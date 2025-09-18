Return-Path: <linux-kernel+bounces-823206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D6FB85D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711FA1CC3FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C133101B8;
	Thu, 18 Sep 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="lw+2csNx"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022074.outbound.protection.outlook.com [52.101.43.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7276D30DD33
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210610; cv=fail; b=e8tswMC5OkB1eHFd2q5xDPVefddqFm8iwYKlE7rE+QCBrvlqFo60YJGRWRcmbZltPZ8LhbrjPINevj0W+9PEXwjCk/k6Z6skfFJl/yWpbv9uKC1gNoyFs76Se/pQMMR++i51KzqYU7fLLtR950or4aOqJtiJLd1dkzxag0zY4h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210610; c=relaxed/simple;
	bh=7MMj8MR7j+pVE3saGGDQXXXEbor5KTBYFvJlgdxa/lI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rbYMurj0J7SCZvkWjjPDQZ/hz+AJHZvOAu1LIwJROCQvDHpmcsbTDMwtiz+uzsd9FwEA1Tdsu6RgUB31KAQf3HJL8oLBZXvFJZRaU9Tc5MaOrVHlvqAateCKpYV/HHw0mJl2dN5cGabihDez84bDECO7z+o1Bgqk+YhkEuNmZws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=lw+2csNx; arc=fail smtp.client-ip=52.101.43.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErieL/+HvJMyZnpnmr29007gVaKx9SwrCBOCzrZCPBV5hUASI/eDKHOHMtP73QbTPdVffA78lo+E2bnv7y25uqZidD77PBGdx/WGvKhKO2YLF2rxSzrcZ9JESlc125AiVhXUI5P12sz1bJwt+g1MeOsilEa3ZGQnwm7X55VmDR+dvUpMuIMXeS4l756fMenVQxyGQr5dUq+9nYhqniQRa+3+pJ/v6Td9w2NmEg/lsEuEAencFtl4SgN7Tyc8p81DOguAim8lSU9mTErRlGTmQ6AMUUNtqJPkiRDtB9o7d8lhRGHdNLe5UzhQarTJBN9BCLP/ZIfjP+euRuaMkg/HWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iJgEA0z8IK2eMIQvuiTiZpDwyYYIkVtWtaC66G5RYc=;
 b=gRzuvH1sXRzTb/5+DSXsXZu6ktB44fgzYBMjhj31NBoafs6NMBkGvOUhHSjmnSYoYiRPPp1zdEuaxGl7CoZ/u+0h9a9+G5mH78RBXTmZdj/PYLo9DV7/TkjChtj2CBpIKmWUvEP97PfICx0xCBlSfgTMEj2WqEmfmunJ2b3c+outUhBYVUxjtT09ZfPtbLFVjAePj/KLF2LoXVlkMc3oWLqTE6hYbNWQ048wIFm6L+fL+87C1z2a9bU7odou8ERYdu5rxPEdtxHUXuFclX2OmsDLJkzK2lhr6LbDdqZIsVmg47RZp8KF0qBFdqeeNCebvNRtfCYXr7uySBFXOPIVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iJgEA0z8IK2eMIQvuiTiZpDwyYYIkVtWtaC66G5RYc=;
 b=lw+2csNxYZ1b3fFZ6iIKcYFdmlqGq/ZQZKsB+sldzscydNMTWirDxtkEEX83pV5K2iIB9Zx5nRZMUZGdA/j0vi0K19q9zp2ESoq6/eqtC9bhSbSpFNOXqVt76MQNygm9XzfpO5QsVCJNj1mkqan3KO6ad857dllsU59MAgfMyEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6699.prod.exchangelabs.com (2603:10b6:510:74::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.14; Thu, 18 Sep 2025 15:50:05 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 15:50:05 +0000
Message-ID: <2f03eb8f-f343-4243-bd87-9b9c15d00beb@os.amperecomputing.com>
Date: Thu, 18 Sep 2025 08:50:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] arm64: kprobes: call set_memory_rox() for kprobe
 page
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, dev.jain@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <20250917190323.3828347-6-yang@os.amperecomputing.com>
 <aMv_nhEuCSHKp5J6@arm.com>
 <22732cbe-20f8-4d1e-b086-e34d0f9bbb35@os.amperecomputing.com>
 <960fbbba-8018-4e42-b1fd-6ed96c148007@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <960fbbba-8018-4e42-b1fd-6ed96c148007@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: dc15db0e-16f5-456a-a653-08ddf6cb0985
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlhyWE5lK0pFZTJ3V2xwVmhTaG1MT3poNWdab1ArN08rMkNiM0Nyd056TVh5?=
 =?utf-8?B?UHhEa1h0ZlBoRXdpeXBLMmhFUzlRTDBSTjdHOHNQWTUxVGdubmVWMm4yUUp4?=
 =?utf-8?B?TnJ5T0NDTXQ4bDFyWTBwTjhnNWVYcnJNMmVEdUV5aXFQZHpIUW5pK1YvdEkx?=
 =?utf-8?B?elJzR1oxM1o2cTU1TE1MK1hyblNpQlRFMXFVRHF0c3lBQjl1WFVGYURRRjg2?=
 =?utf-8?B?VVAvdC90dzlkVHE1UElqdStHL1U3MjNQdVN2MWJxbEt5eE96cWlUWFB0UnBu?=
 =?utf-8?B?ak9sUTFKOERkc2RGTTNjUjl1eEJtSEo4czMvMGFaa3pYbGlWd0RhdXo1aVpB?=
 =?utf-8?B?YjAvSjJVcVBCVHl4UUZUUmhDTElIbVlOMlZpd3h6YkxPdGZ4OExPdmh5YjRI?=
 =?utf-8?B?Z1NqcVJyeWxKRnlYR01sQmxkKy9pM0dyUGdMbkJob2dhZUV0anJUTUt3cVRp?=
 =?utf-8?B?RVFkc2N2NWc0eVZoMnVMcTRZU2hCSWwzWEJ0blZnMzhHdFFWWGdydHlxSXBZ?=
 =?utf-8?B?cjRYSWk3U0tabzlxUENPUTBuSFVHdnBKL3Z6VkRSMEtHTVBPMXg2TVhnaXJt?=
 =?utf-8?B?eXRXNVQrWXN2cmhPeE4xLzM5KzhVcDNlT1hPRWJoZ1BKOWtGcHVybXBhM2JB?=
 =?utf-8?B?dHd3d1NqNE1ESzZuYkhmMWRpZFNtRXhCc3h3WFlaY1l2SUg2SHBwbDFtemUx?=
 =?utf-8?B?UE5Td1BRak1aQU5WejVRZUI3dkZkdWNYeWdYL0J6V1RCSW9PNk1tbDJuSllO?=
 =?utf-8?B?YTdnU1BpWndXZzZndmo2VXY2eVNyc3NJS1RQMzBTelE0dFQ0UzFlV3pLSmRZ?=
 =?utf-8?B?VjdWZXZNZjZUcDR4eUtsM000eWMxbjEyZmNFUEw0RVJnUWI3VDFBWkNTeE9E?=
 =?utf-8?B?M2ZvTTRXbWpuR0hnSFFRRVhjeng2WmNkRm5CVFhTVDB6TW1qbVZEVDkzbnVD?=
 =?utf-8?B?UlRFaDFvSERzMkZ4YmFRREJvaHRwUWw2aGFVWVo0S3diQzZ4c2JvbmFoZmFz?=
 =?utf-8?B?NDdFSFR0b3J3YnpvWVA1TVVxL1EwWjdEckJRbjlBcUlYbEZKbEZ0eDd5bnpz?=
 =?utf-8?B?eTN4RkxTWGc0RTZBRUpzYkpobENXZVBkV09LbVU1c2RpTmwxQVdNcUQrTWw1?=
 =?utf-8?B?TWI4V1F5c0NkMm0vUnVWUHNrR2xGZlk1ZzhzdTlZS1NOampWNWl0NlJnVkc0?=
 =?utf-8?B?ZnNpeHpXQjhqem9DdVRiT3RjMlY4TGszMFVRTnZKekQvdnpHWTdVWi9XV0Jj?=
 =?utf-8?B?aitJcnNVU3FrRk1kTHYzSG40NVpyMEoyaHRwdks1dERZbEpMeGJibDJZanMw?=
 =?utf-8?B?cElMWVBoN1NhK20vSzY0VkpFL3RIWkhwSHBzamVIQVBBc1JtMzVwSjVDRVdP?=
 =?utf-8?B?Y2JKWWdFeFRPYmNXNU5xaW5OOVV1L0tjdi9sN2ZhQTVyMExlTHI3OVU2OXcv?=
 =?utf-8?B?aUZwcGhVUEpsa09TczhDdWIyVW5ZamRKT2ZrTmF6QW5TdXAwWExGbmt1TzF3?=
 =?utf-8?B?aWY0OS9Dc0hSS1Q1WWxkRW4yVFJack1pZ3pQTkhSVytIZCtuYzNSSVlSeVNP?=
 =?utf-8?B?QVBpQXpnNG1vY3hSVXhoSEtCMGpzRjdibXZPOGM3ekV1RW5pemtCVENndFdj?=
 =?utf-8?B?L0JKYTdUYmVHdXJpeGduZXRVSUxHbXJoaGxuak1vR2xWcFVXL1ljRUIzTFhK?=
 =?utf-8?B?OUU3NU1hSGVSeXNvRkVpNUp3L1VHMDlqKzl2ZGpnejRROHlNbnV5UGtlNHMy?=
 =?utf-8?B?Q1VvMHpUVnZmb2JNRTlEMHp5TjNOQnEyWWdiNmVIWWVObnN6NGJaNGNqbGtp?=
 =?utf-8?B?MDlxR1FDYjA1SDhLZjdiaDJ5RkJvVGRzRmdLb1hmWlB4T1FJbWdSRnJ0cEI0?=
 =?utf-8?B?TWw4dVdSL0VxMCt4cWlLUVZtOFpuaGdGQlNicjZtZitCeGFmbXJKanQ3REkv?=
 =?utf-8?Q?JupioRQ4ig0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFdtK0wxT0xuT25RM0hvZXRQem84N2Fwd05LQmthQmk3T08waUE5MngwQjlR?=
 =?utf-8?B?c1o0b1pzK2dsdFhBenlsNjBmb1VGSHl3akxWVTRXOVN5RlFBU0lOUVRaQUQr?=
 =?utf-8?B?bnVTYVZlZHRZMFJDZndYOGdLa2pSckZXNTV3a0tQZmJYTm93WGhqbWNjZVRM?=
 =?utf-8?B?Nm1oeSt2MUdnYno0L1I0SXpwVk5Pd3Z5RkpGYjErVEVZMUJOR3FGaVh6c3Jr?=
 =?utf-8?B?RzhCM29CaVFmUFJFK29UNGdzYm5RT0k3S3JaNFRHV1JoWElCVkNac1I1cXhy?=
 =?utf-8?B?aDdDczNyZmJ4b2l0cUhxeUhveGpmcElVZ3JvUU9BVSt6MEtVVTBNQ3RSSWc0?=
 =?utf-8?B?YXpCbE9QOEREaDAwQnlYSDcrbFpzZE9DNmU2aVBTNFVrNm95RHBPakdKeCtL?=
 =?utf-8?B?NlgzUTMwZWJJL25YcVlMT2NaRXJXZWRYTDBkdm54ZDdBcmVxMkRsYkt6Vjly?=
 =?utf-8?B?cXhkZ1hrOXRqa1FkU0trb0JqNG41c1FCZ21tZlVYVjBMNlJCemY0M2c2VU9p?=
 =?utf-8?B?Z0pVU2hib2xaR3VGamtLNnRRRmtpS2lERHJ6OGZYU3JweGM3d2ozOWV2Qjl0?=
 =?utf-8?B?VWxPME5CSUl5UTFtM3R3U0F3ZXpqdGZKaS85b0dWaDZkQUpHcTBIVjRYQVJh?=
 =?utf-8?B?NVpZK0tRQnRrODRITXgvcUo1WE1SRlREU1JUZGtLS2VGc0NwbSthbTZ1d1pB?=
 =?utf-8?B?UXZ1dnp3WjZsUmtlODg5SjlOQ0duZUdQdU9sS0xlL3JhekFxWHBKQjhwY0hl?=
 =?utf-8?B?TDdLUzc3ZjdIeUhUQmJjSE9ydnlOWHZHYUVWZEY5Ky80TXJmUWh0STdldFJW?=
 =?utf-8?B?Rll5WmlWc1RraTBIcjRFdkFZeG5pdW9Lc2VHVmw4ODU3UU11NXNIb3NlclR4?=
 =?utf-8?B?NnFVNGd2a2gvbnlJVndwTk5QOHp5eUNtYlVXODAzR3pMSXhhaW5JS0NzSmxi?=
 =?utf-8?B?NmhmWXNzOVJGNFVHOXh0NkFzRm82VmhqRDg3THJJMitVYVZLZUtyMHBCY2ZQ?=
 =?utf-8?B?b1NTYVZmakpBUDZLUHRuU1J6QkVsMHBSYVpYSU9kcThRZjdzSENVUVY0Rjlz?=
 =?utf-8?B?SE0ySDhmVFU4NkxzZHE4U1dITGVaK3RmM25aUVd2dWs4aTR0ZW5zS05TcW9p?=
 =?utf-8?B?d0dlZS9NNUpNUURkOW1sTFBDdkNJK0l6WWhjcFoxNlVweXF1dVBuR0YyU0R3?=
 =?utf-8?B?WU9JaFBtdWN6QmpFMWJ5TE8vRUo3aGxFSGl2OUN3Vm1JOVJVVU1UamlHMnNJ?=
 =?utf-8?B?M1lOYWZWZmF2Z0owcUE3VEl1Y2x1aUxtMHVCbEVaZFlZVWZhTFZETm1ob2FJ?=
 =?utf-8?B?NTIvL1BFa1Q3VkViMDBWUDVCRHRXbkFBUk5LVjUxdTBqSkFoc3JiOGVUc2Np?=
 =?utf-8?B?UHZNa055aERVM1hzZitEcEpuY0ZpVnlERmdBV3RJU2dwMkxvM0dENkU5aEgw?=
 =?utf-8?B?NXlQa3hRRUJBUkZLQzVaN2Z6MkRicjlKdzc2RWtLcjVyYkpSZ0MxMnBnVXdm?=
 =?utf-8?B?Z3p0RUwyeENEU2wwS3BkMU5DRU9nSFZMMUxZUzBhWGFidWZ0QUdqUzJ3Z05n?=
 =?utf-8?B?MFhaZVZEZkdWSmQxdGwrM3dFZ256M2VHTnZWZkVuZ3d4Smo2WnRKRWpGMXJk?=
 =?utf-8?B?d3BLSklEdWlBSEMzcGxiR295bFY4a0hhVEt5Z3J4cFc0cWR2NlFBL0ZaQUxw?=
 =?utf-8?B?MUlRNmdIQzNackNkallkdXNFbXhlNy9tM2Z1T0dBSUFJRDBpUUU0ZkNjOFdF?=
 =?utf-8?B?OGFrVm9yOGNPdnpER1Fzb1BVV0crQ1oxWlIyWGJRRnh2Q0R1WXlSeHZqYkow?=
 =?utf-8?B?Z1NhSkNnNmJ2TW84Tk9QcGliTVYvNE93MEZBRkcwQ0JrVkVEbDFpcmY1VzdG?=
 =?utf-8?B?eVljZzlQNlpOZ1VWMEc1WENlMGxaQ3JEVitCd2lBNzZJTTRtMDRua2ZaU2xO?=
 =?utf-8?B?NytVeDNiM0k5TE5vS3VNTTB4cE5aeGowV1hNd3lLdDByU202TDFhN21JNkZ3?=
 =?utf-8?B?Z3VwSjBMNnkzWjhUbVV2cDVjM3dxbms2dldoUGczYXMxMDdwdWR2dWhIc2Zy?=
 =?utf-8?B?NHU0QjFnUStEMkdNalpoNXFLWUNESFc3d0ZZVmNNT2NoWFZ0ZTJKdzV3VHJB?=
 =?utf-8?B?cm5JdmVmb2hqYTVIUXFLaWk1eVpPZXZpRGhFUm1QeHcyTXhCeFdodXFnN1Bk?=
 =?utf-8?Q?KUIZbj+NgJZro2ifZo3Zd+Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc15db0e-16f5-456a-a653-08ddf6cb0985
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:50:05.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SxldrxMEZ3HHLO2jBvYds5iJnAu5ClInSZKqr4f9RBV/NnFrvKxZZU4jUNcJmdXPyo8lwhX4ETB1mot7P0eUdLS16bo3tcdZW5HvPsWCDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6699



On 9/18/25 8:30 AM, Ryan Roberts wrote:
> On 18/09/2025 16:05, Yang Shi wrote:
>>
>> On 9/18/25 5:48 AM, Catalin Marinas wrote:
>>> On Wed, Sep 17, 2025 at 12:02:11PM -0700, Yang Shi wrote:
>>>> The kprobe page is allocated by execmem allocator with ROX permission.
>>>> It needs to call set_memory_rox() to set proper permission for the
>>>> direct map too. It was missed.
>>>>
>>>> And the set_memory_rox() guarantees the direct map will be split if it
>>>> needs so that set_direct_map calls in vfree() won't fail.
>>>>
>>>> Fixes: 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page")
>>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>>> ---
>>>>    arch/arm64/kernel/probes/kprobes.c | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/
>>>> kprobes.c
>>>> index 0c5d408afd95..c4f8c4750f1e 100644
>>>> --- a/arch/arm64/kernel/probes/kprobes.c
>>>> +++ b/arch/arm64/kernel/probes/kprobes.c
>>>> @@ -10,6 +10,7 @@
>>>>      #define pr_fmt(fmt) "kprobes: " fmt
>>>>    +#include <linux/execmem.h>
>>>>    #include <linux/extable.h>
>>>>    #include <linux/kasan.h>
>>>>    #include <linux/kernel.h>
>>>> @@ -41,6 +42,17 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>>>>    static void __kprobes
>>>>    post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs
>>>> *);
>>>>    +void *alloc_insn_page(void)
>>>> +{
>>>> +    void *page;
>>> Nit: I'd call this 'addr'. 'page' makes me think of a struct page.
>> Sure.
>>
>>>> +
>>>> +    page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
>>>> +    if (!page)
>>>> +        return NULL;
>>>> +    set_memory_rox((unsigned long)page, 1);
>>> It's unfortunate that we change the attributes of the ROX vmap first to
>>> RO, then to back to ROX so that we get the linear map changed. Maybe
>>> factor out some of the code in change_memory_common() to only change the
>>> linear map.
>> I want to make sure I understand you correctly, you meant set_memory_rox()
>> should do:
>>
>> change linear map to RO (call a new helper, for example, set_direct_map_ro())
>> change vmap to ROX (call change_memory_common())
>>
>> Is it correct?
>>
>> If so set_memory_ro() should do the similar thing.
>>
>> And I think we should have the cleanup patch separate from this bug fix patch
>> because the bug fix patch should be applied to -stable release too. Keeping it
>> simpler makes the backport easier.
>>
>> Shall I squash the cleanup patch into patch #1?
>
> Personally I think we should drop this patch from the series and handle it
> separately.
>
> We worked out that the requirement is to either never call set_memory_*() or to
> call set_memory_*() for the entire vmalloc'ed range prior to optionally calling
> set_memory_*() for a sub-range in order to guarrantee vm_reset_perms() works
> correctly.
>
> Given this is only allocating a single page, it is impossible to call
> set_memory_*() for a sub-range. So the requirement is met.
>
> I agree it looks odd/wrong to have different permissions in the linear map vs
> the vmap but that is an orthogonal bug that can be fixed separately.
>
> What do you think?

Yeah, sounds good to me.

Thanks,
Yang

>
> Thanks,
> Ryan
>
>
>> Thanks,
>> Yang
>>
>>> Otherwise it looks fine.
>>>


