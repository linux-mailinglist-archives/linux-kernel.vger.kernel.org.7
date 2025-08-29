Return-Path: <linux-kernel+bounces-791309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D7B3B52C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2528F562E81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641F429B8E2;
	Fri, 29 Aug 2025 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NQJJNmng"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7138328505C;
	Fri, 29 Aug 2025 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454222; cv=fail; b=AQvS9VMqeF7Q6hmMf05Tp5z8szI5cUcT6MsSxil1GoJHEPU2m2rB1uKz4lxACnyHjC/eVHpcvpHaYFKjzyQ6a5+eB/8ONnS7ZuzS3eDlnxt3+hfb39eMcSO7xLnG0ucXHDdkVwpBm4SBEGkRaS/egU7eJMPeTeAd5nPIsl4UOIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454222; c=relaxed/simple;
	bh=oaIp2bWhWB4+nTWQGCgpzAui2VVsj368JVYnBBKhngU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vh58zKun3Jpifcfew5jLbbtLq+26pm6K1wbLqFhMoToDntWTJ+0ddMcaKiN/RswNWK2kGxJFYrP0vNo6nxfIv5Wdu3DYqQfOU3Rfq5FwRBWL1ZU9Oimp+SmGyHd+zkGPKLcnXUIRGtT3rYoqt4Q+mX7L57O0CPghKGwAzGFvOXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NQJJNmng; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vs9i8VEuKTF+keF7M+ccxjunckKh0v0VJYNVdKw04/YvNe09m9eX/LqFJYmaxDSO6fCY3cmqEYdQ1u8vxowGpUimELd6r8BF74y4TTYOrCiM+C3iFg8miGzGm9vywV00JRKnHR87IAkkNw7UyEMGvXGibunQP+eplCJo+RYjHwVnd828ORsyHd54fDUtHu6tkOmuHqJRQ+taRHT0zmLXTCnqm3xZjiNsP+LQ3o842YEF7bVEEyWwj+Wj92qBmvRtmyf5gkK26CUxgLzfyiL4MV8s0j6k8Q2/tWvBrgsLxoc8XfgEfinrNV0nTZIse4O9US29WT4kd08GtV6j503PUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6/i7cd509tx0qwl417Go7taTJmYQodh9c8WY4R1ZCI=;
 b=I5tEO1lp15LQy1wgdqL9cs+d1GmK3xzaWPxj7rV4MlbjovrRaYhg2Y6Bx4ZQIX1PeSWxfWpcozimzdinntoCd5mWMODnXY/HWbzQkAJSlk683Py78ISPyhnJE5es3l4ueNGiLaO79ByQqjLyhzgeNy7B4oSOu3oSZNs23Eg71rcDqpbDl3RwGbgadux3q3W8rToK8n/H1Pp4Wf8lLJ9th3GcbLZqoKS7w2XRyD8xvFOOtnsqkNyVjjPQXRDeLg7VYU4M+sbJFC+kp7hEVbVAFStniKiX0AH1D5ew9qpQebd+g0Y0YU6VoQiS5my21hvmCdgZBOpOTVWsjwwbf1zw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6/i7cd509tx0qwl417Go7taTJmYQodh9c8WY4R1ZCI=;
 b=NQJJNmngbGq/2aaM72OFCWbIv5VldPyd87eeALaWp1k7o8sNCeviRO9ljEpxkeQaWnT/fqSvPuHB1G8OhtBktAYhZ7nIUh4q2PCBmlwvFVbmKELp3P/ArqDwrN+t7RDx5E9wvfNXnYtbcz59dJbykXbpz5DihMInInMfQbF8vv+B0eGXCk5xbIKiz1k+1Sz9qH34jW+b6DzH0NGpbkRPC4rtUV191jPfrZLzxt0UDbPhwjnnkPl9Mktw6qnNTAjzlogDZRhQ4IjWMsgET4CnKKQUh1Qb/QYEg4XDdz1+wqHigaAi43BTZovOQliBRSoJXTMkoozRORdAckmgGI2ApQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 07:56:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 07:56:55 +0000
Date: Fri, 29 Aug 2025 17:08:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] clk: Introduce clk_hw_set_spread_spectrum
Message-ID: <20250829090812.GA16625@nxa18884-linux.ap.freescale.net>
References: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
 <20250812-clk-ssc-version1-v1-1-cef60f20d770@nxp.com>
 <aK8oD6HNw131avjI@x1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK8oD6HNw131avjI@x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b52847-5f0c-4a0b-b6c6-08dde6d19f16
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HLu18QYpyWJ7LfSwUIsIZwaWzSy08oriHfrksPrJ5iJTpk+MJBNuRuR3S3QL?=
 =?us-ascii?Q?pqBR2xMPfgo1TDzc8vWRAw4lfICs9GbsRLV79aeKeZ0WnE0kuhZUrRF2pAKM?=
 =?us-ascii?Q?HMjXKG+Q9O+Tl9Lha85wGJSkwogxhbEIZsXeueUeUnUfLCSmURx95EhoEppK?=
 =?us-ascii?Q?bn45yklXI1WOPyKV1PmEU2zdak5c+Wn1fGbbpBI4K/v6xQj4KLAbnW3ImOc5?=
 =?us-ascii?Q?aKp5ZydkZ90wKEHuBhvK5lXR3Qx+0ZMB7CsRAYFSPj9lQuCRQG9z9JvyX8aN?=
 =?us-ascii?Q?KJhG8+Kj7pLgWuZRFoQgrYm+3ourNF/aivlkd7422qPFZYkxpt8THzBqzrTI?=
 =?us-ascii?Q?VziBTaDfw5KoSTF90cPbHlvyJQ45oeax9+38K9ishgBny5471Ph+3/U1wAKz?=
 =?us-ascii?Q?eqq3RpxqrEX0Wx3IVfooqEjjGnrNWngAwgwFbLNce2uXDBJe8tBhYPLDagOl?=
 =?us-ascii?Q?Ql+BNQe7O9kQddZqkByXJUXdOkHhMDUVq7PKM1/9wBPIq/yVTX1Rjlxh8Dxw?=
 =?us-ascii?Q?kQwp9Jd+tPMcFF+NR/xsuF5/8vUwDZDfOtXT6MPKMFE7XPwwL29jqimwBl47?=
 =?us-ascii?Q?URUauwj4DOeNkZkbdN8Yh/R2dW6y1Ft4oLi5Utlo8jE77N2dga2bx4A9oSmt?=
 =?us-ascii?Q?oYTJM6BWaT1dTqwmUJm8zxCY4+9zaw3rk0JmihFeWxSi1IFp93VVekihrJhC?=
 =?us-ascii?Q?xszjae5s58Irtn9fJAR2RQyjppztdo7rOnj1mui8aYi1qRxKE2Hepgsc2/rg?=
 =?us-ascii?Q?PcqYgtTU/oA/EhoFn9hBhRTkH2rvRQ/2ycUTFV5lH21nqn5uRNQakQ34Q5L0?=
 =?us-ascii?Q?BX3pAapmtNUz1zkmq80zk2Oa3U426et41ndify2I6lA+g/BYEsHqBN2XfIn6?=
 =?us-ascii?Q?ZPy7BNfjC9O95DfXp1+VVK+Bm/bCFclmTjYtzrP0d4aPGJpEuRFVGVFqwTNv?=
 =?us-ascii?Q?YQGklhUpp2YfDrL6Xbckh2A33ZrXfDLd3wjVZFKQ6tb5L5QwFwdJnHnvyW5l?=
 =?us-ascii?Q?jAWQ5mKHJdpkDNqYdKcS6/PUViexdqzhYfeDqCfZ/n2Zf4l0HM2CQUDFP1MD?=
 =?us-ascii?Q?IMqsOkllnmEZbqk31MQPvGYCKTmMZ9ubwQANl7KIJ+DBRtd4xwy9J9cD+bh8?=
 =?us-ascii?Q?keAcqxu8QGALYSAqATwAF/xFoWhLTYOqEMzOyoSQsZ+BaDCaUHuWv7iK7oa9?=
 =?us-ascii?Q?yAcC6XiNtpnR3cev0YeSVHGwvKiBI1Ks/OE522O/6oQiXKDhMLymtRKp4kk2?=
 =?us-ascii?Q?i7+ccVUBGPE8MnxSdGjyi2p1ALqfOeEEgWDwfH2Meoc8Slvl3iH7AJ2idqG/?=
 =?us-ascii?Q?DA4haccqGb+dbMwZDj8nkY9+ZH/j07SlOaHvhD+YjeIFm7A9oBfQiov1SGMv?=
 =?us-ascii?Q?UN0dabEN3SvN2X3Q2Jlg/QPmvFIWh3I4pzxbJ9sbwXzMS7l0Vlk5DHmixUaH?=
 =?us-ascii?Q?DHpqHtim0MfW4LrGDfRAawbbG3tHIswdSI0MgFUWr9zJxMWmmE279g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oef62ZFWO0iYQY8rmkK7c5YX9+sNiq1Oe7GhCMq7ZsCcBHU4rsu3VAkLQKDE?=
 =?us-ascii?Q?20fhJNZIzJJSkiGw789RUjQelxnla3QmwArLmeUx92m9SPIjizjIN7uDk7J4?=
 =?us-ascii?Q?9X3tTVbP44SPTg40i2LG/iZFrmAzqg46lc6GP4hQkqw4h27VMvMP9ArYi9OM?=
 =?us-ascii?Q?UyQpiSMdRinXIWa/PUH7UCzUcJZFS6Vp9TsKRQKKtUkLZ7VZ9tZaRaSzUifD?=
 =?us-ascii?Q?/s6hW9UjnXGMVKptun+1RZ1natnP0P2Tez9TB3NEg9vOiw72opNoryX1D0nt?=
 =?us-ascii?Q?JlW6kCMiPUebJ3+woNad5llbFO8gLx81kDDc3j1QFuXXVO2UyMtyRObAYzaM?=
 =?us-ascii?Q?npTlYGNCrQ9zkj1+9h4gi+Auqs1INvZULsWDlQAY0eMQnCdDwZBfm3fwaD7S?=
 =?us-ascii?Q?FXNu8xp0kJsJlsZBuvu/JYjCiNgwqgeDetgKuAMh5UKhGmr0CYi4McFyHRrS?=
 =?us-ascii?Q?ekHF+A3FhByxIvf7z+xwOHziP9htmIyXebC0ULhtXWFwitQthlWRBPc2lwJf?=
 =?us-ascii?Q?bgGsa34OjouLjupT1Hx67M7P57jzoY8Q8hfdk9p2uyQHGwZm+PBUteEwzKKQ?=
 =?us-ascii?Q?v6rhRh/11fR+gEe04FItL7fQr+NOxLlWYTnkK28DNYVrVfrGb8x7zIx2ErJ3?=
 =?us-ascii?Q?dB5STHD6+zo02QcaFiAcwtnTmzcpGsjZKSEoqrFydRfenRT6cDMYWwTQxqFf?=
 =?us-ascii?Q?u0oct2giNX7xwg0uedIdrQTbmkv9/9qeRL63Q3Uhux1LHVyk8HuU9bYAwwur?=
 =?us-ascii?Q?iNRNifjMdS9gEQnTRD0a7x9KYv97sHi4hAUKAEaqdkPPc8bgNg4nGi8JwAds?=
 =?us-ascii?Q?FRGccSF6tkGeWa6dU8iZrSNL8EGxRLy2MdK2tVTGgYZMm0L9B7PW64uyce05?=
 =?us-ascii?Q?np/039Z3Cdy2XVhM4kZegOK7JchZ/SfTDNTW9JGt8A+eXwwzWhuruTWco/u4?=
 =?us-ascii?Q?OJebq5UNO4JYDmKDt7ZeUoTHvlB8kJ5LnYBcKAALKGQ13U3pm1ESwFrcT2v0?=
 =?us-ascii?Q?y9Vzams0bsTFpUwysWVaY3Ff4qbBjHUmpYtbLVPnNuNY06BgjyAhkEWWk/ZT?=
 =?us-ascii?Q?K+WINVMkZLa40p5+4oduE+2Llpu30yPEWYGcFYxVMbIpV5g0hgDkM6ORvCcN?=
 =?us-ascii?Q?5oAxNCJ5pvAbeJK4M8qDaKUUonA5GiUgRoOJ/llSZNhcciCFnhlD1v7I6afn?=
 =?us-ascii?Q?g3thS2M0i6PizmUz85bwz01ZmVBQSDoXv/nfp0wrh2PDXAfrl8i/E9zATEJl?=
 =?us-ascii?Q?/+LyNVfk2GcjqEyFy4rL8zEw5rZBZny5KRB2G1z5ClbL1uKaWYK0+zNpG3Jq?=
 =?us-ascii?Q?eM+AwpDBqHNVVI+J5VB8UcDFXBmoxcs5WNmnRn6zUNMsw/HVhrTPalfQKekq?=
 =?us-ascii?Q?pGsJACGeHFceAcmK41FeYiTZwIMJ+id1Cs1ioFizZ4xjhfsJbtmaWO10+PFK?=
 =?us-ascii?Q?iIBHzrt9+pJU0G6Br954kU962dTxgqIEKlFtSXTSGDMRdnOqy5jibPP7jlo5?=
 =?us-ascii?Q?Q7E+C0MdagqiDsCmhZ2axuPDKenjTf/nT8BtF+LWB5l6WYOfzAj0NoLClqt0?=
 =?us-ascii?Q?xeD3wyUzaRUzHHuzrXQ9yYWbmiJ4iw/V+yM9utKe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b52847-5f0c-4a0b-b6c6-08dde6d19f16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:56:55.1172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljRVHAeNvPvmnvycKC7/PwkwxUrrn4ksce5xKQ2Ln8NPbDuhZuJNA/TGPaSxrBmVAGDqfVjAZJqCI3C+Pm73+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139

On Wed, Aug 27, 2025 at 11:45:19AM -0400, Brian Masney wrote:
>On Tue, Aug 12, 2025 at 08:17:05PM +0800, Peng Fan wrote:
>> Add clk_hw_set_spread_spectrum to configure a clock to enable spread
>> spectrum feature. set_spread_spectrum ops is added for clk drivers to
>> have their own hardware specific implementation.
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  drivers/clk/clk.c            | 32 ++++++++++++++++++++++++++++++++
>>  include/linux/clk-provider.h | 29 +++++++++++++++++++++++++++++
>>  2 files changed, 61 insertions(+)
>> 
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index b821b2cdb155331c85fafbd2fac8ab3703a08e4d..48c7a301b72b30fd824dae7ada2c44ee84d40867 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -2802,6 +2802,38 @@ int clk_set_max_rate(struct clk *clk, unsigned long rate)
>>  }
>>  EXPORT_SYMBOL_GPL(clk_set_max_rate);
>>  
>> +int clk_hw_set_spread_spectrum(struct clk_hw *hw, unsigned int modfreq_hz,
>> +			       unsigned int spread_bp, unsigned int method)
>                                                       ^^^^^^^^^^^^
>Should this be 'enum clk_ssc_method'?
>
>Also can you add kernel docs for all of the parameters? I know it's
>documented on 'struct clk_spread_spectrum' below.
>
>What do you think about having this function take that struct instead as
>a parameter to match what's on the clk op?

Yeah. Dan has raised similar comment, I will change to use
struct clk_spread_spectrum as the 2nd param.

Thanks,
Peng

>
>Brian
>

