Return-Path: <linux-kernel+bounces-777845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69489B2DE78
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A2F580655
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74411DDC33;
	Wed, 20 Aug 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UFGFeipw"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43111A9FB5;
	Wed, 20 Aug 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697961; cv=none; b=ZsBpWuPar6EO0PAo6cfe/qk6HGFDqsLZDtpL6B8sjkSZrPWV1GHKdtmQk7PoZi8pqBUPXODCAURgOVhpMb5gT+iPAbVY2JXP1xRzchJAa/zIX/cs4xOcyzHnhKCPKgT7pqFxqsf7BBD8ntoaDsKakY4+buljmROkwjCh8jfURTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697961; c=relaxed/simple;
	bh=e6xWfKDZKJ1nHTZR9zFz86W0PJbkIoZCR4yIosPV2i0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bwq3mGwHBF2YDfQobqI4gWj/EU6vMeYSQ39rkZz2Jto8Z+HXmsw6XRnSonLJKk5OuqFptsqwXEVY+5HfplD6Urni3LPUDKky0sAxU/jdshUFAG1kwRe+qEiefdUAVda7W5HiDbaSvqGk34tkcrp/UVtE4DGaxmJbJmeOJ6048h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UFGFeipw; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57KDqJ2e261463;
	Wed, 20 Aug 2025 08:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755697939;
	bh=GL9sAeRKOASA+eAc8v67yQLe5ezdU+IrDN1Fs5amqjc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=UFGFeipw+uQJHat4UONB2RUWeM6loMedMBLjso0MpqRCE3IgGqPYxnTxPOoS9W1hD
	 WyfYAbu1bac8ShGI28m8/xVwdQhH+hzo9wJDyZwu7e3rC4TaneV5rdAvkzLLFvZPkO
	 ViAAOPixF+DGi3dIlHBCcvmJ+wk19mHvo0VOIvzA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57KDqJSe1828734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 20 Aug 2025 08:52:19 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 08:52:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 08:52:19 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57KDqIHg597953;
	Wed, 20 Aug 2025 08:52:18 -0500
Date: Wed, 20 Aug 2025 19:22:17 +0530
From: s-vadapalli <s-vadapalli@ti.com>
To: Michael Walle <mwalle@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-main: add legacy PCIe interrupts
Message-ID: <ae898bf0-705f-4e36-9664-37c401f5fee7@ti.com>
References: <20250819111317.1082515-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250819111317.1082515-1-mwalle@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Aug 19, 2025 at 01:13:17PM +0200, Michael Walle wrote:

Hello Michael,

> The kernel will try to map the legacy interrupt pins, but the
> interrupt mapping is missing from the device tree and thus that
> fails with:
> 
>    pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
> 
> Add the node for the legacy PCIe interrupts to fix that. This is just
> compile-time tested.

INTx is not supported by the driver as explained at:
https://lore.kernel.org/r/be3e3c5f-0d48-41b0-87f4-2210f13b9460@ti.com/

The patch to fix the error displayed in the logs was posted at:
https://lore.kernel.org/r/20240726135903.1255825-1-s-vadapalli@ti.com/
but wasn't accepted as-is. A different approach will be required to fix
of_irq_parse_pci() instead as pointed out at:
https://lore.kernel.org/r/20240729080006.GA8698@thinkpad/

[Trimmed]

Regards,
Siddharth.

