Return-Path: <linux-kernel+bounces-805712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728FAB48C8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE08C7A43E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B2A22756A;
	Mon,  8 Sep 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ehcfA6IL"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E6229B12;
	Mon,  8 Sep 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332269; cv=fail; b=gaKSCVNCqOT0TmNpjCNvxjBaTrpuUJC14jBBwuX/2bcClEGAyY+d4qBuMmgNoWXJw9V82ZCn5aF2nABaq4t0knniP1DNuoAfCN3IUfHxtrK09N+fRAHF+oBytmTxKf00TdPw0uidRsY2s8xwq8xUEN3B+yvUwRKGopNvOmcHvpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332269; c=relaxed/simple;
	bh=BTSPycQyByc5RIoebmF2WvxZTg48p5BS80TuUoHIN6c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jzDXsEK5DE8q/uqcFgLKGZ7ZVokiU+muaJ7Mwll8sLtIzviUeLh+rcEAMNlT41nT7EnFhIhTkR99ZSxUOrBi+DQnEND2fRYrsfgb+N1x8JFFb7gDHQb7BKAouuaj1SmWeDC41PnGAa4m5ubUtLO48mP7Y1nxd0hfNHDVFg+0JHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ehcfA6IL; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gN30L3sM6hwo+RRpfWV5FheeSr0RwUu2TqCNyEzCUeLi6sZSOfrjCWQa/aks9PbfoI8t0q90o0kCRO3OazPNNFokgm/obJGCgQwR7ZFIePzrloSHEdzj4/6pD7T0Tq7XRpaZ5aHUNEbPig1C46md1/PczG/0BpmahNQMtIgyc0IFArfc3XFsBIL3mqraQPNiEOTYeIkMbm4l1uj8NZ2oaYc3ZkOXnP8G93igrZsHTBnILcx478J0ErI86vI8LHmgMonD60jG+ZqS5C0BYbiIJZ7CveHL0WL2rxmnjSLMc7xhVNuA9kLz2nU2XjA7Hgsd2/7KqOs3sXUMUs0FJTou3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTSPycQyByc5RIoebmF2WvxZTg48p5BS80TuUoHIN6c=;
 b=BPVqzR46JpqRPYqHi3glLEgPahYeah/TLUkFBLP4D5M+En9XYbH9uh5n576HXH+uK1ZKjWrPq3/YxkHeQZjKMaTuF48Tj9WitbMdJPNOFAEkJnSFNK4dCEelAZyXQA30ZD5m/PsHxRFGWobn/iVOk27bCdjoLRjyDk/z3+7AG2hn0O7Zd4arHIZvRVNtXdJ7V9K1Vd/KRXlUjwAYdG5+Cec2H71SBgaOQ28r/97wLzyS07DA3xVsixhQwTLScqnoOqH4CD07isPIRmVSjEZnuNc+ka99Codn5rcTEkqzXtbOE855Sg9KszSCI2jaGxPaNQ1CQ2GpOXZJE645b3UuOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTSPycQyByc5RIoebmF2WvxZTg48p5BS80TuUoHIN6c=;
 b=ehcfA6ILtuljQ5BB0VryaqojujW77Eb/16m2BkRaL9kKzBDixSmoLaRiljeRVhdNgOcZPppCOioszqYBNU4KXJj2Dl4ndZvLl1uxL7JVRljmECWfJkkt1BqcouUgbeDCVG4wkm6G/xTtbfzFtoA1syDh5wS02p3vU+yw0Of18Cawe+cvThr8ezn+yvu6a6/oq5CxE6FHCcDbpGi27Z2odAKPnehlQYeYfVW6ny6bp3rcgFiBMDmCMgOowgOkCi8ROo/OUhGfVBXBZoKuBIzUFFBHJwlthhr0GP/g7djrtWnp6dxTI0KcuJzqs+myrVt71YsNEPwdF6Y0ZtIG3ANq8g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB6864.eurprd04.prod.outlook.com (2603:10a6:803:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Mon, 8 Sep
 2025 11:51:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 11:51:02 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: Cristian Marussi <cristian.marussi@arm.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting syslog of
 MISC protocol
Thread-Topic: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting syslog
 of MISC protocol
Thread-Index: AQHcHYiHR2DPVilmpU2z96PMF4sNSLSJJYwAgAAL0FA=
Date: Mon, 8 Sep 2025 11:51:02 +0000
Message-ID:
 <PAXPR04MB845929E7106141E785A32387880CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
 <20250904-sm-misc-api-v1-v4-5-0bf10eaabdf1@nxp.com>
 <20250908-sparkling-owl-of-judgment-f17eeb@sudeepholla>
In-Reply-To: <20250908-sparkling-owl-of-judgment-f17eeb@sudeepholla>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB6864:EE_
x-ms-office365-filtering-correlation-id: 7f712850-5a28-4808-804a-08ddeecdfc33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zwxsaVyIAtsJIoo8LT8k6N9K/ug17CfDJQ+coU+LQlbN4AobMYc2xQ6irLqp?=
 =?us-ascii?Q?CgKC8LWuupkNdwvL/DdkFcvBDafjAeXiU0PbiXEngWKNVp5qvhv0i4NeA+KL?=
 =?us-ascii?Q?6Irwm+3i3w55WrgRHBcHPCC8pu2oUa9wCLW2WpMvOft0fTryALuT3jI0a+A8?=
 =?us-ascii?Q?0c53xB0G8mtU3njCT4kFIhO0py+re+hM++gXjIV0X/kzdjK3vm/+OgVpnq0V?=
 =?us-ascii?Q?wY1hrHCwbExzFs2qsfdp5f0jLPnuYLTXGIoSZIc7U0zdJJNvWEuDN/7SSoIb?=
 =?us-ascii?Q?6FfVs3QNdRsO/cG96YVAYTGPrfba1jVOvsbYQIMkRf+OZNWfVp1+9I+cOsNJ?=
 =?us-ascii?Q?tYp3Q1j03xciNElRP+vjhx7cX+gvdLkFSj+dQPjxHPAQW46VH+PkRVTcKrze?=
 =?us-ascii?Q?unndN1TE4pPvigYM4SXSmCqjo/Db/fZNEqFqr88IM4NdDKrAICtnxgZa/UqE?=
 =?us-ascii?Q?oSnkbUhwZqgf9su9dCegVUTj/r3OcZRvjbwK0rmlQHL1YIvakFPTBFAWIYV/?=
 =?us-ascii?Q?eMenFrOWAyhOKNiAhAVKUQg7a48uwsOk1VzU1QGuvRQXvta+9ipQsC0ERpHi?=
 =?us-ascii?Q?CrlWpIol3Vjq9W8GO+pgJFROdh8DSz9KK52pvRMJMbqYWXQoBXMQNbu4hTlJ?=
 =?us-ascii?Q?MHs2mxYBILCEw5KqrfTmViCwrEH6BWkMlnKZ0ekt3tjHZ2ltEel6/ygpLawN?=
 =?us-ascii?Q?KoV5QM0jHxMiaa3h0tIyCxHd37Vtwiczq2+tIHKXgW32FfeidJkwQwW566vP?=
 =?us-ascii?Q?IzlghOLgk1uXuclr4YqdOji/tEdy6FiNc3OM6rMd4W10lMlwm6rjJ1mXDAOS?=
 =?us-ascii?Q?vSu9ozKOxB7QFq7hGdkvXWPsbEuVIkJBJ8ADj8/htwDFlVmp7myuMFbXPz95?=
 =?us-ascii?Q?DCpqtz9Qj2xbHxs8O6CorxhSBT3ABnG90bwtCpmJZYi0aJc+NdYrH1jgbJwP?=
 =?us-ascii?Q?gx/BjcHGeK43mlwb62ll4YEcsZhpAcu9q8lD0CWjsfR6fr/xrE9XMYun0xDj?=
 =?us-ascii?Q?44foKY5syot9svJ6ZgaaEMpWSPgoz52JTJPF7j1UDu+Ziq0bBKQX70rMAOvH?=
 =?us-ascii?Q?uGsiE+3pPDf8wQ4Z4J4Asv+2Hl7p3q+q85Z/mVC2rGZcYQzu41ZOYGZSQ2qn?=
 =?us-ascii?Q?ICbZS7PQfaE/VGLg/+kdCfSZgPmcuMDVNWgtLwKdB/s5yu7h39T8UCliBDDt?=
 =?us-ascii?Q?lD0oQrmL5hbSgtMa/c6bnl/U/QtkkijiZvLz31XQpNHjCbT0oyYmJ4c24v4K?=
 =?us-ascii?Q?p326JvDoV2HJIRwz7KsJR6A5/FozfgrTriOHm5n+ehA/DoPx9JVdWqQQ+mN0?=
 =?us-ascii?Q?nUMOx/A0IKYpxwGQAGGXol/AaKWuVXS44SwHYj6huxInZjwBt9wdoZRI6rDL?=
 =?us-ascii?Q?J+t/t4xPUWiuBx8dPC0lTFPq/JWKGnAHe1eK/XKK+MvEQRimgWdwFZLA3qpJ?=
 =?us-ascii?Q?fb1DuWRsAFsKrNMt2rrrOneA9bD12C0rM3B6Y7qX5rYqWY4T5JswgA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DYIMXqP+eT9e5Z7UjCq9/2VVQ1+aT1rYp16AkWiCo6vharm38Hjk4xBkx5il?=
 =?us-ascii?Q?tKqSEPd0V0zSjGIVOMU3db+qZVLP01VAg/fDV0fP9j1xYPep9amQvycDlu5M?=
 =?us-ascii?Q?t83N2IW0xZ0awypXMHv8+GIFgiXaRjhDj8rQ+XkRA61M5JpeL8YL3i7CqhYa?=
 =?us-ascii?Q?gte73VRoYUDF/Dhn2K5LOXy9PQ0viasaRj2SiwEjOVgrplLnjJd2k+jvLlbd?=
 =?us-ascii?Q?Wo1ksJR1l7/TcEw826DgltjdU48oBbe7Ygg87xJ3VPITKYLNmhVCfBTia80Y?=
 =?us-ascii?Q?RYt4hsHROVvaMFGK+UnHQsZ8an5ZjODKVaCNn+Tkqm/hE4W3yJnxlu8QTGtu?=
 =?us-ascii?Q?/4Ll9DNkkZD0rZIhW0P5DVZnEmsj0SdmdJhS1Oon0Eu0jmWOldYDrDJyHmwq?=
 =?us-ascii?Q?Q1DvEjZRhqT5rgFh1wirVb2jrn8sD9AbegzEgUjl2PTFOvAlf9tbQoPWQfYB?=
 =?us-ascii?Q?a9nOwWVYxSSqLZbipCLq/n8aMGKFH6CIMKsp+emzJihPzsSevs1TQ0wYjLwv?=
 =?us-ascii?Q?9MPVDWVDWfwU4WXnZkDcK4nwSk2WD3vf+jY0sSlFuhc7sRghp7tDKZ3ocQl4?=
 =?us-ascii?Q?Im2T0cwn6uiZ+uC7lsktOSrHfwD/VCQJhcP+VPvNaSF5/5688DMRxgq7TK/P?=
 =?us-ascii?Q?4/3C2xHQjJAEi2/JZNIM/GQmu8QvQ0Y+EyUVVWgi69B4IMewCbm8UtkcCuRh?=
 =?us-ascii?Q?EwWQsPD+9Lte8MQusUIgvz4/B7E4EsnlWwU8Au4ntwaLPhrEGSjVtQ6DruwP?=
 =?us-ascii?Q?uB65xln2cwO5PfZucIKQWolEB+KvyWF0bXCT3VAcyfdJMupmmuzFfBBr4MBg?=
 =?us-ascii?Q?+WKthK6TWnXkVujxuscbdF5ufk674nENs4CGnOLRzeVYlnrgMw3roi8u02K3?=
 =?us-ascii?Q?Muoe11ktWZjcR3m97dTaRFQlBO96t6UcWW7skwTyNIsZjaKNWAqVo1QZi4qH?=
 =?us-ascii?Q?fsJwVVtaz82jESDSfWkwhpR+7BFox+otjGBm/+zoJd9ZTA/iOm476ly5uznu?=
 =?us-ascii?Q?2F//oJLoqh1oSgS1lk35UDi1MLXaOLVQnA/Q+2ZOXOjZI2D2QRfWcq/uCf+F?=
 =?us-ascii?Q?U5SWIQflLHC2yxybEb9mnpiwQdkUMsmDNBTwDQIOor7fNIrasQ5egPLDaqJI?=
 =?us-ascii?Q?nfyTn1peqStb+QqSvkkMX5m9XbPG1uyYiFnRH+ogPfC3x0JlQsqyATh/6WRc?=
 =?us-ascii?Q?pDinJbScaMnZo8OIqUIqi6VTCN0hFlujoghkpz9rzGAzzMDU0U10+HqJXaqz?=
 =?us-ascii?Q?ZaVFUkPH/mNjq05hah8WdPWxwGLdOz5JqM88UFiP1HWG4lteDO1/cAaaOA3D?=
 =?us-ascii?Q?GKIY97uUaZ62krJkQBNDmfY0gGmV/s5n3u4JBKZmxuOJO4rHUl9iMGXUHNaw?=
 =?us-ascii?Q?7CLc9eOU5c5l3zZRx/g93xI3nM8eapKIkrAfOrux7xeaQH4lW9GS5Gpcrnpl?=
 =?us-ascii?Q?sSkbrsW8WpoikzdeHjLBbQ1YdTMTcRwGCz05+Ko3b+Q1CyotiiBhQhgwZ3Xb?=
 =?us-ascii?Q?uQJfpi4FRYrT54OoskKKnnwkxPa04Si91mTjtaZKAxQInG5EkLr7Y3NYMyeU?=
 =?us-ascii?Q?HepQ5pw0v1YjQ5V35Ug=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f712850-5a28-4808-804a-08ddeecdfc33
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 11:51:02.3331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InswwoE0aiRInK4l00RoAQlRlHGqAbVyXMwhQSB687CdpyqJ5qCl7NKSx2fVZHJEiAPt0gqz8u8pyJdlVGx+Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6864

Hi Sudeep,

> Subject: Re: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting
> syslog of MISC protocol
[...]
> > +};
> > +
>=20
> Much better now. But I am still thinking if this must go to the
> document to make sure it remains ABI and firmware can't reorder the
> as we might have no way to deal with that. That's the reason I was
> asking for raw dump so that you need not put all these details in the
> spec/document.

Let me check with firmware owner whether they would include this
into i.MX SM spec or not.=20
If no, raw dump would be the choice.

Thanks,
Peng


