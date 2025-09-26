Return-Path: <linux-kernel+bounces-834510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE4ABA4D67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E2517D78D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B2D31282B;
	Fri, 26 Sep 2025 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fNY4zWJz"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC80A30FF25
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909947; cv=fail; b=Dp73VyfuAMsx8WjJPhNbw5D5jcPnqeVPPPkoVnR/GJGrzqf5gCJXEkRJLf5iogpK0daXtD1NZeCNiJyPqbodKlsL9hTtZ4OQXGFLER/OdUQBrvwmiONT2c6vNqmmXYqmHpcX3yNTdjPQRvbasasKBRvFQGXVml3yZcZSGERdY1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909947; c=relaxed/simple;
	bh=xXwWWmsyxWtDTUyILLzG4PdAyOOWeogZgWMU8m5ws/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=blgRs6VUrZCGGfZVXJ7jZkJDNRuCattouUgWd85N9z1+poYerJr/ThkI/v+mzuNExFANWGyhBlKLsSdDcukOcAD1eam0QzCH5J7oqvmiY2BGSuVEBedNjt18M8n57jwhEN4nA+OYZsOLlf4pEdwTDI0/JdqPlwhYjvQetUYTeZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fNY4zWJz; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tX4t/laGopl//qRUEcV08kmguXGiPQipyW0P8JaF3U9MbgBGVNno4jwzD43NXEP16tyvQjlzpwkAfH7cb382Cz+B/5f6vZXslZBknrUyNH4wsjE6Avx7jqwRzRDNwbVo4/kdWCxOVPPBZZNOEhqXO1/jlc0RVv41r2Tq/KnNpGcjwJ2lRgHHUp1QM7WAda8o9MhRGkUp+TKkC3rtv+CAuUxV1XgAzCbAbciQTzryf0CChWCXyDnGgM1isY0/WLztZYx3yLHskIU9XLDv5JJxfv3UyDXcmF1JQOnCo+fFLHI0ZtO1lPTtYUmGJMIlep/ydy5hcHywmIaTX8Gh/QGpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzeDbsjSgzAnwFmwINhDbnmX2vgA3i/eQ7O9lo/IldA=;
 b=BrJIKwRiwVDVS/Lmb2MU81tfBoXPKgPGCvuFMN5bVPik+2fGh5qbF2zxUTsIx4KXdA6OSYUVouQES/hWlNL2mhBvK/PdFbi1UwOmS3jDRuHQBEcI8nD0fVB/ulJjXBa64txLgy6WlGgItRHB6n4erfpgVhxhpxEg/mEBjracXadJuddsh8eoyZ8qMVot1eoxvf9vVc3J3C1jiPoipL/PhB6cLcyWOpQq5wvHXVC9k/Ljmcu/HKdNz++lT850GoMr73W88hk4No5c7bvr53n8KVK3RTv0EzvpXbuZADVeKm8a+cqGl7lSYC6nBydM0q0FhcDTYgLAoNxti7UW+BdOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzeDbsjSgzAnwFmwINhDbnmX2vgA3i/eQ7O9lo/IldA=;
 b=fNY4zWJzCaEDAi8FaL381ujAuXhG+NcchUh5lIIUICfHKvbLi6eOHomSeKyp18Sx6uUK70QQ5CH3ymz9au+M9pkVSeNrVnh3AOclsLOJKxhcho0WZohCbGerl/A2EwMMxO0gD4bW1cKXDfK/vr84dWHg4sxTe/fbmkvqhLsb2jDvG6oEuvKHiFLHfvILmvhLYIFX0PjRrFNRtSPcVgJ5fN6whrv5P4iJU/E2MoyUtwFJLyhXz+SgzsJbmIlyTsNLA5PGBgZAAc3ZDLGF/Uq12Veap+/KKRNZ84N2trCrz+EEAjvHt/V4WJhk2IeCbvH9Td6nJNZnMJTgrnbVOfHD2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7823.eurprd04.prod.outlook.com (2603:10a6:102:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Fri, 26 Sep
 2025 18:05:35 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:35 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy 17/17] phy: lynx-28g: implement phy_exit() operation
Date: Fri, 26 Sep 2025 21:05:05 +0300
Message-Id: <20250926180505.760089-18-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926180505.760089-1-vladimir.oltean@nxp.com>
References: <20250926180505.760089-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: b0020ff6-bb83-4e99-c1cd-08ddfd274ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cVYfgpAasxzl5NkPxf5JoVxJaMYApzoDfgYDux3Uv0PDijHGFKyXOWr4Qg9n?=
 =?us-ascii?Q?bP4iqbe1VRXi4TUfCaikxcgEpSTZT8hOQbB/YFQWveLmTRFbGRfoxbtOJaI/?=
 =?us-ascii?Q?ij/yqU/RM6b/3ys2AWSu3Kfc4QSIJPGjupBR4IxfyxGU6apFLc0JHVLu9JuS?=
 =?us-ascii?Q?WR9y9C8vpDyS4DxDWWihgE9AE84+xpJqLIR8S+PSvxoAIJD46cGThaFbQDcx?=
 =?us-ascii?Q?PQuEK50H+pLtBeFiL8hOvC0Nsn2tuPWnHlKiY7Gsq3RiUHobrnGLWoNdjB+w?=
 =?us-ascii?Q?k0e3T8+41pUNK6WyCs+qj396lTq/LdTywhW+2CiogA1212Dr6yhqVHNXchBz?=
 =?us-ascii?Q?kA6ZhfkV2Q/c/+bAq5VI58bH5baX+qpwGAhKXFc6hWM5CM0TUmcMKEhdbJmA?=
 =?us-ascii?Q?OoaAdKxu/wvqIas6TB7o5/1jazyYf4RpuYkyTjwlAmoMQ/d5S377BfFauM79?=
 =?us-ascii?Q?GA17wRDArOEAuEuSmmSXlwma7MUXDLrVw8YeP1sHOe7uvVolP0fC5eG+5Voz?=
 =?us-ascii?Q?5LFYh0B4GYyl6eP43ap7ODHmKUFyxPiuIGc/6i6eQm6eQbLtlIaEsMwwwm+3?=
 =?us-ascii?Q?dz3rZkDd6j0J9oX4meUZlt+odm72fmGhnCWlzDoEZwH6C60s97dhOp4UeuWI?=
 =?us-ascii?Q?ZXUFAKRXBwGXgn8y2kUPZZzQvBM41WpUeHHVYAcyB4UjEJhKF6w+sbH6G/o4?=
 =?us-ascii?Q?aWB3YtOI6FPuppxhsHSiSrzbVuVvBRolRe6o+6ML3pcF7i0+A5cahgoKTW3R?=
 =?us-ascii?Q?lSPaeyNzh7zG6GVORxPwXM9bOQxL+VLKTKZK/3PUr3NuJiukMxpaKCvKP8lb?=
 =?us-ascii?Q?mzZk9MHj6K7/ft0zvyhOuseCQFkZgLspnTwnFbFF/DC6qgLiPbGnF347lgdf?=
 =?us-ascii?Q?a0XZ8nVrWEUlT5aq4yilc1IUYO+wRXPcqoMz4kj19/1cwGUNIPcZXMYA0kpr?=
 =?us-ascii?Q?C6hiU/oFrw1yUpWB0t6fII2RJ42D2sT7A0HH8C/v0+v8fu+DNwjSs7DULZrX?=
 =?us-ascii?Q?nq13lEIpDLGNQt/tNYsqXetbWvOU7KApZQsX2RZNjz31Cfi11+TUwYRvaT0w?=
 =?us-ascii?Q?jSxPupSFSU7+ZFt0IgOro7tJJetjfJ9Z0il2PNO5fMlOmoxLoWwz8iNdnuDP?=
 =?us-ascii?Q?GFdbPs26cEdRyiIDAR2qGIQXVmzZX4+1IGXqW8PKWAaUB2KfV6qCY7VBWYru?=
 =?us-ascii?Q?21kCd791RZk+zLyi5K772bQb8y+10OX+8pBToags7sAyBdanKrPVjaNdwLCT?=
 =?us-ascii?Q?PI6/NDgRiTnBmb1wfieb3j7bFq6GBH2Wcdbo2d2I8Cy2dJiox4UF2mpkGQ3D?=
 =?us-ascii?Q?8YSqOYUJS/3d94SwsKMKxyZBMrV5AF+XER7mRpqWOHc0y6j5l6A/7s41Ro/Y?=
 =?us-ascii?Q?76ohlVT6s/RU9sxoXZdrgJDbqY190EfpDjbuhwRC1MXaiKCo28fTvV+pa8b3?=
 =?us-ascii?Q?VMutDevSO5QGDvIJuPz3YyRpOidpIPu8UIBKPwHq8/kVGSvIB0c1xTFsGQT3?=
 =?us-ascii?Q?hHtuJDgHt/1e0SAc9RvcnT436qa7zRdA/UD8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I6vnAL3cAPKV46ayiNThZC+LT7i1wNUvIF79DCkq4ucmtaCgx+Ec8kvzBDYr?=
 =?us-ascii?Q?CIbrBfuDmdQnpbu55yueyb07CnqHa6wZcBAoBgr2xi33Wu3m2Ct0VDPQa1K4?=
 =?us-ascii?Q?DIpVRhNahp7CArMAQlKV7FhTbgedFXdXbHg1YUsxRRSxB38dqQjc+nfdQjRc?=
 =?us-ascii?Q?SAIUmDe+9zn9rvC3i6r11iNeyvEJAiKu5+5Vuh4gvm5e1jmpr2Fy5gmywRPn?=
 =?us-ascii?Q?id2Hf5vGfmfcZ5vyO0G4EAlqmcNMDBKFhLc8MRQuuzNdxl5DcKBkDvyZe7Kv?=
 =?us-ascii?Q?boMmfnShz3bfa2073X+qlR0plwci3KpSaNVLtDrCaEH6yGjh7AhilcMpi7tb?=
 =?us-ascii?Q?oKTPcxgifa6bxnqT15aNUV5RuugD947xvLzyRVF+lBSuoKTQtRCByVnH0uCd?=
 =?us-ascii?Q?r4WU+cxORp7BvSs8Ki5Ww4lvI4GXXcGoVtKvVvr0zHQhKi6hK89ldHH18I3d?=
 =?us-ascii?Q?pWAC4EGOaAcbXXKB7vEhJS4gEg1VG2AGeaohpOdRd2V5GxvVpnaHzVC+/3la?=
 =?us-ascii?Q?li58jriH13mlt5FAQU2IMMK2/iYHe8jBp184eUCxSo1wjY4ggednSH40PDwC?=
 =?us-ascii?Q?ebmRXpJ7qXBKZ7AJVydLGwlf3KaU0Ea6aT1sqYTffy3/1MmZBCU124t6fdOR?=
 =?us-ascii?Q?tL2oIb2WBEqbTaLeYoAgY4YLKUWndPiTqoawuzbwKXbD0KhfH960CRZvu/VG?=
 =?us-ascii?Q?hzSwfcPNQK6p2sUWKZRe2cp16bZqAn5KWOqVbRBA2benRkf00xXZbA7vIJev?=
 =?us-ascii?Q?vTmNCqPUp2rPkqHX2TNDf2/dUOW8yFolpjkzDhZetbiQdrmNf4tpd6+cfjin?=
 =?us-ascii?Q?P84R6Gv1zxe5/EGv5/33NBOe1LjemmVv+GU9lT9lPQM990qo0tQG/RDVCMRj?=
 =?us-ascii?Q?aGTOw8yWH2gFyFtim6Z9xLdiVNeTlTHkHmBHeKzQzGkiZ0GAhbWUvRyizMDH?=
 =?us-ascii?Q?ZZ4xLBOYb54cI3T1Xq4C4fCUFbiGFZx8UL3K/W6G/VAfiFqdAIyUpf0MsWeV?=
 =?us-ascii?Q?61lK16oWLs/Im8iuD50xJejPcR1wsnwWtUEjkkoG2O3uNctrl5oF+hPAfkZa?=
 =?us-ascii?Q?85bDNHAlkTiRWiHvRS7JOixuq3FYJHfrnb3s0sgo6TvlfH3PzzRWg7+kjnPM?=
 =?us-ascii?Q?yK1/tmh9qgqlUTnCNqbH7xorqcqSeq+nFjFvz/juJdcOgPiMrfEtUGRBBD28?=
 =?us-ascii?Q?8am1PWk4sJYlDpyu+BgYSfAZv8bswWG63lOGrKt7nzs8wx/Jnf4d992wOJnJ?=
 =?us-ascii?Q?DC8ShI2Us366gtkIap4s2df+U4IIW0iOW/J84wSUXiViHRPeL6DgKV7pV1Dc?=
 =?us-ascii?Q?znmH3rU1U9RUCDSWl5WyDbUbXpOYvVsxWMRTrL9FFC9l4DvLDiKhz+VncOr5?=
 =?us-ascii?Q?4iNWVx1H3RGPRyeunODw0UwbnWaYlvrKnz7lhM7lkZasMoKSpTD1/cEklirw?=
 =?us-ascii?Q?GFoXdq1/J4ajVOF2H/AluUM+KNTK7MCO9gQWg1DZWofg+IPB/Sh4Df9MsoVY?=
 =?us-ascii?Q?2T/XWdEIA14Xqgii2IjIrrccYvFZPQ7dyTi+dyZHOTJIIQGgHRUMrOe8D5js?=
 =?us-ascii?Q?hHWHjtZOYKX/Vje1j1iRTTmwo9KUgqXyFgtjpgYIZASUi8KS6DUV0B2KMUKo?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0020ff6-bb83-4e99-c1cd-08ddfd274ac5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:35.8148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQHetQ3OJ2m5ISdUwhSpwQMLiA/bjGND/II0hoGh0RyUl2G55PjmyMCjJIdcyhfuF//ANHS96KMC1uEy66sfrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823

Managed lanes are supposed to have power management through
phy_power_on() and phy_power_off().

Unmanaged lanes are supposed to be always powered on, because they might
have a consumer which doesn't use this SerDes driver, and we don't want
to break it.

A lane is initially unmanaged, and becomes managed when phy_init() is
called on it.

It is normal for consumer drivers to call both phy_init() and
phy_exit(), in a balanced way. This ensures the phy->init_count from the
phy core is brought back to zero, for example during -EPROBE_DEFER in
the consumer, the lane temporarily becomes unmanaged and then managed
again.

Given the above requirement for consumers, it also imposes a requirement
for the SerDes driver to implement the exit() operation. Otherwise, a
balanced set of phy_init() and phy_exit() calls from the consumer will
effectively result in multiple lynx_28g_init() calls as seen by the
SerDes and nothing else. That actually doesn't work - the driver can't
power down a SerDes lane which is actually powered down, so such a call
sequence would hang the kernel.

No consumer driver currently uses phy_exit(), so the above problem does
not yet trigger, but in preparation for its introduction without any
regressions, it is necessary to add lynx_28g_exit() as the mirror of
lynx_28g_init().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: propagate the potential -ETIMEDOUT error code from
        lynx_28g_power_on() to the caller
v1->v2: slight commit message reword

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 8e38acd30224..fef2b2d7d170 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1295,8 +1295,23 @@ static int lynx_28g_init(struct phy *phy)
 	return lynx_28g_power_off(phy);
 }
 
+static int lynx_28g_exit(struct phy *phy)
+{
+	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
+
+	/* The lane returns to the state where it isn't managed by the
+	 * consumer, so we must treat is as if it isn't initialized, and always
+	 * powered on.
+	 */
+	lane->init = false;
+	lane->powered_up = false;
+
+	return lynx_28g_power_on(phy);
+}
+
 static const struct phy_ops lynx_28g_ops = {
 	.init		= lynx_28g_init,
+	.exit		= lynx_28g_exit,
 	.power_on	= lynx_28g_power_on,
 	.power_off	= lynx_28g_power_off,
 	.set_mode	= lynx_28g_set_mode,
-- 
2.34.1


