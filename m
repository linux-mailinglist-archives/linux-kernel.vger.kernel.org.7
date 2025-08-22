Return-Path: <linux-kernel+bounces-782757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A98B324E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28D11C28A18
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323772836A3;
	Fri, 22 Aug 2025 22:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rpt6v+pN"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC77F20322;
	Fri, 22 Aug 2025 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755900767; cv=fail; b=GxwmT1VTE7r5taNStaMc8DVMOzHlCsA5HW8cxA1uXbXDIEOyXrmZY77enFiB616PZ8k5Grc8tFW7YlaCGCJjjJXAFuUci2z2/rlxNG3+putUk23wGwtkdsmkt1+bHIDy++2/06SKAUqE9XLkL5/B//tTcQDXmthNK/Fie5D99CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755900767; c=relaxed/simple;
	bh=RRYtdm0cLCumcq+PoQzKizXGFIDwslLAl3w/n5cfglE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RNugnlViTp9u+6kgj1rKL/Cl1XfrskHuKnc6epcZBcRK5+8vTz2+XNOV/fpx4rDTN+MGVN/chdu9tXs1IQXTbRdm12Y9sf6ihghIwzQ1IG2KMW4YiFbZBuxDTqHu6mRxcTZmCeGEOKsoDLRLsZ8iCbRSoepS5VroeSAb2PaRXYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rpt6v+pN; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjR2yoQ52TOK1dwltsxauEUhZNrorbAtP1giP+GZPPLJd/6Nupe6MnEGcb5gvjo9dut74JDYwj5NICPkm0968+zIGBEtYA0zJrNV7eNx40Lhc9pNSahpBEiLAo/IxCSR2orsbUtZ0GjqpZrG9+Avu7lB0kfYpMxG82HGGC+kf/1gtgfZS0YyvC8CJq9kwX1LPX8YjEICluzLHDwSK+mWiXg1c3OA+SPPL6T/4gobhgwBreeXl5de/cuIEH0ejgpmz+b9YNECmKso0IjEtWHpmtSo6BCfTUQEK4j8cI0difGXkGfNGu/jhVIxyZjZvoEIIp2w09AZtpcehxRQ6wmqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9JZXME1bQLnp5iXh3uqSQQODAMldlLIQ8UbTra8AR8=;
 b=F+oKBt8wqjkdWd+/eOEAGJZmPqewyqw/FHWE4odSrJ78agGm7MNngil2UpcakeUcAbcoJtyfnZ6TFUw/tJKRg355ccky46wvtazdafN6jNM4So3chFRKbwSnxXHsTIMfcub/Z2bewuH5SRcj+1QFYGg7p+tX5lwzxRJaQGYlW/bo93WEis3NY068G/Qnt17Hsidhe8BA/AmE8irUiCX+sDEBU1DXD9orUKm97GCKgT7kLVqtgo0PKN6upLkNvmjFSDuCx+gmAXD39YQQAz9OxE9KDAb4EajxS8d5E3+htzf9sVOPlDmn5tq9+aT4xfyBTC3t6QN/KwG7XTP2g136gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9JZXME1bQLnp5iXh3uqSQQODAMldlLIQ8UbTra8AR8=;
 b=rpt6v+pN7t+jbR9fHnl+0wwm0//X+0i8nirmjtvThYMPJqLJ0op2AuGX4Yuox86fP7cBhvueCZ/Y6m69v+U2WaoUGqhcr2twgxhq/u1B6PMb/cX7FcBsfvWfAzsKJDiU9Y7yecw2k+bZmx2Vq02Z/lmD5qwmi7fFhVawWBLEwIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by PH7PR12MB6562.namprd12.prod.outlook.com
 (2603:10b6:510:212::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 22:12:43 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9031.024; Fri, 22 Aug 2025
 22:12:42 +0000
Message-ID: <67bd0215-8380-4207-bf97-bfd1d08d7faa@amd.com>
Date: Fri, 22 Aug 2025 17:12:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/10] fs/resctrl: Introduce interface to display
 "io_alloc" support
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
 <1004ca25abe2f7460960f08bf9bacacbb5b07b3b.1754436586.git.babu.moger@amd.com>
 <d566dcf5-fb4a-4d28-a7fb-d173d423c83c@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d566dcf5-fb4a-4d28-a7fb-d173d423c83c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:806:126::17) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|PH7PR12MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eea2c46-e4d3-4873-a194-08dde1c903e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L01OV1JnNjVlbElGM3VZM0FIWmc4RU40K1QwTFZkL0pPVVJOMk0zK0pQc293?=
 =?utf-8?B?WW9jbVBHYUlMSXduV2ZQNk9ucnh5RTVVRDZ6eWpoNDR6VFczZTdUSktGRVUr?=
 =?utf-8?B?UzN4alBWaDNOSEl0ZjlsY2RGaWlPTXNvQllSS0wrWnV4TUxYcU1KbFZnWWVJ?=
 =?utf-8?B?UGJBNkdNT0pEaDlnejFRUElvSXoxclJaeUlmdng1ZDNjeW4wWFN3RzBCaitP?=
 =?utf-8?B?KzExeGFwVEZiUHFyV0sxeVFqc0tZN1pHZXpFYU9sUnM2OWY3bEY4QU1MOUdN?=
 =?utf-8?B?WDlBUlF1ZWtscVNpbDIyblFJRGE5Ry9OZURNU1c0cER3aE1hUzNqbjVhRUdv?=
 =?utf-8?B?ZWNpSUtGanB5R3dkZXEzdkgyaHczRzUxN09Wc1lUbWxGTjlVbUx4cVoxcHAz?=
 =?utf-8?B?NzRLUzNBb2JNRFVaN3lJQkNVSkpHZk1zNkhMYTFnQUNua3cvaVJVbEZ3NDFD?=
 =?utf-8?B?N05SazlIN3RqUStqdE5kUFdvRng5YnA5MVFHdUVDU2xvMUNIR3NiQXdSdHQz?=
 =?utf-8?B?T2RXYUV3dXMwaEtJajJYSUhObnRoTlJiWGJtUGZPNVI1bzlxWTJYNG5CUTdO?=
 =?utf-8?B?dUgzK3JIeGUrSjdmU1cyMXdDWXBnRHErM1p4eksvdmxTNUhyOFVHTFcwQVJt?=
 =?utf-8?B?cnB0WkNTMVNrTVN2ZVd4SWpML090WldpaE9pR0xjbi93V3pBSFdkeHd3d3ZI?=
 =?utf-8?B?NEtITzRrWnJVZFZ5Y0FlVExJRk9oSHNNcDI1M0k5VnVnVU1DMXNodDlTVU5P?=
 =?utf-8?B?dThHZi9MdVk5TS9pS3RQSHVKV1drSlJ2U1VuWDg5dzhQN3hoZkFhWEFUWG92?=
 =?utf-8?B?QVVsSmQ3WE5kaHdPdDkzNzNPSmlDSDd0RlBHMVFCQWNDbjJGeXZ6dDdhSFpT?=
 =?utf-8?B?ckF6UEVCeFZiOUFKdjdkV2p1aHFzU3hsazRsbGZMNEFhdnpYVjVDeDlWdFZn?=
 =?utf-8?B?d0I3ejFTNnUxeE5zdWIwc0p5L1hsaERDQ01FaTNNdUtHU3VhZXZXYWl5Z2hh?=
 =?utf-8?B?Ym5lZ1VvbFJyRzU1OFQxQ2NJdG1sRTFMZi9LeXkvdXJuUUpJbGJ1RVVtV0FW?=
 =?utf-8?B?aFcxekkxcDJUeXhnNDRNSnJZcEZrVzgxdWcySTVOVmFrZ1dmcmVyaGh5ZTM3?=
 =?utf-8?B?REhMK3dsQkN0M3Z2aE0xbnNUa2U3YjNJUk45UUp3dG9rRXArRStBNmo1KzN4?=
 =?utf-8?B?Q25IOEQzOEgvWFYvN3hiWlJXeTNwNGRGaTlzdnZOcWVvZG9BT1BTRURrdUJp?=
 =?utf-8?B?RUNsZS9mUG9pS1Y5QnF1U1oxZS85QjVZWEJhNTVzNGE3ejlITDZaa3NHaWIw?=
 =?utf-8?B?OTl6bDZ2VkY1N0gxRXNXU09OWGM2U01OZDFFaHNKbHNjQmM4aVR6Q01DTkZv?=
 =?utf-8?B?YW84bTg4UGJCWUtWYW01SXlPaHZEUUYvZ0hmNDZ5QlpOcElYV25RVDVYaXRR?=
 =?utf-8?B?VSs5TThHRXpTbWpiVUVPRmJidy9hYkt3VWZ2OXk4ODY4aWloNDNwYS9YaHhX?=
 =?utf-8?B?Y2pLdXBET1dtMVRtSS9DWWRqVGZycU43RFdPQWRTWkZLeUZKdVQyZGp1WnVz?=
 =?utf-8?B?MldhaGVESllyOCtaaTVzWWNRZHZwWkVpcDZLR1RqK0drMnhTRktFaHhQOW5t?=
 =?utf-8?B?MlVZdmg2SEp6ZzJYWkpLL0lKUDI2dzhxQnBzTzdaZ090OG45ZDdyZWx3WURi?=
 =?utf-8?B?NHJ1TFdBMFdZTHZ1eUZmc1Q1cXdDZmNyS09IRFhITFQvZWFtVGNZZWw4Mm9D?=
 =?utf-8?B?Qlp4emRHcE1YTjBBekZRb0ZLNVlMYnoxTXcwaGxHVVV6a3JzdC9QTHZOZFhG?=
 =?utf-8?B?ZlY0U0VBVmZtOUlZME0xaGI4V3pzNzY5a2UrTEgrQTJHSC8rOGlOZGkwK0lt?=
 =?utf-8?B?MTNweTE3NTBGc3JaTWpJUUtJb1hrMHlPamRLcmJSS3ZiQVBGWHQ4L3I2cG0v?=
 =?utf-8?Q?Q5zqzgWTWGc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVY1Sko1UFhMR3RGT3BGN21PSERYS21FMXV5RzZmQnRiYWxybnBYVkkrbjhl?=
 =?utf-8?B?cGFkNzlHcEtseUR2VHk0YWZPRGY4OXlkUlhLN0FLY2NGZEpWZGEyNUlCUkF4?=
 =?utf-8?B?RkFpdzJpbGhoS0dlRjVYUjYrb2xJeEdReFN6OG16WHNtTnZHaDB3dmp4MnJG?=
 =?utf-8?B?L0hIOEhZRm9iUXMxSFJNekNzQzZCU0pDV20xcHdhUitDMG14SjJjeXlMcmxM?=
 =?utf-8?B?U1J2T0Noc2JpeEtBcndwM0NKdVNMRER0Z05WWkVIVFpBMmQwTEI5aGVHRVFL?=
 =?utf-8?B?Mk5BMEZjZWMySHNqbkhxMHdSRHdFSUhSRlhidnVxMEg4NS9LV3lmSXJDakJ0?=
 =?utf-8?B?bUJyd1VTR1pQa1FIQjNGQmZ6NG9iMHNDbDQzYzVqSTZvd2RkVk5PR01EMEhx?=
 =?utf-8?B?UnUvYWZQY0JoL1o3eVdmdjN2NldXdVhqang1L283WWZISXNLYWc2WHN5VjNu?=
 =?utf-8?B?eTZYaXJ1Sk1veE9ualVSNWhXMEN1bE5nYXVFdUlXMVM5RWQyMERoS2JJQy9C?=
 =?utf-8?B?WkV1QnFLdFU3THFVUS9maFVsclJjSFRQRHkwc3A1clFHN3U2RHo1dlFDMEpk?=
 =?utf-8?B?aGxRZ2xwbWovUVdjejRLTHlVUUJaZ09qVjQ4QmU0bUsyTzdWWFg5UXVITHJW?=
 =?utf-8?B?Mk5hcjV5WkhsZHZmbnhtVUJycEpidXd6OEVmUzF6UHd3cUR2dWtSd1RhZHc5?=
 =?utf-8?B?U1gvTGxmTTExSkE3U3FHQ2ZKYTg4Rk5sblg3aCtRQ2g1VXk0SW1KdVZIVmtk?=
 =?utf-8?B?ckY1Y29LdDlheUV0WmducTBkU1BEanZaL0dxQnNBcThNbzhORUJPVWZmd2hQ?=
 =?utf-8?B?dXRNWlVoM3FZK25uaCs4RURiaGU0QUZzdERxRUM3d25wSzZqd0UrYzFsK29Q?=
 =?utf-8?B?Syt3MlJadnR5a2plRDRzOW1zWnJuUFp1YkhySGVONHNEN2tPckFDNzJZM2Iw?=
 =?utf-8?B?Z3RoUXNoNmxmdUxwNGlYMHpFZ3Z5YS9nb2p4TDlRWEg5b0g5VGJVVGNPTGpN?=
 =?utf-8?B?V2p6K3hmOEJMeFpZcGlTZ0dSNVpiMWllb3lyWFVBdFFYaWxaZ1ZmWW1tTTBq?=
 =?utf-8?B?d3d2cUlZTURNdUJCaGxtcWhhTmE0TFUrVVE2T0FiNmYwU0EwQ1JySXkvZlZ1?=
 =?utf-8?B?MXZPRzVrRkxnNGRPbUgzczJJRCtJbTlNUzU0TVByZEVjZk94T1VVZWxNaDQr?=
 =?utf-8?B?OVQyako4SEpCaXJDSlBPNitCVy9reG4rT2p5ME1zbHlaclY3czVZTkJrMDhn?=
 =?utf-8?B?THBWd1ZpRTI2clhvMTVKd1I5eCtqdEs0NWhDdjBhd2pMZUFsL2tGK0ovZlhq?=
 =?utf-8?B?T2ZqM3E3aWd5NjhUMUxsUm5hUEFtUUg0VmY4a2tud0hRUUs0ZUlpRHE4VTNH?=
 =?utf-8?B?YjVTMTJ5TTRiRVBXeFlNY01EQ1NraVhVSWo5VFJCQ21SSnFiZWtlWVplbXli?=
 =?utf-8?B?WVh3UGpySTloNDBoNVBxMFlvTDlTbXhVVi9Sa2daQmVrck14VjJJckxJMVBL?=
 =?utf-8?B?L1ljVWJUZE5abjZUcVlZeGdwN3NscGR4Rmd4ZWdzbXM4S2F4VnFRSWViVkps?=
 =?utf-8?B?L1RnK0ZrS1BXaldici9WbzgzdXF2dURRcXhlajFxeFNNajNkUDZFcW5raFJt?=
 =?utf-8?B?NDBsTi9YY09kU1BDUnhKeldHSmJaUWtualN0a05Zc1RjYTA3Nzc0KzZvYzFN?=
 =?utf-8?B?dXZkMlY3UE13OFNpblRVNG5VY2NVMjRkdjFaS0RBUHNIYzVjdVYvaE9BZlow?=
 =?utf-8?B?Z2ZHWVBmYitGc09QUThmQWpCc3NJMGZOWTV1NmpqNktKVisvNFpxZTJCNzhG?=
 =?utf-8?B?TUdJYysydHBpVVJpOVRaRmxWbWdkNFRXZ011ZkRhUFJWeWRGRHBGcytGOU9L?=
 =?utf-8?B?MTB3RnNrZ1luQnBKUVlxbmxiRmNkdnJxK0RjUmpKR3ZoV05XL0RodkRScE1y?=
 =?utf-8?B?WkJ5d0VlY3pYbkcvdng1WkhpRXhRRTM5UWVnNnFuSmNZSUhyKzFmdHUvUzg0?=
 =?utf-8?B?c3A1bDVnUkw5UVJkOG1tdldobnZLU3g0RjlKWjlzRklMQWRleklHSnMxNkJV?=
 =?utf-8?B?NDUvMVZMQjh4VkRwYkZzbWw1NUxrYXZKNmp6MlRZTlh6Slk3WkRCUHVSSzlo?=
 =?utf-8?Q?TukU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eea2c46-e4d3-4873-a194-08dde1c903e4
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 22:12:42.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cvX4AOUiOeu6oVlx+JAmjrcrGRCYfW6UX0bs4NyhqHkOpWeOO8ahRP30W8Lu+sI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562

Hi Reinette,

On 8/7/2025 8:48 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/5/25 4:30 PM, Babu Moger wrote:
>> "io_alloc" feature in resctrl allows direct insertion of data from I/O
>> devices into the cache.
>>
>> Introduce the 'io_alloc' resctrl file to indicate the support for the
>> feature.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
>
>> ---
>>   Documentation/filesystems/resctrl.rst | 29 +++++++++++++++++++++++++++
>>   fs/resctrl/ctrlmondata.c              | 21 +++++++++++++++++++
>>   fs/resctrl/internal.h                 |  5 +++++
>>   fs/resctrl/rdtgroup.c                 | 24 +++++++++++++++++++++-
>>   4 files changed, 78 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index f08699030312..fff7e04d1e2a 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -136,6 +136,35 @@ related to allocation:
>>   			"1":
>>   			      Non-contiguous 1s value in CBM is supported.
>>   
>> +"io_alloc":
>> +		"io_alloc" enables system software to configure the portion of
>> +		the cache allocated for I/O traffic. File may only exist if the
>> +		system supports this feature on some of its cache resources.
>> +
>> +			"disabled":
>> +			      Portions of cache used for allocation of I/O traffic
>> +			      cannot be configured.
> To help distinguish difference between "disabled" and "not supported" it may be useful
> to prepend something like "Resource supports "io_alloc" but the feature is disabled."


Sure. Added it now.

>
>> +			"enabled":
>> +			      Portions of cache used for allocation of I/O traffic
>> +			      can be configured using "io_alloc_cbm".
>> +			"not supported":
>> +			      Support not available for this resource.
>> +
>> +		The underlying implementation may reduce resources available to
>> +		general (CPU) cache allocation. See architecture specific notes
>> +		below. Depending on usage requirements the feature can be enabled
>> +		or disabled.
>> +
>> +		On AMD systems, the io_alloc feature is supported by the L3 Smart
> drop "the"?


Sure.

>
>> +		Data Cache Injection Allocation Enforcement (SDCIAE). The CLOSID for
>> +		io_alloc is the highest CLOSID supported by the resource. When
>> +		io_alloc is enabled, the highest CLOSID is dedicated to io_alloc and
>> +		no longer available for general (CPU) cache allocation. When CDP is
>> +		enabled, io_alloc routes I/O traffic using the highest CLOSID allocated
>> +		for the instruction cache (L3CODE), making this CLOSID no longer
>> +		available for general (CPU) cache allocation for both the L3CODE and
>> +		L3DATA resources.
>> +
>>   Memory bandwidth(MB) subdirectory contains the following files
>>   with respect to allocation:
>>   
> Code looks good to me.
>
Thanks

Babu

>
>

