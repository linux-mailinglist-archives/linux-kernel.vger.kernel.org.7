Return-Path: <linux-kernel+bounces-846486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816D8BC823B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315623E646E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB8A2D3756;
	Thu,  9 Oct 2025 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Ik2aKtzx"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022139.outbound.protection.outlook.com [52.101.66.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42D2D321D;
	Thu,  9 Oct 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999996; cv=fail; b=BuqLVKS+z/eTD2XoGBsXAT7QVqKgOR2TvViIsGSKTuqxp0NofMO3qKPcUJLc/DM0qPlvQkmYetEpNeF2v4XG2UlqVNLs8GPyx45jpm4GnwMQu+kxS4hX5I2qEDWJWKR3g6c7ayo+oEhRm85EDKjEYuCjeKWbN/6eJ9X6wh6fH5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999996; c=relaxed/simple;
	bh=w+rInlVkAh1PK8OB/QOdce0NeilOIS6wyg+QyDefKPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c+hzQunvJHr5cuufQFGOQKjEz/cvT7r07thVrKzc5T+2pZAG+0ILy9qAtvJUJA/zDAJ0O6vhTNH3GMS/CMZzKyQYkjUkeo0u9U5oO1mUuYAv+C7BfvcZTbEcUWy2FY8fPVXXkKTIZIoAGLeyFw/A3qoNjMDWky4gEnx0NlnybJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Ik2aKtzx; arc=fail smtp.client-ip=52.101.66.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFQqa+6SizkKxQI8ClpPpun0M0lSQ3syH+PGTCggNPZQ/sFc50ux17Y8ytYVJp86yWtEepaLeuMMeaCuTyBR7yN5Jjtl1GLeRNCA/MgnYFPU34mtsQcgGhoyGWXi4mM8GUknLGSbQUc0HGJJOPzaZpfOjUmbeJ3q9lN9lQcTwVA/siiffmDFZuErO2N1rVETk492V83epk/jkTpXIcDR4ZyTRNuqyNIRBaXqBhg1k6MYDRQ4INV6EPUb3EJV8yB6+OsQh44xC2oiDJwqZeLHeedLqdjd4yuPg9Ku0hTO1WDYzWoRXmmiYaS9yqAS1mBYM4FUOF2EckZMVPX95b/UFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZHNPLQiw413uvBxrkZppSRbwcvTmQ12So+1FLPSMhc=;
 b=XdQrDgfLJ1RcFB7z8TOhhmlY7UXWd+VVFrLKyPyOGt4MUt+URS0E0dGg64ESldYOXHTUYKF+6C1XCBvoLQeVOyq29fXEOSbkwX+RoyILiOEVsvydHhIVI9Rzk5w6MBgXIvEg11V0jGN7DNDMCjXfRxB0wTe0xY8osohGuk8K/R2TEZxYLq133yRB5os3v3AEAx0KZf9p7FP5TZZCoGgFFGWuJP7G3vukTDjLzVE7jYQH0nnvjs0yzZTL5QbpFuzJVtaCbL654hySCTLWEr+RqYgcX0BCgzpyIoYLfLSfGWE8btVymcYHKFIW3l0/ry5c2UH9njVlqbWTzdTdCwEVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZHNPLQiw413uvBxrkZppSRbwcvTmQ12So+1FLPSMhc=;
 b=Ik2aKtzxAhr9upBW4gWMdQryMauFZnKsW10mo2yo00F7StN+AU+s3Cb6SAvcOj7bN6OXmzGOE/0U8McQhxeg+FcD8IFaKgzMLNkooc3IsdU34+X3P72appOe0nEPzS1AlGyQ5rwQjZLg0vqM3UCXQbw67vlsvRjdAq5B/O1TxZLVXeobE8bICIDUyv0/vEVRieM3stddioaUQKBjjKEXpT3ghzVHEs3B4vTxjR6oKa6Y48Lr4C8iKI9/iCn8EfXabPrfya4zFpPR9AUa+k+lZ83DMrk2X7m5QwsvxzlkZzOWuzx08GHxsYqILpf2MhVlgQk2F1o9GseXQoSOUSJONQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8434.eurprd08.prod.outlook.com (2603:10a6:10:3d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 08:53:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 08:53:11 +0000
Message-ID: <ca777e63-96a3-4dbc-8540-2fc8ed61eec2@iopsys.eu>
Date: Thu, 9 Oct 2025 11:53:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] clk: en7523: reset-controller support for EN7523
 SoC
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Felix Fietkau <nbd@nbd.name>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924104850.1930254-1-mikhail.kshevetskiy@iopsys.eu>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250924104850.1930254-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0f4850-d3f5-42a0-91d3-08de07114672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDdoYTl3TVh2a0NETVVIZDY5MmExenNMMGJ3Nlc5aHBkTk9NQkN4SUxwdytQ?=
 =?utf-8?B?RkYydml6ZFNaUzNJNEJjR3ZSK3FEWlErMzFaYVRVZG9YVGZrb3oraTJ5N0E2?=
 =?utf-8?B?OG5RNGdSUjRnM3l3cWtMRmc4RG16NlpncmpCZUxONzcyVVlOVW02S2UxZXpX?=
 =?utf-8?B?VnpuSlg2YmhOWkx6aTRRWWNTbHd1QSttM1FiNjZ6NjZaSjhJbFM1djRaL2I5?=
 =?utf-8?B?WFl2Uk1vZzV1NTFkdCt5NW1BWmhQMlFtVEFHL0EyUmQrNHMyZDF2UWxIMGxW?=
 =?utf-8?B?Mzd3RGNlN3c4MWtFY3N0bXVpVGZadlJoby84TE1nVlZDZzk4ZE1uZFF2MzB1?=
 =?utf-8?B?djVXVHlwWXMvbm9WUjB3TDhSNHR4THlUVllDVGdubGRFQXNPQVhmWFZSZTdC?=
 =?utf-8?B?czFKeVFQTGcxOXVNc2FCSFNTcmVlN2dDeGFJbGNjWXhnelVEeWJVdlk2aUdV?=
 =?utf-8?B?NDRETmV0bVVpVXdzY29Qazh3Q3JPTytyWHdEYU4vNUlnNTNHRFZCY1lzSVdB?=
 =?utf-8?B?MCtPTVhFa2xOLzgxQldXa3ltaXFrRmtpMERodU1kQ0ljMzJpdVJzUGIxdnRa?=
 =?utf-8?B?bFJVZzhGL2RNTWxGQUw0RnEzYlJGaXRoaUpaNVN3WGlFV3hGMG1mZys1elpI?=
 =?utf-8?B?Q2xYQUVRQ0hFTkNwYmVrdk5lenBIRFhKQ3ozZldzTlhhbERKekxGdXhEUDNQ?=
 =?utf-8?B?V0FXQW5vWVU5ZFNUZGdaMVpBbTNBY2JGSjFkMHVxQzZtQjB0cjRlTXNpK1ZX?=
 =?utf-8?B?WXBMY3ljaHRwL0wrVE9qdytkekRPd1l3eUsxRG1kaForU0ZrZEMvY05LQ2do?=
 =?utf-8?B?eXFqVmgzWG5yUGgwN3Brc0J0LzF3b0lBclZWQXB5NVpCS0xCSEtUMFNha2dG?=
 =?utf-8?B?aVBnTUNQdDlQM3I1STIzeHEwdUpYMURMaFJxdFdkRlIwYjEvdmsxQVVnMktG?=
 =?utf-8?B?QXpvVTV2NS95U1VLNSszSWV6Z0lLUm9VYmlwdXlQS3JaRGN5VCtQbUFjdld0?=
 =?utf-8?B?NFpoVlJrRlJ5T24rbTZDcmxqT0IxRGNsVmlxQjB6MmVNK2RiZUZZemF6L213?=
 =?utf-8?B?UHY2SW03UVFLWFR0UDk2SVdnbklHU0RLUnRaU28yamE4T3UyYXVaRzNXSjVM?=
 =?utf-8?B?aDZNQTRUZ2E2dUI3anVQVy9qTS9aR0ZocHI2T3B4R293QUYrcnlpS1grN1di?=
 =?utf-8?B?MGZGcEpzdjNiOEdPMTUrcVNueEVNajA0amNhTjcwN1h5TVpDN3ZhVGNHU2xS?=
 =?utf-8?B?MElRN3FlRC9FWmNpcDUxOEthRXBSS3p5MVIzcEgrcENQRjN2bCswcHRNc2h2?=
 =?utf-8?B?NXdQUnk5SDdOa3dxc0hDOXRLRGw2MnUyN05lTGRxUDlaMkwwdkRUTElVTlhV?=
 =?utf-8?B?LzRuSHE5dFV0VDArWDllYUJCbEFCRXlPV05WRDkxU1c0V2FQU1Z4RHVVY0Ir?=
 =?utf-8?B?eFhzbU5mM2dGQWN0YWlRN3d3VUJyeWxtbU16K0VvT05nZm56QU8rM1djY1lG?=
 =?utf-8?B?cEtxZFlHYldKYXFPSTJzS1RZVE5mdkx4ekFvWHppa25PTGFqcDFRM0dmcWd0?=
 =?utf-8?B?aCtycTIvbStsclhxMGZ6djg5bG5oeDV6QW51VGt3L094OEJBN21ReUFMUFNY?=
 =?utf-8?B?QzFPaDB2cVpTdVNTYitGbWcxSEZwQm8xVmFTWHE4S1N5aGh5alQ3VjB4ZWZa?=
 =?utf-8?B?RTdHMEVudzZFSjNSQzJLUHZzU0s5S09jWU5KckZ4VWsvQ3FvVUZVRVMxOFQ0?=
 =?utf-8?B?TW5BMVozRUxkbjFROVR0RTN1SzNJTThWQWxqNmg1ZWxSZW01dU5pYnlwbXB0?=
 =?utf-8?B?NTVWWm9QU3dkTjRJL2ZRMHA5K0FuWHQ1ZmZMYU1ZTHZjckJIUTFvRHpNYUk5?=
 =?utf-8?B?NUV3WHpuOXpVNk44d2RRbWpLU0JEcURpRmp0alp1OFZOVXY5bU9xMTVWa1lV?=
 =?utf-8?B?c0M1UzVCQlB0Kzc4OWNjeXFIWXEydzI4ZzZicVFWVWlYUDErK3dyY2hKR2No?=
 =?utf-8?Q?Q3Y0zVpIlp/NFW7xKvD8C1WnQ0Tm5w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVJoSExOUTc4bUtoVTJPZnJGSHFtQWZXVnRCUmFmbmxhYzg4SmhLWmFrUGtR?=
 =?utf-8?B?UGk5dGc1MDRjMzloMFI1UVNhT1NyY25NbWVIbVdGT1dsRXhCOVEyblRsS3dZ?=
 =?utf-8?B?YVI0REZJR3BvMlpUZDVWZEJCakFCelhWd3FpaUQ1UEdUS2o3R0tpcTdXV3Fz?=
 =?utf-8?B?RE9Nd0tuamFRRXgwelFEQ0pSZUxzK2RhaFprRDBSbzcwMzdZelFpTGQvMnJO?=
 =?utf-8?B?UUt6VU5EM3lGZEhqdjNvTXJzRTFtWDRMb1FXalRDMmk1SG5KMm4zUDlJbDVt?=
 =?utf-8?B?VGtqd0dSeWdBV01rY1ZCVjQ4cFVuRW4wTWhSQWxjYWtZc1VZVHgrcDJjUi8v?=
 =?utf-8?B?bVU3WmdBUk1McDlDMGova1lEdlFQdnhIcVJmeVBUaGRPRFFhdDJmVC9FeVVX?=
 =?utf-8?B?SE5YdjRaZXZwTHlkTTVKV0VqUjcybmlFYXJBQVRyRG5ZbUswR1NiVHRNYkpQ?=
 =?utf-8?B?SVlUbVdHci81K2prMU5tdEtBRjFiU2tIZ2lRM25vQktWdFIrVlFmT2N6RHdz?=
 =?utf-8?B?czl4N3RtUFh6SXd6SDBjeU9ZZFF5bk9iRmtzc2owWktWc2plQ3lsNjJPN1py?=
 =?utf-8?B?aXF4RHorbWk5MVRoV2JtYWVNUmxKRitiZStjbW1ObDJESlM4Z0I0TXBPVUFh?=
 =?utf-8?B?WVZ0V0xDelc3OWNPNm8zaHhJUGpqUlYzWVNnYTF0L2Foc0prbE1aUStrRWdS?=
 =?utf-8?B?dWhHdXd5VVJJS0FNWGJJYURPellJTVQ4RkVVRVh0YXNodmJSZlhQSm12WlJX?=
 =?utf-8?B?bTZXVXg5alVieU0rK2FZRnJpQXIvcUorc2RMMGpYNElXZEdvTU9mUTJ0dE9Q?=
 =?utf-8?B?cHE0UGFuQjVCR1psZ3hmZW1YWDhrUlcyYmF0OERiUExaNmFqQzZYWmlOQm9k?=
 =?utf-8?B?ZW1qczZEdzJ5S0kwcjVraWVPVGdCdHlIT2ZTZjZEUXZnOGM1ak5SY3loWTRM?=
 =?utf-8?B?b1hTR1RNZUxpbjhlMjk1TjRQOW1SN29PTUNyYjRsa0pDcEMvekExUUVobUE0?=
 =?utf-8?B?RWE0SmxUUEQvT3o2SDRnbklOYkg2aHdPbFNJaTNIQStOcVhXMm1CVUxKcFBW?=
 =?utf-8?B?SnptR08xSEhmOWdQR3RlZTU4SjhOOFA4LzE4Zm91TlpCa05ZbzVpeFVSV21P?=
 =?utf-8?B?VU1HdEpsa1VkcEowMkxYdFZMWDFxYWRDWE9oUjY2NUtISUhpOGRqNEJmWHNE?=
 =?utf-8?B?RHhrbmhMZXIrMG52WWp3WlVCUDhZTEVoZnlpM1BzNXhLTDREUUJWakFjTXpm?=
 =?utf-8?B?bGw2dElxd3RpZkxQTCtBNE12TU5oWFlXb3dCNmRNdk9vd1BERTUzRmpKVUFi?=
 =?utf-8?B?S0FhNGQrUHpnYi9QWlhGMk5PUEszbWkyWVZvMW1ub1FidTMybDFPbEg2V2sw?=
 =?utf-8?B?VjlIMHN1VjNxV2JBdzh0RzVON2Y0ZEZvNGJJd2dyQzJRMHk2WEVDTWlsZ0dG?=
 =?utf-8?B?OHUxMU5jTE5lQklPWElTYTVmdTFRZTUwUnUvbEZES0x4aGNhN0tyYlRyRHpi?=
 =?utf-8?B?dTNxT0VWVHhsOFBLamZUcDVqZm9LTUw1VUdCOWtBMExnT09ySnMyb2l1ZElZ?=
 =?utf-8?B?bVhyQlFTODlaWStGK1IzRC9vZVFreXhJaEI0ZVBxRXRyaGpSQVlVb053Z3Aw?=
 =?utf-8?B?QXVNUkxmNk9mSnk2ZkNERFNCYXYwUTVKcjI4L3F3ZEpFNy8rYng3QTN2NlV0?=
 =?utf-8?B?RUFkUUtobXV3b3pKQ0lNVXBBVWZnQ2VjZlpVYUJkRjBna0RWbUp6d0xUdWRN?=
 =?utf-8?B?eUZyeEY4bGc2WEFVeTI3UnhNQWQ1Y1kxVGsyQlFZM2MyeU5EUkYrekJVdmJQ?=
 =?utf-8?B?aWFid3lMU2VjdVNPY1V4TlAzY0NnTmJNdDdsbC9yYWN1aTNaOGVTS3d5VlQ0?=
 =?utf-8?B?YUg1bzJiYVB5OUUxeGxWeFFsUnJmYUYwUzVvZUVtV3pBMnRUMUxrNmZwUjJ3?=
 =?utf-8?B?bWVabVFVVDhvdFhRbFZiZlZWdWJZSWtsamtDZXhqMXNjOFBpaWhZSkw5T1dH?=
 =?utf-8?B?YkVxR2duSStsa2hVL1lveVVOa0lOQ3VFZkZ2Y2c2aGZQQlFSYU1sSXdrQVJ5?=
 =?utf-8?B?SW9EeHVXWnBIK0U3M0JpdU1sZkZVcFZBWENNN0F3Ni9NczBEd3RTWThTUUhV?=
 =?utf-8?B?SEtwWmowaVpqT3RRQUx4QmdiblVaUEU0NW4vUzVUbGpxdGF2dzhYdUt4MmNZ?=
 =?utf-8?Q?t8b8U0bjkOCPWlwOouV9Sac=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0f4850-d3f5-42a0-91d3-08de07114672
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 08:53:11.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yl88ZDRoGcDzOOzKSCovvRFhMl4NDqHgpGA335I0Q/VAKEmzYGqZn6TDmmKPQ6N8vyMbBi8F4+F7Repy/DnlpjPn606V9o21jlHj8Jd7G/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8434

Is there any chances get it merged to linux-6.18?

Regards,
Mikhail Kshevetskiy

On 24.09.2025 13:48, Mikhail Kshevetskiy wrote:
> These patches:
>  * adds reset-controller support for EN7523 SoC
>  * updates dt-bindings
>  * updates en7523 dtsi
>
> Reset-controller support will allow us more easily reusing of en7581 drivers
> for en7523.
>
> Changes v2:
>  * keep '#reset-cells' property optional
>  * put dtsi changes to a separate commit
>  * add missed dtsi include
>
> Changes v3:
>  * keep en7581 prefix for common en7523/en7581 variables and functions
>
> Mikhail Kshevetskiy (3):
>   dt-bindings: clock: airoha: Add reset support to EN7523 clock binding
>   clk: en7523: Add reset-controller support for EN7523 SoC
>   ARM: dts: airoha: update EN7523 dtsi to support resets
>
>  .../bindings/clock/airoha,en7523-scu.yaml     |  3 +-
>  arch/arm/boot/dts/airoha/en7523.dtsi          |  2 +
>  drivers/clk/clk-en7523.c                      | 64 +++++++++++++++++--
>  .../dt-bindings/reset/airoha,en7523-reset.h   | 61 ++++++++++++++++++
>  4 files changed, 123 insertions(+), 7 deletions(-)
>  create mode 100644 include/dt-bindings/reset/airoha,en7523-reset.h
>

