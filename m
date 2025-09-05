Return-Path: <linux-kernel+bounces-803247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9E3B45C98
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFCD3A9173
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB712F7AA9;
	Fri,  5 Sep 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T3Ttz2gk"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC229219EB;
	Fri,  5 Sep 2025 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086199; cv=fail; b=vBE9jhbDfH1WTNPgElJmpa2bcoYyyx1NagTTBK+hyRmMVcGerewaNc+XSUI0DagfYQMVjfiMHtGszBI+CGOOQ9hZh19EehGuhjQ/BMt1Y9cYtSyqRav8FlRgQ74xLsTPPI/I/E/z3sWfaMc+GcFO6qtUWvDYOVAYqMy/lH76ucU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086199; c=relaxed/simple;
	bh=olNXmZYrMO/1ZSJdYxVmg9CGr4aNhzh+LWJ+MI9Lic4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YM4yy77zE+UsbheBx9Am5sildFkuUAno0/5AKrRTcZlLAJHDMQrWJF1y11sPE7ACi4vUQLmLIevAV1RpGRdP6BS37mRNJDccAKEeQv+jzm26rYcWR5nupZ06Z1VAM73lH9gix9LvGdmyTbszQsspeV8A7lIv5Yqfcdx9vGE/pUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T3Ttz2gk reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cticattl4FyNGA1Fwg8dW1rmQ+CGxERXNnijOpUXhst4bZBIVlARQXSzFDsU5zXrRGnFGbZoviYf2KJHzFOg6eYXCTqST+VG2mjheB5/XvFgkYICjcgYVfg6H8yq3rv19RZPR/MlhbDc0gdVagMnwrFbiJFiQ4kw1rzMA7ZysNWOWmJlWYf+/EmFDzCred5w/tG6ziMXtb48+vCz23REKeB40V8atY/8ZssN2pTXmJ/u+ZcUzLK7rI5U1Mfil6rsINoYrpgsRBVOHDaomKLvgg8yCI8eYH4wEGbEH1+TK5DjS5WTdvsnAgp8kCcZQHFt1gq09pz2GSdMQMR82DcAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LyoMvmsIp7QlvMUCUm411SW/kDN81SoxeLZ4H4Rh4M=;
 b=xD7Y9IvRLE396sXck0YGs3UgoxVZ1VOM6/jrj4fASuTiKFlMlUK8vazVYiyeXmAK2CmyNxfjbPY1drTLDYYJkLKUke+VQp25oGtLUawW5YRSQLJfxZtvSv8VSBPY0SF8RmLbR3TMVmSifO7moUbsVA+FTiY1m5mYyHouEVwb1QrJvCB82ANr9CBIKXPy9YU7Jzy0jdAI/Ws2nOFxUX70wGtO+RnbuWKC2Mhj9IPvIFSIryUEhnpVpJTubRwh+Y+5z8MGo/wT6YOha+l2BHmjnlx2zadvUmWSOrIHPxVCY1YTt6Xa1d/JDctYkwHoihjFCROkXXiKI94Yrykws2zq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LyoMvmsIp7QlvMUCUm411SW/kDN81SoxeLZ4H4Rh4M=;
 b=T3Ttz2gk5SbxBQ1p8i30a2oy2EYnAJCiSA8lzygLIyXijCv790zj13IWkh4saKfw65EzcjlThVBO3yfv0oZNvX7ftHP17LzvxyIsdoEAR8j5+i5m2t3ZS3y+fVDHzpQTlLwT1YvaYrNvFTk6I2iUqgxhgACFxxjBHziks1XPTx4CQzp1UmHcta0TYNsbh2GufAoCKgZKuES9fV3wtX6fkUEbPJufQZhMhMtJU38yE5ePBeFLL0zZbxYTdGqR6aFiCjMIc76dPr5IbGnzxA99w8db0WSzUbsTaN/Ko1ZoJfBHPbvONHlppTZIqS5HP1v1TwbmBx0p4te54rVXPZl33g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10021.eurprd04.prod.outlook.com (2603:10a6:150:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 15:29:53 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:29:53 +0000
Date: Fri, 5 Sep 2025 18:29:50 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Conor Dooley <conor@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250905152950.dvt2jqpgfjuzyh4o@skbuf>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250904-molar-prune-4d3420b1bcb4@spud>
 <20250905104921.7grpgloevlifa3kj@skbuf>
 <8bbbf34e-ff9a-481e-a45e-26cde7d8f6bc@solid-run.com>
 <20250905113757.pmumjdnbd52jxw6o@skbuf>
 <02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com>
 <27f64133-729b-448c-96ce-771716485786@solid-run.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27f64133-729b-448c-96ce-771716485786@solid-run.com>
X-ClientProxiedBy: VI1PR06CA0204.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::25) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10021:EE_
X-MS-Office365-Filtering-Correlation-Id: 7536186b-48b6-4d3f-ddf3-08ddec910f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|19092799006|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?qOyOKRQRQU3jondodTy8+MkMneHBjm+cT+3pVLHsG03uObJgEOcY8vz7cG?=
 =?iso-8859-1?Q?8Xa2lZDTLb9KEkCF04qRW9zvd9TzaZ5rtLJD5dX/UFTYPIdzbWQqGY8kqq?=
 =?iso-8859-1?Q?rxmHU8p006wmEiw3IiY/tKAqhLTkIrd2KVwktB6N8VG9uWS3UU3UnlrgPW?=
 =?iso-8859-1?Q?cDuD22htSwAQkbb1hFmfg1GMmaVPDaXChVvJaj+mWd793T25CStFVkejND?=
 =?iso-8859-1?Q?PcWDybpoo62HWxCKp62hGUmy8TWHmq0RoqfFosVcPwk0EEeaQLUXJCcS/N?=
 =?iso-8859-1?Q?5DQF4zd7FUluO4j4JOgkffWhRWhDKnaFV1sk6pvqPRvUZoSg9R4gp7E3gM?=
 =?iso-8859-1?Q?R/ma+0EEpzND7ML8rdVyeNFQZkaaO096TwKV67DnJ1+9Jtwx1zGZOme2eA?=
 =?iso-8859-1?Q?xMve64rHra0yS7rHzWZnFVuK7a5pq8daymtBTCvwIh58MnYzuNYm9eGh4c?=
 =?iso-8859-1?Q?krw/1bkiCD1F2d75Ym3FGnuZs0hzZ3hiNbKe/RwiNglMI70jrqHzcpjLfW?=
 =?iso-8859-1?Q?6Sc0HxV58nXGUbKgnO+W+38uEv+tmOx4O1mwrcy/jcDGQ+AcO7wviSPOsd?=
 =?iso-8859-1?Q?H51JCJiA8Xq0PBm2dPjSraObO+7sEs9c4q0mTHXFtyjUmvyeA9Qq/P0dcz?=
 =?iso-8859-1?Q?0UKcfSyLwiOvOqmLq5rIgXpIVmuRspPSynDxgpkB46GoctSVhGK+JTaOO2?=
 =?iso-8859-1?Q?pLmhXKm8NIxJzsvLrZb4vkldemyQ7GR7/eESOyodA+ueBG8bvfHlpcpi70?=
 =?iso-8859-1?Q?1iOPkRTTxBjGtMxWKWIqZm8QgrscecaZJNQpg3JGctMAxn/poOOtciNP0/?=
 =?iso-8859-1?Q?J+FcGKCuML4P+CzYSTTYh2LxAcKer7Ek9NEMXa2BGbJlmSZUcP5m9VZTgk?=
 =?iso-8859-1?Q?vayM5pT41hmunQntxQV+0AwdLQiA6UqEtDzidjqCd1MLBVl2TRtRLKZPZ+?=
 =?iso-8859-1?Q?2kwxZtQyq6C2KsLLYU8Wjnp3oLiCuhJouZsXDkm9G8RIX1LW+VCa1migIy?=
 =?iso-8859-1?Q?r3cy/58+7d5ao0B9pTUkmsLZ8QmVkKcBII+NXoT7RtD8a4qADyh3d9aNgK?=
 =?iso-8859-1?Q?nC8awst5EZ71TorlozsNpLQ1U6X+HuGHwUKEq9oOAiR4wn0feK3BmXY5lN?=
 =?iso-8859-1?Q?hWG4heQTPL0blLNz9h034ZcW226jxl5S8l3O+A4qsXMFdM4Q86n2fdbTwS?=
 =?iso-8859-1?Q?sC4ppvAZrNEsWJ8M8in7PrS/OAl1idYmtAsvK/o0KeO3lUWKC5PCfZ+2qy?=
 =?iso-8859-1?Q?uO2B/vOF2MY2Tx/dRM3QzEU0ELei01h6zrH+OGMoypqWp+PkfgyqerUV1z?=
 =?iso-8859-1?Q?rEflr9SNwzQWlnKA/wlyBZ5XrhKThtEozXfnob18yMpnI9VSMCeC5LNXl+?=
 =?iso-8859-1?Q?ekJCrxxAUfbVDhJvffHRp/tZf+nCGrWPCfbzB+VUf95ht5cgCySAr9CmdZ?=
 =?iso-8859-1?Q?BJDHXmku6avvBsfTZgWw5M7U2u7PSeNY2nNV8dzzi/2Bm/UBLtxXxCDAMM?=
 =?iso-8859-1?Q?s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(19092799006)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?KqSjR9ELLHoBq/D095Km389GtaBhGJm45Gvp/jquj4P1OyAJm806xvzdRu?=
 =?iso-8859-1?Q?jZzjvYQc303LnR1MzZICHbRSL0LuGpsfflqxkmPZkr9Xohy99Ll8xl0NKi?=
 =?iso-8859-1?Q?Pvtnugib1doqdM1cZAmJwa7+QV35ko6pGZ7aNzD9vmsDSXfaCIT98RY47F?=
 =?iso-8859-1?Q?WAG1R2LjikdnRCVPGvYbKHfGCRff75L3YgdHNy/Oejzk2vyA5M31Nw60nn?=
 =?iso-8859-1?Q?GXQWRPxsnVeJfgzWWjp5WNYD6bfrtnIhoLpzoV4wexpeJ0Zbyy6Gey8K7r?=
 =?iso-8859-1?Q?eZVFZiL0JJ8o1vj+qMr3re2WirLOOXmObs4+rTq96UAJS81/pqJA0+hat5?=
 =?iso-8859-1?Q?h50thtxEvUrXKEz39FpXxOLzOWNaZ8ovAzSRdSSej3w/jwiaGHIjFLkuwN?=
 =?iso-8859-1?Q?P7lfKyE3bsz/CF+XoNnmL61wHCBuflKsE1NrRdVN4RLaWmWw07zrNAyDRz?=
 =?iso-8859-1?Q?v88pMQS8k2MxyvgpbxmihEaHhYFWn4jX8muovK1oLQa8p9RTJFYakdMHlX?=
 =?iso-8859-1?Q?yRoUn3WShUQK1mfxKFdylrdaUn8b9D4ZKbkfVUuXRORGamUaIGhuuiQhOS?=
 =?iso-8859-1?Q?pnxRz4Q39PP1szuSrS5hvTIQmSgl6BkquDS8S5WBIEf2Hl5osHXOHagTNM?=
 =?iso-8859-1?Q?Wv8MiW36j4J0OEZV0unEaN6Qb+Job/BnlvHdBwam9N8r6dmfnX8D9HSSdf?=
 =?iso-8859-1?Q?WVTZGRt2wfbwR0Gmpr6YYPA3zYoUnrSMXyW/TJHb7lCJhLiVmvdFzPKQoi?=
 =?iso-8859-1?Q?1mhpyUNcAV+iy+X2HEeXMpmyrC9Bd1IH1BvypP68ZNvspjzsAFk9k+lON+?=
 =?iso-8859-1?Q?aQbL9vLnjOEDo8gqMvMJ9RXNEqqE5+WmMKRWZ2fmUpFBYNJ3y/LiCXg4cv?=
 =?iso-8859-1?Q?obQBW6i3UQhZ883Gp3+ROD9HTIBChkPg9xRi8bsB4x6xfpTlPa3DkvQs8y?=
 =?iso-8859-1?Q?iWmHDewzO7a7d7JbnKj6bqf4iHLO/XxjNGE29EghjRtaWZFrHACWpO3p2W?=
 =?iso-8859-1?Q?iL2QTEN8r38pffdQzV9SR+AegAt/5dcaNjbvYNOV8QmlGP7sqvup01W5iL?=
 =?iso-8859-1?Q?iEvs+C06QVp2Id2q6yAI45xrCUxLw/BlctSE7h/Vc9HI9+PFU9nMGymPMa?=
 =?iso-8859-1?Q?oB1AXlQZVc5oOGMl2OMrviWVHbjrV9ODhNlEsN6+pq6oPbq87D1hIS9ScO?=
 =?iso-8859-1?Q?Vr4F0J3nBxgALOg1Eym4YcHQmWe6HjvA1Of0C8hoFh1EGNLa6CnNYBTF0b?=
 =?iso-8859-1?Q?At1dCQXMacm4mYQTgzAGsj3k2hmJ+pU2Rmp40Y2F+4sF7YYRAf+QayVWGD?=
 =?iso-8859-1?Q?biJjrReViCkA73YtGAt8VEYg4SbiBvF4ocLmj1uBJicUSgFPJxOadAgssv?=
 =?iso-8859-1?Q?SQV/chDF60ZLkEv3iOT4iGmp0EpXDnp+QUBtepqlqsgPNz+3w1S4h8u1kT?=
 =?iso-8859-1?Q?ckKXm8yboPDopfBJfv0G5v1yXOyPy9B04AHTuq4G4MMdrdzysWI6bcJQL3?=
 =?iso-8859-1?Q?awaXj3d1Hn22qZKO7/1jZhwxytfjal1mXSdg5RaRx1/nbyWYVBsdHlcWbC?=
 =?iso-8859-1?Q?FjEW45PdJB7sJ/vp6xnLK21fGadAcq6nXvCRE0YsHTYd4U7MJWbcJvfcmq?=
 =?iso-8859-1?Q?N41OEPgeSII+kJ74uDIesP7sSVkYxIHD8rfL8Xf5oVKdLB3kW50fZqBiFt?=
 =?iso-8859-1?Q?nvR/2mOpDiBaU4oZ0KsLWNTExnEgOj4s9BqQvVNeU0t7qhqYuQQPbvY/Gj?=
 =?iso-8859-1?Q?UrlQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7536186b-48b6-4d3f-ddf3-08ddec910f9e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:29:53.5102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXtql546y/ZhWolAVn7hWPdhX7EYZVV7dIGo6Psb0Br4xbDrWF/BCR8OoVRYIU4UUhObb0d5lYhg3z9mE9A1fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10021

On Fri, Sep 05, 2025 at 02:44:33PM +0000, Josua Mayer wrote:
> >> Do you have a specific format in mind?
> > I have a prototype implementation based on v5.15 using properties as below
> > (I am not sure this is the best format though, DT maintainers may have opinions):
> >
> > serdes_1_lane_g: phy@6 {
> >     reg = <6>;
> >     #phy-cells = <0>;
> >     fsl,eq-names = "10gbase-r", "25gbase-r";
> >     fsl,eq-type = "3-tap", "3-tap";
> >     fsl,eq-preq-sign = "positive", "positive";
> >     fsl,eq-preq-rate = "1.33", "1.33";
> >     fsl,eq-post1q-sign = "negative", "negative";
> >     fsl,eq-post1q-rate = "1.26", "1.26";
> >     fsl,eq-amp-red = "1.000", "1.000";
> >     fsl,eq-adaptive = <32>, <32>;
> > };
> >
> > I imagine a parameters sub-node per protocol may be more readable.
> >
> > The best description would be generic enough to cover pci and sata, too.
> >
> > Perhaps:
> >
> > serdes_1_lane_g: phy@6 {
> >     reg = <6>;
> >     #phy-cells = <0>;
> >     fsl,eq-params = <&serdes_1_lane_g_eq_10g>, <&serdes_1_lane_g_eq_sata>;
> 
> fsl,lane-modes = "xfi", "sata";
> 
> ^^ Would be mroe elegant, as it can at the same time explain which modes
> a specific lane supports generally.
> 
> Then eq-params is an optional list with specific parameters, some of
> which can be shared between different modes (40g/10g)
> 
> >     serdes_1_lane_g_eq_10g: eq-params-0 {
> >         /* compare downstream enum lynx_28g_lane_mode */
> >         fsl,lane-protocol = "xfi";
> >         fsl,eq-type = "3-tap";
> >         fsl,eq-preq-sign = "positive";
> >         fsl,eq-preq-rate = "1.33";
> >         fsl,eq-post1q-sign = "negative";
> >         fsl,eq-post1q-rate = "1.26";
> >         fsl,eq-amp-red = "1.000";
> >         fsl,eq-adaptive = <32>;
> >     };
> >     
> >     serdes_1_lane_g_eq_sata: eq-1 {
> >         /* compare downstream enum lynx_28g_lane_mode */
> >         /* example parameters, do not use for sata */
> >         fsl,lane-mode = "pci";
> >         fsl,eq-type = "3-tap";
> >         fsl,eq-preq-sign = "positive";
> >         fsl,eq-preq-rate = "1.33";
> >         fsl,eq-post1q-sign = "negative";
> >         fsl,eq-post1q-rate = "1.26";
> >         fsl,eq-amp-red = "1.000";
> >         fsl,eq-adaptive = <32>;
> >     };
> > };

Why stop the eq-params reuse at "per lane"? Why not make these global
nodes, like SFP cages? It's imaginable your pre-emphasis settings might
be the same across the board, for both SerDes #1 and #2 lanes.

Also, let's take what is upstream now as a starting point. Currently the
driver has #phy-cells = <1> (i.e. the "phys" phandle is to the SerDes,
not to individual lanes). Wouldn't we want to keep it that way, and make
the SerDes lane sub-nodes optional, only in case they have phandles to
custom pre-emphasis settings? If they don't, use the driver default
pre-emphasis.

> >> In the circumstance you describe, isn't your fix just "code after return"?
> >> How would have lynx_28g_set_mode(PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_2500BASEX)
> >> gotten past the lynx_28g_supports_interface() test without being rejected?
> > v6.6.6.52-2.2.0 release, .set_mode:
> >
> > lynx_28g_set_mode->lynx_28g_set_link_mode->lynx_28g_set_lane_mode->lynx_28g_pll_get
> >
> > does not check lynx_28g_supports_interface.
> >
> >> The driver would have needed to suffer some pretty serious modifications
> >> to allow this to happen, and I'm not happy with the fact that it's changed
> >> to handle incorrect downstream changes, without at least a complete
> >> description.
> > Point of my submitted patch was merely to guard an unchecked pointer,
> > generating appropriate error with enough explanation for non-maintainers.
> >
> > I debated using BUG_ON instead of warn.

Sorry for maybe being obtuse. You're saying you added code in mainline
to check for a condition that exists only in downstream lf-6.6.52-2.2.0?
Why?

