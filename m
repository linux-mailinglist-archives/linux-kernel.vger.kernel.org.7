Return-Path: <linux-kernel+bounces-826529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68905B8EBB0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4397018961E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EDB2ED842;
	Mon, 22 Sep 2025 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="QXrN0V32"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022084.outbound.protection.outlook.com [40.107.75.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EA017993;
	Mon, 22 Sep 2025 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758506628; cv=fail; b=d99PHsbSTjHDBVky00iJrsLb6NZthDMbdin9pZatwly7Eb8eafSTXzN+3HM/Wn1Yh4os0tsTo5ZWsPWAHBCKPvyRMFpYs24bRUTuUFSxmUtX7xLXgISs5DA7bMhyAdPE6FZu1vDlsfwpk4qf57d1NFQS7ZhBf0DrG5OhMOTjE88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758506628; c=relaxed/simple;
	bh=cxkv9ZOKfArxvTgOpbyU/ggPUfLfYZoSdwX2JVeEO9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QaecmgTQfI4UAuEeRYhNFw4Vi3RAgMEfIGLy+JmXR9e5aCWRnqrVTKYhw/mcrJxJd/LquanDL8/7+t4CpxP1Hc8Ky+f8ANjoRMoLiSTfwigp7UvDYweIQGeK2inSXNS01WUdy6JAp0mV3tqF+xDA/1C96hVac+8pvtB5Z9dUuwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=QXrN0V32; arc=fail smtp.client-ip=40.107.75.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSCXQ8PC+2HvZjOjK1I83sdgDDcDW6+RGi8OH9KLC7+T6YGYykFKUPivx/17VRQ9pDUWSRkbpihU6VSkJsuRWK9FtcmYEVLL46d7KFFwujMLB4PaSD1Kv6j6HRcTxmlLFbhodi7VIl/Ojb7t2mcPcRLexQF+b0iq7nmWcVh3JZUi+BT8ZTaiqliGqGAt06RFMPu65wUHJToy12yQoa0c2wXTscTwf8Bwqs/N6NzBbaHwgbi7bU5HzifYUM35lwaaXYeywPE/IJtlWH31tV8Dwb3RUlxlLIriYPqLn1vKFjr+JcVH5Ol89/6kSsp9WhM6HzkXn48jA6iIW1T9RgvtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUwI60KdGI6O5XTc0oQBArY3uUU5h6uP9agX4s5UqLM=;
 b=GNLQ4FJLb3xWXFDqa0uQS/EjMmoJFxDkiUvxo0vBliR462EejXXvQF5hWtNpwR6zf5gt1IU47wqVt356vrZFk/VAJhmzkyV5N+0dbCrC6DyREVJ/PDDfxQhPRhT3KLMcFCLRaENwK2y3aA9NudoE3O4JeX6XVHMlfQT3bcr/0v6HlvRRjgz4BevQrXG1Im1fhFgM9jTCcj/Vmi/gqHff1LbuCgCwguy6WE7NRphUKWpS5UBuCT7olQwBhjx9IEXGbb8EOWF3FRUO6VX2uVsTjludYIAdDmccluslBJ7S6EorhHWMGJt13eh4N9fJPC83qtP3sTGBB96i1Mj2lQB1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUwI60KdGI6O5XTc0oQBArY3uUU5h6uP9agX4s5UqLM=;
 b=QXrN0V32OXE2vt0lskDgZJYGOAx36M52yorP4lsJziImgQKmgqI1N9qerGWFFkHj/6qDxnAUt44ZS31leOa/2qq47+jTRx8wf9yANdRyYxDQYDn00EltpVjKSvozuRAJ8d0bDqNM3awN95s4buTQ0gp6DBNuNw2icGZoGtuDPjhSB+EEmnEOLTPn8QcK1Y6fMBvkG88daBfyRgEti7Wrgob0CihkpPJA9QmfFv9x/K2DiIo1bo9yg2KjtuFUHX6IFyJGwQdCU3lv48Ad3GS+ydY1EG4NJUWY6SIhgTRJ1TEmZ507WsFd6d8JJTX9HWXvjYseVkJlNYS7Lm1XuZgbIw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TY2PPFFD5F4C141.apcprd06.prod.outlook.com (2603:1096:408::7b3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Mon, 22 Sep
 2025 02:03:41 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 02:03:41 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] usb: uhci: Add reset control support
Thread-Topic: [PATCH v3 2/4] usb: uhci: Add reset control support
Thread-Index: AQHcKREd5VlUPj0h6Ey13T7T08axA7SamuyAgAJBwnCAAZodgA==
Date: Mon, 22 Sep 2025 02:03:40 +0000
Message-ID:
 <OS8PR06MB7541897BB2E71E8847B04C0CF212A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250919025712.719246-1-ryan_chen@aspeedtech.com>
 <20250919025712.719246-3-ryan_chen@aspeedtech.com>
 <9c867c34-047d-4771-b9a6-a2c88dd1f800@rowland.harvard.edu>
 <OS8PR06MB75419B5722DD375F493A7902F213A@OS8PR06MB7541.apcprd06.prod.outlook.com>
In-Reply-To:
 <OS8PR06MB75419B5722DD375F493A7902F213A@OS8PR06MB7541.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TY2PPFFD5F4C141:EE_
x-ms-office365-filtering-correlation-id: 2531f2fd-6b54-4da9-5948-08ddf97c405c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yCBey29F2hY2xrkMQOYK9wX2kDhl9OySAElye3XhlE+y0saZwER6Cxr9i9TP?=
 =?us-ascii?Q?V2P3m2gIgDbVjDPdpa5ZK54/KvrCGFADQnsmdEXGEOnja6WFVAhpKZjFBjiG?=
 =?us-ascii?Q?6PjALNktxNXVxEH+E9K3a2B8BBUtgyolbZqAqlkNz6Fghg/o0Rzqsyl5qrQw?=
 =?us-ascii?Q?z4rHkqUoUk1AF2rA/mgKWX/Zm2ZeNqNo3C+22lWvVonOIktpTI6ctbz6GIRm?=
 =?us-ascii?Q?hJmPmN++x4eGCZgw+cCaid6A/K1HFHuVQUP8acx+l3HtCETGbOcN9UrkZNuW?=
 =?us-ascii?Q?JUFTs9RwgjR7GFNu9EnURo4SAqzFMR/mYFYJvZiVDrlwh4cf+o9OV3GFKm3I?=
 =?us-ascii?Q?Fjgyk+MKNUPkdxb1b0a5GOj5jnyF7YxgP6F7CxYIBM9EjxL5O8WDDjnsWB/Y?=
 =?us-ascii?Q?y4tEyhjbVw0eJBnpt2k7aGlr+BA2h5CmnGa4AFKQgGbq7wMvQriDKnL39r65?=
 =?us-ascii?Q?mesWsEh4TnQMszMxxddgNmY9YV0UR+A2QmeRuZaSzjA0He6El6PsQ5pHTBhS?=
 =?us-ascii?Q?oeJneiA/Rq7Tp3MT8gGH+VNSPrrJP65HxuQn0FRcHmLR+LHUnSK6igS7oo0Y?=
 =?us-ascii?Q?0lrgfkuWyBgqxAARwvxf1n9A9ksb9v7P0QtG+t3XKEEtO55Vw0SGeg7H9D0c?=
 =?us-ascii?Q?gCIl5yZbeVAX8EYMIrNnltJGbJtNSnccJSLNbYraGeZHsM5+4kJvJ5I/XpNj?=
 =?us-ascii?Q?t7I1fneLEA/UbvWLa8snMJWR9ko3ZcCFON6/GJRc6snbg8eX95I5HYrMdiKK?=
 =?us-ascii?Q?LuVstodugB/St5k5CQzTUM0soSch8DwkS8XsmvsG80AXJ4GwNV34tpAuP1Xc?=
 =?us-ascii?Q?C8N8H1WM7nezUwxFiQj5kajwYaAGvixjCW+2NpfeDNOHMljPneAFUvqw9K4E?=
 =?us-ascii?Q?fmACNIZdpBM0kbG2w7M6MZz5snUhf2omQWtVmAeRY2S6uMFMYT+eaAmrbNUR?=
 =?us-ascii?Q?naktJ5XEkRe906GacpXMv5UOb2NwLjLwulW/JrfRRYbx43BFDfI6ahJ2/C0C?=
 =?us-ascii?Q?JM8eSaI6RpbZBxBfJMUN1p4Kcnp4EgNfjRSoSxLehE8grjcsb9ymy2WGiz8P?=
 =?us-ascii?Q?ZAUrrTtfLFN8jUiDK1wH4mSri1v3nm2hMRVSieiWvbdUR9NMLmRA+mSbkGmD?=
 =?us-ascii?Q?GsVGvXkop/ZOEWm2C/rjh+0fz/2b2szt8NnT1ebRyZVKerzzk0L7+Kl78ZWS?=
 =?us-ascii?Q?phdbWMDhZBz83H6VcncliKtqoEUte2hWXHaHgyMfqhLwB/VTtOkKjU7mDcv6?=
 =?us-ascii?Q?rHSZhaGVlMBgLdMoSYAHMmF2Ug9MjZC/07O/fdBJOIZb7oxM47HSlVY7EPr5?=
 =?us-ascii?Q?zTsczlyQeA+ok/N6nQc/niItzjGdvbDrrCZTrImAgHjBNCRtWBeO5UGGlJly?=
 =?us-ascii?Q?Yz3szP63kLyJAbqFt0hUrjajfhu/NQE7aa6N897Fo8CvrzMbDiovs1z2mLSm?=
 =?us-ascii?Q?T0ZIK9tIFbE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(13003099007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QhYqw5rnsh2xGISN6nTYufIVrvlbBZBqu4dhlMjEAhclAc0paZbgLGI0WNc1?=
 =?us-ascii?Q?AQ1Nd3Pt/L+yjxWnUXWCwOyUAgFCmXuqEVX/TLDkczSwkZS4+KlhfPH6HqxG?=
 =?us-ascii?Q?xRbLbpD67iX52q8WydKKDWIHcUSLuscYPVETNpuPublDAaahQQjGVUgYILzC?=
 =?us-ascii?Q?8RcYIKGG3bX4J9X4Jxjz0pA57+UCPl3doLcYcq8rznST4anETWroTpmpUd/k?=
 =?us-ascii?Q?S4xlxahFbp4u1ZFzWcyBMWr/2dh6Hk0pZjckwNp7Dsh1wB1GPfP7my0tYY5b?=
 =?us-ascii?Q?lkS9gJGmbWD19+SYpxbhL2vN4AZWVNW4lfC5Zm5/LljOQ6KJEKY/+EagTqY7?=
 =?us-ascii?Q?nYvbZn3AqwoFspJkgNQnFxXoo62MAYXi8/gF9DclRbnRSa/yF3ETRGC3oSwK?=
 =?us-ascii?Q?W7fodAOsUZ9oPCmI5vkUCcHens6GBbwbElNlxlDF58OFbceqiLhBRQ/AYMnR?=
 =?us-ascii?Q?p2tuyaCqY5W5LtL58EHvalja+YQdtV+FYW/g1J8argfqAbUtnR8ysWaJ5BYh?=
 =?us-ascii?Q?2c7wBewP1AMtCAAldjtA4sa4IKlDHCV7ynS8Mxpw7rDR1e2heAjhJgTGMNLr?=
 =?us-ascii?Q?SWZvJ1SHq0PnwaN2HdnJKMWQOacGzPF1IKv7Fy9LgktfzjfDVmL8zRcmTZ4V?=
 =?us-ascii?Q?+UlAmpzevrm4v7JuafChw8chzRRfEf4tDbWKcvR/7TWDTdPN6Q83g9aqbR6F?=
 =?us-ascii?Q?9Qay2nMAgMG1Wgnm5yS/3MG4Y5FPrkQoRKX452REpNHsprQ8dKOLMXkZnhro?=
 =?us-ascii?Q?842ZkJViCIBvxTOvDA0+Ew93OiflaS3KhD4uve+JbCV6WOLN+xMC9SUW3RdW?=
 =?us-ascii?Q?3ldzL0+4io80XY1IHDzd9K85aRp3zTRmPBZytfFjjCUug5C9YgRAdGrua6eN?=
 =?us-ascii?Q?OUp6hSbSt+ChWGvMredR/gh8jZSr9/lmowiXaApGNPVYYRPn5g2JVvpjf8sj?=
 =?us-ascii?Q?P0laWdG6w1GeT98WsfXBElhxmRdHq8EjdxKGMaslwG2P+ECSFVB88c3TZSV6?=
 =?us-ascii?Q?Hh8bN7wLPZB65pTuINnLeOH14bBK2saK1tKihFsK4TcAWyjJmNw8aB7oKLk2?=
 =?us-ascii?Q?p0oB51n4g8Lzw+pGed3caYKyzF/SdbJDz7BGNv+9IpQtmePC0ERbNiNrwX2e?=
 =?us-ascii?Q?O4VCgN2cy2Njw+q4jV+XjKciFj4ICSpjAT5gnS4chYgDrcPu6+BZXO2ybk0x?=
 =?us-ascii?Q?ysNm6tUTd7Adpgx4p0tTSQ91sEdjMt+4SfsxYTU6706+h1KS2gEnQLUSnV4B?=
 =?us-ascii?Q?yAAOt9Axn716GpY0sUFyLFQVOJGdZNQqXuSlkPU2CHIQTXDMjYiSGtu+cRI1?=
 =?us-ascii?Q?cxTgHhKdVTdCS5rsml23rL9f/huHvv6UFnGS3NV7k04R4LUdITU7xeqnyJ2q?=
 =?us-ascii?Q?FZqtrMwifKQyTdWw3JE5YpgmsPMIXwk65PFDiGHEfMXPI+baQ3Lh2wNE56Vp?=
 =?us-ascii?Q?EzOv9dGTcvu/b4gcB4W2pjFlUL6XhEYFq+pZD9noF2sTlhyreN/pwI147Xfl?=
 =?us-ascii?Q?4Fb+EeJSArVXz3ohdRiEfcZLTBfCT+68VaVxXwEUkqf73GlcQEwNTye5dV7z?=
 =?us-ascii?Q?xgu1AOWp3tvLii697eJRxPGczPdNEhpVyST51R5t?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2531f2fd-6b54-4da9-5948-08ddf97c405c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 02:03:40.7344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5H8yR1vSbaac2SDad95V958DE8JxWOwUZoeX0ANViBfffXEfmLlNOLaIrHQmlCInQfqXjtOePNQQ6D/IprDbLR9Zn08qO+bsExw4ZOy1/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFFD5F4C141

> Subject: RE: [PATCH v3 2/4] usb: uhci: Add reset control support
>=20
> > Subject: Re: [PATCH v3 2/4] usb: uhci: Add reset control support
> >
> > On Fri, Sep 19, 2025 at 10:57:10AM +0800, Ryan Chen wrote:
> > > Some SoCs, such as the Aspeed AST2700, require the UHCI controller
> > > to be taken out of reset before it can operate. Add optional reset
> > > control support to the UHCI platform driver.
> > >
> > > The driver now acquires an optional reset line from device tree,
> > > deasserts it during probe, and asserts it again in the error path
> > > and shutdown.
> > >
> > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > > ---
> > >  drivers/usb/host/uhci-hcd.h      |  1 +
> > >  drivers/usb/host/uhci-platform.c | 18 ++++++++++++++++--
> > >  2 files changed, 17 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/usb/host/uhci-hcd.h
> > > b/drivers/usb/host/uhci-hcd.h index 13ee2a6144b2..4326d1f3ca76
> > > 100644
> > > --- a/drivers/usb/host/uhci-hcd.h
> > > +++ b/drivers/usb/host/uhci-hcd.h
> > > @@ -445,6 +445,7 @@ struct uhci_hcd {
> > >  	short load[MAX_PHASE];			/* Periodic allocations */
> > >
> > >  	struct clk *clk;			/* (optional) clock source */
> > > +	struct reset_control *rsts;		/* (optional) clock reset */
> > >
> > >  	/* Reset host controller */
> > >  	void	(*reset_hc) (struct uhci_hcd *uhci);
> > > diff --git a/drivers/usb/host/uhci-platform.c
> > > b/drivers/usb/host/uhci-platform.c
> > > index 62318291f566..f255358d6242 100644
> > > --- a/drivers/usb/host/uhci-platform.c
> > > +++ b/drivers/usb/host/uhci-platform.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/of.h>
> > >  #include <linux/device.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/reset.h>
> > >
> > >  static int uhci_platform_init(struct usb_hcd *hcd)  { @@ -132,17
> > > +133,29 @@ static int uhci_hcd_platform_probe(struct platform_device
> > *pdev)
> > >  		goto err_rmr;
> > >  	}
> > >
> > > +	uhci->rsts =3D
> devm_reset_control_array_get_optional_shared(&pdev->dev);
> > > +	if (IS_ERR(uhci->rsts)) {
> > > +		ret =3D PTR_ERR(uhci->rsts);
> > > +		goto err_clk;
> > > +	}
> > > +	ret =3D reset_control_deassert(uhci->rsts);
> >
> > Does this work right if uhci->rsts is NULL?

Update the information that I test with ast2600 (which is no rsts)
When uhci->rsts is null, reset_control_deassert(uhci->rsts) will return 0.
So It still work. I think this is support both rsts and non-rsts platform.

https://github.com/torvalds/linux/blob/master/drivers/reset/core.c#L468-L47=
2


> >
> > > +	if (ret)
> > > +		goto err_clk;
> > > +
> > >  	ret =3D platform_get_irq(pdev, 0);
> > >  	if (ret < 0)
> > > -		goto err_clk;
> > > +		goto err_reset;
> > >
> > >  	ret =3D usb_add_hcd(hcd, ret, IRQF_SHARED);
> > >  	if (ret)
> > > -		goto err_clk;
> > > +		goto err_reset;
> > >
> > >  	device_wakeup_enable(hcd->self.controller);
> > >  	return 0;
> > >
> > > +err_reset:
> > > +	if (!IS_ERR_OR_NULL(uhci->rsts))
> > > +		reset_control_assert(uhci->rsts);
> >
> > How could this code ever execute if uhci->rsts is an ERR_PTR?
> >
> > Also, why does this code test for NULL...
>=20
> Will add with following.
> 	if (uhci->rsts) {
> 		ret =3D reset_control_deassert(uhci->rsts);
> 		if (ret)
> 			goto err_clk;
> 	}
>=20
> I will test it with non-resets platform.

No need to check if (uhci->rsts) with test with non-rsts platform.

> >
> > >  err_clk:
> > >  	clk_disable_unprepare(uhci->clk);
> > >  err_rmr:
> > > @@ -156,6 +169,7 @@ static void uhci_hcd_platform_remove(struct
> > platform_device *pdev)
> > >  	struct usb_hcd *hcd =3D platform_get_drvdata(pdev);
> > >  	struct uhci_hcd *uhci =3D hcd_to_uhci(hcd);
> > >
> > > +	reset_control_assert(uhci->rsts);
> >
> > when this code doesn't?
>=20
> Both reset_control_assert() and reset_control_deassert() already handle N=
ULL
> and ERR_PTR safely in the reset framework.
> https://github.com/torvalds/linux/blob/master/drivers/reset/core.c#L468-L=
472
>=20
> >
> > Alan Stern
> >
> > >  	clk_disable_unprepare(uhci->clk);
> > >  	usb_remove_hcd(hcd);
> > >  	usb_put_hcd(hcd);
> > > --
> > > 2.34.1
> > >

