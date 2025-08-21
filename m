Return-Path: <linux-kernel+bounces-779172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3296B2EFF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E657A8295
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2697C283695;
	Thu, 21 Aug 2025 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eLYNpbY/"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BFB2E7F2A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762286; cv=none; b=IeRntCCz0wj+fwbVaXXXAy2aVSEIDzoOOHaMxhCFAk930Va+Sr3l81czu2Ulb87fx4O7dTwtfpo9H/54r/AZNB9w0+UA8qvU84fHJ5vlRfykpv619d8r6siAd3qU8JYHxRpWgqM1Yep/d7NtsshPOshoNXvDoViemh2m9hyS4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762286; c=relaxed/simple;
	bh=vdHEyzhc86TX9tbtznEx/85Id6VeMcRJL4nwZLlDITA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kj6IliYTLj5oJ1YUyfZeHQvpINlxROD2p1ZeGjj4hFJMV71k8dCUVog3zs/LzZG2OYcdETyEO5/MErLHaFcDrskOLOgzVlte+NDdIKuaOZAeosBrup6xL5zaNq7SpWqkr1bXLhT3Jj/RUFtMFNfzvfaNGqi61sANVxvUVxouYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eLYNpbY/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-33548abffdcso4085751fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755762282; x=1756367082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaaBqUCEqJX8gBaeo+0oUHbgJbmtScd0fm8qFrnpKZs=;
        b=eLYNpbY/JncK4WvSg+cU0OofTvBwO14cUFosgYB95pUPLztd968taCCz8BMBqWdkQM
         q2ANYOWaP8aeMI4bF+vSFs2Gg5Lgwr/kQ7XOjjPGW0BsGCbbdpZEV2g6Bc9NdrngQaIz
         Ll+6l+wm1A/dyT8ZDlO1a5+jk0rrRwULnOVCyyqsJkibTNehKMeH5pQ5KDhcTDkjVFQS
         hcUJUzhhj89SFXFipeMFMSVTjJpImetAn8q/4hbtWNQAiEGUCqlHPwQDS6DZxOItMsk8
         5/RTJviq3kUlIvvXUgktm5+RIDRkgVpjKPoO6rbj7tuM3DS6ClB4RWK80GJYE2hBz/Ns
         3rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755762283; x=1756367083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaaBqUCEqJX8gBaeo+0oUHbgJbmtScd0fm8qFrnpKZs=;
        b=OuFvho9/2Ew/HqIJJ8heiGCSLRwnr0Br0+iF3tx5N6TLm/lrJ1cM4l3gXby9YEbe/G
         3Loq6IJxnUgTrNkLlK+/Dof9D7cWfz9GYaZ4Tpmu8EooIcJhGUDRkPHPVeP3gRPCxoUE
         xqKoEdxAHSaHfo2+yner0vi1oCw7M59cFk5yS/BYy48K2n/zjjCG48kiRBuuPtq40K9n
         72sFqv+AO1UmSFOZoQzqm7Xia0bcMSmr0V7K4hoicqAFTaZKdmUQO51/mojvitiIyTDH
         +pNMP6ivxMqUrjCB9X/q6P+WvS9gQ2EOfyr+EuF7gHIB901s6+Ca13NLujPvqLURyHji
         /0fw==
X-Gm-Message-State: AOJu0Ywt6eWZ3Whpt1KIhUgeLyHQ3D9Vdj0TZocZCGvEBDV2v+oTOQ/K
	EKE88c7JYCmL9heIivNu6DMXF0Brg0uF48WWAKGRPNPblQDX5rAyiEEV/xP7r/rawEr3JReL6m+
	+BtCvloVLVbovnkjx0Yps3EYNz8JlTQ4t2RmBTHfYlQ==
X-Gm-Gg: ASbGncvgQeezEHyWwKsY3nQa9+JskbhpIaenp5WkrgSPAErpfwxRBJfZV8ObAmkddxw
	U0c8aQ4mz2+eEMXT6TavymivPXBpPXndl3T/Ft4+d3BAxniAW4AY3H7brFl1ar5keBgfeAAgN3K
	uNl40mQCk6/U+luGENSGkTuu0EUEAXukgR7RyAzaBxkYD+/XSWO29jhgQpMLBOHscogBtLvJERW
	qpUkCE8S0s8lYvUGZthe3Bxsy3/9IkwDVvIiSUn
X-Google-Smtp-Source: AGHT+IFA5sHCL63vzY7cqM+GaSEj0WZVkyRn2xaUCErjwOg1A0ozD02QtL70YiwzLFD2WvwyLPMEUrqF4yi74FcOx4Y=
X-Received: by 2002:a05:651c:23c8:20b0:333:ac42:8d6a with SMTP id
 38308e7fff4ca-33549e3daa8mr3598311fa.3.1755762282568; Thu, 21 Aug 2025
 00:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815094510.52360-1-marco.crivellari@suse.com>
 <aJ92vqBchsh-h-0z@slm.duckdns.org> <CAAofZF5KtD3zdrNcGekt4=sZCAAG6_a3Pz99NzfhX3iMkqLdyw@mail.gmail.com>
 <aKZYutvp4BtcqFJT@slm.duckdns.org>
In-Reply-To: <aKZYutvp4BtcqFJT@slm.duckdns.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 21 Aug 2025 09:44:31 +0200
X-Gm-Features: Ac12FXzUDjQ8b1jO_hE5V6z2mQ1_z-g8yN5st2g4G0tEyc6gPWsmiyfoZh5bW3o
Message-ID: <CAAofZF4+GsCwF=1uFYeyxtPn5aenCFU2ztyGcsYJL_DTvHZsHw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Workqueue: replace system wq and change
 alloc_workqueue callers
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> NVM, if Christian can apply for all filesystems, that's better.
>
> > And I guess it would be the same for drivers, eg drivers/net/
>
> I think net should be fine with wider scope patches, actually. It's mostl=
y
> about laying things out for respective subsys maintainers so that it's
> easier for them to take actions.

Perfect, thank you!

Anyhow, I think the easiest one is MM. From the 2 patches in the
series, 1 were only comments changes (the new wq name), and the other
had small code changs..

Thank you!

On Thu, Aug 21, 2025 at 1:22=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Aug 19, 2025 at 10:41:01AM +0200, Marco Crivellari wrote:
> > I'm not sure I have clearly understood what you mean here:
> >
> > > e.g. Network flows through the same tree but different
> > > filesystems often have their own trees.
> >
> > With this, you mean also distinguish between e.g.  fs/ext4/  fs/etx2/
> > and fs/btrfs/ etc?
> > So if it is the case, in the example above, it means 3 different series=
.
> > Prefixed like this, I imagine: "workqueue: btrfs: ....".
>
> NVM, if Christian can apply for all filesystems, that's better.
>
> > And I guess it would be the same for drivers, eg drivers/net/
>
> I think net should be fine with wider scope patches, actually. It's mostl=
y
> about laying things out for respective subsys maintainers so that it's
> easier for them to take actions.
>
> Thanks.
>
> --
> tejun



--=20

Marco Crivellari

L3 Support Engineer, Technology & Product




marco.crivellari@suse.com

