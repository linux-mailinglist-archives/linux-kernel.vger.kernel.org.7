Return-Path: <linux-kernel+bounces-816365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F946B572E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317547A785D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273D52ED177;
	Mon, 15 Sep 2025 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jkBjcDFG"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F02ED85D;
	Mon, 15 Sep 2025 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925021; cv=fail; b=DtHzaNH55VtIyYGZOtmrmJC4WTQ8K6MCKBqvid//BO5vimZCXSeGAHtiORLZPH2beyNVIIXJPL4Ts2OzSDcaXaTUT7dIh/k8osmbzYDJSnGULI2Jr36NTasaD/YXJdcTfwcMULHFpTjUPHK5zoN50Bpz+vSf0/AhEKMnNHiwh8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925021; c=relaxed/simple;
	bh=J5itaEqqunD00+BEa5RkxRSc2ZFxgjVuzwpmYs0j44I=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=OEfqsKPIZJXuPDDoavEe7XrfbzR0pP9GiXYP+hX+OpJJpHHFG2ZHoyOJxX0vFYuR9JHPmTvPCFN54NEM4D8EI65/RHvDZALnoUlRmbQFKUzN0azCP2wYsdIap6s/xoAn2U4DtAyKGpxFHIITshTDI+Z7gOZ+h+vO+wfGY+CHTrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jkBjcDFG; arc=fail smtp.client-ip=40.107.130.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQvVMeo8IxIT9qVl6eNRrff0hqzwBVHW1+i7GuH7tY1FXsT7XFxF0jh+WzG+V7MKKGV33nz0W98fTHFak+HjuG95F3I7W2KvVd8jTnd870rFdEvtoAINu3FQq5mEffE19LzgVHlWZ2FN6XCuWjLFHambgB4dRXgjwVZE1gb8VuzYOGkOiieJQdtSdyHYZUjuM8GH3ecYRwn2fjDEjG5utcgCSCUVyZO4pfu3Vg2Rb/ROFLmoA1iUL7f99AQjkXzuznSeSxAACk6dWh0fCn3d7w5AjCFxvHhKjy32kMXaad8VVGYrjnJtA3RSRCwk2gMZIp8/81BCscbhWoTCduFReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4LD9cbR87q9wxsWuZoHSJF8/fdAZRIkGTenx5oUXVM=;
 b=XvYTod9V/0qD7ZtP45T8tctA3/lZE/URNSAL6cDu/ret6s37xj+wkeKTm6VklSE9LxvDTV0zqoFYNPqvUaEW7PeslKJLu877OdhNTWXJDqrnWl6rP9DiEt8S/Lg3e3r43i83zynNO52TLSjIKpxwD2orKfot9mNsl0IWMCb4V8nTm8xjWI7nl5Di/4bVV6ZtvjZlTUt9bJuW23jv/6e//1MlT4hUJFzwMuoEHzJk0oiCtvFpn55qjV17MjDxNLdWbOsWjCIY7PyQe9W2FyfFwsT9IgJAb1aeerHQQZ4NoPbfbfwnjaAHMYRweT/k8XkHttFaeK53d0VRNn6EfBwmLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4LD9cbR87q9wxsWuZoHSJF8/fdAZRIkGTenx5oUXVM=;
 b=jkBjcDFGKG7YILpv9UQPWxuzg8EjbdIzL5eM1jUgCIK+Phv6btq4zOFROAWOfnbSwfHIobtTDXDpVruCyQ0N2//YA9u+uGZOSJjMbADTxBZpMvj2y4KFt1lunYkSY7rj9kcMc/7nho5ue7LpkRCYWhhZz7O3492QKDK5jmEOs9H+W2vfiwbtvs1E7IzpO49XhBw+NoPkeZmAk9b1TN/wxI0F0FQx6AhrPZwR89eAnvfJYb4HhQwQMtnED8+MC4lbz2zIbaNhJnFKHd66jCEn6fn5tJJkDubZPm/S3yf9a33ua8PFSv2p/YqcJDfL5WCsAVnp7gp4SPm2fc+Msn2WRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7181.eurprd04.prod.outlook.com (2603:10a6:800:12a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 08:30:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 08:30:11 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 0/5] clk: Support spread spectrum and use it in clk-scmi
Date: Mon, 15 Sep 2025 16:29:34 +0800
Message-Id: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG7Ox2gC/33NQQ6CMBAF0KuYrq2ZFizgynsYF6WdkUYF0poGQ
 7i7hQ2aEJd/Mu//kQX0DgM77UbmMbrgujaFfL9jptHtDbmzKTMJ8gilkNw87jwEwyP6+VdwbUi
 RQqptpVhivUdyw1J5uabcuPDq/HtZiGK+/imLggM3SApIgi0KOLdDfzDdk81VUa68ArHBZeLCg
 s5LZYlQ/fLsi2+uZ4mTFQhFXqhai5VP0/QB7RImKywBAAA=
X-Change-ID: 20250812-clk-ssc-version1-acf6f6efbd96
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757925004; l=3955;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=J5itaEqqunD00+BEa5RkxRSc2ZFxgjVuzwpmYs0j44I=;
 b=RSvB9rT+fOMu0shOtCmqLgUiXotA5OubnFxeRxex+9j178G9MDC+Icd5SJ6YazIKXEOjBvUAa
 qguzqlbEUfvC4Hr8wBB2lH+esBQoNMu771yVdSHqYKhIHgS02RJjBV9
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f671fa6-d52b-4810-71bf-08ddf432162d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXRsT2pWdjBJaUZGUHd3UkZTLzgvcjZXMFBUR2dDQkc4NHkyVkUvcWxnbmhL?=
 =?utf-8?B?UmI1TDBHemRUK0ViSkN0ZU1Pa1lhMnRMRGRLYW1TZXV6MkkzMlQ1T2tjN2NX?=
 =?utf-8?B?U1E2NnJhdFgyM2drN0F5TWdkMEplMmNrWHN0VTZ5ckVpNXdveXU0K2Z3eXJ0?=
 =?utf-8?B?cmdHOXpoUmZ3TFZlSkpaaHVSL1RUZjl5dlk3WWNHbzZLZU5Ed0l0S2l5Wk50?=
 =?utf-8?B?U2dqVEJNUndBT1RNKy9YckxkVzAvRXhjMnA1T1JkM3VDSWpReHRzNWtZejh1?=
 =?utf-8?B?ZXlLL2FqT20rVGs4a1J6U1JldWErZS9HZlhMdGlNWkRPUnlJUzdnRXlmeVZB?=
 =?utf-8?B?QjdKSmNXZEpHRlpRMWVyNG4xM3hsVkVUNG9BdENUMWhEK3h0ZDVnTkVNWUl1?=
 =?utf-8?B?dmxpSjNGNWdCQmw1ZiswT2hXTHZOdXpOTk8zWEhvbDB5M1ZqaVlJWmdOeExi?=
 =?utf-8?B?VG1qYUZzQ3hYZmxwbmhTbjY2bEdQSUxyZVpSemhIZEMwOXpPNDdjMFBoK0ty?=
 =?utf-8?B?T3pzQytZOW0wcEJJYkNlK3dNWThWd3lNemFaS0ZMZDg4WnhJV2VpRHF4cWJ2?=
 =?utf-8?B?ZzhMOUdiV0xCQmNSRUh4Z3BweitjbnJBWkJmdzlLUkpnZCtCaURBeHg4SHVZ?=
 =?utf-8?B?TnBaUlpWMmhJUFBDdzIrRnI2Q0p5R25mS2V0VndCOUhTQlZYMW9KZVBpNTcz?=
 =?utf-8?B?NzgwTjFNaGhKcUVkSzg4REtnY3QrT3ErUGRieTVSdWpiajJxSzZwL1NFYlBU?=
 =?utf-8?B?ZGNwSFhLQS9Gd2tEelFlV1FNdG9IT3BUQUJQQW5tTlNCWWh6bGRUeTdPNjBE?=
 =?utf-8?B?a1JNNkFGankzeHY2RW96K1JrQnpJYlcra2RsUFgxdzAyUE5yZVF4bE1rcHcw?=
 =?utf-8?B?WjlySFBqVnF4L2FGbUI2N3lYejVmQ2tBMWdsdGRJSzNXZXlDK2tSQTBnb2F6?=
 =?utf-8?B?Q24weUJXazhJcTlhdEh5WXZuenU1VUx5ODRZQ1QwcHJZWUNLOVpSS2pNKzd6?=
 =?utf-8?B?UzlhQWdBSjZqQU5PQkFuYkpDOGJvQlJ4U0Z6eWtrRk1rOFNyejhwVWFQMGtl?=
 =?utf-8?B?N3JHK05DZTJqRnovbEtEeEptbWZMR1puTTU2TGtBaXBXaHNNdGtVbFpJZTVK?=
 =?utf-8?B?R3p0KzF6KytxNE1FRkJKNEdXMWwvd3hCdmZhNlNLTGZnOXYrS3pCMUdwTlZV?=
 =?utf-8?B?T3YrdzVtWkd3YnNsT1lVTHg5K01rLzFHWGRvMWFDbk5meXU2eW9OZVM0Nkhl?=
 =?utf-8?B?NjdxRERtYUJ3S1czZ3BBSjNwNEVsQW1IbVU0VXV2aUxrYXYrblV6dkZaOHF2?=
 =?utf-8?B?VXo2eUFnQUNqdWtiN2EyTTlxdUZreDJmVGx4YzJzUjBiLzIrUEpUQ3grN1BX?=
 =?utf-8?B?cTN0b0N6WDYvZ3ZHaXhUa0c4ZjNOV2Z6UU9WLys0WUFFOW1iSThqSTFFTXNS?=
 =?utf-8?B?OWlSZUxTZjFXbDc4U2pXSmk5MWdEbTF6V0NQaHVjR3ovVGpwQUJVZWJ1UU9R?=
 =?utf-8?B?VDlNSi9GdHNxUnJ3YlBrWEw2ekZpOGU1MDBsQ0NJZVVrOU1VVkpBdDVLcTcy?=
 =?utf-8?B?STMxMW5wVnY1OU5wWW53NThneXFRUEZ5K29WUXQ3S0MxSkZ5bm1DMGtIVE1x?=
 =?utf-8?B?SFE1WnJJamZEcy9TNnVzSDR0bitIaWFSZWxEMDRMeXdsSVplTUpHQ1ZlMXBZ?=
 =?utf-8?B?UHA3WDYxQkxKalVuMnFWOU5VcWtuYmpEOU5QbkhjQWFYMCswRW1Ba0pBTmpB?=
 =?utf-8?B?NGZWZXZYOUdFbHkzanE0QVVNZTlkUnJvQkFEQ3ViWm9lWGpFeGNwdTgrRHFN?=
 =?utf-8?B?bGZPYWJpRGlCdE5IK0ZGMm1QdFFJanJ1N0JCa1M2VWUzSVBLbmpzb0MyRnN3?=
 =?utf-8?B?dGxtR093S2VLN2xXTjQySGdZeFN5L0F0N3Y3YzBOWGVsL1poM1lMcDNSaXNo?=
 =?utf-8?B?eWtuemV2bUoxQzN6Lyt6bitOVnk5QlRobm8vSSttL1hpL2VlMDRwSGhubXlD?=
 =?utf-8?Q?3eoTQ7whNXh9+YMTncxYTrVf5wtC6g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjZQYlFQcHFHVFN0WW43dzZCNk9LS0locjcxSGxTWmt4ZUdORzVmcjI1R1lq?=
 =?utf-8?B?WEYyZ2lCNDl2WjZWaHo2ZWlLNk9MNUV3QzB2QmNVd1doNzFSZDVnV1d6UnV1?=
 =?utf-8?B?M0MrQXBhblRrdXNYRHdYR216L0NpQU9XNmxybitXVDJGcS9ET0FKb1M3SjdW?=
 =?utf-8?B?a3BpcTVMZ1pjM3VSZ1RsN2hIUExIZVA4ZVJTZlRSSUl0d0NxSmhsMktTd0Ur?=
 =?utf-8?B?VGg1YWpLOFNZY3ZsV0hOM3JTZ0FJTkhTZGp0RDVZckhTWEFUNm85TmdKR1B1?=
 =?utf-8?B?S1JUbGdEeUtHME9TNGY5S2dGWGtGWU1QSk5RL2FqVW80UWloOElDaEx4SXQ2?=
 =?utf-8?B?aGNlaTliZmd4cUFIdEVKdU9DbUFaaU1CZml1dkV6alBnOS9oa0czaHpFT0JF?=
 =?utf-8?B?OS9JbnlBQTYxSmlUU0s0WTRXUG1GT1Q5Rnptc05uMThheUNoc3l1d1F2RHd1?=
 =?utf-8?B?RWFvSW81ZzdONnRTZnorY1ZJeGhBMVVINjZZY2ZSYnlRL0lRTnY1TTdVYkxp?=
 =?utf-8?B?bmV2ZkRuclY5QUVLbnc3UGo3empYaEdoa25UTXlNTzNOSElReDNGTjVnMTIv?=
 =?utf-8?B?VmtBZFFwZUR3TUR4Mlg5aGpoV1RCRlpOc1Fka1NGYk42QUhQQVRkRjRBQjhF?=
 =?utf-8?B?WFUxV2E1aGJRWUl2Z091MjJ0RlBxT2FXcXlBQkF0NVJmV1p6YkhaY2dURXFi?=
 =?utf-8?B?dTdNRHBhWUx5TnlPMy9EczZlaVkvRy9CaDQ4VUdSRi94ejlGYm5HMzVwK3J0?=
 =?utf-8?B?VFlOZklFNVJxRUt2RUhjZkl0aGlCUmJhMWptTEFFM0NEUUFZNFFGKzJLUkU5?=
 =?utf-8?B?TWNuUGpvNVh3dEgva094YjdETjJTWlVTVnBINGRLMXkyVmprVG1uMXpCYXJl?=
 =?utf-8?B?ZGd1YU9LaVdQenI3YVFpb1h3eUpMNTkweFRtR1RyeUI4b2p0VTdHZjNRa1k5?=
 =?utf-8?B?R0FVTEthTGIwLzRCUHlzVEtQbGpQTW5WTWhiVTFnbWtkV04xOS9BYy9uU1FT?=
 =?utf-8?B?Vk5FeUY3b2NQcEIzd0xjazhwaFV5WEs2c3JIb0hKU1ZjM3ZmU2ZTTDVLM0t1?=
 =?utf-8?B?aXI3dFkxMndIRy9pVlk5NFRWaU1uN0xSVnF4YmEyekRtaGQ3WVpjaC94ZzFr?=
 =?utf-8?B?WUlVb1VvZDN6K01YWUd4ZXFUaFpSNzI5dDBLUlpKcyswZnlxUmh4Q0xBNmQz?=
 =?utf-8?B?YS96VnZNcEJmQjdicDJ1SlZFVFd6ZmlmZGdSZmg3b0N2Q3R4Y09hSm5aQkZY?=
 =?utf-8?B?bElXWC9vWHJRd0Zad0ptKzk2THd6ZGxWTk44dUNIRHBSTnRkRHhOY2pQYlJz?=
 =?utf-8?B?Z0RGRHhaeU1SNzVMQ1dQY3EycXZuYTF6aG1SYkY3VG1HZThFWkFVc1laV2Uy?=
 =?utf-8?B?dTNzL08vMzJSanE2QkcvNlYyQlR6QU5CUndMNVdMakJGOEZ6VjNQWVFQcmdW?=
 =?utf-8?B?MmsrNWl1cDk1bDh4OFlxdmRHUkczUXB6LzlQV1BoZEFySTJTSEhtOEJKRGtD?=
 =?utf-8?B?c1Z4MGF1M1N1V2R2VVlQUFYrV3lKYVAyMmhkcEpKR2duNVFHeDAvMi9abWUr?=
 =?utf-8?B?aXpkeklxRkFOUjJOZW1NNW51WG9PUWcrYnVhVWw3VUdFUWZha05FNWpqUWFW?=
 =?utf-8?B?eWRzaXRIVFBNZFU2SzlrTVBxdmdOT2tvd0czakZCSnB1bzJEcUxnWVJ2czky?=
 =?utf-8?B?cjU3emJvS2EwbWkxODU5Zk9rR2xoTVBUOHh1aDByYmVGM1dGTEZadVpyNWhn?=
 =?utf-8?B?NFlnRVh5eU1qbUV4bVhPL1Evc0wxMG9FODlRUmVyMldyTzBwTnBRcW9lRlZI?=
 =?utf-8?B?bWtiTWZtM3dvQXJGbjd2SG1uTVJiQXdzc0JHKyt5eVZndUd1c2R2WmViR3dz?=
 =?utf-8?B?SHpiTFM4dXU2QWswUFZTZFcwMGVpSDlWOUNNSnBQVHAxbVNNK2lvZVB5cDJm?=
 =?utf-8?B?RmNJRlQvb1RpTWFRSDZZREdERUphd2F2dXlPOTdDeitaYTR3Y2poZE9nVTVl?=
 =?utf-8?B?dHJ0S1ZGY2VOOFF6SHZWZkJXTWdGb2NDb2dvVGRUTDJxRFdHRDI5R1Qxa0Jv?=
 =?utf-8?B?TVFtMy9lNHBuaENoSU1qUXdtRG5ES1ZHcEc2THFuWUZ5cDh6bnV6YllUNzNq?=
 =?utf-8?Q?+vNeDk48F0TIf0jUrTsG8TTWl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f671fa6-d52b-4810-71bf-08ddf432162d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:30:11.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3S0xSU2XD/fuPYYmN9+npY2/NHbvmlmoDBe9EWWznA3UsuzJ2T8dNig/QP7VMJax40B3HPUU0zetWIs5vT0sgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7181

Since the assigned-clock-sscs property [1] has been accepted into the device
tree schema, we can now support it in the Linux clock driver. Therefore,
I’ve picked up the previously submitted work [2] titled “clk: Support
spread spectrum and use it in clk-pll144x and clk-scmi.”
As more than six months have passed since [2] was posted, I’m treating this
patchset as a new submission rather than a v3.

- Introduce clk_set_spread_spectrum to set the parameters for enabling
  spread spectrum of a clock.
- Parse 'assigned-clock-sscs' and configure it by default before using the
  clock. This property is parsed before parsing clock rate.
- Enable this feature for clk-scmi on i.MX95.

Because SCMI spec will not include spread spectrum as a standard
extension, we still need to use NXP i.MX OEM extension.

[1] https://github.com/devicetree-org/dt-schema/pull/154
[2] https://lore.kernel.org/all/20250205-clk-ssc-v2-0-fa73083caa92@nxp.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v4:
- Add R-b for patch 1 from Brian
- Drop unecessary change in patch 4 Per Brian
- Link to v3: https://lore.kernel.org/r/20250912-clk-ssc-version1-v3-0-fd1e07476ba1@nxp.com

Changes in v3:
- New patch 1 for dt-bindings per comment from Brian
  https://lore.kernel.org/all/aLeEFzXkPog_dt2B@x1/
  This might not be good to add a new dt-binding file in v3. But this is
  quite a simple file that just has four macros to encode modulation
  method. So hope this is fine for DT maintainers.
- Add Brain's R-b for patch 2
- New patch 3 to add Kunit test per Brain. Since Brain helped
  draft part of the code, I added Co-developed-by tag from Brain.
- Link to v2: https://lore.kernel.org/r/20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com

Changes in v2:
- Simplify the code in patch 2 per Dan Carpenter and Brian Masney
- Rebased to next-20250829
- Link to v1: https://lore.kernel.org/r/20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com

---
Peng Fan (5):
      dt-bindings: clock: Add spread spectrum definition
      clk: Introduce clk_hw_set_spread_spectrum
      clk: conf: Support assigned-clock-sscs
      clk: Add KUnit tests for assigned-clock-sscs
      clk: scmi: Support Spread Spectrum for NXP i.MX95

 drivers/clk/Makefile                               |   6 +
 drivers/clk/clk-conf.c                             |  69 ++++++++++++
 drivers/clk/clk-scmi.c                             |  64 ++++++++++-
 drivers/clk/clk.c                                  |  26 +++++
 drivers/clk/clk_test.c                             | 121 ++++++++++++++++++++-
 drivers/clk/kunit_clk_assigned_rates.h             |  10 ++
 drivers/clk/kunit_clk_assigned_rates_multiple.dtso |   6 +
 ...kunit_clk_assigned_rates_multiple_consumer.dtso |   6 +
 drivers/clk/kunit_clk_assigned_rates_one.dtso      |   3 +
 .../clk/kunit_clk_assigned_rates_one_consumer.dtso |   3 +
 .../clk/kunit_clk_assigned_rates_u64_multiple.dtso |   6 +
 ...t_clk_assigned_rates_u64_multiple_consumer.dtso |   6 +
 drivers/clk/kunit_clk_assigned_rates_u64_one.dtso  |   3 +
 .../kunit_clk_assigned_rates_u64_one_consumer.dtso |   3 +
 drivers/clk/kunit_clk_assigned_sscs_null.dtso      |  16 +++
 .../clk/kunit_clk_assigned_sscs_null_consumer.dtso |  20 ++++
 drivers/clk/kunit_clk_assigned_sscs_without.dtso   |  15 +++
 .../kunit_clk_assigned_sscs_without_consumer.dtso  |  19 ++++
 drivers/clk/kunit_clk_assigned_sscs_zero.dtso      |  12 ++
 .../clk/kunit_clk_assigned_sscs_zero_consumer.dtso |  16 +++
 include/dt-bindings/clock/clock.h                  |  14 +++
 include/linux/clk-provider.h                       |  22 ++++
 include/linux/scmi_protocol.h                      |   5 +
 23 files changed, 464 insertions(+), 7 deletions(-)
---
base-commit: 8941e75c0f122fdd76dc54ed45c4ce917587e006
change-id: 20250812-clk-ssc-version1-acf6f6efbd96

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


