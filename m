Return-Path: <linux-kernel+bounces-774409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0580AB2B1D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF843A8FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF5A273D73;
	Mon, 18 Aug 2025 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jw77B70c"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14425DB12;
	Mon, 18 Aug 2025 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755546234; cv=none; b=RpPRjDOD1CnIA2iN0ee3YHT5kTma5QRCm48UVlFcznCicws2vhoBsewfaPDQYlX50HWQdWjx7Rt3QcqcQ8dWXRkM3z4MSOLsgb9j779hJkZnffZMO8Hmt8QQKYYbYHXpvBBV475LcVdvHOyvlIGyHGu//eLQEtF00BSjpEl6NW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755546234; c=relaxed/simple;
	bh=ughZPsaD1nq7Kg43+Ma1f6tZLG4S0Xyy82tfIIKOTnE=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:Subject:From:To:
	 References:In-Reply-To; b=gmAn6aqvZwcOMzoKfiMg8vvueEv94iLqYR7qAHiJFSvZKMUEymiKezPb1H5WEPxKtiNwjer02Z96Regec0yUX62fO7Ufd82eWdxi0G8t5sLMy5LlE3I0ys7KjihJUFJtw+PEJkektdsKshC7pVmLG3lBvZ7JGu3oomGLbDz/Sdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Jw77B70c; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57IJhhNE2728942;
	Mon, 18 Aug 2025 14:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755546223;
	bh=hbqjR77flrEojaMmvXfL0GY1fNUeEb1Qsxjgnrp8ask=;
	h=Date:CC:Subject:From:To:References:In-Reply-To;
	b=Jw77B70ciHlBfvOueY2p0pueCXi8VH5bRDrpHynFr5WH4FN0I6fdE/Lqen5rkZg+q
	 mtDvWjWje+lLMMgM50BIw2TX4jn7cAFep+BoOMy6vUioZzjU6tmwAvyXGFq/PWAUxb
	 bX+18JRiHEAcJwvPBkfur+0WN9Rc4LpZJWLr3ck4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57IJhhcg515659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 18 Aug 2025 14:43:43 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 14:43:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 14:43:42 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57IJhgLn1830747;
	Mon, 18 Aug 2025 14:43:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Aug 2025 14:43:42 -0500
Message-ID: <DC5T752T3P8B.1UC57G2GH35Z5@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d-gole@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <detheridge@ti.com>, <matt.coster@imgtec.com>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j784s4-j742s2: enable the
 bxs-4-64
From: Randolph Sapp <rs@ti.com>
To: Michael Walle <michael@walle.cc>, Nishanth Menon <nm@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250808232522.1296240-1-rs@ti.com>
 <20250808232522.1296240-3-rs@ti.com>
 <20250813151819.5rthljjrpryfwezz@skinning>
 <DC1HU458W3QA.YLONSMYKK0C4@ti.com>
 <20250813181300.xfpsu23arx7xy4fy@anointer>
 <DC5C5JA237HD.1ACBQVG1LYQ7Z@walle.cc>
In-Reply-To: <DC5C5JA237HD.1ACBQVG1LYQ7Z@walle.cc>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mon Aug 18, 2025 at 1:22 AM CDT, Michael Walle wrote:
> Hi,
>
> On Wed Aug 13, 2025 at 8:13 PM CEST, Nishanth Menon wrote:
>> On 12:58-20250813, Randolph Sapp wrote:
>> > On Wed Aug 13, 2025 at 10:18 AM CDT, Nishanth Menon wrote:
>> > > On 18:25-20250808, rs@ti.com wrote:
>> > >> From: Randolph Sapp <rs@ti.com>
>> > >>=20
>> > >> Add the relevant device tree node for Imagination's BXS-4-64 GPU.
>> > >>=20
>> > >> These devices uses a similar MSMC configuration to the J721S2. As s=
uch,
>> > >> they also require the use of the dma-coherent attribute.
>> > >>=20
>> > >> Signed-off-by: Randolph Sapp <rs@ti.com>
>> > >> ---
>> > >>  .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 14 ++++++++++=
++++
>> > >>  1 file changed, 14 insertions(+)
>> > >>=20
>> > >> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dt=
si b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>> > >> index 7c5b0c69897d..a44ca34dda62 100644
>> > >> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>> > >> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
>> > >> @@ -2691,4 +2691,18 @@ bist_main14: bist@33c0000 {
>> > >>  		bootph-pre-ram;
>> > >>  		ti,sci-dev-id =3D <234>;
>> > >>  	};
>> > >> +
>> > >> +	gpu: gpu@4e20000000 {
>> > >> +		compatible =3D "ti,j721s2-gpu", "img,img-bxs-4-64", "img,img-rog=
ue";
>> > >
>> > > Following  https://lore.kernel.org/linux-arm-kernel/DBE4UO2RGAYX.17V=
1DAF8MQYJM@kernel.org/
>> > > Is it worth having ti,j784s4-gpu here? Are there any SoC specific qu=
irks
>> > > that driver will need to handle?
>> >=20
>> > No SoC specific quirks, aside from those already being tracked through=
 the
>> > dma-coherent attribute. If we actually want to register SoC specific
>> > compatibility entries as advised by the kernel docs, just let me know.=
 I've seen
>> > this opinion toggle a few times.
>> >=20
>>
>> Please provide bootlogs on linux-next with just this series applied.
>> IMHO, based on what I see at the moment on GPU, it might be a good idea
>> to have SoC specific compatibility entries.
>
> IMHO, that's *always* a good idea, even if the IP is the very same
> as the integration might be different.
>
> Apart from that, we now have two series which partly overlap.
> Should I repost mine, as that's more than just the DT entry? (Which
> doesn't work as is, I'd guess.)
>
> -michael

Ah, I don't see that series on the linux-arm-kernel list. If you can forwar=
d me
that I can work around whatever you've got.

