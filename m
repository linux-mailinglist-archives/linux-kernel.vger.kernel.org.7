Return-Path: <linux-kernel+bounces-720220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A597AFB8B7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93A93A6ECA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655C22222C2;
	Mon,  7 Jul 2025 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jb+md87f"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CD155A25;
	Mon,  7 Jul 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906124; cv=none; b=ppMCBXXreaSKEZLIwwwYj1Q8GmI7bypiaKkhekHK9h0s0xOme/MzUgigdT17LRoU/3UlldbBn9Ywyzcc8Z0WnWd/+BIpcHb8GIu9DX5DWT7DntU2ogfxGPojZ1MPgKpdrPoi1gwYONOQyJE9hf3JkAdsFE7NoVzjmi+KeARQ5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906124; c=relaxed/simple;
	bh=3ccaAKo8bqSiRpLKbyb++ylypBC7BxLDPFYa8O6TydM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmu1KmU76VY3fadmIdFX6Fzfg/RX5vtBvFqD1buWsPmHI9kBuisfalKH6XSg0gHHm9Th/B2WBWZY8WtR6H4oeyU/X7dl0+1rHQ+C8aEMiTFtL8Nw7B09seKebc7tVh6xpd56br+MSR1S0NluVnatjG1AjRe2DI298wf3qM40U/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Jb+md87f; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 567GZECo272112;
	Mon, 7 Jul 2025 11:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751906114;
	bh=adOl+0ZROT08R4gkFgtW0IB/T2wkeUgUvkFVxuu+NYc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Jb+md87f0hCU48J8NYDmrYFm9cW/xbIkCvhKNm5VZUGAPSfZa/5fdiLg84Hf5XYjR
	 uKUxKsBqRjqZSlCI11hbbFf/8xkhRkHf18G9/pVkYj2TZPNC6OqG3/Oh4qhOvvR3Ub
	 iHXwD9OkB6ylEHOAmYM0DCbGss3yJu2dCs179nJw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 567GZE0w2389392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 7 Jul 2025 11:35:14 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 7
 Jul 2025 11:35:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 7 Jul 2025 11:35:13 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 567GZDaW223977;
	Mon, 7 Jul 2025 11:35:13 -0500
Date: Mon, 7 Jul 2025 11:35:13 -0500
From: Bryan Brattlof <bb@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <khasim@ti.com>, <v-singh1@ti.com>,
        <afd@ti.com>, <devarsht@ti.com>, <s-vadapalli@ti.com>,
        <andrew@lunn.ch>
Subject: Re: [PATCH v6 1/4] arm64: dts: ti: Add bootph property to nodes at
 source for am62a
Message-ID: <20250707163513.g5mzvuf4o26dq7cg@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250704100954.2231853-1-p-bhagat@ti.com>
 <20250704100954.2231853-2-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250704100954.2231853-2-p-bhagat@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On July  4, 2025 thus sayeth Paresh Bhagat:
> Add bootph property directly into the original definitions of relevant
> nodes (e.g., power domains, USB controllers, and other peripherals)
> within their respective DTSI files (ex. main, mcu, and wakeup) for
> am62a.
> 
> By defining bootph in the nodes source definitions instead of appending
> it later in final DTS files, this change ensures that the property is
> inherently present wherever the nodes are reused across derived device
> trees.
> 
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   | 13 +++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi |  2 ++
>  2 files changed, 15 insertions(+)
> 

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

