Return-Path: <linux-kernel+bounces-824886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE54BB8A5F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330EF7E487D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882EE31D380;
	Fri, 19 Sep 2025 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YwHkwYQC"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82731D38D;
	Fri, 19 Sep 2025 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296596; cv=fail; b=WUnAeNTY+y78PIzOPhfUnmsnxfMVFtv5eoC4QUwOZemKJobjLm/EASOPDumNT42Zv9JTYJGmHnydVi3GCm6cWgLjWXz6AR86J5TcBTucB7Y16Cyh1i2sQRcOmFo0UxI7Tcf2rvxI649Ob3IqXziJTGVS2lSuLIPlbwSPtuEw7mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296596; c=relaxed/simple;
	bh=v9fDjetlOcNmfHreK+F4Umr99TE6DZVIGf+NSb7pp/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hx+Wx/jO/8FMpYVgWQwbGAX4gen5f4L3j/tcachk4cpd3Nfft7Fq2SETk05+1TL045yJblyfMlhrs060wnyppVV2eSbsGU3dZ0OGDYT8aWXjiFgTMwkcHBQn7j4ewI8C9eNm77dkzwE1jZC23xExRyRLbRd7WxVnUSN/ROiursk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YwHkwYQC; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaV64LfjIunscY2Sap0f9bMxDg1sBbazsXVO3gS4BBo/3yqQHIv/9qLLOqSyfB1xoTshgVF5gnBvhV1V3xaE+qO3xYjTmlXvqwLF3dPeI5X+pTXYaHDoayxADX/c2wwZplTGW9K28hRU2qRB4w8DrEpVNCya+3GIyMCixVLAAemTsLHdPPcjz2l9uIFqokPnaLTLKP+VekXhMb9IpD5fVuXqFNgHrmcij7vqOSFevis2ZOayOAGPK5268hJeKgBuFOQRkv++dr9T4sjNXZmBCMW0I4hXPiy55afL4xj/HRcQ96SZzqS02iuXjuFUz3fFSTnExeCrKETgvRz0xup2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQ8QWGaZuH0X14d0f2S8comJv/HOCeCjwXakMoJAGHc=;
 b=Lo0p9i5WpLKteHYo8TY/LwZXpKYhHyv5oEmpdmVj6BuZOD5apDEyY8fNa95oY26acNPHG2j1S6xYwg72DtYzlHBdygrLRotS0OIeIw2P1onH07QnwyRrG4Z/BRz18O9FyaFlr/3gCijcmCpSafA8TSNMweDGf5Orkj2N/wh6oA+nnsPsK9ff4NTrPfx9bAu9+pCOoQcfyJ0ZOk3D1uAkMOtUItCbNUnvkKh/UuUrIcWt9dHRJmlqsvYamDB34dY4j5oAY+ytaVOGnz8oWE8UuFIgPHkF+gu/LZPeA9Iq/ag/ApWkLHTo0TVPo5Rwe7d+oDiSo3p1oi8rqMK+DRos/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ8QWGaZuH0X14d0f2S8comJv/HOCeCjwXakMoJAGHc=;
 b=YwHkwYQCNP5323vWzUe3Pkw+a7aoLDLJ31NRDycILprEGkmhEcqaXWaFxEKaDmPa7ywMIMLYqt0zA8pRY1YC9qPKo2CQYmut9Pg46p/RIkR1fWelhyGZmZgZJiw0fNlqa3YHSsRdfknXAviqPsyXubxurMgHXcU6B8NsfeI3QYudvrwUv3hU3NSkgG9xYD9hrNdFx36FqcSzBA0YnoR9v6LRVjFiJaI2RQtUPzoQ04Z8Wspt3JyOOIdxGQRioWcFejYY9rlCFOGbEM4RSQbXdqoDDTTqZ7Vb3RSwTCxQTCh+E8NPmRNURRGQHbn8kKL5AxRXbxwzOC8mXiywsW6luQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8456.eurprd04.prod.outlook.com (2603:10a6:20b:3df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 15:43:11 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 15:43:11 +0000
Date: Fri, 19 Sep 2025 11:43:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, peter.chen@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	peng.fan@nxp.com, jun.li@nxp.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: usbmisc-imx: add fsl,imx94-usbmisc
 compatible
Message-ID: <aM16Bs1Aud3Ai4oD@lizhi-Precision-Tower-5810>
References: <20250919071111.2558628-1-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919071111.2558628-1-xu.yang_2@nxp.com>
X-ClientProxiedBy: BYAPR01CA0008.prod.exchangelabs.com (2603:10b6:a02:80::21)
 To PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ecb1f1-10fe-4634-15a6-08ddf7933d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x4OEROzmotwvtM0JePWlpcet70rJohkgES88JJd5gDT9A6QdUXFkXqi10+aS?=
 =?us-ascii?Q?9yjSKVnDB3FOOS+Akjs5s75pJiJF2dsExFPZT6dU18fTHNPuFXjW1Pi2/om1?=
 =?us-ascii?Q?IBAJVYLuloTFARbkkNYZdL28t2e2h0l59QTBkE+Zy+IoQq4hKXNSMZZIeYxJ?=
 =?us-ascii?Q?fO8wRYw8dkDH0Db9vHQbknU02ew5NABFPKf9kNiqotElRwlqSpeogf2Vu88I?=
 =?us-ascii?Q?yZxs3YxCdxWZpPOeZuP1FTjNkni0vfR+ci0j3hDC7O+zaf8IhEUWSpbLD0BN?=
 =?us-ascii?Q?Ib4scvpGkZPKYc7qzSTiujlP+oyVtYdUYPp/weRJxYLaZNnk6J1A5rDflgff?=
 =?us-ascii?Q?DDuoWnu08mo7ZVbBR1yrd3mq03FQoIbh0DiYwyDweJMhw+GZKMpiK2FxjiPn?=
 =?us-ascii?Q?dff5Jo9D7x1o7SFiYowfRiTDRc8mzUvPOgwRgHKN+r88zuhnrgPAEIdZjRq9?=
 =?us-ascii?Q?F9nglcIYN/cxKaeqqEi7JQgH9Vv1fpy5evtJTV/kLawNQk7ooM8HKCX0QKC3?=
 =?us-ascii?Q?EsUN4/hWZ0b3xJXJgyO8QM1bhEmmopZTDfkwFtiiQf6wuqMzJnAB4/Mj8Pvf?=
 =?us-ascii?Q?puyC1CskDf54+l6VSGPM2EdiK12amn10zz2kpeszSqrlWcS0LF6PlNeNjPzf?=
 =?us-ascii?Q?mjd26rIBz94tOxP6xFXKV86vnCo6/8ky9PB8OU9B4/F6cYLSgYEkOQwpfRhg?=
 =?us-ascii?Q?Hx/J8PoWRbNavlQX6rbvnLXNXceH2ibMV6oegjUQJKQUzxQ2gIaoe4H0oBbN?=
 =?us-ascii?Q?WxikCdxlcxULmfSVdoEUhJYe7Rp3r74I5Anai+PgE86LzDWnQ+weFUtO+4NN?=
 =?us-ascii?Q?7XNn1WsLGD/7YI4s4LjDcIkbpY3Pwwoiy+kTJ2zDD3vvJnEiJdRvdopTyS8m?=
 =?us-ascii?Q?r5SXqqzPqCUgq2t60I8Clgj+oqaid/Sn/ybw/uK0oFd9e/dPkPBwJMZ0Nq24?=
 =?us-ascii?Q?JeCZvwx2xgkJJqtnCr+ZejbwbrPpwozejJ12Tt4KcBMyS5SHL8FsZJ4Q2jpl?=
 =?us-ascii?Q?FfPfQDf/hK37DYKxjxX7XtEm3CFp7rDwY4mzafs0YdM6PTkr+KKKi3ADPIZJ?=
 =?us-ascii?Q?1EEHJQ0KsMzruJWtpDwAXXjE9CDF7uZtilaCRhJRTUiDiLhtDz0aHWyOLEE6?=
 =?us-ascii?Q?x2vvbXxc+TyBy3LyAncH/WRqO9ZJsR5zcTJ3R3e8YTcqsnfffEL6QvTDiyDq?=
 =?us-ascii?Q?4ulmFn1gtSvkICDsJg0/6MSxNkKwuUk8QaYAG8HHEa40l/qOG+ZcglrKxVIx?=
 =?us-ascii?Q?ttha9Y5y1kXh3e5IfHrCll3H+odtYPvgNtKLbIwu62+gG+VNe7kmLJ1ftySt?=
 =?us-ascii?Q?cnTPfZYXJr2py0lU9daxK1z4lLmOpXAlkrcN1D1So9ym5ra0K9koRNuo7TP0?=
 =?us-ascii?Q?cE1GWh2bRGHJ4K5dTn2G6jmyDFp72+ZFzgjpICSJ/ppaXLXk6T5Q97zPtUwh?=
 =?us-ascii?Q?6YR3MRg8/ki6c5kP6HpndllhatLr7exsTLZfYH28bbx06t+gyosXNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2s1foKSVwAcl9LyeGrl/KQodq/uKC0v8gzrdPlYvDqQik38MqgGVPPrFx5VH?=
 =?us-ascii?Q?n6TLKi/+qHTQnhMiWhQO+VYS8u/8LAFpHT8gv1gTZkwm7pWDGgTn5g+mqIAD?=
 =?us-ascii?Q?HturE1BAYbiTvE/wovEVuFtpPgTmft/2VzHl2EFYAxIEwUuc1FfOc32kaiTK?=
 =?us-ascii?Q?RMIOCQpWDDb1gS5D6BQ+Y2rrZAXQbsBTdVnKyscf1ESFQyW2SkBT+3RO5jeE?=
 =?us-ascii?Q?CXKJDHIx2viKrKymRit3a4lcDA+pw81aDp7vT+rFYPHdCE5TwxuGhU8zzNj+?=
 =?us-ascii?Q?aIQ+yfq3PZlVkWLI6S/3xehvKc9VzRCEpJSif2TXbTF4WFdHdd3394FHvISD?=
 =?us-ascii?Q?6I7WK6yKFWH/2orfoW+LyihtN1fUaZxHy+RiRhVvuai744W9c++DMrQGTpZr?=
 =?us-ascii?Q?TOblb9K8x7kG9WPCarbd2TawjbdP7sAcXJbSXCHT/xV/WUCBBsUZ8Rhwoq59?=
 =?us-ascii?Q?6oDjjKP5qufwiKU6dBfLVesSYL7oYEtl6uq0+tlXak4V6iSyB2LqGMxTspCB?=
 =?us-ascii?Q?0SvgYSPWqPLs8g7Zfbtp3orlUb9b0f+5jaLOAeK31vZ4oX6eECk73JjbgtZ6?=
 =?us-ascii?Q?fmvIyuTmLUexFXZREJyfXFl1/mbdi2Qw+QyxPEN2et5o7yF6Qd0yd33DBWnI?=
 =?us-ascii?Q?Omn+nn19B78YQVCPFMWTTAUshok3Wa7tU1Cdwh8YikSnbY1m1ArCxWKdoMKp?=
 =?us-ascii?Q?3tIZVkxQkenMp5/PvP7msX0Nz1d/23zvIiWla4qyL5VAirBehZPrRtIE2Izs?=
 =?us-ascii?Q?bnz7xY03z0oJ8Q+U7u/i+7t4RcF/Tupo8T7WBgNUMAuQl0fh5uYsmsrJS3xu?=
 =?us-ascii?Q?vG95NSNnGwXfHRdWX9lI0ztaQS2xsEaz9FD8DntTOXc/U3BOtzTSWKczMhMZ?=
 =?us-ascii?Q?CTw/cfYOj0rXOs2Wb/+NdLXJc/4Gleg0qzXPD7NzE06ZTWweY4H73kH5Z6cp?=
 =?us-ascii?Q?RfMj7c59zX/iYzkKVg7pAB2JGfTNkrcLJkRfq8ltCrpbj0+/dEhm/9TdaG98?=
 =?us-ascii?Q?mE/S9IE/edRKbTFm62zrd8vAc4nfTrt40gTZ5f8Mkpbm+mFuo9LBsWJ5Gsbp?=
 =?us-ascii?Q?cAwtFqHqv8LhShF9BEH+QhCl/g4kauTcB6vtekqHl+15Dl1FweL8lxLe9HDk?=
 =?us-ascii?Q?MPwsoMOViRfrQ6CM/ntMRMHMBFvdC4L4JjvfN+tKIurclbUWw3cOE7aoU3sr?=
 =?us-ascii?Q?r6rl2XoiCGcQ969FFhHJlQK61UPA0UxauUZP2691wMEmAKgyCFNlPKo6xiqU?=
 =?us-ascii?Q?g/nHHWQ1WGJyr8JiPLSqMyX/gC33C++k7qoLlQ834Qo92uZlyyV+Wza4q0yN?=
 =?us-ascii?Q?18KNJb9fH+bJ1FblEo6l2FkeZbpVHFc88bGFc7KbFCONc78pfnsv6meE3Kiw?=
 =?us-ascii?Q?wcJd8izvGGlTVI7mEG08q25qxMGZx8qRcA/3U5y3EZkq1LuV8lj5dRywXkya?=
 =?us-ascii?Q?iNhG12ts57A9ecGVIMx/f5rC/fwryElc06eyJX1zKaXacj/a+pc/3cOmmxh3?=
 =?us-ascii?Q?16iCYzgblaFIq8CgkhR7UE0TuDKDU2PRt4mjIRw0aXKT7iSoPBzrf/KC7eKo?=
 =?us-ascii?Q?/0cR1E0zwhkGJ+Ratno=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ecb1f1-10fe-4634-15a6-08ddf7933d0a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:43:11.3862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5k0GZO0nr2F41uIskUz7G7zE6aBxl77WgkVGKECjpeEvQb+P86dj0/RBaU8VsNdUqpK0rXrdfJkHyohHjpbMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8456

On Fri, Sep 19, 2025 at 03:11:10PM +0800, Xu Yang wrote:
> Add "fsl,imx94-usbmisc" compatible.
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> index ca677d1a8274..d06efe4dbb3b 100644
> --- a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> +++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> @@ -36,6 +36,7 @@ properties:
>                - fsl,imx8mm-usbmisc
>                - fsl,imx8mn-usbmisc
>                - fsl,imx8ulp-usbmisc
> +              - fsl,imx94-usbmisc
>                - fsl,imx95-usbmisc
>            - const: fsl,imx7d-usbmisc
>            - const: fsl,imx6q-usbmisc
> --
> 2.34.1
>

