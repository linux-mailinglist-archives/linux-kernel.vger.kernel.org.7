Return-Path: <linux-kernel+bounces-855600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A8EBE1BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F74F439A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1802DE700;
	Thu, 16 Oct 2025 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G3JNGKki"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ECF2DECB2;
	Thu, 16 Oct 2025 06:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596368; cv=fail; b=WTXMvyhAhiWb5LC/BsPIkTkFK4J0Xr+t2ysGjVm0RBQwv487M3haFWZRYCZKQCzQe8Jw3y5F6QJa4Vth5tCZiGv1cLDFYtA74sqGcoDVqL0d1fXxqAfoOu64QuxaiCE28bVkIQYK6iVm1h6ErBHKhnKwPu6+UApfhwDZpr+4qbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596368; c=relaxed/simple;
	bh=yQlHZyUi/r48kvVLyWr7GSZJU7t57N5Zdmgj1vNHNqw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dCRxnoaQbc1a/QkLtE7ssKdkZSB38b/gcRq9JGmah0FUwUmlGTCZrRDXXdNof5Vi48x29VyaHYG8B8Vp5Q0eSq5IVzMwE1WX9Cf8cvFMPnJDTt4NdmPnEFfXEL0b8kCc521eMmEkqv5ghFqB7k7sDy96/7WbbR8KT6ItZlFkSis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G3JNGKki; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSpJF5xja+RtCkLhN+eUvymVCZlHabuGR+6TTgmJXTMxMSawLaD2JuowJqvHQDMSAmnF3Iwg9c6or3FQhBNcALL7xbwD+LxpVJcYx2FoF2g9Sq+J+VK13o04upys8gxOdTcwwPrwS0bf9jg897zv9TfqO9/KeV5Ubv/davZLq0FWiXGgTpozQHRPll6VrondoUlU2qbUutzulhG9QsRBmUsPzKmKlqQVwJ5m6hgNHnWS4IIAvPeR+AwWeWFdVVaNiNz6OdDJnZ6tF6C2pEQVr38IwgaNbm99YpUWxuST5UivqNbciqA67VrYkHkWhh9GJRW0idRrwK30+P+ZeGfj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehw/5aS7wtuGyafxw+NRNoVpv2QVJZzfXlnQb5PZ49Q=;
 b=oM0ZJeMyFEecT/2bTY5OIL6lAxlzTmqq6Hrh0TYyBJ1XFulinmej7hsnT/ga1u4lBIVEyw7Ipg/7ZsQgdhTHatFtsnEbBUTzvUqJ2Kpd/nAmXlvaGUWjHsnuzMIoKeCVsnL1PvoQr9IM84ouRFtetyPiholgNvT7qrHWCyQ2H1hWpJuR9HFsMAOEJ21V6JAZ1BMEe8ha+hHthamiRt7Qze3SRwQq2H0TrVFRIX9aeeXa81bYle2rYJ/BsMPs6AebBCD9V3nAH4wzRWZUBKU5CDkeeOU/As8/gK8ZSWxftE81zfpLreAR5Kwgoz3Q6JHmt8rOE5eXnkbefolQsgAung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehw/5aS7wtuGyafxw+NRNoVpv2QVJZzfXlnQb5PZ49Q=;
 b=G3JNGKki3rGPgihBbo9pwWPyr4AMU5LtraY6sQE1/6w7zPr6i5ybYONzabW6WdMiToeFZVX6a4SkKBqkB8kCQSHrW8n4OnS7yfGGD1XZ/knq0zHrQCGHme1YOFqBKaLxPsTqNXwZyrbi+3dO/kcBwoYAsPF11tVF8oSXuPGFj0noLE6wLAHcJbkeoSbWNAtMMI5wFpqCaMjxG0wb4EOE4QTQ311rEdNW48Ii1oR7ay9RTnxfqHA5G0qHkTGEMgdO5KmgbcAptBW1//mVHtho0QEXiVq13r88rNlhz8tkk4qaiDXsGLPV1yveVPn3BqrgOvbW1nThKfIwXRIm1Xb85A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 06:32:43 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%6]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 06:32:43 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Thu, 16 Oct 2025 14:32:21 +0800
Subject: [PATCH v4 03/14] MAINTAINERS: Add i.MX8qxp prefetch engine DT
 binding files
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-imx8-dc-prefetch-v4-3-dfda347cb3c5@nxp.com>
References: <20251016-imx8-dc-prefetch-v4-0-dfda347cb3c5@nxp.com>
In-Reply-To: <20251016-imx8-dc-prefetch-v4-0-dfda347cb3c5@nxp.com>
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
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB9PR04MB9964:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e96136-8afc-4f6f-5402-08de0c7dcfa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFozM3d6TytQTkRjMlVpWXdRK3dLOVZkVGNTTGw3VTEvQit6cFZBZDdHNkR4?=
 =?utf-8?B?QzhreW95TFFEZXVBbXM4R1VDMEhVZDBONldVRmNmTWZSRzZuaGZXUDNMUkQ4?=
 =?utf-8?B?OEVVaW4vVEQrTGpzV04xK25nQmQ0eDk3T3h2cDhqQngyVGxiZ2NEU3A1bzda?=
 =?utf-8?B?ZjI0bXB0VDlrcEQzbWlDejJMN3p1YU9UMlBqRWpRdzBWeHRCSGZidGhiUkRQ?=
 =?utf-8?B?RnFQVXJYb0FzQlRiOFZUQnpwcDcyQU5hVC9kSDF2bWFCV01NQUN4bElZMFRm?=
 =?utf-8?B?VVVJcU85YmNrWGhjQyt4MUpid2x2UWdwWHJFRTQyRElObmlQOUZVMzhTTlln?=
 =?utf-8?B?elZrVFNtaDhVSGZBNlZKSjBVVERPU2xIeG5UbSt0b0xjdGlRaG5Sc3kwdkJu?=
 =?utf-8?B?ZmFQd1VKbStKQWdYdWVBdU9iVnRiNEllME5uaHNrUDNEUVdSMXQrSUFHVkli?=
 =?utf-8?B?SG54c1ZmMFgrMEZsd3ozY0F4SWtuQkEzQzJEbnRMamFvcFVDNlltZTN0dWt3?=
 =?utf-8?B?SEh3eS9OZmNRSmw1dnRncFpzdnlORUl4MTFNT0JCa0gyc2RjUzlDQnl2MlJI?=
 =?utf-8?B?bEVFR2EzNUp5RGlaOHBxQStBN0xjbHhwYVJBTU5oY01JTDlSdjQ1MGpxZmxw?=
 =?utf-8?B?LzFYMllkQlZnVXhuNGlEU1dvaENVQk1UQktYaExJMzVwclhCTjVKMWt4S0xm?=
 =?utf-8?B?dkJuSG9OK05tRzN2anQyeFgwM1M5VEdodjAyRTFmREt5RG1OREl4cXlEUVB6?=
 =?utf-8?B?bWIwcDU2ZzdsaFhwYSt3ZkkvMWtSSkpwNDZIcXFYVWpSOUZtTFFiRFZFMzRH?=
 =?utf-8?B?R01yU3d5YlF2WGFxMWI3OG5MMWQ3N3Z6V3JTOGpHRlFIRXpjYTRYdElWclVP?=
 =?utf-8?B?K2tiL05PTmIxOXVPTXpuR0ZmK2xJaVl5QVV1c09CUk5SYVBDVnF5UFVVckVU?=
 =?utf-8?B?MzE1NUszck1UcmJ2MGVSeWxBeVJOUk8wblErdE1YT3VWcEdxUXBKMTdXaFRx?=
 =?utf-8?B?cmYwREc2YmtKcTE2Z0Fland3L21ZSnN0dGp5NE5PZDFhT1FtVWlEbFVyTUlV?=
 =?utf-8?B?ZmZ4SzRRM29TWnNncHk3RW5IWkFMZTA1YnZHWlVMVk4zRk5FSzlxRElxdUtS?=
 =?utf-8?B?REhybVMzYjhwdjBScWF3a2VUN3pQUkRhOExoc1Q1dmRQS0c0NlJCVjYvaFhv?=
 =?utf-8?B?Tnh4UXp1TWw3ZEpoN1JzUW4zUTV1NUFOUlVlcFdXc0kwZ0lCWEEwb1duM0J3?=
 =?utf-8?B?RnpaVURBb1JCOFlsTmpRL0JVQVdjMm04R1hxQktvc256TFRhSmFldVR1cXh3?=
 =?utf-8?B?bEFKR0d3c2JFRU1pNVlRVWNmdm5wU1hmYXBEMkRDNU40QVIyYlBySjgxcEQr?=
 =?utf-8?B?SEdQc1kxSG5wTG1WZ0l4NGdQVDlmSVVyTElNM3k4bS9aNUFZVW4yQUFQcjc0?=
 =?utf-8?B?ZUc3SXVxK3l2U3JvUVA1SFdBcFE2bVlSR0lyWXlYVFJxamM2aElYTEgvK05w?=
 =?utf-8?B?RnJ3bm9MT1lQTnVuNENxN2FacGxpSUgzRXpLOUZkN01tbEZNM3lHMTNzam1t?=
 =?utf-8?B?RytxUVdLWnNLSjhyYTE0V1JEaG1nVVBlVHlzMzg0cTRiakNTdHZrTkxNWU9H?=
 =?utf-8?B?MUhRS1lrdGdZM2doWCtrMGYva09hOTZEMFFaZHVOdU9NalZoYnRxdktwaUpP?=
 =?utf-8?B?UDI1enNhZUxMcjJoUjFLSFZwbWpDTE1uRmM2U3VORExIR0YzVHcrREpWbUF4?=
 =?utf-8?B?RWtBRmpOTGNmcHkreUUyWDk1ZlN6RitIYnEyRHY0dUZzbGd4Sk5jL296T1l3?=
 =?utf-8?B?S0R4bnc2YlBZN3lYM3RZcEZvVEhkbjVreEllbUd3MVZCeGgwNDZSbzZXUC8z?=
 =?utf-8?B?R2lNZ015Y29Fck5LY3JTTHBiZS9heko0cWdlUmdFUXpqcWNDTk1wVWhBL2Fa?=
 =?utf-8?B?REZlcWdRZHRONWk1dzJwNTI1WEgzZnhhb2ZqcWZDdDljR0FGWVlGdGhWdXFE?=
 =?utf-8?B?N3J1SWxZcC9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3JpQnlpVkhyNWFsQ1VIMEcyQ3dCZkczYXk1YWI1eXRGbndyUG82SENmbHhm?=
 =?utf-8?B?dWpKa295QjZHUXRpbmp5c2dqUlI2VlJVUThLSHR0Nis1WGt2dEhCQk1VL3px?=
 =?utf-8?B?OUFJV0pZTTNEUlNJcGlRQTVrbklEZ0tESElPNEF3YWZPUFFFWU80b0EzbHRN?=
 =?utf-8?B?bDFYVk1rcmF1WjNOK01GMjBQTUdXMjMxSmFBbm5SS2NsaHFRRDJWL0s5RXFY?=
 =?utf-8?B?S2x5ZFVZcEdjTTBRckdCTVNjQWN3TlNGU2ZqajE0N1AzOFRIU0wwQi9yQ2Fx?=
 =?utf-8?B?aHY0TERBV2syeENYN1l1Q2N4TUpyRlp1SmFaZnEzYUFqRnVSVE14Ykh5S2k2?=
 =?utf-8?B?YlhKYnk3RGtRTTlVZ09sS2xBVFB5MVhKMVppd3QzUTk0U29vV1hOSEs4Z0I1?=
 =?utf-8?B?Vy9lMTdjNWU5Vkk5M2QzcUd3N1lNUGJWMUorb1hnMEUyWGpFRUlwdCthRWkv?=
 =?utf-8?B?b3ZkRjU1dEpUdHk3UTdWeHhYOTBCMTRyMWNMSG50VHNuUkZnTVdkd2FIRUUy?=
 =?utf-8?B?YjU2eFZLMG5vVWtyV0UybnU5VGY0U1E5dXVJS1NnR0t6RmIwaFdvdVA4MU1O?=
 =?utf-8?B?b3kxU1ZvS0pFWmRFSWJ1dXZhRlV5eHdEZGwxNncwTkcwQWpqZlNJZjU1bjE2?=
 =?utf-8?B?bEIrU0lseXFVakJWSkFIVkJ0UHV3V1RsZDNKN1RHV1hWWTNnT3lneVdpejR3?=
 =?utf-8?B?eE1GVmE2K0VxWk5Fc0h4R3NTVklGUDhidEJZam8wTjh4WUthUzE2UTR2SkEz?=
 =?utf-8?B?eGRBekhMbzlWamhqVXlJTzF1T3ZtWEhvSVhaU3FXa3Jrb0lXbXB0c1NPNzJC?=
 =?utf-8?B?Y1VKTVhYL05sWTh3T3d1d2NNRlRXMnN5b3ZoUEtHbklUa2UzRU9yMHUxQ3Za?=
 =?utf-8?B?WENSZDBha0pmNWZaeFNsZlFTOFFldGNrZy9lZURQL0tFY3ZkMEZ5QlRxNmxF?=
 =?utf-8?B?UWtuNFM2NzZDSDBZWklyV2pXemh6dFczSEl5KzVFc0FLVHNwdkxzMWticko3?=
 =?utf-8?B?S1JwLzhTZWpyUmNja3NHRVdtTFYrT2ZoY2FWQzFmVUhKVjNZOUxHb1RwS01z?=
 =?utf-8?B?T2hHMGZEak4wZjR2YU1nbHp2cjBYREYyN21oU2xNYW9PNmtGb3A1NzFacXpq?=
 =?utf-8?B?cCszcEtrUlRMSWVvQ1pobytuakd3aWluMk5USHRicExKWjV0U3RjOWdxNXI5?=
 =?utf-8?B?SXZiVGk0cFdLcjhydk82WGlmQlI4NHFneWpoYnJEM1NDOE8vbXhVUGNJRHdw?=
 =?utf-8?B?VVBTQm5HZlc3YnJFZUNtVXlRam5Rd3I2cmlUQ2hJV09GNlZWRVlUcVJnazNy?=
 =?utf-8?B?L0g3OFdCSWdDYVlrM0FzS3NlWW93R2h5MUg1UzRXMGZEZWJldC9hZlJFMVU5?=
 =?utf-8?B?bFp1bTZ6TUNRaUpmMXJKblJrTUsvQlJpOGcvNzdyQjZFaGFJR1B5d2kxcWFD?=
 =?utf-8?B?bjRvSjlpKzY3TFNNcm1nOWp3b0Vkb2p3UTExcjFlWUNZT0FYTDlFanpnanhI?=
 =?utf-8?B?RjJJWVRQdXlPY01xL2FKTzd6VTZoZEpFR04veXhya3hRNjFyLzJpZG0vZnNL?=
 =?utf-8?B?QmJjVjFmUklKWGNjQ0t6MUttRjE5RFhHWTNNa0M2Sjh5MVB1bGpGaTVTTFU2?=
 =?utf-8?B?bk5xUUhMZ3cxSGFJS1ZUSHhRTTBweVBnMjV4WDRnMDNhVi9mSzFZd0ZUaHRY?=
 =?utf-8?B?aEoyNzdyczM5ZEJBTW16ZHA0eHBvYTlWQnZkaEZXczBCM3YwZ0h6OW1LNHRE?=
 =?utf-8?B?SUJHNnVNa0NXYzI0SlBhRnNtUVlvTXpsSFp0TU1NWGFHWFNEa1RKUSt5dThQ?=
 =?utf-8?B?dCtYSS80R1hFK2VjRW5KUExsWm40R2FoVW9IVGZmUENVY0Y4MDZDanFBZlNN?=
 =?utf-8?B?ZnFMcVY2YjczV2VOOG5OUkdjRVU2RkVlTVozN2krNTVVWC9jRlNHZklZMkxj?=
 =?utf-8?B?VDdaR0FsYzhJZkFDNTcrSWRSRmZkTWtIK1V0ZVQxaE9IOW01ZHVQYUptMzE2?=
 =?utf-8?B?OWFmanBOenVJQ2JJb1ZiOHNUZ24yWlBPOERVR3dMTVZSSEFsc21tenNLNnBL?=
 =?utf-8?B?M0Q3NWRMamROaW9kUHdHV1F6aE1IVitOVmZaVTZaLzBNNHJmZERwUzVVdXd1?=
 =?utf-8?Q?8RlBan2yysoaNcCOs5ZYBz4NZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e96136-8afc-4f6f-5402-08de0c7dcfa8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 06:32:43.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3u2z/GIv+xRAY8RtLtDjAAsAlGMeBjyhwWmzMr5BqOoEhPl++GEzq5dg4qXyZqUzLYzUcl+nbgfZNEpBebrbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964

Add i.MX8qxp prefetch engine DT binding files to
'DRM DRIVERS FOR FREESCALE IMX8 DISPLAY CONTROLLER' section.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2:
- Collect Frank's R-b tag.
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f9f985c7d74796938560148ffab7d3838dc02942..a816b626da6d05b70ee6fc90f83911ebb4e12e06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8332,6 +8332,8 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc*.yaml
+F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dprc.yaml
+F:	Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-prg.yaml
 F:	drivers/gpu/drm/imx/dc/
 
 DRM DRIVERS FOR FREESCALE IMX BRIDGE

-- 
2.34.1


