Return-Path: <linux-kernel+bounces-755207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B708B1A30C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D0718885C8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC0267B7F;
	Mon,  4 Aug 2025 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DjXcRfQz"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011001.outbound.protection.outlook.com [40.107.130.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE72620D2;
	Mon,  4 Aug 2025 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313319; cv=fail; b=sGyrvkW7NemUP+Q4spu2mPPrN/kRyw6c8aNk5bD69FQkB9IoY0JJ4CnkYaYLML+lt96wLEifpuB5LeFkbNFVgYFkl0vDeSlcyVYmWz+0TQRRspEQsmjzAPjL8n40xQOT5eNSjxdMmErggXp09Pj8xzvj8b44DrxvhvMB7fMuDUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313319; c=relaxed/simple;
	bh=Bday/C3TSBUwuwqubVNJEczoTs5a/6W1dqQ9S+bZ5Os=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dL6x0LvJiMGmfb1SGhPuoWonHMBg7+IaSl2qhwpflYTp+mIjllUQFUwX6lBeSJ9rzllrPnzELu6HC3R5KgilE0gFvqn2JxSL55JSSiAxnyxwT4oz2L+Ikn8Vqz7YxicagDTHJjm46SgL1tZpEPN43MIe/1vIWLU8GUyFwPlHh/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DjXcRfQz; arc=fail smtp.client-ip=40.107.130.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxHlrEjT41/ZrUyLThpzuBNMTgtj1JXyeVtNslKVm1w9ntCvLB9BQU1GlWw4Q4jwNS6NrHWqflxFYOuDgRXoZelpcNKzkaChkQNjx86U+3ydmVCRmlXcfy9AcZJU0ikAGrhkped9jcHdttsgaycdHk3pMTr8X4Iq0NLwLG1xCwqtVZ0BP9jA+Tg+dUzEAHiWx7N/TQDAPTljWCNjdN03/sJSl6VK/Q+rNiue+ngkXN2bzLPlJD6YxZOAwKTHYPaApuIIbG/5TO0V/HSP+HNVoOKxTai5oyD++vUSdyhLPOoJVC3Plk2q2NISYQfMy4jISCkve4MWCZjJiaNiW8wS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQV/cJNV5hxJ+DGod/dRa68FMecLPmWBXGGj0NRUwiI=;
 b=oaubWQGEqdJgOkZ5tglTx+gDp6Qhb5fVo61BezyWR42jVhF0PrCmypCe/GTMuVNwuQJ3S4WxU0RsXWUrjZ9T1K1443iqyPioNgD/NFCjRMpzGwVyFOQUaI5gvSz3lCy95GDV/t/CjgkWByAbiIdxmYu0OHZJK4RshbZ+81t5s7wI8pqqpg/VGkkywLyW2IsQes9p3mjh08Z4QDC2oLV5pPyZ592QuQQcCczi+28512su0aaquMvLkI9iKNGdNEYNd4bijLE4rUVUfd1bpr5KRySi6RxAbr3xLppCVqoUMgpC5leCapnX790W7qILF9Sa4McFFFsB1LvKPqZqALpYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQV/cJNV5hxJ+DGod/dRa68FMecLPmWBXGGj0NRUwiI=;
 b=DjXcRfQzKyzfI/HuCIUbd5R2G+eJZuGgGRGCDSiyvFbJvYRH8eQeTanXgwaxuBzHgaco+oXQRWSKFPnfpIy5efhCS0sUxOM2wSQkO9+4eDE7dFVuSu9QDB8wWVNsQKsAy/I0TICxpAUy96536VbDwHS3BiyzlM8YuOf/cvrGhn4oiPPzTLrNzwf7Sg/nXkJd5EMk1lDahRcBMwM92nj+M7vK/icOnNLgzgnDJE/NM5O18uruZYojgOQHJIPlpaNOSFB3Tv32nTiW6kPmED0x/CTQtMOi37B4OzciyiaTG06/0By856bjAB3NdZ5FGQfR9DwrsH9prb6LXtVLowMFaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by GV1PR04MB10349.eurprd04.prod.outlook.com (2603:10a6:150:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 13:15:11 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 13:15:11 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: frank.li@nxp.com,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] clk: imx95-blk-ctl: Fix runtime PM issues
Date: Mon,  4 Aug 2025 16:14:48 +0300
Message-Id: <20250804131450.3918846-1-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::10) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|GV1PR04MB10349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3caccb-7380-4366-e09f-08ddd358f0f5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?21RGMjQ2+Q0J+XCXOV5gyySKRG1o/Ue3y/L6IGIwHLNFI+AuoPOoYDx7YjVU?=
 =?us-ascii?Q?tS/1GS+ej8n/JbIRGLf2+4A5k5rd88k59Pc8WSquexs4KWDl6CcnDLFKfgh8?=
 =?us-ascii?Q?hAGMIXLVBJWcGpNFUu7A3Z+5IXNumzm5I9bWmLwSXtLayOHD/YBxxdBPi3oR?=
 =?us-ascii?Q?YyKc/Cw/ynjOoQo7agRskQNkuqKdL0LadT4EC5mSWv85kq5LwJ91adR58umG?=
 =?us-ascii?Q?6Er15xFn/7RUGGYE3PEqUSZ+4T4+rlld0XaxNk5izmC42Q9VagEkNSJ6hYTy?=
 =?us-ascii?Q?0eAWOh/Jh96J/Q5MJqxJqZZcSDVNqW5iac3SeQCfy8zm+BrLBfx55SafGBDL?=
 =?us-ascii?Q?lcBlv/OPT5qTI8Tuqr3d9gnFjVPnmbLJQAeQ7oF/448jR1/bWGWl+kf5QDAf?=
 =?us-ascii?Q?SuXmNhaHNLJr0uvYkdY2n+HR5JYV2HaK4LFkU3S+/J62cb1C6jtWW6v9wmc1?=
 =?us-ascii?Q?COgQAjn+8QfnX/4ohvvGCrZmMYrNHlQscEBEfuiVdYanKyFVQ+Suq/MZUoBQ?=
 =?us-ascii?Q?XBVpOh0gtXKe5I61KyCnMCrja5otgoUQoyH2Sv78dIFMwujnSm+B8lO0hH53?=
 =?us-ascii?Q?IqY9j90TJH1S424F151OiTLHC44UUshpZfVCc1ylLUPUJxaLhq4BMhk93WBU?=
 =?us-ascii?Q?ME+AH7RperS6VbSy0iqeOBmpTmrb/DTctYNCbQDW1QJVDEec40c4Rq20bjBB?=
 =?us-ascii?Q?dVBnLk8kl1P3q2Vx6fcfnBQ9+y5qBUhc4TnhHcWFiRebtn7O+4OQCRCFog3m?=
 =?us-ascii?Q?L1Skm8gYQTppbt3VxITBDdWN/wzibtxCeMnlepNUPnpZ/pFeFqWMXy16oD8W?=
 =?us-ascii?Q?En3fYWWsg7Hw/sivmIYdybmd/hr/EANsODe7URcVm/hNs7P6mBWjMOmQNA1U?=
 =?us-ascii?Q?oBjuLx2tS4AM29ju3WOgoX55+Wzy+ddCB6KKMxex9EOidVNSWK9zpjrpdHt+?=
 =?us-ascii?Q?58MCgIB4ezJ8LBIpuQqu3eonCLmHeomLQ6AGsI+8F6vwSwBguxqJUR4cZzWj?=
 =?us-ascii?Q?3HDB4p99/vk3ZG7+SHL1ZgvrUqh1w2bClSPHzj8Pc4Wv0TPhmbFbaJt+DHTL?=
 =?us-ascii?Q?u6vbCQLUTz7eFreeMCXk+CJknPemR1U7NwrWdIUoFAZi4/UmwD0DT2dI3BiB?=
 =?us-ascii?Q?0QY6ky6NMFFNmk8h+qlBSbMWSkOgfQvVHV8uq+LU1s9zOpH1RH2XtrZZohtH?=
 =?us-ascii?Q?/tL2d8tyBH8Fjiwp0JCrDHhdEheN1hEFPFBIQWjZ5frI3EsTTmRvyUepaLVb?=
 =?us-ascii?Q?W/PnBa4g1Z+1R3DsiCf8gF5yjE4MuWsfKOW+uzWKa4Nw0X6ePw8h/AOmT92m?=
 =?us-ascii?Q?T3YaoL0LWH8NXaP1xD/kJw1mRu6qayhmi1lahABdRKc5fj7Ky6A+El4f1EAX?=
 =?us-ascii?Q?NLhW/GQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?znj5wc+3eRKN+e9qmcyJOF42bebihXNZXg6cJSHDJ8kwguxZI9G8mwQxIe4D?=
 =?us-ascii?Q?GWmhrFv69JFuOA6RoOnzVXbOOPKJd3rTC0nlMIljv9MZh7mKzpVXR+t+4zR9?=
 =?us-ascii?Q?yGlz27qKjmUp+2TJTaD3PgfvnJ59Cbap4sryOf40dxZqoOw8jf4BkBRPODLl?=
 =?us-ascii?Q?xKO+QUNLyz1Bf5yRt3fJSxfKL4Mt37ke4kJvQbv42PATcpVY729eoW+w9+HC?=
 =?us-ascii?Q?iR2/gEjHTqMhbsGArkje7ubMTrqExY34e+36po/SNrGKJR9djZuumIx3Ybc2?=
 =?us-ascii?Q?OlODY4ox89VBuTjeBSIHmpbFxvSzCYBsHESDH0ttTBHp5HKbIL+EjoQr1IjP?=
 =?us-ascii?Q?ixyzvLvAMhHivR+z3MIbjDKRQ40uq9pDQU6RzjDEBSYMeRHE7wTl9cSWLEc8?=
 =?us-ascii?Q?5B6z6q4fv2Qjr3eDGyCmltiMu+wH0lwuVe4D/Rath+Zxe1VEBHWRJblHcacX?=
 =?us-ascii?Q?bkOVb3dpQV6hcKlcdXjWSotcZHEhIIRULLj+VTN3tUpxucvyihQuynvx0yrJ?=
 =?us-ascii?Q?c0+RV/fvOknEnnnbpw/xU7Wbtm6Smv9DJqyXpydkzxbqEdODtSh+WcvULMpU?=
 =?us-ascii?Q?qs5/DQDD1o7WR0qE7DMXbIYSeqs+/EbuI+Do3XzUlmvW8MtRnbxlcLFXC4XT?=
 =?us-ascii?Q?EeNEBRcYUmU9AwW2RLzcHP+j6dKPwkXHrGR+0FjLLQW9EAG/0/NTAi+0Skdi?=
 =?us-ascii?Q?wWm1uATi/AgirG0VPcKNEt6L5P74fJoSYvZ3RLDAwQ/zw9rBRI+TILhv6XOZ?=
 =?us-ascii?Q?2Z9RY+8NscUdvMSYlF8Cj63rXuljjV6dkWeFU/x+pNRHUzBPPCKgdFp0+fxM?=
 =?us-ascii?Q?as+ns/PSG6IAFJiH5WqJDnuEZLNxH3k2iB94sLf7EjoivdpY+3T/RSqrWpfR?=
 =?us-ascii?Q?7p/l9V4Bjcwco9zmBy5TDEYak1/RNCOcsIsa5AjQBg6WZcpUKcSGFvAoIsKd?=
 =?us-ascii?Q?5lWm9bgJqs3A4mrjNa+dq4PMaY9CTWh/617dPLe1DP+rj65oM30yE8oW91/d?=
 =?us-ascii?Q?54xTNBX49BJx9PavRzeV4K9ptmSKj7VUpt+Vn59plgBrV2naE83/6of7YJzl?=
 =?us-ascii?Q?tr+aT5U2cBszfdiT9hqiAx+tZEYvD09uHrsD9OUU+uS20cRen0bxFR6DkArO?=
 =?us-ascii?Q?2JYjpUMmKNx7qAEumgN1KO4O79z03W0LhuHxc9qgXDNLuIOHzFnxbvB9u6V1?=
 =?us-ascii?Q?AXgDXgafR6iTAP9nT4idHp1qZxO8ZKzi0RzmnFN4CiXXWBXYEIQ+XyigKn4T?=
 =?us-ascii?Q?v0eXomODgWhYqonnGT8fNM0D1KdrIAqo4X9OCaACWRGkoq2gv0rIQT6dHWBf?=
 =?us-ascii?Q?CRjDnBsEViVC2Oz1mR31x0z/tTFPsiyu37skZeykQ1Nkis39EE4VI8mWBOIm?=
 =?us-ascii?Q?4w8Z+E28Vlj5TRR4SJN1ocRZUpb8Qn/b6Nuz0eeAxsytJZtd4tp7zgguJBhE?=
 =?us-ascii?Q?vY0sK9fBMDDkQ59A2aMPhp31rJm7zUsHiczPH8igZC+2QDpJQSq2rjVmeJFs?=
 =?us-ascii?Q?xLQiKQw8AUCH0sNzMoLFn5iPavZVny0NaOVTM4kfihajv6kweKitB3dOvEMZ?=
 =?us-ascii?Q?wNJxUwaCJ+8pmMVkZbbtOSZ77R5WBKvMBpNcJkJmVGiceI2DvoNr4jejpr7D?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3caccb-7380-4366-e09f-08ddd358f0f5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:15:11.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhJnlJPjuSDEwNi1Raz27NWRQS5esB4Oi9quDIUoopHyxU+lpieeANyHIMipM5CB4AG7M0Kp8pkPHVJ7eGGH6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10349

Hi,

These 2 patches belonged to a larger patch-set I sent a couple of weeks
ago([1]) but I decided to break that set into smaller sets, where
possible, as they will be easier to respin, to address any issues, and
will probably be merged faster than the other one.

Also, I addressed all the reviewers' comments received previously for
these patches.

[1] https://lore.kernel.org/imx/20250716081519.3400158-1-laurentiu.palcu@oss.nxp.com/T/#t

Thanks,
Laurentiu

Changes in v2:
 * Collected r-b tags for patch 1/2
 * Changed patch 2/2 commit message to make it clearer;

Laurentiu Palcu (2):
  clk: imx95-blk-ctl: Save platform data in imx95_blk_ctl structure
  clk: imx95-blk-ctl: Save/restore registers when RPM routines are
    called

 drivers/clk/imx/clk-imx95-blk-ctl.c | 57 ++++++++++++++---------------
 1 file changed, 28 insertions(+), 29 deletions(-)

-- 
2.49.0


