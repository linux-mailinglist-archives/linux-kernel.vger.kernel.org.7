Return-Path: <linux-kernel+bounces-755678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8404B1AA46
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD6A189D7E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED95D238159;
	Mon,  4 Aug 2025 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GTviITCL"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186AA634;
	Mon,  4 Aug 2025 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754341301; cv=fail; b=EX584VI4y+SuK+5eciq2JGn3Z4NF+/qFp4VeN9oHDmyx01SFl/77XT/OwnDmaIFzj4MsiTnhAnzkmnh6vBHGlIz6FxFjK/qHHPJq2Ma1NzJyPpkvP1csyqOagi9GxxGStpzdzRTyP+orD1Ms1yFgWBSJCsJYNNSE2xVu9LL6Hhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754341301; c=relaxed/simple;
	bh=TwmtbCuXpZgg/kBoV3IrzrimGtYJuBq1yu+Eftgejnk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EsTR1UyfLc3XX305F5gUNbjh5eyIPjye8e04i7Rnig3U+wd83pBQ7q8saxWujs3R+xlRRVwsFpEgh4OcaB7A8w+0/xUl4NVzWSB3QjdPC27efzYODbRczGJB61/OqMuMRONzQeY/Bt+CCwVrP2elnecLpn8qzop9Lra/T1PWTzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GTviITCL; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/4T2i9Ju0k6LhaTP4yqX6LwJsX7uNNPAcdsQ38Qcjc1GJ5quRb4KBnG8WoEh0mn5NtZJWEiWNnRxd0fZPZGqtQ5gQDgvmq5QytWi3ePmPRaOPQ2PCIxN0MIC4lIgtfZD/Pnv4LW0z8vYoLDohd6ifxvTHbvEecCAUW+LXXxtOwYgMEKs+T48dD+PajSLOLupAbLDJbBBVaVKSZ2pl0g0v1t80xds1RgrFoa5fxpvWAtdLVS/iBF+EtaBQWI5lTiay2H61dIP+LpDGzg5mxs1HgEIfBbumfM7Gi9xR4nHyBRnqtQI8eqYUEUC3THyGyDN6brXFD2jTHfoUuTIZ/z+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpREks+h4DjveBwkXvL/Ypf1iJ36KWhZ/yC2E6kZSkU=;
 b=Byn/cTTPWV5FISf67bfNdQF0um3K/plptPHjm15hOQEJXptklC1DDp0LW4RlEyj4oI134Bf67fmSLBKtU3hWaFZL2LKyR/ch4UGs7horaITbOj500VreCzNfZ4E8ym6eOuOgnEXjfzE22t8ku5qG2k+wazatiwENXmKYyT4Af4noJN2ikI+sK1n0zDPzd7vtOjNaSaVTqu/kQGU5HPGKLdzrfnoTLmi16croiOORtdHXTeWiOtAb41yvaYEJ4hA8M5B5i24xFgyV1I/VA41ByNimvKIT98hEL8XaGndEBxzhowSfM4162a6l1C3+Gteo9CVLJoNvxfu2yi/rSvHBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpREks+h4DjveBwkXvL/Ypf1iJ36KWhZ/yC2E6kZSkU=;
 b=GTviITCLHY4hQEGci93SRBxPXGzh8ZrYcrkXpIogYfYTWsVNGSa5KbpWrXIZzqp8NJZfGpsZywBRGAJb1n9mf1gJnQOpsbZO5ZwCKxFYgyFfMdI6aUE1M812wtomEZ5uA/rSyRlQIAS8tZkgFs9SmFYsUEy/STwrogEAX2owtio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by PH7PR12MB9222.namprd12.prod.outlook.com
 (2603:10b6:510:2ef::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 21:01:36 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Mon, 4 Aug 2025
 21:01:35 +0000
Message-ID: <ecf340f9-a7d0-4ac7-ab1b-4ce4a17a9d20@amd.com>
Date: Mon, 4 Aug 2025 16:01:31 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 10/10] fs/resctrl: Introduce interface to modify
 io_alloc Capacity Bit Masks
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
 <a6f4ae3a709185e2c0904d53267e99e395a492ed.1752167718.git.babu.moger@amd.com>
 <82045638-2b26-4682-9374-1c3e400a580a@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <82045638-2b26-4682-9374-1c3e400a580a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0145.namprd11.prod.outlook.com
 (2603:10b6:806:131::30) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf1acbc-8789-4b91-6dde-08ddd39a18b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGpFY0NIS2dGNVBqUWVaUG1Iak9DUE90NmVZRDB0OFFUNkZyNUdvaUF3LzQ5?=
 =?utf-8?B?NitWd1BGNkpFT0JCSzBsZnJBSHB2RDRxVGx3TDdqVFdZaW1ZUlZaa0Jyb1dh?=
 =?utf-8?B?TTN0djlFUy9PNlZjWUJzUGt5bzFId3AyMkh3NE85YXFlbDNha3RvRGd3R0ov?=
 =?utf-8?B?U1hmdWJpM2RpOWtEY3pGeWp2U1BCYW40RHZtTDEyKzRmNzNQSkEwNVBORWk3?=
 =?utf-8?B?ZDRoU0NFUFZVNldBRDNDQitIWmtBcmRQb1QveUVHWlZETXk0MGdvOWJ0eFJT?=
 =?utf-8?B?S1N2cmFoS2czZ0FhTmo2Unk0TnhGbzNlMUtWZXVRbVlmY0ZWWkd3Nis0RlJZ?=
 =?utf-8?B?OWU4M1ExckUxQmVqT0FFbXkvOHE3Y3F4VWhtY2N2ci83OW9vRHRkKzNXYkE3?=
 =?utf-8?B?UDRhYTVJTG5JZzJCbXRpMHRBMmh4ek9pcSt2NG1MV1lTM0pHVFA5cEd2ajEr?=
 =?utf-8?B?VDRTSkYyMjNVNXhncTBmUGhrY1NyZ2wyMjZaOU9QcnpSUnVxS2ZJZVA3dTRl?=
 =?utf-8?B?VG8xRnA4MGdSajhBZFQydVZmeDhHTHIxOWdZajZ2MnNjZ2o1aDRRRHYrbWV4?=
 =?utf-8?B?M1BBYzRvQXZKck9DOW0rdEcrVWZMM2c5VktHbmlrYUZRVHZLcW5OL2xOWVcw?=
 =?utf-8?B?OEJ6Ukg5RHYwdFdYTFoxUERxVGl3cXBQSkdOY29uVU5YeVpIRHJuR25tRTdZ?=
 =?utf-8?B?ZzV6TEY2RzI4YTZyRVFmWlI1UXFHNU8vd1RqZHNuTXl5Yko5T3BEaWRxTFlr?=
 =?utf-8?B?MkE0NnN4NVQwbTV3eHczVnRLREZ6dEJHeWtGWm5ZdlpYS2c0Sk5pemE1MTRY?=
 =?utf-8?B?V2hGOHBqVllPNUpFYU15WVRzcmNaQWRjUFRlamVPUmlqWGhjb1ZBaVBzeVBq?=
 =?utf-8?B?bzFkMUhySllSWGhGMWJNQWZUSTh2RThlQ2xrQ3N1R213RnoxTEJMQUFyRGRN?=
 =?utf-8?B?VlJzWVB2YXRTcUxGVFNtNUVnSmgzUXRkbm51SHM1Z3JFaU5oeWxwRU0rZElz?=
 =?utf-8?B?SVFqeUVVZjBjam5oK1VHZ2w0bGIzRHg5ZzV5eWE3eEVEaFRtQXc4dGRJVlVh?=
 =?utf-8?B?L1BCTWxyWnIzS213S1JhRWZDOUxVVkRBaFFxeEp1d1pLa3ZjZkM3RHJVejNw?=
 =?utf-8?B?eDZUMTJKYUVJb1hPNzkzYzF4dVl5V1RsRjJRKzlYVjFtWTFtMjJJR0RONlRS?=
 =?utf-8?B?U1p6Z0lheERGTTZrMFBrc2pYL2l0VGV0Y3dDOE05Uy9PMnRpcDJQb1I1SE9l?=
 =?utf-8?B?RVpuU1hnNjFNbjRSdlBSaStzeWNSa0RRYlBVRklmK3hCdHl2ZTFObXhkcytW?=
 =?utf-8?B?eEVIaWxyYW5nb28wS1loMzNVRllVcCt3dk5pTzBObUF6czdiL01kTUNaK25z?=
 =?utf-8?B?YkYvZkFUME5xVUtQVC84OFhveUlJMGk4TmxBZHdxZk5DV3JrOWJpTFg1YTJw?=
 =?utf-8?B?SEhOVFhldE5IQkpKZUUrZ1ROcWs0bW9hYzFTdmFCRGg4Vmtyb3lhUUltYVlK?=
 =?utf-8?B?Z2ZyOFFsZGduWVBKOHVLcEc4VlNZMmttb0Jadm1TZnF5RjRCK05XRmZyQVB0?=
 =?utf-8?B?YjMzVlh0MEx2Nnh0QS90c3hrWEIza3g2cGQ3OHZWQmtBSnpjUFd4eEl4WWg1?=
 =?utf-8?B?OWpsZnhzRHhyTmVpeVFkOGQ2Umw1Z3FBU1YvZDJRQ3FRVXd1cGsrS2dla3lI?=
 =?utf-8?B?YUJEais0amhNZVpyYlE3T1VZa1RCb0lVb1IyQmpveGNUR2JlRkRqL0hiNlps?=
 =?utf-8?B?TDQ2cXY0bG5uK2loWFpMRklTNll3a2tNbHpPQnUrWnR3MTdDSVZLL0phYTgw?=
 =?utf-8?B?emMyclhUN0RrUkw2YVBrcjFOeit2Wk5tUFMzdlJ1dU16UWlSanh0Sm43bS9I?=
 =?utf-8?B?NS9hcnNOc0V6RXp0TXVWbkpyeGxRNEk4Q1ZtTGE4M2cweU1xOTNRdVByMXNq?=
 =?utf-8?Q?UG4T6WIJKdo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFo3Z3BkRGdUZVgrWWlKN1NLOHU2NnZyajhRZmVFdytvcGZCWjFpRTRuNXpS?=
 =?utf-8?B?VkJ2VW9uZko3OUNiMGJJQjFuYXl4d25xQ1o4bi9DYU9TRmtrRkZNSkw1SmJS?=
 =?utf-8?B?VGFwdkZZTU5PTW5CekFOUTJLY1d1QzltSmtSc2UzKzRPNUwzL2loM0NwSk40?=
 =?utf-8?B?LzQ1ZERaMWcwZmVzR3RQTWRJKzFScnlYcVdKWitabDZlK0QwYUlEemo1bTFO?=
 =?utf-8?B?V0Z3a0kzUE9aYTdOYmpIMUlVY2taYkl4WVc4cVVha0dRa2V6WFp3MUo3VlpK?=
 =?utf-8?B?Ynh1Nkt5elRTbzZ6UXJJeEVYMFNRTy92eGNsamJaTGorUkI4UHhHTVVwYjlC?=
 =?utf-8?B?REZwcXVYVVMrT01GM3dSV2dUeFdnaWt6SjY2NWNxR1c2K3VyV0hBZGZJbEY4?=
 =?utf-8?B?amk0WlZKNi94OWFDUVd6b3dUbHhwTlNBUHF5MDZDc0x5QzgwU1k2QXlMRG40?=
 =?utf-8?B?MDdUb2FBY1JHSHFYOFpGQXo3TXg1bUhDVmtrbTcxYnZ3VWd3QUV4Z3NyeFo1?=
 =?utf-8?B?cXNURENmbkVsdUsrRW5kelhvMmJDc0ZFcHpGMTRHNXAzZTdvNGpqZzhLSkNn?=
 =?utf-8?B?eXV4UDdURU1CNUZRaVRtK0U4NmFaeFJ3WmhFK2crMFY3NHk3c1MzK2VveklF?=
 =?utf-8?B?OUlOMHFycWN2T2N2M2NSMHRxRWJtL2JlcUNHVXpTZkVSNmthaHBSMlVsd2R1?=
 =?utf-8?B?THRJNGIzQ0NwamZYMWZBd055UFZwYXdoTDdiNmlHUXg5WjdXZTlUUXRLYVZp?=
 =?utf-8?B?ZnpWR0JITmVKczluUEk0NEg2bGRRdlBvaEhtODczTS93Y3hKNEpLcHFVanlR?=
 =?utf-8?B?ZVJVcFdHZTJ6L0JMbENLME4xbEJMaDhoVEV1bnZwcUc2TDl6WGZiU21lUHhO?=
 =?utf-8?B?UWxXOVlST0tBRlBXb2d5bGJVSVVMQlVqN01XZmZuN2swOUU3VERlYzlhdGpp?=
 =?utf-8?B?dEdVdnJvcEF0bVRUa0NjNG9XN0ZpcmVrU3BHM2NiWU1yaUxPRnFhWk1qZnZY?=
 =?utf-8?B?M2Q3aVd1dnhjM1ltV1NJU25tWUpYdmZid1N5d1FKdzZqbFI4ZlZGZ2JnTno0?=
 =?utf-8?B?bm5MU2YyV1pmalRGOGlsZjRpb3lQMVF5UFlqMDRqemlsa053WVkzYnU1VjBL?=
 =?utf-8?B?akRoaU9neC9xZVdQNVdDdmVaNkRmbFRwTFNxYzNqdHlPNnhicWxHYVJONVVH?=
 =?utf-8?B?M2ZnN21JbkVHOW54Y1hGUzdvTnBnZVZyMHdXcU13ZTJIbFNSbHA3THZVK3BF?=
 =?utf-8?B?UkJ6UDRWcm9IZkx3alFiTy9TWjBzaVFhQk1YRDJZeUdLdDdGcHV2ZGlWSk1t?=
 =?utf-8?B?dHErYnJZdTA0UjI3TFB6UWVQN1RqbUk3WUhxb2lxdjhKK1duMmw5WjNOaGdp?=
 =?utf-8?B?dVhLdElmazNuemkvN0FSVEFUUU9ZS1dmY3hHMmplSUNwdmZCSmtXS0pjMkdr?=
 =?utf-8?B?Qi9HNHlzaW1RcDZtWVhhT1NaeVp1V1VESVJJcVE4WTlIaW8xb1ovVWo2Ykk2?=
 =?utf-8?B?V2wwZU5ZbFMrTVJpT0xXb3Q2NzBZdDA5bHRuM1FrSlA1ekNWUkxkWVZJT1N4?=
 =?utf-8?B?SEZUVU1yRUpGV1hSNmJzczhKVGVjclpCR1B5aGNRSzRMYWFkeFlSazRxSDhz?=
 =?utf-8?B?SEc4SjYyc1FkM2J3cGVsUVVhYlpTSTZhTVREK1kvMjhJWVZQL3VaeXhrazZH?=
 =?utf-8?B?L0lNQkxzRWhmLzBMNUR6b0R4amkzcXJRbTVsREtXbFVzemtobWlVbFY2RldY?=
 =?utf-8?B?TlF1R2JqdnM5Zk1iZUxMUFVvNmpNaHVlbHVVTzR1clp4Q2NvOVZwcmIxTjBN?=
 =?utf-8?B?cndjZTFkaldRT2orc3IwL1c5Ums0UEsyMlVTWGI1MWNmMmFpcXNpaCswY2Vl?=
 =?utf-8?B?TDdwaDZEZ3czNENvR2hkYmdOemF4UTdvUXFMeWJwOXVaTFA3R1hKWTNqN2Vy?=
 =?utf-8?B?WWJNUHRPbkF5aGFpTUxVdWFwWHl6aE9YK0dJeXZFN0FSUm5lSWVob29CelRw?=
 =?utf-8?B?Q21hRU5FbUhtaHNqMnErLzhhS2JYdUtIbmFBTlV3YWpoTmJYMkI2aVFGWk1r?=
 =?utf-8?B?OGI0b0NMcFNHaFd5bDkweHRhQUgxUi95ZytQcWdwSGFKU2JQZzdVZlB4OXVo?=
 =?utf-8?Q?0bPA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf1acbc-8789-4b91-6dde-08ddd39a18b2
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 21:01:35.1503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIHS/eF63u5LfBEgo2wPfEaycSBukHAA7Ay47UF03RcsK6qb4jOoWS9KapDxRpdm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222

Hi Reinette,

On 7/21/25 22:32, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/10/25 10:16 AM, Babu Moger wrote:
>> "io_alloc" feature enables direct insertion of data from I/O devices into
>> the cache. By directly caching data from I/O devices rather than first
>> storing the I/O data in DRAM, it reduces the demands on DRAM bandwidth and
>> reduces latency to the processor consuming the I/O data.
>>
>> Provide the interface to modify io_alloc CBMs (Capacity Bit Mask) when
> 
> "Provide the interface to modify io_alloc CBMs (Capacity Bit Mask) when feature is
> enabled." ->
> "Enable users to modify io_alloc CBMs (Capacity Bit Masks) via the io_alloc_cbm
> resctrl file when io_alloc is enabled."?

Sure.

> 
>> feature is enabled. Update the CBMs for both CDP_DATA and CDP_CODE when CDP
>> is enabled.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>  Documentation/filesystems/resctrl.rst |   8 ++
>>  fs/resctrl/ctrlmondata.c              |   4 +-
>>  fs/resctrl/internal.h                 |   2 +
>>  fs/resctrl/rdtgroup.c                 | 112 +++++++++++++++++++++++++-
>>  4 files changed, 123 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index c22a9dd667cd..b9c3ffdec27f 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -189,6 +189,14 @@ related to allocation:
>>  			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
>>  			0=ffff;1=ffff
>>  
>> +		CBMs can be configured by writing to the interface.
>> +
>> +		Example::
>> +
>> +			# echo 1=FF > /sys/fs/resctrl/info/L3/io_alloc_cbm
>> +			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
>> +			0=ffff;1=00ff
>> +
>>  		When CDP is enabled "io_alloc_cbm" associated with the DATA and CODE
>>  		resources may reflect the same values. For example, values read from and
>>  		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
>> index 5c16557fb7a8..23c72a5ac043 100644
>> --- a/fs/resctrl/ctrlmondata.c
>> +++ b/fs/resctrl/ctrlmondata.c
>> @@ -148,8 +148,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>>   * Read one cache bit mask (hex). Check that it is valid for the current
>>   * resource type.
>>   */
>> -static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>> -		     struct rdt_ctrl_domain *d)
>> +int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>> +	      struct rdt_ctrl_domain *d)
> 
> This can remain static by moving caller to ctrlmondata.c

Yes.

> 
>>  {
>>  	enum rdtgrp_mode mode = data->mode;
>>  	struct resctrl_staged_config *cfg;
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index ab76a1e2e679..011564e69ed5 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -382,6 +382,8 @@ bool closid_allocated(unsigned int closid);
>>  int resctrl_find_cleanest_closid(void);
>>  void show_doms(struct seq_file *s, struct resctrl_schema *schema,
>>  	       char *name, int closid);
>> +int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>> +	      struct rdt_ctrl_domain *d);
>>  
>>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index 008657e43656..1093ec5e385b 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -2036,6 +2036,115 @@ static int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of,
>>  	return ret;
>>  }
>>  
>> +static int resctrl_io_alloc_parse_line(char *line,  struct rdt_resource *r,
>> +				       struct resctrl_schema *s, u32 closid)
> 
> Please move to ctrlmondata.c

Yes.

> 
>> +{
>> +	struct rdt_parse_data data;
>> +	struct rdt_ctrl_domain *d;
>> +	char *dom = NULL, *id;
>> +	unsigned long dom_id;
>> +
>> +next:
>> +	if (!line || line[0] == '\0')
>> +		return 0;
>> +
>> +	dom = strsep(&line, ";");
>> +	id = strsep(&dom, "=");
>> +	if (!dom || kstrtoul(id, 10, &dom_id)) {
>> +		rdt_last_cmd_puts("Missing '=' or non-numeric domain\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dom = strim(dom);
>> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>> +		if (d->hdr.id == dom_id) {
>> +			data.buf = dom;
>> +			data.mode = RDT_MODE_SHAREABLE;
>> +			data.closid = closid;
>> +			if (parse_cbm(&data, s, d))
>> +				return -EINVAL;
>> +			goto next;
>> +		}
>> +	}
>> +	return -EINVAL;
>> +}
>> +
>> +static ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of,
>> +					  char *buf, size_t nbytes, loff_t off)
> 
> Please move to ctrlmondata.c

Yes.

> 
>> +{
>> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
>> +	enum resctrl_conf_type peer_type;
>> +	struct rdt_resource *r = s->res;
>> +	struct resctrl_schema *peer_s;
>> +	u32 io_alloc_closid;
>> +	char *peer_buf;
>> +	int ret = 0;
>> +
>> +	/* Valid input requires a trailing newline */
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +		return -EINVAL;
>> +
>> +	buf[nbytes - 1] = '\0';
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	if (!r->cache.io_alloc_capable) {
>> +		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
> 
> rdt_last_cmd_clear() is required before any write to the buffer.

Added now.

> 
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	rdt_last_cmd_clear();
>> +	rdt_staged_configs_clear();
>> +
>> +	if (!resctrl_arch_get_io_alloc_enabled(r)) {
>> +		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
>> +		ret = -EINVAL;
> 
> Inconsistent error codes when io_alloc is not enabled.  resctrl_io_alloc_write()
> and resctrl_io_alloc_cbm_show() returns -ENODEV.

Changed it to -ENODEV.

> 
>> +		goto out_unlock;
>> +	}
>> +
>> +	io_alloc_closid = resctrl_io_alloc_closid(r);
>> +
>> +	/*
>> +	 * When CDP is enabled, update the schema for both CDP_DATA and CDP_CODE.
>> +	 * Since the buffer is altered during parsing, create a copy to handle
>> +	 * peer schemata separately.
>> +	 */
>> +	if (resctrl_arch_get_cdp_enabled(r->rid)) {
>> +		peer_type = resctrl_peer_type(s->conf_type);
>> +		peer_s = resctrl_get_schema(peer_type);
>> +		peer_buf = kmalloc(nbytes, GFP_KERNEL);
>> +		if (!peer_buf) {
>> +			rdt_last_cmd_puts("Out of Memory - io_alloc update failed\n");
>> +			ret = -ENOMEM;
>> +			goto out_unlock;
>> +		}
>> +
>> +		memcpy(peer_buf, buf, nbytes);
>> +
>> +		if (peer_s)
>> +			ret = resctrl_io_alloc_parse_line(peer_buf, r, peer_s, io_alloc_closid);
> 
> Similar to resctrl_io_alloc_write() this looks unnecessary. I think this can be simplified
> by moving the CDP check to resctrl_io_alloc_parse_line() where the provided CBM can be parsed
> *once* and the staged config of a CDP type just copied to the staged config of its peer type.

Yes. Changed it now.

> 
>> +
>> +		kfree(peer_buf);
>> +	}
>> +
>> +	if (!ret)
>> +		ret = resctrl_io_alloc_parse_line(buf, r, s, io_alloc_closid);
>> +
>> +	if (ret)
>> +		goto out_unlock;
>> +
>> +	ret = resctrl_arch_update_domains(r, io_alloc_closid);
>> +
>> +out_unlock:
>> +	rdt_staged_configs_clear();
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +
>> +	return ret ?: nbytes;
>> +}
>> +
>>  /* rdtgroup information files for one cache resource. */
>>  static struct rftype res_common_files[] = {
>>  	{
>> @@ -2135,9 +2244,10 @@ static struct rftype res_common_files[] = {
>>  	},
>>  	{
>>  		.name		= "io_alloc_cbm",
>> -		.mode		= 0444,
>> +		.mode		= 0644,
>>  		.kf_ops		= &rdtgroup_kf_single_ops,
>>  		.seq_show	= resctrl_io_alloc_cbm_show,
>> +		.write		= resctrl_io_alloc_cbm_write,
>>  	},
>>  	{
>>  		.name		= "max_threshold_occupancy",
> 
> Reinette
> 

-- 
Thanks
Babu Moger


