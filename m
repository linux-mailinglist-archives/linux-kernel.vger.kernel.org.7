Return-Path: <linux-kernel+bounces-831708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8FCB9D5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381AD2E0B99
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14CC2E6CD8;
	Thu, 25 Sep 2025 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ku6+10dc"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F220FA81;
	Thu, 25 Sep 2025 04:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758773404; cv=fail; b=ZnLRhhKz8AEtLs93LMT2V7DPe0FIYfPMzqezIp3gmkEIhrx+cFIyoTVIm5m/HTSQVQTpD0OZeeO3kodeB3aZ0Uwd2jwyIm/48Co0b4HE9lJoYPH+VfYV6aH+hnFpR+m8aivTCCarvPKJL9CVqFYHVYbGwjj0/JJj1UNrMTiuYmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758773404; c=relaxed/simple;
	bh=f4Vct8GCxwS2YZH/2+J0IQ/0nXc45StHZKwfNtQbkvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IgSof/K6KbCY6jYom5B88+lvgGiXXxcocRWClSLdV0BvpvvKTowGgTIpdoAg+kqiNrLLCTJmJfMia8KNZWI34c/8SNy34AMIrBe2mz1o6JcpVtb9SOg0xGqOJu7e59xmquOcbCkJh9NRckkHtlJgZagyEBhVBY3pvY9EUMbIg4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ku6+10dc; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylayh/FIGEG6dAm7wPWx+sl9rLEDW89o5lyqwXkSsbAdv+aSwZQJlILMnrrB9yZLx2Kk5MFmP59yL9okfdBoSFNLEklSLV5hnyDNLdcpMT8efwot/BkRsrmCDE0zNlveXJV2A3dMlfUK/Dfiy/RC0nohCSZZa9JRVhWigC1PNs8bJ66qPyB41udWWTwIxd9v58fOmveP/LP8MH5KAN6ePRsIGoMRgCCB+D1iEYzw7vk5dHUbQ0y67ci25qVaAgTIj3/ULEkjLNn8BSqNLKOppu58zsYrpTR99Jt6QUMnFbOenV3yRev/seAIWpJvDSwax2wSNgZPvh1onxPhJL6y9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JuDRoPdj0MrzTm7WDRkgD3v/L8mxV7MXFPn1/dVtIY=;
 b=v0j6J44FelDHtRawT1u+e9gEDjMpXLYlKH7xeY08kXY5u104OMfQu6jXuKwY1EsseYOIi2KAfg4GgTlLppd/Rak4KTCaJtn9zylMqv+1Ubqpjb9l2UNcg202/iOqclbcrGpjlm1pNJ4HRw0nfDcO6cYznt8dOkCQCPSECgwS5QnC13HqsBEeHypO+MuRvtrxJKXji2dhwJtpsjtnBnBXNjbhzLLYjEbLZnTp0wgVJdJwvfvvYzjJSE0ofjuONy+TBpy7sW0FR4oKTWZNNFoXZHc/NA8+fLTHCITWnXEXHEGiaVkHsI92crsKaMXcsmX0pzPCVNa12pMe4s1plfzK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JuDRoPdj0MrzTm7WDRkgD3v/L8mxV7MXFPn1/dVtIY=;
 b=ku6+10dcFxtGLI1jfaMo+HQMqlk9hf1Ma4rZeCS+JOYo7P7xfqlU1RHJHKfnVZDUbDGYKH+rHnvc1Vceig8IE+brfTuhUsLhdqy0oOZWeUZt7thhG9znI6+c2pk7I1eA3Mn/1ZsBcT4MPPiQIz4FkT4fkpAO8ysOxe4ZZqW94uvb7qV8NeN/DHMu4UsGVGKipiBGQvDSF2iTdo++B5eZl05UgzIjaVe7yf5ZQl4m8hbQMaAHANvgC7ghUGAh66a9V0wHeJzoPP18xYgZEIjJwKWuQdhBHRXadnpMNVXFxnkcjSEcWGAS9KVx1IjV+tN7c64IbbZPLPZp4A4AMBKt0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PAXPR04MB9424.eurprd04.prod.outlook.com (2603:10a6:102:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 04:09:58 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 04:09:57 +0000
Date: Thu, 25 Sep 2025 00:09:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"bjorn.andersson@oss.qualcomm.com" <bjorn.andersson@oss.qualcomm.com>,
	Ze Huang <huang.ze@linux.dev>
Subject: Re: [PATCH v2 2/3] usb: dwc3: dwc3-generic-plat: add layerscape dwc3
 support
Message-ID: <aNTAjk1zsWF5lm3p@lizhi-Precision-Tower-5810>
References: <20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com>
 <20250923-ls_dma_coherence-v2-2-ce3176396bdb@nxp.com>
 <20250924221331.migo5szpf4svxpyr@synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924221331.migo5szpf4svxpyr@synopsys.com>
X-ClientProxiedBy: PH3PEPF000040AC.namprd05.prod.outlook.com
 (2603:10b6:518:1::5b) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PAXPR04MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be7f91f-633f-4aa5-1b01-08ddfbe96367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?25dqwPRXcHPKMe2EsqCsruOnnlYeNNK1AMMrepymsranydmQHOVwdy0JalzZ?=
 =?us-ascii?Q?mZPSzG2/UNjDAWLcXMbqnPxwN+CXHzeHy7yNOR+z86t8L8utaB2HmPnpALgC?=
 =?us-ascii?Q?vvVd3CqkZiILq1qaMZfV6DyO/A6JQkWsa1/DZe99Y2nPfvNCf96Y44mPj0au?=
 =?us-ascii?Q?bvKQeVIoRzO2DVSKC7SrhhnOQQVwiGIn2YvvfTFhbVGO+nZCAyK08qsTaJis?=
 =?us-ascii?Q?MUxv/RmgyJJE6NGWaopQnZ8yb4l+/tmdw1fXVUzsHVtwBZOCGCLDVs8A5uxy?=
 =?us-ascii?Q?0vPXNpCW2YAoaVAOE8ETKRaTq3sPG+qRXJLlFrDx6G6mEiZGjYimgWJd7uAd?=
 =?us-ascii?Q?WzBEoqwc3jOLhO308a4s6Pem01DtGVspv9e7/rLLnv947W6jexHaa718MJ6X?=
 =?us-ascii?Q?y+r31snsbTfdc7FjAvFKWwcTmhghecYm0oMz3MeXBNn8abS8q4jJuImKcus+?=
 =?us-ascii?Q?x+VyXAaoCWVrGEiHkV50ssN6guCyVHe0uP5r4ayOxFqMiLmNUvLNO40EDq9C?=
 =?us-ascii?Q?Vw8/i+ckvJpHxCX7iajBuB01b8CeFH2xAr1pzWaK/RoF3Arne4bKIbpZK8+G?=
 =?us-ascii?Q?g7QpSup/qri37+dLhe76ECct7caaPhYb3RsLoTu5sUdQGj5an9LFLMKcVcP7?=
 =?us-ascii?Q?EGsoyTQf52GyYVSUhWm28QEdik/zRyCjpVM30Zlb5kozEynfmBPhnAUa6qV+?=
 =?us-ascii?Q?g0Elg3BQ3mKVSRSEpElM7JfxXb/yFneaN9oCgmt19B0d8YgthK0PBReJgWm/?=
 =?us-ascii?Q?NrEKdzXmIZlkh0RN6Tlc9PvY7NANBgX6lf28rHrpbcQDfqPWbxj8Es6zdqLT?=
 =?us-ascii?Q?GZay+FoVoIKog21GDw55aIX6JzcN57v+rBI6BMblG7SNZTe9y6LSJ5GjLbM8?=
 =?us-ascii?Q?ZozxUqRXlCK6vpa6N8nBZYzRhdfRtdIO5x/MON36TEqx/tD5o7mGtbz+ymSG?=
 =?us-ascii?Q?vdzQVuIUognSpXTINucQdJ00wTKH0wgeYGrvmAyhBET/2m8WKB5rNLBLn0Ej?=
 =?us-ascii?Q?DVK1C/ntdo7abhrZXbjmnQKZcyGeZVObQMwMqPqyvl6OOz9qzYtZTvPnciDN?=
 =?us-ascii?Q?E6at3kjDtcSMmPLaiyxDTJmgGYiuT5ODGnNCyc9aN88B06z8Zw8x56Iuu0YX?=
 =?us-ascii?Q?c/XLwdMqkAev+jZnDffaNllb8phRWfn3XMqhQZwXq4xZSc7Yd2qR9HxJYgey?=
 =?us-ascii?Q?/TyapiwNSm2tClaVK+aYjS+LSNHNVzAyqBP66lBdSQEPY5YtnYN15wuVlUkl?=
 =?us-ascii?Q?+V7yGyvQPOlpcaI8A+NvPQNkQafQMsZtRC/O+RC0F3EYg9pzzqYuC2Uc18BY?=
 =?us-ascii?Q?ICzQTFUrZSRfOvyNRGbw7JyyFQn13VJUMKZFXJYcR48zkD3qpME00PB1Pxl9?=
 =?us-ascii?Q?yBCZNuA2Kuhkkn9WTkypKW3Wdbfl0riRUDxHdIDTa7exUXhduGlffDtW4hgo?=
 =?us-ascii?Q?Y7StTxr85z+WEqIO5V4rn53JX46R+51aMMip5svsE9L4pJkxlgSiBILNOMSB?=
 =?us-ascii?Q?j3wrm7RZHTKriXYwn2+zkYcSpkCA59mZVCAQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?duFU2Tu1WaoY7wfwZfSxKNwW6ppBECxe4IoMJru4vH3wrnIL8C0HMsKKAiqg?=
 =?us-ascii?Q?uHVvvyLG4fgXJ4afsPzBZ/8HzS4HhUrR8Zh5LGL5So4xnNn+lFmOG4e4nWd+?=
 =?us-ascii?Q?gAzs6Dn4xTpwL+vzv2pnCQJcwLqTu2T4n32KGrSGC5rqkD9bkamisqJ18mfI?=
 =?us-ascii?Q?KGJpsmuQ1Lcp9VdMtZNpRwfH+ECY8m6zs4AUkDKk+D99u5Mol6VRMED7T42R?=
 =?us-ascii?Q?9ymOi6JrKFcC/5wfrfpMwRkjdjO86DvZ+s5csOZT7fC+InWr+0rmFEKGxeFn?=
 =?us-ascii?Q?wJV0ontxRWwQ2fbAsfCGt0OLjGKLz/pj4bsaBYL4n6jeTb06h/2mwnFhZ6K4?=
 =?us-ascii?Q?gT5esymJ5S0V+3jtAEqZBfg1eVyUolJHa3Pg33CnKuqmNT3KYAkEYZIPTJsY?=
 =?us-ascii?Q?P/H8N23HggGB3qLdif+VQWZzZIpI673wiIwjyoq15RQi8oDaYdIN8DEyvBsE?=
 =?us-ascii?Q?DA0MjlMV/zPC6UPuCQk2n7VsEsm2fD/8qEVTISyHRURomDZYXemhWabZMZnx?=
 =?us-ascii?Q?8jysIToyN0t6yDLgUbwsGHQEywfmCf+kFbiA3I8LJ+idRtdDFIxK5TpeZP0k?=
 =?us-ascii?Q?ioGW0jRhlAdzIFhF+mCzmzIZPAXw0vcyaaF5ccNFyfbVJF7AG471gZvLynpp?=
 =?us-ascii?Q?TvXuRLD3COG3U0MwRAmzuh7Io+5A3W23DKZAUAX+s8CMRFLJUWOzO8Vrnl09?=
 =?us-ascii?Q?zbwxo1+4p954eIRRuMe0pXXgEmT/yIi/vn2Fv7gtP4/SeNKsIPws6O4lopbL?=
 =?us-ascii?Q?Prm4FwXwcMtrMoxPTRuk6yPFoVopHiU2hr12G5VluiNBxpEgwzblVq3qRxhf?=
 =?us-ascii?Q?+MVjabCun8MqhaxRLNJAKzmw2z+eoK8BAByup4TMqZYSUI9GoBopTSQFU8MT?=
 =?us-ascii?Q?BDTAWMiw8r+09hg7kVe4quS2mVWDAODHrPzRf2IKPu3Eb0/FlPh4P+nHofsE?=
 =?us-ascii?Q?YJXm6PaZdhKiICspg05RrochUR1ZICObL1UgLOLGrg+/Uw+tbCDOSxh69hnG?=
 =?us-ascii?Q?3QdCcHho3F+sk7h4jUQXxlsRSZ16L5SWl25mIoLg2U3BlDXHljHImKhLcnz0?=
 =?us-ascii?Q?EvR+o3SAnSdYnhvX394vQcfTbv6CrmCsjMGXmD5rrpqkWTm3c+otuHrON+Wa?=
 =?us-ascii?Q?0mBZ5hBjWBHvPdCTa7Z5xNav2gOoH7o8EPpegDOncFwoRSGj6TuGD2fnCysb?=
 =?us-ascii?Q?wS1Kp3RNqP9t2xT0dyfi7nhYTce9E4mj+VP9XUPGRLJL8t2s8nwzUCAqN+GM?=
 =?us-ascii?Q?OLXeFzpAnAkZmaF7RznzzWd4GxWdI0UAYOSXCWL18RQxzP5ROCvDr5znaHXr?=
 =?us-ascii?Q?EEytCbl1LOV+hLDdYmfS+F2MJL8QWPq/eo2b+7RpZnUL7LnPzzwZfcNkUpFk?=
 =?us-ascii?Q?ERQGUan674JvqyFfp9qM2tD0Eee5mSxTrA52I/uDpuFvSM90l4I7x3tC4btO?=
 =?us-ascii?Q?GMzcPVaQYhL4+kypkv8U9fYldc/pDVu8zjxsiEzcQzJv6qAFngNL+84J43HY?=
 =?us-ascii?Q?FRxfDwZwghYVph2/gayzSPi+xfbqS8KD96EtkBwzmd8iOwwv7vmLwNuisXCY?=
 =?us-ascii?Q?oic0G8O0GKBNGA6iyBAI+Wrn8jg0QD6Yq8nNqT8v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be7f91f-633f-4aa5-1b01-08ddfbe96367
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 04:09:57.2048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okDvLB0psOYJKvLgH7u1GlYkBBeIlHA4jItuWawZ5dmQWKKpVsdmaKdJvjd9gntarP/VlZrC3k0YXa7Odx4E3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9424

On Wed, Sep 24, 2025 at 10:13:36PM +0000, Thinh Nguyen wrote:
> On Tue, Sep 23, 2025, Frank Li wrote:
> > Add layerscape dwc3 support by using flatten dwc3 core library. Layerscape
> > dwc3 need set software managed property snps,gsbuscfg0-reqinfo as 0x2222
> > when dma-coherence set.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/usb/dwc3/dwc3-generic-plat.c | 30 +++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
> > index d96b20570002dc619ea813f4d6a8013636a0f346..d886b6e557b12edda71203e4f640a9a0a53b4f35 100644
> > --- a/drivers/usb/dwc3/dwc3-generic-plat.c
> > +++ b/drivers/usb/dwc3/dwc3-generic-plat.c
> > @@ -8,10 +8,15 @@
> >   */
> >
> >  #include <linux/clk.h>
> > +#include <linux/of_address.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/reset.h>
> >  #include "glue.h"
> >
> > +struct dwc3_generic_drvdata {
> > +	u32	gsbuscfg0;
>
> Are we going to overwrite the entire register or just the REQINFO
> fields? The "snps,gsbuscfg0-reqinfo" property only updates the reqinfo
> of GSBUSCFG0. Perhaps rename this?

Yes
>
> > +};
> > +
> >  struct dwc3_generic {
> >  	struct device		*dev;
> >  	struct dwc3		dwc;
> > @@ -29,6 +34,7 @@ static void dwc3_generic_reset_control_assert(void *data)
> >
> >  static int dwc3_generic_probe(struct platform_device *pdev)
> >  {
> > +	const struct dwc3_generic_drvdata *drvdata;
> >  	struct dwc3_probe_data probe_data = {};
> >  	struct device *dev = &pdev->dev;
> >  	struct dwc3_generic *dwc3g;
> > @@ -41,6 +47,8 @@ static int dwc3_generic_probe(struct platform_device *pdev)
> >
> >  	dwc3g->dev = dev;
> >
> > +	drvdata = of_device_get_match_data(dev);
> > +
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	if (!res) {
> >  		dev_err(&pdev->dev, "missing memory resource\n");
> > @@ -70,6 +78,17 @@ static int dwc3_generic_probe(struct platform_device *pdev)
> >  	if (ret < 0)
> >  		return dev_err_probe(dev, ret, "failed to get clocks\n");
> >
> > +	if (of_dma_is_coherent(pdev->dev.of_node)) {
> > +		struct property_entry props[2] = {};
> > +
> > +		props[0] = PROPERTY_ENTRY_U16("snps,gsbuscfg0-reqinfo", drvdata->gsbuscfg0);
> > +
> > +		ret = device_create_managed_software_node(dev, props, NULL);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "fail create software managed property node\n");
> > +	}
> > +
> >  	dwc3g->num_clocks = ret;
> >  	dwc3g->dwc.dev = dev;
> >  	probe_data.dwc = &dwc3g->dwc;
> > @@ -145,8 +164,17 @@ static const struct dev_pm_ops dwc3_generic_dev_pm_ops = {
> >  		       dwc3_generic_runtime_idle)
> >  };
> >
> > +static const struct dwc3_generic_drvdata spacemit_k1_dwc3 = {
> > +	.gsbuscfg0 = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED,
>
> Why do we need to do this?

because is 0 valildate setting for cfg0_regqinfo.

Avoid add new flags like REGINFO_VALDATE in drvdata. dwc3 will use default
value if reginfo is DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED.

of cousre, if you like add bool b_usebuscfg0 in drvdata, I am also fine.

Frank
>
> > +};
> > +
> > +static const struct dwc3_generic_drvdata fsl_ls1028_dwc3 = {
> > +	.gsbuscfg0 = 0x2222,
> > +};
> > +
> >  static const struct of_device_id dwc3_generic_of_match[] = {
> > -	{ .compatible = "spacemit,k1-dwc3", },
> > +	{ .compatible = "spacemit,k1-dwc3", &spacemit_k1_dwc3},
> > +	{ .compatible = "fsl,ls1028a-dwc3", &fsl_ls1028_dwc3},
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, dwc3_generic_of_match);
> >
> > --
> > 2.34.1
> >
>
> Thanks,
> Thinh

