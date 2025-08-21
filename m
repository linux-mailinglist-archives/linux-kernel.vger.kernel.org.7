Return-Path: <linux-kernel+bounces-779168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 926F9B2EFF5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAECE1BA6000
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0E224EA90;
	Thu, 21 Aug 2025 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y+p5wdLO"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B078121FF28
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762077; cv=none; b=m5N6Pq1Cw/5PAZVu/VNGxvny1Qb2VJ0MKpSNfGBqCVSh754Oiq+VrEd1BX3E8pBvDurVz1DJV3fzwsWfPyflZu8tBJjPt1hatzKV98b1dv6eT0YIbIPIncjpVtiZ//nzAIn83eb12DPJ4+dKSPmGz+msjUcOBvtGXS3b+Q5mmH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762077; c=relaxed/simple;
	bh=R5Ttggd32V+MFeSKFELvnP16jw3tNq8ik1dqzw206rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHWj+bDGm3LyYeow4l5vsIyq82RGbgeoLQ+bfReeKje309Pcw2BmDg5OrMKyzm9MrULsA2yuAqYTNvzI51hnfKdjEx/HzhyplTMeTQVaCS4F0fJ53Hm18NFqwr3DweOIArYlhT1ZFXbvvqdktOpX2NLuD11tFk2+244weIGgNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y+p5wdLO; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3354b208913so2244381fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755762070; x=1756366870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti5B2OppIdJ14C+jlxk9QeuB8MZbK9cE5qBq6GJOv6w=;
        b=Y+p5wdLOECckicpForG42AzFiPrhrIbl+H/eZ81teq/1038DdTgPcb/8gUnhrwdS9P
         f60Ybbf4Yri6P43M5cP20g5DoZw70wJjACv8DwEgKtzUAUaiiLNWd4STD9JEytdktv0L
         U9fZ1YlPziA7kwRFsOL7WOvFhGN/9tynX2Hs5sLHBtl/FlrPP3xFE6/nq7Px/9ohUT4r
         PK08sbZmoF6NhE6ovlw3Vff8t8gzmof12c5Yayq7QKVvB/NMeym0flQxMeJwDvCnun7Q
         Z6vNK1RhJnUBoa0uHjBJXF9Oh/scoHeoBehDDhCuOcc2T7zw4Mz6R4idF9zvsCVTNOuf
         lnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755762070; x=1756366870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ti5B2OppIdJ14C+jlxk9QeuB8MZbK9cE5qBq6GJOv6w=;
        b=Yo8pzsTaIX7L3ATDf/YJ0mOQc+Y7dabEeeTeu2CCJXiGwCurNAmPfeMMc0CgQlsFb/
         LL7ZSso9zrJvus5sKwdHtUf7fdGuqIvGkedFeCVSN45t3/A9/R8Weo41AZ19LjZogsKa
         aDLxoyf414wLIFiTPMFB7c14t4KVqxIlXn19bwl7cwP9fJu/WkpnKqqpMCzP54GBfDf8
         cOq1LHwugYjnLOoohBZHEbAl19utlASsxgkuwwyHcceBexnlGTPz0vjzBZGtpaKw8ONs
         F55/XH4yJ3jNbbzkpySj58QMW+i3u/9DSJxZ81vpvgGE8JcOQE7xiSZDIojyMQIEpigC
         LXXA==
X-Gm-Message-State: AOJu0YxS6lM2uHB9ZEkigWxbIfvua7/JWOMqgNAuLLN7LRP4X1juliOU
	/gLBW7VtHqplQfkTfdWNMBmC8Ek69iqocp0/0nClJx0osh1C/+1CUvwo0GQhwAZhrtVv+7LcXKb
	9iV8/I6ljLM7/xf28MwZFCtc4WU59tjdOaTnWXMdCItSFxSk/22AqMko=
X-Gm-Gg: ASbGncvOpFslgmMoSSGkpnf3wRk6kXntMv9rp2MyejxtJsniS9ApkyChBrnfjnyOsFr
	F4dIHrl0pBmHUI4jsQ61viZhGfOb1L5lxvBuIZJuqIpduwlPVhvY2AKjJ17gwcbQFQFrsKm7iPB
	w1Yky9yoDJKMQ7sleyjNjPD3fBnzzQJ/V4apZ/IDTtAnf5dhI1rnWT9UvKNYPE3C7xcYUbzdCX2
	cmcaHSnjEgI9GF9lkEIFVrUm1GyLG1m+8/L5jXSRWn0xkRT/a8=
X-Google-Smtp-Source: AGHT+IFPeGolGP1SHT+UI5FBN+TFk76c10gfNsDmUba4Dqno3VnXTqdsdQqTIRxAN0cNEBF8z0NIIENh9QfuZa/7hHQ=
X-Received: by 2002:a2e:be22:0:b0:332:2c2a:63bf with SMTP id
 38308e7fff4ca-33549f5a800mr5305301fa.20.1755762069623; Thu, 21 Aug 2025
 00:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815094510.52360-1-marco.crivellari@suse.com>
 <aJ92vqBchsh-h-0z@slm.duckdns.org> <CAAofZF5U_fND+te4Sj_+TQPgZH_DDTneN2XLyY7a0niGBjGjaA@mail.gmail.com>
 <aKZYEDYHYs3W2OL0@slm.duckdns.org>
In-Reply-To: <aKZYEDYHYs3W2OL0@slm.duckdns.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 21 Aug 2025 09:40:58 +0200
X-Gm-Features: Ac12FXwwL0dlcW3LF8umxrthiAb0KN6xOhvm9kaXzH64zEK9pDHR4frIyf7zkGE
Message-ID: <CAAofZF7gEeKVWf_i3uCj=QPNpDXmunb30_6MqiXRHbb9wGHKCQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Workqueue: replace system wq and change
 alloc_workqueue callers
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 1:19=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Aug 19, 2025 at 02:28:12PM +0200, Marco Crivellari wrote:
> > Sorry for another email.
> >
> > Another question / observation: I guess maintainers can't just pull
> > the changes and merge for the next release, if the workqueue changes
> > (e.g. changes in queue_work() etc) are not also merged, right?
> >
> > I received a reply here, in the meantime, in "Workqueue: fs: replace
> > use of system_wq and add WQ_PERCPU to alloc_workqueue users"
> > (https://www.spinics.net/lists/kernel/msg5811817.html).
>
> I can prepare a branch that fs can pull but aren't all the prerequisites
> already in the master branch from the last cycle?
>
> Thanks.
>
> --
> tejun

Hello Tejun,

There is still the logic inside "include/linux/workqueue.h", in
queue_delayed_work() / mod_delayed_work() / queue_work().
Just the pr_warn_once() and the workqueue redirection.

These changes are introduced by 2 different patches, based on when the
two new wq(s) are replaced inside the code.

There are also changes inside  __alloc_workqueue(), always in this
series (when WQ_PERCPU is used), because they are the "general" (core)
changes.

If I remember correctly we decided to keep the prerequisites without
any more "logic".
As long as this series is merged before or anyhow in the same rc, I
think there are no problems; right?

Thank you!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product




marco.crivellari@suse.com

