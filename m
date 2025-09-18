Return-Path: <linux-kernel+bounces-757651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D1EB1C4CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D525623626
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00F425B66A;
	Wed,  6 Aug 2025 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XSstKBWL";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XSstKBWL"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013029.outbound.protection.outlook.com [52.101.83.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191FD19AD70
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.29
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479463; cv=fail; b=Ff+PKD+5eGBngkmH3NNf91TtXu8njW+mCOzplH9x8nfFOtgj9AtL2XuRuYTtaqHrm34sAu7eR4SpQ5q5GGwHaCjPFS4fOOWNMpSHIGmEqHTl5pUlFPi1XQU0iMdriqREmLM8VyOcn0PhKa4uUGKXHwFvc4KZ4qvNsrEV/zh3T34=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479463; c=relaxed/simple;
	bh=hVUmdzR9fxntoC3vfhFUoZy/VN3+jzf9THcJ/RSjOYU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4nGc44T0SxA0KpybUhUF+CodQ4dXeUs9vPgE7e9iJDwimzwQX7omTOCghmw/Zzdl9k5M5zY8SRMumItcK3kbLs+9M6IsgpViEC1N4X2svoGd+aaQf6gGI3sKaE2INyGSHe3dK/CWBf4jdTfXbubGUOJBhJWDXX11zpgaPzym10=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XSstKBWL; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XSstKBWL; arc=fail smtp.client-ip=52.101.83.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=a+Gu94Y5AEGMKXJhPf2XmUBF6W7t7JCUP+Rsx1YPoa3++4P7wo3zxRE1Pcb9n3778ciHsfW/DGHRhXy5bjw+4/8XedrrnOkHlEZHkzekhgmi+Bpf4LS+JbBRWEw026kO0U/lzufwazDsLwAhvnyUI56DXfaClU1dCBZsxBNsDcpCJWBVaI4hYp+2qM8yC/132vowauJbxt41FH07GBNsU+qF8oCmnPO3zK3QEHzznr65lgSPHDzPOX9CucpLY8q6jWnta2zPWHuQlaaX8Z4GNmoyBfU2z1HViNM+zULDvvE7dr23K0vwhnijlvVOBeeRTYCcpd6kXoeglqfsc4wwjQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=degfFdWnQjhgnh/qj0z3KiQOZyb4HuuB8JkAzeITo3s=;
 b=suojWhGk04+W68/md37Mfl0Ux8QHf+NjMHWgmJeHcFmvRYSFX2C4yfpmi620FxvJJ0Dh4IIZZv/dBKx3ILtp8zE5FtLkHY9zkn9vSxBNxPiKEYpqG/HZ4sEaaFiRKEnWZZC16odg17n8YqGS08lfm4eg1AQrXZmOQRR+GsBQwOmtoDpxteM8TWH+mwv5OdZa1Te6iy2Ze4NcHXXIH4QTFlwJ02NiGOEUHzn8dTuTZfTAt7ktpPx6C9gTVHXRIOK5Gax19nFS8wMhP32TQtmU7F6SDmOKPh1YClipJmMvKPOOBlBVGlBaPITiy3b3QAyFUTepm0wW+8RZMtDSfrZ/WQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=syzkaller.appspotmail.com
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=degfFdWnQjhgnh/qj0z3KiQOZyb4HuuB8JkAzeITo3s=;
 b=XSstKBWLcOQLa1s9u97awqGmrUYmDgztoeWXjFugi0A+Awosy+jjjwoBcPdt+R0/bTAIgjduNV5MbKEsb/5IRf5Xo+QRm/MgqzeRHcTgtdlp2M1P9ec0JysFN6PPyywff+TEZVMraGbFQBnFnV0ZhGzk8PCzjZ67ruURTrOhDN8=
Received: from AM4PR05CA0016.eurprd05.prod.outlook.com (2603:10a6:205::29) by
 AS8PR08MB8160.eurprd08.prod.outlook.com (2603:10a6:20b:561::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 11:24:17 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:205:0:cafe::15) by AM4PR05CA0016.outlook.office365.com
 (2603:10a6:205::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Wed,
 6 Aug 2025 11:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Wed, 6 Aug 2025 11:24:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnRiWN1n/A715qG6aZE5/a/I7HkXz1/zu3KSGLHzVAzYUQPcqt0WEGJNZEVxFbLXTYKkyWi7kOcsFXa6Hzh4VO3Ihj62kJbCFNpOCz+9Rzv+coqSCcVVxRKumGExTgk4ZvlVpUgliDKJCRQ/k+8yjRFxhWKioc7Pw7c4dsbYK4hszkaez6SLUFtA6w2NDXxQwVciwzRIFzhJ7CtLE8r0Sn0PTMDZQb/0553NeQle6LjWVqpIolZchEDUZNwi6bxJ1XHvrM8PCxThgBvW5eHmrsNU+q/gJ+qSa4bJWRerRefRD1o3vg9V/11D/pGSQQeDJIEnowirQIToBMUtTYY5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=degfFdWnQjhgnh/qj0z3KiQOZyb4HuuB8JkAzeITo3s=;
 b=UkEN1iLLNAyyKYeeWvTnmR9VdWkAV8DMGqz2Gkax3/0bPo+RC9F0Mt3hl8rsczn/I2kAL1V1AWXDk8iNGsDlhZxaRulLwREoSCfUQ18AGrmTj8bE95oAdPMPOb/1Z3AZlc1cbAKWUxrXhYB6DphaNdWmFT1leujITfhsjSA5TYO6dV9OYhfn0N1N1eqjbBoShwqfNHrAqHwnloztiPk7TfGuYcPdhmK/1WUG34lvRuoHb0VQjsK8F3XhHhWuw6JF6vePcjpBwjWDxPTSrf1SWAvx87dRrMlqUIj5Qq4YPsWeJ7Uw6wgQmpC0/rg8De/Qkr0IKPZDERJeBdUF73tPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=degfFdWnQjhgnh/qj0z3KiQOZyb4HuuB8JkAzeITo3s=;
 b=XSstKBWLcOQLa1s9u97awqGmrUYmDgztoeWXjFugi0A+Awosy+jjjwoBcPdt+R0/bTAIgjduNV5MbKEsb/5IRf5Xo+QRm/MgqzeRHcTgtdlp2M1P9ec0JysFN6PPyywff+TEZVMraGbFQBnFnV0ZhGzk8PCzjZ67ruURTrOhDN8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS1PR08MB7659.eurprd08.prod.outlook.com (2603:10a6:20b:47a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 11:23:43 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 11:23:43 +0000
Message-ID: <3a565e1a-6a40-4bd1-a6e0-7f64b745d00f@arm.com>
Date: Wed, 6 Aug 2025 16:53:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in follow_page_pte
To: syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org, david@redhat.com, jgg@ziepe.ca,
 jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 peterx@redhat.com, syzkaller-bugs@googlegroups.com
References: <68930511.050a0220.7f033.003a.GAE@google.com>
 <20250806111922.669-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250806111922.669-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::23) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS1PR08MB7659:EE_|AMS0EPF000001B5:EE_|AS8PR08MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: d46f1ad5-4fb2-409f-da9f-08ddd4dbc76b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZVRNTlY2TWJHRkR5RmJQaHRaUmVWcWIrdFNQWU9OOEtlbVRsZ3MzVm9SQXBl?=
 =?utf-8?B?NVlacDRoUVpSdldGcmJWN1hoS2l3VHEzTSs3dmFTTXltbjUxYXBGeXhFVllo?=
 =?utf-8?B?VjgzQmZyVXFCb3NTVWF5dEtSdW84R0VvZ1pnYlVHMEZ0YVp0eXBaalhEeFFh?=
 =?utf-8?B?ekgvang2VEZXeG14NEtSL3V0VUJaOHN0NnRiWDQ4bmZuUFFocjV6S2hsQ0Yr?=
 =?utf-8?B?Zk5FWUk4UVF2TUVYbnhUbGZkK2J6UVJFclMvV2tSclU3ZVJzWURYRUpETkZp?=
 =?utf-8?B?My9nV2M0OWxrZlZ5TU1RQ3hDeXp2Qkh2YWtJQWZKTGdwTXFocitqMEZXU2pZ?=
 =?utf-8?B?UFRobk5Hc2x4OHlYNlNjU1NENzJIdFRZaFRDb2N2QXA2cHhlYk5DY1ZKNkxG?=
 =?utf-8?B?cUVKMDlGVWVEK1RMaHBzR2t4RGU5RDAyMVAxVTlEZmJYYko5S3htbGtHLy91?=
 =?utf-8?B?Qm14SVQyRGE1eGRVakR6Y2UzM1dGek9IOWNvK0s2Zko4bGRnSk9UaGNudHBz?=
 =?utf-8?B?SDVYeEp4UkFudXlhblVTbExLVHNac2hvOUgzSDE1Mk1mY3RXdXErQnBvRWlW?=
 =?utf-8?B?MHkrL2hwQXROSVVVTlZZWFBkNUdlMlBnZ2tUdWZIWE5KakF6RlVJejRzVitm?=
 =?utf-8?B?bDh1YnN4cUl0QXcycWN3enZpMWRoSUJ1ZmZOckxHeVRZblE5ekt0eXhzRDFS?=
 =?utf-8?B?bEpYa2pvT1FFODFTMEpMZnNzbStCOHluUkRLVEMrcDM3aUFxZWV6WVpaZTVW?=
 =?utf-8?B?bWVNYzBtRXMxV1FkZjNpTituRVNOaER1N1pFbTQzbzFtVXNQZGtXRzhvMUJX?=
 =?utf-8?B?T3dmQXVzSjdGK2tvbDJCZk5sYjN0L2h0S2kzRE9VdklReGVlZ1lKVlUreCtv?=
 =?utf-8?B?VGhVYmo2R0ViSU51OWREbDhJN2dTbUUvSEtKbTFkQlF0akhCNGlkMU0xdjNw?=
 =?utf-8?B?UTgwcHFidktZamFLU3pSeHhBdGgyZXgyQ1pyVG1haWJjcS9uNkJJWHJ5UXZi?=
 =?utf-8?B?bWNNcktVN2RsdXR6OEw0VmROTXBkVU1VVXFjV1U1QjMzRStrdkRobjB2Wm9T?=
 =?utf-8?B?QVVjcC9naTRCdUEyRnMrU3RMNGo1bXZwOUZQbU9DbjFTajBEellEU2VEZDRj?=
 =?utf-8?B?Qm50b09MbnV0dm9UMUJuZUFIWkRmR2tXNmV1b21xUXc4UE1jZTdYcHdOM0Ix?=
 =?utf-8?B?NUZicXdUaUNvVk51R2lKbmo1VHVRZTNQTWN4YlRPWnpUTlZRSUtmSGZnNzRU?=
 =?utf-8?B?RFJYajhXL20rb0tUMVpTM1N6L2o4MlE0OWIvZWZBMzQ5WXc0SkRtRlUzdlFj?=
 =?utf-8?B?M3UyYmZzY1Bnb1dUYjJRK0NOSTA1bzVRYlJ0c0hrOGZHbDE1akxNS284dXNT?=
 =?utf-8?B?N3FNM3puVWRxV2ZVWHJJYjJVSFV6YmZxdnh0eVlRS0VjdldzNGlCWXc4dWVy?=
 =?utf-8?B?eFFWQUU5NXJXOXhzQTBsSXFMTnhkaG90bldIdXhvZERqLzIwRkRYVGg1TDgw?=
 =?utf-8?B?Y0hHSm9ISlpCN0x0RXlKSjV3WVpCbHEzWWhhREdmYnVWZ3EzNUNyUmtXZTR3?=
 =?utf-8?B?UDBmQlpySkdVZHpYckJtSG5tWUZTNlhXWFhodnR5RDdPREJaeXp4VEZTWXVp?=
 =?utf-8?B?WDRZWlJLd3hXZEc1ZnpCREpTNWRZeTNVSjhoZy9rV2JzS0JHNlRMQ251d0lZ?=
 =?utf-8?B?L2JMdHZyeEJhVkFoakhsRlhzdnhvb2l3bWdTSVJUR2IwUVdVTWhtK0UwcUZ5?=
 =?utf-8?B?QUdhWWpmM2FVLys2cXlaWXJKNldmUkRYS0NxWE1CUTRHUmhLdzltSGdHVUZt?=
 =?utf-8?B?WkpsV2NpWlZlc0xMampvSWN4cjFjRjJBTE5HZVFQMnZ1aEFpMmF3c3M5eXlX?=
 =?utf-8?B?TUFlUzJoakozcGpNcnVqUlpFV0RLc1BYaXBQYUVIdVQyM1RsVUZYQ0dXL25y?=
 =?utf-8?Q?L2vHzTEerRg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7659
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b33c0703-516f-47ec-14ea-08ddd4dbb382
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|376014|1800799024|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWJORjh0K3NzS0pyOHZpNUZoUEl5NDc5NHVta2JnKzd6a1czK2NTeUpZbU9M?=
 =?utf-8?B?eERnN2lwQk5YOVhiQUJoQld4V1JaT3cyRk9wYk1sMHZjZ2VwSkEzUHcrRW5S?=
 =?utf-8?B?ZUxrUzBBMDFvQ0krMmIyMU5wRnZ0WkY0N1prc2k5WmRmdlRBdW1sNmd6WkVl?=
 =?utf-8?B?Q2FBTU54N0c3ZlRaT0M0ZDlKKzlGVXRuNGE0RVlVeit6dHZNTHNCSUYvbE5G?=
 =?utf-8?B?YTJoOUx1VnRkT1Bud1JraitlQkFFVkZPYUcwMnZaTU9MVEtuUERYclQ2YUcz?=
 =?utf-8?B?VEI1RktlWjZwUTRWcnhqSXBVT0RwVFV1SExBaWpXR0tEelcydFNwUWVKSWpx?=
 =?utf-8?B?ZWM5ZE05QlBCelA4VTZtMFIwakJxNktUOGNoUUpTREZiY0ZObUxJbVVkdytC?=
 =?utf-8?B?RGJRVlMvb1RLNkx4eHpkVGlRUTJONDNpMGxmSEtteEpQbUF5VXNXUGgweXFq?=
 =?utf-8?B?MTkrYnpFSk8wdnBnaGFmcFVrVDJQSDBxWmZ4L2l6bnZBS0ViWkpKTjFod2Ja?=
 =?utf-8?B?SVoxZWorbDFHb0wxalNFZk1OdEJENS92NG9tODZ5elhXUmY4R2pxM0Q1SGs1?=
 =?utf-8?B?LzBOUFNTUWVWZUh1SWUzdGxacVczcUVDMGREdkFJOXpkbUJmZENhcjk1N0hP?=
 =?utf-8?B?QmR6S1VKeksvUVUyNG9ybkxrbHFQdkhkd2tLSEtIV0FGSnQ4UVBuWDZpaGd2?=
 =?utf-8?B?U0RnNkNjWHV1aWZCSnQrb3F4QTFHakpSTHhnYzRnUWNHT1RzT21FZ0NDUjBW?=
 =?utf-8?B?WlN5QnA5MHRVZXhpOG5Rbmk5WXk3ZndhQnBZeHNrRUkyRG1PMlQvUUhVWm9s?=
 =?utf-8?B?WS9sVE1VY1c4OGtSbDRtVWpJdjI4S2dhcVpnVTh6SXZvSGxtUlk0aWV4UDZF?=
 =?utf-8?B?NUxQNlFWK0JPTDdINnZYTU9JcEU0YmFKa3pjZmxvUEh0MzlCTEx6bzBvYnpl?=
 =?utf-8?B?RzRBSjNzcnp4T1BIQlZvUVgyR2lEYjRTS1BMenVXeGpPdzNJVVU2TTVoTEZJ?=
 =?utf-8?B?Z1VWcGt0aE9kUWN5SEdaSDl6LzhzbkVHQnJNKy96UWZCS2RMK21tWnlqTW04?=
 =?utf-8?B?V2U4QXFRWllHaGZaNFpRSkdsVjFYUFNFR3JqZ3FiUkpPT29IWUFldEFGZ3M5?=
 =?utf-8?B?QWxJcU81UkZvMlViRVA1bzlzckpiaklxZ0FmRWRWWExYcVN6L0Ird2ova1FP?=
 =?utf-8?B?Lyt2ZDR3cEJESCs4TUp0SDRNWkNVYjd3R1NhdzMycDk0ZVBZZTRTTk0zb21R?=
 =?utf-8?B?cDdxNnZzL2lJeGYvZVludTYxaFhoMTBGb0hLR2NRVDRZVkxLaEZoenlrTlhH?=
 =?utf-8?B?bkZiUHFCY1RISjhhNEt3NUcwM1ZwYVpjQ05WOW1meks5SHU5SW5OZC8xVWNY?=
 =?utf-8?B?Ty9sM24weXVhRHpNMHg4U2EyKzRoaTF6eTlTemJjc1RwclBtSG4raHBNR3cv?=
 =?utf-8?B?TmVHdXpGZk1wRXp2Q2lGdTBKejdtVDk3aER0OW00cWJoNW1UUWh2SEZVQlRV?=
 =?utf-8?B?RjJScjVkNjZCcTZ2NlFFdmNnMU5FMmlLN3BkMkt4dG4xc2g5UVJmMEpPdlR1?=
 =?utf-8?B?SERYTjVGekFxd0pkTkMvMTZkVkdEL1BWenVYSHQwMEVHVmZPanlkQ2lRekNv?=
 =?utf-8?B?MHVqNWFXcTlTQThwNFBYWlZYMFUzV1ZWT2lWT2lIZXRTVm9HeGdBY3V3alFD?=
 =?utf-8?B?ZmtpdGlrREdWaFlRQWMzRm1KTDRIczFYdkFIcHZmMndta3RrN2hpQzJzMEFI?=
 =?utf-8?B?dDg2d0JSd1JqVExaMUZaZ2UzYmVUODJxWGxGN1VNYkNUYktXVjNzdXB6Vkw3?=
 =?utf-8?B?blFVVVRIbkxIdTFTZi9YMkJDdTZZbXZYK01DZjNscHJTakJBNTZiNHpMUEVN?=
 =?utf-8?B?czExTG4vdnI3MkhhSVh0OXVYYmdCdUR4cnZLTTNUejRNenJPUFA0Rm1wVlVM?=
 =?utf-8?B?bXI0NEJhU3pwUldhdFVzektuR1VBanM1Q2RLRkkwMXc2TGIxYUwrN2ZsZ294?=
 =?utf-8?B?c3Y0Y2tKTU5SekRlT1BVVWFHdmcwR3RFT3FUWWpRQXRxMitOTEF4bGNQYlEz?=
 =?utf-8?Q?thWXcW?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(376014)(1800799024)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 11:24:16.4154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d46f1ad5-4fb2-409f-da9f-08ddd4dbc76b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8160


On 06/08/25 4:49 pm, Dev Jain wrote:
> #syz test
>
> In commit_anon_folio_batch(), we iterate over all pages pointed to by the
> PTE batch. Therefore we need to know the first page of the batch;
> currently we derive that via folio_page(folio, 0), but, that takes us
> to the first (head) page of the folio instead - our PTE batch may lie
> in the middle of the folio, leading to incorrectness.
>
> Bite the bullet and throw away the micro-optimization of reusing the
> folio in favour of code simplicity. Derive the page and the folio in
> change_pte_range, and pass the page too to commit_anon_folio_batch to
> fix the aforementioned issue.
>
> Also, instead of directly adding to the stuct page *page pointer, use
> the nth_page() macro for safety.
>
> Fixes: cac1db8c3aad ("mm: optimize mprotect() by PTE batching")
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/mprotect.c | 25 +++++++++++--------------
>   1 file changed, 11 insertions(+), 14 deletions(-)
>

Oops, this patch is based off mm-hotfixes-unstable, but I guess syzbot
will need it rebased on Torvalds' master?


