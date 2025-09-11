Return-Path: <linux-kernel+bounces-811376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3829EB5283D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6256A01A91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9CD2459D1;
	Thu, 11 Sep 2025 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IlKAu9JW"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2521ABAA;
	Thu, 11 Sep 2025 05:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757569587; cv=fail; b=l+T600wDb+kuEvzwt+jJo6G33spE6KWGybgt24O/3CrPkCpBrQBH1cMnLJBLXZTeezl99fQSJTu4tye1mlNKiRzDnxdYYEidcgJ07LPDZSnJKRwa+XDYMrM/H5909brxlXtnUBwSBDVRrL+SdS+CUSz970/gIrg5ONm8OGoH+w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757569587; c=relaxed/simple;
	bh=R2XXNx7WbNFxvxYIbst4hX64WvLdnfT6VL/NgMzAUEw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fow1nxM+NPz4KXPE9OIO10Af6Dw7qwpDvfq4C3njm93napS0nU/y9Cgre0H69cGrHTrx4q54NcNvMPpj+OeZFettZDSKaLcho8f1/Qb6vnx/ml0ETJUiFUL9Q1Zs2UEfdzlx6h09BRJahww4Bwb6S+2bLUgKueL1v69XPdeoHE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IlKAu9JW; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mT9hmzq0pTH9ib5DOMRL1HLjKUTaSkCuwCFY3t9XytCpi82vDN2FYTJD5rxW5gPB6Kh6zP8WCv/svrXoYXJ2ekiAv4hTICu06b+vbi6LA0Ci5VxgtbvcCnKaM0fFq1fxdaTgVDdWfThRov+yzVlFX1PKPhL4NFc9lPxrG7BSuU5bZFYT7u/uTgU8b9upeIEIZ1RuaRGGYbEQv61mlmvWe0JTfZlDJZwviIJV1/zF1DH4YRrr02Qyd1bVWFNuVPDt7DQAgZ1K06jl2cyjLiqm2qTqPf3fDyjJoyPd1OER6gy3viLuw6R6r+8KYg2gks+56MuHehfugq7Iv8lG1f6gew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8OYZME6K+eCLY0zY2Obosb6bpg9947056YyNtxziPc=;
 b=hlkhZX8of6GSyDTvXetqJvW8csAOx+SEuMp6msooGwEPw/oCn8kKOB/COYe4Zxo6iw6C33uSxu0KIizcXQWI1cVm0giETaa9zwldaTzMmlltBijhkyPojXcjFSw9V4dwUpOAZ9G38z8dk80ud2+Bk1q8jou0UaOZoIaTaN9tUVoVZKRKU8LoRq1vztnz7nU2m5NaC6uUCVsq6luts+2FIjHJHI6NKf97eWgrv02CSY7Qgl2KB1EwzDnG6ap1a5PHu3NX4QoTEf6tNjrFr+e2+bSccEYBAC0WNLrYfiF1hKfZbLO77vZkBLBsX02yPf3TQE3zkNWGPFiW4cMZRhfD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8OYZME6K+eCLY0zY2Obosb6bpg9947056YyNtxziPc=;
 b=IlKAu9JWJw28mxuI/ycqyk6CD0jup3tzUipAejb2rctJ5Jg0OYarHyvTay2cJR1JYFbS6yYf18VB92UHkRaXGBIo1hWRSfTfXhAPo4WfDx7YM4QjOTJxNwGKlEtU3r0x2E3TRzXEfaVIrhn6ZcXMBuBSqiBoElFabW8X2k/hSrtImSQZtWwAjyFs1+EnWg6VKJYXgLjodlJa0mhJO1xOywBmIxfgq9dx2eH1CJGNVhUACz6vPpq5MFjqAP2fyoachd4OmInU2IIRrV/CxfyqnBd77HXeZIKO7nBCy9cxjy1B4d56joVp6yjGfT/ubOsYrC3c5xXNn3lJtQGNuGlrsA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10592.eurprd04.prod.outlook.com (2603:10a6:800:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.10; Thu, 11 Sep
 2025 05:46:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 05:46:21 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>, Cristian
 Marussi <cristian.marussi@arm.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] firmware: arm_scmi: imx: Support getting syslog of
 MISC protocol
Thread-Topic: [PATCH 1/2] firmware: arm_scmi: imx: Support getting syslog of
 MISC protocol
Thread-Index: AQHcIl8yEPNQHrbs1kKczW7bxX1wX7SMhzoAgADxUMA=
Date: Thu, 11 Sep 2025 05:46:21 +0000
Message-ID:
 <PAXPR04MB84593DD5C537BA9E18582AA68809A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250910-sm-syslog-v1-0-5b36f8f21da6@nxp.com>
 <20250910-sm-syslog-v1-1-5b36f8f21da6@nxp.com>
 <aMGWeswjrsJDiBKJ@lizhi-Precision-Tower-5810>
In-Reply-To: <aMGWeswjrsJDiBKJ@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10592:EE_
x-ms-office365-filtering-correlation-id: b885f2e4-31a2-427b-3c23-08ddf0f68943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YP9R/E0wsoFsIjBpJymwX8aPGfKRpPd8P+tlc5xaVm1J5dDdPzi6MRoCbCa9?=
 =?us-ascii?Q?DW4jDR54uXW5GQ5kOhNL9RX9w7rjSsFx94ydEWRQ7i6o6RZiAemM+2xg8yhw?=
 =?us-ascii?Q?Fl0rOEYj79MTPaqmcuugYbGU2zgG/2UQaK5SBU9YA8XYVOpUFbZ18TzpU0qE?=
 =?us-ascii?Q?9ddI/LZjNgIgsMY5cLtXYb8trW3OD6YnAG98xy+Uz7uRCCkomYG6Ow+TcwNf?=
 =?us-ascii?Q?T1ma8wAwsDLPV06LcIkP8Y1v8h0wvLmz+Qkaisq13/eFvyq6CsvS46v+2UCa?=
 =?us-ascii?Q?UWuzShSg7dgetCA3uD4/zfoVRRu9sIPYfHASi3eNXLWhNI14YhQFKVFYtSPI?=
 =?us-ascii?Q?un/uV0yEcNWfrfUV6/0SbE1cF4ZWka5wdgNwKyx3txiWAaFcFQD9A6t42EqH?=
 =?us-ascii?Q?IsMzKGI3vve03iin+aAiP3kTyfSMnGX/xEYkENIJFvFHAxZCizwkJNAgzHaF?=
 =?us-ascii?Q?bcyArZWsXWyLlTW0l94KhjETDX2gTATb4GhiL2FQJOOX0oo+I6WAfqAIrED2?=
 =?us-ascii?Q?VnoPjcIwyORSS3NosZfUiJjfWNsQkyvdhWVcQHKOVWN3jfPGKNLSaJCmPRof?=
 =?us-ascii?Q?nQkRCBZzfItxoantKD8bvZliR1crsN0ILNRiNAm7tCX2vC2chvYUI3GZOAZT?=
 =?us-ascii?Q?nHoclxj6ej0FndpJ6/hhok9N36cDzvNIULY3YpqcKSYBRj6WevbUiaK40t6E?=
 =?us-ascii?Q?hubtqgPRkkxlR3muJyU8nzD/MJ4nK96Hsw1JuF8pky8e5QUJueqLaiTVCsQO?=
 =?us-ascii?Q?7KlyROGdbs5XhAnBKEhhPiiyOVmcLhAlcOUood2+IbL4dQ0t98L1pRq1WF05?=
 =?us-ascii?Q?M2A5xlHq4a3HeOly6wJjdH8wIs7tQvCymX5nPiD4jogw37mS+5UiM7pJprRL?=
 =?us-ascii?Q?7CrrFrRZ4ywUWTCMH52RPWsP4SkrYrouYwV9beHmgkd0tCJ+iFUaQwWqfuAX?=
 =?us-ascii?Q?WQmjqLdXnSFApynM7OtNUUtpYuZzqt7m2oGfPEEe/avesX/A3sMyoGagtr5w?=
 =?us-ascii?Q?zJMbB3IMAKPb+Q0ttTp8UZQ24Tap0HJZAqSeTY4SToOMAaff/m2L77KLwbLZ?=
 =?us-ascii?Q?+5ICdH5MADmjuWqAjUg8cKdFVrdOp0OVB4n4NqyNaU+sGrRbDkCVk63XUzTg?=
 =?us-ascii?Q?4YRJqi7isHk1HluIVnpqfkIwv+KUGJI/j0Unaz5mPMDSixJQp7aSmr88Jf9E?=
 =?us-ascii?Q?xGjW491bqqviST8iWuX6rmbYudN5jLZQ7jr6uNVMT7wJirhjTkVMpSA0+fqC?=
 =?us-ascii?Q?mF8J8CGAMsjeimGymMEt6/OfYtxbYACdCEqHbr3RZPUN4LG0nxJregX2a0n0?=
 =?us-ascii?Q?nQ42CzSArZwk/v8ptVYtzVzg5YEt5MvNj161GMC+dN1iH2SOy9H+egnWX63b?=
 =?us-ascii?Q?pVwFgOK9eGJG3bQjnIe0uBw+zyuL3qGWyz7sSpSxFziJ2+INjCtEtaKFc7NN?=
 =?us-ascii?Q?TBog3dhjG/Kta4k0SASwW28j9WqLjQ0MPdTHghJ0Lv2sZwMPloSP+Dsla8rx?=
 =?us-ascii?Q?mHDlZ45sMf8Cy9M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?68dSLkLzmVRERXgj5b5oebo+p+X86r4nK7+ZE/pvITxdAfxMLYoLdXpuVKr5?=
 =?us-ascii?Q?NlSASie5Z41nClGhBsI9CR3o75BfgaLbm8RdhGKihmm4lyARol8v9ZKpvLpb?=
 =?us-ascii?Q?YkLKZlNp7uK8JL4yfSGVLtauR/I9LFvWgz7iRN6lQ/ZWeH6jfaRze/Joq50h?=
 =?us-ascii?Q?MXDsdcbMRogpRIj0Jykosfy2ffW+sj/g9Mc/heKD8W5xb28hNJqh1SD2VDmP?=
 =?us-ascii?Q?2EmlUdmxFnwg1nHnXJnE29TxCseMNYp4gU3xLdbLkedp1eqC4nW3ysO4ZlvP?=
 =?us-ascii?Q?AZWdaCDDyM3aJqnByvIQvv0ML/4T1IDBhb38CbBshxXOGEzTI3bs7N3ekmX3?=
 =?us-ascii?Q?VqI06xVYoIOjrxDOvSpSNXGbsevxUfEr2zJynxqTz2Lug2lAN9IJ/YER1GmY?=
 =?us-ascii?Q?88tY1/jt/cFwt2mHf26DB/e/1IoeO2qHSh9pGgWslaCl5xY8v0pH4rWXdVHt?=
 =?us-ascii?Q?n7YFrNxKycNIXCWAs4rSaAbdabJbabxfRJyyknJK+laPVitsfDH8KiOabve+?=
 =?us-ascii?Q?6vVKrCCYw+fDAfAJrzxRkpFt66pkxpG2ijQKOtjSaQa/ae7Wvp+xLleSrlpC?=
 =?us-ascii?Q?5J8Y/Y6vpYQsNjTVX3VJ9vbrmIznrIbeT10KHSHuJn2JY5yUXdkT53N+KfZb?=
 =?us-ascii?Q?CSckLGjb8pAJYSmoLYN2iGouLj5FzBP807srJ/YHoRZGwCyCqa2S+xt6IMHR?=
 =?us-ascii?Q?k+zsRmIbHw6hjmUmzns4vAqrprpUcaZcPWQ9F5VE4F3MMuzU+wxL0crfOJ3t?=
 =?us-ascii?Q?5v7bVaBD+Gwj27mlPReQal/0swWkbI2LCAb4tYHy4YQ2fpOQYWYRfdnugbaL?=
 =?us-ascii?Q?MabJErtUIYBqeCWHfDghMmGMpK/xb5bxqs8XdNOzaJvS6EUTnMlG5q8Cied3?=
 =?us-ascii?Q?2rKi8lFM9ADZpdQDgUC7qIg0tHCCazADCSp6rQ4CNO7tJGfyl9Lj+q3h+cy8?=
 =?us-ascii?Q?NK+TUuvMxPzAH9xs4NtawubsK2wirwi0UEHCbeLM6NBRcMvWrbray8Lwr4HJ?=
 =?us-ascii?Q?QP6wKwu20yGVqgNKR9LJLgcB4W05uOoFICwpSkOxiVB4Ekm9mWfhKCHZgnnU?=
 =?us-ascii?Q?5KTXk4n+/mFVEWaX9UWxlBL0wXdWHQP7YQdBk4Fj2YcN49COalNGnfG4xSLL?=
 =?us-ascii?Q?RUmvUYz+N38T75TWV1j35pPjfzCVcyeF9i5aQ5vw0l6eMGzZnwTZwmFs2TZ2?=
 =?us-ascii?Q?CeTFaOfgf+RsIdyKL82at6Ka+cGENOMrCsNwPM6CRzh3V6uvLwUFejWHCylU?=
 =?us-ascii?Q?nr8BAk1IAmYid7dT9ldBrear5ZxdL8pCkLLVcFo+jyzkUpMWPaVK2RZM72K0?=
 =?us-ascii?Q?ETWr84h+/bDrJNY6mia2O9ZV3HQTBxhyguleH2beRgp8nwf27PNpUafegKWI?=
 =?us-ascii?Q?QBkwOySNijmtBNSqA/cV/THPq9O5GulxyV48A3sxObRuiOVSiEDxpv0UTV3b?=
 =?us-ascii?Q?3oY6cLrSyZBPP/J2T3XLvUS+heYKnl9h91rLoBFgr+gKNTBOZn7yblJqndUi?=
 =?us-ascii?Q?wQGhJaVAfmYGfEcdQCXEAmLa0qd4knIjfgRVk7MtK9LW80h3dW12DUsYHloS?=
 =?us-ascii?Q?/6ZOrkR+9NpAtdSXANo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b885f2e4-31a2-427b-3c23-08ddf0f68943
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 05:46:21.1364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nyzaFthxzRb5wp2dcypsdUEg9kL7dV74aptK+BpGYs9gdYcFyIslNxkg/Uz0mps8hrtXtrJWfIGlLINmZ+Vg+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10592

> Subject: Re: [PATCH 1/2] firmware: arm_scmi: imx: Support getting
> syslog of MISC protocol
[...]=20
> > +{
> > +	struct scmi_iterator_ops ops =3D {
> > +		.prepare_message =3D
> iter_misc_syslog_prepare_message,
> > +		.update_state =3D iter_misc_syslog_update_state,
> > +		.process_response =3D
> iter_misc_syslog_process_response,
> > +	};
>=20
> Does it need const?  looks like also need static.
>=20

Current drivers/firmware/arm_scmi/drivers not use const
for this. Changes it to const will trigger build warning as I understand.

And many other places also not declare it as const, such as
pinctrl/perf/sensor.

We could take your suggestion as an improvement in a future
patch to convert them all to const.

I am not sure whether we need static for this.

Sudeep, Cristian,

Do you expect me to convert all the ops to const in this
patchset or could we defer to a future patch?

Thanks,
Peng.

> Frank
> > +	struct scmi_imx_misc_syslog_ipriv ipriv =3D {
> > +		.array =3D array,
> > +		.size =3D size,
> > +	};
> > +	void *iter;
> > +
> > +	if (!array || !size || !*size)
> > +		return -EINVAL;
> > +
> > +	iter =3D ph->hops->iter_response_init(ph, &ops, *size,
> SCMI_IMX_MISC_SYSLOG_GET,
> > +					    sizeof(struct
> scmi_imx_misc_syslog_in),
> > +					    &ipriv);
> > +	if (IS_ERR(iter))
> > +		return PTR_ERR(iter);
> > +
> > +	/* If firmware return NOT SUPPORTED, propagate value to
> caller */
> > +	return ph->hops->iter_response_run(iter);
> > +}
> > +
> >  static const struct scmi_imx_misc_proto_ops
> scmi_imx_misc_proto_ops =3D {
> >  	.misc_ctrl_set =3D scmi_imx_misc_ctrl_set,
> >  	.misc_ctrl_get =3D scmi_imx_misc_ctrl_get,
> >  	.misc_ctrl_req_notify =3D scmi_imx_misc_ctrl_notify,
> > +	.misc_syslog =3D scmi_imx_misc_syslog_get,
> >  };
> >
> >  static int scmi_imx_misc_protocol_init(const struct
> > scmi_protocol_handle *ph) diff --git
> > a/include/linux/scmi_imx_protocol.h
> > b/include/linux/scmi_imx_protocol.h
> > index
> >
> 27bd372cbfb142b6acb0b1cf4b82f061529d0d45..2407d7693b6ba130
> 3e07629e45e2
> > a7eaaa906fd3 100644
> > --- a/include/linux/scmi_imx_protocol.h
> > +++ b/include/linux/scmi_imx_protocol.h
> > @@ -59,6 +59,8 @@ struct scmi_imx_misc_proto_ops {
> >  			     u32 *num, u32 *val);
> >  	int (*misc_ctrl_req_notify)(const struct scmi_protocol_handle
> *ph,
> >  				    u32 ctrl_id, u32 evt_id, u32 flags);
> > +	int (*misc_syslog)(const struct scmi_protocol_handle *ph, u16
> *size,
> > +			   void *array);
> >  };
> >
> >  /* See LMM_ATTRIBUTES in imx95.rst */
> >
> > --
> > 2.37.1
> >

