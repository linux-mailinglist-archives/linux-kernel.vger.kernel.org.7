Return-Path: <linux-kernel+bounces-746072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99481B122D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DECA1CE5364
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48162EFD9F;
	Fri, 25 Jul 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJgEUy3I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197162EF2B7;
	Fri, 25 Jul 2025 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463655; cv=none; b=UtBCtfpcSJvWWzkVBQjagvyiUpl0WqyTVGQonHD/fdYvx3K2/UmXLBB+nu9EiKRbIE9UQqVlwCnFgNsFf6amHGlwfxF/7Gc8kDPl3do9g+UFrlyzCvb3P4uAD70a3KLpOfGtt8Dvix3q/1GktmF+KA9bx1vOCTKfELowdh2/MLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463655; c=relaxed/simple;
	bh=re11S+8tEIqumSpDL6H1rj102o30u8YGPUHXIsZC5kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZF5D0czoeXLmLRiqSp2f7fISVifdimY6+NdFEgAnfc6cB0CKDJuaGeherUFhOtxHtOWRLbesKqvPllemse5TucPnehfPG150rTqeJxrFN7/RN8vAA/Byy+DDo10jjZx9Xg8NA1lav0Ha/tf728tVVOUHweEmnxGI49SoawqbdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJgEUy3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51FDC4AF09;
	Fri, 25 Jul 2025 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753463654;
	bh=re11S+8tEIqumSpDL6H1rj102o30u8YGPUHXIsZC5kQ=;
	h=From:To:Cc:Subject:Date:From;
	b=kJgEUy3Imdjsuw91viPX8c8gaBRYRt4bL7YSdv6zJ3WZgdij2GElV+409kOiwRE1W
	 2eIiuHUAAl+c69S3vgJ48bsijUWVZ1b2Dn7wFXh6Z8fm58GD/zZKP71AxSrAo6LiSy
	 Sng9eCdlOWbvx9e2Z9jmsFZZ33iMQecx9auRvcfw4l9aR2zwyQDFbOlCLQYioLL9Gx
	 HaLM520HJvbfp6zoLO0tdbtZbEu/VK81WQ97besWCDJFL5WMMX6/SAjNaHyldtpPVo
	 KvtqvG1k+zSynY7sZtmupbM5d0uhX9aMHvH5xcgDB0nTbFC+ec02VGRJvfgsq+oCC4
	 pe28SmQiQ3PuA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ufLzm-000000000Gh-34a4;
	Fri, 25 Jul 2025 19:14:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/5] net: ethernet: fix device leaks
Date: Fri, 25 Jul 2025 19:12:08 +0200
Message-ID: <20250725171213.880-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes devices leaks stemming from failure to drop the
reference taken by of_find_device_by_node().

Johan


Johan Hovold (5):
  net: dpaa: fix device leak when querying time stamp info
  net: enetc: fix device and OF node leak at probe
  net: gianfar: fix device leak when querying time stamp info
  net: mtk_eth_soc: fix device leak at probe
  net: ti: icss-iep: fix device and OF node leaks at probe

 .../ethernet/freescale/dpaa/dpaa_ethtool.c    |  4 +++-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 14 +++++++++--
 .../net/ethernet/freescale/gianfar_ethtool.c  |  4 +++-
 drivers/net/ethernet/mediatek/mtk_wed.c       |  1 -
 drivers/net/ethernet/ti/icssg/icss_iep.c      | 23 +++++++++++++++----
 5 files changed, 36 insertions(+), 10 deletions(-)

-- 
2.49.1


