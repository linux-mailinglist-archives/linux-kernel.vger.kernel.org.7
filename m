Return-Path: <linux-kernel+bounces-801363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6043B44435
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C001CC0B53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412A02F5484;
	Thu,  4 Sep 2025 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="F8Fm8xMR"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020133.outbound.protection.outlook.com [52.101.189.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB368EEAB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006460; cv=fail; b=CO+cbmx4ytQawl6td7BhyK30W3teR6dJNWKl3mdUmrnaWLS7Z+X2PgxRR5kNY5qPzVESC+v6+U9T3w2hDitvK4sSyW4mEvrr+BewzgkRDqa0leEvzx603UnAnBorTsNTbz4AKdOXSY3pUJE/gWmkNCXC0CLam/M8SGzBUUcuQY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006460; c=relaxed/simple;
	bh=kLwB3ESyVN6oJBxSs6q2u8Gl9CcQQ/9j/tpYhvrqV8w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=auNT9PKYGwCWFn524oDpMlh4hoNoWv+88Gi+U813W++JOVwKbYcAX0BdEzs46LZnkJoJqeWzSA+lAUgT2FX5vahHtgnq0QlHVV7HooHnOMzshfIIgd7eXwBCJbLRQEwT0kwHhzuDFvV2KXWXea1z2+p69NRfoRkfx5p13lGD4f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=F8Fm8xMR; arc=fail smtp.client-ip=52.101.189.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYPFc5XiQ0HOlCLcykgoiyP0kyvVDn4meKIe7U6hjyZjzAVFGMFmgFBzGehprjwfCKxXFYbWGHUrKHL9xru9K6gc4uy4ohiAG28Sd6oDDUPRBxVdTkWsV9mFtqS8GKmgr4DhCmxiEil2da++jGIiWsWoxyGdXnhUqBekyEaheVce8hejswtdL8UQpug06kbGalvF64/30FuAt9waVYJAQkMcNoYlchdSmecPuCZSvkfy2gK7S6o+gMm3ScLVOuzPF9b6+D7k51b6uHT2awvgzoRKY0XjES+l1Pwl+sB0AaAc8yRz+rpCqXQtvktW/m2D+FXrpIeicHuOAOt1ArvhyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQzdKYDsKskrLmpPdJZ2Fac3Zt0apWASp4C7QFSN7rg=;
 b=mPqr1ZPQglNCTKneww4XyFsUFKgwg3fPhCAE5Rp88BoZ/US6xxdGlru8E6KdlqEpwB3kSQEz7/dBFisqpuZgik3KYDPAq1UzHWT0b4fed/HnCFr5l2dumBfMAqYx4xH7t0rLPIQjVvIQ8mNtJNaF0okqITsmP5eqC5EqQx/qxzASIsLfyPuNubzFKkDhCszJvRYqswFwzDAzM/T1bqpS6L/t/jMAp80DzkMj2+VU4Z3m+iGW50nm9dNL+LZCrBcLh/xQ++EonRSQOGy/f4EZDZv0aXn0ibo7kDrgF3XsjvixF7Srg0Vcuy5aSPjm88lUlHbqOVdXdQVrK5AKrIn+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQzdKYDsKskrLmpPdJZ2Fac3Zt0apWASp4C7QFSN7rg=;
 b=F8Fm8xMR/EII7N++xmi8V40mxc/KrvGxbBlXzyPxyVg6Ts0hxfiMaWB+dkiz0a3DQ2FpPsMjBiY87zIgEwdoSbJlt2TuMf55TTR07jIPgngrnqpTdrB3jg6E7mhMK/mS1CIlafUa+EbLx52mI/Xx7olEUfCzTXSrO93+6hYjllLwWcC3j+EaDwzpvLGXhR9RLv+ZLoFxZRUtijp46Zo8Ba2c8aHc0QMFSWYgeHP2Ne7WwqsOUUPrjM4w5VeWCqof2RTI5r/LW2EPoY5nSFfW0ixG+ACEJ1LYnY1Yg7iHz1Wt9oXrJxsMX+I+Ti5rOCYzgNdXhI8piPprzlLEKwnGCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6669.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 17:20:48 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:20:48 +0000
Message-ID: <831f465b-3fe2-41a4-a50b-437f2e028864@efficios.com>
Date: Thu, 4 Sep 2025 13:20:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 08/37] rseq: Avoid CPU/MM CID updates when no event
 pending
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
 <20250823161653.778777669@linutronix.de>
 <566bd13f-54b7-42e3-808a-619a58ce05ab@efficios.com> <87ms7d0y5a.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87ms7d0y5a.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e88a115-5c7c-4b1f-2e34-08ddebd763ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K284SnVMTjV5RXlsK3lsZ2FLRXM5VU9aM1kzZmVnWk1lYnRQNVA1M2ZGTEdi?=
 =?utf-8?B?Nkk5L3RmQzlGZGNhSGZFNmZnMEFEVEY3THMwbFZ4L3o1Q05mZ004RFdEUXEz?=
 =?utf-8?B?M0NuM2RPQWc2bVdNWElEbXRFczF5YkwyVkxOQWEwazE1bExqUDVLbE9TdTRt?=
 =?utf-8?B?SklZclFhRWhycFJFcGNncmRBb01rK1NTQmxaQXFkdHNzUldNY0QrTEhEZHVs?=
 =?utf-8?B?RGM1NUk2MzN3bS9abHhGRnZ1Z1NGWTRoeDNZbG0rbkhrTnhSWWtCMGhyT0dB?=
 =?utf-8?B?RDhCSVJHeVpadHZrSHdRNm1iaUl3YVcvZVNQajBjUTNTSWxjd1JWVUIrYUVV?=
 =?utf-8?B?N1MzTWZHRC9naFhmMDhDQm1nMkp3RVVWSzlZT0lTeFhiSy9ZamVlZmZ1SkY2?=
 =?utf-8?B?MUFmaG0zb0h0NjVneVNpL3FHbjM4WE9Ba1VJNUYwYmxjVVdwUStNZS93OW5u?=
 =?utf-8?B?dGtXVlRpTytCYWdLclBLYmRXZEdGVkMrWDlSWXlRUmVDaHEvNUNrZGx5bmJs?=
 =?utf-8?B?NWRQSXI0bHM2WnhLUU1IR3NFMnV2dG5UZG5XNFNEbXZoSXdGdlIxbDlLSkFZ?=
 =?utf-8?B?RW5rc0FxQktUOHE1SUE4amlzekRENWRobHFGMEkyZHQzeDJnRmlyNExZb0dN?=
 =?utf-8?B?S0JtM3ZrcFhmc3RlbE8xeElVV1VJTlMvVGI1OVFObUxndE11Zm01U3dmdmx4?=
 =?utf-8?B?TDhJQ0RyMlBNWVJndzZwaGpFZUsyYTQ2aTZPYjM5L0tqNnUzeGxObmdSMjk1?=
 =?utf-8?B?allUVkJYN1A3b3BwWVdjS0FVV2FYekdEM2ptQXlRTlpoSFMrOEduNFBNM0Mz?=
 =?utf-8?B?NW1ZWWI0aUp6Y2pIQlZsNUM1ZGpPVCtoRGthSmlNQWpIaGtHbkpWUnNhQ3p4?=
 =?utf-8?B?a3dFRzZMR0lwalNJQTFHVHc0ajRnN0FrMzFLNTE2M2szYy9pcG1lVFIrelp0?=
 =?utf-8?B?OG1Bd1llNjY3TTBReWFuRDY5NmcvZ0FBYitUZElLWStXaWxUbCtab2Z1TlZO?=
 =?utf-8?B?U1VOUmJHRkZ6TVRJeFJXUFlvTnRmbmxUeW96bGt5UW1lVjFqbW04bkFnTWRI?=
 =?utf-8?B?ZVBRRG90dm5NTnZnc3ljb011dUQyYm9FeTJqRDB6Z2d3ZnM2dHpHNG1JUGlB?=
 =?utf-8?B?OVVobE1jK3pBRFVicXh0VjRueUNoYm51cXE1Rk1PLzN1Z2NHWHBhdW1EVFRY?=
 =?utf-8?B?WVg4SW9XWnZ1REdESkJsNzZWWlNBUVRwbVE0QnlseE9IU1BPdWJNenJVTTF3?=
 =?utf-8?B?NGFVL1k0cW5PUjFoSmw5VFYrT0RkQ0RaSE95YmxtcFlobDAyVlNPcEV1R2do?=
 =?utf-8?B?c1A2WVhua0h6RmZNOTNsZjNzRVhuYUFwS2lpckkvaVViWmVRQUJuTXBXV0d4?=
 =?utf-8?B?YS9WdXlYU0ZLaS9DV29DdjEzY3lpWUlwVjkxVzN3eVZIMWJnVXZYR1hoUDVQ?=
 =?utf-8?B?UE5UVUNHYlQzbXByZHlMK01qeW5oOGZudzg4NXkrTTJ0Q2pxYUV4YytoZWlH?=
 =?utf-8?B?Y0g0VDA1dlA4QXB4SEppRjhhOHJhYmZ2dG5yOUhoVjRGbklBRzBjcnRYUEZD?=
 =?utf-8?B?Mzg0M2FRQVFROUs1bThCdjBtUkNJOFpSVXVIcGRJMFVNK0xrU1gxYzZHYnV4?=
 =?utf-8?B?aC9Fb1R2V0dkVU4zMHdmbE5VRzhwTEM3YTdTemNjYjdFNWdHV0xiK1BnZnhU?=
 =?utf-8?B?K3k5LzRQZGZqQTk1M0RYUU1aYy8xa1lyNko4UzR5SlErTVYrdHdrTmx4cmVC?=
 =?utf-8?B?YStNZ1ZDWmdqTWsyY2ZLQmVxRitZZm5CVW13Ym5CWFJOTW5yVU9HZHJzRHlZ?=
 =?utf-8?Q?oNJOSszUIRJvN4Jmm9La41UXMn8XTNpVZ2CnA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmJ5dFVNbEdTNStpK3d1R2VEbGdBNk5rSGYxc0I2azhhUG9GUVhEZGNKOEdj?=
 =?utf-8?B?bk9TWmRZNkJYUVJ0aGlpTjFhSnhlandsdTFDeURrMkFTK2daYWtUUVVlU0pn?=
 =?utf-8?B?SHVTNEZhaEppNDVWTEZ2VHdzWG1yT21GSnRpQVoyUlYwcjNJRzB5djNzaXJD?=
 =?utf-8?B?NytQc1ZUcFNMbUZvVWdEL1lTZjFmdnJYNElqZ0VuLzVoR3NFODJybEJ2cmVZ?=
 =?utf-8?B?MG43S25DYzRyNlVZVDJzNis3UDhkMWM0a0taQnlIdDQ0SDNuWFNsbENab3dB?=
 =?utf-8?B?U3FrNHJWU0x3clFJeFVHam9pTk1jN2U2Q1gvb0FVTVNFNTcyVDBYM2xwT1M5?=
 =?utf-8?B?WEY4dzhIeStFZkd4K0FCb3pGaG5IdzByU29HcXdESUlmdWJjajFFbzJTdHJN?=
 =?utf-8?B?YlNpamh3TGlMcDRYbjZlT3NmM0xiTW1rNVVOSzViZHljcTZqVmxab016b3Vo?=
 =?utf-8?B?MGlhb0RwdmhVUHJtQlIrbnlxSWRSOHRBdWFuaWFPNGRoTlhvRmMxQ09RbU84?=
 =?utf-8?B?MjBzQ2c2ZkhFS3l5eHh6ZXp5UHFRSXJUckx4amJnUkNIOS91UXRnQ1hRbzJK?=
 =?utf-8?B?cVdMQ1BRODZNZEY0Qm43QkV3cVVvelhZQ1YydVNHd1V6VlRuR3BlaVJ2TjJS?=
 =?utf-8?B?NzQvKzBvVHR3K2YrS3BaWGRMVWZiclRwSy9YdTlvdU85Z0laelVOektUYzlZ?=
 =?utf-8?B?eGJXMHpwbUNMcHdLYWF5SllHTXR2STduWEZyRnB0Z0UvUndVb1VncTVkSUpQ?=
 =?utf-8?B?SWR1SnhXOFl2ZW95YmJuMkoyWUJTdWhwUklNZ21wWEpocUZzRmNiVlphWjhx?=
 =?utf-8?B?bGIxc2ZCbzV6OHA4MnZhTld6ZkEydEdNMmFRRVNjV1d2RmdFVjRYMWFPTVZy?=
 =?utf-8?B?MWd6NysyeUp5N1lQOWlUM3g3cGVyN2hPaUFyK0ZYR0dRa1QvQnpzNmRpRXIr?=
 =?utf-8?B?TTRXdjl6WEFIc3FWUDZxL0Jpdys5MW9TSUR1VGd6N2dXL1NYUUtQdHBIYU5n?=
 =?utf-8?B?OEZUMWJyUEtVRTAyejIvYllBOERPVm44RSt2YjNmZFNzeEF5b0kwaWRjdCtC?=
 =?utf-8?B?RzA4QnhCMjVlTHJZbmRaQ3Z5R2RhUERSVytkY0IraTg2S2J2T1RTNlpZWmJM?=
 =?utf-8?B?UlhId1hFUi9hUjFxeGlSSFVhcnljQzhsNmx0RXdLZ0dXNXF2STc0aXdiTGtQ?=
 =?utf-8?B?blB1M3B0d09YZzUzSkFoWEFnRms5MjY2RFhaUlRaVUt5ZXRtdWttcVBrck9M?=
 =?utf-8?B?N0hKY3JnSmsyeHAyRGtUbktWbDJkK2hOUVpzMnBPakd6cFJGeHJ5VGI3b0o3?=
 =?utf-8?B?VGVwUnpQblpUVmpPKzZnWDhlbmRHZytrcVVPSXdzQ3F3WXVzVUxKa0xwOFdO?=
 =?utf-8?B?L3E3bnBUZC9BU0IzUzdYK1BLaW1SbG1USGhudU8vbnpDbWtXMHpjZUVpK1JL?=
 =?utf-8?B?K3d0R1lXdndKNExPQnlYdG1obzVydC8raUJiM0QrbzFqNGhJTzMrU2FGMUZq?=
 =?utf-8?B?elRienNERlhseHRWY3ltU0tpcTdZeHJDSmVCMnBKRHVSZ0JMNzNRRTFzYnV3?=
 =?utf-8?B?bXIyT0ZibnJxVHd4RlI4OFR6WXRUL2IyYlkrWHZ2bVkybVFacmxIejgrRWxn?=
 =?utf-8?B?aURPWk9OVGtVdERuandOVzl3OWl4NXhFa3I2dDVCT0NnTjhvSm16NGpac0dS?=
 =?utf-8?B?UHN2R0Q4QW5ZNWQ1UjJucms0MVNxdVpWTnVXR3VQam9hVDQrU3RVZXN4V2Rk?=
 =?utf-8?B?TWdjT096WHNmSDRvR002VTdRK0FqazVtbTZEaEZ5RXRtSGJiMFkwc3dGS1ZV?=
 =?utf-8?B?YlBkSGRRK0VhTGtZL1NPL1VUcm1QN2FURWNtRVhpTmhxQ2FTaUgzUFhBaEJU?=
 =?utf-8?B?QVREelpqV2R2MFBCZXVGeUx6cW1VV0tGMVd2TnBnREdwTU96WmlsenAzZTZo?=
 =?utf-8?B?bHRnVVE3QTUyMSthcEc0ZVlDMWJwRFlSWmdPVHE5YlRQZWdUNkJOSjhoaUhH?=
 =?utf-8?B?ZVl3K2cwek0yaXpqK1cvQ2xXNUpZSGlnWjFadVJCVVlEUHJiMFQ2SUIraXFk?=
 =?utf-8?B?Tkx1ZUFucGptOCtvTVI5MVlOMzU2Sk4zelAxandCZjZkVTFhUDA1L3hSNGxq?=
 =?utf-8?B?T3RNZEFCU1AwT0hyQWpOb1VUUWpmQVJZRGc1WGhhVDRXRzYvWXMwZlpJNEpD?=
 =?utf-8?B?UG16VnFCMWtPNE5tcHNFdGladVpkb3BOVlRBSjdGbldldy9PVHRXOWJBQmR1?=
 =?utf-8?B?Rzg0RS9ocExGSUc5Zjhib2xYTk1nPT0=?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e88a115-5c7c-4b1f-2e34-08ddebd763ac
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:20:48.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wzdaYaPdtLc6J6BoVUTqeB8oEnI6B2XGHiAo4tP63/kaDAC/fRZeS57xc8doBSdwX2QegkAsFtKehh5w5EtX4H9BB5zF1B1z4OQfOQKiT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6669

On 2025-09-02 09:41, Thomas Gleixner wrote:
> On Mon, Aug 25 2025 at 14:02, Mathieu Desnoyers wrote:
>> On 2025-08-23 12:39, Thomas Gleixner wrote:
>>> There is no need to update these values unconditionally if there is no
>>> event pending.
>>
>> I agree with this change.
>>
>> On a related note, I wonder if arch/powerpc/mm/numa.c:
>> find_and_update_cpu_nid() should set the rseq_event pending bool to true
>> for each thread in the system ?
> 
> What for? That's the hotplug path, which establishes the CPU to node
> relationship for newly added CPUs and their [hyper]threads _before_
> those CPUs are able to run anything.

Agreed. Thanks!

Mathieu

> 
> Thanks,
> 
>          tglx


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

