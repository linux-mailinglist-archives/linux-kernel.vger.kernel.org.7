Return-Path: <linux-kernel+bounces-624555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61172AA04BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 09:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5C827AD575
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD87A28468B;
	Tue, 29 Apr 2025 07:41:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1191278E47
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745912475; cv=none; b=eWPEv3LK46q3GyEx2bwiUX+atJ8HLrihh2O+lTwhoCKbAnx+hd0rcKDa7fns32/D7LMhD1lF/DgivDHAHaADfZQ2jj4gNaHmpMTJm4LHTqHPmLxN7ztliF3QSYqPfNB6EG3bzapTHwlapJicxJRZyoS8KP8MPRr/eAyG8eaglEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745912475; c=relaxed/simple;
	bh=S19/Flofel9AeUg2OHz/3Ga05JqDWZ+y0Fk5OatPor0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PVDVr6mZyfVzVOdBorwXP0Urnf9hifxYwh56jl9V565pZCI2N4MoqZvTkXpQk9xvGoKnDjlbvZgsmx4EgkTx0ll52kiPbaeTM4MQrjmOm2nGU+XkdipEGpjhqGJGXKfEdwi50dk4XMn0vlc99+C59uIwR6WfgGp2hxOyZJBBH/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9faT-0006KN-Si; Tue, 29 Apr 2025 09:41:05 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9faS-000E3B-1M;
	Tue, 29 Apr 2025 09:41:04 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9faS-00CY6U-18;
	Tue, 29 Apr 2025 09:41:04 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v3 0/4] net: selftest: improve test string formatting and checksum handling
Date: Tue, 29 Apr 2025 09:40:59 +0200
Message-Id: <20250429074103.2991006-1-o.rempel@pengutronix.de>
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

This patchset addresses two issues in the current net selftest
framework:

- Truncated test names: Existing test names are prefixed with an index,
  reducing the available space within the ETH_GSTRING_LEN limit.  This
  patch removes the index to allow more descriptive names.

- Inconsistent checksum behavior: On DSA setups and similar
  environments, checksum offloading is not always available or
  appropriate. The previous selftests did not distinguish between software
  and hardware checksum modes, leading to unreliable results. This
  patchset introduces explicit csum_mode handling and adds separate tests
  for both software and hardware checksum validation.

changes v3:
- no functional changes
- rebase against latest net-next

Oleksij Rempel (4):
  net: selftests: drop test index from net_selftest_get_strings()
  net: selftests: prepare for detailed error handling in
    net_test_get_skb()
  net: selftests: add checksum mode support and SW checksum handling
  net: selftests: add PHY loopback tests with HW checksum offload

 net/core/selftests.c | 308 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 291 insertions(+), 17 deletions(-)

--
2.39.5


