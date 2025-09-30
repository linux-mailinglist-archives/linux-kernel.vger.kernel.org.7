Return-Path: <linux-kernel+bounces-837620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F85BACC6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9A17A20AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9F72F8BDF;
	Tue, 30 Sep 2025 12:09:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426E1B4236
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234151; cv=none; b=e9Yr0ehbhzlyvPSjTV4do9y2YUENeOpjL6KSXH+JpNEHWZy0qb+NEJp3In4EcBHRpQrhsY3VXZOi0CwK8988epti8eDjaJE3de9Mx5RiVKpcaD5+3iyJ8LNTsQOre4EKjIzrl5lAxdzWyTW1Bop3k/nS25V19D4iL0+nPJKyz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234151; c=relaxed/simple;
	bh=FY5dKoqFeK+Kdw0kwcuXO/WXGDTuCylcabfnssvgqKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVv+nYRY8RRgLJA7Wf7OAWvyOYOywfGX+xgahvu5SS32mb6O48dEa48AGnVbccrwjWjJvTZGs2HnIbuJMLgS6UGSFnGv5RinZc2CGmsJ6lQgi2+fxWhh8tL0lGHjEYwmqXJAhD/QozoMmA1YOemHqnlAIgH4JIvcco3FczPevnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v3ZAC-0008J1-H3; Tue, 30 Sep 2025 14:09:00 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v3ZAC-001F1T-0t;
	Tue, 30 Sep 2025 14:09:00 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1v3ZAC-00000009Lhl-0rxp;
	Tue, 30 Sep 2025 14:09:00 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] regulator: forward undervoltage events downstream
Date: Tue, 30 Sep 2025 14:08:55 +0200
Message-ID: <20250930120857.2228296-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
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

This short series lets critical supply events propagate to consumers.
It introduces an opt-in helper in the core to forward
REGULATOR_EVENT_UNDER_VOLTAGE from a regulator's supply to the
consumer's notifier chain, and opts the fixed regulator in at probe.

Only under-voltage is forwarded to avoid surprises. Behavior is
unchanged unless a driver calls the helper. No DT/UAPI/ABI changes.

Oleksij Rempel (2):
  regulator: core: add infrastructure for downstream event forwarding
  regulator: fixed: opt in to downstream event forwarding

 drivers/regulator/core.c         | 113 +++++++++++++++++++++++++++++++
 drivers/regulator/fixed.c        |   7 ++
 include/linux/regulator/driver.h |   5 ++
 3 files changed, 125 insertions(+)

--
2.47.3


