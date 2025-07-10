Return-Path: <linux-kernel+bounces-725653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8037DB0021D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706D55C30DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24402566F2;
	Thu, 10 Jul 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qxMn5dRU"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCCE221561;
	Thu, 10 Jul 2025 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150826; cv=none; b=pP8jixZeZu8m9nkfyjQoN00JrrNonVVPi0QvJ5+SBhm50Ph906syMIo30iAz+LxvaoOEcs/F5yXpCodTmbvsKDkC5nWCB/QfaQg06DS18gqdSF5PLdApddEm+EQEI/6ohVVQmy1YcYNPGd0INyWLU87+PJrsgDlNmdPG+kpnf/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150826; c=relaxed/simple;
	bh=fz9X3p10KAkS28O0joUbvc0AkhGN09HbLV3Rz4ngYTs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l44raBptfRgX4TlQL/gb2R3qG84JtwWcxDBUlCKZGkCzc9jexA6kg+6B7kT8rtrGFOPBg9nAqTwA0O9WT4T9MLozj0/GT1xLJ06o+vN6f3QJmKc0ZsRjG6NUFCdjjsObt1dL9/yMQVZ1cFk16Kg5RU9EzOE9SrMv2QIeeKwF2nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qxMn5dRU; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56ACXc0Z1504996;
	Thu, 10 Jul 2025 07:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752150818;
	bh=67Mt84dlbu0xtwxBGwYkDpISqaxe7nX50EapXSTnVt0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=qxMn5dRUXXIwAR+d2S2sM+9gaO/zjfqdV7Vn7DpyBnCdyN3zehz+qpwWARPNbeqaS
	 6XyKfIhMKJLHGEJEMu/KD2iyn9Ki4bnctj8kTrdXmI+1OlMlgKUpNY1n8OREW3byB3
	 uDr/zlOGy2nk6T2OSpiAEurSEHhhPbRyXVvc+3g8=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56ACXcRo3499436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 10 Jul 2025 07:33:38 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 10
 Jul 2025 07:33:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 10 Jul 2025 07:33:37 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56ACXbZ01342395;
	Thu, 10 Jul 2025 07:33:37 -0500
Date: Thu, 10 Jul 2025 07:33:37 -0500
From: Bryan Brattlof <bb@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am65: add boot phase tags
Message-ID: <20250710123337.ltnfhtpxaisi2yu3@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250709-65-boot-phases-v1-0-e1f89d97a931@ti.com>
 <20250709-65-boot-phases-v1-1-e1f89d97a931@ti.com>
 <83c5d0b8-add8-4db7-bcde-5b17c796b53a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <83c5d0b8-add8-4db7-bcde-5b17c796b53a@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On July 10, 2025 thus sayeth Vignesh Raghavendra:
> 
> 
> On 10/07/25 04:05, Bryan Brattlof wrote:
> 
> [...]
> 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> > index 7cf1f646500a16c1d1bac6dfb37fb285218063b3..5bbd817bc51464f6605c5b2dc9cb544a109a695d 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> > @@ -211,6 +211,7 @@ mcu_ringacc: ringacc@2b800000 {
> >  			ti,sci = <&dmsc>;
> >  			ti,sci-dev-id = <195>;
> >  			msi-parent = <&inta_main_udmass>;
> > +			bootph-all;
> >  		};
> >  
> >  		mcu_udmap: dma-controller@285c0000 {
> > @@ -235,6 +236,7 @@ mcu_udmap: dma-controller@285c0000 {
> >  			ti,sci-rm-range-rchan = <0xb>, /* RX_HCHAN */
> >  						<0xa>; /* RX_CHAN */
> >  			ti,sci-rm-range-rflow = <0x0>; /* GP RFLOW */
> > +			bootph-all;
> >  		};
> >  	};
> 
> Should this be board specific property? Does every user of AM65x need
> DMA at boot stage?
> 

Yeah. I'm not too sure how we want to handle this. Some boot modes will 
require DMA up and running, but if a board only uses eMMC then we won't 
need DMA during the early phases of boot.

I saw we already do this for the AM62P so I decided to keep moving in 
that direction even though it's not a perfect and it seemed like a 
better solution than dragging the DMA node up to the board level.

I'll drop it for now until I can think of a better idea.

> [...]
> 
> > @@ -107,5 +111,6 @@ wkup_vtm0: temperature-sensor@42050000 {
> >  		reg = <0x42050000 0x25c>;
> >  		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
> >  		#thermal-sensor-cells = <1>;
> > +		bootph-all;
> 
> Same here..
> 

Yeah I'm assuming this is one of those weird things being in the middle 
of the Jacinto and Sitara class causes. It's used, much like the rest of 
the Jacinto parts, by the bootloaders to get at the voltage domain info 
to configure the OPP data before the bootloader starts the A53s.

All AM65x boards will need this node to prevent an overclocking situation 
if the voltage isn't high enough.

~Bryan

