Return-Path: <linux-kernel+bounces-897175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54C1C52369
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECEE3B7270
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5E5314B70;
	Wed, 12 Nov 2025 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="O0Yn3WRo"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022102.outbound.protection.outlook.com [40.107.200.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F15314A85
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949059; cv=fail; b=V7AfwQVU7h5V8OCRZvhWuCJVgeJRVExYg97Le4fPYzxfmncfaJSzAO2r/CgjDFwtUQ0hVooNYhuhoOO+rbtGskfrA4OirVGgSzs7yjyCb+SjGMie6GQ/fjHy1OMY1Lc3Q0yU+Qgqw/mEnm4XQrzMoMQPN/REDlXVeOi21nsV/K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949059; c=relaxed/simple;
	bh=gdysYandrvgz3d5SnMB99rkcKZizze1jG8EAmHcxBuM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=om19mwTVzHELOJtdpTr7r899/wNw4xSo8E7kAu8jd0mUNIVVaeJaYuK9HNFqMid8ipE2xWq7MxC5AKxn0fkNMwFXGicM3LyZb/zMwnw3WTki2+Wq12xCiDlRhth9zAk39EZ7mhsQugBE1n4bvMNZhODdJPQajmU24XgYgbJH2LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=O0Yn3WRo; arc=fail smtp.client-ip=40.107.200.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiLzZoW6tdrAQ+XeBqS6reftJXANxjJrgQYEUnQPnPYbAHB4AK3jE8/AtFyrKheh6FRuy4Ds32gtSzTAu/xWCnp4WYxqMaX9+gAWUTOykIFxTlD6WAnOLsCbqJdXmkajv2Fgg6jcQQFgaesSASLwRltGkpHFQ+a0mPCpcRRtQlr0zOQeRwt0OMrUJppRPyln5+SEn8dkw3yInH/YhpTg6zlSbAbwwr/w+ahwIg/mTeQNtEYRhfXrgCEILgW155Pwx1KmRw+OM4y0Be242M2ETurGkO0UvAWR8CCbpvrKbqhRWFMHqDQZ3hnuSDU0hhX55X5oKTGY7hnT/qC2/9EiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWNw7pi9gm+a/JftsaeZoGJj6CU2aNhG8JF08hAHEKY=;
 b=kE9J75VJtwOUnGcnXJ7nsPgFvS3EWckv857OugOBqLrdmzpR/7eDLMdhtKzC9Z5Krzq10nDc3YpRHcKZe3eAnjGAJMkOb6MVuM0FWyTpxJgZqeK6ED70d7Td0uIFDUBxh/cPmLobFcDR0cx26ZxT9uhqHuzHxd6xY3iq5mhuD91KwYScfTEQcHBdP2k8DX7wZKNkjryHP5KZAu6RPGSkdxXXih/lU72ImJPAmKs3jwI51BDQIxdjZrqBfwK7cOqxrMdGNUZihYd1KLcUKnjnENUrYpbUmKuXqEucC0zEfSCCvAHxKOtUaFfBjZQnn+EaHAlQBILpRTqZR+2Y5ispjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWNw7pi9gm+a/JftsaeZoGJj6CU2aNhG8JF08hAHEKY=;
 b=O0Yn3WRoJ3PU9O1xyIxbT6NIIJdTE2Hx5r3QFWK8/FZAjkvAX7Ajyg0mKxG3n12xOOkHm3JTOBBwiXtl4gcBUrOg2gDlWOeIHUXmCE85IUrhfkzIRC8GDy1N7BKxk9xo+eKom5S/JHyG80q8JLm2gVOqllfZ/FUr9k7dCz/6Mw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 DM4PR01MB7860.prod.exchangelabs.com (2603:10b6:8:6e::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.15; Wed, 12 Nov 2025 12:04:13 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%5]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 12:04:13 +0000
Message-ID: <39bf6191-82d5-467c-9c09-2deb420875ba@os.amperecomputing.com>
Date: Wed, 12 Nov 2025 20:04:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sched/fair: Proportional newidle balance
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chris Mason <clm@meta.com>, Joseph Salisbury
 <joseph.salisbury@oracle.com>, Hazem Mohamed Abuelfotoh
 <abuehaze@amazon.com>, Josh Don <joshdon@google.com>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20251107160645.929564468@infradead.org>
 <20251107161739.770122091@infradead.org>
 <ee62fc73-2a08-4648-8852-afa9e2705c8c@os.amperecomputing.com>
 <20251111092009.GE278048@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <20251111092009.GE278048@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|DM4PR01MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d2d049-0935-4a4b-4356-08de21e398b3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkVBMXVLVXQzL09vaWhtbkxhRVBiaCtLTDF4dlN4T0NVOXlEcWNaMUs5OVpi?=
 =?utf-8?B?T1FyczIwanpOY3JsbG9WMnplK1Q3elN6WmlVb1pqS3U5VlJqeTQyUnNsei9V?=
 =?utf-8?B?WWRuQ1FodEUyQ0RwNEJnRzA4Q0ZTYWM5MUplclZIOGwzRUQ5S2JsTzlzTFNG?=
 =?utf-8?B?Rk8wSjJUazlLQm9vQloxc2NjeGZSMUgzK3N3NmZzREdHNElDdWNyT3J6dVNQ?=
 =?utf-8?B?bzNoUk5UUWcxRmU2Yi9PV2hla0E4M1hvR1FNdGlwdkFFb1BrYzZjcFRadjM1?=
 =?utf-8?B?REg3cmovMjNUYlhYV3NIZVNoQW5XY2QrQ1VDUGJlMlJ5ZEl6MjFXVXNTelBV?=
 =?utf-8?B?L0xEdGlyejNDaXFORGRLb0NjWGpYRzJmRWtJS1MvczcxZXNmdDgxc2hXdzkz?=
 =?utf-8?B?QUllbFZWREM2R2Z3d1VvNFk4Qnp4WG83RnhLbENXdGl2QWVSdFZCbUYydVRr?=
 =?utf-8?B?cUhVRDRYbVlFTXdXMFhZMGhlaWJTWTl3ZFE0RTdsY242QWRRaFlKMmsrZ252?=
 =?utf-8?B?V25tNUpyOTVhUDduRU53T1ZBSk5udTl6QUtPbXRUMHZQSStUaWt4K2VMUFlq?=
 =?utf-8?B?QzN4UFZYMGtCOEFtY2NqbzdyYVQ5dVF6MW9lTmV6M0VuVEVnVFFCLytHV09J?=
 =?utf-8?B?VitKckFFMGtaTzdidFVBYS9KcW5OYUdiMnNZZ1FSWmVuamZwQTQrVm9jMVJ2?=
 =?utf-8?B?aXVWWWpHRURTa3VYSjhzbUJBL1VqNXRDSjRmN0VMMG55Z2NqL21kRVlBNmhF?=
 =?utf-8?B?UEt2aHBtendZc3NSRUk5aUFsSU9MVU1vazQrWEMyeUhBUmIwOTNJd01zOFBi?=
 =?utf-8?B?ZUsvckxTMkhpL0h5VTY0RjdRd3VSb2xHTXZNUnRnblYrNTBXdU9OL1ZDcys1?=
 =?utf-8?B?V1JDTVR1dXRZcFlkSys4R0Q4eGdaUEFadC9qWS9wUEpDS2xETmRKMEFnNWEz?=
 =?utf-8?B?UnJ6ZE5GalVHaFdjRGkwencwOTlXVmkvZHJJUFpkVy9kWkwycUg0YitndVpI?=
 =?utf-8?B?Y3ZGUnRibGNROVVUNnhVdVdzZ2dkcEtUWXJxamwyWEw4NFZ6VGRqTFpqQ3ZZ?=
 =?utf-8?B?VFpXcVZjK2JDY2ppNGZnQXNzU3pkY3RQdE5IeVFqS1Mra3g1T01TMmN6eGhi?=
 =?utf-8?B?RFA3MnMwY2RCYlpCZEV6RkJ6OE9hQW5uWjBIWUFoOTMrK09rQjVqRnpUSHk0?=
 =?utf-8?B?dTVKUllJblhEcDRCYUZBMElDVm1pL1lYeUVHTUhZYWprUWhURU9EVkVYcExh?=
 =?utf-8?B?eDQ1S1BMZENydVpibWIzMmdkSmNiVUFRMG1tam5zN0k5bjNCSis2UlgxMThz?=
 =?utf-8?B?ekJuMm1QMFBnUjV4bHlDczFaV1Q0aFREd1NYZWp3WlF1WUxQN0FxK3NHaUFj?=
 =?utf-8?B?RWhlRnUrbUFrSFZTaDRYNUx6NU9ZS0Q1QkNCaXlzVDF5UllHdmVWTkZTY2kr?=
 =?utf-8?B?SGZJMGkzSlpTYlNiSXhWMjhBbnNJeEpHeDk2T1I5Ky96VWNCRVRTQTVJQW5t?=
 =?utf-8?B?U2phSXRkUFcxQ0VnUkZEYUFZb3p6ZVBqR0JWMHNIU0IxWlNHKzRvb3lKYm1M?=
 =?utf-8?B?Zjk1cTFnOXkzbFdydk5qd25aWEp6eWJTd2dzWnFNcWFmYm40elJ5eUlqbHB3?=
 =?utf-8?B?Nk1taytRTVdDY2dzVml5TkNkeTlONFBTSFJldjlUZDZpNXhpa0RHYWdncURa?=
 =?utf-8?B?Vjd4TldSTzl2OGVKdThUNWozQ1EzUUNTZ3ZRaWY4enJldXNkenpQUCtSK0hq?=
 =?utf-8?B?WVFmbXJ4WTRiNEkvbi9ZdFdKc00xNVdUMDYwWS9pbjBjZHhGQk5SOERteVU3?=
 =?utf-8?B?aWFTcVJQbzdyR0lWRmJkTHpCeFZYb0FrbWsrK254aHdPak5XQ0EyekszSWVM?=
 =?utf-8?B?K0EzTHJwZVNsbjhYRGRNaXlKSDFOQU1YS2kwRFhOaGpDa1hMQ1FmNzUzazAr?=
 =?utf-8?Q?ynmJhjGR+ywXD322U6pDMPvOsXB2L64U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3kvZFlGb0N0L0N3Qzc4Y1dSWnMwaml0aHV5bEx3aEFia1JVT2xqRXFlL2Rl?=
 =?utf-8?B?U0p6Z2p3cWFybldBakdrb0tvdW1SeUV4djg5Zy91RVJ2UUhXeVpNSkZrVTRU?=
 =?utf-8?B?V2dRRFdlbGF5YmNtd3Z4UnNKRWZUQmp4cGFiUzRBMGQwQjErcU5iRjBadXRk?=
 =?utf-8?B?ODBPRXJlK0RIbzVEZHhVOFN1QkY1UUdVOVFtaFpJUCtFMlZxNjNmeVYvc2l0?=
 =?utf-8?B?UFFCRWpYdy80eHFEcVgzZ1FkZ3plQjdGd2lqUmF0Zis2amkvNnFrS09iTkVC?=
 =?utf-8?B?KzhDQUNzZmdNNTYxLzZhN0xmWDE1NDJBcVhCa214RCtOZ21mdG11YjlWUlpU?=
 =?utf-8?B?NDRsY05hZ2ptSXNDdjhXelNCU0JHbllJbXhYKzhTMGlWUzRnMTBGcVRUYmZY?=
 =?utf-8?B?NFpDRWszUzVZeEcyUzRaL0w2VmlyUUx3WlZTT3JYYW00VmdWVkx4eEhqMm5R?=
 =?utf-8?B?U3ExeUZLMy9DN25maWNlbm91UmVMVEFKU2RwRGYvRkMxcU4xUmROeGk1WVFU?=
 =?utf-8?B?VnJUYXBLbWczcUxIUERzdEFyRmJDYlVLUGgvU0had2pSYUpRcDJWV1JkVEsx?=
 =?utf-8?B?RkV2MXE3N0VDdzBRRExnOFFUcTVlYnlUKy9XbUJjazIxd044OEdVTnJTbFd1?=
 =?utf-8?B?eHYxZmVqL1dXWm9HeW1HZnB1S1BFR3dvZG1VSS92R3hZOGtsbWlGQ0dpbVhL?=
 =?utf-8?B?RFVtQXNVTGFRM1lZTlJvWldtWDFUOFdpNkhNWGtSTzRELzVXL2JMb2N4aVpE?=
 =?utf-8?B?d0hJVUh4M0lsbXJIakhOZzRrMTF3VGNVbmRiaWtCOVVjTlo3OTNaUVNIaHkr?=
 =?utf-8?B?S2pPM0JnckFxY21xUWFJZEExVndjVmNKdWdJcjZ2VUtUWmhHM2cyNnllLzIx?=
 =?utf-8?B?SldvQlJzVmRHcUt4UkF2dGl6bS95RGhjWmFES29YS1ppS2ZkcUh5ck1kQTMr?=
 =?utf-8?B?MWk0djcxY3lqQUtiZkx4S0s2UjhHZlNmRGdLUWlIMlBkbmpzZ1J4SHVJeTRR?=
 =?utf-8?B?THQ3elo3YXdGcDdNaG8vZ3NsM1lvQTUzTnlCZk9oNWZQZEZ6UVdOTFM4cVF5?=
 =?utf-8?B?TjFGdjJrUWwxVFhaYWFIU3hmM2I0UFdRVHp4YVc5RUk0R1hlczdJem5jVXZE?=
 =?utf-8?B?TU9HZmRoSjZIbVpFcEZqeGYzSXVDUmNmNFhnWGF0NW43NVpHUG5yZXoxUEFQ?=
 =?utf-8?B?VWVlRE4vcjlkTTJwWkZENTIrRFV1cmYrVWgyWGtqTTZxV20vMUZ2OC9hSDlS?=
 =?utf-8?B?ci9Ia2VsSnREMm42Q3prRzFWRmVJSjZRWnZOZGpCM1poTVl3RTVwVloyZDJy?=
 =?utf-8?B?eCtScUIwbFYwTE4vN1FoZkVFclhaYjBaUVRHaDExV2JwWkowS0p1SllpYmRs?=
 =?utf-8?B?QlZZcHY3Ny9jOWVjM0IrYnlKc2VBcWpUQkdoZ1g2dXdUcURrQ2srNktsa2tz?=
 =?utf-8?B?dHlIak15V3UydytYemtkMzQrM1BreFBNNVBxeVZ5SFdONGZTNXNNYWZZL2s5?=
 =?utf-8?B?U21vV2Q0U3lnTXNEenBBQnBDUDJTb2FoZWl1NW0rK2lhRElkeTlyU0tTS3ZM?=
 =?utf-8?B?d1NPTjgreEJNckYrZ1REQ2tIZ0tLVi9TMG91WHdVQ0JoSnZlSytTNHVVQ0dL?=
 =?utf-8?B?UlhkRHNwd0p2aVJDMU9SNkVweWRpeTVtWTNQdHRxL1NHYkNpSDl1UUdmNzg5?=
 =?utf-8?B?Y2VyT3hob3B3NFVPSEd1dXBYbzBZTThWMjJMQUdrVVhqMUhKYm8waTgwYmpG?=
 =?utf-8?B?cFh4WG1UdzYzZVpLZmZLTnVPVkJ4TzdHeWUxcEd2bWE2M25NakwwUzkrSGFY?=
 =?utf-8?B?YjNHOUpjQ0ZsakU1ajUvQkZOK0hMVk40eGVLWlVLZ0R2UFp0NXJJSzlUUVF0?=
 =?utf-8?B?d1BFSG5XclIwZi83Rklidm0zeXBPTUJqdVY5alRjUGg5OGNXSHB6eTErVUdh?=
 =?utf-8?B?YnBmS2tyWFlKcjhkQm9vNXU2YVNOUEZlRUlzMUM4aFB4OWZGME9Fa3A5VlE0?=
 =?utf-8?B?a3lSanE5cTBNd2c3eXdhNzJWUVV3V3JBWnlpejRGdlNyVEhZdU5yTzFNRmg0?=
 =?utf-8?B?WnphYTdxai82TnBjeEd1QVhZK1NxdS82cjVnUHFYZk0xUlByTDhockpmOVBJ?=
 =?utf-8?B?Rk5YTnd2RytPMk5OUUcxT3NCSDlCWXVXZFd5OXVCRTR6blpOYm52NjF3dTdU?=
 =?utf-8?Q?A/3BcA007dpAe3C5cJXJmp4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d2d049-0935-4a4b-4356-08de21e398b3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 12:04:13.7316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGLZ7GAOTCYiSNyasAy3OhwoWgK8o92QYRzorkXxrVYaSdlHrwLE89zEVHovIYvwLCkicFOi3Q1BD4ikztdB7eHL6G9y33M3KfTk8ySXWswrTjiaLIwtfIKKnE/jEZv1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7860

On 11/11/2025 5:20 PM, Peter Zijlstra wrote:
> On Tue, Nov 11, 2025 at 05:07:45PM +0800, Adam Li wrote:
>>> @@ -12843,6 +12858,22 @@ static int sched_balance_newidle(struct
>>>  			break;
>>>  
>>>  		if (sd->flags & SD_BALANCE_NEWIDLE) {
>>> +			unsigned int weight = 1;
>>> +
>>> +			if (sched_feat(NI_RANDOM)) {
>>> +				/*
>>> +				 * Throw a 1k sided dice; and only run
>>> +				 * newidle_balance according to the success
>>> +				 * rate.
>>> +				 */
>>> +				u32 d1k = sched_rng() % 1024;
>>> +				weight = 1 + sd->newidle_ratio;
>>> +				if (d1k > weight) {
>>> +					update_newidle_stats(sd, 0);
>>> +					continue;
>>> +				}
>>> +				weight = (1024 + weight/2) / weight;
>>> +			}
>>>  
>> e.g: Why 'weight = (1024 + weight/2) / weight'
> 
> Not sure what you're asking, so two answers:
> 
> That's a rounding divide. We have a helper for that, but I never can
> remember what its called.
> 
> The transformation as a whole here is from a ratio to a weight, suppose
> our ratio is 256, this means that we do 1-in-4 or 25% of the balance
> calls. However this also means that each success needs to be weighted as
> 4 (=1024/256), otherwise we under-account the successes and not even a
> 100% success rate can lift you out the hole.
> 
> Now, I made it a rounding divide to make it a little easier to climb out
> of said hole (I even considered ceiling divide).
> 
> 
Thanks for clarification.

If I understand correctly, (sd->newidle_ratio / 1024) is close to
(sd->newidle_success / sd->newidle_call). 'sd->newidle_ratio' means
success rate of newidle balance.

Shall we update newidle stats only from sched_balance_newidle()
as bellow patch? So that sched_balance_domains() will not update sd->newidle_call.

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12171,7 +12171,8 @@ update_newidle_cost(struct sched_domain *sd, u64 cost, unsigned int success)
        unsigned long next_decay = sd->last_decay_max_lb_cost + HZ;
        unsigned long now = jiffies;

-       update_newidle_stats(sd, success);
+       if (cost)
+               update_newidle_stats(sd, success);

        if (cost > sd->max_newidle_lb_cost) {
                /*
 
I tested this change, Specjbb performance is similar with your patch.

Thanks,
-adam




