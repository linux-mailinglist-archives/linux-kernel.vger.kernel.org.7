Return-Path: <linux-kernel+bounces-594057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4562AA80CA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 15:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BFD8A52E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D0215574E;
	Tue,  8 Apr 2025 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DBFdsrRX"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075BD2FB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119348; cv=fail; b=k9NvRAdcaDa24GqswZKDlOUrkj/Smz1bslMHLP3s4bBsgOzJj9v/m6o/TsNmmCevdE0z9KkKEZ8WEtoDE6h44ZdeiCF4Je0MVB/9SiKP1rmxJX//rVnleurRBjxJLqAw3H0clsaTyTiG3dXX5SIZieQ9uRPzsLW/6b+EbJy5znc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119348; c=relaxed/simple;
	bh=R9Py1VYOVrbFHLAL5zM9/pWH5j7kDmsNZVQ9taEHasg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nmJe+pyS7JpcXENFuMEGZzNNqyoOjLejBsEur0H4I8izMm0fnBrNNr+dHyiuSFUkp/ZK3ecj6+dvaDVB8myOYwJgCncBaekWUBNQXhXXuBA655ZZj5R8uWjCyRcpNRVBLeo50QHhI5I0LYp+1HDkR0lsKUsEg88itL99WjO8uhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DBFdsrRX; arc=fail smtp.client-ip=40.107.105.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WF9xJXDNEFgTpS9w8V+0fXXad6P512nG2saZQqauY2ClsDvmDoTkGSUkaIOcbUhL8lqYYcA3UYiNQCPpJ3QvtteL1qAcy87dn1Z+XODjUHnF27Tvybg0+7lIomcFZx9cEMujWIdfFK5kJWPbZIMr+atdjRm5sZKw5ETkFBBXf5+mUaqOrSzHrccTbK8ZSu6xYgF7HJ9jMxgG6CZRIB3GnmDaYnW9BNNgiMwgM+hbqF9oQzOqILtdB263Oy1tzrgnXPy1uvsrMIORL5a9TFVpM18e4QsG5zZ+xIj6KDueX4asCHHY2w+/3r2CGP2GjSt4/uHstKmi1XZ6gwVdSPeoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhvVTc+/gX9mTDuvNSMMNAJVT6OpgSGMna+kvt1qO94=;
 b=d94Af0getVXpjsjqbZDd2TZoBi45K2+a2xgavHZJcqQTEMkmmqrR4FRL0V8dMjUmH8RXaLro7Oc5yOM/krPAl4r4WxdiD/iMaKYQ1wmPGhnb+NgpHmkkm1x41yx9F/V7m532+CbrTUs2wE0NOBeHNExGMVF6Jth6zZnJZ3599XRKDrKoHTr/cUvrKQaDrMMbjjEQiF3ivDAGIp4O4Cl4LxOjgblSPS5OlIvSr5tfcHTgt8L41FYzegejuXO4yEzxaRGtd8YqKqWjsqnTM49106Hb0J5ClrsK9SoKkzCmdHtZV2eyh4jAMXUHtT60S6rDP5lTpZ6fYEZmwhTE+odTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhvVTc+/gX9mTDuvNSMMNAJVT6OpgSGMna+kvt1qO94=;
 b=DBFdsrRXPucmxxJMz9RJRvq8efdjkmjXpP/Fu/F4ER2twLf3t0FUdNvnX43h/AYZ6+geE9SPZjQwh81g5O032N3LXGimRlc0h/TrSNZyXdFjLIQ3erYeE4aUrQtCoOLTLOOJQjAkl78I3jWPMoSZSVrhnIlHBHUZkIkBCR0tGuUAlAbUD04apNkUX/ZCk8R0uLlgem3bZkrZXbfZkeej36MbN/Zd5j1B7l7BoYPO+PTcXVF//vQIoiZVSaG0NWcZIAO35cmKcwXvCaiRyhEshbSS/k2kSdnblbsmjcCP3oJF8VqgBet+qcL2d7vcWjCJh1AHvHOgcxvccGHsav0s2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by VI0PR04MB10101.eurprd04.prod.outlook.com (2603:10a6:800:24a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 13:35:42 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 13:35:41 +0000
Date: Tue, 8 Apr 2025 16:35:38 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: Do not enable DPAA2_CONSOLE by default during
 compile testing
Message-ID: <iet2fsgwhe6bnkznz2z3xgidkbfhxas7madnzlflui5di2qbjl@wr36cskvjvje>
References: <20250404112407.255126-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404112407.255126-1-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: AS4P189CA0063.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::13) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|VI0PR04MB10101:EE_
X-MS-Office365-Filtering-Correlation-Id: ea520ca6-fb38-4939-008f-08dd76a241ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cW1qbUlFBcwGiNEevAdntIs4qmYHRlkKJEkECv54tNtncuUhOE19KblVPf2g?=
 =?us-ascii?Q?qYF5XPE+hseTGidF1N4HfsX8sgHzF/xXXeQT/DgXePUBwYiRLt+uAaWAtqVm?=
 =?us-ascii?Q?dBi9MVnBM/NcpnCMaPJcyyU8oM0Tq/lo8jWryik3q17CpByCLHWciuT70AWm?=
 =?us-ascii?Q?/+jSdPSdo8+cHuq3slcbM9+5r/h6NWe5pDwwl1DWG1OQzS7mmim16M/b+csC?=
 =?us-ascii?Q?LYOFxgZfiFQuc+N/G9gC0UxOJVS68f+kWhZvtcJ01jsmeyM5BRSVMoUFUQV2?=
 =?us-ascii?Q?ntliNsfoVxJpMFhUm+KhLPwVZelm6ma/U3EfbxgLBi79ET1rRA1MirdczORg?=
 =?us-ascii?Q?GAe1OlFv+yxsHAMaVjl9df+3FuthWgDyjAbtrq7FZoMHzbKf/eVJ2M/LYH2x?=
 =?us-ascii?Q?vxrIFaK7fW39mrfTfSUYWgSZg+W8hK8Um+IavxYCYRdp+yE/6a730+93N3fD?=
 =?us-ascii?Q?EZAXwqdIYVPtIPU/XXimefO1T14cb/9vg+GFpW0Y4/YThtM/MCAfdELvn1zF?=
 =?us-ascii?Q?wA/HF9ZXb5vZt/WGBL6x5sATYwMHt23D7mUKBTlMJTagHufoRQmKoWH366Al?=
 =?us-ascii?Q?3N46MsnUkzgVW/0ANUphVYw7DsDvcKnFjLBmfHTyrfwi32pqys62hXN2xNGn?=
 =?us-ascii?Q?ldpz/4HETqdm4kTRZkRtJW/2d/MVawWtZuXa7x1rBiZ8xfd9uXgW4we91xjJ?=
 =?us-ascii?Q?GX2qWCyJsji+qJTFgrB2oAayVdBSBdxpro7Qs/3QU/6T0i4Uk6Heyr7rgJLR?=
 =?us-ascii?Q?yf9COF6xfkHXt8RAti0Xqgk33GKYsunfTxfZlPWFHNgNuGpiO9KdO7Jf/UqA?=
 =?us-ascii?Q?DT1L73gzaED7cMvfITPi+Jdlk+Q9cbpNEf0kwCbQWLwImt6+/Nw9LrkW6ag6?=
 =?us-ascii?Q?EeFucKMbw4LFPF6Rl/WasyKLyR7VgaJWkWnx+nO53J0RgnOvgHBo3jcy5esL?=
 =?us-ascii?Q?uNTZxCdMk34i2hde9dDx+0T3AiF+MQqGRyTpn51sr9oIaGwVfJfH9AVKMr23?=
 =?us-ascii?Q?Tm2mzwxx6agoae5D6RSqoJbGmF+rhw7oNon4KLCqKm9rvFLk0PXW1tia2pn2?=
 =?us-ascii?Q?OE+Sl7WGm0RDklMWGniCCm1ulwy4pKHfepSa08/MwZ3TDpJWgsHASuF2Oq1m?=
 =?us-ascii?Q?butQBCLdCGA4bO5FlBX9UNksMmcvHi7tJZ+xJAOnhTCyPpHhSxXt5ktOk3HT?=
 =?us-ascii?Q?+duiizK/m4dCEj9ETp8Mx5K+nBR0rXzvE8941CwpMVdrMM38G179qoTtR18j?=
 =?us-ascii?Q?mTUmCRMxuBnnFNCXhBGzICGDPl9yy6v49bwrFYlJ+C/6vjLrTQWiDC8UJ9TD?=
 =?us-ascii?Q?+BiweIRFfu9f2TuJIv47p7ZxZo86fBtf3IDmvlz27cIAxnWDSSby2uLZQ6p7?=
 =?us-ascii?Q?oIW8xXrSa/F0RliFRJ7fzsNRISH9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DxmzN1q7NIgrquDBdA9gC4RYj59trIgZL1tKFqj0lmKBNGjJd3N7Vr/mJoWY?=
 =?us-ascii?Q?SDf9fLMLPI18iy96cMaBvXzqlG5O7t3JWBLl8pswpy7GeQRNtIHygfRHjKTg?=
 =?us-ascii?Q?sBbz3EnfzPXx1h78adWMbqaOa1mwb1/So0n87+UtJ+K7n7N7WVB2y67wzqrz?=
 =?us-ascii?Q?jyRCKGJoVVYEGUfgUtpIWBbOY1m/vdBRBP+/GTcUMVBBRKHvI1sg2181k/Mn?=
 =?us-ascii?Q?tLegAU0Pr99KZfMIhRYO9T3Fvwom8ePDG28UZ1E/cnIFMjeTY0OIIXwxBoAv?=
 =?us-ascii?Q?MbwfX9OwAHDPP3SawkCEp1pp1bRfCor0ebCrNMtcTCr51QbZRtuxHyvzrAHa?=
 =?us-ascii?Q?DnnKx94+VSmsMk80KPDSnBUExpTnXa03EcfDbu+EuIsJLMi8GycuaQQluem5?=
 =?us-ascii?Q?D38W1tGMZh0UcnQNBSzYrxS3BPMC+jXQ4T8AdB2Wi4AYlYhYq48T96EaY/AL?=
 =?us-ascii?Q?yY46UYXZz0H5+FqDkRi7F0Yatxmnhlw5+nqKAiT3pUy4T4hEOHTf6eTbxQKx?=
 =?us-ascii?Q?WDTLrgSd6ESrvPGSp18wygrSZ+zB0/gAn4XkBp9+vfbR46Zt9GVGTQI+/7ew?=
 =?us-ascii?Q?97zriA1SiGT/7DAiI69wFxZkIESa2Id+QrGGvoI5zWSxny2YqPKHn96TGcaD?=
 =?us-ascii?Q?LS4cnxrrFM2YSWYABTGoPEWqIbZlklO17e6yxZwsgk68A8IhnW7m6pstJX5a?=
 =?us-ascii?Q?OmtBfyj8v3b3b/RZsHaVPXmI9ASrRzp9IaGPynmAe1L7m6zV4ku02ozscsPi?=
 =?us-ascii?Q?1E+//y2nkabqEYZdmFBr/e4htrXeEllswv0bbohSHWkEQdePdIW33KgsIctu?=
 =?us-ascii?Q?I/cfiL081LduZirehRA64PPqK7XJpFSCf6HbWV2dRX3H0pj5yc5Dll5p55SG?=
 =?us-ascii?Q?nWGz2H20JwjCMvm2/Y+YRyw4KcNkdba6EH6cLCSqAmRnGLzTEfEXi2lBQzGL?=
 =?us-ascii?Q?uF4KvmQezkLh1rJxEwcxqKHk1P3d3Gzazq9cIvfD/etbbJ3aOJW+WqZbJbqK?=
 =?us-ascii?Q?cxqo5fS7x8IALcdrlRhaz64p3iDrEEEJV53q91eU17s/uNhqxjBTlng2NIyj?=
 =?us-ascii?Q?irJvoNvwvqM9LqbUBJ0WfBvVUtfjTUfurh9ThQpe5V8DashlQ94yhNIDCPlu?=
 =?us-ascii?Q?tJZzpa7DQNWgGbyHQbE0BRYczffEDyrDzjaWU4hWEoz7UjxT+HcsBjLIhNZQ?=
 =?us-ascii?Q?iYljVa5tduLZyV4swQdqJhVqUc+T9Q6WPoETjJkdCWbDGJN9TM278Fv8QeLK?=
 =?us-ascii?Q?l4HhmnCA2jg/zeWPQ6BlvF8X/smT5KaKmLSpTYE+/qnGtUVtENkpEqZDVlb9?=
 =?us-ascii?Q?ddGAtGhu2JDzdWGP4mEfFpkdeKRGdfrEwSRW1G0MZa2rpQ4ZvLbHhCW0rpEX?=
 =?us-ascii?Q?mwaXaSz7zWBAhpDid/Oqb1qqbfTgSkVJXm+b/LY81vnWDK3fSAvFZGye5hbg?=
 =?us-ascii?Q?+QTFfZYmkwE6Qz42+Wm79nEp7gEhMwOXPO7lOE+2F68nz/2t3qg3dPjbbadG?=
 =?us-ascii?Q?V+s2uS7FCT7LPVyj0takvWslMAEugz0ts945qb9TXFy6WItuoGqjUnD8g090?=
 =?us-ascii?Q?2Gu9I/E3gp3z8UGxo8K6P6RBZOfpY7cRWhQbFUzs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea520ca6-fb38-4939-008f-08dd76a241ac
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 13:35:41.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IgMeWjUyLPLyUsHPtWknfNmLXoDgynkN8v6xJ351DXUx+SJMUlsdfYypkMoX7lwbE97IxKee32Y0MP/IaoaTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10101

On Fri, Apr 04, 2025 at 01:24:07PM +0200, Krzysztof Kozlowski wrote:
> Enabling the compile test should not cause automatic enabling of such
> drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Ioana Ciornei <ioana.ciornei@nxp.com>


