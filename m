Return-Path: <linux-kernel+bounces-752454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEE3B175BF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A7158665D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8F028DB47;
	Thu, 31 Jul 2025 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rd/8gZAx"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DD3243379;
	Thu, 31 Jul 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983612; cv=fail; b=cHNnLC/gUfB73304T0SY5ToxYAMs7iSJ+nohQMOqP+Wt8c/NPRDwe8T//zonh8VEJjk7XKhujza4+OaKwZHfimOmEsKXlqarQCbEHgp7sYM15JdoOghYhxqIJQKRqU/Lw6J0vB+fVfA2vPYQUO3rxJy9O+ZjjzruWqdzxK6Arak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983612; c=relaxed/simple;
	bh=meTN5IVUsF3Hby7y2HN1Tk5oXgnDdtzk8XXtzDTp0/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oJwMoYu4OYaqQDGvge8UZ5GKbyizIPJ5dsHzZZi3R5BUcQjPHHruroEYul5rBFOij83lwFlInR9isiM4uzHp7jvo+se+tLtzd6QymoRMuRZ3qxdizD+hDvU0hBug8KU+joiEITryrmPDMx6bpQMc+Z4ZqUuYARMLzKRsXidoZNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rd/8gZAx; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwfJ1s9Q7enTX1S2SWSbpbQHNelsTVGE+QesWMTwJgPwxlCbMV70lcbucEkfggi7HpEbKy+KbrcCxd8hzlKR4FcxVjfWGF+LJFJ8vkAe0lg4dBuQuCKmNcHHrnfHp7avVSjZgowqiN2UnBk2BQUv9qDt5e9hUbYL3DT1iC2xKtuF83K3VxcGNdiXv5adVXoNmp/uw8yCokaFcxd26QxWtkn4IKdVpy6fnR6uuFrqFk3PCT8fTtmY1VbY+T7xFm76HBPcq818gZxYxOaV8mdX/NzvAi12/yNoADJsUKRFs32+cCrJcjNa1orOhFFvTJtc2ORw2HVJgEcb1teyLXU54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrGy0/SXVSh02M/ASqjlTYWa6s7ZmzgZBbefnypecAg=;
 b=E+IoDHSAnFLGVU3pW2cY7UdJtN7TQ32A4a0+xSba3jnEVWIm5cCgK1Nl25/lmX3VpPN49ive8aZziiNTSxf7vDYT/MrmDj9vcJsHdXUnF7LYMNECjdjXgn6mqC6LTDQ6zPB25jeoB9ojelPZFF4jVFpKFyf/Ym/kmtLNu0Y+RxNxJcQg7a6aHUz8dRUdWNUDWXHEiFnuLrozHCVaalffNsjTDTdtHJmT9EWhW6jn/DuCL6kAcbCEkzeXQVEnsUBb8FGQE8BzWdD+i28wrK5jlyRHljSntuV9G6huvoaBtwt6ZVIF1zvyZ9EP3Jnsz20Ug22cmb2Lld2RzjvBJ/c24A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrGy0/SXVSh02M/ASqjlTYWa6s7ZmzgZBbefnypecAg=;
 b=rd/8gZAxBC29AKzwegSr99LB7EuPOK6BTK75sgdABVvtMsTQZfyXBF8NECFUU13oixNCX9HIK2+o1H5sk2AqlCoWT0q+Hcnec/NifcqRoKu8+G6l3vu0dHvDGoTE6Q8W0PZJTBkdBrXFYZw3GTpKor9pOv4WZXeYkolgFovZIBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CYYPR12MB9013.namprd12.prod.outlook.com
 (2603:10b6:930:c2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Thu, 31 Jul
 2025 17:40:07 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 17:40:07 +0000
Message-ID: <4abaacdc-4b13-4752-a0c6-e55c428e91f2@amd.com>
Date: Thu, 31 Jul 2025 12:40:02 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 04/10] x86,fs/resctrl: Implement "io_alloc"
 enable/disable handlers
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
 linux-kernel@vger.kernel.org
References: <cover.1752167718.git.babu.moger@amd.com>
 <b7c61425e9da008add366958a26f7d8e75eef4a4.1752167718.git.babu.moger@amd.com>
 <09d7e417-0482-4172-b110-417c12558481@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <09d7e417-0482-4172-b110-417c12558481@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0154.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::9) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d30f637-cde6-4997-c4ed-08ddd05949ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUViMnZQUXluYUtSQVVOaW5HZUlDdTRHamR4cUR4MW9xeGFRM1pGWmJaRysy?=
 =?utf-8?B?djNYMTVBVHBxcFZyaE41TW9qQmZMUHIwUTdBcGZBRU9udHM2Ni93a05XS04y?=
 =?utf-8?B?TkRTRTN4WFlSS1RiN1NxZEEzZW5JbW4wcFRyYlNvL0htN0NGWkQ1N3dFTitj?=
 =?utf-8?B?YU02OHVJK0JPR2RNb01HTDBNYlJSQmY5MnJmNjNwOW51OXB0MmdTU0U2UUxh?=
 =?utf-8?B?ZnBJNDFzeHZKMlF5ajBtdHZBL2t5eEV4OWsvc2lXZlZQSmpHbHZRVVpQL0ln?=
 =?utf-8?B?cVRjaGMwODFtcWlERFFxdGRSbjRSOWxuNEtZU3c3Zk1pZXNreWdMbWtrSXVC?=
 =?utf-8?B?eURUZVZtcTN0cnM1REZCOEk3TStaMlRKVURBc0w0ZlF6RVJMcEtDWmg5bXZN?=
 =?utf-8?B?QkxWeTBBUTJQb08wbkxmNm5MSkgvTGd1TitiZGNOQ0I5c3RCYjBWYnhXcytE?=
 =?utf-8?B?YldLbmdLcmcrL1VsOTZ1Mmp5cU9YcGlhUEREU091T24yRjhYcE5INkU4LzZE?=
 =?utf-8?B?SG8zQkU2c1Z4N1hkMTBCVW52VDJRaS9oL3hOM2RRSjVKSm4wY3hWdWpHcklN?=
 =?utf-8?B?YThXU0xWaGRaQ1NLWm5jYVhkRU1sSDJQMHdZTVVNV3VVcTFEQVdQUmZRU3NJ?=
 =?utf-8?B?QWlxT2k2RGEzcWJobm1UOXZjY3ZFWENGbXVHL1lWQ0hFa3B5SENDTnp3eURv?=
 =?utf-8?B?REowM0dVS0tUYmUrOFcyZGg3bXZxdEZGSktjeDhHSTFTVENUWk43eGZaU3pX?=
 =?utf-8?B?c0EwS1JhTWVpdlpEODhLV0ZJWUxXRlZ6bm1Pak5RT0VjWnhNRWdIczhkb25T?=
 =?utf-8?B?cjZVTmUvbmt2WEJONkJ1OHFuQmJqSHRYOEdKTm5LQm1rbVZKTDdGOCtnVXdN?=
 =?utf-8?B?bkQrRndJZ2hHNmg2TDA2aGhuVDNrQ2M5Q29DaDZzUFJzaVFyQjhmcmFWTzJ0?=
 =?utf-8?B?UGJyd2lBcDMvTzVNaVg2ajV3YnNIY3VrSkhsRm9Ybjh6cHgxaVRZS0JJc2dT?=
 =?utf-8?B?QTliU2luYVlCb2tkeVhJOXg4dW1GeVBOWDlRVU1GKzNQYlNwaTU1M05PU1Mr?=
 =?utf-8?B?TkZ6SjZqYmVJZ0tGNy9IM2l4NU9DUmRjVW5EOXEvWTdGaVc0YVk1Y1dJd3Bq?=
 =?utf-8?B?SjJGY3VSRjM5QVRsanV5a29neGw5alNRaEVnWlBCN3lzZDc2MVlFVEtXUWFI?=
 =?utf-8?B?SHhkRTR0Q21NY3lQRnllOVdtdU1HY0ZEbWhMUnRwUThPR0lHb040QlFid2xB?=
 =?utf-8?B?Y0FKSUhhVDFMamVkaHcrVHJzdUZTSUFncU5Tb2lIZ2JUc3E3Qmg1bzhDajhj?=
 =?utf-8?B?QWtJY281NXNvVkMwc2h5QXJGTUU0bkxOSmRITzkyTm5SWFY2R3pYZEdGa250?=
 =?utf-8?B?MjhjTVoyemh2UjZ2eWJEZnJZMjhucEcyMHJCVnJYVUZCU01rQ09TM1VOeERB?=
 =?utf-8?B?RDdPMkNnb3NSUEFJUlhyOWkyV09RSEYvWTBjOXJmTE5JVE9PYkMyTUxldzha?=
 =?utf-8?B?K1RpZHVyUU5HUGNPS2V0T3N3RWtkd3ZBZFpKK2VUVE1aUXk0czN5MGVSUFBa?=
 =?utf-8?B?YUs2MFFCazA1QkthUHhBZHZVdXhnYjVDMnRydFo0akpTVU5KbnhmRjRTZHJS?=
 =?utf-8?B?TUpaMERDa0xZRmw3Y2lObXBRYXp3K3g5eHlheDdTaFl0QThYVjNUZWJpU2gr?=
 =?utf-8?B?OXpmbk9OQ2dCNjJvUW8vdGlhZFE4eGNJdDZMcUZ6c2lUak8wcTZVdEgxQnl0?=
 =?utf-8?B?YW9hY0J6NjFjRURkYkpZK2JBdUdtQjlnVzFGdVcvUDkyaS9iQUVqYWhuSzFI?=
 =?utf-8?B?NHVNaDVmdlBZQmRFdG9ycjNJSm4rY0hvb0p5VlhHOTZjeGY3VzJRTEJJRUNw?=
 =?utf-8?B?VXFoRlhnSm53d2xZVDhUYTgyRzc0SnAvUWRlVjBiNit5WUtuTnZSRmVNQzN5?=
 =?utf-8?Q?7aMW5I5KqT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTBYRjE5VWExNVRMNnhrQnEybG82ZSt0bVVVd1BFMXlDdWM5dzR5cERHNXlW?=
 =?utf-8?B?b1A5L1BDaCtkK1hzWG5NS0QzV1hraWt0WkRyVEh4QTFiQ3QyblJ4Q212d29q?=
 =?utf-8?B?N3FjMkNkeEZ1d3M3aWhqQnNiV2duY244YVpqTXJoSTRiQk93TjRuSGd5Y3JC?=
 =?utf-8?B?TnBPdUZ2RUpDZnhuMjd1ZTV2d1laMUdlS1ROcldDTjBWelFoRkF2SVpaQy9r?=
 =?utf-8?B?MkpmRm5HL3BpNTJZY1VBcXhnc3JPM2RQaStqbjBiSkpzbW0wZm1SMkRNVGpL?=
 =?utf-8?B?UGNQeUpDOHZYUHU1NUJ3bW50UTl3RzdOc25mRWZOckNSNHpTZ2U0SmROY1lN?=
 =?utf-8?B?Q1lKODQvMzI1clFnRXhENkg3c2xMcm5HMERiK3A2eEUrVFpvblFEN3FTTUQ4?=
 =?utf-8?B?dEwxVGZiNkVPLzdOdVcyZGVjbHplckI2bDdBM3BxU1VLSm5YUmlKaDl6WFNk?=
 =?utf-8?B?RWhRMDZHY0JyS20vT1RGSGoyVDdTOXVJamV3NHB0TVlpdnBOeUVra3Q1TnVK?=
 =?utf-8?B?bGdLZjJhc3F0MllGK09pc2s5UnR4ZG5yVXVyTjFMOFo4OFJRdE5NZDhHdjZv?=
 =?utf-8?B?dUV4MGF2UnhuMmYySFYwL01rOHdoWmx6WnVUdG1rY0ErcTNtSTFYNHdpQitC?=
 =?utf-8?B?VEVLS1NXOTM3SGNha3ltYlRYMkNiT2JrOWg1ZlNKRDA0Q2d6RjliRDBMTnNB?=
 =?utf-8?B?a1J3c0lwSWtzQTdnRjdoWkFHaWg4SUx5a0piK3RWR3lYRHVmNy8yeThkdkVP?=
 =?utf-8?B?NkVCdSsxbTNJcWxqMXNJMkJFYVA1bEY3R0NqeWwvQVVEUWhFTGdsVzNRaHdw?=
 =?utf-8?B?bmNQay83SVRZV3B4c3E2L3d2ZmtKbkJZYjl5R21qMCtZYUtXMmxlT3dhWC9n?=
 =?utf-8?B?ZUdxMEpoNkJKUkgrcEsvNGZRWmd1K1ZiSTF2T1ZnRVI5TDRraW1MMWZHT0Jw?=
 =?utf-8?B?M2d1dDFzQUZnRHdXTS8wRE0yTVF3TlBLVURlMGd2VGZNSWxxdEZwQ3V2TlBH?=
 =?utf-8?B?R1YwMGMyNlRZOGNzL0gxWFpHQ2g5V1JwV2xZdHFaYTFLdTlCSEgwNmtmTVlE?=
 =?utf-8?B?MDgwL0hlYjYyN2lYcFZ1NFVhdCt3Z0txMkp5TVZLUDZrbDFSWHdDQ0lRMzN4?=
 =?utf-8?B?b3lMVWJkT0U5cXowOGlhd2ZlSzFNdktzeWFtbFJibUR0a3RCRWpRMVB4Z2VL?=
 =?utf-8?B?dmhkU3BtMWJvanVsaXc0Z0p1VUh1bTg0bC9vaHYzSVB1bFg4QWxNOGllUTdN?=
 =?utf-8?B?VG1GMC9yVVFEcWRIY3NPSFFKb2ZNc2VXd2NsUGROVjJ5U2tZRWJEcW9qeDV2?=
 =?utf-8?B?SVdUcEVhYkRXRDlYYVFIYS9FL1JWZkdYa3gzKzEvaHJubFhFcHpMS1h0Ri9K?=
 =?utf-8?B?YVZkeTZ1QWV4NG5XM2E5aE1yQ1FzSVZoVmkvYmIvZG5EcU9JckpPbS9id1lm?=
 =?utf-8?B?ZEIyZEhoZzh1czFSZDdEem4vVFR3b05PMVNMYjlVeGdHUDY2bzY2TWRiclU0?=
 =?utf-8?B?N1JMb0JIN0xjYkZ0K0JiWUdEVzJrOStBd1paSW5QTEhpOU5Xdlg4b1B6WG5E?=
 =?utf-8?B?ZXdCS2hCWXBYTVhzeEFBL2FaYXV4dWlLU2IrYmQrZUd0Zm5vKzFlcGc0b1RD?=
 =?utf-8?B?ZS9HdzNSWUd0M2NmU3lqK3QwMTN3NTdnN2lxSmlGREYwNFNaOUw0NmZjbHRC?=
 =?utf-8?B?SkpRV2F3RVNITmxZeWRMY3VlcXRwQzlWcHRZeXhuWWpIYWRPWmxKWXdUM21m?=
 =?utf-8?B?Q21oT2krVGJ2R3MrSmJrRHhVN0RlcFl6a05vUjN5NFVCTW9tY2ZQbTFmUkNz?=
 =?utf-8?B?L0xXNVNkVU1yNDZXQmVPSkozempCbi9oRmEzM3dKNlM2YlJPQktzU3h4a1p1?=
 =?utf-8?B?YndLdFk5bDBtalE1Z2ZSQlRqNjdZamtrSjJWeXlGbWFpZ0lRMU5NdEQwMS9u?=
 =?utf-8?B?UFZGeGNubmM0SGxKS3ZLTFYvNUhFRmNlSTlneHJkZnRzNG1sSFQ0V2pybW5C?=
 =?utf-8?B?RzErT1RMV2Rub2pBVEd5VUlBQ2hoUlp5NUNNK1J1b1p2UEpxQlRKOFRDamg5?=
 =?utf-8?B?VkdpU3gwWTVYMmQwSDZnZHZNTjlXcGRZREJrSk9qSkhIdXE5NWlmaGkxTnpX?=
 =?utf-8?Q?BJVSN4Yo9ggO2iA7U8SFLxhsq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d30f637-cde6-4997-c4ed-08ddd05949ea
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 17:40:06.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kszR6tLCegAwEllH4W+sfkCNxweslhPz0AmhgNve2hDzB2wwf8inGqv8EVmYKcHQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013



On 7/21/25 18:32, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/10/25 10:16 AM, Babu Moger wrote:
>> "io_alloc" enables direct insertion of data from I/O devices into the
>> cache.
>>
>> On AMD systems, "io_alloc" feature is backed by L3 Smart Data Cache
>> Injection Allocation Enforcement (SDCIAE). Change SDCIAE state by setting
>> (to enable) or clearing (to disable) bit 1 of MSR L3_QOS_EXT_CFG on all
>> logical processors within the cache domain.
>>
>> Introduce architecture-specific call to enable and disable the feature.
>>
>> The SDCIAE feature details are available in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
>> Injection Allocation Enforcement (SDCIAE)
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>>  
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 885026468440..c165ac333336 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> 
> The code looks good to me but rdtgroup.c is becoming bloated by being the default place for
> any resctrl changes. While I do know there are counter examples (and I admit I do
> not have a clear understanding of original intent) ctrlmondata.c is documented and supported
> by its content as the place for cache allocation code. Could you please move these changes
> to arch/x86/kernel/cpu/resctrl/ctrlmondata.c? I will try to highlight the other places where
> I believe the either fs/resctrl/ctrlmondata.c or arch/x86/kernel/cpu/resctrl/ctrlmondata.c is
> more appropriate but please as a high level consider where appropriate to move the IO alloc
> code to be with the rest of the cache allocation code. Looking at the series it will help keep
> a couple of existing static functions static and keep data structures local to cache allocation
> code.
> 

Sure. Moved it to arch/x86/kernel/cpu/resctrl/ctrlmondata.c.
-- 
Thanks
Babu Moger


