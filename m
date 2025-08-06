Return-Path: <linux-kernel+bounces-758423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69192B1CEEE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183A93A7235
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BD322D780;
	Wed,  6 Aug 2025 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZWYmqPsZ"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF620E6E2;
	Wed,  6 Aug 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517893; cv=fail; b=LJe/rm4Fem5Lujb+poKFBB/NrjMcKQ3CPTEbdiLby+vssnavf4LIMAgFsSXMcjPWFdY9Ey1Zt0Yg61V7AuP9/jqydRDjVR1KHkfjB2Ca/DSMPsahLCjwgYLIMJxqJx7o5UTc3FhROomLJz4iKcbdC8fSvZqq+cVPnuCITJy4lTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517893; c=relaxed/simple;
	bh=xR9FNK4ZM5jImdCvUbjCFBmV7vZL1DV0+M8Mfyn1p7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PKFexsMXOhaNtmwRe6KE71zXbDkseb61CDKXY3vKUOCkQcBNUFR3jqDAnvdrGm6ztFBFEeE1MDAUVdIFml1i4R8/pmGXyCPPXXSbkO++cQkQRrTjPg48ZYCNhmrQ0Y12ay1bjxKiD6v69YBFMqtI50HbeaVFb0V5UzB61jjk0x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZWYmqPsZ; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=au2fJNZhWlrWLIOgn9Mv1aIRy63CxHlinCdsOhn4BODmxmKio2CYrkt0hBCJfYDl3sw124juUijagE2SOK6yFovA/oGKbb/ltPV74OK+r7O4G1AoXC1Na62Rquc+vJdibd2pwkLaSWip4jK6fj+BIpIilgxCuSPdFuFlIL3AtYzl3Gjyd9VLHZyT4NMEDKblqi/4v3hH6YEIjCVKHi0Y0UYZuMWFXtCrJCUMMg3ely2RHGza0h+F78MwVXIyIGGINeZxloPMhQ+pl3X7qNyzo0SZz0kFy+4kaCDB3jv+pNeS0fQfci5BZh6av95hzSzi3uJ0xNerMAMvnY3Ibx6YLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DFrmM6Tu5e+MS8Fhxb5ubWjaKWoN5uGmOAyhuBdAvc=;
 b=foZHFVO4SLam6gufZtOKBl9ot6Ks3GhRwTEvjNcjYuKrmm8arOczGGGsZ61eIS/GDlsDY8dLeJ8+wQKwUZu+f0v+q44e5H27CxpDkXsZsrFzGBlXjCwAMz5lLROCYQtVz5AixVajoJ5b93sNNVmSU46fJ9bcsX/OPQrsPHPKhHXq6OtjFX+ADltD7S1Hx0abCxA7n4QYkSxCAYSD73DbCABMAK2DR0JIzXbCCb9VYwUGOfhchcFQ57f15jMwi5Zv5APZPHqTm/t6xclhmcD7HdCl3aOmFuKCEDOTWZkB202RqNmUK2xrXX1j98g3qwG8mPiM0C7aZqPWmA8ZVQzbZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DFrmM6Tu5e+MS8Fhxb5ubWjaKWoN5uGmOAyhuBdAvc=;
 b=ZWYmqPsZbcaVtVX4TKcyG99U3KqDiIdRtiMa+yGc/Q5x8h0YydhIOHq2Ipssbr4Nj7teB4cE/ugwvF3j6Qu640U6vw7AQEfT2ACPSDK9Jp3U6CTRYKzQLbfpzaU9iNHhrzPMy3bKrr8hUK8bD6Gp7RXoUM+xRS2QCE6VjLCXt3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by IA1PR12MB6163.namprd12.prod.outlook.com
 (2603:10b6:208:3e9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 22:04:49 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Wed, 6 Aug 2025
 22:04:49 +0000
Message-ID: <05075026-38b6-408e-bbe3-15572827365d@amd.com>
Date: Wed, 6 Aug 2025 17:04:44 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 13/34] fs/resctrl: Introduce interface to display
 number of free MBM counters
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <9e805169d3fbc889a89b283d074a5dff23cb0e94.1753467772.git.babu.moger@amd.com>
 <a549c986-5914-4e00-81d0-994c933550c2@amd.com>
 <f07836ca-8504-4619-861d-c2e9a6f517c0@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f07836ca-8504-4619-861d-c2e9a6f517c0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0104.namprd12.prod.outlook.com
 (2603:10b6:802:21::39) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9bc915-6997-4a59-b397-08ddd53542c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzI1VmlmeTZmeXA2bk5XT0p5VkJGRlczM3RrM25PckpxNTN4ZldWb0hkcFlV?=
 =?utf-8?B?Z1FXelN6SkVIb3ZzM0NMMHk2bGR6UU9sOVFUTHFScDNrUStQaDZlY0lqUjdZ?=
 =?utf-8?B?cjVYakJEaElkalRMZ1p0S2J3Z3hoRWc4NDdKazZuTEs4dHVuSVRVaThuNitR?=
 =?utf-8?B?dFpEbDUzYXNrN0gra2tRbFhBSzBWRk1iWFhHaEE0U3p5d20rVzVBMEFPWmdh?=
 =?utf-8?B?WWIyMzVUL2RqTlczaXF2ekg2ZDllcjRvSjJNVE8xcmhlcE9QYTl5K3Q5Nmsy?=
 =?utf-8?B?VGd6a24rNW02L2VuK2JPV1BPQUFUR09SU2lVVW9FZ0RlekVjeDUwK1J1TTFv?=
 =?utf-8?B?OUV5WElaandlenBIN0NYMzV5dHJJMnZkMkN1QkZuK2hGTUlPTElBZU9zaUp4?=
 =?utf-8?B?aERwOGsxa2JsQXdyL1doOVF3TVhlV2Z3NTVjLzd2bWlPZlUvTlFxRjE0UE9r?=
 =?utf-8?B?VHMveUZvZEtCUyt6Y3dkdlFRdFVjVkNhWmhFSFptdkVabnRvSDFNQ2R4YU5L?=
 =?utf-8?B?dlhWUmhsQWt3dUd6aHVJM1NLdVF5bDczMU1wTnVId2trcHVDMzdjKzhkblJO?=
 =?utf-8?B?RXJucE9kbzh2MlZIV2JWVTZxZjZFSnQ5VUN1OEp1TXB1eWl4MHNSNC9pd3Fj?=
 =?utf-8?B?UHh4aVpiRDBFNEZUZitpMVZiQ0lyV2h0SVFNTWdIL0k3OWNoUW1Yb3pmNUo4?=
 =?utf-8?B?dmxkejVFT09DT3ZsL09GbXkzRUcxZjJKSW1NcG5ad0hvUStkOVdrWnozVnNX?=
 =?utf-8?B?U2RXbnJOUUlCd21PMWt6d3owTktxMThhTmV3ZWczVlNRaDlSMXZuai95RHk3?=
 =?utf-8?B?ZUo3NUNWeUJmbjlvTW1PNjh2MWNqbVljZFEvNUdJZzdqOVgwM1FqRlhWZG0y?=
 =?utf-8?B?TnBnMXJZaElJUVEyVzNsWFJweXBTcFM4WGYwQVc4T3FMeWZzTTFTL0R6WHNC?=
 =?utf-8?B?SVpZcmpCRmtuRVpEcWlNUzQ4ZHo2Z2Z5ZzBQdkNGMGJmNlZ2OUJ1YmdoazBu?=
 =?utf-8?B?NFh2T1ZwcFZOY0NEK3J6RXQ0ZFdlZ2lsY0ZRR3drYy92V21sd1Y2eENQU2Vp?=
 =?utf-8?B?OC9OOFNpQkRaVFJiZ1VZbTc1a0RvZXVQWThPV0FmdE5qcUVFWFMyc01KU3di?=
 =?utf-8?B?WjNNRzFJZDBNZW1PR3V3L0xpRDlhaHB0b1FNaHhxajlBTDRieXRlajk3WlBH?=
 =?utf-8?B?WWdFZGlJMWZRYkx5S3EyR2g0SWtyL1NTWUs3NjJRQWE0WnJ3T1Fpc2lGNHRl?=
 =?utf-8?B?Ym5SUjZrQjZaL1NSTWR5bVZmeG94enJzcGkyc3BzRGd1UDdTcDVqNkNSN01y?=
 =?utf-8?B?K1Z6NWUwK2lDc0VhQk41MFlWQU9udjlNeFNSV1Z1Q28yWWl3dlhvTk9kWDFn?=
 =?utf-8?B?WUpmSEE0Y2ZOcGZsRzF2TGlvbGl2SzVJS3VSNldqTkVINmhRWG1UWnNDVEV4?=
 =?utf-8?B?WFhVd2k5V2FRYWtlZUh0VS9tMWdUbTZrcklFaFpBTEtEVGRQcG81am1POEtq?=
 =?utf-8?B?dGlkZXRaSTFqTkZrL1psVUg4a3luYjJsL01oWHl0NTRHajVlQUljbm9CSGJY?=
 =?utf-8?B?TXY2NzRPSDdqR3BOZTdqYSt1andjWEU2RDQ0emo1NWovM3Z5bDBzM3N4UWU5?=
 =?utf-8?B?VWtHb1V5UVIwQnNaSGRKenBWanRnN0RqWDJwK0RQU2JOYit4TS9SSXFPcUJW?=
 =?utf-8?B?ekVTUVJNQVhaWldreGFSS1EvYkd3aFpKaWFzMmR2V2wwU0g1WUhwck9rRGxP?=
 =?utf-8?B?Tk1WbW1KdXNvekxtd0xXVTVpQjkrMVp3TGpyYmtWWWFDWFg4STBDRG52LzRE?=
 =?utf-8?B?NEtpK0ZZM21ZUkRkampEQmh1R1Vrdmo3S0FDWWJ4cktIaUdRbkJxVDdueDZX?=
 =?utf-8?B?T1daNHJVUHR2V1FpVmhHYUR0aXN2YlQ4N3FsYUxNRzVOYm9RbWJiU0U3UCtH?=
 =?utf-8?Q?lSH6o9wm8uA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c01uY2F2azAwWlBiVS9INHF2TVFXR0ZUV1lvcmh3U211elp3Z2JRRm5Wb1dl?=
 =?utf-8?B?cDl5bEdWSm55bEJ5OGlKTHFTNnNDcVZtTUJNRTlrR0JMOWhtUUwrZnNobDBl?=
 =?utf-8?B?T1EwUFFEMnI3TzhnU3B2Q0c3SU9YQ2lQOFNqNFNMNGdETDZQVEVhSkIvNDI5?=
 =?utf-8?B?QTJMU1NTVGl3aWFtQm1MWk0wdDZBRnNEdmw3MjVoOXdkNzhrdmRwSjRZQjFr?=
 =?utf-8?B?UVBTL0J6VmpSZWtyWUs2L2M5aStwM3lNUHk0WjhVWmxuVVZPM2l3U3BvemFm?=
 =?utf-8?B?cU1RS1hGL2Z6M09UVGFGU2pDdDh4bDhRY094bVlIUHg1VmtHdWpkUlFoV3ha?=
 =?utf-8?B?dDdicHhHVG1QdjRMY2oxU3VDQlcyWnBKTkI5TXhYQkx1dG5mbHROK2IxR29K?=
 =?utf-8?B?VFhqaHpNbWFxNFQrdnNjZk8ycDJlZjN6MDlzbVN1ZW8zMHo4T1NJUWUzYUdV?=
 =?utf-8?B?VW9XbWs0L0FPOHdLY1JJMjJzTWVJMFd1L29EVi8ySkhLWlN4WlQ4aTRaeVd0?=
 =?utf-8?B?TjVpODI5MUNCMXllVHJJSklWVmx3STErVEtTWGlQaHBlYTYvVVBYSGVHNFpD?=
 =?utf-8?B?NDFEdHhSMjROenhGN0lod1BGRFFyVDNSMWFxSVlVU0JFbElUdGhxbHgwQmRB?=
 =?utf-8?B?dGxvTzFhRFFIMnRHcFl4cTJyRENqN0hWdDZ5ZVJzdHpDeUxHam1FdDhCNUNk?=
 =?utf-8?B?ZDBIanVKRVVXYWVMZkppUzZwMDQxYlFPaWF0dzh5b1E4TjRhSFdaQzEybG96?=
 =?utf-8?B?aFVkc1BKTW1MaW9zT2R0dHFGRHZ1MXRvaXdnYm52Z0k2UUpyWFI3d1ZMamp1?=
 =?utf-8?B?NjNNSys1Qzh3amZvaElId2hPS21BNldCeSthT3lFMmFGR2R1RFhpcGFrdkp1?=
 =?utf-8?B?Q0RiSW1Ub0RzSGlKM0IvRHhuNmQvb0dqY0lDakgrSm1tV2pGUSt0bm9oR1g0?=
 =?utf-8?B?NE9icXI4b2ZHN0h4NFJRQ1BnTHYwQ2pGNHNub1ZhZEQzYkgzNUZwblYvVFFl?=
 =?utf-8?B?aTF1ZDNxcXQwU25XQko2bmVERU4zeWJ6Zk1xVnhHdVJOYjhZaWtiblNrK0hG?=
 =?utf-8?B?WkN4MmFuVkpCVXNzWVEyMWxONUdQQ0FGN243T28yalRVSERhMVViSE9jNDZR?=
 =?utf-8?B?bHU3SWcxZHlwWjhhQXRoUm9hL3Y3K0UySEQ5Ykd1YmR0eGJ2Vmd2Wk0wa0hQ?=
 =?utf-8?B?MDlQeXl4VmhCNG9Ub0RtR090d2ErcStoZWF6VUJXeHZrS0FUUUdYNGpkWW9O?=
 =?utf-8?B?SlVxcGo4aWR3NTltNFBVellMVWhJUkt4djNhUG1EYnRNMmM2MnQ3MW0wRWRI?=
 =?utf-8?B?WmY1dDNBWEpCd2ZTanNlUkxwTGYvdnhDL1hnbnBCV3lWYTJ2MHRXbDJuWWtP?=
 =?utf-8?B?L1ZVTHNXQnZKcGRaNkJDZEpDT0R2MXlaejFOZytPdE16SFpxUUdoRVQ3bEVj?=
 =?utf-8?B?aTRsVmdsdDRER1R1VHMwZS9uWG8xS1h2THZjWWNPN3AydThCOGdTZWpUdDlI?=
 =?utf-8?B?TS9sRlRIMnlxYUt6OWNuWGFOU3pSUkxKMisvS2tUdFNtUEdVNSs4UkltbE1N?=
 =?utf-8?B?U0RsUTJDM3JDMzhHQjRXc3kzTjJIbS9KTllUbkNQZEp5UkdReU9oaGd3eVRn?=
 =?utf-8?B?dzV1aGNQR0xpd2J3WDk3bzhYZEZmaTNhSXJkSldRSGdUakZvdjJUaForT1Rn?=
 =?utf-8?B?UXo3RWkyNDE4UkhvZXZ6NWxtQnMxOXRjVDJ6UzRDL1pHcEVvL3JCcUx1NHVY?=
 =?utf-8?B?Wi9vWm0yckc5Tk95dkFOVWRRU1YrOUtQWFJDWjFvMXBoeWgvUW53YXBTSTNu?=
 =?utf-8?B?R0lGQk1SWk5LcVVXZ0FLaFNpTFNPajJxRXAvby9hQ091eUVPbzVTbGhnTEh6?=
 =?utf-8?B?Q1FNSVhrYlZSWmh5bGtYSS84cXdJdC9FQ1RnR2JscHY4ZmVHWnJONjBpdzJu?=
 =?utf-8?B?bjlMZzkvcGVWZFBpU3cvSmJCeW5hdW1HN3U2a3p2UWtBa29vS09qQ0gzQTdP?=
 =?utf-8?B?ZDhvVUlSRWg2bUtQd2pCeG1ObmhjVnBCNGh2dkxzQ3J2bk53aG56VzVzd0kw?=
 =?utf-8?B?aXd0VEJHdGhCVXhlQjVlUXFtbzRXL2w4aEZZcXA5M21KTXNLN0ZnU211M0F3?=
 =?utf-8?Q?HE2U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9bc915-6997-4a59-b397-08ddd53542c2
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 22:04:48.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dR6MMVchKc64GMaISkfUUmPNKWW0yMh09/mmS3KVcOx1jTPUt8qt/KM/5spzEU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163

Hi Reinette,

On 8/6/25 16:31, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/25 2:19 PM, Moger, Babu wrote:
>>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>>> index a09566720d4f..15d10c346307 100644
>>> --- a/fs/resctrl/rdtgroup.c
>>> +++ b/fs/resctrl/rdtgroup.c
>>> @@ -1853,6 +1853,48 @@ static int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
>>>  	return 0;
>>>  }
>>>  
>>> +static int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of,
>>> +					    struct seq_file *s, void *v)
>>> +{
>>> +	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
>>> +	struct rdt_mon_domain *dom;
>>> +	bool sep = false;
>>> +	u32 cntrs, i;
>>> +	int ret = 0;
>>> +
>>> +	cpus_read_lock();
>>> +	mutex_lock(&rdtgroup_mutex);
>>> +
>>> +	rdt_last_cmd_clear();
>>> +
>>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>>> +		rdt_last_cmd_puts("mbm_event mode is not enabled\n");
>>> +		ret = -EINVAL;
>>> +		goto out_unlock;
>>> +	}
>>> +
>>> +	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>>> +		if (sep)
>>> +			seq_putc(s, ';');
>>> +
>>> +		cntrs = 0;
>>> +		for (i = 0; i < r->mon.num_mbm_cntrs; i++) {
>>> +			if (!dom->cntr_cfg[i].rdtgrp)
>>> +				cntrs++;
>>> +		}
>>> +
>>> +		seq_printf(s, "%d=%u", dom->hdr.id, cntrs);
>>> +		sep = true;
>>> +	}
>>> +	seq_putc(s, '\n');
>>> +
>>> +out_unlock:
>>> +	mutex_unlock(&rdtgroup_mutex);
>>> +	cpus_read_unlock();
>>> +
>>> +	return ret;
>>> +}
>>> +
>>
>> This also can be moved to monitor.c.  What do you think?
> 
> Yes, I believe monitor.c is most appropriate for all the monitoring
> related handlers [1].

Sure. Will do.

> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/0fa9a12b-e900-4ceb-b59c-e653ec3db0ca@intel.com/
> 

-- 
Thanks
Babu Moger


