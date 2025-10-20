Return-Path: <linux-kernel+bounces-861778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7299BF3A54
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756FA18C484B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3153A2ECD3A;
	Mon, 20 Oct 2025 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C+P83YxE"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8C2EA172;
	Mon, 20 Oct 2025 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994426; cv=fail; b=Vc5XajFoHPmX3fT7yULtphqgPXci8IUQlJS0/cUWC/8h3JVJgEU9Rv/8ge01q40TeItZFPyrlu+K9gXKfdkPGy6s9AoraCLr7HMX95OiWXkWAn0KPw2v+C9jgPkBE915xyBLEyinnhGPvyx+mWio9aFnPfImKDdjuOLVQ9xaepM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994426; c=relaxed/simple;
	bh=kp+D5c4fcdfwelfvU50juvcloK0a6nkna7wbA0g3tW0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PmLnxi8tgWDIQcfSFB/OZqrfS84+8sgnuHtb3cB+ifNA6W1qBlHq58A6o41VHon++umUYs9OY8tTZKoWPF1DI3Fesaw7Zs4ChDFd6V/2lUhy0E7TNqj/ULkIHTbp3GCQrGwDoqxLEzkXG02J5JK8qlUc3P5+oqAV6BqO1SV0gRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C+P83YxE; arc=fail smtp.client-ip=40.107.130.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzzNAxYpLC4uCMGy87dnqpdZ5QQBKDs2R45fPZPWFCQPJ2HUSWnKlxOrbSFkQzXcSVlJcE4r8BduKV+bkKM6P7UGrOMIaavWJzAsvdTM1swaMmyMutJDb0DVAkIv7pCDKxmI8sH+gR2k5fwTIPbmmZE1onl4OlBJdlNReVJoW9vcmjEw8os02hrRvaAR6VqjHs+BFADc1MG42c0Z7Fpf1JmQQBQSaDd1Uw+UhdYgl2ERh+XzKpQqC0RFubO1zBsQHvn/5vycOZTYdeSCw75k40N6JkJthbx+bPQmcw4voNZ+5lCZaYJ7ZvTGLYjNI+Z+e4G83Z7Twy32mdyOg6+dcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6x0Gl1wguVfXFT9ai5ZglJdGvhkhWY+ibaX58fdcBhQ=;
 b=qda8ovFjwlNAEO7NlULuLiULnd6O/USUxPQ4jZwqR0XgjcFtL9tlFh5BcGZilAUC5NwIwPGLOHnvDsUY3ZoIVq7wR3XMTXwUsst9K9jEO/VmMXHvNDjBq1VxoCj/aKeZLOr+hQyjhqg7Kl39NroJYcdorQ97GXDV6oxDYJ9x23MtwL7ORmRF29HnTLjMPZvuRODAnf0djezSfxxLMdfgqH10qDOUJvlF0r+pTJ5lCWaA+fgBIY6D2OfSBtuzPSLuqVZ6bUWLxecQQRahSGiEqCLTCYYyfiR6TatiI4KpIU0uxxKqUtbPvwYytC6vyfPel5DbNEDsAbUhDKuFUf1kNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x0Gl1wguVfXFT9ai5ZglJdGvhkhWY+ibaX58fdcBhQ=;
 b=C+P83YxEknyVAQzqnig3cvcXMTt97R6sYNLNkwuTC3qYRdFJaUyJ173D60aGXGeXRibMdQ5U2Fu4q3oGsj2E9u2BcQ/eo3TZ0E3hVbfXyqBf9OFhtu3pzWwQR6HXOYKlXQI/iWee/ZcJteAPbkFQBy3b+ZmFMGvDehTIGX4M2EiozrFD52iWiNJdbDKlvFkaD4m48Mpu0yOIkaHNZLRcjDZ9rAGKCkvTLX5SMa9t/20uJc/ma2m7YTQ5jYtYZ7T0W+Q6XNL1g2cfilBfVA53jxKL2EUElSNrTR8esN29+ezRX98XZ3v9brITYxxr7WBU4cWZG2LI6S3fOdycQruPRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8105.eurprd04.prod.outlook.com (2603:10a6:10:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 21:07:02 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 21:07:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 Oct 2025 17:06:37 -0400
Subject: [PATCH v2 3/9] ARM: dts: imx: remove redundant linux,phandle
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-imx6_dts_clean_2-v2-3-3c12ead5094c@nxp.com>
References: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
In-Reply-To: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760994408; l=1726;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kp+D5c4fcdfwelfvU50juvcloK0a6nkna7wbA0g3tW0=;
 b=F0ZlXnn/C8tkAtJIKq4z+T+WCLbZsgNPif23ugAjz9muDA2ECNVQrNbVcjHX0/vkoMWZ2i3Ca
 9StxGU+sYsXC/stMO1KLdnhuu79HboEkS0FWhn/Iy2qI1YdDjPDzifr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:510:323::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: f153a583-c553-45f8-1569-08de101c9d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enhSOGwvcSs0VjFoQ0sxdzQzVVZEWkdkVU5WQ2daMWZYdGRKNlpOU1A0Qlhm?=
 =?utf-8?B?aVpnVE1aSEU0TTkybjhWTnh1cnBZQndFWWVybVhRMXQ5dHFxN0I4YjEwd09w?=
 =?utf-8?B?b3VNTzN4bkM4dEdTazUrK0ptTEhUTGlEZS85QnRVYVMrSEowaW5CcCthTFND?=
 =?utf-8?B?aHNTcmt0UlFUb1JjYUk0YllXekN3cUhEaVVyVW9DZFVYTkZZTlNiVE9ocXdV?=
 =?utf-8?B?cTVOZFhCc21pQVJBWDNvLzhjL3ZXSjZWZzFGMHI2YVNGbkd4NU5DdkpiWmpN?=
 =?utf-8?B?MWZDTXd0Lzd2aFYrK096OGxtVUdzMFQxNzA3aGI3REpuc1Jvalh3SWNCU0hK?=
 =?utf-8?B?R04zZngydGZuUG40aVY2Z1YvaVNlVTlsL3pzcU91UEZ2YjhnbTloUzdYd3d4?=
 =?utf-8?B?SC93bms4R01yU2RCb0MyaTArcUtSZkZoUmpCVjB4R1M2NzY1NFY2a1ROWTdo?=
 =?utf-8?B?T093YlVLckFSeE8vTzJ5Mk1vMUZERERJT21GSGtoWXVrS3paS05SNXFLRjdU?=
 =?utf-8?B?aVpBVlNxWFBHY1hVT2JlN1NaZ1lKZ3pVaGluUXE5QXhPcUg3Q0hKc0lzMjZS?=
 =?utf-8?B?dmVEVkZicWFMNWU2aElMcVZIWWk5QzM4NE4wUlhQVzU4YzRGWitqMFlpb2tj?=
 =?utf-8?B?dE9HTnNlTG9ya05Cd1pCUTdud2xLblRBWFRCV25uaWdGcXFHMFVRd3VGajMx?=
 =?utf-8?B?S2VwUmMzbkN0L2dPYVVNdkhvREcyNmVRWHlIcStRWW1uNDFmSXBRckNMTmhY?=
 =?utf-8?B?QUpMd1hSK0FNT3N0TWdhaUZlRjJpNHVuRGhsOGYzNkx3QUM0RUl5QkhZRWQ5?=
 =?utf-8?B?T2Z4ZDdLZkhNVjRlMHJsRHh2eTR5NmNMWHlQaVI4TEFzaDNkdFVGV0Q4V2g1?=
 =?utf-8?B?NEd5eVhYYkVMWS80b3BDZnIzaHJvb01DQ1N1a0FsN3pVMVRRMzY2b1pITllY?=
 =?utf-8?B?dnV4YmNJUFlLcXFkd3BNdGJqN3RQeWJNRmpXRGZTeXB3VnEyUmhDQVBGa2xG?=
 =?utf-8?B?WUVnY1ZhWmVVbGRsWE0ydVFNSlkzK2xFbG1FUDRCVnBMbWtGM3d0UFY0Vkl0?=
 =?utf-8?B?Q2hCYmVzQ3FORjdyOGdOMGtlVU55L3RObGFtdlhMNTEvUVJBOXhhK0V2SFRp?=
 =?utf-8?B?a1B6dE50WFI3Q0t5eEhlb3ZOSENueE9sK2VhQS8xd3ZjOGFsMGlPYUwxR3Zo?=
 =?utf-8?B?b1RRMmZzUXBwMlVOb09NbkloWFRSQlJyNEhjWjBFelhrMzdVV05FVEtYSlVV?=
 =?utf-8?B?M3o3aGU3cFdQNFZPUUxQaGpySEd2R0t2QU1EZ2VwSDJUNzdNaFBLYkIzNFBQ?=
 =?utf-8?B?WGFxRzFmdDVaa1Q2aWRjclFWZmhKcllIS3Zwd0NkVStVdmVqaDRORmNjSWV5?=
 =?utf-8?B?b1JHWnp2M2YxNll0cEZKejlzdDlJRkROaFJpZVBkeEdUUHNEenVkZCsvYnVk?=
 =?utf-8?B?SGNNNHg2NFJzTnVkY3lNSDUzdnhtcEc4ZDRQYUxsVzRDa1ozLzZCZENzbUts?=
 =?utf-8?B?QzhkTlZvNFE3dkZkUlNIV2p5c21XZUdyRkhsbmNiZFhiYVRCNUpMczJNd3lQ?=
 =?utf-8?B?bER6S0RYa2dnSHhwZkVaMnpnUUtjdVlSbjlyS2N6YmRqRkhialJkVHJiUlBD?=
 =?utf-8?B?dThqZ1lqKy9FNUhjUStkZmhKMU1WV3kyTk16YzV0S1Z4OTVLVFE0eW9mN1JF?=
 =?utf-8?B?dzY5UUNkSHF3amwwYmUxWXNOK3V0NFFEa2EwcjhkOEJPWmxxNkd2Y3d0Yk1k?=
 =?utf-8?B?YkErb1NIZjQvc3UyZlREUURqaU9EY1BldS81VW9ROStybGtlYTlmek0weEFX?=
 =?utf-8?B?SnZoTVVsdXBUdVJjR0xPa2I5SjhoeDVYNUtkUlpWTUlIclhYQjBwU0crSzZh?=
 =?utf-8?B?dHcrY056ajdmT3VtdUd6T0Y5cW04Y3h0bW5IMWdwbDBrQklZekhjaC80dUZI?=
 =?utf-8?B?dHVoYlVjbzJacmd1M2RtbmdvUjJUaGRJVDFzUHpPWHkzRGhweGRmRFBpemNz?=
 =?utf-8?B?V3BaY3FEa3p5MEpmRGJGZ3Voc3BEb1Viekg1K2dqOC91a05SZ2M1Qm4rMTNY?=
 =?utf-8?Q?TUGos4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWVCV1RaMUlOQVVkZTZuTWpsb1lycXc5STNNYWp6V3VVUmY5VGdUOVdPM3VE?=
 =?utf-8?B?cjBMcUc5bmI4T3NyZEsycE5XL0dsNmdPSWlqQm15WUMwdnJYamJOK2hDdFV6?=
 =?utf-8?B?ZW9MdDIxTHI1SlFkME1QMTRlWEtjS1R4SVFWcEZwTnRZZDUvVCtSQVk0OU13?=
 =?utf-8?B?TXpINmVIWm5jQlMwTTN3bHlKWE0ya28xN1l4T1A0aTZUVGxEZ0MvTWVXUTZs?=
 =?utf-8?B?aFVTbG1QcFlidDRwUmNyZkl0Nk56UWFaMXpGRmxnMGp1S1VMNkI4TGZEL3lz?=
 =?utf-8?B?ZitsZGIzam1ocHlSK25mTVd5TUVscnN0Mk5yM3pWWjY2QnpMMHJmMFp0ZVVT?=
 =?utf-8?B?d1dJY2hvNFdvNjdXUjJ5Y0duaWFVb3U5V1VKakpRQXZaNGJ5dGNkelpnSytO?=
 =?utf-8?B?VVB4ck1HZG5JSlFVaTBjUWtkcmdwSmtLNDRySzBhaDBEL2VGai9XbHRXK0tY?=
 =?utf-8?B?MUVxcUJPdHRZa0lqV1h2QzRrNTE2bjVaUDFQN1pUVDRxYm5PSzhtUWNnZnFl?=
 =?utf-8?B?RlI0elhKcFMrSkpIRGcwR1NSdGZFQi9ySnVqaERCNlh1bTdzVWNVVnEvU3ky?=
 =?utf-8?B?akxESmx6WW54dUlvZDkxaEdtb21KOHdwOEpmMDlrcTZIcDJuN2d3WFViK2E0?=
 =?utf-8?B?SFBOeml6aFhVK2FpVnlubmZpY3YwVnhZRjJTcU5oSUtiVlFtc3U0SVBSQXJm?=
 =?utf-8?B?WGtGVHVuSHJCbnd1bWZOVzVrdVVTUXZMR3lWVDFJcGRDUlNWS21PUmFOelFz?=
 =?utf-8?B?L21LL3ZQSmVyVTFXSGdlN0N2bFBTdGRKcXl5Y04rWG9GdXBoK0xhMHdNUDFt?=
 =?utf-8?B?UHM2V2dJRC9yYUNhNUdKQzNmdnJ5Vmdib0ZyRjNlZ3NIQVVXRUlIaTBIRGlt?=
 =?utf-8?B?RTVTMUFWTy9RMS9GWkpyNFQxNURuV1NYOU9QTlhxcUJ6cEdXb3VEK09kRjNW?=
 =?utf-8?B?azdlU2dOejlueHVrdFljVHZrakxlQUlXTjhIclFTVm5kVTRuNXVwaXJUSjdl?=
 =?utf-8?B?OXpxbHdMbnhjWDFXanRRTUNpczRXMmF1czVYKzNvMVJhQzRDRkVoa3JiaUFz?=
 =?utf-8?B?a21zeGZvM0VyeTV5RjIyQnA1Y256ZmhQMXF3L1NPbWJsTE9VM2lwNGVhTTFN?=
 =?utf-8?B?c0tuK2I1UzRnRkVFeXFxSk85OTZmMkNsbkhaUVpVQXJvMmlISHNkQzhyeUxy?=
 =?utf-8?B?UHdrZ0RxY1NXZURWUjAxdVcwSHpIZkZ1dTRNS3VBK1RhNFV2bU1KUjJYQmcy?=
 =?utf-8?B?ZjZVNU9leEQxVUFweHI3UkNJR0gzUmpZMDlJbXJzVHh0a0hpL3QwWkRzTUJV?=
 =?utf-8?B?Wjg4SW43Y1JyYmZFRDFCa3FySWdVUHZvL3h0bk1YZGxlTnFPUjV1UjdJS1pr?=
 =?utf-8?B?cVVkd2l3cjA4T2NpaDhINlMyREFzNzY3c1JCZVV1aEZ6MkZJMng0RGpuNzM0?=
 =?utf-8?B?ZU9UQjIzaEtHYkFGM1Vxa0YvK2trY1hybmE3T2dvSnBoYllTcVA1SzVUR2cr?=
 =?utf-8?B?RUJYVTRFc3JaYnVDL0ZyZ2YvMXB3ei9TeSswRms0MElRemtxYVRHWXNCeFRL?=
 =?utf-8?B?eE9pVDZnQlREMEwwa0h6RW5ycjMvd3ZWYitjZzNnMVNPQnpWQk5oNWdwWFll?=
 =?utf-8?B?TVQ2TWQyU2k4dEJsV3BhMFRtQUQ2OUN6d0NsMDByeGpEMXpSWHU5d1NaSERn?=
 =?utf-8?B?RHkvZzlkZytlWG5mV2VOeDZaSlVwMHRtbldYWGhFa2R2RGhmMzFkcVJ2V2Vu?=
 =?utf-8?B?bVlWbW5aYVo2RjZPclo5R0hPcVVJdThFNEpGaGhSVGJUQTJaeEVPRDlRQ1NI?=
 =?utf-8?B?clNJVE1GY2dHYTl4b1AvVUZFRHVqSnB1bUxMdW1GUVE5eWE3V29tUWNBSUlh?=
 =?utf-8?B?ZUZudVFrbHNDM0VoeXhsZkJsem9YQUxnRDFaZFNuVTJvSXg0ajhqVStXVGNB?=
 =?utf-8?B?RzZDQTE3WlBaTzQyTU81aFJBTVhZSzhqam9FVm90VG5sU3Z0dXV0YTZEc2lZ?=
 =?utf-8?B?WEs5TjBodWRzQXV0dGsxdzlXRE1DYXNBWThsQUF2SXJNdzZrRjZ3cFViZjk3?=
 =?utf-8?B?bHlVTi84SnZuSDhVeXpaS0g0VVVlQ3c3MWFGQktVY01PR0tZcTgxYTBOWit4?=
 =?utf-8?Q?ObVQKgp4HyXn5kRDVJf2N2cGV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f153a583-c553-45f8-1569-08de101c9d62
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 21:07:02.0820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iwwu0YayWmP4s+QtQ2gx49qhug7bIOwg6nYhMY7edjzSJ7mdoUhpsWB45SGRVVEtTepXsDff9cjNpoHpSNkhxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8105

Remove redundant linux,phandle to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6dl-gw560x.dtb: pmic@3c (lltc,ltc3676): regulators:sw3: Unevaluated properties are not allowed ('linux,phandle' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi | 1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
index ea92b2b5c50d93b2e3a03d3a6f8d7526bb8e6785..e9d5bbb43145f8260873b60164e713cd1012cb9a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
@@ -462,7 +462,6 @@ reg_vdd_arm: sw3 {
 				regulator-ramp-delay = <7000>;
 				regulator-boot-on;
 				regulator-always-on;
-				linux,phandle = <&reg_vdd_arm>;
 			};
 
 			/* VDD_1P8 (1+R1/R2 = 2.505): GPS/VideoIn/ENET-PHY */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
index b518bcb6b7a99673de2a7eb49e2a34b75d41fb29..01f77142e153b2775050de4d792c37a8ccc47cf2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
@@ -360,7 +360,6 @@ reg_vdd_arm: sw3 {
 				regulator-ramp-delay = <7000>;
 				regulator-boot-on;
 				regulator-always-on;
-				linux,phandle = <&reg_vdd_arm>;
 			};
 
 			/* VDD_SOC (1+R1/R2 = 1.635) */
@@ -372,7 +371,6 @@ reg_vdd_soc: sw4 {
 				regulator-ramp-delay = <7000>;
 				regulator-boot-on;
 				regulator-always-on;
-				linux,phandle = <&reg_vdd_soc>;
 			};
 
 			/* VDD_1P0 (1+R1/R2 = 1.38): */

-- 
2.34.1


