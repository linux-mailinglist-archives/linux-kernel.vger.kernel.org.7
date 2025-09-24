Return-Path: <linux-kernel+bounces-829972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEFCB98584
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6482C1896F97
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E338243371;
	Wed, 24 Sep 2025 06:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="M2DH6KqS"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021132.outbound.protection.outlook.com [40.107.130.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBFF78F51;
	Wed, 24 Sep 2025 06:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693925; cv=fail; b=B3odrctnPcxT0cKI/e40+Bmkp3QpLgH49CuTmzEKA13HTeQgaJfwEl+jep0f3/kWCoY8pjh8ZYOmMw+rw1YObe4eDcoUlgS5G6I6LbtTRJo3VFBNZVWne5idqoN0sIcDaGfXrVk1IOhqBDbjjEH3ugoVNidC7Z9r7whGr2ymJjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693925; c=relaxed/simple;
	bh=3q7iazoUH5B7pPvb9qzEbzg+1j1gCGjC4zJd1aKzgf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IQmK0FdmOP1OSGNGZFMvDvgSfUpcXNZi9NhMvKFBQ2o1SuHlz+W/M375yUINXMQRvShMgF1mApcgVWUzdiNvHM6xX65zdlfoCsFRfTm2tXfI8hYO4j9sAl+A0x/Odzfygk6iDbXYuowXpMTUd0m8bMamtfgsn/YZ181diWKHwvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=M2DH6KqS; arc=fail smtp.client-ip=40.107.130.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cd4n0CtvMplTVpVL972+vpkl00RFg7CXUKTEi/LzokvRFjv2nAF7s8aUsuFC0Tc4ewzpAXTkQ8isLUmOTHTIuwAaquDjxciJWIM3ijJ4fqNp8k7Eu+9ejq5C1tnuyD1og7frnlMcHiV9HCCHPX2ztmjccAIbDl76LhuuGC07MtL8QEfi/X8SUbp4+xcQnN90GFA0XNKDCe6DuZCvqxrtd7nW7NZIythqzrL9FPqlorgWNBcZx0i5q3rPaggTnVYnj/6bHCLSk1nAt9R0CEKFcCEcMuJuck9cCKRqL2S8B7RhtW8+/GulDq02a3G0Z0Y7FQl2xE8vFLUdKfUoDr6Cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYgQ4aFhcSvYGQITjCcxJF80VC371NBb6sHNmyYvQxU=;
 b=dDtTzIqV6pPhEABL21zuZBt8V4ITWIUaFpzNCWf/kFZSMo8qB2qn0C58/iyi5xd+cctBe3Wawkxjq6inokqjqT1IjnESrDH40SXXquD3Z/1HMRzHQLBGv5ol02VGmClMetVpmBC2KDK7eG7zZOnsCgiJiQ01eov8kmBhPl099ZP5DZfqH+2hQnJ3RuDeXqoIW3ujC7E8UBKSlIit6+nOfV5zqD/p1+RISZYGFCfD6lMP2YCpp9u8UIDxFfjHQNebvCdhD7i+NCUBeMwapiANjf+cbRz3+aIeeM7iNrssblJBcNT0caD/xJ7jBnWSBAbdwi3c5MIcIzAfTeJLBgpH2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYgQ4aFhcSvYGQITjCcxJF80VC371NBb6sHNmyYvQxU=;
 b=M2DH6KqSFPOQLi/XTRj/iwxoxDIKNBfhL4JQsrsiDi8oIc/iEsfy7CvVap7HsAo8n0+E1hQsnR1d3p/0icjEtDjVsVlKLaoJ4EAfDdRWxMreRn+lJl6H8MIkkaUKNgq8YhFI9qOwrhCLtfHk6B/lqdMh2TViFO/LWN6o9XEqjRiQQs/R+W0Ddo4ogDWc39IcMRSfhQaCeeV1Mlm3kdLU2iKaL5A7Pb8p5W2jYYgfNay64h6HzisEtqjKZ+G/clkguf2PYQWcjU9uOHvlDDMGt6BPjKuQRiDYrqV13jkl4TVczE4LpCo8NjB/qaBv9uXc+NlSA9URseD8CL5GI0MnMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6080.eurprd08.prod.outlook.com (2603:10a6:102:ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 06:05:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 06:05:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 1/2] dt-bindings: clock: airoha: Add reset support to EN7523 clock binding
Date: Wed, 24 Sep 2025 09:05:08 +0300
Message-ID: <20250924060509.1889131-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0154.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8441f7-3063-42b3-8dbc-08ddfb3056ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xjtz6Nkiqj94amfHDNww4XleUjNsJA+BgN6Z+fVKx7t90P+/vA2NqTt74p4Q?=
 =?us-ascii?Q?u0oGkavQ00TM54HAKfHfGOAesd+BS2aqv6uDBs/2ly63fBWFcphcrL9HXKXo?=
 =?us-ascii?Q?lHWra+UV6Si2n1XB5ywKpKviLS+vFi54iBgE+6Eo83IW0R0hzys79qXwzYaB?=
 =?us-ascii?Q?QpfXPBZAhX8HrIMVD214/NFs2f6/LLeMlRjv2xCSb9J5rbaerxoKigYC/pYg?=
 =?us-ascii?Q?VwFZS3vpLESIVww8dxvqf61G8U5+3aIgxAfepYa09KgFX6h7dk1+njjs1tKO?=
 =?us-ascii?Q?69Vu9C9lHT0tc4n8rFGt0gf/tZ/faOYQlzl/fuy6ABoMyZDi8HEIV+xNZhQN?=
 =?us-ascii?Q?vIjJ6bnSafyB2KKMUowrKBy9Pq9gTS+65z/Fy3Qj1erw8fCAkvCBa58qMU76?=
 =?us-ascii?Q?/oyeD8RYIniSl+N0S3N+NKhPOmkQlWFxB82OTl0mZjHQWLO189Nrjveyh5Nc?=
 =?us-ascii?Q?I5NMJ0hiU385kPkUIWc6NJ815WilaBf3WfO3IhKxYnHkyCppGdhsMA87WvoP?=
 =?us-ascii?Q?Rzda7SlOWYUxX+aRQo59ulDPY0Ul9YK58jWn5UWGq+AR64s0uV7J1U6gq9SK?=
 =?us-ascii?Q?p74EwTR3DwHzRxONHD62S9VRCbNh1YWRycKd//o4SvPQ44NoIB6ZKoul0djR?=
 =?us-ascii?Q?EZFfT7946NJKxHAG4vsLQgprx1SdYZO4YgY6rK+IqxWnJ0ulZBBF77A5MdAy?=
 =?us-ascii?Q?9qcabWggocDXwwJx9H1yCNPmslVKa9EOFdESWlBSVf1mu9ICPvYB0GsgF55s?=
 =?us-ascii?Q?XWgJDRrjzK1xJ7G5mgUUeFfHJHnVmh7GEh3ttQcaOpSiIvIo+TLE8UN2Hp1x?=
 =?us-ascii?Q?IWlyKWyNAd5nNUqNajzhXGfWuOF2vK4n1Qa/+9lTec/OYFari0xLMlR3RfEo?=
 =?us-ascii?Q?F4JKLUaQQ3cABYiXxM0VSbXXfY1B3+aPFmH7M3+vvwTOPzwIDqy+fEKcWqsd?=
 =?us-ascii?Q?wu5YQb1JT3kvEhZ6GpeHKMaSWJY86wSO77l4WjLNeRJKXQAh7uHMLTfeGfIz?=
 =?us-ascii?Q?8IPb21wZp6Armb4K790m4WnIad1HTqabz8G/AYzCAqah7Xl6PUvMQc7vwXjj?=
 =?us-ascii?Q?dJSPe6FTKIU6qxU5xffW+lvvtlFSw3tCDWun05dSxM2IEqPNxbNgFjTHzsn+?=
 =?us-ascii?Q?GJjB7I/qXAS5fVVTKtiNfMS6nT0KBizLCAKQEPoY67v6kMhgREh5gDJP62L+?=
 =?us-ascii?Q?rIUR36JXWzSoO5lpdEnSZB3xwyNqakAcp4U418KaVEtohFOTG36mTSQdfqzT?=
 =?us-ascii?Q?+GsxNcG2zWbxB2F0kfuIeea01qKgwi7QV7VR/A+aSJhh4i53WCCcNHAs4IbJ?=
 =?us-ascii?Q?lKprBacbZ5tYwzlwtgxa2DcoLCdhrt4oJzGjRmTI1vlSXBeq8B+H1clFkXOr?=
 =?us-ascii?Q?zAcwHNMP8x+YHbdQ0H9R0ZVOkfrhBhVSPTP+rIRE3hfWUCGzL093/tdPdIV3?=
 =?us-ascii?Q?HnwE031+Gqqm5/Clm4kLhZ0k/NjCIzhxBitUPmDdlWEGZs9MUUvik5QVazaz?=
 =?us-ascii?Q?QxA1/J2lEGXicxI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I9ewawzhCCsf3V+Lgbeu1++gnkjbhi2CVrlWOiArcOqmf1YZ5pij/rm4JNaE?=
 =?us-ascii?Q?PDUOvM91YqpNpacb8h52x9emEyNvoWdCDQQNtL1U9I3vcpPRj1yCGxHBWoEp?=
 =?us-ascii?Q?P6kRQ6ENPYlOjZ52xvSDNVk/XkID3gzfIdlDhKCBpwea3IxjDWh7XE7NEts4?=
 =?us-ascii?Q?y8mgXs8iSGsONiooY/u0IhPodVWxxLEIpDOBv5XGHQKqwWOPwG4DIM6V0NQy?=
 =?us-ascii?Q?bRMgrz1ODYoPubaQUMccPRUKcQsOxX/G14Nqe4z5xBzMplIbV1l+Vbh2Nx4B?=
 =?us-ascii?Q?eTrxIQsd/E5bWd9oHnAXWW4ADkv0nTd9LT7R8xM29DKzKZV9S0ggiuV74ewC?=
 =?us-ascii?Q?TYwLNc74D10YR9TABmoRD8r4DOT5EzpVHDO3JH7KEL5XQszO76OR3e2iIXls?=
 =?us-ascii?Q?IYgcKcyrbGcIVHfNnrFuuRnubK2HuySH7NpCuUETCEqvERHe3JesopunpRjM?=
 =?us-ascii?Q?QRWA38rcXGStxKlNJIaiNMcLmiIccYeZ2YRg4DKzwfL9S0yzJrtSuEL2y9nB?=
 =?us-ascii?Q?lmpoIXN1a+y8CL2ZXQOsJANJM+meFgrpzwmZmvpuaTYtxs7kYPStOUkjUde3?=
 =?us-ascii?Q?/z3twmTzeik39C5bv9RimhZMwPJneGLSb1WBbsU53kw+zSsqyk6TvmYPzxTK?=
 =?us-ascii?Q?bo4WmJnf2gWG01pjbHLKBhlpAI3O9ewuW9PPKCK9s/qMlSxmPmBgyDaVIp8f?=
 =?us-ascii?Q?GKmexERdqmSJkzosBh3+oyxHHgNOOWZ1FXQElg4YZHqtAqzhe0o/Bn8fAXsn?=
 =?us-ascii?Q?ufIWq7ibFYhJObb/P8Hvw+TN27BWSFfiPCKP9hgHfWabs9TUyYXpIy3QQ0RD?=
 =?us-ascii?Q?Kiq46wAje9mrjUMAYxfffhkrZVacuF+T0RyiLRAvgZNIoZyVttppeKwtue9a?=
 =?us-ascii?Q?9uSiRK8cCXN+iApLTjd3JEq5nt0Vb/zyYWCm00qcBNQ2sxNGIKlPTUTqZN41?=
 =?us-ascii?Q?VQF6hSL8c4Ac4ptzOR9D5dey+CwQ9eEmq8j9nG5S5E4UKsFflc6zmzK1mxa0?=
 =?us-ascii?Q?Rzo2uRlrC097kOaQyVt2abRVjGfKT+04bWSsWdET4aC0CropGCnrCXOk5Wuw?=
 =?us-ascii?Q?X0euUDBgiaEUtHt6Ldembb/mDZuyYbF6dqJxhOYYXNlL2DrF3xHUdKevHJcc?=
 =?us-ascii?Q?mS8cdrtQyeRXTHyI+NBSL9u6HvNHB1xtSFH88B6DOW4ktLYFXqzt39imCeWd?=
 =?us-ascii?Q?iso+LcXJnoFC/OAg037Jt6dAtXhS4hUql0c65SD/OLuT7qFF4tk84loeqF2m?=
 =?us-ascii?Q?cjbtAvxDLaA5pDIoPsgRkhiNVPFFluWNP1pgUmgMslyRU/6dr1fLDf4luS1I?=
 =?us-ascii?Q?oY+wa0BtmRQMi/DItQ7F6gLGZj1Kc40vqQ7FRvlpCusTl82LpPWeVVUJYETU?=
 =?us-ascii?Q?rzPN2pRL4ttB2zlam/tkcNxYYXKLmRVShrIgIIxSpr2h5Qmm+Pzp+u9Z66uq?=
 =?us-ascii?Q?kI6AGvBhGltLroigHEi6LYfi34AWlWkB/fkZ1yqJ1SyZiP6S2bZ2LHEIYbnr?=
 =?us-ascii?Q?Tk1TIX6jJO1qN3kOdE1YhxLCFix9J1KBehSpC0kN3IUc2cknbw3hOtsacZQh?=
 =?us-ascii?Q?NgG6IclnCYElBzdgc30tafWgBOwyL7yUqCkTc/sKQVW7vfYqhW31cGUVYyVW?=
 =?us-ascii?Q?2JTYffanPq4JiT+xmi5Wqh4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8441f7-3063-42b3-8dbc-08ddfb3056ce
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 06:05:19.2484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sL9h39Hk+EpflFpp1yXGa14xLn1cmecvhPzoFTOcAGJsaTkcYFQXoWOzyPCh3nfvzJHtajHpZXFnYzlbVpdYKMBV99T2Oz7y8lDud8QP8sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6080

Introduce reset capability to EN7523 device-tree clock binding
documentation. Also this patch makes mandatory '#reset-cells'
property for EN7523 SoC dts.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 .../bindings/clock/airoha,en7523-scu.yaml     |  4 +-
 .../dt-bindings/reset/airoha,en7523-reset.h   | 61 +++++++++++++++++++
 2 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h

diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
index fe2c5c1baf43..a0df16485300 100644
--- a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
+++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
@@ -53,6 +53,7 @@ required:
   - compatible
   - reg
   - '#clock-cells'
+  - '#reset-cells'
 
 allOf:
   - if:
@@ -64,8 +65,6 @@ allOf:
         reg:
           minItems: 2
 
-        '#reset-cells': false
-
   - if:
       properties:
         compatible:
@@ -85,6 +84,7 @@ examples:
       reg = <0x1fa20000 0x400>,
             <0x1fb00000 0x1000>;
       #clock-cells = <1>;
+      #reset-cells = <1>;
     };
 
   - |
diff --git a/include/dt-bindings/reset/airoha,en7523-reset.h b/include/dt-bindings/reset/airoha,en7523-reset.h
new file mode 100644
index 000000000000..211e8a23a21c
--- /dev/null
+++ b/include/dt-bindings/reset/airoha,en7523-reset.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 iopsys Software Solutions AB.
+ * Copyright (C) 2025 Genexis AB.
+ *
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ *
+ * based on
+ *   include/dt-bindings/reset/airoha,en7581-reset.h
+ * by Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#ifndef __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_
+#define __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_
+
+/* RST_CTRL2 */
+#define EN7523_XPON_PHY_RST		 0
+#define EN7523_XSI_MAC_RST		 1
+#define EN7523_XSI_PHY_RST		 2
+#define EN7523_NPU_RST			 3
+#define EN7523_I2S_RST			 4
+#define EN7523_TRNG_RST			 5
+#define EN7523_TRNG_MSTART_RST		 6
+#define EN7523_DUAL_HSI0_RST		 7
+#define EN7523_DUAL_HSI1_RST		 8
+#define EN7523_HSI_RST			 9
+#define EN7523_DUAL_HSI0_MAC_RST	10
+#define EN7523_DUAL_HSI1_MAC_RST	11
+#define EN7523_HSI_MAC_RST		12
+#define EN7523_WDMA_RST			13
+#define EN7523_WOE0_RST			14
+#define EN7523_WOE1_RST			15
+#define EN7523_HSDMA_RST		16
+#define EN7523_I2C2RBUS_RST		17
+#define EN7523_TDMA_RST			18
+/* RST_CTRL1 */
+#define EN7523_PCM1_ZSI_ISI_RST		19
+#define EN7523_FE_PDMA_RST		20
+#define EN7523_FE_QDMA_RST		21
+#define EN7523_PCM_SPIWP_RST		22
+#define EN7523_CRYPTO_RST		23
+#define EN7523_TIMER_RST		24
+#define EN7523_PCM1_RST			25
+#define EN7523_UART_RST			26
+#define EN7523_GPIO_RST			27
+#define EN7523_GDMA_RST			28
+#define EN7523_I2C_MASTER_RST		29
+#define EN7523_PCM2_ZSI_ISI_RST		30
+#define EN7523_SFC_RST			31
+#define EN7523_UART2_RST		32
+#define EN7523_GDMP_RST			33
+#define EN7523_FE_RST			34
+#define EN7523_USB_HOST_P0_RST		35
+#define EN7523_GSW_RST			36
+#define EN7523_SFC2_PCM_RST		37
+#define EN7523_PCIE0_RST		38
+#define EN7523_PCIE1_RST		39
+#define EN7523_PCIE_HB_RST		40
+#define EN7523_XPON_MAC_RST		41
+
+#endif /* __DT_BINDINGS_RESET_CONTROLLER_AIROHA_EN7523_H_ */
-- 
2.51.0


