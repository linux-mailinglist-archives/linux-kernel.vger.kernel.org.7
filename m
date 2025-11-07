Return-Path: <linux-kernel+bounces-891014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C65B2C419D4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A56234C724
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5641E2D8776;
	Fri,  7 Nov 2025 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jSEwFyrz"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A991C30F7F2;
	Fri,  7 Nov 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548296; cv=fail; b=pYYOzht1rqA7/F8ZJ3MBo/dQstBVQ3t6o7eHyNA2zNE5/ZxDXOPVb3gjwomn2QOSEoXUBQFrSvvbPML4vCNA5N/dZ6h1C/KOwVbTbRHafWhRkqMmmwnuWWkN1/H2OmnNFdf3GiuNx5cuQ00dCULXDwQnqo5r7BkRQETTQopEztY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548296; c=relaxed/simple;
	bh=LJheYFsFE3gTgbB/4exm7kW6px7qSqmIClCgzXMKKxs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sxMRsxTrt6VHBTljZZZeOxnv//ZuJp57FmFQ4/XIkEClSoqdlXf9grcMJFjZPGtgFMFHoL2ktOWwzQ20YQ0Vyna/eS03jsH5smzfk4/X948IAx0tJhTASv32PwpqBa3juzafozI6MNDIvtASCfqcsdpwo49MSffgCD4swTdND6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jSEwFyrz; arc=fail smtp.client-ip=52.101.84.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxpzALqy9glufjPjbv2r1sS0Ydxbq43udEuwOeRT7hA6TuWfr+a0905eEgDwMezYgABLcgJRMFYj8/ywE43DLR/vnrmq1QsvEhL3YGRrmFYq3jTTt7KFfV6/GC84leGTPOkJ6MQmfmBck5/Wc5c+fxn3x5trGfkM9k5cnHqZR2ksTe9epuLgt9BL9CmlHXg0U8hMsg1iC//EOg97m5XpFJEmREI/sxL1lrMG22B6usvEEXvHHXmpnL3fBAZNdE1gEIaURMxC42xgpVmZdBQoVuvd7Dk0/nq3udHULxP884DZyerIiTER79SYD6+kj17Ygw9hO+XmMCPqM7154ogmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWDSKYGOK866sldsSpKS6S3hnBKaYQtP/Dg7w21A5r4=;
 b=yuleaUYsCgkHgua+Uu2FL8CMd9NZ4sYPFFRturK2RzbMpo426B/993Gvz8mhBLoM0H//BDAV80lR+rpXkSjDQSkDNQza9EBrKkbmEpO6Dojr0kYzxq75M/cus+5P1dD+VGzMp4P1SZloFqbwORxWI71Umy1N37gyEFEzEP0EL51ILAeY5OeXBcmZ7EFpmA6VhK7UYQfaZHqBfqbmr/TyX6I4uI53m4A11XSxOVgU2jnl7q0bP7KFRBvqqGw98nBq3DSrCQesw7/xVdhWB6dkR3X+V0iVA9SjKHKJ/Y5rww2YyewxZV4A3rDfbsKMxymDSqCoIWTyGqDCFl66UGuJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWDSKYGOK866sldsSpKS6S3hnBKaYQtP/Dg7w21A5r4=;
 b=jSEwFyrzLQFMhS+eYdZVqSSXAidaxdszi0tblMDIvDMarLXbI2yGWStadwsGj0ojzmyLxw4Lq8FU+Y5Zf8uRFQO/wCekE2YY5wLRV+4z0zdOOgllsBqM6qH7NP8555UxiCLjICCbDBrLp2mznlKCj0SDORupfXVqeVBi8JXbbtgax3ke+ODHtZx78wrYY77MJDShaqdgEqU4IivMqGQc3GNjcLsLknYsJtbBPtyTjeFhkxd684SWm3KRrRIvd5Zyc4oAElaEbqK8ES3o5lvx4lOJJ8U1A4AI0khuWW6tnSISKgyDMfkJ1Iooqxh7DsQKU5VAOqrAt1OgWxGsbcD6Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV2PR04MB12021.eurprd04.prod.outlook.com (2603:10a6:150:301::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 20:44:51 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 20:44:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Nov 2025 15:44:32 -0500
Subject: [PATCH 1/6] media: staging: media: imx6-mipi-csi2: replace space
 with tab for alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-stage-csi2-cleanup-v1-1-5d42535243ac@nxp.com>
References: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
In-Reply-To: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762548279; l=4945;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LJheYFsFE3gTgbB/4exm7kW6px7qSqmIClCgzXMKKxs=;
 b=151hCgavd5sCio2HKF4MWd4pFEX1ViaKDQ51oSewSRCYJ4qE3wm8tlTnZFGwVIJIhgi3nC+8j
 Zw4P87fghD7A4uuQW6tOnJ7rmAa6ApLU8RiCj4GkoZ/Mk7bSbjwFX9A
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV2PR04MB12021:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d54fdf-9cf3-4c37-ca11-08de1e3e7f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWdoR1ZNN0pwRVZDQWpMVW9QOGxHOGRQaGVwRjFjUS8xWFd0TjNWMldLWjRE?=
 =?utf-8?B?VVBWb3J4dUJKMUFwZ3c3WGxneklROHYvQmdPckQ0OG9BSmlXeVpWNG5nUjBM?=
 =?utf-8?B?di95SE9DYWQ4Y3hkcUJyZytac1FSK1NuZ0RKSzQreGRZb3d3eldJb21hWStx?=
 =?utf-8?B?WU1qSy9IWGU4VzYxUk41ejhLS2N5cFdlOFd4ZzJPSDhMa2x3Y1Z6WHJRajlj?=
 =?utf-8?B?WHd3KzdKQlRBK0pjSVhhWm0xa2wwQ3VrTWdtYm9xRExhLytqcHliSlkwV3Vj?=
 =?utf-8?B?cTNUVWQ5WUVqYWRTeUk2WEFONVQzMWtkY2J0RXZJQmdMRGYvWHlYVW9WeXFl?=
 =?utf-8?B?OEEyc2R2eGc5d0VGenVhMy8xVkVWV2FiTUx0YU5LREkxSFdrODk0TWd3dy85?=
 =?utf-8?B?TnVpTVRwdGdsK1VCSW1uRCtEK3B4bWhWS0pUR2RWOC9Nb01KTDR4L216N2NM?=
 =?utf-8?B?OUt0SFlpeHRjTjEzeGZiTngzc2NLVFJ3VjVpMHFJMjVHbjVqdkZqaU9XSDdl?=
 =?utf-8?B?dDlrVWJDeE92RkFwSzhSZkt0bHp1OUhNRW9wMElDcVhXTVpucWU5aGFHeDJt?=
 =?utf-8?B?cktTbStOUUk1NW5FTVNnSUprUE1lVTVmNVd4R3lRWWNFVG9FMHhXTFN0ZEJY?=
 =?utf-8?B?b0JKOXM5bDQwY2FMTTZKRk12S3FxNFNXd2FwenhlMWs3Z2JnYU5iOUpWTFRD?=
 =?utf-8?B?eVVNYkdSSms0ekNNcFkzQjVjZXdJQXh4TTlZZmpTOHZ2NkZKKzkxamc1MURy?=
 =?utf-8?B?NGFCMTI5TEFndTVyeFROWGxwR0F1WkVrMnh3dXM5R0dNMVVtdThBWGM5K1dW?=
 =?utf-8?B?N0dVdEdpZnQ2Q2hLUEJJUWtoNnFxQVRzeWtuUFdoNEhFeU1SamhOb2NDMjc4?=
 =?utf-8?B?UHFjQ3ZqbVhOMERLakhqL0I0VXpMZGJ5RXc4UkU4Rjhpb3pwWGczcTd0d2du?=
 =?utf-8?B?eVdhS1hpQzdHQzEwRDBya281dEpmQ3VWWmJ6OGFTMmZocHBMV2h2aE9wSWoz?=
 =?utf-8?B?R0tPMXVrNDg2QUZqN2NhVWFRRFBFOXZ6SkhYbHZMNnJQbTRGTm9zcnozRkJk?=
 =?utf-8?B?UkNLaUFrSEJSbXNqVG9HRERDRmZia1NYbVFQWCsyQ3AyUVliNnQ2UXppUEF2?=
 =?utf-8?B?b0xFTzBvRUlLblZDdFJTS09zSEpKbmxidFVkRUlzaUhWZkVyS0cvSXk2MTR3?=
 =?utf-8?B?Wk8xZE4rcTE1ZXRhcjNwNWZ1VlA0anpleElCZkkwNytCdWoxVkQ4NmY3cWRk?=
 =?utf-8?B?YjlXSmpEUGhxaWJRR0JBUEY1N2JPOGptaVhsdkM1Z1gwVTRwZ0JIOU9ydjZy?=
 =?utf-8?B?R0doODBVR05ISkNRbFJyNlc1My8xVmYyZEp0aGZJWnhBbzAxWWlHWjVVanIw?=
 =?utf-8?B?TnNHWWpGMlJucWUwYytBVk5vc09mSWR3SFVtS2dLNUpmcXptUUhzeWxqQkVF?=
 =?utf-8?B?Vzh5aTJJRGRINUZ4NkNub0Z6N2NZbjN0ZGZEYWRMUGhJck0xUmZicmw5NUdx?=
 =?utf-8?B?aU0vWlIrT3NJVnZWTThPZ2N5ODljSTc2emNnY0hFajV4UStOcDUyVHFieldk?=
 =?utf-8?B?QmZNQ3diOFZIV3hvdHk5UEtEWktUbVVyRzFVRTRvcTJsZ1RhWVlOOGZydStm?=
 =?utf-8?B?MlBJeFRvVXNZcVhJeWdWbmcvRklOTGwvWWIwaFJlVzhoTEc5c3VadXIzci80?=
 =?utf-8?B?ZXZMYlpBL1VGTmgwMGhjdUtCMGxuYW9TWEdXNnE3Rk1vNkVqaUJSWThDV0VQ?=
 =?utf-8?B?bEFuWkNMRkhiMVRWRUZ3Q0xSRGQvZVZ1M0pmei9PQ1Y5T2pDL2plM2dYMGIz?=
 =?utf-8?B?THA2Zlk0MEwxYmpRY3Jpa1MweHVGVy9GNDgwdEVvZlhQZ0F1cGVQVWVIUVNa?=
 =?utf-8?B?aWJKY3ZRMkpDTmdrekxvbjdpRVIyMXc5ektCelJzVEt1cCt2ME5qT0RvV1Bz?=
 =?utf-8?B?RGRSL1llNy9jMU9WZmFWazlKU21YLzFZRk0rUGw5eS9MTEhqTThiWU15L1Y3?=
 =?utf-8?B?bVJXa3E5UnFLYThDK3NuTVZTbG5kanpyOThCbFVxeHkxZGhHNXZBYzZMd1hY?=
 =?utf-8?Q?+lm+/0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTEzMXRxMTFuU0Vqc2JoS084L2hPdFRHVTBOSkxBZTlWcnIzSEJ4cDVTUG5h?=
 =?utf-8?B?ZGdCbEZpZGJFRU9wR2JXR0JCWCtja0g2NFpKdGNkbzh6ZHRZOXRPNWJ6UCtx?=
 =?utf-8?B?Q01ITmw4MTFNTkNJQmw0aFJCWFFHRzhpU3RqSEVPc0VLelZnN2NEaER1bnl6?=
 =?utf-8?B?RzNDTzlVOExFcThPeVVwSXVGUnVnTnJ0aVhIZkl1cGEvZjlaaEg2RDFxaTNW?=
 =?utf-8?B?UVJZZmViMGduSkN1ZFZCajM2bFB0WEdKSk5ZalBNbmNzdGh4R29GUmREdWp5?=
 =?utf-8?B?QkI4alNQWmJ6WjVCbERKT3gvbVprbWZSTzhCdjRGdXVGeSsvZXZTT0ZWRnp3?=
 =?utf-8?B?c05tQWtRbDdHNUxSYWZ4Sy90OUhPVTcyUGx4c2k2NlhUMFBhcUJ3ZFR2bDFY?=
 =?utf-8?B?T1RrVXdFLyt4dEhsWDRRazQ5aUJkOFI2M1JsWFcyK3ZRK0lYMFplalZRYVMx?=
 =?utf-8?B?STlXTTUzdjlCMy9mZklvamdWbDNEeGQ0bzJ5TXp1VFc0R3BvdXNid00vQk5x?=
 =?utf-8?B?ZVpyZ0FHWElsMXJNeXJBRUtENFVtSlpNOTkwNCs4YUhzTkNXcHFOMGhUYnU3?=
 =?utf-8?B?enYyZHZmTXBkcDZxR3ljaEdMZFYxOEdhK0dGTlluMWF5WGZsUFJnd1hPbVBk?=
 =?utf-8?B?ODkxdG1pVHl4YkNHQ3RnV2ZXWjVnQWloUThpU3o5ZjVlaytPWklKVjJMSWtN?=
 =?utf-8?B?ekxZYXNaQXJIN3NwMFlhWW9XblBRcVpzLzhPcWZuM0lPVnJPZi9rR0Zhb1hj?=
 =?utf-8?B?d29KYWRSSEdsWDRzZlFGNjM4OUFkOXV2MU1WTFBFek5Jcyt5dlI3d1BHMmda?=
 =?utf-8?B?UFJreURZbzBEWjNoMDRKV3RXdm1VWmRzMUFkWTJHTVVWd2VPV1VoOVI0TDRw?=
 =?utf-8?B?QTFTT0lhai9IeStDeWZjeGhHUGJ1eFRhWDdiZS9zL2crVkZTRGxZRWRvNU1B?=
 =?utf-8?B?MlBnQjdlZWFPZUlDYjlYTzhpRlA1dnY0eFpYNytoekh6MWFRQVg1cmI2bkN1?=
 =?utf-8?B?akZUMDlZMW41S2RJbjNhOGlLaDZSL3pHNUNKbjd6Ym0wZTBNTjJUcVFSQWc1?=
 =?utf-8?B?UU1idkM4Nm0zSWloNDJ3bHBJd2lKOGRENWV0ZDNzWlNHdzQyNmZ5aDFPaS9a?=
 =?utf-8?B?aEFUOUdpSE83eEp4NThGUEpPL3JoVVJuZ2c1RGkzZFBqWjNtNVd6QTJiellV?=
 =?utf-8?B?QTE3ZGREZXFqdGw5c2lydWJuNzZSaUdRNWxldCtPSWhpK1QrSW5TSnpTUG5h?=
 =?utf-8?B?UjNOVnA2NzFidHcydnUxM2FuUTNtVThvUnRaeXVqemdZVHRYV2Y5S2FoOXZ4?=
 =?utf-8?B?Ti9qbVVuQk1vc1ZDRnNIRjgvZkl5cXRqSHhjZFY3WmZpWXhFZXV6U2lpMkoz?=
 =?utf-8?B?NDJiZWhGZTA0N0pKUEFIbStwTVpaQm9KMGFRMHU4MEF0a2c0bzRoYUJnd3V4?=
 =?utf-8?B?RkhPUWJYNDNuTWdvZzZKeEFUK0I1KzVhUXIya1BadzgxcloyQm5PclI2eHAy?=
 =?utf-8?B?a3djbWY0OHdmM0h1ZkoyclFYK1Z0ZE5jM3VndngxVDYzbEU5RWJSN211aXZQ?=
 =?utf-8?B?T2I0TkNrYk5tV2VOcUxHeE4rMXArYktTd3JPL1VGQTJJMFI0SkZDVUJOazhM?=
 =?utf-8?B?aHVzeGxrajh5TmcxdHVwbmJRNVlORkpkRGt5ajhVMzBLeWUwQnZIYVlsVC85?=
 =?utf-8?B?MlF0STZmVW5uSWhQREM0QmRQRjFhL2FPNlo0ZENtRWlvQ1Rab1RUWkk1TUtE?=
 =?utf-8?B?VGIvM0JVMlFqaFpTSWZFUnNBY1FxNnhVcWQ4amdMN0hqcCtTc20wekxESERO?=
 =?utf-8?B?d1Vtek1rNjh1aTZQcHRBd1BoNXpPb2E0anZQc3FTeVIyZ0RtWks5emFQOVZD?=
 =?utf-8?B?SGxwdG83YWlVN0xta3pkRmhMMm5iZEx6emVjVEoyVWVLbWVieGhpdEN5b0Ev?=
 =?utf-8?B?N3FxWWVLeTRIV3VzMk1xTVJTVGJUbXExQWgxcExyc293ZTRVR1JQeGZkVkov?=
 =?utf-8?B?Mkh2K0pqckVmWUJSbWNzYnBVT2lIR3VsV28zR21scjl5WS9yRmhkOW5xdzFk?=
 =?utf-8?B?Z1NaSVFtWVp5TTJqdHh6WkRpUFdSUXc2TnEzMVBMdEhodUh2aUdBSEtqTlZm?=
 =?utf-8?Q?57ek=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d54fdf-9cf3-4c37-ca11-08de1e3e7f26
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 20:44:50.9141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyMuohtutVI+bJ7etkhn+eRulxBgxKBSCaBeDQ3DSTnRUy4FvVJShH1WtrNLWrTDj3a/B67wmxQyULSPJmsAeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12021

Replace space with tab to follow coding convention. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 92 +++++++++++++++---------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index dd8c7b3233bccfc34b59e0f0ff813b36752e1526..42256441b881d9f132ad7ff899d6f1e35643b4ac 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -23,65 +23,65 @@
  * there must be 5 pads: 1 input pad from sensor, and
  * the 4 virtual channel output pads
  */
-#define CSI2_SINK_PAD       0
-#define CSI2_NUM_SINK_PADS  1
-#define CSI2_NUM_SRC_PADS   4
-#define CSI2_NUM_PADS       5
+#define CSI2_SINK_PAD		0
+#define CSI2_NUM_SINK_PADS	1
+#define CSI2_NUM_SRC_PADS	4
+#define CSI2_NUM_PADS		5
 
 /*
  * The default maximum bit-rate per lane in Mbps, if the
  * source subdev does not provide V4L2_CID_LINK_FREQ.
  */
-#define CSI2_DEFAULT_MAX_MBPS 849
+#define CSI2_DEFAULT_MAX_MBPS	849
 
 struct csi2_dev {
-	struct device          *dev;
-	struct v4l2_subdev      sd;
-	struct v4l2_async_notifier notifier;
-	struct media_pad       pad[CSI2_NUM_PADS];
-	struct clk             *dphy_clk;
-	struct clk             *pllref_clk;
-	struct clk             *pix_clk; /* what is this? */
-	void __iomem           *base;
-
-	struct v4l2_subdev	*remote;
-	unsigned int		remote_pad;
-	unsigned short		data_lanes;
+	struct device			*dev;
+	struct v4l2_subdev		sd;
+	struct v4l2_async_notifier	notifier;
+	struct media_pad		pad[CSI2_NUM_PADS];
+	struct clk			*dphy_clk;
+	struct clk			*pllref_clk;
+	struct clk			*pix_clk; /* what is this? */
+	void __iomem			*base;
+
+	struct v4l2_subdev		*remote;
+	unsigned int			remote_pad;
+	unsigned short			data_lanes;
 
 	/* lock to protect all members below */
-	struct mutex lock;
+	struct mutex			lock;
 
-	struct v4l2_mbus_framefmt format_mbus;
+	struct v4l2_mbus_framefmt	format_mbus;
 
-	int                     stream_count;
-	struct v4l2_subdev      *src_sd;
-	bool                    sink_linked[CSI2_NUM_SRC_PADS];
+	int				stream_count;
+	struct v4l2_subdev		*src_sd;
+	bool				sink_linked[CSI2_NUM_SRC_PADS];
 };
 
 #define DEVICE_NAME "imx6-mipi-csi2"
 
 /* Register offsets */
-#define CSI2_VERSION            0x000
-#define CSI2_N_LANES            0x004
-#define CSI2_PHY_SHUTDOWNZ      0x008
-#define CSI2_DPHY_RSTZ          0x00c
-#define CSI2_RESETN             0x010
-#define CSI2_PHY_STATE          0x014
-#define PHY_STOPSTATEDATA_BIT   4
-#define PHY_STOPSTATEDATA(n)    BIT(PHY_STOPSTATEDATA_BIT + (n))
-#define PHY_RXCLKACTIVEHS       BIT(8)
-#define PHY_RXULPSCLKNOT        BIT(9)
-#define PHY_STOPSTATECLK        BIT(10)
-#define CSI2_DATA_IDS_1         0x018
-#define CSI2_DATA_IDS_2         0x01c
-#define CSI2_ERR1               0x020
-#define CSI2_ERR2               0x024
-#define CSI2_MSK1               0x028
-#define CSI2_MSK2               0x02c
-#define CSI2_PHY_TST_CTRL0      0x030
+#define CSI2_VERSION		0x000
+#define CSI2_N_LANES		0x004
+#define CSI2_PHY_SHUTDOWNZ	0x008
+#define CSI2_DPHY_RSTZ		0x00c
+#define CSI2_RESETN		0x010
+#define CSI2_PHY_STATE		0x014
+#define PHY_STOPSTATEDATA_BIT	4
+#define PHY_STOPSTATEDATA(n)	BIT(PHY_STOPSTATEDATA_BIT + (n))
+#define PHY_RXCLKACTIVEHS	BIT(8)
+#define PHY_RXULPSCLKNOT	BIT(9)
+#define PHY_STOPSTATECLK	BIT(10)
+#define CSI2_DATA_IDS_1		0x018
+#define CSI2_DATA_IDS_2		0x01c
+#define CSI2_ERR1		0x020
+#define CSI2_ERR2		0x024
+#define CSI2_MSK1		0x028
+#define CSI2_MSK2		0x02c
+#define CSI2_PHY_TST_CTRL0	0x030
 #define PHY_TESTCLR		BIT(0)
 #define PHY_TESTCLK		BIT(1)
-#define CSI2_PHY_TST_CTRL1      0x034
+#define CSI2_PHY_TST_CTRL1	0x034
 #define PHY_TESTEN		BIT(16)
 /*
  * i.MX CSI2IPU Gasket registers follow. The CSI2IPU gasket is
@@ -106,13 +106,13 @@ static inline struct csi2_dev *notifier_to_dev(struct v4l2_async_notifier *n)
  * reference manual is as follows:
  *
  * 1. Deassert presetn signal (global reset).
- *        It's not clear what this "global reset" signal is (maybe APB
- *        global reset), but in any case this step would be probably
- *        be carried out during driver load in csi2_probe().
+ *	It's not clear what this "global reset" signal is (maybe APB
+ *	global reset), but in any case this step would be probably
+ *	be carried out during driver load in csi2_probe().
  *
  * 2. Configure MIPI Camera Sensor to put all Tx lanes in LP-11 state.
- *        This must be carried out by the MIPI sensor's s_power(ON) subdev
- *        op.
+ *	This must be carried out by the MIPI sensor's s_power(ON) subdev
+ *	op.
  *
  * 3. D-PHY initialization.
  * 4. CSI2 Controller programming (Set N_LANES, deassert PHY_SHUTDOWNZ,

-- 
2.34.1


