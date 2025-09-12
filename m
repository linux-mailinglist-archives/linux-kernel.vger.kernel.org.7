Return-Path: <linux-kernel+bounces-813620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2B6B54856
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D83A57AF67E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0EB28851C;
	Fri, 12 Sep 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k7dEIi2o"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEF2877C1;
	Fri, 12 Sep 2025 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670655; cv=none; b=QK4ayMf6pkXLqjIIVnK0QJ+7MHFFYfzIwb+M7ugZBVUe9P0Cv4tkH+gG2GRcLLbRt3LS2RYd0RJnK1n0A7MkXtLNoOBUmgWZbaDgs/ksoAWcqn+s6uFAHFtNP5NWB/FJ0Am9WVm6mu6sy+gILVgyzAKHLlf6xU70Kt0WFGolLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670655; c=relaxed/simple;
	bh=xHNkoqoHwX0TX4dRlZUjDWlMHlGpsEYKhGtb6jKAu1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0Mpt/wTwMGCReXECpqMj7DKEd9qGw0tELcZvYWGZWLjgRA2ZEbhlOU83UZneJZVZ+up5qkkTT26qIef1Dub6pAoLv54h1Uw1/lLhG6jjSXrM9rCIEprLU5cqrEcLU9tMmstf7rl9hjXtpxTh71GKmnzWgH+B79TFo61EJq44pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k7dEIi2o; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C9okDc1008505;
	Fri, 12 Sep 2025 04:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757670646;
	bh=00JJC95eGA+9HiqS1iD9cIi+d8wa3H1eHI7M7UBEhDw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=k7dEIi2oy/7V+x016xrssKCDh0D/Qq8H6awn2f4qhmk8DWiJ2/TtAM+AK3fRUBZ0q
	 Gm0zT6uPrCMkJRalRJShu56NVfGuOG6znYSRb1e09f6hLeW5oLklFw/Km7Fm+dZLpW
	 DB0mtbIJ/gl3onBiaZl6c7FxWpz57CF3RNaJShw4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C9ojBn1895129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 04:50:45 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 04:50:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 04:50:45 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C9ojIl3414296;
	Fri, 12 Sep 2025 04:50:45 -0500
From: Nishanth Menon <nm@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Nishanth Menon <nm@ti.com>, Moteen Shah <m-shah@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Andrew Davis <afd@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] Remove HS400 support from common
Date: Fri, 12 Sep 2025 04:50:41 -0500
Message-ID: <175766786999.26286.12984291959565660129.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250908235207.473628-1-jm@ti.com>
References: <20250908235207.473628-1-jm@ti.com>
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

On Mon, 08 Sep 2025 18:52:05 -0500, Judith Mendez wrote:
> Since eMMC HS400 has been descoped for j722s due to errata i2478 [0]
> and is supported by default for AM62Px device, remove sdhci0 node from
> common-main.dtsi and include instead only for AM62Px in am62p-main.dtsi.
> 
> Also, update the STRB value for am62p eMMC sdhci0 node.
> 
> Tested on am62p SK board.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am62p/j722s: Remove HS400 support from common
      commit: 7efc354b7fe1ac5e874d0188b3d6be88a3fa0fe4
[2/2] arm64: dts: ti: k3-am62p: Update eMMC HS400 STRB value
      commit: 9fdcc5f98141cf2f77e8778bee830190d7b71ced

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


