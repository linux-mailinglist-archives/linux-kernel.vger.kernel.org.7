Return-Path: <linux-kernel+bounces-857168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 583A1BE612A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A52574FE718
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45224728E;
	Fri, 17 Oct 2025 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cIk+8oIQ"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75616239086
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666233; cv=fail; b=azAvACprkSO9J3OKF8DeRUbDOS8Gjm/gDO0w84GGMVfdsc5Jg+o1LAjzca3IDpT/1R8YnVbu5X7O31D23oOXQHAoSR4odFw6vcyWLVaRzUHc9BB+VhtcvRk6l+wsq2lvbZLohd16lZsbIyECOW6ZN9O264TKugvoDxZXgkU2lIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666233; c=relaxed/simple;
	bh=LDtj53DbJjlleXKpoiTWgsyiC2B5Sn38Ijfb/8ZnDmw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=khDFxMV22WxggTVxrfc39pnCZkm+TJQQh4/LSicNCljS1Q1WIqhhKrenhNYXGw9HGxT9fTCdGLuuWyawVfhBcgna6iol1ojkGKIJLlcvcUT3vE4WyHGhkQOBLR1SIh5nzhmuqkyJizqg/GzukOxosk/J9WvOPj3qiS2UJfymtjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cIk+8oIQ; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDjaeprFVIbCkhVvHRrR5DhIOQSNgBXL3bG0bS/uMpj7PBhvSxBbbiRi7Vz6h0KJ3W5lCk4ZaQjq09SRBsRj1eLFi2g8HkiftmzVbva7EIJbKVgsHeTdyJ145rAsdy8dtvOZWXEirzeWQ6nN8lT4yhTc6yvbfxcLQR9G+y2Hdvee8zGeAJwK/ZBX3jRrq3uV0FWd8R4VhOBjkbdDs+1UmOuSuAXCYrY6wOKKVv7CcrN3uMDPMdUUYFPEMndyrSA351YVtNibDyW/aty5wHaVZSPgsnLkvPvKDjgWZI1rsHILzXCzad4lrTViPbRq7EPjDZj9ANRbx7I9xyXq9zwFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1LtcfOMT7T5iHdVWc6EyhBxaBgHlC86WdGYeSBN0io=;
 b=QMz6xO9t2tuqhKFdblqD4N4M3slGjoMX1Z0gOUri1+4Hupz7H1EngjrD75AzAn7/gk3hyp5IzWWowY65lu+Mvc1cQM8sEWemv/8HPTY8ry+yel3DdPrnflUb8gx0EM/2ZlkXEm5Q9/St8Rp1yjrmlicstJxWch19/VRdPtZpLzEQsRQb4R9fhvkR4mnAFz0SZY06LPxY0Z7TS0J5V2XCeO4RsEPyzlJHm8S98s5b4PkA9gkuaqOZHDVFYbG30yLmIW6hqNb4yizWanugjAFkBQEVai+EbP0HGrZu8nUb9rZ8zAHIDHuodsgYQJyW5ieJ3tMatJsEe/rnRG4VH9wasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1LtcfOMT7T5iHdVWc6EyhBxaBgHlC86WdGYeSBN0io=;
 b=cIk+8oIQjzMK2DmLKsFpNPsbodCfZLG2+X9h7JDWHYoeryQZw+aO9maIqvvFCamUNvGrCtwD2g69WIGOLlQeaZSstw0YmphjI+nFuYEM4jRmDO/JRCCj3+J7mS6xJJ8B3ie7zXNSz3tX6CRwTJ0t9hw42iqpQhQhPlHJLkZv+5w1GxkrDycQI2TcpUIt0VVgZpxqSA2wPoQOgnI7Zn3p7jwmYhCtm7ypqMZasjGI2ANRu3XhVKmDznjkVh9psma9BV1gD9lSwoBUBW0jC+WzmccdkhUyR0vnhj2yp6/trOQodjkiYSYS24pcKPu1PO+/gbYtOyVx/nSGt2IC+tkQhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Fri, 17 Oct
 2025 01:57:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 01:57:06 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 17 Oct 2025 09:56:29 +0800
Subject: [PATCH v2 6/8] firmware: imx: scu: Update error code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-imx-firmware-v2-6-b58f68ec2ea9@nxp.com>
References: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
In-Reply-To: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760666195; l=1086;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=LDtj53DbJjlleXKpoiTWgsyiC2B5Sn38Ijfb/8ZnDmw=;
 b=RVqvGgc0/dh7HBVb32RR/mPtCcjmbGCDnCf5V9ddc/ws7fiEOkyV7cV+60IYxAFSwWcS2hCtV
 Q5dhfOIAG/YDn+Tb91FO/1ipgjU7whlS37CFRcoy55bzXUAfO8Qdkep
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: baec8590-1dde-46c9-45b1-08de0d207953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2ltVk13enNwdG04ZzVmRldMaGN4UElONGdiZm5mMmZmTllmZVpuVWhtb0Ez?=
 =?utf-8?B?YVJ5NGxydkNmMjQwSTlvaXZCYzJ1MTRNRHhFTmdDWnpsdEo4VFl5ZDBFTDln?=
 =?utf-8?B?S0pXVkxURXVNR3dXeTNTU2IwMTNpNkszdzJkREVXZW5tZEdwTndKT3RmL1Nk?=
 =?utf-8?B?QWtTNU1aZlBaaExWc1ppSFhweXI4UFM3R0d2dWMwYVhHZlpad21mejhxTzN6?=
 =?utf-8?B?dkcyTDFuUjdmaFJnMzQ5ZEkzVDBWM0hRVTh2OTh2anFqc0UwTHlOV2tuZlJh?=
 =?utf-8?B?c25ENE1WYndPOXpNZ0ZqWnZEeUhpTStPNVBiMFNDQjZNQ08xTFc4QnJ0VWRm?=
 =?utf-8?B?Tmw0MmFJbzhsQjlCM1JBOFBRcklPeVJ2dUI2dXlocGc2aXlJWC8zQzhGYU9a?=
 =?utf-8?B?YktIdzVaTUduQ1VPM1VLa3pVamlaYUd4TVEybXNqRFZIcU9SVkEzVkI1YUgx?=
 =?utf-8?B?VzdlbEp3eEJWMGo1L05oVDhFQlV0T3l5Y2ZFT2FIWjR3blZnY2hqaWZ6V0Ro?=
 =?utf-8?B?ZU1hK0Z4RVZadmpKMTl0akxick5EZjhDOENTdXJYaENCMmc4ald6MEhaNUc3?=
 =?utf-8?B?MzBUK2htQXpEZzVmSWxvdjFkRjk4QUdUbHlLQkt3K2M1S08wYUhpd01vcVo0?=
 =?utf-8?B?QzBiYkI5QnlBU2JDcmlnN1hUSDAyTVF1ZWxoU0ZMRmdweExaTEdNQncrOGxp?=
 =?utf-8?B?cHY1bnhEdXRBZGU0WGZiL0QydkpTVVM5VHhDN0hwQzd6STVFRUVJTmZCMTVz?=
 =?utf-8?B?d3ZOaHlXNndFQVk5OWJYUHpkc1R1ZFY3M0x1S3BDT2M4ejFNamNlY3dyZHNT?=
 =?utf-8?B?cEt2U21DMkFPVXdmSE9oQkpUd1NOTzlsWEpKTUFKUlVpM2FGOG9ua2RWb3Mv?=
 =?utf-8?B?WXphZkJwN2Z4anh1My81Q3BWYXAzdDBnTEduakhtdVRGbXJGVzd4Vm1QRUx1?=
 =?utf-8?B?a3p6MFdBM2JHSmNwc3RQbC9RRkh6aU9rdEs3VjdMYi9CV29WeWdwSWNnL2pY?=
 =?utf-8?B?L1JJaFpmZXVzTjZyQ1lhVzNNMzJJWEVkSnJ0cXY0dlZ6dVp2eWhjZTMzUXdl?=
 =?utf-8?B?RFFFRXJHK2lBbGlQbWhoSkczYm01TVUzUUh6UkxrakVuRnNGMjh4SW92T3V4?=
 =?utf-8?B?YlgxeWE4amozMVJMVjVtekorWTA3RVVNWjJ0SGNGOWhPV1hHWHNpWk9oVkVP?=
 =?utf-8?B?eVRUM0pMMWo2dkVsZVp4S29YVTY5b2RiTURYTmFad21UcjNFR1lVTEZaVmZF?=
 =?utf-8?B?UStEK0hyWHU2YlJyK3Z1VnRhN3ErM2pNNjJCbUtvS1RVUGFFQmE0Mno0cWdy?=
 =?utf-8?B?UkM2NVZ1b0x3dkFPK1ZBKzNGazQwYlRNcXdnWVNYam1qZWl3ZTFWWUxVYWhN?=
 =?utf-8?B?aWZQTVJvaERxZUV2bmN5OGU5Y0RuQjkwRHdicHdId3B4WHZpU3dzL2E3UWJv?=
 =?utf-8?B?eDNxN0RjdTEray80dllJOU05K3dick5zTEhDQ2VUdGk3eEtObmdnODRaSDhU?=
 =?utf-8?B?R1hZaUhzd2RmdHZpMzJvY3hhYkdxQ2YvdFNzQWlRdUNSWHJOcDFuK0JsUm5h?=
 =?utf-8?B?RlVUTE5OMCtZSXlXZUE5UGpFQVFDYXR6ZzZRWFl4dkNDVmowYlNPSmhiR3E2?=
 =?utf-8?B?emJuUHAzNTgwM2xiWjE1N1pRWXVYTG5QKzFuRGF2dzNzVVpUaGJYU0JQTG85?=
 =?utf-8?B?d3VwNlZMMFJPWnd2RldtRk1HRFdTRlpzVjhRZmZNWk0yQVdMaER6TzVIRHJv?=
 =?utf-8?B?U0pRWGJPU01wQllldVAxaEdreXJZSmNkTWc5NFllYk5acFhPeXdzM2JZbnNF?=
 =?utf-8?B?V0I0YmhDNVNvcWEyM1hCWHl1Q1l3R09wOWZjUGl0ck1lRzZDRzFBRnlvdk1n?=
 =?utf-8?B?a2ZWQ3RGeG1GTGlMOUFkdmhlY0NFSTg5UUVaVUhxOEdSZEJEVUNvVnVqUzNK?=
 =?utf-8?B?TWY5NC9nQnFJMlNTVjF6VU95K0pPZHFrTUhkSStTcWdvMEpWYU8zMEp3dzJm?=
 =?utf-8?B?Kzg4RzcyaUczRFd2YWxVLzZsN0ExbTlRRG1NQzBZazZmdU0wZzN3VzgwL1o1?=
 =?utf-8?Q?QqxzIF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SENzRWlVdVFFaWhMVE1ySHdzeG5GREJOSGJjVTNndWo3aXlJbTRqNzdOS1Bw?=
 =?utf-8?B?eExMcEhCM3JFMTQ5ejNaZFpMdkZBTG8zS3FOOWxGOWtTWEdLcmcyYlRaai9V?=
 =?utf-8?B?UE8wNzY5MVpKb0Fieit6dHhrMEFtYkcvQ0xvUEJjNXRmb00rTTVFUU1SNk80?=
 =?utf-8?B?aE9vQU0vTHBYY1Q0RklkMjlyUUpzbldOWE95dnAzZ09hY1V2WmZHZjBCenhh?=
 =?utf-8?B?WHBwbDFFZWtPTmJkcmFMdjBqNUNGQ3VtZFlIT2lOdFRTdFpGUG95YnVNMmlt?=
 =?utf-8?B?K0VrR3prYmdqMkJOMm1TbW4wYkJSS0VKckQ5VnZzdURoWC9hQUdmV1VHdWZ4?=
 =?utf-8?B?Nm1BZzkxUjloOUZGT2hWa1h6eUdTaXR0TEJJY1R5YkhwSTBEVTYwcFlhS2lZ?=
 =?utf-8?B?RnVzL0hoZ2JsREtNWXhiTFFUamF2a1h5M2Q5cHlxTUJSQlp5ZTlpeUsrbnEv?=
 =?utf-8?B?eVpWQVdnVW1ZRmppOG9FR0RUQ1h1enJLT3huaGxKbE1USVRwcDRoRDBFcDhk?=
 =?utf-8?B?Y1Mxb0Q1Y0Fsa2pxeUVpS2ErdzJ2aUdpbU5IazlSbUNnUGY0Q2FHSWNJR2Qr?=
 =?utf-8?B?RHlGSmQ1WUJUY0dsa2Ftb3dVVTFzc2RYTXJMckZueTZ2RElJL08xYWk1YXFT?=
 =?utf-8?B?Q01sOEJSMUh0VjhDYm9qTVo2NFZOTGNtQUJSd2Q1NDdrMU1LSUlCQkhjWDlL?=
 =?utf-8?B?Y1E5aG9HWEFRTFBjbHlMQjdxL1ViUStRa1ZJMXJvcjU5Vk9PRGFJNlNFbXNN?=
 =?utf-8?B?Z2U5ZTNvQ2dVcU11bG1Mdnl5elpzcnVsZ2ttTFV4SGoyNUpGaGFoYTFlNlRz?=
 =?utf-8?B?VS9kWFpRbzBMRStBaUZ3OVpCZFJvTzJ1Q0NXbzdMazRyd253azlVNyt2SnhZ?=
 =?utf-8?B?WXZGakZPYnlCRFo5enVBdnEvWVVJTUNtSkNPbUZUUGlJd3I3MWhEekg5blA5?=
 =?utf-8?B?YnIrWGJsdk03bjRIUVlDSVRVNW1OdWk4UjZQdjZsckxUc2NGSC84OEJqZkJ4?=
 =?utf-8?B?QVI2K3g4RzFIb0VrTXd2alVyY3QzRnRSWjlCbk02UjBvOUlsVEVtRmFoZmNT?=
 =?utf-8?B?cnpUVUU2SzBpZnluUHl0UFJ1eUJlZ08xWk15OVpKSDNvWWdrSGFmRkxRWmxB?=
 =?utf-8?B?WFp2TTFWdTNGbkd4Sk51T0FVTDR1QmdRZm54dTFGQXdWSmZzUkhFS3pENlFI?=
 =?utf-8?B?OEllRlc2dGcyNG9uYmNOZkZ2RUxMeFFuQ2haRlV5Z3Q0Yyt6anFmRGFQdVZr?=
 =?utf-8?B?eW85bzhEV2YyMW91Z1ZyMlFIMHhwcHVFak5CQzNDMVEweCsrZFZ6Z3I0cDZK?=
 =?utf-8?B?YWlkUUhIamdtUmtBUm5Jc2VxUTU1MlNwMm1IQnAyMHVBaFc2WTdWU3hEcDZW?=
 =?utf-8?B?aXcrZWIzb29sRGk2eVlVNk9QcjJVcktiQnI5bjduMW5aSjRuUFcrVkNjQlhF?=
 =?utf-8?B?dHZrN1I3UVNvUWU4OEF1U1dHbm5DUFhHT1JxWUdQbWg4VkU3QStzN1oyUEtI?=
 =?utf-8?B?ZTVpaHh5amk2SndwVE4wZjJRcjQwMlFuRFZsNnh0cEQvenhsOHZaeVlDWTV0?=
 =?utf-8?B?N0NpU2R5ZmRkM3F3VitPMlNVbGl5Y1oyZEtrelFDRmFtVWtxMzFJSFhzQm43?=
 =?utf-8?B?V0o3eTNyNC9sZlgxWE5ZOWtYL1pxNXJIcSt4b3Q3Y0lva0VrT2xtK285bmZ4?=
 =?utf-8?B?clNSTVNHR1dndENvUmQ2R3I3bDYzV1MyeVVEcjdFbWU1Mm9pYi9EbDloVTUv?=
 =?utf-8?B?UTFVSXl2TnpXamhmaVN3b2Z6Vk1qZXdZdE1PUE9QREd4YWxidUVHQmxoSmpP?=
 =?utf-8?B?TDFJeGh5SXlHOWpCL3B0RWYxM0UvblptODZkNUEybU4xbm5uVzlFUUlxUUti?=
 =?utf-8?B?OTlnYkx6QU1BS2wzSysrOWdFaHJOQWk3QTU1UzhzODFUblZLT2w0aUJvUDVO?=
 =?utf-8?B?NWNsQ2NsejBCQ0lGdTNoNmNtVkgzY1JVT1VTQUtadENDNmJOaG5GcDJmSUkv?=
 =?utf-8?B?UXg0dlF4b1VwMWtFaGxXZWJFQ0pQeE5zYlZSUm1KN1pBRjVVYVR0MGl6QnFl?=
 =?utf-8?B?UmJ1ano5YnkveVhXL1ZrVGpZNG84bzhmN3Nva3RvbmNrNU9neURsckxIVisv?=
 =?utf-8?Q?ISq2mtXet/2jeWPdDl2ku41za?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baec8590-1dde-46c9-45b1-08de0d207953
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 01:57:06.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Up9hZvaXu9cLvx4ZJRiEDxsdJNto33kJ8zU6zbLwFNGoDJpcmhxTyOnb+dM9Xv+4BX+WdEW5J3IO0xbflGxq5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

IMX_SC_ERR_NOTFOUND should map with -ENOENT, not -EEXIST. -ENODEV makes
more sense for IMX_SC_ERR_NOPOWER, and -ECOMM makes more sense for
IMX_SC_ERR_IPC.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 8c28e25ddc8a650d2d191c40193cf1fb5e70bc35..6046156bc3c9abcd8f62b46f04571b1a9decc0eb 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -73,9 +73,9 @@ static int imx_sc_linux_errmap[IMX_SC_ERR_LAST] = {
 	-EACCES, /* IMX_SC_ERR_NOACCESS */
 	-EACCES, /* IMX_SC_ERR_LOCKED */
 	-ERANGE, /* IMX_SC_ERR_UNAVAILABLE */
-	-EEXIST, /* IMX_SC_ERR_NOTFOUND */
-	-EPERM,	 /* IMX_SC_ERR_NOPOWER */
-	-EPIPE,	 /* IMX_SC_ERR_IPC */
+	-ENOENT, /* IMX_SC_ERR_NOTFOUND */
+	-ENODEV, /* IMX_SC_ERR_NOPOWER */
+	-ECOMM,	 /* IMX_SC_ERR_IPC */
 	-EBUSY,	 /* IMX_SC_ERR_BUSY */
 	-EIO,	 /* IMX_SC_ERR_FAIL */
 };

-- 
2.37.1


