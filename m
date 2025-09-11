Return-Path: <linux-kernel+bounces-812312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DD6B53614
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABC218905F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDA73431FD;
	Thu, 11 Sep 2025 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Shr01IU0"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020137.outbound.protection.outlook.com [52.101.191.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F431320396
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601906; cv=fail; b=ElUf+zMcqw9xJCoVEJwXdhs7tq2lPVaf3cfVR1m3gJiQxyGqvRGX+hWsfL2ThKnCkujuxsM2PJqCxDisCBLfQVvzaCMIhocz5GRGV2uVPg0KW04qSW3kh4rfO9YlSpwB+XGLeu0jjCmkXtmYnRnH3vM6V70klmAvaSOGuKMk4mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601906; c=relaxed/simple;
	bh=GcS8TKb29sG6+g0S6mXVuJcAF9MHWhiKAXy1M8D4jJM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LHWE94UZINHI4sR2m7xvjYNux9b0f05eb0yzwj+UleFiYoBd1HlcNiAkNpbm70BGgqxX/cWaYjpGMEEzrsbKQQg+x/nWYq0M0eMmjiMNxU1w8BU1zdTH7e63Idf1kt+dlbMRxEql3Cf767LWGD4SCy5eDiNmbD6eLoLGATrVCfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Shr01IU0; arc=fail smtp.client-ip=52.101.191.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MX+op3SdWlCQTBn+ecMJjYNu8/L3B6rqz1RXt+cnK45iZVLTGMhKH8t8SpGWNZGVJL5zXEHlN+eu4+duJvpmL+4ys8GqBL+fLxAv+pL8CrYTAXpvZVFn/9cwQyclD3B68BFq4tSOzT+qtBZFXbV8LKrwdyVrH+Nv+f9cz8XidC2d6zw9CRcn7tx9FswEjbe/sykZ3oRhEoMSFcUjLIEA/hGuwcH8tybGrfXme3xh7uXOMlyvCAsXum9/NoMqtjnrliL1RhsoRmR/vW+T5L+dfPUhQeAGE9AXJ5SON2mglKU+vDl0JwNQypwY3OUVQDs0ioDGA8FYk9+Hsy0QD9G7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc0C9wwktVepg8mewITeOEXgl3j+xEoqkQq/R2oyZD8=;
 b=TioRf0oRf6si9AoK6ExoAVbYrNCpLH1yvHupXYOYPp/C5KwgVdASljCFa207tX1eE1CODwM4msBehB1XoNUABKXT+YFa4xd34+2LrUh/zkIEd6vN/B6RYoGhaWmaO/yHSpF7jhr9A0zvj2nosr0ztbm+0Ba1TebcOquKU9AEfusgA35Fe4V71dkQgNoHFuO7ON8O+sDYiDjlSp4fTCZkBmZJ9q4pZ9MZJJLG7Pq1u+/rX8J8UGmqPDx/6CQbzCb6BvTpQFZ6lTzwE3nH8oPiUPMRUM7lMnDYBZEVOOfY74IjfF/P8H08Ffmkn9muC7RDB1+7J8DP7Kfg7wUgCyHong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc0C9wwktVepg8mewITeOEXgl3j+xEoqkQq/R2oyZD8=;
 b=Shr01IU07lHIT5JmpaDwiG6iaFspA0UDNRtaV7f/E/61Y4cJvRwGGqFmOQscISNymYEYTNbDFAjdmjsvOOL1kUknTYIbE9HHvCdGp0hskhQV+UEFwqN8cZsLstK/cZLNlMoUKVOOi8k9x4ciACLLand/3MZReu9XHdtwq/u/LLyoj0/7DuXHgJCMMEWSTDLDvSZ/VJlkiJIdxDjk5kCI77KVEDILfPqvEtQdskyYDwv1j2FrO3KPB+MfRpm7dJ2lgw2MmozmuRWH6AzBuzBYiLXgSfxSfHTOdV7xQWxVjl6kT9d8g3q18lGOWTVZvFmvVJKVX9JHxCGx8UJHkHC9ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPFE7189E232.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::49a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:44:58 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:44:58 +0000
Message-ID: <84d9beb2-85e7-4fc0-b403-0514bd87ae8b@efficios.com>
Date: Thu, 11 Sep 2025 10:44:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 28/36] rseq: Switch to fast path processing on exit to
 user
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212927.058801648@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908212927.058801648@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPFE7189E232:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a674fcc-9573-4e9f-ec8e-08ddf141c7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEhrclE1aldNYlpLYm11eHVyQUFNV2N3cDVVUmxDd1NkemFGQlZVSU10YzNG?=
 =?utf-8?B?bWVLQTRmWS94NUVuOFljOXVqWk83bkdCY3NpZXhZMmJrSGdYNEZxVjVNU28r?=
 =?utf-8?B?ajk5WURPMTZEYXUxTkVJMkljV21RbnZjV1ZhVjRUWGRSaU9oS1gvZ3htRWV4?=
 =?utf-8?B?MkVRM3JFNmViVjVOYUdJUHowbXdVc3RuZ01aTmpOK3pYS2l0NXlzKzQxYXov?=
 =?utf-8?B?Y3FOaGtpMTV5ZVdyNEVXWXdFQ1dIL3BaRHJpWmt5ZGpNSzdHTG1mK1pRcUU4?=
 =?utf-8?B?L0JYOTlIcTZBMTk2UFJSaWJSbDgrM3lhZHZpTno5YndFWjNtWTJ6Q0g0ZmJz?=
 =?utf-8?B?ZjlrWi9kVERkdncxa1lLeklhcm5qREVGZ3JWUStOU1pOVzE5QWRSY093RkRk?=
 =?utf-8?B?amcwUGxnU1dSdGNGak9rS05WNWFteEdrK3UrZXY0b3lFa0FIRWxGWHViQ09D?=
 =?utf-8?B?MHBQVWhRWXdFenBEbTN5aTZnMEEwR2d3cjZJeko4WXNONXF1Y201bXExZGtL?=
 =?utf-8?B?ZlYrZFI0ME5lVjF1eE5BOVVUZHJCc0wrbmEwVGhyTVhJblcvbGc5NEh0Yk5R?=
 =?utf-8?B?MzVTRTBhLzhRRzhuUks3WDlBZzJVRkRvWVd0V2N2K0x4bk5qcTF3eExoWmxa?=
 =?utf-8?B?NC95WVNRSGhQQmlGTDRUcXpvT3pSWGgzdGYxT3JjLy90T0ZyN2lDMnZpN2w5?=
 =?utf-8?B?bXV1S0VlTXJGSHRmcitCbHhIMC9YTEFPUERubTF1ZGkvckVuaVcxMTgvNmVB?=
 =?utf-8?B?OHliTXJuVlJXTVZyQ29xZjBpRy9TWUI0SkpNR0I1Z3l1VFAwRm16V3BRazkw?=
 =?utf-8?B?TWptV2pkSlRNaWx4MjBmbXVwaCt0WExyT0c0VCttNndXbDQ2U0RqNkFUaTZM?=
 =?utf-8?B?SjVXMlBnR3ZqREM0dDE2ZWxXK096Z3pyOFVVZHRjT2ZKa2hyTTdraTNPMXBa?=
 =?utf-8?B?RGJNb1piWmpYeTZYdVVLekw0VmRZaUc0THhtdFhRbG9BUUVFQ0VnMGRnaFAx?=
 =?utf-8?B?ZngrTVJ4S2lUWnhUTmhxSk8vUDdsVWJyOW4ydXF1czdEODU3NHFSaDJ4U3ZY?=
 =?utf-8?B?cTNSRWRiaU5EVVhGUnUvdFlOSmM3MEJ2Y0JqaS9kQU9FT0dKR21WQ2xWajJv?=
 =?utf-8?B?NmlMbzh1c0l2VjV0SVJlK2ZDMkZKVlZKdjFjYnllU1lmbmx0dUorMGRrZFVE?=
 =?utf-8?B?dDdtejRiU2JFL1hHQmVXVDhuSC9DaFZvRFVPclNXKzJvVkxjNTQ2cHE3bXFG?=
 =?utf-8?B?UW1ZaXdnSC9CNHZFOGRKRHdiRlRRNWVaN1laMC93d01sYWphQXVUdEVPYmNh?=
 =?utf-8?B?VFNOcld4aWF6WTJzRCtIQ2hBM3pzTm1NTUtGTlNac0ZRUFRVQjJvMVRxamZK?=
 =?utf-8?B?UTVSU1BlVnlIV0ErNnpkdDdDYUhqSlhWenFQTmI1enpqRFFMQ2x1dmJIWTNr?=
 =?utf-8?B?c0V1WjNXRDgwUW5qeWtDbk9hRStoWXpTVjVQUFR2WldnNUpJL044K3hBL1RT?=
 =?utf-8?B?Rm5QbVBteGdhcVpoUmw1MzVneVNNYk43dU8ybExGeDlMeFZvSGlYN0xZRDJD?=
 =?utf-8?B?UWlicGhYZ2pselpQK1NZRnBmenJHTUc2YzJIWFRsOXN6MW0wODFFbEwxZDYr?=
 =?utf-8?B?WlVuTnhmVDJhTGQyZGZsOThCNHBUcWNWUmlIQUVXQlVDZGU0ZE1Ycm5Zc3dB?=
 =?utf-8?B?czdPZEorZkI0d0ZpMHV4VG5RaUtqa05KNVY0dVFheXBhSklYSytBdXlORktB?=
 =?utf-8?B?cnFsbm9nSmo2M05NVGc3NGdIN3M4R2J5OGMrbzBNWXZOaFl1WTlNRXphVEYw?=
 =?utf-8?Q?uvOEla4hed9CYZ8XwmYOCo0hHkwUV+f15FY0U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjVDSWJBRERWVjEzT0ZVbWNUWktnNzBCMUNJb2ZkSnZiVTh3bWkxNndza0F1?=
 =?utf-8?B?R0NTbHBDSFlWZFdpK2lKOFNUOFBuTkNZVXlCeUIrZVQ3U09Ja2RMcjI4a1pu?=
 =?utf-8?B?bDNpQkxMdC9HbmE3YUdPcVpjWVRuZ3kyZmVhQXJvbUFJdjN5N2cva2tXeHMr?=
 =?utf-8?B?cnJpRERFR2duWWFVWktEdEE4Mkd3OVlvODBGb1UyR21oM3VIRHo5S2hIYkE0?=
 =?utf-8?B?ZEl0WExhdVdHUjdjcW5BdG9kZ09RZm0zeXQxbjk2RWtXVEw5eEtxMndyK0pT?=
 =?utf-8?B?Uk9qTVBIYVRzbjR0eUFlYjNjWjk3Yk96YXF2UTJraWF4QkF1b1k3bk0wSWVm?=
 =?utf-8?B?WFNXQ2d3ME1XdWxGZzJqT2ViZUFmdlM0dTRQWnhFUHNWVllVOEF0SHpkajVB?=
 =?utf-8?B?amg1MERNNGxDdU5tdjhmeERkQmIwS1BCQXNWMm1uTGppeUFxdHFiMlRvRmNF?=
 =?utf-8?B?TzJNTEZZVkdMZUlQZXc1NVBlWXVTWHpydGo5aGcvdmcrL3p3VmxGa0xaL2Nl?=
 =?utf-8?B?d0twbjlTOWRYY1o1TWx5T0dqU1Urd2RCMGUyMTlEQzFsaUJHYytmZCtOUVlG?=
 =?utf-8?B?ZUZoYU5IcG44K2ZjcEtaUi80emEzN241R1c5dlc1bVVzcXZUTGhtam1xTWZh?=
 =?utf-8?B?ZDRTb3hiRzdGTVRuaDRpL002elRVSXBBcUN4N2l2SDlGbmFacXVicnQzZjhE?=
 =?utf-8?B?TVlaUTB0Q2ozV3NLQnFjd3dIR2p2RkFGY0VNcWkzZ3JibXFFQ3JQS2JYV0xS?=
 =?utf-8?B?dGozeWd0RFFvM29FU25kQ3ZEb1Z1V3hFRUVKNktEK0p1TXhhYUdCL0lYckFR?=
 =?utf-8?B?ZFgwbWZ1SVR6N2QyNjBzb2tjOE1pZXIwMkp5V0tUejNwcHBlYXNDc21vanNh?=
 =?utf-8?B?VWZoeVYwNXFLZGV6V1hGNGxCYm9LZnI1WEo4dTR5ejRyc0ZuSmVEenA4WVNW?=
 =?utf-8?B?SElqSVU1c0QwaFBWMlFBKzJHa1ZOc1QxQTZBYWdPM28xQVRHNGVleU1tM3Q5?=
 =?utf-8?B?QUQ1SlR1ZXRYTnhoeFVPZ2lGQXBKVDlKY2xGV1FhWG1BNjJBN3VMVVYzeVA5?=
 =?utf-8?B?Z2phTlNYSFlRWEE3d1hVeEw0YjFTMTFqNjRHTm5aQ0hzdVFrc01JNFYwYlQw?=
 =?utf-8?B?SXhkRXVWMTJTa3NtWVlUdUlONXFaeGNHcEZITnlyTElZRGhBNnZ5WVhCbzVt?=
 =?utf-8?B?Zy9Dc1FMazdWUDFGakZUSXBmcXI3VmE0bEJvR2J6WEtFclJFV3FZM25nT3pp?=
 =?utf-8?B?WnlseDZFVkFhNmVILzgzbmVpYmhxUDdIVmJueVJPMmpOY0Rwbk5KdUp1dXp3?=
 =?utf-8?B?elJ6TnluekFVbFA3ZXhWbVVSWTZaQTBjMFBCaTJWTVo5TE4wTnRlV0NWMDYy?=
 =?utf-8?B?dVp2RkdQTUY0UWpJMGoyTFdwK2g3VUo0TnNuWDR0aVl4dFplak5pN2Z5SDgz?=
 =?utf-8?B?N1dzVWNUdjBxUysvd2xsSm92VlNIWC9OeUdkN1JMaEZwcDNyT3pzTGwwSFpj?=
 =?utf-8?B?eTRCQWRFOWRNUEFjeFFQY0pwRzZIcVQ0MEFUUU9Xdy9TQy8wd2g2TkVlU2dS?=
 =?utf-8?B?c0RiNEN6NGwzYmZwU3JaemxIOStXMWZhak01SGF5bzMrai84S2t2NG5Td09K?=
 =?utf-8?B?NUJjWGRHRitHZzZSd2dHZ3JpazhMYytaRG1CVXlqNVowY0Y3bUJ2STNkM3JR?=
 =?utf-8?B?ZjROK0hXR25leWQ1S1R6ZTBtaW1BMHVBYVdGYTl3b3Fkc1JjSis5M21nUjBm?=
 =?utf-8?B?TEYxcGFmT3hwa0xGVVNIS1hLSVdieG9rYzhYTko5WUU5UnRWNXNQczNrL2tk?=
 =?utf-8?B?THIybjNnTExFSzlWUklLa3B0WHBud25kMFBwcm5YSjJYQjdzU3NIU0dUdDlG?=
 =?utf-8?B?TEtJZUh1ZDIxaUhweUtHSE1RN05SUFVrd2RkbFIwNkNLeE9QMzNWRmRDTDdz?=
 =?utf-8?B?WXpyM2tENGpzRmVualdDOHJLNmRPSXpHK25oS2J0d0JQWG9HWkdubEY0emYy?=
 =?utf-8?B?ZS9nZ1pweHl5RExwank2WDlBQStndnFiNWF0MTBEUi9OOUNoV3JQck1Md1dB?=
 =?utf-8?B?VVhzSFpxWXdyc1hHMlY5Wkc5djNCREtnZFdIamFpMm52WVk5M1B0N2tyMm85?=
 =?utf-8?B?MktGREc0b1hSWHNUOTl6UGRPZEtDdERVaDhPNmc3TlhVNS9DaWlRUThZMjFn?=
 =?utf-8?Q?oZBqaQq1yp3QiKXWYxndol8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a674fcc-9573-4e9f-ec8e-08ddf141c7bc
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:44:58.4238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvzTrq9nDqUQQHeP6vQmr5iTu72g2P5lFaRm4dy5ZDLq1FuabLI1NhTfgl+VEJS10zb9v82XFzVW4U2jWTziShK1qokGB/ykjKZcofFcMDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPFE7189E232

On 2025-09-08 17:32, Thomas Gleixner wrote:
> Now that all bits and pieces are in place, hook the RSEQ handling fast path
> function into exit_to_user_mode_prepare() after the TIF work bits have been
> handled. If case of fast path failure, TIF_NOTIFY_RESUME has been raised
> and the caller needs to take another turn through the TIF handling slow
> path.
> 
> This only works for architectures, which use the generic entry code.

Remove comma after "architectures"

> Architectures, who still have their own incomplete hacks are not supported

Remove comma after "Architectures"

> and won't be.
> 
> This results in the following improvements:
> 
>    Kernel build	       Before		  After		      Reduction
> 		
>    exit to user         80692981		  80514451
>    signal checks:          32581		       121	       99%
>    slowpath runs:        1201408   1.49%	       198 0.00%      100%
>    fastpath runs:           	  	    675941 0.84%       N/A
>    id updates:           1233989   1.53%	     50541 0.06%       96%
>    cs checks:            1125366   1.39%	         0 0.00%      100%
>      cs cleared:         1125366      100%	 0            100%
>      cs fixup:                 0        0%	 0
> 
>    RSEQ selftests      Before		  After		      Reduction
> 
>    exit to user:       386281778		  387373750
>    signal checks:       35661203		          0           100%
>    slowpath runs:      140542396 36.38%	        100  0.00%    100%
>    fastpath runs:           	  	    9509789  2.51%     N/A
>    id updates:         176203599 45.62%	    9087994  2.35%     95%
>    cs checks:          175587856 45.46%	    4728394  1.22%     98%
>      cs cleared:       172359544   98.16%    1319307   27.90%   99%
>      cs fixup:           3228312    1.84%    3409087   72.10%
> 
> The 'cs cleared' and 'cs fixup' percentanges are not relative to the exit

percentages

> to user invocations, they are relative to the actual 'cs check'
> invocations.
> 
> While some of this could have been avoided in the original code, like the
> obvious clearing of CS when it's already clear, the main problem of going
> through TIF_NOTIFY_RESUME cannot be solved. In some workloads the RSEQ
> notify handler is invoked more than once before going out to user
> space. Doing this once when everything has stabilized is the only solution
> to avoid this.
> 
> The initial attempt to completely decouple it from the TIF work turned out
> to be suboptimal for workloads, which do a lot of quick and short system
> calls. Even if the fast path decision is only 4 instructions (including a
> conditional branch), this adds up quickly and becomes measurable when the
> rate for actually having to handle rseq is in the low single digit
> percentage range of user/kernel transitions.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V4: Move the rseq handling into a separate loop to avoid gotos later on
> ---
>   include/linux/irq-entry-common.h |    7 ++-----
>   include/linux/resume_user_mode.h |    2 +-
>   include/linux/rseq.h             |   23 +++++++++++++++++------
>   init/Kconfig                     |    2 +-
>   kernel/entry/common.c            |   26 +++++++++++++++++++-------
>   kernel/rseq.c                    |    8 ++++++--
>   6 files changed, 46 insertions(+), 22 deletions(-)
> 
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -197,11 +197,8 @@ static __always_inline void arch_exit_to
>    */
>   void arch_do_signal_or_restart(struct pt_regs *regs);
>   
> -/**
> - * exit_to_user_mode_loop - do any pending work before leaving to user space
> - */
> -unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> -				     unsigned long ti_work);
> +/* Handle pending TIF work */
> +unsigned long exit_to_user_mode_loop(struct pt_regs *regs, unsigned long ti_work);
>   
>   /**
>    * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
> --- a/include/linux/resume_user_mode.h
> +++ b/include/linux/resume_user_mode.h
> @@ -59,7 +59,7 @@ static inline void resume_user_mode_work
>   	mem_cgroup_handle_over_high(GFP_KERNEL);
>   	blkcg_maybe_throttle_current();
>   
> -	rseq_handle_notify_resume(regs);
> +	rseq_handle_slowpath(regs);
>   }
>   
>   #endif /* LINUX_RESUME_USER_MODE_H */
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -5,13 +5,19 @@
>   #ifdef CONFIG_RSEQ
>   #include <linux/sched.h>
>   
> -void __rseq_handle_notify_resume(struct pt_regs *regs);
> +void __rseq_handle_slowpath(struct pt_regs *regs);
>   
> -static inline void rseq_handle_notify_resume(struct pt_regs *regs)
> +/* Invoked from resume_user_mode_work() */
> +static inline void rseq_handle_slowpath(struct pt_regs *regs)
>   {
> -	/* '&' is intentional to spare one conditional branch */
> -	if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
> -		__rseq_handle_notify_resume(regs);
> +	if (IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
> +		if (current->rseq.event.slowpath)
> +			__rseq_handle_slowpath(regs);
> +	} else {
> +		/* '&' is intentional to spare one conditional branch */
> +		if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)

Ref. to earlier comment about has_rseq check perhaps redundant.

> +			__rseq_handle_slowpath(regs);
> +	}
>   }
>   
>   void __rseq_signal_deliver(int sig, struct pt_regs *regs);
> @@ -142,11 +148,16 @@ static inline void rseq_fork(struct task
>   	} else {
>   		t->rseq = current->rseq;
>   		t->rseq.ids.cpu_cid = ~0ULL;

As discussed earlier, do we really want to clear cpu_cid here, or
copy from parent ? If we keep the parent's cached values, I suspect
we can skip the page fault on return from fork in many cases.

> +		/*
> +		 * If it has rseq, force it into the slow path right away
> +		 * because it is guaranteed to fault.
> +		 */
> +		t->rseq.event.slowpath = t->rseq.event.has_rseq;

I think we can do better here. It's only guaranteed to fault if:

- has_rseq is set, AND
   - cpu or cid has changed compared to the cached value OR
   - rseq_cs user pointer is non-NULL.

Otherwise we should be able to handle the return from fork from the fast
path just with loads from the rseq area, or am I missing something ?

Thanks,

Mathieu

>   	}
>   }
>   
>   #else /* CONFIG_RSEQ */
> -static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
> +static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
>   static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
>   static inline void rseq_sched_switch_event(struct task_struct *t) { }
>   static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu) { }
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1911,7 +1911,7 @@ config RSEQ_DEBUG_DEFAULT_ENABLE
>   config DEBUG_RSEQ
>   	default n
>   	bool "Enable debugging of rseq() system call" if EXPERT
> -	depends on RSEQ && DEBUG_KERNEL
> +	depends on RSEQ && DEBUG_KERNEL && !GENERIC_ENTRY

I'm confused about this hunk. Perhaps this belongs to a different
commit ?

Thanks,

Mathieu

>   	select RSEQ_DEBUG_DEFAULT_ENABLE
>   	help
>   	  Enable extra debugging checks for the rseq system call.
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -11,13 +11,8 @@
>   /* Workaround to allow gradual conversion of architecture code */
>   void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
>   
> -/**
> - * exit_to_user_mode_loop - do any pending work before leaving to user space
> - * @regs:	Pointer to pt_regs on entry stack
> - * @ti_work:	TIF work flags as read by the caller
> - */
> -__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> -						     unsigned long ti_work)
> +static __always_inline unsigned long __exit_to_user_mode_loop(struct pt_regs *regs,
> +							      unsigned long ti_work)
>   {
>   	/*
>   	 * Before returning to user space ensure that all pending work
> @@ -62,6 +57,23 @@ void __weak arch_do_signal_or_restart(st
>   	return ti_work;
>   }
>   
> +/**
> + * exit_to_user_mode_loop - do any pending work before leaving to user space
> + * @regs:	Pointer to pt_regs on entry stack
> + * @ti_work:	TIF work flags as read by the caller
> + */
> +__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> +						     unsigned long ti_work)
> +{
> +	for (;;) {
> +		ti_work = __exit_to_user_mode_loop(regs, ti_work);
> +
> +		if (likely(!rseq_exit_to_user_mode_restart(regs)))
> +			return ti_work;
> +		ti_work = read_thread_flags();
> +	}
> +}
> +
>   noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
>   {
>   	irqentry_state_t ret = {
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -234,7 +234,11 @@ static bool rseq_handle_cs(struct task_s
>   
>   static void rseq_slowpath_update_usr(struct pt_regs *regs)
>   {
> -	/* Preserve rseq state and user_irq state for exit to user */
> +	/*
> +	 * Preserve rseq state and user_irq state. The generic entry code
> +	 * clears user_irq on the way out, the non-generic entry
> +	 * architectures are not having user_irq.
> +	 */
>   	const struct rseq_event evt_mask = { .has_rseq = true, .user_irq = true, };
>   	struct task_struct *t = current;
>   	struct rseq_ids ids;
> @@ -286,7 +290,7 @@ static void rseq_slowpath_update_usr(str
>   	}
>   }
>   
> -void __rseq_handle_notify_resume(struct pt_regs *regs)
> +void __rseq_handle_slowpath(struct pt_regs *regs)
>   {
>   	/*
>   	 * If invoked from hypervisors before entering the guest via
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

