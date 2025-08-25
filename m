Return-Path: <linux-kernel+bounces-785458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46921B34AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A801A84D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DEE28000B;
	Mon, 25 Aug 2025 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PDGDmq5i"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2108.outbound.protection.outlook.com [40.107.115.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EE1169AE6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150498; cv=fail; b=A9RFzWyND+KotXYXhvC+Q+iA7zTelG08lLjp7I1Cj1g4tte7tW3Y/W1MH597TbeZ24UmW6aXXO0P3C6I09CsHrURip/tmMyHYFPPMYEAzVurqXXiDZk4MxvOEyUKUEIBAgYSD3/dRWx9L5DZpACdV8hJSriqH2zP86k7e/dL8gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150498; c=relaxed/simple;
	bh=H2GSHM02/ENPfUvsNBPHGJXiF1wtkitl8WM8bePaBa4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MQG9LInPvvr/Aoz3CeI+EQwxSBtPzKb6wWEjRk3QXbIDNQx0VGnnS3/6WQLSVi+yp/hKyRnlfem8265v45JD+fj4m1IHOcB0slHCvkXz7VuJUloG3uMYzZhBvbK7wAu2nS5Oah/LpiYJ2droqz8pL03YMiRA3O6ViRXPAi7CTnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PDGDmq5i; arc=fail smtp.client-ip=40.107.115.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpxzbAdiKp2HJlBWUJpSmRIyEZKACfqoxzcUQAxfcnDiVKB1x34EpsyQvP0fwLRvZC2+ImHLJP7U0byV5v1lFs0N4HusVMxzeDl0DYvTxaWlOa5pqOHHuBnFWEzofj7fPYd/1OOS7V0ybBGps4A1+uYZZ6pRlSduL/O8qtEz9/l9L08YJWwZvZVidrqLX6Gf1zCLqE5gBPeMo38Uah5hqZMcC3fO1sAPMaM1Q5fwWDQDzAd5+WKeP389DRg6U1w5GeB8wgc+IWQH7yO6V4MElG4bH65O532YCkBW3gqmCP0oMsTuA7r0QZFmInfJ2UrFmEY8wBtn5JeS5JOQKy6ORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLzVEIh8ag0Uoz8XcrT/TWrYJ3k9HWDPejoh/O20pfI=;
 b=pefffNlBPMf9jxNrxfL8oqvCbSGyFqPZ4aAFXxcthzEu7N+vOiFhDtr0GVWPChAfAXwNClTFyLbxR+Qf8zYzwRVTIr56eU5ycLUdwQn/7ns3CowpuME7M81uxZuyNh2paPNlcXAk06zYwLCIiCTu4/Vu6PiQx2qU76CJGRCEKPQN/lewiM/6zpJLZQ+8Nmd0tDbPU8axZ51nVUdrwliLekPO3U0ViEFkBczUCMp6aozzK2GjcF9CuKiJWot0jB3y8IEPlN+77X2UEsYiN6/ntuFShneqlMbcEWCW1iFRqigSKnn4mwmCuxbmU6stZ14Nz1hI3Jxe6fQGeFMQQBfygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLzVEIh8ag0Uoz8XcrT/TWrYJ3k9HWDPejoh/O20pfI=;
 b=PDGDmq5iMKgAtoYAWeTyLSocSHnXryKVIUNOycwhaZJzmaESL6ytD8B3L5uc2X2dR+DhZrTRq9k1c9n0PBVmMS5nZlx0ckGYBff/SZtg6oAygJ46g4hoLYu5fXK9vZZaKPlLg1j57prQPzcAWD1fmJPlwwWg+v/aPYmfidyUGSPKi+YAeQnxtrr9okludX5R+7ykyTYQuTbXT3W/GlqiHnmQ9gqu8CyHHTkDRa90d2E7nT/40KsGPoNZeI+s07y25+feFxaloj99bSvdvhGg27QMh3pMQHHMkqhrNofsVG3xNwpfMYx53qnZ2ZphogfU58yA/l+5rYX6nwHiJKUNug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8239.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 25 Aug
 2025 19:34:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 19:34:52 +0000
Message-ID: <1f8a7c01-ef66-4f20-bca1-d203e7f66c4e@efficios.com>
Date: Mon, 25 Aug 2025 15:34:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 32/37] x86: Use generic TIF bits
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161655.319791141@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161655.319791141@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0030.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::43) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: aff4a690-91ff-4923-6dd1-08dde40e761f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWgwdGN1T0pvQ1RqNlpzYmJ1cUlJRzVvVW9iTGt3S1F3Tm5EaHljSDgyR08y?=
 =?utf-8?B?bUw2VXdmdDNQSElCd01KTUdrL3NaVDUwMnJGZy9RMGJxbG5GT2c4SEpCUnVr?=
 =?utf-8?B?YVNQY3JyYlVrUDdRVk9lVjBwTFRsVk9jYk0yR2VqN0hvUDh0TjZvT2t1aCtD?=
 =?utf-8?B?M0cvOFdzWitLMzFEUHpCRWl2Wmw1OTkzWDRSWjA2OUFINXlTdkRta3hVakxv?=
 =?utf-8?B?bGZNdCtRdWl2LzhPUjJmcEdRaHoxVFc4cys3YllWTnhKNWo0THBGTVlsai96?=
 =?utf-8?B?c2xTMHhqUmFVbjJld1Q1VkpDc1U0cWswRHVmclpHVmdzUTNDbW5idlp0NWt3?=
 =?utf-8?B?VW1NakhaS0ZSNk44Sy9HckxUY2Q5bUJiOEs2TWZPbElHMGFEbk1pT0poa08v?=
 =?utf-8?B?YU5sKzlNTXFEK0x1OHUzekg0SUhaWjZBcVpTTjducHpaYmlpdFgwNG9XUGdF?=
 =?utf-8?B?KzQ0UmlNN29reElZVVVEMkZKT1FTMkk0c0JuZGVhYm5YQUdiOWhIbWNacE9t?=
 =?utf-8?B?U2QvUzJUNU9mYkpsVkNrSy9nNlByUVFKV0V3RDQvMW9GSDRkSWNOMlhoRTA4?=
 =?utf-8?B?UEMxSXhQdDlzZ2xGVjRtRG4ySGJTRFFpZW9qRldNNDNBb0UzVVNIRGpkbllu?=
 =?utf-8?B?UytqbzloY0M4cWQxQnRjekFYVWovbFBlb08zVUF1bnZ2czVoU0VoMjhPekZD?=
 =?utf-8?B?TWhPRGNzMnRnb0wxdzZmSXJDUzBIcGdRMkZIdU04QWw5alBaZ1FPd2I0N1ZU?=
 =?utf-8?B?MVlMNTlUVURrZDEranc3U1RrWlg1MGp1dXRmQUVxc2dFalUydzBPUFF1amho?=
 =?utf-8?B?SVk3V2lhN0hQSWJOS3k1Z3F0NTY5Uk1IU1ZVV2dFMnF5RnhvZzgxMVpSbHhO?=
 =?utf-8?B?UE04QkJBZDNsNkRWck1vN1RvdlczWVExT0tFWE9yYjdBUHZjUENCY2dvTmRD?=
 =?utf-8?B?aFdRTkVDMWxCTHNCRC9KcGRmbEU5MlZBQ1B4ZmEzeStWVlk3eElVeVZBdkht?=
 =?utf-8?B?andub3VGVWl1NTVHSUczQWw4KzFZamNQblcyUEpnM2UzYmNLbkpBdDN0cGgz?=
 =?utf-8?B?dURaZWp2NFFDTGtyaEY1TWFFQ1hzRS9QQVdPR3dBY1FncVJWajBHUnRYUXlQ?=
 =?utf-8?B?bUJqUUJUemRpWlJnQW9uK2tJTXBXaFptOXlDdk1KTWxKcmFsekcxMTAwbUZv?=
 =?utf-8?B?ckxub1IzckhpWTZYd0RTTDRnSXZOUjgvZEhuRnVsbWt0UldpRHRQNkEwMWVT?=
 =?utf-8?B?clNTL04rdkVua3MycWUycDlMblpmSzJqSVZ4VnFrZ01HeFdPQXlSSzFGeTFT?=
 =?utf-8?B?dEZqU0NtY0lpYjdsT1duYlU1TTU0eXl5Q0xZcFhFNHBhdit0cGs4WWkzMzhK?=
 =?utf-8?B?em9IbVh2TVk3WFNoUWFJemJBcmVLV25rQ0hUdXZVMVZRK2Z5ZE5VbUVrZDQx?=
 =?utf-8?B?clFUbkNMeE9FVXdGdmw2ZEh6ckJ2cmorQ1RMcldPSnFaWmplYWRKM2pYMGxi?=
 =?utf-8?B?V25TanVFQzg2L3lVTWhwVUh0b3gyMDhtZ3BKeXlTTVRYV0lJY2MvZDIydERG?=
 =?utf-8?B?UEwwNmxZMDZHVlVyTmxaeFJOb29yNDdTMEtWMWs4YU41N1dIOENmbjF2dFhF?=
 =?utf-8?B?TWtaZHFRMU5KeEk0eEpZTmp0NFVYUFhQYjhlaGJXMTVLdUJZWkUyeEdaU2Nt?=
 =?utf-8?B?cG9vK1N4MFFsZGhPZGcyejhBTFNnY0pWL0RqMWF2V2Mwa0tVV0xucjUrM2Zx?=
 =?utf-8?B?dEhoVEhMa1Bpb1UrRkZUY1pzd3o0NjljZ0kydVpSNzhkLzhCMDJqVW5kMit2?=
 =?utf-8?Q?CE1YsVxhMtHroaeTpIyzhnovz54xboVbX8F/k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUU0UmY4MEMrRkNKV2hXZDIyWEF4RHBmenFzLzBtVVoxZkVjaGt1RExpYldK?=
 =?utf-8?B?L0xKdEh1MWViK3RFYVFkTGdrS2Z3QWQ5R1FWTEVrQTZEMnJzZ2R0MkFMem1P?=
 =?utf-8?B?cDl2YUJyeWFNRVMxc1VVY3ZTNkVEWWJLdHFmSFZrUWZEeTBOMERpQjBEVGJ5?=
 =?utf-8?B?WHBqOXBVc2pTbU1HQ3crblNubXV6MVV6dkI1UHlpK2w1ZEs2dW1lNkJ6L3gx?=
 =?utf-8?B?eS9oMzhCODhpRXF0WDJUK0xxeGg4ZVVDZ3hiRXl3dE96RnR3cllBTEt6QzZx?=
 =?utf-8?B?LzZuNll6NkkvQ1Z1ZFlKZ1JmbzlURzF2NTVrb0pjeEpRaGJLR2JkRWxiWnE4?=
 =?utf-8?B?VmhmQ3plWXhJNVB5QnRhVDF6RDZpY3E3MGNxUjhjWHRMYW5VTGx1T3V3R1hQ?=
 =?utf-8?B?WC9DaEo0cGlhSWIxWWVkTDlWNWRibjhFSmg3eHI1d2psZmYvUWRvQndsYU5O?=
 =?utf-8?B?cXVCYWwvOEpIcmw4MXhmTFlheWpOT3Q2UWdhSnlXMGFuTjhYaGN0Tm1DajR2?=
 =?utf-8?B?KytCT3lyUmlwU0VLM1VlYXNnR21OOWp5NDUydVpvMmE3bDliY0pXTm5LcVNK?=
 =?utf-8?B?YWdzT0VacnlDcmNobVJwMWhqYXRuN3Y3a2FLUTA1aHErM1QwRW1DWU8ycldz?=
 =?utf-8?B?bjVjMUFWcGZQYWtrUmthSE8rN3EvbDgxNnBIdzNaNXl4MWp3c3RwTy8vaWw1?=
 =?utf-8?B?c1ZuanUrWVF6cmUrdm4wcDBMa0x5MXVUa2hYZHBQT1NLWGVBLzA3Vk50TFcy?=
 =?utf-8?B?NWpETFRJZmRZWUVmTFp5SlRXNGRPS0tjWkdJOG5JTzBYdGsrZlNCVDViTC96?=
 =?utf-8?B?aG4va1ZCeEU3MUl1MXpvb0lRUWhqeUxRZTVrT3ltN3VSNzJGK2pGYWxZQzEr?=
 =?utf-8?B?SXhMOGp3MUtFVUhSZ0kxWkVBMlo5Vm9ZSkFMVjJBSkNRWjY5cjhIVzArV0Zt?=
 =?utf-8?B?MmprM25aZzAxVkxzUnRoT0d3dkRqaEZwa2g3eE5pQy9TQ1hVeHFJTm1iM3dh?=
 =?utf-8?B?T3pPNDdCQS9qYklmVS9wbUdMMkluUy9jTkE3UFcwaEk2czhnTVArODdWTC9B?=
 =?utf-8?B?dHprVkNka1hhcmZDaStUSmtnc0JKZDZkRFVscFRnczU3ZVFZUHVJS2p5WG1E?=
 =?utf-8?B?clF2WHNsdWdVdm0ydml5REVPeVYxNkx2YllNbHBYZjNkM3M5bzl0Z01LVFVO?=
 =?utf-8?B?TnN5Y21kRFRMQXEwMXV0SG8vd1N6cmhSTkxQMy9DWlRQUEhRRnhCbTRZS1pB?=
 =?utf-8?B?K0o1bXYwQ0hqT3VQUi83T21IOUdGMzRuK1hEdTNRVDBnb3lsWk1EQ2EycTJP?=
 =?utf-8?B?YURHVVh4dThkZHBkSkZxS1ozZ0hkek9ZOU0yS1B3OGdBWjJrM3lKV2pWczk5?=
 =?utf-8?B?WFE2NG1WMDg4S0c5aE8ydkNPbFE4NEpGcUE4aVZ6ZHF3NjFSaUQ0cGFXZEsr?=
 =?utf-8?B?N0RXQkZXN2o0WnphUFRMSnlPMkYxS1puQnZDR2NBUzk4Nkg0c1dRUjFqc3NK?=
 =?utf-8?B?RDFQYWMyZis0ZDY2OUdJVGYrdE0vUCtHeHhwdysrOWQ0QWJTc2lRVkFTRkRi?=
 =?utf-8?B?emNFSmIyRStBUnVtdFlrcTdFTHdGa01OdGp6NHhlWGhwQU5NbEZMaXRJZTVK?=
 =?utf-8?B?TnlNQ1djbmY3a3U4L3FSUE40MkU0VENROGF5dWpSazZNVlhnMTlweGlYTWtE?=
 =?utf-8?B?U3Vrd1o5TXlqRWUzbTFMSkJQbjhvN2E2VC9uVjhLUkI3VkplSVNzaXdJOEdz?=
 =?utf-8?B?SEo1R3pKT21ocFZ6aGRVQ01sVVZESU5rcjVMRGIveGxXRmNnZjQwb29jaVpV?=
 =?utf-8?B?R3lJTlFHOUJqc3p3L2V3cVcxVkVxTnZTSmEwVU9zRURUTFNzbmZ4dUcrK0xS?=
 =?utf-8?B?Y2ZyQ2lzY2dmeWhkVHluNERxV2FZMVdidU9hL3NDSkdOVGo2ZDNDaldid0Vs?=
 =?utf-8?B?Y2M5bkNJVWdTZzZiUks4eThpU0JKUDc3M1Y2dG52VWFHUFkwL0VNR3pTVjc0?=
 =?utf-8?B?UUFCQTFWOGtEaEYrOVBzQkRyenNSSVJoK0FyWFR4M295Mlg4aVZnQ0praUU5?=
 =?utf-8?B?MHJqbGVZUFV5Vm9zUStNamVJdDRIK3lLMGZDSlRKMTNQMVNpYlRGOUR6NzJJ?=
 =?utf-8?B?aG50TFhlVWxTYjcyd09uWWFhWWwyYy9ZWStuMDdHaEVmdnh3K1RyVVlaK2VD?=
 =?utf-8?Q?wnPqzkOyo23AA/eanyIo+Ho=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff4a690-91ff-4923-6dd1-08dde40e761f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:34:52.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzCgf07cICANATaW7QtnZc/N53JT1d4uyK/zc8GCsaO0pTwfaAwgnunOglky4OVEUsAcGGfPhogWErSUxfplhhs4VlvI50+yEeNllhVWIcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8239

On 2025-08-23 12:40, Thomas Gleixner wrote:
> No point in defining generic items and the upcoming RSEQ optimizations are
> only available with this _and_ the generic entry infrastructure, which is
> already used by x86. So no further action required here.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   arch/x86/Kconfig                   |    1
>   arch/x86/include/asm/thread_info.h |   74 +++++++++++++++----------------------
>   2 files changed, 31 insertions(+), 44 deletions(-)
> 
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -239,6 +239,7 @@ config X86
>   	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>   	select HAVE_EISA			if X86_32
>   	select HAVE_EXIT_THREAD
> +	select HAVE_GENERIC_TIF_BITS
>   	select HAVE_GUP_FAST
>   	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
>   	select HAVE_FTRACE_GRAPH_FUNC		if HAVE_FUNCTION_GRAPH_TRACER
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -80,56 +80,42 @@ struct thread_info {
>   #endif
>   
>   /*
> - * thread information flags
> - * - these are process state flags that various assembly files
> - *   may need to access
> + * Tell the generic TIF infrastructure which bits x86 supports
>    */
> -#define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
> -#define TIF_SIGPENDING		2	/* signal pending */
> -#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
> -#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling needed */
> -#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
> -#define TIF_SSBD		6	/* Speculative store bypass disable */
> -#define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
> -#define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
> -#define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
> -#define TIF_UPROBE		12	/* breakpointed or singlestepping */
> -#define TIF_PATCH_PENDING	13	/* pending live patching update */
> -#define TIF_NEED_FPU_LOAD	14	/* load FPU on return to userspace */
> -#define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
> -#define TIF_NOTSC		16	/* TSC is not accessible in userland */
> -#define TIF_NOTIFY_SIGNAL	17	/* signal notifications exist */
> -#define TIF_MEMDIE		20	/* is terminating due to OOM killer */
> -#define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
> +#define HAVE_TIF_NEED_RESCHED_LAZY
> +#define HAVE_TIF_POLLING_NRFLAG
> +#define HAVE_TIF_SINGLESTEP
> +
> +#include <asm-generic/thread_info_tif.h>
> +
> +/* Architecture specific TIF space starts at 16 */
> +#define TIF_SSBD		16	/* Speculative store bypass disable */
> +#define TIF_SPEC_IB		17	/* Indirect branch speculation mitigation */
> +#define TIF_SPEC_L1D_FLUSH	18	/* Flush L1D on mm switches (processes) */
> +#define TIF_NEED_FPU_LOAD	19	/* load FPU on return to userspace */
> +#define TIF_NOCPUID		20	/* CPUID is not accessible in userland */
> +#define TIF_NOTSC		21	/* TSC is not accessible in userland */
>   #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
>   #define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
>   #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
> -#define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
> +#define TIF_SINGLESTEP		25	/* reenable singlestep on user return*/
> +#define TIF_BLOCKSTEP		26	/* set when we want DEBUGCTLMSR_BTF */
>   #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
> -#define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
> +#define TIF_ADDR32		28	/* 32-bit address space on 64 bits */
>   
> -#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
> -#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
> -#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> -#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
> -#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
> -#define _TIF_SSBD		(1 << TIF_SSBD)
> -#define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
> -#define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
> -#define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
> -#define _TIF_UPROBE		(1 << TIF_UPROBE)
> -#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
> -#define _TIF_NEED_FPU_LOAD	(1 << TIF_NEED_FPU_LOAD)
> -#define _TIF_NOCPUID		(1 << TIF_NOCPUID)
> -#define _TIF_NOTSC		(1 << TIF_NOTSC)
> -#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
> -#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
> -#define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
> -#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
> -#define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
> -#define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
> -#define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
> -#define _TIF_ADDR32		(1 << TIF_ADDR32)
> +#define _TIF_SSBD		BIT(TIF_SSBD)
> +#define _TIF_SPEC_IB		BIT(TIF_SPEC_IB)
> +#define _TIF_SPEC_L1D_FLUSH	BIT(TIF_SPEC_L1D_FLUSH)
> +#define _TIF_NEED_FPU_LOAD	BIT(TIF_NEED_FPU_LOAD)
> +#define _TIF_NOCPUID		BIT(TIF_NOCPUID)
> +#define _TIF_NOTSC		BIT(TIF_NOTSC)
> +#define _TIF_IO_BITMAP		BIT(TIF_IO_BITMAP)
> +#define _TIF_SPEC_FORCE_UPDATE	BIT(TIF_SPEC_FORCE_UPDATE)
> +#define _TIF_FORCED_TF		BIT(TIF_FORCED_TF)
> +#define _TIF_BLOCKSTEP		BIT(TIF_BLOCKSTEP)
> +#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
> +#define _TIF_LAZY_MMU_UPDATES	BIT(TIF_LAZY_MMU_UPDATES)
> +#define _TIF_ADDR32		BIT(TIF_ADDR32)
>   
>   /* flags to check in __switch_to() */
>   #define _TIF_WORK_CTXSW_BASE					\
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

