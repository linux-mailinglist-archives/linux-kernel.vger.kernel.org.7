Return-Path: <linux-kernel+bounces-742815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC3CB0F703
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7B61C23AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7039279DD6;
	Wed, 23 Jul 2025 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t8DH93du"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125B2EBDC2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284548; cv=fail; b=LWPdATxHtfiu8bjoIntRrzBjYiq+lNk3UnmlHQWI4TbEWU3qwYtsfm3PhzYWI+V7aXh0+ct5bN5P/G5d/2vfyibxDPjNXOkc0tqMBstWT5e4PDB4dPhxKBoEv4Llo5eDW4oQ0NSNzjp3uy7PePs9Hwkao3EESjpz2JrMZu8+0K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284548; c=relaxed/simple;
	bh=cZ2Ic9EnZ5FnVsSPBGhXBK3sRfzkqqlQCcFydbNNbDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GARo/Aw164Z/3K4ce3JfjSbP1bCVAEt8RDf/9EsnebKtZyNosdytng9+xPhhAQnPv5nozQCezxzoUXGUT8IFXQz5W1fzM5VCucytjVSxO56JX3JVrjZnfaD7sFn1gRSF0x6ovddSnOoontgNEDLioMe93yM/fZeDPNfAXNeDNCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t8DH93du; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG89phUkMhrzMNUVdKIfsCTCgb9fGE/tHA6PaHZMOfzhH3rKtHuJMLR+6SE2HakZWWPkg8H44KlXy3VAjLRFeTXItSFPHeeBm5bbK+vNZbW4kV7DK5tIN7BpzkFOKjvzjdCj26bHRMDSs6dlvTiVp/mjLcsKQycTOWsezaiXxjEP09EY35e39LSDyFtejQW7BayrXYe2prdJrwhRn3wa+iJFGvC8TwSLtn0aNdcgYi1/fMBh0g++FpFAPfhsa0LmKLEU/kQg2026rfuwIOM09JiuKKjN40e0Fu9blUmtvZBSEdaIQ+luiz+hhr1K6aJsJ1I5Km6zpRCpkSoVK+iilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbgPik3qfobjNM7QInwl27PDs+KyT1rC5kJSuLucXpc=;
 b=JAk8OTj06/que1OZrdzd1L1zFOGAmltezK4ajHqckc4wuKBDOxlj/cXMtpxS6nzFOUVRMjRotHfiauQXoaiIKspmOQ53Rq1SdWu8SsFfnVbldGMm42aJj8jm88Vj3SVuwHJxzZU9A1tj9KgtmU1kr9kAJwRxWot4B9bMzO8zUismljDz+KbosHqDcc/ujLtoU7EkxJTWsMp4N1h51vcEqujKFxxODb2lgdVFKWQE9swbVIg5YTZRrnaAqb+30vHij6CtyMQO6ZQ3HMbv6PzHbDcpj/xJ9GTq0Eb3nYvv1zbPiJldmOITbivSOjiIM0mW0SaaIFS3GkYAFNaDcdupsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbgPik3qfobjNM7QInwl27PDs+KyT1rC5kJSuLucXpc=;
 b=t8DH93dupcm+ruMu6kGKrdVtReQq1ryIBnj1eFN/G9mFPWlCBEu1lW0j6exlcIw4bnnLSYgbJmXfTMy0PcrZkR/5kyiG4u5C9Gt+TpPIpZJmmNBzZFPv5Uo0QfnFZ4siwPaum4EMr+/b4KVm8LBPE87fJgSPKezAqakd5Qn8gvNlMJCped4PfZbX68Fz/wR+at/KN0T8batCo/htl95kyCggG+P1203f2mc0pG6XRnzuB/sjU05ypGzgbfAYd1OR1mconH2URTpoh3pQ58TTwR+PQP1ZXO6F3cO5XfAwDuX8Hua4G3WuRaWDUM0G6vaeTfmRpF1XP2pFJuMKkHr6hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.27; Wed, 23 Jul
 2025 15:29:02 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Wed, 23 Jul 2025
 15:29:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
 willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
 anshuman.khandual@arm.com, peterx@redhat.com, joey.gouly@arm.com,
 ioworker0@gmail.com, baohua@kernel.org, kevin.brodsky@arm.com,
 quic_zhenhuah@quicinc.com, christophe.leroy@csgroup.eu,
 yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 hughd@google.com, yang@os.amperecomputing.com
Subject: Re: [PATCH v5 4/7] mm: Introduce FPB_RESPECT_WRITE for PTE batching
 infrastructure
Date: Wed, 23 Jul 2025 11:28:57 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <6963114B-A7F2-49AA-83CA-CC4EE284714F@nvidia.com>
In-Reply-To: <20250718090244.21092-5-dev.jain@arm.com>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-5-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:806:24::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 14bd209b-665c-4ca4-2f09-08ddc9fda6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDFBUXpCRk8reFNTWTdEU0ZqQm44RGxwbHZTNHhycjFlZzh4emU0RkNsQTlK?=
 =?utf-8?B?MlRZWXZMSytGS0pPbDUxbWhSZCtyRXJmTXZlSHVvQmY5L0tpbXRwNG9CQjlk?=
 =?utf-8?B?eFBIYS8rMENxZEZUNEtnOUgxRTlIcFNqakRzS0c2UmRWTmdaRm9rNm5DR3hI?=
 =?utf-8?B?N0NNZzNKZlh4WkE5Zk1zTkFTMzZtRWNWc0p2UFJhUHJUOW5CUlh4UENjSXFr?=
 =?utf-8?B?Zm5Gd09RTWROc2JTQ0ZMWmsrNjA4VWl5cWg0YlFnTllQQkxsT0JjOEdlUHor?=
 =?utf-8?B?bk40bzV5L3dPSXNCMDFOVnNvbFJWeHJ0V2k1bzJzaFBxVWNTWnE2MTZXTDlO?=
 =?utf-8?B?NnJKS1U3dFBiV1g0WUtLcGd6NHJCTEFSS2piWWFUMGJ3K2tSR1NJTDlWZlIv?=
 =?utf-8?B?SXhrRWdxQk5hcEZlaWd0SHRHUi9Xem9nVDZ4N3liL0h2Q3J1SHp3SU5zZTJt?=
 =?utf-8?B?Z3NxTmVobndFWFliNUdWYVAvTTdxUEdHRmdrc1BiN1BMaDBkSDhXaXJTUmk5?=
 =?utf-8?B?UDNFU0x3Q1BZbW4xZ0xhNW04VG9wQVArNy9tdXNlV2hHQkxES3JuQnVJcGRF?=
 =?utf-8?B?b2Ezam1JNm9YQjJ6eTdUL040YkY3K1hoOUVQUlREUmo1MXd6QjZNOER1YS9a?=
 =?utf-8?B?QUVEYnhCY1NpNDMzWUpOcFpjcjExM20zZFNraVZJOFJvNHJNN3dicEhZeFZh?=
 =?utf-8?B?bTVlTkZ0NFZBOFo0VkdSUDRtWWVud0tyL29hMlBwZ2YrUDhMZ1NubkZPUW9s?=
 =?utf-8?B?dmg3QUJLc1laZlhRb0liOGZhWmVndCtTdUNKYVI2TWxNSGhuOUk4bXZsdzZX?=
 =?utf-8?B?NHFLK25Qdno4RXRldXM2SkhJZzE3MmVkOThYcmVHVjVvOXpwZjVqVXNXNlUw?=
 =?utf-8?B?MnlDUHE0aXlqY3BsV29OOUpmRTY4UFNHY2lQT3pYK3pTMXZUcGJEeXcwTm1M?=
 =?utf-8?B?QlRUdGNWK0hjUTV5RWFpQm9wZ2VOMmlEOE9zMkFmQ29nUG1XdlJlM1NkdnBH?=
 =?utf-8?B?Q2NJV0hHenRiWjFnbWZmZ1hEbFJDZlhjSEE3Zm1uK20vNnBsK1VrK24zTXNk?=
 =?utf-8?B?UVZQWHU0Z25Kc3g5UGo3dW1VQTh6SFpnZzAwK0NrTFc4NGJRQTNndjdnWTlI?=
 =?utf-8?B?aFQreDM1VmhOS1k0dFRjbE4yWUkvYWpucnVpbGVCZ1BRZVc4MmN6K2h0am9Z?=
 =?utf-8?B?UXVZaktVNkFiTk1vS0VFcHJBWGZBZEZ5TVpIeTFMRXlILzRUQzFpeFRNbi9G?=
 =?utf-8?B?dEpQRGFMOEpTTjRYMTlXcFZMKzRaR1ZHRXl6QVgrUTFsWFpWaGJWaDBjODNL?=
 =?utf-8?B?MUdaVU9yL3hLNzRDMVJXSmhxTnZBUTZuUk5UckJnK3RNVjdlWmJ2WlVIbnRK?=
 =?utf-8?B?NjJ4Y1hYZDlTYk9IQmM5dk9oMzhZeFlEZ2E4MHUvOUhCdnhuZG5nRnF5MVk5?=
 =?utf-8?B?eFQxWnYyRU9ySmFqVnRJREtEREg2VmZzQlYwT0JXQnIzVzJ1QTdBNE1qcDUy?=
 =?utf-8?B?c1lScnB0N2VUQlBCWFJxRUdBdmxYOWFYc3VxajRMenEvWm92cTQwTXR2ME9P?=
 =?utf-8?B?bFg1bHBPVmIvWjhaaFRpNFNuOERBOU1uUFlOeWFsMXZjQVdtZitRTFJFdVJu?=
 =?utf-8?B?elZWaXM4eFZ4anFzQ01teGlZVTA4aHh0R0UwYmJndk9jRnV3ZWtrZkt6aExw?=
 =?utf-8?B?b094dlhCTmttWlpiYVc4eXdaQjBsL0dyUWNJUU55V05wYmNUS3Z1OS9DKzdG?=
 =?utf-8?B?TVFlLy9tQUlzWXBBRlg0ZnBrY2c1ZCtXWEw1OTBtNUdxNXBIVDNqSC8ycDht?=
 =?utf-8?B?T2c4MXh4S2NOa3F4VmVDd3dwbE5lbjNGQmtLTXdUY29ia1ZBR083R0dKK3lz?=
 =?utf-8?B?OS9kRThtRllaSVZOMGcyb2dUdWVGcFNuRmszekhTZDVQZEM1QTNTTnVYdy9S?=
 =?utf-8?Q?mCtUrGaLtOg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW9oTkMxRksyL1pZQlBxdDJsTm42MnFJK0Y3TEFCa0g5a0dSdEx5aDVrSlIv?=
 =?utf-8?B?TE03SzliblNLejhLSU9pcVNHZlplL1ZJeDlFUHMrdzhkOER6amduME9Fcy93?=
 =?utf-8?B?UWZJK2IxUHlUR1RQdmVYT3k1K0tmUm9wYU9GRldBVWZ5L1dCY3VQdEtybWs1?=
 =?utf-8?B?Y3E4ZVFLTk8zcFd6QlpqNnlMdG1RSlBCRU9LelVUL211NTZVdVFRYk5semJR?=
 =?utf-8?B?ZVkwNmFIZForZ2E0K2N2eVkxZ1RwMytabzlNZ2VzdFpPOUhmZ3VadWJVN3Rx?=
 =?utf-8?B?LzBjYTF5Z2x5cm81a1RvRDFFSi9uNVB0NXdzQlIrbm9LRHl0aDA2QmxwaGIx?=
 =?utf-8?B?LzNYTUtuT1hWMkc2VHkrUWJrOUs5VjdKek5UVDdjajcwNWVZZUlTODBoRTBO?=
 =?utf-8?B?M3IxRWR2MHdrczN1eTduamRZd2VmYmVmMjRnT2Q1SndRNHhYREdNRERIaHQ0?=
 =?utf-8?B?eUQ3ZVEwYVFmUnI3M1E3a05LR2RKcWh2dE1IM2FXS1E3SkdmR2R5eEJJV2J0?=
 =?utf-8?B?OTNCMSs0WGdCL29mTm1YYklQQ2E0cWk4Rnp2ZlVNRndoZXRFWWYxclM4QjNO?=
 =?utf-8?B?ZzdUdnhzRVdqOEM1YWVwYTIza3BZVHFMWXY0TDNoVDBHV0ZmTVJtT1krV3RR?=
 =?utf-8?B?ZkZvelhFOTNaRmV6MUMxSkx2OXJ1OURMcktIZ3pwNmNLdjRaZFVMTm9QNXc5?=
 =?utf-8?B?eHJrUThwNno2T2l5NGVtQ2JTQll2ZmdsTlFGZnhMR2RucWgyY1JxbW1zeCt1?=
 =?utf-8?B?SURHNXZLUlc0d05NbThMa2t0NUpBWjdSL210alEwU1hHOEdMSXBuZU9QbHhZ?=
 =?utf-8?B?c2oxczFnZzZxY0hqY2x2Y1UrcThyQlA3OHFJd283OXhrdTNvcVhTSndja3d0?=
 =?utf-8?B?dkZnYWFBRC9VbzBOanRIaWE4RDJwdEpJVmhGK3VYN2lGVzAzd2FqbUpSdjFi?=
 =?utf-8?B?d2FjdkxzL1FvREZIR0NMaTd3OVVMcVhpbzNsWUJsVm1KNWppUHk0NEJ4VG1C?=
 =?utf-8?B?SGFTQkc5SWpmNWhUakV2dEdkeHVCaUY1bndvR3U5TnJxUmdIOXo5TVN6SUhq?=
 =?utf-8?B?eVlZbERhd1BmcVZwMnlxTW1QVEFUUVQ4WmUyTXNqeXVXU0ZJSVdLektqdE16?=
 =?utf-8?B?d3VLaWlQS3ZpMTU3bmRubGMzck1EY3czOWhlNTBzdE5FajdkczJZaFpBdy8w?=
 =?utf-8?B?QTNOaGFhNnhGTUZ3dWsyT0o0a2Zvd0Z5aWYyODIvQUVrWVFEbENjcXpHUG9j?=
 =?utf-8?B?OE10LzBtKzVjazdZZTJXNGlyQW4zMkRseTZyenQzL3h2KzJGSkhPajQxM3Z6?=
 =?utf-8?B?aUtIOEVGR2RxaERpUEJtcVBsWjBrbExBekJUdHNvdkdmTmdZcThwN3g2VGMy?=
 =?utf-8?B?MGhmdXpPZm1jMEZOOXZNSFpVRGxKWk1lUFNOU1JFQU1Zd0lxbGRvRzZEZlVH?=
 =?utf-8?B?YTBHQmdTYUV6RUFZaXdHRzNIQ3FDekVOUFVnTlRIRy9sNWlBU0tlbU92NG5E?=
 =?utf-8?B?ZkhCaVJVNENEcVp0TUpsRlFOUFRUa0FxRjQ2UG1aZmhKWGQ3Ry84N2hFUnVm?=
 =?utf-8?B?MkFET01wVERxVGw5U0NmOXpTRnBnakJTME5KajV0ZGtUejBhMzM4SVZsbUNW?=
 =?utf-8?B?amwzMVJUR1ljNEJFRzhIOVZ2SnRhZy9pZW1HV3gyY1UxNlFEVENReSs2Z3px?=
 =?utf-8?B?TzFVaFBZRWNFRERHOGpSYzZaa29COFhoSkVEcjRQaS9NVWNabjQ4eEtrcjVa?=
 =?utf-8?B?TTFtZXJ4R09ESzJyZ1FJR0FJckN6ZS93c2M5b1Bxc3JZQUZGLzE5dEZoZjg2?=
 =?utf-8?B?NzU0eHRQTWp3dWlYMlZDcndFN3BYd0xnaUQzTEN1a1VPQmRheUNKUTJKeE5u?=
 =?utf-8?B?N2dMNXpPMlBWMUJDY2lHbmdaUFVQcDFPa2phNEtWd1lOcDlPOVlINmZoWHBP?=
 =?utf-8?B?QjMwcVN6SUwyTm1qODU4dnFlanJCbnlUSnp6L2FxRm9MamZpNnFsZ1ZWTzlj?=
 =?utf-8?B?TkQ2dG4vdERrSTQvUkM2SFlROHJMZUJiZmFUd3hWR2paM2pRN0k5b0hVMEcx?=
 =?utf-8?B?amU5ZW0vaVVoK2FoTWlZZHArMFV1aWZQc3phSTNuWUppeTNDS2h0MkRtOXJX?=
 =?utf-8?Q?2Ly4Xqd7Ccs3/EHjxfmil2B3d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bd209b-665c-4ca4-2f09-08ddc9fda6c0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:29:01.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaCNufwpRNwtHZ0B7MQYFt4z1NPIR5jpX06bnmY2wdQBzi8EH6U/dEsGFAwoU6lW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729

On 18 Jul 2025, at 5:02, Dev Jain wrote:

> Patch 6 optimizes mprotect() by batch clearing the ptes, masking in the new

“Patch 6” might not make sense when reading it in the git log. Something like
below might be better:

mprotect() will be optimized by batch clearing the ptes, masking in the new
protections, and batch setting the ptes in an upcoming commit.

No need to repin for this one.

> protections, and batch setting the ptes. Suppose that the first pte
> of the batch is writable - with the current implementation of
> folio_pte_batch(), it is not guaranteed that the other ptes in the batch
> are already writable too, so we may incorrectly end up setting the
> writable bit on all ptes via modify_prot_commit_ptes().
>
> Therefore, introduce FPB_RESPECT_WRITE so that all ptes in the batch
> are writable or not.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/internal.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

