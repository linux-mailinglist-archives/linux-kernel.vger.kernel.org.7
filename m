Return-Path: <linux-kernel+bounces-753249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A8DB18095
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A684A84A84
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6A123D28E;
	Fri,  1 Aug 2025 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JpvLK1eU"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013045.outbound.protection.outlook.com [40.107.44.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAEA238D57;
	Fri,  1 Aug 2025 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046037; cv=fail; b=E+tTFCHC72qnhfZJRik9UO01trNtPBaMvcNhvl8Pj00pv7Wse3NSHnYj2G3FxaIL60D4DQYLibdC2ovZZomdwZYURfCWn2vTFRYPUGQeRHYn0tmsiiKBIH1MwYeoBtTGNSlyXVesFI7CRHvvZlSDKkmSRb5HtwPT6+noWaqbYAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046037; c=relaxed/simple;
	bh=kWck44UnO2VQSgVqnIHEj8zOPfjKMaTJObHUVbSy70g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I4v/6dEbM91xcnrjUsYgmpbLGBVJVE9f+77KYIUSmdCsOBgHj+jviVhfWGsimavLJcDaKFf7X5kQ/xaAQjp6+95S/jYl5cOymafQByY0DlcD218xzWravtq57TBwo1wLV31PjfrthqSZIWPoO3cDmxMxR8M8chKBtk+IpykRcCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JpvLK1eU; arc=fail smtp.client-ip=40.107.44.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNR/Toj8bCDLszfILChT9E6GWynH6JAAPIkWGgHck3w/ykxfiipCziNW/bEfoiHjaLY0o0FkCJXTKrfZvZ7xRfjcP/dyQH4kNy1BnKa7N7F5f4skHvCUOF7xZGhQwCyevxaizLhFZvhjaRm65gWCYWWn78kB/346xZAgzlzzj0cU/v+KkmSl2QPo0bDFDX0+PieRauOvd0KhFzc4r8I73YJW7Io3teOXi1LnmY6cQ4NyFGHGyQEYStmfVxEoY/V+LBeluEhIPaT3jbbxP1Ekvoa6Xq2NiiEqycP90c3RR7RZ4wHen0i0uRzH/1cDAkGyQD6CFbxKsCuXH4UHTXw5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8SlOt+i2MBAS9LSEMdIgEMYCDy3fDvAFG4xR586DFE=;
 b=cGr9VL2vi4KvzzkVwmNgMOPfzpucKDBQaAt72YO+Vg18QMT/C5NdqlLbPvB1SIpgWgSlyid+E0ZSQx8mGC5bYBj1EEQvkOSvlyOX7fXCsL4XzuxLNEW47QQ8E02xBdjZ1vlEWiAvJNY7rZFM6/D8kMND84Jh14nV0afWTDe7r6Omis7Ag/RzFSuOqDq0WJBcAf30JrL9PtFwmG4BOaJrMHmrJ5jW42j0M+mD17wyDP4azLyB8q7kiKHqdjKxHyXnW9HekUf2jSyRKXndlwUtlkWBKjPQiuTL7Ln/iK01NG6U9701eRYR+N7E6btB5LhC6WQ2ylKg1gVhoTX/74+sQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8SlOt+i2MBAS9LSEMdIgEMYCDy3fDvAFG4xR586DFE=;
 b=JpvLK1eUcmnmTvG2DSHTvBsVw+teVMWGPD6ow/mZaj19yw+ZcDw0yOGAPP9SKkE82eihMIf0nMaJmZptqCJA1VZRJfNtveiyT8iY0BZ+QXQfwWdve6FSNx3pXATx2qQrcoxhbzkAYd5906gbAdoBsjbl+XODtPd5z4LtLbNIyvNB2BsDOqmBUhcFesSQvAEMkOBMsclV+PjqHu1Qd6ygUvTDkm5AQ/vitqh8CRDosDdir2qDIogXYXUM9HzqDp3QPiZqx47NpghMmK/1LawX9BWd893QsAQfVn8RBGD25ESqPXFZMAS8bddwYqaRx0YhafRFLR5TkUfpTg6c1L165Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYPPR06MB8052.apcprd06.prod.outlook.com (2603:1096:405:31a::12)
 by TYZPR06MB5805.apcprd06.prod.outlook.com (2603:1096:400:26a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.15; Fri, 1 Aug
 2025 11:00:32 +0000
Received: from TYPPR06MB8052.apcprd06.prod.outlook.com
 ([fe80::5cf4:4746:d56a:157c]) by TYPPR06MB8052.apcprd06.prod.outlook.com
 ([fe80::5cf4:4746:d56a:157c%6]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 11:00:31 +0000
Message-ID: <e719b8bf-804f-41e4-93bb-1d54fc6721cc@vivo.com>
Date: Fri, 1 Aug 2025 19:00:27 +0800
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
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To TYPPR06MB8052.apcprd06.prod.outlook.com (2603:1096:405:31a::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYPPR06MB8052:EE_|TYZPR06MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 300fd684-069a-4705-f199-08ddd0eaa1fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NSswY2h1dEQyc2hhK3NRc3VzaHlQejlveDBpSWVnbkh2VHc1ZHhZdXdoVW9C?=
 =?utf-8?B?dzRuMmZzUkFNejFXb1RTZm55UkJXc3pJUmpEcHdnQkQ0S1NHZ3pRZmdJNXpS?=
 =?utf-8?B?VmVzbU1rcnVWZ045Qzlqa1Nkbk1sbnJINU9lSG41TS9iU3g1cnU5dWFORC9S?=
 =?utf-8?B?ak1GK1EzYVRrUmlJTklKS1hhRXdOcXZkQWpBbElFYTJBZG1UbjN4MUwySVBH?=
 =?utf-8?B?emFTWU5kLytqbGhrNEx4MGpJUVRWY2JQcUtYVndUTTBScGpLSldjUUxDZktM?=
 =?utf-8?B?S01kbEVUZCtRRW56UmNPSWJVZXRnOC9aeXIxZnEzVUV6aFhoYnRPUHNSMHBo?=
 =?utf-8?B?TTB5VFVHVzF1UVk2YUpLam16UlkwQ1lZWVZvVUtFck5rUEtuZkxaQXU4VHYy?=
 =?utf-8?B?aVYrcjNJNjZ1V0QzSDlRWnl6QWIvak1ldyt5MjNDVVdXVjJZSndmOTZDRXlU?=
 =?utf-8?B?Wk1jUUc4TE9jamV3Yjh2c0RqbkRjSDIwbFF0ZUhBM0xlMWduSWtHeVZSRlVF?=
 =?utf-8?B?OHpMcEEvUTVvY2IzTitkVTFqM2VVcmN5UXBldEdOeUNKaVR0QUh3T1hsUC9P?=
 =?utf-8?B?dDE4UUJkMFNPSmhObnZQYTg2Q2cwSERHVHI2eDh5TFZzeW0zM1FXOFlxVlRh?=
 =?utf-8?B?eWwrc25UNHc1OWVJY1FpblJPYVlsSTk0aC9kUjBRbDJkMHcyYm9yYjVuRERL?=
 =?utf-8?B?LzBQTUlCY1phRVN3ZkozdThaUVZXZ01JaUhzeWpQa2ZJeG9yNTZLUHhxV0Ro?=
 =?utf-8?B?RTBHekxNWXlITGQrWlAzVnMrRmd1bDJxbEhraFRUcWlGSzQwNElQZFdSZWxU?=
 =?utf-8?B?ZEcrdDNqOWtaMk41Y0JCQU5xMlNjZmliTEs4bE81WGtUZlcvc3NUMzdLN3JH?=
 =?utf-8?B?UzMxUThFUzl6T01lK3pRdE1TdEdxdElrejdxMVVSRGFuR0tMbVlsdUEyWGkr?=
 =?utf-8?B?NG1CUk0ybkpldGVBY1Q2VHNMbExBZkJYZEgxOWE4bFdJWDF6aUloTFJ3NFBY?=
 =?utf-8?B?eThMK1F6TXh6RU9YbUhIb2RZUHBmWnlnLzYvZ3gyN3dFOW54bjQvaFBYakw3?=
 =?utf-8?B?V096SFlNQXZlN1UyVnRUb2NzSk1hYlYvS0hLemtiUFp6Q2d3RTJ1czd4SDJl?=
 =?utf-8?B?UzM1eVI5Ykk5Q0h3RVU0Nk5TT0V1RlZiVmQzbG1FS3pYNHpsQTJEazFvVytu?=
 =?utf-8?B?N29sNUh5Yk53TnlGQlU1Qzk3RVBCQ3NuWk1HZHNMdW9mWjRjSGVjb2grT0t0?=
 =?utf-8?B?bk1RUkJzMnBaYlVkRXJqYWY5RjRwUndhVTFMQkZKckxIWDBIQzZUZ1hXY0NH?=
 =?utf-8?B?MzAyeFlWU0NkWnpCTGYyUkROTjVYNDRad1U2c2tMekRodkRLU2d2M2lWRUxT?=
 =?utf-8?B?RWZzbXFsUzlXRmZxSWRsTXNLRGNEcnRUSXpBUThMdTZhOEQzVytaKzNvcjcy?=
 =?utf-8?B?T0J2TEdRUjlMOU8veVFtRlhwVTFycTUxRDJPRVJCelVJdytVZmp5TmtZVXpB?=
 =?utf-8?B?ZG9jaUJ0OVBKeWtmZys1VDdYQW90ZFBqd3g1cUVhOGhHR1ZjS3ZIeklvUmZL?=
 =?utf-8?B?SjFCbXNZd3V6M0N5eE1xYjkvMmZvY0VORVNKOU01R1E1VmFwcDk4clMrV1lF?=
 =?utf-8?B?VEdxM2ZENkk3WkswSVA2d25DeU4rUWlNRkQzanlzd2ZRYS9ZeWRYQ2gyR0RH?=
 =?utf-8?B?SktPWkd2MmxLZlhLb2Q4OEh0RmVsbGQ0WVZzblhseHhTUHc0YjloQnhrUjJU?=
 =?utf-8?B?eGozWHEyRVcrYVFxOXF2bkU2NmlyZ0NnMnhicGlsUFduVzdHdHZURnFQQlpF?=
 =?utf-8?B?VXdoZm40anZrZU5sN2dMaG5wRlUxRkZnaFRxU1JTT0xpd2NkT0pqTDZJUTFF?=
 =?utf-8?B?aXhKRGtVZVh6R3JNSThkZW5sVTlvamIzazBPRTVmTXdSckE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYPPR06MB8052.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0FRTituSEoxWDd5cWhaa2FZSTlpMVdNWjRHaGplSEhaQnVaR1pZam9TSU96?=
 =?utf-8?B?bnUzL2JrM1BYTWF5Y3RxQzZsU2h5U3dPNzVrNEVxZjl0RWcrd1hOZ3ZhdUdj?=
 =?utf-8?B?YURGOXlmYzBXUGdRNHNtTnZqd3ovT2NqTEZUV1FSUFlHZGJQSjBJZmxFYmlH?=
 =?utf-8?B?aHZxcmxtVVZFaXJMU2xSZHpvTk1LYUMxaWpNTFlBUTVwWkIzU1Nnd1h2UGl4?=
 =?utf-8?B?UDNpeE1sRnZsNWZuUm93cVB5SU9GR2J3SytVSXU4Qmx2ekFGQUVuSTVyVnE5?=
 =?utf-8?B?cVI3T0Nwb2Q5QlZvTDNWQ0tjcWx3SkYzek5BSDhOdFVHaUo3Qm02aHRCTi9G?=
 =?utf-8?B?RWljUy8wWG1OZWVIRTVRVzhHNCtKSXlUcWNnSGp5K3Vjc3h5UzNpZnBoSDZO?=
 =?utf-8?B?VUhWZUxkRFJ5NlBTYzFPMHJEUWd6VFBOSm0wakpxejQvUzFLZFN6a09DKzMr?=
 =?utf-8?B?bGVsMDBDQit4b252WlNJQzVJSy9TelBKT2FwanFud1NpSXVFVXZOTXhNQm91?=
 =?utf-8?B?OTczbmJjbzQvQ29nRVgrdjVsTzM5VnpQeWo2NXhCVE9ML0Y0K3ovbXR5V3l3?=
 =?utf-8?B?LzVrdFpkYm0xWXNHSXgwenVKNjhrZS9hSHlEZS9QK0dsZ2x5Tit2U1g3Y0VF?=
 =?utf-8?B?ejhDK09zR09aaW1Nelo3NXZEdzI5ZWRCREdpZDB6Tk9uRW4yRjlRMnlGUmR1?=
 =?utf-8?B?MFVWaVp2bHlDUjIxNjA0cjR0SEZTRkhDYTFBWnNnNmtOSG9YY3A2MkVXZEF5?=
 =?utf-8?B?R21QODVLWE9HYlRGQmJIOWJ2OHZpc0tTYUNoZlVvL1Bma3JwVjljOEQ1U0wz?=
 =?utf-8?B?SmJsRGhmNWhDSEd6S01HSkFIKzhtMGp5VmdMM0FCZDkrNUNMVFJFeHNmY2cr?=
 =?utf-8?B?bE16dHZhdXNiTFlVMjh6UlRwcHROVFdid05UdUFMaXNtZGFrR2xLUUdPYVVp?=
 =?utf-8?B?M0NzaTQrdHkzNk5ZZnphOURuZlY5amVyR3Zsc0ZlSU9mZ3NaWDJMOFZhNnow?=
 =?utf-8?B?M0U2UFJWY21NNGlVcDI2T0dxUzRVeXVzSFJaSlBNTnlTUm82elpxYk1rMmNJ?=
 =?utf-8?B?aytrUzdmb3NvY3lTbU9vRHJ3dVVhakxkSmFsZm1mK0hWbnEyT3ZBcVNPeXYr?=
 =?utf-8?B?RXJ2MWtvOVZxb0M4amJKQlRzRTRPSEZLKzZoYjJ2YVFka2M2UmwyOUxsc1Mz?=
 =?utf-8?B?R2JBZnVrNHVHaUpFYTBiRXBUNTlIdnQ3YTBnUWs5VWh0Zy9IMXZKNENLcUxC?=
 =?utf-8?B?L1BzWnRmZnRXZU9XempQTmh1WWhYbjQzWWZiRHVaR2lFMkFtMTlMdUZJLzht?=
 =?utf-8?B?TFpvTGdPeU1MZEVHcEl6bzYrZThteExDaGFVUzAzZ1gwakM4ZFQ4Vm1SYUho?=
 =?utf-8?B?bEVXd0M3Q25OQ3hnOWl1Kys4eHlVSWI3Rm5paStwandPSngzNzh2V1ovTGh0?=
 =?utf-8?B?eHdLNll4bG1Wbk5lKzVYZWpLaFh1UzJBcExuKzFRTW16S1ZSNzYrdXliRXJH?=
 =?utf-8?B?aCtiZWpuUmJ1Um4vMS9tRjlqSGN3NkJDTnRjTkgvdStXWXBqaEtHdWk3L2Vz?=
 =?utf-8?B?U1lZRWdPZWl2UTRCZUlPcS9XZXFxZVJsaTlmSjRFc0VsRjd5bVRZWkJDdkhi?=
 =?utf-8?B?RE9QQVZBNjBxZnJCYmRZMWtEQkZTdWkyaHQ3QlNheTl1TCtTdy96YnV3bGlq?=
 =?utf-8?B?ZDM2a2dqMDhCdFRZTG1pL1hzNFQ2c1kzdkFWWldkNEtEZXFqWVV4SkY4aEVG?=
 =?utf-8?B?VytSMElKc3ZQQjdIdGtsVDB2V25RT0YzRTJRRDVCTXF3WldNams4Ky9POVox?=
 =?utf-8?B?NHpOVFBGcS9YN0pIMUlCUG03TUs1ZzdHTnVwdUxYblRSUlc3VTdxb2lQVnBD?=
 =?utf-8?B?OVY5V3JUM3RyeThOaVk4ZHk4cGFUaFI3YloySFZ0Mks3MmNLL0pLK0lSQkx4?=
 =?utf-8?B?SEwxenZ1d1dSR0pLVkQ5NDhENERSQ1QvMWhLUGFIcWM4cFpBaTQzVytaTjJW?=
 =?utf-8?B?NzVjT0lhWGcxWjJwRlpBUnV1eUc3U1JXUUt0U3ZXdS9LZ1NGUHFYZVNaNTQ5?=
 =?utf-8?B?RzRjOFJDQno1bWh0cGlHSis2VUY2RWU0Mm84cnlXdis3RnBGcHMzaUg2QlJT?=
 =?utf-8?Q?hr+umkt/c8qfx/IuMBWrAtJly?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300fd684-069a-4705-f199-08ddd0eaa1fe
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8052.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 11:00:31.8285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqBagTTEKsB1wfjYOr5esHvKA0FTop339eKMZlyjqGi5yNh6Lq/4LKWQVK3q/neUgK1iDFPfsgaZD4iQ5je8JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5805

Hi, tglx

在 2025/7/31 1:27, Thomas Gleixner 写道:
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

Or do you mean that we should add a new API devm_request_result() as 
follows:

static int devm_request_result(struct device *dev, int rc, unsigned int 
irq, irq_handler_t handler, irq_handler_t thread_fn, const char 
*devname) { if (rc >= 0) return rc; return dev_err_probe(dev, rc, 
"request_irq(%u) %ps %ps %s\n", irq, handler, thread_fn, devname ? : ""); }

And this function is called by devm_request_any_context_irq() and 
devm_request_thread_irq().

I'm concerned that when we call devm_request_any_context_irq(), it 
always logs a NULL parameter (thread_fn)."

I would appreciate your guidance on this issue.

Thanks,

Pan Chuang



