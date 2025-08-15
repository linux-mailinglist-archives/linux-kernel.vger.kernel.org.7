Return-Path: <linux-kernel+bounces-770394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1811BB27A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C09A16C2F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E224296159;
	Fri, 15 Aug 2025 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WDXarwik"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AC221B9D9;
	Fri, 15 Aug 2025 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243594; cv=fail; b=ONK+Adv+tJB+dTKMjGISGZ/W1ahWkAukVzQmwM/FeUyNFfbLAhLwWbh22et16djvXtpntY8U8IDrY/JX3Zqw/BircNM64XLd/n1d/SC9dJ3m6N8K1d3B6y+X8sJ8gvQr7KECh429HzEs91UkoZviZp1OAMHE4Je5Wv2++0DAGps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243594; c=relaxed/simple;
	bh=EochVH+5iRwRzcBRwqt7yTIBHc/9NNdcOui5mCyezJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YJbdeAInf2Pgn2duMlHMU7I8f9q4pdtyGe4CiaimlDZ9LRYCjab7bocMxuFplD+W/HJLQwV/+Q3Kgd/iCVwdVMKQ67tlqk9CiEnQIwFztIi4r8CKs7K4ImPspE6Fd0uDVqsQ663bQnWJauZSlIvsomf0cZiNQ2P1p0d3Msj4ryE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WDXarwik; arc=fail smtp.client-ip=52.101.84.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m57ZUu4GzvvirxE41yjPtqcU3Ny31Ib/h7G9Hvp6iHbL8Sck0GPwjCQP1bF7yK27lAOXBkxY65Dj3hk39Gqcv436oRMFMQH2sLWjcbrGD22JS7GR9uBNalQ53O/pHet4D/y4J5MVJ2IHetrEHU5C6tGL0GY7zNM7FtXc32Xf+nQ7EG71br/4XBvGTQ+hB/IGJeLFCUHN2WpaazOQEVpon3sMsW7R5imTNXyzgAU/xmRHPPjwh2isX57syr9RhLetCt84GWvq6W2e8RKejRXClO6ZZKVFvmxmp2dPee3nycNPKNwu2AUNH2q4sy58M9SGTWMOFI448i4yFXx4cx1JTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpqWpNk04hSSsjHa7vLu73ZDV4Quj/2wJN1mPWsmcFI=;
 b=V5bz81z5H+g41OFvu2hI9XxE4H4hd9k0N3K+KsmyWD5cEiAny8LaUSHgIPSfKk+W7Z5jYYLCUqiQGurDkJEXTBMDo/pTIpE3mdy4aLuI1592GTLmBXg0I6xKh3VpZSWQDfsLEtLKgwzCkcLe0Vj5H4qbAtBI0VuS4QI3BoDvQ7pf2+vnsG3cqnVk/mvCkO06LZycxxN9zCurTNIcQsV3XBR29zcL+c2DgZgopOw40TOVTS9ltAYo0OOwzAZ/6gFYI5BrTYVkj7MM8qVwLscQDN4wxznKvCqRl4RITaWfpR8sDahzD8gUow8sLqCupgDjv2XnQv99i/CiKkVC2/q7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpqWpNk04hSSsjHa7vLu73ZDV4Quj/2wJN1mPWsmcFI=;
 b=WDXarwikSxP+CXjRETvwT0sPAZnt0YGcx1QhZytk5o0E5lGrGyX+JRZ62ZtTzdklpU4hQ+ICw6S7JII6gLYWni2DVY8xl7Ky9+jQUQHgemEa+rRcwOBDDByMzXXS7vKW3yOPKkSgSAEZ+0MticNq0YkYwCS3iQ74w8WtXWC986xe3CqzdmhlB7c8Tzdb/28ss3kvfzuRW+pTe8UBmGW3Ak4KXitk/mxG6L4RASYitNnBjYUIDXjnmjdQR5XXmSTX+HjKAH06MyWZSBXwhrfsrbbHz9X/zRe/2gHu0HgnLpYOzbOarGVRt+YmTFI8Qv4iqOkT/7KERwBpEGM26hqYMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 07:39:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 07:39:47 +0000
Date: Fri, 15 Aug 2025 16:50:42 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] clk: conf: Support assigned-clock-sscs
Message-ID: <20250815071249.GA20726@nxa18884-linux.ap.freescale.net>
References: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
 <20250812-clk-ssc-version1-v1-2-cef60f20d770@nxp.com>
 <aJwnH2mlRdqp1K1u@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJwnH2mlRdqp1K1u@stanley.mountain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf51b35-48d1-449d-e197-08dddbcee8f0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|19092799006|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cpUBlB3ndIa1Noz278SuEqv9Fk+0fXOjeHkQbuuCOHW7atQtjhOGUud7+CvS?=
 =?us-ascii?Q?M5U+4dEduRiBFMCQslVc3axPxhC8GeyxEvHndKI/7Tk44xkfetPW19JXiu1N?=
 =?us-ascii?Q?5uKEgzQXLS3HfQu/Xf46MCzZpe87hGOgxZFmA/OIe7PJiQhIRcf5WAEq+0CX?=
 =?us-ascii?Q?fsJQcv3+c0CCbOSVpAhsl3Er+U/4Ked7o7D+NRTde5QeqKXIaHaqbYn4M0KK?=
 =?us-ascii?Q?6pl2H0BQwblB9N7ZpbWfp4KbUTgAo84Yt7Jqi4eesysiEb1J9ZV33BfeOsvS?=
 =?us-ascii?Q?6VcDiv2ihZ6g33/2OfHV4TBdFBkTLt7FhWtS+KMQHcyS5svJqQPYBoEYWgjc?=
 =?us-ascii?Q?z45JUgzDKGXQu4cLOWvquvtT3d4rBNNq0WsytN+JELI2rLCGvTRKut/XvkaJ?=
 =?us-ascii?Q?vgnuGLVjavYkTT7CEm9RfKF+bpPduk3SIvj+J45PieSzFb5rA7CG/iMpah8C?=
 =?us-ascii?Q?ujV7y0zd/CML+1nQ+Nprgr7YK2anO/eDYq48IdKbz7kIBOlaoPgWCiCEKcNe?=
 =?us-ascii?Q?Bm6dEbvtDcQFJreE0sAHaeU6ujSbKx4fUTHWiqbI9ORvp01YB/+bRR0tHeu6?=
 =?us-ascii?Q?qWMskh9ZtUhGlnBhHbPcYBpZRQb2UWxchnzVnZe/8CwolMzL34i9riM4RN+3?=
 =?us-ascii?Q?Rolhu1V1zjQG75j5jphRbG7jQ8d55FAeMXrhela3hEoz6v926vy03eQ7vC4K?=
 =?us-ascii?Q?9Ke4OF2NdALcvstcINhHHueBkj15DWY0bBGbgmvXj7HVIdwijipQEuIHL/Gu?=
 =?us-ascii?Q?hZwacHLJqhi5NpmW/9mOFfoRppk9ZBfnsyajjoTjD6tK1+WTPsh+0mKl4WZH?=
 =?us-ascii?Q?OSJAKMfbvImWSrOiT7POzMBZySCIlbaGm/qa+uqTpgGE/27tq78DARBWQ1xk?=
 =?us-ascii?Q?AXyU4+cNxxzR7os0JoytGPPAZfYyiFvybyzUqgDPGakPs5myeJ2lGfiizwtx?=
 =?us-ascii?Q?5ZNHa5RUDxJjWrE1gRyuspXFmAV454dQKEtIS97PbocT+/hcyWcvakzLIUc6?=
 =?us-ascii?Q?VKPR9Rxd5my9YkgBg4ksxAkd4qd44MG4rv62vY/XrArwFI8KW6weQ22avyki?=
 =?us-ascii?Q?92brUcaO4pUWu6EtqrPLLzvvLl6DtENDTXkCOXLIqcByZ/y1zh1O1fYeeRB0?=
 =?us-ascii?Q?cAsW5MKkagAS64HIi1xR+80rhr2P8S+NjFEYypKUrirgEZWMwPzCoQ4c0Up3?=
 =?us-ascii?Q?D/ef1fewYBVbWzoqPUoxl4xay/NiBziKeEvMvY6VMDobF8TqyJ0Dy/cArYwF?=
 =?us-ascii?Q?qvmQJaTqEUGF9KWAG9oR1T5AC6+2RFTOOfobcchBNKWBOuQqq3PovUOjLkVj?=
 =?us-ascii?Q?/oM9TPqKDft2tz3/HuwT4DYlwuSktVTOx0kjzvbABiZLymM30TAYu/J7QFOS?=
 =?us-ascii?Q?liiz4ppLsXGirJhawcWarLfcKcD8qDE5h4InQwWKFi9hrm8ZEyCAnoSsdecV?=
 =?us-ascii?Q?2WIYD8bbZpFzGMVLYxI4pIUiwhXln/phVIvhrWH2qeKKdL/n9tbyEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(19092799006)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qZbDmFzuEI+5MjDASZWJuHoMmEwXIxgGPZ2uqR9SSPGgvI3g7nhojVUr6ZRY?=
 =?us-ascii?Q?XkNBvwM2oeSE/QVNPfSh6wZ8+IH6uSFRsOb0jcasnL5tn3AWToBfgnHFnf3K?=
 =?us-ascii?Q?6SplKGjuEFyo2WEouiyJouR8YeuveS/vvy+BcUT/L5qkP95ddWeyFcGSkRR5?=
 =?us-ascii?Q?wrI9X2SiLDHzw3JgKusZR/odGWzmvzeocn4rjkgkE/KZkSaFiqYlYVQUVyho?=
 =?us-ascii?Q?9ogzogZdpf18YZn5WChurO0os9PdSr53MbZWyT3VQGlxcByGsI5neR+TfLNR?=
 =?us-ascii?Q?Zm0NLgAR4uNnEGS5sD5ZlSNDLXLJZ4bkcnozqCwMD7PUgiJmRFWyxKbG5ul8?=
 =?us-ascii?Q?da0LmDsmFxgqniTDm8jYCOMhQPDxdmDj9zlA+dg58IhESxJTBoh/BsI30O7v?=
 =?us-ascii?Q?NRND7lppPVE84zUH2VT2aoL2eYCiNC7uvUXRS3pspeJV9b5UKEcxVOpsV4oe?=
 =?us-ascii?Q?WbuW1vJdsC6nkhDuyavu75nys3tLkA0NiQSCvoVyK7rptpIlSVL9P4VRXaTt?=
 =?us-ascii?Q?yWeLgIXYhHos7k0aSPf4VKPS0rMSrmMUhBaS6Aly5yC3x8PGngn6lbSMPIEL?=
 =?us-ascii?Q?EQWHr9zkq5Qp+m7EiolYDyFG9u2cO0EgatH6wRljKS9CNn3ZgEwZNFrRMsNq?=
 =?us-ascii?Q?HMZEI70QlphdQL9h7r4B/0m6/CoDvuaRmoIxisIVirWcBOMqrBqbItuE+563?=
 =?us-ascii?Q?N4KTQxKmabOgUre0UGo+feJ8CEwvHadJMmS+2G5cpa4O0kSMNUNgsxGFBYWo?=
 =?us-ascii?Q?jzxfxPk+iav0f47o4OAVoW1nazxzQUY7axaMfqEgEBnQFj+YVzVPFMdrdpvK?=
 =?us-ascii?Q?jTSEAlN/sNS0uxZq5F7tHAxzOUh8/1+2KbkUiefGPYeBlVX+Tf0ksIYa0TPP?=
 =?us-ascii?Q?V55gJfdRnNoA9X41NEsw2JvuYd2RojZ+u/rFGYxnQY1iYR/67GNwduf7yik7?=
 =?us-ascii?Q?k9m7xK0hzqaYxHQRboy0dCJi1ZhC0NMIP0NppUwOqb6EIwCwF/iCeuVR2GhT?=
 =?us-ascii?Q?dFDAj8QtVqhqiz/9Hv2Sld4Ff2FPSnQZVTDRfjagKHWPXFODX7aJddOUhob7?=
 =?us-ascii?Q?Y9qlIJUFE0GsEmXHVdhg7D5Hv2nGBpxRdoxXZBQQFixO9GTcowU0VQt/bS04?=
 =?us-ascii?Q?5CEG+2E+zDVQGLznPTM8OWA88xbGeW+ONQkT9AVFYkGef0kYiBu1ojHunALR?=
 =?us-ascii?Q?1xhmBd7tOh71irRtlTSqbncK0+mJkVTB8ToDHN+OoBaeDS3SLbcezKHWxhs2?=
 =?us-ascii?Q?uBrI5aRDyvLb8n8iMPlTP3tBSUy1MFlsXaoDhH195177ujML/a9Sb6BWkTj7?=
 =?us-ascii?Q?+LCXcy0jnCP4EYudYfAhZ1xPM53hZgmaXj47HplEhBtszPRXddJfK+UNqlUU?=
 =?us-ascii?Q?/lIZF93aqdFJ80nG6TM330oPd4jMwpT4HrDIgx/BJwWEXn6aE8QTZoA0nP9G?=
 =?us-ascii?Q?JexSh1rH7ilKQbl1SCfo0XppS1eMhKod4qFI0cJMuBfwKJCyEKsRsvV24tq7?=
 =?us-ascii?Q?fIPO+cjyYF7CmtDTT6NepO3s6hvnFzH+8My1lgFVq8loWRc+2PXUaTjNPoIH?=
 =?us-ascii?Q?LkTrtJ6DmGyAG7/p1T0LFynHH4Yk2i8s3jugCy0Q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf51b35-48d1-449d-e197-08dddbcee8f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 07:39:47.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nk1a8AqF3SL0cP2UrQ+Q9NlkuwoSEziYPiaFtlfQmb5vzx7nB0F8tMfq4SXt4QnwvvMWnEyKorIuyfDAjSronw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8712

Hi Dan,

On Wed, Aug 13, 2025 at 08:48:15AM +0300, Dan Carpenter wrote:
>On Tue, Aug 12, 2025 at 08:17:06PM +0800, Peng Fan wrote:
>> Parse the Spread Spectrum Configuration(SSC) from device tree and configure
>> them before using the clock.
>> 
>> Each SSC is three u32 elements which means '<modfreq spreaddepth
>> modmethod>', so assigned-clock-sscs is an array of multiple three u32
>> elements.
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  drivers/clk/clk-conf.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 70 insertions(+)
>> 
>> diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
>> index 303a0bb26e54a95655ce094a35b989c97ebc6fd8..81a2c1f8ca4c44df2c54c1e51f800f533c9453b3 100644
>> --- a/drivers/clk/clk-conf.c
>> +++ b/drivers/clk/clk-conf.c
>> @@ -155,6 +155,72 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
>>  	return 0;
>>  }
>>  
>> +static int __set_clk_spread_spectrum(struct device_node *node, bool clk_supplier)
>> +{
>> +	u32 *sscs __free(kfree) = NULL;
>> +	u32 elem_size = sizeof(u32) * 3;
>> +	struct of_phandle_args clkspec;
>> +	int rc, count, index;
>> +	struct clk *clk;
>> +
>> +	/* modfreq, spreadPercent, modmethod */
>> +	count = of_property_count_elems_of_size(node, "assigned-clock-sscs", elem_size);
>> +	if (count > 0) {
>> +		sscs = kcalloc(count, elem_size, GFP_KERNEL);
>> +		if (!sscs)
>> +			return -ENOMEM;
>> +		rc = of_property_read_u32_array(node,
>> +						"assigned-clock-sscs",
>> +						sscs, count * 3);
>> +	} else {
>> +		return 0;
>> +	}
>> +
>> +	if (rc)
>> +		return rc;
>
>Nit pick: Please, flip these conditions around.

ok. Fix in next version.

>
>	count = of_property_count_elems_of_size(node, "assigned-clock-sscs", elem_size);
>	if (count <= 0)
>		return 0;
>
>	sscs = kcalloc(count, elem_size, GFP_KERNEL);
>	if (!sscs)
>		return -ENOMEM;
>
>	rc = of_property_read_u32_array(node, "assigned-clock-sscs", sscs,
>					count * 3);
>	if (rc)
>		return rc;
>
>> +
>> +	for (index = 0; index < count; index++) {
>> +		u32 modfreq_hz = sscs[index * 3], spread_bp = sscs[index * 3 + 1];
>> +		u32 method = sscs[index * 3 + 2];
>
>This math would be nicer if you created a struct:
>
>struct spread_config {
>	u32 modfreq_hz;
>	u32 spread_depth;
>	u32 method;
>};
>
>Then you could use that instead of sscs.
>
>	for (i = 0; i < count; i++) {
>		struct spread_config *conf = &configs[i];
>		struct clk_hw *hw;
>
>		if (!conf->modfreq_hz && !conf->spread_depth && !conf->method)
>			continue;

Thanks for the tips. Update in next version.

>
>> +		struct clk_hw *hw;
>> +
>> +		if (modfreq_hz || spread_bp || method) {
>> +			rc = of_parse_phandle_with_args(node, "assigned-clocks",
>> +					"#clock-cells",	index, &clkspec);
>> +			if (rc < 0) {
>> +				/* skip empty (null) phandles */
>> +				if (rc == -ENOENT)
>> +					continue;
>> +				else
>> +					return rc;
>> +			}
>> +
>> +			if (clkspec.np == node && !clk_supplier) {
>
>Could you add a comment for this condition?  It's strange to me that we
>don't iterate through the whole array.

I just follow the logic in __set_clk_parents and __set_clk_rates, nothing
special here.

It is just like to phase out cases as below:
  node-x {
	/* node-x is not a clk provider, but assigned-clocks uses node-x phandle */
	assigned-clocks = <&node-x   XYZ>;
  }

Thanks for reviewing the patch. I will wait to collect more comments before
posting next version.

Regards,
Peng

>
>regards,
>dan carpenter
>
>> +				of_node_put(clkspec.np);
>> +				return 0;
>> +			}
>> +
>> +			clk = of_clk_get_from_provider(&clkspec);
>> +			of_node_put(clkspec.np);
>> +			if (IS_ERR(clk)) {
>> +				if (PTR_ERR(clk) != -EPROBE_DEFER)
>> +					pr_warn("clk: couldn't get clock %d for %pOF\n",
>> +						index, node);
>> +				return PTR_ERR(clk);
>> +			}
>> +
>> +			hw = __clk_get_hw(clk);
>> +			rc = clk_hw_set_spread_spectrum(hw, modfreq_hz, spread_bp, method);
>> +			if (rc < 0)
>> +				pr_err("clk: couldn't set %s clk spread spectrum %u %u %u: %d\n",
>> +				       __clk_get_name(clk), modfreq_hz, spread_bp, method, rc);
>> +			clk_put(clk);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>

