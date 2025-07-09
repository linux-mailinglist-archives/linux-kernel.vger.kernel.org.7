Return-Path: <linux-kernel+bounces-724508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B14CAFF3CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F177A3B9B16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04F023A9B4;
	Wed,  9 Jul 2025 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I9d8L6+J"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A12185B1;
	Wed,  9 Jul 2025 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096060; cv=fail; b=nFYGQAwooqqJgMzO+Y2+pFm7zGYLj5aABNYUx1fGLoy5RV2C2y4zfsXm48eGmK5eaKuNJU6UWLsCXYvJ9qynGcJXA8jvoQwYB5RxR5NSH1rLyEFkDZjw/EdMxgd7uEtS3ZSGuSltq/tTF4h/zwYhIrX/fUNqNU/DqOUlsQSFiXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096060; c=relaxed/simple;
	bh=oRFo5gPSZWAY7Hl0X45CR97VJR2QXVwkNq2pwBmU4gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sd8fYOaBerRQc35LK5PanMTbkbLfCrmvO+eqW+TEnPnmc8/i3ZYRPwNwHg8JR4kv2UE/Pz+d2C/SV+EQpp+bk+cCFMXNZAoFf6sp+b9+BX2wPtv810YRt+ZcBrCa4A3yeGGch3/h89259se57rt4nladiAqh31fiGS19qGvPi7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I9d8L6+J; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHopZPrc9BUlFbWmgIBKUY8L02AZcf0JvZSJqphaZDJ6WYur0V40JRu5lQYZxMwoG1wn16FOJkzeY0u7nwMnkPnj6aYAH2+oo0Q30/ffBOhjWmfOxHMSsnq4tkAfalEzLWIigIUEnB7fV0xahMkpcflexllWLyTuIe4GS56QQm/zNcbk7KepKI6huVmQhQhnWNabAcd6b2WP2TZ/+CfgjSJ98OKMbdskZg3FXiSNnSK18Eoip0Z4uFJlRq3T8RZ80b0rMyFmrnuZPSviGQ+OR4DD6b14KTPQXRLd5oQFn6dVZSUPesVW93oAtCPp31e3ab/thG0NqrZIRcFsBz8Agw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4HSWwSjAUgC5CuLu8j0eMdAA0AxWUQ1H80u8YTicm0=;
 b=hBghRBo0EWI7kfyjnH5i6ZsX1j1/OVxf6LkHlUAapG8Lk+znfXtAZypK9MFQ2tD6aMAk/ywy/ED+1W+NG4ElUR6ShvrQ+nZ9MayPlIGM6NZtGEMBZ3qmUA4dnzglWrbWlOKQHFvte+A9pKhIg4HgmJGtRavBddXUOoj4zK15F4tUA+NT8EqnZWhVqZRmtYO6lMK4KSbul6Sh43u4cADXjH7t6MhR+e0mTXiHHKEgIoPih71vyY4w4gw+mH/sm84oiVLiJvGqaf8UTEmBZcw0OzrsbZB/HYR8vLOjbSc1yKO+sqiBzCRxBc+6ISntZK8GH6UCKlFw2NyiR1EkKb1KxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4HSWwSjAUgC5CuLu8j0eMdAA0AxWUQ1H80u8YTicm0=;
 b=I9d8L6+Jcn9t2xUp6DATV8s06xQI3MEJ04zrYbnwTZ5YGjRdQhG9dVk6bSaouAzkSTME39k01kuLqnyxmRUPpgDt7IoGyLPebDquPTIGuMcj8g2CALlsD9n5v4UyQIGplXA2uSWPSLPMtVOFC7J8FDLhwJQFcY0tOT5MBx+kcQ+AN3YpoA75VLQUEmKuyTsLVpLXhKWHN8WvynJHCWa4EPkY9h5f2y+lw/DpXl9TYqvviCbMVH0THETVfDhoTLdrKreY+PURmC7VEf84ocAofe61+4iq0Hjv6UCP8UK+4rMs2qa2cyWCc1e1GDF1lEVRWjrzmnyUZxvroGhBs3E34Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 21:20:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 21:20:54 +0000
Date: Wed, 9 Jul 2025 17:20:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: fsl: convert fsl,vf610-mscm-ir.txt
 to yaml format
Message-ID: <aG7dMZideV6NksxB@lizhi-Precision-Tower-5810>
References: <20250424030305.3868637-1-Frank.Li@nxp.com>
 <20250428-sticky-thistle-booby-fab337@kuoka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-sticky-thistle-booby-fab337@kuoka>
X-ClientProxiedBy: AM9P193CA0028.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4c790d-e731-495e-988c-08ddbf2e7cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I2O+wLcUWgNXVV8+pbMXK+a447GNdCmSVaVxWcTwuPxkcX1leFZuCTw+n3RX?=
 =?us-ascii?Q?SxCtUbsOF3iARm9CzSeb8+oD3crJOXlPD5i6pWVC4RXQmcwKK5g1Yg8n44f0?=
 =?us-ascii?Q?OkgSCcVrdHmcFODgSDU+QgsiecOhIdzBcB4VvzfS/0+buTWuiqNYw6d6C75j?=
 =?us-ascii?Q?qm9Sf50tt48+lOuPgWvhnwi1aEOtFVe+jo3lpplqb9+YGRmLGg/UOFXaLG2e?=
 =?us-ascii?Q?ZMom+fOWqQCJvBMkgBcfSX07Za0N53n6PonYIOEIBygjMtWDI34S+BCzemdd?=
 =?us-ascii?Q?ddztTmXmKqXM9VPCFhJZhLX3sZPYeB1i+pnvWDMxq2DQJu1v8FAPGGrfLjjT?=
 =?us-ascii?Q?jFA0rsAl3Y5AYcs7rRnAm8xfKEyYOpTIkJ2Zi6dToR1GMex9EkBD/6tIJOyM?=
 =?us-ascii?Q?ZWemFxDyf7XEYCUAIa5OpkX3FZLYj5ajeXJmBTZMBQdYuR86ifZYPZhvCvM7?=
 =?us-ascii?Q?rojoZdK/4pygshxaeAGtkKlxPq6NkHrqCXnNJmd8O6ElgylAXNYa+FMKc7hk?=
 =?us-ascii?Q?CMLOmuim5vRauG7wcdt4T64xAylfI+Avowr2ln7LzWL55xiy1uPh9JbFP5+D?=
 =?us-ascii?Q?DYigNPyx4cdcBGrlmn3CdvJ+fwqS1GRUXGGqEHRJWP9NsvxwHLkipwZcmIjL?=
 =?us-ascii?Q?GPpN/ofTXldA85YsPhhqcqP1lCB3Ip49aA41YffkDwYvY5DhNx/9Zjgg9mdU?=
 =?us-ascii?Q?Gk88iz1owb5YPULG7aVI0QCZ6d5X++EveUUm/UmATHQrWTAaRR+M3WJ5AhsT?=
 =?us-ascii?Q?LigmAaoJUTQUSJiEJjDh0Y9eqDLGNMDgxpNnOUhUMjOuY1o4BV9gSjrEY1Vm?=
 =?us-ascii?Q?vehhg7Oeg5nOkPsFQXvjye5WnRlINJ8gl3NGdQaKbObrGTisf9e0LJFH7op8?=
 =?us-ascii?Q?23QUasXwT3Upi/tAIhcs1MywsjFfgAxQFbKHyy64G7bWmTaSF34Vgr3huUm9?=
 =?us-ascii?Q?htNjcrjrU5RLYdB4kKipNtc92JoYLKabwBmTiCdB63gfJOBkvzcai5RJOCoo?=
 =?us-ascii?Q?XvwHovfN93DGuJQVua/OqBNHV29CAZrr+CEHAeTBx0pk8pw9tC3msyoLQ7WA?=
 =?us-ascii?Q?EOQd93x+3fS+ICNH4wLEt5RX0CGkthbGNw4K54Peh5jPjUgHDF+PR5AASWCD?=
 =?us-ascii?Q?Q02xTSsoS4Rf0oJ43J1VYBXJgZ6x91ExggM+emmWwzfaTHSFZIiAvDJrgNct?=
 =?us-ascii?Q?kNN+pBk5ezMSpl2nu8jmudCadoMtkzorJ0VMBQZugyL17vWvVMrbXcIlcUa0?=
 =?us-ascii?Q?XfgmUFYYdjWMtjg7XDXH8nY0sNMhetSJ2BlJAWM/iP2EeCQwZOQqW6PenTV6?=
 =?us-ascii?Q?Bpw80TMyYQpr/AiE+Ylsn+Y8HOlw+2irCkE1VYZvVeDHpSAfoNTth77qSReE?=
 =?us-ascii?Q?p1kRazLivrokZg//GLTyR9qlWSQbyBI4QZulGG0kwQNMZh7uxOlWbRqZK0nz?=
 =?us-ascii?Q?IfxNhaWWE3uqVd5VIFDCILIyjsg79poqmH9dEWdYUrY4zB5CvXXVDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oicUBOBoxnbdm36WMU+vmtmZSqnd6lfjuD21116bDU/G78Z/d+An/1l/JQbW?=
 =?us-ascii?Q?AdVIrYLd2axwMQsqNJKBZlgrBuo431lMSosFCQRztiqjrat1bM2d1NdFmJfk?=
 =?us-ascii?Q?V25ITe1hk0IW/TSEb3ydaaWp7SzzN6CjEAYUTSrPLkPrlH35tVIt0GkJs2Wz?=
 =?us-ascii?Q?YnreO4wE4brtnPXiiQZza2YMuw2H46CyUpIw0Ii8rb41Yu2fTc9MxtAWehYG?=
 =?us-ascii?Q?y/kAnXQod1917bWDnTFtHuDeOpSD3fy7A5crG6BJNYBXxVfk/KIEWTjBP9v2?=
 =?us-ascii?Q?0fibR/+9/fIA7tO6bFjV+71euIWUuIxmp0zmzvH2Joc3NDyG4PHg30LgNtXX?=
 =?us-ascii?Q?Hmw6++fx6BC8TPxgrHsOaCjpRwguKJD8bNNFrLGnrgUmhG/E1iK0PlT/uwO/?=
 =?us-ascii?Q?aFJubEADbIIGLI9bZPbp3N1azCW6w+xK7vE7DrbE00PBDQ1rpHMD8O+eQGij?=
 =?us-ascii?Q?5Wzv9eI+7gmfwKr2zbUTBOiEqqqshaZIo+lgCDnWPl/mav6lM7L1e8Ljnd3A?=
 =?us-ascii?Q?eOuBiFdCMwN1waGO9e/eiyAG1P1J83q7liivD+iG5HRg3hYQxA63nVfGMyvz?=
 =?us-ascii?Q?IRt8H07nC85MypM9yRz3ECjomlbkl6QmrL3MPJ+jg6C0K5ywUOwe6W2EBh2i?=
 =?us-ascii?Q?Sq3vCS//4uNxrqpjgjwmACdWrvUBl0pQIRrpNtI1ttfbpDu9L5a+2bVHBTg6?=
 =?us-ascii?Q?H8mweW2JShij9Szv6Wo+Az3+Zc3Ks7leHSnvT5AcZnAnQrBP+Keb1Rt4BpJw?=
 =?us-ascii?Q?XNdVPU7a6Wv56BuY4lYRMhkSiRW/1h02vhy0QzkkbfKmgIT5+ZfRG12b+0aC?=
 =?us-ascii?Q?Tu21y8U1vrHaN/sqaHCNxA/BTOSIoapOYA9jGXnwc/mKzgetQDJfHk+1e/O2?=
 =?us-ascii?Q?oau321ldTbYE4bPStlLNgn3VDedk4k0QbpKAWc5P/sGTKhbH2jmGK0v9XWUy?=
 =?us-ascii?Q?+z5gwDVne73WBH4bYhT7YiQYH0SEUKACRGTVMaHvtCUzvVf6ejnRNkK6PhX5?=
 =?us-ascii?Q?NJeHiyh+Cxv/Kgzl25i2MPrgCtWIS9y6v7b94Wo1BhVY8e/xdSq79vTUYQgB?=
 =?us-ascii?Q?IABrMgQzgVJkpoYEY0gGqSw9P1p1iKmuCiYU4cAKg3+eggqIj2GtlkZrxkvS?=
 =?us-ascii?Q?D86zS+Wrhbo0EU54AKGyjrzTW0gjI8rjVU8tUNEzupfAyUMUCBd27g18wgV3?=
 =?us-ascii?Q?6MEZada5j7AA8d/GGzOgiG7xsadXVqBuTDPbn3p8N0qMXFEQyfPn0MRtc+k8?=
 =?us-ascii?Q?0mVOGNiId5/MQoi0cEcza3d0k4fUwZcgCE8Gxc87XG3grS03r1UgKp01DEyq?=
 =?us-ascii?Q?DvrGPrFj3Jx5OYNU4uiJl+e5BYs47ZndTKhcx3w6WGokjbzipOq6HV3iQxNW?=
 =?us-ascii?Q?rZYinPxSJ1QSvB71QVWjUh7Y9h1clm10IktKZj/88n18gFOoYPyvJi651Oqc?=
 =?us-ascii?Q?lVe9iVrsYsHL8bVE2dzQE58csNXOQ3Ae0mS1pwNAP6dCtASoBFliwms63qgy?=
 =?us-ascii?Q?SMsoInAQ63Fgdvrm+mp5B+GdiHA87FOhZBX4X7f47zD/Eb7q68rcxAWybrkY?=
 =?us-ascii?Q?yv1JR4T5HzZoAXl7ZBW0hfCOx/YB69csEQyiE3kP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4c790d-e731-495e-988c-08ddbf2e7cda
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 21:20:54.3066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wUt6flmddfc+K7VmeWS9nUBDzSqx0qY+mGmUqM1/y4Iq3XmNHcZ1RgLtGNDVF+T6MLwXQL+MtA/odcV54u3NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

On Mon, Apr 28, 2025 at 09:18:08AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Apr 23, 2025 at 11:03:03PM GMT, Frank Li wrote:
> > Convert fsl,vf610-mscm-ir.txt to yaml format.
> >
> > Additional changes:
> > - remove label at example dts.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Rob:
	Look like all irq controller's binding patches are picked by you.

Frank
>
> Best regards,
> Krzysztof
>

