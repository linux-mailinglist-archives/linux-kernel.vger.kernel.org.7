Return-Path: <linux-kernel+bounces-811489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE088B529D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF4E581291
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2672C26C38D;
	Thu, 11 Sep 2025 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BScjYEGi"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EF3329F11
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575660; cv=none; b=Zm8fXyPIyDMVVIU62NuVD080y8UjC2Dz2oGi1hVt5OaQHbWgTCvxwx5Z3G5qx9ofw/xy2uyiE0qK1mz38AFFjCY0pVhyEb1XRvqkp3qR7hAtq5NBv9lYLLruiDsT2nagfTQ0DgjAkgDr7TN+uMAN1XkhLZJrxlHgaywh2TGjElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575660; c=relaxed/simple;
	bh=WCXFlTq4/NdVl1ou3si6JVfNN5hHGcyPApo3youXCqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4lNCcuH8GLNJQQZkPil7gSL+eBC46MW6eDJXq6KjeGXYjE2+GXgf4tLN9+OMbYgs6ZTgwDc9qvooXHSVV0wbCZnai+TyoSEjwQKWbD3iEAzMKshzhYXXAsyoo5ZP+vHw7LwhMwkGB2b8ak6EdCI4gmKkTdUVg23B6ts95e1u1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BScjYEGi; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so530412b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757575658; x=1758180458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IxiYNCciyhdbcX0Wp57UVsdWd/rQlfFnyOYCGJ7WZc=;
        b=BScjYEGiNrH/PjXinklHddSRDwoKMRSd5I8QEQ7f+D/cWFa7P7QiwOkd4+2MY8Uxam
         qFGMcfAlfex+HssTCz4vxZNwxn9rjvkJH2N7MKXdPCGkJ26GGtL/tj2H0ludlXIsdZEZ
         DqVok1to9SIRGvfem2acuNwAPdr7gCfEX2f9ceQCsMvlvBvmLVJ65FbHkiy4fnsD1tSp
         3JZXuyIlJqSM+VYGkXo+97KX8ZTljdk7rk53LVVYoDdEInouWoJiVu6COXn38Y6udJcx
         diqn3XHlmtpbaQR8o0TVjocvr8vyxJLISfD1H0xSbILoRAsQBMsfh4D8fqdD72u//8eV
         yCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757575658; x=1758180458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IxiYNCciyhdbcX0Wp57UVsdWd/rQlfFnyOYCGJ7WZc=;
        b=LCbqdyk62gtzUyLjeqyCFTxRjsUzDCSml83kixxTzn8nmlSkFiBYZzDEdjpqDR0DPR
         drc8d/o7K0QzIdW+qfo9F/KQH8NbOW+h6lEGp+fOmyP3Du1RjDiXY5/cwynRfd0gkd0n
         7dHIFfj3TAu9upzr3WbqdLkbDLVoGP0HQ113fWvt4j4co8uRWa8jcNHQd1W8eHJRGPre
         0VLn3Ju4wTNgIuJ8HwI4pk55KWhze7KLBY+3bid3K+EFg4+J4QrGRLCFtd2dFLPArWqo
         BLVI3WKazdeJlyCf8X+FALOJt5G7WIx1qCO9UHh1NmDM5ZPzYrY9T7wF5KOW/sLM0biU
         JVPA==
X-Forwarded-Encrypted: i=1; AJvYcCWMS7HHtmqMgXN5T8dEBB7AlNhvWVplgTev9Xe+VBFO6QI/9kKI1ceK+e8LpXXCCxBiDS7Pta0T8DWxDQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh/ap+1iT0HyBVN6y2y+Aqh/iUoWx/zut6+dWxAaSF97XlhGoW
	TcdJNPjMX9cWrzad18IcVeOw6FC6bieEuYHmssEgbH1zYnP8JyHusBj5DH000LF9YLXCRCTH2Ey
	uU9wQhA5rY3sOo53hxDOlVbY/PuTk2Aw=
X-Gm-Gg: ASbGncvKzE+WrYp+FXlbdZOI85YLyd4HvVqGNhA01lS2HK8yewSLx5Y+1EOlv7SLZVr
	6a9/Ng5r+DU9vNoEdu7b+Jbj4IQCnxWjmzNozl0GgqHOae4MDF1tASqWYJ8xG04Ldw03XDo40Wt
	ojno8QREyBM3izeztI/sIE72tHQ7p50dBIeeowoAY5kNM0bWI+B7XcT10McQOsu+Wnp5D0BDzp4
	MoUalHfWZ3d8lKXRXnBUBBH7KGcnoA0IZMWk58rrZGvB4B+eFSGdSByy7m5jhvXMNbFNYJgBJ5Y
	nwL9kA==
X-Google-Smtp-Source: AGHT+IEK3FOFAc8CqBrE58Q0X7qAvx6ovvpjHhcP/WLfd4cTYoJu3yF9/cNaQzZZzEySVQZ/WcetUbyqA5DJPZOt0Ts=
X-Received: by 2002:a05:6a21:8906:b0:254:b352:64a9 with SMTP id
 adf61e73a8af0-254b380a9b4mr20835704637.21.1757575658285; Thu, 11 Sep 2025
 00:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910030301.1368372-1-linchengming884@gmail.com>
 <20250910030301.1368372-2-linchengming884@gmail.com> <87wm66d67k.fsf@bootlin.com>
In-Reply-To: <87wm66d67k.fsf@bootlin.com>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Thu, 11 Sep 2025 15:24:35 +0800
X-Gm-Features: Ac12FXxQbMqgBdhf8vRv10u0KG0v6L4LrQmY9Oat7o2VyF5BcMBJZNy0FdPHeho
Message-ID: <CAAyq3SbXiPUjZE7OCAe1=uw4h82bFN7DSU4bLx1dhKe_XFtu=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: spi-nand: Add
 enable-randomizer-otp property
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, tudor.ambarus@linaro.org, mmkurbanov@salutedevices.com, 
	Takahiro.Kuwano@infineon.com, pratyush@kernel.org, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=88=
10=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:10=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hello Cheng Ming,
>
> On 10/09/2025 at 11:02:59 +08, Cheng Ming Lin <linchengming884@gmail.com>=
 wrote:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Add a new boolean property "enable-randomizer-otp" to enable the
> > randomizer feature on supported SPI-NAND devices.
> >
> > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > ---
> >  Documentation/devicetree/bindings/mtd/spi-nand.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Docu=
mentation/devicetree/bindings/mtd/spi-nand.yaml
> > index 77a8727c7..432bc79e9 100644
> > --- a/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> > @@ -21,6 +21,10 @@ properties:
> >      description: Encode the chip-select line on the SPI bus
> >      maxItems: 1
> >
> > +  enable-randomizer-otp:
>
> This is a NAND wide feature, so we should probably add a prefix, such as
> "nand,".
>
> Now, what about this "otp" suffix? Many (if not all) chips have a
> volatile setting for that. About the naming, "otp" often reflects to the
> OTP area, which is not what you imply here, as you want to insist
> (rightfully) on the fact that this feature cannot be disabled.

Yes, my intention is that once the randomizer feature is enabled, it
should not be disabled again. You are correct that this bit does not
belong to the OTP area, but rather to the v2 volatile register. The v2
volatile register has a default value that can be changed through a
special OTP configuration register program operation. Regarding the
"otp" suffix, I will remove it to avoid misunderstanding.

>
> Also, this is a per-chip configuration, while I would have welcomed a
> per-partition configuration. I can easily imagine two cases:
>
> - The boot ROM, for longevity purposes, expects the first blocks
>   containing the bootloader to be scrambled. However the rest of the
>   system does not really care and disables randomization.
>
> - The boot ROM is not capable of de-scrambling, however the rest of the
>   system relies on the (probably) more robust scrambling feature.
>
> In both cases a chip wide variable is not relevant.

The scrambling and descrambling are handled by the NAND flash hardware
itself. Therefore, the boot ROM does not need to support a descrambling
feature.

In the case of Macronix parts, the randomizer is controlled through a
configuration register, and once it is enabled it covers the entire chip
(main and/or spare depending on the randopt bit). There is no hardware
mechanism to enable it only on certain ranges.

>
> The fact that it is a one-time feature makes it even harder to fit into
> something generic.
>

This isn't a true one-time programming feature. Its default value can be
changed through a specific procedure.

Please refer to page 29 and page 51 of the datasheet for specific
procedure and details.
Link: https://www.mxic.com.tw/Lists/Datasheet/Attachments/9036/MX35LF4G24AD=
,%203V,%204Gb,%20v1.4.pdf

> How do you think these constraints could fit with your needs? Can you
> please explain again (sorry for the repetition) what Macronix chips have
> the volatile capability and which ones do not?

Macronix chips that support the randomizer feature are V2 type registers.

>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

