Return-Path: <linux-kernel+bounces-871578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569C2C0DACB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1F83AE8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E38C30F803;
	Mon, 27 Oct 2025 12:44:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568A1E0B9C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569065; cv=none; b=bUv7s1UWJqW1oFgXgKAhAh6l/iTLZziyg/fMj8gJnBfIFZyzdtlHx+0WFC4ivOoDWscHf82jPLonZeoCw7pJADAXyr1h502bsG1WOEANago2B26SpArjAfk/xqLNED/Z7tY42aIApH1JXO/NFcc6gWGwWz6fFDsI2VGNg6SGEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569065; c=relaxed/simple;
	bh=VndImNTPGzuFFyOTE93RrPsuT4m292pnagREhJihIYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGqkwxLbHXfZBPeD9GGkAVb+T0BezZpzCvKWsPTtUTdlVvu4KTL3c+m5NgEYaL9UTcDWIgc+9fBofQUnTkS7JpMRh48B6gLNGODsTYSXFFEqUPeUWVZ4bFLQoobzq5lWdLGMtfKgeg7W7ve9ydF/9i9cfXj2r0KstqjlMGGk5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMa8-0007PM-DC; Mon, 27 Oct 2025 13:44:16 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMa8-005htR-0K;
	Mon, 27 Oct 2025 13:44:16 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMa8-000000049N8-08gZ;
	Mon, 27 Oct 2025 13:44:16 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1 0/2] regulator: pca9450: add input supply links
Date: Mon, 27 Oct 2025 13:44:13 +0100
Message-ID: <20251027124415.989301-1-o.rempel@pengutronix.de>
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

This series adds input supply definitions for the NXP PCA9450 PMIC.

Some systems detect power events such as undervoltage before the PMIC.
To allow correct propagation of such events, each regulator must define
its upstream input supply. The first patch updates the devicetree
binding to document new *-supply properties, and the second patch adds
matching .supply_name entries in the driver.

Changes in this series:
- Document INL1, INB13, INB26 and INB45 supply properties
- Link all LDO and BUCK regulators to their corresponding input groups

Oleksij Rempel (2):
  dt-bindings: regulator: nxp,pca9450: document input supplies
  regulator: pca9450: link regulator inputs to supply groups

 .../regulator/nxp,pca9450-regulator.yaml      | 15 ++++++++++
 drivers/regulator/pca9450-regulator.c         | 30 +++++++++++++++++++
 2 files changed, 45 insertions(+)

--
2.47.3


