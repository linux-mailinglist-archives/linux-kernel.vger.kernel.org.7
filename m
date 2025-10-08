Return-Path: <linux-kernel+bounces-845856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A847FBC650A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC70189A2AD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C822BFC60;
	Wed,  8 Oct 2025 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IEd0K+lW"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15745221DB1
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759948963; cv=fail; b=In46IXiuMJqfdBr2p7joloVXlTTjnbvl8IljyPdGQ27XGJNaEmXUUbCL2ric6jZWRNQXObP1QIBbxbeUsynquWqVc7JnT9G4lJDTqBWq0jL3AkPCTg31emjNlx5PibxJSBIo7kkXTVQBUpiILTTEG185dEf+9GUu/2Qr6lg6j54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759948963; c=relaxed/simple;
	bh=Lis8h7dwCgNU+Ikg9C+MmkmwUd1lRKspfaa2Ue2/cjA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fgpf1XGXua+2YeslicTPY2jCSAszeNaYDgA5/2I9aLA3jv/J2hElwdlUkVyGpQXqc9a6KNb4dDCB8PUWdmWpHK8nwmUoRnH9+VzDcpHfzsMD9fYpqaWON7dDdM6cL2FjiUfnHsQjasuekrGlo3CYIYUSY2lrm/3BPHF0hHKW5Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IEd0K+lW; arc=fail smtp.client-ip=40.93.196.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7MlHdtOqHB50279BB/P+DwjyiFDL/wW7CaGVgSk+Da/C3VzPKcegPxeD9snAKoHKSo+BvmE7xrKnl+LAdQ+Ex6XeRkyQpbcrcQZxSvTvcMA/EFd/Lcrh5kCCM/ywswjkmFa1oTsm36ZmJ2RB+olJuX+HYkH9MGUkeEgjMSvALBKUpcg3+41Ad9ICCNr2Eo7S/DqiZys2h7YH3N+mSA9+XxgmVgIKhYxJo2tVVkl3ev+h/DgfzlHQn6tSohmE5SMimnyZg2iuRA08RgP5qDVrZFag4MsOZs2hXFU1jBM5U2gI8rs9WpiYNOGK8Pm2lKcTvADGEgvqM7FF3yGkCRXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l35ifvweMK9bbNQ30jjzaHvZIfQkbMjxL8QgvMbslX0=;
 b=f8ki/ck+JYQEcEbmUaVzOAL8K0BYpIueAe7+sNVB7mgwDUtp2Aglq39v6U5J3d18o1B0L12l4X7mf0yL5Y3floK6nJ92K8SQ6d4+2shheXIpBY3LnS1X6zNrVr+C8iNpEftUkYdm7/iAQjfh+QVnMnkP6ehrgLSQOOiOiF4NNHr+QEQ6+E2ER6gwa6+M7BKjbn3QJOH/1xHqsBCSWan/mkWqyPqA6ULNI1FJfqGdEOoXIkCOeouPkoXm+UKOfF4EU3q18CW5sRsH+TXL/q0nKlXBx3/hBfgG0Sxd3EC7ZO/h1MAYHrG69VRX9z13Ou375CAQMBf2RYMB+sUrun1smQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l35ifvweMK9bbNQ30jjzaHvZIfQkbMjxL8QgvMbslX0=;
 b=IEd0K+lWQs3pJOiGP/WRINKyZoLa0yKMtq2QZziMbcMaqIyV+L+YYGfTapIN0+9timLo0lCbexKP2blULrRT0wRWy8SErOI2bacJSPiloC21n3FeAvkgD/Z2TzSVAJwZ/fwB8hZoFb0OTDf8qW7yNFVZHY8JL9ClLE6QzXMvdcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CY8PR12MB7658.namprd12.prod.outlook.com
 (2603:10b6:930:9e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 18:42:35 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9115.018; Wed, 8 Oct 2025
 18:42:34 +0000
Message-ID: <5af3e4a0-8013-4b50-af56-b8c0c6f71b5e@amd.com>
Date: Wed, 8 Oct 2025 13:42:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix buggy overflow when reactivating
 previously Unavailable RMID
To: Dave Martin <Dave.Martin@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: Babu Moger <babu.moger@amd.com>, tony.luck@intel.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com,
 gautham.shenoy@amd.com
References: <515a38328989e48d403ef5a7d6dd321ba3343a61.1759791957.git.babu.moger@amd.com>
 <fe06aa33-3351-45d4-a687-ff88a689be6e@intel.com>
 <aOaCDee7xbhA0ji3@e133380.arm.com>
Content-Language: en-US
From: Babu Moger <bmoger@amd.com>
In-Reply-To: <aOaCDee7xbhA0ji3@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::33) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ff4172-f310-4eda-1269-08de069a7254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUlNanFtTTNxQVlzWmVQM0w3eVNXYlhDQ2ZRQzNNZVV3NWZoWHV2dG55dCtw?=
 =?utf-8?B?WEprRllJT3BRcjVLazBLYWJqdEJ3VW5PeXdSK1FqOXZqVjF6YlA2NGRaS1NS?=
 =?utf-8?B?Zk55QTR1b01mbjVReTRBUThXbTZmT2tpNy8yQXZGQ0NhM1lBektOVFhWQ1p4?=
 =?utf-8?B?bjk3aDZLakVDK2VsRldSY2ltR1BMNlRtZmpCaEJnTk81aE80Yk40YnVGa0x2?=
 =?utf-8?B?c3FWazU5cHpsMW5wWTJUZUFrZ0RyVjc2ZENhT0tmS3UvOWY2R2twYTRRbnBU?=
 =?utf-8?B?NDFuTVR0SUFOQTd1cTM2RVpIeXNPWHRqWHkyOEZMdnhiTms2WVpRQ2t2Sisr?=
 =?utf-8?B?Q1ZvQVBId2RmOTRGQ3YxN290VE5NVzhjNUQzVTUzbzNoaXBRVEthMU1KVHpx?=
 =?utf-8?B?VGRtWk9wYlVKdmQ5MTJRN2FEOVB6eDhaelE2NnZxQXBpbzJodHlEd2hDUVh1?=
 =?utf-8?B?cDE2Tkw0NjcrNlhicGhZYjZ3QVgwRkxWaDV4QnE3ZGw5UGhQczlEZDhTWWxs?=
 =?utf-8?B?bTUxWElLNHJjL2hzdUdHdEc2WXh3WFBOeHJmcFlEb21meTNxdHZtc3ptMGdy?=
 =?utf-8?B?Mjg0Z2Y0STh2cU1pUS9vcnVHSjNCaVRweUwxellkNjh5WGlhc3I1UnQ5TnZI?=
 =?utf-8?B?d2pxUUZGaGNMcXdyL0g3M29HKzUwRDUxZ3NXay81SlZxaDVIcHNyZVViMEpw?=
 =?utf-8?B?YTBQdTJzSlNhTlJkdEFnRWxWNGhsZXdWWHZHQ0lCWkY0V1RGakpjRzJ2MitJ?=
 =?utf-8?B?M3VvMzRjb09YaEgrOG55aTdXeURsUElGV0ZGQWhIR3hWT3AyajJSSFd0Y0Ru?=
 =?utf-8?B?NldKcStJN3RVSGIyMW5FWXFvL3VsQURIclJXdW15UXpPWVhTR2NHZjFZa3Ns?=
 =?utf-8?B?eEJ3NFp4VHJDMjV5akU5ODVVWlFHUkN3Zlh0Zm1VZTd5dGdTUXZMS1FQUjJu?=
 =?utf-8?B?TmNhZDlFTlZ6TW0remk1SDBidVBkbkw2ek00N1JBemQ2YlBpaGJTUlRwcmgr?=
 =?utf-8?B?YWY2L3Rxc0s2RmQxR29hRVZDRHEzaVo2OHoxd3pjckVUTVJaYXRsU0hQVFo0?=
 =?utf-8?B?KzhZQWZ4eGFNK1JuZEI5QU1XcEVqOHRkVWM3dDlka1F1bW9UeGVnVXVsdllN?=
 =?utf-8?B?ZjRUdFRwOVkxR2hsK3NRZjhlNDlxQ0NmSjRvSU5SRy94VDhwSmM3bnFJNHVY?=
 =?utf-8?B?RzBQZ3BtL2cwSGhDUlV0cU5Hc0s0eHJCZ0RoWTBwaExQVzBpMkhseTl1VlBT?=
 =?utf-8?B?eXZHQ0d5aFFhbDBpT0xMODZLODlXREJhYWErTHZuS2xhT2t5VkxCbllVNUY4?=
 =?utf-8?B?bld1STNRK1QzbXlsMWlxV0ttY0xIRnFydHNWTzlCQktkbGhMYWdnWnRHMjNX?=
 =?utf-8?B?bmk0emU2cVZiNmNjcG1IREpiTjZJSE9ydDIrOEZXSWdGTHBMbzd1eHh0eTNv?=
 =?utf-8?B?dVcvR2JLSXVKUEFiblA2YTZvSXpwSUVLT3hBZUlnUUh2TUxBeDdzOGxhNnlO?=
 =?utf-8?B?VEM4RWNPTVVTL2ZXUzgzdWpNcnJLR25iWGIvQk9NQm93SVhGWG1xQU4rcTVG?=
 =?utf-8?B?ajVyQkJxV05HNVVJMnlwSC9vaHJqL01mQjlwdE1vNTZHMzJiVmFJMEZGb3or?=
 =?utf-8?B?VEcwV3RvVThjV09jZEVhbkZkWlRudzh4NnY3dGFtNkhqSjE5VnFmUFArSEw2?=
 =?utf-8?B?NXM1TFN2VElmSUxxT3pNNWlPcDVZbDZHQjJUQ3hFZlVqOVU4UjNwK3RPa1Nr?=
 =?utf-8?B?WXpMYWRuaDVsRXl6R0F6TG95N2hqdGJaR29RbFF6RWpXYS8vZDMyUDd1ejlp?=
 =?utf-8?B?dy9sNVBWVTdOdXZ6RFF4cm9rZzdxWEZ3L0VUMnA5UkpsYktIRVFrZnF5MDFF?=
 =?utf-8?B?bCtRVlVEWDJGTm5DblFvY1pZUGp1eGxXblltZ0FjQ1A2d21OMnhxZ3pHRjJr?=
 =?utf-8?Q?eMmIXPZSrMVi8nUJoUXVYf8Fm1l01xdD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b09oRjl3TDhhYzluSWVsL3lqUzFqRFNvdE9Kb2M5L2VOVE9Cc25sNEtlOEVp?=
 =?utf-8?B?d2twcUtWSTkrdmdLd2FGRThobCsvaHVONWlyS3Y3S2FBUlFYTldJMytXR3Vl?=
 =?utf-8?B?Y2ZwUE9pcXdFc1pCNEc4MFBtcFNlYlVvNVlxSDJtekdnMTUyVDRkYkNoVlpV?=
 =?utf-8?B?TjRhZE1pQWMyZkpEVHVsNStmb3M3ZkVKZElCa1FsQWJvVmpUV3cwMEQwYlRY?=
 =?utf-8?B?aVBub0xxUUErTmh2ODhtU00xVW9GQklmNTVUbXJxdlJmcjV1SXFUUVlrRGZv?=
 =?utf-8?B?bHdLeXNZcm9qRk5qNjhUaTlNazdHRGxvSjhtRFpSVThZZ0VzTnlNQmN2bmhH?=
 =?utf-8?B?TjdrZnlKRU82SUxFY0Z0elI0Yzc4cDZKWm9qSjh1MmlsZW5JWUhqWEd6d3Yr?=
 =?utf-8?B?VHpsRk1wQzVFSmYvV3pJeE9OSHFSeGJldmpsVThqM1JUQS9GM0VENEVacU56?=
 =?utf-8?B?YmJnK2VrMmZPR0Q5OVZiYXVlMDkvbXRtL1JsM2V6RGtWTVN5cFg4VkFTajg1?=
 =?utf-8?B?MXpoMXd0ZjVFNkZvOHJKc0kybWVkMHFSOHgrWXBQOVdLczNqTjJzeDZLWnEx?=
 =?utf-8?B?dWZ4M3ZBRkFqSXRNV3BkOFFxN24yc2oxTlB3VlRnWlhxTGQ2SDRTUldpSmJY?=
 =?utf-8?B?b0FQL2ozTjhQQ0tLcWZEN2RrUS83UzZkWjdvbUlFYTFIMGYyK2E1N2VEdkJW?=
 =?utf-8?B?RHcwVkQ3OERDYS8rRXQyTkxuMFFOMENWMDFkSndPaHZJMFNORjh3dUdIUWdT?=
 =?utf-8?B?YVdTWS9aVlU3N0p0Rzh5Z2xWOWJXWWxJM1NnS1Z3NUg0b2dmVE5yejBoN2Qx?=
 =?utf-8?B?aHpDT09BdUhlMlN3UDRYTVFNWVgybjl2RXdHNnNBaWpnbDVoN1lkNjlHaEph?=
 =?utf-8?B?OTZSQ3ViNGZVUnVzWHR1UmZGVFEySm1JRkV3N2tKWGZRZHBLVTEzd2JtQUt6?=
 =?utf-8?B?cjFNSGVCaEFJSFBaNEkxUTZ6d0x4eUlJTGZYWmRwOXNTVmFCYmxqNUtFVEpy?=
 =?utf-8?B?ZDFHUDVsU3NkSGtXUmp5VnVXZ0d6MGR3TmlkOWhTb3VlWTdpNldBQkhGaFY1?=
 =?utf-8?B?dU9hUE5EOGpPTU9XR0p6QTBRUmhBRWF5eWtSeXN5bDhnRmJLakdyaHdWN2F2?=
 =?utf-8?B?NE1WZC9Wcmw1MVhXWGd2bEx3YnBDVUEyalljNVYvRFlIcFZXRmZvMWw0ajF2?=
 =?utf-8?B?OFJyUDRNVGJzeHBnSnlCbGVKSk9nRjZDZ2VqcS9STDR6RUt0SmdPcCtkdHFO?=
 =?utf-8?B?UDNGZDU0VnFiQjFuOTBCWVZQcFQzYy9DSm1adkdhQTlXN3ZPdFFWRnFPR2Vy?=
 =?utf-8?B?K1JOYkdBRlE1SE9lbTcrUkZEc2VBY2s1NW9RdTEzMHBVUlVQYkoySDZQU3pa?=
 =?utf-8?B?YzRvZXVtOTBmRlRhTkhlSUdxc1h6S0R6SytBREtBcktoeThQV1Eyc2xRek9J?=
 =?utf-8?B?dHFXZGUrQzJSYnFIQ1BqNW9pdzFWYjFFbyswQ2haSHF2c3IzYlJpcEVvNTRv?=
 =?utf-8?B?UHhGRUpITVRLV0g0UGxxSC92dk9sY0lTZm1OWmd6aFI2aEZlY3IvcHhJbnFR?=
 =?utf-8?B?bTl4enNnbWdwdWpnRXJGU1Z2M29qdStVWVRqbFhFZmNQa0U0WFp0aGR4amVH?=
 =?utf-8?B?YVpobm1sc1VBTDFLMUt6aWx2UG9oaVBoYkkvdlErZEExL2QzZkp0MG9UZnMr?=
 =?utf-8?B?eldWSEVESndPMndLM3hFTUJnVnFxV2JrTlpwNDZMQmlSaTZRb1lkaXZhYjN5?=
 =?utf-8?B?RFFwYktEZDRPVUJ2cjREd0ZNbmhjVXJNL2Q3aVF6cVVUMmd1TVBZQmdUM0ht?=
 =?utf-8?B?RzEranJvTnlBUUJZOWpzNTNHcTd4K2pNR2o3S1NQdDFtMTlRRjdRSENQbTNI?=
 =?utf-8?B?OXhSeFNxb0drQmRzMkE5V2h6VWVyS3BwbzNScXNLeVBDNlR1SFpSNCtBcUxL?=
 =?utf-8?B?T3p1VTN0U3dTZk5GamZ4djFMdmRqV2E1a1k1YjVYaC9jQ3dvckRMUE1DWDZU?=
 =?utf-8?B?MWZseUZUOXF0VktGS29JN0loaS85a2VFQU0xTk00NU1PMGhQa0YyTy9RM3gz?=
 =?utf-8?B?NDFrK0RVbjgxODk1VVQvZDB5bW1IUHBNZ2FHLzFMbzVKQ1JVT1dDM2J2cFFt?=
 =?utf-8?Q?hS5A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ff4172-f310-4eda-1269-08de069a7254
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:42:34.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKxK/yP8hAuySI3wym/vNcnvsTRo8FP/OYNhmV194Lsu7i300A9frnKD5PBzB5no
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658

Hi Dave,

On 10/8/25 10:23, Dave Martin wrote:
> Hi,
>
> On Tue, Oct 07, 2025 at 01:23:36PM -0700, Reinette Chatre wrote:
>> Hi Babu,
>>
>> Thank you for catching and preparing a fix for this issue.
>>
>> On 10/6/25 4:13 PM, Babu Moger wrote:
>>> The issue was observed during testing on systems with multiple resctrl
>>> domains, where tasks were dynamically moved between domains.
>> (please let changelog stand on its own and not be a continuation of subject line)
> [...]
>
> [Quick, drive-by observation:]
>
> Can I add that the commit message also seems way too long?

I agree. But problem is bit complicated, so had to give all the steps.

>
> I think some of the description of the problem symptom could probably
> be after the tearoff -- there doesn't seem to be a clear statement of
> what is actually wrong in the code, or of why the change made in the
> patch fixes it (or if there is, I struggled to find it.)
>
> I puzzled over this for some minutes before I figured out this patch is
> fixing something that is not upstream, yet.  A statement to that effect
> would have helped.


No. Code is already in upstream. Just that it is not resetting the 
internal state when RMID reports "Unavailable".

Updated  the changes log now with brief summary in the beginning.

thanks

Babu



