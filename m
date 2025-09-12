Return-Path: <linux-kernel+bounces-813617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DACB5484F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E317A270A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86722857CD;
	Fri, 12 Sep 2025 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lgPA3CbT"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE0266B6F;
	Fri, 12 Sep 2025 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670632; cv=none; b=KZh9lNvnRkfedCj58WqNce5FKkhszgrZGf25ssIwOcd4Sg3BYi5Fu718CVGUFSCvQJXSSutAs1KQQlqqpUMXTe8WVbyaS+tzRYm52TqSuc4SR+I/bh50pceM6RBIM5P2aqDHqE1mhDWBcBOZnY0F8v+1kV0YtWlVph3bRL8YmLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670632; c=relaxed/simple;
	bh=0eF+X12rUKERfp6zAB0DcBk3pWNCWplfe9yIERR3PYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKw/8lMWuXg1tmAaHKv5eu9tPl5uHd4Ei+8XOgPMJ38GDmEmMox/VhaR/dKHbHjpWtRwdq55KaUYH6wjLWUHNzgdEjUOPpc7w9boJ9XU9uWSCuYBg7btxAVImxQ+RKasFsIpMVBTiqOb0Amh4Gj5rERU/2Z7akf3QZj82HEsTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lgPA3CbT; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C9oGUn495811;
	Fri, 12 Sep 2025 04:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757670616;
	bh=ntkc+eDfi34B22gjEgJT3aJJ9hSVrI8PWXJvH/RPrJw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lgPA3CbTGiCTBuEhSmYlFtcsPb3+Ms14LbLxkKoCGHFaoo95NQrbpOFk/rW1sHhfw
	 AUWFfKZgHj4LlNyD0AjOouCLHtc6KlEjZMaVJ0/HDVpjZy6qukIQ4ttxPY2Ude3caG
	 JWx+VNNNV1316VTuug133KCppLDpOe3vqxSt4Poc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C9oG0K1219416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 04:50:16 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 04:50:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 04:50:15 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C9oF7L3413569;
	Fri, 12 Sep 2025 04:50:15 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Hrushikesh Salunke
	<h-salunke@ti.com>
CC: Nishanth Menon <nm@ti.com>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH v2 0/4] arm64: dts: ti: Add bootph-all tag to USB PHY controller
Date: Fri, 12 Sep 2025 04:50:12 -0500
Message-ID: <175766787158.26706.7113494915316256606.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250902053009.1732607-1-h-salunke@ti.com>
References: <20250902053009.1732607-1-h-salunke@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Hrushikesh Salunke,

On Tue, 02 Sep 2025 11:00:05 +0530, Hrushikesh Salunke wrote:
> This patch series adds the bootph-all property to USB0 PHY controller
> nodes across multiple TI SoCs (AM62, AM62A, AM62P, J722S).
> 
> The bootph-all tag ensures that these USB PHY controller nodes are
> available during all boot phases, which is required for USB DFU
> (Device Firmware Upgrade) boot functionality.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am62a7-sk: Add bootph-all tag to usb0_phy_ctrl node
      commit: 47315d395a98a56f8854a2085f887fb18a8217d9
[2/4] arm64: dts: ti: k3-am62p5-sk: Add bootph-all tag to usb0_phy_ctrl node
      commit: 398af33bedc1a64f7045be065e1e17e292cc1c60
[3/4] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all tag to usb0_phy_ctrl node
      commit: 69cd3e0eef26edbc39dca06522f6ae289448d172
[4/4] arm64: dts: ti: k3-j722s-evm: Add bootph-all tag to usb0_phy_ctrl node
      commit: 5cad4ce9a7b82118cfeeb764e1a555a5789c22e3

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


