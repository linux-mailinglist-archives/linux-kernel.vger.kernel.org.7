Return-Path: <linux-kernel+bounces-835698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1044FBA7D65
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 04:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD33A17FD9A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 02:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A66230BF8;
	Mon, 29 Sep 2025 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jBYTnCDz"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013026.outbound.protection.outlook.com [40.107.159.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1708321770B;
	Mon, 29 Sep 2025 02:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759113696; cv=fail; b=H+9MujLyfkTt2XNmmUI7/YRmmrLRUvR0g09OZKIvhI0ptyfijd/nTK7rwBa35U8S2EMKvbVdw4Tf9cX9U5nKmewSTLG3uoNj8eEm0FCpGPJJByUzFl9fd45K4Mz0dllXWbqaiUCwzS7NUiPFdiSvtAxa7M4/sMo1mQybb+uvHYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759113696; c=relaxed/simple;
	bh=ZbfESai+gNxJI9TVigFxKQhHPVEQ8zoX0LDlRqJ40a0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iBSbJUeB8j6rkvDz+yAKd+p334xLn1yzgYa0qqv5uuRU9hvEJ5JNl4Kj7gKgez3MnYZi5PAw1dQlXi//2OyRip6B7VwjDVsm39Agh+qvFvAKbdd3C6RvoA0VSUfJpAU39fYoDa/P2XDsidi5NmSsx0LRuCx5wOoWolTiYj5pgZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jBYTnCDz; arc=fail smtp.client-ip=40.107.159.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeSke09MlwRpmWl1d03vZDvnB8dB+UGJNZmJxBzJLcbrfv7wE+NpOdJmktwnvUZcvepgBWJKZgQ5zeZytsufcWP/YJn/tsLw/6+Ud7UUq4q9XzkicyYPSQT84IIt5AYrszSwlmDHFxwsbHfKrwKDTPNo5xnLwJ2K47HFiJnBYZ+j8iQzWiVkOb82VKhkdCzmZF+JYSq3OwFvjdpX8DNUo23MMXSWULzpff7hRxIjMYwIQ+PTs2057wq48/04/YAhcp9jmBFzRSEFKGFV9X/vg+UOPk0Vn6v9dRml0FJ2W54PvBbm6XU6/nKXi0TFdo2XRFskQjGjVFt/twguOl2FRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylTcisnamqVDiXOTck8+M/9vQSIsvrcc+9hAhb+ikk8=;
 b=y5HIjJAOW8xpXuU7c4beyzb9fIXxcETBlvAcd9yeLOhPThjklrPrk02k0VA31Fc99BXIH+2M7zw+0DiWbBPZWx5wHTjeLCesO0RhjtGtwn/OJkEqDyqxaIOJbiMz/qCzQm5hgSw+OCTeA9c5wMbS2GHLR7XZLwJ8e7fphWD36ryBFWBgJIm8TRrGhs3BjpbaMefCKWRYbRNZhhQ4ovYWvj09Ofo1m7WG5xFIg/hXCH7EW+9dXpNwSVXq2aVJ5qeVpVU6OkPveDeezIrroCh0HqYto1qMah1F51BVapgCJRKiG4YjLVhQaDsNfzzo7k9LMWExrOJC44KDHP/hb00l8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylTcisnamqVDiXOTck8+M/9vQSIsvrcc+9hAhb+ikk8=;
 b=jBYTnCDzdZlDszz/KE0D8ElNyJ9OfJwpUPUtuV3dOoRgEvHAma0SDVvr1WORzhSYvG2+i8CW8xmex0Ol8TzNmSgO9mNSoaD12LCvlgEEj6UaRLFzEYd210wAHeoUJh58mbUrAbHIoLa15EzN31iDqr7F02qmNqdZtjBnGYYBFQIyvSzsaKskhY7bVPjfaWKU49TAoHvHpq2b0M8j5CgDZ/xmrKGb1gWKj+KKx6I/J2MbkWHzCzsNMijCqb8a2s633mmKnMiIsWc0tH6tbNOj8H7KdBNO7WJOjcJ1lYxjL2yMUG771laMCZK6Zq4yJHDWWyAHt8kLOkedDiHfMm95Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI0PR04MB11722.eurprd04.prod.outlook.com (2603:10a6:800:2ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Mon, 29 Sep
 2025 02:41:32 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%6]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 02:41:32 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 29 Sep 2025 10:41:46 +0800
Subject: [PATCH v3 11/14] drm/imx: dc-ed: Drop initial source selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-imx8-dc-prefetch-v3-11-c01d0608add2@nxp.com>
References: <20250929-imx8-dc-prefetch-v3-0-c01d0608add2@nxp.com>
In-Reply-To: <20250929-imx8-dc-prefetch-v3-0-c01d0608add2@nxp.com>
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
 linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VI0PR04MB11722:EE_
X-MS-Office365-Filtering-Correlation-Id: 623702ea-a65a-4aea-b0df-08ddff01b301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTVjM3VrNnpIRzV6T2ZjY3dMWmZYSlBDbXFWZi9BWVFMTi9OcEgvdmNHZXJU?=
 =?utf-8?B?SFYxTVNSaStKU010VXVCNENWS3p3NGhubzlHVXdhT3o3L01selJqNVFXV3Fj?=
 =?utf-8?B?azVZYStBUlc5ZEpGa2tJVjQ3RkFac3ZhOFBFM0tQdHVEckR3ZzQzRUJHR2xU?=
 =?utf-8?B?N05TOGJ3MGVpcnV0U0s3UmozRnFNbW9zM3pHWGpCMGJ6RVV3bmJJM3ZLU0F6?=
 =?utf-8?B?RC94YmdTdlBTT2VCb0wvV3MyeEllcm5GTkF1RHNaV1lkOFY1eGd2R0xHUVR0?=
 =?utf-8?B?cHFHYmlPOEVSSTFmZ29OZUx4MzRjcHc5bTROSi9Nclc5Y0N4K1ZBbFg0SWE4?=
 =?utf-8?B?M212cjJmWFlEVlU0blFWWGNacUhxbGJKMXRXMFhXN0FsSWd0cnJVaW5rdkZK?=
 =?utf-8?B?RzFuTmZsTVdEZGJHYXl1RFN1NEkyWlpVRkJ1RDlJbHcwQVlDaEdHeHFqUU5X?=
 =?utf-8?B?ZjV4anBuenRQUTMwVzJEdjU5bnY0aVVlZkh4ekxEVGlTY0kwMlRNWElsMTFM?=
 =?utf-8?B?MHFsYTB4RjllSjVOS2pPRGM5dFJvU2Z4WUZCUkpUbjNUSlQrTUdXRjlFNUJF?=
 =?utf-8?B?Vm81WUU4M0dKeDZ3UFNPSlhpM1FSUEhIb3N6cDN5ajZZRmxMNVNUd3JQU3Va?=
 =?utf-8?B?eHhqSnBXWVlWUDRUeFdiU3MwQVRoL1Q5aG5oRHA4NmpIYnB5aW0xb1JJZUNj?=
 =?utf-8?B?TWZSZzRnTjlXY3Noa2Z1d3pZbTRiMVNNRFlHRUs1c1hGQ1JRWFp6WEx6aUl4?=
 =?utf-8?B?L0Fmd1I5SW1rb1lDR3BvYmczdjNXVmlNODYvbXZHU3NDekZseEx5c2M3VDVB?=
 =?utf-8?B?SE91UEtEMmcrNUNPSVFwTjVQK3NuNjRoOEN1Q3IySmJ4RmlwWnpXNGoyVTBX?=
 =?utf-8?B?RjFEM2NNSEtQQUZKNDlHMDdmTXZiVlM0K2EyVGJVYnRWdmFBQ0JibEhMWWVC?=
 =?utf-8?B?M3ZxZWdaeEs0T3lOYXVYV3gxUSs0U2ozeTFPRTUzVWwxR1ZaNlVqNmwyV1hy?=
 =?utf-8?B?VDFqMkFGWTB1aTZwcXNGSzR3T0xPTjZFT0RHQS95QUg5dm1weTBCdXVwMGVP?=
 =?utf-8?B?QkIxNXZ2VVBFTndMS0F6U1ZrSXZKVTZ2R1J1Y09PQ0JWdVR1TktvTm1UdzdN?=
 =?utf-8?B?VlNERnFDMlNMUkJVUUdiREpYYm5rblNUVjdJdE9aM1NhdHVSU0MxdTY3ZEJ6?=
 =?utf-8?B?bWwvV0Framd5M3p3eDR2NjlKSjhWSWllSG5xQzZvSnNnN09ZQXFMY3N5RWw2?=
 =?utf-8?B?K2pPZnNBUUg1eUJ3dXJORHFPWVZmc3czb3dCakFPbElGSjRSZzBDOWdjYnFN?=
 =?utf-8?B?Y09tSUxqaHpHYXJmM1kralRHUTBCMWErOWNaQTJJcDZRK05QTVdUVjBDa2lW?=
 =?utf-8?B?RkpBckZlUmFJSWNWUUZXcC9RSDlRWDlJYUVWV1puZk9xYi9BU3hBUkovYnhG?=
 =?utf-8?B?MFZhS25rZS93dkI1MWs3OHdOdklMZW0xMW5lL3pSVUVkMk5sc1htQjgyai9u?=
 =?utf-8?B?Nk00NzVyZzdxdkIxREdnQmRKcUpsQUNGUDNIYytSZlZRYWdHZmh6TmU0TXJu?=
 =?utf-8?B?QVhmUDF3OUNlNmhxWUx0NEFLUjFaS3pxR1BWZXFvT0lHSVRDV1MzTlVvY1B4?=
 =?utf-8?B?eHdQZUkzMGp4S2xpYWdyVkR0dGVSK1ZaanBZM01sQkc4UlhYY01UL1pDYStF?=
 =?utf-8?B?bVNYYlVheGs2LzJlcGhuU1luS1VsMlVJc2J4anJkTm1udWtsVW9jVFoxT2tv?=
 =?utf-8?B?YndFVUhRMm9Bd0dmTktadEtSRWk0emxHVFZPYXJKUlQrME9TY0JDN1ZCV2lQ?=
 =?utf-8?B?ZTZibEVCekRHQzZPZzBjcUE3WjBKSTh2czc4bUpLcU1FbjZYNHpZNEw0cVFr?=
 =?utf-8?B?TnBGcFZReHkrTUtlaDhmZmc3VVVqYWhSV00zRTJ5ckFOMDd0TmNwQXI2eTZy?=
 =?utf-8?B?YjRaT0lielJIUVF6R2hhNlM2cnBvNjNpeXJmcjcxZERRZWx6WE04MVZnZTNi?=
 =?utf-8?B?bVVLam5WSEZZemZzMzdlQWNMcjRndHdsQXZoRGc4VXlNa3NsbnNpKy9WQ3dJ?=
 =?utf-8?B?TlBiS3BrR2h4YXJEV3o2MjkyT3MvVzhjSVN1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVp2dVluTkJyamxWL3JHcUlmV1p5U2hxdFIzUnhiTkpZL0RnTy9OY1RoYjIy?=
 =?utf-8?B?RW5iOENVWUxRanNLQVh6OFNBRDBYMFhESUhZOXc3WGROdnlLaXhyTlh5Um01?=
 =?utf-8?B?eVZTOGFPRk91T3ZxbVI0d3REb29qaXV1SStjWkw5YlRQampYZnh6YXYvajZk?=
 =?utf-8?B?MytVYUovOXFnVXJXNnIzMW9qZGdPdWdDcEphcEc3TXltS2pvaTFxZWI5SVFE?=
 =?utf-8?B?dEZYTi9LM1JEUjZhRnhubWJia1F4UlM4VFVoS29JOE0rL00wYkczcG9KRXZ1?=
 =?utf-8?B?UjhuVGdqaXpaSzh2S1Y3WW9kVEpzUTV6VWRrOGVvdklBRzhDU0hUVkFVOFJm?=
 =?utf-8?B?c1FUWDM2c3EyZlZBR3B3dU9wOWs0Q3FuSGhaRW5WYjR3OGpEbWVObTJmTmp1?=
 =?utf-8?B?bzV5aTdKN1RDems4UkpjaE5ZVGx2dUJwZmVXc01FMmJuWnFoVlFONlV0dEhp?=
 =?utf-8?B?TWZEWWZOMFVTUzc1Q00wS3F2RzRRenNQYnV0VkhERHZ5QjN2MXQ3TWpIUzBM?=
 =?utf-8?B?aUprcHBobVZ6VWF4L3VvMnBYNWZOenBxb21EamRLRCtOTHM2aHlXcWVRSFk1?=
 =?utf-8?B?cHMyQVV5d2xqdzNMdTNtZlpHYjhNTDZObzc1KzhSOFZBOWdRT0duUFo4L3Ew?=
 =?utf-8?B?S2xSdlNNV1hkVVNsNzBtQXJ6N2daNUxSR0pmNHIzZkhGa003OHJuTEhGaDIy?=
 =?utf-8?B?S1ZIcUpxbHFiM3NVUGljL2lMQVdMT3lHM1ZOR1VGcVZmbFI1SHMxNWNKUDNp?=
 =?utf-8?B?MkVmNzhyMlo4bGRiT050ZGxra3ZDUGFzbUdEZnpoK3VISzNnRzhMZVA3MlJy?=
 =?utf-8?B?clZYZlY5RkhLQjlEM1Izcm1NUklwMkdhUjdXczdwTjFNZE5IQjZvai9CWndR?=
 =?utf-8?B?TTFOZjl3WjNYdVdqeUNSbEd5ZmdrckZGc081MnozRi9uVmc1WVNNUCtQL0xT?=
 =?utf-8?B?WWtrcHJWR3dpaEozb3I3b25vSU1FV1BIajZFNDBiMTgwZnFTcUNaYm5BMVlk?=
 =?utf-8?B?L3hwT0djbVFYUUxxcHNiMVVyb0ltRjJadHBQNVNSUDgvSUMzZGwxdzJOSmdU?=
 =?utf-8?B?YW5ZSWNlMURnOGtqS1dpWTh5YURwc0lMNm5iZjc1Z1BUTDBDUnN0TWpXd0tz?=
 =?utf-8?B?ckZhQzljVTIxdCtNZUxPdlM5MTFZZXZMYzdUeDgyYnpva1dNSEc5WE5INWZH?=
 =?utf-8?B?Y0NVVDNXNGlTdFU5UGlJYi9sL0c5QjZ6VjhsTFVZa2tXbUJkQWtZaHVpVFA4?=
 =?utf-8?B?MnJGdUxQM2QvR2E4WTlLck00RVN5Q0hVRlk2WWFtVjd3MGpUQ0tvc1VoSVRK?=
 =?utf-8?B?Q0d1N2I4QU8zenJRL05HTFZLb3dWK2IzVmRzSXRYOU5LbHo3YlVpWFYzOHZD?=
 =?utf-8?B?TWpiK3duZTdnTE9qVyt5SGw5R0I3U2hmekZBYmpLam04dzltWlJqaG9Yb1gx?=
 =?utf-8?B?c1NoRUZxcGRFekdHa1VudFZpNGtUd243amhXeFBSSy9NaWQ4Z0VnMVptQWNI?=
 =?utf-8?B?UUVRbVFSZVRwd0hkZTBFS2VjbjlHTlZzVHZqS2tMbkt3OG5CcUwycWYzYzUz?=
 =?utf-8?B?K3d4ekF5WVYrQ2dXb1lzR0JlY0RTamRhaGk5Y3kzMWpsUmF2TmdWM09FbE42?=
 =?utf-8?B?R3crSC9jTzU0YnFDcjB0eHdWZ1V0ZVV4WXYwM2VhQ0FkcDc4Zlhwdk1xTHdv?=
 =?utf-8?B?WFRObDl0Q2FJVSs0N3BqT2E5WDhuWVVPaU5iRWtiWXUvVDZFWCtRUDdyQWxM?=
 =?utf-8?B?bHdOaW9xdVpUMEtPTEpaT3Z1KzhuVVNMbU1GNi92VEozZnYyQkZuR0s4YjJ0?=
 =?utf-8?B?VnVlVFlpN2VQcHZwWUNnN2FPYXZRemE0K1k4N0FWd0ZhcGxlZ2d1b2MvaUFG?=
 =?utf-8?B?c0VQd2VoM09oSXFDeTBUbjJJTFRRSi9tc1FBMXhlZXNOdFZ3bnlLc2g0MDZL?=
 =?utf-8?B?N0NjSmRvUTNIRnQrL0tPSGY4R1JtUGRuM2JHeWo5L0lUM2Q4YmJjY0IwVHM4?=
 =?utf-8?B?SjJGNlVxTnlaeGo0dG5FNGY0NVFRVjNSOEpzSkx3ZEdlbUk4elZzSHE0V1h5?=
 =?utf-8?B?eVVOUEVLTnV2QXQwT3hya1RGNVVWc0djd0lrbmJpZ0ZRZE1EUk5FaVQvUDNq?=
 =?utf-8?Q?Wq/LsuK6JoVHwrQFNMvuywG7u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623702ea-a65a-4aea-b0df-08ddff01b301
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 02:41:32.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: audFXB7lPwF77KmGTth37vgs2CmwXzrjCgaO3CVMt3qG9qpevSqx+xY5tuiVxCqzNGj0SCrs81vG8H1pdOGwLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11722

It's unnecessary to set initial ExtDst source selection because KMS
driver would do that when doing atomic commits.  Drop the selection.
This is needed as a preparation for reading ExtDst source selection
when trying to disable CRTC at boot in an upcoming commit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-ed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-ed.c
index b514790bb765329295553f89d16ee1167ef411dd..1b141ced57b895c24b6358332cbe5e308dad7c01 100644
--- a/drivers/gpu/drm/imx/dc/dc-ed.c
+++ b/drivers/gpu/drm/imx/dc/dc-ed.c
@@ -203,7 +203,6 @@ static inline void dc_ed_disable_gamma_apply(struct dc_ed *ed)
 
 void dc_ed_init(struct dc_ed *ed)
 {
-	dc_ed_pec_src_sel(ed, LINK_ID_NONE);
 	dc_ed_pec_enable_shden(ed);
 	dc_ed_pec_poweron(ed);
 	dc_ed_pec_sync_mode_single(ed);

-- 
2.34.1


