Return-Path: <linux-kernel+bounces-816366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C9EB572E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F4D3AC7C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719032EF65F;
	Mon, 15 Sep 2025 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nSGuV68j"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D902EF664;
	Mon, 15 Sep 2025 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925023; cv=fail; b=t25eKpsaVuY3U30htek//PQgaz9pWzUcerCJMUIo4N9/64Iu64PmWUvKOcIbgsA3OdIJne4usHSJozR7bPhiFmo3GgZ9oFawuH12PJV2zUCz9t/5LIxoBftbZj/b4eCqMNeJGL+XfCVb953hiuR2N+RJso+YgNEp3ztxJV7ckg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925023; c=relaxed/simple;
	bh=b/YlDremuFjUMekE7oETCp7MNf/xtDoQoxvSBS9DXdI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b2TL9Lg/7EpbpQlwh1QgkGnGVyKh/ma/Gs0T2kblDv8yRBOxMG0KuRi77XC6qel6LnUnw9qt75j9A4r2AokIcoXlum5OEzSQnsRdKnMSHsM/QBFTkUEenXeRFCCdX+nxj2FZsSt4IWsxWnjGgj/CFWTe7LhHVWcTzpUuU/zjrDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nSGuV68j; arc=fail smtp.client-ip=40.107.130.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gz9AVH2/NksaSOMkX6NcaqJ28P3zmkypHeLO5FjZYZNsi3i5RTRkD5bdiPBAQrJxkFYo3wi+h68aasfI/QB8I1qjJiKV+gh1Hs/Jsi+f+AD9h6vh1KGGWbMDz7Pnw5e/8s8K0S9vRLgRCfCK3Vak5FelMZYUs1nrQ4BC1ynczF2MEx9tRgne/Qf9steOGyf+XM+lbdm+rLuc3Hfc5Jj3cIXnCNm2I4/BZuZay3NjGYbdFWXU/lGd5YQ5V98Rje2LWlP0oXCtS67nZzJsEzmAVnlM/NbvmZIrMZsw46eTTx4FQPgu1GXlROM/OXqLQ14p28qQ3zbpfMPb5WkJwyh60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFebTBDzzDHv9feDEZdCCxUxCpEUHmBHXvqdQCzZsso=;
 b=lanVfUyVsvDPkVtTQ+vr8nW8j4gB0r7ZUPr0PKkp9tSOtQwXymgPK//VUzh4AfSvyE9PvkQ5uLn8PfNOC4AYXaTqjEGKG6S+cL02+SKsbk0O+SgSI70NqshFDAB9K25i7DxJQKAlnCH80AkbIU6IO7sXCrwxk/UbdOvSdx/Ns/hAcN20o50pWY4Ye8bCIXHozuSxrWSG3IY3MIBYPXbTKNUsjEOQJialiXNcoXS6Ex2WE8d6cmvMNxsOAOfZGYCWWRG80eIwtl+iTpnxk50ASNbb4mXcmOUWmEar02KsdLpd+SjTYlTanYMS6HxH0+p8ms7eqO02R/brtg9pAcg4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFebTBDzzDHv9feDEZdCCxUxCpEUHmBHXvqdQCzZsso=;
 b=nSGuV68jn1elx+u4Az3UN3EM8By9yJiNiIukwOyaMuU0/XRmNbUMoUx1PtpcM9f3WHOO1vrArBUNOEiTfOpA40GnnkMkdoGqQo0FNNs94JRyeRafhw6eHZPEVnaGsvytVpqxc3zztoW+e+c1CQmGGedYmSpD96enlRkmqRf4/e5agp//nt5blAZZ7fhNqlIqfhs2aTZo7ys9ZMatIzmSGdToZzICPOREP9Jt7H82Q6sOw311wo104NsEkrU6w1ljX1hkhx88YfqoMviF3yzx8B1CgvR52zkW8HzQKINC25M0lEptTf6JDxnuscd63HJqAakU2Y/HOVFuennghZc9sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7181.eurprd04.prod.outlook.com (2603:10a6:800:12a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 08:30:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 08:30:16 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 15 Sep 2025 16:29:35 +0800
Subject: [PATCH v4 1/5] dt-bindings: clock: Add spread spectrum definition
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-clk-ssc-version1-v4-1-5a2cee2f0351@nxp.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
In-Reply-To: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757925004; l=987;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=b/YlDremuFjUMekE7oETCp7MNf/xtDoQoxvSBS9DXdI=;
 b=ZQP/Xgr4C3eEGvJNl1CIe5ekpIqvoOafEYPJyVEvcGpnATskXPuWKoaN5ozPI1ZHBsZtDPzav
 pBrPDKnf1r9C9ZUtvGK6g7AWvM2mNJhxKfJS8xDhuVw/udsgnWiArGM
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfb0ebe-25eb-4f43-10e2-08ddf4321904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVY1akloK01vS243dVhIOU96dnNmR0Q3QTIyWWFIRjZnQ2RjaEE0OHVKeE1w?=
 =?utf-8?B?Q1dkTGVRSy9RanpXNEJFanpHYXY3WDY1M00xTTBIRnNUb0J2YzIxM0NkNXhT?=
 =?utf-8?B?TUFRaDl2SkVxSHpzMk5CSS9Zbkh4d08zcUh5alFPK2puV1hCdW9WUEtNTHFr?=
 =?utf-8?B?TE4vWXBjeXBhWFl1NzE3Y0RmVWR1am1DSk9NV2FXa3E1Tlc0WHNaWUFMeW9O?=
 =?utf-8?B?K1FiQldHZmREZ2crSElsU3dzR0xZRC9laml4REthN0dYNUd3N0FwRjk3ZTVN?=
 =?utf-8?B?eWIvUTJhSzM2RDVCZ1dsTXJCaFZXYklhalRyYm5mc2tuVUlQcG9QNWNuNW9m?=
 =?utf-8?B?ZnhrU1dWWDZIdkJOOTRvT1VrRjhZSEx0SGgyMDUySUlhNi9zOFJrU2JXS2Ir?=
 =?utf-8?B?ckZsV2tTbmRIb1hhVCtySjVTOHErb2ErRWhJQkx0YTZkUmR5eGtQMXNtRlZV?=
 =?utf-8?B?bHdJYjdHdHkydkV1R01TMzFDS3Z3QVhQekljdEtJUms1SHRUdHR4V3IrWFpV?=
 =?utf-8?B?MlpLcEVDaGtwTUR5ZU1jSGFwV0JjQzYwZ04vQWdwMHpTdjVSdUNDUkxsQ2pR?=
 =?utf-8?B?N09hWHN4RTlMZzJNUmRkdndiem5vNVlNcHdocVAxTmlvamw1czFGQW0vN1Q5?=
 =?utf-8?B?VlJPQ0hzWU9UWDM3VEhjN1Ircjc5d1pyaWhmSkx1VW5GVlVPaFBWVVlwRGZU?=
 =?utf-8?B?L0wvKzJLOEpRdEVuSHBvcnZWNFRDeVg2TkdSd3lyOHIwRnMxeXFhOENZQnNL?=
 =?utf-8?B?dHQvbDNjU2NoZzdQSEhvbUR2bFNXTnIzVzJIMVhNTU50cTU3OGl6TGJ2WTVs?=
 =?utf-8?B?bGJCNTBlTHpWWXdyRWlNRWIrUkRvWVg3eC9EN3J4bmRlWjJyQnB6WVFkcVBz?=
 =?utf-8?B?TVZTaVBrZE12Y293VE5MZGpIWHE3Vk91M2RKMGQ4TlBISFhLZVAwN3htK01D?=
 =?utf-8?B?LzFEM28xSWh6dWZ5WkJJTUVQODJUWllqWU1yM2c4L1JqQzVPMHFXdzJhSlVX?=
 =?utf-8?B?bEJDTWE3WkRKSTVSa0x6RERMYUtDTXU0cHpJZ252a255bGMyUjVHZlRvOVQz?=
 =?utf-8?B?N1VUTXVlbWtOemV1a3V3TlpDYTNKcW9RVlFXUStTV1ZwYzBKRFlwWWFYSklR?=
 =?utf-8?B?Z3dOWm5lMmU3a2kvVzEzNS9tQUpCaXgxOFA2Um9XcXViay9WdnZFRnp2cnc3?=
 =?utf-8?B?ZURVMzJuVFgyYUNKaEhWS0oxR1RjSm1VTUhhaGVCOHpMWjFvV2k3SjExL0J3?=
 =?utf-8?B?ejZQNEJhNU1SSkN3cThDU2JBUXNyN3F5ZFZnWllqMHVWSURkYjNjdUlITnJ0?=
 =?utf-8?B?M21GamtraWRBRTh1NnU1dHF0S0lRQjZ5MTNWelV5enQycm9Mamg3cDQzd0JB?=
 =?utf-8?B?UDJEaWpUSWVtRE9YYnZaaWttRXBXMys4NWFxZTZxbWtwM0lxaGlaRW5MVGJI?=
 =?utf-8?B?WmIzNXBOL2lyRXJLZlJFdWFZVjhJcmp2eEw3OG9HZDBnSy9EekVCbEtzRU1h?=
 =?utf-8?B?Q3BvUytWN1dLWS9pOExBVHFzYVRkZnVxd1pJRFN3bjBpU3Z1L0xTMFpVai9L?=
 =?utf-8?B?YjNYOVFyWWlBWDMrazhaMXlNTnpqTWFmZ3lTZjhhVGtza1ZVdmNoYXJYUDFU?=
 =?utf-8?B?VmJCR0NJSWlZZndPcUpIaHFiNlR3N3lJRzdaRzAzd3Q2aWZNM283QnFlanYy?=
 =?utf-8?B?a1Z3M0ZZSGw1c0pTVmRNVGdtWVFpQ1lmTXp3c2xRL2g3VkRhdHZRM1RXUFdC?=
 =?utf-8?B?SmsvK1VMT1hTOVBFRU5xV1dUV0xoWWdUZDZmSHhPWU9VdVJWK05RaEpuQzBq?=
 =?utf-8?B?QVd3bUo2SmRuWUZZbnhpVW90M2huZXRuS3Fxa1lsTThKM013d1lrT0c0OUI2?=
 =?utf-8?B?MmF3MzZSckZPVHhGVDlqekN4WGhhdzlFeUtnQjdpMXF5bTFmK2s3R2lVZ1BW?=
 =?utf-8?B?WDJDUkw5SGwvOHdVbEJYWmI3YXgvSnJHVUFGcVNwYjVWSnRId0MzZ0lHcGRT?=
 =?utf-8?B?Z0ZjVWlnSXhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UStWdUtpMWZCZXFhZ2drMUZlSmdJUmlCQkh1QUJNSzJBaTFyU2dVOEMvbU9k?=
 =?utf-8?B?cGd3OWtORWxMUHRKLzFBN3lmWlh1Z3ozMGRXTzd1NThGM3dXVW5BWGlJclBX?=
 =?utf-8?B?cHc1blU0cGRGZXRTcnFyVVdOaDcxS2FleDJjb0d5OGVEWjZ5NGMxQkFwTlNu?=
 =?utf-8?B?VjdMdUh4ZGR4d3h6bUdNZlk2aGx2cUtKeUJOakZYaEx3WGdTVDVJUXhzajVh?=
 =?utf-8?B?TGlXRHUvRHRDZ0YxaENOZVZucG8vSXhPVjI4SUVTTlR1eTBwcEVNK1VabGNq?=
 =?utf-8?B?Z1N2cHRySFMxelpyRVZLVGQ1WkpSckJGRzhhQ05QdFZoMGEwZlhrU0dZMXRE?=
 =?utf-8?B?NDVKeXhSTjVuNk9WYzV1WVBxLzZaUU02ZTdodHd6MGViR1J4NnExMDBQQzJo?=
 =?utf-8?B?SlA2RDlLYUdBM0ViUEorQjdVN1lkMzk1M2FFZHR3UGtiN2pTejNDS2lxT0tU?=
 =?utf-8?B?TnBJKyttZE9zM1lWYUo3Z3FneFQyTTRpem82dFU2a2MvemZsazNvSmZyUnNX?=
 =?utf-8?B?akZrZ3RoOUNYTGh6Mi9pY2R5ZmFwZHlCd01xbi9FalltM0oyYTJhRUlmbXkx?=
 =?utf-8?B?TGlLZ243K1h0aG84YzhCb3lUQU1YYm5ldHRvM1JObDlSM1RvN3NlNEQ1NTdl?=
 =?utf-8?B?VUxXU1RBRjBKMUtxazh1ZWNSWTRWVlFKdkZJUml6SklWK1g2REhjbkkrM3Ur?=
 =?utf-8?B?MGg4alRyc1ZmNCtXYUpHTWJsRXc3bTlYMzNkTExxSVVYQXhabHVyQWRtRGlM?=
 =?utf-8?B?L09yb0Z2dGo1eVp3UFRTNXh1WE9Cd0VUb2gwbkt3QU5Gb0pmYXRpMGtnVTNy?=
 =?utf-8?B?amw0TVRIRFdJV3RneGhWck9ObHJpbCt3UFNSV1BOajNhOU4yMDZQMUUrQTJP?=
 =?utf-8?B?eW5UQW1rc3AvYVhXcFZaeGtOa1pFMUZNa0FscmdXZUxTWEZzYTdXTS9qSXFx?=
 =?utf-8?B?cFN6VFVDMXVCdEk1NTRnWkxEU2MzZ1RNZ2tLNS9EajlPV0h6bXY5R1JIaHQ2?=
 =?utf-8?B?WGY1YTRLMzl5WE52MW1Wc0FjUFRDbzUvZTF6dlR2dzliN25pMkhrMXhLWEN6?=
 =?utf-8?B?bExIYWNvSHVwd3VrMCtGZXNYRlUrQ29zZWRRZUx2eXQ5WmhzczR3NHBoYXR0?=
 =?utf-8?B?bWVNVUQzeU0yT25Rc0dNdXZNM2E4R3dPMkJteHVqbXYxQkFTV29PcDc1dENY?=
 =?utf-8?B?RFgzVG9wdXp6UUlSRWtXaDZUUHVnalc3NE9SNlZYVWVzN3ByZndMeU5hMVdR?=
 =?utf-8?B?MWhxcVVCQnYvVGlvZTVZT2w2M3BaWDF1cEFRYVRlSVcvNS9mMkR5c01LdGN2?=
 =?utf-8?B?UVVXQVM3czJVRHk5aldaNzlVRG1IQkJ5dTMyNGo4ekI1dlJnQ0cxWXJYQWJ1?=
 =?utf-8?B?TkNOTWtKM3ZzeFBCaWFGWXh0VHVtTlpFQk0vNHhkNTZ2ck94b2cwU2lzRyt5?=
 =?utf-8?B?RndnZ1lPS25mY2NjZEFhWnBCa29Db1lIM255VWJXUEhzZjkvYW1pSTE5cUlz?=
 =?utf-8?B?UW45eGI1WkZnSUxUOHJ1QWJZdStLM3M2aVdaU3VqNUxjcU9VT0lGR0FxRTNx?=
 =?utf-8?B?UktWM3pCcHFkK2J4V3RZOU1tLzVWOFg0L1JkeUJOcFhVeWtkSldIemo3UjZp?=
 =?utf-8?B?ZnJ3dW9PcndxckRiYXBoS2I3SEJSc2hMZnVOQk5xTVlOc2pycXdlVFRaT1NO?=
 =?utf-8?B?ZExNTzlhUkROSjFZOTRhM3dacVhPSlRKYVRiSmJacG5LRG1WdEhyS2hXUkpP?=
 =?utf-8?B?ZUFJb0Z3RXBRWktiYStxS044VHNlQXdRaDJxenFUNkJ6QUV3SGZIRFF6RG9U?=
 =?utf-8?B?ZDdLZ3hUMXhLeE4wRUJrclA0VXFPeFBBQlpWVWxISjE0M2JrUFpWbXQzeitp?=
 =?utf-8?B?OVRWc0EwSnVZaUJmSmg3amZDWXdkYktMSkRVVitvd3VYbTZIZDJqeThnOGpC?=
 =?utf-8?B?SkQ0L25TVlZoM0JCZ1lDblhnd3FKVGxNOFhwMUNiVUluY0FyRDVFdjFlRWpO?=
 =?utf-8?B?VHp2eWYwUU94SGNUSUppa01zb3VqaEl1eHo0aFhKczJLcHl6MEFiSDBiaVlH?=
 =?utf-8?B?TFUrS3BvVXpoaWxKMURYK0hiU2hCY1dKTTY1ckIxbXBVS2gzWXI0Vlh2cm5W?=
 =?utf-8?Q?mdBYElXlh/7fxsfC6AGQiLnUM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfb0ebe-25eb-4f43-10e2-08ddf4321904
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:30:16.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5fkplZ5eA0Pf7kZp4R5jmwDiwzE8ZF8S/ki9Y4YWkCtbVHJfsUyz6HhabVMMdrz0OARoyvgMmXXFHH8qvZ//w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7181

Per dt-schema, the modulation methods are: down-spread(3), up-spread(2),
center-spread(1), no-spread(0). So define them in dt-bindings to avoid
write the magic number in device tree.

Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/clock/clock.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/dt-bindings/clock/clock.h b/include/dt-bindings/clock/clock.h
new file mode 100644
index 0000000000000000000000000000000000000000..155e2653a120bf10747bd7f4d47f25e0493e0464
--- /dev/null
+++ b/include/dt-bindings/clock/clock.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_H
+#define __DT_BINDINGS_CLOCK_H
+
+#define CLK_SSC_NO_SPREAD	0
+#define CLK_SSC_CENTER_SPREAD	1
+#define CLK_SSC_UP_SPREAD	2
+#define CLK_SSC_DOWN_SPREAD	3
+
+#endif	/* __DT_BINDINGS_CLOCK_H */

-- 
2.37.1


