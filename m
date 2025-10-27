Return-Path: <linux-kernel+bounces-871128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A54C0C7B5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50EB54F40FF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079772FB607;
	Mon, 27 Oct 2025 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i5LdXeQJ"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0792FC012;
	Mon, 27 Oct 2025 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554832; cv=fail; b=WyTvFSMqkYLIyRa3Ebi6FcqKKGYWO3gcWjm+RIou6i/5ab1QVCuz5ORCO2NOz7amnR5E1i3UPdbdecI0vsoTFfP77zNMt8ewOrpQRUZoeNiAvQGNkpN96WQfnPjL8FPyxbxdHt5uVD0XZRTnbuD9ftj1EuVNhwkOJ8wtXVbpHKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554832; c=relaxed/simple;
	bh=hUYaumacpieOHGyfLf4DOs7EVS7AXgnRrgmnejys2UQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TwYg/emzb9I872+3BsgxE3lZ0ASpdkD+XFJ8W6DOV20poRqN+l4n9Z5qykjBXegjrxlNsQmo6ef2vSBs+q+AdwKg80VIqXLCJzI1P8WglxzZNsyQNoGG0wWDI9oHerbt8I1w7m8oohUjgJn1qtKuRqHk+x/TyzyzvnhsPZdxS/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i5LdXeQJ; arc=fail smtp.client-ip=40.107.159.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ex84+88bjXIZ0vig0TfLuvUZamyKodn+DmcSv7Y0zMJSG5hyULdqFe7L2jdMPlr1+WCBQOJv+TM008/i6eQ1A5Lx82RBt+Ooii88tHz2u4dVDTCNlutbpbuil7Mq1YRN7IVR7QqgPZdz1hTDvdts8uGinlIegjCx0DtbOhCCGr+1JMWassWy39yk9o8bD/gzds5zNS7uDMzmpbsowrAfwvtjwuVHqhZN9BtYpgV9VTNEeuUTMIK2bN1b/JsgdpbR2hn2TAsZOh25YeP8PB30AXvfs0L3OzZY+8BzFutwtajZJau1VRAMN/FFmq12tTrTEFruGh4A7/hthRIQFru9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGMunIFIcOBCJg2FjXlmclmg9c2lCgL4MzlfIYGhw78=;
 b=uIH+G45JkaC6KXODjPJQmnANmZNNTIZmKy3mR2ysIPtE8CESKrPMvReV1wc+/eR8pTGlMJ0EbNaCX6vnaqNP1nmcRoLczFt4oFk2XxIa/ZphT985jg1zkuNDKvelUwpQ93niza1p1ML0Y+Qb31gVlsFdXCaBV4tHiALcpSnRoaCpoiX6s0YFtvfMLen7ktQ797Lqhw+01Ezk60nvHCw5CZDI2wSNnMQmOYQcHNoQbSVhlpQ6L/DIA8vu4Gvk1cwl6aJX2SNchSLyVvpBGWm1Tpb3ABQ8Z5eDisKi/xU3iuGq5+6ujsCKhIrLJSVCAdzNUHrReUfuspYUMgXqOJNzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGMunIFIcOBCJg2FjXlmclmg9c2lCgL4MzlfIYGhw78=;
 b=i5LdXeQJnwHphGpODthE9Nlm3r1+Rwr0KLbaziD3SoLajRa8zoGJi/gqR51dQJ14MQ1+5LCZ2h/n2FaQy6I9vws+DadQf+6WX423crcWF304RwkiNqi5dpsU4z8bxBrTZ6OCfNE/XhAlkWTbiGh82E1mj91lm7G3ik64Hl+sUEBrHo3JxhEuPqpFWHvIXFCPMZLF8FCJXtHk2gmn9bN6fPqO3aDdiHlV+Kn66O63XfDTzcKIzFNL/MO3IwUMhptj86d/MX89KLWQvJoU1rFlQuwnQI5sKjYSJkY16jxfq76YOU0It7UBGsU8v+2HqWUm2p+UIB/GxMVgGtKm2pAgMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8739.eurprd04.prod.outlook.com (2603:10a6:20b:42c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 08:47:07 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 08:47:07 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 27 Oct 2025 16:46:53 +0800
Subject: [PATCH v5 03/13] drm/imx: dc-fu: Fix dimensions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-imx8-dc-prefetch-v5-3-4ecb6c6d4941@nxp.com>
References: <20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.com>
In-Reply-To: <20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Liu Ying <victor.liu@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a9dc6e-00c8-4e73-40a4-08de153568ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDg1SUdiR0dlSm9SZ0wzS3NOcXhwSFVjMFd2aXBXY2d0dTBIUFdKUW54TUtq?=
 =?utf-8?B?bEtSOHBQTzhmek9pcE5SMURBcGVDbGtEQ0EyUnpJL1BEWjlYdlk4VC83T0Nn?=
 =?utf-8?B?Nll4UWh4eVlNdTdPM1pieTE2NWtHRHdzSklYU29Qei9waDNzcWlQbDRDNXh5?=
 =?utf-8?B?OHlGUUtzek5YaG56L0ZzYW52WE5wSktCS2crOURaMFk1UEdKM0pncy9JT1Zx?=
 =?utf-8?B?NDR1QXNURzRUR3dUaU8zV1hnRytsWmp4azdnK0I1MmMwTzU1NG93WVlmOGJh?=
 =?utf-8?B?c2QrNWp6UmFMSHVXWDUxMDcvYmZKYUtncDV3OVNLYVNhQ3VmM2FDdXg3dFlu?=
 =?utf-8?B?YmQ5RDB3Ri9VWUQ2emlGTXVYWGVYVUVyeXFFZzlDNDA3M0xSTS96UUNtQVR3?=
 =?utf-8?B?SFN1ZjcrOThtclZiNkl3eWpibmsvRzRKQWhUSUVWWkozWm5ZUVViN2NXT3p6?=
 =?utf-8?B?UWtpVXVEb3V6cnU1a0Nyd28xNFhibmxENFBxd0dpelZrdXRSSytNaVpsNnRI?=
 =?utf-8?B?aThtRjZyZFcwNzl6SDJ6SGMyWWRmODh1bGhNdWJSVXNMalk2UG5FQ0QvdTNL?=
 =?utf-8?B?cE5UbTJuTWE2aFdlRXFJY3NkZHpCNXBCYm5Wd0N2RFZ6VVZ3N2Z5VXFzM0c2?=
 =?utf-8?B?YmU0ekJuL0VadkozTENkK2RvSS9OUitiNFlIN0ZPQ25QVTAxVC9xMzloKytZ?=
 =?utf-8?B?bkVFNVhreStXL1hUczZWb2ErcFhHMnpxRnBzWjA0TWdId2tNQk85NzEyNG1Z?=
 =?utf-8?B?M2ZpQ0V5c0xDdXdIRGptcUVWbmhIV0Rnb2MrOVFqS0IzUGhuQ3c4a2laak5u?=
 =?utf-8?B?UUcyT0pIbGlwZjFmNDdJNTRUcTA2WmhLcEJ2em4vNEErekpqUzA1UFY1VTd0?=
 =?utf-8?B?cGh1YnBCY2ZTV0VZSGM3dGdKL3RIbkdzbHJhYUFoNDVNcnBGODFBcVA1WTJ1?=
 =?utf-8?B?c3BEUmZXMHZKYkd6bFhlVS9lSmE0UEpEZm1IODJ4TCttRmJxTmFHWHppOTZo?=
 =?utf-8?B?ZWpaUVRIWkVNN1JoTzFzemx5R1NOWmYxZUxVei83d1EyWGJYdGZKVTdVNUc3?=
 =?utf-8?B?cEViZ1VVQkNzRW1nNlpIc2l1ZUdQa01vUE5QekNwY1c3YXJLUFFvMmlOcUdo?=
 =?utf-8?B?V1oxUVEzMFdDakQ5R0FUZUl6ZDhsdCsxWUo1aGtqYXVyYWZsS3BPSFNpcml1?=
 =?utf-8?B?Ny9YNzA1WDhWdmNGRXFNVWpaa0JLREh1aC82dzliS2F4Q0V3K3p0SlUvbFA3?=
 =?utf-8?B?RHphWnlIZ2lRSjRGNGFobmV1Nkk0V3F1Q0VwTGMxMUk1SWEvUlFwVlRjZGRD?=
 =?utf-8?B?c01TZWxZR0ZSN1FwWnFqYnBlMXpCUjM3TERiWFhqZEUxREV1NmczeDFRNGU3?=
 =?utf-8?B?ck1LRVVZNHRwcmgwZ1lacWl5cVZ1bW9nMEluaHpIODdqbEgwc0VudmpmTHda?=
 =?utf-8?B?UThBNFRhNUdTWlBIdXByV25KSGswekFCdGUzWU1wcDNkbW1PR3JhSXUyWnVq?=
 =?utf-8?B?U0xaTHZuc1d5d1FLc0NDUlpZUmpGU3J1R0FWaEZCcmFsNnBpMG9tcUhGMW0y?=
 =?utf-8?B?V0dGMWJ6ZUhtWTFnbmdpenE3cVFnY1I2SkQxWnNtaVQrdldnb2RzL0RsaEsx?=
 =?utf-8?B?Tnd0Uk9jVnNCWnpCdmR2Wi9wamNIV0l4ZkNWUjQ2ZWlTSEN5TWZVNDlnTXEx?=
 =?utf-8?B?N2hobVhSa3p0QWE5ZDZlcjFsZ3d4UlM4NFdyNnZFdDYrK2ZsMHlDNkpxM0VI?=
 =?utf-8?B?bk01TWU3dUNhTHdLU2dzYkMxWTl1ZWxsU01oY3pUVmVxZ2h0TzhqNDNEek1Y?=
 =?utf-8?B?a1lrT1h5S2R5NVB2ZzM3TjFQaXB0SlJTUmg4Y0pUVExKa09jU0RuYkhFbmZ0?=
 =?utf-8?B?Rm9WUVg5WkJubE0vWk1YNlFKbjJBa2pQNElEVWE4UkkzZXJpR3V0Zzk1R1Iz?=
 =?utf-8?B?MW03KzJhNm5qbzEvR0R0WUEweTFuaTZZa1l1NFVKaXFkWjNGQkdUdHFyQ2lk?=
 =?utf-8?B?QlRZOVlKRnV5NzkwdXlZZ3RwRE5HY0VRNUhhTEYyZUFhNFZ4RHJDVCtIUmdQ?=
 =?utf-8?B?MDJmS1Y2WkR2VTA1cnh1YmZTdFFSUlZvanRSQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjVzZGk1b0VuNFpVYjVubitZQWtSVjZpYXVEbmxnT1dwQWpPZTkwaHVBdkN3?=
 =?utf-8?B?SXA2R0RRUVg4MGlHVGM0bmw4TW8xY1NmZFQ4N2IwcEJZcmNoQitWUWc0UDZN?=
 =?utf-8?B?YjlZZThYZ251ZEVOZWcvd3BET3R4VStDeWRyWDZCZWRGU0diZDVRUHhqRUcw?=
 =?utf-8?B?bk1kaFl0TFpiTEIwYXhiai9VTlcrRTAvcXR1MFZBOFlIdkRmMTlxWnA0VzBG?=
 =?utf-8?B?R2V5L0hHcHpSUzVZWUpqOE04OU0vNUNZOXJENG1ETEIvMzJmNDdrd0Nia3NC?=
 =?utf-8?B?SUIwajNSQlJkVUNGMmtMM2VQeTgrbUV1dXdMcTdramZIWWppOU9Sb2FyVUtF?=
 =?utf-8?B?Tk1CUFl5WEUyTitnTGVxL0xXR1MwWisyOXpYdWFET1ZoV0Q5WlFkbWxkZ28r?=
 =?utf-8?B?bHpLamptR245Rk5YWnNwZkRjU0ZSUGhSUEJuVTQzWGduTXA0UEd0V2taM0RU?=
 =?utf-8?B?RlplM2llUHdDbDZqL3FBS3F6MjJqM0lKNXhMVGdNZGpyOWQwT0JjTDBpZUJF?=
 =?utf-8?B?c0FKRzhkVG9OZkJhdEVwcHhFQVp3MTBySWgxMjhNTTdUNWZsUHM2RUZ5UHlK?=
 =?utf-8?B?c3R3L3AwbFprQTkyNkdtc3p0VDMrRWw4dGJvVkVPUnNITTZRQmI1TURUcWdv?=
 =?utf-8?B?aUhGaWJpdFYxNktESTNuWjA2emwrZmovSXVoNzNBVjFhSzlNK3NFSENlOHlT?=
 =?utf-8?B?aGlwMElOUDE2TTN5UGdwcXllYVlDRklPLzY4SUsxRlVYM3RGNGxOWXJ1Nzdr?=
 =?utf-8?B?aHRGaE9uYkVYR3JRWlFKQjUxSHBYR3B2WTdQaWcxbEdta2Z6QmRiZUF4ZENh?=
 =?utf-8?B?bmZpMjVqNzZ2MGN6eEtOejhDYUkyZG1IVXlCeDBlZDY4c0hqSWVaOU9xWUtQ?=
 =?utf-8?B?RTFFWnYvZ09ERCtyYmhVMnZTQktWbHg5aDlVTlQ4d0pzbDZDVjlhN2tDQU1M?=
 =?utf-8?B?UWFZMkZ5YUlQS3pMcW4yL1ZDaXk0MllYTlRQTGQycWdUb2RhdWQxb3NTUjV2?=
 =?utf-8?B?REVSdlhIUi9WR2xjdE9JQjkwT2IrV1pNOUNxaEY2SWNVSkNmc3JlaVdDdm5B?=
 =?utf-8?B?Ukw0VzcrVzduSytsTGtvbUdGdXUvTFZiVmY0blc1SEc2RWFkZGxDeVRaYUtX?=
 =?utf-8?B?ektyaTk5YzkxQjdXNFhwOVpaSTlXQWtXZ0xOUHNLYnV3TjJwWHhaczJjNHFD?=
 =?utf-8?B?aGYxVkcvTmlhZDViUEU3Y2p0U25oYXZYWDdtREZYRmk3SGFBZld5SFJ2SU9s?=
 =?utf-8?B?aVZxTEo5QTM5VkdyVDhGdGtnYlRZUDlUYWE4K2x2STJqQXMzVE82MWVnN0Yx?=
 =?utf-8?B?TFZvOE9JOG1CNXFJZWk3SkRYbzQ4Z1ovM0FBbnIzRzNVWHNGNWt1SXJBMFRG?=
 =?utf-8?B?YkRYMVQ5UU1OckNVSmNlc2F3WXFzMXdZWVJQY1dnRFovYU45VzQyUFFSWEpr?=
 =?utf-8?B?U0RkczVPb0dQVlI1Y2VTdGVHWWE3bTlZSVFOellnb2pJOFcvL2RvWmVPYVVU?=
 =?utf-8?B?aExJVklxS25Jd2dNbWNFNGQ4K2tEZGx5WlowNFdRZ1UrSG9CRkZ2dEhPRXRr?=
 =?utf-8?B?YTM2d281cENWQjRtMzVybHl4YmVWZWo0QWZIaFNkODY4bEU4L3hVdXJQWFQv?=
 =?utf-8?B?ZmMwS1pkWXRIS3dvdHFlUjEyWWxITkF2b1ExT1VSelNWeWlRaE83MTVVZ0Yx?=
 =?utf-8?B?aVR1bmN4VXZqUnRhbm1vOVlUK2pjNzZvU2ZMS1pOMUJxRE5GYkdVbmtWYUlY?=
 =?utf-8?B?MS9FM0VhWEJBWGZzYkVtTWh6a1kxWStJZ2RCMWM2emRtc1NiNlMwa0dMYXJz?=
 =?utf-8?B?RkJwZy84WTNFQTEwMzZiVXU0WTdhVFFLQkxWR200Unp4czA2N2hXcEUzMTFW?=
 =?utf-8?B?MjN0ekVrZVFTVnEwSHc5Q1BVUDlDUkdGREkwbGJjdDhLMjF3ai9leksweXJx?=
 =?utf-8?B?UGp1RXM4T0luK0EreG9KV3kycUUwRFVsWUdyZmNtSDB1ZXFSUTczWlFsZGk4?=
 =?utf-8?B?cHBOYkpvRWtmZlhiM241b0Ird2FMQmJMSTBWOWR6b2VCY2xLUTNQcE9DdGdG?=
 =?utf-8?B?aHUwams0RFF5RTZjaXFSMFN4YTFhcXhNclUzWlJjb29RSjhnOWxOcGluempP?=
 =?utf-8?Q?+iwhOFahMcMcSPu6pdgfB5xlf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a9dc6e-00c8-4e73-40a4-08de153568ec
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:47:07.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76vms6Z0LdEY7Jx3dwC6cYcBYAN95mtr7wLrPZ4SXBF4g+uLgNztS4n1IjlWKuaJHqtkRTEG8jnqIcZvtT4ssQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8739

Fix off-by-one issue in LINEWIDTH, LINECOUNT, FRAMEWIDTH and FRAMEHEIGHT
macro definitions.  The first two macros are used to set a fetchunit's
source buffer dimension and the other two are used to set a fetchunit's
frame dimension.  It appears that display controller itself works ok
without this fix, however, it enters panic mode when prefetch engine(DPRC
and PRGs) attaches to it without this fix.

Fixes: 0e177d5ce01c ("drm/imx: Add i.MX8qxp Display Controller pixel engine")
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v4:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v2:
- Collect Alexander's and Frank's R-b tags.
---
 drivers/gpu/drm/imx/dc/dc-fu.c | 4 ++--
 drivers/gpu/drm/imx/dc/dc-fu.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-fu.c
index 1d8f74babef8a7139d9d4d42726426dfe437d966..2e197b3344bd12491c1f7bab0e5304190ed84356 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.c
+++ b/drivers/gpu/drm/imx/dc/dc-fu.c
@@ -31,8 +31,8 @@
 #define STRIDE(x)			FIELD_PREP(STRIDE_MASK, (x) - 1)
 
 /* SOURCEBUFFERDIMENSION */
-#define LINECOUNT(x)			FIELD_PREP(GENMASK(29, 16), (x))
-#define LINEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x))
+#define LINECOUNT(x)			FIELD_PREP(GENMASK(29, 16), (x) - 1)
+#define LINEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x) - 1)
 
 /* LAYEROFFSET */
 #define LAYERYOFFSET(x)			FIELD_PREP(GENMASK(30, 16), (x))
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.h b/drivers/gpu/drm/imx/dc/dc-fu.h
index f678de3ca8c0ae8d883ae47ce6bebc33cd00815d..cc93317e300134a0f8c378a155fb7c67dc6689d5 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.h
+++ b/drivers/gpu/drm/imx/dc/dc-fu.h
@@ -38,8 +38,8 @@
 #define YUVCONVERSIONMODE(x)		FIELD_PREP(YUVCONVERSIONMODE_MASK, (x))
 
 /* FRAMEDIMENSIONS */
-#define FRAMEHEIGHT(x)			FIELD_PREP(GENMASK(29, 16), (x))
-#define FRAMEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x))
+#define FRAMEHEIGHT(x)			FIELD_PREP(GENMASK(29, 16), (x) - 1)
+#define FRAMEWIDTH(x)			FIELD_PREP(GENMASK(13, 0), (x) - 1)
 
 /* CONTROL */
 #define INPUTSELECT_MASK		GENMASK(4, 3)

-- 
2.34.1


