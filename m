Return-Path: <linux-kernel+bounces-848533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D37ABBCDFC8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B615479C6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D8F2FBDF4;
	Fri, 10 Oct 2025 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UdliAmTy"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC249620
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115141; cv=fail; b=a0PmWCu/aiLfUMX7NNEK/1E6Qu79HEx6xsy9ThZiEn6id0/IXOXMWScy4ZClojyeBEOSM0pvZCZEEaLf1pk9upae8msnqn/dwJnTQbu+wpUmhw5GtIiDSDHv3EqjiWxdthRpCS7DTJwd1CM+4rOY6AUkGNWA1QV1TuHW3cfJTRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115141; c=relaxed/simple;
	bh=YI/ft9EDTdlSTbQUqYUsYMFIA62YoQKxbYSZKKgSxj0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VzHQbErBqIuQ8R6t/rZo1daoAS6eBpd1/3GajPw2eFi6AbDmZ50qVZlozdoSPako/V6pvHgJ3aLst3PvBMlcBY9fIR2YWmMWGDrnJOst4diPzThBgUn+4pOIeMwKlCoPjbjOEOyUhH43PqoItwqZHxG1ZA0KwY5fRLUBaPHfzOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UdliAmTy; arc=fail smtp.client-ip=52.101.193.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ilrd54lA0rApYN9f2JFawWJKLYYC/U26BbgbMnLm56301mYe/LxRjH/fcXOFXCEM7nFYcE1SnypVIktclUN6tPR9PxeDYWhbhc5mZ+KJUw1sVXvCFLvU6nFdhDpzSZ+LWhMiMSEQHIwYyxPqdADV0hRCqTwuDfwH6iio93GYI4GDuZb5BqnzY5RB8J4KzWZNJjMQnSkzp6hVs00hGIfdMFskppG8rNor1X1TdsJsTbFSp9O45Vz7ic5QeDar4Wt2b9DYiEEiw/Gs75fo9+8TqJmEEeBZ0uo0RVtcDsrw9c1S8JsueRCsr0Ks8xxA7MREgXFOUmcRXMlnUapQD1AOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMrnPz1Br0RY7FCDtIoFnrwHf1Jym5iq44VTDEoK5Co=;
 b=dn7DciBCpsbZCxMM+OcMlMU1XIL1MPM/tg4FRi3z3ro7c6F5kbeNUhFVi0dfPC5zCJQk4grG1ka9Ghs0VWG7tFRSW5vqjUaVHCyBpl8yUhiJtVs6VOGXvbNJJbnMjVqKlgw1G54EZCnQAkkRSlxd6qmV4SogsWWNCSWOqEijb5TrIYmEOBA+Tez7SHQWu8WDhmFK2Rt4ndUk+RaNVJS9lsFqwtj5ZU/ROnc0aQctdvaBvh4gY2poOElye3ymyEYnwZpkRxiEEaTIqp5aGv65p2Dgu+aLBi9pQhUaV2mFyaLZuvTMleXFjaC+5qmhsaHmKdbw+bMxJvp/71+OPzbALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMrnPz1Br0RY7FCDtIoFnrwHf1Jym5iq44VTDEoK5Co=;
 b=UdliAmTynkuUZBd9Bq1z+cvyJMhYG7DE3JyNkkL+yi823XhoVnLDgCU6K1qkwOU+YXUl7kqbaFqQmN27TZeAAsXSgxoCgTvh2E9f5NamqGEz607n2C3L3f8U+/Th1WUEqhPm9xvMkgXxvoj/dus/tXhNwMHd/4eTM3uESa8cBoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by DM4PR12MB6134.namprd12.prod.outlook.com
 (2603:10b6:8:ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 16:52:16 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9115.018; Fri, 10 Oct 2025
 16:52:16 +0000
Message-ID: <b9a0ac5d-6ccc-45b1-afbf-bdba24aaf501@amd.com>
Date: Fri, 10 Oct 2025 11:52:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously Unavailable RMID
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, Dave.Martin@arm.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 peternewman@google.com, eranian@google.com, gautham.shenoy@amd.com
References: <8eace6e47bb7e124ffb6c10150d1b7d38c2f5494.1760034251.git.babu.moger@amd.com>
 <3c428de8-f8a6-47a1-a5ca-768d1906ed24@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <3c428de8-f8a6-47a1-a5ca-768d1906ed24@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::21) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ddd507-3f3b-45d2-505f-08de081d5e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDgycHRFSkVzY0N4NWUvOW02ZDR2SkpZWmxNQ3BvT0QwY0xOVHZKMEpXOXA4?=
 =?utf-8?B?MUlHTXppeVBPR01tdXdvc2l0anplcUlEai9acDhjMEJCdndMUHFNLzNBNnM1?=
 =?utf-8?B?dFk5Ulp3Q25sZ0JIeG5PSjVTamlzWU5VUjJuRzhUMjNXbGpxdlIwRURWckIw?=
 =?utf-8?B?cjdiTmxicnJQM0V3TXZTeUZTaDdFcTdnQ0svSEZBSUxuUHd2Tjhuc1g1VFlB?=
 =?utf-8?B?T2JiTXRuS1IxTURuNFVaWWJFdnBJWk1ZZGQ1emlVMmhpbkpIM2E5bE1nTms0?=
 =?utf-8?B?T0pET1gzb05BNk5GREFIbW13WDNVa3h6ZUNYcGs3ZTdHN2tETTZ1dnloWFFN?=
 =?utf-8?B?V3RTVTVmeS9Zck53b0lWdEF0WHhGeFR4cVlNcENVVDJvb1NwOU5nWWQrVGNx?=
 =?utf-8?B?V1V1Y3c5WG0yN1hSdU1RbVV2am1XcTRaM3VHU0ZhOVdreDc0aEY2SDNuZ3pp?=
 =?utf-8?B?NVVCU2JjdUtZL3VLcG9kRDRtSjlCVXhpc1dWY2w3Tkt1YVIvTlkvaG5SdTBa?=
 =?utf-8?B?Q2xpVWFiRjMyK2YyM0FPeHRobmdsWnBWc3VqQi91LzNqZ00vNlVlODN0a1Zl?=
 =?utf-8?B?K05sRDdVOEFFUFN5a3ZvYWM0K3UrRUlma1lVckpkd3hyZ0tvZXpMTUhCKzA3?=
 =?utf-8?B?ZlVoMjQwQ1FzdkFBdm52V2hNWVQrdjh5ZEZFcUk3UVR5bW05VmRVWTJFZ0E4?=
 =?utf-8?B?cTU3RzB3cXl4blNVcDRmZERRUHJYRmpLVlcxWFJoWlp6Lzc3WnRTQktIemxj?=
 =?utf-8?B?TGVPdDVPY1lFYkM0eG9tekRjcC9GYklQTDBrQk8vV2o2RDRYOXhLSURBWFB6?=
 =?utf-8?B?eFJkalZWcDlEL1V0azIwc2h4THI3WUpndmdUVlZJQUlqUzZwbkNHQ3I3K2d6?=
 =?utf-8?B?WlYwdmxZRHVteUNaVWZkVjFwZWdrTVJ0a3dKclZDTTNRQUR4bFhMRlVkS09W?=
 =?utf-8?B?L1NRMXNOUUpScE5RakZ4akt0ODcrSS9pYzc2Vml6allEUEtXV0JzQmQ1aVJj?=
 =?utf-8?B?RnFoejBNVkFiVDEvdHZSMXUwZmZJbGFyc3BsQ2gxMWJRbFBBTkNZYWxDcDNT?=
 =?utf-8?B?OTh0d3ZpcDl1WnhFT3ZUdVlzcnFpWFY4SDkyN0VKVFErRjJNK1Rvd0cyVVZo?=
 =?utf-8?B?S2hvcklCMUJZckpQaGRQbS9MbnFpUjRhNXNuYXdEQVZMVzhxWHltaG5IUU8x?=
 =?utf-8?B?VFc2a1R3MTk2N2xHSHlaY0VaME1naVAyaHFSNDE2ZnlVZ2Z0dmRuU0o5bG1W?=
 =?utf-8?B?ZURiNzN0OVA5Njd3T0dVaDFBYXVneE5lN215SVZ4NkxQWVRld1FWMFNwN243?=
 =?utf-8?B?SlpsWU9sbGlNZ0swUEZLWjZvVUdxdktlREFUWG5WdE9uam5Ba2J4YUt1OXVj?=
 =?utf-8?B?OXc3WHhOemtzK2JpU21ZVmZ3RnVwRGd3ZGw3MlZxVHhySXNIQ0U0eXFDVzc3?=
 =?utf-8?B?c1VucUpDN0pUT0pBQ2VzY1VibVNjNzR0cW1UM3YxQ2Qrc3FZN2V1a2J6RmdW?=
 =?utf-8?B?K1QzVXJ0aDQycWx6YzNpcjFNdXhXOGF2TDVuZGs0emljU09raFN6ZVZ2NS9n?=
 =?utf-8?B?OFVzOHplanYyNytBTTFKbG9qdHNHb2RyVHdXQnZrOTUwdEloZmc4TzJteXh0?=
 =?utf-8?B?Q2xiRnBDS0t1NUFITzFkcHVqUllQNWRlSVFGRTQ3VklnVS9LVGR2clkyZFI1?=
 =?utf-8?B?d2hzYmdZcEdVTTNLTkhjSG9zWGFPQ2tCSFJjN1B2aUJiUmkxd01OcGo2akto?=
 =?utf-8?B?eVhGbUZrMWhYYXVaalczWmsrRlRmL2VjQ1h1LzBEVkZQRldrWnU5SFQ1T1Ru?=
 =?utf-8?B?cDFrWWtMeE0xWjByd01xTXF2STErcUJ0Z0syS0lrei94M3RMdnk1a2lCOXUy?=
 =?utf-8?B?YTFOQ2xGU3lvMy9kdHQ0MDRLNzlKdGI3WXJwOHRWdGV2cmRyRFhqNUxKMldB?=
 =?utf-8?Q?/QnpYu2maGHFY388dDywIIMkD1qSruuB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWorQ25STzNMbDJ1bUEwbFJwS0xNT01WQXlpN1pCRktCd3hoT05NVjEzWi9N?=
 =?utf-8?B?aEVuMW54ZS9IeWQ4T1RwaDErUTNaYklqZEZwTC83TXNIc3JzZ2NnNU5XSnVZ?=
 =?utf-8?B?MjFwSnZqSE5vM3BaR2UwUEhCam5UZVkzMVpvTWQxemRwWnJQZ1c3aDFQc2Rh?=
 =?utf-8?B?b1NBMG9NeUxlQWU3dnFxbm5OcGM1cEtNdjFOR3ViMyt5TDJncHFtdmh2Q1NZ?=
 =?utf-8?B?elJ5Y05vOThmMllaOUFtTmdJOThHU1htbU9JelVOb3ZmR1pQcG1wMldXcnAy?=
 =?utf-8?B?SjNxMk9vWjNxMEwvcVU0dFVWUm5qMXE3Y040eEdZaXphdGRGN3VtZ1pxbXpK?=
 =?utf-8?B?bHFhbWxLTkFqTlBtOWQwTlF2eU01YUVUNXAwcGxPcHRISTJJaVlQdTNCclVa?=
 =?utf-8?B?SUlJU1FPY2ZXWTZtc3Q2R2VyVDdVeG8zTGJiYzdRMzl5d0lkN2sreHBBQ0hr?=
 =?utf-8?B?d21JaGsxMldJWldNT1l3YlY3R2g4aGttYk9CMmcyQXlVOG9VYVpkSFgyRmp0?=
 =?utf-8?B?YmxvQ0V2RmZ0enRBY0ZJa3lCVkZJY0FZOFJxNlB6N0ZwOElzb3ZKNEJmTVVJ?=
 =?utf-8?B?NVpPYURtbTFoT2dzOXlFaC8rbEVDV1F0d25sRFkrM3RBOWN3WGIvUFJXNTZS?=
 =?utf-8?B?UVd4aGdjaFNOWFR3ck1HaDFjaVU3NUozVnB1ZnhGNFNJR1Q3V0ZiVTlhM09a?=
 =?utf-8?B?VEpNMm9pZVZaWWdPRTdCNkJnNlVTNngza1AxeHBzSjUzUk9hRDVWWTN6cWQr?=
 =?utf-8?B?ejUxMlNQdy92cmsxck9MUEZZYklFUmxNM3huRjIzMnptKzZlM2g0UWhLSGJ3?=
 =?utf-8?B?WmtDSERRVTZpYXRmdlpMbWlIb3dHd3UyeDBlSzlQVEhmRytzb0NrUmlRZlE2?=
 =?utf-8?B?SExDRFJhSFVPYVcvRmV2SXp1dkpXNW12Sno4ZTlNUWx0QlF0SEFIQ0Z5TGZq?=
 =?utf-8?B?V2RXMCtodTgyeFhhYkFDV0JYM0lUeno1M3YwZXpGS043ZnRteEo4emFwS1F1?=
 =?utf-8?B?UlVxWEFwRjVLVnY4cU9LanBYdzYzMUhVWWlnbG5UTm94MlhGSFd4Y2JqbHhF?=
 =?utf-8?B?WnJtdjNTdDBlakVKaHVxQjRzK28wOEtxWm90Zm55ZU5vdlllUjhYZFh6cEhm?=
 =?utf-8?B?NU9FSDlKZGpnTnZXdmFwenhxbTdhQUFRa2REMmQzYmlmS0ZteVpCSjA5RkFG?=
 =?utf-8?B?ZmpiQzFlekNJdUM2b1N3d2oyRE9aRzNIRU9JdTdtQ2pxWW1WRFNtUEY4RlMv?=
 =?utf-8?B?ZHo2dzhqUHIvNlZPUnhrR1RWUzgxMWorSTZTS3NnK0JlMCsrQ1JBK3JlSStn?=
 =?utf-8?B?YUJ3dk9pLzJ4NENFSmk5cE9MM2VpMVVUZlpxVHZyK1lTZHcrZDd6ZnM4RU5l?=
 =?utf-8?B?STduMDlDNndUT1BQa1BhUUhJSzFpM3J2ZGliWlpVZWwyUmoxc0FIL2NCQjF6?=
 =?utf-8?B?YXZGSDVpV3h5WkVnYlVKaXNQdDZaN0F0S2dqenBSNDNERGRkUUNFTWxSbHg4?=
 =?utf-8?B?My9XNnNuSDBub3ZzbTdQR1pzdi9GS0hXSyt2NVlITWNZeWlac0Vkdkt5cXdI?=
 =?utf-8?B?d0RnRzRrZ2pXZFRNOXhBSVRZTW0vR3hGR09MWE81QTRXNWJLU0w2NHU5dGQw?=
 =?utf-8?B?bTAra2xlUi9yZ05TU3g0N29TSTg3WGtGWk9Gc1U0T1lPTUFFcmtjNTFvL3g1?=
 =?utf-8?B?VTFwWXRnVHdVUVY1WEluWkZRZktNRHNMN1gzZ1lramJGQ3cvY0xuY3QwUUdy?=
 =?utf-8?B?azJwRlhEdGIyYnFBTVhHRjJsSmE4K204d2hkdDV3UXRxYUtkaDMzZzFzUG56?=
 =?utf-8?B?blM0cnRQS2FLamVLUVFHeWhpZmVzVXlOK1o5VXpibWcrYWlNeVZaT09iV3Bs?=
 =?utf-8?B?ZkN0QU1UWGlRWE9JRG1MRXQ0MERHT0hvdzdZajJJdFJ1ZTU3K2NxT2d0TG5J?=
 =?utf-8?B?V1A1YVVWcXRrdG03bGtOb1lVTVVJQkJHRTV2aVJ6bVpZMTh6eXFrYzFzdFpW?=
 =?utf-8?B?UGMxbFJHT0U2YVlTMVhLM1hyR0R5TXlGUHJyYnFHcTc0eFROOFFYUlpZTmEy?=
 =?utf-8?B?andVN0theXBBKzR4N25BSzFjSGdzaWMwWktkSzJlNGd3UjdyV0lGcWwwOXJl?=
 =?utf-8?Q?oGHEnOxl39hgDv2muzgV2OGTo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ddd507-3f3b-45d2-505f-08de081d5e0f
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 16:52:16.0872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/Q7dWIt+2h3+gfEKhJTfLKk07e+7YtPRR7AurggeaoJoPN2TG1LQqH1di7mwLlJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

Hi Reinette,

On 10/9/2025 11:19 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/25 11:29 AM, Babu Moger wrote:
>> Users can create as many monitoring groups as the number of RMIDs supported
>> by the hardware. However, on AMD systems, only a limited number of RMIDs
>> are guaranteed to be actively tracked by the hardware. RMIDs that exceed
>> this limit are placed in an "Unavailable" state. When a bandwidth counter
>> is read for such an RMID, the hardware sets MSR_IA32_QM_CTR.Unavailable
>> (bit 62). When such an RMID starts being tracked again the hardware counter
>> is reset to zero. MSR_IA32_QM_CTR.Unavailable remains set on first read
>> after tracking re-starts and is clear on all subsequent reads as long as
>> the RMID is tracked.
>>
>> resctrl miscounts the bandwidth events after an RMID transitions from the
>> "Unavailable" state back to being tracked. This happens because when the
>> hardware starts counting again after resetting the counter to zero, resctrl
>> in turn compares the new count against the counter value stored from the
>> previous time the RMID was tracked. This results in resctrl computing an
>> event value that is either undercounting (when new counter is more than
>> stored counter)	or a mistaken overflow (when new counter is less than
> 
> Since there is going to be a respin ... there is a stray tab above.
> 

Yes. Thanks
-Babu



