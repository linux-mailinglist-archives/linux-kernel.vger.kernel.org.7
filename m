Return-Path: <linux-kernel+bounces-782646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40A0B3231C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66216B21516
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7943C2D4B66;
	Fri, 22 Aug 2025 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nlqkzU9F"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC252D3748;
	Fri, 22 Aug 2025 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891908; cv=none; b=W+Fg/eTQczVdwxAD0xanbrgrZFDCuO5W2MLFbGwM1ZGWzZLR8nhl3hjQPxcQvd97RNeG3rZfhS1/P2lGsbDTAJDq4ujHfHANNY9I+5NfOkr8EVEeWyNkYjvpBg5RExL3A1NM8hzQR7MDRKm1wIGLujOjamq9c3PgKPohPilkMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891908; c=relaxed/simple;
	bh=gh5gC3Z1OjXTLbFp2ZJcVc9T55LS+XJHUJyb09gjH40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wn5pxw5Oke8kQHadyZJ5jNGNN9Wa+cj4hcsCthKtRm8jL9PmPaElvscj0tW6OfSJrPAwHtiTP/NgtiQipmNSm5QHnieK33DcUS2MCT5LEUUw5ApE5EC7aP2MI+ScfODWukVEb7yLLEYA5SV2sC+UOV5RBSdcbZVNvc0DQWEZpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nlqkzU9F; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57MJj1oB319076;
	Fri, 22 Aug 2025 14:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755891901;
	bh=7SzRokkMKHyGOyZyYSr2/sLuIjvPVIIRRofT3eBfPO4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nlqkzU9FL/1vR1sY6j6uiHNO+Vk2bbucBnVQnSr/jE73gUXPJ9SJeJJ09VThDvETO
	 ZcbCNvV28vLskiUBfqGRs76YEIJmkrIyd/WHPLx0XM7pGbJ4Tp46tKkclzuUAqzX4X
	 q7jJWp4F174h7Z2j/s2LVb1eE98DQBTsSrJ3uqYQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57MJj1Ig3502370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 14:45:01 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 14:45:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 14:45:00 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57MJj0V3123482;
	Fri, 22 Aug 2025 14:45:00 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2: Add default PCI interrup controller address cells
Date: Fri, 22 Aug 2025 14:44:59 -0500
Message-ID: <175589187470.649734.635057180914460439.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250822133309.312189-2-krzysztof.kozlowski@linaro.org>
References: <20250822133309.312189-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof Kozlowski,

On Fri, 22 Aug 2025 15:33:10 +0200, Krzysztof Kozlowski wrote:
> Add missing address-cells 0 to the PCI interrupt node to silence W=1
> warning:
> 
>   k3-j721s2-main.dtsi:1431.3-1434.29: Warning (interrupt_map): /bus@100000/pcie@2910000:interrupt-map:
>     Missing property '#address-cells' in node /bus@100000/pcie@2910000/interrupt-controller, using 0 as fallback
> 
> Value '0' is correct because:
> 1. GIC interrupt controller does not have children,
> 2. interrupt-map property (in PCI node) consists of five components and
>    the fourth component "parent unit address", which size is defined by
>    '#address-cells' of the node pointed to by the interrupt-parent
>    component, is not used (=0)
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1] with a
minor subject line fixup. Thank you!

[1/1] arm64: dts: ti: k3-j721s2: Add default PCI interrup controller address cells
      commit: 04f1c432b7ae38415a1cf374f39954d5a612c23a

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


