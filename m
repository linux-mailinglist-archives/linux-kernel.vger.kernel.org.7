Return-Path: <linux-kernel+bounces-861247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EE5BF22A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349773A4F09
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E9626E6EB;
	Mon, 20 Oct 2025 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h70Bi4XG"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F026E14C;
	Mon, 20 Oct 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974851; cv=fail; b=m+mAtk44MyEuykFFNUya/es0NWPtpRuM7X56EzMGEBBLfClHYaGhe+wlkkQHw+JmCq4xx950KDEINJewAN+5REdmizjvRfZTtMJ1mXpR9+0I+PRmw5Gi6YuxOeSF6BEHXNIoZfcHhXi6MXk3XfmRbT0s4cW0sjGOKRjHmZak2Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974851; c=relaxed/simple;
	bh=v8oYi7KQIThQLYl/3nXd8eH9UWt0Faxl3ce2okKajeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dZ1S1aFVRLndtOvxFe1DWFq5hF9XiUFjOyrjHVeYO7fm+8/mBuBguXHDLbwZM/jGeSc+eSlvDbfREqfiIbHgBo3CAFG1EpIqyYqxxpzopXQYT600gGZEfEvqIs8EBYJiMqtcVjWHk/HaNeufGV7Di9fExURK+KbE7KTtHIsgt1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h70Bi4XG; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rC0srjj6jDZjxCP8YEpsMGiXWKiWFDpgIkyDRywRrU4G+EfiO+xRGCl3iaFKP+etAm+Lo5vMy1Y79B+hzHeTJINlK40ruzZC1DfV8hyOj9d80sDmDgUg36kH0HUskLvVZ09/ir0GD+U0vYDl2poHZYjdwFNjPrkhhEvV8rbTTi30Q4egZ6fEKRFC+GTfkg31p6k69oDlEkU8fASqpEi4XZQR64dFUmYZ7yBcJ7gdiMVeWFONkLvR3mvKywx+h0A1oA//mH0gQ/MTo6jv8Poln+PwklhqjMqE5IqF95p33KGMMa/vyl3Aq4NWfUa77a3YWT0A1lM/X3vVMZNzCVA+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp4fz2MkGmx6UIsRlB+h7tGZCLoICB3+QvQXC9Ovgx4=;
 b=ASg7JZQuS+ackqnZeLHky+cnodMO3LJ4e9QanSYsqVmx1y3PQS0pKAP1YVUj4ozD04TX9QVkXdtMZw6q/hwAOxmkjGUsSkfTN6MiU22JADXi3/74HBaxO7zM4KgzUQfksvSVNeE5Lgm1xuKa+7dWeBaFiLtiPgrO8um6Z4yxi/OEZrcAahDaHMv74WPlEb212jTaRpa+A6YzIMnXaeccTShs5MWMksVQWrpC1DUnnVQMno/pZJ8prFIkA1cvkppAZyVzSl09nk+J5Jx95TeQOLOXI17k/hYrej75iVV5aotqV4AsUbaBFSA3uODfrfVgDJxWkkBrrVAz/kDSA1h7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp4fz2MkGmx6UIsRlB+h7tGZCLoICB3+QvQXC9Ovgx4=;
 b=h70Bi4XGrKlXsucWx0Mos1IMamUFgwSMpT2LRAPabvgglhVjyjL8m2+NXhmzSw6kfXtc3sj7QotLaAESzGH6YRX52z5wjdNZTfdI7jZ7aDdmgvumA2CGGnXiaZsfmFn/ifgRMLCKu2QgZST0uydpj4hOfyZhBdPCUEw8c25OsMfG7+Lwv+fgFvwPqxqwM8GkEH2BiD5JIKg35Z7itSyYO+8eWc59tRZeoWtcYragt4vtE7bHMuutbq2q0h812X0CtnDbIf7f3XTcrAkCFJuDmJVC2+P+3LiAPKNh34svt3L2d/g5R3/zpRda85soLxEV2/xdzgWM9uGY9LDuVbgU2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PAXPR04MB8672.eurprd04.prod.outlook.com (2603:10a6:102:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:40:45 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 15:40:45 +0000
Date: Mon, 20 Oct 2025 11:40:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Yannic Moog <y.moog@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, upstream@lists.phytec.de,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: imx8mp-phyboard-pollux: add PEB-WLBT-05
 expansion board
Message-ID: <aPZX9fapKz7d6Ekl@lizhi-Precision-Tower-5810>
References: <20251020-imx8mp-dts-additions-v1-0-ea9ac5652b8b@phytec.de>
 <20251020-imx8mp-dts-additions-v1-4-ea9ac5652b8b@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-imx8mp-dts-additions-v1-4-ea9ac5652b8b@phytec.de>
X-ClientProxiedBy: PH8PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::14) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PAXPR04MB8672:EE_
X-MS-Office365-Filtering-Correlation-Id: 36de120f-df54-443f-d479-08de0fef0909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c8AMR3Gg3lic1Pj/zJ6IayT0+51J0UFKyU02kZKUkMO7d7OOkU2qavXO0F3i?=
 =?us-ascii?Q?+cqCOrpzaLSLnnCpjgB+Uf/QvMMv6fodFlM6xBKx0Ezan8MIkF1OLmVttKt8?=
 =?us-ascii?Q?BQvOtdhvawXI52g54Mnoszl3m/Kq1tZkcEN6lujQB9dfXcSWOuSK1tCBx1ae?=
 =?us-ascii?Q?kLx8Mx+rqe7FYQlA9vXTSHo3D5z/G/HdLX5TRo+kWBeFPSHbJ3EwUl+pwtiV?=
 =?us-ascii?Q?QJBUEuoTc3c8kOa9xL4Yx1ZndjQRFxpsMfvToHEWjctx9AcnbpDVpLDgZXX7?=
 =?us-ascii?Q?5iBAoavBGXlpmtfs4ARc0/jQAL/lGd+ycAeKPv6uDYBumwiD48zznkxZgG9R?=
 =?us-ascii?Q?57fRXE/9NvJgwdNhY7VC/FkPedNDwQo0h/raAwkdBT+gS5nNt/nAsA03A4CA?=
 =?us-ascii?Q?42y0yFesOX/x1HJP0/A2ZakZC2qGI9waRI69VoLoH0m9S+Iya/Q8cev4Pqu4?=
 =?us-ascii?Q?SGks03xvnU0w5tAesXuecffb9LFD7yCb/D0lTmMiyksdQpwDAnf7Y8JnMQNt?=
 =?us-ascii?Q?epRotxIGToAIvfvujQdSieHKAgSsTMazhZaqw0bF0wKW0qk0Xu9qcaCCSVdb?=
 =?us-ascii?Q?lIwBt4lcZqoqN59kAEr1S42tg65C1/TFZJz31BEbBPan1tjzqJBV2ru3Rtq/?=
 =?us-ascii?Q?qAtsTPzqxz2UfTH94UdcY1srSuoBjX3ciK4zB2x5oW+x4kaN98vVLK51w4g1?=
 =?us-ascii?Q?t5NjAjEaUKREdFzUZmvQnMIuUHbvPHDVjcX+d0MQNZ3+NQPQIlLARR5rm/RV?=
 =?us-ascii?Q?s29LvXpm+2JklY8Bcqp2erRUtanZbKWMLIgWM/AL6YCNY+a1XdODIDnFiugg?=
 =?us-ascii?Q?8JwE5WVQLOY+0wlOW27eTIDHJcSW0D5+SITLVHfizUlRHXQT/3OKgUmPCYVg?=
 =?us-ascii?Q?ApespBIiup9xfF+PeAVOPPwG7MVe3ZKfeBTthUc+bdvW7SnEeKWVV8sxr2jf?=
 =?us-ascii?Q?BVZYvuXBO58QwbEsIiBxnz9k2hHInbDz/UwkIAkbv0gVd4MJvO9hZYFGGF0C?=
 =?us-ascii?Q?afNrIZrSUGhOq7IRkuWbp7i3LvCmA3BpMmajv89v0+GRA1F3fdBr8uAXf8JK?=
 =?us-ascii?Q?s4U0IwNDKF04L8Sgsl7bU7/9lN4nyoTXLr+4L8Dyc/wD1DkGjySQEKCmEggU?=
 =?us-ascii?Q?XrMYtk2/A5A32WeOnuVKVyglb/c6dJivmTrFLNiLEsFJKDMTgIHyFrY2scC0?=
 =?us-ascii?Q?eM3wxZguaXeMbbz5XypGXBKza8845/sMtkmxqtrGH5xiZlQP5azFDXPIGAeY?=
 =?us-ascii?Q?byRZhzZEYA9kWIp4BAG7R3fUKcUNYUx1g00f9SJAb30ks9CsLwRVsyo1BgwE?=
 =?us-ascii?Q?TadEF1I0J6yl1kMyz5jW1OV+eVuGPW/BqkQczbssxlMVEw19NWHMkCAicAt1?=
 =?us-ascii?Q?M/8LJC2/xG2+ldRpkk+yRB8x3y1xggc+DLP6yGS5+q1e4rrSgy4QGaCyOHCx?=
 =?us-ascii?Q?L+yYxhRfkqCOJs2GGVPdyRexYv7gmvYY7vUWg9AuNx90lDm+0sO/9NHbd/pT?=
 =?us-ascii?Q?MoNM1kNbcDo2y1Hb48W/3xWhXXmDo3sBpoOn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KdyKTad/Lfqgw713tqv3RdPBFluTNWGJmnXtZYoTmYeZSTj47Ryi6R0S0JSH?=
 =?us-ascii?Q?zQsmZNhf3DPHY3bqnEzdTzqn8LKPQD961C3XhAigphlTznz3Vby7bFUYHksm?=
 =?us-ascii?Q?LsangYhgqlgtAagILsXVLa/4KhDO/gHY8SLzPzZgVB5fO+eW/6BBcfCe8jpP?=
 =?us-ascii?Q?twCfArv4sbYRnK8hcUDwbQwgCsUylF4Spb5VFgoF1TkFCeFkYbeIqdThBSIe?=
 =?us-ascii?Q?afRbo4iYTjrM+dLNrkpfxxH2TkwMmsYab4gCt2Q5mGnmzjRjxtNNuJs8LGMX?=
 =?us-ascii?Q?lXuToLd7YtpHbOzKW/jQwMKUsC3I42ja1KuA8N61e6QBOCH0XjtyQtGsYeAd?=
 =?us-ascii?Q?TvcX0ALjXDmu7UgKfwyjKCl+Z+0rkVjOpdYBNo0fv1NvJ27Knioq1jVgN2eM?=
 =?us-ascii?Q?7KsWxvnU+kyYY1wwbuf9s2SZxn2vI0iS/eJxehlflqs8sf8f++wVqu7nlORm?=
 =?us-ascii?Q?GnsmTrH5aeYhrL0CM5y67Bz5iZy7ELWWnnT5hU90vea6WSbdM/b9qsTlH+kO?=
 =?us-ascii?Q?KyOi6mAC+Kt/se18lYM+Fms705am6qe02RFGyiyIYO6Gn55DH241W1JInKHU?=
 =?us-ascii?Q?1UO1I+nv5z9yxjCcU8NxjcMh86+0BWL9JUy5Qa41Tz/ppVjfWhSF+rMnBnuR?=
 =?us-ascii?Q?LrHdCayvm9IJHlrwcRZ7e2lXUpTCSSecoYqfeMZbPJjskNyrcmsDUqlCY2nR?=
 =?us-ascii?Q?eorgYDkc3ydfPOu2vr5U1dCWyKjT7Ghk1Ea6nfjTuxjCXvsS8P91VySKdoll?=
 =?us-ascii?Q?8gnFLIV/i4PA2+Q3XfhXPuE2cbNLhsssARb7EbNAV/qri4LqFrbHjr7LK6HD?=
 =?us-ascii?Q?rZMlRgTmOu/SJyq3rFkh5qowjLAzUILcTMbuT8SVf7aBPEQWxlHs9o8NmYCr?=
 =?us-ascii?Q?NKkUTTVmAiLnv8Bvo4QVQD5W2QFPV+Dhuwj7ol6AKexyhmsvfb9zP0sBPEmz?=
 =?us-ascii?Q?0iv034cBi0iGCl9J9AiXlKNidVFBF9iaGD+GAX+RtFhBPRK6VPpK64nMnBas?=
 =?us-ascii?Q?8xip6PTPtEFPUiOX6fEgE/vPPOzF6CF/lD23lBXc/K8HuOegtnjG2c9dUShO?=
 =?us-ascii?Q?TWWo40Zwv6PNtLtf3J/mh3Wmnp7wOT4W+GHf9UN7uYSeRlpIIW3Sr8xJsnKB?=
 =?us-ascii?Q?pb10DJokq7/QFuBXfee37iC/U45mN4P2npN1N7C2JyVi3TSjCjZL31/1XRqK?=
 =?us-ascii?Q?xvincQabIZK/ut8z0cOqJQA0ue+QPlhqnLR75/qQLbTTRIk0mA8IFr7BHI7/?=
 =?us-ascii?Q?yI8Igg4JE5kAiOzP3bKhNV3OXL6tx59Pmk1E4hR+A8wSuFcq/JAyToh8RKko?=
 =?us-ascii?Q?T6dRzVxhudLIaBsJUl6Akzx4c32DlYU93j1OYsYLHRqEfK54XbpNrD2+XF4+?=
 =?us-ascii?Q?2ChaaXvKAPDxFpH+SxkNw8LB147tjfoL+K6IPM/9Yf0uiKEmYFbOjm+6wV2T?=
 =?us-ascii?Q?5bhsrmQILhZEX1ZTM+o60/w/SNOwG4MnyuXl24BeWCQQwPiqPQcsB6lCs0l1?=
 =?us-ascii?Q?AAAas21/Az25nMwHRYUzVjIlHMWipdA3SjYH7fHMssL/XK/GHo6Dkm5w593l?=
 =?us-ascii?Q?CTBqhLCFuccUkN/KOhM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36de120f-df54-443f-d479-08de0fef0909
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:40:45.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZSqAieDliyGWzLxR2JxFLNOuxDF453tULLZKs58aHSUqNIyKhpuXKWPNiot76M2YTbppKp1FFhlV1OL/VD7Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8672

On Mon, Oct 20, 2025 at 03:11:25PM +0200, Yannic Moog wrote:
> PEB-WLBT-05 is an expansion board that provides WIFI and Bluetooth
> functionality. It features the Ezurio Sterling LWB module [1].
> Add missing regulator to baseboard dts.
>
> [1] https://www.ezurio.com/wireless-modules/wifi-modules-bluetooth/sterling-lwb-24-ghz-wifi-4-bt-51-module
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  arch/arm64/boot/dts/freescale/Makefile             |   3 +
>  .../imx8mp-phyboard-pollux-peb-wlbt-05.dtso        | 108 +++++++++++++++++++++
>  .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   |   9 ++
>  3 files changed, 120 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index d77e6ab8e46fe71ae41087a3b65ca64cc50e2e76..606a25f3323dab51ddff7bab686e69a8d48610a3 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -237,12 +237,15 @@ imx8mp-phyboard-pollux-peb-av-10-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk
>  imx8mp-phyboard-pollux-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
>  	imx8mp-phyboard-pollux-ph128800t006.dtbo
>  imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
> +imx8mp-phyboard-pollux-wlbt-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
> +	imx8mp-phyboard-pollux-peb-wlbt-05.dtbo
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-etml1010g3dra.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-ph128800t006.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-wlbt.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-lt6.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-wlbt-05.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-wlbt-05.dtso
> new file mode 100644
> index 0000000000000000000000000000000000000000..0e98f4d942716e57f5bc1567924460b618eb0930
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-wlbt-05.dtso
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + */
> +
> +#include <dt-bindings/clock/imx8mp-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "imx8mp-pinfunc.h"
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +	wlbt_clock: clock-32768 {
> +		compatible = "fixed-clock";
> +		clock-accuracy = <20000>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "WIFIBT_SLOW_CLK";
> +		#clock-cells = <0>;
> +	};
> +
> +	usdhc1_pwrseq: pwr-seq {
> +		compatible = "mmc-pwrseq-simple";
> +		post-power-on-delay-ms = <250>;
> +		reset-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_RESET_B__UART3_DCE_RTS	0x140	/* RTS */
> +			MX8MP_IOMUXC_SD1_STROBE__UART3_DCE_CTS	0x140	/* CTS */
> +			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX	0x140	/* RX */
> +			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX	0x140	/* TX */
> +		>;
> +	};
> +
> +	pinctrl_bluetooth: bluetoothgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x106	/* BT_DEV_WAKE_EXP */
> +			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x106	/* BT_REG_ON_EXP */
> +			MX8MP_IOMUXC_SD1_DATA7__GPIO2_IO09	0x106	/* BT_HOST_WAKE_EXP */
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x190	/* SDIO_CLK */
> +			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d0	/* SDIO_CMD */
> +			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d0	/* SDIO_D0 */
> +			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d0	/* SDIO_D1 */
> +			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d0	/* SDIO_D2 */
> +			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d0	/* SDIO_D3 */
> +		>;
> +	};
> +
> +	pinctrl_wifi: wifigrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05	0x106	/* WL_REG_ON_EXP */
> +		>;
> +	};
> +};
> +
> +&uart3 {
> +	assigned-clocks = <&clk IMX8MP_CLK_UART3>;
> +	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	pinctrl-names = "default";
> +	uart-has-rtscts;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		pinctrl-0 = <&pinctrl_bluetooth>;
> +		pinctrl-names = "default";
> +		clock-names = "lpo";
> +		clocks = <&wlbt_clock>;
> +		device-wakeup-gpios = <&gpio2 6 GPIO_ACTIVE_HIGH>;
> +		host-wakeup-gpios = <&gpio2 9 GPIO_ACTIVE_HIGH>;
> +		max-speed = <3000000>;
> +		shutdown-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
> +		vbat-supply = <&reg_vcc_3v3_sw>;
> +		vddio-supply = <&reg_vcc_1v8_exp_con>;
> +	};
> +};
> +
> +&usdhc1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-names = "default";
> +	bus-width = <4>;
> +	max-frequency = <50000000>;
> +	mmc-pwrseq = <&usdhc1_pwrseq>;
> +	non-removable;
> +	vmmc-supply = <&reg_vcc_3v3_sw>;
> +	status = "okay";
> +
> +	wifi@1 {
> +		compatible = "brcm,bcm4329-fmac";
> +		reg = <1>;
> +		pinctrl-0 = <&pinctrl_wifi>;
> +		pinctrl-names = "default";
> +		reset-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> index 7d34b820e3213a3832c5be47444d4e9c636a6202..9e25ce1d466b1174c60d2bb350339ca5d68cc025 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> @@ -119,6 +119,15 @@ reg_vcc_3v3_sw: regulator-vcc-3v3-sw {
>  		regulator-max-microvolt = <3300000>;
>  	};
>
> +	reg_vcc_1v8_exp_con: regulator-vcc-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;

regulator-always-on and regulator-boot-on is not neccesary.

Frank
> +		regulator-max-microvolt = <1800000>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-name = "VCC_1V8_EXP_CON";
> +	};
> +
>  	thermal-zones {
>  		soc-thermal {
>  			trips {
>
> --
> 2.51.0
>

