Return-Path: <linux-kernel+bounces-877057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A51DC1D198
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C188D56432F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882C935A958;
	Wed, 29 Oct 2025 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XIfo4Qa5"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5B363BA2;
	Wed, 29 Oct 2025 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767725; cv=fail; b=E0+44hmHSuuSMOesasZAeFTjfY4cGY3KgZy5dX4fj8VTnsAp6mt08MbbAvc7R0pvUZfNTVboRi7fdYoyhiY72IiXzGt2Ow9WEZDjNnFvhQHOHZN1DU/kA++dPl4AkZY/rEuKKGSsB+0Q5v6hLvZMNgm9vXEyt3rV4DCoRHY2b1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767725; c=relaxed/simple;
	bh=rLKJpVJon0mWaqVq4rURCcb/az2rL1MM9mIVdh/m6P8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D47CwZS/bQxgGfg3qrN2R5N/3XtumkV3UqSMoF3uRh+sIFXHaumSFZYrRiF3mf7ceOPH/JNvOcMEnBYJMkLHWBeS4hU5SoHuIYI/cNzBCUQKTBnod82vsQmyPEa5rGnQeGWYP0eLKBqAb57G0U4jArCP/ahTn9zoCj6DCEZvM+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XIfo4Qa5; arc=fail smtp.client-ip=52.101.84.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gt7TaQdKcvc+GTndIdrCF9YiCDry6u92tNUVFTIls1zLK2300uvwiWWyBzeA0lTPpA1Sh268UgywopiEd6sWC3lV/IqWvNMYXmLsDV2YIEZu/PNp3YyUnKg5wV7MHsBezOpUoapOE2KljCzo20/bIzLovFhASV5T6b59DP8FcSBlm1o74B+GBSyDwj7j8cwPDpny0smvhoztwCKMG7A8FAms0XUCA8Gju4MLgzHflwK47vjExaTSVS8iNTUFlTASgFs4MQe5L/u8fjJWueL3cY/PODnw3HQc8upmf1+u4KTrNrcGaeSPtmGT6i+b0Ykr9V1gNV6BT78cc4M2Qad9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8VqCBIagD0ch+yIHB5z8IZjn1Oh4CNrwvXVGYi/LHU=;
 b=QKbETmZWNoUWlwW7Mzx21SxjkflCWPkG83Yi5uxglSFkh/iQbksm3W9Uea0R2jnF2H8Ob/Qp50nvwWMUEuv+mG2cR8JImr0YD60xp8LbdmDSRJ/Djj1l5cmmzRskFuT/inNowjMy0laG97bCJfWOKAFz6dEjRJmqndTRNpO231Oe/vIt/O22Q/OO1yjXv4K4esWasOyukJYQ0ON4oPctcUu24xoxJ6VzqmmKPgIQvFleMrshtFFWDC6F589DhksBJ8b810nVL6rTkZ1lnJzB33TkgS03QzCB7tx/0GNdapJ7GsXnp65obGLXCl6NJFDiMdEvV0lV6atXNrKJtBOm6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8VqCBIagD0ch+yIHB5z8IZjn1Oh4CNrwvXVGYi/LHU=;
 b=XIfo4Qa5ZYvOqja4RFmxlbGxp17txqHrEyxatc7d5VkKwu2AXiGM5Wfbrf5XMqEiFrKCTW+Xq6Wlz3kp/b33dB56CvlV3Z9dfOVDy1rnnaJkHmvguRL3zX0Z/Q+oYZqftz2caXCXFbeojXzlZXhyKxPhKFgeIuMJAapY5sEAarAx9tnUmwa9SuKTj25JJqM1VPJDD7EP4llP6JIi8MMMIIOEKl4tighcBBfvnjW9sFMVTLObACr1d7ucu8LzPqgesanYSo0gZxgvzGDvsu+Y+fuSQuvFbF304i7ZtYO8uKCN0MmhD3SjpJMG4nKjuizv191f0zF1ltIyOxjfbFlhZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV4PR04MB11377.eurprd04.prod.outlook.com (2603:10a6:150:29c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 19:55:20 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:55:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 29 Oct 2025 15:54:45 -0400
Subject: [PATCH 09/12] arm64: dts: imx8: add edma error interrupt support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-8qxp_dts-v1-9-cf61b7e5fc78@nxp.com>
References: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
In-Reply-To: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761767689; l=6376;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uU2mKj8Kj0TWlihDARcSxQnZwhM/c8E/jxhI9vpXjn8=;
 b=A97rRm2lNeg5loHzmx+hFqyR6GbAwemGR3DPzz2M53JKBmfo3VXYvCAUyGBa/IS4DA0z18tle
 BsjP2o2lWpUCAOQrg7aNkM8fGhmWxDdC0uYrID/nAAFMNkkcgOfLo7u
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV4PR04MB11377:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6cc22f-4ae5-46c2-5c5d-08de17251713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDNRVWNueWRTK2JFMk9wZDFZYk5VUnpqQmlJeml4MzZrU2hzbjFTeGlMRmJa?=
 =?utf-8?B?YjArcnVZM3hhTG9hUEIyV1R3QkQzdjFIZnlULzNsMTRWSE5jVGg4c3JCWkIv?=
 =?utf-8?B?MlZzWUhTelcxSkJSbHBTcm1WazI1aXNuU3p1c3crSjJzc1JTd1BxSTlPQVox?=
 =?utf-8?B?YmhTeE01YUdvTTVFU3ZQaXBZYnBvSW9mQ1Y3d3lnNWdvdzFvazJvZ2RkZ2Na?=
 =?utf-8?B?RS8zVzBHTkg5UVlmTlY2TUE1SHZZNlVTcFBNNUNteVlyQysvcTM4bUJrNXVl?=
 =?utf-8?B?bFVoU1VQU2xMRmtCZ0Y2aGNNWVozWXBJa3FNUmRDYzFFT1huQnlHMVFwejFq?=
 =?utf-8?B?WlprWnhHSXdvWXA2OTRFbmZ6R3JybUYrNEg1VmErK0hHS2FIL0pqbXl5RHVy?=
 =?utf-8?B?UUh3UEZVT0hDR0tEV1hTUHltSWZpRmtDaWFUL2ZwNmJWaDRjcXlzMC9uZ2t0?=
 =?utf-8?B?blp1NUNnRHNsUEp4dGZzZ2M4WS9jcWdXNlNUQldES09hVzhxcWh4bDBYNzVi?=
 =?utf-8?B?amZidmFMVTZudWhiUDRXcVYzS3hLYlBMVFBjaXRuUlZZTjh3eHh0cGwzR1A2?=
 =?utf-8?B?T2cwOUZrSG9VNnA4aGh0UzV1bjFUbzRTak5vczNHMmI3a2tIV3AzVnc3MHVw?=
 =?utf-8?B?UkU5N2lqV0NRbXI4cE5od0JJL21Ud1ZhK3FWSk4yeDVvN3NsNHdNamhNUUpO?=
 =?utf-8?B?MVdwejhNMXAxSmd2ckpPL3pyV0N3dnRUNVRjS2VNdnM0M2NMS2NheGZ2Zito?=
 =?utf-8?B?TUVqNEVjNGFRWm8vR1BZTUdhdmVGUnk0RG10SnV4dlU3dFp1V3dvT1FreFBY?=
 =?utf-8?B?Q3VLOXB4bURXWmQ4Slg5YjJhM29YVllPcU4wNUdZVk9IbUNpUC91U3BId3Yz?=
 =?utf-8?B?aDRkV1JOdlpTdVpabnNDOE1jRTFFNFdkL2ZEU3hrMW41RGZKUkt4WlNCenFU?=
 =?utf-8?B?QXBLR3JQaHl4UUZXU1hPRlJ6NSswRkE1dVBncmFIUm95Y1IwaXhaMGFGOVNs?=
 =?utf-8?B?bTEycXhsY284MWRYSDFuOWVRWGYxU2hYa3dTMGtnS2tUR1BIZC9zanZMZk4r?=
 =?utf-8?B?M3ZIbDFZdndCWDhwOTdXT3lFQmxIVTF5UVloNHVEYlBEdGlKeklhd1JPTEh2?=
 =?utf-8?B?VnNkU2tuZTVmdnBhRDlUMndlMXVKV0t5NGRBSjVDSllzbTFEUGxMQUFMS1RV?=
 =?utf-8?B?bmxwZ1NnWVNnMHV5cVpJYnJNaGdiVVZxaE5QYzgraHFkaUZsaVBuMkpYdVkx?=
 =?utf-8?B?RVJWNnhTOXU1SUJoWjdIT0NER3ZpckhJaGdzUG1VazJ1SjBodGprNnJmWGlm?=
 =?utf-8?B?MVRsNDltdEsyNkN1ZGwydS8vck5ONTJyVzRFMXcxVDBjYTFJeFpKUDdicTE3?=
 =?utf-8?B?T2xwQ2FNSDI2aWFlSHFGRWVJZE0xOHE1eHpWam43VTRHTWorWFh2Um5IY1lV?=
 =?utf-8?B?b2grRjZ2bDFlbVhXdzZzdkN4TS9iUVl4ampvcytadHlOajhwZE5BZXRNbkFZ?=
 =?utf-8?B?L003UVBTSkl4OG1uOWJsWVY2azVrMk5LOHVoZzhmaks1OVdnOTBIZjlSYmcz?=
 =?utf-8?B?U3luZTY2MDhmSDFYTXowRlpyRUcwaDl5akFVL1FFNVRlTnlQTnd1LzI3WXVS?=
 =?utf-8?B?cTdVbUhKcHM1WWdjQkNtallrdG9zOEFPOVg5cVdiR1ZuRlg1VFBiQzY5dzhl?=
 =?utf-8?B?YmlvMTlVcU5OTyttVUFYai9NNDN3ZWJJemhMQ1RrRkJzQW5Xb1puMW5zbTFh?=
 =?utf-8?B?MStFTW9MQnFjakw3WEQwQ0dTYlF3Tnp6a1h4c2JpeW5lMWR4eFZ4ZHNMeTB6?=
 =?utf-8?B?dGVBOUhlZTFKRjdMeTFLTFo5VVlKOTJNb1lxYWlBQnBEQUhqdlhaakt0MDZZ?=
 =?utf-8?B?MDJqRS9mSlM0Mzc4Vk05d1hlakFHblA2QmZ3RWI0ZTR5Q0VFd09XQUpWRGNk?=
 =?utf-8?B?amZQUjV0dENhV0luLzIyN3FUS2FQVW9xZ0hXQnl6UUdGZDhXc2dWeExGTS9V?=
 =?utf-8?B?bzF1cXdDazhncy8yTG9DbjVNb0lrRU0wR25RczNjVGk4MzZBcURsRndXUmN2?=
 =?utf-8?Q?hjsdEb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azFKREQ1RVpWVFpndjdCcU9DUk5JZ0I0K3oxV1cwR2gzTy9xekdjRVlUVTd6?=
 =?utf-8?B?Z1BpN3ZIU3JzOGpPVjYxWU9Nbk9HbFhVMVF1d0x6N25MbVY0cE1KanAvMGpx?=
 =?utf-8?B?RjF0Z1pJazRKbHN1QkZaZUoxb3ZXOGI3MHNncTVsdWU4RmdjMHhadURpc24w?=
 =?utf-8?B?eGVOUUpBbnlrS1ZLVHBJN1VkVzMwSUtMTC80SlVicXdxNitjZ3NwcHBUZ1RN?=
 =?utf-8?B?a1E0cExmQWdRT0dZWUV1c0lSSXIxdCtXUWVYemJQNmhRWEVpQTJTUWNEaVdJ?=
 =?utf-8?B?S3ZRbElrdmFmOUZ6Ym9BbmpLM3V4UHlwTlFuQ3NjZmczalFuNC9zbHk1S3d5?=
 =?utf-8?B?Zm5RcGJtSmovcWZGbFUrMFhhOUt1MGNrVFg3L0R2OXo0NDVRVUpweTJaci9E?=
 =?utf-8?B?ejNjZ1VjR3I0QTNIelU3Y3lrN281QVIvZERJdVd2SzZiN1lPZ1lJSEF5U04z?=
 =?utf-8?B?ZTR6a0M5aHJMYUFRSWhRNUx2MkVWVGlSYjJNQjhLNWluKzdQWGtrc2UyaHNx?=
 =?utf-8?B?ZUcvOGtJVGdNVWZDdkgzNEdYbFR5b0l2bzRqZkJOYWZyaUh4RFlqYm5OWTNV?=
 =?utf-8?B?YkpFZk5QSWZrTHhLdGR6TUxyRFFvU2hVUGdPemJNSGh4aUJhUzhjcUVsYkxh?=
 =?utf-8?B?R29DQXQzcXhNWHFBSi9nTXZ4dzJSZy9USXlxUm8vaW00K1U5djRPeWNaYzhG?=
 =?utf-8?B?VTNPSmNjbHRaU0ZPaWRuRzBGREJpR1Z2OFpQVi9GNXNHYVo3alNkVG5mK0V2?=
 =?utf-8?B?TkVzSm5JblVvbFRlTXppUlVna0Q4RHkyYkRDQmRxcFArZUhkdDFMeEJabHZB?=
 =?utf-8?B?eHlmcm5GTU5QekJOZ0pLY2UyYU0zWWJaeFJHWkRwbTVhSlhkS0c1anNXVTFo?=
 =?utf-8?B?OERJbUlmaUIzMXBDZkZMYkJsWXJ5dnh0Ti9ENDNlV2s5QjJSaE1DYTE1ZzF0?=
 =?utf-8?B?SVpzcDhHSElQQXJtbklUSlF6NDFXV1VGeUZQbnB2Q1VnbUdnWk9aMDNEbFdh?=
 =?utf-8?B?dmgzUGFUMTBlakZmU21BSjNtdkkxa3RqcHFnY0hvVUwzZXQ1dEZIUFlVeGtN?=
 =?utf-8?B?U3BqT1pWdmRsenpWTnVpUVBncmt3NEh2OFZKdDY5cVpLQkxrd0xzY1kwV1d2?=
 =?utf-8?B?bVp0VjA2R1VNeUZrNkhENWV5cG51MEZWNlYzR0FhSEhFMVdSc1E3clQ3K1Nj?=
 =?utf-8?B?Q3ZUNDNRczgvS1JFOFdSQisydjJLdW04cDB0QldIeHBBUFRvajdSczRrM3Nj?=
 =?utf-8?B?ZWJRT0ZaQ0crTzk0UElxbTR2WjJBUGFwb0t6cEZ1azUramtlVGlBWlRkM3Zq?=
 =?utf-8?B?b1NqckxQemUwSTVMRnA1ZUNXOThLTnJzRmtPaFFhNDhDa2s1dGdaQ040eHRB?=
 =?utf-8?B?YmNDKzN3WmJnMHdvRFMwTERCQXdRY1JBaXFZaUhORmpoWWNKeDlHV0M5M2ph?=
 =?utf-8?B?UFF1YkhoQUpKZWVkd2kxY0NyZVV2M3hFTFBvYnk0WUhjc3RpajltWFN0L21m?=
 =?utf-8?B?VlRkcHg0U3lhcU01VjFHSzBiZDlhK1ErMWorTzJSZVFFSXpCVDBtQVBHYlVl?=
 =?utf-8?B?c1NsRGdYSWNFMklVNmpjT05hc254T2t1bTBVRGN2YmNRUlhLOUIvdVRHTGNZ?=
 =?utf-8?B?V0p6NjlkTW9FM0IwOEpLdTYvNWszSjJHMDFIYXJzc2Y1eDNJVUFsMyt6NVVq?=
 =?utf-8?B?cGx6MWxTQUNQc0phNk9WeHNTcDF6MTZGaE1EdEY5VWhPekFYdDdpZUdTcjJx?=
 =?utf-8?B?Um01WmJWU3dtWmlwa2R0a1F6TUVpSCtNaHBvUVp1TkozMVJvcENOU1kyajRp?=
 =?utf-8?B?eU9uTXkxVlFTOGFzTGhjbE9LWk9MdlMxNW9jZUxaOUZKWUdDU25PTVhndFAv?=
 =?utf-8?B?UHRtNTlYRThGaTA3KzI4V1B5ckhkTkpEbXVHdUJNSXFVNEthYVBHQXhIQjFm?=
 =?utf-8?B?OUI2VEdpbzlQL2hWRzVEWXRmMS8rMXRiRjZ0L2Z4RjhBbDJpTlVXZzRFS081?=
 =?utf-8?B?cW1QYXpMamUyTm5zV0lzTXhWb011REFYVEJKdGhYTThJL1I4NnI5RDlJbkxK?=
 =?utf-8?B?RE5yVzJFcUQ0SWFEbEoyQllHTkp6amtGRk9YMkp2d2N6VWptQ0tLS0lyMDZu?=
 =?utf-8?Q?Is4aBKpdWlIGE7dgG3uL+Um3B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6cc22f-4ae5-46c2-5c5d-08de17251713
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:55:20.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFODsDAmBmGIGXrkFkfeKtIhYj6jMTGJ8bqm5ARAdc98aMNfkSuBdwbMbNuvfoT0f0NK8236FQtusy50Q9Erhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11377

From: Joy Zou <joy.zou@nxp.com>

Add edma error interrupt for i.MX8QM, i.MX8QXP and i.MX8DXL.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   | 6 ++++--
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     | 6 ++++--
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 9 ++++++---
 arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi | 6 ++++--
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi   | 3 ++-
 5 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index c32a6947ae9c4224b174b45aa64d22b7f619942e..5e4233ccfde469d797275f5e301987a08dbcf71f 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -296,7 +296,8 @@ edma0: dma-controller@591f0000 {
 			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 20 unused */
 			     <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>, /* 21 */
 			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 22 unused */
-			     <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>; /* 23 unused */
+			     <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>, /* 23 unused */
+			     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd IMX_SC_R_DMA_0_CH0>,
 				<&pd IMX_SC_R_DMA_0_CH1>,
 				<&pd IMX_SC_R_DMA_0_CH2>,
@@ -558,7 +559,8 @@ edma1: dma-controller@599f0000 {
 			     <GIC_SPI 0   IRQ_TYPE_LEVEL_HIGH>, /* 7 unused */
 			     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>, /* sai4 */
 			     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>; /* sai5 */
+			     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>, /* sai5 */
+			     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd IMX_SC_R_DMA_1_CH0>,
 				<&pd IMX_SC_R_DMA_1_CH1>,
 				<&pd IMX_SC_R_DMA_1_CH2>,
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 575be8115e427e5eca1635af08dfe3450048a2b6..4de78f870c05c8fb1a1e5742bf9e6bc607a4a6fc 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -182,7 +182,8 @@ edma2: dma-controller@5a1f0000 {
 			     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd IMX_SC_R_DMA_2_CH0>,
 				<&pd IMX_SC_R_DMA_2_CH1>,
 				<&pd IMX_SC_R_DMA_2_CH2>,
@@ -466,7 +467,8 @@ edma3: dma-controller@5a9f0000 {
 			     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd IMX_SC_R_DMA_3_CH0>,
 				<&pd IMX_SC_R_DMA_3_CH1>,
 				<&pd IMX_SC_R_DMA_3_CH2>,
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 72434529f78e693fe325ad487ba8f4d7819b37ec..7a191195dbd976534313435dfb746f68f6f4517e 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -101,7 +101,8 @@ &edma0 {
 		<GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>, /* gpt0 */
 		<GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>, /* gpt1 */
 		<GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>, /* gpt2 */
-		<GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>; /* gpt3 */
+		<GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>, /* gpt3 */
+		<GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
 	power-domains = <&pd IMX_SC_R_DMA_0_CH0>,
 			<&pd IMX_SC_R_DMA_0_CH1>,
 			<&pd IMX_SC_R_DMA_0_CH2>,
@@ -145,7 +146,8 @@ &edma2 {
 		     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>;
+		     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &edma3 {
@@ -156,7 +158,8 @@ &edma3 {
 		     <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>;
+		     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &flexcan1 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
index c9b55f02497ab6a0c4e3edae7ca9a876c8bd7ce7..7c5386d4ab2b7a9782f9715eae5c497fb9bf75a5 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
@@ -327,7 +327,8 @@ &edma0 {
 		     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>, /* sai2 */
 		     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>, /* sai3 */
 		     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>, /* sai4 */
-		     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>; /* sai5 */
+		     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>, /* sai5 */
+		     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
 	power-domains = <&pd IMX_SC_R_DMA_2_CH0>,
 			<&pd IMX_SC_R_DMA_2_CH1>,
 			<&pd IMX_SC_R_DMA_2_CH2>,
@@ -365,7 +366,8 @@ &edma1 {
 		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>, /* no used */
 		     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>, /* sai6 */
 		     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>; /* sai7 */
+		     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>, /* sai7 */
+		     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
 	power-domains = <&pd IMX_SC_R_DMA_3_CH0>,
 			<&pd IMX_SC_R_DMA_3_CH1>,
 			<&pd IMX_SC_R_DMA_3_CH2>,
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index d4856b8590e0c540d69f8919d3cead8bd7c547ba..5f24850bf322a4de76844709f48a59afbd949cfb 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -99,7 +99,8 @@ &edma2 {
 		     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>;
+		     <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 	power-domains = <&pd IMX_SC_R_DMA_0_CH0>,
 			<&pd IMX_SC_R_DMA_0_CH1>,
 			<&pd IMX_SC_R_DMA_0_CH2>,

-- 
2.34.1


