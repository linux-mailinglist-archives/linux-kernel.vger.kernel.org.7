Return-Path: <linux-kernel+bounces-852360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B4DBD8C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8081921E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646992F5A09;
	Tue, 14 Oct 2025 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IqYC+pJJ"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013042.outbound.protection.outlook.com [52.101.72.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BAE2C0F66;
	Tue, 14 Oct 2025 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437628; cv=fail; b=e+vvrQVMjKwi1VlqCpEbbjhC2ChxeBu/QEAw1OGOdNv+pezmUU2x/T4cnj0U0pAK6hNSSnfzRod9SPtEnmBjiULlE0/LX0KzU6xgwuq8uUrGTK0cJrxqVgWlD+dCDfIR3Dec2P0+2AsqEzy7Lyx5R4sR9xJIpQ6EghQUA2+NbMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437628; c=relaxed/simple;
	bh=3FIEpCTAucIgl4sNcK7SZT6vj0VNEovAC2juurZ8kYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mCC7B03RxNQH/KSPuIgo1gPjlOhS86CeLHokiteWvFdYjkj/7gx8NDOBv5TsyPZkbtVMi00+MD3ifNPdmL+XP2Dydh9rWXQg/3h8apk9qAumi+1A7O7yjLoM7O2PjG2MlRUOv/ZwRj+xDoidMZ2etF3cVthtQhJmhx47JpCEBOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IqYC+pJJ; arc=fail smtp.client-ip=52.101.72.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M58jtAvUHBrRnwpvPm+X+jIlQ1zVeUh+oSJL9xfx+fRDzOwScwCrO9eyANO5sj9x8J8M6WtpuHUeH3OSYIyrM1NCJWEt7DyPlYatFn1RWVT/q/sCjUv5YT6LUxNOO7YlT+1heug4HwDOpAJD+UT84H8RoMaAtQav55lMjMsFlBXgaqj3WA8ygMWDPdJCn/UBbQsosBMS2ynFlJGC0Ae02Di6IIVjTgwDga0JZJUPX002/DaiVKjDKrqOqfbUPgh87ib+wg54MxdhABlD+3fq46Ov6obX2hV1aXYSWlWu/aSUahAoT2CfZYU/C7lr5gQLSARLi5QhhMo9FJbDySoosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=for+D9Rv29cdYnvaHy5lHDYqVS1UG/3uz5OeYHEv+wo=;
 b=T8JwlFw/rkD0SI52oORKOuDcRf1UZCui98LnPyoeqWU6xmUPFcuK7LP5qDr/9JC8ZStu5P+xe5HXrFXKnHBJIUvofFs3MUM+XNcgGAlqWrIMdfqtCtj58Kw6DNx7HhciYAFOwgU6cM5tcGAqkwtgD7K+z/wHrgqwFIYIpSSZM+eX/nSURruTzVKtF/TfDRJHWF2TVD8F03AUsVSp52ENpGr8PwNWSoSp0e2OMvcypEpSZW216JcuY1MLqlMpNiPx+CzwV77nPtF8jaNNmePl1odozWtvxlpzZK+DRRwmwwDGFuDyRkv+VTdacGviXTCwby4vdu3Fs0gu/nVYRgHHEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=for+D9Rv29cdYnvaHy5lHDYqVS1UG/3uz5OeYHEv+wo=;
 b=IqYC+pJJeKnzYmlSA5yPhiCwNgWQ0elUaa7xF5B7wyro7OrB15hzR+Xy2qJ8/jf3Mz554OJ3z0ddgySNDKHQn5QStaGpVBxzTVteMeSD6o2uBsAkJ5WQJmddRq1i+St5mxhQzHoeOSGb0CfYkTF6OA3VTBZEFbTneBOLPM72XRlBErZ0EPnNsrm9OC4LVoOarqrHq4vwbxmii9p842xxyuCqwsFzQV8G5cgh+9dqxsfmoPrmebSKBd5EQHlGixQr3MER3jQEiBTgho874ladF4WpeTeFoK3FZqm8orkhQeHotYPW3eyKYr4/QDxGHHmzxmKfBoGDgRPl3sSwH5fUUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 10:27:03 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 10:27:02 +0000
Date: Tue, 14 Oct 2025 18:20:42 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>, 
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 3/4] phy: fsl-imx8mq-usb: support alternate reference
 clock
Message-ID: <spkl2zc4h2zzzp3c72ln4lorhzmejljjbso26wigifccl6uydv@4wd64dd2iggg>
References: <20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com>
 <20251010-usb-phy-alt-clk-support-v2-3-af4b78bb4ae8@nxp.com>
 <2805917.mvXUDI8C0e@steina-w>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2805917.mvXUDI8C0e@steina-w>
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: da96237a-4b8c-48e7-ea78-08de0b0c372a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XH2DeHvTlZBpWbmaeNEs0FGt/qCI2PQxkNxDKvN9ggfrdXaAbbuXBehO5O9F?=
 =?us-ascii?Q?LlWmfg9+YKT2bSz+2uT9Gq1xd8/PaJPaVTG3c7Ts2E0k6YA+E9HnOdqs4r2G?=
 =?us-ascii?Q?zhhtA0zNDKVu2eYUIih1cDy3UhTFRd5Dtf8iGqqh+WGmbqxe3o2dYmMKTo3n?=
 =?us-ascii?Q?d/O1JI2MBR6O9KccP34osLmoVMqBz0MnziIFVEIFfLJyGk2QONKS5Zc3EWfP?=
 =?us-ascii?Q?a0cxApRPbWdQKjMiJ4BaWdznqa75Vd59atHq5yz2O0g5KnA6zFDoV4nY+GV+?=
 =?us-ascii?Q?2PowPNPyP6IhM4+5DYw6NCCyzUhhCBE5298nFZi817aB4GWrlLIHFNP2Z/mg?=
 =?us-ascii?Q?vOAOP7R2Wc0keefukFqqGnOTr36724SATLacjxDTvUjbfH9PloNEWlNucPXL?=
 =?us-ascii?Q?hxBwN9lUo6cMPPDuQrbWp450YqRz8VPwn4qkPajqrbQjRJBFYZVIH4vXQbZL?=
 =?us-ascii?Q?lyYk1KcTpY3VM43dCK1KRNzxWDGguUsaoIRlz+cjzQxpJ6u1jIIdozP8Vef/?=
 =?us-ascii?Q?XtdaqD+eWs6DN0zwHk/c7SFZNumXCh2Nlk8kkIU5xDxVp6aQRbuuC8PrUBYt?=
 =?us-ascii?Q?f1/1CPHkBjQozHchonSgC/EpUDdJ6+BVvhXHcET3f+KqwEe4QjmZKMyStm3K?=
 =?us-ascii?Q?Mc1rtMaV/P/L00XX9gbvmolDnAMtZvm1zC3IO9bVhjMsfkOQR6n9+W6xTQbU?=
 =?us-ascii?Q?jbw4YlWUbT9KqZCKcTtLtdpSEExhwf57cNnYbVVQHDqlBY8HvE1ovkoX/AOb?=
 =?us-ascii?Q?Qix5w0KfLJSVFA4N0aOvRBFP7/hpSAf9+0ksAuY+WMtWoGRfnnDckg+rJBKZ?=
 =?us-ascii?Q?cXg055ov4q2Rnlwv6a7xCPt64xfm4Bdempz8yWMGz0hi8nUrqIZF6hVbRqG+?=
 =?us-ascii?Q?ooYNCgKO7STFJUqnVbyml0NmynRtTcJFeodWgF5kTkutfbTATrY0Tn8WyrZD?=
 =?us-ascii?Q?mrVeNur8PcveazS9kBlUIdLJJNklt9IAhCNAAgjDPjIaFMeCpg3fSJ8aDq7x?=
 =?us-ascii?Q?GvR6B923xhhtjyfNumo5EbXwaXiRlAVmPHERnpI69MZmIKYNGcZGK4YoNIpt?=
 =?us-ascii?Q?bMSFo0zLbW1qRqEULHlVBrXxjiRgWuMnL1oEDGPzdeFleLvjALQ6RZ/TrDlu?=
 =?us-ascii?Q?KLQfr16SinUIYqVQJyegaxo0V5fqcXo3QcLTpT8yAEIQD1yTCfWtDo5hf8KS?=
 =?us-ascii?Q?DyKVWzRhVZzIBc/n/46zN+b/xgPNHnc2MZgdm7OLNQIuIWWsC3sciMAYzIDh?=
 =?us-ascii?Q?2XFhFEcJiPypYmXHYU6Ao2FAEvMIiXN6NnSV2F5jcUeOvJVsVAzJmegbcG+B?=
 =?us-ascii?Q?FWti/8hvwBpZxb4ReUnhrudTQPSeLzNDfIfLzVMIGze5LkZ4M1mlZTle4T3X?=
 =?us-ascii?Q?AdVkIAe+79lUqE5dyQimhDWN2EIVcxcb5xoga66TcPp96bJbmnlZSjS0bDQD?=
 =?us-ascii?Q?F1JA2/I+/uejqbNSkcNkeSV/D6rN5Rn5WtafoQDsMTiHmJ5N10nggGj3uqYE?=
 =?us-ascii?Q?DlRzZcl/vRJzN0ey8tJAY0SBgRzXYWd9gmXL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zw9NxPkCdlScvGsscK1e6iZ7NSm7gKY56RVDKuRMPtUb804DvCE3gK9qZ3vW?=
 =?us-ascii?Q?IZt6GeoTyA8DtETX8VNYfOosr4sYkPb8aWrop7mwDwmlNffEDwLoOr8EGsP1?=
 =?us-ascii?Q?o9ev9qhsFRtHS3Qe5dbwJY8Lp3WObzdqAue+s665gJargqg+RZ+pVIHrlv85?=
 =?us-ascii?Q?aE4OzX2+djUt7COh4mq714oEtATdfsNtg8yJDylktJRhWKtgQa+5nvgZRx6B?=
 =?us-ascii?Q?FsToRSNSDqLihek/FkNSSZsbGPFr9u7SoUVRR2UISiZeBZIGIWN06QtAgDYr?=
 =?us-ascii?Q?zulOTWJW9N/gyexq1rA8npGZERr8Xo1cP0nYT1VqAobEllXqPHApd52ig9Ux?=
 =?us-ascii?Q?aw2UXnzo6yzrad+ZN43gwW07spOQS5aAiMbbaMkESSTu7zXeY019wChtvmrx?=
 =?us-ascii?Q?7qG7vjGw2UXIJBsYSZKCBiO+Jde+GP7w0lKn8iTsTydoCJw704txWNRbIS+x?=
 =?us-ascii?Q?Y1TNfCtn1zn6fjZ9nwlvVWq8wcgSYE7fmkcGtTz7Dgm/E83U9n1gZaTw64mG?=
 =?us-ascii?Q?n3q9SNOXr0va5TtKGcOB/BGfEBdqdkAeXJ2Tz7cfov+dCEEO8K8JhKBnwmkD?=
 =?us-ascii?Q?/kv/n9JGBE6E519ebBvZHVBHMU5nlLGdaCft+6Rji2X7Ob9zgmO30Tt77hOU?=
 =?us-ascii?Q?Q4Lwpp3wBopa+cUrdaxsVK4cYsO19deMihIf1+AhuUX+UtzMFvyeEr5Tzdg/?=
 =?us-ascii?Q?AtnLrzq7QFO6wL0GKBOq3nn4s3zWGNQ7/s/IhOA0LL1IFgupW6LG5pw19BRz?=
 =?us-ascii?Q?tviXVgLrHz4UR5Wo2OgVPQqR1+ONTKjCKCldsQjuJVYX6i4v8IHy1tQsZpLw?=
 =?us-ascii?Q?eXRFwsQAUwxHcodhPzmNRI8PwJLFatgyOtMgjoY5Crb627zRlbcEmqhWFRMF?=
 =?us-ascii?Q?fZctyhHsKnnDBdckpshvXx4Xk/PdoXTOv/TsyYO/tZaCCH9RPNs8TeRjI9bV?=
 =?us-ascii?Q?CLvn1a2LtphOHsFGh/T3O8mBR3T0Ap6swacnXYzCGu4YcdjAsLUkJa+39Dto?=
 =?us-ascii?Q?WfWBozpSloJ2xNaRMabL4hSfE+/YER+RNplj7a4E+mWST/WPGbK2hjWSbR2Y?=
 =?us-ascii?Q?r5K62c+ZMBUvsIi4Lx1Isvj1XWh/qonEqR4LhdQ79PsM1uqjH6TOLFaqI8LB?=
 =?us-ascii?Q?yaRJeJHuCGJV4EEsaK/B+U5KDWELVcR1220cF6q4PbcdeWC8TqB69elC9Xhi?=
 =?us-ascii?Q?drU36ksGrFj2pXJ/KYZ82684n1at+YssnQXTx45URSb3R985OJeiMjhGmnUz?=
 =?us-ascii?Q?/jhpUtgSPaS6kCExcLFG0SQ9A1G6B2SIkaeWpYz0fXNX6nZ/gXMtXvMDcYcZ?=
 =?us-ascii?Q?d5NsG/8bvNRuCYaNlVQLtxNFI7g+P4Cy5Azl2fC8OosP4kH8khO2h9hK0yhz?=
 =?us-ascii?Q?HNUqjbPiHdiQdfwOAaJdZ/Pdx3imesnqBqNByVT2EhYPmGmDYR1q/li4uF4f?=
 =?us-ascii?Q?haEeySjYjxAAPOucLdmDVP4q62NjGheQs79ytY+Zwy1ObpTuGkzWZld9WoTx?=
 =?us-ascii?Q?MUGtTCxs/t6P9NO/mzLwi0FgFCjgOiIFEPlMBRtQiWv02JHYTOroLFcMlwYy?=
 =?us-ascii?Q?94/glndJrbupxcy7kvysoBmF1cOFTPIJjqHE1Www?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da96237a-4b8c-48e7-ea78-08de0b0c372a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:27:02.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kL5xTcMPxGpj9f5rc7RZf1fqn9aOWjoBi8FD3GbrE/Zde2n8+sSMGCYtc6aMQmCeyYbtca8zfgztbMhHNWHSKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243

On Mon, Oct 13, 2025 at 07:58:12AM +0200, Alexander Stein wrote:
> Am Freitag, 10. Oktober 2025, 13:01:12 CEST schrieb Xu Yang:
> > This phy supports both 24MHz and 100MHz clock inputs. By default it's
> > using XTAL 24MHz and the 100MHz clock is a alternate reference clock.
> > Add supports to use alternate reference clock in case 24MHz clock
> > can't work well.
> 
> This driver supports imx8mx and imx8mp as well. Do these SoC also support
> the alternative clock?

imx8mp support the alternative clock too. Note that for imx8mp,
GPR_REG0.USB_PHY_REF_CLK_SEL needs also to be set if alternative clock is
necessary. However, it's not implemented for now. 

Thanks,
Xu Yang

> 
> Best regards
> Alexander
> 

