Return-Path: <linux-kernel+bounces-767307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C84B252AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A5917E21C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6B629DB92;
	Wed, 13 Aug 2025 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YummBlmY"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4973229CB2D;
	Wed, 13 Aug 2025 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107795; cv=none; b=FeGTgPBKXuHtaPiZfv2GkqQ+TK4N8susm9praWWtJuf/4G4IK0dcn0DeH1MsNTMjv2u1oK5ImDiDgMBb3z16tnLyaFNlHBfX+sIkyqpLnqoBPC6sfMxosnkLBxSkKlf6MEYCKiVKLMF4G6/lqjCd+/1UADbJ+qaFbNEiBmfktnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107795; c=relaxed/simple;
	bh=aplisa4/4T77IzHyjLTtEJnFGQ7pYtscP/S4eNvIWVQ=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:Subject:From:To:
	 References:In-Reply-To; b=JgJnpdeCyPdUuK+QzduOSbUQZrkD3zQQb55AmTY/ph/dsdEVgCh+lDwaoUw5RQChfQHn5Bu5RYeLSE2pcSscIh2703MSD+JPUFCzCyXuPJ1NRr3v5HTZrNBICHJPeI1S32EYidwmiyKRliRt27D79sb6ujwD13RUkZxXPGtLt/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YummBlmY; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DHuNSX2202385;
	Wed, 13 Aug 2025 12:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755107783;
	bh=QFJX7ROmMlHtgiQ3gBewH9Q1Os88jQwB6NXsXPrawN0=;
	h=Date:CC:Subject:From:To:References:In-Reply-To;
	b=YummBlmY7ttSy6IpyHWe6VEDzxGUSkFPK8eiiTitKq+WZDKcVLTyW5PWF4SJr5WaU
	 azDgclvEJyZk5o4fM/0UBa0OEZwkr5hmttGCswZ5wAdDRQTX6wkuP0y4TQt5LutIU4
	 H3uVI2Iq1X+tvjKG3Ksmshmfz0Kj3kziSN9sWV9Y=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DHuNtZ565346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 12:56:23 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 12:56:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 12:56:22 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DHuMO82674221;
	Wed, 13 Aug 2025 12:56:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Aug 2025 12:56:22 -0500
Message-ID: <DC1HS8D8KLIF.2MN7D9EXGQQ45@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d-gole@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <detheridge@ti.com>, <matt.coster@imgtec.com>,
        Michael Walle
	<mwalle@kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am62p-j722s: enable the bxs-4-64
From: Randolph Sapp <rs@ti.com>
To: Nishanth Menon <nm@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250808232522.1296240-1-rs@ti.com>
 <20250808232522.1296240-2-rs@ti.com>
 <20250813151721.nc5fr3qmro5grlda@steam>
In-Reply-To: <20250813151721.nc5fr3qmro5grlda@steam>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed Aug 13, 2025 at 10:17 AM CDT, Nishanth Menon wrote:
> On 18:25-20250808, rs@ti.com wrote:
>> From: Randolph Sapp <rs@ti.com>
>>=20
>> Add the relevant device tree node for Imagination's BXS-4-64 GPU.
>>=20
>> These devices specifically do not set the dma-coherent bit because they
>> do not use the same MSMC configuration as other BXS-4-64 enabled TI
>> platforms.
>>=20
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>> ---
>>  .../boot/dts/ti/k3-am62p-j722s-common-main.dtsi     | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/ar=
ch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
>> index 2e5e25a8ca86..a51db8f9dff8 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
>> @@ -690,6 +690,19 @@ ospi0: spi@fc40000 {
>>  		};
>>  	};
>> =20
>> +	gpu: gpu@fd80000 {
>> +		compatible =3D "ti,j721s2-gpu", "img,img-bxs-4-64", "img,img-rogue";
>
> Note the discussion in https://lore.kernel.org/linux-arm-kernel/DBE4UO2RG=
AYX.17V1DAF8MQYJM@kernel.org/
>
>> +		reg =3D <0x00 0x0fd80000 0x00 0x80000>;
>> +		clocks =3D <&k3_clks 237 1>;
>> +		clock-names =3D "core";
>> +		assigned-clocks =3D <&k3_clks 237 1>;
>> +		assigned-clock-rates =3D <800000000>;
>> +		interrupts =3D <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
>> +		power-domains =3D <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>,
>> +				<&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
>> +		power-domain-names =3D "a", "b";
>> +	};
>> +
>>  	cpsw3g: ethernet@8000000 {
>>  		compatible =3D "ti,am642-cpsw-nuss";
>>  		#address-cells =3D <2>;
>> --=20
>> 2.50.1
>>=20
>
> Is the issue that Michael reported
> https://lore.kernel.org/linux-arm-kernel/20250716134717.4085567-3-mwalle@=
kernel.org/
> resolved?

Define resolved. If by resolved you mean using the same hack we have had on=
 the
out of tree module for years, then yes it is resolved.

