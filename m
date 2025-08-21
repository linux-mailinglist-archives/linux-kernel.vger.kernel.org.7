Return-Path: <linux-kernel+bounces-779653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2FAB2F6D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1517189E6A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D29C30F7EF;
	Thu, 21 Aug 2025 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xjb4qtzu"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7201FBEA6;
	Thu, 21 Aug 2025 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776059; cv=none; b=WeHrh51nuzbwKiD+dQSII1WCVlveegrfRtNp0S0vJR/+vP2aV2UhwIVrU7cOJDn32zdeK3//u8/L6M2TmdZAvRHGgwexhpUz9FsPTJDXoazXztgvQ8pV99g8Myd0bdnX2LMBfT8jEuJXBuLgDtEFvyX3w5rDxwr5Ql7JVzsRi1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776059; c=relaxed/simple;
	bh=hgiD/3vAlueldraQG8FtixIZHvoR9NWDaSmN1AX3F6M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5ERfBQ7QH9vFYHgECGxkIMCKarBSBJrAL1cu+LAOxe2zuyP39cQ0elDAD3AWLFxPb7tXQC3AmB5VxJmYlFRkH97APetZot45fd/9Tmmfqa+H1mH5taXgEob7BGlY+DIp9l911TaIz3EQQoTu+K/96DKMCmgEnPTDJ/NtNgQ0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Xjb4qtzu; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57LBXsjW3422679;
	Thu, 21 Aug 2025 06:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755776034;
	bh=oTAUFqQj+Srt76jvVzsWjRdQqnKeQiisH+eWp10upeM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Xjb4qtzu8M6RZpELdSuAm2Boqv1Punv/CZ41zdOAImU+FvVK/Q5PvtUdbJthVefdP
	 u4jLPevxs2LDibXoejsGNNU0j6KstqWcC93Vq16QreyE3US8BI8zmJ5PnglX/nEbvc
	 FgbHbQjYCgXS+6KtoWFyYIHLnKv70+cr1+SKAxgA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57LBXsV22789075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 21 Aug 2025 06:33:54 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 21
 Aug 2025 06:33:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 21 Aug 2025 06:33:53 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57LBXrPB1799874;
	Thu, 21 Aug 2025 06:33:53 -0500
Date: Thu, 21 Aug 2025 06:33:53 -0500
From: Nishanth Menon <nm@ti.com>
To: Randolph Sapp <rs@ti.com>
CC: Michael Walle <michael@walle.cc>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <d-gole@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <detheridge@ti.com>,
        <matt.coster@imgtec.com>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j784s4-j742s2: enable the bxs-4-64
Message-ID: <20250821113353.mhumx2omf3i5mdtv@cubicle>
References: <20250808232522.1296240-1-rs@ti.com>
 <20250808232522.1296240-3-rs@ti.com>
 <20250813151819.5rthljjrpryfwezz@skinning>
 <DC1HU458W3QA.YLONSMYKK0C4@ti.com>
 <20250813181300.xfpsu23arx7xy4fy@anointer>
 <DC5C5JA237HD.1ACBQVG1LYQ7Z@walle.cc>
 <DC5T752T3P8B.1UC57G2GH35Z5@ti.com>
 <f0353dea24751f2f2ad6e7735232b933@walle.cc>
 <DC6P6R1L2ZED.2UR8XRHH5RPJ0@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DC6P6R1L2ZED.2UR8XRHH5RPJ0@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 15:47-20250819, Randolph Sapp wrote:
> On Tue Aug 19, 2025 at 1:38 AM CDT, Michael Walle wrote:
> > Hi,
> >
> >>> Apart from that, we now have two series which partly overlap.
> >>> Should I repost mine, as that's more than just the DT entry? (Which
> >>> doesn't work as is, I'd guess.)
> >> 
> >> Ah, I don't see that series on the linux-arm-kernel list. If you can 
> >> forward me
> >> that I can work around whatever you've got.
> >
> > That was the one Nishanth mentioned earlier:
> > https://lore.kernel.org/linux-arm-kernel/20250716134717.4085567-1-mwalle@kernel.org/
> >
> > Also this:
> > https://lore.kernel.org/all/DC5KCSEUZQUJ.3KPENNUQBUFM8@kernel.org/
> >
> > -michael
> 
> Ah, alright. I'll hold off on this series until the AM62P related sections you
> were proposing are picked up.

Are all SoCs impacted by this need? just hold off the am62p changes,
perhaps?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

