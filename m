Return-Path: <linux-kernel+bounces-802666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A53B4554B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27F41CC3F30
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AA82F744B;
	Fri,  5 Sep 2025 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="khYxkmFc"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010031.outbound.protection.outlook.com [52.101.69.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F52EBB9D;
	Fri,  5 Sep 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069370; cv=fail; b=iuojzmd1iCf31pcoXkRsIGyVo0niriXliisSeX/0s1T+1HMGcoilImZnj9DluSKdQR9Hdfs/bC+Odph7B0ITpsQbTp++dii/hPF8pX6L0epKP7Kh4Gs4B3qDaE4pU30ReWlc3QihWf9P/MtHCwHQFy/33bBRzbvk+8w+eIDfaWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069370; c=relaxed/simple;
	bh=CcxkZt7/E0qHJm62GVsuAtrGiu2R68j8jUsGdduNRUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tt+JxjauKBcCoUwWz/OwttE9lKNjAEScotoI8ucAT7fpeyNa4UKk+1o51YoSEEpFvn2efH8OyrvdR9eDimrIMrxv/+S7bAxjjZssL5nARqoSvni0cIuVEkyTtbE0ftAYqaFxz3zhV/DmOBjlVLs07JG5bZlS392xzj6xbZYcZsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=khYxkmFc; arc=fail smtp.client-ip=52.101.69.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujttKOV9fu0LFLY0Uj1Q5rKYRG9KAOfKAnGQp7JvZyrAVhyhXj0yyyaujpBLwT8IOCab83PNygU2tsInRCynu9hJukpK00OzP5easUoJXc1RnvWkWGjc6bCtjbdE3/4gbfRa6KqiDpZx0yKsTU4FdOQrOBreMXc7Qy2j6nOyXkAfJghooFd0Ul8d7C1avCubTtOAKvR1uLJSuaay1CaB4SDEXm/vyAWB3y3qbJyYFp+N8j4ALtPtmTp+7ztkUPk7bnkt2Ghgv0YF8fz+ugNBWHUt7SU07RyCM9uvItbTZc2bqxirwXTx0AxLD08b19gNM0UdD+c9ub6UX7LqhZaZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/pP6ZYs/y7LT7GeU4x0OTFGE1iPR8ZqAlWvdgz1PvU=;
 b=g9Sz1qNKoAMK/JHWlrSmgxyag239bbp0cSpVqxKPaZ55nQF8ngtGA0AF6s6iCQrFn54ouVfnVUugmdt104L/rNmr2k0Oa/EppiLgjBzmS+4vjkOapu1nB39QluNlAljAnN3BwSr55N4we4agoLSE6lVSdVn/muSyU4Dwh4OeaaID7itzrKG+68TJj/F6FLIu6nafC6uqykdxpe8QJTRhetut9nwXpIbBDTn8X7QUpuEvsu3Rz2jjTwl4u7svmnjo6XZp5TB4mP1ApMGWVmN9sA1pPCGf5BG94sSUHBxrQhC5SvhUurBiQIWAENB+hITbGwAqOIszVDCuJ1HFv0KaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/pP6ZYs/y7LT7GeU4x0OTFGE1iPR8ZqAlWvdgz1PvU=;
 b=khYxkmFc+/sAsRB3c6lbaPFzw3LsOM8fTEkR6EPKqQPhl/4rtB1mfcKG8fzmTBE/fBBBeYqutD1HxGISEaQsY5QMJSk9usFiVbrTcymAv6C+mOoKTVoW3om4ye5jEX4IUGoW5eZv2G6W8nkwI0Xoa15xH6hLWHoxIFD+UCL4VTSzyR+Q5mKw7oYKmAVNxNONsNlm4kPzLyEgHlNBNTDW4JwbfeY6YjNipJs2wIzPYcCv0hEgP/W1uMQt3sz1C7ImBj3Tg78ruG8KIHA55HiJjSU8CflLzx+a1qILmFQ5pX4EBtw6vHQBLJ64S9vxfoBakYHtekog65KiDHPPs80QBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB9376.eurprd04.prod.outlook.com (2603:10a6:102:2b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 10:49:25 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 10:49:25 +0000
Date: Fri, 5 Sep 2025 13:49:21 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-phy@lists.infradead.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250905104921.7grpgloevlifa3kj@skbuf>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250904-molar-prune-4d3420b1bcb4@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-molar-prune-4d3420b1bcb4@spud>
X-ClientProxiedBy: VI1PR09CA0172.eurprd09.prod.outlook.com
 (2603:10a6:800:120::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB9376:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb1d230-1d54-4330-07c1-08ddec69e139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gfRIajNoHnfOTiDrSZ+PVmmre5k/2EPKXigigWJ/wmPbrS7+/hbf//Nu/jmk?=
 =?us-ascii?Q?ajcRBLBVCUkp5xt+aPK9iPNW/Zv+KdUSE7rZoRJFj1fERdMHx4NLARmbU0E9?=
 =?us-ascii?Q?ujaj4D06sdVpR09RSdaM02kjYQ8eCJGzBOq8stP9iVhs1tD9lm8RHsI4rnlD?=
 =?us-ascii?Q?w/G+0lRYo0FKTHk9qY3I2C386eY0pgmKoMYuKcbz3PR5fi6Yb57aquuClYtW?=
 =?us-ascii?Q?grn1YZ4j/AA5+c76QnB8eU1TuczXJDdTtwHuiRT1kzYqD6+RG4lHDX0BUl+X?=
 =?us-ascii?Q?/G2iAkMpI3G50/6OFdFl72s0xTTGzXhmkPkWWOpW298oKcSUYyJAaMJoNbTa?=
 =?us-ascii?Q?7/VFMAg2RGRhI2AGfF311/tfMmInPUigY2eGFNv0b4uN3VUwJY+RcRKSCd89?=
 =?us-ascii?Q?V7f9ndJ39oNcQcREJvneNWbvu9lnJKcp+bXPUdpZUI7VRg6g0+JaQg9FIzf9?=
 =?us-ascii?Q?a5k16ze/yyxFFnIYsBh35bFDE2gZ/bKZWUyk3/SWGLnIyf68aJz+kgf3MGbb?=
 =?us-ascii?Q?9ZHAb08mGySkM6ywRX9s0Qk72mn2EKScBlaU96aeTYiLhxI/aT6UWYSsEv4H?=
 =?us-ascii?Q?8NhMgh6IPlv/c2XdET/TfxsB1miwMLttifATTcdoYuCX/LrDYRNv2D5y3BbK?=
 =?us-ascii?Q?B2+d+1wVvdE6UseNLfrtgIfaHNx1i+EDIe4ndp+Pzo3dcZXck3OMeRVmgyTV?=
 =?us-ascii?Q?OJEXTkG/0q+rvB0pCm2/5kq8CfN4A+kYurjn4EIhsqa2CeXxVkOERRfAghWP?=
 =?us-ascii?Q?FM0FuaSXR+89PMNQbl2+vqiRRbqoF4FnG4FyH2gm+7jQ3oUlG9spWDJSujCp?=
 =?us-ascii?Q?8taDadyN1bcJmtBRV/zqd95GkkT+WY0BSg9QO8SP7c6JxZ/QvAoAFDRN10LX?=
 =?us-ascii?Q?jTq7lS/2uaz281eTxIXMAHEROdFIT4muNTPTo9Va2rYTjTsWbmeNiwMokRyE?=
 =?us-ascii?Q?pTbwnZM9xdgxOqk/Za5EodhQyoRcUzu6OaRPNzdXjPqe92/xD9NbopaODyXk?=
 =?us-ascii?Q?nJWuwG8TyLmZ4Pu9gEAftbO642MEfLm1Fi6PqDQ7U4wvlG8Hh7GjxMml3tT1?=
 =?us-ascii?Q?bO/XERLA/gkCzNYdMbqWAtoWnPXSlRvihiz2NPdXrgR2abPXaxoIKyxNDY1n?=
 =?us-ascii?Q?uBIrf8Nx1mnOP9GFZuIlLTkxqpYvGxTPdwsDQ0z+tykvF1jbP0yPpz6Zj/Gr?=
 =?us-ascii?Q?sxilOdkIy0mRpynTEDfcMSV7OHjAKILxkXz347gcdIU7OX4odP0ArnG562fA?=
 =?us-ascii?Q?H+ytqLOEZOL5EdQR3dpLspmhvb8wF4EQeS9vXhzkV8f9keEUFvICqCLCHrwt?=
 =?us-ascii?Q?Y/3Y029WnWqFhfSaivA4bx9oYq1NhXwtK4vo+4BRpX1ev6e/gen6q2WL5geT?=
 =?us-ascii?Q?NzWM7B6xERNXwvH4ylTUbL4V99G2gGRosm3WvcmtHWgt6uWCYoeUTcr0gDq8?=
 =?us-ascii?Q?EswtbpoN09o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lKuD1CYvcDJ//5FsATuFAMfPMVd8ZwpKrLkbarcveq87cKF33QqXf/ZMObNT?=
 =?us-ascii?Q?KME1RDYVmJv71k9s4vsbeRUl2Zb0rs4NSkDWSwMPgehDRp5Bwm9DVdZ2Z9Ag?=
 =?us-ascii?Q?tU/C+sg+mrlTFs+KzTDedRjFzTdfDwrdxO9UKEt1NJYhz7ngCXPpRu7O8YAA?=
 =?us-ascii?Q?18eoDZ/RmC5gvK8LCD0cPP3UqRQyNispC2IojR7WwzL5U/WlF5tnNQ7oWJ0F?=
 =?us-ascii?Q?spH033llaBoM7QlBkIPXyZKZp6IwMbJ9nX5EgbzReVaj2wO+3kqj0okf1BfI?=
 =?us-ascii?Q?jKKNDKaK5F5YkmG+e7UMXYMMFofja/m+3JxP/01oG92sdfbGGMzJT3woPRkJ?=
 =?us-ascii?Q?Ic9r1DpILrU3J0GBoCPVS1DCVVHmC1zKX9QJ8RiaaMWGD2jK9VX0fgRyI+0E?=
 =?us-ascii?Q?OCSMDaL2iH7B57YYvCSkMRYx4mqkFV+vJEVF0cNaHh0xdWto0Afdy3V6Xkq/?=
 =?us-ascii?Q?GQguJ8rlVuFhnFILoh+V+JLZfqQ5w6ptjnbIEPhRQ1ru5QJug9cDnG/97rnU?=
 =?us-ascii?Q?JKbDxOwR6ZN4qH4oeWUqOk0uvR09QQZ3utdeR4Gulj27zEX0QSgB7XL64upg?=
 =?us-ascii?Q?PH/mGnPW110n7HVsTItWJp7X6GjeLL2BO2PdhydMnLATMJwcXuKyhrsAC0uC?=
 =?us-ascii?Q?Cxc1aPNjwfEMLn+TEdh3gLQk2tQ7QGLof/eob/z1jIco5MNQukx5xb8rQ+xP?=
 =?us-ascii?Q?nWNpSyTvSikjm2dvBansu4lucv81MKVD3BdgQBR2oqYfBmvyJItNmAXLMTFo?=
 =?us-ascii?Q?lGsM3j/YC5UAGnz//uL49IV1YPUKA5y+VlcCxePYEcP2KBkGLeXj0oMMQd7n?=
 =?us-ascii?Q?yNerkijmZWhFPYFFFcNRAtpFfSEqB3V2wKsJgeeeq/skH74BHXG0kiPOUJNg?=
 =?us-ascii?Q?cAxJj0YkrOCLrLahXpjp5P0n7lNjNkojthul0PhGMXxMwbLm1qVby8Fo4UJ1?=
 =?us-ascii?Q?kOPwmFaPU/HGVmo4bg+fsukICOoaDONX21ALr9q5Gt1K2qjE8NHgMBAmVn/L?=
 =?us-ascii?Q?v93goMHfQN/8oO69i1+wze+bc0tqLKxZmw2N1s6NLaXtKpmTad2FvMxxcY7E?=
 =?us-ascii?Q?HINj7fb0MucDDxtmDk34sSvgTfnoP88KnSsmdRnNBDGonwa8qPC+Vd7/I47c?=
 =?us-ascii?Q?YvMu7eQTGXFCcuFgg0L9/scTOlBC4RU78Bk1yjchleVK8xSrA099kjfKfsun?=
 =?us-ascii?Q?RJVVjFmO+jheqRB+azTfaNMAaTBTIl8bQVraaZxAHC7+3FBnK8u0Hc/yhvfb?=
 =?us-ascii?Q?11rOpF+jMnmmu9gmp92GLwNg9bx5imRsd99HDKkvgInUkQSWimofvhwaxRQ1?=
 =?us-ascii?Q?ionfD6gSRG3X+HHioeUWKQRYF+PxmDFoQgFCfXCd6WeRhJTbuhrm6xtCkdVm?=
 =?us-ascii?Q?3wcs0frVcGapGAE/RqoLDYIovLVrVQVk7u91CbErfb+Q7nsGMMq66fueJw8A?=
 =?us-ascii?Q?WLzQl8Nb9NJHSISkr762RNGJAJpXM7yN+ETQmlIRUVJv6DNtw22U2pWLAWf3?=
 =?us-ascii?Q?mmYx84WkrrwMtStjvqpcrfUzmGxACvXc77tmWiQeNQRq0NK9e6gjqPfD3C0i?=
 =?us-ascii?Q?PQQ6EgraIgt5aneD3YtgLT5lpkRcyt67Y41m8PP3JWbQaU//fnDJ0GMwIOao?=
 =?us-ascii?Q?ulcuknh0CprVizEx+V6fKxKVxDvXnZKRT4248Mr3T1Iafi3jyNc1OJQ0+cQH?=
 =?us-ascii?Q?w/RJhQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb1d230-1d54-4330-07c1-08ddec69e139
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 10:49:25.2717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nZO76nriJu/p+pHbLXU6q6dqzu7uBzMd0t1YRZxQexXaUvOBa/Y6QUBC3fbIFqhJJEg3hxtupIBi5BrIFcLxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9376

On Thu, Sep 04, 2025 at 08:22:16PM +0100, Conor Dooley wrote:
> On Thu, Sep 04, 2025 at 06:44:01PM +0300, Vladimir Oltean wrote:
> > Going by the generic "fsl,lynx-28g" compatible string and expecting all
> > SerDes instantiations on all SoCs to use it was a mistake.
> > 
> > They all share the same register map, sure, but the number of protocol
> > converters and lanes which are instantiated differs in a way that isn't
> > detectable by software. So distinguish them by compatible strings.
> > At the same time, keep "fsl,lynx-28g" as backup.
> 
> Why keep the backup? Doesn't sound like you can use it for anything,
> unless there's some minimum set of capabilities that all devices
> support. If that's not the case, should it not just be marked deprecated
> or removed entirely?

To be honest, I could use some guidance on the best way to handle this.

When I had written this patch downstream, lx2160a.dtsi only had serdes_1
defined, as "fsl,lynx-28g", and this patch made more sense. Keep
"fsl,lynx-28g" as a synonym for "fsl,lx2160a-serdes1", so that new
device trees still work with old kernels (as is sometimes needed during
'git bisect', etc), for some definition of the word "work" (more often
than not, unsatisfactory - for example, fw_devlink blocks probing the PHY
consumer driver if the PHY driver doesn't exist, but the 'phys' property
exists in the device tree).

Unbeknownst to me, commit 2f2900176b44 ("arm64: dts: lx2160a: describe
the SerDes block #2") came and defined the second SerDes also with
"fsl,lynx-28g".

The second SerDes is less capable than the first one, so the same
developer then started battling with the fact that the driver doesn't
know that serdes_2 doesn't support some protocols, and wrote some
patches like 9bef84d30f1f ("phy: lynx-28g: check return value when
calling lynx_28g_pll_get"), which in all likelihood could have been
avoided using a specific compatible string. The lynx_info ::
lane_supports_mode() method from patch 14/14 is supposed to say what is
supported per SerDes and what not.

In terms of implementation, what does "deprecating" the "fsl,lynx-28g"
compatible string mean, compared to removing it entirely? Would there be
any remaining driver support for it? Should I compute the common set of
capabilities between SerDes #1 and #2, and only support that? What
impact would this have upon old device trees? Is it acceptable to just
remove support for them?

