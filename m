Return-Path: <linux-kernel+bounces-779336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42C4B2F2D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9650CA076B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D22EA48F;
	Thu, 21 Aug 2025 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wwpf8ynM"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013024.outbound.protection.outlook.com [52.101.83.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3E02EAB85
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765952; cv=fail; b=o2XYYMv9Q7SoX5wDBhl8DrV9JUFvMadZokVKnjzqs2DhvFWN+gm5wbjtwNjC8z2uciCUGLANnW0PDdX4cCm9qMt7PjlKX8r8+ZsZBptLZWSsNENo33MeZS8WNGHqWzEEn6b/oQE38nla7bAvsuFRPipkTfnAl4nNISpLYRwJfkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765952; c=relaxed/simple;
	bh=4U/Op+3l/7fjmWsm9XRMYAlENhDtv4c3FaMzesK0jNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jVL4AD7i0jns9x3k1yM1frW3T8CmP0QH8iq61IEw1ogR35zcm4e2xdnj/fmJCIEJr1aHsBizuqujco+XEAG7GnFbEtnXJjI9g6bX1t2yBX3+Xr+gG2Kxyck+aCtjcg/uQDcsBex50uTB0x1MOea5qPaNxT1GlPxPLXN+z/VaCWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wwpf8ynM; arc=fail smtp.client-ip=52.101.83.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5F2y4xjdqR85WaTuhrjjpQv8F9Oss+5NtTHBNRH9x6Gpx54ldL6iQBsF3zXO9jAfG5fUc2zLuCNALDjRv7A03uZFOwhyEvjs/p+rnXaXtaHxNfkp4zrtK7x8ukmzgKSFl7Iqcj5PUOT5aN+YqdFWRli1GkvG9nbsQ1PEx//PPMcM3iBl4Br1ZACHDk3j0eXiLZLQM8buwAHelWUJok3sb4eBvb96canrlBt41KGMHODaY6bQwySqZ8MNseRwqURa2R4sJnAvFZ+H0DItH5GTvjhv7Ji0gJrQ8JRtBiKJjOJEyZZKURpuCMGZSZfr0pm6DYfT7v/Hbn+vBfSQTBJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arHTNXJmroyAkXCwLKtCp6PFtAcYlcxdTpKX8vsqFew=;
 b=aXqcSxgUEL0m0ZhFiM8X+aM6bmpFHG5lahJkY5ojhxnceX40hgbT2nby91I2CZNouGUvG5tFayHBYtmYUUXG3zHPGjmWLd+cCg3x452OiO6k+3QM6K8djfERl7VBmIsc+8zGeA6y0gaBahH/qdfsI13XgdpyO1sTcR2WbyL98S2olkeLIhtJJaB052WPgxwEJaSsUNG1osDdZG3hhClNWF7QPTXCHRRIgDAnAxAwQMcY4q3F5NvM5cvM/vmQDqR5pAErKvlYfKNazZWNT4eHuHShITZ/8j2l7MLRgMK6L4AS2sMG/LHZRBazfpAS2t/4l0eWbc0WwRUKDcptyBIpeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arHTNXJmroyAkXCwLKtCp6PFtAcYlcxdTpKX8vsqFew=;
 b=wwpf8ynMRaseELSfGINnbc0fvp9I2qa2r7H1QUb+JsEMc1z4hYaPGJszjJp4DO8wntIbsYvctWMQaszac8mRfzl6J1XNHqMp1MiZmXfn5y3rAfCCsSlnjeCUe95HmCVMePKX/qRWCr/osmfYgcu/N2v0/EIxB0lrMYio14aR9PFoUcJAt/GcfSw/b/qSto4elilBAQ/WLN4kUTMOVHW88ZaESodTDvKPFpJCbWVB2QWlLKL4Z97XTmNCPw718EGBHt1pM/ckJoQ/zcp0i7cfpdNws37JejlZJcxSXUY3osyqkl04z6aZefAx0YItrbGfUCplcwW1NpnUDqz0WQPYPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8323.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 08:45:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 08:45:46 +0000
Date: Thu, 21 Aug 2025 17:56:57 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] firmware: imx: Add stub functions for SCMI MISC API
Message-ID: <20250821095657.GB19763@nxa18884-linux.ap.freescale.net>
References: <20250807-imx9-sm-v1-0-3489e41a6fda@nxp.com>
 <20250807-imx9-sm-v1-1-3489e41a6fda@nxp.com>
 <2ff85fec-b571-4423-9161-674f88a32e18@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ff85fec-b571-4423-9161-674f88a32e18@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 31dbc8be-167f-4dde-ed37-08dde08f1f4d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GljmYiOufcZuXpdZkda45SKjKfAdB6zXijSaKinZjGX8i/HqEW970+kXCQHo?=
 =?us-ascii?Q?1HF3lfQh2IKDMMYS/IDcXSGkeEBFExDWdDSIsdvqDJtert6pl/K95H9m7JgV?=
 =?us-ascii?Q?91dxJCURO7U1trAcFu7LW8eooPgrtiYXlZ700TLxFWS8ic19pKwATn8XXJXN?=
 =?us-ascii?Q?wwLiuqxz0cZZCW90xkGGOwQ2l1f7+iIc0zc4cMMo3cd8nz5i76u9RSOAUimp?=
 =?us-ascii?Q?tgCIjrVMRMQ1MYUqI9Vdyg2tZOomhQDiH7VFUF+2bIlknQS3w6HUMEpEgJTj?=
 =?us-ascii?Q?8MlbzxLr7n/ZjwqB3zs3v5jmhvOXutPcQyrYKSxC+codFnPt/v5xu0spHKN/?=
 =?us-ascii?Q?OfxAc+P0OwV5ATj2+2hpKJEIKcbbcM3LbHve0HK5lgEShCBaDwVy79XbJloQ?=
 =?us-ascii?Q?u4TcO9ZCU4itJszzU46jG41FW15weYNkzW1Ot7+bf9SuGK4MiYoYPqeZG1Fi?=
 =?us-ascii?Q?L0KxFfM/WLZeCnV5TF6LenYgsIB2J77XUFvCkZszf1T9uM7YkpQoiofMA7mN?=
 =?us-ascii?Q?eehgqw4xBqTELJOGOTTdzNs5o0g1IGfEN0HvYuH+WXZtcYyhuUgXIrb3DR+9?=
 =?us-ascii?Q?tdJ0Tig+4U+k6+j9vAA1CZsr8KrqcUJ7B9eIoMUCKqOzY1og2w0XD781ye0+?=
 =?us-ascii?Q?ppqFjP2gqsqhoVoQZxyJ4ixI0KI6xZKPGQgBqRQG6C9aEAfT43Z8NBnTux6T?=
 =?us-ascii?Q?pVf7hmFDJfPoK8X6KVBPYoHI+2JXwhjBpMFOl5b87kZOGH7qhURj/ackFEqT?=
 =?us-ascii?Q?Ko4BsZDyVCZNyWa6onqy/15TFRQtZp6nHswPcs07/43976HCWrIg/dHpQTls?=
 =?us-ascii?Q?sYPh08cuLOiI973ugHzWjmw7XYupq1OaWRdqfqk3MBV9hiwuUTuslplbNKA7?=
 =?us-ascii?Q?9m6Xy9PnGf/Ul3R2ZO8oiKSzcHWu6fvIQAbpr9MtUwg9LzIWeFDiNEg9poOe?=
 =?us-ascii?Q?K1aYV08ehBWxOT0mmNh70obzvXstGs9pTty4fq68t7LUD1GtH5HtweVdw7ql?=
 =?us-ascii?Q?0XZie5bvGWWRHQEpX4qSnnQsSFxQifBg8f0Cl9DoWYKpu77AyNJLcUVqcLK1?=
 =?us-ascii?Q?8lRTKZ/KGohJzuibqzPLjTuXOSiuIBMIk6VHITwWqK5J5I7BlfhgnsUzbU3l?=
 =?us-ascii?Q?RrwQOvTCjNNFh8qMLtGa3dIc82TsQyu+jEKsrYRBMD0Xhc4NLfjPBlb3zGxg?=
 =?us-ascii?Q?iWnDSOHRzDMQfAMQW5rQ1u3xS6G1ap3VK3P5IfHcyvLjYx7CsEhkfjbLAyAl?=
 =?us-ascii?Q?C5FaAnPhYelviZqDy1kv2WDIMoqprE03OC1lsc6lC3H5uTOtV7CGKQLeoamb?=
 =?us-ascii?Q?M+OR0c2rCglbZwVtcKjZG8f3RuElRJ3luzzBkHNNtGUVtd1Gm1+s1mOa76oK?=
 =?us-ascii?Q?e6L+W4Fm4jl8ErCw4b7+jCukdw9faYnGY0gbkmvKK46/o8zmhu065PCRTuQj?=
 =?us-ascii?Q?aJt/d33mHPwOsy3ldTWUg1yskYM7hKnQUbHnunvXNLcqd4iuqfVsRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dDb97jnpjmss1Y4NiWvywwFrJXEamYv0I1HRbugAUvJU4/b5MsD2E9S+bYic?=
 =?us-ascii?Q?CBdO654zlkhWVY32IcRXV0HG/qJr1KeEaLfJAJML6AT7NQCC0r5GSxVpfmmN?=
 =?us-ascii?Q?/DvtDEf8nnjJuKq5EjuQLbKyV+Tm9+TMlEJG7c88Z6TQnX9YWrgUHfHOCo0j?=
 =?us-ascii?Q?HzSuxKgR7Lka+WOo+3n4PWmbNWYrR91xoU84/JhieMRXjUQUe+uDztQTl/M8?=
 =?us-ascii?Q?avAuh95Lbak0mdPLhUwF92i8hFKueMl9NhlHgJcwRR2iAz99epcAAlNaP8SU?=
 =?us-ascii?Q?PY8DiOI+qjbXejZACDBefpR2/RijEr5oD98lEBTC4GF5ZpRjW+kWT2GLgIAh?=
 =?us-ascii?Q?86pdmK0Bvdp16wMM4sYfVOOvYchuVqFc9o+9J2PLlc8MDp5ABp8mbXOTwqwH?=
 =?us-ascii?Q?5/TgX2KwZ0hzIL67pBgxVPENhQJPTy9+/5QfK/jcwth+jdn+L/XgwbN4j2ld?=
 =?us-ascii?Q?nDuOPdPMTRyL+5bxiM6sg5aJG6sJ6DRromOZsm678psSg23irWqCiaZdrhYC?=
 =?us-ascii?Q?Ncp6Qv0X4x6hoqCnnqyHUaU2MGhHh5Fhuhx+wJpcdps0xQ5vQvvJezBYnKrY?=
 =?us-ascii?Q?xqteuP57kLLG+Ov8PZSZlSGCqmN8zO+XL/FISSGUjg+o13qYPnFAdDKRZokn?=
 =?us-ascii?Q?RxkeJJf9Ks6FkOIsBp5TBxJefk6BNhJO/Pfz3Cmmx89FgZ/rpgXToDyG01gy?=
 =?us-ascii?Q?nT1YZ1sPvwtxjWOtTMqdbOxz+nHwAuOWSCKSg/34DG2OjmuzPhm1QNLrRiMb?=
 =?us-ascii?Q?BZ+omZQO+ii/i/+bglp7njwdlEvBVYYwtlLqa1V+iRL838R+PG1cw7I1yo5p?=
 =?us-ascii?Q?7rBAC69CbQYaA0tLLZXe4W8HHa28hRiXnCrVXWAPXxjJhrbowsmJXomsBlUD?=
 =?us-ascii?Q?5379ZqK54oe4ukeDf1U49jK/qwbnpKEn3xXYWG41Eq1u9iDpgmKCWUiSanF2?=
 =?us-ascii?Q?OXOWbLngaXHrTMq7fyrmfViQEwdCEjHlii7JYfTEC8CejrX5a/ntHosIf/ao?=
 =?us-ascii?Q?1vSTXWoAOJ4F8lt/nOmKTEzW7Qvv9wrbkxs1iMIe+RRDm4OG7xSKiTlWvjNu?=
 =?us-ascii?Q?wJoi5u+LrauyNLXhf8ndzCcmuA4MbG6OgAMdpq24Ipur0qctTOUF3sbF1I6F?=
 =?us-ascii?Q?yxso44G/dGas+5QAWwBqWyTAEMZaAYVebVF2Uwl1dNH+v6g5Sb7qgfFa6C52?=
 =?us-ascii?Q?qpM6O+a583XaMrmjr2hSfq27AqvnfvTEpTGuQRg2I0XX1KO6xiVlnc7hYqfi?=
 =?us-ascii?Q?Ak/5hdb3bTnfhfib+OTYt384a1yrirKb1v8OJw3CbxVwwayL2CBigKvylrmc?=
 =?us-ascii?Q?3BHSA9CpXFXPdcUC9ptbTFgco1/lSh6pxxIB5vA7BMrJJ6tiBufGW1G+bvQA?=
 =?us-ascii?Q?fhCi+goNYXCYeChSmgMnjT/GHpO04/NxkLDe48+pf7k81VI9a+Ja/IeS1LS2?=
 =?us-ascii?Q?yTAxRxS66+Pj9cqtlWtZ5rH/ylRjWiqda0ILTdzxYstCbOWuvhdrHTn6F41K?=
 =?us-ascii?Q?/EeIsX4bARpetcnkQFBAyfTEqwqJb1q71TkE5gu2dAZ6C2aTUBRvsa064eu0?=
 =?us-ascii?Q?nF/x1fz8M/lgLP+dFSmXE7NhAXOxllXQE8ATK4G+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31dbc8be-167f-4dde-ed37-08dde08f1f4d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:45:46.9147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9TBb+8yW6HOuhImxOJOteU0UME0boqUSJ1xQzoQg3C0mmPw/8NTXSwbNPttK76p5m0MXdHKbORIRRBhZAiXqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8323

Hi Arnd,

On Wed, Aug 20, 2025 at 03:55:20PM +0200, Arnd Bergmann wrote:
>On Thu, Aug 7, 2025, at 03:47, Peng Fan wrote:
>> To ensure successful builds when CONFIG_IMX_SCMI_MISC_DRV is not enabled,
>> this patch adds static inline stub implementations for the following
>> functions:
>>
>>   - scmi_imx_misc_ctrl_get()
>>   - scmi_imx_misc_ctrl_set()
>>
>> These stubs return -EOPNOTSUPP to indicate that the functionality is not
>> supported in the current configuration. This avoids potential build or
>> link errors in code that conditionally calls these functions based on
>> feature availability.
>>
>> Fixes: 540c830212ed ("firmware: imx: remove duplicate scmi_imx_misc_ctrl_get()")
>> Fixes: 0b4f8a68b292 ("firmware: imx: Add i.MX95 MISC driver")
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>
>I don't think this does what you describe, at least not reliably:
> 
>> +#if IS_ENABLED(CONFIG_IMX_SCMI_MISC_DRV)
>>  int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
>>  int scmi_imx_misc_ctrl_set(u32 id, u32 val);
>> +#else
>> +static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>
>When a caller of this function is in a built-in driver but the
>IMX_SCMI_MISC_DRV code is in a loadable module, you still
>get a link failure, see 514b2262ade4 ("firmware: arm_scmi:
>Fix i.MX build dependency") for an example.
>
>As you still need the correct Kconfig dependencies, I
>think your patch here is not helpful.

The consumer driver still needs Kconfig dependcies, such as
  depends on IMX_SCMI_MISC_DRV || !IMX_SCMI_MISC_DRV

So when IMX_SCMI_MISC_DRV is module built, the consumer driver will
also be module built.

But if IMX_SCMI_MISC_DRV is n, the consumer driver is y, there will be
link error.

The consumer driver is to support platform A and platform B.

Platform A does not require the real API in IMX_SCMI_MISC_DRV.
Platform B requires the real API in IMX_SCMI_MISC_DRV.

So when producing an image for platform A, IMX_SCMI_MISC_DRV could set
to n to make Image smaller. Introducing the stub API is mainly for this
case.

Hope this is clear

Thanks,
Peng

>
>     Arnd
>

