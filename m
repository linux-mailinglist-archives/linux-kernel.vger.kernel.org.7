Return-Path: <linux-kernel+bounces-731212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32568B050F7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A84016835A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F3A2D46C7;
	Tue, 15 Jul 2025 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hXTxYMqo"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25CC2D3EE3;
	Tue, 15 Jul 2025 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557373; cv=none; b=VNnQ19yuAoDWtkBfbMuMnesjZHy6Yrrbe+zRMEru2F9efyEHiFeuMfTz3sPqwe+LtDavFDzP3ncjhjGQmexiz93lhrbJEo0rdIIzW4poafw/WRH0AeS8yyCTWjNiEzhDXe5C8ZyXgtms6ZWiVYAAfFYbsLnBhHF9nEUr7RCBDW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557373; c=relaxed/simple;
	bh=EmcFd9If01Ptrm1+NDGW0avhFBg6kBR+QdXkzZT0NpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXcIcy3mF3HO7DlUXffGxpWtiXgLWWymTXNIOkzCjqo8jzoyWI7LDuOHXH80iDlsmZpu8wxVb/LJCluAOqx6Ou3mtscmGQt8PCiVml8ehCv5CbDgMsvqAKOLN58oOh0sjLH7eXNjyp3I7apfOWA28L4IxKmVRvrUKjisgVE/ZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hXTxYMqo; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56F5TR0c2771537;
	Tue, 15 Jul 2025 00:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752557367;
	bh=wqv6Z1egGGiJqpn1LoPFiVDxqgCPwJ2jW4Su+cvtpSM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hXTxYMqo2sCGeZOaUvDckTBkTMF4a5EoFivXpW8NMpsPaeAFCVtKLwQ2Gas9VyEUj
	 65SrJ/a2SFasE1M1jBf5024yKlNkvSyhKCJC7/LGyptfRf9nea7DwAYxFHyRUM8yfx
	 Uv0uRDRVTm8qyp/67ljKPCgrYulcagW1wrJanwJ8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56F5TRvJ1037133
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 15 Jul 2025 00:29:27 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 00:29:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 00:29:26 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56F5TIFd2337840;
	Tue, 15 Jul 2025 00:29:23 -0500
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
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62a7-sk: add boot phase tags
Date: Tue, 15 Jul 2025 10:59:00 +0530
Message-ID: <175240652599.4073742.7893826610210923370.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710-62a-uboot-cleanup-v2-1-9e04a7db1f54@ti.com>
References: <20250710-62a-uboot-cleanup-v2-1-9e04a7db1f54@ti.com>
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

On Thu, 10 Jul 2025 07:03:10 -0500, Bryan Brattlof wrote:
> The 'bootph-all' tag was added to the dt-schema to describe the various
> nodes used during the different phases of bootup with DT. Add the
> bootph-all tag to all nodes that are used during the early stages of
> bootup by the bootloaders.
> 
> This includes the console UART along with the SD and eMMC nodes and its
> required regulators for the 3v3 to 1v8 transition and the various nodes
> for Ethernet booting.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62a7-sk: add boot phase tags
      commit: 289c5862b6c8984bbe840a6cd590225c6dd271f3

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


