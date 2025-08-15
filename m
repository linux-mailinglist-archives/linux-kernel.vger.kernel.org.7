Return-Path: <linux-kernel+bounces-770716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3E5B27E28
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985EBA253B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5822FF174;
	Fri, 15 Aug 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MHtHCmwr"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7D86359;
	Fri, 15 Aug 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253424; cv=fail; b=jNigE8ZbzBlaM4n24n7Uceq1UoRwVX4d8WRaCQqqUiLPr/Mp2vSoA8t6b2x9MKGF/Op9bq1t+PDnbVlZX8Jyl+wcOyp9UtoSikWkhno8BC/053BMIsKp5XeusMNngAByvAnvaeAEnBmT0W6LUoPiZdfYEAdrxBpYm/1hvwD0y+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253424; c=relaxed/simple;
	bh=HXyhNFiMQr3J13+/WuWBNdnwh1xV90iQYlBzmvI+7Bo=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GahX9evUF8WYqMX/ItCAyj18PZ69WVf4dnA5XTYpcreH7nqCObJBD/Jd8vqZ/DbM2Ckpx48RfCZejcFLkdzV/+YhNCuP2PIPq5jhslyykbhpr1yUdTNxACYwa0rYKFl6BRF7m9CghJPLi/twJRNpRhYwuO120qsVAIIWZhcEFP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MHtHCmwr; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlkyAZeG2070ZAomzOgeWcWwNo8wcG2PnJCeIWlJvrXQ6pCcucIWl8O2gQdSYUthO03PUEz3HfrLDbZZTg3PTWWn/n2D60sg2Jhm70MDaH/XQC3dl8Fbn+g4fVsgjD4HI5BeqeGWuYWpQ8GrWwZGb152EVJbnjlncVsAGqXkKvdeD0JlmO0t3XRr8VxqWVC4O1ioMzWr6SUfFz3TJSc961ix/KopfAkXUkZbpxHdZx/lRK84C+ictVfMJ489bMYCBUOdTcznOfkRoxgVviKhv2UWJXnxvkdaUst+4+iThZXMzS5bku47Jj/4tVJC9qWujRPaXE6gTEKeGEQ8bcITgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Zwgm4U2rF1hVgxd1Mc5FpFrxktNuqz7n28fKDtbwMQ=;
 b=rBDVAo5pri0Vm7jMGCn3aT0JSENCamucvNSuNThwY720jufEyL9wySmigRVOauvb8RTWlEKVnvLDMx9AQUXNrR0Rh5k/kt28awSjLUmJxIs97RyqCyxYUNBQdJKBWJKMjd6O8UvUYMyh8FH+mrB3zPSk9mQhBHaKhaInstjgfRNsvh0DIuoHy82PoCqHT9jhejtqo7BqBCUd+E/EBGcai2Z5wobp0889Q2poQzy6Plo+aAobg1wsSWFqm240FX7gy9YXOuaVtr03dyLD0+ig2erPcYFX+N4xj1RUopYmgCq7nYLLi9bBzSBndvA0YyLcdYbFE7HATg9hu2JJeRDzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Zwgm4U2rF1hVgxd1Mc5FpFrxktNuqz7n28fKDtbwMQ=;
 b=MHtHCmwrW85vW2RgtKXqWmlKYVrpcA4rpafxxV7RrjC1hc3271dVkYsWsXGvgtsF3/sNwkulagnLex/vsVPz1s4BnvFwMJvguq2bScLiJ8eQYirZa9aguO6Tqfojsal7kT/dC5B5Ev14eiVOWP3b4MZKnYFk5YmgEV/bmDyTIaZ6j3adfCOW9rJludgvTEw0LxBxUwoCFdI5fnrqOg/5DKQflHgDztlb9NGxQO9d3EYzfr2i1JciLabCVpo1LgMh6rWeh16ZYavbE+qT+Ns8p4IM2GdDb/V3Iux7FMDBar2qkzxbzrgwGQGZEDdutGL0EAKM3zI6aXEBZYhPrmYdvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 10:23:39 +0000
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8]) by VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8%6]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 10:23:38 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH v3 0/3] arm64: dts: imx8m: support more sample rates
Date: Fri, 15 Aug 2025 18:23:14 +0800
Message-Id: <20250815102317.910014-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To VI1PR04MB7055.eurprd04.prod.outlook.com
 (2603:10a6:800:123::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7055:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4bc6ec-6808-4ff8-71b8-08dddbe5cc81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4dawTaivu0UBLjJzgYBYw3fdLAOMqUyvaAE75H4IF2R/vBaXuZvK6FmDj+SX?=
 =?us-ascii?Q?afEo0R7nskD4lm/M/utRJrlQVaXfMKNSj72r4FiUnt3hiVyftAyGJGdE3gPS?=
 =?us-ascii?Q?oIlvKx649SnOjayxTZCinCkjMsB/52r1qMK5eK8l9mZLAQKeSZllbLYCg4xy?=
 =?us-ascii?Q?USd2Oy5Pmtr/G2l6jicChdyez6fnSWCAa5nv/i73Ktb1IBMjAXuuKxWzAHku?=
 =?us-ascii?Q?uKE197+vvNGf2kd+A6VaOMuNysURc2Dv4CZbMmHXwUwD0DWMDOfg7Bi9DqcU?=
 =?us-ascii?Q?2hFQbT8bvv2KiA4yypJahVT9uH3aRZip6lEWd7IBGnFC11ZoQKLnHcuMlZcd?=
 =?us-ascii?Q?P0OY40cT9Wu9oFRLgBAt9sDf5FSy9dPb9HJDvwawTMg9FnAwe+f/AgeMuYnQ?=
 =?us-ascii?Q?2A+Ty11MT5HYZDfKADIpdta2j70ibgY5vW19Z3G0KJt3OicYSkfyorzBBTu6?=
 =?us-ascii?Q?oiaD8QXyTBW0wx41fq5Xrw/CcTW8mtSaW8JdkBnydmkpu2DBotnOOFDwOtVw?=
 =?us-ascii?Q?XtxvZ/UlPjYuVQ/gTngl7UlJtWmGV3U4Wlets68fIZ3cFcX3dn7SdfcGv8xc?=
 =?us-ascii?Q?rocggec1+EBt0/Ktf80U4jtW6ETys3A1SgDSf3dqEKpOHpv0FVVi0xPoJwpP?=
 =?us-ascii?Q?CgsIEpWNhfng3z/HDHBGgz2rUr5vCtvbuwswyS/E5aig2otEJwPP74ZveCH+?=
 =?us-ascii?Q?e9qg3Dd3JmnaprNEmxrlIXKYpGJm5EnSjjgrVNnDAC2izf30dJJKNEU5mkIN?=
 =?us-ascii?Q?X57GNoyvCTKXec6Du3jGPL5l/zzoeZQwQSEYVtZWWIdGzXVS+Dda1wj4Fwv6?=
 =?us-ascii?Q?uT8xKDPO7irQ7PLWJBotMbW/F3EAnUv5khHtoR1thJZ9uMTpB2Kk5ccSCig1?=
 =?us-ascii?Q?nw3AdHnhzUUnkO0K8Fr0UGJMhQZbDZjxFJtRJ34Nlz3tKCK5L18YyzlM2xD1?=
 =?us-ascii?Q?4+3Jkl6ZFWTV6xYbEdf+LdHfmryxh3WiWUqsnE6+BeYiAsF/C4CbQdzIlKhf?=
 =?us-ascii?Q?jPjvROy9lNGM8tlbdNTyCR1t1c8qfIxr28g7PefefFvNXEdnjuePetU16qu7?=
 =?us-ascii?Q?5mUQOP2kiRT1L5SzVhPmPckBug9KGVrmf45GkMVffREilLsSY3Iz0fixmQof?=
 =?us-ascii?Q?bXKTPT9+3seMQ4/jVs8gAis9kDG+t0CiFb4Kp4fbP9WYBebIxNqEQslB2DU7?=
 =?us-ascii?Q?/aSn64XMKstRT0SIJWmsaCFAqCpCNZYQ3SgDfXBQZ49s207k11LT05TZ/Q7O?=
 =?us-ascii?Q?d1HwXzVlfSrsWqPrbp8PObaNq5L6iTI7Ow7j7JNCYbeU8fbRnesFgkhkQMdJ?=
 =?us-ascii?Q?/h/i8pupZmqWfnaBKyY3brIOBWUKDH8LBLpsLaRM1zxFoQ1XSuNPMl3nFTK7?=
 =?us-ascii?Q?iPRI3T1izg+pJ5D09RZSWF67s1ev0GAI4wNd6S6O9/d1ESymvo9JL3ujpl8G?=
 =?us-ascii?Q?5AzjNlcmGLRHNHCwwcxnP/38aJjslFo0I3AgYUzG6kcUul9wNqazqaF53lbk?=
 =?us-ascii?Q?XQxnhqk+Njc6b40=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7055.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6r+c5q5kNF5TMUiVm48RErGxdW8rSvvq0U439GXMXaiQgLHcHNjblA06M8sg?=
 =?us-ascii?Q?X43TWMuv4Zk3ZNbsLr86pxT9Uv9p4JKomIj0s3C87Ck7QHIjUyumisySx7X9?=
 =?us-ascii?Q?QNDHNhfrmOEpd1wjMBsS29paZyUDL60SwggyZOmcWgrB0b0UBVnRYePs4r1s?=
 =?us-ascii?Q?zaLrZxRPAd7s+pvBW+fLHdJW0oeF0fx0xWAlwnh5L1s137a39SeK0XepCU3P?=
 =?us-ascii?Q?yBCv38+HG4c6goRfD4JKe5itsb434DO1UhvQ9Xk0uEhmoSQ6s1kgmePxJwR5?=
 =?us-ascii?Q?sJpIKOZXaNRRA5QlpxQI3x3wejE4bRU3GdWkOF2PIfHwlhI9M6ZLijdKBZiN?=
 =?us-ascii?Q?K28Eua7b5FvLGonXKjcbpmLpyIQp2qDZQJuYM2QK/zaNNgdEFI6QS9BYZlbM?=
 =?us-ascii?Q?tXQmtPixFffEkHpjc6V81ouv19eIhHXS0kFzV/3NdL9kk6Hu9I/3Cbx1gmP7?=
 =?us-ascii?Q?OrzUFjmlp60AFOmqosGWfb4P147IeL/oA2Sn5J/t4bts6uF6UK02umfQx7fI?=
 =?us-ascii?Q?jTwmt14sAZoI1l3mjSROMGpXZoNvZZZ5r2CiPjarYDfoekBNYwxkw3Wj4Wup?=
 =?us-ascii?Q?LyVKlgH66QG7uL5fiS4HVHuNxwO902dN1FXuq8nyWT9aTtkxaNYK5uDkb33A?=
 =?us-ascii?Q?yo/+ABkXnlQMi0twIeqoOpaRR7vYuNWGLOhuK3OASC9srzgq8IZthQ+jwEGk?=
 =?us-ascii?Q?wrZi79blTiWawN3eons/1942SPmFCh8h2fv2aOlK8bi5w9PotyVCeHUnKNRj?=
 =?us-ascii?Q?t2WopBinuci2veeMBnzg+6NR4aJ97buMa0OjtVEQkzXaTiA/IF8Pyic1JhzP?=
 =?us-ascii?Q?lndVOV8jvAKkCrnlTZOoBhv/LvXFBMVjETIuSA94BBjws/9WO3dx/8XWU0dz?=
 =?us-ascii?Q?ZebaqUQ6pwdyHKGh+rAsfVPlfRMhhoUdVYgOZ+PdwiBqFuuqdIaQhytRxk+l?=
 =?us-ascii?Q?V4z4sfhUA0aKxX0AuaH7BUtFDD6FuI0we9uDRpQulbCs1SDJsPawpnMWCXOp?=
 =?us-ascii?Q?bQymoPB566cR8pbuSg4EfhNn/kKgQlybNTCzMSQxSqGyzo1ibdb5oWD7JqMC?=
 =?us-ascii?Q?4cpsQ/Ip0xBNVfLzcEIjPpTxxsg+3Z0xU3DMGy67lAXzCo+VrogMKCqYfidF?=
 =?us-ascii?Q?mnGQIObgB4VAzPlOl6Sngqub03U1tnGWGoaIBFUPr+IBBo0f2ojY2rkHvHWs?=
 =?us-ascii?Q?rcKHCYsp/Sw3DBADFcKK9Q5IU2d9X/pdJbu9mX+Ssog5pIAbP2sLBhI/eQSF?=
 =?us-ascii?Q?ERheAvCxJzdIdGonk6x7GwCP903oLTYZ4xNDHY3jJ5UVn0jWGWm0Jj2Kv1p6?=
 =?us-ascii?Q?LGJ9uatKSmq9zyzk6GMGu9M9eEAk2t8fZ7YreVqtw1aGBMctVWiyCS3AIDWA?=
 =?us-ascii?Q?0TSqn/nT+bB2jYRDk8CfmwGNsdVmWzQ6g3Aebvz0N7sgRVCHUj9foh18LPDQ?=
 =?us-ascii?Q?vJzI0ujZGOE9HN+aJpkDXY90hU44hhcrfhCcjPTJtSfH91uDFeB0+3KxagLH?=
 =?us-ascii?Q?6x2hKAZDjC0uBc5gy4tXIH7E/vCQCXDdLfnbxHk8QhJeihZ04LFJGOIQHAp9?=
 =?us-ascii?Q?KOQIThtNgnemXJTaPpqhI47bjff2M0xxdAw7EAMD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4bc6ec-6808-4ff8-71b8-08dddbe5cc81
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 10:23:38.7410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0tTkZ0gSFC0PNafxynPl9Y+Ai1bETbtOGfAnstWHqKwx4pvQM1L0UX2e1B7A6dU1TCeoaSw5Ne1DCLV2zlXoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

The wm8524 codec is connected to the SAI interface. There are two audio
plls on i.MX8MQ, i.MX8MM, i.MX8MN, one pll can be the clock source of
44kHz series rates, another pll can be clock source of 48kHz series rates.

Previously it only supported 48kHz series rates, with this change the
supported rates will include 44kHz series rates, from 8kHz to 192kHz.

changes in v3:
- Minor change in commit message for comments from Frank Li

changes in v2:
- Add more comments in commit message.

Shengjiu Wang (3):
  arm64: dts: imx8mm-evk: support more sample rates for wm8524 card
  arm64: dts: imx8mq-evk: support more sample rates for wm8524 card
  arm64: dts: imx8mn-evk: support more sample rates for wm8524 card

 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 17 +++++++++++++----
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  8 +++++++-
 3 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.34.1


