Return-Path: <linux-kernel+bounces-886809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B45C36972
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6553A1A436D7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFEF332EA7;
	Wed,  5 Nov 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R2BtQPgO"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD53328E0;
	Wed,  5 Nov 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357512; cv=fail; b=ap+r7otboebM+MCVdiLMPIF9PBpQTvEu3vDTkhuMRHUV0sMvop1C1uBSGS0GIYc8e1SIdubmTkyhSwZNIDNb+3R9pyQKRxP/Nn+iQE+DE6CzSUf/co9vwCyjlKo4ASs7fuZ0ATVCxfsXlPq0q5Rb01F+tBKHpxbX1P9vPtfURJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357512; c=relaxed/simple;
	bh=ZgZr4mGAAbI5wkl96eC2iGJmNLJWKQsxjKIyjMuzZug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cO92hTx9+UhDQly0xsQGOpHMwCsiUNdedjGMJApOAVR5/HWGwOEhT7EJHCTVfHzkZNOJFZioIJfKwn8ISR/ReLlZqrg9BbSAtKBvsWBWc50jGk/FvJZfZDw0KeLvmi1YCMoet3Pjc57CTcv5MuM909jVckT/JBoo0sya2ccmis4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R2BtQPgO; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9R7FiyJIZvmSTPQB5lrqLunhnICpG2B/fAmYCicq5nxyIBrYMcAsBsgnXaLz5cJFvvVyTR97F2hAMjb3Zy8aE6O0TKXCV08FOzV0wrO1hLylvLKA9gqL+E8KAcKaCEbD7RotEife7OLCPXAt/eH9KZI6tQ55CnyaotXPodKzzQZME5Tn5UcpSqRuZ5oy3ZlDq1SaOQ/ejymcuS7LU29AWqlY1tgTOfqK4ybtRjo/4EU8fwnhjfmHa471ConcY5a07n71gx2ooqxb8vg26okh+zkJsJbuG15WVFIStb4dFT4yP626xZp+kfQqjz5e6DDjt/OCCo476hMi38U56oolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhyJgJAodYpYZ55IQ8duFjwzfIlhFZCXd7zYj9y0RVg=;
 b=Qc4ieMxVJ48zSPajKNVonSDXIDffmMO+ZrGsymZ/3qj4NyDiFh+xNfqovdOGMbJUwqQ/JuHB3Ix7nGXbQEqtKWCLnc895FJauHduY/spM9mQm8tUuG/y/lTKiaIG7/BNA9uEDO6IHrE1SkoeYAXN6Q3aiTR4jAee8+OEG0NCVm9hBRf2FRK57rTg9zzclAw13ECdzIPl+ZKIdMO2Sg9GAfDn3/FEp5A04AX9aaHfiueWmTTKowOcXPpW+ACUAzIaDrcRH6IhegHpIfyg3eN4GN7DVf4AfN2++vWemYXKO8RT/G79/fDOlkgHTJ/4Q28fR84yeQNRQhZEH8WI8v3D+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhyJgJAodYpYZ55IQ8duFjwzfIlhFZCXd7zYj9y0RVg=;
 b=R2BtQPgONaQHNtM8wb8DcVVRs/j/kJvt0cMwzEDJQLsxg6L9D5NX/4ze8FXxCQsQSKouOHGBLm84ZnRtvgH+qsCl1bbJ4kXfXmm3MU/PVomrS8vaoXLtubf29/qol/EYh88azKMhMAMel9/hXXB+/G+ngCgkMRoETMktnqvNkZLiEIHXE/lumTk0f0jJVaujzezBvO5g3WqvTzYWAO650RHeVFhj5t7juDZcfcGkHsA9ZOGdaCUQ2tKZwOmo8rya2C1FJd2bqRmUP1nSyV11NlmRW4TNy8ZrW/WBOAfLGqIhI/TnMcr+15bW0xPS+2Mh3kvyIO0FkqN9GWtXSvBu2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB9992.eurprd04.prod.outlook.com (2603:10a6:10:4c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 15:45:06 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 15:45:06 +0000
Date: Wed, 5 Nov 2025 10:44:57 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jun.li@nxp.com
Subject: Re: [PATCH 2/2] usb: dwc3: imx8mp: disable auto suspend for host role
Message-ID: <aQtw+dNQEWkKxs5D@lizhi-Precision-Tower-5810>
References: <20251105074504.1427926-1-xu.yang_2@nxp.com>
 <20251105074504.1427926-2-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105074504.1427926-2-xu.yang_2@nxp.com>
X-ClientProxiedBy: PH7PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:510:174::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB9992:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a28e0f-1037-4616-6621-08de1c824ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5SCjYKKkUf4FJD/BUT5xXTXTde4Gx3g2hIkHfqKhZwhPIihOUBihfu3x0PhC?=
 =?us-ascii?Q?2T8H7lf0GqHU7PnY4NGpHPa0VMlzEBmxH9GkcTXP6tQSxJ40btADlL6bgoKz?=
 =?us-ascii?Q?6YEqLz9bNEXA2hz71CmnRVDSuQpl5S6pYhh1/FRggCWVXagN6ZhzI+9QH5cJ?=
 =?us-ascii?Q?Ino3ooB5TQOt0jHsq6q4m+KNIFTT2+Bjyf1MzoaqVgIbBrlqmPdXqEA/cDrs?=
 =?us-ascii?Q?lnfmzN8SfozQDcAVQGZdgXeuJ+krV7kMgIWX/sCHh4hGgjUv2jBPjij/qGf+?=
 =?us-ascii?Q?LyDvAPLeLb9czUnrgVYq2+Gd76cgJM0zw4+wq7nN9R8UCXXVoOvxVq7zRR+r?=
 =?us-ascii?Q?IgryvOvTW6jBdBGSTPnO6yoYC8or7ocq7xqXvFugu+fMaEnVFzV067Yv7AKT?=
 =?us-ascii?Q?9BtiEnYl5C17U6MBwU/OrHjCdNNk6eUQD7u4ig1jBNRNJK+l0Ze61a1+qBbT?=
 =?us-ascii?Q?VtNxrTrWGz4m0Q5LFAYe6+lTzAYSWaRi2O1vI/VAScpyUXQOHDmnmrHHxy1k?=
 =?us-ascii?Q?Psb57gfP1ZkDzNZUMeNFHiHXNHj6coknLcMmfTNFStgslQUtUk/UXa9eEQJb?=
 =?us-ascii?Q?Ov3lKV2kzX4QWcR9azVEOQvbx0Iu5lNHjJzOAoMewsUs0WQwdizAI+VwUzRo?=
 =?us-ascii?Q?MhLCVEjlv5dKjaYI6IBsxrYbYR1uEa4gZWkDgrg/Jk81dfnmkUP1rsU04ckd?=
 =?us-ascii?Q?qW8bWfVFY1q1t6d6oeDqqU9nCYEqMJlECVExgu0lmcJz0JkSFcuC6DCrKcbJ?=
 =?us-ascii?Q?YQbbZdoGjIqGbd7Y2caAEd2zg/BOzm4kUTpM1TA2y4seb9FU5ibMxK/OgoN1?=
 =?us-ascii?Q?d2ZoM634suNRdcnqFO/lMwN3zMtjrBeVTTDR2Bo7H6EAUcXgrHhtoNpwOJrf?=
 =?us-ascii?Q?VQZBX771IA1d7xfrc7BH1Q/bmX0AZhE/inHtmTWsSD0ONatKjwH+3aJaxEes?=
 =?us-ascii?Q?bW8zb+1Sq6qsarzm1lSTp2Zjk6iZ4Qx1wgRZh3x9Rj6ox2ydqcimBI0wzjGC?=
 =?us-ascii?Q?PL+bh7okIXTvO9b/LmcDkxgLGuq1Awg6zMLHkz6ApnsINNDG9bqRA0XtCg4J?=
 =?us-ascii?Q?7/aSGXtzj0awfJCiAcvj7P1qbEmwafonKNpJKdHjwFmvXENnzyk9/rsVSvAW?=
 =?us-ascii?Q?pRcPSn955/5Gs5S7Siqqqpoh7xfn2BzuvSl/1RfSOStKzjmYaTyJE76yRxMM?=
 =?us-ascii?Q?+Df6vBRXFc+XZH+ZUCgVj8EIc5lfF/I6za+vfIMcs60o0yj3OlHn/0L11UlH?=
 =?us-ascii?Q?w7VxLv/hkeJGyeS+AH5MMNTSZozsigc18r4JrLqpI5LMrCHfY2Dmi2R7p7Gn?=
 =?us-ascii?Q?B+vTcP47MJDDl645RWufiaRZllKUg/8pmg3UVXo19LBR0YK8ODetFqhzr+ns?=
 =?us-ascii?Q?YEJq49/ubooVuIBYxRImqDL6/H1oRx9w+tSBAq1OpSFU7sNZUcTCZAIIOnHD?=
 =?us-ascii?Q?6LtTjF1ftDofLuBhpuEZ6nfY1FaFZ/Aj7lEz4KNNC35xf+jjH4m6rs3VqO7o?=
 =?us-ascii?Q?8s7JyGi3f9QyAxmvg0NBxJnxwFQv4PwZP82V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yHYimF+mgVYCY9vv/TKSttoSbmG+FcgscSgz9YRHKwlVI9DBju/D+LlML/aR?=
 =?us-ascii?Q?HeXXhrQfHhENHAOzlMO8Eq+Eq6h0XqktWN17Go19aqs5GYZgVPcysETPNfoS?=
 =?us-ascii?Q?4K0Wxd3f+g8HuzRElRW+BWH2X9LfHamX1puDLGlDnUydnHr5FGiqmA0U3oWG?=
 =?us-ascii?Q?v5bv0FEik9Phvf+Gkg2aWGR6qZspIsp32aqAGo7cFbFTqSUn1bpwuY3jrMr7?=
 =?us-ascii?Q?It26hv/D/IEUfE3WFsiLFA33v6JeVHM1QA6URKw7m3a/ETuBJfwZO2msQ3XR?=
 =?us-ascii?Q?NsZ/w6aSsiwAL+pBjr7lGjfEGiDmCLXUUVJ385rf0OF0n+oRi+tfV1pGifz8?=
 =?us-ascii?Q?xG/acbML8uP9En2SEVrokcGk1ZYZHehCLy25CvOlT+EKSOOB677ZQGwr3zHH?=
 =?us-ascii?Q?v0nYwC7TsH+FiA0q+126jppMKddQyxwtbijLoB6Mi/2c3BCKL93/tYY0GQdC?=
 =?us-ascii?Q?zXt5nazUZRc/Mt8W3FhhLbds5CCxmidALYSf0Bf53F7TM+J/gPjWKSp6wy28?=
 =?us-ascii?Q?PX4ZY3E0YdBH74VYA0qxCeBa/RXZd4gRP2DvZ0B0gs7dW3MzSdFOzdRF7AEr?=
 =?us-ascii?Q?U7CvjSODagPeOuVV8sCvwStKzs3Y8WCMSa3GhurEQeqWb9NPI2XSA7ZXiYUq?=
 =?us-ascii?Q?mv7giDpHQpWocsTeZx7PzFuWPClSSSWMlCDxz2D3raYLPNxxe8hK1WrOQfbW?=
 =?us-ascii?Q?XPTwmCEkZvSJi50zDVIzT8hYqWtaX7Fe0W2odvQdvbUU9HB+Ka6wiHUYUgA/?=
 =?us-ascii?Q?fzwZ5nMt5KqF+ZUwyP/dSD12I5b1N/j3yDGZHTfrJ6mpfQdfphM7H6crdGFX?=
 =?us-ascii?Q?mBVZXA0TJQ0asNCrjC1Y6R94BUHfPfGfE1gQlabgmEo1hgkNP0DheEOfTu1c?=
 =?us-ascii?Q?NWarkwwyOKKBS45OQ3mSra5r4DS6siRpwN7bM03DcwCMwvsy8sOKVD5zXSWX?=
 =?us-ascii?Q?zF3wNOE+/2eiL56JPmFX1YWovWs9/TtiA/nwlJ/yDbaCXd2lonwHrrVYweRK?=
 =?us-ascii?Q?AHAHuaWusYedDpVd9Ppo4phrPEEKUs+mo7VrnA8iTECzr6naqzx8qtPltap+?=
 =?us-ascii?Q?9ybEBiMBv/ZDs79/tBxhXyJQV6pABIVUu410DlC9kwPdEU/yzKl0XHp/F0uj?=
 =?us-ascii?Q?Vt+jUM6b1pCfltmEoXCv8+FBNjweRs/R9l6C8hG8CJeFiBNwbEDiueuospif?=
 =?us-ascii?Q?6fm30WXISPAQ/TEPJS4EOhNrkJISflPQ2qklDLMQrzuyGlwzaLdoSs1vU1IH?=
 =?us-ascii?Q?Rr2F07GLVh54MtfMC/Y9YhAgh6gv0XT7HB2muRIwbtRTrMED/HngH82q0bV0?=
 =?us-ascii?Q?MSsouisD9nYUYRhFLQGcAOGuj/oe4GfnhzCfzk3gUopaZxAoMvel9RS8dLKi?=
 =?us-ascii?Q?BXZ4yfvvfxvxIE0kKV9MZmn+wzAEwF0QkIboa5Oy/xt9MDdfZ9+w1PusrKMj?=
 =?us-ascii?Q?2aPFekRyK30hiIixMsKP21sJj0jy3qpKJFe/UoRzom3QJ92dcsPwh6Kfc/5x?=
 =?us-ascii?Q?LF/E+s8svLIxmZOj6PTWmzmNnXUrFiELQl6n08QmfTRt5OHQ2aDvmYtu/e4G?=
 =?us-ascii?Q?rqfLDAaEiaFtFzV6ikGlzRYcXg4namnevixK0S2X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a28e0f-1037-4616-6621-08de1c824ace
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:45:06.1713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BDUmGm8ydlT5fDBTXVkPiRzas32ZSX2ztQl3oho3azJd9jggpgAkpzHmpaRPICjPPJventrDFb3VyOvlkIFmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9992

On Wed, Nov 05, 2025 at 03:45:03PM +0800, Xu Yang wrote:
> Do dwc3 core auto suspend enable for device and disable for host
> , this can make sure dwc3 core device auto suspend setting is
> correct all the time, the background of disable dwc3 core device
> auto suspend is to make its parent device suspend immediately
> (so wakeup enable can be enabled) after xhci-plat device suspended,

Does wakeup only enable at runtime pm suspend? why core delay runtime
pm suspend impact wakeup function?

Frank

> for device mode, we keep the dwc3 core device auto suspend is to
> give some wait for gadget to be enumerated.
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  drivers/usb/dwc3/dwc3-imx8mp.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
> index bce6af82f54c..80a431cb6fed 100644
> --- a/drivers/usb/dwc3/dwc3-imx8mp.c
> +++ b/drivers/usb/dwc3/dwc3-imx8mp.c
> @@ -158,11 +158,31 @@ static irqreturn_t dwc3_imx8mp_interrupt(int irq, void *_dwc3_imx)
>  	return IRQ_HANDLED;
>  }
>
> +static void dwc3_imx_pre_set_role(struct dwc3 *dwc, enum usb_role role)
> +{
> +	if (role == USB_ROLE_HOST)
> +		/*
> +		 * For xhci host, we need disable dwc core auto
> +		 * suspend, because during this auto suspend delay(5s),
> +		 * xhci host RUN_STOP is cleared and wakeup is not
> +		 * enabled, if device is inserted, xhci host can't
> +		 * response the connection.
> +		 */
> +		pm_runtime_dont_use_autosuspend(dwc->dev);
> +	else
> +		pm_runtime_use_autosuspend(dwc->dev);
> +}
> +
> +struct dwc3_glue_ops dwc3_imx_glue_ops = {
> +	.pre_set_role   = dwc3_imx_pre_set_role,
> +};
> +
>  static int dwc3_imx8mp_probe(struct platform_device *pdev)
>  {
>  	struct device		*dev = &pdev->dev;
>  	struct device_node	*node = dev->of_node;
>  	struct dwc3_imx8mp	*dwc3_imx;
> +	struct dwc3		*dwc3;
>  	struct resource		*res;
>  	int			err, irq;
>
> @@ -240,6 +260,17 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
>  		goto depopulate;
>  	}
>
> +	dwc3 = platform_get_drvdata(dwc3_imx->dwc3);
> +	if (!dwc3) {
> +		err = dev_err_probe(dev, -EPROBE_DEFER, "failed to get dwc3 platform data\n");
> +		goto depopulate;
> +	}
> +
> +	dwc3->glue_ops = &dwc3_imx_glue_ops;
> +
> +	if (dwc3->dr_mode == USB_DR_MODE_HOST)
> +		pm_runtime_dont_use_autosuspend(dwc3->dev);
> +
>  	err = devm_request_threaded_irq(dev, irq, NULL, dwc3_imx8mp_interrupt,
>  					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
>  	if (err) {
> --
> 2.34.1
>

