Return-Path: <linux-kernel+bounces-817364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB2B58126
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87ED3A6800
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3294A223DFB;
	Mon, 15 Sep 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BraxM08z"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167121146C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951196; cv=none; b=OkaDjARoibfampK3A6Y5NRbj1c4rpPQbYjGgYmkyS5u+GFt2VvaDEAUjgp7hCenNaGmR84oYb9j6TDQDHdpvDyd+lEW2I5VAw16rCcQweSKcu9A7lRlvrvo4Ym1yUb82ZV7L3z9Mvr6u3vY28Nng1e59RuvFYnfRKUsAKLAfBTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951196; c=relaxed/simple;
	bh=vw5V22u1zW3vlZNq8JfLJlKIAtukVQu3dc2tIRfzTS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieCz7MPJjjTvwce0OX+4HgnHQqSXAihtICGFQlj5SYOCvl4NfpprgK5T12SP3RWgmXAEnCtcKgCpYapRwQ21CSizw8rbJNGuVVyC56AhTzowzoBszb8HKW6U3iUHFN4dtTe4zGDLEmNfvHQQu2fMd3rm5iRWjptzCVK7l99MJus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BraxM08z; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-55d9f5d5f4dso719626137.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757951194; x=1758555994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6uUAh+LuL/fPSRTdR/xbny0tMCspdITXSiqvbosN1A=;
        b=BraxM08zeJpDQLAKovmzoRQ5Ccq6Ww8lJS7m8EHQOPiYzJieBEwprRVdx9gWyDHsEz
         hcWoA649eYqL2ZJ14oKzoTNsN+9J8HT56Z5Kk4GClqXOm065irgdWwiEmopGHCQb4uCW
         XiqXgF6G32PhwQXCWw+nAkXpPOpbOZ0OTtg2CgrLpvs+vbBYIUdVH3WSYJ9HDotvtUOx
         vMovhDGCUN53bdiLZrc/OQZCY/i9+28NFTfWEW5ys8MydhAwcx27tdpyKB7hEsKYmvwW
         N8x2/MH7jdkjXgkWUD1VxVaW7drks8shOmw1ddqWznQckJyAM7YP0BqUAUwb41pFher3
         G+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757951194; x=1758555994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6uUAh+LuL/fPSRTdR/xbny0tMCspdITXSiqvbosN1A=;
        b=kxAqN+648ftyd6wiKNOzaPV8JOjhEhzKwhzyt/fL9V3ntJrDkZdsiheFP1EuB/U3ev
         oiSIu1zAhVEcyDBhwXN9iHuF2WicIvFFMWjHDFdLw1doYlRoKBp5mkQylhV2VDd9XkZp
         uwoEd8239b07GdPBZtCbUbht/1bVVbyT/yHxlS39MuAsw9koxF3wWkNiAvzrUDWQu6+S
         IAjSciif2Rhot7zTfLCFJixZI9Upa0nms2fx3xOQoDo6fGYOPmjcmSpUqrA/KEIQLO99
         UFymU5w4zJBEEXdj8Y7nJhX6PjhYR8eRm3VWSZ+JJ+ddtxSkpRIjamUDvZ0W4JfRG4ke
         DCFg==
X-Forwarded-Encrypted: i=1; AJvYcCVgFNrWNt5o625oaucoGkNXZmU7aMDh7lBoWOLEQ1KHX3thmtn5QoZemzBLv420gfOLMBVuYQMixHXOVO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPeoSlTXC2QQw+3fQ9+khdtfr3um5lbJX3NzLkV3kSZ/zUzfaX
	R96zVjXtDRMC9GSdoUrKo+pnIPJQSw5X+gG8vwOuCQkoQmyOe+LdDt971DUDoPYqfmmM7aVcFTq
	qltwvk5w1VTOQFVqZzD6AkfSntw/k8sI=
X-Gm-Gg: ASbGnct/SMWFA5avnaz/HUb8TSqCXFTYgp0nWsnjlXD399GbWdMdq69NciktmVoeeNa
	mESawyKLhUrSHXPC8CoY8zOCdkYh7efeHwWt8g1w4dTUFhGMMoSaMcDNq+odE4lVZyMIGpTGt81
	CNdl8DCHwjCNzD1xlA7Gy3pK3tL6rmrW0/oDf3lPN6gNYJ5CvILJTPzpEslLwFWsBmlv8ErD5qY
	qsAnbc=
X-Google-Smtp-Source: AGHT+IFUJEUTCYa/7AfbKYcfE5drkKeFqkZxqfSfzL9+OIjs2x42tPAl7dXl36fVlFfhVYJxnO21hWH4lbS2NuxFcq0=
X-Received: by 2002:a05:6102:161f:b0:520:c9fc:4cd6 with SMTP id
 ada2fe7eead31-55610dc11bamr3869950137.31.1757951193544; Mon, 15 Sep 2025
 08:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-starqltechn-correct_max77705_nodes-v3-0-4ce9f694ecd9@gmail.com>
 <20250912-starqltechn-correct_max77705_nodes-v3-1-4ce9f694ecd9@gmail.com> <a3ce0aa6-41d3-4ce8-adff-14c767d7f871@oss.qualcomm.com>
In-Reply-To: <a3ce0aa6-41d3-4ce8-adff-14c767d7f871@oss.qualcomm.com>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 15 Sep 2025 18:46:22 +0300
X-Gm-Features: AS18NWDb8W6Zs9BKh7Ic6_AGKZLW7SnWJ6ItgKboSdNTYCSuYztfbS17zB0U_7k
Message-ID: <CABTCjFAO=iLauq37M7LOXOmrgAnPxh210bcoujUsL4zEC3634A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: max77705: add interrupt-controller node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 15 =D1=81=D0=B5=D0=BD=D1=82. 2025=E2=80=AF=D0=B3. =D0=B2 10:4=
9, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>:
>
> > +      The driver implements an interrupt controller for the sub device=
s.
> > +      The interrupt number mapping is as follows
> > +      0 - charger
> > +      1 - topsys
> > +      2 - fuelgauge
> > +      3 - usb type-c management block.
>
> The MFD driver registers one more interrupt, and these don't seem
> to be what you say here:
>
> static const struct regmap_irq max77705_topsys_irqs[] =3D {
>         { .mask =3D MAX77705_SYSTEM_IRQ_BSTEN_INT, },
>         { .mask =3D MAX77705_SYSTEM_IRQ_SYSUVLO_INT, },
>         { .mask =3D MAX77705_SYSTEM_IRQ_SYSOVLO_INT, },
>         { .mask =3D MAX77705_SYSTEM_IRQ_TSHDN_INT, },
>         { .mask =3D MAX77705_SYSTEM_IRQ_TM_INT, },
> };

MAX77705_SYSTEM_IRQ_TM_INT(and others you mentioned) is a part of 'topsys' =
irqs,
which is kinda MFD own irqs. They are unused at the moment.

See also [max77705 rework interrupt patches](https://lkml.org/lkml/2025/8/3=
1/27)

--=20
Best regards and thanks for review,
Dzmitry

