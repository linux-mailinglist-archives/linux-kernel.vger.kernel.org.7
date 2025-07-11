Return-Path: <linux-kernel+bounces-726898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 697B3B01286
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F312B18964FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320BE1B4233;
	Fri, 11 Jul 2025 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XtiAB7YD"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88021AC43A;
	Fri, 11 Jul 2025 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752210372; cv=none; b=pcDO9mcZH5dkTmncmZB84U3ZSGsSUWjvJIE2Ao91ESeenNZ/i/2xgXtLi3Ja+lSCvSuhKW9ndlxNDVl/e9vaNejgTXKkU3up3pnggm94XzKdITil9H8WLlho6/KlByHHIhBZq2JRJxDkh+t9Bu79cfIrVnXgo+OF/SyToT8aU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752210372; c=relaxed/simple;
	bh=cbja0iTTo78l0yM30+jBfuW9rnuMRbFrSQ3/FZQKJII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtJdhkqH3GbkFxDB1hNEqIxGDwXriU0FZpP1BK+D0koyw5z6MW7oRxZHiXp2dBRfSYpj4ieRdBZtvVfUwLJpn01zbJ/Wp4no1niEJcSPQZK2nyfb+YOPI2SNRf2XQB3RVWJzdfWL6KbmUSegE5psx1zh4be285CZlDLUPW+VlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XtiAB7YD; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56B560NJ1936309;
	Fri, 11 Jul 2025 00:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752210360;
	bh=9a1qT38KzNKFqzHT4jH1u+Pmf2ewvv8eOtT7trCzsPE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XtiAB7YD8hutz45qXPzIln6ujJHr2nHXiphGUoTPD8mCkUDZbyZbsd3biUZ2ryXDn
	 S+kf1MSljwCyh38iq/F4oWYFOTfaBUVVLPB3PxhqWucGwqcTtxDORBQ7R4zeBt0z6g
	 kC/9vRrSOmNQvWT8XcAfyZ9JYsY+/YtmKpD4If1Y=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56B560ZO3708141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 11 Jul 2025 00:06:00 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 11
 Jul 2025 00:06:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 11 Jul 2025 00:05:59 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56B55uIj2878323;
	Fri, 11 Jul 2025 00:05:56 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joao Paulo Goncalves
	<joao.goncalves@toradex.com>
Subject: Re: [PATCH 0/2] arm64: dts: ti: k3-am62p|j722s: Add passive trip points
Date: Fri, 11 Jul 2025 10:35:41 +0530
Message-ID: <175205768444.924566.10610235115148189827.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623-b4-verdin-am62p-cooling-device-v1-0-cc185ba5843d@toradex.com>
References: <20250623-b4-verdin-am62p-cooling-device-v1-0-cc185ba5843d@toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi João Paulo Gonçalves,

On Mon, 23 Jun 2025 13:12:25 -0300, João Paulo Gonçalves wrote:
> Enable CPU frequency throttling on AM62P/J722S when an alert temperature
> threshold is reached before the critical temperature for shutdown.
> 
> Adjust Verdin AM62P thermal threshold accordingly to the SoM
> thermal specification.
> 
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am62p-j722s: Enable freq throttling on thermal alert
      commit: f02dccbe9641c4be467d22f4d5712523d902e94d
[2/2] arm64: dts: ti: k3-am62p-verdin: Adjust temperature trip points
      commit: 3b08f8a34a2061d89a2411d04a675b3860d4f9cc

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


