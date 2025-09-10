Return-Path: <linux-kernel+bounces-811068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DC8B523DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0631BC6B94
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC3D30F935;
	Wed, 10 Sep 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lUCMaj25"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D355B2D1926
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757541071; cv=none; b=ec4GuGZgldtj4psJE7qT8UaaHIHJr2hw7CKKS8s58YI6v4UsXfT2qqq/VS5vwd4So7A902OKETxEG17x3a6l3rCGCqWEgJBDoI6UMFueLjm66+6c6M0XxXyiKOWaBlTcsOILWuuB/XnIV0Bzbucd+Iti++hH9XXc+FpXFkCVz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757541071; c=relaxed/simple;
	bh=o95v/+Gki1KYTrPyXr39Fj4FLKk98Q6CUu2/j+SJkls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+5N0XrweFz9RIJO3zqVpY6VIad1+quvF6IiIXf3QN7Kk7bv4EvL4k3LFGNXc/ogreY89o8JDgW5H9M3zqh4N2jMtrkKpH/NLQ1pRLPoBXfYHqNdi68it4VhNbvqkBVqWPSYxMTjQHp+FVTxE0gmj2rfJHIqcj0SVqKgV6YEeYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lUCMaj25; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f72452a8eso8442e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757541068; x=1758145868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o95v/+Gki1KYTrPyXr39Fj4FLKk98Q6CUu2/j+SJkls=;
        b=lUCMaj25tQhXcGFY9D49JqORZtpH3UmMIfCSRICie6AeBAXTG2ucmQFL5J3kyTOjMr
         GqN5k6s7s7bdpSWx8c5oCiSYU4Sbc6GEHlF78Pe3p50GUHvC+ALN45xW6bZJEHXwEuSE
         DhTp8AdigzSmAzdS+VKPE6zo0Ynywrra60+YIEPpRqYg1kOILa9FD9TyqWYFyoGcCUPy
         qCvARQTTJ5mBd1ShV7sIUoEvzSfQmvPWDKIo6crDJFWaZRY5aexfXHkLJY3PBoZH24IG
         WAhkw9c+ntdcIANOIQdwSG/ZX2iqKWzt1TVpVB46ZLdEs4/H45yI9hN0YG9B8Uk/njKI
         5Mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757541068; x=1758145868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o95v/+Gki1KYTrPyXr39Fj4FLKk98Q6CUu2/j+SJkls=;
        b=xT4ZJwfXRZpgs2JJ+6YnxETE+nnjvymhwXdzWTNANHu0G/8kJ32ganpx2/2wEnRLFc
         QrMP0qrUEi3k5EntXatJI9GKyzNkkA6PNKeLMpbYbECw6NSSKt17l8zl7+TrAktuSPk+
         kJft6zT2kDWuz8mBmZ3t4A76UNWrjrOdd/AQOc2AQCi0rw0yS9JUwrupjR/7e5aArivN
         IvB8d92mWUj7Aont9/jTB6SAJDWocbRP1sz4vlWxsQDqwhXmmvBZHmIU7ljYu7WY60Vg
         EAr03Jc2QQUMr/LhKEZbKosQktoswqL24rrxes/Iq742lkT9r9M2lf7sJSn74sbQSvxU
         JR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3sd2mTubEkHz56uNTTzyifmdK5k5TlVghMsvVXyQ1gIvQCVBARqoBbqFx5+8Bcr3K7vAIx3IMjriPNsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR7OSJjEkFyta9OtYn1EY4FEpa2P8SY7PrurawRpSqDnCqFcdp
	w3Wr/QnUVR9qvL2R2Bk69rH48UHbT8lhwUBkPsteYrOqnYi53MJ87HWC8SAhUEF1fGdZvdTqFtO
	qIfnmBmqBn6d5M+c/6X4q3AUXUmG6ohIhNeIkF25QOUmdCU6RD2fiXG8qvg==
X-Gm-Gg: ASbGnctBjHS3ZogleYOkKr1cV9fj2Lp491lPNlmQpkDUoavLiJ52vhdQacyzUIrw2SM
	uLHq0P0D2ZF4RW8tmtM1n243EnjLdyDjYxcaN3ja9hOOXU5yveyDen88qkOjG4JcyB7Ot4RfiQW
	vQvJ9HSEolucYEadre3Vvd3aQBdCKlkCS/+SIRqPloc5q0tVJGKBlO5d6SILyBLMjddej5DT/YF
	Gjrtls=
X-Google-Smtp-Source: AGHT+IEJlIdE5osVu7CFRz1B+V23ahz3lLGypCenTLhiP4qfmKZkgsEstnnmYSdvYj0hsFA8e+enqb/RwpOwngd12h8=
X-Received: by 2002:a2e:a54b:0:b0:337:9e3b:895f with SMTP id
 38308e7fff4ca-33b43430959mr48580621fa.0.1757541068033; Wed, 10 Sep 2025
 14:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827024222.588082-1-gary.yang@cixtech.com>
 <20250827024222.588082-3-gary.yang@cixtech.com> <CACRpkdaX2VPAb+vihZ5BEAsGy+jNUdQ8q+3c3Q78uWmqZYeu=g@mail.gmail.com>
 <PUZPR06MB58879640C5849ABA55EF0C34EF0FA@PUZPR06MB5887.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB58879640C5849ABA55EF0C34EF0FA@PUZPR06MB5887.apcprd06.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 10 Sep 2025 23:50:57 +0200
X-Gm-Features: Ac12FXwBa9ZOv5SOk4OUSUTF518ns1CoJ9PMufbvw3-fq3nVHK7Qp4WDBqsYJOQ
Message-ID: <CACRpkdZzqRo9LRkF8=BSDANweWd0ccWtu5_nznDUn_FS6Fb0BQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: Add cix,sky1-pinctrl
To: Gary Yang <gary.yang@cixtech.com>
Cc: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gary!

On Tue, Sep 9, 2025 at 5:30=E2=80=AFAM Gary Yang <gary.yang@cixtech.com> wr=
ote:

> First share a good news with you. It's that We have verified the new sche=
me pass on Radax O6 board.

That's great!

> We just have a question before submit new patchs. As you know, there are =
some macros defines in dts/dtsi file.
>
> Where should these defines locate? We found these defines locate in inclu=
de/dt-bindings/pinctrl/
>
> mt7623-pinfunc.h on MT7623 platform. We don't find arch/arm64/boot/dts/*/=
* -pinmux-props.dtsi.
>
> What's your suggestion? Please kindly remind me if I misunderstand and mi=
ss anything.

Yes these are old habits from Mediatek platforms which are bad.

Since they are not bindings, just convenience defines, I would suggest you =
move
the stuff from
include/dt-bindings/pinctrl/pads-sky1.h

Into
arch/arm64/boot/dts/cix/pads-sky1[.h|.dtsi]

I am not aware that using .h or .dtsi has any semantic difference,
maybe the DT experts can tell. Maybe use pads-sky1.h to be on
the safe side.

Yours,
Linus Walleij

