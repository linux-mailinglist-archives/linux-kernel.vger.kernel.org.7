Return-Path: <linux-kernel+bounces-759642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDB8B1E09C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDCD18C320D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 02:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824D518FDBD;
	Fri,  8 Aug 2025 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZskC0bNV"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C12C181;
	Fri,  8 Aug 2025 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619624; cv=fail; b=Zd9WOeiKEdbdtIgXxCH5unay8RZVlr+AIH1PErO/X4WPvur+tGCD+ymdltoZBLcaxugkF39HvQEMzq988LYCOKJ25OWQ+Sw/Y2XM0V84zB0y5eVbdqnqQwUAuaKtF+l+0tZ/EQb03OntEPWxSM0vvB2/WUKMTrNnGQPGo7GGako=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619624; c=relaxed/simple;
	bh=93yjr1+wlE3HBkwev3JFvf5XvihnQ8exv+wphvGUjgg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F0bDH2f4nkBsWCvTmrdb2KZn3M3pzGJXxzhLPthZOyh8EbvNHbydz7SFOuoHCJiFoS5gY1IyUjr5Hgk25G8KWSQHd9RHQKmYIXtLvnACY9K1LZotyqr+oe1ZkNfjMIbcYBOZkRVQ1mYRSaFwMvMJtAE19ZhH/B0uBKYXxXcZcA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZskC0bNV; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on+HnyS9Unt3FSB+Dgc6Cyu1FZhBKpd7GtehCZdzEoamk1GRK+kJl6v3W2SJPVEjB3wW4uAdqcpXJ+aW5PEMm6F/vjnGFIX9I9aQFhdHpVgZhuehGm8iRfLCxkPyFsjA5QGhtAMGFm1sja1XUjEG1XGeKhzagDlExYuFI0balRZMdL4QBFY6JjXcVHJWy0b3g5GWZhbETegrMZxE3dCgC4gDLw9M+TSasNqzDJcQ+dkxKplqMZSoSXc2jHRQ6PO6VB3LNKYBR6Uef7dbvtmcu0+gC3eBFqNXEU1pvE5L0N98u27/Qd+LJtTub+f5As2WtwrzZTnzRXdbFM0pfvRUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvhP/t7JWyQ70kWNtjcAFDRLu47XhuCTDCA0ojwmcdE=;
 b=S6/bN2fNDcjsR8Od7kuPAqvKvIc2OIauh88GHvqMCrGcWlsbrWIZtg7EvlKE3mRmRJmsrqLqU55T0L22Y3CZkd9p8A8xcRT8101hc8fDb8dgXEXrj20nzCBZrach5c1vheP0dTTEpXIZYfe6didqivPlF1/Z0XXahMoaBGvSi+2ewGlJ6ocuIvtXPAiO+KvnGg+4yuH8pwWXl6H63ByyugTdQ7b5H4Do8l/9uPEvanLQvGvf+7OVquxV9VX/uVmw+fEGH99ZXNhqVFYvqNdIigSK6b5qpCrF76hPPoEgYn7neR9OEqQ8wiCN446LmJRD4il6VVlVmT9TCD/EO2yAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvhP/t7JWyQ70kWNtjcAFDRLu47XhuCTDCA0ojwmcdE=;
 b=ZskC0bNVL/mtp0HF3o3vafL/QH95nnACxE820vvkIrADPDcHjAboWcF4roEDI5LdyLm4xv092OPFvzuDaeh4Ryn4y2DeQqtR2VmjOC5xMUIioxHcAeJhA566aXt4VYmIjd5Ao+p0YB9J/+PayGjeLbdKt0AXGUDRgLgFag+TP4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 8 Aug
 2025 02:20:19 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Fri, 8 Aug 2025
 02:20:19 +0000
Message-ID: <62c5e15f-8dc6-4ceb-8bd1-f1389ed8dffa@amd.com>
Date: Thu, 7 Aug 2025 21:20:15 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 23/34] fs/resctrl: Support counter read/reset with
 mbm_event assignment mode
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1753467772.git.babu.moger@amd.com>
 <dea9cd70b311b6a7e1eb85b1e6087c701bcb488e.1753467772.git.babu.moger@amd.com>
 <26db5cff-dc25-417e-bac2-e05584e8f987@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <26db5cff-dc25-417e-bac2-e05584e8f987@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:805:ca::30) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: e3249575-3376-4d20-1e77-08ddd6221f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aCtiTG0wekpPMzZEeTRFTjVVWHp1TXhlOTdWYTJ0NkVrNEtWNXVqUW8rNitt?=
 =?utf-8?B?dU5XMk1xVkVkSDYxVThZT2FDbCs5RGpuSGFtZzV1WHNJVVR2Ky94bk9XNXYw?=
 =?utf-8?B?SGd0K1RkRHRZOHZtS01MRkRIVEI4MjJLYm5jbFd0M3JaS3dRalU5aU5MNTNh?=
 =?utf-8?B?eCtWMlRnRGdhcDkrMFBzZm9zTjlNeWh5cEVRVjl5VWp3YjlmdjBTMzR4Vm5q?=
 =?utf-8?B?end2N1RnSzFKSjNCdWd3UVdSdnBLQmxwTUpsQ0tZb1RTRUI1c00zMmNoRGFs?=
 =?utf-8?B?Y0ZUc01IWG5iR21VaVRkL3Z3NkpERHVaNnppZUJuK3ZiM25ZMTZscUFsY2Fs?=
 =?utf-8?B?L1YySSs1N3ZiTmFlVVE2TkxQL1ZJRDFwWmFmRjZUN1hxdVRsQ2ZWZnVWRlZF?=
 =?utf-8?B?VWV3NmtvWGFodlBsWDI1R3hWZzZENUtQSVdVMHpjbzhIdTFNcEZCYWFjMEtz?=
 =?utf-8?B?SUFGRmJOQ2ZGZnJYc0RXdmlEb3RWS1hEOENxNnJkYTlBYkpzc2RCVE1JMWdu?=
 =?utf-8?B?V01PbVpVUzNQbFVaeUo2bzB2LzJTSHFYU1ZkT21vQ0RXSjdTdnpzMUxDTWlP?=
 =?utf-8?B?UFhIK09iVVpZQzZoR0Fndms3L05wMW1hcUFXd3Y1WXJuRjdURmhKRHBWRmkv?=
 =?utf-8?B?RWozTlBOb1czeEpkOE9EaXJSbkRqT1ArUEUzQjArSEJxMjM3cmd3SnQwY2h2?=
 =?utf-8?B?WXRJb0pjelJDcUdVQTFmWktYRWpQVXlRT0VaL0VsSEVGQlRHSTJ6aWk4U1FK?=
 =?utf-8?B?SXY3QjNxQVVrdVRjbCswZ255cFN1RXIxNFVTZjQ5c2IvYTBOU3RXVC90bkpW?=
 =?utf-8?B?K29tL3A5cjhwcDZmMk9rM1I5OGpTVnh3emNGT2E3UGF2S0puYm9RYUtiNFZs?=
 =?utf-8?B?RkVqc2xTeER6SWtKaVNFSlRCVEdkSVhiYXBGbzBwTnlKOExLTUZkS04vNlVM?=
 =?utf-8?B?TjNGYVdMb0VaUlJnVmNSSURlaERHUGd5WHlUTWRpRWJxMVpuRS9tNWZnalg1?=
 =?utf-8?B?enU2TVk1R0R6OG03dTZHY1krZnNoUi9pVnZiTVkvdFJuNGl2ckx1YitSMUJr?=
 =?utf-8?B?dkVLWlYwK2I4eFJXcnlvN3Fqb2l0cE1nZDVUakxFSG9aaVFHODZZNEVYb0po?=
 =?utf-8?B?UG9lYkJzK3JjSmF2TWRaQmE3YzNtUHVzdTZIY05ldmJLQTFrbC9NM1IvR1lC?=
 =?utf-8?B?cXh2SDJyeFlLYmUzK1JTb0NpYzVSZlhtb1NuVlNIK1c4dUZZSVJ5TkZmSjNM?=
 =?utf-8?B?M0JCVG43cm5DN01sa2l0ZFpscjR6T3NJM2dZaDVETGwxSFFRTzFTbTN5NGVr?=
 =?utf-8?B?Tko5RHRBbFY3RmMzQlJTT3hpRGViRWlzZnV4dWRPZXRRaXozalljUXB4TklE?=
 =?utf-8?B?N1d0TG1uNnBnWlZtaEtSZ1ppSWRlWjUvckhpeWl3OVMycFlHd3J1N3NDTDc5?=
 =?utf-8?B?b1RoSUY0RkRRN3VqNEhscnltVFIwNDdQTXRHd0FrV2RwRGhYMTNCNzhtWlFt?=
 =?utf-8?B?cnpoZUJQMmV6WU8rUUJ3Y2hyRTIzeXFvc2FIQlJNamtlSndBS1BHWnRsSGt0?=
 =?utf-8?B?YWxiVHpPemdITHIzNWthbEtReHI5TTRMMmdoeG4rTkRBK3ZiQ0R3VmhhNHFw?=
 =?utf-8?B?MnVmTU0wbEo0ZC9KM0lWd1pBeUdiWkZJVkNSSC9LMThGRHVaMEJlQVFPTnEr?=
 =?utf-8?B?eEMxZVQzaEo5Nkw4eEpwN3JCNzY2TjhST090VXlXTE0xOFNZc0laQitSTVNO?=
 =?utf-8?B?bGJVV3F6TzVRRHhYUXJ3Vk9NSjNHOTF1VG5YWWpzaUFjeDZ6ODd5bTVKbGlI?=
 =?utf-8?B?K0pqWjlQcFh6cER0UWwyOHlVT3NyQU94V0NyRmJuU1Q2SHZrdWFBakV1T0hl?=
 =?utf-8?B?bE1BNnlVVXJKWWEyRWJ6U25hR0FPYnVjYXRGVElQT2REa3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkRzMTBSdFZzZy93VXpITFIyZVdqZ3RZN0twakR1SERNV0pEZ1AybkVmeWRP?=
 =?utf-8?B?S3ZOWkZmSG03WDJRaHBXalJ6MFF2Q0xHTU1kTzk5amhQbzZXRXBqaVl2TlE5?=
 =?utf-8?B?VUZMdTNWWWlWNUVZMGJCenp6cDhxQlpPRXR0cjdLQ1JUQWpmRlZNZnRROU1m?=
 =?utf-8?B?c0RtRXBySlh5NWVKWjh6dlhuM3JQUzFaVExUSkNXOFhwU2lQWURONm1rZmg2?=
 =?utf-8?B?Ym5tTFBYSG45ZzJ6QlRyMGduNWxKNit5RHNZVmFIZ3hpRXJEQWVFUU1DajJv?=
 =?utf-8?B?c0Jtelo2NUhGbHUxUUpicmg5Vkg5Zi82eFUxNHd5S0xSQXBLTlJwd3NrcE8w?=
 =?utf-8?B?OEFJTCt2cm5Ja1B2L2phTnVYQWdXQ3pwQ3ByZ0s0VEs3dFg5YmdWMTFPdE1n?=
 =?utf-8?B?Umh1UmFtZi9FTGhRRGNDYkEzM2oxa0NnVjd3N0d3S3BQYy9PcG9NbWdPVmw4?=
 =?utf-8?B?TjFPenNtQmkxSEJsS001S0I4OFczWmhmRGpVc1lTSEhWSTQ5TmJ2aENyc2tS?=
 =?utf-8?B?ZW1qZHBaem04NnkybmVUZlNkd1NyVTJUN0hZOUhBaS9DZDJab011TFZvMGU5?=
 =?utf-8?B?WEhNSloycmtiVkJ2U0ZRRUZiMjZwWm5WREIwanUvREFrM2FKZmMyb2ZyakZ0?=
 =?utf-8?B?MEpXbHRGUWxwM01mYnVrZWQwaGswVkVONkxIdmZ3bWxxcFRlY0dobGRObUFn?=
 =?utf-8?B?RnVKdWFVQkFjLzdWcXdyamhvUnYyMDFSdk1Ha0diazQ3WlY0bkZ3R2lWTzBC?=
 =?utf-8?B?QldWUktWd1JGdEFldkhmVUt6ckh4cGxIN3d6c0F4TmtCYjdaaHdGNHB0MjE3?=
 =?utf-8?B?K1RpT3NDSy9vMTd1Z0dGTGVrbk8zc0FMLy9UQnQrM3Q5TEdQUmhsY0Z0azRz?=
 =?utf-8?B?VVpkN0tJTTg3SVByZnhaUHk2Ly9HUVRNejJya0RrWXhndWxvT1hGUHFkZDlz?=
 =?utf-8?B?aDhnb09mQjlVZEtlaTh6WnVkOU5QaVpqMjRXdXRKdHV5S3MwVlE1aHZKWXhS?=
 =?utf-8?B?bExDaWpFUDlxaTVjNExKOFQvSGpWSUtsK3UvNVU3QlZEaVRua2RPOGRPaitY?=
 =?utf-8?B?SEYrUHJXVHREOEJ2VEk4bkFzbEYxRmxxcXRsZERveTNJUTJ2cG8zaG52QXpR?=
 =?utf-8?B?eHlzSWwwaXc1dFpBcjBScUJWSEpnVUdPWHR2MXFCQVlKdnRoMVNUMXpVb1hN?=
 =?utf-8?B?bG9mNWY3ZW1FY3Npbnl0WmJQSERSa25FOHR3eDh0b1FvcjViSVdDRnBXczQ1?=
 =?utf-8?B?MGxHOEFlenZzbFlSc29mTDB0WjR6N0N5KzZsUG5kU0RHbDBEcW5IaHlPODEw?=
 =?utf-8?B?THR1Q1hwTzdHZWxYT2dJNU9odFVtakFYdFNCa0ZaU3JTSTFFWnNkUlh0VGY4?=
 =?utf-8?B?YjBNeFEwUmRkRHZvcjhtYXRDZmFMZDk2NDVqZWdiSlpnN3VLVHlxdG52aDFK?=
 =?utf-8?B?MDFNRmxmQmJYWTRpdnc3ekRWUmd2WU1YOTJMb3ArVVdWZG8vZmJDU2dEcVU5?=
 =?utf-8?B?dUcrdEZkYnpNdGJIOHh4YnU3Y2UyNmNwY0hRd25taHBJeGRsRWpNRTNmcXFI?=
 =?utf-8?B?QVh6SzU2Vk4rdkRseGZtMkRvR0syYmMvU0RqNC9DM0tGQXlGVmIrZHByR3lM?=
 =?utf-8?B?YnJWczM0b1BFUlZEZFVRaDhhQ001RjhObzh0NzU1YURzYjM3U1ovSXV3VUxL?=
 =?utf-8?B?eGw2S1hwVjE5ZmtRMW9UdXBYOGxLMDdiZFZhcnV3aUIwUXdrcWJJRmJSclVK?=
 =?utf-8?B?MjM0RHZmOGE2RVZRcXFyazZLai9OMHBicEJWZlBqOStKbVZEU05Dbng5cTZ5?=
 =?utf-8?B?V243Wll2bXlnVUcrOWlXNjB6WUx1MjZUQWhTYVB2WTRCL28zTnRBaGUzbFVa?=
 =?utf-8?B?aGRnc1hpWUM4TU1ac1ZpeFlTV2tpdmpMYXBBbWcwVGpLWkZiVGZQbC9CODE2?=
 =?utf-8?B?SzFiR3pXWnlvQzhHWlZJTGVQczB0NVBNdG1FSVZyeGlkMWNwS2NDK1JRVlQw?=
 =?utf-8?B?d0pQYmd0VWF3aWJNcjVHVjZGOWI2Y21DVlZ1c3BIZVZTYThwTTFHZDhjdGxn?=
 =?utf-8?B?ajA4YmtHSVZLSGRKMmZsWmtuK2s4TlJRdWFSSDB2N1VIWnhITGVmS1JOUHpR?=
 =?utf-8?Q?lRH0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3249575-3376-4d20-1e77-08ddd6221f11
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 02:20:19.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnCmKaoANnwszXNHyWjI69SCcqJOldxppKmzJm+o/s8RLPI0yhB74uUSFCrZhGGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951

Hi Reinette,

On 7/30/25 15:03, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> When "mbm_event" counter assignment mode is enabled, the architecture
>> requires a counter ID to read the event data.
>>
>> Introduce an is_mbm_cntr field in struct rmid_read to indicate whether
>> counter assignment mode is in use.
>>
>> Update the logic to call resctrl_arch_cntr_read() and
>> resctrl_arch_reset_cntr() when the assignment mode is active. Report
>> 'Unassigned' in case the user attempts to read the event without assigning
>> a hardware counter.
>>
>> Declare mbm_cntr_get() in fs/resctrl/internal.h to make it accessible to
>> other functions within fs/resctrl.
> 
>>From what I can tell this is not needed by this patch. It is also a hint that
> there may be some monitoring specific code outside of monitor.c. Looks like this
> is done to support later patch #29 "fs/resctrl: Introduce mbm_L3_assignments to
> list assignments in a group" where mbm_L3_assignments_show() should rather
> be in monitor.c

Yes. Will move all these to monitor.c.

> 
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
> 
>> ---
>>  Documentation/filesystems/resctrl.rst |  6 ++++
>>  fs/resctrl/ctrlmondata.c              | 22 +++++++++---
>>  fs/resctrl/internal.h                 |  5 +++
>>  fs/resctrl/monitor.c                  | 52 ++++++++++++++++++++-------
>>  4 files changed, 67 insertions(+), 18 deletions(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 446736dbd97f..4c24c5f3f4c1 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -434,6 +434,12 @@ When monitoring is enabled all MON groups will also contain:
>>  	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>>  	where "YY" is the node number.
>>  
>> +	When the 'mbm_event' counter assignment mode is enabled, reading
>> +	an MBM event of a MON group returns 'Unassigned' if no hardware
>> +	counter is assigned to it. For CTRL_MON groups, 'Unassigned' is
>> +	returned if the MBM event does not have an assigned counter in the
>> +	CTRL_MON group nor in any of its associated MON groups.
>> +
>>  "mon_hw_id":
>>  	Available only with debug option. The identifier used by hardware
>>  	for the monitor group. On x86 this is the RMID.
>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
>> index ad7ffc6acf13..31787ce6ec91 100644
>> --- a/fs/resctrl/ctrlmondata.c
>> +++ b/fs/resctrl/ctrlmondata.c
>> @@ -563,10 +563,15 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>>  	rr->r = r;
>>  	rr->d = d;
>>  	rr->first = first;
>> -	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
>> -	if (IS_ERR(rr->arch_mon_ctx)) {
>> -		rr->err = -EINVAL;
>> -		return;
>> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) &&
>> +	    resctrl_is_mbm_event(evtid)) {
>> +		rr->is_mbm_cntr = true;
>> +	} else {
>> +		rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
>> +		if (IS_ERR(rr->arch_mon_ctx)) {
>> +			rr->err = -EINVAL;
>> +			return;
>> +		}
>>  	}
>>  
>>  	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
>> @@ -582,7 +587,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>>  	else
>>  		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
>>  
>> -	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
>> +	if (rr->arch_mon_ctx)
>> +		resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
>>  }
>>  
>>  int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>> @@ -653,10 +659,16 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>>  
>>  checkresult:
>>  
>> +	/*
>> +	 * -ENOENT is a special case, set only when "mbm_event" counter assignment
>> +	 * mode is enabled and no counter has been assigned.
>> +	 */
>>  	if (rr.err == -EIO)
>>  		seq_puts(m, "Error\n");
>>  	else if (rr.err == -EINVAL)
>>  		seq_puts(m, "Unavailable\n");
>> +	else if (rr.err == -ENOENT)
>> +		seq_puts(m, "Unassigned\n");
>>  	else
>>  		seq_printf(m, "%llu\n", rr.val);
>>  
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index 216588842444..eeee83a5067a 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -110,6 +110,8 @@ struct mon_data {
>>   *	   domains in @r sharing L3 @ci.id
>>   * @evtid: Which monitor event to read.
>>   * @first: Initialize MBM counter when true.
>> + * @is_mbm_cntr: Is the counter valid? true if "mbm_event" counter assignment mode is
>> + *	   enabled and it is an MBM event.
> 
> Since a counter may not be assigned to event being read I do not believe that "Is the counter
> valid?" is accurate and should rather be dropped. Rest of text looks accurate to me.  

Sure.

> 
>>   * @ci_id: Cacheinfo id for L3. Only set when @d is NULL. Used when summing domains.
>>   * @err:   Error encountered when reading counter.
>>   * @val:   Returned value of event counter. If @rgrp is a parent resource group,
>> @@ -124,6 +126,7 @@ struct rmid_read {
>>  	struct rdt_mon_domain	*d;
>>  	enum resctrl_event_id	evtid;
>>  	bool			first;
>> +	bool			is_mbm_cntr;
>>  	unsigned int		ci_id;
>>  	int			err;
>>  	u64			val;
>> @@ -391,6 +394,8 @@ int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp
>>  			       struct mon_evt *mevt);
>>  void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>>  				  struct mon_evt *mevt);
>> +int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
>>  
> 
> Not necessary? mbm_cntr_get() can remain internal to monitor.c

Yes. Not necessary.

> 
>>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 070965d45770..a8b53b0ad0b7 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -362,13 +362,25 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
>>  	u32 closid = rdtgrp->closid;
>>  	u32 rmid = rdtgrp->mon.rmid;
>>  	struct rdt_mon_domain *d;
>> +	int cntr_id = -ENOENT;
>>  	struct cacheinfo *ci;
>>  	struct mbm_state *m;
>>  	int err, ret;
>>  	u64 tval = 0;
>>  
>> +	if (rr->is_mbm_cntr) {
>> +		cntr_id = mbm_cntr_get(rr->r, rr->d, rdtgrp, rr->evtid);
>> +		if (cntr_id < 0) {
>> +			rr->err = -ENOENT;
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>>  	if (rr->first) {
>> -		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
>> +		if (rr->is_mbm_cntr)
>> +			resctrl_arch_reset_cntr(rr->r, rr->d, closid, rmid, cntr_id, rr->evtid);
>> +		else
>> +			resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
>>  		m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
>>  		if (m)
>>  			memset(m, 0, sizeof(struct mbm_state));
>> @@ -379,8 +391,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
>>  		/* Reading a single domain, must be on a CPU in that domain. */
>>  		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
>>  			return -EINVAL;
>> -		rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
>> -						 rr->evtid, &tval, rr->arch_mon_ctx);
>> +		if (rr->is_mbm_cntr)
>> +			rr->err = resctrl_arch_cntr_read(rr->r, rr->d, closid, rmid, cntr_id,
>> +							 rr->evtid, &tval);
>> +		else
>> +			rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
>> +							 rr->evtid, &tval, rr->arch_mon_ctx);
>>  		if (rr->err)
>>  			return rr->err;
>>  
>> @@ -405,8 +421,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
>>  	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
>>  		if (d->ci_id != rr->ci_id)
>>  			continue;
>> -		err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
>> -					     rr->evtid, &tval, rr->arch_mon_ctx);
>> +		if (rr->is_mbm_cntr)
>> +			err = resctrl_arch_cntr_read(rr->r, d, closid, rmid, cntr_id,
>> +						     rr->evtid, &tval);
>> +		else
>> +			err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
>> +						     rr->evtid, &tval, rr->arch_mon_ctx);
>>  		if (!err) {
>>  			rr->val += tval;
>>  			ret = 0;
>> @@ -613,11 +633,16 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
>>  	rr.r = r;
>>  	rr.d = d;
>>  	rr.evtid = evtid;
>> -	rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
>> -	if (IS_ERR(rr.arch_mon_ctx)) {
>> -		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
>> -				    PTR_ERR(rr.arch_mon_ctx));
>> -		return;
>> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) &&
>> +	    resctrl_arch_mbm_cntr_assign_enabled(r)) {
> 
> Duplicate check?

Yes.

> 
>> +		rr.is_mbm_cntr = true;
>> +	} else {
>> +		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
>> +		if (IS_ERR(rr.arch_mon_ctx)) {
>> +			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
>> +					    PTR_ERR(rr.arch_mon_ctx));
>> +			return;
>> +		}
>>  	}
>>  
>>  	__mon_event_count(rdtgrp, &rr);
>> @@ -629,7 +654,8 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
>>  	if (is_mba_sc(NULL))
>>  		mbm_bw_count(rdtgrp, &rr);
>>  
>> -	resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
>> +	if (rr.arch_mon_ctx)
>> +		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
>>  }
>>  
>>  static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
>> @@ -983,8 +1009,8 @@ static void rdtgroup_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *
>>   * Return:
>>   * Valid counter ID on success, or -ENOENT on failure.
>>   */
>> -static int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
>> -			struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
>> +int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
>>  {
>>  	int cntr_id;
>>  
> 
> Not necessary?
> 

Yes.

-- 
Thanks
Babu Moger


