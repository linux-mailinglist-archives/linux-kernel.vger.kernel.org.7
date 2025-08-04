Return-Path: <linux-kernel+bounces-755544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB05B1A835
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 489C07A2A71
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E3B28A707;
	Mon,  4 Aug 2025 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PTm3b/HI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F454673
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326414; cv=fail; b=Hp/SNYiwguBD5Xd8BdXkiF79veAzAI0jidR79ZKyaAswDGmLf3qZYcxBiyIaRkpR5dxu5sAhhpjuShPIotOdERq4cfONNX5Um2sa52jH23P+eS10+VqNIc7CoQcmtNIogYCPMEkb99F/DtQPBwzDBcHm3KB15OSYWqKEPG1TSbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326414; c=relaxed/simple;
	bh=zIyN+Xo26casjHXiDe54jP2KVIHWFOSs0thr5gnRPLU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qAySTzOYbh2/DrfwzZAlVSCnM215ewp2bNCnjHnM78+tCHB490BwhYASwUyzcfaDC/Sfb6flxcli1gHONO9lwRnatqKLdVD7STpGFBBBkIqh9gXt6bAld74iXpDJciJPbf+yOkp8EIN3hAYLrBXeowUwUxL1Bfb0C+na/rTzpr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PTm3b/HI; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ajj7gJpD693w0k3aBi3fXIUTJ6cIAbmJd2S8UgJ2GzLBMZl7TIt6tOLLdesoK8Ohj6loC9t4OigBRw+2Q/eERHPeZQ/CGdCU8YfCGF9iP2j7jaqjFWgl4aVOUEX8ZAX8mvPupjziruBIcSLFUPcdf0LOD/Yc/n7NKIe3dnzBsgw3JLCHGGcPTq+wR/BgqozA7AdobM5Bf2BtMh2THXKGM1pUot8IIEzN92OOT4GVJhu+ctgMeRqiatRrPLighhdXzUwF+QBwrL3dpxOLZKM7BjEakttLQX3i147VuC5eAVC/x5NPXaXfRHHDC7SKdiwFbTnkDQfD5UjcfQrsBx294A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwdGLzbJzCPrfygqernGK4ZFupRdAkOiPzEuWC3ut2M=;
 b=QZ/VTp6ECLUS/TWeV95xTujbK39zhAGqHAd57+RIY8rORpEqm0Rc8BIJ6zOqcWVeT3J3igoYj+0Ll1eNnhAB8So/CtJ7N5QCHKrDu2V+GGVkmTi/VRCVmnYy9/wZDT+UWEDYYFmhx0MzDKM6zIEm//ci4M7zlRh9pDLEA/dRbU8qeAdCZoSoBm+uC11lITIkY/2DDD/W/upWOVmiDJkL2bYyCWvITMjlCtiJlVEkx9VGSm6n3IlsrLzX/2Pdv4TPVIa0lZUV/f2NZHbCt7tAGl/fxgGhVn/R62cCT3pjCN3TgEt6YjdeFXwoPy89NRHb7jUdwzwVOuWoPvPObtebFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwdGLzbJzCPrfygqernGK4ZFupRdAkOiPzEuWC3ut2M=;
 b=PTm3b/HIkRj2zJeUuXZtwZtXMB3OsNEK6goryKY+lf2gIGUOC02LwMLvGGkJIx8YrKbYifIY9NYeoQo7GYTiJ002/AUMnL2xwSpgY4AbCANxbgJzOMt3e6BNz25K9s6v/pvmPZ8CQWXBXEWjtm4XnmGUnyrD9yHaPoxUD89DMS7i73GDp4SMLnqk67wz8pc41JkJBNgCgiwbwmd/wrMrkQtK3/UYvZ0c/w8JMYPNFAAZqKsz8jz+SA1cH3AdeIsqiv65rSyr53cvMErVLnVAIgBpVSTR4OByb76nCArUClv1bxhYmIeCo+rbjxvs5o1vd9svADsYVFlVfsN+a8yxSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.18; Mon, 4 Aug 2025 16:53:29 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%3]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 16:53:28 +0000
Message-ID: <7b909125-103d-41d3-a2ad-5c96a15df672@nvidia.com>
Date: Mon, 4 Aug 2025 09:53:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 25/36] arm_mpam: Register and enable IRQs
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
 Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-26-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250711183648.30766-26-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1fe560-46b0-41b9-e883-08ddd3776fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUUwdllHejlWOFBacWFXVGw3d3FNMUFrMjlLeW11akkrU25iajBBRlhWY1Iw?=
 =?utf-8?B?TzNNUDRyTThNM0VlV1Njb01NU2gvVTlDOXZwbXZWM1FkMlBKcjV4UnlkOXhi?=
 =?utf-8?B?WFZuTW9yT2FMWUlCRE02OFM5cVpCK244b1Iwb3c5MzVtNGtqUU1QNmdjdTZ6?=
 =?utf-8?B?b1Z6Q3ZXaFNkazBENlRIYkRqSlJXNmNyQ2RlcWJBOGlzRHFhNW9rL2hhYnBn?=
 =?utf-8?B?T0ZmZ0xyTzFZditJMCt3NjRTdHNEdmcxWmRBV0hNV05hV0lTMzNlVy9nTlJR?=
 =?utf-8?B?SStnRy93S3YrKzJVU1JDR3JIWGkrTHdsUzQxbHhULy9mTGpOQ1RxaEdNazRQ?=
 =?utf-8?B?V0ZsWlo3b1ljdG1aVGpEL2FIcDRKOTE4THBkZ0M2T1kxWlFsTzI4MURoeTRk?=
 =?utf-8?B?MHBHNGJJWHBNY0FCZlB6SnF4eG1zaUtyUVg3bGMyWFdISm9veDJVOWJtYlk0?=
 =?utf-8?B?U2NIZjMwenFBcjFwNGl5MFd1RjJWd0R1QTJaUG93OVFVaWIwN2lPV1NwN01S?=
 =?utf-8?B?SXNESmNuVXFrKzNuY3ZYdjlBVjBWV3hPNHc5MVFCcWtYQUN0VzQyNVFad1RM?=
 =?utf-8?B?elpaVHhZSzZPOERkUUdXbVJLV2NlZnlmMTAxZCtrWHBHcmFvamxzMEZObkhl?=
 =?utf-8?B?U28xdEJjRW81clNObDIraFpNM2lFSVR0TUh5UkRKTmJ3S2tlemtDZGE1Wkk4?=
 =?utf-8?B?VFBMenprbzBDa1JVZ09MdEdVM2Nkclk0NkdpdXlZSXd0Zm51c2g3VXhudDJL?=
 =?utf-8?B?by9WOW90dzZKZ3grOGZ6OG5lTFhKQ3M3QTJCaFVHSFJLSlZyRHNOaVdZTTR1?=
 =?utf-8?B?UWFVaEN6cW83ZVFiL2RKaVRjb0t5MEwzY3IrUUVBTTl3NVZGaWRPRUN3WTY4?=
 =?utf-8?B?RjR6Y08xclh2NGFpRWsyMWJEOG1aRnNsUlR5L0RCYkVkZEpxQWcwQU16akUy?=
 =?utf-8?B?YVhxdTJUWkR5b0hCanRYNkh1aHY3dHduOHU2SEUvYmRYRTZ5SklRZm94c3Vi?=
 =?utf-8?B?ZmdMbXZNM1JNTEpRWUVvaVR0WTQ3SEc4OEo4UEw2Q1o0R09yaFdmNVNXeXNX?=
 =?utf-8?B?OXh6dUhBS1FBVHU4R0piUjVBdktVQ2lpT1NyaDRQRlJCeEJDUDByeS9kTHJP?=
 =?utf-8?B?Ym9ESlRKbE5Gb3d3ZEloRnpkZ1p1SXhtOTRSdzhqamtBVFprd1pleXlCVlY1?=
 =?utf-8?B?OEE0NThNTVM2enFJcU1ETVFmU0c4Znc5NExFU3IrSFMyb2k0NzNycysvTkpp?=
 =?utf-8?B?MWRJbHdWeGx5SEMvYURxV2JOellJRkg0Rk1XeGorZUxZR1VoYk1zRnAyK3Js?=
 =?utf-8?B?UWwyQjRBTVNFMnQwVnp4bUtxa1lxb3NTLzVnbjR0Z2k0MmRORlp5ZjlkZ2dO?=
 =?utf-8?B?S0JzOHE4TEViNHJvenhYeE5SOW5QWkVaU0pSUzdOdnpGckhuK3U3ZFZHSllI?=
 =?utf-8?B?ckc2TkpIOWxtOVpPbXoxSG5YSHRQT3F6VGhSVUk5dTRSWFpSUkpEZjZtYWRq?=
 =?utf-8?B?YUl2MitsRzc3SEdoVFE5UExmNFZod0NSR2RuQlpaSUJnZ283ZDNGNngySTBQ?=
 =?utf-8?B?Z000b0lhMG9KK0RYUVVuMktuaENRMmJ3ekJYRjRiWmlJRXpKMU5NMEp1RVor?=
 =?utf-8?B?dWNpampBRXIrRFlid2ZTa1JnMi9OSGNnZEt1MUZ0enduN09vS05qNmVpRkpK?=
 =?utf-8?B?WUI0aXVJbHQyZC9tMW5DeXh3MVN6ZVczcWVGdXhTd3kvcDhlakMvRTlnMGE0?=
 =?utf-8?B?T3FxTHorUjFaMlYybjRxclZvWFNYUnhPRThxMjVNeGVSKzRVVGVnR0crbWhu?=
 =?utf-8?B?WFZZclB3UG5DYlVuUnYwMGpnN09iamN0bUFMVzYxYjBCdms3aUlSVWZLNGRT?=
 =?utf-8?B?OGt1YWxYSTVjcXBNcTd5YzF3bHlxeXE2QUxzZVpHZlVTeFBWWStPU1plNW1L?=
 =?utf-8?Q?egUsUOaqdYU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmJ1bHUrWXBheHNFMVlFdnllaTBYbUFXcXBHcHZrTi9HbGwraXJQdzZiU3ZN?=
 =?utf-8?B?NDRTYXRXM1pDSVRJdUZkYi9Yb1ZMQVh3aVVlN1RmMk1vOWg5MjZUL1VtVlhh?=
 =?utf-8?B?U3BHME4rZ1FKN0t0aXBXeTF1YnJrZlpkYk9lcThTdzR1RXI5WlkycGt2SjVB?=
 =?utf-8?B?ZFFzQS9LSmRWS0ZGQnIraGZtZGgzR2s3eFpUV1IvSGt2dFNJZlAvVFlhOUdx?=
 =?utf-8?B?Q3lOWGI5eVhsRkRadXdCcW9Tb2w4bjFOWlBaaEJSN081WVAvWjBoQTlSY21p?=
 =?utf-8?B?SURmbHg0Z0NWSDFMeGg2MjhTQlR3dUxqQzVobUw0bFR4VGtQaEsvUVFuUWtr?=
 =?utf-8?B?ejhrenU3TWhmZzVNZ2diOXUwYnhQSTBXRm45Y3FUalBXeTh3ejRrQVlhS3o5?=
 =?utf-8?B?U0ZwTysvWmJzVVJNN0xqK2xObW9rVm5DUUorYXdJVmNMRktqc1ArSVF0cm9j?=
 =?utf-8?B?T01lT0Z6cGdYZXFteWtEZS91TEVoRC9NM2R0MXN6REZMWGh3a1I3R3hQZHRk?=
 =?utf-8?B?L0pEZjBzRWhvSjVUdmVXcnhoQ1dHdkxueUdVeWcycHV5WTh1SDhNY2Rzc3kx?=
 =?utf-8?B?UUpJcHF5VGt0WXhLdmdqYi91WFJ4bXdZZXRVZ2I1bUV1bXRId0NVelVicWN3?=
 =?utf-8?B?UVgxcXBPRWlBcW1iaUJONzV6Vm5ab2hvdGdxVjc1NnpkWEk1L0JpNWNxUkZD?=
 =?utf-8?B?eGtJUGVmV0l2L1dodWNNY3VkN2V1WDduUmRjczRMMFVRWGMxRzM4N2hoZ0Fn?=
 =?utf-8?B?T1hDd0YzZWdGTnJ3V2VuSW9xS01OZkd5MEFGcU41SVRFOWpHK0xoRmNGcUxp?=
 =?utf-8?B?RUlIYTBZNkFkb3pGcnd4ZHdLUURjSElsODQ0ZU1JYW9BR2xLeWJqeXNGVlZX?=
 =?utf-8?B?TjVLVkttZ3c3ZlVhWW5OWjAyK0R3UncvK1ZYRnpMMGRoakZUZ1JaWHhhZ3Bq?=
 =?utf-8?B?cGFvaHAzc2pucG1IQWRheEl5MGtXbC9LdkJhQ3liVDNWeUxCWGtiQmk3ZUxX?=
 =?utf-8?B?SzFHTlV6KzlpTTRVeUw1a0VwVUFnU0h6UVNSSGQrb3REV1pmQXlRUHdkWk41?=
 =?utf-8?B?VHlMblFqWlZER2dleGhyMTdtWnpDM1RSQkowVzVZbEZoOXNCNG1BUlVHUlR0?=
 =?utf-8?B?MmdZa2EvL09VejRPT1I5VEIzRTZKTU1rdFJaQ0c4MUdFMTZYNVlIYnhCKzJK?=
 =?utf-8?B?V3ROMWtnKzBFaGRSUTlvbXg4bFBBYjBHRHhrejFzZmVRODltRXRZWTUxWGVk?=
 =?utf-8?B?NUdrVjM0S0plUXRhWmpKMTFzcEZEeFdIdjZPU2hWUG5YMHVRcjlvcG9GSHk4?=
 =?utf-8?B?MFMwc1IyMWI4eUVudFNKRlFtenlxbUlnWDc3RzFIU0lSdUJNamF3UWZrS2sz?=
 =?utf-8?B?YTdDNmlrQmlPVVU2OURsWnljaVQ4NVJmQTJIaFpxdTF2OGVNcHpxMnc4Zlk3?=
 =?utf-8?B?K2RzVXErQ1hEQ3AyMnV6RW1wRUVPb2ZQeTVaQkZONDdKVytLNUp3dTBsMnhm?=
 =?utf-8?B?c2pVbi93aGZ4Zy9HOFEyckJLa3d3UWtoQjBwK2JnR2VNWDJNUUNIWE0wT2Ix?=
 =?utf-8?B?MWdYYzh6d0NWSXpZbHVxYnp2UU9ZcHdUYmFUcVBCcG9LOTYxNldYc1h1R1hj?=
 =?utf-8?B?M3VGNEpYenpxMytUT0RxS2g4aHh5bGlPWFBmLy9PT2c3QXdoVjFqZDNZSGJm?=
 =?utf-8?B?RGlpWmRLR2JxTnVCSWJwL043RDNQcDNrUGE5NktnaGwycXlLWUtyMDl6d3Qv?=
 =?utf-8?B?YmRldmUySUd0ZU9oVHdQNFA2VTRrU3BHU3FzbUF4RW1HSEcwdkdsbW5NdEsy?=
 =?utf-8?B?YThieTJlWGNLZEZBTWdlVGhBTkVyUXZjVnNaY0U4OGFmZEl5Rk9xYzlYU2lh?=
 =?utf-8?B?bVF5RUsydUhhMU5HdkZJYWlHVGszNDhGVE1LWFdNaTlyR1NQOWo2cHRJNkg5?=
 =?utf-8?B?RFFtaldaajNPWjhPOXdSd0ZRdnl0Y2o3NStIWEl1dGZTWVBVMVJaMXYvbkls?=
 =?utf-8?B?ZmZWWWRvRm4zSjJ4WEViNEpRU1I1RGJUWm5PWFZ4ZkVsYjg3UUdNeEp5OWkz?=
 =?utf-8?B?TkxmV200dG52ZXhLSkxmQ3ZMMzllM3hiUDNNbnZlUjM1elJtYUNhZThiNGFW?=
 =?utf-8?Q?SjwzL90Q/9515UcEEtF5T5R+k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1fe560-46b0-41b9-e883-08ddd3776fba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 16:53:28.8684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWXO7WHrQeK7H9xSOQnpxuq/DpfXRLsrRoXN8CyCgdLonkAOS0M72WgS7zUuWjZfmplth/U0NcOdVK6LeQfy4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383

Hi, James,

On 7/11/25 11:36, James Morse wrote:
> Register and enable error IRQs. All the MPAM error interrupts indicate a
> software bug, e.g. out of range partid. If the error interrupt is ever
> signalled, attempt to disable MPAM.
>
> Only the irq handler accesses the ESR register, so no locking is needed.
> The work to disable MPAM after an error needs to happen at process
> context, use a threaded interrupt.
>
> There is no support for percpu threaded interrupts, for now schedule
> the work to be done from the irq handler.
>
> Enabling the IRQs in the MSC may involve cross calling to a CPU that
> can access the MSC.
>
> CC: Rohit Mathew <rohit.mathew@arm.com>
> Tested-by: Rohit Mathew <rohit.mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
[SNIP]
> +static int mpam_register_irqs(void)
> +{
> +	int err, irq, idx;
> +	struct mpam_msc *msc;
> +
> +	lockdep_assert_cpus_held();
> +
> +	idx = srcu_read_lock(&mpam_srcu);
> +	list_for_each_entry_srcu(msc, &mpam_all_msc, glbl_list, srcu_read_lock_held(&mpam_srcu)) {
> +		irq = platform_get_irq_byname_optional(msc->pdev, "error");
> +		if (irq <= 0)
> +			continue;
> +
> +		/* The MPAM spec says the interrupt can be SPI, PPI or LPI */
> +		/* We anticipate sharing the interrupt with other MSCs */
> +		if (irq_is_percpu(irq)) {
> +			err = request_percpu_irq(irq, &mpam_ppi_handler,
> +						 "mpam:msc:error",
> +						 msc->error_dev_id);
> +			if (err)
> +				return err;
But right now mpam_srcu is still being locked. Need to unlock it before 
return.
> +
> +			msc->reenable_error_ppi = irq;
> +			smp_call_function_many(&msc->accessibility,
> +					       &_enable_percpu_irq, &irq,
> +					       true);
> +		} else {
> +			err = devm_request_threaded_irq(&msc->pdev->dev, irq,
> +							&mpam_spi_handler,
> +							&mpam_disable_thread,
> +							IRQF_SHARED,
> +							"mpam:msc:error", msc);
> +			if (err)
> +				return err;
Ditto.
> +		}
> +
> +		msc->error_irq_requested = true;
> +		mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
> +		msc->error_irq_hw_enabled = true;
> +	}
> +	srcu_read_unlock(&mpam_srcu, idx);
> +
> +	return 0;
> +}
> +

[SNIP]

Thanks.

-Fenghua


