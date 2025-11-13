Return-Path: <linux-kernel+bounces-899083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BEAC56BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8EC3A7E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DD72DFA46;
	Thu, 13 Nov 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="ksoc4oY7"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012030.outbound.protection.outlook.com [52.101.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38522DF12C;
	Thu, 13 Nov 2025 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027852; cv=fail; b=PKVmVP2vtKG9I/FaVx8T3JHgCF29gZt6zMOqqIW5LZU2bWbJ9mcAxAMqUWZs/BfjhCxdGF+ZOcniKlabZJBWH0NqfcIKmVnzDTIvC5hBfFH7vK4A5iWGCzFGQIR+A/aQW8PaHpCmO4cqUiUjE7XfsdRa4K1XYaB85WyKipOpcT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027852; c=relaxed/simple;
	bh=FGplRLmxa1m4yqXAPpndJionoZPFxfSuzUqcb+0WS/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TpUfUlO5fNL7Qu3P3vDOdAmWsD5k9ho6XoSNKFWyvR7V90QMPhuRlVitOb6/ubIHgpIeRtLE4DV/iN5WRoFKIVb1q3NPmkblminXLsh5IpF5v6t19coFoyDw3qTJZ59bWfpRm6zzPBU8bRwU5xzayuJYKyAC8QA7+kCdFoFnLZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=ksoc4oY7; arc=fail smtp.client-ip=52.101.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqbqH36cNCNqTeKyHKi1QGUcSTIB8VDQyf4PYKssdOLO3LLdCCCYKaT6I4B8Ty54Ea8NUZVF1QWoMwu5SelrstLR/8qpOp+Uviy+1yDjuTDxKwDyHKNY2QJHiGTPZLoKTm8fN2nIMqjfYfAiqjQ9jEkJu/6CYkM6r0mQ3byRmfAFCEmuQ5+s4njTlaQKa5f9aTBN5hdpDWA2RWIY2/hXTtQxOKHxOCxAvtDiQmwlA3SHrKyxoUTKRAVe0S4/Z4hrO5c/5sZfoW+7yo7a+ZolkpXPPvZp43T/wR85EEN6zKV1lsmEnk/35e31hdijMyd8udxRRwqRwTGVKXPfSKBJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zm240b9LMkAwHDYzNatS3Zq5ccj4Se/T4wQKo0mTl0=;
 b=jTNN5NHnz3uRtAzCMoEv6Bw+RlzNg729Peq0IATeA1eOwiJsqargXPwnBiTsZtcNpFd37NI0em5d3+4qrPH1VUq3+nENXV3OG3QiBLURpLGJrmdZw6mo9Hyt718jhboSeMPcDwhuBovnS2ykuHJRQc9p2Y86ZGewQikKtE4gD5YJJvU3m8UH0rc4Eid3b9JyTmlN6st6gULcWP1Axa3LrX+2tY63UU3qPzOyymS5TLDDwLp/K6m++sDE4SQvPpxcG1/mqPm/jzei0BTj6BQsXIL9djnn/fy3V3Vulj1XD3Y2k3D0pwMHlJ8MOHt0a3ZB78bGx9bJRZVNNcyL5RchUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zm240b9LMkAwHDYzNatS3Zq5ccj4Se/T4wQKo0mTl0=;
 b=ksoc4oY79pcR2ydntGbbzHhYI8gFfyH+RLR8U+cNt1WZXGmaepyvliL8bscuuGKOTpYRjPCGkv+r4Q3e6S4Q+18YfeHaKlETrezsGYkAZJUixelM7JBgcuMrWCmk10TiWVemUa6h0DmWPvQVpsYycAR+AwqzSL1g04AJ5z08GOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB9804.eurprd04.prod.outlook.com (2603:10a6:150:114::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 09:57:23 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:57:17 +0000
Message-ID: <575fd825-5ee8-4a46-b9ef-2a16d9ce61b1@cherry.de>
Date: Thu, 13 Nov 2025 10:57:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: disable HS400 on RK3588 Tiger
To: Quentin Schulz <foss+kernel@0leil.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251112-tiger-hs200-v1-1-b50adac107c0@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251112-tiger-hs200-v1-1-b50adac107c0@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a561b3-7040-41fb-712f-08de229b075b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1lpNnZlZm1mNVZITGtiYWl5TzBIc1BocFpodlJYVTVMNC9pVFlmUklkYVRr?=
 =?utf-8?B?TGRTRTl0QWFxeWJ4VXlpN2FsMlR0UDZ1VWVOVExvN09HeTlWdVpqYnJTZEwx?=
 =?utf-8?B?Nm9sVzZRNmFVYjRGd1VZZ0l5ak5YYk1VSEZRbHVJYVdtbmRHZFZISWs3NlNn?=
 =?utf-8?B?QnVHaXFDZlpsdEhvSkhaRkQ5bEpGbHdNdU1pcW1sS3BnanJEcUI5ci84YzBs?=
 =?utf-8?B?NFcya0NXMk5uT0RjTWRZRVRFT3BUWHFwRHI5Nk0vMlZMcnpqczVvc2hlaVBG?=
 =?utf-8?B?TDVqamZ1N3g4MHFVMXJQL2JKTnhxUFlTMnFuY0cwTDRQcVUraTVsQkNsa25j?=
 =?utf-8?B?WkRuRTZqblRRUlU0QWo2UnNucVpxdThEcHZDVVBnOFBjam00UTZEQzZnNWF6?=
 =?utf-8?B?YW85ZFZPOTB3b29SRUNGbnhEL1lZQW5RT3BNaFF4UjkrUDJkWk5jT29HOGgr?=
 =?utf-8?B?bEVGUWpsS0ZLdWxiR0JabW1jUDRyM21NSldObTNGdFhxdlpHU1dIYTBGdlh0?=
 =?utf-8?B?eFgzd1dDQjRDYzNsaGhvZXNacnc2a0hOa2dGM0RZU3V6YzVsVnMzNFNnR1lC?=
 =?utf-8?B?OVQ1cnV4WnZvdDFBQWYyZzFFWWNNa2ZmY3pudkpZRUtQZGR0RlV1ckYzVGZn?=
 =?utf-8?B?U0hxRzVCeWVlOVRrSnZSbCtPRlVtKyt2TmZHVnpaS1NWY0VtTkdkcnJpdHRE?=
 =?utf-8?B?eEhia2VQd1RXS1RDeTBmakxGVWgxZ3FhY1NEMlFsTSszdUEwTnFvTzVVei9O?=
 =?utf-8?B?R0puV0VKZE85SHprRXZySDRQQ1dDVnpUUDZnUU5PbmVoMnVlTDU1SERma2RR?=
 =?utf-8?B?cXZwK2ZkRzMxZTlTZ3BPZzl1d2srcmpmZ1YzUmFHd2FGMlhnZzhwK2haOTBj?=
 =?utf-8?B?RVduZzZvZm5vUXN4UkxRaGVRd0NTaTBGSjFVWE0xZmJibk1jVTQyTFFxNGdm?=
 =?utf-8?B?dFVVZlNGUnBwTExnT3VOQ1dpSUpKM2twSkIvdTJ0OGFDTzNUc29USk1ZaTRK?=
 =?utf-8?B?QWNOQXdGUm1jaEhKZU11aVlITWF5U0R1WHpDWS9WQ0xMRlo5aDlHdXRSZ2Y2?=
 =?utf-8?B?RDZKalFmK3FSRnJKQXNPenlBZDRMMUszRXJQOCsxaXBFcElCZXBCR3B3MjJs?=
 =?utf-8?B?NFd0N3NTa2tTQ2ZoL3p5NzRqY3l2L3B1QjhhQnh6Ri91dlBQMEVGRkF3b1RJ?=
 =?utf-8?B?Um9BTE9reE5sRWVzUlU4bEdoRjlxZGxSRHJkOWZzMW1hc28raTdiaDNCMGlX?=
 =?utf-8?B?enJ2cUZoT3ZTZjFPeTJETFhWc0hYUUFiOHFFNEozcmpHK2NJcjBHemo5RC9Q?=
 =?utf-8?B?d0JOVGIwV21qVWRmMXQrcDI4TTRsZkg4TU1NL3VQcHFOa0hvMGN6bGdWOXQ4?=
 =?utf-8?B?RGRMTnh4MXdabWxzZENsMWpTSTFyYjE5QXhHMDh3QzE0eGpNRk54dHlLYnAr?=
 =?utf-8?B?T0tGUnd6ZnZCWnZWNTU4SHFpYmw3eDFJTFdydllhSk56Nmh4UWJBSmh5K1Rl?=
 =?utf-8?B?ZVZ1SDJtekYrZ3BybXVvWGlwWkxkNVJUQi9BUmZWS0pWTDhHa3FaN284TFlE?=
 =?utf-8?B?Y1NISG1scVd6R0s2ZTJHMmlwSXFUTXY0TXYvUUw4NXh4SHlobmEyN2lkcnZN?=
 =?utf-8?B?b2RlbjNCZG5abnRsa1dpMGtXRDZucEVocmFkZmxQUFVtNlRIT2N0Qkc2MERC?=
 =?utf-8?B?bWtSYWNVMlpUaHNsNXp0L2NHZnNlZ0ZDWHdQU3Z5eDlBU0lXVEJ6RkNQdlJx?=
 =?utf-8?B?Um0rYlFuVXlMWGlsTytCaDRVSS9TTG1HV2ZSWktSVFBkaG8yUW5MRmp2NGht?=
 =?utf-8?B?dExUMkdjZ3BjNXhUa2lTTklQeC9BNGNhaGh0b0FNcTVHc2R6S0xCMHgyRUhF?=
 =?utf-8?B?YWsxcGl1V044eDRHWXU2WDRkOTFSUFdFZDFtR09DSGN5ckhaQVFZNEhGV2VT?=
 =?utf-8?Q?ojWoEPJOjKqTvApvUZ3r4zkWDR86xne4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wlp0dmxJQ1o2T3Q3dTNZYXZsU1pMbUppUzBkcUZkSHlsQ1NxZVZBeGpIdngv?=
 =?utf-8?B?SlJkcHQxSDlKZkdwUEYvRWhUdHNpcFpWVi9QZXVGNjJ2VExIVEFWNDhWR2pj?=
 =?utf-8?B?ZnRZaHdtYVZSdUdyUlZvcW1FaE91V2s3bHpLYkVJbktFVDhwajB1bkNheU9w?=
 =?utf-8?B?Zi9qSXNxYUY4U2xOTVBXVDVhVWJ1MEhoVUV6QUt0eFU0cmdPMDRDaUFKaytQ?=
 =?utf-8?B?dGxMRHlhMlN4YVBOWURqeCtVQnZIc2ZvY09zNkZ6eE9TVGxic254eUc1Ky9x?=
 =?utf-8?B?RU5US0VYNkZzM0p0KzBoWkpya3dzVWd1SEJEamZxU2VUM2c3Y2w1K2xrUHJ1?=
 =?utf-8?B?bFV0dUdQR21ZVWl0OXFFajM1SkE4dHpScXlqaUQ1cTdmem5KSmtaZ3Z0UmhT?=
 =?utf-8?B?Umprc1dOeDlHMkZocm5wcjdxQ3pBOS90SHJ1dWlPNTRaS0lhS3RlaGo2WXBP?=
 =?utf-8?B?d2lvakVHODFqcFNKTW5RenpRTTFBTWZKL05NVFBqWjFsWmYrYW5LTGpDM3lL?=
 =?utf-8?B?bENqdFpnQ2lJcmZsQUk3R2pCSnNCWlAzNjA1a0oxVFBwV0xSU3JZZkZFZlJS?=
 =?utf-8?B?MG9QcncrNmlPMW5Mck5vMXlLM1l5eEZEdmhJNlVSeUk4dkJZSDFvR0d0ZkZr?=
 =?utf-8?B?OFB3ekpiVnBhdUFhdzh2T0F2VnFPVzQ3djg3OEtsVCtTMi9CWCs2TG9mMHd2?=
 =?utf-8?B?d2EyUUtCWDNsaXd6SGNlVkM5a1g0VWtYb3dxZm9sbzdjYW9uancyRlRjZVE0?=
 =?utf-8?B?V1dWcFRoYzRnSitkdTZsNTIzUXlBMlpBUmlQcHhLN3l5ako2Qm4wVXFtdVBO?=
 =?utf-8?B?R21qL1MyYkZ5RDQwUUk5SmNLTjA5bk0wRnNRWnZUWlBPakdRanp2Q2tvS2gv?=
 =?utf-8?B?cHNBamtYOEs3THRrNnZVNDJYZlltejJLM1JIaXVsakNVZlBzeTgrbklvdCtL?=
 =?utf-8?B?SyswemNQRUZocE9uUXlmeEduRjJGS0taMGhWbE1FVURUdmZtYVgwUy9heXVh?=
 =?utf-8?B?QTFPdU4vYlNUZG0vWk9FZm5XbXMzWU9aRDJFMUhEdnN1eWs0SmxzQ2xyd3JC?=
 =?utf-8?B?dnV6ajJnRDd4SmVuUENRTUtiL2tvM2R5U1FjeEF6dXE5UzdiN2pZcnkrR0Vh?=
 =?utf-8?B?RHBrNWlXaE9kcVNhbWRVNjlwVWpXb1BQT2RlVkcyZkxxb2NlWm1PZHRRekpH?=
 =?utf-8?B?RVNLTnI5QVZiWGhUdmVwdEx6Tk42Sk1UdHIrUWpsb2ExR3c2WlpncHpPcGJn?=
 =?utf-8?B?YWwxc0UwSDhrYk9Bc25ScnFTanI1RmdOY0E0RnJxU3VSQXpYNGk3cjJDN2pN?=
 =?utf-8?B?azAxenNzMlpZelVKTUNJNG5SR09JcDdzNFQ2QWkyMXArNXNuRFRxRTVhbVI4?=
 =?utf-8?B?NDNwQUpLZHNpc2c0V3lkQXRaVW1BTWtiazRUbDhuQk9CT3BIdXlsbHRiT3hP?=
 =?utf-8?B?dWpJck5kNWZSTW9tdEFsQ3I2dVRwTU1qZnFFSzhDRysySFlSNC9McFJGWlNu?=
 =?utf-8?B?TVFRSDdrS3NNVmxSUVJLUjJtckdVRE1zUVlFS0cyaTQ4RmQ4b1RuVEhRL2s5?=
 =?utf-8?B?Y09zMlVJSVVDY3lmMEMyc2lSTno0NFZSd3I3V29oMGtVY2daZ3pRTExSejQy?=
 =?utf-8?B?a3ROb3ZJVU1mamdHSkZMeVdTb1lmb2p1ZVJrT3FQK3NZOHFpdC8wanRLd2Vq?=
 =?utf-8?B?WkQrVG1sZFlHVU9sMlJOWWoweXFjcWx4M1EvMks0cVR3S1NKYTAvaUxZNVE4?=
 =?utf-8?B?VGg5VjVva05TM2NuNGxzVi9tV3N6eFc5QzhkczJHNGpFK01WTldSNDBNQ2t1?=
 =?utf-8?B?WWRxRlI0UE5IUjM5KzQvV1FLbTJTS2xRRjdZcURMbW9QT011YVJCSkhpVXZH?=
 =?utf-8?B?anJoQ1RuWGpLQXRaY2NOYjIyekxRZjZBOWhLbGxvM0Rva2lSazBKWVBXb3FR?=
 =?utf-8?B?YlJycE8ya0NwcWFzbTNPZFFScyt1VnVEZDY2UnZDZnFPRE84ZUthQ1NHVS9p?=
 =?utf-8?B?QUI3R1B0ajZRTGJ1eFdZUk5PMXZxbnNZUFEybVQ5SWtlSjltbFp5K1I1Z3RU?=
 =?utf-8?B?YlhqY3YwejZoeXBKUStkTE1NSUdIRXNTRXUyaTJtMnRjbnMxR2FzdEYwZnYz?=
 =?utf-8?B?SmJLSUE1TjhzaXFGSER2UGdTTjFMMVdUSHJDNG1Va0ZhVnVSKzFROSthd2Jo?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a561b3-7040-41fb-712f-08de229b075b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:57:17.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gGHT+gVZc4Dn420E2b65YY73/0VuCgKm63S95jR+cAxpa+d2Y2w40OZyHbZ7U6kBje70a9oiu9VpHyM7EmeXMGnEb8YFVL0t8pXw/I2Eiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9804

Hi all,

On 11/12/25 4:01 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> We've had reports from the field that some RK3588 Tiger have random
> issues with eMMC errors.
> 
> Applying commit a28352cf2d2f ("mmc: sdhci-of-dwcmshc: Change
> DLL_STRBIN_TAPNUM_DEFAULT to 0x4") didn't help and seemed to have made
> things worse for our board.
> 
> Our HW department checked the eMMC lines and reported that they are too
> long and don't look great so signal integrity is probably not the best.
> 
> Note that not all Tigers with the same eMMC chip have errors, so the
> suspicion is that we're really on the edge in terms of signal integrity
> and only a handful devices are failing. Additionally, we have RK3588
> Jaguars with the same eMMC chip but the layout is different and we also
> haven't received reports about those so far.
> 
> Lowering the max-frequency to 150MHz from 200MHz instead of simply
> disabling HS400 was briefly tested and seem to work as well. We've
> disabled HS400 downstream and haven't received reports since so we'll go
> with that instead of lowering the max-frequency.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Went too fast and forgot:

Fixes: 6173ef24b35b ("arm64: dts: rockchip: add RK3588-Q7 (Tiger) SoM")
Cc: stable@vger.kernel.org

Will give a few days for reviews and then send a v2 next week.

Cheers,
Quentin

