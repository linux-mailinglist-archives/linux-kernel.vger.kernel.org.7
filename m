Return-Path: <linux-kernel+bounces-762294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 435BDB20483
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C84418A09DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B992222BB;
	Mon, 11 Aug 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IWaaQUNY"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012011.outbound.protection.outlook.com [52.101.126.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60FC22688C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905949; cv=fail; b=cEbZzEOUAfjTBFJ1kGvOCQ/ohx3HBfFOHFF6ACudPESX+vGoJPKQB6md1OQOZSTo+bA2rTn1q50OQfKY4d3aHKXlFWionw5gH0nthD7t33uwuCWSDSJpVFHdqlnStL8D3TcjMhuG2PXr0CBX5IPrUbjYawTS57+35tUPbGM1O2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905949; c=relaxed/simple;
	bh=pFEJEe2LfclnUcU8cQeL8wA1KNvR4bYIxFIyavE2XVI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OKNlJqWPyN4KzRGN7Zb0CavZxrAFbc4MvW4w0p2xX9JxEhyGcRGTEeSfJlvBAZFtVPjZc4E5zwBNQOVHMCnWcEnLbY+ygpIOR7Mwq/oQRuGKyVC2gq8efNQ9NK95/fG6y4sqfKGwc8tpP8+BwVMy7T4kOo54DKddk/8GdRraWkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IWaaQUNY; arc=fail smtp.client-ip=52.101.126.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzBaM7e6cs4lNmKQwCKNZc9Aiysy82/jq+JQmyIzuPpQ+zvt/twTNDNxu3qODF1Xxizz+bAwxbEwHghYQDs4/mLOheU7VRPr51dg1D0n27HFic/Rd4CZ64usCIOHNt79xP3wrNTYFiuJGdaJBi3Xd8e2wvIQAXQxPdVzkOOZqUwWX8T7fvH/XnJRZx/2uZb5tfEZmmcbfUnSUbjQ85pjoF8KLN0BMmm/tB2jUOwhf6wh2Wxn9VUqlGifAQ95W4I3m9rkxQT3G3KzT2lE7Ajvi80mhYNAHMqq8SnoK7uDMXtRHVRT97Ugdsa4L6I4elYJAP86qk12h+1EOL6MfnlIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFEJEe2LfclnUcU8cQeL8wA1KNvR4bYIxFIyavE2XVI=;
 b=BsAVVJdHUlQu0FtUFAhXi89QDkOJprq9erUj3y0vj1UeM7NTa1PjXfngK+5ioo0iYWNdFVXycZ3fsPlLZVuOmGBrxizGjlVxs5GtUDeS+hqqiaefkQruAg5YMpVmxu/KnJYHtzX5MgI5MNOZRBgB9vaIJAeq3s+2Ga/HgAt13/sNanS8r/0DotzPl80p3CrSzza+QxeqUfBLlpEgi4hbVwrn5BiR0tHV8GmpI7P0RpUFMpJ4DtO0iMbbrVLT0h2LWyIby9ETDh4nAQzUv8CsyirZzNSdZoEIMMkrx5JHRyt+6/lBNZL/lkBjJk+fO18uef8EY9S9lygK9uNugE6whg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFEJEe2LfclnUcU8cQeL8wA1KNvR4bYIxFIyavE2XVI=;
 b=IWaaQUNYTPVzsweOsw7boTWOEYft10Wdw8RMdy0FkItZiBuj4tAt1a5WgHy7N/cwIVwpokppHoyRAmyRSwdNAp7fVd9LvQtZbgtQL2mT7JATaUDujQLfGjrLCGRkCetHbXtsA6FH+Z7dpevR+yn1igW/eAJdkFDmPV3zlXnHZ+vPDZDJEXUQsjDHmWOlBEAPYquw1tQEC6ugys7bFBFknyHkc0uUjx0SE834DOqxREcwHZ9Op5qw0DIbDwwkrCD6JaZTb6l2HBTMh28zHiYaS9BYZCkF9p2NrpoCivZxQV+gpdHQ4nZLsyM8xKP6cfmYTYzecGRwG3tcsF/HtdYEAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com (2603:1096:101:2d4::11)
 by JH0PR06MB6776.apcprd06.prod.outlook.com (2603:1096:990:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 09:52:23 +0000
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b]) by SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 09:52:22 +0000
Message-ID: <84254646-134e-45f3-8031-3062221205cd@vivo.com>
Date: Mon, 11 Aug 2025 17:52:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/1] genirq/devres: Add err handling in
 devm_request_threaded_irq() and devm_request_any_context_irq()
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
 Jonathan.Cameron@Huawei.com, u.kleine-koenig@pengutronix.de,
 angeg.delregno@collabora.com, krzk@kernel.org, a.fatoum@pengutronix.de,
 frank.li@vivo.com, christophe.jaillet@wanadoo.fr
References: <20250805092922.135500-1-panchuang@vivo.com>
 <20250805092922.135500-2-panchuang@vivo.com>
From: PanChuang <panchuang@vivo.com>
In-Reply-To: <20250805092922.135500-2-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To SEYPR06MB8068.apcprd06.prod.outlook.com
 (2603:1096:101:2d4::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB8068:EE_|JH0PR06MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 405620ab-8ab0-467e-8cbd-08ddd8bcc4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWpHL2xwRUVQaXg4WFBQMUpZdzdIaUlxbm1EenN5Ny9qQlhveitveTFqU0wz?=
 =?utf-8?B?NmxwaDh2U0tJQVhpWmxZaXpBTHZjVnZhQ3E1RTA0SnF6QXhMRVpiYm05M0Z6?=
 =?utf-8?B?YkNWY0N4RGlOU1dkVXpCWWZjMGgyV2dCUzErSEs0eURQM0h1amhzaUNwYXh0?=
 =?utf-8?B?Y2tqYnlSRDdONlZ1RmV6eWlLVWxVVWlwYW8zRThvYUcvKzBiaXFIdVN3dk13?=
 =?utf-8?B?V3pxK1p6RE05YnB1Ky9MUUI0K0JxUnhlM2MyYjk3MkZOTjFsZGNmTEdPdDVy?=
 =?utf-8?B?M0pGTkZtdzZVMVZuRFFtblI5Njhxa2RQZjJCSkxtZCtjamFHZkpkcGFYWHFk?=
 =?utf-8?B?Q0JUdXN0SWhWaGhYbHBxYi81WUJvazZGWjg4cmhLYUZCL0N1Z3hLREJwMk9U?=
 =?utf-8?B?SjgwODBCQTR0aVJMbWg2V2IwRk5DVm9vdXZKLzQ2NE1sVytTcDEyaWRUQUlH?=
 =?utf-8?B?NzB2OVJNMjhrSm5QR3U5UjEyNDFaWmRwbTdSWm9FM2d2WXp2SG9DUzI2MnpL?=
 =?utf-8?B?VDZ5WWlwYTdUeWQ3NllSK0YzRVd3WTVxMFZWTmZ6R2Z1NUJJNGlIQzEydnUr?=
 =?utf-8?B?OGhiQkw4RGFMZzQvc3lRalE0cGVPcmcxWDVtZFNrZm5LRVFMREh1MitJQnNs?=
 =?utf-8?B?VExtVjNnczNzM3lxZ3BHeVVuUkRWTUdlWC8venpOTmc1NmgvT0Z1cmlEUjhh?=
 =?utf-8?B?RXdwaTc3WGZWTWVpWkVMenZzOFMrLy9DS3JodDR4aGdRZVNMSVduZE44V0xV?=
 =?utf-8?B?QlVDWXlUNjN5YVhrc2JTcWxuWHJnVWFkMkdrNTRlY1o5SCsrZnJzaXVMcVVY?=
 =?utf-8?B?OGxZM01hSURFYUh1V2d0QzM1OEhmNTNXdDgxdHFhOWU3OU04Mm9aMi9semhB?=
 =?utf-8?B?QnpWb0V4Qityd3V5eWNFd0diVzBSY0RuMzl5emxWRHJlUXN0TTh1UkVhelpu?=
 =?utf-8?B?bThRMkptQUhBYkR2TFVoZkcvcGp3c2UrZmR6SUhVSlJYUzRTNnZkRmF3SHJS?=
 =?utf-8?B?YnAvanZXTTVCOWpEMVZLdDNPMmhwTVFPWFB5WjBqbWRvOHh6Y1dBWVpnZWtq?=
 =?utf-8?B?N2MvMFBVRnBDenVRLzcyN3czUzBXZlpLL1lIYnlEM0RCNmRWZkNQaWFZdHla?=
 =?utf-8?B?eDlkSWRhUHlUcFlkUCtrdDBsSTZGd3hZRnJZcDlsdUtPWVc1U2dGakhPdTgv?=
 =?utf-8?B?cTVXcENyeU8yeWV1cGRSUWZVeHZ0dEcvWUYrVFc3SUlacmt6ejZ1cnRmTENi?=
 =?utf-8?B?RHNjaXFFcVlUQWlsUTh3cjRaWFlWci90Tk0rSzRLdzZCNG9UWHcwODZYZ3ZK?=
 =?utf-8?B?cGhJQ1ErdmQxeG5mYVMyVVlOVHlKVWMwcWJLTmpLaVpheDBCWUsvbCtVME5U?=
 =?utf-8?B?alJ1VkRoRTU4NFdjS0EvL0V1Y0NQMWM4WklnOVRqUm9uaFdGbUl6Tk9lWGRv?=
 =?utf-8?B?RTlrdXB1RkdJZjhCWUVuTWY4UHRzSFpzVm9RWWhMTTBDa2h2T2JBR2Y3aVRh?=
 =?utf-8?B?TDlJaUV3Zjc2aytHZXIzUzIxVTczWlNFQ0JnbWxOcDIxTDBzc0FFWlhqRW1z?=
 =?utf-8?B?RjdzaXkzWFlFQUw0bjFaem1MS0pEQXJUN0U1eXowQUZHY0tsQVY4QmM1bW9t?=
 =?utf-8?B?YkFDamdZZjNJdFl6NGZ0SyttdmQ4L1hEV2dFN0hOai81d3RybTVWK3ZST2hq?=
 =?utf-8?B?MGMyRkJVMUt6UnROcG5QQmZzK2JObHpPSExaenRvWFBMWXFqVG1ZakRsYnRk?=
 =?utf-8?B?YmtHSzUwcUw0L1hZRTd1UmkremdGQ0lPejl4VGJkMUVWZGpsZ2lBdUNGclY3?=
 =?utf-8?B?YXZPWUNiL0FUbDR4ZkZMUFpOYmYyRE1HTlp1YmhHb2M0TG1ESVJzMVV1dnhM?=
 =?utf-8?B?UUhnVmkra045TjNzU1EybnB4NG1obTZ4QW9VcUxWVjE3K3N3ejdBVXVaRFlO?=
 =?utf-8?Q?fgDxrqaDN0c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB8068.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aldORmN4OGNuTHZ2VkNzYytJMkhBcFpqS2xtZ2trYnJvaytRZ3BvQXFROHox?=
 =?utf-8?B?eGoxa1ZJZzhZdlVHNVdQYjV2SzBuZXdvWnppVHlMSllkc2dTZi9kbHl2VnN3?=
 =?utf-8?B?M3N1dnVYTEtaNUpONFg3MFhUM2NpZ3pzUk16ZTlJQ1B6cFFBRjRBcHhZejM1?=
 =?utf-8?B?YWQwTG5xT0VjdEVrdk1LYnQzdUc5YkJBVW5ieC9iZE9Ic0VEdVUwbC9TS2Q0?=
 =?utf-8?B?dWx1YUVUdWE5M3RONW9RbGVrWFFNbGpQYmZZOUNTNjBVQTBqNzdZSFZrWFFO?=
 =?utf-8?B?Tzd5dStJYXNBSGhveG9lMDBCQUJxOXVDb3dXQldMeWdvRjZscVBBUHNPWkli?=
 =?utf-8?B?TkZYVlV4bHRXaHF4UHlaZmg3TGw0VHpDZG1HNTlKZ2IzeG9xOE1hNjd5YmNY?=
 =?utf-8?B?dXF5QTdrbDd0ZzMyUnBiOTNBUExlbUVpaStQc0xYWXlwenFDbnZkSTMwS09q?=
 =?utf-8?B?akFGSXNnME16ajEwS0gvcTkwbUhMeWp3VEJnUTE0M3NmQ1JNZ0FTS3B0dGdE?=
 =?utf-8?B?VTZtOUwvWlRxaWxJYTZrL05vdWVVNUdDRHFrN3QvVVh4Q3dhK1FpZThIMVZh?=
 =?utf-8?B?cHJYQnF1bXdrYXRyM1g3NkNjWUt2T2E4ZUdLZVhJYkFJQjBIdWJwbEJQSFNH?=
 =?utf-8?B?TnNpeGJtajNLek5RTXVDYWhXMWlxVUc3T1NLTFdyOS9Bc3d0NnRRbVZvZnRw?=
 =?utf-8?B?aHZuRFVmSjM0NnBpYUQ2Mk8wT1hyNS9IUmlBU1hzMXlDcDBidlMzdCtBa3ZO?=
 =?utf-8?B?VXQvYTRkd0loRG5ZK1dOVklUeDZjMTZEMjBnUU5RcG96Ynd1ckJ3cDcwcmVQ?=
 =?utf-8?B?QTBJTlR1NUNVb04xcTcxeFNmU00vRHY3ZDRJZGh5MVdjR0dHalRvSFVVd2Q3?=
 =?utf-8?B?TGRkRjlCRUlqeHhWLzJlQ1haRFVFcml6TzM0Z1Q3cWpNVzAzeDVZaDk0UXVN?=
 =?utf-8?B?NFRxTXpoNW1hU29ad3YxNFlucHJLcCtKV1o2ZkgvL3NLVzkzSmJqeU9QblZ2?=
 =?utf-8?B?ZDF3U3o4QkZiVXplNm5xNUJYeUp4MnA1MVdaZldzRDVKOGlvMEp4YVZpTzF3?=
 =?utf-8?B?QjVIbUhVeXlXOXpTb2ttZGdlQldYWUVOV0U0ck9ZbEtRbnZFWE5VQzVIS1Mx?=
 =?utf-8?B?bmxlbW0wWnI0TWF3Y1ZxRlczV3ZIbm9UNXphMXdxQzVvQ1IzMnpIdGNLSnhT?=
 =?utf-8?B?VlNRRWZlTzJ4U2x4ZXltWW9CQUEvL3gxVGl2SGRUWXY1N1Z6ZVRPOXN1b2tl?=
 =?utf-8?B?cXJwSmlxMVlVL0dkYVZiTmdPNlIzWTFDRjFwcEVtY2Fqd0tNVUQ5ZDZmU3d1?=
 =?utf-8?B?UzBZU0FyUmNmZ3pYeW5JMjdCQVl5bDZ0eVFpUHNYcUNsL3dlQ0hUWEZwU2Q5?=
 =?utf-8?B?a1JSd0U0SkVCMzNFQlBRYU1pUW9vUUQvTWxOUUxOaTdnaDhaZy9VWlpXdGh3?=
 =?utf-8?B?OVFNYmJEY1N6SDhKK3ROOE1obTdDMmVubzVoRElCaHllZEI4RjVLZWdxaitM?=
 =?utf-8?B?V3NqWG5QMWpzTHVlM1Bwd3d6V1lVdjM0UVo5blZlZXpiWjVxRzQ1eVVwSWdj?=
 =?utf-8?B?NlhnQ3VkN0I1ZXd2UkpBNVJMK3Y1a2NiaXBjanp6QStnQW5GT0wyM2Mxb3NU?=
 =?utf-8?B?NldnbnZRbUVEUkpsWDk2eU9leS9yQUltOFpWcEhqcXpJcnEwbGV0M3dlczZ3?=
 =?utf-8?B?RTI4TUo4bERvYks4bVpFaTg1THlqVDRhMGhKQWcvUFZ2V01ib3A0QTgvRFUy?=
 =?utf-8?B?WE8vdGR4SjhwUXpFZkM1aXYrVHRJdUk3eXFER2NwQXNiMkNFdU1yTEFpcC8z?=
 =?utf-8?B?N2VCNGZxRExJQ2dYRXk0UlZGOVloSWFKS2hSdXhHTWJLWmYwb1BNRG1KaTFz?=
 =?utf-8?B?VEN2MmR6Ykl6aHFDNHl2YkxKSGZZRWNxQ0VPRTgramQ5K2RNd1BXemphNW5y?=
 =?utf-8?B?cTlZODFvaHNDK2dWR0luZllWR2srVmloa3NGQ1Y5R05jbk5aWElOVmxCQ1hK?=
 =?utf-8?B?d0JOQ2EwRklXc05kR3htZEFjRVdUODRydWY3QzUyd2RCdjRNNUo5Q0VHQzg2?=
 =?utf-8?B?OUx0aHc0eWRZWmFGOExzRG5WSmJxVTNlSWtSekJwRzZrVVg2aDcwZm53OVl0?=
 =?utf-8?Q?HUkYQdzVcuSdtjX0pCwxUC7s0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405620ab-8ab0-467e-8cbd-08ddd8bcc4ba
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB8068.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:52:22.5604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Daj7ZADiEAtEB8n/SO2lJCTrWdTZRXf91W3CWbWcM4FM6KRA4o0YLayNVZdqR+IS9XmUbW37E6XeuW4w9EkXTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6776

Hi tglx,

Gentle ping.

Thanks,

Pan Chuang


