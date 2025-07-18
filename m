Return-Path: <linux-kernel+bounces-736240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CDFB09A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DD73B9211
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E831CBEB9;
	Fri, 18 Jul 2025 03:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o+5eCNo5"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8A1C84DD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752811045; cv=fail; b=UtEaTAyaYzccnmezAeFX0ConvFEWB7pg3o0sCfbRdG6eD10K21vt92afs/WdZKNWLLlk6Rp3u/d4TDZ6iBw16cXAC5CJb/51WvdTDAzEwCaSVPOxqvdS0by1O+hT2nL9PakZtpkyhARu2RBGKbz3G2AMU8mu9qz2Xyyf9BTpiFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752811045; c=relaxed/simple;
	bh=/T8sWBQYe7zK115icbePHGDCOEzhrt0N3nY4/eAEUO4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=huzeZkMMFPcsUkD6asae8lHnEVR09euayJVYw1c82KROFmaYeooJvzEH2VPqvvwM0fkuUygDYFVz75PsHHWb+gneJYofkJ63wvutdrphrRO24GMSALYMQdb8s9eMp3FBYBu0kKHbOHu4Ue9AUTSU0WYtdbV56GYji9a5ojxVx94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o+5eCNo5; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erZ1Z/Rtt6InipEMh38SV9N4AhRtOHC3y9Kj2jBCAb34t3hnqX3KnYIW8CMoDLWFJ4PJz5yHIrW3dp8yvr2R1eT1Jt+1qtxqKxSmxcbr5j7Syj6lKk5WKPr7nOOhoNDP+QoVQvRsIbBuPVfFOMimNiJEED+b9XfFv7BI/tlTWVF8ALeEGGkrJ/9njBQwi7bAHU9jOlOqbkkzJw+CFbLpXfZTiJf2+dkmM/JP5tjxDEjArEXy5q+sU0dhtS/eKcQfPduQSVurg2sm6/joj0nOF587nC0tJhBVk9uWG/x2HIjW9wd4lT7kY/UKuLkkVOfeVcH0/3y/1K6ksvIRm1vqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bmbc5mGeaZNqueGzPPSK3rEXUbKD/ajFiCBGz2PfL/M=;
 b=mqvQ4ss91u3NtkJDdSCd9PCOMXWhYAXF1QnVRaO9HRZ0e9chS3AYaGOMtQHYxkPTbJvzxhLwlWMzfwrGhCXhrMPx2ulEYCk9dAl71Uw3CfjFQZQwU0pAloJw2VL58i8qJWrxGW52DpG0rUUczlwSwi/30NhqnLKNBpH7onAnyMMmbDXAzMQWMLDDYrqPdHeo2WXQJBzYud/gABwOIqkGSO92ujX6eIL0K+NAXMImBkLoUhLz2MEuvX3yh4TPybavyzijdshIGbA8UsMsILXLLsqqFZ5ae/5Td0YdRsIQW3zu+PU52WE59Y7m4z2rDZGkYZL/S/64G2OkVtJrlX/J7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bmbc5mGeaZNqueGzPPSK3rEXUbKD/ajFiCBGz2PfL/M=;
 b=o+5eCNo5WQytL0JVSg+ZRvvZn+PMDNrdojoc5r2YOotzUvkgFcUjSBvVD8+Jl3RwiN6ACQkJUcCOYPEkKY7UZCDIxpKqdn9eR17C97lPrR3ffEYiCbIrY6kdPtIsZq94TQF7hYO78TP+gpLWqYRN9PK5Yfbb8beb5EkP0A1lx9lCBcDYJxG1jls800efa3ET/exrg5IPOIe3OeFO7ijX/QYTtkRZ5Z+LkRbUd9+Y+TjDjCUln5WiCa/3E75mAPo8UjeHqco7b7m97T465ZTWsnidxDkprLeUe8EikryQq1Go+2L78IuMwLfrVItH3QHXD/e30DXDgqbo4u2DY5pU1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 18 Jul
 2025 03:57:19 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8901.033; Fri, 18 Jul 2025
 03:57:19 +0000
Message-ID: <09c5ce76-f7c1-41c7-97e1-74448e6143f7@nvidia.com>
Date: Fri, 18 Jul 2025 13:57:13 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 00/12] THP support for zone device page migration
To: Matthew Brost <matthew.brost@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <aHmJ+L3fCc0tju7A@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <aHmJ+L3fCc0tju7A@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 35495cb9-65f8-4ba9-a1ab-08ddc5af3158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0puRWZ4N2J3d0o1NXliclk2ZkY3UWRxM2NnWmNJbmFvYzFPcXRZYXEydHZU?=
 =?utf-8?B?bEZSVFRtbUgrelU0UFdsU2dvZmJ5eFdOWTg2YU01RWNGUE5Hc2kvZTB5Ujcx?=
 =?utf-8?B?di9GcVpyMGh5RHU3QnFRcHQ3ZE9pTU5iSm1YRGZwN2U3Wmljbk5IbDQzRWtn?=
 =?utf-8?B?MUwyT2FtM2ZiblpwNThHTWE1M0xmVjRWR3NmUWd0Umk2bTlKVEhzQUl0T3V3?=
 =?utf-8?B?U1ZQR1BSTUtFZFQ4WHVJdlZsU1Y5THcvUmZaZ3NYUUtWQ0FERlhxdE9PUnRL?=
 =?utf-8?B?d2ZxaEdoem44UU9SS3J2V1lCazh5eXBYbllaRCtXWVR6L3J4SGl2TDd3SDc5?=
 =?utf-8?B?S1h6clptbGVKN0QzOXZEczllOG9mMDRiajNlbzRReGl0eEsxdTNzWmh4QTNG?=
 =?utf-8?B?U2hsVENVNmlMLzYvaW5Iem1rNVBVMnBxYTh3Y3NPTGpESUswL3ZhNXg3VHhF?=
 =?utf-8?B?aytZUWdteWtUdjdKdU00QStCcGxja1dKQ05UOHZFVXVST0FYUTd1dnVPOElF?=
 =?utf-8?B?d3BtTDR2Z1NxdnpZMnZ3Q3ZIRzlnRkFuVTFzRzEveUtaMjVrMUY4ZTFJVGNZ?=
 =?utf-8?B?TDZ2OVQ5bWw3UENKbFl5a2ppRW93VE9xdzIzc05tb2RLN0M0TnB1QVlra1RL?=
 =?utf-8?B?ckhtQVhwU0V3VUdwUzFnR2pCcHQ1VmtuOVh5TFJ1QTlQcFVCbkFJQ1dBSVdx?=
 =?utf-8?B?OGd6Z1ZFSFptbDgwOUNQTXJodTNlRUxNUXJSYk9yaVVxOHpMRHdWRkg2MlJG?=
 =?utf-8?B?RXFFNityUDZSYUw2NTVvNlZzU3Bpb1hGNEFoQkpQSTFmTjR0ZXFZZWtTemRM?=
 =?utf-8?B?VnlRNjNpRU9UNkVuQWdkYzFBWkhOVjRwYVEvRm9TMk5nYVFyNUgxWnpxZlhx?=
 =?utf-8?B?MXlXMkw5UEdNdlJiaXVvdzY4dlREOCsyRG4zeGx5MDlnSzluNmNoVllzZXR6?=
 =?utf-8?B?NS9RSWthUnlKYVpmYXo3eDJSRUc2VkdzR29SZC8xSUFGSm1iRmsvWEdZRGg3?=
 =?utf-8?B?Q01NbWZKUUxVZVpXcll6elovcDd5YVpFcjJjcE54b2hhRGZMSWpGOVVMNUcx?=
 =?utf-8?B?eldDWm1KM3YxU0hVV2VLVE83QkN6QXBPZlBVU210bVdPaDVEOTdvbm1ncUMv?=
 =?utf-8?B?K1JUOFJlYVptVHJvUlIySldFOFN2QnB2WjVpaVppQjhxTWw2clZpVEhrZmY4?=
 =?utf-8?B?bDRYRUF5aW1RaDlDU2VvT1FDWERYYzhZeFlpTSt6V01yZGxqVThQdmNKUnJ3?=
 =?utf-8?B?ZEhnanNHRDl0MzVwK1kwSE50QTYxRG1nL1JTQ2RJZGZjZFhHSkp6cW50czZP?=
 =?utf-8?B?VWZIMkZXL0N4Y3VYcGFuYUo1MHNTY3BaM3VHcTFIaTJYZFBOTzBBaVFjaGcv?=
 =?utf-8?B?SitjbzYxSXBRNmpMVExpVFdrOElBSGdEbGlCNEd2K2tFaEZURWl3L1JFNjdQ?=
 =?utf-8?B?MXdDQndHV05teXU5Y204ZGZOclVZYnJydHlXbE5IY0FJMUNWL1VLUzl3WFFW?=
 =?utf-8?B?RlE4MEpKYjFmRlRWaUU5UlRyVVg1YXNTYkhRNkppSFoxbWxaejNnUVNSL0Zh?=
 =?utf-8?B?UW1IT1pXT2RjWHlEYW1ZemN3VnRoSERzYkRhVFRkTEEvODMrODBRTEZJQlpw?=
 =?utf-8?B?MlBWam8wT2JBdUFMUS9IQWN0WFlKSWJtbzU3UE1mNmlrS0JjcE5RSFUzMDMw?=
 =?utf-8?B?SEJId2toa2dqVTlYNWJmYVFGQlh0d3RLWEFCSk1tVnVNYUFlTktNQ3RaWkpk?=
 =?utf-8?B?bHJZUnBjRU5sU3FoUHZTOHI2YVo5aW8wcVJoU2t3MXNsbzdDZFQ0OEthYVNX?=
 =?utf-8?B?WTlmSGJLNkxUVlErdzlZeTM3K1A0ZTBDTWpjaGhwQ1dpem81aGJWOFgzcGhR?=
 =?utf-8?B?aHB2MTA1L1lLSmpwM20xUlppVExXSnVFNTFxcDNRWDhxQS9VMTlIdHd5RU9V?=
 =?utf-8?Q?zDC+/Ldgjoo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjdnQm03NTE4RHo0dS84WmRnT0p3eGtGSXZEamlLQmFzZEd2RGlwM3E0Qjdu?=
 =?utf-8?B?QjN1aG5uMHdLRENYUjB5TS9YU3ZQaUJobnpzczh6SmtXeHdpRUZ3MGJrcGZT?=
 =?utf-8?B?RGlHN2pLWTV3dHRZVW5XNVNhT2YyNkFVdVoxdFBrMmlJaWJLNTJDMjBXTVNJ?=
 =?utf-8?B?dmdWS29wNHVCUFpIbzRGcTlSYXBVdzFlU2ZPNHJMdENLNnBOOEVTVjZ6ckZL?=
 =?utf-8?B?d3piNXpWdW9TMUF6VVpXWkNsdDZ3Z2NVdUhaSk9BZ0ozanBwNERKNlhwY1Nh?=
 =?utf-8?B?ZURETXdjd2tXcndOdzUxL1hJbWwwYi9BcWdYLzBjQTYrTkNDakJubUNSNXd1?=
 =?utf-8?B?YW0zYkIvdXNmY3NWL0VSK2dNb3dKdGdBUW9CU28xOU5kQ1NNby8wUlphanJ3?=
 =?utf-8?B?YnJSNWNNTVFXLzZCOUp2VlBEcS9uSHlBZ1JIOGl0Sm05NHdabGpsR2xZbU1y?=
 =?utf-8?B?bFVJRnVOR0Y4SUtEQ2pNQUhucnVHNTRjRHNsODgxcHpPVGtaUXBhN3RtRzc4?=
 =?utf-8?B?ZWt2SERQMjY5TDQwa2xuaWFMRnBzem1nL1lTdjdWN2ovU0d5WW9rY0ZkbUE4?=
 =?utf-8?B?aWJZa2NCMTV5Y1E2dDNMU1BzeDdIdW12TjhQc0lkb25qek91eWVwSjU3VGpQ?=
 =?utf-8?B?WVZoRVFzWHJvVVpyblI3R3J5eVJVVzU1R2c4V3ZMQzUwa3o5VDUvQmFGNVBM?=
 =?utf-8?B?ZWRNV0pSZ3JacDJ3ZWcxYW1DMDIyNE1MblcxTE9RSGo4Q0JxU3dJRFJxanM3?=
 =?utf-8?B?TEIySmowdzZwMU5LczdHVXBSWDYyUTNlT2xaRmZMWFJ0K011WFFEVDA5cFFn?=
 =?utf-8?B?a2V5TjJiRlUvS2M0Uis3bkk5WlhSR2w0OUJmYWV6RHhFZHNCWi9HTWVDWGk2?=
 =?utf-8?B?OForQndoNWlqNlFGSG52aUhKZUdoTC9DWXFydDN6ZndjTEtvbUJPUEpVYkhC?=
 =?utf-8?B?WXpvYlk5UHhNc291Ymw5SG5tZFlzWnVXVkdDbm02N0dhZXQwelE4TkhlY1Fn?=
 =?utf-8?B?dDE0RjNFT0pTcVZrVEdVcVBhRWs0V3AwVVhKVGZYSmd6MENUcjJiaGpzZ1pW?=
 =?utf-8?B?WXZZaEJycjFoOURpV28vTW9rcmhtVk1XM2Y4NTViMHV2cktuVHpDZVJrVThN?=
 =?utf-8?B?c290YWNQT1Ixb0ZYb0VZRE1YOXJkL2c3Q3NtQ0xOdmdKYVdKUS9uTU9PUzRz?=
 =?utf-8?B?TzZXTmRFSmZSRkZoSnpiNFNWSWlnZ256c2RRWVhqNDluZEZWN0wyL0dRMWw2?=
 =?utf-8?B?bGlka0h1R2g3bUt4OHBIaW1JbWpLMjJuYVVQcS9RT0s4SXpYWEF0bHlpQWlL?=
 =?utf-8?B?RlRCdlNBZ1dWS1hJMi95MThrNEg5QTA2aTVFYmNyVnlwNlB4TDZpdGRWUkxZ?=
 =?utf-8?B?WnJLdXpHNE1YM1Avd0laVVNMcGpNSzRyTXNIZnpuQlNmYmxpUkJWTTBrWEUy?=
 =?utf-8?B?RFdJdTg0QlczNVM5SlhKUitNbGVaL0hHc1FGQ2pIaXU2Q0kzTnNuTit4Smho?=
 =?utf-8?B?OVpJMDQzQlVrR294bHl6SFRseXlYM2VhSmJLQ0UvbElwZjdBMUMwRi9RMG1V?=
 =?utf-8?B?dUJ1ZUtqZXJGQ2ljM2QwQk1XbHJ2bDhvanFjVldWUkYwUnB2YzkrUU1BVWtI?=
 =?utf-8?B?Z241UGRZKy9XRkdjRjBEUlVzZnVJYXZnUFQ0b2hpVjhHZldiVFpEeVNwSnJ1?=
 =?utf-8?B?aGZsakgzeEh4Vm1iZThjWHprSEltN3BDcFpraEpWTkNWTEFRODRZc21DTkty?=
 =?utf-8?B?cGp2MW5WQ0ErTFRPV21qTXE5YUxUbXpVOEsyemtSWFV4VnhwdUtxNzI4TEJk?=
 =?utf-8?B?bndsVUpPaGtzQW55TVJrc2drWVF2KzVERzVrWm5PWEp4ejYrckMva1VpNERy?=
 =?utf-8?B?RC83SzY5NHZxYXlBNFF4WEd3RGxjam1USC9GdnNSOENZcXN6Yndyc09DU2NP?=
 =?utf-8?B?OExJbEFUM1NsQUtkdVpNNStYZVZ6ZW12SHdaNVdldnduUUtPQVRMMlJ2MjVB?=
 =?utf-8?B?R0RBWVFwZFpyRnU5SVppcVVSRHUzRTJabmRUbXNsZStDR0NDUUlSOCtOSjBX?=
 =?utf-8?B?ZjBaa2VCZ3orTlhyZTZnOXVLVUlpaTk2b3Z4NUZRSFlaRm10UHRsRGlNQk5F?=
 =?utf-8?B?QlZWRkJvVDlTSy9IUjBhOEFFdy94NGcxVld6N29LL2h4Y3RMWFMzOG1Ic09k?=
 =?utf-8?Q?PICZYci0VhNWH+UDO5NFS7P3h0m0S12H8ouInOi/amqq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35495cb9-65f8-4ba9-a1ab-08ddc5af3158
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:57:19.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjwR2J+eiB7yvpZlJXoEyGfd0nQWFdwcJFAl7/gW0Ek08uOIfRtJccS69Bywgpl5b3pFMRO3K1CXPktKr6XfXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608

On 7/18/25 09:40, Matthew Brost wrote:
> On Fri, Jul 04, 2025 at 09:34:59AM +1000, Balbir Singh wrote:
...
>>
>> The nouveau dmem code has been enhanced to use the new THP migration
>> capability.
>>
>> Feedback from the RFC [2]:
>>
> 
> Thanks for the patches, results look very promising. I wanted to give
> some quick feedback:
> 

Are you seeing improvements with the patchset?

> - You appear to have missed updating hmm_range_fault, specifically
> hmm_vma_handle_pmd, to check for device-private entries and populate the
> HMM PFNs accordingly. My colleague François has a fix for this if you're
> interested.
> 

Sure, please feel free to post them. 

> - I believe copy_huge_pmd also needs to be updated to avoid installing a
> migration entry if the swap entry is device-private. I don't have an
> exact fix yet due to my limited experience with core MM. The test case
> that triggers this is fairly simple: fault in a 2MB device page on the
> GPU, then fork a process that reads the page — the kernel crashes in
> this scenario.
> 

I'd be happy to look at any traces you have or post any fixes you have

Thanks for the feedback
Balbir Singh

