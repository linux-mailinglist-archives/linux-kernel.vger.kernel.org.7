Return-Path: <linux-kernel+bounces-824550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E5B89874
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99641C80C69
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689521ADAE;
	Fri, 19 Sep 2025 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ReYMIQ7d"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6920B7E1;
	Fri, 19 Sep 2025 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286020; cv=fail; b=Nle20qQ6E4La2JiNS1z2yjNNa058gle8VdXbU4Kl7kQUw6gIZB+7/B5spuzwHhef6jHVf/PAX+HcLKYer9R+8r7jyY5JgXLk41zHChJ5z1kN+VnuM3in6rjM+2J5aRIa9+o+Dzuv6ZXoCUyc+JEguoy0/qA4klnDWvDOeQlKwp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286020; c=relaxed/simple;
	bh=joUjRxqdNA1ghHZEHS54EZikIu5ndRmw2bOQU/rDXgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MBs56gR4/3jHa0WpwTBi+lbHY9Gz/FbuPmfeufPpetClto/d/UewF8cnsBB2vTLVlBRjUCsh9d6bV6JqylW+BgBCwy7nvJ0bPlfhOhgYQ4MOUjmQEe4NCPLv2ZTt7OWZJBGBCWUSOqk7stTpyYyGJJSAa/MZ/2Wmqgc9AeLzWMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ReYMIQ7d; arc=fail smtp.client-ip=40.93.194.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJDwX83W0nEWTeC95wR1I2d6DXHqNBIo1I8G8E00mvobKBn9WQLCJq2g5niCYSJ4X4X7jrbo4hask7TAvxagHeMkAkzaxngwHeTjCQflOvgq5L7u9IqB2V/l6ekMKaDwiKENObEOlpPt8mWfIZZuf9BlB5O3v0U4HyNUVrv+jVvm6UkmGo9wyH2fVE4rZEL5rTxkrIh/wtG0o4C2y0K1B0Z+HtpXoNnLPkvTzLM/j8QauqPKiA3cNIGda5peb24UqSUX72RtpHwYvp/4fuu56O7uaHSuQJyC+BP0M9sa57A0eTrJf2rCqsSgn+xoyiec1u6hXPQriKNEq3yIuisC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmLCQqSExcjLoVWRlKFbIJuvdi1l3fJ4xFfPsFgolvo=;
 b=qR5NypNEOwvcyAWWDSM9aLdpK0cLNtXCGzPzWRM+rLrCQAjLx0YIb8Jp4i0vxgxZbLMTQU5MHYNIDktY3/ZSYLyKLCV12vTxsMJPwIcbxte19RxLS6K/d6WGpy2+PANgBoqzljhmoXqkuzW4GR+SCMu6iQXYUDOzx/ghDmGNqrERglz9bI9pI95CohJuv2rmrd+ShfLNNdwLyGFXi/cK450Rl5jv+qKheNDbeAPnnZqkvCo7tJBrbjPnyd/bD3ZnjID4tBv1NpWz0EgIhIGZa8dt0+MWGZeE4b+4QgRd/oZ5oFlIBFhm6eVzIj1oNSJCwVQwcIz5Z8ImhaQbTTfdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmLCQqSExcjLoVWRlKFbIJuvdi1l3fJ4xFfPsFgolvo=;
 b=ReYMIQ7duATyKL6qFPhxCn72vX2SRKSOMGQePV0xpYdrnYPjD4OIOM+ZbvKeCdE30vzBl6+jP4CHBeftKE0QzuUn2Gpda9Qc95fb4xJjFWrbFjHqfLxWvkXsqpb41j/9+qFdNpAcrMEhkWn8ztKytQOHbs75uxXqnOocfyroOlZQ0YED63Lq5VmycTxWV2RMB7AhCmDtXeyfZIRPOjGqGLauaY/+gXTqiEWZqT9BkWoVVNMGAnriy6pU88mPw4R4VrY9GPBmryP3xXuJmHFQCaSxGALePelBODqgihKMyNqDx5xJJTCz1zk3hrQUnMdSPWtBJXJEN+f72KwE8p6/NQ==
Received: from SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 12:46:54 +0000
Received: from SN7PR12MB7324.namprd12.prod.outlook.com
 ([fe80::36df:d252:e8a1:b651]) by SN7PR12MB7324.namprd12.prod.outlook.com
 ([fe80::36df:d252:e8a1:b651%7]) with mapi id 15.20.9115.018; Fri, 19 Sep 2025
 12:46:54 +0000
From: Ciju Rajan K <crajank@nvidia.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hans de
 Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML
	<linux-kernel@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	Vadim Pasternak <vadimp@nvidia.com>
Subject: RE: [PATCH platform-next 2/2] platform/mellanox: mlxreg-hotplug: Add
 support for handling interrupt storm
Thread-Topic: [PATCH platform-next 2/2] platform/mellanox: mlxreg-hotplug: Add
 support for handling interrupt storm
Thread-Index: AQHcJs1494jJsQwTC0i1mT7assuunrSVk+yAgATkDyA=
Date: Fri, 19 Sep 2025 12:46:53 +0000
Message-ID:
 <SN7PR12MB73247244E8D925D264EABA7AD611A@SN7PR12MB7324.namprd12.prod.outlook.com>
References: <20250916054731.1412031-1-crajank@nvidia.com>
 <20250916054731.1412031-3-crajank@nvidia.com>
 <34d028ac-f907-1505-a2fc-f455a10cfa5e@linux.intel.com>
In-Reply-To: <34d028ac-f907-1505-a2fc-f455a10cfa5e@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7324:EE_|CH3PR12MB7500:EE_
x-ms-office365-filtering-correlation-id: 3122393e-b106-4f9f-7217-08ddf77a9c81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?HMjUwH8v83HDyn579dcgHd7M5/jiDD9hiEQ/Qeecbr1zq26OZ9LpUrKuLg?=
 =?iso-8859-1?Q?L2yxL/qYZRwAgM0oG/A7b7BJ8GrSsJO8Smbzr1K3yW3Xk0Qv8krX2SnH+u?=
 =?iso-8859-1?Q?/mp+a5aSTOmhwThM0y1uDBiO3CPmT3QRIhxTGvbZDIlwn6CgXi/YrCWz+B?=
 =?iso-8859-1?Q?boK2SNDO2vg1amS3ecd2kXSb0BNjxYiws7YCoktxJgsHyRx29BONIkNOj+?=
 =?iso-8859-1?Q?5R/85kAJPpH/RZA+Fu92MIR7KkEq6aYqvt8oPgMKJxl8YZIjHqlgqSf90m?=
 =?iso-8859-1?Q?URMz5i2X/kes26V7WgRx+24gZllKiv21o/2F//Qyv2lPcrsNRhZaHeHO6e?=
 =?iso-8859-1?Q?vKRvExUNN9vmpR2SXZxoH1uGcTxBc9lYPBVxZXxetAoEhlRGfWchqKOefT?=
 =?iso-8859-1?Q?0Ekt6F2aAyUbaE46459bQKDodwWTpp8oEMfD9SYDsobOTDE5FSmyevTwHo?=
 =?iso-8859-1?Q?4Ts83GjqQQbo2nzLxQwyhfTEl3NFwUT8MfUkyFjwxDtjY7Kk+V6OW8ibf2?=
 =?iso-8859-1?Q?YfhGnUwWg9ZPdOVFU3i47+MW6/qaN2NugsNw8Qoa0cMhbZf5effGPRe8GM?=
 =?iso-8859-1?Q?O1n97y58igk16KpGyUcRLs+8Du1pBAjuUKsICTZqcXvH4cflOH1TyCwdq0?=
 =?iso-8859-1?Q?rnpaX78wVacQJU9Muk7G7iAcXFoyYaNXvyZXRYjYpMjPdLykDtm0RuWZLi?=
 =?iso-8859-1?Q?iTjrJFySU2V/oTPupUVQ7YFPvcjgOSyecrzeA2KT8TGA7kGN7T4Pd3nv6r?=
 =?iso-8859-1?Q?b8c2yBnYDx8FADouzJDxQXEOP0yBxJv4mG96n1/PKGbxZNWjEDeO1VET5o?=
 =?iso-8859-1?Q?nNY81+/NyoKCOTT43RrO9YIkd0t1mK4F1U/bllN2y9XXqdeyCRxbDxQEWX?=
 =?iso-8859-1?Q?phrdohnxJrHiMn5dA1ufXc0xFbw+UD+PL5ynNMP6h4k+usCAsGc5zIO9bt?=
 =?iso-8859-1?Q?e/6O29SXdvxaieDYlxirw+HJSlQdITPQJbsJl7jbgWBe8Yiy0jAmHkYN1H?=
 =?iso-8859-1?Q?pSUG5xPVlmJNPbWgoIcC6Y4Kt0P9R6m/32ojqwVMRQN1ydW9YOMm0myKbJ?=
 =?iso-8859-1?Q?bbRs9QE5aR19FkkxX91h0ymH5Yp4NECLAATQXqOqSkHr5oIgaZmaOYhUDG?=
 =?iso-8859-1?Q?hDMjXx9ogRzZr/9NDnvKT51aFXXaNDZu+l8s1VdMVY6foMngnfwBF06lyM?=
 =?iso-8859-1?Q?b6vPpqyv7znJCCRw8bO2cg+MA7kT6URTf74k/uee2WwU6Z8pIVoU6zY2Ac?=
 =?iso-8859-1?Q?15dREE1melBPRXYVPTlrEKt5kE3ZcZVhawGulhyZWGyI75yAJ3BJvO/Zeu?=
 =?iso-8859-1?Q?nUkk5ZXkTXfftrn4BntWmnTLOPOsE+MXkj9+wmRHOLK2tWF2PvdDoZnSEU?=
 =?iso-8859-1?Q?jXY3jy0aZOysK1JIiCbftnGmUc9DFHfDEt1BG7MfE32CBDUMSVoJ7ndMkb?=
 =?iso-8859-1?Q?BTbtAGpkQq082yW9GuUa0s1QZ3G5cxb05UniwI27Ox752kqXWIwaxruXdz?=
 =?iso-8859-1?Q?Xx6NHHH4HFfur5Mz6yp0rH37mW0BHk+zy2+0/+dwgAPA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cAQvm392wbQBWglnlm3MDI3w/DLNPEJJmPcUxOG9b+f4MXpukZgmMGlBXW?=
 =?iso-8859-1?Q?HLcLx/KWrZ6BDvcGPbkNs/9wn63RxtC4+IC7Cy6valhgigH6HA6oelmfrF?=
 =?iso-8859-1?Q?Fz/JumIkikuYrj3ys6tocbVgI4aBZyvAsdHgh7QY0PefAow8NDcGMYYdeb?=
 =?iso-8859-1?Q?XKRfNmKspivmkq2IGVGlVwjRyZqDnPpBX2jxAOmLqI56Pwq+Jo1ofjdFUj?=
 =?iso-8859-1?Q?1Hcwee9Bk+TbHhbed5iKSyQpTTpd1VB3Yp85y3hQhYQ7KamgIiqmqB2cRq?=
 =?iso-8859-1?Q?mUDPKOmIyE3QSn+w0mMwawmv9yMlVQtX6MMOSSUoJG1R/crzt6FHPHl/bw?=
 =?iso-8859-1?Q?00/xwSYMQnAPlH4AELufMc3R6v3gYW8MoR4HV6p6I7id8cYlYmYETEn5Ji?=
 =?iso-8859-1?Q?KGd9MN4bBBx6wMnyh0z1/noe1EHxmRqveiqT5cVO6KM0bS5wZHr4RhtLZL?=
 =?iso-8859-1?Q?MOyj/PfwraEuJhG6nuTx5LGDYB5NwD1XdEi+s5JtW3NpvLarQJKIETE9bh?=
 =?iso-8859-1?Q?tx6SZQHxIIeurFCVo/t2FRmBm6hct64GTTIdM/RnvBiuvThQPKYxzA/SoY?=
 =?iso-8859-1?Q?74kPiAflNSTIlSfIVUUlbdPv5LHVVXRkWGn4GzdaYTnjMI+6U7yc2CuCJb?=
 =?iso-8859-1?Q?8wuW6pdEud3oQGqWMwDLoZTKqrhZ7zcqDO/WNRlE3zZyDs2scG+2mCaunm?=
 =?iso-8859-1?Q?5zKFrFHgozK1h5ph7xPe6Y3GOKB4LcW3hvffaVm8lEDDXnvxxTNjtOhnkE?=
 =?iso-8859-1?Q?nK0ahWQyfGTSGDN746Ur9w2HSm77pjST2GLslUD6jcLExOr/9bizdX8f2k?=
 =?iso-8859-1?Q?vEksJixkaOmq+buMQuKG2L4KrL75IzKg1lEYe+fod0qdPBMB/vH23unG51?=
 =?iso-8859-1?Q?9L3il2Jh4yhkYNNDXlnRDGuLlDXDnWvjA6RYDm+V64DhacVBJqOvQpfDK7?=
 =?iso-8859-1?Q?ClxEM9mN33TmQC2eCFQwShLjHpp2NjAmF4L5YNSNDL3vVYCiYt2jQoYcJb?=
 =?iso-8859-1?Q?AoQTTZmAdwd0gPJabsQJdd/kn9cd4gvdrJjsTbRsnIiREVoGVU27g783tB?=
 =?iso-8859-1?Q?HEuOvSwSieae/xTGaYLxl6VTI2m3bNr5Ej+dfLA4g5PvkWY6FmYWu7TrIs?=
 =?iso-8859-1?Q?zRBOGF0V3C21FEHj3MTG4X2zzjHiCU6sgehE9Js6QgJTjp0fRVZD+Ad1wm?=
 =?iso-8859-1?Q?17lRI/K3Tpay2H3gfFKnfKOhgyjFGW42vyorO35lT7FcA0x6LD39fuYpI9?=
 =?iso-8859-1?Q?/yCVvskrDC25B96kCLNgRbG8F/hV0idXfzIAVaWuWV64vWcg6IIGgU9mJ1?=
 =?iso-8859-1?Q?CdfqBBBi1BJh0Aajp8q6dnl7rKSJsUKdLcjVSDDfB3HOM2FK4kLqSO2oJt?=
 =?iso-8859-1?Q?MQYfgepYwIp6FSM3FUawImUWJ1deypmJaZQQLk1AoiK3NmYjvcXUUBwUp9?=
 =?iso-8859-1?Q?y4rxlm90GGlCxQowF6I810kNHuxf+dttKjyOORXzjb0o31PXzn+f+MJdPp?=
 =?iso-8859-1?Q?D5SH3Bk2rLZ4oSKS2VG7REzjt7DL6gogTeoyFVEkS/izExafI7kSZT1oY2?=
 =?iso-8859-1?Q?/z8se/0yV8aXbcN5yevCn9iXkm4R2YUFogI8uxlxciqKGyOaAHu7PqeqlO?=
 =?iso-8859-1?Q?9C8e3Av6IYe3c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3122393e-b106-4f9f-7217-08ddf77a9c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 12:46:54.0080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CeQC2H4XTTW00nwJiEfVWMLkAT7YWa8dBc1sbE+11zjceQxaJpg43YljWgLoEjUbAAS5MK9SncNa2Cz7gAYo6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500

Hi Ilpo,

Thank you very much for the review.

> > +
> > +             /* Interrupt storm handling logic. */
> > +             if (data->wmark_low_cntr =3D=3D 0)
> > +                     data->wmark_low_ts =3D jiffies;
> > +
> > +             if (data->wmark_low_cntr =3D=3D MLXREG_HOTPLUG_WM_COUNTER=
 -
> 1) {
> > +                     data->wmark_high_ts =3D jiffies;
>=20
> Why does this timestamp have to be saved?

Good point, I will remove it in the next version.

>=20
> > +                     wmark_low_ts_window =3D data->wmark_low_ts +
> > +
> msecs_to_jiffies(MLXREG_HOTPLUG_WM_WINDOW);
>=20
> Why not just calculate the ending of the window right at the beginning?
> I'd call the member e.g. ->wmark_window (or ->wmark_window_end).

ACK. Will introduce a new variable in the next version.

>=20
> > +                     if (time_after(data->wmark_high_ts, wmark_low_ts_=
window)) {
> > +                             dev_err(priv->dev, "Storming bit %d (labe=
l: %s) - interrupt
> masked permanently. Replace broken HW.",
> > +                                     bit, data->label);
> > +                             /* Mark bit as storming. */
> > +                             item->storming_bits |=3D BIT(bit);
>=20
> Why not using continue here for consistency with the other skip above?
>=20
> If you add the continue, you can remove the else and deindent the zero
> assignment by one level:

Yes. Agree. Will change it in the next version.

Thanks
Ciju

