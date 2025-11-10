Return-Path: <linux-kernel+bounces-892688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68939C459F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 321544EAB83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3806E302143;
	Mon, 10 Nov 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PCxTk6do"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A92730103F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766594; cv=fail; b=s0+UT/c2BC9Ztqp5iz0g7V/dvv06PgTD5l7jtUl6yIvi7te0foAtsOv+gvatm3z0TI3ZIIxZ1wf/ME5iKW8q8Aoi6o1eR5KvY+k23wt15gGQCoqI2kWMQxh6Mf1qFXuxz1rOlePgMq02lDMzYMPvTtJQYx01I1VsWjlU+DAj4T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766594; c=relaxed/simple;
	bh=hiSrU6VO3nyLEc//7ywVbq2+KZISlF9oxOiZwTQzVI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qzvfKX0iT5Uz9lPeO6D9Znj2w5UVpBPwy4LxtS6PW4qCOEVUFh0Z4dT3rColcpg0oxTqaGHk4Vg8cqFIcV8gffFp76rPErKbXTyFj6BrW5dgsffQZp7LMmM6gKkwR+rbacg0L6C8RwH9LMBDChPwUmu/+EAKXzBT5spem5Vm+QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PCxTk6do; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzDUU9skyk5DHKiuWFMfZFvxeCi0P9g13XZ+1/UMdPbZ6oUisEw31bKP80O1N75Hoijro3gT75lFsM6RpV3HtEcieP3+OM5d9lIl/rJ6MLBOOpquyj85mqt7Rf+hjb32zuEnRsPA2noxj0F7eCafCvxq4D7sKQemnXFQhFdaV3yAVoCUDD3TTZ6caZqkuRxLyuDzDd+0sVWY3HnGK23wE+hzRI5EBC/gN18qIOC8fCIw04g1nEIN5y4HbOJTOPpQjbgTMOxPn+J52mJBves7OQ+n6bP2SX5xHouCj01tREtlOSkPv9ui04gsd89c+3Jim076q5CIsr+SXXxFKhIt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWqHZwrIKPlEhSzIt/ojOekmBeVvI9nGzMkVomBgS+M=;
 b=XQVZjG46Y+6fzyJa3XFRDtybeQJ1UuwzfLPZVHoa6E+SpB5EGOo94e57O60G5NR1M6kifohH7J7yUgOL7y8UEi4pu1hNJsYIRrCwfB695P3d+gA+cVGWwYAY+fp2xcr796DIpJ8ie4v/pBd6ASBnkJpU6d4lHRPzVkQNu+8p/XqEgq47Zx1XTSj7H80RPy4rxFLKPj7qigUi+SWdGmnKhbhdiJkCh6b0r8tHsYRrzc6HdF2X1ClhH2792/tRW4Wi79KGEDzZCwyxHgcR5AbABhcKQFbWXp6k21ZfmFSbzmCaon+uNHI8KtGGQL8k2o0TdZog+TJL0pwwHuoUew3LzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWqHZwrIKPlEhSzIt/ojOekmBeVvI9nGzMkVomBgS+M=;
 b=PCxTk6do/ARFhuQZzJZjA/U+9dIOQnxsj5cEbvemjIMuDj/LKFrvVJA7FOwejd3Dr7taDkxu1mzhgD6knSNo+wPyxQoeLa73mo8dfn4/f3qOvRyhPZdk1Z97GZi+sPjlA5EmaoEmotDUg0qRcWvBMqMFFgzzmsPLoBOx6DSDhZRjd0bqFQP9ZW+uUVOMWdcF4aFFv18z1Vf2891b+QBzYlI4RTCr92OVXwZcR5nOQ6UQkN1dF6vSFICFEGqEgk90fyy09Gqd/a98jacxb90vQj+hBqXGJ31786NeW/9swGdJGoB2XAVl5kHEtmnCVEUv+1JLJffY/qEaTp1KO0ASww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10574.eurprd04.prod.outlook.com (2603:10a6:10:581::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:23:08 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:23:08 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 phy 12/16] phy: lynx-28g: configure more equalization params for 1GbE and 10GbE
Date: Mon, 10 Nov 2025 11:22:37 +0200
Message-Id: <20251110092241.1306838-13-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10574:EE_
X-MS-Office365-Filtering-Correlation-Id: 352248a1-1c7d-4a9b-d5e7-08de203ac2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ddlmB4bf8oPcfQJ7Y4X1w/Bn7R4i3L/LcsSdy2Fre4gxHs+G9OP2icp9F/Ky?=
 =?us-ascii?Q?VmGI9nsk/VuVsTecUi4jqyPv1jDjg7mGtnQc7VfyrxBni5mQ2hJIFZ/Bx0Oz?=
 =?us-ascii?Q?58oTZkg3sk4hjKBWPCqCwVmZyX103Fk+8Ub0dS12sVdNRN7kpS/z/gaZ6Llm?=
 =?us-ascii?Q?J6ttAzkd4EdPubH+DLWRYZLwiJmkhaMFK7RwWx4rJOaqLZaurRXxSwcYwOWy?=
 =?us-ascii?Q?n5LD5nIqojNRVd3L6SMGo1ehO1ksHo8L4zeOL9uahU/h/tQShb2iC2cqJ6dd?=
 =?us-ascii?Q?CODT9m7A3GtWuvUPwTFz+M97VEsikbpBJxaSO3bOy5n/vIPJGYU46qGmalHE?=
 =?us-ascii?Q?8sGRIKcvPb0V/JMvgS04/PJSZQVTD8V7ZyA9GLFyvvhIzPLDxNjl7uJwnn8Y?=
 =?us-ascii?Q?8pY7m3OySvAH2arcP6hQDNp3q2pGpveCzrwXFYEbNpXiVrx68oReR6um5sf3?=
 =?us-ascii?Q?TcxTdZXTiMbcT+SAe3OMygPBLk9QBRJ8a0c++/u+5cR12aEtVbI9uiNk9O1M?=
 =?us-ascii?Q?r+6zRUd4u9LuZFyG2NciJxxFrfaEgmaxUOpzzcOdwhoHxKEHoEe1k3lx1nWC?=
 =?us-ascii?Q?sKGG4IhAnupcybaLyP/qTws4VOM+O+R+CylpGDILb/3nLhcX0npv8OAJLZUa?=
 =?us-ascii?Q?CU5ss6IiblNS5C9ImJzLU0TXrzQQEFm+R5YY6d7doxeCL2Nz0+P9Ckuqq4us?=
 =?us-ascii?Q?TyUUFQX+r/dULvRfNct/p/3VAsTq+v+fVoGXYDQ3CfmOkU/rgiK9GxhKzIyq?=
 =?us-ascii?Q?Kh0/SthalbXr6cYCh3UnyYKQZkqJiAjBsW5c0KRe3qlvrhGsNeRDqQg70EpF?=
 =?us-ascii?Q?0S/Kbxgt/uOojntTkT6Jt91+a8zM08d6mIqARWjPMrH0k9xJZWeoyuCUMAI1?=
 =?us-ascii?Q?quT8KTnk1bIYUsxnH9mCbtiD7BYJ1/X1tZw6pXSsupmUd834J0MNg+D6fh+8?=
 =?us-ascii?Q?678MpJ/uLn/5FgHiWoiTZlBX3TvpP685kboxsQgj4L1jlZY1+euZN8uYzJcJ?=
 =?us-ascii?Q?LlvqGgZ6zkJqZXLW/q1qn1GcZ6GMZ1PnMeg1pKMOpvN/0ac4tb6LJ/b1Kv3Z?=
 =?us-ascii?Q?3uW58XK4Qx+pPFC7vsRi/Sr4T/cShNMKyTOkWV+8yddcKmMFdQyopLYeC4fg?=
 =?us-ascii?Q?IvzeDyrcpmasKvOmrW02GpWLE1s2+LTq8u7MYEudMp78WHQwSZ+y1lvuZKCd?=
 =?us-ascii?Q?/IMSzdajw9gvJfIaa456vEhVB6bqmac5CDFA9uioYbYaCQuWdsgeXNmHxyu7?=
 =?us-ascii?Q?/YPn8el5mIsQIvhkNhYpGYJJg3YxPSRgCi541tkVfX8lzgsUehKFCMKbTlkC?=
 =?us-ascii?Q?S+QOfJOQLnazzlhXnmpH3crRyg8vOY+Mx9oiWoD3MNh67wwfntHlwzhlz8ZS?=
 =?us-ascii?Q?KZFLLGgim28xSGRiOd0+yJuycns6ok8BIDHzaDsR3k7tvSG2wemsYG2PE2iW?=
 =?us-ascii?Q?h7eY4liQdVmBUQL4GISJPoaWu+QVH5EwR79gAa51wTqkgtU7G6ZFVQwAXgg3?=
 =?us-ascii?Q?mL6Fm9JBPjvfNqFTWjmjMHs/1gkc4BXJmjQH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T4Wjv1+p63p/1KHNkDSFIoI7ZBdM8jL5twxbyCe/AM97UqwiEs4X/3u7k6D3?=
 =?us-ascii?Q?Ha8OyGuoLubJkcU8CTe9i+GbgTd0t+tPrx/Ak0fob9M2pYPHpWHvpjQ19BYI?=
 =?us-ascii?Q?4rsOuvF/dfcvJw235VRXwEgoXp+Tcs+7Bx1vLi9pTY64DrOzZdQNV8j9tUTu?=
 =?us-ascii?Q?whRd+xl3S3C6Uo4dBcPz8fClvLFDvB4l0o/k9v3D3yrBSztdZ1NFn6C78hyV?=
 =?us-ascii?Q?aRq3584yz/ClGb6+8TmzH497rAA3LJTRQT46q79uGb/m+O9TI3zkYPy5zHMk?=
 =?us-ascii?Q?rYx+ot4RWPX95h75IZIiyed4n2IRtQq8SBlSZz8as0NITN9ny/zMynOlxd0D?=
 =?us-ascii?Q?TJTJgIyz164JEIt2e1mkXkiLqtyRI3H9n17ubEFKn9Xvv78QMHcdoIKVwysK?=
 =?us-ascii?Q?R0U6YXRniZS+UqWMevSF4lMNI1xmcRjMU0z67B/O/AXsTU78RPl/zKcPwK0L?=
 =?us-ascii?Q?24BrnON8Hepsjr9gQU2yEGsxBxEziZmE8/6usVTKGTLwZ4dJ5Q6LW4lCsTy3?=
 =?us-ascii?Q?1Y9b7AT42RBSYPt1Hd9NRl0AzhyMxOSydWgwfzvyTEY7GwbBxXdFt6S8RkbT?=
 =?us-ascii?Q?5x9d3Rh5ot1rcVV7u9AjS8xcPM+40o/fd5clJU/V/MUPfL94eHGvOxcYSWkE?=
 =?us-ascii?Q?iSsOZqkpnLVh6h0cM/KaEXNcYUiOF0TYdIyygqgNxE+lUIBZFRJPhkDOt9y8?=
 =?us-ascii?Q?6Sq0JPy7ib7nhw3XUviAK0AbucqyX7Qls6+7HbZsG0bylMW1infpF8piqexJ?=
 =?us-ascii?Q?P9HGbE51zu3BQHI2RQIhXJ+F32kKs/I85yFyOe1v8spZeYd8i20iyiu9OiVR?=
 =?us-ascii?Q?uWhjTA6gdDjJFMM8aSU0EoPNIzyL0j/HfWx2MJUb4fJYwIdDB8k2kWJRHGiq?=
 =?us-ascii?Q?7ZsXbdVw/9YAd4KvRq72pZ/A7wDL1/V0+sIkK+mlOBWp4gyKO1wEuSYCdPpV?=
 =?us-ascii?Q?QWgCFVuY/YLMIPFHFRYmn3Of+IdJkQ4gHSdLRTBjEt09/nPos3BZAiiO4ms+?=
 =?us-ascii?Q?UTf7FdWmyxda8OPZRKft7IS0jdA94naz8iX69bdd7IYdRVTSnPW5zfKKXrmK?=
 =?us-ascii?Q?jUsrQeOyeVylj2coj27Z/UmgZZZGUQ+UH5kvYSjzPqqtugH2EEYVslMcanAZ?=
 =?us-ascii?Q?IMUy+Omyay/BGiYAOshdEvM+SOR9QBb8rhDWCSWaBG9fOY+OqRE6XZl40JTr?=
 =?us-ascii?Q?hNR5PxsTcfCsZ+o1cfv2BXrVdRQqP1WCaCrtYkaEeZQgH2UkmwpzKvWT75jm?=
 =?us-ascii?Q?2HCrLFiJDekAURXTprCXIGtORRy1sidynqjFO77Ek/SN9cMHoMTeJP3GfMS9?=
 =?us-ascii?Q?/aZ0nIULpFSsHP2SVkT2QtS7WGtp6Xg9ULpKqq3zMdJQPgimTCwk+wepIc9F?=
 =?us-ascii?Q?Z51wBqlPo1iESdzabfr+fQxN29yw4e4Kbqh5ejV5qkDZwILImImHx4Mx9JZ2?=
 =?us-ascii?Q?9GqIf9dn2BG/Tc3236KFiQI3gcmBq21nysp9BOjQUhArh7fhxAPahihu3TS/?=
 =?us-ascii?Q?2lK5fbcBAZ7YtrBmSTKGnTLx3YNp1Xb0Pt9qQqNmLF0cHxi+7QnXr7BUU8+t?=
 =?us-ascii?Q?SqpZEIW7nkcA2hT7I+Q3NzrxG2IyemJOCrPonWH7K4ZuZHt0Sr4Hrttubwye?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352248a1-1c7d-4a9b-d5e7-08de203ac2b6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:23:08.8038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHm/o4Hz9N6BsD5K9np7Z3uaoogWhYf/GjGP9cafSdQo+TZjLCHm4C8qztIaQL7bQ9d8RsCYAKhY+XRL2KzRTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10574

From: Ioana Ciornei <ioana.ciornei@nxp.com>

While adding support for 25GbE, it was noticed that the RCCR0 and TTLCR0
registers have different values for this protocol than the 10GbE and
1GbE modes.

Expand the lynx_28g_proto_conf[] array with the expected values for the
currently supported protocols. These were dumped from a live system, and
are the out-of-reset values. It will ensure that the lane is configured
with these values when transitioning from 25GbE back into one of these
modes.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v4: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 9c78f2db631b..0010cfa61e07 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -166,6 +166,18 @@
 #define LNaRECR4_EQ_BIN_DATA			GENMASK(8, 0) /* bit 9 is reserved */
 #define LNaRECR4_EQ_BIN_DATA_SGN		BIT(8)
 
+#define LNaRCCR0(lane)				(0x800 + (lane) * 0x100 + 0x68)
+#define LNaRCCR0_CAL_EN				BIT(31)
+#define LNaRCCR0_MEAS_EN			BIT(30)
+#define LNaRCCR0_CAL_BIN_SEL			BIT(28)
+#define LNaRCCR0_CAL_DC3_DIS			BIT(27)
+#define LNaRCCR0_CAL_DC2_DIS			BIT(26)
+#define LNaRCCR0_CAL_DC1_DIS			BIT(25)
+#define LNaRCCR0_CAL_DC0_DIS			BIT(24)
+#define LNaRCCR0_CAL_AC3_OV_EN			BIT(15)
+#define LNaRCCR0_CAL_AC3_OV			GENMASK(11, 8)
+#define LNaRCCR0_CAL_AC2_OV_EN			BIT(7)
+
 #define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
 #define LNaRSCCR0_SMP_OFF_EN			BIT(31)
 #define LNaRSCCR0_SMP_OFF_OV_EN			BIT(30)
@@ -180,6 +192,15 @@
 #define LNaRSCCR0_SMP_AUTOZ_EG1R		GENMASK(5, 4)
 #define LNaRSCCR0_SMP_AUTOZ_EG1F		GENMASK(1, 0)
 
+#define LNaTTLCR0(lane)				(0x800 + (lane) * 0x100 + 0x80)
+#define LNaTTLCR0_TTL_FLT_SEL			GENMASK(29, 24)
+#define LNaTTLCR0_TTL_SLO_PM_BYP		BIT(22)
+#define LNaTTLCR0_STALL_DET_DIS			BIT(21)
+#define LNaTTLCR0_INACT_MON_DIS			BIT(20)
+#define LNaTTLCR0_CDR_OV			GENMASK(18, 16)
+#define LNaTTLCR0_DATA_IN_SSC			BIT(15)
+#define LNaTTLCR0_CDR_MIN_SMP_ON		GENMASK(1, 0)
+
 #define LNaTCSR0(lane)				(0x800 + (lane) * 0x100 + 0xa0)
 #define LNaTCSR0_SD_STAT_OBS_EN			BIT(31)
 #define LNaTCSR0_SD_LPBK_SEL			GENMASK(29, 28)
@@ -286,6 +307,10 @@ struct lynx_28g_proto_conf {
 	/* LNaRSCCR0 */
 	int smp_autoz_d1r;
 	int smp_autoz_eg1r;
+	/* LNaRCCR0 */
+	int rccr0;
+	/* LNaTTLCR0 */
+	int ttlcr0;
 };
 
 static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
@@ -316,6 +341,9 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
 		.spare_in = 0,
 		.smp_autoz_d1r = 0,
 		.smp_autoz_eg1r = 0,
+		.rccr0 = LNaRCCR0_CAL_EN,
+		.ttlcr0 = LNaTTLCR0_TTL_SLO_PM_BYP |
+			  LNaTTLCR0_DATA_IN_SSC,
 	},
 	[LANE_MODE_USXGMII] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
@@ -344,6 +372,9 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
 		.spare_in = 0,
 		.smp_autoz_d1r = 2,
 		.smp_autoz_eg1r = 0,
+		.rccr0 = LNaRCCR0_CAL_EN,
+		.ttlcr0 = LNaTTLCR0_TTL_SLO_PM_BYP |
+			  LNaTTLCR0_DATA_IN_SSC,
 	},
 	[LANE_MODE_10GBASER] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
@@ -372,6 +403,9 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
 		.spare_in = 0,
 		.smp_autoz_d1r = 2,
 		.smp_autoz_eg1r = 0,
+		.rccr0 = LNaRCCR0_CAL_EN,
+		.ttlcr0 = LNaTTLCR0_TTL_SLO_PM_BYP |
+			  LNaTTLCR0_DATA_IN_SSC,
 	},
 };
 
@@ -829,6 +863,9 @@ static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
 			  FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_EG1R, conf->smp_autoz_eg1r),
 			  LNaRSCCR0_SMP_AUTOZ_D1R |
 			  LNaRSCCR0_SMP_AUTOZ_EG1R);
+
+	lynx_28g_lane_write(lane, LNaRCCR0, conf->rccr0);
+	lynx_28g_lane_write(lane, LNaTTLCR0, conf->ttlcr0);
 }
 
 static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
-- 
2.34.1


