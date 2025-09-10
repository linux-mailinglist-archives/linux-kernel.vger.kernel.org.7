Return-Path: <linux-kernel+bounces-809283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B7EB50B14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4CE5E56A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A6424111D;
	Wed, 10 Sep 2025 02:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LfGGUOtu"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297718E1F;
	Wed, 10 Sep 2025 02:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757471601; cv=fail; b=o/gordn2CIxTjvv7PWnDFracayx8qe0Xv2w2vue2AJRRrL81pyGVuqQn6ETU66BVHR43511YmIYkTdvxnDAQiYxLjkxoy7xM6QLFpWO7L+MIhshLjMcpzjGtLyv3oD4V+eZQU1zjLGLkwCStsqIb7Jio5pULfm47g4WrY+ZjBsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757471601; c=relaxed/simple;
	bh=u9VgWLXog5DjzG8shG0uOO1teSp8oanpYp4eG5P7Xuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DAsWF0gNErECb2huXlSorwhs6J182PxANrzl6k5QJCZ8S1T0T1Jz9Ko2YFhoCkqVKxwkj5ptpQoxn26PM/XBao/ZwWVu0q8ve2shX43sAr/avtYBK8OhZOYiZSZTgdDiw2nKwHikclCxEePSZ94LBM1F4A3GwwfBNECyjBKjh5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LfGGUOtu; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ie5ev+an8ju0gNg8McQQVhpGffnBlFo8+dDRSOL1hx8E4CAyWeEn25sLg05HOrrUYGpPZgsHEL2Dli27vW5Bldw4RXSjTKyZGF8E6zyn3ou/clACN8QeiYrsY7q1pobss5RjmWx9GyDpj1tFOK1Ct2BdQ70EHI6cvwyNrYGKK4YECwBa3bDjUsPChQKPc6Q/TGwfhiEmDQDBzbRQpIqNAb+1jt+HdxAQ1BsnJEXszp8A7GI+mYeALzawXh7T+6+p8mBMqUwt4iX3OZ26tuOweA2JS7UDJ8wMwRf2nDfcd5iZ+Zily3et5ufCKxhwA7jPUJVxkaIyc0yFpNnBegGyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9VgWLXog5DjzG8shG0uOO1teSp8oanpYp4eG5P7Xuo=;
 b=ejzZQkwdu+d6kJMQjqovNrzXZFvD8xiyDtmVoZzfbne1WYyyWyNyNBAU8jFnA8NzKDH9LAB9qItZwPiWewhQPFxKRt5uyhZnPtUChTLg6tT8oIgKiaOCa2sVTJsRWw16Y5HLa5vn/+A5qzX/IjahVp6/hE+t6eopi1VbIedDwecBo38or6EgV+qdB2PxSo6XACb1uOtthbyeaJnNubwVci9StN6mESEQq1x0q/mvjuq3pTLxd4mVtIgq6Og3kPyuViCK9B0xFG9Q4UyNk1RE15dbHswl9xZazTfnDq5NV5s3zEQXfzp0CFSIhrBf+A9JF3HRowB6rwU1ezGk9TEMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9VgWLXog5DjzG8shG0uOO1teSp8oanpYp4eG5P7Xuo=;
 b=LfGGUOtuzRUIJ5Jl1aQXd/5v32wz0ix1Es7JPigDiCIuMCgSwbaNGUGs7s7nRznufbMV/INOdaatxlBYgjOKzfrSs/EPxRUZi7ziCqui74xQoxP/XTzMi06HNgiaxNd0cUW6p0COFlmmvz6spbRW5Oo562ZM0cJ7smsw+xMQswQxe5M7M0uzuob3S6gvppeivHSrc84qVWidorhBTma0yX18iEkZUfYfT6UgAsjn+s90HZmJZARDj1gW+UVq67gAZkMb7r6amnx20HwGLqpsdP9gc55TCwmscGw6c1S7Ior/1ZdGtZFTqd9noe7cTsqeDi/KNhh0qASTlFjbvXYF1g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6785.eurprd04.prod.outlook.com (2603:10a6:208:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 02:33:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 02:33:16 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, Clark Wang
	<xiaoning.wang@nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li
	<frank.li@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 08/13] arm64: dts: imx95-19x19-evk: Add phy supply for
 netc
Thread-Topic: [PATCH 08/13] arm64: dts: imx95-19x19-evk: Add phy supply for
 netc
Thread-Index: AQHcDcOqPWhJYB2cHU6Q5dvXJIGBrbSKGTWAgABRCYCAAWrlAIAABaiQ
Date: Wed, 10 Sep 2025 02:33:16 +0000
Message-ID:
 <PAXPR04MB8459AE0C8D6A88632390C28F880EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-8-e609eb4e3105@nxp.com>
 <CAJ+vNU2hro_ZoRvmQ9yowKsX25AnrgZdGMn2D-RCkyJA02CEhA@mail.gmail.com>
 <20250909043327.GD20475@nxa18884-linux.ap.freescale.net>
 <CAJ+vNU3=mwZFBqQRNz4i28EjWXX6=Nf7iAsYPEBgpqkQw4wgtA@mail.gmail.com>
In-Reply-To:
 <CAJ+vNU3=mwZFBqQRNz4i28EjWXX6=Nf7iAsYPEBgpqkQw4wgtA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM0PR04MB6785:EE_
x-ms-office365-filtering-correlation-id: 804dd697-c8bc-450a-de95-08ddf01265cb
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVNTNHF4SnF5eDhvNnp5TVZ4V3daS2VJOWlmMERoZzdhUDZ0U1JUREVyL2Zm?=
 =?utf-8?B?NmVuLzd1YjNoamYvdi9MNEh3dEZHT0ZXY1B6K0dzL0hTYkd4Q0JWUGtxZTJi?=
 =?utf-8?B?WHY5T2tMcUgyNTF4Zmc3NlhyT1RBK3dLc0ljc3N5Mjk5VmR0U3lqdE5wSWlM?=
 =?utf-8?B?Q3RqRWpwdzIwYVdib2lNVU1mWUdJelNjV2t2d1oxbUkzTzFQa3dPNXE0MDRU?=
 =?utf-8?B?bFBybENqVTNxSzc0RW5JRXdhdlFEZW1uQlVWMHZtWm1GUWh5MmFsT0hBZkFq?=
 =?utf-8?B?RGVBc2RTSEVUcWNhZVp0bEVsb0R2WXBpdjBoNENYS0NYU0htYTVVU1ErcWZl?=
 =?utf-8?B?UlpQc0h0ZzhqYXNzcHZCc1poTXZhYjYrT1FHNk9iLzRHeW42dlpaWDZZbVBo?=
 =?utf-8?B?MHNZVGtMd1lNTTB0d1lEWmQzKzJEVkdYMDYxSDM2eGdjZE9VTlViUnlQSm8w?=
 =?utf-8?B?OE9GY1p6N05kT1JncEI1OHM2bkhNNG9PaFJKcml2c3pCbE45a1VGUHVZd0lQ?=
 =?utf-8?B?ajd4YVM0QWptcXhuS0owdkt3RkxQbStBNUxEVDVpODRKUUYzRmpyZzVlL3RZ?=
 =?utf-8?B?c3RNVFZyQ1RtOTMzYUNKN1JzS2tsRXF1WTYrb0d5emhoR2dqRm5jSTFiOWJh?=
 =?utf-8?B?RWo4K0lTNno4ZlNkWXBlZXprQ0NYUUFZK3Vnc2VoVUQvdXBWSHVjWTluZUN1?=
 =?utf-8?B?U0YwbnE1eUtVdTgvbUtOZXUycUZZM0FuVTZIVGJpQ1hFcGNYSzB3Ui9WeFpN?=
 =?utf-8?B?V0pvSGtJWktPcDlFZkRjaHRXOWRucm9NZ1Q3V2cvRXlmUk5mUmp2VHRYb0xl?=
 =?utf-8?B?UW1QOVJ0emV0WndzNlVUM2RkU1BXSGdZSjRMMGdzSThnTVhQYmRUOU9mT1Jy?=
 =?utf-8?B?b3NTS001bDlJcW1idUpaQm1Ec0hMWDFndHpGdDhxLzV2TUNzNUhGbzlwTTBt?=
 =?utf-8?B?YVl5aW1pZG1pUkVreXpCbzlheVd2NjBaaGM2Vnlmei9NaVRGMy9ZRm9HWUdx?=
 =?utf-8?B?VzZFR09vSnJ1OG9WVldDTHFOd29ZRGZZWDc1b3RaV3VsUE5uazVNWmx3N0JO?=
 =?utf-8?B?MDNlNkhsanNWcWRMWnFPNjMwR1ptYUh2TmMxTm1HTC9UaldvcGt6Q0NQRmRU?=
 =?utf-8?B?aVhFYlhlbmtSVk1lMXpQU0RoOE9IaFBlM3c3SXhGY0ErQVBuNDJrcGZPR2p3?=
 =?utf-8?B?Ty9TQkpEMnRDYS8wbXVHQUozWG5hZnVvRjRCb0lGM2dpaVBlYU1XWnFkdFVZ?=
 =?utf-8?B?VktUUWVSTDRNdCswNGhXOXorWDRCODFreTd5ZXptMStjSFdkeVp4d1Y0YlNK?=
 =?utf-8?B?VEcvUHpvRitHbTJUNlNsbG0wQThRcGgyK1dhYXdtUjQ1Q1Z3UEZWZHZnNmV1?=
 =?utf-8?B?U0g3VG8rdHltYWIzbGdOcEtRc3g0dTVjUVV2QnlRa0lWdk9FblZTV2RLbENJ?=
 =?utf-8?B?NXAweW9valpwVmQxbGV5ZkFQcHdMd0ZBY0RzTEZzYWNrNTdOa1piWk5sVHA2?=
 =?utf-8?B?Q1RrTklOSEMwQjJsSkJrNUZrdXRvN1Vjd3dtQVBjZVhRczlCakh0S295eFND?=
 =?utf-8?B?dzF6N2F4M3M1RzJUWWxZUmk0dVE1NmI0Z0M0UjdVd1ZHNytUYjhzLzY1emF4?=
 =?utf-8?B?eDRnVTIvL2F4TzdsdVJob3owOUNvTEprU21vbTNtb0xPWUZ1OTFlM1hmUTAx?=
 =?utf-8?B?YWgzdWVleHUvVDR0K05YTnZDTWpQYUtBTGZFTkRsUVFhQ00zSllpQlFjcDcr?=
 =?utf-8?B?NmQ3QzJyVWd2alFUbWFhNFFTcUFiVWZqdStScGtsbWwwR2F6MkxxNTV3NGlC?=
 =?utf-8?B?Y2tZZkgxMS9BUjVoRGx6dVlVZVREQUFPRDZOWEVUS1FzaGVSZWw4UnYyZWs3?=
 =?utf-8?B?YmEvNXlFYlVmMzQwK0lLa2NzcUlqTGZ3T2tRNVpmcGpZdFFnNndIeGNUUUNi?=
 =?utf-8?B?K01ORHAzQStZRXJ4MVJVUVZJY0JXaUZBckVTczhTdGFYcnUzdjlPd0RRc24z?=
 =?utf-8?Q?qtI1G3XyP/Cvi5ltzFH9s3OATxs758=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkhCeGJCQlFKU29XQ2RGUTVoVzl3MXE0RFpQRFNGUEZHa1I4Zy9UbGNXOXB4?=
 =?utf-8?B?a2pQaGJwUGs4Uk43NmdmVTU2SktJNzFIVURDNTF5SGh3MFMrVGtkU29XdWJT?=
 =?utf-8?B?LzROLzNmb2F1QTJGN0VQV0hPcWRiYzhvdVlQV3AzVWZxMEthWnBlc3Q1MDI4?=
 =?utf-8?B?clVMZDVKYWt0aUNNQ1YyaXIwaHhMd2RuZVhIblpieE9Yd1JuL1BCYUVkWkFC?=
 =?utf-8?B?aGhwTFA0QVJhVnc3N1hoOVQzTWhsMXVtaFJwSzRGZXlYN1Q0UVlHbVVyZVlp?=
 =?utf-8?B?ZFYrVnZnVGdra0dhanVXTkdyZExBNFgzZlZNYmlldXdwYVF0czN6aTQ2a1Js?=
 =?utf-8?B?UkpzQWM4eHFwaVJsaS9ha2ZybzZ3TmZQNlREMDBrS1ZJMXM1R2xCNjhRNFRx?=
 =?utf-8?B?cGNQTDhGUmx3eHhtTkJvbkdtc2xDZzRwMjdCV1ZYTWdGcDJad0hiQkdLQWth?=
 =?utf-8?B?RTFrUU4zSmhpaC9EdUJRUjc2TGphWkNVOW9xRWVWTjZ2b1VEQ3lwMzgxYmNG?=
 =?utf-8?B?TXZuY1ZLUGhqRnNZUWRNLzAxVzRKTEJQa3RqdjA2bGMwM3lCazJ2dW12K1dl?=
 =?utf-8?B?TmN1WnFpTUxLYy9STnZwN0JjdWR6L1Y0ZTg3QTEwcVpiZ1o4SDBnaFJBc2FI?=
 =?utf-8?B?MXdXUi9tQmlidThucjdaQkNBUThhbUxzSG96WkhvMGxpVEc4eTd3Wmd0K3l4?=
 =?utf-8?B?Qngzbi9xRHZYak15QUVOUFU2YksySWJ2WVBENE82c21WajZMam1SeFBuc3Y0?=
 =?utf-8?B?dGJNbHVKcjR1NVBWUElXOUpGQzNBYlI4WWdEUC9jcDlSL0Jtd1lNRjkvWXpk?=
 =?utf-8?B?UXJhc245VHFnSHNtY290eXRQd2JabUxGbW5oaHgxbXR5akxIUDZyVFR1SEFG?=
 =?utf-8?B?K2tuS05aOVNyRmx0NHJpWm54dUk2WU5sWkl1ZjN2Y1p2d1dTenVjVDJBSjhQ?=
 =?utf-8?B?TTJDdWMwMVJqQ1FiZXNVNGlzS1Z6QUJFRVdOK2gyZGtjaTZlbWpWM2t3eDhO?=
 =?utf-8?B?cWkwV1oyTGdFWDNMblBpNnM3NHc4WWRrekJldDMxMk9zcjVSN3Q3enUyS3A3?=
 =?utf-8?B?dHpHUHdRaHhHdUhEK09YTnRBeDdBR0llQkFFU2pzbGFDdGI0MGN1Uk5qYWtE?=
 =?utf-8?B?SWcwSjVLYUJoRlhJZVdhYzQxYjhYYjJyQk9kSkF0YjNGS2ZCaENwcWx3dk5L?=
 =?utf-8?B?VHFvcE9wQUthc3pOL0RrTFZ1aE43SzE4Q3JFTWZGcnIwY0tGSnlPT1BwQ2pB?=
 =?utf-8?B?cGRZUkg1bEhrZSsyL0FGeCtYNGJnOVdtb3lUanFYZW1nMkxlYXRuYXNJcWJn?=
 =?utf-8?B?TXltYmVKV1prV1kvaG9NYmIyZy9XQmdVRGhQY2JORis4R3dTNDBPbW40T2Y0?=
 =?utf-8?B?dSthK2FzTmZOWlRoQjZ3M1dzYlUwQ0poNm5TbXVkWVVsZEhlWTA3MGNjSFgx?=
 =?utf-8?B?QWk3ZnplTzhCcnY0UnpaMXl6SnRBOWo1NG5uOS9xSWQ2OGR2QmhGRml2b2FD?=
 =?utf-8?B?VFNCSy9oeU0wNXBmQnU2bzMvaFNVT3V3dWRQSHR3WnpjcHZBNXRCYXMyOU9J?=
 =?utf-8?B?UlU5UXc1R2g3eXR0OGh5WmZ6QUEycUJBbGFpZ2E3S2dkQVNtdEtQalFJTkJC?=
 =?utf-8?B?d04yYjNZS0Q3ZUk4cDJZbWUyQU1hUFFGRysybVUrVW1IbTQxK2wwOG9iTzBS?=
 =?utf-8?B?VjlENFZIZ2dFc1N4YlFvalRpRkcyM1UzT01OSUd5andsZzlvV0hJNmlMTXR5?=
 =?utf-8?B?a1BmZVhqUHFWWG84TXRHNDZJVXRlMXZBL2hxckJ6bXFNRUF2TStwMEd6bEJM?=
 =?utf-8?B?b0VaUDVvaFI0ZlIzY2R3dENWeWRMdjhVSHNJdTVPaXFCbEhWbm12ZUJQWUYw?=
 =?utf-8?B?b1VQaXhxSlpUWVhUZFY0V1hkRnBnSVVGbjBtT1BOWW53Z0wwRjBCR1Q2S3JF?=
 =?utf-8?B?TGNZQkU5UkNSMGc0UzJKWEU2YnByNmtYTEVtN09SWVFBb04zaEZqLzNQbzZt?=
 =?utf-8?B?aCsxeHh5Mml1TzArRS9IMWd6OUZmTUQ4NUVBamdjMVYrTGc0bHY4bXdaTnAv?=
 =?utf-8?B?SjV0aEJkSkhDQkNFV29CTTd3UWh2WlhpWkZPbDNOYzZ4L0x0ejBCWHNFeDcv?=
 =?utf-8?Q?pRWk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 804dd697-c8bc-450a-de95-08ddf01265cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 02:33:16.4055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHynVtTRfu4SMw52xeJKkv9q8UDRw6jJNbARRIbkL2cXWnz9kUwmK9ilyVioWgoaH5HeedUvoU5I9ZcdN4OQ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6785

PiBTdWJqZWN0OiBSZTogW1BBVENIIDA4LzEzXSBhcm02NDogZHRzOiBpbXg5NS0xOXgxOS1ldms6
IEFkZCBwaHkNCj4gc3VwcGx5IGZvciBuZXRjDQo+IA0KPiA+IEZvciAxMGcgcG9ydCwgaXQgaXMg
c3RpbGwgbm90IHJlYWR5IGZvciB1cHN0cmVhbS4NCj4gPg0KPiANCj4gRm9yIDEwRyBpdCBsb29r
cyBsaWtlIGF0IGxlYXN0IHRoZSBYUENTIHN1cHBvcnQgaXMgbWlzc2luZy4gRG8geW91IGtub3cN
Cj4gaWYgYW55b25lIGF0IE5YUCBpcyB3b3JraW5nIG9uIHRoaXMgb3IgaWYgYW5kIHdoZW4gaXQg
aXMgc2NoZWR1bGVkPw0KDQorIENsYXJrIHRvIGNvbW1lbnQuDQoNClJlZ2FyZHMNClBlbmcNCg0K
PiANCj4gQmVzdCBSZWdhcmRzLA0KPiANCj4gVGltDQo+IA0KPiANCj4gPiBGb3IgMTBnIHBvcnQs
IGl0IGlzIHN0aWxsIG5vdCByZWFkeSBmb3IgdXBzdHJlYW0uDQo+ID4NCj4gPiBZb3UgY291bGQg
b25seSB1c2UgdGhlIHJnbWlpLWlkIHBvcnQuIFRoaXMgY2hhbmdlIGl0c2VsZiBkb2VzIG5vdA0K
PiA+IGJyZWFrIHRoZSByZ21paS1pZCBwb3J0Lg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFBlbmcN
Cj4gPg0KPiA+ID4NCj4gPiA+QmVzdCBSZWdhcmRzLA0KPiA+ID4NCj4gPiA+VGltDQo=

