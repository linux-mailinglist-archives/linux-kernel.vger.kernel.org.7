Return-Path: <linux-kernel+bounces-811377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADE3B5283E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0890D4E1788
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBC624729C;
	Thu, 11 Sep 2025 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eY1b3JBg"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013051.outbound.protection.outlook.com [40.107.162.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789FD329F29;
	Thu, 11 Sep 2025 05:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757569628; cv=fail; b=dzCVHqx6DJckZsemOp9mb9v1Aw61J2vdoRbnReSARw9kU2tY2Pb+rUU/dG+DHsZkN6zTBw8gFtdmGgCa72OSHO4MT+qMVbEobGa2PuzElnq3TfgTBXONwRr38SQMevMry6sFQaVcErK++qUlMfUcVC2fXsZzjMK9k2LfyGxX9Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757569628; c=relaxed/simple;
	bh=I+GyhBz7OrJPelp+cGglOtBa4OLYJ93zrp6e7JLL/w0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ElMZPGFoIyLfP0WSbOmpgWlH99pNiJ68thnPwu1msFOUAVaGTRLWgnVlBAmsIsZDCjVtqud3MINI+rQlV6qcaamQ4KEb/RwBo5Ut0Nik7yNl4qtZNyL0/QMyLv1ChzyPPwbTpcrNX/3UuHsL2V5dTRn8abCzPEcUHRpaNGCyjqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eY1b3JBg; arc=fail smtp.client-ip=40.107.162.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GC5siQqrUQ/y3PAnoh3E9m8o/+zd3PXbBrOtYpXhhYgC2hv4FDKWKhSxUqYUyHBtyxbXBotrA09uoaFpS5tup0qiffYYUstqrBfjzWt34uKSGJE8Dgjr9VeAJ8L9S1TkfzRSDO83ZD/3W4+JZzwKH9xRpafcZfomE4d2qzOCjL1UrlLsYeORc6u1LRup9cv8pXgsazqsi2Au6Ioe96bFMazfYgT+6c999wztaeZ8rmshuIF5CCXLhVmmacfW6Wc9QCFZgt8NB6OJNP/6E6u7jKFYL99QGScbD9eclhTy85a8pw4NOpmw3wn9238aHjpmivowXGIVZwDwDIeboGtCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wviYovxKazF3FQuLbMuPhQSbnBaeFo8Gs5r90YC+Fk=;
 b=T8n5MEji4NXE/K2FhlHAw8Yzi5xyPAeoD6FOIrUV49gGEOzqz/65gsu+a9TBgjO4dDSHcCVJj9c0GdjDegjvAnK0dENS+y5+/5l+Q3FhKF6Zuf8z7KiBRPDFc4nopUbj+YsnSULk/PKpnpRz6J58FFegK6nXYJ/RkHcZjokyVsty7d5zBdWx+3kdsRLzAJMqxyQIYsAYWAlOm+uLzaNxJy6CK+W3qZPzMR9fLhWQ6zL7e5YeK0hKsU2aED0OnQpjNeHHsUV854QN4bJDHrw5urchg8iYqHUYSu+i8/RUGDF50rLWuv2tnlFKkKjAo6Bhfba8OboX1N0LD7jZpcc9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wviYovxKazF3FQuLbMuPhQSbnBaeFo8Gs5r90YC+Fk=;
 b=eY1b3JBglaLpQk/HasEekXh/hk3/ziozXY46CbpvpiXhj+Kk8NB+lQP8Fo3E8VhgXYkOtsPulNKEopTuU+OLHk8iv8OgExOTpSDgx6sBQeVPgsg0HrrLUbOMiWEzKo0fX9YX1fpr7xPDalmLynjBOSGdFy7DnoUJkfs/GZXkTIK8URm0JXzsHLTuHnE2tfRa4pBJrEM/KtRLJT87YHrBpXuBVwCERt/ACzs/tv0rPt+50zJ7QyzXO6XZABxx6HKwUikw73eaDcwJmXmcwmN+7TDoi3iIo73q7nE8cMW8ugzCdK51UKtXxSYkhjeviyytMowojG4DqbcthL0uCzKVAg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA3PR04MB11226.eurprd04.prod.outlook.com (2603:10a6:102:4aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Thu, 11 Sep
 2025 05:47:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 05:47:03 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] firmware: imx: sm-misc: Dump syslog info
Thread-Topic: [PATCH 2/2] firmware: imx: sm-misc: Dump syslog info
Thread-Index: AQHcIl80Fo5hq2EiRECy1yk7e9nPa7SMlf+AgADkEmA=
Date: Thu, 11 Sep 2025 05:47:03 +0000
Message-ID:
 <PAXPR04MB8459349D4D60703FCFFDF7698809A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250910-sm-syslog-v1-0-5b36f8f21da6@nxp.com>
 <20250910-sm-syslog-v1-2-5b36f8f21da6@nxp.com>
 <aMGi3S2j_FHid3Sb@stanley.mountain>
In-Reply-To: <aMGi3S2j_FHid3Sb@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA3PR04MB11226:EE_
x-ms-office365-filtering-correlation-id: 9f1fa9cd-d712-429d-dbe4-08ddf0f6a261
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fngUsFgl20DjFsL8UNJ3NVfxaf6j0KR3WTJnJ1sPRUb4YjAsoK59TciYndvt?=
 =?us-ascii?Q?wHeXYmBkcgYhr/lc5xthGdMl3Y5UGJ6hzsjSUQzMe+1mUXJxTHTgUwaGgi1L?=
 =?us-ascii?Q?tmGyv1YU5Rm2j1JQmWiF/HIAgcA0aZgAYhJs5PX150IPglDigGb7ljc29Yxp?=
 =?us-ascii?Q?YSjrEpGK3VHzR0ty/8smD8Vu+3jwS1ENlESeesm4nATdbpc3X09+Tu+exUas?=
 =?us-ascii?Q?at2rUmfR6EwsPAzwBRmPKxnswd3F3lifrgOL6wCiaHN+RHvdTiw/qOlq9PBj?=
 =?us-ascii?Q?QUnlgOrrO9VMC3bk5iW1aNyS1x+37n9R1iiHEiMrXy4S+CCm7nJlkOVujLyX?=
 =?us-ascii?Q?iObKktSe+o9opbXf3E5gUyjkXYjpRulxYGN4GxSy80DXCEJ5aCxX/z/+Zxpr?=
 =?us-ascii?Q?kMJkShCBUPQwNUz623nXkU5gD3uDu1WHF9+nBzcCXSpLesZksiwCFzZB/+0P?=
 =?us-ascii?Q?9tVEO1BVJATBOujtKWoiEF7XWB9LYHnkk0qgdjYDqxpNrsX3FbeYA4JyM5BK?=
 =?us-ascii?Q?HLMDEIMWb9EFNRsP9TVnB4FrMNYfoAtdd4fY6klVHJ3NYhJ3zsdzygdGq1qP?=
 =?us-ascii?Q?ZtPeU4il4RGV0qABBAfr4kzzCvxOgV7sr1fgXvBkArq0mNlz9JZ2Osm4GJHC?=
 =?us-ascii?Q?etKCv5H82G82HR/UkpbESEH9JDUEo4GnAHtnf4b5PiFPjubTvIzyWUtuiEni?=
 =?us-ascii?Q?/bfJb6Gk2jKH/KpOtL+JwiFc1a1fGUDaZxwB8EYRfbxErYeaxDRp2hWmL3Rk?=
 =?us-ascii?Q?hlns0/sFUp4vEG57uhFnF6jy/Xy3+y1wHUT+VDxbHMLCAjkvLYZQ/CkNNCOC?=
 =?us-ascii?Q?3avzTfZjjnX3sXEmA2UmD7MYbQvvKwQ9rnyfwcCg5cC6VOFlRrrO6R0Z4OzS?=
 =?us-ascii?Q?X2yFLiABBUibq6QM90ifvufS0291kbiKX3BQlWOHae3ENAz4rSabAd4MfQC+?=
 =?us-ascii?Q?r67gIxi7JL6ZAwHUMI7HkAUpX0O09ogWcTOZJude4fg4nwG6C9HGdI+pK0eN?=
 =?us-ascii?Q?xuBHb9/Ie7eQxoaalDpmHND2aUvnEtamkFn06myLRcaJinqy3WcbYyzZttSD?=
 =?us-ascii?Q?hK951oKRwvWUzUysMGqeagxP2spIoA8WgFuBcNdVJZQnfIC52BzTPy3FawWt?=
 =?us-ascii?Q?DZWSN/HIUEs9zyoBZg7tX3p7/qWcd4NCLvEtCTTwxrq7l5EhZJFg9tcfrLRX?=
 =?us-ascii?Q?u8rlvKB71a9toZcAbgudfcQmG9LwrAeM09G2KrxBwidOnpxEYpek3oBQMKgF?=
 =?us-ascii?Q?1T76SOkWRNMYcvb/RgeR+uQ3Z/RM8onV3AX1GdjEzwdcaOtXCze5NQaB8QMb?=
 =?us-ascii?Q?BkmtkWiPjObDI7A5BvomrFHnkXC+xJknVjPg1v4DtMzkQIegVBVS9SMcg4xN?=
 =?us-ascii?Q?e1BfQYi6GrbeBtpx5B1LhwyCmYE/shGggROIYCZWzp+RaMyl91lZBDFUsw+8?=
 =?us-ascii?Q?iBZ0uq5ts4TDHrya6Wt8ZaDXIsdh5Fns/aPeQxabyy6iysGSyOlYgJIyG2Gc?=
 =?us-ascii?Q?LsOZySjpkCQAfRU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OJFLFhxsKD0v73d2KAHoZ0HUkJGayYKWoqGh9G9qpLQ9LwLVELmJ91C5zB55?=
 =?us-ascii?Q?a+/hkDOay/NYrIIIUubdTEdkhoPAfAHMVrbw50PX6AEalsx6aJDwkIfRkETp?=
 =?us-ascii?Q?AIahgJOevEUI+23v/VisLmO1DTkMQvSlqqkMwdyw8w4KAmFfIByn/BSfDldh?=
 =?us-ascii?Q?xYm0zQMn2BgGXNK7l5BJXUhTk7wJxs+uViZKtH/LctJLI12uLMJpI9t0SVuE?=
 =?us-ascii?Q?Sl8BaRsrYfCDWog5q2ZN05F0JpIRVeVgBZAlVflY3GWw7090o4LtifnNfB3D?=
 =?us-ascii?Q?xlqRxjFWRNZO4Wh2XAuNwSrLXQyyKlwNpWrXshc+FH+1SN6Zk9YKgWCuXHfJ?=
 =?us-ascii?Q?HkroGsimR5aq/x0+WuOhBO5lw9lv2J+Kc4ARaLe76S7pq7wovlmgE4biPs/C?=
 =?us-ascii?Q?2EgNyynuPmsVU8an+jADpKKoUNnddo+prIxsCeem3u/vFBaR7rMucyC2pXPi?=
 =?us-ascii?Q?vuS4OPmoQXTVdF5lH1E8QAuL82x1ektbLMduGt+Ssba937pi9nHUKogCNiHI?=
 =?us-ascii?Q?LBlPeULR56uUSv/sHcEhOVAIG+3A2Y4EaM1u+ObTXXY+1IPhdWBieoBmsM/8?=
 =?us-ascii?Q?Tv4U+AVNsVfli5LF3G0v9S405ade9a5KWs5Ok/rGONTxEpDUvBu/cfFgXkFY?=
 =?us-ascii?Q?CHGu9LCddld2uKYiGwrsoN0t4Yi6Bj7Ot/6ca5R6l5oDiIHRkYtpU0BzoNQQ?=
 =?us-ascii?Q?w2qHdD8RgssvQ0+nWNEP8Cqn5LyGufoY2mG+lgldQy8le+/iAnfnrGDAyNs2?=
 =?us-ascii?Q?thOqbFSQk5mmyvfYiO2p3Rmi2q2hKKrZA2PFWEtea0ML2m9l8Y7Fyl81+XJ3?=
 =?us-ascii?Q?zN8DNf2gtI9TsLgiMKEiFWHLNHZBNP/2zaFiGqT+CgajFPicNg9dPJvg0hJ8?=
 =?us-ascii?Q?mFfUAM3E6XV3CpL2+C9g2E9w7MHctaxk3Iu4O0sBhCc7/aRhWd78cwdeOJgN?=
 =?us-ascii?Q?MMpsXzVm7IGGwmWj9OaDj/om6LCLX7cykygzweQTv8A29CyeYyT4askabmUG?=
 =?us-ascii?Q?gf3uOchn5P9JXpBfGPi64FuCsIbtqzmERvfG9haHHkHO/Pby8wch6wqyqy8+?=
 =?us-ascii?Q?CaWeMlLAGDtxN1cAdk4sdoQGht5mMbwUOjJcxLBx0V35UEg60omao5vpffXg?=
 =?us-ascii?Q?zSzt0QkWo/PG+vAUtEmCYqXec+g2SZxSrzkrP7JoI1ORIg5mmiOrRHYzkivY?=
 =?us-ascii?Q?ZUley4Ykddk2Iab8C/RTc/Tdk63AaJjKpTKDFo3YZPtTfj9rTDbjm46DPa8u?=
 =?us-ascii?Q?G9W54uyRuhVTWQanoFkFKj+pOGkJmgkOJ3xm6DnQYcxldNUXPHSpQZuGLc7P?=
 =?us-ascii?Q?3ss5ZAeoiX1MNiz1fj/9lvJgc7aV48dhJryjwixpQO7lEdnn0QXA+CwxdfP6?=
 =?us-ascii?Q?i5Cc3ybkvWuIE+d7i5E1yUS7dKV9HN3re41AkzGM8bClPKzq/9gjNQlf8y5H?=
 =?us-ascii?Q?1BBq/sx1BWwGUtP4XYlq1SaUChjRaMmRZRMdpSbsUgEw2iLQwPS0fOTSyMrm?=
 =?us-ascii?Q?pisDbQ3OpL6xEWijciUvk6qpK0BfVk0IXm54RELpao0hGpcmiZ95F6CF5tQi?=
 =?us-ascii?Q?/TjZ0gabdU/qUBrCx0w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1fa9cd-d712-429d-dbe4-08ddf0f6a261
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 05:47:03.2785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkF113SEK13vFFGq6RDhtrJzohYyGaN6Zjs8A3WRY2LD0fnl+Y4O8YIdKC0eeOSsAxL6gHOWT9KKX0XpjS1PNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11226

> Subject: Re: [PATCH 2/2] firmware: imx: sm-misc: Dump syslog info
>=20
> On Wed, Sep 10, 2025 at 10:28:18PM +0800, Peng Fan wrote:
> >  static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)  {
> >  	const struct scmi_handle *handle =3D sdev->handle;
> >  	struct device_node *np =3D sdev->dev.of_node;
> > +	struct dentry *scmi_imx_dentry;
> >  	u32 src_id, flags;
> >  	int ret, i, num;
> >
> > @@ -98,6 +134,12 @@ static int scmi_imx_misc_ctrl_probe(struct
> scmi_device *sdev)
> >  		}
> >  	}
> >
> > +	scmi_imx_dentry =3D debugfs_create_dir("scmi_imx", NULL);
> > +	if (!IS_ERR(scmi_imx_dentry))
> > +		debugfs_create_file("syslog", 0444, scmi_imx_dentry,
> &sdev->dev,
> > +&syslog_fops);
>=20
> You don't need the IS_ERR() check.  If debugfs_create_dir() fails then
> just pass the error pointer to debugfs_create_file(), it's fine.

Hi Dan,

Thanks for raising this. I will fix in next version.

Thanks,
Peng.

>=20
> regards,
> dan carpenter
>=20
> > +
> > +	devm_add_action_or_reset(&sdev->dev, scmi_imx_misc_put,
> > +scmi_imx_dentry);
> > +
> >  	return 0;
> >  }
> >
> >
> > --
> > 2.37.1
> >

