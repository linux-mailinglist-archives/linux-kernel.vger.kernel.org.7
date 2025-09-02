Return-Path: <linux-kernel+bounces-796985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B8B40A6A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A302D1BA2410
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7F132A825;
	Tue,  2 Sep 2025 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PutKW8G6"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734D22E03E6;
	Tue,  2 Sep 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830023; cv=fail; b=ACRZ7eE3w9i0BQVaXqyKMUJy8k4dD4unbLm4GCLMoU1F5ivwgQFFtJ2GvpGXd3GtYaMnDmxzQTYEE0q0wyONDq619MYMjpL5kgvprLwaoHT83TerBzKDiDnWarbDj14cn0dtjRHLWczMS9Fe/SpCnC6SglJguxuIIlASlRZEAj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830023; c=relaxed/simple;
	bh=7roTtnh3kbOkcq46kEA144/9dY5XvCY7ix8i4HzKXQ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TZLoDXfSItcjq8tbWBnvTXV2lam5OWKJFkvUIuljaBGf8cZxImL9jhZ+B2H8dyQw3pC3vaCvu/X7FeLJm22sSwj4NR64rcgkmfikJZhKwAVwVoNiba8drw6NOT/8Pvo021RyUFyaoDhVoIBIjwJ31+uUzvpvCQQ8fgffa5zLv2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PutKW8G6; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbX9K7kSP2arNaCEm+sonSTb/7Xhfyr5pfEL+19QJWX/ENmEtiDhhrkzXt0cz8To8tNx3PCei9FztaTLsPuVTaKLOrHMmyv0bi2l1j8nXKk90cMnqySrFw+eP8YPapByDVkryjfvouromBdkh/h9P8a/ImYHt96n+WM08mlwg+lLV2a2HRASC5hNgCsXAuwufNj0JWvZXgepLmQIocg8X4jkU0kSTFAGCirmAC9SZHS7E0XJppfANooZAP2JRZ5gpx/ftaG0VD4oPoId8w42Ffyux8JuRQYqwcoH51fozXTvCYVRrDq8Vb+N0BGr5eC+gjKTCw0HY6JeLneicvTWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsIiAz9A/Posddnmus76zXyBmy9j1YzIEmw3lWXZ824=;
 b=yRlXGYSDtHisxhpsY9jiFH1rLUD8k/rBQCCjvpc/LB4qZJvMdu2fJGBqgCOFl/LKzH8dGOr4JdajMG4A2yAzu7hWBPgeSyq2tm0om/tw3ppcwvm47IVyV43Xn/BYwL7SR2mN/etxVTpbBlhZfwonKu6eszofgBKZgfX42BtxY7yGPF/eEPRGS9oVCyeCLTLEwW9Em18tIDQdiXklRyk2PTbd3tEM7zWfVlTwkI8dR76cniT70fVJOL+jfS9YE65BaBIu9+JPYWZfVCMj+o7CmUZhYIXCCLrdZwckcSUTmewIies9AmvyNOajZU/7MehRicwSQK6XTa2kxtjMaWfziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsIiAz9A/Posddnmus76zXyBmy9j1YzIEmw3lWXZ824=;
 b=PutKW8G6xzYkdrvaLs8WQK1sEqqpNBPXxi9PS3y1Zj3MNeU6DXUk4FNuABYo8obr7E2F4EXYXOAENZjHdBI6DrTu81Ct68g8QyNVI182c4xYy4s25rr5Nl9uy/u4yQVc/9SB7VV5jT81uJqUaqfJ7X4Pd342GmzA5WmmB1wM8/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by BY5PR12MB4114.namprd12.prod.outlook.com
 (2603:10b6:a03:20c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 16:20:17 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9094.016; Tue, 2 Sep 2025
 16:20:17 +0000
Message-ID: <f0aa283f-2769-4701-a639-9917348d0cc0@amd.com>
Date: Tue, 2 Sep 2025 11:20:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/10] fs/resctrl: Add user interface to enable/disable
 io_alloc feature
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
 <d11e20c1-1162-422f-8915-97efa69644c7@amd.com>
 <cfe2a26f-59a7-4563-b6a8-aaa674f60636@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <cfe2a26f-59a7-4563-b6a8-aaa674f60636@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0059.namprd12.prod.outlook.com
 (2603:10b6:802:20::30) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: f80ad747-e658-495a-beb0-08ddea3c9a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFJMYm9DdjFLQndwK0dmSjg3UlNWUWtkRnRuUlZxMEdLY0tETnJSREVFMXFZ?=
 =?utf-8?B?R2FhWkE3WWlWM0Z4dm1zd0RNUDF3bDlkTk5Rd0UwVHY0T2Q0ZmRrNFcraHNI?=
 =?utf-8?B?NnJOWitITzJoMmRZQVJxSi8wZVJ0Z0xuUHZLU2h3Y3o0aVk5dUFEY2R1Tks5?=
 =?utf-8?B?SXRCc0VOdHVtUnRyeWp4b2JUMWtCNTdVRzVRcVoxaHFLbEIyS01qdlNzN3Na?=
 =?utf-8?B?K2hHRlhYdVRwSUt3ZUNtMC9uS2xydDMyTlFIV21PeWJIaHZ5aHpJRDZFaEpG?=
 =?utf-8?B?WkVPM1Y5VmdlRWRzRGs1ODM4RUZQZFVxU0l3dFpxWXdQZVg1VG1OOUVOYk92?=
 =?utf-8?B?ZzJOYkRSTDRFQ3BJdTNwZWx2VHBuTDZvbWwxcThPaU9IdnRsUWtTcFAyWnF3?=
 =?utf-8?B?Yi9BTTZ2dFBMOHh3Skw2Z1BZRmJCQ2ptZHZ1aXN2UE1lZGdYYS9aUlR5VHNs?=
 =?utf-8?B?a0lPL2EyUTBQd1lPMVRiVU91emNDN1g1aWRUeDlpb3F2VEc1NXFJWFRzTDQ2?=
 =?utf-8?B?Qk9zM05jUGM5TnJsckZSV0MzTjd2aWZlOVl2Wk5GTFE4OEROSHk4ZTdocStl?=
 =?utf-8?B?SWgwR1BoUlFLWW8wRC82NDBTSzU4WDlCRFFrSGJBcGJEYkRMRE9mdld2cEhI?=
 =?utf-8?B?Vk5tcGpGdi9wRFQ4aks1SG9RU1MzVHp0YUF1d1FONEduc2hrY3VYcUN1bHM5?=
 =?utf-8?B?VERMV1FQMzA5QVQrNDVzWURZczRtYkFoNkRWRHVZOTcwd3p3MCtLUVNBaFJy?=
 =?utf-8?B?QUdsajg5dnFuNTJUemNsVWg1eXl2ajN5OXZNdWdZY0JGbVVaVXN1aS8zaFJq?=
 =?utf-8?B?NkhOTkNZS2EzRHBHMTRTc2RYUzRjZTlpd0Jwa0U1R2J5YjVTKzFjWXlYRGFB?=
 =?utf-8?B?Ym1peEpRREEzUzJFSzYrbE9MZVdaTFF4Q0pSc0E3MWV2R3FlRDBsRjBWWmFL?=
 =?utf-8?B?RGtLZmFIVTlrUnZ4UE5TYnFRT1NsMzc3bUxlYXVhcks5amJaVTl6SGRrREhS?=
 =?utf-8?B?eTlLYzgzc2Q2ZmZkOFo2a3R1ZTlleTJkY1dmYi9XNzFwQUl1cEx3Z3hIUlZh?=
 =?utf-8?B?Yko3cVNOQkpiZFFQNVB2TGxNZXU4M3RWOExJckRQMUk4L0hlRzVmM1RWUzJM?=
 =?utf-8?B?QndpbDlmU08walllY2U4SWhBQVIzRENlbkI1T0Z6djFQVDF0UXY5ckRqRXJZ?=
 =?utf-8?B?RkxuYjhyemV6bEpPZXZrRlZGcGh3ejJHUXM0K3Qzd3lvL24rNVlrZ3FTMzJu?=
 =?utf-8?B?RGNKeUhCSmpNZmJxRFAwNzdFSitTM0lMMC9ub3Bxbm1NMU5Dd2pIWTBCZW5j?=
 =?utf-8?B?M3E1MnMyNjVKaHZhVnZ4c2FQd0NPb3FiajJvSE1QODNUaVlzdmgzSG1iN2Zh?=
 =?utf-8?B?YjUvckc0QVhEczFrcnp0T0xQN0JFai8xdVBjTDltUnZ0b2hvSTNyWkFLMnNK?=
 =?utf-8?B?cWhFMDZnRDBicVFudFJjZTZsaGxiRkhXYjBmWXBZeTRSZVUzSmVkd0JNamhC?=
 =?utf-8?B?NGg1UlY3bTlwU2ZSNlNOcHVpQ0p6RmRuM01EUkhmakVTTCt4NjZxNng0RnVZ?=
 =?utf-8?B?Mmt4cUdxTW9IVy91S0JjdkltY2ExVHJEa3BRZm9Md0xIaDlLTUhhMUxYdktH?=
 =?utf-8?B?TzlRaDhpYUg5K3FxTGtsZEliNGhMbDczajZ1L2V5N21YS0gweXM4NmtEZUNq?=
 =?utf-8?B?ckJJOUkyTTBTTDZCUHBFa2FhS3JwTGZkd3hvR0IzbklNQnk3d3RpdmF0Z2V0?=
 =?utf-8?B?SkxRV1d0Z09pN2tVVHJ1S09jay9lalB1SkQ1NmQ4OElKMkpEVGRPL29pQVUr?=
 =?utf-8?Q?OCyrEGDk0dvCtALQf1qkNlnQeG/uvWb/QE338=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHpxajluZVdoUmdTVmhCNlJrYTVmRWNTSzJtaWthUmNVZjhaZ0lGWTF0a1BQ?=
 =?utf-8?B?dHJNRWNtUmc0RkhZWTF6bGdIejBpY2RGV0htN1JSZmg0UkNJS3dId1BIRFlE?=
 =?utf-8?B?WlMwU3lVdWJ1OXh5ZTdDWHNieSt4cWNEdG5VdlNDM0oxbFRsNndwR1F1SVk0?=
 =?utf-8?B?WkdBRGI3ZlFpOXhSeTVKZFd6Q25WN1NqbzJscm54aWcvWktVMXlCZTArYXda?=
 =?utf-8?B?cE1tU3dnOTVWMm1EZG0rWCtVb2pxMTdFNzNlNmorMUFwOU10OWJ5Yi9Ic1BX?=
 =?utf-8?B?azhGZGg3Q2NvWHpzRitzVVlEQUpjMlpIZzJmNzlqc0JUTWFVSG1qNFNHS2I4?=
 =?utf-8?B?b0pBRmpBdElzcVJRdWprTVZaaGdlWUthNGlVb2VTTzFtMFA5NjM1cU02V0Rx?=
 =?utf-8?B?SEhlMkFabFlkUzVoOVdIbCtKYnljWEdhcUJZcjJCZjdoV2t0c3ZQbVI0aVJU?=
 =?utf-8?B?UGQ2SHRTQWd5MThlWk5WLzBSWnkxLzJtMkVMUk83ZHR1UzVMcXJYOXhrT2Ny?=
 =?utf-8?B?QjRORzQyK1dKWUZVZHBCaUc4TGQxdUZFcEdIN3Z4NEZaa1NTUE92UG12S04w?=
 =?utf-8?B?YnBSamMxN0V0UTRSMTh0UWx4elhobzE5YVFZUGJQMUxYUDd6Umx4VVQxb2l1?=
 =?utf-8?B?MzdmVDB3cy9Nd1R4U3hpc0dITFJjbW53bzVSSC9pZjhvd1RlYXBkNTFlWG5H?=
 =?utf-8?B?UkE3N0NiUDJETTJmS3J4NlFDdDk4UisxNUFDVXNZc2hsZDNNc0V3UWJaYW8y?=
 =?utf-8?B?TUdYdHVLS3VrdW1pYU1oR2MxYmdySDRlZ1ZzZ0g4U1hpK0ZXNVhMZjN2bHFD?=
 =?utf-8?B?U2dRQnhQTk5JcWhoZ1dJWkFKTXhEUEFRazFRZUtRc1RoTG5Ra3J3L3RPWU5P?=
 =?utf-8?B?ZnJpeFNDTENxWUhkM1FuejMwTXc2QmZ1cGFRb2JzWHZEaE5pVGNoNDNXVDFp?=
 =?utf-8?B?RWhFVDFvSEJSMzFBT0tDeXhKNldzQ0hTZC9HT2IwYWNOKzhHTG96UnRLVHpy?=
 =?utf-8?B?MGM1dG42VDU0di9WZjVOV0U5Z0M0ZTlPOG43RjhHdkNheWZUcXRvbng2SUxY?=
 =?utf-8?B?blB3VCs1SDcxbHdsV1JOMHoyTXhXWjFTTmNSWGQrS05ZZXpMYUhBeC95OHl1?=
 =?utf-8?B?c2Q2U0RoeXhMQnRQVVViNWExYlNUYlA1MVhzcXhPVmZpNmlKdXBSM2FTTGsr?=
 =?utf-8?B?U2Y2a0pzNm5GZTYvRTl0TW9BQ05pZm13UXV5QnpuZlRHdTU0cG9qQ3BtMDhL?=
 =?utf-8?B?bzJGY24xbGEwc1lHb0duNXNlUXFDS0tlbW5CQ0pGWlhsZGNUanlBVVk5S1RY?=
 =?utf-8?B?Q2NJR1J6WjRjWkVIVnlieWRDdXp1WWU2WDFJTzViMHg5S0VLTHRPSWM1QTA4?=
 =?utf-8?B?Mm1oWlVPa01CVC9xZ3Z1REQ4YkplUmgwNjQycVMyNlFFU2tFZVl6WXl2VC9q?=
 =?utf-8?B?T0M3cjJLMmVuay9pYW52c1grUGxSeGlJM1NtSjRYSnJuZHJhMUNCQnpQcjNN?=
 =?utf-8?B?bWVYdFRPbGphWGp1Y0tYWVZETXZ2czVUR0NuOUJUSlc4ZmNoVEZ2Tlg0b28y?=
 =?utf-8?B?bXFUQjJNYmRXVTgwMWc5T3IxRFFOcHhBc3RpMVdCaStHdmh2ZWNWRlk1L2Fn?=
 =?utf-8?B?clV3cHVVYVRaMnJaK25YQUhIZUwzUTc1YXAxZmdzdGVuMThmZjIwWWJ4dFkx?=
 =?utf-8?B?WnYyWWg2azg2UFQ5N1BQOVM2ZS9yZ2ttdHlvSUhVYmZ3WnJkcFN0dGVaalIx?=
 =?utf-8?B?SEVuZGJQajh2SHlXYVZ2RzdIZ3RXN2ZGT3VXelpnbnNNaXBSTXB4NDBLK2V4?=
 =?utf-8?B?QTB4NXczYXJPOS82RUdDVWRHQWsxNnY1d1VpQ1A3dUcrZ2NsNnQxUE1jNCtJ?=
 =?utf-8?B?VUlJUkZqblZLaTBTVFFwcVY2bUIzRHRYekVObTk4WG96U2FYQnJEQmo2dGUz?=
 =?utf-8?B?alZNcmRDTjdLbE9yanVYSFdrRkVaeE5QSHFpZ3k5T3NyK1JpWndWNjFIM3BM?=
 =?utf-8?B?QmxjaFVXWkdoa245bG5BMFFtZ1hMcUlMUksxSHZIR1JuTVhSWnU4L0ZsSGY1?=
 =?utf-8?B?Q05ZV1ZCc1VOeU1rOHEyazBjdVBVMG1PeUZiVCt0dmRFM0xKTFJIZkQ1MWgw?=
 =?utf-8?Q?cDgc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80ad747-e658-495a-beb0-08ddea3c9a9f
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 16:20:17.2395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8UqBUbLQc9+CNPIVLwt8si1K73QfAJkaelQg3bDOhr6VuFvh+zE/BvGy46nJRit
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114

Hi Reinette,

On 8/28/2025 9:47 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/27/25 1:39 PM, Moger, Babu wrote:
>> On 8/22/25 17:53, Moger, Babu wrote:
>>> On 8/7/2025 8:49 PM, Reinette Chatre wrote:
>>>> On 8/5/25 4:30 PM, Babu Moger wrote:
>>>>> +    enum resctrl_conf_type peer_type;
>>>>> +    struct resctrl_schema *peer_s;
>>>>> +    int ret;
>>>>> +
>>>>> +    rdt_staged_configs_clear();
>>>>> +
>>>>> +    ret = rdtgroup_init_cat(s, closid);
>>>>> +    if (ret < 0)
>>>>> +        goto out;
>>>>> +
>>>>> +    /* Initialize schema for both CDP_DATA and CDP_CODE when CDP is
>>>>> enabled */
>>>>> +    if (resctrl_arch_get_cdp_enabled(r->rid)) {
>>>>> +        peer_type = resctrl_peer_type(s->conf_type);
>>>>> +        peer_s = resctrl_get_schema(peer_type);
>>>>> +        if (peer_s) {
>>>>> +            ret = rdtgroup_init_cat(peer_s, closid);
>>>> This is unexpected. In v7 I suggested that when parsing the CBM of one
>>>> of the CDP
>>>> resources it is not necessary to do so again for the peer. The CBM can be
>>>> parsed *once* and the configuration just copied over. See:
>>>> https://lore.kernel.org/
>>>> lkml/82045638-2b26-4682-9374-1c3e400a580a@intel.com/
>>> Let met try to understand.
>>>
>>> So, rdtgroup_init_cat() sets up the staged _config for the specific CDP
>>> type for all the domains.
>>>
>>> We need to apply those staged_configs to its peer type on all the domains.
> To put it more directly, this implementation keeps the CBM of CDP_CODE and
> CDP_DATA in sync. Skipping the unnecessary and duplicate parsing and instead
> copying the CBM from one to the other makes that obvious.


Got it.

>
>>> Something like this?
>>>
>>> /* Initialize staged_config of the peer type when CDP is enabled */
>>>          if (resctrl_arch_get_cdp_enabled(r->rid)) {
>>>                  list_for_each_entry(d, &s->res->ctrl_domains, hdr.list) {
>>>                          cfg = &d->staged_config[s->conf_type];
>>>                          cfg_peer = &d->staged_config[peer_type];
>>>                          cfg_peer->new_ctrl = cfg->new_ctrl;
>>>                          cfg_peer->have_new_ctrl = cfg->have_new_ctrl;
>>>                  }
>>>          }
>>>
>> Replaced with following snippet.
>>
>> /* Initialize schema for both CDP_DATA and CDP_CODE when CDP is enabled */
> Could this be more specific? For example,
> "Keep CDP_CODE and CDP_DATA of io_alloc CLOSID's CBM in sync."


Sure.


>
>> +	if (resctrl_arch_get_cdp_enabled(r->rid)) {
>> +		peer_type = resctrl_peer_type(s->conf_type);
>> +		list_for_each_entry(d, &s->res->ctrl_domains, hdr.list)
>> +			memcpy(&d->staged_config[peer_type],
>> +			       &d->staged_config[s->conf_type],
>> +			       sizeof(*d->staged_config));
> This looks good to me. To make it obvious what types are dealt with this
> can instead use sizeof(d->staged_config[0]).


Sure. Thanks

Babu


