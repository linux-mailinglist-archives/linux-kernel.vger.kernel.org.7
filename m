Return-Path: <linux-kernel+bounces-793871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0559B3D98C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C683B219D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C92243374;
	Mon,  1 Sep 2025 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q4rb1b8v"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C8121019C;
	Mon,  1 Sep 2025 06:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706953; cv=fail; b=D+Oo7RFDFMwvV/41Kyj7VGawx88+1TXS7vLw7yr7hSGoNr9r9s6hFKT69khpg6u4nf11b4o4r4By2hfAtO9R042Qv216hd6Hxaudfn8qap1+TgFvp1WlHYhE/fZHpWQ0Pxmi786ZMvs6LiSkvhsSOutc8hV7HTOl77CwLYcqpyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706953; c=relaxed/simple;
	bh=gRMQaNUS8Lp8tyhD4a+2YkObZavX63HhkW0LBSUv+iI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n++7I3OlMgPPxl6uDI5sEKRLwQOEfSZTx2+rwmsrzKRJ48OAMcYHeSYm+pQnDNCww5ubM3Mxn6xs5blSsLej/Voa6oawnoUzo8MgTluoPkMyLKT/1HQI2gsXciOkR3Mi1vZRcAtOUsp24Zqk4sFz7uBCyYm2fo/tbgXALEiv5XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q4rb1b8v; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIPo8+BhmDb/F6W7A5EKL9qfN2psRmhcRSSMh/AId+Q+6G5U+0UryXOpvmZPMWZyCrlz87YlTdRJIzYxvSgWrG2WcbdZuHj/uzfac8Oipb4Y/OPTZOTcUbfHMOgZ85wZcmONZReYFrl5Xwkymkp/6JEW8wroVqQwJiaNw8ccfPWpZVPJHAA7ff0R5eYHWjvyITIpWYp7YQNIXE/4NhUeLb+Goi0sSzJ8JN4ZONIPiwdskBkjQi2wITornXm23qLADUWy7fO475v5qDFmBLbIfidYYDNcm3a9VT7SsFARC2pS550jIO/M/kgY/QUCnlu1/zCiG5VkJqz6DdqlmiYVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRMQaNUS8Lp8tyhD4a+2YkObZavX63HhkW0LBSUv+iI=;
 b=xhl2iWxPr9Rt3mNL2eCoWtvaJ4L7QDS+Z4j+lcMv0Ue/BSCuI10AOHGXDcGsCPWvo78GQQPfQ423FXlFku2UnSQDUF7OwHkfp6ZTX9V3OydImTzVY4IDL/GQcljBX0lzlXwRFmpOe41Zpez9vVy/3cRtseF/rUcWbv1bHgitrZ6mJwt994wMQ8ujEYV5prBBozjDpvnAm/++Q25YaAvDKE3Y6a48R6TAAB8xalP2EowVteO6e3NAONjrPsQP2bXyQPUVzaAUP27bOqv4GHRpoj6qctFJn6yVzXt62DiEeadcaGz4gh5YxxZbLLEiZVWZn4FXvF9PFgn43fz4GneRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRMQaNUS8Lp8tyhD4a+2YkObZavX63HhkW0LBSUv+iI=;
 b=Q4rb1b8vn9qBESleWhlU3aVGyBEbB3nlPnIN6r85rUMB/uTWb0URiHSonGyggX9F3CwgQPFO020WUqKYCHae2JGmUaCX2M0ofR/qVKJ4GGgmAELkc5s1i+xbhAZx85aN7BObqrzDESCIAm3IPbQU2wvx5G6bpJOrnXKRw+kETHpD3DL0vPuvaYvSSrW64Hysb58isJI6giLmn4XMnbJGlLz7h2Q2AcyVf+N39XkJOW+Lxu6dPv7SOw3ZgRJSsVNyJ98KNzKiQDyOCvidiF1JdobuQ2orobaNgysqwGsnU2TIqSve3v60KA6O7Po2vvqRG2IVw9PRVHvVcnFT4jwLbg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10510.eurprd04.prod.outlook.com (2603:10a6:800:233::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Mon, 1 Sep
 2025 06:09:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 06:09:06 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Marek Vasut
	<marek.vasut@mailbox.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Abel Vesa
	<abelvesa@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
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
Thread-Index: AQHcGrLMzJw01yb/r02Eq/dbVTFFIbR9qcaA///vfgCAABPWAIAAKrlw
Date: Mon, 1 Sep 2025 06:09:06 +0000
Message-ID:
 <PAXPR04MB8459F95D64A4D759C5C3BED28807A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250831200516.522179-1-e@freeshell.de>
 <20250901032203.GA393@nxa18884-linux.ap.freescale.net>
 <3a165d77-3e36-4c0d-a193-aa9b27e0d523@mailbox.org>
 <05f7d69a-9c05-4b47-ab04-594c37e975eb@kernel.org>
In-Reply-To: <05f7d69a-9c05-4b47-ab04-594c37e975eb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10510:EE_
x-ms-office365-filtering-correlation-id: 44596d41-db7f-46fe-cb0c-08dde91e0f14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y01TcmJPSGkxaGpDd2RHUXdIS20rUXVLVG00YmplVld4WUluOFd4dDdhejRj?=
 =?utf-8?B?cFJrSWdVaENSeTZWMlZRQVA1SVpNMXZGRjdQQ3hkdmxPZFd5OU04OFVscW5P?=
 =?utf-8?B?UCtjdTZmeXVBYThsRlQxKy96MUJXOTcvUUxBR0hkL0xPQldFRG1xRVJ6VmF5?=
 =?utf-8?B?MGZlY0RtRnhrUmw5eUFONElEczhSSWpOcW90MXJ4OTc5eUlSR0IrOFFUdlhz?=
 =?utf-8?B?alk4VEh6T3VOM1lwY0tLQWVyVS9EazBNdUI0T25QWkJCYUdrQ01vcEgxV3dE?=
 =?utf-8?B?alBGM0FzcEsyQkFPbWdHME94SXVQSHhnSXRHUzFOZG5lNzNMb0RlRWxaYlhI?=
 =?utf-8?B?ZlhibUtFRmVWSHpNcW92ak92R1pPVVhUa1ZxbnY0MlJWNFF6ZjZ1dDRKWFN5?=
 =?utf-8?B?eTR6Y2ZWM1d1NlVRYU1UQjlMQ1dFNFpyTEhtUVBWZy9leHpXL0phbVNTZS9s?=
 =?utf-8?B?bGVVYnZ0c1lhWFNncWxvT2hYYWVuWEpiOUE5WitsZ3Y0M0cweEltcmN3UHFy?=
 =?utf-8?B?VkRHbEN5Ty9ISVM2ekFhMnViTzVPbk9tNEhFR1d4NDFObmxFN0tWVlZCREhj?=
 =?utf-8?B?cXhvWkFqa1B6Nk1oY1NlSVJOQ1UxSGcyVWFWd3c4cGUyZjVmQ1V5WmE0aXdU?=
 =?utf-8?B?L0Q0L0ZNS0xzWWNQL0pLYyt3bGRTMkcyL21jWDdFOHB5b0ZZQjBWb0lKeHlj?=
 =?utf-8?B?NzNvME9raXBNbUhoR0oydHAxU1ZGa05lamt4bEVtUGpERFpuWXBIcDVTRmlC?=
 =?utf-8?B?djdNVkpBYWUydjFRaDVPcGRZNi9Ra3djd0tUMlFBdE5BWEluQWJySGl3NW1M?=
 =?utf-8?B?WFBFOUJNaG1FYlgrZ21TOXVHL3dBV0pyUFYxODNBV0JuWGtRb2lRYXlsNFpU?=
 =?utf-8?B?NEdtdHQ2bHJGTllpMFZLZjRzUFdLWEtPRG1Zc1JITGRjZEc3K2dlU3dRdUMz?=
 =?utf-8?B?OEczU0lMRUVyc1p6alpVUjFtano5djF4Y0xxVzNvV1JMQXNSMnhWeEw1c1NU?=
 =?utf-8?B?QzdDWjlSNlpwMnlnRExlcjlDanFzMVhROHViZExtN3o1TGJqT2FXZGZoN1pO?=
 =?utf-8?B?bzd4WmtzMWpHQWlpVUcvVDFuNm9jaWoyWVRWL0FVZ01ZZzNYK3d5VEdFZDdZ?=
 =?utf-8?B?R0dSMExCOGFBeDVyRzZxcHpJNlM4NExWU3p6TGlIZXFXcWNJNnpkd0hrVmhM?=
 =?utf-8?B?OXhZb1hnMTcwL3RBcjZMQjZhdGQ1WEZDekYxZlM5Y1BROExuYXhOV0Y1OEJJ?=
 =?utf-8?B?VzQyRndBdkxSRXEySmNhMWxSRFBWakl6R3gvZUhNbklGQXFZRnBNSjZYQVdI?=
 =?utf-8?B?a1h5Q21vbUJCVGNDZmdsVkdvd2tBU040bVUzaGdnbEg2TjlGMmlmZ3BEUlFK?=
 =?utf-8?B?TXcrZ3ZCWG96Vjhmc3lQaFhHNkN3amVCY3Z1QUIvbjg5QVp6ODhPZHowdUky?=
 =?utf-8?B?ZTA4dWYxdnl4UVoxa2FsSUk0aXZJNlZvV3AyMVQyVUlndFQ4bFlBQ2RWVE5C?=
 =?utf-8?B?M096amJ3WWtVa1FHRmhhWEV4VithbEdBVi9YakRIZ0xXbFlzcDMwbmdsd2pP?=
 =?utf-8?B?QnB1a3JuT0Y0eFN2NnBGdEdhUFdPclJQcUpXRW5oRXdDU3l6SS8rWHMwN0Na?=
 =?utf-8?B?dCtEaVVsMXdMbnVYUG5jd2N6SzVRZlN4NWtPNi9BZFpkRktjeVk0ZEt4M0Ji?=
 =?utf-8?B?dTY1RS9nTFZCMnBiRUt3ME9BSnRZTTNFQjRuQi9CMU5YaXpGTVdMMENEcEVM?=
 =?utf-8?B?WjVuSGViUlBZUGRpb3FueU5Bc0ozUW14RzN4eEJEWkxQUHBWQ1FKcnpEdkZN?=
 =?utf-8?B?R1NWQmg0c2RFWGFyTGo5SmdicDhXRk5BdG1ZYzNISkxFV0QyZ1RobThHWk1X?=
 =?utf-8?B?UWM0SDBjU1BSbUpIU2JKeGxXT3BJcmRsSDMydzlMZkhiRVRpMVY4L204WGpk?=
 =?utf-8?B?VFp2dnBYTnhXQkVlbXFKbWNKQzFSeFlPbUVzMUNUVC9jOGRoaFdValBYUzdC?=
 =?utf-8?B?NC95MmNEVlhRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmRBVEpYNGZSMDdGU2xMaTN1b3U5RlMvNDBjQlBuT2daOCt6Y2xndkpVdEpU?=
 =?utf-8?B?KzBUWS91cGhuTVA3LzRWMlkzeUpkOWo1a2htZ1RmUk5pZlFTTk8zL0RxVk16?=
 =?utf-8?B?ZEQyNHdrcGo5a29IYkpmQjUzVjBHM2x1cVRNN1NHWnhnZXFMNXZ1RWJ4Vytz?=
 =?utf-8?B?S1BueUlLUW12S0l3RitML2l4VVVZVFdUT055RGVFbXFVR09rSEhSeFUxUTA4?=
 =?utf-8?B?VDVqVVdlSnlWcW5GQlRrYS9FV1hqVEZnVTJuRWFiUXZxN1hQYXIxdlhWN0Yz?=
 =?utf-8?B?cWpJd3RNdGV6TktqNWhSbWRwenkwNjJMbU13TjhLRjBFUWNHM3UvSVV1R0NS?=
 =?utf-8?B?SkdxQlJXVnNabk9QSy9Cc1ZycEpYUmFQTUNicWpLeW5EV216RHJpMmtuVGhr?=
 =?utf-8?B?ckRVL1h1YUNXcUVjYVZrWEtvSHZ5ZkdyTXNXUlBydFZNcmNPOFpwV0RYVFBu?=
 =?utf-8?B?RkNxbWdZN2tZNWhkWkl2Q3NFKzJhSm9MRnJzVDdDTk1SLzBsQm1pVjBBNXNo?=
 =?utf-8?B?bXRLbTNUeEhxZDhsbktWWkJLYTdFdUo5b09ua2c1Nmk3TWw1UWVoRjc2T1dl?=
 =?utf-8?B?NlRPRXRZMTg3MTN4R3p4TnhmdW54b3crWUtNd2RMZXYvcTV2VTRFUHludGJI?=
 =?utf-8?B?cjVZODA2OERVc25JTEU1Zk40Qk9JU3NlQ25OV0lpMy9uWnFQWFJhRzFhQkR3?=
 =?utf-8?B?Sk1GMzVhTHRWQXQ4N3ZROWFuWkgybVA4NU5PUFZna0JGZlhwL0NIOTE2Uzkr?=
 =?utf-8?B?dDYzQnBJNE43OVBRYlJCUW9QQkdOKzlINkY1VGtvR2tuTWt5ZUxLVVVSa2lq?=
 =?utf-8?B?WkhTTGZHYnNFYUdvN1pVaHRZOFJ2c3BkdnZkc0huUmV5UTVTNWhUOWZsQ3Zz?=
 =?utf-8?B?cm5YM0lRbU9RWk1mKzBQZGU1NlBMNW5NcDdaeHJlek03LzlCMDY3WUFsOXcy?=
 =?utf-8?B?V3dvK1laV0lCRTRHLzYvaEt3czEzRXlpSFl1MWNoKzR2THpsdTBXTEprdnZi?=
 =?utf-8?B?TTN6V0t6d01wdm9TWHFvSDRla3hjeExLc0ZsTGZIQkMxamlnUHNIcVNOamNL?=
 =?utf-8?B?K2tlOEpGSVhESEZLQ3VRUXJ1S2dCNUk2NXUxQU5XbHA0WE85aXFOUndoUW83?=
 =?utf-8?B?RXdvL2pWS3BWU1YveDc1dGpyQWU0MXN1aitsRDlpYW1OR0tSWmt5bkwxcCsr?=
 =?utf-8?B?eERnOC9ZN1pHcm85WlFqeFB0Q2IvUWpUd3Uzc3pteHRkdXlrd0xrcXlnSFNh?=
 =?utf-8?B?elZyMDdaRUZzNGY5ay9zQytvTVBHK003R2oxS3RUTDVJS0FrenVCZXRrVjBu?=
 =?utf-8?B?OUNQU1VkOW4yQjhRMUNwUDFvRWRvV3MvL3RmazN4WkgrKytQbWtqSlFFWG1z?=
 =?utf-8?B?STNtVWJGNVRJS1A1dmRWZlJ6YnBmQW05R2VNNFplTUxabkE1bXpSNUZJVm1s?=
 =?utf-8?B?SVRBOXhSZENpUmJ4bzVBbVpsWTIrU1dTRVF2dWVGdG4rUjNOZkpxTFB4aGFQ?=
 =?utf-8?B?WGJreUNqNVZuTXAvZGczY2h5Mms2YnIrUWJibzZiVFdyUXdtSzdrZ251ZG5D?=
 =?utf-8?B?MENGYVlUVFVGVW1YK2ZuK1RTTC9pVG9uRW01NXlGTS9UL3ZWVktoNjFXMUky?=
 =?utf-8?B?RUFDUGhzT0hSK3FjL09EQ0o2M3oxTmhKZGhuQWVaVmFWalhxOExuVW5pdDI0?=
 =?utf-8?B?V1pRbExmTkdNOVhDNUdNbU5yd0NlYmhQMTdDYlJIa1JrWU05SUJRREo5TlVW?=
 =?utf-8?B?RlJOb0N6VDZPM2pOVWNENG1BYVUvVzF3WjNnQXVBN09wZEtWVnovaCtVejNK?=
 =?utf-8?B?dEhFNSs4bnNaVWV0YlVkN1pHN2daN2Jyc1RoNzdGdTNBeTdYLzZZQ3E5Q3lP?=
 =?utf-8?B?eG01bkVxNkEwZmRzY3l4VTkyeEFCUFRWdmV5MS9Vd1FZZE10aDE3ZXV3SXlQ?=
 =?utf-8?B?RUZiN3grZEtJUFRnNVNSYTFUbGU5S3d4NGFFUVdoUlNoV3BIWnRWbCtpc2sx?=
 =?utf-8?B?WkQ2T3gydk9mQlV4Y0VONFl5U25GeGtFY29lc280aS9Kbm0ycllydm1pNDdi?=
 =?utf-8?B?dEtZZ21zd3VLd1dhOUQ4c0ZwNHR3c21yNytpSTNWLzErTmJMRHVSSGdhMTha?=
 =?utf-8?Q?+kdI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44596d41-db7f-46fe-cb0c-08dde91e0f14
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 06:09:06.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AANfbg3k56vnXRukD4gtHI0MgBTT/Jo1LY/PY6TkxofOB+x42t7dU6uBh4q4oD+bKIxKPj0yEUmYTqVq08+Y3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10510

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBkdHM6IGFybTY0OiBmcmVlc2NhbGU6IG1vdmUgaW14
OSotY2xvY2suaA0KPiBpbXg5Ki1wb3dlci5oIGludG8gZHQtYmluZGluZ3MNCj4gDQo+IE9uIDAx
LzA5LzIwMjUgMDQ6MjIsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiA+IE9uIDkvMS8yNSA1OjIyIEFN
LCBQZW5nIEZhbiB3cm90ZToNCj4gPj4gT24gU3VuLCBBdWcgMzEsIDIwMjUgYXQgMDE6MDQ6NDVQ
TSAtMDcwMCwgRSBTaGF0dG93IHdyb3RlOg0KPiA+Pj4gTW92ZSBpbXg5Ki17Y2xvY2sscG93ZXJ9
LmggaGVhZGVycyBpbnRvDQo+ID4+PiBpbmNsdWRlL2R0LWJpbmRpbmdzL3tjbG9jayxwb3dlcn0v
IGFuZCBmaXggdXAgdGhlIERUcw0KPiA+Pg0KPiA+PiBOby4gVGhlIGZpbGVzIHNob3VsZCBiZSB1
bmRlciBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS8NCj4gPiBXaHkgPyBMaW51eCBhbHJl
YWR5IGhhcyBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrLyBhbmQNCj4gPiBpbmNsdWRlL2R0LWJp
bmRpbmdzL3Bvd2VyIGRpcmVjdG9yaWVzIGZvciBleGFjdGx5IHRob3NlIGhlYWRlcnMgLCB3aHkN
Cj4gPiBkaWQgaU1YOSBzdWRkZW5seSBzdGFydCBjb25mbGF0aW5nIHRoZW0gaW50bw0KPiBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZSA/DQo+IA0KPiANCj4gQmVjYXVzZSBtYXliZSB0aGVz
ZSBhcmUgbm90IGJpbmRpbmdzPyANCg0KUmlnaHQuIFRoZXNlIElEcyBhcmUgZmlybXdhcmUgZXhw
b3J0ZWQgZW50cmllcywgbm90IGJpbmRpbmdzLg0KDQpUaGFua3MsDQpQZW5nLg0KDQpSZWdhcmRs
ZXNzIHdoZXRoZXIgeW91IGFncmVlDQo+IG9yIG5vdCwgdGhlIGNvbW1pdCBzaG91bGQgY2xlYXJs
eSBleHBsYWluIHRoZSByZWFzb24gYmVoaW5kLg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
S3J6eXN6dG9mDQo=

