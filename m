Return-Path: <linux-kernel+bounces-840164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E460FBB3B91
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612F618909CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A08730F934;
	Thu,  2 Oct 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mxr0boh1"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813EF27B35F;
	Thu,  2 Oct 2025 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403652; cv=fail; b=RnXsWL8Qfi+A6g9muKWIWm7NoK0X1PGLb5wIOWHX84qBIQnvPAIRRAEA6Kmq+I+6xL2QOu5NJPgQpvFiEVCo69FJULo7cyAKWv0hdEaSsgHftWKXkemdzhbA4cjDQi55S9Na4w+reQ4elvRT/r6R78rY4LwPup5JRuR0Qd5vVp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403652; c=relaxed/simple;
	bh=ktgsQsxeQCFUzjLqJRq/i/zX3sRkAkDntoQl9mde6bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CNGNCmcpX+YyiFJDuxm1rKhLdfKSydOFrtEO7xYDZLkqHFzQsxjliHUcSrG8tvLzAIUcsQrjDnKEDjAB0y9SvJLEVoUZvpu0nnoSaRLPQdmIKiXB7WHaKino6Y975VQ0Tnvu7Le0pD4WTqqIpcPG/GUJe4rpEVQIce4eCO4Bi7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mxr0boh1; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfaSmM74ndSMcTZjCzNM/goFNoRw3n0k1rvzIeHGPZW0xlErLFeFaVho2QibxI/9XTN0L6YY1OsQJFklHW9MBjNuKI6THX7bxGwTDPSMnOGfxEQxCOWklA7Zjnc9y8paAJ/z39UlL2LYg4phD0js89F5KZYtzpEEnetZshEnPPbZFELI7VGrzxHQn6JTWTIoDzqD3n+MWMxTTqTeu7/VPeNRkrsDifD2Ipqc7AjOxaiiOiTqeXKJQlLKz4zVTHuW4ruOXG6jnGb8HfMNNpVNO0/d61EhDqsoPcFPU7i7k+gYg6tIFu0TIPLOnIT5NlIMOxxWmJiY5xyFUjEA4uWEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XYHU4CH0Yevxp3xguH6qN8hw4acjIQ30RfhOf2nfrU=;
 b=yrAzYAfJiIK8tEZ01lGOgW074fTqrhGSadiXjLgDumJae9I9T0aLn6aNzGYj0enlRHfLM5gdam8tZd9NLYaATVXRDtcES9YVMboAWmwmch+5kdM9xJ0UXGijmF98P3osvSpGfPJu3KFBHXC2k9dBSEBpQjWfYGobXZWCF8hnkzN20LwJC/o74WFBBfFi5wMN+hyBdQMCoe7A61JVQlfGuyiil9pIaoZOY5aNSoYr53W7KmYm2nc5yTKl66sSvRXIgxeSKn+3qe0rHd5Rt9bBsFjg2YLyRJCFcabAhAnhJicOv7gHF9S3tZNVxoG/2aJwRSXBTK2tePdEvtlSpUg+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XYHU4CH0Yevxp3xguH6qN8hw4acjIQ30RfhOf2nfrU=;
 b=mxr0boh1fxtxB1KBXDGV2tUWNqgE2ozQ8hshKQELIzu1FrTGz2fV66tlNE1yaDgkk6VGXm2ut4LZfdFIuBDzC8wvQ1wmm1+k1klrSBbGXAYBEuUd4Lxo7uO0wh1kgv6AqrwBr3vg6C4rfpba0eO8/9WpHQbobDwpNJONso3FJWKTf0WALHtaHSkXb3PUtMD7ucCHd2UsNxAEAD6D9NMJBdlk9Dm7l0KVxsgn4LN5gZPbLreGwzxDiHHbq//gR3BZSmXMaEbXU8ADnUqkKLB7ggxmtXAX5Z0adRFANoV5YJeavz4aZUVQZoQBNhLKPZH+asqY5GKf4LRqmeyTsYvSzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8993.eurprd04.prod.outlook.com (2603:10a6:20b:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.15; Thu, 2 Oct
 2025 11:14:03 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9182.013; Thu, 2 Oct 2025
 11:14:03 +0000
Date: Thu, 2 Oct 2025 14:14:00 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 phy 13/17] phy: lynx-28g: probe on per-SoC and
 per-instance compatible strings
Message-ID: <20251002111400.ezfk57c5mwga33re@skbuf>
References: <20250926180505.760089-1-vladimir.oltean@nxp.com>
 <20250926180505.760089-14-vladimir.oltean@nxp.com>
 <1ec4002f-6c5a-4f64-8ba7-7f991b0f3f75@solid-run.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec4002f-6c5a-4f64-8ba7-7f991b0f3f75@solid-run.com>
X-ClientProxiedBy: VI1PR0102CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c85827-699f-45cf-c5fc-08de01a4cb95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|19092799006|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oh/PBJ1lmgTxdrwdqQWzZSaRY08H+2n3Lln5U6Weq0kVYq6M6KWkEuAZOXsF?=
 =?us-ascii?Q?yxeu80RTCM/1VlelJrtFMy49VN+snXWvlQbzMazaK+0bMpNb5uqrN/qnpjad?=
 =?us-ascii?Q?ssQX945DiyP5ILh31GPhkonHT7Rc+SRmT4t5IK+4tYDQjExdLiFfd7W26mE2?=
 =?us-ascii?Q?zu+2ycEAClJk3ahECy/OcTdi0IEClab6V7GB3jbaix09h2hRJNnDae9jakEj?=
 =?us-ascii?Q?xCZZBZ+KG2MT51WYW1gp1RpG7p4VhRxHgQuuPzywdd3qzgaCpJYUOX6M0KeT?=
 =?us-ascii?Q?qJV4mTD46DGHsiyf/DqcRU3oDOVdswukRWyayHaL+l2cAneHODbeYM9eCdmn?=
 =?us-ascii?Q?vp/U9MykQPD3d6uP+uM70DHilZKkXCjiyEOZIRqtSHEiX60AfM3+fsZrQkaJ?=
 =?us-ascii?Q?Ewq5YrFhuo2L8Qr61i7+3+qB2eEjXTzddTrnP+IWsZX0WDO/xdKkgyAvv3f3?=
 =?us-ascii?Q?OiuMVEmKGDuUmrWjJiBM9O9CN18CyLloayV48h1yao28W0OuI1nhfYcN9GHO?=
 =?us-ascii?Q?R5uCZQqKq7PRnTeYUe8HkRtllBMZGaAQEUZE8WKQJKLLH/oxAS8D7u040BAn?=
 =?us-ascii?Q?p92QG6byCGWfwM0MUfTX8tp8bpFKh9F5ZPST/ZPEJMc2QLTDo6zOlwb3O5dw?=
 =?us-ascii?Q?zlfn4kcUfxitNRlKT9moHEcbmLoO1ltGKVFjbMwJo0cIsaCAOZrHuncCkjAA?=
 =?us-ascii?Q?CQXpIS9QiI1BLiKh8mavhr461na0OTuplQahUwIbdT32uJDrFggCGRV2tag+?=
 =?us-ascii?Q?CMcZzGq6AItXGFcAum95/3KolE/NQs80eANq3yjgburl7NvHUJneh80N52SS?=
 =?us-ascii?Q?2bozW3eV0q0VkskkSpAdn0h86CgV2bDhfyG2XeOd7jLSp0HbN+vpKpNSU7hX?=
 =?us-ascii?Q?NMyCw24e+UTz1DzdpdoaZ1S5kjUHKG2TZU37UAE3j0r8ShbnrK5wM3wJGu0G?=
 =?us-ascii?Q?/OUPZ02OXLp+fPnU4IL7wE9tugVb8VFQo5T+JmI5klaahwGXYOIojidFkwAA?=
 =?us-ascii?Q?nV2pr6TPpcu2hpzS4f7RzC/NXEtMqAJi/ar73C4B1tKYCrasF0braX1LJ7rm?=
 =?us-ascii?Q?XBfZDOpDNQxsWcqJWc6eBd9DQY1ua7DWSq9dTuI0qY/0Q6UBzH8/ILIF5zPR?=
 =?us-ascii?Q?/WxDQgqMOGpqB251RrnwylQMHk2D+xOp0SSf6gc3sEmS6/Nx9lE0vTY78uUo?=
 =?us-ascii?Q?yaqZbH6i2GOKByFsOKeT0tvKqDTewf68taWTroNXkM6b3MWAEGdtU7Bk6k/T?=
 =?us-ascii?Q?Y13geNka0tWXBv4Q4ppg55XkiZQH++ZpsxCcEq+RmLXVm0lDO94LMirhbm7m?=
 =?us-ascii?Q?7Rls4mVoFYQyqX7cHEDwksL8s3kwmcH4Z+0Ti3CHdn/W2EA7n8ACRVwKeIFH?=
 =?us-ascii?Q?HQLN0Ubyhfz9Hmzlbv4+1xmaX3JBgJLl/sawXInDzuDppjs5QBdlI1XwlLws?=
 =?us-ascii?Q?wIygDyu6+z6EQzz8hQXCEmYxA0XW4Pj4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(19092799006)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1I12XQKqmcKchCiX+yIBSsiUAAHk/m41E93HPBqvOoWF8dMXUCl/dZSfQbMU?=
 =?us-ascii?Q?oRNd0EEiYTAY3AX5tw52EMJe/alDG+ZAyo5AqgqDVfheXKkYXBa2zHo8uhUl?=
 =?us-ascii?Q?3/NNCRF+DTpXlr66pxAGcZe53i0FXDoTSsu5FVm6A5Jro0OjWx98MHAeAcDm?=
 =?us-ascii?Q?AlvQQPbPMNNTO1hftb1cEemGpqAv8qcKbaiCNzgJ8lXLAOxiimyYUALoEjQt?=
 =?us-ascii?Q?VZtvkPjcOdKEx+x0wvXAtMCXfV/2WBd0hcV1JKaAidCTZResQ+ZMHChrUYaI?=
 =?us-ascii?Q?Ah6n4aDKBdKDUELonwGg/WGNYTwwSxk8C5y/2RY93IahqDWquRGUeK5MtGsn?=
 =?us-ascii?Q?ilgPXMbbsX6V3UsX3teDKstCLAQzDyzb3e2kfuu0oba0SLSepIkNczDsI8gB?=
 =?us-ascii?Q?dZkhE4CJ1xzWdq4zXHs08NNyEn2PMespw2LeW1QBKORZhs0h2gNR7rau8F6T?=
 =?us-ascii?Q?Kmsld4d7auQaiSiYHppQmlwvlCJq/csYzqQaCQcfwDBSykc0JG8ou+yUDTzI?=
 =?us-ascii?Q?9FahT3gPNYL+PP9ZJyX2u/q9gM9vzMmzK4kgeUDQzX/GDDbtFp6zx5dotBIh?=
 =?us-ascii?Q?SLb67Hv4hc3HwQwUADpECxLgByR7fcstjxsqtoeuSfnBmPgeffi7MLZ9O9S6?=
 =?us-ascii?Q?tZg5azo1yI+888w9+GWyqEvcpR0NprPcp4bofOii8ytcS2sWgi2vHP8vQLyz?=
 =?us-ascii?Q?gwjR7d+9eFE+141vbNYqPswuEWNC3o+C/G86775ouoxy3GdoeulpNQ4yTQ/W?=
 =?us-ascii?Q?qHfbG0UFHb9i5kGB6VLojBCOv/KfMsKVZ7GwyGAGFW/Wp5yRLyK7VEiNX/Cf?=
 =?us-ascii?Q?+M2OWlSOb3Nn03TLwu0lJAdfOs+zwtt1KvAHM6bB2ReVlwQhh1FPJdfXYCn7?=
 =?us-ascii?Q?zyVQzoJvqKiAVKhI3/q97/DGaSGaYW5AP78IVLJW2OiyzbBnePUJEkQjUpD0?=
 =?us-ascii?Q?/lrrvP2qN/XOc2hLZvgPymqt0GI6362BIjFp5MIqu99IzOhz8RmZLrxgZqRJ?=
 =?us-ascii?Q?t0pxPfnl2uV1GLvChtbzf3Z8ebKKQbOpyu16oyLCUjlq8rcutpuw01FdwyeB?=
 =?us-ascii?Q?OIAFNx60pNt8PKyzegPscp2bVYSGIOv4bfUHwrgwAXvg94cK/5s6K8cPXkIS?=
 =?us-ascii?Q?guB3tdSyYdWc0fXgqhfya10JPsn0GH1NGfX7CiQx5Y/9Z/Fb3itElUqvittm?=
 =?us-ascii?Q?KeVvakxzqYQ+k2/aRvddo75k5JkndnmzfHHSy88529F9AEzznzbtqHm2Vec8?=
 =?us-ascii?Q?V1W/iHKwF/Sb47v/svDVE3RHy1U6aYtjEpJ4MejaiaMMlsmLVjdWIqyAxVly?=
 =?us-ascii?Q?JPMDrRnG06TbTwegRFVirudwOJyAUl38Itc2VhrPegVQzh8JcMvjm7EMlOSt?=
 =?us-ascii?Q?9A4Il/RB+9jSJ/DoiWV0kuMeAadl6vXF6mIgRAoIxcNSAmeYU5kf6KYeC+Qw?=
 =?us-ascii?Q?Jthj1eatvh7wjsmnLoaWb6rI4eMTssyYGwgG2V+g2ADygjoi1WSMViv34qyn?=
 =?us-ascii?Q?Cm1tuI/3KN8EuH/ML4XJKLPKV+tFIUmcnAvSCfpugtfSyBWxfEPz1DELOraz?=
 =?us-ascii?Q?AODAjrb1KImKqh7ptoJDQwYn5m1pN/COuLtRp76+GQL5ux/AacmWg2+r0KhB?=
 =?us-ascii?Q?FW89sypJ4IIs4z3UFun3Dlp7+j9ic5PoD3MrYWkNT6JtxpO0A5mfX1QmlB8L?=
 =?us-ascii?Q?5ngPQA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c85827-699f-45cf-c5fc-08de01a4cb95
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 11:14:03.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdAvTFRs4VYGGUXxhOwCK6FP0g49e/L+MBavxly0mJb8oTkdOtSo+X9TJf95giMrJh9hd1bLn+/KweUeRW4sIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8993

On Thu, Oct 02, 2025 at 10:40:51AM +0000, Josua Mayer wrote:
> > -	provider = devm_of_phy_provider_register(dev, lynx_28g_xlate);
> >  	if (IS_ERR(provider))
> >  		return PTR_ERR(provider);
> Keep this to have compatibility with phandles to the parent.

I am not removing it. Both the "if (lane_phy_providers)" and "else"
branches call devm_of_phy_provider_register(), with a different second
xlate argument (of_phy_simple_xlate vs lynx_28g_xlate).

