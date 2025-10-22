Return-Path: <linux-kernel+bounces-865869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D943DBFE35B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5EF3B355607
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B672FD7AE;
	Wed, 22 Oct 2025 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j2ui/Uxo"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B602FE57C;
	Wed, 22 Oct 2025 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165827; cv=fail; b=rK/QzCOHUQQLNumRRyQz793oXE3BmLcaYw5WWT3cwfC7fWwMQyNjEZ2dJihlpgsS1AXl/30fd0Oci8YpGTcVcbjXTtIjjHuQb9CkIjuxocZURZK2MlnXzxXVAfMY6su9aj3UV7xsXAtSklQfiTGfCStdD4UHzGRgnG5ZkP5zWCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165827; c=relaxed/simple;
	bh=cx41n8OoxYqFK7AuAjJPJ5i9dR6/6QQ8q9W3Dj5HN+c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gj34krhGjfImDfXu6qOGAU+uVYuUJmxPwWa9u/tDzrJYiCXJ3W7kwcIHMpmHcZJJOPf2Za425QXkuTUheyrvomGPlOwe1MW5VdoDVedBPQ7dwHVOGlDK8O1ZqIwKPRThyfhwyQTPuz5+TtgDQQo0uk11thvhCUtMac0OO49Rjos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j2ui/Uxo; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBJR8ftEBc7dXXKE1P/CsLjQBVVUBtcPw6O0VDHWCuClCetHUHirtUdPmGmq88pZc9VSMACVg4A+Z5aQ1YDzblYS/R2gfIkOWG5D4EOnY2jkBESgIbuCMP+6TxFKJP5Ms1HWDq8FXMZwU4eQZ0xTguWA/R4EOX/zoINiQmFHzAxPm8o/L4GJ5zTThQUGfUv8RR2nMu1iQgOfmK8TP9y+YuvAUFWSyRdQ6JSlOUDwHsz1KUMyz6/qhmtAZq/FvNyY6pVp/rwOiMt5sSEXuL1MCkiRo0GMGU6gULy6cXNQ1XaxpcoBSwZ809u9YO0JFeCiYF4VRfAO8hcW394cNEIbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UT9m6OPplSy0op8aFJtn8kL1n4Lj1Ir0uQJmytJy5Q=;
 b=N2SYrrC2+pz5KKbEN92zafiv5I9mINmUHpwHQZ/pfi+70lQGSZIeEAxlmYtCSx0XpNwuCgyH9YTPSJIJkow2mw5SqiV7tz/qvH8VeaDX0uvKu4uJtaAJNdX9x1RKMA72/RFb5jXV2Cg6mMe3hEklvsfbmy2q27zQOav8yKV8K75alT0UPZAFFybd0P4MKTK9LcS1E4iF4lq9L0u5IJppX2wUS27y3kXFkpe2WjdgOxvRTUltPOikA+JdLijJk7+gYwREMFKY3aRBojQFcvQFhilUjjNjJMerupJfefckdXZE9DmRJ2t63p2qI9WqHTCbppy8utywMsWE7wVbCIZJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UT9m6OPplSy0op8aFJtn8kL1n4Lj1Ir0uQJmytJy5Q=;
 b=j2ui/Uxo+yst5YrQsWoSyc2OKb9cvwNEpwdz/2qSqOri7dahILOska3c9KBmRrUHLglFusUHs0xCFuMhK/u1EWESVCs7pnXkc5fTHFh6O0+loChhYOO3gLcignYklR53SVsa90Wh8qrMPUGLEvExrZUUnfgxEKBsmPpRKd74XRqYUmHeVm5bWtm2K+mepIvKTxb7+V0Y09HaM0pnglxltEeCpHdcpVswmjBncSpxPKyjcfNHydyvMBQ9X+zZunB8dq8iV+JDwZKzsrvhbnxNb/0gMPn80e0kPFbNGk9+Abe3Prf6fRpJW5JTANh7rUQYxtWJU5R7h5iV6u3Ex2DeGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7482.eurprd04.prod.outlook.com (2603:10a6:102:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 20:43:43 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 20:43:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 22 Oct 2025 16:43:22 -0400
Subject: [PATCH 2/2] ARM: dts: imx: add vdd-supply and vddio-supply for
 fsl,mpl3115
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-fsl-mpl3115-v1-2-93187d095efc@nxp.com>
References: <20251022-fsl-mpl3115-v1-0-93187d095efc@nxp.com>
In-Reply-To: <20251022-fsl-mpl3115-v1-0-93187d095efc@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761165814; l=4885;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=cx41n8OoxYqFK7AuAjJPJ5i9dR6/6QQ8q9W3Dj5HN+c=;
 b=mcXEVz/oN/vhN3FULfFtSX3/zFQ2EghWzOodjrMqtkeT29+q1kBSB7GFEVUzMVBmRsCs+MtwF
 xn5Jv163Vl9CF1ZfolzYbiwuiCbnOovJAG3L1YOmr90QQKrhTbzjEsY
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:40::35) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 74719fe0-f9b9-4e59-ea24-08de11abb0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVRTeThVMGYvZjhwTXNzY1FDSnpoVi81d3hmd2ZSQ0I3RmRMSyt2SjlXZFdu?=
 =?utf-8?B?bGVlQUlBMW1QVEgxbWZTNmxnRGhoMEdkTWdFZDgvT1FNTUdtYVVVQ1BxWjRs?=
 =?utf-8?B?bXRPQWxDRGswVjFVUkdZSUJiM1BiVGw1bHE1U1RwWU5WKzA3RTJTQkZwV0tZ?=
 =?utf-8?B?Rmd0cEpYZzBtWXpvRTJJb2lTSTNoZHh2MU1OajB4K2JGMkYxSmRCZjRSbzhE?=
 =?utf-8?B?N25pQlhUOGNaNFJPQUJST2hqdjZ2dGVMZzA3UElWOUkxZzJXa2xVME5JaWE3?=
 =?utf-8?B?SUkxRnJZM2lEbm5pUk9zaG5Zc0NxazYvUmpqZEZyOUNmTmJnNWJWRW9LRTdX?=
 =?utf-8?B?dFpvN25wZ0VxSWhlRTNScm5iU2J6R09aQkF5dTZTU1dMdGRmWmhnQmZyb05m?=
 =?utf-8?B?VGlMQVdtQkFiMUI3QXV5KzQrVkNDS2tNWGptWWltSnRRaFo4TnFrZ3BWdGNs?=
 =?utf-8?B?NW9PTTJHYWpUQ2xLSnR0c2MzbU03ZE1zem1LU3lLamJtekNWUXRMSC9xK2lu?=
 =?utf-8?B?dVhNdCtUNVJYS3dnYSt2cW5tazY1a0VuODBBTlgxbFRIRmxQZndTK1UxekJX?=
 =?utf-8?B?MnJ5OVF1Mk1mcmIzbTJMd1hRMzN3SGFycGlwMmpHMXd0MW0xbXlaTDIwR1ZZ?=
 =?utf-8?B?R3ZRcWJ6emZJb3hCaVRydmFMZElzaWRJUFZMRXdFWGx5SkVmUStQNjNqc2M4?=
 =?utf-8?B?QzVrcjJHd3ZZQ3pVZVg1aVJZSEdHbytuVis2dXg4NHpadVZmdWlRbWdKYUtn?=
 =?utf-8?B?RG5VdW5aZVFzU3VPSlh2aWFCc05idVYvUWljZ0UwZktzRkdQTkEwbVNsQ1l1?=
 =?utf-8?B?RFZkSjZnTEJlRWhVOEU0YXM4SlBRV1VVM1pkSGxjK29mMHJ5ZjluZWx1RStJ?=
 =?utf-8?B?UnNZVFdvaTVMck9CTFJDOU9QanNhOTEzS0xsMkV2NStUUVVNQUZ3U1Y1ZTdw?=
 =?utf-8?B?M0ZxYXZMTzFEQnZ1eGozeGxFcFhQOGdGNjJ2NXlWVU11bVNSK3lLbHp2U0Nr?=
 =?utf-8?B?ZHBNb0pFQkZMQ1l3MnNmZ0ZDS2swYUFRQkUvQ1BGYWx4aEVRNXZOQTRmajlT?=
 =?utf-8?B?OGdyRjEyanRCQ1NZdFRnV2MxMC9RYURQc0xHU0VjVzd0YzhZS0d2QTE2SjRH?=
 =?utf-8?B?N2xSczVRMXZKR0Fka3ZtaDF5MVA4YW5RSXVlZVg0Q01zdUU2Q3YzTC8rak9t?=
 =?utf-8?B?MFFxTDdWTDdJTjRDdTFOcmFON2RTQ0VHREFUV09UYkZScCt1K0JUdXM4LzIy?=
 =?utf-8?B?aDR6aW92SXRURGVQTzNpVDAwWU1WWXhzZTlZT0RubGFXNDNmaklYL2NxUFhB?=
 =?utf-8?B?bml6UVFpblFmb1NNQm85VXZ1MlVMbWNWeVNqM3AzbzRLdEdiTDU1VlYzRkhw?=
 =?utf-8?B?Mm1ZeTlsQkFRSnFjaElscVc4SGVTRHlmN3gvdnI4M2lmVUh5bGF1amdnL3VY?=
 =?utf-8?B?YkJOUGhmRjh2M25wVzZKN0p3UlM0VjJiSmMyb0Zya2V6bWRRY1h4MXppYW5a?=
 =?utf-8?B?WGNad0IzRW4wS1FYbzNobU1haWRHSFJKKzk5VDNwc1c1cXV4d3ZJQ2FPWG1B?=
 =?utf-8?B?dnRIQnVKeTRIRkVCZndieXdJTzVGZzEwVE1pNS9NQmRTaVJibUtQekRlM2M3?=
 =?utf-8?B?T1A5NE95K2NBTVJOeHU3QU1jSlhpU0xMelplb1hkZHFOcHVGOUxLeDZzOVNO?=
 =?utf-8?B?Y3NJb1JXQUlscUMxS2FWMjYveTM0ODFGNktTdVRRWE1tc3AvOG9yU1Y1c2ZN?=
 =?utf-8?B?ZUM4RGFaL1FLRUM5MDYvVmVkNXVhRkhXYWpSMmk4STdiQWNIcEl1Z3pEZkRk?=
 =?utf-8?B?TDQwck55NEEvZzFEdGhJQy92T1pqNXBhME1KODJNc0tsbjNVVDBmWTlKZVFr?=
 =?utf-8?B?SFljUFNPdUFJUHE0WDlBMTZuTm0vbXZUUjh2alFpdjIwcjNiTXd4K0hvZ1FQ?=
 =?utf-8?B?enV0eHBuL05nMmlMSVZxdEcvQW03aFYvSTQwVmJmN21tWThlcnczQzB0L1ZX?=
 =?utf-8?B?UktQWWNnYU8wM3h5bHBSOEo2d3A2bjRzWEdINDdaNGhIRGJPUHp4N2FGNkhi?=
 =?utf-8?Q?5qUYk3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUpCaUFaQWxWME5GSFUzWnZoN3o2dXZhdVMwVEJibnVQSmp1cy90S25zZ1lQ?=
 =?utf-8?B?bFpNVG85d0kwQUhkb0lmMVBEZ2FDRWV1cVRMZVllUXVURFNkY3B2TW5vbytQ?=
 =?utf-8?B?ZUxoajNpdEY3Z1Y0Snh5OWg3YitITGkvRzExdWlwWDlqa0xlZm9MMXE4bk1h?=
 =?utf-8?B?Z0hKaXZuN2ZJVWVRYlQxK0owQXd6Tk8xU0tsbGw5cGw4Y0JrRzhrMEVMSHdW?=
 =?utf-8?B?ZTlvVTgzT29RWlB4d1hVT05TUmpjR0dJMlEzZTZ0RUQrRHZ1ZFRua1k1Q2VE?=
 =?utf-8?B?WFpyQmFZdE9hNW5UcVlpZkVwT2RVeGtDTDdmNTFMK05kNFZFQUlvMnZVRHNT?=
 =?utf-8?B?OG51ZUNNaFlSN0l1R25KK0UyR01jbFRJN3RFTUhIZkh6NUdGV3RKcytVRTQ5?=
 =?utf-8?B?aGlMZm5oZlk2UkVlZXZsWWJ1cFErWmJSdi96ZmtTWjVtVEtpL1FOOWs5NXp4?=
 =?utf-8?B?Z0JKdFVzaDVOVEhBSitDUWdseWdySFdmYWhSLzl5bmtBcnFXWVpzT1RoR09x?=
 =?utf-8?B?dm4xOWp5Y0RHRzhHMmlNV0lPd2lwYzg1QzQvNHFDRXMxTTFmeXBVVFozWVY0?=
 =?utf-8?B?SU92cUZUMkt3ODlLN0tBZkUrQzE4ZXZOR0dOU0phVWFmZkpoS3d3eFN3N21z?=
 =?utf-8?B?RGZOc3JDMlM2dWZTbFdubXRML3JwR3J1UlVhQ28zd1BMTFhENUt5bi91cFJn?=
 =?utf-8?B?aDl3ZGIyQkFkUVFUUUpjOUdUVit1NDFraGhyQ3JPRFg4UjFZSi9iVWdCQjVv?=
 =?utf-8?B?VlVTZXhkY0hIMlpWakEycDV3OGRBa3U5OW92OEw4ZzlSRlpVUDhBMHJVRExv?=
 =?utf-8?B?Q21KSGM1YUNwQWw3NVp2emZkQk96djNCZExLWmJ4Ui8vQ3lRN3daSmQ1bzRa?=
 =?utf-8?B?VE9uSm5KOUJQWEt4bXpkNExJdlNBSE5DNTZQUXJkbURxczRQWGo0SS9xTktj?=
 =?utf-8?B?NGhqTG81NzljSEhSTllSQW0xU3c4N0hSdk5CNkRhald1VG1XeWJLeVlBYTdJ?=
 =?utf-8?B?VVdHRGFmdDJrL2owZ3NSNUVmQTBqR29UKytFMWc4Zzh2VnhVRVBFenRKSkty?=
 =?utf-8?B?UGpRL2l5aHZNZWQwNkpIemxtZFZGeWZJM3QwNGt4STkxQmliNnFENUt3Mk82?=
 =?utf-8?B?cnU2Sk5mU3dMWHlUakgvOGVzZGt1S2dMeDZNckEvK0JjVVRXMjROWGQ5b2hq?=
 =?utf-8?B?WUNacVJMdE5RUGgwZGlhMXBpWmU1aDIwU1ArR2pSZ0dVTGxTb3FUZWtkTGZk?=
 =?utf-8?B?V3lyTmdST0RmRElIcC9yNXBiS1JyM2FmcHJsWnlQSEk3OE1RY0JWSGxjY2RT?=
 =?utf-8?B?dXYrVmJyNSsyYjJ3ZWJ3VHhLS2tqZmFnMTJtQkxkdjlLcHl4QS9Yd2tLR1Ar?=
 =?utf-8?B?ZHpMWVVzRWQ1c3crSFRVZnY1WlNPdG1ZUU1kUGVFajVrOWJJVmV1NklvYzhs?=
 =?utf-8?B?OWxvZTI0dWxhZlZDU0d1RU5FZlZFK01YcTZ6SWZBZFZJdStjSDF1Z0lPTllo?=
 =?utf-8?B?emZJdUxmLzlpRmxIdmpuSSsyWlBoUks1LzNySjV4ZHVXWlhsMjVGQmJGek9V?=
 =?utf-8?B?TUMwY1hrcXQxd0x2eEJkR1c0MnI3Y0FoejhXanhOWWxzS2ZjSnc3NzN0UFI3?=
 =?utf-8?B?aXNGU0FqNE95S3BFWVJlejlHdTZDSXc0SW80S0J2cTNDdkdyV1VBNlpLaWNV?=
 =?utf-8?B?Y0h2L1FFVmtkSk5MLzVRUzN5aWx1Y1BVNjRoOHRHTFREcHl4TmVEa1MyaTFp?=
 =?utf-8?B?MzZpUko0MjRRQ3gzVXNSYjd4NHlZRzFJZ1hDcjlkUE93Z2c5amVacHJFTmQz?=
 =?utf-8?B?YlVTWDBNVlBEVlhKNFBOd1dFSnpWVE41OFRSQ3NEVG5Rc2F0OE41WCtLMzFF?=
 =?utf-8?B?QlBxUHI1NERGVUJXdjVkbWtTWUlXMmVsM1pSNmJwajVoRCs3bVpkalduZEVa?=
 =?utf-8?B?cCttME5yQjNOZ2phVGtKREIyWVZBQlZheENMY2V3eStuM3ArcXBxUFpXWmM1?=
 =?utf-8?B?bU9CRmdpaUVXRWhnY1V0YnhEbHpYandRN1BaQlM2T25EWW5jT2dsaGtQK2Ey?=
 =?utf-8?B?U3liekJHT2xFMCtsZkhGaW9zOWpJbjl6RzIvbGUyWGRsaU96aHZNd3kycVFp?=
 =?utf-8?Q?raNxE+yzSA6ZiqCE+yhBWbAtG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74719fe0-f9b9-4e59-ea24-08de11abb0d7
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 20:43:43.8465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GL/PsbmkwVTd3kAXFk25tihQ0/4MAM/s/t2qZu2Rt9gwBRIXOzo7gtxu6rhNwEsRaLzssg5eAm0H9CBCuNLpPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7482

Add vdd-supply and vddio-supply for fsl,mpl3115 to fix below CHECK_DTBS
warnings:
  arch/arm/boot/dts/nxp/imx/imx53-ppd.dtb: pressure-sensor@60 (fsl,mpl3115): 'vdd-supply' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx53-ppd.dts         | 2 ++
 arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi    | 3 ++-
 arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi     | 4 ++++
 arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dts | 2 ++
 arch/arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dts  | 2 ++
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts         | 2 ++
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts        | 9 +++++++++
 7 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx53-ppd.dts b/arch/arm/boot/dts/nxp/imx/imx53-ppd.dts
index 2892e457fea7ef79ac5877f0a3c893f29b614fdf..e45a97d3f449de9a82ecd9171bcedb0f5f41346b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-ppd.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx53-ppd.dts
@@ -537,6 +537,8 @@ mma8453q: accelerometer@1c {
 			mpl3115: pressure-sensor@60 {
 				compatible = "fsl,mpl3115";
 				reg = <0x60>;
+				vdd-supply = <&reg_3v3>;
+				vddio-supply = <&reg_3v3>;
 			};
 
 			eeprom: eeprom@50 {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi
index 590dcc0953cc7b95307794b2293eceb8b849be39..5dc7f1f9ca17835f3e92bf1705761ec6998582a4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi
@@ -47,7 +47,8 @@ &i2c5 {
 	mpl3115a2: pressure-sensor@60 {
 		compatible = "fsl,mpl3115";
 		reg = <0x60>;
-
+		vdd-supply = <&reg_3v3>;
+		vddio-supply = <&reg_3v3>;
 		/*
 		 * The MPL3115 interrupts are connected to pin 22 and 23
 		 * of &tca6424a, but the binding does not yet support
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi
index e1d0c6e123fd728f7bf6a6aa19c22b75ce3e5817..1e2266a2368be79163ca963c4418aa3941f17b7e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi
@@ -195,6 +195,8 @@ ads7830: ads7830@48 {
 			mma8453: mma8453@1c {
 				compatible = "fsl,mma8453";
 				reg = <0x1c>;
+				vdd-supply = <&reg_3p3v>;
+				vddio-supply = <&reg_3p3v>;
 			};
 		};
 
@@ -211,6 +213,8 @@ eeprom: eeprom@50 {
 			mpl3115: mpl3115@60 {
 				compatible = "fsl,mpl3115";
 				reg = <0x60>;
+				vdd-supply = <&reg_3p3v>;
+				vddio-supply = <&reg_3p3v>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dts
index fb206c1d8aca1efef8d71220630a1c373ff94bef..fbab126f95b95cde82668e218c8ec11b69eb1cfa 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dts
@@ -49,5 +49,7 @@ sgtl5000: audio-codec@a {
 	pressure-sensor@60 {
 		compatible = "fsl,mpl3115";
 		reg = <0x60>;
+		vdd-supply = <&reg_3p3v>;
+		vddio-supply = <&reg_3p3v>;
 	};
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dts b/arch/arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dts
index 1b965652291bfaf5d6bad76ac3eaf10974eac6ea..347dd0fe4f82e00ff5fa57487f3333d61c4b27c5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dts
@@ -49,6 +49,8 @@ sgtl5000: audio-codec@a {
 	pressure-sensor@60 {
 		compatible = "fsl,mpl3115";
 		reg = <0x60>;
+		vdd-supply = <&reg_3p3v>;
+		vddio-supply = <&reg_3p3v>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
index 17236f90ab3355591028ade5ce811cf7e22512fb..a370e868cafec0891f96ee64df31066ed2f5af79 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
@@ -406,6 +406,8 @@ &i2c2 {
 	mpl3115@60 {
 		compatible = "fsl,mpl3115";
 		reg = <0x60>;
+		vdd-supply = <&reg_audio_3v3>;
+		vddio-supply = <&reg_audio_3v3>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts b/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
index 56dedd4fb8f0894c48eea5e34f2b8445cd38cace..92b6258059ee0150803d960ea076f6301ce1b209 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
@@ -31,6 +31,13 @@ key-back {
 		};
 	};
 
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_peri_3p15v: regulator-peri-3p15v {
 		compatible = "regulator-fixed";
 		regulator-name = "peri_3p15v_reg";
@@ -228,6 +235,8 @@ codec: sgtl5000@a {
 	mpl3115@60 {
 		compatible = "fsl,mpl3115";
 		reg = <0x60>;
+		vdd-supply = <&reg_3v3>;
+		vddio-supply = <&reg_3v3>;
 	};
 };
 

-- 
2.34.1


