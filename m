Return-Path: <linux-kernel+bounces-824770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02638B8A1D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5597D3A825C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25399315778;
	Fri, 19 Sep 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="RkwYezGA"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022120.outbound.protection.outlook.com [40.107.209.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E4326056E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293769; cv=fail; b=pZRUGeM/E7pLyUAfXNAc3V2R2SGzkouR/S11w3o42Yo72LRxVc/kb7DvgmoDDDiBC4psz7Pr96iCOxkLQaVfDYqlmVBnX7tjPk2H7bxPybQbquAGPFiS6OJDY1AZpqHE+eftlveSjGy+wM4o4+eGKtaAyUjbCpJWTb0GqDdz69g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293769; c=relaxed/simple;
	bh=vHN8vG/C8nNpcopbQg/g9R5zFvQrG5R/HP1NgDH/oZc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MkjLArfnkB7d9KxuI+V4gVaTEbfECi2+QWiS1oo1KLFDAEv6VIiKW+9VxaeQ1nmhDyEjgilOlwgW2fSWGGN2EOkEXJ7h0G1I6zTr6nnarJsxvLc6WiHerT6t6RgPVJI8Rv4Zjwth1TpKGhZQEBeZ3o1kQovtOCPzNWfb6X7ljuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=RkwYezGA; arc=fail smtp.client-ip=40.107.209.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clHmjSvGVYIF9m+f/u1lKnIh/I8X4zsE21ot9jw/9ky22Ar8bYYLjw3CIAXG0eImGj3xqn7nAkgd7C0hoF54QPn5yk4uhWqCktPq2U8tWWxr+mL6rZwGti4G9CGbyvruixmrjbP4bSIK0yblFT0GIIVRxmT5howC23f18PEbCryOKAXeVpn7MZEiq8DX50uAGCj2ObhDWw5QI81Y9CCLG1YX/VKJCLKO9hxt1vN0boSf7VGPm974Lr6/FNZwWhC8iaJM0c3Oz9EOUcRAo8xrArSSn4grnSiYRuMucCRz8jMrPRnM4F5iMPaWZsWafOIMhrVqbKuNPjmxdNYvj7z0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/apl8GLiu9MmN/CEjXfff+2Sg/b3ttTt8fg1C2do//Q=;
 b=lEdB7y6NDP567qrTD/H/i8m4V6AaFvjcOsxQbcfx51s3xaqmhhOy3TiO1mODZh4Arf38clOCav5DbgHShUT3EhOcO5qV7EV6wNRcg/dEZMbD0/EyvMiC48FJvRLHI7cpp1EnBOU4YF/R2/fOGzNd1xVlfoAzMeIQDF0bDTVzXa37humNnf3z0ki1TSdanb13RKdN1P7qzz31Isxmv94zRG6YRQj2Rye865+3GkEcRD721GrwmXqQ/DgLdvK71XXcTqdXzbwE0qqztDAZcesfHUYmObCp0Eh6qffCyoXzjNgI7hQjR7WNJNwFxyHCXN1lt31fyUcyLi0Qqknb6GL7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/apl8GLiu9MmN/CEjXfff+2Sg/b3ttTt8fg1C2do//Q=;
 b=RkwYezGAx9e2swfELyWqXnjxQwgUV/NVVd2oQKEshDO5eqN/UxmB89d5suhpo6zn+CGW3d1OGGkunyBi0rTe93arQKV9kH6P/vcCj4ZEipKA8iUj3h7SFoausqBW+5XZqfEa97AA7yR2KQn51AFpan1RGk4ndapZ4/MdiFfVQo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH2PR01MB9101.prod.exchangelabs.com (2603:10b6:610:27c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.17; Fri, 19 Sep 2025 14:56:01 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 14:56:01 +0000
Message-ID: <9b2d3ddd-ffee-4b54-ae38-6412516c3f07@os.amperecomputing.com>
Date: Fri, 19 Sep 2025 07:55:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
To: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 ryan.roberts@arm.com, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, dev.jain@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <175822779944.710258.10028837182267037801.b4-ty@kernel.org>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <175822779944.710258.10028837182267037801.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYXPR02CA0096.namprd02.prod.outlook.com
 (2603:10b6:930:ce::7) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH2PR01MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7071d4-ec33-4f28-1de8-08ddf78ca60d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTRycURFMjQyT05uMUx5RFR2L3A5MmlQdnJpcDJuV09jdkUveCs0MjNrQnJE?=
 =?utf-8?B?ODJhV01RTGYraW96Wk1zRzhKaEdTdCtGYXRGTzk3a3lKckRwanZXK2ZXS29s?=
 =?utf-8?B?czU1Vkc2ZXc2YzBWR09ScVA2MWtZNEJxK0JoOXh4VkRXNmQ1Y2FSaTUwSGRo?=
 =?utf-8?B?MUpYRDZhTzgrWi9zYkJ5dXQ5ZEZXeGtDZWxrRDJUYWhwSXU5c2ZXTEJhc0sr?=
 =?utf-8?B?c1o4RXp4QzF0QUc2RUVMcThxM1pMaXgyUUlRQ2pVY1QrSm50N3hTMGNNUWM0?=
 =?utf-8?B?SjcvejQyQXA1alBKdC8zMHF4UWNXdmlLT3ZkN3VhQkYvVVBPMTVoaWtiSWZG?=
 =?utf-8?B?UmNQTk9oekV4N2JwckxoUTlyNk1iMHM0UG4wQ1JURFQxTk80YjBLenV3OE93?=
 =?utf-8?B?TEpERStQRUdPcWhVRFFIOFFwSk5qMTdxYkIyaXFCYW44cUZBb09CaUNEaEkz?=
 =?utf-8?B?MnI3ZExIblhTVTNBNldHMHcvamxlR1JLYzdkNUFxSU5nczFjVWZBSkJnWXJm?=
 =?utf-8?B?TG1CUDcvVmdSeVUvWDdtQm94RXE2MUs0bkdOakhMNkhzZnVZblVmc2t4OGZ3?=
 =?utf-8?B?Mit2cXd1UVhOZTVweWt4SzJ1aXR5VytEVE55Ums4RUJka3k2c1lvUWJ0WUkz?=
 =?utf-8?B?NVhzNkFaWFk4MGVaYWR1S0dIUkVDbFVRTmh4eVFNUkRRVTUxYnZWTXBud0RS?=
 =?utf-8?B?TDRHNmx2SW0xbzVtREw1clRUdVp0Y2E4aTFld3ovOCtwMjN0OTd5dXVzVzJs?=
 =?utf-8?B?Q1JjQUtxTzFwemYyTUw3eG00anBPc1FPYUhNejNBVnZCa3Z0SEVRRUIyWkNt?=
 =?utf-8?B?Q2MzVFkxaFhhRWhsc3IyaERib0k4UzNZcmdGQ1ZFWmVFNWJ1T1llT0MrRld6?=
 =?utf-8?B?dkNQcW0zcnBIRUhVeG9sOGdXaDZhYkoralhjWjFZQlp6Yk8ydUhqK1NITXFo?=
 =?utf-8?B?eEM5dlVjRzBqYThTakpieUNsUVRTcFRSQnNRRU9xR0RkaDlDRlJIUklvc0ts?=
 =?utf-8?B?LzE4Y1A2c0J6QXpUVk5VL1VrV25HdnZOL3ZEbHF0RnBFYkk1UkNLTjRSUytD?=
 =?utf-8?B?dTBqaktpTC9vdUJWOHFuRld4TWRpL25zSEsrRUdwUlpvbTk2elo3WlZ2RWU5?=
 =?utf-8?B?ZnRCVzBWYVJVK1liMytxK1F6U3dMUkowNEVORUdodmR4WEZBWG5Gb0l4Tm9F?=
 =?utf-8?B?RWh3UGlpNWVCaHFmamJjSEZQUkRIZk05MG9NOTlxbiswbGFpaWNmRmM3eUh6?=
 =?utf-8?B?L0QyWG1ob3VvbUw5L3Y2cGh0WVovZHRNZUE2TllrME41TDBvakx4NHJJZXFq?=
 =?utf-8?B?UkZoSHVVcWNUb3U2WFNFMjNDcXFhVEF6MUMrSXhrcGRHMVhPcTNSaUszWnRm?=
 =?utf-8?B?dE9ORVZBcjkxRXNZcFZQdTlsSURwcG90ZlY5eDg5VC96MmlBZENMYVd3TWxy?=
 =?utf-8?B?Q2FiU3hBWDAyZjJITEYyTk44VEMxQks1dEtGdHhjd0dEWjNNTjdyd3NYTmRM?=
 =?utf-8?B?YXM2dEkwQjFuN2NuSTlPN0h6RDlVT2hFdnRwTFlyeVpxMkZFNVE5WFRMakZm?=
 =?utf-8?B?WDNZVTJYbkg5bFo0NTVCeDdoRjlpQ0RSdVVKQXV1UlN0TEZqUU5hVW9NdGVp?=
 =?utf-8?B?RXZqTEd2Y0RqNGltUVhuVERHWi9oWkY4aXJxSmY0enRYUTdEL3VQYTBEcTJw?=
 =?utf-8?B?RW9Yc0NSc3IyZmJaMk5WT21pc1RYMUIybnQ2bnNnZHpSNlNnTkRRY3d3Zjhj?=
 =?utf-8?B?bVBZZFJtVUNpeXY1V3NuQ2ZsVExwVE5RS0NXTS9saDZMZmhoVzZoSXhzYml2?=
 =?utf-8?B?MmUrZ0tvVXJ4cE1mdjAvY2V2UmJtYzhuU1ZXVjlQb2tpejQ4bTlTVVBCbFN5?=
 =?utf-8?B?OXJxSVl0d1dIaExJUFZjR09FOGlWbG0zWGhDeWIzSmkvTk9XQmRnSUY4WThD?=
 =?utf-8?Q?HjtTExzE+x4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVpDSnVHWUU5ZnRuanVNclpXQTlsTkFBQ1VvVTRNNDJRNHVnN0JySEZuRVd3?=
 =?utf-8?B?bmtIU09NZEFiL0g1V09aSUE0NURQVGFxT0FlQnBCWUhxQVFzT2tueTZSUjZ3?=
 =?utf-8?B?T2NzUm9mVkF1Vm1BV0QyM1pHMVU4QmRjLythb3RULzB6SkRJM3hhN0VObkhB?=
 =?utf-8?B?TzdKbE5rUjIzVzNFSnpacjF6N3VkdGFjeXFHUG1zNDdTYTVaRUJRT1o5VE1G?=
 =?utf-8?B?QlpacHlTNUtZaTBSQVhydlF2akQyVkdqenlabkVPV2p5RmRtZFhQZHVFSnU4?=
 =?utf-8?B?bzVYU2p2M2ZNZWQ1anprZnhHKzh1bGg2VTlLMTVia2pQVjFMZVdTclovOW01?=
 =?utf-8?B?SGo4a0JtYTR3blZrMWdhLzlhZndoZStkQlM5dFZTQm54aGZoQzZSa1UzYVFz?=
 =?utf-8?B?eWNlNjB3SzZGOHFSR2ZTS3NyalBrSDExbUlpVTB1MVZKTEF3dFVFOFJoY01Y?=
 =?utf-8?B?OUhvRTdwN0x2TU5aUGNOZDZxV1dKYm9vUWE2QUtzLzJHRWNBN0FvYnZjZlh6?=
 =?utf-8?B?LzZCd09SMjl5YWEzdkFRU3dSZ1MrK09VSm1BVlRVYVlBakhIaG5GTHhDMnhQ?=
 =?utf-8?B?OUdvcnB2TlJYQTUvUDhOQ0IwVTlmWXc4WHJMa0xhQlpjQk4zRWhWK3kxWEk1?=
 =?utf-8?B?Um1KR2JHY2puZ0piMnBsejduYjZsQ2N6WlEwVlZvWDRDbmxTMSt2b0tjSUdN?=
 =?utf-8?B?YzVUWGJQUUpjOUJsd3JjSHN3Yks4L1ZVdEpHV0tydmwzOUovb1JZUS9ia3RV?=
 =?utf-8?B?MHBjZUtvcUNUNFRMR3NiejdEbGFrRHZtNllpSmxGUnZ4QkZFL1RRZTNwTzBm?=
 =?utf-8?B?NzlDK0IrZGZxS0tMZWZpSDRmSUNGYzVvQ1lFam02ZS9xWTd6c3VRaUMvdExo?=
 =?utf-8?B?M1FtWFlIS1hBdWc4bUR0RUJzKzlLOTF2c3lSanhIOVA4c1MzUTlpU1hXTVpI?=
 =?utf-8?B?ZGNJSE1CZlVNK1lsMTRVL3BZRFlQaWVyeVRydlhteGp1T3NjMTBqUFBzWi9I?=
 =?utf-8?B?VnNBTnNxQWdLSzhMRjVzdnE4aVpEZDlFeTRJS0xDdHdrQzRnR0YzS3I5Q01t?=
 =?utf-8?B?anNUVGdSaFdGWnlvb2NveHh3Y2RUNVRLaUdJZmY4UWRQV1JSL2ZiKzdtSTB6?=
 =?utf-8?B?eFQ4YjRiTlVCNGFRcjE1ZUt1L2U2YTh5ZlRDYWJERjNQVisxVndVS2Z2NzVx?=
 =?utf-8?B?ZlJVMW4xc25QWStzcFZyUGlib1BiSHVtRyt2NzNlbzdLNEJRdyttenkzUHVy?=
 =?utf-8?B?VXZBNVlRSXNGL0Z0YWVVYUFxbjVyai9XcUhoOFYzeWJvTEZqSlBLb1VyNmoy?=
 =?utf-8?B?NWk1ck5XNWo1WVk5cmhzSU00d2FvdHhDMmhUNWlqR1ZvdkhsMGdWeUdsbENu?=
 =?utf-8?B?SGd5NWMvam42eGEwcGV0OEw1Z01rcHZSZ0wrT3Z3YnIwTW1uWlhSQkIxaGFV?=
 =?utf-8?B?RG5DRWZjZDB6K2FwZ25oZkFjTnlPSjBCNVZYUzlrMlpZUkNvZmlFdDJRSms2?=
 =?utf-8?B?VlhZNVpWS0FIaUFuNTdFb1lJMTBicTBCOU9NMkZZZWh6SUVxV3lHNGp1TmVW?=
 =?utf-8?B?eXYzNTYyalRPejBjNUFxdVRRcHBMNjNPY0Nack55eWUwL3FjY1lxdVRpRlpw?=
 =?utf-8?B?NTkvWGdXS2xQMEdmRWFON0JNWWNlWlpmREtVRi9SZzJCcVJ3YnJNcTNhVS9l?=
 =?utf-8?B?RmFJR1BOWkdNMUExN0xxWFMvZDN1YWh4OFhnZUt2bmt1M0NZdHcwZDEzbzFY?=
 =?utf-8?B?MDFlU3hic2RRc2Z0c0dVM3gySFM3V0hRTTVNU1crem9XYTlsT09DSnJQSUdC?=
 =?utf-8?B?ZmkweU9aL3NnK1R2SGNJYi83SDZlQVhLd1NDYlU1Uy9XSzJyTW4yRFkyYUlu?=
 =?utf-8?B?MU0wRDdaVFRVajlySG1ZUTVPb3dhSWgzczl0dkZ1Tk5HRjVIeTdJaEI5bVZs?=
 =?utf-8?B?Z0RUNjJuT2xKMzRiVC8zRTV5WTVucE1EZE02MWI1MmtUdDMwQk9BVlUycnhT?=
 =?utf-8?B?NEdYVUkrQkQ5cllqZWo1YjFUNXpURzRPTkxDRVpVcVBIV0VUYnY1c3NBd2tr?=
 =?utf-8?B?bTkrSlhnMk55S2cyQU5OeUd5RlRYV3EwYllTME54VTA4Z3Q5dVppdndrNm1L?=
 =?utf-8?B?cldTOWIxc0lORGM3dkJsOVNUcnNNWXdKMkw1Y2k0WEJTNUJwSUQ0VFpycFJo?=
 =?utf-8?Q?/i2Qc26hD/4S+xqbm6siJLg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7071d4-ec33-4f28-1de8-08ddf78ca60d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 14:56:01.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBrcoCyLr2KHQ+2Foiz+wA+/S4/rgejQI7u1rDaOPzWglm+Qmkkm+kpY4bHwT0kqwRTq5rc1sjvIfP6g5e4DhJ5AgP1Rlo/c/beLRjnqZDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB9101



On 9/18/25 2:10 PM, Will Deacon wrote:
> On Wed, 17 Sep 2025 12:02:06 -0700, Yang Shi wrote:
>> On systems with BBML2_NOABORT support, it causes the linear map to be mapped
>> with large blocks, even when rodata=full, and leads to some nice performance
>> improvements.
>>
>> Ryan tested v7 on an AmpereOne system (a VM with 12G RAM) in all 3 possible
>> modes by hacking the BBML2 feature detection code:
>>
>> [...]
> Applied patches 1 and 3 to arm64 (for-next/mm), thanks!
>
> [1/5] arm64: Enable permission change on arm64 kernel block mappings
>        https://git.kernel.org/arm64/c/a660194dd101
> [3/5] arm64: mm: support large block mapping when rodata=full
>        https://git.kernel.org/arm64/c/a166563e7ec3
>
> I also picked up the BBML allow-list addition (second patch) on
> for-next/cpufeature.

Hi Will,

Thank you so much!

>
> The fourth patch ("arm64: mm: split linear mapping if BBML2 unsupported
> on secondary CPUs") has some really horrible conflicts. These are partly
> due to some of the type cleanups on for-next/mm but I think mainly due
> to Kevin's kpti rework that landed after -rc1.
>
> So I think the best bet might be to leave that one for next time, if
> that's ok?

I saw you and Ryan just figured out how to move forward. You guys are 
definitely more knowledgeable than me regarding the asymmetric systems.

Thanks,
Yang

>
> Cheers,


