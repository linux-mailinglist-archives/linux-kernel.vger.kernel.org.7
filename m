Return-Path: <linux-kernel+bounces-812505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36185B538FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40EA6B60922
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE72435CEA2;
	Thu, 11 Sep 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlHoMuDq"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712363570DD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607667; cv=none; b=gJSnYKAml9QcfvM2FL/ew0xLu/YJq7kJ9vRYw/OjAA9h8giBYPzISIXrWcs9nNVwwikrFAkFVNNY7JuTmCYx4sv4zI4/1DpdKmxPwLAixJu+cQXAUlubQY6d4ud7V3XtyIOJ+VPf1mg3/H4vQoJ1Z6buv+03eZokzomW3qliUmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607667; c=relaxed/simple;
	bh=xylUB0Rc4c6OgDv9OHVYrt3+LG83H7TowALVvxEYyFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hetdg3xDsTs5ghry/jhhTCXk/5nsdulUJYYS3c4VWrxKtRbpIAEdGOzD4rk/YzJ0n699m6GAXvsmt1uyyXaD3fTVJ5VkTf+RZfbG7LzAmWnbY0NDTOJVR3KNfJOYpkXo7cB2YpFz2AsMYkGh2Bg4aB0eoZ+Hu2lv/lQAUwKUQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlHoMuDq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b9853e630so8618905e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757607664; x=1758212464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FDisvDBiIy/KslMUdjYzdNmjgvVdihkRNeWbLiPYzM=;
        b=TlHoMuDqXljCIT/j1fYdFAv+srZzJcfFe7XrDmCgfwnplvVw1rLMYUrGWWZGjeiTPm
         wt7mVmD3QseXu/NbUlKkgT2Yliq9VVPkqV5wB5QTLDSutbUKB+t0K5tgR4fklyqug5F0
         uui4Mlhn78zNbjwnOqp01S4JDpM6zIUbjt1TzThdaMQS5sfWhKl8GyxlnjMC9XBgtKcs
         u+16pURnD/OMa43m8CsXTZE3sCE7P7+FrO4FCG4T7KlZNjrdmdqCv1jSlKa925VAcrR8
         hBSL5GnINwLawx7GHlUZ9gTeN6BUa0YK/AMO1Lgt8Nmr7xzhOKvh0wHuu/8sYTmiz1JM
         nP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757607664; x=1758212464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FDisvDBiIy/KslMUdjYzdNmjgvVdihkRNeWbLiPYzM=;
        b=i9MFLLqI/QWUiA60Yr+7OzNN2YFMrC4nI8tDsLNTFbbmLZlgyeBEfYm1S+8bnEsIfF
         K8CpuzLMqb66LpgAGWVQk5DQeKagKb2bhr1Dkp9P4+8LM6BnP84vD098pnCIeofYp9ZF
         ACHI2sMHPqVaVTfmOXkLJE6AJN1hQC9lgpO4h7yR6Yi19C4XoxznWLfuuHpCodGisM2F
         hm7RyYKJcQkciBPt2wh/rFCZr6FMCqEHQz8YdF8NOY3qsfJIRCkryTEGlfHMK8qQihsa
         xIwx/X95+upr/ldVEjJA78wbFocqmf9nB3Mq6im79rEWCuumIK57Ur9RfX327HKmDTwI
         6oFg==
X-Forwarded-Encrypted: i=1; AJvYcCVT87TiOEL5rxjeS69TICodIw5OAO7gNNzImunGBoPKSWN9xWqDf4qP7I5+51t2Lt8zgvtnoGQV1QNr3Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdK5qWwZeqUL1S903uemaSuLGe4F7qqGxoevydvUc3WbXfJ44u
	JyBv7+OIMYOf40pAIj1PGQai3UphxoGXK87PuL3OgSaw+aZM+D6tX9WzlEY9iRtfu1XOKnqkxRb
	Iacilwq+Cpg3xMyx2gXR4f0DEs50dMsc=
X-Gm-Gg: ASbGncuKZZcRP6bRyIr24cYiHZ+jhH3Pl2qyXwy8oxKw6tbwaAVFJoHpFPnT33gAove
	qvTozRioUWVYCe14BxpbmlMmJ7Iv2NY88Mwuk6DdHk/Jd4Mqx6EsY1RgB/P/ca+32sbgPGTFwkF
	6zjPeyiK0K+hBEFDckC8wh3AnwkefyJFAl1g1Cd5x3rltg3YRxEwkISPuNI9KgA0ZgSWS6dMvzb
	pGzdUW1vjd3+NdqQK4=
X-Google-Smtp-Source: AGHT+IEDBVdK5maGi6tjqvhg+QJyFP96pMLfaZDihKOWpBcWXhhNS0z2CKzjyZk6w4tKay6WVukI753YnJu1NEM7QYs=
X-Received: by 2002:a5d:5d05:0:b0:3d2:9cbf:5b73 with SMTP id
 ffacd0b85a97d-3e636d8fb29mr15720485f8f.6.1757607663373; Thu, 11 Sep 2025
 09:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909074958.92704-1-clamor95@gmail.com> <20250909074958.92704-3-clamor95@gmail.com>
 <2tmlhaymx73frvv3qv7qvaagzwvh3cepringiyvhsmqrdgfy5i@fvspt74y6nj7>
In-Reply-To: <2tmlhaymx73frvv3qv7qvaagzwvh3cepringiyvhsmqrdgfy5i@fvspt74y6nj7>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 11 Sep 2025 19:20:51 +0300
X-Gm-Features: AS18NWAVp107axZCb6wtJXjw2YDOpvtl2OIKPBZAVHxfMbzOvuoCwQiLPFAse6Y
Message-ID: <CAPVz0n0WjOaBrn=stpwjhT-fZ-K7_YQHDUnuKUccZaqLJGXJ-A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ARM: tegra: add device-tree for Xiaomi Mi Pad (A0101)
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <treding@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 11 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 19:00 Thie=
rry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Sep 09, 2025 at 10:49:58AM +0300, Svyatoslav Ryhel wrote:
> [...]
> > diff --git a/arch/arm/boot/dts/nvidia/tegra124-xiaomi-mocha.dts b/arch/=
arm/boot/dts/nvidia/tegra124-xiaomi-mocha.dts
> [...]
> > +     host1x@50000000 {
> > +             dsia: dsi@54300000 {
> > +                     status =3D "okay";
> > +
> > +                     avdd-dsi-csi-supply =3D <&avdd_dsi_csi>;
> > +                     nvidia,ganged-mode =3D <&dsib>;
> > +
> > +                     panel@0 {
> > +                             compatible =3D "sharp,lq079l1sx01";
> > +                             reg =3D <0>;
>
> Looks like there are no bindings for this panel and I don't see any
> patches anywhere that add them. Am I looking in the wrong places?
>

It seems that there are no archive yet with panel patch, this is a
schema part from patchwork
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202509090738=
31.91881-2-clamor95@gmail.com/

I would ask you to NOT pick the tree commit yet, I have a few
improvements for it and would like to send v2. Meanwhile, bindings
related with this tree should be approved.

> Thierry

