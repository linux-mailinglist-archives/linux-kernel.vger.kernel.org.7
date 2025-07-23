Return-Path: <linux-kernel+bounces-742931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D66AB0F85F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86231C277F6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ADA1F30BB;
	Wed, 23 Jul 2025 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xj/Rg6y/"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798DB1F03DE;
	Wed, 23 Jul 2025 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289315; cv=fail; b=tHlaBzWeoCPK8DkeUAEflnk/BpZmnDbAToB6Ik7BGsRY4rLEKKONUYAHAqZ3fazH5X5wi47gcpfZxkMIG6RfN0Z1ZZbc8Be7Tmh0Q1gDjXsOJBQlj/gMfWl9vk5JQFgPpB/9nmSQ4KlwfHdu+geUB2zAlEyA+uU7htTlDGr9gvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289315; c=relaxed/simple;
	bh=z15btSmn+wL64fW+peDwBxdvdlNuXleoWUrvSYo6yKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i6Tapi2HEK6gAQQcbI9wW8r08tnXZO+oClJEqTmtz3Qr3m5G1Rdsv2tBN8+Bp07MYEX5sL3q7f3GdR+WIg+Dg1UWYJSK/nbKo6AUI3fcuqFdrK2/quYjerO34+NNGEdlb88riODhQVH9HYaVHfibqDC7XZ82KDL1I6NX27VoWNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xj/Rg6y/; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJVfaN7yS1oEw/7dBHEEyZ3f2xaMvmnqWQaFvW4z5nSpQgQ9Fc672RtHMvt7tkBeuPy3dC1IJC6MLrqrJuUlSftKI9WpWsajUZwFTkMlooiX5sMZimH0Bcc0hZ+5aCL8HqUiqaWYP1EVQiG+lJ2IzxdmJlQlpxa4ZBWN8kyfWX/Oe+NTgkve2yKHMMh4eJ6wqAuOSBbY1H4vQI9XYfBgFW6gRzRBY5KnLHufG80AumsXzXEyMCMtJmQY6HlpfknhwjokB+3/dSp/T1QxzR9vOXQ2BEyloXCTfe6bWgngDY7QNvwsyqMV4qTbbxWHMQzHKI07nmMrV+JFNHas31hCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQBTNnUXSRX4YEQ8kzDw7dJHQ7stP5xoYBw0c3mKNu4=;
 b=PyBYGzBxjK589jLbr936eEpEQHq2si0tleVyAzTFZaLcpse+i482moySN62EZxxpZrEnTwCKAzeOuTtdogiaAmPYRavbHKKnkl7vreaHvsblFqSp6Bb08TwHtcck7fg0YOj4WNe+3bemivETiJVTlC9z1YrfHSY1JI7abO4Mlet6F926ixdJLM75cUL/FTdqaAVWBlq5F+2lFz3Zs7DNcVIViQSZFWq0DVzuOblHV0/2+lHzfsgZ8t5GhZnFRktr+F7TskXKgabq8sD93wJgAcuKrgX3Ts6Pa20qbF/R1IUYiDl3G7tJUcJL8mgGCPlZH4jKDBjzy4NWIGh1NrupIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQBTNnUXSRX4YEQ8kzDw7dJHQ7stP5xoYBw0c3mKNu4=;
 b=Xj/Rg6y/4z38JAtw5+Vp8mCRo2C5SWTU76R9j1cJHuq2bgp8SwcVhCZYLp946XUD8dxYNf6h/qp7KLN+x9wpbF2dx86363ilf5BoHLJXnDzENViYnqZYbnq/ze6N4ohc14Em9NzBKmgP31GNLQC7bXe3kTk2HMhuS1DTyxFheAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 16:48:29 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 16:48:29 +0000
Message-ID: <cb0201d7-5f88-4f0f-b335-246dc684fae1@amd.com>
Date: Wed, 23 Jul 2025 11:48:24 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 22/34] x86/resctrl: Implement
 resctrl_arch_reset_cntr() and resctrl_arch_cntr_read()
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1752013061.git.babu.moger@amd.com>
 <d31ab6c51a57591423d3aa7b8e741972cd66eb91.1752013061.git.babu.moger@amd.com>
 <272dc6d5-eb63-4dde-8201-880acc9a3846@intel.com>
 <1e8b0a20-d12c-4f1b-9fc5-c4dfafb7c1dd@amd.com>
 <bdb5dd0f-e60d-4d79-9543-ed7352414df6@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <bdb5dd0f-e60d-4d79-9543-ed7352414df6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:806:120::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9a9e63-a948-41aa-df64-08ddca08c022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjVmeXY2clZYQnVtMjZyWUFEWFdubDhOUnFWTEVQOWNCcVlHeGxDMnJ5UE41?=
 =?utf-8?B?OU5RREl6ejZOUkMxOTBPMXhSODdWNDF6bW54bldGN3BFendYcnBqbFRibWJR?=
 =?utf-8?B?cDdpWnVmWlA3T1AydHJPK1pRNFNNUjhKTk03VHNwQW43bHkzaHlpekQxbXcw?=
 =?utf-8?B?R2FkR3NzYzRKSmNLMHMwYlQvaGNXbjNQVGtTcGNQTm5hODdmMHhTME5FRG9j?=
 =?utf-8?B?K2VWN1dHcEZEZVFlbzc5TWNZa0xEKzNBR1ExM2hkSEE5YzdrTmFDaTlOcFRl?=
 =?utf-8?B?VVJrOXZYQVdmNFBFMHM1ZEo2cllFL2xPL2dTWjZMVllwNk5hVkxBZXJQSjZp?=
 =?utf-8?B?clNSM3ZPUnFraXY4MWxHd0pvOFFzNDBGcC9PbW9XM0x2cVJnTEtOejV3WWJI?=
 =?utf-8?B?bnpKRmlUa3VxaG1wUUhyUGdCMUZRL0J2M0FLRmZyVXZ2MUltNy9rUkk4MXhz?=
 =?utf-8?B?VkdJY2lQWm9RZHhRLzFIT3ZjQk1LeWJDOHhoR296QXJqUlJ1MktZbGVzekRJ?=
 =?utf-8?B?cld2cTJOSnBkQlMvQ1dTMnZtZDdXWlZIVlpNZ0x3RzVsRUdQUzdESmdBdnRa?=
 =?utf-8?B?NHZZdnh4WFRCQkk3RnFHT3dyQnBRRm5RajZMbzZ5RVIwQ0dzOWhRK3pJVXJI?=
 =?utf-8?B?TWYweWE3UmlvTzJ6K1B3SS9nUVJtMVdpdHQ4eHMzVk1admpGeDBwQkVEeDdL?=
 =?utf-8?B?Qm85RjZrckxVRDVZcG4xa0NaZlNQWEFKVTF2bmNvajBGTnNsN2hLYjQwZGpZ?=
 =?utf-8?B?eE94TVlONVRmOG9zRi9XNm52TE8zNkpya09MazQ5TlhkWENOL2ZvdllkeHJX?=
 =?utf-8?B?MDhHQnd3SWhUUkQ4cm5ELzZkY1RaMG81ZkJYeCtzbHVmN2tOa1RqWkZEV0dv?=
 =?utf-8?B?R2pwQ2tveTYweStiZkRKc0N0dkVDYWpKdkNOeThkZGpqODduL1Q1bHROMVl3?=
 =?utf-8?B?cHNKRWZmcVJpVEc1Zm52NEV2VDRwKy8vOFBmSU4xdkNLR1JDR1JmSzRXZ3F1?=
 =?utf-8?B?NDJodXBxMi9Remk0Y210SzRXaFByYVdlMVp3Ry96d2U1S2prWjV1N1dUQk56?=
 =?utf-8?B?UFl2QklYSDZrMS9ENUNmT3NiWEhTRVB4NWZSSEh0TzE1YVRZbFpYRWNvYlJE?=
 =?utf-8?B?d3kxOG5tMDJ4TnFqd0pBandndTF3Umc3ZHpISkllRWVKVW9GL0U4c3dIYTls?=
 =?utf-8?B?YW8wRno4MEVVTzY2ZjZ0VmFoS3l6VHhkb3BWekRhdDBEVDVRTEVIcGtOM3Zl?=
 =?utf-8?B?TVFtNkJ4WExyQkhZN0VBNU1teGZseFU5MGFjR0d0dVQzRkthODdkQmc2SmZZ?=
 =?utf-8?B?Snp5d0dNQSt3OVVwSm4yQlN1UmdhWDdNUVpSNElVQ00zQjJlbUQ1NVpmLzcw?=
 =?utf-8?B?a3IxZGNwMC9nbEt4QWRaWGR6NGgwM3JMRWp4NDVSK3JSandtaGpieWRxL1dC?=
 =?utf-8?B?Z2FIbnJtT1JpaGdCYk1LV09PVmhMZHZUQzRoSWkwRzFrMXdKSTZrcWVXQXJi?=
 =?utf-8?B?ODhHTVpiUFBIb0NuN2NCQ01qMTBQNXFTRXU2UFVnVUpzeWdjVkhrOGlXYVJ0?=
 =?utf-8?B?ZXRRZDNiZEhKbGx6NkRvV2t6WWZtT0Nnc3o4bEtxL2xDck1JWkdYZzJPUFhZ?=
 =?utf-8?B?YXlTUVh1TWU4ZE5mRWc0RjIreGh0Y1RLc1IrcnFEZ3l5VnViTWF6enRwQlJl?=
 =?utf-8?B?YW10Z1NtY0czT01HMzZMT2xYK0hQYkJmRFRBQzQ3QlNyZlRYSHVCbEdrZ2tk?=
 =?utf-8?B?cVN0SFJTdVJNbjN0b0JaUmVUSFhuazdodVJwUFdzSzk0Z0dwVHJCQWJJcXY5?=
 =?utf-8?B?Qlh4NitnMzZLaE55OEI4Rk5QWDBPc0ljeVpiZ2xwSFBqLzJ3UmpuUHFzVnoy?=
 =?utf-8?B?SlAySEQ2RmhvSmN4c2lKcENvUkp2bnNqM1J0TkYzUzJnVlg3Nk1IMkVST0Zk?=
 =?utf-8?Q?/ymjVXZApGE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2NuOWhqR0gvUTRaK1RLVHdaa2hnbHBQK3poL3BIaTROUU5TemFaQVc5NkxN?=
 =?utf-8?B?MFBiYlU5bExtdm1OQS9jRkZDdjVLamZQN2tiRUlCN09YK2UzR0QxcGFGcmha?=
 =?utf-8?B?QW5SYWNPbHYrc0ZsVlJQUEZJYXZOK1RkZE0xYWk1K0Q1L2VyOHNaWlpoKzYx?=
 =?utf-8?B?Zm5nNi8vOTNKRjZkc0IvZmZkaTYzdkFvWFZQbnVBUlRXU0VzeVFXZ1VmMGJ6?=
 =?utf-8?B?d1pGMnhVbzFocXh4eU8vbkUzZmZrMjZRT2FEOFFKMjU4bGJkbEpJYiswaHp5?=
 =?utf-8?B?cW1veHJqcUpUYWxBaFo3eXJNSXpNWjNrQjBDc2NSN1F3T2svSjBhTFJOVXFY?=
 =?utf-8?B?T0w3dEEzd2J0bGsxb0FWTXN1d2NYcVQzLzhQdURYdS9CUlE0cDIxdk5QRnN4?=
 =?utf-8?B?YzIyVGJ2OWJyQkFyclZieHlua2tZK3pwSHVkaSs3cjUzV25lR0tXZmF0NFh0?=
 =?utf-8?B?eEw5S043dzl0Z0Y3Qk9IMFNwMUVQeWRJakREdUxDRzBvMm1HNGErNnM0eWtV?=
 =?utf-8?B?OWJHR1BXbUYxTUlZVmpPMm54aG5GTlBuU0lrbHdtQnFDREg1WDlsdXh3eUFB?=
 =?utf-8?B?OXlUZ2puY3RiR2F2bk5uYkFFeDZxMzMxaHUyaXNXOGMzTTBjN0xPTGt6T1lX?=
 =?utf-8?B?RGgyZzNLUDkxQmFpNDBxQldKSHBCZ2IxUFBORWFFRnBJMWZCQlRGc05Ca3RE?=
 =?utf-8?B?VWJEVy9idWRoQUtWcHVMWmZGUm1iRkNiR1hOVThaaENFSHRCWi94WU9BTDJn?=
 =?utf-8?B?cTFMRFdCNS8wSTRBcXlWMDRzaFZmdmJGa1BVQUtBbk9IT0FwcEo1WVNzNjdM?=
 =?utf-8?B?SGU4Sklldlp4cm5qYU9sNnh4RzJuSGtveEFiaUkyK3lGMkR1ZVRjK1FHRHZ5?=
 =?utf-8?B?RVpEVXJYenhKOHNDZW5mWWFodTB4aExCOUNON0k2b2Y1cEQ3UFJIVWVodS9j?=
 =?utf-8?B?SkFLWVd5emNGVWhoTVd0a0Fic1loZlJpbkIrK3RqT2FyZ2g4VjJtT3VwNW0r?=
 =?utf-8?B?WEpDdmp5eSsvelI4Z3dkc3dSK3RFM1U0ZUVFK25KOWFhNXhuYnEveWl6NE5G?=
 =?utf-8?B?cWJ2R2tCN09mVXdNZ1M5ejBGazA0RzZyckRxM1NOa0pLMkJHMFZmbUNmdHlM?=
 =?utf-8?B?NTI4VWZVbUlMT1pUcTZidUxGb1NlL0ZBL1o0ektQMW5FQ0ZSRHhTamkzbktB?=
 =?utf-8?B?aEd3TTZuWUFSWDRSbU5BSzlMbitQd2pubjJrU2JFMnlhZGtuc01IRC9XYURC?=
 =?utf-8?B?dU45bmtDb0FKVk9FWjhJMzBtUG9teGtNTDdQbzc0MFVPa2RuTjBZcS9zTUJW?=
 =?utf-8?B?VWlKYjJaVWVSczRuZHk4dDBtYXdrWkI4Nkp1U2dSVDVWcXY3MXZaU1l3NGRS?=
 =?utf-8?B?WTZ0WFdSNG5uaHl0eDVXRDVXMndaOURKZXZNcEUxRXFtZmhaKzE4MExiTlVX?=
 =?utf-8?B?RUVyblU0bHA2cjhhQ2NESFNUbWNiVks0YjQzc1R4cEhQYzN1MGsxd3M3SXE1?=
 =?utf-8?B?R0lWcDQ0aFNsQm8wc1B1TXRRd0pORDlVV3lZSkppZ3NSLzcrRGNKY25VR0Yx?=
 =?utf-8?B?aEV3cVZuN2dyZ0h5YXQ1dW03NmRhUXVDalVjb3MzOThLMGtkUzVlU3loYmYw?=
 =?utf-8?B?NWdDbURQcmZuNzZVOFdLSEZsSElkeTBOZ2kwN1Jrc0RCRFdJMzkzYkxYUk8v?=
 =?utf-8?B?WjI5bnZHcGlNWVk2T1RnUEoxWGtjclErUGpVUitpaWVad2orTHdBdkxkOFZ1?=
 =?utf-8?B?N3l6SE9hMm5Yenh5eldtMkVxeFp6Q0IwdGp4dGJVcWNSM2dFQ1llM0lWYkpr?=
 =?utf-8?B?SmZoL0ZHK3AwQTRBTmV3V2dnSnpFVHA3NnZYTXBrTU1ZRjNVSDd1MndBRG9y?=
 =?utf-8?B?SUJUamF0MHhVMm5RdTlwMm95ZGxKKzdsem42T2NYbGswZ2IxdlVQa3huOEVF?=
 =?utf-8?B?S1NLa1Z6WmRTSHZLVW95N3A5dzA0YzJPMmRmYW5YV08yWnpMRXpyeFR0dVl1?=
 =?utf-8?B?alRraDBVQW5hQzJUL2hsWkpSMmNLdE5ybEduVFhSUFdMVURSZ2tXTFJ6bExD?=
 =?utf-8?B?b21pekZ1Q3I3bHRxSlRaU081NFFlYlhlV2pjYmQ1T2VKMnlRclFRYVMxZTdP?=
 =?utf-8?Q?D2halE2i5nM372RD+IzDQ4lTH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9a9e63-a948-41aa-df64-08ddca08c022
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 16:48:29.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBbrG/yvSlWsu/PM4UibadfAEu5R9fUXRIWQYMDtmHnGenS5jmlNPFcqjKjbZ0uK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591

Hi Reinette,

On 7/22/25 18:27, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/22/25 8:51 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 7/17/25 22:51, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 7/8/25 3:17 PM, Babu Moger wrote:
>>>> System software can read resctrl event data for a particular resource by
>>>> writing the RMID and Event Identifier (EvtID) to the QM_EVTSEL register
>>>> and then reading the event data from the QM_CTR register.
>>>>
>>>> In ABMC mode, the event data of a specific counter ID can be read by
>>>> setting the following fields in QM_EVTSEL.ExtendedEvtID = 1,
>>>
>>> Seems easier to parse when "fields in" -> "fields:".
>>>
>>
>> Sure.
>>
>>
>>>> QM_EVTSEL.EvtID = L3CacheABMC (=1) and setting [RMID] to the desired
>>>> counter ID. Reading QM_CTR will then return the contents of the specified
>>>> counter ID. The E bit will be set if the counter configuration was invalid,
>>>
>>> Where is "the E bit" defined?
>>
>> QM_CTR MSRS bits
>>
>> Bits        Mnemonic    Description.
>> 63		E       Error on access to counter
>> 62		U       Count for this event is currently unavailable
>> 61-CNT_LEN   	_       Reserved, read as zero
>> CNT_LEN-1:0  	CNT	Count of monitored resource or event
>>
>>
>> The bit 63 is "E bit"  -> RMID_VAL_ERROR
>> the bit 62 is "U bit"  -> RMID_VAL_UNAVAIL
>>
>> How about?
>>
>> The RMID_VAL_ERROR bit will be set if the counter configuration
>> was invalid, or if an invalid counter ID was set in the QM_EVTSEL[RMID] field
> 
> It is not clear to me why the comments only mention one of the error bits handled
> in the code.
> The motivation for hardware counters is that reading of RMID may return
> "Unavailable". Does this imply that reading a hardware counter should
> never return "Unavailable"? Why is this error handled as possible when
> reading a counter though?

Checked again here. Yes. RMID_VAL_UNAVAIL is also a possibility. I should
have added the text before.

> 
> 
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> index a230d98e9d73..026c2e2d19d3 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> @@ -259,6 +259,76 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +static int __cntr_id_read(u32 cntr_id, u64 *val)
>>>> +{
>>>> +	u64 msr_val;
>>>> +
>>>> +	/*
>>>> +	 * QM_EVTSEL Register definition:
>>>> +	 * =======================================================
>>>> +	 * Bits    Mnemonic        Description
>>>> +	 * =======================================================
>>>> +	 * 63:44   --              Reserved
>>>> +	 * 43:32   RMID            Resource Monitoring Identifier
>>>> +	 * 31      ExtEvtID        Extended Event Identifier
>>>> +	 * 30:8    --              Reserved
>>>> +	 * 7:0     EvtID           Event Identifier
>>>> +	 * =======================================================
>>>> +	 * The contents of a specific counter can be read by setting the
>>>> +	 * following fields in QM_EVTSEL.ExtendedEvtID(=1) and
>>>> +	 * QM_EVTSEL.EvtID = L3CacheABMC (=1) and setting [RMID] to the
>>>> +	 * desired counter ID. Reading QM_CTR will then return the
>>>> +	 * contents of the specified counter. The E bit will be set if the
>>>> +	 * counter configuration was invalid, or if an invalid counter ID
>>>> +	 * was set in the QM_EVTSEL[RMID] field.
>>>
>>> (same comments as changelog)
>>
>> "The E bit" -> "The RMID_VAL_ERROR bit"
> 
> For comments to be accurate, per the handling that follows, RMID_VAL_UNAVAIL
> is also a possibility, or is it not actually possible and just coded to match
> RMID reading?
> 

Added the text now.

"The RMID_VAL_UNAVAIL bit will be set if the counter data is not currently
available."


-- 
Thanks
Babu Moger

