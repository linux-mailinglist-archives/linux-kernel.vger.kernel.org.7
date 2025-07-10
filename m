Return-Path: <linux-kernel+bounces-725254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1E5AFFC7B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E891C2756D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9198828F93F;
	Thu, 10 Jul 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YY5ORvwH"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985728DEE4;
	Thu, 10 Jul 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136537; cv=fail; b=Ai+NCh3XB6scbrBhcE/ZOjCgmOQbc+97xNQHgcbqsxR2lByclb4ZQT7hyHv9HiF3Kw++BvDfgpMxWDCZEKUWfSIYXaD+HM4HpRO59h85raP2IhOzBVEuj0LQTAAYfVhyPeV/n6u9Kn8RKDfO41Z6sQ0/ejVoPAWu1bZvkfZTK3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136537; c=relaxed/simple;
	bh=tlkSVkXKpxigZeQOBhJixvwjd2xLeLF8IB26VcqZ44A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=t9G7y6r+0/Nfyc/uOzrNSuN5x/IMrFzTMBoYzLBVe1vuhpKhmaSWkLTXBQNOIQ4DbUHaOo+U9Q0fimUNuZIylanbOLT6w0mFox+xtZLWGkCimaB9E4iok5VfSgp7pF4cotMlqCHfGdQizgr71daygdEj/Ng5+0Dwy2uEscUhACQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YY5ORvwH; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M48SoVU5WYIZIzoBNlJLbnAm9/1UqI3dRAoC1eG7QLUdQShwCze+MFnecvV4GLfckN/NnoOeC0YydpyTu8HJITWoL2kCEJimQ8hqqAavBJ5B4LBBQZ4tu/SKcFyM4VH7raFw+K9JXaIs9Kar9hKVH2ekkipaf/KhZwE5/RImgqV3RC4+3RkhredrmAXS53IEeEnuKSDCNLBWVTGKUaBI9Nto1lzh/Oz/aW3ywWyj5EW4/ScxC5L7OrrD/cL7wVrvk+Ov8xmyUxgTQC65VyHOp2uSHfl/UHcAu+YvRvPmYyndWVnBu7QJLd9GRoSOsFP/wl5lt/zVfWqicoVCtocAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uh4onHOgJGlU8EOM/tggP3Hx25ck7Z0WzRNVQ2uK7tE=;
 b=uaLnOuBRyMtp2MGDTPfYB/EwHH4ZbuhEMMKokpjgvQF7PHgd08GNfjZOpkeyEvclOXyt7ruIAZfMNNVqMpA1c6oc+eU0HJG9uI8wz1PC1DsWnCY1aRmuOCmWjrmeBpOKyZPho6ZOzZhIMez/BT2gpWcS9irzfecWqbB6pV4E2aqFjbqBdccdVZpFx0ymurNxqkI6Np8Bd4E6O9wiNofc+LuYc+xVmC6KVPb6BXHOeuh8Ppj/iSqaA6MpslQeWk7lA6hGBZUyycR6opayTWasyw8MPSNzKGNuJir6HJvAYUkFb5vML6JC5bMAR30Rpub6mR1PhwutDXYADkNfE5vMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh4onHOgJGlU8EOM/tggP3Hx25ck7Z0WzRNVQ2uK7tE=;
 b=YY5ORvwHbXPlMwRbof0LA3sAfIGW+wmk1vjPWjOCGaivmdaaK2nbwsrwfJiBVmSXuHzXI8OEr7kugZURzAQ0oUvO5QCF0GYyGpjUAkqgt1jP2FF/T5Az7bi5cK3Yyr4oE94y026F+/TroGBXIXtdX4aCRYoNIa9gqArBaPHG7uXCRdeMnXfAAQZ9QXq1nMA18EvvrYjmydVlPkAnrb8cpCfCfRHdyTmf0nP/YpVhujcj7Y5x8Qvjb9K5XVxvi6dPkZb1lvRP+EJp23B5+pZd8joJe856Fj0EpLkJwjOE+r6WIrTagg5ZWNzA6/XIB8WjmldXpmmRQ/xV0rZllNIbTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB11512.eurprd04.prod.outlook.com (2603:10a6:10:5e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 08:35:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:35:34 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 10 Jul 2025 16:33:28 +0800
Subject: [PATCH v2 3/6] firmware: arm_scmi: imx: Support getting cfg info
 of MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-sm-misc-api-v1-v2-3-c3e953e34be6@nxp.com>
References: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
In-Reply-To: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752136418; l=2366;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=tlkSVkXKpxigZeQOBhJixvwjd2xLeLF8IB26VcqZ44A=;
 b=tFP/DC7S2rUVQKmVv69nWAY9xICJ+XfCelX61A4p0X+x7bk+0IV9hnnZnjEKV2wElBgKDr0fk
 yF3t/F0/vG6DRYankRsSudmFbMzg7mSUX2qL2cTG8lE4I/aoLHpMAmS
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: f84f8234-91af-4486-ae2d-08ddbf8cbce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGZyaXE3b0VKTVMwaEd6dUdETWJEQmFMSS9DSk5aYzMyd2JTTlYzOElCc0FH?=
 =?utf-8?B?NkFzOUxBL1hlN1FBb2dkcU0vN2JPZ29JVjVIdTlqNCtpN0FWSEc1QWorY3hh?=
 =?utf-8?B?SkI2S0xmWGlqb2pKL2Y1QUxLWFk4c2Y1Tk03NUlFeks4alpuaDlpU3d2WDVu?=
 =?utf-8?B?dk5xZTYxb1RRWEFHMjYvV0trR01Qd1NubFliOWdFNU5uamo3NUFSS0xQTGsw?=
 =?utf-8?B?cldtdUJiWjRVSk82WmNuK0NhcnMzY1dDSHliSTdoMmIwRXYydDZYekUvVis5?=
 =?utf-8?B?Y2hPa0Q0RGRwSWk1UmN6VFErbmNvb0FITFFYVTdydldMOVE5TkdlaENQQTJp?=
 =?utf-8?B?RTlTbkdnZHB1NnpMT29zZ0pXOEwvN3F4M1FJNUFOYzRvSm1rWk5xZzdNcGZy?=
 =?utf-8?B?Q2oydWNvcnNORCsrUGFrUG9ZSWgxSU5TZkZsaWlOaFR3eXZsZ1RWVlZUaGZn?=
 =?utf-8?B?WVd0WWhNWDlqeHo3SW5QRXdCaHRKamlRRDFJbjgrWElMajZUa1JsYkNTRml3?=
 =?utf-8?B?WGpmTkxwOG03cnNkZjlTN3ZtT2RFeCtLVWpiV05lelpvUUlTK2szeWRPYWI5?=
 =?utf-8?B?VHU4SzVaTHN1c2RiSUU2K2tKYkVkUzdIUDdLVi9OMmt0NkpVcTE2aGhIOE5K?=
 =?utf-8?B?bW5tTzcxNS9uTk1xZ2ZRTXBEdDdmWlFTdDNNeDJTTlh1NkZRTWhCbWxVaFRh?=
 =?utf-8?B?QlNuNWxlUndsTzVqeldFSHBJSnJwV2hxOHdWVG4yWUppUzNpRG1tbk1yZHRn?=
 =?utf-8?B?dUJTeWUwY2hWTWhBMFl4KzBhQURVWTRyTG85V1BCREZYU2xibkNjT3NwYjJh?=
 =?utf-8?B?RlhqTENzM3VOZExqcGZVNUdidUdHNzZoYzFxZ1ppRUZhSVhIZi9yZ3Y2VG1k?=
 =?utf-8?B?QXNSdTAzWnowamMwS2FRbllqT0lCZDV4NlBLcHg1czd6SlM2TmlTVEdaZTVu?=
 =?utf-8?B?by9PSmloWVMvRENMN3lXWktNbW1YYk5jeURFSnJqZGt3NklTT1dFa3U2dWFG?=
 =?utf-8?B?QktYQ3lkU2x2aE84NFdteDQyZHhuNlV5NmdvN3BGL3dZUHlUbUFHTTNHUkd3?=
 =?utf-8?B?TVNFUXlUOUdSNXl6bFNZR2hsM2VjR0dOc3BTUHpkS2c1bEF3MlNrM3llbUsx?=
 =?utf-8?B?dkFDaTB3VkFhckZrNFlkUjJDTDEvVXhiT0dVcDFHYWxueS9NZzFnaklLeWtO?=
 =?utf-8?B?cFV1SFZ5cHlJZW96RUpCdURVbWtaM0thSzBBVTExclVPczh6cFNLN0xxWmdY?=
 =?utf-8?B?cUQ5NFY1eG43YkFRc3o4cHlOVS8zbS8rTTF5ZDhZU0Ztc1FhK2dsK1pPOFlz?=
 =?utf-8?B?TzRJdlM1OWxMZ1BqN0xscFRmYW5NUTI3eGpXamo3ZEN0U0pLOUV3YU40eUJu?=
 =?utf-8?B?MzA2WE1TRFpJSWcwM0NPZ2lzNEJsR0h5WHFwcUhBR2lRbGZ5UzR2aW1LRTlw?=
 =?utf-8?B?Zk55cGtwb3JoNExibGlta2MyU3JwdFAvdGw4QjkwQlhpQkZjTzdTeUo5Z2FM?=
 =?utf-8?B?WW82eUtsN3g5K01mZ0lBZDdvczlmUlIvUFYwNUZmcE9ydC9OK3NyUDVLMXBq?=
 =?utf-8?B?RXIvRUJBK0E1Rk0va3d2eHYwSXJLL3hQaGJabnprNHcrd2Z0RHJHSHdqc013?=
 =?utf-8?B?SVBDVWdMT2dsbGx5aGFUeVZyZDloMTJPb1JmZ1BuL25helU3elZZWVNjYnBG?=
 =?utf-8?B?YklCT1BWMHNxckVsOWpka1I0ZGdkL1JoUFBaYjVNaDNLVnQrcmdHcU0wbmY3?=
 =?utf-8?B?TEgxUURxajcyeTZyNGorVGZkWHlYTGlESDg0WWtYVFdwQ2FqM0RLY3F4L0NE?=
 =?utf-8?B?WnVvQmxQamxDa0c1QTBlMEdXSDYzTVhXc2ZSWXVNcDhlL0FHVXVLTFNqaWdn?=
 =?utf-8?B?aU4yS1lPZVFaNnZBTDF0QTBhSWpJS0gyLzVDbUlvRFM3NkNKdy9ESFhpOEJG?=
 =?utf-8?B?TEg3RER3dUJBRVArNHZSQUpmRFhLMkZwM1JqaEZmWmxGRndTOGM3MTZ0dWx3?=
 =?utf-8?B?NXJ6WUlsVkR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlhvQ1BLOGFxQzFURmdRZ2I0QkZkNGhBL0hvWjFwZzR2S0hMZ09Fbnpja1E0?=
 =?utf-8?B?aTJKb01rZFhBVUZsdlFoSjZDTnFvR05XVklqNWRadVZsOTBFNTJTcE1jS0w2?=
 =?utf-8?B?ZncrTTVOd29nakYydFVkYlVIUXNxdXpzN0NvWXBYNmVZd0tuaHpmbjk2K2Ev?=
 =?utf-8?B?dXNuQmNGNlhnRWxkVm5rZXNFVXJWbHVVM000VHVHTlJFalJ0RVVFUE03eUJS?=
 =?utf-8?B?K293Q2dVOEJZZFpDdG56RWlsMm9xaUhjQ05ybjJIOEQ1RUpBOXRyVStUSkZQ?=
 =?utf-8?B?WWliRVhmd2djRU52bms0K0FWTTV6UjcvYWRoMVFpY2pXS1RuU0wrdkpjandJ?=
 =?utf-8?B?QS9wMlo2QmJtZ3dhYWczN0ZOZVRmQ3pKK1p6ZFBKaUxRK25sckFxV1dOcG91?=
 =?utf-8?B?dkF3L1JzZVI1Rk90OUlKTEk5VDd5MVNjTWlQZUlHWkQydHBhVDZPaklhTWx6?=
 =?utf-8?B?amxyaE9yYy9JMUtUNGNPdWRVcEtXbWZWM2xmZXVpMUdHMVlwTXdMZkxDdzNE?=
 =?utf-8?B?eS80YTQwTGtrSHVrNm5vWFhmckowTUZla2k2TVdjcnFNNjJ2SldwYWp3b29C?=
 =?utf-8?B?SnJIcGsxcjFoK09OelZtZElRaFRVdXplWFFPY3RHV2FxcFFVaTROWUgwUE5B?=
 =?utf-8?B?TWluRFhXL2tkNmZ3UXdxVmlVVkJwdXFBQWU1TFB4TEk3T0FCclpUbW1HMmMz?=
 =?utf-8?B?Y1RMNWRjWEtZbWZUa3BoNmtDLzE1N3JtZ0ltUTNNMlliUEhLaWcyNkZiUVda?=
 =?utf-8?B?aDZTVlluR2QvQW5NTDJqaXBkNHd0V2NwKytDRU0rbFFiL09sVitQK2k5Z1J3?=
 =?utf-8?B?YmM2RDVNVmlEbVRBYTBpN1lmbmRFTDNBdGJ3VTdoaXF1QkdsRlhWUnNmMHpD?=
 =?utf-8?B?RDVLWjhyb01zaGZTWDZNMUVEM1ROZXdnNnMxMDU1cUU1Y2ZNT3ZVaHIySHBY?=
 =?utf-8?B?RkRUbXNNZEdsaTRmekRncnF1blB0WmZ3SnpuVGg1WmVYekoyVTBnNXdvbm9O?=
 =?utf-8?B?T2FhNHRpZE5LcW9TTi9HK3g4MnNjdFk1UGNyS29hTkE5b2I1SmcrZi9STzBB?=
 =?utf-8?B?NzdPMmJzOHFVYVBIZGwyQy9oNG4xdkg2eWo3RU04UjcvTE5ZNzFwVHRCWjNJ?=
 =?utf-8?B?WG1UOWNpNjA3eWNyajlieTRQWTdKN3I5emVqMFZ2ekdjTzg0R3IyeWNMK0kw?=
 =?utf-8?B?dVp2emUvZWlzN0pzMHI4cmpyUXlWYUZTT1JCL1lZOFU0Y0kvT1hZYnhzanND?=
 =?utf-8?B?RGY2dzJhTlp0V1dCekpqYUVTd1RNMGM2cTFCOS9RcEh6ZEZjRkZLeXVHZWJL?=
 =?utf-8?B?YWh6azQraUxBbmlZdExCMHBhdmJ2cjVPQlZzNC9tNkxvdC8yb3I0WnZWMnc0?=
 =?utf-8?B?Q1g4U1NkMDhKb0lPODc5dEJKM29pK3RhYXhRdnlzaDVQeURYdUJBNWIzSGND?=
 =?utf-8?B?U2c0NC9HNTFkTWszZ3pDdTdKaDRob05tNFFsUU1mRkFLSWdLZE1LSU45VHB1?=
 =?utf-8?B?bmdYMVZJUTIzV29DRGtmYnVVd0pFOGR3WGRFRlhtMnY1L3dEeGs0TkRBazA5?=
 =?utf-8?B?bDRBV1NrenFtSGUvbkl2aGNtczJjQnRZNHRkOXA3K0lWTFZFT253VUxaRU5w?=
 =?utf-8?B?bHVGN0J2bVZwTTNEd2ppTGxHek04RTJKNHowOWlDQ3NmUmV5VDNPL2xsTzhL?=
 =?utf-8?B?VjExZjU4c3d0TG9TdWY1cjFsdXdyUUFuc1BQQjlGenJad1lXUlRPdEM2S2dC?=
 =?utf-8?B?dGxnUVJtcXJFMU9DQTVZa2E4ZlM0YUpmc01mTGU3OEIxSGREYzBpR2JFSHdE?=
 =?utf-8?B?OVJ3R1dwWm9CZHdUZTR6UzBpelFKc09CTnM0L2lWSW8vaU1mTnIyODB2MDVj?=
 =?utf-8?B?M1A2OGtYVXRXejd3VGlYRU1JVFB1bDdLRGxzSGppVEhoQS8rVWFLaXY5djdJ?=
 =?utf-8?B?M0h2ZjlqYWxOYXBaMVlqcFFrbWp5a2d5QVBmTDRPaThhM040UWp2T1FkV1dK?=
 =?utf-8?B?QTVmL3J1MG1uZUl4ZllLMmxYVlNocFhEVDdId2dlOTdEVFQ0SlVNbllPRnUw?=
 =?utf-8?B?NFJ4UzI0MWlNelBWK1J4anRQRjR5ZVN6Yll3MFFNOWxtNUVqTWNFWThuOXFo?=
 =?utf-8?Q?gzu5HUcbD2sqSiBZmJLFlEVBm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84f8234-91af-4486-ae2d-08ddbf8cbce8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:35:34.4105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbxNd8QakMI6heiQA5vKIDh9R0yv0Uj5YpoXpsejW6+HL7x5JsYy/ZxsR8ne4/Huv4zZXGvR20jGh3/Esu0ypQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11512

MISC protocol supports getting the System Manager(SM) mode selection
and configuration name. Retrieve the information from SM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index b301f09ab6cc65d286edb8819031d7f4c02e8272..dc6ea67255b8b1ac95dfb552fa88b65044de8d3f 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -26,6 +26,7 @@ enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_CTRL_SET	= 0x3,
 	SCMI_IMX_MISC_CTRL_GET	= 0x4,
 	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
+	SCMI_IMX_MISC_CFG_INFO = 0xC,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
 };
 
@@ -75,6 +76,12 @@ struct scmi_imx_misc_buildinfo_out {
 	u8 buildtime[MISC_MAX_BUILDTIME];
 };
 
+struct scmi_imx_misc_cfg_info_out {
+	__le32 msel;
+#define MISC_MAX_CFGNAME	16
+	u8 cfgname[MISC_MAX_CFGNAME];
+};
+
 static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
 					struct scmi_imx_misc_info *mi)
 {
@@ -310,6 +317,30 @@ static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *
 	return ret;
 }
 
+static int scmi_imx_misc_cfg_info(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_misc_cfg_info_out *out;
+	char name[MISC_MAX_CFGNAME] = {'\0'};
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CFG_INFO, 0, sizeof(*out), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		strscpy(name, out->cfgname, MISC_MAX_CFGNAME);
+		dev_info(ph->dev, "SM Config\t= %s, mSel = %u\n",
+			 name, le32_to_cpu(out->msel));
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
 	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
 	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
@@ -341,6 +372,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret)
 		return ret;
 
+	ret = scmi_imx_misc_cfg_info(ph);
+	if (ret)
+		return ret;
+
 	return ph->set_priv(ph, minfo, version);
 }
 

-- 
2.37.1


