Return-Path: <linux-kernel+bounces-891730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4479C43564
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4780034875F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33C128C5AA;
	Sat,  8 Nov 2025 22:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FqkUI+oQ"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599642848AD;
	Sat,  8 Nov 2025 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640692; cv=fail; b=vB2r0ahb979k/CZBAI1HofkuuFBWVvKwXMg+DCVFjL1ls+c7nJLwPkO1/3QPJ81L3Nf+qqjPaEpagg4fjanmFtbqh+/RxebwdQnjl2cvMi+m2uvPxtfWQF2vJB639qaXnFLxLPh3y6LpH0tjxsSYFi5ImrC4S++qn2Y4HNqRCnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640692; c=relaxed/simple;
	bh=ez6m14NrbQgP5asreKZj28vUoRTOpvGUdWrmSHeBvMw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EbtPcwzsA3NliGqiNCoaJXYdYXqxKq1vAtY5JsV5+jTD/GB73mWq+pnJtkomwvfh+aQ0Jzu/4BqTlQVMKG/CUmebA4d6fMyXSZBj0m6ZjZEuS/cMmS+XffQw/xrbFbqGL5Iu1nIAnqwivJbpsRNpBZBINXY6NbYWnZJmrFSBCqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FqkUI+oQ; arc=fail smtp.client-ip=52.101.43.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAv75Bk8sTwtZJkeFO44gzBdYqL8UF+umMl6gIqY/tjIOdmUGYoL2U6tB5WbhaJAwBii8/DCSJm4Bo2jNADU0GlE+GG77D4zoqrLEQXruQvkrsKxD96rRpjWHVUMjQqwAf9wvUFXf1jyXTJR2+gHydIeo23vzCo3o7sKaKJR8Vrvof/tJ+14O0cgBD1oGSlM/yYyQAYvfTHXZBbKfl77fe4oypu7UP+LxS3sCKdnQTkraUMR0qKJpv46jbidAAxLcreTzU7wuw8Ezi2EDw5fKitK3VY2OjO3j2pOBzheoTdPbo6OuMXB2TPT8Reh/asjljh4PF3ct7mkxWyYuqRI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRos5dRZWzfftA4ydsZFZv23NCLcVEGCG2a94btnu3s=;
 b=ll0yOV27Q8YWQNmvv0hnixZplcFsKGEMXxXrGC24+zKBgZGYnlo427OtOXMWO8KIduT2EWxYG6JilV+HtRbtDKXu3SBgTUyDgZcAGMIUMc9wVqv44IBReVVvpLuZ3W2hC7mIliBdVHX6lYfNgwzLiJ7I4wrljMyyD+h/74TOsbKhUzehSwb1GIjPIkNNbTjylKvU0EnXTh1AblweF+qGneSxfrK6brgEfVi3UDqZSslMrtOpVgAc2txqznrZqXM+kgDn/SbxqZBXkyqmlO6IkYfNO7F8sl37yssDoLu6aWlyOntaPmfNMtP1Y3t3JibwMBQ6lkhkP3AXq79dPvV6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRos5dRZWzfftA4ydsZFZv23NCLcVEGCG2a94btnu3s=;
 b=FqkUI+oQWKnqRHUbrMNXVISGK6DZNLJRoUgK2jriZsOyumLWRM3YZzuspNJIjvhoJfFwSW02vkuJf/tq9C2IL5+I+ew9GwZdLU7P/41D6MV0pQ198l0zxqOxdaDj8emkd+ZhP22ZOfozADJEE/iWxc+V2zKRv2Go9zk02Ve4oYTBskLyWBDlStUbAFeq+m1tOUsl8G+sUWOAVe0o3jU83Zy553j9EYmLRteW1wsWuu50ZgscuFMvWHUCsuX0q86bw7KysEKoT0iAvstPN3dTwqqMsn12QMFXqu/8dgTOGaJ/DK8QY0pZLSt+HeeaJh9HOp2e5VmkeQ4wZs4cSF/44A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by MN0PR12MB6056.namprd12.prod.outlook.com
 (2603:10b6:208:3cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Sat, 8 Nov
 2025 22:24:47 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 22:24:47 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Sat, 08 Nov 2025 14:24:34 -0800
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: Add Nvidia msx4 board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-msx1_devicetree-v3-1-c7cb477ade27@nvidia.com>
References: <20251108-msx1_devicetree-v3-0-c7cb477ade27@nvidia.com>
In-Reply-To: <20251108-msx1_devicetree-v3-0-c7cb477ade27@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762640684; l=928;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=ez6m14NrbQgP5asreKZj28vUoRTOpvGUdWrmSHeBvMw=;
 b=2N6ubbaH/3ksIJhiS/Pcs7NNl0bEoMvgL3/IQNcXuh3NB3mcKD45dGdKdMXFf7NfYA0jaGUum
 cUGVLQZZQQIAgHFl/F4xhWk2b5lEFidCDYVRZg0Mz1Vp0GEHTs5OLWr
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:303:b8::6) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a23416-a3e9-4c8c-a27b-08de1f159ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDhlUCszaFg0Sk5WbXNPeTVhamdYSElnY1NJb2doeDhjb1Rla25wM1JxdVRz?=
 =?utf-8?B?Y3JWelBIVEVQaFRLbDlKalkwRjdZQVdyTEhUa3BwS3dLZU9kaFY4WXZ2dTR0?=
 =?utf-8?B?TzVxSmJUUDM1SXJERFJFL2g1aW9CR2dMWUFMRjgyQzhBMHhTV0poTmpydDh4?=
 =?utf-8?B?azVaRDRmbXZpTTFoRys3MGJHcS93UlZvTWQwWTVxUHR3NDIxaEhENU5JT0gz?=
 =?utf-8?B?ZDByQXBVV2ExRWdua0o4MXkwa0dBT1Z4WDBjNVpQT3kyQjNEVU1GOERkbFpx?=
 =?utf-8?B?S2JlcXljdS9GR2hENlZSVWZMUWFvRDBuWUU1RlF4bFBsb1ppcnpUV0xEdTlu?=
 =?utf-8?B?OUVCdDJpc1lVcG9EZlMwakpzakF5MmZvMTdYN1p5bXJoeW9LSllZNi9JK0hF?=
 =?utf-8?B?cWVkdGVoNlBUaUNMd1JYaXY4cnlQYjBKaW14MU1MTytlSjgyTll5MzQ4b2hw?=
 =?utf-8?B?QTdRWEdxN0M0dWpzNkpqM29JMFNvM2dOTnpzVGdFMUtwaGowUVhKcXVaUjZB?=
 =?utf-8?B?NXJKZjlEWWdDNTE2MmRRMitDWU0xR0xBeE9qc3h5cXVqMUJoN2lDbVJVeml0?=
 =?utf-8?B?ZnBBdU9mNncyVWRPQkQvUHhGQzE2aW12c01jeTl5QlN4b1ZCNjM3V25OQU1s?=
 =?utf-8?B?TlpLb0pGMUpGK2VwQmNjNFlucUZjRFdna0ppWnA1RlQ0V0ZaS3Z5VWhXbVRJ?=
 =?utf-8?B?TTRRZUp3dWc2Tk5kWXc1QWxQT2tDT0V3L0ZQVkloY0xXVzVrRm1mU2drYTBQ?=
 =?utf-8?B?ak9IZFY5RjZQYTE5WWJQWmsybHVQdEFjaloyRng3TEExcUhvN0NYWXdWYWVQ?=
 =?utf-8?B?djJjNTh1VzA4TXNUUkVyYnhlWFZPYVkzQ2FQUG9CUis5MlJYVFMxaW95dWtU?=
 =?utf-8?B?SE94R3VBbzZaN0hWQmdhQUFRQjJJOTJDTThPd1hlMDRzYnFNWkttTXhqRGFh?=
 =?utf-8?B?bW5waTVlQmthYXJ6eGg2ZEl1bEgwV1N2SjhFNFBZODdUUE1kRmsrV1RUMXEy?=
 =?utf-8?B?ZytETmdVMC85Uk9jTkRENFRTRVdIMVBoMnlhZ1dPVzF0OWova2xzdFg2QkRC?=
 =?utf-8?B?Mzlpb04yMmpVam5WWlg2bUtSdTl5YmkwZmxLMWxpbHRiL0NtNTdaUUV1MERO?=
 =?utf-8?B?S3NQSDZocGFwZ25oR2h1cjkwSjJDdzIwYlFTL2NrQ2o5QmZaNEN5MzRnSGxv?=
 =?utf-8?B?Y0xYTG9HUHRYYnZOUVQ3TDh0WUo4cE54ZHpaYnp6SzMyQS80Z0JiUkpUeUpO?=
 =?utf-8?B?YmNON0JJc1V1eVliQ2ZBcWE5UzYrRDQxUlhDU2VPVFhTaDBpTUkwamhobzRq?=
 =?utf-8?B?bW82WXU5RGw4eGs2YnNWRkRiOVI1bTY0Q25pUUMyaGpNNVVuNjA1clFzNEdp?=
 =?utf-8?B?U2pNWUZRNFE4ckgycnlUZVo3ZmxBWEY1VG9IL1hUQ0czR3NOZ1RtQVhIellK?=
 =?utf-8?B?N0Y0aGdScUZjN3pOL21yKzBQNzlIbU9PdHBEcGg3TGJuTVcvOEVpbldpQS9a?=
 =?utf-8?B?dDMxcHpkTXdTcEFaTlNMM3VmSnpxWGkzV3M5c1NQczRjZXkwVjhXQ3pHSmxq?=
 =?utf-8?B?Y1Bwemw5Wm5XNjlsdHg2ZHNCbTF0cFhGYUhTSTBIaGNkZ3ZYMTR1T1NpWWtr?=
 =?utf-8?B?c3FFanY4SE16REdoM3FKY240THl1L3lUbzcwTmpJWGJ1T3FCeGtQOXNNanFo?=
 =?utf-8?B?YjJ2anZ1N1ROUjVOZG1zdmZDeE4rak5xZGJNOCtzRGdaQzg3NnNUZEFIdDJI?=
 =?utf-8?B?U0hsdHZUbFFtNVlHZGJaRUM5cnFQSkJvSC9KeVQzOWxZa2p2Y2ZCZWFCSzhr?=
 =?utf-8?B?d1ZWT2RQT2tjdHZLcDZZNGtLWFE5YXF6RG5YZnRvZDc2NUJ4S1UxdmdsZnFK?=
 =?utf-8?B?S0F6R1V3dSszbWtlWER6WHR3c2tOUXh3d211eFFrNUlObi80NXlRQUlYbGl5?=
 =?utf-8?Q?bmVi4BmgDKLcqcpaSZ9nRDilVe9Pubb6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REJFQ1dKSjRyaTVXRTJBd1F4V1lFa3c4dms0bkl3djdCTFAwRVFnQzhBSzdS?=
 =?utf-8?B?cDJzT2dmdm1JZHNWcS9kZFFRVWRneStITTRldkFHbTkvRHd0OGYramM4Wlh1?=
 =?utf-8?B?MSttNlArY0RkaEQ0b3NaWjFDQkxYZVBLQ21PY0NIUGdib1BtL2lWRWtYbENl?=
 =?utf-8?B?QlgrdkhlQUxOTkdsaWJnWHBZenZWZkZPWXhFRlJiRW4yVnBidUlCQVRwSTBB?=
 =?utf-8?B?OFJNeVlDemRpaFQvT0hIOWtLWGNMVHI2bEhjcjFTSDhUSThaNG5hYnUremtQ?=
 =?utf-8?B?THlQRE4zNUdKSmI4OU83NVFVZ3Qzbk1qL1Y5SWRmYndDcHhVZlB6TDdBL1hB?=
 =?utf-8?B?ZHRGTzlHUkZxQjYybkhQckFtdzNRQkNwQTM0c2gyYlVGMFh1Q05ueTlybnpo?=
 =?utf-8?B?RTZOOVdaNE4wTHZncDYwZ3pMUHJYTEdhVGxQN0poTnFQT3M2TlU4K1RGYWNS?=
 =?utf-8?B?WEVJTFNmR3JCOW4wZFlEZXpkbyt2bWxCL2JLMHFaWCtIdzRQK1lJODU0V2tR?=
 =?utf-8?B?VURMZktnZGxkbER3RUovMHNqMnNXQTdSRVBMT2xtbkthbzBYMkdacnZMbEhJ?=
 =?utf-8?B?REZGRzR1ODJ6emR4U0hTSE9qSDkyOEdHeFZubmUvd1E2cGxpMjluYVdDU1ZI?=
 =?utf-8?B?akNGZHVTV0NOZTB1dDl4aEJ5V0dqTGwzVitTSEU0cmtxZ2FsUE0xR2x4Wkov?=
 =?utf-8?B?TWF0TFdnNFFmVkdZK1N0ME42enNVK2tMY0xpcUhwYldLdE54QUhmM0NBRjhs?=
 =?utf-8?B?ZHNYeW9ZMkY3L1FGak1jVXpmK0N0U1o3V3Z6MXhTdDJyS1g3K3UrWWFrMG9T?=
 =?utf-8?B?VmdnQk8xWUZXc1pTQk9oT1A4WlJBYVBNMFhvWlJuNUhnR0tRSUxuNW1CRTJl?=
 =?utf-8?B?TGJwSnB6Rm0rV3pLcHJSZ3BlZWNhT2JDUGFEMTJ2eW9nNVJ2T1hhcm1iVGQ0?=
 =?utf-8?B?STJmT1BONllVWlIvVHhVckw3aU5PMkhUUGpRU3hLQjVmTHpZby9URjVTaGYz?=
 =?utf-8?B?TkVSTnZLdmxuSEtCek4rWTI5VHJNODFQc1V6L1REVHEzUVFNZ2FWbkFVQjI0?=
 =?utf-8?B?aExBbzByNmpsS2thdk9LRitCNWRmS2NZOHFqeTNLdkJjaU4wbVZ3SG5yb1Fz?=
 =?utf-8?B?MTNiN0Fjd0JNWmQweG0vOG93Y2MxcnpodVJnUGVHMEVlRDRVdzZPcjluVElw?=
 =?utf-8?B?Y081VzczcVNJcERuTEtCQTNud3BDTWtuVXFyNTVXenBhWDNQUzk3WDNBbE9m?=
 =?utf-8?B?NGZIMklrRXVQV1R2blJVSVRZVVFIQ3BwYjAxQUswS0g3cTJydEtsdm9CQjJq?=
 =?utf-8?B?MWxtejBsSTRPM1FGRmFkb3BtUUNKY0Eyek0ramt5V0JNdGpraVg2MU9VN2RE?=
 =?utf-8?B?UTYyZm5MalNqWUtReHVidjVtVnBBMGJ1MkRWVG50Tk83MGk0b1lXUDVjUWdD?=
 =?utf-8?B?OHFFN0RLQkNvQVM3b1BuN0JFV3E2eVBBRkpHMEs4TnZvcHV5ZmxqNTE3ZGhR?=
 =?utf-8?B?YjRDL1dCb2puNTJBZkVvM2szR2FwQU9TNTZtYkNlejFmZU9yOFlKQzNXOHhL?=
 =?utf-8?B?ZG5uUzFXb2NVczNWamZvSHpsbEorN2JQVk5PbHM4bHRxVXBHK2oydTlKS1Zr?=
 =?utf-8?B?bzJtNnFoUi9sYVdMTWwxQmhkeVhjZnRWSGhlMHgyZ3dkVi9EWjhSRmxWb3Vz?=
 =?utf-8?B?WEJYRnZ1eTk3QzZhUmZBTDhZaWRCNnhSUm1Tcy9ZS1NGM1YvMzBnck9WMm83?=
 =?utf-8?B?Y3FuRHdDOGdKRnRjL2FxbFhyZHdUaEdESVBhWldIaEIvcmNKV3ZOaEdYZzJx?=
 =?utf-8?B?MUI5eHRVaTdUWWZZdWx3aENRZjMxdEdFLzRJTTJLcVVhZGlBVzFKMXdaUXVG?=
 =?utf-8?B?M05HWUF6Nktnb1BNa3llaVNzTTVidzZqMzk4bG4yWTNXMjJQTFI0b0RLMU1N?=
 =?utf-8?B?THMyM2QvQW9zOTh3d1IrNGxpNWFObHExMnVyODY4OHltN0Zzdk11RjJCVzVo?=
 =?utf-8?B?VVNGbkhJdytQQU16WlNQbVg0RTJKSGtwRXZ0Zzh1WUY3MUVtSlp3MjI1WTZU?=
 =?utf-8?B?bDRVMkR5SU8wbTlQdVZ0MFRRUzU4KzFTTkRydFVZWkJPdkc1a2FMT0hBeHFZ?=
 =?utf-8?Q?q7zCWfJhjcV42+NGmLoIM2RXt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a23416-a3e9-4c8c-a27b-08de1f159ff8
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 22:24:47.4439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2su1UfEk+CX3n2YRGIHp0Oh9tm7c4FcPzardXRrbRgxmRmhZFyJYoRvZuuj+pJA5Qob6P+iB3TCgyzvJUcr0nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056

Adds a compatible string for NVIDIAs msx4 BMC board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a80b5c9d14098b60ce277391fcdcb..5933eda3371b33f16a1129cbb84933c1393c9b2a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -104,6 +104,7 @@ properties:
               - inventec,transformer-bmc
               - jabil,rbp-bmc
               - nvidia,gb200nvl-bmc
+              - nvidia,msx4-bmc
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
               - ufispace,ncplite-bmc

-- 
2.34.1


