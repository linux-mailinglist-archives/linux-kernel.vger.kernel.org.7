Return-Path: <linux-kernel+bounces-818773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2413EB59649
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17C11BC0B81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687862D7803;
	Tue, 16 Sep 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="R4HKNQqD"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522F25C70C;
	Tue, 16 Sep 2025 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026008; cv=fail; b=KZz858AQbe8PF069eJTVvEHsDLTOT5itAvSRk6tB2Pli+tleiZ0IQChdHfjs59+xnkSFIUebQ02wLk5CJQ2D/UpANcMERXfeqSprXiDG0F4xXfy02H4rxJ+Pk7M49EF2pDT+jcCv6kePz7FYwmxuNFFJFbdM2qiz/5hn89MbBuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026008; c=relaxed/simple;
	bh=UOe4TKFrYg1qV2/Jp6FvsHmfHJe56nLOe8WAh0Ni2Dk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hXz///1moE8HPJ3tIa6K9KGLZpNeazlqeiK7m6Nfgf8OeOzV4WxRr+Wm2bHjoHihWSBQsotZvYmK9i+Et8WNeVPamFsiYhh3YNRSCzLubieIBoZ2iEMm/YsC2pRrH1E/Vq8RvGygX1qG38smFvWdHY5DHksSX85o3dGcRWc+tus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=R4HKNQqD; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GC9I5F002720;
	Tue, 16 Sep 2025 14:33:04 +0200
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 495kjns805-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 14:33:03 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rE6Lj0s0z3CD1rbLKrW+/Tr2FyPvZnGCBGn9DX0Ovbuv52u0Wpoi1lqlJnU4SzoLl/L0Ysh/AYZ/62Bb5z6Jl6tUJbNTSXaYaDmIUmC5U9YlLJ3P+iinjuI68PhBT9g+F6cUztMyIm3Snyny70RaiNqPC0ScnUltYPAJqgV2e8p6N5ACJq9DI3J1MjQtiZNx8hktPUmVevw4yVzmb9nACRupHkYSUyifDEWR2g+BEypHtwd3ViWWqbET0aoEMyxPa6/i4EsSI1mbypWQWKY/oftorm+ByLCHh+KC83NpYXynrbI1Ls74Zbxm9fDrvmO6KUA+/hjWJD3qii4UQN14PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrG+bS1MWAaJcpyX2r0YtsEdWkvLlIftr4HaQsunZPE=;
 b=lCQlDJWNOkZvTvGOulF6tr8RDJoeWH1vXQFh20Z/TlNz+W+Kk1K9DvIT5w1Ij8l5Qh/J07LZIDT1YIBJZw5KUfmnasB0zhf1i3C/sIwj5PgL8zKceuR9Ejz6XD/Cl2Jvpw9EKEzptvOW/WBMGTfe5h8Rpl96Vct2jdcrx84T6hyDMkw5Hc3bbP65CEYvKT8cpE4H3SD0UvMe+swfk7MCQJJsVVd1D8BctCZrprU2wyboygvQzjkuCJIhADkEFKjvasy6LPoluib4kpsxXxV/Qy0hk3lCXRPm5WVGdFlZ7Xrtxrm+BKQ3BH8q7By73ZbkoxEBCBozL5SXJ8yg0sxb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=renesas.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrG+bS1MWAaJcpyX2r0YtsEdWkvLlIftr4HaQsunZPE=;
 b=R4HKNQqD86Ij2hGHu9LZs+4Ci5Wt2UDA02FLzxxLBTXqxTkCbAJ1xbKfQ7HX5mbJ3yH/oiE2ouJW0vEYjYB+8eYYWSVfXn+wkyPniIqiQ5SQ5j+mbDRmJG8i3jNmdsYqZcaNrP2NEkdcxz8sQA+hNJj1l/rH7/DIw+4H6R5VMJ4MXOH4cMsFXePeDB3kzKcTVCSX0Kpt88788Dphkmn7sDLkYbDIhyHGWox39Uf7llxQo2nA0r9WxJ+xAvfWSh5jPgv40kqmMYFmfRUYYlLAxuCKZjq+/2TBEe+8wwK5YLq1R3bSXnaqoavWMSlfwjTGs021e/VyOLVm+HVBFFWF4g==
Received: from DB7PR03CA0080.eurprd03.prod.outlook.com (2603:10a6:10:72::21)
 by DU0PR10MB5194.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:346::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 12:33:01 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:72:cafe::90) by DB7PR03CA0080.outlook.office365.com
 (2603:10a6:10:72::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 12:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 12:33:01 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 16 Sep
 2025 14:25:56 +0200
Received: from localhost (10.252.10.12) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 16 Sep
 2025 14:33:00 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: <kuninori.morimoto.gx@renesas.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Mark
 Brown" <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai
	<tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>
CC: <linux-sound@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: stm32: sai: manage context in set_sysclk callback
Date: Tue, 16 Sep 2025 14:31:18 +0200
Message-ID: <20250916123118.84175-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885E:EE_|DU0PR10MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d06d78-6ee7-4faf-90ad-08ddf51d2d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NqCpDxDtMgbs+oRJRYZNu5mi/gSfTpWSrqOdTy+kyUXjywzCjU3T2nS0W/ne?=
 =?us-ascii?Q?IkZVZJcMCm+/YdWO1qVuwE3BCVs6iQ86osnrVrAs1JONqj0zs1DB4reEeomQ?=
 =?us-ascii?Q?u/ykv+OQImjL7gr5XoGyQlSpXAEhlKKBFV/YXoE7HF0PLUJFWM8zsMe2Ndox?=
 =?us-ascii?Q?A79SR6Bav2cYLhxyh0U6grUBKUNfSqYwnn/M5RDcHBkXS7J95T6Jrxq4fqa/?=
 =?us-ascii?Q?ZG+QkF4Q57mSfSVtuTlNjiUXEBm1sLZPg8k9j6JeXiEyFfopSop0rX9mCYjj?=
 =?us-ascii?Q?pVj+dISYrecMDm0T1dp9mfs1vedmaOrAGjffL23fXC2t7wnRjMAbesmPl2Ve?=
 =?us-ascii?Q?6esuGxdePPK1zP81F3aXyC+NnSG2F2FlcbtzzWXtb6WsuFIwbzraO+YyxnUf?=
 =?us-ascii?Q?uJMMKMbC/oHLsTL1LtNbRLvrpubrCfGc9qVkd7HV+2jFJ/+cssE2+iEMj56p?=
 =?us-ascii?Q?STphrIvni6OWcviHbYU1LjqA7xU00RuNug2BcBkObhWOHueg7ww0SipsLUA1?=
 =?us-ascii?Q?hWwNSBIz6mmDJiYgOrRYZB35EZJhJntHzj5h0oEOl36UqYcRbAtLUWE28M+o?=
 =?us-ascii?Q?1mKCK9VnRKAWtZ2rK9pueoTOfL/REC5kwLsIurcza5V52lLjzXsKyOIOReph?=
 =?us-ascii?Q?QDmCXQHzbqfyBuO9siVWMR7b10WQCkR4p9pTItBQAQH2urqsU0rglccZa9fI?=
 =?us-ascii?Q?lvz6tftd0SV/cmxEHWdEK2RWInGbu3Dg/ZuvNqmYPg7DEBkrIEyhd0WGmQAY?=
 =?us-ascii?Q?nJUz8oDxBHeuy7U4WuBbe1J0hH5aoGQn61klNCJ4L5A3kAe3rWnD0668zVcI?=
 =?us-ascii?Q?iAqgfK1VQRRII2AWr6O20Et6CFvpTF36n16kB3mQmsFpI1GdpJhvZYPxsrGd?=
 =?us-ascii?Q?uV/kFY7Dn8KxOjxiAmFzApvkZwTHE/RY2fUejutiW0q7o3FQxCr0w73hL+LV?=
 =?us-ascii?Q?g1PaEdUOOAU2IHHHPoByf/Fzg5J4S1sDTVoyubti/Z6c3+4Pdx0IKUUiiyId?=
 =?us-ascii?Q?K4MX/28C1tafNzlpHUfl1q96gC7bGXDbLexoeIfoW3Y68dnTHh/d+RZKP/oN?=
 =?us-ascii?Q?SxzkMlq36LFpyw1dvFhivL6vbV0JrJWBfbp5BI+qOTIANGRINoLZpMvkDpdb?=
 =?us-ascii?Q?AMqSxQ1s1OdysOFZy06CX9s0m4zYwAG/O7SbXR/uPRtqDvkdDgAiGWDR3X8A?=
 =?us-ascii?Q?jAiTK8yjcd8jym3tNFtAn72jjsk+4aG7F8/LpnBfDErFP5HhGY9RB66jFUwt?=
 =?us-ascii?Q?qS2IKCPagRnIyTIH2/LH2Jig95cCRAToYOqtw5j/O6UiAyFm1b/zq2AdD86A?=
 =?us-ascii?Q?0LBfbS4RDgIJcQ8dPYteAz7GFwt6i1LYi3YyXBYLUEx0RgE3GpxPnNhECGrO?=
 =?us-ascii?Q?qgIaXj6fjLn+9mpixwNPJYhhE5tXoztYVDxIZ3px2E50Wt6VNsm007M4txnx?=
 =?us-ascii?Q?zbYdft3gvswe7ttEy+vjnzb1N6k5Y3A3qQylQ9BLmbv8cwUZky5ied32IS6r?=
 =?us-ascii?Q?1d95zpfwu/WxZ6f/1SiJQLxDujWnc4SdKvXt?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 12:33:01.4541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d06d78-6ee7-4faf-90ad-08ddf51d2d15
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5194
X-Authority-Analysis: v=2.4 cv=ObaYDgTY c=1 sm=1 tr=0 ts=68c958ff cx=c_pps a=rpDra4TIJV0i4HlMjvoxBg==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=8KI1uNhz6KsA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8 a=ZX3i2W64EGGOe3iA3tMA:9 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: Ea0aH1oXILXktavvW65pdVgWJg15KFQg
X-Proofpoint-ORIG-GUID: Ea0aH1oXILXktavvW65pdVgWJg15KFQg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE0MDAwNSBTYWx0ZWRfXw1iDkRDUVND9 E6gKJfz3cle5Mna7yAhGvfe3Cd5xd6bxlL56HolGpJvw7ILVr5LoOlko9wxUAWS8c9pnKuCMrju k8fExN58ZfUEBYMDGaQ3KYU09Mw1jDnfPMNERV4FZ0X3YTzx5dL2lirEkQ1ekIlroCr0e9d1LB/
 Pc+26nHocaVlTpw1bKgqW/+XRdhVZU54dQ3DtLqzzzopVD4CwyXwPnnu//UR7Ij08izHYJ0CrwU lncWwHBIsDILAp8bDk+NAGISOu9HLnIu1G5G4oZxZpH21HUWrEtm3ggnZmzkyto18+SL3wrqtfl Nw9xqSUOW3gdAyZ35HUHoZZCv93likFqDItjueYVuuNGFzZtNATgucG6ojE7i0dDh6IJ0xZ83Bl 4PI0C5RB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509140005

The mclk direction now needs to be specified in endpoint node with
"system-clock-direction-out" property. However some calls to the
set_sysclk callback, related to CPU DAI clock, result in unbalanced
calls to clock API.
The set_sysclk callback in STM32 SAI driver is intended only for mclk
management. So it is relevant to ensure that calls to set_sysclk are
related to mclk only.
Since the master clock is handled only at runtime, skip the calls to
set_sysclk in the initialization phase.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

---

Here is feedback regarding commit 5725bce709db1c001140d79398581e067e28c031
ASoC: simple-card-utils: Unify clock direction by clk_direction

I have observed some impacts on the STM32 SAI driver behavior.

To accommodate the change introduced by this commit, I added the property
"system-clock-direction-out" in the SAI device tree node.
The SAI nodes typically look as follows:

&sai2 {
	sai2a: audio-controller@4400b004 {
		#clock-cells = <0>;
		clocks = <&rcc SAI2_K>;
		clock-names = "sai_ck";
		status = "okay";

		sai2a_port: port {
			sai2a_endpoint: endpoint {
				mclk-fs = <256>;
				system-clock-direction-out;
			};
		};
	};
};
However, I noticed a change in the driver behavior:

* Before the change:
- Initialization:
simple_init_dai() -> set_sysclk(id=0, freq=sai_ck freq, dir=out)
	Calls clk_set_rate_exclusive()
simple_util_shutdown() -> set_sysclk(id=0, freq=0, dir=out)
	Calls clk_rate_exclusive_put() (releases the mclk clock)

Comments:
At initialization, the mclk rate is set with the kernel clock frequency.

- Runtime:
simple_util_hw_params() -> set_sysclk(id=0, freq=mclk freq, dir=out)

Comments:
At runtime, the mclk rate is set with the mclk clock frequency.

* After the change:
- Initialization:
simple_init_dai() -> set_sysclk(id=0, freq=sai_ck freq, dir=out)
	Calls clk_set_rate_exclusive()
simple_util_shutdown() -> set_sysclk(id=0, freq=0, dir=in)
	clk_rate_exclusive_put() NOT called (mclk clock is not released)

Comments:
The set_sysclk() is called with input direction, resulting in unbalanced
calls. This seems to be an unexpected behavior.

- Runtime:
simple_util_hw_params() -> set_sysclk(id=0, freq=mclk freq, dir=out)

This incorrect behavior made me realize that set_sysclk should not be
called when the frequency corresponds to the kernel clock frequency.
Here, the SAI driver needs a way to discriminate between the kernel clock
and the master clock.

I identified the following possibilities to achieve this:

- Check execution context:
Assuming the requested frequency is correct for mclk at runtime,
the execution context may be used as a discriminator.
The snd_soc_dai_stream_active() or snd_soc_card_is_instantiated() functions
can help determine the execution context.
For example, the following check can be added in STM32 SAI set_sysclk:

if (!snd_soc_card_is_instantiated(cpu_dai->component->card))
    return 0;

This approach fixes the issue but looks more like a workaround.

- Check clock direction:
I expected the kernel clock to remain tagged as an input clock.
I am not sure what the correct behavior is yet.
This may have been a way to differentiate clocks in this particular case,
but I don't think it is a robust method anyway.

- Check clk_id:
This seems the most relevant way to identify clocks.
However, clk_id is still set to 0 in simple card set_sysclk calls,
So, it does not seem to be a valid option at this time.
---
 sound/soc/stm/stm32_sai_sub.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 463a2b7d023b..0ae1eae2a59e 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -672,6 +672,14 @@ static int stm32_sai_set_sysclk(struct snd_soc_dai *cpu_dai,
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	int ret;
 
+	/*
+	 * The mclk rate is determined at runtime from the audio stream rate.
+	 * Skip calls to the set_sysclk callback that are not relevant during the
+	 * initialization phase.
+	 */
+	if (!snd_soc_card_is_instantiated(cpu_dai->component->card))
+		return 0;
+
 	if (dir == SND_SOC_CLOCK_OUT && sai->sai_mclk) {
 		ret = stm32_sai_sub_reg_up(sai, STM_SAI_CR1_REGX,
 					   SAI_XCR1_NODIV,
-- 
2.25.1


