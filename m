Return-Path: <linux-kernel+bounces-833505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE582BA22BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED52D7A5122
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B4B1DF273;
	Fri, 26 Sep 2025 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V5afHx7U"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE661D5147;
	Fri, 26 Sep 2025 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758851627; cv=fail; b=OAnMTmHW63FU2z2iz8RsO7iuqHmH1namAyyWXUJ8yJJZx44fYpjbA90fh0pIaSFou/Qa4N9Xh6EysYISo0dayF8R5ZNIoQV/weqg02jTEFUUd1MPNuWizQ3XhmbLNPv9N2GFpVSGDywMuA9l1ZNNT43kx64sEh9O7WJt2OxDQCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758851627; c=relaxed/simple;
	bh=yJRwjslA1m8b68t1p7DBZl0nVGL0Pem0NuYvSd9eV20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X6qJMYaHajE2m5IfYCXnRwrieYRdwdb3Nbt3qzW5Y4p3m1eyjdc5X/sGHnSL6E2E0yTud8sOhyyGy33qrZcXZtDR0w6MWmXVMV6Zhq3sDKC+kHVQK80pLSZtvDD1hNJ03b6UN//mE852WrYF+QrQnBN4FKvPI6TmWnSfleK6KvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=V5afHx7U reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHTnbAbPDK5GkNvElJ5luD3QcsjApmDnz0o3x6dWWfJnTK2KkK0zVzoNSuid9onTAEqSLhEFQ+IiEL72qrOkON2JUKXl9RcOzrfnRGVdkwt2bVi0+EEgbJS1JBi5H18/K1e1nq6CZVnKrik0jmeeIXZVf24FB/8rBObyawr/QtlP545cePmiS3NOp9VE+uUH3SKU9QcMGGH+jIJaXvSr4cBTpC8fgWe7e5jhGc31imGAMhnHrcsYfgY3j2WeH1NN1gHI0Lgvq1xCR4B0hBM7TAjEMzLAfCw63/2Xhv5qcbnC8snYq+JRfejgjI3pu4M6AuiitFH7F3PUo8KjvZWFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvtUaFf9nNt2cNog4WGuY4gtmcgyZ7/Gb6Ym2IaIbUY=;
 b=eGCNA3jijfAdKjHNb2hd23IAyHGmcwqkWnCLN0LrdPr4OZiMXXZ6csIp+6XZRxbweFeJ/HxHKs5NeElMPaAWg5Krp4vzYA/yNyDzo/D/ZZpEREb3NkRvQyl/ZhSiZdBYXYgLyP6ftqo1hJ4PXbmIgfxeGBO3yeoc9BAJ4ZwpOvl5w7RPOqIBlBlh7ouIOS5Ieo2d4DRIM5ZLJx37tlMGv9Gcx1yDqlQ1ZHOLdJmqkg+so3WBf4EafO39b5bunt9e6vW77pndMb0nAKEzX8tp9LIBIGE4RkEu1Sl56xn1twqSnwxnyvXBXWqFCH7nAaelRMlVcojRLtE8suBiB1s68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvtUaFf9nNt2cNog4WGuY4gtmcgyZ7/Gb6Ym2IaIbUY=;
 b=V5afHx7UbLF8VXz94CZCgnvoar7aGMRg5B7PHql25Khad56q7sgYb2tyRUbi1n2Ac2W2IX1tdsi2z2lC+BjgJBGuZ+VS++6NsGT2EO2kkGgRPSHsgkEaPupQbbvR9Twys+baVNhJf0m/2urTNQoqTfFudGIs4G/FzuRbhaPTNnm/s2ns62Yr+89eGVScsUaAAJT4hWML1L6bILL0PC0SuoWsv/WO4Q3M3eq2pigIN5gnIPFh7rzu09cQ0AZmYEyyVgA3GW6uJjanNvH7mn017tkZQFB5bZnVceaR5jhPBzlLhICE+Hu1dief+cpXB9pPjCact2l1sfrbcrWcwaTQPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 01:53:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 01:53:40 +0000
Date: Fri, 26 Sep 2025 11:05:24 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Goncalves <jpaulo.silvagoncalves@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Michael Walle <mwalle@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: freescale: add initial support for
 i.MX 95 Verdin Evaluation Kit (EVK)
Message-ID: <20250926020829.GA8204@nxa18884-linux.ap.freescale.net>
References: <20250925205211.171699-1-marek.vasut@mailbox.org>
 <20250925205211.171699-2-marek.vasut@mailbox.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925205211.171699-2-marek.vasut@mailbox.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8f8136-0dc6-43e3-093d-08ddfc9f83d1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?qwmA+NUTV7PjWSw3QyFuTidIpE4CF1+dDWySVp/f1ZCci1zgxDlkhdengw?=
 =?iso-8859-1?Q?nLSf0laWTEQhxRGGxmRg20pj+lvWr31V/yBJGfehI0F2Vb4gttVrCtqchR?=
 =?iso-8859-1?Q?eDyWWglclDjFowy/037cn59nTAXshaKA4LzPssY3NzZoCsEyImjvlbk2UB?=
 =?iso-8859-1?Q?dElNynBM6nnwGIeJQDi19WavmwWIoMrdldjHi0730GeYI6f0gHZF8V2Q2s?=
 =?iso-8859-1?Q?74izJ9eiYNzdO864n+D03r6iEDAKV0QcXBszM09fyqlUsbzL2mj+FRS9eY?=
 =?iso-8859-1?Q?jLcSZW2y9gu6N8hu5X17EsuBioPd0Fjn0/jQtIRn2AON9/34Y3zaCnS+jA?=
 =?iso-8859-1?Q?2sZqAjKqVxjWdqV0cbPnPtXLZ1HCRfPa+HUd0DLZ+nF0/K678UnpVJbQ60?=
 =?iso-8859-1?Q?oJwNgmnhMthz51x+KiRh4CPrLKsgzWf4c0/Q0HT51ccal8D3LGMW8Cyvuc?=
 =?iso-8859-1?Q?s1pzTYfW06XbHUSXD/YV0/AsUsiecSgI5xaF/QdH/mYR0CEys1uvdpw0aj?=
 =?iso-8859-1?Q?gL3IQDvezIdPZO0NpdSRagKl475B3GhrzXNEBWqtqgI/jTpUmBdgJ4/2o0?=
 =?iso-8859-1?Q?9m5HIXTwgTJeNZssute1T0MKzQtt04q2JPuf/BL8wpx0apZBgQB8wqrlBI?=
 =?iso-8859-1?Q?B/b84rFBxvpyy0q7zt7jvEiMCjyB8BkSLVnIQzODFfB/XXALMWM9Z+n2Um?=
 =?iso-8859-1?Q?3FlcoeUc31cuttuIM3pGgiMLoYfts+PHW/zv29cbYc4A8eV19d9XZBuXUY?=
 =?iso-8859-1?Q?902D8nmjuBUuowzBjPjBl14UlS3pwnEoV73t6obHC63usmYNjzLMZf1+Ql?=
 =?iso-8859-1?Q?IfPvg7XCvl1Nu3V40ilyiv4ixJuMWys0oXtPSJPO77YLy/ld2fZubIQcml?=
 =?iso-8859-1?Q?I8PrjmYMCBHSYWpYA5SJCRLeSg+liTvxq9i0OLzwQ0/BnTF0WNdw6OfR2g?=
 =?iso-8859-1?Q?lMV3tIwS+70MJI+gecrgXqTepveT5F59xtuv2lvrywI5xwOlnAaToNe1jf?=
 =?iso-8859-1?Q?RxsdXTnvQU1weG6r5vrqNSWPW5c0ijFOE+XZZxmAi55yLpMyOSzVagXOUi?=
 =?iso-8859-1?Q?PTQVssyMyzRGpY7oxY8RsDpQ1YppVxF3fTwXxw7Z9sQKgtwFeVkngDAkPf?=
 =?iso-8859-1?Q?71ff7ngLtE1TeN9nXNkzQjhj/HPOs7McuOcQeC9bC1fBmDimjiUjRwTPWT?=
 =?iso-8859-1?Q?GGkXnBedIImtp/uviKG0Kax1BFMbP6ewBcWNuTzGCuMBjICjKAU1M8ItCd?=
 =?iso-8859-1?Q?OANzD/kuNImOTyUPAQI7VW/+fG/cL4qKgVyk+xgoOONLpcdIvD0gtSe24U?=
 =?iso-8859-1?Q?F8rJ5hojKoar/PVozR5+g9T7yqq5HbdhljL/Ke26ILMruBJqL56gZLDNrA?=
 =?iso-8859-1?Q?3iHrtND6ySKUDtnNh4wsldu7/UvtLeoA/v9W+304mjxBBb4Dd7onHg0R3y?=
 =?iso-8859-1?Q?QZ7IwfDtyWBNfzSU6soUT+LgxWpmIFajugdK6HnpckAM4vAw29EppVjhzm?=
 =?iso-8859-1?Q?jMJ4YpvPYzTTft/X6uJVpyS+L2k/9ynxnjaVZ4GTtE5w=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?vidRb1zflxVm3hKvI9uk9TvXvGtwzJuK0DMZrykskPyKkIeu/LisnyyKWD?=
 =?iso-8859-1?Q?m8cVa+IxwMOrUJcO446liJ4fRPKlM3KeDIx7z8kC8y9eTqUXPHHwJWkAyZ?=
 =?iso-8859-1?Q?eVc+Q3KuGXtE8DSGobWoOS+aOleS+YKkeKYPAwBbmuY5KFYbsFGUB/imj9?=
 =?iso-8859-1?Q?bKjE0FPo6QO8OoZ6Al/sokeJaC/oKVsrVq2+GyrF6G5W6oc3eT2nsvzb9w?=
 =?iso-8859-1?Q?zmwhw52PY1uVXek7rJr/3hdVgAx3wTq16Pxj9AE+orbdqvUL+4y40nG539?=
 =?iso-8859-1?Q?rpI2TS358LQ3Ae6x7K4GA5KxqG9GVnZkeSMOiy7Bm9hENYqjsQSDDy6PtT?=
 =?iso-8859-1?Q?rl2HqTUFDxM6EumFr0lkfUb3bkm15EWBIKigL7TQEhGhanTFehx0X6c8Aa?=
 =?iso-8859-1?Q?XSiTI+Qobl/kZcbOSWzkJUj+uBBOPnbNLW6ReZaDWS1FI4GAw6fSiPS5Sw?=
 =?iso-8859-1?Q?M8rNjUjkejWONUbqgJsK6aSUOkUUSpMHL6BVbLp/iFZr6VOrFpKrzRHKX/?=
 =?iso-8859-1?Q?8H1Txfps3b8PGMHqFmTaWIMpdXqSEddUHok8s4ctTqXIDgYNpPY+w0n6Dn?=
 =?iso-8859-1?Q?AIPJOXEn3fW1fRa37GA2chaEJPW8/a0U34j9Yl8XEDxHvMYLuITsAUE1KI?=
 =?iso-8859-1?Q?Bbkf01PYzqRpBLwGcu4Ot9MbzWi2ZiXV7uplcDsSxaVorzthna7kjzSxM4?=
 =?iso-8859-1?Q?Q4jp4WUL3QKN/CH2CIv5Q4XxPaIIHtNi7xJmpWNPSw++kV2F2Ocp/Wjimt?=
 =?iso-8859-1?Q?J9MRACbJ8o46kZqG6GZfKDvUpkeWD+HzidtG+NS5wfmuL7B+ma6fNmOd5D?=
 =?iso-8859-1?Q?Xf8rvK6BwM6YyibbD93yvcTPzHpAb0QYbqzlGdjxls0Zp9REEzHRnzjjvf?=
 =?iso-8859-1?Q?mZt6pHkfmGESRwzGMoIlHVf+CHQh7TseWrSKFRm1n5VhG1YPazGUSculuD?=
 =?iso-8859-1?Q?B+9BYjVt1i6tJuR6ZTdZl4KpNWDOWCN6BXMN7FCz30TPDaxwwUBmencztt?=
 =?iso-8859-1?Q?+C2gbuslzjW2ibUe//OYA48K1Pavt9dX9xv6+fsF9C6qr5jywK48XZ0msJ?=
 =?iso-8859-1?Q?hlQDYLYLFacqMFBjmTDDDOiZxELDolJ2YoNlnYh2c8uTpfkSdK+YblSbhW?=
 =?iso-8859-1?Q?6zVJbLe9K3e/xty3m8ufyYesV1ZBQPSA+/Rejr+xNbsP8DTHd53QlXV/5h?=
 =?iso-8859-1?Q?AfWA+HdyiQ4IGnscoBijDTwrbO3otBSv8ZYqELixFgY0RgRRvrewJiJkFx?=
 =?iso-8859-1?Q?YOTfx5RRLgSe4l0306Pyb0aOhtNBukP2+KA0PydgONQ8OO3PVjOh35Q80w?=
 =?iso-8859-1?Q?a7rltf+WYULSbFligVr0XFUQwwsuALdu56wkO0J/xddIe+kKtpUeOk57Cs?=
 =?iso-8859-1?Q?u+ERP6NCqVjr//+xT89VdgzhPMCzbKTAgL3Eje8MKcpXrsf1kwqWhTYTMh?=
 =?iso-8859-1?Q?5i74Ih/DSPmS+wtiFHCCP/1iMjhZ3jZFfOWE1Q1mszOE/UB+IhYl8S/g6g?=
 =?iso-8859-1?Q?ifgjenZz7OicaD/XXpoweNSex1vrS35sN0HGr+QCvM3tEbLjuwB7hMkVdS?=
 =?iso-8859-1?Q?e2MI3EzbBVR8BOtbDT1icQOVDhdQMtLJMFndhZRWgs2cg5anxaWq2llbD+?=
 =?iso-8859-1?Q?KClmgrUuIOXPAYvBW+gwElcFDlBVph4k3G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8f8136-0dc6-43e3-093d-08ddfc9f83d1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 01:53:40.2192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1MNmxI6Qq5zMk1BUKgoTZOTgSH8T2kSAfDEPy4ELPPPj8HaBBSbWzgC0c7J/Rv7GhSa4leyzrLqusMcDdkjBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9018

On Thu, Sep 25, 2025 at 10:51:55PM +0200, Marek Vasut wrote:
>Add initial support for i.MX 95 Verdin Evaluation Kit (EVK), which
>used to be the Titan EVK. Currently supported is lpuart1 as console,
>SDHC1/2/3 as storage, WM8904 Audio, USB3.0 and ENETC ethernet RGMII
>Gigabit port.
>
>Note that the SoM used in this EVK is a derivative SoM from Verdin
>line of SoMs, an actual i.MX95 Verdin SoM is under development.
>
>[1] https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95-evaluation-kit
>
>Reviewed-by: Fabio Estevam <festevam@gmail.com>
>Reviewed-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
>Tested-by: João Paulo Gonçalves <joao.goncalves@toradex.com> # i.MX95 Verdin EVK
>Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

