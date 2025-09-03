Return-Path: <linux-kernel+bounces-797778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A62B41542
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F1517599D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764B52D77E9;
	Wed,  3 Sep 2025 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yye0lol7"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D552D5938;
	Wed,  3 Sep 2025 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881159; cv=none; b=ocy3SZwUGsYniUyB1IIkwXBKBRC2icNRIds3CKFgCSbdmGUs3uNcrPSxzRDiZt4dc7o+TV1BxXzqieO3P5I8wRpUQNfWrLa+gWXAe3obd6OTgDJsbpj/B55x8ewQFjBzkqvTT6N5xYj4FvJ4CSWGxgCWT3hIkrJvNcYJbkTN3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881159; c=relaxed/simple;
	bh=s0DKIh1cSOjVvSWX/ynVfn107wKY3U/k3t+LrqOBo/Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxTg2z7gR2yCYTebuCT86KoCNslUN2ABPtv+rMff+H1PrCJ2EAfzrmr9jVkMB2dBv3FdcEcb+eC7ozBFe2abHxCKsspHik/cE8jLEdXc78dKBo4IRehoA5fiKMh8iFIKrBtLwJfLYl+fpkM4t3yvIUBn25BNJWXfTZ/kRzNKNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Yye0lol7; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5836WV6Z3163068;
	Wed, 3 Sep 2025 01:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756881151;
	bh=8BDLROrHANQ5rnFjq0nioXWqPbh4i6CKj6MmqSMnW3w=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Yye0lol7VcI7GZgSKUI+cL6ViooyhfCuFSexWnMj1n8siQ6Y0S4yYbi3IUDCydIvM
	 yUpX7KzKcy6K7MKpWExk4F8GlzL3WPPosbbwnfHzjOW0EFllv/7Ri/VYdDKdaYYq0T
	 e5DlyGy5gAx664P8PnWmKJT+iTyBbjMFm0niMDcU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5836WUkI3398227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 01:32:31 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 01:32:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 01:32:30 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5836WTiU839700;
	Wed, 3 Sep 2025 01:32:30 -0500
Date: Wed, 3 Sep 2025 12:02:28 +0530
From: s-vadapalli <s-vadapalli@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <khasim@ti.com>, <v-singh1@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <devarsht@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: ti: k3-am62a-main: Fix main padcfg
 length
Message-ID: <6e206470-89a2-46c3-8fb9-357a56b2d03b@ti.com>
References: <20250903062513.813925-1-p-bhagat@ti.com>
 <20250903062513.813925-2-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250903062513.813925-2-p-bhagat@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Sep 03, 2025 at 11:55:12AM +0530, Paresh Bhagat wrote:
> From: Vibhore Vardhan <vibhore@ti.com>
> 
> The main pad configuration register region starts with the register
> MAIN_PADCFG_CTRL_MMR_CFG0_PADCONFIG0 with address 0x000f4000 and ends
> with the MAIN_PADCFG_CTRL_MMR_CFG0_PADCONFIG150 register with address
> 0x000f4258, as a result of which, total size of the region is 0x25c
> instead of 0x2ac.
> 
> Reference Docs
> TRM (AM62A) - https://www.ti.com/lit/ug/spruj16b/spruj16b.pdf
> TRM (AM62D) - https://www.ti.com/lit/ug/sprujd4/sprujd4.pdf
> 
> Fixes: 5fc6b1b62639c ("arm64: dts: ti: Introduce AM62A7 family of SoCs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

