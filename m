Return-Path: <linux-kernel+bounces-792495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB96CB3C4CB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2681B22A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E668527EFEB;
	Fri, 29 Aug 2025 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="foPVQYTb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2108.outbound.protection.outlook.com [40.107.243.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66932221F0A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506485; cv=fail; b=sjszOt1nJyJnasTm8D46xaajl5fRexWR6P4JZv8qTlhbNK0H18YCTeMHk7u82r8KuB37Up1tK6y+SvedensbKGIoiFbtboIDB0FN8rhpM8QbqJEkjCj42lFjd9GgdgAg2xacbpjBpyZ+P+o3vDGvOlXHy38Zh/JuUHnRk6krx9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506485; c=relaxed/simple;
	bh=pYee6HbShL0jcFcI1Do0bQhk5+PD8uw+Yt9uxtfms3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NPpAqKu13D7jz8Yio7UE8B8cgA+DC9WfbFMoHc/D0k2yKxmB0h2MZcwSHGRR6XHZma3xDhvjwNF/3mff4EpG9PXioQYru7pWW6yy8wArVkpSGxLF9+vw+dde4u59B7wIpnoZh6ldVqT7EaF6wjyzjUp0aqm6q71jiIopH7YdC3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=foPVQYTb; arc=fail smtp.client-ip=40.107.243.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkuCczetYldykBUbmGXjCLAoxLyTdFwzjycSzAFwDP8IU++r1tzjTk7SVcaxIlhpVEAvLCcxpI47ACEmuer0ciKZwcxFVdlgEBVmqfeAA0AqU/3ljnOKF2pFC/u9WZqsthWfqu/cHaYB29FV/EKschdPCIKGQDFOITxlnn68YXr4201xb2viialrrH16dyV525Ov74AhF+SAWo2deVRJizWHmsaGxXBy1DOZjY7kS9fwT+Rrx/wHfpQ3BUZnTtHyy7JwNQniqMyuHyGyCcQZwnWeSxnAw0cQ/0W1KWDQAEjclKHwHsj2vMGfavaZKZoCEYQvqpIRK7UP9PRL9vfQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdDrmx8SjcdU27mxbbtR2h7FHJ6+kPdcuj86KqWHIII=;
 b=iXjYBD6H0EQ03Ml7Ar90r6o8HMeM9hWM2NcpdjFDKVOmuum2TRnPoG7O+6IKzeaI8DXgwwoV/2zCylNX5Z2/3UXLvLtiZBxhwEyNE8PPaHq7LUKjKCXyYkD4wXXKT1vtTrCyhC1VpypgWciSFIxylCJMBLNkSkYptC7HrPc032wWZo0ubLovuGtgO3XwJRYvESnzA7l1gDvsO/vM6kKNqPL4z+TNEtdS/lODkjTxmdwL2Kgtm4yoYGGx401t37u46Vs1cOpRskVLMdD6HZYaeIreRFTNOPnKffRK79AFTBVP9w5MgG8arMPp6a2OC1wqifVL/003U/b8H73h6Xt4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdDrmx8SjcdU27mxbbtR2h7FHJ6+kPdcuj86KqWHIII=;
 b=foPVQYTbPFeHyoqHyHqNUIluAqtfGm2PrIK6DGUvKr2uFKI3qG5nAWesj0B5ooPjyRarrMd1jZBam/ylH17wyD7VNzTbQSdiutVY9ZZUNAaqr51yoa4KRPG5htKqrR8bHQ+bswrRZAs37PDozGlCeurz/aM+4bhbxmC4K397XRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH7PR01MB7630.prod.exchangelabs.com (2603:10b6:510:1d2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Fri, 29 Aug 2025 22:27:54 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 22:27:53 +0000
Message-ID: <9d666caf-a799-4229-86b5-3a22a60fa79f@os.amperecomputing.com>
Date: Fri, 29 Aug 2025 15:27:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] arm64: mm: Optimize linear_map_split_to_ptes()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, Dev Jain <dev.jain@arm.com>,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <20250829115250.2395585-7-ryan.roberts@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250829115250.2395585-7-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH7PR01MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 7936316b-f366-493a-c8fe-08dde74b40ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WElRMVY1Q3NGKzh3dk9NWSsvbUU1NWt6MURGV0VtTTViWk50eGZOSitLbWRY?=
 =?utf-8?B?dWR4bEsySzFsNXBHbmhsbEZyUVFMdVlrb3ZwaXg1b2RINHdKNGRsQ01iZlh6?=
 =?utf-8?B?SEZFMHJmb1dyc3h2R0R1ZEhTa2gzZHNIZ2NLNzF2YW16eTJMWkp6WldMaWE0?=
 =?utf-8?B?T0Q2S1R2a0xhRW9NWTM0N2xsZDA1ODhmZHhnc2I4N1RaTkNZcko0dFN5eGdQ?=
 =?utf-8?B?UkIzbksvNThhUHhNNWtBSy84L3dvbjA0bDk0MkxMVW5qdFdmWEJaZE0yVDFi?=
 =?utf-8?B?SDNpR0J3WmhhZmtlbThyUXNZM3ljeWROQytKQjNXZm1HYWRPWlRxU3kzSTlZ?=
 =?utf-8?B?RFYxMHZqWFphU3VPNThoVGJlQ2ZoZHlOQUJKTzFLR3FXaml2MmlYSHRkbVlx?=
 =?utf-8?B?S3NUSGdyQ01yaUFFMkVNWWNBQlRjZG55ZzRuaWJVMmpvV2xTNUM3ajNuc2Nh?=
 =?utf-8?B?bjlqQlc3eHVEMjdRMDF2SC96aEV1RnpiTUpXQ1U2Nk0vQ1BGRmJObHZGVW8z?=
 =?utf-8?B?NkhXZDBiWnlYcGxFMGtSVDhHN1ZCNGkwWVg3WkhCeEQ5eGpFSmhIVVV0bU16?=
 =?utf-8?B?NGdncU1OZzhqL0JnN1JsdndMWUlxZGdPUmJDb1AzWFR0dERCdG1vVEpHTHRv?=
 =?utf-8?B?cVo2TEFjQlU5NE1WVG91cnlFTXFGYjlOVTY3MFhFM3VxUjRNWHVRWGRwSnVr?=
 =?utf-8?B?NHpNUTYyRlF5MmtWWTUvNFNKbUN1dUZHV1ZuUEFvQkxPTVUzTTlhaGxVNVhK?=
 =?utf-8?B?WTk0bXFzaXk3d0k5d1F4emdja3BuTWlYRWM4bVBvd0V3ZVFzbHk1TS93WUVL?=
 =?utf-8?B?UngxQVJvZ1pOK1JSKzhacCs2K1dveVJDblR0YUJ0azdick9sMiswczZwM0JM?=
 =?utf-8?B?ajFoVSt2VHRlS3UzTzNUNkZjQjNJWXl5cUYvcDVkaEJxdEw5eURCMjM2K0tm?=
 =?utf-8?B?cDJJYUNIVHJiNkVkeGFJSUpzb01QT29FbzlOUGVqZmZZWXRYNUJnV3RKUVl0?=
 =?utf-8?B?OEpJcUtSVVZ6WElzeHY0bUZGQVU0TjRmbWhNWko3TWYyQnpXN3A4c2UvOVMx?=
 =?utf-8?B?NTR3K2xmeCtYNUMyTE8yZTlzT2IzLzlJank4WDg3NnlIM3NIWCtpOTcvd2ll?=
 =?utf-8?B?UmU1cUZxVVhHOEQySFQ1MUx3UzkydUlic0E3VkgwMkRheGMyQnR1dTZjb2RC?=
 =?utf-8?B?RXdYSUI2RHlyOHJBMnV3NGJ5dWE4NWdiYnRFb2YrV3NQRzFKTG1sdmo4K21D?=
 =?utf-8?B?QkJZcDlOdU9wUXNBWmdMN20rR2Q2WVZkY2RLZjRtOWR2Z1BNaGFJekxzNk5P?=
 =?utf-8?B?LzZmUnJQQkJDaGdRa0NrUVo2TXBGRTc0bzdtZlR5S3VrTVpHaFpIQjFIYTVl?=
 =?utf-8?B?akVjeVpqUllERGRaRkRJRmdrbUlQemt6VnNWSStWUmIrRUlHRlhDVjV3eDIx?=
 =?utf-8?B?cCtBeGZtaXo5b3p0WlhvT1lOL24rVEI4cUEydVYyU3dlWG5mb2gzMkp6eFVp?=
 =?utf-8?B?eFUydnRPQVNGQmp4dGVkUlRpY3I5MlpQM0JJVHdrWmFYMS9VRGVCNHpvMFQ0?=
 =?utf-8?B?NVFCRFhDV0JJaTZBbCtKSGpocTZuQU9CMEJzOUsxMVF3ZHpIK3Zja1dSbnlY?=
 =?utf-8?B?Z1A3WlJkVnE1b0ZKU09uMXBDU3VGWWxkanI3YmxnZWVXSHUzdUZ2OG9kVmJz?=
 =?utf-8?B?QTdXY0hneWhtV0laVjJGTkxabjYvMS8xdThqRnhwTlFycDFwWEFiRzZDaXFh?=
 =?utf-8?B?ZDVQNFl4QUtZYTczUlM5Y0NQU1J4eTJqSE5TOVVNT2VYT0U2ZTZvTzBpREhs?=
 =?utf-8?B?YlFxSWpIbWErcm9MTzJaK0hkVnloc0puL1UzaFJndEVUTWoyeDlLdEtRejBU?=
 =?utf-8?B?OXFRQ0wrbE5wYnBRWUxGanQ5ZnVOZG01QnhSS1Y3cmVHSGVubzA3ODR5VEZ5?=
 =?utf-8?B?cEkva0I2TkdKT0orSGdtaG5GaTJqTlVSUUt0MTFjTXlrcXQwTHh2dVhRMkJ1?=
 =?utf-8?B?SVp1SE9HZjlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dExFa25IbHZETmkvakx0K0RrUUpteVBING0vTnFiNm5RZnNOd2hYZmFWbkZK?=
 =?utf-8?B?ZDRaKzh4ek1sclI2bXhUOG1tOXM3THBNRDIwclRQY1UzNnRqSldyU0dzSlN5?=
 =?utf-8?B?TkZTOUt4VVAvYVBUY1o1NTdXaDV3N0RXenhYWkJ3Skg3MDNmSXFSNm1XaFB3?=
 =?utf-8?B?ZUFpTnJ4TEdWWG55RnBuVzA3a3ltc0ZKL3Q4c3pYL0N5aElNYzV2UXdnR3NZ?=
 =?utf-8?B?TlFtN3RGS01qYmVDc0ZNeU5RNzVZei91UEdldkJXRUhyU0lFb0ZxQ1BjbFo0?=
 =?utf-8?B?bnMwRXNTcWptaW5hSHY2VHZpTlVtaWQ5S3BvQ0hYOW12b2hRdWdPc0dCd0h0?=
 =?utf-8?B?ZWljOUFDZEhzcW5BU0JhcHJiTFZPczlvWXZxVlpEWXJtd2JHbHBTOUNDalBF?=
 =?utf-8?B?OGZBNFA0a2IzMHNnTzUvRnVBbDZmYWEyem1IOTV3TWtKZnlVNVVPUGFPV1Fq?=
 =?utf-8?B?RnBPQlJtSllybWNsMEpBZnFxNktYQkgrRjhSNUVRbTRvZEdITjcxVEhSWlRV?=
 =?utf-8?B?UERlUTNWdk5sakYwUGpZMGNSUWp2d1pQeHlzNVlHOU1HdFFxVjE3a0k4cEhE?=
 =?utf-8?B?by9ZS1JJU2NKRHpXRkxjZGhQOHU4ZTFyVTllSmtTTVhDWU9WM3hTcklta2V1?=
 =?utf-8?B?dmVxUi82VXlxZmUrZWZOQWpjUkt2YlFreXhEeWJZSWtLR2MxYjcwM0V1Tkt5?=
 =?utf-8?B?dWxSQ1V5ZysrNTVZUlkyQ1M2TEJvMDl1TUtyUGZGRGJJT1d4MGNKRlBlSTM3?=
 =?utf-8?B?MkllaFdhcWhvSkxiWTFFRS96SWNVN1VWVUViRjl6V1hmNWpwUVBRM0UrOUVv?=
 =?utf-8?B?YXpRSVVQZ21DZGVmL0NneVBUOXBHZDhaYUIzUDQ2R01SZ2ZtMWh0QnRwTVp6?=
 =?utf-8?B?SmJ5ZmhBSE9nemZka0RtZ09mUjhmZnFpeXRxSDd5cjZTMTIzaWpHT1lVS0h1?=
 =?utf-8?B?SUtmbThjQjRpOWU2Z1FOWkE5bVlzWVJVMk5zNkVvSmZ5eTBTaHlSRnZsbk1K?=
 =?utf-8?B?NEUzcmxVWm53dzd1bUZEZTJWOTFsYmt5Ti94VXhvOHRYMDN1V01wSVhjZGNs?=
 =?utf-8?B?RDhRUXNTWXQwRFZZak5NSXR2N2VjQXRoUkF1T2YzMlJZZ2Y0Tnp3UitBZEIz?=
 =?utf-8?B?QzBxZS9FNlhwcDByM2FEL1JUWDh4SW0yUUhzak1Ud2o0dXNiNGlBU1lHRjRV?=
 =?utf-8?B?T3dwcGZGbU5YUW9SaXJDYjhrN2NKclFNVFZSdEdtVTJNOEMxUFhTTFkxczFE?=
 =?utf-8?B?NGZ5UGFxbFlwZ1dodEUvZ1ZVeWZMeVM3VksvZ3RzNGJaajRoRkFtN2ZkMzg1?=
 =?utf-8?B?UFVOVWx6MURQMVNQbmZlVEhlemtBTWNwNVFoTEZPd2tSR0tTUkxsRU45Z1Bp?=
 =?utf-8?B?ZG5WZithb2t0T2tIeDlUMzlldjRzM3BzL09OS2FiNjBDK2RWVXhKZy9qSmg3?=
 =?utf-8?B?WXY5R3ZWWk5tYmhkcFU3TTFWYTRoLy9GeXJ3WitDSXRtTEhNaXBSdE1KbUtV?=
 =?utf-8?B?QmpVUHhPWkxaZnV3S281d0p0RG9SNk9XempUNHNFb3pKM00xWmpXV3QzcThM?=
 =?utf-8?B?NzIwVzJmWG9JNzg2WWZoSkR2N29OKytIT1BJTE90MlNBbEUweTNWOEFoTUw0?=
 =?utf-8?B?cHdkS3h3UXdKYU9CZFl0NDc5cVJtdFcvdElRQzVyK2NVam5reDA1SDVXYzhm?=
 =?utf-8?B?cDEwWWVseFFaVERXVzlUNUh1ems4aDNxVnpQOTRUZkNXY0gyV3hyTXFJNmF2?=
 =?utf-8?B?WDhoT2pYeG55UXRKeFNHclhIeG9tVGRGYjF1eWZUY2lRUktrU1FERlF2ckxv?=
 =?utf-8?B?ZXVjSXJob2tmYUJ4WlhiMXVDTXZaSmlZNzJTVkMxdlJqdkd3NmE4ZGpQK25k?=
 =?utf-8?B?RUFDblBXUXB0M1h4eldqdFFLaDdYcE5HdktEaFkyanFxa2xxdUsrd2VNclB2?=
 =?utf-8?B?ZGkzV2FZYTZyNlN4TVF1V0duYmJmcnAyL1RJY0MwLzhqZFpvSjY0UStvbTZF?=
 =?utf-8?B?SnpKVlFxc3ovRXd4YVplT0VLUkNIenc3OE44bW50VHZIbW9FT3pzYnc3Tzc5?=
 =?utf-8?B?N2lpcVFhYW1HRW1wQU5tNkpqNVBjdkFRTXNWSlpTbDdIRkI4MWJyOFp3Wjhw?=
 =?utf-8?B?MGd3aFRPRnJUQ3VBelBoVk83anIwM0FTczZQaUF4YjVLaFpuMHBXaHJQdjM3?=
 =?utf-8?Q?ALFVgnBegsmksx2UlgKqtxw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7936316b-f366-493a-c8fe-08dde74b40ff
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 22:27:53.2032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ak8DRXxKUtQz6+0aJiyTRWSLwYfKP4ZDh/5YV7uygyec6bxHIAU+TQZCCF5fyt3Cvclktxfl0eutosWBhNu3L9oAIHZxtKyGXykXsKmuZns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7630



On 8/29/25 4:52 AM, Ryan Roberts wrote:
> When splitting kernel leaf mappings, either via
> split_kernel_leaf_mapping_locked() or linear_map_split_to_ptes(),
> previously a leaf mapping was always split to the next size down. e.g.
> pud -> contpmd -> pmd -> contpte -> pte. But for
> linear_map_split_to_ptes() we can avoid the contpmd and contpte states
> because we know we want to split all the way down to ptes.
>
> This avoids visiting all the ptes in a table if it was created by
> splitting a pmd, which is noticible on systems with a lot of memory.

Similar to patch #4, this patch should be squashed into patch #5 IMHO.

Thanks,
Yang

>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   arch/arm64/mm/mmu.c | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 6bd0b065bd97..8e45cd08bf3a 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -550,7 +550,7 @@ static void split_contpte(pte_t *ptep)
>   		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>   }
>   
> -static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
> +static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>   {
>   	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
>   	unsigned long pfn = pmd_pfn(pmd);
> @@ -568,7 +568,9 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
>   		tableprot |= PMD_TABLE_PXN;
>   
>   	prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) | PTE_TYPE_PAGE);
> -	prot = __pgprot(pgprot_val(prot) | PTE_CONT);
> +	prot = __pgprot(pgprot_val(prot) & ~PTE_CONT);
> +	if (to_cont)
> +		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>   
>   	for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
>   		__set_pte(ptep, pfn_pte(pfn, prot));
> @@ -592,7 +594,7 @@ static void split_contpmd(pmd_t *pmdp)
>   		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
>   }
>   
> -static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp)
> +static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>   {
>   	pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
>   	unsigned int step = PMD_SIZE >> PAGE_SHIFT;
> @@ -611,7 +613,9 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp)
>   		tableprot |= PUD_TABLE_PXN;
>   
>   	prot = __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT);
> -	prot = __pgprot(pgprot_val(prot) | PTE_CONT);
> +	prot = __pgprot(pgprot_val(prot) & ~PTE_CONT);
> +	if (to_cont)
> +		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>   
>   	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++, pfn += step)
>   		set_pmd(pmdp, pfn_pmd(pfn, prot));
> @@ -669,7 +673,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>   	if (!pud_present(pud))
>   		goto out;
>   	if (pud_leaf(pud)) {
> -		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL);
> +		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL, true);
>   		if (ret)
>   			goto out;
>   	}
> @@ -694,7 +698,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>   		 */
>   		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
>   			goto out;
> -		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL);
> +		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
>   		if (ret)
>   			goto out;
>   	}
> @@ -771,7 +775,7 @@ static int __init split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
>   	int ret = 0;
>   
>   	if (pud_leaf(pud))
> -		ret = split_pud(pudp, pud, GFP_ATOMIC);
> +		ret = split_pud(pudp, pud, GFP_ATOMIC, false);
>   
>   	return ret;
>   }
> @@ -786,7 +790,13 @@ static int __init split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
>   	if (pmd_leaf(pmd)) {
>   		if (pmd_cont(pmd))
>   			split_contpmd(pmdp);
> -		ret = split_pmd(pmdp, pmd, GFP_ATOMIC);
> +		ret = split_pmd(pmdp, pmd, GFP_ATOMIC, false);
> +
> +		/*
> +		 * We have split the pmd directly to ptes so there is no need to
> +		 * visit each pte to check if they are contpte.
> +		 */
> +		walk->action = ACTION_CONTINUE;
>   	}
>   
>   	return ret;


