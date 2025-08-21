Return-Path: <linux-kernel+bounces-779324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C30DAB2F27B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD087AD937
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F82EA49E;
	Thu, 21 Aug 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fNekpbkQ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF292EA498
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765645; cv=none; b=J4Puy0gIf2AERZ2gPccHqb8gi4eOom4N2u2+qgrQk+BzfUP9EeuEgfBfJjAfTeELnLPIA9yLcyi7aVnI0uHm/Ryy6h6OtmpqaGj5EEW4lyDrl+EwV3EBm3OMudW3kZwPFz3yZktLe9ZY8Ca/ETeD8tMf33VVsJFKeDUngJwz2JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765645; c=relaxed/simple;
	bh=7aK4/SU1Ct1ml2JjaK30nU4voYerLKo+nKBBvu21qzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StArRTBkTQZA3JzCwDPrvFJPwyFq7L1H41YWT9IjlKt+p0WofTyYwSEOyeHvd8VI70R6+eBuPJO/2j8PNZ2NROzmQgg4mgyqE//VwJK7T/K1NTauqyaDTeYXO+mljuzHL4wtjK6D6+roc2dOYnujUlBvhyiJmYPzCwzcA5sJ31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fNekpbkQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55e041f6da0so551630e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755765641; x=1756370441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aK4/SU1Ct1ml2JjaK30nU4voYerLKo+nKBBvu21qzs=;
        b=fNekpbkQEswZSRy+HpqFCpgFME+DtSf1+CWf0gog0xhyASnCIDC0PCFve8hb5i9VEO
         X+F8NrkQj2BTFynVdUpaPX9soblZh7HbqxNcinGaEx5kh5LDsiCJmAurEG1aFImhly7e
         31ZK3xQg+dUyQmlSn37YwY8uw7XeUh3Qx3VUl266Rird7pnZPTt6mwV1rP65jIkpGmEf
         ret39wqY1zfZH1nGoWPVbRYcSFuumqXKFNGQa/3a6T0F+CIXys2Tg/TMAG7C9H/hNYws
         bTZwPL9LCg3NAM1ISV3N5tnSqNmf30oVifE7bCB6InEWKjNaCPRtM3lR19dXA2Xy+vWG
         oTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765641; x=1756370441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aK4/SU1Ct1ml2JjaK30nU4voYerLKo+nKBBvu21qzs=;
        b=R7gO9aLYBhLYLMFe9jOj5KHTdgw5x/gsjHASUxWBUByAJeh2RASwEa1JLeBc4uPevk
         GSlvFsHBG5O7TbOcLxbFXI060HhtzXX6ay8ug//GZPuf3VJzpMyCqm4JMOkWrw3T/ezr
         gFpNd/R6MIzjiyEbIEXMwqCWC67DBWjW5azzQW55BJF4nmMmZQvlkQKOEfgf7wmU7+Zo
         WurLQFTnZQoNUV9OfnvwEQjT69VD762/7Cp5O+ibMbTmp2yduEObRXJZ0eo+j9MEv46f
         tD0yUBMSKp+S86IiuZpaJJWwsOk8ElrrDE53Kxw5jIdD9ZFFxcxF1WQmPdiORI+sEBcR
         8tzA==
X-Forwarded-Encrypted: i=1; AJvYcCVgPtsyNAl1g8RBe4V6BVIVtOT8syX7+WsB0ZHJXJhZfaMgfMPOpuopRUXjejo+eWQXO5IBlJrp3RVe5iE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsijf1V1WgpTk81AYNuyjcM9bKVwjpL4xvTLbjfG0vA4NXBXwN
	PfJiurE2KlubsiOsIAKZX2i2v3tfDSf7lBP/NODj5xh/dpPu/1fAeXSpytX881pOFWa9Vtl9hV0
	HsOR0W6HZrKihKH2OigawtxavvgZE5/kC9+HWZMGU6A==
X-Gm-Gg: ASbGnct7Jr/CCMoGnn9EsuUK40N7r4X28fprX2UwRU6fnDoXEkIhvf3jbY9rO9VSK6p
	Z4nAXYycKFZjjVYjfonZp67+nGkJ/uFIjtVstGJz0B8wQu5UQB4hUDpU3j7GMoNEAcxhtE73PlV
	Y68e5Inuo0SQye/INkNymTKNXV9lcEMUxUViUacBiDdMn87z3iWZU+xdcNnLrDCQULWsLYPwbo7
	X+tf9IWUZi0ax7LcL9l55HUyP++kTQrOTcX9t5a
X-Google-Smtp-Source: AGHT+IGgkgUVrYJh6cowLH/Xf85rezoYs0gPmYvYPm2kVgw5F3I7DKXeEtyDDjY4aMK/wF347JSTD21kdGX08a9avRo=
X-Received: by 2002:a05:6512:405b:b0:55e:64f:c10b with SMTP id
 2adb3069b0e04-55e0d57be7fmr635522e87.43.1755765641291; Thu, 21 Aug 2025
 01:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815094715.54121-1-marco.crivellari@suse.com>
 <20250819-maden-beteuern-82c84504d0b3@brauner> <aKZZCrE7IxtQz8kG@slm.duckdns.org>
In-Reply-To: <aKZZCrE7IxtQz8kG@slm.duckdns.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 21 Aug 2025 10:40:30 +0200
X-Gm-Features: Ac12FXwtUbJSE-4GZ8lMu1Pn8yfjCHJKqnSEQMiF1BToSDIc6ZD-kGe87ijkcds
Message-ID: <CAAofZF4SKz8UDmWuaiVkNVw5NYf0ZfDacdcOxSFYUNOyJ0=-KA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Workqueue: fs: replace use of system_wq and add
 WQ_PERCPU to alloc_workqueue users
To: Tejun Heo <tj@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Tejun and Christian,

> I believe all the prerequisites were already in -rc1 and you should be ab=
le
> to apply the series without pulling anything else. Marco, please correct =
me
> if I'm mistaken.

Yes the prerequisites are in rc1.

But there are changes introduced in
https://lore.kernel.org/all/20250815094510.52360-4-marco.crivellari@suse.co=
m/
("Workqueue: WQ_PERCPU added to all the remaining users") that in my
opinion should be present as well when this series and the others are
merged.

For example, there are changes in __alloc_workqueue(), and also
changes inside queue_work() (include/kernel/workqueue.h) that were
added only in the "core" patches / series.

About queue_work() and the other functions, changes are made by
("Workqueue: replace use of system_unbound_wq with system_dfl_wq") and
the related patch (about system_percpu_wq): it is mostly about add a
pr_warn_once() if the old wq is used, and redirect on the new one.

Btw: in this fs branch I only have the prerequisites and this series,
and I can compile and boot.

Thank you!


On Thu, Aug 21, 2025 at 1:23=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Aug 19, 2025 at 01:23:26PM +0200, Christian Brauner wrote:
> > > If you agree with these changes, one option is pull the preparation c=
hanges from
> > > Tejun's wq branch [1].
> >
> > I'll take it through the vfs-6.18.workqueue branch.
> > Can I just pull the series from the list so we have all the lore links
> > and the cover letter?
>
> I believe all the prerequisites were already in -rc1 and you should be ab=
le
> to apply the series without pulling anything else. Marco, please correct =
me
> if I'm mistaken.
>
> Thanks.
>
> --
> tejun



--=20

Marco Crivellari

L3 Support Engineer, Technology & Product




marco.crivellari@suse.com

