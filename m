Return-Path: <linux-kernel+bounces-873433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07A4C13ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3833B806A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88E92D595A;
	Tue, 28 Oct 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCcYzrY2"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19A2D877B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644970; cv=none; b=uFABMpXFLMVQ+Ln3hJSpTyxLuf6/Eut7id5U+RPrGXXx42G9ucfikrhqZmtLe9O7s52sn6N5obMU/hIb6VRu82WA1LFjpNLn2sCCUDUvd/Ckq2Q3kPtFlTqhe9lOyw6BQigcY6rtmP96lFeDcWD2TRxgydYHy//rPyu8NphHsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644970; c=relaxed/simple;
	bh=HlMVZKXiPzGH3vjUzbrHUAJiXnZQ1VgM01/9Vdi26wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRcgomu7TCdsmloDkVl0C9xcXX/RXRRGOjUgnwGlBYNNNS9zgL5oFRFZAHtHF/vJF+krjt1zsrZjiPpumvahMfCyTH//QmFbPRF1CeH1/Q+B5TjyrZbKL5w4FD77D8bo/Vg0I/kNsTW7O5MgtYmAP1ysvG/QBDuXaO0hH4CAXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pCcYzrY2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-378d50e1c82so57555681fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761644966; x=1762249766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ag4RpPho5sULiazlXNA0y7JZ5ZSjgCMfktnwGNRil1A=;
        b=pCcYzrY2BYJR/brdApua61ctxRqWSAtLKy3QXsOAwyXt6gAjlXZArmM88EkobQa6sn
         O/h+w3tIXuSDdQVv5EJgw/KaUNd2eFU+bFdU5A5CobIs+vBCn4MkWOftPYDo0ATAFGbs
         Q9JnuXugAICH1u4ajaNbW4dB2dMj+W6ulmKzsUswUB3Tje6bGLT8sGSNmi8qO3hLg9xV
         ChF5ax57sraW5kAUmxycnwwXcsbiRLD+LiYwyFQDr6jKvosHoFUqABoX4zHHUmg37QUn
         PtXQqti6AfUDhbcavqjH1YVYVfQw6sLAiY6W0u1+OyPZK7VRlZhCLqb9y9W8lXE3M05S
         m+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644966; x=1762249766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ag4RpPho5sULiazlXNA0y7JZ5ZSjgCMfktnwGNRil1A=;
        b=sy+ZoLUlsV6BkxS8jGevfAwJACZ8MCsfUmDLBu6DfB2gyUWiVKER0v5oCftxrsL8xn
         PpmBz72MNFqXobQfgpcQrb0etB7iKsX55Hfabiru4+xr9kE3Jhs60B0dJyoM1FK9OVfR
         Qsb18j09cEu0ixAXI42GH9yKuAFBq49Sab+yv3ksEfhvn39V8LJwTmZXP7wl0SRG9mZl
         MT6Dn6OxE2li64FwQyQWGNzMfW2SPqlktxt7ttiWYjav6BGxMpPWsLeP0b0GBCAr+M6j
         09L2ola7H+QbiPwURrHkgLieXM05SQja/vqQTik6Twd1b6IyXIezuvIedgf82EyB6kB4
         KnFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEuKAxp7mE8/ZhqivvRZdaVRzUhfk3RvcsutfrM0wqACCTabBiTofD/4t6nnRy+d5la3cgYVYN1nAUgUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2scA98iLQuEKLxBs8FNzl22WJdgR/rEONGR0YXhIpvbBLTyU
	6YE4iMTwTF5wrwCYjs5kcTlenVAdb0AlWJdNthTczUhqejhD2PrxnoAswxWTSBeqbW6p2RJQ8/R
	t7jPguk+T3QW4Z9sY09GR5G4VG7l/b3BxY/GP8YyoFw==
X-Gm-Gg: ASbGncsVhA5HI/cb12Ud93hDtjraFzvY5xHEARsvPSzRw26VSUb+Sd+cTZxbIJNPwcY
	y2+NVXo3P/oO1vZaiFxqH64toRTyuUgYVNpQy0POnwfWQKj51dLRJSLaWz1EatMKYkJV9vCsspf
	mMV+eQbMuQFf4+iLGpk4HeJG86S4501ZBI2IoY1T/mfWkGA2HdqxA/2Dh7onarDCpAyN/M/wQd4
	/5CxmUoq/vmgZm70WR9DOffvKboB5dfFEVk+WOx9F+nT3KDEHufHFn8+1Jg
X-Google-Smtp-Source: AGHT+IHLnbuiTb17yCojPLzTfDTPTsYUvPEhpjzcDmPys9LqE0Vi78zD5Ee5nCAV3CJXyUjTEm0Hy+cMggR26FQ+KH8=
X-Received: by 2002:a05:651c:254e:20b0:378:e8d1:117 with SMTP id
 38308e7fff4ca-379076aa8b7mr6977841fa.11.1761644966332; Tue, 28 Oct 2025
 02:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028061345.3885632-1-gary.yang@cixtech.com>
In-Reply-To: <20251028061345.3885632-1-gary.yang@cixtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Oct 2025 10:49:15 +0100
X-Gm-Features: AWmQ_bmvf5Ur8d5O7ggkU8MMUQcJO6q9gUJ2SA5XsMYb2o4yAVo6574UPA09OxU
Message-ID: <CACRpkdYdQa4=4JvBWJcRv0X_A0PnkQpZQQ8NTPzF0ntdt9qX=A@mail.gmail.com>
Subject: Re: [PATCH] Pinctrl: core: export pinctrl_provide_dummies() to fix
 build error
To: Gary Yang <gary.yang@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	cix-kernel-upstream@cixtech.com, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:13=E2=80=AFAM Gary Yang <gary.yang@cixtech.com> w=
rote:

> If a pinctrl driver uses pinctrl_provide_dummies() interface, and
>
> is built as a module, then an error occur as follow:
>
> ERROR: modpost: "pinctrl_provide_dummies" [drivers/pinctrl/cix/pinctrl-sk=
y1-base.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> make[1]: *** [/home/gary/workspace/upstream/kernel_upstream/Makefile:1960=
: modpost] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>
> Signed-off-by: Gary Yang <gary.yang@cixtech.com>

I just deleted the call to pinctrl_provide_dummies() from the SKY1
driver instead, because I didn't understand it.

But if you need it, put it in a series with this patch based on the latest
devel and an explanation why it is needed.

The only other driver that use it is the Renesas driver and it uses
it like this:

        /* Enable dummy states for those platforms without pinctrl support =
*/
        if (!of_have_populated_dt())
                pinctrl_provide_dummies();

I don't understand why you would need this? The SKY1 has pinctrl
support after this patch I think and since the arch code in arm64
requires DT, it seems fine. But maybe this is for ACPI boots or
something like that, so you would have this driver but there would
not be any device tree?

Just explain it in a patch and we can add it back.

Yours,
Linus Walleij

