Return-Path: <linux-kernel+bounces-828014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA19B93B08
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E6B7A4166
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7230719DFA2;
	Tue, 23 Sep 2025 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="ivaiLEeg"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022113.outbound.protection.outlook.com [52.101.126.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8213595C;
	Tue, 23 Sep 2025 00:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587335; cv=fail; b=RHhPZepmzJKBieLWee3NSvqrvhngzQufJQ2mxSpUv7IvGChtdZYAMdnV4qV81pV4VJwi3JF+R7V7M4e4TjIx1ORy/p4Sv0EeprInrdE1qUiRgn44nMjJJwcKzpU8xTeA8m9HGWXDxndvph3CRRILcwtwcCQGddXpqdxdkqY5X/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587335; c=relaxed/simple;
	bh=tKzv8jri+29enRQBBgeVcHnyQBgTreBX6t/YHvTlaMo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XRc/UlIjiCVyXGSslqfN2fyAA828lPE0BPiFnokacCVElALGgvz7CoQE8uqr+akHU1hk3VR1KG/LX6AxegtHuynoH10EWoFIwEtVZosMSqgsapkduJzv5fVKUIvGGbLet9Pfp5O8hzyEXRbvnVtfxdFgQ1TxRvjJcMSbJ9/RJsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=ivaiLEeg; arc=fail smtp.client-ip=52.101.126.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1iEuJUiVGav3U07P0iYR6Vp3lMmK4eYWKWbfpmP6tK72zl7HG4uk6+GBCHKZwxtevXSd5ciHnj9UVpU+SG2nmBTnAeN18ox0Ludw2k0xAZmkx6TOO7IJrUe6Yd4Xg0iBKrbbS4tazb2DKyEKn1MRVk5RpFbJFYnGLwYAjCMNgCrSzxlziH1hCvzusuzLKaizutYB5qNeXTE8w+QrGzW3Q7cgPvd6GL0OzkikniGn5WQceCP8YxzMvNa7Bgpr17p9eQdlB53t41FgsqYv9JajU6s4hR76Z3q4DjPyKnxnJ4z/g3AErsd/2j9nmPoFQ2S/eY1B3mmuEEFv0fOEGIqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkfAxUzWzRjxlUd+vpJZ2Pezm0JHHt1Ly89V+DfSzFI=;
 b=TkQD2Ws9Q7wH3BnFjl8FEndSbFv6aUoYDgtDLwMhcQUnvmM8coMUrexgIU55u8IOFdshTy3ONMd0EYyINEPXpiOQQ3L3+KY0oe1TPyzcOUUIxpUg2+asVlvRBvo3kTBTL804a5z4SsLj3aMS5UwrUtA7e9CK/PjJniuhJEbkFwVThzQw7D+7FqslF2gfeVII4agLvpCq5ClsOrAzhXi4wa4zUotL2PX8cTcMU9AN3OvO9o0Bl4ufawSa/YUm21YJEm6k9HGVco9oOUjy/D9fb8xOq6X7B9qdW2npPCjHT3F5tTx/sw/l6O1rDGl2zXo38lHplU1X8Czcr3fYuTrejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkfAxUzWzRjxlUd+vpJZ2Pezm0JHHt1Ly89V+DfSzFI=;
 b=ivaiLEeg+4fU83FhVHJK1pWT1IIYm2AGqDNbeMJQUkgMzLsi/XnVI7fmy5oqFmmII8bf/Qc9FRu833BXVC3gzb3s4YmtdjV9oa29OGheLebq40RMislKRJMrvlzKtTUWBg4dNqBaB/EGaU7PCeJW9m3AvO4SpEt5bjOphgNFHCuEFoSCytURcn/AIcFD8SESgnVhNHPi0MK3ncSdoiYcmGCTX2mAPnUsOn8Xdg6GJYIw7zw3iKQkO6jYf3D7pYxnNGJFt2V+wxDcP+oTEDJOFA7TBpgzKxTkvFbQFvplBm9SM6Zz6kdbqXkzedkpwlNEdccNKhc8SwaDpdvtHCNbNQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by KL1PR0601MB5581.apcprd06.prod.outlook.com (2603:1096:820:c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 00:28:49 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 00:28:48 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/4] Add Aspeed AST2700 uhci support
Thread-Topic: [PATCH v4 0/4] Add Aspeed AST2700 uhci support
Thread-Index: AQHcK4Co88Hg5mWnq0OFcsMUJ0rkkbSfOuCAgACvorA=
Date: Tue, 23 Sep 2025 00:28:48 +0000
Message-ID:
 <OS8PR06MB7541BE1844B1A3B5709E6E7FF21DA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250922052045.2421480-1-ryan_chen@aspeedtech.com>
 <67259dbb-4586-4099-9762-5c1d143db7db@rowland.harvard.edu>
In-Reply-To: <67259dbb-4586-4099-9762-5c1d143db7db@rowland.harvard.edu>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|KL1PR0601MB5581:EE_
x-ms-office365-filtering-correlation-id: 6db5cb18-546d-49ee-2706-08ddfa3829b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7gHveYULrc5Uc7Y7H8hR6M4QQMibCOrWM5cYXgFYopQlZeKuufyKdVBrPIOo?=
 =?us-ascii?Q?PU7qxEP82hND9m8BS2eqVY49CPrfUdRY+joKLJsbdzu9H99bDQQNRGYrG4rS?=
 =?us-ascii?Q?WtUT6QI/XaaxTKihazYfqtG45tEeM+zeG5JSBZCeQBZDQg/Tsb78x3S5M3o9?=
 =?us-ascii?Q?xn1StumRy5vrfogiyPmpXqyJXmIWsEZnIO7R249id2hhEeqA9lXDaIn/m8An?=
 =?us-ascii?Q?LLyG/4aJShmvwbmUDi/ZoaKQrFByhOTWJog6NNZrOGGhgrAYLwaD40Tvbh6A?=
 =?us-ascii?Q?nktJA0hyQlnwTYYNGilFJ+IhoTQAFOoKLr+A07LdowmUvT1R/pC22QyFDUMM?=
 =?us-ascii?Q?yc+Bh4NxQDgAOB3GtswyE+V9QQxCdSLP9FvD1/0t8V/LQJSL0Se62H5ipoEC?=
 =?us-ascii?Q?iIskDtJGpgUwdjN1xZWb6rMgtCGC9YV+ws8ye16XgOeOzLrJ+f1SlzftpTIE?=
 =?us-ascii?Q?i26wGFs/XioiDd1O3uWOUtmc1e/VdNDPG5K+kDMrGMKFM7pdhTqwfaiAHxoo?=
 =?us-ascii?Q?J6G+66QuG8esnLsUqAw+ZcNMPQb/q8BFW2SfYBLSZWOjR3EljG9qMhVFS3d8?=
 =?us-ascii?Q?ZEHsHcHqKUc/a11vZ67ldEIUHZZVMQxanHruK0Wqu4upDHAu5e2KEYS1fgpf?=
 =?us-ascii?Q?UHH3UK4LXGxs3ynQgfocWQ3obiLpmhLrquYZOuyNhx+pF8LVDAelLQeOUhQH?=
 =?us-ascii?Q?rvPJHJBbxOoK1frXI/feAOpy4kb0/vQav/64fDqzP9gixS1RsNvBGNVLFGZ+?=
 =?us-ascii?Q?RU6s7E8Utx/fyaTeL6PqXGf5rnzGxtKqorQJ7afSjp4ExRg9Gr0mqMQH3I1t?=
 =?us-ascii?Q?HMRQAhP14ehL5gqiX+Apqr944pwO+cjSW1vhHFLyKO2baCcNw4VI6DfukcI4?=
 =?us-ascii?Q?HhtMnaXWezY3+PqLQuGPq+glhdirlHgn/tsDpjNE7jiKD5V/wgQCjE8IN+6b?=
 =?us-ascii?Q?35fA4h6RCcxg1M0MJV9CcEzjtDr6l4ludgGwrJ/veamvl0K5M6Tyb/kxHvhi?=
 =?us-ascii?Q?FyNJztFPhmIvFuxv8Dq+ohakwnuPij5IHW5dFVHtfRXUnMeDzohJFE/q/JgT?=
 =?us-ascii?Q?ssOkZMBIZlyb9zS+29uElPIriEKKronS3oQnStlWyMpHrm0wA64etYlIsyZl?=
 =?us-ascii?Q?wouYLFSgX2ziKThcvkypxjuEDY54WsV2nIsKL5+azY/n7kDIzMNxeqOrk6w2?=
 =?us-ascii?Q?PIspNFieRlLovSLIYTA7xcnq66VO9TsDtU3MQOL6m9j8lVTuEUTCg+yMsIVU?=
 =?us-ascii?Q?zodDV8qjluUbWZbIl6dPDhXpXvEqY7GZk9b7GzywUs/K5Qy5owZFJUtKm2vs?=
 =?us-ascii?Q?DRrSDcSB/3p2M11YiLGTA1weths2uQ5ky26dEWw4T7VrY8RTlT/sVoWPzUz4?=
 =?us-ascii?Q?cuZFGjF+SWkchiI/pjrKQI6ycl4i8iQh+2ERwFNjoyuFhvyZnlvPIMmjdJNS?=
 =?us-ascii?Q?q9tki2tR9gTRURlFuruvqY9h/NdlmgI3Rm4aAh2pjsDncS8Z3osNz9i9QWGF?=
 =?us-ascii?Q?jePUA+RWKHWtLPc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BKnoZn6nDrZZBW30dxCm6ZIpSS7ixGCgiFiHjcaiZSoWmTXZ7SRUR4ZDjzff?=
 =?us-ascii?Q?fn/LVsdU5sBTBdlrK7L2f/4aj565yAqJU+zuQgsKHQodFvGTxpWjLTl3J7WJ?=
 =?us-ascii?Q?JVZyrU0SLxxXQmHPW2oNMORmAcso6akVPPziu132pVYTfLD0GAFPovInQKuV?=
 =?us-ascii?Q?myJtMkHtD1Wg3wnFK2deWMCKzlPhbfUL5pV58UOoRed03mjLTRHEi1iSqG8N?=
 =?us-ascii?Q?WXE40foHJGlC+Jbm+nnY4Zz1lbg3VWUgerlsqP0yHqzqtcAblIqTB2Gn7Bff?=
 =?us-ascii?Q?TR+tKkqUgJYNE1L/vQf1Nkr5zl8jA1Ek7mj9CfhYEBM9VrCQY2pyH79PuM3w?=
 =?us-ascii?Q?vCSE3j9ozJl+YOI+7memwI7ITvtDkXJLvogkP6UMCmrdI/S3+Lz1x/DzNbWD?=
 =?us-ascii?Q?OSQyqIaSDlIA45SoYvZo3t1PEjx47vO/359yDu1iT057cNCmPxiP+lJQIv4k?=
 =?us-ascii?Q?lmN123EwuaPBxTbncfmNqFuxRy4Z4iQmo7TwOspKfWa6v8qDU6IA/ff2iPCl?=
 =?us-ascii?Q?34NInFdz6GCtgZgxYjIq29hk21kpNP0payEzPawXDKASLcY19Gx9e9a3XUTI?=
 =?us-ascii?Q?5qa6Gh6l1U3zkP3XzP0BHpOitMldzdIsi9vlSGq8hn/JlC0GOeB0a38M79il?=
 =?us-ascii?Q?jHwRZsxINwBNxxP5XUZj0ZZBvKQi3uyR/ndFCKSP+o3CGJCm0n6iN03fYZtN?=
 =?us-ascii?Q?EJkzZAi08xjAt2J/huJj2WvFpzyTNv+3X/fhUwTYyGWu9ARquSljzGR8HIWg?=
 =?us-ascii?Q?3fMSOhE65p5EfAvKS1qMUpGupdoYCCRIVAa1OrvqA2EwqTuec+OjWvH0RuUX?=
 =?us-ascii?Q?yZAbP5shmKowcpA9RPWUEGjvy4oK+lJpX5SAipSwkGkrN2YQnyMA3+iw7rmV?=
 =?us-ascii?Q?uapRwPBM2BEfA/79sZV31zp7WRMg3ypEFGInG75xnQ4GG80p44cPq4WoOVUT?=
 =?us-ascii?Q?+eOuPJkxOFG2Yt9YvJ8zzPpsOBrzd6haBLyjRqVGTIr1zRuOQHaKz5XsaWQP?=
 =?us-ascii?Q?Kt0mBFjwCyRYmjdAcSSh6CT0mym9NB1Gzgfogu3YwrMqAQ+b0R8Q8UgkDhXT?=
 =?us-ascii?Q?W6tHkTiyI6FJ9Fm+Zyl0QVJnZhk7Y7quzs54xSgSFqM/m9vXqr4nxryhpiM2?=
 =?us-ascii?Q?t6Tg6QxrkxdBkrxhvKx8SZi3TsDyrDDxdi6uQeurM9KDIzZ57qQ2z76O6Ys2?=
 =?us-ascii?Q?MGEHt+gZffdtnXrm63Lhj0MQPmtXKbK0bEEBmDcDSqO6V7veG8ayIoignccE?=
 =?us-ascii?Q?u7zpuVUWY4slKR/tb8SthPxXdqOBm5P9TE+gTxKC/PxOSPoOcXWFHdAvhW/V?=
 =?us-ascii?Q?g9xb4EF+ePmXj5zoC9j8aO22UtHKTUyNR4KRD2sJMoJgBaWaSGu9ahdGocvB?=
 =?us-ascii?Q?JI7TbAvYUk4ILr1f5/tV/O/4myFcrc6+zXI4ce+5mlHA3bMDF0VMcOqXQT5/?=
 =?us-ascii?Q?RYNfl1t3pdoOaSGS66Hl3WqNSH93hO0kfYNNQwK+xNVIYqU+JLLHPO7bfzC5?=
 =?us-ascii?Q?mUKj9LA5foHRee4fl18kJ5SYTMuVGIzGINOOrrCiqNlVfVSPIg3bwt4a2LLM?=
 =?us-ascii?Q?Qu66q+y8A26Bb1usKyX/ljzKj919CaUKAozr+HGj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db5cb18-546d-49ee-2706-08ddfa3829b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 00:28:48.1219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHE85SnJfEOD5BL3Bqldyc4/UWvEZ11zXtiLEfWse2diiodVJKerfaDB0ic3fN8qKgDzKHAPEeJY70gFasJsrmYh41vA3nitkkJYJm7KWKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5581

> Subject: Re: [PATCH v4 0/4] Add Aspeed AST2700 uhci support
>=20
> On Mon, Sep 22, 2025 at 01:20:41PM +0800, Ryan Chen wrote:
> > This patch series adds support for the UHCI controller found on the
> > Aspeed AST2700 SoC.
> >
> > Compared to earlier SoCs (AST2400/2500/2600), AST2700 UHCI:
> >  - requires a reset line to be deasserted before use
> >  - supports 64-bit DMA addressing
> >
> > This series updates the bindings and platform driver accordingly.
>=20
> For patches 2/4 and 4/4:
>=20
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
>=20
> Alan Stern

Thanks your review, I am wondering about the progress,
should I submit a patch for patches 2/4, 4/4 with your reviewed-by?=20
Or just leave it?

Ryan

>=20
> > v4:
> > - usb-uhci.yaml
> >  - fix errors 'make dt_binding_check'
> > - uhci-platform.c
> >  - remove IS_ERR_OR_NULL(uhci->rsts) check, due to reset_control_assert
> >    will return 0, when uhci->rsts is null.
> >  - use dma_mask_32 as default, and just add aspeed,ast2700-uhci for
> dma_64.
> >
> > v3:
> > - uhci-platform.c
> >  - add reset_control_assert in uhci_hcd_platform_remove.
> >
> > v2:
> > - usb-uhci.yaml
> >  - add required resets for aspeed,ast2700-uhci
> > - uhci-platform.c
> >  - change the err_clk before err_reset.
> >
> > Ryan Chen (4):
> >   dt-bindings: usb: uhci: Add reset property
> >   usb: uhci: Add reset control support
> >   dt-bindings: usb: uhci: Add Aspeed AST2700 compatible
> >   usb: uhci: Add Aspeed AST2700 support
> >
> >  .../devicetree/bindings/usb/usb-uhci.yaml     | 13 ++++++++
> >  drivers/usb/host/uhci-hcd.h                   |  1 +
> >  drivers/usb/host/uhci-platform.c              | 31
> ++++++++++++++++---
> >  3 files changed, 41 insertions(+), 4 deletions(-)
> >
> > --
> > 2.34.1
> >

