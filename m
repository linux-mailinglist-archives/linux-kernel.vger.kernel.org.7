Return-Path: <linux-kernel+bounces-799367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AB4B42AA0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B200C545D2D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E19D2DE6FC;
	Wed,  3 Sep 2025 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e76GJLcr"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43F82DAFB8;
	Wed,  3 Sep 2025 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930816; cv=fail; b=L5JiC2ruABhbKmpgO2lVZ9U7eMERaysdp+0MgjhKISY77uTqtG4yJRrI7fsxU2EbYoTCAgutqoxLXwx99fBgaLQ64CM1pi5LUK4+fSK3aDtRlg6JaWvE4oDvsk79MCymXy0xNIf3WRvHRxM4vI5+BOVMADW1NERQMSjw66oc/7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930816; c=relaxed/simple;
	bh=79m9SSJAiqxzjewW/Fj7W2NBcthLXt+JLYFK2YRuUx8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Gy5W+AW4hsBsSf5mO3+DbQiFlZ5mL8a5mgGFjtN1ifJRGu+pWirH0xtWGU5ZKiVGtIxMY5azoj1UOphHFZO0sOZt+BrdIgmMf6U/F2jPeDqQs950OOTsgHwm4wj2CztsLI+mgfFwk4gu3sLudhfkWKec4Uu1WHdDt7LuthyKzUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e76GJLcr; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJqikLDZVMUVOKF/9QHd0llWHUmY7UoZuQSqzjcqAreBeS6ptjv2CfRkQLYWMUJgtZ5bfFxsYC0lgM3lvHi8YnrGeRxGQg0GrKVLZmC2utGm0Trqm0cM7B/w0DMTYzqGW2uusOJSRfyC4UXA0QjHGQNGysdk6NJ0EarWyqnJodEzcBsbG4ANp0jG+NLHAv4J/blpDSUr3yHofRQCSjyQdbT7P1c+nJ0iUh1mbyH9WiZ/87/PjqA3Hj8LihZ240tKAPZG8ftpw2VP+dbI55Nsof3RdUNr0viWFDnpRB8I2+UE8hc1TrPQstWQUYBMDRjBIlMvTMOiWph1oyiswVfImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/Zr5v6p9lA96vh49o+CprEu1IkDGYAMuJLhyW9Cnyw=;
 b=wYLgZ/jPnt7yjbdB48AYRi+csQwEfjkHOJ4OJVa6z9YnzEHnr3Pvdt7JNAtFByDC9ddwbR4KmEeUKOPOWwMsmB/JU3ysFt1RE4AWRGgjLIBNGmxHm8+Fzt7yW+pbEmcwpFr32KqWwz4qn9db7FY8m7m/P5cCVVQYR3dJg/jvtgo9FZ8vkOD/iGeQaCHvN0J2B6resZAlzEJ0JwFZZDaEFi+aTGwIavVrMJQISBIKgUzXo/klLGqMK50YTO1kq2K3SbBIsfTG+cwF/7xU9sCIpt6HwemHUJzoFOgYRYKdKRCXWv/sap8KAB5PpgsPgX0jnjiVcTnhery1tR0F1VNhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/Zr5v6p9lA96vh49o+CprEu1IkDGYAMuJLhyW9Cnyw=;
 b=e76GJLcrW7FWoD2qjdJIg2O4Co7If53PMmpv7JfYxF0mUSvw64QFCBQPZ1rrsNkVrWS2H3kimaWrdFGggAUHCmeqJYoIhEemCP2ZXySehjkNfHntL7nyyEnClkqPc6GksJYRycNHUVgB5ZNUqe34YTZ47arzlsCi57nKXdK/i1LWEbm//rDq2PLYBMA47wJYwzfC3uUeVDfimWsOwMfECkzgiD/EWiMAinVQLcQP1Vejn23eQ0jGSw2A4zB80NleQEhGq9pnc3nD6Vlz9zAESYDOkDNG2KJQGJs9BU8nWPn1Vc/T+QZzCAxX7nmVIIqrHb8g4WIatTX7asjnyeJszw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:09 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 00/16] ARM: dts: imx6: clean up some dtb check warnings
Date: Wed, 03 Sep 2025 16:19:53 -0400
Message-Id: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOqiuGgC/x3MQQqAIBBA0avErBNMMbKrRIjlZLPIQqOE6O5Jy
 7f4/4GEkTBBXz0Q8aJEeyho6grm1QaPjFwxCC4U11wy2nJr3JnMbWOg4JmVOPFWKKk7ByU7Ii6
 U/+Uwvu8HHvFLPmIAAAA=
X-Change-ID: 20250903-imx6_dts_warning-a3eb0625398d
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930806; l=5364;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=79m9SSJAiqxzjewW/Fj7W2NBcthLXt+JLYFK2YRuUx8=;
 b=eZ+T0VcJEs86fCTvw+H8mKKVrPYavrDj1FssRtHjP0UarhqZjCaPQzrrxAMddbzv1RjwQlnsN
 PgzyTXyXrYuBPJbeT1PjwaEKtALSa8Q7XEvwF3fLJJ42Z4AUR/egn1L
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: c261701c-aaa5-4143-2b7b-08ddeb274785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEZvQVFnMFM2dzEyaUNzK1VaR2VPMnVyREI3SmJRakNoL2JPMkR6RDdDalo3?=
 =?utf-8?B?a3lmWnU3c2krMzBscGd3eUJqaUs1b0ZWVWJmOXhuWkN6elVvcklEL1VOSDZi?=
 =?utf-8?B?bTltSFhSSmszellTcUVyUXhMOWx4aFJadFRYbUhTMjBhN1AyVjlBN3JMUTBU?=
 =?utf-8?B?YlJyc2NQVktiZWtpLzlHLzMrM0w1bE54cnlSWGVsMzlsWlltWjlSZmlNUG1O?=
 =?utf-8?B?VDlIaE80T2FJZDB4ekZHRUN1UnVVTkhCTmNQVTB6ZTlVWFNlZkVmSDJKc1Av?=
 =?utf-8?B?TkJVM2MwKzRHUnZRcE5ocWVDWTJJemFPMlhrdDc2cGxUdTVkSDJtRFNvYXVY?=
 =?utf-8?B?VEUxcit5RmpIa2c0cGpiSElGMFg3V1NYbTA4Q3JSMC9uSzdJZ1M2R3FVbEZH?=
 =?utf-8?B?RUxxRW9pQmx6WVlGNHFFTnVDVEsyMmZoOUpObklFSU1TZjdxRjdmbnFjYm9S?=
 =?utf-8?B?QW5veUl6ZkJ4MG90Z29lNHBYSWp6Q3FTOE9ad3N2NU9SdnlXSG9aOHoybXlj?=
 =?utf-8?B?ZGMxcHZaWFB2SHNnMWF0WXg5TWdXUXhLTGtSMWxSdE4rczh1QnhLVEdQTW13?=
 =?utf-8?B?QXZnenE3YWpFYTIyMkNuT0xhQmxZMG10amhxeFlnekVyRmE3NjY3Zm5KaE5t?=
 =?utf-8?B?M21veWduU3pCZEJTVG81UEVvZkdOaHBGZzdoNVpEaEtBak9wN1oyMCtzVFE5?=
 =?utf-8?B?TFAycGFMMnYyYmpBSVZBVEw0NXdOT1pKcVRVNllWS0RVZjE2UTNucFZIWHEw?=
 =?utf-8?B?bnU0SUIycytMY1NFbHJmaE9CZVBCa1Y2aUhaUEl4TjAzazhjc2NHQWZ6a0lo?=
 =?utf-8?B?RmdrZ3U5UHlOR3J4VVc0STN6MFBiRXpNQ29PWXY4bG1qMm93ZEhlQkRFWUIx?=
 =?utf-8?B?Y1pQby9GT1JNQkRDQ0JtMWRaYk5tdlJ4STJqaWxpWU5CaDVLM3hCZjk1Qnps?=
 =?utf-8?B?b0I0cUp6V1g5aENKZGR1TW52dzY1cnMrbjJCN21DeWRZSGJKMVhRc1BzcHhi?=
 =?utf-8?B?Y2gyb1p1NWdLbzJaVCtpU3EyYXhMMHVsaEluN1djMnRWZExkcHlUVGhuSTRF?=
 =?utf-8?B?a2ZOSWIyam0xZ3BHM2xoOW8rcCtRMEpBVXcyaFZhOXlzV3pjdXFqa0o5QzNh?=
 =?utf-8?B?RE1kRUpYQ0dpWmFNeVYwWDZrakZIM0hrenMyQ2xSUSszdkU2NTVuTXNuek5a?=
 =?utf-8?B?cVZwQXpUUWx4cmVFdEtXWEVQNXpWTHd3RXVWdmpISjFSa2Zyb21qelViV1RC?=
 =?utf-8?B?RU9hYWFOOXRtWTRjejd6QVRrTkhTMlo3d0NZWUYzVGl2RHpPZE1ORktDSGJ0?=
 =?utf-8?B?T3hkdDhFczJNMkpXVnZYQitjVFVEeTlhZ29DSGErVXVoOEM5WEFXcW52WDR6?=
 =?utf-8?B?REhHc2JQWmg2cXd1d1ZoeTlMQnJzUFI4WEVLSE1nV1F0YWVIdHh1SnN6TWZW?=
 =?utf-8?B?WTUxSk9pK1Z1TlA2Yko0cWF4b2s3c05BNmYvOGJ0YUhhUkVHN0NxU2NqMHBD?=
 =?utf-8?B?ZW9PY0NaNUhDVkpINVpXS0FYVFphalNQODhySHlhV1Y0b01Tb3NjdEZqN3My?=
 =?utf-8?B?ZzNTY0liNHZoZC9DUldKWWFqNmp0T1hVV00yam5NU0h4V3k1MGhMUGJPSFdm?=
 =?utf-8?B?eDI5a1Z5UHB6QlZEWi9OUGZmM2RjTXQzZzAxdm1JM3YrZlpiV2thN01VSXdI?=
 =?utf-8?B?SThJRkNjR0RmOTNMM2xaRzUvM3FucFMyQks3eW51UUVpbTdmVVNqNlhXUnho?=
 =?utf-8?B?R0x2bkwwTXRaRUFnbFdaSUpRNnM4bkFGLy9ZUEJGakh1d21UOU9TUC9RVVU0?=
 =?utf-8?B?UGhZTkUxZExVdFFsM09jOUF6TjRJM2x0YlpOaUZleVBjbDlGWW5QMmpGcjhC?=
 =?utf-8?B?cDhyVTVFRC9JMDFNNENOZzR4blJhbVozMEJUVFA5ZVZVK2tkL24rMGZDdGNl?=
 =?utf-8?B?TTB4SmJxYmNWRHFwTjY3UWRBeE9NR1gxbkk0L3l4czR4bmxkVlRPTFREMmZV?=
 =?utf-8?B?Zk4xQmVvY0F3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU8yc0JuSFR2QTVURU5FU2xmNkhlZ0JZS3RONk4yYXZPUFNKc0dGWG5Wck9Q?=
 =?utf-8?B?N0ZLM1JvSWZyUE11R1JkY1FNZlJpNzJyK2VBWFViQTU3NVcwZm40MEZxRzBW?=
 =?utf-8?B?K2U2c0xrZTQvMXBPOTROTmtaaUY5cEVZZXMyQWF2QkpmSktUMFp5dWhsV3BP?=
 =?utf-8?B?QWZSNDVQOW5makdnZTA1WTA1MUFjeHZ6ZENwMzZ5S2FGM1ZRQS8rSnhWTllS?=
 =?utf-8?B?clhYSDFRdHJ1RFlESXJpK0k4QzFPNDFzazBDZFY2R08xYk5KNUIzS25YQ3ln?=
 =?utf-8?B?ZnN0aDhENS9Lblg0M1FYUTNZdHlUKzIxYnlIN2MxNlZKZFI3bE1iVGwzSFdN?=
 =?utf-8?B?Zk55cXRQaEpMTnVaL3E0bXJjZGxTV2o5MVUyUHRVUWxZT2ZndkVsNXlkN0l1?=
 =?utf-8?B?dGdRc1RKWlQzblVUcmRNMVBGa0I1c1VGWTc2c3RzUld2clBsNkhlanVPMnRC?=
 =?utf-8?B?ajVRZ2x3RHd1aFdLZHV6SW1tUHkrdEhyT2xBT0dFSE1oa0tnY0hJR2EzdGhU?=
 =?utf-8?B?NWlQMTVNbFZIWExKQVY3a2taQ2tSdHNnVVJQZjIrME9Jb3BVY2NXSTc5Y0VU?=
 =?utf-8?B?TEdQeDNKMzhrdGQ4V2htVzh3bjJCTk5rZ0ZhNjhsZDEvcG5pamtDa0lWOFJt?=
 =?utf-8?B?K1BvVkFUdUU4ZWdiZzlkQmpUVTFOaXpZNnZmT1BuakFRUE8wRkNQekdrVWh6?=
 =?utf-8?B?UnR6TE1hNmhZU2YzbXRRbWZnb2tYMy9rSS9VSzlvQ2RJS2pmbWJkbGdtRlJE?=
 =?utf-8?B?ckF2b2w4aEpPRU5jSWJIbWtaenFDVEZJVFl1cm1uSXpxVjB5Rm9Bby90eVBk?=
 =?utf-8?B?K0UvT2ZHeUtaK1dnNUlmVmpzUENmcEJEcXdlVXZwOFhWNDZuVWlkVXZlMlFU?=
 =?utf-8?B?RGZCM2pMOHNNTDZvTmV5b2wrSEVXMUFDQmVnMmNqdGVhZG45SzdxdFArZG5w?=
 =?utf-8?B?dC9ZOE1oYUw5NWNKYzF6azJ4Wm5vWU5ZZ1JTbnovQzNOaTNUV3NCWEJsTTVv?=
 =?utf-8?B?QVg0dkIrcTErSjBLVWVySCtVK1pCejZSOEppaVRnWWdYb29kcWUxUG80UzVF?=
 =?utf-8?B?b0xkRmhaTjRSZnptLzhYZHBTL21WaWZKejRaM2JBTnkxY1hhNFNtS3duNWlq?=
 =?utf-8?B?aHAzT24zc0czZFkzYm52OFltMzF1MTJ3bmpqZ1VBalBwWGx6ajV6enA1enlQ?=
 =?utf-8?B?OVdFSGlOR3Z6MEJwYk1nZkx5eXk3clcrek0wamp3T0NWNW03OE5vYUswUTZW?=
 =?utf-8?B?TVV6T3NSSi9YcFdIQ2pjWG5QM3dNSlFLd3RBQ2hjTWI2c0pDM2owby9reHRK?=
 =?utf-8?B?UGtJcms2K1o2KzJmcS9KMDljTUM1czRscU8vRk1mY1MyR2ZkbzdPaHpxU2JZ?=
 =?utf-8?B?QlA1cy9pRW9EamNTMDlBdTV0SEhSSGprazVXUWg0ekdYcVhFZXd0WUc1SlRE?=
 =?utf-8?B?QXh2c1ZYRUV0OEdOZWFGMmlaTDkvSFZwSjRaQXRqQzJEd25Xc04rNENQQlgw?=
 =?utf-8?B?amJ4clhwNERhRHJhMjRtTUxFK01vdHExS3dvQk5sMDgwcTYydi92ZE9Fc0ZP?=
 =?utf-8?B?UGRvYW9Nbk9pS1E0WE9USDBPaEpUV0F4dXhNRXJNUy8rUk5DUi9hU1FMTXlm?=
 =?utf-8?B?aWdPejJWTTNPVUNMNzVVNHpIVm5XUXIvZHJPTjg4TjlhNGtkMmV2OTJFSnR3?=
 =?utf-8?B?U0NyM1lrOExkbllvL3Z6T1VmczhoN3lVc3FnYlY2NnhMOFJ3R3N4Smc0R3c0?=
 =?utf-8?B?UGo3L2IvM3lvTlZsNnRjakV6aEJBZUtYYStzajRSOUEreDZIMHNMbHJVaWpN?=
 =?utf-8?B?OWJjV2VtYTFJdWJqK0VQc0hrVHgvcU03UmF5d2VUMFFtUElFOHE3UWorRkJk?=
 =?utf-8?B?b21qRlo1eGJXOURXU2JGcDBYcVZ5M254Z2FoaDNvT2x4dUlrQ0pCaGN5aGJV?=
 =?utf-8?B?STNrMUNweThmRHNkS0FkTFBYNXMzUG4reU9GNW1ETVRIVXBaVEhkeWloQlhr?=
 =?utf-8?B?eDloaS9UbGxDMFdHbjd3cmhMNmM5L1pJU0Q1MUhCNk01MjlPV0pxRmp3Q3VV?=
 =?utf-8?B?R0RnU0ZoMHBSQ3VUT0dlbFlOZEhNb0JudTMwZ0ZNdGpDakNheDBiN1JJaTBO?=
 =?utf-8?Q?c/uEWzSlJ9gdjNo8KagWryCGp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c261701c-aaa5-4143-2b7b-08ddeb274785
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:09.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IETPm10p9cpzKpuv547K+Izfl+BWNchI85as6QbS0MaI8o6oJPo/9eblZW9snt948jxb5PH3SV35oPUqEKo8Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337

Cleanup some some dtb check warnings for imx6

---
Frank Li (16):
      ARM: dts: imx6: add #address-cells for gsc@20
      ARM: dts: imx6: add key- prefix for gpio-keys
      ARM: dts: imx6: align rtc chip node name to 'rtc'
      ARM: dts: imx6: add interrupt-cells for dlg,da9063 pmic
      ARM: dts: imx6qdl-aristainetos2: rename ethernet-phy to ethernet-phy@0
      ARM: dts: imx6: remove redundant pinctrl-names
      ARM: dts: imx6: rename touch screen's node name to touchscreen
      ARM: dts: imx6: rename node i2c-gpio to i2c.
      ARM: dts: imx6: rename node name flash to eeprom
      ARM: dts: imx6: rename i2c<n>mux i2c-mux-<n>
      ARM: dts: imx6: replace gpio-key with gpio-keys compatible string
      ARM: dts: imx6: replace isl,isl12022 with isil,isl12022 for RTC
      ARM: dts: imx6ul-14x14-evk: add regulator for ov5640
      ARM: dts: imx6ul-pico: add power-supply for vxt,vl050-8048nt-c01
      ARM: dts: imx6: remove undefined linux,default-trigger source
      ARM: dts: imx6: change rtc compatible string to st,m41t00 from m41t00

 .../boot/dts/nxp/imx/imx35-eukrea-cpuimx35.dtsi    |  2 +-
 .../boot/dts/nxp/imx/imx51-eukrea-cpuimx51.dtsi    |  2 +-
 arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx53-m53.dtsi           |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-alti6p.dts        |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts        |  1 -
 arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi         |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-riotboard.dts     |  2 --
 arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi          |  2 ++
 arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi        |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-dmo-edmqmx6.dts    |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-dms-ba16.dts       |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-gw5400-a.dts       |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-h100.dts           |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-kp.dtsi            |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6q-mccmon6.dts        |  2 --
 arch/arm/boot/dts/nxp/imx/imx6q-novena.dts         |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi      |  4 ++--
 .../boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi    |  5 ++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi     |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi     |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi       |  4 +++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw51xx.dtsi      | 13 +++++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi      | 13 +++++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi      | 13 +++++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi      | 12 +++++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw551x.dtsi      | 13 +++++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw552x.dtsi      | 13 +++++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw553x.dtsi      | 13 +++++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi      | 11 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi      | 11 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi      | 11 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5907.dtsi      | 13 +++++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5910.dtsi      | 11 +++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5912.dtsi      | 10 ++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5913.dtsi      | 11 +++++-----
 .../arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi |  1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi   |  4 ++--
 .../boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi    | 16 +++++++-------
 .../boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi   | 12 +++++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi  | 12 +++++------
 .../nxp/imx/imx6qdl-phytec-mira-peb-eval-01.dtsi   | 10 ++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-mira.dtsi |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-rex.dtsi         |  2 --
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi   | 10 ++++-----
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi   | 12 +++++------
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi     |  6 +++---
 arch/arm/boot/dts/nxp/imx/imx6qdl-savageboard.dtsi |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-ts7970.dtsi      |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi         |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-vicut1.dtsi      |  1 -
 .../boot/dts/nxp/imx/imx6sl-tolino-shine2hd.dts    |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi          |  4 ++--
 arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi    | 25 ++++++++++++++++++++--
 .../dts/nxp/imx/imx6ul-phytec-segin-peb-av-02.dtsi |  2 +-
 .../nxp/imx/imx6ul-phytec-segin-peb-eval-01.dtsi   |  8 +++----
 arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi         |  1 +
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi        |  2 +-
 .../boot/dts/nxp/imx/imx6ull-colibri-aster.dtsi    |  2 +-
 .../arm/boot/dts/nxp/imx/imx6ull-colibri-iris.dtsi |  2 +-
 .../arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi |  6 +++---
 arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts      |  2 +-
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts           |  2 +-
 63 files changed, 206 insertions(+), 174 deletions(-)
---
base-commit: 84bbaec999e38e78b1394d46ef6e273cd9afa8f0
change-id: 20250903-imx6_dts_warning-a3eb0625398d

Best regards,
--
Frank Li <Frank.Li@nxp.com>


