Return-Path: <linux-kernel+bounces-861780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E226BF3A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE2718C4855
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F9331A6A;
	Mon, 20 Oct 2025 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X5xcXhI9"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531332C316;
	Mon, 20 Oct 2025 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994433; cv=fail; b=Wd14Wf0GtrxK7G23dX+HWoIQpjs8ABIFkX08Pvl5/Tr6dMpoB5i2TT9ffb8yL0TcX6y94cnTg+8Hu9imphKvc0YRski2DOa7uUHWqNA5orag16dH3lafy43UpHa+5vA9ZlMvsff6CZSTOUPWNlFfOqyQ0r8ueUueIS98W5KEgeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994433; c=relaxed/simple;
	bh=4RnVBqZnX6urwIa7PpmAMq+hsU0mF32MABSVMzPNeqc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lhKZbtviiqu5PhO+pOOfUpLGze8TNoegQcZHrWtOwER83kcd/FJHmmtKtvoxZMu5tOgL4fTlrufbYeTIda/Ta1iYtAuZcBxxZJcsH08VKVeaeGphUITMLZREsxbDAnUHZ29TpcKoepLXKMUm9C+Npn/FaG1S2Cwfiyzcvr/udjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X5xcXhI9; arc=fail smtp.client-ip=40.107.130.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxrX/5Klfk5utITVTEQpAu3GhIV25j78pPzpqI5zguNeHYOpKfdplCGjOrIFdfsJFUJ7w9AF5IFfROrhq29PMBx3ocHV9wUC1gjDmlnmIDUPMso3Mh7eieSyE4+t4iYeiKiplTHyvSA1M3nKgKgKXJsvIitS75+lcmsNrkkQp4A1+PMfXi1SZ6XG3pqqMbCe8Ob6TTV+Sr2WuISzH0DoNogajPga2m2BwnMkdksJGo9ppPYvFeL+WgQKxvmHq8QwNZ+BSe0FxfuRcKfAwCKpOdssj4SqhCf+WLWrflrHFvgtBbXDcQuDMWaq3gvkRpwLKvu6drEXDNNcg7Nia4rI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65PL8znCqn2YAFcoxdCGvLCqX8bQAPj1Ar3QOIouQxg=;
 b=lH21eFf4n86LENV0idnTCAG6xEwZ/z5ixcUDVk9T5HF8ekvNGFdogiPoiA+3HeIta0aienOK/KuVZ1NrBlXj37bOqRD8Rwb6XJyh0Xc5AI6tr4miQFfyzH9SvOjP9wz5NptRoEUkYFoie1MPZPeBbEPVsG4qAr+eYoznsE6D71MemKWDEalBzqw5daar+s5Bo5VD0FJyBQZHXlHYyOB3/JS7MNbkYE/TvTqS0QdJGDFrpMBEjJ/5980wdqPh4MMqQ0pZTJNl47jWVxKhBhmsYJUWri2MC0vX9wKdz2/SsaOP4A+anyB3OtG4d/pGZhCWBvLshomjo2FOkee8v8aQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65PL8znCqn2YAFcoxdCGvLCqX8bQAPj1Ar3QOIouQxg=;
 b=X5xcXhI9oO2Jofh6FQ0ZIKIZTByQS2XhpzUVen+8ZtzO0wbzuxIs9/zw46IimZ/mosf9YMsoe7Qso1gleBPR0SSosqNzyyxQzyueXmw6JZc5V+Kus/4H7evNhofczg1rTps2p9D8UTWbOWnRYvgd/rYFTzxlasVqS2ej0lbocfVjN4bWvqlDvX5cBWh1XpVleginc00gZMafNJSXoTG8IHs1lREYGW4a18lg8iNfhUka/qW1y9WsFDYjgipVI8hFuc02iCxD7EHkROWMuBQloCdBeo1Zr7pkdqC0Gqjx3GWysW+Ke74z/CIwSHbwK0fE0CV8ucjEDDCJBIOXTK5j9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8105.eurprd04.prod.outlook.com (2603:10a6:10:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 21:07:09 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 21:07:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 Oct 2025 17:06:39 -0400
Subject: [PATCH v2 5/9] ARM: dts: imx6q-cm-fx6.dts: add supplies for wm8731
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-imx6_dts_clean_2-v2-5-3c12ead5094c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760994408; l=1936;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4RnVBqZnX6urwIa7PpmAMq+hsU0mF32MABSVMzPNeqc=;
 b=p1fpghMZ464zi9vXEUBzkOBpITUX+ixcfYQZ51pMkEn46LM+DfJQbwhr70feGuSH5KXL+shC2
 Mt7YvahLXF3AoFfVor7uEa0m5Zj0FVqv8Qa6onjtp++aQ9ajXyiGNuz
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
X-MS-Office365-Filtering-Correlation-Id: 25357d09-7166-4517-6497-08de101ca176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2xQbzlpVjVySHNNQTYyLzZqUlBiTkIvdzFLSlptL2JYZ3k2WnZPVWNmU3o3?=
 =?utf-8?B?U2dwZ3YyWXpzaEdXTStESEVHb2h4YzU2WFZMZWlDa2JSSkl3L3ZHT0grTi9m?=
 =?utf-8?B?UHM3YzROY2FOTmdKc0padzFmMGtxVWY5SjZHeHBBK044TFpqWXhpTC93Y1F2?=
 =?utf-8?B?aUVCT042b2x6Mm5UbnJaYjJGRUFDcklON2l3YnJ6anB0STJpa0FkNmFZMi9Q?=
 =?utf-8?B?TFRJNmtLMEpqb1I5N3M2Rkt4WEZSdHd6ODdydGVPdDN2S0lrZ2R0T0JGNXBJ?=
 =?utf-8?B?QzVUZURWeDRWNVY0dmdJZW1xdFBPM3pzNC9VV05LU1BrbGs4RXpFMVRCK3NO?=
 =?utf-8?B?WjBHNUdPcElkQndIeGJBbVJTVXZwQ0hHSTRvZW1VKzd6OEhnNXVVbFFzc1Bl?=
 =?utf-8?B?TFpyWHRTa1AwWDN5KytKMHpxb1dSMitwTVRNV3o3Z0tuQW9RcDZVYWNBU1hN?=
 =?utf-8?B?b3paRnlMWFZaamU1MG5VYmFlVjR4VGpXWGtzdDVaNDN1QUNVRWg0NUJFRTZz?=
 =?utf-8?B?WkJPZG9kSTdrNzFpZVlmUld3dVdCbHlKcjRZaklWU0FBa3k4L3VOZnFIdG9C?=
 =?utf-8?B?RUxWamdhaTNCcUVwdGszMkNUcS9PQUVwQU9TWDUvdDVVYVl1dHY5aXZrRVQ1?=
 =?utf-8?B?Tjhpa3BkRVlkRElPemUrT3c4dURrOTVQTEljTVR2SjArZE5CT1ZjQWNlWldx?=
 =?utf-8?B?OGJkNUJSRXk1NUx1Tjc0WWdZZWFBREszTExBZW01VjlyZjkwa1R5c0lvSHJW?=
 =?utf-8?B?NEJJMlNlOVFsN1dHdm1VU0UwWFZCaW5CQ2ZzMVZ4NHpneTVvTEIwZnJ1dTlX?=
 =?utf-8?B?VjBaNkZ3OStQSUNrSFBSc2RoZDZZRGpMd3hNeUVGdk43YXRWSVlIU0ZmY2lS?=
 =?utf-8?B?aldEd3RseGJWKzQzUWVSNG9hR0JLeGxCWjBLUTNudnA2aDB5enluZVNhRjIz?=
 =?utf-8?B?VDVmMmdFVytieGhOM081MmFOZ2xKU1pGbE9Qdm5aZ09zNEJIdHdZWHFZME82?=
 =?utf-8?B?dkVtbmM5UVMxa3ZpT3JrVmYyNFhsSTEwcEl4Q201VHdQVEJMTFlia05xWXps?=
 =?utf-8?B?UnljSkxyN2x4aTNBTVRtOTJuenVNT2xEcWdJQmZOVExDQ1FKMlA1RnVqbXZ1?=
 =?utf-8?B?TWNzV3o5UzhmZmhPaWhabC8vajBxYVpKZ0dDc1hqVEpEeHRXcVlsTFVpRG9X?=
 =?utf-8?B?OWVZMHhxbU1tMFUzL1owdVJEQnVzRFVuS2xaKzVsWUdYNHRVdmU3RC9QSVI4?=
 =?utf-8?B?dUQyWkxqM1RLL0YxWjBHTVdrMmh3cFVmWHJhcXdBcDVPTnE2ZjRxMWlSVEtw?=
 =?utf-8?B?STBNTmg4NzNrSXhoZnJvRmZSMFBOTzkvL1E3UUVwYWN2WWxKeFZsb0VSUTdt?=
 =?utf-8?B?emFGbGRocHRlTlJwK0Y3WGthRTNhaldZNUI5amNTa2FiT2ZMYzZKdytOTWYx?=
 =?utf-8?B?bWNJS0lRWTFaYVN5SGRZb0QwcnY1WHBZVm55MGJhS21VWkJLWmJYcENPSkFQ?=
 =?utf-8?B?bzJCL2pqb1h1bFhRRXFEdlRIWEM3SmZWQnc0eVBiQktUOFplcGZ0a0pwWWxI?=
 =?utf-8?B?K0pyZzROY2xCSkVsN0pYOEpjVkZHa2FFNmYweTRYZ0twdENVck9XSTRVR1V3?=
 =?utf-8?B?R0g3QTZGMDBkVXhGSy9ndW41OHM2NzFxVDAvZUZXOTFTdkorUU9sMWhQWjY5?=
 =?utf-8?B?c20yYmROdzN1aXR4WWpsdDJZSWIyNy85NXF6SjVaNjNnR21BOFZCcE50bFlz?=
 =?utf-8?B?RU5qUFNYcWhwVjZIcm5oaGhNcWpvUWpFclkwMXFuV2ZPZGw2OW5PM3Racm8y?=
 =?utf-8?B?YVdqdVZKcTg2cTYyV294Z3JONkFwb0h6b1k0ZGE1VDlYQzRCbnh0VzhBYmRD?=
 =?utf-8?B?dTl1NmxBSEdtdEkwVGNQYW13UkFEUmdOUFpMQkl5anRobElOUkpHMlBISXh6?=
 =?utf-8?B?VHdQVzV6aEtuSk91NzhxS2syQzVxMGVFZCsrcndnUGx1TllxRmRwQk9uQnNy?=
 =?utf-8?B?bjQxYWNhQWh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QURtdGdaMzNzN0VoSFpvYldnT3FwRnBid3dMRXl6MnhLZzErQjl1ZDhDN3Iw?=
 =?utf-8?B?b3ppZGl0d3VNeVlaTmN3OFhjZllEc0JlK3JIQTVSZVYrTUNzSUFUWktQdEVh?=
 =?utf-8?B?SmoramJrc1hkYzIzdlJGbS9ER29QVGhPMWU3clY1cjZ6RndLQ002ZmlLbE5J?=
 =?utf-8?B?K1hTcFhDN3pvZmpYQzJGTklYMWVMRitMZU5iNWQyVjdPQVB4RWFXZ0NISGtl?=
 =?utf-8?B?OXVSYWh4Ymd2Y1RQV3plZzlvUzRKUHZGZ0dmUzFJejNMUEhTcytOc0daYUxx?=
 =?utf-8?B?YUU5eDZGbDFRYVpzbllzbE9nWEwxdmpnQVZMekRVelNCMlBNV0dlNGtXd0M4?=
 =?utf-8?B?cE9sa3dkMkFJcEV1SDFEcUhqMG5jNVJlMVVsUEpTTk4yV2ZzL0hYNjE1Y1Bn?=
 =?utf-8?B?UGZTZVZTRjZzZnorQk81WkhxS01FNzNNQmxjZUlpTXNEaVAzWlhXY1FtVStM?=
 =?utf-8?B?T1VDcHZBR1dVRUpnUTN4RFJCV3BkNk9EcGZwSXMrNFM2N3VKRDlMak5teVBM?=
 =?utf-8?B?N0FCUE92cXcwSlNrTE5RZlNsaFNCNjlzZ3VMWU43UC9GeHV3LzJKK0NSMnlm?=
 =?utf-8?B?dXB3aGpYcklJMzZoRndLdHBVSUdMWXIzcVk2OTRpRldJcHJBRjBBTlY2Y0F2?=
 =?utf-8?B?QThXSHhKc2dCb3pLT092ZGlzVjJ5TkdhRVhVSUxJZE5nQTg1dEF2YVFIMU1M?=
 =?utf-8?B?VWU5Ymo5ZE84SWRBQU0yVDB0SnBzZTBaeHNrd0w1c2FzVVhHK3RsdlV1RCtM?=
 =?utf-8?B?SWlmeSs5eW9vbnNaaktLcW5aTy9FczlZNUFUQ1RZZHdiK0wydmE1R1hjUHNG?=
 =?utf-8?B?cW44RXVTeTZ0NklRUGtaZWdOSHBSTEpJSjZPbXVQbm5ycXcxcG41MEFKTklX?=
 =?utf-8?B?ZUJET2RneUwwRWlyaEo0a3JIVTlBNFlCTXlULzFjZHVlOVp2NUtSaHFseklK?=
 =?utf-8?B?QWRMR2liRWtwS29HVDhFZXhBN3hsejB5U0s1eUZBZkZ0M0trQmhxN2xxa0tT?=
 =?utf-8?B?ZG1mbElocVcrMFNnSG8zUnNYMkx6TFRKNDZHWUpqVmROS2J5eUg5MXNpWUpp?=
 =?utf-8?B?MnJqZVdQWXFzc2RSUlkrT2tGc3plWDBiajdpT3NETmtFWTNteXBnVjd1dVVh?=
 =?utf-8?B?U29sbzlVRGRJbUplRUZ4dHIybjVsZWVUMkxWUG9xL0Rtd3FuRTdJRkloY1lm?=
 =?utf-8?B?MEJDeWxOLzVkMDZZdW8wRHhnTUFFYTUzWjBoMTVGdHJIZlRjYWxPS2dnRzI0?=
 =?utf-8?B?SzFPQnJrUzBxTWpiNXRNbVRDMTNpdW11aDhSemhKa3JtbEhoT0dlNlloSE9Q?=
 =?utf-8?B?TjBiSVhkaGF6bWhzWGJFUEZRN2ZKeXY1N2dTbFAyWWltTjh6aFVmQ1k4N1RD?=
 =?utf-8?B?MjNpdXduN1EzaFVvRy9NU0dpdVkyQ0NWMVFyZ1ovZkRNVlpFR0ZhNTVsVGxF?=
 =?utf-8?B?SXlwTFp4SWIyd01MZXJrSURJVFFnTnNtakh1Slcra0FGSTNENStJWjJCR0x5?=
 =?utf-8?B?RnVUcUkxenZ2Z25Jb1dZRTZEdzBZdVBneElQWVpiL0ZkbTBqU3B2TjhUeFZk?=
 =?utf-8?B?WmRNSjYyWkpoQmhuek9PTGlHTnl2UWg4YzZBVEYwNEJFU1dvb1h2aCtxREVj?=
 =?utf-8?B?cGIyNk9ud2lHRzc4MlNrcC9sVFExWVplZkdsd1VFNGJxZFBvRjJDRWhpTjhL?=
 =?utf-8?B?Z1hwenBFV3hhcTNxM1QycVZNUTk2V1Z5eCtIcDJsNFNERXc1d2p6ZnNialJV?=
 =?utf-8?B?emUwdTFDM1QvMTB0MXdJYzlNaGRCa2QzZGpxOXVVTThQSkIwaDZoQ3hjUjFW?=
 =?utf-8?B?L3JITFVQVW1FaFQ2Szd0YmhMTTJJb0VMM3Q5ZDdjNGcvT09nbFc3T1pjM0Nz?=
 =?utf-8?B?YWpHeitCdkZWRS95aDk4aVdBM1dtaS9BUzJFK0pQek5iNldXN0QyTTBnMk43?=
 =?utf-8?B?WnJ2SVRwSlE2K3ZTZUJkcDFhajlhdUw5RkdEQi9FZUdsKzlVNjJMQUJydFdw?=
 =?utf-8?B?MEJLZXdPSy9NeTN6YnZpbVNJR3lKRXljVkduMVZyMzBMQndyTDJOUFdrdXo2?=
 =?utf-8?B?eDNDS1RDUkF5SjlGekl4MU9MamFIMWZWeWhQNDVpd0toQlFpb0U0Nk1KTmVP?=
 =?utf-8?Q?DRYnQa5inthsGjq7Mb+gJiUKe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25357d09-7166-4517-6497-08de101ca176
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 21:07:08.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yZBPPcbbyajCYMcdlukJo9X8MmI6YyKkVlzD5sLR0XpRo3dVkcaPQt+onvgznTQx3UnexeYULlDYOrKcapnMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8105

Add supplies for wm8731 to fix below CHECK_DTB warnings:
arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dtb: codec@1a (wlf,wm8731): 'AVDD-supply' is a required property
        from schema $id: http://devicetree.org/schemas/sound/wlf,wm8731.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
index 299106fbe51c4ac1e9e0a70a4ec12e16b8110497..1dc5cb41f260843dd1239f49e513891c23ce4121 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
@@ -99,6 +99,34 @@ reg_usb_otg_vbus: usb_otg_vbus {
 		enable-active-high;
 	};
 
+	avdd_reg: regulator-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	hpvdd_reg: regulator-hpvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "hpvdd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	dcvdd_reg: regulator-dcvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "dcvdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	dbvdd_reg: regulator-dbvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "dbvdd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	sound-analog {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "On-board analog audio";
@@ -307,6 +335,10 @@ wm8731: codec@1a {
 		#sound-dai-cells = <0>;
 		compatible = "wlf,wm8731";
 		reg = <0x1a>;
+		AVDD-supply = <&avdd_reg>;
+		HPVDD-supply = <&hpvdd_reg>;
+		DCVDD-supply = <&dcvdd_reg>;
+		DBVDD-supply = <&dbvdd_reg>;
 	};
 };
 

-- 
2.34.1


