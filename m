Return-Path: <linux-kernel+bounces-808510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FB5B500B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256E3177DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B4350835;
	Tue,  9 Sep 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="C6QFi24t"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020088.outbound.protection.outlook.com [52.101.191.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5CE32CF8F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430691; cv=fail; b=TCcroJcYVm2Qtup4k3RF3q27LQu/9ZRRrEoTHfKYewiMLVRe33/Z2o5icZo5sNTf0HLpDVOO4+Ff/r1nJNEn3Kd/Vd5ZWpX0OApMD4J6Eq+mZNqIk4O42jmGIRe549fx9mhpjOtcMiD5mX8zaqG7QNbS2xu1+TXdNr2m6l1WM30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430691; c=relaxed/simple;
	bh=PeR/x+O5JM+Dud0ZgtCzTSNoY2kZOMJqyT0joofqzP0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E4n8naAzehScUlTkl5k6I+mkY0YQbMhTDWc9jOhRU2Hq6App/4fxp/pL7shbZa7Cmxh0aof+tRUykM1cVQMEheeO9qdeu8dEmu7rgpZNybmcbx++//VzvN3kwzztwTnrGuLZakGJ6bBulONA3r7nCJWcD3IxBM3FeXnZG8PWpzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=C6QFi24t; arc=fail smtp.client-ip=52.101.191.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMdmmiImAmncAK2weqic2TFwGTJ2bP3G+XxRRpHNRMIHxWSCvgbU7tnO5gArpDyjErUxsBhJLXad0cJmCr41sIAdbgO/73IKJZNeouO5MERD+tc3fCb1/SgrH0s68PpYoz68lGfkvFrsqYca/invyf3/RLoJ3+h+B5fT2glUel6Yg527j80NiC5fBL86a3FZatHPyzcHSb0e0gSrdbMTGrN8am7eZH/+rZDZd5l80KaTg8J58l6Ifj6RHx7xkjT9nHKPKNoI+UIHEWorJTbAecbeixYS66vh4M48SFZoMqR3nPvxXU7XzWkHkQoM/s1p/lvUTYJa9Owvss3AI8t1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SY+CmoBcwanbJuVwPC8oavbK+bunV/ija96rwKExKo=;
 b=pCPermojzMquMaEnktI0B/UkTQWCWMxROu0LzE3vpeEYYSwMy8VfagbEzZzqgcljzlwiD7DpoibUiKX935StRFqLirmTNIidczgDDi1J/3wxtYtHPNaSuqab4F7Vq/dv1tGz51Kr8DedS0962Dqr2KFYV8sAJIl65YhjG+XYmjMke9pu52xDxW8jc025AUS5AiQF7mKb3se90QNZ44QNDyqde9HY3cWHipz14ZJJukJrZl5Z3I26AqG5jc5cOAoXDUzNLsMU7kssDpG+GDQ8CTgXxhf36ppOMfgn4y6+7GlTwtNXzZ41dQVvVzK57p8u9OYcTCpc/HvkTwGrhK4LMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SY+CmoBcwanbJuVwPC8oavbK+bunV/ija96rwKExKo=;
 b=C6QFi24tTxHzy1232UvQ/sUVCsd6PbY9sYWxU/Y+sUbR4kTMn6ODw0B3FC+XkSdx5Sk4OuPiRlff3p/mLt7zfpC+wG4kzuO9+PKuGubsvLgcyYQ0Pkf0PqkJpGlUsuTsqfxGq+kEG61XxbxT4EFFjqEAhpR3Wbs0BLFSmlvLWjZ4ZJJ0akYeu/gjuEWga37XCQi/gg3dS6ouE3ydy1h0d4SITWdzSHDTPl1iI0E449jmum9/fHptKlCtoPfdwLCy3fIdvAVKZnWPCPqbskfW+yMN9Vol0cxLcpBCBfCahzj3u5NoUZrJKY5gY6Vg+i96hbCHiAaLB9LWUsI0t5fr/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by QB1PPF16753AA98.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::21a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:11:16 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:11:15 +0000
Message-ID: <098b19cf-901d-4de2-9fa1-eff87147fbc7@efficios.com>
Date: Tue, 9 Sep 2025 11:11:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 19/36] rseq: Provide and use rseq_update_user_cs()
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
References: <20250908212737.353775467@linutronix.de>
 <20250908212926.482184911@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908212926.482184911@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|QB1PPF16753AA98:EE_
X-MS-Office365-Filtering-Correlation-Id: d6aed20b-d40a-4e8c-af2c-08ddefb31f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFF6Qk4rYzZKYUZZSTBjMEhEc1JwWjJwbzFXVmhsMzhaUmozeGFKakJpQ1Nz?=
 =?utf-8?B?WjYzN2VHKzF3c3BjNWZYYVRTUzFRclpnSUtkSjJ5ZjdOZDF3QXBpemlyaEI2?=
 =?utf-8?B?MUxuZ2I0MmE4TzJmbkVMVmk0MzZwTmJGbTBOQ1VWU1ZwQjZHRzh5MmYvSEtD?=
 =?utf-8?B?YXF1bW56N0dFZ3dhSVE3eVA1c1ZiNU9wOW5NSGQ0YkxkeTZ1SVdEdHFIMkt6?=
 =?utf-8?B?dDU2cWNhelh1YjJaNWZaaUJuYUtSV1BESkljOHF1RUxjcG0xOHFkNGpVQlMv?=
 =?utf-8?B?RGo4aXBuZ1hWZ3NDdDR2MGo3WlhWVUhYK29ad29hcERJWHBPSWFWR3RmZi8y?=
 =?utf-8?B?WTk1K01sMGYySnN1clkzYjZrbk02enFZTk11aGgrSzMvQ1BmYUMxTDhvZ2VH?=
 =?utf-8?B?ZXpkTDNWMS9vVVplNzZRM0ZXNGFSMWNmZkVCWng4UGVEWlZGVngveTdCTnF4?=
 =?utf-8?B?S0ZjdEluVzl0b1dhcTNHRjFXd0NQWDZBZXR0RmtPKzFiZERiOU9qVlpKU00w?=
 =?utf-8?B?R3c1bUdFRkRuUUxFRW9iZFQ3eTk2dHg5TzBncEZEMHh2OUNXd0EwR1Jza3Vt?=
 =?utf-8?B?M1RQTjFTdS8vTi9rV3lHcTIycVNHUzQ0TVJQMlFXWndVeXY3Z0MxdkJad3dx?=
 =?utf-8?B?ckVKNHRJaUdWajliV21hVyt1TmZpcTArME43M3JVOFFLUjQyTlo3YjhqbENO?=
 =?utf-8?B?TWV1bEhGNExJQXV4QThMWmVCbE5XYWNTaExOZnBFbHZsaWEzY0YwdzljM3lW?=
 =?utf-8?B?ZGhYQ2J0aUI4dVA3RzRzcXY2ZExYYkg3NGNrWFFNTDUrV3FjZnJjcDlWZ3ZQ?=
 =?utf-8?B?cmM0ZTdWaEV3KzF3dHR0SDV2UERHTC9iRVNjR24xUGo3MzlEcG1jU3dWMitK?=
 =?utf-8?B?bHJ6N2s0Ymp0U1BKMWJxN2kxYzQ1ZVR3ZnpUR281ZVA4QUczMEs4Vmk1YXN4?=
 =?utf-8?B?UURlZzdqYkRvL0wzZG90RkxpcTRBWlc1SDRJcXZwNWE4TEtiaHUxRVNHc1Ux?=
 =?utf-8?B?c0FpZlNRVFpITVBYNmZQYW81bmRyMnd3MGpheVpWSzBZZi9FVHlHY0xUbTFs?=
 =?utf-8?B?aGdYQitVQ01VV1FOWnM3QVZhVm1hdC84OUxySFhFS0ZrUW8vVmRKOEJsQ2hz?=
 =?utf-8?B?VnhWaTJPWXJUZmNOSVI5QWpraVlLT0swcWQ3Zm01SDc0U2Vjb2tQNXRiTG96?=
 =?utf-8?B?ejZXN3M1SzNDM2JycW8vOVVaWHJ4UlpMdkpHUm9aVXo4S0ovVXpQQk9YZjht?=
 =?utf-8?B?UTA5L3NHTXk2L2NTSjhHSndpdTdHdWsvZFByOFNEZVNPdzVTRFpiU2I3Sy95?=
 =?utf-8?B?VVBnTXlJMEpjRXV2L0JYZ2o5NkVObkd5cllyWFJES2lHcnJ1L0JiNEtxRHln?=
 =?utf-8?B?Mkk3RHhYY2RFb3pQcHM5Q1pkTkhrUzZkZXRZV1lkL3JiM0dOTGkyZVpYdGNx?=
 =?utf-8?B?Tno4VFBqN3VTaG82dDR3aHFxQVVlRnMwRXBBRU1hMDdjdGpvVjhQNWY5S1d6?=
 =?utf-8?B?NFVXWjF1WjRDNE5QaWovcnRTUGZadlAxUDBMRllTcktZZ0lHL0lKYnNaN2dU?=
 =?utf-8?B?OXJmRFRSNnNTNFlWa0prQkxxV1RuL3RUQ05HK0VTSm90bUZPMnUwSEVwd3R4?=
 =?utf-8?B?alJ0VlZmWmFhMlBWNjRxVms2TEhiQUEvQkZ6MSsrSkpWY1JLdEp6aU1LYnJz?=
 =?utf-8?B?NnlONTRwV3EyOE9hUGt6TGFJeEd5RVErenRIaHdqSzFRWkJGZ3B2ZWFqSVBw?=
 =?utf-8?B?UkNCaHQxeFN4QnBQUDJqRHI4cGZmZlRaamJoNE9RRnBFc0YvU2dqSXNwL1RX?=
 =?utf-8?Q?lkKdoiEy0uacksmkwZficVfv3qpHYb9G31b3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG53MlJkZGUrR3Z5RkQ3MEtoN2xTcHVCbHVUdkN5WUVtWENrNWJ4VkdlZUxp?=
 =?utf-8?B?MERDQjQxYlpZZ29kemh0eUZjYWp2bmJpVWdYMTZMemVtcllRTEpwVFVsUzdq?=
 =?utf-8?B?bDVsdU9Kcm9KN2xWd0FSSXJ4T3NvUHdwc0M5NzZzMGx1U2FSM3ZFa2dCQTZW?=
 =?utf-8?B?WTdDTzBneENhZTFoeVdYM0wwZ2kwY1ZZZ0lhdFdpSWRSVWwxNzVuVldPMmFm?=
 =?utf-8?B?cmUwblN6TitWUEtxZ3ZyMkljVmczR1dwUFhScW1QZEhFMGpGNmQyaVZWZU1w?=
 =?utf-8?B?TkR6ajF6NnRybHM0S0pnM0E0Zk45L3BsL2t6alVMdS9XaWpBL3A3NUlXT004?=
 =?utf-8?B?aTVYdTdQVkswNkFVcW9MVHpXWXBDR2ZkVEd3STJiZFdEN2RzWVUrbnRQL1Vm?=
 =?utf-8?B?Z0N0eGxrcGlpTmozNlJPSEdSN3dmaTVjaHhBOTZqS2JtY2Z3RHRzcEh4NlIz?=
 =?utf-8?B?ckNPTnNXZ2VaWUlXb1VFdHczNE43RVAwWVgwNXg0ckkyMGJBT1d5cFhIM2Y3?=
 =?utf-8?B?aDBHekRncVpnSE5ORHlrcERjVXRSak9GcWlPTStocXEzeEo5U0lJSC9NcjhI?=
 =?utf-8?B?UlpmUDhBOFBDb3FxSXpUZlgyV1FldE5DUnRueDI0V1Q1V3NqSjViS2I3NkdG?=
 =?utf-8?B?SVozYkt5L2p4YTlCaXFtRGhWcjlVeC8zdjMzWXk4N00yMnY3MGVaR3hRcWJ5?=
 =?utf-8?B?L2lqVGJubWFpbUhkaFB6eEN0bWFJTkRVY0JJNmxWSUIwQnkzQ2NjdGtjN055?=
 =?utf-8?B?WDc2WkRjcnFZVndoS2x6Vk5SUHpBQkwrL1dSZXpkUUM1Q1ZaZDlPUmcyQitU?=
 =?utf-8?B?NWZ1OUZEekY5UyttdnlQaC9iUXVNYmZPaWF5b05ic09QRDRyZGxndTA1Skhx?=
 =?utf-8?B?eVFjYm5QL3pUSkEzdUxFYzVtdG5nY296NXlka0NZdHBxVEcxU1FlZUxXalI0?=
 =?utf-8?B?bEp5RWJHK0dlQ0NuaTgxYnJldHZicHdrbmMxZXZRSGNraDJxVW5sc0NwWWpI?=
 =?utf-8?B?cDd5MHFsSnp3S3ptNk1pVzZkR3FoT0x0RlFIQzRvT2ovNDlCR1F2cUZrczBD?=
 =?utf-8?B?REgweVozRmxlbStXZGtyblR3RGpXNlNiWTRFaElraEZyOUxvWDBCeDgrUENs?=
 =?utf-8?B?Y3hDTDVXWmxLelJBMGJTWjROS21EUEIwaFQwUFZkbnp5TWxKN0JDQ0RwSW9y?=
 =?utf-8?B?RmlUUjJodVRZQisweVQ2SkFKbjV0S0xxeDZRU2J5YWVQMnhhSjg3cWFYZ0ZO?=
 =?utf-8?B?UzAxNjhkVmp4Nk1haUYrTDg5L05mVTU0NnArUHVkWCs3bkw5OEZxUTlSL2RZ?=
 =?utf-8?B?TjdVQ0hKdjdKYlNta3FhS0o3d2l5eWFzUGJseUFscU5aZUVWZlRNYSs5YTVV?=
 =?utf-8?B?dUNOYUQ4TWNzb0xTTHZrY3pSQkdjakRTRktWV0RXQnREQ1pIM0Rtd1FrQTc3?=
 =?utf-8?B?cW5aaFhxamFPNjd4ZDRTL2R6Q2tTRThRdUg4eHplMGtaeit2MXVlZ1RrbFdn?=
 =?utf-8?B?MndsVDJXcnJYVWUzbWFvOG1nM3Mwd2hiQ1JFamtPeFllaDRub3BPUmRUZTZN?=
 =?utf-8?B?Z2xEd0VxVTlFeC94Z0ZNSitHWUdoZVFRR0NDd083S3UzN3Y5b2lYOFpnalNt?=
 =?utf-8?B?RWl5Zk11THU3cnQ3Wlk0UXU3bHFTaHpPNCtBcFRWYjk5STdaTExvMEU5emJo?=
 =?utf-8?B?eGZGck9saWd5YTRXVSs4MVBsb3FZSGRlYW9LNmtncnBQakZaSUdYNWZpR0ov?=
 =?utf-8?B?SmNERUVoa0tURjJHS1libFJlZ2Z5NzJsKzRzU1RCWXZuUnhQT0pMOUViWUJa?=
 =?utf-8?B?YTdmWnNLSFJmMmlDei9VczVpMzlKU0x1V2NWSTgzcU1rV1RGL1ZHdUNRY0pS?=
 =?utf-8?B?cTJsUjI0ZXo3VnRqdlFpNndDVm1SVmMxdGY3a3N2VDN2YXR1WEE1aGZpZnlh?=
 =?utf-8?B?WXIwcjRUQmFWWkJyMURDZmhXSWVpenZIZnJMcW1xZjMyb3NDdnc5OWZVSjNo?=
 =?utf-8?B?bmUwSmp3bVBFU1I0REw5c2NzWVZqcjZhbFhRbHhsNEZ0b3dIS3ZuZXZEbERx?=
 =?utf-8?B?ZzRzNm1kWEwwTklhMC9Cb1d0WUJDNUp0RmFYcnQzNnZ1SlBDUVNrTVdOQmZG?=
 =?utf-8?B?ZEQ2SXUxL0dLN3hZWUZkclNPYkhZRTEzYzl3bTMxVzQ1amV6L1MydE1MWGxE?=
 =?utf-8?Q?QtuDdAYf8auRDXsTcqtN1y4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6aed20b-d40a-4e8c-af2c-08ddefb31f1a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:11:15.7993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2uQHJiRt1rg0n3WjgiikYX5fibHc6cD1Li7x3ouVPcEKbqM166CBp1Aob+YllAWMxHweeq2xyelVcuZIx1YoBikWqmeNHDabO/SiFI1Pes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF16753AA98

On 2025-09-08 17:32, Thomas Gleixner wrote:
> Provide a straight forward implementation to check for and eventually
> clear/fixup critical sections in user space.
> 
> The non-debug version does only the minimal sanity checks and aims for
> efficiency.
> 
> There are two attack vectors, which are checked for:
> 
>    1) An abort IP which is in the kernel address space. That would cause at
>       least x86 to return to kernel space via IRET.
> 
>    2) A rogue critical section descriptor with an abort IP pointing to some
>       arbitrary address, which is not preceeded by the RSEQ signature.

preceeded -> preceded

> 
> If the section descriptors are invalid then the resulting misbehaviour of
> the user space application is not the kernels problem.
> 
> The kernel provides a run-time switchable debug slow path, which implements
> the full zoo of checks including termination of the task when one of the
> gazillion conditions is not met.
> 
> Replace the zoo in rseq.c with it and invoke it from the TIF_NOTIFY_RESUME
> handler. Move the reminders into the CONFIG_DEBUG_RSEQ section, which will

reminders -> remainders

> be replaced and removed in a subsequent step.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V3: Brought back the signature check along with a comment - Mathieu
> ---
>   include/linux/rseq_entry.h |  209 +++++++++++++++++++++++++++++++++++++++
>   include/linux/rseq_types.h |   11 +-
>   kernel/rseq.c              |  238 +++++++++++++--------------------------------
>   3 files changed, 288 insertions(+), 170 deletions(-)
> 
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -36,6 +36,7 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_
>   #ifdef CONFIG_RSEQ
>   #include <linux/jump_label.h>
>   #include <linux/rseq.h>
> +#include <linux/uaccess.h>
>   
>   #include <linux/tracepoint-defs.h>
>   
> @@ -67,12 +68,220 @@ static inline void rseq_trace_ip_fixup(u
>   
>   DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
>   
> +#ifdef RSEQ_BUILD_SLOW_PATH
> +#define rseq_inline
> +#else
> +#define rseq_inline __always_inline
> +#endif
> +
> +bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
> +
>   static __always_inline void rseq_note_user_irq_entry(void)
>   {
>   	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
>   		current->rseq.event.user_irq = true;
>   }
>   
> +/*
> + * Check whether there is a valid critical section and whether the
> + * instruction pointer in @regs is inside the critical section.
> + *
> + *  - If the critical section is invalid, terminate the task.
> + *
> + *  - If valid and the instruction pointer is inside, set it to the abort IP
> + *
> + *  - If valid and the instruction pointer is outside, clear the critical
> + *    section address.
> + *
> + * Returns true, if the section was valid and either fixup or clear was
> + * done, false otherwise.
> + *
> + * In the failure case task::rseq_event::fatal is set when a invalid
> + * section was found. It's clear when the failure was an unresolved page
> + * fault.
> + *
> + * If inlined into the exit to user path with interrupts disabled, the
> + * caller has to protect against page faults with pagefault_disable().
> + *
> + * In preemptible task context this would be counterproductive as the page
> + * faults could not be fully resolved. As a consequence unresolved page
> + * faults in task context are fatal too.
> + */
> +
> +#ifdef RSEQ_BUILD_SLOW_PATH
> +/*
> + * The debug version is put out of line, but kept here so the code stays
> + * together.
> + *
> + * @csaddr has already been checked by the caller to be in user space
> + */
> +bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr)
> +{
> +	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
> +	u64 start_ip, abort_ip, offset, cs_end, head, tasksize = TASK_SIZE;
> +	unsigned long ip = instruction_pointer(regs);
> +	u64 __user *uc_head = (u64 __user *) ucs;
> +	u32 usig, __user *uc_sig;
> +
> +	if (!user_rw_masked_begin(ucs))
> +		return false;
> +
> +	/*
> +	 * Evaluate the user pile and exit if one of the conditions is not
> +	 * fulfilled.
> +	 */
> +	unsafe_get_user(start_ip, &ucs->start_ip, fail);
> +	if (unlikely(start_ip >= tasksize))
> +		goto die;
> +	/* If outside, just clear the critical section. */
> +	if (ip < start_ip)
> +		goto clear;
> +
> +	unsafe_get_user(offset, &ucs->post_commit_offset, fail);
> +	cs_end = start_ip + offset;
> +	/* Check for overflow and wraparound */
> +	if (unlikely(cs_end >= tasksize || cs_end < start_ip))
> +		goto die;
> +
> +	/* If not inside, clear it. */
> +	if (ip >= cs_end)
> +		goto clear;
> +
> +	unsafe_get_user(abort_ip, &ucs->abort_ip, fail);
> +	/* Ensure it's "valid" */
> +	if (unlikely(abort_ip >= tasksize || abort_ip < sizeof(*uc_sig)))
> +		goto die;
> +	/* Validate that the abort IP is not in the critical section */
> +	if (unlikely(abort_ip - start_ip < offset))
> +		goto die;
> +
> +	/*
> +	 * Check version and flags for 0. No point in emitting deprecated
> +	 * warnings before dying. That could be done in the slow path
> +	 * eventually, but *shrug*.
> +	 */
> +	unsafe_get_user(head, uc_head, fail);
> +	if (unlikely(head))
> +		goto die;
> +
> +	/* abort_ip - 4 is >= 0. See abort_ip check above */
> +	uc_sig = (u32 __user *)(unsigned long)(abort_ip - sizeof(*uc_sig));
> +	unsafe_get_user(usig, uc_sig, fail);
> +	if (unlikely(usig != t->rseq.sig))
> +		goto die;
> +
> +	/* rseq_event.user_irq is only valid if CONFIG_GENERIC_IRQ_ENTRY=y */
> +	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
> +		/* If not in interrupt from user context, let it die */
> +		if (unlikely(!t->rseq.event.user_irq))
> +			goto die;
> +	}
> +
> +	unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, fail);
> +	user_access_end();
> +
> +	instruction_pointer_set(regs, (unsigned long)abort_ip);
> +
> +	rseq_stat_inc(rseq_stats.fixup);
> +	rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
> +	return true;
> +clear:
> +	unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, fail);
> +	user_access_end();
> +	rseq_stat_inc(rseq_stats.clear);
> +	return true;
> +die:
> +	t->rseq.event.fatal = true;
> +fail:
> +	user_access_end();
> +	return false;
> +}
> +#endif /* RSEQ_BUILD_SLOW_PATH */
> +
> +/*
> + * This only ensures that abort_ip is in the user address space by masking it.
> + * No other sanity checks are done here, that's what the debug code is for.

This comment should be updated to state that the signature is also
checked.

> + */
> +static rseq_inline bool
> +rseq_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr)
> +{
> +	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
> +	unsigned long ip = instruction_pointer(regs);
> +	u64 start_ip, abort_ip, offset;
> +	u32 usig, __user *uc_sig;
> +
> +	rseq_stat_inc(rseq_stats.cs);
> +
> +	if (unlikely(csaddr >= TASK_SIZE)) {
> +		t->rseq.event.fatal = true;
> +		return false;
> +	}
> +
> +	if (static_branch_unlikely(&rseq_debug_enabled))
> +		return rseq_debug_update_user_cs(t, regs, csaddr);
> +
> +	if (!user_rw_masked_begin(ucs))
> +		return false;
> +
> +	unsafe_get_user(start_ip, &ucs->start_ip, fail);
> +	unsafe_get_user(offset, &ucs->post_commit_offset, fail);
> +	unsafe_get_user(abort_ip, &ucs->abort_ip, fail);
> +
> +	/*
> +	 * No sanity checks. If user space screwed it up, it can
> +	 * keep the pieces. That's what debug code is for.
> +	 *
> +	 * If outside, just clear the critical section.
> +	 */
> +	if (ip - start_ip >= offset)
> +		goto clear;
> +
> +	/*
> +	 * Two requirements for @abort_ip:
> +	 *   - Must be in user space as x86 IRET would happily return to
> +	 *     the kernel.
> +	 *   - The four bytes preceeding the instruction at @abort_ip must

preceeding -> preceding

> +	 *     contain the signature.
> +	 *
> +	 * The latter protects against the following attack vector:
> +	 *
> +	 * An attacker with limited abilities to write, creates a critical
> +	 * section descriptor, sets the abort IP to a library function or
> +	 * some other ROP gadget and stores the address of the descriptor
> +	 * in TLS::rseq::rseq_cs. An RSEQ abort would then evade ROP
> +	 * protection.

Thanks for documenting this.

Mathieu

> +	 */
> +	if (abort_ip >= TASK_SIZE || abort_ip < sizeof(*uc_sig))
> +		goto die;
> +
> +	/* The address is guaranteed to be >= 0 and < TASK_SIZE */
> +	uc_sig = (u32 __user *)(unsigned long)(abort_ip - sizeof(*uc_sig));
> +	unsafe_get_user(usig, uc_sig, fail);
> +	if (unlikely(usig != t->rseq.sig))
> +		goto die;
> +
> +	/* Invalidate the critical section */
> +	unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, fail);
> +	user_access_end();
> +
> +	/* Update the instruction pointer */
> +	instruction_pointer_set(regs, (unsigned long)abort_ip);
> +
> +	rseq_stat_inc(rseq_stats.fixup);
> +	rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
> +	return true;
> +clear:
> +	unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, fail);
> +	user_access_end();
> +	rseq_stat_inc(rseq_stats.clear);
> +	return true;
> +die:
> +	t->rseq.event.fatal = true;
> +fail:
> +	user_access_end();
> +	return false;
> +}
> +
>   static __always_inline void rseq_exit_to_user_mode(void)
>   {
>   	struct rseq_event *ev = &current->rseq.event;
> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -14,10 +14,12 @@ struct rseq;
>    * @sched_switch:	True if the task was scheduled out
>    * @user_irq:		True on interrupt entry from user mode
>    * @has_rseq:		True if the task has a rseq pointer installed
> + * @error:		Compound error code for the slow path to analyze
> + * @fatal:		User space data corrupted or invalid
>    */
>   struct rseq_event {
>   	union {
> -		u32				all;
> +		u64				all;
>   		struct {
>   			union {
>   				u16		events;
> @@ -28,6 +30,13 @@ struct rseq_event {
>   			};
>   
>   			u8			has_rseq;
> +			u8			__pad;
> +			union {
> +				u16		error;
> +				struct {
> +					u8	fatal;
> +				};
> +			};
>   		};
>   	};
>   };
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -382,175 +382,15 @@ static int rseq_reset_rseq_cpu_node_id(s
>   	return -EFAULT;
>   }
>   
> -/*
> - * Get the user-space pointer value stored in the 'rseq_cs' field.
> - */
> -static int rseq_get_rseq_cs_ptr_val(struct rseq __user *rseq, u64 *rseq_cs)
> -{
> -	if (!rseq_cs)
> -		return -EFAULT;
> -
> -#ifdef CONFIG_64BIT
> -	if (get_user(*rseq_cs, &rseq->rseq_cs))
> -		return -EFAULT;
> -#else
> -	if (copy_from_user(rseq_cs, &rseq->rseq_cs, sizeof(*rseq_cs)))
> -		return -EFAULT;
> -#endif
> -
> -	return 0;
> -}
> -
> -/*
> - * If the rseq_cs field of 'struct rseq' contains a valid pointer to
> - * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
> - */
> -static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
> -{
> -	struct rseq_cs __user *urseq_cs;
> -	u64 ptr;
> -	u32 __user *usig;
> -	u32 sig;
> -	int ret;
> -
> -	ret = rseq_get_rseq_cs_ptr_val(t->rseq.usrptr, &ptr);
> -	if (ret)
> -		return ret;
> -
> -	/* If the rseq_cs pointer is NULL, return a cleared struct rseq_cs. */
> -	if (!ptr) {
> -		memset(rseq_cs, 0, sizeof(*rseq_cs));
> -		return 0;
> -	}
> -	/* Check that the pointer value fits in the user-space process space. */
> -	if (ptr >= TASK_SIZE)
> -		return -EINVAL;
> -	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
> -	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
> -		return -EFAULT;
> -
> -	if (rseq_cs->start_ip >= TASK_SIZE ||
> -	    rseq_cs->start_ip + rseq_cs->post_commit_offset >= TASK_SIZE ||
> -	    rseq_cs->abort_ip >= TASK_SIZE ||
> -	    rseq_cs->version > 0)
> -		return -EINVAL;
> -	/* Check for overflow. */
> -	if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
> -		return -EINVAL;
> -	/* Ensure that abort_ip is not in the critical section. */
> -	if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
> -		return -EINVAL;
> -
> -	usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
> -	ret = get_user(sig, usig);
> -	if (ret)
> -		return ret;
> -
> -	if (current->rseq.sig != sig) {
> -		printk_ratelimited(KERN_WARNING
> -			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
> -			sig, current->rseq.sig, current->pid, usig);
> -		return -EINVAL;
> -	}
> -	return 0;
> -}
> -
> -static bool rseq_warn_flags(const char *str, u32 flags)
> +static bool rseq_handle_cs(struct task_struct *t, struct pt_regs *regs)
>   {
> -	u32 test_flags;
> +	u64 csaddr;
>   
> -	if (!flags)
> +	if (get_user_masked_u64(&csaddr, &t->rseq.usrptr->rseq_cs))
>   		return false;
> -	test_flags = flags & RSEQ_CS_NO_RESTART_FLAGS;
> -	if (test_flags)
> -		pr_warn_once("Deprecated flags (%u) in %s ABI structure", test_flags, str);
> -	test_flags = flags & ~RSEQ_CS_NO_RESTART_FLAGS;
> -	if (test_flags)
> -		pr_warn_once("Unknown flags (%u) in %s ABI structure", test_flags, str);
> -	return true;
> -}
> -
> -static int rseq_check_flags(struct task_struct *t, u32 cs_flags)
> -{
> -	u32 flags;
> -	int ret;
> -
> -	if (rseq_warn_flags("rseq_cs", cs_flags))
> -		return -EINVAL;
> -
> -	/* Get thread flags. */
> -	ret = get_user(flags, &t->rseq.usrptr->flags);
> -	if (ret)
> -		return ret;
> -
> -	if (rseq_warn_flags("rseq", flags))
> -		return -EINVAL;
> -	return 0;
> -}
> -
> -static int clear_rseq_cs(struct rseq __user *rseq)
> -{
> -	/*
> -	 * The rseq_cs field is set to NULL on preemption or signal
> -	 * delivery on top of rseq assembly block, as well as on top
> -	 * of code outside of the rseq assembly block. This performs
> -	 * a lazy clear of the rseq_cs field.
> -	 *
> -	 * Set rseq_cs to NULL.
> -	 */
> -#ifdef CONFIG_64BIT
> -	return put_user(0UL, &rseq->rseq_cs);
> -#else
> -	if (clear_user(&rseq->rseq_cs, sizeof(rseq->rseq_cs)))
> -		return -EFAULT;
> -	return 0;
> -#endif
> -}
> -
> -/*
> - * Unsigned comparison will be true when ip >= start_ip, and when
> - * ip < start_ip + post_commit_offset.
> - */
> -static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
> -{
> -	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
> -}
> -
> -static int rseq_ip_fixup(struct pt_regs *regs, bool abort)
> -{
> -	unsigned long ip = instruction_pointer(regs);
> -	struct task_struct *t = current;
> -	struct rseq_cs rseq_cs;
> -	int ret;
> -
> -	rseq_stat_inc(rseq_stats.cs);
> -
> -	ret = rseq_get_rseq_cs(t, &rseq_cs);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Handle potentially not being within a critical section.
> -	 * If not nested over a rseq critical section, restart is useless.
> -	 * Clear the rseq_cs pointer and return.
> -	 */
> -	if (!in_rseq_cs(ip, &rseq_cs)) {
> -		rseq_stat_inc(rseq_stats.clear);
> -		return clear_rseq_cs(t->rseq.usrptr);
> -	}
> -	ret = rseq_check_flags(t, rseq_cs.flags);
> -	if (ret < 0)
> -		return ret;
> -	if (!abort)
> -		return 0;
> -	ret = clear_rseq_cs(t->rseq.usrptr);
> -	if (ret)
> -		return ret;
> -	rseq_stat_inc(rseq_stats.fixup);
> -	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
> -			    rseq_cs.abort_ip);
> -	instruction_pointer_set(regs, (unsigned long)rseq_cs.abort_ip);
> -	return 0;
> +	if (likely(!csaddr))
> +		return true;
> +	return rseq_update_user_cs(t, regs, csaddr);
>   }
>   
>   /*
> @@ -567,8 +407,8 @@ static int rseq_ip_fixup(struct pt_regs
>   void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>   {
>   	struct task_struct *t = current;
> -	int ret, sig;
>   	bool event;
> +	int sig;
>   
>   	/*
>   	 * If invoked from hypervisors before entering the guest via
> @@ -618,8 +458,7 @@ void __rseq_handle_notify_resume(struct
>   	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
>   		return;
>   
> -	ret = rseq_ip_fixup(regs, event);
> -	if (unlikely(ret < 0))
> +	if (!rseq_handle_cs(t, regs))
>   		goto error;
>   
>   	if (unlikely(rseq_update_cpu_node_id(t)))
> @@ -632,6 +471,67 @@ void __rseq_handle_notify_resume(struct
>   }
>   
>   #ifdef CONFIG_DEBUG_RSEQ
> +/*
> + * Unsigned comparison will be true when ip >= start_ip, and when
> + * ip < start_ip + post_commit_offset.
> + */
> +static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
> +{
> +	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
> +}
> +
> +/*
> + * If the rseq_cs field of 'struct rseq' contains a valid pointer to
> + * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
> + */
> +static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
> +{
> +	struct rseq_cs __user *urseq_cs;
> +	u64 ptr;
> +	u32 __user *usig;
> +	u32 sig;
> +	int ret;
> +
> +	if (get_user_masked_u64(&ptr, &t->rseq.usrptr->rseq_cs))
> +		return -EFAULT;
> +
> +	/* If the rseq_cs pointer is NULL, return a cleared struct rseq_cs. */
> +	if (!ptr) {
> +		memset(rseq_cs, 0, sizeof(*rseq_cs));
> +		return 0;
> +	}
> +	/* Check that the pointer value fits in the user-space process space. */
> +	if (ptr >= TASK_SIZE)
> +		return -EINVAL;
> +	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
> +	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
> +		return -EFAULT;
> +
> +	if (rseq_cs->start_ip >= TASK_SIZE ||
> +	    rseq_cs->start_ip + rseq_cs->post_commit_offset >= TASK_SIZE ||
> +	    rseq_cs->abort_ip >= TASK_SIZE ||
> +	    rseq_cs->version > 0)
> +		return -EINVAL;
> +	/* Check for overflow. */
> +	if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
> +		return -EINVAL;
> +	/* Ensure that abort_ip is not in the critical section. */
> +	if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
> +		return -EINVAL;
> +
> +	usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
> +	ret = get_user(sig, usig);
> +	if (ret)
> +		return ret;
> +
> +	if (current->rseq.sig != sig) {
> +		printk_ratelimited(KERN_WARNING
> +			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
> +			sig, current->rseq.sig, current->pid, usig);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
>   
>   /*
>    * Terminate the process if a syscall is issued within a restartable
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

