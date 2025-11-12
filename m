Return-Path: <linux-kernel+bounces-897024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D95C51CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F8B1884642
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15D13064A7;
	Wed, 12 Nov 2025 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="pt720XPR"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21142FDC3C;
	Wed, 12 Nov 2025 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945160; cv=fail; b=FIgSxlCA7PvaPfTeYM+WCKoZqDf/yEfuvZ5qx0NpBS/55bUyO4SR55fkRtCRkv1n5V5F9XgVhEk+JGdL8F6heWM0RuSsxcBG2tdWjMGt46aOOAw5Qk4G3gCakEfqBQKrYak7cK6m7Zn+v5voJG8ebHNlxnW4cioYydLYr59fbJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945160; c=relaxed/simple;
	bh=RSJRXUcvXfFlwwKNr/gZ7Tqmz7MnmCH2YIOVZIP2z5U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N/RkUtjV6qqlS9CkxCWXjvRiK+S4wa5X9ZkpHMwPSk+k3kqmVAoF9uwQy/Uo0am5cohmjcwshcOmjeBR1Y6xaUNTc9hQK0hQMV9QYREyZQvJpTnVnj3OMyeCknczUlMFrfezDVlotqLdR0NrPAIFwKNjCWKSnEhiBGTD+7AJx8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pt720XPR; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfG9gngM+YKxp7TpRW1PDyDtcbwVuMhbgBo/djb0lAKqWsDz0P1ecDE+9883nQlZUV42GxYGWctsBh1iM/ab4gD6C6zTHszCYkJDGj6g+01GKgzHSZEYX1R6c+LnxMFrMDFnG98LpAHmiPITJaB0pX3LxwA5CAwQ8bBv3kLmN6SYcJcgibc+i4w9o6APZM3qyeOtXNxrohuYRhttwXAPg03sg48gQpS57KMYkLiraUwG19F52ng3pcguN6DO+S3v+H7rADnEpjEhYAmGPPC9cLnegGkB1wSk28DYtxV3FNvEsa39/CfdB2lsPKh95V6CUAr2lz2hasHYf1DAE3gYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3e9k3/PauJujL6VKGGW0BidWkzz7lgoqcDpgdSEBr0=;
 b=yxaKUjbsn3s0jp3TJRW4oXh2eN62+51or/6aDGpHThgey2DzU1dwXqxnyHwncdf7FpDfSoX6BVKX5p1eGv2Vv8m2eVVYLN5xEhmZyu+EFJAniec9noQR5LQemZ9HlX1mL2uofzpOMKQ7/WeZJHgc9mX2MKvjthSJu6HS+dhtOHEsMgghPwhKFrldTdzqAf8ncMdqt5Sxrhb2hiAczcnvp434za8/lfBokONm8BHnDfOsr9ZpB2IuBKdg2tKWYUuJ0uvtRigYiz93xwR/0jKabSydbXYtrxUk1pujk20bsYHKctfeG50EoG0G1s2367dyu7obeYnDMeppSL/Ca8B6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3e9k3/PauJujL6VKGGW0BidWkzz7lgoqcDpgdSEBr0=;
 b=pt720XPR7/cXEwyZnlnUz7RNYdQnTUafdmm+V9zgylmPd1fHmP88w0gIyMbRhtHj4eo43pi5Ud5QqcVLkd6c+K9h/hN2ycguGjjumcIGWfBEZP94x4FSvEGT6cuZ5KTFSz8zTJTCT2ls+PiXqRE53fytBDc4br1vGJzoOjTlQwAmUxNLFoHoI4AH+PJQrIb6ohSOPuch4P6ktlCut9mh+JAnE+gUTN0LGltEnLws2vgIOZcXCXW2gsemzIrbaHzRyjC1h4T6QO1o8/idIioAYb7I5BkqQ+TqATjSmADrqMv+z5PWzjwASYuhj3lWOgakZ53P6xPfX7o2S7FJcU9/jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by PH8PR03MB7271.namprd03.prod.outlook.com (2603:10b6:510:250::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 10:59:15 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 10:59:15 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH v3 0/2] Add support for Agilex3 SoCFPGA board 
Date: Wed, 12 Nov 2025 18:56:55 +0800
Message-Id: <20251112105657.1291563-1-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|PH8PR03MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: ad69878b-bc1d-4630-9d4d-08de21da84ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWpHcE83eTBiY3dkSTVad3ZwZzVoU0RRWnZmQVBLREMzeTRlTjJMVkVNVlll?=
 =?utf-8?B?QkNRTjQ1UXl3MDQ5MW1yeGlWZ25hNllWWGVvZHBHMXpZQ3NEWUtUZnBFb2I2?=
 =?utf-8?B?VHNuYy9jbTQwd0JnZDNQN2dyNzdNNWRtek9vNi9iYXZpRWVuVGhXYzlQMlNT?=
 =?utf-8?B?KzZkZzIrS1VEdmcyVzIwT3U2UENEc0dSQTVBV29vckNmaW5yam96eDlkZHhh?=
 =?utf-8?B?Q2x6a0pzUS9zMTFkSTZPdE1iVTJIbW1QNTluSFg0WkVXc0wyb1RaSVV3UDcv?=
 =?utf-8?B?T29SMlBnb1lENVdPa01pcm9SODlTdStuWDB6akorMXRTWlkyNC9HZHA4RHZy?=
 =?utf-8?B?S0REZjhDZ25TUWY1QXBEZFVzOTRJVXQxWWg5eldqekp1R1I1aUdOTU10eWt4?=
 =?utf-8?B?dThlSzhLcHZOZlJOMHlLT0VmZ1Z4OFBsaEFFRHYzaGVNaURkMjhyZWNuZnRJ?=
 =?utf-8?B?UFNzM3RiQXFXdHo2QkJIMWhkUUdBWWZvSC9SL1Iza0wydU1PekFHTEtQR2lX?=
 =?utf-8?B?TWdhYnVBeW96dHZCK1RzMmVwQXNMaFZod09aWXAxTmRpQXlxY0VtQ3VvTlJ4?=
 =?utf-8?B?TFN6alI1WkhPR2E1U0x3UFBSbjFWbTE2MXlOQlZEWno5c3BvZjlPQWZkR2Fo?=
 =?utf-8?B?bFkyeGx6WUx2NDF4dVpMajJpQkFMaFZodTE5cC9PS1RLa29TR2laSHdVYVpW?=
 =?utf-8?B?SllPWHFmMzZtU3l5MlE2NU5vc1lCcWk1aE8xUGhOSHl6VGZkYUxJMUtqTW41?=
 =?utf-8?B?OExKVWdPWlBORGhUWksreThGTjVXVVZLMUtpaUxLdXB3ejYxZUMrUDc3Y2oy?=
 =?utf-8?B?TTFpZ0FUWndFNG5nOE9SY3cwNHovM0VhRWxwWUxUTElkWmVkZUd5dGtraUhj?=
 =?utf-8?B?TXRCMUZrN1hLemJFM3JoWHpZc054aFB3NnFmbGFvUThTL3NVcWRsRDRWMUxu?=
 =?utf-8?B?QWRmQzlva09VcHhtclVJSjZSdFU0dk14TnZpUnY5Zk10TFdiaUUvSkg5R1hM?=
 =?utf-8?B?YmJBYkFMdXZUYjY4dzdmRUR3UzRXbnorSDVZbS9PakxKS1JUeU9CcExTZ1Rv?=
 =?utf-8?B?SDZweWk4dnllcUJEeWdWa2Ewek41aGlTc1V3cGJzdnJ1b3lES2Y4bmRJWDJ4?=
 =?utf-8?B?bnpIMmtBbjNTc251UTBZZmFHbXNCeVlGMjJvMG16dnc1VXJBS2dUaHlGL2E2?=
 =?utf-8?B?aVFRZVZ5WVIxR1lvdWc0NjhET3EvODRXc1BobGR4YXU2ek95S0VMSFNYME40?=
 =?utf-8?B?ZWNGWE1ZdEQyRk9SL3pBTXlrdGdBcXhjVnQycmdSTS9HQlBFL3k2cEwvRHNj?=
 =?utf-8?B?S2xxV2hzR0ljelFoeVFBYTdZRnQ5L1dGMklVbjQyOTNvVnhVWm44TVFjVU94?=
 =?utf-8?B?M1ZZU0ZFRVBiYlc3RWEzN2krTUtlcTVLcTNKbUt3cHNSeldjdkhydEZUenNB?=
 =?utf-8?B?QVZoNTB4alQrb2srUUdXS3BTU080QUV4MDcvcW43cVhtYXpDVlFUSmNvU1ln?=
 =?utf-8?B?Vkl4dExGNURpTWhPdXRKcEhvdWo2azRKRUpVRFlwRnlmaENpQUQvYmFCZ2dD?=
 =?utf-8?B?U0tJSmppdXgzUWFZRjR5Tm8zb2ttc2hJalEwL05CUFl0ZXZxTHp6M0U4TWFF?=
 =?utf-8?B?SlMzbCtCenlJTHIwWU1BTFZtdkxiMWZ5YkVjUnZTb3VWZzFVaWRycXRMakoz?=
 =?utf-8?B?MUlHZ3c4MU94OVVOTVc5dkFicnBiM1RVZkoyZDlzZmQzZHF2UGFwUEZURTNX?=
 =?utf-8?B?SVlUeEtWTW1LN25ZWlV4dlR6QUlqZXFjL3RFYm8xSnROdGw5cDVwbEFESUo3?=
 =?utf-8?B?UktZZzY1SVNMY29tOTdhaXVzWW5XZGNWWTh2aHZNZ1JFN2tqbmtzYzZyN2Rt?=
 =?utf-8?B?RkpuL3BlaElMa29kSzdMNS92aENWallqeWZLUndNZGhVK3k5Z2VjUWlJbmRy?=
 =?utf-8?Q?GGPzC3qzAQL5FAgt2gs5SZviow3Pf94m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aSsrY1Bpek9zOHl4QTdJZ2VBeUVndlMxdDQzbkdtak5GU1hXdTNaYVUwVzFB?=
 =?utf-8?B?UVZqWTFPdWRiaWRzeHhwcWNiM2Jud0tRZHY2SXZybE9SVG0zN0NEWWZ3SkEw?=
 =?utf-8?B?TWhkTndYMFdMYTVYN0VmZ3Y2dCtScFJEc29qWE9iVE5Wd25sWVZWSXlDdVBw?=
 =?utf-8?B?N3dKSXFRRktmc1ZUc2JDTFJjeVR1RDlNV0JPRUYxbm50MkRZMUVEWFloWHdE?=
 =?utf-8?B?TS9xSVVRTkZsQXorbitKNThoRGdEeVRmQWp5L3JJUWhtR1YraFMrQlhIZ3dL?=
 =?utf-8?B?TDZRUkVHSjhZWk5HVUdEOU5semFtTUZvQ0NNRHpFa0VvemxSZnR6K1BobnYw?=
 =?utf-8?B?NWhVQUZrUTNHVjFwb21tSXprQUczYVUrUEJIL2ZLbW5waHkxdkZyMVZML3Jp?=
 =?utf-8?B?cWJ2bGpndkJrbCtOaEJlWDNiNGZ1dXlFQkprdWZ4VlpSbnA0UWplK0NSbUhx?=
 =?utf-8?B?cWY4YUtzK2VBelREd1A3SlJqOEFHb0R1LzJSUU91ZHU4Z2FQZGxRbHo1a3c2?=
 =?utf-8?B?ZTA0ZmpiWk5IbHRHNWM1dmc2OUdFWm03Qi9SZVE0TTlCbWxtWVpiendLcTZ4?=
 =?utf-8?B?cWZPVU9WZ0x4aXgvemhkRGRzN2dsVzVXMTdLZWlPa0lPZHlxRnNVYllXdUIw?=
 =?utf-8?B?YlJaRUQ0QjVIaks1ZDI2amxYcWhOTW5LUnFMOVZxbm1IQ05lNkdVazEwditC?=
 =?utf-8?B?c0VLNGdiYjdRSExlMTBNYlZDOFR0L1praVQ4Q3VYU3hqS3hZL0hHM3h5aVhi?=
 =?utf-8?B?TktFVHNKTWl2MUZScHYrQWhSMEdTcHFEdXRzeEtReFlQUSt1SU9tWGpxRStB?=
 =?utf-8?B?cW1VR0FPam8vVzN3cmhWeEdHbWhneEZ6aExYd09IeGtuQVFBTEp2ZUYwendN?=
 =?utf-8?B?ZUxPbzFJejZpZVl1R29FNXUyZU9NeXV2VjlpR3hjZjlMZUxlalg1RktOY0JI?=
 =?utf-8?B?WExaZGp2NmFHMjJFdzhrUUFsMEZ6Mzh2U2R2Q1FrQlVodXUzaXVZTTA4UzIw?=
 =?utf-8?B?R1FwTHhFTnduUFRwTk54dlRiS1l6cGZDUE16TWhDd1hXc0JGN1ZCd2FZMng0?=
 =?utf-8?B?c05TYW1QTks0NDQ0ZmJsMGZHQS9OdEpaL09Za2xUQjBRTENGWWRnckp6VGtT?=
 =?utf-8?B?TlduRkhNS1RNZ1NKYnNIeXljbjdZQ2R5MTQ3c01rVDB1OEtNcCtVUGNmTVJx?=
 =?utf-8?B?YzhKbGVvNDNEVEV3MlhTRktnZFpaTHp5bEhCRFlEVTN0QW5DZi9lRkNKVXB1?=
 =?utf-8?B?WnNyaEl5ZVNsMU02bU4vaWREWWM3Uk0wa3M1K0dvNGlHRFIxNGdjRXBsTEFu?=
 =?utf-8?B?c2x1b3p4d1RjRmhTRCs0T2s5dDQ3dytTYllJZEo5ZGlxb1p3TFJmMmE1M2RK?=
 =?utf-8?B?NjdPVXlWcnpkeGUwWVlJaCsvOHRtT1JpNkhlZzJSQlRSUWlDaTM1MTh1K2NK?=
 =?utf-8?B?QmNxV0o5M1AwZFAxMW1tTVNRelFnZllXNTNLc3ZueEVncFhRQkJ5dkFXT1dD?=
 =?utf-8?B?dDRKVU1WZkt1RElVUEFVYlA3bTAvTHlVdm9rR3F3UEJQdk9XSE8rK0ZDOU9W?=
 =?utf-8?B?dWM0ZU9KRG4vWE94MjBnQ2JVR1Zvb1o5TUpWcTNVdVc3RXUwWlZiUjNqUzJs?=
 =?utf-8?B?NDFmSlFsTUVOSXpMS0FaYzFrL1F1cXhmdDFkbEQ0bm12QThHNlIzNFZrelIv?=
 =?utf-8?B?UTM1cnhMQ0xxUlZDMmorbzZBSDJRQlNITjF1ZkZlMmxWakdDcmdrSzBmWnpY?=
 =?utf-8?B?ZHNWV0lVeEVRQkVwN1ZNbXp4dmlhWENRVXFsUDlNa1NENUp3dWt5Y0FlTUpw?=
 =?utf-8?B?KzdYMVhrMG95TzdkbkkxR1cyT1dGSkttVVhQS0xDbkltMHg3SGd0SEFka1VU?=
 =?utf-8?B?NGFFc25DZDMzY3JMdUVMa09uZEdnM2tHaVhKNm9JcnFSNGZSTitYMHkvY2dV?=
 =?utf-8?B?Z1p2RnBNUE9vVHBFcmc3ZnFQL1RseGNreWllNnZMSGZpZjZzZ0xuSXY1eEtX?=
 =?utf-8?B?SVZOTENCU1AwdUdNL2dzaS9jREhsTTkrNGQ4VUNMUDIxTE5ERnhWd3pMMFp0?=
 =?utf-8?B?dWVuazB1amFsdFdsOTYzV1dFN0l0eUN3bmlybGVyNUtnMlJIMEl3UXVwblVp?=
 =?utf-8?B?ejBvSzhTc3F5QW1RUjY2SEhLa01YVWpWTi9NZjZpNndVdGlVRklVZHFFcVQy?=
 =?utf-8?Q?sl4pWJF/FkdCt65zOAvDqpC2F+8omOn0eJWzZzHtk3M/?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad69878b-bc1d-4630-9d4d-08de21da84ec
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:59:15.4560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrrbhUTXZKCbs7bYmQ5Jo3xkJV9EiKtREA7B5UNFCPeRPSXRddZCdZhtjEH33TZmOSHrxyxPeEn8nFcQLNs97B3zevKrVbyFlVJWZAtDpp71UXw+PiVuV2ATHgPaQLX9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7271

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Agilex3 SoCFPGA development kit is a low cost and small form factor
development kit similar to Agilex5 013b board.
Agilex3 SoCFPGA is derived from Agilex5 SoCFPGA, with the main difference
being the number of CPU cores — Agilex3 has 2 cores compared to 4 in
Agilex5.

https://www.altera.com/products/devkit/a1jui000005pw9bmas/agilex-3-fpga-and-soc-c-series-development-kit

This series includes:
 - The addition of the Agilex3 compatible in DT bindings.
 - The initial board device tree support for the Agilex3 SoCFPGA.

Note:
The patch 2 depends on the series: "Add iommu supports"
https://lore.kernel.org/all/cover.1760486497.git.khairul.anuar.romli@altera.com/

Patch series "Add iommu supports" is applied to socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

v3 changes:
 - Add missing agilex5 fallback in dt bindings

v2 link:
https://lore.kernel.org/all/cover.1762840092.git.niravkumarlaxmidas.rabara@altera.com/

v2 changes:
 - Add separate agilex3 compatible.
 - Use separate dtsi file for Agilex3.

v1 link:
https://lore.kernel.org/all/cover.1762756191.git.niravkumarlaxmidas.rabara@altera.com/

Niravkumar L Rabara (2):
  dt-bindings: intel: Add Agilex3 SoCFPGA board
  arm64: dts: socfpga: add Agilex3 board

 .../bindings/arm/intel,socfpga.yaml           |   6 +
 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../arm64/boot/dts/intel/socfpga_agilex3.dtsi |  17 +++
 .../boot/dts/intel/socfpga_agilex3_socdk.dts  | 127 ++++++++++++++++++
 4 files changed, 151 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3.dtsi
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts

-- 
2.25.1


