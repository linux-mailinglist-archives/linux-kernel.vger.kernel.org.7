Return-Path: <linux-kernel+bounces-731211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EB7B050F6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A691691C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46F12D3A86;
	Tue, 15 Jul 2025 05:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VlhI2Y5+"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470051A254E;
	Tue, 15 Jul 2025 05:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557369; cv=none; b=qJ6jEBy2lKzvkeVLWgGJw3KAxro1Fp53uh+m1RCa3f8oDbGKdwBx2loevMQWV+x4Wm2XHABbMHxYyVTSKrTNuRkOWoZ4ufwEvkQlSmrKcbHkMyOHoIQJTEQTiluHJPHk2RfWXhl4lHHkS9ymFHrgwBTfXMX5w9l2yHGul1HsNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557369; c=relaxed/simple;
	bh=VwDFrPMREUa3DOyHoMvAqkwMe0MzIsOvkU8BqX9iXB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4TazuvuqbraGBtKZOYbCI7L1X8TgJy4sxU+UZ7Iirv88ghSnPv/VRmP0EXUEqBLntzX1dgkADinOlTb95reicuR2+WHYqf7wUzrERK1FnM6+h5ghsW0AIg4QElOyBmnLRSZjeD688RlQ5kWiEZeG7fh27QWyoRkG6+F4VUctHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VlhI2Y5+; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56F5TMXV2816970;
	Tue, 15 Jul 2025 00:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752557362;
	bh=1Sg6YHeYGi4yQZWG2m4AEtdd8BiAgP7BgQnUSkYjEUg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VlhI2Y5+D6+8I5heNwJRGORpiY7UCavO9603xgX7PlwAaQiIdxDGccUrmfQMg4bVb
	 mYq2l6KxgpZomquqlYWgi92XoeXSYzvYpMCLIwBpsQ3Va601cIqJkvxkLKYtZQMNwh
	 Taz5iV6XAI2XlvIFcr2eulvwA691U/Ir14nt0qk8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56F5TM8T1037124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 15 Jul 2025 00:29:22 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 00:29:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 00:29:21 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56F5TIFc2337840;
	Tue, 15 Jul 2025 00:29:18 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Bryan Brattlof <bb@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-am65: add boot phases to critical nodes
Date: Tue, 15 Jul 2025 10:58:59 +0530
Message-ID: <175240652599.4073742.12757905646611609157.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710-65-boot-phases-v2-0-d431deb88783@ti.com>
References: <20250710-65-boot-phases-v2-0-d431deb88783@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Bryan Brattlof,

On Thu, 10 Jul 2025 09:38:58 -0500, Bryan Brattlof wrote:
> To save precious on chip RAM space during bootup 'bootph-*' flags was
> added to the dt-schema to describe which nodes need to be present during
> each phase of the bootup process and which can be pruned to recover RAM
> space that would otherwise be wasted.
> 
> This small series adds the bootph-all flags to all the boot critical
> nodes for all boards that utilize the AM65x as well as to the AM65's
> reference board.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am65: add boot phase tags
      commit: 3302e07346fea5709621a71c2cdb93ffbef2108a
[2/2] arm64: dts: ti: k3-am654-base-board: add boot phase tags
      commit: df62b42b0f37c4fe71613383c6a083dfff7f2c86

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
Vignesh


