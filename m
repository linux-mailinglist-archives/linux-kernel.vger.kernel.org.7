Return-Path: <linux-kernel+bounces-600354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BD1A85EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 15:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5F53AA085
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 13:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A22192B75;
	Fri, 11 Apr 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ivgc61Gf"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE117BA1;
	Fri, 11 Apr 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377953; cv=fail; b=cOZFVv+jOD9/vtJfwwd+Oo5ZeyZDylBd4XpCfQ4NLVeBRvaINu59osMX2q4vsIcqUSMadNtTcP4x2dNv1du8Rwl2eEwf+Az+NVegl2KmKyK5Dd512eCbmgXNzmqQhbZKEym8/QaVGskNIkjqo0YGXZctz2KBibITGBoErm8zYho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377953; c=relaxed/simple;
	bh=EKLhJihpxVEWhZU3iThM7BydHsM8ncaiaiEeWpIcio4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aTVyGJaV2eMElJhRXTlH7N+JeY6GQyvAABmWBTLr1FvZxZsrWHvxQokIcNDF4bmBuiuszRXVj9c0H+t3+hboGbVTh/0quiWoGPuZzNQSPPBcFj9Ia37MbvjEPjZ7C60fMVWrjX8UFThpEsyI6xobRGUIveIvWWUNNmQFpnzTgJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ivgc61Gf; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipVedHWDHeG2oBrmE+Yay2uX2CVyWcbJemYTT7KXFSjv7KU9CEr+XLOADrVikHVphjf6DTGrBB6kg5zWkg9SdeGmmFq9PaW4AkzbqjszN1kpyzvwNyqc5eB1Po3eNekg4ya9ysBVli3S/qrmL6VAVBGLPJ0qj7C0HQKMe9lEfO/puJd4j5nbRqIGVx0emUB2aiOLJUhgWX4sN/ej6tnZZ42zbD7vBZLd7fB0/UZioL0CVKsZuIitAQEhhxBfE9fcsUcipDiweqJkyOJ2eH22GFC4r1yE0xogqBRXQvHQugXpqMcCt0F56NOXyScwyXZ3lTl87NsHkRxBF+fyOTwYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9mPBLbebNh72HLPXndAm08yPR4fseXddDz51aCX/Yc=;
 b=mokhRBPoBkR+NLi1gxNI0huUm0wmxmgOsz2k4pMLEkgoYCVWX5A+EwIfuVLk+LRCHGM9aiNIlqSfsxmAmdynlt2nBFlXF2Rtv3KET7o1mv5t6Q6gH2tgSioc39G9K5oSW++gFYdX7zeXWRfI1RDwGukOhZ17S8pkG4vaVBJvUbtrRG4Q+LzhQWbQA8ifrvVxTNorlfaoiJFb5z22/dtz8ACFcskgf96P6va03155YUgZ0ddMA6EUjaiZq8uovoFH2m/N0WuFlRweR/aFjmPqJKHPpjQWZkMebk56g6C13SUDIqnDzsormHmmmsXvyFOYX+NHqxRQH+9ueCLh06R/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9mPBLbebNh72HLPXndAm08yPR4fseXddDz51aCX/Yc=;
 b=ivgc61Gf0MHTEr6oTOpczfXSHXXxYKCGkm/uO/Z+nuk2h36+piW/xUmQEDrSK7eK7YB/pWNMrABBiXtoIJkcnDaEErTit9hVHH9g5xovXtF1s4MMP8e0qVif0iinCOFbMC+IGnR7shFjY/DCXjwx+ptQqqXY1SuZvi5uq7cKaGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 13:25:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 13:25:49 +0000
Message-ID: <65b5bb62-4552-43cd-acfc-bf3bb0fd713e@amd.com>
Date: Fri, 11 Apr 2025 15:25:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drm/syncobj: Fix leak in
 drm_syncobj_import_sync_file_fence()
To: Rob Clark <robdclark@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Rob Clark <robdclark@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <c715ef30-9d91-46f3-8a0f-1039f3d25e7d@stanley.mountain>
 <CAF6AEGshmGO0AAD3ndz-gN32r+xf2u=7gyf9aXbkZyb97AUXdA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAF6AEGshmGO0AAD3ndz-gN32r+xf2u=7gyf9aXbkZyb97AUXdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 251d5dc9-957f-4a47-cfb0-08dd78fc5fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RldCWWNHVThzaE05eURsSHdNRngrWVlwY2xNL2UwZmQ4N1lhNVNhczRVY2Ix?=
 =?utf-8?B?T2piUzMyVVd6WGJneC9FY1Y4eTluMWJiVkwwUkxlekV1ckFUQmJVNGY0SFZx?=
 =?utf-8?B?STZ2RkhtOHhCUStBVER2cHduZDdqVklzRXY5MWxWdEF0RTZieVF6b3pWeUVX?=
 =?utf-8?B?MzlzRVB5eEswbE9MVXhQYThkYVdxU3M1Y212ZXNYNWZudmtCNzdWZXpTWUsw?=
 =?utf-8?B?akY1d3IvWXRvS1NxTUNHZzNPaUxMU2JKUURMY2htRm12K0g4VnkxYklOSTFt?=
 =?utf-8?B?UFRYWE5BWXBlYjFrNEdnalpld3VPTjZDdHNKeUNnMVZURGNuajN3ZFJ3V0VD?=
 =?utf-8?B?OG9yUVIzallyOGlLTEdOSXErNDdMaWxZTHJKUW1VUi8zbklQY3FFUHlKVGk5?=
 =?utf-8?B?ZlBqMzlBR1Eva0xmNFBJaVdTcm5ucWlxbDhFQmoxdWNMaEhYYVgzNnd0S0JE?=
 =?utf-8?B?UmxCci9MRWR2bTlNZXVMaEc4ZCtXMHVuRjJuNDN5SFJkUUtlWTFDT0tJMkxB?=
 =?utf-8?B?VHlrMzdqTWVtNmdHQVhXNzhSU2o2S2d1eHU2ajR4ckpWdGM1dEdaejNwNWVR?=
 =?utf-8?B?R3B4VUxubG5uU3ZCRkU1ek4yM1RCQ0NTb0dLbzZqWmsxTkZaUVdDTkhMclM3?=
 =?utf-8?B?QktWdXA2UTBnS0ZIdi8xaEhvSnMraEFHT2NyNTZvZGdpQ1ZUVzdnVlpZK2RH?=
 =?utf-8?B?dW1Lb1lyTFIxNVJQY2VMNFZmNXZKMTFKV20yc1hGMjRkZ2ROZmxhZS9oTTcr?=
 =?utf-8?B?eENuRWZvSnYwK3FWMGhVVWxlQ1MyTktKSjhwdlQ0UkhSZmY0TG5ldmp4NzE1?=
 =?utf-8?B?bVplSnMwTCtqSnU1VjJDQXNSam1UQ3pjQ0czMWt4UHBmd29yR1BqUmg0R3NR?=
 =?utf-8?B?RnE0SWVDWFlqd2lHVWQ2KzdkRFlCWnNYODJJS1RrdDY0cjJ0TERKYWc3ZzNk?=
 =?utf-8?B?WlJUb3UwbWpqdUR3NWZCbDBTS3NmYzZKL2NsdWJ0QVJDbnFWdEkxUjM1ODlr?=
 =?utf-8?B?bUd5bFdwMEV6TW1saG1KckpPTlpEWW9OSWxFbTk0bG1NUDB2MzY4WHdEOEZS?=
 =?utf-8?B?ZWhvOGxtM1A0L3creXhhN0lRc1dJMTFkOTlTaVVMY0kvdXZFRklhQm5DZXdZ?=
 =?utf-8?B?d1d2QjZ1WVFvdjdnR2ZjenVQa3dpRjdSYXRrL2ZDVWNtL01YZXNqcUZOR3dG?=
 =?utf-8?B?ek8vSlYyQys4Y2ZhdHFydG03K2J3cEc2UTE1V2V0cnJiL3k3cmk2cHFjdUU3?=
 =?utf-8?B?Rkh3WWhVVWErbFlLQWtFVkE3YWEwV1IzQjRxUCt2N09EelcwQnNzazBjQ1ph?=
 =?utf-8?B?aHlkSUhnVkR5d1dQNTYwM01FeGxNL3dQb2RXRFJGQ3J2WnlDWjNFbDVtWk9G?=
 =?utf-8?B?L2ZQd0xXWndRdHp1RWRxRTNSb3pzWVo1R3hqNU1nUElYcFk5Y0VEQTRnL1Vu?=
 =?utf-8?B?czJkTTRSWUtPQ25MZDNwdFVFTnlNbVkrSEhVNFQ1TGhlcGRNM2ExUGFLZ2JI?=
 =?utf-8?B?UnZtTVBJRjdWVVgwVTNWTEdHRmVXOUJEbDEyUUxIRXRZRkc1NmZtLyt2aE0x?=
 =?utf-8?B?MWxUNXFZZVh1K2ZjQllqMmZ4WG53QW5Ldldna0xMYWVDK09qYUhDRUs1aS94?=
 =?utf-8?B?azJRamd4K1hLa0Y1WDdHc1NGWnNVbTBZYU0vTEtBUWVuRVdES0dTUDRYei9n?=
 =?utf-8?B?TURVNlo0YUJZU1lUQysxQlhvNEFJdHJIaVdRQ3ZGb0ZOTElhbnpXdWZicm5G?=
 =?utf-8?B?amJHcXN4ajFpV0p2SHg1YXozK0QxWlFqVEVMVExnVE8xMytOaEw4RlB0RXBR?=
 =?utf-8?B?UU1kblc2d2RGcVJZckt5cHUyaDBsZStwZTFnd1FnbWZpNTFqczUzV3FObW9l?=
 =?utf-8?B?cWNiTWxqZUVUcEplLzlNbGFIYnZOMmdIZHJXanZ4MndLUzkxUWw2UDFpMm1m?=
 =?utf-8?Q?WMnIbu/qeyY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2ZldTJRSjJBcWs4dGhFYjRYajhJMzJQTHpRRlFTQm1WRTRVVmJHajdjQzhM?=
 =?utf-8?B?UENraG1QRm9sbHZkalBMaVdzNW1pbTkxTFNXWWlKaHh5SVVFOFVrb0FyYTgz?=
 =?utf-8?B?T1BBcFplOGkwK3Axb3BmTDFWSnFESDUzMkVEZVdtU2R6Y0ozZzdoU1hObHVm?=
 =?utf-8?B?SzNGd1A3OUh0bDEzMGppRmNZK3VLZ09YN3VwMlZZcHFVTlBWME9qN0NjRURa?=
 =?utf-8?B?d0xrVUtid1BJZStuUHpvb0ZoVTVWTDRJd3lkcnJkQWZ6UVRrS3ExNWt0K1RN?=
 =?utf-8?B?cXlzLy81dk9BVFcvbkxyaUlOdTdLVzVSVzUzSVRLSDhLcENvakJ4OFlRcWwv?=
 =?utf-8?B?Mkt4QTVIZ29kblhtTzFmSTdDTzJ5UHdYVlR6dW1VdG9LSWswMmNBNHpuNTFU?=
 =?utf-8?B?N3cwY1MrMGxQRDB5NTIya1l3TkJmaWVSNnNEME9RMTUyamNiM3A5U1llY2lC?=
 =?utf-8?B?dS9BQkNxUzBIQkRtcUxvYnhhazBnTjEzSGtJMTBlcEpRUmkwU1ljQ0NaNmxT?=
 =?utf-8?B?L2FTVGlyMWQ5Z1RkMDEvUitvYWo4N3c1aGR4V0lCRkdZQW1hOEtOVmlzZ2pG?=
 =?utf-8?B?UTdGeHdSOFYzQVhZQ0F6Vjh3K1NWRFRKUXJQZVlRSGhoK05lZXIvREs1YzN4?=
 =?utf-8?B?ckhaa3BFNTMwLzkxS000T3ZMY2ZJS2Q2alpRc3R4V2hTNXpITTVUS3cvK2I4?=
 =?utf-8?B?d3VLbmIrcml2aCs5ODk1b3FoMm11ZjFpa0ZWL0dSNWNDR09sTWNSNURHS1Vk?=
 =?utf-8?B?SFRwQVN5cHgrdy9zZzNrZUhoOVMyY0lPbk96OXdBN083d2Rrb09tZVJJODhl?=
 =?utf-8?B?NjkwZkxrUDhMM2tiMUNiYm95Wk5QVWNUL08rTlhhb3pCQitzMDRxODZYM1FY?=
 =?utf-8?B?cHg0d0NETklDQnN3YWg2bDlCZnVRdUF0WUUyeHVxN3liRElZdXBNM1JDRVZO?=
 =?utf-8?B?Z2xoaXljSVZFbEtGNHFnV0xTRGxqRGkwaDZWNjNvZWNMU1JIY3gzL2ZIdWtZ?=
 =?utf-8?B?dU9iNXNIcmozcy9UajJXTm00a3Y4S09MYitoSTY0VDFJUmc4MzVESVZDTk1D?=
 =?utf-8?B?QlFoUzQrUVl0dWZmMzZOSjZnU3BkUEdCSlFQL0h4NkN3Y1NZRHZ1aFAva0VP?=
 =?utf-8?B?Y2E0N3orZ29WMTlTN243czdhWVlodVZ5Ky9WbGpOVkw0dzdORWNCNWZJSHZw?=
 =?utf-8?B?bjNMZjRudVZRUXBMek5vZ0g4cFBkY0NIZnU1UHE1eWpjZGVyaitYQXNEZFQv?=
 =?utf-8?B?eTNYOUkzT3VHcGlFcnZnMlk5cUpScU94VkZyMG1zd0VIMFh2SFgvUnRnaEdY?=
 =?utf-8?B?WG9ySlhRMzdYUVBZUWdzT3N2Q1hEQlRBNUNvVUt1ZVF3MjVNSGZrTitZTjE2?=
 =?utf-8?B?Z0lydUpCMi9scFlmRGF0ejNrcDZWQVgyR0F3YzVsd05rS1VrMFFlRnBtcndl?=
 =?utf-8?B?NXhWNmk1L2c3dUZNMHdtZk0zTldsYWpuTjZtdnpiV2pKaTVILzdodGs0U2Rt?=
 =?utf-8?B?YzNSK0R1dXY2dnMrbERybTlqVWQyWE5oUS9WdDYxbW8vWVZlQnI5UTlRL2ZV?=
 =?utf-8?B?T09tUis2Q0FhTFd2c1ZKc3JjKzUycnQ5YnQ2OGJOQThabkxxYUVvWGNBQkp5?=
 =?utf-8?B?U1p5VXRBU1RibXdVTk92RHpxeGJxMXZEemRCalE1RVBIa0RMMUFvZ1JQNUZa?=
 =?utf-8?B?N1lkaWMvUVZacFN3am1nbUd4RVpmU2dhWHV1aURTT21HVUhJcEhwWEI0bWIx?=
 =?utf-8?B?TzV5M0tkOXdqQ3g2VFA0OVJrZTNMb2lnZ3hSY0FjemtFQjJJY3hkTUhMN3FI?=
 =?utf-8?B?T052Wm1XaGlsdGZRemh4NkZ0S2FoZGZwNkdoYVgzcFFpU3BPSTl1V05td0Ew?=
 =?utf-8?B?ajBuVEloL2xRaXhSWEE1andYZFJPSFBIWVdYZENkSlhmZ0lhRjl1YVBmUENJ?=
 =?utf-8?B?a1UyRFZkcmtvbVk1L0krN1FsZUFwYWtRNUwrZ2ZGNlJkNm9rMk5uelRyTTVz?=
 =?utf-8?B?NEZHcVNFb08xV0lxYkdZZVE5OVpwVlJCY1BBVzgxdUJUalNyalVrV2ZHZk9l?=
 =?utf-8?B?eWVLL0I4Vzh2UmpkWFl4VDNUOE12NnF6WnVqektMWnBnY0JITVdGTENtbHZP?=
 =?utf-8?Q?HsIno3LrP7FCmwde8cULClUzG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251d5dc9-957f-4a47-cfb0-08dd78fc5fb1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 13:25:49.1489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdeQT3akxTfO5A9GROniWBKuZG5d5EgV7fnEfg0j+GFZbl10U/ddDN8pn+zY4W6r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178

Am 11.04.25 um 00:06 schrieb Rob Clark:
> On Thu, Apr 10, 2025 at 9:33 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
>> We need to cleanup if the chain = dma_fence_chain_alloc() allocation
>> fails.  Now that we have multiple error returns in this function, switch
>> to using an unwind ladder for cleanup.
>>
>> Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline syncobjs")
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> ---
>>  drivers/gpu/drm/drm_syncobj.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
>> index 636cd83ca29e..c136d0c772dc 100644
>> --- a/drivers/gpu/drm/drm_syncobj.c
>> +++ b/drivers/gpu/drm/drm_syncobj.c
>> @@ -745,21 +745,24 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
>>  {
>>         struct dma_fence *fence = sync_file_get_fence(fd);
>>         struct drm_syncobj *syncobj;
>> +       int ret;
>>
>>         if (!fence)
>>                 return -EINVAL;
>>
>>         syncobj = drm_syncobj_find(file_private, handle);
>>         if (!syncobj) {
>> -               dma_fence_put(fence);
>> -               return -ENOENT;
>> +               ret = -ENOENT;
>> +               goto err_put_fence;
>>         }
>>
>>         if (point) {
>>                 struct dma_fence_chain *chain = dma_fence_chain_alloc();
>>
>> -               if (!chain)
>> -                       return -ENOMEM;
>> +               if (!chain) {
>> +                       ret = -ENOMEM;
>> +                       goto err_put_syncobj;
>> +               }
>>
>>                 drm_syncobj_add_point(syncobj, chain, fence, point);
>>         } else {
>> @@ -769,6 +772,13 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
>>         dma_fence_put(fence);
>>         drm_syncobj_put(syncobj);
>>         return 0;
>> +
>> +err_put_syncobj:
>> +       drm_syncobj_put(syncobj);
>> +err_put_fence:
>> +       dma_fence_put(fence);
>> +
>> +       return ret;
> I suppose you could just initialize ret to zero and collapse the two
> return paths?  Either way,

Yep, good point.

With that done Reviewed-by: Christian König <christian.koenig@amd.com> as well.

Regards,
Christian.

>
> Reviewed-by: Rob Clark <robdclark@gmail.com>
>
>>  }
>>
>>  static int drm_syncobj_export_sync_file(struct drm_file *file_private,
>> --
>> 2.47.2
>>


