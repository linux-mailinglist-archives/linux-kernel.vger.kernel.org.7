Return-Path: <linux-kernel+bounces-723261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA40AFE51C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27F45471CE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7E828C2A2;
	Wed,  9 Jul 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="kkvQGU4H"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E028BAB9;
	Wed,  9 Jul 2025 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055458; cv=fail; b=FAG8WKGOeGjvKfX8Qk31roqqRLAJ8xCaUtjJBX21GTlGa80VCtaVOs2QITLWM+DgV+1Y9edLr76XJDEhOO78gAqzMq+1a7fJVvbi84TAQ2XB6f6Nr013fuTmKHDPpJy5EQOmbdH3EGUioHxxkv1cdc6pedo2/+tBA5UiUDmYKRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055458; c=relaxed/simple;
	bh=l33apMaNeTe3Wrr/AbJAKrxI+bkxSwRH7YCctQopk0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l6RyTxsCd2BPRHzb6IPXhEBOsvIPf+c0g0FDqrQEDt1zpWgE0LzIZU5JMOHvjvEJ6OBG1UITgIW7LrFZ82KbAMlISdfAGA1kDWpGsczUf3wFGLYX9C9RxSj7UyrfDJGF5nKtqr9HuOpoV6c4fgmVXz56jSXnTaM7hPeagonFT9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=kkvQGU4H; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsMlOSnFdYxdUd6Pz4YtaCq/qwu9zx51s/EwKZc8XS7OOliwGbPR9JPjz0mi0eRzlxfS4r+WzdU8vywoNW6flLQ+A4wqQWbmjwqTwhUlrR+37yTYUjjWTpAuKGFLqJJQjis7pF+sByyCr7BMbx96xC8bWeEMoIYwZTyse5AjkZduQYzwpJahiDh5v5SimeQsMA6jO7UElcfZUvmoSq1PULv8l1j892ZKVVfTwsZhuPURsVL1NcHjMMuURHBBhCNASrk1UbNV8vGAc7PFUSTcPdLxmy923elcf1I9/yX1UPXEaaf/ZrLEqzSd1GtpOxi2jWTZkGSvw9R7+yUiIix8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uCI4mPKjQBAieTfQagcNSYu/bNjtgGw/vVNwN4evkU=;
 b=rQzVGwDD9JV6veNy81BV2uvemHSVRRXwcYJdFbPd2E7ErIDdURg+qvynMeRaxy8KR7p0o7C9BGe1QRwwbZ4YraRCsUjpkfT7Zv9neMzrC/GmG53Jf0ieQRnEirNRBlYGB68CmlsCvr58823auVs5i/BOSKtC6BKMkbvcCb7V2+FFZMZYmR1ISaWi2dpGky2gMtuo/U796+PyeMtQ9v/RwwS590LRW5opE2VbbupqomJFQur1RGV38ykvRplUmFbAbxEh/efkN4eceN5MZZMhdA3pf+00dYtaMFzZPFZQt5oy+2XAiCLXJNdqM2WvI3QJ25vWKAmXhxfiVnG8c7MYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uCI4mPKjQBAieTfQagcNSYu/bNjtgGw/vVNwN4evkU=;
 b=kkvQGU4HwF4fz+8lQt7JGofyFEpkYAef+MSQjegOsYPvVhmY82XoukqAZm+QIrE4+Sk0X93UCYCQpcsRcySx62mqb8tFl1Yu6GF2WDKkbm37g8TXVlL6ucfxszUHM76H9WPYIh5VSHonvHNcVdlCjLDqqImjiSfk0RLTlOH+H3WBM86tC7cwwy1eZo6OESCulA/KS2RBrk8U/ddlu9fOKtzC0zMati8ObAo2UpIWseiG8Y4xwNyfhIpb/Gz8z2fIHTyTw5iHuo4yghWaYBOK/zfpyqjEIQlhHLcQZAvmcNCAL3GR8HMJD/jDJwNW5b8f1RSc34obnn2q87GoWobIQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DU2PR03MB8123.eurprd03.prod.outlook.com (2603:10a6:10:2f2::12)
 by GV1PR03MB10584.eurprd03.prod.outlook.com (2603:10a6:150:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 10:04:05 +0000
Received: from DU2PR03MB8123.eurprd03.prod.outlook.com
 ([fe80::a4:d971:86e0:ff72]) by DU2PR03MB8123.eurprd03.prod.outlook.com
 ([fe80::a4:d971:86e0:ff72%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 10:04:05 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Wojciech Dubowik <wojciech.dubowik@mt.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Tim Harvey <tharvey@gateworks.com>,
	Markus Niebel <Markus.Niebel@tq-group.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Heiko Schocher <hs@denx.de>,
	Andreas Kemnade <andreas@kemnade.info>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andre Przywara <andre.przywara@arm.com>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Junhao Xie <bigfoot@classfun.cn>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/4] MAINTAINERS: Add entry for METTLER TOLEDO BOARD SUPPORT
Date: Wed,  9 Jul 2025 12:03:27 +0200
Message-ID: <20250709100341.1492456-5-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709100341.1492456-1-Wojciech.Dubowik@mt.com>
References: <20250709100341.1492456-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::20) To DU2PR03MB8123.eurprd03.prod.outlook.com
 (2603:10a6:10:2f2::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR03MB8123:EE_|GV1PR03MB10584:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d75736-5c32-4e67-f296-08ddbecfefd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VnO2126Hbt+ZNbD5Iyu2LVcGqonYX5xzg3iFDjqgXY6O2w322y/82nToyk1X?=
 =?us-ascii?Q?MlN/yk8DeNG1i0914da+DXd8HDc53PSKXKyK3TmX2SpicUfyierBDExYwaZA?=
 =?us-ascii?Q?OlDmJHvcKh0TXMGo2+KyxHYP/OlgRwZGWyAWjwvTlZhI9lzS/c1mEoFH+V9e?=
 =?us-ascii?Q?5F5CAMqdx5oHJJlelddijym53H4VzLVwPitAgc2Wq40LkCEPQ+HvRz1hD8zF?=
 =?us-ascii?Q?anwRjYnzrmS7OPI44tXOXk55CyA4UCR3cDgaKnN2geuFeKTMq2TwZGYu7uaY?=
 =?us-ascii?Q?WGdmAg4zxdmsq35PuzH74gPEKNpaMxzJhSD29GnBx9qkehiN26x8uq79ti9Q?=
 =?us-ascii?Q?MzFRyRtw1HHtPo13M0SL+1cjbrzTszdRLSR3ScT2blLsQ/7Q0T9XkVY+6xwK?=
 =?us-ascii?Q?Mn4SQH+sBQteyyn+u+48awZBe7xf50fFnDy8Mng08KggW8G7TXrVwuI9IaMj?=
 =?us-ascii?Q?aJTmdtcP0CyvG0iNSzSlS1/WBGPCKnjKQaGSi8tRdGOWBXZC/gH9OCqRx7Qk?=
 =?us-ascii?Q?uIsDL4Xmv3/iEQ4F9yzDov5mauenbrhpqALiN8h9WXgfmr7eG05njWUJxk5j?=
 =?us-ascii?Q?6lGXCM4Cw8UIj2drDpMaLjDD3CtgA3/Vax09C71jRCzl+DxdvXo6DRM+/JXm?=
 =?us-ascii?Q?K3UTGGB6pfHd8djBG9l+zQaVBUMKEsydWBt7hlHbBuq4IBfVqSpEpAsme4uL?=
 =?us-ascii?Q?rooNsMDtOThODjrMQFJeTMqrj0d+UnwKffqAdKkLmb06kMNdqUjgf+Hxx3zw?=
 =?us-ascii?Q?tSQByXjTIpr+s4hYyJovcOMJWVmM01JUrNmsZCycbzchG8+OvHSSpkILMcnO?=
 =?us-ascii?Q?4bZlcIsquRLWWmQmseNzQynkaYY9J2sG1kqSCAc8ec3zv1TVRzMb22EVsBnZ?=
 =?us-ascii?Q?w9TbtqFIwBrRc4jqbh7ohITXjJfWITs4HzyYdQWSAsA7i5P2OksgPeot3Gso?=
 =?us-ascii?Q?jfcBosdbMXOYNVYC2c50QgkzrovWDrCwmvB4loFGcXQ43ZftSqvbBv29fztq?=
 =?us-ascii?Q?7C0Z+BxSSQ/vx6Eppla8qQTd3/+WLsgWDvuEakQbO/tJBIp7Og4MwVgcZOk/?=
 =?us-ascii?Q?M9Dc99KbYnhYd9nLc3U6PF9aULu2iRP/YsiTqbGwNLemgXtGI1e9vZrp312Q?=
 =?us-ascii?Q?9e53exa3O49Xh5bbY7ZWx6siqJrXMf5v46GvDMcnlCSIhy1YuynPJuYmpHs3?=
 =?us-ascii?Q?2smxRAGzA7zKP5AaXXXo9AbzytwQ2qNuQiksNzrK8TJuK+Hn8StNI+VzUqn4?=
 =?us-ascii?Q?PvpOAAEfmAt0JI97mgLTaoXG9Aa8gvgGj5bmnfuRepCwy56yTRWuVW2g9SXX?=
 =?us-ascii?Q?3glPA3SPi5EP81NKvsAtawadAFFFEHHNsLRDBTbuwXwGr5epB2rQ3qQ5Dvgu?=
 =?us-ascii?Q?GUbMQU7dAcaSZ+H7G8GJztU5C95LbWDZnZbitmfYoOcHJGu3aISSlh7t2Odj?=
 =?us-ascii?Q?4GjLnxDJPmNtIB6ceZj46bLwRiUaS+vcves9Erq26zFfqR5nWRyY+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR03MB8123.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CCL4iX5vcPeSALxpes2PbdI/Px5fS6HkIPMvJNCyX0vtvbcPc1Ah3RtN9WA1?=
 =?us-ascii?Q?m5fQVepLeibX0XkBCwjJoXBiNNsWVoHCleiCwWqL95HGl5mBKkQzfbhKsvYG?=
 =?us-ascii?Q?NnMfPMsEUtymPzZmxTYVSLndmdHFa23kY3FUE6oIe+Q9WikTYRwFYWaojFhC?=
 =?us-ascii?Q?3+i8AcMdRC4NcF7pKe4Ofhwv/jtP9Ii65eLuhAQiPvsWGgEJDrGFDe82CHex?=
 =?us-ascii?Q?y8d9yUpjBdtsnfasH911MkyvnUuewarkj582g/lJ+66iOFqBOf269/cZV97N?=
 =?us-ascii?Q?+yrHXdI6sx7tZzs88983jNeuyMOjBRitAtoJTpuerpWeGLmsYOdds/j1S/18?=
 =?us-ascii?Q?R7PnjcHZibG2k8dHv67trBKAqLGpcoiA8bGAQa3gCYtk/TD7oZ2q2eptOYWB?=
 =?us-ascii?Q?kJCG4cOnofAolthqqbYphqTRazHvEkm40qLq79fLDRqcsVEQVlLQ3qmJSQ7V?=
 =?us-ascii?Q?2hhU85AwGhk8EvErSFE2Se9PSIow9Dm4Ik50U96DiubwnXwWq7NJoc4sZyR+?=
 =?us-ascii?Q?9rq+4L+ZXBPrfdQ0gvzKLu+WPKJeYpoNM4kpmzbXTQQO0OFOR43NbvAbdUB2?=
 =?us-ascii?Q?dNpkImsH6EGYT4D+tGNBw2IRHO6jTNcH9XJbLXXOdaJsUZI7Pk+bYg/EEtIJ?=
 =?us-ascii?Q?d6QS/BfinLO+QOAPuCPJq360laWr/sFHdEUOEj11/TtuB/FyT4foHM91evJH?=
 =?us-ascii?Q?mGbaqS4mN0rJoe1Xk0+WTvxU5l+58dzELedrUwVE3HZt6ioVNC2GVM9sWXEv?=
 =?us-ascii?Q?AMRUkMxM/Ey99qDpOwEQYtCJk0YWWZ1flTSO0EEeRG4MJ8NyGI1oconkmz+y?=
 =?us-ascii?Q?VtUj8bIZOtGzf6YnSr/ExgYlu91CR4RIw1sCSDOQrWRMTQkjFjsfDlTLY6/A?=
 =?us-ascii?Q?Xgc/XAl8gAgPQ1/5akPEdsmFSRB5ZJxH7LYDHzGY/uQ40LWSV+NKbgFfW8LV?=
 =?us-ascii?Q?nejldEdwsvqMJKAcGcrprhJ4/dzvewtKjLhb0sJQefblmXiyxMvpObKh06uj?=
 =?us-ascii?Q?DYlQ1N4lG/GG0fMOOs6N+HX03MNb3TSniSHHmd9Qtbn5vwQN4m27Q1tmUvy/?=
 =?us-ascii?Q?TM4LkelxGe4SxmVesYMCsIfZvlPXklhNJWV64gCkpZu5NlF6TAv3Au8TasT2?=
 =?us-ascii?Q?7qQMIClEOqSFUsSPvYjFgomIhMyS0sIkvr01Cr9zz4NhEybif+5xO/WX+8MO?=
 =?us-ascii?Q?SJGbOFU6RJP9xyCDs9RZY4UeLGhI8lwmTZl9DGKwqMpsV2de2Yyo5Lztz7IR?=
 =?us-ascii?Q?CnR1ZlKksaNwuNCdlAAl9fJXyiki/Uz5MqjnXhhslVI2nNtERX5No9NQrKIT?=
 =?us-ascii?Q?LES5AeUpZ0aX4vCCD3xDoyCEtEyJP3RQE+CjZ+qLzkzMlU7wnNi0VVr/xI8K?=
 =?us-ascii?Q?iybQMG3DmbWhYLrFuhnf0GtBARABbwG248GSh2W9bn++irCxFI8z+Sgl3PlR?=
 =?us-ascii?Q?brVWZV+IraO+tPuEEYG1ytNu67oiT9Rw8lr3aQ+P4ZQo+DAz0IqpTweO4od3?=
 =?us-ascii?Q?Y2w8vb6/mtT77k7TcUVwAoX3Qojflfpb8vxaKMRMxEvUnvzD2xzCgck/koGY?=
 =?us-ascii?Q?SZqp0cXTeA4Bia2peIDDUHH2cfsJib77linhUAaK?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d75736-5c32-4e67-f296-08ddbecfefd4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR03MB8123.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 10:04:04.9228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ngjayvc0aD6SUvOeeh5Jz57WMM58Fa/+xPN/hcFkiUGhJmKbXAAT2/YxM2nk28iv/Z0XDhgb2PdQsX+NobnHJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10584

Add a new MAINTAINERS section for the METTLER TOLEDO BOARD
SUPPORT covering imx8mm-mt-* device tree files.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 240793fbe64b..eab5597e659e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16149,6 +16149,11 @@ S:	Maintained
 F:	arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
 F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.*
 
+METTLER TOLEDO BOARD SUPPORT
+M:	Wojciech Dubowik <wojciech.dubowik@mt.com>
+S:	Maintained
+F:	arch/arm64/boot/dts/freescale/imx8mm-mt-*
+
 MHI BUS
 M:	Manivannan Sadhasivam <mani@kernel.org>
 L:	mhi@lists.linux.dev
-- 
2.47.2


