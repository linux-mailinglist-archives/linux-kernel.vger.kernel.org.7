Return-Path: <linux-kernel+bounces-899539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EE7C58192
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3834D35840F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73092D661C;
	Thu, 13 Nov 2025 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xf+IuNQM"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2E221FCF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045739; cv=fail; b=bHiM9GPxlG7hzZsX2nlSIABl8dGXx2K749s0v5xFS15R7/S8jdTXoX7JK7bk2ZXtLHenb16CKrejqQ03/upc/myrqOElG67noXQdsxTGgXwWOCDx0jnUMxuoPk656yvrAEgTvSGAr901iw0pr6En70ouYSR3Srl0VJaN7ZESAWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045739; c=relaxed/simple;
	bh=7b6giLlxlxSh/P7BDC9p7jPhwC6b9YfiFt0oNPIT+bc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E3eK6ybIWI5IaJufa4M4FLMNo/a1wN+6kJEAXcIiZq8rFo+rSyFoEb092unhTRI6JRtnf447O+gCbUpDlZpg5xeO3J1jnc4TKTxzomozexmnoMbBVnDRNjheFZZkv9WfLGiFjH8Eu94S9AWSRiPz5kAYsGPrbxgKMR2cBSb0oxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xf+IuNQM; arc=fail smtp.client-ip=40.93.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6bjflGXFlqtnqB8ohEy7u5ineDAHakiKyqjqK51D6sbXceb7/TaF8HQ5JWWpIK2Xjc4VQiRKcs4VKIJQ7Ph0Qy6nbhn5eJcS0zBwKqVzOqpOmp+2CSLPM67oRKVgvRInTLgkSd4OjogrTC0jACCZUgjJv4Ho396c5n65oF5biYoLsLXLMWYlhK5BRIyNkWD7qWkV2L7ve0EfTADNHJ9YXQQ8hhlGFLbbsD9IF5yc9wfs/HF7CEqPUcKlaWO1lROtyra4C9+0NCtE4AMx09XYC09xlD1gfOhIQjkDzKPg/Z2r9Dk70NtYibADinO1+sZmxyFJuLlVib0Hr9DivwV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXMpc+dW+UE+p8g3zTsDXTr+2QiMscTnKgAZzvVapE0=;
 b=t8WArWhUuYK17RYhW8yW+xU5f1FgXrB9zIN89KV9Y5WFKldzAejYKQ5Ucx2CsUNudhLLvSS0aWBfgGTs2e6K94KmVLPt9L8Yh73DIWl7XtnH33fs9yBaSy3KvzsAY5h5ksaTpN5p3M9Yliq3TinzKUufd0vdPaYHYFrjsRF9IZKKs3s4cGRn4ac8Xi92ijzWBgSKBEr6zympTQIH5HVvt+DmRC7pNMXUly/wWavgba/h0xABKQIOz697YDVQkrSa/Y1dgysHhUOoVevDb1XR93LWNTU4t5/rwnANzJmSIxhhh2NIfBodCohXh0nQgHwG9vuRnYAZ84pK1PmeV4wL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXMpc+dW+UE+p8g3zTsDXTr+2QiMscTnKgAZzvVapE0=;
 b=xf+IuNQM5CWluwVsTsxFTDuqBhjjbLgB56VfuKj3FQ1eGFIumOHP/1L85KbD/zUBlpMeQ4h93mjtsdGF0cIHdcihkRl07V+IZG3J3cc6yiuWikQffLfFTuDsa9Ba7UuQZOPpyOGIxW/RZNIJX1TzuGD7LgI+AMB2ScB7qFwfcGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 14:55:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 14:55:33 +0000
Message-ID: <a9111a91-33e4-4f07-96c8-5d724a8429f1@amd.com>
Date: Thu, 13 Nov 2025 08:55:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/acpi/boot: Correct acpi_is_processor_usable() check
 again
To: Borislav Petkov <bp@alien8.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Michal Pecio <michal.pecio@gmail.com>,
 Eric DeVolder <eric.devolder@oracle.com>
References: <20251111145357.4031846-1-yazen.ghannam@amd.com>
 <20251112135618.GCaRSSAkqagSF_gr9j@fat_crate.local>
 <c430ae05-74ca-4620-bb11-ff40d2eb62f6@amd.com>
 <20251112172113.GFaRTCCfu2H6JpkZWB@fat_crate.local>
 <20251113142713.GBaRXqweHEuZw1bjD1@fat_crate.local>
 <e89951cf-3a1a-4ce5-92d0-2ba63e2fd94b@amd.com>
 <20251113143408.GCaRXsYM8aVHLN3zSj@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251113143408.GCaRXsYM8aVHLN3zSj@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 466462f4-7827-4d9f-2c2c-08de22c4b1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUlhQjFSY3NuYUpHUVhuZjZuTUNicUZYWmdPSVNSRVV2ZldPQjNKRVp3MVpX?=
 =?utf-8?B?RUFuaGd3cGIyYXJpd2ZSbmp6Y29KUzM2KzlLR0IxUE1GTG9VL2RMVkRTcXht?=
 =?utf-8?B?T3VnWVRMZTh0T1RuZmlGSGoyYnNpV3BSME45U0ZSWU56QUpMOWtDNHlYSVlr?=
 =?utf-8?B?Y2NCZGRoektRcHZqYXlrc1Y4NTJ4alV5N3JYeEFETm5MMGNwaEZTaDY5ZTlM?=
 =?utf-8?B?QVNUYjRBTi94WlhqZzNZM2Q2bkN2WTB1Mjd1MkJ2ZERrSkg5eUs4bElYeUZL?=
 =?utf-8?B?K2ZsRnpyc2tzOTJKZWtYeWE3N3VKQWU5a1lQcEhiTi9iY2tHKzFBVlVCM2hQ?=
 =?utf-8?B?Z04zd0VhVlhoSW1SWjJyWVZlTmhvT1E4bHFEM083OC9lMEt5dUo2M1hROURm?=
 =?utf-8?B?QXhZY3hSdnFkSXRmZHRXUko2Qy9iVDZ5UDZuV2hSZmxES2pERjBBRnc3S3Jv?=
 =?utf-8?B?NjluVEtERHBtanhOc25zdWpKZ3d1WGNjMWVJemc4elplSGVsL2djcEtqaWNt?=
 =?utf-8?B?RE0zblB3TXV0aDBJZnhzY0l1RTUvSTAvMGtEd0VuVnB6S2MwbTZQZnRqUHpH?=
 =?utf-8?B?SitCdklab3YydmZqUW1GeUJIbWVZdldhTkRvYnVmUDNMTytFMXVqc3E1Qi9Y?=
 =?utf-8?B?QVVzWEdEWDQ5SlFTdjUrMHNLVmNacm8zUGREUjhydHFxa0V6eWRQODZ1TFVM?=
 =?utf-8?B?OEZiR0psWHZPZjZxTHhnRzhkZEpOWTVmRllrci9xM1VteUdnYUJ3dlc4Umw3?=
 =?utf-8?B?S1dydjBHZGhReUNVcWs1MHZLc1NvODMyQnNUTnVxMjBwbWdqVk1paWpVMUtP?=
 =?utf-8?B?SlFkTERDeVhRcG1CYW1jcEZEMUdHUnpYRnc1bDVlZ2FkSlF2dnNZc3ppVklZ?=
 =?utf-8?B?NHBtTFlaWXZOTlVVV28rVmpvTC9XUWttcjBoYnJYSXJCb3lvb2xKemlzSlRn?=
 =?utf-8?B?c2dlekF0QkxDK3R4ZTVaMkFuVDJBdCtZRy9uTmpXNmlQeHl0aFkrL2pKb1lN?=
 =?utf-8?B?TDBVZmltNnNQZm4yNk1CL2dXMzdiVVYwQnFsUmVoU0VtTjZFSVFLeWswSDUw?=
 =?utf-8?B?bkM5TE13d3NpK2lwVFdQSGNIMDdHc2RQTUtabHhEcjlNN01zT1hwR3BQTkxn?=
 =?utf-8?B?UXBSSjBDLzVqenNncGhBKzFDcWNaTTJXTmRXbzd4K3FvMlFtYVBwMWRGeUY0?=
 =?utf-8?B?Wi9IOHFVQ3pNbkJLUmwxRHM1elU0VE52dHNNU1htQjRKdXNqY21LamZJT3V4?=
 =?utf-8?B?YStoSXZzWmJlTER1WkxVZWEweUZlMnBuUEJ0bzk0c3dkRUczRTBDWXBBTWxE?=
 =?utf-8?B?c1R0UEUvTk9zN2duY2JVcHh0a0pBemt1ckwxT0wxaHR3WUVnQlN5b0ZXbnRo?=
 =?utf-8?B?cy9YZGROczlKMmRZeFZnMWR4eHkzR3lqVXhIaVBGaHNQclBZV0N3RGU5UDRE?=
 =?utf-8?B?a1ZxYVZ0TjM0NWxzbHdReVI4RnJhSm8yN2RsUXRXTTRoeTMwMGhKRlpjS2th?=
 =?utf-8?B?RG93N0F1amZacFNVeXBKeU9tTkViMUlNWDR6eVlQWFFBRTZHR09mQkV1cjFW?=
 =?utf-8?B?c001UnpCNVFFOFN6cHNycFpEeGFOZHFCdm9rUzFZUG5HNEFHTEJzYmlETzNP?=
 =?utf-8?B?TUtHRmZidXNlaEVvUWI0NVBseDBYa2MyU0xSTWc4TXlRSkNmZThjTTZGSTNV?=
 =?utf-8?B?U3hVdXhXRUtEamxtTERWWkw1ekRJVUJNeU1BVkZvVEJZaVBnK1Q0Qzh1TGpY?=
 =?utf-8?B?WDFVOUlncWxXRGVUYjlUdWdLdk9rbnQ0VVJjOFo4ZmVNUjh5cmhZaFBrRUlD?=
 =?utf-8?B?bzk5ai9HSjVaSzVuQzAxQkMvb0x2VjhkMkpqWE0raGRETnZFaVZSTCtGSTNw?=
 =?utf-8?B?MW9RVHdHa2wxY0ZncnZCZUFrVkx5V042QlBBVnBnd2NQaDN0Qkh2WHpXODEv?=
 =?utf-8?Q?FMBJNDjjW+9pIZRz7O0vH2dQkstdcBbQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWszSkZWcS93YWdIK0Rob3JTbUJ2MVV5ejN0N1ZzT09FUFhaMjFGN3o4YTZ0?=
 =?utf-8?B?VldKWDRrbVp4VFdUd0c2NnRnYXR5QnAvT1VsajgybXM4dFRNRExDeXBuQkRm?=
 =?utf-8?B?WmZ6VlEwNWxZaGJONHRydkd0NE5TbkVQUFRYUDcxV29XSThwUWpPNHkyR2lo?=
 =?utf-8?B?czZkV3ZoL3lxeFh6Y1RJTjZKM01YalozQm5ySTFRbU9FVVdISk5ndlpQaHpk?=
 =?utf-8?B?SE9VYXpsdUZHUW1vVGtpRFNRY0l5T3NiU2tYUDl2bVZXVlFXVmpBTFVHYkxs?=
 =?utf-8?B?ZHZXcnZ2V1FwNmozaXdXMWVwc2tla2c2MytyOVhUQzFJd2M3V2dadXJocVdr?=
 =?utf-8?B?Z3ZrRmhtbENseTdNZ0drRE4wTzZ6d0d4TTFQTUFidmRUNTBHdXRXS2RZeEk4?=
 =?utf-8?B?QzRYZGc0bG1Ccmo3bkpBeDU2Mjc4VUlCUmE0U09xRGNhSFk4ZEdkcGtZbnAw?=
 =?utf-8?B?VzhwRlFJN0JTNzI2NG9MSWFFVEk3OXhocmt4c2RXMkxSZWJhSmYzMXNuNXRn?=
 =?utf-8?B?TnR3Qzk1QnVMZ0RXQ0hCUmJGOVpvOHhpemdzMnFxQmJPNzh5WTZsZ1F5V0Nt?=
 =?utf-8?B?eW1peTR4cmQ2UllMemcySlE3TTF4ZUpRcjlYMklJellTNjJFT3BFQVc0WHFt?=
 =?utf-8?B?ZlZLSCtIcm9OcWl3a21Rb1hVMmtobmxMRTl0TlZnbFA4ZjNVVEU4c0tOWlpM?=
 =?utf-8?B?K3FjRVFvOUxVOUF3Q290dWNJQlhtT0tvd3ZCeEYyZ1ZxTERWWXJFRUdIbHZO?=
 =?utf-8?B?a0FhUG80YXZaSURkTDZTU252elVUdzZ0VXlCSlFyM2RtZUVaTGhLczdYT3Zp?=
 =?utf-8?B?c09Dbk5xelQwRCt0SzAzSnJCbWtGRGpESUU0eGM0WW50VXVMa1JXUXBqNE0x?=
 =?utf-8?B?bmNuVm1qeHE1Q1dHcytQSlRTVllsT0J6RGowL0oyRHVNVWJjc1B0TVhhTkEy?=
 =?utf-8?B?SFFxV2FmbUVoU2pVWTN0S3c3S2pEbDlOcGZ6MHlrMHgwTTRURC9LTXg0Ri9w?=
 =?utf-8?B?M2Q2NFhYZ3Exeng0SStCTmxyOU5EMHhDYm9KdlZ2eHFTQythR0h5RDdkVmRx?=
 =?utf-8?B?ZWNxWitwWWhCVkxRS3YxMWdwYU8yZzNlTm40TURLUFBLNEdSUWsxQWlZUjdC?=
 =?utf-8?B?V2JVd013SWZ4dlI3U05EMXo0V1d3YjNJRk02aXAvcG9Ya1FoZXdsWmxDb01h?=
 =?utf-8?B?eWdjM2JsTndLQmVRRG1KODJGNzMzNnlJV2hpTmI2SkJ4aWt3ZTlWbVVsdSty?=
 =?utf-8?B?ZGgyYk9FMTNjTFdFSDROOFN2eU5ReUR1YzArdjlIZ2Q1MW1sUDhCOXRmcW1V?=
 =?utf-8?B?aGRWV1VmRSttOElXbEk5dW1jNlh4Qm9yZ2RjWkFIZG0xUmR1cmlsUFdYS1NM?=
 =?utf-8?B?UDljVEJyYThQaGZhVXp2R1dUU2J2UTkydU5YdjN1S1hWMlFjSUxIdUVzZE02?=
 =?utf-8?B?RjFsSDhUcGMwMW9OK3hGN3hUZlhwazhvNXpMNk0zU1Z1S0pNQy95S2tVbUVr?=
 =?utf-8?B?aGFyMklYaEVOSWhqWGtNeGdlZTQ4UXpVN2FXZDVKSm9vVDFGa2U0dElkOXRa?=
 =?utf-8?B?VjlzU0gyZnV3cE8vSzRWRlFvZWlqd1k5MEdqN212Z3N3NHN0LzBQUThlNTJB?=
 =?utf-8?B?QTAvTStyUDlWMkRtQzV0YmNKSFh2b0xRTitMVTQ5bTFSVzBhcmZ5cnBPcisw?=
 =?utf-8?B?MFhub1VvZ2dCUytpanBsVVpJTVdLaWhabDBkS2VyeHFtQXNJNG1RNGU1S2RO?=
 =?utf-8?B?VkZ1N1N2R2hVS3JwUGdzODFJTlZkZVc3elA4ZHRJaXBzbFprUzNMOG43dUpi?=
 =?utf-8?B?YWMzb25mS3lIb3J1SjUvNHhnTEoxS0ZuRzFPc0R2ekJqVW83VWl5TmZrdVk0?=
 =?utf-8?B?bGFsZm54akozOWZ1V2drZmdWZkMxdy9IQ2hRWlRPYjdvWXcxNTJHSXowdmpD?=
 =?utf-8?B?b1lkQm9kbVYxRExnejkrWXVwOGVPYTd0U1R5V1ZqVEtrOGFGendkSFM1ak01?=
 =?utf-8?B?cW0xTnROQ2ZxOWRZSFdwNlRSdmFSYUJHUkR0S1g1QWhLcGw5cldmcmhLYUw4?=
 =?utf-8?B?YXVRRDVrcEIzQ21MYVk1eW9VWGM5YWw3QnVZN3EyK2w2akxTc2RWNHZPdVdJ?=
 =?utf-8?Q?sJF9l4Cez5g5HpgLTLkvbeNQy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466462f4-7827-4d9f-2c2c-08de22c4b1e2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 14:55:32.9528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0puhPEMzIAFxpP50Iff9cMl9EvFfKwc+2K+T0m2OegeOei905UfTv7J0K4fZl9831fTaY4Nh0ftiTinIFpV0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

On 11/13/25 8:34 AM, Borislav Petkov wrote:
> On Thu, Nov 13, 2025 at 08:30:27AM -0600, Mario Limonciello wrote:
>>> +	/*
>>> +	 * QEMU expects legacy "Enabled=0" LAPIC entries to be counted as usable
>>> +	 * in order to support CPU hotplug in guests.
>>> +	 */
>>
>> I think it would be good to amend this comment to indicate that the behavior
>> of the "enabled bit" changed and that QEMU follows the newer behavior but
>> advertises the older version.
> 
> This is just there to hint why we're doing this fix to the kernel - i.e.,
> try to salvage an already shit situation. Any other deviation from the spec is
> not the kernel's problem.
> 

OK.

