Return-Path: <linux-kernel+bounces-755641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064EBB1A9B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DEC818A3E22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D71224B1F;
	Mon,  4 Aug 2025 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xoUHl2bq"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B456A920;
	Mon,  4 Aug 2025 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335939; cv=fail; b=VbIsOIQLeIqZFB/uVf7wwCe52gyT3j7990cGGkHPmxGKrGA530xItm/H0R/Cn4JE/2B4yg54h3R9MS8eEgovu0jd/ip64LVNZ9NWCpbQCbDDIl1Vtgq657s3loCmapZ0rdYlcUtkl2S50xq4KLOJkgK6CLOVnWpNWzqT9VC2LZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335939; c=relaxed/simple;
	bh=toH5TZRYyp1dovgrrbQknMJtLasDAoKCCG8bAOvkVvc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LT6m9HenkCX0+FY1IOYswHPWtB1UEvkrd/YF4mOci6jelNRVcfiSlZ7eHML2BUCS2CAY5iMHFvPf0MiJpeUZpdqJUjX5bf+sD5ATsxnnE+SJV5Z5S26AO8OzLh0Gr0n+oAXH/cqvjJ0YnEXQ+qbh7OZm10292UkhkugBtKodGno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xoUHl2bq; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzfaKZnU8BnwhIJlnJIcCq83R2owYbmOBkdFG7gI9Wa/n+EL5vkCZYXoV/vEgxQtBkxU9WgDH8jTJg8OlDOgHsxLa6asIhl0b1D0oLR6KO8beqo4Nh5OOdWy0sX0JDpES8rdXlSIjpixO3aIVBIP/FZot6t9syBEKci7PkL3ve/EgVjNaqAwEmGFEXZjIZYsSW/3a0xOXKmpBPa8Gk51K5XmpSbDfSrEUqYs8+w0noQmuCuC8fiZ6Wivwd8fOx0RDI9XOWhDkSVzeg1YnwhdcsAmkhwAsO4LmPfjJ5mEFepfsHMkT+axun45zjTsyAGp8kWfFrYMZE5/yxx4tSCjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC1o9yN6gp7tTxAhJZrP96HbZtJLvwfTFUU3An6d0DA=;
 b=rSg2gT0XWYVIo5CibnEp5MjAnqP4o22T16FhazN/afzPj1tTSF28ZGPQ+EZDIlXx2YCQq02+RVCSIUH5+zFp3Hyopr/tvqVk+QuM1jg8UJoLYsdL5r46Y1qqJQUwCjd9M9J8iysfG6iAIbCzG063Aa+o/BEWGp8xEv9VVXH7dx9woNqrUr7aRE+Wwx8rX0bB1Il7lMtituqfEUY5YZao+sSHrG+2IIUsGLhuW9HhS5g/xdviqS0nCLSrCvmUMeoVrZckoza6CuyM5H7MvQF+Z963z758cC4b99+LG9Bu2SB3gY+01NJEP5mx2a2ik4fvxmSW47BCaJ5d62c6T5zTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC1o9yN6gp7tTxAhJZrP96HbZtJLvwfTFUU3An6d0DA=;
 b=xoUHl2bqzBOi67V0zPLlQKUXiK5pawA+fpy3AZU1HGcWdglWXIV6OFWIkEYg0FeQiEVq9FONl8r06pxKHZj+xFCKC2fNcmDpI9S9rv/4+qoXR823tr9CC/1igHxB2wdh2PAkpYARgUGpzuHygQy3l0JUvDmyx7hinaoTgNwXYlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by IA0PR12MB7749.namprd12.prod.outlook.com
 (2603:10b6:208:432::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 19:32:14 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Mon, 4 Aug 2025
 19:32:12 +0000
Message-ID: <5bfb400a-948c-40d1-b509-affcc22341f0@amd.com>
Date: Mon, 4 Aug 2025 14:32:08 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 09/10] fs/resctrl: Modify rdt_parse_data to pass mode
 and CLOSID
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
 thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
 yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
 ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
 andrew.cooper3@citrix.com, perry.yuan@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1752167718.git.babu.moger@amd.com>
 <f52c579262bbbc8bda4dbbb7341ad7bf0add0379.1752167718.git.babu.moger@amd.com>
 <798ba4db-3ac2-44a9-9e0d-e9cbb0dbff45@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <798ba4db-3ac2-44a9-9e0d-e9cbb0dbff45@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::28) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d91686-691f-4b6e-c5f9-08ddd38d9c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEE2Q0dRbFN6VVBXd1RvR05rZjRwWWxobUhZZFZJTGRMd29qcG83cmM2QXdy?=
 =?utf-8?B?WlhQMkxQOXNGbDNBWGJUL2hBNnFTcHRnZmtKNHNYVGlxcXQ4UjNFM3RHN0hm?=
 =?utf-8?B?Q2doK0JQL1JNU1pBVGZ6NkpudUZtL3AwNUZkM3p6b1BLYVhMNlAxRHE4QXpZ?=
 =?utf-8?B?QTlST2V5Ykw1NHIwU2FJQUlUbGlJNUtNemZNTUhHQjlFYldnOWwraFl2LzA2?=
 =?utf-8?B?amp3U1o0aXEweS80VUc1Q05pQzVoVHQvN3VqVytKNTN0VW8wcjBEcDhreEFK?=
 =?utf-8?B?dkR3czhTUFJzZXBMQkZNb2YwVHNOVXQzQmxoWnl1RzZTYU9NUmZqU0VIS3FM?=
 =?utf-8?B?QWg2b1gybTczU3Y1V0FyWmRmUmtPQW9yWEhMYmlYM2hZY3RMRTlHcXZiQTVD?=
 =?utf-8?B?N1NVTGIwKzBHeUF2VWpFVzRHbWQ1VVJqdmVCeDE2NlBmb1dzWVRqV1EzZnFo?=
 =?utf-8?B?TTVmb3pNYUdORGZxZUZaNmhqNlBVU2ZKb2pqeFQzRUF6L2dDVUU3TmVibEti?=
 =?utf-8?B?VDdnRGU3NzFuS1Q3eHdSNFhDZDNYK3FZSjhmd2RVeG9iL3F0Qm12RUJMRDNL?=
 =?utf-8?B?YlhkN3Axb0xmeFlHdzJRL3F3Q3FzRjlhRVpVdld3cCtFM1grRkxNcUI4cisx?=
 =?utf-8?B?b0NBcy9ZUjRZNG84R3I2QWhxdkpMWGR5dXdPMUowR2IvL3BhdmJrZHhaVXNp?=
 =?utf-8?B?bFk1T3pPNytTdTh0QmJnMStHSVRCVU5FbElIYnJOMWlWbU1OT3FaMjRGY3Bi?=
 =?utf-8?B?ZDUxYi8zd05zM0JZekU1Q1ZyVUZ6NWlmUWJncUpGS3dYTEpRRUZjcGhsQ2lv?=
 =?utf-8?B?U1F5dFNkZk5tRFNFa0p0S1VscVgrSXowYUdXcTZkOXRQMUMrdnRoREtqSEZM?=
 =?utf-8?B?UlVZSkR3c2ZndHd6M2ZSTW11a21CSTQ2RGdpMkdxdE5LQURkc21OWTdYa3hS?=
 =?utf-8?B?cGpyU0VPMzJyenVVUGYzVmd2ODVtdlo2SVBvL2V5MU9hYWxRK1lMSVMxcWo4?=
 =?utf-8?B?Skd2czNVTG9ERkdCdTJNRkZ3NzlHSHZqZGNrT25tM3drcW1DbU5aUU1MYXhK?=
 =?utf-8?B?c0MzZEVnQ0lFOXpOSU00S3ZlYTFqN1A1ZjA1dE5nK2dURnl1OFhjZTRuS3Jo?=
 =?utf-8?B?MDl3b3lFSVpoVHYwMnhQNWdzTlVHWnNOTVB4VFpvd0VleGY2aE9Bd3VwQ2Fo?=
 =?utf-8?B?bXRSOTUyNHFhUVprNUZVbUpaTmJDcnQzMlIxRndubUFvUmdjTXZ2Q2owL2lB?=
 =?utf-8?B?L0YyTlQvMWhYWWlCYWFpbnozWDBreVdOUzlMWWtnUm42QlJJaEZmOFRIajRO?=
 =?utf-8?B?Sm45ZnJyYjE3MmtrRndxZ2MvdkFPU1JZUFd6QW9VdFNPNHdTcDNMUGlJZHYx?=
 =?utf-8?B?Um5PcDJjVXAxcTUwQ01nSE1pL0I2T05EMmpYVEsxMkNTZmVBSU1aR0RKQUJF?=
 =?utf-8?B?QTdBRXJkSEYwMzBrSkkwdnhESHNOQkxSZmp6T3locEd3QjRQcWFEOHBVNHZ1?=
 =?utf-8?B?bTY5QlhQeWJaSWZEYVJLcllYZHdIZ2RkZitiamc5RUlCRzZLYmdQeWNyT3pi?=
 =?utf-8?B?bzduMjZBaXVydWFiVzI2TmtVNFliS0Y1MlNkVFJBZkVYZVkrMCtyd2UwVjFL?=
 =?utf-8?B?amZwVWx2NVhHZzRjeXJQZzFnSFlGS1IremhJZUFETURzYUNHdU0zMm1xbzJO?=
 =?utf-8?B?STVmYnpuQjhBS3h5STU4c3RNQTV5bFZnRUN3NGtnR2RiRytWakcvSW80V3lD?=
 =?utf-8?B?VHByeVFoRjlid0E2c3FhNWE4L2MvazFNeHVZU0IvQ21EbmVtSGNpYXlhYklD?=
 =?utf-8?B?aHBDYkVyV3RuVzVMZS8xZGpHTXpnR3lPY2ZQZjVZS1dFSTZqYTJKWS8xREc4?=
 =?utf-8?B?ZExlVUx6RGZIN2dIR3BzcnVDZ0NyYWNtWTVwcklOZi9MMXl5N2ovajZ5UVp2?=
 =?utf-8?Q?DPAcVN9vyTc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXUwblJ3T3hrc1A5OXE2R2NtMFR2M3d5N1UxaGYzQ1ovRnFodlh2RGJmQjdI?=
 =?utf-8?B?WTgxV0NZcng1dThWQkFxbG1STW1lZzFUcDZDRndMb0hIYmtZamdZTHVCNld0?=
 =?utf-8?B?dmZXaWlobHZlRCtDUVM4SkpZNXRvU3AvazREc1l1K0JJRTZuanNISkttTDVU?=
 =?utf-8?B?aGdZVmI5UElJUVpCcnRlckRqQ3lMR3RkRE81TEszMXBhNmQ1K1NPbVduNEht?=
 =?utf-8?B?UURyYjczYlduTEJyU09ab243dnZ6WXlzUk9UV0plZ2x2c2wxbVdUWjZIUjAv?=
 =?utf-8?B?QlZMQVVlWU8xS0tGd3lyVEM2Ty84Y3Y0Zm5NQWR0azQyM0pjTzhBbUsrZkpE?=
 =?utf-8?B?dmpEVmI2QTRPUEJzNjUyeEU3anJLUm10emc2V3B6eTc5anlBVXRFVHVjemRK?=
 =?utf-8?B?REVvblpTa04yanU1S1pHN3g1VzF1K0VuYUhtU3hVb09CMGVMYnpueFhmUW5M?=
 =?utf-8?B?UmthcVVpY1RnWTBYVE96YkdmbmVxTzY2OEpZMVhvRldtRDJyaXY4TTcwVGts?=
 =?utf-8?B?OGVDNzB6L0phRDhpYWVWUk1RR0xJOXM2Z3BFUWoyQ1Jibm1TSlpkYnVvd0FR?=
 =?utf-8?B?UitQMEpMUXNsb25ac29JaGkyWnZiUE5sNTdrZEFRQTNFRUJCUUJsRm0zWWdY?=
 =?utf-8?B?RHFLTWxwWTFRUm5kQnVrQ2VCeFc4cXdrTVVscHhTTnFpS0VYK1IxV0lBZUc4?=
 =?utf-8?B?cU43VEliVjYxelJIM3dxTXl2UWdnWjVTSGYvUFRWbEduRDY3a3NwZFh0aTNz?=
 =?utf-8?B?bU5OclBFN1loaDFKeGo4djZKcGJDZjNHMmMvbHdTZ25Lc081UUJ3UzN0QnFN?=
 =?utf-8?B?Rml0YVN0TnFlMHNQOElrTEFEZmVNNHQ5SUdlenczWjQ3b1NCUzE3bXU5UFJE?=
 =?utf-8?B?Z08rMy9NUFNVb2tSemNiT3pIQ0xiM2RnTGMvTndwZEdkRDBmOUZjK3B1NzVF?=
 =?utf-8?B?OXZ0dlIraXBJRjdDdVkydER6Y1YzOXYxcFovU09Td2RsdTNTbHpvaDNwcm54?=
 =?utf-8?B?TkdlQXh0WkY1dXJCM3c3c1NaOU42QVJUWHlyZUVUVkkwNEZuNEV3K1hxU0hR?=
 =?utf-8?B?YnFaSzcxYXhYc3l2SWQ0TXB4NTV2ZTBBOFVVRXd2Uno1OVNVclVHczhKTTBO?=
 =?utf-8?B?QjlVSWp6L2p0dSswRFMrV05sVWdqN0hkZDI1ZXByT3FBU3VmV2YxYTlmM1NM?=
 =?utf-8?B?UTBpdnI2S2ZBTEluZHhicmRmaWdFSDRmMWFIemRIeGQ1aWk3dzdBQlF3L09j?=
 =?utf-8?B?YVJhVnlnWVQrV3ZRaGxWU2xOVjhXRjVJNER1MTBzaCtuVXh5OVYvVDBMb2xn?=
 =?utf-8?B?cmxhU1VDajBkTENHS2RiVEVORmczKzlucHdFbzRCWisxM3J1K0NOclBPbzd0?=
 =?utf-8?B?TGJEQ05TNWRqYy9nUXc3VWNaVHg0cTdzODJCR0tlYmVHZkpNWkJZL1hUbWpW?=
 =?utf-8?B?cEppL29wd0hZd1Z2OE5VYjJRZTd5UFN6RzRHMXVyRXl2M0l6T3ZaSzFFNFg2?=
 =?utf-8?B?VjJ0SnVVa08xK2NhYXFBMFBSRUVpOWd2bnJ6d1piUGdqQTZxMWtYRHg3RmhP?=
 =?utf-8?B?ZExtWUJ1ejYrVzFpZDlsK1RGaEZmSDduTlF0cGU1ejJ1bTNkc0ZYWlpKdGZV?=
 =?utf-8?B?OTF2MHFCUEdJaVV5TkZzckZWMnZUdDBRaERDV3JYVkNKazh2U01HUDh2STVF?=
 =?utf-8?B?T0NJcTV2TWV6bkVoR2RieWdBb3Z4QkNQVWRoRWEwcUJJZFFTL0ptZWpvTi9x?=
 =?utf-8?B?VVFqOTQ5RUc5K3B6SC9NUUpQalRVcnFpeFBXMU9ZSTV0UGNNSWFCY3BGN09x?=
 =?utf-8?B?Z3BQRU5zMmJBVUpWRW00aDVyamFoZ2F3NXl2RUFab1hsZVU5RDkzYlVWcmsr?=
 =?utf-8?B?WHpRbjNiNThteEVrcG5hQkFFTVR2ZmtvUGh3cFZYQUZJak5IbGlwKzQ0UmFy?=
 =?utf-8?B?NWROOUlRbDVxZUV2WUJva2JCMzlITU5WaUFvSXNIM1dNVDEvdTRNd0xIbUdL?=
 =?utf-8?B?Wlh1NEJjaFhLTVNWNGkzWHgwNlhhelZTV3NncWNMMDlzczQ2VlhqRk5XbURZ?=
 =?utf-8?B?WGNkL2R0c2FUU3RycmtyTnBVYlMvcng0UWhiNWljM1o5T25RMVB6SUhaY0dp?=
 =?utf-8?Q?ryRo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d91686-691f-4b6e-c5f9-08ddd38d9c84
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 19:32:12.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yi+GEdV8gvkFl2xwB1YVIPkxkUnr5txAQ5Pyx2fEw6rwnhO5hFvpPA/5LyRtLnHk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749

Hi Reinette,

On 7/21/25 22:30, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/10/25 10:16 AM, Babu Moger wrote:
>> The functions parse_cbm() and parse_bw() require mode and CLOSID to
> 
> No need to say "function" when using (). Also, drop parse_bw(), since it
> does not validate CBMs.

Sure.
> 
>> validate the Capacity Bit Mask (CBM). It is passed through struct
> 
> "passed through" -> "passed via"?
> 

Sure.

>> rdtgroup in rdt_parse_data.
> 
> "rdt_parse_data" -> "struct rdt_parse_data"
> 

Sure.

>>
>> This can be simplified by passing the mode and closid directly, instead of
> 
> closid -> CLOSID
> 
Sure,

>> through the rdtgroup struct. Doing so also facilitates calling parse_cbm()
>> to verify the CBM within the io_alloc feature, since io_alloc does not
>> have rdtgroup context.
> 
> Above notes that "simplification" is the primary motivation but I do not think
> this change qualifies as a "simplification". How about second paragraph changed
> to something like:
> 
> 	The io_alloc feature also uses CBMs to indicate which portions of
> 	cache are allocated for I/O traffic. The CBMs are provided by
> 	user space and need to be validated the same as CBMs provided for
> 	general (CPU) cache allocation. parse_cbm() cannot be used as-is
> 	since io_alloc does not have rdtgroup context.
> 
> 	Pass the mode and CLOSID directly to parse_cbm() via struct rdt_parse_data
> 	instead of through the rdtgroup struct to facilitate calling parse_cbm() to
> 	verify the CBM of the io_alloc feature.
> 
> (please feel free to improve)
> 

Looks good.

>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> 
> 
>> ---
>>  fs/resctrl/ctrlmondata.c | 29 +++++++++++++----------------
>>  fs/resctrl/internal.h    |  6 ++++++
>>  2 files changed, 19 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
>> index e78828b0408a..5c16557fb7a8 100644
>> --- a/fs/resctrl/ctrlmondata.c
>> +++ b/fs/resctrl/ctrlmondata.c
>> @@ -23,11 +23,6 @@
>>  
>>  #include "internal.h"
>>  
>> -struct rdt_parse_data {
>> -	struct rdtgroup		*rdtgrp;
>> -	char			*buf;
>> -};
>> -
> 
> This patch is only about replacing rdtgroup with mode and CLOSID, there is no
> motivation for relocating the structure declaration. This looks to be a change
> needed by following patch but is another change that becomes unnecessary if
> the io_alloc code, specifically resctrl_io_alloc_cbm_write() and
> resctrl_io_alloc_parse_line() from next patch, are moved to ctrlmondata.c.
> 

Yes. Not required to move now.

> ...
> 
>> @@ -171,7 +167,7 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>>  	 * Cannot set up more than one pseudo-locked region in a cache
>>  	 * hierarchy.
>>  	 */
>> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
>> +	if (mode == RDT_MODE_PSEUDO_LOCKSETUP &&
>>  	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
>>  		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
>>  		return -EINVAL;
>> @@ -180,9 +176,9 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>>  	if (!cbm_validate(data->buf, &cbm_val, r))
>>  		return -EINVAL;
>>  
>> -	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
>> -	     rdtgrp->mode == RDT_MODE_SHAREABLE) &&
>> -	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
>> +	if ((mode == RDT_MODE_EXCLUSIVE ||
>> +	     mode == RDT_MODE_SHAREABLE) &&
>> +	     rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
> 
> Please fix alignment.

Sure.

> 
>>  		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
>>  		return -EINVAL;
>>  	}
> 
> Reinette
> 

-- 
Thanks
Babu Moger


