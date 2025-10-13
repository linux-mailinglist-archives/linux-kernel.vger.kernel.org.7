Return-Path: <linux-kernel+bounces-851384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A09FEBD6532
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1445C3500C6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318D0270EDF;
	Mon, 13 Oct 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kEu+y36S"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013058.outbound.protection.outlook.com [40.93.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF51219E8
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389777; cv=fail; b=jyirTE00NsjmjxFJq0VOhLUtMPhH9IvaenpSaCS/aGGV8OgUGzfWByWCgbRH6v9XSxbQtejavnnwLKfD2aLM46K5GVinD5hoRdNl5YE5phiyjCyMnzWAAO7VDCWWUQYwTBr/tWb3e5XqmXm/O3RVwOp/cS2zg2EH8KkCa7VKbug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389777; c=relaxed/simple;
	bh=Kh6cn3TgWxregkz20KPEy7jPslh12pbku5ueIOqUGLw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h4fsi0lBf2Q+n1t9ZLIjcOxM0M6V/nJ/0g75FRFu4iS/XXcdAW9xW1QFR+z9Mi5ss7USPZbI7fYQ2xtnA6YtyuQz/T1JFvpV3n69/IwsvLHQPykTcl7h4OkjpiCxRvFg4ADwIwFz0RoP+phsJ8e+ynAdqDxrYT6//mjyzIGDQ0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kEu+y36S; arc=fail smtp.client-ip=40.93.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykDX6r2M3YZUsT92G5HX5W5rykalkim5Ri5f86vSNx7kYbbr3vD7QQJKQXQ2JPm5gVjQ6C/kYw6RpKasIFSrJwWLKjMv8mVTufVOLUrgDGZ62JkMg1Yi9FenlH2xudF7IAlQs39rm8ZSrsj8ySXyhCLc+K/xFs20VwdV/nsnDBh913BAtYh6FlfC+9HRLv+l8Y8H45e6eN9oS9ijkPr/PncgtRbF0lGOWA32KGairxWRGWUQUxX44UgtLwI7W5FtO5yYkPHeG2PKB5s9d9XRQ58+zxbYvKTyTKPJo99W7mwgEbTlCOPhp+tmcEibkIKKxW0armJ5qLwMLq9TMLmklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCAuQNYgZE7VHFK41F4rMLA8Lzsohg8BbA2RkdoAl1Y=;
 b=N9PfGBiPIUBwauZGRFZoqoZ6Yza0wCo6VP2s2WEqzVV9dKYsyGrm7HE3tRpWb9dr6Wptf9i8TsxZ0uJic77BeGpjfGnklBgGittwhA8N9E3AYZwY2uDiNb94E4k1Yak7TQJUb6S5IhAp1AcWSzIplzqnSI52koJrgm24CVojVWWPtcFlymWDEsPh8/IIcg2CQlW7K87dUpAPj67rm0ZKt0StR6YUiKqNYGh+z60yehZxMS4lwJmjCmtghJr5v+dUPB50xyFWAbLjmTfCC5sswIeqBnukHQfBx5/4VRDK9c5WL8l7Lxl+p6aR+hibaI5v/Z57XUClBNNSuMcuNZHi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCAuQNYgZE7VHFK41F4rMLA8Lzsohg8BbA2RkdoAl1Y=;
 b=kEu+y36Spf+m6F11h+JS6RBuGfniOCsVMZumeQWcLtAuOU5mNo0d+8kVTrCxDcIWCsztTFNBgp1HJ/61lXLkhnytZLrt7XfarbxwLl9d9EHfvF0Sp5SWBvguHQ4tTzZgFbpV612GUwyC5dJd1N8A1lgvMPP8qi44sJ5wqBnhU7lbQuu1lNaRVaXkZgXlAMiFGuu618f9mFoT4jS4ckmp8hXL18J+dQo/ZAu5k+2iKBz3SCVsMa+lL1nRTSXe1E/7NKo+kT9MDtamqGuYWnCxZ6uwPN6L2RiKSlBWZXxqlt3bH/dQwb8ejdCAFyDm2YOUemtkTvye0zf5HbHqggcRGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22)
 by BN5PR12MB9463.namprd12.prod.outlook.com (2603:10b6:408:2a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Mon, 13 Oct
 2025 21:09:32 +0000
Received: from DS0PR12MB7704.namprd12.prod.outlook.com
 ([fe80::e85e:e922:a750:e68b]) by DS0PR12MB7704.namprd12.prod.outlook.com
 ([fe80::e85e:e922:a750:e68b%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 21:09:32 +0000
Message-ID: <a58eeebf-7678-4003-9c30-e87d2540d121@nvidia.com>
Date: Mon, 13 Oct 2025 14:09:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] firmware: smccc: LFA: refactor, add device node
 support
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: salman.nabi@arm.com, lpieralisi@kernel.org, mark.rutland@arm.com,
 sudeep.holla@arm.com, ardb@kernel.org, chao.gao@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, sdonthineni@nvidia.com, vsethi@nvidia.com,
 vwadekar@nvidia.com
References: <20251008190907.181412-1-vvidwans@nvidia.com>
 <20251008190907.181412-3-vvidwans@nvidia.com>
 <20251011010348.67ca808c@minigeek.lan>
From: Vedashree Vidwans <vvidwans@nvidia.com>
In-Reply-To: <20251011010348.67ca808c@minigeek.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::21) To DS0PR12MB7704.namprd12.prod.outlook.com
 (2603:10b6:8:138::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7704:EE_|BN5PR12MB9463:EE_
X-MS-Office365-Filtering-Correlation-Id: 868add56-b84e-4dbf-8a5b-08de0a9cce0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cU85WCszUXZlUnFxMG9NQU5nZzlzTVJsY1VDemZFNkRQWXkyeUpXMlhNM0hB?=
 =?utf-8?B?dko2L2ZUeHY0K2Y0NS9IRHJOa3YvejY0WWkxQTg2NzlUOGpQWHM5Y1pieHFU?=
 =?utf-8?B?VWZiSjVlOHBiUWxOL0Y5OE52dWxTRTJzMytmMW8vcGtydlZRbFJPOEFQVDdm?=
 =?utf-8?B?ZWVJUnVDV1lpeEFwQmprREdhMzFtaXhBN2RxdmNsbVRFZFR2UnFxbWZibkda?=
 =?utf-8?B?VUVkNzkvR01hS2JiTmlLbzdoUDBObTlkVkU3MFBCRHVTaDJvU3ZYRFVJRnhi?=
 =?utf-8?B?b0JzN2RXbTd4SXlnSW1Ec3I2ZlFteWMvYVRiNFE3R0lMMlZKZGZDcVpubDJq?=
 =?utf-8?B?Wjd5OTBjYTZ1SGs2ek41Q2p1NGVQZk1wMXh1aGhnLzZuWFBleTJQQy8ybkYz?=
 =?utf-8?B?ZVhEV1FyajAzNmNYbEIyTHhFWmZ4QXhUTFRSTTFra1RsNUtwRmlDNS9tSFJU?=
 =?utf-8?B?S3RqR3M1NzRYSjR1Tm10V2o4QTNOM0JOcTZ5d3VtSkxBcUtkbkFOMGZ1Q2M4?=
 =?utf-8?B?b0IzKzNPYXI4eFF6RGx1OGJuMmlDdWhlWmlSckZadU83c01yUi8yWmNzMVNS?=
 =?utf-8?B?TTg4UnRUVk85T09nQnI0bTRhNWQ2RDEwUEsrRXQ3dmFXcCtkbWFES1djdzQy?=
 =?utf-8?B?MlNqYzFRU2tkQ0Z3amxoaldLcVZ0ODdwem9MeHAwbFAyNnVXZTdGa3BxTEV6?=
 =?utf-8?B?K2FzNSt4R050QmNGWmNIRXFGaGdmQkQxTGtHWHVDeW9idnJ4RHlOajZ4ak83?=
 =?utf-8?B?YlRSelo5WWtaNjVMYnk0dUpITnp5SEFraVpMOTFSQ2lmbFBBdUVWcEI3QnVY?=
 =?utf-8?B?Qk44ZGRYSVE3TmFhanhoUDc4SWRoNWx0L01oSTBaODRmVUhWWGZZYzUyWGZF?=
 =?utf-8?B?TjFHUVhzVFdxcU42dWZ0RlJzQkptcUFYeUZ3Z3VqblV0WnhWWmlkRkZRbnhJ?=
 =?utf-8?B?dmFIT3QwVTBQdWl3dVMvM3IxbEM2bC9RM0pmQ3RrL1VsWFBtUUp6eDEzMnJR?=
 =?utf-8?B?dmthQ0hZVXBvQWYxTG1FK1k4U2VKMTlFV0lnOTI4MXVPZTNKNlZSYkUxbk9M?=
 =?utf-8?B?dlFDZjJTWGxaY3BvZkxwMWJkSlc1WG55eVFTT3R4MFJhZHBLbm5jNllGQTVx?=
 =?utf-8?B?bjJPOEZSS3R4aU1QMklEcUpBclBJQVhUSVJUZ3dibEpGb05FejlxOGdrUCsr?=
 =?utf-8?B?RmhBZVZqRWdsN25qanBCTVNuczJwSXlESWk0NmptZUtPREJlQXBpYXhzcUFO?=
 =?utf-8?B?VEVCUVJVSk85U013UXgxcTRsYnVGakZIWENkYWJXc3RjYU96S1o0dmU4QkI1?=
 =?utf-8?B?MU0rVW9KdkxJR1dkWkxYY1RueVRiNE5aK3BsWFhMaDRNcW9HdUtyQWRSZkZE?=
 =?utf-8?B?TlJTaVYzOFRQSlYxQ1BZTDlrejRmYzFWaFNCdVZvNElTeWRUbGdONU1OckZ6?=
 =?utf-8?B?TmRka2d1a0QxMERQaVlicURUSTBaTmFSR2xSWDQ1MmNvV3Ewckx1U3FRd1Ru?=
 =?utf-8?B?bHFFdlVmZDFDaER2cnhBY2U3cjNSVS9YNXdPRHU4TkdlVWhkdlN0bXVHMWth?=
 =?utf-8?B?VGlwdEFvVXhsb1F3d0N0MVFsWmhXb284c2RNLzdmSjFHTi8xV1FFc2hWRmI4?=
 =?utf-8?B?bjNMOEtha0g0MzJsZHhkWlluQVNZTEwzV2xoOU5lNUs3Q2tKcXBkYnhzZDVt?=
 =?utf-8?B?Q09PaVE2bXFBdEFaU0k1MCtnWGpDWVpMNjVzSVJvbEZjQkRXZnlmU2c2WFNl?=
 =?utf-8?B?Z1hiMEpYNjFJYVlVWjE5YzZZZzVvSFhFZXdoQ1pFbFNnZWc4czA1dk9nS0FT?=
 =?utf-8?B?V2hZQnFRUkNob3duMGsrRVVNOEd2dWlTalRpaXJIcmh3QWc5dmNpQkpPY1N5?=
 =?utf-8?B?dGF0TDc5MGVzY2lMMU5HaHVJUERjYjNOSTJ0VEx2UEhSMlVLK2dnSnRLUU40?=
 =?utf-8?Q?g4Mj5xDDiVeRvQhUOb67y8AxhgZtBsyv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7704.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0FUbzBHc0NEV25RZ2l5dlBzSkRzcFZGVVlHSU0vRjRFaEZ1Mnlia3pKeG5V?=
 =?utf-8?B?bm5Dam04UmJPQ0hicUtNM04rRHpNWHMvQlBLaG9SeVBpNjZ4aXlyVkNKaTlu?=
 =?utf-8?B?SDZhVnZMbWhRckQ5TGlCbGxOVld2blVFNnNoajBWeE9IbmtrUTdhUFVkRXFm?=
 =?utf-8?B?cXYza2hpY1NpR01yeC9WSmI2T2hGV2ZXN1Z3MGFlZkE3SHhYUVdBRHNIK2Iz?=
 =?utf-8?B?ZEFiYzkvOXIwSHZGbVJtUzl4NzVNVlB1Z29sMS9hN1dGMytNTCtnMjI0aEhT?=
 =?utf-8?B?YUxYN09JeXV4bTV6L1FoVmVIbUw4bjZVbDJWaXBjcEpHcXU2QzdZcmdONi9r?=
 =?utf-8?B?T3hNTXpTNDdMVXIrOHRxZWhPWWQxckxsQks5Uy9FMzJ1cEtVUkZHT2JmQjl3?=
 =?utf-8?B?TjRhc1V0ejRBNTZCKytqUlM3Zm9ORUdBQ3p3Y2pReGdtT1c1VG5HbE9EYjFH?=
 =?utf-8?B?b3dWenNpT0QyMDJLeGMrdnFEL3gzN2dlL2VWenpReENBS1AzTjVIbzgwazNy?=
 =?utf-8?B?SGIzMGtkckhxcnJheVA2Rmgwa1k4L0NkWnJSWnlWMGdxVnRCNzRDME5OU0FH?=
 =?utf-8?B?S1o4bWlhU2gvVFNkWjJTSmswVEEySXhCbW93T083aXZLWk92VElZMjdjZTlm?=
 =?utf-8?B?UlhiNFhvZVp0WENkblovTVl1ZEJWY1ZFRGNTYks3WHhFUlhhckRCd1JTd29B?=
 =?utf-8?B?N3lUamNtMEJjZ1gvakkvOVlpcjV4OHFjS0Z5Y0FWQXVZZ2tHWHM1K3ZMT1Ar?=
 =?utf-8?B?STVycUpOQTNRdURLS0dYWm1zT05kZXlkR3hKL0EyWWlHS3lkb2tLOUYxM1gx?=
 =?utf-8?B?UWdNMXUyY0JmTk1TczJLeDZRcGdETEJOMDdnVnJ6azQ3dHJFb3phSnFLTHpV?=
 =?utf-8?B?QW1GWTVET2k0T0dVcDJwdnFvMExXd3ZhSTRmRlZOUzd0WTBKVEMwSWhrSWdL?=
 =?utf-8?B?Z2FlUUV3TXliL3p0ZW5YSEd6MDE1aFhjQ1VFUjRtYmtZckE3RTgrYVh6UGhL?=
 =?utf-8?B?d0xnT0tFR3hsOTVPR25SNVNUOXYxN0lzQ0hId05BcHZHNERzTmc2NGJGOXRZ?=
 =?utf-8?B?MVN4cUIyampGOGpIQWt0ZDh6eFVzdVFIQ0xNenJCNWN3QW04S0Z0OXUzQ21Y?=
 =?utf-8?B?cjZWZEh5R2JYcm5hUXQ3aXNsbUJGbExta2tOallMRmlURFE3VWorQ1hiamxZ?=
 =?utf-8?B?VGRtN0I5SnZFY2hLMFBwVndVNjM4RUplWlEyVXJZejRDTzdVbzRmbko2cjF0?=
 =?utf-8?B?SWo1eFk2YUI4MTRVdS94VDk1UCtKc3pTTExGRGVWVFVYc0dpcjVNL0dZWUk3?=
 =?utf-8?B?b3BWSW4xd3hFUG5YQTF6QnQ0UFZDU3FoL3paZjBIUkp6dVp2T2k2RmNCRFBt?=
 =?utf-8?B?eVhMbVorOXB4NUlyU1dOemhBZFFYc3djb1Vrenh0Y3lxdVRkWElWeUE5MkRK?=
 =?utf-8?B?WUNuVUhtRjZ0K2dYT3NORTcxNDBrdVd6cVN2R0NYMjJUdVRvMEJqUStYV2xh?=
 =?utf-8?B?Qzd1S2lPVU5RUVZJWUduMFpZQVRBSkJmVUYyNHdaaGYzMUUzM2VXVWxzWTJs?=
 =?utf-8?B?NlZSbG8yWHN0elcxdzcxZlQ4cklWVkJ4cmpXL2h6U1N5VVdoOXlWc0E5V2Vp?=
 =?utf-8?B?RzdtZGxlRVdzSFl5bkx4anVqOUtESURCQ3RwTjkwMVk0SDJNY0EvbDRjRmVo?=
 =?utf-8?B?T3MwcmVYeGFrOFJjOGV6VWRiNjd3a2V3dVhsNFhXekRwa0kvaGpYaUdiTmFs?=
 =?utf-8?B?M1ZHcE91N280UnFvSVRlZ3hYRjFPWjRsY2dRTEpndDlxV0xTMGhoT09IRjNF?=
 =?utf-8?B?NkthYU5EaHpXd2F2K09XaGwzRlRvRXA3VHNrdStyVjBKWVBpSmpsWCtUZE9R?=
 =?utf-8?B?YnRaVi9vMWpNRHNkL3RHZW93WFVRS3FzWngxNlhjS3BYQ25vK3dtRXU4bkFE?=
 =?utf-8?B?aXRpdzJPRFlzYnNydjl6RVEyQ3JrcjY1WlZZOTcwalZEajA4aFB5TkllNjll?=
 =?utf-8?B?a1FjeitWalI1NFoxR0I5U3Q2QVVpeXp5UTlYTWx4ZUZnZmxRM25ONzFkejlQ?=
 =?utf-8?B?YVRTekpQZVZEamd3Q1ExVXJoVlRKVFowQmFRcFlyY2VnUVRaQ3JPaTRmaDh6?=
 =?utf-8?Q?DMXn5Fi+u+rBVxVzOuvRdwEKh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868add56-b84e-4dbf-8a5b-08de0a9cce0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7704.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 21:09:32.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sxp1CpkcMCd3PXC5rj5QJs1gbu0UKosQ6Sxi8SAd9GpXGStJbKVRlo0O5HROPWGLy4jrNrqK26/W+UPYOvWlHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9463



On 10/10/25 17:03, Andre Przywara wrote:
> On Wed, 8 Oct 2025 19:09:06 +0000
> Vedashree Vidwans <vvidwans@nvidia.com> wrote:
> 
> Hi Vedashree,
> 
> thanks for sharing this code, that's much appreciated! I wonder whether
> it's possible to split this patch up, as it's doing multiple things at
> once, and it's harder to follow, review and comment on.
> The bullet points below basically give away how to split this: first do
> the refactors and fixes, then add each feature, in a separate patch.
> 
I understand, let me split the patches in next iteration.> Just one 
general comment for now ...
> 
>> - Add support for LFA device node in the kernel driver. Implement
> 
> That "device node" put me off a bit, do you mean you register a platform
> device, to connect this to that ACPI node?
> I wonder if we can use this new faux device instead of a platform
> device, since it's not a real device? Or maybe even query the ACPI or
> DT nodes without a device at all, like using of_find_compatible_node()
> or something?
> 
> Cheers,
> Andre
> 
I haven't completely understood your suggestion/question about using a 
faux device. But here is some context.
This patch registers the driver as a platform driver corresponding to 
device "arm,armhf000".
As the spec recommends, we would have a "arm,armhf000" node in 
devicetree with appropriate interrupt and payload information.
The OS will invoke this driver when it finds corresponding device.
Could you please elaborate/add details for your question?

Regards,
Veda>> probe() to register LFA interrupt and threaded interrupt service
>> function.
>> - CPUs will be rendezvoused during activation.
>> - On IRQ, driver will query FW components then triggers activation of
>> capable and pending components.
>> - Mutex synchronization is implemented to avoid concurrent LFA updates
>> through interrupt and sysfs interfaces.
>> - Refactor LFA CANCEL logic into independent lfa_cancel() function.
>> - Enhance PRIME/ACTIVATION functions to touch watchdog and implement
>> timeouts.
>>
>> Signed-off-by: Vedashree Vidwans <vvidwans@nvidia.com>
>> ---
>>   drivers/firmware/smccc/lfa_fw.c | 299 ++++++++++++++++++++++++++++----
>>   1 file changed, 262 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/firmware/smccc/lfa_fw.c b/drivers/firmware/smccc/lfa_fw.c
>> index 49f7feb6a211b..b36b8d7457c30 100644
>> --- a/drivers/firmware/smccc/lfa_fw.c
>> +++ b/drivers/firmware/smccc/lfa_fw.c
>> @@ -16,7 +16,15 @@
>>   #include <linux/uuid.h>
>>   #include <linux/array_size.h>
>>   #include <linux/list.h>
>> -
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/acpi.h>
>> +#include <linux/nmi.h>
>> +#include <linux/ktime.h>
>> +#include <linux/delay.h>
>> +#include <linux/mutex.h>
>> +
>> +#define DRIVER_NAME	"ARM_LFA"
>>   #define LFA_ERROR_STRING(name) \
>>   	[name] = #name
>>   #undef pr_fmt
>> @@ -34,6 +42,18 @@
>>   #define LFA_1_0_FN_ACTIVATE		LFA_1_0_FN(5)
>>   #define LFA_1_0_FN_CANCEL		LFA_1_0_FN(6)
>>   
>> +/* CALL_AGAIN flags (returned in res.a1[0]) */
>> +#define LFA_PRIME_CALL_AGAIN		BIT(0)
>> +#define LFA_ACTIVATE_CALL_AGAIN		BIT(0)
>> +
>> +/* Prime loop limits, TODO: tune after testing */
>> +#define LFA_PRIME_BUDGET_US		30000000 /* 30s cap */
>> +#define LFA_PRIME_POLL_DELAY_US		10       /* 10us between polls */
>> +
>> +/* Activation loop limits, TODO: tune after testing */
>> +#define LFA_ACTIVATE_BUDGET_US		20000000 /* 20s cap */
>> +#define LFA_ACTIVATE_POLL_DELAY_US	10       /* 10us between polls */
>> +
>>   /* LFA return values */
>>   #define LFA_SUCCESS			0
>>   #define LFA_NOT_SUPPORTED		1
>> @@ -114,8 +134,9 @@ static const struct fw_image_uuid {
>>   };
>>   
>>   static struct kobject *lfa_dir;
>> +static DEFINE_MUTEX(lfa_lock);
>>   
>> -static int get_nr_lfa_components(void)
>> +static unsigned long get_nr_lfa_components(void)
>>   {
>>   	struct arm_smccc_1_2_regs args = { 0 };
>>   	struct arm_smccc_1_2_regs res = { 0 };
>> @@ -130,11 +151,40 @@ static int get_nr_lfa_components(void)
>>   	return res.a1;
>>   }
>>   
>> +static int lfa_cancel(void *data)
>> +{
>> +	struct image_props *attrs = data;
>> +	struct arm_smccc_1_2_regs args = { 0 };
>> +	struct arm_smccc_1_2_regs res = { 0 };
>> +
>> +	args.a0 = LFA_1_0_FN_CANCEL;
>> +	args.a1 = attrs->fw_seq_id;
>> +	arm_smccc_1_2_invoke(&args, &res);
>> +
>> +	/*
>> +	 * When firmware activation is called with "skip_cpu_rendezvous=1",
>> +	 * LFA_CANCEL can fail with LFA_BUSY if the activation could not be
>> +	 * cancelled.
>> +	 */
>> +	if (res.a0 == LFA_SUCCESS) {
>> +		pr_info("Activation cancelled for image %s",
>> +			attrs->image_name);
>> +	} else {
>> +		pr_err("Firmware activation could not be cancelled: %ld",
>> +		       (long)res.a0);
>> +		return -EIO;
>> +	}
>> +
>> +	return res.a0;
>> +}
>> +
>>   static int call_lfa_activate(void *data)
>>   {
>>   	struct image_props *attrs = data;
>>   	struct arm_smccc_1_2_regs args = { 0 };
>>   	struct arm_smccc_1_2_regs res = { 0 };
>> +	ktime_t end = ktime_add_us(ktime_get(), LFA_ACTIVATE_BUDGET_US);
>> +	int ret;
>>   
>>   	args.a0 = LFA_1_0_FN_ACTIVATE;
>>   	args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
>> @@ -148,9 +198,32 @@ static int call_lfa_activate(void *data)
>>   	 */
>>   	args.a2 = !(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous);
>>   
>> -	do {
>> +	for (;;) {
>> +		/* Touch watchdog, ACTIVATE shouldn't take longer than watchdog_thresh */
>> +		touch_nmi_watchdog();
>>   		arm_smccc_1_2_invoke(&args, &res);
>> -	} while (res.a0 == 0 && res.a1 == 1);
>> +
>> +		if ((long)res.a0 < 0) {
>> +			pr_err("ACTIVATE for image %s failed: %s",
>> +				attrs->image_name, lfa_error_strings[-res.a0]);
>> +			return res.a0;
>> +		}
>> +		if (!(res.a1 & LFA_ACTIVATE_CALL_AGAIN))
>> +			break; /* ACTIVATE successful */
>> +
>> +		/* SMC returned with call_again flag set */
>> +		if (ktime_before(ktime_get(), end)) {
>> +			udelay(LFA_ACTIVATE_POLL_DELAY_US);
>> +			continue;
>> +		}
>> +
>> +		pr_err("ACTIVATE timed out for image %s", attrs->image_name);
>> +		ret = lfa_cancel(attrs);
>> +		if (ret == 0)
>> +			return -ETIMEDOUT;
>> +		else
>> +			return ret;
>> +	}
>>   
>>   	return res.a0;
>>   }
>> @@ -159,8 +232,24 @@ static int activate_fw_image(struct image_props *attrs)
>>   {
>>   	struct arm_smccc_1_2_regs args = { 0 };
>>   	struct arm_smccc_1_2_regs res = { 0 };
>> +	ktime_t end = ktime_add_us(ktime_get(), LFA_PRIME_BUDGET_US);
>>   	int ret;
>>   
>> +	if (attrs->may_reset_cpu) {
>> +		pr_err("Firmware component requires unsupported CPU reset");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * We want to force CPU rendezvous if either cpu_rendezvous or
>> +	 * cpu_rendezvous_forced is set. The flag value is flipped as
>> +	 * it is called skip_cpu_rendezvous in the spec.
>> +	 */
>> +	if (!(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous)) {
>> +		pr_warn("CPU rendezvous is expected to be selected.");
>> +		return -EAGAIN;
>> +	}
>> +
>>   	/*
>>   	 * LFA_PRIME/ACTIVATE will return 1 in res.a1 if the firmware
>>   	 * priming/activation is still in progress. In that case
>> @@ -169,20 +258,36 @@ static int activate_fw_image(struct image_props *attrs)
>>   	 */
>>   	args.a0 = LFA_1_0_FN_PRIME;
>>   	args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
>> -	do {
>> +	for (;;) {
>> +		/* Touch watchdog, PRIME shouldn't take longer than watchdog_thresh */
>> +		touch_nmi_watchdog();
>>   		arm_smccc_1_2_invoke(&args, &res);
>> -		if (res.a0 != LFA_SUCCESS) {
>> -			pr_err("LFA_PRIME failed: %s\n",
>> -				lfa_error_strings[-res.a0]);
>>   
>> +		if ((long)res.a0 < 0) {
>> +			pr_err("LFA_PRIME for image %s failed: %s\n",
>> +				attrs->image_name, lfa_error_strings[-res.a0]);
>>   			return res.a0;
>>   		}
>> -	} while (res.a1 == 1);
>> +		if (!(res.a1 & LFA_PRIME_CALL_AGAIN))
>> +			break; /* PRIME successful */
>>   
>> -	if (attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous)
>> -		ret = stop_machine(call_lfa_activate, attrs, cpu_online_mask);
>> -	else
>> -		ret = call_lfa_activate(attrs);
>> +		/* SMC returned with call_again flag set */
>> +		if (ktime_before(ktime_get(), end)) {
>> +			udelay(LFA_PRIME_POLL_DELAY_US);
>> +			continue;
>> +		}
>> +
>> +		pr_err("PRIME timed out for image %s", attrs->image_name);
>> +		ret = lfa_cancel(attrs);
>> +		if (ret == 0)
>> +			return -ETIMEDOUT;
>> +		else
>> +			return ret;
>> +	}
>> +
>> +	ret = stop_machine(call_lfa_activate, attrs, cpu_online_mask);
>> +	if (ret != 0)
>> +		return lfa_cancel(attrs);
>>   
>>   	return ret;
>>   }
>> @@ -286,23 +391,23 @@ static ssize_t activate_store(struct kobject *kobj, struct kobj_attribute *attr,
>>   					 image_attrs[LFA_ATTR_ACTIVATE]);
>>   	int ret;
>>   
>> -	if (attrs->may_reset_cpu) {
>> -		pr_err("Firmware component requires unsupported CPU reset\n");
>> -
>> -		return -EINVAL;
>> +	if (!mutex_trylock(&lfa_lock)) {
>> +		pr_err("Mutex locked, try again");
>> +		return -EAGAIN;
>>   	}
>>   
>>   	ret = activate_fw_image(attrs);
>>   	if (ret) {
>>   		pr_err("Firmware activation failed: %s\n",
>>   			lfa_error_strings[-ret]);
>> -
>> +		mutex_unlock(&lfa_lock);
>>   		return -ECANCELED;
>>   	}
>>   
>>   	pr_info("Firmware activation succeeded\n");
>>   
>>   	/* TODO: refresh image flags here*/
>> +	mutex_unlock(&lfa_lock);
>>   	return count;
>>   }
>>   
>> @@ -311,26 +416,11 @@ static ssize_t cancel_store(struct kobject *kobj, struct kobj_attribute *attr,
>>   {
>>   	struct image_props *attrs = container_of(attr, struct image_props,
>>   						 image_attrs[LFA_ATTR_CANCEL]);
>> -	struct arm_smccc_1_2_regs args = { 0 };
>> -	struct arm_smccc_1_2_regs res = { 0 };
>> -
>> -	args.a0 = LFA_1_0_FN_CANCEL;
>> -	args.a1 = attrs->fw_seq_id;
>> -	arm_smccc_1_2_invoke(&args, &res);
>> +	int ret;
>>   
>> -	/*
>> -	 * When firmware activation is called with "skip_cpu_rendezvous=1",
>> -	 * LFA_CANCEL can fail with LFA_BUSY if the activation could not be
>> -	 * cancelled.
>> -	 */
>> -	if (res.a0 == LFA_SUCCESS) {
>> -		pr_info("Activation cancelled for image %s\n",
>> -			attrs->image_name);
>> -	} else {
>> -		pr_err("Firmware activation could not be cancelled: %s\n",
>> -		       lfa_error_strings[-res.a0]);
>> -		return -EINVAL;
>> -	}
>> +	ret = lfa_cancel(attrs);
>> +	if (ret != 0)
>> +		return ret;
>>   
>>   	return count;
>>   }
>> @@ -418,6 +508,11 @@ static int create_fw_images_tree(void)
>>   	int ret, num_of_components;
>>   
>>   	num_of_components = get_nr_lfa_components();
>> +	if (num_of_components <= 0) {
>> +		pr_err("Error getting number of LFA components");
>> +		return -ENODEV;
>> +	}
>> +
>>   	args.a0 = LFA_1_0_FN_GET_INVENTORY;
>>   	for (int i = 0; i < num_of_components; i++) {
>>   		args.a1 = i; /* fw_seq_id under consideration */
>> @@ -437,6 +532,125 @@ static int create_fw_images_tree(void)
>>   	return 0;
>>   }
>>   
>> +static int refresh_fw_images_tree(void)
>> +{
>> +	int ret;
>> +	/*
>> +	 * Ideally, this function should invoke the GET_INVENTORY SMC
>> +	 * for each firmware image and update the corresponding details
>> +	 * in the firmware image tree node.
>> +	 * There are several edge cases to consider:
>> +	 *    - The number of firmware components may change.
>> +	 *    - The mapping between firmware sequence IDs and
>> +	 *      firmware image UUIDs may be modified.
>> +	 * As a result, it is possible that the firmware image tree nodes
>> +	 * will require updates. Additionally, GET_INVENTORY SMC provides
>> +	 * all current and revised information. Therefore, retaining the
>> +	 * existing fw_images_tree data is not justified. Reconstructing
>> +	 * the firmware images tree will simplify the code and keep data
>> +	 * up-to-date.
>> +	 */
>> +	// Clean current inventory details
>> +	clean_fw_images_tree();
>> +
>> +	// Update new inventory details
>> +	ret = create_fw_images_tree();
>> +	if (ret != 0)
>> +		kobject_put(lfa_dir);
>> +
>> +	return ret;
>> +}
>> +
>> +static irqreturn_t lfa_irq_thread(int irq, void *data)
>> +{
>> +	struct image_props *attrs = NULL;
>> +	int ret;
>> +
>> +	mutex_lock(&lfa_lock);
>> +
>> +	// Update new inventory details
>> +	ret = refresh_fw_images_tree();
>> +	if (ret != 0)
>> +		goto exit_unlock;
>> +
>> +	/*
>> +	 * Execute PRIME and ACTIVATE for each FW component
>> +	 * Start from first FW component
>> +	 */
>> +	list_for_each_entry(attrs, &lfa_fw_images, image_node) {
>> +		if ((!attrs->activation_capable) || (!attrs->activation_pending)) {
>> +			/* LFA not applicable for this FW component, continue to next component */
>> +			continue;
>> +		}
>> +
>> +		ret = activate_fw_image(attrs);
>> +		if (ret) {
>> +			pr_err("Firmware %s activation failed: %s\n",
>> +				attrs->image_name, lfa_error_strings[-ret]);
>> +			goto exit_unlock;
>> +		}
>> +
>> +		pr_info("Firmware %s activation succeeded", attrs->image_name);
>> +	}
>> +
>> +	// Update new inventory details
>> +	ret = refresh_fw_images_tree();
>> +	if (ret != 0)
>> +		goto exit_unlock;
>> +
>> +exit_unlock:
>> +	mutex_unlock(&lfa_lock);
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int __init lfa_probe(struct platform_device *pdev)
>> +{
>> +	int err;
>> +	unsigned int irq;
>> +
>> +	err = platform_get_irq_byname_optional(pdev, "fw-store-updated-interrupt");
>> +	if (err < 0)
>> +		err = platform_get_irq(pdev, 0);
>> +	if (err < 0) {
>> +		pr_err("Interrupt not found, functionality will be unavailable.");
>> +
>> +		/* Bail out without failing the driver. */
>> +		return 0;
>> +	}
>> +	irq = err;
>> +
>> +	err = request_threaded_irq(irq, NULL, lfa_irq_thread, IRQF_ONESHOT, DRIVER_NAME, NULL);
>> +	if (err != 0) {
>> +		pr_err("Interrupt setup failed, functionality will be unavailable.");
>> +
>> +		/* Bail out without failing the driver. */
>> +		return 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id lfa_of_ids[] = {
>> +	{ .compatible = "arm,armhf000", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, lfa_of_ids);
>> +
>> +static const struct acpi_device_id lfa_acpi_ids[] = {
>> +	{"ARMHF000"},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, lfa_acpi_ids);
>> +
>> +static struct platform_driver lfa_driver = {
>> +	.probe = lfa_probe,
>> +	.driver = {
>> +		.name = DRIVER_NAME,
>> +		.of_match_table = lfa_of_ids,
>> +		.acpi_match_table = ACPI_PTR(lfa_acpi_ids),
>> +	},
>> +};
>> +
>>   static int __init lfa_init(void)
>>   {
>>   	struct arm_smccc_1_2_regs args = { 0 };
>> @@ -464,22 +678,33 @@ static int __init lfa_init(void)
>>   	pr_info("Arm Live Firmware Activation (LFA): detected v%ld.%ld\n",
>>   		res.a0 >> 16, res.a0 & 0xffff);
>>   
>> +	err = platform_driver_register(&lfa_driver);
>> +	if (err < 0)
>> +		pr_err("Platform driver register failed");
>> +
>> +
>>   	lfa_dir = kobject_create_and_add("lfa", firmware_kobj);
>>   	if (!lfa_dir)
>>   		return -ENOMEM;
>>   
>> +	mutex_lock(&lfa_lock);
>>   	err = create_fw_images_tree();
>>   	if (err != 0)
>>   		kobject_put(lfa_dir);
>>   
>> +	mutex_unlock(&lfa_lock);
>>   	return err;
>>   }
>>   module_init(lfa_init);
>>   
>>   static void __exit lfa_exit(void)
>>   {
>> +	mutex_lock(&lfa_lock);
>>   	clean_fw_images_tree();
>> +	mutex_unlock(&lfa_lock);
>> +
>>   	kobject_put(lfa_dir);
>> +	platform_driver_unregister(&lfa_driver);
>>   }
>>   module_exit(lfa_exit);
>>   
> 


