Return-Path: <linux-kernel+bounces-785115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D27A7B3462C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFFD47B3C31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF082FE579;
	Mon, 25 Aug 2025 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HW5B6XaO"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020139.outbound.protection.outlook.com [52.101.191.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E042FDC53
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136601; cv=fail; b=hrHZYcyV9IyhMjWZNGRwLv/caB5I1aaXymm6IlFu+GGGKA3PW77vmjTWiPyX0CYOqJHlIaIAIj+BXqMaJ7+EObLCPqTHrcX2NHufoL90qwXMiFttd42s5aRZDXu9ajTQyhHb2oPVzaF1Gw1Z/6yIqqNUZrR2cZNQ26e5EUdGy0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136601; c=relaxed/simple;
	bh=v7Aq2Fmz5poudv3jrToXtXkjdhU+JfgdiswoLxZ8zzg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V7VYLbAc5dyA0TBM0Ngt9WobUM0L0oT5RnJtu+9ngZ5VeF4ZwRX5FyqfnSuUrq2b8ff938vTPD7N7hi5yE+0XkkwuT4DfwpLIPt8mURnwhQ4VojWKQrts1W4g0Cjxu0cTc7J7xzK3m9uTvtWZ5Rdo5pcaY02t7Fc7UrBG69CvB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HW5B6XaO; arc=fail smtp.client-ip=52.101.191.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsQTp9ne+KYDjCf2Uw4tzOQzCb9oU+Pyii+38OjyLhomPnYT4DE37DZPsa6nU2JASfnsCOEJiwQQ3FCxm4Npp/ju8W7GHfMUfAdZIzjnMofJCOgdPA6rnxCGk2D6aOEZbTBFMv77V8I/8WYOc6kNHQDpG6XLsQ5RFCx391c1knu+xpo6Ic4u5ItpyJlXd0ZvL114WoPm8PbL9VpNXDW8FJdvdk/4RpWn777q7CM2gA+M/Xb6QL1WgEdLiTV24feZSpt3QzpHJgpdZhdasW6RCh8e7gpgB7q7vxUgTu10qTOaI9Gs74XCnQEvKiV+7H3osDJ2jyWwRByQwPYmfVaMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezgrDIMtd0UbjhsEcxCpOUkwan/Ho1jaujEfN71IZ/s=;
 b=dskQojd/T3QtfM8HXLKcWdBVAtFEVyiy7Fkl5iExv5WDjFZAowrKypZKZEi4L5AVNJ+xZQPvDFGzhqRYsUIfoBASBeVoIghoOKevI7Wdj3z5dS50cHHnqkZm4743OVnz4ggQY9Xr45C9iv/GWpn8m5DeChRMlHbPLFsPHRo/bJzaX2405g4KPAzWKhIKvb4H565uoTaIAGJfLZcArMPFqI6rIuhqCCnupWwYeMOgBFWmn+xftpTMLsXhAm9O+P5ejlaHTIRN27OsCZc08NjXcBg2TvyhIqOpu5ZQwUb6UO5zMf5bft2lFT9oCGZdNKZ6xL8PN/MECYYLS9YjEMljog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezgrDIMtd0UbjhsEcxCpOUkwan/Ho1jaujEfN71IZ/s=;
 b=HW5B6XaOPSHkvs7T2CCrMjpqNWPa2AOp85Z+vkqjhQHaJpCvYJlWz5h7exyapH1h+CGvkOpXeKswc4j/H42GWJ5dGzCGxa3BRy3RSH7Mvu/7BKh1arNVF6uw80a0pRKM5t7QxaWUCNbrRpWo9pQd1qMYckJzYSFAWItD6zotZ/8eka0TtUBYQrnImrtTsq8eVc1YiKyJmsT7hckzMxIz3jA2VwWKhCLDWKFGaL/hMjF+Ip5ZeSTS8vZS1oDR+fArb2uWKr5Bio/YB+m8wW2NWX4+8usSXWaNLBp8hlo+9H9mbtCJ6wuTcpNLvBqodFRGl2969NIrHYP/cuWfrcKGuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPFB0A9C7B87.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::578) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 15:43:12 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 15:43:11 +0000
Message-ID: <e7757033-3746-46b7-b776-4db269b0499c@efficios.com>
Date: Mon, 25 Aug 2025 11:43:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 04/37] rseq: Remove the ksig argument from
 rseq_handle_notify_resume()
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
 <20250823161653.516925982@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161653.516925982@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPFB0A9C7B87:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b2d805-e111-42e7-1cef-08dde3ee1891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUpPc1dxc1hvSXU4bXFvR1c3TFBvU2tFS1RUOWJqZW5HVU1FRHp6M0QwSXcw?=
 =?utf-8?B?QnFqZHV4SlN4TzI1ZlB0VjRZTktCYWdXM1YzNC83cWpnT3FWcHk4dW5hSXhI?=
 =?utf-8?B?bjJuV1Fjc3BYNFFaQUMrM3RBNU9jN0tpVk5DQTNYWWhGQkcwck90bzh1SXpP?=
 =?utf-8?B?NGt4dlc1bThiQnVMWWR6MzFXR1NKZ1hzZFdaQWpkSEMvdFRzU3RDWXRBRno2?=
 =?utf-8?B?N0NidjlIcGp5VFdzUFNhMnpIZU5hWTYrVXhlUGZrUFlLT1lkOXhDVXR0STJT?=
 =?utf-8?B?MmQ4enlMWjdab2s4eko4NVlrd2FsYjErZHkrVDNHVlRPMUozNmhzVzBobDBt?=
 =?utf-8?B?cXBMMXhESUJYbjlVVnRBWVdtVWtjdWp6YnBhdG12MnhZOU1KZVZ5a0wzb3Ns?=
 =?utf-8?B?bTJ4dHBhSUNITGswYWxudE5JdEhuRFdrVFRPVGVtUDMxelJ2T2t2VXhlY2pC?=
 =?utf-8?B?RUl2WTMzR1dMTEsrR2tkY2lNZUVWeW43Z3dQZ05rajEzWEUvbERzYllxV2dL?=
 =?utf-8?B?ZmRYNmRqSlZGSVh3NE9JY09PNWo3ZFk2K21SZnRkSm9WaC82SXVBWklVNVA0?=
 =?utf-8?B?MTdMOUlZc3NjZHI1YkEyb1B2WXYxMFZCdCtVWFJsL1lDd0xJQjlwemdRZjJ1?=
 =?utf-8?B?a1AvRHFUYlQ4TVNLQ21INmlSTE5FSE1WRlhLVUZXUEZWdkFyYW12Um51TllY?=
 =?utf-8?B?MGZ4ZEFzQ2g0WE9xcXNoNW9MOWs1cUFWbTJiWFN0OEJjQnFpSCtEdXdWWVhj?=
 =?utf-8?B?eFpBZVRBWHF4a0E1RGhGb2hGUG1COVJrQTlHWUFQZnA2ZllaS1BvSkllM1px?=
 =?utf-8?B?LzhqRDVmUUN0OEVyY2N3amQ2T2tqbzcwUFpDNmJUeHdGU0QvUVo2dHhaMVJR?=
 =?utf-8?B?b1BJRERFSEVCTm45Nzd2YmRsZ0lRa2thckNoRmlTd1ZDVjBQMm45UWZTYXRD?=
 =?utf-8?B?RjNZb1JQRU5oZjFwdnBxdEZ4K01BenF2c0ZabTNiS2VUc2VRVmgyd2hRMGNs?=
 =?utf-8?B?Q0F2aWRhdnMwQWR4Qm1VdC9BWXpDSVQ5ZzI5OHVvcmVoK1MvajkvLzU3RENV?=
 =?utf-8?B?cWZYYXJnbVA0Qlp6OThjeFFMbW0vOTJpd0szeUNQNHgwQk85MnExY2RqS0x4?=
 =?utf-8?B?b1VoRlA1bDlHcXYveExuV2lYaktQUmJFc3plSldPZ25qV2d5Q1pvblUwTDh4?=
 =?utf-8?B?Tks4S1piR1JWajNzTjVWOG9UdXFjM3NZNTRLSU5aYkNPeTBEZURHZVBkT3Fy?=
 =?utf-8?B?SEdXVVQyblBGUE9iRkY0UWtsZ2RDQlZKNnNyL2xxcDNoeGdzZXMzRHpWUmN2?=
 =?utf-8?B?U1ZvNEZtMU9aNEN2N1ErYWhCeFVxbVhZNlJoeTJjRjFVMTFmcXJLSTI2TkpQ?=
 =?utf-8?B?VWdGdDV0ME50a0dCS01zUlhEWGM5T202aXlJUDFDRThDZG5tb2FMcEx4aURu?=
 =?utf-8?B?SWQzVXVSdjBzeHo3YUwwemtUYXZhYlJSS2pHamJoZlFZS0NReFVRUW5NNEM0?=
 =?utf-8?B?eDM0VmRvWkh6KzlxYlpjL29NSUw4dVhrL2NxNXVjUjhCTGZHTXlObEJ1SUxk?=
 =?utf-8?B?WkpaRDVDT2FjcGlVSUJRVzF4Z1pIcUxKcXJHc29nU09ja1RvQm0xZEFFTmdU?=
 =?utf-8?B?Y0ZHMzdiallKRVFxdGpiMmYreXdxWTBiSzh6VHZ6SGZUdVdqUnhlU1BYNS9i?=
 =?utf-8?B?UHlzK0UrS0lnT3lab01CYzJaYjNsVXM0ZnhoTldwdmtRb2RtN2FPb20wWXFG?=
 =?utf-8?B?djM1WisvMmVOVmROeVhFQ3RvSEFHZUpYaW5ZSDRSWVlhZjBoa2FVc0xUTzlq?=
 =?utf-8?Q?m0uozkomflXdkrmy4mN9sl68UB9/72YkxVtyg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjRqZ3hob2RCZnRoUzV3ZDZKcTdaa2xjUHdRLzBEVzJveWs4aDZpY0ptYmpN?=
 =?utf-8?B?b2tvd1ArMm40anRVZXVPQXFOMHcyVFlxaWJmbXpBMVp6RXBLZERqbHdZdkJO?=
 =?utf-8?B?RWVJUnc4bExvNkI5U0hZd3l4S01FYjdDREU5QjNCdFlBUUE3dHg0MUZ6aENq?=
 =?utf-8?B?bGZGRlpGVENpL29ZYTBPNkpKZHAzVXhYRHovNE1GaTFjUUNSNW9hU0pyQzkr?=
 =?utf-8?B?RW83QXRSbURKL2Q1SXN3QzNnU2N6N1JxZVdENDk4YmxFQjFBeERUZ2ZWODFy?=
 =?utf-8?B?SmRZQWRBUzNpV09tZFB3ZmVja0JoMTNGem51LzJXQ3ppMmZ6cFRaUDBLSmd6?=
 =?utf-8?B?eE4zTzd4clhhRzIzYzhqaDZUUEF6cmFWdVBvVzdEOXJSM0pmNHYzQXZzVlpt?=
 =?utf-8?B?TFNCQVJmZmQvTzRFNVVLRHJJUnRoSzFKUWltNWVhcUY0dnJBMncyODVBZ1JF?=
 =?utf-8?B?SmgwVTNOZFBRa2c3SkVwYXJjbHlJMDBTdnpwMXhPZ1hGNG1kMnBLNmZxUnFR?=
 =?utf-8?B?bXhJbEQ5UUwzTFVGSzZXcUhldGg1Q0JvbmtxQ0ZyeXJHRmZZNlNxMmc5Y3Zh?=
 =?utf-8?B?THJsYy9FV1lIVy9pVDFOeDRtSUZSWllzT0hiREtZK1RLWmU3VjYxS2ljVWxO?=
 =?utf-8?B?QytaM0oxOG5Uem1sbUI5eFBRWGs4N3dWUS9MZ2lORXNQQUJya0tZeUsrbGxH?=
 =?utf-8?B?azAyRnVla3BiazhRM0liYnBLTWU4MHFIbDN4NkFvQlFoMGpXbFNrZFNUZlc0?=
 =?utf-8?B?ZkpOVkZBMXlFcHc2UUQ5c3JFY3JocXhTUnRZMndIVkdsdDR4VjJNMDY5UlJD?=
 =?utf-8?B?UGdGNVJmRm4wWnFNZFZFbTRrdCtrZ29zVnErc0g1Vm0wSXdCb3JWMFYrbHEw?=
 =?utf-8?B?Tit6YWZ4aEdlMzBvUHV2VlVCQjBkeDBzQjl6TWZudk91cFJDMTVQMnR3UkQz?=
 =?utf-8?B?aFdkbWhnRjZONzFIcDVubUN2K25Va29PTDdvbVAvdk1NdHA2TUwzSmRIUDNs?=
 =?utf-8?B?QWs4eE9yckx2d2FhTlRFUDJDaU11NjZRbllQM0NZM0FMNjhiT2tER2Vqa3Bw?=
 =?utf-8?B?R1lwNlZYeG5sMTJxdSswU2RZYUNkQ3VOanRaRzY5NWhScTVpVVYrcEg5Wkdk?=
 =?utf-8?B?bTk2RlQyVkVXNDhTd3VIRXp0TGlQcko2M3RJYnUyeEtpbVBLamVYcVdudU9D?=
 =?utf-8?B?NlRxT3ppS0RpM0l2NWVJdUtGdzNmMmZ2Z2VZSENjZFg3MThJQkNDeUtuTUs4?=
 =?utf-8?B?ekoyd0NHR2w1S01qTDc1ZDhLRnR1MmhGTUxlUkRvQVAyZnpGOCtzZlNsVEE3?=
 =?utf-8?B?S0Q3TWxwcWRjTnZNam4waWFEdTFhZE9wUnVzKzNZemkvdElTVWpXWG5EaWVV?=
 =?utf-8?B?WWsweEZFL1pxMW9HUjVvNlUva3hPVmp4dUoxYXlTZTNFb2FhdzB4QjVORHpE?=
 =?utf-8?B?VVBBS0xESk5XWmNaVkl2QVBJSm9IaVVMaDBpNW94MlVyZzV6bDhCWDVKcnBp?=
 =?utf-8?B?aEkwWDlrOXg0amo1QmdUZHF2YlQ1WHR5cy9abjZoYTJ1NVRybDZBQzBkaU5a?=
 =?utf-8?B?S2pMSExnZHRMMzhNdElvUHRHK1U2WS9rQm9MQW1CNmNrc2Q3SVFDMnJ4c1dE?=
 =?utf-8?B?YXJCNVd1UXZ3QlZwSWpmNm1Gby9LUk5tUksvRjNFNHdpU0dURjZNa2NXM3Ev?=
 =?utf-8?B?VFB3K3RIcU1uTFJkSDNudG1BME9EMDJBQWg0ZHNjSDFTWis5dU4rdk5HSWJW?=
 =?utf-8?B?dHpXMWNMakRIZ3ZWekNvWGRScWc4NWVMTENNM09xZm83b1prNkNEdGIyRnp5?=
 =?utf-8?B?S0NLOHpMSE5ZQmQzNStoa0ZuTnNRd1VTcHZxRWhON2J0TlBqTUFZTVcwb0hB?=
 =?utf-8?B?WmllRXdZRWFQRlp3aGlEOEphYUN5ckxjZ1JKRmxYMllVem4vdUVualdzUW10?=
 =?utf-8?B?VUZLZEhzdnVqRU1JdzJ6aThtTUZrcU43OVJWREQ3SXJZNktmOHBCZmRGVmFJ?=
 =?utf-8?B?dVBmR0lHNTBxQm9CNHBzVDFuQm1mSVZBUWZCa3hTc2Fxeno5VWZvMTRXNHZs?=
 =?utf-8?B?MEp0bWJKaFFNUjdzcUsrTHNpYUNMOUU0UVVORFZBb1BNbWp3QkFXRDBOc3Zj?=
 =?utf-8?B?TVFCRzVKVzN1R0RvenE5ZEtZbjRESTZpeHYvR0FtNml6RFJmUjFRejVwY1px?=
 =?utf-8?Q?MVyOY9gCHU8wHgQhaOH9Cb8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b2d805-e111-42e7-1cef-08dde3ee1891
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:43:11.2396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eMcL/k2n8LySGVH7tm4+axk5adWGUgXhe4wZAveFQMACLcpBWHUGAaVj9Cwh8qANuERLcWYvGFsfqTFfj7sd/nQngd64A+Xx7VsCqKTIMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPFB0A9C7B87

On 2025-08-23 12:39, Thomas Gleixner wrote:
> There is no point for this being visible in the resume_to_user_mode()
> handling.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   include/linux/resume_user_mode.h |    2 +-
>   include/linux/rseq.h             |   13 +++++++------
>   2 files changed, 8 insertions(+), 7 deletions(-)
> 
> --- a/include/linux/resume_user_mode.h
> +++ b/include/linux/resume_user_mode.h
> @@ -59,7 +59,7 @@ static inline void resume_user_mode_work
>   	mem_cgroup_handle_over_high(GFP_KERNEL);
>   	blkcg_maybe_throttle_current();
>   
> -	rseq_handle_notify_resume(NULL, regs);
> +	rseq_handle_notify_resume(regs);
>   }
>   
>   #endif /* LINUX_RESUME_USER_MODE_H */
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -37,19 +37,20 @@ static inline void rseq_set_notify_resum
>   
>   void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
>   
> -static inline void rseq_handle_notify_resume(struct ksignal *ksig,
> -					     struct pt_regs *regs)
> +static inline void rseq_handle_notify_resume(struct pt_regs *regs)
>   {
>   	if (current->rseq)
> -		__rseq_handle_notify_resume(ksig, regs);
> +		__rseq_handle_notify_resume(NULL, regs);
>   }
>   
>   static inline void rseq_signal_deliver(struct ksignal *ksig,
>   				       struct pt_regs *regs)
>   {
> -	scoped_guard(RSEQ_EVENT_GUARD)
> -		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
> -	rseq_handle_notify_resume(ksig, regs);
> +	if (current->rseq) {
> +		scoped_guard(RSEQ_EVENT_GUARD)
> +			__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
> +		__rseq_handle_notify_resume(ksig, regs);
> +	}
>   }
>   
>   /* rseq_preempt() requires preemption to be disabled. */
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

