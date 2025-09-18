Return-Path: <linux-kernel+bounces-777752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51FB2DD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF03A7235E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E831AF38;
	Wed, 20 Aug 2025 13:10:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B6242D9E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695452; cv=none; b=QmuRkrLfwbn5Nh8G+pA4ZKTc2nqajeer0a/ZiBgbaLs3+y+R0Tk8NA5EhR2jH1M7Z5frK/50mZ4S1N5mYtpc88i2olOfrd+AVzdFSJaOGMCVkukW3jbZieqBstuQtx4oTNMVRML2sMimFhVZ1zCQ0uBYxtvjPVUib6x8P0cMsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695452; c=relaxed/simple;
	bh=yKVG4JgXuOy0kLK2+1t9JbSUAY/kx7t7yYGBQ5c+L7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bCLnIbjTtFU6KBRsHZjSraX/FRcr8A4I9JVpF/24Q1OgGsNbA5p1l9w0ndqnyQtgxCmFaoe6/hwFsluGz1qcRb2leFmIjciRfG/8Aye4gOa8Sf4P2QhRIbfemGjZfTdPoK6IYkjiy2qp1oL+kgimNeqAwIWcareWPay26xd2WAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uoiaA-0007YF-9i; Wed, 20 Aug 2025 15:10:26 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uoia8-001Fnc-2C;
	Wed, 20 Aug 2025 15:10:24 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uoia8-003atA-1s;
	Wed, 20 Aug 2025 15:10:24 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Divya.Koppera@microchip.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v3 0/3] Documentation and ynl: add flow control
Date: Wed, 20 Aug 2025 15:10:20 +0200
Message-Id: <20250820131023.855661-1-o.rempel@pengutronix.de>
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

This series improves kernel documentation around Ethernet flow control
and enhances the ynl tooling to generate kernel-doc comments for
attribute enums.

Patch 1 extends the ynl generator to emit kdoc for enums based on YAML
attribute documentation.
Patch 2 regenerates all affected UAPI headers (dpll, ethtool, team,
net_shaper, netdev, ovpn) so that attribute enums now carry kernel-doc.
Patch 3 adds a new flow_control.rst document and annotates the ethtool
pause/pause-stat YAML definitions, relying on the kdoc generation
support from the earlier patches.

Oleksij Rempel (3):
  tools: ynl-gen: generate kdoc for attribute enums
  net: ynl: add generated kdoc to UAPI headers
  Documentation: net: add flow control guide and document ethtool API

 Documentation/netlink/specs/ethtool.yaml      |  27 ++
 Documentation/networking/flow_control.rst     | 379 ++++++++++++++++++
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/phy.rst              |  12 +-
 include/linux/ethtool.h                       |  45 ++-
 include/uapi/linux/dpll.h                     |  30 ++
 .../uapi/linux/ethtool_netlink_generated.h    |  57 ++-
 include/uapi/linux/if_team.h                  |  11 +
 include/uapi/linux/net_shaper.h               |  50 +++
 include/uapi/linux/netdev.h                   | 165 ++++++++
 include/uapi/linux/ovpn.h                     |  62 +++
 net/dcb/dcbnl.c                               |   2 +
 net/ethtool/pause.c                           |   4 +
 tools/include/uapi/linux/netdev.h             | 165 ++++++++
 tools/net/ynl/pyynl/ynl_gen_c.py              |  23 ++
 15 files changed, 1018 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/networking/flow_control.rst

--
2.39.5


