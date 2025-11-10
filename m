Return-Path: <linux-kernel+bounces-892715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A79F7C45AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 076A34E9AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E129A2FFDCC;
	Mon, 10 Nov 2025 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIBxp0e6"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516142FE59D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767239; cv=none; b=Y+omRfgFNW3Mo5rDKAS5eN0TzwvdDjnnvJy33A223sAakpEPOOuxMA+D2HNocLuEj5D5PNFhooLSb8G8twbHU/jLGgZfFXkJUtg5FgFKWfiq/UwoMn85H0BKYpfOYR0dH+ohHXloKfPrHrm8GcFAzUrQ9eG9XDAWse41UrcJN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767239; c=relaxed/simple;
	bh=sHVZhmkSKysZDap3sF25xrcfxQaq5BwaaVGlIsexEw0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tWQpqgnFQE/K44+5rRMrHvKASR4UuC6oyk0ezyCfAI7Kx+/QlflLabQO7rigd+qKr8rwJblpLCjPsVjGBup0zZ5DBYBjJMRPhsJJXugzPuUKbxNW/7QEl7T4hhIoVozDwhS4zO58f8Q657ZZGMRn37rD84jxbVxFAewt73vaFJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIBxp0e6; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b98983baeacso1020614a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762767238; x=1763372038; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hIOQ6rxvxUexWQ4rBYVQFATudRCo9jllmoVsfvKzXaI=;
        b=VIBxp0e6Gf16gPRKVh2sREtXzx1Epi9MkZPA+FOdALT0QeVKMdJ93sTcO+85bGZnG8
         adW0ka4ts5RuC7eApaF876kMTJm0XcU8GTOtszm/6PP/QwOWWs/CjtPFHQ6XMylNP8h9
         SVQL9C3pEfb4dLiAKx6SMrZ4Aj5jr1jbjQLqNHqWLUUI+vSgm2SQJ/6aq2MoeyLaa2+M
         gM8Tv7w7+ejyoDZL1q7YqycAo2/iPIPzah5YM6f0XZBr6GqvoKO1FCEylNS3Wpo7Q/5d
         q9mJopqWSIRDHOPwdrphP0/ekbLDIT6qXtnIo3fNn//p/3GggzvCiCDelT6H+OwW7ZSO
         qwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767238; x=1763372038;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIOQ6rxvxUexWQ4rBYVQFATudRCo9jllmoVsfvKzXaI=;
        b=Liz/ninS3MoOJ2KZguLkQRIJgTiXe9qR80NqrhfvsM65mo51QZSw3oJkRu6lb7C8my
         9US4go8yUfe4FvUCupWLMdQurNkUevDLcZGtT92JzC20y5th01b5zv+0OS1KcWnF6WBB
         9KLN3AtMkpVPyXdDrOfszJqWfr0YLCs5Bz79oFKsx74+SdYj4G3wzRPq/WIKCii1CU4v
         +twbPuGNFfQ3cN9gqiX5XuHD8keJdb6Hu4H7qGyJKzUGHDAypn7KpcTd9TgiqP+bHsp6
         bVND/AdiUjhhmMadCXZ1m0L/Xy9/5LCcv1dKA8YGM4eSBCHBP8kNvO9a+hwrVAcWK9BN
         x4YA==
X-Forwarded-Encrypted: i=1; AJvYcCX5vquCtI0HW933ECanHq7BwJSCUMbSzfoLGXtxzlgvhw7aQ9FlJcd4Zu5eLYN7SOdhg71TTIJ3OwtN98c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2K9CR/0ecvjG/O2kLf4xxoZ9S61xvloEwm6golBnog9aN8UBu
	rkjcLCTGgImyVziKmeuJwNoBpTQ0q3UGbxKiw0hlrcXRA+qwnJttWy1O
X-Gm-Gg: ASbGncs3SD2rIQTVZXMSi323sspSJhKt88WZkb4Z8GtFy55RlWCCehjqUu2wKXyBD0s
	j8rSRWdZN8pCtGrk9nNGSerPIMVU/UQxn3PC7RCJoXjaJ7W9r+waw1txM9dYTsLYexuZ5zIj155
	BSc1BC+DcJmB6LlokIPBRVnpS3p2Re4FFzb9Ou88EUh0azF0okMabH+OnbWmTfLB9C1bjBZxCQT
	ASNQkRQXRkfQfT4qcrPNbwVU6RRDkOB6ckhJ5NbT6O1+2SDIhkkbUaXt/hkxBblwMDkrYRNM8Ga
	pYkon/A+jdDdxO/QmfSCD60QY7vgk8lvtA2geZ6Ab8ej3aS1M//GGS6R/5quXo2EO3L36xD6WoS
	TiVXR+3zmw9heeF5HUuUI7i7YLwdDdbl73DwJo0s8qTA5hULsN9jChACY6zU1RrIwcw+NM/tcgq
	fAlhqmptOoUrV0fTvQH5KYdp111ewJF0ATNVgBjp9b8OFr53gYyX7y3vkBfQ==
X-Google-Smtp-Source: AGHT+IGL8U8AwBZN4pJnMi80e3kUGQSuXjn0pR5txm3KfrC9GE4bH1N0BeBWaOTIzoZFdpcdm+wzMg==
X-Received: by 2002:a17:902:fc8f:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-297e5413468mr96707665ad.7.1762767237567;
        Mon, 10 Nov 2025 01:33:57 -0800 (PST)
Received: from ?IPv6:2401:4900:8fcc:9f81:b4f9:45ad:465b:1f4a? ([2401:4900:8fcc:9f81:b4f9:45ad:465b:1f4a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436c27a999sm3764935a91.4.2025.11.10.01.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:33:56 -0800 (PST)
Message-ID: <feffccdea0085f2a25f699bf80e5e8176ecd4128.camel@gmail.com>
Subject: Re: [PATCH] tee: fix uninitialized pointers with free attr
From: ally heev <allyheev@gmail.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg	
 <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan
 Carpenter	 <dan.carpenter@linaro.org>
Date: Mon, 10 Nov 2025 15:03:51 +0530
In-Reply-To: <CAHUa44GYnZFaZQBNbV0=RSR7r61+ErYdQtEsRObNALz2CwT_Gg@mail.gmail.com>
References: 
	<20251105-aheev-uninitialized-free-attr-tee-v1-1-2e1ee8483bc5@gmail.com>
	 <CAHUa44GYnZFaZQBNbV0=RSR7r61+ErYdQtEsRObNALz2CwT_Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-10 at 09:57 +0100, Jens Wiklander wrote:
[..]
> > diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> > index ac134452cc9cfd384c28d41547545f2c5748d86c..8b7b4decddd8d1811dc0a7c=
c46a4a4fbada45526 100644
> > --- a/drivers/tee/qcomtee/call.c
> > +++ b/drivers/tee/qcomtee/call.c
> > @@ -645,12 +645,13 @@ static void qcomtee_get_version(struct tee_device=
 *teedev,
> >  static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32=
 id,
> >                                           u32 *version)
> >  {
> > -       struct qcomtee_object_invoke_ctx *oic __free(kfree);
> >         struct qcomtee_object *client_env, *service;
> >         struct qcomtee_arg u[3] =3D { 0 };
> >         int result;
> >=20
> > -       oic =3D qcomtee_object_invoke_ctx_alloc(ctx);
> > +       struct qcomtee_object_invoke_ctx *oic __free(kfree) =3D
> > +               qcomtee_object_invoke_ctx_alloc(ctx);
>=20
> Can we zero-initialize oic at its original location instead? Doing it
> here looks messy.
>=20
> Thanks,
> Jens
>=20
> > +
> >         if (!oic)
> >                 return;
> >=20
> >=20
> > ---
> > base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
> > change-id: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2
> >=20
> > Best regards,
> > --
> > Ally Heev <allyheev@gmail.com>
> >=20

Thanks, will fix it

Regards,
ALly

