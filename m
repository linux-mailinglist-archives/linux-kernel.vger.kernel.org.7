Return-Path: <linux-kernel+bounces-774482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F20AFB2B2E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D4D1B213C5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF427978D;
	Mon, 18 Aug 2025 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TUzVu7de"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57227277C88;
	Mon, 18 Aug 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550131; cv=fail; b=uETZ2nBNj/NK7pgdnqdVekm+KZhP6Ne1jVyPvzdjHYxKqScj6YGsx7mwuBT//skh3HIvP+gcVnwxpCSHojhKyaKdiH/nioij4wy5pNovbW1qbJNXFylg/j/RqvX/nQJmSKr03ZzK6Azczu01uc7srMtAKoL+PJrki3leM3Nwa5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550131; c=relaxed/simple;
	bh=gCM5/Cs/05tffWVY+RDrHU//sGBT8qFGT36AlI1Rw5Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D+ZX+ptmw0MHB5Gek2taZ2Ah8obv+HO0LMq1wGKrLQ+QLxJEDPbabeLywyTXP9iarerJpnYQ3dR2nqNaHiLSqVE+vyhYa6iG2Ki3NmrEgQn/2tCFWdlq1+fFydEbtfw4k6xtsoiivCJy21uuDDcCRv9lEdxfNPTjTgt7DHj8kLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TUzVu7de; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGcNpsL2syRc5E5vgiLkd0L4iPMnYIID/fHFOxFPrPiqVDzfJz2In5pbJaz07PUG0Dr2M9HpgkjCTNgDEWDWRTOvhvRzf9+DDU0hBkZUuf/3onP57qI3kTPcfID5n5WCSPiTjAQxtOlsyYzbKm4qxKdxG82DE8STEl1TqzMuuy1wuKkB0seiQiCk+1OwVvoR4dORQ1453pZ0iVRCSDa+O3dUlOaxCySdDT6Xe/g+9ja0zKvnsd9+nZdY/pMm/8qowkD4rmszSADRTMqSdXJWwMywKOFLQHuGlj+QDIP0OyiAYRjDQbw1M46E2wM8FZbLO9EeROVsp69ngzUXUe3lhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tuw0dpSlEwjpSTlPmQb/cqQpJz5HUVXY12MSWhOyFSI=;
 b=itCJZ89k6nl55nZ6rb+50NceTkn9ufLKUx5sLD6d+1oybb1+jmyKgrQh1960fwCGHIbisVRoCJwQhnkm8/GpJI7sd7EsIhdR/bJUFPV7XeBCi1SozLGxmB70r9OzhocrpGosDMZ5enmBY1NmpZBxKDqRSNJ6Wk0Ro9XDhBEHqV2htNUA/FS6wo1Y22NU+cHIpaUf1o5vOnW9ujv6PAZj9nHF90SOkJgP1F85uNCH5CKcCdOxmZdzR9+emU7MswQ38Z2XkqzD7x26aLffidj7V0iEvJaIUQxosbBb3Img9fWWBa0age+Y2sl8huK9HQDes50x+mTag6hTOy18i62LYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tuw0dpSlEwjpSTlPmQb/cqQpJz5HUVXY12MSWhOyFSI=;
 b=TUzVu7dekNCG797mLLKDfC9YuA8F0JeyJRvH6N02Se8FVLBU4SHfC8wUyDu4DUMIEEpZQMQK1uMr1NPW1kdb91+6mVshRGBfq2u6JM+M/tSYyI6HHdI/3gLfppwGk332j8U9KJBOoy75tFr2mzTY9+2FcLnJ3z/RndfL6uWbDDxR5OqGTGJnKrB0pbg5vlkxl5ZnpTs1m7OU159FdZigGCycr+UJ3wskubH21FpmQlseUnpnGsVXWDnM/8XowJI3wl8B1wUWBtFMqY1QiDKwYLIzzMhuzZRs/jmX7mjisZ1y2Yst+WpCI8raFggCxomse6I+f2kR22ybL+T6PuWm4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9009.eurprd04.prod.outlook.com (2603:10a6:20b:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Aug 2025 16:48:20 -0400
Subject: [PATCH 09/15] ARM: dts: ls1021a-qds: Rename node name at45db021d@0
 to flash@0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ls1021a_dts_warning-v1-9-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=1040;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gCM5/Cs/05tffWVY+RDrHU//sGBT8qFGT36AlI1Rw5Q=;
 b=RLH/wmNWNqTBV7ldFTR52dAmPaWVu/GvWbAqPix8sBeuK7VuZm8/TqYXTZGRYt+tdFSH+DJZc
 ztNOqcrHpayAZtxl1NC/vJLxo86ns02hzZVa4o4dNHyH5TIHaVyjIUU
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae19c3b-67e2-440f-c9d5-08ddde989f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXVqaUNKcC9UKzJET3FFTTdUZlRzdVptQkh1Q0paTDhubFkxRG1MeitIOE9H?=
 =?utf-8?B?ZnhzcVBBdExpdHVHSkd1cThBbDFYR0hvMGlxN0hmOG1SYzgvbytiUktTWkJs?=
 =?utf-8?B?a2ZZZ01YRU5XV1Z5bTRYZXlkVXVzUHdDdkxETjRQUnI5MktZWGdwWWR1ZmMw?=
 =?utf-8?B?eHIrM2VvRFF4em80ZWFSVlhXVGdTaWVKNlgvVE1YczE0QXVlNUVlbm5iZHpn?=
 =?utf-8?B?R2VlL2RWZVI0S1R4UTY3S1RteGVDb2MrcXhDaVQ2alhyK1Q3MUVMT2FybXBj?=
 =?utf-8?B?bVBxWXM1QTZsbFRaTEMzaitBTldjVlE2cnYxY1FKSHk4RHZMMXg1ZmR2dVNE?=
 =?utf-8?B?U1NOOGJwczlLb3EvUHh2NjQ2OUU0SEpHek9yaFozcVV2RTl1VjZTZzVYaVlT?=
 =?utf-8?B?WlhnWVc1b2Rrb09TMHk4M0luMW1MNHg1RFdFUC9YaGQxNVlYbFhZYmRQZytm?=
 =?utf-8?B?aWJObEEzQ0o0ZjF2Q2w5Ump1RVNOaCtyRVNGM0EyYmdyaHpBY0lNTXMvVHBr?=
 =?utf-8?B?UFY2UkRGTXpBakJqSWRveVhNOTV2dGEySnh4Mi9JM25rRFRTaVQ5MURRNVlV?=
 =?utf-8?B?NGs2ZDJBSGJWYkF3bWxIT3l5aU4ycVh5L3J1Um9PYjVybEt6SFFMR1pnTnJn?=
 =?utf-8?B?WlF5SjBTWWw0cWVFSUZ3L0lLbzJWcmtCWmtKYnJUZW1QODgzSDRiZXBnVGNP?=
 =?utf-8?B?b0dpMkViUHZGa1BqODZZT3pUL0lONFdmZUFhRjFoZS8rRHY3WXRaem1GRm5n?=
 =?utf-8?B?Rnc5WXVPelhyQnNuNzdMVVZaYzZkS1FmMjRVeWpSNWpETUF6d3NlV09SUElj?=
 =?utf-8?B?Z3FpL1ZlWDQyekFCWGEyM1JTanAxTVNHQ1pJUnBxV2dBZ2wrWWo0bFRXbS85?=
 =?utf-8?B?Vk5wNng2cHc1ekZJeENNMHBxbHVnakhqQ3pxcC9GazRnK3Y1ZnltSGRjb2NI?=
 =?utf-8?B?UVJUNjRYVUF5TS9GS0RDVWU4czVEMXo1U1cxdEt5MzdDL0lGVEN2ODVIdENG?=
 =?utf-8?B?K2xnU1pUOUhsN3RCMG9lVkcya3NnZWNkdjhMS3I5cWEydHdsNmxlUkYvQ1VI?=
 =?utf-8?B?TmhoVUFVcXFlem9XNW41RW5mOHJ6aWRnNTZ1MzVxSlQwNXpGUU9pNThGQ0tB?=
 =?utf-8?B?Ly8rQUcyTWFUcVI1ekJVVHdyMkRLWlg2cDdkUit0ODJMdVR2dEh0RmdPQ21m?=
 =?utf-8?B?TWRQSkp0UVhMenExdFlubjhZampYODlITlZjbWdmNnJMcHJHY1JERGwrdFBX?=
 =?utf-8?B?TTM0cHhMQndMaG9XTUVSSXNZSVh4NWowTE94Q1oyT3VMNWJ3TXlZcTVCVWhF?=
 =?utf-8?B?TjBnMUt5S3h1czAwNVU3WFRrQjdweEJuby82RHZ2enZic3FTNlRnOUxlTXJw?=
 =?utf-8?B?NnVMWks5ME0wY0JLM0hsT1dnYW41Z2JEc1IxTEh6czNMcVBIQ0ptZVllTi9i?=
 =?utf-8?B?UTE2SGo0dnpGTEJyS0RMOUt6cS90YkRvZ2ljcktHVWpOZWM0VllTWVVDQW9F?=
 =?utf-8?B?NnN1RURSQ0tDYjl3eFNoZkFiRmxORk1TRDRqU1NQQ0hvTlNsYm16R1ZZUEF3?=
 =?utf-8?B?TnVQeGsvQzJ6WDZsdjM1WVR3SFdSREpZbTA5U04vTDFLb20ra09HQzU4THZk?=
 =?utf-8?B?d2VGeDVZcXNJRkh1aHJPWXNKM2ozcHArbHM1RElpUnB6NCtTL3QvTzR1K21x?=
 =?utf-8?B?dkVZSUVpNmFGR3UrSE1QeDNRNnpiTUlsVnNCREEyK0o0ZWNQYlFoM015OFI4?=
 =?utf-8?B?eE9ZeTlOVUdMc3VWWUM3Z3M0eGFQN0tLcTN3UUhLemt2Qno5NTBTY0UxdzBz?=
 =?utf-8?B?VjdiKzJGdmxsTngwQjJnclFiTmZRa2VoODJLejU4Q2VwUUpCSjJEaEdUSEUr?=
 =?utf-8?B?SmRXankrcUlLaWRPYXNYRUlSVjRPejUxQXE2TzY4MjNQZUlxQkVPbWlrTHFM?=
 =?utf-8?Q?Gs2SArUx/gc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1pTZytmK3E2K3Q3SWt1dnhITmNpWHFJUTkxODlmZEhkQ1E4OVprT0dBVEFK?=
 =?utf-8?B?SFRpZ2FQSkJCbVM1ekZwRko5TTI0b0NPNU9ia3VWZ2VzMVgrMTdsbFlsQnJY?=
 =?utf-8?B?OEZwbWhaL2lIZDZsd2JNaG5kQUNUN1hzNjhwTWhZMEp6QnFOc2UrZnpSVVdC?=
 =?utf-8?B?ZzZIWk8vWDZ4OU1BeFo1dzlzLzFMUnhXL21KcGpBSWtIUHdLQ0ozQ0JXbTNl?=
 =?utf-8?B?bnZZaUtkOFFpdG1DVkFuM21WTHhCVkJRd3liU0hjeEs5MWJCUmpseVY1V3RL?=
 =?utf-8?B?OVFzdzVJdWhoTjA1d1QrVGFMYnNPRW5BZW0wVUZyaDRoYi8ySklvSlI2RHhH?=
 =?utf-8?B?a3JTcmxSZlMxbnFRL05IWGgyRFd5QU5ESzdzVDJ5cUhQNUFQKzNaMlhXRSsw?=
 =?utf-8?B?TUdEdjFJSDFIY0dRdW5UWXVIaktTTW5vM1RBRU9YdG93U2ExclJMRzB2TnNy?=
 =?utf-8?B?WGczU0pROWpkTUtVejhKdCtTSVh5MXhCdWdqU2trUlJCdVg0RVlsM0Z1ZVJF?=
 =?utf-8?B?aWZPRURjVUlISE5Za3lmc2J1WWRlVThvNmt6VGhITjJ2VVM1cEFwT1dLT2NV?=
 =?utf-8?B?YlVoUUtmMUNZQndHa3FWaGFmNDRUeHY3OGJ3UVpaa2t0bEtqeldkb0pnd1Fz?=
 =?utf-8?B?WHMzMzluRDU4TzZnMHRGaFpQMmhrMXVod1Z5ZVNLMEhBZjQzcFc3ZmpTdUJ0?=
 =?utf-8?B?cnc5Q2N0ODdZWEUyaEV2RzRGNTM5VFA1elp3TzBmb0pjdHUrQTN0Q2NVNGVz?=
 =?utf-8?B?bkFkZXdsYThBb0MrOG1iYVgvVGF3QllEeUZEaFZmV1BGQ1ZLUmduM0xHTDlo?=
 =?utf-8?B?WEV0aDlDam1KQ3BsVjRaRVpUV29iOGRiakpRcU9vTE5lMmFQYUZVcGpKbXFa?=
 =?utf-8?B?V1R5V0s1VmtNYnlEUmZHMXEwakpEWDVnczViTVRkRHRJUW93WWtKeGNlKzlw?=
 =?utf-8?B?WjZTRllSU0JneHoyNDZrNld5Y2l2aXBZejNLQW1qV3Jnbk1UYTU1RTJQV1NN?=
 =?utf-8?B?OW45a1FvMVFCV3JGWHNhWFJDS1Fvdk5tc3hZUXMwRmpZMVQ5aFFGRkdkRll6?=
 =?utf-8?B?MzJSbWo2SGFnbzJzdnU0NjBXOFB0bCtqM2JkWVlMY3RyellIRHNEeGxBSHd2?=
 =?utf-8?B?bXhydFoyWmNhRmt3VThCcXVPSXRmOFpwTWxVR1NRcEZWVkxMcGg1eEo2OGVj?=
 =?utf-8?B?VC8rTzN3bVV0ZkxZRVpOd1JFTnI4Z2JFeWNscUJic1o4S3dEWmhKQUxxR2xu?=
 =?utf-8?B?VUQwSU9pK25JbnhVTlcvb3JIS0gyOUo3KzJRdk8wYkZQZzFHUTBIWG1PTDhl?=
 =?utf-8?B?ZFdzM1JjcWc0dFZ3SE5GZmU4SXR1WHRiZXlCU1czbVczcFMxL1VhK1VDT0RD?=
 =?utf-8?B?dEUzT1lnRjBsclZyK1pqWnZIejFsdllybkJnQXR1NjVBT0ZuWHQ5bXI2YTEz?=
 =?utf-8?B?VERSUVc2bTY1b2NGU21tNm0zSHhrVmVDNDZoMG1BOHdDSHB3S3BtQXo1amxa?=
 =?utf-8?B?YXFJamNySEFwUHFTdG0wMUpkeGNncDVKRUFYY2tIVU9MT1psem9oT1JmeUN0?=
 =?utf-8?B?b3Z5WHg0bm11NjdBaDVjT0h2TzBWM3cxdWdmTVZWVERuQjFNNGNsdERtUFl0?=
 =?utf-8?B?eTVuRVJKT2w4aDFRVzgwZmJueEs3U051Nis3U0lLT3I4eDNYL2U0UGZ1cUgr?=
 =?utf-8?B?c3Zrb3JIeE9kTlAwRUVQRUNpNGI3M1lmS2YvWDBhSTFOOS9RWEo1a0puNVU4?=
 =?utf-8?B?T091SFFZVktTL0hZM3FIa0NnUUxiTTZ3S1dmeTAvNUVUNTFsNFd5aVM3UWNP?=
 =?utf-8?B?TlEyZXFTWDBwUGFGK2hFMG5QOUk5cjFWY3paa1lRb0pnNm5XNTBBSVJCNnpF?=
 =?utf-8?B?dGlsakpDZ01JZFQ2ZEloSGp2RHJDSHBMdEsrQjFiRksvOE0xQWhmdlMwamZY?=
 =?utf-8?B?a1VBZzdTenJ5YXF4ZkFGSTR6WFExeWlYbzljUG5OUVlaYmZEa3lVelYxSTBy?=
 =?utf-8?B?Qk9sUFoyK1h0TnoyVkY0MVV5QlpuNlM5OWVlcWMwekEvZjZ2L09tNFZYcm5G?=
 =?utf-8?B?S2Q5ZWxCV2FRY1RiT3VXN2pEcHZsaVRIUXBDeHg3VVNQYUh6UHFmY3FCMko0?=
 =?utf-8?Q?OJ9GuVC0WoL2kk1bvo93APnVe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae19c3b-67e2-440f-c9d5-08ddde989f97
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:45.1635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sELUJiOJR+9h/s52hXdoP+qawmJxodIua//F1MLLiWZJlGCr+GsQ/K/DHm8dKgVFJzjSC3p1zx3hebVq4Avlkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9009

Rename node name at45db021d@0 to flash@0 to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/ls/ls1021a-qds.dtb: at45db021d@0 (atmel,at45db021d): Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'spi-cpha', 'spi-cpol' were unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/atmel,dataflash.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
index 227a886ca6825465cfbb404e93c8f5e9977b1321..8bc8ff2e3b03d6eeb43d79fe0555842536ab735c 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts
@@ -66,7 +66,7 @@ &dspi0 {
 	bus-num = <0>;
 	status = "okay";
 
-	dspiflash: at45db021d@0 {
+	dspiflash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "atmel,at45db021d", "atmel,at45", "atmel,dataflash";

-- 
2.34.1


