Return-Path: <linux-kernel+bounces-772686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74095B29617
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6AC4E3049
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37DE233149;
	Mon, 18 Aug 2025 01:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m5KnsRWN"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D5224AF1;
	Mon, 18 Aug 2025 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480361; cv=fail; b=f13i1D2tc1u/sJ3vZd93aHquYBQuRewC8jknfWZDChLv0SiTBTJW26/1RLa0W4/rMMnsohYLv+8TRdnDEzjBg51DWx3EtS8D2FicEAxy9fhyiVSjbIxrfSXaW7VKCjC0Dmap3O23Pun0RBcx2LNF39WgKIcGVaY5i1ysZXkm5Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480361; c=relaxed/simple;
	bh=NFnz1E+VaB4ZwC5QCVlrmdjJB4ujLQDNCZBPPQouUzU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=W25VvKjo5HeGmggtzab3dr38wBfnVsWsLSW45V8y11C/Fxcz2Blx8IbfCogx1ZEdQjcJ1m7HDk7IdZbX8CpZlii1FkSOifGGvyU92uCO1ejXFEwq3gT34vqXWhp8P92vKvfyZW53D467a4L2oUF5nq71g3fCn+w8jD8VoRXseWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m5KnsRWN; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OS1lTx9p6rMWJFrvj1vGiUYwQBZbWX8ZcLUKbN3tVu22LOgXnUcY47kRdYdFC0XLuLyl/i41psxX0quAmQgwphINaUx2C1J7DOzksikP4Bms9lQybeV6g1mlHRn73pUQXnQkNN93y8OBxBPbSRhLj/Hb7Ooq43nCOWI2Tm26WXpNKNScZJ5cUu6gk7dO2YcUqeaR/HW+5XTAbKoHKZA2Z/c4cNVfvBrIAryGD0ytTYwMD3c6f0OqLmG/7yt8oBYd2oI0bVgH0+5jv6d1wY/8iNev4lmgZgZHoSTSx3dGH+PixCeILlFMy/C57iyLmaiE3awqjr2wu0sAWVjv07Kv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj53fLCMfwd0/kmM3E7UMFjAcYkxJgTHy/ltenyd/4o=;
 b=pGPwAn1DiyJwL5lCffOGow2Gs298oBIfUY16ursr/geqfXcKjI8Aamlj/gZwDiiDG2rnVgtedpOmJD+amJhCjFFDCQdpgK7Pf/sIKduxd4a4Hb+rEMrRwcpWNjPUJMANLzxWjhvCxGRIyOEINZm1vUbMLAmyEGvqWyZBFKMgNyF2RzhY/0RhDNLfZvwBb9LFarsYm8wdENUOaQcxlU8/QhfKrPlwhT3Tsku5ZPoWXT9/vnItDfk9+2wXHhwDqWk8n48p9NklDWkcDnzLqsgP0qm0ZlZnGt9FZnWm+FMZFd52hVkuH0/6NWmDcvDyWIjjbpr//RYN6dBjFjrl0SscEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj53fLCMfwd0/kmM3E7UMFjAcYkxJgTHy/ltenyd/4o=;
 b=m5KnsRWNNkGPS4WE6f6RwvMGswe7NNaShrwN1vOaBQhRdQ/D8EjHjB53TmulpMggmxzmPcaiu6Co92KjWI7HRxu0JcQmkDqmB22mlRepHpiRdGXRABknTNNzzbAmFXZGBkiaajShV1ssDW2V8pJSubP614GWhCkUqnTBcM2O7ownPr7QGVIDxe8sAdBwH390oJdh5Z5mh4uTbmVMZHXpNTJ5HJTbm17VeOHqKRWuAldR57D6parINvdy2F6Nm+bjv0cZR3OUxp/6EaH8IhoprW2A+fWhrs255Aki36XLHLcWPLGom6yqKKMBWoxN998J9B1RoOUUmJVE5NWb4icunA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7388.eurprd04.prod.outlook.com (2603:10a6:102:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 01:25:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 01:25:57 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 18 Aug 2025 09:25:32 +0800
Subject: [PATCH v2 02/11] arm64: dts: imx95: Add System Counter node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-imx9-dts-v2-2-8ba787fb5280@nxp.com>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
In-Reply-To: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755480343; l=1005;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=NFnz1E+VaB4ZwC5QCVlrmdjJB4ujLQDNCZBPPQouUzU=;
 b=4HF1Mgbe2yZ+PKuHpj/ugOTPk1NdWYkIXTwzOXDa2IpGUAspb767PtdkEZ/Z+O3nBKChplgfk
 2cTz3Qzmd7ZBXAjAJv8esyKqe9HbbgoW4ReFDdIhH135BTZUL0Yp+7A
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MAXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbb44a7-5226-4224-72e4-08ddddf62eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3dlMjhtTXpnWUt2aTdvMU1Tdnk3Q1RWN1FkZFRRbDl1akEzb25ISm8ybUFL?=
 =?utf-8?B?MWpaMmNwaDJSZUVmRVVINlB5ZlA1cnoycng5V0M4eUxMQjRuRGNMN1RnN1Vi?=
 =?utf-8?B?K1JtakNBTXAwbFB4Y1ZXdUNwVTF0Zmk2SnJNNDNkS0NFclpHUXBZSzRjR0xG?=
 =?utf-8?B?YUYzSWVXb0krczZlMUtldVJvUEJsM2dwaUswcmNGQ2djYWh5VHlTZXo2R0tZ?=
 =?utf-8?B?d1pFdVR1UmRHcGgreVhzc1FITzhoclJqY2VLZUVHMDBZNFVocytCc2oxSkJH?=
 =?utf-8?B?aXpPUWJRUEZBTXVTUnRYK3BHRWZGelJoeUMrZ1cwaEZsSk40RDNFakVPNnlM?=
 =?utf-8?B?M2pEcS9kcUZnTm1aK28xR04xK29YNmFaQ0k5RWhudERtaXE4UklvdUt3dit2?=
 =?utf-8?B?TitBRElmd1ZPNVFOYzkrelZVWWhxMGJ6Zm5XUGJvZFV1WWhzVkltUnJ2TkZZ?=
 =?utf-8?B?MUtYNFM0WHNTUGVDWnphajZTRktqZzBHRUtLZjcxNVpVTnZkaHN4ZFRCb1Uw?=
 =?utf-8?B?V1Zjc2ZEMWc0VDRmWlB0UXVUZWJzdGMrcnNZK0Q2NmU1cGlPZlVHL3I2V2My?=
 =?utf-8?B?SWhhMkQ1dS80MktKdkF1SGpUdlJlZnU0RWt6QS91dmVLOGF4dkhEcUVXRHo0?=
 =?utf-8?B?NDdJaDVEcm0xOVl0MWNESmZWaHZSOGZSckNIdzEyQ1JEWE1rZHBKTnFNK1ho?=
 =?utf-8?B?NXFlTXliaWE0Uk80UHZyeFhlUUNvMG56d1NQd0FxUDJrRmw3cGJ0THo3WDRw?=
 =?utf-8?B?RkUyQ21OSXRGTFF5bVIvZFYxUjRPb1paUy9sUDF6ZVlCYlk4eGpKYmdUMG1L?=
 =?utf-8?B?clJBYW9WeW1GSEdBdHc1bm5na0JkaUZBTUJDZ2FPaVhMcTVCWE5sL2M3UzZ2?=
 =?utf-8?B?bkdmRUtBVnpidk45emcxaWQ4bGtXN1NlaGhTSXlQQi9jNkZra3M1SEdCeUZo?=
 =?utf-8?B?ZjFkLzhSS2ZVNUhRWHlQWGwvYjZhQUVaN1NydldwRStsQ3MrcjlmQTZ2YVBP?=
 =?utf-8?B?Yk9nb2VuTXo2SlQ3aVg2eTZCS2ZlR0dFMkl5bDdib2lJeEl0KzhSRjJlM0Er?=
 =?utf-8?B?Q1htZnRBZVd1anBxU3V2MllHRy9XSEh1YWw4OWlrbWY5MTZ0UTlISVVGQ3RX?=
 =?utf-8?B?dkpWS3M3NGlpVnA5ckNoTDBMRzlxSzY1dTZtVnBRaUptbENtWi8wR0hnVWdh?=
 =?utf-8?B?Zk1IeHczUWhjVGp3ZllXMlB3MS85SnRWYXNxcTI1VUxaa1hXOFVLOWJvTHcz?=
 =?utf-8?B?NFV3Zy9yNjNobURVOHB5dTVKR2E4VGRLdGZub2g4MDIzWGJtTTY1R0ZGR21a?=
 =?utf-8?B?Q2RYY1pWeGlBQ3Fmb0M3bnZ4ek0xSjBRWE5wSjdVenp1M21sNkRUREhIU0ZZ?=
 =?utf-8?B?MGxYbkxFeHJoeU1ScVVhbnRjbEFUSkpad0Q2d3gwZkxvVi9rNnU1bzZ0WXZU?=
 =?utf-8?B?bGh0YmxIQ09hTE1sQWY1KzI1QldkTHlsTVRLOGkreTlYSTBNRVE3YVdlMFJt?=
 =?utf-8?B?WVBRVlZqRmppSkxIYmNRVi9wUU5BZXRzKytkYU0zNGVsekZVNXV5MTJscGg4?=
 =?utf-8?B?VWMyeUwyU0FYaVF5RWhlWW54U3JXQVFCWWllRDBQSE9xK2N3dDNabXRXWERM?=
 =?utf-8?B?WnJuendqM245TEpBQTkrUVU4NVdyZUczeTg0L2RPVUxZbFI4ZmJXZGUrTzJX?=
 =?utf-8?B?RkFoZkRxT0NXUjZZTmtqbTdmL0FwSTVrM1hTNWJKRlgyaHJMT1B0YjhQcmto?=
 =?utf-8?B?cTdrQXpubm1ndlFCZGNvcHQ1Q3UyN1dOdkc0aXNqOUZBQVp0Q0ppS1ZwVWlW?=
 =?utf-8?B?cVltK0VabUVhOCtVYmYyUnI1MmxQV3duUjF3WnRqckZhUWV6WlF2VjhjdFh3?=
 =?utf-8?B?dlJybzJaamx2bnN3YkNvblRyQ2hUMkIvQVNLQUdJOGxZS2ZuMmo1U0dPbW9n?=
 =?utf-8?B?OXV3emtCc3VzMWZwRVl0R01wOHF5ZzFpOGNvTXM3bFMvaWVIc1ZlQnhiQzBQ?=
 =?utf-8?B?aGhIMHFocE1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q25lTXFoQmd4VXNGampBd2xPK3Vmd2dWalhqR3NvRjJrNHNPQUR2dEhWSVpt?=
 =?utf-8?B?ZEc1REtRVDFKNmVwMjdMWlo0bGI0WTB6LzRzbXZ3OEVDL21iVjBWbXVBMlhs?=
 =?utf-8?B?VlhRdzR6bU9wb045UVVidSt3WEZmNFRLZE1rSDNQUlBtaENZZFNhdmJrVFp6?=
 =?utf-8?B?QkNLLzJmNUQ3YzlEWkZBWHlYZ1ZueEQyMjBVb1UrdTYzV3lSWW5KQ2Z2ZXB0?=
 =?utf-8?B?N0xpYjI0TWpxcE9vQ3lRM3k1N1B6VHM4NkUweTJWM1lNZytMNW1IVTBXOW96?=
 =?utf-8?B?NW1oNGlkN051N0pEeU45VlBzbjIweUtQZlh6Zk12cDArNllJb1dlSFVXYWRs?=
 =?utf-8?B?ekMyVXJJRTBzVE1oV2tQL3BBMTIzT2JnbWRyOFUrSWNzYVJhMUZKTGJCTGQ3?=
 =?utf-8?B?aTFSNENKY21INjRncmY2UDNWa3NETkNmYjQ0MFo3QnFNaE9ESExaMUUzWUNP?=
 =?utf-8?B?bUpRNUJzRUNtZklIdUdLeDZrZk8yZFpPOVV3bDEzYVFWbHJNUFVOL0lnTXM1?=
 =?utf-8?B?bjRXeHNaWUx4eFYrTGtzSUtyYWxMNWtPUGVaS2NMWnpKOThtOTBDUkJqajR6?=
 =?utf-8?B?WE1BSmN1YUN3N1UxRWl0ODd5Qy90SFQ2OWlva2RsV2R4UFJzVkE2NmlnOVN6?=
 =?utf-8?B?eXlDd1BOczFjc0FycVVmUlg5dDUzUkUrUUoydnNMZzM0VU41UmFkRE1XaXVz?=
 =?utf-8?B?VDNCSUc0bC9nZnd3R2VuRWc5TmVJSGswNXhxaUExT0NvdTFpdGpHYUhvYXBC?=
 =?utf-8?B?cFFwQUFCaTg4M1RkWEFrQXZwYTliazdaZjRTbU1FUUlXaHF1aGc2Qnd1ZFNw?=
 =?utf-8?B?RXIyazNXekhCLzdpTGdWRjBDM2FXbG1uMVVJK1Q2UzJBSHNWNGdadEdUMlAv?=
 =?utf-8?B?UENod3YvY2htdnRuYkhJUUx3bWx2WUN6ZE5lRzZzOG81VWwyemdzWlBtZGl5?=
 =?utf-8?B?NTlUU1BsS0tHQ0tDMVAzWUx5ZUN2RFV3QUo2aVVJQXNqaTAvWDFYWGtuWmlL?=
 =?utf-8?B?SmZkL3VRUTB4bktFekFyN3NEOFRIc0tNblo5OXV3QkNhQlFnVUI0YmdBcVBG?=
 =?utf-8?B?dXVFMFZEMFg3L1NWdjQvT0hLbllndFB5VEh0OG1yTG1YTGlzZXM2dWNFQ2xI?=
 =?utf-8?B?ZGNtZ2dnOGhNQTduZ1hpSUZqR1VIZm5LRDkxOWVjRFUxOHZmNVBzaFJSUERM?=
 =?utf-8?B?NUtRM2hMTHh2K29wamhQeC9LbHB0NTdsTUxGWlZtVTdCVllWNVRYL2ZpMmRK?=
 =?utf-8?B?c3kyKzVPRXhrd281ODJtcW1CU3ZBZis4Y3ZzU0tJakhOOExCSDBicTNoOVJq?=
 =?utf-8?B?Y2lua3hpdUVUK2QxVUdXL2VPMW8zZlBnTEltQVZxRUdxSG9LTmlFZnZFbzNK?=
 =?utf-8?B?SkZRaTlGbnQ2L3Aza1FvQkE3ekNnamp2ZHFuT0N5ekVTSlFkMmM0M0VEcnhx?=
 =?utf-8?B?WUVoNHgwS3VIRUdFQW1qMHd3cCs4eWJiVWlWMkpQZzlwQ2FBdi9WWDVNM3hw?=
 =?utf-8?B?ZnhYRXd4bnVnU1BlK2s2WHlubDlGakhxMm5yQisxRDlaZHNNWDZJUm01cDhw?=
 =?utf-8?B?Wm9jK2NXdmJrVnJpNHkzTHpDQ1FRbzkva3BTWG4yQmhnQVZZNzNVazl6ZkRS?=
 =?utf-8?B?WTNuWU9SMTd3ZDdDVVFhZHpaTUV4QkhyRVV5ZStjVURJMVhtMTFGUTZRK0Yw?=
 =?utf-8?B?M1YvWGVzaUx1MWZ0UVJ0T2EwN2g3Yk1PcVY1WmNqWmtuM3hvSzN0elRaTUdl?=
 =?utf-8?B?cFNKQ3ZOQ1lBWW4zeG5ENlpLQjQyNUhmaEhsZ1B1MmxWQWNZTE94Y2dwNS9p?=
 =?utf-8?B?eUZUaFIwNlNpaytYYTJCQWZqSmtxeGxLbG83bzMwOWw0SHVPQ0EzZFhwZ05F?=
 =?utf-8?B?QlJEKzB3WFVGYzk2aUJVL3E0UGFCdWJkQnc0bGY2YWtHeDkvSFl6MjRZcng1?=
 =?utf-8?B?UTUyd1RlWEx4eUNmOHhSNkl0T1J2K1lORmE3UkFDcFR5aU1JYkVvcXlJZEQ0?=
 =?utf-8?B?QnUxejMwa3F5RlpGakZ0V1d1eTRnZ0pCTnYzNnlzK0RDUmwycGRZeFdVa2NH?=
 =?utf-8?B?UVRDb1gxWFVaaTBiVzR6dlRlQ3Y3SGdQTnV4RnpSSHhQa3owWU8vcEpKcUdH?=
 =?utf-8?Q?QRNToHy9cYO906ZSb/eyRTqVC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbb44a7-5226-4224-72e4-08ddddf62eaf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:25:57.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKtPyzGfuTYU1xpzVk0sZkjq3RNtB+1pNSA44YBEh8qvGAVhGxglCHL2QGFn5CUT8wC3IqQ/RU5ADJNhmrtjgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7388

Add System Counter node to support cpuidle when arm generic timer stops

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index dbcc557d07f5b8a0ef27d68b7211b07d26fdb9bc..642dc4b7a4770be50960f53a73db965ea4374e24 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1260,6 +1260,15 @@ mu1: mailbox@44220000 {
 				status = "disabled";
 			};
 
+			system_counter: timer@44290000 {
+				compatible = "nxp,imx95-sysctr-timer";
+				reg = <0x44290000 0x30000>;
+				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&osc_24m>;
+				clock-names = "per";
+				nxp,no-divider;
+			};
+
 			tpm1: pwm@44310000 {
 				compatible = "fsl,imx7ulp-pwm";
 				reg = <0x44310000 0x1000>;

-- 
2.37.1


