Return-Path: <linux-kernel+bounces-747305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1AFB1323D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33423B36E0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86E524C664;
	Sun, 27 Jul 2025 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ueh8PYut"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1B21578F
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655337; cv=none; b=HjCK358YE3Df9rCNrcXlS/5+4ZWFAq2K7r7+bX9ateUqgybZ/2oOeLhNALgeRVvWquqRGUpO9uUfyLd5Y54A28luB6/NjqyqMhgNdel5KNhLxu4m2fNpoxRqx49WCVhvlbvPKzdPNfuj3ZVW1YR8n+TTsqKqTehgGKYd1VAGCPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655337; c=relaxed/simple;
	bh=7aE55925tcWmGaX7tTb9viX7+snG3Kn2dzQ5QJ3oigY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xi4u9lIL/HM6Dp+Dig6M6C/y6unAEEpkNfvSdVm6KCcbN2cW9N5pbKaCoZrc8S0GfFTasBNdA/QcMo/AaeL/PoqdcU5VTjbD9LhpisDg/SW7/HH29kox1bzMb7JquIYV4GlHz/xxCCU02/RRSOP+yAL2c4citiGVuWsulK3GxIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ueh8PYut; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b321bd36a41so3168910a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753655335; x=1754260135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aE55925tcWmGaX7tTb9viX7+snG3Kn2dzQ5QJ3oigY=;
        b=Ueh8PYut7SFlUsxVY9UuWocPnTEp1FN6SbfUuPmi5SCfHgCJ3mTdy1dNPPZlyU1QhJ
         EBrLjNzi3Q86Wit6axN8j8XJy/XQ3DmybKkw3EiaQL5qGJ/dd7YBIcR4wbhAlFfciG47
         an2RQDKBnIQwLIDYSJ5afvS8Hem84PZuLBvyLISCZk18i9pKeL2RCs9bXLF6edRBYGge
         vlZqxK+IBBBrtckXac3LmsYyUUhkNCyC6/dmjCCwln58ajayrCpyqnnje+RJH56GYF9v
         Pbj5Wdjry6gMR+7aNygO6qvWXYkSuMD3qyuTUVvJnbnpESqYzojbEL9F3GmMiHUoyzSD
         /e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753655335; x=1754260135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aE55925tcWmGaX7tTb9viX7+snG3Kn2dzQ5QJ3oigY=;
        b=ewt4UM89qK26jaigIYqpO96e1JlkXfyvC48F8ESk8SMCKaFqgOlViDeC0w/l45OXHP
         C+EYBpvEtrikk2b28Jor2Gyz333GQ2052HH9BOlnOpNqHm1yPcb+wwKRvFjbAG4yD+f1
         E+NH/RgKEFC8ifwUrDZIJ+mMjDWG5euv+ukhD4NiR35Q/CJbzSfeBd+h0oZmiOPeANMx
         ebNlaOKPMOfiS8gX0Q0ARV3/Cui99osZ3weOg+CJktv+LZXBceu4qU4rhOKPE2rQXEf9
         SJiTf7Yk4zohQmZdZSJGttnSnGdkF85LtbocUmkAequ8hps8auCyuePdHs7Yy1ZdMn74
         RrpA==
X-Forwarded-Encrypted: i=1; AJvYcCU7aghymi9A3+k8UXUPfmys3UFOJ6cpPlAmIHPfZSZRmUqid++jdcgdCIWjcYItTpymm/t69AiOTcO/+N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJRAkYSVP042lOvMitCPVjP/hqew1eBk17HIzqBCbN8YQtjTM
	Yr+wSU+jxYvcSxDA8yzF3u0qrN9auqkXXnEWvkrSinJB1TwaosRW8CcfhHN2jRQ9bL2PKqz6Li3
	NpdeEFjd4q9+hQmovzPZmrHr/c3Qa/xk=
X-Gm-Gg: ASbGncvmIK3ZkiRsl7P7sLEmhR9qFD5ZBQoxAmTX8wkTue1E168eIhbY1DwisKhcbaV
	ok3yEhLNokc6/oXnFE4tkQYjfj/3Gx/mz4G3mj6sCMpxPn1pkGV/tzWn/p/8q/K0X4+U70K+BGn
	WHRk9KnIWFQmJ+NjIkalHf4ZQTsNHBPmj5RDnteP7sfTj87BmdiMIdmHaut3HeIVm3p5Ti/NrzW
	RR6hQ==
X-Google-Smtp-Source: AGHT+IFB+UC79G6GOvpYCOqLMKe5c6XQOXyyyhKfZRzw/xMYi0ZwUgQjJFrdTLPc9goYRCJRriQdvkUAynVP85BQUE0=
X-Received: by 2002:a17:90b:584b:b0:311:e305:4e97 with SMTP id
 98e67ed59e1d1-31e77a01261mr14286891a91.19.1753655334777; Sun, 27 Jul 2025
 15:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507112131.3686966-1-tomeu@tomeuvizoso.net>
 <20250508145624.4154317-1-tomeu@tomeuvizoso.net> <a18f214ab0487a1c562f9e2f7f66ab1345925177.camel@pengutronix.de>
 <CAAObsKDwVB7w0mK3qkJJ-x3sOVxbcM5pbjxJk-106baaiwM=dg@mail.gmail.com>
In-Reply-To: <CAAObsKDwVB7w0mK3qkJJ-x3sOVxbcM5pbjxJk-106baaiwM=dg@mail.gmail.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 28 Jul 2025 00:28:42 +0200
X-Gm-Features: Ac12FXxXmcLRHhwJZhvSwh_E4TOWBWwI2_AjoaRN2XLAJ0SAZOxjnsj19GW09HQ
Message-ID: <CAH9NwWfMCYKFF6Z+XiV9=4BANeyPk6bgNV_8FYM0cGwXuyDSxw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/etnaviv: Fix flush sequence logic
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Russell King <linux+etnaviv@armlinux.org.uk>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>, 
	=?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> > > We should be comparing the last submitted sequence number with that o=
f
> > > the address space we may be switching to.
> > >
> > This isn't the relevant change here though: if we switch the address
> > space, the comparison is moot, as we do a full flush on AS switch
> > anyway. The relevant change is that with the old code we would record
> > the flush sequence of the AS we switch away from as the current flush
> > sequence, so we might miss a necessary flush on the next submission if
> > that one doesn't require a AS switch, but would only flush based on
> > sequence mismatch.
>
> Ah, you are right.
>
> > Mind if I rewrite the commit message along those lines while applying?
>

Now that v6.16 has been tagged, I was wondering why this patch didn=E2=80=
=99t make
it into this release. From the timeline, it seemed like there was
enough time for it
to be included, so I=E2=80=99m just trying to understand if it was overlook=
ed
or deferred
for a reason.

I also haven=E2=80=99t seen any recent activity at
https://git.pengutronix.de/cgit/lst/linux/, which
made me unsure about the current status of patch queue handling.

--=20
Thanks
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

