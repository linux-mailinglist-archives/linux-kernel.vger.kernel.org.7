Return-Path: <linux-kernel+bounces-815238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A613B56194
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C53F3AE57E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06832F067D;
	Sat, 13 Sep 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="beNcghQh"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A22765D9
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757773794; cv=fail; b=DI1tLG/iWzSRAX2SjEoucqywzEVVrIX4tBKUnGXSyA92zEkMRSRhmRJAw71olPC/ojdtfDhGz0mWJSXZetut7QXaZ3zN748OKO3rY6WGCkj+YYXl+7p9ES4Uq0o7y4EHrNrcw1TuhtrPVg5KCKnpSwRgHifcvo8PbGg50zTl0sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757773794; c=relaxed/simple;
	bh=29zgSmIEwXkZvnHl6g6j3tNVWKZmLCTLRssmi3VG3Gc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ttFQsH4ZgPg+RrcTsK/elLoCZcumI3XhAh3+2fL47S4BsUhadJ4uZhcYf38IDIg6xz1nZs1wBWTx3k1D/aBcvqErFJuZAOmgmK04NGPUE68ZZVN4zprO6BfsTXDlHdyUR83t69nvDCA1Tpxcku4j793AppuNBJFQxS0+te9gbnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=beNcghQh; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iURiJKp923mVVtGceTlLPyDPjRAY9MgAAmj/fBKsE+4AcpVo/fEDlAK6zIQFAecySKupPxeaHVp0RL5/zEjH+A4agvula5YCjt0h/FXmXc5T4BgfP2y+bQB+eV/8vB4KWIZ+HBBnZQXJtjLY/hxihLXs1u5dwsrw93Uvy43+dHQVixY1ypy7z0rKPc05YgpJFcNf3LKUhnJiHFThGCGV2WpXB+KtZeE3lecojuw4jpXLiaAu1vRuHrRwBLXCkg69QKWnfx5VioYKX8o8R1lFXDoA2ChoJhXD9YNtc+Jals7s959hbH2HR9gxXgKots1BIKdOoPUH5G+E0KQY0Iuhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw2gD+sjrA2TKftScW989ATge1W93Sx+ZKD5djz34xs=;
 b=FfxaBdJarJCrn/ZUnApPKpokDi4ajyJtVJlDgcDdgoniPfgr1oKEsKSS+CgA3A1/BMrxOZSnE9YUfIlsdf6nYWqbBoKDB+XOADx0Uu/5YP7RiWlX4Vz5HBa32YnkZjOZgfrxgLGwBvQYpVfC8KPjLRZP/1099XkoxxH14HdeyidwjHhkCaMAHP9uzonAVj/tXGAVfBqnj/wUEpKQXjP0CoqqqJtUy/hjZ8cGwiD3r3wWAbNILgYjhPWb/9AabTi2jILbHLGkcDV4dbvT+rdXQuK9KCwL5AjtkN9fUsWsCSHzMjjzDbo5g57U3Lt2QZqBqMefsXngXmd/ZOuHiOx03w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw2gD+sjrA2TKftScW989ATge1W93Sx+ZKD5djz34xs=;
 b=beNcghQhEhYPlM9+DPiQI/4runLg2up3y8NpOYpCk1AM74Q3HdL/2Tp5E2l1ahRSjwyqTCqP2rIHUWPkInop3bD+7nTYRsGoT3fa8qWOmKqY67O/NfxEUic6aTwwjqBz2UzpnwCrTGiWRYsQocVya/UaEYOjBzmlSMfjetI+9Qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sat, 13 Sep
 2025 14:29:49 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%3]) with mapi id 15.20.9115.018; Sat, 13 Sep 2025
 14:29:49 +0000
Message-ID: <56877590-a7c8-4dbd-b334-ae9cbbf62bf1@amd.com>
Date: Sat, 13 Sep 2025 09:29:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Guard sev_evict_cache() with
 CONFIG_AMD_MEM_ENCRYPT
To: Borislav Petkov <bp@alien8.de>, Michael Roth <michael.roth@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, stable@kernel.org
References: <70e38f2c4a549063de54052c9f64929705313526.1757708959.git.thomas.lendacky@amd.com>
 <20250912204203.GEaMSFm2-N6lPteue5@fat_crate.local>
 <20250912204929.pls6245t746gtalr@amd.com>
 <20250912210201.GFaMSKSSvK55XIwR3e@fat_crate.local>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20250912210201.GFaMSKSSvK55XIwR3e@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:805:de::49) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 9162bbe5-3c8e-42fb-d122-08ddf2d1fead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXJOOUNDMW1jN3F6L2ZIOTFrMUxtaHUyUjJtdTVUMkMvNkNGMWQwV0lmMk5B?=
 =?utf-8?B?VWFIV1l0MFRxQmpiQjJMS1V6bzkrT25yNUZYZEVCdDd3cERiWWIwbEs2d0Nx?=
 =?utf-8?B?S0RnMnBqRnlTSXBxem5vcXV4UVJZZGRNVTJuZjBPZWpOK1Z2N0FEbnVlQ0dV?=
 =?utf-8?B?azNUZWx5KzlqVlhRSXBHSm9OL2xNbnoxZDJHVXViYnF3Z292aDU5MVVvL1pm?=
 =?utf-8?B?UFhlcklVQmFTSzhHRFRpRiswVWpnV1dDN0JuWTFmNnZuWmNKK3h0OVRJeTJp?=
 =?utf-8?B?VXNUdlRzeWhiQjlWMHVHYWx1T0JzbHFEcTFGOGVVdURlZStZOE4wdjZuVjlH?=
 =?utf-8?B?S0w3Y3g1cUJtckQ5ZkZFVXJvajVKSURUaHJlL2s4ZWo2R2hWZURXYzdHRFls?=
 =?utf-8?B?cGFZZ05zWnlwNGZFMks0Z042MFVSSkRPSE5ZZjhObE9sVFNFVGZwQXEyZHFN?=
 =?utf-8?B?QmlmaTV2QVhBWGpVZXprdHozdE5xekhFR0lkclVzc0dmZGk3NkNGT0dobllp?=
 =?utf-8?B?SkIzYkhoMTFtRkhyOCsxcmZORkVucE5aYjJTT3pkWEFkemQwV09JK1lUanZW?=
 =?utf-8?B?azZBMXZMcTcwc2N5ck12QlBsZHFPT1Y1RlV1VjRFSlFlMlh5VkNjaHlEcjNT?=
 =?utf-8?B?bmNMWkVZSDZndFdqbUxJcEQrZ2R2c0pYM0xTY2JVTHptSGM1ZFVqU05ONVpL?=
 =?utf-8?B?TzhSdUZacWwvdERSWDczdS82bGxNSU5aVUl5UWFjZUZmVU9XdlNnT3FKUmgr?=
 =?utf-8?B?S09zT0JWRWRhU3IxQnhtVmdxQ1NGL2wrNStiUjNLUFg2dllseVJrOTYwZ3Y0?=
 =?utf-8?B?SkZRbjJIR0hXWGtzY20xN1dlSmR1ZkxIdEFpOS9ZMFh5K2VXZjIwbW9kaTdE?=
 =?utf-8?B?eVY5ek9zUThoWklNZE9wNk01WW45Q1lvTTVqN0JvemNrRlA2WXpLYzhVVXNK?=
 =?utf-8?B?YlZPRlBZNXE3R0xlWm1CaVU1Vy9wc3YxYlRCUmwyM0lZWFFxOExMdi9zZmVS?=
 =?utf-8?B?N2orME1uZ1NVRFJtaUpEUkRLb0pVUDZabUhGby80aERtaU9kNnliY2F0Qk9q?=
 =?utf-8?B?aHFIMU9oVDhZTDh5OHM1UnlTVGROZ2JJRnNrZmFHZWgzVVF2Wk1qUk81bURj?=
 =?utf-8?B?N0N3RFgxQmRnYWJFSG9ybjVJZEJ6RzEwL1RXK1Y0RzZvbDFVQlU3c2hORUVp?=
 =?utf-8?B?ZEdpb1BBRzBML3RMcnhPLzdKcDdTZTJ5SkJCYldZUURQVTk4ci9ZM3RxU1hw?=
 =?utf-8?B?R2N6R3A1ZG9tZk5VaEQxYTNlaDd3Ujl4ZmhaazdWTHJ1YjZoeFZxaDFaME04?=
 =?utf-8?B?UExQUm02M0M5RzFlbHVmZENRaG5rSUxaZmJacGl3VUk2Vkd4NXgxR3ZvN3Nt?=
 =?utf-8?B?WHYrYUxkMFl3L0VPa1B5QjdGRjIzS29xdnBFaXNKeHhvaUVWNS8xcVM3SXd6?=
 =?utf-8?B?UDlRR0pDZFcyK1NROVAxc0o5cnJhenc0MzE2SjdqQTgrazFZMmIvNUZUamQw?=
 =?utf-8?B?Mzc5Sk1lSjRvVXViTmEwUmZLSmpCNWM5a0xTbkhSZGoyWjRWSU1ORzM3a2pi?=
 =?utf-8?B?T0xXamtSd3Y2UWwzcUJnT1N6NHhGNXlGa2pSOGluN1lwWXdBTXNRSG1Kdk1K?=
 =?utf-8?B?Z0swV2NlVFM3Y05xd3p2dDQ3T0l5QnFGYzM2eFlnRytSNHRCdVpnVkFCUGFl?=
 =?utf-8?B?ZWt0Z3lrVVlsOURDazJOSXdoZFVYVVYwVTlsMXVKZmFsVWRsbXJzYkdmTmNS?=
 =?utf-8?B?RWxnaEZWY1c5eUd6YVQ5Wlk3RVFtbUNnME1WV0QyRUJHQnJBUTBYWDl6U29E?=
 =?utf-8?B?Q3E2MU5mQUdRbFBibmhFb2FBZk1JaWR1VzdJUHpoVFZMZ0hMcDV3MkR4Q1Vw?=
 =?utf-8?B?djN6MkRmYytnU0tPQmpLMUxKOGRuQlo1QjJ0UHZ4cHArdGZzdHdzdzhyZGxi?=
 =?utf-8?Q?oH1RDkW2lwE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkIzamcyMW1OL3pWUUxCclk3dzhyK2crOVo4Z1gwYnlvU3RjbmtXcWhrR1lS?=
 =?utf-8?B?amszeEdxaDJHcmgwZ1NXQTVQQUNYdkgyRlY0SVJHOERiQ3BVOTZXbThxSENR?=
 =?utf-8?B?b0g1akdzZkFnbFkwVG1IckZ3TURJVXZlSWwzMldqWEhaTlh2MEN0SkYrU2pV?=
 =?utf-8?B?NEpFU1B4SHBlY25yWnlVTnIxdFg2VDlEVkd0ZVlaNThhd1NsMjVzd3UvYzdD?=
 =?utf-8?B?RjJULzNvbVVBTko1UFBnMmh3U2RiRVVGNE5FN0RnK05MODdFVWl5c3Zjd1Jl?=
 =?utf-8?B?SmRQZVBxNzhhQW5KdVhheFZyekh3L2lWUDVZS2h5dFl4cDNUanorbWp5TTVz?=
 =?utf-8?B?SktyUnVTaGVUS21IN1JnUEhwVWV1bmJOR0F2ampidFFTVEdYOGRCSjBlZkl6?=
 =?utf-8?B?cVQrZzRQN1RTSkNkcjhMQU0xQXhPdE5PTGc5SEJZbHVVa2dnaGwvY2xGUW42?=
 =?utf-8?B?c1VUL2ZFR2Nwa1c3UStxdGVJNkhnOWkzcG8zOWtCcWdZRHM2ZS9ENVBwV3li?=
 =?utf-8?B?N0l5MEF1N3dEcGJISmk0alRBYk0zZ1l5VEM1QjFSREhJYWk4RHl3NHhhbWF1?=
 =?utf-8?B?OFlhdnMvd3pTRVZQaUhEaUVUSmw4dWNtVlVWdThvQUVtM2ZyTnlNTTgwUFlZ?=
 =?utf-8?B?SjJxd01LcWhEcXhDckxaa2FCTE94UWVtc05raWxMS1NvMXFFb2lYZ3oremZp?=
 =?utf-8?B?QXlWOVF3V1NhVTF0OW53cWpSa2xWRWxKaE9ueENxYXBSMVI3NVN4cjFwaHFt?=
 =?utf-8?B?RjdNOHBaNStEY3owYWtBd0tqWE5tV1Juc2swT2tvQllORHdiY21SdUJ0UHVB?=
 =?utf-8?B?STN6M2d4aWxmWTR0MGQ5anVpNG5yNlFpbE9IK0ppWFQ0V0lNcTM2ZWpDWkds?=
 =?utf-8?B?T2FDdGkzUWdTeXdlUDc2ZXZkUzBSSzM5bGFUcDRDQklWeVE4WTRmUW9VY29a?=
 =?utf-8?B?YjZHclBlaXJURVhobGZ4Z1lhUklySVEzMDVYWFV5djhwZkt4RnpIK0FkbFRR?=
 =?utf-8?B?NTcwL2VkUGNXdGovQ1RwRmNoSmt1UFl6dW9iVVJhOEZRZkVBYlNlSHV1UW5q?=
 =?utf-8?B?a0dtcEVvdDdvd1VvM1MyQjM2dGs5KzBQRWRNYXV2Y1Q3MDdEUUZXRVBLVTZZ?=
 =?utf-8?B?QzAvdEZ3ci80anI2MmJJZmdGK2RYVHF3NHA1Z2hQbTJzK2JOZkJNZlkvdTl3?=
 =?utf-8?B?cmJqb0RyZTNmWW5IRXlsczYrNGptUldldjlHcHErcU5WMXo0anpTMXVNbVpY?=
 =?utf-8?B?OGcrS3VhazFlaEkyZzFPZjhTeTRZSVFhY3NIUmRscDFQcE56bkxncGgySW5O?=
 =?utf-8?B?K09qbWFnKzIweEZOR1QwVkRldWJJMEJhc0haL0tudXVOeWNucVBxaEZ5TGZa?=
 =?utf-8?B?U25lYUltcFl1d09OVVpocnNUSmtkS2FDWmV1d3JKbHo2SGhrR0VXb045Y3BS?=
 =?utf-8?B?WDdMZnNHSFl3Mmg5Ym1tcDBTZnV1SytackZrUXhqam03YVVmZzBxVmcweU9J?=
 =?utf-8?B?ZnR5dmNJU3VCMktCMzdqN2QzTDZya2Zkd2I2ZkttRmswek5ZT2RwekVEMHJR?=
 =?utf-8?B?UTBhYzlXUzdHTE1HTzhrdjlBdGNmVXJlU3RxUGR4akZXcjBLOUREYWlRNWVu?=
 =?utf-8?B?MVVhbVl5ai9WRDRkdnRKaWRmaUxNS1Bkb0I4M3VSMmV3ZnM2TXVIZ2wvVXIz?=
 =?utf-8?B?c0hyY3lSWjNtWmI0ZjV0VmczK3c5UG1KUThLWFp4OTRhTGF1SFNNcmp3V0xB?=
 =?utf-8?B?RlRXMERWenQwSXd1a2d6MjByVnErSE03bllnZUk0UDNhblAzQXllVXpVYjlk?=
 =?utf-8?B?TjhHVk1lMDg5eTBQUjNMVGxlU2FSMkNxQXZGcTdrRjVsOHFxcURMTGJsVkRX?=
 =?utf-8?B?RENBTC9DN0N5N1RiY2tlUXBpc3BvMms4UUd0NjlQeWRUa1NmL2o5c0hpWGpx?=
 =?utf-8?B?NUgzdkNVOVRMbE5vWnR0REF6Qm43N25MVnZmRU5EREJvL1lGMFpva0JQMjFR?=
 =?utf-8?B?M2FlTWFDaUppeStaS1FkMXpPWjFTWk54Uk5iMFJjVzhzK01PNXJKZG05cndm?=
 =?utf-8?B?ellKcHZpRjdoc0xOcFNodDZ6VU1lbllCck5HVldYc2NkWXlTUkNQaTRCaU5W?=
 =?utf-8?Q?DEzRjrixvUPrGOtS27KcofMro?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9162bbe5-3c8e-42fb-d122-08ddf2d1fead
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 14:29:49.5212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vefaA99RwbXUtultd+tpRfgcVHxNUm7UmOnBWQ8J6RExKfyA8DJS6ZbwWD1+K0CqArlu/ROUB3CFQS05YFYwpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722

On 9/12/25 16:02, Borislav Petkov wrote:
> On Fri, Sep 12, 2025 at 03:49:29PM -0500, Michael Roth wrote:
>> I think that's actually the concerning thing. If someone built a guest
>> kernel with CONFIG_KVM_AMD_SEV=y they might be under the impression that
>> this is performing evictions when it's actually just a stub function.
> 
> That sooo needs to be in the commit message...

I can send a v2 or if you want to modify the commit message with the
following:

 The sev_evict_cache() is guest-related code and should be guarded by
 CONFIG_AMD_MEM_ENCRYPT, not CONFIG_KVM_AMD_SEV.

 CONFIG_AMD_MEM_ENCRYPT=y is required for a guest to run properly as an
 SEV-SNP guest, but a guest kernel built with CONFIG_KVM_AMD_SEV=n would
 get the stub function of sev_evict_cache() instead of the version that
 performs the actual eviction. Move the function declarations under the
 appropriate #ifdef.

Let me know.

Thanks,
Tom

> 


