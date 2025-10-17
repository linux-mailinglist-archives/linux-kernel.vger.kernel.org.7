Return-Path: <linux-kernel+bounces-858252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D0ABE9706
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 757A158017D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE0032C93A;
	Fri, 17 Oct 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U/uAIHQd"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013062.outbound.protection.outlook.com [40.107.162.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5395B2F12D7;
	Fri, 17 Oct 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713209; cv=fail; b=BhKC2rv6vGICx+vXYCIRRmusdse2EdaNWydYF1mjMLiS06d/P29JPARrq0W/U1eZiiHdlgKJO9BzWzP+W5l+aliYqSVXQEBA9VuMk8vk2Y1yMnhywLbqUbcPGHU0cYqNXf+NAwT9s2LTUVxapNmHiUPnBpZLWihIoo1ARJE6+6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713209; c=relaxed/simple;
	bh=M0zsPGF82hykh120SzaYs2kejNe1n2UrjM5EuN+alrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nTUOQtfW3HdqabVC78fPba8ivMkSu1y8VHEUsIL+dXKX34oZJARs1sliIxxlC2+gywFvCFUg+oEoKbHiv2qJDrnwpCmPgmGoHb6xQ6ejG+wgma2xDsNqSIRVosewxapEooLBpKy2P7pcY966QpLYAZgpyHzjA1FR6r+UpUDCBHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U/uAIHQd; arc=fail smtp.client-ip=40.107.162.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bb3cx4+DY97fcagb9/h+mvFwPTBrBk/cqXQwOctk9N30Bk37H7XBA7jfbG+WNoxNJQ3F557abX5mkRk2BCdsEzq2GjfBee9b/p+oS5cb9o7Lumih/5qOgyfhs9MYY8Ob/LL+Y6I/x5XAI6cMaL5asrTcXuS1wALUMya+K7RT2MAktmF8HgPVAr/28NzNjYy9Z3NOCr7CwNxvKLs18k57VeSRB6q5Z9x5sMtKer/29fgRb/lwJYBUsVygXXodIcWPLdZfMoikurVs6Wi8RKBskEUFa53HqVnajkM5iphxmsuyP+r0ZeGoNWpWOwVKyuF5M/nCbHjjKAPgTopybHg42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1dcKcpVVLGTBkOUmuh0NmoX92wivO5TSnNxU/70zrA=;
 b=L5hWcciM9qN/S3LDmGzt92e/faXp6jUmVv5W9gkuj/2B83TaeJldBbvlw5Sjhvpzd8gzqeIWf0te7PftG99j7VLl4/TbMcy23nZHBSzRr5XmA44d3RSYQxvWCeFK7CshJ9W5jjr3xof/tYeiOK455DMgb3tqAFVmZjkhHTS5SH7h/OS+lNzD14L/7+Z/EdNC4x3pNfZRmYE3gWzu1LYtcMDTzk1EWN7pWj+w3Y1kC1wp8vCihPr4YnAuPR3Avp8CgQ9dJcMD8F+7b5nr7EgwfNY23aHkxsEN4teDFRELsMCUowtauAvRRwQH/J3fn0REnMOKJFR7EZVfBSZKgrBAZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1dcKcpVVLGTBkOUmuh0NmoX92wivO5TSnNxU/70zrA=;
 b=U/uAIHQdYEIOGLr3Ypu+BesfWnq9l4PZUJL+LkQ+/c0u4B25y1Kv4dwpXJRNdYQA1w6Vrjs2/Z7iKVgecL8xiEtgiNlNF3V3V7ukeIKciHMs6j3QT8nDTAG57529Kta4EAGKU4tzsGz5jfZTt0cpZArVEsZII4NDL19OmwRAH4eEPHBX33FeaFX3bjumD/o2YLOHBbz7vCK3AsjEM/IvqJpmCrOfQrbpMhkNsMofKU8uMy4A+3OMy6+adpzLGBvIS13lxW1lPesFdFAT3OtUZbz4COgW2ZQ9wiGgFFbkuMWeUeBGk8opc9iHr6T6AyOneOaHpbIU62LQ5KvAPQ5CoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB8395.eurprd04.prod.outlook.com (2603:10a6:10:247::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 15:00:02 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 15:00:02 +0000
Date: Fri, 17 Oct 2025 10:59:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 2/8] dt-bindings: clock: document 8ULP's SIM LPAV
Message-ID: <aPJZ6dDRyyl3Qg4o@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-3-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017112025.11997-3-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB8395:EE_
X-MS-Office365-Filtering-Correlation-Id: 70409378-ba3b-49c4-f51f-08de0d8dd96d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qhSeeiGbXZ6tVuPoUv7qEyEXzBkwUXP6On75/iJrljljGezHVu8diL4uVCYq?=
 =?us-ascii?Q?zJ70ww/i1rSGE74i+fxfmq+BfpfQbaSOFplinpbKdubGvBOduFStAoUmyeW1?=
 =?us-ascii?Q?lGwtbM5A/++oGlRryizhmMTufQINyRHED1G/tN/gMKai0R8DWmZnH+v6KpuF?=
 =?us-ascii?Q?0vLmuGy980mNnBknqhcStiY7PTXfVN9FVPnekUnbRn4b8oABJfx8Ev3U3FIi?=
 =?us-ascii?Q?1o7qieC2yvqaJHPCujcvAx/2+H4WyKWVlEOrPaAV58ozut+aXcYWqEDG49ll?=
 =?us-ascii?Q?qZmMdf+cji7lAjqWtB7ZHmBktIAKuq4nSwmbdfDTlYmP85Pn7r3i/OTWki0N?=
 =?us-ascii?Q?6450qJp1JPfVJDfrpHUhSHpEguytgmBBusJqIuSXkwvkMQLnli0mpr4zAWF6?=
 =?us-ascii?Q?cOFzWHjjggBkZfOeYbpY0lrh5rmxnIVJ2Z29DKjQ9g4mDGm8e8w4Rve2Z8O+?=
 =?us-ascii?Q?UPsmbktYNaxOctJp/nQli4+e3Kzrc3+Y7Xh3ZOKLA2rariWkWcKwgxsBIGjx?=
 =?us-ascii?Q?0TkW5MlPIJiW8oD8Z3SqE/RiIJ7DV62yeE8vTH/XQVRnR14M7pRwdjETplpz?=
 =?us-ascii?Q?NvGGa98a11CC81EyOh5jKoA9K5pOp6WJAkyc2pAZJoBt9HkryFmXl1zK56fZ?=
 =?us-ascii?Q?D4gyJEDrVWkq5Dde37pprF+QsAj4MRQDypFbqKzQxgupAEeXw+MC/jwrTM6o?=
 =?us-ascii?Q?FJbnEzTwjKyO0TYOd89rK2HiEf+vefYuDB73auggi3N+Ub64fQ80XZ0Aes6i?=
 =?us-ascii?Q?eXjQtfgKmqBp1pn/OczDyJSNqkJZtJsf753YssB/RoK/6/e59IwFY4ZW4bSv?=
 =?us-ascii?Q?fV1EoVRPWKbvc/WzKCBfGfek4mHcsukMuEU0jEGS0f8Gfx8Cs9oSF+94nlc8?=
 =?us-ascii?Q?ajAE6/1DbsqSTP0p5gtYDw8xlGzdjm5TAl8+4YJczXpW0+vsq/STeLLj2Yoz?=
 =?us-ascii?Q?MD+ziXur9sIy22zzR9d1Oga7wRx9sG/kGP7Y2pDVaseAvkEnXMVcV1Znxd+Z?=
 =?us-ascii?Q?mUxII7MnxBe/EdGqbo14vmkJSBkW3Mr6UycAd1aVaf7Tq+y6pKtS7uepnW8q?=
 =?us-ascii?Q?n60ZjNV6TrmHsSJA4CZuAZdI3QaBD8gQX8CHUnLUSZYotryWD0TjMeNqTGry?=
 =?us-ascii?Q?hwhZb73qX9nVgVVUTZfpb5aVnIP52MJOvrtnRo4jjhfIaBKLi7MQn49K191x?=
 =?us-ascii?Q?Sc7xCQ13sOV1Z79snC+YqxTqwHjSgDt8xnwK9eonUlmOo9kjUMYHEep9qRfg?=
 =?us-ascii?Q?W/9I3pTURKovGqXORZ1SzkqJMK4JmNPgHtbP7LwJSEbvzkuwTA3AS0S9HyUe?=
 =?us-ascii?Q?dh/hizyTtvkr1uvZAih5jt4paS4QgDm227DktMeIb9xFzZSZb2WbCocT6SdK?=
 =?us-ascii?Q?2a2MvWp8eZONTISHjyM4Q36DxC3dnXk356UCZI+PDIZuamo5HuSJiiPSCwR1?=
 =?us-ascii?Q?PjqVEMsPtzjj00mUVcpVh6F7lJUH17ad8fgi+nB2dE9km2gd+i/RcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XS57Wb2GTBTGavpn+vC+H1l9rf0uInctymws5T2cfy67RUQsE78DkTEQGJ0s?=
 =?us-ascii?Q?ElAwaUDdtAkSyWjehr+ng/tV8/CnGMPQVUlO3fT1ZdL4J1pi8OKhicV4/ugh?=
 =?us-ascii?Q?84vTydv8tEHG5heWSfYUZR4RMgzaWD/gUf4WTDiGt5Sob2xYIRwOnPyhFLtt?=
 =?us-ascii?Q?mfR6U/umQr/VcBhdQ9qGho5+x1jiYBbYa0pgW09T9A/ZMrSXxxQKLbSMYWQn?=
 =?us-ascii?Q?I9JctowVa+rdylBbdEi3K3QX8aHwmipYaiZiqknzho0tKqtBGf+GrX00C8RE?=
 =?us-ascii?Q?MLyCO8f6OQMBrbGlrwQx1W2ztJcKRLPOkd3cbAsm0wOc1Sj6LI6sV1aNKhI7?=
 =?us-ascii?Q?j1/Slfklc+I+pi4N4Jhw6JEnCxoyjjk8SyAZfiV/b5CEs+L/CzIyR+1PO0xt?=
 =?us-ascii?Q?/sn3pHcIO2yJ9zQM2WiE9tRrSonrc2y6rZn5F9yAcaSjKV+mMLIBfCMeU95B?=
 =?us-ascii?Q?knjy3uMOOiod6b1W/LINifpKb+52lt9/DI0cc+XwPWxAEKWOO8oYZWpfxzbt?=
 =?us-ascii?Q?joaGZv0h/GeBl1AaDgscDzZkgr6qw3vE1ejk/8TFV6Mq5wOKQXXKL9JBgW46?=
 =?us-ascii?Q?49rtjY6sV4CTbEjfIELFk9eAyXpqe6sJWS3ef3D8ylrhnvxqPN2CuwQd4iMF?=
 =?us-ascii?Q?q6BOrLob8B/Acy4jQzZ58yuIm/p6qq/QdyLo8ebXdXfCk0usvWUNX3mcfhdX?=
 =?us-ascii?Q?bGwloaDZVz6PCiBhY3i4qBJbaBzpjoqHfLRSnBRz0lNfv8Te7coJ5UvjSCgW?=
 =?us-ascii?Q?bLsOuhUzcjXdHwapIQY0iRwBbfpHU8YDALG/zq1ExEsYqpFAuEPpb9b15nHH?=
 =?us-ascii?Q?3i4NdUUfailPnskMK37imOlj8Fd3wjpwbQ8lnsiJJaQXgEwY4Y1iUUUITYhm?=
 =?us-ascii?Q?Rjs+KXftWI03DiorJFMyMrfxpwxUAuK7CUof88oRUWYIvQY9xm/kqvlFd5nL?=
 =?us-ascii?Q?QReMmpS7NzTuc/Oy3L6MDkEOHU1OezLYAPU2MQNnYbwGegnnnOYRU1hSkF6n?=
 =?us-ascii?Q?s9BHUjIutQvpAktTjLQ3bdbrZjNWG5/8T7VZ241WqprxTixSNiP6oeVNacMz?=
 =?us-ascii?Q?EtztLAd+B6Ex4Hf7+IlC+WkXptS9uW93J6MvJtK6iC9VxGnso/cF4Q0IGcH2?=
 =?us-ascii?Q?7/g6rUI0ifCpDO3eZV8ep7qKlsvc6Hv+iPQCDVFIjs5gdnYQrJT1i/UM6+m/?=
 =?us-ascii?Q?T0ZZ/Km+fCiMRjYWHA8X3nX+G/0v1TYAsY341PmalEmk4Ukgjs4d1GVxap7T?=
 =?us-ascii?Q?dEntaPWqITwnBWd9q461p5n0wh7VO9ftp7GoA6ItEtz8bSK5+dC1J6UtaJiz?=
 =?us-ascii?Q?t78uYnyMlmlF0obaXB7MYuD2ZLKl9VnaXmyqBdFjvtmi+YKAYj6uM03k5Mfd?=
 =?us-ascii?Q?BtsQsGQKIQMZ/5pCHzv2ghgWyHNzvkj9nTv7OdNSLNOPTg0dpYuH1fKKCCV/?=
 =?us-ascii?Q?7cFSuqT4mBjOgY0QuIFJjVQiKRRB/xeZ85fPAe1GvpQ9sfHBNEa8NIGuHfge?=
 =?us-ascii?Q?PwEujPoMfHf1UvSNYlq7vYICPU4EPbs75Gy0WzccDWTIoAiTjvHU9xa8jimT?=
 =?us-ascii?Q?eCfpVEgiDoRHRNlw48I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70409378-ba3b-49c4-f51f-08de0d8dd96d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 15:00:02.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1/j2wx/Cu0wluxJLJWgzz+2C/VfrLQNUG9c+CuAzSDa568W5RVojKT11OlLmMjMOU5/qeo+NyjxTWmlYBZiZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8395

On Fri, Oct 17, 2025 at 04:20:19AM -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add documentation for i.MX8ULP's SIM LPAV module.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/clock/fsl,imx8ulp-sim-lpav.yaml  | 72 +++++++++++++++++++
>  include/dt-bindings/clock/imx8ulp-clock.h     |  5 ++
>  .../dt-bindings/reset/fsl,imx8ulp-sim-lpav.h  | 16 +++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
>  create mode 100644 include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h
>
> diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
> new file mode 100644
> index 000000000000..fb3b9028a4c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/fsl,imx8ulp-sim-lpav.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8ULP LPAV System Integration Module (SIM)
> +
> +maintainers:
> +  - Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> +
> +description:
> +  The i.MX8ULP LPAV subsystem contains a block control module known as
> +  SIM LPAV, which offers functionalities such as clock gating or reset
> +  line assertion/de-assertion.
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8ulp-sim-lpav
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: lpav_bus
> +      - const: hifi_core
> +      - const: hifi_plat

dt prefer use -
lpav-bus, ...

> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  mux-controller:
> +    $ref: /schemas/mux/reg-mux.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - '#reset-cells'
> +  - mux-controller
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8ulp-clock.h>
> +
> +    clock-controller@2da50000 {
> +        compatible = "fsl,imx8ulp-sim-lpav";
> +        reg = <0x2da50000 0x10000>;
> +        clocks = <&cgc2 IMX8ULP_CLK_LPAV_BUS_DIV>,
> +                 <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>,
> +                 <&cgc2 IMX8ULP_CLK_HIFI_DIVPLAT>;
> +        clock-names = "lpav_bus", "hifi_core", "hifi_plat";
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +
> +        mux-controller {
> +            compatible = "reg-mux";
> +            #mux-control-cells = <1>;
> +            mux-reg-masks = <0x8 0x00000200>;
> +        };
> +    };
> diff --git a/include/dt-bindings/clock/imx8ulp-clock.h b/include/dt-bindings/clock/imx8ulp-clock.h
> index 827404fadf5c..c62d84d093a9 100644
> --- a/include/dt-bindings/clock/imx8ulp-clock.h
> +++ b/include/dt-bindings/clock/imx8ulp-clock.h
> @@ -255,4 +255,9 @@
>
>  #define IMX8ULP_CLK_PCC5_END		56
>
> +/* LPAV SIM */
> +#define IMX8ULP_CLK_SIM_LPAV_HIFI_CORE		0
> +#define IMX8ULP_CLK_SIM_LPAV_HIFI_PBCLK		1
> +#define IMX8ULP_CLK_SIM_LPAV_HIFI_PLAT		2
> +
>  #endif
> diff --git a/include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h b/include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h
> new file mode 100644
> index 000000000000..adf95bb26d21
> --- /dev/null
> +++ b/include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#ifndef DT_BINDING_RESET_IMX8ULP_SIM_LPAV_H
> +#define DT_BINDING_RESET_IMX8ULP_SIM_LPAV_H
> +
> +#define IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST	0
> +#define IMX8ULP_SIM_LPAV_HIFI4_DSP_RST		1
> +#define IMX8ULP_SIM_LPAV_HIFI4_DSP_STALL	2
> +#define IMX8ULP_SIM_LPAV_DSI_RST_BYTE_N		3
> +#define IMX8ULP_SIM_LPAV_DSI_RST_ESC_N		4
> +#define IMX8ULP_SIM_LPAV_DSI_RST_DPI_N		5
> +
> +#endif /* DT_BINDING_RESET_IMX8ULP_SIM_LPAV_H */
> --
> 2.43.0
>

