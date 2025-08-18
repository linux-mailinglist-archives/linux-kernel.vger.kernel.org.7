Return-Path: <linux-kernel+bounces-773237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719EBB29D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2744205773
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23C330C36A;
	Mon, 18 Aug 2025 09:02:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A45224B1B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507758; cv=none; b=TuYP4cVZWHAVAb1eh9G0ngHhuZbKsFdPyUUF1bo9N2iwldfD+xs4Ik2buiG4bCfUeNcE5KrEFvoEVhsEgRJefsCVHc2hakXpRC6vRPuRAaYWfypM0j0+GN2SvK/Z1HO9AilZ3wn4xoeNRC2bVonxkXFMbhAR+TpKlMn+6HCpx14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507758; c=relaxed/simple;
	bh=vwWq2gQjuhdr2jRIjEhG3Jn96WIa3/SjAzzadW8kWnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mv6L9FDGh5zRbL6JGWkr+ZwU3UUXtaYH4y2OLHzZeDqxSo1y7B2CKp9NBWN5kdT7x08I/IJKaOLHpEALZjIIPdb3pjiu47L5T9YdR0kXQxBs+lGpMEIh1n+na+yUZznTkFQwsNnRrvSYzqrhA05BnKZf/xLrBrIE5Hb3iTaAogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1unvky-0003N2-Rd; Mon, 18 Aug 2025 11:02:20 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1unvkw-000sBB-2F;
	Mon, 18 Aug 2025 11:02:18 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1unvkw-00Bhgg-1y;
	Mon, 18 Aug 2025 11:02:18 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v1 0/3] stmmac: stop silently dropping bad checksum packets
Date: Mon, 18 Aug 2025 11:02:14 +0200
Message-Id: <20250818090217.2789521-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi all,

this series reworks how stmmac handles receive checksum offload
(CoE) errors on dwmac4.

At present, when CoE is enabled, the hardware silently discards any
frame that fails checksum validation. These packets never reach the
driver and are not accounted in the generic drop statistics. They are
only visible in the stmmac-specific counters as "payload error" or
"header error" packets, which makes it harder to debug or monitor
network issues.

Following discussion [1], the driver is reworked to propagate checksum
error information up to the stack. With these changes, CoE stays
enabled, but frames that fail hardware validation are no longer dropped
in hardware. Instead, the driver marks them with CHECKSUM_NONE so the
network stack can validate, drop, and properly account them in the
standard drop statistics.

[1] https://lore.kernel.org/all/20250625132117.1b3264e8@kernel.org/

Oleksij Rempel (3):
  net: stmmac: Correctly handle Rx checksum offload errors
  net: stmmac: dwmac4: report Rx checksum errors in status
  net: stmmac: dwmac4: stop hardware from dropping checksum-error
    packets

 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 8 ++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   | 2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 3 ++-
 4 files changed, 11 insertions(+), 3 deletions(-)

--
2.39.5


