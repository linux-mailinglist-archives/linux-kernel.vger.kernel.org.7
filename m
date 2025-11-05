Return-Path: <linux-kernel+bounces-886996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B58C36EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D7E234F7E6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5D233F8C0;
	Wed,  5 Nov 2025 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kL2ngA0/"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013051.outbound.protection.outlook.com [40.107.162.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8622330313;
	Wed,  5 Nov 2025 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362202; cv=fail; b=ZluOsB4/E4dAn7ZqzFeAt0x68/yOa6/5Y7XQoUS7bfH2DklLFspvW8a5RF1uUcvPTPLRdLJedzkS2v3ulghJejsiTdQCQN9TzQeAebDlDCjHbQQpjHJ3FJdPFHlZaZMxPg06XwouJJ1aDlbOaE5LKCz8q7gY6lR+U5WCqplB7Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362202; c=relaxed/simple;
	bh=v0dwQ6MaugWSJx4KbwhUKZc4SmxFeWJYAiMW3AMudNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JkuVFmaweBkavLIiBfccitFIBlpPSsxlG+bERqFCuPN58sMOypYNGcCxAQcDqQaGb8PQe8cpLNvrkRmj9M7OL7ZfzuVhuuYqc6ZpqJASNa5bZV12q1P2uCKrtaRoErKA4XcHB/b5/lNFgCv7plblY3dUyH82/PfQ3KrZ7ReUIAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kL2ngA0/; arc=fail smtp.client-ip=40.107.162.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBPn1S3nDN6tOSxCjuwRpOwQWXJg16ZTgDFA1CQjY1cjfsqhWDU0bUMsYk6Bl8reCTeKGauNAMjBt2znRMGG44pdfc52k4pLbJFH7mGeXWpu3W5fkZZRLBBd65Z5pOHfDP7uKq5cxvIk0t92Rife645vcsKNAN3N7Dss5YWnEtMUVmAL83AKGvrQjPWJ65zOUqUrE0EEUH6MO7CIMjGmY/2d1r4SfbiDpFSY3QlB9qJCE/qBL7ZcY/G9kjt20s4xhiCurGk4tEGkNBD5wZVA6rdtY9McLK0zP4Ghx4y+Nl2QoJZEGwRCH588KnRDNw+c4UYoSlDm3VwK6J53SPfngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4VND57RZ5g7hEkU7lYuEU+/demwOcf6B5ulu0+YVUo=;
 b=Jg4FKun9f5N7Xdz17Hr09MkPRhP72TYbFTUg/6fYtmfDHAQDBKRZm1dkds/BvaI+VodnwThk3ojvUbA0uN/FY0dPKViIfv8UsGSDbKJprQpoMtC2NtzOgrbVGYFBu2o2onuUGkBd51juTIFuK0/GgivtOzCF/KZqLvN5wYfeVtwEjEBBCSAE/+r7cGCPNYUjAAMKsI86fN5fdTTw2FGWDIHDkd3wiqTDQzenUmwNHIACJ6rgpG6vuKmTkC3dGR9Gqfi55y418qEXe96hmmg0sHEpCfFYMUyW5BbahFgSHNm/MBMYrM921SsjakFFtuj8jOSmdJ0gjY1n6bfiGNnfdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4VND57RZ5g7hEkU7lYuEU+/demwOcf6B5ulu0+YVUo=;
 b=kL2ngA0/3m53DzIN93l4LVaZt0em2JadLN7gpIUGWbv0ZZGb5iWXfNbrRuWnDCeMOHjQQcMHrR9eJZhU7K8oB3mMMdnmH64rqG5UwLalcJXILnA5RmUBIZaCmDWH2T/ogpLH+gfbgcmeYrVnkM9Cxor0LQgkkWXYs8PC5qnZm9/RuVFSmz4GXmwJh3FBjcy/xKjUFROLCZru31abruLyUREkKkS72cxgN+HIUGL1q8nsUytnYqvpry4Vr94wVr5Zs4/jYIE3yKWeTHK8kGAjQjf3ncGddgiQO4c7NgreYGhHLcHrRgNZar74HsIhWumWypOqeOjtJBp8wTDnrs93iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV4PR04MB11976.eurprd04.prod.outlook.com (2603:10a6:150:2e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 17:03:15 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 17:03:15 +0000
Date: Wed, 5 Nov 2025 12:03:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Alice Yuan <alice.yuan@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Robert Chiras <robert.chiras@nxp.com>,
	Zhipeng Wang <zhipeng.wang_1@nxp.com>
Subject: Re: [PATCH v4 0/5] media: imx8qxp: add parallel camera support
Message-ID: <aQuDSROHLGHIhtlh@lizhi-Precision-Tower-5810>
References: <20250729-imx8qxp_pcam-v4-0-4dfca4ed2f87@nxp.com>
 <20250805010822.GC24627@pendragon.ideasonboard.com>
 <aLbcpEZXm5G1Onq7@lizhi-Precision-Tower-5810>
 <20250902123920.GM13448@pendragon.ideasonboard.com>
 <aLhJDXnz9HPGrWcp@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhJDXnz9HPGrWcp@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV4PR04MB11976:EE_
X-MS-Office365-Filtering-Correlation-Id: 397bd3b2-75ca-4d14-0ba4-08de1c8d3615
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?he80D24URKmrx85vvZuwzgi/FIuqIjw41rLbvspuCBlduQ3mpHqcFttEtchf?=
 =?us-ascii?Q?1fc8QSCLdERhxJGA479sJD2RPsQkTOo5FcqgwHxMUo2ReNXXwyNcN8yBw8C+?=
 =?us-ascii?Q?ODXsA5pAFBq6zenXtVbxmOXUQC2+bVr5p04cmOW8mmT8yEDkIs2gLRL6nfd5?=
 =?us-ascii?Q?qVCjzf3EUByneTBO/YBHnR1CPHEEruixlVXfsZG0+BCWoZLBbQbXhi3LIUsK?=
 =?us-ascii?Q?ewJ42eWSGKowO0hmrYt/oF0hED1Gr3QhpLqCqft6kC8liPaAOUNcxgr0Xgde?=
 =?us-ascii?Q?SYuzS4oz5dP/rxPkNoYxVt5/euar3KCLr4EV7/kccejgKo4D49cg69yA0hGs?=
 =?us-ascii?Q?/Yo6QrUXrSONiSkSQ5WBohuEa+EhI5tjE9P7h2t7Suo7ApJFrKoYr3sZiGYx?=
 =?us-ascii?Q?j3cHpQDnyLKZD5UcEyunFlOl9HoI/KmepLmJNFm2LyYTQBzXGSVEIKlGePQ/?=
 =?us-ascii?Q?PUoss8wKOi87HaiZcMNExht6mx/tRYWDeNdWO26xybMqpHXfAows244H43Hb?=
 =?us-ascii?Q?io+As/mhf05rRDHGEEsjCxlKivcVcVZ4sm0ALd0KnzQ6ZZm7v30VZruYnFVM?=
 =?us-ascii?Q?PAtqqcAQlkzIQNOeiMKNIoiRaUD1szDHTe7v88BfUtbmp3qZkuR/q+I7vFl8?=
 =?us-ascii?Q?gIEAzs7LHVff9l3uWzZcCP0s8QJLcis9ZbUdYUH6D1aOQvZC/ooK1f1C2ekS?=
 =?us-ascii?Q?HonOchS1ShROi9KwC6nrR+L6T/ZBoBvJZt4XaA0BavDRwQA2xW1q8+gX5J7o?=
 =?us-ascii?Q?3VAKwBFITvC8LUvzHOLuTPZgL2W2i/SLp7d5ZdACatOneVwssdzdXX4BF0Y5?=
 =?us-ascii?Q?bqvF6wFP/FcZ3W8jhKNFBOr4fqPzlTdNSnFGkWKgU6eMgzmG7aQWOXEw05W/?=
 =?us-ascii?Q?2xeYEKajfS7ZhZ/rEPQ6ujWg6Hmb+OySrpJjfYN0pFQcQ2eRXLzhcaacNobm?=
 =?us-ascii?Q?rzkKrbmBTBZRWGv7V3kO1KxRJAuimvTM4VNN4pWsFCd4Ue36GtHBbEbPA9pv?=
 =?us-ascii?Q?oKt4pcYRsz4mQmc9lsU83xcoefu9GLASJE4WZsbVNWwlS45yekG9BNGvmZnF?=
 =?us-ascii?Q?vAS5L6yspXJjRPbIhLSOZLxzSJjlD+TRoF4icxm9fxAos5fhgRLemJ5POU4Y?=
 =?us-ascii?Q?x/L66yNERnX2sEb3j5y2RERm3/FhkgKM3mxS3EBPYlJPnUGlI62tJmQWq89p?=
 =?us-ascii?Q?QrphK9p+19leSVaQPPKQSC11R66N5yfJK/jUkZ4t/cRendd2U1yi9/ZPaXJr?=
 =?us-ascii?Q?j3aS+PZ9iiD0hOHJITqX8Td31XE9Tt5av8lvkijCU+2S6XettrT/cgRsuMZQ?=
 =?us-ascii?Q?zeBotoKQW8YNediF6xr/FwuTZOYKA+s4I0FjxEBLTbzN1vyhDGZQtZ3suku9?=
 =?us-ascii?Q?Sx7QDWV0g6WYsOPNuI2UENV0tJX6s34TNmyzHvpua6SSWB+GPh8DsoSUWDrC?=
 =?us-ascii?Q?aJmK9PxrQwovs1pS/hByVfOhiaqY9lmUAXuYMrEK4r1oBZveQLeN5hKSvpJC?=
 =?us-ascii?Q?WFfeQ2QxOoxBjDtLOxha0U8dbLvxQOlGGyDY?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?J8GAAGnV0w6tIbw7RpXIMhh8I1qYFVqUmJwIb60xwnXNfHYUN4AxrgHRHDFx?=
 =?us-ascii?Q?ENcQjcRSOsHJG+G8FOk03xsuHn18WaggoRLHF+or/nf4SroS++NJnlgt4qeR?=
 =?us-ascii?Q?19k02hAdZ6Wao8sWRAP7vofrWmtJafLo1QQvFxxnNBK90lobYtoVyuajunM9?=
 =?us-ascii?Q?rxmEXHDHB6m6f0GLIkKEQw0NfXE80zzR4+VH1/RMt5RbCZszw+mT+hFB1jng?=
 =?us-ascii?Q?pF1Lr9PHMOkqynHk8J1+kUuCFReOMZa1L70ZCmxvXw7lkeDvpnuhFgX3db83?=
 =?us-ascii?Q?WPZnX1foL/C3geNIw2NjH6iCpzsQLZCNQoGkfMDjiuSxqDB5Swuohhp1OVjQ?=
 =?us-ascii?Q?1BkRfwuPtP8LiJ5G6EhvNuj6LNXv0rP55nNEs9tCOEFD6XaZnfx267cBcxdV?=
 =?us-ascii?Q?aPOidwy/QRwhj9M/l3zwO3Lauz0gqkJwY4VSH4PaMfqDSblsK/278PdSGwii?=
 =?us-ascii?Q?5qxN2s1eaPR9oArL1Cj+HisdrI+O6kRZO6/+aagIDLjfNe/mMJ/Jm+f/lseX?=
 =?us-ascii?Q?DFSjPzw+BUEatn96z+HnS+fYYFMHXIu3DxG2RuRavafKCAHTexA2zEwq8fJ7?=
 =?us-ascii?Q?fTykUMXdIFLrGUCj5aHqNTpvl9K1pc4Id1VRu/Kw3sUb/pHbUDfh/zJ3925V?=
 =?us-ascii?Q?VKLhzN15AcVn6MPreBVa0POUS7+bqyf/Ai1tW8bOcsRE5B3ZEe0Ksxrjd9Be?=
 =?us-ascii?Q?IMeN7XIWHfqAKz0yA6k/9ha/lRlYrs3So4EjwbKdYxLhwdXrkuavm6yBcmj6?=
 =?us-ascii?Q?sEtWKB1zu4YMRxItq+2cAcmRumY8zjh+sRYtgRDrckOc6x/LrZAshfBeYpHU?=
 =?us-ascii?Q?3SWCNXPQKsRMrPp7pdmy46TbOjz+HlVcy92JNbeXSYCZ++HOjrB33mCHHQhf?=
 =?us-ascii?Q?mRHS3ZCtopo1vdA6YhrmHm45DMrjtdgB9eIJHt7Ymje7WErQcWITkd/JsIBa?=
 =?us-ascii?Q?+vckL/CLUKPHqVETIxniQrlHqjAw6z6/EWn+518u6vhmyMdwUqyv92PAMkLD?=
 =?us-ascii?Q?xz9ZBAdUe2aZiG9xu6kbBmGaktXb//qnXPo4pm7bbm+Y/M6KaM3ce8KPnBle?=
 =?us-ascii?Q?Az/Kw/BXlknAR7D7JFEYY4i9P1UtnsLBkIhLKbKJBXRKrew3t8kUsnr7T4RC?=
 =?us-ascii?Q?WL/0CvXAFHKJ9WHWwT2FVMccRouT6PNOlOQ0RYKei1PkIqAm498CJ8oQ11Ls?=
 =?us-ascii?Q?e+p1klZGIz5NRUL70K6DBABtBbEjF1hYDPJYuKAOU8YZgQduKG7zGog4jAHr?=
 =?us-ascii?Q?xUh+YljKnXJ2x8KNdVdQ347gbWGdgyoSjS0maRbOlUm0OFLj0Q3szHKMB9ML?=
 =?us-ascii?Q?BvuQN95tJwidirqzzrjn/XwtDTWY8iHfb1KkmfFwc79kV1IIAk2xsEnb8Q76?=
 =?us-ascii?Q?q4tSJo2d9EguPFRdgbtTmZwJkDJdY9Lp85lU/U9vKmQwb1LMh2VfyreA6adA?=
 =?us-ascii?Q?GUOT4kmM17L+dlU3R69wLR0Y0bbXwyUWK05KQnTY9/Ej5Jr8rwaG7987mNtz?=
 =?us-ascii?Q?c3kviTvxpm/XK2X2FQ3HGNlCsRV8lDW7v6WxkfIfaMcbSfZKwjE1Yiv9fD95?=
 =?us-ascii?Q?cFTjao50e/2pS+9b51oP43jLmqZgTMTyWf6LFtrX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397bd3b2-75ca-4d14-0ba4-08de1c8d3615
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 17:03:15.8163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALY27OP02BiNDkGVyvzrgyzzzrmHMl7wfKPRGJ0fcPKmDQuxBt/VdqF+SxrbmfxvtXKv4sAHRDIFCVVLXKSJeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11976

On Wed, Sep 03, 2025 at 09:56:29AM -0400, Frank Li wrote:
> On Tue, Sep 02, 2025 at 02:39:20PM +0200, Laurent Pinchart wrote:
> > Hi Frank,
> >
> > On Tue, Sep 02, 2025 at 08:01:40AM -0400, Frank Li wrote:
> > > On Tue, Aug 05, 2025 at 04:08:22AM +0300, Laurent Pinchart wrote:
> > > > Hi Frank,
> > > >
> > > > Thank you for the patches.
> > > >
> > > > I've quite busy these days, and I don't believe I will have time to
> > > > review this series before coming back from OSS Europe at the beginning
> > > > of September. Let's see if anyone on CC could volunteer.
> > >
> > > Laurent Pincha
> > > 	I hope you have good time at OSS.
> > >
> > > 	Do you have chance to review this patch?
> >
> > I'm going through my mail backlog, which is really big at the moment.
>
> Understand.
>
> > I'd like someone else to volunteer to review this series. It won't scale
> > if I have to review all NXP media patches in my spare time :-/
>
> Yes, but none volunteer review this in passed months. Expecially key
> reviewer. I am reviewing i3c patches. but Not familiar v4l system yet. It
> need scalable solution. I can help filter some common and simple problem
> from beginning.

Laurent Pinchart:

	Do you have chance to check this serise? this one should be related
simple.
	This one sent at 7/29. Still not any volunteer to review it. How
do we move forward?

Frank

>
> Frank
>
> >
> > > > On Tue, Jul 29, 2025 at 12:06:21PM -0400, Frank Li wrote:
> > > > > Add parallel camera support for i.MX8 chips.
> > > > >
> > > > > The below patch to add new format support to test ov5640 sensor
> > > > >    media: nxp: isi: add support for UYVY8_2X8 and YUYV8_2X8 bus codes
> > > > >
> > > > > The bindings and driver for parallel CSI
> > > > >    dt-bindings: media: add i.MX parallel csi support
> > > > >    media: nxp: add V4L2 subdev driver for parallel CSI
> > > > >
> > > > > DTS part need depend on previous MIPI CSI patches.
> > > > >   https://lore.kernel.org/imx/20250522-8qxp_camera-v5-13-d4be869fdb7e@nxp.com/
> > > > >
> > > > >   arm64: dts: imx8: add parellel csi nodes
> > > > >   arm64: dts: imx8qxp-mek: add parallel ov5640 camera support
> > > > >
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > > Changes in v4:
> > > > > - remove imx93 driver support since have not camera sensor module to do test now.
> > > > >   Add it later
> > > > > - Add new patch
> > > > >   media: v4l2-common: Add helper function v4l_get_required_align_by_bpp()
> > > > > - See each patche's change log for detail.
> > > > > - Link to v3: https://lore.kernel.org/r/20250708-imx8qxp_pcam-v3-0-c8533e405df1@nxp.com
> > > > >
> > > > > Changes in v3:
> > > > > - replace CSI with CPI.
> > > > > - detail change see each patch's change logs
> > > > > - Link to v2: https://lore.kernel.org/r/20250703-imx8qxp_pcam-v2-0-188be85f06f1@nxp.com
> > > > >
> > > > > Changes in v2:
> > > > > - remove patch media: nxp: isi: add support for UYVY8_2X8 and YUYV8_2X8 bus codes
> > > > >   because pcif controller convert 2x8 to 1x16 to match isi's input
> > > > > - rename comaptible string to fsl,imx8qxp-pcif
> > > > > - See each patches's change log for detail
> > > > > - Link to v1: https://lore.kernel.org/r/20250630-imx8qxp_pcam-v1-0-eccd38d99201@nxp.com
> > > > >
> > > > > ---
> > > > > Alice Yuan (2):
> > > > >       dt-bindings: media: add i.MX parallel CPI support
> > > > >       media: nxp: add V4L2 subdev driver for camera parallel interface (CPI)
> > > > >
> > > > > Frank Li (3):
> > > > >       media: v4l2-common: Add helper function v4l_get_required_align_by_bpp()
> > > > >       arm64: dts: imx8: add camera parallel interface (CPI) node
> > > > >       arm64: dts: imx8qxp-mek: add parallel ov5640 camera support
> > > > >
> > > > >  .../devicetree/bindings/media/fsl,imx93-pcif.yaml  | 126 ++++
> > > > >  MAINTAINERS                                        |   2 +
> > > > >  arch/arm64/boot/dts/freescale/Makefile             |   3 +
> > > > >  arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi     |  13 +
> > > > >  .../boot/dts/freescale/imx8qxp-mek-ov5640-cpi.dtso |  83 +++
> > > > >  arch/arm64/boot/dts/freescale/imx8qxp-ss-img.dtsi  |  27 +
> > > > >  drivers/media/platform/nxp/Kconfig                 |  11 +
> > > > >  drivers/media/platform/nxp/Makefile                |   1 +
> > > > >  drivers/media/platform/nxp/imx-parallel-cpi.c      | 728 +++++++++++++++++++++
> > > > >  include/media/v4l2-common.h                        |  30 +
> > > > >  10 files changed, 1024 insertions(+)
> > > > > ---
> > > > > base-commit: 37a294c6211bea9deb14bedd2dcce498935cbd4e
> > > > > change-id: 20250626-imx8qxp_pcam-d851238343c3
> >
> > --
> > Regards,
> >
> > Laurent Pinchart

