Return-Path: <linux-kernel+bounces-786909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB3B36DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F207AC054
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB799275AED;
	Tue, 26 Aug 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rHcPRAm2"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022137.outbound.protection.outlook.com [40.107.193.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42640270ED2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221971; cv=fail; b=h8WIbX4sHpvn8+JW+bYsoyRvGZ0SmOfiOu0uGn1G+tgyO5r+/t5MSTELsU7BypSnyaQhTxb5+hxiABksr9SNhk1Vpc9z6QWVc3P9ycem04wGSmnOpskGwjtt+WMyYBiFUlnKo2xakgwVKDsdnUypLuuDg4zJ/zQhPgg6m+Zovc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221971; c=relaxed/simple;
	bh=OnjmytR4x3AMb2NOwSp2NGep2AIVvKrfO+NUTQ7tSGU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OgX+x+kEPv1Fe2ClXw9GqdZIKl7+ELPYuPxD8djdlhxTdFEKrQ/HgB31RPvdcW3YyNoWmMvAszw07f6uk19dTl1GvqdRyEgtysCh4ggXXI8nw/HhlhWNXcLfm6mu5Tw9zgffLY9Acd3PlGnoGfh6EqLFYthkcHLeH1M8oaQfFFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rHcPRAm2; arc=fail smtp.client-ip=40.107.193.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwdWb6zYoTuWtI/PiNzs7BtESJTALeNa8AxZrNZUMYb6jJmb3YT3zu+2l1EYvqzg0OWheRRxjgTD+SqtgcIFq4A6PWm3yUivgdyLSwthQQRxgfLd6gjbLncRdcJdG2iG+yIpAcILxaWRwoAPlXSI2ODPri2E+8e3pipvEV5cMddnhZcbAJ0xfKrTgdtIx4iNqC5BOj4cRd63wPWMf81miXwmU/vZ+gThVa0J2JJpdarmIRTjibq/gx3u4Ppm0dq+uGGE/a4NXanqEt9360+Vzfk6FT1ZqgoUyT9ZQonbXuijzX+Lr/EIIQmEQ+fK2iFvMR8MMe16X6n3h/+chtoI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiUaXT6UYD62pNua0BRiEvS2a9Li2pG+tTc1ytDn16k=;
 b=GuDkWSdSnc+mQhm1mhMQKYHdfqI7DfwIyD93DRgJsNejvsCey6+K6Wtn62gCusVROcWdq+JUOkmxJGkJq8hVFL8x3EB0SoX4CtIG3XAysm+A41tL2pXdgIRAhGPEpxvPWGHnlFrKdvDndbtxDpqvEkbNrVsvMVrrokgryD5SfSxJcMl5kW20utgixHzQTRkPK5EEsnYRPH+FO73Yhoenur9VjjtprBKRdIdCgfEgPHDFeiyXNlgmsqJg6Q3bsIwsuknkedCYJ9AfIW1TjwLrrCAXyvHL5y37SpRtIS91jMLd2K/KILuyBFbAXOXjb1v+k5laZOp5xLnSnjn/qbbfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiUaXT6UYD62pNua0BRiEvS2a9Li2pG+tTc1ytDn16k=;
 b=rHcPRAm2o8T+vkXpHHnZ390II7Da5TGBC6MFs84RGm5UrYalF4THHuOK5wEEFZO2sRuAuoqtjfy4yNF0rhFSbv4HzcyKiga7F/zt7RRKzAeiYmBp2bUZGgjmOaVfWUzJFEV+zrafhaPI0NOjGQh1+JcLBgQnRxeJp46benBfrxiiDJs9O5MXokfjXSJVTMWTVtVmm1BfmnuokBSzlRkr1wX6LejRP/wAyjFW8LlVXZw6oQFGUIB/MqgMbCO14aN+hbEiAQfD+ZOMR6/kEb32bGim5cKbpvBFVE+Ijxc7tZWcR/di66L8Nyy7OAy7/2//BYCmmE/p+OKiSFpBwZgMXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8941.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 15:26:04 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 15:26:04 +0000
Message-ID: <80f966ea-d8a5-401d-ad2f-dba5035cce0c@efficios.com>
Date: Tue, 26 Aug 2025 11:26:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 26/37] rseq: Optimize event setting
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.935413328@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161654.935413328@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d5af2b-fcf7-4278-a3d9-08dde4b4dea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajVHVUl5ZkJnd01pT0hOeXUzUjMyY2tMNFlETlN4UFVjdDFDdGUxbDMrLzA5?=
 =?utf-8?B?ay9HaCt4cGsrMVZDUVgvTGpqSTF4eEVnQ2VKclJ3b3hld2hDVWJJaE9KOG1z?=
 =?utf-8?B?Vk03U1d5NEtQcTJRV2JqTWdsQlpiTEhlT2pRUUQ2T1NDY0FkMkZPZktkSHZM?=
 =?utf-8?B?UU9RUXF4enBEOUxOczhhOUdjUU9JeWZSMWRqcmNIUzNkWHppM2haSm1TQ1Bv?=
 =?utf-8?B?OVdSTTMwbzFUN1FmbkpFNTVjRThEWEpmUitLWlgwSUJTV3RjUjNCbEZINmda?=
 =?utf-8?B?UWVqZ0VWQk5vSVRnbVNNUEVSZ0VoRXduTDAzUEdtRkY2SDExSFZwSHdaNWYx?=
 =?utf-8?B?eWNDL0JEVFRRdEFhdDE5ZFNyRU8wTng2NlZpV3Zkd3NSd2FGNkFTVmJuTHZz?=
 =?utf-8?B?ZmQxZ2lidjNmclJTWTAwMEhwWWkvZUV6L0pKSlZiM0NLdVo0MUJka2hhd21l?=
 =?utf-8?B?OExpTVJOYXVZaStXL3FWRTZLODF1OXJQSWRmOVNvQW5SRnhhVnBJY0wxdERC?=
 =?utf-8?B?dzhqVGQvQ2RaM2JHWFpUcTFTdFBrNjg3VnVFb2NFeXBLTkxGOFdCSFpVVUM2?=
 =?utf-8?B?RGsvRFZ4QjFiY3ZCaTYvekQ3N2dXTHFEaXdrR01FNEwxVTN2V1JxY1lvYWpH?=
 =?utf-8?B?VG5SdDcvZ2w2QUh0WGM1c2NBTitkQXBTU3JxdDMrM292WG9QWlkzMkRDQW95?=
 =?utf-8?B?VW81T2JsblBMcXRiY2pYUk1teHR0OUxDbEdUNERlWXUxU1ZJMGN1R2F2aWo4?=
 =?utf-8?B?YVlzTlNOYkt2aHhhR1dUV3J2Q0VEQUhXVGR2YThESUlXaFhjclIxVlJtNGFj?=
 =?utf-8?B?NVRDREJMVUx3SVFnV1l4NG05KytLOHRhcHI4cDRQMmtGdVBFUEZvT0EvUmti?=
 =?utf-8?B?VE90NnFGRVBsRmJFQms4U1FXaUczQVd3S2g0L1pLOTU4cVd3VEcwSnZRUWky?=
 =?utf-8?B?cWd1SDBMMkw4N05QUTZJNUNidS94dlpXWGhEUThZVnF4SVlhSGlBNHBJQUpR?=
 =?utf-8?B?Z05TK3dxQncxTDQwMTdCamJSUzR5SEpERDVLS1RvTTZOUHFFQ2tCTG41SmJl?=
 =?utf-8?B?TTUya3NKUS95L3NxVThYOVBiVVlzc291K3U2MVBIOXJKbnh1Wnp2Z1piZ0VV?=
 =?utf-8?B?WmN4Y2p0emxLNmJaeXh0QXhBaEkrK1I4NDIzbGNCYkxjb2puUkFJNldDVUtB?=
 =?utf-8?B?aGd6ckFZV0tjR3N2dkdWWHlSK0pUaUVmMXYzVFhETTlweUYybHloc29lN3FU?=
 =?utf-8?B?TnY2M3lrOE9JRWlrdERaVnFlTm50VnRGMnZhV25oRTl6RnlJQW9uWGQ2TzVR?=
 =?utf-8?B?L3lPeDB6SHQ4RkJkZjZFMTk2dVB0VVo0UGNtK2IvdjBzc3kzUGloaVM3eFZp?=
 =?utf-8?B?Y2RZSVJqek4xRVdOejZ5ZWxWUi9oY1FqU0FPVkRBc1cyckFvREZzaXZZZTZ1?=
 =?utf-8?B?VGQvT24rbXRhVlB0OTNvMTBhU0FkMU5rR0JsWGNjMzBBRnVUZmRJa2dKdE03?=
 =?utf-8?B?WmpWNjN0LzkvUWZxRnVSMllpaHkzdHBwUlBIdEJQUk5pKzlwVm1IRTczMHBs?=
 =?utf-8?B?YVI2M2hsM29PT1I1c3dhSUNCSUtHQUJRMUtiQ2k2UTRkVjZJT0dwSFpMblA1?=
 =?utf-8?B?NEkwZTJVODNpOGRGb1JiRG9xR0dva3puQTV6Smg5enFaTXJqc3hlYmpBencv?=
 =?utf-8?B?S2tCVW1kWEpSaG5xOHhUeTQ2bkRuemZNVWJralRwTEMwa21UaG8vMThxYVJF?=
 =?utf-8?B?QVo0OUQvWlVHd3cyRGlPS0FpNFdudWQzNCtUSVpUWVFZK3ZqQ3g2Nm9xNFg4?=
 =?utf-8?Q?kOE+w+LfZNuDkvl0ulRiIMP5wvCwXYskebw+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmJrN0Vxd1RKS0lkYUgyQnh3L3YxRGpsWTgyNkhJSGdCWVhGRm1JakpNaWts?=
 =?utf-8?B?TzYrbHJ0QkduRHA0a0h3SlF2TGFvVHFtdW1tY21NUVRIRHp4Z2U4UjZEU1Zn?=
 =?utf-8?B?dlk5bWNYYWZ3RXB4My9SNU4xQll4Q1hNR0YyaFF5cjltOG1Qbm9pVUVwaFNP?=
 =?utf-8?B?QlVOc0tpVDlzd3ZQMjY4UzJGbGN5NXZKTXk0ME9YVW9vS2Vmbk8zaW02alhL?=
 =?utf-8?B?Ymk4Nng1dWQwSXRGT1BJTnVHckh3QkkvTzQzV1IvUFdiZzlpK0Qra0c1NU1E?=
 =?utf-8?B?SUYrajN2UWo0TzhicXc4VUMxYmtoRFZFN1I0L2oyREtLYVRXYkZvWGIraDdC?=
 =?utf-8?B?NlRKeDZPREcvbTZsd29kNkNQWExNNTRLcWs2RnMrV1F1NDlqUEpKaFBEOFEw?=
 =?utf-8?B?VVJRVDJEa3Q4NjZ5WmoySHF1R2U5ZCtsUHIxRlg1R1h5NjI2OXR5NHliUEdi?=
 =?utf-8?B?VTlBRmJpUDRSbk1zSGhHbXZnNzgrWjhMWDV1MmxkenVMOFM2SHdSTkoxOURm?=
 =?utf-8?B?ZDErZ0lacHVZbkhpUHY4ZTRHNVZiUW1nUDBMMVY3OU5oZXJPdW11YTQvZDNC?=
 =?utf-8?B?RHl3cWZWeldQdEg4aHVZVjhab1g3SUxzMUdRYitVcFM4a09sYUFkK2F2Yi9N?=
 =?utf-8?B?TUVvb0FlR05xQnpYY05NcHBLMWVRNkk5MTk3amNlcXpnNFo5a3JramNwVlIz?=
 =?utf-8?B?QXpKbG9vZzhteXJyUXNTY2h2UWp5TzEzRFN6Z2I2S3hlMmFoUXBTZlA3RVhq?=
 =?utf-8?B?Yldsa2RKS1F5VjFWbTFJSjJjcmxxZGVEeVlZd2VQSVVpU0k5NXZ5bU9pd054?=
 =?utf-8?B?akVNNGt1L3BrRlZqSHdLVytKYW00bm8yOWh1cGs5Q1RISmlTeDBrK0lFOXpl?=
 =?utf-8?B?T09wazVBM05wdzZkWkltRDNlRGFhSkZZRVhHZkdNZXQ3UzNLSUI1QzBHYXF5?=
 =?utf-8?B?b1g1eDVuaHk4c203aVN1YlJpVDFsaGo5ZnFndi9zL2Q4SW13c2p2aitQVUZE?=
 =?utf-8?B?SHAzNHVDdS9aQ1Jhek83UGhEUU1VYlMxMmFFWG1zQ2o5VTM5dlU0dzlUL0Nj?=
 =?utf-8?B?TWNrbVFzQzhUVEtCcUg1Ym9Ld2ovMXNUaDAzb0c2dk1EaE9oUTB2MlNnNkxR?=
 =?utf-8?B?cjV0NlRVY3J4T2FQL21RRVhzK0MvOUdRYTZ6THVDOTVZLzRieXBUTHJZeDZm?=
 =?utf-8?B?Q0hnZTZ3NHJ4SFB1WW5kTlRFbENieUlUZ055cDZzMFlnajBpOWp0SzRoRmNt?=
 =?utf-8?B?K3E3UFFKS2Z5NHFFeHRuY0VBTU5RRnB1OVlvTStxdm9BRGxnandYY0ovSXha?=
 =?utf-8?B?Z3pYRGxhMlNQWDkzOVFnN2QwNkRtZFJwK3BheFJhZy9IUjgyZTBQR0dFaDNB?=
 =?utf-8?B?Q080VXhickZ3Zzd1OU9UK2ZqK0RaZjFPa3hrUDI4OXdUYnMwK2FxT25nRVdL?=
 =?utf-8?B?bUlCYU1LUUYzZGhVOUVTdDJyaDNwQlR2VzBDQzUrU2hHdXpwTkNSMHBtQXVx?=
 =?utf-8?B?Tll4ZVB4OHhWOWx5QTJCaHN1QnpzL1h3aStYNEt4NmhsWTZTQkNoUTVsWnh6?=
 =?utf-8?B?WDBkVHR4UHFJOUJOcitXUFlMTWZhZUY2NXlLUlVxN3hSVFB2VVdXdEd3YkxC?=
 =?utf-8?B?ZW4vVE9aUU5UWjIvSTRHTEMyNWZxQ2oxbXRFTElObWhQMHo5SUFlZlRLUmVo?=
 =?utf-8?B?SDJEaU5zakhoVWU3Q2tYaEh4LzJZbk5FVndKWlpkTmtYL2daZXpCTSttcFF3?=
 =?utf-8?B?bUNtdmhwYWhVUDdEVzVEV3ZKWGNucnlJMXh1ZnpHb2QwVmFsc3JMRmtpMVJi?=
 =?utf-8?B?NXc4cnRJa01aZXV1YVQyYVdCMEs0NVdObjVjUWloZFdmOG1DaUJYZVFhV2Za?=
 =?utf-8?B?cm9IanI1ekl5VkFnTmxiUHFCQmtkT05hRm12YXF4QXpzczlBQnRVeEFFSTJX?=
 =?utf-8?B?eTJ1TVJSOTRDWk4yMC9kVGdUendaam9LRDFTZDlIbkdEM2JuMjdVNjBybmh6?=
 =?utf-8?B?eURNVXZNdXMyTnMvWkJGVktXays3RGRNdDRNZC83ejFNUjNsMys4UjhOMitG?=
 =?utf-8?B?OGoxSW9jNlc0eVJHM203WWNHVDYzTTU1NElhcWdlVStNZ2l2a1djb2hjajBP?=
 =?utf-8?B?R2ZvcHkvT0xmVDVtOWJiR2pBVGs0b0R4VTVzU2dRZGhSa1ZERTQzM3J1d3VQ?=
 =?utf-8?Q?n1A0TnqH6OuS9YAv2f4Tqg8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d5af2b-fcf7-4278-a3d9-08dde4b4dea5
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:26:03.9502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5OkVuq2ffdssZkxchWMreODLcgPZmaD6Y++sm9zIuyAUp+XCV9kD6fSsQMO183x1qdbeTGQtlnaQO08UTyMTfc0RpGE2HDSX5SQXDfHL2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8941

On 2025-08-23 12:40, Thomas Gleixner wrote:
> After removing the various condition bits earlier it turns out that one
> extra information is needed to avoid setting event::sched_switch and
> TIF_NOTIFY_RESUME unconditionally on every context switch.
> 
> The update of the RSEQ user space memory is only required, when either
> 
>    the task was interrupted in user space and schedules
> 
> or
> 
>    the CPU or MM CID changes in schedule() independent of the entry mode
> 
> Right now only the interrupt from user information is available.
> 
> Add a event flag, which is set when the CPU or MM CID or both change.

We should figure out what to do for powerpc's dynamic numa node id
to cpu mapping here.

> 
> Evaluate this event in the scheduler to decide whether the sched_switch
> event and the TIF bit need to be set.
> 
> It's an extra conditional in context_switch(), but the downside of
> unconditionally handling RSEQ after a context switch to user is way more
> significant. The utilized boolean logic minimizes this to a single
> conditional branch.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   fs/exec.c                  |    2 -
>   include/linux/rseq.h       |   81 +++++++++++++++++++++++++++++++++++++++++----
>   include/linux/rseq_types.h |   11 +++++-
>   kernel/rseq.c              |    2 -
>   kernel/sched/core.c        |    7 +++
>   kernel/sched/sched.h       |    5 ++
>   6 files changed, 95 insertions(+), 13 deletions(-)
> 
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1775,7 +1775,7 @@ static int bprm_execve(struct linux_binp
>   		force_fatal_sig(SIGSEGV);
>   
>   	sched_mm_cid_after_execve(current);
> -	rseq_sched_switch_event(current);
> +	rseq_force_update();
>   	current->in_execve = 0;
>   
>   	return retval;
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -9,7 +9,8 @@ void __rseq_handle_notify_resume(struct
>   
>   static inline void rseq_handle_notify_resume(struct pt_regs *regs)
>   {
> -	if (current->rseq_event.has_rseq)
> +	/* '&' is intentional to spare one conditional branch */
> +	if (current->rseq_event.sched_switch & current->rseq_event.has_rseq)
>   		__rseq_handle_notify_resume(regs);
>   }
>   
> @@ -31,12 +32,75 @@ static inline void rseq_signal_deliver(s
>   	}
>   }
>   
> -/* Raised from context switch and exevce to force evaluation on exit to user */
> -static inline void rseq_sched_switch_event(struct task_struct *t)
> +static inline void rseq_raise_notify_resume(struct task_struct *t)
>   {
> -	if (t->rseq_event.has_rseq) {
> -		t->rseq_event.sched_switch = true;
> -		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
> +	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
> +}
> +
> +/* Invoked from context switch to force evaluation on exit to user */
> +static __always_inline void rseq_sched_switch_event(struct task_struct *t)
> +{
> +	struct rseq_event *ev = &t->rseq_event;
> +
> +	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
> +		/*
> +		 * Avoid a boat load of conditionals by using simple logic
> +		 * to determine whether NOTIFY_RESUME needs to be raised.
> +		 *
> +		 * It's required when the CPU or MM CID has changed or
> +		 * the entry was from user space.
> +		 */
> +		bool raise = (ev->user_irq | ev->ids_changed) & ev->has_rseq;
> +
> +		if (raise) {
> +			ev->sched_switch = true;
> +			rseq_raise_notify_resume(t);
> +		}
> +	} else {
> +		if (ev->has_rseq) {
> +			t->rseq_event.sched_switch = true;
> +			rseq_raise_notify_resume(t);
> +		}
> +	}
> +}
> +
> +/*
> + * Invoked from __set_task_cpu() when a task migrates to enforce an IDs
> + * update.
> + *
> + * This does not raise TIF_NOTIFY_RESUME as that happens in
> + * rseq_sched_switch_event().
> + */
> +static __always_inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu)
> +{
> +	t->rseq_event.ids_changed = true;
> +}
> +
> +/*
> + * Invoked from switch_mm_cid() in context switch when the task gets a MM
> + * CID assigned.
> + *
> + * This does not raise TIF_NOTIFY_RESUME as that happens in
> + * rseq_sched_switch_event().
> + */
> +static __always_inline void rseq_sched_set_task_mm_cid(struct task_struct *t, unsigned int cid)
> +{
> +	/*
> +	 * Requires a comparison as the switch_mm_cid() code does not
> +	 * provide a conditional for it readily. So avoid excessive updates
> +	 * when nothing changes.
> +	 */
> +	if (t->rseq_ids.mm_cid != cid)
> +		t->rseq_event.ids_changed = true;
> +}
> +
> +/* Enforce a full update after RSEQ registration and when execve() failed */
> +static inline void rseq_force_update(void)
> +{
> +	if (current->rseq_event.has_rseq) {
> +		current->rseq_event.ids_changed = true;
> +		current->rseq_event.sched_switch = true;
> +		rseq_raise_notify_resume(current);
>   	}
>   }
>   
> @@ -53,7 +117,7 @@ static inline void rseq_sched_switch_eve
>   static inline void rseq_virt_userspace_exit(void)
>   {
>   	if (current->rseq_event.sched_switch)
> -		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> +		rseq_raise_notify_resume(current);
>   }
>   
>   /*
> @@ -90,6 +154,9 @@ static inline void rseq_execve(struct ta
>   static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
>   static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
>   static inline void rseq_sched_switch_event(struct task_struct *t) { }
> +static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu) { }
> +static inline void rseq_sched_set_task_mm_cid(struct task_struct *t, unsigned int cid) { }
> +static inline void rseq_force_update(void) { }
>   static inline void rseq_virt_userspace_exit(void) { }
>   static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
>   static inline void rseq_execve(struct task_struct *t) { }
> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -10,20 +10,27 @@ struct rseq;
>    * struct rseq_event - Storage for rseq related event management
>    * @all:		Compound to initialize and clear the data efficiently
>    * @events:		Compund to access events with a single load/store
> - * @sched_switch:	True if the task was scheduled out
> + * @sched_switch:	True if the task was scheduled and needs update on
> + *			exit to user
> + * @ids_changed:	Indicator that IDs need to be updated
>    * @user_irq:		True on interrupt entry from user mode
>    * @has_rseq:		True if the task has a rseq pointer installed
>    * @error:		Compound error code for the slow path to analyze
>    * @fatal:		User space data corrupted or invalid
> + *
> + * @sched_switch and @ids_changed must be adjacent and the combo must be
> + * 16bit aligned to allow a single store, when both are set at the same
> + * time in the scheduler.
>    */
>   struct rseq_event {
>   	union {
>   		u64				all;
>   		struct {
>   			union {
> -				u16		events;
> +				u32		events;
>   				struct {
>   					u8	sched_switch;
> +					u8	ids_changed;
>   					u8	user_irq;
>   				};
>   			};
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -459,7 +459,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   	 * are updated before returning to user-space.
>   	 */
>   	current->rseq_event.has_rseq = true;
> -	rseq_sched_switch_event(current);
> +	rseq_force_update();
>   
>   	return 0;
>   }
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5150,7 +5150,6 @@ prepare_task_switch(struct rq *rq, struc
>   	kcov_prepare_switch(prev);
>   	sched_info_switch(rq, prev, next);
>   	perf_event_task_sched_out(prev, next);
> -	rseq_sched_switch_event(prev);
>   	fire_sched_out_preempt_notifiers(prev, next);
>   	kmap_local_sched_out();
>   	prepare_task(next);
> @@ -5348,6 +5347,12 @@ context_switch(struct rq *rq, struct tas
>   	/* switch_mm_cid() requires the memory barriers above. */
>   	switch_mm_cid(rq, prev, next);
>   
> +	/*
> +	 * Tell rseq that the task was scheduled in. Must be after
> +	 * switch_mm_cid() to get the TIF flag set.
> +	 */
> +	rseq_sched_switch_event(next);
> +
>   	prepare_lock_switch(rq, next, rf);
>   
>   	/* Here we just switch the register state and the stack. */
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2181,6 +2181,7 @@ static inline void __set_task_cpu(struct
>   	smp_wmb();
>   	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
>   	p->wake_cpu = cpu;
> +	rseq_sched_set_task_cpu(p, cpu);

The combination of patch
"rseq: Simplify the event notification" and this
ends up moving those three rseq_migrate events to __set_task_cpu:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index be00629f0ba4..695c23939345 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3364,7 +3364,6 @@ void set_task_cpu(struct task_struct *p, unsigned 
int new_cpu)
                 if (p->sched_class->migrate_task_rq)
                         p->sched_class->migrate_task_rq(p, new_cpu);
                 p->se.nr_migrations++;
-               rseq_migrate(p);
                 sched_mm_cid_migrate_from(p);
                 perf_event_task_migrate(p);
         }
@@ -4795,7 +4794,6 @@ int sched_cgroup_fork(struct task_struct *p, 
struct kernel_clone_args *kargs)
                 p->sched_task_group = tg;
         }
  #endif
-       rseq_migrate(p);
         /*
          * We're setting the CPU for the first time, we don't migrate,
          * so use __set_task_cpu().
@@ -4859,7 +4857,6 @@ void wake_up_new_task(struct task_struct *p)
          * as we're not fully set-up yet.
          */
         p->recent_used_cpu = task_cpu(p);
-       rseq_migrate(p);
         __set_task_cpu(p, select_task_rq(p, task_cpu(p), &wake_flags));
         rq = __task_rq_lock(p, &rf);
         update_rq_clock(rq);

AFAIR those were placed in the callers to benefit from the conditional
in set_task_cpu():

         if (task_cpu(p) != new_cpu) {

perhaps it's not a big deal, but I think it's relevant to point it out.

Thanks,

Mathieu

>   #endif /* CONFIG_SMP */
>   }
>   
> @@ -3778,8 +3779,10 @@ static inline void switch_mm_cid(struct
>   		mm_cid_put_lazy(prev);
>   		prev->mm_cid = -1;
>   	}
> -	if (next->mm_cid_active)
> +	if (next->mm_cid_active) {
>   		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next, next->mm);
> +		rseq_sched_set_task_mm_cid(next, next->mm_cid);
> +	}
>   }
>   
>   #else /* !CONFIG_SCHED_MM_CID: */
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

