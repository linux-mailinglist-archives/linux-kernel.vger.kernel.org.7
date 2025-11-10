Return-Path: <linux-kernel+bounces-893634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C939C47ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C489434A16B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB07280A5B;
	Mon, 10 Nov 2025 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l8bl5PBV"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6B027FB37
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791974; cv=fail; b=JbJ99kxTrxTY5fa9B2nSYKqa65E3jM92YYVjQVCOODcXzCGTVCnr8ifIQQtQBoesxuWowVDOSXme3DeWAwQKhTBCk/ud9ndXbwK1rjsOHCB+CL1jUl0r0aHaygWPvZ3Clxfk/j+xmShRUd2XuNpXbWtPK53QuNwhOI1DTovaNsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791974; c=relaxed/simple;
	bh=p1GAvqpw0jACsO3fs6FR8t9nw6JU31kKlUqbsV9O48w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eITYnx8L8qPZ9X/icqxkdkSlD23UH+YRGJzzP2TkJ3YtriZZT4TXSFoTcElGGvcU4x1QKuYYyQp8H9FqhdEf8ZQ/XSmQF+Oc17c/Uxg2A0M98Pk89SQRoCHf866edOtKhxHQbUKSJiEaUk9fkWZZLb0fwg/BmF1fPa/5Etn3VmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l8bl5PBV; arc=fail smtp.client-ip=52.101.48.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvW4zCRQHrjIFwn/leWpPGR31laUqoUXFa5TIYRGjMsFS8/KVwcXycFBYCl2fBdbmJot7iZN1ltJQsiD5BA3uniY0iPsLkBOVg44Ew6VaTteAvXT3B+Tnn55NF/M77QCRIxdP0pQXWZZjHx/J0dYiIV8evRfiFlOfAOvdRvA20OykgIPDT0fqXZ7oKWiPzjYCmXUQpmRrv3BB6ISBkveyPmR3kUU4RQFuKO+YYuwqIWCZCWBItUaMbssOXFZesQIHmrhIa9L9gKPnGPyEB7j5G0dCaBggzPqh3dpW1+5L2/71Ct+BDieMMTt3CjO/A6PoeDJwl/z4x3iSDjUGzgw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7J6B3sEHIN9pdW64pM7BBVPlTQ52WGXPXMgi8WeFuY=;
 b=VaM9cFq+mC4gf1DGcZd1Bz5zTbvfmMioSohnb7BtB+Kvs98pHJ97Ng+J+xWnbfWTJe9cxj2eGeEZdu6Egyu/boMs2ulE04b5d6gQhOIuhrM/2ZyQjM1bjj0jlQpLc3vt7eest+TgXPuEDG6JNeySIoUxyX942sdBonMLitG1pLBvt7e+pgLZOVd1CKeaIS4mg5xDmQgTAHYL/qkpYpVa3ZHKw3fgUS3TblbIswvZxkhSB3MRsX9tMv/HEyhsLAMZBULOZqY+OvMuYVwEGA1VvqOa7dix2WFN+2FGlSj3SLuPexf7Y8oCeiXumG3GpfghcFyg70Cnu0/Bj/KKIgLC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7J6B3sEHIN9pdW64pM7BBVPlTQ52WGXPXMgi8WeFuY=;
 b=l8bl5PBVPZSITAz3UOxcJPL1MIEW9scJ4vLAJ1Kr0TC8kk0UFztLnqoB290MNh9ZoPH/cf23k8mlwEWwt9wdl9oR65R4Z1TtEik+qZM3K+lxkrOOOWwLuRt08eka2RFd20XLyszJ67+4QBZ2LMAUD6MpLFQK7VyLDzu+NDqpEkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 16:26:10 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::29f2:4b41:f65f:248d]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::29f2:4b41:f65f:248d%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 16:26:10 +0000
Message-ID: <c19683a2-5a98-4bc8-8584-77ff32860792@amd.com>
Date: Mon, 10 Nov 2025 11:26:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Ensure isp_kernel_buffer_alloc() creates
 a new BO
Content-Language: en-GB
To: "Du, Bin" <bin.du@amd.com>, Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, pratap.nirujogi@amd.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 alexander.deucher@amd.com, benjamin.chan@amd.com, christian.koenig@amd.com,
 dantony@amd.com, gjorgji.rosikopulos@amd.com, king.li@amd.com,
 phil.jawich@amd.com
References: <20251105232108.107765-1-sultan@kerneltoast.com>
 <a6063bc0-4ba1-4cad-9045-5fa31ea4ed7a@amd.com> <aQzv00We7FyKAWk7@sultan-box>
 <cbf09540-df4b-4e2d-9e46-e6893af79fba@amd.com> <aQ0FkZv_l8UPLhvr@sultan-box>
 <5b1c1686-c48a-4f43-80cb-941c52dc103f@amd.com>
 <c8854e18-94bb-45b9-8e82-67db5db9a02b@amd.com>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <c8854e18-94bb-45b9-8e82-67db5db9a02b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::27)
 To DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7885d0-cc2a-453f-0fbf-08de2075db84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFFtNyswZVJFQ0x2aERZQ3prN0U3NEFrUWgzTEtrc3Z6ejdncHVHTGk1ay90?=
 =?utf-8?B?RmJsckhXZ0N0bVllQk5rbFNQVGl0eVU5TW9QTXVXOWpIaEtEY3M1M0ZsNDJi?=
 =?utf-8?B?M1ZyRHNreTIrVGR6d1RBbTczU0pDcXM2Kzk3WGNUWDQ5Y3ZLdFhhVjA3QkVq?=
 =?utf-8?B?cEwvUUMzVlZwRmx0NTgzdExIaUxrczZQU1ZEcFpqZHhrN05zeG1sSENxRzcx?=
 =?utf-8?B?clRlN1dseGRRNlo0UjJjR0pYbS90QXhiU2NZVFhkTGNhMXIwK2RXdjJDUlBB?=
 =?utf-8?B?K2d6bWZ1cjE2Y1luc0dsREo4SFJsYnFhdXVRamVkako5STRHb1hKVDlzbTRG?=
 =?utf-8?B?OFJNa09Tbm5aaXZYMEZ5NFlXUVlQYUpvdDFKNFluOTdETE5Tc0J5eVV1L3dy?=
 =?utf-8?B?bi9lL0J6NFZ3Ri9vM0hYcHc1a1NSRHlPeXJHRXR1NERPWGZMV0drTURHaGsw?=
 =?utf-8?B?TlZDQTRZNlBkZXFXeDZKRGJYNklCRTVKb3VQemliRklzU2h2b0RZcEliNjJB?=
 =?utf-8?B?dkFhN3lZM0pmWnZ3aWZacUZzVmlQN2p4RFM1cXBNTUhNaHNwRXQ0SlVTSDhL?=
 =?utf-8?B?bG5obDNaQzBmbXFZV3VFcGlDcFhmTXU4UldmRHR4cXNtMmxKSW1qVW8rc05Q?=
 =?utf-8?B?Z1UwcEpId2VQd2R4R21hWmhJWTk1RE1HaDV5cGJIMU9tTitGa05Ya2ExcUk2?=
 =?utf-8?B?KzF2bmE5TDRtbTk2NTMyQ09mQmlIYk1mVkk4TzNUS2VrVDRrZVh2NWNXS01r?=
 =?utf-8?B?WkJFKzN4cnJheU9wRlFseDRFT05RT1I4bUJ0bHQ4Si9nWWo5czhVc3IxQkhT?=
 =?utf-8?B?c1ZmVDA1ZlY2SE5ETkJ5dUVPWjQybk44cUJGTHpMdU95Nmx1Mm5ZVWVyUW15?=
 =?utf-8?B?SHRnbFZ0UnFjMjFiTTJQVG13WVJOYk5TQkVHUm13a1RDVFBCVGt6dEpITXA5?=
 =?utf-8?B?RC9XZlVQdUpBRytMcjBkbTVHK1huSWNaelJBaGFhNTBUMTZLaDdVNjJmamVt?=
 =?utf-8?B?dHgvZFpvb2xRTmJDUmY4M0JkSkRBT1A2VmJjUU4yemkrYXpoZmxFYmhDRmlv?=
 =?utf-8?B?MFc3ZnhDMEkwZm4xb1RoMFZ3NUxrQWpkVUhTejFMTEZrWHQ1ZE5YclJDaFJM?=
 =?utf-8?B?YmFHTFNzWklDZUNBVzFmTU0zcG1Gc2ZSNzVweWs5V29oamdlSXZlaC9nTlVw?=
 =?utf-8?B?L1I4NkxZeUllS2FBcEhOcnY3TmxEMzFJY1VhV2x0dWlhRUlUVzV2aGtkbks5?=
 =?utf-8?B?c2dzc1lhazlDSVpZQWZYZ0xrOUNlL1d5YmlhTFUvQ1ZORVdpVSt4Wm1CUGhy?=
 =?utf-8?B?ZkhUSXFLTTVKdGQ4SHVJbVhRZmQxK1lzeW13Wlp6REtqV29Vc1p6cFlXald3?=
 =?utf-8?B?cGRLTDV5azVWSlJHa0JqaFJ4dDZoekZrWjc2YVljVmlNVUFFbFVaR0xQVko2?=
 =?utf-8?B?WXJOQlA0TGw3cFlPWEdkSlRTMlh6WlJYOGF1YTAwS3lFb2ZBK0tDWGwxQkRO?=
 =?utf-8?B?MGJMOW9lcktJbnJCbkhzakt2QUxVSzhqVkJIQjZqMElnR0RkWTlkL2ZBOTJG?=
 =?utf-8?B?ZzF5QVdDQWNoM3Jod3FDYkFuL1JBZmQra1I3dk9FUlNJelY5ZHU1bjVTMGFp?=
 =?utf-8?B?Mng0VTV1SFcrMVBnM09NdWU3dTRibStKVnN4VFpLZ0U5SUNYZHY3eThMdThK?=
 =?utf-8?B?dWVONGlDQ2lIeDJzWlJqMVJKNUhCdWRuc1M2R05YNWdTZy91a3M4Y2VRYVZ1?=
 =?utf-8?B?cXBOY0pQVjZEOE15WjhJd2VqOGcvekpoMG1SYUJ4WVQ0SktWK01kYXRwQ3FF?=
 =?utf-8?B?RFMxZHRSam0vN2J2c0lVc290blljcy9SaWYvV3RsYkRBS2ZJaU5jWWVKc0VU?=
 =?utf-8?B?NVlQVmMwR0VaaGFoeWY2N3lockJhZWZPcmdiOG9QL2l0Q1pUUWFybE5sZ3RO?=
 =?utf-8?B?OFRpYmdRc1g3R1M0ZmN1VzVkRjRwVFlRejZEcDRyMU9sc0RsSHdNSFduQU12?=
 =?utf-8?B?ZHZnTDU3TzV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9501.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnBGME1uSXpCa1Voeldhc1F5N3puOS83d0NSVTVJSUxnT2xmR1VhVTNaY2gx?=
 =?utf-8?B?L1phSVhOM0ozWjc0VUVUSk5STHI5dUpVclJIZmg3RVN1K1VtRDI5azl2MjVq?=
 =?utf-8?B?cGNCWFJSN0VpaGc5ak5iTkw4NFNQT21heW5oQW5PSGtpNnlNa1liVVlGZGI0?=
 =?utf-8?B?ZDF3NUZkcUgxZk0yQkcwVGNvSnRlUkRMZXg3YjU4ZDc5YWI0Nmd4dzB5VzRu?=
 =?utf-8?B?QS9IdXljdDJEemhzdlUwa2FGMSs5VC9YeXY0b3htaWlmVi9jeHZtY3ZYVlMw?=
 =?utf-8?B?NFduTXZyWjFDNG9RczNLQkdvQzVaLzVoVWY3YlllVEhkanF6QTRibm9YS3BZ?=
 =?utf-8?B?TXRUU1RKYjZrMTZJUEpiKy9LRVY3REN6RXdvZHRFMW0wMWk2VVV2Z0dwQWQy?=
 =?utf-8?B?d3FPMDZCaERsaCtKVEhiVGZodkpvVlpTUlNvanpOeURsMUZMVlNmbEluWjQ1?=
 =?utf-8?B?WnU0MGlUSFZvYnVZczc5S29FODJtRXBBYmlXaWVhclM2Z2xsNnIxVXAxTDN3?=
 =?utf-8?B?RlFaLzZNRmNDU0FjU01sSVB3OE8zbTUrcHp5cWdpNnEwZGRGWXZXZ0d2Yllu?=
 =?utf-8?B?aWNhdktsUzhYUHFocmpLVUJvUUxLaXMxejUwVDEzVXlEUWJNVHhmYStOL1Yz?=
 =?utf-8?B?dktWSUNXaUtha3F1dVVaUU1qbzE2bDg0Z1c5VU10QkFFbXF3SEtJZS9lNDNF?=
 =?utf-8?B?aC9hYUE2VXRPY0t1NjJoL2ZSc05rdmVPUCs4YVNwa1dGSllBaU1hNFRZYjQy?=
 =?utf-8?B?UklISFVxeGRyN1lNNUg0QWVHNnZEYjRFUVk1aXVoNy92SnpBSVVqRE04NEIr?=
 =?utf-8?B?UDZ6NituZ01PZThISndLZlQ1M05ZMjhpOUZJWTlHOFlkWldxR0d4OXkrYW9T?=
 =?utf-8?B?L0VSS2xCSkJaaTFJTnZXTzFmekVHV0hwSEtGVWlJdTNGVWpBYy85REdBSnE1?=
 =?utf-8?B?azM0Y0lhWHNTQlB5OFMxaFA3SDFPR0NJR0t6dWhjYWgySmpBM2RFQWV1V1c2?=
 =?utf-8?B?K29iTGJpbkZNVVRuYzYzOEppZUluYzFGRjdHMnRsT25vNWIwampsM0U3NlYw?=
 =?utf-8?B?V3dibFNwYlNzZ1FYK3lsNHRDc0k5WDU2NWlKOUlua1krYnpPQ2p3NVlxb29M?=
 =?utf-8?B?c3BRUTJmL0lnV3phVUQ3eHVyeW83WVBVRE1DVDZoUkpzL2VrS1FGaGo2T2xE?=
 =?utf-8?B?UFlXVExvMkRBYkZ1UERPWDhza1Nwai9CMmx6eC9VckxWY1JWUTFaSVU5K3NV?=
 =?utf-8?B?azRFRXgxQm1qQlhSK09pT0t6RFhwTm1BdGxvMnY4N1orYTFtdzAvN0VPNHhX?=
 =?utf-8?B?dnlDeldGdmpRV0thMGJpTGJtLytaMWxWeWFMRWZQZ3RCcHovTjVEL3pjY1Fn?=
 =?utf-8?B?eHo4WUtpSWQ0YytQQ00zNDhyNUZrZGc1NjYzcXFSaW9DMHNwOTd0L1JkUHZ6?=
 =?utf-8?B?VHhTNVEyOVV2WVFvRE9Td1lrVFRDTWtpRS9nR3lEM0M1N0tpcVpmRCt1TE55?=
 =?utf-8?B?dUlwTEQxRlJQekxRWlE3VmFFVy9BUTdEZXVxalZsOEJYMkw5dENlcnRkdU11?=
 =?utf-8?B?UTVXWUtHQmtRdzF6ZnBhZVJJWExqUmVNd2x6S1FZWURodlh2clJMYnR6Sjgr?=
 =?utf-8?B?NUtrYXpHdVd4YUdadk5CSEJCb0l0SWdXeDRIUXczeHhQSEtTZWM1N3dJb01W?=
 =?utf-8?B?eCt6djdNRG5YdVZqc0VzbTJlZ1NPVnQyWEdJQzN2ZkNPQjQ2aFpxeStLdit4?=
 =?utf-8?B?TTNkR0RmSkFCYWpUcUZ0L0dpZCtwRzBMNk9hRnpQYzhWajBQVEN2WU44Z25F?=
 =?utf-8?B?VEY5dDhyck5YWmdyejhjRFlKZ3FTSjJHZG12T2NKSWVTc2JtdUdUdW1udlJp?=
 =?utf-8?B?akVhRmcvcFRGT2l2d2x4MnNHc2dsUnlOajhNSWFUdGNnSUhVeTB3dzdWS3Qz?=
 =?utf-8?B?aTZoUWxneUxRNm5UZWV1S2pPNFZVTC9MdGVHU3RuMFllN3dWYmFKSGh4aFZa?=
 =?utf-8?B?dG0vK1llWjNSWnVSUjhBQ0J1RDc2RzE3ZHM4REdJS1VMbFQ4Z2tFbkpJUGQ0?=
 =?utf-8?B?cGYvOU9JL1Rqcm9qK0ZPSlRGVDFzaDlxTFJpSVJ0cENnR09vKzBwYitja1I0?=
 =?utf-8?Q?0ublVVAvq2W46nlwTgXE2PhI2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7885d0-cc2a-453f-0fbf-08de2075db84
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:26:10.1736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vi2nEzTI5AqJ4Pma3kjcUKmLy3Ln6vEM4dOQyptT8yGTQze/soHM04i1Q0iYMHrtL+ZGfGk+jEyuOtOLTt//GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

Hi Bin,

Yes, with this change applied, its not necessary to explicitly 
initialize the kernel bo handles in ISP driver. We can continue using 
kmalloc() in isp4if_gpu_mem_alloc() of ISP driver.

Thanks,
Pratap


On 11/9/2025 10:12 PM, Du, Bin wrote:
> Thans Sultan & Pratap,
> 
> So, based on the discussion, the ISP driver will retain its current 
> implementation and won’t do unnecessary init to *bo before calling 
> isp_kernel_buffer_alloc().
> 
> On 11/7/2025 4:51 AM, Nirujogi, Pratap wrote:
>>
>>
>> On 11/6/2025 3:31 PM, Sultan Alsawaf wrote:
>>> Caution: This message originated from an External Source. Use proper 
>>> caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> On Thu, Nov 06, 2025 at 03:08:44PM -0500, Nirujogi, Pratap wrote:
>>>>
>>>>
>>>> On 11/6/2025 1:58 PM, Sultan Alsawaf wrote:
>>>>> Caution: This message originated from an External Source. Use 
>>>>> proper caution when opening attachments, clicking links, or 
>>>>> responding.
>>>>>
>>>>>
>>>>> On Thu, Nov 06, 2025 at 12:46:51PM -0600, Mario Limonciello wrote:
>>>>>> On 11/5/25 5:21 PM, Sultan Alsawaf wrote:
>>>>>>> From: Sultan Alsawaf <sultan@kerneltoast.com>
>>>>>>>
>>>>>>> When the BO pointer provided to amdgpu_bo_create_kernel() points to
>>>>>>> non-NULL, amdgpu_bo_create_kernel() takes it as a hint to pin 
>>>>>>> that address
>>>>>>> rather than allocate a new BO.
>>>>>>>
>>>>>>> This functionality is never desired for allocating ISP buffers. A 
>>>>>>> new BO
>>>>>>> should always be created when isp_kernel_buffer_alloc() is 
>>>>>>> called, per the
>>>>>>> description for isp_kernel_buffer_alloc().
>>>>>>
>>>>>> Are you just going off descriptions, or is there a problem with 
>>>>>> reuse?
>>>>>
>>>>> I am going based off the ISP4 driver's usage of 
>>>>> isp_kernel_buffer_alloc().
>>>>>
>>>>> This fixes the following crash I experienced on v5 of the ISP4 
>>>>> patchset:
>>>>>
>>>>>     [  175.485627] BUG: unable to handle page fault for address: 
>>>>> 00007f6b1092e888
>>>>>     [  175.485799] #PF: supervisor read access in kernel mode
>>>>>     [  175.485840] #PF: error_code(0x0000) - not-present page
>>>>>     [  175.485869] PGD 0 P4D 0
>>>>>     [  175.485889] Oops: Oops: 0000 [#1] SMP
>>>>>     [  175.485908] CPU: 15 UID: 1000 PID: 57022 Comm: cheese 
>>>>> Tainted: G     U  W           6.17.7 #1 PREEMPT
>>>>>     [  175.485921] Tainted: [U]=USER, [W]=WARN
>>>>>     [  175.485933] Hardware name: HP HP ZBook Ultra G1a 14 inch 
>>>>> Mobile Workstation PC/8D01, BIOS X89 Ver. 01.03.00 04/25/2025
>>>>>     [  175.485943] RIP: 0010:amdgpu_bo_create_reserved+0xb1/0x1c0 
>>>>> [amdgpu]
>>>>>     [  175.485961] Code: 8b 30 44 89 64 24 20 48 89 44 24 28 c7 44 
>>>>> 24 30 01 00 00 00 c7 44 24 1c b8 02 00 00 c6 44 24 08 00 4d 85 f6 
>>>>> 0f 84 a9 00 00 00 <49> 8b 86 a8 01 00 00 49 8b be 40 01 00 00 31 f6 
>>>>> 48 89 04 24 e8 d6
>>>>>     [  175.485976] RSP: 0018:ffff97b14e097ad0 EFLAGS: 00010202
>>>>>     [  175.485988] RAX: 0000000000000021 RBX: ffff97b085af04d0 RCX: 
>>>>> 0000000000000000
>>>>>     [  175.486002] RDX: 0000000000008000 RSI: ffff97b14e097ae0 RDI: 
>>>>> ffff97b14e097b20
>>>>>     [  175.486012] RBP: ffff97b085af04c8 R08: ffff97b085af04d8 R09: 
>>>>> ffff97b085af04c8
>>>>>     [  175.486023] R10: 0000000000ffffff R11: ffff97b085af0560 R12: 
>>>>> 0000000000000002
>>>>>     [  175.486031] R13: ffff97b085af04d8 R14: 00007f6b1092e6e0 R15: 
>>>>> ffff97b0a0f00000
>>>>>     [  175.486037] FS:  00007faf60ffe6c0(0000) 
>>>>> GS:ffff97cfa7133000(0000) knlGS:0000000000000000
>>>>>     [  175.486046] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>     [  175.486058] CR2: 00007f6b1092e888 CR3: 0000000101c3f000 CR4: 
>>>>> 0000000000f50ef0
>>>>>     [  175.486067] PKRU: 55555554
>>>>>     [  175.486072] Call Trace:
>>>>>     [  175.486081]  <TASK>
>>>>>     [  175.486092]  ? smu_cmn_send_smc_msg_with_param+0xc0/0x360 
>>>>> [amdgpu]
>>>>>     [  175.486102]  amdgpu_bo_create_kernel+0x15/0x70 [amdgpu]
>>>>>     [  175.486110]  isp_kernel_buffer_alloc+0x56/0xa0 [amdgpu]
>>>>>     [  175.486118]  isp4if_gpu_mem_alloc.isra.0+0x45/0x70 
>>>>> [amd_capture]
>>>>>     [  175.486126]  isp4if_start+0x3a/0x320 [amd_capture]
>>>>>     [  175.486141]  isp4sd_set_power+0x96/0x1e0 [amd_capture]
>>>>>     [  175.486148]  pipeline_pm_power_one+0xf2/0x110 [videodev]
>>>>>     [  175.486155]  pipeline_pm_power+0x51/0x90 [videodev]
>>>>>     [  175.486161]  v4l2_pipeline_pm_use+0x3b/0x60 [videodev]
>>>>>     [  175.486169]  isp4vid_qops_start_streaming+0x22/0x140 
>>>>> [amd_capture]
>>>>>     [  175.486176]  ? isp4vid_qops_buffer_queue+0xb1/0x140 
>>>>> [amd_capture]
>>>>>     [  175.486185]  vb2_start_streaming+0x79/0x140 [videobuf2_common]
>>>>>     [  175.486192]  vb2_core_qbuf+0x3b5/0x480 [videobuf2_common]
>>>>>     [  175.486200]  vb2_qbuf+0x98/0x100 [videobuf2_v4l2]
>>>>>     [  175.486208]  __video_do_ioctl+0x480/0x4b0 [videodev]
>>>>>     [  175.486219]  video_usercopy+0x1e5/0x760 [videodev]
>>>>>     [  175.486226]  ? v4l_s_output+0x50/0x50 [videodev]
>>>>>     [  175.486237]  v4l2_ioctl+0x45/0x50 [videodev]
>>>>>     [  175.486245]  __x64_sys_ioctl+0x77/0xc0
>>>>>     [  175.486251]  do_syscall_64+0x48/0xbf0
>>>>>     [  175.486260]  entry_SYSCALL_64_after_hwframe+0x50/0x58
>>>>>     [  175.486268] RIP: 0033:0x7fb03371674d
>>>>>     [  175.486275] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 
>>>>> 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 
>>>>> 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 
>>>>> 04 25 28 00 00 00
>>>>>     [  175.486282] RSP: 002b:00007faf60ffc9d0 EFLAGS: 00000246 
>>>>> ORIG_RAX: 0000000000000010
>>>>>     [  175.486292] RAX: ffffffffffffffda RBX: 00007fafb40050b0 RCX: 
>>>>> 00007fb03371674d
>>>>>     [  175.486301] RDX: 00007faf60ffca70 RSI: 00000000c058560f RDI: 
>>>>> 000000000000002c
>>>>>     [  175.486306] RBP: 00007faf60ffca20 R08: 13455f273d2513b9 R09: 
>>>>> 0000000000000210
>>>>>     [  175.486313] R10: 0000000000000215 R11: 0000000000000246 R12: 
>>>>> 00007faf9801c4b0
>>>>>     [  175.486318] R13: 0000000000000001 R14: 00007faf60ffcad0 R15: 
>>>>> 0000000000000001
>>>>>     [  175.486324]  </TASK>
>>>>>     [  175.486330] Modules linked in: ccm hid_sensor_prox 
>>>>> hid_sensor_gyro_3d hid_sensor_trigger industrialio_triggered_buffer 
>>>>> kfifo_buf hid_sensor_iio_common industrialio hid_sensor_hub rfcomm 
>>>>> snd_seq_dummy snd_hrtimer snd_seq snd_seq_device amd_capture 
>>>>> videobuf2_memops videobuf2_v4l2 videobuf2_common videodev mc 
>>>>> pinctrl_amdisp i2c_designware_amdisp uhid cmac algif_hash 
>>>>> algif_skcipher af_alg bnep uinput nls_iso8859_1 vfat fat 
>>>>> snd_acp_legacy_mach snd_acp_mach snd_soc_nau8821 snd_acp3x_rn 
>>>>> snd_acp70 snd_acp_i2s snd_acp_pdm joydev snd_soc_dmic snd_acp_pcm 
>>>>> mousedev intel_rapl_msr snd_sof_amd_acp70 snd_sof_amd_acp63 
>>>>> snd_hda_scodec_cs35l56_spi intel_rapl_common snd_ctl_led 
>>>>> snd_sof_amd_vangogh snd_sof_amd_rembrandt snd_hda_codec_alc269 
>>>>> snd_sof_amd_renoir snd_hda_scodec_component snd_sof_amd_acp 
>>>>> snd_hda_codec_realtek_lib snd_sof_pci snd_sof_xtensa_dsp 
>>>>> snd_hda_codec_generic snd_sof snd_sof_utils snd_pci_ps 
>>>>> snd_soc_acpi_amd_match amdgpu snd_amd_sdw_acpi 
>>>>> snd_hda_codec_atihdmi soundwire_amd soundwire_generic_allocation 
>>>>> snd_hda_codec_hdmi
>>>>>     [  175.486373]  soundwire_bus snd_soc_sdca snd_soc_core 
>>>>> snd_compress snd_hda_intel ac97_bus snd_pcm_dmaengine mt7925e 
>>>>> drm_panel_backlight_quirks amdxcp snd_hda_codec snd_rpl_pci_acp6x 
>>>>> mt7925_common btusb drm_buddy cdc_mbim mt792x_lib snd_acp_pci 
>>>>> cdc_wdm btrtl drm_exec snd_hda_core snd_amd_acpi_mach 
>>>>> mt76_connac_lib snd_hda_scodec_cs35l56_i2c btintel 
>>>>> snd_acp_legacy_common drm_suballoc_helper cdc_ncm snd_intel_dspcfg 
>>>>> mt76 snd_hda_scodec_cs35l56 snd_pci_acp6x cdc_ether drm_ttm_helper 
>>>>> btbcm snd_intel_sdw_acpi snd_hda_cirrus_scodec snd_hwdep usbnet ttm 
>>>>> snd_pci_acp5x btmtk snd_soc_cs35l56_shared ucsi_acpi kvm_amd 
>>>>> mac80211 snd_pcm r8152 i2c_algo_bit snd_rn_pci_acp3x typec_ucsi 
>>>>> snd_soc_cs_amp_lib libarc4 spd5118 bluetooth mii drm_display_helper 
>>>>> snd_timer cs_dsp kvm typec snd_acp_config hp_wmi snd cfg80211 
>>>>> libphy amdxdna roles cec snd_soc_acpi ecdh_generic sp5100_tco 
>>>>> hid_multitouch irqbypass sparse_keymap rfkill rapl mdio_bus video 
>>>>> gpu_sched amd_pmf wmi_bmof snd_pci_acp3x soundcore amdtee 
>>>>> i2c_hid_acpi serial_multi_instantiate
>>>>>     [  175.486384]  i2c_hid amd_sfh thunderbolt wireless_hotkey 
>>>>> amd_pmc platform_profile wmi mac_hid i2c_piix4 i2c_smbus i2c_dev sg 
>>>>> crypto_user loop nfnetlink ip_tables x_tables dm_crypt 
>>>>> encrypted_keys trusted asn1_encoder tee dm_mod polyval_clmulni 
>>>>> ghash_clmulni_intel aesni_intel nvme nvme_core nvme_keyring 
>>>>> serio_raw ccp nvme_auth
>>>>>     [  175.486394] CR2: 00007f6b1092e888
>>>>>     [  175.486402] ---[ end trace 0000000000000000 ]---
>>>>>     [  175.486409] RIP: 0010:amdgpu_bo_create_reserved+0xb1/0x1c0 
>>>>> [amdgpu]
>>>>>     [  175.486416] Code: 8b 30 44 89 64 24 20 48 89 44 24 28 c7 44 
>>>>> 24 30 01 00 00 00 c7 44 24 1c b8 02 00 00 c6 44 24 08 00 4d 85 f6 
>>>>> 0f 84 a9 00 00 00 <49> 8b 86 a8 01 00 00 49 8b be 40 01 00 00 31 f6 
>>>>> 48 89 04 24 e8 d6
>>>>>     [  175.486422] RSP: 0018:ffff97b14e097ad0 EFLAGS: 00010202
>>>>>     [  175.486429] RAX: 0000000000000021 RBX: ffff97b085af04d0 RCX: 
>>>>> 0000000000000000
>>>>>     [  175.486433] RDX: 0000000000008000 RSI: ffff97b14e097ae0 RDI: 
>>>>> ffff97b14e097b20
>>>>>     [  175.486439] RBP: ffff97b085af04c8 R08: ffff97b085af04d8 R09: 
>>>>> ffff97b085af04c8
>>>>>     [  175.486444] R10: 0000000000ffffff R11: ffff97b085af0560 R12: 
>>>>> 0000000000000002
>>>>>     [  175.486448] R13: ffff97b085af04d8 R14: 00007f6b1092e6e0 R15: 
>>>>> ffff97b0a0f00000
>>>>>     [  175.486455] FS:  00007faf60ffe6c0(0000) 
>>>>> GS:ffff97cfa7133000(0000) knlGS:0000000000000000
>>>>>     [  175.486460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>     [  175.486464] CR2: 00007f6b1092e888 CR3: 0000000101c3f000 CR4: 
>>>>> 0000000000f50ef0
>>>>>     [  175.486470] PKRU: 55555554
>>>>>
>>>>> Admittedly, it's my fault that ISP4 stopped zeroing the BO pointer 
>>>>> argument
>>>>> (&mem_info->mem_handle) passed to isp_kernel_buffer_alloc() [1]. 
>>>>> But since this
>>>>> issue slipped past Bin and presumably others who reviewed the code, it
>>>>> highlights that isp_kernel_buffer_alloc() is not working as 
>>>>> expected in this
>>>>> respect, and the description for isp_kernel_buffer_alloc() 
>>>>> reinforces this.
>>>>>
>>>> Thanks Sultan for suggesting this fix. Yes, its hard to believe that 
>>>> this
>>>> slipped through until now.
>>>>
>>>> Instead of initializing *bo=NULL, I suggest ensuring *bo is actually 
>>>> NULL
>>>> before calling amdgpu_bo_create_kernel().
>>>>
>>>> int isp_kernel_buffer_alloc(...)
>>>> {
>>>>        ...
>>>>        if (WARN_ON(*bo))
>>>>                return -EINVAL;
>>>>        ...
>>>>        ret = amdgpu_bo_create_kernel(..)
>>>>        ...
>>>> }
>>>>
>>>> This way the caller will get to know parameters passed are invalid 
>>>> and can
>>>> take care of initializing the handles appropriately.
>>>
>>> Hi Pratap,
>>>
>>> I am opposed to this idea for multiple reasons:
>>>
>>> 1. *bo is an output parameter from isp_kernel_buffer_alloc(), so the 
>>> input value
>>>     should not matter.
>>>
>>> 2. The only correct value for *bo is NULL when 
>>> isp_kernel_buffer_alloc() passes
>>>     it to amdgpu_bo_create_kernel(). Since there is only one correct 
>>> value, there
>>>     is no reason to burden callers of isp_kernel_buffer_alloc() with 
>>> intializing
>>>     *bo to NULL.
>>>
>>> 3. This adds more code, another WARN_ON(), and another error case to
>>>     isp_kernel_buffer_alloc(). All of that can be eliminated entirely 
>>> by just
>>>     initializing *bo to NULL in isp_kernel_buffer_alloc(), as I've done.
>>>
>>> 4. The reason *bo needs to be NULL is an implementation detail that 
>>> is internal
>>>     to isp_kernel_buffer_alloc(), because amdgpu_bo_create_kernel() 
>>> needs it to
>>>     be NULL in order to allocate a new buffer. 
>>> isp_kernel_buffer_alloc() should
>>>     handle its own internal implementation details instead of punting 
>>> the
>>>     responsibility onto callers.
>>>
>>> Sultan
>>>
>> Either approach works for me. My main intention is to ensure the 
>> caller passes the BO handle initialized to NULL in this case. That 
>> said, initializing *bo = NULL as you explained is perfectly fine too.
>>
>> Reviewed-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>
>>>>
>>>> Thanks,
>>>> Pratap
>>>>
>>>>>>>
>>>>>>> Ensure this by zeroing *bo right before the 
>>>>>>> amdgpu_bo_create_kernel() call.
>>>>>>>
>>>>>>> Fixes: 55d42f616976 ("drm/amd/amdgpu: Add helper functions for 
>>>>>>> isp buffers")
>>>>>>> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 2 ++
>>>>>>>     1 file changed, 2 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/ 
>>>>>>> gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>>>>> index 9cddbf50442a..37270c4dab8d 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>>>>>>> @@ -280,6 +280,8 @@ int isp_kernel_buffer_alloc(struct device 
>>>>>>> *dev, u64 size,
>>>>>>>       if (ret)
>>>>>>>               return ret;
>>>>>>> +   /* Ensure *bo is NULL so a new BO will be created */
>>>>>>> +   *bo = NULL;
>>>>>>>       ret = amdgpu_bo_create_kernel(adev,
>>>>>>>                                     size,
>>>>>>>                                     ISP_MC_ADDR_ALIGN,
>>>>>>
>>>>>
>>>>> [1] https://lore.kernel.org/all/aNB0P18ytI1KopWI@sultan-box/
>>>>>
>>>>> Sultan
>>>>
>>
> 


