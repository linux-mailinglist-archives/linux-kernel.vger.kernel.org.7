Return-Path: <linux-kernel+bounces-788566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599E4B3867C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2F31750AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792BF278143;
	Wed, 27 Aug 2025 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kq9hQPnb"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3592765E9;
	Wed, 27 Aug 2025 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308192; cv=fail; b=dmwb7cRPKsbzGfc1W+9XCBd34X+ZS15aRZt557cq0X7ZyiQBTeLkawCsXaCX2rUkp+AoZJW83Q1/VV0cOacuwVdi4R6pQg58o0Pzu1E/J8VGzI20rr2Z4OswCl22o+ABWv1SHKO64QAl/7cbKnaP7cgeN1f4N8fIrnzb6MtwdeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308192; c=relaxed/simple;
	bh=dKwxoP1MoO9g2bNaus+hwR7iU0os4VIeO1At9eQ87f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RN6MAi9N+YQ033KturD2p/5HCbb1z41GBQVrkQgDS8IK4qxTqRk7KXh8Dy/x5B/a78NRpPV3Bys5DbNYMkHkH8HwUq8WuWQ3ZlJH8/ZU8nVWKrk9ce5Z/LomELUVnhDC65xctEV/r/9xHwtGEzw40aJxstrlmMB8sMBxP4oxVks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kq9hQPnb; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVMsM2CNHYu/H04LDu9cVYwoMZIOQ531nzSuqrMinT130olfB8oGng5tnflB5w2klr72akfK3gKEfZY9E3RX6VIPJSgHyD2ftRw2P0vnGQ1UHPos6wEcM2ybmQo/Ws5Z4/o+99miP+FAeEzNLN904m0YV5M0v30EEeLhbco/IBt/wAeKfGqaxfvV+EudVt1QjA5QMgRp//6N/M0gSVBY6q9fVHId10laxa8AJc+fCWeN22AEstKHXYAzny1nr5/BtSVb0OtdFhzkMiY/SxPgYetqYs6qi4k3vf4Jf0R7izhK8Obd7hDvcIj261iRjJ8tAR8Q2jRRjGlgOAVJnvB52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwAqq1oA5qOwVI/PwkGSzgYkn7prlu/cTE0RWlQU7/c=;
 b=E6u6eLmItGPyiZLt177Ksj7tdIWG7yLI8b5QvSEP68v2eMAft2purYLwMtBtDYjmvR2yZY76SyIG61rElnhP00FQtDo8L7LR7SKrLkZ25pIfqT1rPayjxVpLdRFwjILMgquA/JR4wRhXmG+FDavvld3veGTXcyrCpLXvCNAsiPpTKUML8hf+G9qWIy7lZ8GyGFmotwbzqB/E951RHrT1Eb2Jk/hYR0e1Qm4KRU5Bqgdo92OAbmspDxG/t1GEezFxLySOg6T/fqWcIYaY8Uj6l9iqiVOYwL8zw6j7d2xMb+M2nxGAYnmKn11dY3J37FRtt3Mc6nNoWvZYUWXXqQY5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwAqq1oA5qOwVI/PwkGSzgYkn7prlu/cTE0RWlQU7/c=;
 b=Kq9hQPnb4qBeoJhYCY2CnERnajbnuazM7HJXTxLGDKQfvPpUothaD9u7oxH8UcB3vRaEx+zHcUHjA6BVObBXrr2sJlA3Rc2oFc4Ww1NcejaCbQqS1rVC90HO+EA6jrO9AKIPWuCP8vfM9fh6GfS+zsQNfXtYUd0/aX2CMw7rx+deKoji6DUw7t+ne6uniW8xoz2avGjC4vLynd08pkUv+oL7LbCH9+fCMhhmVtJCfk+RiuH0tGs8FoJxrJ1epGR5JBJfF2iv3g2rTUym/08jrcUfF56PFfjuV/E2k6JoAZZ9qdjoEyttoCdFYefPmZj4HsoxgViYK105V3mLGCqTaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS1PR04MB9430.eurprd04.prod.outlook.com (2603:10a6:20b:4da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Wed, 27 Aug
 2025 15:23:08 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Wed, 27 Aug 2025
 15:23:08 +0000
Date: Wed, 27 Aug 2025 11:23:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] docs: dt: writing-bindings: Add exception for
 clock-names
Message-ID: <aK8i1GTp2vPI8g2C@lizhi-Precision-Tower-5810>
References: <20250826151650.9396-1-Frank.Li@nxp.com>
 <20250826235519.GA766501-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826235519.GA766501-robh@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS1PR04MB9430:EE_
X-MS-Office365-Filtering-Correlation-Id: 079723d3-8ea1-4414-e927-08dde57da030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nnrNaa2yTqowYJviXySwP7Km4ak6NhFNOvgXBHUtAe3JyfR6oprgDhDPkfLr?=
 =?us-ascii?Q?9WIG/aO7O0CiJ1UoL3Hn15tZLH9aUGIH8FuLvO2mw1rN2nIISGCMVnfora8r?=
 =?us-ascii?Q?FC11X6vtFIyiWwnGzQDqEdhQKAgQkTWRrngBm7S0UijQJ6u0g4uJaZEt/LWt?=
 =?us-ascii?Q?LiVIqgUxp5DU9hCQQhu1/Xm4Guq4DNuu/Wz+kCP1eHaKpeV0YJgDDhve+Hi5?=
 =?us-ascii?Q?/2yFhFcvsgi6V7ZOlz6IKWlPqbGvqHVzKbBag4UF7qCovoW3cRP3HVEOZ1ol?=
 =?us-ascii?Q?U+JUyvtuhwFoNTyzI+CVcO6TMdNUqubR1ZwNbCMNuyVNmnLe7SS/pQJkxUrc?=
 =?us-ascii?Q?d9IczDH+5dkV6qDuOxxlTuKk2ugk70j2rkhF4O0wjbQ1flwv0cZFZ5mT5N1y?=
 =?us-ascii?Q?CjGz6MNsfqJbsu9sjXAMcPqT1dYnymtw3ks+jwd7kwiFy1euBzHqOSZRNmi1?=
 =?us-ascii?Q?uoO9ZIDZnZS1XqqgJFFlbHldlxNNmIiHp6cfjAx7lOKCuEOA7bktc1jD1ZXR?=
 =?us-ascii?Q?TUs4TyKAv8bbrtp8kzP9BacG+kjeEDZfvLJL8vnNYx9O/qi3gz0nhHD00wfr?=
 =?us-ascii?Q?wr6xyrb89zerRBNNB+csQPiaiN+kjM9hnj4gTLrZfTpfSujlrHXB9dNOzTO0?=
 =?us-ascii?Q?gEkN60XRTJnhLCXo67b2lRloW+nisIoHS6Q8yqGeVp+Pajg1k177qEbLdZFW?=
 =?us-ascii?Q?A/fnQrA6fVpQOX7dfC2lB1w10fqJSXLblyBgCnWpbCNSZp1OxeM8aFCQjI1y?=
 =?us-ascii?Q?FNEtiUpqhljKF1+wkDOmu7QjIwr43Wnl3p8D6VlEpsCnrYkqVzK92YT1w+ne?=
 =?us-ascii?Q?BpBItylmzKfhIEWs28ztZh8lV1LNASZCNImUw2WSa06VIbs75eOuTgGJ3I3x?=
 =?us-ascii?Q?W0ZwktAf+/KuhE6s8DAl62wzEqLJOPvUoK60+UwdQfU+s7Qxejf5cQgVyh88?=
 =?us-ascii?Q?v6wc0OHgxuKoSypOh1DDUjuiNfwUCr4bJ3rrk61gNoUQdwFPtmLDozhHrxa8?=
 =?us-ascii?Q?zGVhgY/hEnmPOxt3T4oU2mqg5rx9bmhPRTVV8wykyG+TNXrc9NrKyTh1bfYp?=
 =?us-ascii?Q?nQNDBFQWBqlV+fmWxyiaL+wJzG2QHfH8s4njWQ8+hcA2EbqBUZEvxl1VQVIr?=
 =?us-ascii?Q?fOIP0KuwBej+0ol7MVlw/bhG8je7zpiR5aWAK5mIJFk1mGBnMVmToe4814qX?=
 =?us-ascii?Q?PHPftO2YgMe1q2VtinLhuAjW8fBjwQ4Tw6W4xH/zz/asQVsYDNdTKF9QWwLt?=
 =?us-ascii?Q?g6mQ3GLzbbvTBqaIxwZDu9RAF8Hyr4SAo61F9vM1SXLWfo0E4zTG+sKknDcE?=
 =?us-ascii?Q?aXXHo7HJxwMZFNqAfkXQMzP/8fo3O6jbW+xBEV8cMH5sKx+MCpfnZLljWe+y?=
 =?us-ascii?Q?v9Y+k7ey/9ODsqQ5IPgsZ9QNpqgidBsq9XC/kkfLG97q23fM+vK+LjqOelgb?=
 =?us-ascii?Q?UT22wH2nlDISvbO/NBm8KmvZRclzNrNSyjYScQQ4J4CnLmdYInro4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DsTODw6KGC7xMBLW3mfODZLlgGMZXPZ5nu6cDu7Pp3JOOHHsAf35/0BST+6j?=
 =?us-ascii?Q?ZGWR4FEBkLsq7k+5mu2RpHTetk7pVCqrutuJGBR3iE8q9ivZSSKYqoZZ7sYK?=
 =?us-ascii?Q?GlnVC48TuQQCOZOKYLguDflSkf8MUG2QQJLoBskB7h1o5WhrgprCGCu4ZiDd?=
 =?us-ascii?Q?/PJn093tSpHOfDbcRunnHbTxUCRXqms3Gzi6YoKkvzVUIVXiZLu/Wkwg6f74?=
 =?us-ascii?Q?Ci2whh3TWFJdiBYGJZ4rs2EaDH4Nm4ZBrR+RP7l1xankW6wbXEau9CRcY6vS?=
 =?us-ascii?Q?Fm+YHkHsUx6MdSGF+dsdMUXlcoifdevhWZr3AerRqWdutoA44ZHNzMvAR9e6?=
 =?us-ascii?Q?kAjZlY3Omuxaeiy+pqYEl40H6vig3MMsXAH/FRByl+/2zSpNh7WvnhgWc9rY?=
 =?us-ascii?Q?fKCDq0eZmcDfTSWXGGkjKsrYDay7o6pgKx334msm78pz244nGtIsKD6cQbMj?=
 =?us-ascii?Q?w5n1JeQuGXBWPlPMNicPEMp6h8n0gi2AfdJ0w3veVPERGQeQG6u8VKxUm4Ih?=
 =?us-ascii?Q?NxkC9Nz4ECN5dmtC38qkdjIHtmA5L3Dn6E0CeL7VAo/bIj5fAjnZ1g73lQH1?=
 =?us-ascii?Q?OF9J/idqT+J7H2zNxmMnEX6jqPG9wUKaVxhcH5rJXiXqOnnREE8uPo5+Setq?=
 =?us-ascii?Q?9a2iS5h2rqYduyjjoVpbpGlRLLWERYx13WROIZu4hXurFo+dwk+rkYI5HSqk?=
 =?us-ascii?Q?m1CQkH1CwruUbBVTq96uYNNpKBoD7IMPugIQMc/XhRFUZbgiVfxbc9/GSjYW?=
 =?us-ascii?Q?WIQT/IuTmg1ZkzzA8wagT2/DuVGPhU8pQoK8zqmDxQig7kbmZpAWOdJxIQIh?=
 =?us-ascii?Q?tKhaZT5fFUPjLybexEcMT9TJeEoyP+iDNPDot/qlTTYyOVdcCqu88EvMldFr?=
 =?us-ascii?Q?VQH8y3+VGjYLLoqsprhXUHfaIJXa3M0i7KNC3OmvWmLUs2eJNsHgYTupaWwD?=
 =?us-ascii?Q?FByA1pTL3QYla4zF1rEZUn3tXQA3Dz6uT+LeTv0yRnhURu8y1oo6LKBD9dHs?=
 =?us-ascii?Q?Hkg96zilWnwxMIu+elnyGLOOXD4ppqNjbW0A7p9C+1W8uC9xEkPU1IPKMPSQ?=
 =?us-ascii?Q?3RM09phXiJ0FMxPZF0T/cINNvd7gkAVSDt44YO8ppTOZhuHsmxlk8O2r0PKr?=
 =?us-ascii?Q?QLkLBtB2z7Lu+nLimT3Ce1DykpOarSRxACTHPyAMSC7Sh28cGB5Q/pLZrSP+?=
 =?us-ascii?Q?980SP1U7UIzoUu7JHhPH9qaGw6L/gwK7cxJObE5QXMUqaayg8YGxKOupkAx6?=
 =?us-ascii?Q?Gf5fjV18j1jo2mEhz00/GOLwsg/BB5H+QiLymSvcCLNdRSY5XEmk8Xz05M2J?=
 =?us-ascii?Q?0ELoD0SoRh2oh21K050s8g7HHf/hboTXNu4SbmWRpRSg7/NbDnCoI0jg9lzH?=
 =?us-ascii?Q?zon6SX5IcEKs28MlZ37Za+PzTDuux+cxRuGv+eljt9DebPsI7G7fVVHNex1H?=
 =?us-ascii?Q?wfXdtdFpgwA3omTHuouVc2+ZG/OF69T2HtaJDqRkeo8gJwKZoDlRDkIxlYlS?=
 =?us-ascii?Q?Y9NGftfQygQ0p3xVk2PGG0Ri6dHD6LH5fWxCgEkgAPDZ8QmdE4BRwb5bfwrT?=
 =?us-ascii?Q?CTOB/rUpDoX+rQl0xm/1BUsZSJ848amvKsU7TReU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079723d3-8ea1-4414-e927-08dde57da030
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:23:08.0889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfLisikSObLT53RSPJvvdRG5dx0Jsxq5AaxW6bZ3nj5RVtb5fKt7u9mQw6/yvk9WAfaaTxXWp/4gRHcm1hPXeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9430

On Tue, Aug 26, 2025 at 06:55:19PM -0500, Rob Herring wrote:
> On Tue, Aug 26, 2025 at 11:16:49AM -0400, Frank Li wrote:
> > Allow pattern like "pclk" and "hclk" as clock-names.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > https://lore.kernel.org/linux-i3c/20250625200451.GA2117971-robh@kernel.org/
> > ---
> >  Documentation/devicetree/bindings/writing-bindings.rst | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/writing-bindings.rst b/Documentation/devicetree/bindings/writing-bindings.rst
> > index 667816dd7d504..81f76ca57a394 100644
> > --- a/Documentation/devicetree/bindings/writing-bindings.rst
> > +++ b/Documentation/devicetree/bindings/writing-bindings.rst
> > @@ -97,7 +97,8 @@ Typical cases and caveats
> >    constraints (e.g. list of items).
> >
> >  - For names used in {clock,dma,interrupt,reset}-names, do not add any suffix,
> > -  e.g.: "tx" instead of "txirq" (for interrupt).
> > +  e.g.: "tx" instead of "txirq" (for interrupt). Except when only single letter
> > +  remains after removing the suffix, e.g., 'pclk', 'hclk'.
>
> It's more that the examples are the hardware names for the clocks than
> a single letter is too terse.

Yes, some hardware signal use name pclk, look like [X]clk name also from
hardware. How to document it here? It breaks "do not add any suffix" and
this name is allowed.

Some hardware use quite long name like ipg-clk. just need ipg in binding.

Frank
>
> Rob

