Return-Path: <linux-kernel+bounces-810912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5E9B5216B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305C95E0F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEF42DF150;
	Wed, 10 Sep 2025 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kJ/eahoc"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020140.outbound.protection.outlook.com [52.101.189.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825A2DAFBE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533776; cv=fail; b=GCSrXnkHKO/gKAowtCOhM4aIF+veFJzCBN615Eu0rYZs5jsxwPln4L32Xe8GjWDrq5uHEYx+9VEuZrh6TbUWpj6riRKWnorVDlc910sAKtjtylwCjsu5/UpATezwS7HnMBDG/9gnlSBj4e/Rb2JwCm7IR5zjnD5B3TchwJM2dKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533776; c=relaxed/simple;
	bh=EbTcNik31mfiEsncapR9nVsRBerTiprWpBkyzV8suPg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CQFW9Xu5hg/UQTxShbTSxYh9PYvjloOnUvdYlJyYou5KTICy4KGPyXWepmw3kDIjtunjl0HKXgEM98+rQn+8ad5UFdrPInSWj/kYS6vZxdwBIeKfh/TAnu0b8zqV5Rp6FZ3F/XN/tJlu2yuCpEvg/l3el+vc5bKE50Lrr52I3do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kJ/eahoc; arc=fail smtp.client-ip=52.101.189.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqxWRZCFut0XTCAt8MkidZqRGAztNg8x/NyzSu1wy49/hNaRXzTfpzPWXIo/PIFNlqcP84129fzGW86bPcGGteNaqTDJukz8u6mS+H1HWT17RGztEPqqdbQBYxS8JEzauvqqGuKnH/7nWDb3cgD/BF2dH7UV/Y+7AJNPOzBdrMuOc9wNdSi3BZvl7QU2Dt48lfCRGe0EkjrIwyuy9P0cQ8XaFgahCmLW1olopyeCyw0k/RfM0engGKwMyQT9EEearBh6s0MZMEhs1IKPjBau8h1E1tlvnC/RBbeXzCQb012/VNqkKrSxSLY9XLDq9W8FTwvcnnSnJyas2a4koRXNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dubpwirKlCxevTdedelaBXvvp8w9VceAy7NoMbXlXNs=;
 b=r8+E0x1F3XicJFB8vCBinrxmyl3S/zQ4w6az6z3ZnRRk9zt/3kHnJ5AF0kamY3vi6cRAD+2N4zh2E9ntLiC1dDq/Si/kdKUNQAZCMEOlXsgtX0e0uYUnAo2jQeN/EeFlP4J9ub7RwzBHwMQHOtJA8bcDOZxeNivsSrTGdHxEqkAI5xwDapmbwq9qnZ2nueDgaAWc4rhvdRACsC8MTwNlxwsUgYIMyigwYkTSMiZCblf4KsQXG6OQdm81SxXFbXpH6wBFKOXvOIDxW8xz6frNZjoN3MXgwZ2tTC/YteuvCJ3rryNXc5pMh8FocC0x2sHZs00kyO8C4L/j72kMFzrfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dubpwirKlCxevTdedelaBXvvp8w9VceAy7NoMbXlXNs=;
 b=kJ/eahocN7wyUv7uTik4A3oO0Ghmhf3XLYx9x0OwwUu+ABbWw0/q8lLlSbNWuUqT/pWY7e5S6At+QCpAjtAS+nIMq+6FJZfUFD6HmzuGr+Bw0yHqwzXtam/K88Rvp67epcGJbAFi49UNuC2XONcEM6xsdp+fqJxLGFovzPhBQDdytFrAGEbgG94RCrg8LcoyMinAjK208YA9y5JsBnlTxd3H2LOz+f5IMM4NLZqlanv5nx/pG6RYW9Za6JcAFGL0Lj65XoNPBDp1o/Ez8oUZX8sOQA5D6Hyi4cpgRDTAquZ9dfvvTvQ01RhO4n/ltv4l6bV/xza+S05fikT+a+/8Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6383.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 19:49:26 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 19:49:26 +0000
Message-ID: <77ad4c78-d579-4219-a8aa-a8d4acb8a9c7@efficios.com>
Date: Wed, 10 Sep 2025 15:49:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Luo Gengkun <luogengkun@huaweicloud.com>, Pu Lehui <pulehui@huawei.com>,
 Qianfeng Rong <rongqianfeng@vivo.com>,
 Vladimir Riabchun <ferr.lambarginio@gmail.com>,
 Wang Liang <wangliang74@huawei.com>
References: <20250909162155.76756fe3@gandalf.local.home>
 <CAHk-=wi0c5oBqQiZctP1SYAW7XGHYEDchJWBUSXvQA-XGmNk3w@mail.gmail.com>
 <CAHk-=wiDe+V=kc1HL-jT-C9Pn1AibAU_6CG4Bh9DLeJHfhrHWw@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wiDe+V=kc1HL-jT-C9Pn1AibAU_6CG4Bh9DLeJHfhrHWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::36) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 5228130c-440c-42c5-29ae-08ddf0a325c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEdEZjUveUlUQnVoa3NCVWo5TFVScERQUU1FV1RhWmkxTjJ6RHRYNnA1QTF3?=
 =?utf-8?B?OHovanJ0TkF1cWU0YTJTamYxY1BPR0ZOTmNQSW1rdHQxSW91Uk4yUEtWWjNy?=
 =?utf-8?B?UkYyNXM3U3NGYmYxT0J0UGtTaG5ueUI1cUZva3ZPdndVd1VEalRDTllIeFJR?=
 =?utf-8?B?OGtzRTBsa0toM3NuVk1Ybkw1YzZpTkQzZWh2NVhtVkRna1k2YTVFaUZwVmJq?=
 =?utf-8?B?TnBXc1BCRkg4R0FGeExhWGVPQjdteW92UDZSQmtvVVBSUkVCNVliVnVRS2FN?=
 =?utf-8?B?M2dUQTBLOHVVaUVDcTEwOG5JMTRQREdlMm5HSU5zcFUrWkk4QncwTnZHbVJn?=
 =?utf-8?B?aDcyOUxNR0dpUkU2UlEvU3NYckFhMFFhSm5xVUd3cHlGS3VtQXRMN3R1RE5Y?=
 =?utf-8?B?Qlp2WU1ZY0gwNUdGWUZlSlVBSWVnYmpaWUJ6eHBWMWY3SW8rQ2hvLzhtbkJu?=
 =?utf-8?B?UWlJSDU0LzBkaW02SWU0VHdxRUxhWWg0T3NHcDNETTYvVUIzVC9ScDQwb3JK?=
 =?utf-8?B?U0MzRVQ5RnRpQ0puQ3BFT3VEdStmTnBZSTE3N2tZbUp2ZitaMmJpMDVSWDNQ?=
 =?utf-8?B?dWhyV3JJK2Q3U2lDclllbld4YS93TzZDSGY1ek5uTWRxWGRUVGwrZFhEQUZU?=
 =?utf-8?B?NWY1L2dCbXoyV1Q1ZXlMY2ltUFVIekVwYVhEbmphNnZBOVlIZ2pleHFoQ3NU?=
 =?utf-8?B?dkRZbUQwTzdVcE95OGNGNmlGZ2UxR2hTbCs0M3k2ZVkxT1M3SDhaVjRkRllp?=
 =?utf-8?B?dE1BaUZmRTFXNmdvM0Qwd0NIZkNvdXJkeWxxYkZlTzBIVlkxemN0NnBPSHZK?=
 =?utf-8?B?Vjg5VEIvbDFDcEs5cWY4QnkwT29qWHlBT2pIbDIyYkp3THVPZURzU0xCUE1Q?=
 =?utf-8?B?eGswWnhQa0V1R1dweWpwRFBKLzVPY1Z3T281YTR4YmNkWHNkTll5SnNxRHlR?=
 =?utf-8?B?Zldyd2JBL3BraHhMbmt1RC9qU2dXMkVBUkNCRlVpM010R3BuY2tlajNobmxZ?=
 =?utf-8?B?a0o5Y1loYkxKYjJOMXRaa0o5V3JodzdVR0lFTnhiZ1dPK2ZSVzREaUJ4NUs0?=
 =?utf-8?B?WWlIRmVtT3dzUVJxZ3EvMkQxSkhMTW1UcEFVSmhiaWlDWGZxd0FaVXhxSWs3?=
 =?utf-8?B?cW9jelVjSG90TkgrWTRXOXZTdXV3c0UzNzAxbVNGWndNV0EwdENPM2dqaVIv?=
 =?utf-8?B?cXl5ZmliQURob3FHRUpETklhL3h1dGZZYTJUaXdrRi84TGhiQnJhTEh2L3Y5?=
 =?utf-8?B?c1dFTXUzQnAxNHIwTzRWQzhwZXp5QzZ0emhFSkFCcU5ocGNpN0pJU09GNDlO?=
 =?utf-8?B?ZnRvUmVZRVVWaTZBaDhJZkt0ZEpsa0lYMTJSalIvVzBPZnJZMGIvMTRncHRW?=
 =?utf-8?B?QzltZzIyamhpaXRDdTUwazFpaGNROHNvdWhUUW5hd1dZbUZKOXdGVjFKRXB2?=
 =?utf-8?B?R1pRckNwaVg3aTU0SUhTdmtpdDNzYTRSK3p4UHR3bXJ3NGFhaHJRc1ZDbGkz?=
 =?utf-8?B?VVhuZjFQRllBaithQStBbnhJOVY2V0taUndUK3NCdU5TT2xpOFgwK1JDVmlD?=
 =?utf-8?B?djhyK2QzZHZmZHQ1VjljVzJ2cy8xSGtoU0sycjVycGhvYkhuQkhCU2lsYmRp?=
 =?utf-8?B?ZFJWRkdIRXZ1NFQwTEw0ODFwSGdUei9Qd2dUVzNtazIxNlN2UzFoMXZNcXhz?=
 =?utf-8?B?ZEtiZXJvdnFDM2QwOFNteDhKbytXdzViR1JUbjBmQVhEWkQ3bnhuK0pzKzV6?=
 =?utf-8?B?aGlDSlAwM3p6SFA4azNJS3Z5Y3dYdnZvWFJYUWV6M2x0bjQzSHc0dStpVXJw?=
 =?utf-8?Q?N0unr5vSkXOkb82psy2ujx/KNaxd12kklLYzo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFJSeGZpTEZUOHdmVTdQTmhmWXRnMGdJRlBldWRuRWZPdXBtc1ZlWlNibDc3?=
 =?utf-8?B?WjJ1WVpBd2ZVRy9BOUhWTzB5V0lkbldtWHd4alR5aXg4REFNRG5RUHlSZGJn?=
 =?utf-8?B?Z1ptN2lKWnNQdFVkVFNBVzZEY0pZQy9HUlFNTXM2UmxhZTNZeWgyUFRMeWxy?=
 =?utf-8?B?SVNsYU9tT2RTaVU3TjBVV1hLZ1BUcFlGRnkxRlAxTUw1WCtGazVBNnlYM3VP?=
 =?utf-8?B?QmU0bFlsbXQ0ZWlBY2tWRGNwV3I3Uzk3SmlENFV1dUE0TlNXbWlmYXFJMmxW?=
 =?utf-8?B?VHJQY2hsMzhEejY1UlNqN1hSemc3bW1xUkF2b3lpTUlSWFU1N3JUcHVvRXZR?=
 =?utf-8?B?MGJmNVFnV3g0c0NnNTQrTkdXdldxUW0rVEwxNWZ4RXBOQS9aaDhwYkdJcHhR?=
 =?utf-8?B?L2l1bVZUczQ2QnNqcW1qN1A0QTUrVXMxMzVnTWg4ZVc0VEpMcEJtWWdSMngv?=
 =?utf-8?B?Tys0RGU4RlQ1MFVPdlp2QUxnOE5iQVBreEdsRlRqZVU4cU8yVitDcXlRTGVJ?=
 =?utf-8?B?VHJ2Tnp1OVliWlZ2a3RNMUxkR0dyY0IwVDhKZENBMXloM1hDbnIwb2xaWFUz?=
 =?utf-8?B?VjJBdkZxR1RWbnZCaHoxMlVuei8yanNjeDYvbG1QcHpqMXppZEg4aHBjc0JL?=
 =?utf-8?B?K01lTGpqUkZqQlFCRGc0UmxaUjdwSHJ0Y1VBTzl3RkVTN1RzaXJyMXFFMGxv?=
 =?utf-8?B?MjlaWjc3ZGJKd2ZtNXVjc3FiSUpVNm5rWFRCcUxpcUgyNXFmY3NaRXBLc0ly?=
 =?utf-8?B?YktBR3FsK1F1YmRIQVhpWGJ1WEZyRkhiaGtBODRqUHpGa0hOQUlGaktYWXV4?=
 =?utf-8?B?N01BaTREYy9DU2tZaDZUaGRXQkpZOVJsR1I2NUV2RWpleDBUcDFJMmRoLzBD?=
 =?utf-8?B?OTRrMWwreVg2RjdLZW52NTlGVC9QWTVtUWRIT05TanVBRVdVL2FjYTNFbTh5?=
 =?utf-8?B?QTRmdldIUkU3N1lqUjh4VmtEUkt4L2dsWW5KT1hWaUh0eUl1V29uYUxWbEZJ?=
 =?utf-8?B?S0lrdk51aTdYM1VJWTBISkw1c25zdUFrOHZNaWt4YWF5MEpPSjFHZzVsaUM0?=
 =?utf-8?B?S2VOWGs3QlZZU2VxMVFmcHRKWld0aCs2amJZakhJR0MwYUZ1QWFYRU1jajc5?=
 =?utf-8?B?ZTJCVTlIWGFnbUlOSUV5U3F4bzhaTWFON2hhbU9Fc0w2bG5yRmlhT3FJZ3l6?=
 =?utf-8?B?Y3FnKzRyUHAwT1VPZGVWMnJwOGFPbi8xZTJkd3JLakFsZ05NMVYzbnpEK3h6?=
 =?utf-8?B?cFVtb1pMbWVCYmFwT0h0enQyQWh5SGJieEN3S0c1VjF1a3M3V0E2aCtsOHph?=
 =?utf-8?B?RUxURDFIQ0diVHdHbEc5dkFJeVpBSDh2ZWtaek5oYk5wMElSZGg0SmFoa3Jj?=
 =?utf-8?B?anZmeGRoeG5GTXc0UEdvRUJtdWI1WHluM3YzV0RBYXo4RDhOR3d0UUMxL2I2?=
 =?utf-8?B?YThlamJTYWtqR3JNb2dORnRYOE5uemRkck16OVd5emVMci9LZ2J0MENuM2Fr?=
 =?utf-8?B?czF3b0NVVjJRRjBrWFdGYzYwTGdCSnpaUURSbTVoQ3NVYlFlZ3pWOUx3dWZl?=
 =?utf-8?B?cXROdXB5M0hNY0p1VGYyZDM3elJaajk4WWJyUFNIUmFpdjNtcy9BWnErWE1z?=
 =?utf-8?B?Mlk2ZjRXYStwb0xXSnU0TGVOSzgwM1psR1dpSnMyWUdaYjRrREJ5YkQ3SlZx?=
 =?utf-8?B?dzVLTXltaUFqQ2tCV2tpUGZEWEd6VE9ReDJhRUxaVUdqOUFOZlpmNlpLbUg0?=
 =?utf-8?B?YzAwcWI1NENNL29ybVllS0pzQ2pQMThGME4zU2VTRjBETDA5MXdCRXl0aFc3?=
 =?utf-8?B?cnF3NGcrTXZGMXZjU01zZytObEpOb3dYWEdJYmFZb0orNUs0MGRMQ0tiaXgz?=
 =?utf-8?B?L25PMTdSeUUrU0lVdmROTTN4Qk9lL05jdzFEdWxCVXRLa1VCbGdPSU45bFY2?=
 =?utf-8?B?YXhPTzdtYVJjV2dFWm5vWUxHUFFleTlLQWMrU0R4ZHRSaTVpd2pDc3I1eFRr?=
 =?utf-8?B?VVZzZ1BqTWRsZlpkeldhTVBqRWxrMkZyd0x4Mlh0MEN5YkFHRTZlc3JTWkt6?=
 =?utf-8?B?K2poS3NPQm9LcW1jMm9JVURLR2JTbVpQN3FrVWVVeTRJbWV1MUFlOWFGRk1k?=
 =?utf-8?B?Ui96SktNdDIrVWMxQkptWC81azVSNzZMVG5MUDQvUCttRnhNVnEyaVdqT3Bo?=
 =?utf-8?Q?3QH5Io+NFw8stGn5uWVIrdc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5228130c-440c-42c5-29ae-08ddf0a325c4
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 19:49:26.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNKjbFiXlejXB6CHa38nmWPJYQesaVotTuvCYpiy3FVqnciY4O715xojJeVqanuVAkaHLkEetQxk8wZluWxmlO6ysYzjDES0ynTidusxTT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6383

On 2025-09-10 15:37, Linus Torvalds wrote:
> On Wed, 10 Sept 2025 at 12:19, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> In this case, the appropriate coding is to typically surround it with
>> a pagefault_{disable,enable}() pattern to let the page faulting code
>> know to not actually do the fault.
> 
> Btw, I say "typically", because you don't have to do that. The page
> fault code uses
> 
>          if (faulthandler_disabled() ..)
> 
> to decide if it should handle the fault or not, and that checks not
> just if page faults are explicitly disabled, but also checks -
> surprise surprise - "in_atomic()".
> 
> So just being in an explicitly atomic context automatically means that
> __copy_from_user_inatomic() is atomic.
> 
> Which makes me wonder if there is something entirely wrong.
> 
> Because the explanation for this in commit 3d62ab32df06 ("tracing: Fix
> tracing_marker may trigger page fault during preempt_disable") talks
> about the task being preempted in between the
> 
>    ring_buffer_lock_reserve
>    ring_buffer_unlock_commit
> 
> and it sounds like maybe the tracing code isn't disabling preemption
> for the whole sequence?
> 
> Because "in_atomic()" does check the preempt count, and so just being
> non-preemptible should already have disabled page faults.
> 
> Maybe the page fault just ends up being expensive enough that it
> exposes preemption being more *likely* just because the window now is
> much wider.
> 
> Alternatively, this is perhaps an arm64-specific bug where the page
> fault disabling doesn't honor the preemption disable of
> faulthandler_disabled()?
> 
> I did *not* go through the whole arm64 page faulting code: that commit
> talks about do_mem_abort() which is done as part of the common arm64
> fault handling, and if that then doesn't honor
> faulthandler_disabled(), then honestly, that perf fix isn't actually
> fixing anything either. It would still do the same reschedule even
> with an explicit "pagefault_disable()/enable()" if
> faulthandler_disabled() simply isn't honored properly.
> 
> Adding Catalin and Will to the participants to see if they have input
> on that whole do_mem_abort() angle.

See include/linux/uaccess.h:

/*
  * The pagefault handler is in general disabled by pagefault_disable() or
  * when in irq context (via in_atomic()).
  *
  * This function should only be used by the fault handlers. Other users should
  * stick to pagefault_disabled().
  * Please NEVER use preempt_disable() to disable the fault handler. With
  * !CONFIG_PREEMPT_COUNT, this is like a NOP. So the handler won't be disabled.
  * in_atomic() will report different values based on !CONFIG_PREEMPT_COUNT.
  */
#define faulthandler_disabled() (pagefault_disabled() || in_atomic())

Especially the part where in_atomic() is not so useful with
!CONFIG_PREEMPT_COUNT. AFAIU, this is why we rely on explicit
pagefault disable/enable in tracing code.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

