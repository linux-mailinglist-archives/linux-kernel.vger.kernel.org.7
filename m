Return-Path: <linux-kernel+bounces-731214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B9AB050FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726613BD4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27DB2D5410;
	Tue, 15 Jul 2025 05:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kyma2SYp"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B863F2D3EDF;
	Tue, 15 Jul 2025 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557383; cv=none; b=XKo8dxj1bk+M+dzw9gT6XR12mCC4b5ruKwRrp6QAihKjnbsEW0HebE3Q8LQBI6ZvFMFD3V/vFWK9d5SCvVuKOGdWKrLqk1crDcZSmO531wE7EmTccKxM73HHAUXWQuBNIEwebt762hxwMfFdFy9TvMQUJWZmRQJ/QItVgfNg96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557383; c=relaxed/simple;
	bh=KaqUIsDeZAwrYbDxKxMit35I8BEJxBnNA0LJJgJj+eA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cR0OdRMvw6WmK5rOPDlgjWeXItquJGo3vVKILthzy5YeParVeSkvVV3SUhdmq0xkQqZXGLezMsRvqtWRPMQxqI9BoqdyrH/ZJps5iWF4KjeSk87RziE/1jD+3z89yMEcEq4JuI0d7lGpdDhSaKuy0AtFeL2ZmY3XycIn15oIhL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kyma2SYp; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56F5TVxC2538631;
	Tue, 15 Jul 2025 00:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752557371;
	bh=9RSokxMgEP4SOqdc2oKnXwxbmD35sLZH2NssOeX5TYA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Kyma2SYpcsdwOfmX47sjUk/4Ey5nnBccs37/vQatgGiH7u8eViLNdSL9lViAjf8+m
	 JUJREQGA7Rj7yrcL9FsPMgU89WvmaozrAt9TRcjdp6dHmCPTtM6Fr1h+i9wRR+zOTb
	 P+S5sjn2Gbu0RaT0SCk6hZ51UZZm62G4va8mk+KA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56F5TVhM361777
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 15 Jul 2025 00:29:31 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 00:29:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 00:29:30 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56F5TIFe2337840;
	Tue, 15 Jul 2025 00:29:27 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>, Chintan Vankar
	<c-vankar@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <s-vadapalli@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 0/4] Add bootph-all property to enable Ethernet boot
Date: Tue, 15 Jul 2025 10:59:01 +0530
Message-ID: <175240652598.4073742.14558391406301903223.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250709105326.232608-1-c-vankar@ti.com>
References: <20250709105326.232608-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Chintan Vankar,

On Wed, 09 Jul 2025 16:23:22 +0530, Chintan Vankar wrote:
> This series adds bootph-all property to necessary nodes to enable
> ethernet boot support for SK-AM68, AM62P5-SK, J722S, and SK-AM69.
> 
> This series is based on commit '58ba80c47402' of linux-next tagged
> next-20250708.
> 
> Link to v5:
> https://lore.kernel.org/r/20250708084252.1028191-1-c-vankar@ti.com/
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am68-sk-base-board: Add bootph-all property to enable Ethernet boot
      commit: 7cc984fb30d5c2a780fee0f4b2d4ad2001961c6b
[2/4] arm64: dts: ti: k3-am62p5-sk: Add bootph-all property to enable Ethernet boot
      commit: d6ad164e05844be63210900536108812aa00d2fe
[3/4] arm64: dts: ti: k3-j722s-evm: Add bootph-all property to enable Ethernet boot
      commit: ab9ec669cf74b6499c0de4f42a6dd756a4e4e2a1
[4/4] arm64: dts: ti: k3-am69-sk: Add bootph-all property to enable Ethernet boot
      commit: 89a0284bf92e498c8d24a4ce37949eaf4a5101a9

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


