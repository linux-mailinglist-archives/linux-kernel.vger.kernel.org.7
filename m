Return-Path: <linux-kernel+bounces-801186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93B5B440EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A325E17BCEF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12EA2D59EF;
	Thu,  4 Sep 2025 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RrIe1z6J"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6C22857C1;
	Thu,  4 Sep 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000677; cv=fail; b=W0aMx3FOs9hUyPSJ/b1HYcaTG2OmFYIrgJVazmQFzzEA++33uNXKmYkChnZQEQeM39+sX0A8n5S/dPfs26n/Sde2GXUMdqaMfUwBKgTe5jQ/H3SDmreEkH8AJ0W2sU3PQjuElyirrT8m9Ns1ecKOujPsZt7Ja5toNTHsWnHxPXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000677; c=relaxed/simple;
	bh=W/2DYoPSOtqQkeoK+Eg22PINwXU4yUQuBl6zjHzkfZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PuTBfmDEIDxBtAbkrWNwqar/+6iahPQ9JlPsUSiQWhoMWbzZK88gK2pTC3BlsXOzA+ZkVM5wxrDjolLaWei1Al92d9H9S1c1s8I9VV2KkWZzVlt2vqNiLe8xOJbnR768tNTMi3SMGo8df8Qg35u7RtzxtdjUlECEdRJdXe6Orw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RrIe1z6J; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGF097sOXy/IPLP92/QALZ60RbPC/hQsuqWmu5zmU7NhEbKLjAcOQjVfYYkOYRIoPlaOyHkk9u6t7TOzfJ08zuWQrfedOCb+B7cr3p0ZM1mxHx7TxAq+DUnN+WrGXChu7UHnbKj8TFTMFSulEUm1WYecr/ffQNktVFVswIVCyoel8VvyOwOTgmqoyStTcb1etxRGh8ihxDk92tkXigxAJbSZb1LLcjKad0XezYgi1W39XJtSmGrncXB/ho33E7cBXCQCgnuzhS5YkFkPi6yCs1+TDeAlG207WDjhRCsyoI4Jf/9n8oB2s4rj82geBqotkDiDQTbAuEA8U5fPnWzV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFfnmJ/ZnbtgMyoO1qKYPTH4RqSNYZ3QCzDU5lKpP1w=;
 b=tLTm+BBZfBwc/xdkiSZIxio7iQypUgsGZANEk1U1TbY7QuFoTxQhkzs+21bI6Xo0Frd+YzK2oA8Xx3woMj0BlaJBg6LylkDrsaRnVM1gnnEauVt8O0JZaiZfqW9Muw05qJRV2Dh2HwRQfVLT7kfAD6L4bfCSiiP+gfe8iiULpOTSxv0AGCyFAKgih0Dl3xICQVtu0TNiHHVGUVjv/GHzVxnlou9ns2Jp6K+8kmzXJyATx+NkWTnya1D5UeSbE3H3f+a0fsGmRelvPnkM2F76M5CaH/qr4oR3vsm71sSjWkI2ztA21rUPr/UFDENZHevuLGCoKkobDMWmr6Cp4sQ1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFfnmJ/ZnbtgMyoO1qKYPTH4RqSNYZ3QCzDU5lKpP1w=;
 b=RrIe1z6JifZ1huPcUJvaa5Ar9ZMmlajigVYph5frjB6+gYJh88yvMW6bixKOwWetMM4en6ePueWg+xa9Qdy0GbhuCESjaU2G0VfmWDMobi8SmDIfb8jQjY4fhX738Ao5D1lyEv/wNHr9jKes8aw06/tthj/bq/sePG0PwhUjgfhbiulUYjgf8eZxe796Q6HSkfk0wdnFSu5iqc08RZfc9UKJ6ISM8NdPtSY1uD98jIS/jqhOAgIjOnQIXHhwXK8GfORgBPR/CnJwqqVamsCnFTyd16troRCt+gXLrFh0KbDNLqekTAT1AEb/Iz6LN4g0OrRZNBuBvekQFj0JcZ8TRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB7635.eurprd04.prod.outlook.com (2603:10a6:20b:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 15:44:21 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 15:44:21 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH phy 14/14] phy: lynx-28g: probe on per-SoC and per-instance compatible strings
Date: Thu,  4 Sep 2025 18:44:02 +0300
Message-Id: <20250904154402.300032-15-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904154402.300032-1-vladimir.oltean@nxp.com>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0060.eurprd03.prod.outlook.com (2603:10a6:208::37)
 To AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: d99ab2df-2f57-4412-990e-08ddebc9ea4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hCfSH2TKIoyJZvb9hEgzc5eMScbnI2Zd738O//HW2qJPGNL0cntrZ4LsY1Qt?=
 =?us-ascii?Q?5j6YceWNEwKk0D2tu3YdsOLGUlbnra3QJgPUoUgMvucLbM5r+PoQDQb8CEgn?=
 =?us-ascii?Q?XA4vJHrb8kZWtQLwJinURRlYun2DsxCb2n6W582TuKMTrNBXbBRDNpIWY9uh?=
 =?us-ascii?Q?Zw2f7MITuGr1W7tdOaoxESgvuQ46wxQN2LpxBpIZI39t4XrXmik5qgVAiNOt?=
 =?us-ascii?Q?8dQXvl+UgoYCUU+QON01sI6oUOZfHZA8RdUXleYN+5GnpiRn4Uz0tcnx0VjT?=
 =?us-ascii?Q?Hc+b0lLwkZWpg06kcHBWR71/xz65HkEYMBfzgmQQDM/HBt6b0DXWaFz9bZcr?=
 =?us-ascii?Q?ZBt26a3hrNADZ+V71xNW7mwcJPfSwj95XXcWDLBsefWB0MtZgEerGLS5MsqP?=
 =?us-ascii?Q?dlNj4qMyuDsrDitb9+ZBOoNyhJrwTKLmN3GRev6CsYE21QYAemYGRSMpG0My?=
 =?us-ascii?Q?wi7V+WmWN4k21GaE/pPupgqmRBs5nHOTuEGxcU8gPnO2rJ2T+VfLmjCc3Cwr?=
 =?us-ascii?Q?gKZLOK0OudBxNYDkuLfmDiEuMI8Ht+bqKMsAPkG3NBK2/rbELw7CWQBR+ceE?=
 =?us-ascii?Q?zUArtFSYI7hUj8WdAxrC8ffAWLYhfIK4Cimrce768Xs9u/isxePap8UqzsgY?=
 =?us-ascii?Q?hdl2QzuvHcwoH6x+cjjGbf37jF/HZQ+eIOUi5S6p+bD90BRj6oZQd2cfD7/3?=
 =?us-ascii?Q?M7UzVkweV8K5VG+CGqvYMh9D6ucy1OM7O32U1z3mfdJgHpNTuRj6lZwh3jQi?=
 =?us-ascii?Q?yCHAoXpES5pR6hpxgUDIGIbw79E402Ll3DuciUbQFwX0s7ECf0ZbR14MvHiW?=
 =?us-ascii?Q?ApwEqq0h1SuT79d6P4YsC/KpJt3jl474dPLU+q9LxCNKuomO5Aw4+1Q6GBA7?=
 =?us-ascii?Q?VDU9IKOy+9mizPgJrSuPQGNr+LFZ7lIrajYnxSxqghwbww97bBcFP8OuZfca?=
 =?us-ascii?Q?ug0RXf0NQQk+kDXDxt6YA3JIb5pVFH5oUItsR1VHeus+efZ8njxdk2W7GD4h?=
 =?us-ascii?Q?SPbtns6j7FWuIHLhxBscsT+V/uSQdzMSDs91cTUxbNeorL/SHMUS3olchutP?=
 =?us-ascii?Q?+8OmOm8kKeTsMumLqpiIoRkJqw47fvh+yc4c10oRwYZYRn42QBx2rZUusIqj?=
 =?us-ascii?Q?KKOv5GS9kD2CDWunKRkMyhAVTuGo9bujrwlC4RLbTPf+3h5JlC3nzA/fbY3E?=
 =?us-ascii?Q?AMXulx71QBrDs0gPutmjDSlYU5OidU9MWKP6VG2eUIntkiFatpkfat1CCaFt?=
 =?us-ascii?Q?P7EMNjQHGzJOhTjV/s31EUwypEA1+RzyzYzmIUctUqr6yizqn0zZnSwbOpUe?=
 =?us-ascii?Q?Qd7Ww+fdwY6eEy8CoL7909VMc7bP5mCaAa87e5fylSoa7S12ZE4Vp/uonnRx?=
 =?us-ascii?Q?DH2ZsLTM2NUc4vZRBHl3eMl4TY9gxA432E38pw6ZxMc00qUYtJ0nZOZbxS9X?=
 =?us-ascii?Q?tmBZIkU5jL7ILZpKUv4ED78J4lErAKtqZxFBzhlzf7TVLjZt1x0kgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ETgnD5UT86fZYqGmQflcRPSrgoPBgaJPOz4Z141vRB11R669UoKP9NXBNt76?=
 =?us-ascii?Q?wr5BGaiQFGo6HmR57icLkWZ4iQc9Q6JNHIM1zxvBw6TLNoK09pdYmm1fK9F2?=
 =?us-ascii?Q?fMuVrrV/hhkFe+cGsnqEwj58kjJOuFV0TnlOdb0i5E0m4SyvH27o5/W3X3jU?=
 =?us-ascii?Q?3lxONHr3kgDmIMKLUkkdTTiSy7gVZWPJ81hkurfU7yZ60GvnibL7+Ypvw+oy?=
 =?us-ascii?Q?aKDG7ee1EPckZBAfpGTL07WWQ5He6NmZzRum2IzhS5MJpH4D1kV6p8QNhZ3o?=
 =?us-ascii?Q?wH0jHuuT3vcKs2GoPSq83/2VjaCTHW2V+/v7c8f+y3ctdSqkvtAkAvQIeMOL?=
 =?us-ascii?Q?z5WWpBYRTe/Gn6KKluEWUtGc3LNrfO532+htLDfe+ALpIaXJ/dd247cLm4pm?=
 =?us-ascii?Q?lpIQpxUldv5+xnGwAHCJcZnbmwevzalyLPfo09VB2SCc6q6dqxVmzFs0RiOc?=
 =?us-ascii?Q?aTFuaGhjKn23Trl+wU9MScsy7nK4v/PwBeT4rVJQq9b4kZxMIqNkR6cWieUG?=
 =?us-ascii?Q?u4f76N5SZIXIW80ZgHSJxDVYbEoxVDsazDJHSMPcn9Ox9Kuy/26ChW24B0dq?=
 =?us-ascii?Q?aHrjvZ9FIGwW8uzWc+kcxfDPowtl/5KTljczI8TgZ7XMIa7hSzNbVYC+QbIm?=
 =?us-ascii?Q?AcZmLhK/68Ypsykc2yrxeNL0xbbHpIqfNt+3+9CcIubA4jMdULHALYgjgCHt?=
 =?us-ascii?Q?+6cy02RQ0aphKXUvd/S5uaT5njoWN5gX3EJkoCMUbBtTi2rJkfJAxAEWFQCa?=
 =?us-ascii?Q?WWmLYxMyKDRaFgPAZm23hpDGVb6eEPat50FR55NyLiRh9d5u2MWjWNRuVeXs?=
 =?us-ascii?Q?spFvZ0mxW0kF+NtW7oZDxRtXdUGr+0JQhTicF21+WC6zc9zRTf+yj8Y/EQpW?=
 =?us-ascii?Q?7kBaOXcD2IELPnhaw/2vwQqEmNNAGVtMhltPTorypjnicrVFeZRGz/i69HS6?=
 =?us-ascii?Q?VynkYBiRabfy5SnU4ljA2LDoY8OY9U8RxV7PrCu5qjRsjq3iCaqVyfHPOdsq?=
 =?us-ascii?Q?ZbXto7J0zlQUUJ2v7ovkPxseK7ejxTr0P3pj0tymqhKT6hq3HLnomvDt1qI4?=
 =?us-ascii?Q?SalWrd5Sx7vtRPIh0eBjYZc1JVjq9vxMUzapmmztDtfIWpc5jnVstpwB+6Qc?=
 =?us-ascii?Q?impDo2ACBRrq9K5pRD6n741I+n8nYlREvqsZxUIXULyx8LD7JtHJHSZjz23g?=
 =?us-ascii?Q?1DDFH7vhMXjtgPegHFwi9r4suthUv3o1cUCmerlaohOGBB/v3lYqZYad6uJY?=
 =?us-ascii?Q?+5IlH7GbamF9j/mCb4iEYuMHfQerhhHV6Htr0FmY8uDPIeqzr85iZu+OCubo?=
 =?us-ascii?Q?wlQj6V2aL6zwSRybbjvY65LIeJCDUsHNX9dhO40WriBq3o1hH8xJpvafh/FH?=
 =?us-ascii?Q?qIcJO1OWdInSnt4u16o9fet6pyG7zQh3TpVr80QTNJmnBeJB8k6rNtI6Gi83?=
 =?us-ascii?Q?QFzAewiAZYzrS9u80UCk9lszILwPe/iML1YOSKj3y0XWKuehXyiGOi9BvEhO?=
 =?us-ascii?Q?66RMgEBim6wEf4L9yBVNHKaYmoVI6mpSgoQ1pqy9InHIktKVzw+6b+G6cIhm?=
 =?us-ascii?Q?zfoXClYUKK0ir6kytL+rgN3Cch0vCXWcyfg6MIM3PdJvTdjC0nRYqGmMl9qN?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99ab2df-2f57-4412-990e-08ddebc9ea4a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:44:20.9507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wBPQJc1MqHc/pMNWMt6lQ5z40eY4bstOViQ/jRAU70xO+AMhZYrxV/UQwnM73JTL17pE+cGRQ+W3VPEt8fZJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7635

There are 3 SerDes blocks on LX2160A and 2 on LX2162A, and they differ
in some aspects, namely in the number of lanes per SerDes and in the
protocol converters instantiated per lane.

All of this justifies introducing compatible strings for each SerDes and
some driver structures for figuring out the differences. The
"fsl,lynx-28g" compatible string is kind of the "maximal configuration".
It corresponds to SerDes 1 of LX2160A. If we were to treat all SerDes
blocks like this one, we would access lanes which do not exist (0-3) and
we would fail to reject lane modes which don't work.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 97 +++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 91a3b3928ab4..991587c453df 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -479,9 +479,18 @@ struct lynx_28g_lane {
 	enum lynx_lane_mode mode;
 };
 
+struct lynx_info {
+	int (*get_pccr)(enum lynx_lane_mode lane_mode, int lane,
+			struct lynx_pccr *pccr);
+	int (*get_pcvt_offset)(int lane, enum lynx_lane_mode mode);
+	bool (*lane_supports_mode)(int lane, enum lynx_lane_mode mode);
+	int first_lane;
+};
+
 struct lynx_28g_priv {
 	void __iomem *base;
 	struct device *dev;
+	const struct lynx_info *info;
 	/* Serialize concurrent access to registers shared between lanes,
 	 * like PCCn
 	 */
@@ -800,6 +809,79 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 	}
 }
 
+static bool lx2160a_serdes1_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return true;
+}
+
+static bool lx2160a_serdes2_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	switch (mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		return true;
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
+		return lane == 6 || lane == 7;
+	default:
+		return false;
+	}
+}
+
+static bool lx2160a_serdes3_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	/*
+	 * Non-networking SerDes, and this driver supports only
+	 * networking protocols
+	 */
+	return false;
+}
+
+static bool lx2162a_serdes1_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return true;
+}
+
+static bool lx2162a_serdes2_lane_supports_mode(int lane,
+					       enum lynx_lane_mode mode)
+{
+	return lx2160a_serdes2_lane_supports_mode(lane, mode);
+}
+
+static const struct lynx_info lynx_info_lx2160a_serdes1 = {
+	.get_pccr = lynx_28g_get_pccr,
+	.get_pcvt_offset = lynx_28g_get_pcvt_offset,
+	.lane_supports_mode = lx2160a_serdes1_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes2 = {
+	.get_pccr = lynx_28g_get_pccr,
+	.get_pcvt_offset = lynx_28g_get_pcvt_offset,
+	.lane_supports_mode = lx2160a_serdes2_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2160a_serdes3 = {
+	.get_pccr = lynx_28g_get_pccr,
+	.get_pcvt_offset = lynx_28g_get_pcvt_offset,
+	.lane_supports_mode = lx2160a_serdes3_lane_supports_mode,
+};
+
+static const struct lynx_info lynx_info_lx2162a_serdes1 = {
+	.get_pccr = lynx_28g_get_pccr,
+	.get_pcvt_offset = lynx_28g_get_pcvt_offset,
+	.lane_supports_mode = lx2162a_serdes1_lane_supports_mode,
+	.first_lane = 4,
+};
+
+static const struct lynx_info lynx_info_lx2162a_serdes2 = {
+	.get_pccr = lynx_28g_get_pccr,
+	.get_pcvt_offset = lynx_28g_get_pcvt_offset,
+	.lane_supports_mode = lx2162a_serdes2_lane_supports_mode,
+};
+
 static int lynx_pccr_read(struct lynx_28g_lane *lane, enum lynx_lane_mode mode,
 			  u32 *val)
 {
@@ -1202,7 +1284,7 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 	u32 rrstctl;
 	int i;
 
-	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
+	for (i = priv->info->first_lane; i < LYNX_28G_NUM_LANE; i++) {
 		lane = &priv->lane[i];
 
 		mutex_lock(&lane->phy->mutex);
@@ -1258,7 +1340,8 @@ static struct phy *lynx_28g_xlate(struct device *dev,
 	struct lynx_28g_priv *priv = dev_get_drvdata(dev);
 	int idx = args->args[0];
 
-	if (WARN_ON(idx >= LYNX_28G_NUM_LANE))
+	if (WARN_ON(idx >= LYNX_28G_NUM_LANE ||
+		    idx < priv->info->first_lane))
 		return ERR_PTR(-EINVAL);
 
 	return priv->lane[idx].phy;
@@ -1275,6 +1358,7 @@ static int lynx_28g_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 	priv->dev = &pdev->dev;
+	priv->info = of_device_get_match_data(dev);
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -1282,7 +1366,7 @@ static int lynx_28g_probe(struct platform_device *pdev)
 
 	lynx_28g_pll_read_configuration(priv);
 
-	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
+	for (i = priv->info->first_lane; i < LYNX_28G_NUM_LANE; i++) {
 		struct lynx_28g_lane *lane = &priv->lane[i];
 		struct phy *phy;
 
@@ -1322,7 +1406,12 @@ static void lynx_28g_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id lynx_28g_of_match_table[] = {
-	{ .compatible = "fsl,lynx-28g" },
+	{ .compatible = "fsl,lx2160a-serdes1", .data = &lynx_info_lx2160a_serdes1 },
+	{ .compatible = "fsl,lx2160a-serdes2", .data = &lynx_info_lx2160a_serdes2 },
+	{ .compatible = "fsl,lx2160a-serdes3", .data = &lynx_info_lx2160a_serdes3 },
+	{ .compatible = "fsl,lx2162a-serdes1", .data = &lynx_info_lx2162a_serdes1 },
+	{ .compatible = "fsl,lx2162a-serdes2", .data = &lynx_info_lx2162a_serdes2 },
+	{ .compatible = "fsl,lynx-28g", .data = &lynx_info_lx2160a_serdes1 }, /* fallback */
 	{ },
 };
 MODULE_DEVICE_TABLE(of, lynx_28g_of_match_table);
-- 
2.34.1


