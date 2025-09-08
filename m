Return-Path: <linux-kernel+bounces-805448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FE6B488A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B403C37AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065442EC55F;
	Mon,  8 Sep 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nOiS5qwa"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA71E570D;
	Mon,  8 Sep 2025 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324239; cv=fail; b=RaBx23IP75bMfQpQS9DvZR+oQGxInOisZUp/myrWEJnvw48dXxIXu8STLnPgyMxrhVFRVaOGt78msFrvQ5/XlOZxzo3nAn+sW8c/Ipx90b6svhQZvg/E9GRgxQz3uy0LU5pEUPTrEHz4Fbn01Ambr4J17/HxuvJHwxVFHaGiKbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324239; c=relaxed/simple;
	bh=1zy8Z61gRiWcj5WIYQWV5PicT19Hbo47JiWuV4+1/Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T1IIY2kgmSSu2SPirOEulRAKCAhn2dfrdi3yz/3T0761Y/hd4vk/a0QKl0F1fLkv6JkIqRWITDaUmlzxvGRjx12XEv8yhVoJTYPuLqGx2UDWUPEEKekD/8ovOzmHNZ+h8X9onY041X852tYlajGRDdHUvNcrKb+1zsa9CZcus9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nOiS5qwa; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uz55L5DZRtDikbfUbKY/+Pf7fF7yKZ9Fl97T44lm9pkpjQq0cOwzh4Id22l2HDlGqf9Pq3UBws/RS1hBah13QIPD2abPZtOYT80iJJV2EbXyO4Ryeb3asg9bOSSW1OerqEZ9FQTeHl267MJpRA8pXj1qLEL6a2DE8H4E4iMyB+vZqg4GzFBx1M99QZzJyUxTffSvDftiLq7hIamYjsyMrWvHu82vCIblXpOj6ap30FnZSqaiUX1FWECa3SuAHmP2PZZ6YSUjrUGZi6a/bKWYYlRyvEToOeK2ROkdFgftZ8Atn1MPxg6ZnGjNWmiyc3JPXOUP7ttNskZ7/rwIAJVf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jVuK9KEaBKp6DsdCm13/ScsTvPjwIJswsXYJ7ohA8c=;
 b=QqOdXqS3nZ+oGhc+r6XPXtVNjFpUK/AO4zKQoTR3PZeMmmSAAa+gyBn+pRbID2Tq91kIKxQ8yu7lIayINV/1gT+0uCiMR4aEsEOuuIHCw5Z0H0RgN1MQHDaDNQJn7oLL3sO9C18aaPbDi635JAPoCVNzRvZYl6rDLzfrs06iUwsPt1od9m5Stb3hdtftmEGCPPVaKCl0ODrDaS4Q84pcjxL0lvnAxUmZoKCLkC+/q5KvBbVke+yaPeKDmFg0xg92z4FU4rTPKs1nl0RFcH/gQHRSquDN4GWZQ+E/f1hlqHSv7IAoFHql6z5tL8DtSMZuXFcF6nIAbXEMzXEr1Wm37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jVuK9KEaBKp6DsdCm13/ScsTvPjwIJswsXYJ7ohA8c=;
 b=nOiS5qwaiUEy4HW3EogKEx0s8B0r9hAmkhybxWan+7ikS0QE4fffMnmc1T5jpj3Dze+BwUPjS2y35xBKKKmmmGCAHreqFyICiRaUuNiX28GMCAVIqAiP5DVZQPlfKZ95q122QN5U94kZ8x8ye6ocvEU7Xpdk0UrBt5uar16/Tt7Vg3pSMjgoNKW96KtEsQV3ovADCFjEXjwlrgVb1IKzrANKx2QMAOe+pBzJNhiGMazcCKxSWoGosuJFswp73WlO9PAJiB/uTshJxity50Rv3EMYT+ZtL9J/S52VYqO4+3qHfJDXU+irGX/R/dyI1kzDvX6MmUnRRQDL/OtJSPvN0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB9052.eurprd04.prod.outlook.com (2603:10a6:10:2e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Mon, 8 Sep
 2025 09:37:12 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9115.007; Mon, 8 Sep 2025
 09:37:12 +0000
Date: Mon, 8 Sep 2025 12:37:09 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Conor Dooley <conor@kernel.org>, Josua Mayer <josua@solid-run.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-phy@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250908093709.owcha6ypm5lqqdwz@skbuf>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250905-bulky-umber-jaguarundi-1bf81c@kuoka>
 <20250905154150.4tocaiqyumbiyxbh@skbuf>
 <20250905-pamperer-segment-ab89f0e9cdf8@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-pamperer-segment-ab89f0e9cdf8@spud>
X-ClientProxiedBy: VI1PR09CA0132.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b582673-ebda-42d1-bc2d-08ddeebb49e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|19092799006|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5DPXpHkxYlA1obHfJthCaNBGVymcjDkgcbIPyM3Ha9PSGn1lMAcuJarcFE6X?=
 =?us-ascii?Q?hd1pVQiMGR60fIoyMibO3L7bLQ5ZByul6mSAcBEf7z6qyZzRsAYrQRNJ3kHR?=
 =?us-ascii?Q?VLaJY3lzjh+Cn9QAGSXyeHwfHSfFprCjfu877zSRhFIanR96A5wthz8mSoHF?=
 =?us-ascii?Q?Iqmltq23a+0coczcpQ8VXpkvAbGT0fIvHPO5JYptITpsm64Cf4L6nNFwV+71?=
 =?us-ascii?Q?godMtfieom5gMoz722r0gz6PJCAjBbcNNGYqNcBUdtYBBeMNS87SNsrW9gzk?=
 =?us-ascii?Q?p+CVthPZcFwIgYRxFkuRZMURuRwucdOxtS4KAtivFzj6mA2ZGU22R7l8NVMt?=
 =?us-ascii?Q?Akngrm0kQzZMkE4WVdm9GyLLoJGuCbi1PwIVFjcP60pLeoSye2W9kJ9ByqXB?=
 =?us-ascii?Q?ak33wHClXH+rLjh/Vk1gPGWuq3EhsIT7x40OevKnwDSbgGFjlHnKCsuyJlW7?=
 =?us-ascii?Q?UwvHzYn/cBiBdKK2gpEo4OeMW0wOKmRH/00Jr75VQmbE0PDieuFZU22QTtda?=
 =?us-ascii?Q?73wNvaIMgpPFDSZHPp+fzJMtM1SY63kn0MIPxA38DYNNLonQe6/gHe1Qb4HM?=
 =?us-ascii?Q?KWX1OtTeykm+TSqU1SQ5YEucsRYxTAL6m6l2jN8iH03iUTp616Wp+wbq79Vm?=
 =?us-ascii?Q?sduEusxB5+jgRHU6Lhk9B120FIuZSu9ELJFid8cRZ7zftw6CZ97PhnOsJOoE?=
 =?us-ascii?Q?qrebQEscToSaR9TzX1MXXbwsBdCLagug7q5M5MIOn6BAdCojCC/3emBQ5hGf?=
 =?us-ascii?Q?A2GOarfZLQ7TOUkC5Pya3MSl8qWsMT2WPNiZjSo0rZuZBmKqjYuo6wjRpKCI?=
 =?us-ascii?Q?CZkWeUY+22Nq95zy8Y5O+a4ZdD3WlvV7jxM29yWZEQqfQuC8BiR+joohfMmV?=
 =?us-ascii?Q?Jy2cpePMILxyijjIUZSDv6NGCz8ajArysiBSNYK6adW4HVEX+qWtp+atzxSm?=
 =?us-ascii?Q?/haSVaWVma81MTvlS6F9NutmE28dz9+peNMl7AsRNa/A8zghQAL2NLbJ2sSh?=
 =?us-ascii?Q?1N4d6hSUndSYn1swiOulXzO5Xj/Z2y5++ZEU3GqN7QG/6ZW552j7qU7/3b8E?=
 =?us-ascii?Q?MA1Ea+ZehR4yODO8+ovePts9+73rkKs2+KuaWL58gemHmbfQNZPR/fGhWkEc?=
 =?us-ascii?Q?s4GXgdcpDsQxhEWO4OpPJdMPh00n4pSV1WZ2Q5EE+s2LqKg7jfvliGudX7Rk?=
 =?us-ascii?Q?+GsEg0Boy6Cz6lw8SWH3+lVuS7F7jnPANxLh6IUSLdmuCV02oxwCMgdy2w26?=
 =?us-ascii?Q?wCZng0lpYUbmEf05QyoCThnMoBljm/VbwPtuXA+h7Tj0xleXoI1k1ElZXqSq?=
 =?us-ascii?Q?a34/HkAXy32PPjPSbE2WARRfUg6/qIAhMAL9z9SRfnEn2zuhnKMKczP5RYDl?=
 =?us-ascii?Q?MPvg0FKoy7QHkPzUce9sVafl26BbPFBbEYl2TLY83oBC5Im27vH8c7HPFic2?=
 =?us-ascii?Q?wl/L2Mhgz2o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(19092799006)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rdhtU6JhF7w1KX31+eE50h7s6nE8V24z/gQqLKrTVSk8f885sW0co40P9ane?=
 =?us-ascii?Q?xST9mHuXiHl1Ss9O/QFaWHfh4oHnzARUcaaSnQjUT7C5cLno9GmxGEYiIq0l?=
 =?us-ascii?Q?tAMqrnH3QkAetYFVsIDsxCJdkqNo0vLgs/8a1CR6eEjkP/cqNPjZuw5VeE/E?=
 =?us-ascii?Q?d4wjJH55zAyoNm0i3BSWDJDFdzJRaFFy6gHAt43ugTtn0x68WfnkQ4rdQ4Bm?=
 =?us-ascii?Q?KMWeZ7hX71n8BNOhQjKIahaB34vUAioe0rRgHRYmkVr0WHcI8HZSHnigVfjU?=
 =?us-ascii?Q?TlMkVg5xwqSIq6TTVkhBCW0kFsl5EtZOPr6k0DbnGNEf6eBqrTHu5dGw66b3?=
 =?us-ascii?Q?LroHhnCQ9obJZTe9hybUHk8jV9qVuYRCoKpxFd7QM//JjYs92blv7qbtHnLv?=
 =?us-ascii?Q?tNF8CvA4qBfqwJ8WJhctJBFc4KXiisMf0gZ+wF2RhZUO/I6beN+RXiTU3vyO?=
 =?us-ascii?Q?VDBLYXfsLQJPfI03dTKG3MwJpXclNtxfAobS3b+o6fIfKyN12JOtoO1SIhYV?=
 =?us-ascii?Q?kvxRDYgBon9CQO2iGVcZY177vx67eaj9QUcX2jAoMJeiXzQTm0WDW9kJN4Tk?=
 =?us-ascii?Q?W8oV0sv7+YWggn7JwAREwoLEdqL1CE4i9CpVFvPJavDAPbD+RSxuXKS50F1o?=
 =?us-ascii?Q?tLYbR0B/HBEPZJszoX6zO/WrfykdxvYXZkh5zEHvhwzP7idIzY1+JGjOZn5I?=
 =?us-ascii?Q?j0pi3L0SQ2wZSx0ZH1FqJO95BytEssAjcILFE1+eX6TgvEm5WjIN4a/LXWcD?=
 =?us-ascii?Q?K3/kl9CIaJnL9/r3qgTLdZB6dzIU9wCcC9imGWn2VE8c1jeCKYyX0oZfQAiH?=
 =?us-ascii?Q?Z5mNRGZvR7MTE6lGAf+cZM00JXOxeTb2i/m+zqUtjMKDZp8BGaMzlrnPJqRH?=
 =?us-ascii?Q?x9EQFcE3n7514s1VkZfjwuEXvxLb+3XD89oVjj9NT3wctnAzHDlF+D0bwzYA?=
 =?us-ascii?Q?euDmcRBuq0kUSoIoxTIf+0atgxw1AryVjR55nCTJONiEe6ORPuVGsYUiXFHZ?=
 =?us-ascii?Q?tWDBE+zZmpu3ObOipzOO7GSIegMNG33HWv9MSISjTThr5HCWQD4DjJLfo5SZ?=
 =?us-ascii?Q?8Ica89BjJUfyKbAkMFngQAX0nPVfw4yc4NNjinUjk393sgFEm/MXtvwyz+LD?=
 =?us-ascii?Q?8dymKHRbQWsKl4ttJNIqt5gIjTcZ0bCHrqp8AgAX77kr7DOukeXY2knrgwhg?=
 =?us-ascii?Q?bNhxqx+eLjjriMnzu82MT40w5iFfPZLyHRWlOru3KhetG7Q9/7oX8e6akZhB?=
 =?us-ascii?Q?G+UxdgGKptX9ihPW7knOj/tXIEKSiTHVqNnmpOthU8yc14Tz6Vf7pHKVbyuM?=
 =?us-ascii?Q?oCofXMo+CChyxKKSlMDpJuqxz3nj/TUPNn10R258mH4Ues9cQDeGKRB7Br2i?=
 =?us-ascii?Q?z92pmAhOyGMsBoyA2CXH35N7Zd5/3xYBrJ3P0OfEHWhHu9zfdSBRR9ypKFlf?=
 =?us-ascii?Q?b7WxePXASgMsfk30+u1zqnLkVGaHjmQEzW9mkMmQYPgjgD6NyvixUeJUXbhd?=
 =?us-ascii?Q?bhl+tgi1RjFsR4805AOQWslcPBsUqhv8av9EnPyW9q4fSjX11UoMzy2nNrXE?=
 =?us-ascii?Q?YTkXRST+QidOBTbpIcHJ9z/ksWqf/HMfYkQ+qkR1/1WrGFL7L7YahF5FPXVY?=
 =?us-ascii?Q?do/4ux5nizJhnHuPjg4WnyTheKPTrOh9T4pk6BRf5Ou+Tre6jaVvMTLx0cK0?=
 =?us-ascii?Q?N2muAQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b582673-ebda-42d1-bc2d-08ddeebb49e0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 09:37:12.5077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RI85Cssbq1BQlSTZbygLXTpJiEiUeRTx8QWdjBeRfm+lgRn23FTFBDb1YKgEsrGwPzW5O1m8zTITDVcuPMAFeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9052

On Fri, Sep 05, 2025 at 08:02:59PM +0100, Conor Dooley wrote:
> On Fri, Sep 05, 2025 at 06:41:50PM +0300, Vladimir Oltean wrote:
> > On Fri, Sep 05, 2025 at 10:29:33AM +0200, Krzysztof Kozlowski wrote:
> > > >  properties:
> > > >    compatible:
> > > > -    enum:
> > > > -      - fsl,lynx-28g
> > > > +    oneOf:
> > > > +      - items:
> > > > +          - const: fsl,lynx-28g
> > > 
> > > Don't change that part. Previous enum was correct. You want oneOf and
> > > enum.
> > 
> > Combining the feedback from Conor and Josua, I should only be permitting
> > the use of "fsl,lynx-28g" as a fallback to "fsl,lx216{0,2}a-serdes{1,2}",
> > or standalone. The description below achieves just that. Does it look ok
> > to you?
> > 
> > properties:
> >   compatible:
> >     oneOf:
> >       - enum:
> >           - fsl,lx2160a-serdes1
> >           - fsl,lx2160a-serdes2
> >           - fsl,lx2160a-serdes3
> >           - fsl,lx2162a-serdes1
> >           - fsl,lx2162a-serdes2
> >       - const: fsl,lynx-28g
> >         deprecated: true
> 
> >       - items:
> >           - const: fsl,lx2160a-serdes1
> >           - const: fsl,lynx-28g
> >         deprecated: true
> >       - items:
> >           - const: fsl,lx2160a-serdes2
> >           - const: fsl,lynx-28g
> >         deprecated: true
> >       - items:
> >           - const: fsl,lx2162a-serdes1
> >           - const: fsl,lynx-28g
> >         deprecated: true
> >       - items:
> >           - const: fsl,lx2162a-serdes2
> >           - const: fsl,lynx-28g
> >         deprecated: true
> 
> This doesn't really make sense, none of these are currently in use
> right? Everything is just using fsl,lynx-28g right?
> Adding new stuff and immediately marking it deprecated is a
> contradiction, just don't add it at all if you don't want people using
> it. Any users of it would be something you're going to retrofit in now,
> so you may as well just retrofit to use what you want people to use
> going forward, which has no fallbacks.

You're right that it doesn't make sense to deprecate a newly introduced
compatible string pair - my mistake for misunderstanding "deprecated".

> I didn't read the back and forth with Josua (sorry!) but is the fallback
> even valid? Do those devices have a common minimum set of features that
> they share?

I'll try to make an argument based on the facts presented below.

The current Linux driver, which recognizes only "fsl,lynx-28g", supports
only 1GbE and 10GbE. There are other SerDes protocols supported by the
SerDes, but they are irrelevant for the purpose of discussing
compatibility. Also, LX2160A SerDes #3 is also irrelevant, because it is
not currently described in the device tree.

1GbE compatibility table

SerDes              Lane 0  Lane 1  Lane 2  Lane 3  Lane 4  Lane 5  Lane 6  Lane 7   Comments
LX2160A SerDes #1   y       y       y       y       y       y       y       y
LX2160A SerDes #2   y       y       y       y       y       y       y       y
LX2162A SerDes #1   n/a     n/a     n/a     n/a     y       y       y       y        LX2162A currently uses lx2160a.dtsi
LX2162A SerDes #2   y       y       y       y       y       y       y       y        LX2162A currently uses lx2160a.dtsi

10GbE compatibility table

SerDes              Lane 0  Lane 1  Lane 2  Lane 3  Lane 4  Lane 5  Lane 6  Lane 7   Comments
LX2160A SerDes #1   y       y       y       y       y       y       y       y
LX2160A SerDes #2   n       n       n       n       n       n       y       y
LX2162A SerDes #1   n/a     n/a     n/a     n/a     y       y       y       y        LX2162A currently uses lx2160a.dtsi
LX2162A SerDes #2   n       n       n       n       n       n       y       y        LX2162A currently uses lx2160a.dtsi

As LX2160A SerDes #2 is treated like #1, the device tree is telling the
driver that all lanes support 10GbE (which is false for lanes 0-5).

If one of the SerDes PLLs happens to be provisioned for the 10GbE clock
net frequency, as for example with the RCW[SRDS_PRTCL_S2]=6 setting,
this will make the driver think that it can reconfigure lanes 0-5 as
10GbE.

This will directly affect upper layers (phylink), which will advertise
10GbE modes to its link partner on ports which support only 1GbE, and
the non-functional link mode might be resolved through negotiation, when
a lower speed but functional link could have been established.

You mention a common minimum feature set. That would be supporting 10GbE
only on lanes 6-7, which would be disadvantageous to existing uses of
10GbE on lanes 0-5 of SerDes #1. In some cases, the change might also be
breaking - there might be a PHY attached to these lanes whose firmware
is hardcoded to expect 10GbE, so there won't be a graceful degradation
to 1GbE in all cases.

With Josua's permission, I would consider commit 2f2900176b44 ("arm64:
dts: lx2160a: describe the SerDes block #2") as broken, for being an
incorrect description of hardware - it is presented as identical to
another device, which has a different supported feature set. I will not
try to keep SerDes #2 compatible with "fsl,lynx-28g". This will remain
synonymous only with SerDes #1. The users of the fsl-lx2162a-clearfog.dts
will need updating if the "undetected lack of support for 10GbE" becomes
an issue.

My updated plan is to describe the schema rules for the compatible as
follows. Is that ok with everyone?

properties:
  compatible:
    oneOf:
      - const: fsl,lynx-28g
        deprecated: true
      - items:
          - const: fsl,lx2160a-serdes1
          - const: fsl,lynx-28g
      - enum:
          - fsl,lx2160a-serdes2
          - fsl,lx2160a-serdes3
          - fsl,lx2162a-serdes1
          - fsl,lx2162a-serdes2

Also, I will limit the driver support for the "fsl,lynx-28g" compatible
to just 1GbE and 10GbE. The 25GbE feature introduced by this series will
require a more precise compatible string.

