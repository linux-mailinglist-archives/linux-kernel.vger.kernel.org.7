Return-Path: <linux-kernel+bounces-801780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A92B449C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71633B7053
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD3D2ECD3A;
	Thu,  4 Sep 2025 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="c7NTHLFh"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2130.outbound.protection.outlook.com [40.107.116.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291162EC555
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025448; cv=fail; b=qS1PrE8c7w6N+1yitUPbINmCIzUN1Hv5riu4pN5LZVwL0PMyp9hJs5cbjrAdbp7+/3ekLupFsZw0V81FBZbvX/BYFCE0d1arKHiXwngXGVsxA1T9Dz4qlvKfwsipcsw6s8JUo8vK81vvaCVdijx66twQETDMQ4S3JwXiq7BDoZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025448; c=relaxed/simple;
	bh=FxD5ZasDYqVD6lt+EaaedJzGsM+tY2m68XCP/nFN2zM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PCCWPza6gwjiSHbJlpEKm62yr6UP8/IPm2PjovISIW56w7O0neWu6OliBQoaBV4juplIRYqAT5/aKmIVEdvmSatSd1oTVcwRFpNJF1CjUu9+R6QGt1xhg1OLlvSvh0OQ36GMRQCxHo/LPMHozeFcgLdaDOh82ZxJ1wNjh2Qbg3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=c7NTHLFh; arc=fail smtp.client-ip=40.107.116.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kc2LkugdwFv55UXdN+y4H1hOkpgb/sXuBKbn/2xGp701/fXbwaBBiTlcXoX+irdnsOF3Kh1QUn5pFDNOizzMRJN9GLYOjDAcV1dcDayZP+QD177fEDwWOEAy+PQhjMAwWN5nlhM8fVSlA3jNFkVPjmfiJoLH5qitbU40H+ffK7PiyYANdQ+eUF/vEZG2VAu4UysBZFWH8AV/ElcABpZ/vMINpWtFz6d3xnNQftNrUtxqxNXUMUMscBKeTx9eBFQjGkCE6jKNEWq17P7q/ZS210T7iNXUNVE9jqEQBk8ZY1TZNa+pUnFDajnYsf5Nq005XIdrfig50XgfqfNJB1gdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pr8jP+OsRvTmV8ZrkWhX0ljNDB1gQXwrABhvIRnp/PY=;
 b=dMAdKM2DiiPLvCg3BNs+/ReJPwgUUYFgq7ytc3ufAkVLYoaQ7/JFSEw5tF3dfN06nKJLlZ2twdBm981C/CfEcWswHRurCrjotEjXPkr+lpoz7EKaH4a26ub0tkI09t1Li0yctpBaOb4m10lHU2MCecqpnCrwXafwgmr2gohZP4ELxMd54onhS6jaJdh1frAS6HYoa1LRxTzkbPMJtjWss3uPKXh6naEDK5hoQ2rGT2DCUrxv8M3d8xy6qmkvam2xr+3XmGQF2K7yKQ0GDkyDKE1P/0uY93LDh6/4ObYINbD4GbqdF2n5WNGEEvrxj8M5H/X7qAsIMTnVkFo0whQhbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr8jP+OsRvTmV8ZrkWhX0ljNDB1gQXwrABhvIRnp/PY=;
 b=c7NTHLFhLw5MQdRtzofEASN5Go5lf/VHGHzUkjfVnHfbK4aPTU0dSczG9OfFwCIxW76D9pg7VLuDoqOdWmRb0n0Xso3TChEQaP2ux0F85mqqpkS0JD/CZzhqvKqOdYWKL+fvrC3ksGEbnIGMBgidVx+zWvq+6OCOfZi3PCuPwN3tF6VFvWWrLr2YOGpcSRznb6MzLvutFheW9oVeiIqvBd3Ob45/3/e6Yt/F4KFXhg6y+md6IK9Sf76Hf6psaVdPtJYRBMczdVzVU0GElaZTGUBW0MxTUel9OhzH6gwTMD/Gp1zl79qSQIo5yQozGwN0z/wlIsZLbtYcq92OZb/vrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6507.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 22:37:21 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 22:37:21 +0000
Message-ID: <70457e87-e596-4f32-a9f9-e5ce4e3149e5@efficios.com>
Date: Thu, 4 Sep 2025 18:37:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 16/37] From: Thomas Gleixner <tglx@linutronix.de>
 65;7006;1cSubject: rseq: Provide tracepoint wrappers for inline code Date:
 Sat, 23 Aug 2025 18:39:45 +0200
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250904185336.943880027@linutronix.de>
 <20250904185720.150944384@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250904185720.150944384@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::11) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa55999-5bfe-4a1b-6525-08ddec039ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|7053199007|21042699012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDJ6aElrd0VyRVNCbW5IdWkwMlNrWHlqTlJRS29NYTlXVmhXcWpsTUpnV1lC?=
 =?utf-8?B?VFBGTjZaRy80MUttdmI3Y0ZGWnJVSVlrakhjdm9TZGY0RTBhM0FBdGd1OWhp?=
 =?utf-8?B?MG1VOC9xSUpXeGY1YkpoU0IvNGwxbEhMYW5jU216ZkVrTkxpd0ZvUk1SWlVi?=
 =?utf-8?B?UTlvVFNDM0hlcnNEK09rRGZ6bWlNSThrcXp5c1VKanlpazBzYmJyWkRYaHpv?=
 =?utf-8?B?MG5qSzJudXIwWTVKZmNhY21RQ1FDdktEZ0k5cUdsNnlRZzJRWGNDV3VzYVp1?=
 =?utf-8?B?c3NpRlUwV09JaGJpdmhtQTJBWW83VG9PM1d0N3BVbG00TXFJcnpKRndSSkRL?=
 =?utf-8?B?TWN4SkZHdmMvdHJ2L3BmbjFVQjd1OEtvWkNiNlozV3NHWmdLRmFib1N3VWhi?=
 =?utf-8?B?Y0JYUE0zZEhSY3J2N0dMTDVBYWlIVWdOWHhXemdzZE9SUWdCOFNjT3MwTEdQ?=
 =?utf-8?B?NDFVS2tiMkRYZGdFa3dXQWE1MEpGU2ltVjRJTEZOalJISm5LdVVGU3VkZkZI?=
 =?utf-8?B?YlZvdmlMVVU1Vnhhek1waXpCVDk0bEhlRERhRVhkbjZxdmJ5ZjFpSTlTZ0xC?=
 =?utf-8?B?YmxEUWZaRXNjVWg1ZTNTNDA2UkVlWmh2UUtvWEhmY0dVWFA1ajNiL095NHAv?=
 =?utf-8?B?NGYxSEd1K3V1dmlEcGdIMHJCa3VKV204NHZ6cEllbU1tMGRzdFA2alB3MXRt?=
 =?utf-8?B?UVgyeGVxVzJLNGpmcDcyVzFaclhTbE1tQlUzV0MyMEErVGkwSE9FcEc2dEtN?=
 =?utf-8?B?dnplTm1wdE1PNXJIWEN5TEduZnY5YzdodXQ1RHBGNDcvTmVTR0E0QUlDY09C?=
 =?utf-8?B?T0lFYVA5Mmlac0VIZGFIYldhaG1RTkc3R3l5dStIamtaZ0xvcFdjc1ZJcWg4?=
 =?utf-8?B?YitwVkxXVG9BNC9Nc0xGaUpSNEZWN3hsZzl2S0VPcTl3ak8vZFpWaURXbjAv?=
 =?utf-8?B?bTgxakVRSUdCVjU1cUhrb0dvOGVKYzJldTd3N0JRZ2Y2SGFBMExKeElOUzZL?=
 =?utf-8?B?RUFCdlRJblF2QXI2Z0xQNFRSZEJJY0ZOL3VPWWhMMWw5dUNnSmVUOFByUllw?=
 =?utf-8?B?VFdJWjdCMDNWZFFPYks3V3RHek4xcEMxbm94cXpVSVFmNEtlaDJTY3JaUHVh?=
 =?utf-8?B?WWcxTHg0WEY2amk4ODlPRHZqM3dkZlg2YS81TEMvd1FTZzNYSmpQSnVjeTdN?=
 =?utf-8?B?cEMxMEk5Y2lleGFTaVA2alNKWHNkN0tsQzdRL2p0Z05rY1plLzBoVldxZERP?=
 =?utf-8?B?RTZqdStkc0lLa01VbDY3NTdTTk5CakE2bFdvVjlVeFdGSHRTRUp2cmpkczRh?=
 =?utf-8?B?Vy94OUR2OWp3dW1vYzhGbFNSZWZ0VnJvUC84OEQxRW52NVVmNEI2ZGFPQThn?=
 =?utf-8?B?SHNxMXpSQ1ZHazZZSHJ3Y3NKY3lvZUZJNDdleCs2RDFXNmttUndtU3RNb1FF?=
 =?utf-8?B?TnZsZjJ2R0t3SDRzWkx3SlNGOVhUdEVwMjE4VGlicjRneWlMR3V0T1l0Nzgy?=
 =?utf-8?B?UEkxVDNzT3V6aVBLT1dzcnAwVUhmajYzMXpwMmlQRkxNTk9KcVZZd2llcWRa?=
 =?utf-8?B?ZW5Pd044TmhnTXRSQVk3d0Rma2FmNS9kZjVzZmlDTy83V1IrSDJkaUw0K1NQ?=
 =?utf-8?B?NkFkaHlhQmV2SlZjVWVvSnN4OW1pN0lyTkhVaXVDUE1MbXVPbVoxTXFXeWdp?=
 =?utf-8?B?K0xiNVZEN3B6ZlVtOE45RlRlL3NWQWlLWVYxaS9NTEdnSG43QzdkaEJuc2dV?=
 =?utf-8?B?OWFyNHl4UUVWT25acHlxaGtPVForZ1RvZ3JOZFhqd29IdHhneld2ZmtzMFhG?=
 =?utf-8?B?OTJZVjZnUzIwTDUxVDYrWVhKZk5mLzBSdDdZY0QrSTB1alBvR3RaeTFhTFlw?=
 =?utf-8?B?am9LVWlzR1BpSnFZZnJiRExOTVdvZWlRL2I5dEIvV05SaXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(7053199007)(21042699012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU10enZCVEt1Q043S25NZGZrY3lVeDhmUS9hSG8vMUJBWUhadUpETkpDVTlF?=
 =?utf-8?B?N3N0SzA5cVZNY2t3SWEyY2w5UFAxanJxS1p5NmRNSEhJTTNyM3ZjTnhoNEFM?=
 =?utf-8?B?V3ovWHNvc1JDTmZNYUxiUXBHdlNrOFRRK0VMTnJMLzVnci9CL0U2WTBpNitx?=
 =?utf-8?B?Ry8yblRqMlZDR2I5cEpjalNURTBFSkNtdjRuZXpiSURRanpFajhaUzk1Z1B4?=
 =?utf-8?B?VTcyRmFCSDIwU2dKY3NmN1FBN3p4VFh2UGx6alhpWlB2ZHNZVm5SQ0Urc1Y0?=
 =?utf-8?B?SGVoN3FHYlJCU0ltbHYwdmxaaTZoT3BuUFhVRENKRCs2eFp0cG1jeGxDU240?=
 =?utf-8?B?aDYwdG5OcWRZaDY1MlMwbUR2bU1MaEhZV0dvbERaL3lkRGZwTXRHb0dUSFRs?=
 =?utf-8?B?WmlRVFg2QWNZYmNTZWpoc3BrK1lhSUxQdnRYMXlBT3ZVUFRSMnNLNTBzQStP?=
 =?utf-8?B?d2VzUm9zRWIrckRUVHBreFJRblR3RzY4ZmdKclJiNUtzblRaWWFja0FGRUtZ?=
 =?utf-8?B?MWlHekgzV29GNG5hZHVZcUFpQTZOdVlyNnR5cnFFaUEyUUpkd0NISVduSFZV?=
 =?utf-8?B?UWRxOVF5QzRobTdMUnBkRFFEd2RLWUlrNU9ka2hubUxnU0lVSitoQmtzK2RM?=
 =?utf-8?B?V2o2UGh1cW52MGJCVTlHOVg1a3U1eDYySXZXcVJnb2RheWJleGNLbWVWN21C?=
 =?utf-8?B?ZUJ4Q3dscHFUeUU5ay83NTVZNStjT1Evd3VldmVhVzkraUEvZ3RETHNIRE1Y?=
 =?utf-8?B?dXA1K0VZbXgrWTc0VkpidXpFUjBJeEJZK1VWZ1lULzkxSnhET0hVSktQOHY1?=
 =?utf-8?B?QnNkTWQ2dk5IRTB6UmNnMTlITFhCRS8vVTNiaTV6eDRtNmhmSTRkWDNRcUR6?=
 =?utf-8?B?NU1DaUZyblllVnZoZHpiWXZ0U2E1dHF0cEZpTW4wZ25UQ3N1SVdIZnZlOWdO?=
 =?utf-8?B?dzluQ2hmTFEyUkdTWmZJcDhMb0lFNU9GLzlWM3FLaVVJUXJBaFRSeUVRQkEv?=
 =?utf-8?B?VzhjWERSazdaQk9RbXVHblcyaUlScE1qOE9ycDNOR2MyWU11YUVKTDJHQVBO?=
 =?utf-8?B?ZEdQOXU1UzBVSXVBY1VJNkdFMjhxamgyRXdrRWt1OThaRW1PTU9IVWFZU3B4?=
 =?utf-8?B?aVI4c0xiOTVUNmVhOGkvbVlVNmlZY3F3QUdXN2lXVWI0SnVYOGRSUUtjcDZ6?=
 =?utf-8?B?ejNWSkFXRlBvUmtqeld2RWFzK0tPcnY2bkpEWi9qWTg1M0dJY3hnUTFycXNq?=
 =?utf-8?B?Y3JHbXFIWXp0dG5kVXhkTXkxZ3JTTGZFQWZlR0VUY3RQcll0THIrU1JtS1J6?=
 =?utf-8?B?TDdWZkNrbG50SklpSWFyYTN0K29HbXhSdlJJN25YUWNjZ05QanYyc3JSWG1k?=
 =?utf-8?B?V3V6cUJ3T0w1QjZmWE1xU2R2UTF0ZzFIVkhpWlZBQzAwMUpkNG9iNWVCOTFV?=
 =?utf-8?B?Q25EQXoxM3hyUEc3b0JBVkhiL2I0SmZtSzIvN3RydXBBSmdLVURNQzNnNzlD?=
 =?utf-8?B?anNlTlVvQVV5S3FnSWZqYVU3Slh6QlorZFJIZmdLOEVXRVhPVUNVbVFLTDBG?=
 =?utf-8?B?b2ZGYzQ5K09HUlZjdTg4N2JZZWt3RXVyZDZNcWdrNFhjOHkrUlc0cDNVYkJB?=
 =?utf-8?B?SGVTeGlhODVhRG9hVEZDbTI2UURGRDJ6SW9OQ2ZMYTNqT2k4cnc0dkFHYkx4?=
 =?utf-8?B?T1NFMnNvd2xxVTNrRWkyTDRwVjRqdkIxRFFQcWwwbHBMMzNlZEdhazdjRm5S?=
 =?utf-8?B?djRZREtxaUROcWlwOU9mM2hzQzJDWVFLS3FVZ0tVK2NNN0Q2SUxtTDhYcC93?=
 =?utf-8?B?bHE4VmJMNUFpQTNJWU5Nem1ma3lpZ1pDcmR4ZzNna09YelJoOHh1WDNiaG9Y?=
 =?utf-8?B?U0FNVS94Qk92Z0QzVFRnczVodzFkbDZUVk5VQnB1Y3JScXRsT1htY29sYkpO?=
 =?utf-8?B?SnV0VWRZVzhEWi81VHZTT2k0elE3MUE2UkNkQnBOc3BieGJZWXJjQWdKUm5D?=
 =?utf-8?B?cGs3NnlZbHdOU1JtU041OXJzazM3YlF2ZVhnVVdNNUgvSy92b0k4Z0tVYlRP?=
 =?utf-8?B?K1BrVmlKSm1heFlzcWkrS1hSRkhyTnA1VDBwZ2V4TEsvbFMveC9DNVhHRmp1?=
 =?utf-8?B?VW5CKzYydjFwQUlMbUR6NjBqRmRPaHc0cVgrWVBlVE9wWXZadDVoQVhENXpG?=
 =?utf-8?B?SWZOU3BudXdLM1JYWUpxdjVER21STWppaGd6VGR3Nm84OTdiaWNLQndZbFFX?=
 =?utf-8?Q?Qv0xtnTB6Oq3r2nBopv5SL6EQfVL87AOkm9jNJNGvQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa55999-5bfe-4a1b-6525-08ddec039ca9
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 22:37:21.5428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ld/zlJMY4QAXVDbylomNPeRbq4GNnYcdDQKBRkjNRh3WS2Ci34epXqhDxMd565SEADxW6x6X3Pl7Fq5aBCW4WSIMgTcpIZe/pX6R+/yyvig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6507

On 2025-09-04 18:21, Thomas Gleixner wrote:
> Provide tracepoint wrappers for the upcoming RSEQ exit to user space inline
> fast path, so that the header can be safely included by code which defines
> actual trace points.

Note: the Subject of this patch is weird here.

Thanks,

Mathieu

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> V3: Get rid of one indentation level - Mathieu
> ---
>   include/linux/rseq_entry.h |   28 ++++++++++++++++++++++++++++
>   kernel/rseq.c              |   17 +++++++++++++++++
>   2 files changed, 45 insertions(+)
> 
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -5,6 +5,34 @@
>   #ifdef CONFIG_RSEQ
>   #include <linux/rseq.h>
>   
> +#include <linux/tracepoint-defs.h>
> +
> +#ifdef CONFIG_TRACEPOINTS
> +DECLARE_TRACEPOINT(rseq_update);
> +DECLARE_TRACEPOINT(rseq_ip_fixup);
> +void __rseq_trace_update(struct task_struct *t);
> +void __rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
> +			   unsigned long offset, unsigned long abort_ip);
> +
> +static inline void rseq_trace_update(struct task_struct *t, struct rseq_ids *ids)
> +{
> +	if (tracepoint_enabled(rseq_update) && ids)
> +		__rseq_trace_update(t);
> +}
> +
> +static inline void rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
> +				       unsigned long offset, unsigned long abort_ip)
> +{
> +	if (tracepoint_enabled(rseq_ip_fixup))
> +		__rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
> +}
> +
> +#else /* CONFIG_TRACEPOINT */
> +static inline void rseq_trace_update(struct task_struct *t) { }
> +static inline void rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
> +				       unsigned long offset, unsigned long abort_ip) { }
> +#endif /* !CONFIG_TRACEPOINT */
> +
>   static __always_inline void rseq_note_user_irq_entry(void)
>   {
>   	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -91,6 +91,23 @@
>   				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
>   				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
>   
> +#ifdef CONFIG_TRACEPOINTS
> +/*
> + * Out of line, so the actual update functions can be in a header to be
> + * inlined into the exit to user code.
> + */
> +void __rseq_trace_update(struct task_struct *t)
> +{
> +	trace_rseq_update(t);
> +}
> +
> +void __rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
> +			   unsigned long offset, unsigned long abort_ip)
> +{
> +	trace_rseq_ip_fixup(ip, start_ip, offset, abort_ip);
> +}
> +#endif /* CONFIG_TRACEPOINTS */
> +
>   #ifdef CONFIG_DEBUG_RSEQ
>   static struct rseq *rseq_kernel_fields(struct task_struct *t)
>   {
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

