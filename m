Return-Path: <linux-kernel+bounces-854499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37349BDE84B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DA2402EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AB71B6CE9;
	Wed, 15 Oct 2025 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="x66N/t51"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491DC1B0439
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532174; cv=fail; b=JFDwN5QRJd6X03yO/LCCJxF5KTVTgEdEwCorQo9UzWF/wHIPGixzT3Mn+OykT7w2fRZKT3mmWkDhoc4G/MGqlGTa63pZRjLhpwbveGgMH2N2VQUtgtMjqsmnp276oJbg2Q9mm58HtQLwRs31UnPTdqLIGbsnq0q+OE/2nf7tOYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532174; c=relaxed/simple;
	bh=Tf8szCPRDPHhd02rVxbAC38e66voxf9aTA/sHOX6ePo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KHJqzQ/OdzZH0M5NDV9HiNkZ6qKIO8dXHOmF+RJA4JOcalQMq4osBM+KDhfVFumIS1dLzGWaSIIdDcngzNYnQLmUEk/+pxFs5h67XRC4+lbh8odeESViJYD1E8xI1JCzYOyJHWuj3JnJ5dYkqFUsmEMel3FL8D/ChVj1pp+k8Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=x66N/t51; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDNfChs9YjtHUmFx00MxyVVIDfq3Q+RIJIhwldjObOfqaiiTheo1DRBBMPB0QmmMI0fBH/d//uUkAXrYqH93AqKekNcPxytQWnPxqv/p0P1JBUGa9uhQZuD1Y2nwTanqEzfNxs22BhAIemPaNtt7HZ0Ux9TPU9Lqkz+M9MOZ0A3Zk4aZI7/0oDBVZRI1kTyI9dZairs1/XlhYZhT88K1o3+Oh93SgNbjLELPJPWwOlmg7mZDgPVWllh70Kx6Zle6hYH/5AJkdzlsgZsmpRoRi+aBLqxdfoD7Sl4u9S24wbKmr2FrH3bleivd+mSHNfcW/VSD9SRsP1MAuwRqOBZCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hpnPQiRP3FNHD7iq56gdTDMHg7THYND/+0IMnv3ckE=;
 b=vgvK7YfKJAceSuPKRYl5V+ufAydqWw9nYwBpE/5oKD7uiISiOQVogFY4Y7fbbILahjjcQYFlGPNicEAb7FR54mg0Luw4azw9kjs7z48DYyqCKXJo6buBDXdhg2WSAVbm9dgjZMqII5ivYODquvYyycYSfC60eiPnpUmCkWGGeee89nQj1Mj7M0MV44sqKpe651qusfqRLbDHu5mTjHrt7yz5AchDVY+vLjTjCcmHuMkMrLJQxxjjfqPD0WARxxt2fpYxs0A6MqTMvdGSJS5CJj3hskQi/3i9XHgqDDMRG6bjgM1lqg+AA6BBV6ZMtX4mkH5kODeCgnC/cgJxZeEEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hpnPQiRP3FNHD7iq56gdTDMHg7THYND/+0IMnv3ckE=;
 b=x66N/t51Pnl7WCliaQKNxYiZoYGJd/KrJunqW5N7k0AtY/oEEpa34KboNa7nqjxbEDkCcwsliuOjpnuL5G76CTs/jLjWFilMYwNYiKSj11LZBedMOSQsJGu6sE513ZNLDQ3sZqYsC5LBHAKpfPOUGDlGq1sBwmcET8EBXF+mtDcgkuNFaOjKIAMZU4wfT/SAnBqYYgB/pvCtUeDY7LyjhXJMjWnoyUShxbSuheVA3PL3RBut6pT+NHmPtGsxR+89hJJVEVOZ0+gVj07qIrSxCAvvrq8kPpS3JGzkHQ/5dxriZIKWEtd1RLEDjJRSM6awjcyMBx9LXbL36c8j6VGUyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8284.eurprd04.prod.outlook.com (2603:10a6:10:25e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 12:42:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 12:42:48 +0000
Date: Wed, 15 Oct 2025 21:55:03 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] firmware: imx: scu-irq: Free mailbox client on
 failure
Message-ID: <20251015135503.GA31091@nxa18884-linux.ap.freescale.net>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
 <20251014-imx-firmware-v1-2-ba00220613ca@nxp.com>
 <aO5yPLL9HKdM6yuB@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO5yPLL9HKdM6yuB@lizhi-Precision-Tower-5810>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: d681db4b-a988-4a80-7578-08de0be858f9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ll7QJ6sxzFI2GDsa3x2ehioG5Mp0q/DkGxdVFGji4ju98gtqFh3+rfRVlGYs?=
 =?us-ascii?Q?RrMU6M411IezEvi/aXe3OevLGdLcyMRAvEg6NpJiOYmwb46xfCfDso4ES4c7?=
 =?us-ascii?Q?3jrb5OMV9UIGgSV5+kq+AbU9GW3L3VFQhtsA/OGh5NVU7P3xC3BymnAcSDsn?=
 =?us-ascii?Q?PjyfkRIBZjwc/dvCLVTCYLR9/XA9x3l7wQ/oDfPD6YcOxXbT63UlkirptKug?=
 =?us-ascii?Q?lO7/xFMmV0Uljw5Sq5GKudKRmPDS8MO0PboNIXy54hPt3xhUlpSDHPtAv/mz?=
 =?us-ascii?Q?E7amODTpolOaMiIqyIwM/MIMk8Dhudxau1RgJbw/A/3Y+kKUv178MIRTcSun?=
 =?us-ascii?Q?fcxf8pA6SYVmFlxt4yGt16uMf4m4Q/zYPOglV2okH3LY8gmurbG3Mtve/ptA?=
 =?us-ascii?Q?sH+rmr5qTb/wdXbC3tFt245jz2xyb3ulbhX6Nd85fvr4EteCXE09L0oxKkY3?=
 =?us-ascii?Q?7Qb0qU8hVILwBrSD5Byw0BO7pLfnMCnUtByRPs08tZJdHVQX59OAMXtpIWkK?=
 =?us-ascii?Q?oW8ywbAleeKaNlTY9aJThPmbgWi8AqPoLZWPxl5YOVtstxMC0cMngxUGwWPg?=
 =?us-ascii?Q?InmMAry/akLky4EHlad/3MexJFeyCxM/7Ghiogx406IL2CVmxtqBNhK2Et4n?=
 =?us-ascii?Q?wjNX4cbXkaSwfgbbOWmikEIz2/LdRuicf1qsrtErKgUaEWdenq0efINSH9K1?=
 =?us-ascii?Q?+V266AozoFuSjW3rYFihRnNkkA3BeS6ydrrsNlO1ue2S4YDTzX4bghtzrITL?=
 =?us-ascii?Q?vrg70nqp/vrxB6VL0kGOciQbQadbb8wfkRtAOjBFvArDblEmIyofTxYiU5ib?=
 =?us-ascii?Q?9ophy/n1/1gKmy31jCzlGcqc2S+ozaUymSjhh35C41BskWjlcz5usVT76uBs?=
 =?us-ascii?Q?mxFr11lSl2FNPM2lp+6T9zOca1wqyoLuFm30whzgoQT/DpKV4SwCSsupJnPg?=
 =?us-ascii?Q?d27rqgVtqTGWVVQE8Z0fG8YUTL2PeD0z28AnP5oRDoUSXCfpbXW+foX60hIb?=
 =?us-ascii?Q?rKAZ2wJE8RYJsPGFLj0Im7KR9jzUNQqPYGOEUQoSarat7mtZ+pUogOTWqkIk?=
 =?us-ascii?Q?CJaYa1yddBYyH+ypRbxKG7tXLmwqU/wo2zwcvuLAlBf2ZnfgAw8HJidM87Zb?=
 =?us-ascii?Q?LvJNX1TMfIHAHl/fR7I0JhbuSA1qkz+67+9FRAcFtQuEacrIWKtLGxdQCIXQ?=
 =?us-ascii?Q?Z8eDhEo//RsRsflIGWlxmhFEXNfpVEFKApVOs5T2NTRn3sMb/wuXbp7GtkDP?=
 =?us-ascii?Q?51HeDXaCRrSgCrSp2KSi1rCcoCLrie8XhALhMsV4JL4hq9qI/ae3QqtT5QkS?=
 =?us-ascii?Q?F0EK39IxOe+lVTx1tsB7XugbL/+hRdZsT8n3Vo2AURN55oy7NcySTB248jCp?=
 =?us-ascii?Q?UN9eZNm/5a7DhTArH1Hfurzrzcy8EXfSLiof51bZ2EQoyZwY0tqUPKiS+idX?=
 =?us-ascii?Q?JajhbSAP+ZgzIfJqk8bJOwMFanD9R3inLGGRmabG8TC4NtwhWs9NOHXtqeD+?=
 =?us-ascii?Q?6D0cwzQZVjH9CkCumENnkX4pGwNtH41FNI1P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xme/vDP3lTs/07D9Z1LrVCwrMJSdcG2KJolRkmbfCHY6LFPms+HT/veIbfXs?=
 =?us-ascii?Q?H17jULk4LGVcuWj8NSNzU2ljDUyajnYBzJhjKfYkXoCZ5OQv4hNRNcXAYUbd?=
 =?us-ascii?Q?x/AjjhkF0JvH07I5k7VgjoNj6Wh2DI7Fq8qcdcHL1H7Y5HBVSE7qkDcNqk1P?=
 =?us-ascii?Q?h1s4nieHsjp0LA+zmRsIuSSQ/DmkuVXCeWJRubznQkmQCrFMOR36wsIGM5co?=
 =?us-ascii?Q?IlJFe/1tMIUZUkvU2E+WoBssBzUHK9kdMSgQjb8MAz/YCKk0ZjTyNOCPXBeW?=
 =?us-ascii?Q?yFNBHerO4oVi+9wi0WF8zqt9fw0AmZciOU3re1rYPfB5tMPyPS0vcy14n2ya?=
 =?us-ascii?Q?qaXbzN8HC2pk+pWX01WNTtthqz+MrwNEY3L5Tt0tTTvnid/O6+J+TX+rzcKA?=
 =?us-ascii?Q?TcuKl1TMvR/wUKMPs22Zmu3UEULCc7HnmEnqIM3GT9G6XNXsYz/2TKHExF3f?=
 =?us-ascii?Q?NWwWLzuj4BBF+16G2vQri0Dlf2thXVxRmXsyY6DEQqT7gxaeDlPd6OHSKmGm?=
 =?us-ascii?Q?K2bBHOX+KZSOstyigWC7G9JIcS4P4H7c++b5ZsRn+gjpnOYnC9fYXXRUG0Yi?=
 =?us-ascii?Q?o6Cmec8rkKsH9JJf8cPDlWg9KBZGl+na3gWExFgkzbPEASNwFVbzfsCngmI6?=
 =?us-ascii?Q?Xz01hCSKHcFl/beTJqEdqnes8Hlc4+oo1xszAreLiWkrJe2EpkKw38HKN0vG?=
 =?us-ascii?Q?BVvZOwYIgmhb56f+WjYw17JllzcFoFNP4Qyl0nVUL39xdt+tGIfo3y/2rg6k?=
 =?us-ascii?Q?xAx9Xq7XgzC0wAhTe6+146cCQ7/SHYsQsqJgjjj3luZ3EWcs1exhz80HJpu8?=
 =?us-ascii?Q?0/4Ta6xFr3ZxKmIlpUwU15Bk39avYjh/IqpzkDo1AGcvDYGwbHiSUJqLH1jX?=
 =?us-ascii?Q?OJYJHRm9ZGLvSKnMHugUTPGRxecD60yp+1KUEY7G1KMhhBSzMiWxCAvytC4y?=
 =?us-ascii?Q?y8FeN1rN6oFE+5WlxzOpljHgahIeBARj6gY0ohGeZbYp6SPuD8NEj/JZSEBX?=
 =?us-ascii?Q?EK4ZllDSfYf075SZXXX4pbFAw7izIOW43VXxi/WSTpiOqdV8xSvjRIZibanG?=
 =?us-ascii?Q?FYhsyglENz0FKMirkiPHRb9a4R61i186A8lGNZDHetFPU08fMAHUC70ShnG9?=
 =?us-ascii?Q?ycxAeqS+ARaSODM4H+5cUL7esSdyfEEruyoDRDfkxCDAUGhMemZn1kwd4Tau?=
 =?us-ascii?Q?AyNKDJhZnB6ZMD0Hf+BekzXmCru76hCjnrnc19BEhz8PFRMuORQvTK1n8uln?=
 =?us-ascii?Q?iPDOjr5Ni8KPewnLdxvPFX+4W5ykZKMh74qykBiTF6kbuaKZwOnCkSEHmRJu?=
 =?us-ascii?Q?vjZ2ZXvwoeB7hITTzssP5s95MmtIOmqxk4EaYuaSBY3c0lbBIjpICtaW6/Gi?=
 =?us-ascii?Q?WdZE77kYNuzM5SGDfqswxa0uBzCVkEQNqbGp90xYqg3/TI3nU2tNoyZHPNfl?=
 =?us-ascii?Q?PVyk0wcBF2GXv9PwH6AQW0NWrnyCGLx7zRgFYveiOckdMFRb75dBCgxnaKLS?=
 =?us-ascii?Q?KOk6BxUJznB/kHO8aZcENqcnmMc9ul4xcs1vNfIHUgcKtVIfmZFRwlIEwS7+?=
 =?us-ascii?Q?vLGwr5a8z9a4IioTRCNOm1SUAhqdwqhgyVDjr82P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d681db4b-a988-4a80-7578-08de0be858f9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 12:42:48.9416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM7a+xkBUXptWiVJUgj+ONvVw50DO9h/pKZyWsslxC6NxzuBdKtRU4uNFfqhu203NSfXJflAy20nwGCJdLsp3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8284

On Tue, Oct 14, 2025 at 11:54:36AM -0400, Frank Li wrote:
>On Tue, Oct 14, 2025 at 12:54:39PM +0800, Peng Fan wrote:
>> With mailbox channel freed, it is pointless to keep mailbox client.
>> So free the mailbox client in err path.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  drivers/firmware/imx/imx-scu-irq.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
>> index f2b902e95b738fae90af9cbe54da4f488219906f..1fbe4c3de5c1592bfcf2334a83776c25d5ca7a3f 100644
>> --- a/drivers/firmware/imx/imx-scu-irq.c
>> +++ b/drivers/firmware/imx/imx-scu-irq.c
>> @@ -255,6 +255,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
>>
>>  free_ch:
>>  	mbox_free_channel(ch);
>> +	devm_kfree(dev, cl);
>
>
>you use devm_kmalloc(), when return failure, framework will auto free cl.
>
>Avoid mixing manual free and management free code.
>
>So I think this patch is not neccesary.

Actually in imx-scu.c, there is only a warning message if this API call returns
error. So need to free here.

Thanks
Peng

>
>Frank
>>
>>  	return ret;
>>  }
>>
>> --
>> 2.37.1
>>

