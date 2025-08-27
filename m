Return-Path: <linux-kernel+bounces-788407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11287B383EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8240C5E047C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1F03009FA;
	Wed, 27 Aug 2025 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PfsAQx4z"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2131.outbound.protection.outlook.com [40.107.116.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD00E72627
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302347; cv=fail; b=MGx+tzSpX0W1siDoEuWYln3YN46A7T38rAwP+IK9Uz5eifiFBsAr7sClDQ/qWIEBMW0JDX4DJUe3alw9b37vyyd3NGDnCYKTS0/gnzgaKSk7+TDdDeY40dV7m58NHXH8mYeu5F+2mD7PTP6AOTpyi1YVnIz9D8/pgcpIhYRC6aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302347; c=relaxed/simple;
	bh=R4X+UnteTk+wU7JUodYlCOHOmOb37HpJUePX5/b+2J0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hNDcl5lGlrZhHDGVetOSfh8jvmvDMGb3zSr2Z5jxs4Hp7YOotE2z/zlamI45rFv3RXOD+99TRt+jaz4bBdDJz/ubqoUsBYQrgjII/VUWMfVOfIdCSTlLcka2Z6fMGjQ7Xik9KTSojokiJzTIFCQSG4eY29IFPoIp1Eq0Lga3ASQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PfsAQx4z; arc=fail smtp.client-ip=40.107.116.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5LrCOBwAeKbRP+p5bVFwU+bTELg1QEMuEI8Mr1PE88ogwteWHxZ+c96Nmi78yxKVWYNrUSu1NBXWOR08qPwiaQosSh+aG0JjMUBhP5LWcgNuWsZPOIF6lhwtlALta29h+vRCeY0eKVAaK7Pwoqf5sQspoC69FyJbM4XmUGk/01wPPOjbFv6pEPQEcuCjo+op7pZniKARAEFr2+PtyDGpzLMWi/yQ6ToBQUnfeHbD0aXWtz5nye+lvZxeLMGibo+81CWlwkab5ozSbHvsXH6VlaVLHW+8u5btnvPYCEos/QKPpfAQHXuEtvZGsxBnxQMbbl4faX9/kKMXmvsdlnsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtwyIF03T1HR6A6DPGEtVFHodrC7m8Tm2HrOozr5hlM=;
 b=WKoEUcydmZUWnxIwiPkq8rMsSZrXRNVs1CiWuw5RpINk4Oux5hCoXUXlWYCwEJV/taKuOKlAIAqlcJGpc0+ql/H6GspGSVjSrcR0PmV5BvmiDlOqP+0WkZPHICUzBkw7l4rxWgf9SwnHbs5gnpfXT3ozyHAAfJAvOfgxUiL9p1KILF8/5HcCs/VSMMqwwvzTIdAv1P/mP4J4irA+4O4GKqUDbnLl/43C/qZzritOnnW5vm5e4SsWk2gyp4G23i5amwqFcIduQJa+NC2wXQP3z/M9ZUMpanUqhZVKSsqzCsDMLFIbQN8PKK7g5d9OOOkvnBkVxh2C4F9pqDZHO0sdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtwyIF03T1HR6A6DPGEtVFHodrC7m8Tm2HrOozr5hlM=;
 b=PfsAQx4zUV3scloIQETtURHamf2+dEsuPxWbwW5QGcn21cXxhd6cQxrXT2FS61R6IDaPE/YQYDmYNiysRkq+Pn4Mp2MuDwJhmrMJ0XZdkPyV5aRur2aVI5m6bZ8aMfV6dgARAAeD6IIW1JIyk1mPnbjav/9dc7HHG9h8J7rerutGcFHCnBKfBVN0MtJ+bJY2Tp/6dVc9lV41gP3K54uLvLGT0DiLrysP9AQ13KLJhPP/KM7mjFsPoJf0KYzWidO31kzRwl97kVejqj+iF1KFrJJpG5C5xquMvUgzDEUU51RxyYyX2qpLrmne3+4jIRadOaMI0QxTHPr5wmrr3U9ZVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by TO1PPFAB0CDCD34.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::678) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 13:45:40 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Wed, 27 Aug 2025
 13:45:40 +0000
Message-ID: <02e74cef-f2fe-4590-8921-ef4df2b24786@efficios.com>
Date: Wed, 27 Aug 2025 09:45:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 28/37] rseq: Switch to fast path processing on exit to
 user
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 <20250823161655.063205235@linutronix.de>
 <bf216d3c-9d9a-45e4-b7a6-64c0c3cbe6ed@efficios.com>
Content-Language: en-US
In-Reply-To: <bf216d3c-9d9a-45e4-b7a6-64c0c3cbe6ed@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|TO1PPFAB0CDCD34:EE_
X-MS-Office365-Filtering-Correlation-Id: defc4c51-2944-4939-b65d-08dde5700298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzhMNEVsQ1c3Q2lxclNvOVAxYmZsRUdKMGJCYzc1dGFLZHJiSzZZNVZLWkNE?=
 =?utf-8?B?S3k3NUtYVWJPRG1xdG9LT2xxQ2l2RW1weGpTaWc5bmNTMlNwNENzVFErTkF5?=
 =?utf-8?B?Uk1CcEZkOVBKNi9FWUdzNmhBaWlyRFFqZFpMUU10WGRBRDJ2YXZINUM0NnZE?=
 =?utf-8?B?OXJScWs5V0xwOUtzNjA0RkxlY3MxODJTUXh5aldkbXRQSk0rckhBaHY1Z0JX?=
 =?utf-8?B?WlN3QURudDVLcjM2V1Q0ZDNOVklsMmd3RkxGbFdJY0JYdlVDa3VBUlA3ZkRr?=
 =?utf-8?B?VTlDOUdDdzhCbldPY29lMHNpc1Y3czF1U3I1T21Fd2VOQXZLWlNtd3lNSU0r?=
 =?utf-8?B?SWZjWjBKTXdOOGNnMlZlWGw0Y2VxNm9yV3hyMU82RzdIcml3VGdHOHRzU2xp?=
 =?utf-8?B?OVlLNlpQQVlhT09vekoyQjBmbFBhSzdjU0FEQmt0VE8yUE1pNmZJUWdEbWFx?=
 =?utf-8?B?cVBFdVhrMmdMOHBQV1p3VFRwNGdrV3FaeWd4YWJYb1dOdjVPYXFKRmppQUtY?=
 =?utf-8?B?RUhXSmFBMGQyNmUzR3lhWkZUQlpaUWVoS1lEZEtKTVhIQkNRM0dSUHo2dWs5?=
 =?utf-8?B?d3JyL0VTaGFXZHRuRGloTUp2M0tqenVXT1k5aVZVcktFRkxFdUZCN0dsajV4?=
 =?utf-8?B?ZG85SmJZTDdqN2dlNndSU0FEcnlZcmlsRDJQQXVMRDRDUUJZNjdBMkxmRGgz?=
 =?utf-8?B?T0FWM016TXdzU1NlNGFtUCtCQzkzZC9GVlgrd1NJbU5YZFhyOXRXNG9LZG5j?=
 =?utf-8?B?dCt0VHo5STF0N01WZ1F4VUVHL0c3a3MzTnh5Z3Nwd0pXeTJndkcrdTlGRlRQ?=
 =?utf-8?B?VlpNbFBVVjhkRG5JNnd3OWx2S2YwV2VGWlhiS1lCQmMrR3VIZEQwUjZXUHc0?=
 =?utf-8?B?c1d4bHRpSmNGdlR5cllKNnprdlVvS3g3NVErYUxaOUd5QzZGY1VWb25qQldJ?=
 =?utf-8?B?LzZma2NvNWtpQVdTRXZwaVVva0hTL3lJeVA2dGd5NGtTcVcxcU5sNE5teDdh?=
 =?utf-8?B?TlM5b3haOXFyRm1FKzJ3cCszM2NuSFJvNWlaalBpQTM3TzhuWFVPTVprSWln?=
 =?utf-8?B?VGxva0g3eTd2TjhiTmxKUlhtaG02RTY2MytCNWVZZEw1bFlsK0NlRmxGNjRC?=
 =?utf-8?B?L3d5cE9sYnY2VXljM2JrNnoxM1ZaZnYwdFQ4VGpwNjFhQndObmN4dXVjWmVX?=
 =?utf-8?B?aFo1N1Vmbk44Mk41OVlGUnJFK2FZK1p4NmN1TW43WTRmRldnQlNhRlJFVEUz?=
 =?utf-8?B?OThBWEFBejEyRHdrM2hpdHgyMkFmdVlPa2JpSHRNNjg1MUJ5TE9ycWdUREdS?=
 =?utf-8?B?KzMrbnUyOHplZ0x1ZXJlVmpVYzB4NEJtTW1IUVhuZXZVU1ZZUzJyRnhlOTdN?=
 =?utf-8?B?V0VPdXJHUGd5VkpYcWxUWVUvZ0hrZm12Z0x2UmlmanREcFl0RHZBK3pqTWxC?=
 =?utf-8?B?VUtvSnZSSVJwM0Qwb2ZKdW5sN2tYNHBlUVI4NWxrQWFUT3FsWTl6bU00ZElT?=
 =?utf-8?B?UHVESU9Vb01QUjBScWhzM2NiaXdhS1BPN0g4MGF0SGErSkNHVEVhOXJoL1NC?=
 =?utf-8?B?OHVRWjBwZHljcTdlcVpFbjdBVG1Zd3VwNzB2djVLNDRvSTNxOXY0S2YraFEy?=
 =?utf-8?B?cXJVMHBiUkZCRzNpZWtzZ3ptQzFybWZhS1Zma3laWFNLZiswQVRKUVVJdFJH?=
 =?utf-8?B?ZDBNNndYcGxrQmVROEVXMUFISzlBNHR2dEczU2ZVZ2Jnb1ZWVDd0ckpuUW1H?=
 =?utf-8?B?Sm5KL3R6V1ZjdEFmTmtOUzRhVEc0bGMyeWVmM0JaaHVOWC9vVExhb1poTjBq?=
 =?utf-8?Q?eyT9DuXjQqqh09076O6JxZ1ttwncn3tk+/1Qk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djR6dFlHTkR5UTU3YmRtdGJsVDNYMDBCQnNKTVBqUzJZQ2JtL010b1RyNWs1?=
 =?utf-8?B?UkpiMTFEcC9NSTBydlhLZmVDaTRjd0RaL2JTdFVJMU5UM0R4dVFIdzltZkVq?=
 =?utf-8?B?RGlPU29kUDB5YkIzd1J2bE1abC9GMlFrWVM2R2ZWU3B6MkVKb0dnTCt6Y29i?=
 =?utf-8?B?M0huMzBmaDFtRnUrQTB0TGFEeGQySUtIc3NMSTh2Uy9qMXROUGxVWENSVUcz?=
 =?utf-8?B?b1E2OFRnL3lkTGtOZzY0WlVDd3F3cUdhNGxXKzF0b09ydUN3TzlxNUtFM1ZV?=
 =?utf-8?B?SVdWaHpwZlJDYkk2d1JwYjd4a2x0cjQ5OFFYWERnbmc4czViSlBZczBVNHk4?=
 =?utf-8?B?Q2xQNjd1dy9FK2dFc0RUN3I2K1R5QTBKamdLR20xWVE3QlRMcXJXTUNqaFRS?=
 =?utf-8?B?LzFZWU9BQWV4NHVTNFhlYjFINll3SVdzVzZPMTRIZFBxSTdMaWJXRWRSNXU4?=
 =?utf-8?B?cXk5RWJYMzNsaDRKcEhuOHZyTXVlcnFIa2lSN3VGNnBBUG5yZXdmTm1VRzRL?=
 =?utf-8?B?bHdwOGFUZ1FheGR2b2JyWmwwQTVDUEhPa013TVFuQ1NVaTdCdkhKTXlOd0NR?=
 =?utf-8?B?ZllhZnBtaFh2R3RORGU5eW9ON1dYVmdwNzhWQ2d2eWdicXd5R0swTmRWMm9B?=
 =?utf-8?B?WHNqS1dmQnpGTWJKbFMrOUFUMHIzZVhpa25FOG9ZUXQzWmxManMxUkNQQ2Rv?=
 =?utf-8?B?MGYzZTVWTlRzM1c0RU5PUzhrYmFldVVQV1p3UWlsdmJ0MmhWMVFQT2RtaWRy?=
 =?utf-8?B?M3VDSDZnYVhUakRPWGtKNnhYMFc1TzMwZ2xkUWJ3SXBiMkgySitmV0wxZmRW?=
 =?utf-8?B?dTNYRktvWlpJUlE4ZGVGMzAwQmxSblFaQksyZUQzbC96WE1oaDJaODc4dzJx?=
 =?utf-8?B?VHQvR2NlblRZdnFTOHFBY1A3U2doREFpUmRpdG5IeTlWV1dYUVJYK1hqOUhR?=
 =?utf-8?B?aWFNdWdUMm5mSEFWOHdYOUVYb1pkbmtIM0xSbmZ4VnQ3RjQ4OGtPcW5ndmJW?=
 =?utf-8?B?MUFoTUpHWDJVSENvbk42ckNWTEpHZENremhWOW1TUDRCeG0zT0xzZzc4dDU0?=
 =?utf-8?B?V2hpZ1BMUHlRNm8yS1BTa082WWRMbnFROHNYeTN1NHMzTjdld1JrZ1ZXYW9F?=
 =?utf-8?B?UThvMC9nVkR0Q3R3QVZTek9JRjBuNmZyaFNCQ1VDNVdOYlhQcTZVajZaU3NK?=
 =?utf-8?B?Y3FqZVc5VEpWK0NlTkxNQjJrbzFlcHRncDJZMlc5Sld5S282T1ZWQmdLM2I0?=
 =?utf-8?B?RlpTVDJiWGRaWjZ3ZUFQY0plcXFnMjlkU1pxZ20rU0l2R3JaTXBETCthTjFK?=
 =?utf-8?B?b0x5SC9JbTl6cXZBcUNUeFE3aUgwc29CeWpBRitqY0RnbmJubmZQN1VlQXBn?=
 =?utf-8?B?anhGQUNyQWI0V004MFc1RHZna0dVbE5MUkZ6N2ZhanNUdEtNZ2swaDUyOWtW?=
 =?utf-8?B?bkZHYWdrSDBIc3dEeGdkNlUyRFlCaTFLdVZVZ2J6Nk51d2pPNnlEYmNYWFc3?=
 =?utf-8?B?VU9qMzJyTGtXc2ZobWJaS0xoZXJEQ1E3NEZvS0Rxb2xHRkgzWk96aUtQS1RE?=
 =?utf-8?B?RDZWZGZ2dHdTNE8wVjZEdWdlZkdFeXdlbFpEU3FWVmRDVzFmVHc0djFVMHVK?=
 =?utf-8?B?SFlQRXFCTDJNQjR2bHVLOUdaNXYvcUFUR1pTVDFPL1hSSHArcEx6WDN2Q3pm?=
 =?utf-8?B?dDZrSFpXdTQ3VjZsQ1FMUzR0ZnJCbjhXeHo4ZDcrVFQvNXFWZ2ZGWW9zYmUw?=
 =?utf-8?B?MUdVODIvYWxPNmg4bUZMZG11MlRUbDY0TkRrMlo4V1g5RFlheEdCTVRXYjJW?=
 =?utf-8?B?Mng2eTFDT1hkanFxOGpuUXozVVRCSWlOYy9iSjVsNURVQm8vT2RVNlZKa0Zs?=
 =?utf-8?B?WitzbDRhR1JxM0hKb0xJai85dEtUL3l2TTBvU3lKMzhBT2xWa2IxOERpMkN1?=
 =?utf-8?B?cXVsRjRmdkZyUGdValg2Z3N6UHBPZmQzTjhZdEhlaGxpWlU3V0ptSE1qbGsr?=
 =?utf-8?B?NGhRUi8wSkU4U3ZISXZ5aExnYURXRHM1RXpWWlFVWVpkRFJRNlFaaHZnNkVE?=
 =?utf-8?B?MW1nOEYwL0c1YlRVRm5OYk14dmRIRkJObDlpTmVLQ3RrbndNN3lFT1NGYUFW?=
 =?utf-8?B?b3FXTXJqZUEwQmJSclJzekRCWVZTV045N3EzdzBEaVora2tySlp2OGtVMHRJ?=
 =?utf-8?Q?YYY7cmib3mKvTNwuQ5xR600=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defc4c51-2944-4939-b65d-08dde5700298
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 13:45:40.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkRYnc5vsCmA4BrAylDbuOMK9GonsISA+q39PP81yMicy8KZc94VsAjZtqHLdmNFj31+P8AO9VsCzftcfDkhpVdX5qbaXrAmbI6oRq/IbbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPFAB0CDCD34

On 2025-08-26 11:40, Mathieu Desnoyers wrote:
> On 2025-08-23 12:40, Thomas Gleixner wrote:
>> Now that all bits and pieces are in place, hook the RSEQ handling fast 
>> path
>> function into exit_to_user_mode_prepare() after the TIF work bits have 
>> been
>> handled. If case of fast path failure, TIF_NOTIFY_RESUME has been raised
>> and the caller needs to take another turn through the TIF handling slow
>> path.
>>
>> This only works for architectures, which use the generic entry code.
>> Architectures, who still have their own incomplete hacks are not 
>> supported
>> and won't be.
>>
>> This results in the following improvements:
>>
>>    Kernel build           Before          After              Reduction
>>
>>    exit to user         80692981          80514451
>>    signal checks:          32581               121           99%
>>    slowpath runs:        1201408   1.49%           198 0.00%      100%
>>    fastpath runs:                         675941 0.84%       N/A
>>    id updates:           1233989   1.53%         50541 0.06%       96%
>>    cs checks:            1125366   1.39%             0 0.00%      100%
>>      cs cleared:         1125366      100%     0            100%
>>      cs fixup:                 0        0%     0
>>
>>    RSEQ selftests      Before          After              Reduction
>>
>>    exit to user:       386281778          387373750
>>    signal checks:       35661203                  0           100%
>>    slowpath runs:      140542396 36.38%            100  0.00%    100%
>>    fastpath runs:                         9509789  2.51%     N/A
>>    id updates:         176203599 45.62%        9087994  2.35%     95%
>>    cs checks:          175587856 45.46%        4728394  1.22%     98%
>>      cs cleared:       172359544   98.16%    1319307   27.90%   99%
>>      cs fixup:           3228312    1.84%    3409087   72.10%

By the way, you should really not be using the entire rseq selftests
as a representative workload for profiling the kernel rseq implementation.

Those selftests include "loop injection", "yield injection", "kill
injection" and "sleep injection" within the relevant userspace code
paths, which really increase the likelihood of hitting stuff like
"cs fixup" compared to anything that comes close to a realistic
use-case. This is really useful for testing correctness, but not
for profiling. For instance, the "loop injection" introduces busy
loops within rseq critical sections to significantly increase the
likelihood of hitting a cs fixup.

Those specific selftests are really just "stress-tests" that don't
represent any relevant workload.

The rseq selftests that are more relevant for the type of profiling
you are trying to do here are the "param_test_benchmark". Those
entirely compile-out the injection code and focus on the performance
of rseq fast-path under heavy use. This is already more representative
of a semi-realistic "super-heavy" rseq use workload (you could see it
as a rseq worse-case use upper bound).

I suspect that using this for profiling, you will find out that
optimizing the "cs fixup" code path is not relevant.

The following script runs the "benchmark" tests, which are more relevant
for profiling:

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 0d0a5fae5954..30339183f8a2 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -21,7 +21,7 @@ TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test p
  
  TEST_GEN_PROGS_EXTENDED = librseq.so
  
-TEST_PROGS = run_param_test.sh run_syscall_errors_test.sh
+TEST_PROGS = run_param_test.sh run_param_test_benchmark.sh run_syscall_errors_test.sh
  
  TEST_FILES := settings
  
diff --git a/tools/testing/selftests/rseq/run_param_test_benchmark.sh b/tools/testing/selftests/rseq/run_param_test_benchmark.sh
new file mode 100755
index 000000000000..17b3dfcfcdd4
--- /dev/null
+++ b/tools/testing/selftests/rseq/run_param_test_benchmark.sh
@@ -0,0 +1,49 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+ or MIT
+
+NR_CPUS=`grep '^processor' /proc/cpuinfo | wc -l`
+
+EXTRA_ARGS=${@}
+
+OLDIFS="$IFS"
+IFS=$'\n'
+TEST_LIST=(
+	"-T s"
+	"-T l"
+	"-T b"
+	"-T b -M"
+	"-T m"
+	"-T m -M"
+	"-T i"
+	"-T r"
+)
+
+TEST_NAME=(
+	"spinlock"
+	"list"
+	"buffer"
+	"buffer with barrier"
+	"memcpy"
+	"memcpy with barrier"
+	"increment"
+	"membarrier"
+)
+IFS="$OLDIFS"
+
+REPS=10000000
+NR_THREADS=$((6*${NR_CPUS}))
+
+function do_tests()
+{
+	local i=0
+	while [ "$i" -lt "${#TEST_LIST[@]}" ]; do
+		echo "Running benchmark test ${TEST_NAME[$i]}"
+		./param_test_benchmark ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
+
+		echo "Running mm_cid benchmark test ${TEST_NAME[$i]}"
+		./param_test_mm_cid_benchmark ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
+		let "i++"
+	done
+}
+
+do_tests

Thanks,

Mathieu

>>
>> The 'cs cleared' and 'cs fixup' percentanges are not relative to the exit
>> to user invocations, they are relative to the actual 'cs check'
>> invocations.
>>
>> While some of this could have been avoided in the original code, like the
>> obvious clearing of CS when it's already clear, the main problem of going
>> through TIF_NOTIFY_RESUME cannot be solved. In some workloads the RSEQ
>> notify handler is invoked more than once before going out to user
>> space. Doing this once when everything has stabilized is the only 
>> solution
>> to avoid this.
>>
>> The initial attempt to completely decouple it from the TIF work turned 
>> out
>> to be suboptimal for workloads, which do a lot of quick and short system
>> calls. Even if the fast path decision is only 4 instructions (including a
>> conditional branch), this adds up quickly and becomes measurable when the
>> rate for actually having to handle rseq is in the low single digit
>> percentage range of user/kernel transitions.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
>> ---
>>   include/linux/irq-entry-common.h |    7 ++-----
>>   include/linux/resume_user_mode.h |    2 +-
>>   include/linux/rseq.h             |   24 ++++++++++++++++++------
>>   include/linux/rseq_entry.h       |    2 +-
>>   init/Kconfig                     |    2 +-
>>   kernel/entry/common.c            |   17 ++++++++++++++---
>>   kernel/rseq.c                    |    8 ++++++--
>>   7 files changed, 43 insertions(+), 19 deletions(-)
>>
>> --- a/include/linux/irq-entry-common.h
>> +++ b/include/linux/irq-entry-common.h
>> @@ -197,11 +197,8 @@ static __always_inline void arch_exit_to
>>    */
>>   void arch_do_signal_or_restart(struct pt_regs *regs);
>> -/**
>> - * exit_to_user_mode_loop - do any pending work before leaving to 
>> user space
>> - */
>> -unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>> -                     unsigned long ti_work);
>> +/* Handle pending TIF work */
>> +unsigned long exit_to_user_mode_loop(struct pt_regs *regs, unsigned 
>> long ti_work);
>>   /**
>>    * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if 
>> required
>> --- a/include/linux/resume_user_mode.h
>> +++ b/include/linux/resume_user_mode.h
>> @@ -59,7 +59,7 @@ static inline void resume_user_mode_work
>>       mem_cgroup_handle_over_high(GFP_KERNEL);
>>       blkcg_maybe_throttle_current();
>> -    rseq_handle_notify_resume(regs);
>> +    rseq_handle_slowpath(regs);
>>   }
>>   #endif /* LINUX_RESUME_USER_MODE_H */
>> --- a/include/linux/rseq.h
>> +++ b/include/linux/rseq.h
>> @@ -5,13 +5,19 @@
>>   #ifdef CONFIG_RSEQ
>>   #include <linux/sched.h>
>> -void __rseq_handle_notify_resume(struct pt_regs *regs);
>> +void __rseq_handle_slowpath(struct pt_regs *regs);
>> -static inline void rseq_handle_notify_resume(struct pt_regs *regs)
>> +/* Invoked from resume_user_mode_work() */
>> +static inline void rseq_handle_slowpath(struct pt_regs *regs)
>>   {
>> -    /* '&' is intentional to spare one conditional branch */
>> -    if (current->rseq_event.sched_switch & current->rseq_event.has_rseq)
>> -        __rseq_handle_notify_resume(regs);
>> +    if (IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
>> +        if (current->rseq_event.slowpath)
>> +            __rseq_handle_slowpath(regs);
>> +    } else {
>> +        /* '&' is intentional to spare one conditional branch */
>> +        if (current->rseq_event.sched_switch & current- 
>> >rseq_event.has_rseq)
>> +            __rseq_handle_slowpath(regs);
>> +    }
>>   }
>>   void __rseq_signal_deliver(int sig, struct pt_regs *regs);
>> @@ -138,6 +144,12 @@ static inline void rseq_fork(struct task
>>           t->rseq_sig = current->rseq_sig;
>>           t->rseq_ids.cpu_cid = ~0ULL;
>>           t->rseq_event = current->rseq_event;
>> +        /*
>> +         * If it has rseq, force it into the slow path right away
>> +         * because it is guaranteed to fault.
>> +         */
>> +        if (t->rseq_event.has_rseq)
>> +            t->rseq_event.slowpath = true;
>>       }
>>   }
>> @@ -151,7 +163,7 @@ static inline void rseq_execve(struct ta
>>   }
>>   #else /* CONFIG_RSEQ */
>> -static inline void rseq_handle_notify_resume(struct ksignal *ksig, 
>> struct pt_regs *regs) { }
>> +static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
>>   static inline void rseq_signal_deliver(struct ksignal *ksig, struct 
>> pt_regs *regs) { }
>>   static inline void rseq_sched_switch_event(struct task_struct *t) { }
>>   static inline void rseq_sched_set_task_cpu(struct task_struct *t, 
>> unsigned int cpu) { }
>> --- a/include/linux/rseq_entry.h
>> +++ b/include/linux/rseq_entry.h
>> @@ -433,7 +433,7 @@ static rseq_inline bool rseq_update_usr(
>>    * tells the caller to loop back into exit_to_user_mode_loop(). The 
>> rseq
>>    * slow path there will handle the fail.
>>    */
>> -static __always_inline bool rseq_exit_to_user_mode_restart(struct 
>> pt_regs *regs)
>> +static __always_inline bool __rseq_exit_to_user_mode_restart(struct 
>> pt_regs *regs)
>>   {
>>       struct task_struct *t = current;
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1911,7 +1911,7 @@ config RSEQ_DEBUG_DEFAULT_ENABLE
>>   config DEBUG_RSEQ
>>       default n
>>       bool "Enable debugging of rseq() system call" if EXPERT
>> -    depends on RSEQ && DEBUG_KERNEL
>> +    depends on RSEQ && DEBUG_KERNEL && !GENERIC_ENTRY
>>       select RSEQ_DEBUG_DEFAULT_ENABLE
>>       help
>>         Enable extra debugging checks for the rseq system call.
>> --- a/kernel/entry/common.c
>> +++ b/kernel/entry/common.c
>> @@ -23,8 +23,7 @@ void __weak arch_do_signal_or_restart(st
>>        * Before returning to user space ensure that all pending work
>>        * items have been completed.
>>        */
>> -    while (ti_work & EXIT_TO_USER_MODE_WORK) {
>> -
>> +    do {
>>           local_irq_enable_exit_to_user(ti_work);
>>           if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
>> @@ -56,7 +55,19 @@ void __weak arch_do_signal_or_restart(st
>>           tick_nohz_user_enter_prepare();
>>           ti_work = read_thread_flags();
>> -    }
>> +
>> +        /*
>> +         * This returns the unmodified ti_work, when ti_work is not
>> +         * empty. In that case it waits for the next round to avoid
>> +         * multiple updates in case of rescheduling.
>> +         *
>> +         * When it handles rseq it returns either with empty work
>> +         * on success or with TIF_NOTIFY_RESUME set on failure to
>> +         * kick the handling into the slow path.
>> +         */
>> +        ti_work = rseq_exit_to_user_mode_work(regs, ti_work, 
>> EXIT_TO_USER_MODE_WORK);
>> +
>> +    } while (ti_work & EXIT_TO_USER_MODE_WORK);
>>       /* Return the latest work state for arch_exit_to_user_mode() */
>>       return ti_work;
>> --- a/kernel/rseq.c
>> +++ b/kernel/rseq.c
>> @@ -234,7 +234,11 @@ static bool rseq_handle_cs(struct task_s
>>   static void rseq_slowpath_update_usr(struct pt_regs *regs)
>>   {
>> -    /* Preserve rseq state and user_irq state for exit to user */
>> +    /*
>> +     * Preserve rseq state and user_irq state. The generic entry code
>> +     * clears user_irq on the way out, the non-generic entry
>> +     * architectures are not having user_irq.
>> +     */
>>       const struct rseq_event evt_mask = { .has_rseq = true, .user_irq 
>> = true, };
>>       struct task_struct *t = current;
>>       struct rseq_ids ids;
>> @@ -286,7 +290,7 @@ static void rseq_slowpath_update_usr(str
>>       }
>>   }
>> -void __rseq_handle_notify_resume(struct pt_regs *regs)
>> +void __rseq_handle_slowpath(struct pt_regs *regs)
>>   {
>>       /*
>>        * If invoked from hypervisors before entering the guest via
>>
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

