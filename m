Return-Path: <linux-kernel+bounces-739268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B168BB0C420
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB31D167C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4212D3EC7;
	Mon, 21 Jul 2025 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SfGG1BWk"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDC28D85C;
	Mon, 21 Jul 2025 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100984; cv=fail; b=KxASrWeAu0n/lv5HHzcdUwDvqxNR0vG8XQvVYG25RLA7Wxdj1ZzGk3q/NK3wAf8YKEWBuLb01tToNDXfe3syrt99a5H32784sONxuZ+UP4ifjYLSdn/969KwT47mh6NxARkp8s9FjtSU3OxZP38mj8W+0jd3wlTupfZXVFojCBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100984; c=relaxed/simple;
	bh=YvzGR4SE4CNQlyc0TNGPhCu5ywN1bBYaiTIRkDQJOUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sXtnMFC5uMtOhNrETny1pt2S3uK3xivxqxDOcP8xtfEj8LmXRzcYbp4CsCDK+nJ048ZSvaom4YwVFqoNxiCP6dh7tVU7SsW1+7Q+eTp34UMTF0kE5IiEyCwYFTwVzMJhCmLhAUshL74zYrWSG41b+/khnr12VloGD6l0mtlMNXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SfGG1BWk; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyEiUQnCoTeycl7+5hTQY/XGB0Zh+alAZjjq3txcsEP1ub0V51XJLNNG1Fk5xCwpRCq4omWdSQCs45pDuv9hlPtEWc2WobnODMPKAR1IcXa1ZHD4nPL3tFH5t9rsdDNk2JHu1E1qEUSEVQXmpUuwI1zAjKEkNK5OO5kRYO2jVexF0bx7U9KSrYYcj4OOlTYh8cpNDTJ/PUEtQ7F9F6LREDsEZE+KQ9EG9e2P3o1QFIVGn29zS2zWUDUlVDzFX/dNLajo8I2f0XI1E+0Hd2QukrSJewv5xk6qL1rnnyVxzAAX5O9NNe9S53z2MENPfhMRl9FskkRP3NsZqvLPzC4W/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pgEWbB8JXzm3jAdnYbI22GAokt6exebYRifayk/zjU=;
 b=cWL83fpIQQfZFtFqH6lAWyqlhv/TK+X7doGXIMoLtt0Y9e93rA+QQlmJqv3kck+IXulgngfGLid+8990SrnzkCKSAFh1ki5qYerBHjrFz69CWAYrnzxl1Kur6TcM5AOSsbU/lUzwyvEBH6zcxHzwt+5Gvt1kkTdfazkuzHz99LVAJoVkhpUKdPozDHnKQw5oJtA2plQI5fNbYbkxrX2wL+DDVkJEXFVqwNYE+7C6Y3cdnZ0r/sJW/n5ri+P9VUyV+D9Qzrus+uCFKqPuRzyBOAZCEWJXmAEiv7BcnTm+9tRTR91LHOrERwFWhKajk7ICiuD5jBSpw/6ucAPLatr//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pgEWbB8JXzm3jAdnYbI22GAokt6exebYRifayk/zjU=;
 b=SfGG1BWkLCgxFVlui8UiQ9Xz5E/j2LQwHolbMOzIWpf/UZ5inwkrLoKKMqKJBV28MvumSPGSVkFn9OlHH1JF38sGWDWuEKX8ltPNR+3h61Jrj16OW4GGGAv+lSjPRUmITmlBirTIp66sCUkzr99v1LjJpfu+IHUx4RUn4O8tI0LxBPcKmDFggZvNSzTILjibS1Gx3y7cklP0UwtZM7G99AVQC2VmgtnbZRqeaKWeqap5grfSeYpsuFwXuTKCQzFqsVeW25MRQw0evpqRwyR9r9FHbNaUNrURFrDdQX11HSQAQpZNJ4WeQuxrfENJDSyf//pkOoFez9O+HmgrGYGgFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9929.eurprd04.prod.outlook.com (2603:10a6:800:1dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 12:29:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 12:29:38 +0000
Date: Mon, 21 Jul 2025 21:39:49 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	"open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: imx8mq-usb: Drop ref for
 fsl,phy-pcs-tx-deemph-3p5db-attenuation-db
Message-ID: <20250721133948.GA28518@nxa18884-linux.ap.freescale.net>
References: <20250721065424.4192351-1-peng.fan@nxp.com>
 <20250721-imported-quaint-crayfish-d4e44b@kuoka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-imported-quaint-crayfish-d4e44b@kuoka>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MAXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB9929:EE_
X-MS-Office365-Filtering-Correlation-Id: 154a22d1-5997-4341-99c9-08ddc8524260
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nQdzQZeWdq9lhIpP1y7uW8x79D4PIUz7IvnlFP6ibRe7SisyE5IuPQ1w0gH4?=
 =?us-ascii?Q?FesswA7TLsrolnyCcYLVmgkDlIx/z7t8xcaTQJpmZ9QFBg+CR9nlX+Qjegqu?=
 =?us-ascii?Q?cwGdFO/iWFU+eAi1o5kqLkpueamycLv72gKW6c7yqdWjIjeO4woF/9Xg/ajZ?=
 =?us-ascii?Q?kjrrm0kTAOq6VAZf1l9zgxamK+TPTyPduur9KLeePH8qaTJM951uD3gaWK5e?=
 =?us-ascii?Q?f1phJPh7AeoC+PvCLjB4imM7KObM4c+it4nUn7IK0d65Ildo36yXa0VfUmyG?=
 =?us-ascii?Q?vh4dXhoAXwzfzhl7WvosMo5stT8gERpLv23SNKGHSCP0xedy/l8u9IA3xFRP?=
 =?us-ascii?Q?t8kEjAMWkE6kqc6/69M6zX3p+IdMpveYcXEJQ97xm3yuPNYEtK1UM6pBx/yv?=
 =?us-ascii?Q?hbheaMb8NOaJwsz4XjEcZON3oP0y8Jh8cUYRokYEml+GHIMpP4ujodR3dF+X?=
 =?us-ascii?Q?FAC/Ky7QBNudErDQlakkTykIPt2u0kiquQdTpoew7yzjHK2IRXYOLukVFeqN?=
 =?us-ascii?Q?MP2avRyHECmV1YIMgnCDSQl9TM8JGACjpGJEq619klodEA0B0Awf34YV2Wew?=
 =?us-ascii?Q?8sv6iXxk8Yj5sn2RiNP41sl4M7echRtq/zKkQxu1Dbtl2ZiDBbBxvfXFb08y?=
 =?us-ascii?Q?PGUvuuLTuNeMEGO8m2ChB0a0TyqUFB0UEphO1KDVRCxS7gSzdzDOGnzDtUx3?=
 =?us-ascii?Q?n6DbUezdttUJEFW006gE2vCAOvsAB9AV0tI6wf6vFC4rIsZGtGajq+Z12IQT?=
 =?us-ascii?Q?5pRVuI36/CoFccoaYepJkH6jVVx6hiNUCf/zYDXBdsrs9dtUuS2Pz4aZYNxT?=
 =?us-ascii?Q?PVii2o3rd6XqFm3Xo3qtKlllB8FbXLL+9y6oZjmhHdv7l0AVdSKgQIrIWyxm?=
 =?us-ascii?Q?31P2AFBHfY76aCH/2RNdL4Ay7RWxYJRY5e8ywWV9X5dGlMUDTRniaDYap/sL?=
 =?us-ascii?Q?nopqGBjVEbnsFkHUMjdSZssqY1XmyQeRYkLf5zGs9yVKpu/hvsSnVIEj1/16?=
 =?us-ascii?Q?ghTC7uexHc9UVe9IL1y0iPe5v//W1cuMq8E6Z+puC9rNjVw1zARSc1d1pYfQ?=
 =?us-ascii?Q?/jBFrASy1ih3+LWmEuyyPFRPsN4YSM8qOvHmjz76ohmcFHeVHPewAB7Gaswk?=
 =?us-ascii?Q?xsn1KqHN2vmRGzNZ0yCl6VhSFLQ+bB2VPy0sn3XqHjM7yosCwra42sIcU7RY?=
 =?us-ascii?Q?lcI+XHKTpjdca0K1Pkw/fJon7Af2+5NYhXWG9vJzPW4ZAh6NwP58npfccJQQ?=
 =?us-ascii?Q?v7domO7yZTMGkRL+3BO9umQXcYtChf1jRsEDDV/u7TMLlx0pXz0ExZQ1ibx1?=
 =?us-ascii?Q?xkUAju73PXmoo4CYOfOUM7VowYs8c+j5cRt5RMjZTylA6eAaAubJPOMGObw1?=
 =?us-ascii?Q?Uf5iBcuaWUCa4TchpuZzN8fK7e1OWM0hFgvjlZ5sVS479CBKZzWlQgm6Vi2m?=
 =?us-ascii?Q?a+lqxTd5rairMAjOOLfzj5u28jZP7s7bZrCucjulBJULGBbbpt0mGJuFrRbG?=
 =?us-ascii?Q?zAbDpYvwe62e0mI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L38x5hEIUfi04PrBBU6/ESaG30+6jJ9GqJBsx54oSpp1HdVpggXNMrPxEABJ?=
 =?us-ascii?Q?AZtSyhcQ4PZUtTk7bx7DZxMkLNz0/iHQU+Sci9YGyIINOCkFlyj078c5c7OA?=
 =?us-ascii?Q?p9SqB9r0959IqoEp4naTE4r+n1rhTDdvrLzr4vL3YpBDiSHISAEFHVNEcfSl?=
 =?us-ascii?Q?vPrDBe+z+ZU6fply7gye+M6tL+a+G9jIyotIBEIqAC3wGbL/9lrIwtLfQy/v?=
 =?us-ascii?Q?PiniBRNyyG51bJI0obTy9APkXqZuaNxmw24T407FsYzKKCWq/SfMm+UlVjYX?=
 =?us-ascii?Q?qBB33W6LwwOSWyQXpihV2LFWJTQXVAdixjy4AXlQWFz8hYN0oHrzLUe8ko9G?=
 =?us-ascii?Q?gyMqL/5WqYIvU8CEvESLauI3PyXsJGHorqL773gPTHDOvxfzws8sR/y+YcCz?=
 =?us-ascii?Q?7VVcAtL1J8YPp3EwR71ZncAqb8CY4eldER+D0BimAE0O8EPOb+2lIAPp7SjW?=
 =?us-ascii?Q?QG3DsHjrY2m8LsesxOliWwYAkWmipsEK7STjgbAcUe/amyvMcxgIpzcSb3B7?=
 =?us-ascii?Q?nObPDG7lI68yofBO6ved/zoUkfdq7/InuUBytmA4MOvXs8q4NlOq5PHuAAPH?=
 =?us-ascii?Q?d0YovFULXHTq0eHGMyVSzI+O4/zih2FUB+o44Otox7iIf93CrHRfOOKZw0H7?=
 =?us-ascii?Q?ZzJveMoPMPAyhzOrr+x6Bk0mVmus9nPY1JqcW6zYntUonT5SlqmV7yaDkFoH?=
 =?us-ascii?Q?sLapBaVXOXQaTK270uZSkSqxE+Sdq5DzHaWBf9QGj0mD1PoRzkPNf656ydt/?=
 =?us-ascii?Q?eww6hKD4WzCcf8ELRSmbdiscPwu9yORXZqYTLmS/tFUIRoDeayeaL9lzksDG?=
 =?us-ascii?Q?Zy7jh2Jss2Wf9ov+5nHoOdt46SPaxyENzAG3w2CfVQPiqHCn+bivT7Ievxb3?=
 =?us-ascii?Q?sFXdtqmcdKgQg8EsSK3/VL2wrP5shqDryEWVxBMT2qdc9HjzOa9tr9DfeV6d?=
 =?us-ascii?Q?qJOcBJ/OB5FYjQMzciQk6yhhCiOxPto6hQVc5SDuVVsa7YmvkRIQrk5GO21v?=
 =?us-ascii?Q?r02c2ftaaiKppG/vNuXeRZCDUS9TUJpS5f4eiZEId/i5e4lfqVVi4ako5JSO?=
 =?us-ascii?Q?GibssbPoi2vtH2kGhhuDtgNz0Qs8V9OtJsWnVX1Jno1qqI4aA2RI6kenFIxQ?=
 =?us-ascii?Q?PLMsD0t5d8OVpXngOqTExMS0ZqFjHY6eFR5FkSQHUEM1mxLGvoTY0XOvWfGi?=
 =?us-ascii?Q?bRzEUmuwWwjCth2p5rSuQXNfKv1dCtkjfYpoX/EZnTVMgtEFYcSDUqzHyuiR?=
 =?us-ascii?Q?oZ9H+cr8oEbwNxwdvo5lqOZIwdQz/izp/KdW97E7awzObu9V53MokD5VaiRd?=
 =?us-ascii?Q?50YTgTqi2PDg8F1pAYBIxTf9Bqn2cQsaDBcgo8qD2NSsSqOvWGeShduCuSZ9?=
 =?us-ascii?Q?N8e2cq0uabXz5X4gXdl3+5oClCNjgwNEanWhYljj5REkKfAHYyQnDjoYJLl7?=
 =?us-ascii?Q?KYa5S7heQTSqAYU22FaL+u8n81UgI9ILrsL3nQL7sZlMCyxAXrsZXPkG5ES7?=
 =?us-ascii?Q?WS5TLvUpjZCMlyJYyDFdN2OTxlIUfC7UPauJid+vYOsFMMF0tjapc/+f3keL?=
 =?us-ascii?Q?RkKWOC2KddZCa+PgYouZCsIatbRWhW21MImOAUh0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154a22d1-5997-4341-99c9-08ddc8524260
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 12:29:38.4711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVYJo16Z5noRocjDRiclrk+d6GZJ0wNftAzp9qWdbUZGwsnJZTTKnbMXjwJudSnZfeDftIQHFeQ/GIRUWhpBBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9929

On Mon, Jul 21, 2025 at 11:39:11AM +0200, Krzysztof Kozlowski wrote:
>On Mon, Jul 21, 2025 at 02:54:24PM +0800, Peng Fan wrote:
>> Address the device tree check warning: "phy@4c1f0040 (fsl,imx95-usb-phy):
>> fsl,phy-pcs-tx-deemph-3p5db-attenuation-db: 17 is not of type 'array'"
>> 
>> And dt_binding_check reports:
>> properties:fsl,phy-pcs-tx-deemph-3p5db-attenuation-db: '$ref' should not be
>> valid under {'const': '$ref'}
>> hint: Standard unit suffix properties don't need a type $ref
>> 
>
>I already sent it, since I did the change in dtschema...
>
>https://lore.kernel.org/linux-devicetree/20250627-dt-bindings-db-v1-2-d5c7072acbee@linaro.org/

Thanks for letting me know, then drop my patch.

Thanks,
Peng

>
>Best regards,
>Krzysztof
>

