Return-Path: <linux-kernel+bounces-865023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DEFBFC06B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52B5188C483
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42073347FC9;
	Wed, 22 Oct 2025 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rDb1SJD4"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013065.outbound.protection.outlook.com [52.101.83.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC1341661;
	Wed, 22 Oct 2025 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137796; cv=fail; b=Q07FIyZt1/pNsEMzlFHvHzhb+S8X/4GtPrlvXfaRQ2K3v7LlbU0vFnCrJAQP/IpZsL6AEl0qQ3mC7unh0wvO54ewilkgx3YhTy/Qd4hXKxLLaiCZVAn8syThkzSIhU2DeENms1n0whJ1+iC96heHeLYZXAC2xidAP9/WGQm2Ec4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137796; c=relaxed/simple;
	bh=x+7Z3iaynrbJAEile5xJ7OLlTzeO25NDwMhFhg1xiiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cF1D8v6A9Z0C6Dv1mThfubCWgjP+NIl4CKnbkEVCmT4wKIKf/cKXfXfqoHE8qgppB4FoeU2v/T4v6hY1/cmu5js4hRTIDE3LBS/iBRNxJtIs9RwTVjjgtL0oB2MB5JzjYp6RGNiKhj/IypmO8vgF7CIeqttBpW0wEIdmzj64FNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rDb1SJD4; arc=fail smtp.client-ip=52.101.83.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkgPyD0Hh9TzfORRO8BUz9o7tqGUrD0D8gFUYsj6H/D5o/ZTsiMlzMiOD9YPx/SWK7A7cLvtKL51QOBpXCfaqKSaapzJu1QHEFzqJjvy5z6VfdgmBxLYpQm/1NU4VB+gyfNBlXcNUrHpp6m0qjnMjco7cWL6rjl60OQFMg3XoAW2VX86v0Kj8YQh25imIKsQS0PLzpj4pZNHzeZdVziKdqN1fr3BAOPhOpJ67VmzfIbR3S7NG8nmGbUg+ZOW4GXqbmqyKmcuAbNIO/ao5/dhDuQ4tNhDLn2MwGKLK8bG1iVvLfo4/Q9GWvg7WXNJxx2jdfff4uQRRcbJn5SAkG8eAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gK9gMw0tq8GSwmEVT7IN2PN5lAbDLA8eTkkW+xFntNw=;
 b=pUWbdg+L1CSrjFtC6cnhSdPzYjkwspSHu6muwNr/vFWIEQQgmrFB27PW8ipEjyySNDTNWXRZ8BiyPjzKdt9Dl0rIhdTJHr/snWwbDAcMdtZTdUCFr9Z7uSW0/pmFdAQqD0Hj2DkeceKIruR1ubdJrLyTsYVHHPBRt/wut4bppZXuI6yhEIlXGHo5tVaVC2JQfKqMzPXNOUT+PnfBzECpS/wY5w0HDAbZNmsxxAlxR+X3yMqZZpXgx0vtsazU3LAwxn4/08IyYDbaEV2zrcrF/G9HMAhJXqtve0zBAVOcEAre7L48LDHKn5lN/mSZfL0f4NuSfr3Lh0RtbW67jldudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gK9gMw0tq8GSwmEVT7IN2PN5lAbDLA8eTkkW+xFntNw=;
 b=rDb1SJD44WIw19D+eqBaaMr6ju5f4kApu15aliG7+RA6fUTe8uakebW6NKhn8By7Imq+rCp8geUQR9yr+JAlfyl4RELXADkElKl5rLhZIhwDCw6TjB9zlsW7BDlTFD+lwb9ySsXniTAz2Ax4JTqQh75ONnDe5Oi6ahx7dXBygWCSIkKV0YXrjESujqM4+m5scHL1dz3Z8H2y3Fn/clA4ZwH8W09AuXm5Trz29nQ8tWbX/GO8od2Y3gZBL4hufwP0GVkZZm6cKs13wc4XApMTQKWrskoaYXCdmUA75bgS3EIKvoDVPRNykuK10u+7YaHBoenhPB/sZxOHPXHhzt4RWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11530.eurprd04.prod.outlook.com (2603:10a6:102:4e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 12:56:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 12:56:30 +0000
Date: Wed, 22 Oct 2025 22:08:41 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
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
Message-ID: <20251022140841.GB11174@nxa18884-linux.ap.freescale.net>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-3-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017112025.11997-3-laurentiumihalcea111@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB11530:EE_
X-MS-Office365-Filtering-Correlation-Id: c1eb435d-85ae-4401-3ca6-08de116a6b81
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WmuXzur68/2+FDRshHflJWfWcWSp7byPiovJpAMedE6GsDJtQrfiS5pwMcEq?=
 =?us-ascii?Q?CY+B6Oek3rnZk+Y/92ymMRZv5KMYS+o2MfQJxZuVNhu2iJPljPvcbccKzcdN?=
 =?us-ascii?Q?ypAuEwWb5slm541wuQZ8TABdWeYqMFfPpWPM12AO0xYCR9UyUM9MtAZ9+dVY?=
 =?us-ascii?Q?FoXXFygXiWgYeiyZrwgdarkl03pBZMTmLotsokxM00OQRAA2kyg4k6m2SmaV?=
 =?us-ascii?Q?/R7EHuGVTL5Fx9Qe+jSLruCdoAuNIfH70NWncxN+cGyVz4onBprAGWZ8fVMt?=
 =?us-ascii?Q?MTJ7iWUJjfo9CZgglAQ0ddKzio/d6a1cv6sNNYXEEZmREY6c+JVjHUgDYqGn?=
 =?us-ascii?Q?YqsHWPjhDgbRuVsnCRrsgCQk33VTWgLT9aNHJVFwOXLqO5BbYslC4dftnLyV?=
 =?us-ascii?Q?W2+ZfszOtDH98aKk/zr5LUJKiwLJM2LcJFurQu61a+CtIyY5+73estmAs1iA?=
 =?us-ascii?Q?FM3wVLJUJ8+Uy9l5Mbh1ZIm5+FYIOgS35hOzCDcdb+d2M8MEZJ9nIMhzb11F?=
 =?us-ascii?Q?oCPU4ZBYj0iQazuAoxThmSCVm5BCds9UEDP0GQPFK8IV0eW8JVxVRBMbQNGT?=
 =?us-ascii?Q?00DR48PMHw05h7E/9jWyAiKbF9xISqd7A9UWEUQGRcleK3AI1b5dU6n2I/VT?=
 =?us-ascii?Q?MAnzjDJSwIcey0wCZZTiSlQQ7YDxfk7WMvDXPBLRgZvP0xD0RBGeW8x1WOjN?=
 =?us-ascii?Q?zS2tTQegEz5RBRE1nHS/aj54VTF3wYXaYB3BUoFl8FXhB80/boO7J65HeG0J?=
 =?us-ascii?Q?AsZRXwe3E5GTEwK/IeMFXPia5umYiDJAukKsI+LNkuLO/b66ZgprnHrlkM7E?=
 =?us-ascii?Q?4xuirr1T8FdqMzJzt4Ls6FjZ3OVggCg1+PFQmGlNxJw/fb7bVQXpwnsMsUa1?=
 =?us-ascii?Q?5JwgN+rhImtqEDaYRCx//nzVbBoi7nUGz5CancAmdfVzsfr0rhQMBw2pRZhI?=
 =?us-ascii?Q?eiPPU/snSp2H1uRJVurOWlQh0Yvom+AmLIlkSs1uTMtxTBIcduENGfqQmz9W?=
 =?us-ascii?Q?/PScaAKYDFxRwfN8GbQWk7THXKJ6bUywIYlzZB51QzonK4PSOEPXB2aGyU3f?=
 =?us-ascii?Q?swiJlbbo58f39Ap76gjFXKRwqShrMFrZY/To8643MeRjFiPMuqxWS6Fh0QW+?=
 =?us-ascii?Q?znMXuIIgezECEtnrjqdrwbK6td+Jp8XzMiViWBm5R3vuHiotMvmCmLyDr4Hv?=
 =?us-ascii?Q?+B722qNNiLHGym5eHfSnBUNXiy5A+bCwU8xYwTjUi2BNs/4oAjZLHgQVWoup?=
 =?us-ascii?Q?YWQqdnlwjZ34ogLBiWAJta71uHZr6UQTMFX9hB1jL+rUpOJnI795jzJ3u5Q8?=
 =?us-ascii?Q?Pm7OYxTVySGQGoULLAwZNG2qwrTNHHeG0DC88fXSdl3J4guuOCIFmmXaMpM+?=
 =?us-ascii?Q?3nncNlRWIG4tA2cg7iI6Pt0jEoq5AGT7U4ykC+HSXtdFC1XNuec1myFIy+6p?=
 =?us-ascii?Q?aarMiUv1yFYhqJOucsIYePEYBbnkIq1UDeaBeWoT58BAFtJkcLb6W5JSatXY?=
 =?us-ascii?Q?I3iLwST0nngwIlH2xPaJrCjrGwdOdU+zmSPV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UKwXkqpRtdMOcfbqIVDtb5QvuZlX7fk92Gd4+hetbTqz5N2fCl5mZ3qiRAfV?=
 =?us-ascii?Q?+NUHSbsTeEC9nnMfOaMBdmJpHQ1s744B7mG5Y3/FzOcNUcSoRB2TJuvgDXh0?=
 =?us-ascii?Q?KX75Jx6/IltfqeH4i0CL0EXj2cAuA968w1jJDNEfz9pgIX8idPGASXgk7r2r?=
 =?us-ascii?Q?wMr6PXfMZRPFGYGv0y4OQ1Jd5aj6OnXYkWL2vO8pk/lk7P/2LBaMLlyPlc6F?=
 =?us-ascii?Q?Q0yFbX4uzweDhXlnk2//l5Jk5JlOuCdl7J6LaiE6PGCTs7b1I+YsMT7cz2aU?=
 =?us-ascii?Q?WubT9Q26vtleJVzKjK4ITYDlzgnjNRnZlQVAfQHfmXzShjKMSCwc1JIpcoxr?=
 =?us-ascii?Q?i3dLvcwkzxqxH+soGZ2tO4lRzXGHvpFdAVsSYQ28S4+l6uI6TUYVdHbBHwrE?=
 =?us-ascii?Q?ZCW+iR9tLUNMpPpsYHueISpC4U4UoqzMOXHaCNPCTUf36NC8WUuoHn/fs0Nw?=
 =?us-ascii?Q?JuuLdQ/oLgvFaZYHA5r/YmpN0zH0FgVCLtycIZVTwQstBVY2ZJ93WptlN3fr?=
 =?us-ascii?Q?Kv5bkOhXsEUyDJi5TgiiyeNghznytrxYLwr6O8840AA73u1QapajQKGsYq26?=
 =?us-ascii?Q?WuhS5KvHmxfQChsjxNu/oGlWUpPLo4Wqb9LJhze2yi48wVvxQlK4GF1SKtnv?=
 =?us-ascii?Q?DdTdzGuQ11uOkPuZAVZnJQR46J/MNz7T2smIGv8eu0JOaOPem/DylrLb3N6n?=
 =?us-ascii?Q?am3kI1u20G5/gN9qQpMCP3347Quk1UWQRDJRPJx4fpy2XrXeWDtLQ3ofz09u?=
 =?us-ascii?Q?DadUdSA767pcXQMUYwOauebF3tfOX9DLdWQBvfXh6yVfwY8AwxjNN/O72Ch4?=
 =?us-ascii?Q?nnlVGcCnHw2BwypAzOGLJvBF4+TM2KPAn9L2LG8pmQ7Cfq30PDxXU54JqhPE?=
 =?us-ascii?Q?DcsCuKq9GGwfkP4c5Yg1d3u5GGJeKKtxpLT7vAFAZq6zEviKE/CrqQ3xJpLE?=
 =?us-ascii?Q?v6z83Hu+CqG4sjExhdN8+kBFZP8B0QdKFoxHK6TIaZvGhSYQ1mrF4h83QX5o?=
 =?us-ascii?Q?tkxhEc8SFkX7l1N9/kMKFV6mHQTKR4vCwDHzIiIiCOgmYbHD4QfA7GrapkO5?=
 =?us-ascii?Q?Fgd0Y2+3r7oATtZH2ndichoqZeIJsJuYXG1x/DbLQ9F7LhLM1/wPJ70HpiA6?=
 =?us-ascii?Q?RhyVhPk/NCx3mUUdvTva+2L5PHde7KPRG5N4nfarGQzhoF8vi4A6gS/wjF7S?=
 =?us-ascii?Q?3T5vUu7B6LhSa1rlI5/k7ZWUPKSiYJ7gkPLGVPBa3/8mfcFbqCGj74Kbi52e?=
 =?us-ascii?Q?NOG+zfBoC05Pq2zClibQ9I8zXEh9LZraRMx5oRzUeaXH7QAqikRH9c7e4Z/+?=
 =?us-ascii?Q?lrgDCswxon/dBN5ESjqGuwgdLFVqLdQ5S2aqkBBZiuQRjaUjBccFLzlBXvNZ?=
 =?us-ascii?Q?APBeUllhKERW2g77aDv3wdqTEafjp+iaJjFrtJIYUTF8tQkB7ZKNcNOzI9E4?=
 =?us-ascii?Q?ZGMtoST8SsP1kqIQ508ieSdGrGMUlNHdbAPYFxo6pK39X1eJwIRs9LvmZPM2?=
 =?us-ascii?Q?RbGO7qmJ/0iGYMQl7MkXGPoVPPv4ZRGTosfdIYgREPBPOR3luBwEX3uvx7Ah?=
 =?us-ascii?Q?Ir+EchDDsoJGChNtIQ4vsyykKyMT9Vxw/rjnS4bE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eb435d-85ae-4401-3ca6-08de116a6b81
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 12:56:30.3615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFo/8isqWJ59HmuQTcRQloDQKSzWlCtZoSGv4P39NpkrWjFEG1H0g1En9CsMEna3/r4QcENWJYpVm1twQ8UE+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11530

Hi Laurentiu,

On Fri, Oct 17, 2025 at 04:20:19AM -0700, Laurentiu Mihalcea wrote:
>From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
>Add documentation for i.MX8ULP's SIM LPAV module.
>
>Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>---
>+description:
>+  The i.MX8ULP LPAV subsystem contains a block control module known as
>+  SIM LPAV, which offers functionalities such as clock gating or reset
>+  line assertion/de-assertion.
>+
>+properties:
>+  compatible:
>+    const: fsl,imx8ulp-sim-lpav

This block also contains QoS registers, General purpose registers, HIFI
general purpose registers, and others.

I am not sure whether need to add a syscon fallback here. dt maintainer may
help comment.

Regards,
Peng

