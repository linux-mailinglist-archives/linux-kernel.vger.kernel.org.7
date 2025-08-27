Return-Path: <linux-kernel+bounces-787705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16652B37A03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6BE1B62038
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7984630C601;
	Wed, 27 Aug 2025 05:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Pk8HXh5R"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EC728E7;
	Wed, 27 Aug 2025 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756274039; cv=fail; b=epTXyQ0R9MH2WzOGKF5yN/mUC/1ztjnDSSh5N6tOZP4vGAWBGtgvdvFfkkQJ6V/d5WZ2uQaSophEdJb0oa+6ilq6ybnHl9qfMZCQOxB0alW3cRNgtMWkplEjTpI7rBgz3TrTaKP5rzuRkovr+/r6yCojIQ2lbpbIag7QOlVDh2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756274039; c=relaxed/simple;
	bh=UMdiESglwOD5LTqRo6menM5q5Mm3g1pZRpmqueUWEFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dONaclBS5KfATpYZORueQOHRgk/j++Zb1hUkfEQKK5gMusqP/vYeDSO1L70QBdWx0nLrI5YYrm3bOMxYbC0WyOMsH2yU0V6XXCL2FV++nQTnNXtJTw0rhVhgIFiU4tzKUFqy0gnwlY6YUtPCQ5SLE4Smgj35VnvQuYTldp8VcfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Pk8HXh5R; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTqWvv84x6UIRlV660JksNtVfqphDpp8rG6v1wZi573OFbe966mckeSAI3DZVvkVc0bqq5yt3APyrpYtlxix6zayh6Kq0EPhJ/wr646Y77dy/NRtb2c0Ir+vXlDKoQbD7DiF3jxCPYY7JmVrdmrFib8Ni1+HVlpU0gWAxEtTnLJqxvMNUaPykmGr9ba0C5VmksjKqmDmb6UIzjFu4oyxR+/02g8sFagM1SpupeBLQmUyq/zPeExr7mJBHvAJSgwWYq/CGhHw6ZOlnU6tVLY71F8IQIv8cFyN0vtX8tB69UfRf6Z1MmFsdHnhOkpuzx9imR6HcK2FUhlRygmm48iKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wHs8et1+JOmUzd30aCL5CLYzQ+MAwxSbNFxlmyGCC0=;
 b=l26Or2+p+x+Wk4UMJi93FZyI0ECmTwT32yLSHZy/czMP1J+wWM5A1bF7wxlPZoo0fNZjj3BiltZbQtbhpEc+y2IJII0ohY718mjUFvslSvPIzU4vvJNGd8eNKtWsUnyGJvq/UePGeZbNw0Xl+WVrDdDaKn10lUssHorbNAUVS/k/IJ37bmtC+qHLxbHxWZfOyLyM5kTTLZ+6XV1VvFynVy5lnK8hpQKsobQvNy7sGaH3lQ+Iv8RDRE+KYQFFy/ykbvfAjk0Nd7TDB99/C/FI9KItlXuPiq4lzEJfX5oqdkFLSe/LipmH5/1j4Kxa+Rkze5w00gnzuiug6Ni0xT9j7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wHs8et1+JOmUzd30aCL5CLYzQ+MAwxSbNFxlmyGCC0=;
 b=Pk8HXh5RofcQLPuhMsRigLLhZwLeFmO5DkmwWEeUZXLSMeNk45aUTpPpvRcM3YDH1E3cRXbbrbZtIBw8iao9jWFTBIE2yjo3xoXAFQxxd1xc1MPG5OXsgFDthMPaVaIBIqJeeBd4EGMNfFOhuiwD9z9V2p4oS3Ub+1EfUJ4uILIDUNBZBasoecg5g15DRrsAkxhWaIRkcmNd90kh/5DPEwCdvU7j7pjQUWgXt2jR2lZhb6U+uEV1+yZIR7jXnc+X7MuQl74UkKcvyiStCODrt7wIbeOcYk0goT/kOa+FJCp4Hte0DTx7m42nT7n8ApB6v2Xq92fIIJQkzB2oByliNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9524.eurprd04.prod.outlook.com (2603:10a6:10:2f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Wed, 27 Aug
 2025 05:53:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 05:53:52 +0000
Date: Wed, 27 Aug 2025 15:05:05 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] clk: Support spread spectrum and use it in clk-scmi
Message-ID: <20250827070505.GA18994@nxa18884-linux.ap.freescale.net>
References: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA5PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 4092da0c-5116-4565-57a2-08dde52e1a30
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUJFeU1BV2dzdWxrZlFvQjJWY3plY0VhYXlUWEl5YlY4UkRSYTBMMFdvdTdr?=
 =?utf-8?B?a3FrSTlkdHQ3YTcxczRJc1RmdmI4ZERjRzFCZ3hONHg5cmduWm1qdjdac0xt?=
 =?utf-8?B?dWFWcGh6aVNPRXRXT25JNlFkSXRTY09wS1RNN044b1hIR2FaY1F3YWVRSjlz?=
 =?utf-8?B?blc5QnMwTnNIMzJ3WGdKMVFJcG1kbWdIdXZKZUl0Q1R1Rkl6MFBFOGh0QmtF?=
 =?utf-8?B?VXlrUFVxOU9abkRXYW9QRWhOTnhiZGpPOGhsR09iMFVQS1NrRmJsZzRLSWtS?=
 =?utf-8?B?N0V0NnA0TEVUMzVCak5IZ2RhYzhPZ1FleHpRbTFlWEVGdW9XSUtGNTRLMk45?=
 =?utf-8?B?d1NDMDVwMjlFWmJ5NkpTeStNakw1eDRnSlJVU3hVYmFmQ0wrMVB1dUx3Qklz?=
 =?utf-8?B?OFQ1YTU1RGd3M3Nla2haczBEZzlsOHMwRTFndXN2ZGlnejFzN3VKZEdVRGtS?=
 =?utf-8?B?T0FDakhPK3NqL1JjN2VKcTdUdWJQMWxDaE9SeHk0Rm5vNVJvUjFNZ3UzMC9O?=
 =?utf-8?B?N1lzMmRUYmtvSGtoQVUvMW5XYUx0K1JOQzZBU2IyWDRkaUVQazhIZUtRTVZ5?=
 =?utf-8?B?WHJ0akZBdk9pVUdGSU5PNkpLbkk1bUZhbmxSUFNrZUIyMFE3dGhMb2I2Q3Fq?=
 =?utf-8?B?cVB3ZFlIUFR4R2RUOXZUaDZ5ME9PdFBzbThsTm8xZmtReWZMVitWYk0zYlRn?=
 =?utf-8?B?UnpxOTZNOUd6QklXeHpPa1pJbzJCcDdtbnFFYmJZUFF6aGdjdncyRG5pQkNz?=
 =?utf-8?B?bmtDRXN1Yi9RSmtZTXh4QnNSYisxYTZQbEZxV0MzMTVnY1pScVRNWTBTQjk5?=
 =?utf-8?B?a2dlY0F5RDBuWWxhMUF2TWlCbW1veWpqcENjU1NPa3BaenNTNTh3RlQ5eVU4?=
 =?utf-8?B?L2NIQThrVHpvMlUwSEsvMXZIcHRVZnRjdHVPTXptVVA3R2hZSHhITlZUcGpq?=
 =?utf-8?B?N1ExMU85NmZETzZISTFCdDhTZ1diTHV5aGhWeVE4Q2V2YWtLWUxqTzNJNVRY?=
 =?utf-8?B?OVFBa0tZYXZQZlFYRnU2TzFhVGltMDNJWUV2TzBZY2h2S2pxZUVMQWpQRGFV?=
 =?utf-8?B?N2pKa0RYaXNCSjFsc2xwdk9jRkZkOVhYSk9QNHM1Q1RFZEp1UXQ3VE10UmRN?=
 =?utf-8?B?N3YwQS9VYjVsK3VTQzJ6L3Q2TmRYUit2bnNuZDI1eURaSWpNUHEwRzVMNzlM?=
 =?utf-8?B?emxZempUYldGUmpZZGN0andNeGE2aXJQZ244OGZSSDQ0dkRCdG0xU1U2TE9G?=
 =?utf-8?B?MzdDNThVcnQvZnhlbHhTUUJDazRqRDdsb0lBb2lWYmYzSDlyOUx5V0FJb3BW?=
 =?utf-8?B?MVpmdHg5WStBTkN0R2EzVVJKU09ha0FMcWRBUTg4dncyS1prY2FFVjBoR09k?=
 =?utf-8?B?VFJHSUkzTUxaNUVFbW1UNTlQZzl5VVNNSHJDN0dFVFlsMENFYmwrd3pqWEVP?=
 =?utf-8?B?cWtUeENNRmVvc0l6NEpBNHFHWVVCOUFLamNSc1g5Wlo1ZU80VTcwUU9zNGhr?=
 =?utf-8?B?ZGhxanFYVk15RElJTlIzaXhRSy82bVc0Qmg2K3BMTHBOWThVRW9OTXZ5V1N1?=
 =?utf-8?B?Mi9scTFwb21xVG9pNDdOM2JsR29yZnJwTEhSTDJWRVdFMVRNQXlYYzNuNDg4?=
 =?utf-8?B?UWk0NCsvRmNIZUFTSFRrSGUxM3FKQkRxYkJuQ1hEU3JYZ3FZRXcxQmVsUHla?=
 =?utf-8?B?b3czMElOREhtWEUvRjJxWVlmVFMyTENPanJ3WnNMMlN1dXB2NWpiOERIRmJ0?=
 =?utf-8?B?eUxIU3dRcStHMzU2TTVVNDE1WjIzT0ZMRXBySWVCSGJHSTc0Ums3TTJGSzZQ?=
 =?utf-8?B?dmhjTjlyZi9oM1FUbUVCaElaL29uSFZWSFNVaWdXN0FQWTdLUFhkSCs5MzV6?=
 =?utf-8?B?anIrRXgyUWN5aXZtNmEzKzN5NEREcVA4VGl6NVl0bTVhblNRSGlmVlRYU0U2?=
 =?utf-8?B?T2hnRjdUMjRSdkpYaXlsbVVXTituLytjakV1c0MyOGx4SW1zMUVISmlmYm9t?=
 =?utf-8?Q?KLOIj5q26XZ/XrOTXlutUybQq4JDD4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TitXNDFXS0VpQVo1eGgyekhYQmNQbDJpRVdmUm5pV3ZIbjcyVyswVXk0VktF?=
 =?utf-8?B?UnlhZ2tyUmlwMEowUFhyUWpQa0RneGlISHVUSkF3MHlyVkN5U3RBZGRNODdU?=
 =?utf-8?B?N3ZJS1R1SDhINTl1MmVkSzJFbmlOQ2JXRTlEeUtWS0ptM1NweVBBbzNaWXJ3?=
 =?utf-8?B?ZkZLQWhXRXpoOFBiWmVCUEtwNTI2RGFSMkNUQTAvVjJoOUxYK0F3Q3FscVNJ?=
 =?utf-8?B?eHd2NXBpclRzdkNPdUcrOXF5TW1SZ2R6TXlVM2U4aFduakdiR0pmMG5jem5K?=
 =?utf-8?B?MVlSNnRsUE13TWVuK1djeXV1SXpuZkl4ZUZCRmJOODBRY0dYNE5LaTVZZ1Yr?=
 =?utf-8?B?VjhLUlI0WHh0d2t6R1RFQjZvSUFmUW9RZVF0Sk82cDd0TW13SGQ2SXVwMGc2?=
 =?utf-8?B?MFkwWlVzY0JJeURyVzFSK3FtREEyemF4SDF2Nit3dHI2QUpFQlFvaDFkQjdu?=
 =?utf-8?B?VXMralBUU0VzL3E4UmcxYllYSXdIeStvS1hVd3RGUVVqcUREYnc4eUYxTzZF?=
 =?utf-8?B?UmFhS0J0YWsvYW80U2hOeWoxVGFXZVd3TXlKSGR3Qi85SWNJUVdWYlQ1Sms5?=
 =?utf-8?B?Z25nSE1UbENieCtrQTB1OGtYaUdOV0FkWHdrRkxKMTZIVG81bVF1WkkvMklo?=
 =?utf-8?B?bEI2Mms1LzdUdU4xVFlRS2hIa2xNTlZ4ZEdvck1tZW1SOHljQ2poTVREN1or?=
 =?utf-8?B?dVZDNGthNm45Zi83WFRsdlBVYWR1TXpWN1VWdGVEZDRVa2pKUy9vTnN5VG5w?=
 =?utf-8?B?UDkwUzBMNUp2UXVFU3J1OUFqSHVBVWdNYzN5K0Y0WGxOL2J1M0ZtaHZZa0JX?=
 =?utf-8?B?MTg1d2R0QldpemJxRHhYeFc1K1RtMjhZR2p6b1N0dXVLWmRjaUEzZE85TFUw?=
 =?utf-8?B?UUtlK2ozbzlvYlJmVjhOeXpvUEVaZ2tzeDdsSklSZWVqTktCakgxbGg0WndC?=
 =?utf-8?B?SU5mRWVTR2hxK09EdWpiMjdlcnZLK01HNHNPeW9wbVpaR29TRVZvZ1llOHV4?=
 =?utf-8?B?YXRjNngxaDFFSVUzdW4wYWZVcVN4UnczNTJtNHA2VFU2ZHV0Q001NTBSMlQ1?=
 =?utf-8?B?YXBFcWtZT2dKT3RKN1VRSkU4WWs5T3dSNGZ5ZVM0QTVBMXJFNWVyUFY4Rzds?=
 =?utf-8?B?Y2RGbTdoQXFuVElFbURwek4yTjJTRVo1ajJkdHNvMVdudml2R1FMMjBHazIx?=
 =?utf-8?B?SERlNUM0S2FHMUwyODMvc0d3ekZ4UUF2cHN1blFUVW85Mi9jRFZhSEFHSWk4?=
 =?utf-8?B?aWhCV20rcHFpN1FhbUdpaCt0V0paT1VtWGpLZmdiMHJJZ2NUZDFqQ3l6MWxW?=
 =?utf-8?B?ZDJNdVVOWTdlYlc1cXRxM2ZwZCt2NkFjSmJob0JrdDBkTEhONzFCcWFYWXNl?=
 =?utf-8?B?R2d2YlIyVkluSWdHVE5zalI4M2NJYUM1NUw5WGI2Wk5UVVczUy9jQTFDdXlP?=
 =?utf-8?B?OHlzV1RTMkY5aVh0T0EvYVl2aTMwdXZXdFhVOU1LMTFBU09xNXQvWTdGblNr?=
 =?utf-8?B?YWcrMTJMSW4xcjlhZjRrakg0d0cybDZHbjFUN1B4WEUxbm5aaG9FT2cwcGEw?=
 =?utf-8?B?SHVsaTRISjlPYTZiZ2pFaUFNVXptS0tsRDJaWEswUjRJUlBLZ2tSZ0lZNSsy?=
 =?utf-8?B?RFpBaHJnT0plSnRiRWpEVjl2VnY3VXpONU5zRTBMa2dwSS9yd2I1TGMya1li?=
 =?utf-8?B?UnMwVUhiZ21CZ0UrS2hHTWhkaEVhWG1hZGRXR3lDakJhMmhuOW9GUUlwWnB5?=
 =?utf-8?B?RDQzRVh3MjVPTWZrbjZndnJHQzdVOFI2NDFWSUdFWmEweW1LTzBIL2tyTlNp?=
 =?utf-8?B?K2todVhwZ2tmYkRRUFpMMy9vczNtZ0VrZjk0SE5aMXQ5bytRT0ZvSXhtOTZI?=
 =?utf-8?B?SlFCTmFaVWJxT3dhc0FQMXpzSVluUG01bFRCVUpBSWdUWUYyU1loaDc4aURU?=
 =?utf-8?B?RzR6QUxocWt2Mnh6SFU3ZCtuaFRSd1ZtajFtT3ZrK2ZVRDVhazI2NHp1UkNN?=
 =?utf-8?B?ZGJETjVqK3JRRHFuVzdGRng0K1VKclVVKzRxQUE4TDVTUGNBaWxPc2FlNFA5?=
 =?utf-8?B?cUYyYWRZNVNnYzV5UUE1dWVpaW5QcnFLdVM3S0hyS2c5YWFKTFR4azBpdXVr?=
 =?utf-8?Q?62zkiHiOyn79PwDDxPppOtPS0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4092da0c-5116-4565-57a2-08dde52e1a30
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 05:53:52.9045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ul28xzXBCh4VawOeLlrP7AcaTAV3YWAm0VqA4FoeyFLmauwksK6LJFCWgEe9jM3l6r4NMwIz7I9p6pknsKeWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9524

Hi Stephen, Sudeep, Cristian

On Tue, Aug 12, 2025 at 08:17:04PM +0800, Peng Fan wrote:
>Since the assigned-clock-sscs property [1] has been accepted into the device
>tree schema, we can now support it in the Linux clock driver. Therefore,
>I’ve picked up the previously submitted work [2] titled “clk: Support
>spread spectrum and use it in clk-pll144x and clk-scmi.”
>As more than six months have passed since [2] was posted, I’m treating this
>patchset as a new submission rather than a v3.
>
>- Introduce clk_set_spread_spectrum to set the parameters for enabling
>  spread spectrum of a clock.
>- Parse 'assigned-clock-sscs' and configure it by default before using the
>  clock. This property is parsed before parsing clock rate.
>- Enable this feature for clk-scmi on i.MX95.
>
>Because SCMI spec will not include spread spectrum as a standard
>extension, we still need to use NXP i.MX OEM extension.

I only got a comment from Dan until now, before I post V2, I would like
to see if CLK and SCMI maintainer's have any comments. Or I need to wait
a bit more time, please just drop me a message.

Thanks,
Peng

>
>[1] https://github.com/devicetree-org/dt-schema/pull/154
>[2] https://lore.kernel.org/all/20250205-clk-ssc-v2-0-fa73083caa92@nxp.com/
>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---
>Peng Fan (3):
>      clk: Introduce clk_hw_set_spread_spectrum
>      clk: conf: Support assigned-clock-sscs
>      clk: scmi: Support Spread Spectrum for NXP i.MX95
>
> drivers/clk/clk-conf.c        | 70 +++++++++++++++++++++++++++++++++++++++++++
> drivers/clk/clk-scmi.c        | 64 ++++++++++++++++++++++++++++++++++++---
> drivers/clk/clk.c             | 32 ++++++++++++++++++++
> include/linux/clk-provider.h  | 29 ++++++++++++++++++
> include/linux/scmi_protocol.h |  5 ++++
> 5 files changed, 196 insertions(+), 4 deletions(-)
>---
>base-commit: b1549501188cc9eba732c25b033df7a53ccc341f
>change-id: 20250812-clk-ssc-version1-acf6f6efbd96
>
>Best regards,
>-- 
>Peng Fan <peng.fan@nxp.com>
>

