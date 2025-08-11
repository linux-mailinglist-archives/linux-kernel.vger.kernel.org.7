Return-Path: <linux-kernel+bounces-763734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D330AB21982
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 01:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A083B6A17
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B221826E6E7;
	Mon, 11 Aug 2025 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T9yjJ0T1"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1825B1CE;
	Mon, 11 Aug 2025 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754955768; cv=fail; b=VK37scBJrPWjGoCsmJyX6UMR9hsK0o0S3wdI7ylmKrnv7FTOh8JvIvM1BmX9oRg9EIHTgFlON4e4ct7HqEUgNxkiikTlDvr4VvgLXsum3aqWc4cJkWc9PT7o9VVefwQEApXuJStGzU5Ta1B6d3X6TRPpYscTKU82upCCVvdxXQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754955768; c=relaxed/simple;
	bh=civkQiqmLMn1NLK4FUengTXHEyu5sGbzLmrLVFC1jzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tK64U68k5DtGLwq8QJczd3PTRc4wi6Rn37PDo6pAb8HRabnepMFEarz9nLbZ2Txbor6CiYlTtWUJpDCg026r0qrVRU3XLmbwQOH5ZrnfUH/DHNF9le4XOUQYighxq8to0M0htiAg7fTvNBZX31jV5Rb+uavEh9YRNgJ0lglQ8NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T9yjJ0T1; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETi/IaCdZjJOgMEZDbSGJFY69rtDI8vx2yetUK7MolzZSzEo3UkMRGGfZkI5RFCX81xM5yj/HzCmFVoa8w44ucjlYS0VZ313HRLZaAQNElBUJoyb692i/Uxkwvbi+bhrMDxMIOFcJoSI0vdRZXGrlU13zqwhdRk8ZUulqpwbD8lfPOQxCcFAx3PfsvICnOjam2cWDJLZkqFt2y5oOemw8aK7IK84zv6cqw2gLzBBsobJzRlbCZvHwNOcy0zSf2AWfmwE5jzzlEqRNnMchya79YvvMueTLph6eEyRm/uBPXxl6wKy1Y1izEi7xrMhZ2spVs0xLspKacUOBFyGThN6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jFzONxasbn35k0Vrrltwrb1+UJjgDuB+VTs8Oc5src=;
 b=RerXX6mj4DNwUaD91uddW+/qjcSCIZTwJbUGYILb1VDmVU7lySh9I7lrDmN1V1UYhCYFfjCNMT8G6pb3RMKFlcFQbotIQQvwDqFEvWdMSei/njsyiba09G3ktO00C1ZXNhaRm8zOWXQE6NLyuAUDgnYGDLwv44oZPQVxPbhewSReAEzlqXks9fcyb/Y6bXjd3LS6meAFP5+2qyhRYfzt1IxuppDAC1Krf6F9zHbHluU2Zf11cbWAK6x3WXmh4DT6QoUgKMEJsaKbCaBEn4Jcuay/8dl9ROd7yDi5K7JPaIjdgTLlW9ljEpwrm4RHfe/Abf5zqweZczihe2k/KWyruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jFzONxasbn35k0Vrrltwrb1+UJjgDuB+VTs8Oc5src=;
 b=T9yjJ0T15/8P8x/9fFwjJEKZxcvR9lYLzx2xrZmx2Fdj4wEXTTLck0p+6LDazd5dJOENuA6UUP8nYpenw+eE1JWjmli9ZFd3f3mq4UBxQRjSMIy89yFHZpTGDuc8OZbgr7ArZAuJiQrYFrpj6NfwYsCsCaOZhKkS2dI52ItgQFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SN7PR12MB7300.namprd12.prod.outlook.com
 (2603:10b6:806:298::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 23:42:44 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Mon, 11 Aug 2025
 23:42:44 +0000
Message-ID: <a98edca8-9f14-4f90-9e49-01d07fea2d58@amd.com>
Date: Mon, 11 Aug 2025 18:42:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 29/34] fs/resctrl: Introduce mbm_L3_assignments to
 list assignments in a group
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
 <1a031e141affd6dfb8693de5a0bda83f3cf4a330.1753467772.git.babu.moger@amd.com>
 <68bd82ec-854f-4325-a892-5deae2fa7720@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <68bd82ec-854f-4325-a892-5deae2fa7720@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0053.namprd12.prod.outlook.com
 (2603:10b6:802:20::24) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8c9240-9a87-46f6-e502-08ddd930c521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXowRnlsRTMzUHZYVVFrVHIxdmxmWGVLL3Bubkx6OVNtdW53NEZnZUlsR1RU?=
 =?utf-8?B?MjUrT01kMG83LzhXOGNYR1Y4bzZWVDNJaVVKaXRFc1dSRE9JclNGSTJBQ2Ny?=
 =?utf-8?B?czlKaTU0dmRmZnRLRnJSRG1UcXNzRzVTVjkrV1AreVhRK1J5TWZUVFp0c0wz?=
 =?utf-8?B?VDBFZjk2YW8xWGVyWjZESmtLb3FXWEt2WVA3bXBKTE16bW1oQjJiOW5nYjR5?=
 =?utf-8?B?cmZvaHpVek1PYjJHSFFxclhqUXRRSUNKKzZaNjA2Qy90TlM4Y3JtWkc3RTlk?=
 =?utf-8?B?V2VHak9nNkxTNFZIN0dXUUpKbStFdFhRTStuY1ZSSUxWVUd4Wk1YOVFKbjBK?=
 =?utf-8?B?TExHV0lKbzJCeGM5WEFPQlB6aXBrc3F5a2gwM3oxWlF3d1loaG1QcFM3V1or?=
 =?utf-8?B?MDBSWTZLUjM4elcwMjJRb3poc1VDK21tR29td1pSNWZ5Vmc0QjNsbVZqMkRE?=
 =?utf-8?B?ZC9pa2VvRHoyNXFFK1BKSWZWT0lTZ2xkT0RPWDJMV0tqWS9WdGhJSFhXN1RS?=
 =?utf-8?B?MllNWFpwUmlicFJBUXlsWnROcmlBbE5UZkY0RFF4ODRlTER1djFhNVJlV01Z?=
 =?utf-8?B?c2hzY3RwbkhhZTl0VDRsUkJTMU5Qa0UyVHR6Wk9YendlUWIrR2Rtb1AyaWk5?=
 =?utf-8?B?dVFkTkNNQkNYRzBXRE5ZNkJYRE9GaGlCVTVYOWdUWDJWaXhkM2V3dk9hcFBQ?=
 =?utf-8?B?QkhSUzR1cmhOMWQva0hHTzBkMDZCQW1hWjhyVXd1bWt2am00UWZpT0EzbDFx?=
 =?utf-8?B?djVjYkRPWFMvY1RCcW85c0tWdGtZeFFZaDUwK3VTcDRLNmpFbVBTMXZIbUZV?=
 =?utf-8?B?OGdrSUh4L3c4ZVZESk5WVW1wU2RLbjl1ZVZUSlVPRXJNZVVPS0tqQzIvU0dm?=
 =?utf-8?B?d2JnZVpZalB0aExDZ2RFSTdneHpKYWlUcGxKaUZsQzQ2MW53UUl4ZHJKTWh2?=
 =?utf-8?B?dE5sL0xrYWtjOVhWbENFdG9vMlJnSUR3MHV5KyttYU8xcWIyV2VFNlJiczVE?=
 =?utf-8?B?b1VwdU1qU0tmNGZvRTk1cWY4UC9FYUEyOUNqK1BmTXZ0WWJUaytUbzNvUkJ2?=
 =?utf-8?B?dVJ2QUZRYUlXL05xOXFyQmRIemdNVEF5NHM0aTVFVEtsempSSU5nSng5eFB5?=
 =?utf-8?B?dThFZXQ5d1hwQU1BdjRpUlFFQytrZWJYTjRwVDAxUGN2eWQ0bGJRN3AyTHB3?=
 =?utf-8?B?VXVHNzVpa2NuVGlIVWJaNUd2c2YyOGN4MHcwVGVqVHJYSnZzNjhKTXg3VmlV?=
 =?utf-8?B?MzgyOHk5dzRKSHNBZUkvUG9paWRHY0xHWmFQMlBPSUJlaWYvOWI1QTk3NzVq?=
 =?utf-8?B?YU04TnJmV1BEVC9tRG9Pb1ByYVc3aVYwKzlKM3RmaGdpM0lnbU5QYUticnRl?=
 =?utf-8?B?c1lMK2tJVlBIR1ZZWWJYRG1BVVo1OWJJNU9ONSt3aVI4TERPWmhxVnFib0ds?=
 =?utf-8?B?cVZDbVBqemkvczZHbTFnc0lQckVUNnMwNUZpRUlZSndrbTAwVUYyc1ErVFpK?=
 =?utf-8?B?S0VqN1c1SDdDMVpFMXUyODRJR0hLd0xrQ0xpUnphSm5ScVVwZmZLYTZmaURJ?=
 =?utf-8?B?aGxpMGNzUXpwSm1yb2xsUnJzUDFnVGk3bUxQaXpJRDBoNTE0emJPOHNiSjh1?=
 =?utf-8?B?VkRwRU9LQUFseW16cnkxaS9qSCt1KytacjNzeXYxZUo3U0U3R01Za3dmRHQv?=
 =?utf-8?B?OGk5N3BYbmhNNWlDSndNbk9UMXFkYjVXdUVSUHlMQXYvTnQzZFdnZlZYakdJ?=
 =?utf-8?B?Wm5meHlDeWk1SUYwQlNiRmxpc0VkalpyVjA5N0lLTWs0U2hzblFxT3FnclVR?=
 =?utf-8?B?SEY3M0dLb0Y4bmFwWlNWTmUyaDhBKy9VWkE1djlIZTE0VVlmVStaajRaRHFw?=
 =?utf-8?B?L3U1dlFPMVRDVEhienExTnNRWGR1RTFoVDhtM1F5WGRWRkg3aU5zQ05mVGd6?=
 =?utf-8?Q?Hx1OztdeiE8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFgwSHdvbWpySUZOUndZbWZLcFhOR2JSdTUxT1d6N0U5UnRBTHMxL1RKdjhC?=
 =?utf-8?B?UDRTcUI1RVJRTU5uUy9CbFd4Qm1kcHg4UE1IK0x1OUgxTnhSejlRQk55OXFa?=
 =?utf-8?B?VFlZU3JkeENyOFg3YXhYNjRVWkFVY0duYzlwK2diZ01UM1JGcWlNZythRlBM?=
 =?utf-8?B?K1pXcVN2bEliaDBTODV6aXNqbnd1WTFnVGc4Y01zeHQzbys3WHp5dUNsRllu?=
 =?utf-8?B?OUY3ZEZ3Wm8rczNkdWdoNVc2aGFwRGgrZXN1YzVVYkhCbDRkNllNYi9XbUlz?=
 =?utf-8?B?S3owalZHdW1NT1BLcTdtNnlwRjF0Yzh1WjVvR3RlZGEvVHRsQy9VaDNIR2RW?=
 =?utf-8?B?cVhnOHh4S0xKQzNkZ3hBK3FOS0toYlNLamloZWc2U0tvOFMxbnVDeEU4Yk5F?=
 =?utf-8?B?QklCT0pxdTdhek0wQXVvNUhUa0F4clVIQjdYeE5mZlZTb2hKblVGUzFrWCtD?=
 =?utf-8?B?YW81L1Z5cHMrY0lvU2ErY0d5dFhhN0ppT3FPMm1GTWRkcGt3VzZ3R2JpN09K?=
 =?utf-8?B?cjhZbXhoY0pxZW8zdWdyQzFLOCtERnhJclhRNUNjd0htc09PL2tBUkxuSzhB?=
 =?utf-8?B?SzBKMkFMQ1JsMlBaVEhWZmo0K00xZlg0a1phOWRLYVQwNXBxeUxkM0gyTXB0?=
 =?utf-8?B?S1pvNTVVMk0rNFVBbnhxem5sY0VWOFhGb2w3WDMzU3JSNmFOdTdSaGk1YUlI?=
 =?utf-8?B?Q3IzbG5yLzVEdkJzUCtBL2pZb1lkanl2cmdqQXUvak02b2ZoM3ZzbG54RDhS?=
 =?utf-8?B?QVZ5K2sya2pYV0ZGc3R1ejBacTNvNGFnRWVvTzJwN09kd0gwMmUzU2NqZ0NT?=
 =?utf-8?B?MmxYejdxcUhRd3ZMM2llRWRjWTN4STZCYTRkY3dIKzZjekRUNms3YUZlQksr?=
 =?utf-8?B?OCtveVpNZGErd1FTZUNjMFNnaVJKUlNENE9qeHhNS3VFSWRZVG5ZU0tKMnBm?=
 =?utf-8?B?WWZzRk1XNFdPaVM2S0hxc0V3d0RBSWRscFQ3MnRrSDJmRmJ6WFgrRXI3dW95?=
 =?utf-8?B?aGRtSlpSUFZjR1FydDFwSUYrSDlqS0poT2tyNWlTSHF2blZ0UG56NDhjVnVH?=
 =?utf-8?B?dG1iYmZuTDRSMU9zK3JvMUJOTGRtbVdsQ0V1MWpHSWhIU3BjUWdEL1QvRzZG?=
 =?utf-8?B?TW5kUWpkRzlsM2JtakxsdHpuMTd1NXpESE9qZDV2RmlqM0N6cXgzU0FSclBD?=
 =?utf-8?B?eWNxNFBzVFRZT0d2OW4wS1FqNHFZL0E3TlhiMHN6ZXRGLzVNSDB6V3VvWlpk?=
 =?utf-8?B?ZG51NHZQVXdPUkRTK2NrRko0TmMwR2RKMWpQaXpOQVNsMmRYdXpqWjJwY1gv?=
 =?utf-8?B?c1RhakRCRXVyczlXUi9vNFQzU0VMYllySXRMTmliTXVHUXRnYmhNNkZ5ditK?=
 =?utf-8?B?b1owQUNVbXJ2eTFNUVJrNHBTWERZTFQvT3ArQ1FZbWlzeVc5RVQvNTFGelNx?=
 =?utf-8?B?VmRoTk56TGNOS3QvSktqWXZudUljTEYzN2xSZmwxZjNrZEJIVmJaeDNRZ3pQ?=
 =?utf-8?B?c2tNNU5rM2ZsU0RMWmNOdTlBd0xRQ0xFZWEzeDNVUmpHOGxob2hrcFFKdGlr?=
 =?utf-8?B?a0I2bTFFOUViS1RlOXZISjJUZktSWjJYY0phU3RZZXp4RU5WNVF1bW5FbzVu?=
 =?utf-8?B?ei9OL2E0eVZDUWZmTm9YNDFMdDl4c0NoY0VvRVBIUDJyRS94K2hRVENhRU12?=
 =?utf-8?B?U1RyMlhCcUxxMW03QVBUN2oxY2Q3SnZsMWRmbTdOam5BWFl1S2VHYkUzNVpk?=
 =?utf-8?B?bG9EL2o0Y0ttNFA1ajFnZVQ2d1VMVlVVa3NBZ2NPUzV1Z2Y0Zms4MlVNMEFU?=
 =?utf-8?B?N0oxWG9rK091aVBNT2I0RnFmZHZ3N1Rob01FeHNuQmEyMjgySnVTTmlPWXdJ?=
 =?utf-8?B?ZFBCdmNCeXh0OStFV3dIQWpRRHJaejdjMUFNRlc3NjR5QVljcEZBZTJPcnBj?=
 =?utf-8?B?UHhUZk5YOGc3czJGcmtjYUJacGZoeGtrb3NMdGNMYWxnN3laN1MrV3UxTDJP?=
 =?utf-8?B?UEFIeGh0L29KMk5zejZhN0tPc3FtZUZPU0M0SDRVanFWczBvNmhuSkNDMDJn?=
 =?utf-8?B?aDVZbkFsNVR3MmJkQzNQdStrK0R3Nk5UZTIydFpRc2xqamVhVEU2UFlJZ0x1?=
 =?utf-8?Q?G/i77q1+oiS67NzddIYkD7RG/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8c9240-9a87-46f6-e502-08ddd930c521
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 23:42:44.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mf4W6u1+vn3GWQUAT0vJ8SozHvrWN9MDJlQvAYKEsoXadYdJNHJ6HhP7y+s7HBxH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300

Hi Reinette,

On 7/30/2025 3:09 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> Introduce the mbm_L3_assignments resctrl file associated with CTRL_MON and
>> MON resource groups to display the counter assignment states of the
>> resource group when "mbm_event" counter assignment mode is enabled.
>>
>> The list is displayed in the following format:
> needs imperative:
>   "Display the list ..."
Sure.
>
>> <Event>:<Domain id>=<Assignment state>;<Domain id>=<Assignment state>
>>
>> Event: A valid MBM event listed in
>>         /sys/fs/resctrl/info/L3_MON/event_configs directory.
>>
>> Domain ID: A valid domain ID.
>>
>> The assignment state can be one of the following:
>>
>> _ : No counter assigned.
>>
>> e : Counter assigned exclusively.
>>
>> Example:
>> To list the assignment states for the default group
>> $ cd /sys/fs/resctrl
>> $ cat /sys/fs/resctrl/mbm_L3_assignments
>> mbm_total_bytes:0=e;1=e
>> mbm_local_bytes:0=e;1=e
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
>
>
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 5cf1b79c17f5..ebc049105949 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -1080,6 +1080,7 @@ int resctrl_mon_resource_init(void)
>>   		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
>>   		resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
>>   					 RFTYPE_RES_CACHE);
>> +		resctrl_file_fflags_init("mbm_L3_assignments", RFTYPE_MON_BASE);
>>   	}
>>   
>>   	return 0;
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index d087ba990cd3..47716e623a9c 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1931,6 +1931,54 @@ static ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of,
>>   	return nbytes;
>>   }
>>   
>> +static int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file *s, void *v)
> Please move to monitor.c (then mbm_cntr_get() can be private to monitor.c also).


Sure.

>
>> +{
>> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>> +	struct rdt_mon_domain *d;
>> +	struct rdtgroup *rdtgrp;
>> +	struct mon_evt *mevt;
>> +	int ret = 0;
>> +	bool sep;
>> +
>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>> +	if (!rdtgrp) {
>> +		ret = -ENOENT;
>> +		goto out_unlock;
>> +	}
>> +
>> +	rdt_last_cmd_clear();
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>> +		rdt_last_cmd_puts("mbm_event mode is not enabled\n");
>> +		ret = -ENOENT;
> The error returned by the files when "mbm_event" is disabled (but supported) is
> inconsistent. All but this one return EINVAL. Please make return code consistent.


Yes. Sure.

>
>> +		goto out_unlock;
>> +	}
>> +
>> +	for_each_mon_event(mevt) {
>> +		if (mevt->rid != r->rid || !mevt->enabled || !resctrl_is_mbm_event(mevt->evtid))
>> +			continue;
>> +
>> +		sep = false;
>> +		seq_printf(s, "%s:", mevt->name);
>> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +			if (sep)
>> +				seq_putc(s, ';');
>> +
>> +			if (mbm_cntr_get(r, d, rdtgrp, mevt->evtid) < 0)
>> +				seq_printf(s, "%d=_", d->hdr.id);
>> +			else
>> +				seq_printf(s, "%d=e", d->hdr.id);
>> +
>> +			sep = true;
>> +		}
>> +		seq_putc(s, '\n');
>> +	}
>> +
>> +out_unlock:
>> +	rdtgroup_kn_unlock(of->kn);
>> +
>> +	return ret;
>> +}
>> +
>>   /* rdtgroup information files for one cache resource. */
>>   static struct rftype res_common_files[] = {
>>   	{
> Reinette
>

