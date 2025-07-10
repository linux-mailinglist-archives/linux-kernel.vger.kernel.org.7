Return-Path: <linux-kernel+bounces-724869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C59AFF7B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B3454759C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED94028136B;
	Thu, 10 Jul 2025 03:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QWVF9nYr"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B91754B;
	Thu, 10 Jul 2025 03:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752119821; cv=fail; b=ndSfaSCrz1r3rBDeZGRY6E4TvPcCOBoL0l4kAJ3bXo9MThYjVXt+EXTkJLEZCmOqSFKe7ko7S0uNhj/ZYr1Dy28aORzUuaiS4F+9dUwbh9LniD5VPfF5/3q49w2fbrccikUh2YC1XaQ39o22g8AVYaG2OPYVRm2aQcLLa1TX7sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752119821; c=relaxed/simple;
	bh=vqYw40gCTn97ZeCn3ThlokaPL3tnl/2b19V4fBeOuPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XsoXsch0DXnP5wOFSjCPyMe74Ev6Hl9N5qEyrboU+YnWmNKPZ9Te8k9juakKvssa5gk1oMjSYo1Z8CqaCn7asj5RUcANKbyNCb2sQJSL/UxUXcrrECvA75YJ6P92PNf701gV1FdZR2HdDRSRSAIBPsbwXwbrSnsfVr4HrqGHtiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QWVF9nYr; arc=fail smtp.client-ip=52.101.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8RbPakBVAz7CqYIFMfUsbKRS9boYM5qvG0znqDuRuwutzVr+x7PsKlGefYmRE0EaahSeaNMtfmFDfnQpoUy0QDNmVxRm4Ach9sGpa+0if9U5cQg/qhxUal9ndf90zUoybuurxPL8mVw4/9LGAsZ6KtYEPIEH0FYVsoJ0NjWWk3a9MAGQ0mWeh4axCXJTyKw6pt8RDzMJRMAUne6xRrh/nkdIRkH+GTfkiUQxRe1KFa+TVurUETPEaYm3fwdclELXpR2svNkmkDHMogr4v21vsQrE+GcXMNrYkGhBPL1VQBbgC3HD0+oaDfPVvxRQeX9Y+uE90/RviypQqdGLUJ3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uE94xv/gbYL+JOToHWjh7/X9GZzMXtUvl35QJfWLBo=;
 b=wUpaITfVcP+blWRSgR1FOrnKYiViVt+hrcsrSvY48TJw/Uksb4atNuVXJBGFpwd1jpWI9VBSaV6AhFXRUS4BZgqaZ+itblsx/hqGZiyNjR/1gpbgHxVRBRk/Z3fZ0lYx32iw2v1rjhbg7ZaPiLMvP8Pe7HIR4wR64U7znLH6wwE3X+u7W1cSmTq2QtDnRZ6ndcUWD7pEl6fVsPL/bFgVtUwVGLCwXGf8MPc6+FVW62mIG8qpC1pXBrH7tTHNUJHBfIqTazqokbhXR71DjMW2WyunUV7aUhOmyKGjmzrLCJRvJEq5JVrx0Cr30cBQEJ6hyRdA4zmUtMXKXGPrEi9vtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uE94xv/gbYL+JOToHWjh7/X9GZzMXtUvl35QJfWLBo=;
 b=QWVF9nYrV980J99Sc7FxGypsPD11fFXcHrXJ3VBYDDSTOMh8e8XIcFEItSM4ZRfeQNWtPIWYKZgGLD2TOca2vVOCsB2RR2xxA4i/UhZnsrUsknBWgFlzdSntFV/EIHw4+qMUqUZ/PsF1J85srQkjtP2Hk6ut4lnhb6jsa/HkJ3Z6VR8B7uC/maR7NBbRabu8XkVLPvnGuaPADNYTwSS5LMOLkHOCxm6W7oJZ0UoQC9+uEK2MOW73qmOTuZxfc99zBzop28AxvkrqjIuj7gbiG0JlNBQHR8mZFM0RjFV32ZS5PKCTdysMS9PGQWvsPsnr1C9/PxDiQ/9oQlfmrjoncg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7072.eurprd04.prod.outlook.com (2603:10a6:800:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 03:56:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 03:56:54 +0000
Date: Wed, 9 Jul 2025 23:56:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: Karthik Poduval <kpoduval@lab126.com>
Cc: jyxiong@amazon.com, miguel.lopes@synopsys.com, anishkmr@amazon.com,
	vkoul@kernel.org, kishon@kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Synopsys DW DPHY Driver
Message-ID: <aG86ATqLZOPMo131@lizhi-Precision-Tower-5810>
References: <cover.1752106239.git.kpoduval@lab126.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752106239.git.kpoduval@lab126.com>
X-ClientProxiedBy: AS4P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1addcb-5620-4dc8-6d59-08ddbf65cf22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vEDe4b/emGHUcfAXhshXHZt8Py9s9gV8ljKomlU3KJzvth8IUec1QzFGVtCP?=
 =?us-ascii?Q?wb7uRaNjiALfXQKgL6rtteJfCyJoYSFRb9I67SyaqFLkYg4UKr8VAC+4gkRc?=
 =?us-ascii?Q?28LjiGTTlS1bBulOOkZJlGjkln1lGlKarGsx29PgFqyzDy1BkY55BMr3Tw3b?=
 =?us-ascii?Q?3gicDCayfjXBNPl/ezF/ToVNdpMxkC8FqtJgf05mXSGHyT9BeASmOHUyF1eI?=
 =?us-ascii?Q?ZlWklnqG/DLRA1l1GKIO0pFWYLp/ZAIzMKAJIaogO1iuDkhayPU3G4hMxo9C?=
 =?us-ascii?Q?VefHqTvJHTE5bgabplQnq+Ky8u1/+K9aWGPUosCKZYqs2w3yVTSqOD8NaYYw?=
 =?us-ascii?Q?F2xnjLCLXqYtWir+Ik7OyEFqy8n1pCbid5hoccnUMDTsobVyOpxj1iJmUKKp?=
 =?us-ascii?Q?Vx6xQWYCUB//3qwe/8q99bidFPvUVQ4LTO1OgFHXQERynlqz9Z/Y2LOlw6W1?=
 =?us-ascii?Q?tV3pCG3F2XKmA4214w6bmWtz/bKOQaTXD/oB8EsDevKAHTOb7WJQcK9bZAiV?=
 =?us-ascii?Q?4o9P4YT3oj9RowVqKpmMXoX7ac3Mmk/qi5cRzESkyXP6zkU3GciCwIrb0dTz?=
 =?us-ascii?Q?zSdQ66uEIrFUOgVTZHCIQ1apX9Dy6r+aO2Dx9yYcgO0GRvEEK8pMRjebudkO?=
 =?us-ascii?Q?m4ebM/mFfOUFLzbYWHM29gcTC5TxUTgfvBKRw/km7Z0TUqny2cLDS1VWlRt7?=
 =?us-ascii?Q?kZcSqzqmnpZvbylPuDMA6+HoRYHR7WhGYjyz//tCQcunCymE75WfEkroXkg+?=
 =?us-ascii?Q?P/zJPb7jTkYg/FNienTu6hkW9KilIeduxJTmeR3Qe8a/RDq0Sb2fcvHSrlYo?=
 =?us-ascii?Q?kzFfLN3I+EtoYPDkMRllO/f8AJr1KjbWrUBaghmyr+sOvoS8G7JYLxWIBPhB?=
 =?us-ascii?Q?RrtT2xpVcPINV4W0VyWKbMjV0YoVWbFAbMXwP+ATVs0B9KxxnuEqIA1+EQyJ?=
 =?us-ascii?Q?OsyLZ9YCeja8VKC2ktEcNxiPnDsr2TsHOIvxBAfl3NfiOHxnHW+3t6krS1vl?=
 =?us-ascii?Q?HEkjRerxbQWpoAtG1sVOCtTV/4+NRazamb5UcAKpOPP2VA4c/2asBdF05Wnq?=
 =?us-ascii?Q?tEf98yKURwE5B9oMmpQwOK2ELsso4Z4OO/8zkMw6bvJamfpQRvidWwy1tjO9?=
 =?us-ascii?Q?mHZIkEbFEN7ewzlzUMgkOb9R6aWck7Rch7S4mu4Yg33Ty0TWQdq+RXZRUWNB?=
 =?us-ascii?Q?ysJ4qPKh3+NQsDlFdVUkFVO1C1p8nKtSIsXWVLXe3lSvg7UiQjUilss1VKqe?=
 =?us-ascii?Q?QugJPOawJSn+jYcRJyBtz04ARyD9WbB9xqC/Zddi+54aF/Y6tAh0Ko4/53q4?=
 =?us-ascii?Q?JEKJIzNsPU7GzxqMhXF/8Dzysy9kMakJbMIohhOaXGTvH37uctjdvTmp8Gd7?=
 =?us-ascii?Q?gymqSvIZ4ratTUZgE79l3duNUUwt1Q7dHrSV6rPU4pgvlGy0zHCc2aLnrVAY?=
 =?us-ascii?Q?MM3y4bRy//9NCC4Vhb0MoyapbGsEJa7Jr/jvrkeI7dT/mmEgWRkaiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BfKN4hkRUmOVNZhTWFA+y93ip3fCE1rNv3sTHxmYZY0SQttcuO0MhNQaUmUT?=
 =?us-ascii?Q?Wc7XbkeXbCJQQ5FzhXf6hVv5c0mo3k6mI7/LnTXDVo6eyqyVXbBbeBK7vQBt?=
 =?us-ascii?Q?qe3UB8TfcCnhn6A8w5+5+ncJwtG1dH7p/tI7qYO0YR5SLcUWf3r5AntkFojQ?=
 =?us-ascii?Q?DPwMwYX9bjE8RVGAEvZ99il5Cwq14OWvGWhsIC8yFEJoneCNlUBiEUzw3DW+?=
 =?us-ascii?Q?yWjWVH/TMMgOVcYnODOjqyPdkJ0i+kZndhyaqSFob8ePttXwdl+yQ9QMnasB?=
 =?us-ascii?Q?D+yXtf4oJJlFj7lk5pu0IE+92rxQx6C2awzPzo9Epx27c94OIcp0Lm1h+Hdk?=
 =?us-ascii?Q?zNes8pNMH6vN1EQzSUiT9qfw5Hwjh70SmqlMCmDalqwPC5zx4TclhlhiO4jK?=
 =?us-ascii?Q?O2uGvUt+sdeogWB/c8wmnmLoaBuSEc6T6QSFyTQ13T6IUGdf4tcgz3SLFGdJ?=
 =?us-ascii?Q?Rwmd80TvKVDhUAXVlPEno7giZCe9FbIuPyErr/cfvzIgbGGNHM/PVX5YiCVR?=
 =?us-ascii?Q?okc5po0SNVs8K5FBbFGMGP/VZd0EYi7hmST7tOZrCyQQB9HkAc71jOanOSME?=
 =?us-ascii?Q?smboF88BQGpzqb2LtqNBDOHWXRPLLm4cEQI5amDPJYFXSolZ0s1W99lb38ON?=
 =?us-ascii?Q?/GABAfVGrq0uneWh4Jq4CeqI4wYKVeuh7fY5YDviQt3ehB3OkUA9Vxf0TaGP?=
 =?us-ascii?Q?AX5Zel8Vox1/XUzQSd3Oj/mh/1/2vRXKYSYSCbhllI9vKmhd95xcygumLWCl?=
 =?us-ascii?Q?42L602LS8uhoUA2m4X/Iyw/Ya25NY5vSn6o8BIAfUXuq9S5Xvk53HLzOaPOx?=
 =?us-ascii?Q?0K0gqLA0alSSfG7HYg9R45+gyuMoc9rBI8GKuA9/yow8k+fMlkugj264kV5x?=
 =?us-ascii?Q?RluOJD0eCOQMaj++FvrhBnJvYkYOblSmlRdtu9po2/4b7h8WFbZJZXsp6c/H?=
 =?us-ascii?Q?RVu4P19OqBX3+HdSy/74vP7lKSl0ZYSAk1ZGZMt0fMLa4k4Pr9ihYs7qDsTz?=
 =?us-ascii?Q?vaRdnbnllHN02mbh2BrJUj5eioGNsdWmziEzRWDkCDbhB7YQ9zv4wdxeN98h?=
 =?us-ascii?Q?TYAL65RKHfsbNrVld95kSy4+n4ytijSqsPQT+/o2bCVyxi0Iez/uINhMuMBR?=
 =?us-ascii?Q?0lIkYWtkGTQucft67TYW8VGBDhwL2c6kopEYojKOVbPTDjfS7u5ToD5qHvsY?=
 =?us-ascii?Q?5OZ3cZoWCDHGSQxftmXkNmaY4Wzfp3Yek70c6TN+g+8Rl5MHKXfG/ZqSvbAm?=
 =?us-ascii?Q?8Er9dzvJxlCiNGv7QLYBBkM5PRIbaSm9cHRuhTk2LHfVw6TE5gGsIuvmTavA?=
 =?us-ascii?Q?zIUCwELhpZaDu/L5oDv1+aHKjC5YEZwZKaLnE7mnTY2vZR3w7b7JcF0+UqTm?=
 =?us-ascii?Q?QJad38PDA6DTyLpmy0ArFhT/FHpzE/b+Owz24uaG59DtUif67R2ksk9vxpft?=
 =?us-ascii?Q?7wQFOhM8doN4JedC/J0L+pExlCwsRvSVROjeGllDvRFsoCTJPjSpOVvPGf1/?=
 =?us-ascii?Q?KG/xOSF9amzXRPiUG6pKiARTSJc77Lnuop08V+BAFNYkE00UiLiMi+iV802y?=
 =?us-ascii?Q?2GUJB1tKznIN0GZKQP4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1addcb-5620-4dc8-6d59-08ddbf65cf22
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 03:56:54.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ikkn3n6AAYTBs/zPI/r2dD5sNQOh/Xb6ELyG7yRVqYk+lR+ePPaE+hEAO67COr6F+AHnaZU971BxnKXX9ngK5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7072

On Wed, Jul 09, 2025 at 07:42:19PM -0700, Karthik Poduval wrote:
> v2: fix dt_binding_check errors
>
> Karthik Poduval (2):
>   phy: dw-dphy-rx: Add Synopsys DesignWare D-PHY RX
>   phy: dw-dphy-rx: Add dt bindings for Synopsys MIPI D-PHY RX

Can you post patches or link, which use this phy?

There were many attempt to try to support this PHY.

Frank

>
>  .../bindings/phy/snps,dw-dphy-rx.yaml         |  44 ++
>  MAINTAINERS                                   |   7 +
>  drivers/phy/Kconfig                           |  11 +
>  drivers/phy/Makefile                          |   1 +
>  drivers/phy/phy-dw-dphy.c                     | 575 ++++++++++++++++++
>  5 files changed, 638 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.yaml
>  create mode 100644 drivers/phy/phy-dw-dphy.c
>
> --
> 2.43.0
>

