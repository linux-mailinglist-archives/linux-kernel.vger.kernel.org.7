Return-Path: <linux-kernel+bounces-896604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB268C50C21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82BA189B6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098CE2E3AF1;
	Wed, 12 Nov 2025 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k346FavC"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638C2E1C63
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930082; cv=fail; b=CWOSCeIi1w+7rmpypVm5bFmT1C5k88QC0xQGBHZFjb0Jd8SluZqavy7plCx/QdXZhLsd+qZbB6UMNdIIBljSovb3jBWN+EWWUgoR4UJ+Dwwo7un/Hra2dW9RhGRWeZV6lE650iF4aiPG2+kXaofk/Hu4ifMlx1L8SpJX2pLpjY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930082; c=relaxed/simple;
	bh=9z04Ep0G5ElhiVUuj0x/xZiFASLE/QZ1KwvnBGySPBQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cDj9EtQSokFQdW+bXFQrbkDa1CpxguFb4LIIs6jZb8N3dSe45XciQhSsMteTxw8/ZoZ4vd+nTSdFW3XUix2yvHCE9DIVBCJXIuk5yd8JgE3FzsKvYj0IICkvL1/iYiWbVO2c3znAGZhCzqVR1BeJLNZTUnPkWeWsXF8B7VtMc8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k346FavC; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWnDCKBLlwPe6RVecb3ytm6S/qlDM4sewejrOx9whN0IByQe0pYNruY0fz2abmFa7ZKVyrLb/f02Mapu5IxVtf+b1SJedWboieTVo1rmApdbuKAXtyvQ7tEa7DngyM3jTp71+/mN92Sd1nqs/ecAeZ4zVqfdgtjHtl8H7FCeOMq5UHP9uPYfRxQaWu3lab77mtZBN30eTmZ1LaKzVRQgkhEb+BFHVE1917jrfCfzAfC709z0TA9nHmGu96rBWFJ7abe9myRHbO7iwOK8Gj5T201+tgj86Oy5sXwMNAeA2prDzZjuHpjBX6SvfGE634618dHogLlGgfjIbzZQqLPyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RunJnqTqTUPygsSQzMHiAbCecp0YEtqYme/+VgtNSXY=;
 b=HeI4nh/eazakjJqXCFXg4cqGaHTkK+yCaV7X60tz8hB58cY6c9xQWYePdiDcpmxEmlO/20bA0ovT0P7nbDYJJQC7cd3Jlaw1k23h6ZKhDxWcd4e5oEvnK6o5tPbg/1N9DcqDI7DY4idOsS+QARC7CiWbsHYLKv4p1f59ADjNdWFNHvhcr/IV/MsMIP3MOQTEW5AQKJ2JD++f/hSykA/s+SmJ7XZJxddvyRwbCVlT63sZu88Zyvx7QTcDLC7zT8Y7i6MDXk7BXdjUkkoL0RPH884B1tEJaGAz7wkcuhqOIsczbm+9QIyW3aQ0vdMX8KmGn4TssewHlWPCk9LUqXP09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RunJnqTqTUPygsSQzMHiAbCecp0YEtqYme/+VgtNSXY=;
 b=k346FavCij6ZM0Nafo6sxb0N9JV6Q4rWkV7WD3zZuNSS4vEmNDzCKAS0MPlrEDO0lgPzFLImHY+MVTLIzEkho0vLGQ343HNRmLJJt8zvBavZfI9w7kIZ7y5jSJTYlRTzPTsb6kwEcIkjkpJDZ72/Hju70SgpoxllnQG7+Q5Db+YZilwCKr48eEeBhtAzokvUdCmgOS/7iq+Rh33yyVvV8DSB6kBi3L/GHTD+IjNvtMpmdgSVPBPMpY+eNkjT5AHlbKZwF8XF7H7+KuOpdNy5sfg8NhaaF/AQsKODHGw1Kls+SGgQ199IYmZSLCfOYvacenLp2H3f1fcnQjyCeX5vYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV2PR04MB11301.eurprd04.prod.outlook.com (2603:10a6:150:2b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 06:47:58 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 06:47:58 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 12 Nov 2025 14:48:06 +0800
Subject: [PATCH v3 3/5] mtd: spi-nor: micron-st: use SFDP of mt35xu512aba
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-nor-v3-3-20aaff727c7d@nxp.com>
References: <20251112-nor-v3-0-20aaff727c7d@nxp.com>
In-Reply-To: <20251112-nor-v3-0-20aaff727c7d@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762930121; l=6839;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=9z04Ep0G5ElhiVUuj0x/xZiFASLE/QZ1KwvnBGySPBQ=;
 b=7S5NCHq8C6aLt0JRpcSsvnuvZBgurmB/z2s20lMFkBpPfLNll8D04OcHwoSW4KY0rUvqT5E97
 fQO70fMFHvaAPqIgnkPz50zdzYs2Yo8tqeM6bhqy+Q/x/dsWAhYZBIh
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV2PR04MB11301:EE_
X-MS-Office365-Filtering-Correlation-Id: e00e10f5-9dab-419c-1a5f-08de21b76a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHRkaDM3c29laG04bEhFcHgwVlpWNmZ6MHhmWjlGd3lDUHFzZWJsQWxEbmcz?=
 =?utf-8?B?TXdHcDF0M05BVnNqaXNhR0pOMzh2dWdRbUI2RW5UNTVMN0lRRXF6a3huZFlH?=
 =?utf-8?B?ellsVEptZUlVQUM5K3lOS2dvSjhXVDNpRndzeCtqakdyZmxCY0dCQjhQUzNT?=
 =?utf-8?B?S05SSGlUanZhM204RnZiU0pPcDVLSE1LdU5BSmprbGZublJoQnJBS1FoMytC?=
 =?utf-8?B?Zkg4QjgzNkF4Mlp1QmtCc1hPOHYyUFc3eExibEFPRVE0bVdTaGVacXJzOGNy?=
 =?utf-8?B?dHVrQk5qZFRlVjZ0T3Y1RW1mWWNDNVFIS0hDeFBBUlZIVndaVmVwMHRkdExR?=
 =?utf-8?B?TndUQUFmbnd0d3VzVVBHeWprTzdZTVBFeXBWZ3ZqWmNEVytRWVlTNEJLWGdK?=
 =?utf-8?B?UGRyckRJak5HV2RQK3d6Y1pMOGh2TTgwOHBnT05mNDRXSk5QSFl0R1JVSHZN?=
 =?utf-8?B?bDdtQUZ6N2c3WXhNbllWYXAwdk9BMlJpT1IvcW5FcVBvWFhJbVk3elFOU2JG?=
 =?utf-8?B?TjZPRys1Q0NWbmp0ZEIxeWRwZ3NRalR4OS9KUjFQeUNub1ZwamJmanh1YS9J?=
 =?utf-8?B?L2xqWTdtOHlqOTV0TG9MdXFkRG1ia0VZNDhlcmM0RHE0QzNuL3BqK1hQS1pH?=
 =?utf-8?B?bFJkRElpVmRYVUJvL3R3eEg5d3RGZUFYcHJPYlRmWGRLejFldndUa2dSK2hX?=
 =?utf-8?B?eU84UGtwZHRYWkIzZEg0S2ZpYkxML3JTek1sRm9Wc1VheTdoN1llaktrUzlV?=
 =?utf-8?B?c3pPSEZ0YU1td2pGLzVzZTVVREpJaFoyYXpWd3Q2YXRwaXBPTHBaMGpwVllm?=
 =?utf-8?B?aElnLzdHUmhyVVZrQ3VKUDJPTExFOTFNYndsOTVEbmZFOEtTdmtaYks5M3No?=
 =?utf-8?B?QWk1R0F0NUh5aXQ3TzNHS1JvUTMxMmZpaTdkUnZpdFUvMXdFUVREdlJHdnYz?=
 =?utf-8?B?bjhHSmhRY25oQ090UUdTdjRTUzE1b3hpRUgvcWR5UDJzREZIK2hNK1pJcXUy?=
 =?utf-8?B?NnNOUkZqbThJRDBkZ096MmpCL3BnVi9mUUdXd3RySE43Tm1vRFZkOWRWTFJk?=
 =?utf-8?B?R3JqMktreGwwNVpOeGdDMXRqOHpjeXBSaHQvQVowaC9XU2xOTUJrcUhSNmpG?=
 =?utf-8?B?Q1hTVG9JeWZhekhYRnV3b1g2TFB2VDgwaWNzREpnWTJSY1JGZUJtekQ2NVF1?=
 =?utf-8?B?aFdac2ZWanBmMUN1WC9tVnVHYlFPcm8wNVhpcUVISkhEV1FZZnZ5SVd6eFRI?=
 =?utf-8?B?QjNIUGxvV29uY3ViYXJLcC91NHR3ZlBGSkRRTUI0WmRZRmU3UE5VWExlVUow?=
 =?utf-8?B?Rk5yZ1AybG5OM0tReEV6aG1mWHlOOExYeHFoeVJjQjJheGNGcmVTM0N1aDh0?=
 =?utf-8?B?VWdzZ25yRXhZLzBVUS9pWXJkRTZJRTNtOHJxcyswTDRGQ2Rpayt6cnY2WG10?=
 =?utf-8?B?N284RTIweGxRdEx5K3pCNkZMVkFLazJnQmZXaEtaTGlsZWV6c21SMllrbkdi?=
 =?utf-8?B?emZsSG9xdmlVaVpxZnd1MTRnTEVyME9iRkpKSDlZUm9FcVM2QlBGTnBhMlBU?=
 =?utf-8?B?ZUNjeGlQMVYvWGxTNVcxZHM2NFZNN0JxeHFmTWEweG1QaHVHUVhMRVd5aVYy?=
 =?utf-8?B?MXlNTDlpS1psR1FwcGtOV1o1b3UzR2J3Qk1ndXgwVjQvUnhjb3Z5K0hCK0pz?=
 =?utf-8?B?NUNybTRiRmhmNkFvOUdlWTNCSmg1a1ZhR1JHMURmUXpJanN3QzA5L1A2QjJ6?=
 =?utf-8?B?V0ZEajBRMWg0TjRPdERpU3NlVGd1bU9iNnZDN0VlTGh1NzY3Vk12WkE5MjNn?=
 =?utf-8?B?VkNQc3NaYjlhVlh3TWw0dnJkNFROdnpRK1ByeVhEaitVaW5YY2lEV0ZlUHBy?=
 =?utf-8?B?Ni8xNEd3R2puNW9IY1kyY2xoY2pieFJPb25UWEtJQ3A3dVJrUGtteE56Wmtt?=
 =?utf-8?B?RnhzdXA3NFlVZHlldXFGQW1TQzF2U3dIYzJnUkJYWGttN21pVUYxS2JkemRj?=
 =?utf-8?B?TVhKaVdhUkdaNjZrc2MvSk9UREY0OGloL2RUVzBpMHczR0taUnFUMm1maGJu?=
 =?utf-8?Q?6HfvCt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE10dEYzcUlIVHBuQmxyQjRlTG5PRW55bDBsZUtoTmJJRlJtMUZTcGVUNHpS?=
 =?utf-8?B?ZXAyRGxHMUoxcEpEQjNJUU9yZndjOVdHWlBWYzBwcEZ6MDZqREVJcG5xVENO?=
 =?utf-8?B?dklHUlFSTGN2UUxSRVQzWkkxVlY1cWJYZEExY3F3NVBWUFRoWkxvaFlEdGZT?=
 =?utf-8?B?YnY4VEc2WGQxMDdianRhaVphNFhQSnZQejFsWHdiZDVqaEpUVEV4Y2FVQVAw?=
 =?utf-8?B?TmZtNjhkSU00bk9vbnM0N0VBK3Exa0E4d1pPb29qZ09XTHJJVzBCNXAzRnkr?=
 =?utf-8?B?VHdia09JY0FpMDdSZ1dIaUh0SzFHSnF3dTNReE5YeVBXaEVkVDI3RDVzbDk4?=
 =?utf-8?B?WUt5dnFoRndURi9uTWF6bDJaQU9GenF1OHQrM0ZxSWZGdjJHOC9ReEYzZEhG?=
 =?utf-8?B?TktVcWlGdXdvRXZHYVFaNkdPcW81eWx1NE84WDBSbGo5V2o0NHd2cXRFVW9J?=
 =?utf-8?B?Um5FRERabGZFZkU4dFNmQTk1V0Y0SktEU0lmL09DcHFCWG9GQnF1OXYrVXU0?=
 =?utf-8?B?ek1DalBvbDFjMW5lWnZYQXZZWG1CMlRhejFvMXFjS08zQ2p1UlhaQk9UQkxt?=
 =?utf-8?B?MFRRbElaMTlyTmpGd1lGcXp0Mm9MQ3ZnQVg0c3I1cWdNaVB5OVQxUy9BNkcz?=
 =?utf-8?B?d3lNSDBCREdRblpMbkU2RVQzcEV3WVByRnpYUCtjRE0ybXpyejVFa1ZZYUtu?=
 =?utf-8?B?WlZKQVJ6YkhtUE9iSTlYTFR5M2cyN2VLTTF1bXIzY3I2ZnhSdGVEUWZ4MVFm?=
 =?utf-8?B?Mys5VGJWcnhremorWUgyOXhqR1NDZ1haZWJyRVdQMGZrK25EbGplK2szZmZB?=
 =?utf-8?B?WGIvNTRrQ0tyZHVTMFVwcURlUmloUFNQdzBEVllHWXdiUmJKcTNZNHluWHY4?=
 =?utf-8?B?bjFveFNrY2hmdjJqMFdLS2gzVU5YRkp5aHY2MzBGMnNSbG02cXhUSDV1WUdF?=
 =?utf-8?B?Tjg1a3FGUHFKL05MUVRVeW5icU5QUE5uWktDZEZmVTdaaTF5eVRhc3h2Qkox?=
 =?utf-8?B?enZaMitCb05qUVovUUV3L2lSYURuRWxnMUx1TC9vY3BUN0Z1T0NRQmI0eDlE?=
 =?utf-8?B?akRvWWJLaXFEU0kwaWNoMnIrZU83a0tvdVlDV1lLc2Vrck9mQmtUT25uR0lr?=
 =?utf-8?B?L0NCbnpOVTNtbUNwL2ZJRDVRYlRIeWZudTFlUVhzdGtaNmpSV1JMQStVeDJB?=
 =?utf-8?B?N1VKcDRsS1dtd2NyV3g2cVRCSzRvVnZTNUJDUktBQi80dFp0MnpZUTVvWVh3?=
 =?utf-8?B?OWtaa1VQUzFYZHNxNFYzQUFXNE5jdkRRUWJPTEFycmxrU2J5UHRlSFBzckZn?=
 =?utf-8?B?S09ESDNhcG1ZNHFvODBQUHp1WFNtY2piWmhySGI5bXRYdlBoSnJXZU1tMmtq?=
 =?utf-8?B?SThzR2J0djFCaFZ1SDgxK0ltRWgyQnJiUkk5bk15Rk1EOUx4MU1YMUx5QjRn?=
 =?utf-8?B?Y3d6YzQzS3ZCWlFHVUZ2SklZNjFyMHJZblFmN3ZuSjlJZUY5L2Z0WjNUWTJm?=
 =?utf-8?B?MFhqYllGSUJvZU9oUkdmQWtkYWFkUUVKdm5YdW5NS21MbCtMU0VWUnREL3Bw?=
 =?utf-8?B?UHFRaDlBSnN4SlBwTGNTdmk5ODNWMkh6L1VidHBwbis2djZ6NEoreVlkZEk2?=
 =?utf-8?B?SFdzRW9HdnNrcTdWOHRGd21VS2w0SnhlWjhZOWRZbnJDS0Rhbm9EaE5wTmty?=
 =?utf-8?B?bmQ0dWE5YmpxWHhUSjJYV1BRVkhhQXVEeksrS0FhQ052b3FjNmQvWnVXKzJm?=
 =?utf-8?B?c21XYjNvb2JaejZsVlRQVi9ia3h6RE53cEZmdlJBNUpNWW5KNlJOYUJaNHVw?=
 =?utf-8?B?aERRMU0rcUVKSnJwVUk3MzNTUFNBUzRUZHVvQjQvTmVDZ0Q0elBheWEwaTlN?=
 =?utf-8?B?M0YxVU90Qlp5QU5sdzE4cmIxMDRieFBPdlpTTkVnbjlKam1scHFWTkF5bm1k?=
 =?utf-8?B?TGZhdFdHYkVFQWp2V255b1NBd2kwRitnME5ITFlHZkdrdHA5cmhDdlB2b0FW?=
 =?utf-8?B?UXg2WVJOZWZnSEtNKy9PVFFYUHVYcHU1ZUJiZmNlRmlMOU9KcXFkeFFmUkxQ?=
 =?utf-8?B?T2ZzVC9hZHJlbndVRmJEK245elBiNUdQcFBPSmdVSXJlWXkwVjBxRkxIem9F?=
 =?utf-8?Q?jymrzhLW99QMJCSXUDCCp3Vew?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00e10f5-9dab-419c-1a5f-08de21b76a3e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:47:58.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Si+uV6ZgwSlq7G+h9gFhovGcQIHCndqcPPBp/0f0lmcZSrt+vL55/C0LX5zIRWTPuwmIUBrgdbtZD78nC0U4dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11301

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


