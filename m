Return-Path: <linux-kernel+bounces-789172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F0EB391E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8751C980026
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED01226AA91;
	Thu, 28 Aug 2025 02:56:14 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2926A088;
	Thu, 28 Aug 2025 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349774; cv=none; b=AdOiaRhWdHDrLujllm3pdEzqiOV8UdenqFr1lpKSX4IW/tFkWNepEsF/L4TxGGsFUw0tad2Y+xv5uh/FrfJL0m4HSBRaY+doJyWiPiPQamhqaoNVVIwISxHfqlqxmWy8jq/Af16sar9lzwBKSQ7mzP4vj3ESUQKCi/GbvKYhTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349774; c=relaxed/simple;
	bh=3Q9iEVOUz1gJksPvlCugtYW8aE3sRLkDtX7rKdL7enw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lv6S8beo2V88Jto9pkAQtibzSItsMnDM9LdtLdwGmuTVB9jCyDzShrTRTyn9vKek/0RvQREjO1oqn5Bbh38s7okLiOR31H9cGjzKhvNFOS9meh/C9oOa3SZe0p8WpsMY3JPxQtGyAdxSxaX4HoqeBkuUVz/xEQayQ4NenflfKHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afebe21a1c0so66533366b.1;
        Wed, 27 Aug 2025 19:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756349771; x=1756954571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/sG5Ec7Hlcd6BQNqJwLka5sDq9zcWIANhRNknbwVaY=;
        b=NVjLCKkAO2cG6XBG55NEvsPjaeLXZH40cF0qfywAyHpNPiMQrvZ0uS8lL/Wfsvbgob
         Io0bYnqxFuKXCEyNXa/O0IgJCGJAU//Yy2kzShh09TAXwLWaR6nuceIdeo0pn5oYQwFU
         UlY27aZPmP6ybgx8vNMJcX9sgT1IQ802Mzj7SdZ6JTp9WvzXGo1vt7VNAFtfaJTn5Gop
         q0BWUUvidIt6TKmtp9pxKUrHEr9eOn1RetA3pl/prS6o6KV+c+LpFOSkyJYeL/rk9fF5
         iw7xuzEkZpGjHcMY4j71z6kthjzkV9a1Kkmlnk/WpTXqM0ghpg+7Jp4LeEl3fvlwgQfW
         p4vw==
X-Forwarded-Encrypted: i=1; AJvYcCV0VN4DWE0UoKLbaHpL4zM5pPdTRYx3ezm2vnMYbz6yuUKBlwLWCRQnb13i+f5NEFNY4PeEj644SaIebxuX@vger.kernel.org, AJvYcCW439OM7WnrZkbPXxWBWfSb3bTzRsk/a6OtuHoNdRIqXb8HxFFdMMDJStNNh5r6PWue4TmUxg5GMKxM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmxb2SRsIfP44KTDBWfVMX54eTp8ibV6eCOjNZ5CTxkqhOD8T7
	chfP09L1cersWIr1OvaWejlTbgx9Ta0eozHerOuWw7s5ConRdI3heLmSb6+l6y4+ee8=
X-Gm-Gg: ASbGncvQXi875XHMgls4+li+7dwnfliB0UMjI0EoHbYbjNohgJXAgzgLXyjgzzm21vj
	5X/uK500IiJQX9iC0aH4sonAOAOSuhqZpmAEKVEkAE+daXDj3hWXBr2U+KMlPesqxlcgeIbtxFC
	aRZBZkIx3guxJETJvoOCEyVLs/NbmWutuEzWbNADDF/DL/uVObHSkvDTOPjK39ScL76Eup5T8FD
	Bl8V5OTbLd8SctiP1aXetWVlHfp4Imgg/AK0Vxc2Z9g9CwyhiNPy82A8JF6ZLA+qan8zoRpBijD
	qlROSUz7Ea0s9FAGvv5nrzWPOoZl0tzGhUYXv6WAIqnir5qTSjkzUueMhWcAytVe3JpRd2gCBgX
	qUK2+xOMDnSPSQNTjkzdsEjPCKz8YZZRVlhgpwx8v8TjphU/I4ac68vY01PH0Ry9pN17N9oSJDR
	FzVHTbhXO6
X-Google-Smtp-Source: AGHT+IGVAo13RrRQvBt+hgRc1uaRfzs1rbCwvTCix81bOLcIrNP4esz/j8NwwaazEdwmc8FPeLF5/g==
X-Received: by 2002:a17:907:3f9a:b0:afe:d21f:7af0 with SMTP id a640c23a62f3a-afed21f7e3cmr265415066b.14.1756349770831;
        Wed, 27 Aug 2025 19:56:10 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8d03f981sm662259266b.60.2025.08.27.19.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 19:56:10 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afebe21a1c0so66531566b.1;
        Wed, 27 Aug 2025 19:56:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQV4n2gH82qyO2Ru8IapVrUaJ9ifdj9c0230o3hP/YkatMPv2JGZIdAFr/lRd45ucCuw0eF5mpF59YXVy3@vger.kernel.org, AJvYcCXyQHn8ivPTv6A+4Utc+PtCeCvlx8+1qOsYsncCYTEP/KZ66ziNwspKRdRUY+T6YpOjNcrV7yYZCepY@vger.kernel.org
X-Received: by 2002:a17:907:7f26:b0:afe:ea46:e808 with SMTP id
 a640c23a62f3a-afeea4747aemr33407866b.47.1756349770127; Wed, 27 Aug 2025
 19:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823-apple-dt-sync-6-17-v2-0-6dc0daeb4786@jannau.net>
In-Reply-To: <20250823-apple-dt-sync-6-17-v2-0-6dc0daeb4786@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 27 Aug 2025 22:55:33 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9WSJ_eyuKfZejCNCdN5g-V-7_VSW=NY=Sxc4jCJfDcJA@mail.gmail.com>
X-Gm-Features: Ac12FXybLNW3dXUB-nTs8fEB4lNe9ODNBHdvueiT250V7fxKSinYXBh99Kd-hDc
Message-ID: <CAEg-Je9WSJ_eyuKfZejCNCdN5g-V-7_VSW=NY=Sxc4jCJfDcJA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Apple device tree sync from downstream kernel
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, Hector Martin <marcan@marcan.st>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 5:49=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> This series pulls changes from the downstream device trees which are
> supported in upstream kernel.
> Most importantly it fixes the PCIe description for a specific iMac model
> (iMac M1, 2 USB-C ports, 2021). This is worked around in the downstream
> kernel by not disabling the port. In preparation for submitting M2
> Pro/Max/Ultra devices trees I investigated the issue on the similarly
> affected M2 Pro Mac mini and fixed it this way.
> It completes the Wlan/BT device nodes for t600x based devices and adds
> the missing 15-inch Macbook Air (M2, 2023).
>
> Checkpatch emits following warnings:
>
> WARNING: DT compatible string vendor "pci14e4" appears un-documented --
> check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
>
> Which I chose to ignore. `vendor-prefixes.yaml` prefixes contains no
> other mapping for PCI vendor code and the list of ignored prefixes
> forbids extending it. Both options feel wrong though. "pci${vendor}" is
> clearly a vendor prefix but duplicating the PCI vendor data base feels
> wrong. `vendor-prefixes.yaml` currently does not contain and PCI vendor
> aliases.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Changes in v2:
> - fixed commit subject of PATCH 2/5
> - correct Macbook Pro (15-inch, M2) to Macbook Air
> - added Neal's and Sven's Rb: tags
> - Link to v1: https://lore.kernel.org/r/20250813-apple-dt-sync-6-17-v1-0-=
209f15d10aa0@jannau.net
>
> ---
> Hector Martin (2):
>       arm64: dts: apple: t600x: Add missing WiFi properties
>       arm64: dts: apple: t600x: Add bluetooth device nodes
>
> Janne Grunau (3):
>       arm64: dts: apple: t8103-j457: Fix PCIe ethernet iommu-map
>       dt-bindings: arm: apple: Add t8112 j415 compatible
>       arm64: dts: apple: Add devicetreee for t8112-j415
>
>  Documentation/devicetree/bindings/arm/apple.yaml |  2 +
>  arch/arm64/boot/dts/apple/Makefile               |  1 +
>  arch/arm64/boot/dts/apple/t6000-j314s.dts        |  8 +++
>  arch/arm64/boot/dts/apple/t6000-j316s.dts        |  8 +++
>  arch/arm64/boot/dts/apple/t6001-j314c.dts        |  8 +++
>  arch/arm64/boot/dts/apple/t6001-j316c.dts        |  8 +++
>  arch/arm64/boot/dts/apple/t6001-j375c.dts        |  8 +++
>  arch/arm64/boot/dts/apple/t6002-j375d.dts        |  8 +++
>  arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi   | 10 +++
>  arch/arm64/boot/dts/apple/t600x-j375.dtsi        | 10 +++
>  arch/arm64/boot/dts/apple/t8103-j457.dts         | 12 +++-
>  arch/arm64/boot/dts/apple/t8112-j415.dts         | 80 ++++++++++++++++++=
++++++
>  12 files changed, 161 insertions(+), 2 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250813-apple-dt-sync-6-17-d1fc1c89f7ca
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

