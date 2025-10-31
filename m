Return-Path: <linux-kernel+bounces-880455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6990C25CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F6F188C42E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990BA257431;
	Fri, 31 Oct 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="xvUwvMY4"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022110.outbound.protection.outlook.com [52.101.126.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A865229B2A;
	Fri, 31 Oct 2025 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923397; cv=fail; b=pmSLSV7z4Y0nFwBhFI2ovBRWmakRn/+3q/lTD9TCUcHinChonHcg/49SHawzjR8lpxg567Bq8rweOhZklfJS86unPEBfsS8QlNrWEn/ojdisYJxfzn8spK+eiIJb1qDPHtuOB3m5Qjwv3P1OwViMMRVsTdUXgZWnWUEBz6741y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923397; c=relaxed/simple;
	bh=N1VyoMVnlLiO+ZGSJINZv0dYAFJnhMObIdgQSy8FkOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f+rjJyk1CypD5Tm2K4t1d14/ta7Jq0cUZzSYnhtcJvaC6bzavn/sT63dMFX/tyMvVXFq47Lw2FR9bqLF4SeM1xLiShc3Y4juWKFXyXqAKXoqvi9RinyZ3OnyriTetTcHSkUhKwAxyITvMX7r37veLbgku7JjINoZJezoRNFVYHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=xvUwvMY4; arc=fail smtp.client-ip=52.101.126.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXlhQQcmgMN5q8JhHrqc7xGCXi8FIO0SwyH/DxxM36Ggmg0C+ii3m+iZD3Si+i/8Eg9yXvIApLyvxw5YqGbtpL/imCqZnwtlxymYQhOMwWkYIMePL3SgKB5RfiqOrbhqsxIQl/zMdEfyBvufCUMhYTBNUSWx1rxJWsoSVaqGDCaLy5WUgiytCYCLPLwTOGIQTx1k39+BL4I5Lfgyn/M/Ipojjn6vMfB6hmgHiilw8CNnQde71FUwLTSHEmid2sTowAVJHdXXZCEJJegGDeV/BpmgFVh+3Zj82m7nGTOdgJW1J49q7oiN+xPzng3uCCM6L9N8Rv/Yjrh8eSFn4TUTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W06SwcKg6XitF9J9EFGEtaEtrLCBZ8wqGT9G+1+hPVk=;
 b=THHnV+fC8t7XrjT7rFaeb7p0LmY5T6IhKKR3o5r9b5D94b9+dwwePNeB3ICpUb+A7VyqICCwlkNUbN8awZy/OAHgLl8wJsYstOO1ID3R2WsPTqTsDbAF4caNkyHN2La/OlMgWYs5iOK3/JJPKbInbydqtUigytvGIjETE5KtyMY989euuGjuwXBoa66FHTqiRoqe2fHR9XE6v7MHt+uSYz5DGxuLdO/APFvU0AwRPHFgES5d1l77DwNhEu6WbMnDw7UNHAiZYtOIfcYoddg0uP1ENc4Q+XHvz2il2X8fTOVSbacjW6Ilz7RjAeUwcAKPFQ/QzAyzZodF7wpJjciWjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W06SwcKg6XitF9J9EFGEtaEtrLCBZ8wqGT9G+1+hPVk=;
 b=xvUwvMY4yZx5YWJcPfl56QMap9eABwiLypI3XNP39UHhcfro4VKnm4ZndZxlWtpYlxj3pxMsCcnquVQeniI49Q9nB91FC4APtlS2r8gGOLMxMXx8wywv4cBimtSrAPNxwVxcu4V+IO1ZhXCpBulMmu4D2zWSk2ZMQyXsXrVNdsa3T2jkrRc67CkedhQVYeQ62cscENZ9NnHooaggIEzNLj6uh+sbFVIWzPmNmZjTqWOWqvcEJmpg2oxNEyRq42cy224Jv6//PtHeyLym9pfN5/z0XBh0EkkYAYTIhciSda9rSn8dmr1MBawEYCNPbDGa2jWVXqmimL0juqWPR2TMqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEYPR03MB7119.apcprd03.prod.outlook.com (2603:1096:101:d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 15:09:47 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 15:09:46 +0000
Message-ID: <9751014d-926e-4d42-b8e1-5a4d3e734457@amlogic.com>
Date: Fri, 31 Oct 2025 23:09:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] clk: amlogic: optimize the PLL driver
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251031-optimize_pll_driver-v3-0-92f3b2f36a83@amlogic.com>
 <1jms57xx05.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jms57xx05.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0187.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::11) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEYPR03MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd6f002-594e-4ec9-ec84-08de188f8781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVUwT1JpRXY5ZjNMR2NBbGZ0cU81bzBFTlpDV1JMVy84eWhFTjBrN2RGb2pz?=
 =?utf-8?B?Z3hGcDUwdk1TdytTeGJsb2pmN1BHM3RySC8weC9ydWlaQzROMmJoN1ovZVB0?=
 =?utf-8?B?U1JGLzQ4MVJPRnhPWDFGV2FLWGMvZi8zbGdtQmt0dkFVcTJraERJRzQyWUNh?=
 =?utf-8?B?bVFGMnJEUnRZdS9wWDVlMHk5d2ZHeDNId013SnRPN3RUalVTeGN3QkdWZDM0?=
 =?utf-8?B?SXN4NlUyZER1ei8yR05qMHk2aXpJWk93a01KSzcyYkVPN0FrQmRDZmJrQzcy?=
 =?utf-8?B?dXc5N0xubXRneEFJSFcvWlRpM1JacGlNVWhOZDZraWk2SnhsTkdDUEFkaG1x?=
 =?utf-8?B?MzV4cVQ3Y1VUVVdSMm9xSVRwTDZpSkhOd0R6ZWllWStQb3BHd0hnditxVk9x?=
 =?utf-8?B?M1RUMVR6MDAxSlVQZDNSMTc1bkIzWHFPZjhZOUJYVHNDaXdRZWdYdnJMM3hl?=
 =?utf-8?B?OWhOWXkxd0ZjODVmLzlPMHpXTHhPbktNdkxyMWRTejROSk5rY3ZHOXIxeTNI?=
 =?utf-8?B?VDVpcDVXcVczNVJVZjQydHFraUJybWNmdFEyVERrMzllSHp1cmNQTjFMcUpz?=
 =?utf-8?B?SWxqVm1vSmFnaHRsNGxqWE43cWhxKzJ5VWRXS21IWDhzNTlnOFpZNi9CSmxu?=
 =?utf-8?B?d0UwL3JhQ29uWVpmdFNKd2FrS3EvaHJXVkZ1b29xa3ZtM2dIRUxLSmN3aXJQ?=
 =?utf-8?B?S0VtWTFJaUtmNWtoYnBEdGlBNDR6bzJ2TU8vNVh4U2w3MTA5Z2I5L0ZTdWpS?=
 =?utf-8?B?b05TZnNWQm1SL0VONzUvcEZiS2oxWnUrbzNEekRxRzBBL0dJeGpwVC9KMnFF?=
 =?utf-8?B?ZzhhNGdTKzRvRlBPamY4aExXTi8wVC9nMWRFSUprMkJPTnRHaXFzZWJQMDlQ?=
 =?utf-8?B?R3lJblYwcWNUZFo2SnJ0NW5IY1kxRWpmN0RtYmFWMWs1VFVReUVwV29vaGp3?=
 =?utf-8?B?RThJVFBzcjM1Uy9lQjlGajJBUllscVcvTGEvMmpHUTd1UmUrek13STdOUWht?=
 =?utf-8?B?TUZvSVFOSDNZVndOTzkvMXFmWFBMR2FlTmNQc0tkMVZ5ZHV4Vm94UTQrVUdW?=
 =?utf-8?B?cTAyUlc2cXh1SGEwSlR6VXUrb3p6MC9QVzFmcldUUkczMStDTnJoSmZ6OXRN?=
 =?utf-8?B?MDBTSHBUSU9hZjdkMTNnRm4vMDh6YStLdTQ2QUhSTGVvTDA3S1dScXhHYjBp?=
 =?utf-8?B?UFlvMHVsT2w4VHRIZnFDSG5lV3EwWlZoVXhxSkxZbzBWZDlzaEdqMGppWDVI?=
 =?utf-8?B?elVFNzkzdVhoWGJYUlRuV2p3QnpqN1BrNkk3R3ZsakdmdXhUakMybEFRM0JK?=
 =?utf-8?B?aHUweGhqZGxNeWxUbk04czRoUm5Yb3JPRzcva1M5NTdyN2I5WUxoMlppVnMr?=
 =?utf-8?B?WmNxSG96cjYxTXEwbjllMUc3UFRGTjdVdTV0bFFIbmxidTUrSVBWS3MwQ3FN?=
 =?utf-8?B?QlhwbW0raC9HaHpLRFlOcWRkSFk2aFgwV0VJMHc4NEdzZGZiL1ZneVM3QlRH?=
 =?utf-8?B?cVNmNlFVcUZjUmZSMHBDME5qR21oYmgrU2xHWFE0R0xBUWRBbFgyM1NRN2ky?=
 =?utf-8?B?Z0gxZUlTRzVlK0ZRVlhwMXg3YjBocE82ZDNKVDdnYjdDa0tRT2QxSXpldlpR?=
 =?utf-8?B?MGJXUGdJWFo5aExuSmxYL0VtSkl4aTNxblJVRVRDMHZPeXdvQndtWVdIWWw3?=
 =?utf-8?B?eTNTR3Q2QkRTakdaWDlTOGJqc0RaMHM0WFdsazQ0dUVkcWVvWlZVSGVmTlU2?=
 =?utf-8?B?eHd3a2RCUDAvaFhrYWdrNSs1QWovN25KcVEvbEY4OFlmOE92TFlCRVJ5STdZ?=
 =?utf-8?B?ZVhwVjI1VEFqV0JUSzhES2hoV0FvYmlZWkg0cFoweCtZQ0xVUzVTczV1ZEYv?=
 =?utf-8?B?VFFWV3lSYUgzRUwvaGRyaXF3cDl4MXpvOXoxZytaNTJLOW04VkEwcmZRRnoy?=
 =?utf-8?B?Tmg5NkY3TkVDemVtekdkNVp6Y2dEcmc5aVVhVzljazJxb3BqVUlGQXVhVEdx?=
 =?utf-8?B?bEt5bjlxSCt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3FGZlJ4Vkwrb0c5Zm5VTXpNdGdWeWN2dGJnMVkvSGNMTmlra3NLclhWazg5?=
 =?utf-8?B?ZHBjT0UwRHBOaU5aSjd1bHM0bzhiTU1oQTVuWld0QkphYmxSSFNUNG5Lcm92?=
 =?utf-8?B?ZkZLNTdzMVpyY2xWak1zQUpBTEN1ejRONlE4N250UHhKNTZqOWNrK1l4NDlO?=
 =?utf-8?B?aU0vQVdrelRlVGpEQ2luWkFmcHNFU1NIcTVpNVVqMUpxNXRYZzh3c0lJTzdr?=
 =?utf-8?B?YlljK3h0cktmZDlGNzU2azVoT0FaQXN1ZG55MWdqNmYvV2hOK1dUSHVuQ2FQ?=
 =?utf-8?B?dlNJdExZVnp3V0lFMDVaTytZb1VLOElUMkR3eVJaRHpPcVROTGFtQmxLcUdF?=
 =?utf-8?B?b2VMTERRZkU1ajY0ZkhHRkl3MnVDV2p6aTNBNWRFSkFXb2RqRU15YUx6L2pj?=
 =?utf-8?B?L1dqd3hJVkkydlBDYnltMDJuN1MvbEtyWXVWQStUZExaUDJyVGtSM3dZOTd5?=
 =?utf-8?B?S09BeWM2UmdFdnRQVmdyQzA3bnpyajNlR3lqWjVFeC8va3dHSnFSYzE3ak5K?=
 =?utf-8?B?NGROclVjWjJ1U05ZbFM3NHFTRVpjVzZTWk81TFpqeXRHR1dpR2ZtL1ZlZmhX?=
 =?utf-8?B?VWxoaURLTEFsQkFEbFNOZ3VONWNmRFdZc1JSem5TRHI3cGoyYk1JYnNadzlK?=
 =?utf-8?B?Yk81OXV0a2ZLNzcvKzNHb2ErbENiTytSdzRHbkRnZTk1K1FyMHdkcGRhdzdN?=
 =?utf-8?B?YjVKcnNmRWZSYWJ1ZkVOOGUyM2RydmNrQnhwZU44bGpKSUh6bm1yOFY0bHVi?=
 =?utf-8?B?M3ZPWDZSaEpzcjd2UzFPZ2llTTNyTGNNSDV5UUx6MHdoR2J6UEJoTHlpYUFv?=
 =?utf-8?B?OU9CZnhjUDk4NnY0K2IwdHladlJhWVlKdjNWTWdzU0FxWm5MQW14VmNEMDVI?=
 =?utf-8?B?dm5Lc2RiM3JRNTRCZzViSXp5M2ZwTURRMHM5TklueVRTUktjcnZlY1psK0tt?=
 =?utf-8?B?d2FGQnhXZFVPc0NueEs2UC9lSFY1eFI0M3l0b3BDTVNIWk0vY1dyYVA5U0hK?=
 =?utf-8?B?M3dxaTR3ckNrUDRLM0h1QkFEY0NkUXFMUWxhalh1V0FBcCtWOVc0L1NsUHlN?=
 =?utf-8?B?SFpCTis5dS9OZnIxQ054bGVROHczWnNCZGJ0YngrejY2MXZvd2hwZmhlL283?=
 =?utf-8?B?c01FaEV5YjhnZDlPSk1XaG4zdC9oczZxMjg1MDVxTEVlQkRybFYvZzhqY0Rh?=
 =?utf-8?B?dGVZSjczbXNnbldvdjVXYUtsZ21hV01oM2Zxcy8xUEF4YVg1Tmg2MzV2eU14?=
 =?utf-8?B?dFpVWnp0UXJta0JadHdxakVYa1hieVNSSG5XNnJoczlrbkJoVVcwV1pvRVlM?=
 =?utf-8?B?U1dFdlpjaGV4RVJURWdxbkpZVDdDUFRMQUVYRVV1ZEN6VWNVMXR0cFVlclFt?=
 =?utf-8?B?OHJXOXRxQ1NLblJubHNEWjVONHBOaVFzWHBNbUNsKzd3NWdLc05oc3RqRVJm?=
 =?utf-8?B?ekxwYjdnUnJPNTJyYjg0UzlGdml1RmxaSklWSzNNVjhGQmluZTJXN3FpV0Yx?=
 =?utf-8?B?clpSeW56dWhTd2ZXempuR2FrL1dJRFFXRGE4U3BoNDRORElBK216Tk1TempT?=
 =?utf-8?B?U2RsK3pWV084TEkwUVFYMjZBd0xhSk9KM3VldG5IU2lGWXJYS0ZGdjFqdXNq?=
 =?utf-8?B?TjZlUHhiZzhNanpNUk1LZC9kVDB0bmtMYjlrVUppWHg3VHZmMU1raWRvZnZx?=
 =?utf-8?B?MmNQdXN4Z3J0YThRc3FzVjhKWjVnNzhFblpRanp4NCtacGEyZGZlSTMwem9X?=
 =?utf-8?B?eVhvbXlRMFdWY1ZrZENHa2tLNkRBTks2M3JNV1VSYkovdSt5OTNzOUtMNHBG?=
 =?utf-8?B?MjU3TnZPUmV1UW80em9pUHZUNFBQY3BIUmRqaXdZWXBRRmZDL2JOZ2tDckxB?=
 =?utf-8?B?WnQrZFRrTHZPMEh3bGovRmZXMUplVmZMcVhFWUhva0szejZ1RjJlN2h5UnRP?=
 =?utf-8?B?TVMzQzN2ZXY2UmphcWQ1NE9QSjkzd2dJdHhwdUZoaU8rYm4vNzhRT0pwbzBp?=
 =?utf-8?B?em9PN21BaUh2UnVCR1BlOXFmL1lObXNwKy9iUUkrdzFpNzhObkVTOU9jWlpz?=
 =?utf-8?B?cFVmK2M2QzhvR2V4c0pyQndJT1FjSVhKNDZPMFZHYWs1UWh5RmVtY3NuUUZM?=
 =?utf-8?Q?8iKi9tVDmrPAgtzbnqqSXjuKz?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd6f002-594e-4ec9-ec84-08de188f8781
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 15:09:46.8245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIcI0uuUi9hHIfriA+zXzu1792/2WzuGCKp+rRgX8OaPtbcTSbuxe0+LhgfAZyF7lairxirGZklbes5mrBIxYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7119

Hi Jerome,

On 10/31/2025 5:04 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Fri 31 Oct 2025 at 16:10, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
> 
>> This patch series consists of four topics involving the amlogic PLL
>> driver:
>> - Fix out-of-range PLL frequency setting.
>> - Improve the issue of PLL lock failures.
>> - Add handling for PLL lock failure.
>> - Optimize PLL enable timing.
>>
>> For easier review and management, these are submitted as a single
>> patch series.
>>
>> The PLL timing optimization changes were merged into our internal
>> repository quite some time ago and have been verified on a large
>> number of SoCs:
>> - Already supported upstream: G12A, G12B, SM1, S4, A1, C3.
>> - Planned for upstream support: T7, A5, A4, S7, S7D, S6, etc.
>>
>> Based on the upstream code base, I have performed functional testing
>> on G12A, A1, A5, A4, T7, S7, S7D, and S6, all of which passed.
>>
>> Additionally, stress testing using scripts was conducted on A5 and
>> A1, with over 40,000 and 50,000 iterations respectively, and no
>> abnormalities were observed. Below is a portion of the stress test
>> log (CLOCK_ALLOW_WRITE_DEBUGFS has been manually enabled):
> 
> Okay, this little game has been going on long enough.
> 
> You've posted v2 24h hours ago
> You've got feedback within hours
> There was still a 1 question pending
> The rest of community had no chance to review.
> 

There might be a serious misunderstanding here.

In recent years, we've mainly been maintaining our code in our
internal repository, which has led to some differences between our
internal codebase and the upstream version. The patches that account
for these differences are already queued for submission, and several
SoCs are also waiting in line to be submitted. As a result, quite a
few patches have piled up, waiting to go upstream.

Previously, I had been waiting for your clock driver restructuring
patches to be ready (which have recently been merged), so for almost
a year, we haven't made much progress on clock driver–related
upstreaming.

Other drivers that depend on the clock driver have also been blocked.
This situation has been very stressful for me. I've been doing my
best to update versions as soon as possible in response to review
feedback.

> and yet, here the v3 already ! still with bearing pr_warn().
> 

Regarding pr_warn(), I explained in a previous email why I didn't
choose to use pr_warn_once(). The quick iteration of versions wasn't
an intentional disregard of your suggestions.

It's just that the upstream submission process has been severely
jammed. I admit I've been anxious, because at the previous pace, our
chips have already been in mass production for quite some time while
our clock driver still hasn't been submitted upstream, which puts us
in a difficult position, so please understand.

> Chuan, the community is not dedicated to reviewing your submission.
> Time and time again you ignore the feedback provided in reviews and the
> documentation. I've had enough of your sloppy submission.
> 
> I will not review or apply anything from you in this cycle.
> 
> You have been warned multiple times. Every time you ignore a review,
> you'll get ignored in return. This is how it will be from now on.
> 

Seeing your message was really disheartening. I want to clarify that
I've always been very grateful to and respectful of you, as well as
Neil, Martin, and others. Throughout the upstreaming process, your
feedback has been extremely helpful.

I've always taken your reviews seriously and communicate frendly. I
truly never meant to ignore your comments, please don't misunderstand.

>>
>> - For A5:
>>    # echo 491520000 > /sys/kernel/debug/clk/hifi_pll/clk_rate
>>    # cnt=0
>>    # while true; do
>>    >     echo "------------ cnt=$cnt -----------"
>>    >     echo 1 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
>>    >     en=$(cat /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable 2>/dev/null)
>>    >     if [ "$en" != "1" ]; then
>>    >         echo "[ERROR] PLL enable test failed! (clk_prepare_enable=$en)"
>>    >         break
>>    >     fi
>>    >
>>    >     echo 0 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
>>    >     cnt=$((cnt + 1))
>>    >     echo -e "sleep time: 1 s."
>>    >     sleep 1
>>    > done &
>>    # ------------ cnt=0 -----------
>>    sleep time: 1 s.
>>    ------------ cnt=1 -----------
>>    sleep time: 1 s.
>>    ------------ cnt=2 -----------
>>    sleep time: 1 s.
>>    ...
>>    ------------ cnt=42076 -----------
>>    sleep time: 1 s.
>>
>> - For A1:
>>    # echo 983040000 > /sys/kernel/debug/clk/hifi_pll/clk_rate
>>    # cnt=0
>>    # while true; do
>>    >     echo "------------ cnt=$cnt -----------"
>>    >     echo 1 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
>>    >     en=$(cat /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable 2>/dev/null)
>>    >     if [ "$en" != "1" ]; then
>>    >         echo "[ERROR] PLL enable test failed! (clk_prepare_enable=$en)"
>>    >         break
>>    >     fi
>>    >
>>    >     echo 0 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
>>    >     cnt=$((cnt + 1))
>>    >     echo -e "sleep time: 1 s."
>>    >     sleep 1
>>    > done &
>>    # ------------ cnt=0 -----------
>>    sleep time: 1 s.
>>    ------------ cnt=1 -----------
>>    sleep time: 1 s.
>>    ------------ cnt=2 -----------
>>    sleep time: 1 s.
>>    ...
>>    ------------ cnt=55051 -----------
>>    sleep time: 1 s.
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>> Changes in v3:
>> - Fix some formatting issues.
>> - Move the 20 us delay after reset into the corresponding if
>> condition (no delay is needed if there is no reset).
>> - Move the code that releases rst back to execute before current_en.
>> - Remove the patch that changes the active level of l_detect.
>> - Link to v2: https://lore.kernel.org/r/20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com
>>
>> Changes in v2:
>> - Modify the judgment condition of 'm' out of range.
>> - Split the PLL timing optimization patch to make it easier to review.
>> - Link to v1: https://lore.kernel.org/r/20251022-optimize_pll_driver-v1-0-a275722fb6f4@amlogic.com
>>
>> ---
>> Chuan Liu (4):
>>        clk: amlogic: Fix out-of-range PLL frequency setting
>>        clk: amlogic: Improve the issue of PLL lock failures
>>        clk: amlogic: Add handling for PLL lock failure
>>        clk: amlogic: Optimize PLL enable timing
>>
>>   drivers/clk/meson/clk-pll.c | 64 +++++++++++++++++++++++++++------------------
>>   1 file changed, 39 insertions(+), 25 deletions(-)
>> ---
>> base-commit: 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
>> change-id: 20251020-optimize_pll_driver-7bef91876c41
>>
>> Best regards,
> 
> --
> Jerome


