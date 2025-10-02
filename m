Return-Path: <linux-kernel+bounces-840201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D21FBBB3D12
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E4E1923D48
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B3230CB42;
	Thu,  2 Oct 2025 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Kr4lOiZe";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Kr4lOiZe"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B53081D0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.43
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405817; cv=fail; b=NKAmug1l/2pLeHAE7tUgPrYw7WFpQAfX1RHFyhyee32+q4bgPWAyXRfqaeOP36C9Tcgrmd9dmch3CqoLIhhmv03mymBcV842vpbZ8B1JU3HCA5RNQ5NYQ2eGmWWoRJCX2LwaeveUInmEqyWEuRF88Q01LWzq1b7+8DAzHeh6FCY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405817; c=relaxed/simple;
	bh=3S019Xom/0SSpKQN+d8D2JXytOJ0w6HmVamafojBJfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AoHsgD++rBQPkfclbNHjfP4mhymnCE5+IRugtPju8BMellzfEUOMSOTzEV1JbLKHjus5WpgvC4rQUtsPQwSbYFfVOmBjLiha/3toR4kXe4P8Hpnh23iimXmJMF7TE0QFrR/+9W5tGx3MtUXH0V+E9ngMUs4XL+InhTOx52tSlZw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Kr4lOiZe; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Kr4lOiZe; arc=fail smtp.client-ip=52.101.83.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dIq+8ByFoB6ICBlWdctajNOoHQtRWpGhGaOfg1Nebds8S4YFtzFJx+NGY6Xgg4bEMcRA75mIbwGaix25/D0PK+FRpHNbkXId0LMP0O3i/dWOhTemcMQs9iP23/ZDPuq8oLRJuOkYQisuV21kETwbJcywVGuzIdBmMKMTuU2CZJH38XgmUUgDiUJC6o23gC4EUcJTDimpdSiYq3+0oOJXdNIUYTiMlZSSRoT0YmA/DrTrV61nxlJ8tHDUR7KHj983Zf/qjB2GobRapCzn/ZDxLMLteQ82c1K4/ie0+5dq/Pg61SOqArRzp7TxpguYegnSEtw7Z6OIZVdrxAsuylDKIg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MbuJl8U0TFf5qF6r3dFzdQrjzPM4zhpR2DeqnoXDpo=;
 b=hC5GUQZ5Zlbs++zHAEoiVsVCOHvjzPfSjZr1GzC5wX8ChOwjI4OPiIragN9wOd0zBnZmCl6wYChcicRYPkZc+p8tLpdhq0gmGr33Shd/mOnBdILjw+z25n3m5KgXRJDO7przTYKmEI44KTh30lQ/VgKSAfEfTcEdApfhfMGtNom45b/MleaqVWhAuOpQpov90VucMEfLDbh0CDal1KfSO9bUXz67BlkwbPlpK2HuzOd1tv7CZstlHxfkBe0t5OVo+U3rURMIVbyH1GbHUY75R6tAhdWwCSJxnzlpyjgZozBMSSnI/T0/umsd/mrfAN/RwC6CTUjtaA+1pZcHMAQ3gw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=sk.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MbuJl8U0TFf5qF6r3dFzdQrjzPM4zhpR2DeqnoXDpo=;
 b=Kr4lOiZe7+7po83ntNsCYTmvC5LYlPew78zCu2mykck17iX4fA36mOJVaSEpJ+VgN4sVub9RAqHUn9eBUwqmlLyT7fgdrb7w5fzv3lC+4LEePJpEt43u1JiFP5vHTpm36sJ40S9WOM+AOY7E+1ALywY/QS1AtuokZ4lZg9ifexI=
Received: from CWLP123CA0093.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::33)
 by DU0PR08MB10328.eurprd08.prod.outlook.com (2603:10a6:10:476::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 11:50:05 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:401:5b:cafe::cc) by CWLP123CA0093.outlook.office365.com
 (2603:10a6:401:5b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 11:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15
 via Frontend Transport; Thu, 2 Oct 2025 11:50:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2M8iVtNQ4a8AepYfCkWahn8d6qOeGGXxlJsiH51eYcb/ISXLHxSxj7z3eWxuMBuLPfJF9E0HvwxiZE8VAlPGiGjgWObEjG5Aqlsuh01nvJTvOBQhSl4pdvIJdrVhVwcYWUNLSrAYzK6UKU6JA8407G9oxU/XJfNWFGR4JudG82nTJG8so8ZCu9jeXdOPSSlM9iK3EHgk5O47YkFssJGI4lWxHRJwOYX5vGVDvchaKVx2mNum+Dc2X4eXi4LonaiicAkGi2PfWWVHSYsaBe4Jd+vgONsv/P1+a4bdzTrkl9abhAR7RckN5LiVPsdB5i4C5EsUD0axiWEC4AcXFSysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MbuJl8U0TFf5qF6r3dFzdQrjzPM4zhpR2DeqnoXDpo=;
 b=W2n1AV/Tzyv6uJMk3FHWgd6dUcJwxuDyDDSK/Erwsq8ip8RTftw0zrMq09jIMz7Bt4GaXtfALCfTjrEw0bFIVTNtU9Ws49OgsdUno1BAdWBgW5rwu1TOVaYUjI2wU6+edK4YEPfBOsWKs7y4kBBvgmxriR2BdMUpk32MF/G825KXBAa/ZgDhO3c7AqTsRvGCZt7ifms5tGxeLslAHEXcSGmthQgIx6J1Jocd7FVfFFBv867tncw02VKshMXgxmEZn/O1DDDBOHuswg8b0Uh6Eu0lGxAbuJxWzmkxkQDqipqE0WK1G9HR1I5sF7uzmQSEP7JWWURW2KRVIMPbG1vufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MbuJl8U0TFf5qF6r3dFzdQrjzPM4zhpR2DeqnoXDpo=;
 b=Kr4lOiZe7+7po83ntNsCYTmvC5LYlPew78zCu2mykck17iX4fA36mOJVaSEpJ+VgN4sVub9RAqHUn9eBUwqmlLyT7fgdrb7w5fzv3lC+4LEePJpEt43u1JiFP5vHTpm36sJ40S9WOM+AOY7E+1ALywY/QS1AtuokZ4lZg9ifexI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by VI1PR08MB10005.eurprd08.prod.outlook.com
 (2603:10a6:800:1bf::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 11:49:26 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 11:49:26 +0000
Date: Thu, 2 Oct 2025 12:49:23 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Byungchul Park <byungchul@sk.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	clameter@sgi.com, kravetz@us.ibm.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com,
	kernel_team@skhynix.com, harry.yoo@oracle.com,
	gwan-gyeong.mun@intel.com, syzkaller@googlegroups.com,
	ysk@kzalloc.com
Subject: Re: [RFC] mm/migrate: make sure folio_unlock() before
 folio_wait_writeback()
Message-ID: <aN5mwwFE2aEJwlT1@e129823.arm.com>
References: <20251002081612.53281-1-byungchul@sk.com>
 <aN5lOFVFfewXUijF@e129823.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN5lOFVFfewXUijF@e129823.arm.com>
X-ClientProxiedBy: LO4P123CA0051.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::20) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|VI1PR08MB10005:EE_|AM1PEPF000252DA:EE_|DU0PR08MB10328:EE_
X-MS-Office365-Filtering-Correlation-Id: 45355ef3-1921-4c83-96bf-08de01a9d359
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WC9OOCtxU283Y3B4Vm9jV2E5YWtBWXNDb0tySUR1cHZvUTZhaEJmRVFLSzJo?=
 =?utf-8?B?aENuVlZjbk1YTWcvenkvbmUzM3ZwK1h1N2V4QllpdTFWL1NlcHp0RFBPdUVE?=
 =?utf-8?B?QU5hWVIxQVV0bWlJTWtPb2FxT0Z1S3dMSUNHbU9PaVRyZXROa1ptN0ZjcnNi?=
 =?utf-8?B?RFh1WG5Sd2hrblJwTitzSjBTZEVEbnRrejBFaUdBWTJtRlVQQko4WVNGcjBL?=
 =?utf-8?B?ODcvZUEyMVZNOWRQbkNpMkxvYk9YbzZLYnZBZ0RmRHZRYm5HY1NtV082Zk15?=
 =?utf-8?B?K04ybnA3ZGpWbXNscGFFKy9NOUZZaGJWT2dpTitXaEQ4UXp0bzRYVXhsZlc5?=
 =?utf-8?B?OExCVkxWYUpHWWh0VmpZQm5mclpwc1NidXZuVy81UmkxLytSR3Q1WTRmeU41?=
 =?utf-8?B?eXdPTDJCdm93cnNNSFNTdVNXQ1JWYXphNm9pYzVBNEJlcy9QV1RTQXNLZzVx?=
 =?utf-8?B?Z2RCOEMrVGV5SGJCY0licFM3TUw1Z3VlWmd6MHlPbllJc1VrQkFrZ3pxdWt3?=
 =?utf-8?B?d0NjOGFPanJ3MmtSdkJDd3VBYjR0SWFmSjg3blE3MC9jYUVGbEFYazV5dWRK?=
 =?utf-8?B?RkpqTmxhRGlZUG16QWNSdE8xZCsxb01mbndOSldjVnlNWEdyRDBJSWRJRDda?=
 =?utf-8?B?VTJQY0NONlRLR3JBQU53Y1FLbnZYajk0MEY4UDJHVmlZR3hBNWQvNTdCNDNi?=
 =?utf-8?B?MDB6UDNCVHQ2TUhuU3l4cTJCWjR0a2k4OHFQREt1bmlocWZiWWxBUVBzUFhx?=
 =?utf-8?B?ZXl2cUVnUGl2TFVMZm1md3lCNDRsaDNLOHVXZzRtWUpseVd2VGVlcEdBZU9r?=
 =?utf-8?B?WFRKT3JJcmVoR2JSYlNHMWtUN0F0T25waUNFTTlrR21Cek9hWTY0ZHR1SlVm?=
 =?utf-8?B?K0JlZG9xZnI4OUVQYWJLVWRJcUY1Z0VGaHVSdnhpdjVmSHliNExOSyszeTVJ?=
 =?utf-8?B?L0R0dE1wUEVNNVhVMGhxNUpFRmpJdmhMR3FuZC9Rc0VaQ3B1THozeGY4STAr?=
 =?utf-8?B?TUJHbUQ2MWw0dW9UdUM2SCtVQi9SR1dZakF5YVRsQ210TW9ySjFKWGNlTTlZ?=
 =?utf-8?B?SG9zSFZhWk1xWkpoSDA4YUgxMFVnYXQvODUvQlRIcnNDeEJxYllJeFlocGk1?=
 =?utf-8?B?cVZPK3k1a29OKzlTNC9RK3g2cE1HUFluakxwQTlvZEdPdTRFWGpjOU44cTJK?=
 =?utf-8?B?ZmNNN0RZMkZmU2V2TmdvWnZ3aTA1dHFwNjhIbWZJL0V5MEwrQWNaVm1XYmhZ?=
 =?utf-8?B?aVJEYm9UUFpyYVlYNks1U3E4clUvaGV1Q01KWTJscG16dmJrU1VjbG1uSXpr?=
 =?utf-8?B?K1dpRkVWMFh5aS9UK3hPUUZGd3BjVkFieDJvVFhKODk5S0RZVDdZLzFlTS8v?=
 =?utf-8?B?N3VLQkk4Q2NJdWcxWkQrU3pxYnZMTWVLL2Z4Y2NiYzJ1MmlIak1uV3pRcmlv?=
 =?utf-8?B?dStxRk12YVJYcnRkdW5JN2VlRTJzNU9GUVB1SFYyRFEwd2Z2ckxrcG93V2xo?=
 =?utf-8?B?TUhyc2tKYk9SYytTVUIvc2JSSGE3aHpWL2VFV2pacnQ5dmRwSGtwWDdqaDBu?=
 =?utf-8?B?K1lQSks2anhHTkpJZzN4MmxQZ05xeFpKQ3FZV3htcWNmcWlHNDRGR2RUemFP?=
 =?utf-8?B?UkVSOFpRVTZvNkcrVitYUklXeTdnRHMxVmtYb2wvaE4vQmNIZzRhNW1JZm9n?=
 =?utf-8?B?bUx3SUJndXFIV1lCeXJrbnd4MzBWNUNnb3F4S0tld0d4R1doOElwcWdZaURi?=
 =?utf-8?B?L2dBUmVDa2Z4Z2tkWmFkWWdQSkZkbnk0T2g2RlUxRm9CcEFlcU5hdTJUL0Ft?=
 =?utf-8?B?aXRWT2JnMFdhSWl5WVVFc1pzR283M3FkQjRtK1pQQjlLQXRBdk42K081cEtY?=
 =?utf-8?B?eDVwL0xPTmhqWVc2VXovWmtXZjZtYTlnOHo1RnlRTjZxSzJReXIwZFVJWCtP?=
 =?utf-8?Q?Qgr/xsrK4XA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10005
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ec013b92-ca66-46d9-648b-08de01a9bcef
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|35042699022|376014|82310400026|7416014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFNpRnBSencxNDl1V0RxVk5BV0Zoc1BhdG0xL3hkSE95eGZYckFHNFZ5ZGdl?=
 =?utf-8?B?SWpPdzk4N3pibmdmK04xeUh5MXcrSWtKcmc1WXJFVGRJeXFBa2FUTUpyMkFY?=
 =?utf-8?B?Wk1hR216YU1YVmZjL3YzNkEwY0FrOVBLRHpCN1p5ODNyZWx4d24yM211bGZP?=
 =?utf-8?B?OTFQcFh3VDMvNlZaa3hxYmxYMmpPdWM3SU84aVNnaEQvQzdQTkMzVDBRWHBX?=
 =?utf-8?B?amR2OE1tMGljOGk0QTl5ZGpJL2c2V0pUQkJvTGNLdEU3QTZ4V0FvSlh0cW1O?=
 =?utf-8?B?L1VXL3RGakNKaFBrbkRWRE9DVUZQWVpid084UTFjMi9lNVRnZk5mS3haY1I3?=
 =?utf-8?B?amRlN0FjVTdoVGFjTSsvRlQzM1dyT1dDaG5qZlZqczBuWlFEb2VkRlllM2Jx?=
 =?utf-8?B?NU41SmpUZW9vODMxa2g0NFdyNWtwU2pVMVkyeGgyY1VBTmZNZWNKS0RhM0tW?=
 =?utf-8?B?VXFXR2VrS1FXNy9Cdk9KTFVKQlVYek1TUFVDbTNTZjdrMUNzOFNSSUhZT1ZP?=
 =?utf-8?B?RmNWSDdoRWU4Y3p1WHhpOUJGeldyVzFENzR4UTM2cUhqNDJUU1RjMDFudUlS?=
 =?utf-8?B?SGpvajh2L0pPR3RDcGowbUV3eDBvK2c2MTNQV1V4TzUvTEhQUW5mOXpYKy81?=
 =?utf-8?B?c041MHVLKzkxelpMMmtEVlhWUVFPSCtldUorNzAwdVZ1SzE4aURaVW91RlhJ?=
 =?utf-8?B?QnJNeDk5SWtiMnhnYTFQaEpIME1lMTd6cHd5eXFxTnZVU3RCQVJ3YkhMbWdl?=
 =?utf-8?B?WWJxeG9mRXU0b0hVeFJUcFFlTVhnS2tHTlFNekRBRjd6NThHa3Q2QUxMVytL?=
 =?utf-8?B?UURNVlZac3BHeGlmbGxwVkRwVDhiWlZqajVldHA5bHM2aEZBWGRVL1B5d2M5?=
 =?utf-8?B?REUybGl2VXMrRUpxOHNVaTBHTWVJV21wUXk2aElnK0s4UEsyaUNPRWNJZm5u?=
 =?utf-8?B?OFBhSW9uN1poL0hOSEJKZGx2dUxDU1dNbkVOMk9ZVWwrZzBwM1Q3NVRUODV2?=
 =?utf-8?B?WkhQM0VNU01JODh6dnRQRW9PU1YwTEFVM01WY0l3bjNKbW53cmFQMUljaTNt?=
 =?utf-8?B?eU1HMDlzbklGTUpYeSs3K2RMTXEyc1g3QWcyekVDQmoybnd6bEt4NmNCSVYy?=
 =?utf-8?B?dTNjaVVEZ21CVmo2WkFJMURzNEN6Y0hSbmRpZFpyNnJBb2UrV2ZwdzIrMnRL?=
 =?utf-8?B?ZVhRZDg2akdZcENQbTVJSmpCWDVUWlhjWW14Rmx3RS82d2E2QTBWZnlDV1ky?=
 =?utf-8?B?VUJ2YlcwakpmM3pOd2dia2pNL2M1NlBsUngyT1FYbGtiWGlzZmJmL0w1RHRL?=
 =?utf-8?B?U0ZvN1hwZmpQRDBGKzMvVWcxamlvaVNlZzNJZWxPeE5qeDh4TFZFdzBPZ2Fp?=
 =?utf-8?B?WUQyd2FYVVFxdUNzd2t6RUx4USs1bWdGd1VSd2ZrTDA2VDZlYzdUSm1Td3BM?=
 =?utf-8?B?ZVZrU1BOUXZxdHgvRkhEbmdrOTRUOUVJakFsa0w0UkNrREI3WkxCZTJLNjBj?=
 =?utf-8?B?TXViWHYza0tMOUJuQkhLQzc1TE5LNmFzN3ozTHRraE9YRVdPd1I2cDZoQUVu?=
 =?utf-8?B?UFVvSTk0d1Q4Y2gyNi9JYVZ4Vm5mTlNEQ3VVRElvN2RtdG0xdGlUU3lhY2tC?=
 =?utf-8?B?b3BNWmVRbXhieFJ4Wi9IcWIrVERoM2tzd2w0VFZLeXBWS2JEY0JOYlNBaHhw?=
 =?utf-8?B?UUJTR0d3dUxCcWhQVENKQWVYY2wrUDA5eVFmTWVlT1F6UWhuN2wycHFTUldt?=
 =?utf-8?B?N0pQeXlaVkkzTDdURzNVeDNtS3hQcG1lUTdjaDlXVWRVYWVCa1BxVHlmYkR4?=
 =?utf-8?B?aXR0TWdZUW95OHRtbjlqRFBpRTA5RmtLOTFDNWcvWm9HbUE1MG9zN1JoRlZJ?=
 =?utf-8?B?eHI1NVQ5b1YyMVZ1MlFwcHBmS3JJaTUvU3U2Zy9mTFJBRk1uSllBSVpyR3Fl?=
 =?utf-8?B?ZmFjNWJDUU1jWkFUYnI2NnFtY2xEWGx4M2NZcVg3QVgwNE9oZ0p5NmRRQkwz?=
 =?utf-8?B?dGJWRHVYVHNHTUZRakpCTEc1SE5mNUFaNC81c2lCc3QySmdPeUxicVhjSnFy?=
 =?utf-8?Q?TUROk+?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(35042699022)(376014)(82310400026)(7416014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 11:50:03.9204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45355ef3-1921-4c83-96bf-08de01a9d359
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10328

Sorry code was wrong.
> Hi Byoungchul,
>
> > DEPT(Dependency Tracker) reported a deadlock:
> >
> >    ===================================================
> >    DEPT: Circular dependency has been detected.
> >    6.15.11-00046-g2c223fa7bd9a-dirty #13 Not tainted
> >    ---------------------------------------------------
> >    summary
> >    ---------------------------------------------------
> >    *** DEADLOCK ***
> >
> >    context A
> >       [S] (unknown)(pg_locked_map:0)
> >       [W] dept_page_wait_on_bit(pg_writeback_map:0)
> >       [E] dept_page_clear_bit(pg_locked_map:0)
> >
> >    context B
> >       [S] (unknown)(pg_writeback_map:0)
> >       [W] dept_page_wait_on_bit(pg_locked_map:0)
> >       [E] dept_page_clear_bit(pg_writeback_map:0)
> >
> >    [S]: start of the event context
> >    [W]: the wait blocked
> >    [E]: the event not reachable
> >    ---------------------------------------------------
> >    context A's detail
> >    ---------------------------------------------------
> >    context A
> >       [S] (unknown)(pg_locked_map:0)
> >       [W] dept_page_wait_on_bit(pg_writeback_map:0)
> >       [E] dept_page_clear_bit(pg_locked_map:0)
> >
> >    [S] (unknown)(pg_locked_map:0):
> >    (N/A)
> >
> >    [W] dept_page_wait_on_bit(pg_writeback_map:0):
> >    [<ffff800080589c94>] folio_wait_bit+0x2c/0x38
> >    stacktrace:
> >          folio_wait_bit_common+0x824/0x8b8
> >          folio_wait_bit+0x2c/0x38
> >          folio_wait_writeback+0x5c/0xa4
> >          migrate_pages_batch+0x5e4/0x1788
> >          migrate_pages+0x15c4/0x1840
> >          compact_zone+0x9c8/0x1d20
> >          compact_node+0xd4/0x27c
> >          sysctl_compaction_handler+0x104/0x194
> >          proc_sys_call_handler+0x25c/0x3f8
> >          proc_sys_write+0x20/0x2c
> >          do_iter_readv_writev+0x350/0x448
> >          vfs_writev+0x1ac/0x44c
> >          do_pwritev+0x100/0x15c
> >          __arm64_sys_pwritev2+0x6c/0xcc
> >          invoke_syscall.constprop.0+0x64/0x18c
> >          el0_svc_common.constprop.0+0x80/0x198
> >
> >    [E] dept_page_clear_bit(pg_locked_map:0):
> >    [<ffff800080700914>] migrate_folio_undo_src+0x1b4/0x200
> >    stacktrace:
> >          migrate_folio_undo_src+0x1b4/0x200
> >          migrate_pages_batch+0x1578/0x1788
> >          migrate_pages+0x15c4/0x1840
> >          compact_zone+0x9c8/0x1d20
> >          compact_node+0xd4/0x27c
> >          sysctl_compaction_handler+0x104/0x194
> >          proc_sys_call_handler+0x25c/0x3f8
> >          proc_sys_write+0x20/0x2c
> >          do_iter_readv_writev+0x350/0x448
> >          vfs_writev+0x1ac/0x44c
> >          do_pwritev+0x100/0x15c
> >          __arm64_sys_pwritev2+0x6c/0xcc
> >          invoke_syscall.constprop.0+0x64/0x18c
> >          el0_svc_common.constprop.0+0x80/0x198
> >          do_el0_svc+0x28/0x3c
> >          el0_svc+0x50/0x220
> >    ---------------------------------------------------
> >    context B's detail
> >    ---------------------------------------------------
> >    context B
> >       [S] (unknown)(pg_writeback_map:0)
> >       [W] dept_page_wait_on_bit(pg_locked_map:0)
> >       [E] dept_page_clear_bit(pg_writeback_map:0)
> >
> >    [S] (unknown)(pg_writeback_map:0):
> >    (N/A)
> >
> >    [W] dept_page_wait_on_bit(pg_locked_map:0):
> >    [<ffff80008081e478>] bdev_getblk+0x58/0x120
> >    stacktrace:
> >          find_get_block_common+0x224/0xbc4
> >          bdev_getblk+0x58/0x120
> >          __ext4_get_inode_loc+0x194/0x98c
> >          ext4_get_inode_loc+0x4c/0xcc
> >          ext4_reserve_inode_write+0x74/0x158
> >          __ext4_mark_inode_dirty+0xd4/0x4e0
> >          __ext4_ext_dirty+0x118/0x164
> >          ext4_ext_map_blocks+0x1578/0x2ca8
> >          ext4_map_blocks+0x2a4/0xa60
> >          ext4_convert_unwritten_extents+0x1b0/0x3c0
> >          ext4_convert_unwritten_io_end_vec+0x90/0x1a0
> >          ext4_end_io_end+0x58/0x194
> >          ext4_end_io_rsv_work+0xc4/0x150
> >          process_one_work+0x3b4/0xac0
> >          worker_thread+0x2b0/0x53c
> >          kthread+0x1a0/0x33c
> >
> >    [E] dept_page_clear_bit(pg_writeback_map:0):
> >    [<ffff8000809dfc5c>] ext4_finish_bio+0x638/0x820
> >    stacktrace:
> >          folio_end_writeback+0x140/0x488
> >          ext4_finish_bio+0x638/0x820
> >          ext4_release_io_end+0x74/0x188
> >          ext4_end_io_end+0xa0/0x194
> >          ext4_end_io_rsv_work+0xc4/0x150
> >          process_one_work+0x3b4/0xac0
> >          worker_thread+0x2b0/0x53c
> >          kthread+0x1a0/0x33c
> >          ret_from_fork+0x10/0x20
> >
> > To simplify the scenario:
> >
> >    context X (wq worker)	context Y (process context)
> >
> > 				migrate_pages_batch()
> >    ext4_end_io_end()		  ...
> >      ...			  migrate_folio_unmap()
> >      ext4_get_inode_loc()	    ...
> >        ...			    folio_lock() // hold the folio lock
> >        bdev_getblk()		    ...
> >          ...			    folio_wait_writeback() // wait forever
> >          __find_get_block_slow()
> >            ...			    ...
> >            folio_lock() // wait forever
> >            folio_unlock()	  migrate_folio_undo_src()
> > 				    ...
> >      ...			    folio_unlock() // never reachable
> >      ext4_finish_bio()
> > 	...
> > 	folio_end_writeback() // never reachable
> >
> > context X is waiting for the folio lock to be released by context Y,
> > while context Y is waiting for the writeback to end in context X.
> > Ultimately, two contexts are waiting for the event that will never
> > happen, say, deadlock.
> >
> > *Only one* of the following two conditions should be allowed, or we
> > cannot avoid this kind of deadlock:
> >
> >    1. while holding a folio lock (and heading for folio_unlock()),
> >       waiting for a writeback to end,
> >    2. while heading for the writeback end, waiting for the folio lock to
> >       be released,
> >
> > Since allowing 2 and avoiding 1 sound more sensible than the other,
> > remove the first condition by making sure folio_unlock() before
> > folio_wait_writeback() in migrate_folio_unmap().
> >
> > Fixes: 49d2e9cc45443 ("[PATCH] Swap Migration V5: migrate_pages() function")
> > Reported-by: Yunseong Kim <ysk@kzalloc.com>
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > Tested-by: Yunseong Kim <ysk@kzalloc.com>
> > ---
> >
> > Hi,
> >
> > Thanks to Yunseong for reporting the issue, testing, and confirming if
> > this patch can resolve the issue.  We used the latest version of DEPT
> > to detect the issue:
> >
> >    https://lore.kernel.org/all/20251002081247.51255-1-byungchul@sk.com/
> >
> > I mentioned in the commit message above like:
> >
> >    *Only one* of the following two conditions should be allowed, or we
> >    cannot avoid this kind of deadlock:
> >
> >       1. while holding a folio lock (and heading for folio_unlock()),
> >          waiting for a writeback to end,
> >       2. while heading for the writeback end, waiting for the folio lock
> >          to be released,
> >
> > Honestly, I'm not convinced which one we should choose between two, I
> > chose 'allowing 2 and avoiding 1' to resolve this issue though.
> >
> > However, please let me know if I was wrong and we should go for
> > 'allowing 1 and avoiding 2'.  If so, I should try a different approach,
> > for example, to fix by preventing folio_lock() or using folio_try_lock()
> > while heading for writeback end in ext4_end_io_end() or something.
> >
> > To Yunseong,
> >
> > The link you shared for a system hang is:
> >
> >    https://gist.github.com/kzall0c/a6091bb2fd536865ca9aabfd017a1fc5
> >
> > I think an important stacktrace for this issue, this is, waiting for
> > PG_writeback, was missed in the log.
> >
> > 	Byungchul
> >
> > ---
> >  mm/migrate.c | 57 +++++++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 41 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 9e5ef39ce73a..60b0b054f27a 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1215,6 +1215,17 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
> >
> >  	dst->private = NULL;
> >
> > +retry_wait_writeback:
> > +	/*
> > +	 * Only in the case of a full synchronous migration is it
> > +	 * necessary to wait for PageWriteback.  In the async case, the
> > +	 * retry loop is too short and in the sync-light case, the
> > +	 * overhead of stalling is too much.  Plus, do not write-back if
> > +	 * it's in the middle of direct compaction
> > +	 */
> > +	if (folio_test_writeback(src) && mode == MIGRATE_SYNC)
> > +		folio_wait_writeback(src);
> > +
> >  	if (!folio_trylock(src)) {
> >  		if (mode == MIGRATE_ASYNC)
> >  			goto out;
> > @@ -1245,27 +1256,41 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
> >
> >  		folio_lock(src);
> >  	}
> > -	locked = true;
> > -	if (folio_test_mlocked(src))
> > -		old_page_state |= PAGE_WAS_MLOCKED;
> >
> >  	if (folio_test_writeback(src)) {
> > -		/*
> > -		 * Only in the case of a full synchronous migration is it
> > -		 * necessary to wait for PageWriteback. In the async case,
> > -		 * the retry loop is too short and in the sync-light case,
> > -		 * the overhead of stalling is too much
> > -		 */
> > -		switch (mode) {
> > -		case MIGRATE_SYNC:
> > -			break;
> > -		default:
> > -			rc = -EBUSY;
> > -			goto out;
> > +		if (mode == MIGRATE_SYNC) {
> > +			/*
> > +			 * folio_unlock() is required before trying
> > +			 * folio_wait_writeback().  Or it leads a
> > +			 * deadlock like:
> > +			 *
> > +			 *   context x		context y
> > +			 *   in XXX_io_end()	in migrate_folio_unmap()
> > +			 *
> > +			 *   ...		...
> > +			 *   bdev_getblk();	folio_lock();
> > +			 *
> > +			 *     // wait forever	// wait forever
> > +			 *     folio_lock();	folio_wait_writeback();
> > +			 *
> > +			 *     ...		...
> > +			 *     folio_unlock();
> > +			 *   ...		// never reachable
> > +			 *			folio_unlock();
> > +			 *   // never reachable
> > +			 *   folio_end_writeback();
> > +			 */
> > +			folio_unlock(src);
> > +			goto retry_wait_writeback;
> >  		}
> > -		folio_wait_writeback(src);
> > +		rc = -EBUSY;
> > +		goto out;
> >  	}
> >
> > +	locked = true;
> > +	if (folio_test_mlocked(src))
> > +		old_page_state |= PAGE_WAS_MLOCKED;
> > +
> >  	/*
> >  	 * By try_to_migrate(), src->mapcount goes down to 0 here. In this case,
> >  	 * we cannot notice that anon_vma is freed while we migrate a page.
>
> Hmm, I still have concerns about this change.
> (1) seems to imply that the use of WB_SYNC_ALL by
> mpage_writebacks() is also incorrect. In addition,
> this change could introduce another theoretical livelock
> when the folio enters writeback frequently.
>
> AFAIK, while a folio is under writeback,
> its related buffers won’t be freed by migration, and
> since try_free_buffer() checks the writeback state first,
> taking folio_lock() shouldn’t be necessary while bdev_getblk().
>
> Therefore, it seems sufficient to check whether
> the folio is under writeback in __find_get_block_slow(), e.g.:
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 6a8752f7bbed..804d33df6b0f 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -194,6 +194,9 @@ __find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
>         if (IS_ERR(folio))
>                 goto out;
>
> +       if (folio_test_writeback(folio))
> +               return true;
> +
>         /*
>          * Folio lock protects the buffers. Callers that cannot block
>          * will fallback to serializing vs try_to_free_buffers() via
>
> Am I missing something?

Sorry, the code was wrong. the suggestion is:

diff --git a/fs/buffer.c b/fs/buffer.c
index 6a8752f7bbed..804d33df6b0f 100644
 --- a/fs/buffer.c
 +++ b/fs/buffer.c
 @@ -194,6 +194,9 @@ __find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
         if (IS_ERR(folio))
                 goto out;

 +       if (folio_test_writeback(folio))
 +               atomic = true;
 +
         /*
          * Folio lock protects the buffers. Callers that cannot block
          * will fallback to serializing vs try_to_free_buffers() via

--
Sincerely,
Yeoreum Yun

