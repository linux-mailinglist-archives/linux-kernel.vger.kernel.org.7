Return-Path: <linux-kernel+bounces-827795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F10B93056
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA311907FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262572F0C5C;
	Mon, 22 Sep 2025 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="aun41yaW"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020098.outbound.protection.outlook.com [52.101.193.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC92F0C52
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570171; cv=fail; b=AK/Q74nf4LaSQDnSmS9z3yD4zGs22ov0pXvM1Y7lZMHyD/V11qLVoMV/WCakuTrA3rzDSowCDIRj7ulizjPRacN7ZoE+Fxp1F6vlOw8Tdu++pHiHyWQ8j18ZKfbG5q0BBRw2WUEIcw8kcJwc8AJfvLQjXHW9h61FjJ1n/FR/48c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570171; c=relaxed/simple;
	bh=q6QMAhvnQTqkjMTORbmLfUZt90r1lfoIAMtPzOL8pek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KEDE8zpQxRaENepOcIM0ZyNUluX65/rQzwVkZGyvLa5vYkiVbMn0ov/uwXX9LH66eDu6/7Y5xUheAf7mb4gLtBAHAqqr6MtMxrWGCj2y7gtJz6W0ugent38E/+WO4cRn1qEgQZXMpnRthpo7ymcVQtAxiFNFPkPN+qDJuNUH/ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=aun41yaW; arc=fail smtp.client-ip=52.101.193.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9z21YX0uiYP7MMCLaQ7+o685Gp5AWRIQ3AKaoiAVtMw7iCnzrxIx8gppCwHVuxUJCLARUp0pdougz8ei49nfy/56Sg3druMA/qiD1ip1I3A6AkOQsrD2K4dHjhrAuOcrOE9NrGlNxY330FMadj8ejas/SWQVbuGP/3M72KlGswyLgETkdTPzgyz73syHurqKcjmioIAcOzY7M3e+z3RCxrJX6iHp01s+Q1m47uKNaawZ0gUnZNZ6Np08HiOqzfShAlehld4PO/A0MABz7nLo3knJxeNPwk1e80ZP9ss9yhbnV9XphQZxxx4MreGCwosbbptRFDZBBX3S/j4hxiSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ziW/p4qd4Qv7eFFz2L6cGFdfCoXMjbcbUbODArycOc=;
 b=o8bpGcQQ7jDFozuTpAe1bdUaVHziXA5k8VJlBpxXUghQoylh7enk0jcJguJhL22SLfCIb8oWb+bkj2bfG2nRCfRBnrJi2L2WzGbSQhp6JxCsXxHx31Z+ILmFFFXxebcx+o+XKbkNJTpMFIHTfUWtqwbVg2ZgI7MzU4wqlw+p8S4CfRfQuliEKNxSJjd8MkjPr2xThMxcvB6HkdXCEb9clT/fKBrRNEVH9+/I07aCjdZehl2VXSrlu+8Q4oPQiZbYdRL/AaJhyjWf1WcZNQDNTbU9Dj23NtQQbBBogVOIbbuULNuOXEULwqjSJK7aPJMXt2o0otMF1hnPaziQ9inPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.233.182.194) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ziW/p4qd4Qv7eFFz2L6cGFdfCoXMjbcbUbODArycOc=;
 b=aun41yaWsUR6AMkp4SdHPLzFVFJ2cbTOvOaYEsL5kJyt20NAGR97OfJOl6P1hL3bGxasNtTYJIh2blgnJFmGMOei6coI4DyrR0dUroQvvQwmwtCu6gZJg+N9YAE0oYa9NlPiXua/2WCrrEqWBd+yC+A2gsOrSh675Uk9nZilr5ANghlQzXLdcUlLF0+OztnddmKzvvH+VUYib6HKymrFmNlP9WRhs1gwb7uuoqDGuaoxn9ejbkhHW6azbSULPbT9WieDAXKjdfS31TJChUwfxJIcyizvCE3YAIvlKRn9LJDARkbjejDFcXLvsRADFZ5ChA9MAWf/KPBT9wlUPuYb0A==
Received: from SJ0PR13CA0238.namprd13.prod.outlook.com (2603:10b6:a03:2c1::33)
 by BN9PR18MB4377.namprd18.prod.outlook.com (2603:10b6:408:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 19:42:46 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::e4) by SJ0PR13CA0238.outlook.office365.com
 (2603:10b6:a03:2c1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 19:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.233.182.194)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 50.233.182.194 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.233.182.194; helo=[127.0.1.1];
Received: from [127.0.1.1] (50.233.182.194) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Mon, 22 Sep 2025 19:42:45 +0000
From: Prasad Bolisetty <pbolisetty@axiado.com>
Date: Mon, 22 Sep 2025 12:42:40 -0700
Subject: [PATCH] MAINTAINERS: Update Axiado reviewer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-update-axiado-maitainer-list-v1-1-b51db97d8d44@axiado.com>
X-B4-Tracking: v=1; b=H4sIAK+m0WgC/x3MQQqEMAwF0KtI1gZqQbFeZZhFmEb9oFXaOgji3
 S0u3+ZdlDRCEw3VRVH/SNhCQVNX9JslTMrwxWSNbY1rHB+7l6wsJ8RvvAqyIGjkBSmzcWKlVd+
 7zlAp9qgjzrf/fO/7AQLBiSBuAAAA
X-Change-ID: 20250919-update-axiado-maitainer-list-09a2a5ed8960
To: linux-kernel@vger.kernel.org
Cc: Prasad Bolisetty <pbolisetty@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=pbolisetty@axiado.com;
 h=from:subject:message-id; bh=q6QMAhvnQTqkjMTORbmLfUZt90r1lfoIAMtPzOL8pek=;
 b=owEB7QES/pANAwAKAfTtyq8jdb2mAcsmYgBo0aa1zoyLNnIh8J+IM7M8IIL+BCEpIWR1rdLNc
 fTH/cNNI8aJAbMEAAEKAB0WIQQyoD/pLptew0QvrhT07cqvI3W9pgUCaNGmtQAKCRD07cqvI3W9
 pjOTC/9omK58lWJGgGsfRhJ45hn2gEvQY1qCGfgqYKBO6/IG9oO91TeOBjO8xvFsiyhUdc7q74s
 7LOf7xU2RdaQ8x1+nn2akw9DLn/hyccnQTVKaY8eNbhZ5v617ZYsfyAOnlH9YhWR3N0Gk1GAEpJ
 jSq3PjvIZv3TT35QV3jQJszWZ6b/XN9QVuiiu7Rq5wsMW3LzmZWEz2CccElSbaS9Dubgk9s1Eft
 lhs4Ql/REa+/WbnfNb9wtdUAV3poGYQz0IR8gN+0gvaPr0qWRgE8n0mSw5J/xMnWjnWa+YXTDzA
 HxWZ7+C7uw8CQYqHbJAqi1h3/LpP2Bwn0W8hgdVOgiykcmf5Ih3zu28MOkjffEtRgYez2rAw9RF
 INEteThNpx9xeZXL2Dfn0Z7GEY+iET4/pECEMuHdQtEYCoYinAXz7Bul6pvE+HyLtONeIopkEW+
 N5O/i0hDpbKevxc/rgALRv8eM6ALWEqAsmlTTEhgQn7c3zwcqMbY9lIj2sSXyP7E3pado=
X-Developer-Key: i=pbolisetty@axiado.com; a=openpgp;
 fpr=32A03FE92E9B5EC3442FAE14F4EDCAAF2375BDA6
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|BN9PR18MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: df58a3b0-9128-4173-e3a8-08ddfa103430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUlRbEU0eGE3cVFLZVBodXlHM2g1OTlOSkx4R0kvZVFzaVJzenhmbFJObDFM?=
 =?utf-8?B?NjJ1YjRkbmhFbFY2RzlCd2NXNFNIalU5VGhETGE0ZG1yUzFSRGtoV1MvMUdx?=
 =?utf-8?B?VHpSUndWVS92UWEzbS94ZUhQcHlFVFZHWTVOL3dHNUFmSVltUWs5N0dIT1Rw?=
 =?utf-8?B?RkU5RE9DOC9JK0VTOWZ3djRZbkx2NFhTVDhxaUpHSDlmRzN4MlE3R1UyNjFj?=
 =?utf-8?B?bTlQTkt2U0ZFbExDRXZRMVp1eVVRT1JKbTAwdnphQ041a0R6MDNFdDFyUjc2?=
 =?utf-8?B?ckQxc0FjSEY4SmZieXFIS3JicStMcC9IN1dPdzhLMDhwc1dhclZXR25vaDU2?=
 =?utf-8?B?Y3pWUzdNSTJsN2tOR2d2bzZ0SXhnUzVtYmw1dE9JQXU5bzhpckhZcmx0N3F6?=
 =?utf-8?B?SWFwRGIrN1VXeW1sN201OC9HeDZ5Z1RTc2t1OFphcmpKSjR1L0NPU0xrUHds?=
 =?utf-8?B?RDkyVSttZlVEUEg3N0dHZUl4VklCN09iZ285ZTB3MlhuakhqaDM4aEt3V082?=
 =?utf-8?B?VTF0OThZekRFblF3d0g1WnJXSUZXSUxNdWlGdjM0ai9iNFhBbG0vNEZ2cE8w?=
 =?utf-8?B?Zy9MeGtZNUZYZ1hhS0VOL01EYkFQL0pFcGlLSDltS0h4dmwxS1p6cmRVZkdv?=
 =?utf-8?B?REd6ckVjTi9TK1Q3TkkrWThOR2tndlJvcms5ck42SjFNTlhiSjVCSnAwZkVr?=
 =?utf-8?B?dzFDODYxaGQ5L0JGMVNqc1R3WTJ5RktaaG5lK2I2QzBXbjF6eWV0b2pXYnlG?=
 =?utf-8?B?czlUS09nTnE3ZG1TUENWcElxdTd6R2NkUUhIa1cvZkJkc1dzRUFnRnZGK0Rt?=
 =?utf-8?B?aGluZ3l3dGJDL2UySXdORVN0TVpxSlZkNFVFRW9KWVB2emE3YkdNcVZLSGpU?=
 =?utf-8?B?Y0FPUTFvN0FnWFFHVHk2aHZGWHJRNktOOGl6bVUwQ1dSTFlhUUVabWp5R1VY?=
 =?utf-8?B?V0FVek44YmQ5N0pmRDhqdWQvMnVoREtJc3hGdHJuMkVQSUs4VU1BOCtNMWZz?=
 =?utf-8?B?aXVKdmNXMGE4Zi9XQ2NVY1hTWVBXNjM1bXZ4S1M4S0hNdXJyaXh2MTZJZ0JN?=
 =?utf-8?B?dHFINjhSNUhKQXBaSktSaEQyQmtDS1lwS2JBTjdDNzNVZDdXRXBVSmFoU0JG?=
 =?utf-8?B?UG5DdkI3aXdXNDNObmJsN1BqU0RrU0NvRkhsRXZITWhRUFRDU2VJS0N4NnZE?=
 =?utf-8?B?SVFhMFpSSGhmVDc3L25zbmJYcmVQZWZ3MUJ2K0ZEYndDdllobHRBYmY2ZjM3?=
 =?utf-8?B?WmRRWmtIOWd3U1Fmem5rOXlRMXoreUhFYit0SWpQcU5zR3UwTkZZb0hzSXpF?=
 =?utf-8?B?ZXRWMmFRUmp3RUhadjlhQ1RHWWszS0lkeVpXOE5kVU5RM0VrcmJmMURvMnQ5?=
 =?utf-8?B?RkpaRjY0NExIV0FOWGZNK1VZYnFZdjhsQmFyK2F4TG5WYkdETkFsMnl5SDYv?=
 =?utf-8?B?M2Q2TU14V2g2aWRXdDNaalQ3VVgza3NtSENzeFlOTjF0djJHZEl2QVg2V08y?=
 =?utf-8?B?bFNwWmNJT1gvdnVUY1NPUU5RaEQvU2t2TDJqM0JLRTJsQXY3eUpsdjB3U3Nx?=
 =?utf-8?B?YmtCRlZ0dGpTWTFRVFlWYldKRGk5c2FRL21oNndraE01elZjTzFPRnBxVUUr?=
 =?utf-8?B?SWo4STV1WXZSbmhPNnlBY1EyK0V2SnZXeW83dkhKb1ByWmJsOVcyVlQvNkd0?=
 =?utf-8?B?M3hNaTN5VEUyOWFwNlFhNWs2dSs4K0ROb1haT0Yvbi83NTZibnZyL3BvR2tN?=
 =?utf-8?B?V1FkTFgzVHUwT3NFZGdYV1lZdzBVbnhmenVCamtuRWo4OStxdTRGOXN5VHNW?=
 =?utf-8?B?bXducjhFQ2NtL3pLUHZySXZEa0Z2bEdWcFA4R2xxM3dQN3JDKy84d0tXbW1y?=
 =?utf-8?B?bmsvZ3VNWG5QZHo5dCtwZllLM25PY3UreFdHTWorUERBL3I5T0FiY0JqcENx?=
 =?utf-8?B?VGFyUU5vbzBsNmNmd09mMG5PMk5hS1hWb01jK3NOZEtLdTdIM2NPSHlpWnlH?=
 =?utf-8?B?bFhwQTlZN1dFZUlmRXNxY0ZCTUFhbGJvdTBoc01CMlRtdDd1dzRCSnNZT1VM?=
 =?utf-8?Q?RkTHXr?=
X-Forefront-Antispam-Report:
	CIP:50.233.182.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:[127.0.1.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 19:42:45.7475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df58a3b0-9128-4173-e3a8-08ddfa103430
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[50.233.182.194];Helo=[[127.0.1.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4377

I am working for the Axiado SoC platform drivers. Adding myself
and adding email alias for reviewer

Signed-off-by: Prasad Bolisetty <pbolisetty@axiado.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 520fb4e379a3954ff9b163bfdfda857e5c5b99d4..c1a050520442a426662830cbc5995954ad090ca6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2471,6 +2471,8 @@ N:	aspeed
 
 ARM/AXIADO ARCHITECTURE
 M:	Harshit Shah <hshah@axiado.com>
+M:	Prasad Bolisetty <pbolisetty@axiado.com>
+R:	Axiado Reviewers <linux-maintainer@axiado.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/axiado.yaml

---
base-commit: cd89d487374c49f18a8c4af312ecc74d997f3b07
change-id: 20250919-update-axiado-maitainer-list-09a2a5ed8960

Best regards,
-- 
Prasad Bolisetty <pbolisetty@axiado.com>


