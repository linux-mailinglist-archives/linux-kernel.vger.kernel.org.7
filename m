Return-Path: <linux-kernel+bounces-723393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1702CAFE65E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D864D7BDB81
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D112D59FF;
	Wed,  9 Jul 2025 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kSxayfnm"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70672957C2;
	Wed,  9 Jul 2025 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057879; cv=none; b=Oaooaf61Ncr5vEDLhpVO/rt0OLcVHLtr0U17zwonOqZ6gaJBX7SReHYeADpUTS6OOxHVKV8Wou3pKn0HdPlqMoz8AvLe2lW4vBIWlgxr8t8jWU5psAnfpS/SMup4khSJsQRgIigm3BfYb81lIeWrUnqAdkRCzB0P681MoqO2u24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057879; c=relaxed/simple;
	bh=klLWNs803hCZz95obSbW3JaAkydzFkghdbwKv4tFhMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgRElapBm9wacZ+EUaVHJoH52uJg863+zrmK9HlgIB/W/xn/5Bw0JF1jcRjsobmmqnoqXdZUh7R86T/b/Wr/4aXJDFP5xFtvZ4oJjJvGcaNo1LEaZJ2DUR/HfaZaHVJl8VnihGSXS96IMgGb32odr7QBzbcqtt2bXB23McTNJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kSxayfnm; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 569AiQsf1453753;
	Wed, 9 Jul 2025 05:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752057866;
	bh=jHGPtIS3stNvh59VAzBioQkLBG2SSTCj9st1LBQOmuk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kSxayfnmivYCyKF6GDhukYNSlMYo4zWW1RDfg5IwL7woLtQD24GV1u9yeJQUTtDKT
	 kq+ynNovT09nMfMkxNm4WTtgrV5lUGrps0+H4uFiA67UIgQakwVRZ9oxMZ/3BTcVOj
	 KLAWlzSl2LWcGtxkU4R1QYz3KFvSK2Frd+nWBo5U=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 569AiPmv1928962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 05:44:26 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 05:44:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 05:44:25 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 569AiLFA3506025;
	Wed, 9 Jul 2025 05:44:22 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Parth
 Pancholi <parth105105@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Parth Pancholi
	<parth.pancholi@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j784s4-j742s2-main-common: Add ACSPCIE1 node
Date: Wed, 9 Jul 2025 16:14:08 +0530
Message-ID: <175205778773.925763.16850623285742388487.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513152155.1590689-1-parth105105@gmail.com>
References: <20250513152155.1590689-1-parth105105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Parth Pancholi,

On Tue, 13 May 2025 17:21:55 +0200, Parth Pancholi wrote:
> The ACSPCIE1 module on TI's J784S4 SoC is capable of driving the reference
> clock required by the PCIe Endpoint device. It is an alternative to on-
> board and external reference clock generators.
> Add the device-tree node for the same.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j784s4-j742s2-main-common: Add ACSPCIE1 node
      commit: abba0c4845ea110a10b4f0dec5351fef17aaa4be

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


