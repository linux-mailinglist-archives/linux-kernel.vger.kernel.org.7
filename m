Return-Path: <linux-kernel+bounces-729800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C39B03BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574907A7184
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C03199938;
	Mon, 14 Jul 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LX8545j7";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LX8545j7"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013051.outbound.protection.outlook.com [40.107.162.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6041DDC2B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.51
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488192; cv=fail; b=dodEhUTkk0mpcJLsVCY2NVGwSre8i9S6GD63r1Vq1hkWbzwOR9n8r7fSxuKUNxPhWaj07mOHOgwg/3XEit1Gw12vd7ilAiEfpSKVSt5ZIpuUzhXKFdx84NnTz06/X5U8TbpznSvCcWRaQ9v7czmq+qy/oWuOVXEwRXy+bSr3O/0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488192; c=relaxed/simple;
	bh=JMW85/zhdu6trnEnr+FSnFzrVlyCDREkTtNSwZ9y7O0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BcaS4oizxmJRJ9MrLWqNcS8yGoXGkwRrjX+kpLHdcmU2jR6nZudqeb9N4jGtuxqoSktmLMGShhLBQA1I1itxPh1i2R+SC3yzrEESBPuH7+1qAUxlBSv8K+1VGIm3JJfiS9kwM81uwLB4aaca2YHZWR6NVBwQ/Km1M5eIkiKaAxY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LX8545j7; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LX8545j7; arc=fail smtp.client-ip=40.107.162.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XHpp23oyJ+bGC6VUIjp6jeA+m2ryHFy3zVCt+6M/edJoff+mtas5E0swcCY4c7zSk5PIClzUsoz9oTP8ysnhMwV0gOOkgfNZraFHjeGCKoLCyV/PbBmwT2e91FNi4SYQ6UTueeiDv13ubYIA05IZgfoeOCyqe1F9eQJRXRLrsMyHg7JMWBsM5pLafeDUJdLPjh5YUr/hp53L0N9DuYQhQ0NjozTJ82eGxcUbcCqZer/ZL8SKahqSp2kK/gqH4TICSZLosozsHfFMD79HAI/svupicH5DYNKopTdG08uJRaFtc1vGP5959ZxzFvhWaoNguaYtw7cEw+Oth6EEH2s4Yw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QlqVjJu0QL0z/UwE52PRE9+6/oywqpYMjQjE5QTNNw=;
 b=bniI+36IyKR98WgiPerZ8cqbwTDiE2Y4JIkm+YhjGKxlw2wdQfKA5CArpQAbbKENxPcqqMqwM1S0RcZcN4mAA/k38hSfIXftk6XbBST59PGw7GfwmkUjHwqcK8GgrQgxfSzMB3qY9vC3gP3q4g3koq2MY5VIO6iiB0ryJWNlHL3ilehyAgNkVynYZ88tMGgX2SXZR9teE8di/8I1xWJMtH/OKFbtKvwjmnX+DjOCmHr0BMbZYAM8KYu3dNB4dAxMZ4Y+QT0eb1IF+v+CRv5B08IK+tcriOylBT9QGcfN71JHhnGWHt6ZZGBlhDyMYVdOVRq0UCx1hesZEz5j9LJR7w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QlqVjJu0QL0z/UwE52PRE9+6/oywqpYMjQjE5QTNNw=;
 b=LX8545j7FxhON9cV1TJkSyAQdjimkyGLzqEkASN+EZGcXSylChs6sE6eRYY8eZ7k4JT2pl3c5cLpMulnUQOWF0CoI4Egxknyznbxt+djbd57xYnYjhKU2kDk9BVaePNqV0VYTwt85ltRS2zx7WLIBupby7AiO0BaPwiBnBWq4wQ=
Received: from AM0PR03CA0056.eurprd03.prod.outlook.com (2603:10a6:208::33) by
 DU0PR08MB9821.eurprd08.prod.outlook.com (2603:10a6:10:446::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Mon, 14 Jul 2025 10:16:21 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:208:0:cafe::b7) by AM0PR03CA0056.outlook.office365.com
 (2603:10a6:208::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 10:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Mon, 14 Jul 2025 10:16:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZYuEZ/EwrCd+PJc5ga3Zp7P8fPAH8Ujt7svhvLTn82qj6C7GiCTu9KLYwxLIpxYXICiO3IofmYdMFF+P/8BpiPLbJ6GyGPM2+cZTjSoBeozjU9QhQw5Xqq+9PJUbUGqqkIy8rGpnDrnSHASady/iDauuJgOF1FXwAV6kZOn3m7rbfNSaRk/mP0GM4FyjIntXUYUnyqdpsq+pQ0sHsjsYhtG5YZHcgt8Rk8oe8IypgAYR6eIfQCGUxAezNoxeQ+9TKgppKl6bC/nlwMuwfPPKAJEODh6CGdWZPwgF1Se6aKFt58loSj2SIXyVIErCiBwCXgu62JEcN0dpSzs9pfvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QlqVjJu0QL0z/UwE52PRE9+6/oywqpYMjQjE5QTNNw=;
 b=Hmw2t7tf5A+bjR+XOXVHJ8YeJQpGNAbQCXaS5GloJzzPejAMM+8xDsiZrQlt5LN8xbOkKFBprI4+R+DM7HStzg/sLY9REx8PzOG2yC4HmBe9a/jxq9RPtpuC+LfQVf21uX2EoBoLrAN86YJWneZv7J4SVqECv0DTglrx9/P7XkQpflJpGOqwcwFfG6r7MXqecatiz2PBZuB4HQ0vIEETL25TwP9hGj77tIgdM1VMBMQc+TEi8hvj6BA919V1/KtiGIWKkyCAa5WZ9rhJYusexOiS9XDilCptJEW5kVy2Qy0gimZWC3KwAtmrnX/2xOX2KywFZmpjTuNgpZlJ9TwL3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QlqVjJu0QL0z/UwE52PRE9+6/oywqpYMjQjE5QTNNw=;
 b=LX8545j7FxhON9cV1TJkSyAQdjimkyGLzqEkASN+EZGcXSylChs6sE6eRYY8eZ7k4JT2pl3c5cLpMulnUQOWF0CoI4Egxknyznbxt+djbd57xYnYjhKU2kDk9BVaePNqV0VYTwt85ltRS2zx7WLIBupby7AiO0BaPwiBnBWq4wQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS2PR08MB10055.eurprd08.prod.outlook.com
 (2603:10a6:20b:645::18) by GV2PR08MB9157.eurprd08.prod.outlook.com
 (2603:10a6:150:db::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 10:15:45 +0000
Received: from AS2PR08MB10055.eurprd08.prod.outlook.com
 ([fe80::7a3d:5d7d:fa5a:b92d]) by AS2PR08MB10055.eurprd08.prod.outlook.com
 ([fe80::7a3d:5d7d:fa5a:b92d%6]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 10:15:45 +0000
Message-ID: <0f2993ff-75a1-4d63-9384-5c949bf2e8e0@arm.com>
Date: Mon, 14 Jul 2025 11:15:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH MPAM 6.16.rc1] arm_mpam: Enforce to recalculate mbw_min on
 configuration
To: Gavin Shan <gshan@redhat.com>, linux-kernel@vger.kernel.org
Cc: sdonthineni@nvidia.com, rohit.mathew@arm.com,
 carl@os.amperecomputing.com, shan.gavin@gmail.com
References: <20250626095208.1008871-1-gshan@redhat.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250626095208.1008871-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0663.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::10) To AS2PR08MB10055.eurprd08.prod.outlook.com
 (2603:10a6:20b:645::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS2PR08MB10055:EE_|GV2PR08MB9157:EE_|AM4PEPF00027A60:EE_|DU0PR08MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: 899ad580-a551-4db8-13dd-08ddc2bf7b0f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aU5FK01pTElmQnFmZzQrU2FjaFNWV3YzMzcvNU8xNnBMbytBbVlIWHplMjFy?=
 =?utf-8?B?dzlPYnVpRW5maWtJUXdnajB0dnpjWjhPcHRHb2VSWlFXamlSTkdBRXg1ZnVi?=
 =?utf-8?B?aEovMTN0SnNKOCsrTnd6RmlSZFI5Z1Z0K0xBcEFlUlBIZUQxVHZYeTBwWDY2?=
 =?utf-8?B?eTUrMjA3ZzQrek9pQ0MzZTVaWEw5bjYrWkNZMjRwNFQrWFJDUkhmSHdlMWJk?=
 =?utf-8?B?cDB3R2ZOeEkyVkdGQzh3bkxra2pMcUlIR1ErUGRYbHBUVDhkZXVleE9wVXlG?=
 =?utf-8?B?bjA3ZEFybmVxK1JZQ3c3R3dwL3BGWHVDd1cxNkptMEZ6TndlZXRTRGViazdJ?=
 =?utf-8?B?dURSeWJHa1FPOEJkdUMwOWdwNFI3QlphZW5JVC9LQlJmRS85RnlFMzI2K3or?=
 =?utf-8?B?cksvblhqY056ZnRsbDhUeUU3QWJxVE10c1BTMjhxZW5aQVhrNVBBN1BNMlhw?=
 =?utf-8?B?MjN0eVFPU3lzRnN2c2pwWWhEZEpmTVoyeXl0M2hWR2kxeVpLMDMwSzJ3TzFW?=
 =?utf-8?B?ZnpUQ2FxNHFFblFPOGtyN3hGek5DNTByNWQweWZ5TStJMEJrRjE1bGhyRnZq?=
 =?utf-8?B?NTI1V1BlbkhXWXUxaVdlME95T3dPQVVlN0tOVXU5N2FMcFN3VXRvdXhUNU42?=
 =?utf-8?B?WjN3MFRTYmVjd1NJWGErS2lNKzBXVFRKUGtLeUVMTUVDeEs2dW9rV1FPYXJ3?=
 =?utf-8?B?VXUzTi9OV0YzRlRjc0RrZkNHNDE2NDFFM0VPb3hQSytoOFhpME5WNTZmdGlq?=
 =?utf-8?B?aVR4eUVnSCtCOVJqZUhlVVhQTTFvM1czYzFIc0ptZ1pDQVpTNzJ4dVg3ZDBS?=
 =?utf-8?B?VGhFaVNiWThVQmhocUtaOU5FMHpPZ3lwSjQybE41Qi9BaHE2TktiZ3M3bTdG?=
 =?utf-8?B?SDhCNzlsUmwyOFhoSjlEOTRNN1BjZXBtNTFNUzlQRHBUdUhEZithQkJ1MENi?=
 =?utf-8?B?KzJOV1J3K3hEcWJvRkJrcHJOckVzM2k5eFY0c0I0UDNmSVYxTEwzMEdobWQr?=
 =?utf-8?B?OTdoOGhTWE40amlTNThMc0tuWVJZUTlPSlc1YW1VQmI5WHlhZ09PNVRld3hl?=
 =?utf-8?B?T2dUL1NXNk03djhtMTBOc0YrT1VUV1FiemZjR2J5TFI3WkJHRTFoMXVpVUY0?=
 =?utf-8?B?ZzhabnpiOE02bGJwYW5DanhERkt1dzU0eEkvOCt5VzVLcWVZQWFWU2tmUFlU?=
 =?utf-8?B?aXBySUlrZEl0ZHNWZUJubGZBbE5HV3BkZlpHSnBtbmEvWEd5NWVkclp0bXY0?=
 =?utf-8?B?eVdiVW8yelRxT2NVMFJvMGRwMUdPMGdWZGN6MThBU3BZeWI2MGt4NGtYVzhz?=
 =?utf-8?B?bkhhSkpLSXNkZXR5OFVWRWJYNG9aVnJzWjJUc3E2bzZveHNhUERmSmt5SFdi?=
 =?utf-8?B?UHpXZTNsemNwMFhuaWFIOHg1U0NuS3VJOVlYZ3MzN1hiRGVLSnc2d24yaWRU?=
 =?utf-8?B?Y2laalk2dUo1Uk5kR0JNd3FGVGZkZ0Zsd1pxR3FkRm9yRUJ4bnNrNkZobEly?=
 =?utf-8?B?NnFWVTE1SUVkZ2VMQkdQZGoyV1o2elhhd2M3K1hjZHpkQ0RYZlJYY0Rua1BQ?=
 =?utf-8?B?RmF5akpZUHVKRTh0UW9aUmZDWlJDWUVtYmcvUnY3QlZTNlZwZ0dJUHBsWlUw?=
 =?utf-8?B?dUtCd01rVjdhZk1BZE83NzBzOENTUm1Fd3dxK1dTZXBMZTJ6NHdZd25ZV3JJ?=
 =?utf-8?B?MlpNalUzT21STCsycmpkcmc1U3dlcUk0QUFGbDFlL0daQ3A5Q1lEWGYyWHNx?=
 =?utf-8?B?b1FsSGt2dzdZVUNWWUJ2S3JGY0lPU2ovelBPMkxxTXlSTGlVSEUzMEFJVzho?=
 =?utf-8?B?MGNKSGxBaFBULzZKdzNPaFFmdC9MVnhyQmV6amZqNlp4WEFCR3Y0UzJYWldm?=
 =?utf-8?B?M0RvRnJpanhrNnA0c0twdjZVVlJtN2lSUVNGZmNNYXFRVk9KS09TbWJ1WHJr?=
 =?utf-8?Q?f1yZT2T7yXY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB10055.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9157
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ce7b14b0-fad9-41f1-203a-08ddc2bf654f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjJ2OTd0NjBxRFFPTXMzY1F4K0puSk1XQStSVmg3enQwd1hPMXVkZG5sQ2o2?=
 =?utf-8?B?UW1FRVdxVE1UWjJHUjY4czBLQmZiZnhSc3hwMW5SUWZ3MmpjNjU2L3F4cHBx?=
 =?utf-8?B?a01ycnBaNW42NC9FR2xjZUhlN21UNWtMc2VZMFhtVzk3T0FCRndwSXQ4SFNQ?=
 =?utf-8?B?MGNveDJ2ZXA1UFFnSXhUMnh4cUdpTVdRRlpaMyt3cURmS3ZtT1I2NkU0RlJy?=
 =?utf-8?B?OXRYOXJMR0doZzZ2a3VBY1h3R3hPdzNIaTBRczVNbThJTnZOS2VWM1ZWdWMx?=
 =?utf-8?B?VzA1SGJoQzZjRTdiU0pmZkFVcEkyTFpzb0JtYkhyWmhYNUNLUmZCMzM4OGdk?=
 =?utf-8?B?YzZNMHBQb0llamFMZFplNnozRHdsT2MrRWowMllJTmlwWXJURDZTUWlvdGFS?=
 =?utf-8?B?V0dleXUwVkZ5TWwvaGFsUit4ZkhSNmt1UnZXTjdXdC9NR0ZFSGVBaFRySVlv?=
 =?utf-8?B?UU15MWVVNGhrRGFpVjBDR0M5ZWhBWDMyeXprK1E2NmhlMmNIK2Jxd3J2MC9o?=
 =?utf-8?B?dWhCMFBmb2JLdFd6VmNxQmE4VVRONCtqc2c3R09uNFRWeGlxbDVVYWZiU3pG?=
 =?utf-8?B?QTAxL0FoRWNjcFZGcVc1SnFWck11empPNVM0TzJJcWQ5Rzk5R1lsOGxnajRG?=
 =?utf-8?B?TDVraDVSZjlFOUVKVkk5bjA5TDd1a3JVUEpBMlhETUJtbnlaWjdLY2IzL3RB?=
 =?utf-8?B?MmZEdnF6L20vbHZUbkFnQ01KZDFhQzF1cmc3SjJSM0xLK2VtVk9ISDJzNm1O?=
 =?utf-8?B?STgycDgzMGwxZjlrK0Z5eEpJSHcwd1JoTmQyZGIxOC9hR3Bzd1dZVHJDQnRy?=
 =?utf-8?B?L1RyM3RLWVhHVmhod2RpUVo4Y1UxNm9zZ0hjQVJEQVBDYWsrTzVhbTk5Qy9a?=
 =?utf-8?B?S2VCaE5LeU9tQ1k3N1VRV2kzRkFuVlhBS0FsK0JmUThyNnJiTWJaUDNDTmZG?=
 =?utf-8?B?UkgxeDhGL1d2VGsxY011eVlEelloblNFYlU2TXRxbjBOTm1ia0hmUVBaOUlP?=
 =?utf-8?B?UnNoR3dqVWZ0Y09rVmxRSXNFWlBpMHpUREtGbERGKzVoK2JiQzBVc0szQ2RP?=
 =?utf-8?B?MERTQUlIbkUza1FFd1RMR3lMYzBQRnJ6Ym1kUUgyc0hZbWpOeXlNN1FEVXJi?=
 =?utf-8?B?dFMzMTJoalZaRCs1S0NpdkUzWFBwQzN6dVlKN2hnS3ZtUUdQL1RNU3RxMG0v?=
 =?utf-8?B?dDlHMnNIeVlnZE1TN3Y5R0c2K3VBb1pqTjBWalJZdUVuVUk5SHhEY24wZjlW?=
 =?utf-8?B?WEpqUlU1NGJaMjl1eHZIeE5ENmJvSFRoZXU3clhydTVwdlpBN0J6aVFpOGpU?=
 =?utf-8?B?Vm1qcmJTdUJ6cWZLRUg4RnkxS09wWVlVNDRGRjhaVnJ2S1pwM0dWWFNOVHpx?=
 =?utf-8?B?cGQrOTlHS0JTS0ZML1NZTmlXdXQrdGsySStJNW90TmVKZWxsbDlHc0VyTVV3?=
 =?utf-8?B?UGF6a1pqRy90Wis4Tkw0OUFFajRUUHJrVE00SmhZb2d6RXdYdDFWQW45V2l3?=
 =?utf-8?B?TTl0MXdnYmZ4RnNuditoYnZZLzI2UVhHa09VNEd4TEg0ZW5QYjdCSWQyVVNr?=
 =?utf-8?B?N1VqWFFkWkRQeHJLY0N6ZkdWbVo2WllaSDNXQkNQVmw1bnM0VG5VdlVCUVBX?=
 =?utf-8?B?TGJ3a0hpZnh3WVkwSDJXb2NQRW95VlpEeGVITDJNQnh6SHR6N0g5UTZndUEv?=
 =?utf-8?B?bWVDd0E4cG1KK0FXVUtqZG54UTFLRjJybkJFNDduaWp2b2RxcC8vckdPRkVi?=
 =?utf-8?B?cis3VFZ5OXJISnhoOVRXOE9VSDdQUEt4VFQvdnRXTno4N0FBMzFwbUFSQ2Y1?=
 =?utf-8?B?VEJHdGtrZE1iYXBWNDZjdnVXL21DVyt3NVlPK2c2OUZDZmNxUHRVU3BNQlkz?=
 =?utf-8?B?UVJhV1YxcWMzeHVaRWpYSXhUd0ZvVzRNODZFN1NFc25teUlkUXNncnM2Ynlk?=
 =?utf-8?B?LzcwQk9ERjQwVkwvdnMvNmlEekllbmNwM3VvUGxxQUgxQTJLOFVSSGt1Ry9W?=
 =?utf-8?B?SXlMak5pM1NLM05RK1hlTkVVRVI2UTJiMTVPVnNXMmFuKzExVi9GSHNXQU1O?=
 =?utf-8?B?d3ZnT21LajF6djRQRTlIdjRSRk9GZDhNVElHUT09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 10:16:21.4603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 899ad580-a551-4db8-13dd-08ddc2bf7b0f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9821

Hi Gavin,

On 26/06/2025 10:52, Gavin Shan wrote:
> mpam_feat_mbw_max is exposed to user by resctrlfs, but mpam_feat_mbw_min
> should be recalculated based on the maximal memory bandwidth in every
> configuration, which has been missed unfortunately. When a new group is
> created, the default and maximal memory bandwidth percentage (100%) is
> configured, the configuration instance (struct mpam_config) on the stack
> is updated, including the minimal and maximal memory bandwidth. It's
> copied to the domain's configuration instance. On next time when user
> tries to configure by writing 'schemata', the minimal memory bandwidth
> isn't never recalculated because mpam_feat_mbw_min has been seen in the
> configuration, which inherits from the domain's instance.
> 
> For example, the value of register MPAMCFG_MBW_MIN is never changed no
> matter what configuration is set.

Thanks for catching this. I think this was introduced by the patch that picked
the component copy of the configuration, modified it - and passed it back into
the driver. That had the additional side effect of changes going missing as the
mpam_update_config() had the same config twice...

I fixed that shortly after rc1, with that fixed I don't think this can happen -
resctrl never sets the 'min', meaning mpam_extent_config() will always regenerate
the value.

This shouldn't happen with the latest version of the tree.
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/v6.16-rc4




> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c
b/drivers/platform/arm64/mpam/mpam_devices.c
> index df8730491de2..4845dcb8e601 100644
> --- a/drivers/platform/arm64/mpam/mpam_devices.c
> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
> @@ -3192,6 +3192,9 @@ static void mpam_extend_config(struct mpam_class *class, struct
mpam_config *cfg
>  	u16 min, min_hw_granule, delta;
>  	u16 max_hw_value, res0_bits;
>
> +	if (!mpam_has_feature(mpam_feat_mbw_max, cfg))
> +		return;

N.B. - The T421 quirk needs to ensure the minimum value is never set to 0 - which is what
mpam_reprogram_ris_partid() will do if there is no minimum config set.

The aim of the quirk is that on affected platforms the mbm_min will always be set, and
never be zero in any configuration. Whether it then gets applied to the hardware depends
on whether the hardware has the feature.
This makes it simpler to think about - and easier to test on platforms that aren't
affected by the errata.

I'd prefer not to to try and spot configurations where its going to matter as it will be
hard to debug the workaround going wrong!


> @@ -3211,23 +3214,17 @@ static void mpam_extend_config(struct mpam_class *class, struct
mpam_config *cfg
>  	 *
>  	 * Resctrl can only configure the MAX.
>  	 */
> -	if (mpam_has_feature(mpam_feat_mbw_max, cfg) &&
> -	    !mpam_has_feature(mpam_feat_mbw_min, cfg)) {
> -		delta = ((5 * MPAMCFG_MBW_MAX_MAX) / 100) - 1;
> -		if (cfg->mbw_max > delta)
> -			min = cfg->mbw_max - delta;
> -		else
> -			min = 0;
> +	delta = ((5 * MPAMCFG_MBW_MAX_MAX) / 100) - 1;
> +	if (cfg->mbw_max > delta)
> +		min = cfg->mbw_max - delta;
> +	else
> +		min = 0;
>
> -		cfg->mbw_min = max(min, min_hw_granule);
> -		mpam_set_feature(mpam_feat_mbw_min, cfg);
> -	}
> +	cfg->mbw_min = max(min, min_hw_granule);

While resctrl doesn't use it - the idea is the mpam_devices interface should support any
mpam control being set. This overwrites what the user asked for.

The devices/resctrl split might look strange - but its so the resctrl ABI implications are
contained to one file, and another user of the mpam_devices interface can be added later.
(KVM in-kernel MSC emulation was one proposal, another came from people who believe they
 need to change the hardware policy more frequently than they can with a syscall ... I
 don't like either of these!)


Thanks,

James

