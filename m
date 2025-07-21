Return-Path: <linux-kernel+bounces-739264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95174B0C410
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4D854086D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245E8283FE0;
	Mon, 21 Jul 2025 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ncOqW8X9"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011008.outbound.protection.outlook.com [40.107.130.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BAA3C0C;
	Mon, 21 Jul 2025 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100796; cv=fail; b=LkhY6QoiFy+l8A9m3/NCDcdDLdRxR1Il6CvctVunCoyG0AKAGvX63RNKqnzZcqLxqdNUqT0t4Dp9fTjmRg23Xn9k6TLOHUhnibAIWtSW+FYgR1ICr+pSBmlr8/tGNPt+sxNTFZJ+KeVXR99BZ0jyd+/x/ZWa9oSUUEAzbq4kjpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100796; c=relaxed/simple;
	bh=uu2qiwgtlP5QiTwPszxmRCFsDVVzqsVuAPqk3oVF1t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PKIxMJL4K4nhqJSm5psRQVLhohc4WtYixtzSow3AVfe4i4nEGxblGeSqozSVxw1Zc329eLE++oLcwE2BlrDc7ioPolZf0ZFcHmdiU2LEyOQm68ribdayCn1kJxZrwpb1FQRWhrst/ABfNu7oqBagw8ET78OK5oOCB6uqUasAe/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ncOqW8X9; arc=fail smtp.client-ip=40.107.130.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3GZNER4hoZrIIL5iWXmmUEsIcdAcbXkfr1zTm03QerXKXLYMfjDFxXouvdOvihkDvY09bAHAtiiLPhD6/CtRchVZ3q9WWfSHBtg4YwzsriLZ/tynOxdlyZOmbbKpasqAM/U7vd6RuuLbfJirD+PMnBakSTTTrPW+Tw31bs4ZsjJjIHKoc1dQLAUKM5+qUYIhyHQBrN3YtS0ZeaYHuosdtEOmnk/ihQpj3E3hU2RdHWGDPAri9MLkRhIDTsuUApnXUzfGB6qD3ypjkuzE3VKlX5nkDh797l9FziLEDW1CibqTmfkcTCaOozNjAXrMEHAYefgwPWcctL7jMsrxAq9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piJwhJQ919phfQ5OxKysnUVS95zLVy0Ri9N7o+nxZk8=;
 b=nepNABozmhIK0AupjAxA/cWFW8tP5GHGajUxVRB6dsDZfG1qtVm4qqlmtMpNAXfnK6WpjOkfWXkQ+tEeWnIXtaBuP4/9hHmEue8AMRoWw7uiFU7FXMqncXqUMEV5Mo1BsQ4G0pbdBzeQHh4+NbyrlwwvLCO72FZINR5q4NGy4IOQKK3K49VnX3t3dkiUDOI2zx5s+6xDwINLRG5npFAWkCAUfZGPQARU3PP//e9guinkB4Yzr1Y3Oo5DkVNPX2o4OkKIPT87H2nmcIHuCGZMeOHW73+HyxcBmi2RMlz6WGd3+1lqDYYHdDIZDBZU9n2+oG4adEJ92HGKfZSSYlHMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piJwhJQ919phfQ5OxKysnUVS95zLVy0Ri9N7o+nxZk8=;
 b=ncOqW8X9REHPBpnaNc/oA8hP+GDzv24TPV6a7K9QmOSeXsm58uyq7v/+W9r7vdQjqd050W2l7YFnXwI2FpbVbt1kEipZ75JNa5k/qVKfYpekYq8TdtcSDG73tD07ct5qPjgvxSybSBZeMknH10LIRVp/xqB6gLKABOZFdbKaIDhghyBb5I8p3mTD+zocfDIcoJGPZaHBwA/QIGUa+9GO5srju+RDe4l00aUDAPEOeFhcnBWM8dQOmpdrP4rrbaOmCzQylsiUnNSYEROiG9xNUEuAixMe3mqAxyam19927phX/S9V45i/YY0mQsQGzPnr1NJovNQ1rM+nNz7asP+EaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9260.eurprd04.prod.outlook.com (2603:10a6:10:370::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 12:26:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 12:26:30 +0000
Date: Mon, 21 Jul 2025 21:36:56 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Frank Li <frank.li@nxp.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH v3 6/6] arm64: dts: imx943: Add LVDS/DISPLAY CSR nodes
Message-ID: <20250721133656.GB27698@nxa18884-linux.ap.freescale.net>
References: <20250707-imx95-blk-ctl-7-1-v3-0-c1b676ec13be@nxp.com>
 <20250707-imx95-blk-ctl-7-1-v3-6-c1b676ec13be@nxp.com>
 <o4sxmotqixib4tqbvjb5m3l6tnbwbjzodywla4ezf66zmwd2t2@5bd27bkfnsy2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o4sxmotqixib4tqbvjb5m3l6tnbwbjzodywla4ezf66zmwd2t2@5bd27bkfnsy2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c5fd78-7281-40eb-9c72-08ddc851d20e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3kU+bgdIxyYZ23kfFxyAJxpJzyrLOsxvo4WL2pcynqveTmk1/oGmilXIdkP6?=
 =?us-ascii?Q?PC7WrYxpvgD2egRBdaSnzhTDe0Pv8s+EgToY9+rS6acnlya10LPExao2hw+u?=
 =?us-ascii?Q?ee+3G2QVk1m3sZVo6W0cuqBQpgr8ikiDrWKJfKqN75G3RqgJQDjKVqmu7cLn?=
 =?us-ascii?Q?asJyCg1cWdVN9BMel5iecFZHMrRaXhOd508GXy094yVHuwC09XrOs1pFpHQk?=
 =?us-ascii?Q?EggQ/i2hh76vCZRMHwOXLN5FVBxEZz1zPWI+UPIUNkIh2WCMmjKOSDc4p5fr?=
 =?us-ascii?Q?rTgoc+N99PedX6Rh7VaUCNmM6FXqXVtlDq/kPBfJDLWnpuf8JVu6CSkmO/L3?=
 =?us-ascii?Q?NTpeEuSYrUVJ+KyhxGaob8BLHbOrvP+2MQBXa8QbxbEzotSCGj1dEu+14T2i?=
 =?us-ascii?Q?hr9IHhyTdR0vWBNjZRDGCP3sCoeZHEDkw4+GGiqpJG7LqLaXj24hwzIkW4Sa?=
 =?us-ascii?Q?UN9WtTsiS+GrQfLOaRu95QnUHU6m9idbmaPfhdK+nuvuizc/ftI2wiCgGejO?=
 =?us-ascii?Q?kHwD8rGmhplJIgIYbnG+UHdXfSXT3oS7PfOAH/dWfFMVSqpvWGTScrEhUkJA?=
 =?us-ascii?Q?fSBaqcV9ule9uwJa6isqxekQA3276dyv8UxjZyZxk/NyOWKffmt2OSsMYcGE?=
 =?us-ascii?Q?tB/MkQMty8e1IWeiDXgmuA1P4a72LVVz2HJDHrCS/G2/ZvVrlzjjoo1xg3qI?=
 =?us-ascii?Q?GN8drObklwtUfpDXPiiYJkPBCnCSDBUkFlwyh4mqCVhXS/miBE7hWuAw/I/t?=
 =?us-ascii?Q?S6/lLX36k3u3+gQVnbCed3ebP7lmH9jjoFzJnzKyJ8HyHBrkkA57J/ajsSBc?=
 =?us-ascii?Q?svCzoBbccOslNIYU+o9YxCz8MAUUOUdAQtBv+685xXGM+eBatW6zKYeXpfTA?=
 =?us-ascii?Q?9Y8FR1EPA/ftLS4buuR0FmBTu3og0aeUMznh1xYVD+2mUByGEsX9hNpki0OR?=
 =?us-ascii?Q?rwf2yZtiUh3N8BMGeXdxgRINCgzOzrF5XNmPHgczCdHCe7u40wDZ/t0IyOcw?=
 =?us-ascii?Q?stxYSS7SZ7kKpIOIbGTqY2PJ/IErOj/VpEoumWG8f4McphExtIe8/vbaRMU8?=
 =?us-ascii?Q?tzJTVqYTG2OVjezc1fjxVcT79Zg6LXHCY0X5L4xhxb1dWxsDC2K5D8FhFMW7?=
 =?us-ascii?Q?yPvGokICgShL3tIqmIljKHnio8EYhgRNdEpY0HRecTwBiSwqGEJdxQUwU5S/?=
 =?us-ascii?Q?PC2uKymHFLYlRQMRXYg4xTLXYQ1CmJrG2GUfwhnFxm5/T8J29GomJIft6faK?=
 =?us-ascii?Q?tXmVi1C+2VCPsERSlF0at1OkO9awp9afx29SXVFBrDK3uxtT37eloBbWHXmC?=
 =?us-ascii?Q?epeQ531C3rKrF8u7edn898EXyLt4WqTn8geJdrt8bLAosSWU28avD1mU/ERT?=
 =?us-ascii?Q?XwKbOrFAm1BZVMLxjnggb29311Z/YaslYThzRJkfgltNw6e08BkfmRQ0KVnm?=
 =?us-ascii?Q?rzLud1EwWRGVMRN8l8HDbvP88FMelWdZ1/o/9MEXuPrr56yzDYVnmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xGTloRC7j/PNmuV3/AfGeKY25rlk7Yr4pQuSe4i6KXfB/aRkSGOcHJN3a5ng?=
 =?us-ascii?Q?HVwgXP+lhdvd6xp/RjnRJzojDcjzXCCDh6orkMyTCodEN2tixajETj7kAjLw?=
 =?us-ascii?Q?vnBgHFfyXcb4i4nZpgEnPGYz+nUM22EyPl1YAbobmdxLfVL+7QRmSL74/Dg9?=
 =?us-ascii?Q?nKQBP3X/4WcHHZ/qPRNopnIwlLewzppU1jBLRkAwTwnBcm1BYEbAR6xrNcH7?=
 =?us-ascii?Q?gc4uVlIsR6Lb44RZtnxKvAR7FYnLjVP87SLfWJr/+/f4ORlPN8mtWPUJzjLv?=
 =?us-ascii?Q?zrt9DRfXJtA8aw8gdAl6m2esTtjSxTZNpRZyfbmqBbmYLQjbf5nok/LWsCPB?=
 =?us-ascii?Q?UQRFEdWLTdaMZnkeuf2YbQ3DQsbEYEsd9QDPCprksQRRrEOkduAOVHNLo2fW?=
 =?us-ascii?Q?TfW/WI0JpLdxxwGL8oNObXttbercWV4OSBaK1NfQZbLtzQxtKUhQklDo0Pfi?=
 =?us-ascii?Q?VjFPcxopoaEeHFCC5BNsrd3IP+Xbd0W1HrtAzFXrvrUU3Q3g1EUYUwmoNIBZ?=
 =?us-ascii?Q?03MJJpHa82j0NN0cKGXWoPSMEPanDJXlv/BckfUISMcHoU0pjzaNlktGSu93?=
 =?us-ascii?Q?JaOUJ3K8x+TLWhJ8tSRq8k5z04L/LhwbHsqHDwZFIxEAuf5OnfDHZciJDScT?=
 =?us-ascii?Q?edyyNR7YXHoBdFjRypLH9SyNNitul4fi4m98ilamEMEGjwCCtzG8KH28Nl0o?=
 =?us-ascii?Q?CjGxVyc78Yya94DqL3ORj3L6iuseM0b/U2h91jvS74Mee7aAjuNwFeKcpbb4?=
 =?us-ascii?Q?/D6zLMG6Wx9iwSMiJd6Qw0U3E6JwbVFOAg3q53HvY3NBkEV+NY4cVJqJmoxB?=
 =?us-ascii?Q?5GOuguuP80I+cxE8ynrRRlrGFcUcqLV4UWAp3rL0ZwQDZwCjnZnyNvdDIoVz?=
 =?us-ascii?Q?VskgRCeUfA5rJL5pAV5SQr1HPCa548HZoyPpq1yhSRspB7PMHWhkFv7+NTug?=
 =?us-ascii?Q?PH9LklERc0NRqk2o5a5osPVccosQy/7zi4JUscGGHZKzVWdR8X58EzolzSB0?=
 =?us-ascii?Q?OoMnKQcaV82AKzixluRBz3ExQGa+ouhXZPj3NterAdAHooSQH4uOt4AiceFq?=
 =?us-ascii?Q?AsGNYpc+5/oWzMSOXRVk+aS35IweW8++cNil5kK1zd1VIPPk1LX+hFyecmyV?=
 =?us-ascii?Q?EbWhwp9JRnqDuLwDf3CztdcOmP6sGT8l31eWzgyuVOyonKP8N82HrQzKlS41?=
 =?us-ascii?Q?2yux2HYaGKjUSVgjNIbOK/RCCYQ5mo/nVwy5/gYaGP/FEW9JwyW8eUjlsVPF?=
 =?us-ascii?Q?Z2RhiV9dtoCDSrdu+YL5HY1Gx/l/tAbDgbOQQCdPQXUgfDDQ9Jl0dbF6X9Yj?=
 =?us-ascii?Q?20jACZzylR4vK3Dvp6UeRvMNOB3ySJuS07AL6rr6yHkDoOBVQ3q08A0c/eCs?=
 =?us-ascii?Q?ImS8BqrxKLE1nZzz8sdIUEOKCv2R7uG08IwIWQo87w3yFdke/78Dr2HfWLph?=
 =?us-ascii?Q?PADCSoOuucf+m77AIX5wZ1+RrMftR2Oa6ZUlzSrTS7ryQ02jPJU4/33l/tHL?=
 =?us-ascii?Q?YqTCcsnJoF1e0+5JCjwKDHFG5deN9Cbo6pvLwWW2fIp330/uw8in0E+0Tw2N?=
 =?us-ascii?Q?CMqK0mbbubnNwoTsky13rwjQmF4znxf51YcuBwcl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c5fd78-7281-40eb-9c72-08ddc851d20e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 12:26:30.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJoXwCk88/pQFmk6PtEVD3Lap0b+DHIoRbwP+rwbkFmk6ukM524intt99THniZ3Xvibh5Ff6GjkJktosAvuXIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9260

On Tue, Jul 08, 2025 at 03:19:26PM +0300, Laurentiu Palcu wrote:
>Hi Peng,
>
>On Mon, Jul 07, 2025 at 10:24:42AM +0800, Peng Fan wrote:
>> Add nodes for LVDS/DISPLAY CSR.
>> 
>> Add clock-ldb-pll-div7 node which is used for clock source of DISPLAY CSR.
>> 
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  arch/arm64/boot/dts/freescale/imx943.dtsi | 34 +++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/imx943.dtsi b/arch/arm64/boot/dts/freescale/imx943.dtsi
>> index 45b8da758e87771c0775eb799ce2da3aac37c060..657c81b6016f21270a1b13d636af72c14ab4f8ef 100644
>> --- a/arch/arm64/boot/dts/freescale/imx943.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx943.dtsi
>> @@ -3,6 +3,8 @@
>>   * Copyright 2025 NXP
>>   */
>>  
>> +#include <dt-bindings/clock/nxp,imx94-clock.h>
>> +
>>  #include "imx94.dtsi"
>>  
>>  / {
>> @@ -145,4 +147,36 @@ l3_cache: l3-cache {
>>  			cache-unified;
>>  		};
>>  	};
>> +
>> +	clock-ldb-pll-div7 {
>
>You need to add a label to this node, so it can be referenced from
>other nodes. I hit this issue while trying to prepare the DCIF patches
>for sending upstream, using your latest patchset.

Thanks for the comment. Let's add a label when there is a real reference
in the file. Since you adds the label in your patch to support i.MX943
DCIF as we talked, I will leave this patch at it is.

Thanks,
Peng

>
>Thanks,
>Laurentiu
>
>> +		compatible = "fixed-factor-clock";
>> +		#clock-cells = <0>;
>> +		clocks = <&scmi_clk IMX94_CLK_LDBPLL>;
>> +		clock-div = <7>;
>> +		clock-mult = <1>;
>> +		clock-output-names = "ldb_pll_div7";
>> +	};
>> +
>> +	soc {
>> +		dispmix_csr: syscon@4b010000 {
>> +			compatible = "nxp,imx94-display-csr", "syscon";
>> +			reg = <0x0 0x4b010000 0x0 0x10000>;
>> +			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
>> +			#clock-cells = <1>;
>> +			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
>> +			assigned-clocks = <&scmi_clk IMX94_CLK_DISPAXI>,
>> +					  <&scmi_clk IMX94_CLK_DISPAPB>;
>> +			assigned-clock-parents = <&scmi_clk IMX94_CLK_SYSPLL1_PFD1>,
>> +						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
>> +			assigned-clock-rates = <400000000>,  <133333333>;
>> +		};
>> +
>> +		lvds_csr: syscon@4b0c0000 {
>> +			compatible = "nxp,imx94-lvds-csr", "syscon";
>> +			reg = <0x0 0x4b0c0000 0x0 0x10000>;
>> +			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
>> +			#clock-cells = <1>;
>> +			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
>> +		};
>> +	};
>>  };
>> 
>> -- 
>> 2.37.1
>> 
>> 

