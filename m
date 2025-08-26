Return-Path: <linux-kernel+bounces-787170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59022B37268
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292CA1B68426
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9324F370589;
	Tue, 26 Aug 2025 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xTjDXPg7"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061612DAFDF;
	Tue, 26 Aug 2025 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233660; cv=fail; b=Lk/94QZu5ER0HtkXgwmyynaO1KYMY6Ei0SFOhx4FWn/k80KqFhdoPZzCxbcLXCxnKhNsMSgoRu7xdKZgyLVufTWoNlEw91wtSWoQsbvP6zi9Ers60u0dHpXs0sOrdmKZe7i7XvH7ie0NDVhndqQzvpLJYdAJ69UVzps2GGdUjw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233660; c=relaxed/simple;
	bh=rFsu9+zcvUwhy2uTEMRWNn41F+lY/Xu+JGSaZ5afgIM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SE8dh4vqULXRueBaJ1eci5zutGWFrJtcsWh9By6UJfAAAaFFejkUEN1AUfY1gCivtH5uk4/or6lxh+tJ5A2XUs6/GThZ77tB8CGtltojiKz/c53dSuVWvNG4uUUR+uP/RkexIH22EOKraj4mOBUwb1PaSrYrqXZFb38j8BE18Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xTjDXPg7; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJUHEYuc1qH2HeQaaBtFE0ru/C10xYUEuNReSTwXMkezWOtrUMLD2fNyCQQ4H+d9O+e7hG0xpHOl6q/ItvPQH8pHimxnW7vO/URvstA9mgdBv3ww17yhIanbHc1E9Ip3iC1x9LNGSldh2ZRgyZw8RtxThiunX6KcLIOek16aFWbesMQNMMOrI+JrY+NFjCXeciC5s/lc42rIYQ08bRfYgeXdhat7c1H7LiPDfqto3SzmDkU1DjZWZXIAO0C4kgZ6kFNIDpoLb9mMBdcDTdeaSF/IbcroGR5oiQX9Jnunp918v5pVShpw3ndHE5EIlv5j7fjO4t+gDI8xVXS64EfkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHK2GBZjxIBpcUpb7u81fMe9MmyURrD6YKNKxg95Hss=;
 b=ORbjtm5EfYGP+zwZK1Ar0lGGZvIvk9M6KzEm+03+qqey6Hh/zQdrX98iSxScaGts1g7jUJ6pZqU2NiMss6/1cjk03ZW2dvLSFbKp69o2AT4WaTjqL10zGVQ18Mrm9DZm1MTxURCb88k+nnFwPos9nLOKC4kb9pj4pGmeOocNcrAisfaks6lURcllLmPsy5FBrLw9ke5GA1r2frykIfZdosh+FXzKV5Ymzgra0pDWQdzMgyN09/Zy0ULUWuS1wTkKl4GksgzIrZ66acAyQPyHMjrGSA5YZDU1sAcutDIlczftQ1x+7yqtdH0KDQa4su2sjgTAmtcK74/bFGdRq/ezBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHK2GBZjxIBpcUpb7u81fMe9MmyURrD6YKNKxg95Hss=;
 b=xTjDXPg7j3npyK9ymdolXT5B9bGecPwowW4UccYiuS2e8ryZkepJYvptn2Y2Ny2R+tTF2iVGMgrzFdSRpwB8c1EOzLB+7B9jgx74JBRGIm/x7jSA4uYXc3YDVe9sPyIrFMfR/6fDqUmbt2/LRtRpSQyCTUsMLl+HbPHShrYcl/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by IA1PR12MB7543.namprd12.prod.outlook.com
 (2603:10b6:208:42d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 18:40:55 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::1370:cd3b:4c30:5a57]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::1370:cd3b:4c30:5a57%7]) with mapi id 15.20.9031.023; Tue, 26 Aug 2025
 18:40:54 +0000
Message-ID: <601a28ca-143c-4821-8c78-9227a17012d5@amd.com>
Date: Tue, 26 Aug 2025 13:40:52 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 08/10] fs/resctrl: Modify rdt_parse_data to pass mode
 and CLOSID
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
 <330b69d50c0161b7ac61986447a9867db7221f93.1754436586.git.babu.moger@amd.com>
 <b08c1d64-8d19-48e7-853a-21947d61ff98@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <b08c1d64-8d19-48e7-853a-21947d61ff98@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0098.namprd07.prod.outlook.com
 (2603:10b6:4:ae::27) To DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: e52cea75-63bf-46c3-8eb7-08dde4d016b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnQyM3ZPQmtPSXBtUWJmZTBjWVNacXU1WjQvRmdGVmNNNjVwa3NvSGk0cVM5?=
 =?utf-8?B?ZXFQRHpFQnNUQml6RUYyamxibWx5UGhranlxMXAvZ3RmUzUwVEV0VHFSY0JQ?=
 =?utf-8?B?eVkrRW5vVmhTN1Z1OEVDVmhHR1Z6U3VsNExkaFROVTJycnlMdlpyc2ZyZXYv?=
 =?utf-8?B?ZDBIWTRuUVhXdUszeHltTCs0SlZtd0dlWlNKNGVpVVM3M0xUWHlZV2NBc29S?=
 =?utf-8?B?ZjIzMlJHblpxVGNNTzJZdGQ4R2hXek1oSUlYcEpwOXg0bXNNRVY5eElzZGwv?=
 =?utf-8?B?akhRM2p4Y3JmOVFKZFZtNWJDQzZ5T21RbmMyYldBeGwzeU5jcGlFb1ZYMWY3?=
 =?utf-8?B?VTYzVXVpcFdJMDd0REJLSDJuZFUwckFCNUloazQ1blJaS2l6WGE5RFhkM29q?=
 =?utf-8?B?aWdIWTJQaTdsMHAvWFJITW5zQU9zS0JNS1EreXlvUG9KWjRhU25naUFvM24y?=
 =?utf-8?B?QmwybkRyS0tUTjdlSzRxc2JKelBkazlBR2ZFVWlBTUNlUk1ocUJVTjlIUnVh?=
 =?utf-8?B?TEVHMXl6QXFWZjRpYXBZSEFSZDBLNGIyK3lHd0grM3BjUmRSYjhaMVJGcWwx?=
 =?utf-8?B?RE9xZitGUkVJL1JKOFJ3V2RtN0k3emRxSTlCVTJkVHJyQVJReVFSbzgzaHFC?=
 =?utf-8?B?Y0NneHg3MTYvT2FoejgrQXBVTlVYNmJtQytOVGlBYzZ6Y3VqMTlkcW5tMkNs?=
 =?utf-8?B?VXVBdFNPR1ladDhSSkR0RmRCVXJyOTZSNkJha1VWa2J6U2RsQWhJbXgzUzY1?=
 =?utf-8?B?UnhvTHhiZ3Noend0K24wU0FVV3RVdmJTMTAwM3p4RHRsaHVYV1JxU29QaUhl?=
 =?utf-8?B?cmJRd2tLc0xrMElLQTMra1o3ZmlobTVseVBCK2ZYMmZzb0FhM0FZVTdvdVJJ?=
 =?utf-8?B?Wnl4UHhKZTFxREF4NjdjV3Z1K0F3ekhraHAvNkF6RTljSmc0Zk9KT0FITnpK?=
 =?utf-8?B?MnQ4VHFldWJxckkvUTBJSlNYalN5Yk1hR0RFZjFOektjdzNVTWMzODJYRkRD?=
 =?utf-8?B?cnpJeHpPUE5CL3lWWEM1Y0tmT1ZxVHovK3c3dlNnZWwyRjB3eUE1R3VuZ2pk?=
 =?utf-8?B?RExSSHN5aDRONmdYd0paZWFlMlNNL2FlUjVaSkliSjVITDFnWTVRWUl0dENj?=
 =?utf-8?B?eFpmT1p6NkpZRDJyQmhwRW9YVVBCS1RBS0VsV1gzaEEvMXNDYmdXYVRSNHow?=
 =?utf-8?B?VFU3RjVpMVJFYmNYQ040NUJ0WmorcGpNU0NGZHNWQmphYWhYQTdQd1kvMm4v?=
 =?utf-8?B?Yk8vYkRrdmdCcWlNRHRhMmNMWDA4WHltU0RncHovbEx3MzRMSWlBT1NmMWVl?=
 =?utf-8?B?NzhVMTQ1UDFjQ1hpWWNwRDdFUk9KeUorMTJJeGhJUlJ1Nnk2RHNsVzJqem9s?=
 =?utf-8?B?U2g2Z0tHRmdjRzJFZEpiQzVwQXkwa0RnbEkxK1pxWVJ2SWRLdXdKTnRpS1px?=
 =?utf-8?B?bWhTN0FnQVZXak1MQkRDTWh0a3RSZjZabUk3dU5sRjBXUkpFNDhuV1V4bkVh?=
 =?utf-8?B?U0gxR1dWa1NWSTlsZkVuTHJQZEczaW1HY1ZIOWYvZnJxbEI1d3NKNVJ0OG5v?=
 =?utf-8?B?dGNrOXpKaU9Jb3hPRW5ISHp6WXhteU1XTnRkamduVWV3R3czQU1naUxuRHhL?=
 =?utf-8?B?ajBDd3ZuZ3JFZUpYUi9LUStUOUtnUDJBdXpLbE52K3B6U3B3cktzbk1WaDRu?=
 =?utf-8?B?MmVmYVNLZis5T3BKUXlIU0xJNU5DMjJmZS9YSUllaEVkSkhvdDZ1N1VNcEoy?=
 =?utf-8?B?Uk83czhmNkhqVGNMU1VEWU1UeHp5UG0wMjhFWm8yZThJa1gxaGxxMWdEdGs4?=
 =?utf-8?B?ZVNPZXRYVFBlMlh1b3doeHAxaXU2RXF1ZTFxaEQvdG9BazVUaWwwUlROVk12?=
 =?utf-8?B?UkZNVzZLSHBCK09QbXpUZkZPRlJZU1YyRXFZY2ZzazJITmgxT3hnT1d0bk44?=
 =?utf-8?Q?tb4G7/3DAtY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVJIaUowK040MU15aHF3U2xtTE51NCs5VkY5Rlc5K0lidnBCanVjWlJSNGMz?=
 =?utf-8?B?ZzJlZGZpU2Q5Um9oSU01M2lRUEFlakRxdDdTclpUK3F4QVJNajFYTm5STU1R?=
 =?utf-8?B?WE5lOTZiNkxKVjZ0dUdpNHZ4dithRzk0b1lmNEJmUEpjTG1BU3J0UWEva3B0?=
 =?utf-8?B?SXNuMzNKeWhhcHNlblpaZ09Eb2oxTFZQNUFTWU1aUnprK1ZzaFNNcFI1Y1NZ?=
 =?utf-8?B?TVRNV0dJLzVUdnZVOFRxc1BucXJoTnRSd25wajB2aHJRZXRUWlVzM2tyOC9N?=
 =?utf-8?B?cFQ4SFVHbHVQN1J2V3p6MERTUHhteDJDS1JXQjlUZUcvRlR5bzRoS0hWQ1l6?=
 =?utf-8?B?NFFnZDJ0VHZvUEh2cEk1OVl5MEVkbWMyT3NWOVJoUzNnVEpESzkvYWZDMGpG?=
 =?utf-8?B?ZVhWVzBQd1Q2cFVPWnFxRWkvWnhubVNFMjNibk51RmhMQlE2T3JES01VSnFB?=
 =?utf-8?B?dTZ6T1lxSmhxeWRCUFhMVE1yN2wxTktVZzBHVm9Ta25mZW1VMFRxWEpNbWNk?=
 =?utf-8?B?MFlYanpNTVg4NGlzZFRxSlNOdVd5R0VIR3FucHpYZFNpRjVOZnZjeDNZanhF?=
 =?utf-8?B?VmhOT2JsUnFHaHpISHMwSEpMSWxHeTdIVGZPcHpheXVxcG5uaWlmbmFUMEFT?=
 =?utf-8?B?dzNvMEJXSHpjSmIwZGR0QmZQNVpTcGpVNUhQTVoyWFJFZGxQdEdwTGwzSWhQ?=
 =?utf-8?B?K2VmQzhZUG5NcGpsRHZZbmRTTlZ1N1FFM015VGtNZzBYL2dHYXFCcDRMaDgw?=
 =?utf-8?B?S1J6eUdaNUs0VmFCaTdodTVrUVNBNldoL2JTb21lMlY1QTZlczlHSTgzQ09D?=
 =?utf-8?B?NlBqWUY5UnlxSUM2YS9tanJVU21GOTZsSlZybFlYK21IcnN6RHBoMmtuNHRh?=
 =?utf-8?B?ZEFWVXlMMzBSc2VYR3NVVmVGTXFlWkl3NXVKb0kvNzgvSThhZW1UV1YzdHpp?=
 =?utf-8?B?SktqdWVUbE5EWHkySGU4SWhUamVZUlR2RS9GbmFrbk9ENS9jYjc0U2ZDcUFo?=
 =?utf-8?B?NXVvV3RBSkF0V3l1UC9LbGhJamtqQ05DRUlXZkJDS01DVUFFOWhOL2ZlalMw?=
 =?utf-8?B?UTY0c3lsQjlpek5zUjR0VG9VeXJtYUljcjgySWFyYXJKUTJqYVEzSSsraERl?=
 =?utf-8?B?QXRqcjRXNENXZi9xSzRVdmIzSFozRmdKMGhlUWhiUzZzREVCVGhFQ2JrN3Bz?=
 =?utf-8?B?cmd0emZUNzBRSnNTdlYxSWwrdEM0V1hBYlYzWDI0SU1YVEs5TlJDWXpwVGxU?=
 =?utf-8?B?SkcrQlRLMCtTVTNGQjFaM0YyVFZCWTl3QjBobmRkTWlMYWZwRnZPMUNnOTZH?=
 =?utf-8?B?ZG42aGo5S3dwTCttanU3WVErM08xQzM1cWVvYi9zaDdXL280dDByajRTMVl0?=
 =?utf-8?B?ZmY5MXlUMjlsQXVxVmsrY0xSUFFESk5XT1B2WUFSczQ4L2RZSUZxWk1WOWkw?=
 =?utf-8?B?ZlgzbnhVUy9jR2VuRU1rUHJtZCtRamk4REl3SGRiZVM3dTh5U2lkL3FQZGF5?=
 =?utf-8?B?Z291Mi92bUxJMzdqVTgzNmxYaDA4c1dVWTB5SWU2dGg0MEI2TW1vbmV3YWV5?=
 =?utf-8?B?UTJCV0p2OVBqaEQvZERoSTNtMlZTUEtKRy9SWm9XRndteTJUbXVya2ZraEZn?=
 =?utf-8?B?MVJ2anFUVUlZUWhDMDZEak1LdUdDWSs2NVZVdWRnalZoamlsdTZOS21TdG14?=
 =?utf-8?B?SFlrY3RReEs4TXBBZEt1SW9vL3pOUGRyWGEyamdjRlQzemtLYWdGNXhCY0k4?=
 =?utf-8?B?b3N0emZKZmlUb05FVWk0czFzbU93bzd1azR0ci9OM2pNbkVPZFBUTWpsUTVS?=
 =?utf-8?B?c1VZTEcwY0JraWFCelZ0NWdKdGFWdS9Wbmg1NUYrZ3VBNndhcDR0cnM1cFlP?=
 =?utf-8?B?NGF4ZmQvRmFVdXltV3RhUStndlpVb01ubzI5RDRnTkJsTEoxNmpaTkRONmZj?=
 =?utf-8?B?Z3Y1MVBlSHA3MmM3eTNPRHY4UElYV0ZJS1BFcHpwenhEUkFScVVxSXBtZGVO?=
 =?utf-8?B?NDdIS0UvRFg2N2t1b201ZHcyR2NvbC9KOXdWY3pYd3lnVVdWT2lZL2QvRCt5?=
 =?utf-8?B?RVVsWWxwT0k3NG5qeTQ4aG9YcjhFeDEwallMbk5Udnk5cFJLdm9OazI3MEpT?=
 =?utf-8?Q?/RY0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52cea75-63bf-46c3-8eb7-08dde4d016b8
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFA3734E4BA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 18:40:54.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dq9ijF+VdpY6y75wyd1XuSMABMU2Y9e/+/Ho/e2rgLb2hllcgI39m7KjpROWuPC1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543

Hi Reinette,

On 8/7/25 20:52, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/5/25 4:30 PM, Babu Moger wrote:
>> parse_cbm() and parse_bw() require mode and CLOSID to validate the Capacity
> 
> Again [1], parse_bw() does not validate any CBMs.

Removed parse_bw() reference.

> 
> To be more specific: "mode" -> "resource group mode"?

Sure.

> 
>> Bit Mask (CBM). It is passed via struct rdtgroup in struct rdt_parse_data.
>>
>> The io_alloc feature also uses CBMs to indicate which portions of cache are
>> allocated for I/O traffic. The CBMs are provided by user space and need to
>> be validated the same as CBMs provided for general (CPU) cache allocation.
>> parse_cbm() cannot be used as-is since io_alloc does not have rdtgroup
>> context.
>>
>> Pass the mode and CLOSID directly to parse_cbm() via struct rdt_parse_data
>> instead of through the rdtgroup struct to facilitate calling parse_cbm() to
>> verify the CBM of the io_alloc feature.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> @@ -156,9 +157,10 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>>  static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>>  		     struct rdt_ctrl_domain *d)
>>  {
>> -	struct rdtgroup *rdtgrp = data->rdtgrp;
>> +	enum rdtgrp_mode mode = data->mode;
>>  	struct resctrl_staged_config *cfg;
>>  	struct rdt_resource *r = s->res;
>> +	u32 closid = data->closid;
>>  	u32 cbm_val;
>>  
>>  	cfg = &d->staged_config[s->conf_type];
>> @@ -171,7 +173,7 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>>  	 * Cannot set up more than one pseudo-locked region in a cache
>>  	 * hierarchy.
>>  	 */
>> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
>> +	if (mode == RDT_MODE_PSEUDO_LOCKSETUP &&
>>  	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
>>  		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
>>  		return -EINVAL;
>> @@ -180,8 +182,8 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>>  	if (!cbm_validate(data->buf, &cbm_val, r))
>>  		return -EINVAL;
>>  
>> -	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
>> -	     rdtgrp->mode == RDT_MODE_SHAREABLE) &&
>> +	if ((mode == RDT_MODE_EXCLUSIVE ||
>> +	     mode == RDT_MODE_SHAREABLE) &&
> 
> This can now be on one line?

Sure.

> 
>>  	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
>>  		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
>>  		return -EINVAL;
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/798ba4db-3ac2-44a9-9e0d-e9cbb0dbff45@intel.com/
> 

-- 
Thanks
Babu Moger


