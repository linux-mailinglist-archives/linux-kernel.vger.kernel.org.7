Return-Path: <linux-kernel+bounces-877048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1FDC1D10B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC7E134AD0E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B3635A15D;
	Wed, 29 Oct 2025 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JoDC4zMf"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892935A149;
	Wed, 29 Oct 2025 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767701; cv=fail; b=RZDznfm7ScdImaPQKuMGuA9IU0BEULVr//gKXUZj+wJrtLeU7Vi7vk5BntfUiCZQp4SaHvt5c8MZ3Gb8FH4h/BivN+IwX7v6ggDE2ba5rGnJxXR2W6Wo+iZ/7E+mAKndOsQ67NQQ/Z8ESa4WaQMVo6l7E5MxqdokWcAqq89pXKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767701; c=relaxed/simple;
	bh=lp/MXFw9m3Onfsc9lSgHIN4Ev0FH8BSLkvAPaUoU4OY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=YMqRwxo9ZBOeLhmp2V6RD6sTPkj4M/MYiuNB6zWzKzT9WNA+BnUG+Q7xSf0/o3PE8+j4DMx+uYFy48Vf1hTc7l+j8x+a8Gy5cUBYvlu3YwEHnlx0o+b6iJ9qMVz9Kw9b8Wd1h2fJE1vBfPI3FvPcbekcQspddETpzi5eUfYEFbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JoDC4zMf; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2BifeTh3+uHVuVBDFkHtM+LjYzGtwmJFIGlZL4WnpQnB0Om9mB8iijCIjrdJ1VfNTOjpwdRqMF0ksOnCc5eg8bRBQqEWtAkEMYp6YazLvxRb/7wryxjozDfLRAXrETiE2cJNYaG/dQTcC0s5YcOpre3qusnXJ081ipekbWs4bPHQzEmOQsFLy348i2Qqi4hu6N/ZLVJY3tvDgE+6LmIOW8NEJHyjD/7aaT359aaoWEOv8b1dVDlGzUeCllkNs2dUD9986bRtX9ZQyezwJScbi/wxgcFyHAw5K2rHPGl4sb+J/8ic3JJvlUHYq/vgdiV2F2fo8nJCM8DwFWIiLBSAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpzcM8YpNz0q1DWf02NIe1ymzdPN0s7eKibmV9JhUh8=;
 b=QWh5Q3p/2ByoydhuaoIr0gg4m+PRC8cwVG0awfBENjEuBnKp4e14HtVL/AZW8NZofNQRGb7lYFonHqdw/Aciim1S+glEft+cVwa+c2ptvK5uk0ppo0B7Mk9da1GamwufZp9R1+VM4s3sqtyWhI7CduE4kwKT6HzUjPQ7CVaX0q0gl5LEWddeiBGoGPQCMxV2nWGT9n9B+r3EF2iPJUqWxuVMNpaFAJFiuX54HCAdIvosxtfYAPVXTsicbOAzzKxF13w2xPhdo+uD7hm+w5K3iDkw6Q3eoRDkT2U0Pyekt+M9tPIb9f5CJnMs9EAkovt52xF+R+sjFOI9qBBH0A7yvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpzcM8YpNz0q1DWf02NIe1ymzdPN0s7eKibmV9JhUh8=;
 b=JoDC4zMfW8YF4XN3sfX4fCUTZ3mU5DyRNp4sH3LFD8LuAGzXO6TYpAIkwBw4DLexcKBmFg153tR588fg67jzNBMJfM41YxmYda7f/UdQWyvp/h2lRYDTp2IiNNhQGlHGtYxm20c7o14MaYz5aMcKoAJDceBlNhO2npdM9kOF9FykjnAE7XjNPRq1btSZfRPyPyekABRsDKFPqM2si+hThdRM2KNtANRgCMLSvpl5PWbA4l1/NqrboGpNdwpTSXj+xT+eBlRm4eBYkSJOO58UxSX7/M2Ogioc81mP73SjBb3e+aNIXjGGSipOoYuQnVPtFXijBI1p0WiwqnU3jPsFrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV4PR04MB11377.eurprd04.prod.outlook.com (2603:10a6:150:29c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 19:54:53 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:54:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 00/12] arm64: dts: imx8qxp: collect some imx8qxp-mek dts
 patches
Date: Wed, 29 Oct 2025 15:54:36 -0400
Message-Id: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPxwAmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMLXYvCioL4lJJi3WQT80TzRBMzQ0vDFCWg8oKi1LTMCrBR0bG1tQC
 HOOBXWgAAAA==
X-Change-ID: 20251028-8qxp_dts-c47a7a46191d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Sherry Sun <sherry.sun@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761767689; l=1569;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lp/MXFw9m3Onfsc9lSgHIN4Ev0FH8BSLkvAPaUoU4OY=;
 b=cW5TDg0vBgRLh7oJ7h3cg93bwRpX+UhFJFbbxD0JQDTdmjSfLS5MG8ElwWoTPIMGIcabdjuwl
 m9hfyXhMHCiCKBsTmp82/X2mkiJ/qGx7yvjbZXu+EAXQ1VsgpFm76qu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV4PR04MB11377:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a96fe7-5bd6-47cd-99a0-08de172506b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUtJVkRnclpia2RBZFNHNWZpRkxFMHUwYWdqWi9xMmhrbjk2VzlYODNJbzBa?=
 =?utf-8?B?Y2IvaGNTT2l6MGVKVXAxMDFkeTNLYTJjZG9oTnVSR0VsWWdyVU5CbkJleStp?=
 =?utf-8?B?WUVUNkZTNk54Tm1vVjRFeU1rSjZSUEFuaytmTFQvVUViSThFZ0JVRnYwNEVj?=
 =?utf-8?B?c3hOOE5OTG0zSTluK1MydjVPeUNwck40WWJXclp1ZHdESVZQa2FLRDRLTXBD?=
 =?utf-8?B?VGZqbnpRRUg1NnBZRE1BNFdqZEMwUzRnQTY0Skg2bjM2Ulh1NWN5NVVyK2hk?=
 =?utf-8?B?czlvM2g1bnR3azR5MTRQV3EzNTFMNXhsUGtFcWlTTzBZWDREc0d2SDEySlJP?=
 =?utf-8?B?blFscEFtWmZzeVFtaDVLdHVrUStOZXUrc1RHYTFrK2lGdWpGS3JVRW5ybEtS?=
 =?utf-8?B?TUM2UXlzUFFEbWF3ZkFNS1Q5U0N5Zit0UDdrbDB4K01jQWE0QXplaGE4NkUz?=
 =?utf-8?B?M2JtZC93ZVNONTlJSGVyQmMzTDJzeXZWTHF2VStpbEw5WjhKOVR4QWNyRFZR?=
 =?utf-8?B?MjBDVWM0cmsrenNNcU5LTGFmU01IeVVZTlMrbExsQ3RHOGdwcmRKK0pQSVd2?=
 =?utf-8?B?TUFDRUpoMk1wRHZ1UXlDOE5jUUVsMkRnODdKVnhkdzJyUXJ0RStwQlBwUHFp?=
 =?utf-8?B?YmZXRmE3ei84WnQ4bWdWakVJQmw4VHNqTlZyZU5CR1BDK2pFejlIZkxSSUtn?=
 =?utf-8?B?dlJUZDNTQWdFMjV4akRNYjZsMjdJdmFZZEx1VG41bW1jT0drbnN3N1pDYzE4?=
 =?utf-8?B?UWU2UWJpazFJY1Z6b1JVTHhoLytMdkt4RE1iY2FNOUZNTXhUM1ZiSEZ6RDJH?=
 =?utf-8?B?MHc3QW5oT2E0TXJWQ1VQV2hJQzYza3NDa3V0d3djeDNwRUViam9QRzVkcGRC?=
 =?utf-8?B?aTAwVTFzSjlQcnlEYlQyeFY1M3EvNFVNbi9SeUV3NXJEYThWSzdjQWhDaW5x?=
 =?utf-8?B?TWZlOXlDOTN2Y0VkdjZTakJUOEN1LzNPNGJxYXVLSWYxLytRY1lOeHRrVWdT?=
 =?utf-8?B?dlBVcTMwL3NPWGZHQ1FheHc0d1d0U2xmZm95RDhmcm9aNEwrRTJ3VzR6WmRW?=
 =?utf-8?B?Y3RibXdVMXdmaVhDaEpnRW1HTnFZMnlvclJxQzVwWkJCUjg1aFlkMDcreTh6?=
 =?utf-8?B?VGhrcXBlVyt1YTh5dXVXcUxKR01WS1NOaFlZUjV2RFJRKzRNUnUrQTVaSVpk?=
 =?utf-8?B?OHlKNFh3eEhwd0R1Q2dqZjlNUkJQQU1rbXBCeDErNEFOaXU4ZmxyRkN3bWwv?=
 =?utf-8?B?dHFNa3dWSHc3R3hrOEEweTV3STVzUkM1MlVoQyt4WFJjb2hGMnI1V1dYUTYw?=
 =?utf-8?B?NVgvWlJEaHpOUXdRdnB5NjFtYU9mOEg3SmJvOEFObGRFbHZiNVhJbWZxWXd5?=
 =?utf-8?B?dC9WdWQ0OS9lTnB6VW5TSDVtdmxIOTcwM0N6TitKcFpBR2o4WnJ5N3lHYk4v?=
 =?utf-8?B?ZDFES3YyUDd4K0FwMTNJMkNrTldvL2ZINnNxM1JZU0N0MitTaHByLzdpQTRw?=
 =?utf-8?B?b2RMMHpzQUhacXJCREF2MDNOMFpJTzJGL3RLQzJnamhCNEhqRnAwN1pqejBX?=
 =?utf-8?B?eEJlenFmMlZQd2N2Y0hxMDZyTzNzZmlranZrZG5RYUlqeTVUa2xFN2ZUd2Qz?=
 =?utf-8?B?RUVhd3hDUlE0ZG9XYU5lSTBSVldVNGN5c0tuTStCdUd6aEZZSVhnYUdVTzJ1?=
 =?utf-8?B?SjRLOUR2NUxCYWRvcndIVWVEenRJVzRpZTYycXlZWXEyL0NNWUhPdENmQWJZ?=
 =?utf-8?B?enFMSWE3Vk1vb0lCV1JMOWF0blZyY0k1QU8zYzVQVDNvVmN0RUUxcmYvTWJX?=
 =?utf-8?B?SitLRUp4TjQxaWx2V01uTmlKUmU0Qkc4NXl0WjVJQUdUbTJQZkNTU2Y0d3kw?=
 =?utf-8?B?dzAwdlU5enBBUE56OUFqWTgrcUVBcnBxekNGaHgzK3ZUKy9nWXgrQkh1UUt5?=
 =?utf-8?B?eDhELzNUSG5XMVBWL2JMdTdzYnhpS3JlZVpJWUY5SzN3eDdwYnp0VUJMZWZS?=
 =?utf-8?B?WWxneVFzRVZsbHJHQ2Z3M096OFU4UGt5Zy8xeE9iWng3SjNVTTRySTBlR1cv?=
 =?utf-8?Q?sQwuoj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHJyM1pCSlBvUWNKdHF3ajJaS3VvWkY3VjJSSzJ6d04xQkpSaDZRTkFoVUlI?=
 =?utf-8?B?VGpmdFhYNWQvRkFYRVRYVnRLUHBoQ1hjYkpKUVRHMVA3bVJNR3lJdHhoNTE0?=
 =?utf-8?B?eGxhSHFYRUduMmpiY3BiNVI1TDRoaUxvYWc3Y1NNbE5kS3Y1Qm1Mc3d3UXdr?=
 =?utf-8?B?V2tWa1g2Y2dYYlREV0NaQ1ppVVVGZVFRRG5Mb2N3ZXNjSnA1KzJXL0lQYnhz?=
 =?utf-8?B?ejJYdWJyTnBxaUVpMGxMbVJITlBmYlpHNU4yZXJlOUs4UkR0NWZNZVdCcFow?=
 =?utf-8?B?b0xQejNMM2NmMGhkdUx4MjY1S3FxTW5PME9lUTlIc09nSE5EaEF5Qmh5U0xC?=
 =?utf-8?B?R1RYMWV5Y1NpOTN3ME9zcWdmdlFxcnZYRkJoTTM1QkpLdkFqeXEwM3pIcGJZ?=
 =?utf-8?B?VldUdW1hNG91YUtCUzd3WnluUFAybEZBbVVCVkZsWnBKMWFQZEZaNDVLbFp6?=
 =?utf-8?B?SnExMjZ4a0drNXB0enh4a0cvR09lcnFtMzFodjZWMFhma3V5emVicU1qckpL?=
 =?utf-8?B?RTA4cUxiSjZjL0Y4VmFUTldYMzRxa2MvWE5NSzkvaWRwbXdpTXBVdWZLaXlL?=
 =?utf-8?B?S3RoU0ZneitHK1JPOG5vcFlodGg3MW56bjlub2hkL1N6cHBuSEJDKzc0QWFl?=
 =?utf-8?B?dC9jYXZyTEcwdE42am1lcTR0WUpPd2ZzUkdLZDNBWUNwSFBvV29VeG84QVN0?=
 =?utf-8?B?VjY0a3YyZ0YwY205T281TElha0xNaXQyUktrOHZmS1g5aVpXSjRGN0J3bWU3?=
 =?utf-8?B?M0F3cGF4bDNjK1FYbGMxVFVOMnlYTi9MREdRc0tKRmh2OWNFTm44RHVtOWpy?=
 =?utf-8?B?Y0pDaXdXZzROdDA0bmx0LzZNbnZZYTUyTlo1VVJIUEZiU1FHRytpclQxMUhI?=
 =?utf-8?B?OVNoNDVRc1lLTGU3aGpRRnRid2tTYTZCZzg2bVFqRERKUHdpMDE3RCtzWHRW?=
 =?utf-8?B?TTNuMGx6dXgvTXJ5ZmZLMUxONzB3Q1ZVTTlhTm1tVXRpU2J0bFRWUjJscjgr?=
 =?utf-8?B?bDhWNmFGTHJKK1V1ODB3ejIrWWRDcFZvL0hHbWthb0RZNzhxYURYUFU4NmhF?=
 =?utf-8?B?dm94cFJLbGE5ZGE3OUhIL0xSS1hhVFBwNytjMnZtZjNIMmVHQXJxWjg3YlNo?=
 =?utf-8?B?bzhpelBWZWMzcENTc2VSYjBGVjVINjNTTDF3SGwvK04yZkM1YVlxVTFwYWtj?=
 =?utf-8?B?ZTdabkIzRFVvOUtsSFQyaEZCMDVNSWV4Y1NmRjE0U0lvWDdqTGwvZUkzZzdv?=
 =?utf-8?B?eitua2JVb2RJczhveE9XVG9BVXBOeFBOUXRjQU5YQ3lhMDgrRTlIaE5oUGt5?=
 =?utf-8?B?R0dnaGY4aDgzTXgrWXNpeUgrc2ovTVJLcVd2ZkFkVnFOQjU5eDFaYnJtRjNT?=
 =?utf-8?B?bjB0QmJORjlYWUdzcnpGNS9TMUkvY21zV1BicE43b2pUanZQNDdZcElNcE1H?=
 =?utf-8?B?Y1A2cU4zbnY5OG8vZWtIeEpSaDZQb2EzZ21mWTV0N3kzQTdFVW1abzgvRGxV?=
 =?utf-8?B?SzFYN1dpZFVWWDBNL3VVbGhYdlkvOFNqclNXQTY2QjlWMHJsbnNaZlV2cTI0?=
 =?utf-8?B?aTJ2QzNQR3JNUHcxK2UrR3YyTjkzdDlaVk1NaWxyZmdxU3ljQXFuYmdyME14?=
 =?utf-8?B?YnV4TkxUYkJEQ3AvRWJTYUFkRFpRaityRitYRGh0N3dPRG51RUtkN1RIRW0z?=
 =?utf-8?B?Z2pCbWdKUmxzb0VMcjB2UHhJVnpvYmt4QVV5Umx6ZW9RbkdBa3ZMMGlTOFpM?=
 =?utf-8?B?N3hJNm5NUVdkbW1xVWdrZVZRdU93eEpYSnJpYlF4ZlZ6V0NwSFVZSU5tb2Vv?=
 =?utf-8?B?YUZ5RmZsU0ZNUGlXMEpGOTRjVHRuMXMrVlhLMmh3ZTY1TGZaK3pnRjBicVJO?=
 =?utf-8?B?T1hJdVI5WFV4bFdqWDhTWHY3Z2tVbWJpUkI3UmcrSXIxMUcwVzZFUXJNbmRQ?=
 =?utf-8?B?aHVhNGtkb2E5VmdOMEdxK0hSL1dhZUNEc2J4NWZiQmUvMmRod3NacXN2K0M4?=
 =?utf-8?B?OTJPVmZZalBqZEw5T1dnZzUrU1BIVXJBT1oyOFY4MnRYU1RqbzNNSUJaczE5?=
 =?utf-8?B?MjhPdjNhend4UVlXRmRqVVVzMCtaN0htUGlRNDZzazVURjdiMmRoS0V1ZXR6?=
 =?utf-8?Q?gtcCEc2YY3Xl8o/5a89tO8gjk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a96fe7-5bd6-47cd-99a0-08de172506b1
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:54:52.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7dRrdboEqYQYDrhzrUWQyf9fISmbk9TRoLK6HsnAdpvhrBw43HaaiVZVYELiVeQV7gGhQ4qI40XDeJELm7Iig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11377

collect some imx8qxp-mek dts patches.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (9):
      arm64: dts: imx8qxp: add MAC address in ocotp
      arm64: dts: imx8qxp: add readonly for ocotp
      arm64: dts: imx8qxp: add wakeup source for power-key
      arm64: dts: imx8qxp-mek: add state_100mhz and state_200mhz for usdhc
      arm64: dts: imx8qxp-mek: update usdhc1 clock to 400Mhz
      arm64: dts: imx8qxp-mek: add flexspi and flash
      arm64: dts: imx8qxp-mek: add phandle ocotp mac-address for fec
      arm64: dts: imx8qxp-mek: add fec2 support
      arm64: dts: imx8qxp-mek: change space with tab

Joy Zou (1):
      arm64: dts: imx8: add edma error interrupt support

Richard Zhu (1):
      arm64: dts: imx8qxp-mek: Add supports-clkreq property to PCIe M.2 port

Sherry Sun (1):
      arm64: dts: imx8qxp-mek: Add lpuart1 to support the M.2 PCIE9098 bluetooth

 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   |   6 +-
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     |   6 +-
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi |   9 +-
 arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi |   6 +-
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi   |   3 +-
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      | 166 +++++++++++++++++----
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |  10 ++
 7 files changed, 169 insertions(+), 37 deletions(-)
---
base-commit: faae091652fd52f662e1fbc6b9d922b3d6e33641
change-id: 20251028-8qxp_dts-c47a7a46191d

Best regards,
--
Frank Li <Frank.Li@nxp.com>


