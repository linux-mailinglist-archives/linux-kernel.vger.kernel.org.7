Return-Path: <linux-kernel+bounces-726895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C66B0127F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C39A584A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59C81B4138;
	Fri, 11 Jul 2025 05:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wbZQAC6v"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457B51AC43A;
	Fri, 11 Jul 2025 05:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752210283; cv=none; b=UnO6a1BxtPvL5lBMMxpE6rgj36+gfUK668uwtHo5RpTnsp9y7yM578YOW4vcvTqovnwylqP6bs7SwcuTtSXNwT7DMkdSdQVuLOsszCf3ippL/xQX2GQi7Dh2PNh0okUm7TU8KmY0cAdmqfKQjw/W1TYEEOH5SssfignR/81ACYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752210283; c=relaxed/simple;
	bh=li+KKQYKShXO9StLVmcaoJDHygBVV2AO7A/ZIqviLvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItLVHvu7L7QYFM0+YdYGWNY95Jq94ISR9MsmHd1M/G2fIGYeQPz9LMPVbjEihGZ3XnDMrGAUzoV6RDu9t7FMqiUiV3+/QOybAjbhG3yHCnTFZFMs6JZ6HrLd+U0XrMoqbFovqDrhBs6O5715hGswdq98GBsG6ebhy79VevD9obI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wbZQAC6v; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56B54ZIa1712262;
	Fri, 11 Jul 2025 00:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752210275;
	bh=gAtPwuJxwTw3fe5iCISNmAbzibXIDozHyZtM11bF4og=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wbZQAC6vSjt4aebmT3LmcPNONPNW95E0i0klalhjP72LcLBsgUrKMWzuYehnIA7YG
	 0NSqoRCNOO33mSbo1QrClEpLvK2w/uMjLypvIY8gDdFX6filqCCj3mN/mTDPHlA90O
	 F059Fy13u+zboEfIN4i2hQvn/YQq+wLJCH/FSUk4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56B54ZVE4178100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 11 Jul 2025 00:04:35 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 11
 Jul 2025 00:04:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 11 Jul 2025 00:04:34 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56B54VOd2876133;
	Fri, 11 Jul 2025 00:04:31 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board file
Date: Fri, 11 Jul 2025 10:34:17 +0530
Message-ID: <175205725858.918402.16357151083608277299.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707190830.3951619-1-jm@ti.com>
References: <20250707190830.3951619-1-jm@ti.com>
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

On Mon, 07 Jul 2025 14:08:30 -0500, Judith Mendez wrote:
> This moves pinmux child nodes for sdhci0 node from k3-am62x-sk-common
> to each top level board file. This is needed since we require internal
> pullups for AM62x SK and not for AM62 LP SK since it has external
> pullups on DATA 1-7.
> 
> Internal pulls are required for AM62 SK as per JESD84 spec
> recommendation to prevent unconnected lines floating.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board file
      commit: a0b8da04153eb61cc2eaeeea5cc404e91e557f6b

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


