Return-Path: <linux-kernel+bounces-799456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34EDB42C08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2623B726B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA4E2EB861;
	Wed,  3 Sep 2025 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="TAzaVAoh"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2127.outbound.protection.outlook.com [40.107.237.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16829287518
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935538; cv=fail; b=e5GfMaamLydo6zs8k9O2lg/NNb/9K/pMgxB6RWmoKWovgOZxKj2qthJ8omNyhRGNK/a4cwikAQ4+LpraRseysVt3JfoqclJwHpfocwAKmoWGEjqxRjGrLfBmlf53O6bKEBdhRLocxO90cFKbQ88l54U1560naynbLmAR6jVFEhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935538; c=relaxed/simple;
	bh=l+gXJEGZmdrF6HxkI19ke87CfryETPcOnJkVlR/A+5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gXCnUeqeacqADVN/pRyEksw9MU8a76nNV0T6ktEZ/5UBZ7Vh8dW7rTAB5UWWQgJEs1+j+QkXxcx6PoHNClf6VPWmjCttnDTyOIIzv0q0uqU6DxBv5rzIjAQ7IAIyjYGM0J9mPlinF5lQCTpVnbX8Ini5mEslSzP37rFOhwjq2c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=TAzaVAoh; arc=fail smtp.client-ip=40.107.237.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNbELYRg6MmSierK8wCoCc3UGVQAyiObvCImByhALu3Z4J7m4TEo+YRJU4lJ9I7L1Qb9Q7mgVXKTa8zLQTbnLW8/KrHJu/gmumObjZA0XvCiPLVnm5U/lBmhdgQFRz/FFv2p0ZWfxHG3mQsk/RFxWEYMDBlycXMjgUIK7AGhZH6Pvk1xtl/okFrt3Oi3g3aRFU7geTw9NlW8LESbmPMAxPaovTXZTNXT4JTqHqcY0UDHbu3PKjVLJs8oP8kQN1D/lSVT7fv5ruFlSOjAm4xWdD033Cq90IC8Ot2UKkumILTPOhOf570M8xeZ/H4jmTW52B+SIdQmn+zH/WDmGiJzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7GokxwbOlGyjsbY6T5hl1QcIglm1ALtBaQhk3TZ5Bc=;
 b=NBPp/JIEm1Mm5XCbkDK4SmoixUrKariKsNIQCZPw4OX2ABby5WVJEBHvOtmZJ5/q6g+S4Ql4jpG9WbBZDkAZ8r+3e3tkV5mvjGNQsOJSQSkhkf3qvzG7G8GvPEXtOSs2UIW1Rz84e2j/8YT8sYRzcQTplxLN6dkdzfGQzvjWXdUVOs2axuwOmCyVKqs+Kkl9BPhOmJOUd3syqaB9Q5cvqsIFfSQGYud+/QcW+ss+eZ+g6a9GRqURqqP6JMZ9uPlCVKokGEmSUW3tW8gKJeXLdNWCgzynBse8ThDVNnG8Xi2Lai14VzofbiDo4hWJ/jdeCoE6csnTP4jkkXy517dfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7GokxwbOlGyjsbY6T5hl1QcIglm1ALtBaQhk3TZ5Bc=;
 b=TAzaVAohK6fr6zPgtoqevIMjilnw/M9rVZ+gTYdu+3jvpVa3sydchgBhWPz86E/lP7G6cULh6HYrAbg/S/tKYBsJplArT7BUkx9Nk/8xQQvTJ8v1+AkSSWY45f94nm2rFB2U+AucO7+3qAhLQKP8wURNeAocmR2bURIVT9hBPrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8179.prod.exchangelabs.com (2603:10b6:806:330::14) by
 CH8PR01MB9456.prod.exchangelabs.com (2603:10b6:610:275::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Wed, 3 Sep 2025 21:38:51 +0000
Received: from SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::8e54:8037:e941:a539]) by SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::8e54:8037:e941:a539%6]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 21:38:51 +0000
Message-ID: <cc8000c0-e457-4bfc-94de-aeeddacab23b@os.amperecomputing.com>
Date: Wed, 3 Sep 2025 17:38:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: smccc: Fix Arm SMCCC SOC_ID name call
To: Sudeep Holla <sudeep.holla@arm.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250902172053.304911-1-andre.przywara@arm.com>
 <20250903-great-savvy-bloodhound-38c1ca@sudeepholla>
 <20250903-loutish-orangutan-of-experience-3dcfda@sudeepholla>
Content-Language: en-US
From: Paul Benoit <paul@os.amperecomputing.com>
In-Reply-To: <20250903-loutish-orangutan-of-experience-3dcfda@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::20) To SA1PR01MB8179.prod.exchangelabs.com
 (2603:10b6:806:330::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8179:EE_|CH8PR01MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbbc7f6-e7fe-48b2-6fd0-08ddeb3245a9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW50eWV3OTBrVHpjdE5lYkpaS1ZvMU56MW9nWGVlajlITEo5dTdIckFUS2JJ?=
 =?utf-8?B?Zitjb0tqSVo0by9GWEgrTlJuRjZNcHc3NkNFQ3VVbVErZkFzdDZXdDlnMlNi?=
 =?utf-8?B?TzMrV3IxNE1sZTVJSXpDZnpDaFdFaXpTY2JDaUt6cDJSblUwOCsvUS9rb1dx?=
 =?utf-8?B?ZUlGRmhGRWJVWUVNNzdMNmVoWk1QbGVyWVNxelNvVjVGQUNnMTZQNEJaZ0xO?=
 =?utf-8?B?Q3JsWWZPNXUwZXExMVF4Tjlia1plTk0vQ2ZLdjFNd0ljS0l4QVNnaUFZZFlU?=
 =?utf-8?B?dmFKVmhIdC9TbHZmdmU5Qk1LRkhCdHZsa09JYXlFQU1rTDFKTGJxdmhzR2ZI?=
 =?utf-8?B?Q0ZEVlRCYUx6UWJBc0dHZXlSbzBkMzlOQ1JhbkVOTllaN2UrZ0NHR1FOTmdx?=
 =?utf-8?B?cmhpWUI2UHc2SGxPTDBsdkV1SVd2TEhYUUdOQ2NSUHpmbG53WDZHYjNpQVlq?=
 =?utf-8?B?NldZSTlLUHA2NitZUVIyYW1jZW4vN2VCTDdudFRlcCtHdE52S2g3bmt0T013?=
 =?utf-8?B?ZUJoSlNGWS9mRnF1UHhwazhHeHl6R3Y4REEycTBTQVNWRDdWS3Z6cE9OdDI0?=
 =?utf-8?B?bzdqSWdPbjhLcG9DbVR5YTFxN2tpaDQ1YzBkVWFYcmJEaGZPeWtEK2dramxH?=
 =?utf-8?B?TUVqQTZQZzBEUkY3N1c5TVZkNmZHeWZmVFlqaVBNWjVhd2xFbkxvK3dhNXI3?=
 =?utf-8?B?ZTdkT0xxK0JRaVBRL081S1ZZRVd0b2Y4Nm5sWDhERDJva1Vvd25BWGtSWjNI?=
 =?utf-8?B?bHhWRTBPZ1MzTDdrOHlzakpVZFJpR1VFUTFGYnhwOGYrRlFadi9GbW5Xd1Ry?=
 =?utf-8?B?NzByY0RhTEJSaUdkcHF3Y21BZC9SN3RDQThQRitCWHVwcXQ4cnBxVkZ2dWJ6?=
 =?utf-8?B?aCtDejR0bS9jaWVpNHhzMURSWEMrZ3lHWVppeStTK2RhNDFqcTFxWjV4eDB4?=
 =?utf-8?B?ZHlUaXRJd1hPOEJ0eFhzVURITHpBS1pIN2VVQzFDV2JpWVVoRUd5aEVtbStN?=
 =?utf-8?B?b2RSWUFQS0dkZURoRWJ3RXZPSU81SjdPQnE5Vno0RjRaRThYL0VhTy9KRTJ5?=
 =?utf-8?B?OE43bW5UaWQxbjJFZUI0NWdJVVRFb2lVREZ2UnU2M01VcDh1ZnhyUG13NFV4?=
 =?utf-8?B?Q0I4TmR1NTZnSjh5cnZKbzkzSzBrVFRGeWozMS9raGlMcmNPQU0za0ZuQmdo?=
 =?utf-8?B?U1JJeDhwb3FZa2s4VGxLeW5lQ3pSa1pZZ1N6Y08rRWI0QUMrVVZ1bXg1cFNR?=
 =?utf-8?B?ZDJ5VHVXTkJIWmNHeldkUmw5bTZpTHdJRUZxcjBWbXVaYjEzTFY0Mm9TVmIx?=
 =?utf-8?B?bGU4cmozSFF0RHVEVjFrb0JkcVN2U2dMVVVIcEpRcWVMTGVtN2VOaVdzN3dL?=
 =?utf-8?B?ZzMwckFSQ1ZMMU1ZcGZibFVpQUNtM2M2T0VWTDF1elhQNTRqeEFOUzkySmJm?=
 =?utf-8?B?NEw4YVN3REpIcElLWUJQeHp0K3ZUWVhyQ25xbkhUam5wSUJsbjh4RGlTNVBy?=
 =?utf-8?B?dzVwZ2pIczdncGtlUkNwdjdJRk4vQ05oT3ZTSlc1eWludnZlaDdCSVYyK25l?=
 =?utf-8?B?U2tVVURvbzVLSXVGZlA1Rno1alkxY0lnUi9UOG1TbDJhTmhXb1FXb2VxZm5x?=
 =?utf-8?B?MGhVWm5uNnlSM2RTMXo0VUdUck9sZUZVd3BURHB2Ky96OEpxL29UQUxmcFNM?=
 =?utf-8?B?eEpJUDY1R1JtbzJDUFErUndldW5KSGRNS3JKRnpLT0RyWU5PSGg2cmNMZS84?=
 =?utf-8?B?SjV2bUNOdmFOV3EzVW5ITHZOVXpZYjdCSXFSRmd4dnlIN3dveFQvc2d1blFQ?=
 =?utf-8?B?RjJHTE9KdDBwVVp4dEEwY08xRE9xbXVRVE5sMlZDbk1CMXdXRis3NnQyWmJv?=
 =?utf-8?B?RitMZnloeVFKZGZnbDJuVDB6VHBDMkFCSU9Jekg3VENPTW9KeHcwMEU2dWI5?=
 =?utf-8?B?bE83UVdzbTNhNUFzeHU5SGRFWExiVjZ6aGNRRTBJV1hEQVpkb2hUbGt4R1FU?=
 =?utf-8?B?MU12eHdMV013PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8179.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUJBUzlFblJkMmVVQ1RDOWJTcXQ2ekM4MFdOVmZuZ0xXR2RjTDkwSG55Ykx4?=
 =?utf-8?B?cEg0ZUVCOVViek1mZWQzWGNGTlBYRXRLVzlTNE5FSkp2Kzd1cjljQW1HZFo1?=
 =?utf-8?B?b2hacTdOa3ZUT3J0bDRwMWd2cE8vakVteTJJbmFhVVZWcDRlZEZ3TVVNL1pn?=
 =?utf-8?B?ZFNyemJ2TVQ0VGN5RXhyMTh5ZS9UbDNXNHFRTVg4WkNPRGF1c0FWWUxTMno3?=
 =?utf-8?B?UWFNaTh4NnQrc3FnM04zb1ZHVEdzeDMwd2VwQ054TGtlODlFOXQvM3BTRyti?=
 =?utf-8?B?VFdrcWZhTDU3ZTU0TXZzM3hYYVA4cjFhRDlEbEZCOWdFZnhFV2dWWEpycXVM?=
 =?utf-8?B?a3lMYUl4ZkhRWkJPVW84aDNxODhiOVdjaFRXUEs0WS9aZTZRS1pQK1JNZ2lh?=
 =?utf-8?B?NHp2YTZSZEgxa3duMjBTMDQwVzhCOFZXNGdwVHlEVkFpQS9Ua1hQYlI0OGMz?=
 =?utf-8?B?Y01IeHhsenA1VWlHSUdPWEtXaXlaNzlFU3RUWW1CVEtiNlYwL1BGamRqTUYv?=
 =?utf-8?B?c01BSWxGN0lHZzhobUJqWDFYeWJjSVByQmRoTlNqY0dtZGNCU1pvNU9LYWFp?=
 =?utf-8?B?eFNqZkZCMnJ6dzhqaXpNRThQQ0VCWEpKTFNHWEQ5d3R1ZW00U3AwM2R4Z3pl?=
 =?utf-8?B?M0l1TGVUZ0IxajIwMW1HallPWmlQam1kNzBaSnFxbmdhYnQ0VUxhN3lwNU5L?=
 =?utf-8?B?aExTVUZ3aTYwU3pKYU85WDRCTkd4TW5ZSFFtc2F0dzNxdldBbGZTeWVmcTVk?=
 =?utf-8?B?ckFxdzhieXZNcStsY09UWWZtTm8rL25SMWdCNHhIQ210ZUVCUW5VL3g0c1VF?=
 =?utf-8?B?bmlNcnFlU3NrN2R1NHhxT2dpN3lNOFZ2UndBWnluK1UzOU5icG8vd0NjRy9y?=
 =?utf-8?B?VElPV2tBdmdySkMrRlpRZlM2TlZQWnFSa2RBbTRkYzZrK21McXo0V1NIQzly?=
 =?utf-8?B?RkNES2VEZUFkRVJLSXVnK3piMDBVb3ZaMXNDajFKOXFOaDVFOGtVTlVOblcy?=
 =?utf-8?B?Y3dua1V4b0E2dGdhOStUb2c2M0thcTF0MEFUa3Q3N0tlZ28yMis0YXY3QnA3?=
 =?utf-8?B?MUlJc2VhZHA2ZUYrbnJCWWZRWnFpcEVnVldmd3lJbDQrdlVhczdOZWFjZkE5?=
 =?utf-8?B?YjBMYWlhZTlNR3cxcjdWUUdpU2V5RFA0TjdkaDdMVXF5dVF1cjBGMHExd2Nw?=
 =?utf-8?B?M3RRbnhRR0VEcmFoR3UvL1FHN3ZEZVhCNG1EN3p3c0Q4S2F6MVFmc1ptSzVU?=
 =?utf-8?B?NDVrcXJuNm9ieFdMRDJrcU5HN1V5bFZoSTNLWi9idkhCVG5sV2NnUnZRanhN?=
 =?utf-8?B?U2F1UUpEaVozQzRoMGhxQmxlNmVsUFBmb2hKUHNtaFI2Z0ZCMEQ3d2JSSE44?=
 =?utf-8?B?bWI1SkZzOUFMREZib0Zsam95T1JlNlI1RmlkWlprUnBNdFVTdWxBREZqbVdL?=
 =?utf-8?B?REdiWVRYcnNJelBhb1BvQnhiTDZwS2M5a2JOR0J4d2dBTlNJblAvejJPd05u?=
 =?utf-8?B?TW5GZW0zQ05Oc1lwbU5ZblZsUkY3aXJPVzRmVHJXOFJ0b3FvYUh5N29QVGxF?=
 =?utf-8?B?a3R5TGRicEJNYjV6TFNuakE5YVhuUkVWWGJmcGZyd0pHaktMSkxITEpMTEMr?=
 =?utf-8?B?Q1NTam11TjU5ekg5eEhyd296WHdQb0ZGc1hnb1lMOXBuOHVVd0R3UUxGY2tI?=
 =?utf-8?B?U2pVZGt4R013N1NlN2RUMGgySldhT0NWZUVPZkpLY2U1UE40cERzejhmcDEv?=
 =?utf-8?B?aGtCeTIrRGlsbTNVOWZMMDg2T3plbVFBVFV5TUg2UGlzblRmeWR0b00vVHFQ?=
 =?utf-8?B?L1pIbVVPbXpTT05nYjIxUExlYkFwTnBDNStqM0ErZ1ZReitDaENzZGJ5eHY3?=
 =?utf-8?B?cGFaSnJLbG5PbWNMT2l5ZlJyRzBnYnhWSVJNRW1Pd2Nyd2lxQnh1YWhMcmhG?=
 =?utf-8?B?QXdmSUhSbGpnZ2VYbE5pNmlLdUpBZm9PSmQ1cEE2R2dlWWkzaFhRVllQMkZE?=
 =?utf-8?B?dlFWaXBRemlZbDRzN1lpTWQ1aDVEUnpydkxXRlNGUnJJQm82YVV2MEpzOGlu?=
 =?utf-8?B?OUM3Zy9iVE5FREhKdUt5VmVyTFZicVA2NjZvUnlvM2l0SmJuYmMzUFB3MTVh?=
 =?utf-8?B?WjZmdzlxQkNyakV3eVg1SW5FZnRxM2pXTk04L2VVT0hUcnVJdTh0S1JnRUZM?=
 =?utf-8?Q?fEfQQeRWfXzOeKP5yi3hoi0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbbc7f6-e7fe-48b2-6fd0-08ddeb3245a9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8179.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 21:38:51.0980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qq2uvq8xgNuzJAvY8lav1KI6FYWnEeh9T7yHyQKTaZRhknC0a57GWLu58LElXRnCKnL2UKFW6RDNlB5xIU/ve3LIxVKwom3N1/f2SHQ3paw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR01MB9456

On 9/3/2025 10:49 AM, Sudeep Holla wrote:
> On Wed, Sep 03, 2025 at 03:23:58PM +0100, Sudeep Holla wrote:
>> On Tue, Sep 02, 2025 at 06:20:53PM +0100, Andre Przywara wrote:
>>> Commit 5f9c23abc477 ("firmware: smccc: Support optional Arm SMCCC SOC_ID
>>> name") introduced the SOC_ID name string call, which reports a human
>>> readable string describing the SoC, as returned by firmware.
>>> The SMCCC spec v1.6 describes this feature as AArch64 only, since we rely
>>> on 8 characters to be transmitted per register. Consequently the SMCCC
>>> call must use the AArch64 calling convention, which requires bit 30 of
>>> the FID to be set. The spec is a bit confusing here, since it mentions
>>> that in the parameter description ("2: SoC name (optionally implemented for
>>> SMC64 calls, ..."), but still prints the FID explicitly as 0x80000002.
>>> But as this FID is using the SMC32 calling convention (correct for the
>>> other two calls), it will not match what mainline TF-A is expecting, so
>>> any call would return NOT_SUPPORTED.
>>>
>>
>> Good catch and I must admit I completely missed it inspite of discussing
>> 32b vs 64b FID around the same time this was introduced.
>>
>>> Add a 64-bit version of the ARCH_SOC_ID FID macro, and use that for the
>>> SoC name version of the call.
>>>
>>> Fixes: 5f9c23abc477 ("firmware: smccc: Support optional Arm SMCCC SOC_ID name")
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> ---
>>> Hi,
>>>
>>> as somewhat expected, this now fails on an Ampere machine, which
>>> reported a string in /sys/devices/soc0/machine before, but is now missing
>>> this file.
>>> Any idea what's the best way to handle this? Let the code try the 32-bit
>>> FID, when the 64-bit one fails? Or handle this as some kind of erratum?
>>>
>>
>> Not sure about it yet. Erratum seems good option so that we can avoid
>> others getting it wrong too as they might just run the kernel and be happy
>> if the machine sysfs shows up as we decided to do fallback to 32b FID.
>>
>> I will start a discussion to get the spec updated and pushed out and see
>> how that goes.
>>
>> The change itself looks good and happy to get it merged once we know
>> what is the best approach(erratum vs fallback).
>>
> 
> Looking at the SMCCC spec(DEN0028 v1.6 G Edition) ->
> Section 7.4.6 Implementation responsibilities
> 
> If implemented, the firmware:
> ...
> • must not implement SoC_ID_type == 2 for SMC32.
> • can optionally implement SoC_ID_type == 2 for SMC64 (Function ID 0xC000_0002),
> ...
> 
> So Ampere is not spec conformant here and hence I prefer to handle it as
> erratum. Hopefully we can use SOC_ID version and revision to keep the scope
> of erratum confined to smallest set of platforms.
> 
> Paul,
> 
> Thoughts ?
>

Am I correctly understanding that, if the SMC64 SOC_ID Name call fails,
rather than an unconditional fallback to the SMC32 call, the SMC32
fallback would only be occurring under the proposed erratum?

I brought this issue up at a weekly team meeting today, and I'll also be
communicating with the Ampere Computing firmware team regarding this
issue.

