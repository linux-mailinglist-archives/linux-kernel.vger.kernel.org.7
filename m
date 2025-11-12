Return-Path: <linux-kernel+bounces-897583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93EFC5396E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA04564621
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B9F31C587;
	Wed, 12 Nov 2025 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K31FwC33"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154302BEFFB;
	Wed, 12 Nov 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961821; cv=fail; b=XLP4LM6sz4b6bigL3C/+UQ3X+wa6g74BUuX6zVUsK2NhApvvH9C4Tdia55GtQ6EflaTgzAYYoRV5hsKPx7G0vUK3zPGPNg7rTGGasBAP7MbJo9MyDVDpmdOaJfe42ptZmQVT8O6PRYuHrT/Wtp0CLflIop07aPUfftHFdzkzBLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961821; c=relaxed/simple;
	bh=4L+f80oPKFqSssioR1U69jZqzN++mmOBux6JzCOi0xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zucu8ah8RsQR8YtrjCjqVGNIRCEfsdq46GdJJSkSBe5TCkwSxc7W0wAK/HQWJYaS08bMI6bfp+xhAv5yDZoz49hQT0B7mip0uAx850FzJnYw2L42NHOYoPxk+GaxoBBtO/Jjj3xHEjzV8/ux3Isbn+arvbnHduDOthMiDNpYj8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K31FwC33 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npy1CrX09Z47lCYNzDHZddl5lO0bxbcJKcnrwT2P+K/6gSYXYJoVPLoCCyiqEFzTXaMkqzgt6LMNOXQSoil4tiSZzvhaDm/D7w8mmSfO7xn0I43yD2jARo/WGs/MMSWdhitC25sC5UoqQKzdcihfqsHwYbTSQ5l1LWeaAqDxMd3BsOcPiG0t+Doa8UM3hVXfOME66btn0QbQKGXEPBvlVZv+sGUHtyMqajUlAwdUB64F6jTHO6GlhnG9AAPi6KJQJHfXZRkaA4uJjz5ETVXZfH52//J5uCy0GmdO37hDzEjimiAlRXg/KVrS4/SI4KdfOQieF4wjcQQH/OC7uRh43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7dpUYELm7KoFRH4nDOBoF/OqwDbI+d/zuSRgIwFXHs=;
 b=CfX0PRRPP+UNE3aPV6409ueWiTNIMBSVB1XTnavGQBuwIyjF7HFRZwuOSBdii834LSj40El2qQAC41TwKJz6SFq8IumTKCXPH91hWCXkp1VsYx+YuB8ko5pwmj163q4LVuEwPMaS2HjbUNPxjKWL8EgulRkhh4aOCvCBYj0eH9BpfofXuLilOh6UMqpu4R/lD/bUC6+rFjoo5hFo+U8CNnrtX9cjlaaGS+BE8xoHRT+2MXyWd49sOv+xQngu6s73D/iG4YW3YUSX5K92BSJEXYjqveb1q/HHaNTEH9j2+J5+Tjm1d05Q+K5E/9Ra3fEiBVg6K7cv/MVL4EC8o0d4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7dpUYELm7KoFRH4nDOBoF/OqwDbI+d/zuSRgIwFXHs=;
 b=K31FwC33eMq53KQULNry+9eskfYqwpTZrUJ60sDLCuA0rjgxw+a4bou9XuoOii20FnM3rjq0nbGKjCguOknrrMvqAiVYe3j69rbUmo2uSO3Um1OxIRwkIun4IZ9SqzhIDRXKqqNTkrtfRr5CksMGOUa5yyimU00KKsfWdZAajeQxQPOZlAd71NzCUfNuG88R3f49B5zKh3axIBmjG7gLYUNt/0BPsD2I+cKIfEJg/gjRcq9oIeb6M6HW8b89Iuwp+fKGnayew0AtlQ1z1GOndcAx3h4k3WloSaeEyTXEE8Ch/T1JWpS9OQr/tObYzlOdQgJYo9O+ef589xfE7w0S0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by OSKPR04MB11414.eurprd04.prod.outlook.com (2603:10a6:e10:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 15:36:54 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 15:36:53 +0000
Date: Wed, 12 Nov 2025 10:36:41 -0500
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Max Krummenacher <max.krummenacher@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Vitor Soares <vitor.soares@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: add Toradex SMARC iMX95
Message-ID: <aRSpifUe+fH7OHtE@lizhi-Precision-Tower-5810>
References: <20251111151618.70132-1-francesco@dolcini.it>
 <20251111151618.70132-3-francesco@dolcini.it>
 <aRNeMJWsCTRO3j6X@lizhi-Precision-Tower-5810>
 <aRN562k3NXCMghEl@gaggiata.pivistrello.it>
 <20251112094737.GA5126@francesco-nb>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112094737.GA5126@francesco-nb>
X-ClientProxiedBy: SJ2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a03:505::11) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|OSKPR04MB11414:EE_
X-MS-Office365-Filtering-Correlation-Id: 508eb6f5-1686-4551-2d50-08de22014dd2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?IevzEIi8JGVSupqPR2ElI1vtq4dH0xNbFuUWrcPXG2XPsgaXWsLf8+guOZ?=
 =?iso-8859-1?Q?axBxVTX/7j4p8y/hrRMIFWV2qAmNT56QN8c4fgWB6aSeAe3jZd9S1oAHH1?=
 =?iso-8859-1?Q?Fgme5i8CMhQK0v0Hs7gugwpobUreJuX6/ayjwID204CK6fZq98fHuNOtOT?=
 =?iso-8859-1?Q?rSeyXOntid928FUOVRx+VrltiOzyhAgaN/O6R62itlm/5ZwpwM96oiO+cv?=
 =?iso-8859-1?Q?JFZGRvkAqU2L+R0xlMh5CX5Ll+VxRqvLUdaTGZ4JoGq5w2Vbax9kALN04g?=
 =?iso-8859-1?Q?XqwlUI7eCwjLgBFEhEHiC+35E9tQy+90BvAOAU6bKM7foXadXwmwlgk7CG?=
 =?iso-8859-1?Q?Rs488Mlfyoki5mskxoRao1dQAjmv4mrPgOmkBJYFkIglIRAzIQNiV2jMk6?=
 =?iso-8859-1?Q?tceRMoha6z24fNMt1DyELXV3Je+soKOg/HBm/Qa3OxQUZsOY6f7vo2eaJG?=
 =?iso-8859-1?Q?e+iSaawRanyfWMFJOFvK14g7CC+ST2GY1yQEmyYRC58UAtJ4sek/a1i2rB?=
 =?iso-8859-1?Q?kLvcv99rOlwKKXpKmG6mGFCJdgn+9GIMBRQzdezx6NOmXiTwoyXIXZ0KoY?=
 =?iso-8859-1?Q?yE9cP11+UO4LKvTrPxiDsoEPa42F6GbbLknTR3IUNqui9fCpQ6jWVPb2P7?=
 =?iso-8859-1?Q?+rIdApHtXmfjmizR1QgwtJ4JQTTFvLnTf/rlWi88poP5nZhHdp0zHzMFwj?=
 =?iso-8859-1?Q?6jas6K/VNkwqtDEpZJ95s5dOcZITHDW7bGbZO3u8GmoirFkrkzcOYD9CYH?=
 =?iso-8859-1?Q?pd86aJx2MfKWIJXRSWZdbhXBjGCurUKls8WzTmOORDEerSw3ItPLHxUniB?=
 =?iso-8859-1?Q?H4I+v0dU54FK8eYymwXs3JfwDN5sUiRHdex1PP+pEIJ9gHhfMe6JCeVlIM?=
 =?iso-8859-1?Q?DDe6AJO60lZGYZH3u/+ZpjzLqe4sIF6+2agZ1lDPFvTRjwJYrschJfbfMC?=
 =?iso-8859-1?Q?H5hqkUl2uOSBNb9dGZpF4zeQFYlF/XYhAvXWdwyTr5+pcsiGfBYI2K0GdB?=
 =?iso-8859-1?Q?SzNTNJquZ2TFnZId2IndSqre2Fm/6ry4eZ3efOqkHrqTRjknHT0nGK4mIa?=
 =?iso-8859-1?Q?FiEAqMOFU+KrAPwMUb4O1NrWfRRyc9r2mHWB6JZk8WB6EAvtaFZo9C30+T?=
 =?iso-8859-1?Q?RwqcmepeaNfAMubcdxqXRHxaM/rm9M16PhkEFLFdioTEUY3vEkHTtG2PO0?=
 =?iso-8859-1?Q?rGB3GO5jvbJZGoC1+2Yhxw5GttTSsdOvZY+QULm7Y8UV1BDKMfLEOIspRu?=
 =?iso-8859-1?Q?5R01eSm3OYPPVlqOJybbj26NB/1GdnCNwZRwNLZbWJs4FKqlREi3jg1+iw?=
 =?iso-8859-1?Q?4ujRoIgJOfF3+hUyiPeLyIjxXsn1DT982OpKtq3cgEcdrHkHZvz1noBz1F?=
 =?iso-8859-1?Q?Y4xU7FjwSybBOYDL9xZqLJzUBmcKCOMDM6vTUVyhK2QYZaHfPL0HdmHPQZ?=
 =?iso-8859-1?Q?pGW+Mn3R1avq3rKMSMSBUouPJMuxyXYWAwvAPzoI+kTL/3uQhaAxG6Pm69?=
 =?iso-8859-1?Q?7707F5yuLY6d1YlbHpqre7t26/Qq1AV7vP164lfkxyVg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?7SEh+lJ0gKtTQ9tRDJicoQxW7RKkclrWit/LTvlkqwAk3xJu6A7rsS1QE/?=
 =?iso-8859-1?Q?5AJTKYcMyrP+Fjev/N7kRHc9VMp475uE0OW539tozoMTZalu+Spz3+U/f2?=
 =?iso-8859-1?Q?M7kYpQLpW4bz/CIUMwWpWVh8wehU9bLhWUjgJnWpb0J6Hb5aA9ILA7hBja?=
 =?iso-8859-1?Q?9+Ta074BoUYeZ3+qV/TWuYwWhSzTr7w5hxflazB6UKEe0D9fjQpgBh4GrG?=
 =?iso-8859-1?Q?QD7wKsJrC+QZk1GgD3o6oLQzJ2lwxkFvMFL/pu68jlayMox00PtWax2z1K?=
 =?iso-8859-1?Q?vlsiZ/WZn00NelKWy3LNDn1tdzrsKBm4YLQQRzop8VKkB5uRhHdGEtO0EV?=
 =?iso-8859-1?Q?gu0H0incb/kwT41zW4+S4XVJGHCXiCmmf7xz/3eSb/+AKpmmT8PPcY45Gl?=
 =?iso-8859-1?Q?KXc62S2DN6XbFqgINgWNHlhNRhqSooSkedvZg5uHtdujXl5R4kfknx53mO?=
 =?iso-8859-1?Q?kovA/A5oqKhwkBIWb3NcFmGHGL+dg0/ITl7DqBvJW2ytT3pbxj//HGNa7v?=
 =?iso-8859-1?Q?TwZONu1VDI38FkGROsMDn9UEivKiUfcFFO9pY9YDAm/UJJI1RUaaQjXVxl?=
 =?iso-8859-1?Q?nH5Nltn2xYCCEzsWJHk3Oo22NVwJ5OUdYaHAjXyp0muGCuZnfuZ/uBMSyS?=
 =?iso-8859-1?Q?Yj4dZYx3baTvxDbsxP4Vkw4xZJlQvRA08DRPbLeG/anhTLRh7vC6cyOntF?=
 =?iso-8859-1?Q?lbZJ+MZfvBaWt2wElcVO3GiGCA+HrZJWiYN5ejkYKy9Qt8x09daYU5AHCx?=
 =?iso-8859-1?Q?ueTAoi5FQxaoAShyxGnWQoV8OFEGCkpW1ahqMA3ZmzoZZFF/HCL8GT6Vd6?=
 =?iso-8859-1?Q?QDty/iXFHHjJ2+XijJPf7DIxQb34X9V9749FQW209ZWkYy+BGbmEwqexNc?=
 =?iso-8859-1?Q?RzRUmZdRcmsnU3qjmd/xQdrfijKCldh9HBoo+sxEoBftleSeel6IPTd2uP?=
 =?iso-8859-1?Q?SjmJ9PGLkYvCfeoC3jbGQzrcwdgPCmOn6Aa8kcUjvSqvhA+ewVZoIQjHfv?=
 =?iso-8859-1?Q?ZGp5ZWVuX19OMk1g0Q3HTtxu2bfY/KfQaTZB9BgdugBp4ddaVGfSruF39Z?=
 =?iso-8859-1?Q?56uHXzXoAH6tWclcKuA2Ed857tnBbODgWaYkCcOq054xDXEl5fT/HHn0Tw?=
 =?iso-8859-1?Q?IfPS2fLrL4uJ5Z7JplwXirZXxkuLE9RIjHsp8G2yxweupPhttz7KVvqf9G?=
 =?iso-8859-1?Q?1DxImz+Hz+ub6SdCjL/NkzL4qOjaRybbYiWNfkWLzWMB4GKDopMsWBygcY?=
 =?iso-8859-1?Q?p/y7AKp4OlAFE+rx33l4jSnBB73PYuhQ6d0Fvu/dQsWoBYyqqsMx+ZF8R4?=
 =?iso-8859-1?Q?Ly66tvRF1Kx7cnTXBOno+ewzlhmhwiEVpItYtH50iaesxqjG7Qm1OvP60A?=
 =?iso-8859-1?Q?xOeeBu+uLxNEfEIYVuw2gJykQE5T/11nnitIjgHbkIsLJj1lzuP3fMLw8B?=
 =?iso-8859-1?Q?hArW88NSf+7lrCaizjxqOuW2g4UTV0RueDt+xSmwTyn+OpvXLqBTqKfEa3?=
 =?iso-8859-1?Q?OUJeYgTP0zzTaAPkOq0Z0NJ8/tcTsd69LOzCqiygoSnSDXqZUYQxtcHKbP?=
 =?iso-8859-1?Q?NgBJBHfdEGilIngiu074Le9MhoCU8LHBLx2HxaCMgLcNlQEAMIsTrwvUN/?=
 =?iso-8859-1?Q?49go9mvmWfO0pMBBGLrAtMNfKpLDnWmjca?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508eb6f5-1686-4551-2d50-08de22014dd2
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:36:53.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaYKyWzYJYO+JmPbyx/VAsqz8C4Vjt3yK2XeCC33MLkKr+shY92A+L+thDEgmHddI+OATD4ciBtmGYkOIVLwng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11414

On Wed, Nov 12, 2025 at 10:47:37AM +0100, Francesco Dolcini wrote:
> On Tue, Nov 11, 2025 at 07:01:15PM +0100, Francesco Dolcini wrote:
> > Hello Frank,
> >
> > On Tue, Nov 11, 2025 at 11:02:56AM -0500, Frank Li wrote:
> > > On Tue, Nov 11, 2025 at 04:16:14PM +0100, Francesco Dolcini wrote:
> > > > From: Max Krummenacher <max.krummenacher@toradex.com>
> > > >
> > > > Add DT support for Toradex SMARC iMX95 SoM and Development carrier
> > > > board.
> > > >
> > > > The module consists of an NXP i.MX95 family SoC, up to 16GB of LPDDR5
> > > > RAM and up to 128GB of storage, a USB 3.0 Host Hub and 2.0 OTG, two
> > > > Gigabit Ethernet PHYs, a 10 Gigabit Ethernet interface, an I2C EEPROM
> > > > and Temperature Sensor, an RX8130 RTC, a Quad/Dual lane CSI interface,
> > > > and some optional addons: TPM 2.0, DSI, LVDS, DisplayPort (through a
> > > > DSI-DP bridge), and Wi-Fi/BT module.
> > > >
> > > > Link: https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx95
> > > > Link: https://www.toradex.com/products/carrier-board/smarc-development-board-kit
> > > > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > > > Co-developed-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > > > Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > > > Co-developed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > > Co-developed-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > > > Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > > > Co-developed-by: Vitor Soares <vitor.soares@toradex.com>
> > > > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > > > Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > ---
> > > > v2:
> > > >  - move enable-active-high after gpio
> > > >  - add newline between properties and child node in som_dsi2dp_bridge
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/Makefile        |    1 +
> > > >  .../dts/freescale/imx95-toradex-smarc-dev.dts |  277 ++++
> > > >  .../dts/freescale/imx95-toradex-smarc.dtsi    | 1155 +++++++++++++++++
> > > >  3 files changed, 1433 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx95-toradex-smarc-dev.dts
> > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > > > index 75676b908299..28f8eaf18471 100644
> > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > @@ -390,6 +390,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx943-evk.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx95-15x15-evk.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
> > > > +dtb-$(CONFIG_ARCH_MXC) += imx95-toradex-smarc-dev.dtb
> > > >  dtb-$(CONFIG_ARCH_MXC) += imx95-tqma9596sa-mb-smarc-2.dtb
> > > >
> > > ...
> > > > +
> > > > +/* SMARC PCIE_A / M2 Key B */
> > > > +&pcie0 {
> > > > +	status = "okay";
> > >
> > > Nit: if there are next version, please consider add supports-clkreq.
> >
> > What do you expect exactly?
> > Maybe what you are looking for is in imx95-toradex-smarc.dtsi?
>
> Found it, you are referring to https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml#L155
>
> We would not be able to test it, the required changes in the PCIe driver
> are not merged yet, so I would prefer to skip it for this series for the
> moment.

No impact for current drivers. Only thing you need check schematic, make
sure #clkreq really connected. If connected, you can put it.

i.MX's PCIe driver default enable it. but l1ss have not enabled. add
supports-clkreq will keep the same behavior as before when pci driver
update.

Frank

>
> Francesco
>

