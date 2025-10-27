Return-Path: <linux-kernel+bounces-871580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3DBC0DA4D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE87118868FF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A17A1E0B9C;
	Mon, 27 Oct 2025 12:44:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE02330F7E2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569066; cv=none; b=KsbvXUDUYDlDvyncJQYEjAfa4Zv75O0asK1161HcWdN0dzMS6YRQHh+R6f9rsuL+HrkC6voEuLbTYVhuUyhzgklIjT5ImVb4UVwSfTxPBKT2O4cEd+t7LVWe12NK6N+Z1P7tan7O5gRT8LywGyUuf19SRdDoVbDGPH2wCXLnruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569066; c=relaxed/simple;
	bh=c7vwf2FAViYNdktynom/5hESo4YAfTJM0FR/0wD90/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPTElAVRO48GoznXuhmvXAZleqcNaal6IuSjsL9lBIzT7ZOAaRQq0tUaBC1dJEGrM9vQP/OZpWBjsgF5SXsB3Px2+hkCwXlxGqzswdO0rtMB9QJdpND/Ae+KesheDQzNM23BSeHNt6rrN40GqaZmLizSq+RF43qIz94Mm97x9oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMa8-0007PO-DC; Mon, 27 Oct 2025 13:44:16 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMa8-005htT-0X;
	Mon, 27 Oct 2025 13:44:16 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMa8-000000049NS-0O8x;
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
Subject: [PATCH v1 2/2] regulator: pca9450: link regulator inputs to supply groups
Date: Mon, 27 Oct 2025 13:44:15 +0100
Message-ID: <20251027124415.989301-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027124415.989301-1-o.rempel@pengutronix.de>
References: <20251027124415.989301-1-o.rempel@pengutronix.de>
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

Add supply_name entries for all PCA9450 regulators to describe their
respective input pin groups (INB13, INB26, INB45, INL1). This links each
buck and LDO to the upstream supply that powers its input group.

On some systems, power faults such as undervoltage are detected before
the PMIC itself. Defining supply relationships allows the regulator
framework to propagate such events properly through the dependency
chain.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/regulator/pca9450-regulator.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 4be270f4d6c3..247f12df8974 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -355,6 +355,7 @@ static struct pca9450_regulator_desc pca9450a_regulators[] = {
 	{
 		.desc = {
 			.name = "buck1",
+			.supply_name = "inb13",
 			.of_match = of_match_ptr("BUCK1"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK1,
@@ -388,6 +389,7 @@ static struct pca9450_regulator_desc pca9450a_regulators[] = {
 	{
 		.desc = {
 			.name = "buck2",
+			.supply_name = "inb26",
 			.of_match = of_match_ptr("BUCK2"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK2,
@@ -421,6 +423,7 @@ static struct pca9450_regulator_desc pca9450a_regulators[] = {
 	{
 		.desc = {
 			.name = "buck3",
+			.supply_name = "inb13",
 			.of_match = of_match_ptr("BUCK3"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK3,
@@ -454,6 +457,7 @@ static struct pca9450_regulator_desc pca9450a_regulators[] = {
 	{
 		.desc = {
 			.name = "buck4",
+			.supply_name = "inb45",
 			.of_match = of_match_ptr("BUCK4"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK4,
@@ -478,6 +482,7 @@ static struct pca9450_regulator_desc pca9450a_regulators[] = {
 	{
 		.desc = {
 			.name = "buck5",
+			.supply_name = "inb45",
 			.of_match = of_match_ptr("BUCK5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK5,
@@ -502,6 +507,7 @@ static struct pca9450_regulator_desc pca9450a_regulators[] = {
 	{
 		.desc = {
 			.name = "buck6",
+			.supply_name = "inb26",
 			.of_match = of_match_ptr("BUCK6"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK6,
@@ -526,6 +532,7 @@ static struct pca9450_regulator_desc pca9450a_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo1",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO1"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO1,
@@ -544,6 +551,7 @@ static struct pca9450_regulator_desc pca9450a_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo2",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO2"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO2,
@@ -562,6 +570,7 @@ static struct pca9450_regulator_desc pca9450a_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo3",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO3"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO3,
@@ -580,6 +589,7 @@ static struct pca9450_regulator_desc pca9450a_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo4",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO4"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO4,
@@ -598,6 +608,7 @@ static struct pca9450_regulator_desc pca9450a_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo5",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO5,
@@ -623,6 +634,7 @@ static struct pca9450_regulator_desc pca9450bc_regulators[] = {
 	{
 		.desc = {
 			.name = "buck1",
+			.supply_name = "inb13",
 			.of_match = of_match_ptr("BUCK1"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK1,
@@ -656,6 +668,7 @@ static struct pca9450_regulator_desc pca9450bc_regulators[] = {
 	{
 		.desc = {
 			.name = "buck2",
+			.supply_name = "inb26",
 			.of_match = of_match_ptr("BUCK2"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK2,
@@ -689,6 +702,7 @@ static struct pca9450_regulator_desc pca9450bc_regulators[] = {
 	{
 		.desc = {
 			.name = "buck4",
+			.supply_name = "inb45",
 			.of_match = of_match_ptr("BUCK4"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK4,
@@ -713,6 +727,7 @@ static struct pca9450_regulator_desc pca9450bc_regulators[] = {
 	{
 		.desc = {
 			.name = "buck5",
+			.supply_name = "inb45",
 			.of_match = of_match_ptr("BUCK5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK5,
@@ -737,6 +752,7 @@ static struct pca9450_regulator_desc pca9450bc_regulators[] = {
 	{
 		.desc = {
 			.name = "buck6",
+			.supply_name = "inb26",
 			.of_match = of_match_ptr("BUCK6"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK6,
@@ -761,6 +777,7 @@ static struct pca9450_regulator_desc pca9450bc_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo1",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO1"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO1,
@@ -779,6 +796,7 @@ static struct pca9450_regulator_desc pca9450bc_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo2",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO2"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO2,
@@ -797,6 +815,7 @@ static struct pca9450_regulator_desc pca9450bc_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo3",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO3"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO3,
@@ -815,6 +834,7 @@ static struct pca9450_regulator_desc pca9450bc_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo4",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO4"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO4,
@@ -833,6 +853,7 @@ static struct pca9450_regulator_desc pca9450bc_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo5",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO5,
@@ -854,6 +875,7 @@ static struct pca9450_regulator_desc pca9451a_regulators[] = {
 	{
 		.desc = {
 			.name = "buck1",
+			.supply_name = "inb13",
 			.of_match = of_match_ptr("BUCK1"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK1,
@@ -886,6 +908,7 @@ static struct pca9450_regulator_desc pca9451a_regulators[] = {
 	{
 		.desc = {
 			.name = "buck2",
+			.supply_name = "inb26",
 			.of_match = of_match_ptr("BUCK2"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK2,
@@ -918,6 +941,7 @@ static struct pca9450_regulator_desc pca9451a_regulators[] = {
 	{
 		.desc = {
 			.name = "buck4",
+			.supply_name = "inb45",
 			.of_match = of_match_ptr("BUCK4"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK4,
@@ -942,6 +966,7 @@ static struct pca9450_regulator_desc pca9451a_regulators[] = {
 	{
 		.desc = {
 			.name = "buck5",
+			.supply_name = "inb45",
 			.of_match = of_match_ptr("BUCK5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK5,
@@ -966,6 +991,7 @@ static struct pca9450_regulator_desc pca9451a_regulators[] = {
 	{
 		.desc = {
 			.name = "buck6",
+			.supply_name = "inb26",
 			.of_match = of_match_ptr("BUCK6"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_BUCK6,
@@ -990,6 +1016,7 @@ static struct pca9450_regulator_desc pca9451a_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo1",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO1"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO1,
@@ -1008,6 +1035,7 @@ static struct pca9450_regulator_desc pca9451a_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo3",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO3"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO3,
@@ -1026,6 +1054,7 @@ static struct pca9450_regulator_desc pca9451a_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo4",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO4"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO4,
@@ -1044,6 +1073,7 @@ static struct pca9450_regulator_desc pca9451a_regulators[] = {
 	{
 		.desc = {
 			.name = "ldo5",
+			.supply_name = "inl1",
 			.of_match = of_match_ptr("LDO5"),
 			.regulators_node = of_match_ptr("regulators"),
 			.id = PCA9450_LDO5,
-- 
2.47.3


