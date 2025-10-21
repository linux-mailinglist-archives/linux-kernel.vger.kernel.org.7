Return-Path: <linux-kernel+bounces-862411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0CABF5370
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6A83A611C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EDD302CD5;
	Tue, 21 Oct 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VMo/3tAP"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C872EC54E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035132; cv=none; b=iPnFXeSup+sQmiUZQIOBPa4fHcvPvA55NLg3VgyGa1Q0LDpDwYfUYvUEdpwE2LcaBK+q/nBu+Z7QZmh6PfR2chNkzyjR03VPgOKkAJKLb4VGWcnaVl/4bfoXXIx7GaVT5i2Wyf4/JCj0NnucP4mEqcc1f9rqrY98Z3AiIEwA4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035132; c=relaxed/simple;
	bh=CDOX/Q0SciF/sAPfd5jrTqH0lpHfF0elP4tDo34UTmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sj5bWIMqifPBP+raVrX0xQh9rUoHyBk13fCfNv9qolhKjW6cvenUjozmyb0WtTQvRu4+MT+l1Lkzjj2wymJURfa6eoAHq+OSQGIDbSEy3Kps36pZ+QH5/4p9jxrsg7aQb6v7TF8jf4uo+yiSDwq0c8By35DaY7MttzmdPZiLZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VMo/3tAP; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37634d352dfso66317581fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761035129; x=1761639929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8L2F3ZRh6fW8RZGFdedUhnU7a9bMMQNWC8eaAEnGh4U=;
        b=VMo/3tAP6USTssallSInBg/Sa1LRioToEouW+zy70B6VtBtrrHdm1IOxFiRrcob8P3
         /lKmzGs5OQLGRvyJ2Pm1a3IfhHkJFfpTEXrMUWmVh0Phs9XcrdZ9gzkA/DE28E7etfQ7
         WLvmfzi/2X7c5U6eVZKKnZ/BNKKNa+XkMpVOnlJRdB+Sr4RyPILIWyNGKgsbSlYLerD8
         mfkYE/pU6MyrCEyekAg+fxrkUJJeobT5kkJBwV9UfZAM2JoFpgQcbi5e9TAVB3eokWjh
         emgc0AdQ9Brut9eLKW0hEPf5lxpqPedPBb2EHaodtjAzE51er+3nNDmgVMoDDtCcCdm8
         wzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035129; x=1761639929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8L2F3ZRh6fW8RZGFdedUhnU7a9bMMQNWC8eaAEnGh4U=;
        b=CPOyZoTzLcmAIwOsyPSYesrX2bCh62Jngbk1MCaTPtOUn3JEV9cmy2/jJRCxYdKh2W
         rZ++wSokMkFPFlQ3a9Ci0yJL2qN6ZR+DwdWn5rpCddhwxrMyD5l7tdd4lNMLLIGNaXwi
         v97cIrDB695tfq++ehGlKu1CEpICag6xg5+S7XQ+OWUmSc4b8YMJgQivHXXZ1tLOSfUh
         +ayPIM1yC5BA702LIAqfazuJwXBeT06j6qqO9BPcqzKEXZwBUgHggQ1z3P/2iBPq4WTX
         wBsCzeNd2rwbXcP1vyZh+IJ8k89MTr70z0ghxHAPsNuuBGsQUhmUI6aWmToZH/s1LAvZ
         rElg==
X-Gm-Message-State: AOJu0YyV/opE8CLZvs1mBNHLJWKkatYcDGdfKP1LjZ3Mepv+xVW4aHAw
	pDidwmA21Delo2aVu7ZtkwzOLstIEfEfPJsCcjx5KxO7EaJHpgwkHwkbbKupZNfbts3OO+gLtas
	Z1qbbo8YK3DmKwA+6rbUtlsFuW4ph8s23xM6pIBBXrw==
X-Gm-Gg: ASbGncvLORI698lkRou0PqAyNjW7d7qcmOyYbChx1zhXa4ARJ00KpuNsgwJ70jN7SXh
	jz2INkSYkYSikDhS9Nwi3jJCrJRSymsxEDmcEZgOIlKcOW35Yl1LlM0NWJBPdo6ERb6nci6TJvJ
	gbGqusXQR6TUnA4RB9ghmLjzKZyh/jY3gAFaEqTWdKJdfjy8Ck68EyQiFKwnE9EO6bHrl2XzuuA
	/vutUhf7unBMBezXpIvSZWp2rjLJlEHiks5UJEObg7OxCPMNVVKAuby2kY/SU7X3MbDxarDIppK
	ZV301SwI5iauF0WrDn9KPyyTBvL4TAsPHo5Z108=
X-Google-Smtp-Source: AGHT+IHXwT/xNzUPN0bqIpQnLcE/96hcau6Gg+Y66ThzilB47Bpq6EUW/f9z6HeQw52ISlIUQnzWWfBWa7aI3wFgiK8=
X-Received: by 2002:a05:651c:983:b0:376:45a3:27c4 with SMTP id
 38308e7fff4ca-3779782c00bmr48618191fa.5.1761035128705; Tue, 21 Oct 2025
 01:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926083841.74621-1-marco.crivellari@suse.com>
 <20250926083841.74621-3-marco.crivellari@suse.com> <7c8363c38c4352181ebde6b27b6d8fe69c60429f.camel@sipsolutions.net>
In-Reply-To: <7c8363c38c4352181ebde6b27b6d8fe69c60429f.camel@sipsolutions.net>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 21 Oct 2025 10:25:15 +0200
X-Gm-Features: AS18NWDyx8qVK6r7mfmkx-izjawGx9uFzulIzN-LcHUeTPVQt9XiCdqbcImcGGg
Message-ID: <CAAofZF6uieKF463KnikeTWqKxjaaZ0SX8t5CpAsFWTkj8r1G7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: WQ_PERCPU added to alloc_workqueue users
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Mon, Oct 20, 2025 at 4:21=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> Hi,
>
> So I don't know if I really need to tell you this, but generally the
> subject should be _imperative_, not describing what you did after the
> fact (i.e. "add WQ_PERCPU to ..." rather than "added ...")

Aha, thanks for the hint.

> > All existing users have been updated accordingly.
>
> Surely this is not _all_ existing users? :)

Yeah :-)

> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> > ---
> >  drivers/net/wireless/ath/ath6kl/usb.c         | 2 +-
> >  drivers/net/wireless/quantenna/qtnfmac/core.c | 3 ++-
> >  drivers/net/wireless/realtek/rtlwifi/base.c   | 2 +-
> >  drivers/net/wireless/realtek/rtw88/usb.c      | 3 ++-
> >  drivers/net/wireless/silabs/wfx/main.c        | 2 +-
> >  drivers/net/wireless/st/cw1200/bh.c           | 4 ++--
>
> These have different maintainers, please split up accordingly.

Sure, I will do it, like I did for the others.

> >  6 files changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wirele=
ss/ath/ath6kl/usb.c
> > index 38bb501fc553..bfb21725d779 100644
> > --- a/drivers/net/wireless/ath/ath6kl/usb.c
> > +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> > @@ -637,7 +637,7 @@ static struct ath6kl_usb *ath6kl_usb_create(struct =
usb_interface *interface)
> >       ar_usb =3D kzalloc(sizeof(struct ath6kl_usb), GFP_KERNEL);
> >       if (ar_usb =3D=3D NULL)
> >               return NULL;
> > -     ar_usb->wq =3D alloc_workqueue("ath6kl_wq", 0, 0);
> > +     ar_usb->wq =3D alloc_workqueue("ath6kl_wq", WQ_PERCPU, 0);
> >       if (!ar_usb->wq) {
> >               kfree(ar_usb);
>
> I'd also think that WQ_PERCPU doesn't actually make sense for any of
> these instances, but for those that still have an active maintainer I'll
> defer to them, of course.

Thanks for the pointer!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

