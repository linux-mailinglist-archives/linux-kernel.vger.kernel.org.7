Return-Path: <linux-kernel+bounces-885839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A50AC34044
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB83B34BAE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6D0284890;
	Wed,  5 Nov 2025 05:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QJOGp7Mt"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BC28000A;
	Wed,  5 Nov 2025 05:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762322093; cv=fail; b=PP5YyPgSXAhPy6vzCPm7bsKHSu4nX9zJ4OHRSNymKhcpIplmIjfhh1pV3CcK+zwMc2K9r5HUdO8o3boHxediBjR7O5dQmN4gDGW2D30TZNZsiGJ+qMRQU/OajEKycwFOZznden5BEOipHBOAXwP2vHjJBtEKM3AGTAC13M5pdUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762322093; c=relaxed/simple;
	bh=dvRJcUubPxIahlw/Pb32xfYO1UjA1BJ6l8KAjhC9O4c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DAH8paoOu6eq+/bQPV7DNxLvHoMGBlOFCztwOUfkH5LH84fzxOaRYh8+asJle4s+jTLyYByZylIrYYmAsp8zVCEgCTq1Oc1EOlSZB6gkbS9VBeXmJVongxhg+ybn+IFFD20hpj4ACCqnFWKW919ueO5rBN2a+XK/Rvy8Hcam9Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QJOGp7Mt; arc=fail smtp.client-ip=52.101.84.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg9SLtw7Oamz/cIMZdN2uYUFNEocslxq6Mhs0JIYGFOCMumcPDcDEoDCgQXJJsqSbGRdbWIpZh3busg52ti9qwhWvV3XUOR5S6kWKsE9ZiBhvcPEtOuGprzhb0You89jbV0LrU1lz2KICY5SfElw3hOHo64cDZjQh7nNBxD10GCMT+b7YeFn7LLb47YDn7DYjy8O5IU4oIvsRRQ9U4O5aOT/oaUO/HTj2kVoR1Aouyrpi79xD0XkL01V35GgrF0EQywWcgDHFd/8VDvfobbLef9luGtchVyruZ/eMCZkDwGDGCebJ4ZwBIH06KDkykP1/PK/CYgZ8+lB3e35SURGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1uoEcFmYQcPQ/DS1P1pnSrsBAyNyn2zxzFRR26tvRA=;
 b=mtfRrGTW0a9YyB23Qe2ctSlVEV0bkJJqWsovHD6UtMf8AlSXCmGrupOi+eZwm23AqVXh0og6oqdQc6K2CWQypTpUwoy7+7B7RkpOJCDF8xHEVmiG2FGOpgP5yWCqFXQf/rqvoFDD70qwG6hqLT95SYOpxJg8EV8yOmrtzwJOMQTX55trLFcicEfQbCiT5kZOd6/5WfdHkBFHHf6ubYc3mKWher2sVgk1v1pWsXxXLvkGPQSEGEPmE4pDa6eOyX4MCzIKYPl8Wdzo9H3Uaee/0Bmt9e29yxsBRLCItOInYPFa90zPsVPEeXgRXzJtvEj6yU6j0zv04MsuaFonLo2R8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1uoEcFmYQcPQ/DS1P1pnSrsBAyNyn2zxzFRR26tvRA=;
 b=QJOGp7MtNaaEkESY8r67fnS4KKGruowprbobBw6oCSkNC+OJCPjWL764T3rbJuOOT/52h78Ljwmzk9GzBQCPf0+bC6o35YawNqItBrQATF4CJe6JMR1lUkkaWc+Al98XYhk+PF4nQuaMbwm43slYxheUr/h2KteCqaUJ9AOehU2T5+3Nf+XsAClj2i66sxmX/qsIElFuYRLJ5RxL0/tNqg+mt2aluz/Shx6XkiMlP3OcDPmQRe5JGlYfTs9F8U9V4fn7jkrhsKo9AbGi0HlMk1SRtNLbF9ZK/WMqccXRCB9OlyHFE4N364uTr1fu+Zv4fk8XvYOuNyenjpnLUGQjNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16)
 by AM8PR04MB8002.eurprd04.prod.outlook.com (2603:10a6:20b:247::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 05:54:49 +0000
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb]) by AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 05:54:49 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Wed, 05 Nov 2025 13:55:10 +0800
Subject: [PATCH v3 1/3] media: dt-bindings: nxp,imx8-isi: Add i.MX95 ISI
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-isi_imx95-v3-1-3987533cca1c@nxp.com>
References: <20251105-isi_imx95-v3-0-3987533cca1c@nxp.com>
In-Reply-To: <20251105-isi_imx95-v3-0-3987533cca1c@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Guoniu Zhou <guoniu.zhou@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762322131; l=1995;
 i=guoniu.zhou@nxp.com; s=20250815; h=from:subject:message-id;
 bh=k6Vv0VkJLpcK9QwbPhlyi+wAF625gNJ9rku2zsgjzpM=;
 b=RPFSfGN79okYtX6DD21G2dU9z/MRgvB8wZuEvDaxvJEj4NQii2wvyj3JtvYdfg8Xc7S6V2XWf
 mEcdoAYiEONDBz0/Dkd15GJTTKZVt7rj+pCaU7vTA+GzewdwRD/PM5A
X-Developer-Key: i=guoniu.zhou@nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AS8PR04MB9080.eurprd04.prod.outlook.com
 (2603:10a6:20b:447::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9080:EE_|AM8PR04MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 44117a0e-878a-49fb-9523-08de1c2fd49a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NVlKK2NlU0QyWmtMK3F3Zk5OdnV5a09qTng1NkNTcXg0YnkraDgrbk1wdHNU?=
 =?utf-8?B?c0pnSGZhaWxRNFVsSTlSbm9JKzZTaUNjYTR0OThCTkthcTdNVG50VmhFZDQw?=
 =?utf-8?B?OFBqOHdkdVNSUmFUeFNPQTRBZmpTQ0JENHo5MVFQU1o1YmRZRTJ2ZlNsWHFh?=
 =?utf-8?B?K2MyTGduUWJaNHJpTmRncmJ3dEVVVm9NQUFEbnJZYU5jb3BFZWlWSlAvOVJy?=
 =?utf-8?B?RCt3ZmxjMTQ5bkd6dFp4Ti9lakplRVphTzUxZC92TG02SkZ2NkluUUR4QUpp?=
 =?utf-8?B?aGZXUmk2WDBzcldmNjd1REc1aE14M1BLSktHUkFWVk9INFZ3QzVDYmdWaDdG?=
 =?utf-8?B?RmtoN2VZNmRDZGtlQmdwK28yVW44bVEyM3J0L2x4VWtOQklwNWsyRjhJN2Fh?=
 =?utf-8?B?RTJ6TkJrUllUWUNmbHBOcG1nQzEwZDkxWlZpT2VKSFJGczdreXJDM1BJUzl3?=
 =?utf-8?B?K005VU9YRDRhdDV0RXdKU0k5ZGlVYVVLc29GcFExTC9hN2Vad2xoeVJEWndW?=
 =?utf-8?B?MXcyWm5FNWZJeXo3V2ltVGFPUTBXcDQ4TklWVEhPVERzWkVtbER1dGhOVys0?=
 =?utf-8?B?alJFbmtTV1RrdXRlOVNLalRObGozWkVBYnVLSEhmWWtjSThYNHJrWnpGWERh?=
 =?utf-8?B?Z2tBY0FGallXRlR3N29LaG8wY0lrVU5hdThUWmlQM2d6bkJaWEQyZTVVQ2sv?=
 =?utf-8?B?QTMxZXV1YkQ1TzNFQ3BlVlMxR1c4VDl6UnFaSkwyWVliYjlxcy9PZjFOd0tM?=
 =?utf-8?B?NUlQTmVpdzdHSVlKejZQRzJaUE96R0plczVjc3kyVDdOdWlqMGlSVEJKVkRB?=
 =?utf-8?B?eksrVUM3ZnZoQ0ltWTRRQVpDamgxTmppaHlaTktHU25LaDhPcGwyeGlHWUpm?=
 =?utf-8?B?RHJaaHF5T2ZMUWZoMk5jN1ZGQjNPK0UvV1hIeW52ViszamNBdkdNWDVzcVVF?=
 =?utf-8?B?VElHcXRiQ1ZUNDhtdHdFdTR1THdxQzFTWXg4UHpSL0dma04wbCs0QWV6QlVE?=
 =?utf-8?B?WjU4cUgwaEJUL1kwZnBPU0llTGpHalViY0dRdjFMaFFQTUJpaDZ4aUVXNExm?=
 =?utf-8?B?UDdZT3dxaGdmWDNtaGNTQkNvTFZoa1BkWUNDVjNYcWFWYWZ5Z0pzemY2Z0pv?=
 =?utf-8?B?UkduekR3VDV3Yi82aTcvVWczVURXZ3BCWUFOWVJQU1BLNE1YRjNZVjRZRGdO?=
 =?utf-8?B?RHkrUlZBMWZUZHBqQWNVTWFYL2lNQ2ZLZW02d3VnRS9OeEVYU1VWSlNZUEhE?=
 =?utf-8?B?ZWpCY25ac3dXeWM2SzBRQTRUM3Nva0VYZC9ScVdKOEpSSUsvVUNJZHJvMGZq?=
 =?utf-8?B?U0lUZEt1cmhUb2E4MFVBZWsrSWJxdDFwOFpSYUp3RnVLUGpLWWtNeUpPdkhO?=
 =?utf-8?B?YzBoa2l2TFQrZzRsN3lFN0NtRWtpK1lNaHlXUjdKbzBka3Byd3BGbURxeFVJ?=
 =?utf-8?B?K3pPU0dZbXlFTHl1Y3ZPYkJJRXI1K3BOQXJYdTdVZGsxc0UvbzBoUnBpUmRD?=
 =?utf-8?B?MExvSGNxV3BkRkFxaGQzNGNGWGUwYytkeWg4RHpyd1J5dmdWR1hSd0pzU0lx?=
 =?utf-8?B?RzhhN294OUdmcU1McVpzeFFHTUI3S0VST3VlWjRhM2kyNDQreTJOUzZkSGI1?=
 =?utf-8?B?cWtmMjR3SVpFQ1BCYWRwMFdMbWdnd2crb0N6bWtsS1VQd3F3M3N5UHBhSStY?=
 =?utf-8?B?QzN0OHdrN2c2WTQrWFUxQWNpWXE1UmZxNTI5VTB6Vkt1RFpwMGVaYk4xMkl6?=
 =?utf-8?B?SHhPQXhSbGo4UE8yclYzdzhKcVVLQzlTMTVORXhSNy9PNjFXdEROdVZhSjR6?=
 =?utf-8?B?VlhadmNjeVkyam9RKzdmN1lta051cGJQUlJKQlkvOGlRblFjbzJvVGM1RFBV?=
 =?utf-8?B?SGpoNDJZakd2ZWFZQlJMN08ySGw4MnFsV0x6ZzBkUllYMlpUZlNIMHRjejFl?=
 =?utf-8?B?TC9VQlNWSFROQVZmL01PSzYyS2RlUkFRSlBOak9qMHNYcktJRUttNmpFVFlD?=
 =?utf-8?B?aTlUbG9GSmpJbW1lRG5YcmU1NU5leGQ5V21Dd2VTcnZVd1FNL09UL0xYSnBX?=
 =?utf-8?B?MkJNdWRXd2FoVzhNd1UrWVFlU3FFUFhKT25sdz09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9080.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NzZDWjJqbVVFVmxvU25tTkJ5MUFDeDJna0hYbmxuQjk4d3VMRHNWMVN3RnJh?=
 =?utf-8?B?ZG9yNzMyK0x3aUtvMmpDOXlpL0lXRzZXZDB5eCtlaUZXSUxRSVh6eVFwNXhk?=
 =?utf-8?B?SmZlMktHWXBSU3dTZjNYUWxsdTFuZXNPRzRscW9YL0dtY2RUUnRZMDAzZFlw?=
 =?utf-8?B?UTZEVTFlYjJYamhQNXhveVFHaDVOdHFXSm0yM2tUamx6QXhZVGxyWlRPK0x3?=
 =?utf-8?B?QUN4NTVWWU5nQ1V2amN4RHZUNTdySEhXQnNjeUF3TW1MSUo2ZEhJcVNpMUdW?=
 =?utf-8?B?U20rQTNoMVQxb1lXY2l6cEl3YjVEMFFWbFV0TVQ3L3RQd1lUQUFuVDBrYlNP?=
 =?utf-8?B?NG4vMm1YZjlPNWNQVTZ1UkV0WmEwTmRiRUV0c050WUp4dkpjTGFwTFd4TmJy?=
 =?utf-8?B?KzRibmtPMnY3N3BYb2ExejgrajdVTzVPVk92SDJYbGpsakJ1TXE2VXdURWdZ?=
 =?utf-8?B?QnNQRVBYUS8vTTZTb2l1L0M1VzVGb1hHQWJxYWhNdE5icU5aNUlrR2l0WWt5?=
 =?utf-8?B?eFU1T2VvS0FBdkNCUGNFMk9SK0hFSEZac3NiRHRTRkJvMG1PSWZudndMZXd2?=
 =?utf-8?B?TStJRytwSkQvQWtJbmkzTk05Sm9zK1RqazJNM0JyWEp2TWJ4Q29lMDVzeENw?=
 =?utf-8?B?akhneWxVSmVEdFFvSnB3aDFHckVPSWhLVTd4VTc4YTVWTXFOaEVEYjhTZ2hU?=
 =?utf-8?B?OXVMRFdhY1poYS93cFQ5bXBZaEZGM2w4MmhWNXloUzUwWi9zTFZyNjlldHNW?=
 =?utf-8?B?NVBrdzdqTld1b3NKT1Y0N2pHSzFxcW5XMkFPU09hMkljajZ4ZUpzYlVzWEpt?=
 =?utf-8?B?WS9wZjZySEJkRmlFOU1KeXArOHJ4OXhqUDl5TXcyTW9qaGlJRTYxTkVVVlNY?=
 =?utf-8?B?SnlsNDN4Z3pMM1JCY3lWVEV4Y3R3S01sNFVzY2g1V2drUEJoZGVWaFp0MzVI?=
 =?utf-8?B?T2U3SU5PNjJGVEx2N2FLQlVJb2RpdXR1NDlWUE44YnhCaXZCOXZmQkUxWHMz?=
 =?utf-8?B?YlRqMnlITEtpcWZDRFBBRnpYcjUrWWphOTVFZWoyRnhCM3d6WUhkWUw1L216?=
 =?utf-8?B?eUhNSDJ1VXl4LzNOcjhCMjlyZkpqUWtpSzFNeHBDb3ZoWE9Qckh0b3p6TWhQ?=
 =?utf-8?B?U1R6VWV2Ty8rRy9sLzdHRzhmNUhPVlJ1VGkrRTcyQ09GUnFMWmRVWXAremd5?=
 =?utf-8?B?WVlDS0VMK0x0SmUra3RoRlVtVW16UFpZSWxoZThZQ0tvSERQaHNBazJMNDkv?=
 =?utf-8?B?RVVzd2xuSkZIQXBrV2taejVnakhYbFRwMjBmM0VZTXdRYllvUXBVK3BJSElr?=
 =?utf-8?B?Z3VYWVZ2ZFBQR054R0J3L0lSdTUyRStxQ0J1Tk1lMFVYMS9Vd2NuQlVnbnN6?=
 =?utf-8?B?cTZhV2lTbG5ERitCTkhQVWQ1djc1NGN2YldXL1dQZFpjQmVaUzZWR0RxTXZv?=
 =?utf-8?B?VXJuSCtERldZckJLQndDVVFvT2VDOU84N083bDc3amFhdGRQblMwRThUS2Mw?=
 =?utf-8?B?eUNEeS8rZCt3dmJ4VFpLOVRUYUlPYkRVcGptZnNNNEtKSHgrSUZBTktWb2FE?=
 =?utf-8?B?Qm01d3p4eU9MQWtveGRLZnllUzRqUEhVcGVUSk5yalVwZEJzNkcwYmR5Um9P?=
 =?utf-8?B?TUZNaVd0RmVIQWlQNkoyUkxvWk01QWhPYmRBbVVCV1FMeVg2MHdIaDRvS21J?=
 =?utf-8?B?MnRtTVFLL2xQMUFNY2xPZytlaVMzdEhJN2NZakVuS3pBNjJGaXQ2SlNlUlhm?=
 =?utf-8?B?MVZ6UnJxTFVHSWE4RHEzbUFwUWRSRjFDcGpLbzF0T2o0RkRTdGRmMVpaaCs5?=
 =?utf-8?B?TEdsS3VSdVJKTjZvbkwzcmVsaXlFSDY0Nm51ZTNkNVd5QVdpWmUxVnFwekpM?=
 =?utf-8?B?OGdhcUZtTDhaZTlkQll3V2dKcDRIbXFDRlNyRnZGUGtOL2dybGdVaUNKdUVu?=
 =?utf-8?B?ekp5MnVxUGdLNzErakIzR1BRR2wzWk1lQVRvMTErKzhBb0hZbXJaYWM3OTFm?=
 =?utf-8?B?Q09yWGVoM0JGeFZUMFYxemVCYmpjWGRmVjkraGR5QS9aQU10N0lCcEZWODZ2?=
 =?utf-8?B?bGxnZ2c4MGlVQVNFM1lFUmt3V01ldVhla1Z4RjFsdFBGdm5sZlZCTE5TRnRW?=
 =?utf-8?Q?3tGRyP2ERqtNoW5/TL4lBIa6k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44117a0e-878a-49fb-9523-08de1c2fd49a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9080.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 05:54:49.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUc2nZYMdQImTU3cL9auy1Fy1LpMLzboMYf5sYjKsxTBT/8i7AL6J/8Ln1Y0TM2/DOTsDA2wTlMtggNhL5LHXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8002

From: Guoniu Zhou <guoniu.zhou@nxp.com>

The ISI module on i.MX95 supports up to eight channels and four link
sources to obtain the image data for processing in its pipelines. It
can process up to eight image sources at the same time.

Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
---
 .../devicetree/bindings/media/nxp,imx8-isi.yaml    | 27 +++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
index f43b91984f0152fbbcf80db3b3bbad7e8ad6c11e..c5cf4a9787ee7f31273bd097d2200402fb346773 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
@@ -23,6 +23,7 @@ properties:
       - fsl,imx8mp-isi
       - fsl,imx8ulp-isi
       - fsl,imx93-isi
+      - fsl,imx95-isi
 
   reg:
     maxItems: 1
@@ -49,7 +50,7 @@ properties:
   interrupts:
     description: Processing pipeline interrupts, one per pipeline
     minItems: 1
-    maxItems: 2
+    maxItems: 8
 
   power-domains:
     maxItems: 1
@@ -98,6 +99,7 @@ allOf:
     then:
       properties:
         interrupts:
+          minItems: 2
           maxItems: 2
         ports:
           properties:
@@ -109,6 +111,29 @@ allOf:
             - port@0
             - port@1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx95-isi
+    then:
+      properties:
+        interrupts:
+          minItems: 8
+        ports:
+          properties:
+            port@0:
+              description: Pixel Link Slave 0
+            port@1:
+              description: Pixel Link Slave 1
+            port@2:
+              description: MIPI CSI-2 RX 0
+            port@3:
+              description: MIPI CSI-2 RX 1
+          required:
+            - port@2
+            - port@3
+
 additionalProperties: false
 
 examples:

-- 
2.34.1


