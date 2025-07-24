Return-Path: <linux-kernel+bounces-744792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FAFB110FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47730AE3283
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469E029ACC3;
	Thu, 24 Jul 2025 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sq4Ac64Y"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0D2701D6;
	Thu, 24 Jul 2025 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382387; cv=fail; b=U572XjCo5bKjLWUFoL98OOOWOU2w55MPD88kUDvgJfP9fyu3Vh8KxUWrlncuj1maCHisdqcj3vZr9ASDsHIXhoCjQSkKYOzbPW2e9zoqBuCs1Nd/1dGgjCEscHmJEhcbHyVNmqbLjq7zGB9EcVZY/PG8A1/iW/rjKKS4rMPU0zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382387; c=relaxed/simple;
	bh=ciMGo+l96eMiWkSA61mJJhYfT3JQ6tEy13lcAhS8NVg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pdujQmw1Ee1/4inQd4D4lfGRq+PP5IhMIDunnbRHCE7rR8U/TkAxYvDDza8U+Yp179H3ZCGP4Bk8XHdUgiu5oe5rMPAE0bd6glHNbaHhnULzotAUCoV7Vo0LS6bYlq5pli6wOuaHJ2j7HVjccDIzW5bPzkOfR/wWkcLcDKHZh0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sq4Ac64Y; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZ36rb5CrEOUQ4hCG8o3qkZ+dNpaQ3LrVTpx9fAXCI0u/eZBZLZlFwsPNteQExCKG/vLZ2+/hVtOH9j68x70fSihLBju9ZL9QFRbvx+FjwIvLNdguG4YsYqfcgv3Upvh0ubmf+wlxTHTKgTLJvzgXWEvgnLvmUoEpnpg7q3BLSyPhfuBK4xYkQ+Aw3Ttwu/OIdwhaBlPMogDkb3YHa/xAV4YOhCoucqVp6W6bIMr7ZHkuddmk8GE4kS9qxd2rXLi/Z6E1kl4BD75dV2RRBHQDNTizAvPrrQMg6z9gGESS6p2U61uFYl8Tv5RZeD1C1mXZancj8oU5fEDnnPawDPf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEC0VemRdq0/N7lx+hZJJTGGMpSOQZlh9yrD2F6iLG8=;
 b=gDw9j7X5H/o8REaKL+vB6ucIEv7fR3OyRu4ZkK5/XOZ8B1kbFpIEyCULVAOGvlSV8uyMJiymTjHtosLm7RYzokBnA2vvcGvi4WqhOjqlA1nK09O53hENpH2IsiDVjmk+NcQ26rxLpOeJFZ2CdlS5O6CZx+rY2SMEUu8EqQmTDZbLPhVdh43JeqV5xSYxXWCd8nIHkuIcCB0fzJWjUenwtnufg6jERp5+oGrxW7J6qy/Z0Dx/eft/WRKV7XUTHzCLTasGKSWdiV7fh2pbEaiheqEktErlxMs9/TdfC0wkI+lEmtWmkKhDR/eUn/JlpDaIIDBZy0x0pfa5NKKkEoN88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEC0VemRdq0/N7lx+hZJJTGGMpSOQZlh9yrD2F6iLG8=;
 b=Sq4Ac64YJsva7EAhhbkvJOLx2vdsIP9cwZFM2Q82xMNw+sKLoBeZlQyisWmE5hMi5F/veETOzFezeOAr8TB8M1pWWPUcIdIo1Ri/k6DKuPbp8DSgv9RuFGCqaoW4IMz/5wcoqmt3qbErj85aejCDld3BPeEgP50eN/3KYKAcu9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Thu, 24 Jul
 2025 18:39:42 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 18:39:42 +0000
Message-ID: <a6a3ff44-a755-44aa-a862-89717c80f805@amd.com>
Date: Thu, 24 Jul 2025 13:39:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (k10temp) Add thermal support for AMD Family
 1Ah-based models
To: Bjorn Helgaas <helgaas@kernel.org>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux@roeck-us.net, jdelvare@suse.com,
 yazen.ghannam@amd.com, linux-kernel@vger.kernel.org
References: <20250724154423.GA2939389@bhelgaas>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250724154423.GA2939389@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::34) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac5bc79-55b9-4953-57d6-08ddcae1741b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTA4ekhJK09TSlZrak4zZnk0THErYXVZSytlRU1MbVI5Vk5jKzBqZlNNRzhp?=
 =?utf-8?B?ckFIY1F1ZVZtYU1kS0hUZGJ0QWxXT3A1V3NLNkRKSnhSTjl0aW8ybW4vRUI5?=
 =?utf-8?B?MGhNVmtBRDlMOHQ5clRLek1lVGFFblorN2NOQXlNL2FQZURSeGNaL1RGRTNO?=
 =?utf-8?B?dnlMeGt5WnBVMFJxajdqeXdnZ3JEbCtnNk44and0cGJjQ2NpQTd1UWl4N202?=
 =?utf-8?B?bWxiMXNIVEk5MHlLRU9pQi9hK0t0RWxTUEM0dDNWWTJneXR6MjFGMVhRRWdu?=
 =?utf-8?B?ZjNLT3J2OVdPc2FadGt5KzIweGdkd29RTjBCdUU3S1ZTMjZQVlphcXQ4eEdX?=
 =?utf-8?B?K3hOVUNuakx4eWI0b25TalBhc2J2ZkxDUG1lTkhqR25VdzE3Y2hmN2RYdEpS?=
 =?utf-8?B?UlE4bEdsL1BUaXNWVGE1N2k5OWxmMHJpNXNSM2ozMG1ZQjh5NGw4SUM4MGY5?=
 =?utf-8?B?d1ZlWWlWbS8xZGpUNVEvRXJaL0RhdG9LOHR2RmIvZVJkczl5SnFOS29DRzlr?=
 =?utf-8?B?RUJ3NFVlbHI5cEpmaEpHeDFSVUlnSDdJdTd6Nk00dGpnNjBWY09sVG45NFFZ?=
 =?utf-8?B?Uk1IZFAyVmJZT3lZWVdwZE9ydEVOeEh1bGlWZ2wxWDZ0eW5ZUlBDM2UyanZO?=
 =?utf-8?B?TG1YRE1zRllqMUZtVGhYMXdXYlVWMFdZaW9PKzhnMWVrS1hreG5zdC9nZHVp?=
 =?utf-8?B?bnNtUHlzUSs2NnM0MjdiTTBDOU5IRi8rNlErQURQNHdxY25WelZuMCtMeVF6?=
 =?utf-8?B?amx6OCtMNmNZUGlLaXgyNXR6RERwdG1ZUXowWDEwTDZrS2ZkRjNZd3o0R1NI?=
 =?utf-8?B?SjJLbnI3UnpjRTV6R1ZTcGJXM0E1VTN2cjJyaURzMzlLQ0x1TXdwa2RzajBs?=
 =?utf-8?B?K1pIVzNFTXo4OHFDckM5ZmdCVld1eTVqcnZTbktjTXJCVjA4MzZoQ3Q3aVlJ?=
 =?utf-8?B?b3BrU3JwcE85M203TjQ4MytEYkdLM21nZEhvQ3VnMllRNmFZalFLZFpQTEgx?=
 =?utf-8?B?SnV4QlFMNE5CRVEwSXRSRGFFazI1ZjJZbHkyRHYwZ3hWaWcxYjh2dEJPVGh3?=
 =?utf-8?B?eEYvaktEMzJpMVdncGZJVmhyMWpvYXdMRlFTek9TelJITWJYWlF5QUM0RC9h?=
 =?utf-8?B?SzFwN1hkQ2M2WHlQcHFCR3BpN2dGdlhYVFBxUXFnZjliZGlncmtnUzNuMStr?=
 =?utf-8?B?SFdjMG0rMnVyUjM3QlRuQ29HSVVkdDVZTE9LSkVCcWphQW5ob3liTjlML1pH?=
 =?utf-8?B?dUthMFAxNjhUekppdE1JMUR2ZzRlUVVDUmNoa2J6TU1xc09qWHNPRlAvREIz?=
 =?utf-8?B?RUtkTWhSZU5GT3hpUlBnbjF3cUZoZjl3MUZJVmRrSUU1WkRRNEkrQTNnK0tM?=
 =?utf-8?B?TUVlYnRpVmxaTWtFZ3VlUmxJUDUvdkNwKytWMVplWUZzc3JTQ3IzcTFpbmow?=
 =?utf-8?B?LzY1WXNKbFA5SEp3Q0hseXNVSnRzMmpXUnpnQUQySFJOTzNZZ2ZydmJSMFFr?=
 =?utf-8?B?WEY3dlRnNE55Q2dLUHlhSk8xb2R6c01BdzRUSEh2L2JtTE1mczRNbjQyamNJ?=
 =?utf-8?B?bjVlUnhiMDFaUDNzcW1aVVJ4U3ZlNHVCSzUxV01MbE45cithM3NXOGpZcDRa?=
 =?utf-8?B?bHBUbCt2ZGpWbWI0dGplVlloVWNCdk4yUkNHN0tMd0lMT09ocWR5a1NnUStY?=
 =?utf-8?B?NkpIT0wwQ0FZaHJpTFlkRVVpajRLS0NvQ1JjM3Nwa3JQS0tBUCtSWGVyWVBI?=
 =?utf-8?B?K2VpTHRlRXdHb05RcjZZWUFnVG04MUhWdnZIY3ZXbU1JRCtJeUJpcnJRUW5h?=
 =?utf-8?B?Lyt3S09ibDA5VXlZWGFkN05tejVHRzhvYnE3TG9TU3pyUWJBNmRyTi9tMTlM?=
 =?utf-8?B?YXQ1M2pndkRlQnpuMnpWQTVoUmQ4UTRJZmZRdndkbkFBcEFVYStKaUZkVnB4?=
 =?utf-8?Q?xBkor6eKKOU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2hmVFZydGZjNHhQbnBLQU1EbG5Fc0E3b2xWd3J3RFdRdmNBRTJRZ3ZRQ1VK?=
 =?utf-8?B?T1dpclBNY0RQdHRuZGNGVkZhcXRSNEJ6Y051QUtPclZ1REJmNjdMSy9iNjlq?=
 =?utf-8?B?ZXhTNklLWHB6OFBjR09tcC83OUpmOVJDRUkzbnhKVFd4YWduV3ZLeXo0NVNy?=
 =?utf-8?B?UkZNdkRsTm1ncmFneHRJZi9ZQkhyRlBCUnErUDFlZWVjN0xad1RmMWRaVjRN?=
 =?utf-8?B?ZWdwUHhUU1VvUGhhMjdYRDRQVmUwTzNpcVh0Znl2dWVWOTE4Y3NoR3hnMVpz?=
 =?utf-8?B?NHJFNUZORFJ2UGhnUi84aVJXSHFlb2VPRTd0RDl6Tml1azZPa0x3Y1JFTTUz?=
 =?utf-8?B?NHBIempFd2tWSTB4MUdFSHd4enlWMTV0YWowRVhlaERyY2FIN1NlWVhTZ0l1?=
 =?utf-8?B?MkNPY0ZvUGVFRmt5RUgwTnNneUJBMlQ4aGxYdkxXSlkzL2JGTThLRkRvbEVJ?=
 =?utf-8?B?TVNkem5tUE9QbGowYTFCcjhXbm0zaWhMbTkzcktha3BMTDExZHpSK09yTThO?=
 =?utf-8?B?aGdHeU5GZVowY1Rya0txRjlSbUxHbnUva28vQnJ6RzN2bDBDamFNS1pySnNH?=
 =?utf-8?B?RHJnV0NXQmQvVFNYdUFHS2s5QUk1ZXltaXVsN0NlYWtsWUd5Vk9YeU1rd0M0?=
 =?utf-8?B?elowV1ZPcStpZituRUVyK0FXSFU0YjN4M0RZYlUwYUl0TGlBZDJtMEI5Zlln?=
 =?utf-8?B?cGZaSnkvb1ZYK0NVckM3b1NuRFlpL1lIelpVbHhxZDExSUkxRkp4eVJkR2Fn?=
 =?utf-8?B?YXVSamhyZnU3UWtoK3dIUG5Zckd4ZFJiaE90ZmNRWisxeFRKZ1dBMkhnR2wy?=
 =?utf-8?B?R2dFbU9BNzFmV09IbU15MU5DSitJaEIvM25aVGh6bkRBdHBLOEFqYkx6b21x?=
 =?utf-8?B?ZXVZb2o5TjZkMHBOaGVQcW9NNC9ybi9qU3dQb2VQdzNvbWdDZE42QWVFNFlD?=
 =?utf-8?B?a3g2ZDhEaEVxMjdlSWs5MkNxd1VVaFRMM21pQUVvc2VBZ2RPbVVEMERFbE56?=
 =?utf-8?B?QnZYcjEyZUtMZWdRTmprdGpWdWtlazNESE92VHZsRklHMHlFSE5aKzhHSHJ5?=
 =?utf-8?B?TWdCbVN3UmgyeWVGSitVL1AxMElIMGlZbEpMc1p5WHA5UExKOEJKMklRbmsx?=
 =?utf-8?B?VXh0MlpVL3VORTJBZzhVMmpkcUhyRUsvRUJiQ3UyOHplcU9pZmExdnBHMzBB?=
 =?utf-8?B?S2U5T2hHQU9ReDBCQ1BRakVpdjQ2UkxDUmZHSVhMMnZVbTdJMXEzWkhqT1lS?=
 =?utf-8?B?czU3by9HN1l1M3NrTWdpOXVRYVNnVk9sRGpEMzA0YWNTQkpza3k2RGVTRlcx?=
 =?utf-8?B?enZvS0VuaVZsRkFLZ2YxN3d1NjdxMzc1UHFHZDRGZmJsaWNnbEF0dXdiWEg4?=
 =?utf-8?B?aWZEeDZObmVCRGxhdWxjOElwck03ckJLaFpOVXVOL011WS9LbUtOZ2g2cEsw?=
 =?utf-8?B?YUZQUG5DOXcwQkpQYTRyWWxUOEhBOGhzUzgyZGViQjdzT0svanVJMTNKdFVG?=
 =?utf-8?B?YXlHSmdqQU8wTXMxaERrTGk3OHlJS3NMazVVYzRrOXM2cVA2Z1JpMHZseW1P?=
 =?utf-8?B?Z0lydzkrQy9WaXJaMlRPQlRNem5xNm91a09lWlRNbXd4a0J1eVczMHQ1TFdj?=
 =?utf-8?B?SEZVbFlkdlJZbHhjbEdWM0ZpYS93cGFnZFR3ZzZSOGpnZXNqNWpnRG1NaXlw?=
 =?utf-8?B?eGFXU3R4eFNRcGdDWDQ5b2FycWw3RExQQVBGbnJWUGNEUDl3RUdaVDlOdld0?=
 =?utf-8?B?WHRSN3J2NjR5NGxSYjBUWFB5cmc5Qkk4OEh5bzVOSFRwUG5kRzdsdVQ3Z1FT?=
 =?utf-8?B?NEtCR2hGSjZJYmpQQnhGSTBPV2ZYaXVSVnppOGp2Uzl4NkRLNW1HeWZGQ2lM?=
 =?utf-8?B?Tnl4Y1hmTVRWWTdnRkF2RldYTmFlRERMSnBPcXBja3BQQ1h1YzEyRUJnRzB6?=
 =?utf-8?B?R3VoeG1xem1UNFY5emhrTGVSRllZYzBtTC82M1MydXBtR25pZEhjVk1IbENz?=
 =?utf-8?B?Z2tld002QWNKVHBLMGJjWUw0NjNBNzRJTXl6YlByZElFcGx1bGV3OFhTRlhY?=
 =?utf-8?B?a055d2t4dFAxMExrNjNaL1B0YklzMStMUTV4OTlIcVF3MFo5dmhXQmdicGI2?=
 =?utf-8?Q?p4oW/1AD505G91Xd7tPyXLXaI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac5bc79-55b9-4953-57d6-08ddcae1741b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 18:39:42.3221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51r6X1yWWbr6a7cKdhXLLAEFvX9eQXHZ22SIoDtIRj7F8hv7SWPTOd+ClVH+Yp3yB78tVcYNCKdLsO4DIIES4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902



On 7/24/2025 10:44, Bjorn Helgaas wrote:
> On Wed, Jul 23, 2025 at 08:23:38PM +0000, Avadhut Naik wrote:
>> Add thermal info support for newer AMD Family 1Ah-based models.
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>>  drivers/hwmon/k10temp.c | 2 ++
>>  include/linux/pci_ids.h | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>> index babf2413d666..7765cd57d746 100644
>> --- a/drivers/hwmon/k10temp.c
>> +++ b/drivers/hwmon/k10temp.c
>> @@ -556,7 +556,9 @@ static const struct pci_device_id k10temp_id_table[] = {
>>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
>>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
>>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
>> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
>>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
>> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
>>  	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>>  	{}
>>  };
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index e2d71b6fdd84..ae87b6c72981 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -583,8 +583,10 @@
>>  #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
>>  #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
>>  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>> +#define PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3 0x12cb
>>  #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
>>  #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
>> +#define PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3 0x127b
> 
> Per the comment at top:
> 
>  *      Do not add new entries to this file unless the definitions
>  *      are shared between multiple drivers.
> 
> I would suggest adding these #defines to k10temp.c itself.
> 
Okay. Will move these definitions to k10temp.c

>>  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>>  #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
>>  #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
>>
>> base-commit: a2609b707b58561b9e52f92f3f571d0510201f2f
>> -- 
>> 2.43.0
>>

-- 
Thanks,
Avadhut Naik


