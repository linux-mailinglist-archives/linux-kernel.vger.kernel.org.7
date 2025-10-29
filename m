Return-Path: <linux-kernel+bounces-875964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE8FC1A525
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7DCE4FCB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D530035A945;
	Wed, 29 Oct 2025 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdTfVIXh"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699B33F8C5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740586; cv=none; b=is8uakT0ksVsTdcj7FDqN7Abc/wCi7qcW7gpyXuY0GCnWMwKJaJGYFFSIKa8V6agrlOpMl2Yqa7NO09lO6hG2I/3yN8mCCCQC/9LOPdW1n0U14x871A5RnGh5uHTKVH41DLdrrUKQajFndD06rs8sT8xQAtGAcQGTQUjp2RO+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740586; c=relaxed/simple;
	bh=lMz9fVEHjNsR89opwTxfGLHpbSSbTkwW22XDxfNJNo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQYhRMS2jsZ6MbslU5MUgwAaDJ/tcRHKKTyKk566WXq2UYcNzha9MqADrbf3ajHv3GPdzizW2khGpaposwkIi/0OLbdvh3+iGnR0Sfen3vywAtAFUfAePGS+l5UWKtcaqH1tsVFe0Ut3vRJcH8GIQVqtansymqVLydPw8oBhI58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdTfVIXh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c09141cabso10708054a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761740581; x=1762345381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0c/4hWZsozl7YTWr0GTKUdnk9cs1fYSN3DX9TuRcw8=;
        b=QdTfVIXh9/dOsJGVosuYXyu2OI4ULunmyzx9bU4iudMY1LHGpxZH9hzJrIOvg0isvQ
         tks0nuDAITBPssvR+rSCsFu4HSc2JnCjz2zZpDNnylnQwZS9GuRVLT/ifyOsIv0pxxGs
         Vu+1xNdZN1K4cgR5tL+ouhkUMNx+eJyc3s5pX/HkWVkcYuEwp2KrRqUj/3QfuJF3kUvo
         cr/5tb7szhacJAkneL1ckmZKUFNPK1LdDed8RSJo2LhYYYj5dK8vzHqGZR24C3eILIli
         XnUYXGRax6amNgFhkjo0Xnk62aVRIV9T9Fr9og2SfsjvCk7LqZvvSYEmEosSxL8LUiuI
         Q1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740581; x=1762345381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0c/4hWZsozl7YTWr0GTKUdnk9cs1fYSN3DX9TuRcw8=;
        b=qJLOO8xzNLcnsXQamAVNOYp940qTDqTitqvBAVpVVUf+XmDQ8Pku45rMQVwPoEklUi
         c4nYDpe4iBe9gUfaiufKMBefuT/iCYtMLwOS8KrcYhg2sQmQ29kc5ujVdwSTlZmkboKo
         NfWBmG/61XZC7Tg7Ul2hK/IGVCOBe9MYhUdjTd8iJoyWAirHTDWyVk0dmEItFdi6mAC/
         VA7WUqZ5NMbRhrd5TvTSIMSrmIdqcRFXrwVsc9BM5R0KGJc8b0wSKvcI60C4v7q5Epic
         V9RSNiSU2CjmF0ZrUbDQgnDufb43zc6uoMWi1WBuo5anqw1aQBy+x1Z51Vk202hrBpox
         eMiA==
X-Forwarded-Encrypted: i=1; AJvYcCWyFyH20i3KSZbAzTzD6AxIFsU2Wpe6lDwS8QjySIndQzI5V+5IFSBDQ0cLTPTpq+auPBCzYkSkhbG8mPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJuHQJ+zGabOHJhJhlvAw7bKoPirdJxwjNrnz6sxgV7glBrQ16
	qVynxEnREmREMaxqiWW/lZ5Cma1/jrJ/ZdKX2vneIQOb3TVRluzbujdeHUX/fNGGs4tAyz3rbOU
	D9j9RWE7/4b35tn34Fn8oKiair5bhYNXo9GKlCI0XHwZ5
X-Gm-Gg: ASbGnct2BWFUPviMhoz5Q3xs/aWs+R0BhJohW9tEJOtVySJmMOm2Qt3FjsKz6kQCRhg
	+RUaqklJxRBi6j0aoWvsLNrrTVrhUA/AuW1ibbva29KLpYxN/qJWiRlw/vrJsYw8VXulqhQOdiY
	ejEUOxvLZrI/3mdR/Zhph/laufB4JhIirCtdeIaak5FXZ2YYx8QCwnIq5P6BGCATwCf4/QZwX+K
	7nK4CltIj6A9HRuOKl5X+f6+scnwPLWoGDNxuYPmAQhqrteWQcSHGfMG28SP+4=
X-Google-Smtp-Source: AGHT+IFHLKb7GuMaTant0mZZh+7DkoNItPLMFom70+IZl/TSaLwjrPzARyq58A9cf3m49Eb6OHGyh8pSiSaoLoPR9ug=
X-Received: by 2002:a17:906:6a0e:b0:b45:1063:fb62 with SMTP id
 a640c23a62f3a-b703d342998mr257605866b.24.1761740580026; Wed, 29 Oct 2025
 05:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANypQFZ8KO=eUe7YPC+XdtjOAvdVyRnpFk_V3839ixCbdUNsGA@mail.gmail.com>
 <20251029110651.25c4936d@kmaincent-XPS-13-7390>
In-Reply-To: <20251029110651.25c4936d@kmaincent-XPS-13-7390>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Wed, 29 Oct 2025 20:22:23 +0800
X-Gm-Features: AWmQ_bkoWlg1YTPn_cPJZ6nI1pu6U1-lm4Q2dEOkydz0FKu0JfF4g7H6BwfQWow
Message-ID: <CANypQFZhFdSZdEXjEysET58DWYik-8bMVRP4Nqvz=1WB53BrfQ@mail.gmail.com>
Subject: Re: [Linux Kernel Bug] KASAN: null-ptr-deref Read in generic_hwtstamp_ioctl_lower
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, linux-kernel@vger.kernel.org, sdf@fomichev.me, 
	syzkaller@googlegroups.com, Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kory,

Thank you for the suggestions!

I will prepare a patch and submit it shortly :)

Best regards,
Jiaming Zhang

Kory Maincent <kory.maincent@bootlin.com> =E4=BA=8E2025=E5=B9=B410=E6=9C=88=
29=E6=97=A5=E5=91=A8=E4=B8=89 18:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Jiaming,
>
> +Vlad
>
> On Wed, 29 Oct 2025 16:45:37 +0800
> Jiaming Zhang <r772577952@gmail.com> wrote:
>
> > Dear Linux kernel developers and maintainers,
> >
> > We are writing to report a null pointer dereference bug discovered in
> > the net subsystem. This bug is reproducible on the latest version
> > (v6.18-rc3, commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa).
> >
> > The root cause is in tsconfig_prepare_data(), where a local
> > kernel_hwtstamp_config struct (cfg) is initialized using {}, setting
> > all its members to zero. Consequently, cfg.ifr becomes NULL.
> >
> > cfg is then passed as: tsconfig_prepare_data() ->
> > dev_get_hwtstamp_phylib() -> vlan_hwtstamp_get() (via
> > dev->netdev_ops->ndo_hwtstamp_get) -> generic_hwtstamp_get_lower() ->
> > generic_hwtstamp_ioctl_lower().
> >
> > The function generic_hwtstamp_ioctl_lower() assumes cfg->ifr is a
> > valid pointer and attempts to access cfg->ifr->ifr_ifru. This access
> > dereferences the NULL pointer, triggering the bug.
>
> Thanks for spotting this issue!
>
> In the ideal world we would have all Ethernet driver supporting the
> hwtstamp_get/set NDOs but that not currently the case.
> Vladimir Oltean was working on this but it is not done yet.
> $ git grep SIOCGHWTSTAMP drivers/net/ethernet | wc -l
> 16
>
> > As a potential fix, we can declare a local struct ifreq variable in
> > tsconfig_prepare_data(), zero-initializing it, and then assigning its
> > address to cfg.ifr before calling dev_get_hwtstamp_phylib(). This
> > ensures that functions down the call chain receive a valid pointer.
>
> If we do that we will have legacy IOCTL path inside the Netlink path and =
that's
> not something we want.
> In fact it is possible because the drivers calling
> generic_hwtstamp_get/set_lower functions are already converted to hwtstam=
p NDOs
> therefore the NDO check in tsconfig_prepare_data is not working on these =
case.
>
> IMO the solution is to add a check on the ifr value in the
> generic_hwtstamp_set/get_lower functions like that:
>
> int generic_hwtstamp_set_lower(struct net_device *dev,
>                                struct kernel_hwtstamp_config *kernel_cfg,
>                                struct netlink_ext_ack *extack)
> {
> ...
>
>         /* Netlink path with unconverted lower driver */
>         if (!kernel_cfg->ifr)
>                 return -EOPNOTSUPP;
>
>         /* Legacy path: unconverted lower driver */
>         return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cf=
g);
> }
>
> Regards,
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

