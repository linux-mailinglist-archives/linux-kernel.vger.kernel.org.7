Return-Path: <linux-kernel+bounces-896590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 837E0C50BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0904E34C1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAA52E336E;
	Wed, 12 Nov 2025 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f7OBgP8V"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA51F2DCC03
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929380; cv=fail; b=tZjP7jvLuFKu+0vt5yRcYpVKaQjmBKukfg97S3aGeWCQh4hQgfryUU+2Y+XR6i2RXQRQsXLG8sgj+pr1WL8BN56SzwZzntT6ttz8BFcc4v9+q1pGT9+kOacPEGr9Gvl34QmvjX9DEqrtTqbbZYNm8q3oL5eg5O6ivXWlQfcWnwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929380; c=relaxed/simple;
	bh=9z04Ep0G5ElhiVUuj0x/xZiFASLE/QZ1KwvnBGySPBQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hdt0O6AkvZVaUgBcWowDWg/B5K4/VRPHDnKLFAiWY1qqwvx2x3FKAqMhIOG6LQ4nDZT4PCKtYYDeq/aV3Yy7EAXI+oRqqdtxhhfx1k+Y+8UHmIfMcsjpAmuN3SSwn6mJMMFsApauW2+ojMPmGCbEM8nt9+xNOAM/GL0Zpl7b9LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f7OBgP8V; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5Ff2hzLaGo1plUXqGf5+8p9hEasBnVHftTY42qmQfWQb65eGlUsK4pkTUWbDGlk1mTUnvRHhWD5sBtL/6wl5KYLbxkJdan/1IRTZePL8UvWNsL1Cg1ROQK5t5vTRcOD7TfRQKApgyNBUUenDYWupMR1jkDncZ5g+CbySse107c29sR2baMwVwC+kVBzjbObyho5j9Kh27qUZ5r0bkPgoPcHf9J9bDYY7Ylsj0gzWo6F09jYSSvQ1spjxQ4Xe53qS3M4/geotlNYI2dM4pS0inSreuHCy4BphFl64cJQMjngm9tugpQ+o2Lndv2bFkoZfUHldrNEodkNxRhh59aAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RunJnqTqTUPygsSQzMHiAbCecp0YEtqYme/+VgtNSXY=;
 b=mkLXNM0yxf9DKQcFA2XQ3KST0gca52beb5CycMxBKRFMGT7oOySq76/Qt8MZs345CPTa9S+txCvv4el0qfpUSaUX6k++G0KGSVg3lpql4QWnBkFuXwsenhTOiuhZNE0/abK8imwOVCkHK+G0OrCvgONYG748F7IlOjEamitON0FFgLV2GJwZuxi86vD792qkazqSLTscfeCFfVanMQPM75LqyWGa0nsZEnR26JCcwfjuBar0+5X/sLl5KGWQlNakyjusj/FiAXQbff/vPaYmY4eTcNn03gNXFLQLVfM9CNpChOAAJfjWcV3vxNs9C79L6Vo0p1S1h4yFrboaSCcgxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RunJnqTqTUPygsSQzMHiAbCecp0YEtqYme/+VgtNSXY=;
 b=f7OBgP8VJm7wZYxsy3FwI0q5g3UvifLxkCdznzr2allMgAt447BRLEb9qJifE1Eh+RWSTx97Y+KLnXuhrYMk1xzwyINPRDEBN5zro9wphZIH4Henu1rflPiMw42CuiTUELQdDIpwNZOESO8SdL7ahGvms+/JN6XD2O+dMLg95BT3YD4Y/8f9sn0+qA3O8p8ey0eE4XtxV98ighNtacS6TfrmtGn9d14NFe8Y3u+iVFzEfhSzTizK7Th6VIPkiLfmhQgezQxoEn4q+Z7WHSfjpM6BIrES1INgP6j/ygYaWhkZ8TE5vKlwOooDihvMdC+IVdMZcm9edLc2vYA7jnhJ1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DB9PR04MB8187.eurprd04.prod.outlook.com (2603:10a6:10:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 06:36:15 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 06:36:15 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 12 Nov 2025 14:36:21 +0800
Subject: [PATCH v2 3/5] mtd: spi-nor: micron-st: use SFDP of mt35xu512aba
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-nor-v2-3-8699383714b9@nxp.com>
References: <20251112-nor-v2-0-8699383714b9@nxp.com>
In-Reply-To: <20251112-nor-v2-0-8699383714b9@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762929419; l=6839;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=9z04Ep0G5ElhiVUuj0x/xZiFASLE/QZ1KwvnBGySPBQ=;
 b=TMUlhO3TJMhEP2wb8AJPc1Bhkst64PECLFbcihAHh/rMgzikNAJgiKagf4Ita5hPAIbljyT8w
 6EeQobrKM8JB0VOSYaUMXwItk8EnTH4J4XMI4w/WX8kzaL0Rr+bGwBX
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|DB9PR04MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d710171-c1bd-4d77-6ebb-08de21b5c764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elBwRkNSUEcwbWJyeE1sdGFpVklJT2JheHdqNVBDaWs1bi9zR1hYZytwRFV0?=
 =?utf-8?B?NU9YbUJkdDJoTnZXazMzNDZndmpNdWdpRmoyaDRtQjlWTE9zZUZQK2psay96?=
 =?utf-8?B?RVM1T2FHb3ZuMGdCVmcrZ0lCMTA3eHNSRGFsNzFPSW1qbDdMbVVzc2dneWlW?=
 =?utf-8?B?alFiQzN6RUExN21mS3QwNHdCRTNNWkFTdk5JVDVPS2VibXJHcGhDT1NvZlJH?=
 =?utf-8?B?TGZRNUFmbCtpaHQ3THZsNVpQR3VSa3RFcjkrbU91NHkyR1lWUXBrU1BqdUNz?=
 =?utf-8?B?MUpTb3pEMjREbnRLRW1udzBlRXZ1SGpmRUhIQWlEcTgyKy9SNDFidGNtVzFw?=
 =?utf-8?B?Ym9uTVo5NkRHazZ0dVhBTSs1bkxvczVUTTgwOG9DbEtxOGNlYVlGR3BaS1Fn?=
 =?utf-8?B?STF4aVdhZStOdlZWNTVsbjBiOE9jQ0sxNmEwSXM5ZGR1dXVMc0I4TUlCT2R3?=
 =?utf-8?B?V1NrZmlHRWFVV3JRK0RTaWdJdit3OUdIRWFiaU5ZSTZzUThOeXFOM29NZDVO?=
 =?utf-8?B?dmxxWmlmS2pzd1dxU0FpTDV4MkYvYTJYMnRwdExHZ1FBTnRxdFJzVlc3MFBh?=
 =?utf-8?B?b3lyLzV5N054VG1NRWVQSkgrcUFteDRTckVLWmpTeXBrN1pPTWRhWlBqNFF5?=
 =?utf-8?B?U2c0eUVBL2NzUDdGT2pKRmM4RHRWSzcrUytyQlZVMzdScDlGWlZpdjVXK0lr?=
 =?utf-8?B?VEJXZWJvV28yMlU3WlR5dVZFbEcweXQxQ1JZdGx3VzlGeU1GUWVJTmh2SVlJ?=
 =?utf-8?B?UFVhaWo5QW1GQncxTUVGWnVhZmFNckUxYnd5RC9FYXJ3b3V5Q05vZ0txdTZz?=
 =?utf-8?B?aE15Yi9yR0I5QWtNT3A3bjNPQ2UxWnBMcnVOMTk0N3dqT0JxSW5HOXVmZVNt?=
 =?utf-8?B?SGtzREJXK0xuZVVwd1dBZStKWS9TNHc3NGY5Q3pmckZmOXM0d2ZySnJIb1o5?=
 =?utf-8?B?djlEemdQNnRhL0JlZGJXMkFPVHhYYnlsZXc0dlk1YXlQeEdZdmlwaTRCVlhR?=
 =?utf-8?B?NTdMQnZxYzNnZ1dqS0dWOVJOMUVRK3BxNXUxYk9EWFBCRWJiOWlrVzBPM1JF?=
 =?utf-8?B?NGhnSjIwMnlaVHZUQ0t1WWxsditHZjZFV0x4R2ZHaGRnSVA2WHBUbG1xMm9V?=
 =?utf-8?B?NXNsOG9oOWZ3L3Q2K3owdVJGd0xlcmxVTDE2cHNiWkZmazI5MVRVU0hkR3Vq?=
 =?utf-8?B?RmhmeFhERFk0Z1Jqdkp2S1E1L2JYZzF3dk81Y1pjOUMwaWYxSzlLb1IzTU1z?=
 =?utf-8?B?N0dYK3U3ZmI4NnhaZW4wSDlNbWtyUjNQZ2lZOVhoY2UzanpjZ1hOUU1pZFpz?=
 =?utf-8?B?dkhlYTJ3bG9IUkNrdzd5Y2dyR0xIU0RvaG1aSmVjTlloSFIzS3ZQaVZycHUw?=
 =?utf-8?B?WGRhTmRHcVNCR0JvdDJXK2tIMDExNW9oS2oxRXNTeUhqczFTVThhV3Rtd3Rt?=
 =?utf-8?B?azBpMTNiNUpPSmo4N1FPSzNMdWVqbHAxTDY3QUpqZ1o3L21HR0FhYm1MMG9o?=
 =?utf-8?B?VWExdzdBQzhFbmtxSVI0cWFGYVBucmFyY0x1U1BBc1NzZ2w3VXE2U25EV2Vu?=
 =?utf-8?B?bGVYMjFNNStaYVUzeGZxclY3dnowNFlhQUtRWXpIenpxUVBKSzlqSWlVUnRM?=
 =?utf-8?B?YTlWbXRmR044OW5Kd2tUYkNVVWl5ZnVnYWNpNVJWSUtISE9tV3pmVFpLemcx?=
 =?utf-8?B?TDdGTE82SVdsa3RRbWo3MTV0NS9xUzNVT2xSMEN3NFN2MUxWZjBNbHpQVXJj?=
 =?utf-8?B?NThYVUg1OHBMOXg3UEZkTTBqZGQ4M2hLT3hBK0k2YUlOYWN4cXNiWnE3SVEz?=
 =?utf-8?B?ZDZzSElJb2hrbXBnbUxVRk9xN212bjhkaGxiOWhVR1JyNG5NdDZIeGU2R0Zz?=
 =?utf-8?B?d3lISlJqdUpHTVEzRDZ3TUp0VXg0U2t5RkNDTnM1aXZxOFlhNU02R0k0dFNU?=
 =?utf-8?B?NEJ6UkpDd05hRno5eHNQQUFCdmZLVU1ickhKSTFaekxPTFJiSVVlTjNodkZq?=
 =?utf-8?B?Z3BBYTVHRms5VUxaR3hSVWhiU2ZOYkRORzBndXBRNU0yUkxOSGpQSU8xNzVt?=
 =?utf-8?Q?pjZsAS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0Ftakl2SDF5VE1FbE05KzRjRXA4Z3pvTU0xQ1NxZWQ1M2t4bGc5RzlWdm8z?=
 =?utf-8?B?YnZOcjEwZDNZN2tWTW9sQ3pGdk9tM3dEZ2QvZG9BRGN5UElLcCtaRzVtOTBY?=
 =?utf-8?B?VEpjUzc4Smlwai9vRjRUK0Z5YTVWWFhIL0tyYmx2aXNCclhQR1FzRlZDWmJz?=
 =?utf-8?B?S1pYcStwK09iU2FkaVFOR0o0aXUxS1ZRM09aZ2JEMjFWQ1FhV1ZRcFhtZW9Y?=
 =?utf-8?B?VWZlQ0k3dmpLMk55cEl5T091ejlQL05mLzhkck80TmZreGdVNTB4NDBmTi9l?=
 =?utf-8?B?TnFvY0UwNDZIaXpNdnRjekJhRFZuRnpIWW1jQ2M4SVhRK3Y5SUNkcUNEejM1?=
 =?utf-8?B?Vk9PUiszMnhoT0hQNWRmaEl6bFFYbDlNYzd6TVNFUzhHZjBaa3NORlYzRWpj?=
 =?utf-8?B?QWZEaUI5Tnk4R1lXODJjT01vZ2l1U0xTbWp1TGEyMmtvK2tRcGpSRm5tSGVy?=
 =?utf-8?B?RUZHYnRpa1RBbHpkcTJGL1JhWGVNZk1oekUrZjl1ZjgxOEJVWmFsVnFnalZC?=
 =?utf-8?B?eXVVcWtFVGJ3d20xV2hDWWJlTTJ5VlgxWTNnUmFudDhyQXlGRTZxRVdocDBI?=
 =?utf-8?B?RXJtV0ZRYWV0NUZEMENOZENtN0l4QjZmRVZZNUhsYTg0ejk1cU9LeHYwNDJB?=
 =?utf-8?B?dFhEYnV0N0IrUUJ3MFlBbVducHZpNmlhNjZ1bW5DZnArNWFZVFcveEVGVjk5?=
 =?utf-8?B?K2w5aGl0QStUY1ZBNEcrNHluWVIyNm9QR2xkbUVDaVFkTllJc2dScWUrcml4?=
 =?utf-8?B?VndKc3oxbGNOUGpJOVBvWEZ1blhadng4a1RGU2F2S1hGWlQvbnd4WWtxWnls?=
 =?utf-8?B?dGZwVzVjT0N1bHZ5L0RwUkdVZElIVjV3ZXR1bWlmRGI2QWg1cVdib25JRlFt?=
 =?utf-8?B?a0toQ1dLR0xZa3czUHF3VTRycmJQTUlCOFVRYng2dXZHRzA1SWcxNDJDMjVp?=
 =?utf-8?B?KzIxQjRJRDhLN1BaWHlscWh5bXlSNGF0bzBMaGpsS2M3MnFNSG04T2M4cnZB?=
 =?utf-8?B?SlZkUFJvU0g3ekt4T1JxZm5COTRTSjFLTzlhRnNjY3pCOTltZkFObzV0UlZZ?=
 =?utf-8?B?dndDTHRiNGcvV2piY3RUQWNFZmRNdWpaNk1aYlB6RXVPd1haSUZnV3VmamJQ?=
 =?utf-8?B?VG40UzBJRnhjeVhrQjU5NWZhRmpKUXR2RTZxOG1sODFYRFNrNXBkQk4xU3BG?=
 =?utf-8?B?N0FTL3EvMFZhLzZrRzNSanM4U0Y3RnB0bGJNdDR6dWMxTGlhajVJY2xlSFo4?=
 =?utf-8?B?U1V0Y25STGdjSmlReEdXdEhPb25sOW0vb0xZcmhianRzRXlNcEJ5VUV2VDR1?=
 =?utf-8?B?T0pML0V6WW0xYnV1ZHFST2Y2SG9oR0RLK2VOREZnUE0zcGUxeHA5M3pWaHE2?=
 =?utf-8?B?M1pYd1dlQ2NSSWEwVkIvNUlDa05Rc3pKaXZwcnBnRHRxK1Mrbk8rbFNIdGp1?=
 =?utf-8?B?bHFtRzVKdERDTU5MY3F4QldmcmRCMlcyTSt2ZXdOcXp3VmorT0UyS2RFRlNl?=
 =?utf-8?B?WE1uOEE3MDkxRnA1eUYwTTZXWmI5MVo4TjlXU1owSGlyRnhPUG9Wb0M3TW9Z?=
 =?utf-8?B?UWpSajd0R2RwSmIzL3RuZk93YmpYUFBLaWk3TzJ3WVBxTlZIS1NmcGFnYUxH?=
 =?utf-8?B?NHA5dktNMk1pRDFPaCtjYWVkNXppOWFzNVBMdmJNZmVzWmpxWERwRTBzdUNT?=
 =?utf-8?B?czFhZG1oZENwM3htTHo2em1nWDFkUmZTMnJnYngxbFFMM2w0b1M4dlZvdnVR?=
 =?utf-8?B?c1d0MVV2aVQzTzVMejQ1RDBVRXRqM3Q0T3NxaUlBYURvWHJTRVpwN3dlUnY3?=
 =?utf-8?B?M2ttL1hqVzl4bHhzOWw5cVFvbDFCSlVWNXh0QnFKOVk4cWVVaC9Ea0k3cWdK?=
 =?utf-8?B?QmpMcks1cm9PRDlUTUtSWU00MEtZRzVqNTQ2TWx3TElLZmgvN3pnU1NmSEhw?=
 =?utf-8?B?UTZFcW9RVDVaYk1HRm9CblBjaG16OVRLUFNaSjhCNkVONVk3QURKdGYyRGVt?=
 =?utf-8?B?Z05jNWdQdGx3cncyNEtNWURTTXByZ1B4OThZeHZKR1B2R3FKd29jb3hDSEFI?=
 =?utf-8?B?Y25MR2l2MVp2MFdnMk54U2x0QWtzMkhHdGVlK2R1MTR2Mk1saStZZU43bGs0?=
 =?utf-8?Q?dCmhIbLtTq3CMJI/YmBNUnSqL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d710171-c1bd-4d77-6ebb-08de21b5c764
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:36:15.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qGjPJWx3WceaWqPWAq0AhlYpFO79ty9pX4P4NI2Ezuw/dfxErqMmIh/c/QtFXaaoPOWeYfVPYENktVvSpYdQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8187

mt35xu512aba has SFDP, already contain the necessary
information, so remove size and some flags here.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

---
1) This mt35xu512aba is populated on the imx943-evk board, was
   tested at 200MHz using nxp,imx94-xspi SPI controller.
2) root@imx943evk:~# cat /sys/bus/spi/devices/spi8.0/spi-nor/jedec_id
   2c5b1a
   root@imx943evk:~# cat /sys/bus/spi/devices/spi8.0/spi-nor/manufacturer
   micron
   root@imx943evk:~# hexdump -Cv /sys/bus/spi/devices/spi8.0/spi-nor/sfdp
   00000000  53 46 44 50 0a 01 03 ff  00 08 01 17 30 00 00 ff  |SFDP........0...|
   00000010  84 00 01 02 90 00 00 ff  05 01 01 06 a0 00 00 ff  |................|
   00000020  0a 00 01 08 b0 00 00 ff  ff ff ff ff ff ff ff ff  |................|
   00000030  e5 20 8a ff ff ff ff 1f  00 00 00 00 00 00 00 00  |. ..............|
   00000040  ee ff ff ff ff ff 00 00  ff ff 00 00 0c 20 11 d8  |............. ..|
   00000050  0f 52 00 00 39 61 99 00  87 8e 03 d3 ac a1 27 3d  |.R..9a........'=|
   00000060  7a 75 7a 75 fb bd d5 5c  00 00 70 ff 81 50 f8 a1  |zuzu...\..p..P..|
   00000070  2f cb 27 8b 00 00 04 01  00 06 01 00 ff ff ff 8e  |/.'.............|
   00000080  00 00 00 00 00 00 00 00  00 00 00 00 ff ff ff ff  |................|
   00000090  43 0e ff ff 21 dc 5c ff  ff ff ff ff ff ff ff ff  |C...!.\.........|
   000000a0  00 0b 80 9e b1 81 b5 85  00 f0 ff 9f 00 0a 00 00  |................|
   000000b0  00 0a 1a 88 10 00 00 00  ff ff ff ff ff ff ff ff  |................|
   000000c0  00 00 06 01 00 00 00 00  14 01 81 03 00 00 00 00  |................|
   000000d0
   root@imx943evk:~# sha256sum /sys/bus/spi/devices/spi8.0/spi-nor/sfdp
   809cbdfc57ae56771e017ff7bfdae7122afcbcbb238f2502420cfe3b2fe20d11  /sys/bus/spi/devices/spi8.0/spi-nor/sfdp
3) root@imx943evk:~# cat /sys/kernel/debug/spi-nor/spi8.0/capabilities
   Supported read modes by the flash
    1S-1S-1S
     opcode        0x13
     mode cycles   0
     dummy cycles  0
    1S-1S-8S
     opcode        0x7c
     mode cycles   1
     dummy cycles  7
    1S-8S-8S
     opcode        0xcc
     mode cycles   1
     dummy cycles  15
    8D-8D-8D
     opcode        0xfd
     mode cycles   0
     dummy cycles  20

   Supported page program modes by the flash
    1S-1S-1S
     opcode        0x12
     8D-8D-8D
     opcode        0x12

   root@imx943evk:~# cat /sys/kernel/debug/spi-nor/spi8.0/params
   name            (null)
   id              2c 5b 1a 10 41 00
   size            64.0 MiB
   write size      1
   page size       256
   address nbytes  4
   flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET

   opcodes
    read           0xfd
      dummy cycles  20
    erase          0xdc
    program        0x12
    8D extension   repeat

   protocols
    read           8D-8D-8D
    write          8D-8D-8D
    register       8D-8D-8D

   erase commands
    21 (4.00 KiB) [1]
    5c (32.0 KiB) [2]
    dc (128 KiB) [3]
    c7 (64.0 MiB)

   sector map
    region (in hex)   | erase mask | overlaid
    ------------------+------------+----------
    00000000-03ffffff |     [   3] | no
4) root@imx943evk:~# dd if=/dev/urandom of=./spi_test bs=1M count=2
   2+0 records in
   2+0 records out
   2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.0213893 s, 98.0 MB/s
   root@imx943evk:~# mtd_debug erase /dev/mtd0 0 2097152
   Erased 2097152 bytes from address 0x00000000 in flash
   root@imx943evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx943evk:~# hexdump spi_read
   0000000 ffff ffff ffff ffff ffff ffff ffff ffff
   *
   0200000
   root@imx943evk:~# sha256sum spi_read
   4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
   root@imx943evk:~# mtd_debug write /dev/mtd0 0 2097152 spi_test
   Copied 2097152 bytes from spi_test to address 0x00000000 in flash
   root@imx943evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx943evk:~# sha256sum spi*
   f7d59270621c04aac29df9fc1742d0a0882047c618833ecf1577a57d109060ab  spi_read
   f7d59270621c04aac29df9fc1742d0a0882047c618833ecf1577a57d109060ab  spi_test
   root@imx943evk:~# mtd_debug erase /dev/mtd0 0 2097152
   Erased 2097152 bytes from address 0x00000000 in flash
   root@imx943evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx943evk:~# sha256sum spi*
   4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
   f7d59270621c04aac29df9fc1742d0a0882047c618833ecf1577a57d109060ab  spi_test
   root@imx943evk:~# hexdump spi_read
   0000000 ffff ffff ffff ffff ffff ffff ffff ffff
   *
   0200000
   root@imx943evk:~# mtd_debug info /dev/mtd0
   mtd.type = MTD_NORFLASH
   mtd.flags = MTD_CAP_NORFLASH
   mtd.size = 67108864 (64M)
   mtd.erasesize = 131072 (128K)
   mtd.writesize = 1
   mtd.oobsize = 0
   regions = 0
   root@imx943evk:~# mtd_debug write /dev/mtd0 0 2097152 spi_test
   Copied 2097152 bytes from spi_test to address 0x00000000 in flash
   root@imx943evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx943evk:~# hexdump spi_read -n 20
   0000000 f3af 8ec6 388f 56a7 4b69 0859 7bde 910b
   0000010 ea09 0762
   0000014
   root@imx943evk:~# flash_erase /dev/mtd0 0 0
   Erasing 65536 Kibyte @ 0 -- 100 % complete
   root@imx943evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx943evk:~# hexdump spi_read
   0000000 ffff ffff ffff ffff ffff ffff ffff ffff
   *
   0200000
---
 drivers/mtd/spi-nor/micron-st.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 81a9bead1434056cce0893c97bd35ea248c15894..4cfa89b0fc3dcc16fe47fc58c043971f4c474ba4 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -187,14 +187,11 @@ static const struct spi_nor_fixups mt35xu512aba_fixups = {
 
 static const struct flash_info micron_nor_parts[] = {
 	{
+		/* MT35XU512ABA */
 		.id = SNOR_ID(0x2c, 0x5b, 0x1a),
-		.name = "mt35xu512aba",
 		.sector_size = SZ_128K,
-		.size = SZ_64M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_OCTAL_READ |
-				 SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP,
 		.mfr_flags = USE_FSR,
-		.fixup_flags = SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE,
+		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
 		.fixups = &mt35xu512aba_fixups,
 	}, {
 		.id = SNOR_ID(0x2c, 0x5b, 0x1c),

-- 
2.34.1


