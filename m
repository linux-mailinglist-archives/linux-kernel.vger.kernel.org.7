Return-Path: <linux-kernel+bounces-793254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E205B3D13B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB736441897
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 07:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADAF226CF1;
	Sun, 31 Aug 2025 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e/PwZxMA"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9247322425E;
	Sun, 31 Aug 2025 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756624430; cv=fail; b=LQxJ84q6f6iUGU8FyxV1Q7ZsgchTFSX/IcS/eSpmk8w6SyGRKcxKCdau67o2zishpaim7w3khkZSCH1ayrO2M1linCiaAG4Us0SsrHGPN+x74eSCYSnkfjy2fYHsT+iTQ1u72+TZrf9NEpHDWNb+gskZezutGvTkJXYnE+Eifp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756624430; c=relaxed/simple;
	bh=lfLY4l4cQN6RhyK/1KvTz/l2zx8ev2w4eGky//Wc600=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SZ/7CjyHYtuwY1KywHGrG3CZUJrgg5j3hI7yJjeiM8PF9zT2gzLzMmBEID3I/CS05S6exZlczYoGXeNFR6B2+U8mxP8JYe33sxU8Epu5b+Z4vQo4KP5IgXXFn7Nnm4SmSp3Qa2VB0+i7hZqh70gqzQAC2olZRzq7qNLDO3Uv/yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=e/PwZxMA; arc=fail smtp.client-ip=52.101.84.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHX/YYFRwxO1oo6G1iuacafq4FDYQeXR49t8WCWxxCg2pTafRCEvoQPodwzYsjrVOD5ENzCwDSM6gujixFJ6pj+9yinh5olskLMUFQETTo2rQTYnAG0vLLfnXkoURDMjPfquIb00r9bB9tPdRu1/RgFEF0sVAO6+aaW2v8XhUi23TcgJuXm/YZyicKhhwBHhtstjN1gLa9E4Cpo42HhtSD4kvYgIgVbh8tzb/y4cpzQtWlSZzP0kvFJAkNBOBNsL8mf1lAoz1VNzam9L4BErhpy3r6HDRd3vcL1x4TABcjkL5Wj7pXjhvhS9hPjqoQDILzJKVsETXaucPWhMCWgayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnF4gPYnXJ20y863BGhqbGOfCBTGUVud3v6DIarfLXk=;
 b=lOHg4oouPWIQyIjKGeT9GTvEFaCG0Fr9ylDDsiCh4Yfbx5UO3U4EQhjE+4u90ReCQd80yRJtUV3ZjD95A1q34vcWSvTWKAZTLDnHu66pcXmy7lt3gt1C9u8ZmMbnWeqAcY8+yhwW4/sISYCGOKVyiWoz0bfcqytSOH+4rUIoIf7wRnm8b2Mf7KylPHzaTKSZGkU3BFGPfEydsxJXEEoX5HLAvJTkOe48HjgFJbPfkiDM5JhUwMwYydtLqfknr30FJ5zsMp3+PlIOqG/JvocZphK0jT0lvu+u41s8W97TrwWw/B3QNMm9gI6cvilkwCymtjWzKd3s7hWKV3fkjqoZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnF4gPYnXJ20y863BGhqbGOfCBTGUVud3v6DIarfLXk=;
 b=e/PwZxMA33haCcQ6fNaAINti7qkblKoA8p6jdtEg4akAN0yfJeS7upQkKKD2raIkfxWFS8ai/J3rr+5EJF6E4YKF5XWDRCPwna9N5UK8dbx37ItS0Ub91v5l6og2lx6eGtAe7hBPwtqQ3RV2DMnXD2oCgLkJKaB2uYBxw7RMveBe0QjSgG/jzB2pluqOTc+TnnAeYKTlRRIsnf0z9DDzghZrLkYoWBOpHsjmPewY+hgzpKSJ/y8tNRke2VOiv2+S9N40PJUWr+vbG9lZyACwmoLU6XUHg4k7ArkwcupxFOhvdhUTpzmmkeVpNrIgJ5guWXYqxyf/vyshmljSEQQ9Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Sun, 31 Aug
 2025 07:13:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.011; Sun, 31 Aug 2025
 07:13:45 +0000
Date: Sun, 31 Aug 2025 16:25:03 +0800
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
Subject: Re: [PATCH v3 3/6] firmware: arm_scmi: imx: Support getting cfg info
 of MISC protocol
Message-ID: <20250831082503.GD17728@nxa18884-linux.ap.freescale.net>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
 <20250827-sm-misc-api-v1-v3-3-82c982c1815a@nxp.com>
 <20250829-sophisticated-lemon-porcupine-8dffa4@sudeepholla>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-sophisticated-lemon-porcupine-8dffa4@sudeepholla>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: c5fabc67-dacf-47da-06dd-08dde85dec96
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VeY8baRz3x4PxpqgysyyGp9sJuGL5i7hXAo3To7a66C+VbOkLCdKqJKx7Bdc?=
 =?us-ascii?Q?9yLUslZkQAgHvwm1xhDzKwmVH1OW+MKd1efsnOtlaxLmJH20bwWzp5uMn9GF?=
 =?us-ascii?Q?gjjB6G9g6Ae4FdPqUMbtaFxaGPIKtv5zaBPaHRjcHmDHpkpG/rfjBVlV5X1Z?=
 =?us-ascii?Q?2Ip+NME72UhJWK8d7E9spOipRCOZuFP0YmlK8XihTufMGXm9X7EVmWuGJjVG?=
 =?us-ascii?Q?pF08mG7bTKrvNPLXiU9xdk55D//mouoR4Jzj1Ija/j5V1FYdvD6pqo52JkEG?=
 =?us-ascii?Q?YQeyHSVzMoU7pK52s07VnuHVSdVe7rpcHPTrKHDSQWKHlmlU3MiG87fWX+4F?=
 =?us-ascii?Q?hnW0rM/sZyBy4BWb6E2cWg28e9ow/aXrx5pEL/vs/ZtLmMp0Z90aeY+x2RwV?=
 =?us-ascii?Q?2ju32+h3YZgM7mG4fL0sulBxJC7Z4fqqsAriSh+Tck4oygVhyCNVHga3LhTS?=
 =?us-ascii?Q?sji+Vd2iXL2r0HrFdU8XzlxJPLZ0404cT0LvapehMdfGD3taohot4y256YJr?=
 =?us-ascii?Q?7ycUgcGITWwyLen1rWLejKDK9YnqmdXO26XDePWuLTEegMRXFA+u3HbGRfIc?=
 =?us-ascii?Q?eUUb+lwJNSsuCjZRjQmRqmzbA8BTL78h91aubGEK1Lq0fg4w640hyaM7M7Wq?=
 =?us-ascii?Q?aEocIQ2kf30ZsDeJmd06uKanWQYukwRhZwWKM/riGdOMt6KP/HDS5l5zRbW3?=
 =?us-ascii?Q?LGx0tfGO2WX0NX37hh2y8OLpZfh4V4HKyiuHn5KBewtGVU4mKwPozA4+JHp4?=
 =?us-ascii?Q?91Bbmdy750kDpbapw+8cAdEy8APWJ+rThtb5Wg7lGLXN62NJ/y6WQ8BH7ulX?=
 =?us-ascii?Q?BLqWoqVkTx6NxxfglL3rtj93UAVPTAEQvS6QEK+NlXDuhWYZnjxW+BLKymsK?=
 =?us-ascii?Q?LtVwRvVFVa9k8qSKaL8VWmyLqUJJror5DUAu8MJp+o9aZniWjcs/sDQp34oh?=
 =?us-ascii?Q?CzCumPkBky69TeMw04fFiDumKmEnko0/sGtxnsASAoRFRqa4WdjofCYj47CC?=
 =?us-ascii?Q?PPDX5RDX96ZqvdGQdC27svVIodFCwgbgDT2BRgQmX9Eje6qpDoqYjvBdYzht?=
 =?us-ascii?Q?wUXhwnyMSm+f2wuEi0eAOZv2zD7kjhspge1PR3FydH1UtrMJFh+SlG7uZunB?=
 =?us-ascii?Q?Axfn+IJffqKSpQ2RPczkiDxQNQKIATqZ2ZXb7hAe8A9FDnXrU41hdy/vC+R3?=
 =?us-ascii?Q?1jKUIxKpEJ8aTUYLHV2uFb0TAOO1+avRXF48lcVSYdOChlzxpMc4iTg65bwm?=
 =?us-ascii?Q?g9QoXu5E37aNuR33yTzNTyWM3XU0OQwM8rFPl8StFKart367iTqZaRn9SfOI?=
 =?us-ascii?Q?3Z8Z1SMeJBD4jmZXd8cBQ3HNC/Zw5pX5FPIDIAaa4ZqWcwkqNdRCAwdslNxv?=
 =?us-ascii?Q?oaoIS7/JZZwALJ+3jnXCJhukTtFVvB+NX+MEL54aZ+6in19WTdH68ej4vodn?=
 =?us-ascii?Q?KPsSqan0yIs5sYcuDJXSqG+LaN6y1TrCWEHnpTxVxubijJPvCgszLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?axjILlFf29a/HZRah2OnP+5TgzNvy8aXBs51TtlPo52hhB1izGjRSWGOyhqR?=
 =?us-ascii?Q?ObiQRcK15krav7Z+qr7nauBNluMYY6dpiDqUChPAHD7db0iIXxe7brdYN25G?=
 =?us-ascii?Q?K5SgL71k2Zal4limT6D63huNVZSlJI9Jq3svpsN3NLa7eSBM7DAFSZsyTsH/?=
 =?us-ascii?Q?JF9rcbxL941Y8rBKaCGrCRjt0CExH7AN1eLchCN+Yl8lqDTH6TndwmCsEhsd?=
 =?us-ascii?Q?prg+nJBGb1F1H1H7gct0d3O5Tah5uLfVkCQF3oKfc01DC+C0FMaOIDrhcVwE?=
 =?us-ascii?Q?Vc2+gfu01H+rmKbKcFRyjRDcyvDkWBrTbxqvPyoEsj7Sg5s8RelavT6UQBZS?=
 =?us-ascii?Q?9ZUn7up6lefTH0MoCy/E1apmsjB3XiheA1SB/ZR9mG4hDaTBTJh0qLNNQKzq?=
 =?us-ascii?Q?l+2D5ogMFBKvDSspsypmdBY2Uf3GgAdxL3tZt8Tu/UPM2nXNH1zqZqq3XXaz?=
 =?us-ascii?Q?qUgwDa4FEEoeFhyO31xPQ452KYmdopq882jBNXIGXtSLBgnYcCExIGTQLeu6?=
 =?us-ascii?Q?5NbdEzVtlCZwt2gpmb+8NbSkHoTufc49oYZSQOiQCVQVDPSN0AvL1ATnb+4v?=
 =?us-ascii?Q?uqomH8V0vQ8RfUM8fJHd17Opf+Uu9UErOcw8tzHBOe/QnzD6Ev3+BdZFsxxt?=
 =?us-ascii?Q?LwTP8/FzGeN4rIUsMIOWKNfDBnkVecLyLm7lUP747d+uTVUuAgqHvobJaX/p?=
 =?us-ascii?Q?EjSSbo0sxYM4nZGl0Y9WJbkx9tCBSJ6Qv4Iwep3Xwe3If3k+ApqtGpP4P+LM?=
 =?us-ascii?Q?lETwj4GzFFhoniznXFl2TMrQqyOnmDaXQ6aaOP7XV2oaUvvRcVTgx8jMSRIX?=
 =?us-ascii?Q?YHH9xvU5OcBWLIQfB9KQRkBsgaR/yOkbyJHaxM5voMNu9o/1PrJNVUOkgTur?=
 =?us-ascii?Q?6pjWIGoY3/MPcLtKICFIObrspw2NWeWCP1paivB/cl9T4IYYC3AIN6YL0OkJ?=
 =?us-ascii?Q?MlZ/WLAMLXgji+AeQs8U9CD1E4MY0VlbZJxDuxSCP0qM+2hk6aFqRnoVX6VK?=
 =?us-ascii?Q?Cvj3vB0OrcSAWWgGDzWDvzCLGNinbXiWYPwGfdRjYRzUXzk44Zc3+QUtAgyU?=
 =?us-ascii?Q?vTkGd1NuzEOKiAadektHb0hDqC3uXvw2Kj2p9Cf+hny0drqDM85UeBS4AKny?=
 =?us-ascii?Q?Z1J/PH/lHC6CAsoj0EMOFqe8DOwJ0fKMlDrhEUIzB3KktUx9/9DOMN2D4IzE?=
 =?us-ascii?Q?mO7ksSH5/Glp5fyWPEfw0mGPtIIRjL3wvrGBiIjR5Mk/ztMP0I8C4493dbm9?=
 =?us-ascii?Q?26enD8AzkaxYjI37+dIzgMBvtGZuhVfFhddiwAeEO1UItYZmpHP0vsdPDG5K?=
 =?us-ascii?Q?XUW/oA0rba4e7ppdQ2ul/bAr1CAne7Xi6ztWC7XdKmDwDeyozReMYUoCLUDy?=
 =?us-ascii?Q?yfLXnC+MPJdC+UbDc4XBP4X67wcrKr1VSNMzGiItoZUinkj6fp5FMI/LN1XI?=
 =?us-ascii?Q?yL+0eSSolzxwOaucXngvTFWllAt9OKNv2+jtxL38wkI0htDU7rZy98/XOGQO?=
 =?us-ascii?Q?/mEs/ShdljtgNRiFBpP0zAAfHmUxtY0PKf7/SZvAWpr5UjjQW8ehc0KqL/hb?=
 =?us-ascii?Q?4HZMnZUvOYfziqkpw8kNQ7xm/ZH3uSy9cexQ/Wlt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fabc67-dacf-47da-06dd-08dde85dec96
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 07:13:45.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3F6CHjZFh16xYDM0mikQRCQ+/o7hrue56MTLiyyEBwxWARxjH8Rt/EWZ9/IqZMNCiXhL1i/ee1isQtTzsRBtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

On Fri, Aug 29, 2025 at 11:56:15AM +0100, Sudeep Holla wrote:
>On Wed, Aug 27, 2025 at 12:59:15PM +0800, Peng Fan wrote:
>> MISC protocol supports getting the System Manager(SM) mode selection
>> and configuration name. Retrieve the information from SM.
>> 
>> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 35 ++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>> 
>> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> index 464afeae8267d8c1eca4c4d5e008eca6d741c6ff..220b9369fb537306f9e1a105930ad4d65e6b10aa 100644
>> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> @@ -26,6 +26,7 @@ enum scmi_imx_misc_protocol_cmd {
>>  	SCMI_IMX_MISC_CTRL_SET	= 0x3,
>>  	SCMI_IMX_MISC_CTRL_GET	= 0x4,
>>  	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
>> +	SCMI_IMX_MISC_CFG_INFO = 0xC,
>
>1. Order it by command number
>2. Be consistent with the document, MISC_CFG_INFO_GET is used there.

Fix in V4.

>
>>  	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
>>  };
>>  
>> @@ -75,6 +76,12 @@ struct scmi_imx_misc_buildinfo_out {
>>  	u8 buildtime[MISC_MAX_BUILDTIME];
>>  };
>>  
>> +struct scmi_imx_misc_cfg_info_out {
>> +	__le32 msel;
>> +#define MISC_MAX_CFGNAME	16
>> +	u8 cfgname[MISC_MAX_CFGNAME];
>> +};
>> +
>>  static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
>>  					struct scmi_imx_misc_info *mi)
>>  {
>> @@ -309,6 +316,30 @@ static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *
>>  	return ret;
>>  }
>>  
>> +static int scmi_imx_misc_cfg_info(const struct scmi_protocol_handle *ph)
>> +{
>> +	struct scmi_imx_misc_cfg_info_out *out;
>> +	char name[MISC_MAX_CFGNAME];
>> +	struct scmi_xfer *t;
>> +	int ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CFG_INFO, 0, sizeof(*out), &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	if (!ret) {
>> +		out = t->rx.buf;
>> +		strscpy(name, out->cfgname, MISC_MAX_CFGNAME);
>> +		dev_info(ph->dev, "SM Config\t= %s, mSel = %u\n",
>> +			 name, le32_to_cpu(out->msel));
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
>> @@ -340,6 +371,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
>>  	if (ret)
>>  		return ret;
>>  
>> +	ret = scmi_imx_misc_cfg_info(ph);
>
>s/scmi_imx_misc_cfg_info/scmi_imx_misc_cfg_info_get/

Fix in V4.

>
>> +	if (ret)
>
>Again the document hasn't mark it as mandatory, so handle NOT_SUPPORTED
>gracefully.

Yeah,
"if (ret && ret != -EOPNOTSUPP)
	return ret;
"

Thanks,
Peng

>
>-- 
>Regards,
>Sudeep

