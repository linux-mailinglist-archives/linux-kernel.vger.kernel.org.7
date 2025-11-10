Return-Path: <linux-kernel+bounces-893059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4603C466EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4ADC4EB2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF63530DECC;
	Mon, 10 Nov 2025 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HOQlXuZB"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC8430DEAC;
	Mon, 10 Nov 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775939; cv=fail; b=OddZI9Y+dQegSYKZ9hP3GqtKC0+YOPTgJwT04PKqtdYUFQWm5v4p/EORtACEB5eK/RQePR0PStIXN6fIbGv2QnqPNQLhlUqS2iLuxKJL4fznaTBe62ykgisjbcDsfhQvRin5HOU+XHJ2QFhZdcIL3hzeM7FKpJjIIOL0a97XOZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775939; c=relaxed/simple;
	bh=XeKpLGfT7RdzBOO79OB3t/6Za+KJAEuY7f2pa58YB0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ku5XBSi6RKHzACSJxG4X4uwZ8uOJYTrXUtMNIT2nWOdHkoCFwQcpDCHxLtMadyZVpG7WsMeDHAoyin7gZuDZF0a4Smg50UpRBlTVdkF/l49LoiD8WANGOC+APyaFuSuHPOz9wxhhAx62+f/4uOWPcB1Wh6ugiRjMoSopRhEb6sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HOQlXuZB; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8gmG7nsu7TxaazSBXI3pE16AeOGMVCMcIQdmIZtjc0M9UVoLNn+OWUe5ckD+KRE1HBOU6W0HqsTTXLPM5CVYP+p1SzpvPFv3GEaTz7jxrZnMiIMkNwBJE/jc8XGsZ6qciQOnzoGxNJfMt2/AJCrq6q19/prM9uRjrjPCOADQCLE9RS861eiFshhkOxK+a00pAenTkMnnTRcBabylRzhdRkh46Bab7SJrOv85b7XBEqmkVov4+ev2yCEOD4eOldZKGuPAU9V0+a2k3Ze/+nO5sDobB95K28Cl8oGS5nU1F4QAy6yPN8ABIJW/080gN42/Ki32jTeQj4ieC49Fv7dtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS+3AQKhdUwOiYyJYyKE5Ik/j7tpGsbFmL3EI6U1MkQ=;
 b=s4kZzVqWtQAXLS4a5J8hnl0RNd9hPG/JajaCcX78xQZv0Jaibi93ZVS47NKvVunW9tVQDDOzlGAmEpdF9Uw4fjORUJY59wK2ADnSUFDS04B65tva1KqHHwfTRRqwiVoySimT0H1g/QRNYnyUXvWriXc3B3JNZfODtmfwsuXso6AY1J1Qn8NhgeXjvIgx2e1q06z/wwUow4w2hIIT64TWEg7gOAjDzJ2P4wm30yqGgvAddVOUv6hbbQGOcKxL3QrNJ9cSNB6WiE/r/V95f+/zihnublrZNRSeHxjR89lV7cIZJy7HMYZxkM2hwkrkEoma06cNuZbOiG2RM4KnwGcyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS+3AQKhdUwOiYyJYyKE5Ik/j7tpGsbFmL3EI6U1MkQ=;
 b=HOQlXuZByHG7O1EwZtd47N6Qm65q76ItpOxC7fcp+MduAJtc23ynsSEx5upV60ko2vT/R2JzqKvqqbWZP5sq7F6jA9T6cORQB635TlI/45qJTR6/i2nqWAJQx07DH7sVACTkiAbnRsEVJDrPvwHCQuidJnYxyz3ihUEWKFuR2g7+IDTKmsmKx6VmAR9eRiXTVAHfDI5RiC4lgvGnVH7rvyZKkCUkmOgp/wj0iIN/Umvd3K47ftH/gyA3b/IRclpRLXJH+/uCXkCF0fj+ZWxZ1HhrPrK9baE194gSZiNm9GShqN19VkrEOeP/ESpYYbyXgRy0rjKLe3m0OJy761Djbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AMDPR04MB11605.eurprd04.prod.outlook.com (2603:10a6:20b:71a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:58:54 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 11:58:54 +0000
Date: Mon, 10 Nov 2025 13:58:51 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: devicetree@vger.kernel.org, Josua Mayer <josua@solid-run.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 phy 15/16] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20251110115851.ew72c7b4n6npkxkg@skbuf>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
 <20251110092241.1306838-16-vladimir.oltean@nxp.com>
 <176277056708.3414333.5403009680990856810.robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176277056708.3414333.5403009680990856810.robh@kernel.org>
X-ClientProxiedBy: VI1PR07CA0211.eurprd07.prod.outlook.com
 (2603:10a6:802:58::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AMDPR04MB11605:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c11cc5-b183-4daa-8e6d-08de2050856a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xmwudsQSCdDwOb3ecTbWwPBrfqcwNt6eDi2Nc3nDRWhlzWI4JKLSkBsEW28c?=
 =?us-ascii?Q?d1SHLPx90RTPCagv/eedENhU7FkSkrEPou0lk8Py2gd3w9oWTep7eUVXZLcn?=
 =?us-ascii?Q?CbHYqzyojV4jB9J7wVGji+c1xosDNv4lHk8Gv/bCsrSklS1h6+KC2L0dqdUX?=
 =?us-ascii?Q?vaxfXTd/+Osp6cwovpVSb2SN+8cjyWjl+8EsSgopZbIq3mKOHPmLqVyA1gAi?=
 =?us-ascii?Q?PuSUJS45SG6AmNw6PIKVODoPEPqnJ9/HszwKRa6Qxqi1y6l9Fo9cF+mU3L+A?=
 =?us-ascii?Q?cBfh9AaFoHTmlj6zfXR6ePL0E72YdjxIj3XicbuEjywbhylbkuJkqS/A+QrP?=
 =?us-ascii?Q?wW6adMKuWhldJVWrEhueh6PkXIOwk138kFCNepf5MwbNBu5GJr0squw8Hg/V?=
 =?us-ascii?Q?4LQ1Ekgrr52AcsZISrzMoSxp1/sagCLS8GDSLqUTKLxrLDo9JlgLXSo9Uzao?=
 =?us-ascii?Q?rBTZ9QomSuaVlrypsn6lrZtQdExXJcZI0lW3KLXnJlEa+WugyxUsWSVE3IQo?=
 =?us-ascii?Q?U7+RX3JpGqCOsobM3M+wtjYPkOuDcZf93tZuG08GgLWYc6d8+dk6+6+ZHcsm?=
 =?us-ascii?Q?T9y20lLqEO9oPkEynR1bDjHPTqB7HKaD/MsXow0+k2bvt3BWzfbF9YorJ5o0?=
 =?us-ascii?Q?O3adpBgJN0wFQJZkYBdZjkZFvWazSDYWccYtcnb+j4Xw3vy9ALn+r/pCP0us?=
 =?us-ascii?Q?AIZhB6mHsrdHiGMDYtDNtDXiXnzJnS41Qk3CMo6akK9o02dOOb4A7LpERS/p?=
 =?us-ascii?Q?cP51497bCRKXlYpQ2T02UoeiAanmGfotDyOtO1lztQcd56qzZNl8WlJ6vM+W?=
 =?us-ascii?Q?7JldzvCg4zHJWRqt6IzGYfgkwWj3ImsMjOgkvJ21jUPyvCGS1vTxnBsJlxmd?=
 =?us-ascii?Q?qfmHe7uA+XAwtd7HU1Jyex0FLOh2ZZP0A/3Kqf34iyqGhgahP0imhpjwPoAJ?=
 =?us-ascii?Q?Mmx8Ey/4Yb6dbd2/b4vIj5GYt6aaWvWWadXqpBLNeQyoYgOjKPzJuO3nDnIs?=
 =?us-ascii?Q?nMyOHuB/PAbQr+s63+xbo4vQPyzG/YAa0dPB+OCXkvG9La7qjozrE3mTgSBo?=
 =?us-ascii?Q?Dpiq1xB7ViHE/OK9bqKb1MKtREFipAVWxAujOX01lt1wbBrUslEWHLomvj7Z?=
 =?us-ascii?Q?NcyXF3Ys+XfOu/5PqbESZJeRdvSEqVisHgDk9RvX3ECFDcOvVs6x5TWs5bEw?=
 =?us-ascii?Q?icSuL9LaOZIUf2TlIpeBl/4WKkHbazMel1/H66fk3yzpiwSf14vMqE1u+qAE?=
 =?us-ascii?Q?h7E8Wwd9eluKfJqnPNYH1CQ3ZQWlzbDc1S9LzX+6bDSDe21UyVVvkkveVx5W?=
 =?us-ascii?Q?ypT/Pq/X56CVgTqPRpSc5Hr/V2VLp/4TVfFWMbygRme6wRkhp4MNfSK6bD9g?=
 =?us-ascii?Q?zhbe/xvkX7t5S+9dmFuPg6gpVdjGWqT9TL1QBLHRC5M5dwFZvGdZVeJNy+ns?=
 =?us-ascii?Q?KLKVnJqs4jcDLicCpjwFDTFVDrhnQ0Mx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tslUuoUdjdf3MkmGWGXfd3Dd3iIJBQtn2PUplqh/HB3WG5ElnCWBbUZ9pRJo?=
 =?us-ascii?Q?ooNwzZTQ5RdbmTXIN3BxTSCpBn7svknFwUbByiq1gXEfLPyyUikR8PXhP7mv?=
 =?us-ascii?Q?ll7mVpt0Bk4m1BlYXWR5B/A8MLY5MSK69aWVxHN2i7d3lwes1Ggqh/AcLSkE?=
 =?us-ascii?Q?GRS/+o3hi8t5FwJriuQO5Ikn/X5yL7WyQPQ6JZi+eIwtfGgQ0p6X/jFqihyZ?=
 =?us-ascii?Q?EPmWwDGlLioB9psKB2laILwBYKD21+9py4EcsE//ljaqoGgRRmJJKdgWismm?=
 =?us-ascii?Q?7YdUJteW3s6NzDfccP7QV99XAZ2jZm+vqmUjw67f7MLnLkBY4FiRD6rmOBFv?=
 =?us-ascii?Q?8aZRQHI/LTczuChtSP3ghimVpadKlUho1H8RPUU1gvrGQ5dV7vr9hH6edUhC?=
 =?us-ascii?Q?uBpTYsI4juceQUqCPr5tasSNK6vpkyApI//TH8MT1bSngTXUC5Vb1r3QUNS4?=
 =?us-ascii?Q?ivE4+8eP1+DbTDExDzO3G2TDKf+U4rKkZ+R50uoSnMHO8GXArATR/KVS00MT?=
 =?us-ascii?Q?CpLb+cLlTtH/QT99TNLtpANUZlKHfhOKa7YSA9QBGYmKU3hWrSDmv4O9NYH/?=
 =?us-ascii?Q?KTyBM2n5CJY9qN9wEe6102+q768G1W6XUPPpKlk22gKns0bqpv1bF3089U2u?=
 =?us-ascii?Q?BU6igBphMcw9Qf5BuIIiFk7jHWveI17svB3LQOQvNkYS9ZjhJXo7JDMXypjT?=
 =?us-ascii?Q?/8NPlpFueVwMioKGPil5PxCtM3BEZZrlG/2UspMUY5KLp+8gOI61GSacCD7j?=
 =?us-ascii?Q?ZWXcYUeSyrBEo8WltA1eOE+mw7KY/gmTB3iToyHVatX8ZW/ZufOxlEIzkIyK?=
 =?us-ascii?Q?4WBPBPTb62/e7MttqMefT3MtRG5uqGaAe5fQ8liwZpQjLWUVEuPhhB9Ccr2g?=
 =?us-ascii?Q?8nU9LdI3cS687lFM7cbc0pUydBF/7c+shlSwIC5YeqitIOgE0QaCoto4nI+k?=
 =?us-ascii?Q?r5Mkt0xTrB7L5etuMbOym2X284NlblSBuQ12mK2IUjS2hPWc0MesrFzeKLeW?=
 =?us-ascii?Q?2iwuH0fUmx6xue5fhuITRbV1csX1QL2TJ5W3vZhGEcuqMkDC8ldA3jPuPwIy?=
 =?us-ascii?Q?v89kAKtvDMU5PGunasjo4kPrMcrdGH+EooAX8EjSAlQsQYXhH0u3imxs7aAQ?=
 =?us-ascii?Q?c/bOP3v5/5V/020VdD6hmhpauzWpsxpMitR9EjiTY0GKCx9a5l/4m8dxQrtN?=
 =?us-ascii?Q?AFO8p9vAGNo4GBmkKbN43ggEmpKgolGlokxZrrr71HXSW85ia4lK3/dKSNhQ?=
 =?us-ascii?Q?Gc4dBt8+sV2c4xl2AN7118fgCdbZLjc7BR5v7eVgsqVoXCwqN4El2U0GVwht?=
 =?us-ascii?Q?BvZhs6Gp3nO1aQylOm49TtprzbPNzgOlatwVdSkZ8hoEYBNnKM3ua65V2sFR?=
 =?us-ascii?Q?PShl+GoURNCs/QnLfRr3S0XD0VokfGPknKp8PqKITfx486i8CvhuF74GJSxz?=
 =?us-ascii?Q?zeSFuOM82LBDCvZ8VRFKmH2cgDgukVqjj5hy6Hihn1GshMl8XgLWzcezLqO6?=
 =?us-ascii?Q?MfGAlhCM9QL812+iMGEpL1lLsr2JfHl8nyK/5YKxl//mItPxNkADhBPoA2/F?=
 =?us-ascii?Q?S2G6KaDrQ/9OuvpiQqoARnhF21umPgrFpYkHtuctBXLCpT0Bt67sOx9XIyzT?=
 =?us-ascii?Q?CJ6B8NOCp1+WaShjCyYGZHwI557bfZkg2DkJYy8kcPvN5QxNGy9Yo7JXa7nq?=
 =?us-ascii?Q?NwEBqQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c11cc5-b183-4daa-8e6d-08de2050856a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:58:54.2724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulTECW5hwVSL2i6cWQ65vxl78B23ZmKTqgNRrrs3zTmNh1j/KGGvGkKoPfq2xGUiV4+v8LzFr21YVCU0Gi7OyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11605

On Mon, Nov 10, 2025 at 04:29:27AM -0600, Rob Herring (Arm) wrote:
> 
> On Mon, 10 Nov 2025 11:22:40 +0200, Vladimir Oltean wrote:
> > The 28G Lynx SerDes is instantiated 3 times in the NXP LX2160A SoC and
> > twice in the NXP LX2162A. All these instances share the same register
> > map, but the number of lanes and the protocols supported by each lane
> > differs in a way that isn't detectable by the programming model.
> > 
> > Going by the generic "fsl,lynx-28g" compatible string and expecting all
> > SerDes instantiations to use it was a mistake that needs to be fixed.
> > 
> > The two major options considered are
> > (a) encode the SoC and the SerDes instance in the compatible string,
> >     everything else is the responsibility of the driver to derive based
> >     on this sufficient information
> > (b) add sufficient device tree properties to describe the per-lane
> >     differences, as well as the different lane count
> > 
> > Another important consideration is that any decision made here should
> > be consistent with the decisions taken for the yet-to-be-introduced
> > 10G Lynx SerDes (older generation for older SoCs), because of how
> > similar they are.
> > 
> > I've seen option (b) at play in this unmerged patch set for the 10G Lynx
> > here, and I didn't like it:
> > https://lore.kernel.org/linux-phy/20230413160607.4128315-3-sean.anderson@seco.com/
> > 
> > This is because there, we have a higher degree of variability in the
> > PCCR register values that need to be written per protocol. This makes
> > that approach more drawn-out and more prone to errors, compared to (a)
> > which is more succinct and obviously correct.
> > 
> > So I've chosen option (a) through elimination, and this also reflects
> > how the SoC reference manual provides different tables with protocol
> > combinations for each SerDes. NXP clearly documents these as not
> > identical, and refers to them as such (SerDes 1, 2, etc).
> > 
> > The per-SoC compatible string is prepended to the "fsl,lynx-28g" generic
> > compatible, which is left there for compatibility with old kernels. An
> > exception would be LX2160A SerDes #3, which at the time of writing is
> > not described in fsl-lx2160a.dtsi, and is a non-networking SerDes, so
> > the existing Linux driver is useless for it. So there is no practical
> > reason to put the "fsl,lynx-28g" fallback for "fsl,lx2160a-serdes3".
> > 
> > The specific compatible strings give us the opportunity to express more
> > constraints in the schema that we weren't able to express before:
> > - We allow #phy-cells in the top-level SerDes node only for
> >   compatibility with old kernels that don't know how to translate
> >   "phys = <&serdes_1_lane_a>" to a PHY. We don't need that feature for
> >   the not-yet-introduced LX2160A SerDes #3, so make the presence of
> >   #phy-cells at the top level be dependent on the presence of the
> >   "fsl,lynx-28g" fallback compatible.
> > - The modernization of the compatible string should come together with
> >   per-lane OF nodes.
> > - LX2162A SerDes 1 has fewer lanes than the others, and trying to use
> >   lanes 0-3 would be a mistake that could be caught by the schema.
> > 
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> > v3->v4:
> > - OF nodes per lane broken out as a separate "[PATCH v4 phy 01/16]
> >   dt-bindings: phy: lynx-28g: permit lane OF PHY providers"
> > - rewritten commit message
> > - s|"^phy@[0-9a-f]+$"|"^phy@[0-7]$"|g in patternProperties
> > - define "#address-cells" and "#size-cells" as part of common
> >   properties, only leave the part which marks them required in the allOf
> >   constraints area
> > v2->v3:
> > - re-add "fsl,lynx-28g" as fallback compatible, and #phy-cells = <1> in
> >   top-level "serdes" node
> > - drop useless description texts
> > - fix text formatting
> > - schema is more lax to allow overlaying old and new required properties
> > v1->v2:
> > - drop the usage of "fsl,lynx-28g" as a fallback compatible
> > - mark "fsl,lynx-28g" as deprecated
> > - implement Josua's request for per-lane OF nodes for the new compatible
> >   strings
> > 
> >  .../devicetree/bindings/phy/fsl,lynx-28g.yaml | 86 +++++++++++++++++--
> >  1 file changed, 79 insertions(+), 7 deletions(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/fsl,lynx-28g.example.dtb: serdes@1ea0000 (fsl,lx2160a-serdes1): '#phy-cells' does not match any of the regexes: '^phy@[0-7]$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/phy/fsl,lynx-28g.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251110092241.1306838-16-vladimir.oltean@nxp.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>

I'm terribly sorry about this. There was a testing fault that led to
this mistake remaining uncaught.
Originally I was testing with "make -j $ncpu DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=net/ dt_binding_check":
https://github.com/vladimiroltean/nipa/commit/5579a443f88ec7f8a3e33108acb3d9d529ff825a
(and because this is a patch on Documentation/dt-bindings/phy/ rather than net/,
I missed the warnings).
I had fixed this when submitting the pull request to Jakub (removed DT_SCHEMA_FILES=net/):
https://github.com/linux-netdev/nipa/pull/65/commits/b7d53ebaaeaf1a4e474d6cd85b3b73d557a669a2
but I forgot to pull in the modification back into the test automation framework that I used :-/

Anyway, regarding the warning itself: I had forgotten in the 1+ month
since v3 why I had to do this:
https://lore.kernel.org/linux-phy/20250926180505.760089-13-vladimir.oltean@nxp.com/

 properties:
-  "#phy-cells":
-    const: 1
+
+  "#phy-cells": true // <--- this
...
+allOf:
...
+      properties:
+        "#phy-cells":
+          const: 1
+      required:
+        - "#phy-cells"

so I removed that part, but I'll have to add it back.


@linux-phy maintainers, if this turns out to be the only problem after
review, could you still consider applying patches 1-14, so that I can
make less noise while resending?

