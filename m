Return-Path: <linux-kernel+bounces-878507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D1EC20D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65B8A4EEF31
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7388B3115BD;
	Thu, 30 Oct 2025 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KgnXuXuY"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022103.outbound.protection.outlook.com [40.107.193.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967130F556
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836964; cv=fail; b=RuCvvSiesHxfskd3jr8WB4lLmejhPfixU8EGHYtEG201DWq1ScZkEwyoyVCS2ZYweX1T4Lk/IQqHV14MyD6Z0ox78UsvRpI4UUy4ohOtlxd6cTRNwlr+0p+su19X7vF4Hz6mJmpLizqxwGHM8UynpfHm7AiLvmxxPKG7Avj3AHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836964; c=relaxed/simple;
	bh=Heq6775kYx9pHPKsY62YXb+4nHq/+pK5bTuWkEBlFRY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SoAjwC8M8a/n10JmqtHyZM6m26AmDoO/Rc/YmldPC05frgx1ojT1CzACj9Lm+MOSIAeK1fG/7ykm8lHSykINAvaytgQ3Ol7GDCKQcrLw8He96J6qshwEQyOwrlabykaIVW3+GEDrEkGjx+xkP8RF431dUL8ZfCeCNwXoh5Or8P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=KgnXuXuY; arc=fail smtp.client-ip=40.107.193.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ox5CzYDE+TLvP7EyHwFAzmT+g16v9XYbFQDHAqEejB1G+Hl1/fXX7cK6I6bdytqz0L1mph1C+We1/ntjmXNSHNeWp6TwLgWvUZ0Uw94XxiZR2jJ70qHQqiU5whSjOXeomISwHj/Yy5x8K1UdWJEm2Zcwc0jRZUsE7/LYxbnfly0IcfhmaEPRhOijN8jDR1SKCItYvcHIBVtKFNYs+O57mg93XVUSa9eBtW4ax8dbSUxwAgqnZ0y+H/y+x9vbeIIhygQQ/kvxRQmVgS00ziJTxyxHAphf4gaBvb4vn8BlZzvX6U6AVNFdNQSFd73EPx3urP4izm70SRPAB1FqREJoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYqinMbgJJiVidVkj+W8Q40g/qYgUhCy2gvLNLbmbZY=;
 b=OO0b7d1w8AgJCYpkKvbUOkWPARUoaBb69iMgB3XDQP/W9a0EsFioZG3zcT+8L/0jXSVsZVkOAqBdAbmUF/DH7ETtT0ZO4tlTOZBaKGKhqL0d+/F5iqjkZPFhuNWCR0vYTOWf13lMJQD1TPZJKdjv+fXPU5K8i6c6JsnAuxRZwR2lGQ8+ZD5PMaoTyy/oDiPSWhsYlWyBzYaNvwL4rb/6YL+RVDiByQtXd393V5DY73UFCiYff0OkvITOKvWqfymUNXj+MtB01KcLifQKXdWHQNMhIiqLbVDbZYU316CgZeF0l5yusLvtmQhaqvl64f9o2uGbkIGUOe6OSnA6g16MwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYqinMbgJJiVidVkj+W8Q40g/qYgUhCy2gvLNLbmbZY=;
 b=KgnXuXuYOpTj5jB9uBgSSJBMw5SvdMgVZhqLPBOMkly8pKJJzzzAv1W7mO3V423U58lddUp1mFEh7AzlQeei6EPXbB6afKPyjTf21OlcS3X+HV8UgewJNO3F0IA5yS+h4REA7jLlC/fTWUwAvm1yzef3gOmjCNivch81foex1XQfAY+40kxUFxupRdYlbcOIoQauKXvZlI2Hlsrqj/K+0twCMxcvCXh7a72XafJNuVghVv1tQn8p9iXIjJwnScIseJw8viOM9hSg9upc+6jtqefSfxtkTH70yizfVGMUTAlnim1LQDVtwE6dfEx8GJJKkDWCESR4wZuPFDd7874RQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6472.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:74::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 15:09:14 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 15:09:13 +0000
Message-ID: <45d09605-7cd4-48a5-9141-32ccd6695813@efficios.com>
Date: Thu, 30 Oct 2025 11:09:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 16/20] sched/mmcid: Provide new scheduler CID mechanism
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.282547108@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124516.282547108@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7f04d4-ab09-40ab-db56-08de17c6491e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zlk4R0ZhOS9rNVp2Zi9GM1dhRWxLL0N2YWh2cXhQd2ZWbGtMTlRXcWdGdEc0?=
 =?utf-8?B?MmVHUEs0TDI1aThpUmdraEQ0Sys3WkIvVDV4Q3J2SUJKbEM4ckRpVTBQZk1D?=
 =?utf-8?B?MytrQ2FScnMzZ0Q5anFwRnM4bUMyQWRBdkVYVk1pMWhHQ2tOR3JBejJ5Ylor?=
 =?utf-8?B?a2VGRk1OcFVmeXUrWkxHUEFUT2FYS2FOMDJqQTNHdGJEM2t6MWJuS1NiclpR?=
 =?utf-8?B?RXlDMjJZcEdnQ0wxTjRDWEh4T2Q1eG5naklhYnRSZU5kY3dTNndhWjFlVGRI?=
 =?utf-8?B?WElqK3V2cWRjK0R5NkdLam9FNFdUeVpYcUowTTUwTW5uVXpFNXZIeEs1K3hL?=
 =?utf-8?B?Nm9YQmtQWjJZSVFtYnFZNUxuV2tWNVJUa0hpcU5WbnEveGN5eEJaS1lQNFYy?=
 =?utf-8?B?QnhIdlRhUldwUG1KYnYvR2RXdlp1V1pCL2Q2b05jRWJ1a1FEZkpnNEVwZkFE?=
 =?utf-8?B?ZktqclR2UXpzOWMrYnZ1dUV5RHpOTjV0N1dlV2E0YStJekpJS0RLSXdvQkFW?=
 =?utf-8?B?NDJ4WW03NnY5N3ZUNUVLUFpQN2FxVmd3YWVtSEhwbEZsck1sVkJheDQzOHVv?=
 =?utf-8?B?N2pmZGl6MVVySVFPa2pSbWtxcWF5cWdGNHN6YmxaQ0hma0p2dFB1OEV2Vnhm?=
 =?utf-8?B?Q3g5OHJneVVWTzYxVkNpekhMdEJmNmJLOEhxT05zbXovczJ2TEFOeHVJaExJ?=
 =?utf-8?B?djZxbnBYTFBkSEszNlNEWC8zSkpCSE83eHp4bTduRnJhWE81dmVxd2RJaWlw?=
 =?utf-8?B?SFY2M1pxLyt3UytxcjdiWEt3Mm93SlJlaytIVnhQN3gweXFNTHcwRGJHeW53?=
 =?utf-8?B?M1JJRDA0eTJlV2djd25IaWV0bjRHK1FXaGJtb1llUWhjVEpPRGRqNW1JQ2NJ?=
 =?utf-8?B?R2YvS3RwRzIwam8yWUlqOTVZSGRXb3RmbXNFdms5c25vc0hhOU5rUUVaK2dM?=
 =?utf-8?B?c1J1cVhUc05pSG5oTnlpRlFJZ1VwSkIxRURyeXowZlpQNk5zRVNpM0hyTVJa?=
 =?utf-8?B?T0pQUnFpeCttWG0wN21xRnNaem8zY2NsT3dPMkprWHFPdzYrVTZtcFJ3N3JY?=
 =?utf-8?B?OFg3Z1dMUWpEUmV0RzdhZ2VoaGtwTEErNHhGMnkrZXphb3dFZC9LR2k4UHpn?=
 =?utf-8?B?K0xOd1RzSDZCVzJKcm8zRzZwdDZMOUhhcFJsY2FIS0JQeGlFWkNabnBBSlgv?=
 =?utf-8?B?Y3JlTGVscW1vQWVNWVRXNzc5MDZoZ1B4YURSVG5pOFVleG1DcjZSZDM0UTlz?=
 =?utf-8?B?UzZGcVBjZ3A2SjJHdWROL1JtTDRHSStWYVZvRi9idy9jRER3K1daVXJ2VDhu?=
 =?utf-8?B?amxBdG0rdndLS2Z0eWZnT1JnRzdBaVh1M2s0M2ZXREpWRzNaeG5ka3NVWmc1?=
 =?utf-8?B?VGI1ZkdvYUI2NC9IYmRaMFlWWGdBK3JnbktER0FkUlZib2ZXUFN0NHF5czFk?=
 =?utf-8?B?OTVnWHJHNFJqTHFXNW56OG9DOUpzMFNFOTVmckMybEdMdGx3Q2pxUGt6MVZI?=
 =?utf-8?B?dTNZNFg3MTlGT0crOVd6cjRYNW9wTXdqUk5FSVhEa1N0ZnJqWXlRT25qemNt?=
 =?utf-8?B?UUQwbFUwblhUMGRnY1JNaUk0K01yQnl4OFZqMkxPMENBU2RoNGVWRDlmelQ5?=
 =?utf-8?B?a1hRU3Aza2RBdGp3MWFjblFsZHRoY2dKNGNvbWZ4cXlCS0VoQ3FUaWE2M09G?=
 =?utf-8?B?SEJ6NmVLWVlYMWhMZWJlSEVicE1Ea2lyS0FkYndIY1VKeDBIZ0szam4zLzVC?=
 =?utf-8?B?TUJCSERIN1lyV05RYzIvVW85bXdSYWZCOGxJdzJHRmRYSDVCMDVCc0VyaWhF?=
 =?utf-8?B?bWpGdmswQThXbnZFdXFQbVZUa1hJeVBBRVF3M1F0QzZvcTFYWHdkNklJR1Q1?=
 =?utf-8?B?ZjZvY0J0SS94Sm1VRENUb2dseDRnN3VyN1dsb2lkdk5qdkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWtidDNuMlRjbmZ3QzY4QXZGdHJWVmF3dUNHeW1qeXdHcmxYbUZLNkhzTUd2?=
 =?utf-8?B?T3FSd3dmVUJORHcxWFM4cnNyenNNVjNFRFFleXZpWHUyT0k1a21jV3d5cVNN?=
 =?utf-8?B?Y0kzTkk0VjhpZjZTZHg1bkpxN0QrZHJtOU10MDIxczNwTWxITloxZlVKRy9C?=
 =?utf-8?B?K3RQR1ViK0loUk82VE5wVVdMbDdRYkpRNXY3c1dCQld2ZlAxdDYyMlI4VjdU?=
 =?utf-8?B?NFZkTStvNml1Vy9BcExsMUpSa3dZbUxZaTI1Uk9sM0JVVFNMZ0VIUzMvYjV2?=
 =?utf-8?B?U25pVWY1UG1NYkhaaGh3bTludURtQzJVZWlsSXB5d1hmOU9BazFlcVR5d2sy?=
 =?utf-8?B?WW1BSnFxdm9CMGQ2eUtLc2JSb3VWdlREZnZqd1JwRkpQemJUOTRQb2xCVGNC?=
 =?utf-8?B?dXhNRHQ1Rng3VmFCT21RTXl5MmlBSEZZTXJGTWZkbEcwTXh2NExQb0N4ZTUr?=
 =?utf-8?B?WnlPZGVkWk41Rkx0RDZwbWwxdjNOMFZNdjVtOVdDTUpMVnJ3S1VjU0JxTmxQ?=
 =?utf-8?B?SkM1YTgzNTNxNXVIUDZ3MnpvWHFpYjhzL1hnTTArb2Rvd2FvY2Uwd2d1VHZt?=
 =?utf-8?B?bnE3YVU3ZlJsZDJPYmJpTVhWYXp0T2V0WVVuSUpKSzlaa3NvRy95azhoUVZ5?=
 =?utf-8?B?ZUVvM25nNmVOOHRPdytqU3llSXpDL2haSlpVR3JHZzJjalN0ekZ2NVlyNytV?=
 =?utf-8?B?WEFFc0VzaURaR1FtcTJaOVIvK0t0NXVITmZZV1JwbkZnSXZ6SXZ0Q05pSndF?=
 =?utf-8?B?UnBSL1g4MEdadXFENUE1U1hmREpsSlJiNnBjeDE3VlhqNWFweGwxeGk1bVhY?=
 =?utf-8?B?MEhlcDN1Skk0UFRXZ0QwN0F0bkhmQmczQmh5dmIzSW9HbTNFK3U1SGJMWlhE?=
 =?utf-8?B?S2k1Vi9RVWlIM3B5aCt2S2hyZEluNmZpUjBYWTQ3L3luejg4RjMxQmJLbFlQ?=
 =?utf-8?B?NWtVWXpMWlNBWFpDOS9nczFFS0RhS0grVjQ3bFRsWnJNZ0h4aitLMExGSzIw?=
 =?utf-8?B?V21IeUs2bk9YWXd4ek9sK3VndFhFdWd4T1NscE0vb0VwU0J6SWxtcEh5Kytu?=
 =?utf-8?B?SHRHbzlhVkRuYU5JY3lveVhmNVJLYTNXWEY5K1ZiSFM3eGJCREo4Q2pOSFFI?=
 =?utf-8?B?bXFjcDNkb2tuS2Z2QXdzNUNja2RDVlo5RXc4bEJheHkxQzRtOStBNkx1VWh4?=
 =?utf-8?B?QWhSMlYwYVdqdFE2Z3RlNXVENG1zcW91Qkk3R3VWTC9iZU5paDVVckdyVFlt?=
 =?utf-8?B?MkoxLzdjM1RCakhDUVY0cmJpMkQyV0pDaG1jWFNFc1NGbjVpR1ZvNnBFSGNQ?=
 =?utf-8?B?ZFVEQWFsb0xFa0Y0UVZNTEFBMUU3ZWhicGRkbis1MW9aNlV0WHlsaG5VdVdk?=
 =?utf-8?B?YTlFKzdvTTVvdWc3cEo3VlVubklFclFsU205UVBtaDNyVGcwbTQ4Sng4UTJp?=
 =?utf-8?B?TklIaE1ZTVlLL1prWm1Ndzc0SlFSaUN6b3dUaEZWUkdEM3RWQlN4QW5NVU5T?=
 =?utf-8?B?dDI3bE1wL29NaStwNGlDQjBuWllWVVRkV01iUU1PSXo0REM5aGJtVkpNbHUy?=
 =?utf-8?B?eWVheWhveWVGR2drL3Q0RXAxTWlla3ZNaFdZVkJrSFZoSEkzaTJWR3I3R1l1?=
 =?utf-8?B?SU4wM1FxbURFMnoxQUpveXUrOVl6N0ptd3N0NENPYlpVbzRiTlVhT1pDaUNk?=
 =?utf-8?B?ZDBFZWhldVRtQVIxT3p5ak1pb2ZvWXNtbGZ0NUhrRjF0ZnlGak90K2VVeDJr?=
 =?utf-8?B?STc4STFXU1p4bWlSZ1NIQmlMOWdWdno1dUEwWGY5d011c1FwTFdVWlc0MGhj?=
 =?utf-8?B?VWJPQ3V6dlM1N0RhdHBCZmxLb280L1c2OU9OWmk3TndzOWYreGI1Q0hXK2VI?=
 =?utf-8?B?TmorUUw5enMxTEVzUDZrQjduMERFKzg0VEFzQVk1Mjg0bk5RSEgwWVVZVzU2?=
 =?utf-8?B?OWdialNtZW5XR3V0aWJxT2RkTzR0WnRRL2ZTNkM0Ui9YM2pnOVZKS3ZvV3Vq?=
 =?utf-8?B?QkZJdE5aVHkvbFpua0t1OVNsR1hYMFdoYkJNQURocDFrWWE2eXRyTTZTd1NT?=
 =?utf-8?B?aUE5eTZHblFiU29NLzNTNU9oZTlJQkF4K04rZlpZZzc0bkhrWk5OWEpON2NG?=
 =?utf-8?B?MUxYRDQ4THhCdFZJWjRGSHNBRkp1OVJJVVA3TUs3cHhmTkRmTWlXc09VL0Q3?=
 =?utf-8?Q?MVqkejznHCkZtgRS97h/W9E=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7f04d4-ab09-40ab-db56-08de17c6491e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:09:13.3407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxYKQjAhl336Waau/ujMfqupeTLjhsz4N1w2XlLbuVAiuik02sSlMwpGjszrjftAnZ/5XGX7W/LrpybJYy8uHgGoOkriJ6jdYK11vloVf04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6472

On 2025-10-29 09:09, Thomas Gleixner wrote:
> The MM CID management has two fundamental requirements:

This explanation is duplicated verbatim between the previous
infrastructure patch and this one. I recommend keeping only
one of the two copies and adding a cross-reference in case
people are looking for details.

> @@ -130,7 +132,10 @@ struct mm_cid_pcpu {
>    * @mutex:		Mutex to serialize forks and exits related to this mm
>    */
>   struct mm_mm_cid {
> +	/* Hotpath read mostly members */
>   	struct mm_cid_pcpu	__percpu *pcpu;
> +	unsigned int		percpu;
> +	unsigned int		transit;
>   	unsigned int		max_cids;
>   	unsigned int		nr_cpus_allowed;
>   	unsigned int		users;

I'll repeat my concern about false-sharing between frequent "users"
updates and surrounding read-mostly fields.

> +
> +static __always_inline void mm_cid_schedout(struct task_struct *prev)
> +{
> +	/* During mode transitions CIDs are temporary and need to be dropped */
> +	if (likely(!cid_in_transit(prev->mm_cid.cid)))
> +		return;
> +
> +	mm_drop_cid(prev->mm, cid_from_transit_cid(prev->mm_cid.cid));
> +	prev->mm_cid.cid = MM_CID_UNSET;

I wonder why the transition from per-task to per-cpu needs to drop the
per-task CIDs. Can't we just move them to the per-cpu CID tracker
instead ? This would save us a "thundering herd" effect on the
cid mask allocation when switching from per-task to per-cpu.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

