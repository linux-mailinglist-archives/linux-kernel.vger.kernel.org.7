Return-Path: <linux-kernel+bounces-896591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A79C50BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E668A3B63AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A622DECCC;
	Wed, 12 Nov 2025 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SXxguDNY"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3E02E229F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929382; cv=fail; b=Z2wZ5BOwN9zm8kMyppcJnk/dWn7CMwfawP4NbdUXIYXFLpfT3tL5bGAlnZDg7FD7wJl3qAGmokE72rSn4IRU2xapXmhkNXSjvjNmSY8GY3yjLabPaGvoJCTOuv7diqaWIcgfFGi0t84j5rzfj8bw1Tz2LlwUsei4OXZZjzo3wWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929382; c=relaxed/simple;
	bh=Jynd6hEp8Gwn0IwCRNKMTJw+4libXRl/ckl4sUhJCBk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=emIGp2Nb3wLo9Xybqz/mrE6W+nXIOIQIm4rye8drhyWf1Ga9OLG5ol9rn47GK8vlOojWte8WL3kU4ZLnZ0f0V6ix2ISuT+UzF+jZFQsXlB6IRlvDaPUkv5R815zmv2RfgX8E0etYP54MtcebN8U1LzEc2tOgIASWfp5h+38TyzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SXxguDNY; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWywYeWmjNK7KfuQmDt7UwD2v262VoWmvQr5RWBaFwbXccY/KyYNvHKYzLq6y4C2Jxb2OsTtIkLqy+wbBNjvdgvx0tFcw8CqxRaF55EkyyioMsRruEoeKToSMFdJjFOc4ejFcLrOeG+4acAoqzSHOpTuXqjezG5T2zuJUuhtC2FPIUl9yxIIBXUZHj7T6hKm2XFWSVyfFIx7mqvCW4rQCcp56s66AQa75Myd5SSswzeJMHIT38E5ekcCF0eOqp8gxlbvZoQ1DAGlaWHiXP7xVWUBApwH17sQgjBI5sDwG1W9PPoGZZicz4/Xq9zEnmjKepgSR5ZAlFTE2ApYcmWTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzNj7k1UG9yEKDP5Cngg1dFvnzdGxDqBDDEoIsGAYXw=;
 b=sfU+27vKM4nGU1L3nL7mcIwDqvuki5sKiDqN5hx2Z6HTYm7m+8YOOGjEuUEyBFoX+Gw36f5Oe+M/gcDEdsuPOsHD29IdEpSnwBoZe+bSfDJBwhUjsNft+Kwa1mjaaNtCNJTp8nWuFtjJxiUiGXyz9Tqbmq6tFvWigrmYmwjrriNRw4xdP2PipS44SD90gX8TNHWS+wyuagj914DzQPThjA8KRQxl+zp0QTx5IyRpQ7LH9khXSRoxjgyV5iB1oODVtfjmxgjCpdRN2KXJg64b0Q4pJBjV+uVibiCqDxRIPcp8VrCId0sWuEePFCeAyujcdyuFYGQwMk2fEURLrUqV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzNj7k1UG9yEKDP5Cngg1dFvnzdGxDqBDDEoIsGAYXw=;
 b=SXxguDNYyQ7n6+BLXoeLRo4MX3DR6aBFrxJ1al1nVxpz9WC0R1l2Bx5BV8kuWiX/dcy6F3PYUn+2Qqsg1iAQdqRPjmY2ZZq8S0Fl8rZS4wmLqfAaWXrrowrGo4u6g3e2ni1/Vw5/eXJsj17+jlQPZiqShWi+8vosJIlXgNkhGfnAHA4BRBobSdgx72q2Cg/Z+cXGIRVCFBdmRJQCuUVNbZ+xhaEhNYaPNBjalv2HGtsnFj1D7dHizif0pAmEsWeIkftpaDjVG9Xf7w3ujrGT6M3OyxTMtgH6ZeaSDrle5A0ckKFU8svm3dLyO3uEXv/8hqQUnsYZyHDzhEgwchhSfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DB9PR04MB8187.eurprd04.prod.outlook.com (2603:10a6:10:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 06:36:19 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 06:36:19 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 12 Nov 2025 14:36:22 +0800
Subject: [PATCH v2 4/5] mtd: spi-nor: micron-st: add mt35xu01gbba support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-nor-v2-4-8699383714b9@nxp.com>
References: <20251112-nor-v2-0-8699383714b9@nxp.com>
In-Reply-To: <20251112-nor-v2-0-8699383714b9@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762929419; l=6776;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=Jynd6hEp8Gwn0IwCRNKMTJw+4libXRl/ckl4sUhJCBk=;
 b=eoR5DcjO3lTjZZjnUrXVcP1G9YcmqRAbezzujtL6pi1E8qPZbcUbckSL925Ykb2ZPeMHOyYu6
 hqzbv9KsfCQB0n7w6WjRAtpOlo4p16wxP0eZOQcyXpVfXFYmYuathoL
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
X-MS-Office365-Filtering-Correlation-Id: 597a19f0-6cbb-4625-1fa5-08de21b5c970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0NMT3dWUHI0bTV4TFpYVFlWamd1NTljMC9GMnhFdVUzdTJLeHZTa0RIZWc5?=
 =?utf-8?B?cUtkVXFkWjU1a3ZCT3d3WE9JbUlTeWFVUDV5L1hVbjZBaWtCekpaNGxrdXBp?=
 =?utf-8?B?eWZIMVhOdzh1eVUvQUFrdUxDVWd1QnA5VU11VytXWjVEOXRiT1NQWXlCdk1B?=
 =?utf-8?B?N01aaC9HMnE2bjQrY25qQVZxZVFaUDZDYXV0WjVzNG1vdTNjQkFkVWJaMERq?=
 =?utf-8?B?V0hUYXJyaGtOZnJzMUNHSVFiWG1uY3puNmFmUHcrT2pYTmoyby94VVczRVlD?=
 =?utf-8?B?V09EK1N3UkdqMlQ2SEJRV29lL0p1c2dsVSsyWWpKN3pVT0lEdko1Z21LL01U?=
 =?utf-8?B?Y3VnVWJQd3FqL2JlRFFaMGdWSTh3bGd0RS9xK2ZlamVCQUtZaVM5c3VsTHYx?=
 =?utf-8?B?S21xOXFYYU1FSUd4dXBzbWE5THB5MVQ1OHd6SW1SeCtkSFgyTFd1VGZveEY1?=
 =?utf-8?B?RmdwMmpHSm1GWkVrVXJZNGR5cU80dDBJWFRRVmxuaHlaamNWbjJjOWJmdHEw?=
 =?utf-8?B?dDVYWTZkUTMrcDZIQ0lGMTZueUZJdHN3cm15V3luVnNBKzU1ajN6Q1dhQ2Vq?=
 =?utf-8?B?V2VodkpOaFZOZUtCQ21SaGxzbkI5aFB4YndZYWNwMVE2cGFKY1cyd0Z3ak8y?=
 =?utf-8?B?SUhEWVA1Y0pyMjRGOTlnNlhGckk3eW1HUXB6S0t0YmJtUWdyaEtMK2g3aVhy?=
 =?utf-8?B?NG9ZNDdaSkVGWklXQ1VtQ0tpMkF4NnN0dFpFZjZBbnVSVTZQU2tlVDdjY2pZ?=
 =?utf-8?B?d3Y3a1RWZGZkcXUyNFBTVDBqZGtrekZIWXZPcmhjZ1ZvOFNQRVlJdGQ5ei9H?=
 =?utf-8?B?U01pczNEZ0FqdVdJek5zTHBXNVhOK2FsejMybGJwZkFEcXBpbFJrOVpkU2Nr?=
 =?utf-8?B?UHpIaXBHem0xYjlQQUZKRCtucFdaak02K25MM3hHQytKVnd1RDRFeEhyb3Fq?=
 =?utf-8?B?d1Z2c3pOdEZCdFhjZXBjTUVmVGJyeW93dTc0K2djTGFTZ3FibHA0SUxUVTYw?=
 =?utf-8?B?WFNSWnVlMElLZkQ3U3pIdlFVMHRTd3V3R3RML2ptOEpEU3ZtSjdKdEUvQ1lD?=
 =?utf-8?B?blFPNmNIand4ajQ3UDB2aS9aa3BpOCs3Z2R5bk51TVNaRDlSWGR0blhhazJp?=
 =?utf-8?B?VXZsRHlZdmp2WkxxZnIxZjVqS0NXODdOaW0vME10NkloMGRLQU9Qc2pFc0ZR?=
 =?utf-8?B?Z1M2WHhUUWpycys0ZEJVY1NVQXZ3K241RUJGajJzblNLa0JvbW5IUDFMSG04?=
 =?utf-8?B?QlVPenl3akJmK01yMWczalE4UlFzMmZ5WHp1dTlsWjVPSGtCcHpHWktwcldz?=
 =?utf-8?B?eWdONUtiTEZrNXEvdnVGMXpkV1M4TkdIbGNGMTNCRWxoMnU4aGtrcGcvU2pN?=
 =?utf-8?B?V2lWeDFZT3FRbDVHTS93TlNGQjltTlExNGY5cmtTYnFnbXViQURjRXg4cU5R?=
 =?utf-8?B?aFBLZU5rU1o3UGVuZlIvZHJuVkJ4OWs1S3RWUWpDSllVU0thWjUrbllLTHVl?=
 =?utf-8?B?Mm16NWpnbVdLMFYxM1NRaGNNZVRIZkJPRE5vdExlM2ZsdHFQdEp5Ykl6cmFM?=
 =?utf-8?B?eU1YZnE2d2o2bFFibktacEwrb084Y2xQd1FUcjNqUmxQVVVFMjlkMWtYQkhZ?=
 =?utf-8?B?WU9aZWhwejNwZnZvbnV1OXVwL1ZlNGk0LzBVWkc0OXdLa0tYZ0xYc0RvbVNo?=
 =?utf-8?B?VUtJMTRGdi9Ic1dPaHNjRkRMTngrZWdkTk9FeFlxd2JhOWkvTCttR09XTnVL?=
 =?utf-8?B?YVF4aDNiOWViK1BaWHAxZEZ5cFRQMmZsbW5WWWVScFVNYXJ5YUFGK01jTDMz?=
 =?utf-8?B?VXVJVlNsSFk3OXhiVlBwdC82WFVmeXVsRkdDZmMwZkY5aFhTQW9SSFBLS0Za?=
 =?utf-8?B?aUdNQ2Y1TlFra1p3R0V6V2w2WTFqWVg1RU5oMjVRNjU0anNzT0hMUzhUUm5W?=
 =?utf-8?B?TEZNMVZqeWUzSHVkYXJzMkdrc1FScEl6VTVIZnZYd0xQNk1wcTA1K2QxaVhk?=
 =?utf-8?B?OE45TFdrbGZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDFwSHJULy9CNVZCbnZpSy9rL3psTjhEMUFzeHpwRzJQK3Z2anVaRjJ2M3Zw?=
 =?utf-8?B?YnJoZ2czazRSSE5Ca1Q5S2h1SVArR2d3ZWh6eE9DVTYvK09BVWhnTHNzRjAr?=
 =?utf-8?B?QytFVFZXcFhLRW1EYTV4NFZkNmhyeUVETkpiQUtNcjU5Q0N3T3pldmlhTEJn?=
 =?utf-8?B?K3BQOTE3TGdYb3ljR2dDSkZwTTZMYkJkdzExMXBhRDFZTzloTWp4MDNNRE81?=
 =?utf-8?B?RnpkNUFSN3Vkdk9mUmJ4Z29yR3IwZ2ZqSlp2aWljdzRQVW4xems3bmYrKzBo?=
 =?utf-8?B?UVZ0clB1Y0FRVjljZFlnd1h0MjgrdXFJRzJDbDhwaldmYjBZVzNiVTNla2J6?=
 =?utf-8?B?WHp5MGFkYUVOZHRmZUFMa04wTFRHb1N0OGVjL3AwWFlFZCtwcUpqRkJrWmFG?=
 =?utf-8?B?Z1VqWjZTVTVOcE1RMGdJbDA4UTBKZmEwM08xeDBqTzkwLzkvRCtVOFk2YS9R?=
 =?utf-8?B?eWs1aUhjY0xtVFBIQnEyOUdGdU5LTUpacmdTbXBlZ0s3ZTBmWlR0ekoxblBX?=
 =?utf-8?B?YmZ4TXdwcFd4c0d1Y0l2MEZzZUh0Qk5tODE2S3U1cHY5NTNQZGtYSE1IZTFM?=
 =?utf-8?B?MWFCYzBKVTQ4QUxkUlBkRzYvYTV0Z3FNbUYxNENuQ3B6Z01DbGxZQmdwSVRk?=
 =?utf-8?B?c2JLUkxXOWR5ZjBqUU10c2ZVL0lTQ04vUTRTaGZVa2pJcHBaYVJoU2lLRjM2?=
 =?utf-8?B?NVM3YmhVdS9rTkVxK3VXdjRrZzNENVlWbVJNMUJEV1pqUm9BMlVITTZ2Nkh6?=
 =?utf-8?B?eFZhT0pmb2FiYVFSZDYwL2Z2ZXF5V2Y2U1dudjE1bkZlditTSEsxOWdqRnIr?=
 =?utf-8?B?MlorOE5nTE5tU2ZHUFlXMUQ2TWpkQ1BIVUVCMlI3UXVpMStJQ2MxcHlxcVlP?=
 =?utf-8?B?SER5M2FZQUczRW45b1c2L2YxTVV6RDdWSGJqcDZwak4xeVBRL0pHMXVLSkpY?=
 =?utf-8?B?VDkvZzBIczIrNFRqRUZBTnlFbEVVTlljRmxSZmVWZW5STW5PdmRZUEt4RW82?=
 =?utf-8?B?dlFFUXZnaldrWlB4dDhRRmU1akZzL0lFcWNteTJ1RWR4QUVHY3FjTkFhTG41?=
 =?utf-8?B?KzBDc01lSnZFQlcycFltZ0twR0JIelZkUG5uQmcvN1pOaDhNZUtsMFdCUklJ?=
 =?utf-8?B?eHJpRkI1eFNiMFltdkltZlRnZS83VFp5Z2FDY2VkV3dSSXA5V1FlN21MdDVv?=
 =?utf-8?B?NE1ML0QxZHh3c2R6Sll1OS9ENlBtQ0ppc2FhTVVXOFc4Q3BhdFRCQ1dyNVd0?=
 =?utf-8?B?bW9Lb1FWMWljQVMxOHk2c2JWMlkwL1lVdE4yejMyVWVqSExKZ3lWZ1pXaEMy?=
 =?utf-8?B?SmVDZ2NPTkV6a2FYSHB6WWUxNUtPdE4zN0I0WFhHSHdtbUxPOXZTdU9OcHVz?=
 =?utf-8?B?RDY2ZTZsTEVieDNqbThrWDZ1N3o5SWptVzhoNDUxM2pqd2tYQnJzOWh1cGlm?=
 =?utf-8?B?QzhRRE1WdS9mTG5DbEptMkNuWFBDbVVPZE1UbVZrM1FSU01MSG1tM3Bad0M3?=
 =?utf-8?B?M0xyb0JydGRCdWhWYkpqRlpPYUc3WktDWkgwODlBd0ZEejAyVmMrbjV1aUMy?=
 =?utf-8?B?d0ZEQlBhTDBHMHhCUVo1aU1HV2o1aXZGellpekF3eFNadjh4YVlUK3RWYVU4?=
 =?utf-8?B?SHpNVjFqZWtydXArM1FBSUFpVUMwR2N4RXY3QjB1N2xOZDVzYmlPYWRYUGEz?=
 =?utf-8?B?NGYzdE01ZjN0UmdkNDJneHhtUGFWWXk5VEtybldrc0VPbFozUnV0UWVSVjk1?=
 =?utf-8?B?Q28vK1NlV3Vlc3YzTllIbUhhcFRRTmtQaVpvUy9WQjIwYjBSeGpUWVJpZnQw?=
 =?utf-8?B?cXZOenBDVFpSemwxMm0yZTNDUTlCOVI2VEtMK25ldWxxL1FWd20zbWw3WVZR?=
 =?utf-8?B?S3JTSXY5ZUVvekpnNUEySXZLKzgrRUhISFRpamppUGVGZGVTKzNSZUgwaFR1?=
 =?utf-8?B?bWVOZ1hTS2l3dE9wZmdqOEE1N3NReTcweVUyTDZaTWplRDJ1UXB2TElPR2FP?=
 =?utf-8?B?TERoL0RVdUhsNEwxNWJjcjFBQzdzaEdhTUpDclN1VDdFWkplbkY3MGN3ZC91?=
 =?utf-8?B?WGNmTzNKbTBzT3VnRlorRGV5ZUx4TEcxVnVPeTJLa1dXZGpyMEVaNDVndzBB?=
 =?utf-8?Q?FFffZDJU8fZMY5RjYHhSnmJOY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597a19f0-6cbb-4625-1fa5-08de21b5c970
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:36:19.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y46jiR5EuhpKz7xQwJGair+dytt1r32p1SzRPjAVJog75e6Hh+0cbeI2IBr+H3wVk8B9eb9pVGjF+oNI2ue/1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8187

mt35xu01gbba is similar with mt35xu512aba, but with two dies.
SFDP contain the wrong size, so define the size dierctly in
the flash info. And it also support 8D-8D-8D mode, but SFDP
lack SNOR_F_IO_MODE_EN_VOLATILE, so add this fixup flags here.

Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

---
1) This mt35xu01gbba is populated on the imx95-19x19-evk board, was
   tested at 200MHz using nxp,imx95-fspi SPI controller.
2) root@imx95evk:~# cat /sys/bus/spi/devices/spi1.0/spi-nor/jedec_id
   2c5b1b
   root@imx95evk:~# cat /sys/bus/spi/devices/spi1.0/spi-nor/manufacturer
   micron
   root@imx95evk:~# hexdump -Cv /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
   00000000  53 46 44 50 0a 01 03 ff  00 08 01 17 30 00 00 ff  |SFDP........0...|
   00000010  84 00 01 02 90 00 00 ff  05 01 01 06 a0 00 00 ff  |................|
   00000020  0a 00 01 08 b0 00 00 ff  ff ff ff ff ff ff ff ff  |................|
   00000030  e5 20 8a ff ff ff ff 3f  00 00 00 00 00 00 00 00  |. .....?........|
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
   root@imx95evk:~# sha256sum /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
   3848f0bd2436d7ca1373cee33f90e09d6479d0f4dc4bfd19f6a082d9e0039495  /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
3) root@imx95evk:~# cat /sys/kernel/debug/spi-nor/spi1.0/capabilities
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

   root@imx95evk:~# cat /sys/kernel/debug/spi-nor/spi1.0/params
   name            (null)
   id              2c 5b 1b 10 41 00
   size            128 MiB
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
     c4 (128 MiB)

   sector map
     region (in hex)   | erase mask | overlaid
     ------------------+------------+----------
     00000000-07ffffff |     [   3] | no
4) root@imx95evk:~# dd if=/dev/urandom of=./spi_test bs=1M count=2
   2+0 records in
   2+0 records out
   2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.0207974 s, 101 MB/s
   root@imx95evk:~# mtd_debug erase /dev/mtd0 0 2097152
   Erased 2097152 bytes from address 0x00000000 in flash
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# hexdump spi_read
   0000000 ffff ffff ffff ffff ffff ffff ffff ffff
   *
   0200000
   root@imx95evk:~# sha256sum spi_read
   4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
   root@imx95evk:~# mtd_debug write /dev/mtd0 0 2097152 spi_test
   Copied 2097152 bytes from spi_test to address 0x00000000 in flash
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# sha256sum spi*
   57300768c1271d4588b850dcbf4e1400f287f09b2d515eda610890456695b205  spi_read
   57300768c1271d4588b850dcbf4e1400f287f09b2d515eda610890456695b205  spi_test
   root@imx95evk:~# mtd_debug erase /dev/mtd0 0 2097152
   Erased 2097152 bytes from address 0x00000000 in flash
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# sha256sum spi*
   4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
   57300768c1271d4588b850dcbf4e1400f287f09b2d515eda610890456695b205  spi_test
   root@imx95evk:~# mtd_debug info /dev/mtd0
   mtd.type = MTD_NORFLASH
   mtd.flags = MTD_CAP_NORFLASH
   mtd.size = 134217728 (128M)
   mtd.erasesize = 131072 (128K)
   mtd.writesize = 1
   mtd.oobsize = 0
   regions = 0
   root@imx95evk:~# flash_erase /dev/mtd0 0 0
   Erasing 131072 Kibyte @ 0 -- 100 % complete
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# hexdump spi_read
   0000000 ffff ffff ffff ffff ffff ffff ffff ffff
   *
   0200000
---
 drivers/mtd/spi-nor/micron-st.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 4cfa89b0fc3dcc16fe47fc58c043971f4c474ba4..6d081ec176c37249e5ddb724b61bd70f68088163 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -185,6 +185,11 @@ static const struct spi_nor_fixups mt35xu512aba_fixups = {
 	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
 };
 
+static const struct spi_nor_fixups mt35xu01gbba_fixups = {
+	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
+	.late_init = micron_st_nor_two_die_late_init,
+};
+
 static const struct flash_info micron_nor_parts[] = {
 	{
 		/* MT35XU512ABA */
@@ -193,6 +198,13 @@ static const struct flash_info micron_nor_parts[] = {
 		.mfr_flags = USE_FSR,
 		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
 		.fixups = &mt35xu512aba_fixups,
+	}, {
+		/* MT35XU01GBBA */
+		.id = SNOR_ID(0x2c, 0x5b, 0x1b),
+		.sector_size = SZ_128K,
+		.mfr_flags = USE_FSR,
+		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
+		.fixups = &mt35xu01gbba_fixups,
 	}, {
 		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
 		.name = "mt35xu02g",

-- 
2.34.1


