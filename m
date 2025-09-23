Return-Path: <linux-kernel+bounces-829577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AA4B9762E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01901B21C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8B32236E9;
	Tue, 23 Sep 2025 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jx+Q9Pqr"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45E304BCD;
	Tue, 23 Sep 2025 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656716; cv=fail; b=VP82E5mh2urZCIgpDyFNFeaf5pC7RUtrD/wTm+4yFieMDoFCK7+fLKLygHKl8QfA5F+Od+s9/0MAMsnISBJdCloYN5drkIUw9+o2BtbLoKGlUiaY04IztFCRky8rdOgJqyBev0xpRu7IVNYOVt9NxRTlHa4ossKVSyxvEWXfYJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656716; c=relaxed/simple;
	bh=/vTXStpUh0pUbQULtKDY+Oh2dWCAFU6XFDwuM+bvZJU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LmI2VzCQbiQRZye57wfJVyL871FAyMbKONkHBkbfPmm+eipSqog8Ij4E7oHi4fH9dzzUjXIxihQxiRe+D8Tr08jiRXrPNJlu963o+VErNLe3bXBvK9blcPrUXIC3dexj3njuwcf7saSSpS//7habYlbVjHQEOP68HHjIQoZyT1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jx+Q9Pqr; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1IRz4Jfpa5ykTZHbzVUvktzViNslVJR2RJ/Un8XY6MnsVngZrELAglaDFXt/5vctfwAeVzZKZD1uUV7hx0XnmXEvssWVw2wm3Pr+zJdW6bt1p32T2X1ORcKoiErOYGNMBpVPtwhhTupVJ8TP1ZstgQy9rdbfDIcsJjQgVHpRN8A5aJHCuUvS8m4eYbjhzkKAgNYN++LVI+4VolsAu2ZXJBX5vu6dQ3AV//xctkuSCA0xMg3gGxClPrg8Rv5Ye0mrzZqRj4+ZWMFLoHBWllUvn2sm7JIFe98aOBe7wsLQa+Gp0PZReoAwjoc71bJBCw8M4lRNa2CGyPi27lG7hPN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U10tsrSyjfYiDagQjKSbR8mqJp3rFHjMwDppzujDluo=;
 b=BH/scTROKmrI+DJ/wZpdu9M9uWK4mCiBpKNwPBex4WO3K6BcFmDgvBmxj/RSd51FTo+HP6ETBI2bR3yP8qOTQ75UT1nw41B4ZJ2sjt7U++XbiGdduFUxItXwJp1zCA8k/9Yj/zoJD0ND8LZWFsgxOhOBYv7FhbGFC72yV9x18INHRb7EeRcJ8n1YR4r/ELZgT+9lcMbQxhFYRNuY0nv+1DNpNkq4fcZidMFxOsgEDXJtu03vTonAV2H/M2pMkcUDdmWelPKl/L+T7zEP8Q1sMxSp/4podMt/1YZX/rKJQBnbE+fn28PXI2Bo0VcpWRj5V4iw+T2qq6WKTY/aqUqiVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U10tsrSyjfYiDagQjKSbR8mqJp3rFHjMwDppzujDluo=;
 b=jx+Q9PqrTrZQ1RF9CzKC7VHjaBue3hz5AAqleaxljG0GJc6Za9KzEd0cBds10jpTSu1wxlAegivHsF+rD3LElZ8QYNb7nFwnL+jZ3eRJCbb9rfPBMXbfkmmmzmOc1GWT2TgXFDm/XVekHVsMdqp/FT/U479OU/7GybKQxG3BgtXEQBB7UHDjpTtCEC6qn8h+L0zRXHcFRKX/9jK7uuGwvkF2pJTSqWDpQPhUr+NdAHQmzsFipp6UckB5WqfYiueItcIbRZT6MDTSyqv1d8pjB8bpWjzsTlC6eNilULCj2yJ2Gcxp9km/oceUrc7UtwizneZP4J1noVq/wkJs+KeI0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:08 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:08 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 phy 00/16] Lynx 28G improvements part 1
Date: Tue, 23 Sep 2025 22:44:29 +0300
Message-Id: <20250923194445.454442-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: bde26ab7-8c08-4a8e-3f03-08ddfad9b35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NGg6Rjn3bPN7rPH34Dti6scQsCZQCoH2mgNzRdTWqiuA2WwH4XZ7Ayw4QMpz?=
 =?us-ascii?Q?FpRg4GMWneCfPegu07t8vTdY/IOhM5VCR6OAj325PFOeeqEdHIwTBDlxAHHq?=
 =?us-ascii?Q?QK4lepVMlzMh3ZWI0PXwtY9ECAmYKxJi3apAwKs+QM8WBq7fHuukoQBDYWOM?=
 =?us-ascii?Q?cXaOlUVIGHN0tqy6YNE98Tu8yl2DAhoaApCjArDCapSajWfFD4MZlBh8GLhG?=
 =?us-ascii?Q?cPA4YbLS7DgRmqVGRvE0GDpE+kaqZVv4RYqgUusF9RAeLycralFWMz36LiPW?=
 =?us-ascii?Q?+nQyIcvtVRz4Ojht3bl76Wy2XsK864Osk2lTWqlZ5jYgYeI/xbkUzQSON7Lj?=
 =?us-ascii?Q?fEHpb/yjEs724IhWIUlZXeHEEedJHWPdla5R4W6/BcwnzrZT12+wxMlmAPZa?=
 =?us-ascii?Q?vdpl5inUBNtv/3o/dj0bRhnddAAA+fwcHGAsyks5cr+B9DSV8nfDblU9VQKU?=
 =?us-ascii?Q?S5T60SAYcFD9/8vlrKfqXsJT8ZMzVR4JYlOefiBuFY/P08sxadnY6rLnqVAQ?=
 =?us-ascii?Q?2BS4zD/+m9NilMyUTr3O3hPK5k0D9PEWm/c+2PSsxBy2F/U1P2n6HhURrHJH?=
 =?us-ascii?Q?mN5qW462hfO5DAX/ek2JgCKhs4NBovh5B2sNgQyEJQRyDh5Noa3LT414vLXC?=
 =?us-ascii?Q?V7/Pfk82eRr7c9ywQSP3esht2P3KqDvx/4w8Jd35BQLVGkqw40xSb7HSfrnB?=
 =?us-ascii?Q?iqxZ2ni4BIYwWtSJK5xyw75Cdr9K6pZjSJ2K4/8Iu1yFLkjad4KqsDGa5BBw?=
 =?us-ascii?Q?ssnEDAjhKmsURqOfiy/Ijwtf5GRkIMpBhkEQ70ctIT6JOLNzzAFyvP+JE1Hx?=
 =?us-ascii?Q?2OsqhH8ZY6sXN8FRTstqOjHqA1RUO0J/pBgVU+IpuH+UhYHI0AKcXL4x5CbL?=
 =?us-ascii?Q?xFkD0XNhpApUlEeCXxNmSmJD3/EBcoaadMbyFgtI1zBnHmqLlK4MnjzZxUZL?=
 =?us-ascii?Q?Flz+ptXELNiZlGjKQZQmuoAdRBvL+dgfvrhBLefEXV23GCnVmyvQDjrIGvl9?=
 =?us-ascii?Q?Z/eBz4prFdsITEiQXRkIlPYNutxlYQ7j+coRvWw7Yj24tcDk5I9HUAu8SgWx?=
 =?us-ascii?Q?JvcGeu/b9VA9qtcxsnCZVmJwbIcFxFRr/s3QQThBGBSLQEkkTpWSPXmO7zXB?=
 =?us-ascii?Q?r7xPdVkXw9jSisN0KSjjzQc+JMLnzE7V35xhFUMBIvdfn+BGspx0EcpjcDLZ?=
 =?us-ascii?Q?Rrxy+CN9cCjGKaeieZ9eNShxbq4Y6kkzY6bavE3LDuhXGFxhHqQlq1Kup4t1?=
 =?us-ascii?Q?gq8thCjOHWKyCdl6Ha171T0FDlVOb5kFsjojleDOXhhLeULVKGOLHH1tscnl?=
 =?us-ascii?Q?EGle1+I2sju95fsuqnLslIfiqqSNlw6ny2yENh/05+Tnt4flCI2e8SZ2t5qM?=
 =?us-ascii?Q?Wvp27Z10BshAPhbZXckMTxYbgKZdc98Hto46dfBvO1QJeAVYecD833SHq+0M?=
 =?us-ascii?Q?8gFTE4WodB4JezxJUcq61GUIH2oS4H02U2KFlm1QD9uqYgm5db8Zz+8VWGeY?=
 =?us-ascii?Q?9OfnoDNPW9L9eFU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ql7rANe58nYvc6KzGjil1htjaebPvx5VMcYVQd6wXp3bxxSsn0t4UDu7bycn?=
 =?us-ascii?Q?JP7TPOgWGqcRtIRadn72H6CCezb+4yKU2n8usKcfp+Rz97WTW5xaR4IT/bdU?=
 =?us-ascii?Q?8DSV8G7gBtAoKg/J8quXartw5qJNbQPQbM4J+qm9BxzWybaehchaq6BhFVqS?=
 =?us-ascii?Q?tMYcfwE9coQRz7XK46KehQnx5XM9xuav4DQh/V0C7/GE1Zayg3vxnotEmpuI?=
 =?us-ascii?Q?zUlrfcNhWDKFKSvia1g5wtQgqDHLrk5fbzIJ7kmjgEQG2BfkA+eBRHbDY0X+?=
 =?us-ascii?Q?8Dj1SeRtOSxaK1q/y/cS1Wb5eoDQtXbwlbGEoIp+RK8lsHm3JO6/m3rltcwJ?=
 =?us-ascii?Q?AkcLyzVWNoXoFelKDNqwTcgCrWw2gwyz5XxpZ2UU68tiuJ6tSIqiwAv+Kddj?=
 =?us-ascii?Q?oeFrKCfwmBa7hEfu62nBnrESeGipZFdiIS0X5ntxQklXsPb9suq6d/pcs5zb?=
 =?us-ascii?Q?/OvyycbrO02cDTgBTlNHzeoBybiDj80UtFdRlnzC6n0UkuKaIZvYTpCfFWS0?=
 =?us-ascii?Q?02fiYgLxOQpW19wabKjt5Hp4tA+pDvtQ+hYY2SEbg3chBxTMIp2ebrU9+/zF?=
 =?us-ascii?Q?OUOmspUl2K7NRFRKEtQ3iQiLyiiIJTCnUJoJnPToiwQ7jYlbl5a7HlF13hqU?=
 =?us-ascii?Q?q5t4SHNEpdmX8c3+5aMsp8pBqM2NhzAXGO6xn8xNeDiWhylEK63qN9BJuUjG?=
 =?us-ascii?Q?ZsIgNVGi7cWdUtBXngsZK3zPSigHY6Ll5rjnoxkNZKJ6S1fZSjjn+UfSuCw8?=
 =?us-ascii?Q?K46RUeOeIzbnvJChKCYSkCfMZSL7lhi0j67BZCoKJOyfL3AjuwfkHM//G85X?=
 =?us-ascii?Q?wmhSasokKXp6eaGj6GYoPGLiZumxthVTNtAnKERMOPUgz12xgeaeWwUL74XZ?=
 =?us-ascii?Q?o2qBH7fVAqBlpNtPQLuVfL6cdkB/OMzmiojq6gVEhiBB7Qiq7Jj96QadyToO?=
 =?us-ascii?Q?Ew6GlNZh/YpTYUcKEOGo73wdVIcW10Le13z3SqfIlUEv3vzHQLdj6cDVCc5C?=
 =?us-ascii?Q?6H1Dwi2yI1KoB5xWnC8N2uwhsoZmlTnjACUVlAXqhZ03Q4xrxxvf2Kx+pWD6?=
 =?us-ascii?Q?Fha0CEOwFBOMAKw5fvegNTMml90jUyRmy/YH8N1Vh8dwj6DQKxfzRtE8h16H?=
 =?us-ascii?Q?1/QbXrxyZZFPQQ6+jdGnE1RP9ihLlqwLsRxkn1T8RQ9Php3Wp6UrSDszWVB3?=
 =?us-ascii?Q?UaPegYkFg/XnuDsnCSH9BXYUKVpisO6XEB4gzWHY98twOifr36+VLSdnnsKQ?=
 =?us-ascii?Q?rwZQ4AXqaVg5AQuQlUGFZu8NmbftTyFJ8G2NOl+8ir5z1iRMYFneuAGKjJtQ?=
 =?us-ascii?Q?Mv4vhfmjU8AR+EQPmMSLjuNhFo5ez4//zCdq0I8ubCXiPYclaZWTvzWgPgL9?=
 =?us-ascii?Q?jt3B0vX3Z+mbqM8iAENJR4uniMHA6IOsjjVEES7YN7VX7paul/YCassZst+U?=
 =?us-ascii?Q?wPYuIWa6RwKlu9kRcdY0TsX2a76TUSHnyZxf5km01m2xLR8z2c0laWH6FbFc?=
 =?us-ascii?Q?0ZjJP9unzfM449jP2QhKYv5iMGicGm39s5bZc/Q2NpPuBDyMEZVM/B58sr4M?=
 =?us-ascii?Q?R1kASRdgCtNQGCkXK55V7SXuQeO5eTSo+wdOda+Ah4/aNu0ChdAKv+sEL8us?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde26ab7-8c08-4a8e-3f03-08ddfad9b35f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:08.2237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pz3Lu/0qpinzMOa2io+IZgcbBx+YMEMbFYZQ7DjUK7EYxO/o5lgjW7FkL1mO8njaH1o/84E9BQ6pCJSQbwZlZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

This is the first part in upstreaming a set of around 100 patches that
were developed in NXP's vendor Linux Factory kernel over the course of
several years.

This part is mainly concerned with correcting some historical mistakes
which make extending the driver more difficult:
- the register naming scheme forces us to modify a single register field
  per lynx_28g_lane_rmw() call - leads to inefficient code
- lynx_28g_lane_set_sgmii(), lynx_28g_lane_set_10gbaser() are unfit for
  their required roles when the current SerDes protocol is 25GBase-R.
  They are replaced with a better structured approach.
- USXGMII and 10GBase-R have different protocol converters, and should
  be treated separately by the SerDes driver.
- Lane power management does not really power down the lanes.
- Consumer drivers using phy_exit() would cause the kernel to hang.
- The 3 instances of this SerDes block, as seen on NXP LX2160A, need to
  be differentiated somehow, because otherwise, the driver cannot reject
  a configuration which is unsupported by the hardware. The proposal is
  to do that based on compatible string.

In addition to the above, a new feature is also added in patch 14/16:
25GBase-R. Code allowing this mode to be used is also necessary in the
Ethernet MAC and PCS drivers - not present here.

The set grew in size (sorry!) from v1 here:
https://lore.kernel.org/lkml/20250904154402.300032-1-vladimir.oltean@nxp.com/
due to Josua's request for a device tree binding where individual lanes
have their own OF nodes. This seems to be the right moment to make that
change.

Detailed change log in individual patches. Thanks to Conor, Krzysztof,
Josua, Ioana who provided feedback on the previous version, and I hope
it has all been addressed.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org

Ioana Ciornei (2):
  phy: lynx-28g: configure more equalization params for 1GbE and 10GbE
  phy: lynx-28g: add support for 25GBASER

Vladimir Oltean (14):
  phy: lynx-28g: remove LYNX_28G_ prefix from register names
  phy: lynx-28g: don't concatenate lynx_28g_lane_rmw() argument "reg"
    with "val" and "mask"
  phy: lynx-28g: use FIELD_GET() and FIELD_PREP()
  phy: lynx-28g: convert iowrite32() calls with magic values to macros
  phy: lynx-28g: restructure protocol configuration register accesses
  phy: lynx-28g: make lynx_28g_set_lane_mode() more systematic
  phy: lynx-28g: refactor lane->interface to lane->mode
  phy: lynx-28g: distinguish between 10GBASE-R and USXGMII
  phy: lynx-28g: use "dev" argument more in lynx_28g_probe()
  phy: lynx-28g: improve lynx_28g_probe() sequence
  dt-bindings: phy: lynx-28g: add compatible strings per SerDes and
    instantiation
  phy: lynx-28g: probe on per-SoC and per-instance compatible strings
  phy: lynx-28g: truly power the lanes up or down
  phy: lynx-28g: implement phy_exit() operation

 .../devicetree/bindings/phy/fsl,lynx-28g.yaml |  146 +-
 drivers/phy/freescale/phy-fsl-lynx-28g.c      | 1408 +++++++++++++----
 2 files changed, 1264 insertions(+), 290 deletions(-)

-- 
2.34.1


