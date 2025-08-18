Return-Path: <linux-kernel+bounces-774476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A543B2B2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644B86287AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4C2212F98;
	Mon, 18 Aug 2025 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vnlh6poQ"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE426A0C6;
	Mon, 18 Aug 2025 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550119; cv=fail; b=JT/U+I6J8p4Z7L+lbVc/+Fq+je59qe8Qils7lhpr0vtHDvHW+zm7sbtIN8oNguAL0uWIDijpEGoPbFSpNqEO5OqDdMQqIIDVIr/WIqEEu4Rp44ix/Qk+62v5Sg/Zeji39XObe7Mmgz6SpVygCWalZD+pDei4pkEQqfj2G6GXWfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550119; c=relaxed/simple;
	bh=k8eqBWBfOEyH+xBZseIjIV1sDjfWJut2RLpKfUdw540=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=k87SxTIYK4vTnMKN0eqX003W3QByBIs3c9kkIjLIRk2e2rLP83daoX8sONovzmmrSaUFEHmTfSpjt6NNeRCvwTstDj4CA+68dQMyZoEzVg1I8UwFtcjAo+yjnanOO36gJUjKBGhHdAehO5DgBwJp4l82A9Tsx9yYZocf2jSxvpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vnlh6poQ; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJypIegSLJx01V/WaOlrzrunZCZhAB8EtLu3GpEqEUoP2edqbGIjy7kB00DPSmSD3214ozWMcguPO7uSu7Q2BxhbPFTahEgrq8kEiUaUXC9DMl1R9UDD/euSG82lzmtHx4WvGKG0TfJPjhcl6pVv/UmMaEVnSvr4J/MX9PuKrkYsUjJJUyIT4abY2tNbXvn3sDGAmVERdxZ4FrPGPNTeted98Og8lP6ZElPMGOclTvoYwN/gul2YO5SyfZDFUr2K8MJfaZsQcUSn0Q5mOsTQNjXPw8LOTiZzEdQLhcJ08ysX5kAOGwrNVAkZhTM9wpinJ/ThLmBkEamP3rIqNxt21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4AwOwBkIM+I9Y0G2nEANlns50TSD/u531paxy9gCnk=;
 b=Sq1ww/m6L5lBn0h6hbL1pQbedEPtssE/eLFW8/2VuDL8Bvuj+T1eKLjZr1vGaTqA6aAOjhRb8cCLjnPfaKf1i2bPxhkf3CN1CGH9nEEqjk4B6+c5XSC2fjJf8KQ1ETGD8qSFruOI4A47I3kuVf3RTo3stGYUT96Ts+bcACBw5iUNaX8hry8ELZOtGeps34lQ7p8giaJOiCSDacdnzlP2ILd2Raqx60a5jM57SFRsI3tpk0uIXyA31liImFjJ5RnaER0krHjyq2srCj/TVBmooXicTBtHWPFjMKRHlM2csnscuhZp53KqMbee5l5fUvFVbl4IpY4WEeIo2ZsC2mNHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4AwOwBkIM+I9Y0G2nEANlns50TSD/u531paxy9gCnk=;
 b=Vnlh6poQOx6EcvFgfmjzb9J5MnMsJfVw9Or5M22/PVdHqoy8HbMG08QPj/YhxLweM5/kol3zThDBFddfjvOk4cMSQe9cPEqtXf3J7IMWtC2/vHWF3Y+Dn/bOutlrzckQC8VxA6kJuyH4+EgLdTeBlFO3qjncCszoBqfLZDGEDkjuA3TicF1esacOEdQw6BpgFXJJhxJlsWS7WmMIJI2V/YtD/ssffniB+AWq9vX3odnoMG67WunTklF0rA55qU5P/8zC0Q+nkuv6UyMPKsz3+KjIbnLNstJN8KI1DoXKnR/TXFmCqp7g0RDU36/8ZB/ZH7Zm/x1CBdja0WTzo1M+cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Aug 2025 16:48:14 -0400
Subject: [PATCH 03/15] ARM: dts: ls1021a: remove redundant
 snps,host-vbus-glitches
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ls1021a_dts_warning-v1-3-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=810;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=k8eqBWBfOEyH+xBZseIjIV1sDjfWJut2RLpKfUdw540=;
 b=jsnv+MuxwLTk5SfCYhMXxFF2pwrF8aoh5EO5205097JgVtBjcPWklXzYoMb2nz4E5oxXoH8Vm
 A5RzOqYcoGDAilfkpZOau5y3h0QzQZFAkbfHn+76Ryyp3EF4M+hieRI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: bc81a8b1-c0ef-45c7-13bb-08ddde9898dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDF3NTM3MlkwM1lmaXBEL0RZVEFrMVNtYVkvVHM1dnBISE5RMlA0L2VWZ0dn?=
 =?utf-8?B?QnV0OFpxdDNpc0tnSU1uM0dqb09yWEE0S0FNL2dDRHU3MHBNSHVucnJXczEv?=
 =?utf-8?B?NjNvLzYwaFk5M25OWFZFdEN2blNOOTQ4bHZlelZSVThLMk5MQnpHNXMzVjBm?=
 =?utf-8?B?Vit2QWRvNk9BeTl6WDl3ajhrWWw3a0hxak5NakVYSUM4ZWViMjNaaGlCUEhM?=
 =?utf-8?B?Q2o5dzNXNHU3dlZCNzlXRXJSaGZCd0R5WnhJVEdHM3AwNnFRRWowWFhpQStM?=
 =?utf-8?B?STBoaTNYcHVDV2pSejE5MCtBTWMwRElwQXozYjlEY2MxVUdjVjlMeUlEYUM4?=
 =?utf-8?B?SlBlUGFob2F4anIwMyszc1B3QmQ1Yno5NGJ3Z0xsSHJEZGRaYUlGN3FTQmp5?=
 =?utf-8?B?NTdZTSt3NjIyajdlTW5VWmQ1dlpneVZGT2wyVTJyWHMzUHBNRlJkLzlwVGxy?=
 =?utf-8?B?S0sxVVpyY3FKZ3JlQnBtQlcxSEhXaGxoQ29XOEhyWG5lU2cxZWhEQVU5M2hm?=
 =?utf-8?B?VDRWWU9hZi9QaXpKaS9LYldBTGNJYUN4QXJnd1Z1R2VybE1pR1g1enZzOTht?=
 =?utf-8?B?Rk5vbVd1aisvN3ZlU1B2K09oTGV4cUczZ0t4RGZXbE5WRk5YemlZcHZlbHdq?=
 =?utf-8?B?NlY3V2hsRXd2c3cvSWhDOHlkS1BFSDBlTTFZREpwcTlXRDVEVS9Jb2Zxc0Zr?=
 =?utf-8?B?VE1OR0JhNmhEbmMxNjgzWDdVaFYxK0lGNEhWcGpyWFVQaDZWUUFYd3p2WFFq?=
 =?utf-8?B?VlpuL294L2RyODF5MUlyVU0xbnJzcVhGc2xMNXAzQmo2M2R6WEIyQi9FdDVj?=
 =?utf-8?B?Y2tJZjFmenhYeFJpT1RzNWsrUENISVVMemd5T1NJMDBUNUsybVJiRG5taTNM?=
 =?utf-8?B?UEpzWnkwQ3hiNTdzVHMxRmk1MkNZcHdRMm5QRUJnMGJ2anJjbmg0L29UTUZw?=
 =?utf-8?B?OHd4dFA2RXR4VzNNUWZCN0t2UnAvTURvZEFqRWl1UXQycDljUm1lQ0JoY0NL?=
 =?utf-8?B?cEl6WEg5ZVB0T3hscWQwNjlBWW5ZRWRTZkxBRzlJenJBK09rUGxyRWdYUHBP?=
 =?utf-8?B?YTduS0pYTmcxOWZyUDMyMzcwMER6SjhnVkg1RUQvRWo3Vkc1b05MeUVWUVAr?=
 =?utf-8?B?czNXMmxYVFVrcjRlVzRjUGVvOHlhN2ZhR25ISk9MNFBiaXVCeFJ0N2Z1bzNL?=
 =?utf-8?B?L1ZxOE1SZ3FENjZKUnpxZFRoUTZtaXJaOXAyOGM1U3FadVVLSzVGTGIrRUh0?=
 =?utf-8?B?dTM0TmkyMG1YeDhLS3IwaEFPWTVkS1RGaU9MRkozZ1U2cE4zck03K3Uxc21N?=
 =?utf-8?B?ZU90aHBmWnJvaXNHNU5BeUhsMHhPK2YyYi9TRXF6UHQwdUtVSEZyTEk1NjhP?=
 =?utf-8?B?dWJaSUdsTUdaUHpnVlhCN2pTL3hzUG5wZXA4K1gyNTF2ZGRjTUhqV1l2a1Rq?=
 =?utf-8?B?UHJScWFoaHpTQTBzTFliQ0FyUW9oN2YyK3J3cFNUWk1yUGszK1NDQjN4dUhN?=
 =?utf-8?B?Zi9Bbk1yQSt1RFVyTHFwNmczQXpFQ3Rja3lYelNXZGJZdWg2TTlid1V2T2kv?=
 =?utf-8?B?OHl4d3k5bm5uYUhGOUlOVEJsYWZmQ0p6SnpRUWlHbmlQVXd1UHlCU2NSK3A5?=
 =?utf-8?B?ZWhuUW95RHJPa2VPYk5Md09UNEdXRmdoTjM3MHNjYWdjaTRGYk9CbkcvenNk?=
 =?utf-8?B?ZDRsRG9rR2lHWVFDaTZMQ29WaWg2eXVPektDZ0FjV0VOTDZHZjhaV1VSWHI3?=
 =?utf-8?B?SysraDFRdGFrTS9VdktQNHZlVys5YTI4ZCs5Rkc4bGl1ZTZpUWFUVVY3Zkh4?=
 =?utf-8?B?U0UwalpsTFg5WDcweVp4WVU5em9ZdkJuZVQwRGYyOXNMMHR1VzhQVXRQY3hB?=
 =?utf-8?B?Y0FJTlFBWCs1M21rdkJXbk9DWnRTZjVqcnpzRUpqQjI1d0hZNXR6bHA2VGFB?=
 =?utf-8?B?VWdXOHRKTFNkTWE1ODFzYnhaMGFPb1Z6SEZjelVsb09aWGs3eDN1b3AxS0Rn?=
 =?utf-8?B?NDNOalEvTFBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnVhOVk4TlpDRHZRS2p6OFpwUUhSbXoxOVhSVEkvUEt3TFhxT2EvQVpaK01S?=
 =?utf-8?B?T01LK2k5K0w4U1Rad2svNDQwdldDRzQ3MmR5NnN2emtjVUlaQ01qZVRXdTFt?=
 =?utf-8?B?K01JTThlQ2xTR1RyTkNRV0xZYllIc3RTdTlObFZoUnR0VHRBc1A0WEw0UDNM?=
 =?utf-8?B?V0tMQnd1ZXFnRVRSKzRpbGRYTEZvb1lRV3pDemh4bUw0UGx0VWZUUFhFaXhR?=
 =?utf-8?B?c282UzFCOEZ2MkFBWUkyWEVGSEpPYmdVWWlYM0VreVRVdy9WTUxhUTdCZUhl?=
 =?utf-8?B?TDVZK3NJbS9tcXB2MWxjT0pDUWFiOURyMGk3QkhsZE4zZm1sQldGOTNjOERn?=
 =?utf-8?B?WEQ2VG1oWHc3d1hoOW0yNm1EMEJ0dktjdExaU1BwanNCYWF2MzdJVitXUlYw?=
 =?utf-8?B?RUU4VVFrOEtrQXE3c1V2Y3YzQVMrUkpTdDZZYkYzeGJPVXA3WTAwcE05bENH?=
 =?utf-8?B?MytueHFOTjY0UFNZTHEzU1RtN1NLOXdEbHlDMy9CdFpOdFI0ZGNNM2VKc3l1?=
 =?utf-8?B?SWFVWHJWY0IyZmVJdGN3eldsUDUvQjRTcmgzYzNHQ0RVVitqdGE5NVNZbWt0?=
 =?utf-8?B?VWJsWkNjYXVFaXl5TkRTK3VaMXlWM0pDMFJqV1RCQ21jTkVqdUdXdHU5TWY4?=
 =?utf-8?B?Nit5eTlWdjZFVUdDVzQ3TnVVLzRuYzdZMkZzODk2bnpDR2w3TDZmdGt4Nk42?=
 =?utf-8?B?enVjMU15WHhTeVNkNVdVS1hqNndSZklFUEswZlZHTGRxc3o2OGpValYzOVMv?=
 =?utf-8?B?cGpWNUc5RzI2NzdFcUJsWHZxNHNpOTQvNlBzUzZKbHpPL09NcDBsbkZoNXdV?=
 =?utf-8?B?ek14UnJraFE3YUp1bUNIK1gwbXJRK2hUMDNTdkRLQm5NTjVPTkEybEZ6blJS?=
 =?utf-8?B?dk1uNDZmVWpTcjlvOG9MZnAzSmsyN2MybkhScHVQQm84M3llYUdmbnNZSER6?=
 =?utf-8?B?YWppZmlQamR6R2lpQWRGcnZicmk2aS9jdThGc2RuNDFMaG9LdmMwZ0FSYVl4?=
 =?utf-8?B?aENTVHl6U0U5aktjUmFjSG9MenNTYWliQTVLWUpyeEd5SU9BUUg5cmk2TlVv?=
 =?utf-8?B?TCszVklyRlhXNzlaa0tvSWl2eFlUMmdjb2MvcHpHMWNkT0x3V215WWY2Sktv?=
 =?utf-8?B?UHgvSHVXT0hJbUJGNzExOTVUZzhKNGszUllzRUlYVVBDN2xIbmtYUDBwaVpR?=
 =?utf-8?B?QVNKZlJMYkFsUmdnVHMxVzhlbW1ORVRycHNRUVUvcDFtdmRoSkwwR1VEMDAw?=
 =?utf-8?B?Y0Z5TVBmSnZvVWRSdmxsWVRCcEVTM0ovakJ0dU92L01ScHE5UUd0TVdRdFlV?=
 =?utf-8?B?WjE4c1lSRVlUZDR5NFFRWkowTnBySjZDeHRlOEVYUWZ1U25rcFlpYWs2NEQz?=
 =?utf-8?B?S1I1MGtySVNjQlNyb2traVJuSk0vckdzZmVNQ3BJczNvd3JnQXZXRVRDRUlF?=
 =?utf-8?B?WStNK3E2S3l6L2ZWS0NRWXJONEpTSm5kbzlqcmlOVCt5ajVJVDNHTWp5Ykcw?=
 =?utf-8?B?bENJTzVHeVRkdjZkdVN4cU95VUlMY3hpeU5NK3hGaEtTNTVhQnBDTzVzcVk3?=
 =?utf-8?B?VE5qbzlqNVZSUG5zZS81ekwzczJlRjA2ekU0djZRa3U2MHhtREhsUldqNVlz?=
 =?utf-8?B?SWVUa2twMmkxZEhmTmJWMHg0LzBwRno2WUdyeDJVMjVpcWZEUDVxZldiZ25W?=
 =?utf-8?B?c0N2MUJtWDlzYnlpeCtXeHVXSXJ0d3k1Yy9pRzV3aVU3ZWx6SFVnTktqWSs0?=
 =?utf-8?B?SU9rVnU1OGRycDNnQVJZQ2Q5VTF1VTlQNUpyaEpsYWFoTll1eVpIb2ljeUVM?=
 =?utf-8?B?VXNoYi94M3pjekNLRWp3Um0yY0xMbjk3SVY5OVRpMGZQV3M1MzVCczJ5bFJ3?=
 =?utf-8?B?dHRQWDgrdHNLZG5LZFI3ZzluNUl3aE5hZkJua1FRUXhmSE1pMUJ0ZC9Nc1Uw?=
 =?utf-8?B?Q29tRFVHcFN0U1N4N3lvWUlzL1U5NjJCOEdUTDl1MGRWd3ppa25kUEh6S29t?=
 =?utf-8?B?NjQzNXdYU3lxQUtrcVFYT3U1M3h1MDRFVjhuNVZlcyt1SlZ0Vzg0ZlBQV0Ew?=
 =?utf-8?B?eFBSN0JNbCs0WngvSFhrUDc2RHNDbHNwLzhBUlV5bkkya05SQXk3TG96Rnc4?=
 =?utf-8?Q?4mNWCYp1u0iPs/DGoOZuQHi6e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc81a8b1-c0ef-45c7-13bb-08ddde9898dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:33.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFJZh7twwYknUZ7rM31+bx6pLadO5+BAfIxQ613O/8vxIQVWHleWBmEveA34HZGV3xL8CE3PY3xUg6hyyg9rlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619

Remove redundant snps,host-vbus-glitches because default workaround enabled
commit a6ba1e453174 ("usb: dwc3: apply snps,host-vbus-glitches workaround unconditionally")

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index fdb8f5952fcf7f55fda9b5d5a45de053697f3264..ba354c48a9cb4c962599925017828a089fc5a4eb 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -810,7 +810,6 @@ usb3: usb@3100000 {
 			snps,dis_rxdet_inp3_quirk;
 			usb3-lpm-capable;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-			snps,host-vbus-glitches;
 		};
 
 		pcie@3400000 {

-- 
2.34.1


