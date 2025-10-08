Return-Path: <linux-kernel+bounces-845830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE3BC63D7
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C8A34EC5AE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF5D2BE7AD;
	Wed,  8 Oct 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZNvWTkwT"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37827B358
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946928; cv=fail; b=WHyTwLZUImKt4PrcPLpNqQRyynD9C1WVDyQIAl6TGGufgvWkFu6T7kY679KRjvNarA6cp0BMymtbhHWGKuFBYdQYyMJAoOnSbFMK53LW5H3UrVhQD5w+qGE4E8IbX8EZlg1bIAeQ+ikc5ljFteoHNt3I/Dv5vHiZOJIzweimT5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946928; c=relaxed/simple;
	bh=rI5MjrlqhbTdZW1oLwQmflwZVAuXtjQUR167SwK07jw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H+y/qJMzf3QTjZdGRdbF79vDEWSLk3GweOoBUnJ9YG9IVr+w7wkeZTuXR8Uu+ed8KyGs5zvkjE6dlWSRLflhxe7YYTKHvYEOOR2q3zj9WfZah1BNXWADf3BbEcocTFDtjPNvEXKeaF8V3u2DbGOtkVKAZRqIGfCSzONXqY3+XpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZNvWTkwT; arc=fail smtp.client-ip=52.101.52.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN4jpON+fzdSCWOMs3kgfeSvYX1onb9SoIlQJGSdIg/VCpWeYWqTTkJUbb8S38sf6kUF+KdMpwiBTJIoUqnKJupWnehh3ZnATzdPId0Q8ksr1kAciYQDtecwQRR5QPpr+0UsuknVrdmjs3gjLtZU6aDtvX8rZz8FV+XUCFMq0/bgBUVfBKZJ/B9mq5Usr8i4LD82Gzi/LBreW+lkuvhoKjkHUnOBPa8dqax4UVFSseKiyAi9pfIoCSJYmpGM3NsihCy94Cn0Wy1uQcxBKrCvO1x/IMKrEzuBzSQuXU35+RtzK9b6RWMmDFo6g3j4OMk5NC/1Ia9rD/1rnClLg7kPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqkzCsdBYRvkuATifWe1rdvP0VUWTlhw+W7GO4bmqoo=;
 b=tq/UHWRix3C/AWXOsJ7mRu3WIzQhsegYcWjzTrb+kCWG427IFZ+WRSfGYVST2mXkBeD5dlrWoBddV3zKxfVZ35/p7EY/yIWb7cYPmaooc+NqGkcE8C4GYu03qLRWZ6TTqWyvmxClCwnMpaJ48EmrCRNZHdZ47aIa7GsZTMqtu5z/m1cov7VCO8pvEdYRsEqWfQ4aqyyihVZeoWBGeMGU+bEjeL7bWJ6AE07MRB1mKwBKAlAl866eowErUUZiwxDuJlq8UC2hN6RoJbboQWtYn6fXJfkSRFkD8Cf38VI4DvEKI9cY1/kp3qUm85kmlwCYRlm/BKj6yHfpwf2RUAuwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqkzCsdBYRvkuATifWe1rdvP0VUWTlhw+W7GO4bmqoo=;
 b=ZNvWTkwTlSAwcO14woSuI9m6Or9slo9gCk1Wfy1WfBOgQQHZc4PjMem0ROYsoauzuooYbWQBfOUSQVFB3g5VHMVbvHY0LxQv8Z2uGJfmFLTSfWDYJ+MU+lx9iub3VIjakXzR0T4ax6hPrngh58THQDh8aeXM0Ae8aQCT4JIJghY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SA1PR12MB9546.namprd12.prod.outlook.com
 (2603:10b6:806:459::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 18:08:38 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9115.018; Wed, 8 Oct 2025
 18:08:38 +0000
Message-ID: <6c512e5a-0657-4f3e-83ac-7f8fa1de4c6c@amd.com>
Date: Wed, 8 Oct 2025 13:08:36 -0500
User-Agent: Mozilla Thunderbird
From: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH] x86/resctrl: Fix buggy overflow when reactivating
 previously Unavailable RMID
To: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, tony.luck@intel.com, Dave.Martin@arm.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 peternewman@google.com, eranian@google.com, gautham.shenoy@amd.com
References: <515a38328989e48d403ef5a7d6dd321ba3343a61.1759791957.git.babu.moger@amd.com>
 <fe06aa33-3351-45d4-a687-ff88a689be6e@intel.com>
 <3e1b459a-bd9a-400b-8c10-038b330e539f@amd.com>
 <1b352ad2-e542-4005-a470-5a9bb94b7ad8@intel.com>
Content-Language: en-US
In-Reply-To: <1b352ad2-e542-4005-a470-5a9bb94b7ad8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0195.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::20) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f29da93-5e72-4a94-6b88-08de0695b471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFhUdDJ1UVdIRmx1TGM0ZHJTTStSWCtmNjkvQXo3RE5aSnRLQXpISWNYTno5?=
 =?utf-8?B?TnBNd3ZZVXZaRnI1K1IvZHJLWFdDU2p1bWhKT3JjMmZxMFNJaFRuajVYZlE5?=
 =?utf-8?B?MGUwaFFnK0tPbk9pUXNiN1NmQ2JaQjA0WTFsQXNqUlhjTzM1QjU1YjBVUUl4?=
 =?utf-8?B?RXViclRYSm1QTmJCc0JkMGNqbU1KL2dsSjFCcSt0NHdFQW9taUZnN01tZzJN?=
 =?utf-8?B?bUNEUkpZbk4zQzZZWEI2aklIZG81Ri9kaHlvMEMwcEZ1LzVNZVN4bkVrc2VD?=
 =?utf-8?B?eHliUzdSMllSMkVURzRjUWkrKzU5SmpFd2NoMUd0K0hxSWtXMmxNVEt3UGpO?=
 =?utf-8?B?Y2dsZENYaTZwWU5zNXRuZ3M0SHNRUHROSkZNMmh4K0o0Z0FmYnN2Y2hCcmEx?=
 =?utf-8?B?NWQrUmI0a1hFMkYyQ3BrZXB2ZzVpS0xRdDg1bGtETVY0N1JlTFRQV0JhRzhl?=
 =?utf-8?B?Y2s3ODR5SlJlanpZV2t0aUJTejV3b3VYQlJZUEQxNTk5eG9XZ2hQRjVwR0t2?=
 =?utf-8?B?VjZkamM0Z1NNejdpbDJaRGdZOEdDWi9uR245bWJXRE5VN0FMMjlXN2dYR3kz?=
 =?utf-8?B?eXRyNC9EdjA0cmtEUlhKQ1JYK3hJT2dyYjU0UGZZRHNNMEJwWjZ5Z2pWd2tx?=
 =?utf-8?B?VDMrVFJJc3hhVVJoVnRqcVdrR0oyMUx4aUlNQ1R1MkcrSHo1Z2NFd3hHNk1L?=
 =?utf-8?B?T05XUklEdi8vc3BjSDV3REdOVE52aFhqZWVZbVdMSGtVM1ozQ05wU29JdU5H?=
 =?utf-8?B?UHRKZGMrM1doRXFJMG45QXlwbHdXcG9ORXVPeFZKK002eFRpeHBNNTZnWmNQ?=
 =?utf-8?B?YVEzdFRKL2wvOEFqOURuem1ocXNER3BHNXdjQXB3SW1VN2FYQ3l0d3YrNTI3?=
 =?utf-8?B?Yng3bENpRGVmU2Y2MitGUUJsTStPbXlNQVpOQ3hYWk4vQTdwd2lKVHg0ODBB?=
 =?utf-8?B?dm9sMTlQZHpiaHRDSllobm1pUlNQbHhSTHZkME9vb0pCcXVVMmdqcXl4RDFv?=
 =?utf-8?B?NmF4d2trWW8xUldNUU9zaXpzdmdhS3kyY2JoZ0o1RjhYYjlxZHM4dUlGZzZT?=
 =?utf-8?B?NG1JRW05b0lhcnAwL2VwS24zWncwUkNObHVZaTFIUnlCVUl6c2lkbEpQMUFl?=
 =?utf-8?B?d0VHT0Z1NkJpanJKNTd2Y2d2d01VWEluU2NLVERCRVVmU29xajRtVlJSKzdS?=
 =?utf-8?B?SzNlR1ZYRHJ4N3RLTWFPdXFFTUFTT3QzNzNuVVN2Z2FHSkdlc1EzT3BvdnEr?=
 =?utf-8?B?YWR3MWZSYjdDZDcwaEVDYWdLLzAyaHIyNTV2OW1Mbng0S3RkUWVwVUNlVzR0?=
 =?utf-8?B?VDI3ZCtCcW1vb1RuOFpzRzF5ODZWZHI1Q3dyTHlzeGRxWXNNVC90VVJZM1Y1?=
 =?utf-8?B?VTNpd3UxV1dmSXJGa0xjSm50cnZOSGZmUXhIenVYeEZ0Y282WHROQUVOU0th?=
 =?utf-8?B?aExobUQ4MFBSUEpvbnlwaGQwaGF2OWJzeHYzeDJ3dGRVOVJROEQyY2hqblEy?=
 =?utf-8?B?RmJ6K2dmd2tjUnVRUlhsTHVMWUNOaFpqeGhWU3JxaUFscnpIRDh6NXhLbTlq?=
 =?utf-8?B?WGFib3VHZjl2UFJ2NzBad3llWjU5bGpDcGwrR2dwaW1qVDVLRisyUEhIQ2M1?=
 =?utf-8?B?UzdPYUpQeDcxQ1B3Z1dHZUFyREkwY09OWGcvbnp4NHE4ZGEreXNrM25zV01C?=
 =?utf-8?B?c09sTzZjaFNsNGJncWsySDFwdkVNWGx3VHdEMzByTlVjQ2J1Z3o1VGtsR0p2?=
 =?utf-8?B?MXZVVTVHTmZxczR3NWsxVzRtREQ3TjA4VDlYWitRZEpuajhUTkZvSEpGQVl3?=
 =?utf-8?B?QVlKN3U5R29jUmZiVzBjUDZWMzY1TjM0OWF3UE96Zko0b0R3c05FRFFpckNn?=
 =?utf-8?B?Q1pqRUNncXpYWjJZMHNORG9VR0RBbk9kUEtaNmREcWRmQWlDZU4rTzRCakR6?=
 =?utf-8?B?VjV0d1FsVllSdHJxQVlLbFowbkJmdGlENVRRV0JyeWxyblNOaWx6Snh0M1VM?=
 =?utf-8?Q?aCOyApXkSllQwkJssxgJ+QoaLO/Vlc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?by9ycThYM0FZclo5bnRtNFk3Nld0b3d1RkR0UTMvelNMVG5ydUxOVXhMayts?=
 =?utf-8?B?azVLaTRNSFU3YWxPejA5WmZHTmtwOGdic2ZjbmRYQ2VUdmdDcWY3SWwwWmRx?=
 =?utf-8?B?bzA1UkhFdkI2eHJ3SDVDSVA3ckJDTEVpUkhFQ0ZRVHpNa0Uyc1hCUURFa3NY?=
 =?utf-8?B?Q3hHRmN3SElaVWVKTlR4enRVZTBRU0VrdjAvV1JPQ1RYT3RmWlRGd1YyN0dl?=
 =?utf-8?B?Y1RUL2JnQ3FybWwzblA3dG54Z0JzYkJkcWNGVDVzQi8xcWIwb2ZpS2dZL01O?=
 =?utf-8?B?REY4VFNlR2UwTllEYWNBNWdwS1QxMHBXZUxUNEs0Vm56bFp3VjZTQXJuU01w?=
 =?utf-8?B?NHRaS084RHVZNmh1VEkzOGlZQmdGQ2FqalR6WW1xWi9mOE9LN3pISG16NEpj?=
 =?utf-8?B?Z3pMNUNMODB4dHF3Rm56YjFlaHFTWk1sVEx3SUhGL25abnVnWlRHZjZUaFJl?=
 =?utf-8?B?dTZ0UVhzRTFXTHhjYnhBbVI1NUJKUHpMZ3h6NDE5QzJoT0ovT0xhSll3TldE?=
 =?utf-8?B?SUtub0cwdU83aTIzMk8vcWJUamFLQi9uRDQ3enB3MFE1M1RtNXZ4T2NxdUlh?=
 =?utf-8?B?TVVjcmpSejEzQWdscmlVd0RaZmxsMjN1bmxCYmttazRpTXp0OGk3WkM0Ny8w?=
 =?utf-8?B?NU9DS2ZuMjQ4OEtxMXdwbTUreFJpZWRTTitpdy9TZCtyZmVPTGRKN1huckJt?=
 =?utf-8?B?ckJvTkk4SDIvaGQ0bmVGZEFHQWtjdkhranl6bjV5Nmcrb1B6Y3E5OGZvc2da?=
 =?utf-8?B?Z1hUS1hBaUlzSkJtbmhEbG9OMVUvaW56R2VmQjZYNU94T2tvMGVkby9ESDdl?=
 =?utf-8?B?ZFdBMlpzM3ovalllUzZTQldQSVI0eGRzdDEvWHhLZzRvZUp2bTBCdmxYTFRU?=
 =?utf-8?B?YTVGVCtabUI3UFpsS25NQnJlSnRnZWIwek1wSFh2YmM5S0VkYTR6VzdzQ1NM?=
 =?utf-8?B?RmYreEJ2dVBSYzhpblpCL2xmWW50V1MvTEtzczdVOEpxZEUzQjdBdTJlZVRQ?=
 =?utf-8?B?SzdYZU9Mb1lwNGNZbFVDVVBEQU1WYlg0OVVIWkRNWVJDYi9VTXJKS1FUWks0?=
 =?utf-8?B?eVB1UkF5ZUtIejRqV0x0UTVmVXZZd0RxbXpieGp6SlR4MjdGMXNCRVlWbTJE?=
 =?utf-8?B?YVdZWFJhUUwwRGpBZDlJUUJ1dTZpcGg4RHNnczloaytZbWY5WEVZWUYwcWNl?=
 =?utf-8?B?L3FFODVUREdZazVIc2VuSWVYOTdWM3NoZ0dSc0pKbmZWdEJPeURXTzlqa0hY?=
 =?utf-8?B?UnNZRWNUV3hHeXZsckREZzIrZUdVb0lFK1dHcTVxeGFDR1VGMWxoM1kybXI5?=
 =?utf-8?B?WHczTDErQU5nN2ltb09iZTMyOCsreHRLR1ZMWXZqUytHS2lXQlVTOWJrNGRQ?=
 =?utf-8?B?RjcveEF0dEFGamhiVXlOaFRJQXZwY2xJTG1hbUxDWkhaTnMwdlJTMlcwSmcx?=
 =?utf-8?B?U1crTHhiRHlKbkJqWTNtRWVIQnVYVVVlWmJtZnlja3BrVU5YNDNIVUtLb1Fz?=
 =?utf-8?B?QllHK0JadXorejJIaC94c0xGTGppcktBVWVQZk5oZzhXRlBKK1hzN1ZjdUky?=
 =?utf-8?B?Q1E1eVFHUUVmZTlOQkY0cTBRSUdxUldLbUZNWEVxZFp4ZFU4ZnpqcUN0SkZE?=
 =?utf-8?B?Zjh6dzIzM1Njakp6cDU0SnJ6bFVPdXpldUk4QzZBQTY0aGxSMHdBV3lxdVRL?=
 =?utf-8?B?bG9NRVplZStsMDMyemdKOU5GSTJKSFZmTzhBK0ZsNXk3eGZDVnZvSzlXTUlK?=
 =?utf-8?B?QW5mSCtmR1NoQjhhWGVRQVZvQnZVOEhzK0E2cHJQcjRMZ2lnZ1VKSEQ1bmZn?=
 =?utf-8?B?NnFzWkhjMlcxaVlCRnA4V0Z5M3YxbVo0b01qNklFVEpraS8xcGhDNzZPOXRx?=
 =?utf-8?B?ZG5PbUUyUkMzZGtVV1NaNHJMdk1GT1NtK1A5ZEhGY0k0aU1URUtNb2l2VGJt?=
 =?utf-8?B?WHdVY0lmTFM4UEdieElYUHFBVkxXQWtKUnpqMWgwdlpHK3lkWVNkb05CSndi?=
 =?utf-8?B?Nk9zSW16RUpzMkNGY1FINmxucUJBZWFSMDdDM1cwWmhnWVR1WGl4dFVwcys4?=
 =?utf-8?B?UFNYWmdwRElRZEJ5OExlSzVYN2tQRTQ5TWgrbFlCeTBhOTgxSUNGY0RGc0gv?=
 =?utf-8?Q?z1ds=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f29da93-5e72-4a94-6b88-08de0695b471
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:08:38.2722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yTPvIQGMIqoShEyxe4xjNv5+VdlVhyqRWSi7uShfuQ7swnWsBCpRU2xP2juZZMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546

Hi Reinette,

On 10/7/25 22:04, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/7/25 4:47 PM, Moger, Babu wrote:
>> On 10/7/2025 3:23 PM, Reinette Chatre wrote:
>>> On 10/6/25 4:13 PM, Babu Moger wrote:
> ...
>
>>>> ---
>>>>
>>>> Tested this on multiple AMD systems, but not on Intel systems.
>>>> Need help with that. If everything goes well, this patch needs to
>>>> go to all the stable kernels.
>>> Needs a "Fixes" and "Cc: stable@vger.kernel.org"?
>> Hmm.. Not sure. Which commit to add Fixes in. This is AMD related.
>> We should have taken care when adding support to AMD. Does this commit make sense?
>>
>> Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")
> This seems fair. From what I can tell this spans all LTS kernels so I expect
> a couple of different variants of this fix since this code has evolved quite a lot.
> Do you want this fix backported to all the LTS kernels?
> It may be useful to add a note to the stable team that this patch needs changes to
> apply to all kernel versions (see "Point out known problems"
> in Documentation/process/stable-kernel-rules.rst)

Sure. Sending v2 will all the updates.

-- 
Thanks
Babu Moger


