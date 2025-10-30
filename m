Return-Path: <linux-kernel+bounces-878613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB646C21195
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0FD04E5622
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC9B3655C9;
	Thu, 30 Oct 2025 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BwuGXUno"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021121.outbound.protection.outlook.com [40.107.192.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A432286889
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840447; cv=fail; b=AGbNHwInlrB2lvWqNR0Lux/rjDIW5pWGc7eX1//0Nd0S2n1LPUVZrmFMHdgT1YPl90nts2tW+K8+MvKR7m/t1aH5NnAnzdj/+yxSD9OX25Oz78clAdZ8avMIbpdRwR6W+eUL239MDziiwYHRnBS2h3IeRyT3kpQX3N4uPKeM6n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840447; c=relaxed/simple;
	bh=MTbHHgBp9JdGE/ND63LCzZfzjPi4TihVmNBdmPDDxuw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZlBxhz0tByJzbww/kx5PrppmzbwCcfm82owfMHlyhpFSTuQaouFO7y8zgBvaXvfEK9CIb9oy1y9rpe3YeFbgrMb8AGrMrsdqOA7aTEOXT/VG57IIE+2+M5Nnu/lg6CDkRU0cN4V1/EoLhxN0eHzRrELn+8XxljFDiChhorv+kSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BwuGXUno; arc=fail smtp.client-ip=40.107.192.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2SLWUhSalxzfQr/VZo/G4yCtzktc5u52dPiVy58bzCWso8vHIs2S0dIp1/plWRQn3Kn0Hzb/nul9tH4JtOWuKSvNRNG4VIVMPDb0I6VyfbhHHJvj5y29FLIoQSRWI9hQ3Dhu//iYM72G67Vo9XsbprXvFdEdnfF7fvx06kL/2ypRc2uNbaGUcdWfldnxperp5tz16f3Y4Rg0kPmI2iOgQ8XfXK0hmrB+7N6LUxugRpTYiGiFy4hNUYdFwZFJmN2GxHriiWQ9woErzaja2vnM9CjHdmA2faa7KnBdwwHKxK0O/Lt3Z/hceNBWXX8wUjERhnbyTRAXzSSoPj/ovWj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRwWFvliI6nGD3uH73EeGKD2wqrME0OXazWsfyyZ1GI=;
 b=Lfvs82WezBxdEN4BYspgMamSq/IWmon1x9kyxxhUe4k+XBh2ndl2L6I4wskQryJFD1Gw1ubxZhUfJe6sOWY5+BceAYdL2Rio6qIxKDTwz84uf5LAeM2lyJTpF594eNmfYq85FZjX5Zo7Yphhn7HaPqfEz1sE6004fy1LmsHPwGMirPSDb44eod/1T5Rrq8L4Uwmt751jNhtajUGFE+iiERBOmlKcA6TEV5ipdNwHF3YLmGswm7+tzBQY8kIGrclpbNhRJ6/FV30rXsM9cf7HjD7IdpM8S7s9YMrsG0qx5GrEZ64fpfrRTjHENr5RcnZpWfZ+H887O3EcV1YKrsbpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRwWFvliI6nGD3uH73EeGKD2wqrME0OXazWsfyyZ1GI=;
 b=BwuGXUnowxthcvsqeF61far4+xAAG7mdpDiYz9Io/vB4aqFPeRrve7+ewy81IhFP09Alh5VuDB2v7SX+pyE/qI+Yo+SAof8U7yAPa0cGToRDc3Bh/NpZPU4t09IXFJTDtqtCnE91FHTXSrf6z1OaWX/EozS5KEIT4/vg64BuP4XJkTS0cfUKMCioaTp4Bv7YigAaMYa2UhrN8wAGmEkeQ1qrCNIruUeCew7bVvIvUtBPnCVk10FXRPVV05YJQG69JuDXyr3dxWpcx4TB+dQ2AC6rXG6DFkLzFvzkRZn1FMFR/oPAZAPQsWCwN0N/XGVlmllnlqa4ATSE4Pp1BI+42w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9506.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:78::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 16:07:24 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 16:07:24 +0000
Message-ID: <72cc0b5f-b1e6-43d4-aaac-ef3ff2e20a01@efficios.com>
Date: Thu, 30 Oct 2025 12:07:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 20/20] sched/mmcid: Switch over to the new mechanism
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.529828589@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124516.529828589@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: 274c3852-b28d-4f40-b856-08de17ce69c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXhyRjNheGdweFNpbldFTEJGVmljMGtZQXlsYUVqdS9Xd2dNYVltaytZcW54?=
 =?utf-8?B?czROZDFPc2pOZ3BrL0hGVFpFMXNvUHh4aklITkFkUFEyZGRFTmdNNjNjVldI?=
 =?utf-8?B?WGJ2ZXY3TlRwbnRxdHRyNGVLMHdaZk8yYnFGOUFQdWdKVE1DbVV4TVJTTXcy?=
 =?utf-8?B?bVR0a0RFQlRUYlpGSVpvdmdRaHBYZzdKa29vU21zelFFR05kVEpCZ3h2YURE?=
 =?utf-8?B?SGdEODN5aGVrTDd1eGlXVkhWYWNmOW9Gd3VMelg5NDlHYjVMYkpwMXg2bFpu?=
 =?utf-8?B?RzBrOGRUL0dTVVhpYlphbU8vV0hXTXZScTljMk1KU1FickVUdWxYRXJDUHdW?=
 =?utf-8?B?ZTF3dGQwY0tZRFpsdVd2cUpObmdjQ0FVN1ltLzc1Z0w2QnpSUWpEZWQwQ0JS?=
 =?utf-8?B?WGRPNU5VUHBrM1VyR0lKUk00dTRXQ282Z1dnNHNpMk0zeHZ6Snp2NXZMUTlT?=
 =?utf-8?B?alN5dnNuc1dlNzNMTmV2NjhUbEZSdzI4bEtrZTlhNHVqbEZQVXhGSHMwTlR1?=
 =?utf-8?B?L2tEeGg1QmYvTUplaE0xZDdKcGpiNEhwa1ZUU0dOdklUQ0FYNnd3UjkyWThS?=
 =?utf-8?B?eHBZdDQ4bXJKbkpxdGRhMUNidnZIanVKdmJBendGRXNIbUU1blhHOG1sblFl?=
 =?utf-8?B?clZ3bktNaGhNN1dSUnB1SmJqYnd1eDRvRmdBaTlqMTFucy9CNVIzdis5RWkv?=
 =?utf-8?B?dDF3M3UyMVR4ckNwamhPM2xDN0IyTkFFMUFWWkdkRnM1WW5aZDZxWDEwOVdh?=
 =?utf-8?B?TnRZV1dITmpPcUg3ME0yRTA2Zk5DZ0VpekRjOW5pVE5PbDIvRUtSQWlMbU1k?=
 =?utf-8?B?dFpobGFFZW5IcE1OQmh4ZlZ6SXU2M1ZobVRaUGRxSWVpRStvNTQwRmlibEYx?=
 =?utf-8?B?U1pUT0RCWGErdVgyaSt5eFhBWG1wQ2h4Z1NNR3pUQUlxU01ick5DNHZjZkRt?=
 =?utf-8?B?WFdQQ3d2WEk5d1lIcm1lTGhTeDB4MGxzL1gzSkptVDlxV2ZQdUFreWl5QVda?=
 =?utf-8?B?RFljbjd5R3YyWFVXZDcvUkFIWWFwVkNMWDdSMGE5QTVyLzl5YTd1ZlM3ZWRC?=
 =?utf-8?B?Ui9QOHdlL08zNVdyODZSR0xTSHNuQ0t4dGx4Tnd5VmprZHBWeUZJd0hDNDFk?=
 =?utf-8?B?MjR2RGgvZU9JWkpnclA2VU1ZQ2FsekRPOWZKYXNoSDdNOG13WGhmU0FqYytU?=
 =?utf-8?B?MTNFZVZGbVFrSWxNUVdtTmdGMVVWUTJPWlBMa0VKN0F2eVdwQUVJaTRCSGgy?=
 =?utf-8?B?SE1mMjUrZVI1Mkk4UENlajZPMnNVZ0JnMXpXeDNubE9PRjZYOWVMSDQrZWRG?=
 =?utf-8?B?c01MUzNrS1ZSVVZ3RGlNUjVzM2ZzaEdLSmYzMTVOQ3ZtZEFXNjNFWGwycDkr?=
 =?utf-8?B?Q0NMRFZvcVRxeUUvRVQ4ekVSdTdPdU5teGU0bzlrem05QjZVNU5FeGlQNGg0?=
 =?utf-8?B?M0E1TjFqUWRHWURYK3FvNzhsOUh4T0JURkZwTzZ2T1I0a1l6Znh6VnFmeVpK?=
 =?utf-8?B?eUdQN2ZZNjNVQlVWdHJxRlM2T0VHNjBSN09xMzJvZXhlcWFZeEZRTnJFWXZV?=
 =?utf-8?B?NHVjckRESDBkOUdtQUIvbTVHSXpCVkw0eGpYN0FjV1VDckt0ZENZOEpjYi9n?=
 =?utf-8?B?cUR3WTNOMnAzNjIwc1NTeXUyQzRRZEcrL044RmRPVmNUb1VDSWdadmlQM05n?=
 =?utf-8?B?cUgzUmpua0RHVUpLTEx6UHg5dm5YYmlUMjhpdWwvZEVWbUdpS2I5YWg2Z1hJ?=
 =?utf-8?B?SisxWEtpV1ZkbW5LMko1bzE1ek8ybGlwejlDa3o5ZkcwdG5yalNkcXBiK1pJ?=
 =?utf-8?B?VVV5V2tndi9uWFd1dWl3am5IQTNsUG5uVXNyRWNQTXowZGEvMWdnZ2k5N21M?=
 =?utf-8?B?K0FqQk51Y1h1UnFKcWcwTVRWVk5aNVBsMkc5K0E5WFU0L0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm1uUTMwYjYvMkdWa0RQZklQdys3dC9QMTl4R3I5Y1RmNXVUNG5qaXZiY2Nk?=
 =?utf-8?B?SzJTTHdYc3lGaGtZQXBHZVBaT0FtTGZBMEsyWXVhSXlXWis0SW1qZVYraUtT?=
 =?utf-8?B?NjlNa1d2QzU2aUROYS8za0Fqd05id212TG5SMTM3YXFNaWRPWUN3RjFieWdB?=
 =?utf-8?B?a2hLMWJYSGJxR0NPQTdVTEhESmg2Ri9GUmYvSUVzejBXaWhBZndJNUx6OFFh?=
 =?utf-8?B?eWc5ajUyU2FubzRzQjdYK1NuMFo0OVVGL3JLeEM0Wk1XdS9rYkJrcUx5akI2?=
 =?utf-8?B?R2JIV3BqSzd2QUxOSENkY3h1VHdGcUpFMXNOa3JPNnVSc1RXcUovSXlsYThB?=
 =?utf-8?B?bUlNc00wcjBDVFRodFkrZit6RzFybHJtcHFCakNtUk94ck1McE5tZExvdTdC?=
 =?utf-8?B?UUdLb2JBa3lOZlpicmxVVVdoTGVFMFlHYlE2NmZsb1dkandYaTBUWWdHTlFa?=
 =?utf-8?B?OGNSYkU0RXpLcTl3b3gwV2xUejBQWndNRWJqbnJPZWtyQVBRd2NzWUZxMjZ3?=
 =?utf-8?B?bFZOQ01kKzhyV1F3aUNMVEdUZ3p1WWp5b0QyOVV1U2JVT0R1czRnUzJkQkJJ?=
 =?utf-8?B?OWFuMWhBOGlLcUtpOEVoOTUxWkRxWWJrNkQ0YXg0bnh5MDZOSDR1aGU2dHB0?=
 =?utf-8?B?Z1JvKzJ3QjhvRnhnaDltUWpMQkpxejZkL1hoYmFGdVJxTWYxR0tpOGVXd0hm?=
 =?utf-8?B?VXRMaGYxaEFyQ3JoZytidElndm11ZExSTGE2WWovN3BUcEgzQzh3U3phTkxX?=
 =?utf-8?B?L1o2WHdkMVY3bk9hVGpEbXZJVjBIRVl3Rm1jclhLaTVCTWlvNno0R0ZRS3dk?=
 =?utf-8?B?c1l3T0FPVTJtTko5enJwS2VtY2ErVkNLdGFpemV3eDYvcjJnS0x1VmJsSUM4?=
 =?utf-8?B?elZtQ29ZRzFnMzV6R3J1cGxlSkRkTHNUR0VkYjNwaXROSDg0UGtGTWJLYWhJ?=
 =?utf-8?B?dEJTWVJ6TWdNWDhLcDdDMUZ2VnR5Ty9GbDZjTWpwZkxkS0pFQnRpcXQ4L21P?=
 =?utf-8?B?bENGLyt5Mml5WWhvMEppcW93N0ZmRFRvaWZ4REl5WTBXK3lqcUxma2dGWmF5?=
 =?utf-8?B?ZlBpRTdWRGxxcysyM1hOUWIwbXFsK1FUbXhTUWpkUXdqMVBPSDV5YkhUYURW?=
 =?utf-8?B?KzlkYUZJdWtFTjlvdHNpdG1FUnh4SUxXY0Rtc1ArOGJsdDhlcGhSZml4SHBn?=
 =?utf-8?B?eHUvb3h2SmxWeUcwSU5yWjMxY0FWODJoUmk3NmtBTUJaQ2JHMi9KRExrb2hW?=
 =?utf-8?B?MXppclVKck9WRmp5dmNtSjlrZkdsU2hsdHNwM0hyREVST2l2Y3V5UlJsK2Fv?=
 =?utf-8?B?elNnbjNod29XQVpaOStPY1pBMUhrR1ZTdGZEN3NuVEx4aE5CYXlwSmlZZHpP?=
 =?utf-8?B?M2ZOS3ZIMnNpTlRTenFhRDJjd3dvN3owTkdlUi9FRkNZZXloMWsrbGFJdE81?=
 =?utf-8?B?bkRGamZzc1JKSlpRK1Z3Ym1qYnlZdFdxdUlhT200aDIvM1Z5ajJZUlhPZVBv?=
 =?utf-8?B?YXg3eVBRQjJZbUlqaWhBUXp5MFkrU0tNYmk5SE5na3JNTDhBVXg0SlZqMkJq?=
 =?utf-8?B?Zm9PNW4yc3kzWUVpV1hRa1B0WXMwY0FoVXozMnRmUmRCNlZTZVlyUzN4SE5Q?=
 =?utf-8?B?cWNxVVh4SVRJVWhQV0xDekVwbDVMSzR1Q2o1U3hrYmhzdzI4MW00OWVYS2Nx?=
 =?utf-8?B?Q21DMHV1d2JKWGpmZlJYWkM5TEJ2RHE1SHZFZFVEY0ZpSm44WEoveExaRjND?=
 =?utf-8?B?OFBMYkVXQ0Y0bnlvZW9qalpOZmxFZUoxRXBzb1N3RWFtQ2lSNmd2a0dxMXpx?=
 =?utf-8?B?UVIvanFhZXlpeHcwSkVzZEsyU3ptM1VNOXdDdS9LalFRQjJGQTdQZW9kNnUz?=
 =?utf-8?B?TXVKWVEwSTU1TU43ZWRaamNTTHhnZ1lySkpFUmUrZVFQcndkWmh0ZXpwd3RR?=
 =?utf-8?B?dWhZL3hiNm9ydUdGM1o5UldrNkFqN1N0TEoxQkFvL2JxZ2FFU1h1ejFYL1hO?=
 =?utf-8?B?ZVptWTAyWW43M2gxWWNINm1POGtqeXVISDYvZXRvR0lsT08xdXpaV0lXb2Np?=
 =?utf-8?B?STRGeTEvNXlZQ3Z5K2Y2cjJYSnN4eC9CTkR3SHFIS3ZCSXI0R3pwUDVGeE5u?=
 =?utf-8?B?MWNHQm43RVN4Q1JMbWx0U0ExWUFIc01aN0JuS2NjUzlEd2tSWnl1aDlrbXdV?=
 =?utf-8?Q?XPYifFLi1fsVGA3+B6teBmg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274c3852-b28d-4f40-b856-08de17ce69c1
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 16:07:23.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kp1Zrs7fYFos9TYeMP3Fh2PRI/96jJjNFhiJXs5df3K8d0kruk3BgCbKUN4gNByvUEVr3z13K0yh4fgT5s1TXQ972l+SkngvQwYbg0m8dA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9506

On 2025-10-29 09:09, Thomas Gleixner wrote:

> @@ -10702,10 +10758,43 @@ void sched_mm_cid_exit(struct task_struc
>   
>   	if (!mm || !t->mm_cid.active)
>   		return;
> +	/*
> +	 * Ensure that only one instance is doing MM CID operations within
> +	 * a MM. The common case is uncontended. The rare fixup case adds
> +	 * some overhead.
> +	 */
> +	scoped_guard(mutex, &mm->mm_cid.mutex) {

When exiting from a mm where mm->mm_cid.users == 1 (read with
READ_ONCE()), can we do this without holding the mutex as an
optimization ?

> +	 * Synchronize eventally pending work to ensure that there are no

eventually

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

