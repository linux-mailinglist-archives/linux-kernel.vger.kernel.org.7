Return-Path: <linux-kernel+bounces-720753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBD1AFC008
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC261AA5F34
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5D11E5B60;
	Tue,  8 Jul 2025 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jq1qZi9g"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3F1F4626;
	Tue,  8 Jul 2025 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938341; cv=fail; b=foqXL5VQxbgvfFafRxJucoAinnu6azhPgy4h4weBy4AJHk6axy3nkFrnC7ouSoEAvacS1VIrwiG3iuu8reiC6gTggxKXxttTv3ZjOIOXQt5H6tWkJlZJVIOhMW1ymiZRRw/u3y/FrsnCjZdImvdN96ip45NuwtyaY/9x1J7DmWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938341; c=relaxed/simple;
	bh=x5LPT8UWB9tTFJcdtuYmBb/t5R/j9rjF3nymmU4j++k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mZ8Acrz1crKbK/5j4205skbtDdEaQn2aiv/WaQD/i1wfmHDH1wbbIaSj8gmDlz98+4roZToKFGxgoLdqNUlS8xsNkCX3K/897OPfET8VtYruj1PXBIae3B631mSADNeY6QuYGKM88bDZoHRwu9vL2SHFQitrFNJr+BmYevzWVcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jq1qZi9g; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/LopT/YqYvRB2lhwdls2MsN/CC21LXKNaRwrPN6r3l+YhCzGM3qHE3wFfGyJg+c9x6AYLNstWQznSqc6hmQ4MUdoJCfp6485tUohKTMAN3G8PSdvbBmKEwoWN32GNF5bzbFsS9hbDcXYqxbJCYSG0NVqPQaT2wPsc8dnhKsjpfAeTcKMV6hI8P7dB2bkZLE3h+guUoJmXEfV1XrohPUpQfgstNZ0Mcs28t/EwEgxBNZfudVLci8veGIRylpJJpNqgafu/wyzjak31jzS3ggrrQTBV03WGaAh9V6sflaLhYg/q/ez7jDppnqDzgYSZYYBPyO4epQ5Cupl1+CBpbXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuiMdEsviVBcx+zi/Aexp+JkOW9emtTrDStz6/fZ+6s=;
 b=kGJDQ43ZcYZW66fYQ7BuO7Xi7VkJjiFl1yPVCenlbTkPolV/lq5mfd6afFrn0ZBcgciyHiMMNRewkr8lbRX7RVUD3Ley9Spip2xL7QUN3woM6UH2EvZIZUYolu/64oswsuHboKgcW8064MhUf/snZ9KC4grfPbR4KRaqTItYOnB0xJU5T62LPYToK6wO/3p8PMhfu3j9OtaiwtYg7AXFU865Jpi+WC9i/0IxZS7glq4VFVfXGFfTqxbOzwTLlkDDdxeVb5WVf0hShYJIb2A8brJldOgNqzvLDyUgh25V0TEMyrB+ziyr1Vhch2foKl6aEods50/VCnumyxFbrKnksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuiMdEsviVBcx+zi/Aexp+JkOW9emtTrDStz6/fZ+6s=;
 b=jq1qZi9gbMtueyISrbmpHIMjyfEN78ih9c3neelvWrJlU7ENvUJ0JCSkz0p3EZzvr7eXLxLU6xEc2p/97f0rFLnuTeblpMRE10wsnZA6iHDGa40+UJn5xt+xF8cOsVP3VMtiB9qVY2d1hYk9yJILLxeflKo2WxAF4+LsYxt03mQC7DbCLT8IJleqpmYzviciFkf3R0YHnBUQa6XNy69wh6efDPvwVx3JeGasviRnINnTcj+XV7xhjTncb+KIfm7j6pqrKoUHy9WJol9Vbm5a4FLrTuSrj11aJSL9lRJ5n9m2jQnR/3vqvZr0U9MnQqyGnBr30v7kK5JJb1keOfWTqQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB4PR04MB11278.eurprd04.prod.outlook.com (2603:10a6:10:5e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 01:32:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 01:32:15 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: Cristian Marussi <cristian.marussi@arm.com>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ranjani Vaidyanathan
	<ranjani.vaidyanathan@nxp.com>, Chuck Cannon <chuck.cannon@nxp.com>
Subject: RE: [PATCH v2 1/2] firmware: arm_scmi: bus: Add pm ops
Thread-Topic: [PATCH v2 1/2] firmware: arm_scmi: bus: Add pm ops
Thread-Index: AQHb7JFbd+/WkoGZcUSJYBRO+mWNY7QmipaAgADsFkA=
Date: Tue, 8 Jul 2025 01:32:15 +0000
Message-ID:
 <PAXPR04MB8459B53FEFB119A446473268884EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250704-scmi-pm-v2-0-9316cec2f9cc@nxp.com>
 <20250704-scmi-pm-v2-1-9316cec2f9cc@nxp.com>
 <20250707-rich-helpful-guppy-c5ea68@sudeepholla>
In-Reply-To: <20250707-rich-helpful-guppy-c5ea68@sudeepholla>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB4PR04MB11278:EE_
x-ms-office365-filtering-correlation-id: 9ddcb1da-e3c0-4a6c-18c6-08ddbdbf4579
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y26bDHa94O9vR/1+KuLd6B1cQPUaUEbAXdTNGtEDlAYIgjhVbVZpXbIOZnVX?=
 =?us-ascii?Q?ZLfZDq0HXtPOc1Gq1bhrcvAVt6LR26VIeY4j3/o5OB5UHbiResLyYku3FPc4?=
 =?us-ascii?Q?vSJjoSes+bPq7FFI4yt3zWMTzMhlXax7xQvwXf5iWiyuw0TuibPPqXpGTBXl?=
 =?us-ascii?Q?jXc9vQsRPexb/ymY4Vx57Nn7Xd02FNcP8rZR980jmVq3DF9ef7kzjyoYpdnR?=
 =?us-ascii?Q?WKIEnmQ7WX+3c2y/aUMNhHJFz65g1m7FfOfXThv5CHiT60/2RFVLvIZEt80I?=
 =?us-ascii?Q?55t43DFJtlTRRyFFDglLXzfE+cO3w045aBdfixWBurlyjAHJ51dXSsR9donT?=
 =?us-ascii?Q?4u9lWeqShvEInWPs+BCHcQn+j+OHqUJAGbgT5KElgr9WWWv7p47eQdE47PHH?=
 =?us-ascii?Q?OAaIE7nseI8Bsp6Y3gYaouIrlB5iKfgEP5RDUJIJ3KYpyB6f8EO14+DIA8RM?=
 =?us-ascii?Q?1SbGN6etcSXEn9+LU/YKASDxAZMYc+L38IA3sADTv9K1vgy1y0jPBhWQAvQF?=
 =?us-ascii?Q?lLH+FRrW0Oxa86jn514P2U69z5VSWg0xkW15hGkaopYhYB5PxQQYzLxMImQS?=
 =?us-ascii?Q?DjeQEao5IAL6gyAwxujDi0sU0gn5nBF9C+SIQoGA2aTUzPteOzbiqRPJjvom?=
 =?us-ascii?Q?WT2rndydu1E11A+yEBaDNMtyzsM8DoF2AQIDvlrZgHbOVzn4q30wSx8jla9r?=
 =?us-ascii?Q?QCu/8UMZjAxsIQ2bvpkiMmqNBsAaf70H0oz49bQL1GlfgUMff7xBxWKZ16CP?=
 =?us-ascii?Q?jG0BT26T8uiR5oEczyV0LbqxOM8iNwpDHhYeKgCyawtUmjmiFANcVqX5PTrA?=
 =?us-ascii?Q?U5wou/E40wUe6IZjs9n3OtKPQgMYbhDOZ9YczUWp51IcYB762UJ+VTIgwqBw?=
 =?us-ascii?Q?Ki+7NbhWZ+sXq+cvVsJeNWrIoOLtrXtjiGn9l7jOPm/F2WGkMjq18jU1Q4OR?=
 =?us-ascii?Q?kg3+51ny0cJJZvVQZaBYYK8zXMYlttSiriigLt0ch9v5Ef5GORP6xq0aVR56?=
 =?us-ascii?Q?lByuo/tcl9ZBAJzeuEnFOZGYuW3a+CXys5viM5E1IzMirpfAtLRL6UyupK6K?=
 =?us-ascii?Q?xySiS7ryrIA9MT5f5e3hazSqMNxQE5zJyT+FAK7XUFAQtabeUKUbKEUoNQu6?=
 =?us-ascii?Q?TgrbiE4uR0DXrMtZapoklxlKUWsA0lAyb5QNw8sfxwtJnVfHK5fwlNeAVVkP?=
 =?us-ascii?Q?9o7A1Hjw8/xBywEOh3eQgKf7/Vpc/hj2Ox8/1oJS56OelT8sWmNL7yGDcQah?=
 =?us-ascii?Q?HHLZthnaKUJBqhDGAxYXwM1/9wtaMDboWM8HctpmKhzwH1A9rHGvo+8P8JcS?=
 =?us-ascii?Q?KD6Ru0GHcYfvoC26o8fT3u+M0pCgY9gqFU0kgaPakswFOCsSvUy1kW2ZrNOf?=
 =?us-ascii?Q?vs+TeiRVx7X3K+k14pkpu6GFn8+6WorpGz4k80bo5gPS+xYtTpY1siVNb5+3?=
 =?us-ascii?Q?mekc2sr9LNNMlU3ut2RIeCqBZtkdysF/VQ+ONoD9VhxouX8HJhxtfg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z6nY5x6TEDW4IFR7gxxqdV2hq75ZGnqwmrDAYXKHag6dGAqAoaw/oQjxDLKe?=
 =?us-ascii?Q?n6V10yRFQ5C0jIiL9TAaz24CX+ZZZFK2zO6QiNNVjMxDDFeKTo5mmt4TLF4j?=
 =?us-ascii?Q?wvfG7OTTwpnniek7Yu+2JyYjW3sGbrTEm22Om2C5fcvOvg1EhPSwGBQDBplV?=
 =?us-ascii?Q?PMGdFAlOCyO6QkgZ7lXSdPcHfw/wRSERxItD9ojDomhn+arhS/laG1pBmw/X?=
 =?us-ascii?Q?swTAn9U+PYdYm+5hJHP/4zfGbAj2ejwfTkCGRo5yHDEwqCXeCuysBfWBhGWP?=
 =?us-ascii?Q?QmiDBpUkgS2yTE8cxObcC9rcVhjtEe2zsnwLOBB2sSwdcuLawLapGoSpyPme?=
 =?us-ascii?Q?Cca+toxnoTfq5bjHUXmjQaCC2OHNyCxX6RadZqmeDB6BUP3nXFjYMFuv8Yz/?=
 =?us-ascii?Q?8wOO1/4CmHE1w1I7JyGrgT3rBgnxVMycerangARIb2+GC00esKg/ryv3lxib?=
 =?us-ascii?Q?jrsKWNnhdBsllqbRAtrpf2SGdCuoCYdvCGwJB/tvZHyO/SwLNrpBOiZSLBDD?=
 =?us-ascii?Q?tbXiUClpr2x7BgMMgyP3QV4AEnspiMZlnyfFS3Hlym8F4vsWliVercNZEpNK?=
 =?us-ascii?Q?1EgJIjFbI+4e6XdDp4T+k210vNKX3ioIaMSv03NEQNO1nR3Qf1L7Hlzc8QNq?=
 =?us-ascii?Q?s9zSCNlS6gpmQhUoy0UCMIeb1Y21J3GUwHJ8C2Pe6zEmYXlFROGNwRuEuNE0?=
 =?us-ascii?Q?WUip8XyZIlbecEGEauWXyn+ErkZJhetX9vFCvgEa/HSTblLKCG+0sQuyj/9T?=
 =?us-ascii?Q?v4w7iCdDUQEfKXdjBQc5qs8XJevVCr9clo5abu8kOLaYLCRtZbScGhFVKeBF?=
 =?us-ascii?Q?J1eZdppArc+QWg8WVB4b4f0tHxJrob5J+26/IHdW8EKkXwvwY0U28N9ywVxZ?=
 =?us-ascii?Q?2oSt43u7mn19hkWs62cmVzD+IErSHzbRSujtx3W51zalN9iTFEobhbHJ/jP7?=
 =?us-ascii?Q?gcQ21nEamh9xhb//4tz1ZKccX3ZSdWszBEisQko6KyDAoiAq2V+Loi7EVcGe?=
 =?us-ascii?Q?kVz5hAoM5Luo2nv2gzZbqoFysmIk46t8ODjnpUxuZjPN4Ao+vSQQuzxyjqRN?=
 =?us-ascii?Q?qMRPIgLhvgikCbneKEFy8FYw/LNSBPd6TC2mVf7SgEZDHjA0npHt3S1Uc2LY?=
 =?us-ascii?Q?k05t8GGESM9EyYO/ymRnGVN6IbMMe47tHKf1MgnWdkAhVQcPuAAaIImiWtGM?=
 =?us-ascii?Q?E5ok5Zyp8dRfvEjYnnqzQuWfgY2CoXepX6f9bS2xCjaVH7XLkTfpa1rxUpG4?=
 =?us-ascii?Q?ToNUcRHCXKVOyR3i3W3Rn2Z8QqtMFXQD5IaPEmgyVUuQahTuUxnOKzEEjni3?=
 =?us-ascii?Q?MaMeaM0uyNxuuTC0YD0NMyfscxWjZH+qVxvthb8IHqsFfnYCaHzx+u96fRMk?=
 =?us-ascii?Q?2Izxa4BKAQHjqMIEyyPKEFilFwuEtvlcsQTyjqQ8aC48O0H/ReiqPko8Qw2j?=
 =?us-ascii?Q?1Z02GQ931r9ik2GLs2M8fQvkFf1T9lENOPvPyVWwj9iLpEkz7mBh7IhmfllQ?=
 =?us-ascii?Q?9RVRGAZNfmVW93U7AllWcEIZ4f7oAQCAYP/zrf+rjtNZpQJI5diePZJFk7o8?=
 =?us-ascii?Q?E4eybgfIQFwuuvTkXzc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddcb1da-e3c0-4a6c-18c6-08ddbdbf4579
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 01:32:15.8165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VWP/PNwPAkFw0RnZKXJgQqx8FVYToBsHZoH9oeyITxztYzgxVP1n5oncDYeBMQohyP1zGQJRGaJbQyuOwjCUTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR04MB11278

> Subject: Re: [PATCH v2 1/2] firmware: arm_scmi: bus: Add pm ops
>=20
> On Fri, Jul 04, 2025 at 11:09:35AM +0800, Peng Fan wrote:
> > Take platform_pm_ops as reference. Add pm ops for scmi_bus_type,
> then
> > the scmi devices under scmi bus could have their own hooks for
> > suspend, resume function.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/firmware/arm_scmi/bus.c | 33
> > +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/drivers/firmware/arm_scmi/bus.c
> > b/drivers/firmware/arm_scmi/bus.c index
> >
> 1adef03894751dae9bb752b8c7f86e5d01c5d4fd..b6ade837ecea34f14
> 7fc1b734c55
> > eafecca5ae0c 100644
> > --- a/drivers/firmware/arm_scmi/bus.c
> > +++ b/drivers/firmware/arm_scmi/bus.c
> > @@ -323,6 +323,38 @@ static struct attribute
> > *scmi_device_attributes_attrs[] =3D {  };
> > ATTRIBUTE_GROUPS(scmi_device_attributes);
> >
> > +#ifdef CONFIG_SUSPEND
> > +static int scmi_pm_suspend(struct device *dev) {
> > +	const struct device_driver *drv =3D dev->driver;
> > +
> > +	if (drv && drv->pm && drv->pm->suspend)
> > +		return drv->pm->suspend(dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_pm_resume(struct device *dev) {
> > +	const struct device_driver *drv =3D dev->driver;
> > +
> > +	if (drv && drv->pm && drv->pm->resume)
> > +		return drv->pm->resume(dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops scmi_dev_pm_ops =3D {
> > +	.suspend =3D scmi_pm_suspend,
>=20
> I have use pm_sleep_ptr() and removed the below NULL based struct.
> Have a look at for-next/scmi/updates and let me know if you are happy
> with that.

Thanks for the cleanup. Seems kernel build bot report a failure, not
sure related to this macro or else, I am still trying to see what happens.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep


