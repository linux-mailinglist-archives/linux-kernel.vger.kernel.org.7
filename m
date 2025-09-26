Return-Path: <linux-kernel+bounces-834342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDF7BA47E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407451C06A94
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFE123BD1F;
	Fri, 26 Sep 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aV2wjF8g"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA762376EB;
	Fri, 26 Sep 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901701; cv=fail; b=QD0wNP9snCi2bvH8JKZFAb/G0eTxM0LRH7OQqWVOhB+fKrTaFoB+3lXvmtaktKCkI9LPYP02k5jv0Uavs07tntk0+wrM+wJjxm4L+IELCXx7m0iBnCcvGwMNOlzLovrrkRNXAt54Ul9diTOos72KdCj9jar6EB5GWU2w8GHJ0Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901701; c=relaxed/simple;
	bh=4w5tTIYti7iA3GrGZlldgwVR5QrapQ+PywNOE5b9rOc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=U/bsHR5pgdA+xSicgU6dgtg4GzVTDFV2YlBhJi7364yDKHYqyZBA0DGMwYhKsOoszMbFmbnXnYUTau1u0+xDT5sRKACGmwfSVexyCIkrKny3N5ce4G7/tu01OAhWzuDw39log9/kqtgMuGwku6m1edro8mXjRIQR3po1FJl68Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aV2wjF8g; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTqj1DBD9XJoTDXRTSH/12twYOS52UmPIKHW6BJMNY8F0eDV8tfNaqqIFprb7wLHLDZZgfM1ch4leUjLDql5WTYv+JxDJ37KC2JZzcT5KGhDK/G14pnbx6wAd3kQ8PnwuJOXoFpp8oBqaOKgu6FFpoKylKL37NLWx76nqI6p4KVSY1fDeWC2t/F8fvzqLukuiu1nTlzARsOG+TlUoDmXj53GLOHc3uXYuw1OMj00taVAcVVfErMNRdNpffMkYP30YD/i62QYfZu/oMlel8IXGyaPoe8THLusdaP+k7PxE1IPHYGkQ2U0FjwO1/Ezu3x55w6dDTD+Zn9psy13vKlAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQHp2yZsK+e2ioy8wswR6PSZqIAIAMOeejkSV5M/CS8=;
 b=dUdw8N1O+Gram8OurCQjEhsyOD00H1vPrDlqUEQECT40fXVzWM6HkfMpyn7/0fwbDgcDRtDRzd8efGQGHbRVOzIySfFODhR9DeM97NQqeG6DjQne/dzZWor59/ofzImHrvm6Wnhq5zY7s6Rx8j9NUAB1Xqv5UWPwm97TBYuyzPrAg5/BEhNtOMbjLsfI4gWoiKqQ/IEm6kB0nWhcq7VUQGy09NUJH875qo7SFGEafP3zqLWUebPCdWVviUkzzM+BpC9wrOqjU9kcfViptdazhXYI80QGipOg0C5n/VTN4aGsNLy0wmQPxE+MAGSh/K3HUIW7aKiRowkOZCthXujI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQHp2yZsK+e2ioy8wswR6PSZqIAIAMOeejkSV5M/CS8=;
 b=aV2wjF8gHUuvCJZ4+B7ACe4lEz4Pi6nEwaj/GoCa2TIzZalR8wGlNx0sZ19N34g3e9hKi5070aP+1aJT9s9VieXy1QvMd4n2B9cmmZTMOQZcWsQMoarlXplIY0zg+hTcppqZlWCVAR+OhWsvp6L1l8vkujzK9l0SJgIpvzRmPKNEHmy4Qs9+LJ3H7qhMITdvsaWx4DsMajldkHPfACR527K0znDp6eSCt+TccRfK3rnlX0BidkMJ0dVLRhYFFmQ1oqoRduBEnpqbhx2QsFzTSBcf2UrB8H8XS0bVJzLEQ5Alqco23i2L2kLy5xHgAHaVQbdRn8Fitqq0ycrsnwXptQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by GV2PR04MB11826.eurprd04.prod.outlook.com (2603:10a6:150:2d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 15:48:15 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 15:48:15 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Sat, 27 Sep 2025 02:39:34 +0530
Subject: [PATCH v19 4/7] firmware: imx: device context dedicated to priv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-imx-se-if-v19-4-d1e7e960c118@nxp.com>
References: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
In-Reply-To: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758920996; l=11122;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=4w5tTIYti7iA3GrGZlldgwVR5QrapQ+PywNOE5b9rOc=;
 b=E70qfWb/PDEUH0Pz/fC5vV73KP6eKM0VgX18nOmIligtLQ31elLOkuWo9YP10+Ix1kNP5NSXc
 5wX1Y6C1YnIDCja2iJ2d0PM4z/WHwqVjV2SFc7YRabFJ1Efa5l3gEja
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|GV2PR04MB11826:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8c9ab1-4409-4ac1-42e4-08ddfd141b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVFzVmNweUg5SnBoY3VmZG5xZkx3MzZvTEduK3JhcjJZK0hLUlM1aEF3Qjhu?=
 =?utf-8?B?dGkxWTJpamxwcnFVR29QbDR2MWlzemNkci9Ua3NSQ3d2OC93NnBsbC9ZRCs0?=
 =?utf-8?B?RVpzL3FqVkMxM20vMmowNk1POUdmd25TeXNkSkFnL1dON09XQ3pteGM3eDZp?=
 =?utf-8?B?d1J6dW5lS3JuZHJBQS9kSVJnam9LaFlsdnNzdzJYeHVqTGVITURHbzhFNkU2?=
 =?utf-8?B?MklrblhWL1ljSXFwN1R4M0liaS9XeXFoOENNNWNkeGJwdUVFQWdXRU5oQndh?=
 =?utf-8?B?S1JCY3h0MklicVdTQmpWbTE5YVZrbTRLN0xhWWVYTm9tUFRKS2hTQ1RDNkNE?=
 =?utf-8?B?bGU5UkNYY1VDSHpMLytpZVRJb3NPcVFTMFo1TWh3R2VKdU56anBoWFpaRHFT?=
 =?utf-8?B?TEdSMENXNHZsYjZ6V2pDclNRcDRuNHVuVGw2QjNOT1hteTZVMG9IOGIvRzZM?=
 =?utf-8?B?YW5LVDlFVm9ad3I2eGJ6ZDYxZW9lMWJ6Y3pLRWxOZDdoekp4WXJocFpmaVFn?=
 =?utf-8?B?Ujl3Y3AyRVR0V0JCbTNpc0E2QkV3aHFyMnpmNDJ2Z3FIM2FSaVdXME1BdUNR?=
 =?utf-8?B?ZmVERHU1MFhQSlMrc25jUW9GZkQ3R2dQamJHSFVCVHFNMlN2bStSaEtVYklV?=
 =?utf-8?B?eXdUeTUrVCtaVTAwNllOMldTK2lnb2pjWXQvKzRldlJkeUFWb0FZcU1rNTJz?=
 =?utf-8?B?Y3hjS0xQV1lLR3RROEJ5N1Z3QlBKYVR0Z2IyVFZCanJkRlNxUU55RmpJbUNF?=
 =?utf-8?B?dVdhdkcxOEtqdWtNS1o3SmZPcCtDSkNSSTJsRjNUSWhxcHFrOTRyd2Q2YkZL?=
 =?utf-8?B?RWtzUmdCOSt4bTZYaEoxdUcrWXcyLzhHV0Q2cjY0WnAxRFFPeEt3MW45ejNu?=
 =?utf-8?B?dHN1WFh3ZFo0d3V6MGd1dVIrVS9ybDhocVJIYUd3bFNQMjg5ZU9HQzhnT2lN?=
 =?utf-8?B?V2RJVE0zRDl5RWN5NjNCWE5KTklVTHdWQWsydjU0S2craUtJTEQyRmU4Uk42?=
 =?utf-8?B?NnNJZWpiMnJqQnFSVG5xYkVvMUI3TVZZOWhzZ0dRSzlhenQzNnltUDhNdVpi?=
 =?utf-8?B?Vk8rUWhDQStNeFJJY1kwaXd0L2ZPQkNUN3lnaUdkaXRoQkZaeFd1OXpjamlx?=
 =?utf-8?B?aEl5anY1UThTVXNjay9UMElXWms3YkFSaFFXYng3R0ljZ2crWFlsYWJydk0v?=
 =?utf-8?B?d1M4ejZzV3pIK2E2K1JLWkZaVVRuNHRoSG51QlFsR2ZRcEJ5ZkxId2ErbGsr?=
 =?utf-8?B?aVgwRmZHS1F6QXlYRG9RVWhJaENMOTlCZXRmb1l6YkJmZUVOdE5ubmlZZG50?=
 =?utf-8?B?R1NudXBxS2RnVFg2UzNaNXR2ZFpJZEFDVHU3VWxMMktZd1BFejRCazBxNVhK?=
 =?utf-8?B?TGc4elUzTG9ocGU3d1ZhdHNwOUVLdWdoRlZ3WWxLVzI0QmNJeGlvSC9SalE1?=
 =?utf-8?B?UitpVUhQV2pueGl1YjN2RGZYMVV2Qi9PYWdwOEZ5dWJqRkt3dXF4UENGOUNl?=
 =?utf-8?B?bXhEY1NkZ2x2RWpaREk2Z3h6NkNXajFWc3BuTjVicWtDTU9kWERGdWFobnFT?=
 =?utf-8?B?TWQ3amtEUi9MdVAxUVM2R3AzdW8xRHlGY01XNUNWQjhLZ3d2cGhGeDd3bWJ1?=
 =?utf-8?B?Wm5hV3p6K0pTaHkxTW8zT1QxbkpXaDNIZVlGUDd4WWJQQWJ3Y09pTjErKzQ1?=
 =?utf-8?B?TVNBc2JVbHhHRC9Dazk1Y203ZWhlOElGQ0JJTUt2T29UMUpvdC9JV3k2VE1h?=
 =?utf-8?B?dHJFTFFhbWhIZ1gzWlFod3J5VlVyUXlBOGZyOFk1WGxFTzVsQnhPb1E3MGR1?=
 =?utf-8?B?N29YZldoUEN5MTRhYWRVRjRpaDdwNngvbTRCRXRvQzRGekgzZ1FBbjFmTHZE?=
 =?utf-8?B?bkRYb2x6aTNkajFNL0RqZ28zdFpUYnE4U1ZlVnZOWHllSnI0R05JMGp2cEJn?=
 =?utf-8?B?UFpNVFNUMmp6K1dHRFFKbS9lMTlMaUI1K2VMM25uSW5OVmlMOUZiU3M4S01D?=
 =?utf-8?B?ZFNoMDZ3MkF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3Y1YTNwd2pSb3JkUzVmUWc0M0szbWxHVjBQNFU2NzMwSitnVGFlSlY4Mmg4?=
 =?utf-8?B?bkpjamZoVnRJSTVUVW8wTWtDaFJCUUxYQjY4YldMNnV3V2UxcGhMVDZyWGYv?=
 =?utf-8?B?czBjb0EwWjJiY2hlNEM4WGFiY3hITlVkU00zNnRHZ1EzT1BqU2hTN1U3VGRF?=
 =?utf-8?B?blJpaytwNXhUUFVhN0lqSTRDNTlVNGlEUU8vcUlOYVFuS3ZxbFd2bWdMRTNh?=
 =?utf-8?B?NnRDNGR1Yi9hRFZnemxWVHZhWGEwNEZUa3BxOGxBMUFURFZXZk5sL1ZXd2Qw?=
 =?utf-8?B?Y2JReTViQldVSnNqUk5kSmpwemZDZFhlM0UwSXR1cGxjNWs3TU95a3NKWWQx?=
 =?utf-8?B?anhNOElTbEpzNGx6dlg5aXBtWHUzMGwwanFDbytIdGpKZElvWXVCTC94RFFH?=
 =?utf-8?B?N3ZOdXp1TXpvdTJJSUJVVXVyYkYzaUl4R0VZMkxzckZBOVdqVEswRTRWTm96?=
 =?utf-8?B?RlA4QXhPa3hnb3hsMWM0T2hES3E2MUhjaGJuRXVnVGpWcDZwdGJhTHFlc0R3?=
 =?utf-8?B?NExWdk92OXI1Q0hYQURaK1NsRTZnandJRDdhY1VzT1kydDVtUEtRUUJCNGxy?=
 =?utf-8?B?ajdYRncyczVxL1dBc0FibEd2SC9iY1Y1bVc0UC95RFFzME1kWXFUY0JaM0pJ?=
 =?utf-8?B?RU41K3J6ekxNR3Ezbk5vZVhVVWhkM0RnWGJrNUFkTGRTQ1pGZmFQdngzdlZl?=
 =?utf-8?B?N1JyN3oxNktRYVFlelNsRTUyNm90S04wd0xPTEFCS0oreTJERVNScUlHS1JU?=
 =?utf-8?B?djFmcTJVZU1BNnIzMHROaU1jMm81MjdDZXdRVkhCMjFZNXdraWNKRm0wbFkw?=
 =?utf-8?B?OG5SaXNyN3o3cXZ6cHNaUXBtUDVIUlJaQXc1cFFteUs2SzNhcUFaY2VBVDRB?=
 =?utf-8?B?ZnFPOEo2YXhiOWI3dUhzRm1TWTZ4RGkwRTFENEJ5SzQ2SWRueUJUaEtERzBu?=
 =?utf-8?B?ckRjWUdIdmR3QXBnSWRPQ2tqN0sraWc4eXlPallRV0MrY3JyZHo0bWZQMXox?=
 =?utf-8?B?aDFxNEdFd1JqZElYSUhwS1ZnTE1mYU1sblRCamlOYjNTMll5bkVhTHBvQi93?=
 =?utf-8?B?cWp6VE4rdVgxNklNSkNidHp2SW1ZSEZ4TXZ6RW9wUkpRRDdNWkNCc0RUUXhQ?=
 =?utf-8?B?QmF2Ums3ZGE3b3l4cjNRYnBGRldpcXRrYzU0Ni9BRVV0NkRYNWsreGhYelkx?=
 =?utf-8?B?eEQ4bnRsTWpHTXlsVU9RZEdBUTFxV3FBVm50RG5TUWVoQzRWbkdlYnpSSTNw?=
 =?utf-8?B?ZkwyNmhIUGcvR085ZDk1dTRZWlBOd1E1cG56WWR2bG5kd2NSV1dobDhvaWo2?=
 =?utf-8?B?cEs5YUk1S2xQZHNHRllESmQraXplbHBueTdURElaWTJBUGZuSm1WanNlTC9x?=
 =?utf-8?B?MkVzV1Npd3o4bXJJbHpvbWk4L2FIbzNQSk9VTWx1VEJubE94ZmNFQUxvbUw1?=
 =?utf-8?B?d1Bvd0hzVUl3NXFUQWxDZkxPL3c3eDZKRDZjdDRpcUhWT3lPWG5LSmRYdkh4?=
 =?utf-8?B?Vy9jeWxVNTNpd1pOUEFlL1hDSFhiUU01K3Q1cEVMYmdEVkpSQlhZbHBCVG1C?=
 =?utf-8?B?bWhrR0dRbU9UMVpPU1BPdzRCeFBJaUd3Y09NUU42ZXkzNGVzOXRqZ1dLTGZ2?=
 =?utf-8?B?Y2luNXR2TGIwT2o0bDBKUHRsVmdwT3B0WXNDWnBpYUFRVHRDN2lzQklvVkZj?=
 =?utf-8?B?NmVFS0RXaWVZUk0zS0xiT3dieGJmMVRpNjdwSG1jdkVWL1VRSmFIL2Y2SzFk?=
 =?utf-8?B?Y1V2OS9mbnhkbzBMZVQ3K0FNRTFjcXRiMThnaWJwUllTemNmZy9Ld0tZZWxT?=
 =?utf-8?B?YzQ0S1J0bkw4MmdTaHVwSUZEWlVFUGZ3dW9SRnhSYVB3NGZ4dzlZNFZqcDNo?=
 =?utf-8?B?SzdRMktMdHdQWkVqa3IzMW8rWGNaM3dMTUF2c2xqcU9GWHJiYVRhWWhvcUpC?=
 =?utf-8?B?bk1PekE3ZzdPRHJUMzBUMVptUFhRTExyaWhacXFITGJxWXRyaWdwczVaYkdt?=
 =?utf-8?B?UTR4N1lOdk9IRVpqZy92VHJUYmY4aDJpd0tNcFlpVzJONVRERjFZMXEweUpH?=
 =?utf-8?B?YTlnVTE3dlI2R1NqZWJSSUhjZ01HRm12WWIvdm5DUEFaNWxUU2NvTFgwNEpT?=
 =?utf-8?Q?HuKXR6ReFajrFMFt/xt9+IC4y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8c9ab1-4409-4ac1-42e4-08ddfd141b19
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:48:15.3621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGYnMJkcGni2Z2De4sx2wi1gT19ObwMI7fEh7RLKH1IeU/vWkRXxxSLDagSDLcoput84lFt4hbWIyDm94at8Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11826

Add priv_dev_ctx to prepare enabling misc-device context based send-receive
path, to communicate with FW.

No functionality change.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/firmware/imx/ele_base_msg.c | 14 +++++-----
 drivers/firmware/imx/ele_common.c   | 51 +++++++++++++++++++++----------------
 drivers/firmware/imx/ele_common.h   |  8 +++---
 drivers/firmware/imx/se_ctrl.c      | 29 +++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h      |  9 +++++++
 5 files changed, 78 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
index a070acbd895c..b233729dd13d 100644
--- a/drivers/firmware/imx/ele_base_msg.c
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -59,8 +59,8 @@ int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info)
 	tx_msg->data[0] = upper_32_bits(get_info_addr);
 	tx_msg->data[1] = lower_32_bits(get_info_addr);
 	tx_msg->data[2] = sizeof(*s_info);
-	ret = ele_msg_send_rcv(priv, tx_msg, ELE_GET_INFO_REQ_MSG_SZ, rx_msg,
-			       ELE_GET_INFO_RSP_MSG_SZ);
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx, tx_msg, ELE_GET_INFO_REQ_MSG_SZ,
+			       rx_msg, ELE_GET_INFO_RSP_MSG_SZ);
 	if (ret < 0)
 		goto exit;
 
@@ -109,8 +109,8 @@ int ele_ping(struct se_if_priv *priv)
 		return ret;
 	}
 
-	ret = ele_msg_send_rcv(priv, tx_msg, ELE_PING_REQ_SZ, rx_msg,
-			       ELE_PING_RSP_SZ);
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx, tx_msg, ELE_PING_REQ_SZ,
+			       rx_msg, ELE_PING_RSP_SZ);
 	if (ret < 0)
 		return ret;
 
@@ -154,7 +154,7 @@ int ele_service_swap(struct se_if_priv *priv,
 	if (!tx_msg->data[4])
 		return -EINVAL;
 
-	ret = ele_msg_send_rcv(priv, tx_msg, ELE_SERVICE_SWAP_REQ_MSG_SZ,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx, tx_msg, ELE_SERVICE_SWAP_REQ_MSG_SZ,
 			       rx_msg, ELE_SERVICE_SWAP_RSP_MSG_SZ);
 	if (ret < 0)
 		return ret;
@@ -199,7 +199,7 @@ int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t contnr_addr,
 	tx_msg->data[1] = upper_32_bits(contnr_addr);
 	tx_msg->data[2] = img_addr;
 
-	ret = ele_msg_send_rcv(priv, tx_msg, ELE_FW_AUTH_REQ_SZ, rx_msg,
+	ret = ele_msg_send_rcv(priv->priv_dev_ctx, tx_msg, ELE_FW_AUTH_REQ_SZ, rx_msg,
 			       ELE_FW_AUTH_RSP_MSG_SZ);
 	if (ret < 0)
 		return ret;
@@ -238,7 +238,7 @@ int ele_debug_dump(struct se_if_priv *priv)
 	do {
 		memset(rx_msg, 0x0, ELE_DEBUG_DUMP_RSP_SZ);
 
-		ret = ele_msg_send_rcv(priv, tx_msg, ELE_DEBUG_DUMP_REQ_SZ,
+		ret = ele_msg_send_rcv(priv->priv_dev_ctx, tx_msg, ELE_DEBUG_DUMP_REQ_SZ,
 				       rx_msg, ELE_DEBUG_DUMP_RSP_SZ);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index 748eb09474d7..f26fb4d55a9a 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -42,7 +42,7 @@ u32 se_get_msg_chksum(u32 *msg, u32 msg_len)
 	return chksum;
 }
 
-int ele_msg_rcv(struct se_if_priv *priv, struct se_clbk_handle *se_clbk_hdl)
+int ele_msg_rcv(struct se_if_device_ctx *dev_ctx, struct se_clbk_handle *se_clbk_hdl)
 {
 	unsigned long timeout;
 	int ret;
@@ -52,8 +52,8 @@ int ele_msg_rcv(struct se_if_priv *priv, struct se_clbk_handle *se_clbk_hdl)
 
 		ret = wait_for_completion_interruptible_timeout(&se_clbk_hdl->done, timeout);
 		if (ret == -ERESTARTSYS) {
-			if (priv->waiting_rsp_clbk_hdl.rx_msg) {
-				priv->waiting_rsp_clbk_hdl.signal_rcvd = true;
+			if (dev_ctx->priv->waiting_rsp_clbk_hdl.dev_ctx) {
+				dev_ctx->priv->waiting_rsp_clbk_hdl.signal_rcvd = true;
 				continue;
 			}
 			ret = -EINTR;
@@ -66,7 +66,7 @@ int ele_msg_rcv(struct se_if_priv *priv, struct se_clbk_handle *se_clbk_hdl)
 	return ret;
 }
 
-int ele_msg_send(struct se_if_priv *priv,
+int ele_msg_send(struct se_if_device_ctx *dev_ctx,
 		 void *tx_msg,
 		 int tx_msg_sz)
 {
@@ -78,15 +78,16 @@ int ele_msg_send(struct se_if_priv *priv,
 	 * carried in the message.
 	 */
 	if (header->size << 2 != tx_msg_sz) {
-		dev_err(priv->dev,
-			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
-			*(u32 *)header, header->size << 2, tx_msg_sz);
+		dev_err(dev_ctx->priv->dev,
+			"%s: User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			dev_ctx->devname, *(u32 *)header, header->size << 2, tx_msg_sz);
 		return -EINVAL;
 	}
 
-	err = mbox_send_message(priv->tx_chan, tx_msg);
+	err = mbox_send_message(dev_ctx->priv->tx_chan, tx_msg);
 	if (err < 0) {
-		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
+		dev_err(dev_ctx->priv->dev,
+			"%s: Error: mbox_send_message failure.", dev_ctx->devname);
 		return err;
 	}
 
@@ -94,27 +95,31 @@ int ele_msg_send(struct se_if_priv *priv,
 }
 
 /* API used for send/receive blocking call. */
-int ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, int tx_msg_sz,
-		     void *rx_msg, int exp_rx_msg_sz)
+int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx, void *tx_msg,
+		     int tx_msg_sz, void *rx_msg, int exp_rx_msg_sz)
 {
+	struct se_if_priv *priv = dev_ctx->priv;
 	int err;
 
 	guard(mutex)(&priv->se_if_cmd_lock);
 
+	priv->waiting_rsp_clbk_hdl.dev_ctx = dev_ctx;
 	priv->waiting_rsp_clbk_hdl.rx_msg_sz = exp_rx_msg_sz;
 	priv->waiting_rsp_clbk_hdl.rx_msg = rx_msg;
 
-	err = ele_msg_send(priv, tx_msg, tx_msg_sz);
+	err = ele_msg_send(dev_ctx, tx_msg, tx_msg_sz);
 	if (err < 0)
 		return err;
 
-	err = ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
+	err = ele_msg_rcv(dev_ctx, &priv->waiting_rsp_clbk_hdl);
 
 	if (priv->waiting_rsp_clbk_hdl.signal_rcvd) {
 		err = -EINTR;
 		priv->waiting_rsp_clbk_hdl.signal_rcvd = false;
-		dev_err(priv->dev, "Err[0x%x]:Interrupted by signal.\n", err);
+		dev_err(priv->dev, "%s: Err[0x%x]:Interrupted by signal.",
+			dev_ctx->devname, err);
 	}
+	priv->waiting_rsp_clbk_hdl.dev_ctx = NULL;
 
 	return err;
 }
@@ -159,8 +164,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 	/* Incoming command: wake up the receiver if any. */
 	if (header->tag == priv->if_defs->cmd_tag) {
 		se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
-		dev_dbg(dev, "Selecting cmd receiver for mesg header:0x%x.",
-			*(u32 *)header);
+		dev_dbg(dev, "Selecting cmd receiver:%s for mesg header:0x%x.",
+			se_clbk_hdl->dev_ctx->devname,  *(u32 *)header);
 
 		/*
 		 * Pre-allocated buffer of MAX_NVM_MSG_LEN
@@ -169,8 +174,9 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 		 */
 		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
 			dev_err(dev,
-				"CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
-				*(u32 *)header, rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+				"%s: CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				se_clbk_hdl->dev_ctx->devname, *(u32 *)header,
+				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
 
 			se_clbk_hdl->rx_msg_sz = MAX_NVM_MSG_LEN;
 		}
@@ -178,14 +184,15 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 
 	} else if (header->tag == priv->if_defs->rsp_tag) {
 		se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
-		dev_dbg(dev, "Selecting resp waiter for mesg header:0x%x.",
-			*(u32 *)header);
+		dev_dbg(dev, "Selecting resp waiter:%s for mesg header:0x%x.",
+			se_clbk_hdl->dev_ctx->devname, *(u32 *)header);
 
 		if (rx_msg_sz != se_clbk_hdl->rx_msg_sz &&
 		    check_hdr_exception_for_sz(priv, header)) {
 			dev_err(dev,
-				"Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
-				*(u32 *)header, rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+				"%s: Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				se_clbk_hdl->dev_ctx->devname, *(u32 *)header,
+				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
 
 			se_clbk_hdl->rx_msg_sz = min(rx_msg_sz, se_clbk_hdl->rx_msg_sz);
 		}
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index 96e987ef6f88..5bac14439d7d 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -14,12 +14,12 @@
 
 u32 se_get_msg_chksum(u32 *msg, u32 msg_len);
 
-int ele_msg_rcv(struct se_if_priv *priv, struct se_clbk_handle *se_clbk_hdl);
+int ele_msg_rcv(struct se_if_device_ctx *dev_ctx, struct se_clbk_handle *se_clbk_hdl);
 
-int ele_msg_send(struct se_if_priv *priv, void *tx_msg, int tx_msg_sz);
+int ele_msg_send(struct se_if_device_ctx *dev_ctx, void *tx_msg, int tx_msg_sz);
 
-int ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, int tx_msg_sz,
-		     void *rx_msg, int exp_rx_msg_sz);
+int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx, void *tx_msg,
+		     int tx_msg_sz, void *rx_msg, int exp_rx_msg_sz);
 
 void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
 
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
index 5f978c97da4a..40544cbc70ca 100644
--- a/drivers/firmware/imx/se_ctrl.c
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -203,6 +203,29 @@ static int get_se_soc_info(struct se_if_priv *priv, const struct se_soc_info *se
 	return 0;
 }
 
+static int init_misc_device_context(struct se_if_priv *priv, int ch_id,
+				    struct se_if_device_ctx **new_dev_ctx)
+{
+	struct se_if_device_ctx *dev_ctx;
+	int ret = 0;
+
+	dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);
+
+	if (!dev_ctx)
+		return -ENOMEM;
+
+	dev_ctx->devname = devm_kasprintf(priv->dev, GFP_KERNEL, "%s0_ch%d",
+					  get_se_if_name(priv->if_defs->se_if_type),
+					  ch_id);
+	if (!dev_ctx->devname)
+		return -ENOMEM;
+
+	dev_ctx->priv = priv;
+	*new_dev_ctx = dev_ctx;
+
+	return ret;
+}
+
 /* interface for managed res to free a mailbox channel */
 static void if_mbox_free_channel(void *mbox_chan)
 {
@@ -325,6 +348,12 @@ static int se_if_probe(struct platform_device *pdev)
 					    "Failed to init reserved memory region.");
 	}
 
+	ret = init_misc_device_context(priv, 0, &priv->priv_dev_ctx);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed[0x%x] to create device contexts.",
+				     ret);
+
 	if (if_node->if_defs.se_if_type == SE_TYPE_ID_HSM) {
 		ret = get_se_soc_info(priv, se_info);
 		if (ret)
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
index b15c4022a46c..b5e7705e2f26 100644
--- a/drivers/firmware/imx/se_ctrl.h
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -19,6 +19,7 @@
 #define MESSAGING_VERSION_7		0x7
 
 struct se_clbk_handle {
+	struct se_if_device_ctx *dev_ctx;
 	struct completion done;
 	bool signal_rcvd;
 	u32 rx_msg_sz;
@@ -36,6 +37,12 @@ struct se_imem_buf {
 	u32 state;
 };
 
+/* Private struct for each char device instance. */
+struct se_if_device_ctx {
+	struct se_if_priv *priv;
+	const char *devname;
+};
+
 /* Header of the messages exchange with the EdgeLock Enclave */
 struct se_msg_hdr {
 	u8 ver;
@@ -80,6 +87,8 @@ struct se_if_priv {
 
 	struct gen_pool *mem_pool;
 	const struct se_if_defines *if_defs;
+
+	struct se_if_device_ctx *priv_dev_ctx;
 };
 
 char *get_se_if_name(u8 se_if_id);

-- 
2.43.0


