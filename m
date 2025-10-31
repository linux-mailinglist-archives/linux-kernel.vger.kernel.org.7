Return-Path: <linux-kernel+bounces-880460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2231C25CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE1854F6504
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA82426ED24;
	Fri, 31 Oct 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Bq4YV11N"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022096.outbound.protection.outlook.com [40.107.193.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D4258ECB
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923647; cv=fail; b=MUbksq+gqtyOCY56HQKsB+CVwhQNJK19DuwbwHAhtbumXyycFWKjwrX3WZHwLB9XvF83emOZNLKPIXBIGnO7vrS8Kpq+Q9mjDKn23nTQK+7ymCEEUXqCecdJKYR4NN476L5fO6LZA/nCW4ixwcS7FwmldiPN/6x30vmvD3gIBIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923647; c=relaxed/simple;
	bh=Yg3xCjna+WztywX2fxG7vda8nELKnmgkyx8oAyKZXzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kf44v/vlvPpOBLm1yGb+ieJNLm/5/TWmAIm8GzJMEK4jLcxehH4sI0lQTbJiHwZVyHy/hfccNgPbY6uwy7Kmy1SWjiJbclTwcN7EcWgJLUK5Ub/zkplqWHbCHTzu6+ZYbOkGEcjYGzLRvBZs3hJIa4f0+TkLF7GHTZ0v3g7KPCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Bq4YV11N; arc=fail smtp.client-ip=40.107.193.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUWqfpEgRvzJ7M//oQYqPW2qe0vHS1ZnRF9a/4FZmYG8HSNTGbksmQBIt8+y1VRafAgoJ5SKoAUFlgO+VeyTM7V8i8ixIqh9nTPzuBRtjiiuWc6kWrX98+jpZMVcCd7bhIjmNoSd1iIlqBQFTiQNPyvJEvAC4bCTkb4M9XKI6YoF4NMJ8viuhKKcm9IwYptlXVlfNNDq9FIfH5RWcEAGqt+zLXDiv5ZBcM30tCRzqO8xQyAJRZg2wKI3hfP68MvcRpfMCU/xRLKUAjhnOjkitqzTtGh25xgTqiITtK+CKRRUA4CMUjEPc02xaS1IGhLLkDpEKulYeWEf2PGrDoYCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLbtABjzdZ5Ty2Ja5X82uvbUlpsFSXYem7vmZQYXMXA=;
 b=JVSjIhfhAo7OoczFgZou208FotAm4ln03eGRsAQ9Hz8REN48R92/kQl3XURwFx6bCM2LMbuUo6R/VlBGA0xTejSjdpebP2sfw0uxdKDzkJY2DkthWEaUP2ZXrG33+e6WTuwJ8Bdx4NvIigeXlfUCHHXazY74gfo2Tv9UDMrOTEZ6HUvLeWPwpvq2EpbENLnqBNwnv2NnzjasWbxhm5ffN0KWowqkYSo1PfAshBTOWcBnc86WGr5Ih5M8Ve5zDHihMhFALteEFNBqz4oxkgZC9GVBsmzcCAhhRgn9uts6yWnEERcay3583FDcqI+tgOPv5aI1q3Z5XWQv0B292E83Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLbtABjzdZ5Ty2Ja5X82uvbUlpsFSXYem7vmZQYXMXA=;
 b=Bq4YV11NFAaVqVbioP76GMmLlgGhJHHgxaaG4z2cvRUFDlf0haYfYxS8mUufguZBlvmNvCyCUaxZ+qfKa4n7NtbhWCiktV59FDOUxr+tvD144zgt+/jrP4OhxtIpfuMQIxdHR5cFPIOLqr7jLgcbiclJR230rUPwD5x15HAA17ssATcFmU5pix/inoj82hCzxuJbdQxGp9fH89/EpEaI09qVlPPc3sdJJMtFUSkdb+JgG7yr863K30ZrmEnx9Seuw9udiH1FMp6zrCF8qRdwoJFsO4ycK3Dhn9V0h47bqgldWF/qC23HfnIdL9y3IAqLE33wmjwVJkpgiawqGUNPpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10819.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 15:14:01 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 15:14:01 +0000
Message-ID: <8147a016-2dee-49c7-87b6-dcefd410b6f8@efficios.com>
Date: Fri, 31 Oct 2025 11:14:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 13/20] sched/mmcid: Provide precomputed maximal value
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.098047550@linutronix.de>
 <36caa866-1f22-4825-aaf5-6e4d2629a4e2@efficios.com> <87zf97rtyp.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87zf97rtyp.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0472.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::15) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10819:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fc35f0-00af-4106-6e8f-08de18901f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHBmdVh4N3Vpc2RDampCSTFaZ09FMkxGQ05oOHI1OFVUbjVGZGR3RVI2bUdu?=
 =?utf-8?B?OEZTdDY0aCtJWC9vYnJnTEJFSGhsSDErU1VCRW94Q2JHaFZwZUJ6QlR1LzNa?=
 =?utf-8?B?cWVneUU0TzFRMXpzaUhkd1ZHdng2Rlk5ZFRIL2h0N3FzWm40cUJPclloQURK?=
 =?utf-8?B?UlNCd2ttcnloV1F5OXdWbVg1MVYrUVUvLzBjTlFrNUlxbTR3SGEzWjBOZWxV?=
 =?utf-8?B?aDhuaUhxUm9BaStUZ0VxeW9WUGRsQ2EzdjJ1eDk5a3FVcjJoV3RlNjVJYTlS?=
 =?utf-8?B?dk9CNFUxR1lwckVrMTdpdHZWTVlWcTZHclJDS1NjYytQanBTVWJQUVEvYTdU?=
 =?utf-8?B?K3BacExhdEptT3Eya0lITGRHcEJiRGlvTS96Y0hIaTdIV1ZUWURycU8zcE85?=
 =?utf-8?B?M1NaejVDTFpsSzZpVzRhZVA5aFVuTHRQZHFxVXRSMkNiQnhTbCtuQ1hTSWRD?=
 =?utf-8?B?SnpTWC8zajAzUWdkamJzQUFuenY3UzErZUE2bXRCK05oWXl0RzVPano5eG51?=
 =?utf-8?B?c1h1Y2FBeWdwVk5sRkV5bkpSZTJXRlAycUlKZEdOU3NQTGlEWWJnRzh6MTBY?=
 =?utf-8?B?M3QzQUpKSElRVytSTk0xME1UUk9IcS8vUnhjUEc5aUgzRUhKaVVHUWxjV3JZ?=
 =?utf-8?B?WFd0alZRcjlUaUhWeVhST2Via0pHZGFpd1FwZXRHTTBwSWRUVFNrSFl5V0pR?=
 =?utf-8?B?VFNWOGpWZHlzQTJWUE85cm9GSmZJRXFkdk9rSUQvMmlCNHNVL2NvaXY4VFQx?=
 =?utf-8?B?NFc4QU4vU2ZKZ0lhSW9IWVdvWHg1N2hxWlhYcGlWWFFBQWVqMWUzY1pBZGdS?=
 =?utf-8?B?bUlXbkFZTXhSUnByL0IrVHlTYTAzQmpyVlNET2JGWkRJSUt0VHRocUUvZVE1?=
 =?utf-8?B?WWFpbmNPWGlKYVphbFRkRjdCR0sxaGYvRnZhVGVEanhsM2RPWjE3UW1KeU9j?=
 =?utf-8?B?VFdVZXlJT3JDKzJxZmJiekg5bHBsdzdGNjRsNHFNSTNqRDA4cXoyRm1FTURl?=
 =?utf-8?B?NFcyak02TnQvdEZUb1lwUE5WZXRteEhMUlFUQUJDVGROTVpZME9rdDBSNjF4?=
 =?utf-8?B?cVdBSGRtK0xzbUd2OGpJeFgzSWdlZ0xuVW1XL1BEZVI0QlFXWCtWaWlsYUta?=
 =?utf-8?B?eXQ4UWdQTTcyRERCTmY0bitNWXhYbitZckswMkhITVJMRkU2aUFjd3l3dXkv?=
 =?utf-8?B?b1AvWkJqbFpoYU4wbTIvVWtlNHBPYWlzM25yU2JTbmJUNmNzNDRqOTZHNFZP?=
 =?utf-8?B?UGl5OGtKSHY0ek11U29LbGcyOXhvRnpoai9VaDhzeVE3ZlpDMVM3cjVRZnVD?=
 =?utf-8?B?YU1nRGd2NjlNSFJrTnF2V3VkM1U3WnZ5MW04SkVFYmVJbEpBWjNIRDUzcTB5?=
 =?utf-8?B?QjYvbW1GV0Fhem9vdGtvd0ZvZVdFSDdGcEs3N2FQb05XQzhMamdrRWZzSkhl?=
 =?utf-8?B?bGhkUndzTW5GS1VDWE1iNEF4b2tCaTN0bzhVcEJUMUJ0c0VUZnRoanR4d0NV?=
 =?utf-8?B?MzgxRDh1ckFYS2orVkk4SEhFZy9Cd1ZEZXNPWVNYSldUOHRBYTJTYWIwcnhH?=
 =?utf-8?B?NCtZeCtCOVkwZlUzN0E0akVCQytrdjQ5bHZ3YmliUGVRMFFSWjM3UTdPS25p?=
 =?utf-8?B?Q2hCK0pOTGFkdnR1OUdEc3o3dGFjS3Z2VG1YVEV2UXovN28wNjhzc2ZlOUVk?=
 =?utf-8?B?L2IxZDNVU1VWTkNYaGhEcG5TTnFmck5LempBazZhbDJtMXpjbXJTVW1tUVFu?=
 =?utf-8?B?bEJLcHZhOU5XdWpyb0dKV2xDNHR5bFB0c2FrMW5rN0ZoMUU3S1grVUNJeU42?=
 =?utf-8?B?WU9HL21IZjQ1c1d6YXNIVUJaaHBGQXcwNmo5SW1ZQTFlT0tmMHZyYTF2MTlq?=
 =?utf-8?B?a3JaalZXNzVwTzNFQTVubHUyMnorVU1zUlFmUlFTeUtpcUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REhuVkl6dUw3NGZuejVrMzBNZmhEVDRYbEVSdG13SnpsbjA2eGxlMmE4Sk9l?=
 =?utf-8?B?Q2EwSlJ2T3F6eVhYVVhBQmk2UE9HckZOQ294UmdhbGpJWVVOT09zRTdhRm5q?=
 =?utf-8?B?L0hKVUhGeExsRC9MZWFobUZibStFRDg1dkVQdEhlc1VmY2c3UTZET08xdUxG?=
 =?utf-8?B?RHVCcVlobUwvTFFUZlBUN0NaMmlldzRJWnNmZ0cxeGxLOGQyYlZ5WmJIOXpq?=
 =?utf-8?B?SGpDcE9vRmFkbVF4WFVwMlhrV0FkYlhKVm1GNEV1cTAyVGRSYXA4TVpsWTJQ?=
 =?utf-8?B?TkpGUnI5OTVENCtPQ1p6cXorWjk1bUNia2piSU1OUVczV2xNN04vdmVDRUZQ?=
 =?utf-8?B?MTZ3ZFQ2Q09FbGpSYkJuaWEycUVpU2hxdGZTb0hMZnl2djI4VUY2L2JBOGUy?=
 =?utf-8?B?ZUJ4MVBiWWhQTkpHbFNlVWV1cURSeFdVeEU4SzlWNTlQRVV4V1dWemxOZ3hH?=
 =?utf-8?B?eVRvbjB3SEhQVDQxTlVQZEYvMWV5Vks4Njd0VkJacWpJVzZMaGZ6UTg2Wm9H?=
 =?utf-8?B?dEk3TUIrTTI3OUdMWUhYYk16TDM1TGxGcTNWRTlSS2FlNmU4dVFxeGtTY3Z0?=
 =?utf-8?B?UzN4UzJjN2lSY3FyMllETkZXY1E3Vm9iTmVsYUs4SkVoOVpYVmxuRkdGZHZV?=
 =?utf-8?B?eUtnSThCQzhxSllGMHlOaHdDN01iZWxYaVVCNHZhQUJ5RzFSOHFrVmxKNDg4?=
 =?utf-8?B?ZXNlM0dYUWNRWlVPaU00dXEvaTEvMHhrNmQ1MmlkUVJjcHFsV3crREJtd2Nh?=
 =?utf-8?B?Uys1K09uL0M4OE1GUXBoTEx5dzVUTkJITjBjM0dPcG1vd3RqRk91SEUvUngw?=
 =?utf-8?B?Y1QrZWJWbk9CdDVrVXJPL3phdER5ZkRUWmdsdXprV1VtMXRCdS9NTitBVS9Z?=
 =?utf-8?B?RFZVSHRQR2taQko1dUJibWYvQllpRHduZExrTWwrQWxBcDh5am1IK3dLZmFF?=
 =?utf-8?B?YmVYQmFkS1ZnWTlqR0R6WjBrQ2QycTRGUk5aRitxYnpoZTVMdzNjNXNob2Rs?=
 =?utf-8?B?OXM2dFdkdGc2L1RaWVd0MWI0ay9RYXAyQ3pkK0l4aU0wUkg2R2dXMTR0Q1lW?=
 =?utf-8?B?djNvaXphdmQzZEFQdFQ0TjhmSHdXWUFqVytZakkwamRNM0YyYUVmTDBYMVJ2?=
 =?utf-8?B?NUkzdXE0L1ZTQnRicGMyUW5DK1Vwa1IzaC9jNjdVV0ZWb0ZMSEVMU2dGK1V5?=
 =?utf-8?B?RDFWb0dVYjhmaTZhYjhGeVlKVDEwdTQ0U1RPQm41blNEVmxTcHJleGVOM0tV?=
 =?utf-8?B?ak1lSmxld3NPeHk5cFJ6NTZia1pUU2JzNHdrbXRrQ25FOCs4ZFJ5SWVzdFo4?=
 =?utf-8?B?VkRhRkFUQjRYQWo3bVl2RW9jTlNtalg5R2NEa3BkWXM0b0xBeWx1RHVSZjJD?=
 =?utf-8?B?b3RVVzlUaC84N0dCaFpibzh1Ulg2ZmJlUWNqWEJSdTFBaGt1N2FmdXpqY3ls?=
 =?utf-8?B?SHBIb05Ec25DUlZSNUhOc0t1SDdNTnNRQ3VuQVRVZk5vdFl2dDVrWDAxbmta?=
 =?utf-8?B?QzdMQWE4WWJpeXZ0QXI4cXhLeEdNd3pNOGZ3MFNCNWlQV3poclJQSFU2MUhH?=
 =?utf-8?B?bVBtc0t2emlVd3R2OVc4TjB6Y3RUZzN2Ym5OdjR4RGh2cHFJTzEvNk9Mbmpa?=
 =?utf-8?B?SC8rUU1OblRzN203cjZtallwa013TUNSMDg4Wk5DaHJVcUZHSGdLK0I2Y0p3?=
 =?utf-8?B?bkQ4REtUM25IMGdiMldJbXI3US8vUUE4SWE2SFJjWXZ6N0tpdm5DdUQxMGRU?=
 =?utf-8?B?U090OXVYV29OZFZqeGtqaWpnQ2pucWt6NlZ3ejZFdFNFTVkyQUdNakcvQTNu?=
 =?utf-8?B?UzhZTmJ3bGlOMSthWUkreUFKSkhvM0VnVWlDQXJVbXNCeS9seDFrREN6b09q?=
 =?utf-8?B?aEd4SXRjL0hpYVo2OGxqdGZQMEdGU2piS2tDOVZ6bDFDdzBabGNIWlJmbGtJ?=
 =?utf-8?B?b1ZsMlhjanBZZ1VPNFRSTmdHZ1Y0d1gyOU9GQ0dqckFmQXRGanVJVWV5U0h4?=
 =?utf-8?B?a3dqdjhDdGJlS21paDNRa1pZQkxZMUJmbXpMNGpLTi9iaVBJRzE3UW40eW9O?=
 =?utf-8?B?VlpTVkpqaWNnWEVMSVp4WWpRL2VBLzA5aFQ1QWdONHk2bGhCSGFCUEU4VlZS?=
 =?utf-8?B?MndISVAxd2pZRkRiWnQrbXNSeWxRNnZNcGV6NzVheE5Vd1ZncHlCa0dSdHF5?=
 =?utf-8?Q?Ek26liNWSErcSyGjwaA1GcA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fc35f0-00af-4106-6e8f-08de18901f42
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 15:14:01.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwdjZt2TzZd2gdO/bE6OLE4T5tGhxA8A/nu5SwXOHDtZQF9GzIROPz9Q/b/6JIEtpAbeY0ai9RyiserlOkucrcyAVl5UcqxF8g2ZTqxSi3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10819

On 2025-10-31 11:06, Thomas Gleixner wrote:
> On Thu, Oct 30 2025 at 10:23, Mathieu Desnoyers wrote:
>> On 2025-10-29 09:09, Thomas Gleixner wrote:
>>>    struct mm_mm_cid {
>>>    	struct mm_cid_pcpu	__percpu *pcpu;
>>> +	unsigned int		max_cids;
>>>    	unsigned int		nr_cpus_allowed;
>>> +	unsigned int		users;
>>
>> I suspect this reintroduces false-sharing between the "users"
>> and "lock" fields (updated every time a thread is forked/exits)
>> and load of the pcpu pointer which is pretty much immutable.
>> This will slow down accesses to the percpu data in the scheduler
>> fast path.
> 
> At this point yes, but when all bits are in place then the lock fields
> end up in a different cache line.
> 
> The false sharing issue vs. *pcpu and max_cids is minor, but I can move
> the low frequency modified members past the work, so it does not matter
> at all. The work stuff is rarely used, so there is no point to worry
> about the occasional cache line contention on that.

If we have alignment requirements on fields that matter for performance,
I recommend using __cacheline_group_{begin,end}_aligned() to make this
explicit. See include/linux/cache.h.

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

