Return-Path: <linux-kernel+bounces-722492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE83AFDB47
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBB71BC7B78
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBBA264FA9;
	Tue,  8 Jul 2025 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bcb/DXT7"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76513262FFE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014610; cv=fail; b=WzG7wNL8GOvQzSnpLpmZw0qk+BxbcKsYwOY7dEKgDWcpSzxItvyBXNygYZpF1/dFK2URe00ScqEWbYhC51E9kd/cQSHLcDYUtSeWnqyOxbdFxvfRzE8dg+Uxm7Ec39UYcCWvATHi8jTGXBkrrO8xgf2NKhpN8mPw3w57FlQkFuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014610; c=relaxed/simple;
	bh=WkfZzQ/kzP6wt771/lXdw2JEoEo6H160CUZqU/3xWFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TesSb+GN5uE1GKlChMfzRSTmnsgzNGZcFT3/SMCWDg528W1nvRMqiiokaD6gBq0tbfwW6LYMXl7+OVvBNfdclKxXkzAKsjb2VHBTlVoJaIu7PhI2sLJrlaVY8HTicoWZ9rgSs8Wk8+1gx7bnlESvFd8M2ZYwi9q2Y0sYHHVU2k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bcb/DXT7; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eC46EkAXSICnW6pVHHB9qPnO5dDzqRMJoHrqbpBwotEbVWqnBmSRsDhxaPJr2mTrFlwm0IEHwooMk0lYnqUXDDfu4Lne2zqsJZesn7aoj5j7VhlZVj2qIM42ir/Oi/4nwWYGj+YO8AifyyC0ioxQYl5tCYgFqKcE/SuCeu+6zeYbAHhXuJO6dHZraNzz2ZCsg8PF62ILctJ43LioRRq1MM2j7JHuJTg5JZ1APx7WxDQB4c+jRTfEBkZPrBwt/BGcu1omuqtz8XnEFRuTBlvLBGdCavFPtZVV/jZ5O0aUC/yBNJ0Y+5kaHU4mbp5XzKWoVAt/ZxhbbDVnJWhyKRq5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJkeHE0g0IR8OQ0SGSOP9PTCQ3jpRnSMsTTRZz/+veI=;
 b=Skv8Wsae0Rrcg7iDUq0ejjUehlhUvesT3WfJSsPxDC1FOTV3fMrOrBZzcWDKASk+lc6GXwPCp+AYDKryQUILGbgIfFtsTu4GKNo4UZfqj4kSwUVAHkgAZKlkAPeMrR+14KYXMO/qLiiGBof6p3sy8qa9hcoXyn3QKsUTYJPQQ+pXqvwxJAN6nf8rb/CPn7nmcaeV1K013lGzhwRnl/BeTohlCooOmQWPzltAkAhfFcm5pfCcVvEwaVoyFrUxEw3sKJJriFMJiovGve/uDqQWXGdokYBpoMbWHcBavu37QZgIxme+LZrY+wKe64V5av2gqDECbDE3IQphU4bn7S43Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJkeHE0g0IR8OQ0SGSOP9PTCQ3jpRnSMsTTRZz/+veI=;
 b=bcb/DXT7F2cIgeiqymHVVUgKLj8ISJT5757A8JIJmMfvJl48WSOjd4m1Fz9y/t/aemVm+/WaO7UXw3myOSkP7aDChGQyHxSVrsKXbfjnLjKp+j+TIvn16i+IEWvO5dzeHnn8m4qlpDyEDSu16Nh/9EEFMvb4kD6bylMkQ47LNADc2RTYLVCJXG/ylqHp6GS8LZX4HqM6k4v6KexQ0tzS6i7lF96XWIz54Sb8MHbSdDV0dywGdpjiuYZTeaX1SF/GR5tX98YbDdX6qeM/tjYskbY/UxyWRhTMPu+7MJXVALC25MFvm1J+R/5FQVondJuoNFASDfEN68+uVnAmDiMPDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 22:43:25 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 22:43:25 +0000
Message-ID: <537ab2a5-b95f-435d-a4f2-3de16c535b41@nvidia.com>
Date: Wed, 9 Jul 2025 08:43:17 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 00/12] THP support for zone device page migration
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <6ac61b0b-980a-487e-8b88-8ff1bc3f9f17@redhat.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <6ac61b0b-980a-487e-8b88-8ff1bc3f9f17@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::18) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba2a86e-29ff-4747-a941-08ddbe70d949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWVjYVk3QjErdG4wSXJkQnMrcHphMWUzRlJ5ZzlGcjVRMHUwN1BxbTFzTWhW?=
 =?utf-8?B?U2RCUFlYdGNRVWFpU2M4OG4xV3k2dTRBVXdEanhVaHppMlFRQTRmcDE3OGlD?=
 =?utf-8?B?UUM3MXl0ZTAzK2lXcjZkZ2FES0pFbTN2MWZ4T0tTZzlSTVlqT1hGUVpFdjVs?=
 =?utf-8?B?aUdaV3AvRDlLRFgvbVZ1SVgwd0pmY1BpbXZGSGsxdURLbDhXeXI2STVhbS8v?=
 =?utf-8?B?NXI0U2pyUVlpeEg5ZFVOWjFiRTFHYTRHRzRKVDFyUkF6Sm9iR1FkR2c0dktB?=
 =?utf-8?B?cXVBR1N2NEVYd1pJYTdkRTh3Vng3NE5OUVRvSzJMaGxwcGhMK3V0NiswV3Zs?=
 =?utf-8?B?Mm5hdHRTVFIxcEVrMy82ZS9HMmF1U2o1Q0Mwdm13dm5vSzJrTWJ4RldIOVFr?=
 =?utf-8?B?YVkwNjdMRzYvM3h6U0J0a0N6S3dHVVpIbmJOaVZ2b0NXQlpSOHdCYi9McUV4?=
 =?utf-8?B?ZnF3anVBTDE4NjErYkZDb1ZZQVhWRGlBZndhZjErVmdGT1dEYytTb2VuZFM4?=
 =?utf-8?B?emx6cHdneWJTMTZ3Tkc3NmllRXNld1o1TDNINlNMRnhEcHJvVnRzLzV2UjI2?=
 =?utf-8?B?UFJjTWd0V2Z3VWtOSWFPUDEwaUQ2NFIyYVdGK3pwRGdLdmd2c3g0VjBYaVlD?=
 =?utf-8?B?RXJJT1lGaVBFVGRJa2dTR1F3c1ZqZmpCVmJZekl1ajBMNlFucmFSWDVYLzli?=
 =?utf-8?B?YnlmNUxJNitsQ2dMZksxN0RBR1pCbVJZbVFaczVkUm5PSnZUUWhlcEJOVkhO?=
 =?utf-8?B?eElWZTJNMzBUdG1iMkFESjl6TjBDNWlLd3ptMktBNmJOZENPMWowa2hVTHpp?=
 =?utf-8?B?NG5ITUlSZTBqWjM5ZHh1b1dBMnczRmdKQThZVG11eDN5QWg5M3pDTkYxQXkw?=
 =?utf-8?B?TXQzSGRyUjRZZEpleFNrZXFDaUIxYW9wbGlWTnNJVUNGVTk5Qy9PRkhNUTIr?=
 =?utf-8?B?b25HVldLSlRnSmU4QjN2ZU4ydkFJZlB4L0pNQVFxVnVXNnhaRkQwSTNUSW1E?=
 =?utf-8?B?eTVZbXhPM1BTcWxBcFlZcGl3Q2RnZWVLMnZPT1VNcFArRFZZUnNZNzh5WGt4?=
 =?utf-8?B?UUlTQ0ZlTStYUWNDSFlSV0c2TFlpSnFzcHlGNG5md051VFBzd1UxSmVLQ0w3?=
 =?utf-8?B?Q0M1UmptYWNzbXdvMzNub2pFa21mMzZFanBWM29aMTduNXRBeTd1aTV2cE9Y?=
 =?utf-8?B?bE5XaGlWNXhDYnNiS0s3RXhua2NzZ3FqOVYxQjVVSVdwdUtvMVlLV1BZMFhs?=
 =?utf-8?B?a0E5RjlUQys0RWMveVNtWWpSZDNhYnNJY0N4Y0tqK2pjdGx0WmFxNUw4V0l3?=
 =?utf-8?B?eHdreVRkQWt6VTlGTUd1Uk9ENk5BT3B0QzJkeVg5Rm5ObGJUZTZGNHZQSTB2?=
 =?utf-8?B?Q25kS2tQNDhUN2ZjM0FmNkRNSXgvNGxsWnNNTGxiR1RBdW1jbHhvZTEvcHdS?=
 =?utf-8?B?dG5VMW03YXV6ZW5uRnJpcDBrWWlqQWZrNGNMS1VxVU9kVURrbU1ISFJpcC82?=
 =?utf-8?B?Sm40Sk8rYUE2ekF4aDZNOVNYOFFtNDBsK2FEOHZUV0l4OXVIcEFHU2NkRThI?=
 =?utf-8?B?Q0c3R3ZadHc4U3YzUUFUYklyNjk5UnB1VDdQdU45NXRncm1RYlQ4ZFZPaVZX?=
 =?utf-8?B?akJDRTN0QmpoR1d2NGIyQnFZTnJVbmIxcXAvK2I5ak1IM2lHU3k3THM2Zzlj?=
 =?utf-8?B?MlZXVGNqNGUzMUt2NDAvc1dFV1cwUUxyVkVoeTVTbS9YWURCaStIekh0MFpH?=
 =?utf-8?B?cW41bUdUL1JSbmFzTW9vNUFFclg4OEdHUEtzTkgzU1hEeGxFN29JcTlHbE90?=
 =?utf-8?B?VEdXMmNmRW9pd3VPa2pIRHdvT1NZWDZEeWRXd1A5cUFvZ3lGenNpZU1NdU5v?=
 =?utf-8?B?TUpvTEhERXp4SnBLeHJhcWlLUkorNk9DcjRyRWFLcFdzVTU3N1NZVDN4OThu?=
 =?utf-8?Q?BVMeHmx1F4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXl0cHAwWGk0ckNzZVQyZElWeVNpZWVCY3E4eFQrQ21BYzV4N1N3czJUK3BF?=
 =?utf-8?B?TDdEMEVZRlY0TXhxSFROMWp1NXN2dVNMYnZxT0lLVU13WnloMHdrdHVTbkJ5?=
 =?utf-8?B?cytjRytGTTcweWZCWW9JMHd4am1DL2hLNkVHYzZvbmp2T0lTYm5JTDhLMm11?=
 =?utf-8?B?YmZ4VDAzTlNINk5Ya3k5cTY2Q214UkZ3MDlRWDVEaWdLNWVENjBUMlF3U1g5?=
 =?utf-8?B?Sy85Y09DZmVLaEgvemJIUVUreFhlTjMrS3MvRmNzdkwwaUpkQlNPb0NJaGNn?=
 =?utf-8?B?YXRqUlprazJJTWFGYmJab2pwenR4MDFNa0pkMlVyTnlYUE1UWlRnNjhIR3BD?=
 =?utf-8?B?b292ZlBCb0lCdUZGaVltUldDZmtOejVjMmZNSzZVMXM3V0Nzckh3VGtES2RG?=
 =?utf-8?B?STdKUHc0cnlYWUdpTnJJaUlYT3UyM1ZyUkFvd1l4RmFjUStVTWVHdnFLVm0z?=
 =?utf-8?B?TjNJZmp1N2Z6R09aR1ZaS3liNjg3SW1QYWExTFo0WXNRQlpUOFZzbjNFbTY0?=
 =?utf-8?B?MDl3WDB0NXFsTU9MQm1SaXBZQ1BPMjJqNnlyNkRkTTBTbnNwaVAvdVhoWklV?=
 =?utf-8?B?S1c0UmIzMFVIcFRDeEFZM21MbjZVZGJXZ09Xd1U3NWh2dmdRSHg0VDlpNUdq?=
 =?utf-8?B?c1REZnovSit5c0owRzhpY1ZNVTJaL004dndGT3ZsTnVkTVAzcFpnUktRYlQ3?=
 =?utf-8?B?RnFRUjFVYzlHK1poSlVwcVpxSDFyYWJ6bmlqbTJuWUNvRFV0SDIreFEvNm4v?=
 =?utf-8?B?M3dpN0dlRFduWmhHbDlpdStMS2hjUDl4NmhBSTdyamw3eksrMC9JM2gwbTd0?=
 =?utf-8?B?ZXZUdlZnait2UTk3V25PK2lBWERDTVRybjVtZ3piejBTLy91c1dXVFlwd3U4?=
 =?utf-8?B?K29XenZja1RVdDcxK2pmazBrMFhHVk85YXVUQWJrOWxiUWhHYk1Jd2c2U09t?=
 =?utf-8?B?MGxncXRoeDdhL1J1bXJDcEU0UlZlWEJRWnRoRFFRbDVtTGJhOXJpazY2QXNm?=
 =?utf-8?B?Y2JPcTVQR3NFTDlLM2MrdG96cEo3RG5NSmNaa2djdno5MTlzRXMzSUZXdlN1?=
 =?utf-8?B?eC85UlY3eG1xRzFLVERXQlNyRGVqa2RzTzRzWTdmL1gvd3E4MGoyNmdWeWUz?=
 =?utf-8?B?TGhZbGNIWTNuN0w2SE40WE9lQ2ZyOVBWbHA3SU45TmZvUlBramY3eVJRM0E0?=
 =?utf-8?B?YXBvQUFhVGRUc202RUlGUDFHS0NWbllaaE82S1A4OGRTUDVBSzh1NFM4ckpl?=
 =?utf-8?B?NFY3dGI1ZjlmeEluYXNDK2hLd2tWcWlSOS8vNFFEbGl0NGh4bjFhb2dVUFRh?=
 =?utf-8?B?S083Mi9LYzRTWnlZeFNQdlVzeEo0ZzliRnVJeHdCNU9vY2EyRTdlTFVCUkNx?=
 =?utf-8?B?aUV6U1FDNExqcDJlZnBsL3lBcXRRN0s4VnB4Yy85d29xK0FaL3FDL2t6aUhy?=
 =?utf-8?B?SE5xUTJzY1BqZkNJUlBVMk81dkFyenZQNVlrNW5LblJZZzFyN3dnMEN0VDVN?=
 =?utf-8?B?ajR4VDVzeE1kZldPOGVqSkdqaGJkZ3JVb2lzNy9BOW9RbW90V2U4bmgyWUFU?=
 =?utf-8?B?aFJLN0o1dkJMdWtRMWw2V1dRZ1phQzJtR2U3SVFqTk5Rdy9tTmdaYVE2Tmph?=
 =?utf-8?B?WC9DVG1xZkluMW1kMVFzQ2RrcEc0YW1wWlFUNXBOSUUxR0NHbjZCaXBhemp5?=
 =?utf-8?B?Y0NIRHNkbXVxMmNXN0kxcHRlSFl6Skx2OU9meko4OTBzazBMK0tITTRoTFE4?=
 =?utf-8?B?YWhFb2ZSN3BaSS9RNlZFb2txR3Zwei9pUHJzU20wVVpGV3FKZ0p6cUtPTWVQ?=
 =?utf-8?B?SENQZWZ5RmJXb01sRS9NSi9HSlNNQVVPM2N5R0tzS0l3eVc1Y0gzVXdaOVRH?=
 =?utf-8?B?T2ZZQ0RiWFdjY0tCVlFhZDNoZ1FyZ0pQYzdCWFRyQ2srbGhpTUxFNDhIb0Y5?=
 =?utf-8?B?eE9HNzRoRE0wclZ4Q2dQTVpoMG9FdUNudnJXbHFPSVZIaWxNZUdBSm9wUDNy?=
 =?utf-8?B?dFU0L0hKMldpSkZ4TCtGYlM5S0lqVFlpdk1tNzQydkZuWVlDSmFKc0wzcmlw?=
 =?utf-8?B?eUdoVDJJNEIzei9FYzY2TzY3UmxsL09ieGtPSkZqZS9vTXFYYzZMRHBZc2xm?=
 =?utf-8?Q?KZCcUhUq0qxtQYWNnSTB9oc8X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba2a86e-29ff-4747-a941-08ddbe70d949
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:43:24.9270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1L+rUGpZx28CVPDCOUvm58O/zgV1pV6qE8vaIlaOJmmCdBygzGit51X2MaN7jcefOLMVT/Rwavj/XcneYlkRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484

On 7/9/25 00:53, David Hildenbrand wrote:
> On 04.07.25 01:34, Balbir Singh wrote:
> 
> So, I shared some feedback as reply to "[RFC 00/11] THP support for zone device pages".
> 
> It popped up in my mail box again after there apparently was a discussion a couple of days ago.
> 
> ... and now I realize that this is apparently the same series with renamed subject. Gah.
> 
> So please, find my feedback there -- most of that should still apply, scanning your changelog ...
> 
Will do

Thanks for letting me know

Balbir Singh

