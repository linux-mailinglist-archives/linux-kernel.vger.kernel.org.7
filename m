Return-Path: <linux-kernel+bounces-801179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E64B44102
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C00A44854
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2852B2F83C4;
	Thu,  4 Sep 2025 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NhJzKtEp"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8432ED14E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000667; cv=fail; b=ipeX9BdrlfEZ3Qsly9s0Oh4sdHay+w2oxnWzBc7Om5+Dd63toaVfHCS/Xk1M0pV2OweBH/iXw8x7jMDQoT8BG9AeC5fQvUi6y1zWuC+mDEKlnxLNMm9k+zYwqvM007ICOUmQgb01DrdTEmViiApJKgBxgHfQaCd+0A4nXhc5XW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000667; c=relaxed/simple;
	bh=tYusQ1N3R6JNauBUw6GPP44f/y9dRWuEL4E/bFZBo5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U1qw4F0oGyHvqFi7xwfoybSumN09m5tCtzfXu/H5tLVyWYzs6bOA0+m9o1T7aKOL9x/5Ec+VVNlpIBkqnARAjxnNEki6YEh/Ccu6JLeqtr52LX0wiCJrZm3MtQqn7/EDiS8PFUyTYFcWN/BxaurTvQumXPYwf+2V3JCWsyK/S+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NhJzKtEp; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjbwtDroB6MfZMGqDhd1u4yC4nh+WqZgJhH3rF/ADaObSYGDkPJ03y5zdq0sJPMqr+7x+WAwAYgWv6QxQeiwDxphtxj8A/j/nEnLgTtFt+McoNv8+FvWiCX6ukM/8tvD1WKzsgrLkpeLeFJZvUNA+6pZT2gZJU316nWA4w0pijfqyTWciaxfzBfH29Oc9jWCBoMST3zYiecpHk0fRVdX9F1OdxIMO3YlwezhmkrW3ki6cXE6nZojtR0e+LXc5usaEH1bWAGQzxmsMVRcQ3baOUZ9Gvz67yRkS6XkrkaK/s5JSfoBNTT0zaPW9gG9VRHXBppaOH7raFNjws0gwc4JMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JEeLyRCa49K25TGJPg56UtR713ZoSzWV+NlQWrmaZY=;
 b=J1uAKmDsmnX+nbW9mwVJraiSRV3etzmZ/eShHtasmZelZnxv31LE3mb9fZ29o5HDpPstxMy1arPA1h8p/gNzPDr/+2mwpqgNwYW39aFZLb4qwSg+bJSJ5JPb/jpCWzdKnwt2ljEVc02hPG+PwOUGRhE9JB9czyY+cBLDcjxxBVYGGxWq2+RF9nfVIk3BuP6RIRz87PXHrUsUf+SLb0sP8H56ryd/N+9zniWIaD2H9Nw0sqNNG9mDMfU6xS1a1/qEWWLtiqEd5HGi4AjE4JuZa9tM8cT5+8scmh7suE156PSP9MVbtRiegBM9f8Jr09+uPy4j2MfA+XefvGS7BD6Zzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JEeLyRCa49K25TGJPg56UtR713ZoSzWV+NlQWrmaZY=;
 b=NhJzKtEpizs4QHmVnR117Ufvam1rEr8O3CjyK+EIUcBc3BuAh6yeKIm5j/oltH8GxS9Pgi2sYWigtXCtazjx/xb5uSIxPrTjdVazg5Oqfe4mAO6/5jEEVe3dG+Lg33rl2yTIxPXqnRqsZr1m6WfOcxZL5zbIyuWTo89O7bgPu/JljFWA0n1+XB+dR7h00j5MMl+YczHOfZGwDB/Lyq4vo+ZxwMVxL1fYAIeF9LN77FEjJhwmmZdLF2tMWFrqBrID1aJzD+q9VTGglkPPOIAa90i1gxNAukh8lED2/5ea4dAT/VU6M6ZLODZQv3Ytb2a6MOHkY3EP/wczloQSFHLiDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 15:44:14 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 15:44:14 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 04/14] phy: lynx-28g: convert iowrite32() calls with magic values to macros
Date: Thu,  4 Sep 2025 18:43:52 +0300
Message-Id: <20250904154402.300032-5-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM8PR04MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: af35c90b-bd70-45b4-2d10-08ddebc9e650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Id7UgPSNQ7lejtfMk76V/3jqa6gskxtO3PqmCcRgDETNq33m2lp9vXs0yzsy?=
 =?us-ascii?Q?2jZDNE+191OHsalqKbdHhU1fG07D9IBI0YowHCH5+JfFBpDyFPcj21YzA2HO?=
 =?us-ascii?Q?WkHk/3mce4Y4YUFMrI3goEhWltfD288RepDV9iibLOZiwQtVnTAq/Bav+WV2?=
 =?us-ascii?Q?/zeO8i9nJh31qum5SFMid9L4KvlVUyKQFIYn5e0qVssS3Dn7+cY4Nao4BkFt?=
 =?us-ascii?Q?8xwSe/dM0IhDmZRmcWk1p9UGczkn+rYOyDzxOBpTSflUnCE0bxcltV9GXkdQ?=
 =?us-ascii?Q?2Goq1ZqbryyfwXwb7VwMFVpPgRB/IHVcjz1k6WWk8O6gd7rOv4p7PUgz1P14?=
 =?us-ascii?Q?hiAtMV88VKPiTJwTytLg+qDMHGDxExP5R1cpKtWxgZhTLs+ETfLzpHJFOMmr?=
 =?us-ascii?Q?g7hDOwls97NMpcEi1ybpGwLKpezgnXegbfiGdCMDoabL9u3qv5DnMoBFUYHr?=
 =?us-ascii?Q?hCND0yHnUcWwBMqacGMvXPKHPM/D3+s/tFhivIScB6y/LBlwmZUORBN2LU2G?=
 =?us-ascii?Q?MVHCdZas3IjveKjXf27DLvgJ7z2r0motTZX94BWJopwAw6h2YCF6PVFZFDVQ?=
 =?us-ascii?Q?PE0+8G53j3C2ueWwJr/pdaPrayiikdauDXdUrmykKID3c9qYRCYrYq1Y9Qtp?=
 =?us-ascii?Q?TOGTs5UKYwmaHWd2W5Nm/PbOJ2suuLOwa+CL/aEBqcD7S03Cu0xnG2aU7n5c?=
 =?us-ascii?Q?RRuQ5mHwJHwDPpbZ29aD/MhcINWn7f5JxkL+ikBf3H5bpShHY6HikZ1BXOeb?=
 =?us-ascii?Q?W024+qnMOleZq9oiVwq/w0DLfBIiFvYM58pY9W8W0ypqLoZgxu33wzIYd6Gp?=
 =?us-ascii?Q?qC0Euj0MyRLvkob9uymqzSDVtSaS577UtI0tbTEv18b62m+oVCjx8TpZlMtt?=
 =?us-ascii?Q?0w9bXVo34T/MnEb1AfR3K+a9pVNJ3CDiR/nB3wfxj82SGA+Y9AUBjurEH5qj?=
 =?us-ascii?Q?ytNJ4oG9Nxd6oH/MvZn5NDW4He2z/EKxUG4E9OQ2mEujA/bNqYivrs8bz6ci?=
 =?us-ascii?Q?g5LJ73GiUzFClV2MUHqu64iGmjJpD22gz82ZG8OiKrAR8EI8EWH/Yn7J4dc5?=
 =?us-ascii?Q?AMDLxRZ+W8yHcj62nPkqTbdkjmTkvLrvYwiZkC7fCipXwEA1dTg3ozvgQVu5?=
 =?us-ascii?Q?FSlN7kcUof5vVVlAKx6G5Tv5NikfPYl3juuXCa+FjpbTIuCD/FI1QAd00UMu?=
 =?us-ascii?Q?XMhdawnmvDjoaWT4BrfoMybI0drnkhXLFOxDGGzu4+ZZO5l2fwKjP2WFi/hE?=
 =?us-ascii?Q?Uzwk8FRuJz17sWhwdxSG3UduHHpALQgtKNm2ERzD5f9Fw9VVZgu8aypNxOAF?=
 =?us-ascii?Q?bEXm+2U0/BqdXF6eYaa5DNmOKRJPJHfulrxdyqXbGMYMfzS4oRjHLzzhsQhc?=
 =?us-ascii?Q?v1hawl4jewHPPxYYKgYJLWsPIcNHmZq6+Hb8Ihti/cngmuc915guBrLrV+mY?=
 =?us-ascii?Q?dRMEBEc5UFAyc9Qrow5FT5hAGGN5+uJMfbjcJYm7y4uUt4RbOLA7ng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nWLZe8l0TyOlNLLU0UGEekbBEZBZASEPpi8vNRqkygagY4oNz7G3PUfNMwp+?=
 =?us-ascii?Q?EHNA6s/Q0HuQ/3DySErymsN9arQZNcA5zcUsEbMsamvknWBKI07YPl2Uf9kM?=
 =?us-ascii?Q?juQwAZl1s2N36MwYVhBFNsk8CkBmzPiqir04LkgxNlsifLdHqeiIQNdfrkrn?=
 =?us-ascii?Q?z+Bq99JHWzTRpElkvrUqPL035BZA29Y3Nw7RLMnoJe45uduJBEQg4TxXP0Sj?=
 =?us-ascii?Q?3CxGz6fTkZmDpBWf9P+17uf1eivA93hlbGWW+aYFev8paBUFODI+7T6ry34s?=
 =?us-ascii?Q?X+HHpTnRM8dji4XOnmvOG/u8dFrc0ZyGem4M+8vyE0445dy7BF6Nrxti0htm?=
 =?us-ascii?Q?bcWmD16fZsw0xZTFGqWEI1AIQM2BIKyvRZ8O4YeVDXGgWpIl97LcxY3EycH1?=
 =?us-ascii?Q?0WTWQfFzn0S26RJW4IdSTXj5N5tIWjydU7nXEzg60x4yPzu+JD8FrdtbJpBl?=
 =?us-ascii?Q?4x1PEuQ111rx67Seku0TijFeDW+e1vW5//EmlPLC08zDF0arI4Rz6dOEsjnO?=
 =?us-ascii?Q?B+xklaRlXqcwPsVx4xyfN0u+ql6PF9iLNQb1mTmnfyj5lYsOq9c29h/JfyK/?=
 =?us-ascii?Q?H1bAe6sbLuZXSatEW9OKWKJHcWur+i+lH9Mf7rrpebWdAxFizvVXpigW3QYq?=
 =?us-ascii?Q?ZLoS15/SWnururXzQ36ADHUUxX6X23Z6s04kn1H3XOcl5zppD7poNaiiDmVE?=
 =?us-ascii?Q?MuARD89/PJ1nwPMe8jnOn6jVNg1PKedMmg8ty7k5BvbHvQycCfFk+tZcY2Iw?=
 =?us-ascii?Q?S8vLsC+2yQWZ5oAzTpbSNdkF3072a7uehTtjrjuH55bl36r146k/R4W4nkHg?=
 =?us-ascii?Q?8FRal2Nz1VyzsL2wOP2/55JZDPe+3SGcrL4VRorzwgTvqgS/gfZEyn9qhP6B?=
 =?us-ascii?Q?QyRFJy+8Ykpk0yCjcFW0KDnOKtpOJ1i33g2D1rk7+h7+sBgC2ytCiS9gD7dP?=
 =?us-ascii?Q?pRRVa5iGzn/Xh+mmbitnCW3ofkemXgRFVSLk+5ebagccapklbn/LZQDSTXss?=
 =?us-ascii?Q?N8mOyOGZycK6DKBwKx8at9qOs7rcZjd4xDs6IQXG8ib9OciXE8p/qfin6GCK?=
 =?us-ascii?Q?SvGU8Xw+P47ERE5sq0MBRhsIqiUf3QVDteY6pDD9Z30gxOduvzGKmiHu7ODJ?=
 =?us-ascii?Q?huTESDTEsxTtVnYyr5HKSAIx5IHrZKnu5ISW6SZQI13WMi39yzH0pnSq6mEm?=
 =?us-ascii?Q?+1nrFITaLcCp/FDOpMfa08riiHG+82vZAuhERQzU18Su9YsfEkTamEVUTRzq?=
 =?us-ascii?Q?f/xxCAx8wi2yo/EgIWJh6YCq4uoJwtAnpol7e8zRsQtP/vJxl5NpHWXKWHMX?=
 =?us-ascii?Q?1OOaokUoLbdc3oAJ3Zcp87KZJOkzqEPtLvn1MlfNWaxEcZoANQFmIS/TzWq7?=
 =?us-ascii?Q?fQ0GsUDvZvgMijUzdZAtshHn20o98ePj1nZYtGLMwS7BiLDhOotrakeqgdeV?=
 =?us-ascii?Q?z/IMx2WIIWnF5ObptrADWX4ArB3oOrfCGF9jEVkOj5EAeMyJ63M+7CfhCFFt?=
 =?us-ascii?Q?dkuFY4FpVt25XF+fhinbfhjVjY4xeLMKSTFFxywsyFNuXXVzs7nYMK6ZCo8Z?=
 =?us-ascii?Q?hUttzlfHwEnx9wwKJ+5SEWbL0acnxjivB5evKA53gmOL4Ply49w8XmKGD8Ka?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af35c90b-bd70-45b4-2d10-08ddebc9e650
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:44:14.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WputvYmVczp8+nDStev3JmtzI10CI4w7nL1uoGhow9RHSRtsTkDSFY/r55Z91DqAUD7hiPB6AeiAMJBJRY8TlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348

The driver will need to become more careful with the values it writes to
the TX and RX equalization registers. As a preliminary step, convert the
magic numbers to macros defining the register field meanings.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 103 ++++++++++++++++++++---
 1 file changed, 91 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 414d9a4bcbb7..60a7d1a63dd7 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -70,6 +70,12 @@
 #define LNaTGCR0_N_RATE_QUARTER			0x2
 
 #define LNaTECR0(lane)				(0x800 + (lane) * 0x100 + 0x30)
+#define LNaTECR0_EQ_TYPE			GENMASK(30, 28)
+#define LNaTECR0_EQ_SGN_PREQ			BIT(23)
+#define LNaTECR0_EQ_PREQ			GENMASK(19, 16)
+#define LNaTECR0_EQ_SGN_POST1Q			BIT(15)
+#define LNaTECR0_EQ_POST1Q			GENMASK(12, 8)
+#define LNaTECR0_EQ_AMP_RED			GENMASK(5, 0)
 
 /* Lane a Rx Reset Control Register */
 #define LNaRRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x40)
@@ -89,12 +95,57 @@
 #define LNaRGCR0_N_RATE_QUARTER			0x2
 
 #define LNaRGCR1(lane)				(0x800 + (lane) * 0x100 + 0x48)
+#define LNaRGCR1_RX_ORD_ELECIDLE		BIT(31)
+#define LNaRGCR1_DATA_LOST_FLT			BIT(30)
+#define LNaRGCR1_DATA_LOST			BIT(29)
+#define LNaRGCR1_IDLE_CONFIG			BIT(28)
+#define LNaRGCR1_ENTER_IDLE_FLT_SEL		GENMASK(26, 24)
+#define LNaRGCR1_EXIT_IDLE_FLT_SEL		GENMASK(22, 20)
+#define LNaRGCR1_DATA_LOST_TH_SEL		GENMASK(18, 16)
+#define LNaRGCR1_EXT_REC_CLK_SEL		GENMASK(10, 8)
+#define LNaRGCR1_WAKE_TX_DIS			BIT(5)
+#define LNaRGCR1_PHY_RDY			BIT(4)
+#define LNaRGCR1_CHANGE_RX_CLK			BIT(3)
+#define LNaRGCR1_PWR_MGT			GENMASK(2, 0)
 
 #define LNaRECR0(lane)				(0x800 + (lane) * 0x100 + 0x50)
+#define LNaRECR0_EQ_GAINK2_HF_OV_EN		BIT(31)
+#define LNaRECR0_EQ_GAINK2_HF_OV		GENMASK(28, 24)
+#define LNaRECR0_EQ_GAINK3_MF_OV_EN		BIT(23)
+#define LNaRECR0_EQ_GAINK3_MF_OV		GENMASK(20, 16)
+#define LNaRECR0_EQ_GAINK4_LF_OV_EN		BIT(7)
+#define LNaRECR0_EQ_GAINK4_LF_DIS		BIT(6)
+#define LNaRECR0_EQ_GAINK4_LF_OV		GENMASK(4, 0)
+
 #define LNaRECR1(lane)				(0x800 + (lane) * 0x100 + 0x54)
+#define LNaRECR1_EQ_BLW_OV_EN			BIT(31)
+#define LNaRECR1_EQ_BLW_OV			GENMASK(28, 24)
+#define LNaRECR1_EQ_OFFSET_OV_EN		BIT(23)
+#define LNaRECR1_EQ_OFFSET_OV			GENMASK(21, 16)
+
 #define LNaRECR2(lane)				(0x800 + (lane) * 0x100 + 0x58)
+#define LNaRECR2_EQ_OFFSET_RNG_DBL		BIT(31)
+#define LNaRECR2_EQ_BOOST			GENMASK(29, 28)
+#define LNaRECR2_EQ_BLW_SEL			GENMASK(25, 24)
+#define LNaRECR2_EQ_ZERO			GENMASK(17, 16)
+#define LNaRECR2_EQ_IND				GENMASK(13, 12)
+#define LNaRECR2_EQ_BIN_DATA_AVG_TC		GENMASK(5, 4)
+#define LNaRECR2_SPARE_IN			GENMASK(1, 0)
 
 #define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
+#define LNaRSCCR0_SMP_OFF_EN			BIT(31)
+#define LNaRSCCR0_SMP_OFF_OV_EN			BIT(30)
+#define LNaRSCCR0_SMP_MAN_OFF_EN		BIT(29)
+#define LNaRSCCR0_SMP_OFF_RNG_OV_EN		BIT(27)
+#define LNaRSCCR0_SMP_OFF_RNG_4X_OV		BIT(25)
+#define LNaRSCCR0_SMP_OFF_RNG_2X_OV		BIT(24)
+#define LNaRSCCR0_SMP_AUTOZ_PD			BIT(23)
+#define LNaRSCCR0_SMP_AUTOZ_CTRL		GENMASK(19, 16)
+#define LNaRSCCR0_SMP_AUTOZ_D1R			GENMASK(13, 12)
+#define LNaRSCCR0_SMP_AUTOZ_D1F			GENMASK(9, 8)
+#define LNaRSCCR0_SMP_AUTOZ_D1F			GENMASK(9, 8)
+#define LNaRSCCR0_SMP_AUTOZ_EG1R		GENMASK(5, 4)
+#define LNaRSCCR0_SMP_AUTOZ_EG1F		GENMASK(1, 0)
 
 #define LNaPSS(lane)				(0x1000 + (lane) * 0x4)
 #define LNaPSS_TYPE				GENMASK(30, 24)
@@ -104,6 +155,12 @@
 #define SGMIIaCR1(lane)				(0x1804 + (lane) * 0x10)
 #define SGMIIaCR1_SGPCS_EN			BIT(11)
 
+enum lynx_28g_eq_type {
+	EQ_TYPE_NO_EQ = 0,
+	EQ_TYPE_2TAP = 1,
+	EQ_TYPE_3TAP = 2,
+};
+
 struct lynx_28g_priv;
 
 struct lynx_28g_pll {
@@ -151,6 +208,8 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 	lynx_28g_rmw((lane)->priv, reg(lane->id), val, mask)
 #define lynx_28g_lane_read(lane, reg)			\
 	ioread32((lane)->priv->base + reg((lane)->id))
+#define lynx_28g_lane_write(lane, reg, val)		\
+	iowrite32(val, (lane)->priv->base + reg((lane)->id))
 #define lynx_28g_pll_read(pll, reg)			\
 	ioread32((pll)->priv->base + reg((pll)->id))
 
@@ -311,12 +370,22 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 			  SGMIIaCR1_SGPCS_EN);
 
 	/* Configure the appropriate equalization parameters for the protocol */
-	iowrite32(0x00808006, priv->base + LNaTECR0(lane->id));
-	iowrite32(0x04310000, priv->base + LNaRGCR1(lane->id));
-	iowrite32(0x9f800000, priv->base + LNaRECR0(lane->id));
-	iowrite32(0x001f0000, priv->base + LNaRECR1(lane->id));
-	iowrite32(0x00000000, priv->base + LNaRECR2(lane->id));
-	iowrite32(0x00000000, priv->base + LNaRSCCR0(lane->id));
+	lynx_28g_lane_write(lane, LNaTECR0,
+			    LNaTECR0_EQ_SGN_PREQ | LNaTECR0_EQ_SGN_POST1Q |
+			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 6));
+	lynx_28g_lane_write(lane, LNaRGCR1,
+			    FIELD_PREP(LNaRGCR1_ENTER_IDLE_FLT_SEL, 4) |
+			    FIELD_PREP(LNaRGCR1_EXIT_IDLE_FLT_SEL, 3) |
+			    LNaRGCR1_DATA_LOST_FLT);
+	lynx_28g_lane_write(lane, LNaRECR0,
+			    LNaRECR0_EQ_GAINK2_HF_OV_EN |
+			    FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV, 31) |
+			    LNaRECR0_EQ_GAINK3_MF_OV_EN |
+			    FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV, 0));
+	lynx_28g_lane_write(lane, LNaRECR1,
+			    FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
+	lynx_28g_lane_write(lane, LNaRECR2, 0);
+	lynx_28g_lane_write(lane, LNaRSCCR0, 0);
 }
 
 static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
@@ -353,12 +422,22 @@ static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 	lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
 
 	/* Configure the appropriate equalization parameters for the protocol */
-	iowrite32(0x10808307, priv->base + LNaTECR0(lane->id));
-	iowrite32(0x10000000, priv->base + LNaRGCR1(lane->id));
-	iowrite32(0x00000000, priv->base + LNaRECR0(lane->id));
-	iowrite32(0x001f0000, priv->base + LNaRECR1(lane->id));
-	iowrite32(0x81000020, priv->base + LNaRECR2(lane->id));
-	iowrite32(0x00002000, priv->base + LNaRSCCR0(lane->id));
+	lynx_28g_lane_write(lane, LNaTECR0,
+			    FIELD_PREP(LNaTECR0_EQ_TYPE, EQ_TYPE_2TAP) |
+			    LNaTECR0_EQ_SGN_PREQ |
+			    FIELD_PREP(LNaTECR0_EQ_PREQ, 0) |
+			    LNaTECR0_EQ_SGN_POST1Q |
+			    FIELD_PREP(LNaTECR0_EQ_POST1Q, 3) |
+			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 7));
+	lynx_28g_lane_write(lane, LNaRGCR1, LNaRGCR1_IDLE_CONFIG);
+	lynx_28g_lane_write(lane, LNaRECR0, 0);
+	lynx_28g_lane_write(lane, LNaRECR1, FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
+	lynx_28g_lane_write(lane, LNaRECR2,
+			    LNaRECR2_EQ_OFFSET_RNG_DBL |
+			    FIELD_PREP(LNaRECR2_EQ_BLW_SEL, 1) |
+			    FIELD_PREP(LNaRECR2_EQ_BIN_DATA_AVG_TC, 2));
+	lynx_28g_lane_write(lane, LNaRSCCR0,
+			    FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_D1R, 2));
 }
 
 static int lynx_28g_power_off(struct phy *phy)
-- 
2.34.1


