Return-Path: <linux-kernel+bounces-856468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF60BE43CC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B39134F6BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF71E34AB0B;
	Thu, 16 Oct 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lYe6Gcvr";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lYe6Gcvr"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5634AAE6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628607; cv=fail; b=ljloIUEaW2/IvQ3WU9loL/kJGnyHKirEoAWBR4WSCfPxAjltfJPkg6x2+Re8nq//SyjYXl8SxuHMe+3P8I0KIPFAaB8o1AVXDyH2WwZ/NaNDuUlQixl9aG6IP4sk7KEAdq1yi8sR/kx1Sj0j5N5Hn9m2QzlGg373TnM8ftIuI0Q=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628607; c=relaxed/simple;
	bh=zBpjwX2uWbHNj87f20ktOpQoFRGafZbfP3rPpE7k8zk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sZhXzQJ4odDrL5gMQaSaiTfdUxnG3DWFUdhy4Uym/RExfH+mj67Rw/gfmgB1AZTrKJjRBkXBCTs+4MqSDg2a/bnYVx+Nb5CYq24hXMQrNPKlXQkmGP/GYr31MJ07LSV9ZIESK67kSGAU4AKr7n1Veo5WEpbcZRJuhJz8XisCcsU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lYe6Gcvr; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lYe6Gcvr; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LqC2gJLAtDyA/PwzYW0IO3oDTuuI378qNd4RXC0pyMt1fTxrXRypOucC5sdmStoycTc9ULneju+Av3GTTYLWYuvpWtw7RMuUnW0hPvBFZ25Brp/IDhOSZM3zOPcg95mssMAQPGWzqMuWXKyz8afjLg8L4zecykTQYM9pL29VtfWeannUmcCyXfOoSlIySWlgl45hAjeQeldLNl2CjJhE8n9endBFkI+wGEYx4bLuTpqSptNOZ+UTRgsIlRQgEHtcF2dBohEemCrR306ZMTL4O6VVMW+XmNsf3WnvjKg5lMPPGHqyJZbaNcJvPaanUD1kxdeICzYlW8AIdGr3FiB4YA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA4sHpq8FGzfyidNdBQaexFnZYDyUw1NBEA5LxmtYX4=;
 b=BTwZPHBLvq3eim1i9cZcnLOk6RYJXTQ/hasPxaJb9TgRaUs2ebAId7PoU+LRjXJhh/gMGzSe21gAL3WGU4EalHo06zsZyf3GnSb6JwdTNEReevSpkEAq5jsy+O7/yHY497Uj2KMlNeqs3UuEURRLvCQDEydzSHf0ACYvp7Jes1SGw+rIyeQomW/lqDipFtpwdxm8x5W5VfjHE6bVEsBCUDAK+a4vWhRcPadQ/xF3C29AxSZQPC6ynhPUO+Mjd0I9OWvkgrWg2gp1vUYQeHhHuT3eBI8laIbC8SiCnEU6e1oXFBOklfDk+1wqRXeZKYP6AApwybrjW5kThlo5Eaozow==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KA4sHpq8FGzfyidNdBQaexFnZYDyUw1NBEA5LxmtYX4=;
 b=lYe6GcvrU8SMN1ChOY8k4GZ6y/vmPWRR5yMQc91Z64iic/e0ZXWm/f0zaxAjdQfIFqgQsxs5UYdPhYwJaVjWH+Tj+I+rFJlAQysvGLYwupl57J7t46sXL8jzed1y8IUU5oeC8Ljlh8aWOeh2J55d13mcTz94AGsD97lJ9bPpfG8=
Received: from AS4P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::11)
 by AM9PR08MB6243.eurprd08.prod.outlook.com (2603:10a6:20b:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 15:29:57 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::32) by AS4P190CA0018.outlook.office365.com
 (2603:10a6:20b:5d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 15:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 15:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQkiogjrRvdPTYEbG5/XaBF7jK+TrlDi6Wi8MTmxQyuItNOHhdDAgnAqGKgNnP1IbJcB51wi+XdEYcd4/BDOXZLfpslWuBZVwE/HZyx/Ly1piSluiJGr3pq8tk2Y/efBUgf0CmmCvGNTL7K8KvEADNEulPA9v+1mUBN95bBUdxBuW27flm8dVtbqD0NBRElHCAG9HQDJYSn/Zp5o80WFn5HbMh7VRIDIpFnvNIEmyJodKntfD1sj3nI+ISYhugNzIEynKmm8h+vS4uvl1pwIWcLCpl4XQWqWlAVNZLYEiXnfh746tvWF86jxjmgE2oueCwMy01DC0TjFjQtx7KRA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA4sHpq8FGzfyidNdBQaexFnZYDyUw1NBEA5LxmtYX4=;
 b=Q8yPEjy76q1C00YUJLPkX5Y29+Wv83B8yg1IK1Lt+DRoDICA7lMPwgKKkGgBvCGeSAlp08QL6Y8QgPEnSMJiD+fmIYBo9twTUnK+9CZf4KLy1hMYeTZjSXvZU2b0DJKbd/QNTAD84nDD/uy3Aqu2sInGJcUaCJqjPAp963Hpu2DZdghXkfOMScRfa7MHkrd7MYCOzv6bS2rjeow/SwBcqdOQ4EDmX7ZXfHQ3D6h+JO6VjNtzEScUzB9MqWdPbUtXgFE8E9socPucPq1nnJmSHkZCjxrqVV82PeTmngH+LCpF/ngwRjyX9bz7FiEqUjMIQHBChO4AzQJbLWKpUsEJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KA4sHpq8FGzfyidNdBQaexFnZYDyUw1NBEA5LxmtYX4=;
 b=lYe6GcvrU8SMN1ChOY8k4GZ6y/vmPWRR5yMQc91Z64iic/e0ZXWm/f0zaxAjdQfIFqgQsxs5UYdPhYwJaVjWH+Tj+I+rFJlAQysvGLYwupl57J7t46sXL8jzed1y8IUU5oeC8Ljlh8aWOeh2J55d13mcTz94AGsD97lJ9bPpfG8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by GV1PR08MB7875.eurprd08.prod.outlook.com (2603:10a6:150:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 15:29:20 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70%3]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 15:29:20 +0000
Message-ID: <91eb613a-2e29-4e1d-b78f-741c5fb88e90@arm.com>
Date: Thu, 16 Oct 2025 17:29:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] sched/deadline: Walk up cpuset hierarchy to decide root
 domain when hot-unplug
To: Pingfan Liu <piliu@redhat.com>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20251016120041.17990-1-piliu@redhat.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20251016120041.17990-1-piliu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0049.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::7) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|GV1PR08MB7875:EE_|AM3PEPF00009B9E:EE_|AM9PR08MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: d160d167-9a6a-4bea-35a9-08de0cc8dc9b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SmdVQVlacUd5T3NUWDJVT2k1Wkhyc2xiRzlSNHlNOHhvVnVHZnV3SWRmY3Ar?=
 =?utf-8?B?SmNTVkhxVHM5anpDQ1lXMnJJY0JoZ1JzdGxzM0p2bm8yeWg2R0VPRzA4cEJE?=
 =?utf-8?B?Tk9IQ3Y1Smk2RW54ZDBEMHFmbzhxN1dDSXpGNm14bjRLNGVBekNVUlNENmti?=
 =?utf-8?B?V0EwbHh1V25uMGc1STBCMklyRWlsQ1hIQWJxYzAza2FtcEVPbWNSYXQwbmF0?=
 =?utf-8?B?bGpVeUlZOEIrdXR4VTJ2TFFYU0oxc0dsaUs2dEVScFdQQ0hMTEdUR3R1U3Jv?=
 =?utf-8?B?VnZVNGdHdTdsOHhzVmpHNS9PdHN3aTQvV1lLaTZraVNWQlpZSzUvelZEY3pl?=
 =?utf-8?B?NHRKcWlTK0M1MTF0bldyOFdLVk1PcFNPbk8zZ2dxSFRrcHI0d0dqTWlpeU96?=
 =?utf-8?B?RFdxSjJmL09GeGtnYVRtaUEyaXM0YzBCNVBNWklvRlRHSU5oWHlzWjNiQVpt?=
 =?utf-8?B?Zjh6Y05EWFY1OXhpYzlhaGdrR1dka3lUT21ZeEp4KzIvZ09kdVZaSzhsSk4w?=
 =?utf-8?B?a3NtLyszTGY4T3FwaDE5ckNVUi9ROVlpNUtWdmlVUGNXcDRWZ2k4a0JhaVlT?=
 =?utf-8?B?WUx0N1JHK2F3d0hTakJudGwzQUZneS9HQjR3TFQrYnZTMkNtQlJLREV0K2Zq?=
 =?utf-8?B?SVdTYk9nOXZvZ0JJbHQ5QVR1aXJyZXRMeExsVEFCT2dsVnJkaU1oQ3hueDQ3?=
 =?utf-8?B?eUdQWEpBbGsrNDBqSytxQ0FWckhmY0RRcWx4TVBaS1cvMHovc3VRTEs3OGxS?=
 =?utf-8?B?c3VCMWhBWmVKNUtXZm13ZldGNTFZQTNJVFBISllGWjE5c1NFTDE1MlEvamRU?=
 =?utf-8?B?cGJ5M0FKUnRKK1BQcHo3Q3p5SUlDbkNYUUl5SjA2UTlFZDI5TFZMQ3l2VjlH?=
 =?utf-8?B?SGJaT3pZUVh5Qmc4ZFVSbUUxSXlEVjBkVW10T1BwUWhMakprbjcwaHFPOHRh?=
 =?utf-8?B?N1pRcm9QRjIyV09SM3llUVMvbEN6Qng0bWl4anZ6VjZTcjc0TUtoQlVCdTlt?=
 =?utf-8?B?emFONk41SzlJMGt3UTkxQlVvTThkTzBkK3F3aElaNVlIMGtBbWZKdmNUOFli?=
 =?utf-8?B?UEdDUnJLZUprWjhWMkczdVUwcjVNSlgvV1NVQUJGUGxBc1RIQjR5WG94UjNw?=
 =?utf-8?B?czFXMS8va2tKdkJEODh3bFk3ZVFkcjEzbTdOQm0xSHFJUldKRFBwTS9JQ0hG?=
 =?utf-8?B?Y0NOMy9XQVlhWVlzUFJ1ZnQzTzNMRGtIUXhYZW9vVDlPWUkrbzJDSmJPUzZ3?=
 =?utf-8?B?UklaMEJ1enR2M2puL0ltTmZ3Qys2enNIY3FPVDBqRmdXNVRzR0hDQ3E5b283?=
 =?utf-8?B?TUU2cFhIWXFVNlNlcTIxNEt4TVV2YThrNDNSMzlKbDc5QXFvR2J0UmltTlA1?=
 =?utf-8?B?RFp3Z2ovRGpSb2s0UGYyeEFmYXBwSU5qNENsVUpKR1VZQjNXVVFtUXN0ZHNV?=
 =?utf-8?B?eFZYa3FqTmQyd2d6SkZ3YzZVWnJWZ1lGc2VTNFF1K1dZSDNFRmZYcjZWa0NF?=
 =?utf-8?B?cnV3dktxbWg0bmVjanlVaDVRM1JKZkVjY2ZYQUVRRFRJVm1rMEhzNmxtT0JK?=
 =?utf-8?B?eHdxSXNPVzJZV1NrSGdmNWMybG4rQkhqMG5LOFVRazZVWENsWmFicDlRRnBJ?=
 =?utf-8?B?S0UvdFdpTHdiUHBxRENMVjhDS3QrdFVKQWpVZG5kblhabHpnVTJKaTkzQzNa?=
 =?utf-8?B?b1VKZHlMMDdhcFJzV05HZGNncnBISXlvc2ZkS1NJY3pBV1UwVllLTmhFSGdF?=
 =?utf-8?B?dWoyYzBPczQ4RU5wSkpmSWFob3d6ZzBvSHEyRCtLWTNiU1FpdExYWUhqdmk0?=
 =?utf-8?B?SVlsUHVwMkF6TytZWHMrdGtRdVhvaSt1dmNZb3FuN3FGcmtKZCtmc3ZZb040?=
 =?utf-8?B?WnVTUkFXNW1jU3Z4UDJYbmlGKytFQ2lKY1BNZlpWZzI4bllvOWhHZWFOSWYv?=
 =?utf-8?Q?RypMhuyw6qQJLn5pvAbdtHdzKrL5C+Zl?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7875
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	385f9a84-33df-4313-8278-08de0cc8c6dc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|82310400026|35042699022|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2NoOG96cWNYOWh0bW5rNFl4YlZYSURuYzZBRzZmTWdhUE10ZDE0Q2pIbGRz?=
 =?utf-8?B?VHBsVEV3aXl6YktXUTJZRk9MTVVWRDZ2anhPcENxSzZGV2dNbHBNb3ZKaHJJ?=
 =?utf-8?B?T2Y2Vmh0UHVqdTlQbnozc1NHVDh6alJGalVrM2xxLzh5d3Y0S0tZTXc3aEJV?=
 =?utf-8?B?OUZvS3ZhTDU4anByV1d0MW5FMFRJQjd4QlorM2poSEo3RFVoUlM5OW9LTm4r?=
 =?utf-8?B?S1o5dlJVdEVsdlQzMEJ2UnpuR2FsMnAxOUNVWjVCQWlKMjBBbFBEREhwc0Va?=
 =?utf-8?B?R09IaXdwTjdsM3R3NVlzYXB1aU9KVW5NYVZHOVJySVBnQWJLTFBrcWFVOUdP?=
 =?utf-8?B?MS9DZmZvTWZaMytRRzNvaWVTU0EzZlE4dmlENUdmcXVXSWpWbkF1SVAxaDZo?=
 =?utf-8?B?V21wNXVwMVZWODMyVWFkd2pXRks4Rmt5b3JtdjNQeGgrRjAwNmZqNGJyK0sw?=
 =?utf-8?B?VDA2LzB2Y0RMcVY2eDJZVzdZa3Zha0svT3ZWWGp6YTArRjkrMmliRjRjbGZY?=
 =?utf-8?B?VGFXQ1g1ejkremxHVmJKUFJwdHVza0RoM3FRZzhvU2Nhc3FTZ1BSZVpPRVBO?=
 =?utf-8?B?emhGN3NHQlN6SnExYUNrTUc2eGpyNlFEZ0lVNTREODFra0h5c0NnTm5CNTJk?=
 =?utf-8?B?TUJQTnN1K1hhZy8rQlE1bExlUEV0MERDRHJFVVdzVjlNOW01amZBMVhqTzlB?=
 =?utf-8?B?WkV3WHNabnpLSDR0Q2owYkVScVYzVVFuUHAzekV5VEFSOEh2YUJreUhPRjVE?=
 =?utf-8?B?eE5DckpYSWFjM0thU2VJOUZrdm83dEhnK1BsbVVWUFBQcFluQlFxOERpZkxM?=
 =?utf-8?B?b2FhUEYrOUVhOHVGdTQwODZuTFlacDMwUWZLWm9Mejc4KzNHVmtzbTFEaG9T?=
 =?utf-8?B?S0FUWXBqaUhLM2ZTVDJUNk5US09sYUc2Wm9iSFdDenBpTjdPd25hV2FKQ1lB?=
 =?utf-8?B?dFVyVk9uL3FhZC9NWitHQVVKaTBJd28zWC9NL2JUbGpUeXd0Tkd3YTBjOFkw?=
 =?utf-8?B?ams2SWEzRStpTHZrL29XOXVnV3BxTmR5aklUSGh0T2Z2Y0cyR0g1cDVlckJa?=
 =?utf-8?B?ZEVtSjhibGE4RlgxTzBLRHRXVE16MU5zeDl1MEd4UHVaVGVFNk93d01OUERh?=
 =?utf-8?B?U1IyQ0VEWmtpRER3cmVoTEV5MHVoYlB3WkVvUUNsdWdyc2c4QmxYcU9PVDFS?=
 =?utf-8?B?ZWtCQ2ptQ25iM05heEF2WU9GaU4xdG45OHJoL1U0TVdEUWhWYnNBMUhvNmFJ?=
 =?utf-8?B?VnJnMUVHMC9WaEgya1c4VEFNZ0VvYnRyc0NlMEw2Z3pUMEV1WWFxRnN1S3VX?=
 =?utf-8?B?V25FVnFhWWhQdVVFWkhFNnRCSTBqYk1oTEVMRlVIUEVhZEY0MUJXeW9ZY3Zh?=
 =?utf-8?B?UzFkRVFSa3hpVGV2VHVtMnBybm03a2FaMW5oamJreHEwUEFPTzBYV1d1NVEy?=
 =?utf-8?B?QUhDOUtEeExYeHBYRjk5UmJCNmZNT29jVW1KdlBEak5oeTVqeXZKR3FpN0dt?=
 =?utf-8?B?SmFLbnFlNWZaaXBqV2lrTWZXMXNJYXlJUnpmWFBLbTlpeHI3VHYrb2haNDVU?=
 =?utf-8?B?WjBKQ2xHT2JpN1dhcXhXTzNadkt1R0RvZzJNOTVWTFhmOENuUDJoYURCeS9R?=
 =?utf-8?B?OVJlWElLOEtYWUhlQk5rV3lNSEtUK1kwbHhpQjhoaWN6dHByak9NUTZHYzI2?=
 =?utf-8?B?WFpPOHlhWkNoTjRKRlE2SmV1N28zU21iMEs1dDlldURsRjQxMXhnT0VvbkpD?=
 =?utf-8?B?aUNwRUpPemx5UFZSV0dJVTFReGcrbzFpWnVFUUlmMnhiZ1QrQXVRV2EzcGlE?=
 =?utf-8?B?SEl5aXJwNW0rRzA0UjlxUE4vMGdxSHUyTjRFbzd2cVVveU16Z2plV3N0aXRi?=
 =?utf-8?B?Y0VMRDJWbEJJQzAyYWt2d3IyZm52cm13b1NDZ3RKY2p0bG5UUmxyOWRWVWZD?=
 =?utf-8?B?QUUxY3E2V2IxY2pMV0N2THJtQnIwYTlGSlJGNUpjeVBUWTBFV2NOVSs1N2ln?=
 =?utf-8?B?THF2L29sZ21kcnphRk15ZStPaFRPL2UwdVEwa1lmU0daNlp3VE5XYUxxZWF4?=
 =?utf-8?B?bnQ2ZjhqNHV3c29iTVhZaWtCRDBpdG9XMWNNZXVpQjM3dWJQS3c1R3NWWlAy?=
 =?utf-8?Q?rauw=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(82310400026)(35042699022)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:29:56.6298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d160d167-9a6a-4bea-35a9-08de0cc8dc9b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6243

Hello Pingfan,

On 10/16/25 14:00, Pingfan Liu wrote:
> When testing kexec-reboot on a 144 cpus machine with
> isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
> encounter the following bug:
>
> [   97.114759] psci: CPU142 killed (polled 0 ms)
> [   97.333236] Failed to offline CPU143 - error=-16
> [   97.333246] ------------[ cut here ]------------
> [   97.342682] kernel BUG at kernel/cpu.c:1569!
> [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> [   97.353281] Modules linked in: rfkill sunrpc dax_hmem cxl_acpi cxl_port cxl_core einj vfat fat arm_smmuv3_pmu nvidia_cspmu arm_spe_pmu coresight_trbe arm_cspmu_module rndis_host ipmi_ssif cdc_ether i2c_smbus spi_nor usbnet ast coresight_tmc mii ixgbe i2c_algo_bit mdio mtd coresight_funnel coresight_stm stm_core coresight_etm4x coresight cppc_cpufreq loop fuse nfnetlink xfs crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt nvme nvme_core nvme_auth i2c_tegra acpi_power_meter acpi_ipmi ipmi_devintf ipmi_msghandler dm_mirror dm_region_hash dm_log dm_mod
> [   97.404119] CPU: 0 UID: 0 PID: 2583 Comm: kexec Kdump: loaded Not tainted 6.12.0-41.el10.aarch64 #1
> [   97.413371] Hardware name: Supermicro MBD-G1SMH/G1SMH, BIOS 2.0 07/12/2024
> [   97.420400] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [   97.427518] pc : smp_shutdown_nonboot_cpus+0x104/0x128
> [   97.432778] lr : smp_shutdown_nonboot_cpus+0x11c/0x128
> [   97.438028] sp : ffff800097c6b9a0
> [   97.441411] x29: ffff800097c6b9a0 x28: ffff0000a099d800 x27: 0000000000000000
> [   97.448708] x26: 0000000000000000 x25: 0000000000000000 x24: ffffb94aaaa8f218
> [   97.456004] x23: ffffb94aaaabaae0 x22: ffffb94aaaa8f018 x21: 0000000000000000
> [   97.463301] x20: ffffb94aaaa8fc10 x19: 000000000000008f x18: 00000000fffffffe
> [   97.470598] x17: 0000000000000000 x16: ffffb94aa958fcd0 x15: ffff103acfca0b64
> [   97.477894] x14: ffff800097c6b520 x13: 36312d3d726f7272 x12: ffff103acfc6ffa8
> [   97.485191] x11: ffff103acf6f0000 x10: ffff103bc085c400 x9 : ffffb94aa88a0eb0
> [   97.492488] x8 : 0000000000000001 x7 : 000000000017ffe8 x6 : c0000000fffeffff
> [   97.499784] x5 : ffff003bdf62b408 x4 : 0000000000000000 x3 : 0000000000000000
> [   97.507081] x2 : 0000000000000000 x1 : ffff0000a099d800 x0 : 0000000000000002
> [   97.514379] Call trace:
> [   97.516874]  smp_shutdown_nonboot_cpus+0x104/0x128
> [   97.521769]  machine_shutdown+0x20/0x38
> [   97.525693]  kernel_kexec+0xc4/0xf0
> [   97.529260]  __do_sys_reboot+0x24c/0x278
> [   97.533272]  __arm64_sys_reboot+0x2c/0x40
> [   97.537370]  invoke_syscall.constprop.0+0x74/0xd0
> [   97.542179]  do_el0_svc+0xb0/0xe8
> [   97.545562]  el0_svc+0x44/0x1d0
> [   97.548772]  el0t_64_sync_handler+0x120/0x130
> [   97.553222]  el0t_64_sync+0x1a4/0x1a8
> [   97.556963] Code: a94363f7 a8c47bfd d50323bf d65f03c0 (d4210000)
> [   97.563191] ---[ end trace 0000000000000000 ]---
> [   97.595854] Kernel panic - not syncing: Oops - BUG: Fatal exception
> [   97.602275] Kernel Offset: 0x394a28600000 from 0xffff800080000000
> [   97.608502] PHYS_OFFSET: 0x80000000
> [   97.612062] CPU features: 0x10,0000000d,002a6928,5667fea7
> [   97.617580] Memory Limit: none
> [   97.648626] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]
>
> Tracking down this issue, I found that dl_bw_deactivate() returned
> -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> When a CPU is inactive, its rd is set to def_root_domain. For an
> blocked-state deadline task (in this case, "cppc_fie"), it was not
> migrated to CPU0, and its task_rq() information is stale. As a result,
> its bandwidth is wrongly accounted into def_root_domain during domain
> rebuild.
>
> The following rules stand for deadline sub-system:
>    -1.any cpu belongs to a unique root domain at a given time
>    -2.DL bandwidth checker ensures that the root domain has active cpus.
> And for active cpu, cpu_rq(cpu)->rd always tracks a valid root domain.
>
> Now, let's examine the blocked-state task P.
> If P is attached to a cpuset that is a partition root, it is
> straightforward to find an active CPU.
> If P is attached to a cpuset which later has changed from 'root' to 'member',
> the active CPUs are grouped into the parent root domain. Naturally, the
> CPUs' capacity and reserved DL bandwidth are taken into account in the
> parent root domain. (In practice, it may be unsafe to attach P to an
> arbitrary root domain, since that domain may lack sufficient DL
> bandwidth for P.) Again, it is straightforward to find an active CPU in
> the parent root domain. (parent root domain means the first ancestor
> cpuset which is partition root)
>
> This patch walks up the cpuset hierarchy to find the active CPUs in P's
> root domain and retrieves valid rd from cpu_rq(cpu)->rd.
>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> To: linux-kernel@vger.kernel.org
> ---
>   include/linux/cpuset.h  |  6 ++++++
>   kernel/cgroup/cpuset.c  | 15 +++++++++++++++
>   kernel/sched/deadline.c | 30 ++++++++++++++++++++++++------
>   3 files changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 2ddb256187b51..478ae68bdfc8f 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -130,6 +130,7 @@ extern void rebuild_sched_domains(void);
>   
>   extern void cpuset_print_current_mems_allowed(void);
>   extern void cpuset_reset_sched_domains(void);
> +extern struct cpumask *cpuset_task_rd_effective_cpus(struct task_struct *p);
>   
>   /*
>    * read_mems_allowed_begin is required when making decisions involving
> @@ -276,6 +277,11 @@ static inline void cpuset_reset_sched_domains(void)
>   	partition_sched_domains(1, NULL, NULL);
>   }
>   
> +static inline struct cpumask *cpuset_task_rd_effective_cpus(struct task_struct *p)
> +{
> +	return cpu_active_mask;
> +}
> +
>   static inline void cpuset_print_current_mems_allowed(void)
>   {
>   }
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 27adb04df675d..25356d3f9d635 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1102,6 +1102,21 @@ void cpuset_reset_sched_domains(void)
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> +/* caller hold RCU read lock */
> +struct cpumask *cpuset_task_rd_effective_cpus(struct task_struct *p)
> +{
> +	struct cpuset *cs;
> +
> +	cs = task_cs(p);
> +	while (cs != &top_cpuset) {
> +		if (is_sched_load_balance(cs))
> +			break;
> +		cs = parent_cs(cs);
> +	}
> +
> +	return cs->effective_cpus;
> +}
> +
>   /**
>    * cpuset_update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
>    * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 72c1f72463c75..fe0aec279c19a 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2884,6 +2884,8 @@ void dl_add_task_root_domain(struct task_struct *p)
>   	struct rq_flags rf;
>   	struct rq *rq;
>   	struct dl_bw *dl_b;
> +	unsigned int cpu;
> +	struct cpumask *msk;
>   
>   	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>   	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
> @@ -2891,16 +2893,32 @@ void dl_add_task_root_domain(struct task_struct *p)
>   		return;
>   	}
>   
> -	rq = __task_rq_lock(p, &rf);
> -
> +	/* prevent race among cpu hotplug, changing of partition_root_state */
> +	lockdep_assert_cpus_held();
> +	/*
> +	 * If @p is in blocked state, task_cpu() may be not active. In that
> +	 * case, rq->rd does not trace a correct root_domain. On the other hand,
> +	 * @p must belong to an root_domain at any given time, which must have
> +	 * active rq, whose rq->rd traces the valid root domain.
> +	 */
> +	msk = cpuset_task_rd_effective_cpus(p);

For the cppc_fie worker, msk doesn't seem to exclude the isolated CPUs.
The patch seems to work on my setup, but only because the first active
CPU is selected. CPU0 is likely the primary CPU which is offlined last.

IIUC, this patch should work even if we select the last CPU of resulting 
mask,
but it fails on my setup:

cpumask_and(msk, cpu_active_mask, msk0);
cpu = cpumask_last(msk);

------

Also, just to note (as this might be another topic), but the patch 
doesn't solve
the case where many deadline tasks are created first:
   chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &

and we then kexec to another Image

> +	cpu = cpumask_first_and(cpu_active_mask, msk);
> +	/*
> +	 * If a root domain reserves bandwidth for a DL task, the DL bandwidth
> +	 * check prevents CPU hot removal from deactivating all CPUs in that
> +	 * domain.
> +	 */
> +	BUG_ON(cpu >= nr_cpu_ids);
> +	rq = cpu_rq(cpu);
> +	/*
> +	 * This point is under the protection of cpu_hotplug_lock. Hence
> +	 * rq->rd is stable.
> +	 */
>   	dl_b = &rq->rd->dl_bw;
>   	raw_spin_lock(&dl_b->lock);
> -
>   	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
> -
>   	raw_spin_unlock(&dl_b->lock);
> -
> -	task_rq_unlock(rq, p, &rf);
> +	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
>   }
>   
>   void dl_clear_root_domain(struct root_domain *rd)

