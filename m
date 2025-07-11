Return-Path: <linux-kernel+bounces-726894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58886B0127D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84054A767E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A571B4138;
	Fri, 11 Jul 2025 05:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YZOzLIDb"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4A185C5E;
	Fri, 11 Jul 2025 05:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752210266; cv=none; b=iyt3meKmB6ZdqOHgop/6qagc4Xo7lgJ3zGMIikqRFu8tUG/2c3hdIbOwMWIKNoLH+h3tyiaXBYOR30gPaPm0qicvz36PeUpOvF02lJxFiVbO27OgT0fvaqpts0nN4H6njvkMzMaVQ7k89sV08BOAIlMOfI8r3sPYlywKaYO/Isw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752210266; c=relaxed/simple;
	bh=Pnu+se39CHNEXS18JK+1Rax118MmlTC+cG4KSINH+lo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bn5gWPh/yApr1MpJdfeJs/7JsqmhkLyP8C2TJvtP3qUdO1CbI1LQxYIz37ddd3RiOS21NXH4pYBZm8U8O4Q3rO/wVFOejslj45TvwlAAFcCwFOeLg59H82bG4wfRH76gWYR0F7sgvntJlFpnuQ332kiw4eYA9G2pgyBt9SdBdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YZOzLIDb; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56B54JTk1345674;
	Fri, 11 Jul 2025 00:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752210259;
	bh=59F/wbLVw9RX8vZDA3ieRVFIxpjqaRAIon2IYyvu+0c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YZOzLIDb4ETfgi4L5jvvbwA2QX+wLqWSyZGLOAxgZzORvmT8/HS9MwXPIvQki2uog
	 SOKaQBuDzRByIibpkCp+rjGe0LL/CUaFaUCsS5zd/n7yQLCsxnH9hmRBdxvcALDPTG
	 OUSHt1G/lcCkbaMVbsNX5Ehq7XJ5PqDlOVsSaCI8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56B54J4H4178005
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 11 Jul 2025 00:04:19 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 11
 Jul 2025 00:04:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 11 Jul 2025 00:04:18 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56B54FFF2875859;
	Fri, 11 Jul 2025 00:04:16 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR support
Date: Fri, 11 Jul 2025 10:34:02 +0530
Message-ID: <175205725858.918402.16645352321440429421.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707191250.3953990-1-jm@ti.com>
References: <20250707191250.3953990-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Judith Mendez,

On Mon, 07 Jul 2025 14:12:50 -0500, Judith Mendez wrote:
> For eMMC, High Speed DDR mode is not supported [0], so remove
> mmc-ddr-1_8v flag which adds the capability.
> 
> [0] https://www.ti.com/lit/gpn/am625
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR support
      commit: 265f70af805f33a0dfc90f50cc0f116f702c3811

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


