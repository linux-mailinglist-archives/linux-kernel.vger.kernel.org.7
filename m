Return-Path: <linux-kernel+bounces-812949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FE9B53EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12BCD7AF5E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320B02EFD91;
	Thu, 11 Sep 2025 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="NbTDIA/l"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021101.outbound.protection.outlook.com [40.107.208.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF8A22156A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757629813; cv=fail; b=DfZ8xKYQbEYGCwjJ7o2Wccy7axlKv1dkZHSjW/eunVPesSUIhlOUziV5jlEadsrIuXig6pZLmPSHDn6MtMWSF+dfZdNfmTwP/Xg2gl19yIT0t4bdIe2XHbU0EwwuQf92NHV6ILhDtBWN4R0l01y/HjGt6aU3wl5tF9Eq6vsFGXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757629813; c=relaxed/simple;
	bh=m87u+/k56/5pLKUZJBwQMtedB+QIpVeVADEIkdSU0vg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qTAOS3b3zeDtCjWdg/hptnaoCXBEDuEWTKu4kcAsGpArBYFEmNdYNLv3z2f2MvFQj/z1c7g/4DL9zwxELDXRMXm08rRpdl1sXXefy9K1lR6a2MbKJgV0qJbxlqmfIZyai671i04r4gBjdMvROpNo1cVdd33tGXRKRYMV4+hXQno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=NbTDIA/l; arc=fail smtp.client-ip=40.107.208.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOsBjv1EGfxxmvHt1/b9PEVVglkWRcTIjyOSTTefGbAjQTUtG6shw5GQbuKCMBGKxfV5WQB3OzSCXcJaTZgb1fMr4qpLrBjzDKsv6zss3wTMcNbEixaLshG/ssrQr5csIaHcojB2q7l+PbvcJkkbQZpjrc0Kx/5lAuyX8snp7nylDW4wQWWCMtkSZOwekiJkf2kKxYnddWN6y7caIY/VgDNyqIsuWD1lFWyAs4BiWJzP15xwAgSSXKeMIx0BW0JxKBEh7oxRwak1FL4UQsdaTaeEj1NlSqChUNazbpC6M8g2cUc74TB4oo/6xoMCRYl2gcDzMRgfEx7K3u4C7Uy87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulDZ0RZtJDcacf/mQ9NZDm4IgXPJhwHVx67WP6tKWGk=;
 b=OYrPtGf3HDOFu+NmBxfsQIZlDq7Q5/K7E6fPykhWy1VtnnzWFNLhtI9JZEkWCxz2szXyfiOcDFYJ+a7KkslbyxeQ5x2Re/GSQIj11qZ4yAVusZvWQhAGOvDEEHGTumR1tLWGHUDuveRpUmr5TvGMosL15Mbv7ft3aPk9bRWV1CTuh6qWjL721hmJI0M8Seyp3DENuFiDJoWP2Ba/LAQQd6/sHFlT9AfAjW6vmOz+vP/GBz8GZiyIHg2x8jZcNV8WfWzDVKcCF0XD53CGxszqtGVrTcVkSY1QsXlGkECNddtMdps9Nbyj0/7uiC2vM8oOJtLzeGtoSCu3qDyU4cEyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulDZ0RZtJDcacf/mQ9NZDm4IgXPJhwHVx67WP6tKWGk=;
 b=NbTDIA/lUAZx8M7MFHrkyOK2peCFVCiKXtBeWQFX+Yxb9qoITGoyoSo7wC+g8m3Kop4xJQrKjKon/+2m6IFTMoE93mtBmczKLZnM8Lo8y2Mw8sHJwaSV97a8ieW8RHqgsCbHZda+Z4Z+zXiPty/f/c5l2eRJF55AlIt1TvWbqfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 22:30:02 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 22:30:02 +0000
Message-ID: <018fad41-c21d-41c4-9cab-b3aa9404fe2c@os.amperecomputing.com>
Date: Thu, 11 Sep 2025 15:29:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/2] arm64: tlbflush: Don't broadcast if mm was
 only active on local cpu
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250829153510.2401161-1-ryan.roberts@arm.com>
 <20250829153510.2401161-3-ryan.roberts@arm.com>
 <dcc3b52d-0b86-47fc-8297-a6abc8af4c38@os.amperecomputing.com>
 <b4c7ad35-e855-498a-9128-6f2bdf6baaec@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <b4c7ad35-e855-498a-9128-6f2bdf6baaec@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:930:d3::27) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH7PR01MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: d9517aec-8820-414a-4c2b-08ddf182bffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDRKQk9tdks2bEpuNEtRSnlaU3ZKNDNaaEtCemhjL2thb2tvZkFCak9lK0t5?=
 =?utf-8?B?RWEyRy9FZVQwRFVvWUZoOUQ5WVVHSXRWZUk1SEE5bitxOXhPMXR5dDRWUnMr?=
 =?utf-8?B?aGNuTFBiSlozbXVTMzFHVFllcEUwTEJ0Q3NjWlZXU09GVnRVT3VaQWhyYzZv?=
 =?utf-8?B?TzUyNTZSU0tsRDJVZndSa3V6SzVESEdCdURFOUlERTZqRGx4WDAwM2lXRDdx?=
 =?utf-8?B?b0o3cWliTzdEUWFNM3ZIaVlvUHJUakt3U2dMeVl4SVBqbG54ODRoTGlLNTFG?=
 =?utf-8?B?dnc5bHE2T29sd0NjNWpFTi9aZWhUVTFlN0JIaW5NOGF2R3k0WEFJd0QrMXd2?=
 =?utf-8?B?cEdvclJCYjQzRWY3d05IUFRpTGRUd2tNQnpoUndOZzdxOEdOV2Y5eG1nK0V5?=
 =?utf-8?B?bjdXVFpFTzJ2Z01PSUJ3RWNNbmNUR1NFRW5sbWJqTVB6a1IxaUgvcHFmOHJt?=
 =?utf-8?B?aU1Ock1MTVVweWtnbU5CR1VqM2FKRHVKQ1lSNDVocU9LYXpFWFNoRlRaaXZD?=
 =?utf-8?B?L0k3cjlxa2FNODJQd1dTbGpJcDR0T3ZrYmRmRUZ6d1hRV3crcXltYTM4b3lO?=
 =?utf-8?B?YUZkU0tPMEJzZjNzRnJWR1VDb1BVcVlySkNOS3A5YzRUbVhyWVFINWVZS3lI?=
 =?utf-8?B?RFZJdGNSaEhHV2QxbFVqL0duMVU3Umg4cjZCY2h2THVudVZCeGJQVEJnTm1E?=
 =?utf-8?B?R0JPTUJCYUMxSFBNTDc5cGZqU2JSakVxVS9KTXV3eUtaMHdML0o4QnZqT2cw?=
 =?utf-8?B?VE5XRmZ4ODVXMGFLS2tjREhwZXJQSWhLOG4ydnVlMnF5OU55QlZpYlFnRnVX?=
 =?utf-8?B?ZzdIZC9TdlAwNGx6Lzc0NFJBaVJlWWpZRk1PRWJPdGlNWGdQV2RhSkZlYzNj?=
 =?utf-8?B?NUZ5dUFrVnVvTUFpdGZZY01sa2RIbFBKdjdjK3Y1R2JmTURncmdMVDZDRURo?=
 =?utf-8?B?RDFQRDlBQkxueTZpbzg4UmRjRWVBa3lqazJqdk41Tjl3ZTJaQVBXV05KOWdp?=
 =?utf-8?B?WTdlY2lUWUdlT0MzY1RlSE9HNmM4bGpnT2RBcmtjckhOaDE1bHN0a1VmSmJ1?=
 =?utf-8?B?NkdoL1c3OG82b1JRK3EvVWJIb1VwSTNuUG1Qb29Zb1A0eWZyTVB2S2lKY0c3?=
 =?utf-8?B?azRoRVlLNDBJT0l6TUdSL3dpbFhUSE5ERU5oc3VqVW05Q2FzbFQxenpHQVda?=
 =?utf-8?B?MUgxYVZBZm9ESEpRdHpjWVpjOVdCT1puOGx1TklDaTNDM2h5OVpkSGJSV0kw?=
 =?utf-8?B?cEE5R1JaZjRkT3JONkpmUXBVd0xKZnY4ZmpMczVFazZUdStRL0w4cG1Lejlu?=
 =?utf-8?B?a3pwdGw2dFpIbGZFN1lBQ3VENFg3Wjl1U2lyNU85VzI3MmZxcHVuQWVGeTdF?=
 =?utf-8?B?LzN3OUxVTExBYTl2VVEzdXZhR0NzbWs4N1Jrd25DNzFZWVhUcm9WQVh1djNS?=
 =?utf-8?B?Zlh5OUptTnNEYy9xVG1nZ1F1Vk1VZ3MwcC9LMGd6cTJFZ2hnTmJObm43NTBK?=
 =?utf-8?B?UCtuSTM2R21WejZVaUFIMGQ4S3pDYVFKSHc1RXZyRXE1cFg1cGlJSmU1T2dQ?=
 =?utf-8?B?SVQ1eFBmdWEzUWJoSWdWaHp4OG9sMVJyanU5QzhLSVVXbG1KSVRDclJmanpi?=
 =?utf-8?B?U1JvNGg2TExGc3hNamt2THVaR0s1SWhGdXVjaWNzY2ZiOXd6RGlLbHRmYklE?=
 =?utf-8?B?UlhpbFB4b044bnRtM29wdlRncGkxb08rc1pWbllzUkFoUDE3MWRpcS9BZlNs?=
 =?utf-8?B?SzRxc1ZSemlSQVdqdmtnOGVicVpaT0p0ZFBrdklrUGxacWZCZWRPRVVZazQy?=
 =?utf-8?B?ZWRCQTVMSjB0d3FTeUZSek03b1kvTmYwajJyMDFrbmVKMTIwU1lxMWk0cjho?=
 =?utf-8?B?TWNlVzk3eFBYK09XWWJwOFdBWEF5RXZJL0cwNmFjckFnZ29vOWtDQ2x1Y0tl?=
 =?utf-8?Q?1/T8oR/MC+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T083dWlJYk1XWS9rSHlWeFViZUFsazJnMlNIbE1vTU5lWjhWQmVWektWOXpD?=
 =?utf-8?B?cnlIWWtTMWFkekZ1RlVrSzZ3QXRtcXhYb3dDN0d2TmQ2NnFrZUw2RzFDTWZO?=
 =?utf-8?B?d05tYkhBY2lvNFJoQ3RoVmtRcjNOS1RWOFFOQXlFZCtGZ3JiYkd0aDM4ZXZ6?=
 =?utf-8?B?R3IzQXh3VUJDNTlreFVHdUw3UUJja2d0YXZzaG9wUXI3S3JXUW1hNHRhU3Zq?=
 =?utf-8?B?YW96dG55alEza0tYTVcyZk5ncSs5VU1LN002aUFRTStBcmlwNFlrRFhFN0sv?=
 =?utf-8?B?eExQb1NjR0oyMnp4YSsvZTFsdkZYdUNHbTJ0WUQxU1FQYzl4Q0pFTFVMVTFu?=
 =?utf-8?B?Y0tuUVIyOVJhRDBpOUhnRURvNHpRMDdBeHgrZU82d2o1WE1jbUZ5YVplVkEy?=
 =?utf-8?B?ZDhEVWc5Mmg2bkJHbEZHUFd4SkdrV29iYXN1WW1uay9vc2x6U0pybEU4MXU4?=
 =?utf-8?B?ckp6bURMWHFmV2plR0VaYXN0b2FheThNd2NDSmZLaDBLZEpiZlFSYTc3S1Ez?=
 =?utf-8?B?TmltdVJ4WXZGcERJSjRoR0kxZU9wYzA5elpzZlhwSDVSL1R2QXR5ckN3SElC?=
 =?utf-8?B?Snp5bzBGTkdkNFZXc2VnMDh5MUVSbStnMDlzWTFvek0vckUxVFdZMVp0d25z?=
 =?utf-8?B?RXgvbXFFMFl3MklJMXBaMmVNMWdkOVFCQWdtS1pudmFxZ0g2eHpteGVRZmJQ?=
 =?utf-8?B?dkhTcy94NGg2b1ViMVRyMXRkMktCNWRyUUluTFhkbzRwR1paNTlnT2FVZzQ2?=
 =?utf-8?B?TTBnWkxoVlg1UVpIcmc3WDRISjlKWllVYWNCRUN4S0VkZXBrd1ZpNGlkREln?=
 =?utf-8?B?b3ViQ0laYWpkb0dDWEdSdHExYTRhVTdidmIzeDkvcU9xZkhmVm5WcURicmFs?=
 =?utf-8?B?QUIwSnFzMlJmK1ducW1yU0JKMkMwWkYvWjByMU13eWt3cXZEbHh1bTFzM3Ja?=
 =?utf-8?B?N1VXT095WVp4UjFiR05tYWFVeGMwR2wxVkVMMEtQNW9UakwzcERNNkxFbUxD?=
 =?utf-8?B?UXpvSTdsTjJHVThwQ0N5NUtEOElUUG9HNVlsK3dQaVRtYlE3R2xWTEw2Qm1D?=
 =?utf-8?B?YkpBN095STlMZlpjeVErL3ZxeFZzVlQyUzQrSzA1anZQcjZ5bytVU2IyM2hV?=
 =?utf-8?B?ak9aSVZHNW94NityMyt6VlYzYXZSaWlmNXVjbW9TVGRwbzVONGVlOEhCR0NQ?=
 =?utf-8?B?MjI3eENFWjEwQkFONEw2NFBKNDZlWkQrK2VCK1FoWS9pMTVTdzRVUFJzeTFV?=
 =?utf-8?B?cXl6YllzWWxwQTJlRHJibDE1OHFCQ2Y5UGtTK3FDbHpjSWNSV1ZmcXZvWTRT?=
 =?utf-8?B?NmJLbGFlN0pHQVdGeVBJdGR6cTdLa2p4eGtMTlgwNEduYnBTUVdMbkl6eFBE?=
 =?utf-8?B?UzE2dTlJUGVrYVB2V20zL1dEQm4vT2QwUWZzSHJqd1ZzM04xTWQ1cHVkbU5R?=
 =?utf-8?B?L0NjYjVKZ0tLQk5YbkNFTno0UjlIcExVOHpPZStDeHZERFpYWkdKUyswRGxm?=
 =?utf-8?B?UDAvZGNDYk1KR2hweU9wWitiNkVqYk5jUWwwVnllOGcxalhJTW1La2NycDhU?=
 =?utf-8?B?enR1MVdDWGgzbHpiQ0lXQ0VUbGNRZlRZTVFSMFRwdVlEZUJwNWkrNnVMNEgx?=
 =?utf-8?B?dzlGS1ljT1Rsa1RRN2ZCYXIwRG1tWDBiWXA0b2tSS0krWVBYQWJMdkRLQ1k4?=
 =?utf-8?B?anlMdEVVcHBQREVPZWRCYmFXeS9sV1ozMFFLaUxVeHJCYytaTThkM3VGdXJx?=
 =?utf-8?B?OG5sZFJtbWNmdy83bzI2THVzdnVQUy9tNXpjR01NVjBJcFZ5elh1WDZFbXBh?=
 =?utf-8?B?cVdoR2txME5XbjMzY2JUeWZINFlMSUlkcGtuczhzdU8yR0FvM2o5Qy9MSmp0?=
 =?utf-8?B?c0VheWgyQitPSGpsbkowTXNocnpzdFdBQWhzUGxZYnNSQnBIYzRUVS9GaTk5?=
 =?utf-8?B?R3dGZjdjL2FLKzhLeGJ2MDhVRVhLTU9mbFlSWFIwQStUdU1BbExiK2V1RUJM?=
 =?utf-8?B?Y3dQY0tzR1E0RDl0ei9JMVIxMU9EY05XQzBWQjU3SHlHckppb2VZUUoxSWpl?=
 =?utf-8?B?Zm9CdEEwdHJNcnRDMkUzR0lYdUR5aTl6dzJsYXorSkJYNGpNa3cya3ovdStK?=
 =?utf-8?B?OThWWTIzV3VyazVVdEdnd054RUNEc1JOa0JHbkU5a3phMGRZR2dEcXU5Vkti?=
 =?utf-8?Q?Sn00jn3mxg9Z7yw26l9fZmw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9517aec-8820-414a-4c2b-08ddf182bffc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 22:30:02.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6ErrgwBihtuqgzH+jes7OTHKFg1w/UPlS8f8I5KHzwvY8ERtE0F2eVGJXP6LodFOL98wa2IUukVFx0WpFUmdAY5WvCjagqnm8CgaKNCpYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8146



On 9/11/25 7:19 AM, Ryan Roberts wrote:
> On 11/09/2025 00:58, Yang Shi wrote:
>> Hi Ryan,
>>
>>
>> On 8/29/25 8:35 AM, Ryan Roberts wrote:
>>> There are 3 variants of tlb flush that invalidate user mappings:
>>> flush_tlb_mm(), flush_tlb_page() and __flush_tlb_range(). All of these
>>> would previously unconditionally broadcast their tlbis to all cpus in
>>> the inner shareable domain.
>>>
>>> But this is a waste of effort if we can prove that the mm for which we
>>> are flushing the mappings has only ever been active on the local cpu. In
>>> that case, it is safe to avoid the broadcast and simply invalidate the
>>> current cpu.
>>>
>>> So let's track in mm_context_t::active_cpu either the mm has never been
>>> active on any cpu, has been active on more than 1 cpu, or has been
>>> active on precisely 1 cpu - and in that case, which one. We update this
>>> when switching context, being careful to ensure that it gets updated
>>> *before* installing the mm's pgtables. On the reader side, we ensure we
>>> read *after* the previous write(s) to the pgtable(s) that necessitated
>>> the tlb flush have completed. This guarrantees that if a cpu that is
>>> doing a tlb flush sees it's own id in active_cpu, then the old pgtable
>>> entry cannot have been seen by any other cpu and we can flush only the
>>> local cpu.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>    arch/arm64/include/asm/mmu.h         | 12 ++++
>>>    arch/arm64/include/asm/mmu_context.h |  2 +
>>>    arch/arm64/include/asm/tlbflush.h    | 90 +++++++++++++++++++++++++---
>>>    arch/arm64/mm/context.c              | 30 +++++++++-
>>>    4 files changed, 123 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>>> index 6e8aa8e72601..ca32fb860309 100644
>>> --- a/arch/arm64/include/asm/mmu.h
>>> +++ b/arch/arm64/include/asm/mmu.h
>>> @@ -17,6 +17,17 @@
>>>    #include <linux/refcount.h>
>>>    #include <asm/cpufeature.h>
>>>    +/*
>>> + * Sentinal values for mm_context_t::active_cpu. ACTIVE_CPU_NONE indicates the
>>> + * mm has never been active on any CPU. ACTIVE_CPU_MULTIPLE indicates the mm
>>> + * has been active on multiple CPUs. Any other value is the ID of the single
>>> + * CPU that the mm has been active on.
>>> + */
>>> +enum active_cpu {
>>> +    ACTIVE_CPU_NONE = UINT_MAX,
>>> +    ACTIVE_CPU_MULTIPLE = UINT_MAX - 1,
>>> +};
>>> +
>>>    typedef struct {
>>>        atomic64_t    id;
>>>    #ifdef CONFIG_COMPAT
>>> @@ -26,6 +37,7 @@ typedef struct {
>>>        void        *vdso;
>>>        unsigned long    flags;
>>>        u8        pkey_allocation_map;
>>> +    unsigned int    active_cpu;
>> Any reason why you don't use bit mask to mark the active CPUs? And mm_struct
>> also has cpu_bitmap to record the active CPUs which the process has run on. Why
>> not just use it?
> An earlier draft of this patch used that approach. But that version returned
> some performance regressions. I then re-wrote the whole thing as tight as I
> could, including getting rid of the use of the cpu mask; I figured that there
> are (usually?) 512 bits in a mask, so that's 8 loads to figure out if the thread
> has run on more than 1 CPU. Whereas my approach is 1 load.

Yes, mm_cpumask() loads 64 bits each time. But they should fit into the 
same cache line (64 bytes). Currently mm_struct doesn't force to place 
cpu_bitmap into a single cache line, it may be in 2 cache lines. But 
this can be optimized if it is a problem.

>
> Anyway, I don't have hard evidence that it is actually the cpu mask that was
> causing the slow downs. I made other changes too. I'll revisit this and do more
> testing. I agree it would be good to use the cpu mask if we can. (or don't
> bother allocating it if we can't!).
>
>> x86 uses it to determine which CPUs kernel should send TLB
>> flush IPI to. I understand this series just check whether local cpu is the
>> active cpu or not, but bit mask should not make things more complicated. And it
>> also can provide more flexibility. We can extend this, for example, use IPI to
>> send local TLB flush if the number of active cpus is quite low. AFAIK, x86 added
>> TLBI broadcast support too, and fallback to IPI if the number of active cpus is
>> <= 3. IIRC, Christohper's series did the similar thing. He should be interested
>> in this series too, cc'ed him.
> That definitely feels like a separate step, if we even want to go in that direction.

Yeah, potential future optimization candidate. It may be not worth for 
small system, but large system with hundreds of cores is a different story.

Thanks,
Yang

>
>> Thanks,
>> Yang
>>
>>>    } mm_context_t;
>>>      /*
>>> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/
>>> mmu_context.h
>>> index 0dbe3b29049b..db2505a8eba8 100644
>>> --- a/arch/arm64/include/asm/mmu_context.h
>>> +++ b/arch/arm64/include/asm/mmu_context.h
>>> @@ -180,6 +180,8 @@ init_new_context(struct task_struct *tsk, struct mm_struct
>>> *mm)
>>>        /* pkey 0 is the default, so always reserve it. */
>>>        mm->context.pkey_allocation_map = BIT(0);
>>>    +    WRITE_ONCE(mm->context.active_cpu, ACTIVE_CPU_NONE);
>>> +
>>>        return 0;
>>>    }
>>>    diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/
>>> tlbflush.h
>>> index f66b8c4696d0..651440e0aff9 100644
>>> --- a/arch/arm64/include/asm/tlbflush.h
>>> +++ b/arch/arm64/include/asm/tlbflush.h
>>> @@ -182,6 +182,52 @@ static inline unsigned long get_trans_granule(void)
>>>            (__pages >> (5 * (scale) + 1)) - 1;            \
>>>        })
>>>    +/*
>>> + * Determines whether the user tlbi invalidation can be performed only on the
>>> + * local CPU or whether it needs to be broadcast. (Returns true for local).
>>> + * Additionally issues appropriate barrier to ensure prior pgtable updates are
>>> + * visible to the table walker. Must be paired with flush_tlb_user_post().
>>> + */
>>> +static inline bool flush_tlb_user_pre(struct mm_struct *mm)
>>> +{
>>> +    unsigned int self, active;
>>> +    bool local;
>>> +
>>> +    migrate_disable();
>>> +
>>> +    self = smp_processor_id();
>>> +
>>> +    /*
>>> +     * The load of mm->context.active_cpu must not be reordered before the
>>> +     * store to the pgtable that necessitated this flush. This ensures that
>>> +     * if the value read is our cpu id, then no other cpu can have seen the
>>> +     * old pgtable value and therefore does not need this old value to be
>>> +     * flushed from its tlb. But we don't want to upgrade the dsb(ishst),
>>> +     * needed to make the pgtable updates visible to the walker, to a
>>> +     * dsb(ish) by default. So speculatively load without a barrier and if
>>> +     * it indicates our cpu id, then upgrade the barrier and re-load.
>>> +     */
>>> +    active = READ_ONCE(mm->context.active_cpu);
>>> +    if (active == self) {
>>> +        dsb(ish);
>>> +        active = READ_ONCE(mm->context.active_cpu);
>>> +    } else {
>>> +        dsb(ishst);
>>> +    }
>>> +
>>> +    local = active == self;
>>> +    if (!local)
>>> +        migrate_enable();
>>> +
>>> +    return local;
>>> +}
>>> +
>>> +static inline void flush_tlb_user_post(bool local)
>>> +{
>>> +    if (local)
>>> +        migrate_enable();
>>> +}
>>> +
>>>    /*
>>>     *    TLB Invalidation
>>>     *    ================
>>> @@ -274,11 +320,18 @@ static inline void flush_tlb_all(void)
>>>    static inline void flush_tlb_mm(struct mm_struct *mm)
>>>    {
>>>        unsigned long asid;
>>> +    bool local;
>>>    -    dsb(ishst);
>>> +    local = flush_tlb_user_pre(mm);
>>>        asid = __TLBI_VADDR(0, ASID(mm));
>>> -    __tlbi(aside1is, asid);
>>> -    __tlbi_user(aside1is, asid);
>>> +    if (local) {
>>> +        __tlbi(aside1, asid);
>>> +        __tlbi_user(aside1, asid);
>>> +    } else {
>>> +        __tlbi(aside1is, asid);
>>> +        __tlbi_user(aside1is, asid);
>>> +    }
>>> +    flush_tlb_user_post(local);
>>>        dsb(ish);
>>>        mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
>>>    }
>>> @@ -287,11 +340,18 @@ static inline void __flush_tlb_page_nosync(struct
>>> mm_struct *mm,
>>>                           unsigned long uaddr)
>>>    {
>>>        unsigned long addr;
>>> +    bool local;
>>>    -    dsb(ishst);
>>> +    local = flush_tlb_user_pre(mm);
>>>        addr = __TLBI_VADDR(uaddr, ASID(mm));
>>> -    __tlbi(vale1is, addr);
>>> -    __tlbi_user(vale1is, addr);
>>> +    if (local) {
>>> +        __tlbi(vale1, addr);
>>> +        __tlbi_user(vale1, addr);
>>> +    } else {
>>> +        __tlbi(vale1is, addr);
>>> +        __tlbi_user(vale1is, addr);
>>> +    }
>>> +    flush_tlb_user_post(local);
>>>        mmu_notifier_arch_invalidate_secondary_tlbs(mm, uaddr & PAGE_MASK,
>>>                            (uaddr & PAGE_MASK) + PAGE_SIZE);
>>>    }
>>> @@ -437,6 +497,8 @@ static inline bool __flush_tlb_range_limit_excess(unsigned
>>> long start,
>>>    enum tlbi_op {
>>>        TLBI_VALE1IS,
>>>        TLBI_VAE1IS,
>>> +    TLBI_VALE1,
>>> +    TLBI_VAE1,
>>>    };
>>>      #define flush_tlb_range_op(op, ...)                    \
>>> @@ -448,6 +510,12 @@ do {                                    \
>>>        case TLBI_VAE1IS:                        \
>>>            __flush_tlb_range_op(vae1is, __VA_ARGS__);        \
>>>            break;                            \
>>> +    case TLBI_VALE1:                        \
>>> +        __flush_tlb_range_op(vale1, __VA_ARGS__);        \
>>> +        break;                            \
>>> +    case TLBI_VAE1:                            \
>>> +        __flush_tlb_range_op(vae1,  __VA_ARGS__);        \
>>> +        break;                            \
>>>        default:                            \
>>>            BUILD_BUG_ON_MSG(1, "Unknown TLBI op");            \
>>>        }                                \
>>> @@ -460,6 +528,7 @@ static inline void __flush_tlb_range_nosync(struct
>>> mm_struct *mm,
>>>    {
>>>        unsigned long asid, pages;
>>>        enum tlbi_op tlbi_op;
>>> +    bool local;
>>>          start = round_down(start, stride);
>>>        end = round_up(end, stride);
>>> @@ -470,13 +539,18 @@ static inline void __flush_tlb_range_nosync(struct
>>> mm_struct *mm,
>>>            return;
>>>        }
>>>    -    dsb(ishst);
>>> +    local = flush_tlb_user_pre(mm);
>>>        asid = ASID(mm);
>>>    -    tlbi_op = last_level ? TLBI_VALE1IS : TLBI_VAE1IS;
>>> +    if (local)
>>> +        tlbi_op = last_level ? TLBI_VALE1 : TLBI_VAE1;
>>> +    else
>>> +        tlbi_op = last_level ? TLBI_VALE1IS : TLBI_VAE1IS;
>>> +
>>>        flush_tlb_range_op(tlbi_op, start, pages, stride, asid, tlb_level,
>>>                   true, lpa2_is_enabled());
>>>    +    flush_tlb_user_post(local);
>>>        mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
>>>    }
>>>    diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
>>> index b2ac06246327..adf4fc26ddb6 100644
>>> --- a/arch/arm64/mm/context.c
>>> +++ b/arch/arm64/mm/context.c
>>> @@ -214,9 +214,10 @@ static u64 new_context(struct mm_struct *mm)
>>>      void check_and_switch_context(struct mm_struct *mm)
>>>    {
>>> -    unsigned long flags;
>>> -    unsigned int cpu;
>>> +    unsigned int cpu = smp_processor_id();
>>>        u64 asid, old_active_asid;
>>> +    unsigned int active;
>>> +    unsigned long flags;
>>>          if (system_supports_cnp())
>>>            cpu_set_reserved_ttbr0();
>>> @@ -251,7 +252,6 @@ void check_and_switch_context(struct mm_struct *mm)
>>>            atomic64_set(&mm->context.id, asid);
>>>        }
>>>    -    cpu = smp_processor_id();
>>>        if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
>>>            local_flush_tlb_all();
>>>    @@ -262,6 +262,30 @@ void check_and_switch_context(struct mm_struct *mm)
>>>          arm64_apply_bp_hardening();
>>>    +    /*
>>> +     * Update mm->context.active_cpu in such a manner that we avoid cmpxchg
>>> +     * and dsb unless we definitely need it. If initially ACTIVE_CPU_NONE
>>> +     * then we are the first cpu to run so set it to our id. If initially
>>> +     * any id other than ours, we are the second cpu to run so set it to
>>> +     * ACTIVE_CPU_MULTIPLE. If we update the value then we must issue
>>> +     * dsb(ishst) to ensure stores to mm->context.active_cpu are ordered
>>> +     * against the TTBR0 write in cpu_switch_mm()/uaccess_enable(); the
>>> +     * store must be visible to another cpu before this cpu could have
>>> +     * populated any TLB entries based on the pgtables that will be
>>> +     * installed.
>>> +     */
>>> +    active = READ_ONCE(mm->context.active_cpu);
>>> +    if (active != cpu && active != ACTIVE_CPU_MULTIPLE) {
>>> +        if (active == ACTIVE_CPU_NONE)
>>> +            active = cmpxchg_relaxed(&mm->context.active_cpu,
>>> +                         ACTIVE_CPU_NONE, cpu);
>>> +
>>> +        if (active != ACTIVE_CPU_NONE)
>>> +            WRITE_ONCE(mm->context.active_cpu, ACTIVE_CPU_MULTIPLE);
>>> +
>>> +        dsb(ishst);
>>> +    }
>>> +
>>>        /*
>>>         * Defer TTBR0_EL1 setting for user threads to uaccess_enable() when
>>>         * emulating PAN.


