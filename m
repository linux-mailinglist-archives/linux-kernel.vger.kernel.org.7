Return-Path: <linux-kernel+bounces-785421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3DBB34A70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003C617F401
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6296D303CA1;
	Mon, 25 Aug 2025 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XhGTd2Q/"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2097.outbound.protection.outlook.com [40.107.116.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93EE2798FB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146778; cv=fail; b=ocwmo+YnzwNt3jUM6Slfn/VAi3+p9k3MJwPsU8TGiW9viO/nnzczykmYd5qM2aIXCeiv9Ws/BJuE7lm5LdfzbN9i3EPXuOdoF3ThRh3Cli3VKJbzF0al0+/pMieTA7PXRGO+ZKynBtaZxQpdUxxwUMBJdT+QQ5pbRkRs9jM2FyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146778; c=relaxed/simple;
	bh=cXQUukUA9A58WuMlbnc71decXaDbO8fVRhNxoaKIGmY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IrquV2lxE0DpcSjw6rF18DK+L+jVHII+MkaElshLoK4MXczaVtT5izYzR1qxMdzTHyyZE0ZEBVx0mdH4WiqtujO6prTue981N5AnkjJCI/WvB2zmftue+roX5/uJIY1LC73TD65NzT7xdXQBTkAqCb0PdODtw9z2jjP6T9NkFdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XhGTd2Q/; arc=fail smtp.client-ip=40.107.116.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfPr84CS2o1K0cmHpSRotF16dO5A2Wd2cgs1KQmPDDmJFJOf22w0szrdo8+g/ZV029zIucv/IUH75GL2MOHCfbEjdnZtDc92bBTVhSfpeFUqESTC3+W1EaOsv9AvwP4zqLhDV5DZTqoK9bCv7fsUgJGWbYELmnvnMj9LrsnwPSqfNOg4Cya54Dge34mSI2vVs2uJmCdQBo/Sog7Bxtf5Pm/rZBJqpKjx3y7nsnGSpKs763bxNoIC6l9iDra7k1g2d0ucz+cJIVfDnO/9DlD/C8Abaw8LH2cePFrVPskYUQc+kmWWYPTBjXsb5YH+daFjbjOUMgQlPhXbnOWkHHE6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yudDD1hbh53ZNLNofUNngGsCm7QhNREuL8SfQh1KRKM=;
 b=w/REk56lJPg0hOavpZh8UCAmiHa0yws6Kz0H7PHIrsc1HHdMECQE3WWja7rSBuf0jNebMGgdWhv4jS33+SNZqNswgM9KGrPfTJyLPqFfeBpWVGhvhH6GqYvlc1BUMG7zDY03kx0VWpdGCnQ3qXRjAozzfBhfBeKI+lk/uJ5uUbdxV1mztiwMqI4Oc+OGhbkHBcPrGkaKywYrmiAFTBNnl/sXvpZz0VPJyU3Cnj2YXxLVbVTA1+NlSL/aGIEI/2DiP8E7+Hew6LAy69E/o/fT4117E4tiSa6pjrDFmqJd76R2XqMaxrJb10v4AUqcfW9HgssYo2Px6yTHB6jAq1/xcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yudDD1hbh53ZNLNofUNngGsCm7QhNREuL8SfQh1KRKM=;
 b=XhGTd2Q/3wIkjTnAf3MdS+U86RFha6u4bNJfira+XYFfbf2Q5iIfYa2RhLz5CZPM4aQr+WzSgZiMYGSuPi0ldbmC8zXRV9zXyV8Bz8I1wS0V4HF3Kr7bVU/JYd9ibIhKVcn417a11zv80lb06F45Y8I/0SFqZftrK/MfFIb71K5l+YgJ3p5YEOROkGNWmwHTqhbVdFCNY/TQllWlJeNU2nCyZxH27tw9d58bfb2WFxKsmEjtvcCIUaB0bpz9gVfmqrP8rGAEkF4wtliUDBmSM/XRwpL/EScIZyAFMBjM182dRqlz+qtQlRXED8dpMlku+j4Sj2Afqv9RzzvkoU7h0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB10553.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 18:32:50 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 18:32:50 +0000
Message-ID: <0f216140-f3b4-418e-b93c-e6b05ee4d8de@efficios.com>
Date: Mon, 25 Aug 2025 14:32:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 16/37] rseq: Provide tracepoint wrappers for inline
 code
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.292334353@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161654.292334353@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0254.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB10553:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c97b8b-adf5-4c70-f330-08dde405cc03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmI1SzRHYTNya29EWFBNbDRsMU14WHVRTkhpY2p6ZDFxY2hDUXFQbHMxbUNt?=
 =?utf-8?B?RUZjTDFnNVNxWmoyTHllSzVUbXpqa0trbjBMNG9nYnpwdlVLYnhKQ1djQUs5?=
 =?utf-8?B?VFlQQWNCQzhhelZTWDN4VGNBWldJdytFZ21HK0lkdzBrTlc2elFtRXFWMktT?=
 =?utf-8?B?eFRXaGM2OXNXRUxSZ0dMSzdWR2VsQkJ5RytIRXJGY2o0YnB1dmhZS0VSbVMw?=
 =?utf-8?B?Y2t1TUV3WUdpQjdrazNvbFlzVmFlRjN1NkJ4dXRvcE5kcVNDdFhwSDg1WDdx?=
 =?utf-8?B?VjBJWCttNmREUCtuaFZzNTJtR2dFdWYxYnpGV3dkOVVsU1lXS3NRQUJ1OG9O?=
 =?utf-8?B?dU5CdGRoVEVqWUFRNlM3aCtHUTdHL0JNenpacXFrV1BqaTNzc1JRU0ZYZGNz?=
 =?utf-8?B?c0hZcXNaUHNEa3RKNTBTcGtlZ0FKVGZWM0tJZDJvbWQ4WXNVNEpWQ2hjSm0x?=
 =?utf-8?B?SlJ6QmlTZTd6SUpKUmZxaWQ1MDlYdUJYTFN4V2srZnBQbXNDK3JLYkxjTWl6?=
 =?utf-8?B?WFpFNmcycVBkMGozRVhXVlhzTFFmSEdGRFFyLzVoak5RUlVJQW9wMHRUcDg5?=
 =?utf-8?B?dXByMjllWnZGWHE4QWhRVTdMUGpLYmdKSVhGYVBhM3NBNk53clhzM3BzRjlr?=
 =?utf-8?B?Ryt3Rk1WYXFjQlFWSS9iaG5JUHZsZnN6Y2VmQW5ucGFwR1ZsQUR5WXJOcTRG?=
 =?utf-8?B?QjB6eDhWbURRR2prSVc0a0ErT1cza3ZzeE9lbHNLbUN5WFpEalIvRldzcVJ6?=
 =?utf-8?B?VTVSNUlCdzRlZjhKY0pVN2RpbEhPcFVEV3pzZm5abGRPM3M2Z1pLaklxY2JF?=
 =?utf-8?B?RG0wSmtZVUs1aFhBOXdBTUg0bjlOTGh4OE9GTlRNOHlxeE9mSDRQZE1RaTFK?=
 =?utf-8?B?ekxwNW5UVXdaMVpuMm9YUjd2WjhuQzg2djlzT29Ybkx3NkNUa05zbFNNejBZ?=
 =?utf-8?B?cDBaZ3NMNkpjQk84N0tXZC85UUJ0blA4dC83emVYRlJHU1UyNXJPWHVvMTA3?=
 =?utf-8?B?UVFSU3BCVW1LSFlhSVN6N2ZhQWZSTDYzK3haUXdzT3VCLzl2cHBNMkZVaUdY?=
 =?utf-8?B?Y0l6S3BCN3UzSWpXdlNzbnozMTZxblNxMjIrU25mZ0k4ZC9TNXFPSVRyZ3Nh?=
 =?utf-8?B?TTM2ZGZRNGthbXNnYmF6NWoyQXF0UzlkK1BEYlNxOTl0ajJlNWZyMnBiWWg0?=
 =?utf-8?B?THlsK3ZXbUNwRFd4L3F3VUFVTXhBbDZ3OWpzQllJUHNCRENVMDRLVWxzOGFW?=
 =?utf-8?B?K1FTK0srY29pdWI3WmV3dkNmc2pkOEs0bHEyMnZoQlpHbXVVU1BaMTQrVmpE?=
 =?utf-8?B?RGY1MWNnRGJJQ2lQTzI5aGQ0YmZ2cytTc1AwNXFTV0RZZ1cvZThEZ2hMVUR0?=
 =?utf-8?B?SnAwb1NBMDVvV1ZMQjdtVWxwd0NneGJsY3FvK3ZjOWpIMU1CTVNaWVlKaXZ2?=
 =?utf-8?B?aHN2UjlCMHVTcHVnTnFYZlRyUGppaEVKVllERjh1TjhaYXkyNElaa21VZXFq?=
 =?utf-8?B?cVhCdG9XajBEVDVWZU01djAzeUx1Zk9FRVNPTWw0RWRJTnNXR2pBRWV1SER3?=
 =?utf-8?B?c013SndGeFh1Qk1abjV2S3V2ekhyenBZdE5IUUtuaHVsamtadGgxNGttbTRn?=
 =?utf-8?B?a1RYZm5oNzJPOTBXRGgxbVFXbUt6RmtraUFLUjlTMDdFYlJFVnVWSUdZSzF5?=
 =?utf-8?B?K0NNU0d0aEZNWkgzWEVWSEVKQnp0OThlbXlaMGdzdVloN0tNYlNuSnEwN0dn?=
 =?utf-8?B?YW0va3h2dFI2UXVUN20rU3JOaDZBOCtUQ0VTVHhsVE96cDJGTWZMMWc3cnRY?=
 =?utf-8?Q?eljVMUqHqavtRZcUhf4DxTInUN+/v9sRBeqc0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkxObGVNY2FaRjBpdXlMMERZK2RpS3dEZDZQb09rWGNocVBSZ0huN1MxWUZK?=
 =?utf-8?B?dHBDMUs2VDNMMktJa1FvaHdDSVN0djNSKzNYM2J2bUxFc0VHdTBWeW4rQ1A0?=
 =?utf-8?B?YXovSTI5bnBLRUFTdjRpbDYva1YrS2M3ZzVHUGx2WXN0MXZ0YnQ3aGFib2pn?=
 =?utf-8?B?OGlmdDhBUDlZc0h5V3NaL0Qwd0NiQjhPakx2OThhcEpGMkEvaWxrUFlDUGJi?=
 =?utf-8?B?dzg0SlJBM3lPMmFsU1hDNjlveklyRHJTMEpvRFlkSGdNQXgxNEdiYnZHZi8w?=
 =?utf-8?B?cmQ4R3dzZm1aTzZ1czR2VXZ5TW92L2Y2bG42d3M2TXRYU29ZTGZ1b3EzZUE4?=
 =?utf-8?B?eGNpQ0xwU1ZCVHFmUlROTjI5a1lpL1YrY2psbXIreWVsVVJNUjAwcG80TXZw?=
 =?utf-8?B?R21zc0daQU4zd2lNZDBZdzRqREdkVGpjMkVuSW56WkFyK0xvaTNZMkc0b2NP?=
 =?utf-8?B?aWVkR0h5c0Q3Mm5iamdmbWtZNFk1dzlwaGdGQXhjOVM5d2VUNGF2L0VaaHRP?=
 =?utf-8?B?NGVxWmU0VWJDT3FZbWJJOEJpbmk2blh2NS90UDN1U21sSHRxTmluY1V4U0ww?=
 =?utf-8?B?WFhxSWRVVElXOWpvVVFDMHlRajdKdUo4Tm1ySWZmalo3NlFiVnBHL1lVd0sr?=
 =?utf-8?B?NzZOb1U1Ry81U0tGbk9NaU1yMytseUMxR2UraGxGNHUrUkxKalNTRnVjdlNS?=
 =?utf-8?B?b1hpdDVoc2E5Y0VYRmJzaTRONjU4cEcwRCtXaTR2VlI4YjBIT2FxVHVxTDBt?=
 =?utf-8?B?UlR1bzNrOEdRYVAyWEloR0g2a3krSXp6MHpEd3FGNEZXRG1lRkVwTGxWZUNM?=
 =?utf-8?B?T2xMTExmeGNCa2ZVbXhvd0M5djZiMExMc1N6MmJTZHU4NUJDRzVXaGtwaUky?=
 =?utf-8?B?VnYrVVRSVHFBUktveTFONmZJcTJ2Ti8rVmVmVVh2MmF1ckJ3RTc4RkxYMGRj?=
 =?utf-8?B?QlU1YkUzWmlGRWlTdERuUTVEVEFLNHdpVWZnb1dqS2dhSnhMZmxFMmZ5UVgx?=
 =?utf-8?B?N0ZraFdDdEZuQVRWL2VLMVV6ZzhsL1hLbDkwTHFSVkY3aWxNS3VqRnJDU2py?=
 =?utf-8?B?STRZWUh4VUhuRlZVZUxBVFRiTWt6M3RoOEVpZXVzRTBEVnczaXJhRFFkOTNY?=
 =?utf-8?B?d0RNeDFOTkhRdkdRdUg4SkZuMkNhNnhPa3JzejV1WnRYQzFZaEJEN0R5ejNv?=
 =?utf-8?B?V3hPc2NDK2Q2dG5Bd0tWbWtWWDFVUzI2WmQ1T3RGOUJ4aE1INi9MYjdSUGs3?=
 =?utf-8?B?ekRnSGNtVkxVNFRwV3ROSDRYNjV2d1B3SEdTOUlUOW5PYVNXdTJIbWlxUFo3?=
 =?utf-8?B?azZreWRkVkJvME1Eb2ZONkdXbXZkM0hJTVFkV3l5eGZvZjhmK05QTFI0L0Nn?=
 =?utf-8?B?bGpMeEpwZWRQUkprazlMQ3YxclhQT294U3llekJzMTNVSmJDaVVaeFRKSmV1?=
 =?utf-8?B?c3cxc0xYdnRpby9rY1J5aVVTZFRIeCtsdjNpUXpxcGdiY1kxd1hMMk5Wc0FT?=
 =?utf-8?B?T3J0Wk1BRjhVcHdIdW9paGdPRGJCaUt6N0w5MXdTdThuQnV6QXB3QlJGaDFo?=
 =?utf-8?B?alRvVU5mK0pXb1B2NUs5UmQyTE51VzN6RkVUdjdkVWlJVUQ0Y0ZYTjh0Z2lN?=
 =?utf-8?B?QnNqNTJCcDRDZmVLalA0d3hNTSt6dnROaWZ4YWhTUmVnSG8ydTVLV0lSUDUw?=
 =?utf-8?B?cHpNR2tZM2hPSDBMeFZPRnRRaHMrR1BpZXhuRm8wOEZyUE03cGRIY3FSYXdY?=
 =?utf-8?B?Z2FiMjR4cWcxUFZ3WGZ1Yjc0QitZUDA3VklHT3JhTFF1a0c5RFdVNHFoV29G?=
 =?utf-8?B?eUpEVzhZSFJ1QTRtbWpJbnR1by92R2tHOTNvMUFPRytuSnhFQWdzZlBNRXJU?=
 =?utf-8?B?a1hocG9xYTBlZ1FtTWhtVjEyQlFhY1NtMGIvbCs5MjhENTNWZDFGMVZ4SzdH?=
 =?utf-8?B?czV3MFp6bENmaHJsSWF0Y0tNMklRbzM4N2lzSytZaHBZYUQ0djNWU2twK20z?=
 =?utf-8?B?WWl4MW55d3FVTkVlaHVLamJ1aWZDMkxqeWdpbzNOSHVjY2I5UGZSSmFqL0kv?=
 =?utf-8?B?Zkw0aHJwcTFnbkZxbWYrR2xSaGZzenIvS1VOQTNiWUtidEhxTXdnbE4wTmpU?=
 =?utf-8?B?aUNXQ1lCRlJiUXhHaGdJcVNmVjZ2NDNISHR4TUZvZGp0UVg1K2VGZGVaUkJD?=
 =?utf-8?Q?FH/BE2JlVgDhD5hDMUBIYxw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c97b8b-adf5-4c70-f330-08dde405cc03
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:32:50.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nogM3wz391cOYwORpYR/63taDYzUXr6KSsWXZX5w2wAg7VG5C2mIwpxJvI5s2I1h6wHt1fR1gdVhwSj3YwA1B1/yngUjIb+16PgIJBTm2Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10553

On 2025-08-23 12:39, Thomas Gleixner wrote:
> Provide tracepoint wrappers for the upcoming RSEQ exit to user space inline
> fast path, so that the header can be safely included by code which defines
> actual trace points.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/rseq_entry.h |   30 ++++++++++++++++++++++++++++++
>   kernel/rseq.c              |   17 +++++++++++++++++
>   2 files changed, 47 insertions(+)
> 
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -5,6 +5,36 @@
>   #ifdef CONFIG_RSEQ
>   #include <linux/rseq.h>
>   
> +#include <linux/tracepoint-defs.h>
> +
> +#ifdef CONFIG_TRACEPOINTS
> +DECLARE_TRACEPOINT(rseq_update);
> +DECLARE_TRACEPOINT(rseq_ip_fixup);
> +void __rseq_trace_update(struct task_struct *t);
> +void __rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
> +			   unsigned long offset, unsigned long abort_ip);
> +
> +static inline void rseq_trace_update(struct task_struct *t, struct rseq_ids *ids)
> +{
> +	if (tracepoint_enabled(rseq_update)) {
> +		if (ids)

Does it work if you do:

if (tracepoint_enabled(rseq_update) && ids) {

or is there some macro magic preventing this ?

Otherwise:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> +			__rseq_trace_update(t);
> +	}
> +}
> +
> +static inline void rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
> +				       unsigned long offset, unsigned long abort_ip)
> +{
> +	if (tracepoint_enabled(rseq_ip_fixup))
> +		__rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
> +}
> +
> +#else /* CONFIG_TRACEPOINT */
> +static inline void rseq_trace_update(struct task_struct *t) { }
> +static inline void rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
> +				       unsigned long offset, unsigned long abort_ip) { }
> +#endif /* !CONFIG_TRACEPOINT */
> +
>   static __always_inline void rseq_note_user_irq_entry(void)
>   {
>   	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -91,6 +91,23 @@
>   				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
>   				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
>   
> +#ifdef CONFIG_TRACEPOINTS
> +/*
> + * Out of line, so the actual update functions can be in a header to be
> + * inlined into the exit to user code.
> + */
> +void __rseq_trace_update(struct task_struct *t)
> +{
> +	trace_rseq_update(t);
> +}
> +
> +void __rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
> +			   unsigned long offset, unsigned long abort_ip)
> +{
> +	trace_rseq_ip_fixup(ip, start_ip, offset, abort_ip);
> +}
> +#endif /* CONFIG_TRACEPOINTS */
> +
>   #ifdef CONFIG_DEBUG_RSEQ
>   static struct rseq *rseq_kernel_fields(struct task_struct *t)
>   {
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

