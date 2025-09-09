Return-Path: <linux-kernel+bounces-807061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD6B49F67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0403B4C12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2A3224B1B;
	Tue,  9 Sep 2025 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K6W6txUU"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3FA25392D;
	Tue,  9 Sep 2025 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757386233; cv=fail; b=TVqBYnJj3xs3ZVweDHN1qK7UzUnOxrRRaxUa261WUZz5ELscPEl0s3XNPR26zWJI6ksnvzrt528FoOWxn6RvI1uM98WGpDxxBCnyI97OsRQSYLYpN5AA7ak5tBXLerBgyHESgXgSo8JfrJkVsLTxTX1ckwRuFVOj50DSWqfWaqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757386233; c=relaxed/simple;
	bh=k4NRSqceNwy9PJjuc+ZFWCrWijp47HaD6AsjNMDYUVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KOuvXn7l6EBIICeLvfLtxX98QLctgD8m2bLv9cTpL1Pboc+AEC4Ube3TpFt3g98HmA2vcRJS7YHEZwSOrDpoSOOVYyJVErRKBhOYyUO+kNfl2RgC9l3UenT5FAI8HewhvIt7BPuvdXlFideDRp+RDvpg5polGyT2r0kJrNtCzXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=K6W6txUU; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4nLWs4QIy3qpKSvwvKlasJBzBB15uQbhRNiOldH/Ffwlaz4UdrkzIDEs7dYxRpNuKl6wzw2BLTNOHSL31XQO7vyAtdtifKA+Ido97ONZCDDzEUgnn4PPS+WkLIxRYd/ndIibTGJX5HBFq6YwhyRGBNLOe5t/wQnVl5T2CqFSIgOez0ZPK5FISCyKucu8VmBI76jzX1dtgkOZNT0oHAp62eP+mFWVV0lbjliHaKkJjHbTDOckG8G4bJTwC3owYgYBWjMWebTYjdpllUIdVaRtvCZoz1wsGHG2NKNDDcjp/9LKKgNlW0gMZ1npxoOEyUrKFs09vgHYLujlqxUPPknJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYlxM+w2niChnz48kMdGGI7caYKuuoJ8tHVxSq5TG/4=;
 b=zBXbO8tRVBhZmpqRR5LxwtLyQPAV6Eo+GCnSEBvdQPUbkNdNC+909cLTsmBeBCuz4R6kPcjNuH2oPJtkdSKuRhe4I249FVDu9BTZuwoOq5fRODijA3AWH/m4Xrw0800uU8pKYwMkfA5Z9dMuXcsJkqd1nUSW/LhcupsWy0Fo9wIm0BKt6j2ATOfh0+utckMwr4XEMTtXXROLtT43OXUUad6XFcr5RkJlDmM/6ISuhN2hVK05REn4zx1X9cITaKp7JBFHhc5mmaQLIQHwzGpAOvIsq4WqGqzQlPagNjnVob73g3fPiMdSVEJy9mKCDhWBKby547n/MRJYkmeUiYK8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYlxM+w2niChnz48kMdGGI7caYKuuoJ8tHVxSq5TG/4=;
 b=K6W6txUUh2Ld9/U1PUAbgid4r6+t2UdrQWD8y4+uGUJWNlaOtmu/vlgs1EldZch29tSDlAtV++t6crUEqCtOXFOX1E52a1+M4VkYGtTeehHTLX+Euzwzw3AOVjxEPyDibaf2gXhI+f8i2+gDSW6Ada4r3MBDAfkL8SpYa3QiCEOkOyD1hqM2PPelcGdSzY+CKLWixCSoBINbzUYFIRfwX/skibOqKVBm6JMMxhNqHAT4kOMiw8jN9X/XJMAy/dVkWk4XQwTWRO0UO1cctgYJrRFh4aY7Xb2gabT0vFjYRPrN4zz1GgV9IWKrmihNfDhufnafazerUXbzNp+7b1wmuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMBPR04MB11720.eurprd04.prod.outlook.com (2603:10a6:20b:6f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.10; Tue, 9 Sep
 2025 02:50:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 02:50:29 +0000
Date: Tue, 9 Sep 2025 12:01:59 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting syslog
 of MISC protocol
Message-ID: <20250909040159.GC20475@nxa18884-linux.ap.freescale.net>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
 <20250904-sm-misc-api-v1-v4-5-0bf10eaabdf1@nxp.com>
 <20250908-sparkling-owl-of-judgment-f17eeb@sudeepholla>
 <PAXPR04MB845929E7106141E785A32387880CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845929E7106141E785A32387880CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AMBPR04MB11720:EE_
X-MS-Office365-Filtering-Correlation-Id: f8590089-7f84-426c-1781-08ddef4ba2c1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|366016|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e+dn4akuHdOZLlo1+zoUm8zRU5v/2lTVmGiL64edWU82y5Dw41YRLmve+Dtz?=
 =?us-ascii?Q?RQz/Ky5H8mYtM1FyrKyVc91zVHATUU801iI+AkGlKkrDugpKBMtEuxmzBYs8?=
 =?us-ascii?Q?XEzhygPxAkKHfTLI+t5USSKT6MuxkDrmse7jVarQyRL4T5nicSBESvBdmOtR?=
 =?us-ascii?Q?7s4G420zRV+DD12c1hT819O6jR1VLBVWd8ZiBWGMtHIG8kpxe3bosHCcnSo2?=
 =?us-ascii?Q?a3aeBi1Q7ZjQ6jJTL+KuDAifAIZzF479999TNYAwKkk3G5HAmBZx7Avihg6t?=
 =?us-ascii?Q?XwDffWrFYGUatVtLrBvNa4w5GtYkcikDL9qemagmp7qm+x1MpEmIZnaQ25er?=
 =?us-ascii?Q?KIBeSC2MqPh6X6EX/Lnu4gnt9R7HELkglsqJH86Ykcj7H2t3ehiPf1p59sqE?=
 =?us-ascii?Q?PbVmeEynfyn+miEpFgNToc4jGk/afHnTGaOpYCwjtJxiAnIJY+BXkGvwOWix?=
 =?us-ascii?Q?NvPYLKWo7f93zQiUhLtf0VXCQSe5z7kUH8a+eAlhHU60um4v4z1dyLnNM8Ay?=
 =?us-ascii?Q?oHr5/n8wGDrnL6rM08nHIngU83EGsEBWkYLOj+22U9/fTs/LTaKiE0VCosz8?=
 =?us-ascii?Q?fh474vDah9uJZIUbbzjdG/dqVyWpGvE+lkw4r6J3jvsTCM/Ao4gp2vzh+x+o?=
 =?us-ascii?Q?qkY4V+Yvw33FSUoIjIr3piDVwL+RMYSYK82NNIJr9Kg08RmAln11c0G8lJj3?=
 =?us-ascii?Q?/Opue3eoUNGZRDXC2Rx12Z0xUZS7fkIc+S50xFLFrPGDzY6jR94IOYx1Kjku?=
 =?us-ascii?Q?bk8Wd96HEViSW6Bxn2CCT18bOwQsbcSITexElt6zX1FY3pHyPQCtX0jyWUfV?=
 =?us-ascii?Q?0z8w15mqyLp4oYGQsgK/QcImpzkb33NrQTtucaiDW3uV/sY5i9I/RS9YZaWG?=
 =?us-ascii?Q?CH+Cx5Ml0+2g4OprfHmD8ctl+hqjog8qNLxJAHvaZiV+LTF3qArNhUrj2SbS?=
 =?us-ascii?Q?eAMQUpqhTsfOeLAWh7uB+UKbwnQgSB5Md8yksRDj/B2YNfnRLNBNJWcpiMo7?=
 =?us-ascii?Q?eWjsYI9Qyj/vukLHKB33yzDG0scMAH19cmaBW3WjWGNefgbjviP8C0GoJl8J?=
 =?us-ascii?Q?nlGrgDHilqNlsNoQ+7WhvJHz4RJ2cAC8XBVTqbe2CoBw4wRl/Gpd//JTrWzC?=
 =?us-ascii?Q?mtWAaWp1w3SZBoTVKeXwlilErvMpNN7E0YWKbMmHpcutzyMnDMkAuL2k7v+j?=
 =?us-ascii?Q?PAm+yz/kLgthLlu653gC14j5vCESQEDWEhsoXGnypUHa30wfq0lIRThLs6bl?=
 =?us-ascii?Q?a9bBf2oPMFl77N0zYWVOd92ujoXSinYyYQMjVoGaJmC8Dj5tFJ4ZeTCIgsUl?=
 =?us-ascii?Q?YxrGwnepJiCmqPr5k9FpZ38ygh4qSB57BmvSC0IwHgrRKgG/QbuiiNQ8JqId?=
 =?us-ascii?Q?KwwvC7Ow+dC+QrX/LRR0Q1YMVGAXQqbUXqvMNILbtTNeUUsZ4tXq33U98yPh?=
 =?us-ascii?Q?w0hl8DfezokiGDVai72y2On2SAkllcxaSfllZ2EIKqFV3Im8vP+7voeu4abO?=
 =?us-ascii?Q?OPDifh+OPSHGQUk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xoWEe4TU6ssoHXxhtZD4l/i1cZL72RZM6V4VCbQl+fcbxkSMijSZ6v8cfUb1?=
 =?us-ascii?Q?sncf9TEDNUfIAO7OChB5F4GpzYv0tMkviYzxxt+ABImh+5qljkFCfxRaPYQW?=
 =?us-ascii?Q?rbIchzuf/IlRsntmL9OmYYXuCsnzz23FFZvq5pBuYDLCQt3wwFR5smTSPxXV?=
 =?us-ascii?Q?2HimOYAaPdiVf9Wh8WmttmW1CRap9LxotxbN/VoyxlMvmWkSkOxBlFc1vp5L?=
 =?us-ascii?Q?Mwpfey+VgC5IKYHHm8IdidFSkev677Vk6sFzst0bUtimcgyRoIv3SxpA+8Em?=
 =?us-ascii?Q?ZJ1APYWk6jO0+/9aG6EZkTV8trtTIhaMh38MmaTewJwKjOdJys8t4FwhMi5s?=
 =?us-ascii?Q?5aVJzVBEYr5JNJ4aa0oAtb2DE/eKL/uP6jYrJPMWGDK0+VD5ieAV3IQhX1KY?=
 =?us-ascii?Q?/SEedDVvVi3E3DgAZaZvvY0D5E8W/0a2RQxV3Q9xUopZdoRcuthoDMqmXr/+?=
 =?us-ascii?Q?s7K3xLieGkYsLqibvo7zpFzqSbxJV/0psidC9iQ8UZzWxCBCyhnPRzQdtAPx?=
 =?us-ascii?Q?HdzaAZJ8OxXlsE8V36GEa3s39ZCnvJm6RCOKaLexP0DtIhP2IbITIj6a9Hwm?=
 =?us-ascii?Q?p+dOK4EurvG53IDCBVvE3QUgqc4KpRDnHX4/rfpCST6pfNdm3BKP/L4vlt/D?=
 =?us-ascii?Q?3idQezds/yySfCHN8ErT3t1hLHxr92++HLHRpQ0RcJW+oRh6qkRYcQQdjXIa?=
 =?us-ascii?Q?/eJh9bWYbPOdk4hBxMj2UHODWonM5LwmZ2rys6Mbs8LqMzaQ5RQCbxJk8szn?=
 =?us-ascii?Q?YOP9S1M40PjXLGfJ33Q8YuRYx2jADhpY7FbtOR1n6ipWsnQqYwYBkXam5F8K?=
 =?us-ascii?Q?NnasrkPYZUGmfJnNd7r2PmprfqA0e+8A/Ov0vySHXSm3XPeWUxFXLvU6zVzq?=
 =?us-ascii?Q?ntEhJFwO0GcCCoUblpuEtHBHdYqHjyg5O7XOgR327nPszf94QLK2oKBs2jPi?=
 =?us-ascii?Q?9P1NEw+i6PulUsZe6FDyNjxMhCKFp1Yv2yGHS+J+cTRH1Yc1zhhiM0DFYrRq?=
 =?us-ascii?Q?qU+OJz7SREVQQfXoG9k9gO8GaRjqDyMWOqyEvQ6g8zLhBI3rQEV0eXGhq7cb?=
 =?us-ascii?Q?S1cYiJmDL34XLFjSlpMcKLqhIpBiCBgrCgd+q7E17KqMGM+rMlqAHFVsYaNv?=
 =?us-ascii?Q?MYnqXTKA5vv/HG1ZrJb3xehEqy2lvagEQTlDdwQEiKSDef126RCNkKQkxN9X?=
 =?us-ascii?Q?3jE1E+grZYfAcPAUwS54A7jFeyu3EkI/Xud4qprciGLA7LM/CLS1J0QtuMvv?=
 =?us-ascii?Q?w6wL+5zTwLUUxlVOr24RniH/tVPVJduM9cB9HkTB6DYMD7/C4MMRwq+PiE4y?=
 =?us-ascii?Q?NIfwIpuVs7lQ80yINzOmjBa6DnKMsWlTQwE/cHKlCNYKKipBlUZxOkniX7gl?=
 =?us-ascii?Q?MxaMttBsmPhgrwp5vjhvVadWy0NoTAEGYMZ91A+ph1Vkh7r6GsHMS/LREcgu?=
 =?us-ascii?Q?wO+sIqPyiU6k9Czx6Qj78zvLeC+v2wOMLOXiIlf960/41OBgOjnI1qghNvtE?=
 =?us-ascii?Q?kKDVevWRtggXTZs3x6mhOy8yeVpS4jgP34W2lEUqlhfU/8ca/l1CwrFfhWvY?=
 =?us-ascii?Q?0bgeqC9+mcttEhiltMrokJ/wtBOydISrMdXHjEvn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8590089-7f84-426c-1781-08ddef4ba2c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 02:50:28.9961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdM4jcCatj8MVZFacHZHXF0Z3N/gPaYiWfCLQwDwWcDnoIdSOQU7uSEu4+Ytq7XYd32pH+EAg5HMf4U+u/852A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11720

Hi Sudeep,

On Mon, Sep 08, 2025 at 11:51:02AM +0000, Peng Fan wrote:
>Hi Sudeep,
>
>> Subject: Re: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting
>> syslog of MISC protocol
>[...]
>> > +};
>> > +
>> 
>> Much better now. But I am still thinking if this must go to the
>> document to make sure it remains ABI and firmware can't reorder the
>> as we might have no way to deal with that. That's the reason I was
>> asking for raw dump so that you need not put all these details in the
>> spec/document.
>
>Let me check with firmware owner whether they would include this
>into i.MX SM spec or not. 
>If no, raw dump would be the choice.

I checked with firmware owner, this should be using raw dump.
The layout would be changed for new platforms.

Since this is raw dump, I think debugfs might be preferred.

I will post out the patch for 5 an 6 later this week.

Thanks,
Peng

>
>Thanks,
>Peng
>

