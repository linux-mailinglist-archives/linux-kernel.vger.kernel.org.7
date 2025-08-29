Return-Path: <linux-kernel+bounces-791720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38067B3BAC4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076C57B9311
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9129D314A8E;
	Fri, 29 Aug 2025 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SLoPJGOh"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9013148D8;
	Fri, 29 Aug 2025 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756469037; cv=none; b=TOwBbkMMtMznERC0PNLDtqYgbee3e9qsMjuguCAekgXvm9UPzfbxIUuEMb29X/yyleTnQzs0sk/ryqmp/OYbeFr/B9/nrqQP+tZTskHb1RjaOocvyeltLC2QXE1NHsq8tQWouW85nTeZObRRgzaXctR1qySigb66Jcq0GUdW/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756469037; c=relaxed/simple;
	bh=B8K4vOhCccZb/HIoNc+Oe8RQtm0lDCy9ee37rH/thJI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2RBp9kD+i4IVsCEwy8pvbzDy9pMz3QSW5nG413tkTzFRdMuzQx0yKnlNio/rz9CiVNq3vjhsUK2Og1qPhqBzLkAEW7I9rsj7u9WeDQOtoLFX4bNUviamJiGovXdG+iW+hp80CnBafnnnv4l9Vn/Eqmp+2QbsbAGc8/52HjXktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SLoPJGOh; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57TC3lCH1798691;
	Fri, 29 Aug 2025 07:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756469027;
	bh=jaWfP3mDKCTKkl7RN75qVdEctGBAP2mBme4ObMh7L7I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=SLoPJGOhqd5SaL8cJFl8FmjPWwIrSbW0criJFKOBGwpBHvozEj5HrVIGou1Pijzpc
	 OBbmUaG/Ai/naWSil3ZXvxkqTodsR/cYrwbCq8fuROmi8IqTQhPACjplVFP12GvI3T
	 WPZHyQf38WjNRKEgc5HfY9L6ndCdwMBpKKo6ul3A=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57TC3lIE3997113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 29 Aug 2025 07:03:47 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 07:03:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 07:03:47 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57TC3l6Q2308133;
	Fri, 29 Aug 2025 07:03:47 -0500
Date: Fri, 29 Aug 2025 07:03:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH 0/3] arm64: dts: ti: Add bootph-all tag to USB PHY
 controllers
Message-ID: <20250829120347.v2mhce4tntnewrm7@mushy>
References: <20250829074700.1531562-1-h-salunke@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250829074700.1531562-1-h-salunke@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 13:16-20250829, Hrushikesh Salunke wrote:
> This patch series adds the bootph-all property to USB0 PHY controller 
> nodes across multiple TI SoCs (AM62, AM62A, AM62P, J722S). 
> 
> The bootph-all tag ensures that these USB PHY controller nodes are 
> available during all boot phases, which is required for USB DFU 
> (Device Firmware Upgrade) boot functionality.
> 
> This series is based on commit:
> 8cd53fb40a30 Add linux-next specific files for 20250828
> 
> Hrushikesh Salunke (3):
>   arm64: dts: ti: k3-am62p-j722s-common-wakeup: Add bootph-all tag to
>     usb0-phy-ctrl node
>   arm64: dts: ti: k3-am62-wakeup: Add bootph-all tag to usb0-phy-ctrl
>     node
>   arm64: dts: ti: k3-am62a-wakeup: Add bootph-all tag to usb0-phy-ctrl
>     node
> 
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi               | 1 +
>  arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi              | 1 +
>  arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi | 1 +
>  3 files changed, 3 insertions(+)
> 
> -- 
> 2.34.1
> 

NAK! please do this for the boards that need this capability. bootph
property at SoC dtsi level are mandatory components for ALL bootmodes
and all boards.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

