Return-Path: <linux-kernel+bounces-751538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629EB16AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5162818C871D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87F223B63D;
	Thu, 31 Jul 2025 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OFWReJVy"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013047.outbound.protection.outlook.com [40.107.44.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0C22A4EE;
	Thu, 31 Jul 2025 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931290; cv=fail; b=HtJXuysVmi1iNaLb77vXS3Hf0NFUBc7UBTdbFc5CvkHmK+F+xCoEF1Is0LR0x+frJ0KJYrAOwjf+QOR/mU8QTwJXuhge6rx7tSmSn1il4tmgbY65U36rCZttNOKJcE+u4KcAKTwCB56b62jw7rFd3HqjOHQuRc2qwj8fpsEuId8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931290; c=relaxed/simple;
	bh=R4cfA3hyzsUxC/BC3xBo46djaQ+rSHsb5xAe+Qeg3so=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KGEUrOcxFqdY57aShLNqcR2O2Bq2loDi0HRupLOuGXFy1yXRnpiCJNOhxMyzPr5kY35kPemVBRk3WNiYs38WaB6LuIbZJ07AQ2iQvd+c+b7GPKglJhVMDW86Ukkus/CBBJAfZ4K4+D8DeVfq7tqqAMEQ45btBmwGNqbx7pRvwOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OFWReJVy; arc=fail smtp.client-ip=40.107.44.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URBDWTk37CurAg/bQyt37nWWzYAcHWSHLN879kx0xKPXoclMrfwi/vIqpOjBBtnkh+VgJh6Q0wN6DjFe0GYDi9pjq6pV9MsKKfMW6JzKLDC/RmlQJgLegQP6ypA/zviF0eue8tEhKLdhDVum2GfrEFTikPZ+GLuCAtzWOMHajP7BI69fsQZ0pQE88rjDcaT8deJ7RnxyAGzFQNuCvZ3rbEucdWMfxY5co7TidQ1cvHLSfnjaFr5XYvu9eQoVcvXUdQbPjMTrs9UvQrt1yNO0FEwGTAPKNk/bh1SomU4vpr0C93NA3m/lHUEtH8fL2X9knVEagfQ3M0ArjNQS4yOCMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCRl16/9wiZ18n8n1k/udUfiW/YzMHEBJA4hYyizW5w=;
 b=a8CZS0sx/X8o9FnGtK3Rt8aO9Prt2RkFL2oVjX1hCRUtxnsqC9RoN8v9eGLmQHQqZpysSU+XqkuX9LYwjG6g+GilySkzKMwYFO/lpcTAlzjsW+m8vpsIvbQwOlrsRRiNW7Qh+Gle6W4KxeGfz7FrDqy6wRVd8LKzQI5mVHmUUDUyO9lkTl/fnJDkjHK5gkvpMwtnXORJSd/vNq7DfAxN+EpkjBjx5vyItHe08oDrrOwk3Cipl7ny3B2Ia2PuZ5+E7+aGg7/4FJUrAQPXibTkFFT9LseLp2sdt69UfQbBzKCTgo7ItWGG5XU2fZAA7GkOmbexVL2ti6GUsiWFR8qiLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCRl16/9wiZ18n8n1k/udUfiW/YzMHEBJA4hYyizW5w=;
 b=OFWReJVyQchnnlW16mpK0BTSwuZWp8z+QB/RIRis36lTHunvG2i6CdXv15o7EmSohyyct/pzI/vveixm+QAFPgsP3abfeCkPn5f6yzBbQVl4Wb5xZG4V/fVgVTc5Z8e/JepYTesiDLFyXD7oMMK2mNObqjLSpb1KV4bU8R0XV910sQzWU5GwAmsk5JIK4nCNKmllonLWf5oH35LyxRKCCzdxj+uwsdpU9wFJ6KAFWikDcZI2S6QRgIKocrmGB6htG8aDXH6f/43Ni+vARsxohg1ZyS/mmc/f3j8NkHiaCXlMqRW03/u4vsB+1Eqg5R7YRb7LpDt3lAgrpSemqoUmGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com (2603:1096:101:2d4::11)
 by KL1PR06MB6649.apcprd06.prod.outlook.com (2603:1096:820:fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 03:08:01 +0000
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b]) by SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b%6]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 03:08:01 +0000
Message-ID: <c80a1b5d-c577-4216-9ebb-00a4cecbdde1@vivo.com>
Date: Thu, 31 Jul 2025 11:07:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/1] genirq/devres: Add dev_err_probe() in
 devm_request_threaded_irq() and devm_request_any_context_irq()
To: Thomas Gleixner <tglx@linutronix.de>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 miquel.raynal@bootlin.com, Jonathan.Cameron@Huawei.com,
 u.kleine-koenig@pengutronix.de, angeg.delregno@collabora.com,
 krzk@kernel.org, a.fatoum@pengutronix.de, frank.li@vivo.com
References: <20250730062554.269151-1-panchuang@vivo.com>
 <20250730062554.269151-2-panchuang@vivo.com>
 <2afd89be-713e-4075-b91b-36ec7fb6072d@wanadoo.fr> <87ms8lio7i.ffs@tglx>
From: PanChuang <panchuang@vivo.com>
In-Reply-To: <87ms8lio7i.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0116.apcprd02.prod.outlook.com
 (2603:1096:4:92::32) To SEYPR06MB8068.apcprd06.prod.outlook.com
 (2603:1096:101:2d4::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB8068:EE_|KL1PR06MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e7c27c3-483a-4d67-4d40-08ddcfdf759c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzBWK25tZjlVT3BISGlYMGNSZm9YWHJSVWI4NlZTTlhPUU1LcHlKTG90N2VX?=
 =?utf-8?B?aWp5MEFZK0g2TUNKQTR3UjdqVmRFREorY0VEVnB4VGFTdERPQ3h3VFVGTERT?=
 =?utf-8?B?QWx3R01UT3QzbHlob2pDS1o4VEhqQnR1TXlDenIwaDY0NnE3QUU0eHRUTjFY?=
 =?utf-8?B?UnU3WkJ5dy8rd3BNRm9kRGZrLzhZWE1lWDU5NDJvRFpKcTNYSmN1dktnWkdj?=
 =?utf-8?B?SVExRWE2M2JGNXUyVzZBdkNMdFF0dVNHN05TbUlSZkRrbUdoS2liVURoU0lo?=
 =?utf-8?B?eXRNNXhTQ3lHbGxmSVYzZjh3cUpVOGFpOHVralNrZXFSLytrRStMSHJxZ1Ft?=
 =?utf-8?B?b20rT2pnWnpOUTNVNHJEa3dLTWlzc1BBa1pvV0RlVVpIRDFQUUVMTHJ1U1Zi?=
 =?utf-8?B?SVFOWkVYYjcxczlpYXYwMXpWcWlsNDZzVmpuK1ByVHNKeExxVkg0dlI2WDBG?=
 =?utf-8?B?SHBiLzFMVXhVZFViVGVlUTRpTUFiQklXUWRsdWNqcFdQMVdrcWl1T21sT1M3?=
 =?utf-8?B?WTRtamM5aWhCWGU4VXN3RlB1UG13QkRPeXZrQ2NFd3lIc01aaDliT3IrSFYr?=
 =?utf-8?B?ZzJ3ZWtjaEdaYk13c29xVkJWOFpIN1VnMmd6UEdnU1kvYW1mdk1KRlhLM2lL?=
 =?utf-8?B?TGpHNXNhMGFuVzFBMG93WWZQSTU4d1B6QW05U3BYU3FiTmJZSkRSOUNDNHRW?=
 =?utf-8?B?MDhEUFpQbTl2R0NMamtoWGN6RytDbk5ZK1p3bTdWakJXdlZqOTQ5ZVFaczly?=
 =?utf-8?B?YXdpQmZKMXhsekFmaXh4aDU4OHU4cCs1bEV0TUxNR2orQS91MmRxQUgwQWNU?=
 =?utf-8?B?d1BoaXJWYWU3alhzUlFJaE1wWlQvbUZDOEZ0WjM1aWxieVYrZVVkcENXRjUr?=
 =?utf-8?B?YktqU0UxREE2RmtPVG1zUDkxMlNpU3FWRlJqOG1ERnVORjl2RzZnVk5JdjVU?=
 =?utf-8?B?eDRiVkF2T0U0bndSS3EvRlBFY3k1c0t4UFhqdUtyVm1WTXJueUI5Y1lMc2x1?=
 =?utf-8?B?RTFqNFdvSUJjRU9hM3lHenk5dlRUSnVOUTNnYWNUY1QxVFVldEluZVFtd1FO?=
 =?utf-8?B?eTNhMTRyayt2TjE1WkU2WGNrOGlSOCs3OCtjdHFkN2plLzJoODdxakt2UWs3?=
 =?utf-8?B?TlpZMkVoNUdDcVNJMCtYazlhdVdDUkc0VFdtRDdPemNjWVRuQnRST1ZzeFlP?=
 =?utf-8?B?TlU5TzNjT09jU0RucW9MUVhsRVphWVpGbHJsSkJMUlh0Z25rZnVqcUc0bWd3?=
 =?utf-8?B?L3RjeUZ1YjZYdzZmdytLRGNoa1hUNDF6Y2FsanZxbDFKbjN0dTZ5YXZMZk8x?=
 =?utf-8?B?M2VvRFE2ZlJJbDFUMnd3Ym5HUjlwK0xnTVp3NGNqdk5TVUFUR2ZDZW94NEEv?=
 =?utf-8?B?ZFZQakZYcmV3V3dTSm4vOWhMZ0ZWaG5uRG1nN2w1NzZRL0JrMHEzN1YzOHNQ?=
 =?utf-8?B?akY2YmJGZ1dOTWFHd2FzbW9WbE9ZUndaY0pPRkNkY1ozZUdJWXFnbXRlbzA0?=
 =?utf-8?B?RXNJSlVLVGZhdFVILzJTWktIMm1KVWhYR1BpTGV2a2RQbHNIbDJzdzVvWmo3?=
 =?utf-8?B?cE51cXh2SzF1Tk1Kc3lvbmpaYVgzZ09hYi9YWDZmVklGalM5Z2FVdFpwSXRp?=
 =?utf-8?B?eTZpT3FOSXkwdEo2bVJ1MmFudjJLQ2FFUGUrbUlSdU1ReXEwUWRLTGVpVC9S?=
 =?utf-8?B?UlRQaVpsWW0zWXl5SnBzVFpjUGlmcEJXN2l5Rkc2aVVTcHpqcmcvVVpJU0RQ?=
 =?utf-8?B?eVRyRWxaUTM5MEJ5a1luMVNCZ1lqYzhLdDNuWDVYYWpORlJZaE5FNDdYSlhF?=
 =?utf-8?B?cXdaTEM2Y1VVakZwWmJaaGl1U241VmVwSTc2RnFTa2llOFVKQVVPd2xxS253?=
 =?utf-8?B?RHlCYTd6bEQ2RzlYRVJUZUlUbVVmSEk0OWhGVVg4amY1RVZiOTg5bEc2K0FE?=
 =?utf-8?Q?i/cw8Rh9WbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB8068.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVhUbzMrQVc1em1TdVVkMEFhUTFYaWQ0a21zQXF3MzZiUkZEMzFCbXRSRkJE?=
 =?utf-8?B?a0FncTBtVy9EbnVBN3FGR0FyRWRuZDBEVWhwU0dMZ0dxMUIzdGFPOGJ6K0cy?=
 =?utf-8?B?VWdNbzNUVzNHZFRqZFAwcUN3OUxISlZEbktWaUcwYnBrZGtBeXVjSmgvU1FY?=
 =?utf-8?B?d3BqOWFyWWFEamVFdEZhaWl3UEVSK1dtU203Z0JDaFNCMmlTdW1KdG9MN3N2?=
 =?utf-8?B?V3VGQXVKOEpFSVR6YVZnTFdMS2xRQnBvUHdrS051dSsvZlRyT2Z2VWZISXdh?=
 =?utf-8?B?a05idS8yMktGY1JhZEZGa1dKVXBLUE5RU2FDVnliaS8wYmFaY2Jvb01aTjlH?=
 =?utf-8?B?dlB4VkxnVStVenkwbjRWQmJOajYvQktYTzgxbmlHZ3NXTEw4VFQwWFQySFht?=
 =?utf-8?B?Sk1QRnhjRzNoZ1hTazhmWUNoWEsweE95YkEwVTVSejZ6RHFHVHNKWWM5L05Q?=
 =?utf-8?B?SGxSSTRzVnpZa1dyTXlEVVROcnFWNHljczNic21rSld2LzZnL0ovTTBweTNz?=
 =?utf-8?B?a2QxZVAwS1JQc3BnZFMwcklFd1ZWWEI0Z2ZtQXE4ajNzSTdxU205SGxTS08v?=
 =?utf-8?B?b3pMODMrOUFlZGgxMDJ6T0xMK1pXbHVhWWNCcmRSdkdFODRDNW96cC9rNnF6?=
 =?utf-8?B?dWJmdEhxUmd4TlNQWjNMWDl0OXdLWE8wVUtxWTEzcURET2hXM0xCcEVNS2N6?=
 =?utf-8?B?dWlRR2g5VEJ6bVFGSXg1T0tHRGZiam5mQ3JlTUhFVUFrWG0xTzc0YmFLS2NS?=
 =?utf-8?B?YjFBaGcxazIzT1pqTCsvdTZOektMSTNZNTRGY1U1c29HL080NktBd3dQdjBn?=
 =?utf-8?B?N2h1aEVGUm95dTUvMFRxTzZsL2tvMC9kamRPSmwrUnkxMjA2R1Y4amRRT0VO?=
 =?utf-8?B?VTF2M2p5cnJOQzd4My9wbnVBMGtkcHFOVUNwYzE5ckRYVEJuYVJjcWV4MFZy?=
 =?utf-8?B?ZmZMRUkybHBZVnFWOUQwNGMydUFyNEVnNHRJUjZLYy80d3k3V3lyZlZHUU8r?=
 =?utf-8?B?MkxWWGxZckxZMkcyTTFDOGNVL25vRnpZbTdEMlRzdk1tMEY4Mnk2dUw1MDE4?=
 =?utf-8?B?QUh3U3o0TXAraWlFRGZwNENlTC9kZTdTQVFFaC94WU10dVRFallrTTdNOGhO?=
 =?utf-8?B?L2pvVUp2SjhlclU3V3BJTkI5Qk1KcG8xa1F0bVA2b0Z2QTQyUDdURGllMTFU?=
 =?utf-8?B?RTZCU2JlZFBObEhpQVlzSHJMS2tlMTdTdjBObFRtOER5UTZlNDBLanVMbmhQ?=
 =?utf-8?B?TlRLOGxQM1ZPREFZamwvQUwraVJtbjQrUUVjMFFJWUZXZkJKTlJ1S3hoUVZp?=
 =?utf-8?B?ZE9zNjZlK2tBNDFud1Z2aW5hRlFCZldsSVVhS2JtMWtoTWJFZVJPMERZdXRh?=
 =?utf-8?B?bWpNSjgxMHhUclVxMmo3bUd3NmZSK0g4L0k2T242WEo2NEM0T2kwUU41aUFF?=
 =?utf-8?B?NWVRc0daTUZ2aytndVZLdkozM2wxWnA4dGk1LzNZMzM0S0J4UzlhRkplbE5i?=
 =?utf-8?B?ZHdZQlA5dFI4aDd3TnQzL0tIeU9hTWw5V25YNmhSbEdVUS9leW93Sm1ETGsy?=
 =?utf-8?B?ZVNYakdmSkJYWDM0UHR5WWZUbWNSNE9tSHRzTmZpdGlRTnFFS3pocVZITEp0?=
 =?utf-8?B?ZnF2ZVpiMVVVMnlxMGdOc05MWXRKVWliQ2YyRXpGaUNhbnBSRCs3TGI3RUxk?=
 =?utf-8?B?Vk5KRkdRejVEaVY1MDNmRlFtRzF0cCtrbkNWU0wzYmdENkFFTTVYWDk2OUQ5?=
 =?utf-8?B?cVJFckRHNmxoeTllb2h1QXNnQUxSZ1dlRU9idlJ6NUtLbFladDdkc01FUzJh?=
 =?utf-8?B?WXcwNldFYU51UnBKVU4vNklEWTNpRzA3TlNPeHNhdTFXbmJYalRKOVFXaTVG?=
 =?utf-8?B?LzNhYno2dDhrRGVEVXBLK0RUZ0JyVDlXbEVaSVFXUHZ2cXNJZGcvY2RQNENt?=
 =?utf-8?B?NU92aUhXQ2pHTnJUaE5mVFhtYVg3WVBrTUNnMWs0aWdENm1ZZmt6azl4NEhW?=
 =?utf-8?B?TzVKZGRHSExsR1RidlE0SG1aODBTSGljcUxCR1BpTThac2JTR3Q4Y2loZExI?=
 =?utf-8?B?ekpkRitiWVBpdHhEbitQL2hyNUZ3TWVPdWZacjVvSWlDWVdENUtnTFcyRUt4?=
 =?utf-8?Q?dx7Zfk/QC/ax4Vne33szuo3rM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7c27c3-483a-4d67-4d40-08ddcfdf759c
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB8068.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 03:08:01.5503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tO4+ykeDw+1Hpd1fmJXUrET1sS1DTUgq1K0ZAO8qqJt5XNMRa2z0ZO0/C87ofDufcTcYwZu86BghV5IG921LNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6649

Hi, tglx

在 2025/7/31 1:27, Thomas Gleixner 写道:
>>   From my PoV, it would look more logical to have the same logic in
>> devm_request_threaded_irq() and in devm_request_any_context_irq().
> As they print the same thing the right thing to do is:
>
>          int rc = __devm_request_any_context_irq(....);
>
>          return devm_request_result(dev, rc, irq, handler, NULL, devname);
>
> and in devm_request_threaded_irq() invoke it with:
>
>          return devm_request_result(dev, rc, irq, handler, thread_fn, devname);
>
> and let that function return rc if (rc >= 0), which handles both cases.

Could you please confirm if this implementation aligns with your vision?

I'm happy to refine it further based on your guidance.

 >        int rc = __devm_request_any_context_irq(dev, irq, handler, 
irqflags,
 >                                                devname, dev_id);
 >-       if (rc < 0) {
 >-               return dev_err_probe(dev, rc, "request_irq(%u) %ps %s\n",
 >-                                    irq, handler, devname ? : "");
 >-       }
 >+       if (rc >= 0)
 >+               return rc;
 >
 >-       return rc;
 >+       return dev_err_probe(dev, rc, "request_irq(%u) %ps %s\n",
 >+                            irq, handler, devname ? : "");
  >}


Thanks,

     Pan Chuang


