Return-Path: <linux-kernel+bounces-858242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FE1BE95D6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB913B9A61
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63969337111;
	Fri, 17 Oct 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LBVRd7IE"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7EB22A7E4;
	Fri, 17 Oct 2025 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712984; cv=fail; b=S5iUHC4sX1SDS/QXVkL30coZQmRVOMRuWjWJAqe/2L25UBVrJVVD2GGXkcQsRNo5+UDf4l5AaltYrr9RCrZaReKVuTy7XmX0fMjtXJ1AZNWDGFQK/N6/z/j/GeXjB9jXkVOnSZQsCeoM70RrNuTpF7EkUSSOIuA/U3vBsjdatTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712984; c=relaxed/simple;
	bh=fFQ2B7a/fyfaoXkzUemm8+dVZwQOnQeDkoo/cIYVPAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R1FHX34M3CffkYJVv465XVVJOrPTBkfbDpWKdOLjUYJ3THvVpZP48G2aXIrQuTpOMfkoSTCjvMPXa0iwBunagWvTuFBbbzYRL3AhTNnV7YSUCWDzmNbPOp2jTJLCDCB+6DmxxqST7guNmxt2xFMS8+2dN9rIGwSoImnBMt5iNOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LBVRd7IE; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNnmqi+bgKgrn/sLf2X72r80a8NUtxD0bs+GkD8SbItbImIJomG6RVmPnP3gEzB38YUN9ojzGmOm3IAEAJ9FpFRxD35AqW9FC+nRGhXX8RadHLj1RrJsgXM0gEVTVhMninxX9DDHGkQYoggXt5NykU0ZXNu3zFI4dcRikAEpRviYE0b3YsCe9AcdyesXILYIx6AUtK2HJjpV1zZpGew2pnaKrEQ7KcuqgQB0QIXnb7/HXEAnBLmCvXsbIPjaqUSvxp3nKkOUefA0StvMmMbOF6JfWPjgZbTjP71RqETNaxykXEowdtad3gti9icHMCHQpebb3CjPe9bFdjQUGj8Kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF+SENX2a67K1jYwQ3NlVUQ11wwdPdPKFnK9W/wkxr8=;
 b=UGI5wpi6Mrm35i20NVPC4+tjdMu72JXKPSLhdc+a9owDI8N+hLt/4Df6SIW7iu7NKbIj9qHsDfkh2kuKxw+6kEHIVzs1PIRqO672qgpW6e7iJcszCV08iDXzZYxguKoiO4zk/jvVQi80BWRaJSUQY5DycOrrNChFnr++XwVSDx8dExDNQe0X7Uco8hbJWFxMhcpn8z7iO14GO2XcGjT4IxXHKTCb5EO1Oo59e9a8VE5WMBvSjOew71rgKRWS9UH3yziAB8VCjY+zWy5izLkxIrzXOSc8z+1S15q4apd7otZ/W9j5eOq6bqD5pdFgWFQx9hJzH5B189LlJPYH8im8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF+SENX2a67K1jYwQ3NlVUQ11wwdPdPKFnK9W/wkxr8=;
 b=LBVRd7IElTaAno/DUo3EywoNOJiVE4p9UdNUkurgQdtTra59C2QcuWws6gEUVLYXzJ73bkl6CpuewWVuIcOQ6vzZfAhwJaMdoD5ZdMMio7g8hFWbhgK0r+Hn5taWzLHVZTKjur7odvLoBpWt8pvEVN+h1uxD1lzAj2NDmQwGRdChO2BH1qWfq8tp2m4N3H4l8aWUQwDOd8IjWE9IIEYGkLyz82A5+pJD2AsBcj6ZSQOCL9Sic+XauQzCNxsbEFK7iM+MyFJvoTkoCKfDPZaNXKsNYyKRRCjpyh05PK28ZL72NKmoJF7O5rcZbqW3NLOTxFzB5gcG5R8mNCwqt2WBeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB8395.eurprd04.prod.outlook.com (2603:10a6:10:247::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 14:56:18 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 14:56:18 +0000
Date: Fri, 17 Oct 2025 10:56:10 -0400
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
Subject: Re: [PATCH v2 6/8] reset: imx8mp-audiomix: Extend the driver usage
Message-ID: <aPJZCv+iG6cuxsj4@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-7-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017112025.11997-7-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: PH7PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:510:33d::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB8395:EE_
X-MS-Office365-Filtering-Correlation-Id: c02c4e16-6a15-4914-4d1e-08de0d8d5419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9olDhSAyTl13ILeRg+W1bO6MR5ilyv3c61Jjjnj1K9+ghbgiuUa4+aK3QttN?=
 =?us-ascii?Q?tQsWQ4w9QSPeluxDILouS3FQBloBvhdUF6TBbLg+6SkQXRvBIszIQPB5H/GL?=
 =?us-ascii?Q?+v6N8MiZlTInXG/tsvEeTC7Ac+IzJX/pkEkkwdbnzPH2nQeO2W9FuNFcExj8?=
 =?us-ascii?Q?7U3ZN6ZWxueQnILmHPF0nMweyfyNP3WkuMQ/KuF8AZ+Xdq39jIIrrYha+YKe?=
 =?us-ascii?Q?Eh3JY1lTf6QC0f6T0nxH8Ejqo3s/tOgSruh+4oxg4FuYHnKwSnpC3SBdja/x?=
 =?us-ascii?Q?T7fZpdyXa5naVabO4kcVO4TMe9DYY8h+/q4rJoh/qjnzAUYNl63sU0qsxMJJ?=
 =?us-ascii?Q?0iv+/F6NYdBOjLCNm7HU8kTow84Oo0kJyJcPMuRC/E6PtDwtJxJSPJryXAHa?=
 =?us-ascii?Q?r2dEPlJ2LccJJ84axAvMzMXGLSh1HxLu98hF6qZbCClvIMoRBXD1gmLVfTw1?=
 =?us-ascii?Q?+Ta6oDup6ObdJhpYnvZ4htl/IVqnuklb7J0TYFzWL5wt5IhFTjyNnNg4wuRP?=
 =?us-ascii?Q?CXupYR/CIga4SHbAuxARyqTg+57vqZBJFZWU/TkF92tw5kWcB9e71HdsGYv3?=
 =?us-ascii?Q?gPq0ub170K3ZShIOS/ypYoTxwr6OlI9R4S4VkoJPUbq0MwtVRsWdtp/TcSDi?=
 =?us-ascii?Q?WKiwiEb4SxEASc7SGG+EgpWYaG5jYllQcdYpRQgz7GfcOmA8oNxSYkTTLaT1?=
 =?us-ascii?Q?KeXV4NkUVA6EYrjoMK9RZJIgHj6BVP4SfC9/gScBEsUOS34FGB8Cenq0l4lv?=
 =?us-ascii?Q?07/CPSoNH92vAkSMckOHwaTfhxAhq04HReFZEqTWmW0tN0fNiFfkyigINJuf?=
 =?us-ascii?Q?p/XxY+HCg/8hu43aSUduzFkW7IQIhY0e4aRNHVGhusH01wnmsoQexg2nNSYK?=
 =?us-ascii?Q?sOwNNLBILhNOcxld4ZmAYAy4i75hCnH2Ds9jQeqk54KtEfw2HWss4pdzbfT1?=
 =?us-ascii?Q?8c0DerDer4HHTWV4jjAhoRwI7kLUMamuXCpwnsJZeE9lvnXkLw8YyZON9iR7?=
 =?us-ascii?Q?UKjmjVOpVXqQ4EIg5CRt/CV2mzlAY6CEDe/VyhX7VfUxMTlkaebpG+Z4InUE?=
 =?us-ascii?Q?V3MC2SD2B+j2aOIJsvY3gUWrYz+K3gOKVeqgxADuyR5t6gfQWq/Cvwcx9hSU?=
 =?us-ascii?Q?0Kv1o7BTeEG/hGHTu9LD/GjeALJZMv4qUEoaUco1bxx9Y++pgYMi6D1i14gU?=
 =?us-ascii?Q?C8pgXnUFld7ucBa3T+ck+IvPSoBekBzoIv+cwirAGPB/+uPmzesBb6VgvL0H?=
 =?us-ascii?Q?aRVGIk0Jdy4mWapX7iAYH2YPD1YlaZnEgfXhxF7MUZZ/0G2bGanCXPajkMSg?=
 =?us-ascii?Q?/ts7UtDAjkVPsEwuDA5Cfz6BDeHTFkR8RmT/oY6RZYmXM7k60G4/dWEJw1qC?=
 =?us-ascii?Q?nhepHOk8TYYS1p9D1gqw+QfSrldgKB83n5s0Df4UET6axJ3r9PGLmNl1unSI?=
 =?us-ascii?Q?VbcA/g/xvRaOl1Gx2PvQnbor4ABA5sZA90AUufA1AP24J94uAyvkpthmbudJ?=
 =?us-ascii?Q?50Axv4nSA1Ekpb+de1Q1xy5RCLzlUi0XlgwH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2eBdmJE6mYENQDQmj5PC8kxdKachNdt8kHXjKraDL17aRmp6GmzBuRI4jpyW?=
 =?us-ascii?Q?IJtGYVEL79lbpTHteDQlSKhYpU/Jll5gQRPiziyotVPNTvjVU6+g4gH31RNI?=
 =?us-ascii?Q?MO+iqV9p9NxxvwHykf/JK0NiMrdnKkFmJEcoYwvsSLojV2Uz0dgcx1n7RFJ5?=
 =?us-ascii?Q?aK6LUNSOp/08rEpHla8Ws4mlJzmdA6p3lBU4vsErkMwiTNN2q3GJX9u9AeV2?=
 =?us-ascii?Q?5p4aRYhjHgbzzMb1Scrnf+bXdOAmEMVNx2zmOO4luLOv8L7zkCXdDXYxKlfM?=
 =?us-ascii?Q?z9B2r2TlyM14zJzUYOkVsp0Ev4ftnJiml+jzW0JaWF3wlbVaoXWUR9p4QpOg?=
 =?us-ascii?Q?LHWAOXvyk5OC0y0WtF8UcKW9ppyJWP6xJiPNcKyH0ubnRdMhqOM61kmOHSM0?=
 =?us-ascii?Q?VNrVXhq6iyg592f8QkzWJJ4cmpMCnDikoEgvSE6ff7TwHqO9hobeyA6n+lmM?=
 =?us-ascii?Q?E+qzQn/MF6xAKouk6dyf1rl4sa8Dj1UqsYLTsrKaiIQyaYji65JYAXJbDCqc?=
 =?us-ascii?Q?h96o98cvLC99UUc3RpXxBJ+dLha9iRrIAEajkBLWZXfcI9bR7Pyde3U/mvU3?=
 =?us-ascii?Q?nyvGtnOV5jVED42mJH4fDC6KDALQT8xJmpK0sspJMTWZiz91wYr1Cm00UKU7?=
 =?us-ascii?Q?zqNdwWek2CNWiR8g9Vjf1Ppmf6avsteYmqxKs4FWqQqMAtS/Zlwt1D3V8mnv?=
 =?us-ascii?Q?eJeO1jeI3wWWG7NkMxFG8iFXCh2yRl5sMC8ZQq0qth571BR36SlCSV1saM1G?=
 =?us-ascii?Q?Ku9MQsqF+CGgAzUom0nPoe57lQ7IjLfg2pKRJ95XP6LrWFbdCtfEaDqHn7j3?=
 =?us-ascii?Q?8Mgy7XLmA4r0zmC1v5KTpJvxylfS0qw/wc1f8UrvgrMxm/SsDKQxzD7x7nFt?=
 =?us-ascii?Q?sWc1kSH2MGceOVT25EFzwOOLCaqRZAVXkjCl+czGNZ4dV+cSbT3aVzLrh/oL?=
 =?us-ascii?Q?vKW0r3bz3IxBpF2Fx4YBHj2QuUvHrklWwHEpixWMoxEu5RI0yaLc2a9FkHcw?=
 =?us-ascii?Q?YpXwZRZTbhAlQilAb+ARl0SKzFLQvx0FfUAkbSUzP1WSs+uKYAmJJlkkh/i6?=
 =?us-ascii?Q?ZHs/khHSTVGBgDMvf2ALJpiJ0HNYcxZsaAwNu2QCz5Qj95eoEClo6bCwZFFY?=
 =?us-ascii?Q?khiEoZE+hCnKDfyUBZMQ5icSMVPPOsx7VDXOk6QKY20jerwnNJ1zKN9TZczI?=
 =?us-ascii?Q?UUN+om+w7M0yJOSRV5yXXuHRUpIbuHUEM4DHcMhs6+5eV+Lyw6TQACRq9KTg?=
 =?us-ascii?Q?f+LeNp9UHortnp/8otmU4AEkog6g7rukPz1PZaV/q/ZVNvK6lA4LMkFFZUxx?=
 =?us-ascii?Q?ROz5GbwcFrkyPk7sQTlSV0zoEaQh3MAgguOc8u85oblQk/SIgowiFKuK/MT4?=
 =?us-ascii?Q?NTiQ8zrzSy2Z4xOqNSwrbYZOTAsAwlB4MGQrGlOXXovuCBP1+NXz8yxganpW?=
 =?us-ascii?Q?MLied7/zumzoKksMILv0N83Ln3BSZwy75nsPOThBwsKE9kHTaJ4mglq1CAXc?=
 =?us-ascii?Q?ZphqV4IJN3N9cFGyQcbPUfql29LyHN5rrbzcrzYAr0NWtAEo2JIQ9LQw8avu?=
 =?us-ascii?Q?XSkQZThMHihUp8Nf05Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02c4e16-6a15-4914-4d1e-08de0d8d5419
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:56:18.7922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hitwfR+bdIXqod1ecPvWHaVrDDb3TeUBjL6/QfXbb37e+ypnMq2GrOAb92rCbQV4QebFU11El2WWa5XQsqqeUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8395

On Fri, Oct 17, 2025 at 04:20:23AM -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Some NXP SoCs integrate one or more, per-subsystem, block control IPs,
> which allow users to control the assertion and de-assertion of the
> reset lines tied to some peripherals present in said subsystems. Some
> examples of such SoCs include i.MX8MP with AUDIOMIX block control and
> i.MX8ULP with SIM LPAV.
>
> Some of the aformentioned block control IPs exhibit a common pattern with
> respect to the assertion and de-assertion of the reset lines. Namely, the
> user is able to control the state of the reset line by toggling a bit from
> one of the IP's registers.
>
> Linux can take advantage of this pattern and, instead of having one driver
> for each block control IP, a single, more generic driver could be used.
>
> To allow this to happen, the previous approach, in which a single reset
> map is used, is replaced by a per-driver approach, in which each auxiliary
> device driver holds a reference to a certain reset map.

Can you shorter your commit message?, basically, you just add
imx8mp_reset_info for difference auxiliary_device_id.

>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> index c74ce6e04177..c370913107f5 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -24,7 +24,12 @@ struct imx8mp_reset_map {
>  	bool active_low;
>  };
>
> -static const struct imx8mp_reset_map reset_map[] = {
> +struct imx8mp_reset_info {
> +	const struct imx8mp_reset_map *map;
> +	int num_lines;
> +};
> +
> +static const struct imx8mp_reset_map imx8mp_reset_map[] = {
>  	[IMX8MP_AUDIOMIX_EARC_RESET] = {
>  		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
>  		.mask = BIT(0),
> @@ -45,10 +50,16 @@ static const struct imx8mp_reset_map reset_map[] = {
>  	},
>  };
>
> +static const struct imx8mp_reset_info imx8mp_reset_info = {
> +	.map = imx8mp_reset_map,
> +	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
> +};
> +
>  struct imx8mp_audiomix_reset {
>  	struct reset_controller_dev rcdev;
>  	void __iomem *base;
>  	struct regmap *regmap;
> +	const struct imx8mp_reset_info *rinfo;
>  };
>
>  static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
> @@ -60,6 +71,7 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
>  				  unsigned long id, bool assert)
>  {
>  	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
> +	const struct imx8mp_reset_map *reset_map = priv->rinfo->map;
>  	unsigned int mask, offset, active_low, shift, val;
>
>  	mask = reset_map[id].mask;
> @@ -144,7 +156,8 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>  		return -ENOMEM;
>
>  	priv->rcdev.owner     = THIS_MODULE;
> -	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
> +	priv->rinfo           = (const struct imx8mp_reset_info *)id->driver_data;

needn't force convert from void*

Frank

> +	priv->rcdev.nr_resets = priv->rinfo->num_lines;
>  	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
>  	priv->rcdev.of_node   = dev->parent->of_node;
>  	priv->rcdev.dev	      = dev;
> @@ -168,6 +181,7 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>  static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
>  	{
>  		.name = "clk_imx8mp_audiomix.reset",
> +		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
>  	},
>  	{ }
>  };
> --
> 2.43.0
>

