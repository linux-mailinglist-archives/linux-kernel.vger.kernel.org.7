Return-Path: <linux-kernel+bounces-892689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99DAC459D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8EE18906B3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EFD302CA6;
	Mon, 10 Nov 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RYj3YNiy"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB29E2FF66A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766595; cv=fail; b=IyTgY8K8Y58l/v6Za/QJal7kcXB1azDJyYKMCIlUj2xEYX3H36bBtoSSBv67eGB8nKEVB+hBxSLgv5jI0FbXgqpc1jDyQZfyhaiQvltWA5xUhhq7TVS85777w9w1rjmcIY86rVmclEXmTT/P3qg4rF6mP2Sv9YIaTynrAeNonH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766595; c=relaxed/simple;
	bh=jmDEbIrQiIvGiek2qOhtj8dTajd2scS9/c7+tl1it0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lodPTnZgf1Ls0x/JMLjop2BkeECZBtHteTAYbfZlFD6ihtsf8dncq9CPkUiR2x2kZEbdKWoF4tcGkDPF0Ax34mY6pqTEEMuStmh7jFJPazBOm0ZrVACVpJdpQP+h5FDUxI9fL3RZzdvbv1fXkoW9Dog4+coCr6tBSMxqxarMFJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RYj3YNiy; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ul40jBFZ1TkJWMBoxc8cPauqlB1i7Dejz/naLmvLYVxlCkPbkf5GUGmSHyE8extZhBea/m90/Cu1XDUsMfTwy8fEVcvr7URu15BcMMlzkb34rCdAV6cmGEXtS7iLnxfbTLSCoTU4g7MaffuyUHCK1K+LTVqSN39IwA1WrKu0uXCxFpQdMIQrWSeEAzNrbCH4zCKq00QbgaXK6EU9WOdavMPKNNmXN9fdw5CjCGNZxl8Eh68/Wbb9sFXu7EOr/gcxbBllMAFtWKiYJMUZa/sQBTFwUzs7lF4lFVew0Eso+2c5Yh/wq+k61vOPOcEKcZdluhWu9oTSUbf1iFFmg1RkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjxMsuSXJnqkjNxS2m6Fz19pRHWpH3OjbP4OX+tDj7s=;
 b=qTDJAZOKLfuX9Y22F54C1vzHPGQ3IeWrn6RqjWAfA0VimfKQ/5dGAOT5fljHGlwOP10VaqmhFzbCL4PWeboYNz9mlD55lnhdrp8Nx/nBgZY8mM65btu6iCcog0AjAw2JYaFfxF2+zE0hkjUr4wb0PkjEuDrejyYItRzx40e2cmBRhDssU+/fhvPCwYiOyf3Exxt39FpkmkS6OL7bcR8Q7pjDwxqKjzkgGA2fafE8Sw9d2UsxnAfzZCPmkczVjie2TX8irFrn2vrYRCeuTlDuwiPh7MVBA4caEZyzLNsHHCxHSkexzuoiaGaArFD5uOb6gtA6uUdnmc7TQZac3LrfQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjxMsuSXJnqkjNxS2m6Fz19pRHWpH3OjbP4OX+tDj7s=;
 b=RYj3YNiyO4waOIFcS82BUbHcycV8HcqdOrkfwqWGtRc7Cup0eMnqMlo5LS52ScUkehkrSe3iZgknvHZQLXHrPSLxqe9dvunjztgdcjRLSNydtATcfKFNEvMT6DTaPU9jM+lm8PYZGI+WDbPwY7c297GsLhV/TqQJQ5oQnvybaxfOI2uxh6NaI1f8CD0QnDhz4Bp2NNwfG70jWkVYqV3hKthk92ngxMcwdRH2nmHzM8Jt3oMeJPUK7DGqqR6gKMahGcCrVjj+JrHakmgw8Mspfstxzs9eNDS8LmABR8WbsoH0mULaYYRSuH/i5E3vSp+7R2nrpXv2FMikJdWVpLvSfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10468.eurprd04.prod.outlook.com (2603:10a6:102:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:23:04 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:23:04 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 phy 09/16] phy: lynx-28g: make lynx_28g_set_lane_mode() more systematic
Date: Mon, 10 Nov 2025 11:22:34 +0200
Message-Id: <20251110092241.1306838-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10468:EE_
X-MS-Office365-Filtering-Correlation-Id: 779671b0-216d-405f-5b88-08de203ac069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AYKXlI0VZl7GwW58r/qfNmkw6lCv+5fRlqU85/9oxNGQJ7oKefP6HOTa7Zwi?=
 =?us-ascii?Q?5NqV+2HzLQyF+SQ9ImYkiCvcTxWP5X0v94Y7IVgxKXSPxnNT0uQzH0DsFA7x?=
 =?us-ascii?Q?HCADhDOCCiux1AXDJm1CbDWHbGBcR8mFJKXVAf+6OyLb03uELZ+FOQL+mSQy?=
 =?us-ascii?Q?doUBGtrfU86dcqGbx1+kbvhjUbHcYWJCCs/fdFxBIdNXMxFZLNy/b2ZMqp7Y?=
 =?us-ascii?Q?LSf/T3eLEBd1a4PtW7QZuqyTBxwcMCFaLS38ZBM/EMG3mlYrJb6TL6KY9LXN?=
 =?us-ascii?Q?SplDjSAiFuZX3NXxh4G0952OSWXySHQIU+JJMSJdTwMDX3gyc1NEjauFH2UI?=
 =?us-ascii?Q?Bftwdl19H+Ex8aEvQtOIosK39Maex5nUgo1CUzJ2avtOvlNqPznhRqq/7Din?=
 =?us-ascii?Q?IIvS3zWXNNsG+vmylUSMz8ul91cvsu5K1MN629WkeBjlERmGWtU4i/zLqMfB?=
 =?us-ascii?Q?hwQLRQ2x2lqBk44QFqwQDgrjVC8twaI8kfh1yQpEgn8/8mauyZXWrLUqUuux?=
 =?us-ascii?Q?FnUnJqluGrojCRf2Z2N9PeMWPAIGXEIIkmyWLK8yO68xEDjjl6MmQWNRKrkk?=
 =?us-ascii?Q?wUZL1+nfww7ULlZG8ZOVk5r8qRg10BZ6kOaSB+Wd+KNRF9KrnmbNl34gulVm?=
 =?us-ascii?Q?t5XDg8dTCuNqFkYuVC5zJu5J9ZLf12eiosAu3pGMSoNG8FptlAyoYu+RgsfC?=
 =?us-ascii?Q?9m10fJwF45GhK3Ct7SjMWw6Z0stOqZE1NXD0wWNOgTDPJyshfau8qO3Ynme3?=
 =?us-ascii?Q?mZL5xM0GskeQbglSXHdgu/o7QbM0z1pvzJDc+RHHBWWePv8J7l9iIX6sFdWs?=
 =?us-ascii?Q?0Z2oOtzM/ZNUP5PliQSjK6FlrBiys+K3JP58y5duIfWXZodEXmfkJd9tNZ7X?=
 =?us-ascii?Q?VPD1eAzFk0907qsAX+4ZY7Xai/WTF9QHjW+xYpcp793e5vPfR7MSSG3O0IwB?=
 =?us-ascii?Q?Xu3i1MbL3hJ+LfVhk8+fyTaqdiKVazkBkTZgqFk18/QwZIqsagO49tj4IIHp?=
 =?us-ascii?Q?RXJvGhWFKnbv1JtoqHJqNW4aNCE0v7lglsIkqe9dDaGsyY6QqCb1fUZqDN40?=
 =?us-ascii?Q?rev39WSlP+Kq3++ZWgTPpM/AOc4a5VpAyjNzNusk3lMbQlDarYcfXbppa8pH?=
 =?us-ascii?Q?Tq8GMvs+aNWl+Y7SWaofLzl/jrYCz3zblZ0C5jMWR/IwWpXXvj3hBa0BFz8J?=
 =?us-ascii?Q?Kf17g9Y8AlYGSjYqA69IMftPOHj4isbx73pQSqFUeUJIdGmy8M21dKsN+B2c?=
 =?us-ascii?Q?xwnMmxaqjkGZHfcoId6B+p7qlk2WafF+4eGKKhYkmX4+ZhXJiLoJqaXLX9bd?=
 =?us-ascii?Q?8KMAR8DHcdNMsnTnTz5yWobJKmi/LB+mEAJYTznWMrdbhCIzGV529nwIDAJo?=
 =?us-ascii?Q?TdM3uPwuZti/Hd0Ns/wJFc8YKz3aHGpxa6tyNvdiYRSMc37NvAA5HbPCH1sp?=
 =?us-ascii?Q?wu2iBm/N7ahb321KbzS35nq5i0MN+t9RWjvNUKjCVlzzDSurl/NnTnTxieNR?=
 =?us-ascii?Q?qkIKGVoruB07wX4fXBclaHRbgX84WpWMXXop?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5KKicsP6blnVWrjw9/EJPSFvtYCkBMSlnvcWjZGtykQFmQT0OgaFZ/wd1JfF?=
 =?us-ascii?Q?FUX67TaU2zPxEl0zgOKmN4GGkR2r6zvML1/4s7JzSGkuYwg+eZupP1OwEzQ8?=
 =?us-ascii?Q?WIoZDw/0g4iHkH+w7zhb9ppmXS/0fI3KPyL0YXPYHCrGLVvAu3587N7gFrRM?=
 =?us-ascii?Q?7zOz+Ev+ory7ZVRW/KMlg629D0xF5CrQtJUzWmefIzxVviBwloUru8iUThv7?=
 =?us-ascii?Q?9j/dUox7oy5c4LwiMHv58iyjVwwJ/jPuNSNluh3+HXNilUxQO7z9ChAZJ4/C?=
 =?us-ascii?Q?Pc29guKiL/fo5I3yYtPGlkFMH5g7/JyenutfqU30G8Spl47/3haI2nI24AR0?=
 =?us-ascii?Q?cAqi7zHH4NN7dtTFpkdQ9p+r+31s7wG2ySKkweLSt0hux1rGMwnAAX5G72qV?=
 =?us-ascii?Q?ZAE6bjObFD8L+CmuSzFXA7ITfeJqdFwnCvTzBS1sBj4nolB/1g4Z8ww+O++y?=
 =?us-ascii?Q?/DdHa8RvQj94Ih2MdLqg0mpYH1shmuSWJt85YzN3b0HMhsiFRwdPCdXiFog6?=
 =?us-ascii?Q?wO7kh7uvoZSjiWuEWy7kHmUSBw+Fj3qF264SFAbV43Or/J7wSduWF+VTD+h7?=
 =?us-ascii?Q?bPFTYz5QdEMYSt3M3Uwe5EpeiX9NToN/KXP+ZpMmiy4SVOIX7ZraqFcB7hnQ?=
 =?us-ascii?Q?jDLhXt26zWcEzhTXdC+XKy+28AuBc8Nwfzc0YqEIZB93bVzejxXjVW0pph/S?=
 =?us-ascii?Q?1wIKTlsKbmDmH7A8iWcHqOSEuuhoL2cPhF85KmeU43ZT1xMEWpNAzZCniUfi?=
 =?us-ascii?Q?McnLpaiZ3xOQHlD2PKlKcR2SDaocp8eOQlnjGyR4a9hkMjyBFCCmmsIIW/+I?=
 =?us-ascii?Q?+TBhofK1IoIkcAYiazOd7qHL/wU2YIpabsGBFb5Xh6B/90eHQo3MEq8B7P2Q?=
 =?us-ascii?Q?GgGT/0J9vw99bCAe2BnMD/n508b2UEODcNdiMP5aN2CrZfmNHAT0uhlqig4i?=
 =?us-ascii?Q?oDZ6vny69jdtv0WoM9qrc0A9qKNPCOClJmPgPi/mwsj3AIZZPFzeBmANH6dK?=
 =?us-ascii?Q?9+GPbm5ThQWoAV0rIWVlTCS9E8UdPVVSN66xkz5nMycTA8NUaPbYvt0vMZM1?=
 =?us-ascii?Q?9lZjSn1ev2avtuILf8tu5AQf8/AzaLeAsbJUmVId/TNAoBAVczZakvNcIlee?=
 =?us-ascii?Q?0d230i6EdnXyips0mRJ/kz97jBr5GFehJqhg+aXAzgItYarO1qHjuTGpqsO4?=
 =?us-ascii?Q?eao7ETehZ+GzeYxuYOWT/CbcU04t/Z8e2B/SkPlag/mmgUTEiR5Ky8ONce9B?=
 =?us-ascii?Q?k/VSHSSUor/ZraQqdeIpl/W3lOZPIMUlG3p8gaM3m1p39O2AGojYl+XqwHok?=
 =?us-ascii?Q?BGPu9F1iVyHGaVIgwWLsh4FCXfWPcLUT3dR3yxdtnB57suzs/fJQ2JXWgldc?=
 =?us-ascii?Q?jayCEi3tD2j8vshfX3ltrLIfOagmKplrUdGVldMdZwizGX4MINpvl7ku0EIX?=
 =?us-ascii?Q?AEa089M4Cf/75GyclHHWGJP8oDEdG8oAsPn848AGJgrmqVrFJe16yo+6LOS5?=
 =?us-ascii?Q?Wy/oRnAtA5wn8FZXZZ4erk0Me9BQWmL4N+jehz1i4nyPy5HQjfVjs67pFRQc?=
 =?us-ascii?Q?hrWg/EX6l8C6hEAQyMbtUAYz1s84Ck2m9VEFjsF3QXFkWGtHS35DVHSGj0fq?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779671b0-216d-405f-5b88-08de203ac069
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:23:04.5845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOqQnED2IrSS4AAsf0TvmnqD1dewYYjQdl7WnxUBN0lNiNehlLhNWq7vbl8ZZ00khc/f5Y78BrRBIIclJm7GWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10468

The current approach of transitioning from one SerDes protocol to
another in lynx_28g_set_lane_mode() is too poetic.

Because the driver only supports 1GbE and 10GbE, it only modifies those
registers which it knows are different between these two modes. However,
that is hardly extensible for 25GbE, 40GbE, backplane modes, etc.

We need something more systematic to make sure that all lane and
protocol converter registers are written to consistent values, no matter
what was the source lane mode.

For that, we need to introduce tables with register field values, for
each supported lane mode.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v4: none
v1->v2: fix LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH access by using
        FIELD_PREP()

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 659 +++++++++++++++++------
 1 file changed, 496 insertions(+), 163 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index bf06ce42e291..83d9cbae251b 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -12,32 +12,32 @@
 #define LYNX_28G_NUM_LANE			8
 #define LYNX_28G_NUM_PLL			2
 
-#define LNa_PCC_OFFSET(lane)			(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
-
-/* General registers per SerDes block */
+/* SoC IP wrapper for protocol converters */
 #define PCC8					0x10a0
-#define PCC8_SGMIInCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
-#define PCC8_SGMIInCFG_EN(lane)			PCC8_SGMIInCFG(lane, 1)
-#define PCC8_SGMIInCFG_MSK(lane)		PCC8_SGMIInCFG(lane, GENMASK(2, 0))
-#define PCC8_SGMIIn_KX(lane, x)			((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
-#define PCC8_SGMIIn_KX_MSK(lane)		PCC8_SGMIIn_KX(lane, 1)
-#define PCC8_MSK(lane)				PCC8_SGMIInCFG_MSK(lane) | \
-						PCC8_SGMIIn_KX_MSK(lane)
+#define PCC8_SGMIIa_KX				BIT(3)
+#define PCC8_SGMIIa_CFG				BIT(0)
 
 #define PCCC					0x10b0
-#define PCCC_SXGMIInCFG(lane, x)		(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
-#define PCCC_SXGMIInCFG_EN(lane)		PCCC_SXGMIInCFG(lane, 1)
-#define PCCC_SXGMIInCFG_MSK(lane)		PCCC_SXGMIInCFG(lane, GENMASK(2, 0))
-#define PCCC_SXGMIInCFG_XFI(lane, x)		((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
-#define PCCC_SXGMIInCFG_XFI_MSK(lane)		PCCC_SXGMIInCFG_XFI(lane, 1)
-#define PCCC_MSK(lane)				PCCC_SXGMIInCFG_MSK(lane) | \
-						PCCC_SXGMIInCFG_XFI_MSK(lane)
+#define PCCC_SXGMIIn_XFI			BIT(3)
+#define PCCC_SXGMIIn_CFG			BIT(0)
 
 #define PCCD					0x10b4
-#define PCCD_E25GnCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCCD_OFFSET(lane))
-#define PCCD_E25GnCFG_EN(lane)			PCCD_E25GnCFG(lane, 1)
-#define PCCD_E25GnCFG_MSK(lane)			PCCD_E25GnCFG(lane, GENMASK(2, 0))
-#define PCCD_MSK(lane)				PCCD_E25GnCFG_MSK(lane)
+#define PCCD_E25Gn_CFG				BIT(0)
+
+#define PCCE					0x10b8
+#define PCCE_E40Gn_LRV				BIT(3)
+#define PCCE_E40Gn_CFG				BIT(0)
+#define PCCE_E50Gn_LRV				BIT(3)
+#define PCCE_E50GnCFG				BIT(0)
+#define PCCE_E100Gn_LRV				BIT(3)
+#define PCCE_E100Gn_CFG				BIT(0)
+
+#define SGMII_CFG(id)				(28 - (id) * 4) /* Offset into PCC8 */
+#define SXGMII_CFG(id)				(28 - (id) * 4) /* Offset into PCCC */
+#define E25G_CFG(id)				(28 - (id) * 4) /* Offset into PCCD */
+#define E40G_CFG(id)				(28 - (id) * 4) /* Offset into PCCE */
+#define E50G_CFG(id)				(20 - (id) * 4) /* Offset into PCCE */
+#define E100G_CFG(id)				(12 - (id) * 4) /* Offset into PCCE */
 
 /* Per PLL registers */
 #define PLLnRSTCTL(pll)				(0x400 + (pll) * 0x100 + 0x0)
@@ -92,6 +92,10 @@
 #define LNaTECR0_EQ_POST1Q			GENMASK(12, 8)
 #define LNaTECR0_EQ_AMP_RED			GENMASK(5, 0)
 
+#define LNaTECR1(lane)				(0x800 + (lane) * 0x100 + 0x34)
+#define LNaTECR1_EQ_ADPT_EQ_DRVR_DIS		BIT(31)
+#define LNaTECR1_EQ_ADPT_EQ			GENMASK(29, 24)
+
 /* Lane a Rx Reset Control Register */
 #define LNaRRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x40)
 #define LNaRRSTCTL_HLT_REQ			BIT(27)
@@ -147,6 +151,21 @@
 #define LNaRECR2_EQ_BIN_DATA_AVG_TC		GENMASK(5, 4)
 #define LNaRECR2_SPARE_IN			GENMASK(1, 0)
 
+#define LNaRECR3(lane)				(0x800 + (lane) * 0x100 + 0x5c)
+#define LNaRECR3_EQ_SNAP_START			BIT(31)
+#define LNaRECR3_EQ_SNAP_DONE			BIT(30)
+#define LNaRECR3_EQ_GAINK2_HF_STAT		GENMASK(28, 24)
+#define LNaRECR3_EQ_GAINK3_MF_STAT		GENMASK(20, 16)
+#define LNaRECR3_SPARE_OUT			GENMASK(13, 12)
+#define LNaRECR3_EQ_GAINK4_LF_STAT		GENMASK(4, 0)
+
+#define LNaRECR4(lane)				(0x800 + (lane) * 0x100 + 0x60)
+#define LNaRECR4_BLW_STAT			GENMASK(28, 24)
+#define LNaRECR4_EQ_OFFSET_STAT			GENMASK(21, 16)
+#define LNaRECR4_EQ_BIN_DATA_SEL		GENMASK(15, 12)
+#define LNaRECR4_EQ_BIN_DATA			GENMASK(8, 0) /* bit 9 is reserved */
+#define LNaRECR4_EQ_BIN_DATA_SGN		BIT(8)
+
 #define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
 #define LNaRSCCR0_SMP_OFF_EN			BIT(31)
 #define LNaRSCCR0_SMP_OFF_OV_EN			BIT(30)
@@ -161,20 +180,199 @@
 #define LNaRSCCR0_SMP_AUTOZ_EG1R		GENMASK(5, 4)
 #define LNaRSCCR0_SMP_AUTOZ_EG1F		GENMASK(1, 0)
 
+#define LNaTCSR0(lane)				(0x800 + (lane) * 0x100 + 0xa0)
+#define LNaTCSR0_SD_STAT_OBS_EN			BIT(31)
+#define LNaTCSR0_SD_LPBK_SEL			GENMASK(29, 28)
+
 #define LNaPSS(lane)				(0x1000 + (lane) * 0x4)
 #define LNaPSS_TYPE				GENMASK(30, 24)
-#define LNaPSS_TYPE_SGMII			0x4
-#define LNaPSS_TYPE_XFI				0x28
+#define LNaPSS_TYPE_SGMII			(PROTO_SEL_SGMII_BASEX_KX << 2)
+#define LNaPSS_TYPE_XFI				(PROTO_SEL_XFI_10GBASER_KR_SXGMII << 2)
+#define LNaPSS_TYPE_40G				((PROTO_SEL_XFI_10GBASER_KR_SXGMII << 2) | 3)
+#define LNaPSS_TYPE_25G				(PROTO_SEL_25G_50G_100G << 2)
+#define LNaPSS_TYPE_100G			((PROTO_SEL_25G_50G_100G << 2) | 2)
 
+/* MDEV_PORT is at the same bitfield address for all protocol converters */
+#define MDEV_PORT				GENMASK(31, 27)
+
+#define SGMIIaCR0(lane)				(0x1800 + (lane) * 0x10)
 #define SGMIIaCR1(lane)				(0x1804 + (lane) * 0x10)
 #define SGMIIaCR1_SGPCS_EN			BIT(11)
 
+#define ANLTaCR0(lane)				(0x1a00 + (lane) * 0x10)
+#define ANLTaCR1(lane)				(0x1a04 + (lane) * 0x10)
+
+#define SXGMIIaCR0(lane)			(0x1a80 + (lane) * 0x10)
+#define SXGMIIaCR0_RST				BIT(31)
+#define SXGMIIaCR0_PD				BIT(30)
+
+#define SXGMIIaCR1(lane)			(0x1a84 + (lane) * 0x10)
+
+#define E25GaCR0(lane)				(0x1b00 + (lane) * 0x10)
+#define E25GaCR0_RST				BIT(31)
+#define E25GaCR0_PD				BIT(30)
+
+#define E25GaCR1(lane)				(0x1b04 + (lane) * 0x10)
+
+#define E25GaCR2(lane)				(0x1b08 + (lane) * 0x10)
+#define E25GaCR2_FEC_ENA			BIT(23)
+#define E25GaCR2_FEC_ERR_ENA			BIT(22)
+#define E25GaCR2_FEC91_ENA			BIT(20)
+
+#define E40GaCR0(pcvt)				(0x1b40 + (pcvt) * 0x20)
+#define E40GaCR1(pcvt)				(0x1b44 + (pcvt) * 0x20)
+
+#define E50GaCR1(pcvt)				(0x1b84 + (pcvt) * 0x10)
+
+#define E100GaCR1(pcvt)				(0x1c04 + (pcvt) * 0x20)
+
+#define CR(x)					((x) * 4)
+
 enum lynx_28g_eq_type {
 	EQ_TYPE_NO_EQ = 0,
 	EQ_TYPE_2TAP = 1,
 	EQ_TYPE_3TAP = 2,
 };
 
+enum lynx_28g_proto_sel {
+	PROTO_SEL_PCIE = 0,
+	PROTO_SEL_SGMII_BASEX_KX = 1,
+	PROTO_SEL_SATA = 2,
+	PROTO_SEL_XAUI = 4,
+	PROTO_SEL_XFI_10GBASER_KR_SXGMII = 0xa,
+	PROTO_SEL_25G_50G_100G = 0x1a,
+};
+
+struct lynx_28g_proto_conf {
+	/* LNaGCR0 */
+	int proto_sel;
+	int if_width;
+	/* LNaTECR0 */
+	int teq_type;
+	int sgn_preq;
+	int ratio_preq;
+	int sgn_post1q;
+	int ratio_post1q;
+	int amp_red;
+	/* LNaTECR1 */
+	int adpt_eq;
+	/* LNaRGCR1 */
+	int enter_idle_flt_sel;
+	int exit_idle_flt_sel;
+	int data_lost_th_sel;
+	/* LNaRECR0 */
+	int gk2ovd;
+	int gk3ovd;
+	int gk4ovd;
+	int gk2ovd_en;
+	int gk3ovd_en;
+	int gk4ovd_en;
+	/* LNaRECR1 ? */
+	int eq_offset_ovd;
+	int eq_offset_ovd_en;
+	/* LNaRECR2 */
+	int eq_offset_rng_dbl;
+	int eq_blw_sel;
+	int eq_boost;
+	int spare_in;
+	/* LNaRSCCR0 */
+	int smp_autoz_d1r;
+	int smp_autoz_eg1r;
+};
+
+static const struct lynx_28g_proto_conf lynx_28g_proto_conf[PHY_INTERFACE_MODE_MAX] = {
+	[PHY_INTERFACE_MODE_SGMII] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
+		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
+		.teq_type = EQ_TYPE_NO_EQ,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 0,
+		.amp_red = 6,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 4,
+		.exit_idle_flt_sel = 3,
+		.data_lost_th_sel = 1,
+		.gk2ovd = 0x1f,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 1,
+		.gk3ovd_en = 1,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 0,
+		.eq_blw_sel = 0,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 0,
+		.smp_autoz_eg1r = 0,
+	},
+	[PHY_INTERFACE_MODE_1000BASEX] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
+		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
+		.teq_type = EQ_TYPE_NO_EQ,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 0,
+		.amp_red = 6,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 4,
+		.exit_idle_flt_sel = 3,
+		.data_lost_th_sel = 1,
+		.gk2ovd = 0x1f,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 1,
+		.gk3ovd_en = 1,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 0,
+		.eq_blw_sel = 0,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 0,
+		.smp_autoz_eg1r = 0,
+	},
+	[PHY_INTERFACE_MODE_10GBASER] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
+		.if_width = LNaGCR0_IF_WIDTH_20_BIT,
+		.teq_type = EQ_TYPE_2TAP,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 3,
+		.amp_red = 7,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 0,
+		.exit_idle_flt_sel = 0,
+		.data_lost_th_sel = 0,
+		.gk2ovd = 0,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 0,
+		.gk3ovd_en = 0,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 1,
+		.eq_blw_sel = 1,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 2,
+		.smp_autoz_eg1r = 0,
+	},
+};
+
+struct lynx_pccr {
+	int offset;
+	int width;
+	int shift;
+};
+
 struct lynx_28g_priv;
 
 struct lynx_28g_pll {
@@ -218,6 +416,10 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 	iowrite32(tmp, reg);
 }
 
+#define lynx_28g_read(priv, off) \
+	ioread32((priv)->base + (off))
+#define lynx_28g_write(priv, off, val) \
+	iowrite32(val, (priv)->base + (off))
 #define lynx_28g_lane_rmw(lane, reg, val, mask)	\
 	lynx_28g_rmw((lane)->priv, reg(lane->id), val, mask)
 #define lynx_28g_lane_read(lane, reg)			\
@@ -326,130 +528,6 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 	}
 }
 
-static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
-{
-	struct lynx_28g_priv *priv = lane->priv;
-
-	/* Cleanup the protocol configuration registers of the current protocol */
-	switch (lane->interface) {
-	case PHY_INTERFACE_MODE_10GBASER:
-		/* Cleanup the protocol configuration registers */
-		lynx_28g_rmw(priv, PCCC, 0, PCCC_MSK(lane));
-		break;
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		/* Cleanup the protocol configuration registers */
-		lynx_28g_rmw(priv, PCC8, 0, PCC8_MSK(lane));
-
-		/* Disable the SGMII PCS */
-		lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
-
-		break;
-	default:
-		break;
-	}
-}
-
-static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
-{
-	struct lynx_28g_priv *priv = lane->priv;
-	struct lynx_28g_pll *pll;
-
-	lynx_28g_cleanup_lane(lane);
-
-	/* Setup the lane to run in SGMII */
-	lynx_28g_rmw(priv, PCC8, PCC8_SGMIInCFG_EN(lane), PCC8_MSK(lane));
-
-	/* Setup the protocol select and SerDes parallel interface width */
-	lynx_28g_lane_rmw(lane, LNaGCR0,
-			  FIELD_PREP(LNaGCR0_PROTO_SEL, LNaGCR0_PROTO_SEL_SGMII) |
-			  FIELD_PREP(LNaGCR0_IF_WIDTH, LNaGCR0_IF_WIDTH_10_BIT),
-			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
-
-	/* Find the PLL that works with this interface type */
-	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_SGMII);
-	if (unlikely(pll == NULL))
-		return;
-
-	/* Switch to the PLL that works with this interface type */
-	lynx_28g_lane_set_pll(lane, pll);
-
-	/* Choose the portion of clock net to be used on this lane */
-	lynx_28g_lane_set_nrate(lane, pll, PHY_INTERFACE_MODE_SGMII);
-
-	/* Enable the SGMII PCS */
-	lynx_28g_lane_rmw(lane, SGMIIaCR1, SGMIIaCR1_SGPCS_EN,
-			  SGMIIaCR1_SGPCS_EN);
-
-	/* Configure the appropriate equalization parameters for the protocol */
-	lynx_28g_lane_write(lane, LNaTECR0,
-			    LNaTECR0_EQ_SGN_PREQ | LNaTECR0_EQ_SGN_POST1Q |
-			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 6));
-	lynx_28g_lane_write(lane, LNaRGCR1,
-			    FIELD_PREP(LNaRGCR1_ENTER_IDLE_FLT_SEL, 4) |
-			    FIELD_PREP(LNaRGCR1_EXIT_IDLE_FLT_SEL, 3) |
-			    LNaRGCR1_DATA_LOST_FLT);
-	lynx_28g_lane_write(lane, LNaRECR0,
-			    LNaRECR0_EQ_GAINK2_HF_OV_EN |
-			    FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV, 31) |
-			    LNaRECR0_EQ_GAINK3_MF_OV_EN |
-			    FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV, 0));
-	lynx_28g_lane_write(lane, LNaRECR1,
-			    FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
-	lynx_28g_lane_write(lane, LNaRECR2, 0);
-	lynx_28g_lane_write(lane, LNaRSCCR0, 0);
-}
-
-static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
-{
-	struct lynx_28g_priv *priv = lane->priv;
-	struct lynx_28g_pll *pll;
-
-	lynx_28g_cleanup_lane(lane);
-
-	/* Enable the SXGMII lane */
-	lynx_28g_rmw(priv, PCCC, PCCC_SXGMIInCFG_EN(lane) |
-		     PCCC_SXGMIInCFG_XFI(lane, 1), PCCC_MSK(lane));
-
-	/* Setup the protocol select and SerDes parallel interface width */
-	lynx_28g_lane_rmw(lane, LNaGCR0,
-			  FIELD_PREP(LNaGCR0_PROTO_SEL, LNaGCR0_PROTO_SEL_XFI) |
-			  FIELD_PREP(LNaGCR0_IF_WIDTH, LNaGCR0_IF_WIDTH_20_BIT),
-			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
-
-	/* Find the PLL that works with this interface type */
-	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_10GBASER);
-	if (unlikely(pll == NULL))
-		return;
-
-	/* Switch to the PLL that works with this interface type */
-	lynx_28g_lane_set_pll(lane, pll);
-
-	/* Choose the portion of clock net to be used on this lane */
-	lynx_28g_lane_set_nrate(lane, pll, PHY_INTERFACE_MODE_10GBASER);
-
-	/* Disable the SGMII PCS */
-	lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
-
-	/* Configure the appropriate equalization parameters for the protocol */
-	lynx_28g_lane_write(lane, LNaTECR0,
-			    FIELD_PREP(LNaTECR0_EQ_TYPE, EQ_TYPE_2TAP) |
-			    LNaTECR0_EQ_SGN_PREQ |
-			    FIELD_PREP(LNaTECR0_EQ_PREQ, 0) |
-			    LNaTECR0_EQ_SGN_POST1Q |
-			    FIELD_PREP(LNaTECR0_EQ_POST1Q, 3) |
-			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 7));
-	lynx_28g_lane_write(lane, LNaRGCR1, LNaRGCR1_IDLE_CONFIG);
-	lynx_28g_lane_write(lane, LNaRECR0, 0);
-	lynx_28g_lane_write(lane, LNaRECR1, FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
-	lynx_28g_lane_write(lane, LNaRECR2,
-			    LNaRECR2_EQ_OFFSET_RNG_DBL |
-			    FIELD_PREP(LNaRECR2_EQ_BLW_SEL, 1) |
-			    FIELD_PREP(LNaRECR2_EQ_BIN_DATA_AVG_TC, 2));
-	lynx_28g_lane_write(lane, LNaRSCCR0,
-			    FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_D1R, 2));
-}
-
 static int lynx_28g_power_off(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
@@ -502,6 +580,268 @@ static int lynx_28g_power_on(struct phy *phy)
 	return 0;
 }
 
+static int lynx_28g_get_pccr(phy_interface_t interface, int lane,
+			     struct lynx_pccr *pccr)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		pccr->offset = PCC8;
+		pccr->width = 4;
+		pccr->shift = SGMII_CFG(lane);
+		break;
+	case PHY_INTERFACE_MODE_10GBASER:
+		pccr->offset = PCCC;
+		pccr->width = 4;
+		pccr->shift = SXGMII_CFG(lane);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int lynx_28g_get_pcvt_offset(int lane, phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		return SGMIIaCR0(lane);
+	case PHY_INTERFACE_MODE_10GBASER:
+		return SXGMIIaCR0(lane);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int lynx_pccr_write(struct lynx_28g_lane *lane,
+			   phy_interface_t interface, u32 val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	struct lynx_pccr pccr;
+	u32 old, tmp, mask;
+	int err;
+
+	err = lynx_28g_get_pccr(interface, lane->id, &pccr);
+	if (err)
+		return err;
+
+	old = lynx_28g_read(priv, pccr.offset);
+	mask = GENMASK(pccr.width - 1, 0) << pccr.shift;
+	tmp = (old & ~mask) | (val << pccr.shift);
+	lynx_28g_write(priv, pccr.offset, tmp);
+
+	dev_dbg(&lane->phy->dev, "PCCR@0x%x: 0x%x -> 0x%x\n",
+		pccr.offset, old, tmp);
+
+	return 0;
+}
+
+static int lynx_pcvt_read(struct lynx_28g_lane *lane, phy_interface_t interface,
+			  int cr, u32 *val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	int offset;
+
+	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	if (offset < 0)
+		return offset;
+
+	*val = lynx_28g_read(priv, offset + cr);
+
+	return 0;
+}
+
+static int lynx_pcvt_write(struct lynx_28g_lane *lane, phy_interface_t interface,
+			   int cr, u32 val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	int offset;
+
+	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	if (offset < 0)
+		return offset;
+
+	lynx_28g_write(priv, offset + cr, val);
+
+	return 0;
+}
+
+static int lynx_pcvt_rmw(struct lynx_28g_lane *lane, phy_interface_t interface,
+			 int cr, u32 val, u32 mask)
+{
+	int err;
+	u32 tmp;
+
+	err = lynx_pcvt_read(lane, interface, cr, &tmp);
+	if (err)
+		return err;
+
+	tmp &= ~mask;
+	tmp |= val;
+
+	return lynx_pcvt_write(lane, interface, cr, tmp);
+}
+
+static void lynx_28g_lane_remap_pll(struct lynx_28g_lane *lane,
+				    phy_interface_t interface)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	struct lynx_28g_pll *pll;
+
+	/* Switch to the PLL that works with this interface type */
+	pll = lynx_28g_pll_get(priv, interface);
+	if (unlikely(pll == NULL))
+		return;
+
+	lynx_28g_lane_set_pll(lane, pll);
+
+	/* Choose the portion of clock net to be used on this lane */
+	lynx_28g_lane_set_nrate(lane, pll, interface);
+}
+
+static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
+					    phy_interface_t interface)
+{
+	const struct lynx_28g_proto_conf *conf = &lynx_28g_proto_conf[interface];
+
+	lynx_28g_lane_rmw(lane, LNaGCR0,
+			  FIELD_PREP(LNaGCR0_PROTO_SEL, conf->proto_sel) |
+			  FIELD_PREP(LNaGCR0_IF_WIDTH, conf->if_width),
+			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
+
+	lynx_28g_lane_rmw(lane, LNaTECR0,
+			  FIELD_PREP(LNaTECR0_EQ_TYPE, conf->teq_type) |
+			  FIELD_PREP(LNaTECR0_EQ_SGN_PREQ, conf->sgn_preq) |
+			  FIELD_PREP(LNaTECR0_EQ_PREQ, conf->ratio_preq) |
+			  FIELD_PREP(LNaTECR0_EQ_SGN_POST1Q, conf->sgn_post1q) |
+			  FIELD_PREP(LNaTECR0_EQ_POST1Q, conf->ratio_post1q) |
+			  FIELD_PREP(LNaTECR0_EQ_AMP_RED, conf->amp_red),
+			  LNaTECR0_EQ_TYPE |
+			  LNaTECR0_EQ_SGN_PREQ |
+			  LNaTECR0_EQ_PREQ |
+			  LNaTECR0_EQ_SGN_POST1Q |
+			  LNaTECR0_EQ_POST1Q |
+			  LNaTECR0_EQ_AMP_RED);
+
+	lynx_28g_lane_rmw(lane, LNaTECR1,
+			  FIELD_PREP(LNaTECR1_EQ_ADPT_EQ, conf->adpt_eq),
+			  LNaTECR1_EQ_ADPT_EQ);
+
+	lynx_28g_lane_rmw(lane, LNaRGCR1,
+			  FIELD_PREP(LNaRGCR1_ENTER_IDLE_FLT_SEL, conf->enter_idle_flt_sel) |
+			  FIELD_PREP(LNaRGCR1_EXIT_IDLE_FLT_SEL, conf->exit_idle_flt_sel) |
+			  FIELD_PREP(LNaRGCR1_DATA_LOST_TH_SEL, conf->data_lost_th_sel),
+			  LNaRGCR1_ENTER_IDLE_FLT_SEL |
+			  LNaRGCR1_EXIT_IDLE_FLT_SEL |
+			  LNaRGCR1_DATA_LOST_TH_SEL);
+
+	lynx_28g_lane_rmw(lane, LNaRECR0,
+			  FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV_EN, conf->gk2ovd_en) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV_EN, conf->gk3ovd_en) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK4_LF_OV_EN, conf->gk4ovd_en) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV, conf->gk2ovd) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV, conf->gk3ovd) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK4_LF_OV, conf->gk4ovd),
+			  LNaRECR0_EQ_GAINK2_HF_OV |
+			  LNaRECR0_EQ_GAINK3_MF_OV |
+			  LNaRECR0_EQ_GAINK4_LF_OV |
+			  LNaRECR0_EQ_GAINK2_HF_OV_EN |
+			  LNaRECR0_EQ_GAINK3_MF_OV_EN |
+			  LNaRECR0_EQ_GAINK4_LF_OV_EN);
+
+	lynx_28g_lane_rmw(lane, LNaRECR1,
+			  FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, conf->eq_offset_ovd) |
+			  FIELD_PREP(LNaRECR1_EQ_OFFSET_OV_EN, conf->eq_offset_ovd_en),
+			  LNaRECR1_EQ_OFFSET_OV |
+			  LNaRECR1_EQ_OFFSET_OV_EN);
+
+	lynx_28g_lane_rmw(lane, LNaRECR2,
+			  FIELD_PREP(LNaRECR2_EQ_OFFSET_RNG_DBL, conf->eq_offset_rng_dbl) |
+			  FIELD_PREP(LNaRECR2_EQ_BLW_SEL, conf->eq_blw_sel) |
+			  FIELD_PREP(LNaRECR2_EQ_BOOST, conf->eq_boost) |
+			  FIELD_PREP(LNaRECR2_SPARE_IN, conf->spare_in),
+			  LNaRECR2_EQ_OFFSET_RNG_DBL |
+			  LNaRECR2_EQ_BLW_SEL |
+			  LNaRECR2_EQ_BOOST |
+			  LNaRECR2_SPARE_IN);
+
+	lynx_28g_lane_rmw(lane, LNaRSCCR0,
+			  FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_D1R, conf->smp_autoz_d1r) |
+			  FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_EG1R, conf->smp_autoz_eg1r),
+			  LNaRSCCR0_SMP_AUTOZ_D1R |
+			  LNaRSCCR0_SMP_AUTOZ_EG1R);
+}
+
+static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
+				      phy_interface_t interface)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	int err;
+
+	spin_lock(&priv->pcc_lock);
+
+	err = lynx_pccr_write(lane, interface, 0);
+	if (err)
+		goto out;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		err = lynx_pcvt_rmw(lane, interface, CR(1), 0,
+				    SGMIIaCR1_SGPCS_EN);
+		break;
+	default:
+		err = 0;
+	}
+
+out:
+	spin_unlock(&priv->pcc_lock);
+
+	return err;
+}
+
+static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
+				     phy_interface_t interface)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	u32 val;
+	int err;
+
+	spin_lock(&priv->pcc_lock);
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		err = lynx_pcvt_rmw(lane, interface, CR(1), SGMIIaCR1_SGPCS_EN,
+				    SGMIIaCR1_SGPCS_EN);
+		break;
+	default:
+		err = 0;
+	}
+
+	val = 0;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		val |= PCC8_SGMIIa_CFG;
+		break;
+	case PHY_INTERFACE_MODE_10GBASER:
+		val |= PCCC_SXGMIIn_CFG | PCCC_SXGMIIn_XFI;
+		break;
+	default:
+		break;
+	}
+
+	err = lynx_pccr_write(lane, interface, val);
+
+	spin_unlock(&priv->pcc_lock);
+
+	return err;
+}
+
 static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
@@ -518,33 +858,26 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (!lynx_28g_supports_interface(priv, submode))
 		return -EOPNOTSUPP;
 
+	if (submode == lane->interface)
+		return 0;
+
 	/* If the lane is powered up, put the lane into the halt state while
 	 * the reconfiguration is being done.
 	 */
 	if (powered_up)
 		lynx_28g_power_off(phy);
 
-	spin_lock(&priv->pcc_lock);
-
-	switch (submode) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		lynx_28g_lane_set_sgmii(lane);
-		break;
-	case PHY_INTERFACE_MODE_10GBASER:
-		lynx_28g_lane_set_10gbaser(lane);
-		break;
-	default:
-		err = -EOPNOTSUPP;
+	err = lynx_28g_lane_disable_pcvt(lane, lane->interface);
+	if (err)
 		goto out;
-	}
+
+	lynx_28g_lane_change_proto_conf(lane, submode);
+	lynx_28g_lane_remap_pll(lane, submode);
+	WARN_ON(lynx_28g_lane_enable_pcvt(lane, submode));
 
 	lane->interface = submode;
 
 out:
-	spin_unlock(&priv->pcc_lock);
-
-	/* Power up the lane if necessary */
 	if (powered_up)
 		lynx_28g_power_on(phy);
 
-- 
2.34.1


