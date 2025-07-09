Return-Path: <linux-kernel+bounces-722931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB820AFE0CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA49F1AA2E11
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E7B26E6E2;
	Wed,  9 Jul 2025 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kjI1S40L"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6021ABAC;
	Wed,  9 Jul 2025 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044696; cv=fail; b=PFBn9JuEJyXon59qSZqFeJiRwoPcQvEc5TT6rF5sd+bbxhrVw29oQYpd/80LDRdLqPqfHXamqe0U0+F97zs4YMb50zCR9yrGUavsKEKWQJVUes+mu1GwlrgWqOcbZ6CRSg1+Oz6z7ajaAH6mB1FD426jGJBZG83/wqEuNO8lKrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044696; c=relaxed/simple;
	bh=euuZhXzeSaxBjnDrP8k4EJekdNYhfq3JYIeis8B5/nM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NuWJRMpt2OJ9o1MWqKNRsz3+Ss8811q0y0/gZ9HjfdBqYCZKpRkEdvkXbnX5KKUJuhMgWhuczwc6EEY9TDNJQnd23PDrvfd+gmlkJO/aOtZFhYHlg1GrzyrRTwiHxzDEPSs1iXE/omC5z5LHPN0XlPxsNO82N2rQ9i+MXXs2MOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kjI1S40L; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRO7nmpe9u1r+MTX1D9RyOYf9gdGHia2sNhx9xwqSO+j7gFDy1O+5ycFr5e797iv6omVrwiVAZupsBGDkVAIzIXuLKixDmnMY9UgkijfEkSBIXdl2/9VZLJ9b9hz4UwVwxDPQZjzb1VR/vwIca77PwHgba8hYsVjsBTRMVEOdBezfPPnCLsn6hGz753yw+zcvjxGxW067EPjn/qz3sb/1O10WEiDJeYlIxOELGg3tL4tN6T+2uJ1yPksKJULggOmuw6jAostga2+vZ0CN5Bc1TuIdBR7cAysCORoXIgJYHPNdtJXSgiMRlfh1FTjF2Umd2Y7AA3hk9EfXF4xo42hMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcUdVf2DGJb0xtvWVtoirZ0nWkXYpxkrvPvsX6rSWgQ=;
 b=KbJTJo/KPfCnL5eoT8gOrIHtEw4MOJQLXAJMi04u4u75FT/os3oSckWQBsAc6QXdFyvaaY786TkPM3Jhq1DdYIlDcewt0UgBFLjGv+YsnFhQCA7pL1blfy+y+I4lBSNCbyRF/+zuN53V83e9W8Ue1ccwKmo6MdVQQCR/oUoAYw2RF+RN3mQRUAT6FtdZx7KVQCxtrku+i3cau4n+oHy8Hw5Sv5/D4XXpGFmT8GpHnRwgTMpnCX9MPR5MJjr2Vb2BAVmiD1NIMmp2xBVrfWcALNYHwkW6u331KvPd6JNORelz3Dkif8OsNcmS7tr8uonV+Oxb3xvILC2pczc+nOgHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcUdVf2DGJb0xtvWVtoirZ0nWkXYpxkrvPvsX6rSWgQ=;
 b=kjI1S40LE3YyHinKikYzqUYPlevJkyATgYlI5e4ieI2JzMq4QxWF9Z2iDt150cVkeLf6g1P0jag3VMkhfazFmyRfE4kqao+ABOxDV7d6FckNPcL1DbsLr+xD90+IUfUy/FzRUa2Silqzm1CDNj0xvSczbX7KjKlZByJAbxTyPEuhrO+qPYCnbGt2Nwndwg9cpy7M3t+xBEJ+CgGwdxQzzYUpap5oTsIHVDeh+mn4Rm/0Sd0UF6JsTyDPxycqc/JGcdXUSkBjyxtXa/b+rayZuaYg9sGkI029gMUlbdO9By8NMy9YAsjSovxwnp7x4JlOwz17K2BIwDbSc1KArfnF5w==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9310.eurprd04.prod.outlook.com (2603:10a6:20b:4de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 07:04:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 07:04:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Nathan Chancellor <nathan@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Cristian Marussi
	<cristian.marussi@arm.com>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] firmware: arm_scmi: convert to SYSTEM_SLEEP_PM_OPS
Thread-Topic: [PATCH] firmware: arm_scmi: convert to SYSTEM_SLEEP_PM_OPS
Thread-Index: AQHb8J9DPhR5QrLGOkWpN0R1YnII9rQpXaOQ
Date: Wed, 9 Jul 2025 07:04:49 +0000
Message-ID:
 <PAXPR04MB845996327A0D0D85A1A93E8F8849A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250709070107.1388512-1-arnd@kernel.org>
In-Reply-To: <20250709070107.1388512-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS1PR04MB9310:EE_
x-ms-office365-filtering-correlation-id: 204d1ef0-f2ac-4619-881e-08ddbeb6e56d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OfRgCHr55bhID/kitaZxVueP7f+wXAsj3XGqxx7L0wiWDQ/Cm6O6xPVBmMlC?=
 =?us-ascii?Q?Mtyelc66cuGKj+Hcsp7Vy0DU54TPl1vCKnyh6EjkPrXk+r3OuK5wzWsPmLIo?=
 =?us-ascii?Q?+rv5B0MKyp9683ZsilQFVJ8+qCJTi1RBMMJspzNzVDX3IkDraoyvPmqCr5uz?=
 =?us-ascii?Q?sutX20JrhCgH+2dSx3bjbxPFnWiTYz2L6/124UMcPagIRIJ2KNxFto0U+zjo?=
 =?us-ascii?Q?NdQnjxPKfJEJbjNJyK04wTkYG+rpMND1povpR81MnRNfoeeTCdJwgGwHSdTu?=
 =?us-ascii?Q?YWmVYIb8xN4wN0/TabqD+Tmj5a/STRwIC8vq/RKhBq81Vyy5iRUy9EBGMipB?=
 =?us-ascii?Q?/ebkLjthTusuV1DXrhMmFW8x414BHwrZhYUjTyBwnHlrt8yCL+49Symu2EqE?=
 =?us-ascii?Q?CodDl0YN0AZe7YVSRxQX7+VjUBJj78nDMw1xr4RIuHwttCZpgAbgXmIsrdH5?=
 =?us-ascii?Q?WeMDcEm6SgQeexOWussAgpxlQG9rfgefygEiQgpv6AWBzSgyPgdIlhED54jo?=
 =?us-ascii?Q?5wtv15wNVGtI6NxCOoy+U71yPtIFi75QwLiML354HInX2HMJzIjsVoatuENX?=
 =?us-ascii?Q?n9e9CBu47aExU4Ffvvh++FbU+gzZmOZ32eBFo5MXYoPVnl1NOPVlJSnfGouX?=
 =?us-ascii?Q?onetbDzRPiVpkDYDo+Z85GF4t77NdaFAuSwjBB3nSzzLAJ+80Yrd6ie+BuYE?=
 =?us-ascii?Q?LlSiCC1r14lPeHj87HWEjzszoQOpQfcsJsgHbAFHO/QGevOkDiyy4/H5rpFD?=
 =?us-ascii?Q?w5fsG1N1UAoM/rhtHEliQ1ZwyRLIiPxXLpNSdmYkgy+uGG4XHDEDuG97Qt8P?=
 =?us-ascii?Q?AdsgfL7++ayrtIEGBPSy/rzgiTkCmFsGxv9h0uIJ3QrN+e0C4hb14Cbv59g4?=
 =?us-ascii?Q?iBGsvbLMjTCBFenACBiNKixm9rKEK6KBB8btBmdjNI9p14EStBWS7Yl5FFwD?=
 =?us-ascii?Q?ZmjCFrefJiLxXLf3GwG1HOTiAuoA/1jn4nwafpKYBk0TlBFSPIXhl97dGGN2?=
 =?us-ascii?Q?EsHOuCC4Mx4I4NacAmKxA1uuzQ3N2n0M+tE48NWp/bOA3ixktRqfZ+EEnRde?=
 =?us-ascii?Q?HJP8uBf2ukHrjQCB7KiMY8y7LTb6Sk2o9WaXOj22rR4RBlN3BNsw+tpQFY79?=
 =?us-ascii?Q?i3BEBs5RQnHW+Jx7s5U6YkfUMKZAM8ErWjsIStTU+PQRKNtph/jw6Lfma8sI?=
 =?us-ascii?Q?seUbmQWpZ7igEscV8FramGPSLtUJvl8QxsnOKYVZvFICLQOCRksEk8CzEl9Z?=
 =?us-ascii?Q?muWEMz3vGk/E5hGqUYcJUle9ZX7hiXwbC4GrtaMBGwGK5x8TFTOsPccxnO6P?=
 =?us-ascii?Q?dcnybyUFpUp0rIdQ3PApM7oThZIJpNtbQqhEfPlgIh4gmIWvWVTF61xkP2Ci?=
 =?us-ascii?Q?myIsM2A0pGNSKvfSDb5eSDQGcG7ugPh86Nfa/zLW2hNVd76W29Zk2taKz3hK?=
 =?us-ascii?Q?aljFi9othBmoYAX0cbHfGcxZYT1MiyKQ62/qLgXd76t3Uv3VXvrlpQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OydAF2zTu0Em6fugRvCTuVocUoEzt1lvnaLwMKPSTf95u9IfuFOB8Ts7s5fH?=
 =?us-ascii?Q?Xvgie4UPxvpHlSgBAout173mbNw9guW0UXbbBdvW3/8T/LP9y9fe1esd1pWF?=
 =?us-ascii?Q?cjlaqvDm6/xUUAqQXadpx3o5Q2NPJXQdtQ/gFXiFRoYZ2IjVoVzBjDUcQ7Gx?=
 =?us-ascii?Q?cV+7MgSl3R5NcC9qWtZhW08CHEVyrMP+wquStzoHklcckrAetkUit40GqAda?=
 =?us-ascii?Q?4Ko2dL9Khk+mKwFrNmiYQ6El0qzCAF5JI7PCUSzm48x0lWf7fOPmguEjohK5?=
 =?us-ascii?Q?oivvEC1eNp3FLwwWFlKnPZUAS9QIZucIBPg2NvIdHrNvrHZ6hx5q46F2K/ZZ?=
 =?us-ascii?Q?VBmUDD+r6lTza2/IxSLUPWKLDGExVhcbXtPnV8XH46qvuK83PdkI3CtLY+5N?=
 =?us-ascii?Q?NgmEeYmX/sLkX5o1i/A1KsJsyX/mkfriyeIoq0LAjLzFc2gDzS9mdXBy+fgD?=
 =?us-ascii?Q?/xrs46kEOB3KWH1qDxHrpFu4DeCsYW+NG6uYZ6CgV6naINT/0YsnzKyB5UYr?=
 =?us-ascii?Q?4f8FcWa7RqhA8mC0qnFD7/+N9RsoJpfthPlBZ0P7C32wU4TvXJS1r8J7hvjq?=
 =?us-ascii?Q?XApxeZXEh4MxF7gsW0SK5Q+UfLW57c6S5qpI2TutQrv/Ez54hqSa4YSNsCVe?=
 =?us-ascii?Q?1H7F0jjYTsVG3x3EnnbU0bAtvPBGQiDuRQsYd6jF7gZtLbitGnhEfE7niFku?=
 =?us-ascii?Q?w3bvnRKivcl9oJjovkLzE17L0UrCPfYMuEM68az0S5D/obxV8Xn039C4XWdi?=
 =?us-ascii?Q?bEWXvBOHzZLZZZeCJB7h90dIuQBc4lpg1SFPxT5pVurZwdeFHtQoENzoOTsZ?=
 =?us-ascii?Q?QP0CVkikn8iZGaq9+enbTKCr1RNK8Fo33E7Vk95+gqcKsRjFQW+eJPpb2pbl?=
 =?us-ascii?Q?WH5dEEhZma3H4Pbxca4HJbObrnpZyvm2wCbY2pC4vZ9SSGH5l1eUPChY4qwC?=
 =?us-ascii?Q?dVmpnzkxJDYymxRRiOS1ibPqfioY7q0LGln4UKNCYxkKCIJms48Kfos8Ds3x?=
 =?us-ascii?Q?xQin1/lJyce2rX9AfZn/SdL+r68vpBQJBg8/vu3UYibD8cqbJHjIVtHZ5f9p?=
 =?us-ascii?Q?o8X8c3Dat4m4f2mgO2oHGu5ZhcC40xSFxc4IAFHTnvwjIhZ9gzyKWIZvh0pR?=
 =?us-ascii?Q?8a9h5KVrU+Xt71ln8wMv3Jc7tStQHcytsg2rJfCLQBbyFhdepYrZ8fPogu3Q?=
 =?us-ascii?Q?1rvMnmwVSVXcJA/AghqhSc5G1/mFTgG2cxFSVE9rOGXmiXPuiHEssbOnd/gY?=
 =?us-ascii?Q?Vehc+obwVwR+6kOxtSvvDb9lIXf4piV+WBf+nb7Ogj1X0J2sdl2I0qKgBoPz?=
 =?us-ascii?Q?A9cU53KwVZaf20G7N6w9XHCmhfPCR7x7r1ePpXG5OhrZ1kDJliASuetU2vFn?=
 =?us-ascii?Q?peenUjVvwSE5384OGmk973tMHwWOcucCar4FzEv2K2hhsATJeCor7qmK61Zy?=
 =?us-ascii?Q?UQAECjp64wblVzP8KHIwz+Asa0BgQb83hwt/BfYD+rHRax++2hBz9EMHl48D?=
 =?us-ascii?Q?K7BJTocr6tLMLELYl276P+DJVyclQe80ACsslJsIT7DaiK1KQAUYuunOS1c6?=
 =?us-ascii?Q?flpchbftvwlT8pCB2mk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 204d1ef0-f2ac-4619-881e-08ddbeb6e56d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 07:04:49.8386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVkKDGee8VIj38g8jrwO3czOme1VBWb7o4L27IqulUIqiH1aCooXV6lDgsMkwxtWSQz8pT7Te2QGRuViUJiQ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9310

> Subject: [PATCH] firmware: arm_scmi: convert to
> SYSTEM_SLEEP_PM_OPS
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The old SET_SYSTEM_SLEEP_PM_OPS() macro leads to a warning about
> an unused function:
>=20
> drivers/firmware/arm_scmi/scmi_power_control.c:363:12: error:
> 'scmi_system_power_resume' defined but not used [-Werror=3Dunused-
> function]
>   363 | static int scmi_system_power_resume(struct device *dev)
>=20
> The proper way to do this these days is to use
> SYSTEM_SLEEP_PM_OPS() and pm_sleep_ptr().
>=20
> Fixes: 9a0658d3991e ("firmware: arm_scmi: power_control: Ensure
> SCMI_SYSPOWER_IDLE is set early during resume")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fix. Nathan Chancellor posted a fix earlier, but
yours has pm_sleep_ptr which is better.

Acked-by: Peng Fan <peng.fan@nxp.com>=20

