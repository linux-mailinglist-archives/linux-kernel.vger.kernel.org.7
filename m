Return-Path: <linux-kernel+bounces-894845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BE9C4C3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6058C4F4B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B312BE051;
	Tue, 11 Nov 2025 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h+spKydW"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B826E6FB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848039; cv=fail; b=DtNP5zQm3EJknlz2FsmKifOy4MuHv9gI8YiI6kl8fQ0aHSmJTP9AHAW18rgWTda74FOSX4LYL9JlFQCBKDjahf5rkRK/Hoxr6e0aq9ZsCRBUziCyErGkxhWCwMa90HHd6u5azqiZw/jf+QgVuSxBgSve79roymIGXVhtxQ1bCgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848039; c=relaxed/simple;
	bh=Qax8R1IQ+8/MPwyLNCHMTjBsEp20PHYuOBU9mtLH67I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uNHrxqeohxNUEFrB44cjoKSAxF+gJVdyKRRa66jW1f/WrJpyq60zLpGn6KWYhCOOOk3Nxi5Wh2qdzHjuAGSjKM5nTgNQFSVz4yNFYcfrxj46YOVVmt1rz4mzlAhR2rWHYqlWNOOv23MW5aU3Iwv950Dy6rfFIbzAvIukWJy8yaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h+spKydW; arc=fail smtp.client-ip=40.107.130.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ws0X6Nc5qBQRzqb/3YRxlMrYDU0fvatCOPSAosDRk79g3+3Ys7GMb4jP1DMHi8XjyxGY5HbOd9vnAdjX55gZ13bRCuml1MNs2I9hw+bUUYRfK845bQKqO8PbVLnfchzLYhgddeO1JTZ3y8ZosjLzD4CFoopXWrSjZyQxxMV9qEGqM4U+gPKuMsRYywntHbMV0S6wGRiuzWvWhikUQWpg5QSXA/3wu53TkrfZyMNbHSlzYcHq4mYB3PwzQtf2o10EGL/QBE8Xjc1tYeGxIA34/weNPWfHPcxr0CmoXaMS0hr8/p9XapmN1X2R/tG3LGflZ7BONCJI0Ui/hvZbnalYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qax8R1IQ+8/MPwyLNCHMTjBsEp20PHYuOBU9mtLH67I=;
 b=gQn1FriyzCzahXHBHOoZmMCnj4JOi3O9jQR+l2Tix6lIvs1CJd3Cjq7zyvHXdXfiHfsIAS4QUNvCCYnhCsKI/r4Tj5jwlP4WQ6YntFdvfBOQ1fynsc5RJJ8tC6VtfZjaloA/puN9b2T4A8/5aCfc4wVam8bPtC4Y2BgMna7D5Bic2g4Ak9Dku0dyb2QAoTmq0oMd6+dgp7BPQA3BTNPGQ7bGxL23i7OaQsn3n/dQ6PZfEh6rn/AC0FfFPJf1y8QPd5l2+IWF+9A2BZsxxD4yOFYgH+e+Tft4ZffcVjzLz9Kti7FQy+Dv7fY46gljXTPRUcgow295eDhHO7/uCy3QXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qax8R1IQ+8/MPwyLNCHMTjBsEp20PHYuOBU9mtLH67I=;
 b=h+spKydWU9ky5m8B4S91tb8yH26H4oPDNrKHdFDxygUYxzj+tS7i4aliziu/q2gZeLfe/nQu57pfzGwk/iceUifqb2lnWMlxGywzJP5VdVso1qdWM/rKCqDja72Id4/ecDYsx5vykhbwcqmDnOp5iUhPuwZWeSCRDjmrQv5dHNfx4VeQ6ch8JOHM+fKlWjWlO3mpYoBrMbGsBF2PaSqSJnYAsQ5QXrpKDU1tnRMnaRIBJK/hdbp12dEtAQSh2QLxHwqSit/Xr8aI2Jnum2iPXGidcPwGnbDNryAUMuW0Zh7ElieQ3Wrjj+HR2Ykv3Wu0oN2PuAD2Kay2Xc7x+TAqBQ==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS8PR04MB8134.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 08:00:30 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 08:00:30 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
	<pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>
CC: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 4/4] mtd: spi-nor: micron-st: enable 8D-8D-8D mode and die
 erase for mt35xu02gcba
Thread-Topic: [PATCH 4/4] mtd: spi-nor: micron-st: enable 8D-8D-8D mode and
 die erase for mt35xu02gcba
Thread-Index: AQHcUfbl9VdnnpBiUEWwbRZsy0JYI7Trd2qAgAGlnnA=
Date: Tue, 11 Nov 2025 08:00:30 +0000
Message-ID:
 <DU0PR04MB9496D24A8424C578C942CDE590CFA@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
 <20251110-nor-v1-4-cde50c81db05@nxp.com>
 <7d8b0062-a6ec-43a9-ab00-3e11f0e2fb26@linaro.org>
In-Reply-To: <7d8b0062-a6ec-43a9-ab00-3e11f0e2fb26@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AS8PR04MB8134:EE_
x-ms-office365-filtering-correlation-id: 643df5a4-cd0e-4e95-5123-08de20f8626f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?U2NuNnl0aUluOGg5OU9zd3lRUEtLVmtqOHRZTjYwR24wU2NQRUpwcTM0UmNC?=
 =?gb2312?B?R2N5aXRFc1dKVWI4Sm9FR28wRmNkSUIwUjFjY25zOE0rdjRKSHFXSmZuc3ZW?=
 =?gb2312?B?WFhkRFpnTURPOUVuUVd1M0k1WmxUUG9HaGtpV2E4VTgydU0wT2s0SmFpQktS?=
 =?gb2312?B?ck93SlRlMlRXKzM1a0dCVU5tVUFrVXUrbEVQbXhJZWdaREk4Ykc0ajZqb3JD?=
 =?gb2312?B?RlNwc1NtZmVoSzNWQnNCVUk5NHU1SnZNajF6NXdqSDR2NjA2V005MXZMK3ZT?=
 =?gb2312?B?dmJnRWdjYTl1U2Y4Vm01ZVZqR3NWNllOKzdLcmJoQkJRbFZ4WVpabVNvVUww?=
 =?gb2312?B?K2V3Zys4S0prYXVmU2JUaXZjRzNBcTlRK0QyNTRMa3ZJNHJCUzJHQUdlRCsr?=
 =?gb2312?B?NzdocGtVem1jdXlYRW9VL0NEeitZbjkzM3RuTm14aW9jZ0poL2huOW8rRDJG?=
 =?gb2312?B?S2tmU3gwbUg3UXEzVmRMazB1cGdueFppdVlNMTFPa2J3VmE5MU9BQ3AzSm5p?=
 =?gb2312?B?eDFxdG9QdXFXd3B2Tk4yUnNMSDlOQ1ZVS28vTkUwaUhXRjlUWC84UEVpQ2Qx?=
 =?gb2312?B?Rm9oanY2YmE2UHUxeC92c0Fqd0E4ZkFVbU1jaXdhcUtPN084WTVMa1JjRHdJ?=
 =?gb2312?B?SU0xenVpOUhQTVFZcTBldWtZbFdvcVZySmJ3Sk9VVUQ2QllkTVJoK1owK1Zm?=
 =?gb2312?B?Qm9VVTZod0NSSUxDRDdwZHR3SzNYNjA1ZlhFUFJxRW15VFIrb25jT3d0OUhE?=
 =?gb2312?B?M3JmTklrK1owZk9RVzZMaGMxa2lVc1UzOU43SVBGeFMycGRnOG1pM0hQM0dK?=
 =?gb2312?B?SWV2L0VTUVBZWjJWODJMVnE2dkZULzNmTEZsR3hXM1RkV200OVFCR0JCVGRr?=
 =?gb2312?B?bHczdmtiNW5mOVZWdmJmTzJOaUpCWUpDcmhwVkhQOE1KK245T3lvSlpZT0Fm?=
 =?gb2312?B?QU0wRWQweURtMnIxbHZtMVdtWC8zRXRJUnhLRjRMcmZkcVo5SzFCbS9KQnhr?=
 =?gb2312?B?K0U1d3VxTFpqSjRMWlkwTG5pUE0zemdTOG5qZjN5b1crTVJGVm9IWVNUd0RQ?=
 =?gb2312?B?Smx1dDJwSHZLMWZPcFprTFhEV3ROZkNNQWx6clI2Z0NyUWZkQWFKN1FCNE5H?=
 =?gb2312?B?MG9iS1VMcmU3NVVDWlVGNkcrQjZBNkE5SWlHTHEvRUJ5N3NTcXdtN0lRcHBn?=
 =?gb2312?B?WC84ckttbTluS1ZoZFNrV3ZhcjlmYThWa2tiQ3VHT3JTdnlDNThCemF5bHZo?=
 =?gb2312?B?aGpQdENINDNGSW1yWFN1cmRUZ0kvZTF1ZHorZDUrVVRUSnhtZSt2dEFZVTNZ?=
 =?gb2312?B?OHFFdWJRM0QxYTNOamZSU241TWFOcjJldWVBQUhwMW5tbnFGanROclJ1M0Rv?=
 =?gb2312?B?VGF6d2lHTk1ZYkdxT0NEMHdDU0JsN3AvODg1MUVhQ1pUSTdBVjNzcGFUTFdi?=
 =?gb2312?B?SmxoVk4rakNpWFJ1a0pNSCtSSjE3TEl1ZG9zOEtTQTFMemhoV3V6UXMzYzda?=
 =?gb2312?B?WGV6ODRIOUZTSFN3eUtEaUZYRWVEdDRGRFZ4aUdLbE5pVmo2ZTB1Q1U2MmFL?=
 =?gb2312?B?UFlOdUlqQmhVbStIaUw2WVhNUmpCSnFXUGVZb1hEUjZPcEtnNzl4OFdGK0E1?=
 =?gb2312?B?QUFjdENTZFA3dWk5RVdDbkl6b1BleEhYbExDekpzRDU1WmExU3RCZTF3K2FX?=
 =?gb2312?B?RnNrMTdwdkg2QjBLQ1lNWjZvVTUrTit4cFRlcHpqL0k0RXorakR4YVg5dHNY?=
 =?gb2312?B?enFISlVRNEhrWjF2MGZXNnd2clJUQXltaEZGbkZ1bVg4YWZrVU5vUTNENzEv?=
 =?gb2312?B?cWcxRllrRDFOUFJGUXBjUGdhdGlhYTYwSitrWXRFakRQY1RFMUZML213b2Zw?=
 =?gb2312?B?UmxEb1JLVTlqSVVuTjJNUXlMQW5QOStlSE91eHBDNG9jcUdsdkVkWjRTRU5q?=
 =?gb2312?B?a2VkRmsyLzBjS2dveXBYTDBKc0FnNzVqVjY5SEVXY0phYXlUS2xmVTg0aDVw?=
 =?gb2312?B?bVl5N1k2dmxXZElLV0lrdHozSFA4K25TUmI3SERoN3NBZ2dxME5nYzZHL3k1?=
 =?gb2312?Q?4DlEsv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aXZJUGtTOWZVVnMrR3VyUTN5dlpBTmJrS0tKNzZMR0ViVnFFRXlpeUQ0c08r?=
 =?gb2312?B?L09xS1BDYXE0empKWkhINVRSdHA4VG5WS01sYXB6VERrdGpKTXpwd0QzaVN1?=
 =?gb2312?B?L3pRM05lZjk5SDhmL3F0aTdKYjdQbFFOSXJjdFFMVHRINjFmaUNvc0VGM3A4?=
 =?gb2312?B?ZW12QTdmOU85ZHA1VS9WaXhXRnVYMnlHYUVaTEJscFJZVFlkV3N4dWJjQ0Vx?=
 =?gb2312?B?bnJYU1pIVkJWYjB0OGJ3QjY2RnZjY2EzTGhheitYREFUMlB5dXYxQkRDZXpE?=
 =?gb2312?B?RnRacWtRWi9SdUMyQUFaaWtnRUhXU2ppbnhTU1hYZlU1dG04TE9hQ0t5MVMv?=
 =?gb2312?B?UVhETkRHbE1lM1NzelgwRWplUGJVc2JzQkJ0aW9wRllPUzc2ODlKdjRNU2NO?=
 =?gb2312?B?NGNqcWd3Y0RrZEVxc0lVNjhzN1lkc2NWbWN0dVVBVVk0cjVBd09qMFpDNkM1?=
 =?gb2312?B?cEZROVVpWE9XWm13QmNUUTVQTnNGZnpNa3hDRUF1WDV0SlprZXVEYTJIYlEv?=
 =?gb2312?B?SjRhbWpFK0VQeWp4N2RpcGE2aEtXbU9uMGZpYUtYa0RyNmUwWnU1ZEpOY1JH?=
 =?gb2312?B?azZxVThsMUlOTGxqRWVKT0xNWm5VNEx3WWNXUFMxNCtuT2d4andxdzVMUkd6?=
 =?gb2312?B?M0YwbC84cTFZZjkzYUFFOStELzA4U0dMVy83QVJIbmhwUUpBZHpzaDB4RCt0?=
 =?gb2312?B?ems3bFo3ek10SlZlYUI2eFBZaUZEREpVNEpBSzVuT05IV3VVRUxzcXg0ZVZS?=
 =?gb2312?B?MGVJVmN6VERiVW9xVXpnRVpiOVF2YjNQU0QzeU54NVlEVktiSUV6MkJwKzhZ?=
 =?gb2312?B?NTE2dGVjL3lTVVJ3RzIxeHVOdWx3WUo2c0JrQTRueGJBbGlUZVkwMDN1eHBn?=
 =?gb2312?B?NjNQK2tqSERra29zYVhIb3NRSGJtMjJTdHM4WXl6RDFDZVllSHBBa0ZMdWZK?=
 =?gb2312?B?UzUwcTVocXBiMmpSUUpBa1ZXWUgzaVhwVGltMEt2RkwwaUgzbWhQTFlJU3pa?=
 =?gb2312?B?b0xxV3lQcXkrRXByN1pZSGtRL2JuaHplOW94WWZiZy9XZXh3eE5sQWN6Wk94?=
 =?gb2312?B?cHlWbUtKSmlGZXhtZjVVYXlHMEVDbjhhcU9qTDZia0R4eTFUbFdDaHF2WTdK?=
 =?gb2312?B?cWgvdktReDc0U1dTRzZqQnlFMzBhKzh4L1laYldsWVpjWEJtYi92UWFaK3Ny?=
 =?gb2312?B?WitVVmx3V1I0WmcxTEl3YzhWNTFWMEYva3pHT1FsZW4yVFBmZTBzVERremQy?=
 =?gb2312?B?L2dla2ZWMk1OYWwwbDgrY3JZM1lMc09ybVlCVXh6eWJhL2ZsYlc1UUFHYVNM?=
 =?gb2312?B?L1JoZWJEeW5CUzNHazczZExvK2xYQzkycmUxQlY4bFdwakR3MTFweWRtVVBQ?=
 =?gb2312?B?bGtYWkxjcnNLZXN3U1Ixc0pkaUl2d0hNTlRsZzExYk4rTDVkM0p3TnBBcDNJ?=
 =?gb2312?B?QllnKzcrMkFacUllTHpoMTVSckNyNlV0bVduVEFYVnhDNHVSQU45T3Z4UE82?=
 =?gb2312?B?blpxWVZodUxJb0Y3VnE0SEhTaXJiZVMraHBJM1JIakg0NU1OSHFZajY5d0Va?=
 =?gb2312?B?cDlzQlRyQ1ZDd2c0dExBc3RXUTRKTmx6VW0xNE1KTXczcHdFSHdVZzQwVHB3?=
 =?gb2312?B?NVZxN1FyUkpHTHd5TGJZcGptZVprR3JaUTRiM2NvREV6enNBOE5vVjJYM1Vj?=
 =?gb2312?B?dXdsdW9lMkZPOHZpbFNDOGh5SXM1VkIxYlNBRXZuTTZtVXJiRk5uWWNrNjVn?=
 =?gb2312?B?ZkhJNDFWdXhxMkl2L09QTFBSa1pHcENGMnJTbTIzbXBYby9KWDd4VDNNWVM3?=
 =?gb2312?B?NHlWWnAxVE94bVlKR244YVg0VFF5eTNXM0V1dzI0NGhTVWJjVHluQ0k0NmFy?=
 =?gb2312?B?TU9maXlyTVJuMjl5aFl6VzY5VGkzWWlZem44K0k5L1hPRWlDbkh4aHk1Zlg0?=
 =?gb2312?B?cDVyZllpTFpnd3BKYzR1Nmp3YlIzVEtjS2hxNGt6d0hQdG9Kc1E3Um1DYVl6?=
 =?gb2312?B?QW1tWGoxdXpUV2tNbWRYZEpYVEs0T3ZDaS8vVFpsSTRQSjR4ejRkbThZT09k?=
 =?gb2312?B?QW16Vzk3SmhOQjk4Z3psYlVZZWVLMnpzTlVTbitNNGdDMzBSWG1UcEJ5ZDNn?=
 =?gb2312?Q?1mbo=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643df5a4-cd0e-4e95-5123-08de20f8626f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 08:00:30.8119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVQGyVcmPhY5T0HoOi6gMZe0ZNqAQMVUv1dkUqTh3xWxEYH/KTqxXNyMb8RFIOIzQKg9Af/DarIoT9IGpBWpXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8134

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRv
ci5hbWJhcnVzQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjXE6jEx1MIxMMjVIDE0OjQ2DQo+IFRv
OiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyBQcmF0eXVzaCBZYWRhdg0KPiA8cHJh
dHl1c2hAa2VybmVsLm9yZz47IE1pY2hhZWwgV2FsbGUgPG13YWxsZUBrZXJuZWwub3JnPjsgTWlx
dWVsIFJheW5hbA0KPiA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT47IFJpY2hhcmQgV2VpbmJl
cmdlciA8cmljaGFyZEBub2QuYXQ+OyBWaWduZXNoDQo+IFJhZ2hhdmVuZHJhIDx2aWduZXNockB0
aS5jb20+DQo+IENjOiBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDQvNF0gbXRkOiBzcGktbm9yOiBtaWNyb24tc3Q6IGVuYWJsZSA4RC04RC04RCBtb2Rl
IGFuZCBkaWUNCj4gZXJhc2UgZm9yIG10MzV4dTAyZ2NiYQ0KPiANCj4gDQo+IA0KPiBPbiAxMS8x
MC8yNSA2OjAyIEFNLCBIYWlibyBDaGVuIHdyb3RlOg0KPiA+IG10MzV4dTAyZ2NiYSBpcyBzaW1p
bGFyIHdpdGggbXQzNXh1MDFnYmJhIGFuZCBtdDM1eHU1MTJhYmEsIGJ1dCB3aXRoDQo+ID4gZm91
ciBkaWVzIGluc2lkZS4gQW5kIGl0IGFsc28gc3VwcG9ydCA4RC04RC04RCBtb2RlLCBidXQgU0ZE
UCBsYWNrDQo+ID4gU05PUl9GX0lPX01PREVfRU5fVk9MQVRJTEUsIHNvIGFkZCB0aGlzIGZpeHVw
IGZsYWdzIGhlcmUuDQo+ID4NCj4gPiBMaW5rOg0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmRhdGENCj4gPg0KPiBz
aGVldC5vY3RvcGFydC5jb20lMkZNVDM1WFUwMkdDQkExRzEyLTBBQVQtTWljcm9uLWRhdGFzaGVl
dC0xMzg4OTYNCj4gODA4Lg0KPiA+DQo+IHBkZiZkYXRhPTA1JTdDMDIlN0NoYWliby5jaGVuJTQw
bnhwLmNvbSU3Q2M2YTRiNWY0ZjU2ZjRjYTcxNmQyMDhkDQo+IGUyMDI0DQo+ID4NCj4gZDBhMCU3
QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzElN0M2Mzg5ODM1Mzk2ODA4
DQo+IDExMzA0JTcNCj4gPg0KPiBDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNH
a2lPblJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXcNCj4gTUNJc0lsQQ0KPiA+DQo+IGlPaUpYYVc0ek1p
SXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9Ng0K
PiBEcWhoDQo+ID4gaGxJemR4ZnRUbVF6bWolMkJjb21qWld4V09xcERXUDUlMkI0TlVHQ0swJTNE
JnJlc2VydmVkPTANCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54
cC5jb20+DQo+ID4gLS0tDQo+IA0KPiBwbGVhc2UgZHVtcCB0aGUgU0ZEUCBkYXRhIGZvciBldmVy
eSBmbGFzaCB0aGF0IHlvdSB0b3VjaCwgaXQgaGVscHMgdXMgd2l0aCB0aGUNCj4gc2ZkcCBkYXRh
YmFzZQ0KDQpIaSBUdWRvciwNCg0KSSBkbyBub3QgaGF2ZSB0aGlzIG10MzV4dTAyZ2NiYSBvbiBo
YW5kLCBJIG9ubHkgaGFzIG10MzV4dTUxMmFiYSBhbmQgbXQzNXh1MDFnYmJhLg0KSSB0b3VjaCB0
aGlzIGNoaXAgYmVjYXVzZSBJIG5vdGljZSB0aGVzZSB0aHJlZSBjaGlwcyBzaGFyZSBvbmUgZGF0
YXNoZWV0LCBhbmQgc2VlbXMgb25seQ0KaGFzIGRpZmZlcmVudCBudW1iZXIgb2YgZGllcy4NCg0K
U28gc2hvdWxkIEkgZHJvcCB0aGlzIHBhdGNoPw0KDQpSZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0K
PiA+ICBkcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jIHwgMTEgKysrKysrKysrLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+ID4gYi9k
cml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jIGluZGV4DQo+ID4NCj4gZjcyNDMxM2Y0ZGQz
NzIwOTA4OTY4YzY3MGU4ZDNkNThmNDFjMDk5Yy4uYjM2MTc0NDM2YjdhYTBmNzc2OGRiZTQ4ZQ0K
PiA0YWQNCj4gPiA0OTI3YzA4YTNkNmQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tdGQvc3Bp
LW5vci9taWNyb24tc3QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0
LmMNCj4gPiBAQCAtMjE0LDYgKzIxNCwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNwaV9ub3Jf
Zml4dXBzDQo+IG10MzV4dTAxZ2JiYV9maXh1cHMgPSB7DQo+ID4gIAkubGF0ZV9pbml0ID0gbWlj
cm9uX3N0X25vcl90d29fZGllX2xhdGVfaW5pdCwgIH07DQo+ID4NCj4gPiArc3RhdGljIGNvbnN0
IHN0cnVjdCBzcGlfbm9yX2ZpeHVwcyBtdDM1eHUwMmdjYmFfZml4dXBzID0gew0KPiA+ICsJLmRl
ZmF1bHRfaW5pdCA9IG10MzV4dTUxMmFiYV9kZWZhdWx0X2luaXQsDQo+ID4gKwkucG9zdF9zZmRw
ID0gbXQzNXh1NTEyYWJhX3Bvc3Rfc2ZkcF9maXh1cCwNCj4gPiArCS5sYXRlX2luaXQgPSBtaWNy
b25fc3Rfbm9yX2ZvdXJfZGllX2xhdGVfaW5pdCwgfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZmxhc2hfaW5mbyBtaWNyb25fbm9yX3BhcnRzW10gPSB7DQo+ID4gIAl7DQo+ID4g
IAkJLmlkID0gU05PUl9JRCgweDJjLCAweDViLCAweDFhKSwNCj4gPiBAQCAtMjM3LDEyICsyNDMs
MTMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIG1pY3Jvbl9ub3JfcGFydHNbXSA9
IHsNCj4gPiAgCQkuZml4dXBzID0gJm10MzV4dTAxZ2JiYV9maXh1cHMsDQo+ID4gIAl9LCB7DQo+
ID4gIAkJLmlkID0gU05PUl9JRCgweDJjLCAweDViLCAweDFjKSwNCj4gPiAtCQkubmFtZSA9ICJt
dDM1eHUwMmciLA0KPiA+ICsJCS5uYW1lID0gIm10MzV4dTAyZ2NiYSIsDQo+IA0KPiB3ZSBkb24n
dCBjYXJlIGFib3V0IHRoZSBuYW1lLCBkcm9wIHRoZSBuYW1lIGFuZCBhZGQgaXQgYXMgYSBjb21t
ZW50Lg0KPiANCj4gPiAgCQkuc2VjdG9yX3NpemUgPSBTWl8xMjhLLA0KPiA+ICAJCS5zaXplID0g
U1pfMjU2TSwNCj4gPiAgCQkubm9fc2ZkcF9mbGFncyA9IFNFQ1RfNEsgfCBTUElfTk9SX09DVEFM
X1JFQUQsDQo+ID4gIAkJLm1mcl9mbGFncyA9IFVTRV9GU1IsDQo+ID4gLQkJLmZpeHVwX2ZsYWdz
ID0gU1BJX05PUl80Ql9PUENPREVTLA0KPiA+ICsJCS5maXh1cF9mbGFncyA9IFNQSV9OT1JfNEJf
T1BDT0RFUyB8DQo+IFNQSV9OT1JfSU9fTU9ERV9FTl9WT0xBVElMRSwNCj4gDQo+IFdoZW5ldmVy
IHlvdSBjYW4sIHJlbW92ZSB0aGUgbm9uLXNmZHAgc3RhdGljIGRhdGEgYW5kIHJlbHkgb24gdGhl
IFNGRFAgZHJpdmVyDQo+IHRvIGhhbmRsZSBpdC4gQ2FuIHlvdSBwbGVhc2UgZHJvcCBzZWN0b3Jf
c2l6ZSwgbm9fc2ZkcF9mbGFncyBhbmQNCj4gU1BJX05PUl80Ql9PUENPREVTPw0KPiANCj4gVGhl
biBkbyB0aGUgdGVzdGluZyBhbmQgc3lzZnMvZGVidWdmcyBkdW1wcyB0byBwcm92ZSB0aGUgZmxh
c2ggd29ya3Mgb2theS4NCj4gVGhhbmtzIQ0KPiB0YT4gKwkJLmZpeHVwcyA9ICZtdDM1eHUwMmdj
YmFfZml4dXBzLA0KPiA+ICAJfSwNCj4gPiAgfTsNCj4gPg0KPiA+DQoNCg==

