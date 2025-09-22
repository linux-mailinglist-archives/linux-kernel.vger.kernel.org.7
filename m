Return-Path: <linux-kernel+bounces-827505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEC0B91F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726CA4231B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F92E7F2A;
	Mon, 22 Sep 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAuu0+fN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB552E03FB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555122; cv=none; b=bpALX2gWbqoPwdsaDQbluUsEGf/9rmzNA0BCpAcXjPThPVIaJLiJ6hg5ZZO2XzkfisyQkc9xuZs/C7vpvgBOwJ0yahXzE4tATRPiRpgZAXjQuylH5CfQyLSSI26shPs0paUMGbyokUvttCXhWpZ4zCJ+D5/gGwFeh1wNyIXPYww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555122; c=relaxed/simple;
	bh=Si41+E/+ERxwR66glrdhy5Z3+iC7P4jh0qsSv0inztQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5KyAU238aE4Brd8ISY06r63bbzD/jw5Sf1C0npD/+0T/20VzvwKd5vyKW+/v0rxhi8TqRWiQANRBB44ZJQ0OGwIxbSWy+wA3W2saUxQGqpFEZeqB8FK5NFEnedFd41GxJ7nDAoEB7aqZaWXrWhjeDs6F1oPgz0j+GOJOLJ9VSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAuu0+fN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85656C4CEF0;
	Mon, 22 Sep 2025 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555122;
	bh=Si41+E/+ERxwR66glrdhy5Z3+iC7P4jh0qsSv0inztQ=;
	h=From:To:Cc:Subject:Date:From;
	b=QAuu0+fNDDiJ4/5ZUcZWC9LYypnflhf2/1hkeTpYZmk6iO1ryM1rMJFjJdHnRvu8a
	 KsnCX5q1KSKmiUaFfNtWy+ndRJmUjgI+jCYpHUxM0qM+GNTxd09wADBO9hV2g55tIB
	 TXkAZ/WKfSvO0NN+TgMQqL58dmAdCNZ6HLUDF1JUruO4JwaCS8Y1Um60uN7YzfovNF
	 UclLTi027l5fS4XWLEeYy95DAMOHv5cknN1sl1JLH+5Ngs3e8VZcPI3hdwCNigPHGJ
	 JwfB4pvwOeh8poT13e0p5s/8wb8rftCFAh4ld9NWF4PiR/5dk+gZ26H7P5U54PQ+hM
	 AF+BvEp0JFwTA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v0iWB-000000004He-3sPh;
	Mon, 22 Sep 2025 17:31:55 +0200
From: Johan Hovold <johan@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Michal Simek <michal.simek@amd.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/8] mtd: drop unused module aliases
Date: Mon, 22 Sep 2025 17:30:59 +0200
Message-ID: <20250922153107.16381-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fixing a device leak in the omap2 rawnand driver I noticed it had
a no longer used platform module alias.

This series drops unused module aliases from mtd drivers that never
supported anything but OF probing or that no longer do.

Johan


Johan Hovold (8):
  mtd: hyperbus: hbmc-am654: drop unused module alias
  mtd: onenand: omap2: drop unused module alias
  mtd: rawnand: atmel: drop unused module alias
  mtd: rawnand: omap2: drop unused module alias
  mtd: rawnand: pl353: drop unused module alias
  mtd: rawnand: rockchip: drop unused module alias
  mtd: rawnand: stm32_fmc2: drop unused module alias
  mtd: rawnand: sunxi: drop unused module alias

 drivers/mtd/hyperbus/hbmc-am654.c               | 1 -
 drivers/mtd/nand/onenand/onenand_omap2.c        | 1 -
 drivers/mtd/nand/raw/atmel/pmecc.c              | 1 -
 drivers/mtd/nand/raw/omap2.c                    | 1 -
 drivers/mtd/nand/raw/pl35x-nand-controller.c    | 1 -
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 1 -
 drivers/mtd/nand/raw/stm32_fmc2_nand.c          | 1 -
 drivers/mtd/nand/raw/sunxi_nand.c               | 1 -
 8 files changed, 8 deletions(-)

-- 
2.49.1


