Return-Path: <linux-kernel+bounces-803520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 134A8B461BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CAB1CC0265
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECA303A29;
	Fri,  5 Sep 2025 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DxHO32Se";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DxHO32Se"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959CB393DEA;
	Fri,  5 Sep 2025 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095603; cv=fail; b=cPfZ6HxpTBvfequ5bk+UuWTP9rogXA8r8oOqLvp3NKc1p7IwNDuCMmf0F8ivBreEdS6XhaR3u0CaG4IHFIkL6hLLkCgVnD35ZKljwpau1LSb1XUBDwGQA/JLhG6SDMSKhNUBJU7dsLK5FOtKsg+M0Ja67aloCxGp76aKu/iKtAI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095603; c=relaxed/simple;
	bh=1gTLAAXZnGFG7IlnCVasjTdy6d5SqkgxdcG4hXbHv9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HnPCwhsq7Il9UQTq0HKI93LJeYi2SbFpezn9CSROBiqSfGjOmr+ZWYTAG3Zo7vbS5TXr3plbQGxcLGFmqItKufcn4uYFdKjbCkIXalWr+5QFufu7SsKygG5cxjGvaOgO+vzdaviKr34PQMfgGUXMVllHj1naKzC3r7pCHc83JC8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DxHO32Se; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DxHO32Se; arc=fail smtp.client-ip=40.107.159.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RIxYmUGek/9B8osvjHKeWN+eWdoeJWir1NLRxz2vdLnSsWabbcTjfZJmRKUtpCKxHRmtOMvjnh2KkzBTyYJzTkzz6sXXq3uj59wtR3djeE3OHLo1XJMf84xwTO7Lrn9xSTgDAilfht9YKwS4yC2LpuSPDemP4dXhOZa92iYxey0UPOjGaLjsTfTX7/VPdSSBttkYmeTxxjsbxZIdZ6kdqUICQe3hGpja7NkvG4pm6oGM/dmrQipqZa7mhgwRcdIb/xE82S2sLwAyDwPhVvAyptiQPTh+8Cz2MivCzKe/wplIXpnpg/pza2nArPbp/QvPvhYikm/bwh0reaFLMr0xHw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl2IFBoQ+y+/6HaUGKXsVb7gS29m8F6Ju4xovBP9E0Y=;
 b=yazVcW30iTPfAaeHOJlWmW3sg0rvDsz7wVWhZmFYRSNWpYkQk5jvCbIfuFMioT7gIcglgx8k9AtDShYvhHp+ztKbMXWV+4d7JdUqHbZOQsTuapXCkm617SVeCLXZeW9j7g+TLePa4VfXv6lhWIkQt4Kt8wpbOly8ju3+5oJ+l/lnBsV/9b8VS4k6Yh1Fl/VKWa/5OzTFV2IUM1sWRTi17jeeWpwt7u3w1cHNRNnxzON69zucIJ85tdjA8T/U1O5+yqUDmNMoCGCD49qxFE+E4UXlaV/imsPVUiSbJ95CuUE9LZyEvRR4DT51d1zSAmdMyD42zq9uIlGI7CanUxi8xA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl2IFBoQ+y+/6HaUGKXsVb7gS29m8F6Ju4xovBP9E0Y=;
 b=DxHO32SeKGwJ8iCVwuVg/kwaPfk42sxqNJ9OJDJbjvSdbS2l3X4k3HLAUNPS1A+5u6YT3jpBLMyCOrJFQsVOaB6VCyiNau/FGqqDHR7sqbrq76QHzBn3UEmGECoKYAxEQzmKyGu9UXoYl2i+mZcJGbm3BSRuzx6znWPKsAnfF+0=
Received: from AS9PR06CA0486.eurprd06.prod.outlook.com (2603:10a6:20b:49b::11)
 by AM9PR08MB6068.eurprd08.prod.outlook.com (2603:10a6:20b:2dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 18:06:37 +0000
Received: from AM4PEPF00027A6C.eurprd04.prod.outlook.com
 (2603:10a6:20b:49b:cafe::86) by AS9PR06CA0486.outlook.office365.com
 (2603:10a6:20b:49b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Fri,
 5 Sep 2025 18:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A6C.mail.protection.outlook.com (10.167.16.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Fri, 5 Sep 2025 18:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWtLM2nZDNRKE0v7/7m1o9SoDSku0U0gNqRK0FJRV+QCZI+JJmFWZ9o/FFP1zMQNZzOIJm/9c3jsuvryIwDdqV1BFf8MMXcSL59QeIcC/u/+lvYmlP8nsmpPU21f+ABVM7HtM5WaqlSupzYYgryQ4pIaoPEpvtVI8fYtulv8MDunGU0N8K2ei6c+QUZu55IQmmyVF1LBffATeZMS2/By1K52hFJu83coaig/2rPqUU3GVq7BJO7aoyJ1x1Y81ByxBpI7fh4dnfAlEr3QIFMkA8whcO5g43ppG8YT38IYFX4oGa5RkEBymIKQas93jGgobLcFA9/gs3KSig2n4FqZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl2IFBoQ+y+/6HaUGKXsVb7gS29m8F6Ju4xovBP9E0Y=;
 b=WlsQr+oQNOBUD8gJeyhHgL2KvvPal9PahWpT8fJ6cOUj+4YBoEadvATFAf/ImzKjr9gexdQeGazKgj/mlQJFVs4O4yBSCOOFcO7Q1DOrYJ1nqcZA0nt7+EHPXL5u+BoB6gvdEgTNrUgYGQJpfUOTAMu6VtiXpZS+NzyL1rBlPStVkTCAT9AGovHuAqLduNLxU5Tzsc/vNZxWKfBV8wQEdK1ILddCuVsY+3gazgmzkPJaLRSZxKk8u7MHmx2Owb0WsHGqj3NtA5GvsCiSbfsAZXLVh6+Fbd984a1ZAa66QHdd/M8u/9GZQsGR1cjd1TBPSh27/t1fiEgNvA9lzNN5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl2IFBoQ+y+/6HaUGKXsVb7gS29m8F6Ju4xovBP9E0Y=;
 b=DxHO32SeKGwJ8iCVwuVg/kwaPfk42sxqNJ9OJDJbjvSdbS2l3X4k3HLAUNPS1A+5u6YT3jpBLMyCOrJFQsVOaB6VCyiNau/FGqqDHR7sqbrq76QHzBn3UEmGECoKYAxEQzmKyGu9UXoYl2i+mZcJGbm3BSRuzx6znWPKsAnfF+0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB9PR08MB7890.eurprd08.prod.outlook.com (2603:10a6:10:39d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 18:06:03 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 18:06:03 +0000
Message-ID: <f8eab519-edc5-460b-8f7a-83bf7827f502@arm.com>
Date: Fri, 5 Sep 2025 23:35:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250819134205.622806-1-npache@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250819134205.622806-1-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::6) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB9PR08MB7890:EE_|AM4PEPF00027A6C:EE_|AM9PR08MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 292548c1-d485-44e5-5e07-08ddeca6f485
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RjFhSUxERW84aG5JeGJyUWNVV3hybHM0d3NPbnV6SVZXdEp4Q2VGTGZja3ZT?=
 =?utf-8?B?MVlDeGw1RmRyK1R0b3FKRTJGQS9pMnh2aSs3cXZYa1ZvL3M0aUlYVzhtQ1Ew?=
 =?utf-8?B?anBhazVXaDB2UExSQS94aXdybUhZbDRjRlNqMjl5Y0g4TjExU216bDdIZ09o?=
 =?utf-8?B?cXNjcmM2dWRHSFZmRE1mU00zOU40N2dFaG9yM2h2cXZGTG12Q0R5dXl0aG96?=
 =?utf-8?B?OTJqdEFDbGlVSjVSWnZQKzZVTnFuTVJFbm1CR2ZQQ1VoN0p5ZFpIZ3BtOUti?=
 =?utf-8?B?YStHOEN2elFQckhBdjV0NVRiTHJzTFVvMDRyMDFCWGtDaFVNcytrVnJuL2ls?=
 =?utf-8?B?M2l1MGRBMHlkdU9KTjFOTWErVGNtbTZkdEExdys1ay83U2NXVFUzLzlrWTdq?=
 =?utf-8?B?NEV4cVVxZ01wZWM5VEkzbURjTnE5ZlhMMDd4dS9wTVlNVXYyWnBmbDVVSVhi?=
 =?utf-8?B?bFdHRWNoZ0dVOFZlV2QrSnppT1dvaHZrZEJ4dFh6czhYMnQybGxtZUxBR1k1?=
 =?utf-8?B?VWNFdUlRNTNzRCtmTWtJa3RBdGhONDhjeWZKbWtKa29sN05nODJNNHhwOWxE?=
 =?utf-8?B?QldHNDNBbkUyQ25iR05CN3lCVVNOOHlLN2swelZENjVCb2diWVRGT0Rxb21Z?=
 =?utf-8?B?bCswbjdtTkQ3VjFwTFdRWXlTVjBhK0ZoQlRIbDBnQlU1SlgvZVFTemNtTGVx?=
 =?utf-8?B?VCtEb3laZ0YzTUhNbXVQVi92RklMWUJNeTZhenplOHpnaTV5Qk9zZk1OR0Jl?=
 =?utf-8?B?RHAraHFnaE1FbE9namJmWHY5TkxsWkd3MHE1TVlUQkhINWY4NDRNQmhXdUVT?=
 =?utf-8?B?YmhuRUJwSGN0TE5GNlAxdVNHTHo3SktaTkJseThMU3JsU0V4Mmh6OVJ5RHZZ?=
 =?utf-8?B?eG5JOTlIMkFlakxOUFNqVGQ5bUdxeWNTUWhaU0cwbUZaWUppSFFOQkNtRVdi?=
 =?utf-8?B?YWR6V1hmSlc4K0hpTHhWUEd3ajZLSk5hL2hHekdOMFpVcTdWVUJpbUZwYXIr?=
 =?utf-8?B?dlJ4ZjZqL0V6WlhjU0hlY3lmWVdzYTRtSkVFdHJuSkpYV29vRllHaDcvU0h5?=
 =?utf-8?B?cTE1UEJrNnpndDNWZHR0R0xNUUdOOXBTUmVTQVJlRnhWMkw0eHhCd1d6a2d6?=
 =?utf-8?B?YUgwMGlCT3JjMVF1aHEyWUxGOU8rYlVXb1hXdVQycXFuMGdKV01TR2JpOUVs?=
 =?utf-8?B?R1lPb0xCbG1scjUyYytudTdva0RJWmNZOExFRFhEbE56MENsYnN6MXptZ01R?=
 =?utf-8?B?RlpCeTJCOTNHZE95dWRhcWt5dUY3dnU1K2lCQ1hrZEhSRTJKYU9JbWZPQnlX?=
 =?utf-8?B?V3VyVXNldWZUNFlna2xkUGFUUG13TEtlODVTK3RCZ0dnNnliQnVwRkRaekRn?=
 =?utf-8?B?MjFDRXUrNW83M0NQZzVpdldBNUdhckk2ZzFCeUhsbDc3d3RPY3YwZVhyR0l3?=
 =?utf-8?B?MU1NNXU2SldwN1kraUt4eVF5ejJsb3VIMmxOVlU5L3VzZVlnbFllOUV6QlRJ?=
 =?utf-8?B?NkhCNVhjWUtwNDdnYzhxVmtoZHYwbHRlWnNxZWkxaFpKUWNoOFEyS2JCdFVM?=
 =?utf-8?B?ZUlFeFJEWHZzUWIvMEN6ZkJ1Rjl3MHFiNG9FcVN1cEJsdEMySElBQ0dSb1F3?=
 =?utf-8?B?UWNNVUpEU29CQVFxSUdkeDBHZU44dTFVaWRZRkVXQjdhOTFWL0NXNStQaTNL?=
 =?utf-8?B?TGtGWlJuUUFialN6UGwveThOamt0SVpVQ2tuK0VZWFdJckd1TUJvenpGQUxo?=
 =?utf-8?B?UkxJZVBYbjMvNG03akZzMUJoZ3VBRUxIS0cyVmxUekZTSHRzQVhkdEhRNUo5?=
 =?utf-8?B?eitjMHROSVJiWmg4dHpsV0VDYW83K3ZvLzJUZFpNZnZaOFk4U0w4UnlRV21x?=
 =?utf-8?B?WWNxVXo0NWNoanJVSVNZb1RMZXlML3pNWHo2bkNmVzZRTUxrRWFGK3ZTeWJn?=
 =?utf-8?Q?xLuMr3DgxMg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7890
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9de2718b-79f3-4496-bb7b-08ddeca6e088
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|14060799003|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlpCSTlteWpuckpzbXRURVVDUWt1RkhkaldJWFBLTzV5ZlExZ05sM2ZBYVdB?=
 =?utf-8?B?QUFqRHpMZkdHNk9tMWwyUHB0eE1Ib3pXY0tkWUhCem0rTU0zYkIrQWdCcHhy?=
 =?utf-8?B?UkJLVEl2Ni9RbGc5eUtxK2hXSWtDTmJ3OWdQYUJ4ZTlYd09URnhZaWRkeXo3?=
 =?utf-8?B?R2I4ZlpmK2NqakkyMFc4MXpKV3hLclMwLzVtNStwUFFLL2gzWDdQY1YvaUZP?=
 =?utf-8?B?RTV0NmpLV2Q1V3VrL3YvWlViRUVJQWlrc1JkUjhwaDRXaGhKSVBxSnhQL2lX?=
 =?utf-8?B?Y2pXZHVxMXZTa25aZVp3RFJxRHBaTUFuelo3Z1BpT3M4c2Rod2R4R3hpOTFi?=
 =?utf-8?B?aWd5ZDBDWlRXbG85eFVLUi92L3BjZ2dnd0FlSTFPZ2lGbTE5R3NIM0p4N25w?=
 =?utf-8?B?L2VwL0FwV1JyZVAvL1BENW51VFNkbk0wdzRnZm5CUUY2eDhMTUlwdndZbmdH?=
 =?utf-8?B?T3A1clNrbzBva3RuVm9uY1d0cS9hUlRZdFE3WjBnaTlzeDRibnRGU3BrSWlX?=
 =?utf-8?B?dkxHZ0s5ekY5aGtFeEducGdWOGh3a2tteDRKU1FQUVhRYXBmMmNJQ2lWWkMz?=
 =?utf-8?B?a2RwMG5MKzRNbnZON2I5bWRrTDZHQmtRRllOSjNBQWxtOUlxaTVRMmlWWGNH?=
 =?utf-8?B?YXBSdWR5UTdITzZFVmJxYmlEeWxEL2tWRGtXcVQzaXk2VUtEZjdNYkJXSk9t?=
 =?utf-8?B?d0hYU3k4MTVIOFFCbWNGeUZNZGQ5UE4wd3JHT09Lbi9rS2IrTjliYW12L3pC?=
 =?utf-8?B?RCtUOGVHMXlPb3haU3BuN2lNRDdlMGErQ3FCYy9zZVZ2eUIzUXBvTUhVbEtD?=
 =?utf-8?B?Y0txVEhiRG9KVGxXRElCV0JXallMY1h2RmRZQUFNYjFjOXZxbXkyR0Q4dG02?=
 =?utf-8?B?amV2bFdlZU51ZzVEWXBTNGtBaTFCZXI3MGNVY09ZQVd3YWlBRllUSkpLbmdr?=
 =?utf-8?B?eXFDMlc2eWQxZ0FRZHhESXZESTljamlXRjJWcG00eTlYNmNrcnpSa3lOV2s4?=
 =?utf-8?B?cyt2eHp6bGhWVHNtb2xoVUw2S2twWk5Zamg1YnFjUXJ4aU1PY3A0UDRKL0Ni?=
 =?utf-8?B?djlkS05kbnlUQm9vOGhnYWwrL0o3MGNNZ21NeWZnOTNLRFVvUStzcldtZll6?=
 =?utf-8?B?bFYzYjRGWUdKVXBFVHBjN0oyeEdocWRFallDZlpQWWU4SDJmemxGQVZoNjJV?=
 =?utf-8?B?Tzg5YmZpaUVBeGlSR0pwc3hSQitydDUraDA2NGw5WVFCR1dWeGN3dm5oRzNK?=
 =?utf-8?B?alVrdTBvSTNtVmp0RjNrdXhEN1VRTjRHQ2Q4ZU83SHk4SE9aZ1pKejBUYmQ0?=
 =?utf-8?B?VGZLaGZQUit6REFXZzh2R2dnYTJhVENLOE9CRmNQUUc3R0FUcjJLeWZXU0dM?=
 =?utf-8?B?ZUZteFRneVpNVGVYUEU0dGFXdHUvQ0JKSjVEUW5GSkU3dzR5WVdPOU50RzhO?=
 =?utf-8?B?L0hoWmpwdlNvaVVsNkdxc2JtTUlyK216VlcrNTdKdkdTaUhieEdNcTROTzM0?=
 =?utf-8?B?TzJsVEI3dktUZ2dtWTlXaUorYk5LQmJza205WUNrdDhBT09LdzdjbjZVU1Br?=
 =?utf-8?B?NmFYMnpwTEU2K0N2ZVlHa2pqY0JiUmlBc1UyZVpkVjE2SE9FRkRSUkZzMW5s?=
 =?utf-8?B?bVZVYVVJTkl4VDNoajhQY0lGU3dVdmo4bHV0TlpUcmxFdnhxRUhseW9QVDJQ?=
 =?utf-8?B?TDluVUp6R2RLTU9MdmJpb0VHZVl5Y2pJWTlOeXBLMzZHZTYvcWhJRUcyclBy?=
 =?utf-8?B?MEhCd3NNQzBoc1gvYkFXUGx4NGwwN1lLSXJUbEdmL1pwME1udlNPbENjdGJ6?=
 =?utf-8?B?aVRoNnBuLzhFcERCQ29Jb1RuT0ZuR1FsSVo0d3NqVmRVekovaG91ZDBocFND?=
 =?utf-8?B?YTI4dExCa2xlaHlWb3BqQnB0ZldJaGx2Mzk3L21PZWo5NWhUcHhMbjZwZXZO?=
 =?utf-8?B?RUR6a2NZTTNhQ2RjenYyVlFmdlljdFlSc0dXa1ROUVVSRnBWcWpVZmt5TUhM?=
 =?utf-8?B?bmhYSjFzQjZ5ZjZyak1tWDdMdVpPdVkvblRiaFJaeFgySDg3QTZDdDdYTEhV?=
 =?utf-8?Q?e3SAdp?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(14060799003)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 18:06:36.7041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 292548c1-d485-44e5-5e07-08ddeca6f485
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6068


On 19/08/25 7:11 pm, Nico Pache wrote:
> The following series provides khugepaged with the capability to collapse
> anonymous memory regions to mTHPs.
>
> To achieve this we generalize the khugepaged functions to no longer depend
> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track chunks of
> pages (defined by KHUGEPAGED_MTHP_MIN_ORDER) that are utilized. After the
> PMD scan is done, we do binary recursion on the bitmap to find the optimal
> mTHP sizes for the PMD range. The restriction on max_ptes_none is removed
> during the scan, to make sure we account for the whole PMD range. When no
> mTHP size is enabled, the legacy behavior of khugepaged is maintained.
> max_ptes_none will be scaled by the attempted collapse order to determine
> how full a mTHP must be to be eligible for the collapse to occur. If a
> mTHP collapse is attempted, but contains swapped out, or shared pages, we
> don't perform the collapse. It is now also possible to collapse to mTHPs
> without requiring the PMD THP size to be enabled.
>
> With the default max_ptes_none=511, the code should keep its most of its
> original behavior. When enabling multiple adjacent (m)THP sizes we need to
> set max_ptes_none<=255. With max_ptes_none > HPAGE_PMD_NR/2 you will
> experience collapse "creep" and constantly promote mTHPs to the next
> available size. This is due the fact that a collapse will introduce at
> least 2x the number of pages, and on a future scan will satisfy the
> promotion condition once again.
>
> Patch 1:     Refactor/rename hpage_collapse
> Patch 2:     Some refactoring to combine madvise_collapse and khugepaged
> Patch 3-5:   Generalize khugepaged functions for arbitrary orders
> Patch 6-8:   The mTHP patches
> Patch 9-10:  Allow khugepaged to operate without PMD enabled
> Patch 11-12: Tracing/stats
> Patch 13:    Documentation
>
>

For the next version, it will be really great if you can mention
the lore links referencing important ideas guiding the evolution
of the algorithm - say, a policy decision we make. (I frequently do
that albeit I think I over-do it :)) I am asking because I am
completely lost on the current discussion going on around
the max_ptes_* scaling (been busy with other stuff).
  


