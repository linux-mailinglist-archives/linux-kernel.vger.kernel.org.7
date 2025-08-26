Return-Path: <linux-kernel+bounces-786930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97092B36EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CE51BA885A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD4A371E94;
	Tue, 26 Aug 2025 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="B3L3e2Au"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2125.outbound.protection.outlook.com [40.107.115.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831763431FD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222917; cv=fail; b=DbMqjmlQidE4nztrLEX+RGOB/UuRxx0DwEVmWxSO1dfXnZishtUlXGGyvOx4tSZEIrBTXTxiNrLKZzLaR3VVWi6O/GY7RlBwH2nh+5weuAG7mkHdv2qBji5sS0nk3PQHLf/znrkhbZxegc+vMiJfyouzWld71GNPISKiaA509Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222917; c=relaxed/simple;
	bh=Q3FrgIE0902EMZf1SDok/sQvavXL+1ZKp7RpyhYk3dY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g9CR3KzGNJORr1iKCumS/LLmT00gYTm1QXcUr1pKNseQbD+CtHl+L8alhSFZaBKY+j+kjW1HbnPYbFAaWLhmJVtjd3yEw7L6WPsi/tqHJo/7eBWj8Xn+ZPNv/4ZjLtQ0hC6j1EJbAF+GEIOXHg5Sp7P4CZ9lok4KlzTZOlBvHGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=B3L3e2Au; arc=fail smtp.client-ip=40.107.115.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZwLnp/eGJI4paKFxx19U91xYdWmp0leyLPPSKV0DdtEhBUqjdPwptfs0rUiuLzsDTvp2/63phyp/M70JZbkWG/XfzIsSeIHK4hVmz/VEnirpg83r5L1o/4jAxudLbzSxGNj6/Uv6YPoNDdRf+H68tt9o2vbf0NtOHF6aDgQ+9vCl+LsdKaMgjv88o2RyJDae/7czZPSlIHNeLOkeoYL/brMTCUgcLS6MLYLHoo6tCICXXRLNcgjnxIhfdFmbjdoXIWjZg31WPYNKQr7H6qL7Rn5wu/pgp6l3CgRax/wrFOINH3x0DLv6ig6g3QUX8NeqePbM7+tjym0yNQFtpGHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amR5t3GL+zzBjdE87vtngXOjdOmsH028HquLVC4+8HU=;
 b=BkthmYiqtg+JYxFABVCKi/5aEP4Q/cUYYKfonf7ayNjnJUkgFxiWlHOJNrVoLMwcPi7hXLhbnFCCZ7jH9e/XgDqgLZv1Pbv1DdhndjSsslFUT92e6RAsuyIUyDdJ70WI0XaY2ZD2lEHgXo9RwSQLyey738U3xKDPkYDMH7sO0C86aoBWUjVlCFD3gZeM7xNCzvsCeDZs8xhupNN8n1mIMzOL2OMSOmwtONIMlrBD/9YodnfIe3HOh/Q/QdYzlzvlUtOge3zZs5P+QBaoOrQwOEr6plYKjFj4EH1f5qZbzKH8IwqQeieboJp+yMUJkAIUfa8c9SvgLikm6LM5bAtZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amR5t3GL+zzBjdE87vtngXOjdOmsH028HquLVC4+8HU=;
 b=B3L3e2AuSEeLefKwc10h9P5cJGasPuXuFA+aPuOAvIfth3abWpLk277wpVcu6Gml0SO2BKXTRWoxWB+1qWLR9628tmLb8xSPs8N4CsAFYqaD3hkxeMHeno2v2FkXT8FKhGU9CfXMcG5cRVu3ojBqZpgXGVtyZf08ZvaLYPJmTyvY695cwoSyxGu0SFLhuy59TAOMqcEq4vjFR36LsITa7Nmq6ylshL20kRhNyvisdBR/4HfswLvoX2vyFBPWXy+IxrMWcYk/tiDdBNX4bwLfT8PfPS73egjWZL9lCxUDo5cC0il589AAahjSaVgztBOgs9WL1c+9N2LDMYXEpTNQag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8740.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Tue, 26 Aug
 2025 15:41:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 15:41:52 +0000
Message-ID: <9ac25827-6421-413c-86d1-09f877b6e651@efficios.com>
Date: Tue, 26 Aug 2025 11:41:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 29/37] entry: Split up exit_to_user_mode_prepare()
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
 <20250823161655.127882103@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161655.127882103@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::23) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bac51e4-dcdc-46d2-6fe3-08dde4b713ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFAxblRScDExclJCZWZ1WUxMeFdqdkdUcjU2Y3RMM2haZE1ObEkySWk0dG1S?=
 =?utf-8?B?a1FaZEJoQTBKMUdUTllIM3kxUERrNGVLaXZZeTAxdmdwRG5VelNjeU4yZitW?=
 =?utf-8?B?b2JCQTYwTkdycWtGTHJ0RXNQMTBLSGIzN1h5QS90QjVRT1IwR1Q4dTVJMElY?=
 =?utf-8?B?U09uajdlQ0ZaZmEwcElrR1czNGN4OHU2Wk1GR1BlUU1VL3d2RlRPRWxwSlRq?=
 =?utf-8?B?dEUrbVg3OXhrNFJpSVNZSkFEeTI1UWdkOCsrbTM3bmpIck5abGJGdkMxUno1?=
 =?utf-8?B?eXRtRGtMalFtd0NzY2ZkYnJJc3d1SWkvWjRjd2lEd29iWm1VeXV2M2xwZ2dR?=
 =?utf-8?B?VjVhOVNQeldBQ1FnL0NjcW9yT1NnQ1RJYWFqQi91WGMvYVNEWDVVZzBtOCt5?=
 =?utf-8?B?cnlTRUxBcFRnQXpIWG9LWWVYNGhvcUhHUFEwV0V1c2JadklndVp1QU1mK2pP?=
 =?utf-8?B?RXdJaSs5WUNLamVGbWZ0MGwwYXd6Wm13UHo2bmhsdjBFcjExN3UvWmFYdzNn?=
 =?utf-8?B?YW1WYzJwcnlHNElXd0xtY1c0UjRBSVFIREtOYk9uKytKa21mMnU1Z2tSVndx?=
 =?utf-8?B?T0kySERGREpqbit6YjdKRytKRnk4Nm1aWm1ZMDNONFpyK1pVdGlmZWFEMTNp?=
 =?utf-8?B?alFmcThKSE1MVjhOWGpLcThkVlJDbTVqRVJ0dzRTa2t5MEFuOGtnKzRZS0V4?=
 =?utf-8?B?ZElXQkpINjRFMjdOV2xiVksyVnloMW5YaW44RC9xejV0dzZUdS9xUEFsVTQ4?=
 =?utf-8?B?YXFSUWxrTkY1cHF2RnpmWjVsZlFpMHpqNUxsMmNRTUJxUDJlY3gzSE5YWHRG?=
 =?utf-8?B?ZjZaREtJUElqd2EvM0tZcFNXdXp4cXpRZFlSSHNTSTE1WGJ2d0J5all0R0RF?=
 =?utf-8?B?UE9DV3dzNldUK01GdGpONlc3bmN3Zm9PSjFRUGpIN0dodjQxSjBGRFdML0Jw?=
 =?utf-8?B?dnJwTE1XY2RCOEFEcjZudFRJZ3ZsSTlFSGhvMTRMQkN0Yno5eGVLRi9meENl?=
 =?utf-8?B?UjF3a2tadm5sU1pYcTZMOTBGcTZLRVFkbE9YbVJjZHIyM0x0K0Y1OEdPUHZr?=
 =?utf-8?B?NlFaeDlBME1tc3dPYXFsZ3NoR3hqTDZLNE00WU00dUptNG5qSHJyc1lWNnQz?=
 =?utf-8?B?SnU2MTZDbnVhNVpuVUlhYlFYQUNUZFEzMHFyaG1CWENCRnNsdVlkTkdNQ2dM?=
 =?utf-8?B?d3FtQnFCcWZrVWpBanpiZTkzdEFlc2N0RUZqS3IrTU1VbXNCbFVEb2hxNzcw?=
 =?utf-8?B?aWhsYktRamJkeG1yckhiR3RhOE9VcTc4S2hVc3ZtYzUyMkZiUVEyNkVBMjJ3?=
 =?utf-8?B?UTc1Yk1VNzRYQTNSSzMrSmYyNGZHN1ZpU2FtRVczajJaL1hSVThWL1RLZzho?=
 =?utf-8?B?ejBZMGxCRmlXV29HdTZIc2tQMXNFMk9vbnd2TVppWFJuaVlOd0NLemR1S1Ni?=
 =?utf-8?B?NHdRWGdsajlVZy9VNE5oNHZGUlhucHRRcnZxV0xwT0QxOUF2SkRuT29QK3Z2?=
 =?utf-8?B?cjV1NTdRRGpSUUMydDVuMHJmYzFwSjRpeU9lc2xRSW9oM01CdTllWXRsZVd4?=
 =?utf-8?B?bVhQcDdWUW5RZS92UWRFVkxXYkx4NmhuMWZOU2ZabGpLVWdxdm1ick5WWTl2?=
 =?utf-8?B?a0Q1Y2VBRnM1S3Iwa05RMEJpNm14YmhEZmg1Z2pGZExaQTJhUkRhQTBsa09t?=
 =?utf-8?B?blFJb1h3MW1kbWNOUW54c1UvUDZxcTRsK0ZxZUVOblFKNGlLQXV3V01xSFNm?=
 =?utf-8?B?YVdoZjc5L1k2M3VxS0YrQUtObVZQWDk4TlZpTzd1YWVaVUZaVEVEdklRZHNS?=
 =?utf-8?Q?VqyqI9fTy3bGOOAkNbu66VaEMFCETDe8N0ZSw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0J4U3NQMTRlK1BsbmVlWlEvMm1VNk4yOWZ1SUExT0liRDlXYnRuakRSNVFR?=
 =?utf-8?B?UXlQV3RFN0MwekJoR0VZTlhvVWltazVVanNVclpzZG9IRlROR2RwM0FCUUds?=
 =?utf-8?B?SjFtZGJYdm1YazlIWFlqL2RjZ0tBMmRoWW9RRHc0WTdRVnVnLzF0V1JGSStN?=
 =?utf-8?B?V3ZvL2tUUnF2Mm92S2VTYlljaUcwVkpSNFEvUjdPdzk3cCtIY2t1cHhxbHJZ?=
 =?utf-8?B?VjQxQThGWUtxUTBFR21Ra0MwWDZrUlVyMFRpd0FsUXo4TWJMb3J0K01UcGFD?=
 =?utf-8?B?NHl0RmdYbFJQNnZER281NmUzWVlNL2t0UE5QdUovTzdFblA4L3JwZ3ZPdUVs?=
 =?utf-8?B?UDk3akc5aHlYS0J5WnorcEpKK0d0Z3IzTCtIVXhSODdSSGN0enEvaUhVNU13?=
 =?utf-8?B?SUVYd3c4V2JPUGZxTExlQ1hHaWR3dUlob2JycjJLTnBEckt3dDJPd0VRaHNp?=
 =?utf-8?B?WGVvVFZPSE8zaFFkRlVLR1Fpdlg1WEozU0pPT0piSmVFUkQ0VGVPc0NtVzhj?=
 =?utf-8?B?Q2QxUkJBeWlKT1VzbWxHWjREVnZTTm5nTlpmMzVUcGt0djlZb2xlUDFaWTNr?=
 =?utf-8?B?TzFCbVVLV3BnUEVGREEvYitocXlRTW42RVUrTkxGZHp2RE1sUnN0ZEUyUGJM?=
 =?utf-8?B?T1gzVDRKM0hQWXh6a2dqRFIwY0g0YXQ4WkE4U0FXeHRETFVVNi8vY0FteE41?=
 =?utf-8?B?N2hCSnJSV0x2TVY2cHQxQnBBRmdiVHdBQWNVTzlMOHlzZXF4cnkrd1ZwNmZH?=
 =?utf-8?B?Y1lZaUE4ckJNbkVvSmNOVUt6R1J5eTZCQzloR1BWeGhMTmhiQlNHUW9kaEpy?=
 =?utf-8?B?QVNGSEYwSVNORDgwTHBJZExQOS9WdUJKeWtXY0EyZmQxSXgvUEp0bEVvdnN3?=
 =?utf-8?B?cHFtYlh4SnpibDdMRTNkSTd0UlhzSWIxaWtPYUREdmFBOHdLVzBydUcrY0JN?=
 =?utf-8?B?Y0UxU2RHUzEwS2lqZmtXOU1TaHpBdnorUEl6a2tDZkhCQlJsU3JhVy9nWmJE?=
 =?utf-8?B?WGk3L0xjQU9EVWw4VUo3UGFNQ3NCSmpXSzA0cjh6S0tCSS9GdlNXMkZuaGI1?=
 =?utf-8?B?UzRjL3JNNjlZeTA1STJVRkNqY3lIOXIrUFdaUE92Q0hqWWpBTWRnVmhra2pO?=
 =?utf-8?B?VWhWOWE5b3Z4Vks4di9qdnI2QlhSbzg3dFhLRURieHlKRW5VV3N4Vnc4Zlht?=
 =?utf-8?B?dnJUclR4SGdub0UwN2xoQUNJcDhiMGt4SjJyQzE4cDlMWXJESWY4dEN4ZVZF?=
 =?utf-8?B?VGVIUWdjR3dUQjFWSjYzOWF5NnZ5VktYMHNkTzFadXhzbUJERGVNN3JyczNN?=
 =?utf-8?B?VU9xWnFBWVg4bHlsdmZTZW9aVlF4K1JJSDhjdU5US0JHaXRDcE54Y3Y4VjFq?=
 =?utf-8?B?aldIZXkvVXQ4M1k0Mlo1UGM4R1hDalpVWFpPTEtuTU8zcXlYSjAwVDRVb3dN?=
 =?utf-8?B?MEQvNXIwTHNTYk9FYTF5TlllMGNLRmFYVytpMHZNZ1R2dFY0K21zeGpEeGNU?=
 =?utf-8?B?WmNBNFllYnMrTHlXYm5nc1NRWmpMZ0k2dndqUXRLZ2YvT2FMcE94NTdOU0wz?=
 =?utf-8?B?VjJCaHVyM3hzSWNUNWlxTFhCR3JleHk2NjRxUkRRWkdqa3duSFZpQVVveGVx?=
 =?utf-8?B?MVB0Qm1yd0I2bUV5Nk1PL2ZXRnpMWWFuOWwxT2w1eDdMWGlObWp6cGRnMVJY?=
 =?utf-8?B?bVFFa3ZKaGNxTUFhVUd2Q1luSGZSTzIvaGpGUUc0WVM2VEU3bVZCQ3hUL1Ew?=
 =?utf-8?B?NUYwd21qenNUaldYNzA0RFJQa1NhY2Y3dmEyK1JIWUliNFhVODd5VWxQM0Nx?=
 =?utf-8?B?dGxpR3JTSjFVKzg1d3dKLzZ1N1RKVFpUcWdNTDNJWmx0TnZSWE82TFB6c2pv?=
 =?utf-8?B?V3Y1OThBb3d6ODBlRUF6NmNGeSt3Q2lNU256bXFBNEN6SkJRWGQ3OGhkYkFo?=
 =?utf-8?B?NmpsSEcvdk5Zazg0Unh4UGlkeXJ2SjFoWlI2Ri9PY2dpTERhaWxRaVk2RFhz?=
 =?utf-8?B?dVBoUzRwakVlaWV0cjMwb0FTRkh1OVNxVlFKa0o3MDFUVzR5b1VUVlAycmUz?=
 =?utf-8?B?L0NWNElSMDdqMkZhR3N0QzFaZ1lpRERCUENIdzZDWlpET3ZWVWEzbW4vb2pk?=
 =?utf-8?B?MXhKeVptY2hSYW5RSk11dGJKSUJ2YTJKRHczMmdFYXUyaE5nV2FQNDhJSVBS?=
 =?utf-8?Q?IPn+VBfres1fsJFAuJ2k1jE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bac51e4-dcdc-46d2-6fe3-08dde4b713ea
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:41:52.2977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SH2MrzmzMAozXhGE65x8u5xVUuGqCIieR/RymqTpFly/pQbYjCmv/vAW188flkx0V4b224DmC76E91uaw70Qj7cg8C0y7+Bc88aRcDthoiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8740

On 2025-08-23 12:40, Thomas Gleixner wrote:
> exit_to_user_mode_prepare() is used for both interrupts and syscalls, but
> there is extra rseq work, which is only required for in the interrupt exit
> case.
> 
> Split up the function and provide wrappers for syscalls and interrupts,
> which allows to seperate the rseq exit work in the next step.

separate

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/entry-common.h     |    2 -
>   include/linux/irq-entry-common.h |   42 ++++++++++++++++++++++++++++++++++-----
>   2 files changed, 38 insertions(+), 6 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -156,7 +156,7 @@ static __always_inline void syscall_exit
>   	if (unlikely(work & SYSCALL_WORK_EXIT))
>   		syscall_exit_work(regs, work);
>   	local_irq_disable_exit_to_user();
> -	exit_to_user_mode_prepare(regs);
> +	syscall_exit_to_user_mode_prepare(regs);
>   }
>   
>   /**
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -201,7 +201,7 @@ void arch_do_signal_or_restart(struct pt
>   unsigned long exit_to_user_mode_loop(struct pt_regs *regs, unsigned long ti_work);
>   
>   /**
> - * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
> + * __exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
>    * @regs:	Pointer to pt_regs on entry stack
>    *
>    * 1) check that interrupts are disabled
> @@ -209,8 +209,10 @@ unsigned long exit_to_user_mode_loop(str
>    * 3) call exit_to_user_mode_loop() if any flags from
>    *    EXIT_TO_USER_MODE_WORK are set
>    * 4) check that interrupts are still disabled
> + *
> + * Don't invoke directly, use the syscall/irqentry_ prefixed variants below
>    */
> -static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
> +static __always_inline void __exit_to_user_mode_prepare(struct pt_regs *regs)
>   {
>   	unsigned long ti_work;
>   
> @@ -224,15 +226,45 @@ static __always_inline void exit_to_user
>   		ti_work = exit_to_user_mode_loop(regs, ti_work);
>   
>   	arch_exit_to_user_mode_prepare(regs, ti_work);
> +}
>   
> -	rseq_exit_to_user_mode();
> -
> +static __always_inline void __exit_to_user_mode_validate(void)
> +{
>   	/* Ensure that kernel state is sane for a return to userspace */
>   	kmap_assert_nomap();
>   	lockdep_assert_irqs_disabled();
>   	lockdep_sys_exit();
>   }
>   
> +
> +/**
> + * syscall_exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
> + * @regs:	Pointer to pt_regs on entry stack
> + *
> + * Wrapper around __exit_to_user_mode_prepare() to seperate the exit work for

separate

> + * syscalls and interrupts.
> + */
> +static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
> +{
> +	__exit_to_user_mode_prepare(regs);
> +	rseq_exit_to_user_mode();
> +	__exit_to_user_mode_validate();
> +}
> +
> +/**
> + * irqentry_exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
> + * @regs:	Pointer to pt_regs on entry stack
> + *
> + * Wrapper around __exit_to_user_mode_prepare() to seperate the exit work for

separate

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> + * syscalls and interrupts.
> + */
> +static __always_inline void irqentry_exit_to_user_mode_prepare(struct pt_regs *regs)
> +{
> +	__exit_to_user_mode_prepare(regs);
> +	rseq_exit_to_user_mode();
> +	__exit_to_user_mode_validate();
> +}
> +
>   /**
>    * exit_to_user_mode - Fixup state when exiting to user mode
>    *
> @@ -297,7 +329,7 @@ static __always_inline void irqentry_ent
>   static __always_inline void irqentry_exit_to_user_mode(struct pt_regs *regs)
>   {
>   	instrumentation_begin();
> -	exit_to_user_mode_prepare(regs);
> +	irqentry_exit_to_user_mode_prepare(regs);
>   	instrumentation_end();
>   	exit_to_user_mode();
>   }
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

