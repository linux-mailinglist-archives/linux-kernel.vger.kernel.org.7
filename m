Return-Path: <linux-kernel+bounces-824206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B57EB88618
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C6C1BC7DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ED22EC0AE;
	Fri, 19 Sep 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sxeuSdAn"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010022.outbound.protection.outlook.com [52.101.69.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DFA1FB3;
	Fri, 19 Sep 2025 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269943; cv=fail; b=lrqJwjz6ZkR1p6Qg8FTdP9eGAnHpf/ybslNiq4FAsHWPTIN2sCznhgnBokES+xfpNAnp7zqkt8oT9ZE9PlW2WRhiFaMlBYPa8yB7LNZExjE0+0/c0qPjg1xCn+qkIYcCngDXwknXIPigIC0FsnKGhoL1VARrP23B1DkX9snkA9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269943; c=relaxed/simple;
	bh=QLQNviM3ISijSfCR/zgBY7IrWypvwT6VWOGvXmPnx/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sxxYtFspGMOeb6rAkOAWl7J77RwUjAg5aUiKVOBTSjZiEUnjPORKGF/I9uOXCKva74IJE0SQ9wdHxkKJLKUU9IlX77/2hAtDx/H/fx6hy+vfaGv+dpMr2/BkX/vJZW3GCtqAAjG+32WRdvphm75KQbEBFTPkBT54JNKeNp5BbyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sxeuSdAn; arc=fail smtp.client-ip=52.101.69.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6w0FAXs0qxf0eckTuxzB+GDnJhw0E2PHhRVsaFE+v+9K8zbuUteIE7uOmU5QfPM7mSgJ02iIP9n5b/BfId2csg+4SjM4YizC65tuwzpFrNsTVt6zgMCOqPHKBnakCQNWKgQYhtGEaNQfn3FWeESbfefDyp37EaMFMZjBD/PLsjKnGyAEYXCQhRhLQLhDSH/lybT8A06eNVJ9YrInIkpkd8ckePWu0GxRCDqoERG5SLaVW4ZFoh4MGj9VvJhvKOmUK5AN+d460PF4L/6mh/+ft9x0yiEW+I+LfN2ojK8nfBH6y2qqRMjRnnj8NrXEjouhrpmYWuaKmp12KxfLSc78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLQNviM3ISijSfCR/zgBY7IrWypvwT6VWOGvXmPnx/w=;
 b=d2UBXafLFJHb3Pnyw2uj7mia9IoE/PzIWOrV5JrswJH2zO4zti3vlFdh3ei7xbA+A0bhHwNcqqwXw9Qkn6PK/bhPBv/bDUSNT2mVI76Ghm+HyibrH1IKSmsjyZlo0O0IsRLYqkXdmQQ6uQVAHTKtkPjEt3Z2YZN5tiYV9Mt2v1S9W53vmOmF7A0d40mfq8zjIGAyFHPoVqt1/Kbq4LtpFb5mgWkN809pBF+tl+JAPdIyv649W3OVqs8CXoSv/d7syuJUgALaCrokYRXPwWl8+4bt6bPoI+YvKe3IqvkhUNpjwhoQ5gP7xLWMiztDzhOo8rxygERNh+maB0WkryJvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLQNviM3ISijSfCR/zgBY7IrWypvwT6VWOGvXmPnx/w=;
 b=sxeuSdAnmZmVwgEt7qiuoWL6Jv3VOyP4TWAbXBXnN6iP/wIohgNqVZKh6kzVCFsetf1a4i6tcPbPo/kx60Rh3RMFTMsHc9jHkM+IqiXK3D/HoZROgj+LMJeEIxAkCexQ98uJoFPXNdJx7DxEKtdr4R+vycmSZ3PzmApFDD+afN04l4QkDzpL0FCP3PMShkJ/qkRXXXWBTHPjXmh0PVo2CuVHCQ4ViU4pmnR20MsN1Mm1SUmVJ1oYRA1w36yas0CjSzPvdu8+47G2NSLBttfy5IeHAHeVpCU4ElqvVUvpr9BuXHesd87yui6P4YvrhZPOEGyTx+UC7d3IB78cx0vFKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10545.eurprd04.prod.outlook.com (2603:10a6:800:270::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 08:18:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 08:18:55 +0000
Date: Fri, 19 Sep 2025 17:30:34 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michael Walle <michael@walle.cc>
Cc: Haibo Chen <haibo.chen@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	Frank Li <frank.li@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>,
	Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: imx8mm-evk: limit the max frequency
 of spi nor chip
Message-ID: <20250919093034.GK9196@nxa18884-linux.ap.freescale.net>
References: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
 <20250917-flexspi-dts-v2-3-7e2a95e3cf4d@nxp.com>
 <20250918090151.GB23028@nxa18884-linux.ap.freescale.net>
 <DCWLMKKUEALZ.CX4XNGWG80B8@walle.cc>
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DCWLMKKUEALZ.CX4XNGWG80B8@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 956573c4-74ed-4fc4-b503-08ddf7552cca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z+/cszy5nxcYV+mtlQK2TkboWJA2r3vGPJmGUAfVLUUVC1TujtjH+7/n+2/R?=
 =?us-ascii?Q?r2bWSiHB8XejOaw8FKf3pwefwTiXYt48NB+3zJHevGTi83WZwYwmUlV+MMxJ?=
 =?us-ascii?Q?dEY9rWDiUuoRrxi+Dyi//hbhtImV/SmPxAsO8uJFrgGyjEALrbuFXdzBOTbT?=
 =?us-ascii?Q?zvQ33LnElNRHu9cB+gg1Zhcnsl/nQoz0t/qJ7b37mC0+56rjGX9N6Tfpzbbj?=
 =?us-ascii?Q?rozcW2+9gFLxbYcKE/NPBHgds9U9zq+Dclafb4v4B5ALcq0AeCa5eBODNb54?=
 =?us-ascii?Q?M7Gpi0gFS/er/gKMIvW2hC/ITeuyfoeGITYMCsnjc2p0/egr9LWUti/F3Iip?=
 =?us-ascii?Q?PFnmPQdrMmSdhCX41/4bZ41vlGcrjDU54qhp/s9iScEMxWOIQm4twa/cnEzG?=
 =?us-ascii?Q?YSyC0rHnApLzCgkvjOo+iebxORlZuoUkXBVK92X5RhZrJ9ufWOgyCzLGeT4n?=
 =?us-ascii?Q?xM0M0C1+xEJ4CNZboVBFqOxf/SqzGDSqYKNhwt3UQ3wFdi8Lqf3ssBObhmIO?=
 =?us-ascii?Q?MuGD37ixqfBo+khHG4RL5GmtprrkdE+55Qhr55c5XMQztGmBhj31m1jOptku?=
 =?us-ascii?Q?lRH8ZEgIJChzVIlkYn6ofJbN9mAxr04W00C7+joOpD1dW5oflxoFSLF5OKUT?=
 =?us-ascii?Q?eq7V5hrrf4OfqRV62ScLrpjj6kJpuSpMO4dhXSxJQaTUxHVt9vMhwY2Xb+Iq?=
 =?us-ascii?Q?/vvJ3v1KWvzWVHLdilqND+Y+0LqbYFyik0+xiENZeIP49wFGAtRtyzjohoxv?=
 =?us-ascii?Q?4qxO8KpXKfgpCRxPjXHDlCbQzQ4rALFaz4H0+WSXBiXQG2VXRTDtt1GeVlN8?=
 =?us-ascii?Q?I13e82PxA6qZCYU+GCeQ0tSA3WJPD+58If+hLgPU3bZMZeQcSl57UpoCtAvl?=
 =?us-ascii?Q?cDNFLGk6bstICJZNZspnzIHZ99JMRe08tXqHU6X9JIuv4V9a8tzeAbdAjwdO?=
 =?us-ascii?Q?WssMfTRl0ewe1oDl4rx1sKLTEi0g+tqcNSsQlGFiuDCLN8UOr1cK4Cl3LASC?=
 =?us-ascii?Q?2mXHFKsFF9O0hisMCaw+hV3h7MuRlNQoys+CoetAVnE9m7ITHYm+K6UC/FEL?=
 =?us-ascii?Q?gXxaXvxQiJRaYhngGTM8jKBxq1KFvOHdu6hHG3AVMK7Q6hlf+WzmFgirhww/?=
 =?us-ascii?Q?+nsEo17JzoZydS49/j+kpIS1kFdb6R6JhHSKYxpTeis9olMe+3rLjYuSUIVM?=
 =?us-ascii?Q?MFsHt+kWJIsCVBsIKeFLLBF/1No+rph0mdfmCxG3Yy1pfTtjTVKq5V+229WG?=
 =?us-ascii?Q?o2HM6n+VPOKekq8W43ewVgzQk9LM1043fNek7O3kxThXlNk1HG3KFaIjVqKu?=
 =?us-ascii?Q?wmvU2nCcjihgNQar5UKuFPrKBlbKtSzWSrSgE7gwxBq6HTvF2rKhQRCzRSdp?=
 =?us-ascii?Q?thfVhIDJqLtfYAlnt+st7TIZZJME3/2w5FXH6D/JrNpcKBJLuAm1qii+NdHM?=
 =?us-ascii?Q?lUBmAtbfbq4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4f5Gre9eeonYXtQvSdrRvOckYGT/9MH+yG+esAPEF5W1MsHE36N8F/+8V4FH?=
 =?us-ascii?Q?+COIfgPfeXrIBi1d164KumxqRrgu7YKasGBBa5a957YVKbSbwcLzlJA+YK+W?=
 =?us-ascii?Q?7obF16KpNCNnsWggJw/8IuatPJbE2ZA0OS4glFErmW6uZLfMqYnce8YsJikb?=
 =?us-ascii?Q?K0dhHxNIBBii0Gwcllr8rYPx8d+XnaOMSTtVRAqibr9hLX+uph5GdRFBxxuf?=
 =?us-ascii?Q?FtBPKbp34vILyLnB6wcth6KW+spzaEezR6G4G4GvaR3f1g3VKKZxPL5fFkT4?=
 =?us-ascii?Q?t6tqZLGL3Mo679zEMeNfrC0LTXO+zWKBuzpoLyPmtt0oy8BLKCK5zkOCSxr4?=
 =?us-ascii?Q?VxP4vUCIgW4vRCJqcGzZsXSfcHqiu8Rpld3WAQPZm/yn676KK4JvrYrS6Tjv?=
 =?us-ascii?Q?1YSMG0VgEF2gH6uPGuNwQe+7XclrpHQX0mdLBQjoeO8T+RVfWaStMY0jL8/W?=
 =?us-ascii?Q?fbYqzx+k3MWvpTOe43dt5nPXB+jgP9K5D+PQKivYZUIxoNvOGrks4GDESzVX?=
 =?us-ascii?Q?QntgC2tK5FgYoxnuDOda1IfxEUVroARjuznULbfPGxwQqqIhmqhHVusiOjer?=
 =?us-ascii?Q?zZXmlsL2gkE7YX3SAjojYw/PzJUGqWEjnsxk6H8N1vSrU/0PhFl9OFTNtg5Z?=
 =?us-ascii?Q?SYQoiZYReXnuTeRV2S7eITB7bjFAvBuWtye/YjRhQ0j/Q17PYSt5add5P3nZ?=
 =?us-ascii?Q?rtUqyZsNAFZ6WfYLy1glIdOSGFv+FpqxhD0l2nE8jy4CZ5GHN6olui2T7Rx9?=
 =?us-ascii?Q?nSZW0wQbO5ag+C7yKU2oUQKfhAZyfUkmmQ1sFeglF1YSzlTvvBc/3ErS0VRr?=
 =?us-ascii?Q?4BJ6HvXIlTR4rIWuJcKguTDZzZQETAFtYmEB+iwU/Ud/gtV9ucSTuwujMrFX?=
 =?us-ascii?Q?ui97VksHn9YzToi5Mrt+tPPyz/snUY1/eeXq9BPWik9tFShEGLN0nyeUaSb1?=
 =?us-ascii?Q?8HnHBGJon3yfoaZ+6Gi0pTLv4uWSh8jL24m55zACGMl5UFzydgysFd5T0WbJ?=
 =?us-ascii?Q?fCjcALsI9/x+k3dRewS4vE3e8pthI/vQo4NV+hQriPXFCcBRCCBTQM+DwnZL?=
 =?us-ascii?Q?75Lj6IAkKdl6Pvr3nre6ykEHIjwcKdFMIErPDkJN9HZARPHhY3A6xMX0Vudd?=
 =?us-ascii?Q?eZvV3NFyoL14QfL8d7arZeB14gWyWYjz/Odk2DRP1iYjL0ZqQBfWWw5pPT3+?=
 =?us-ascii?Q?esGj6ZRzmtZzIOvB2gAd9PYSoFNu5OEiF1xI1PunaNRVFabalAgt1vamn6zd?=
 =?us-ascii?Q?fisOZ1UfCZBCF/6E5sXjtcQR4Id7JK5olAl6lJ1GH3AVblqcKZUdvpN/WyLc?=
 =?us-ascii?Q?LAWU54Ybxwa7ArEwsDWHaQPHVsF464CdncUO0n4dOka1/egBIqbpJx1t+Tha?=
 =?us-ascii?Q?aIf3zmmxB0I3scJDaxCcs22QU6VBqI4vk3Gpb84+zCB9rRejFZl8/Tb0OiCV?=
 =?us-ascii?Q?QSUyFas9oncmFVfPei4hYo7fV36M0SE0CCGGcxqq1tv8OucKntqYyRtnKrK4?=
 =?us-ascii?Q?XsJ1clHPLR4v7gVctXgH7WaKV+uBYU/0xCWG9BYQ7C3HhcZ40QnphzS7urEE?=
 =?us-ascii?Q?Dt3tpXf7B7qtqY0077lmV0AQ2c5Jq9ukv985BcND?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956573c4-74ed-4fc4-b503-08ddf7552cca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:18:55.6113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQ4YSfq0woaqLtCHFFIY26QtUqIwd36on8PD+800my886h1iUgeDitDrfXYgQnB/Z9eMjOdH+gR/9w0isXDmSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10545

On Fri, Sep 19, 2025 at 09:29:41AM +0200, Michael Walle wrote:
>Hi,
>
>On Thu Sep 18, 2025 at 11:01 AM CEST, Peng Fan wrote:
>> On Wed, Sep 17, 2025 at 04:42:29PM +0800, Haibo Chen wrote:
>> >The spi nor on imx8mm evk board works under SDR mode, and
>> >driver use FlexSPIn_MCR0[RXCLKSRC] = 0x0 for SDR mode.
>> >According to the datasheet, there is IO limitation on this chip,
>> >the max frequency of such case is 66MHz, so add the limitation
>> >here to align with datasheet.
>> >
>> >Refer to 3.9.10 FlexSPI timing parameters on page 59.
>> >https://www.nxp.com/docs/en/data-sheet/IMX8MMIEC.pdf
>>
>> The SoC SDR mode max supports 66MHz, 133MHz. DDR mode max supports 33MHz and
>> 66MHz. Saying the driver now only use RXCLKSRC 0 to restrict the
>> device tree to 66MHz is not that correct.
>>
>> The SoC max frequency could be coded in driver per my understanding.
>
>Yes that is correct. The spi-max-frequency property is for the
>device, not the capabilities of the controller. I.e. the flash chip
>on the board.
>
>> For the QSPI-NOR chip, the spi-max-frequency should represent the NOR chip
>> frequency. But that chip supports SDR/DDR, so a new property
>> spi-ddr-max-frequency, if we take spi-max-frequency as the max NOR
>> CHIP SDR mode frequency?
>
>Which chip is it? I'm not sure that this is required because the
>supported modes might be in the SFDP data and we just support the
>8d8d8d mode backed by the JEDEC standard.

MT25QU256ABA
Clock frequency
– 166 MHz (MAX) for all protocols in STR
– 90 MHz (MAX) for all protocols in DTR

Current spi-max-frequency does not indicate it is STR or DDR.

If device tree has spi-max-frequency as 166MHz, but driver configures
the working mode as DDR, there might be issues. I not look into details
on SFDP or 8d8d8d8d, so my understandings might be wrong.

Thanks,
Peng

>
>-michael
>
>> So if spi-max-frequency is the maximum NOR chip SDR frequency, the driver
>> should also be update dthat DDR mode is not supported as of now.
>>
>> Just my thoughts.
>>
>> Regards
>> Peng.
>



