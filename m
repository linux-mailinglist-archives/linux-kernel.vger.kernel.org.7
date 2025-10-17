Return-Path: <linux-kernel+bounces-857599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE87BE7382
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E13D1A61B65
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C38C2BD016;
	Fri, 17 Oct 2025 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="B7qItdfx"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010057.outbound.protection.outlook.com [40.93.198.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD45298991;
	Fri, 17 Oct 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690456; cv=fail; b=PO9e5r7D5/Nb64aVJCQ4GYcTzTvwgN/UcAWZo/vDWAU90Gu0EVVJezzFLfZkJsRC+g9obWmkLZMp29pMwqp1ERPAxUmoyqSLjkzM4q6mZrbJvFFEfP7x95pqcVgKgxDeq/sYmTjwc9K7xlZblPgsc6Hq15IlG6lzBeGtbxBAW4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690456; c=relaxed/simple;
	bh=cABuCYDzwKC0WGoFjwjCcIdusGPgIRwiykr8MELa+V8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k3ruu/sl/6sOi4oeM2Ax8o6HhgvjjqavMYOGnKFchVvsBLPxEz5MMudS3tRE72lwyd/BVC8mTgIc9WNDWuaA8mD7xGeyU3ku2EAQuqueyBaY/Ma40zRFP2twZw7Dc+jm9tc0dyWrMbj4Bt941evM6zrxNuYFQHsJ7bzvlhFjJJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=B7qItdfx; arc=fail smtp.client-ip=40.93.198.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbraJZ3qsRZw7aIp+G+6brmdK4+ViptDmuFyPSuXKfFx3vc78SnnLG/CMj8B3yrsPbLHsH9GTnHBgVuF+ev073WUe+OT4a9z4K2DRTNFledvMOxtSaU6iM8Bri4BeYpwPdFaaCm/xFZ968B5ZfRGew5xfM14AhCu9e9wQf3W3LZTqj/MO4shVy9796VtNHQyb0G+mQI5KN6L7pXdxgxLwhoszUMt5TzDw0+CpI6DpJ705XOumeQ7oy6rf8FjLXGverzXdPb0gMkWEqt5mlcXMQPQ+KZ3525mUCHklfj9pgzioGSRgoW1/IqzRGUl89xbdQrAl2dW+qQXRX+TcJAKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxEVEtGzKZzCU1LeZGQmHL62vr+RGq/siTPdljo4SdU=;
 b=AZwhEXyOM/2eLS+h+5Ny47VB/lQ+avEOgRMtOf2hNmZY/pkrrxaP3kajMrrWK4WFzc185W82IzxAzcbzDcBEteeBKRC23lG3LOtX634sH5bFlCwspketyG0JtDUb3Nwh/4LxH4cTVod5UIqWAQXKJnVx6xqY+tDDNEyJ3Dgu/g8PVUTaTZv/+lqxV//VAB3ldUcwnGh5tC9MgJ/EBFmhotaKCMOMGMyvAvc8AQUUhR9kffaM6yH5jwvChutUk4xANMJ4jQ8xy+kABBK8LPQLQqafJeVG7dkZXsUACXXn/vp0vP+VLGynCxgkPnYiPFlJpWduYW3rEN/RgCyyuWnRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxEVEtGzKZzCU1LeZGQmHL62vr+RGq/siTPdljo4SdU=;
 b=B7qItdfxC1Rsg9z1D+QhEqoe0d0uqLAUECgmZPOIa+kwepwQgypd/U9NMixg0zUMXUGUGI/cyNdC3koMcCgqIzzxvBBIgrj44TCxV+H+anS5Ehw5RN2q72gp62CPkS3O/IWUk3iUKHozj4q8/iB2KvLOuS/jkUGy8qcKYwxZ9IJ4AbNU+wKdZzIm3akf1XpAW3o95W4VyZn+6nXXM9QZHdUdc0jujyRrv+pZfFdvbWKPqxYKw63zXhteLltrjdLHPRV4uB1rlxCGkAUQh6w9sChbt4EI5eGequ/9AgoXDpGbqf21ssEu2Tj6MKdVb+N7EJav0mt0YXAHAXqakZNjBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by MW5PR03MB6877.namprd03.prod.outlook.com (2603:10b6:303:1cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:40:51 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9203.009; Fri, 17 Oct 2025
 08:40:51 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	niravkumarlaxmidas.rabara@altera.com
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v2] MAINTAINERS: Change Altera socfpga-ecc-manager.yaml maintainer
Date: Fri, 17 Oct 2025 16:38:49 +0800
Message-Id: <20251017083849.3213192-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0025.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::16) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|MW5PR03MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: c50f8f04-93c7-43f8-d994-08de0d58e09b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zSpJDDVU+FPBusqxc1NB1m2hsAeqRLYAzWhZYCmxU1TNPWPxYnqaQpMxjbIi?=
 =?us-ascii?Q?/6HkmI173Yd7MS2Y6VrXqJk9XlWOb3KY4OdBI30pAZxtYI8kmJvjUUOr9MeR?=
 =?us-ascii?Q?YWt9N9+J3Nd5rXPyBVT5pyxgevO8nzMbj26p/KZJnooIXq2raOmUaKzC6mWi?=
 =?us-ascii?Q?QI6sPBSJOZ3JAn4Xt+hwMahZqsWH0JU9O+WwOyJCQeuzwUJycwtZ/dfgvBEa?=
 =?us-ascii?Q?QPzl+iM5wyhPoK1ase3t0099nARcnqDTz47wVvRaYDQCDNFTDjYhpm/Q0e7l?=
 =?us-ascii?Q?eus/2mJoQHsndA5ks44RuY87OsNOstuZAoQO1hosnxm92+QINUZoK0GVXDQO?=
 =?us-ascii?Q?UF0wn3xJFDhlqMS7tiDXpSAe3tyYeEhdB6uVEd3lwbJIwB5C//ihwbdWJRr0?=
 =?us-ascii?Q?Es/kxX95IRmfF5MtYDJgctLjQbjBIagBfQ2SfaDx3sCMGvH4e6rfWb6qwG+r?=
 =?us-ascii?Q?wD6CqPpcYFfZHwRfW83VuUmiHmZgvyv00025blpAuqvqvDdJ9+y7H/9UTrXu?=
 =?us-ascii?Q?A7fecZg2DS61kHrcd6l/475lDl52yJ7qNkR0whQ/OCu0XmwUYS8U247deGwE?=
 =?us-ascii?Q?O2DU95h3lkBeINr6FTA0sU+TfZpxN+rqDhG0pUEFumwd/gpSzAAU/LMxHquI?=
 =?us-ascii?Q?tvs6lMlg3pH9D7FrrHnqo/D+VVn9pQpQWA8mO8IG10mA8vby9G0MkCIn8+vz?=
 =?us-ascii?Q?eok+bKeLPFySLix9DufEjnpfnrQYPZwnP7YoOVDGDjggYaaIIRZ302gdjP3t?=
 =?us-ascii?Q?kzRkVS3M9DgD8uk4ETJnhq/ncDJGxPX0hBljYw3ooKUuBSyiiKjKvhzkXexq?=
 =?us-ascii?Q?6NXrLLjNzpxqJOxK4+pSUuYmBZdpQWlPI/VYSWPRrZRNVubO5wYOUN31z8KT?=
 =?us-ascii?Q?OWrFiR6uzm4obhA6CDqBSRS94wkpaodpRH9oUkl72n8YYndJhwZ3reYYtX63?=
 =?us-ascii?Q?WNixuSS7gK6YjrucyafhHXOoFOgqLp2tHC/IOcC4efsymVylJnhH7faR7Gl+?=
 =?us-ascii?Q?WPaFWZpYgZAznyXO6RMamGGXUMTm5OfEw+HIbcMyoXbvqLOKTWqJwl+mF7BL?=
 =?us-ascii?Q?6uw74+OH7T+XfR/JkPccxmzLjZxbY/67twIPSVaG3S3igcgnxRg/lm9eqUgZ?=
 =?us-ascii?Q?TyeXhk+mncnBkqUh+cpQmQc8ucFl7dK1vYmr0K3NPLOOtaCn+w9dL1/MW/GO?=
 =?us-ascii?Q?aBBrm7lLcLHok1Bhjwj22Dht+0tj6KCvQ4b8VsUpV5gZapWmLUNM+uRbdUBN?=
 =?us-ascii?Q?5inCra7sAnYMy36oBjuF9W0ra6+b7WUiFuDg/jeET5/wofdglqBRmyBpswrE?=
 =?us-ascii?Q?q3vUS7ItVEVhPn029DTQQxrBok9180Q4WCU2n8qX8xZrDNoJCcR9Pf8q23Ug?=
 =?us-ascii?Q?+3x1LmAxA3mR5eT0WqNg3g4PInKIxtOFD8VquS6+bC3G55JuuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q8O9vndITSff4Uk+WjOx3hufARO1jh7Z+kBHz8XsmWKzJ83amzfLOb3+aMTD?=
 =?us-ascii?Q?RHnvOCKcBZUr2QCmRSNCxjNPTgIsOV3t5+OwweS3StzfOSYYpRdRSVbSULYX?=
 =?us-ascii?Q?KJbs3m7ecOVwsfZaqvSWH4KErLtCYZHHP6EtNDmpNATldA3JOeyDbs2fLbAO?=
 =?us-ascii?Q?Uacf7omxPYsTggnEVsM8632Z7KrVZNRzX0t5d7deKjgTvKW3rRUr+anutXkI?=
 =?us-ascii?Q?ti+BXT0N/MFHU+pPoLcchRTDVXR/4UxnsX8/gQCv8zlXEaQ5CYgN4g2HLBF/?=
 =?us-ascii?Q?FgZrmNxgA1O48RU8DgrLianeOuWJQEMt3NXpMM3Nlmsakb7w7QbHmkT/dG2F?=
 =?us-ascii?Q?TdPHR5FbvgxiOSBZZWNUz68QHZn3S1o+TyB82puTtU/wKT/vLM3jmNBeK+6G?=
 =?us-ascii?Q?H9OPRdNqaVVZpysmmfijDiZu4G8dh2zP6F0vRVBQeV5rSMUaA3Awudv7qvhQ?=
 =?us-ascii?Q?x7CzL4dQ1Ede75SU/HU/HekIIBPgRoHDzpzawXc/UBnIDCZ9mE86fd+yp+t+?=
 =?us-ascii?Q?M+RqkUgtemIzD8gdY44FCoYLKsYHQx7Lju7561mZc9YKJGJzrBY/e9F7Ejt7?=
 =?us-ascii?Q?NvqS4BC8fTNQF88kCSrmuaMvz5EsVPGOiG4P3f7GGMNT740LAhUIywRWwDRt?=
 =?us-ascii?Q?thLDH4Q07FYjnX/W9d/+/sGoE3I8+8YDkGexmzXv32L5v0dQwLpIhCCjmjlJ?=
 =?us-ascii?Q?korZOeXz9dvSrL0Q8g7BpwTCef4vXzuzHlwGcptncd/EJb95NWgCEb3oK2n1?=
 =?us-ascii?Q?o5ibbkwev5XbPBY094m+2CH+Y/r6G61k+1iM1qf06ChUo+FDXDtxUf0R7pZ8?=
 =?us-ascii?Q?X+EbEVbWWQCtoIX5FkfUiTk1u7Sanv1g6mYaWZ+qt653QIObL65LVcTweKC6?=
 =?us-ascii?Q?PppXtu+OVa7heFSV+0iZZ+7WDxujnQbMe52EEfTmgX+d5PSQr9jxyc7N7Jr1?=
 =?us-ascii?Q?NPgBMZKeUWLANhlKuRpaHBIRjusR12RYRTysG0FOnP17Ydu2/ORET54M9J3j?=
 =?us-ascii?Q?M94qZAFf3qrX0u6UMEC5Gn8Frm+IZIp9Xo3mfs7ENpiTr4BCkD92qaw0a9RZ?=
 =?us-ascii?Q?T1dgmT6o+7H6Livq/7QUWYdS7KZp5MkU9VsOqNfPzm8ps5QC3zXVWnyXf23D?=
 =?us-ascii?Q?yUbDRhrpqiK2XQ5BUjJewKDRNsX1QWr1+nia/ZHDQz6lwNM/BGOeRzFBS61p?=
 =?us-ascii?Q?wRO4JJtocq86v7xYwPrlQDbcvLROVjPlknJsRczzCLAKSQX6AE8M7IPvPuA5?=
 =?us-ascii?Q?tLoaKH1YMImklMKPLp/kRRnSR+WEJnJ1fHTzGW1EZMj1fR5AZ+JIpYZIL0KU?=
 =?us-ascii?Q?9xMvTyKTAlD+fQu3fVmMn9iz8nDBo/O1Iq3YK5ALegMnWcM5/TwmhaUsKEhG?=
 =?us-ascii?Q?fExg1f97BsDdFyIHDiruOLj5CrRrS85dWBjeHGFopY/GLeUQvByjVozni31L?=
 =?us-ascii?Q?CXE4swrIWBnqpvgtFNvaDCpKeFe5msmr8fyPnNS7XH6fdl/1QX3wXnSl6qaE?=
 =?us-ascii?Q?68N6CciHCDjqzhlLLvXNLrBT/qFOS8ZyfO7/WnV+t6w8zTpotAs1mnCk8Jfr?=
 =?us-ascii?Q?bET8/hLOkf+L5PMVABzK5OdsllKWDEh9yimZ+ca/Mhf0GHHUfm+Fzz3AXdSp?=
 =?us-ascii?Q?FMMDpyS9SmPmwQIUpBbsx7+KLCSSA74rlgHgY+RF83YW?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50f8f04-93c7-43f8-d994-08de0d58e09b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:40:51.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KasMTxWkJS4TWFP43ruUvB6Vp04+ofSgbmshAk0xsjpFi1Y3nhAW6U6C+PZf9JsnaSOzvoq5xrISp+cBU7YrcullE31fzvjgVRsja4XxH6B38PweU5nAUPPGRDuZInk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6877

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Update Altera socfpga-ecc-manager dt bindings maintainer from
<matthew.gerlach@altera.com> to <niravkumarlaxmidas.rabara@altera.com>
as Matthew Gerlack is moving out of Altera.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Acked-by: Matthew Gerlach <matthew.gerlach@altera.com>
---

changes in v2:
- Update maintainer name in yaml bindings as well.
- Use correct maintainer list for patch submission. 

Link to previous patch Acked-by Matthew Gerlach
https://lore.kernel.org/lkml/91cd7ccb-e821-48de-8d52-f8889af80a08@altera.com/

 .../devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml      | 2 +-
 MAINTAINERS                                                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
index 3d787dea0f14..136e8fccd429 100644
--- a/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
+++ b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Altera SoCFPGA ECC Manager
 
 maintainers:
-  - Matthew Gerlach <matthew.gerlach@altera.com>
+  - Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
 
 description:
   This binding describes the device tree nodes required for the Altera SoCFPGA
diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..516e983a064b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3402,7 +3402,7 @@ S:	Maintained
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
 
 ARM/SOCFPGA EDAC BINDINGS
-M:	Matthew Gerlach <matthew.gerlach@altera.com>
+M:	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
 
-- 
2.25.1


