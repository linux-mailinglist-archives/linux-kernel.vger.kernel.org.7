Return-Path: <linux-kernel+bounces-752711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC18CB17A07
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23577ABB17
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD7283151;
	Thu, 31 Jul 2025 23:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SrJyxkJO"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704A27FB18
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754004214; cv=fail; b=u3KrrYMT+kZoBhL9EgtWThjdqYhu3iEYcMvZltfMBwSqY5qiPY9VJttwjGUcHk0BSJ6vxG/6qE85/AqgCS5qjcD4iG3YW5198lo6+P3JbLo1W/2K2wOs5D1dfTLjzLG+9yfke5KZ7RfX5Ep73nhkDuO+VUkdsObYAfxGpYWp2bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754004214; c=relaxed/simple;
	bh=d2f5xH5N1AlXLrDKnIF2oWPR8eVmlZgHfPoTes4sB5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JonoQG7yPSFA5ziX/MO26SrxXVSp1sy2+1DjinzrDQvOK1GIKCxKK78gA+N3nV4ueKBD53sOFhPv2PwhAF/XZBpXZX07Yr2JgxK17NKkkfrLWiMhhzXnMpUvdKalvKbky2qGfP1N+2yguWD9FE3I/0RBqLHzSBdmkHG7iDAO6IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SrJyxkJO; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6qG1PJAZd8TzKauVdSCQujohaNi7ckmHQzF6J2Xzztq3o1Scy0EgovGc/SfUO4DTy7BwLnGF+syIsuFvnGVqV/sGAZwknLflHM0qND6tkmdiciWxK2fv5cCnhyT7boNZYZEM/JWh9y2GAuZQB3TIudIlFYkfTyDW4w0QOInXRl6x42Kdi3/dXK/VduzPxMguevlyEva6t7mv6ZLKLWcLsVyXXSZT6hnAXcWx1xUxSfT9XkrgFzo1/Tt64PmrKO0B5iAwAIDsfrW+tTtN7DktXvdhqJnrbEL3RvsZNpOrVwa9d4hVo/51zjZqx/c8IWqGQ8uUVNQTTFhq1nJHH2heg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KJ5ckWDwknp0W51nWUSNxAsp0Y4Rl57HfBWQi42Sfs=;
 b=p7Mu/vZI9w22jgx35l5qorKc+qcWhlYS6Asmos+UNMRC4wnh8907ELHqeKlEIDqzhojI2GpOhgkjgPnHIcaWcyE2lMKJ5k9sKtuQiM3NLXBe2DAKb2ND2l/p8vxnCNQONUR26GRBFkBE/F3GRyXiruv6ShHm+Pq48i2yXWsA27qLfmpJz/3ZSCQWUitzD5TnzuAv3Gm0rqDiHsyKBTxIcw0Mp4hHsD9zEXFtoMnjVoybA7uBqV7T//8gk+3nRIe8uvMieWcBQT4GvJLwk2zCMXYTjevUp54s4jN0vZfEN+rC0LPUdHiyUeCg5cF2SBAYrgD5JSeAEbFIAE3fNOQ25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KJ5ckWDwknp0W51nWUSNxAsp0Y4Rl57HfBWQi42Sfs=;
 b=SrJyxkJOgMhKraK8FQZ+tMCI6xO4K4ePmhY9z2Yq2nEGgNpJsmojjEz2BOaCfv4T7JlsatYPk/Xs84rN/G0VjT33EE3M2f6UbROA3ZJuvB/gH6tezXSvl3klAvNm8/fl0jFtBp+QcodE5gxdJv2+FdafrGPb82B/3UGA8hOk5vGBEyKt6xcHTBx8HUz4c1xupgKGKIoGf5Dr62pPwE8LUFwFN3RYg7ajOKms1B+Ms3TLb1jy0NxlGUhqf4ojIVdPiP05k7HQ2RD4c6UCyeGgfQrT1A3Qb3H/PCBuvfSlEaF3BxJt+pq/upJHvWGNbVec4WIit1yUz9nKE2JTaA9e8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7825.eurprd04.prod.outlook.com (2603:10a6:20b:24f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 23:23:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 23:23:29 +0000
Date: Thu, 31 Jul 2025 19:23:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: quanyang.wang@windriver.com
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Richard Zhu <hongxing.zhu@nxp.com>, linux-phy@lists.infradead.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: freescale: imx8qm-hsio: Fix a use of uninitialized
 mutex
Message-ID: <aIv66YIxgX+ufdaP@lizhi-Precision-Tower-5810>
References: <20250731020717.2240392-1-quanyang.wang@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731020717.2240392-1-quanyang.wang@windriver.com>
X-ClientProxiedBy: PH0PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:510:5::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d44bb6-a6f0-4ef2-8ab1-08ddd08941b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Kd3DhPRGwezNfIeV+CKqpZzpQaPWfG3xf90BWvJY+kATNsYlprOwvywaNyR?=
 =?us-ascii?Q?K2IkbPEMd9Dj0FNsetFAcLMyodZ/5ZzpbnFL8dhb9t3mG5f9JF+9kYIQt6je?=
 =?us-ascii?Q?ox6ePdyMYEa5ymTOafzEQgCGW+mvaRoqRxcuzlMeq5+Ak0+ITwAkprc6YANP?=
 =?us-ascii?Q?nPiq+JZBxlzKMN1m2WaRUj1uQIZShv92DGJy3E1Y1PD1JCNHZm8epD0aGsA2?=
 =?us-ascii?Q?Qa/YOHjjC/DNY5TjE0UwbTFZhTydNPl4QL+SHsTxpUDQsf5li6I+xb3TXSWo?=
 =?us-ascii?Q?cLc+APxZ7jjxVYNWtNBoLqlILQHj2P0nyzN2ru+QMCWg9X8g/X1IreXGPiLJ?=
 =?us-ascii?Q?bDxj/5osf/KVVYWNNbf85Ey+KfBQBQDSjmXpmaii/JGMqL9MMVyrEO5OS12L?=
 =?us-ascii?Q?vr6Qdw8Ttac8mJumjoRg6EKkjytTQyfkA6pxH/LY1WQF/pmJ5UzHNh2Vna9L?=
 =?us-ascii?Q?4skEVlY8mO7F/UrV8+4Sv6psWKR8BNZ420s1iTynRTs0l9I3xZUkDHeY1OU5?=
 =?us-ascii?Q?WhEFg8DSyFD8AGshICpc7UXllon70786ad3oKFLPevzVDWHxKSAYXaLcsN4x?=
 =?us-ascii?Q?gceLGi4vGj2hTUew+l1eiVuX5yEGOSej9f2A450oXDoeaZa11xTuqhMNWlTU?=
 =?us-ascii?Q?0OB5OfIhtvyapkbhzf9RVkbbz5DsgkQtGO72pUTR2KfAzNeIBLly+opBrrKK?=
 =?us-ascii?Q?IFPnDPbCmiHSAMzepxZC04nAA8C98ai9lYQQ6vqKLevcyUoz98QoMrlk5rUc?=
 =?us-ascii?Q?EetJqL8zFtjQefnGSMW4LqJchsma1emyJ4HWU7zaxQcFnw/dnePxMFyulAFj?=
 =?us-ascii?Q?/vnrcpDd73rH0zOsNqsvNHzALGiT5GQTl1Bf3iKXPAu6KKPi5SXW1bLHsoYI?=
 =?us-ascii?Q?fDL+gpfkjD8Ga6hIjF3EBxj+upikT8deDguSb7LW+iIdnRfxYSRAZfKpd2x/?=
 =?us-ascii?Q?m1ZhPaqKDuVHyZongL6S/lpb17yqN2FODWfLbvKsqXB2IsKNCQ8MVXE08jEz?=
 =?us-ascii?Q?dJhVAh5D+SJRQldkWwQgDG7631iphUSO8IoH2aHMGxTNofoumPUnqlGyQNVX?=
 =?us-ascii?Q?Lfxl9iwWbc+AwTUp7mVrV0Ck9b2MWIeS12mmDxExbznmsQbNRdbL+F72U04Y?=
 =?us-ascii?Q?81cHiKm9F/9TTaknvng3p1E6PRG4gmwbeVR8QT3lVKmK8m3LS+2CC6mC3myW?=
 =?us-ascii?Q?KZqR7Z6dqGgv5nB2MKqDxxPRaIsTETboijxLaBvBRHQ6jrIA7K2cxp+tUdFO?=
 =?us-ascii?Q?XRYKJgXrguRVUE9BS5+sc4If7Ixj3AXUar6QO3dHhcVo9oHH4g4rYSdIu1AW?=
 =?us-ascii?Q?aYvkccZOlvXWzsjFC/7GsjtNdL4+OlmI+gOJBop9i82zoDBvt9F6azNO3yCr?=
 =?us-ascii?Q?oa/lqzffL3ePlw+9CRXom7wcUcLplv0yKB1S++VuBahiTDIr7d80m/HGu/K8?=
 =?us-ascii?Q?EXjwuIqrGjfSfXsogEwDWUc5VJF80potLk3umdH23FkyfrY7bKr5xg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PG8QKaPRAe7Uui0OcL5rp6/gP+GyiPMYbDYjtGpiYjmnEtzv82o0aqe941p7?=
 =?us-ascii?Q?N9+B6L5rBcgo6xTnH2XBJuXaVN/9p+h6eNnSdqrZhYK4DTkmkl8FI26qsrzI?=
 =?us-ascii?Q?UJM7S6giij+9sJryE81Eyy5oZSzXwJ/c0KkRWUfdM7FepL/Rz1Nusdy+aK4M?=
 =?us-ascii?Q?OSkBnH4LG6gYhjm39owPXWqK6g2MzFvXBrqwGsEzS13eyq7Z5g11Y6lB/93Y?=
 =?us-ascii?Q?A3pv8KOFLMJklBJI1DcSzsmEomrx1gZgIVYfMEdiz1HHcxOsOaHsqqQhifrP?=
 =?us-ascii?Q?BCPHvAl6xXQWDon3sBX3ugnci+BdlGfTG2oXfOfI3qUShAa22SAJYC0jPS8i?=
 =?us-ascii?Q?cREkW3w/9vRxMX0pOe3ygos7O3B8fTtRL1o1KrdrRW0iRjphTBpa3PXKolku?=
 =?us-ascii?Q?MWc3R4E0G1uzkFjbvUSPwYGK3S8CAERyrhACbAkkL5JLlhkZvyYAgvrCC81G?=
 =?us-ascii?Q?h5knBzTZ96r9wH9pkUskAeUF6iED88bXi+2GanXHZ5LfCgs/0K5ak+xPBckc?=
 =?us-ascii?Q?T7lKgFqjHq3s0//Q7+vo3udpTndkiAzmMnbHGuef0Gnpp0kREuMhrraeDbT6?=
 =?us-ascii?Q?qoC2GCKGMdo065L6CYvMhR/sob4pOBNKfmeb1lTbBzjavGumnKInJ8aheLo/?=
 =?us-ascii?Q?GnFoW8hmVtmbw9EFFb3PiqSQKLowKH3HheAjQCuw3If/Z+eIQznXpnWpo4/O?=
 =?us-ascii?Q?uDvSaw9MMAZci/RS2sMzkkJuYi4nyFjsqmtowQN8tJhyuoLJLyFZrYbdxk7o?=
 =?us-ascii?Q?XWOfIq3ESbkdOOCH95LHr7kMFgyzUiuKsI8Uyi5IXIYlOthUu9iPZ+pYqha9?=
 =?us-ascii?Q?qmn2MaSc9F7psRLdV4AX1ajB9AobJD4zfvbjU1aWk/uazcy5Assf5tkzd/mP?=
 =?us-ascii?Q?6/sQPy95j3BR+g/IdIWswskYXevwj6q2JVxfY7y5nCdYY7QeDAaam8poNY6D?=
 =?us-ascii?Q?e2wz3cYFUTXYiodDq5WTRdIsuKg505z9QGuawsg35Sc40ICIh7+AIRXMVlxg?=
 =?us-ascii?Q?+WnHu848b2kYTUne3H3ua+/99usnko8w6vWA4WXUxKSba0H1gAYDczYq/TCM?=
 =?us-ascii?Q?hyDqYmuqnRbdEbm7RxJml7C1hzrnSG18HhVMuj3TwQdEbQkUHA25e0IoBqNT?=
 =?us-ascii?Q?EIPOcCICPs7CWdQ7e9kDwznlDe/pwyK/fJ15qzto8Jix9AppEPfz2pS73sXX?=
 =?us-ascii?Q?j54U0kihVg6dzeCaI9PpQs5Sxmj7gAZp3LBIT/ShQC7YQR+ytz9wybOnjycm?=
 =?us-ascii?Q?CRuq2zaHWEE9Yugfj0UQOrDBpxDJFVXeyCEx7hv2G1/G2mlIn9O+yONPqwZ2?=
 =?us-ascii?Q?EknQC5HsVi6s8VRUUpwcyRb1VAGy1ygLy5ShAngX0sA5Wtbqsk9h6jfecnAi?=
 =?us-ascii?Q?yrwJfnbqY4y+lVtAi6gw2631hYcQ8jdicAV+Eo2YxVFi7VrWyzZmrtHw2hZ5?=
 =?us-ascii?Q?sSR+h4oYHMwABsTggj0QXVQX8b4srXwBi2w2y6mp336cW9klFfELB4YFg6Rn?=
 =?us-ascii?Q?CGjh/LG0RjQTPtovRLpHXAYH4A7W4FuQz8XuO9httTtzbFvQYWqUp9QFlu7h?=
 =?us-ascii?Q?eglNjfux5TJe/0X1UGY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d44bb6-a6f0-4ef2-8ab1-08ddd08941b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 23:23:29.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EjJInw2HOZJ9YxnOn/oN8z2DBVHsL0cBKdZDydiAy3V1dDp0XJ0VQX59Ee9tG6f5vh9ZnLRDfn/Hp4G1lkVyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7825

On Thu, Jul 31, 2025 at 10:07:17AM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
>
> Using an uninitialized mutex leads to the following warning when
> CONFIG_DEBUG_MUTEXES is enabled.
>
>  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>  WARNING: CPU: 2 PID: 49 at kernel/locking/mutex.c:577 __mutex_lock+0x690/0x820
>  Modules linked in:
>  CPU: 2 UID: 0 PID: 49 Comm: kworker/u16:2 Not tainted 6.16.0-04405-g4b290aae788e #23 PREEMPT
>  Hardware name: Freescale i.MX8QM MEK (DT)
>  Workqueue: events_unbound deferred_probe_work_func
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : __mutex_lock+0x690/0x820
>  lr : __mutex_lock+0x690/0x820
>  sp : ffff8000830b3900
>  x29: ffff8000830b3960 x28: ffff80008223bac0 x27: 0000000000000000
>  x26: ffff000802fc4680 x25: ffff000800019a0d x24: 0000000000000000
>  x23: ffff8000806f0d6c x22: 0000000000000002 x21: 0000000000000000
>  x20: ffff8000830b3930 x19: ffff000802338090 x18: fffffffffffe6138
>  x17: 67657220796d6d75 x16: 6420676e69737520 x15: 0000000000000038
>  x14: 0000000000000000 x13: ffff8000822636f0 x12: 000000000000044a
>  x11: 000000000000016e x10: ffff8000822bd940 x9 : ffff8000822636f0
>  x8 : 00000000ffffefff x7 : ffff8000822bb6f0 x6 : 000000000000016e
>  x5 : 000000000000016f x4 : 40000000fffff16e x3 : 0000000000000000
>  x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0008003b8000
>  Call trace:
>   __mutex_lock+0x690/0x820 (P)
>   mutex_lock_nested+0x24/0x30
>   imx_hsio_power_on+0x4c/0x764
>   phy_power_on+0x7c/0x12c
>   imx_sata_enable+0x1ec/0x488
>   imx_ahci_probe+0x1a4/0x560
>   platform_probe+0x5c/0x98
>   really_probe+0xac/0x298
>   __driver_probe_device+0x78/0x12c
>   driver_probe_device+0xd8/0x160
>   __device_attach_driver+0xb8/0x138
>   bus_for_each_drv+0x88/0xe8
>   __device_attach+0xa0/0x190
>   device_initial_probe+0x14/0x20
>   bus_probe_device+0xac/0xb0
>   deferred_probe_work_func+0x8c/0xc8
>   process_one_work+0x1e4/0x440
>   worker_thread+0x1b4/0x350
>   kthread+0x138/0x214
>   ret_from_fork+0x10/0x20
>
> Fixes: 82c56b6dd24f ("phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY driver support")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  drivers/phy/freescale/phy-fsl-imx8qm-hsio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> index 5dca93cd325c8..c97b7ae3f5b63 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> @@ -590,6 +590,8 @@ static int imx_hsio_probe(struct platform_device *pdev)
>  		phy_set_drvdata(phy, lane);
>  	}
>
> +	mutex_init(&priv->lock);
> +

use devm_mutex_init();

Frank

>  	dev_set_drvdata(dev, priv);
>  	dev_set_drvdata(&pdev->dev, priv);
>
> --
> 2.43.0
>

