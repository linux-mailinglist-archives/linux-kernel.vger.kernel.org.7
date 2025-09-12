Return-Path: <linux-kernel+bounces-813624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC1B5485E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3CA172726
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D88288537;
	Fri, 12 Sep 2025 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L7uEpNWM"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8028750A;
	Fri, 12 Sep 2025 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670698; cv=none; b=GqOs4OnqFJmvtnyUYVSCsfel6dhSb4og4fR8Rl2igfZX+NPzCKmNe//gFJj3Y9L9THYr+2KHx9PfKTHTMX3m3PA7Mga0reA5rRCbkVx2jBnrlfsYQhmigwWLf26le4HsUxAU/t/E6rl0DSlq7Espk9CbzALe7bst8mjlPo6DsxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670698; c=relaxed/simple;
	bh=vccwytwxwT+sC/DZHLYD8ZXeqrjXsMzFRSv23k7aQ7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNrCnaNXyQY/x+BF7hBqjltT9CWGoKpn6w6+Bn6TxKC2gjjWwqITNWQsdgbvdbQD6Lq66aXBYD1d4gDgl7TI2NUo5bihWgdo3bG7lcjONp7V1cf86Ic0qe7N/5LkQ0dW1y/NdvCrmCiP1OFv++x1Y3WTNKxZrsb/AiCOrkgxmOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L7uEpNWM; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C9pT3v1008552;
	Fri, 12 Sep 2025 04:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757670689;
	bh=ou3qQEcrPp+2Q8qjelUZkf9KXg2pIjNHfnd3X0XTk9E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=L7uEpNWMItSPR45olK4zoI584nUOd27rkIYGWQkP4XSvI3+v1fReweWX5s8cRk1dn
	 ZqhSZaSzvsFxBWbUuN+d7zEIioY7tNZ/rMCWe3+uIHkcN1SEpn2ErFDvofwKYDPjvl
	 Ig1S2Zpsb/Q17C4jrHzR7uyhODOfLIk1zN1OChLk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C9pT5O1219985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 04:51:29 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 04:51:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 04:51:29 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C9pTAS3719374;
	Fri, 12 Sep 2025 04:51:29 -0500
From: Nishanth Menon <nm@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stefano
 Radaelli <stefano.radaelli21@gmail.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 0/3] Add support for Variscite VAR-SOM-AM62P5 and Symphony board
Date: Fri, 12 Sep 2025 04:51:25 -0500
Message-ID: <175766787211.26844.14791319461065184194.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250909213749.28098-1-stefano.radaelli21@gmail.com>
References: <20250909213749.28098-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Stefano Radaelli,

On Tue, 09 Sep 2025 23:37:38 +0200, Stefano Radaelli wrote:
> This patch series adds support for the Variscite VAR-SOM-AM62P system on module
> and the Symphony carrier board.
> 
> The VAR-SOM-AM62P is a compact SOM based on the TI AM62P Sitara processor,
> featuring up to 8GB DDR4 memory, eMMC storage, Gigabit Ethernet, and various
> peripheral interfaces. The Symphony board is a feature-rich carrier board that
> showcases the SOM capabilities.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
      commit: 03c7b1f0ee9f7c8d047a6ea5767ac96490d1385c
[2/3] arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P
      commit: 571562e76458682231453a561d5df0c8e91c461d
[3/3] arm64: dts: ti: var-som-am62p: Add support for Variscite Symphony Board
      commit: e402a3f1d9681d4b0be4568b5f318b3c3bc804bf

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


