Return-Path: <linux-kernel+bounces-896467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1772C50715
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032A73B2153
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E5122370D;
	Wed, 12 Nov 2025 03:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tw0RIQiv"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E01DE8B5;
	Wed, 12 Nov 2025 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762919239; cv=fail; b=pL8nWTETNvbmGnRDbHEG65gAk00Fil/5THDy9YFfnvrggDtabbSNTzyyGRidGoW92hyAaHzkStbp7R2TsFk230UFU4wkG5G0JP/fMn/L3UkL49Xbu3+aPtDZgcVG9G21Via6rIXqaIoVe1bRejeGmeGnxsNK/Kp5KZfIfI3yPtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762919239; c=relaxed/simple;
	bh=0ASu06xmnU8onK1AszWGsGb19O2jaZg1gXRBmqXmlXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jd6vCbF3/8D2qiZVLqKBLH823mcevZWORozRB/1vtzCIhmPp42JcF5b4ZK2j5u4dTPlkhZShIKWzipCPmo6wDssXSjl0eqGhrANQewgFdtzVhQJsmTfyqTEdk37F7QYKo22X26vZnlcVNFh2jLPePpOTIQk13RQTkeqmprfEeq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tw0RIQiv; arc=fail smtp.client-ip=40.93.196.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhhcbcx61IkVJEl1t6b61TrrgHaCSyggmIr4Elqnti5UYZIIGHq+l7iVN29NRlriX06IVTMi6skIj6o1MdHllPZJ4RYOiR27GWwW54BJLWz/BRC27COw6HhfFO660cDBRmAYKvsIb3pEaqYaRmeOJzuTLsVLVN1zG0PKCKQXjTyyFgHjh50Wi7kxEuKnYKXCxIAFMxyMHFlel7jAhpRtjXdmQE9JVGugN8uwo6WdlltreDa6Ohj61eTxHESJ2QmXNySUOQmsXilnhHJCzX0RmAP17+nA7DqTDYOiccpljvouTgNHbcLmmHszR1zdrunhbEp68VplQvjmjH7nM5j8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hqn/wzlgzq5DjCmF6Pn+Pve79dJxLs3SuesVVNvdNOE=;
 b=L/vVRayPYoxB4UJzz7pvG7E1epo/awD19XRpYCIrX6vswtY2fQ4zOdS6wK628LJCItGbnWvPr6OkUbz90ZZVVJIfo3KZtM4HzDdAMD2bTQgblob31lGgVxi0nWUFnC8g3A3O83x8O56KZiRBO5MCuVtkNFiEFJIPGcnay+KUpEOPcGZ0Ep7nnD7mxchobfIdeU5n42rLIRmhbs4wbGEo+TBVIAP9XIsSgA0E4SSPYP+HFVELD3b0/aSR3Y43jSizqSyjObniOKKRmXqydqIfgR4Wa5QuClK1Kh7lij53pbKUyYAaAIfYf7eIxMMwNZmNG4IE6hsOP0JU/7EM5XRNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hqn/wzlgzq5DjCmF6Pn+Pve79dJxLs3SuesVVNvdNOE=;
 b=tw0RIQiviW6tz6y3zKWeQZf6Txv/xbTeGon9c7pY2zGnW369riEzhNKJRjefpKaaiLatuniIuZ+tl/JZUCt6uVC5SIQLFtD3LMF6hOIKinCG9/T9cODTvffpQMLyrjOMgTBETqLEuWXBjVcHYwvcoC5W2snjLynBKBO3+bLYY+E=
Received: from BY5PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:180::49)
 by CO1PR10MB4436.namprd10.prod.outlook.com (2603:10b6:303:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 03:47:14 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::9b) by BY5PR13CA0036.outlook.office365.com
 (2603:10b6:a03:180::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 03:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 03:47:14 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 21:47:10 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 21:47:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 21:47:09 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC3l5ee1994232;
	Tue, 11 Nov 2025 21:47:05 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "Markus Schneider-Pargmann (TI.com)"
	<msp@baylibre.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vishal Mahaveer <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, Sebin Francis
	<sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, Akashdeep Kaur
	<a-kaur@ti.com>
Subject: Re: [PATCH v5 0/6] arm64: dts: ti: k3-am62: Add wakeup-sources for low power modes
Date: Wed, 12 Nov 2025 09:15:28 +0530
Message-ID: <176266923845.19596.12294261339595431753.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251103-topic-am62-dt-partialio-v6-15-v5-0-b8d9ff5f2742@baylibre.com>
References: <20251103-topic-am62-dt-partialio-v6-15-v5-0-b8d9ff5f2742@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CO1PR10MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: a466dbcd-639b-4679-46c7-08de219e2b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXdCRENOaUpldEt4OHJiUDZSS0xuZDlGRkVlVldyY3hTemkzUTVoc0JxaEpq?=
 =?utf-8?B?MUlPQ1FNR1cwR0NseWZxQndEUEZRQ2ZDRElKNXo4SVBETFFGRUhkUFBkY2Jv?=
 =?utf-8?B?V1dLMm9ucjdFQ0xqQ2tCLzNjZ1RpMC9GNCtJMVJVMlpEYWtlV1ZranIxYWJ0?=
 =?utf-8?B?RnZrcG5rSkhHbGkwMFBSMy9icnlYZGNXZzlTMjNmQS8wRWp4emdXWU00d0tT?=
 =?utf-8?B?VVE1QUN6TU5tSWdUY2Z2OHovMnhDOFZ4RFAvdzNwdFkrV0ZDdG9IbE5sVjFK?=
 =?utf-8?B?ajJ3djFQYzF1Sm0rbFd5ZjdRTUd4VldFdnQrRnJ4bEtvV0ZJaXVoeUFobEZv?=
 =?utf-8?B?Z0N3QmtHVXVpTFV3MFBZVlZraHc0R2hVWU93bGx3dVdQU3FDRnFCakVUYVN4?=
 =?utf-8?B?RDIxckl1VThIR0poVlRUaUV0bllBRXZkbDVxekV4WThIL0RIMTRuQ0dUbW5K?=
 =?utf-8?B?SDFkOGQ3YUpweUZ5T3ZwQittbFJhSzljTEFXWHlVbGp4aktiOENvYTlKV0JS?=
 =?utf-8?B?SFE3WkQ2Nkk0UU14MHRGRTlqeTNjajUxanJEd1BWNnFNcTRTS3JrbkdqVDAw?=
 =?utf-8?B?VHJCczVrTitVaFlmdVZkV2UzUDBlbVJtWnAxam5SVlpBK3ZKcWFvbUdyR01p?=
 =?utf-8?B?SVlNa0cxOVpLdmR6V0RKdmR6V3lySERDcGl0UWlJdjIwNHZLRlRZeDZBaXdM?=
 =?utf-8?B?UWpMd2IyeVRJclgvVnNueWgwRWdvNlh3UFJEN1ZTakQ2TGRjZHBpamMwUGJJ?=
 =?utf-8?B?SEJWclVEZkFrcmU3VXlIMzJEamJQcjhGRUNJR3hRd3dTNnY3SHpYUGFqd1FV?=
 =?utf-8?B?WVg1OWdwdExpMXlFK24xdlFYNFpSK1E2SkFwazZRbkhlZnFiSW9sekM0OGtH?=
 =?utf-8?B?OUxKYUNQRVZ0UXI0V2diSmgxejhDcFpHWkYrcm5YNzhrRkxhbm1EK3BrZG8z?=
 =?utf-8?B?UWJkN3RsL3pKaG1tUkRTUnVRazlOK1hsNVlMSWlMV1lQUU9PQ25vUE80WFVn?=
 =?utf-8?B?cXRMdFpJU0RRZ1dtLzlrTTNKMzdnWTR0bzJxTXYzaG1TN3ZBa0FZYjZaTzAr?=
 =?utf-8?B?V1hZUWdyUnJ4RWw0eHU1aFlxNm8rT1ovN29MY2pELzNnYktMUjJQQjVpK0o1?=
 =?utf-8?B?VXFVR29ta0l3Z1RKdk9tdHRid3A5VklPUis3bFVjYjh5bmUxeVA0emF6NTdk?=
 =?utf-8?B?YmI4ZnkwaG5COGVRakNUbW5yWVV6elBVcUUwZHJtdzUwNk9KNjlNTmNBejJ1?=
 =?utf-8?B?bDZCWG01d3gwamNRM3BQTnhVZ2ZHcGVUVFlEQjZuMDRya2VsemUzR3lDOXhv?=
 =?utf-8?B?Y0lnOUNQc3JMdlNyS2VJNTRvTXZHMktXeUVSZTdXeHFaaE1kVEppYkFvK0Ji?=
 =?utf-8?B?SUFEM3JjTEV4dWhVTzJDTEw0S0dQbFV1b2Jhb1djOXhIdjROaWdhUkdzSmw0?=
 =?utf-8?B?YnpzK00vM1RRQjdOcTlCaU9sditUL2FwcHJPdG1KQmYyWkEvWkhNN1JoenYy?=
 =?utf-8?B?aTRkS0EyNXFVS3lwaCt6ZVoydWhLS2pmeHZXZGc5Z3NBKzQydjlXdmZOOVZO?=
 =?utf-8?B?SHYzOExWUGNVSFBLcU5NazRVMWJ5RG93czNXUzJQTlFpRGgvNWdBc0JpY2Rm?=
 =?utf-8?B?MXFVOUt2cVdXYmVwUUtBcG5QT2g3NWdrTXVKUW9oQ3hFK1MvMUlmV1E2L0hr?=
 =?utf-8?B?S3dmUnloNEZ4VmgzUFM1ZHpEUGdoeFEvclY2YzJZc2dKWDlvYkVoeGloYzQ5?=
 =?utf-8?B?amNvVHVNOEVUMXo5aGtaTlpzbGVpU2tETmloWm1xR3BKMzYzMDdFdytMejhx?=
 =?utf-8?B?R24zaVNYTThNTUJITmVWSEhuem1tVEMxRHpBcVREYStoVUNmZ3lSZkhXRXYy?=
 =?utf-8?B?L1ZSaWFHWlFKWVF0ZmRwTVlNR25XNFRuTW9hbUNjL1hjeFd2RlNiaWp3SUdN?=
 =?utf-8?B?WWFRTUFES0dFcHh5ckVlTzlEdzVYV3FHRU0vbUtkMjRzdlhqQml4bVdteVhn?=
 =?utf-8?B?RXJla3pHSHdZK0U1V3hBTHkxS2lZZHRteHIvcUh0VkszRXc4UVNqN3AzbHps?=
 =?utf-8?B?QXVQaElzK0dyUHhKNlp1NklpN2IxOWdqRjNKVlpRZnIvSnd6TlZEV0lFUEdx?=
 =?utf-8?Q?avsQ=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 03:47:14.3095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a466dbcd-639b-4679-46c7-08de219e2b09
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4436

Hi Markus Schneider-Pargmann (TI.com),

On Mon, 03 Nov 2025 13:39:27 +0100, Markus Schneider-Pargmann (TI.com) wrote:
> This series adds devicetree changes needed for Partial-IO support on TI
> am62, am62a, and am62p SoCs. It defines system states for various low
> power modes and configures the wakeup-sources for devices in the CANUART
> group. Depending on the SoC and board details, some low power modes may
> not be available, so the wakeup-sources are described in the board
> files. The series also adds the necessary pinctrl settings required for
> proper wakeup functionality.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/6] arm64: dts: ti: k3-am62: Define possible system states
      commit: 1b45cec18f89d8f55284bdd4ab124b3cbd0ee1eb
[2/6] arm64: dts: ti: k3-am62a: Define possible system states
      commit: 6992c72c3aa03c1c578c950979b11101a3fc51c4
[3/6] arm64: dts: ti: k3-am62p: Define possible system states
      commit: 4060cf6015e20d7647e9e242a5ba21762741e11f
[4/6] arm64: dts: ti: k3-am62-lp-sk: Set wakeup-source system-states
      commit: 1f2f34b619ad9f3934bcf7486a61ff70d18bf420
[5/6] arm64: dts: ti: k3-am62a7-sk: Set wakeup-source system-states
      commit: afb919a6b36bf86e9000060634740fb4ab987d45
[6/6] arm64: dts: ti: k3-am62p5-sk: Set wakeup-source system-states
      commit: 1581a732f1688cf8a676bea11566045e33beca35

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


