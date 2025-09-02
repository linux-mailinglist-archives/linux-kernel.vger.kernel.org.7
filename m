Return-Path: <linux-kernel+bounces-797013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD65EB40AB3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFFF3BE460
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C8D33CE9A;
	Tue,  2 Sep 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j5Sy+Eh2"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49739340D92;
	Tue,  2 Sep 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830788; cv=fail; b=IccZajVyjAMvOltNFLyAzBNjB8pCAmu7II+wNvmxLj4tzW5HMs8OityhNLWnFsODMmBOK3iBhhVubjHcpi143cNQAjGZdra8sxEYnEOWOZXIbfL/uHzshlOyaJIQxQBvLerpTkBmvJJj+mFPJqY6EV063fNKjMhK5QsJd1sHwAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830788; c=relaxed/simple;
	bh=UZB90AgYLmvYLtcvwoyqlZJ1AUDyMp63DPTvoEcTb+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J+aZiKYFPakZIGNxidWPcEYO/k+6vC4XCxm8cvxhQaHwgywBjTf4v4/pFyhcGtJspBE7j8OmHoc6Lla7SnI13zY9x6TLGyyyReH/7U669saVadvFFsVm0B7fOKKEx/CkCVJW0Y/aSesfzXxiqDOx+GfiEES4HnppdtljDvU85/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j5Sy+Eh2; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGTwskDYS2/neDTy3HmFAs1xbQbTJyEmM4oswMDCLI5ymzuri5xW3nldLx++mjhYh8vx4XxlNR7gaXI9e7/GZ/ooKTaCEnqrmvk9c60Caszvg2PhBxrsgH4IngdetLfcUkut8m3A8puiHOx34mf3X8fI+/UtYjMMmmyZ4BcCe9HynYokhy+QsShFEaRXeymK8WgktiserFUxrYoAaPzz/0KgHRQo9te226lMKsfnEN7hyBwqG0/RqAULm+shVsgPcmB58ls0QR6XctTcZqc3OQVxmgKA6ogGHAD00K/ZymkudThh4mpDhc8/A94eeb9Load7BSmVfkLLi2X3XShOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRc0lHxWSSX8v7UB68YDQC0NjkZJfeTzy97huDJ3klc=;
 b=hzeLXcRUAYJd5SZedLV6e823v2RUSp0NeKetv3xEJPGLX4PZtCtUSaoMz4PFYOuTLSApAbcFCXzdKljbpAFIpkXk0f+EwJ2HmZnEeAyel/cDs3NGFjjlV3pBxKNE88+eiyQ5TeBrUBsEfj7eAQn7+q0aa9FlwrB8SM1iycCIOJA+GCTz39CFjXzhjOvfHDv0Fhzs8DYtUqGm4IkPAtuKUAnZ/QGaUWN6i10ijU/LLLs+FwCHW5gdoH1Zi21hycoYk/TaN5jfcME4tpxqkke5z5HqdTLzFHbFU6TqCiNGd7biqHrFePwLpOM6ulC+ftlstILrMN4huLlW5S8Tui9o6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRc0lHxWSSX8v7UB68YDQC0NjkZJfeTzy97huDJ3klc=;
 b=j5Sy+Eh2LVgwZmBGsOef0TAAOz5i6RCa6BMxYrcpDl4avAEdOh30rkdpS0Anw4fQHtCZLkVJy7AO7mtAqrmocInBy6Qo8KAkXUlpr7rPAAfztpZzr4iaazTLVEQMKD/daz1UhsVt5Z/S2f10QD8h/24locCMwHVOOLcEFze/2DA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by PH7PR12MB6762.namprd12.prod.outlook.com
 (2603:10b6:510:1ac::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Tue, 2 Sep
 2025 16:33:01 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9094.016; Tue, 2 Sep 2025
 16:32:58 +0000
Message-ID: <03ec4ac8-d6f1-47dc-87c2-e2a0017a269b@amd.com>
Date: Tue, 2 Sep 2025 11:32:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/10] fs/resctrl: Update bit_usage to reflect io_alloc
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
 <6d34357ee32bb519c607a0e2f0195194c1096d7c.1754436586.git.babu.moger@amd.com>
 <79e7f426-e592-436d-aaee-f448282c66a2@intel.com>
 <4145a0fc-138a-4a96-879d-34b07fd169a9@amd.com>
 <cf9e1e9f-7d54-4eff-aac2-1bc5c4ec4f82@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <cf9e1e9f-7d54-4eff-aac2-1bc5c4ec4f82@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0052.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::28) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d63744-d138-4d01-d937-08ddea3e5dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?citOY2ZjVlo5MXcyME9VL1VtRE9BWnFtVGhqR1dEckcwUi9yMGJkanRwZy9a?=
 =?utf-8?B?bUFXVWtwYkJBbUNBYXR3SEI4ZW5Melc4YlVoYVRaZzVFd3NOMVNqNnZqS09l?=
 =?utf-8?B?NVl0L1A4cTZNdUtHcU43RnphRmF2OHVYV0NIOFNQdG9YWFA1U3U3YjdBSlRk?=
 =?utf-8?B?MUpOWDFEK3BtYTMwUDNsQ3BmbmpkUThwZFExQ2FoZHJSUDJMUGJVcEJ2Wk8z?=
 =?utf-8?B?N1AyVUR0T3FsbHRkNEw2NTd2V3dYdTZCTHJkdHVoME1pSzVub3dGd0ZrRkh0?=
 =?utf-8?B?eDdMUkVuRW8xNmduVUoxUWRzLy9oME1rNGxudE0wL09xVWVaVEpEa3Z6VU5z?=
 =?utf-8?B?SjFuSWtXbFVyRXRRWTJVTnRMTVJXaUh5MmhFMXNIakRMUlJ0UWN6L3dVdUJV?=
 =?utf-8?B?VmE0ZWI0OHkzbkxpd0NXWW1WSUFUc29vWW14U1g3MWJYUSthK1pGaSs0U0Rt?=
 =?utf-8?B?bXE1NkJRTThpbFRueGtYQ0F4MHpEQU81eTN5bDdLWUVvamw2YVdVZEFpajRv?=
 =?utf-8?B?ZXUxYU5lMDlwUnRZWnl1VVc5UHIxTm4yb2lORzlIQ3dXRXhOcXMweWRQa2JG?=
 =?utf-8?B?NjAxWnd1RGJ0TW9kSEllVlM1WWxhWFJHVkl6QU9nQXZkbm9DNmNBaHBhVEdi?=
 =?utf-8?B?TGpJVFlXOTJNckNDL09DcGtPZWJVdU5PQzI2T0ZhbEVTL0hYdDhCT2h0SzFR?=
 =?utf-8?B?WllaeWlDYVpOcGgvTzQ0Yk9nSlVKcXNrQ0wyMnZTYVpqcWR5TjVNaFlBMTZl?=
 =?utf-8?B?Y2RhSTd4RXpMOG5Cd2FyQ3d1UzR6TUlHN1pwL0F3cWd6cDdhY241SnQzRVhQ?=
 =?utf-8?B?eDErc0kxUG5uR0kyeFIyUWliY1QxOWN0aXZqUExzMkRtMDlnNG9NUVlKMVpE?=
 =?utf-8?B?a1BPK2hYSzZhMXVyTGRocUdPcUNrWmVVZXJobENoQUM3MHVNRmVhMnBzS3BC?=
 =?utf-8?B?T0phRXd6K3UrWG5acFZsVGxHdHhPaUM3WlZ4NjFRYktGQTkySDQzZ1JIUFpQ?=
 =?utf-8?B?MnhFK00rTlQxbmxoNnNVQTlzdDFValBLZFNBK0ZDbGhvS3F1d2hlZ1BuQ0Vp?=
 =?utf-8?B?dFlraEo2WVhxMXdYcTNGbW5ZQW4vRkpPZGNaSWdQZzJpT2dLMXZHdklBWm1l?=
 =?utf-8?B?elF3WVNFNXJJU1IvQm5rdkJBMzZoTDdUUUVuRGd1aXplVjNEQjNrcUxXMGln?=
 =?utf-8?B?ZGRzWHpLRmtoRkEvZU5GNFRkanFodytOWVU1R3VXd1ZDb2p1VVpHcmNiaVdp?=
 =?utf-8?B?eENkTDVaUFQ5OWZoVk9MMlpFMndTbU9SV0p1RmRsTVIvZXI5dHBqT2NON2tY?=
 =?utf-8?B?aGpEczV6RFlXa0FnbE1kUW5SU04vL2RDeGRoMDlLMHM3VDhucjdDZTJUZS8w?=
 =?utf-8?B?Ti8zRkNhRkFpZTJ3RVFGOGhmT2RiWjNkcmxoRjNZa2Z5MVA5NkxkTFVEZEow?=
 =?utf-8?B?V3kycFVycjUrclhLUEE4RnloeTBkN2d6cU9Ob0N4MFIzMnJvTmpjVDhhaU1V?=
 =?utf-8?B?TmtWUGVTRXdNWHRnNEtMVGRkQm5Uc2pHbSsvcmZpa1pmckhuN0FXa1ltb3dv?=
 =?utf-8?B?MUplTVVlMDJFbjZKYXVMK2ptdmtkb2htcU9GclJ6WmxHM1VyZ2liZUR2S2NI?=
 =?utf-8?B?QmcrNTBaTnp1OVN3RkgrdkhZQk5QYmw0dzh4emlCL0VmSjNFZVVJUTZOWnFp?=
 =?utf-8?B?bXF3TG0vK0tudzN6TmpUeHR3Ry8rdmFuWnU3R1lWdXViNVlnS3E3UU1oSnls?=
 =?utf-8?B?NWJNWWNWNFdGNmQ4NXRQUnpzdkNzbE5pTHZJT1NQVi9Ya3JaNjhoT09ienRB?=
 =?utf-8?Q?bsMpL/KRFJDram8e27Yc9tziEd83iy0HwKC70=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmlYNW1qMU5ISVkxQ21HZ01TeG85NjJ2bXQ3RjRBclZ1dE1OblJ2WTc2TG9m?=
 =?utf-8?B?WWhJVzlhUmxkUTVUaDlMTHVWTWlXRlZ6dXlGbVJTaEJ4aEt0aFBFWVErTkRa?=
 =?utf-8?B?cEpOcEFzc1dNeTlYSE15MVY3T3FQSFRKVTluMVNxeml4ckhMR1RKZ1Z1Vzhs?=
 =?utf-8?B?bHloVDdUL0tGRXV2UWlobitjRTRzT0oreDlDcXI1bVIzTVhoSGcwbi9lQVBv?=
 =?utf-8?B?VnNyODJqK2xYQ1JmbFBQbjVIemR3UWI2M0VQc1I1RUhEbDE1RzN3b25RZmta?=
 =?utf-8?B?MXc1bUk2N2xWbW5qU05CbDQ4ZUpzcHFEMVNMZDRJYktrRm04SXpReVZMY011?=
 =?utf-8?B?djZzNC9XcVI0UkZSeFNYbWxWcjk3c2pVR3VBTno1V2c1Y3hSTnN6NGJoemQy?=
 =?utf-8?B?Wk1wWUJtZ0xxb1RUZTFkOUFaaGV2MUI0N0ZlUm5NcmgvMGNxRTFFTVQ1MUFz?=
 =?utf-8?B?cFV1NlJhcFBGMmdRazJFU2JVbmhYbmJmRm5WTEx4bDZjSTRKNmZ6MmFNMGNs?=
 =?utf-8?B?RWhwWVJEOW9QemlQWm5yZjN2bzhmekVTekZyRW5CdkwxdzQ5cnZrWEljdmhn?=
 =?utf-8?B?Z1p4OU1hLzJKWUJDOVk3Ni9aY1hyR0pYNExWUjF6Mk9VUmkzWGxRbk5qKzhp?=
 =?utf-8?B?Q0JobU1hMWNScC9uSFBzMGZqUDNLaFdjaXZlUENqYXhmS0luRDJEYmNQWndF?=
 =?utf-8?B?QVpuQU5pc3BCMERtNCtjcG5FUUxWTW9YODZncUpra2NSL3hPT2hHQURzT2pU?=
 =?utf-8?B?ZzNpVkhMZTNRcGRPaEZmUEJYSFYrT0kwZ0FOWkJwcWlyVmd2RTdSVDZHWVNQ?=
 =?utf-8?B?WWpHbExQWU5McHNDUWdydHhycWIxV2tJK2l3ZlY5aFZKSmx5blh3Y2JzNXgx?=
 =?utf-8?B?ODRGazRLSW9IQzd1dDR2Y0RUclJoeWVWT2RmSVR6RVhHaWx1bHdEdi9oS0Rm?=
 =?utf-8?B?SC94ODk1VDBKU3gzUnJIempnNWFzajU1c1piQnNPMjI0QjZPVDkwWVRPYVZG?=
 =?utf-8?B?c2g1cUZNcWZsOG56RGUvUEcvUDRDNDkxSUFkZU55Z25ZeXlTYzhDdEVmVVlM?=
 =?utf-8?B?TGNudUNJTVByVDZxV05RYXJEWng4NVhHNlg3cFE1QmdKcFFqYytWUFpQamcy?=
 =?utf-8?B?UXhFTC85bHA5UEVyMFRqZWY5cTF0MjYzVXdJVEhUWk5LYmJQZXprVHdmbjg2?=
 =?utf-8?B?QWcxRmprbmNsZWVpbWV3ekJtS0l1QzloSnl3QTZXV2M2T1dYYUNVZ0Z4RDdo?=
 =?utf-8?B?N3JaS1k3WXBLbVQzaGdxeWJNZ3VCdXZuZGpxOEJKUWxWaXpINVFDMDk2OUxB?=
 =?utf-8?B?Y0t2YWl0d1NwWllodHhGZHBNWDRhU01wSFV1cHdNaUJhN1UwQ1RhSW54Zy96?=
 =?utf-8?B?dk8wc3FNZDZRVmRFdWh3N1dVUmpkSXc4RGU5UnlFM3d3NTlidTVERTRBQkw4?=
 =?utf-8?B?djVTUStQNWdQeHc4OWlzdkE1dGh0QXhUWENOR29yZWp0WlhETU5SL1kvd2JY?=
 =?utf-8?B?ZjZQNW41OGJCdG5vS3lLa0l5NEtXL1ZEeW5VMHNWcFZTTzRtcmxzU3FxdHhh?=
 =?utf-8?B?YURvZEw4RFp0bmliZ3dYTDdzQVBPc1NJZFliWWRmR3JpWnhCWUdlRGl2Ym5Z?=
 =?utf-8?B?SlErWkx5RnhFcytqdER1OFl2ak1uL3BQbG52cGtYRXkxQ2lBUHBKQ2VSQkEx?=
 =?utf-8?B?REVQOFBjWTNzSXhrbWh6R0w1d20wdjBZa2ZpaGdwdFY3b0doWU00Tmhib1p6?=
 =?utf-8?B?am1wcE9pd0ZnT1BYTWtGT0I4b0xuT2ROMVZGQVNtSUNUSEFWbjVHUTVrVTFh?=
 =?utf-8?B?OVg2SklvVktlRmpEenFYc2FPWjV5UU9aem1aSXpwR2pZc2Y3dzlqamNMU3lX?=
 =?utf-8?B?c3VPYysxaVNXZ0dENVpqbzBFWlYyYXIzRnVGRmRHd0V5RVFtemphalk4NEtK?=
 =?utf-8?B?czVoT29xOVBvYndQRkJ2NThrbXZUbWlyQkFvcGJ4bWIvMTRWS2U2ZnVZYVJq?=
 =?utf-8?B?SlF6VkhQdjl2bmdyTXp6ak5Pb0RsL24xbFl2K0VjUHNjTDduQythQ1EvMjZO?=
 =?utf-8?B?VTlHbUJIVVJad1B4OWk5LzJzZk5wS2RqOEx3SU1EbldQbmlralptL1A0NmVD?=
 =?utf-8?Q?Uh+c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d63744-d138-4d01-d937-08ddea3e5dfb
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 16:32:57.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqzG37JDdoDWF4JPiEMWboJSShfB88B8MGOmGPXBQPVtlxkVIlN9jWEqxHYtwkv6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762

Hi Reinette,

On 8/28/2025 10:11 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/26/25 3:51 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 8/7/2025 8:54 PM, Reinette Chatre wrote:
>>> Hi Babu
>>>
>>> On 8/5/25 4:30 PM, Babu Moger wrote:
>>>> When the io_alloc feature is enabled, a portion of the cache can be
>>>> configured for shared use between hardware and software.
>>>>
>>>> Update the bit_usage representation to reflect the io_alloc configuration.
>>> ... but no update to the bit_usage docs :(
>>
>> Yes. Missed that.  Will update the text.
>>
>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>> ..
>>>
>>>> ---
>>>>    Documentation/filesystems/resctrl.rst | 19 +++++++++++++------
>>>>    fs/resctrl/ctrlmondata.c              |  2 +-
>>>>    fs/resctrl/internal.h                 |  2 ++
>>>>    fs/resctrl/rdtgroup.c                 | 18 ++++++++++++++++--
>>>>    4 files changed, 32 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>>>> index d955e8525af0..1e46231b929c 100644
>>>> --- a/Documentation/filesystems/resctrl.rst
>>>> +++ b/Documentation/filesystems/resctrl.rst
>>>> @@ -90,12 +90,19 @@ related to allocation:
>>>>            must be set when writing a mask.
>>>>      "shareable_bits":
>>>> -        Bitmask of shareable resource with other executing
>>>> -        entities (e.g. I/O). User can use this when
>>>> -        setting up exclusive cache partitions. Note that
>>>> -        some platforms support devices that have their
>>>> -        own settings for cache use which can over-ride
>>>> -        these bits.
>>>> +        Bitmask of shareable resource with other executing entities
>>>> +        (e.g. I/O). Applies to all instances of this resource. User
>>>> +        can use this when setting up exclusive cache partitions.
>>>> +        Note that some platforms support devices that have their
>>>> +        own settings for cache use which can over-ride these bits.
>>>> +
>>>> +        When "io_alloc" is enabled, a portion of each cache instance can
>>>> +        be configured for shared use between hardware and software.
>>>> +        "bit_usage" should be used to see which portions of each cache
>>>> +        instance is configured for hardware use via "io_alloc" feature
>>>> +        because every cache instance can have its "io_alloc" bitmask
>>>> +        configured independently via io_alloc_cbm.
>>>> +
>>>>    "bit_usage":
>>> More ignored feedback. I was expecting changes to the "bit_usage" section.
>>> https://lore.kernel.org/lkml/94d075e0-6703-449f-9c0c-8e5973349dff@intel.com/
>> Yea.  Added following text now.
>>
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 273c9c9389a4..0a56829407c9 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -124,8 +124,11 @@ related to allocation:
>>                          "X":
>>                                Corresponding region is available for sharing and
>>                                used by hardware and software. These are the
>> -                             bits that appear in "shareable_bits" as
>> -                             well as a resource group's allocation.
>> +                             bits that appear in "shareable_bits" as well as a
>> +                             resource group's allocation. When io_alloc is enabled,
>> +                             the capacity bitmasks configured via io_alloc_cbm will
>> +                             also appear here, indicating the cache regions shared
>> +                             with I/O devices.
> This sounds as though when a bit is set in io_alloc_cbm then its corresponding position
> will contain an "X". An "X" will only be displayed if io_alloc_cbm has the corresponding
> bit set *and* the bit appears in a resource group's allocation.
>
> I think that patch #7 adds a very good definition of io_alloc_cbm and that it is
> unnecessary to duplicate it. Simply referring to io_alloc_cbm should thus be fine with
> user's search for it in the doc leading to a good description.
>
> Considering this, how about just:
>                  "X":
>                        Corresponding region is available for sharing and
>                        used by hardware and software. These are the
>                        bits that appear in "shareable_bits" or "io_alloc_cbm" as
>                        well as a resource group's allocation.


Looks good.

>
>
> Please also update the "H" section.


Sure.

Thanks

Babu


