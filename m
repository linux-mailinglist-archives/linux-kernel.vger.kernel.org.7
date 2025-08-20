Return-Path: <linux-kernel+bounces-778204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EEAB2E291
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D028A05852
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07B033436B;
	Wed, 20 Aug 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ER5IvK72"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF2F3375C1;
	Wed, 20 Aug 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707858; cv=fail; b=jubr1Fu61uOsYnRfzDpjS/Z68AumM1swRjLVQ1xFaMFpH/+gFtAiO7Un3amheAXFEVhHzjcZmwjLNEQkaz+ziZnmP8Lh4yDUEbYkR3P6B2fzB2qcPV8by4WoJOB3OuQY4AibfG9U0gYyKRCvahUieQTnE/5bIiIvSVTMVtfbiyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707858; c=relaxed/simple;
	bh=BQOMOOEddNiLEDO/Ox6h2RoNP7icyHU1aUqf6u4VGdU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=A/qD4H7/LmOqTaxDEntK53083IqfWuZVXTaXAdRnOm9sWum6z8q6UndGZXhH/8Ga3uKttN1tyxIOL+5UpXp/RheTAovotmtrwWrbJX10wDcpstJgO5ZT9ecZxXue4JS/nmM5oluq9RQcR0Ge8dkCWZKfEufxXj/KmiG9dg1J6Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ER5IvK72; arc=fail smtp.client-ip=52.101.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1r7E9F2qvv+4wILuHMatAYFyQpwjhJL95oJI0PFUlamGpYOhhgtfbUR2QzCafHgzaxn3xkHsOrMtw0HYp9QPhBAgOiLuoairUd83fYsz/HSVHTweZcfqSFzXs9isZjPlPR6hy0qllIj7x7dPS/TBJwR2KFs4zvZar3cigNOitOO6dISJveTTU/LmsF5fC+Va0oasgSIZFMMlGYyJxVSD1SUeXOHXQ1xLHkXFf4LTsHMJYI1v/QyXt1GTp6NN7uSY47MJii09KcCgz8MKxhN0Pu7NUpQeCI8d8xzUsPDRtHdPqbHhn6d/SoHi1yQBvsYlzcarJfkE/TOR8zSjQSlLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO1EgbMgoAlmS6/dHVPeu8fxkXfPVwZ5vR96S1Ov/80=;
 b=lqLFsxJfIoQnOjd6DlxPzhk7kEzlFfP7FP1uz0U9/CkaG57usqgFoWoRf8nS36Ob4O+9oSBh0uF+fxjttb7oh8w3t8usPLHGWh/uomskRxyhrvkOGcQbQZEopnH7D3K3e432jZ0xoOGpTl82Qq2FTp1qwBz6z96QybGTAKI66JRhT1dzG/To/XQPUTnbyIjqHeUNfw4564Rvz9X7AF+2GzBsOEW17flOJcqU+HUaBTfMX5H4zuz+hDRhWo/PxvS/u445AuF1YUVqx8MDWUCdltlZm95cGkkjclJuW1lM19J+1lYr1haQMbxpdqXjdGWJDlKiQa4+yDFbFa7efYZmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO1EgbMgoAlmS6/dHVPeu8fxkXfPVwZ5vR96S1Ov/80=;
 b=ER5IvK72vZBS6h2RrqBiEDlz7uGHQyo27aA2dfohMM0xaTamJKSnZ89oB+zXn3ArlMyuHNa2fsMCU8Cz6/ySWqoR3SWeGqN31Wox3joBKs5cIL6HqAYp3QFbBX37u6FRHTYmH9ihoRfL12QWwgqosFET1JxcfKDA0ITrOdDcCiELH42z/DVcuI8MP1OCl8LipSYz3tdkYZgOHrJwcB1JAkeLWtNxox2ysLZWKuf1rCksXE8wyopwujI4LherxqnKPZVrX70R4MaZfzM7IcCGHGVW4An5/VKPn3oQdhAkSNJCBgKzA3TpAenBoVtMP7nssvWzm/luw64XqMUOz6cg2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB10338.eurprd04.prod.outlook.com (2603:10a6:10:565::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:37:31 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 16:37:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 20 Aug 2025 12:36:57 -0400
Subject: [PATCH v2 7/7] ARM: dts: ls1021a-tqmls1021a-mbls1021a-rgb-cdtech:
 Remove fallback compatible string edt,edt-ft5x06
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-ls1021a_dts_warning-v2-7-2e39648a32b7@nxp.com>
References: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
In-Reply-To: <20250820-ls1021a_dts_warning-v2-0-2e39648a32b7@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755707830; l=2016;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BQOMOOEddNiLEDO/Ox6h2RoNP7icyHU1aUqf6u4VGdU=;
 b=aUN1gqdmuu+pNYI/QiYG2xiGb7uadWDNAYM6imiCLdREBw8yJQfxRuuJy7b8xMdQtLrd5JbFQ
 ++BlS5OrmQDB/VdKQS+yzwvwczmEMcKhH21rVImaYVZz/3aQTUvYtJb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU4PR04MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: 2263a17c-5f94-45fd-4720-08dde007dbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1RjQWp5aGlNeGc2Tnd6UXRMdVZCakd2b1UrbGdmbGRZVlJpQUZFb0VoQml6?=
 =?utf-8?B?Uk9zcnhrbEdOK1VaWnphMUZTRnlsREI5RjlnWUFYVDdmY1YwMEFmdnNuL1Iz?=
 =?utf-8?B?MjlmNUlwSDNkanpIbjN1ZDk4aEkxNDRuUU5wcTQzVFFtYy9zcGhDUFBlcmlX?=
 =?utf-8?B?VWNjWm8ybDY5Zk5kQ3hQalZadStyT2xMV1M1WEN3N0djS1NjdExsYzhHSDhG?=
 =?utf-8?B?OHI2UllMcHl2SnUvYWRyeXAzNFlqakk2RUQremZLR1JtZFVPR0dsYVhaUkNW?=
 =?utf-8?B?eEJzQ2lucDFsTWY5dDZtejV0dzh1ZWNTRkprTjc4MHYrK2xVYXRVUnNSdWJE?=
 =?utf-8?B?eWM2dENzT1FiZEt3UU1oTjJIZzJmbExJaUkxU0lEWGV3bHl6eE51U3B6MGpH?=
 =?utf-8?B?T2lpWmt5NE9IbUMrcFppb2hkYjB6Ym5sY0RnaGdCSTRJcXZZY2NWczMvWVBs?=
 =?utf-8?B?WExZYnBUb2Uva1dWRE92RmNCbStpOWZ1aFp6TzJnbkgyenY5YzBrOWN5aGJC?=
 =?utf-8?B?U1VHZmRpUkJ0SzlQSHJuWU9ONE1zWE95VXFwZUIvSlJialkrT2JuWTJneUdV?=
 =?utf-8?B?d2k4KzRObEYyY2FidFVnOUdsY1BpdzFsTG9XVHUvbUxONkJZS29KNTVtY2NN?=
 =?utf-8?B?ZnN5UGFiK2w3S1JmV0p5bjlHNy95ZTkvUGZTWFdjd3dzTXE0VmtmdHg0cFVy?=
 =?utf-8?B?MjZGWnFQVmJja05TYnp3SzVPYTNYbUFtOUJxSUwzblJCVWZUQ1JUNU5nOWlO?=
 =?utf-8?B?ODFrbWJVMDU1eEhYYjBOQUlMQWFOcDJzbjJRc2h1MU11MVdTZUFFdEZIaXJ0?=
 =?utf-8?B?TXM2bHNBdnd2d2JsR2NBZVB0MmdmbTZOanZXS0VmTGpxNGk4Z0QxN1RqZVd1?=
 =?utf-8?B?RmRXVlJmSjJHd0k0d1JCMW8yZXgwc1VDTmVPbmFseDduWmhpbVR2U0hEU1h5?=
 =?utf-8?B?bE9QQ3AxdnllMWdFTTZNZURaWHg4VVhRRE8zeWZmSmpya1hMYnN4em1GaHFP?=
 =?utf-8?B?TjZGNmFxTjhtUWtjbFdJQVY5cGVKTUJEV3BLOUZ0RThYa2Uvc0t0L2IvR0lY?=
 =?utf-8?B?cWNLVEI1anVIZGUvc0ZRV3RrVnJNbHQrTS9xZjFEY1JCV3IwVjRnYUdDTmR5?=
 =?utf-8?B?Zi9JdFZndFRNWWdLak5VSG43YUcxbFNOT2FYbFFqbjQ5OXkydWwzWWlGc2Zq?=
 =?utf-8?B?MlkwZHYwcmhUVXF2Rm1sNC84RkxidUtXT0ZFWmJ5RGZLdzlMTGIvZzNGZVU4?=
 =?utf-8?B?dDhZM3NJenk2aUw0ODlGOCt3Wjl0bjZNaStmcHZESkhaWjRQZ2Y4QUlFN2Nv?=
 =?utf-8?B?aWVFQzl4KzhoQlhEcUlDNmh6cGFFNEgyZEpSZ0ZUd0gzVmI3SEpmVVpWMUd1?=
 =?utf-8?B?aEo3Mm5Za0xLdWtKN1MvSjZRUFJvTFdoTlBLSFpYZUJWQVJYRDdLSnVYMmtH?=
 =?utf-8?B?bUJJQ25KRG8ybGQ4Q1Z1UkEwVWxKcUFQZDVhcnpGK25mK2RKSlFhWk1rTm15?=
 =?utf-8?B?S2hJcDRWaEp4a3RtRCtKRGU3K1htNjdXb0poWm83VzhsY2Z2RnpnZlNIVEha?=
 =?utf-8?B?MVNsOEZwTjd1ZUhBb0JxQ1Ivb041ZXVlNlpoTXZzeFdEUy9jWjh0Z3VNMEV2?=
 =?utf-8?B?QjhpVGZSYVpMUnhJZjIvaGN3ZTdVWlBpS0plWGJXd2RLREIwYUdRMW5jOFlw?=
 =?utf-8?B?U3hxcDVYc1dMcGlFM2lsQzdqRGhGU2JEcjYyUDNwVUNWeHpsWnR3bDNhU21o?=
 =?utf-8?B?RXVnOEJkcFk2cGV4a3haMDNIUjlCUTcyNjZoT1NoRi9mR2JkT21laXVkMjFq?=
 =?utf-8?B?TWh6YXdKcEs0WUpjbG5iUkFmMm1peGJ5SnRqWjNZYmYyZGJRa1NlNlBVekg1?=
 =?utf-8?B?MkJDSTh1STdaYmlxR05WTS83Mm03R2t0TFBsdTJBMnFqSjhFZmtOZUc1bmZk?=
 =?utf-8?Q?bi9XLkHq24g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nmg2eFo4R2xicENlTEhCdWtsTlZpcFJGOVRWcE9xTENnNnNtL0Qva1dBUDJa?=
 =?utf-8?B?K0F5dDFrTktYbFYxdERlNkRJczljSGJKL0p3KzZGNGtHWVM2K2lYSlNMek8y?=
 =?utf-8?B?U0xZWVphdS9paXo1UmwxYWovOTRQVDhZMmIvYjZtQ3cyMkpuZzFnQ0dmdCti?=
 =?utf-8?B?NkV3ZkVoT1o0OFhtSWhIUVFEanV4NHVOSmIremJ6a2ZlU1hEK2FDR3g3YSta?=
 =?utf-8?B?QVNwQUFTblNpQk9QL0VSdko4aHhCZi9Dc1g1bjlMWFFQZTZOWHJTQUNBTnVS?=
 =?utf-8?B?WHI3eHc3MWdqOUJERzVnUkZhYlhrMkxuY291YXR6MW95UTJEcEJab3IvVDZV?=
 =?utf-8?B?ei9UaW93RlQ3VkE0ZlFpakhZOWdHcWpoRUNhUXJKZU5EUlp3bGNjanluQVAr?=
 =?utf-8?B?d2tEaUpleWtTb1NMRnJSbFpVdHYraE81UUZ2VzJrZzl6NWowaGZhVzdzUkFM?=
 =?utf-8?B?WVl6MEFzSWxXTzRUSm05eVJuekdKMXFBWWFFbk5VOEJhVTFuTHRvNDlTMEdl?=
 =?utf-8?B?VVJkWnM2ZmFnbW0wMEkzZkpPdVh3UnEvcmRjazhiU1QreDhaQjcxQzZ4RmlW?=
 =?utf-8?B?a0FkNUEvSWtKODFaTVlyL1ZBYUo5MFlOVzZicXJGUFBDV1JPVVM3emk3NEVy?=
 =?utf-8?B?cHljcUppaU9GU0MzYVFrbFBsbGE1R1FwWWIwRUFlY3dNQ2lwN3p4eEtZcUlK?=
 =?utf-8?B?QzV6d043VlhmQmhxMTZZRGh3b05aeDRNbGt3Z2dRWmtLcE1hYy9PRklTYm9W?=
 =?utf-8?B?ZjZNdGpqYWFKRklLZCt3N3Z4Mkg4ZTZ3aFhrTGdXRkFUS3poTUlKMmlqZGl5?=
 =?utf-8?B?eE5sUFJDZE0wOHJpK1pJZnc4VWdzM2YwcHRqY2g5SnJZdUpBWVdGOTVMMmhj?=
 =?utf-8?B?T2loeHpvcHZvWTkwaTd4NjB1NTlGRllXZmxiOG9NUnVaKzcwY0VIaGhIaEhz?=
 =?utf-8?B?REFFMFExMXdHM3pFK0dyczRYdVYvRlNZT3VsQVB6QjlyaGp2aUVKejFXOW9m?=
 =?utf-8?B?MFFCTVB4ZFgzdTNhdWxuQUNITFJmUkhJcUh2L0R6K2x0eUJqM1lCMit1ZWVC?=
 =?utf-8?B?NkpzcVZDR0tmanNiK20vNlpscjFXTXlRWUtXYVY5K2krV3NXME03OWhUNWU0?=
 =?utf-8?B?Q1dsT296cTk2Z2VRTE5pV2J4UWlxZkYvVzRiSzNUSXZjYlNkQVBBWTlrYVZE?=
 =?utf-8?B?YTFNMGloYzNSaGpjU1FkcFFiSkJYK3o4NWdNc2l4dkswMklobVpHSVdDSmRx?=
 =?utf-8?B?VXhGYlF3ZmJDUmF5QXBwNUNPaEVrUUZJclRja0xiRW1YL3lYOHZCT2JpZ1Fx?=
 =?utf-8?B?YmJ5ZFN0N2w4ZDZtTGJVZmNrSW1WS1ZJNFNBYWRrQ0VWNytMS2FtSTRyemZs?=
 =?utf-8?B?T2IrL3ZQZFRKZ3VhZVlYREdraU9XR1pITlpxTEhVLzBRV0sxTWM4LzF5S1pV?=
 =?utf-8?B?S1NUUkdycm1mM1VMbUg1Q21sdVNLUnJ2YkdLbkt5TWJ5VGMvY1JGRW5QU2RN?=
 =?utf-8?B?dDNNQzJSd2t6WVp5KzcyU0Z1Uml3U213K3FsM2lMN1NPQTFNa0U4d1FqOTk1?=
 =?utf-8?B?NG9xMnFYSXJ0ZlZZcVFEek84ejhIN1RoaE1PNGZ5aXVtc0lpUGJ0SHlEQXNN?=
 =?utf-8?B?T2R2Y1ZINHJJQk9QbzQ5MFowekZWa01PR1Z1RlBBcmFENTNSTDdkQlVlYzds?=
 =?utf-8?B?enN1aVVxQjlDMkpGMDExV0cwOWJORmNDQWdFZFF4b2ZpeDN5akZDdmtBaUxz?=
 =?utf-8?B?WCtXNi9wTCtiZk4zOGFsb2FHckVCeWJVUGRhekJNcU9UejkxQ0pZQ0c4dmtF?=
 =?utf-8?B?YmEyWmp1Witub1hDbkM5a0ptVE5ta3ZhZ0E5eUVMK05nNUphYjFlN2JsYzNW?=
 =?utf-8?B?SklJTmUyK242V05kWGRXaCtPK2N2Nis4QnVzSUREa3BPNldQOUhMaXpYNS9w?=
 =?utf-8?B?L2JyOEZaZkFpSTVDY1lyWDhIZmxuK2I3ZUV6YTNqOVYwYzlQTTJoVzdLTXdu?=
 =?utf-8?B?YTNjaWFoLytGK080RitoWDNiRWIxWWRxSGhpVXlwcEk1OTN2YzF6Y1hNb3Ra?=
 =?utf-8?B?Nzd4a1RpL3JyMDdscnZUbXRFa1MwTTNLa3pqWEg1N0tXS2xQTzhwN0twWlZL?=
 =?utf-8?Q?pS6cYRgYtPtBN1v4IfnksM1d2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2263a17c-5f94-45fd-4720-08dde007dbc3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:37:31.5093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvpJLBOvlx9TlWkutc8zUbmKA8bfqSPfmmCSQh1IlFnLANwba0Md7xrLo0btKewvJk+H4z2TReno51XBF8azlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10338

Remove fallback compatible string edt,edt-ft5x06 to fix below CHECK_DTBS
warnings:
  arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtb: touchscreen@38 (edt,edt-ft5406): compatible: ['edt,edt-ft5406', 'edt,edt-ft5x06'] is too long
	from schema $id: http://devicetree.org/schemas/input/touchscreen/edt-ft5x06.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso   | 2 +-
 .../boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso
index 146d45601f693e92e4c2613c0e56ef5ad63715cf..66cedc2dcd965d0cb3f858421009a0985e345ebf 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso
@@ -36,7 +36,7 @@ &i2c0 {
 	#size-cells = <0>;
 
 	polytouch: touchscreen@38 {
-		compatible = "edt,edt-ft5406", "edt,edt-ft5x06";
+		compatible = "edt,edt-ft5406";
 		reg = <0x38>;
 		interrupt-parent = <&pca9554_0>;
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso
index db66831f31af93bd60c1425b6e5c5c10fa77e845..8b9455bffbd2687bee8664083a97a982318ea6a9 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso
@@ -36,7 +36,7 @@ &i2c0 {
 	#size-cells = <0>;
 
 	polytouch: touchscreen@38 {
-		compatible = "edt,edt-ft5406", "edt,edt-ft5x06";
+		compatible = "edt,edt-ft5406";
 		reg = <0x38>;
 		interrupt-parent = <&pca9554_0>;
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;

-- 
2.34.1


