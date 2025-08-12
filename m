Return-Path: <linux-kernel+bounces-764738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB21B2269F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20001562DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62C415990C;
	Tue, 12 Aug 2025 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WDekmqUA"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013010.outbound.protection.outlook.com [52.101.83.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A9E1A0BD6;
	Tue, 12 Aug 2025 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001131; cv=fail; b=Sf8I0g6rs3VB8jq2JsZFmsqXBsxjE6gRtCntk+z+X6LLKozMYhyykVLq7Kz4P8TTBYJtf7mPMcmRWSf+visKyjwxmWBUBgdI0wPmfO0cU4nXH25sbYtvx2slK99Vyu+Sp/kBftYfW27daBgLID8F+QrtWg4vwwFXdOUO3jZVt1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001131; c=relaxed/simple;
	bh=I8dZ1Y+pdQi1FtS7fxvS86sC7Z6ORGJMrVZmOLkKcuM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=f9lAz1LU+2v85gkg/q7VfzowJk1ahMNUuBkpZnCSGaygLNAW2tNUJ9ejw80HUfdxZWJhI4IhQHymR3eB5vy57XGpj7PC3QTqKiEFhG/b8zy80IaN7zqWrTx0tn4KGZVfNPB5lhw0xHFwwCNhN9t6JXyNYBvb174/CIKKctdfqYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WDekmqUA; arc=fail smtp.client-ip=52.101.83.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wv25ILJ2jBLyMWtkL1mED74DwLPFr+VzzQMx0dU5tAHCCPNeYjN785PdFJlN7QeRzsSwpaiPvWEdyodGkABB5mQ6uRDd1sUIk0icLyPgdKxId9DYJtsGyq4XcTSEMrSHvQIKPf3MwYlc7VwOrOsyh7FBHPvCcW3+NUO368lOgrVqVS6jiGOwxPZqkaN5ni38n0dAg9gmH4tlifwkNM9zjQ5h480b7kTh3CPyoVFVK86o8WJgBEtjFjrYeOef82Qgyh29O9FFv+Ef2QDWtfkD2SEB0GwpLIT9JZimXn/4pLrdbcw2ceOJc5HgTwI6dINr4RInbsYviGrpWO3CPP/opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvwk3rDsTi0CUYTRWDKTxNknuMe7upJNcwuegNGFoNk=;
 b=RJX9A9BmdbzoKaf5CwUyOJYi3bFBUTDznNiZ2fhkVAdcHOXdbHfXzlZ5pQlV24LaUFQivv/FVZ9aGjjhq4cZO9xbYuUFP+M7SyZC0U5SMRvySyyAgc9AhmKZ6ejYht1C7au6/q1dRi8HvEl1vPeyBuarc6EL8hZqMowh1Ne5E8JJCgomvk442+JCOU1KzQp4RaDs7/DpVMTO0zFMwTGb/asDiPjo44hyaAi29obSSwqsQproa7sOShOQ2VbGEoMllVyhsb11rxsoj9yFu22qB27i9RPLSYTdkJvA2IrGdIfuY8b7PML84+pBdW+o3y+PiuRDYXIdNUt3M9ltYAp/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvwk3rDsTi0CUYTRWDKTxNknuMe7upJNcwuegNGFoNk=;
 b=WDekmqUABle76jgh9a60uXpV7L2vKFwkZpWlfFLExQQZFbalKnNOpAe5J2W4pvFkGvvWdNIEGxdcqcFxrx1ogmnGOYsEn7Ce8YYFbpiPj/F0y0bF8A2rwytXfV09cULlAk4zwKGy8V6kWz8MuKvTfpFLlVqWNHhcLx7O1n+g6xwJA1VklavXNqc4XbGxIubTC1OJW4M7xV7lWlSM0JodOqjrCsVTMayhWn5As7SQR+paqrSoXLpb8oZvzL2t5Jw0G72EX9G51rQY7pqYrnDeMZ1fsQ4tEw7puk4cP69H43Dlc/9gGPYUon56Qc7SSt8A6BT0+CdB568xDKjBFHZ9nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7721.eurprd04.prod.outlook.com (2603:10a6:10:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 12:18:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 12:18:46 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 12 Aug 2025 20:17:07 +0800
Subject: [PATCH 3/3] clk: scmi: Support Spread Spectrum for NXP i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-clk-ssc-version1-v1-3-cef60f20d770@nxp.com>
References: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
In-Reply-To: <20250812-clk-ssc-version1-v1-0-cef60f20d770@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755001109; l=6023;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=I8dZ1Y+pdQi1FtS7fxvS86sC7Z6ORGJMrVZmOLkKcuM=;
 b=Y63nLYWfsBcsu3qpBPbq4VVy2k2jfVn4DMN7IceRxycqVpCVkDMUtAgRclOfqF2YbK8TNzcJ3
 2aOjZnDWpKdBFFD5DEKK5qyGTZksjX2rXKpif9OFSJZtw3POMTCajHV
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a98400-db4a-40bb-b08c-08ddd99a62ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vkl1WTg2ZDNvdVpPa0J2OHl2bmpzN0tNRkdNYi9LNW5nR1RpY252b0w0WW1C?=
 =?utf-8?B?ay9KNUxITTFoNWx2Z3lhalgzeUg1Z05uVGVoYjBZbnFhbXVLcGpmMlFiMzJV?=
 =?utf-8?B?SlBpUkZhRWZRcHVZeHU1dVFRc1hwT1gydmNwUk9XVDF5OWo4b0p6aGxiZkFt?=
 =?utf-8?B?RDN4aWRHdWtaMEx6bG4yTnd1RW9ZcE01VW1QQ0lMdWpQZmVsK3VEYldxWlZo?=
 =?utf-8?B?V3NKWnQxOFZrc1FkemwxdGxqU2NBSUNwZGt0dElDNmtTb2YxZ0UvVFZEWDEz?=
 =?utf-8?B?Rm51TFRmSE92eElnL2d5ZGlxNTUyMndFTDVXNTlWaG5YeVgwK2Jub1h0R1hz?=
 =?utf-8?B?alJCTDFCc3VpUmJiYnd2dlZvNnE2bEVYc1RXTUtMdmJxbUZwRktIMmlWa1o1?=
 =?utf-8?B?VVQ2UHF3TDQvZ0NtdEJaeitDcmVlYmNuemtacmpwSGJnRDQvQVQ0ZC9ldGJN?=
 =?utf-8?B?WWNPMndGeUwxRkU4NkJsd1djdEcyUFNCeHZzVC9wUzVxd0VJOEhCRmlaU2VK?=
 =?utf-8?B?MlJuWlpRaWNrRy9HVDVTK3pHQUhSTkh4QzNvTENZcmRUTllrVFM0T0gzS1Av?=
 =?utf-8?B?N1NZYzA4a2FIaTJSRlhzM0FDMWptRWVFWEJrRlhML3gremlTbE1YaWxpZ254?=
 =?utf-8?B?bGNnNjdITGp5M2VYaDR1RElYZ1hIVXpVV0VOQ1RibFVUQ3BOc0h5LzBBQkxs?=
 =?utf-8?B?OURWRGlmYThpVnZIQVVpczQ5cSs2czRVT0x0c3YvWnBSdGhxYzczanY4UkdV?=
 =?utf-8?B?MEJjVjdDYlN1L3ppTzRmSlgrMDE1ZERuRndITlZqT3FmZlJ0amZQa3llcFRo?=
 =?utf-8?B?QUJiLzgrWEtZMzdDQm5MZmU3WWhSTktiTjNTOExYT0JjbDR6eEpQalFEN1Qy?=
 =?utf-8?B?SW1lR0JFbi9HZjNuWC9YeXBYZkFDcDZsYys2cE13TmtPdW1TRTVZV1ZqNkQ2?=
 =?utf-8?B?TjdQV0hRbmhUWGR4UG4wM1R6dlY3ejJJTDQxQlhaUjJiQzJOMFA0Q05DZHJp?=
 =?utf-8?B?Y0pvMjBXZ1RYY1NIdTRkUXlXNFc2bUZvVDhXTnNHWW5DdW03WjZFNHZ3V3Ux?=
 =?utf-8?B?bVFNQkNNNnNhbDYveTNJRis1WHJtcldqcHNyblE4b1NDbklkMVRpTTRkZHVs?=
 =?utf-8?B?akxDU2VETXdsQXRvZS9SdVpMWGRxNTExbExWZ0p3K29PWE4zZnVDd1dXa2FC?=
 =?utf-8?B?UytONXdMTFluekxvWmlEUVpiT3B5MW9VZ085bmNNTlZjNmhhcHNFU3dpRGFS?=
 =?utf-8?B?dXpwVEM4SGIyVTVRY3dwRGtRYUNmNEIzOHlVc09vdWRXZ2JCQTlQRDdXbldX?=
 =?utf-8?B?QWFnLzJKelMzSndUOUhWQkRTU2duaWZ3VEFBVHlsOWxVMDhjTkVBRTZFRlNF?=
 =?utf-8?B?cVMxVk1CZFhJd1pKbnE3R2Z3Rm9mS0orWDk4RldhR0RRZ2toQzJwZzdTNUE0?=
 =?utf-8?B?QWM5Qlp0N3IwSGZDRmxrM1RBZ0c0WHZhdjJHWVkwUG9kU3RTbVhWNmZ6cEZ5?=
 =?utf-8?B?QUdxdzY2NGx3QlcveVhtNVU2UFJoOFZuK09YU01NOWtrZWtkVGdiV2tqclF3?=
 =?utf-8?B?dGFUM0ozdDllM3cyWXFzbWl0eTJLaDZGYUpDK3JXNDZlOUtTby9KNzRpTDBs?=
 =?utf-8?B?eWYzYkJaNUZDQkhSa2RxZmN4aFFOaU9sOWUrUUMyLzZNVW14UWZuVnUxeFor?=
 =?utf-8?B?SDVRRldTSWJxU09VUmhhb0NhSFhhTjZNUlNTb1lNYVVjeFVTT0kreW1YYlhu?=
 =?utf-8?B?TjNraEozblZjWWxZQ2ZGTlgyVWFSc0xaQnRFbTZrUDhLaXhrV1JDUjNsSHNN?=
 =?utf-8?B?ZGtWMURhM1ZIMk1XUlQ4RTAzU0d5WE85bkc1Rmo2UHZ2QmtlSjJrdmFwV1Yw?=
 =?utf-8?B?UTlUUHhKUzJJN0liV2YwbDFCR1JzeE9VNzAydGpzNXJ3WEJ0NkNwLyt4dDhZ?=
 =?utf-8?B?MVhyWXlyVExwaW42blRxSjlZR1Uwei9ZTWxiUGRyR05xY1VjZlh4R0xkZG5Y?=
 =?utf-8?B?aUZCbE4yNDF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3QyWWpDT2Y5R29FRGtBaHoxMEtKRUNmK3NjU2FKczZFeEFRVDA5TGROU0ZT?=
 =?utf-8?B?ZndKaFIwQmEzRlhrUDY4R0hLR2dvL25nUkNPZFp6NitpVGtIVFZOdWplZEta?=
 =?utf-8?B?QW8wcS9ZV0dOSXV2NytlTUs3OFNIQTQ0RWQyMHFqdEZOOWM5RVJ0YjE3UlAz?=
 =?utf-8?B?MGF2TFVSODA2YTJoVjl1M1hrYnZYcVUySi9mRGtwYXJYQ3BTSnptbEJhdjFJ?=
 =?utf-8?B?K1JmMUFDLzU0dW4wTllmeXFkWWhaOTEvVXhvVWw1WFJnbHV6bHRkNWtQbnhQ?=
 =?utf-8?B?VTltYWFtSW41dzZGWGFHbG41eDZiaW10YkZkcEpMR0lMZmxMNUlYdFBRcWRL?=
 =?utf-8?B?SHpmRWtIRytyMHJCUVRsSkVkL211SmZLc0pFQ29oa0VlSmZRM1FZVXMvd1la?=
 =?utf-8?B?YTZ1Sk1yNjJZZE1CSHZHUkRBN0lRK2kwendLKzZlZUprOE9tVmdUeFlDTFBo?=
 =?utf-8?B?bFRkeStFRGVpOHVVaWg3b3NqVTgwSjJEMkJEaHpkd1VEaUMzNE1GdmN4WndM?=
 =?utf-8?B?NVptUU5PQzdRQzFOSUpYang4ZVN1K2VqN3I0dzh1N2UxTUVNcDRmb1VRTlp0?=
 =?utf-8?B?TmREZ1dPVGtDRlBINlIrNUN5ZzBnS3AwbFFxdndONUdlU2sxQ2szSy9qL3dG?=
 =?utf-8?B?aWZRUzNvVWoyN1BlTk5HbG41RWljVUw3d2xpTzZhSSt1NUZyRVhIeVlBV1lD?=
 =?utf-8?B?R1FGNkJmTzhhcDNhb09xdEtBS0l0NmJBQlRCVXZ0ZGk2SDlBM0UyWUc5bHpi?=
 =?utf-8?B?cjZRMWcvaXJmdVpRQkVSR0dIVFNEWlpPcTlMaVlsaHh6VnVIYnRiY1BzL2ZK?=
 =?utf-8?B?VE9WcmN2dHRrTzRjdWt3dFcxNUg4bUw4NUtiZ2dzTDBSRjI4ZXRxeWJhZmxt?=
 =?utf-8?B?OHJsN2krWWhqNHFFNnQ5bVNNV1FsZVJMNDVBYlFNbHZKa0txNXNoaHFoUWRV?=
 =?utf-8?B?cjFqcGVYOEY4cmNUQVhZRFdtNS9QNk9XZ0Exb1JUeWdlNm1GZUsxMVNGTGhs?=
 =?utf-8?B?ZVdkNUlYSDI1bVFxVkM5NFgwN2hOdTRCTVlEVmVaTFVQY2h2UnpHTkZyWXQ1?=
 =?utf-8?B?Z2tBakM5SlNwTWg3d1Q5dmpUcnJaMHIvTndzYUVmZERxKzBHMk92MkNkZEVD?=
 =?utf-8?B?UXlBVHlRRWlYSTZzNngxZk1JTGVST1BsY1RWU0daV1ZrMXFMUG4xV3lhZmtL?=
 =?utf-8?B?NG1rcWwzN1NZZG80S2l6SXhIQTV5THRwTTB6Wmt2ekNNMW9xTUVIWk0rSktY?=
 =?utf-8?B?NkNTbUlxRXhpTU1XVHRQWkJwZVZDYmtRVEk1SjJQTVZoS0xBSGtVbGFGUGZi?=
 =?utf-8?B?a3hGUzFJRm1oOTV0eTZqNFc1dGVkdmNxMlJnNFBGeVpsYnJYcGhkaytDbkRa?=
 =?utf-8?B?RnBnZDdEUHNta3Q5Q1pNZFdIV28zZW5MWkN3SjBJZjYrelY3c1ArZ2pvK3A3?=
 =?utf-8?B?UGlqMUlmTVNtY2ViNmlNRzRTdFptV01yUWI5bm1sRVV2NlNKaGIyWHlRRFVK?=
 =?utf-8?B?U0tLU1NXK0dWNlBLUGd2N01HVkdIUGw4UllXMytRcTM5QVMzdFBxYWIwQUhR?=
 =?utf-8?B?MVVza2lDTUgxQVd6WFN6VWt6blJrcWtSTGVXd0pRWS9sRy82N0NSM2lralJy?=
 =?utf-8?B?bUdvQXVOemNDMjBLaFBFRExqb2VvYnJPb0VqMGVNUDFHM1VuazdNL2lJTjRh?=
 =?utf-8?B?TkU3TGYwV21OVTdYTW1lUWsrUHpMTFRWMU5lOUxVR0dxNHNnNHVHNCtHQVRR?=
 =?utf-8?B?dUNyK0laZlFISE9JYnA0Y2hRVWVYdUxHYlBZZTlrbUVLeCs1eUlzWUdFeFJ1?=
 =?utf-8?B?TVdoU3ZqOHh5S0JrZ3lkaWVQK0J0R2tWT2pxQXJtcTNobnNxTS9IL2dPUWE2?=
 =?utf-8?B?Y0hHZEE1ZURtVU5Yek5oaElod1VmYjBMWmk3a1FEeExNRDYwazZVOUVkSUZl?=
 =?utf-8?B?KzFDNEdueWRGTWhxc3o3a2hXOUh3VWo5WFE2Q0tScHQyaFBMQ1VwUWxaUmRk?=
 =?utf-8?B?aXFxYitsMVhuTnoyRTcxdUpkaUpsZktnTlkrazFqWGlaajc3RGhPdk5JU1Vi?=
 =?utf-8?B?SVIwcm9pdTVtMDAwM09vaXpGWXVVdlBDRWFpRTZkbFZWYVNqTFJTM1lPcXVt?=
 =?utf-8?Q?Od5lhAUYrQUnX2AXFD9afMZi4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a98400-db4a-40bb-b08c-08ddd99a62ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 12:18:46.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txMf3/jHUovjkfhLSU9s1hPXM9iMWoracn6coceGerQNjXzBONj2VW2iLlia55KlX7Ezn7ke9AL8o7gKkIvpKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7721

The PLL clocks on NXP i.MX95 SoCs support Spread Spectrum (SS).
This patch introduces scmi_clk_imx_set_spread_spectrum to pass SS
configuration to the SCMI firmware, which handles the actual
implementation.

To ensure this feature is only enabled on NXP platforms,
scmi_clk_imx_extended_config_oem is added. Since SS is only applicable
to PLL clocks, config_oem_get is used to verify SS support for a given
clock.

i.MX95 SCMI firmware Spread Spectrum extConfigValue definition is as
below, no modulation method because firmware forces to use down spread.
	 extConfigValue[7:0]   - spread percentage (%)
	 extConfigValue[23:8]  - Modulation Frequency (KHz)
	 extConfigValue[24]    - Enable/Disable
	 extConfigValue[31:25] - Reserved

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-scmi.c        | 64 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/scmi_protocol.h |  5 ++++
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index d2408403283fc72f0cf902e65f4c08bcbc7b4b0b..bb5e20dab18e92932ab4b99192b496e0c4d96417 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
 #include <asm/div64.h>
 
 #define NOT_ATOMIC	false
@@ -23,6 +24,7 @@ enum scmi_clk_feats {
 	SCMI_CLK_RATE_CTRL_SUPPORTED,
 	SCMI_CLK_PARENT_CTRL_SUPPORTED,
 	SCMI_CLK_DUTY_CYCLE_SUPPORTED,
+	SCMI_CLK_IMX_SSC_SUPPORTED,
 	SCMI_CLK_FEATS_COUNT
 };
 
@@ -98,6 +100,35 @@ static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index)
 	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id, parent_index);
 }
 
+static int scmi_clk_imx_set_spread_spectrum(struct clk_hw *hw,
+					    struct clk_spread_spectrum *clk_ss)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+	int ret;
+	u32 val;
+
+	/*
+	 * extConfigValue[7:0]   - spread percentage (%)
+	 * extConfigValue[23:8]  - Modulation Frequency
+	 * extConfigValue[24]    - Enable/Disable
+	 * extConfigValue[31:25] - Reserved
+	 */
+	val = FIELD_PREP(SCMI_CLOCK_IMX_SS_PERCENTAGE_MASK, clk_ss->spread_bp / 10000);
+	val |= FIELD_PREP(SCMI_CLOCK_IMX_SS_MOD_FREQ_MASK, clk_ss->modfreq_hz);
+	if (clk_ss->method != CLK_SSC_NO_SPREAD)
+		val |= SCMI_CLOCK_IMX_SS_ENABLE_MASK;
+	ret = scmi_proto_clk_ops->config_oem_set(clk->ph, clk->id,
+						 SCMI_CLOCK_CFG_IMX_SSC,
+						 val, false);
+	if (ret)
+		dev_warn(clk->dev,
+			 "Failed to set spread spectrum(%u,%u,%u) for clock ID %d\n",
+			 clk_ss->modfreq_hz, clk_ss->spread_bp, clk_ss->method,
+			 clk->id);
+
+	return ret;
+}
+
 static u8 scmi_clk_get_parent(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
@@ -316,11 +347,33 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 		ops->set_duty_cycle = scmi_clk_set_duty_cycle;
 	}
 
+	if (feats_key & BIT(SCMI_CLK_IMX_SSC_SUPPORTED))
+		ops->set_spread_spectrum = scmi_clk_imx_set_spread_spectrum;
+
 	return ops;
 }
 
+static void scmi_clk_imx_extended_config_oem(const struct scmi_handle *handle,
+					     struct scmi_clk *sclk,
+					     unsigned int *feats_key)
+{
+	int ret;
+	u32 val;
+
+	if (strcmp(handle->version->vendor_id, SCMI_IMX_VENDOR) ||
+	    strcmp(handle->version->sub_vendor_id, SCMI_IMX_SUBVENDOR))
+		return;
+
+	ret = scmi_proto_clk_ops->config_oem_get(sclk->ph, sclk->id,
+						 SCMI_CLOCK_CFG_IMX_SSC,
+						 &val, NULL, false);
+	if (!ret)
+		*feats_key |= BIT(SCMI_CLK_IMX_SSC_SUPPORTED);
+}
+
 /**
  * scmi_clk_ops_select() - Select a proper set of clock operations
+ * @handle: A reference to an SCMI entity
  * @sclk: A reference to an SCMI clock descriptor
  * @atomic_capable: A flag to indicate if atomic mode is supported by the
  *		    transport
@@ -345,8 +398,8 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
  *	   NULL otherwise.
  */
 static const struct clk_ops *
-scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
-		    unsigned int atomic_threshold_us,
+scmi_clk_ops_select(const struct scmi_handle *handle, struct scmi_clk *sclk,
+		    bool atomic_capable, unsigned int atomic_threshold_us,
 		    const struct clk_ops **clk_ops_db, size_t db_size)
 {
 	const struct scmi_clock_info *ci = sclk->info;
@@ -370,9 +423,12 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
 	if (!ci->parent_ctrl_forbidden)
 		feats_key |= BIT(SCMI_CLK_PARENT_CTRL_SUPPORTED);
 
-	if (ci->extended_config)
+	if (ci->extended_config) {
 		feats_key |= BIT(SCMI_CLK_DUTY_CYCLE_SUPPORTED);
 
+		scmi_clk_imx_extended_config_oem(handle, sclk, &feats_key);
+	}
+
 	if (WARN_ON(feats_key >= db_size))
 		return NULL;
 
@@ -459,7 +515,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		 * to avoid sharing the devm_ allocated clk_ops between multiple
 		 * SCMI clk driver instances.
 		 */
-		scmi_ops = scmi_clk_ops_select(sclk, transport_is_atomic,
+		scmi_ops = scmi_clk_ops_select(handle, sclk, transport_is_atomic,
 					       atomic_threshold_us,
 					       scmi_clk_ops_db,
 					       ARRAY_SIZE(scmi_clk_ops_db));
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 688466a0e816247d24704f7ba109667a14226b67..6f9f197ee671540e38470a5666eb5ba8ec9de439 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -80,9 +80,14 @@ enum scmi_clock_oem_config {
 	SCMI_CLOCK_CFG_DUTY_CYCLE = 0x1,
 	SCMI_CLOCK_CFG_PHASE,
 	SCMI_CLOCK_CFG_OEM_START = 0x80,
+	SCMI_CLOCK_CFG_IMX_SSC = 0x80,
 	SCMI_CLOCK_CFG_OEM_END = 0xFF,
 };
 
+#define SCMI_CLOCK_IMX_SS_PERCENTAGE_MASK	GENMASK(7, 0)
+#define SCMI_CLOCK_IMX_SS_MOD_FREQ_MASK		GENMASK(23, 8)
+#define SCMI_CLOCK_IMX_SS_ENABLE_MASK		BIT(24)
+
 /**
  * struct scmi_clk_proto_ops - represents the various operations provided
  *	by SCMI Clock Protocol

-- 
2.37.1


