Return-Path: <linux-kernel+bounces-819960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F1B7D6D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3DA1BC1041
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 04:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9725119ADBA;
	Wed, 17 Sep 2025 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3ALYzd+"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090B62F363B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082161; cv=none; b=MrhB4l99BAij4DxB4BVbZ4BkXqhmYmM0A8sxBduI5bAyqFUa6oJnlrooQ8xDArJ+taARn6QITrib2rAtYaGJQGNyGcagvLXJjm7gM+v9theQ4FmBxHI7sijYSkchb1Ffnht3kJKdiNqnuIcx+WFa+4scDIH83STubsUY5Q3P4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082161; c=relaxed/simple;
	bh=2bvp36KmupZNMGpps/OrSOzUI8/fL5Jg26VYq8D4SCQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rigkoQxg2yHnsymEhHTu+wmG8ZDdisYwmJnOeHC3L9BnRjZ0C2rQsYDOXVPIEchp8ccfyIrlMVVZnt7mj1ace148r0EAtqGhpX9tYNiRr2voVm0wBwMrgn4ZWlEpFffRbaNDX7DVo8esHVfXlZM3Ch7GPLSSid9amd2koPIcuC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3ALYzd+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f7a34fb35so5683373e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758082158; x=1758686958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q/acXbEK2et4Won7Kyik166aN82Qa/n/alnFQdbkk5E=;
        b=j3ALYzd+Jcb9vvj7AyWTJ00G8UlU9HrlgBa4J8x/3solwanhEssZRyKJYc3nBeF/+a
         8jQAY8PGqU2hBhpSHGtC6ip19/zFTANpoxOLkHHNSMAmHMPB1YwnZa9nWkEYKhqrWszo
         nzdIMlj7w0m89rnVhWkqCdxCRXqaMRg9oQn7Vpl9twvScDN2AfYCDFQd62Y5l8mrZBAW
         99qW2dEDM5nq/RP/pEpGiOLtsg4kwoo6cnevr6wBwKVlukIyt/A/4TGB+FPDUN2JrkBi
         U7fGRSCNXlY1Qan4oKsbLrCo8AKwSy05uUBmX75SP2hOW+KFa4NFSPSzB2kJ3eM4vLo1
         soFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758082158; x=1758686958;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/acXbEK2et4Won7Kyik166aN82Qa/n/alnFQdbkk5E=;
        b=TFGDe0AVbjtxhquNIaZQtW62Gzh1PRqlRSAoEjUO+D/0oQU2SMd54/Yu9GwECD5Ixy
         jiQCdcEQ8O1WJ79fzQ693ENSnM3rJni43aVgrluGNSWTVrWvk64d254ENiz/rqo2TrJo
         HzVl7NS7Nqj1K0/IPZYh1Kw0W9dJi/6Y+sz0Eu/g8E9Kq2d8RRu6uJ9m2OUfidR8T/4U
         z93Aue34KLtCLNq5zUoS29eTvgCUPxPwfWHLyJ3eUd5fKy3POdqq/sGvf0lm/QssWJBL
         AhKx/X+giAIrpF91MuC/f9pDfz12toSAYJcxRD1IVayBdjFTPDQ2t9lXKCWWHx5gdANc
         0G6w==
X-Forwarded-Encrypted: i=1; AJvYcCX/47393NWpHk2prHgre7mCRV2M1ucP5o7LKcdToXa06ya1jNPqwPLo85M5JKJ160wN8WGm7ZA2NxKvcPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIRu5lc50oeZrN9oRRCgxijtbFh8051Q8NZZerOfRjM9LXWPO3
	HB9vPhUM0jXmUp3Rl/0cDxHTWxAh6Q8HNugZ4WD/FtVizs9r/Vqw41hM
X-Gm-Gg: ASbGncsz8d8SS48PNxb/X5vPXeCyWQG/D7T9502W4c421waYLLX8u3BC6I5GSgHZzdM
	hs3vmSMa5oTIX3SS9w01p2WzmwUzl2pytLUlcPpng/9KY3f9TOt/ic9q2HmsRGuIZwv3G4gf6x+
	APfpTkzqep7S9HqX57Y/viTvzE1Bt6oQwm2SfFM4tzDY4NH6FZZKznjPKodkSM0+1aYisC6ybZB
	NUzKCsHyLH+g0WYbVFGtv56IhCt4TJ0h8YooaaORlwx7IJUayzwXEWnsp6/R44eD92myWEuN3Kq
	ATKEctSIPVydzaWLdjSzcEP4p9PU706ZkbVObMMH/dCaoFedjBsR4gf7udjIsMg2zYi85tLD9Rt
	5UT408mchvd7Q6xTZ7zUH
X-Google-Smtp-Source: AGHT+IEIFuayZdeViGaGheXPYMm/8ps877mpBKcVhq8OkNInnOAYSkaIc1jQt5+Wq4pUfsLEPGLoUg==
X-Received: by 2002:a05:6512:6509:b0:571:1bdc:14d9 with SMTP id 2adb3069b0e04-57798943ce3mr200142e87.24.1758082157893;
        Tue, 16 Sep 2025 21:09:17 -0700 (PDT)
Received: from [127.0.0.1] ([178.137.222.126])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e64fa715asm4910278e87.123.2025.09.16.21.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:09:17 -0700 (PDT)
Date: Wed, 17 Sep 2025 07:09:13 +0300
From: Svyatoslav <clamor95@gmail.com>
To: Mikko Perttunen <mperttunen@nvidia.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
CC: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] ARM: tegra114: add missing HOST1X device nodes
User-Agent: K-9 Mail for Android
In-Reply-To: <3549625.aeNJFYEL58@senjougahara>
References: <20250827113734.52162-1-clamor95@gmail.com> <20250827113734.52162-3-clamor95@gmail.com> <3549625.aeNJFYEL58@senjougahara>
Message-ID: <FF69608E-EE3A-40E3-A02B-A6BF8FDE4800@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



17 =D0=B2=D0=B5=D1=80=D0=B5=D1=81=D0=BD=D1=8F 2025=E2=80=AF=D1=80=2E 05:44=
:42 GMT+03:00, Mikko Perttunen <mperttunen@nvidia=2Ecom> =D0=BF=D0=B8=D1=88=
=D0=B5:
>On Wednesday, August 27, 2025 8:37=E2=80=AFPM Svyatoslav Ryhel wrote:
>> Add nodes for devices on the HOST1X bus: VI, EPP, ISP, MSENC and TSEC=
=2E
>>=20
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  arch/arm/boot/dts/nvidia/tegra114=2Edtsi | 64 ++++++++++++++++++++++++=
++
>>  1 file changed, 64 insertions(+)
>>=20
>> diff --git a/arch/arm/boot/dts/nvidia/tegra114=2Edtsi b/arch/arm/boot/d=
ts/nvidia/tegra114=2Edtsi
>> index 4caf2073c556=2E=2E8600a5c52be9 100644
>> --- a/arch/arm/boot/dts/nvidia/tegra114=2Edtsi
>> +++ b/arch/arm/boot/dts/nvidia/tegra114=2Edtsi
>> @@ -47,6 +47,45 @@ host1x@50000000 {
>> =20
>>  		ranges =3D <0x54000000 0x54000000 0x01000000>;
>> =20
>> +		vi@54080000 {
>> +			compatible =3D "nvidia,tegra114-vi";
>> +			reg =3D <0x54080000 0x00040000>;
>> +			interrupts =3D <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&tegra_car TEGRA114_CLK_VI>;
>> +			resets =3D <&tegra_car 20>;
>> +			reset-names =3D "vi";
>
>You are adding reset-names here, but in the last patch you're removing it=
 where there's only one reset?

I am not "adding" it, it is present in the existing schema and I am making=
 node accordingly=2E I have no intention to touch schema unless it is absol=
utely necessary=2E

>> +
>> +			iommus =3D <&mc TEGRA_SWGROUP_VI>;
>> +
>> +			status =3D "disabled";
>> +		};
>> +
>> +		epp@540c0000 {
>> +			compatible =3D "nvidia,tegra114-epp";
>> +			reg =3D <0x540c0000 0x00040000>;
>> +			interrupts =3D <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&tegra_car TEGRA114_CLK_EPP>;
>> +			resets =3D <&tegra_car TEGRA114_CLK_EPP>;
>> +			reset-names =3D "epp";
>> +
>> +			iommus =3D <&mc TEGRA_SWGROUP_EPP>;
>> +
>> +			status =3D "disabled";
>> +		};
>> +
>> +		isp@54100000 {
>> +			compatible =3D "nvidia,tegra114-isp";
>> +			reg =3D <0x54100000 0x00040000>;
>> +			interrupts =3D <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&tegra_car TEGRA114_CLK_ISP>;
>> +			resets =3D <&tegra_car TEGRA114_CLK_ISP>;
>> +			reset-names =3D "isp";
>> +
>> +			iommus =3D <&mc TEGRA_SWGROUP_ISP>;
>> +
>> +			status =3D "disabled";
>> +		};
>> +
>>  		gr2d@54140000 {
>>  			compatible =3D "nvidia,tegra114-gr2d";
>>  			reg =3D <0x54140000 0x00040000>;
>> @@ -149,6 +188,31 @@ dsib: dsi@54400000 {
>>  			#address-cells =3D <1>;
>>  			#size-cells =3D <0>;
>>  		};
>> +
>> +		msenc@544c0000 {
>> +			compatible =3D "nvidia,tegra114-msenc";
>> +			reg =3D <0x544c0000 0x00040000>;
>> +			interrupts =3D <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&tegra_car TEGRA114_CLK_MSENC>;
>> +			resets =3D <&tegra_car TEGRA114_CLK_MSENC>;
>> +			reset-names =3D "mpe";
>
>FWIW, I think 'msenc' is the appropriate name to use on Tegra114/Tegra124=
=2E I believe MPE is a remnant from older chips, even if some downstream (a=
nd I guess upstreaming) naming still uses it=2E
>

Same here, I am making those according to schema and I will not touch it i=
f not neceserry=2E

>> +
>> +			iommus =3D <&mc TEGRA_SWGROUP_MSENC>;
>> +
>> +			status =3D "disabled";
>> +		};
>> +
>> +		tsec@54500000 {
>> +			compatible =3D "nvidia,tegra114-tsec";
>> +			reg =3D <0x54500000 0x00040000>;
>> +			interrupts =3D <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks =3D <&tegra_car TEGRA114_CLK_TSEC>;
>> +			resets =3D <&tegra_car TEGRA114_CLK_TSEC>;
>> +
>> +			iommus =3D <&mc TEGRA_SWGROUP_TSEC>;
>> +
>> +			status =3D "disabled";
>> +		};
>>  	};
>> =20
>>  	gic: interrupt-controller@50041000 {
>>=20
>
>
>

