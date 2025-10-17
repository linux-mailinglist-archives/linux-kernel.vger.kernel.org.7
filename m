Return-Path: <linux-kernel+bounces-857872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C4EBE81DF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB9B1AA39E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E6C3128B9;
	Fri, 17 Oct 2025 10:48:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07831770E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698081; cv=none; b=UgcTUYQ4cmqmU893ExGcVEE7ro38v//En7arg5HFvYc1RVOSbxkuNXj25m+0KzKJ+W5LKvsqdnxxfmSrD6p3Lc3G+y10zlJulKZf688SfZ0J9AX2+BbC3kVZi1ipueAiOrx+42uv8zV7lp/5gKOWh7g45sMFdqdV0uD8DLLhpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698081; c=relaxed/simple;
	bh=FiU1ZUnfZXczH1EIxaAKEC/8DAdVZLKvaIyFtsSNh94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZOBAM0WcAgkyaqSsx7WQJ75khsII1U6vBY26ei+Q8iqDHQt+XQuFI43HJIsFjCd+oWmXBlNjIhXsTPP8Hhp4j22waYN2TpfGSeQ+NSaJKlrfqgmFGn1AQIcFAzP+llD+RpBq9rZ4MROtCspewdXCajRw83UPDfGvxu/z6NiZ8WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v9hzn-0000AG-1j; Fri, 17 Oct 2025 12:47:39 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v9hzl-0042n3-0S;
	Fri, 17 Oct 2025 12:47:37 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1v9hzl-0000000F0A9-09sW;
	Fri, 17 Oct 2025 12:47:37 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>,
	Roan van Dijk <roan@protonic.nl>
Subject: [PATCH net-next v6 0/5] ethtool: introduce PHY MSE diagnostics UAPI and drivers
Date: Fri, 17 Oct 2025 12:47:27 +0200
Message-ID: <20251017104732.3575484-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

changes v6:
- rework the code to use uint instead of u32/u64
- use bitset for flags
- use nest for each separate channel
changes v5:
- add struct phy_mse_snapshot and phy_mse_config to the documentation
changes v4:
- remove -ENETDOWN as expected error value for get_mse_config() and
  get_mse_snapshot()
- fix htmldocs builds
- s/__ethtool-a-mse/--ethtool-a-mse
changes v3:
- add missing ETHTOOL_A_LINKSTATE_MSE_* yaml changes
changes v2:
- rebase on latest net-next

This series introduces a generic kernel-userspace API for retrieving PHY
Mean Square Error (MSE) diagnostics, together with netlink integration,
a fast-path reporting hook in LINKSTATE_GET, and initial driver
implementations for the KSZ9477 and DP83TD510E PHYs.

MSE is defined by the OPEN Alliance "Advanced diagnostic features for
100BASE-T1 automotive Ethernet PHYs" specification [1] as a measure of
slicer error rate, typically used internally to derive the Signal
Quality Indicator (SQI). While SQI is useful as a normalized quality
index, it hides raw measurement data, varies in scaling and thresholds
between vendors, and may not indicate certain failure modes - for
example, cases where autonegotiation would fail even though SQI reports
a good link. In practice, such scenarios can only be investigated in
fixed-link mode; here, MSE can provide an empirically estimated value
indicating conditions under which autonegotiation would not succeed.

Example output with current implementation:
root@DistroKit:~ ethtool lan1
Settings for lan1:
...
        Speed: 1000Mb/s
        Duplex: Full
...
        Link detected: yes
        SQI: 5/7
        MSE: 3/127 (channel: worst)

root@DistroKit:~ ethtool --show-mse lan1
MSE diagnostics for lan1:
MSE Configuration:
        Max Average MSE: 127
        Refresh Rate: 2000000 ps
        Symbols per Sample: 250
        Supported capabilities: average channel-a channel-b channel-c
                                channel-d worst

MSE Snapshot (Channel: a):
        Average MSE: 4

MSE Snapshot (Channel: b):
        Average MSE: 3

MSE Snapshot (Channel: c):
        Average MSE: 2

MSE Snapshot (Channel: d):
        Average MSE: 3

[1] https://opensig.org/wp-content/uploads/2024/01/Advanced_PHY_features_for_automotive_Ethernet_V1.0.pdf

Oleksij Rempel (5):
  ethtool: introduce core UAPI and driver API for PHY MSE diagnostics
  ethtool: netlink: add ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
  ethtool: netlink: add lightweight MSE reporting to LINKSTATE_GET
  net: phy: micrel: add MSE interface support for KSZ9477 family
  net: phy: dp83td510: add MSE interface support for 10BASE-T1L

 Documentation/netlink/specs/ethtool.yaml      | 195 +++++++++
 Documentation/networking/ethtool-netlink.rst  |  82 ++++
 drivers/net/phy/dp83td510.c                   |  61 +++
 drivers/net/phy/micrel.c                      | 101 +++++
 include/linux/phy.h                           | 127 ++++++
 include/uapi/linux/ethtool.h                  |   2 +
 .../uapi/linux/ethtool_netlink_generated.h    | 109 +++++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/common.c                          |  13 +
 net/ethtool/common.h                          |   2 +
 net/ethtool/linkstate.c                       |  94 ++++
 net/ethtool/mse.c                             | 411 ++++++++++++++++++
 net/ethtool/netlink.c                         |  10 +
 net/ethtool/netlink.h                         |   2 +
 net/ethtool/strset.c                          |   5 +
 15 files changed, 1215 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/mse.c

--
2.47.3


