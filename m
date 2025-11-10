Return-Path: <linux-kernel+bounces-892336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A3C44E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0566A3AA92E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E371DE2AD;
	Mon, 10 Nov 2025 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D72gUCSj"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859538DE1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747368; cv=fail; b=KSKLpEH1rVDqBGs+3Y/uPi2cqPF10UeiHahkaCdT3cMSMIvqHgi2xMtHod6RjufnlPdCvfCd5/d96IuJw6zVwKj0TDa8NkgyoJdqcXSZrc0wlp9ZJduHQ/kBXVgYy4z/hniAy/R2IwVfnoAEJJSwnhjJrZoEUTasy3X9kSmx1qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747368; c=relaxed/simple;
	bh=CSuwAzV9TcCWzT0x7aH5DqCAjyQg+sAuB1L/DtMQUy8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=XQRFBscOk9uyKTafxbasBMEVzyd3iJ1ncp2hrnSX593G8upWUiQ2415qAbMkGb2tGCpFG1Lu9CbnD+az5nIrOOvoHESb8KREJO6hEd9nwC8aP2EViPgqVqME+XvQDCLGwlp2YgL6WmjmsjR5sUpgA+XeQuZXB4dt3ts90zMwo9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D72gUCSj; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+mCNlsEaGFga8yDwDAOIE9FQPA5s39lhW/fKGTQDgC0/9PE0NvkHAQCFTR/szMaCAd9oIGWXXgJj5XmKur5gKEtd83Sjd9BB7CBPUGRCtW+I+EWPmbI5TrRxJ10OkVnrMvKAy+KM9ZoJHcGvTi8pUwNV0DVw8sGKdq/4NoP/iNU6t9hVLgZOHmDAJp1+YyJfaGLSjDHszhxNzIf/r/xRRyHCIwbHyY/9ziu5A9KJwDGe/Ejt3+a3n8YWbZkoFzh0dRRAozF7881TQ0Oc3BYtIH+azjH6BOaQYq00bXorNHPbgiHi8rtjRzRLHW9XCFJT9l+NJ4qna7Ex6HL4biRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epvt4jZOEGyyzmpDaPwDCIFfV0IgcDyC56Pqv0U4vkc=;
 b=virnMsKLwtqQrdcf12Zm7xSwaFL7cYZRjwfQZ7whXV8MOQGhARcDQTRBEqSCaBLOh4xB6z+PunH8V1Lo/V9ndjn25Lc0eZ92KMrD0qjXWJWFVh9xuElVbOVzXVT9xLvYTtgnS/5rURiaNAZ/5f775raKC/hYXiXEjS+RYvnKJAtkqVa3qEtJs1Z1pqtscS5ipUnPMYR34g38Or3wWttHcjYBgAzFtJMsKBQSR+zEoqe+zjyUD2AM0cnLn6Id3nFvjOPaiOA7HZsO6TF+8A0wG5iJ6yKl36yipz0FhlVID5u7A/rBVcj8eeBBjSscqiilBJP2A2zfaGa3k9l33HCZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epvt4jZOEGyyzmpDaPwDCIFfV0IgcDyC56Pqv0U4vkc=;
 b=D72gUCSjGKxhAV1RzxxYzLmDOA0JTvS7Pxd3BQmDtTWDPQUWmyEOMf6BenzEjoJKG4WgLSMObFzebF+xHkkLeXyNuHgqtN07pO47RoXjtdqrKDAPSWfsARHmIzvW76PatXPXYQedethZy/qcAWcqOibBznq0JMnakwow01/F+BsqJ0wletYvHT1DBIx4iEgDdL27KYG5Ub8a/929GvJ2yG+sYDK7duj1chZUXb3g8VIASoWQBS4PpJB+oBHYnF/hssD1GlnFbWI+FYmiu0RzCVe7zw5KS13b4rnw6ZbNdFEVlrsmFyQodzJ1ZMRN8+VSSdi1B8RK9sBpV/JSUvvbnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI0PR04MB10949.eurprd04.prod.outlook.com (2603:10a6:800:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 04:02:43 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 04:02:43 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH 0/4] mtd: spi-nor: micron-st: add die erase for micron spi
 nor chip
Date: Mon, 10 Nov 2025 12:02:55 +0800
Message-Id: <20251110-nor-v1-0-cde50c81db05@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO9jEWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwNz3bz8Il0Lk7RUA/PUZGNjM2MloMqCotS0zAqwKdGxtbUAyeoxkFU
 AAAA=
X-Change-ID: 20251107-nor-84fe07ec3363
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762747415; l=1068;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=CSuwAzV9TcCWzT0x7aH5DqCAjyQg+sAuB1L/DtMQUy8=;
 b=Rg9OM/Ncf1kmtp++E174ZV6nZI3CVRmPOkeHOQ6O9YJ8VRsmqnqvTOGB+s0jIhGZmXq0TyouB
 dxzz3WWR8DcAxh+8bsOVFxmeJwe+CV9NsGKq8AyAsVEtKqSOYcjRAul
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|VI0PR04MB10949:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf445fd-cd9d-4e76-0bda-08de200dff0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGtLeWpKeUFiMmFVdUlScHhuT1ppWnNvcVhMMWo5SUdxcUN2SHJodHo1K0lK?=
 =?utf-8?B?bi8vVGcvU1ZKdllhMmdpMFZmMjdEK3h5QWRscU9OeXdrL3VoNXNGMkMyR3FP?=
 =?utf-8?B?WkwwcFI4UzdUZjdVNVVtckRxVmxWWVpOVEkrUHZJSUtNS1NSR2VNbmZ6RDBh?=
 =?utf-8?B?VFpkY1paVjMyUHhUbXZQMlNrTVNqcGVmbUt4ZWliYk5EWlNCZm1JT0NiZ2lN?=
 =?utf-8?B?anpsMW9Nb1gvOW9paEJ3TWMvOHJmTHhlemFNZG4xZGM0NVlmd2ZvWUQycXEz?=
 =?utf-8?B?Unl4RzZ1UmpWTWZKbXVVUHVvY2ZnOThwT04zODAxZ3ZoY1lIN21pNDZjYkdH?=
 =?utf-8?B?NTNhTzNpNWFJaWhhUU1tdThaVy9RT0ZjZGVaTSttcFNSNFFWRDVseXJUdG5i?=
 =?utf-8?B?L0Nobk5zeE1QcXZ6czhNYXBXOTZjbUxFTUt6a2hYUzY0dUsxN1JxWkJPNGVk?=
 =?utf-8?B?aXdHMUdkRHV2VWV3Z0s4cUJ3SEtLcVFLbHRGcG1ENHBUSVYxQmVHOUpPcmtv?=
 =?utf-8?B?NjA4dGxHTlhobWdubUZXKytZbHBIa0FXUVRHaUQ1c2hPQVJRTHNpOHIza2lU?=
 =?utf-8?B?THlIbDlZV0ZGR3o1ZVh0NjlIcmhZcmo2VDQ5TFFzWHdCaGM1bzN5ZXlwQlJz?=
 =?utf-8?B?YTRTMDk0cGNHamlNM1h0R1JiNmJZalpBUWEvQS81SUV3dTNaYmU3VXhpcFcr?=
 =?utf-8?B?MVlvb1l1Wk02c25LR2lUNUh3VFdhR2c3SGM5aEgySFp0ZlM2OGQ0U1pTWDhr?=
 =?utf-8?B?NWVGR1BOVmdMdGhENEpUckxBMUp4bkFXQ3RuU0VWUEVPb1BOaENORGR0Rjd4?=
 =?utf-8?B?eDRhVXZod2M4M0c1d3FiRm1yTkxPYS84cUNvNGxHRTZHSWNUR1NpeVk0TzBo?=
 =?utf-8?B?S3JmTm80OFl1SkVYRWtEdWkzY0lLZmJiZVVZZzZDcFp2bklnUy9maG9uOFJD?=
 =?utf-8?B?YlphZGlWZm4xcCsxTmoxWUtPQ2phU1FlZEpRUW94ME9Fd0M5emVUSzhBcnpw?=
 =?utf-8?B?U3BHR2tZQ0Z6ZTdwYldEd0hGS3NVLzZVTkt3M2hUK1djdWNqQnUxVUt0VlpO?=
 =?utf-8?B?ckFPd0IxWS9VL1R1YU04RlJKeGUySzBWTGtGN2Z0dWJZRlVib2lZTlByanFG?=
 =?utf-8?B?c2hhd1lIL2FWb01teC9GUVZoMHRpL2hxd2NURnRnbllGMEtLSDlHRTV1ZmQw?=
 =?utf-8?B?cGUyODhFTko1OWFORWxKTnh4bENRQ2hTdUNmV0JUQ1RLVko0N1VRUnJsZjJs?=
 =?utf-8?B?Y0V3VGV6RTZTRmhFdlFhU1l4cWZlR0ZUSUt2Rm9Yb2l5dlY2U1ZuTjhmVHNp?=
 =?utf-8?B?YnJNWXIvNURGNnRzZk5yckM2ejg4L1dKMmtxT3FQa3ROck1taDQrWEVBRmRk?=
 =?utf-8?B?djViMlA3b2NrSjFoZmVVb1Yrbi8ySU4vRUZEOXpaaTRlTXlGZUp4bitFRzRD?=
 =?utf-8?B?N1FVRnQ3U1VUY0xiOTZVSDh0alE5VHoxRW1MbmRjdFBjdytTR2tQRVJiVjcv?=
 =?utf-8?B?YnJ5N0V0SGJQelY3VlQrdDluVmZxTW8xODRmWkkrblY1eWdFTkI0b3BTZUpY?=
 =?utf-8?B?K0pWRkZmdkdwSUZ5NXg2UUpFeG12NFJGeStaMWVBNTUxakFiQjJqeFY1ejM4?=
 =?utf-8?B?aTBKa052NDRFbFhDWTJTNnYxcFhWZlZCQUF5a1pCazkyRWh6WmxIeTRjM25h?=
 =?utf-8?B?OGVXRFRnRmg1WFZTMktoRkdScXFvOUlTcGh1L0hBdzdXKzFCa1R4a1lOdVdi?=
 =?utf-8?B?emhSQmRUNmtlWGNRUFcvZXYxdDJYT2EzY1orYTF4SDB1OFNjSnMxMUFGOVNx?=
 =?utf-8?B?SnZRelZGd0p5Ri9BSytkZFpHU3VTeDE3SVpqcXcvWUVxVjI0MU9BUkpUb013?=
 =?utf-8?B?SHMxN28zdFJuMllhU3dQd3Z3cXVkWXlwQTJrQUk1U043SkN6T3Vud1ZZQVhm?=
 =?utf-8?Q?kSXXx95u/RavzHW5Ce3Mk5c0Cm5adgbJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk9wVE5sYjRvR0FJajdsMlQ5RTBvVU0zd0szeGVET1VLeUlUdzZhYzZ0MmpC?=
 =?utf-8?B?dVFaME5GTXZEa3dFbWlpMEI2VnZkSE5mVW9ra1NPK29zOExVdktobmtPRnpR?=
 =?utf-8?B?MTkwbFN3UUJjcUc5MHlpcTlCUEM0bTZlMkNiWlJmRzYrN3NqbFRLS01VZmxQ?=
 =?utf-8?B?UklDYUE1bGFnWlovNndBd1hYc1Vkb0VjZVZwN3lYR1NDdVRnbXZvSHVTbmpU?=
 =?utf-8?B?MDd4S0tqM3d0ZDA3WCtTYVBhVGgwUTNqS0x4Y2p3TkNDdGhxdDJrakpRSmdK?=
 =?utf-8?B?R0wrVlB5V0pKRm1sL1ZwV1ErQzdraWJTRFpEcGVJbC9Jcjd6cEpLbW9TeGh6?=
 =?utf-8?B?dmN5ZHBXMG0zVmNJeVFIQ3dxdjBoZkFzR0RXNlhVK0l3M2VBYnJsNFJ6b1pw?=
 =?utf-8?B?ZFhBcHlyZHlaaWdqM3FQYldkd0Rqa1BTeHE1V3Q4QU52MkVlQ1JXRlNrRUVp?=
 =?utf-8?B?OGhHWmRUV0hWZ2YvQXBTSFNKbUpMblJTZ2dZOThocFlaT2x5RnFLUHRVS0Zw?=
 =?utf-8?B?ekx6aEIxWWRCRU1mcitybG94OE8xRzJCVmVWOVcvZythU3c4MEwzbDhSdm9C?=
 =?utf-8?B?UGU5cWVtSVdXaTEyMXVPUkJlWFp1ZUZNTitDcE02clRISFZVb0hCcVd0SGR4?=
 =?utf-8?B?SFk3Q0cwcytreUlyOFB1Mnkzd0psRXBJVDBQNTNRblZBWGJyNi9CUEZhblBS?=
 =?utf-8?B?VWx5bStLcWVqQmc1ZW00Uzd3VHpaSkwzMFBJeXVHRmZuS1R6WjAvOG1zUWVn?=
 =?utf-8?B?aGpXWTM5cy8ySTBVeGtmUkxGNzZ6cHppdElxVUtmaWRnZWV4NmF0MGJYT3J3?=
 =?utf-8?B?WGJ0eTVEMkhxRDJQWGhKVDFsMDg4eG9CSDNDMDFvVm5NQ2xLajlPcTNZdUZo?=
 =?utf-8?B?L1NPUUJFY3NJZitjTjUreGhWbTYxUEo5UlRDUGdVbmVTeVF6TkwxYjJ3UUNU?=
 =?utf-8?B?enVQR3B5bDV6Q2dRcS9TMzNEQ3V4WllVdVBPUFZBTUQxNUtMVGtBQ2NRUnhn?=
 =?utf-8?B?NmUrbVFaVEpEcTFFdkFERll1aGh2VHNpaE9NVW8rbGkwUnFqYlRERkdBc2Ft?=
 =?utf-8?B?VVRvZ3FkcFJNUFpuY3JGeFlZNENRWUJLZUhkbjlzaVFtZnZ3VnFiQk1lNEZu?=
 =?utf-8?B?cG5vS1pKOGlaYXUrU2UzWlVFT0t4YjA1QzFuQU9wV25DU1grVVdhK1FtNnk1?=
 =?utf-8?B?QnI1cGhrSDd6WFhIUXJBNzFXZ0xkbWM4MFUraFRNRmdBcW0rM3VZeGdZbjE3?=
 =?utf-8?B?UTJvVk00UERxZ2NIMTNoR2dwcnNBajZDaGRic1Rib1U2cDVzSVNGVzdSUFlH?=
 =?utf-8?B?T0xZOWVIMHJ1TTZNWTI2VjllRFRuc3dwVzhZaDZxTCtLODl1MjNYVkxPeFAv?=
 =?utf-8?B?MmNhWTk3cGlhck1QWWI3UG40SGFVRndjZkcweVphRGdNeTdmRlhHMC8vQlVE?=
 =?utf-8?B?dWFicDhFQjVhNlZZV2pXNzNMQzhUTXJUZnAwNjl6b2JnOXgzWUM2dnF1YlVy?=
 =?utf-8?B?Qk9mYjFob2syNkdpZEkraS9iWE1mZjdnSFhwWWlLMTA3RHRnOXo3VVZ5R2Vx?=
 =?utf-8?B?b1hndWZNR1U1VFJNL0o2eXJ0bmQ2bGRpZmhqSkxjM2F1S2hZd3BiaSt0RkRZ?=
 =?utf-8?B?OVRFeVh2T1UwTkxUcWp3dElNSE5pZmdWYjQvYkFiWkwvd1R0bE9LK1k5TGJm?=
 =?utf-8?B?eTk5SU1XWVo2L3RIc2o4Zjgxay8xUFBCZERHNDV2OTZ5MlByaE93M1Qxc3Z6?=
 =?utf-8?B?UHJmOGVrSzh0Z3JQblZZQzNjVENXd2lkcFVjTks3OVZqVXN2SDBLVnQ4cWNB?=
 =?utf-8?B?c2tWdjBrT0RoOWN2RXpoUVdnbFpFUEtWOG10NWk0OXFELzkzbjI5cEVKZzhN?=
 =?utf-8?B?MFBXTUdaaEJuYXhEQ0tESXJjbmVoMzhpaGhFZVZUMm9XMnBFMlV4c09hZmJF?=
 =?utf-8?B?MWJzNS9TTmpuak9xUmlweWM0ZCtweDFoYlFiQVIxSTJXRy9RQ1hUbTEveTJq?=
 =?utf-8?B?eGJIWWJwKytvd2dYYmM5bzgzM25oRmpDM0h4S1AxSXlIQnM1WEJIQjQyRUNi?=
 =?utf-8?B?S1R2MUxTSCtaQlFoOW5wYk1HSk5NakF3M0lTRWFUQ1RFN3VuN3R4S3ZZV3Fx?=
 =?utf-8?Q?WfsQlP4s0+BXo+7zpb7FhiKTL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf445fd-cd9d-4e76-0bda-08de200dff0c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 04:02:42.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HjTBaklxYv+HkCZy11ADY2x5ksBzkCKxi+Wmn4pz4cXuZS5/oNpgeTPLFjpkG6Isnrji+CbK0KVKxYlBTEYiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10949

mt35xu02gcba, mt35xu01gbba and mt35xu512aba are similar, but with
different number of dies. According to the datasheet:
https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
these chips all support die erase command, but do not support chip
erase. So change the drivers accordingly.
Also add mt35xu01gbba support here, test this chip on imx95-19x19-evk
board, it works under 200MHz at 8D-8D-8D mode.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Haibo Chen (4):
      mtd: spi-nor: micron-st: rename the die_late_init functions
      mtd: spi-nor: micron-st: add die erase for mt35xu512aba
      mtd: spi-nor: micron-st: add mt35xu01gbba support
      mtd: spi-nor: micron-st: enable 8D-8D-8D mode and die erase for mt35xu02gcba

 drivers/mtd/spi-nor/micron-st.c | 114 +++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 37 deletions(-)
---
base-commit: 9c0826a5d9aa4d52206dd89976858457a2a8a7ed
change-id: 20251107-nor-84fe07ec3363

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


