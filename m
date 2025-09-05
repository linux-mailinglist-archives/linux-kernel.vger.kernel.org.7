Return-Path: <linux-kernel+bounces-803110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365DCB45AA9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3912D7C6379
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F086371E85;
	Fri,  5 Sep 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rvb5KEJu"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C53705B9;
	Fri,  5 Sep 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082956; cv=fail; b=kq46KNc3j+/hvp+hHwOlzwAQAzdy+s6GHEy4AnynyguGaAWitGUI7WGSUIIhsjmFUAbQrffkxOe1LzFCgAnfOnfOXuS6uiD5WU1fdQjrbTmobazD9iCbNuc1r1jMhH/lTEySF2bnUf4A6IlLPgDbanRSsVzcYqb1ESWIB+sCXRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082956; c=relaxed/simple;
	bh=/O8Fz+5WMeBcPJK8pHIdg4iPu+7kvWqykdWgDPtecTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I8lB73wAw60/pa1fFLDHC9jnV5JPggDYJK77wJNeVZdMeiCKF7ADqGYtsqsKgW2Xsn2PCwHyB8Xk/zMsBEyPRU1eCdgkR5MMLBN7rreC66nl+FjAmTY2AMi2oG7ZHCiFtt3/mu3HOBi2Q1LJlbmU1JUSjMlGeJOqC6kacnJNhU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rvb5KEJu; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L794n/Uzz6VTaX8DR8mYB8+96NOEm8gJ8yYRYqHCOk91v6O5FyoPc4Jo+QUqLADEEbLcbvywnp/YV2TPtZ/LrASFEzPZw6WIfKk5O53Oqwm/0gj9JKETqq20CjFWWFwG05xoWdohrRGGPmXw9OrSbfnqqY9PKby0PTROnz4gAG3UmqE9SQ4ZkxXkFY0NQeGn1E1RucjYZOjpIzVJgdLLF9BHdLNUPuyjygk0cbgrr6ww5DGLNBZVJXjzkmay8xvXQLRmHZLQHhqQUf2+s21nN5vtluY2iJIk+I5W7hIwYkIYSRM3pB6hst1jB6uxSFNosT/SsxYvsHliyy/dhVpzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYbGP80iZyOPJZOK/HO5aroOQoVZN04W5kFr2MNmng0=;
 b=dYTaG2BibiD48y4uTtTBIfROLhAow0FGoQFZhXUPMtwTapcXD7sRz8Y6V/V0JM0lFlCWR2bkrLzFoFow3YL6Yefj1I+hhwlCA6xxfT89S562+aBp43rka5qHh7UdeBUgEEcd03t3YvoLHlfKaGAc64IbBIvED5id6SN2U2z1G0xD901JuRZZiTijMp1VjO3ey73XZa4SBp91rsXX2q0e8kg2Iswi7pZzPEBNtYGapTXQby+NbEnowZCusrovgHHLujgdDeKiret3+uYajJDLcweVBBQVxbOkB49C034l7tcUJ2egVhEmbCpDoBGpqmCHmzc62Odi2eadwQHbj7W+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYbGP80iZyOPJZOK/HO5aroOQoVZN04W5kFr2MNmng0=;
 b=Rvb5KEJuwLKHCs6oZ0Vm5EmWFuMxtwCi8K/YpwJ2m5JsMadi12e68be186ALxaTfIRgBrSku1Mwm7xU0iBcLflPeJiNiqTr5jv9+NH5y1a5hyZz0WbZWPVzm3u8FUW7hcmZ2pWxZuxu5t0K5QnbBeu9xWku1OCBVyCzZ0tepDZJep+xbh9Eqh85SsA1Hhoj8xbr5mYu/0msHxrXqb1I5QF8lxKa7cErMlFjVGM1N601U+63SUgiIYkRO0+Y696RRXIw94PhyLeYo/jUxK2dPHx1pEYts36PwJGrBSrek/3QWpzVfZyUqGoRlrt3QM6kyRy7UPhpxGm+CajViQsKCbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB8336.eurprd04.prod.outlook.com (2603:10a6:102:1c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 14:35:52 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 14:35:51 +0000
Date: Fri, 5 Sep 2025 10:35:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: dt: writing-schema: Describe defining properties
 in top-level
Message-ID: <aLr1QRjVV1lZeuTQ@lizhi-Precision-Tower-5810>
References: <20250904142400.179955-2-krzysztof.kozlowski@linaro.org>
 <aLmwk/0gqrivgl1U@lizhi-Precision-Tower-5810>
 <8fe9ccd9-ec66-4174-896e-01501b8ad8ec@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fe9ccd9-ec66-4174-896e-01501b8ad8ec@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::20) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 0489dfd1-0e91-4543-8436-08ddec89835a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UsZYHGf9tLMSyJlZxrxb+YrP0y4opPl0Vx9toP68PRiNgC01nGs9223jHIp4?=
 =?us-ascii?Q?bLyteRTQFd38WtO9JKBO9Vp4T7GBIksuJC/Lhbt4PSHJsImteFeGo1cM8oTY?=
 =?us-ascii?Q?fYxHNP4cTPQPPDBmcOSzeQ8rwR5PcMHlPjrQ6mY3UT+rp5J451WMYcrHUjLK?=
 =?us-ascii?Q?xsFWjVuonhEbWqc/1/u17DJrL8uyA6tL+zM8rhQeAiig3L+/paJcA66avKrh?=
 =?us-ascii?Q?zhgCN8dJsO8tHBs3nCZtDrilmPL8cGXU7/6aOY68X4cmlpzN7E3c5qvlhjuE?=
 =?us-ascii?Q?OF+NMG7rGMv51Q6eJv1YnC9eOrvugRTj1krj3m7Q9Z33QI5P3U06HtTGSaF9?=
 =?us-ascii?Q?VIMQW2noe95+XLS+chXUSeq6TT9+L2AdboxhG6xFw7Bhem6LfEGqS2yWmQqV?=
 =?us-ascii?Q?1V2V8Oq22rFTAWuOGBHsFi040USBbbNcVFWkhCTSVzlq9i7BjWUKeMP2VkYx?=
 =?us-ascii?Q?EQudidzbtLFmW4tVvI0FmeL4KKlo/KduFbR9lRvXRx+f9VRaFTKovRsMxX8j?=
 =?us-ascii?Q?L38iJ9NznzsI68DKI2f8xe/OS1yypSzELR4IALj75UKBOtM5DtxuBKBxotjv?=
 =?us-ascii?Q?A62IFEFEgmhnhxCF0gNwwiJ++x3uzHfMqiB7q+8dzcSGIEaZ1RfVzV/WQVgh?=
 =?us-ascii?Q?CUQznvW9xTS2dUo3mDWbGu2sv19g7VeaHpjk3sTwe2Pd8ItEhZVED8YjfhUJ?=
 =?us-ascii?Q?lk3Y7QGK3mWzcxV2cLokbq1v2/Mp/vuNVjKFae8YgeNdjYic81DQqiO4ogBg?=
 =?us-ascii?Q?SXg1KhWKhDgxkHlWBu2rRh/4jA3HUg5eS3xR4J6+SsqC/lm5k9L18fjEC5DC?=
 =?us-ascii?Q?ZJ0/moVqGnwNO13iptR2K84vwM2RsKgaAgCN1txg1P97AD5yDgABfx7IRUCy?=
 =?us-ascii?Q?ksegZx7nZc56YgpjJFBOd8P0OlLaoV6uqGnOEWmfaTo4q0tP+BOt93fP4xuE?=
 =?us-ascii?Q?/Qw+4xgVjwX1i0Xkigxlx7PnliThK9O64bcQP4RSZuhAaMqToei2LDWYl4aZ?=
 =?us-ascii?Q?d0A1AicGchv+079KvuupIztWHXLsVtwzWA4L7zwm6jPsH/3dl2Y6H5gugTtM?=
 =?us-ascii?Q?cxFjZVDV+eT7R0iylJHvzgdov4xDzUnl3+jukVHYcW99mY9PjgFeNblmhaeq?=
 =?us-ascii?Q?2dhGJtEQ39lAFniHTcV/gIwLo4s0zirvXIU6/+B8ZHbTW4EwM73MFc/RtFyw?=
 =?us-ascii?Q?TPKR/L+R3bJN65aQEjvqDoCjAW2BzTCH/EUIqYR8O2okRDlsRttvcES4pGN4?=
 =?us-ascii?Q?ATP1bDdbNoLoJwoGEc/avJzPgp3oqO0XlWXUcb9zXsJlyMVDst4S7RtawcmT?=
 =?us-ascii?Q?wIEaatKPgtNVtlC4c26kxABKODV6uyGedGWXtouoG1FoYlCz4ezO9R6C5LZY?=
 =?us-ascii?Q?nKcFoMhfPeSp7JQCdrH1B0qKlMxrukveCqwA/frbZQWA/YaVf2jDVyEjbO6q?=
 =?us-ascii?Q?2KFyou2NlLm5lz9Ey0eyoV7NklmJzJOAxgy6rjJThGV2HxjBHC6n9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tdhgLOnqkqeZDMICIPVgLUkwvWHN2aAursB7wEWD5y6Ja8AjLn6xsT75zCfa?=
 =?us-ascii?Q?QKSEy50LP5ezIgvOjnx0eXZAUZWHqBWjqa0+dg0wwIwKF2oXHWtvlfVEGzei?=
 =?us-ascii?Q?nlFjQ8nsJILyP//Jji9SJ/LPpXMYigGnmd6LIZJcnCXGpT5esiy7O3KNRuqY?=
 =?us-ascii?Q?XzXVrwEGv7LF9qLeras4CbMv7+2zSolWH+QpNkM4eSBNPyXUvKJ2mb5KZhmy?=
 =?us-ascii?Q?KSW0novwcqJthw4PB4kQkLSEydRsgg3hh1wxWiTrOirxFmBDJrD6jcDq8ml8?=
 =?us-ascii?Q?xqc6fG64R6bbiD40MbhT1G/IASAUr+ogOzYUfn5j0sg5op2SdfOgZNirLCjC?=
 =?us-ascii?Q?FHGgwiFnrft+Agccbwaju2oiHJWNuRDHBLu2Wvz/eZwsdvffwAGj7F1ccbIH?=
 =?us-ascii?Q?LQuUw0kQO48j0xnQT6RE/pbPppYmAIY293Q9HFUSM83kF9tO7o9BGDp6KcCG?=
 =?us-ascii?Q?pssoTQUJ2BeH0HTG2LqjQKpXtyPxrMv66lvbdGjZbdx7M1w9+udIDTI+RmGK?=
 =?us-ascii?Q?11nMt6LzGOIupCcuTPGlW655XIChW35W65GnD4EFLwTm6wgDcaInMWCMy+f+?=
 =?us-ascii?Q?HRNHnvXSf6umbasiFYWD+GXO8mB7E8ovyLIOVEyw/KBicDuNX4evQ4QLZoOI?=
 =?us-ascii?Q?RYUE04rScJcCh4Qx22Vi8wRYwjjShEzWVEffqrPnDig4+1LEABSc+g/kAfO6?=
 =?us-ascii?Q?8ENIgPvsVYsMt5V2XzU7rZoQGFObSip7Rneia26Wja53AvXn+f4odZuKqN/4?=
 =?us-ascii?Q?KfHayqpVjlQfHzUvyWhld14xRxOLs56OtcULVI+9zNoplE9uhVGhbbT4oWww?=
 =?us-ascii?Q?rA/dK62YrrTgPjMnTchLDOpMNO1iGpD55x75spml9FsqQsOA0nRjWrAGNlwF?=
 =?us-ascii?Q?1y1aFSMwYljLTiN+oiPc4HEZigtOpP3eT0jBPNlZbXFQknRich+78Hr+kzkZ?=
 =?us-ascii?Q?m/5Ig+utqU0+UOWrCVU4Lzg71ifaTy35CANzjs3jDL0mp5I3bMkkS1dVSWGm?=
 =?us-ascii?Q?mkiKYt//4NS1GIlM0HjGCSQRYTvlUV1pb72nDi5O2KBfTK4mqMUhWA1A6a4W?=
 =?us-ascii?Q?Mxrt0p6qEw8AcUWyJCIuTWLCCAVYxqmncy6kd0XtYxezBAvzfFiUUoSEV6ZV?=
 =?us-ascii?Q?2Oby6W6suitEbmqDlVpSlRhG3oDqHRpmgjLHecDW2X9XatTmv3V5IUWjScXG?=
 =?us-ascii?Q?dZ6yLYfuLxnxNw0YzE1JXZK4KMCxRc0OwMj4LlwSmTAlQwSXrj6VEOIQPeQu?=
 =?us-ascii?Q?+Y2pkuwXGpCEWnA6//BbSrUHPUxIyAWpSZw5IlM4jF6w/JYEDi6MnJ3ge6zi?=
 =?us-ascii?Q?nzIXBuNAjEWKUQ/xhGw5Wtg2xn/xH0aEp+pNT4aJB3FMWPTOPW/U/OwXwnHS?=
 =?us-ascii?Q?MU/k4IK1Wft/W1ncZ9Mk5mHZlSh8iE9seFnsXWmvjqJXhW93wJXe2eI6TOKY?=
 =?us-ascii?Q?NDoUnLFmRt//5KovKkcmSc8j/8E0YFzoc9zOvgI+MOOusgRf8A9n3esHb1is?=
 =?us-ascii?Q?+/lUrjMb1cRZcVqGANVDMYebpz5qXgdlITE0UV5kbDcnww3OeYSkaQeEWP7Y?=
 =?us-ascii?Q?hEv42nVszC5ibt6HIUv5Y1jnUhTji5Po8eTkupwW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0489dfd1-0e91-4543-8436-08ddec89835a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 14:35:51.7289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIE4CDJN8E3vKejSrFydLspTJPj4W2lK010EjMNWJlMsUPDiL9drn7DzmN5xu2C2KEU/jpKiWcnX3tKSsPJyGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8336

On Fri, Sep 05, 2025 at 08:49:01AM +0200, Krzysztof Kozlowski wrote:
> On 04/09/2025 17:30, Frank Li wrote:
> >> diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
> >> index 470d1521fa17..e0859094575d 100644
> >> --- a/Documentation/devicetree/bindings/writing-schema.rst
> >> +++ b/Documentation/devicetree/bindings/writing-schema.rst
> >> @@ -165,6 +165,14 @@ The YAML Devicetree format also makes all string values an array and scalar
> >>  values a matrix (in order to define groupings) even when only a single value
> >>  is present. Single entries in schemas are fixed up to match this encoding.
> >>
> >> +When bindings cover multiple similar devices that differ in some properties,
> >> +those properties should be constrained for each device. This usually means:
> >> +
> >> + * In top level 'properties' define the property with the broadest constraints.
> >> + * In 'if:then:' blocks, further narrow the constraints for those properties.
> >> + * Do not define the properties within an 'if:then:' block (note that
> >> +   'additionalItems' also won't allow that).
> >> +
> >
> > I can understand what your said. I think it would be better if add some
> > simple examples.
> Example for that is already there - at the bottom of this file.

example-schema.yaml is big, it is hard to match to this specific rule. some
small section will be helpful

              properties:
                a:               # define 'a' at top
                  enum: [0, 1]   # width range in here
              allOf:
                - if:
                    ...          # some condition
                  then:
                    properties:
                      a:
                        const: 0 # allow only 0 for some specific condition.

Frank


>
> Best regards,
> Krzysztof

