Return-Path: <linux-kernel+bounces-580196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A71A74EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 18:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B3E16A2D4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67021DA0E0;
	Fri, 28 Mar 2025 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k6fBl8bg";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k6fBl8bg"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085E3C0C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.84
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181634; cv=fail; b=B9tdkhONkTNA9dfIqyLedJEEhBJponQu70bfJwZhaltI0OhqcgZ9pEcRImCMQXdzr5WwHB/xXVZv7WC0PBw6VyNxDvcaVJ7YDn3FVY3jtubNfmF845RyLfVlE6LkaXeRyLBqZR/jhB4plAnxcnC8jdk4pp6B8otySCPn4ixfEzA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181634; c=relaxed/simple;
	bh=Zf24B8axhnCPLnowS/VuZAE/lWvyCrMOT1mgdNy51IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MNTaffOgrg096TJ4SdjkTtz+Hhcoq459/Dg9JGkLid5lSSgvaeoJAKWzkHsvhvFF1LWfqlJtMASzPs2Geh0Timf/JW/60psZocZ6+jRQZJ6uUbN2ENy1Bdyanp+qc34Urqs1miTBlqdQa1QpzCePv1WRAytjIq0BmSLnwDXvhS8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k6fBl8bg; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k6fBl8bg; arc=fail smtp.client-ip=40.107.249.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=L90B+d4E3IrwX577fQ3jRL0GrhiuloOAdFhO/eFmBa07jjPXDymwHWzjcbYxQSlyJv6zkwcQWfZpY2puXh4tDWId7JHlRvfr+liS0bxvubOwGFaNRPf88Fd2BALOG1sFTBFNqtrBLahv7hmQ6dZf/tol+lVC0NyNlI7Zn5CnUyvrA5Jt7F43UoLtkA5jElRkP1to0ghgWvk9voY8t6vw0qN3/vaD+KPRmsyQ7kdldIz8iRFIGXMES2bRqWJx7Azmtw0sxrhtleqpBV8BChcQGGYJv0eWOtpPZLtmckpNmIk7KqjEnAg5A9fBFblBPZiiDJrK+fXNJErAH4UwqaNbhQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdpMLLgGaWDfSJnJ+bZmFNCEEs+Qnbmc6ctsPn6R4U8=;
 b=Jnnm7OZwtSivGOToI7Epfs5QBg5mB/iYuboNgSU2EthKxmFVOAyyFgVXcqPdndFf8etihwU1DelvQMcXAPgb4AJ1sndNioUBALLH/mRimQlU1xgKtwx9YZsDBmgr5YaDQv5gnnC/YjVLvdw9KnKYHRlzEX/AqFQNh2C4Dx5MS1paPaUQCt9+a+tlE4J4c3MLweWzY6WKhQlAVIp06/O5VU2FjiLi4QtnX3ORKwQay9uuVRGgwme5Lwaetnf5r5WRdph969NRGGEqXOEXxksKlKkONeJ1QAhI60/LO7MgZcVS4gEaqqLwFkp4WF35dX7ydZSIk958MXFC0kNi2HrXTw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdpMLLgGaWDfSJnJ+bZmFNCEEs+Qnbmc6ctsPn6R4U8=;
 b=k6fBl8bgCTpLk8SjognP3F1o8lEXU2Hy3dhxgaHa1/6ge/cLWdAjdC4ZeIr3xVm5ZNQij4H7Xr47NT3ZEgcOHayTPutf6Mx3L31/6y4E5JN29La2P1Sdg5vy6dVfnXxauB6WE5adx1LIS2PSdn1f+v0sXgpAl0g4b8cQ8rTLF/Y=
Received: from DUZPR01CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::11) by VI0PR08MB10918.eurprd08.prod.outlook.com
 (2603:10a6:800:258::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 17:07:06 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::d9) by DUZPR01CA0073.outlook.office365.com
 (2603:10a6:10:3c2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.46 via Frontend Transport; Fri,
 28 Mar 2025 17:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com;
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Fri, 28 Mar 2025 17:07:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUkpDP3BsR7JtdRFaJiXN5UCJzoOgkW8DVHnR+6kyRcF9N2pPvIxEstNPO2REO6LK99FFLg+bN8GJ0fGi3RIjkXB3OBnLD1IdHQJnwsLHFLRg7dlSbmHqOJ3BwZGmWXtKkX77L/Fy1oEbOkhEYvwPU+QilrMTVzs1nyFvEHKsk4j/PvJhD7YiwA1tFVLAnG1mGGN3phHnppu7gl0wqVgLsrCaKQBJGOy4WnLJd2geyNmc0AYRQYZA47y27rHrirLJx7Ey0os1UrG6zQHtJa0gHwjnjdTUY3UA1rXaFOxf1ZnnqGQmmuswWSSs+Uyw1FwK7OzueOMbB+ukINRyI8mmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdpMLLgGaWDfSJnJ+bZmFNCEEs+Qnbmc6ctsPn6R4U8=;
 b=fVSJjBbmdwHIjmkqsP/pqyGryMZh8HTQ1TYq8YT5cx5gqkoRZ23I4EPk2+dxOj0spn86rTmaR9rbzSVYwteF+S4APhOUB97Zp0hpPBi4e36m2P9N7EOnBZo8JahdcEQs3jgnF4CvR+yHD0pn4T1bPxnLK4/QWaX/u24jXRYN70ZxHtbbNzZqZnDnrIVkHYKI8QUctEEKGhNzUWs++jygwEsYekNxXlhmsdqIvOZeXg4YBEt02sl81I4MPsbHievMam1odz2Eoei21i/8spBbfpTkmWda0SLmRMSP5gTFHacs9R860nzgEFOLxUW9C5uMlczktY5zpufgl8mnzn/GCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdpMLLgGaWDfSJnJ+bZmFNCEEs+Qnbmc6ctsPn6R4U8=;
 b=k6fBl8bgCTpLk8SjognP3F1o8lEXU2Hy3dhxgaHa1/6ge/cLWdAjdC4ZeIr3xVm5ZNQij4H7Xr47NT3ZEgcOHayTPutf6Mx3L31/6y4E5JN29La2P1Sdg5vy6dVfnXxauB6WE5adx1LIS2PSdn1f+v0sXgpAl0g4b8cQ8rTLF/Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU5PR08MB10579.eurprd08.prod.outlook.com
 (2603:10a6:10:517::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 17:06:31 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 17:06:31 +0000
Date: Fri, 28 Mar 2025 17:06:27 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Morse <james.morse@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, wangkefeng.wang@huawei.com,
	Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH v13 2/5] arm64: add support for ARCH_HAS_COPY_MC
Message-ID: <Z+bXE7UNWFLEfhQC@e129823.arm.com>
References: <20241209024257.3618492-1-tongtiangen@huawei.com>
 <20241209024257.3618492-3-tongtiangen@huawei.com>
 <Z6zKfvxKnRlyNzkX@arm.com>
 <df40840d-e860-397d-60bd-02f4b2d0b433@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df40840d-e860-397d-60bd-02f4b2d0b433@huawei.com>
X-ClientProxiedBy: LO4P302CA0021.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::12) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU5PR08MB10579:EE_|DB1PEPF000509EE:EE_|VI0PR08MB10918:EE_
X-MS-Office365-Filtering-Correlation-Id: 75078d1c-f6fe-4993-9b40-08dd6e1af6d1
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?c212NVkvMHNZUVphMnoyOTRDMStGZ3F6OWlDQjJnaHVtUHZxUXpxYWVvZGxq?=
 =?utf-8?B?SzBZdlQ4SGVqMGJLREFLM2ZSSndaL2tsU1g5MVhPZ1hTMjdPWE1wZVNKcXZS?=
 =?utf-8?B?eCtCTTNjdzNYWC9zcXVzd1k4QmtrSEMrdGkrdGJSeVA2LzZYS1RzcHVKTWla?=
 =?utf-8?B?Z2EyZXN6b3k1WFZuR0I5QzhXUFBCSkQ2N2VNaXdFRVE0dUFuU0pSazdzTi9R?=
 =?utf-8?B?V050V0s4VG1FaHlKWlNFR1Z6QTBsMG42MzFwUnIzZ2pqUEtPcTVaTWJhT1hI?=
 =?utf-8?B?SFVXRUZFeTk4WXJHMTk4cjAveWlDV3BlcTM2MmtjbklJVHp4di80SDgwdzMx?=
 =?utf-8?B?L1hDSjZnRHhjK2krYzdrUE00VHdxZHl3ZHkrR1Y5QTV0aFZ4NXYrOVR3L3Iz?=
 =?utf-8?B?eng5UWttM0xiS05TNnU4QXRSRW0xckZEUWpNK05MTVFHL3FzQjY1U2pzK2RF?=
 =?utf-8?B?QkdFRERTbVYvTE90TitwUEN3V25GMEtrZUFCeFE5ZFVVN0JERHBKdUllbG5J?=
 =?utf-8?B?ZG9wWlgwQW1tOXFpdy91V1pBbllZNWZXd3g5RzhSNGFuQnY5RytrQ2pjOEt6?=
 =?utf-8?B?OVhGM2tDZHFFN21wcjZzb1crWHpmZHhiY1kvMGtwcFAxYU5sajJoMUcrUDRS?=
 =?utf-8?B?NzB0dUhPOFhQL3c4YStySkI2bGpvRGJKTXluck43Q2NXWDBwUEZhTkpGNXlP?=
 =?utf-8?B?UkRMSVJWVXhVSVljREcxS3g3ejZUOXBwZzkvK0hMa3pWWnlFalp6cWlGeE43?=
 =?utf-8?B?dkNsRGR0MVFmenNkQ3VPU0lDaUxjbnVodmtrdXRIMzM3TnVUT2FFc0cyS29K?=
 =?utf-8?B?NUw3blZRb0lHM2hQVHREUUMzN3NlVXdaL1dlZi9mdzdydENTSTdCeHRreWox?=
 =?utf-8?B?NngzMGhrQyt1UWxJekhIcTRDQXpFWmJhdCtRQ2Q2SVd0RkRYTjZjK3dqOWhn?=
 =?utf-8?B?L1Ivayt4OTlHaWRDYmhab0RnTmFkS2VzemxBM1NCMEVJSjNaU2xHbiswbTl6?=
 =?utf-8?B?MlVqd3lEeFp4eTJkYkFGNjMzaGhTa1RuWnR0UUVkLy94eFlVOEdsZXFGblF0?=
 =?utf-8?B?SlZZR3VpSHgrb1JGRmlqU0RHWHVmTTdjOHJCTkEvTlA5TmNvMFlpZmtEV3hm?=
 =?utf-8?B?dkIySUNNbjRlYUpQY0VqNU1SamxvVFZJRDNlMFpPdzBGYjE1QmNhNUNNUEdx?=
 =?utf-8?B?REdFM3E3c2lNbmk1cGxhV2lyNG1TcmxZNWV3dEI3dndjWGVsMHpXTjRwV2ds?=
 =?utf-8?B?MU5qT2craktsM3NuK1MyeGFvdzNiUldyV1drd1R0S1pTSWhJckFMN0d2MkND?=
 =?utf-8?B?MUJLajBDYmJ6dzdYVzRMWnZOTUR3c3lxWjZ1TW0zcnZ6cWduYnlNZEU3TGtE?=
 =?utf-8?B?VzBBVzBDNVBFQjVxNllKb0lvOGpQeUJIaXlXVGlwRlNIZmp2Q1IzK01MSEFs?=
 =?utf-8?B?VTgzZTUwdG9semJZY1BTNjVFcXZWU2NiRnkrTUgyMHRCbmE4eDlzc3YvS1NM?=
 =?utf-8?B?ZEF4SGFEVHBWNC9Ieno5MFgzSzRrcU5VdkpINjdVTnNPVExPQ1cwTVNhWUV5?=
 =?utf-8?B?WWt3SDNzRFJwUUwvRG44ZWREL0MzVUpZYThvZHliSjRKUUgxZXNibGo1bGZq?=
 =?utf-8?B?aks0dWhwc1JSSS9nWnBmK21HMXBjRUVJd29KOHJ2a203cXlyeWVmM1FMbjdI?=
 =?utf-8?B?cEVMVFh3bTVEMWRpNnJxclpYdEVnek9CR0dTYklUejlrZzQwRThaSkVIWnNw?=
 =?utf-8?B?V2UvRUlNZzBJbXpTeFJWcXYvQUVBR3BiWExOMDdOSWJJRFRscEtHV2ZjRTFu?=
 =?utf-8?B?RFZJRWtZOCthbEgvUGJWeHNqb0cvYkRXQi82MWZtSVluMEdlVHFqSjdGZUI2?=
 =?utf-8?Q?019IxEdbvII5d?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10579
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a5ac8323-c499-4c6b-a42e-08dd6e1ae2d6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|14060799003|35042699022|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmUva1VHOGlEeEJTOXNzaE55NlpVOGdRMCs3dVRFYklpMjZkLzV6RDl4Rzdj?=
 =?utf-8?B?MW5ENkVHbVloQzMxNVEvdmhCUEVTV3FsUXZOWjdqQlR4OTRxQ3hYbXE4dy96?=
 =?utf-8?B?S3hKTVBxcE1nVUMwbWE3SWpza0RlNDJPZDV2ODhmQStNeEp3anVYQWdwTEo5?=
 =?utf-8?B?a2RiSFFvMUxwU0hzOEozMzRBQ0RGc3RjaURSVmJvSlNrZUxsTit2TldEMm4z?=
 =?utf-8?B?d2ZjREJyeldYRzNmcW9ZSDNVTW5KekkyUWtSUDM5dUl5VnpiRGQ5TzR4VGZE?=
 =?utf-8?B?K21ZNlNVTDlFd3hrR2JwaVFTSjB1TU9SWk5ueU16N0Z5YndsMWp2Y1VwVUZv?=
 =?utf-8?B?WmxyMHB4NG5wcjBkT2RqOTJtRmFzQ3BxVEM2VWtHcmxLN0FpOGZVOVo3dUNy?=
 =?utf-8?B?WXFZOC9XWGJYdld5anIyczdSQUJZTlNUdEQ3SkRQTnQ3MzhRdndvcjEwbFA5?=
 =?utf-8?B?eWRLZ1grMzlTRFlKOVVERDVUMHVSWjJzeG1mM0RYaWJOSjNCOEN1bm9XTlda?=
 =?utf-8?B?NVcvM1BEZTlCVzRJT3AxdTVBOU82QXQvR1RsSmFqb0NCWTA2MDFFbE9Ed0NI?=
 =?utf-8?B?UVhGZk5Wb2kwSGdJbUFIeGNPbmp5QU5zUUwvam01aTU2a2JudDVSTWx0amxx?=
 =?utf-8?B?TTRVcklyOFEydWR4K1RFSTNVNnRTbWp4ZWw3emJxcE1tNFVaU3paUjRnU3ll?=
 =?utf-8?B?MnlaK3JZbDBFcTQrOUxLTnlERXNLeDBqaHdkK2dnTVdQQ0xuek4zSm5pZ0FV?=
 =?utf-8?B?aDRBb0phUk5WOGNlK3BZYms2LzRWZU1Qci9YeGN6cW9xVG9lK2hOaGNCb2tQ?=
 =?utf-8?B?K2xuaS9Fck1VYW9RWkQ3M01BZEQvTE04MXB6TkszVmh6T21vS0MvTlhrdU40?=
 =?utf-8?B?NTIvbFBTdU9iSFRUNmhRZmxFMlZLY0EvNGZNK1dmRE9rWjFpOHFXQUh5MG0z?=
 =?utf-8?B?UncyNzkwMjRtQWx5NWx6aGhObVhYbXZ0RG1aNnFMTUgwenBGTFl1RTlrbnRw?=
 =?utf-8?B?SW5wOTFITUMxaVdOR2RTQlE2OG4zb3VOdExRR0s3Z1V1QkR0V3dzMFBaQm5r?=
 =?utf-8?B?L2x5TlArbm1EYVhXL3hSUDFham5EbFRCejhnY0ZjM2FTV3ZhcmRidm8vKzJh?=
 =?utf-8?B?QkhqMi9EdXFiMDlpNVZxQVBNak9FajVQZko0UnN6QWRkdGRRbWJxK2ZzOUo4?=
 =?utf-8?B?ZXJtcHJndUExb0d2ZkdOZHpUQjRRWnk1bncwR0dNSnltcytUcDZHTnl0NUlv?=
 =?utf-8?B?ZXQzS3hXbDJWQWFnOUQraWVjc0hCclJWMjFUWmluYnZBZ0o2Q01JY2pkNks5?=
 =?utf-8?B?QnVCRHpkTVQ1dktBK2dwd2RrUHNCYS9ZUE4yTEdrNWR2N3VIWG1KeXN0bHNL?=
 =?utf-8?B?dGUyQkIyZjZxUkkyUy96YnFjYWdjUUZMVzRLZ0pUUlM0V1JQNmlEY2xvRU5M?=
 =?utf-8?B?OVk4ZUJQaTJYcm52Rk9KK0lpd0hQczcxRlV5Q091ZDFRTTF0b0Fjd1Jkb1ZX?=
 =?utf-8?B?Uy9QalNOT2pkdGprbzdiOGdXTmNQK2pGcG5iVFl3MzJTK3MvMFc4ZThkNk1F?=
 =?utf-8?B?RExZMVUzSVdPeHl3NVdnSUMzUnRtSncwdlB6K2Z6TFlza2JsTEFEVTlQSW1u?=
 =?utf-8?B?SytJMDRySW1nTW9IWGpzL3A1VHpCckxOc0NLS29QOVpWVnF2ZHRKOUJrOWZT?=
 =?utf-8?B?S3Qvek5oTUhESVZNQ2QyL3BBVEFGRnNyd1JhZnJKN1FHaWUwcHgyZEx4SEhm?=
 =?utf-8?B?bGZHUmo3dGhKZEgvVlBwWUJsdUZnUFAybElWQ1FVeWlnL1FrNXZySWJpREYz?=
 =?utf-8?B?STRXeCtMVFpha01neVVqQ252dDg2Q1ZtK0xDaWhaVlhqZ1BoUTlyUEtLOCty?=
 =?utf-8?B?cnpiMHVXZVVIRVcxb2xjYyttWmRoNEt5VjFBMUhBOHhtQ2R3S25reXp4VFZG?=
 =?utf-8?B?N3F6SkMvb21LSHNrSFZtdDlxRUo4djVaS0NuQis5Q3BXY2x3ejJ3MzFONHNS?=
 =?utf-8?Q?K0Kr40mZgElBtZZZ9+nMcKH1vg23o8=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(14060799003)(35042699022)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 17:07:04.3740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75078d1c-f6fe-4993-9b40-08dd6e1af6d1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10918

Hi,

>
>
> 在 2025/2/13 0:21, Catalin Marinas 写道:
> > (catching up with old threads)
> >
> > On Mon, Dec 09, 2024 at 10:42:54AM +0800, Tong Tiangen wrote:
> > > For the arm64 kernel, when it processes hardware memory errors for
> > > synchronize notifications(do_sea()), if the errors is consumed within the
> > > kernel, the current processing is panic. However, it is not optimal.
> > >
> > > Take copy_from/to_user for example, If ld* triggers a memory error, even in
> > > kernel mode, only the associated process is affected. Killing the user
> > > process and isolating the corrupt page is a better choice.
> >
> > I agree that killing the user process and isolating the page is a better
> > choice but I don't see how the latter happens after this patch. Which
> > page would be isolated?
>
> The SEA is triggered when the page with hardware error is read. After
> that, the page is isolated in memory_failure() (mf). The processing of
> mf is mentioned in the comments of do_sea().
>
> /*
>  * APEI claimed this as a firmware-first notification.
>  * Some processing deferred to task_work before ret_to_user().
>  */
>
> Some processing include mf.
>
> >
> > > Add new fixup type EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR to identify insn
> > > that can recover from memory errors triggered by access to kernel memory,
> > > and this fixup type is used in __arch_copy_to_user(), This make the regular
> > > copy_to_user() will handle kernel memory errors.
> >
> > Is the assumption that the error on accessing kernel memory is
> > transient? There's no way to isolate the kernel page and also no point
> > in isolating the destination page either.
>
> Yes, it's transient, the kernel page in mf can't be isolated, the
> transient access (ld) of this kernel page is currently expected to kill
> the user-mode process to avoid error spread.

I'm not sure about how this works.
IIUC, the memory_failure() wouldn't kill any process if page which
raises sea is kernel page (because this wasn't mapped).

But, to mark the kernel page as posision, I think it also need to call
apei_claim_sea() in !user_mode().
What about calling the apei_claim_sea() when fix_exception_me()
successed only in !user_mode() case?

Thanks.
>
> The SEA processes synchronization errors. Only hardware errors on the
> source page can be detected (Through synchronous ld insn) and processed.
> The destination page cannot be processed.
>
> >
>

