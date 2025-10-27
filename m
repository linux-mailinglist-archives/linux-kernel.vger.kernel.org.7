Return-Path: <linux-kernel+bounces-871136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 688B7C0C7B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335EE188830B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7404E31960C;
	Mon, 27 Oct 2025 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FNxuDw0m"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013047.outbound.protection.outlook.com [40.107.162.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0AA3191AA;
	Mon, 27 Oct 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554863; cv=fail; b=o9/k4oDqi9DjLNMI1nnFYpvV6A2bmA/JLf5pI2p7SgONhwtwAXkori7e0cduSbjGNrY/PX4/xA3ANk/26N5Ev2853KEBHC5RZMTXuNnwX3QK39eJYsGYjOMGxo+1rUmQJknRzxqLnwpjvu66+8V+hAHNrvi/FTDZPXgJS5dq0zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554863; c=relaxed/simple;
	bh=DGbuQpzfZDKY7kyqnFqCoq+o4oR7TvO4UdPM1UddodA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Etgm6cSAvPX/yTgK8e4K3oWDt7n2dePuqFOHwfxDW61stGJqBZHAkY3JC+f03Y9Kzx0jwfuBTFg5juNMA4y9nE1HuOVOty8zU4B2WR50yqQmwLKeUsUKwDlONw+ytChgOsKKjVRmQAGQdOH5prNrVPLYWVRN3X8ijLs0ODbuqeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FNxuDw0m; arc=fail smtp.client-ip=40.107.162.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEZsXQ5GRCBdaHTG2CxM5o2cNyf5TIcQ0XiRSQdxSoJ0FUCKmV1YkAB/iIn8ORZoB6tRhLpvMO8dRxFszbZ0hRv+zZzvanyi+0tYmWF/06Zb77DYmqPEQ/yIPbkFJVKutzMO6P9bV4z79s3q1Amw9ulmpdLTbRz/ApzNblTSa54UNGXQNSrKM1Ml9kemziCqIYix7GPW2ktsuJPZC+VTyCSBYTI71lkgWdDkqiVfDGaSBzAsQX889ulMMcmIVBlbzOpXExeWJZssLhQOt3D+FPrZDdcDLPJZgrsXRR8oTnoEiufe4usfaZqPrnR0qm4VmPuFWs+oaUD6J5SB+V1SKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTh5wZ55LwLRQ81qq6Rx8uK5Tqd9vh50RBjRgRVy0R8=;
 b=LFp0yWB0Is4dMCm0+opLkTenixuSPs4eIdPRgjfICKA6HUIyD5Fk8mN9CNVCWYcnpW8sdEIerRf4HGR8c71jQcprxw+eWzaY9DROcc+562yu+zQYkWS/Yn6sNusgFcRjKAdGesRUOc90yR7/qmWYZOOoFZW+BUjOXXtS7PTg++Zs/f4lS+UvqWqb/HOSSbGfHsxPtFD0pYB4G0tWoI7kxm3/rRwAkiIcIgvzn9K83V9J7LksY8lXjA5j/MxjgReZOog1N9jj/x7ZkDSQAi2fhAPbpBhPG2MOMbpIFGBAGQzgYxkDqOdV6zSyIWxum8MPFATnjJKnQgavqTMyW2/7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTh5wZ55LwLRQ81qq6Rx8uK5Tqd9vh50RBjRgRVy0R8=;
 b=FNxuDw0m+/wMLMHTKzaPHQ0WGbSbpdH1KUshojill5H5biScz2iNlprl5COG9qK+7UpWrfRAnlhiky2lCThz+R4tjHSWkay8MGt95oKLPjq0f3CanpKPNzLB5fbRw9xSYz/zOFIKMz10Jn0zSG9caaeS6ov/rT2/VgqXGlWayFS0MMU6Da6wWcF/hPeuPPz7cs+46H6byLaoj21IHbnuh53jS5KW9rqIMD/GBZUdoO8ugQByj7pAkFuLtS7B6RftI7uT3kEG89iXvzyhdxfTuv4d7d3eqeDJSO5jvdv1ngwxBlEkrBdSwNpeMrg8aSLMmVKTCzR9WDjzuW/SWOjT+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8739.eurprd04.prod.outlook.com (2603:10a6:20b:42c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 08:47:38 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 08:47:38 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 27 Oct 2025 16:46:58 +0800
Subject: [PATCH v5 08/13] drm/imx: dc-ed: Support getting source selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-imx8-dc-prefetch-v5-8-4ecb6c6d4941@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5f7bc20c-107b-487a-16b9-08de15357b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk42UGRHK0FQaG5KZ1JJdFVsK0VxTFI1c1RKaDFqTWZ1M1MzUFo2TTdqV3Ew?=
 =?utf-8?B?RmZJN1V1a2xzb2QzTDFTWEJsVGVtUVZycVVsdXlVTTVUeS9ZLzlLNmMvcDI0?=
 =?utf-8?B?eDdmSTJOZ1plcm1lbkV1TTE3cVlwVFJRVXlBeXBoYjhsZFQrRVFINjRNZzJJ?=
 =?utf-8?B?M1pxaUh2MFVTN2owMTljZzRpSE9nMENWRjcwZWZQSGVUZTB2bkFPZFQ0aW1B?=
 =?utf-8?B?SU4wMVZKWWZrUTg2cDBDbzZlZ0ZJRVRLVHU5UC8ycWhsSnUwaWd3MjlZbHMw?=
 =?utf-8?B?TWFaWUw3QkFrdnFzZkpOZktKdUUxalBHVk00b0JMblZLRXlxNFBVNFZ6MU1x?=
 =?utf-8?B?MSs3cGs2cUc5RnFpSEl3TExVbVdRRTJZVi8wVFRieXRhRUlEOTNEVmwvWjc3?=
 =?utf-8?B?OUphdVg4MjJLMVVaWmlyMTdEbGQ0Q0RUbXhOMDR3cXU5aklyUXhwRWg5YVUv?=
 =?utf-8?B?cXhRWTNqbTZCK044ekZMRnVISkRwUGd5U1EyWUhRd090ZGY5Y0UydEw4cTFZ?=
 =?utf-8?B?dTJiQlY1a3REa1RKc0pmNUZpMWloNk4wOWt3L0dGS1FNNXl2UHdlamF4OXFx?=
 =?utf-8?B?UnNJVU9kN2xrbGt1SEZuelVKLzkyWTF6ZHgzWTZUN0RSWTZjSUNRRFFQbWYw?=
 =?utf-8?B?YU9Tby8wSHZLcDJGWWtzYWMwMWRVOS93eU43cEVmOFl4VkhLUkduM2xrSFJK?=
 =?utf-8?B?ay85R0J4ZUd2N2RpaTJvT2dCcWZrS3pnQURBakFxK2oxUEYwa096bnRDN21T?=
 =?utf-8?B?YS9LZG9hNmVWWC9DVTBqMXI2SVRKaEY4ZFAvRHVMZjB2NCtjT2VvMTJvVWlt?=
 =?utf-8?B?MS9rUTdJKzd2QzYyMnFQd3pRd1hENERxRjUrNmxGbm5wV3JOK0J2dkNGUVds?=
 =?utf-8?B?anExRHFsKzhLSXpEWTR0Yk15OGh4WFN4MzljRHRSTmFwNWw4QmZyOG5Qei8y?=
 =?utf-8?B?MUdGeHhTOFJSU29IbnE2VWVwZ25TY1VXTlhERDFicjJWYWRsSUVBa29VUTRX?=
 =?utf-8?B?NTZiaG44VmQrS1lIV3pBNS9xWTJQTGhGNE5BZnBYd2E1bjQ4UndkZm5vMTI1?=
 =?utf-8?B?SkcvbVgvYnJFS3BEazA1NEZidStvTExaV2JwODZWRDB6RTF1d0RvR0dpQnF5?=
 =?utf-8?B?YmR4ZmJNbjFNTURJUHFHWEdsT29ybUsrbjRwL05tTE5rekRRMGZnMUVKN3lX?=
 =?utf-8?B?VlM4V3Nqa0psMkJ4Smora1V4R0JWeUZOa2pFOXJLNVpFMzhlSEZCMnZJa1Vs?=
 =?utf-8?B?SmsrYnhrTmhVZUVtSEVaWm05MTluTThiTVJDbWlYMFBDN1pHN09UZ2RjaDJC?=
 =?utf-8?B?MW9NQVA0eHRIR3VxRmgwUlNSVTBheXJSU2dhSzM0VWNqUEtBYUcwL3JzSEtG?=
 =?utf-8?B?ZDlmd2RmUGlWME5OUGhZRzNHWTYvSFd2S2xVTTJrL0c2WTg4UllRWkxoOVpk?=
 =?utf-8?B?L0xwTWp0Nk9aMzJ0c2ZGMFdoWXR3RER0REtPVmc0Y084YVFnSFQrVWx2N3BP?=
 =?utf-8?B?Z3ZqRVkvK2l1L3NQV1VMaEkwOEJRRkUxeEowcU1tZDJYZ3VveEJrSHhXNGwv?=
 =?utf-8?B?TGRhbUlFcGdZWEsvZ0hSRFQvb3lwOUR3U0NVNVZHMFdSaklVaWF1cEx2Q0xC?=
 =?utf-8?B?d01CbHRidi82M25YOXFlR0hSY2Zkalk2RU9lR2R6VGlCUXNZQzRDcW85d2RJ?=
 =?utf-8?B?bkhMVzZuc1pUcGh1eGJuQ2JvSk1TK3d3NXRXSlhYWU4xOXR1ZDhLUTBPMUlY?=
 =?utf-8?B?SnJqaGNFWElVZkErUHpUMUxOek4wRWt6VG5xWlMzUmdhUWg5QWkybjk1d3pn?=
 =?utf-8?B?NG5BN0dvenFGT3ExeDl5TjhkM1ljSWhXWWpsSGNiYlYrQ1BUdHovWkp3akxS?=
 =?utf-8?B?bmw4blpZWURPUC9LUWQxVzl5WEJFZzZ5R1ZncHBId0UwWUR4ZVl2QVRzcU0z?=
 =?utf-8?B?MENCdHRGb2d0TENZYzcyeWhLQWVYT0F1ZzdMVWRYY0x0WmJJdmxmckZCdWFt?=
 =?utf-8?B?bkNndE9Zb1BITC8vajRyenZlbjZDYWdoeVlMTDMwRjZodVBPNFpTYmN2bWEr?=
 =?utf-8?B?ZE4yL09wTjM2dTNSbDdIQmRJMVpqV1FjcVI1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWd5QTFBQTlEY1NsUHRYdENjMnhEWWVDSkdlbHEvVDJoczlMYk90WkFJV3ZC?=
 =?utf-8?B?dC91U0pNWjBTL1Jxa2cyVmdjVGdXVlFJMnp2OU5vNEkvN2xjc1pzcFczMGZi?=
 =?utf-8?B?aE5JUVBMMEZ4cEI1a0ZkZzd5Vmp5ckJkazFrWnowbVRScVJKR0NsZEZBbEVp?=
 =?utf-8?B?UmJaUjY1Vlo0aXZXek5ybFdsdG1PaDltUUNrZFY4MW1Hdi9qQUErdDlTOXZY?=
 =?utf-8?B?RGF3YktyQWg4eGZRVlZVekx3S0MwUnV6ZnBqRmxSVTBLemtxZDB4NnhRVU5q?=
 =?utf-8?B?RWgySVJJY214NWdSdFgvVGRPaTh1S2h6Mmt5RHVtbTZiUUJvakhtcXhXUDNR?=
 =?utf-8?B?Tkp6L200SnM0d2l1UFVHa2wyT2QrQVpVZW5iT1dBWW9oaHpUQnNIK0J5TFg4?=
 =?utf-8?B?SldFaDlpMmhiK3Z6b3FhWVpBb2xGT0ovbTJQeElCYUdydTZxZlowQ3ZRQWM3?=
 =?utf-8?B?WDY4TkVxcmt4WWlUalNJSUVBZFZVRFRaaFN3Szh0V2VmV1M1Q1h5YnRtcmZV?=
 =?utf-8?B?VkxzOC8rc3hnTTdzeHkxNGxqOU5wdzZXTDVaUm11QmtuVTlNTmQwVm9OOEk2?=
 =?utf-8?B?a2tKMy95OEViMkExRFZic0F5Z3V3SzdDUHVNYXNicU9tZi9Ob25KWk1ub24r?=
 =?utf-8?B?V0xoazhoQldONUp2b2owWGo5WjhBSDByS254cTdpWG9iYVY3dkwyYU4vbU5D?=
 =?utf-8?B?cFJ2b3k2OStzU01hQ1A3U3c1cnJub1A0YWdkWjR4UVZ2enM0OXNrVmU4ZWw4?=
 =?utf-8?B?ZGVRdkJ3RGFDTFg5R3pDbGxvOE5FMjUzakxvYzZuNVJzQnF5ekJmNDFvb1o1?=
 =?utf-8?B?TjA5VFhXTVphV0haU0IzSk5BQmdITzJQTmZYcFdLRVRpR1hVNFRNN2NmSkhV?=
 =?utf-8?B?dnZabEwvbGExSHhwODk0ck5nSlpwb3lwcEczVmhEV09BQzl6SGhEZzN2TjNQ?=
 =?utf-8?B?S1pUR3NlaGhFZGJ2UmU5bTNINE5wNmxyQmhpMmRaeE5IdU1XNmF0Q2prQ25J?=
 =?utf-8?B?aTlWM1JYLzdYZU1PR1FlbXQwN1FtQzlXS3ZXSEJ2UWhGT09hS1pIcGhYTGZn?=
 =?utf-8?B?M1RNY2xyRUZCQjNVRUNKNFBSblFVVkxSUzN6WVpEVUtBRGhMd2ZVelM5UzlS?=
 =?utf-8?B?NFRlRVV5ZkpHeUZOdEpNUHlrekFLV0lHZXA1cVZHL1VZZHB3Ny9Fb2dLQUk4?=
 =?utf-8?B?U09FNVpvM2FKaWdZU0MxRWYyckpmR2ZiNGNlUFhlalJld1VOc1NoNmxoQWNi?=
 =?utf-8?B?QURnWlltVGs2WjNnaDJzUW5Ib29ObVgxTjNTcTlWeVRFUmlwSG1WNTFBNzJ3?=
 =?utf-8?B?VktudGVZQm5qRlFiSmlwdDVxN2JUWWRUcFJiK3BtSTZPR0d5b3NFc2ZXampN?=
 =?utf-8?B?T1Q4WEh3cEY4VGp0NXB1a24zZUFMcFc4U1BCbFNKQi82MjdMVWpjTy9Da0F4?=
 =?utf-8?B?MlBqRU5iUnNHaWJBeEJ6eWVGTUwxTE1JWHo3L2JvZmpGdGxKTTkrcGZ0ejRo?=
 =?utf-8?B?d1V6bHQ2eTU4Z0NnNlNhbVoxNDhTeG84SXBRRTdjWUpEa240eWVnNVpiUUM4?=
 =?utf-8?B?TlNaV3JQbkNYb1hvdEZ1K08zOE1wakVhOHVydzZ6QXhsWE1GWDRkblJtMHNE?=
 =?utf-8?B?WjBoUzBSeStGb1NNaUpvMWprQ3pBZ3RCa3ZwNm00Slc3YjNIWjVLRmRhSTlh?=
 =?utf-8?B?VTZEVGdqNzRqK0YvZXBoZXRBbDhGNnVWNVpRdXdqZ29jb3djRjI1cFBqMjZX?=
 =?utf-8?B?UFJ5VHI0eFhrbG56a2I4MWoxNktFK2E3ZWNhOEhIQ1g5cXVwV01tWnY4NmRY?=
 =?utf-8?B?dXBHenA0VUFFeXFvL2I5THppNlFZUDhTQmJBL002ak9weklHMXJFaThtRGlX?=
 =?utf-8?B?OXhkamhVTTYzUVBLMnF3ZUtlRTgxR2wrRmVENG1iMDB0VXRaQXNPSVV4WG81?=
 =?utf-8?B?a2ZQREVyWlU0cXcxcUh0YUtzVTRvdnZPSTVXekdSL2JjdGM3dzZJSTNtQVZo?=
 =?utf-8?B?L2FQZlZwdWhqdVdCZmwxb0U4RytLd0s5ZEw1VjJocSt2K3I5QVFscWpEOG1m?=
 =?utf-8?B?aXUxTldvVEUzUlRDdHo2Z3htTTloZnpwa0hESk5HUVp2enpSc3RDdktySEc0?=
 =?utf-8?Q?6BwLPnp8CaEQh7YxstFKYEc20?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7bc20c-107b-487a-16b9-08de15357b82
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:47:38.4301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+bLv8QV30dGsYDdlIFngVXBAqkINIJRBcPXgpP9cqX8rk6ES/3h4wGSAi0PZrmtGP+CQ1AOX88kKWDj5/DGLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8739

Add a helper to get ExtDst source selection.  This is needed by
disabling CRTC at boot in an upcoming commit which tries to get
the source selection.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-ed.c | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-pe.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-ed.c
index d42f33d6f3fcc3758ddd103be5251cf6ea9b7e68..c8cd15f9e32de4d86c2acb8764146af1c3663c1d 100644
--- a/drivers/gpu/drm/imx/dc/dc-ed.c
+++ b/drivers/gpu/drm/imx/dc/dc-ed.c
@@ -150,6 +150,32 @@ void dc_ed_pec_src_sel(struct dc_ed *ed, enum dc_link_id src)
 	}
 }
 
+int dc_ed_pec_src_sel_get(struct dc_ed *ed, enum dc_link_id *src)
+{
+	u32 val;
+
+	regmap_read(ed->reg_pec, PIXENGCFG_DYNAMIC, &val);
+
+	switch (val) {
+	case LINK_ID_NONE:
+	case LINK_ID_CONSTFRAME0:
+	case LINK_ID_CONSTFRAME4:
+	case LINK_ID_CONSTFRAME1:
+	case LINK_ID_CONSTFRAME5:
+	case LINK_ID_FETCHWARP2:
+	case LINK_ID_FETCHLAYER0:
+	case LINK_ID_LAYERBLEND0:
+	case LINK_ID_LAYERBLEND1:
+	case LINK_ID_LAYERBLEND2:
+	case LINK_ID_LAYERBLEND3:
+		*src = val;
+		dev_dbg(ed->dev, "get source selection: 0x%02x\n", val);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 void dc_ed_pec_sync_trigger(struct dc_ed *ed)
 {
 	regmap_write(ed->reg_pec, PIXENGCFG_TRIGGER, SYNC_TRIGGER);
diff --git a/drivers/gpu/drm/imx/dc/dc-pe.h b/drivers/gpu/drm/imx/dc/dc-pe.h
index f5e01a6eb9e918516adfc89949665fdd2ff1e40e..0b81dc6b251c452e7ca72f1cd12af065bafaa198 100644
--- a/drivers/gpu/drm/imx/dc/dc-pe.h
+++ b/drivers/gpu/drm/imx/dc/dc-pe.h
@@ -85,6 +85,7 @@ void dc_cf_init(struct dc_cf *cf);
 
 /* External Destination Unit */
 void dc_ed_pec_src_sel(struct dc_ed *ed, enum dc_link_id src);
+int dc_ed_pec_src_sel_get(struct dc_ed *ed, enum dc_link_id *src);
 void dc_ed_pec_sync_trigger(struct dc_ed *ed);
 void dc_ed_init(struct dc_ed *ed);
 

-- 
2.34.1


