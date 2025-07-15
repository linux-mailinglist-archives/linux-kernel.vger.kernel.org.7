Return-Path: <linux-kernel+bounces-731466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D7DB054C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDD007B66B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31328274B30;
	Tue, 15 Jul 2025 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="e5ApRqL9"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5DF26C396
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567823; cv=fail; b=pVntcpGj7CALbtrJ6vSUF7eWge3STlOjh/VhzDduGQm8hepEBwUZs1aahY0dzRnaY4lBkx9nKxIVbDvHn+iIT3wZdA+tQyJC/v/6I6Hp6TInaHvEAl0dcysq11m+qMpo4PPot6LhIPX4BppQZEGuUABL6+71B6+q8o0VoXWDgvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567823; c=relaxed/simple;
	bh=G+5qJnQg3qIQMpmLt5D7UszDsORg0IpgC5D+eSFc+vE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nakYeVCBVmAqdvoVAQJ49LmnMHHVAiifcF2XplHA2op34ytl6eq8VFUoefPe+jnj0RJ3Qs808GunoA3IeYxzjd/p4gI2oUcnGrBxeTlZm2DYUDJiAVs0hxRdUTC3A+QgllA8t1sYxHSijeBvbnYo2eHPMtmDXxV25GOE7pkk9Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=e5ApRqL9; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h41Pxf87RxDv0tVnVl2/GjNs8OPzBJbK4iHWvRbpV19lqj5H25cYQY7jm6vYphAEZf5b9/uauMhMSJor+LzMc2pO0KiLWe8sI3hT00J8ZrbFVtBj02LvbulXRBut25LltekRWNtFhaMOiCV+iPj89rvsJUGCWsweiGwdqtPauLRqulKZKaOoj8AnUeprxUGV7/7gIluuhkgFJFLTzUgiTy9QlhQz6ZR6b145k5DzLlW3KNhqIPYGQvWG2mdXy560A5Giaj5lBZcspYXmMGQs+gL3spWungF7zuD/PDG5i7N+uhBb14HAUYGXHKekwysMaM5Sxt5uWJX2sUSGqo0wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWnrgyWSJmRNq5z8NINA0qrGz1sPwE1UIZCacuU85ac=;
 b=ok/xoK8TzEkqzNAALADLN1dRjfMd7jqOBquc3ZnSn+uahfUguHmfkkFaCb78I66np6oQsw/7JqNXW/pnoMf+eFUCcdruGecb3eUEUH8TSvByRhh14gE1NnFWeBnxGqdqFsiW6V1+3QITDou81uCMKdJNd3swIsLANySnZc6oQrPj7fZFjF6RlroiosUi5LXdagzey9ppKcmaoBqPvpnUk6FftoVYt8/aWAgxyiC85Y58Y2Pol8uk3gGi4wmTGxB+wd8njzwFfMfoPyeDh3RlmCk1c5QohZ/vRllefn++kC1WWg94BcdO112vso5DTF1Picjutnl0YpsscA4zsLMHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWnrgyWSJmRNq5z8NINA0qrGz1sPwE1UIZCacuU85ac=;
 b=e5ApRqL9dQCp/P3uxWtAID2Hzfpqm+KpvmDyI1sgTNrkG31ewBwQfvMaE2233Sh/zRLzI0dTD1VJrN+oc7WaF1mYOxZkUIqqDqkdCMj0G0LhcDSEQX4jkHuit3MbW5+9q7up4MHi/jy7sMvC6WLs/webjaklDRMNixbPCzU+DPXlvKh2Ndqmwqlz4QCANv0PWGo8f6D2YsXfegrmeVdViS5SNDGmytBA3978jDHBNCs9oanZ493hxE4IPLjEbUHQ28pKrmGp6P0iieC9q01QCilyjLWnufcN0TuUXuYFWV1L9nG5pCv6gted0Uotg5Qob7PCfTaP6pXXWYK9ejhwUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com (2603:10a6:102:246::20)
 by AM8PR07MB7572.eurprd07.prod.outlook.com (2603:10a6:20b:243::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 08:23:38 +0000
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60]) by PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60%4]) with mapi id 15.20.8901.024; Tue, 15 Jul 2025
 08:23:38 +0000
Message-ID: <43913cf2-3f3d-48ae-baf9-3ed2a80af539@nokia.com>
Date: Tue, 15 Jul 2025 10:23:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irq: add support for warning on long-running IRQ handlers
To: Thomas Gleixner <tglx@linutronix.de>, anna-maria@linutronix.de,
 frederic@kernel.org, mingo@kernel.org
Cc: akpm@linux-foundation.org, bigeasy@linutronix.de, peterz@infradead.org,
 linux-kernel@vger.kernel.org
References: <20250630124721.18232-1-wladislav.wiebe@nokia.com>
 <875xgdnsmr.ffs@tglx> <9dcfe1fb-0361-4d13-a4d5-fbc274f68db7@nokia.com>
 <87frfgmkf2.ffs@tglx>
From: Wladislav Wiebe <wladislav.wiebe@nokia.com>
In-Reply-To: <87frfgmkf2.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::8) To PAXPR07MB8771.eurprd07.prod.outlook.com
 (2603:10a6:102:246::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR07MB8771:EE_|AM8PR07MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: ec568f4f-48d5-4446-7c17-08ddc378e5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0tqRVhWYmZUZzJrQnNCZzRueENKTzh0cnNxbDJwZWZuSmdGSFp0Mm51L0xo?=
 =?utf-8?B?b2xRaEF3UmoyZkN4L3lmczYzWkY3c1NyRVM4bWRWYzBFa2JrcDdLOGhva3Yr?=
 =?utf-8?B?aWRVUUYwUHlZcGdhNU9PN0tBWHJlUlRYckFLcVBiRVlMZGpoRzBkWWNRaEdl?=
 =?utf-8?B?VFB5YklmdTAxbG42a2pVdGpQMlE2U0N4THlZeE9pVGZTUnhBUzNiVlVueVhs?=
 =?utf-8?B?TTEweW9mVDZFTitXSmdtVnVUMUZQbDlnVkYvdjdCQkE5bHR0b1R6NGxET2NL?=
 =?utf-8?B?dUhzODU1VHVHVmZGUzVkVDJXbTRJblNvL3ZqQVF6cnJsaUdoNkF0cXJrdXps?=
 =?utf-8?B?TjR2VUJwNFp3Y2RiSjkwSVd0Wm53TzAyUWJNNUkrVTVBTkxQNXRWYThOdURS?=
 =?utf-8?B?OUhzbzNRZGZQQ0N4VEVYRGo1cUdiWk45Y0tyTWcwTTZmRHFnTS8vdkNyK1NE?=
 =?utf-8?B?SmpBclNUOStMOFVVZS9xTVFQU0VRcXEwZ1NXU2RUS1hya0RnL29FTEFQQkVZ?=
 =?utf-8?B?YThHYkZneHl0Q0xyc2d4K211L3hhWng3VGxQdGcrdjNuV2R2dVFxRWVJMkth?=
 =?utf-8?B?bkszTVVoeXk3SGRWQm9xR1U4Tk9oT01XQzU0ZlJqTFBlV3JIamtuMWQ0Y09K?=
 =?utf-8?B?Y2M0VWtmSlc3d0RKc0xmT0xQQXFUM0VTc1NDM01DTjIwL3R5elRFZE9pck5t?=
 =?utf-8?B?c3ZCWDMxWkhMaHM5ZktMNWYvaXN6S0d4ajlWY3BsNmU3bjgybzhrZkhIbHF4?=
 =?utf-8?B?dHE2L3YrRU00TWNYSzhvRGR0Y0M1VVVoanpGOFA4WVRVb1d1T2NXWHdLbXY1?=
 =?utf-8?B?VmJINmNoMnEvQi96RElHMGxlR0FWRHpSZFlvR0NuRHROMmtobkhHWFZPVnVH?=
 =?utf-8?B?RWJIY3pYNEdiS0Y4SUJyWHpXSEVVQlh6TXNCZ0l3N01JVXhmU1YzejRReFlr?=
 =?utf-8?B?TU1tVzMwYzUxZ3BMa3dUTDYzQ3hocnllQjRnNWcwTk1jclBjYzNpZkJFZEhQ?=
 =?utf-8?B?bHFhUHRackRkRklDTFlwdmR1UVIwSSsvQlNCU3ZFQWhCUWhDM25KR2lSeFlh?=
 =?utf-8?B?RTBUaTRkVkNOVnNUendraThqUDMzcFFYbzVmaVFrQzFtdDVNMGo4aDlhR1oy?=
 =?utf-8?B?S1hVc3N1S3QvZGI3aWpMbHpBME5zQ0xaWlNzQzc0cWhkV0VlNDh5MDR2Sm51?=
 =?utf-8?B?cE1RWllHZ3lmdUxpUzhhMzVuaGRXbnZtYXlId0tGRlpkd2l0TkdZNjl6MzFL?=
 =?utf-8?B?dVVZbXNIT1hGSzVra0RwSWxxZldvblFmWVJmT2htZlhYVHBXcDhOV2lHSDBo?=
 =?utf-8?B?SnpSclN6UzhJelZnR3lBRGowMER0Rk1hdFFPVDZhNTJneEtaT2Y3eWF0Y3pE?=
 =?utf-8?B?NFkreXVSR0tCVmJBaTI1OHJxT1JJY1Y0RUcwOXVxZ2RqY05RbW1KeGNaQUdZ?=
 =?utf-8?B?QjZHQUg0T2lMTEJDUk9PdjJpVEhtQ2lWNmNyOWE5b1h1MzJHUThSZTVRcjRH?=
 =?utf-8?B?cGtsTzV0amR4bktlSWFBdDhTQ3hMWFRtclQwcHQ5MGlxRkEvcit4bkJ3b2Ro?=
 =?utf-8?B?MjEvdEpOdlRabEIzaHo1L1Rpam5USmhjVjBZZXhLdnQybHNHd2tSV3BQSVhx?=
 =?utf-8?B?MEhjenNJN0VyTXRRTkRuZkFCbmlEVlplSlR1Y0JKam12eVhVY2pnR3NBQmNU?=
 =?utf-8?B?NkU5SjdUbmptaGluajdhOGV6amFYeEE2YlA0VWNkeDVoSDZDSWp5dFpQQzJ4?=
 =?utf-8?B?UlZ1elZFdzBDZ0pPODdQaUVuSGxLR2hoTTc1Y1NreFRJTGYxZVZpSkhCb25j?=
 =?utf-8?B?NWQ0N0g0aGljYVFLWXhRQy90MlV1ZVZ2T0ViNWZDUUN3d1lOdHNzYTI2N2l6?=
 =?utf-8?B?TzVwSU9pbUx0Z3JvSVdBS250MWY2T0RqdFlCWVpPOGNBSXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB8771.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnRnL0JUWTFaL0V3Wmp5MGYyU2lCWHhyMW9RdUNHUWo3bVhSRUFDYUtiVjZR?=
 =?utf-8?B?SHZ4aTUzZWROWHFOSHNlVGt1aVFlbElUOUt1NDA0RWFJeUd2Q3g5OXFoSmVT?=
 =?utf-8?B?K2lrL045RmVDN3IzbVhkdnVteXNJbUZidm5ZYytQYWlnMXZsakdnczA2NnVj?=
 =?utf-8?B?bGtUaDR3U2lRb2t2OXEzWjBwUHo1RWVqZ2dsV1U3UG5zMnNJc1ZQdHQwRE1V?=
 =?utf-8?B?aElJN0NFQVpZclFJOTVSMXZ0TUZwK1FieitRa2ZjcDBJTXN5Q2xBZ0FlaTVI?=
 =?utf-8?B?amtQS1dEQU4wMmszR1A4WE01Wm1wMS82SEVlY2IwS3cvVWdZbmxGb1ZXK2Fs?=
 =?utf-8?B?Qzh0Vnc1QTUxWHNSbkhwbWJMdFN4NUwwcm1LRVFTWTNiTnYyNzNpU3VsL1Mz?=
 =?utf-8?B?ZUpudmZqdTJraE5OWkxaSmR5VUluWVJJWUdLM3MveVA3ZDUrUit3aDF0UHh5?=
 =?utf-8?B?RnM2L3RWeGRYNDh0WSs4ZVJON1BuMWxoVm14TCtLZ00wSGdGcll0bzhsTkJz?=
 =?utf-8?B?aEtvSTI0eVkyakRkOHV2dG52aGVZa0F0anJTY2pmN3NnNTdjdG5YcUR0NVh0?=
 =?utf-8?B?U0FQYWNGTlh2OTlFb0lyd1hITVpZeWdrUnVaWFlsOS9SUXk3RGRKRVlQNlNL?=
 =?utf-8?B?NXZiQTlSZmppOWZrNmVhS3Uxb0pTZTdlKzVHQnBMWTg4cGFMRHBmWkVBcmpr?=
 =?utf-8?B?NnhicjNNenhzWE1EajV4eHdKN0k2UVpUTzZRemdLbDJYaTBhdVhkcE55MlNC?=
 =?utf-8?B?UGFZTWUzSG9aRzA1bWNCQWw0Q0lybElPeHFWN2s5aUZ5Qi9UNFBhVWtuNGVE?=
 =?utf-8?B?NU5CVnR0YkVLUW1FTGcwdTVSK1BoMW1kWU53QmgzU01PQjIyb2NOSUFDWG9z?=
 =?utf-8?B?YWpQY2dNdjlsOG1ScHlqbHlJMXZqSDdRMVcyc2hzL0NqWFFPbGhVTVhQV0E5?=
 =?utf-8?B?K2YycGJmdVl1ZjNaUmhLM1lpMkpwemNoR2RKRXF2UXptSkpHZzMzUUJWck9l?=
 =?utf-8?B?OTVXMHc3Qm81Uk1mSGhsS2M3NklLczJsTlUzTWFOMis5K0pFRTFwT0pqNFY3?=
 =?utf-8?B?NGhSK2xhblpCYUJwWmZFNnVNUHhabEN0SER0ejcvdzIwRU5rNitpSlFDQm0x?=
 =?utf-8?B?U0NTb3l6ajVwanpRd3lJWkxrOWlOTC9iZHlXd3gzOFl5OGdIVGZiaFozYmlp?=
 =?utf-8?B?bGJvYzd5c3crNGhNblVoVGZVeGZBdXBBdytiSE1qN3pTcENBRzhSTUlyenJJ?=
 =?utf-8?B?bmpWbHUxSytWME5UTFNhNGF3MDlYTUI2ZzNQN05BcHkzdUFaVzVEdEJuQkxP?=
 =?utf-8?B?am9ObUFWUEhqNGIzdVcvWGk4NUVIZkJmWlIzQTk5WXFQaXVmWjhxNHZjc3lx?=
 =?utf-8?B?T2pQZ0dGU3Q1MUwvVFRKemFKS21iekNSRVRHWVhuT0FkN0RHUWFVd1V1OTlK?=
 =?utf-8?B?OTFYUEh0WTF3YkVuUnRyd1pKKytXRlRHYTMzSWtDRXUyQzJENmxyN21ZbHZu?=
 =?utf-8?B?cG1UN2dRVFltOXllY1pTandoMHlGVUdjYVVBTVN4VWpTeWgxVFV1STRrK0ov?=
 =?utf-8?B?bnpIK1BTdWh3QnBlY1Z4WHlyUjFSSCtFOWhhckZQWFlyZ3BNUjNQK1E0SXZY?=
 =?utf-8?B?N3BULzdoajQ1dnBmTzF0b3FnRnRVMDRKN1pISXJFNUNKQ1QwNVNLM1FkcC9h?=
 =?utf-8?B?V1BnY0tyUm1sWDBsS21UbXcxb1o5R2hGMzFKTzVObXErTzhpMkZTK0tMSkpE?=
 =?utf-8?B?WUVZUTZKcWthYVdLTVdCSWVwd3RIREVRNGtsaUhlVkJZWmRuRlFna0VxTGdM?=
 =?utf-8?B?T2duZ2Z0ZzVaUTlmN3JOTzltSjUwUGNhMU8wUEtxbUxseEFlNW42WVNoSmRS?=
 =?utf-8?B?QWFFWldjclk1bTBqV0xyU0c3SUpwTUU4MGNCa04vREczK2twU3RnVUovb1Bz?=
 =?utf-8?B?bEJFWVFCaTJ1dGw2Wk4rWHZoNHV2LzFRdXNha3pzY2tFVW1TUGhKYklUTGc0?=
 =?utf-8?B?cy9FT0c5R0J1UWFwVmtSb2dXR2N6V0RGNWdYMXlpcVR6Qlc3Sm5yKzIyNUJh?=
 =?utf-8?B?djI5djltd25lcGM3WnRYV1F0L28vbk9GS2RpeFpoMlk4RDZiNFl1VitCb3Ru?=
 =?utf-8?B?ZXBLVVRtc3d0a2wxRnZvU29uQ3Q2RzU2RnhOUVp6WFVIb1ZVeVhWTXQ4MFlk?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec568f4f-48d5-4446-7c17-08ddc378e5e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB8771.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:23:37.9169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axn128udvgcP8yWPicgEqgtpRZAdXNMfvlVZ2nsx+rJq0r7ibs4U7NrvXz77u/YGjLZPyjHoyl/67CGMuz0zsvNFykqURpUR95NKBE9FnQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7572


On 01/07/2025 09:37, Thomas Gleixner wrote:
>
> On Tue, Jul 01 2025 at 08:10, Wladislav Wiebe wrote:
>> On 30/06/2025 17:42, Thomas Gleixner wrote:
>>> Define sufficient. That really depends on your use case. For a real-time
>>> system a hard interrupt handler running longer than a few microseconds
>>> can be problematic.
>>>
>>> So instead of adding some single purpose mechanism, can we please add
>>> something flexible which can be used for a wide range of scenarios.
>> the initial goal was to cover regular non-RT cores, as on isolated/tickless cores
>> we should not have device interrupts.
> Who is 'we'? If you refer to your use case that might be correct, but
> you cannot make assumptions about the rest of the world. Real-Time
> systems are as divers in setup and configuration as anything else.
>
> Thanks,
>
>         tglx

all right, I've updated to v2: https://lore.kernel.org/lkml/20250714084209.918-1-wladislav.wiebe@nokia.com/ Thank you for all comments! - W.W.


