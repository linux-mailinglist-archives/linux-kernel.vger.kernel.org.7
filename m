Return-Path: <linux-kernel+bounces-822109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB3EB830A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103781C23F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D6929E0F7;
	Thu, 18 Sep 2025 05:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="euzLiT0U"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2592D7DCB;
	Thu, 18 Sep 2025 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174306; cv=fail; b=mWldI6Pgtj0W5qJybUvf8L1HtCcecy8nMo3Wg2LObuUGFJuT+ac9DlOWyBe7bnwCDlFd2Ng2yY+s/D0SNwQvkis3KSrNh+PRrMwPo5vy/UrfCjuHbkWq50jf/hMfJJt/uJOJakQAHK98aOW0PZ0QH3eYmMfuYC/s9W2vRl1xJaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174306; c=relaxed/simple;
	bh=CfbIc1elZn6eTFU7iP5xzC5CD5U9QqeDon40aaxtFh8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AF2AAQW1t+j5ShfMgIaaFEMigiY1bsK++5NGVK6u0tHTrf5hOT8+vTwEqPXDtGY5/IvEpOpwlAVbfUczvywcP70hOixKQqjfWLQLw8pBhNPfiiv4HVhMyoHcAkXzitQPcYcHNJxB0lg3KaAMSBYF9IaTNRLbPmIoTyj+WS5Y+cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=euzLiT0U; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYTBtqTnvGkxmCSqPsCjmgl3VqTK/BKT8zffZiOImLgKuGyM/1IDjdE52Jb4QwPIBAtRlw+0R7xbyLHryianA/xMC+IFj+yUP+oS89Q6T3vW+8QFfiiqy4cXfWPBadzKiRHidqfuyRaR/Nw5Zg2Q4AJKWJ7DXZcq2LB8yBRMXsJaUjmHo6NQ32M8WPNtli51fYqgZ3BNuTNd4XVU2FPKnEbYs5nEmmT4FTUw3VBxWM0GCtAKaEdD1srVekziYTiXCsSWG5QEjC0REinZN1Wday/WHtzJkY5OMQ8gS5Wg10bG7m3UMJSeRY0hN/1EkgsDMr3rItnhlZv2IFpOHi1log==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHzOvQGqSC7WE13JG//zlfGOExQHvRSDxYoUa4tKKAU=;
 b=DLgJB7G9PNL9qGy+AEh4mqtS3u5fhedxwp9rR/KeseY1i5Anr+kwC2kFn7wFrokUnHkEBzAzIMYB3Ufps6WOVcNSB3Ye/b23wcJePzQ6cPDv6izA0FWYLvTrIReeN9kXjMShVS0q/SubCYX6ympcCiuGaHPf1/jdIXV6zsnVP7VZR7Prl7YYOvzZLhMu/wh8wvIOv2OeAttN3l5MpxsKfeCOQsrN02IvGr+z9cW4byCrtxaRoITWD3TLbh8LPT8LigJoJjXMTanIq0GFOvkTManKKlo8O1YKmPK1oP+TMf/gYRQlZ+HDofoaAC6uk/TQkb6dI7ENVT2di7nFDwY83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHzOvQGqSC7WE13JG//zlfGOExQHvRSDxYoUa4tKKAU=;
 b=euzLiT0U+yAx31m1SKGlqdjrcJn4TE+ZxhKk+GpYlFrrHzzav1hoS4vyV/Y9XU4iGrQJoHRlgVMnXkk/ql0t0dUsdZg4M/VGwbNuXKOvHg+dftMgqIIC8EzvB2WteGMTXqbqwfGlJrRBL4Pa+q+ip9xKCBpwhU6QhzQ1ZhJAvwLGTTzICFkwEqJxvreuoE2sfsaD3tNeHu/Ild9k1BvCvX5uJPQeToztf+nuubHsijRrAdxMypwmAVphYrRz4fRRkNnbLHgwkyqNvDgm44HM2rlLIVzTXI+Jtl5Aht/qaLIdpPu3Eqn9M9BWTEvXLAx2QLzpvnUV6Ig2EzNinib1rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 05:45:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 05:45:01 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 18 Sep 2025 13:44:33 +0800
Subject: [PATCH 2/2] ARM: defconfig: remove CONFIG_SND_PXA2XX_AC97
 references
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-audio-v1-2-e9d0df5c60d2@nxp.com>
References: <20250918-audio-v1-0-e9d0df5c60d2@nxp.com>
In-Reply-To: <20250918-audio-v1-0-e9d0df5c60d2@nxp.com>
To: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758174285; l=755;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=CfbIc1elZn6eTFU7iP5xzC5CD5U9QqeDon40aaxtFh8=;
 b=I9AFyLD2MpXnPrHcSv0DuarjOEu+TGkSMmnuQWozXUNGn72umnoFUXafIHQ4CdfNSYa9JWDUZ
 eWx9gbxB9w8AwaBRqbFklr9fd7wbAkAedRU2PAbLfaN8E9JyBhaH2an
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e26e431-1692-4768-73c8-08ddf676822e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|19092799006|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXY5OXVBWDVqOGxORWs3TWNoY1l1Z0JOZFNxU0F3RW5UNm8yZFF0SWZRcEIz?=
 =?utf-8?B?NVVUYlBjR2FSd1psZ0pCM3podHFDRUZIUzZXQnpyeUlUcmo1amhEKzAvZ3lS?=
 =?utf-8?B?bDhIZi9Sb2lGTWlxWUxEb2QyRmZCVzJTNjE1ampjM1NPZnlNWkJ0cTM5QVBo?=
 =?utf-8?B?TzRHY1NkbmQwS25mVldUeTFFRHdaK2lralV3Q3VqdzJ0clRXd2h5U2FuUEdV?=
 =?utf-8?B?MjJlWU95ellVNXlubk5lOGZSY1cyR2FOUmlJR2xRNS95WjRMOE1sV1greTlO?=
 =?utf-8?B?RkV2NnZsK0V4NjZZSzZOdjhSSm55RnQzc1dWTWpiM3RVZVgycU1nTGxhbzNs?=
 =?utf-8?B?V1dJbWFlai9neEZ3enN5QUtmRHpBRktCYkJaTk1xd1BIT3ppVFppS2Z5VTh4?=
 =?utf-8?B?WUpSMVBnQ3Jham5HUTc3MEp4RkxFdktDTS9BSlZDeFp0aDF6UlRkUitXMDk4?=
 =?utf-8?B?VVRaanI4Z2JDY2h6OVFCa1Y5eTh3QTF2WkdLYjA5cXZhY2lyMEpNZ2J0OWJv?=
 =?utf-8?B?cFdEbWllNjAwd253OHJyT3FxNGNGcFR3d3NsemNzTDFZc1BONHNKcFlpT0tB?=
 =?utf-8?B?WUhrS2gxWWw4c0JPMkk4QkQxSlFHa3YxR3h5WXNxQlc3ZUptbDF3cldVaDJD?=
 =?utf-8?B?U1dnRVZVUC9aRmNMSjg4b1hiUDNuOVM0b2ZCMDBnazdJMlhhNHNNUXdJYm5X?=
 =?utf-8?B?c1pUYTRBZkpjbElleFVwR1pMUW1HT1drcFN2R1pXVS94NGMzY1hieW9sZFNV?=
 =?utf-8?B?a1RHODNFeWlpVzRPMlVxbWRXTTJ1SWRjS3ZZdWlFTTVnNU0wYTltK2xnOVdB?=
 =?utf-8?B?RUtOdWg3QlJHWFJ3TUQ5RWdFSkh5NkxvY0hrbEVUNUJJQlI5cVh2OVFmSUNO?=
 =?utf-8?B?K3M0dG1yRUU0a3lmLzNpVVloS1JIczJwTU5ucHdISmljVFlWNGFvUE5SQlcx?=
 =?utf-8?B?QnNCVExBOWxwaUYzdGpDT05lSnJ1NlJ1QXNoWW1ReHU2WENHWjhZYVl0L1ND?=
 =?utf-8?B?ODJWYTZOa3J0bXV1cGNyWlk0QUphWGo0cFpuWHRyVG9VY0ZXeE5tSEVtNXVK?=
 =?utf-8?B?K2NRb3ozbmFCZ3RRN05Tam5zU2E4dlErQkgxVTFNcEhJQUNZYnNrTUN1RGJL?=
 =?utf-8?B?QTR5a0JmMGVtTmhuaTFYUlVzS21sVExCeE03d1o1ZnRwS3lYWW5CbTVEVVZK?=
 =?utf-8?B?RkY5NVpWaXpaR2doVFhUWlJuQzFjemNySzhQQTlTc0ZONjlyQ01Wckx0UWVX?=
 =?utf-8?B?T0RXaWhrVGdvWWphc1BKYUlhaTJRUC9WRWNwODloazdUQk85MFpwNmlkTktl?=
 =?utf-8?B?NTZ3L3BZUkV2T3RsK2QzWC8xTlRkeGRabHhNeXR3TG1WbVhYWk5RYXc0SlFw?=
 =?utf-8?B?dVJCQ0dlaVZWNjYvSjhrZE9STVpkN054emsydVFORU1JUFNLYkRRK0NjSWpQ?=
 =?utf-8?B?anVCeXl6NEpWK3BOL0tPZ01hTGVTVTZRRlUyb1p2NHdiQmV1UVJ0VzMwa0pY?=
 =?utf-8?B?UFhSSVRab0g3R1dBYmF5RDJ5NCtWQkJSRHR1VURaUXRFSUpNbmN6dm13YUgw?=
 =?utf-8?B?VXVuWVdpbnBpK01zcTB3R2tOUzk0Vm1RL0NFTGxablI4ek5QU1crTVhyaGpa?=
 =?utf-8?B?b3JCV2I1NDU3c3lzM1hsYXBzeU9lbXJBWCt0c3JVUTlUMThRS1kwaDlJRzhU?=
 =?utf-8?B?UUQ3RVQ3RHZ5TnRNV3VqSlQvREpoRmFnSjhmaVVqRTVLd0VlY0ppd2RtL216?=
 =?utf-8?B?WkQ2bXF4eFFXVUhwQ0JVSEhVNGVBNGJNNEYva0pBaTRJNVF2RHRLZ0Vwei9V?=
 =?utf-8?B?SlBEVFZsVHFXckVzOHg5M01ZVmt4a3JhWTNqZVpSOHd3V0htaUszOGRLS2NW?=
 =?utf-8?B?Rm1Kb3lHbEo5anZRZ3JBcURBNG9zcHNFUDN0Y255cFlUS1huZkh4ZVRCZkdt?=
 =?utf-8?B?SktlaWxNT1NjWUZtR2xDWFlJQmMvbGJEdkZaeUd6WHMrTTdJcEhkRVFTc2RG?=
 =?utf-8?B?QVNaSVlISGI2SXpyaGp4a2U5MHZOK3E2Y3hkTjNxVmMzRlpFWTNMWVloaGtK?=
 =?utf-8?Q?gIdVb8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(19092799006)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZndIbXdjYUtHY2pETzlPSE1EN21Nb1orRjFHUTlTNmpGYWdUWXpaYW9JSThw?=
 =?utf-8?B?T3M3TnRTdm02ZGZSN2VrVU8zQ3lSd2tNRmVBZGRnVzJwV21MakZqOTY2dnB5?=
 =?utf-8?B?RHFUS200K1lSazdaeW41UE1POFpHZFJYZVY1bjBDd1BTVmdmUitOaVV2OXRu?=
 =?utf-8?B?OWcvRmxqVWNXRWc1UjNUOXd5c1Z3dEJ0UnU5NzAwa0E3Y3lzK3h2SzNsNjdn?=
 =?utf-8?B?RTg1UThFMGs2NWQzRlZ4eGt3VGd5TXkzckRQbjVwQzFFTjREb2pwQkxnZ092?=
 =?utf-8?B?SHd3Z1JjS0FKTDJvNGsvQnU4bEVmdjI1Tm9XN28xbVB1MnovQjF6bEdSb1Zo?=
 =?utf-8?B?UTJxdncvYXpmV1F5UkxsR0xYT29CcytOeWdESElRdmhxNWtaLzRScmNWSDZG?=
 =?utf-8?B?RXJlSHQwZzZ6cDJtYWh1dlEvMm1Wd0FsK0FoU2RHdVpFMlY3VS9DRUdIVUZE?=
 =?utf-8?B?QThoT083a0tKUTRnVzVhL3Zuem1qZFVFYjdFUUxpYkE5SjZFNXlLOVJ5aGlR?=
 =?utf-8?B?RHV1UzhNbzBEUXR3VUhNUDQwU2J2dmhLR1RackFmZTRnRWdsNWd1VEhqenpQ?=
 =?utf-8?B?MnlwWVNFRDA4QkJqd3Q4cGhGZnFiN3BIMTFLUUoydVJQeElZTkJsUmZHRzZZ?=
 =?utf-8?B?N0pTUUhkSG9zRXluYXBkZEwwWStyK1ZweU1SL1o5WU1lUVhYMHZkVS9hSGk3?=
 =?utf-8?B?WHU1RkJleXdtcUo2aE85TVBQdFA2Vit6UndxQlR6b3cwOS9kaTlzNWVPZWxH?=
 =?utf-8?B?ZjV5ZFlLaG94Nk4vZ2RucUFBZHdmMHNLYlhyWER1SWxFSDRZb2NoMFg0TWhk?=
 =?utf-8?B?bzllK0x6OW9lWVFXeWNaQnFNSlZkeTR2d3ZxOFRyTnJzSzhOaE15NEVoMzNx?=
 =?utf-8?B?aXY1SWp5WTArKzg0WFJrbThKSWFtRzAva2pUZU5oZ25ZTG9UZDRrSUZCNUFw?=
 =?utf-8?B?SENjYkdSVXlXeEJFa0pwaTJrTEF4RUVlTVYyM255MlZDNHNUaFRWdkNVUkdU?=
 =?utf-8?B?bEg0blozelQzdlRmeVFDZ3JRc0d5UTBvcThEVFczRFJkWC9wdEo1eVB4UHNM?=
 =?utf-8?B?VFFFK3dQVkJmVGJWVE5pdDk3QXlMSGI0dDFqQ0oxWDExaUVlL2xzMGZwbTFm?=
 =?utf-8?B?bElIa0lYWkc5OWVYK1RoUFVOS1BwSmxCYTR3SHVjQkhCT1Fhbnk4cjVOaDJy?=
 =?utf-8?B?cSt5Z1lVSUFSYnQ2OVFDUVJtdU8vaFJ2eXI2UVVSWVFoWEducmFwZzZiNHND?=
 =?utf-8?B?R3AvK3JwaHYrc1dBVkw0MG5wemZkQlp1Sm0xR0htamhSeFRQdktZdmJwYTRN?=
 =?utf-8?B?c3RJTk9COG5IUllCak8zbGhkRXJlQjFYZmJwb0x1OTRGR3lnNnJtM1NKMEls?=
 =?utf-8?B?dk8xRjJ0MU5aUEZSN2lMRDJ0QmNHWWdXOEc5Rks5ZXowLzQzSjV6R1pRNGhT?=
 =?utf-8?B?TjN6QzFkWngwWHUvSUZXYysrNjkrTnRMVEtkb055N0lSTTBJcFdPUEpLdmcw?=
 =?utf-8?B?bUZKWHcwNWtVUmJjTHZnellYblRvd3lFR0pDK0JVUVY4R0F1RDlmTHE1V3VX?=
 =?utf-8?B?Z1RnNEV5SWc4eHRna3ZwWkNqalZTMzN1V0R2SEc2RFBRLzBlT3paaE1PNDdh?=
 =?utf-8?B?czFXOXhpWDhvTmtFdW4vTkZpSHZBZlFrUW1xbGl1Q3JMTFA2WXpXYXJUaDBJ?=
 =?utf-8?B?bHk3eTVtUld2RS9RRzRDWERVNTFqSnZHbVV2WVFUaW93TFJVVzZOZ2lzSEwv?=
 =?utf-8?B?ZzBUdi9xYVJCUWdMTko2eGR0WDNVVHhwWFBwWVkvZkhVRmF1MkpFOWhYZ3lP?=
 =?utf-8?B?OUNDRTZWRElSRWpERzdqOFFnVGx6NExrMjhPdUNvOW1ETTlQREd1UlZkTzk3?=
 =?utf-8?B?MHdpdmt3dWVuMmNRZjgrRlQ3S095eWJ4aEFoTEo4YTcvM2FWL1Y1ZU5XS0JX?=
 =?utf-8?B?My8zOTB1YUhob094LzJpU3J6VWxTYVNlaWJmc0piUHJzc3lwSWQzYmtCNkZE?=
 =?utf-8?B?WWE2bEEzalRlaFdRTGpDVUJya2JJd0VzM0QwUTR0TkgwSHRnQVlJbzM3RmpR?=
 =?utf-8?B?V3FpNVMrYjVMeTVic3dWYWlEc0MzME0rZjQwQllvR2hlVVBYMWVYN0VxRjJr?=
 =?utf-8?Q?fgR11HQ/VMkahCW+rtoX9/oyU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e26e431-1692-4768-73c8-08ddf676822e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 05:45:01.3734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u81FEjS+WVl/Rkut+60T5Vk6b51UA8vwlW0JKzVmmjRuIMfyJgISRFikv7W+lWWj4yX4/gSdo17sSKDafpSH/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415

The pxa2xx-ac97 non-DT supported driver was removed, so remove
the reference to the config.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/configs/am200epdkit_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/am200epdkit_defconfig b/arch/arm/configs/am200epdkit_defconfig
index 134a559aba3dd535782942b1aeef94631ba231f4..9305db0b48f2ace7ececd826d06fa22b8ad3f1ff 100644
--- a/arch/arm/configs/am200epdkit_defconfig
+++ b/arch/arm/configs/am200epdkit_defconfig
@@ -70,7 +70,6 @@ CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 # CONFIG_SND_SUPPORT_OLD_API is not set
 # CONFIG_SND_VERBOSE_PROCFS is not set
-CONFIG_SND_PXA2XX_AC97=m
 CONFIG_USB_GADGET=y
 CONFIG_USB_ETH=m
 CONFIG_MMC=y

-- 
2.37.1


