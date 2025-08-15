Return-Path: <linux-kernel+bounces-770370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7AFB27A10
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA90CA2844A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA382036E9;
	Fri, 15 Aug 2025 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IKnI5tOD";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IKnI5tOD"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0271862
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243063; cv=fail; b=uPn+/28ZxrRch0q+gUe469WKvxKtyQIW4tRvqjc3sU80AmlvjzBPUK4nmgiYNB4b4SITSE2xoMRcoEn9hlwrLvqUYGkn9CaDvjrVRLpqDt0FvDoo4UevRPYMel1IS1XgntITrUdAqHpdu0TeAo12vi7F1FG9T/7en9w+rEKhWk0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243063; c=relaxed/simple;
	bh=6o0Hh1AsROLzRhowyJt2OYLnFd+PPOad1H7FumCzl+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jn8ivr5hoLe8ROdhA6himt3GRDALNQN+/8aZhgIRINYvYQcG35AQ1gUXyorm4JUSKAM3HZB7ISAb0U+kKk8Nxt61rtczQ8PuR0zaWnKCnScPl8+1KMyVsQH6DF2yeUGav4sLG2oPkCWoAg4X6Y9qdvR++oRi2ImzXhR6nyrIORQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IKnI5tOD; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IKnI5tOD; arc=fail smtp.client-ip=40.107.162.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ORTCi0+KQgZflKCz0aJD7+UapdYaCB7L8LlPeOjjUUgiKAS9Gwd2tqCfudsxdbUh56iiDsHiz8tngQ1ACy0CNB6AQFSdWHKT4wXECAZhpsQfqNLLMldi++7oyBXXbKDhozvwaNNU7/SCp2FTE+ZJqP9RG3dRQhq7yucAr2xuLRYWkKZ5SaN9ZynjCqjAXi8E/maTQl06KYDcXYJ5G3I0DCuHbQdQm8y+JPqGrPgYsPw+CNZ7cyPdkgKXhRf1qhFPiVmPeghjkdy218Xo5+ZhN/a/+ZN+PbWPdI5zZcxdItyNKqzUYuqNYJRCY2ri7mTgeAt3XlGryjwzpTdXzUxiVQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w9KRyHPfSRp7stYEz4TEqFbuZZZwAP/LQ2Zsjcnkv8=;
 b=MAKDMV3c6uOEIro9jNtl5d/BxzJ/w5P43dJpjgnRWpdhtMdEyvyQpx0iZRSUDhCBj1z7e/eMN3AlWK9I9lIjIMoA2JR9+uPiOtnm3zfgCxYEUOdLp14SPdNeJ+PcBuKaPMS0b4JINQ06cw76gkDvARYieR+tDGcccGYMlxKBYIcjgvnN/3EUWDyIXIeeNL8A7ET+5c5oRjLNll1sSxNbkCzgkmyEY56RITmaBFnZvjUu4YuEw0C2Ltw+VX/yKR0t2BlwbGobwhV/prbM+SYzHGaORr1dSTNxSrtXhsNwd/RJNGq3iPpczO4zB6yMdWvL5Cc6g7bc//vb0Oe1zEtHmA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w9KRyHPfSRp7stYEz4TEqFbuZZZwAP/LQ2Zsjcnkv8=;
 b=IKnI5tODDU/T+Utuli/qK7Un4h14MB1KP8miwH2Aj0GarHslhhOKCnvClMnS+kH/EH05sjaDIzY1k/r+ub1sW+JL4fpmG3aWbICoJyE0scCfE+b/UbQTHbN1NqbmlXTq2nalR+nCjTb9Yxg/aQjMkdaLHJEklUTYxgKmxyNsdBs=
Received: from CWLP265CA0516.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18c::11)
 by GV1PR08MB10534.eurprd08.prod.outlook.com (2603:10a6:150:160::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 07:30:56 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:400:18c:cafe::ff) by CWLP265CA0516.outlook.office365.com
 (2603:10a6:400:18c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 07:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 07:30:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBrQLkE9jUulG2SrQRfpEOi10xSQttRxJYTuoEQSNKn/jTgENi56OSBmvZ23tQumCHYwCa4Zm6qMAFGSsv6E7gqIO3kG0CnlB9i50Xotp3mMwCzwvOowj5x1OVRiioDYrwHqol1kCwDBeGypvhqUyXd4ViahxD1Ud4PS5fFOFr/3tOa9DSi5n/HWYYPud6IoEfLuXrbRdFlJJCPyybptYlENuS5gMkthRAZyc123DR03JoOJcRLbNYA2E4DRE8toqQeNkZPfg4ordcvnFCj2CFFWSkEq+TMtnzX21cA8fuz7qh7PH6Af6aY01UdWnkO8acK+nl4Yi8vTcd8KYqSNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w9KRyHPfSRp7stYEz4TEqFbuZZZwAP/LQ2Zsjcnkv8=;
 b=MqCGrlSdl1Hgr8x3gB5INYzYzJH3HVtU4GkJ4CU2BaNa5EL73axg/JwtqNZTXYi9LRbZDLMef2ZruIAWGP+xv1nvLzXOLQtzQR3oqf4athSMJmVQGBdQLzp7dqqTXujwGvFiUS/rPVv8AWCxLwr2MarSnz5SvirERDZhm5i3J0GtKpYftzB6jATRjQRvXPNTAEL7jc1cQU6gtI54oHCMQxcqq0B5LAn6Dye7rMoUsg0Hua8wH67Rk/KTnhflCAsJ+PiPDGs4OKczz982mKMvZRxSqnKCpCywMmNihUtRSuggNexJ29jlo5fMQ2wiY7Db+ut3b5u6zEoHVF+GqpsMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w9KRyHPfSRp7stYEz4TEqFbuZZZwAP/LQ2Zsjcnkv8=;
 b=IKnI5tODDU/T+Utuli/qK7Un4h14MB1KP8miwH2Aj0GarHslhhOKCnvClMnS+kH/EH05sjaDIzY1k/r+ub1sW+JL4fpmG3aWbICoJyE0scCfE+b/UbQTHbN1NqbmlXTq2nalR+nCjTb9Yxg/aQjMkdaLHJEklUTYxgKmxyNsdBs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DBAPR08MB5749.eurprd08.prod.outlook.com (2603:10a6:10:1af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 07:30:21 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 07:30:21 +0000
Message-ID: <683f9f4e-c027-4165-a8aa-b561e304e132@arm.com>
Date: Fri, 15 Aug 2025 13:00:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64/mm: Allow __create_pgd_mapping() to propagate
 pgtable_alloc() errors
To: Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>, Joey Gouly <joey.gouly@arm.com>
References: <20250813145607.1612234-1-chaitanyas.prakash@arm.com>
 <20250813145607.1612234-2-chaitanyas.prakash@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250813145607.1612234-2-chaitanyas.prakash@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::13) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DBAPR08MB5749:EE_|AM4PEPF00027A5D:EE_|GV1PR08MB10534:EE_
X-MS-Office365-Filtering-Correlation-Id: cc327cae-ad13-4167-a83e-08dddbcdabb5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MlZaNnVLbklLaFIrbnFzTGU5bGh2TVR0dUtaRWVjNEp2eURqVnBsNUdXY29Z?=
 =?utf-8?B?UGR0aEZmSXRwQjNWaktJTTR0cElwNG1lVFFvY1dPQjdmVWswL0tLUmVPMW4z?=
 =?utf-8?B?WFcxZXdHcXFpcUhubmVOOVlvaWxZdFA3WkN2WHhydi9MaS92MWNUV0JWRExP?=
 =?utf-8?B?VWxHRHNUUk5FU3Qzd1h2dndqcEpoVngrWFRGK0ZsK3pLZ3VLajRZU3l1NGdv?=
 =?utf-8?B?UFViT0JRRzhIQzZaV2wrY3pNUE1ELzZmMnp2cVJJUUIzdUpTbzBscW5RcTc4?=
 =?utf-8?B?emt6MnJ4dkl6ckZnSk1MbFFGeVFBMTc3d05OVy9NNFlqS3JXOURTQkFpdjNq?=
 =?utf-8?B?NlpEaFZuc3lVL2pMVlI3OWdCWHdKY0w4anY5Z29obnpsQkVEMitVcnNZTGFz?=
 =?utf-8?B?aU1rbll6enZzNDJBYm1KaTdpL2FaamFHeUxjTE8xWXFlbU5PMnltbzJ5SE5K?=
 =?utf-8?B?ZGpTY25KdjROVGZTY1VMTTZ1MkhCekhxNmJ3dmtrcDdPWVpXbGdpQmFLQUpV?=
 =?utf-8?B?ZVRhanFoVzJkd2FBSUIzakJUK1BUZEhjdDErTnJhSEpsSE53RVhWU3F2Z044?=
 =?utf-8?B?RHRiTXdEM1l0QVo0QmQrWTFkcStqYlhmTzV4UDVzK2V5cjU0L1R5OURzWGpT?=
 =?utf-8?B?ZnFyb2hDS0JlSTNnLy9GK2dJb2JWWTlmMVRIR3V4OTdSQUxGdDNtRVVQTFJR?=
 =?utf-8?B?cEhSS3B4L1F4TWs5RDRtdlc1MkI4SFkzd3NmN2xTTDNQSEp4Ynd2VHdWUUNP?=
 =?utf-8?B?YXFFakgvb3pYbWRlbU9peUNEOXRmSCs0ZjFNcFduUzAwaGRGMWM0L2czelZP?=
 =?utf-8?B?d2tSMUtvVXFjSitVUHVTdWoza3hlQ0tZZGh3cTFpRThVeWVDWlVObkpIdDM1?=
 =?utf-8?B?anB1aDMwQXpjTjdaVjVDSndXMVV5a1lkM05pd1VEUlgvV1hTYUFiYmdjUDVl?=
 =?utf-8?B?Zit0L3RUM1JRNWtudkJHcVNuSktMekNzQytQam44VnB0a29zRDdaeGdCRlNr?=
 =?utf-8?B?dDF1TWVLcmZzN2pXSXBIeDJwVmcvZW5IVWpndlBLRWgxejE4TmptSWJ4SXNy?=
 =?utf-8?B?QlNNc3FLSEdPRjJKTVh2cERBemJZTTVnM1hwdU1qdk9DT1BIYjJwWFhNUnQr?=
 =?utf-8?B?am4wTjRwdTBFWmNZbVVySElnc1JGWEp5S0tPejZyQlNjNXdnb2p0cEljLzha?=
 =?utf-8?B?Y1Nqc1FrcThOT2haUTBKN2k0MjB1RXNVWlNoMCt0VWN2VDhMcnZ4dlZVRGhZ?=
 =?utf-8?B?NVY3ejJJRWdBOGZIWk8rNkJuaXJjclUxTUt0RXVIcWkveVFXRG9DTTdWbTZQ?=
 =?utf-8?B?bHpkR2VDeVFkblhSWTNpVktKR1hXYVZVREVwUkM1cVZnTFloNSt2OG03SjFV?=
 =?utf-8?B?akx2UC9tVHpJb2ZXc2NnZklhSkQ4cUkzUDZUQmRTb0Y2WUpiMlFLZnNYLzAy?=
 =?utf-8?B?Z0RkNWVSL1RTNFdnbVJ4SWt4L1BjSHFZREpWQndPWkdDY1czT0VibGY5Z3Yw?=
 =?utf-8?B?L004Y1JXT3ZvNkhoUW0za096bk5OMVBkUVEyc3BkZjhIZmNjMlB1dXAvU2Ru?=
 =?utf-8?B?MEdMQzRnWnpQbGZydFNvQjNSbUNTaTJJay9YV3U5OFhVajczbUV3emdhL0tU?=
 =?utf-8?B?YUxrNDVnN1R4WnhOVDBaNUtERlcvUzdPbE5IZFY2OWowQnowRlNEcWg4UVhI?=
 =?utf-8?B?VjBjOHFSVzc5dmJmM0Jja0l2Y2ZvaGpsZUdWOHMycHdLVGc5SmUyRXlEdmM5?=
 =?utf-8?B?NjUxVGk0ZVZiZ1Y2SHZqaENMMnVkQ2ZnK1FtUkVvc0xEZG56Uy9lYXNSdWZ4?=
 =?utf-8?B?TUdIYk1vMlc2dlp6a3ZKSFJrTFJNMGN5bjRabks4OTBoQ3FkMUxYTTBDV2Nn?=
 =?utf-8?B?cHF1V0F0M1NKd3FQRnlDd0dKeW1jQmNrenNnK3JnZi84OVE9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5749
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	81771270-64db-4a38-e648-08dddbcd973d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um05akJwcnNtNzIwdlZYTit3c09jT29vQUNtY2ZGUjhNVzJnK0JsVVVtaVpD?=
 =?utf-8?B?Z1lzRlUzVHRjMlBBM2lCdzFYR2tyVWtUUStsSndGYStoUUt2M3NBWkQ5Z0V3?=
 =?utf-8?B?eEJreHF2WFdleGhEVmlBRlNCWnJzdW8yMnh4VjJsbmFGKzQyRkpkazU5TkZr?=
 =?utf-8?B?dG9SZDdZY1hDZ2pRMFdjTEM0MHpVaExhVjE0a0JYRThsWkQwZnU0a2ovYUNi?=
 =?utf-8?B?M3g4Z052ZlRXMmQ3YUVpclZacTZqSEJXZUU0dGFZamFhYzBvdlpFNHRuQ3R1?=
 =?utf-8?B?L05kN1dvTWxDS0hIN1liYis1U3V6UkRqdmJZSXh1SHNSbFZlUkw3UVFaeExY?=
 =?utf-8?B?R1lCWTI3MEZYYkt1dG9vSkVQQVdqeGttbmF5cmZoZmdMalpzR2ZhcGVGcXJu?=
 =?utf-8?B?WmJMdUJFc2lrWGVXR3RIbHJ2QzRDb2xadmY0VU9iOHphbWtaQmp4N0hPQmhZ?=
 =?utf-8?B?SC9ta0N1ZmQrV1dsRXhxVTlTVVE3ODJXamdKOS90d0c5cDc1TzlZZW8raEs2?=
 =?utf-8?B?SjN6Siswa2dTMXJ6TGN0Z000Q2o0UzgyczdVZmRNVmhKbDZTK200bmg3citN?=
 =?utf-8?B?OEZZSjl0bElhdzVROGJKcWpxK1FLOStTdmpMN3lyRDlVeURycStDc3pqVnBh?=
 =?utf-8?B?d25RYTMxa2dUYjlPTXd0OFI1U3pqRGp3aEJSQlNHdzBTL2RJT0RscXVkVmxS?=
 =?utf-8?B?c1NzYi9rRmhSTlFPVDJ2NDhGOUVKNXg2UDNPS0dVelFqekVWcFBCWGRqd0Fu?=
 =?utf-8?B?bHk4UHluZTRIMVhObzVWU1BHdmpXRlhwR25wLzR5MlNXbFQzRWpwYjVXNDBF?=
 =?utf-8?B?N3hMSlpnelNkcHdrZllrNE9LOGoxbXZsYUR5VE52dTBjTVNrL3NNT2w4UXVo?=
 =?utf-8?B?MGxEMHBHWENqZlBaQk1sd1dIaysyZnoyUFFjOSt5cGRXbktDQ0R6ZWdlb21X?=
 =?utf-8?B?NGJncVd0ZkZObEhVcUJhL3p2SlA2VVA0NmxWSkIwVFM2ZFpMYlJ3MGhjVUtE?=
 =?utf-8?B?ejcxVVRaUmZsaDlVYmJQSWpMbnc0cWNCeWc1ZDlPQkNyczFBSjk4aHFBSi9H?=
 =?utf-8?B?OEduZDRIUUlSeTdMcDA1U1d2OTNMemE2Y1UwbFUwMCtocUY4czJWYnpxNUtM?=
 =?utf-8?B?WmE1MUJzaDhBS0VldTA0UW9NWTVwdndYZ2x0QzBjOWpBc1kvemRpNDhhNnNX?=
 =?utf-8?B?ZDVsemUrbEtuOXVuUHJKMlhJVENIRVpJQ2NXUWZHZy9ZNDJDbzMrTm1PZDk2?=
 =?utf-8?B?eVNqWUc2NlhjZTlLS256djluOEJvRmFlVEkwMzc1RFMwb294bDFhbWVCYmtz?=
 =?utf-8?B?MkMyaEtUaktUQVdDaDhmVHhzSHF4b0hGZUgrNGU3dE12QjdYci9FQXEzQTla?=
 =?utf-8?B?MHpvQ2J6dVJLY0c3YktqdmNpc1dPcXQ4S3YweXFTOGh2bW1pQ3ZZM083Yk1m?=
 =?utf-8?B?QTc0Qk9za3c5Zml6T09oSUp3R2xxbVZZTlNoWXowYU0zTmxJT2FSckhLeUEx?=
 =?utf-8?B?WnNrZFlJNkhQeFAvUnA0d2lIWElmMmZBQngyVDBHZFdHTkhXZkV0d3hLeWtH?=
 =?utf-8?B?bWxkUzZISEdhSFhZQUg0T3FZeG9oYkN6RE5QY2V0cTZkUWtJV3RoNVRLR3A1?=
 =?utf-8?B?KzJKZXlOV1NYSWUrZng5MWdENENHRll0dmNtMndUc2VJZCtzNndOcHdMbjRJ?=
 =?utf-8?B?VFhSU1ZxOW1HQWsvd3d1RFRTZGNMcG9rOWRzTG8wdjd2VHRoUlRlVDFCWFhK?=
 =?utf-8?B?SzYrYTVWUFpKeTBCbGNHcGZ5dXNkMWRBKzBrOFRYYXBFaW5pdG1hMXBLMWE3?=
 =?utf-8?B?eXUvMGo4OVU5NDVDczE1MW5QQS9QVDlmNU5wQTlPYTA5UEtySkZ4OU4waUcv?=
 =?utf-8?B?VVhHa0xwMFdpRDlhRnJRb0N3Y0RJRm51d1pxK2hsdFVpV1Bka093LzdEMWZz?=
 =?utf-8?B?aDdYQUhPMEhJb09Qcm9pSmdSSHlNeUNhWW9vcnNGeWFZZ0pJTDY0YjBORkpK?=
 =?utf-8?B?RkhDaVRqY2JjWjhGNGVBVzliOURORHZuTFM1SDVnU0xQaTNYOXZSU3JCcW9i?=
 =?utf-8?Q?a/6lIe?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(14060799003)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 07:30:55.1139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc327cae-ad13-4167-a83e-08dddbcdabb5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10534


On 13/08/25 8:26 pm, Chaitanya S Prakash wrote:
> [-------snip-------------]
>   
> -static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> +static int __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>   				 unsigned long virt, phys_addr_t size,
>   				 pgprot_t prot,
>   				 phys_addr_t (*pgtable_alloc)(enum pgtable_type),
>   				 int flags)
>   {
> +	int ret = 0;
> +
>   	mutex_lock(&fixmap_lock);
> -	__create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
> -				    pgtable_alloc, flags);
> +	ret = __create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
> +					  pgtable_alloc, flags);
>   	mutex_unlock(&fixmap_lock);
> +
> +	return ret;
> +}
> +
> +static void ___create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> +				  unsigned long virt, phys_addr_t size,
> +				  pgprot_t prot,
> +				  phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +				  int flags)
> +{
> +	int ret = 0;
> +
> +	ret = __create_pgd_mapping(pgdir, phys, virt, size, prot, pgtable_alloc,
> +				   flags);
> +	BUG_ON(ret);
>   }

A triple underscore calling a double underscore isn't natural to reason about.
Since this is the function which must succeed, how does "must_create_pgd_mapping()"
sound?




