Return-Path: <linux-kernel+bounces-809530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C57BB50EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0BF1BC61A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F67305E19;
	Wed, 10 Sep 2025 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WOlyJ+Jc"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E557175A5;
	Wed, 10 Sep 2025 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488064; cv=fail; b=E/qDl8jEQYaseo39xo27priq1nK3RY8v8BppUdKXWfhXaP/+aeema9a+1V2/6K3bZE446Djv6I/PdGmNTdE1B0mdbHAp8LKnZ+eLqMP5oEvkoWSOdvTOE6/Ow0Qx7xPvjj9s/I0XXVcEpjsTESLADnh3QU7c6s2OHiKh6VMKoXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488064; c=relaxed/simple;
	bh=VrbPEBjbodQYGnwvNg/ufbbNA/GeLmQpMSboaUHc8j0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nIuOeinDNwT7JsS6cknkgh/PvKmB6nLhgpK23fDQ6Qs1+m3z9xRQwxNTb6OgZ7/Cg3VyVbKMFS1FOdIfNasgXjJQr8dJu8YdJnSYL0eZJl/rQ40MPCcOg2FxpyruV/zaiXc66VDepBnvHRHbOYrN+PemygK43X7V4/oPWm9j1l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WOlyJ+Jc; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uG7gQdpnXXgD7POiH8d5DXwxblhAII4fIvTaAUU/0yFGb8GvNiSEV9KnuEqus1p0rpBxVu0ic+W6OzcdhCj0u+Y58iS1yG7+P6TQouIND+d7DAOunbHSxGCbKapE1RKCIh+hQaydjM4JbBGpfO9sxQf9QAB90poxUMvAswzdmRuoL6JibugNhkr5O29tycmWQ58Vl3O8dk+Wp7Sm7CFn8Wj5pGJDCA5wEDQmCExTZZulvfcRTf1DNUb/C6Sm+WD98qa0AHsmtHauk177EEh4oj5CSlZOq+EIxOZzmMkHti3egV+mWhg7Xh+dQ2pwMno1qDaOn+vi2bnq0dwadfAJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrbPEBjbodQYGnwvNg/ufbbNA/GeLmQpMSboaUHc8j0=;
 b=gu+LFvd+oztmhMZWUp08tXjIStwvasPhgTaf2cxSYQXB8hWE0YZ+F9vEQiYr4SJla1+JDgtsCwg6W/3ag4z1GZU5te0BMH7pY0GHvzwSe6f1a3EUAUxzQgykVS17m5CUYYBqaXHDPzvWn/a677r6uS46CdmDYV0riIF7wcbR/lL80ss4dxt7mzl5Gc+Y0wZc+evwlFAdD+swn97oNbgbbEmNBELlrAqMuw12Wp4nITqMO5QcpjGLbjMTiYQp9Uz8Gq29ytEoqZwk+yFKwRYiG4DvmtPf5z+YaKiJsp1Ybrz6V0Y7Ew19UWUv6zUoOEl744bCSOTYMsDWo3C5RY7iMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrbPEBjbodQYGnwvNg/ufbbNA/GeLmQpMSboaUHc8j0=;
 b=WOlyJ+JcWCgMjnitGY9/VpehNLDdVfoTWxvTLigWq9psy9cQTpnC7Gak0QvQeMuMWm8a/g7FJVIDOAKu9JgZE/P6EM6QV/vcdnRkK2i6NNIMFYiOQE8za505Zu4PU9WS+rDi8oiSpnNgcdhpUig29tfxqSACe2lcYD2OYWXC3pZdc16q8P4cLfdwEMKw1g7PVddWSJIyjTaMSQaEWZIxkR7PQRrZXnxn+dqVsWqNKtTYrix2LZM7eqsgo0MpUNXQ80nECnvud0Ckha0FxCK1yAUYv7Z4K31P5vMbZg/mowLJZDN8Kbn+49j8L/tfj0Jx/hdgcQgRGm/tu8rnr/R37A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9452.eurprd04.prod.outlook.com (2603:10a6:10:367::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 07:07:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 07:07:37 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, E Shattow <e@freeshell.de>
Subject: RE: [PATCH v1] dts: arm64: freescale: move imx9*-clock.h
 imx9*-power.h into dt-bindings
Thread-Topic: [PATCH v1] dts: arm64: freescale: move imx9*-clock.h
 imx9*-power.h into dt-bindings
Thread-Index:
 AQHcGrLMzJw01yb/r02Eq/dbVTFFIbR9qcaA///vfgCAABPWAIAAdHqAgAAGqYCAANPFAIADzOAAgAc1SICAAg064A==
Date: Wed, 10 Sep 2025 07:07:37 +0000
Message-ID:
 <PAXPR04MB845970863A16718967270D1A880EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250831200516.522179-1-e@freeshell.de>
 <20250901032203.GA393@nxa18884-linux.ap.freescale.net>
 <3a165d77-3e36-4c0d-a193-aa9b27e0d523@mailbox.org>
 <05f7d69a-9c05-4b47-ab04-594c37e975eb@kernel.org>
 <51daddc4-1b86-4688-98cb-ef0f041d4126@mailbox.org>
 <8920d24b-e796-4b02-b43b-8a5deed3e8fb@kernel.org>
 <be2fc937-b7a6-49a7-b57d-6e3f16f4ccc3@mailbox.org>
 <20250904093442.GA13411@nxa18884-linux.ap.freescale.net>
 <afe58aa6-0c3e-4508-8133-8e7621a0484a@mailbox.org>
In-Reply-To: <afe58aa6-0c3e-4508-8133-8e7621a0484a@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB9452:EE_
x-ms-office365-filtering-correlation-id: 273f07b5-30f6-4c3f-d243-08ddf038b95f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmIrRnk1M1l3dVkxdGtibXVmOFNwYWNSSmNwaTI3NzJWYmhOc0ZJa21SYi9W?=
 =?utf-8?B?T2t3bFpTZTZxNGd5YzRQSnNnaHlEYndITWx3ODVLK2NJWm9HY0t0c2VGZDdy?=
 =?utf-8?B?UXRPdnBJcTRURXhXWktzb0xlQTh1K2R0TERqWk1oRCtTZ1pBWVFKUTE1Ny9w?=
 =?utf-8?B?QnVWdVA2Y0hXbEd4TzN2K05PT1A2bytvdnJTV0wzQUR4SEJscTd1RW1tT0pY?=
 =?utf-8?B?QWpwdjU2UklWNVJtemVkcXRuNTJVUjVUdWYyeVRSdW4xdFRLamQ3MlZJR1Fs?=
 =?utf-8?B?aUZqREdtN0VBRDh6MTBudTU5L1E1b1VRMkdobHAxVFg0ME5QbnRxYXJSb2kr?=
 =?utf-8?B?K0FFMmN2TEJOSjkrQVBRRGl0Ty9ibVQwcDBGV1R0WFJyZUY5UFZJa29FMXYw?=
 =?utf-8?B?bzZpcEJwK2RRTnJYdmg2dktPK1IwY1MwVjQrNUJhQURpcStGVmVCMGg0Rm9p?=
 =?utf-8?B?cWQxTCszSW4vZHRKcFppMkRqdm9Mb0NvdlZYRGU3MjFsNmU5NDlDUzJnWjBm?=
 =?utf-8?B?aXlvMCtDd1NyTnprdHc0NHJIZFlIZkpUMnEvTzhEcWhTSnN0V2s2eURtZktO?=
 =?utf-8?B?YkJEQkdQeHVhNkdraDVBWkd3MkdDcjlSaEZQVlh1Tko3ZVBtTXRKVVM5Z290?=
 =?utf-8?B?ZUFrUHBsc0wxOU92NCtIZGZwU2N4TXVlT01wUUd4ejQzd2ZNOTZJMzJBRm56?=
 =?utf-8?B?dVBvaTQyT2hjZGVDaWxMTmdIODVXZzlzNHF6cnE3akxUbzNFaEtQdldTS292?=
 =?utf-8?B?WG44aVRzWmtncERCcTd4M0dOQ1NSMXl2OUpkaE5qYTMxOWFYUnM0ak8vcUhU?=
 =?utf-8?B?dXdOSzF0dmVIUitXMnFoZEVObkQ3QjBCY2dVbStFYU5rdXppVXh5UzVMKzFW?=
 =?utf-8?B?Y29STCtIUEhxVVB0eHFsTk5CZXZHSGxja0Q3ZlpZN1pYejJIY0E2TWUxQno3?=
 =?utf-8?B?cTk4WnhNV21DTlY2T3c2RTM1T05RaWZhTDZpdjNHb2FiZ3prd1M4TGRIajlT?=
 =?utf-8?B?TDJDcmxNNW50T0xkdW9hazRoV1FzOUt0UVFjc3U5VXhtM2laY3BaQm9YV1Jn?=
 =?utf-8?B?NW5lbThSYjhJbWFRdlU4RVVSUzl2N3UyNHEvVTEyZTV6VTVlMXc0ay9iTGk5?=
 =?utf-8?B?YmpvMWpxbE8zUWs1cWpjLzJGZUtJTXhNMnAzYi9GT2syZXYveGJSN1VPby9l?=
 =?utf-8?B?TXM4R242dGdkUFU4akxxSVRNZU1rNlFxWFZZRmlYcU1Bd3h6TlNUV0lVTXkw?=
 =?utf-8?B?UHcwbENZalVlL0FibS9zbXhtcndpNnRKL2tiM0FNajhneVo4YVNxd0w4WGpO?=
 =?utf-8?B?NU54UmZXaEZUSy9lSEdlcW80Y0JUNlVENm9kVlJZbVllRUdvQ1RmOUlidWVS?=
 =?utf-8?B?U1JaMnZTNHpZN085SEtCS1R6VGZhbTJFR0Q1ZmNFbGhiSGR5UlpaM2lIMC9M?=
 =?utf-8?B?NFlDZWFTMk45MHY4MzZ4aVFPTVMyeGtZN3QraW5nQk84Ym8yYmRwNUZnR0E3?=
 =?utf-8?B?TzdsYWl2SGpFM3ltSHFnYzRoOWJ6VDBZbmtzSStUWlpYc29oS0V0Q21YUjc0?=
 =?utf-8?B?dG41Zk1VdHladVIwUTh5WFd1d0V0a1VMd3AwT3JlUFNnY0hhV3JYdUlrTW1W?=
 =?utf-8?B?dWpUR3drdFBHVmw1Z2w4elpLMERmZ0RsWG5JMjU5ejI1bjIrVFc2MGhCTUlP?=
 =?utf-8?B?RWptOHJNQXFGcm9oTGRHL2N2SkI2RElqWExtSTA3bnNWYUxGTW9OMzJNN1Ny?=
 =?utf-8?B?UE05S0JzZXpUWHJyWGJrQWNjZVB5cEZ4ZEFTYmNhcmczSlhRWTBUTDBveklh?=
 =?utf-8?B?VVl5ZWtRem9YR2JLWnF5WlYrSnQvUkVtZXRYa3pYNHlXbmt2M2dDREE0Q2NS?=
 =?utf-8?B?SmgwR3pTNUVSTXNGYitldGJWNFZuVWRHYUlXYUZuV3dUdHNRcW9iTzY4TUFn?=
 =?utf-8?B?Rm43NVBzeWxpN3ZWWVpSWHlDSU9WVyt2b1hubmJHbEF1WVZCMnJsK2xheWVF?=
 =?utf-8?Q?lC746UGFZNhGtkdNLSFhlPuliOPxXY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzF6WFJ6aXBkd3JkZmJqRmNDZzQ1Nm1vcGJ6L2hKR1Q1WUFWa1FOVzRIOERF?=
 =?utf-8?B?QjNzUUZWTm50MTR0WEFYcnhhdTNrYWQ3SG9SUDVuc1lkUHVkSm16RjRDL2dw?=
 =?utf-8?B?YTl6ckx3VTNOWFRvY3lvRWc3RHZtczV6ZmcxVDY3Smk1MXFEM2V5em9PTHhH?=
 =?utf-8?B?eitLbW9kMExadTRsaHFZOCtGekc3eHdTVjZNQmFOUVcvV28vaS9aYTIxNndG?=
 =?utf-8?B?VnIzUlpHbHZEdEkrbGJkNVBteFdXWHE2eUdoalJKUUFGNWhnbDFBc2oyVzY2?=
 =?utf-8?B?MmJxQzVhS1F5VDNRK2xVZGlaRGVPbFk4VDM1enFVZ1IvZGZqZWxadVhYL29D?=
 =?utf-8?B?cG9WNHNTL1RwZVBjME5wVzNSQXErL2VsKytBcVNyc0pRdmhwMFkyZWpWUG51?=
 =?utf-8?B?c1RNbUtIa3YrUGExN0xEK2JadEkweGVWdmd5amZyZjJPVlpYcHIrc2xzMC8x?=
 =?utf-8?B?azdIU3FxaThEdU8wWWJqcEpuUE8vN1RyY2RTOGlmbzBreUdzZEhSclVydk05?=
 =?utf-8?B?SkpZeHhTL2pZdnBQK09CVHg5RXY1eHB4YnlzZjVWVnJSUzNDYmlSL3g3VVFN?=
 =?utf-8?B?eWFJWitLaE1TTjJUTGtpMUZVTkVDNEZCM3Z3UDU5eVRWOG1EcHJvVjl3UWpH?=
 =?utf-8?B?d0xUaS90ZDVUbVllOG1xYUdWNk5ETHFGTVRMQkp5L3hVdnh2TG9obXNhRFRq?=
 =?utf-8?B?UlEwVUxxdlhZSS95NjhVSjErbHl3bXBJK21tam5lekFvb1FIQkZOZTZXTGdM?=
 =?utf-8?B?Mng5eTNMTmFHa2p3cERCakhRaW9mdDZIRUhMZ3pHNXljaS9DR3Q3TEFyTVV4?=
 =?utf-8?B?OXZvTVNDMC9BakxnaEREN2RJcnp4VENqK1hDNzNFS3BCMWRwS3EwbkdIV0tS?=
 =?utf-8?B?UFIyZllycUJ1U213SWVKU0FrcmpFRXFvSm5TaVdPWHNlUmNtVWZpS3ZCU1dO?=
 =?utf-8?B?VzYxVmdBQTVzaThoZlBST3NFaTc3d2xQTmg0Nm4yYmtSMzMxaW1IckJONFlN?=
 =?utf-8?B?OStnMU15bUoyOVNweWhKZ1FUWmNpdmd3Z05TaisybllFaWxqVHdoWEFCaUZ4?=
 =?utf-8?B?elNaclNPT2paSldaNWdMeGFXYXQrWGUxSzRyRDBmMXBYL3BCdk54aEpGUFRO?=
 =?utf-8?B?bmhZMUFocUkyZEdrdkpkZzFCN0FIc24xTm82S3pERVVtcitwWlI5UUE2WUpk?=
 =?utf-8?B?QnpkMitDSGxPUWl3d2lhUThOUjFMM1BDbnczT3lXUmpUQ29vaXZLTXo4bDcw?=
 =?utf-8?B?WGxadC93TlZycXRPQklDZkY5T1NrSUtnUldmaEFlcG05QkNQVnVVOFZ3UDhU?=
 =?utf-8?B?eGhhMVcyaHVYWm9GVTU1YlFISGIvSnJEbzNPRkk2T2VPTlJ1ZDgycFdXNVVY?=
 =?utf-8?B?bFVSOUNKTUVkSGg0VndZUC9ZTWJHbnNYWEUwWkQ2ek5xWUdmMlNTN2JTdlVz?=
 =?utf-8?B?UlZub0l3VmF0QTZjays1Vk9aWStiZDNSdkNRWXNleXZNQ2tFK3lCeng0T2E3?=
 =?utf-8?B?d2tSWnZvV0ZBSGQ2QmFDeFlCK0RobUtNYUdUWFBvVmJ2REppbzFlbXVITDR0?=
 =?utf-8?B?NnJ1S3I0bXJLOFFuQ3pNSGJNZ2krYnNvOGNSRmJtb0orRXplTy9YUytNdm5O?=
 =?utf-8?B?VUY4b3c0NFRRYmU5RHVFNHhLVGtNelNjdTJ3ZXpQb0Z4a0ozLzdzQmJaaDM5?=
 =?utf-8?B?RUk4VmdrK3VrUG9hQjM2cU1sc0Y3ZzRxMmRtRFR0amhuZzQ4OGt1L2tQT0N2?=
 =?utf-8?B?b0QyZW9MLy8wZFhjNVJKN0dUZEZWZVVpMEVhdjVjaHpnQUdyRDlOY2s4VHBN?=
 =?utf-8?B?b3JTOUZZZVZZRUxQNDN1K1RNQWRuUzN6R2RScnBoZnhzbFoyL09WMmtsb1Y2?=
 =?utf-8?B?TXVwSDB6QWh3a2tIT0NDeVY5cW1tRW1lTjJaNXFZeldacndDazVxcFVDY3Zj?=
 =?utf-8?B?THJKK0JYY21oUlNIV3c1TXphUGM2UW9hZWlDeVhraXNPTjYwajk3WnVBTDly?=
 =?utf-8?B?UjF0SGJnUjVKdnlzUnBvQ3d5YWp6WnpCVWdvTzVUaEo3OHVDTUF2UTdvY05M?=
 =?utf-8?B?N1YreG5zREJ5L1Z6cXpyaG8zQmE4UUdzZ1l6cCtZbjBrS0FZOU5EdDh4R3Vt?=
 =?utf-8?Q?DR58=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273f07b5-30f6-4c3f-d243-08ddf038b95f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 07:07:37.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MentRjdbopKrs2RWa5bfaLfnex5/iCzmbfNUHzUXmvs2Zx8geeGqNC7iEDv/fURmhyvNVdkYjdzDDZkZnLgcaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9452

SGkgTWFyZWssDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gZHRzOiBhcm02NDogZnJlZXNj
YWxlOiBtb3ZlIGlteDkqLWNsb2NrLmgNCj4gaW14OSotcG93ZXIuaCBpbnRvIGR0LWJpbmRpbmdz
DQo+IA0KPiBPbiA5LzQvMjUgMTE6MzQgQU0sIFBlbmcgRmFuIHdyb3RlOg0KPiANCj4gSGksDQo+
IA0KPiBzb3JyeSBmb3IgbXkgbGF0ZSByZXBseS4NCj4gDQo+ID4+IEluc3RlYWQgb2YgcGxheWlu
ZyB0aGlzICJJIGZvdW5kIHRoaXMgY29kZSBzb21ld2hlcmUsIHNvIEkgY2FuIGRvDQo+ID4+PiB3
aGF0ZXZlciB0aGUgc2FtZSIgYW5zd2VyIHRoZSBmaXJzdCBpbXBsaWVkIHF1ZXN0aW9uIC0gd2h5
IHRoZXNlDQo+IGFyZQ0KPiA+Pj4gYmluZGluZ3M/IFByb3ZpZGUgYXJndW1lbnRzIHdoYXQgZG8g
dGhleSBiaW5kLg0KPiA+Pg0KPiA+PiBJIGFtIG5vdCBzdXJlIGhvdyB0byBhbnN3ZXIgdGhpcywg
YnV0IHdoYXQgSSBjYW4gd3JpdGUgaXMsIHRoYXQgaWYgSQ0KPiA+PiBzY3JhbWJsZSB0aGVzZSBJ
RHMgaW4gZWl0aGVyIHRoZSBEVCBvciB0aGUgZmlybXdhcmUgKHdoaWNoIHByb3ZpZGVzDQo+ID4+
IHRoZSBTQ01JIGNsb2NrIHNlcnZpY2UpLCB0aGVuIHRoZSBzeXN0ZW0gY2Fubm90IHdvcmsuIEkg
YW0gbm90IHN1cmUNCj4gPj4gaWYgdGhpcyBpcyB0aGUgYW5zd2VyIHlvdSBhcmUgbG9va2luZyBm
b3IuDQo+ID4NCj4gPiBNYXJlaywNCj4gPiAgICBTb21lIFUtQm9vdCBjb2RlIGluZGVlZCBkaXJl
Y3RseSB1c2UgdGhlIElEcyB0byBjb25maWd1cmUgdGhlIGNsb2NrDQo+IHdpdGhvdXQNCj4gPiAg
ICByZWx5aW5nIG9uIGFueSBkcml2ZXJzLiBTaW5jZSB0aGUgU0NNSSBJRHMgY291bGQgbm90IGJl
IG1vdmVkIHRvDQo+ID4gZHQtYmluZGluZ3MsDQo+IA0KPiBXaHkgY2FuIHRoZXkgbm90IGJlIG1v
dmVkIHRvIERUIGJpbmRpbmdzID8NCg0KRFQgbWFpbnRhaW5lcnMgc3VnZ2VzdGVkIHRvIGtlZXAg
dGhlIGZpbGVzIHVuZGVyDQphcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS8NCg0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzc1YWI5MTYyLWVkMDItNDc5ZC05MmExLTdjZmFiZmY2YjMy
ZUBsaW5hcm8ub3JnLw0KDQpSZWdhcmRzDQpQZW5nDQo=

