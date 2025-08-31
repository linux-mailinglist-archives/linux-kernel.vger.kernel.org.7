Return-Path: <linux-kernel+bounces-793252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC141B3D139
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DA91891AF7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 07:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270FE1DDC07;
	Sun, 31 Aug 2025 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iw1ze0Ev"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BF1CAA4;
	Sun, 31 Aug 2025 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756624171; cv=fail; b=mtXs6+jZ3CbJa7USkjS5f2emgykfgFKXrHO+uWHsZ/aXcQDMgwuExiTapzcLasiQ1lk4qJCpBMMRmiRVAxFx/zE1Dw95lWzXhncljTYdpA2GHB/XXBwrsQ9Jjp8NU2+bHWdrRdl2/XMkrBlbZ6ctSf6XbyjULYjNXDT0RFhNlzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756624171; c=relaxed/simple;
	bh=cuWf0RmTjDMft1dnpqx6g9FUEhsTQFKUACALbkAZLnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WOaD+jSokg+qExwPsD0xB9j5OLqiIA2ejxTBRVqL7esA3A/QyzM/GoYNSjj4gwsarTWcRuJwCbvvROIAciUNPONfWjMCC6sK/brrfmk1MeSEsn9/T5yBGqhvwGOCL2pTqz7CWebNY5H2W8k6bUc9bowMmfMx20Mx1umetLkVYVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iw1ze0Ev; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNMaz6W4jp1mgvsd8gXk9lR9FMS5TQgPq8zel56bkQmv4ByGE/ezMbmAAZsX/QXpuLq11KPVwAl1swQeh4U867fwBicfLhUYOM3+No8nGC9u3ytSwm/HMVqodp4f50v/ZaPeBXnh4z+8KsvdKdrQdHgm0xFKbeZWkpQX6nCkeq4pa93Ulh+maNr2kpQ4bleB3Pva5mnoVpXuLkbvb9u2KnVBIfbNkCEvRNqNOCvvNTbzReVhjRzn6611n7gsJtBOscXsuoLC1HyjMZd6XRsUtiuT4lB5j3ppMRQy5ZihwDz7lyBlwqQy50+aE+0AntAAWWhB/XcQT4onxS4UNCOT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgXJAgQWcy+d+Fg1f6HzQ0xPk56wc+MVHK+bA2YVZ4E=;
 b=i2H+vMBUmHgUyTsyf6Degtr9sNNd+5k8Dokw1BVp/j/xd4nY1dm7Ia9/VSY2Ax4FoSKYgDuiTMdXNvE8icYa0xVMreJvoNcnGlZ7IB1GJxl6n/Ei4YkAh/RFC/1EKuL29KR9uNfrxGM2m/8XSY8tbf6yGZqmMUZEmo5g73pwueWGNbKKe5Dxsfpv7/usYj9CnutC8JGoezvhydZAwwrQjYOpLIUhk4hxqibpHtg75i7M/Js1uF8n64+Yuw1zF5rR8NYAkf2P+afboJrcXlpqhZAGY8YQTw9E2nkotZz68OeDBQXnAXVjcMNX482/CpUGxjrsWeo+yVywC+3o2iKSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgXJAgQWcy+d+Fg1f6HzQ0xPk56wc+MVHK+bA2YVZ4E=;
 b=iw1ze0Ev9/AMgWXm/rV0+TJj7OKCwA9xw4BTEEIT/iqSzodx/BwDtpK9PqwSzr9oSNrzcD/3B7SJk+JG/RrMvVgzBBWFLiMiuCCV7pQbiQY2KXoAO3Vb1vrxkfTh59k2dYcZTSzE1YVoXJBiMdCYaHVk+7Q3RqyeaC2SsI73yoQX1+aUUyjPDrfZ8xxxJwmY9QBW7EXThphR2Ph1WtmKwI2ujbcss/cRjpQXI5b0rinhz5YrDD56U4UBa3TDTtx/+pVBrZHw35pJcHCaYBsy8lt5LAPG6kGqtwuXu6eV3552qgCT35qiNBUXK4bF+hwfopfIlXdTwMiH7B+kEnlemw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV4PR04MB11355.eurprd04.prod.outlook.com (2603:10a6:150:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Sun, 31 Aug
 2025 07:09:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.011; Sun, 31 Aug 2025
 07:09:24 +0000
Date: Sun, 31 Aug 2025 16:20:41 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, arm-scmi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] firmware: arm_scmi: imx: Support discovering
 buildinfo of MISC protocol
Message-ID: <20250831082041.GB17728@nxa18884-linux.ap.freescale.net>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
 <20250827-sm-misc-api-v1-v3-2-82c982c1815a@nxp.com>
 <20250829-satisfied-carp-from-camelot-bddbfa@sudeepholla>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-satisfied-carp-from-camelot-bddbfa@sudeepholla>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV4PR04MB11355:EE_
X-MS-Office365-Filtering-Correlation-Id: c70c7b76-e8f6-4308-6d94-08dde85d50b6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oNUaiMC0F3ZogUEVZbbQ6ttuhVZtn6HzB33/t8KL2SCwxxlO/BWdl2V1Z64L?=
 =?us-ascii?Q?QsA/feAgBcU1U0GZ83XXii+eX/cox4f6JPOz4pLRmXUBadH2PT7bmtJo4K0z?=
 =?us-ascii?Q?gAj4+eXlo5vXzNc/NEAybGT6DUXqkdWdiV6U5TfNPtMgKtlW5bra/BXpwJK0?=
 =?us-ascii?Q?5EUIKc+bv+d589CvOPRC0GBGkJSEnAooAa+A4QNV6fAk0M4ffrdsAgmwBqad?=
 =?us-ascii?Q?gqDjFg0TwpUEOkSAJRdz6XFzrk8WlLaDiWRPAu+ngI9DfMAvK7Pot6cMJVV9?=
 =?us-ascii?Q?46b2owWy4uam8p5ndq0GH45bHDNXpXPtw27xuPG2F76TVAlmox+FAmE9gAO0?=
 =?us-ascii?Q?Ia58X/9fyQNthkG26j3QRV5aKEKcZjnJM7Ga/nBF7YDgHrCr/3OHJpRoMQvf?=
 =?us-ascii?Q?SnSmcyzzyCKUFwLCFPd2/O/E7NV2ndjCEnDJzoaeb1i143mp/7xCt7nzuKQ+?=
 =?us-ascii?Q?JXQUAxUuc5NvX3F9ANLI3/tXQLozaYBLTYlvEBk2DKzACxnkV1EL1AXJdcq2?=
 =?us-ascii?Q?MtTjrSL71D0wAI+al0X0bGHc/mAu1XoNzX7OMciGrPnSNyRSv/XdoJqQlY+q?=
 =?us-ascii?Q?TT90XGeJiafCyFnHG2AVIfE33w/8HMVifQr3Jd3ya/k/2y55Y3iBIrcT+rRv?=
 =?us-ascii?Q?TZ/YzINcRMvMY9H47uMZjod9aHBwajjqAEA+uBLVtu6cTvbmSp3mgq3pJQZo?=
 =?us-ascii?Q?dQeHXfD6j7CSv1HpiTJycLtoIFHatnrju80TqUCLB1OdYZusAEz3CWF3XyzV?=
 =?us-ascii?Q?o2nASXdCAjQcfA2s86HXmbS2jOPIeWv67rcrYnSytNkIsmYizOXFbQ+6rKs5?=
 =?us-ascii?Q?ytqyPr8yB/UTqTpdlx0RchbM+aiw3sYnfoPt8LKP0nHO78uhL5hdA24/1+KT?=
 =?us-ascii?Q?PGD2+aRwLPiki58NM9yMUBbSAuyrLv9ItRYnYgTDnCM6i5rmyAUEtpIQAqY3?=
 =?us-ascii?Q?o/GtOBRenrVPK/4ObQX8fAUiEvloDj99wIkCqBELzBmISaToGuHUwGRfDtdl?=
 =?us-ascii?Q?9CoryIEkmtE2zqwyGWLB/LQ3vDHPKFcHYs5N6PERyH3EqcjZQ00mJluVW6g/?=
 =?us-ascii?Q?FuTSW99qAwb8ftyRFpO/xRSGUflSvH2ogDs8z8emQ+C8IcueaLefUrbbSF1Y?=
 =?us-ascii?Q?fjjGX7LCdQNNbJwSRmh25Iy8RxkPsZfnMCoWD5k7wk76PTSK/Wh0r5345B9x?=
 =?us-ascii?Q?UzytyF3zkM3gfv9Xxx9PBg6RorFC5+j9AdnhMZS3722aQVY0Do3TfcydZhiC?=
 =?us-ascii?Q?zIZyIhNhe2/JtKuJg0pbeCTxXPbVgsLSFGEVMOCjVAXX+VVIBfTYpNF9prv3?=
 =?us-ascii?Q?/UZicpkpnPFynCVYeQtKXnDi/5MXXFrhIG462/ikFpLpazAKlPWKuTQNmwRP?=
 =?us-ascii?Q?StXx8OvbnkXogzq4GqRAZbSBvJtTBcQY3dC9gfycOIv6oXSU+OyDh7vh1O9U?=
 =?us-ascii?Q?mOa3+Xd3BuCG22pKAO5lDLO35awj9FkBbGhOvlIOp5vpaeUOX0Wy6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eXWgmFbn04N5K0s/jwAkeledpsm0+RUUxglrwPW3m+YnAC+mo1NmHQKylC9i?=
 =?us-ascii?Q?54E//uSnyxupX9GYZvVNGt3U+z42+HDM0Lwb60Mpe5S4zb09+886EcmBBetF?=
 =?us-ascii?Q?HZ11P+giOMShB8iEPs2YHMEFEZU/6JJZif/rb+QLqMbrEsvs6xKuR2EFUYlT?=
 =?us-ascii?Q?Xua2Nhy4OzNhQ1e27rbkUO7FPZttLddcdOSXvdJZh48PfSGl9WY9N0Z5TQrk?=
 =?us-ascii?Q?RZ/tWEMqJu4+4hsMGuXw5zmnRzIdmbawz4t0sb2UgOCjw0tWw05GwUxTNFhT?=
 =?us-ascii?Q?vrKD8ldPvfdEz1s/ao4lCud87Zf12ZKJ00piJrnsEbx+2W6KM/dJZhJfFjPs?=
 =?us-ascii?Q?3FfQns9aP5HmmVp+ug4xViZ9qoFfR/0KbnBc2VuDxxH1OMwq/ATB+mjT8OGz?=
 =?us-ascii?Q?8CLp3X92GWaHSbjtq6sXkWG/U0SAFOG1N1mBAuNtoL/LHdcJ+NH9dup2R9mS?=
 =?us-ascii?Q?7uqZ9n66J5WV/ub4bfeQp1aDHP0vtES/54QrofvgJmQ9bLxj7HbZsSitLOAA?=
 =?us-ascii?Q?uAD64w5E2YmsfldFXe6j9l75Aj1F7DeA6RXcc8UqlcKryLmGeErG20oBZiDG?=
 =?us-ascii?Q?KPR8ia+fzPIBC9xLJ8+bkdoBlBRS5cXhLWwti7wTPcRwHH3j6EOaIjfdGFKF?=
 =?us-ascii?Q?OcKSFY8YQ9QaNY3mjnyuH4Fn38MoZU23xzr2cIZxVC9cX5BoS3Peg7DIxABK?=
 =?us-ascii?Q?//DHDlXN3Po0jMPvuPYWeaLaB6dpJC9Bz0I7QKmD3u/Vx77RVjO3qz0ARQe/?=
 =?us-ascii?Q?WxSAraiNhgrgVxyA8Q46KpTlinSLOKy4RaYe1zUCQEgYxCaSG3HVNHZmweXt?=
 =?us-ascii?Q?UKirWaP2BlkwKZqRr7u8POBBtPQEG+zmAUJasSyIsBrKrQ5NSsF93grjHKNT?=
 =?us-ascii?Q?QrrNQdsiX76wx51oy2siY2HtyMs74gxxOEDX+btsMirul3V21IT/8T/mbwY0?=
 =?us-ascii?Q?JmEUn9Z/Px2OIFDjreRQoJ0/YLLPf9zWSnQE88qwsxoJmldO1aGDII4Rmmbp?=
 =?us-ascii?Q?8JOS89ACeJeGfgubX15pR2CUrsH3S/xJy1nlGbtw6S9GpXijGZm4vN/mkUng?=
 =?us-ascii?Q?bmjbE55SiVohALNzhiKGjZ+yVDVGgCkidx11HdLjXHUl8XHryXTiayuNwsc9?=
 =?us-ascii?Q?+Odfa21ZIxZmMrxIWRVUvOnQOGaFjFY9EeUdQhCk2c1/TSQrGcbweGLqSONX?=
 =?us-ascii?Q?qxnFOLtqDNhyJ9SfUyyJ1TqZwz+NtnBh79EDHJtuC2rCT60HgEsxAYiolUag?=
 =?us-ascii?Q?/hlZ27VpMTpMjlw8fMcBfGQpKiIwZOZis/e9SXXQZt3g4bofF9RRvOjO3Lxx?=
 =?us-ascii?Q?u8HGbzp9O7859rA3i/BP9Gx44zuL5HkPONE7hgnVKUpg1/Fk3ikFok1pXCSW?=
 =?us-ascii?Q?+92YVepv4Pl7BwGIt3vAxB+tPNEgD68ynyBKB6uYaionkdSYdWm6Kh53CqPZ?=
 =?us-ascii?Q?zyDHIDYdZfoBS4M65u9koDt2q6/GU1hJ8C/njXy8SV4sViFpdGUutmnNd14r?=
 =?us-ascii?Q?JOZoAWKY9j9aCNcFtGqH83akPtoxhZd52Z7omNFmZWmtsfOkbmFF3ZMSjk2h?=
 =?us-ascii?Q?oGgP1GF0B50/P9emaLL/oeHuRch0j/xNjM1yHsP0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70c7b76-e8f6-4308-6d94-08dde85d50b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 07:09:24.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48BKOgE7hpAi6sW//FSk3f3aQrnTpGIiKvoSNa5bwoqUWs+OHZUudSF6kg+gXOq83KRAwYEcfpeTJh7p7YQeAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11355

On Fri, Aug 29, 2025 at 11:48:56AM +0100, Sudeep Holla wrote:
>On Wed, Aug 27, 2025 at 12:59:14PM +0800, Peng Fan wrote:
>> MISC protocol supports discovering the System Manager(SM) build
>> information including build commit, build time and etc. Retrieve the
>> information from SM.
>> 
>> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 41 ++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>> 
>> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> index a8915d3b4df518719d56bfff38922625ad9b70f6..464afeae8267d8c1eca4c4d5e008eca6d741c6ff 100644
>> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> @@ -25,6 +25,7 @@
>>  enum scmi_imx_misc_protocol_cmd {
>>  	SCMI_IMX_MISC_CTRL_SET	= 0x3,
>>  	SCMI_IMX_MISC_CTRL_GET	= 0x4,
>> +	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
>>  	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
>>  };
>>  
>> @@ -65,6 +66,15 @@ struct scmi_imx_misc_ctrl_get_out {
>>  	__le32 val[];
>>  };
>>  
>> +struct scmi_imx_misc_buildinfo_out {
>> +	__le32 buildnum;
>> +	__le32 buildcommit;
>> +#define MISC_MAX_BUILDDATE	16
>> +	u8 builddate[MISC_MAX_BUILDDATE];
>> +#define MISC_MAX_BUILDTIME	16
>> +	u8 buildtime[MISC_MAX_BUILDTIME];
>> +};
>> +
>>  static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
>>  					struct scmi_imx_misc_info *mi)
>>  {
>> @@ -272,6 +282,33 @@ static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
>>  	return ret;
>>  }
>>  
>> +static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *ph)
>> +{
>> +	char date[MISC_MAX_BUILDDATE], time[MISC_MAX_BUILDTIME];
>> +	struct scmi_imx_misc_buildinfo_out *out;
>> +	struct scmi_xfer *t;
>> +	int ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_DISCOVER_BUILDINFO, 0,
>> +				      sizeof(*out), &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	if (!ret) {
>> +		out = t->rx.buf;
>> +		strscpy(date, out->builddate, MISC_MAX_BUILDDATE);
>> +		strscpy(time, out->buildtime, MISC_MAX_BUILDTIME);
>> +		dev_info(ph->dev, "SM Version\t= Build %u, Commit %08x %s %s\n",
>> +			le32_to_cpu(out->buildnum), le32_to_cpu(out->buildcommit),
>> +			date, time);
>> +	}
>> +
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>>  static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
>>  	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
>>  	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
>> @@ -299,6 +336,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
>>  	if (ret)
>>  		return ret;
>>  
>> +	ret = scmi_imx_misc_discover_build_info(ph);
>
>To align with other naming,
>
>s/scmi_imx_misc_discover_build_info/scmi_imx_misc_build_info_discover/

Fix in V4.

>
>> +		return ret;
>
>The document in 1/6 didn't state this as mandatory. IMO, it is not
>fair to return error if the return is NOT_SUPPORTED.

Indeed. I will use below:
        ret = scmi_imx_misc_build_info_discover(ph);
        if (ret)
                dev_err("Failed to get build info: %d\n", ret);

Thanks,
Peng

>
>-- 
>Regards,
>Sudeep

