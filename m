Return-Path: <linux-kernel+bounces-844582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF2CBC243C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 463EA4E7B85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAFA2E8B67;
	Tue,  7 Oct 2025 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pico.net header.i=@pico.net header.b="O5CbLNCE"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021114.outbound.protection.outlook.com [40.93.194.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE13813FEE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858685; cv=fail; b=F1SOL9A4fEFAYxKEjMwYAVfoHO9g8aj5TF0c5DO9l/pmYLAiTI+kpRcNQnSEyIfePZfW5DQbIuTGkoBk984bT6sDbmafluwyIY2QFb3UxIvQL6IoyCM8M5rq7f+Oddmo7s5uWlTZHh1lrI+6JroBRNnPZWo3ccZrx/uqDTnVAEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858685; c=relaxed/simple;
	bh=OynQY1wAusnccnT3GCdHD8EKi8fnpmAzy9kTW3ocaRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tpCODxC+MO/kjuFzvPiKJZlzCRUTbsyCO7YQLOhp+rDp0cASVtaDlRENO1d/PJOAsvHNksAlNabvcFmMoZUw96SoqvsdbIXFjkWjG9VYV0xstcDpdPmVnSfG2Rn3n4+4G2mMo/FYmIT1XhAqsi6mLkLsgMELY/u7rIWIReGrEtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pico.net; spf=pass smtp.mailfrom=pico.net; dkim=pass (2048-bit key) header.d=pico.net header.i=@pico.net header.b=O5CbLNCE; arc=fail smtp.client-ip=40.93.194.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pico.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pico.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSmt0A/1QbC5bq4uJSVIMlzHatk+f8LqNlqi6qgO8i4K08SB2MSAPqF8wHmj8oP/N9PPOUQPubjurqyFV0wL7695x9LNWybVFcOPFfX8rjGM1XOIB9dbaLgQrN2G8XU79x8R4n76ZoQrNKzxm5yjZtiJeTMzOtRE/xxssw/ika9UGR7Pn/oX/cxYHdPl/3lJCtHPNopukc8mXMiUEArjWBC2wj58cDu7EL19kWQ7DjojQaFJQ+mZOkzvpiGlvNW0RdFrMbVBHMttz5OtoF7E4iXEuCpLH9X0Ch6maF1hXM/tRPRt5STHM1q2V52fXwOuH5JC/l39+4dt9ve+9+ANvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OynQY1wAusnccnT3GCdHD8EKi8fnpmAzy9kTW3ocaRM=;
 b=UhDGXn0EN+7397YVo0rRIeSuAFpWE9tIXaTlbw6qYe6YquX0k3H/qGWEeAgcanheIo8eLyP6TivuSuLTuVktPbmeM+1VJz5PyTBy5kDIeld9FRtSt88nctU/+ZGRKtLpj5GJPQ/+4gsXgjLf5cLR75k3D1SPPe0PJRU3O5Ba0MzLWgVgg2kycn7L36J8Wj4y9vrfY6dJn+EpqtFnvMfNoPx4YQDEhdqok91AB4/3Oc+nNUqRyK9j3X3yj+yZYoWcGopub7T48F0ikkxQ4wNXVclSXtxmv+RuBFr0N6vVh0yDc05t0m+2ucSvK77BoNL855xpPCP0lUaJCANWSdH3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pico.net; dmarc=pass action=none header.from=pico.net;
 dkim=pass header.d=pico.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pico.net; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OynQY1wAusnccnT3GCdHD8EKi8fnpmAzy9kTW3ocaRM=;
 b=O5CbLNCEtbWqu6IFXKKIFvXDm4+9zZXZQrYI85Ee054rfxy7eRwEqAiewwAExiuXobvkgUPbJruQlpKUENaFn8j677hmOKQ/bk/5pMAI7AdUyyCCxhCuTeDYUjiZlw3qdtG2SPMwuj5c2XODswYDuypj2B8+PfSNjP7O49M5CLzIC8t03eSw6zwQhCX6Ye8tAIaEEEkooQFL8kURpJeCehbIM6iqk9KNpk23IMIewgN6iMXxHyrR3kzjwvr6Obq8CLLAxMIBsTnJ6JPzzHBocpboIlIKsiM13ESy7Y24hqAfERpHUiluK32PC+ujm7776fTG8GEfrK1YwzqKGu2igA==
Received: from IA2PR22MB5609.namprd22.prod.outlook.com (2603:10b6:208:4bb::5)
 by PH7PR22MB4382.namprd22.prod.outlook.com (2603:10b6:510:2e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 17:37:57 +0000
Received: from IA2PR22MB5609.namprd22.prod.outlook.com
 ([fe80::94ac:e1f6:1aa8:3c4e]) by IA2PR22MB5609.namprd22.prod.outlook.com
 ([fe80::94ac:e1f6:1aa8:3c4e%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 17:37:56 +0000
From: Filip Barczyk <filip.barczyk@pico.net>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "Mario Limonciello (AMD)
 (kernel.org)" <superm1@kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
Thread-Topic: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
Thread-Index: AQHcMintX0Ynf8ethU6MZXcy0IjNS7SsBeyAgAFJPwCACa6VUw==
Date: Tue, 7 Oct 2025 17:37:56 +0000
Message-ID:
 <IA2PR22MB5609866886BA191F64D5049D90E0A@IA2PR22MB5609.namprd22.prod.outlook.com>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
 <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>
 <94cd8a1f-1f2a-4cd6-8ab8-49b9d1e9fa2d@kernel.org>
 <20251001134612.GA738751@yaz-khff2.amd.com>
In-Reply-To: <20251001134612.GA738751@yaz-khff2.amd.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pico.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA2PR22MB5609:EE_|PH7PR22MB4382:EE_
x-ms-office365-filtering-correlation-id: 13b31117-913b-4710-38b9-08de05c84099
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?50C5DwUizW705M60JxBI44ZtDVjLFw5dzX/GvBHeDqawsK/ujPw33mUsIx?=
 =?iso-8859-1?Q?gDgbVvTYFphXIGYFVCeDJ0/0exCMqc71Sg3FaVjlv9UZzTlOVMTBBn0BJG?=
 =?iso-8859-1?Q?9T4N72ZKb0fl/HCUel1ESL0I+lD0hH2r1o2hUiM2YR0NQYynmwKIVkw2k8?=
 =?iso-8859-1?Q?mKmQ9x3TwwdbR+nIRohdQXttF/96jljiKQlscXdkbrxVYFUL7RRRyjMjjy?=
 =?iso-8859-1?Q?Y5D3tfZe5vjq6bj+f8qhAd3U2RhGfu7Yjw1JPsYs8rN1fe+oerVCX2cqOJ?=
 =?iso-8859-1?Q?42EceYlrQK1h58Xj2y5RhWwKUqBVm8wcBcIaWTvZsbr5sK6YmjvdXb9u8f?=
 =?iso-8859-1?Q?XRHjjYTpIqVyVYQxkPjvFwmuK+HeB+q8BFAf2mf/ATd6dGtT4JIC5zUdL0?=
 =?iso-8859-1?Q?gjdtoj2LRQH0rXgVlDGFm+k+CT4MYMWkjguLFjwTY727p2D0uXx/S4Ieum?=
 =?iso-8859-1?Q?grBnRWhA0nQNwQMYg9+2GHN9mgyx9vl21A6iflF4JUde8PBsBV0i53Fukb?=
 =?iso-8859-1?Q?r2yHFbgHEVwPPYb2vCmhtG/tqrLERsegCejlZX7LxGmFLrDbh8XQfOmd+3?=
 =?iso-8859-1?Q?DhgO7zKpj6lKbHlM3EFCOH9L0QzFAtPI0Gz2Fxl83nUb+Yw0SnMEigAKzc?=
 =?iso-8859-1?Q?p3I/alfzSBQGlTOhEsVX0foF1MWMZwDzmxB3frrVlFKk+XYKq6ZupqRwcX?=
 =?iso-8859-1?Q?cSpb2GWGyuKDi2/ui4yL+7DQks0Xl7KtEZwiFcKDnmOb1utf8Mm3ayudez?=
 =?iso-8859-1?Q?Nduwjt3JJdUvYUMgcoDQcKpRhuVLnLGymKJ32N18/+73q/EIOju8oolyEi?=
 =?iso-8859-1?Q?X1dC2O5ejUWpho1TXC8YGVqV+MB/qpB517RplfXlmQMo2/bFUemMnVTyBS?=
 =?iso-8859-1?Q?3C9DJaPPc4/67pOxPkziYf7EttYbb/88tT5IWIthwDT69K3a1rkHRZKhLf?=
 =?iso-8859-1?Q?/sW7em9JavE4MTY6fXXEYURUn9D8WuVbVviwpT51Q0zifpKsg3PTfiKUzK?=
 =?iso-8859-1?Q?QmOicK7dzjdrjWLojDISAR/dlGoLnN/bJrJMwMdSs1452dm3ZhEfYD4chP?=
 =?iso-8859-1?Q?nz0yPkoK/uafWS+Ex42aRuBya5AB2YpasIRt1LnVXmqkThBsSDuwEBfdfU?=
 =?iso-8859-1?Q?KaTU6KzfAcIY3aVeXY9aNxTKnNE8bdlRdKEYh224ZVusbqJEnRoATC4U7n?=
 =?iso-8859-1?Q?ecJgYFwcrfI1UzONb7iC0snnjs14C88J5L3THCIhE6PeXbnkmKrLDEk54s?=
 =?iso-8859-1?Q?lZLG0pdLCUf15FT/KhOTb0N6Mb/a4OPXTJJrf1U+qtz4G8XvBWrK6Uer4I?=
 =?iso-8859-1?Q?+DtSq3PaI3jDqwZvHIAbFImaBX1fEQ4rcpjUxK6jLWQgwPqU7EKOl1jirb?=
 =?iso-8859-1?Q?QsvjKJeXOyL5sT1uVgD9Wef14f6WLKTRkx5ojmDUP9bhcmVg18sh9kTgc5?=
 =?iso-8859-1?Q?n7vOoqZG9Lm4Yn2PhvCTS1GnDvutmmbBVrmOFhXQAO2EQeEY5aaS0BcvSA?=
 =?iso-8859-1?Q?mIEZZJ8HPM9gKc2I0dvEebaLj/iIF87kaRIc6iQyh9OzYqt+4yxKGSMKn4?=
 =?iso-8859-1?Q?aMmfnvbuCCEEGsPIo2E5gctlnY8l?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA2PR22MB5609.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tm5iWM7NCnxyKiblD8R23ehuZbMOtquxsVjDiwu6F6N9FYVQQBIQkEWrTS?=
 =?iso-8859-1?Q?m6xUoknPmvqHeDIGFG69PjlZIZS9RjPELxQv/zpWNx+QGtBhZcsdcfJ17+?=
 =?iso-8859-1?Q?a6TChOG+HqU7w5Jn3tZkY3JMZ9gt5mGhbhDrlSrIrn8fyNtl+kbRpShucL?=
 =?iso-8859-1?Q?2/d5e9UOG+L5l92P7iII1M6cj3eZBrxvcJEyU6khglJhiS0qrLgI12YHah?=
 =?iso-8859-1?Q?3/Fq39699G0anabdXR5NnP7RCjon2DD29sLYh3EMVIsRCpkK1LyH8QgAi0?=
 =?iso-8859-1?Q?8ECdRYrhBBVksXdoftQ3i3lqMwAL/18e9qCtUUQuMrPC+OAhHQFZX9QdXx?=
 =?iso-8859-1?Q?14TOhl0BceP4HCu56tkqEYfli+GuYb03XDAxHw8iGxVLOZKIgEkwDfxOzL?=
 =?iso-8859-1?Q?Zg7aBuNk6MTZuCwOVuzhguYnonOoN4OOlkskw7shAwQyzglLisA33kIv69?=
 =?iso-8859-1?Q?SEF5iGBrvLazK9kc/nXbsfB0koG6M/jZUSxRWXIXkt2+53g4ow+LU0tRHu?=
 =?iso-8859-1?Q?kCgDJWIiuZryu6A5a7WZe7VrHJCCQiujGcKYKBf3gRHkXOCobOfOPlnbtC?=
 =?iso-8859-1?Q?NKHAAPvEi4CTTDVaShbfxcdMHzJoPXbcRbm1MbMho8/0/fcQnh8AHhrRhK?=
 =?iso-8859-1?Q?u4qdJ/YlxrS5hgyJ4yd68ixSmcwCboEJFkXrllHdAmf8VsW5ZupzoutB35?=
 =?iso-8859-1?Q?GkzZS35eYLCZaXUn8H7bzDP/TqLyd+PW0kGACDbzJ5lhIglzCo5pOimLtC?=
 =?iso-8859-1?Q?Tt3xlfOI4dMN5XcIeG6nmLd1AChsvPrOZg7TXV312zrdiTSGMVAAqpfcCA?=
 =?iso-8859-1?Q?/tTK4mjjFlSHdxLtlmcwGDiclvTffKs4niIQTNiOASRWeSB/D72Ss4FZx9?=
 =?iso-8859-1?Q?7OxaBFD5F6S1gXxwKMJtFelBazslNsIvt99kAET4E9AJXRIi0J5OuDgePS?=
 =?iso-8859-1?Q?ucF+6DBf1GdWjWGP7Do/gBxuu2kI+0hADfx2Xo9Nh32j5L7QpyKwjxhZVX?=
 =?iso-8859-1?Q?6VU4VGbUxjhUAfxP1wNeR3TpQFmXgStsmNDyKJI03LzXzIO23QRx7dIjdx?=
 =?iso-8859-1?Q?LFsxf1EAaJH/FhXnV+fUc2+LAoVG4wst8/iV6pAwkrpWG/PqynzdwcWOxT?=
 =?iso-8859-1?Q?QOWPuwO7JFx3WeLeibF4k9uYWm0txH/vK5shzpzy69YTmd67B7pXBnEQCY?=
 =?iso-8859-1?Q?fiMfnGdaOpzHihon43i1qH9ioC4np+nVdAnTDu90lB0/cuBN63KT173Ga6?=
 =?iso-8859-1?Q?m0M+kLFFD1uyqgOlZP/jXnJ33tIyhxLFA+YA2QG4tCHxTrHhLHqxJGxXiE?=
 =?iso-8859-1?Q?4zneTWwOYMCKE8nMZIJUSwtYcTC3f8FQmJ41gkkaIsNnem0f9BhnUeuhBz?=
 =?iso-8859-1?Q?I6FnPvjl/7xATg0NyUmidCUy3L24Unin41+VBc6pO9mwsCsBOiWQ3uYLCh?=
 =?iso-8859-1?Q?G9T6lLWkKlCtA7Jfkf0HP0034Y07LczQcAb5mEJDJVftjQuf03RsaI+BZ8?=
 =?iso-8859-1?Q?aGcqDMOfyFQ7cVJigawOddrLqCeEl8gdx1BGdU1Tgowlbq00oa6v8xsah6?=
 =?iso-8859-1?Q?OzVZ+B5iyiu4xgZvF8bR5ArLCsCuMBMenc33TdQZ4YDhcgX7FAxMBGVvth?=
 =?iso-8859-1?Q?OVGjNfdQlZEiavyj5Y8ojbdleGwPIW5//hJ5eR9YhSfo0HgOhb6Q61ZQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: pico.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA2PR22MB5609.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b31117-913b-4710-38b9-08de05c84099
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 17:37:56.8079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a472a2bd-3702-45a8-8dea-b9e904aa059b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmR/hoqYC3VZYFP4qaxuLZv/XWn00UI4fdOGH5/WuiNGrAh1BiJngmXomSnnWLk8Z5LO0I6TLVYyVlFyhp7N8vmbVrC871JDBEKI3/6OI20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB4382
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: IA2PR22MB5609.namprd22.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 165.225.16.101
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-disclaimer-hash: bca61952c1a5fdf9848b2982c03a9501578b27bdd50184715eb45205411272b2
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: PH7PR22MB4382.namprd22.prod.outlook.com

On Tue, Oct 01, 2025 at 03:46 PM +0200, Yazen Ghannam wrote:
> On Tue, Sep 30, 2025 at 01:07:47PM -0500, Mario Limonciello (AMD) (kernel=
.org) wrote:
> >
> >
> > On 9/30/2025 11:45 AM, Yazen Ghannam wrote:
> > > Recent AMD node rework removed the "search and count" method of cachi=
ng
> > > AMD root devices. This depended on the value from a Data Fabric regis=
ter
> > > that was expected to hold the PCI bus of one of the root devices
> > > attached to that fabric.
> > >
> > > However, this expectation is incorrect. The register, when read from =
PCI
> > > config space, returns the bitwise-OR of the buses of all attached roo=
t
> > > devices.
> > >
> > > This behavior is benign on AMD reference design boards, since the bus
> > > numbers are aligned. This results in a bitwise-OR value matching one =
of
> > > the buses. For example, 0x00 | 0x40 | 0xA0 | 0xE0 =3D 0xE0.
> > >
> > > This behavior breaks on boards where the bus numbers are not exactly
> > > aligned. For example, 0x00 | 0x07 | 0xE0 | 0x15 =3D F.
> > >
> > > The bus numbering style in the reference boards is not a requirement.
> > > The numbering found in other boards is not incorrect. Therefore, the
> > > root device caching method needs to be adjusted.
> > >
> > > Go back to the "search and count" method used before the recent rewor=
k.
> > > Search for root devices using PCI class code rather than fixed PCI ID=
s.
> > >
> > > This keeps the goal of the rework (remove dependency on PCI IDs) whil=
e
> > > being able to support various board designs.
> > >
> > > Fixes: 40a5f6ffdfc8 ("x86/amd_nb: Simplify root device search")
> >
> > Was this a publicly reported failure?
> >
> > If so is there a link to LKML or a Bugzilla with the details of the fai=
lure
> > you can include here?
> >
> No, it was reported off-list.
> Thanks,
> Yazen

I confirm that an issue when EDAC fails to enumerate DIMMs on Dell PowerEdg=
e R7725, 2x EPYC 9475F @ kernel 6.14.3 is fixed with this patch.
Thanks,
Filip
________________________________
 Pico Quantitative Trading LLC ("PQT"). This e-mail (including any attachme=
nts) is intended only for use by the addressee(s) named above, and may cont=
ain confidential, proprietary or legally privileged information. If you are=
 not the intended recipient of this e-mail, any review, use, disclosure, di=
ssemination, distribution, printing or copying of this e-mail or any attach=
ment is strictly prohibited. If you have received this e-mail in error, ple=
ase notify Pico immediately by return e-mail and permanently delete the ori=
ginal from your system and any hard copy printout thereof. E-mails are not =
encrypted and cannot be guaranteed to be secure or error-free and, as with =
all Internet communications, information could be intercepted, corrupted, l=
ost, destroyed, arrive late or incomplete, or contain viruses. Accordingly,=
 Pico accepts no liability for any errors or omissions in the content conta=
ined herein. In compliance with applicable laws, rules and regulations and/=
or at its discretion, Pico may review and archive incoming and outgoing e-m=
ail communications, copies of which may be produced at the request of regul=
ators.

