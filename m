Return-Path: <linux-kernel+bounces-813626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBA3B54862
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A677B1C24D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D71280035;
	Fri, 12 Sep 2025 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sQizrpGH"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE15284891;
	Fri, 12 Sep 2025 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670769; cv=none; b=pxbUtE2ONxh7fWwlyrD/JaZYseEUqPa6OeRmUpu0jfa6SvHDP9dZTv3+kDArRXTp1tdJe0nLrjVzoT02htHGN1c7LzC1mV6pBZQ715GOh6g0ZgCoOGhI2oVOC731VAWYHoIQJ4TpMq5LRG8Fwa0/rCQ7/4I9blep3hAZSBk4Bms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670769; c=relaxed/simple;
	bh=D/BscCL8D9NxQ+NtzHk0hZ7OqfSHWQCBlwgFiDTH66E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=teE1y2AzlZTXDg0rq50t7AYd9uvL5wh4kNkNe23tof3UeffEoYOB1rjhlDaJhoIlHvdQkUDqR00LRzIMTpEhmfjhzdZLusxQRWxDM8H5bBnftegH++lszu8utoXfty0fOsFTHVkrKjdD+KwZfkx+1rycBvTsAMDoZnsZ1P36a2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sQizrpGH; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C9qghP580716;
	Fri, 12 Sep 2025 04:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757670762;
	bh=xRzGKXz9U+GsCb2jos1YYzGtIbZvH6EAGpLjCdcTfPA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sQizrpGHTsflt9DUN11hv88k8DRMzngNqaQXI5eGAqnHORpdYDwtlrYKLqry/UIya
	 WCM5YKfnFAciH6A29QsDdkZ0ZLt6p4x0WSi0q6dfXiYOij6JtkpDVYHVmui5k11NNh
	 qPTm6GN85M1VMRGbI/6N590utYKlx9g6IluR5Bfk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C9qgDN2686911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 04:52:42 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 04:52:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 04:52:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C9qfqk3415906;
	Fri, 12 Sep 2025 04:52:41 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
CC: Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <u-kumar1@ti.com>, <srk@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-evm: Add overlay to enable USB0 Type-A
Date: Fri, 12 Sep 2025 04:52:38 -0500
Message-ID: <175766787314.27117.5995489139863175126.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250912062021.2906034-1-s-vadapalli@ti.com>
References: <20250912062021.2906034-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Siddharth Vadapalli,

On Fri, 12 Sep 2025 11:50:14 +0530, Siddharth Vadapalli wrote:
> The J721S2-EVM (J721S2-SOM mounted on the J7 Common Processor Board) has
> a single instance of USB namely USB0. On the board, USB0 can be enabled
> using a single USB interface at a time among the following:
> 1. USB3.1 Gen1 Type C interface
> 2. Two USB2.0 Type A interfaces via an on-board USB Hub
> 
> By default, USB0 is enabled using the USB3.1 Gen1 Type C interface. Hence,
> add a device-tree overlay to allow using USB0 with the USB2.0 Type A
> interfaces by configuring the "USB2.0_MUX_SEL" mux. Also, since the Type A
> interfaces only connect to USB Devices with USB0 acting as the USB Host,
> set the Dual-Role mode for USB0 to Host.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1]. might
good to see these earlier in the rc cycle, but looks innocous enough,
so applied. Thank you!

[1/1] arm64: dts: ti: k3-j721s2-evm: Add overlay to enable USB0 Type-A
      commit: fcfedcb6804caaf18f22016de16d93bf18bbcfdd

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource


