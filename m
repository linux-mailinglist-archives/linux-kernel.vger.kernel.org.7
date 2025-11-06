Return-Path: <linux-kernel+bounces-889538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB9BC3DDD9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210FE3A2BC7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF63533E349;
	Thu,  6 Nov 2025 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="TKoeQo6k"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C902E4279;
	Thu,  6 Nov 2025 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472138; cv=fail; b=kMfgjwlrMMaehx+caeIfLAKGvh6BmnP/jEQPukJijl2CRHXdqXeFERxvo43NyR+DiogxQ1r1LGhZaigqK3vfrkBOZVkZ2LNQqxbp7pzZ6G2hbje7zz5ajCYNIY2QfBtArf2aTef05qKLZKc10e50WGKJkryb+MOo/iCf7CHcwCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472138; c=relaxed/simple;
	bh=cWqA7hI9BOHcmotHSYQHiN7JdJ42NWplxxDm8+RGyDU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RhNx+83SMaECyP2G0Bquf6xbk0Rbo1AGul5Cga92VAPH5yVuYAQ0V28yQJheonaoFwHu/89A04LDxsY4rRRU5tfGTIjAz6lEB17bVXxpv1TDEWW55ng9dVLMLsVUYxTd6yQwtUxzZZa8qFpiKETTKqWC0WRpyjcaPNNzAY9dGtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=TKoeQo6k; arc=fail smtp.client-ip=40.93.198.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfloGV4Cqb020/vypfeAMxTNXFXgN9ZEr3miTFFtZFR5APsFtl3sIfnUoBs+/gQf8r0B85QUsLPioqxGOZzOrrL0jb8lmQBpOzozvKG2ZubdTPGX5bL3nsEOmVKh+iW03uTjdDR+hqlt2K4O92KsV2IsXpYBoBzNvOHR3MqAQmm8r/gf7mdoG7PP7v8FIDuXRutkzOUo0Z+MukltopQF6BkyUvvyXu0hZ2lMEyBhnI9A7gpdaQHcgN7BGwcS20cohAo4OY5q6Oi9StPPnhWApRCoRW8mpFMX68KAfAX51BcozvY4Wj5szSMl/fYRFTLUuK2k1vFBYUjLIoFtI1sioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8fKrD7isQ5S39+P7eFiHRYZNAfDCwsyNbq40rIYeZQ=;
 b=sCjEJYwQCWfFg4PL6hwCFnouGeFrJr8Z78R8viIOyj+5mbU51oBQa9WuuGdpQUY+EqxqVEGMoxaMf2UcYTGhj6xQY8GyC9kltVmUqD1lRPoFEr5kY4SaAgh0cBN/iYMtfBfqwdy/p9vUaZMaviRS5HCHry7qSp0DhWNm+ttOv/Svozc52kFZOjr9XMCwVq0ZNF7qWC0dS5dR7SVInCv+Y/CGolJ2p4LbcTbY1JefzgLnJ5GzA/AiSfm6+9BprMk9Ertb0+WXyuM3pCSErYxNuCH3Iu9mqgSWhxs4bwi5zTfUdISt1wxVC3MXV781jzb7DDP9t9CGNyQ62NntOnrwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8fKrD7isQ5S39+P7eFiHRYZNAfDCwsyNbq40rIYeZQ=;
 b=TKoeQo6kMXvLeGQyFkWA6G6TtMK9GfpXpa3+zbfa2beisXUg2M3IZYzsVw9UM21JbTmIQ+CLwnDOWvcB9ur3s1H3Kxk/EZe9/U2v4bHPDhTf7z3JCq82fX+2BOVdyialO7tXFqWnIXK84OXkHqVa0Z6S3cNRkhk1q0CJ4sCgXmjgRMyUKbfR96AxQ7cOALXLeyAMmMiyo9zMSPPxpWmnKuS/ZYmcMXc2ClcSiwgg/QiQNzauEJJAiUWwGendqgILrt4g8MIdtWm78+Tf9b8+uoI7XB+bZ1o18P4pwEZ+MlQe/Pszt0STNjZZmoogd5OvRRNhU5ycLzXc3abOJoKMGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by CO1PR03MB5794.namprd03.prod.outlook.com (2603:10b6:303:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 23:35:34 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 23:35:33 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v6 0/2] Enable Service layer driver for Agilex5
Date: Fri,  7 Nov 2025 07:35:24 +0800
Message-ID: <cover.1762387665.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|CO1PR03MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f380221-8526-451b-6b2b-08de1d8d2d27
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lvikUh5jZFtPgQQTfL6Pc313Z9c7jDih+rN9AmphPRyzQBfH5mx/C1G78Nzz?=
 =?us-ascii?Q?hkBuIMLBxGD6vir6IVuRE1DTE1lzHKLPJCId1xqMQdOpwKO4xaVTbEuDTBl/?=
 =?us-ascii?Q?tiLFJ2mWj5M4UPmTfkopAwW7IT74QhGQgvwwSDYjsl66BpvoFjOO5PnZdGKn?=
 =?us-ascii?Q?j8MdQvZFyWK/jM37/KTZQf6BqKGLtaaoEcIu8xiouDyoY/c8oYXEoRWtoVZg?=
 =?us-ascii?Q?7Hc30MoAGHPxdOGj7sSATTeTSK2JYFE9hmg4zlujCvduO/iDfjCOAaNL7WjV?=
 =?us-ascii?Q?D45iD3YBldhFMGEIcW/k89N/ttBRscNfytRv3VJv8kOcu85469O8Az6SlMeL?=
 =?us-ascii?Q?0ZcpTlEpcV/tBz7RHOSGLHGRc4LMH2WjyD1jcR7BRSkcH2R0CB5N8GySVjVl?=
 =?us-ascii?Q?eKwct62yBjPuR9+kAGtrU6WKC3HfhM1FQQOVuMiR/tVRdDZ6OitvAvNR96M3?=
 =?us-ascii?Q?O1FAKSG8eRyg4bBZgLInUHRBzFXeb4dvYXzX4tzuJU0FDxY/kFFqTV5ZkETd?=
 =?us-ascii?Q?NNeTMxgdSwBxe/e8GM81THRpV0EGiRUJAeX3zvRD58Fe8YlOnCm/lQhkYrGY?=
 =?us-ascii?Q?QZAd3A1x8ocAEb0CBuABIh3uW9xHLmclAcFFywlKJHFIDnewnKI9z9PEd6OA?=
 =?us-ascii?Q?9VNypCaOyRCRj8jB4C6qqyiX6JG40Rvye1aFr+bGC1qkv4VABOlpdJQeyt+X?=
 =?us-ascii?Q?6J4LBjOHZ5MNHoGcuT9hpF5spBU/n7rIePOIlqLdnO1H+8zO5+WTZc2uXYDf?=
 =?us-ascii?Q?gT3b/mcNAzKyJfgMimSFqst274FraskHndhsoVwEE6BIK5gv+WEX6kGcvazN?=
 =?us-ascii?Q?XSQyNvAnTtWgkxXNbSfo/ZsMtKXeXaGMKeriZYUajO0GJGUV4gyfCAbSvMo2?=
 =?us-ascii?Q?axndY0IhPvGfO7WqxrOZghjA0zJmjpd1clk+JwBRfJHoGh8CPUMgqHTPTEi+?=
 =?us-ascii?Q?eIyLdrJFqCepTmNA6hSPpt393AQ2KmipaGaeCokLqCibx4g78CNcTvGFaG93?=
 =?us-ascii?Q?y/zuqO0xN+JxlE9twlTpFFc/5+GpsDwCYuXpcnXwK88TYMdUwEU4vFrMIi4b?=
 =?us-ascii?Q?Jq026qbSLeauAkeBazcuaEmtpMWhPvUo2gUcQWCRCIYc28n9uEeaK8IEwqOg?=
 =?us-ascii?Q?BC3qYrcMk3uf1lZwzYYgKh3AiscY3vD8hua6k9DI7WUtvbAAWBXdSguAX7ZU?=
 =?us-ascii?Q?kQq/y7KgCi6nxP7MJTuBAg20ZBfaV2yk6s2SzfsupwoVWk6As5gcV9xoRkSk?=
 =?us-ascii?Q?TMAZBBwW1q85MtN+PnSa8fVtQDMjey1dtZ0iC0whW6SW2ZX4HUUGhE0Axo91?=
 =?us-ascii?Q?kQB84cnybaabpEKw2melVSMF2l1cJAmeTHFcTWB8SJ3JaY9oPWy64u6W+D1w?=
 =?us-ascii?Q?F9yiQ/CeQL6FAs4aTPoZcBYjr0kDJN/4b/CN/0kNgWgt+7FMdBmhWAt+M47o?=
 =?us-ascii?Q?DJ5qsROKbS1Kv8ciOhqW5PPy8p5TjW2bG/yE0+Mosml+tosoCByhAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SRf4lvH082/JhcrzezRjNnbnm40NvWQKuwbKcPfh9lq2qsUdP95E7zcVHNRS?=
 =?us-ascii?Q?HFdMmKWtOXT+5j0YPGaGUWC9FihNNs9ApEzpnOmvBWrX6Qg3YCuOblIhjZFd?=
 =?us-ascii?Q?+SWMPM94AKE8sDkpMupaVTgxdcFwUSZrY2ebY9j06u9Z3v2d0bev+LcEK6pX?=
 =?us-ascii?Q?WTi0OMlOnC4rZwq2ZZa+3mweZAbX15Xhk8PtdGZCiX2f6jm31ueBJ6JIFOnn?=
 =?us-ascii?Q?Dh1HsHb4tQgQxf3sTmj4NQ65BoFnnj8WVDm/+nddmi6NdUNNbZ6iA/+KzT5k?=
 =?us-ascii?Q?Y2irhCk1pZkjSF9XCW+2+RN13tpLvZKePiUoYYJ0c/5e992Hfj5O3vWZ9P4c?=
 =?us-ascii?Q?B/Obf8H/uYja2eLRtFuu3cRcgVfkKYqo56Y5VRT45IQLKRs+HQ1drLk7Y1+m?=
 =?us-ascii?Q?F3b3hAIiAy8Y7jHEOgRB0dzMX6AVAZaSsA4mZbJni3rmyG1clCAyTpeAHpw5?=
 =?us-ascii?Q?J1pOvi1WY0AJuOVvZQx6b6dMoIRHrTs6pjiSVeVkSetyvLeelNN1z8on0UIp?=
 =?us-ascii?Q?Mo+oGGge1l76PlUiXEtifi698jnSuYtwsl0/ArjIs85vKjq7dRlb17tibCu9?=
 =?us-ascii?Q?mTI7RmHeeJZ4vJApTqLFiwq3zlGiK3ZmxzpQblpGgQ8iUNZjoaBaHdUleAFh?=
 =?us-ascii?Q?MHS/O9Zw2U4t5uo9Intn427NmQd10bOpuiprWqyF8X5ELi7VULDRM5Jhm2OP?=
 =?us-ascii?Q?7icn2kt1y9PfYxzhoZjtE1jZs+hTVj7OXKOz1EiBon0w8JgczUBd4g9HUtoc?=
 =?us-ascii?Q?jaPewKEL7jM2YX7fKVIAwrH+f6wZDcYGOxqtgY1qO4dxehIahxs6OMlw6YY9?=
 =?us-ascii?Q?cVCFBXwfLON25gSEnvNDpNdOMHexazGCUmFxHtZmnv5kUOqbrZ2tD8w2EOby?=
 =?us-ascii?Q?8qHf1KTuk6/j260khEe0Y68J6oNM/Eo1j90mWGldpLHYkVVSPq6O9IWCUq0h?=
 =?us-ascii?Q?nplivhyMyhbTQypkIm9l7G9z+syhI3L1gxeiFDnn1I9MSIC8nJriwdFGi/Nu?=
 =?us-ascii?Q?EXD/MUct+7WON+th8MDuoyEBugfzSir8+4AGm10gOlf9Yd7tXogq55TkOAPb?=
 =?us-ascii?Q?W0jTRuurJ3BEV0kxvOy24cqn+xeWwguLca77+D7/W+BuahwqSDQ1dgmKd4A4?=
 =?us-ascii?Q?3DZSz7EdnYbSxcUKGmLvyXRIOe9tNkMJIBF6qZw2y8OwzFMg/CqaJmv0RfBn?=
 =?us-ascii?Q?uteJmP77OgT8dEWCeRvo8bF31AEvHoOtMwFGkDVHUQr5LwHMieXXOfDv5E+o?=
 =?us-ascii?Q?XRcZPh0Zz9vUV3nSy0JaIATOpbmsuX+VtvGm4IjPSu3z07EokPMyj58neM6r?=
 =?us-ascii?Q?ocgm8ILcCQjGXD0YDUzaomJ/X+g0XtZXWBx6xoPuVH+0+4OGLlXqNDA1rafi?=
 =?us-ascii?Q?ZirAiUyGR8UtufEWJ5lTe8yvmVqWTRVW43jV0Tob5RUT0yrWrZ8VE4JhaeUE?=
 =?us-ascii?Q?0DMg0afYzG/Jndq7XzLIHarkjm7+6IWnVnYbaDNTzQzPmViKI46QogbyNq3f?=
 =?us-ascii?Q?NsrJDES7GUiXtCkhaXBXm92o0z2gFyDDyXUAAb71vxKn33DxYuStrqtCtlyE?=
 =?us-ascii?Q?RByEskPyzx5i36ep5N85VRGLm2jC9s3xja/ExoOuj74Nyiqs7emEd3Ey8QIn?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f380221-8526-451b-6b2b-08de1d8d2d27
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 23:35:33.1914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsTTbA/T0pBTqu/FDFEELRw5rTSxNU4Qqk1MXQ+v0GEuDZ+dNco4oDK+HbdvvOO0Mq3jXfkm4ur0O6GemtknkgCDqC8ZNd+bK6h88+R4yM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5794

This patch series introduces support for the Agilex5 service layer driver
(SVC) in the Linux kernel. The changes span across device tree bindings,
platform DTS files, and the Stratix10 SVC firmware driver.

These changes are necessary to enable firmware communication on Agilex5
SoCs via the SVC interface, similar to existing support for Stratix10 and
Agilex platforms.

Agilex5 introduces the ability for the TBU to operate in non-secure mode,
making it accessible to Linux through the IOMMU framework. This key
difference enables improved memory management in non-secure environments.
As a result, this series extends the SVC driver and device tree bindings
to support IOMMU integration for Agilex5.
---
Notes:
This patch series is applied on socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

Changes in v6:
	- Reinstate AllOf so that the future addition will not have not
	  require re-indentation.
	- Add svc node below cpu node in DT.
Changes in v5:
	- Use contains enum instead of const
Changes in v4:
	- Refactor the logical check without using AllOf.
Changes in v3:
	- Remove driver changes in driver as it is fully compatible
	- Add iommu entry and rewrite the git commit message to describe
	  why the changes is required.
Changes in v2:
	- Add driver changes for Agilex5-svc compatible
---
Khairul Anuar Romli (2):
  dt-bindings: firmware: svc: Add IOMMU support for Agilex5
  arm64: dts: intel: Add Agilex5 SVC node with memory region

 .../bindings/firmware/intel,stratix10-svc.yaml    | 15 +++++++++++++++
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi    |  9 +++++++++
 2 files changed, 24 insertions(+)

-- 
2.43.7


