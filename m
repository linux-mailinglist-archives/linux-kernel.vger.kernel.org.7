Return-Path: <linux-kernel+bounces-833943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85A2BA360C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7371A3A3739
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E99829BDA6;
	Fri, 26 Sep 2025 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gc2BAQfz"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD501A58D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758883096; cv=fail; b=og318nmRemeRDXK54l//7evHDRWD1gfIVHO4J4kUeq4H26QX4KvWdz3lFERJYU3bCg3fopOfY/lmFKHSnjESZvMAZJjEdJThOl1AGDUVv+yZ3ADNAlzbo2mdtYWSADxIsQ41I2Z93B05cZflJ2zPEMQm3ZM9nyYan5IW2FOnoDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758883096; c=relaxed/simple;
	bh=GDIgtPSkt+VeTQO1MlWrN9aBnFZkLV5u5OvgYKnSOwI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EZQWQJSnHIpcxql3h9NYnyanf125gKJqopDXrIZk+s4Eh1K4g/M53+EhYfCurMO+OshALtXNPPOCFLCHiMJ6xib/hx8FOQ6p3sRwHMF0iAHciXiimTclvd6+Z/GwrCTykEQbSmD1ofo0aPXngLG6DAMvT+QvtNbVt9neaCTijaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gc2BAQfz; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0K7yKs9iqQlY5GqUyn81E8uGGZ1smTiwzhRd0SHFPLq+3aa06BIyca61jHyuyQaarRS3XhiMBo7A7NdAZAEbSsucYAvcRCwVTmsec3mJSRj3Vbkb1IqD1LSD/zQwypOmtdTVdm6pyfAY3QYZGv+9qJID5rNHpWpcR1S5ViwJjO8srQ648bgmxNTULivfkp+flwCrxy1O36Smd7+eFEJ/Ah/5yhjPaQGmWI4U53qAbhof63MismEbd5MJgZsSQfxOIi0g+wBTToG1VaDeha/WO8Ap8VlvY2JjYYyqPY/54WfQHhnM+qPezWuj8gv/zk1kP067Md1o3QcsmoctpELaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rguveA0dIzyRH9l8noG2C6IaFADBZYBIu+ahxDWlz3U=;
 b=ujWUkrg2Cywk59VbgrUUXvgtlmCWdQvnKqe4dUvX+evpfpCQSMcopY42XWHzMRSZviCnCDVlwGszM0g3bm7FAm0eZQw8keP0xFThp3pFPLw0IxIRhwyTS/sBEEBeCcMUKZX8xUfMOjdsypbneaDeXL+J0M7gp1DLcXTzjFS/TWFrXGWq1Pg2vB21E3AjlqCrOz56wAWBXB73oGNo1jxKjlvnkqmq4gSzEzmtavGUqXDd2WBgvGFce8kaMvzHXiLXOWriiHpiLePlaRUcU+X9QXrn4y864zR78IMXNGAUkXm5tzS9BvR9fqgFksudr07GH2VNYSuFn9TdV4Kroo0nag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rguveA0dIzyRH9l8noG2C6IaFADBZYBIu+ahxDWlz3U=;
 b=Gc2BAQfzk4B2VjJ11hbJ8qb7ogESqiIKoRTvrRbnvz4uP16VkLCTyqOFP/JDeVe9G5PIofU1Sa1q7s+oieLnHjAab/OG1+Q3JFj+sWnr3hksr4eAvfdNy9vsUersqIEIPH/gaM9/86uw0kg/XBbzoeG0Cr/dAIzdsQaHShKvdFY=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 10:38:09 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 10:38:08 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: Frank Li <Frank.li@nxp.com>, Arnd Bergmann <arnd@kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jorge Marques
	<jorge.marques@analog.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH] [v2] i3c: fix big-endian FIFO transfers
Thread-Topic: [PATCH] [v2] i3c: fix big-endian FIFO transfers
Thread-Index: AQHcLZBu2lcu7eR7HUOLh6RNKtQOPbSkAZiAgAFFwZA=
Date: Fri, 26 Sep 2025 10:38:08 +0000
Message-ID:
 <DM4PR12MB6109D513FD8E43B76D501ACC8C1EA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250924201837.3691486-1-arnd@kernel.org>
 <aNVbHeky1X58EYT1@lizhi-Precision-Tower-5810>
In-Reply-To: <aNVbHeky1X58EYT1@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-26T10:35:19.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|PH7PR12MB9204:EE_
x-ms-office365-filtering-correlation-id: cc8b9c5a-32df-429e-2e93-08ddfce8c8ce
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CHXb7GdSLQi67Mjrn32aaVzEl0atI+lkqgZ6kdWdHAEoCV/NfiOTdn7ltI6L?=
 =?us-ascii?Q?SnBP2GfknlApKh+kbMT9E1cuwJZNtD7wie3Bls5+qWWPdrqbCrpbHQCSp0jq?=
 =?us-ascii?Q?mTiF/9Kq9yzAYqyVHor05xcwoo0eGKDG9owdZ50XwO20pQusmqg0eTHtYHIW?=
 =?us-ascii?Q?EE/7pQ8BYJ4y3DdH6I+DMtxMsLaDYaEqGsyrHdwKk7awxNlP5iZoqhkOfSTr?=
 =?us-ascii?Q?Sa2zFLydrAVdF0zdd6VpdoChb7SBFMRSFjBbKop40mcHLdH8OAPVPGPWleR4?=
 =?us-ascii?Q?c8EZoOX+1ENQ1dakwJRt0svoStp33R0Imp1WB+zcp3P2VYUkgYpJsNltNH4y?=
 =?us-ascii?Q?IVTt22xy1rsyv3eDWPNysZsQ85CeQG8Uwtb/xobcYob6pTjU/J3BTFqGrAyL?=
 =?us-ascii?Q?/EOOqMJLLW2v47htX/isxfNwEzNPcRaaH0Yk5XhpXe8Viv2J/tzRRP6Ir1ev?=
 =?us-ascii?Q?nojPyiAUXFWJYAnbAIo0RemUuFjOElqP01Xak15KIUAcTILR/K8XfWUKMPnm?=
 =?us-ascii?Q?d803jn5DSPeybasxU3kv6FbqoRdSjnY+l0669MvsJ4J0JKPvsrwVMSeVII5O?=
 =?us-ascii?Q?WYFAthIkUb97muMBXpTBCI34pwxp+a/6Pb2xdlaznXiRmhA2u0HHnOmSDHte?=
 =?us-ascii?Q?mmVhEF3oZz9oPoSVfI6pFQKAlNORsbuXzdEc6wD4yNsXKzO+mAFk6XR5ZBX2?=
 =?us-ascii?Q?/EGlHQAMql7JnGXCUqs26IJivgQseDXGH78WNcfsOscAJWX2m9NR7/91bRVz?=
 =?us-ascii?Q?b8Jv4eyiwP6Vx1ziwUqo+VyIT3YYEaVpS9qmUDs1n0tustu0Isc3YqOjmkXd?=
 =?us-ascii?Q?uCYpph1cEtFOITEX2HnIOtquAdUUANrukbq1aLkmPMa3eQYAbD9mt8DKmo0z?=
 =?us-ascii?Q?Nx7X3YI1m1Iamu7tgorOCJwpspj3pffduH1h3hk8NVPowKFzCf9c+Um0PPef?=
 =?us-ascii?Q?JBGjHtxEOEqwOFZL90tuJTtD3o8sJbI1ZZmKzAOvIlOPQeRt+CWtcaOSm/W+?=
 =?us-ascii?Q?MP8tjGtwPC7zeuCokQvUNWumTwE1p1SfUjM6oQPNgyi1Xnh0qA8YQgIu4d4n?=
 =?us-ascii?Q?pMaFyrmPMRY0H/h/YHnyPVS6lBgy2nKm+mBdzPJMeHrHta51otAKFuMxtFJJ?=
 =?us-ascii?Q?f829fBdrUNacw7eql8RN5Yrr8Ns7FHKW+TVUZiu34aTkQJ3VfI8SG7gmFosv?=
 =?us-ascii?Q?NomJTn5F7Xv8d44vh49lraDjJiFVyboksfKdCdMyUGolKVUcKVatKGsGmUz8?=
 =?us-ascii?Q?SO44RELOVtbVqg5ntbucibFZfAlQPnOmHikghiBpocD7yrN+GQzdA2djmXhE?=
 =?us-ascii?Q?IQlLW6PjrQEqUfSpL2X3qtJuC/CxUXSFuPtuYNKp5HJTAOoiD8SGdDpgLSgi?=
 =?us-ascii?Q?sFLgr9bk3GKcsSQpdwjISk4IaFoaa1Yebyy4kykmUc4uJMIVn/j8p00OikSp?=
 =?us-ascii?Q?sGtIGhqnCFG/6o/U22E+88huxiEtGhM7Sv7GKi83VDIhBIxh92Hpww=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+aBrGoS12OKTt/E/HBYzk8djmJ0w1X973rsRBpqEwwImwfHt/1x9sCZIQgW/?=
 =?us-ascii?Q?pkqxF1/kn4CcOIlNoEFH4v/Oi6tYT3xKPNm5pLtZOEK3KMG9Q2/TX92QnYWB?=
 =?us-ascii?Q?kqQEaEbqa4ffdMiOVipDKkR73HWXrDMauJe2mcVl9czFzhJXXIh8S/GFTs/X?=
 =?us-ascii?Q?y3BsehVMVPJWop3vacqg2XwP9K2hC1SAToL0y/8kbHfkxDCrFJsu2SCVRFbZ?=
 =?us-ascii?Q?Z09ZnHfFubpx9TcvHJReBolwdgP32mIEygZkSQEF5HNDL6GakcDAMQU3XjHP?=
 =?us-ascii?Q?SiFkTN0pG1Ohg281PK4NqCU2LRssYw5apzCMwOLp4p0w2Zna1Em12ElWoGDA?=
 =?us-ascii?Q?p8Sp1m1/w1ZphoGmOwpPsjxI6xK0Awk3pi9YK+KPJ3TRuk4p217ovTnMgYfs?=
 =?us-ascii?Q?LpkUzHOGpNqYF5BU643ZuyTMQioFI+/PBkm0R2t1D+AteEQRjLutMpubO2QG?=
 =?us-ascii?Q?rdtbLoU2LO4c3qtZp1OA8wpXVccpdo0MbIN/L4Jzd30MxCp7d1AV5U4+nXUV?=
 =?us-ascii?Q?RNADLtM0B+cxS4aLrjzq4JJEDE2qdkc9d0rDnurtlhrgPHKksRFQiaAQpW6u?=
 =?us-ascii?Q?N+yk1lq2Ck7b5sonIIonLI5PGiN5OUyaNkzMaFqBeVTJoxvnqeU4ESnzNupj?=
 =?us-ascii?Q?DwWxWhARXxJ9ntBaC/YBdVFP6xN777XNoyzg+25nOqWaSoF6x1ZlAmzvAQDp?=
 =?us-ascii?Q?OneMnPDOSKtzr8jmxEjMgNFVRNGFlknaQ2wsxFBX0XVA+2WvzBhVueiRJQuv?=
 =?us-ascii?Q?JIG4NFGcIVdV0X8b+K7hK0Bixo8XOtCDSMilS43xWaQcrSlkqmJtlRE4NKTN?=
 =?us-ascii?Q?mmhyor9BT8vaMCdUAMiwAGKsDuC0hnTmRIX2oY402IOaxfdwPNVX8lLp1beP?=
 =?us-ascii?Q?oFk7KWucj9P3On+dB6bwIpsobnuJGpLx4p7k6WzVs58f1CSJ4lI5KCOagu0b?=
 =?us-ascii?Q?NJATyKY1E6IcAMkhce8+UfOHRyOzipjJeA07yyjRSeSpg1w6H1+O/KNSXvcs?=
 =?us-ascii?Q?U2ptpsGZHE91SmZzESToWNZLDuwdQUl8bkDGBtDJFxv6sD+vc6Qo4T+3dAH+?=
 =?us-ascii?Q?M8gjIq/3AD/Ltbth9h/vbbuOJJ4aVVY9bGaTN1ZizaPVJ+FfvzDzE14qfbmD?=
 =?us-ascii?Q?FpgeMxTQWs4RNdgPyADTh7WRNKm14P9C0ZDYEY0LiFNlHX+Sz8wEArgc4auF?=
 =?us-ascii?Q?J5D6wMOCGI0AzA275yJp1bh1HPFPxYBGor3Yp64mW3xGbVAdITSMZ8Az3/L/?=
 =?us-ascii?Q?qYOpMXtV2SIWl28XFeUQLesG4E+00HJCm5r6G23CnITKJFdJBSkeV8tYmmDZ?=
 =?us-ascii?Q?tzMuqNM+kZ8L4E/5FYSh7gJuypJO5VHEaEwMj6z1ORPaEBcG4oi6SjZXdeam?=
 =?us-ascii?Q?gWnu+CXXj1SQZk6mv/6o3/xHZ5RFf2H047xpJTw3sspTHMYxDPB+yQVo1c/w?=
 =?us-ascii?Q?0C1ejrHkiI+fAE4iZm4N05ikyKAvjMzUCMEL8ctX42Y0Gj6AdVjs1++2tlOi?=
 =?us-ascii?Q?vDqM/Ki36VqJUWDDoh9eSGdMNoDeNMCgY/hCE196ZCr5gZPOQ1x3EN1p0hF4?=
 =?us-ascii?Q?yL4P62/cY61H2j5NqwM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8b9c5a-32df-429e-2e93-08ddfce8c8ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 10:38:08.7487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CixHdhSrU5J6txXl9+CHJEW0VZs3orz6m2qb+yVLpr5EHyVSQAHH/1PJOl5PIdskQ5FbTa095NjttMUG+XuzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204

[Public]

Hi,

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Thursday, September 25, 2025 8:39 PM
> To: Arnd Bergmann <arnd@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>; Jorge Marques
> <jorge.marques@analog.com>; Wolfram Sang <wsa+renesas@sang-
> engineering.com>; Arnd Bergmann <arnd@arndb.de>; Guntupalli, Manikanta
> <manikanta.guntupalli@amd.com>; linux-i3c@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
>
> On Wed, Sep 24, 2025 at 10:18:33PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Short MMIO transfers that are not a multiple of four bytes in size
> > need a special case for the final bytes, however the existing
> > implementation is not endian-safe and introduces an incorrect byteswap
> > on big-endian kernels.
> >
> > This usually does not cause problems because most systems are
> > little-endian and most transfers are multiple of four bytes long, but
> > still needs to be fixed to avoid the extra byteswap.
> >
> > Change the special case for both i3c_writel_fifo() and
> > i3c_readl_fifo() to use non-byteswapping writesl() and readsl() with a
> > single element instead of the byteswapping writel()/readl() that are
> > meant for individual MMIO registers. As data is copied between a FIFO
> > and a memory buffer, the writesl()/readsl() loops are typically based
> > on __raw_readl()/ __raw_writel(), resulting in the order of bytes in
> > the FIFO to match the order in the buffer, regardless of the CPU endian=
ess.
> >
> > The earlier versions in the dw-i3c and i3c-master-cdns had a correct
> > implementation, but the generic version that was recently added broke i=
t.
> >
> > Fixes: 733b439375b4 ("i3c: master: Add inline i3c_readl_fifo() and
> > i3c_writel_fifo()")
> > Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > This was a recent regression, the version in 6.16 still works, but
> > 6.17-rc is broken.
> >
> > v2 changes:
> >  - add code comments
> >  - write correct data buffer
> > ---
> >  drivers/i3c/internals.h | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h index
> > 0d857cc68cc5..79ceaa5f5afd 100644
> > --- a/drivers/i3c/internals.h
> > +++ b/drivers/i3c/internals.h
> > @@ -38,7 +38,11 @@ static inline void i3c_writel_fifo(void __iomem *add=
r, const
> void *buf,
> >             u32 tmp =3D 0;
> >
> >             memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> > -           writel(tmp, addr);
> > +           /*
> > +            * writesl() instead of writel() to keep FIFO
> > +            * byteorder on big-endian targets
> > +            */
>
> endian look like how CPU decode byte order to MSB to LSB.
> targets FIFO define look like
>
> BIT 31..24   23..16     15..8     7..0
>     B3        B2         B1       B0
>
> regardless CPU is big endian or little endian system, data in memory shou=
ld be
>
> 0x000 B0
> 0x004 B1
> 0x008 B2
> 0x00c B3
>
> I think your sentence in commit message is better
>
> /* writesl() instead of writel() to keep FIFO byte orderer to match the o=
rder in the
> buffer regardless of the CPU endianess.
> */
>
> Frank
> > +           writesl(addr, &tmp, 1);
> >     }
> >  }
> >
> > @@ -55,7 +59,11 @@ static inline void i3c_readl_fifo(const void __iomem=
 *addr,
> void *buf,
> >     if (nbytes & 3) {
> >             u32 tmp;
> >
> > -           tmp =3D readl(addr);
> > +           /*
> > +            * readsl() instead of readl() to keep FIFO
> > +            * byteorder on big-endian targets
> > +            */
> > +           readsl(addr, &tmp, 1);
> >             memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
> >     }
> >  }
> > --
> > 2.39.5
> >
> >
> > --
> > linux-i3c mailing list
> > linux-i3c@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-i3c

We will include this patch as part of "[PATCH V8 0/5] Add AMD I3C master co=
ntroller driver and bindings", since the patch series depends on it.

Thanks,
Manikanta.

