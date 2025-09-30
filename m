Return-Path: <linux-kernel+bounces-837656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDF3BACD7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2994B3C0BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4ED2144C7;
	Tue, 30 Sep 2025 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kLJmOTT+";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kLJmOTT+"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98992110E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235459; cv=fail; b=aqr5oacuqAfXjuveATjXhvGmXP/8ptdRcztlpUxxGL/Bvb1b39nDreXqUal7xapZNwuPlCb23csfgfizgzPjcrQubhcV4WX1hhS5YeKcPf7N6k9+4ShDcQlLB6ATkvlOJxlROKJcvaorU0+voUltqHoGLCKhI2kET7/xo35Nr2k=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235459; c=relaxed/simple;
	bh=C0iLDzUdGBCQznjh78Q1Iw1uwN3A5Q0vVkSQSP/uL2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kkjKCL8ADhjFlC7VO3y+73K56IDuSNPZKsGkEnPoZoEsoVvoacK7vLzl6Dh/cpvf9F4t4UqQuKU/YJXj6bnmTuK0M4lFzvEfCK4JmqtaSqUmOuG2M8COcfWxpYGI/HMCe2rInsm9wLnq+owaA2co6UjqpK74DvAEHF90yf3CJtg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kLJmOTT+; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kLJmOTT+; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aQW2AFvh9O5qTl/JfCu44MM4kQI20Sf/9lBlglkcpJ05rIY+/KJhVQDyq9JUkzgKyDqBkQi0tMJ1izWmJ1Z45G/QirGCQ5MPAIl3QOdg7EMZYKZE5Y2ZDlcHbkV3ahnzjadBPRbA1g33IydCNW5eAABpwum9mwotlJ/5BgzjpeDRsr6+4Ha3RaXwj+u67wD0sggSJpQVN2BXRKTfO0cWobASvbrxwJvBrywjjzNKUCpAaW41jJ9qPY2u47RnY8CS2NM5xP9Wb+mSrX23GyRVNZKwHa4C2XoZ0Xh3N6k4rfVYpQeWaKZtm2oUlNaoZfx3ejHpqE+Gsd8xgY14vhIBoA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG23NiNaDNn8JC1ok0JdMFwJH44jyU+F2b0gkBa/jVQ=;
 b=DcPBBqXNKGw8V40y3staSgmed7Zy4cEjT2gddIWzUDoRUp5bjlCTi1O1ZI77y3aVfFpZt3OKwJt8tNE25i0caANqJwDh1tlRnjiwCIdJvRBpWYxJzDoFmv3WQ9oJTq3IxohkGcU/qpD3lJhkfBhruC+nKvsYiY7jmSbDJ+ouQdrxZNKYqqej7xjchSzykL+YulXTl63dbPkHfDMdDH5kEDWFYug9gwhRd9Rk/6bi5zKynJdhVRh4uzmlCuAEGGU2Jkx7p2HUkxAEnsHBg/ulhQlV/Z1dx0/IPkBSSRsKOCAwO4poFMVfCL/tKfGM70i9uxsHyA7NxE9HOIUGBmr7bg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=foxmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG23NiNaDNn8JC1ok0JdMFwJH44jyU+F2b0gkBa/jVQ=;
 b=kLJmOTT+vhw/IVgCwuyiFvG8ep5MKUVu7wuLiI2AsEQUI4hFL8OBFrUmC73tnaSHTthFscOWYZsyBbZ+7H/FxemXIRlraex7DVNEawgiyOjcgkg5+L8lIH1TRZypMSr036+zj22JqFs+2rSbQBPLAjvgPtAcuAEFYdJgjdFdNb0=
Received: from DU7PR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::8) by DB9PR08MB9442.eurprd08.prod.outlook.com
 (2603:10a6:10:458::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 12:30:49 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::cc) by DU7PR01CA0013.outlook.office365.com
 (2603:10a6:10:50f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 12:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Tue, 30 Sep 2025 12:30:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2m8vwl68uW400yamoVjCMuSwATy6Df2isoELis1G8rD3BwdsaxSUGKWjalvNOPaN3PjRmOLgPyxBKgnoHy0NTgSqxLp+q7WVV3ZyJlZZ147d+wwd8OcpYz8NEqLatrl8igqnXIc8xEXw4VnmMznOdh25yPflVAbZVQqPCjerBuTrtqJyk9+UGV2/Y8XCEJLYvDZIQsM2c/6JQOX3xzWNmSKN5XJYuukKKr9FItPO77JUuMRWkHPNMCQYgYD+9MY6EbvFlO1mfdBwkcU+/JxL6cBBEdaTFPuSpcB4smkvxeYSLnmbfYwo5V2d4iOIG12s+DZ5nY81ukOf+LttzJYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG23NiNaDNn8JC1ok0JdMFwJH44jyU+F2b0gkBa/jVQ=;
 b=CVQ6Y6QT5cWsKNQvnvtcowYQw02XCjzoWPm+/LbHBBrPJPIIc4aqWnvx5byodumU1eWA/tw8EIqq4YHjXqgRhMrI2kdL5GJNLeDA/6PYjIkc/5le112U4HhWP1vscnoF4Zo/ujlTYXdSZqIAoYRKuiqa0xDX+eneTAY8bQH9OBwyffZhqfHE04+noXiN7IHavzZuIFAav3eDhUg5mL/kRyZjizvzmrfxKy1OcbHchQXLRDUgtjz2ow1m5aUAmwSwSWZnyBHtp8t4evpp+5PUTXElCmrOkJEJoQkAK4OJk6kid1+WObXuhgJG7GjmR1RG3lhFB39vGSryvieC7p5GBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG23NiNaDNn8JC1ok0JdMFwJH44jyU+F2b0gkBa/jVQ=;
 b=kLJmOTT+vhw/IVgCwuyiFvG8ep5MKUVu7wuLiI2AsEQUI4hFL8OBFrUmC73tnaSHTthFscOWYZsyBbZ+7H/FxemXIRlraex7DVNEawgiyOjcgkg5+L8lIH1TRZypMSr036+zj22JqFs+2rSbQBPLAjvgPtAcuAEFYdJgjdFdNb0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DB9PR08MB6539.eurprd08.prod.outlook.com (2603:10a6:10:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Tue, 30 Sep
 2025 12:30:16 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 12:30:16 +0000
Message-ID: <ec925126-2756-4b3a-b311-5f50ffee58c1@arm.com>
Date: Tue, 30 Sep 2025 14:30:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix DELAY_DEQUEUE issue related to cgroup
 throttling
To: Han Guangjiang <gj.han@foxmail.com>
Cc: hanguangjiang@lixiang.com, fanggeng@lixiang.com,
 Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
 Valentin Schneider <vschneid@redhat.com>, yangchen11@lixiang.com
References: <tencent_3177343A3163451463643E434C61911B4208@qq.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <tencent_3177343A3163451463643E434C61911B4208@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR2PR09CA0002.eurprd09.prod.outlook.com
 (2603:10a6:101:16::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DB9PR08MB6539:EE_|DU2PEPF00028D0D:EE_|DB9PR08MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e173e5-a928-49dc-8627-08de001d2fa8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?M0MyWGNzS3RBY1JoVEZWRjVjQ01uaU9HRXh0ZUQ5TnNDRnJXZ2hFckdCNGFo?=
 =?utf-8?B?NHpXbG9XWFZZOU5YMWYxNVZtZ0NkdEhWTzlRdElaMDhDaUtWTkRUd0V4dmI5?=
 =?utf-8?B?aS9iU2FYWXdnWmRHV09Nc3huYWptTnNZRmRDdFRSNi82K1VWakVJNnNDaXB6?=
 =?utf-8?B?SHVoamNvc1ZESzl1cm5sTDRVTnhIaHhTSENsU1dYckR2OXBldTB0UkxxSFBa?=
 =?utf-8?B?aVJwb2lkaDRyMUg5ZFlxQU1LeGFVYTRZcHBhRDNKTU5PU3hHRzVIdmRzTjBN?=
 =?utf-8?B?TXVBcWZ1L0lVL1FuNnFvK3A1SVVNcHUzUGIrNWZWOE43dS9PcHhjZTExcUtu?=
 =?utf-8?B?MDI2ajFuVGM1V2xDTFVPSGl4OFIxREN3QjdhNnBtSVZWMmZsVjRWMWpwUmFt?=
 =?utf-8?B?UXg2d2YxYkRmNVVqQm4ySnE5R2dKNndieEF2cmRJRDdpRlQzZmRDMGhrWUxD?=
 =?utf-8?B?TGNPM2NwUTkrYTZVei9CU1dVVUFvOEd1ZkdTcVZzTTY1UzBhV0hKYXcxU283?=
 =?utf-8?B?UU91c2pHeVZ5bW80a3JEdkdEd1N6Y0lhbERnclRzRlB4K3oxZWV4T3A2QWRa?=
 =?utf-8?B?cUFJYWlUVEJJR01GdUw3SnFnbE5BTG9DMkoxTEdQUjladWFBY0JxTjhnU2hr?=
 =?utf-8?B?N2RaWmFROHVVRG41MkVCMkUyTTFHQWV3YUxhc3U4TGFBOUNiMHJpZm5pQThU?=
 =?utf-8?B?ZGtvaFhIVDIramRBSXNTS0dMWDB5UkZXdlcwSXNEblJNTmpJcGxXQm9CdTFP?=
 =?utf-8?B?ZzZZK3UvMXp0andrSEE1QlFBUE5HOERZVlN2N3JEOWl6K2owakN0cnJUREN6?=
 =?utf-8?B?eXU5MnBtczF6cTBwSDRKaHh3NEJQMWFKRVdualozM0JuQ1Yydm1hS21oREl0?=
 =?utf-8?B?NThVbG5pZTJlVjZIeGROaFRaK3Rvb0pVMGxoWm0vQTJtY0psSDJkZnVoRHBo?=
 =?utf-8?B?RE51V1VhREgrQ2s3R29Kc1lwNTBtem4zMlFZS0JpTjNXTExXMy81eXNXYm1S?=
 =?utf-8?B?Y3RMRGdaajJ6Rnl5N1VvYTM4UWpqK0dvYVdBSEZSWjlYUTFZVWVtaml6MSta?=
 =?utf-8?B?SXZheUMyRFV0QzVua3MzTzRxdDJmMVdvREUwdDNtTDF1UnNGZEhJOGxMbVUy?=
 =?utf-8?B?bGpJTUp4N1dSbUxmMEcrNDFZZTJHMVZMaXhORTFWZGNmTlZ2YTBOYjVEZ3FV?=
 =?utf-8?B?Njg4SlZjeUNPdzF2RU9hVFhOWnlhVXp3bXpSSktxaExOb1NUSkR1c1JONit6?=
 =?utf-8?B?MTJxUnEvSWRieE9sTExZUmlhcno5OWhrd2FweXRPZDVLckpzcWZIOER0Njc3?=
 =?utf-8?B?VWN0NEFrWHRLbVd5MWVlU2JDVkE0N2UrZmhEL24yMWtzQ3VsWkxUQ3BlT0dQ?=
 =?utf-8?B?TWZtYm1wVWNyMytIMmYzc2lCUWozM2p2V2d3VG5NMW9USThTa1dTM2tyT0JH?=
 =?utf-8?B?aHh3QzFKR1pDMEcwdEJyWFpwQmVFc2JRVmNsZVM4bFllMVJlb1RTaDVHL2t3?=
 =?utf-8?B?c0taU00xRVlMcG95UGt2Vm1XR3lQdGVRT09hSEZ0alFNRDlnb2NHUFNPN2VQ?=
 =?utf-8?B?bDBQSVJwUnNsTjlHYzZFTkpqSUFLbnl3SVZJUjRucDlveFQ1d2ZPT01BSTAv?=
 =?utf-8?B?dzN1Yi9uRkZoNnJsdW8zSWI1eW50MzJEaXRMa1JVdk5Temxka3kyNVFsaXpT?=
 =?utf-8?B?MjdyWUdOaWxjYVRmSURZWjVZRFlnbUlLcXZ0RWNTb3Zya3V0c2ljdjByc1hV?=
 =?utf-8?B?MmJvQUpVY3lHcFExRE9NWnN5VXV1b3lUd1RtcktuMWowbU9hbkduckVraXlV?=
 =?utf-8?B?MVVCNjJaQU5UVkRzMVVSKzR1aEV3a2QyeTM1cVFWRFkrU05PL3o4RmpQQksx?=
 =?utf-8?B?dG9rUTBRZlEyaDA2L0RXd0FZS1J0azBVMWRFN3Rsc3pSSU5oVkkwYjZSenNV?=
 =?utf-8?Q?gi/w4VT1vLyNxmGfRDs/sws3bdp4ftPX?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6539
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7de72c35-8ad7-43ec-8de2-08de001d1c2c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|7416014|376014|35042699022|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODdaMTNJQVR0ck1PQUdPcUxkYkxHblN6dkU4SkN6VVZpdVo0WnVoUmg1dU4y?=
 =?utf-8?B?QkladGlzUUk5NW9oY3d5SVdTc25DMTZ3dDJWSU9Dc21LZFdTYkNSZC9VUEdX?=
 =?utf-8?B?QWlyVTNubXhVTDdwOFZQYTBpVTdoZ3RBZXAzajcxRFVsQ0ZwOGRnZXNxUWE4?=
 =?utf-8?B?UnFsTTlCV3ZrdndOWktnWFRrMVArb0cxV2xUV1hZakZFZU5sOHE3cUt3eFB4?=
 =?utf-8?B?ZTIvSVIwVzE2YXlVQXljc1NycWZtSVFXWVc5WGlwSXg3UnZWa2grYXQ4bUF2?=
 =?utf-8?B?d0U2Ykt2MllXUXBRZnB3QW15REV4RXlZVTlPZUhhTjNwSlFlTnk5ZVBtdWpE?=
 =?utf-8?B?YS9aL0JXRjVCaDhSMld6SkxKMU1rc3Nsank1M1pwaUxmaUx2alhPV2pjWm1y?=
 =?utf-8?B?aDc2TFpBUnQ1R2hLZkF5ZVdJSHVRbWhSTmNaWnVpVldtVnYvL2FISjJtQlpU?=
 =?utf-8?B?ZHp5ZzdJc1k3VE5BaG9QTFlPaUEvV2dDZURxSm52VUhrV2lxSkJyVVZXMWg2?=
 =?utf-8?B?MHc5TURTSzMvclYrKzUwSUhQSGZBL2xkY0VXU3ZhbVRIQ0V1MFpFYmh6eFlv?=
 =?utf-8?B?Zkhvb0pZRTZrNHhsczZwSDFzeUxQRkd0bDN2SkdnN2pXSWtPUXBqK2NTWGR0?=
 =?utf-8?B?bkZQaTljam52clgxaDVVZGZFNFlua3hPWmgvbVg3Y2paTkoxQWNpVXd4OHB4?=
 =?utf-8?B?eU1LNzRRN2tHS2IwMGZYYytITXROUUZUODUvWjJWWjRCTlFxRTdidk91MDdB?=
 =?utf-8?B?d2d2NlNrZjBiR1F2d0dRdTFpc3k4SXpjejZMTmVtN2dNb1lOM1NGQ2JwRlFl?=
 =?utf-8?B?Sy9uSHVOZXRkYUR2NE1YdGVQblBNSWRyUng2c095NXlJM2VMeHB4Zk9vOEdw?=
 =?utf-8?B?cEpyWTN1RGFYbTcvSVRkV3RSUFkzTUk0dnIzK1IxRlhlM2c1ZG14UXVlT2pw?=
 =?utf-8?B?VUJhOEpDejZ5dlBGTHZMSjVIQ0lGMWNrcDVWWDVsM09SdE9HOUFJbUlTdDNS?=
 =?utf-8?B?S3VQc0UwOFl4QXZPbW41QTltZmcxSDF0UEM2RUw2aG04cVVIZHNMQXpnNXdk?=
 =?utf-8?B?bEluM3I2SXJnSzBrL1JTWWRjK0kxRDNybkxIemlobEtjNDVaaWNwcUNJMGtu?=
 =?utf-8?B?ZFYyUWtEZXZ1VDVaK215UEZ3RVhwT3N4Nm8vV1pDaVliMzc0YnRSdFhtL0FG?=
 =?utf-8?B?ck5EMkFQR3Y4UTZ1Q2hMUW5ESHFxSFRDaUdGSzhKY1VJR3VURTMxVHN1M1Jj?=
 =?utf-8?B?eURjRnNJUTlmRmVEVzV2a29Ea1UzTWVtTEdMNGFJV1drd3Z3UHQzZS9ZNEZl?=
 =?utf-8?B?YkxXWEtPb3R1Q0habXRseXdpTGU4MWZuMjlDMUtrVVRSMmdxZnNiT2dTMzhj?=
 =?utf-8?B?ZDBrWmFTd0VjTVc0ajNkZEJ2TFJlaXE2UDE4Qnp5TWNrR0FrK2lXcWlNbUlY?=
 =?utf-8?B?dlBqWkpQMDdyTHllWG9VbkxDeVQycFhDYm45UDdmTUk2Mk9MaURHME9KS1lC?=
 =?utf-8?B?dTJIYUYwTzE0TEIyYk1JbTJQV3FFdlBieEVyZXVGSXRQRjFVcGV0RzhmeDJ2?=
 =?utf-8?B?Y3FxM3RjZ3o2OUFkNldQWC9lMFA4V0ZSSEN6L1lrZGhXWGEzaXhpZXh4Sm1T?=
 =?utf-8?B?MG02RzMrY21lTDdyQk8zak8ybklsN0NEQUwrKzZ4K0VHVkZxbHB4cXdKR3pt?=
 =?utf-8?B?c0xIZG1JTndDZXlCZy9jUG4wOVlpRldoc0JhMGxGTVl0dTYyajhSd3djWkFU?=
 =?utf-8?B?UmgzSkZ1MHJWWUJ5NVoxZGxQZm1tVlFQNStKQWdUVUg5K2p5bXc0N1VIL1Bv?=
 =?utf-8?B?T0pzYkczVDJ3R1d6NytKS2hDM1B2ck1vc1c0ZkhIeTBTVU15ZDMwdDNVbGk1?=
 =?utf-8?B?RkFQM2JwVlRyeHJRUnhDSWtka2FkSlVCbjFCdy9tSXdSZFhIYm9JRXZTNWJo?=
 =?utf-8?B?YUMzUU5hYmhNZTRsU1o0MCtVZVdTNFl6Y0ZnT045dmxlbU0vWW1UbGU0TGpH?=
 =?utf-8?B?bDhsN2J6aTJYcFBXSWt5cEx4b3pvd2pyejB3L2RvQ2IrbnlWc0pHdFluT1lG?=
 =?utf-8?B?WVJGUllmOFJjK1UzS3ZENGJyb2M5bTlwTEZFRDhiYm9JblV5a2FOTmFING1D?=
 =?utf-8?Q?Xf0s=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(7416014)(376014)(35042699022)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 12:30:48.5601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e173e5-a928-49dc-8627-08de001d2fa8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9442

Hello Han,

On 9/4/25 03:51, Han Guangjiang wrote:
> From: Han Guangjiang <hanguangjiang@lixiang.com>
>
> When both CPU cgroup and memory cgroup are enabled with parent cgroup
> resource limits much smaller than child cgroup's, the system frequently
> hangs with NULL pointer dereference:
Is it happening while running a specific workload ?
Would it be possible to provide a reproducer ?

> Unable to handle kernel NULL pointer dereference
> at virtual address 0000000000000051
> Internal error: Oops: 0000000096000006 [#1] PREEMPT_RT SMP
> pc : pick_task_fair+0x68/0x150
> Call trace:
>   pick_task_fair+0x68/0x150
>   pick_next_task_fair+0x30/0x3b8
>   __schedule+0x180/0xb98
>   preempt_schedule+0x48/0x60
>   rt_mutex_slowunlock+0x298/0x340
>   rt_spin_unlock+0x84/0xa0
>   page_vma_mapped_walk+0x1c8/0x478
>   folio_referenced_one+0xdc/0x490
>   rmap_walk_file+0x11c/0x200
>   folio_referenced+0x160/0x1e8
>   shrink_folio_list+0x5c4/0xc60
>   shrink_lruvec+0x5f8/0xb88
>   shrink_node+0x308/0x940
>   do_try_to_free_pages+0xd4/0x540
>   try_to_free_mem_cgroup_pages+0x12c/0x2c0
>
> The issue can be mitigated by increasing parent cgroup's CPU resources,
> or completely resolved by disabling DELAY_DEQUEUE feature.
>
> SCHED_FEAT(DELAY_DEQUEUE, false)
>
> With CONFIG_SCHED_DEBUG enabled, the following warning appears:
>
> WARNING: CPU: 1 PID: 27 at kernel/sched/fair.c:704 update_entity_lag+0xa8/0xd0
> !se->on_rq
> Call trace:
>   update_entity_lag+0xa8/0xd0
>   dequeue_entity+0x90/0x538
>   dequeue_entities+0xd0/0x490
>   dequeue_task_fair+0xcc/0x230
>   rt_mutex_setprio+0x2ec/0x4d8
>   rtlock_slowlock_locked+0x6c8/0xce8
>
> The warning indicates se->on_rq is 0, meaning dequeue_entity() was
> entered at least twice and executed update_entity_lag().
>
> Root cause analysis:
> In rt_mutex_setprio(), there are two dequeue_task() calls:
> 1. First call: dequeue immediately if task is delay-dequeued
> 2. Second call: dequeue running tasks
>
> Through debugging, we observed that for the same task, both dequeue_task()
> calls are actually executed. The task is a sched_delayed task on cfs_rq,
> which confirms our analysis that dequeue_entity() is entered at least
> twice.
>
> Semantically, rt_mutex handles scheduling and priority inheritance, and
> should only dequeue/enqueue running tasks. A sched_delayed task is
> essentially non-running, so the second dequeue_task() should not execute.
>
> Further analysis of dequeue_entities() shows multiple cfs_rq_throttled()
> checks. At the function's end, __block_task() updates sched_delayed
> tasks to non-running state. However, when cgroup throttling occurs, the
> function returns early without executing __block_task(), leaving the
> sched_delayed task in running state. This causes the unexpected second
> dequeue_task() in rt_mutex_setprio(), leading to system crash.
>
> We initially tried modifying the two cfs_rq_throttled() return points in
> dequeue_entities() to jump to the __block_task() condition check, which
> resolved the issue completely.
>
> This patch takes a cleaner approach by moving the __block_task()
> operation from dequeue_entities() to finish_delayed_dequeue_entity(),
> ensuring sched_delayed tasks are properly marked as non-running
> regardless of cgroup throttling status.
>
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Signed-off-by: Han Guangjiang <hanguangjiang@lixiang.com>
> ---
>   kernel/sched/fair.c | 21 ++++++---------------
>   1 file changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..d6c2a604358f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5373,6 +5373,12 @@ static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
>   	clear_delayed(se);
>   	if (sched_feat(DELAY_ZERO) && se->vlag > 0)
>   		se->vlag = 0;
> +
> +	if (entity_is_task(se)) {
> +		struct task_struct *p = task_of(se);
> +
> +		__block_task(task_rq(p), p);
> +	}
>   }
>   
>   static bool
> @@ -7048,21 +7054,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>   	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>   		rq->next_balance = jiffies;
>   
> -	if (p && task_delayed) {
> -		WARN_ON_ONCE(!task_sleep);
> -		WARN_ON_ONCE(p->on_rq != 1);
> -
> -		/* Fix-up what dequeue_task_fair() skipped */
> -		hrtick_update(rq);
> -
> -		/*
> -		 * Fix-up what block_task() skipped.
> -		 *
> -		 * Must be last, @p might not be valid after this.
> -		 */
> -		__block_task(rq, p);
> -	}
> -
>   	return 1;
>   }
>   

