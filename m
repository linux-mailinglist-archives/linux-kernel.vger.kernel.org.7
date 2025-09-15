Return-Path: <linux-kernel+bounces-817489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0B3B582C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2201B189EA62
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654A2288505;
	Mon, 15 Sep 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pz/8BiU3"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749024A05D;
	Mon, 15 Sep 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956037; cv=none; b=dKWUHpwpu6A3M2Q8mlXa1UCQ/V010NmzLY7DQel0d2yMzEinBLbwRXGll3EhSk+/auacAUfcYDcXrlpf0cHxn7mOJXNawD9j7OZWHOnTGTvlE/KmtnQLmOD4DK73JYydlE1VaCn70O1C+FH/wOdkxZXrooKgV9sqT3/8HUz6VII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956037; c=relaxed/simple;
	bh=Rw8Ptooz+DaDr1zdzYZlZ02TqtWpKTDn/Uq2rg0UfDY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N+d5kWflkzlGd+jCh9My7nmZRmXpDkl739Oj5ZoE6UyNGGqtrPfOT4mxwWuEIquztQZWPtYyZgCExBztR2obN4GB8TKQ1WL84UV2eD90Ks1pva97WRPHIBklXlj+IyScNVvW8KCvKOYaqCR2Oi1hVVEjjrmmHqTyL6e0HHEmEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pz/8BiU3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 006C21A0E11;
	Mon, 15 Sep 2025 17:07:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BB3F06063F;
	Mon, 15 Sep 2025 17:07:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C97F3102F2AEE;
	Mon, 15 Sep 2025 19:06:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757956025; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=XDk9clebACx0eWwjzXeVW88/n+EAp4FYWju+QG5lAfo=;
	b=pz/8BiU3Bq0bilNYsNheZ8TD9h2LMpVsJrcIfJoysead06qxd+lnj2ppgtc2WzFEBjQv73
	lbfGv4q+nkEZZSmfECsCPUQrXhIkuz/moImma95tOr+G2h5wJ9hzcEvUYskmayxOT1IOAy
	PtMlJbn3m/lnbSEUZW01LzV8qiLimxyvH41iLcH24Tw0JyXgbOLo0Wpp5Zv8bWRg4Bl/n0
	d4PK30jPCObpvhCrFsju9+SjCYu3JA05swEmCCETSxIrg7LYQ73g/oQbnMkLUgwwK6pvEV
	Cb1OBSqVQ6MsUhwOxI4BBmxg8kBev1FMDomgFSf+3iVcIalZBzPe8iJZzZNL0w==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v3 0/5] net: pse-pd: pd692x0: Add permanent
 configuration management support
Date: Mon, 15 Sep 2025 19:06:25 +0200
Message-Id: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJJHyGgC/33NQQ6CMBAF0KuQrq1pB0Rw5T2MIaWdShNpSVsJh
 nB3m7rRDYtZ/PzJ+ysJ6A0GcilW4nE2wTibQnkoiByEfSA1KmUCDE6s4SXVKOLLYze5dOhHYdH
 GTjqrKcq6YkpI5BpIAiaP2iwZvxGLkVpcIrmnZjAhOv/OqzPP/XcAYG9g5pRRJVXFoU3vlbr2z
 sWnsUfpxgzP8Iu1uxgkrOn7WrNziRLKf2zbtg9KxLq0HQEAAA==
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch series introduces a new devlink-conf uAPI to manage device
configuration stored in non-volatile memory. This provides a standardized
interface for devices that need to persist configuration changes across
reboots. The uAPI is designed to be generic and can be used by any device
driver that manages persistent configuration storage.

The permanent configuration allows settings to persist across device
resets and power cycles, providing better control over PSE behavior
in production environments.

The new uAPI support is preceded by 3 patches that do house keeping.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---
Changes in v3:
- Move on from devlink param to new devlink conf uAPI. This new uAPI
  manage device configuration stored in non-volatile memory.
- Link to v2: https://lore.kernel.org/r/20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com

Changes in v2:
- Move from sysfs interface to devlink interface for the permanent
  configuration support
- Remove the __free macro from pd692x0 driver following net policy.
- Link to v1: https://lore.kernel.org/r/20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com

---
Kory Maincent (5):
      net: pse-pd: pd692x0: Replace __free macro with explicit kfree calls
      net: pse-pd: pd692x0: Separate configuration parsing from hardware setup
      docs: devlink: Sort table of contents alphabetically
      devlink: Add devlink-conf uAPI for NV memory management
      net: pse-pd: pd692x0: Add devlink interface for configuration save/reset

 Documentation/netlink/specs/devlink.yaml          |  23 ++
 Documentation/networking/devlink/devlink-conf.rst |  22 ++
 Documentation/networking/devlink/index.rst        |  22 +-
 Documentation/networking/devlink/pd692x0.rst      |  24 ++
 MAINTAINERS                                       |   3 +
 drivers/net/pse-pd/pd692x0.c                      | 280 ++++++++++++++++++----
 include/net/devlink.h                             |  20 ++
 include/uapi/linux/devlink.h                      |   4 +
 net/devlink/Makefile                              |   3 +-
 net/devlink/conf.c                                |  31 +++
 net/devlink/netlink.c                             |   2 +-
 net/devlink/netlink_gen.c                         |  20 +-
 net/devlink/netlink_gen.h                         |   3 +-
 13 files changed, 400 insertions(+), 57 deletions(-)
---
base-commit: c237892eba83664b7265c46ffe3865a876e720ed
change-id: 20250813-feature_poe_permanent_conf-ec640dace1f2

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


