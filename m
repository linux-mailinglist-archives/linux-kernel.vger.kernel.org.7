Return-Path: <linux-kernel+bounces-777686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BA5B2DCB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978BB169560
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF4F311C1B;
	Wed, 20 Aug 2025 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Rdkp2fwG"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013060.outbound.protection.outlook.com [40.107.44.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1952F1FCA;
	Wed, 20 Aug 2025 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693284; cv=fail; b=aUwTMHnKRpLHVpVy+SpAoHxaRVydl/OPnET2Ll9e/wrJb4BB89uUB9qWAJrIcDR4F+AQI2fZ2PXlUVE2SbXYA9hTCGI2ZnOiMKmqoG36lIudfHD0pGp/cryBGtQeu36AgSs2AHju93VFGt58ebKLLiXAKJyTOpQbIjB2rdzVrAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693284; c=relaxed/simple;
	bh=mRNgnuHiADn+i8SBx/RMyEvxP8qF5qfg3hUQu1aoAbc=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KO+nMqJ2NNj2ILxKPXfGoQbXQBoGQg4MRqP/ViVMeAziRNUE9qEx35d2tPY96mFNWS25FqOvWZpzPdcPC437yzZlIYkYNGpe2DJXZfQDdDYWFwgCa+QhWc8Od0bGVwxLyUr74g8+Vcqf6NmO9blXuzOvN4tE2JKYiKnRfgtJ4TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Rdkp2fwG; arc=fail smtp.client-ip=40.107.44.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrSaIjGPke1mJ9uJFAKo/wvSm9cQAv+ZxWaQuBST1qOr/aTRsNipRoNwDVxorIGwq5wKPa7oHPgBrdB9OsN9UY75ZHQmDoB9mxMWidPPQYX/DtgkrsxFOWsgGGbVReOPCizJ5fG+CiGSuLMFmm8DG0ega73AFORK7Rr4gmEvCTlEKx7H+LfbNqpxhk6JjcjqSpeINWwH2RVlaDey8HdI1SNGeyBWbLCs+S9B7E5mvXSN7PmyaJPYwLYlkQGFlQUqV7TCNrvN1jGVzrTQWN7kzaHMqHvcVglU2B0fjJw5PqjaM+gZ3s4YZwKzxZAu2ao8OzYk7kKcrHdT3+egOD8LDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrEuGZ/ge0YAm3T9H8VR3NXEApCCgq4PKndZr3uDlUU=;
 b=Oi2iGzAs6vcLhNRt9PH1G5UP9+B7FAMZifDBWiFxZgCJCx6NPskCNXi24dcyzcqEYVg8Kak+SQ0MeLDUhprhF8yuj+8zhTGWIWN74eLCD4UM0LIUutqMXxd9I6VbRXOuMuhgeeOi95dNrmasVb20ga1MJzjrh7+/RsJtcOmbtwBOSfIgT2owitPH5k0rCYATAqJfInN3xmH/Zcml94gfZnpJxn9EmKeBdRS1x4ERZ4Ewqu9ks7z3yBhNbOAKbS07HPJLAoazZiK35EpRhBCzgRQDHIIQVI3tE3eAFRRPcbrqrO3/9tgQ9Dx2gzEWYPbPaJpYfvIykZWknz6xhCTFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrEuGZ/ge0YAm3T9H8VR3NXEApCCgq4PKndZr3uDlUU=;
 b=Rdkp2fwGl2tB/UxioQ/zAs7Uh581fuUlCFpPk8zLid78ElO8ARlCOdt9jzNhIeB+ZvPJUqLKGK8x4/r4tIuiFgzsXctolHCcHddkUx4zsKi5mAaQF3lQOks/uvcMDrNKVYW0qbNcHIxVFYkFKCB723lHecMvlvNuR0lUiH6zx9vkRckc3q9UMd5LZuh/Qf6mIbYrQBtyUOB+eCN/0Bx6yibVQN2drM000n744rtjyJnKz768mFzqawasqJnWeLswN1/cXZkCrJQ4J0Hn5HyKM1KFheL9Oz907EuuYS+/lwQTmAyqPGjcm8btQYgW94h4o6YaUOnnegMIjGbA+iBZ/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 JH0PR06MB7177.apcprd06.prod.outlook.com (2603:1096:990:9b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.13; Wed, 20 Aug 2025 12:34:37 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 12:34:37 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Nick Li <nick.li@foursemi.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Andrew Davis <afd@ti.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Linus Walleij <linus.walleij@linaro.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-sound@vger.kernel.org (open list:FOURSEMI AUDIO AMPLIFIER DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC SOUND DRIVERS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Subject: [PATCH 0/3] ASoC: Use kcalloc() instead of kzalloc()
Date: Wed, 20 Aug 2025 20:34:17 +0800
Message-Id: <20250820123423.470486-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|JH0PR06MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f09a36-9486-4425-e89e-08dddfe5ecad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lWaBPJ1COwn9VhB/lju6qq6p6HWXxOEw1zeIVEn54TpRoOrOF1DT5+UT+Ocg?=
 =?us-ascii?Q?1c1RAuitW8wGsBrcnkaiD8nrk395ULih9PR92OEV7gZTY7/dbfSGvEeJlGwA?=
 =?us-ascii?Q?Va63a5alYanavZqH5vDVupIrTvsS3rQMOaWonjO8pHxC7fmKMJvF8CbQ8Cwe?=
 =?us-ascii?Q?lsReIbA9gMhE+3vgxdnuN6bSPs7tvUbj5wZbx/mMk9Xa45QRt6ehpaXIoZM4?=
 =?us-ascii?Q?/1l+GeuGUF02qtKuBgXaVmhSCY77PU05Nqf6HKOZ388060nj1oxMG47AnxUX?=
 =?us-ascii?Q?Jff68lgGP4VE7plsx1PJgKJknUcB1TItR0xyesbGB/Otyro2ZyXM0hZI9gF4?=
 =?us-ascii?Q?XnxzTtL+HURsUu6sHw5h4UPBWt09/FRdVyJh8RxZEXNin04RshzRu7/NImQB?=
 =?us-ascii?Q?9PT5v6Dkr+ObVAs8Gv+tmINB9SSxENQZCFTqqQHlTJW196fr5JaJvjjf25wf?=
 =?us-ascii?Q?QtuAL3cMI8mcz9wiJfa6ChGr/9urLzGyxzGuf+zIZqP/9mcZXQqXklB7AB26?=
 =?us-ascii?Q?S8DcuNWzG1fJoXYRvT/BMGEoK/gtZyYdxqruXS2OBcayudjkX/VvUiHJTWYa?=
 =?us-ascii?Q?E/5eEn6bd/uOPzE0y0sM/zYqKgtHTHf4gy+jI/PK2zDCmVh9p4eZCFLiyF3+?=
 =?us-ascii?Q?DWgEqIKxuo1eXHybM3dxBSaowB+h7emJrfGh9DP3CAFDQtBCOt0wYbWy8Z0x?=
 =?us-ascii?Q?+d/4vf+JO8UjMhN3b6OihO09YDC/mqvtAHnxzEKyUkcxQoKMJ1L59B4NHdVQ?=
 =?us-ascii?Q?VLLtnL9q5n86zafbktRYmRWEHRwKfQOO/8Z9WFHK5E1Kcn6cD8ySxcns2VYm?=
 =?us-ascii?Q?ewovPNjEb1lfTXUe7R2B1tYgdeax8/17FjUXCDfcKvoP3FzN1kFzKZVB1yJk?=
 =?us-ascii?Q?EmllS0pjk0OCP5GOpFINBZRmFHIQIAMLuYF9TbaQ9H2OxbDjRKgLlOiqXJu4?=
 =?us-ascii?Q?+l7bv/rLbvbxbLCsx9q1s2h+wIWZqFltPFf3pSOQo98p+2FvZaTQyUnX0K7r?=
 =?us-ascii?Q?JqtJceoXeC/R9vWt0zc2w7YlNBy4eAhv5YwEEsXsbjWR6DWoWRkJLqtrYxfd?=
 =?us-ascii?Q?U6kDzCR4Id+zqmBv0xMauTBbN4lrLs+TX32ujiCu07Htuy3kavIPUXF1/Y2+?=
 =?us-ascii?Q?NfGu7TfZ6+tSTkQ0qe+t+B/CddBDbM5bfygMMB2qvxjj7E4EdrWvgPO0e+mf?=
 =?us-ascii?Q?8IwAs3U/2zgXvw1hVqUkcfc7KXlLVyxeoHl45OszbnC5ODpkmGIgPMJ7pH6G?=
 =?us-ascii?Q?fgrGigVn6jU1WC496u3Q7ejZi4rzei9jxhQ0AnIFQgRZ5os9lYuR0esf7mu+?=
 =?us-ascii?Q?GUegDctwNc6U/aPiKWARy3Hyuo/Ickbg1zRBdqvgcb6MOFsBPuWHpEDJ6O/R?=
 =?us-ascii?Q?SwufYBUGQfNl5BrM0G20B2LNBBSkS8PBJrWOoyrNNwXtBW7PhhJ/D40VSzaI?=
 =?us-ascii?Q?l9pqn6b4dVNutLPBHqO8zckuLapDRH8+NSNiFETIxqwDwW24mPoBfgJs9LCD?=
 =?us-ascii?Q?+5nZAW4i/txYMT6PH9D2UyLFZ5kd83SuTVS7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N/IA0B84r1GFcleSxzjE2+M30p+ZWcGATpFjso5LUMv/4hqz95HUWACpSgXL?=
 =?us-ascii?Q?bW+OIJymNeDjAQrCwJ6NLXm8PSdAKMr6lsX2h9Sb91panc16mQ+lKFHn/vnY?=
 =?us-ascii?Q?UMnY4XwkI4RrfkHK8aHJTpbmKYpPhWzk1xUSVVP1eNHDSjXnHPq6HmQl4k+T?=
 =?us-ascii?Q?xUFeDN2kLitPhlCjwwnQSxtBzCkTWqtWw2YpRpm+Nc0km31t9AA75XnS1nIN?=
 =?us-ascii?Q?/PxKQz663l/aWiK8XOtlSVWRgR3wJB+gORrAKDlzroTITV7qLZSiTp1V7ElI?=
 =?us-ascii?Q?Cq58CSc4avlompMEeAVRzFpbikE8xC1LfzVcJY5l7x4HtEdSNBS25gz2u3ug?=
 =?us-ascii?Q?ScyZ9nh6gjXAD8JfnpMiWD+WtYxXsApAYzQD1pAT8RhSWdOFCJ0vrAYjaPLf?=
 =?us-ascii?Q?bE8SDXrS79y9udPTBku53PVvyUcSLtSTgKqb/Hed+/QjyFu0WKUpvHVb/qSB?=
 =?us-ascii?Q?DAktQk3bWjyKLn+0fiBq2PFZv8Gw288eFMafOHI4qgslTVJwbbkAJe5HFOdZ?=
 =?us-ascii?Q?VBFd/YooBVsHWm5Wh5XmLOlFV8mDkzdHFBclKVQbR6njtLPjlkVdzRv2UkCB?=
 =?us-ascii?Q?z9g8XKj9aQv6Bd0e0A2th+wkj9DUZe/R7A2YuxtjNWbPSfxiBX71ycW3jEKH?=
 =?us-ascii?Q?mtcxYGHzUjzRcRQfax1jtoAdxkfovDkeoQRxBoRzzzqzkmdrXt1L2X0EpiPg?=
 =?us-ascii?Q?rWUl245YzFX7DOG7Lyu3qASNRAIv1r3mvEWQVRY3Fywen+QEy8Mw+M04iBw7?=
 =?us-ascii?Q?TmsqvXvp3LDCwIN3h9NbPDDaomihrLRl5XN6BEbuEbjD9ZrKvhRonT93ij2T?=
 =?us-ascii?Q?ZYc2kvhJCKar1ZusxQChgqXzFVtxXbn28w3xn1C3YxLLnWyfAWe9iKYEBLN4?=
 =?us-ascii?Q?R5XKJJBbofenlODDJxkm5ehDLit53rY+mM/8s7taDubEWfJ7L5RZg86C17Cb?=
 =?us-ascii?Q?JHLvoapt6tnU6BeFNh1bsw6DrJjcBjwYgNu/f7k23Fo2Z1iHt849EIfBVtmd?=
 =?us-ascii?Q?eeZkzbPawvEO0f4rzvuwmJTJSaFJ/ds1VCWnNTyBi9wYERMGDFq+b7P2v3+P?=
 =?us-ascii?Q?neDupjypCwbG7upq+RCHumND5ibAMOAb/KCJN/GUc/MAtz2oOPJhuGplu5Vl?=
 =?us-ascii?Q?lw+jvz68BwfSmfqaDm02Z9NOV/3bya8z+f/pxQrHobTfYKNB6jCWY0hAm4Z/?=
 =?us-ascii?Q?gAlPMGQTMl6r48wJj0+sX3t4RF8k8No5ASM0aJVGQ1f+6k22LUYHMp+vIsB+?=
 =?us-ascii?Q?YYpPKos0h9FcEcYhqjDFGmNLqxze2gQ8m3Ftgd+CX1y37D1yHao+vNj7yiQE?=
 =?us-ascii?Q?qiCUcN2PKJXlrvYVwL1eL28ITPP2u9FqKe2R946BVIVPz7gpC3HXFjTdwE/d?=
 =?us-ascii?Q?gKS1qRyCEbUo/ny7h4txptuz8gmQxQm1pRwzHqimOceF1R/2xym9PvxA2bqV?=
 =?us-ascii?Q?PfHNi+JVRTYvNuwL1bG4+R9Usy3Xo2h0VodlxLOLdWzfmYwKiCAVbkj1djeX?=
 =?us-ascii?Q?H9romsTODrLbCJXkR9yFYS9HQ+COLn3/MZEBUT3IwoCaH1x9y6aKQGcQw4mZ?=
 =?us-ascii?Q?NASYmasSQFARCgaKK7//G3qW/ZcNPrkOYJYxl7Nw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f09a36-9486-4425-e89e-08dddfe5ecad
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:34:36.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43o2CpXG9KbMFNXAyzZ9blxwJ/93yzReYjaJ+hXjug0QdExgAdfEZ01Gj0EO5p+Ki9ikebipNZYzoEsEUQcJsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7177

Replace devm_kzalloc() with devm_kcalloc() in sound/soc.  As noted in the
kernel documentation [1], open-coded multiplication in allocator arguments
is discouraged because it can lead to integer overflow.

Using devm_kcalloc() provides built-in overflow protection, making the
memory allocation safer when calculating the allocation size compared
to explicit multiplication.

[1]: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Qianfeng Rong (3):
  ASoC: codecs: Use kcalloc() instead of kzalloc()
  ASoC: fsl: Use kcalloc() instead of kzalloc()
  ASoC: test-component: Use kcalloc() instead of kzalloc()

 sound/soc/codecs/fs-amp-lib.c      | 2 +-
 sound/soc/codecs/pcm6240.c         | 4 ++--
 sound/soc/fsl/fsl_sai.c            | 2 +-
 sound/soc/fsl/imx-audmux.c         | 2 +-
 sound/soc/generic/test-component.c | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.34.1


