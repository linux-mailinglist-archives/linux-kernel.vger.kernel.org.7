Return-Path: <linux-kernel+bounces-767309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7517DB252A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A771892FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEA829B78E;
	Wed, 13 Aug 2025 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e2Hz9dNH"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E2129ACFD;
	Wed, 13 Aug 2025 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107943; cv=none; b=iPjoALgVj9tfDB9GW35kKoO0UymHYUMKJxYbYo1KQaxsc9UVKCHi8Glxc4BfAUsCYg5sdiMaNI+D4NBv+PAZaybqt2EDntWM4Bb/94As0VOjjVe7ThqASRt+cxAcnmSlvldutil8m1kJwzIB+aLZ2nRu6ZI+5sLkpDQL1yOwvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107943; c=relaxed/simple;
	bh=A0uWMSBoshWApXjMZxa0BZajr8RlMKNAHuKmTd/nBJ8=;
	h=MIME-Version:Content-Type:Date:Message-ID:From:To:CC:Subject:
	 References:In-Reply-To; b=AOcZiy/nDW8KGwq9Q7RQxswyLD6Bd5gskun3cg36Z5IP9/rD/hTr6D7P8ScOV7RF7SNcQq/150brUaFQpH+JOBL2cF10fihl03y4xlXbbzlvdY4l6abkc0VK9stS9g32w5Z+dhH64nxikdSzxzyw+ufgCoDprUcv0Vy4p7ZjGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e2Hz9dNH; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DHwoNs2128852;
	Wed, 13 Aug 2025 12:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755107930;
	bh=lL/86upWP/+8sXqyxr7nH0Vq0QlFJa/4K+UatKQhu1c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=e2Hz9dNHPEhPLQ0CnK8fClA+7gQy4WdM9Uadnl7xfSxkx1LHu6ASr6nKgjcZVpnK2
	 eUwUkhd/R2AY/tKQI2Z32IpG69pGrKxIgZxbFoIYu4+RBBQtqm2QSfstGxg/wVT9is
	 FXfMvnW/bsfUa8LGrENMQlR3d6NK6BhtKKkcU+Cg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DHwoJp239179
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 12:58:50 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 12:58:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 12:58:50 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DHwo7Z2676660;
	Wed, 13 Aug 2025 12:58:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Aug 2025 12:58:50 -0500
Message-ID: <DC1HU458W3QA.YLONSMYKK0C4@ti.com>
From: Randolph Sapp <rs@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d-gole@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <detheridge@ti.com>, <matt.coster@imgtec.com>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j784s4-j742s2: enable the
 bxs-4-64
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250808232522.1296240-1-rs@ti.com>
 <20250808232522.1296240-3-rs@ti.com>
 <20250813151819.5rthljjrpryfwezz@skinning>
In-Reply-To: <20250813151819.5rthljjrpryfwezz@skinning>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed Aug 13, 2025 at 10:18 AM CDT, Nishanth Menon wrote:
> On 18:25-20250808, rs@ti.com wrote:
>> From: Randolph Sapp <rs@ti.com>
>>=20
>> Add the relevant device tree node for Imagination's BXS-4-64 GPU.
>>=20
>> These devices uses a similar MSMC configuration to the J721S2. As such,
>> they also require the use of the dma-coherent attribute.
>>=20
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>> ---
>>  .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/=
arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>> index 7c5b0c69897d..a44ca34dda62 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>> @@ -2691,4 +2691,18 @@ bist_main14: bist@33c0000 {
>>  		bootph-pre-ram;
>>  		ti,sci-dev-id =3D <234>;
>>  	};
>> +
>> +	gpu: gpu@4e20000000 {
>> +		compatible =3D "ti,j721s2-gpu", "img,img-bxs-4-64", "img,img-rogue";
>
> Following  https://lore.kernel.org/linux-arm-kernel/DBE4UO2RGAYX.17V1DAF8=
MQYJM@kernel.org/
> Is it worth having ti,j784s4-gpu here? Are there any SoC specific quirks
> that driver will need to handle?

No SoC specific quirks, aside from those already being tracked through the
dma-coherent attribute. If we actually want to register SoC specific
compatibility entries as advised by the kernel docs, just let me know. I've=
 seen
this opinion toggle a few times.

>> +		reg =3D <0x4e 0x20000000 0x00 0x80000>;
>> +		clocks =3D <&k3_clks 181 1>;
>> +		clock-names =3D "core";
>> +		assigned-clocks =3D <&k3_clks 181 1>;
>> +		assigned-clock-rates =3D <800000000>;
>> +		interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>> +		power-domains =3D <&k3_pds 181 TI_SCI_PD_EXCLUSIVE>,
>> +				<&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
>> +		power-domain-names =3D "a", "b";
>> +		dma-coherent;
>> +	};
>>  };
>> --=20
>> 2.50.1
>>=20


