Return-Path: <linux-kernel+bounces-788853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A48B38B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6364A3A4711
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558CD2F39D4;
	Wed, 27 Aug 2025 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3iYEi6LR"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EDC27A92D;
	Wed, 27 Aug 2025 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756327196; cv=fail; b=omUbs7JlhfFkD9E3+cJyj1NbS5f7Q/LhATvlcD8GgNzFwMMxqwdtljpSLlhq54vRBSS3saFyOCMjxuMY17hn2zllWsGHkBirEz6Dbd2dVCYyu2V1o3Z92lAEj+2WMUM7M29NkAicrEPs1WQ0XDytZntXOI9KvkSPnLMo9bwYOEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756327196; c=relaxed/simple;
	bh=qgRIBEAZhCMVgxyBCbx6e0wOYBkiu0vMkJx0bMfu7IE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ETUfZG3OWso5aDxrSHot9In8CeiLTdDTNbCTN2P9adIwpAUi9z4xlN8GNGT9FPxjLHxOLn1jzsypvsoeHqZgRYlv4ObCYznwqVCo2v5HvluhSd+AFOIVFBLrCuPvUzmTQ15vOQW6xujxcvloZxb8Ut1C2/qEwCSrURUci4CQsvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3iYEi6LR; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+bqn0IeukyI/DnxJegCkU+e1WPS+j8fo33L110NV0r13Srsg5nrg/6j2kwsO7bMAj4Ph22wKY3tDrO8oNdjlKvZdpFQ0/YupPfHq6BfqfrC7gnaydbqLrVBuYeQThH+gYdgja/sKeJjwCZDJ1RwqMZWiK1Ac4oVR3A3mUmBXPlRGr+kO6tKo2bNqdkvjhPO+7Q54bLCX7j2R0z9CdY7WbOMax6tIfDmgROxNliT4wfoqWcUV597fB6kfIzgefeDnixXOKwU3+0x82KtdwcYamUJqfLLCdXvyaMfo+hyhd6O/CJs3WPNyrk6WRquTM882IzpjyCRIGdz5UxiKN/9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pSpVhSxO4qN15FzHzQjQ3VgWSMFKo5wOm401vsVsQ8=;
 b=ZdIdY4aZeLXbNji7H1PbenBXabE4V68kcAAgnVd1kYAbZgl4gjDssefSxaXqS7PSsjgj1pmNfblwXoz7vih5rlpKhND5xTJMR9YdP03HZR8NsloHJ4yWAURKgfC4e4p2Omi1FILXwoXOnz4iF7COAw56GuZQsHhnVxJt05a1VlnBLLg1lwJfUycOL0M2FHo8WpdLjosx33LIcAzCUfQcAbR0RJ7XBpkz2mEVwbcmEqkATYqjfVHivBCSVVtkbbhn/l1D4UBgWurJkGFRI7if96CpkxElraPGDpFD43KmJLlp/zYjpKZzgD82gc//LMXIMXKuGYL6BX76/8+fhIQiBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pSpVhSxO4qN15FzHzQjQ3VgWSMFKo5wOm401vsVsQ8=;
 b=3iYEi6LRQxcXoLLerV6uoqekKpNCvwwn8Uos+LcFobCqZyhJzRfCpvoswRAE0b/lTXnMKPL6zaKAY+LzIMrTexg6IrO1zlfBo45QJ92n6Q22TM7QjSADKsUE6+1WATn380l4OyGmhaQWQ8mOLz4GrSRhI6VKcHTnYg1+e2PlnPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SJ2PR12MB8012.namprd12.prod.outlook.com
 (2603:10b6:a03:4c7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Wed, 27 Aug
 2025 20:39:47 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9031.030; Wed, 27 Aug 2025
 20:39:47 +0000
Message-ID: <d11e20c1-1162-422f-8915-97efa69644c7@amd.com>
Date: Wed, 27 Aug 2025 15:39:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/10] fs/resctrl: Add user interface to enable/disable
 io_alloc feature
From: "Moger, Babu" <babu.moger@amd.com>
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
 thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
 yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
 ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
 andrew.cooper3@citrix.com, perry.yuan@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, manali.shukla@amd.com, gautham.shenoy@amd.com
References: <cover.1754436586.git.babu.moger@amd.com>
 <f53db5c6dd7d0580c0cb1f252d947357d097842b.1754436586.git.babu.moger@amd.com>
 <0dbdff85-1d32-4540-984c-e8eb4b940cc6@intel.com>
 <d5438a53-c803-4704-84db-1da019f50a3d@amd.com>
Content-Language: en-US
In-Reply-To: <d5438a53-c803-4704-84db-1da019f50a3d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:8:54::33) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 866d569f-93af-4a61-76cd-08dde5a9dcba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWRhSUtObE5BOW80dWdNeTNkbmFGNWJGMWIvbWliVHg1SFVJbG1PVzJQOUd3?=
 =?utf-8?B?cEpPUHFDbENBQzlSRFNXbEFZN2N2ZjVBT004OVlxa1VsblhtWVNPSWpzdDhT?=
 =?utf-8?B?QnhaaFRzcElzUG14dmxCdVFKZE5USzVvWGovNVZDL3lSekg2ZUUxYTJhRU9O?=
 =?utf-8?B?R25aUVZ2YXA2Zzdmbmo5MHNhSFBEb3Y5cDZCTGVLaHZ0cDkrMzBHNGJVQmNi?=
 =?utf-8?B?VGJxMFg1RHhSbXorOVJtNGV4NmVVaHRhejN5WE16K2xhV2M5akhnekdROHdY?=
 =?utf-8?B?Y2RyZ1B1TFJQSUhKdFVvRG5pd2dhbkNNU1hqVlZYTjZmaU5EZzdZc1llUk9z?=
 =?utf-8?B?R2RBZDg2ZzUwdHg3R1Q5YVFpNVI1VFNjcitveTlxZkovUzA3cEtqY0p2eDlt?=
 =?utf-8?B?VXhkK2hsSVg0SzVJK3pEWUJTUXFsN1RFalhDcHhBK1BTZTI0M01qcHl1ZnVw?=
 =?utf-8?B?RVdEcHYvTHkyaXI5MFRRdmlubHFtMTZ2QVIwUW9RNkpGVk53SzFNMVphd1M4?=
 =?utf-8?B?bWN6WXVWUFYyU05yZ3FNZ0hNZGNDYU4zemI2UHZMOGIvTGVSdHJTdW1XMnNS?=
 =?utf-8?B?ckJiMEVRczdlL3cxcEFtOVpuaFU0MjJ3SE05MGtOV3h2bCtpcy9tanRWaG1w?=
 =?utf-8?B?TDZBY1dTKzRSWXZhS3FQOWxwMGRxUUplMXRicmJFenFNaE8zNklzZGRCZlhx?=
 =?utf-8?B?bng4SHpudWR3Mkd2QzlESmxFRndhRkQ5d3FpQlNvQ2ZXVUEzeGhpWllSd29F?=
 =?utf-8?B?UE54anRPdmY0Q0xzczdFdUtnaDhxS1pyZDZKRk9yOWM4WG5seGFCeU80K3hm?=
 =?utf-8?B?RStrRVIzUkltM2FOQUZaNWtkeU96cUc5RlhCVE5wR1h4MnBKYWUrOTJjcHlL?=
 =?utf-8?B?Q2ZVbFhXcGo3N1ZHLzJ5RWtCWWpRbGR0WEtkektTd2RlVlJhT1VUYk1mdGNy?=
 =?utf-8?B?dFpRR0MrNzFKQUdqNkpHZlZpNmRCaGR5dmg5RTlOM2NtRXUzSmZSRG5jRlJ2?=
 =?utf-8?B?U2RsUFdIdkE5bTJoaUpYY1F5dmI0VW1CSGx4Nm5MOTFHaWkvTXIwaTQ5Smc2?=
 =?utf-8?B?RnZZR3h5bHVGSWd4WFV4c3JQRHRHZ0pSUmp3Tk5GT3hXaWMvbVNTSjB5S3lJ?=
 =?utf-8?B?ZDBMQTAwQ3M3dStIejRoaXJENTR3ZTdGUDMzL1lMWXBKZFQ1U3huaEN0Q21k?=
 =?utf-8?B?VVd4NU9scjZ2Q0hNSUJTcUVpUjdDRFdmdjhYNWlhbWlZZ2NKK0gxUXE1YUxv?=
 =?utf-8?B?dkFEbnUxeHVpb0lBeDB4VUU2RWZ2WExrVG51WkRZbEM1d0NyUUo4cUJzOXVL?=
 =?utf-8?B?a2VoaU1TdEQ3anhPWDJITWRBT2FYdzRmdlc3emMwSmF0RHc3UkRVUHRPQkN4?=
 =?utf-8?B?a1Z2QVN1Y0lPZnR5dVFWSnlqVWxHejVnQ0NUQ2hPSGRzdGFlWTY3UWh3MUhv?=
 =?utf-8?B?WXBZcm82R2dXYWhwM2FEYmNkZC9wb3M0RlZ6eGFIWXpjVSsxSitpUVBRbDFv?=
 =?utf-8?B?MzN5VzNkZmRTU1l4SjZ6K3RPZ01nQ09UVUlQT2NmdVpHQzFIRkd2bCswd0xB?=
 =?utf-8?B?Zm4vWFpXYzhmS3JNYmsvc3FyZlhFMVBPc1dEL2NOWVZ3dmN3QkVZYWh4TUZC?=
 =?utf-8?B?VFhPTDh3aE1xdFNhdUtrSWNHQ3FDVzNtUXFFTEhPNE5zeFRucXJEV3E0Y0Z3?=
 =?utf-8?B?cXpvUTFhRUprRlpSVXYwTms0bmFCM3dCTk0zK2JXNzhYK3BZa2dBRE1wK0FP?=
 =?utf-8?B?Z3BWaHhTU2FDOWhtRGU3cWFaaVpxUnlyRjFEalk5QmVQVllVWlRvbEVJREhN?=
 =?utf-8?Q?GHVok5ci70pipBvWR2bcK3p2SOyt1+BSGBTxU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2EvZVc2SE4vTldMaE04ZkQrenNQOUdjaEFLRDdtYkExckhDZmpQVnphd2hP?=
 =?utf-8?B?TTVzR2NGUWhSUEVFUUs3VEVwSEUvM25BdFlNMzMyM1dxR04vaGlwaXo1MCsz?=
 =?utf-8?B?TVgycVpBWE55UndpSHVFaGJ5WUN1Zm5vY20wYXBjZkRSNFpwTjFrU05xcStu?=
 =?utf-8?B?bjBNTm9tY0N2SU84b2c5WHFUdVEvVXJnb3c0bXZvOXNsM3AwRWNVVC9rUmpD?=
 =?utf-8?B?YXZySzRIZVdGbVUydmMreWRPWFo4dW5FRVk3WHRFREttQTNaaUZ1TWRMc1JB?=
 =?utf-8?B?cnk0MHllT0lHT2tvdmpub29Kenh4QzZSSkJtUE0zNTBVQTV4cHlxNnV6SlZE?=
 =?utf-8?B?bXRGOS9WZ1JjbUVRM0EwYmE2ZnljZkRuT3gzYjVjY0pUdEI4N0F2WU9QVWJK?=
 =?utf-8?B?d1hpVG1HbFZTQUIxcjZEMUs3aXFTOGxZVTljdkpVOVllS2FGM21tT2IvalJP?=
 =?utf-8?B?ZEdydEM5OXg1cldOY2pxRE1qbWUySWtoVUl6bWNlSnF6TS9ZK1ozd1ZqYTFw?=
 =?utf-8?B?RmFzOFJwcVkrVjdHUXJ5MG5zQjh2WGE0SlQ2ZWE1c1FwOHNiTWJ4b3p0M2ZZ?=
 =?utf-8?B?bmVGQzZqZEw0cUM2ZjdRcE04TjNLVEZvb1ZFVGRDeStESC91aGhWUTZoSlg3?=
 =?utf-8?B?VDNBenY3TjZZcWhvZVN0cDVLbTc2a1daVUZsV1pLRXZDeWs2VUpnN2R4dlM2?=
 =?utf-8?B?VGMwRm9acVR1cEZHUFF0RkIwUTl6TnFLQStGbTN3eGxpNk1LSzVvZUJrWkVw?=
 =?utf-8?B?c1Jnc1FKV1NYMk83QkhyV3ZEcWNkV3dqbkt5TSt5SUU1ZTRJeVBjeUphVjdN?=
 =?utf-8?B?MmY5Y0pZR1BHZmJjd21IWVJJZUhuMTNtcWVaOFpnL2dONDJ0TTY4L1dLVlc1?=
 =?utf-8?B?cStaNUdaUW1kY09tM3lxanpFcy9td0ZlRUJIM3dXcEt5Q1hHc080RjNETkl0?=
 =?utf-8?B?NTc4WE5IUXpFcTJjcHhlMG1VVEh4N2U2ZVlTdTRqdzRMZFJQVzRBUGRFY2Zy?=
 =?utf-8?B?c2hDNTFqVWJQOUFVRlV0S3VBY3dINmxHYmxzWjh1bXZtbmtDdkhoWFVzbmxT?=
 =?utf-8?B?SDRLcXlxU2ZadkdwVVdKenZiNVpMd2JjOUplYVFFclUwNzEyU29KWWQyejlu?=
 =?utf-8?B?djhOUE9CM2VmNUNtTnJZMnhXZ0ZuVTJFTUJ4ZC9JdVZ5dzBTdmZRbDZmTkpi?=
 =?utf-8?B?MlJ3R0RMZTladlJTMXRIdDRobHhFNVdmeGx4NzhOclVUa2I5a2U1L1BJeTBT?=
 =?utf-8?B?eEpKTzU2Yko5QWl6SDNvY2dhT01Gd20vUkVGdGRnTGR5TVh3QjFraE9KcmR6?=
 =?utf-8?B?UEwxQ0Q2L2ZxVzhoZ2owRFBZRFZldU9lckVmMUpNbHFpUTYxVTFtMlRkeXRV?=
 =?utf-8?B?U0llVGZiMTRNSnlvOUVqeFpaZWdaVjVMY1FkYkJYUmVuZm1mRExZVlVWWkNs?=
 =?utf-8?B?ZHBhdS9OVnc2NVhQQ0RBZW1sbVZrdkloSElUREJRVXhnalpXdDZxU0xVdXhE?=
 =?utf-8?B?N0cxVTVvVEN4NlBNcmprb0NpcmpMRTVDek9iWWtpZnZFSHkrSzc2UC91YnpT?=
 =?utf-8?B?RHpNYWhzOWRQa2xNbXAvZDRqVUx2NVpBNFc1aDFFOWFOTVZLc3RaQTgvR1pI?=
 =?utf-8?B?eUl6dmU0MXdlNk9jOXYvdGdXdTl4T0xaR2U4OHB2M1J6NC96b0lzVUFOZkNQ?=
 =?utf-8?B?MElNMDVGdklYUDNnQmpLaFFxMUNhTnlvTGEzS1NIVXozSXV1T24rSUxKbzZ0?=
 =?utf-8?B?VXFpUENvaXJDSlRPcmdtbS9YY3o0WXlPaEEzY3RPSFpZZ3kwVGE5S0pNaWw3?=
 =?utf-8?B?VG1TQjgwTnFrd3grYzZqeDEzdkxpamxjeGlCa2F5VnAxYW9Pa3MyR1ZtTGc1?=
 =?utf-8?B?L25RUEsyWUh2MEtzZzZZZkMyR3FxUmxwanRpQ1lOaW1wSHExbDA5Z3VHdFli?=
 =?utf-8?B?cHBHaDBiNTVSYmNUdmZNWWs1U0UzaWVzdXFjbUVWb2YwbGhvbVFUYU5xUUwv?=
 =?utf-8?B?MGV4cXg0djBXa3R1L28vNDFYelNvUnNvQTcybFdaSGY2UzhXMW5SMlVFR0Zj?=
 =?utf-8?B?bEc2dzdyb2NNUnJHdzhhNWt2MEFTWFNKRm9ocGdJNXZhdnN5UVdwbWxVc0hI?=
 =?utf-8?Q?b0b0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866d569f-93af-4a61-76cd-08dde5a9dcba
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 20:39:47.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHCHOlhvwuSkywpcFI+PLJZIUXOdEXocLsxY5MKYfwG6hq40JtMh3y8I2n0nkQv0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012


On 8/22/25 17:53, Moger, Babu wrote:
> Hi Reinette,
> 
> On 8/7/2025 8:49 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 8/5/25 4:30 PM, Babu Moger wrote:
>>> "io_alloc" feature in resctrl enables direct insertion of data from I/O
>>> devices into the cache.
>>>
>>> On AMD systems, when io_alloc is enabled, the highest CLOSID is reserved
>>> exclusively for I/O allocation traffic and is no longer available for
>>> general CPU cache allocation. Users are encouraged to enable it only when
>>> running workloads that can benefit from this functionality.
>>>
>>> Since CLOSIDs are managed by resctrl fs, it is least invasive to make the
>>> "io_alloc is supported by maximum supported CLOSID" part of the initial
>>> resctrl fs support for io_alloc. Take care not to expose this use of
>>> CLOSID
>>> for io_alloc to user space so that this is not required from other
>>> architectures that may support io_alloc differently in the future.
>>>
>>> Introduce user interface to enable/disable io_alloc feature.
>> Please include high level overview of what this patch does to enable
>> and disable io_alloc. Doing so will help connect why the changelog contains
>> information about CLOSID management.
> 
> 
> Sure.
> 
>>
>>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
>>> index d495a5d5c9d5..bf982eab7b18 100644
>>> --- a/fs/resctrl/ctrlmondata.c
>>> +++ b/fs/resctrl/ctrlmondata.c
>>> @@ -685,3 +685,140 @@ int resctrl_io_alloc_show(struct kernfs_open_file
>>> *of, struct seq_file *seq, voi
>>>         return 0;
>>>   }
>>> +
>>> +/*
>>> + * resctrl_io_alloc_closid_supported() - io_alloc feature utilizes the
>>> + * highest CLOSID value to direct I/O traffic. Ensure that
>>> io_alloc_closid
>>> + * is in the supported range.
>>> + */
>>> +static bool resctrl_io_alloc_closid_supported(u32 io_alloc_closid)
>>> +{
>>> +    return io_alloc_closid < closids_supported();
>>> +}
>>> +
>>> +static struct resctrl_schema *resctrl_get_schema(enum
>>> resctrl_conf_type type)
>>> +{
>>> +    struct resctrl_schema *schema;
>>> +
>>> +    list_for_each_entry(schema, &resctrl_schema_all, list) {
>>> +        if (schema->conf_type == type)
>>> +            return schema;
>> This does not look right. More than one resource can have the same
>> configuration type, no?
>> Think about L2 and L3 having CDP enabled ...
>> Looks like this is missing a resource type as parameter and a check for
>> the resource ...
>> but is this function even necessary (more below)?
> 
> May not be required.  Comments below.
> 
>>
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>> +/*
>>> + * Initialize io_alloc CLOSID cache resource CBM with all usable (shared
>>> + * and unused) cache portions.
>>> + */
>>> +static int resctrl_io_alloc_init_cbm(struct resctrl_schema *s, u32
>>> closid)
>>> +{
>>> +    struct rdt_resource *r = s->res;
>> Needs reverse fir.
> 
> 
> Sure.
> 
>>
>>> +    enum resctrl_conf_type peer_type;
>>> +    struct resctrl_schema *peer_s;
>>> +    int ret;
>>> +
>>> +    rdt_staged_configs_clear();
>>> +
>>> +    ret = rdtgroup_init_cat(s, closid);
>>> +    if (ret < 0)
>>> +        goto out;
>>> +
>>> +    /* Initialize schema for both CDP_DATA and CDP_CODE when CDP is
>>> enabled */
>>> +    if (resctrl_arch_get_cdp_enabled(r->rid)) {
>>> +        peer_type = resctrl_peer_type(s->conf_type);
>>> +        peer_s = resctrl_get_schema(peer_type);
>>> +        if (peer_s) {
>>> +            ret = rdtgroup_init_cat(peer_s, closid);
>> This is unexpected. In v7 I suggested that when parsing the CBM of one
>> of the CDP
>> resources it is not necessary to do so again for the peer. The CBM can be
>> parsed *once* and the configuration just copied over. See:
>> https://lore.kernel.org/
>> lkml/82045638-2b26-4682-9374-1c3e400a580a@intel.com/
> 
> Let met try to understand.
> 
> So, rdtgroup_init_cat() sets up the staged _config for the specific CDP
> type for all the domains.
> 
> We need to apply those staged_configs to its peer type on all the domains.
> 
> Something like this?
> 
> /* Initialize staged_config of the peer type when CDP is enabled */
>         if (resctrl_arch_get_cdp_enabled(r->rid)) {
>                 list_for_each_entry(d, &s->res->ctrl_domains, hdr.list) {
>                         cfg = &d->staged_config[s->conf_type];
>                         cfg_peer = &d->staged_config[peer_type];
>                         cfg_peer->new_ctrl = cfg->new_ctrl;
>                         cfg_peer->have_new_ctrl = cfg->have_new_ctrl;
>                 }
>         }
> 

Replaced with following snippet.

/* Initialize schema for both CDP_DATA and CDP_CODE when CDP is enabled */
+	if (resctrl_arch_get_cdp_enabled(r->rid)) {
+		peer_type = resctrl_peer_type(s->conf_type);
+		list_for_each_entry(d, &s->res->ctrl_domains, hdr.list)
+			memcpy(&d->staged_config[peer_type],
+			       &d->staged_config[s->conf_type],
+			       sizeof(*d->staged_config));
+	}



> 
>>
>> Generally when feedback is provided it is good to check all places in
>> series where
>> it is relevant. oh ... but looking ahead you ignored the feedback in the
>> patch
>> it was given also :(
> 
> 
> My bad.
> 
> I will address that.
> 
> Thanks
> 
> Babu
> 
> 

-- 
Thanks
Babu Moger


