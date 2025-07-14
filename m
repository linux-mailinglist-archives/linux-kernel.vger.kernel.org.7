Return-Path: <linux-kernel+bounces-730123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD33B04077
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1C41666B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ABD25393E;
	Mon, 14 Jul 2025 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eX/gHLyD"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A830253356
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500593; cv=fail; b=s01wbBtAN2BusPSi0U0tKxSNOmpOoFIiU2XU57IPcOVYA8YI4VDj5QvUthuKo5yYbkdErERvOBp2pWwtDCwU53WGwle/lDN7vxhG/9/uIZJ19s5w7PEIGE/KblrtJQh8xQStE89sLy8jeNgHfWepHuPS9ZKex1UxH32ez1sg0Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500593; c=relaxed/simple;
	bh=662Ld/Tkk9l7Hla/ZQNhy26jVjPFubTYAufdwG7J4TM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YhM+hlbUq+RdkTg5EgWhjNz2aT7UMuBDE9LTq34hDvzH4CEcdL4Ia5lEVwj/BNAcakC+cLkfTH4rrNifeVCxTWpykQShm38ipjedjIgzuTpOvnbAj3FS0acmrXgagbrSFarX5xVc8Y17ZkGqe2A4DMMuvqe1LdPlwK9dSWO21NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eX/gHLyD; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9RwR+eAcDIU1rjSJRKQsGbEpJI3TqchZokFn2qNXYiyqg14DMSBNiLjy+RYYNb080aQ8P6o+Os02b/9RHimP3ZLFSSeJfgwY3A7LGcf0xz6f3sD7KG5kEJzbq2gpOQvYwTBspY+lEoloMEL/9sGVxXIHPldDhKvtNyOTGYDevM826vjnGEFthOFoZM3AIEBTyukd4YAMV/lpUtyJwEwzkegoe0Jt6kx95FycybJaJ+jLzy3IM10Lyxd4Y+L3fVo5qaxF5oOpwS9zjpGAk2ajy8Q6c5/lQ57oHB4SZW4TLaaEbErpl9lD3PlZhwuvaz/tmvlr9L5n+ovmdlzTg993Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10fBx6KJ5HWkwonAv0CrbdRn3WvYFt0ZJj8CRAl/hBw=;
 b=OSW4x21wu5m9DwnWDKArhOsmm5PzugzWhhMgUKoczAy8allyCKJTfHN2eQCWoqo87b4riYVxh/ZfvQJZ2r2Fxmt+d44OxNQ1BIfdvECrfWRNI9WYKDJEs8lHaXPUyzg+x/jKqV9BGzcd/xTm0q296HmS0ompuTzwU3Sw5sjawmKRCAOrXusX434zJwRMt5lDEflntdfX2Y4Z3gLsHKs7ZFNAhl4xTSfr7bGoF7SpvF/3/vcMeLi69lQkViD55O6XHELGR3Jb85NbvJojThTq8y+2QkbN9fbt1lWtLcMvZps65RaBKWFsPqgfSeVYx+vV5PLugN6Fb00ymDyifyC1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10fBx6KJ5HWkwonAv0CrbdRn3WvYFt0ZJj8CRAl/hBw=;
 b=eX/gHLyD1cvjh0lRD+1N8+N+B1gar+wLuBZW4OSuvSGzUHWc3i2RlrBsXvw9rCJSr2JSTeKbc9b8p+x3wiFZ8wXMlJD5U3R3G4nUNMt/l7/Ff4SlPx+MoTMuX13Uw+KeZnSYZMAmo90koAud/CaeWQeLxqDd+hmpu2QavaxpyuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by DS0PR12MB8343.namprd12.prod.outlook.com
 (2603:10b6:8:fd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 13:43:08 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Mon, 14 Jul 2025
 13:43:08 +0000
Message-ID: <25734c2a-d79a-4a16-8ec4-0b6e1b7a59b5@amd.com>
Date: Mon, 14 Jul 2025 19:13:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/util: introduce snapshot_page()
To: Luiz Capitulino <luizcap@redhat.com>, david@redhat.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, sj@kernel.org
References: <cover.1751914235.git.luizcap@redhat.com>
 <88d956248f7528b7998ef00ca8742061839d1036.1751914235.git.luizcap@redhat.com>
 <3942336d-20e6-457d-8b53-e198eed5d9d9@amd.com>
 <60a1a526-52dd-478a-9ed4-79e6428743ac@redhat.com>
 <017e17e9-c9d7-4dc2-90bc-0ef06289007c@redhat.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <017e17e9-c9d7-4dc2-90bc-0ef06289007c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0053.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::7) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|DS0PR12MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fb95be-fb9d-4b9c-bd83-08ddc2dc5db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWpiNENNY3lmY2w2eDRBdEpOdkYxMTZXTmpvQjhLSnZ0OFg0aTIrQTBZZ0NQ?=
 =?utf-8?B?V0lMM0I1L0N4V0o1dVJ1NGtjbmorcUZJK2hEZHdNVE5acXZ0K2ZmZVBRcjNC?=
 =?utf-8?B?SGl0ZnNYSStMemo1ZTBFdjUyTWtZT0E2ck4xRGR3RXZ1Ung5R0h0MjFiREh2?=
 =?utf-8?B?MG5SRG5WbU9pUjExeGNvczZMaFVqRVh4b002U04xVWZZdXZnUm93RnRwcXVI?=
 =?utf-8?B?OHJ5VkkrbENvTWxPa0RTYTI5aGc1eWgySXhpRUtZWnRCL3FvYmhOUVZrOTAz?=
 =?utf-8?B?elpqUENMaHNsUGRoZCtmNVdXZGdlLzZmdGJlbCtPLzdYdS9tNGc4NkhhQmFD?=
 =?utf-8?B?a1E2KzlMYmV6b1YxTUZqTDJIUGhobjVFN21KZ255RnRTWktyVlcvOVdUMXlr?=
 =?utf-8?B?T3Z5ZjVQV3J6c1N2WVdOVzBxU1Q5T20vRDVTanJsdWRBSlNScVJvc3MrQUxF?=
 =?utf-8?B?b1c4NXRJTk5LOHowdmJ3VFVDUUd0M2I3TWQrUDE4ZU5qampmZVBTRjh5NHhn?=
 =?utf-8?B?SDJxVEpXKytERUI1ZCs1endCdHo4cTlJOGZXOFdLakRiaUtsYlV5NHdXNmZv?=
 =?utf-8?B?YWdRMUhpSEVkWno2VzJCT1UvdTNMditvd08wZ3hNSXU5a283N0xRQTg4bGtW?=
 =?utf-8?B?dVBkQVVRaThVL3U0cWNXYndJQUlqZUtYNUhWVTZtTlBtWEhQWkFmbEJzd0pu?=
 =?utf-8?B?NXQ2YkNGcFYwcmkxaGdpN2xzMUN6bTJSbWVsczZSZVJtYmhJQ1g0eGZYWTkr?=
 =?utf-8?B?clFKb1FFdllhUHBLQTJmK2RiRFAzM1QrYW9ZblNuVzNFeWg4VUJtTjFJdFZ0?=
 =?utf-8?B?MUF4SnI3NGorbmk4WGszMU5PSzJCMlhmNThrM0xYaGY0K25EWmE5ZnptYXVt?=
 =?utf-8?B?RSswTGtJaDlvVWFEMk0zMERocU03SkpRS2pHME5hZjBZNjJ5NFNkYVBkNjZj?=
 =?utf-8?B?akE1bXQ0V0pPYmdEWWxqVWR3VHltalhjWmhYMU9yWmxzSlNWR05oZnB5M1Vx?=
 =?utf-8?B?MmN3RFhXRmJCb2d1UFR0dEg2NFo0ZnFiYk1LRklzWnB2S3Y4ZjdtWXNXK1Ux?=
 =?utf-8?B?YVhmc0Q5RlFOdmtEekJ2bGZ1WkpMSUNnS0N1NnFpa0xBRE16dzJTbTJpaU8z?=
 =?utf-8?B?RU50akQxc1pUMVpKOUowKzBQbVp3VTlsK1NqL0oxTlA5cWtwMkRQNXVxcjNj?=
 =?utf-8?B?eUxNSnRtMmk4SVdnbFhwNGNOZDFjMWJ3QWt0L2JLRlhVZlF3dHRJbGNxaXA3?=
 =?utf-8?B?SUdlaUNDb2VMdlhYV0JrMmc2R0JxLzVMU3VxYWJGS3VyZWY2U0Fwb1ZPR0VN?=
 =?utf-8?B?SEREV1BrY2dPZHkwUHJTRHNiUmVEb2NOZGtwVldUZElROXo1ckVWWmlKV2FI?=
 =?utf-8?B?c3I4c1lnWXlRSkRxOWwzOTZ1ZTZ4TWJNLzJkOEZJb1p3aithcC9OamVCSEtt?=
 =?utf-8?B?MHpWb2o1WnFMVEttcEg1dzluT0txeXJMMnRGT0dBN3NpSUZxWmN1QWh2eTVq?=
 =?utf-8?B?c3dMSHNDRGtqejVXalowK0szU1MyQnlBUlFXeWdGdmxFR091YTF2aElSUGdx?=
 =?utf-8?B?eEFwLzhYaHJwTVl1NFppcVQvSHRIbkl6cnRRU3M4ZExMR0o5bXhNWlp2WUpp?=
 =?utf-8?B?bnhnbStmMXZXc2lSSS9xUW9xQUZWVENBUm1ZOTlnQzFSc21hR3dSMHBheXRX?=
 =?utf-8?B?RXhkVWtjeG82d29nc05tcnhCaVZqRE9kVFpuaW5JRkN2a3VNTmU2RDIxUmZt?=
 =?utf-8?B?ZFFNb2VZTDVHYk9iakNNd000ZHNTeGZtMkZqYUdMaHg5bmdxZ2M4N2FpVVNq?=
 =?utf-8?B?S3RZK3dHa1ZwUTloU0pIQyt6Ym5GUWF5MURxb1pESEtXaW5HNkcrUndQTW8y?=
 =?utf-8?B?aE5tR1JOemM5SnJxU083bHhsSkhxT2k2ejMxNEVSRU1wL0YybVAvOTZKMW84?=
 =?utf-8?Q?L267ZkziLuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlR2ZENqRVlPZWQrYmpLZGc4Z1FQL2VFTmF3c3dXNGtXZW5ibXdnM3pTR2Ny?=
 =?utf-8?B?Mkx2cW5nbTBQMVF5SEFPR09qdFh4UURHalZnUmNXZG1WTE1TWVVodjlWdDFT?=
 =?utf-8?B?ek4zUlJ2SWtlVDdGVlhxME02TDlpdTA1enNRd3FPclRpcGdYN1BTdjlWVkFS?=
 =?utf-8?B?L1ZieG90d01EZjdDZkxhK2VVY084cW1HeGZhbE5JL2VZb3QycmM2am1kTmpJ?=
 =?utf-8?B?V2ZRN05aOWFSTFJOeWJHM3cyeXdtMnBiZFJGNEVvZFdMbU1Ta25MTXNrTk5y?=
 =?utf-8?B?QzliYXVSMjZXbGlUSUpHUUNvczFkSUNiQ1BEWEVkdW1WcHpkNXBxaFVHU0lH?=
 =?utf-8?B?MGNMMUdMQW9ndko2blF3RVBTdjE3S1FEL0JuNlg0bnR5Q0xzUlBTTHJvd3ow?=
 =?utf-8?B?LzFXRGY1ZEpwNGxuS3NTZ3AvUDZqdjMyUElQVlZYQUROS2taUGo0VE1pQ3Uy?=
 =?utf-8?B?cUZkYVpZNG5QdmlLbDVuckRTWXFVcWhtV1pBMlBHRVNscGcvdnAvemVpcVEr?=
 =?utf-8?B?d21DSTQ0QW9sdU04MTVYNXhML0xtclZwbWIxa3JJWEZjclB5YVNsaWw5TFVE?=
 =?utf-8?B?MFNGZzY4MmcrZGh2Vnc2Uk9VTjlxdHBpTHNTUG52cVdNZThXQ1ZCaDR3OGFK?=
 =?utf-8?B?N1NvUFM2TkZNREJjcC9XeUh5VC8yZUhwTVJ6dThEUUUwVitDNEIxamd4d2k5?=
 =?utf-8?B?RG91MGNEdE14VTJpRU1Ka2gxMXRUSE9TaDdxUi85bjRycWE1REpIZ2JibmV6?=
 =?utf-8?B?VDVqM0ZDZnMxNy9YWmQ4YjlLV09IYXU3Vm41NGFNRjBCdmQ3WVlpSnpyeEtq?=
 =?utf-8?B?WGFZV2ttNDdOWm40cHUrMW9MQzZmUG9sS0hYbDNDK0dZUlFzT1QweWFyUkx4?=
 =?utf-8?B?cXh1Wm14WHFVZ2JGYjVxKzJMNDQxaTIvZzdaWXN6RTRzMWtZQ1FaWTM4UkxL?=
 =?utf-8?B?OUFRZmFMMHZESkNDRmhTMDBiUk9kNVVMNlh5NDB5SVlhcHhsTkVVT1ZDU1lQ?=
 =?utf-8?B?a09EeHh6elVzanFsN091SmJGRHMvbWNLQnJBd3BHM2dzc1ZrRC9wc1BKMjJ5?=
 =?utf-8?B?cDN4dkNCTDAzdU82enVlNk9GY3ZpVWhtWHREbDhUQ3ljSDYrYUNxN3g4dmRD?=
 =?utf-8?B?TlJwVnYwNVR0QTkyVFU5TTl0RmdOVTVLd1dVSkVMV1dBL0Y5UGR3Z1VVSmsz?=
 =?utf-8?B?OWpvcVRTM211cGpDbnRlTEFsbGlROTZSci9SRnJnbVVPZFJkc1M4WGUwYjhB?=
 =?utf-8?B?SEhqVUVyRjlxbWIvZDJrUDNYcVJrdTRPa2lOSklZZWxQU0pUWFcrWS9QNjRV?=
 =?utf-8?B?SysxSGwrMlFtU25WTlkvcTJYVDNIRVdrWlBqUHpMV0FlaHZVcGRPSXhvNE12?=
 =?utf-8?B?TmpxQ3BRanBUYmp2SXNWNnF2cG5PRzVkcXJTWVI2UlIyeUJKVTMzVE9rV2NX?=
 =?utf-8?B?UUZ3Rm9NL0lYZzFQWnk1K2pFWS9ralZjRU9LVlFyMlZNVTFuYXF4OC9nRnpG?=
 =?utf-8?B?OUMveDVtTjlmdUhsM2hMam5HNXc1MDM1SWJYWkU1d3FNVW5ickdVZFJxVisy?=
 =?utf-8?B?dVk2L0dXWkFPUFkzMlNiUVVjcCtTblI5YnVaR0xhUXFCQ3BsNXEvZ0FMS2t5?=
 =?utf-8?B?RTlkUTVBQi9PZ1BaREttWjM1VUs5Z3c0bVVJSHNOYXNhTTR4bmFDTDdCeWE5?=
 =?utf-8?B?RmZPN2VRcmIxcWRLU2Z4MnZKVkZ4TDMvUC91aHlTalZDcHhvQ1pIZ01HMEVL?=
 =?utf-8?B?ZzU4YXVvb3lyYlpNMFpCTURZTkF3UnRhTDB6QVpwZGU2T09wQkVpQjdzdTFL?=
 =?utf-8?B?NzlIaExhYjR5Rm0vQ1pmL2R6c0FMKzRIUWZKdm9qVFQwNVZPd3pxb3Z1b0JE?=
 =?utf-8?B?UTlPcGNTQmZxYzI1WWdsUUMxOEhqUEdMZmU4YitEYW1nVXJkblI0ZENNM1p0?=
 =?utf-8?B?LzJ3WGpMamk3UHhHOHViQUo2YWhvMkwvR3c0Y0dWOUtEZmdmcHFscjZyMHBH?=
 =?utf-8?B?cFhQKzltOVh4WkZISDNDN09YMjR1UUpNWkNRQVJzM0x5dmdGcmw4TjMvWVB2?=
 =?utf-8?B?djVOZ24va0NMZldrd0x3RG1DVkhyVlh4VDhqTHJoWHNPc285YUJLUkRzQ0tm?=
 =?utf-8?Q?YNyXoX15cTR7JSfBFvogyT5jZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fb95be-fb9d-4b9c-bd83-08ddc2dc5db6
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:43:08.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvUUZKVBYbBvTD/ne28c35WPNxYPbO1w0jg2NWLqTCgTZcLWhtoEQTqVNAVMemINHJ0T9iN5UT8orN/xQowmcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8343



On 7/14/2025 6:46 PM, Luiz Capitulino wrote:
> On 2025-07-08 12:59, Luiz Capitulino wrote:
>> On 2025-07-08 01:49, Shivank Garg wrote:
>>>
>>>
>>> On 7/8/2025 12:20 AM, Luiz Capitulino wrote:
>>>> This commit refactors __dump_page() into snapshot_page().
>>>>
>>>> snapshot_page() tries to take a faithful snapshot of a page and its
>>>> folio representation. The snapshot is returned in the struct
>>>> page_snapshot parameter along with additional flags that are best
>>>> retrieved at snapshot creation time to reduce race windows.
>>>>
>>>> This function is intended to be used by callers that need a stable
>>>> representation of a struct page and struct folio so that pointers
>>>> or page information doesn't change while working on a page.
>>>>
>>>> The idea and original implementation of snapshot_page() comes from
>>>> Matthew Wilcox with suggestions for improvements from David Hildenbrand.
>>>> All bugs and misconceptions are mine.
>>>>
>>>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>>>> ---
>>>>   include/linux/mm.h | 19 ++++++++++++
>>>>   mm/debug.c         | 42 +++----------------------
>>>>   mm/util.c          | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 100 insertions(+), 38 deletions(-)
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index 0ef2ba0c667a..090968c6eebb 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -4184,4 +4184,23 @@ static inline bool page_pool_page_is_pp(struct page *page)
>>>>   }
>>>>   #endif
>>>> +#define PAGE_SNAPSHOT_FAITHFUL     (1 << 0)
>>>> +#define PAGE_SNAPSHOT_PG_FREE      (1 << 1)
>>>> +#define PAGE_SNAPSHOT_PG_IDLE      (1 << 2)
>>>> +
>>>> +struct page_snapshot {
>>>> +    struct folio folio_snapshot;
>>>> +    struct page page_snapshot;
>>>> +    unsigned long pfn;
>>>> +    unsigned long idx;
>>>> +    unsigned long flags;
>>>> +};
>>>> +
>>>> +static inline bool snapshot_page_is_faithful(const struct page_snapshot *ps)
>>>> +{
>>>> +    return ps->flags & PAGE_SNAPSHOT_FAITHFUL;
>>>> +}
>>>> +
>>>> +void snapshot_page(struct page_snapshot *ps, const struct page *page);
>>>> +
>>>>   #endif /* _LINUX_MM_H */
>>>> diff --git a/mm/debug.c b/mm/debug.c
>>>> index 907382257062..7349330ea506 100644
>>>> --- a/mm/debug.c
>>>> +++ b/mm/debug.c
>>>> @@ -129,47 +129,13 @@ static void __dump_folio(struct folio *folio, struct page *page,
>>>>   static void __dump_page(const struct page *page)
>>>>   {
>>>> -    struct folio *foliop, folio;
>>>> -    struct page precise;
>>>> -    unsigned long head;
>>>> -    unsigned long pfn = page_to_pfn(page);
>>>> -    unsigned long idx, nr_pages = 1;
>>>> -    int loops = 5;
>>>> -
>>>> -again:
>>>> -    memcpy(&precise, page, sizeof(*page));
>>>> -    head = precise.compound_head;
>>>> -    if ((head & 1) == 0) {
>>>> -        foliop = (struct folio *)&precise;
>>>> -        idx = 0;
>>>> -        if (!folio_test_large(foliop))
>>>> -            goto dump;
>>>> -        foliop = (struct folio *)page;
>>>> -    } else {
>>>> -        foliop = (struct folio *)(head - 1);
>>>> -        idx = folio_page_idx(foliop, page);
>>>> -    }
>>>> +    struct page_snapshot ps;
>>>> -    if (idx < MAX_FOLIO_NR_PAGES) {
>>>> -        memcpy(&folio, foliop, 2 * sizeof(struct page));
>>>> -        nr_pages = folio_nr_pages(&folio);
>>>> -        if (nr_pages > 1)
>>>> -            memcpy(&folio.__page_2, &foliop->__page_2,
>>>> -                   sizeof(struct page));
>>>> -        foliop = &folio;
>>>> -    }
>>>> -
>>>> -    if (idx > nr_pages) {
>>>> -        if (loops-- > 0)
>>>> -            goto again;
>>>> +    snapshot_page(&ps, page);
>>>> +    if (!snapshot_page_is_faithful(&ps))
>>>>           pr_warn("page does not match folio\n");
>>>> -        precise.compound_head &= ~1UL;
>>>> -        foliop = (struct folio *)&precise;
>>>> -        idx = 0;
>>>> -    }
>>>> -dump:
>>>> -    __dump_folio(foliop, &precise, pfn, idx);
>>>> +    __dump_folio(&ps.folio_snapshot, &ps.page_snapshot, ps.pfn, ps.idx);
>>>>   }
>>>>   void dump_page(const struct page *page, const char *reason)
>>>> diff --git a/mm/util.c b/mm/util.c
>>>> index 0b270c43d7d1..c38d213be83f 100644
>>>> --- a/mm/util.c
>>>> +++ b/mm/util.c
>>>> @@ -25,6 +25,7 @@
>>>>   #include <linux/sizes.h>
>>>>   #include <linux/compat.h>
>>>>   #include <linux/fsnotify.h>
>>>> +#include <linux/page_idle.h>
>>>>   #include <linux/uaccess.h>
>>>> @@ -1171,3 +1172,79 @@ int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
>>>>       return 0;
>>>>   }
>>>>   EXPORT_SYMBOL(compat_vma_mmap_prepare);
>>>> +
>>>> +static void set_flags(struct page_snapshot *ps, const struct folio *folio,
>>>> +              const struct page *page)
>>>> +{
>>>> +    /*
>>>> +     * Caveats on high order pages: PG_buddy and PG_slab will only be set
>>>> +     * on the head page.
>>>> +     */
>>>> +    if (PageBuddy(page))
>>>> +        ps->flags |= PAGE_SNAPSHOT_PG_FREE;
>>>> +    else if (page_count(page) == 0 && is_free_buddy_page(page))
>>>> +        ps->flags |= PAGE_SNAPSHOT_PG_FREE;
>>>> +
>>>> +    if (folio_test_idle(folio))
>>>> +        ps->flags |= PAGE_SNAPSHOT_PG_IDLE;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Create a snapshot of a page and store its struct page and struct folio
>>>> + * representations in a struct page_snapshot.
>>>> + *
>>>> + * @ps: struct page_snapshot to store the page snapshot
>>>> + * @page: the page we want to snapshot
>>>> + *
>>>> + * Note that creating a faithful snapshot of a page may fail if the page
>>>> + * compound keeps changing (eg. due to folio split). In this case we set
>>>> + * ps->faithful to false and the snapshot will assume that @page refers
>>>> + * to a single page.
>>>> + */
>>>> +void snapshot_page(struct page_snapshot *ps, const struct page *page)
>>>> +{
>>>> +    unsigned long head, nr_pages = 1;
>>>> +    struct folio *foliop, folio;
>>>> +    int loops = 5;
>>>> +
>>>> +    ps->pfn = page_to_pfn(page);
>>>> +    ps->flags = PAGE_SNAPSHOT_FAITHFUL;
>>>> +
>>>> +again:
>>>> +    memcpy(&ps->page_snapshot, page, sizeof(*page));
>>>> +    head = ps->page_snapshot.compound_head;
>>>> +    if ((head & 1) == 0) {
>>>> +        foliop = (struct folio *)&ps->page_snapshot;
>>>> +        ps->idx = 0;
>>>> +        if (!folio_test_large(foliop)) {
>>>> +            set_flags(ps, page_folio(page), page);
>>>> +            goto out;
>>>> +        }
>>>> +        foliop = (struct folio *)page;
>>>> +    } else {
>>>> +        foliop = (struct folio *)(page->compound_head - 1);
>>>                       ^^^^
>>> should we use ps->page_snapshot here?
>>> IIUC, page may change due to race.
>>
>> You're right the race exists, but we can't make foliop point to the
>> snapshot because we do pointer arithmetic and other operations that need
>> the real page memory address to work properly.
> 
> While working on v3 I realized it should be fine (and correct) to use
> the head pointer from ps->page_snapshot like the original __dump_page()
> does (assuming this is what you meant for me to change). So, I changed
> this for v3.
> 
Yes, that's what I meant.
Thanks for updating it.

>>
>>>> +        ps->idx = folio_page_idx(foliop, page);
>>>> +    }
>>>> +
>>>> +    if (ps->idx < MAX_FOLIO_NR_PAGES) {
>>>> +        memcpy(&folio, foliop, 2 * sizeof(struct page));
>>>> +        nr_pages = folio_nr_pages(&folio);
>>>> +        if (nr_pages > 1)
>>>> +            memcpy(&folio.__page_2, &foliop->__page_2,
>>>> +                   sizeof(struct page));
>>>> +        set_flags(ps, foliop, page);
>>>> +        foliop = &folio;
>>>> +    }
>>>> +
>>>> +    if (ps->idx > nr_pages) {
>>>> +        if (loops-- > 0)
>>>> +            goto again;
>>>> +        ps->page_snapshot.compound_head &= ~1UL;
>>>
>>> Should we use clear_compound_head() for clarity?
>>
>> Yes, we can do that.
>>
>> Andrew, since you applied this series already, can you squash the change
>> below into this patch? If not, I can send v3.
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index c38d213be83f..ce4200529772 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -1239,7 +1239,7 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
>>       if (ps->idx > nr_pages) {
>>           if (loops-- > 0)
>>               goto again;
>> -        ps->page_snapshot.compound_head &= ~1UL;
>> +        clear_compound_head(&ps->page_snapshot);
>>           foliop = (struct folio *)&ps->page_snapshot;
>>           ps->flags = 0;
>>           ps->idx = 0;
> 


