Return-Path: <linux-kernel+bounces-745961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1B9B120F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942391633B7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5588E2EE966;
	Fri, 25 Jul 2025 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="poJkcxlw"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9382BB17;
	Fri, 25 Jul 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457459; cv=fail; b=GaSvGYvO7BPqmSVdS3jXT5kf8ygMAgrp7eEFQ7jUpfXS/yEUKZkywB8BmnD6UUfSlFQEFjNLd5icmcoLEWEHm8k6TJgjRElCr3+9WJyD6Rr00N3r9KL0ovpVWGznihWaGKPZ48tY7NiRXSS1C417yf3JJsDZ+dE2Bp58kEE+lqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457459; c=relaxed/simple;
	bh=5TuUQdJ6gJbrKHQbW5f34qNihpeARWAKK9e0BiMeRKk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VTacEW9hHWmMq8ribTyhLsY6tD14w98c9ElK+yZd+iIsU4GjO1QTKqbJyyKPaI5aimAD8/ASEQCm8UpLKw8FefsM3mAgHvJZMMI9H92Sy4Gl2zRFCGMYdcIg+IuS+hpVzA+KFq8y1vsqcrdAxKF6kS5yzLbsnzcOq8VSAgsc01g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=poJkcxlw; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9zpbm1Aw8EhyWuqqCCDA5DxtioMbfTIpQmGFbz0YJ3BCM2hHHIvRxkkVMJTowb16ujYY5Qz0JKmnWG3O+tNY2W7cced4wivkegLYf5IHH6FtbC7lzT9xDI8OA2toR7LK9wUeJtGEQFIF3FNkJ+dN/eD0IuMBYM7TmVzlaLbReRR98RpcF4LFY4ILbTlWs3r00jH4W3eEiMsDt8dLO55zXL9AHr51ey0XKjW9nXkrjRSM7xK1HxX6B2LvbwXqpyn+XOuM74WJOPqVkUnSFv3NXDB9gbu+kWWpl4bHEgSFcT5XJUAgJR3DlD2mRkv4xmAeQiLUe/h6gb1u/bKEGxoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gvQMeKVRKt5SyT2XVWb5/QMB0hdaTXyCTULzgmmxbc=;
 b=TGGYrK4lfTzQ03ChVICdSLKCcpHAatfd4p89STkSZuCI3zA12dVVuToHx6vb8SMEkhJtTsxLQshPp5Tia03IjLgwJgeebu2a5mLt+cy98W0GeuLzB4V/qy86p+r23oZN46oyDihRLPJaXz9YFXf6Wm+nf+6tkEUlPh3LmJDtJn3CjS4BJ1mnSmu1MEEHfBd2BpUf6yJT8IofetwWrrgnpFCSfRdtNwdx4ZZI1TVGCtQnnDx13M+Aa0LCtBOxUReOXT7OH3RsR1/RQKzN4g9fZG3VRjCtCmEGPWNxvTMY6dQS2eK0QdS1QzXxSrmNA8p/Ve/YTflv0V+kcToixBbVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gvQMeKVRKt5SyT2XVWb5/QMB0hdaTXyCTULzgmmxbc=;
 b=poJkcxlwaZV3zV+23dlZdtWqupM8vytllFXl85qa4kzDh/8NJVYaitpYA1fSE6q1GKP8st+emoPlQhAk7jtmcLX62uvDhpLzQMIJYQozhJMjnwSsf25wGpoK2po6D+Ru0wQS0WN9OXzQkIisuNLZbhc92g9eduY1u2relX7IGdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 15:30:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 15:30:54 +0000
Message-ID: <eb4d48ae-c1a0-4e12-a367-ba8217599e59@amd.com>
Date: Fri, 25 Jul 2025 10:30:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] platform/x86: hfi: Remove unnecessary .owner for
 amd_hfi_driver
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Borislav Petkov <bp@alien8.de>
Cc: perry.yuan@amd.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20250725082735.2005040-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250725082735.2005040-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYXP220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:ee::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ec5cbd-1335-47e8-e175-08ddcb903e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUhRS2J4YzF1WDUzRzJka3N5WUJDSEp2TVAwNUV4WGRhOU1BaU42c0FwYVRx?=
 =?utf-8?B?NkNTay9ieXJ4T2lZSFNqZ3RNeVZIMjRVK2xJUWtzQ3pxSndVQ2hjNG9FL3ZD?=
 =?utf-8?B?Qis5S0RHVUZ3dEhtTDlOY0NjYjJoRXo0Q3lJN2tBTW5OYk8vd2xVWDVIY1RJ?=
 =?utf-8?B?SVNBMU9oL01ncm5ITVhDQzd1bHdHZDdGcTlyVjc1Mys3cDc1OEpuZ244bHkz?=
 =?utf-8?B?aXRyZk5CUTVFTjB4ZThjU0EyS1NNd0YyZkg3RGFtay9zQkhrUG1aeTE2K1Q2?=
 =?utf-8?B?M3RpbWJRd3p6SVpmOWU1SStwNHhBSTc4ak4yWWZGK0dVOCtFc2p0elpvZUpJ?=
 =?utf-8?B?bXdCOTlCMUdLTk9HZjZ1N25paDBTODd2V0hLT0ZGL0lneHp5WkJMZFZrOFI2?=
 =?utf-8?B?UnVMNWg3VlA4aVpnZ29ScXUyOHg5alZSekdFdWZyNjRPclJ3YzNuR2xrVndE?=
 =?utf-8?B?UGRqT0I1K3BaVEIrK2MyU0FlTEdrb2tCbmd5MFVVRktIQVphbnU4dU5uRmNX?=
 =?utf-8?B?M2c0eXlQdEJ3VmpSbklLR0QwZ0Y5dGQ2dXQ5VlB6SCt6Q0VWWjd1bmRubE5W?=
 =?utf-8?B?UTdLTkJHM1EzNi9zWTlDQ2ZJVWxmOWJ5aDhGTlltRzA5cXJFMDM2MVZUY1VW?=
 =?utf-8?B?Rm5WejNsSlQzWmVxdERrN2VXVVBVc3RzRUxmSXd1RHFRU3lmd3pnNTFoNFlJ?=
 =?utf-8?B?RjNGQlhmRDNFbjNDOGNVQzlqNER5WkFsZ1pxbUlyMGhQd0tTd0ptbEpOVExt?=
 =?utf-8?B?SlVtQlB2VDdVTFJDN3YxcVFKRVlZWCsvL01mRnRGckhkdGdkVkFFbXNBRkIv?=
 =?utf-8?B?dVUvclZEaFVadlgweW9RVlRWSmRQRVdoM1FLUCtBZXNkN1N4NzNJOXdvVGpz?=
 =?utf-8?B?VkpaUTI1cUhsL0MwZWFHclBaSHdaVGhIM0FPK3U3OS91aXZqRndtSGcvelVy?=
 =?utf-8?B?T0d5R0lYcENhanFJK1B6dVdyWUJCWXlOT2pSK2lHVmFoS2g2bklFMUE4TldD?=
 =?utf-8?B?NnRHVVA5QXZEcmE5SW9JUkpOVTN2N1kzaWhiSlQyVjlGajYyQmZaTExIMmo1?=
 =?utf-8?B?MkNSMlVOUHMzVWFLME5ZdzN1M1B3NmU3empVV2VGQTE4bFE2QmsxanJXeFpj?=
 =?utf-8?B?RDFwU3F6ZVZIWEZFWXF5cGN6N29raTFSc1dKcWtsTEVBWGhRck5ZYllOc0g5?=
 =?utf-8?B?N0VxakdXYmorQUE0QTNzZ3dab25HNkMydlFFWUF1VjBJQThOMUQxWS9kQko1?=
 =?utf-8?B?bno4eHQ5aXBNTVVBWVMzTlpVTnM3VlVEKzB4OUE0RWY2Y1FSQ0dGaU1PN0Zx?=
 =?utf-8?B?aUF1K0V5cXYxVG5GOHE5MWhBWGpSNDJXV28wM0VoaXR5eXpFajgvWndoUjkx?=
 =?utf-8?B?NWJTUEpKaDFLOGozZytsTFJ0WThISWFha3k1V0RwZVIyMHFrRk8vWDZXN3d6?=
 =?utf-8?B?UEdpMWl2cVI2STRoQVRURWpTZWRRMWw0em90WU4wSlh0UGtxY1NkWGs5K1Z5?=
 =?utf-8?B?K25IeWpBS1hPMzJHaGcyMVB1YTk2T0JsSkR4Um9zR1Fvck1VR1NSSmpCMWl4?=
 =?utf-8?B?M3hhT3FGZXBXaDhyK05kNzNRbmRRVldDSXYxeXYwYm1Ja09nS0YrbTQzdEtC?=
 =?utf-8?B?T0gyc25wci91NndSeVFUdGhxa3hpRGlINTdxcFZlZzVOS1IrWFl0T2pHenBl?=
 =?utf-8?B?NTExZU9IbnFob1ZlRE5vaEZ2aVRmeEFHL3JKLzJmcUVuakRpcGpsUkhCTlhL?=
 =?utf-8?B?Z0d1a1dVeTh1bUdDbmdZZkcyaUF5bFJobCtZYmQ3ak90Mlp5Y2JJUitwZi8v?=
 =?utf-8?Q?uRcO5OZjsdhu2vUj9Xd14Oz1RsoZlVotsgCeY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2RnN3UrODlzOWEzSmdtRDRwdWN5eHQzdzdXM2Y5a1NmeTV4TFRSR085U2pI?=
 =?utf-8?B?a2Y1ZVJNc0xPc3JxbFpvM1JrTFl6Yks5RUpQL2Y4TlBjQlRaMGhwQ1VmbE16?=
 =?utf-8?B?V2RZc3ZQNnRMcHptWUxjcEwxa1ZNWDk2bzJhSW9UZjFRTThtWDBKRHFwb01m?=
 =?utf-8?B?eFJBNzFCeEI4MnBKcEEvMDlET0pvWmxCVWZXbDd2TEU4QnVWazhwbDdTYmVk?=
 =?utf-8?B?S3RPbCtEdlRIcFRXMFZXcTVpRlVxYmsrMzZ6UjF3L2JBNFlVaXJaQzVYQXRH?=
 =?utf-8?B?V2xMQWZYNk1iUlNjTTZLRUcyNUdLZmRJUVRSRFBTMFRjcjJTU2ZhMWtKaWgy?=
 =?utf-8?B?bWZvK1YwVDV3TUJKbm8rVmVxeWtnNXpKMUlmVWlOckFoOHZXelhPRzRCL1lk?=
 =?utf-8?B?OTZHUzJsZFF6MHVhY3RrYmFyUnJieHFLOU9rKzhPTHVkMEtpNUpad2EzRVF4?=
 =?utf-8?B?U2lpN1pFb281b1VoQlk2Mmk0ejhBZ2pMdHpJVm41cXdOUDdGZmdOR2wrbnI2?=
 =?utf-8?B?Yngxc1k0YjEyTzJOcnJ2WkIzZUQ5TGxtT2VJTUxUaFJkZE0rWjRMSDVlZC9i?=
 =?utf-8?B?Z3ZnbjA0eXNFUVdkRlBReHAzeHkwSEZ6MXlrdTAvQkwvR3ZmNmM4eWlkK3Aw?=
 =?utf-8?B?V3ZzUGZEMkk4bFpwcE1Ka1p6UWJUUmwwNlhUT20rYzlYV1ViK2lKRjJMMWc5?=
 =?utf-8?B?bCtkWkd4S0hUaXRnb09XRUJ1SVhxNlhycCs3MmlZelJXL3g0NjBOcWdkRVJU?=
 =?utf-8?B?SzFOVWRTLzM3N2ZTYTB5RmdiRFhMbk4yekdhRE9qL25FNGZnbkhWQVI3RHQ5?=
 =?utf-8?B?NzY0UEVad2UyblRrekNnQVVBMnBRY0pmMjZWeEorOGV3UDRVTnkxcVhQaEhW?=
 =?utf-8?B?RXgzOWxORDJXRXhsNS9HbjlzMGlNQ0JNVXpzSnAxK3F3RkI5eEtBNnlDaFRZ?=
 =?utf-8?B?Y0I2OEl6aE9HL3hBYTJGVzhzRC9WdmlteWJ4TytPWVlqM0RyaWs0SExVRXYv?=
 =?utf-8?B?UEZRTVVwOWpaS1NnWFcyS0s5aURMVDRNbDFYeDBQWlpBdm9FOXAxcVFaUDdJ?=
 =?utf-8?B?QmdKcWlEOXliUjNXT2twL0VYbjR3YWNhSlBOR3pOMUd0QjZYREZnbTNNRy9u?=
 =?utf-8?B?YlJKS3V4cExUU0ZqN1JjUVFOeEphd0tlSHl6RG8zT0tkd0hxM2xZVEMrdkFq?=
 =?utf-8?B?eVdISGNiNUg4ZGRnQ214MVc1TEpwVTd0MHhkOFlRVjhySEtDdlIrNm5WdUJQ?=
 =?utf-8?B?Y3JSZ3Y1QUc5Zy96VjFiQThTS21Fb3F5MDJZcC9tdWlleEZlVTl1blQ2V0Jt?=
 =?utf-8?B?aXFDVE9oR0NwZ0dxVnBXVHV1Lzg2cFBhRXBSaU01Y25YSHJtbVVsVVlPOFlo?=
 =?utf-8?B?RUpNT3RxNld0OXh6VzdHcjkvRmxOQm9zMWpEUTZwamJVTUJBcmNQazhZb1Rr?=
 =?utf-8?B?aHp0OFBnSTB2ak80aHpMQ3ZKZVFsQ3BpY21YKzVqSnY4SVZ6WGZuYlVZZzdV?=
 =?utf-8?B?K1NCSmJEYkVzSFo3cGtnYUlyU0duMHJIR1l3UkdHSUNlY3k0WWxLTldMWEQ0?=
 =?utf-8?B?TXRCMlNmZDRTNWFsdmczcUJVSDYzbkdLNlZRa3UwejFKWUtqQ3lmd0hyRURV?=
 =?utf-8?B?a1FmYVBjajllWXVBOHo1aTBac2M3SEFFWUhVK1ptNUduWXVkSXByaW5jZVJm?=
 =?utf-8?B?Ymt6VWNuQWcycXVUQm9sdTNScGJuTllxeVhrRmZocEZnbDRmUER0VWhVK0dm?=
 =?utf-8?B?ZUx0VlF0QU5TNnJUMThoZFZUeHhRalhkZFZXemRjUjZIa09mTkF6elRuSGsr?=
 =?utf-8?B?Y1djREFtQStVenhjemFSQ25BNnJEZ3JrMHhtaUJyRFNZSGl2bmp3YTREeURF?=
 =?utf-8?B?UjdMT1ZpSEN6eUM0cGs3ZlFtOEdhZ0NacWV0Y01DeW9pYzYxMldXWFF4a2xi?=
 =?utf-8?B?TDloakFqWlErNC9Nc0VxY0drTUwybFR6WU1UcEcrTUhpM2gxS3I1ektraHNx?=
 =?utf-8?B?OG4vMGVZN1IwcElKVTVaNVRyRy83RzIzdHJVbVdCU3IrUDRmenhUMFVUQXJG?=
 =?utf-8?B?Mk9ZTTVkS0F6ZUhzcStRM0dnQ0s0MURtZlpiRkRuQU85ZmF6WUJjN0l2N0dV?=
 =?utf-8?Q?sRCedIp2E+ZxsvAtIyC0ebV33?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ec5cbd-1335-47e8-e175-08ddcb903e9f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 15:30:54.4429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyPS5XGcORChZyBzCBOIRruyc9elJMsdMJdO8GyDgQnGXhtGtmTbZd+LptyHoLHdjpcMo6n08IbLTdcNN277Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824

+Boris for this to go through tip.

On 7/25/2025 3:27 AM, Jiapeng Chong wrote:
> Remove .owner field if calls are used which set it automatically.
> 
> ./drivers/platform/x86/amd/hfi/hfi.c:512:3-8: No need to set .owner here. The core will do it.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22940
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/platform/x86/amd/hfi/hfi.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 4f56149b3774..b633363ebf70 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -509,7 +509,6 @@ static int amd_hfi_probe(struct platform_device *pdev)
>   static struct platform_driver amd_hfi_driver = {
>   	.driver = {
>   		.name = AMD_HFI_DRIVER,
> -		.owner = THIS_MODULE,
>   		.pm = &amd_hfi_pm_ops,
>   		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>   	},


