Return-Path: <linux-kernel+bounces-795901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E88B3F928
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547333A42CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91AB2E8DF4;
	Tue,  2 Sep 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gHGszV8H"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C7270572;
	Tue,  2 Sep 2025 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803131; cv=none; b=hepbISO05LFaOWCKQD1uGHFrQz6kWZX4ldZOeRsDx6mLBONFkyvnnPSkZZ4I4bntfi7ytTC0tEE/iyJ5IZyQqzXg2JJ4XAkFiDbpRlojUKA0SieANTeAdjxVKVwBbB5FUxNwGMR2V/QHMPjfLLz3nAx7FshshtOnUhp6grcBu8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803131; c=relaxed/simple;
	bh=cADqc0G/7sL0/oarbsXhlWO50gtKRaEdW31AEj39NuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCHXSdnNAPodZ/tfhnByjC7+P4s8vEQUuvKcYKkibljJXbAemrSL6olbov0uE6fcjlYMJzzSXN7AujygGiyEaxhhvt0zZ4lSRP8pm8wmya0RsKFSQUFewDDBFHifWF2TOi8AwqrIdGuksIYYMrsHy8Of6bGzpEYURPSmmanHzzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gHGszV8H; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5828q45k2549616;
	Tue, 2 Sep 2025 03:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756803124;
	bh=BEaYaFcRNCB3rYEaAmMXhkNIWrWDCrbSUKBE4BRwTNg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=gHGszV8Ho7ppNXMFp7tAIWgS+beKufNbPzy/rCIdm6n3JkdmidpmQsqINz4FUolqS
	 WQ4o+rsRA98cTiTyp9wqORyZrJfdrWLJqys8P7VKCayeimjYA7WKiRongwl85s6Gxb
	 ZvHj/iDw1OBFTgjVfOP11bytEwWgxHx5TxxWObDg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5828q4Od2158781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 03:52:04 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 03:52:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 03:52:03 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5828q2iQ3526474;
	Tue, 2 Sep 2025 03:52:03 -0500
Date: Tue, 2 Sep 2025 14:22:02 +0530
From: s-vadapalli <s-vadapalli@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <khasim@ti.com>, <v-singh1@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am62a-main: Fix pinctrl
 properties
Message-ID: <77edd9c0-9bfe-4963-8149-51c819cce022@ti.com>
References: <20250823032304.1085775-1-p-bhagat@ti.com>
 <20250823032304.1085775-2-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250823032304.1085775-2-p-bhagat@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sat, Aug 23, 2025 at 08:53:03AM +0530, Paresh Bhagat wrote:
> From: Vibhore Vardhan <vibhore@ti.com>
> 
> Correct reg length to match end address - start address for main

nitpick: s/reg/register

I assume that you are implying "end address - start address" as
subtracting the "start address" from the "end address" to get the
length. This description might not be required given that you are
stating the 'last physical address for the main pad configuration
registers' below. You might rephrase it to indicate that the main pad
configuration register region starts with the
MAIN_PADCFG_CTRL_MMR_CFG0_PADCONFIG0 register having the address of
0x000f4000 and the region ends with the
MAIN_PADCFG_CTRL_MMR_CFG0_PADCONFIG150 register having the address of
0x000f4258, as a result of which, the length of the region is 0x25c
instead of 0x2ac.

> PADCFG registers. The last physical address for the main pad
> configuration registers (MAIN_PADCFG_CTRL_MMR_CFG0_PADCONFIG150) is
> 0x000f4258. Adding 4 bytes gives 0x000f425c, so the size in device
> tree should be defined as 0x25c instead of 0x2ac.
> 
> Reference Docs
> TRM (AM62A) - https://www.ti.com/lit/ug/spruj16b/spruj16b.pdf
> TRM (AM62D) - https://www.ti.com/lit/ug/sprujd4/sprujd4.pdf
> 
> Fixes: 5fc6b1b62639c ("arm64: dts: ti: Introduce AM62A7 family of SoCs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>

[...]

Regards,
Siddharth.

