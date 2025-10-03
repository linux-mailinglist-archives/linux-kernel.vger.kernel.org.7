Return-Path: <linux-kernel+bounces-841435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE6BB74F2
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67E73AF821
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA519284890;
	Fri,  3 Oct 2025 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AHMHrdSK"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3890A1EB195
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759504724; cv=fail; b=TUALLJpyrhkCA2PLC0KORGKbh1RFw2+zaBiUo4Vj/31S92LKgGErSJyou5/4EA91W/QuGBPA+TYOOUhiIcdPHqVA4QGDriw+cB0+7heQVcNAwi82VI5g+EUB+3fLVtTF0/nL+sPTBs65/14D+Q9ZVK6EWywLnCrKzAi5TI3lrYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759504724; c=relaxed/simple;
	bh=a9rME1tRbyVJAMGUOZJfJIzJPenREKI06XmJLJB7j+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uoweSQp/LD0Elb2YG7+iNfKQ9jXQajGM5sPv8dAFlUaOmD3zfX+aMWRqX73XGrgQQ0vSVuGRNiXgx1dFNUMqC4Vigqbig47H71/ymt3io/MwEuQYA4rdwvoLcZdL3Ki/8Rv3ufvEsp6ax5u6SWvxhuY9XidzMvN9Ja+eoILAO44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AHMHrdSK; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vdb8r3ScDtehLxX6iGgFpKCfFnvjhvHfGtpHU3wKoz+Oqg4ZrkZROpymJhSml8BP3ru5Me+NJBMBDIdvIwxqE6BC8xR3HUzicZx6wBlDGMrIPPkvlfTK6AHpXkzbUgj6rsfRY2gkqAlvjOVNU4cDJRHf5jCcOL3zZQeFyy9cb/ZHLUVutwuWip2Y2HqzlJusbugyVy6JDhlXxzRSFS7EP0zR/YV6e/1X4pS/FnhONJZyIltw5ki1WkE48SSMoVC45PTuq2tDS5/TWM+2ELsY2r8ISx6xXF/nh8irDB3WoDFSEb/+K3fK+SQAkPRS/d4xAfgOShBU9BI5ZNUohU2Fsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utLGra6FqBGAm1mX/cUcnfo0FFk+7hwqAkel0Ub6KO4=;
 b=ue3a5tfdn2Fungx1Arfl7q+4iMm7vSTwQEV+ulqYa5utI1/ckjtqwqiFvM7SX0HST2lAIM5vPuxEfXk0B2rWNn1YpomjxcjENuAY++LOpvHDNT5aBztNG5oG2wvfs0Wn9zP27n6BYbMeTX79TIleIWkJNH0XBOvevSI4dij/4fIf9T9tanDRa7DPtWteT4ZjyabxV+HIXspqCpTR08PyNCBQN+xmPGRdqv9KoI3pv28z7TFZ55Be9YAtEzjLr1V9ZU90lpD6h+0csb8XcHwNEwqmNZucYxdF2p/xsawdfqGpRRc0ebSM5FFJ7mMzrkNS7oA4h+WHa/fvVO+wBnpWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utLGra6FqBGAm1mX/cUcnfo0FFk+7hwqAkel0Ub6KO4=;
 b=AHMHrdSKIvBYVe/ap9FuoRFsQ7W4XJttT+L7p93k7rXzVfYiZBQPbrwXoyi0rpMmBqdhuqdpTtIRdHsNGmq1UOFeLtgPKlhjGjlpRnh6B4LVjEsYKy7BaryiWsfTXtVQXKTO9C32yk2kOjVjKFXQAFqmNCOTvLgYWJ1wRNJZ73s1as7kdcb5RJ5J03bXLKACI+3Cyd88E+j4mv8y3NG8+I8yXb0yF/gOpFYUjqBkv4KbL+G+Pso9xGidlpK1HivvQA1vMNCkH1wuhf03JIWwmrT8TEQCM3VdRaKVwlWgPz8XjHfnz4Ypht/18Cd0wDjdIpT5uqcHX5KfpHlgbL6S0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Fri, 3 Oct 2025 15:18:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 15:18:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: jinji zhong <jinji.z.zhong@gmail.com>
Cc: akpm@linux-foundation.org, feng.han@honor.com, hannes@cmpxchg.org,
 jackmanb@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 liulu.liu@honor.com, mhocko@suse.com, surenb@google.com, vbabka@suse.cz,
 zhongjinji@honor.com
Subject: Re: [PATCH v0] mm/page_alloc: Cleanup for __del_page_from_free_list()
Date: Fri, 03 Oct 2025 11:18:32 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <7B0DF4ED-FBB8-48E5-95B7-4C32B645F4A6@nvidia.com>
In-Reply-To: <20251001043809.11019-1-jinji.z.zhong@gmail.com>
References: <F1AB428D-73B3-4E40-939C-2A7BAEA1E73A@nvidia.com>
 <20251001043809.11019-1-jinji.z.zhong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:408:ee::19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY1PR12MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: c9177935-57a8-4c45-3abb-08de02901ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vnl0eDFjdm50Q2pTOVg4L2dOUUgrcGJCdTFRZER1dXBIcGF2Z2h6ZHAyRHBT?=
 =?utf-8?B?SHpPUzcwL1FCTC9XWHg5bkFsR2NRb21qOGpmL2xqZis0bng0WWt3RUpTaFhH?=
 =?utf-8?B?Ynd4UWhIWTJXa0U0emJzMDQxTGpaY04xVldzUjh5S3k3Mkozc2pZOEZveDla?=
 =?utf-8?B?VnErQW5LbUkrUmQ0UWpVN3AvdFRYb1VlWXJ5ckJncjRuRVdSWWNHVkxtOGZz?=
 =?utf-8?B?N2RodEExNExMWWlsRVFrM0tWbU5WcytWcXJlYTJ4bXFGSElWQUtjbTZFL0FI?=
 =?utf-8?B?UXFPV2pxdE5DK3I5OHowNDQ4dDNlNDAxbDFSOCtSTHgyNklEeUJKOFl1Yjhj?=
 =?utf-8?B?TFV2QmZUMTNWbVEyZEowR2hTUEs0dFNUdHB2bDRrWUw4UDRMSU5jRGFBQmYy?=
 =?utf-8?B?eWZXcWdqSi9iZFJEL2xRWUkzTDI5SlU1dHV2SGJHVlVBbFB1bCtLWFRrVnVa?=
 =?utf-8?B?Z1Z2REtUZFF4NmZNVkR5dWsrenVFNTVSUDM3T2txbzdmMFBjU0xQbUVUMElM?=
 =?utf-8?B?aG4vTG9RVE0vdFY2bXc3bU5RaUlOeHlSTFhLNmNtbTVyaU1SbDZaQThYbnFa?=
 =?utf-8?B?cnJhWTBGRkk5QzNXWkpnQmtKMW54S2hCOVRrRVZrT1J3bjNuRUNjcmkxd2RH?=
 =?utf-8?B?dVFBL3BueUoxN29KYlZtMDN1Uk9zTWdWdUc3YU1IWEtPV05OazlwQ1I5ejB5?=
 =?utf-8?B?cmdUNEhoU3RrR0hPUmxRVmJoa1U3V1dDamVRUEtpSlpoY2dvWVdWSk9qSTNJ?=
 =?utf-8?B?TkphaW9KdEIxVXNldnF5S0FDcWhMRVZjWmNNWmxNQTlnUnExRFI5M2o5emsv?=
 =?utf-8?B?dHlURW9YVFlLb01kb2Zubk9la0poWUMyZ3hBUUo0ZXpOcnNoV28vbzdRQm5O?=
 =?utf-8?B?WlNReDJQUktONWRzNE03S0JHZnZlZWxtSHpyWFYrdzJNZmYyN1JpRkNuZ3FE?=
 =?utf-8?B?Wk1EeWR4UHh5L0xMR1ZnRTdZY3hDYzVkZ3RhditqYzRHWDJ2a091YWRaVHRv?=
 =?utf-8?B?Rk9PUERGcGFFY1RodTYwV3o2TUUzQk1rbHI4VkVtS0FyUWhSSWdVeUVZbm1H?=
 =?utf-8?B?cDlqWGl3TklNQm9DTjdBMFFsODR0UWl3dCtMaTBYYXVZU0ZoMVFyNWNCcWdh?=
 =?utf-8?B?NmV4TmRpdEVvL3BKUTNVaXUxZ1JJMHE4NkJweG5vcFNDa2pzRjdRMkpTL3E0?=
 =?utf-8?B?KytRVVUwR3RRdlZvVEtjTTJDWmlKRjhzVzJZVFpsL3hEMzJIYU1SU0pCZmdV?=
 =?utf-8?B?Mjd0RmpmR3Z6Mk94QUhHSktoSEZpMHo4a0hEUlJJWnpjS25rMFJxOEN6djNw?=
 =?utf-8?B?MzdldWpZanpOa2NLeVdYMFlBRCtDTW5neUJJS3ZZNFpYZTFkckc0dXpCbEcy?=
 =?utf-8?B?bysyQldGUWF5SE1vTzg3cHh5dDg3MUY5d1haTTJuRC85aXduMWhoQ3BtRVJa?=
 =?utf-8?B?RS9SdnJ4M1kvdkdOdG9JbGxCaHFIQUNEODZJWU9TODF5ZDduNWtlcW8rMW94?=
 =?utf-8?B?UGJjdGREeHJqbDJRN0xRaW13bFdTL0RLdTZBQXJzK254YWlNek5zWUhRVzQr?=
 =?utf-8?B?anR5b09EbjRQQnFZVHhkTUg2QUhCRXVRTUhsWkRpWFViaGZoVHl6bGJmRTdR?=
 =?utf-8?B?SDRHaG84Q3NxMHBXMFp2WTNwSzdYRkxLTGFiUE1vNVcxK2ZEbThBaUtJR1pY?=
 =?utf-8?B?WjEyVFVnOFFYR2trRUo2NE15dkl2ejFHWVdMdTZ3bmZUSjBqZ0NlbzNhY1cr?=
 =?utf-8?B?aUNwdndweGFRekxEeXlUK21LcnlRcS80ZW9TY3dQZHVGQWx5elFmOUVWMlpG?=
 =?utf-8?B?SUtpRjlRQ3loOS9VdjFPNmNOOHhHMHJsRkliQ0x2aUhFQ0VocHdWYml4TnYr?=
 =?utf-8?B?RW1OL0Fxc0tEZDFiL1IrZ0x5RDVCSC9GUkttZGNsN3VLRC85U0NxMHRwRnVq?=
 =?utf-8?B?WDhNcEhsNC9qMnh5czBUTEdWMUpsRzV4TUZXOUhZZUJWWHJjOVFtUEZWWkRp?=
 =?utf-8?B?amMyMVdZNWRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWtqNmN6aTBscGhTZXVUSkJpTVd4TUpWU2h4Y2hSVkVvSjYyNlY4eHYwaVNM?=
 =?utf-8?B?c0piSThkY3ZDbjBNbzJJbzVvRXZyalpSUkErUXNXZnYyaXBqa2o4L2QvY0oz?=
 =?utf-8?B?enRKamUzVHRuQmJEKzB3V0s2UlNkK2dCVkxIOUw0enora0J4WnFMVldiNlFP?=
 =?utf-8?B?L2dQL2JjWVAxQUlRM3VSWHRqNXpzbXhRUGhtcXIyN0t0NnZ3a21IeWJwZlZX?=
 =?utf-8?B?NjVId1daSW1WMmdqeEQzZG9CK29TUGxTZDNzUE5KMVgwbDBpMTcrR0lmOXlo?=
 =?utf-8?B?UlIvbXZSOU1uL3BCUnFybFQwVy9neXREOUh2eTUycGp1djVxNk1xSG1Kby96?=
 =?utf-8?B?U01tYXo0MFlPbVZWcjh3cSticXJTbitGWjhxSVBpNlNPNEJQVnQvdXJ6ZGRw?=
 =?utf-8?B?c3BVWEE1Sk1mdjZqN1JvNS9vU0FYdFI1cENOcS96M01Sd1NNREttL0NyN3lS?=
 =?utf-8?B?dW1oVmdhUEtBMjhvQU9pTkw3cXJCVElMbmwyc3RzUTRFaHRYU1hMWVFjY0o2?=
 =?utf-8?B?MWJ5aFdrQ1RCanFPY012RXViRGt0WXhJMWF1dUhlbmloTEJjcjlZSzVRYkpJ?=
 =?utf-8?B?c1AwYUN3NVR1Tk51UXNyWStqQWUxeHNLRFpTNkJ5K1dzT2tEbUIvNjN6UExs?=
 =?utf-8?B?WHQySFVYQjhoN0kycm0wNGhCdDFpVU4vL2VZZnllbkFxaGJEOWtndjRxWFRo?=
 =?utf-8?B?SnVrTzBvSjVrRUMvQStGSzlrcHJ6M0pWRWUranQwWDd3NjY2TEZSOUM1QS9L?=
 =?utf-8?B?Z1VXbnpHM0lQa2dMd2VmRmR4NW5sWWg0T2JtR2tBR0tnMjhBTDNPWitVcnA3?=
 =?utf-8?B?aEwxRk4vdFVqNSs1Ym91cm9ISWhpeGFBa0sxVmU3OWlsYTBsL3F5Uk5wR21L?=
 =?utf-8?B?ZzEvUTl5dzY0OXprNzl1UENhbEhVci9uL1A4dXk4RENVaGpScFdOaDBBV1lP?=
 =?utf-8?B?SmhsT2g5NjVnYnpHNlpwNGdrRzJEYUMzdk1VNytuSFRMeGZBcmRSUkMyR3dz?=
 =?utf-8?B?ZUlDSURPbW1MZnRvVXEwRDA3eDQ0L05lcWJrbkxYWXZvSmhVeW44L2lNL0FW?=
 =?utf-8?B?V2ZEWENKdERPYlRwbktaQklKZHJZNkI2cDdWczhzVUEvL0U1dS8yMjhIOGRU?=
 =?utf-8?B?YWNuVCtFdDJWTFNyNXNUU1hQVDVjSC9UbnpORFdTM25hZE9NbWpvTWlldzJC?=
 =?utf-8?B?WU1DaHJaQ0tBTGZRZlQ5bm1YS24ralB0cUh6TzRsNHdqbkNSYW16ZU9GTFFj?=
 =?utf-8?B?NU9nZzM2aHNPZEh2UFlpNnJlbU5qSFIvVHFHUTRRb2ZMQTBBR0FmbG1MdEVo?=
 =?utf-8?B?SFFDUndSN0dHSDFPNk55ZENlRGE3M3NIcHBkTUo3M1huUEpPNkdNcEllSjVj?=
 =?utf-8?B?QS9xTEZyRysyQ2ZkY3B0eGF6SjljSXN3Y04xd090bkhBUTBIQ0J1SytudThx?=
 =?utf-8?B?cEZZWVBFTTRFOXVMc3BJMHhQUStyY3hTTDhWV3lRVldzc0pLR3paZEpKY3hI?=
 =?utf-8?B?SjltQXJjdGtHckFPeis1a2M3MDR3QytOMkgzV1MwVGpBbk1rVDJXaGJiZm13?=
 =?utf-8?B?NlZjUHpMYk1QZnlJN2pBWk5XTEJXOU5xMDc4aUpDdzBiN21iSUd1Wk92UFlU?=
 =?utf-8?B?YktRV0VaMmViYkg0eldPTGxsYi9Xd2F4N245OTlVTmRkS1dHTTZIQ28vTlFM?=
 =?utf-8?B?YkR2TTJlN3NvWUhLY0xoK2ZCc2ZkTzNldW9sMTdaQUFmY1Evck1LemVjeXZR?=
 =?utf-8?B?MW01bkZEV3VqZ2tDUFd3a05tSVZ0N3pKbmxPdlBCT0FQNGhneVBIdTB4d1li?=
 =?utf-8?B?VXViRXVTY0NCQkJOWDA0WnExU0NLcG9mdHZQS0NLazROaDNYK0QrVG9PSDVK?=
 =?utf-8?B?eUViSTRHRVJvV1NzaklpTi95Ulc1dnE1ZVpYNi9hcEJtdC9FMzlkWWM5d29h?=
 =?utf-8?B?Ulpwcldueml6UHcxZElmSjFyNm1GcjhyeVlPVENhRGgyZnZZbUltYTUvSnNR?=
 =?utf-8?B?T3o4RElyRlJjVmh5SGpOb2dWNVM5NzFaMGYraFNUZEV0YjhBOHA4c01FQXB0?=
 =?utf-8?B?cmVJdVMvdXR3Y3RiWGNHWWJ1VlhHcG55UmhuclJuaitxVExGd2hTdzdwUFpp?=
 =?utf-8?Q?lANNHYu6YafR7li4dgRyFZ+it?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9177935-57a8-4c45-3abb-08de02901ec3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 15:18:34.9768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de91a8MtbxHTFgGMhScacCf++wjS9HfOo9Ante9EBMNm7wWFSXPHby+jAdDcVoyf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651

On 1 Oct 2025, at 0:38, jinji zhong wrote:

>> On 30 Sep 2025, at 9:55, Vlastimil Babka wrote:
>
>>> On 9/25/25 10:50, zhongjinji wrote:
>>>> It is unnecessary to set page->private in __del_page_from_free_list().
>>>>
>>>> If the page is about to be allocated, page->private will be cleared by
>>>> post_alloc_hook() before the page is handed out. If the page is expand=
ed
>>>> or merged, page->private will be reset by set_buddy_order, and no one
>>>> will retrieve the page's buddy_order without the PageBuddy flag being =
set.
>>>> If the page is isolated, it will also reset page->private when it
>>>> succeeds.
>>>
>>> Seems correct.
>
>> This means high order free pages will have head[2N].private set to a non=
-zero
>> value, where head[N*2].private is 1, head[N*(2^2)].private is 2, ...
>> head[N*(2^M)].private is M and head[0].private is the actual free page o=
rder.
>> If such a high order free page is used as high order folio, it should be=
 fine.
>> But if user allocates a non-compound high order page and uses split_page=
()
>> to get a list of order-0 pages from this high order page, some pages wil=
l
>> have non zero private. I wonder if these users are prepared for that.
>
> Having non-empty page->private in tail pages of non-compound high-order
> pages is not an issue, as pages from the pcp lists never guarantee their
> initial state. If ensuring empty page->private for tail pages is required=
,

Sure. But is it because all page allocation users return used pages with
->private set back to 0? And can all page allocation users handle non-zero
->private? Otherwise, it can cause subtle bugs.

> we should handle this in prep_new_page(), similar to the approach taken i=
n
> prep_compound_page().
>
>> For example, kernel/events/ring_buffer.c does it. In its comment, it say=
s
>> =E2=80=9Cset its first page's private to this order; !PagePrivate(page) =
means it's
>> just a normal page.=E2=80=9D
>> (see https://elixir.bootlin.com/linux/v6.17/source/kernel/events/ring_bu=
ffer.c#L634)
>
> PagePrivate is a flag in page->flags that indicates page->private is
> already in use. While PageBuddy serves a similar purpose, it additionally
> signifies that the page is part of the buddy system.

OK. You mean ->private will never be used if PagePrivate is not set
in ring buffer code?

If you are confident about it is OK to make some pages=E2=80=99 ->private n=
ot being
zero at allocation, I am not going to block the patch.

>
>> I wonder if non zero page->private would cause any issue there.
>
>> Maybe split_page() should set all page->private to 0.
>
>> Let me know if I get anything wrong.
>
>>>
>>>> Since __del_page_from_free_list() is a hot path in the kernel, it woul=
d be
>>>> better to remove the unnecessary set_page_private().
>>>>
>>>> Signed-off-by: zhongjinji <zhongjinji@honor.com>
>>>
>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>>
>>>> ---
>>>>  mm/page_alloc.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index d1d037f97c5f..1999eb7e7c14 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -868,7 +868,6 @@ static inline void __del_page_from_free_list(struc=
t page *page, struct zone *zon
>>>>
>>>>  	list_del(&page->buddy_list);
>>>>  	__ClearPageBuddy(page);
>>>> -	set_page_private(page, 0);
>>>>  	zone->free_area[order].nr_free--;
>>>>
>>>>  	if (order >=3D pageblock_order && !is_migrate_isolate(migratetype))
>
>
>> Best Regards,
>> Yan, Zi


Best Regards,
Yan, Zi

