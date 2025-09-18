Return-Path: <linux-kernel+bounces-769961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175EAB2755F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9385601D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A27A29D295;
	Fri, 15 Aug 2025 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NH58ytpA"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212EF29D283
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223171; cv=fail; b=LtVZ4sy9Ms2vPuOYLMbX+6Qi4I3OVCDbaQJGQXQxbvxisfvVj1NiZih8jdHMHvyQraXSSu4qPvL07Q8eOgmqdflD4OQJtghOixJBL6Tsr9Ytqcitv3ma0hpEmsQrw5mbRjgxSeBb4JUhagR+UQKydVxHT99yXfjxLJBp0BCAJvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223171; c=relaxed/simple;
	bh=3hRsWTEB11b4vTq+PJKMjlxo4AG3E4jyM3BHAh7/OpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TapJ0sUCP+Ucy3d+Q/pgb4IUiqsK8xhGSw7iNTEn920+a7BB4ox/ScDLpBeqwCDjsyG8xt4Eh858Cw/oxpFPuhIylk0bVJWzYxj9so00NSn583Al2mgC1Xlzx+B9LbDuEPN1M5584AjS9UQhUwi2FS+PO94Tyj3dB0XM0bfnKGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NH58ytpA; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWhY0Nh0wRyWX/A1vi8SajJ2fQW/mUkpvHqVSavcTt6Vv2inPrRIInFfdhWFV4AevTrfKTM+12fae58p+SLMOwe9VmMITU4WXkbYxTJ+wE5G5BbPSt5rPE/Ewv5fUISLeCj4FKtdhMi+NFlI8/4IUQdEaG4cK/L/ip24TJIRoHGMEK73xRB/2bkOx5wPP+c+wqo8gXsAw6eeoJAFvPYH0xvjyNjmJiXbV7OogqqiXIJuben2IJBhutjbLkfbn5HlXndwCcDVfmhL8kD5nDlVAHsTMk4wWzMCrUAa0/ATJW9INIYmZvUpPqg648vU8LfW5rI2lF886lEs6IfBCk0MNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OWYOMmq2QaD7wLypAJ0t645aLZlMfw3i8eFBKLNYBA=;
 b=fMsFopwkfxTI4PbbBBEuyJAVBoopWxAO1Ciu61C8CfU4n4pLg3cFpbP1ldp3KLAPKWekpEp28t94F0QvSHMou9kWpQ7Fx0IwS/EP7LCIHM4fFCfmMZNXAxdOfz3ACJyup2/Uuuf/tu7q9xjiNQ6LwvWz0FH9UWf5fKy0OD0DTLIn9/xKgJfjkHJnt9MFw/HGcUP6Ds2ofe0/2JbGZsk9om4tWFqEfwVjn3kT+C9q8kLbr+WssZPgvVXEEXuq6QOn34Guu6ZCNQP9/SA6oPEGZ1MUl7/peiR86beG7Xsc4neBjEkjrIR4aFiYIXPAfEuCfbXgn6lKOw0Ql1c1g8/OXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OWYOMmq2QaD7wLypAJ0t645aLZlMfw3i8eFBKLNYBA=;
 b=NH58ytpArOoBCSEJc8azgWXaucQPcLzYQyuKW73ZonCmw509lxYoKjpk8B6NGrvrn8SiUlQkkQ7BkH8lwRzKLLinldPfWJ0omBnHSP47opRh6JbKihXGMLsdnSjye7LRTJRnv+FSo4mu3HG0UVQ79/CZeK99wpem39E+Ld0nXz+RXXds765XOvkt8GjcpZtZ8Xp7ADb9rEy8Z8t+H6HeeWaKy3YiGoW+YMBjMSe3zk9kyokrJmYusRkW2Q2KEaRm2W8DmKhaxlrVozFoca8y3GRtiyd06KfrR5DqbCSb37XSxfwAq0OixK3bgjMIgwALEAfNZJFNuPi8HJgRo1GxdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Fri, 15 Aug 2025 01:59:25 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 01:59:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Ye Liu <liuye@kylinos.cn>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: simplify lowmem_reserve max calculation
Date: Thu, 14 Aug 2025 21:59:22 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <78E63F8C-7A6F-4B6B-AD92-25477CF59E4E@nvidia.com>
In-Reply-To: <0032c975-1e37-484f-9b7b-a3f0fea0401a@linux.dev>
References: <20250814090053.22241-1-ye.liu@linux.dev>
 <EF575A1E-6AE2-45D7-9AC0-49C462A0CE5C@nvidia.com>
 <0032c975-1e37-484f-9b7b-a3f0fea0401a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:408:e4::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a05fdb9-c4e0-46d0-a47c-08dddb9f5ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUpmelNlSTlhaXFRSldKK0pwZVcwUkhKVURjZ00yK1U3VjdIM21USzkzSUhM?=
 =?utf-8?B?a2g4S1QwQXk1eVpFNDErc21DK0hzRDdTWHpGNVFvYkVSNnJhQnFqamJsSGFX?=
 =?utf-8?B?bml3R0V0RWNjak55VUl5MkNZRkdsZjI4WElDU3hMZ0w3NWZKOW5XR25QWFBH?=
 =?utf-8?B?RE9MeFRGNWo0ZUM1QkZ2TFhTSjRORjN1bTFMV2FLV1JKQ1h0YkVkZy83Rm45?=
 =?utf-8?B?Q2JWaWFHY0tER3ArQU5JdjR0U0dJNUNLUmF2QnYzWFNXT052MUc5Ym1pcTI1?=
 =?utf-8?B?UG9SQkxrZWQ3RkJrVFZvOExiSTMzOVd3RmhhT3hPVkp2dDc0bW9qRkJrM3VP?=
 =?utf-8?B?VmsrczFqd1ZlbTlDMHdqNmVsdTRwWDh0Vyt6WTg1MDZldzRrdzhzRjRwNnNH?=
 =?utf-8?B?RWpvaXhlajZMdHNsbkU2REplQ3RsL2wxaEY4Vkx2Q2NtdlRwUEdtQWJSVUYw?=
 =?utf-8?B?dEdOV0pFM2pGdytlTDUzN1BlTzU5WmU1ZFdyZWNDUFFISDM1OXFCZ0I5Tm5Z?=
 =?utf-8?B?Nml3ZEdEMEQzdmZVZVgzUUxNYlJDbUF4bUpEZzFWa2VjQ0FRZHFQcngwYTRu?=
 =?utf-8?B?bXU2R3k5dlZVaEdQYjhoS0FkV3prRnVjU05BQjB3SGxLTUJRZ0RQclY1OW9J?=
 =?utf-8?B?WUdxdVhQUkZYNEVhcW1YR0lUK3BHMTVKakNqL1dtRVRGTmI4Z3hZSittTUsx?=
 =?utf-8?B?WGZ5VnV6T0F6RGFkWTREU2t5Vy9ZMTV5ZDVNNkgvOVp6MUZuZmh6bXJEUjZ2?=
 =?utf-8?B?cUJGcCtrZ0ovc2VSaGl3bzhJbE9WOHUvYmtSNmFXeTJISG1MWXh0Q3l2azhx?=
 =?utf-8?B?dEpnWGZtNmxWTi9KQndhNTdFYytoWUMwM2hKSmpTTWZwczRuLy9yS25LMVpC?=
 =?utf-8?B?Yi9WTjRZaVFPbSsvVVFCL01xTWZVZ1dhaGd1ZHcydU8xNnlqZzUwcEE3TW5i?=
 =?utf-8?B?ck5QdjNSV2RXK0J1VnVQZUhMeWt3RVg1Tm5wTXV2bWtFR2lxT3pVci9pNCt2?=
 =?utf-8?B?NllKalByc2M5Q2Nic2RnaXc5QjdsRC9lN2N1V0JqWFc0WG5aaDlJNWVFR1hy?=
 =?utf-8?B?V216NWVDMjFicWM2SzIvOERhMVUydnRxUUpQb3NBK1c1dzdEb3Y5U2dhTm0w?=
 =?utf-8?B?UTVXZUYxNWQ0MU9iV3owT1JSZ3h0KzgzZEh5UXpvcjBRdXptZ3UyNU5vRk1K?=
 =?utf-8?B?b0lRRGRrUXROcSs4d2k0ZEJWcWZFdDFvTTNNT01nQlo3ekxyZHI3MGk1elF5?=
 =?utf-8?B?SFlyaENzZmtHakxETkQyY3g0YURKUDBOeFRNWC8rY25YT3VOMTNvSFJTUWU2?=
 =?utf-8?B?RjJZRmVVL2ViUWh4YnMzdkgralJZc0ZZK0d2a054RFFaR05pcDF3VTNlZlho?=
 =?utf-8?B?NHBEZUdRbTFLZUJQWitQS2JjWU1BYmh0cG9EVHRKMmJhZ2FjcjZuQ0MxRi9z?=
 =?utf-8?B?R2RHeDMzUXZuMjBqSGtJZXlMTGxHYlJkcU5rY3ozSG0wbmRKWjZyczRwUHJG?=
 =?utf-8?B?UENvSjh1MnNVMVBOZkI4TlBoUnV4WkM0VlA5bitXZmg1ZHh1bjhlSWZ1N0xt?=
 =?utf-8?B?MWsyVFBsaU11aE40ZlhGeHVxRytQNTFxYzJUS0hjNlNjUzl4YVNEVXlkUXVZ?=
 =?utf-8?B?eEUzcTZINFA2Mkh5U2tsUlV0aWc1b3laK2tVdmRCNW9OSWlhOE9NRTVxRDVq?=
 =?utf-8?B?MzF3UVV6R0Vtd3RYbDVWeTcxNEJvRVpKZkJueEYrSjY1QkZHZGFPcUFLZjNk?=
 =?utf-8?B?TG1HYmdVM2pNZ3lmeDBDbENrUkJybkpBMzlEVFcvQ3YvUndHdURzVGhYZk9s?=
 =?utf-8?B?ZHFzWTZYYU9MdWNSeUJrWnh2VzJRQXZyZktDTE54M2RhTWQyMGswdUhMdFVq?=
 =?utf-8?B?ZXdtdktYNTJyOHBON1ZZVkNwbm1Bak8xVmQ3WFZRM2I5UEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUIrQU1kalNLT25HUlpwWUduK21KSklhYVBKdWM4d3A2dkN3dW5WUFRNN1hZ?=
 =?utf-8?B?cW52blBsQzdhQ2xkQUJsZG1ZZ2NuOGg1WDVyNENITVNvWkpDbWZHWXRxU0NN?=
 =?utf-8?B?dnFJejNJTzgvY1h5ejRibENjWUFPZ3FJemhhdzBWRmRPTlNwY0FMUmdMeW82?=
 =?utf-8?B?VHRHMHBabnBMc055eG5uaFBWL2RNZVc3c0ZmTzM1QXFVSEZaV01UMnFLSGNq?=
 =?utf-8?B?dDYyVG0rQU1PSzQyMnpQZlh2YVdiVFFJK3N5NHcwZTBQNzQzQUJjc1ZiMjNI?=
 =?utf-8?B?WG1yVVRzSGFCdHRtSTFmM1B1Qmd2OWtGbytwMVN1WjZmbFVIV29ub1o0Ymtu?=
 =?utf-8?B?RkwvT2poSElnWWlqcndQejJwNlBZanZ4SHk3Z2ptemNpMnpuazIzM0lIN2hZ?=
 =?utf-8?B?SkJNOFVobUFrbmdNK1dtR1Fpa2hQcTZ4cHFUeG1tYytTczV1ckNOWlF2NENy?=
 =?utf-8?B?aENqK1p4Sk5OYktnRUhoRHcwMU5odmhISGc3TFdacCtxTmgyT3Q5TVVzVXJl?=
 =?utf-8?B?Nk9SeEtDME13T0lPM2xaV2lUZUkwSUtUY1c2akNndXJGYisxQnVDQmxuWWhL?=
 =?utf-8?B?N0pzVElDNktVNjBIZDFuNE1qcFBMZjhOTW9qODZkUTYxRnF0alRkcXhNdm1m?=
 =?utf-8?B?MVVXYjBqVDlCeGZsd2FwWFE4ZVlFUjFmNWpIclo5M0xnUllRb0NRSm9ISUhZ?=
 =?utf-8?B?UzN4dlVMVCswclloVFJ3VmtldEx3UWNNdU96TU8xamw4b3Rlb0RGcjI2TWVt?=
 =?utf-8?B?MHhycXRxM2xmb2xVbWhrbFRUMnYyd1hvR3lpdUFaQjFHcE1oWUpYMkUvZWMw?=
 =?utf-8?B?dEc3dGFOOTVzNkxZeEVlVDdPbXFCa2lmTVB3aEs0Y0xxVzRZVnFJOEE4eFdP?=
 =?utf-8?B?dm00Q3F0ZURMZTRRRWR5RjlpbytmVXBOSEc4RVpBbExIVkdldVUyeEJ5d0JO?=
 =?utf-8?B?VVlMT1A0aWh3L2h1N1owUi9GVTh6eUVDc0RRcFRWbFFzdU5GYVFZT0g5cWZT?=
 =?utf-8?B?R0c3Rkh1cnpIQUJjSmhsY2VJOU1GTW42RDdMQUNpLzNocUlnMTROM285U1k4?=
 =?utf-8?B?RWhnNjd2enRCcFZWOHNPTWtFVWZGKzBZVm1ENDZNNHdQV1E2aVpBbVpENGNk?=
 =?utf-8?B?MlFEekFHZTBBTHY1U29uL0pzcVNjbWF0eGNhcGJkZFlFS28rdGRaYU5SU29M?=
 =?utf-8?B?YklDdjR3bHR4TjFYRzNpdi9ESnBRM2hmK2M3QVdKbmR6eDF0anlzZVh4RUsw?=
 =?utf-8?B?c08rTzd5ZnpGODM5Q3U5dlNzeWc3T2U3bWc5Qnp2Y3c5UzhwbEVidzFCSTRY?=
 =?utf-8?B?ZE9JdUMrMXhYM2pFSk9UZEd4ZktScmxhdHRUTERIbUhJSHlrSjZTaWZQcU9H?=
 =?utf-8?B?eC82M3d6NG8rZHlMWUFXUmxwT0xGRWdWbTgzTi9KTEpZeGcrT3JKTlBhZWpN?=
 =?utf-8?B?Ti90MkdSM2NtbFBEUjVFeWNzQlp3cUZjZm5lLzBIQ2dsQjBrNDRtVFVSY2R3?=
 =?utf-8?B?VDZaVzNnYmIzZEdmVEFyeE1CVCtJb0ZheWZEa0R0Zm9DYlZsd3VQeHBWRnNs?=
 =?utf-8?B?Mk9DNy9sR3dUYThUNlRwVFBnL0hycWlzTUt4U1paam9GY0taRHpUbEh6WUpi?=
 =?utf-8?B?RTYvTDlBV1BQWjRhSFJUdEZiN0xYam9KSE40RUJoc0s2MklWcFJrRGp4UGll?=
 =?utf-8?B?LzVoRTluZkplUTVjVkFSd1BFUFBNcGRnc2NQVFpyN2RDdWFCYkYxaVZ3Mngx?=
 =?utf-8?B?MEZhcnNrU01GdkVDQ2ZDa2loVys4Rmw2VXRwZ1ppdUxSbUpZL0ZjaDBHczRw?=
 =?utf-8?B?UnV1WnRObjNvb1RsQW5GSGlBZ3htTVBEZm51WnRMRGJkUitLd3o4NnpWNlI1?=
 =?utf-8?B?dm9vQityMnNpbUZha09STHN3bStLZTJza2lVWUJuaWhxNXRsdDF1bFhrMFhO?=
 =?utf-8?B?NlpEWjU3aS81Tnh5M09CQTVmNitWdFByZnZ1dlBWTDNEeUF1ZWdOODAycWov?=
 =?utf-8?B?Wk9RMWtNc0hrUDVUZk5HSEVjZ21QMy9Tc3MvOHBacTlqTzkxNlE2SzJ5L29G?=
 =?utf-8?B?QzN6R1BLRGRpVzJJb2FMbGRRc0NZdjI1UkVBblVvZzRsOWxDZUVmZjh5WXZZ?=
 =?utf-8?Q?c72D5oT8xhEp/gK/T8DC7hO71?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a05fdb9-c4e0-46d0-a47c-08dddb9f5ca8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 01:59:25.8380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEIsvDo+QESWsWiJBUB1XyALqY3Ij+76IZRUfqMGfkN7XBq8lV0EBuc8JyjRymqz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646

On 14 Aug 2025, at 21:38, Ye Liu wrote:

> =E5=9C=A8 2025/8/14 22:47, Zi Yan =E5=86=99=E9=81=93:
>> On 14 Aug 2025, at 5:00, Ye Liu wrote:
>>
>>> From: Ye Liu <liuye@kylinos.cn>
>>>
>>> Use max() macro to simplify the calculation of maximum lowmem_reserve
>>> value in calculate_totalreserve_pages(), instead of open-coding the
>>> comparison. The functionality remains identical.
>>>
>>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>>> ---
>>>  mm/page_alloc.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 64872214bc7d..8a55a4951d19 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -6236,8 +6236,7 @@ static void calculate_totalreserve_pages(void)
>>>
>>>  			/* Find valid and maximum lowmem_reserve in the zone */
>>>  			for (j =3D i; j < MAX_NR_ZONES; j++) {
>>> -				if (zone->lowmem_reserve[j] > max)
>>> -					max =3D zone->lowmem_reserve[j];
>>> +				max =3D max(max, zone->lowmem_reserve[j]);
>>>  			}
>>
>> There is a =E2=80=9Cif (max > managed_pages)=E2=80=9D below. Maybe conve=
rt that as well?
>
> I should use min() here, but I noticed the two variables have different t=
ypes:
> one is 'long' and the other is 'unsigned long'. So, I should use min_t().
> But then again, why is lowmem_reserve of type 'long'?

Based on commit 3484b2de9499 ("mm: rearrange zone fields into read-only, pa=
ge
alloc, statistics and page reclaim lines=E2=80=9D), lowmem_reserve type is =
changed
due to the watermark calculation. Looking at current __zone_watermark_ok(),
the comment above free_pages -=3D ... says free_pages may go negative and
later free_pages is compared with lowmem_reserve.

> It should be a non-negative number, right?
> Is it possible to change the type of lowmem_reserve to 'unsigned long' an=
d
> change all uses of it at the same time? Is it necessary?

In calculate_totalreserve_pages(), max cannot be negative, so you
probably can use min_t(unsigned long, max, managed_pages) and without
changing lowmem_reserve type.


>
>>
>> Feel free to add Acked-by: Zi Yan <ziy@nvidia.com>.
>>
>> Best Regards,
>> Yan, Zi
>
> --=20
> Thanks,
> Ye Liu


Best Regards,
Yan, Zi

