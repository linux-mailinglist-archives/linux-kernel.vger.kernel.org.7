Return-Path: <linux-kernel+bounces-755054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9C6B1A0B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F303BD81E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A322594BE;
	Mon,  4 Aug 2025 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d/stanKU"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA821A440;
	Mon,  4 Aug 2025 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754307950; cv=fail; b=M3c33fmQalrx6/NMwT0W+mvLiTxbS34pylGEA6OJWamLnN4hypjnDsRbGKVflZMXVl5zn3zFaw6zrNtWn6CSW4U3hnh8VwlmyXcF16o25RqkiBboDCJgYhRDoD9Hd0DFoCmuCgxevFwE8bgBhiUA5mBTzD5k4BL7GV+9AArSqUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754307950; c=relaxed/simple;
	bh=8B3YoMWyjeQEnDGwkFZnra06rNVqZHM+yRdYAZOKd5M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nF0iB9KSXqBf5pwWEHJK/HxtcPkh0xz/8bNVRq4hIZdqzOyAoAu+PJ+l57K2S6mjB/3Ku7jV4SjZKaL9zZeVpm7cbH3UtNDWHJhl5GQyY8D9F20PuC8oeT2nbhMmebKoTWOGxhPFWmGgucYKhd3dIa7dMizIub2MigO9luF3fhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d/stanKU; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTFd8y2C1BdB5X2wuMxiyx6jo66TtPdbt3/74Q+rQO0+Fv6Dnmg899s4PmMxJee2rwmaSUDrIanODsBpYJ5jwxcJys/KGB8kMgvHBoglVCtuM7yx9G7juiKbP0pP1VHh/CHXiVtBJ3YA8Uw/2bx3qjO7hE8eb2cvCeY+b4UVPh5axhTfN52cmLihlLSNeXpNcx61c0rPaJ8bou164TBgzUoxbRetJrzMO5CYaWwmQHaQObDWedFhoVp5tDSSiuSoSJ64KBWlHA2snwIpSsYaqhNct8vTAkmPsZmxVUnTj523EoW73pm3eVv/xDwqRO4/K48yvNGOgEDfWc8OtjjEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofpTSDTmzXLy4fMqbrfLAcK8OpuhRsePX/aKvYRz+V0=;
 b=oPArHlV78HU+p+0mpO5wB1BtSu5zpiNZhToTxx4CpUFLvM2nMJKDKMGeT+TFmlxbpmY6rT/i/2wjFluaWLvQ+FUVNGa3I7X1+jHaOAZqb9qAKydMttKxeMKtmCF1EqTnk/j8iX161frtxoVUmIqSXHv39QzIZexDWpgEHG/E0Xyvvr6ZJ21BqzQ6bMznissEoOoEzRKIEdVqJftvEtZWQnBAvH2QHZhAyXJqim/vXqbOR+6sKjWRrL9OSpfrbzGYvxXtQVfcXWIfFBdP+IUm0rsoEDrpZ5+fpvwkDRCWsxVFe80fZTeiaItMFwN+ztGfnXWmcq8OzJDpPZt0A8dufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofpTSDTmzXLy4fMqbrfLAcK8OpuhRsePX/aKvYRz+V0=;
 b=d/stanKU2TdRGggv6bx4ouq+uz3RBPXPeJEGclTclKkbLYaeWvTfyGL5ueIAHx6YugZ5So8aqB6i6+PdTctMIjL1MzHBBn46PoxFsBpShdCWrd9iDLfAd1J9MasRjCcuaS3tmXu6GO4wjYJcWMUjfZ2RfNU0bvRW4tKZr3hFhx9Y8r+/aMbfH6tc9Sl+rWYszY0FwEsLQceWL+vaWOC1j7cBKd5nBL40cO8ZBoFJ4B2pt9A5HeVK3l79YyJNpOiBz4qfoE0hzpym0OFl+G4VN+5YF5emnVUDeaD8C/jTTK9X28KxQ5pekQl/4mI+NoqrKlmNeqFDfq+U9vTA1WNTIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 11:45:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 11:45:45 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 04 Aug 2025 20:45:26 +0900
Subject: [PATCH v2 3/4] gpu: nova-core: use Alignment for alignment-related
 operations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-num-v2-3-a96b9ca6eb02@nvidia.com>
References: <20250804-num-v2-0-a96b9ca6eb02@nvidia.com>
In-Reply-To: <20250804-num-v2-0-a96b9ca6eb02@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 nouveau@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TYCP286CA0107.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 964aeb4f-3159-48b9-c8c3-08ddd34c72e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVdOK3A3dURTVjFzVG9QYjhUTmVDQ2pRMEJrMXZMamwrVW5KSEFxMGNaT1Bx?=
 =?utf-8?B?bUtIUFdaY2FBOTFVOGR6UE1aaGw3S2NRWmtYT1RKTTFIdFhrd2hWd0Z3UWU4?=
 =?utf-8?B?c1Y3dEozUkgxTUZaTHpUWnZ3TFYxTWJzQlppMm1qeC9mYnBIL3JpalovL2Jq?=
 =?utf-8?B?ZHdEcjkxZDF5cFl1bHpNUlVzNUVHaWFXdHBka01EV2pOaXZhTWNjSnZST0Yr?=
 =?utf-8?B?NlZWU0hJRmpKdDgyN1ZOeEZYYk5xWDQ1S25VRFNwSG9lVm9XaU8yNDh2UTU0?=
 =?utf-8?B?bE1pMWV4cmJGR284MEFkNnpOYjl4K3JpL3JjU0hreVVLYUoxYzQ2Y0xucGk3?=
 =?utf-8?B?V3JGckRZaUEwMzlwUFZWQ0dXMnh4R3hqendKWU5TSllLTjNMOVRpUzVIS2R0?=
 =?utf-8?B?MWk5SS90Z2lXU2h5c201SGpZbFpKQzRvQUNoRzliZlA4OEVFY281T3lJNWlp?=
 =?utf-8?B?UkJuN1hDazd4K1l3RXJmUGhrTkpLWUNkSzdJaHhGMnFqMHlOdXV4RHpqU1NV?=
 =?utf-8?B?dERWY3FnL0c2WG1tR3pxaGtvWDgyOUlnRmczVm40Tk5VSlRhZkpzaVJGbHZW?=
 =?utf-8?B?THkyTzcxMGxqUXc3M01qYmpFcWVRempZamVVcjYwb3VLeHpkbGxKVHNaYkFk?=
 =?utf-8?B?VEU5MTRMVmxITlhqVFJQeEZEVTg0UTZ4TytlZGsyKzdSNkFzNmorQnE0N2w2?=
 =?utf-8?B?WlZpWnp6RXdlQTVSa1M1Yjl2SkZUVjZZZ2FnQ2tLcDFUMzBiMUw3S2lHK1E0?=
 =?utf-8?B?ZWRBNmVqVlYzWDFGYm9zQXNKdW56akhUREVQajYrUWo0UiszUHFYcFVUaXdW?=
 =?utf-8?B?Ukp0aWhjblRETjU1YUFNS0lMbUpTMVBKa3cvR2VWMHYyZXpvc0c2ODVZdC9D?=
 =?utf-8?B?YU80b2pta3BkQkdFaUc3ZTZjeGZlZzNvQnRWT2ZjaGhlME5YS2QwcnIyZFRo?=
 =?utf-8?B?eFlZK3lHVjJpSGxBSXZEWHpPQldaV0xZY01FQzJ3L0U3U3dLbktmaE9yMElH?=
 =?utf-8?B?VG1rTGZnZmZkbWI0cm5UNUl1S3FuZVQyWU5ZYjNqZ2xlU1B3bTI3ZXZLMlBi?=
 =?utf-8?B?NTVkRFVVdW1zZHhSWWJwN21rMGV3Tys2MlBmbnRkZzQ2OUVUNWR5dXVmUVpN?=
 =?utf-8?B?TEV1VDA2YjBjVTdKdGllMHpTTWpYdUxjWXZTTWlqWmxoU1JlRFE5SW45dWhl?=
 =?utf-8?B?Q0dEY2VJK2labmtYVCtUanJ6b0U4ZzdMU21BbzhhTlVsaHZxSXM3OVZzT3Bz?=
 =?utf-8?B?ME5uWGJDVXZWMHBNTnVIWDgwMm1wMi9HWkROcUNQVm5oZTdrcnJVZEFiRzd5?=
 =?utf-8?B?VmZTV3REOVU4bkdRMFBEKzQzZFJNUVcrVkRXRnVrV1hoTVhXVlNHb2J1Qll1?=
 =?utf-8?B?Z0NqMDBYNDgrM0NTdGJFNG5HTCtYVEZnbjhUMVV4TmFsbndkY0JYVzlnUWQ2?=
 =?utf-8?B?Z0ZBalJYRVF0RXJFdFZjRk9HQ29nODBoRHVBb2oyaXprZ1IyMWRqMDRwMjUr?=
 =?utf-8?B?RjJjWTJWVysydUpmOGRWaHFoWEdaeENIUGROd1ZScWtMSEV3RS9hbS9mUjhX?=
 =?utf-8?B?TFFyNThROXUzWStOYnhjKzFURjhQSmJ6ZUYzTHQ2a093UmN2eFlmVmROaXNn?=
 =?utf-8?B?TmpGbi9DREg2eUlCanFheGFQbkd0VFJQUlRGdy9CKzJSRXJzeGNjV2pWVTdJ?=
 =?utf-8?B?YXN2bTlIbTNKazlFZ2gyNkpDNUovYWtnVGhhS2NKaUFjUUlNaU5CbENZOE8r?=
 =?utf-8?B?WTI4RWFNZGFiZDJ0aStDTDd6cHpkcEpBbDR2V3QxOTExazFFdzA0N294cmFu?=
 =?utf-8?B?TmFBa0Nxb2RXbyttMkhtKzYvcDM1WDJKdmNmOHIybklFS25TSUptV1c0bEM3?=
 =?utf-8?B?Ui8wS0p3TTU0ZmtxM20wTHl3ZHhNZWVVVU9vZG5QMnBSb0NLTzlnM1h3aDh5?=
 =?utf-8?B?M1lSeDltVnJHUDJxTnlMWGZzT2tmR1pvWWNBUUFYK3JveGJZbytzRUxORURu?=
 =?utf-8?B?ZnM4Z2pxQWdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djVnRWoxNzRvQ1BkajhCNHR2MjFrNHZFYVBhVzhnY2xXcDB5SllhYkx3ZUNL?=
 =?utf-8?B?WFF1TWFOU2pjZ2dnS2JLRFdBKzR4b05BeGhqTStaTy9QNHQ0Z3NibDQ2WkpM?=
 =?utf-8?B?M21mOVloTWMyOEtCd3QxRkkvSzRsbTNvdzBURzhqbzZ0RCtmWm8ydGZ2bjZG?=
 =?utf-8?B?Wk4rQjdxRUF0RE9na0xzWWRhTWpFbE92NlNEL08vV3NkbU56NUROZCtKaTNP?=
 =?utf-8?B?REJteW1CendLVGphZnpUSzM1Y3JtcWgwdEs4SUV2QjBjSWd6dkswa09jWWVu?=
 =?utf-8?B?VXhteFN3OGZCVy9yWUZ5b1hZbG5GUkdMQ0o1SDhWRnFLMHl5aXczR3lXY2VO?=
 =?utf-8?B?NldvaXVBeDVJemlRRTJlYWx2ZlJxcEpOc2V3QjFuTnd2OXBQVnNHdG9ha05o?=
 =?utf-8?B?bk9SMW5STmFFWThqNnFObVp6S2hUUFdUMExXb3NhTHZ4ZHJJdjhlQVZDNUFr?=
 =?utf-8?B?WGRPTnRoN0FSTkV0bWxudmN2azdLemMvZE5BazAyM1ZuRXlqYWM4bllXWmxC?=
 =?utf-8?B?bDd6dk9CdEFQZkYvQi9ZL01naTRrZkgzZlNoSkx1bzVFa0drMW1uODdsNXNn?=
 =?utf-8?B?OTJUa3YwNk9idkkrYTZhcS9RZm5yK3ZCQ0FZUGFCcWJEbCt4dWFjVE1TNU9v?=
 =?utf-8?B?SWt2ZytxKy92Tm1BMExERHJzRDMwejZmVFdLMW9hdnk0VWJ1M2ptelU1ZkdM?=
 =?utf-8?B?OFV6ckZVRHNNcDk5QUNEamVBdGh0TnpKYkFTWG00cGJmZFMrU1h1Q0FJOFRr?=
 =?utf-8?B?Ly8rNVN0M3JiVFR2czVsOEVPSWJiV3Y0Ni9WQUpXcGJVK2dEQmlvRVFzY21X?=
 =?utf-8?B?OFFmbUFKU1NKdmJ1UzE5d0svQk9EemNKa2UzMjhxbnZ1dDNNTjhYV3gySmhL?=
 =?utf-8?B?bTJrNjd1TXQzNUY4L1VwNEo3OVp2UVBHWEw3R0Z4Y2xyTzNoTFBsZ01GMWU1?=
 =?utf-8?B?bWhZTEk3TGR5TVFUWFpFcUYwMGFvajZBYmdrZFhMdEdHNEp2UmtxZEFzOXRM?=
 =?utf-8?B?d0grdnJVZ2hyaldTKzJKZXZqMk5xcjZkQW9RNWVuWlBjNG5LT25hdXZZeS9l?=
 =?utf-8?B?ZDdvZ3YyaXRDM2pma28vbTdPU0ptN0pIaGcyQnhuaWd5c3V3YkhSdExRZXBL?=
 =?utf-8?B?dUtteUJjSk1COXFRaFlrNkZQeCt0Y3JZQURYNlUyOGZwdytqWlJjUnk5SDRZ?=
 =?utf-8?B?TTdRZW15RGhUbkJKcmNXNHc5cExOR0M4NjMyVGdpUjAvcmZZZlk4bWIxMjdh?=
 =?utf-8?B?SnhxbEhIcFVLRE9nK200M2tLRVFscEszQjhQeVhFTmkvNWZEbFhXREVDd0cz?=
 =?utf-8?B?M2hBTkZNUWFkd0tzWVFIdXJHYzNmQUMzRGx3SWZJOGdkM2dhNU5OOS9LVU4x?=
 =?utf-8?B?NkRWdW9LdjhPYnJKRFBMZ3lHdVVZd25pdytyYVFHWWNDcW9rZHpPRDY0b2lz?=
 =?utf-8?B?QTdHVGhSZW44aDRkU0l5YW1tdXc3K3JtL2FSb0tDQzZwRnBPM2hNWjNVWk5W?=
 =?utf-8?B?ODZwYnhRQ0tjQjBQZ3JuTEtpUlZBSWg0N1J5S0pEdFNsR2VLUHRYdXZDOGpX?=
 =?utf-8?B?M0tUZzZzL20zYUpOQ1AzcUhMQUszdnBlRDNDc0diV1ZhL2hYMC9OcGRaSG5I?=
 =?utf-8?B?L3EyQzVrRFBOSVQ2TndVMnZxU0VlM21ydjZHMmVWUzBGZHllckNQSzJuN1V2?=
 =?utf-8?B?VGtaYXA2RE1VM3FxNGpEMEI0OEVYSmErY3lFVCtBU0xMZFA0V1VoY2trVUMy?=
 =?utf-8?B?K2xJRWpCUitOVUpHSkNBcHBnNXNUeGRlSkp6MGYvZC9HZzBNWnhZQ2x6V3hI?=
 =?utf-8?B?aDRKT1pGRDdmWnh1WVJxT0w5cWNHYVU1cmJhSXg0dEQ1L3BQb2xWekRFNkdS?=
 =?utf-8?B?dTZ6dFNqdjdHcU9HOHdCbTFPQ1dmZDZZMDh1UnRPNmc2dmNFQThrUVFQbkZJ?=
 =?utf-8?B?YmFVQm5ybXIrdW5hRGN4R2dDdGhBT0tnZi90N214VFJsRmUyVVgwak9iT2hH?=
 =?utf-8?B?R0loZTErS2g1NkFSMEZhTUJhZWY5L1k4aTAwMlZrL2RmK3pHVHVRVmE1V1Z4?=
 =?utf-8?B?Nkl6SC9KUFlkcXJMWG9oaGJ5QWY0QUd5TkUzR3lxaElJRUtFdXlVUzNPQVJF?=
 =?utf-8?B?a24vUGkzUUVhd21MYmlWVSttMmZIWlJJb011dlhycFBWWlF4c0d1V0h1ZXM0?=
 =?utf-8?Q?3FXrNDyBaDBtdjpdx0SUqSpssqYVguQYcj1Xeth8SoqO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964aeb4f-3159-48b9-c8c3-08ddd34c72e3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:45:45.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKMF5qbtVrl2SogvejMEyy0jBmkMouYEzcKN8WjVT9QAcFqH+1XBsuHVhSwrOOxm78j3x5m5E+EpXuYJh7qItg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841

Make use of the newly-available `Alignment` type and remove the
corresponding TODO item.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 Documentation/gpu/nova/core/todo.rst    |  1 -
 drivers/gpu/nova-core/fb.rs             |  6 +++---
 drivers/gpu/nova-core/firmware/fwsec.rs | 11 +++++------
 drivers/gpu/nova-core/vbios.rs          |  4 ++--
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index 894a1e9c3741a43ad4eb76d24a9486862999874e..8fdb5bced3460a3971699df79ffa2c69f84b2735 100644
--- a/Documentation/gpu/nova/core/todo.rst
+++ b/Documentation/gpu/nova/core/todo.rst
@@ -147,7 +147,6 @@ Numerical operations [NUMM]
 Nova uses integer operations that are not part of the standard library (or not
 implemented in an optimized way for the kernel). These include:
 
-- Aligning up and down to a power of two,
 - The "Find Last Set Bit" (`fls` function of the C part of the kernel)
   operation.
 
diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 4a702525fff4f394b75fcf54145ba78e34a1a539..ebeffc1b1feccc5c4dc08135d8447ec185a3068a 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -3,6 +3,7 @@
 use core::ops::Range;
 
 use kernel::prelude::*;
+use kernel::ptr::Alignment;
 use kernel::sizes::*;
 use kernel::types::ARef;
 use kernel::{dev_warn, device};
@@ -130,10 +131,9 @@ pub(crate) fn new(chipset: Chipset, bar: &Bar0) -> Result<Self> {
         };
 
         let frts = {
-            const FRTS_DOWN_ALIGN: u64 = SZ_128K as u64;
+            const FRTS_DOWN_ALIGN: Alignment = Alignment::new(SZ_128K);
             const FRTS_SIZE: u64 = SZ_1M as u64;
-            // TODO[NUMM]: replace with `align_down` once it lands.
-            let frts_base = (vga_workspace.start & !(FRTS_DOWN_ALIGN - 1)) - FRTS_SIZE;
+            let frts_base = FRTS_DOWN_ALIGN.align_down(vga_workspace.start) - FRTS_SIZE;
 
             frts_base..frts_base + FRTS_SIZE
         };
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 0dff3cfa90afee0cd4c3348023c8bfd7edccdb29..add8cea7bbecc98238d418d0fe6f235c6b850d58 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -16,6 +16,7 @@
 
 use kernel::device::{self, Device};
 use kernel::prelude::*;
+use kernel::ptr::Alignment;
 use kernel::transmute::FromBytes;
 
 use crate::dma::DmaObject;
@@ -203,7 +204,7 @@ pub(crate) struct FwsecFirmware {
 }
 
 // We need to load full DMEM pages.
-const DMEM_LOAD_SIZE_ALIGN: u32 = 256;
+const DMEM_LOAD_SIZE_ALIGN: usize = 256;
 
 impl FalconLoadParams for FwsecFirmware {
     fn imem_load_params(&self) -> FalconLoadTarget {
@@ -218,11 +219,9 @@ fn dmem_load_params(&self) -> FalconLoadTarget {
         FalconLoadTarget {
             src_start: self.desc.imem_load_size,
             dst_start: self.desc.dmem_phys_base,
-            // TODO[NUMM]: replace with `align_up` once it lands.
-            len: self
-                .desc
-                .dmem_load_size
-                .next_multiple_of(DMEM_LOAD_SIZE_ALIGN),
+            len: Alignment::new(DMEM_LOAD_SIZE_ALIGN)
+                .align_up(self.desc.dmem_load_size)
+                .unwrap_or(u32::MAX),
         }
     }
 
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 5b5d9f38cbb3a6b1c374c1e0eee2509eb8d5660c..3bc24ce26b9d4d1948313f808986211facb0e8d0 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -10,6 +10,7 @@
 use kernel::error::Result;
 use kernel::pci;
 use kernel::prelude::*;
+use kernel::ptr::Alignment;
 
 /// The offset of the VBIOS ROM in the BAR0 space.
 const ROM_OFFSET: usize = 0x300000;
@@ -177,8 +178,7 @@ fn next(&mut self) -> Option<Self::Item> {
 
         // Advance to next image (aligned to 512 bytes).
         self.current_offset += image_size;
-        // TODO[NUMM]: replace with `align_up` once it lands.
-        self.current_offset = self.current_offset.next_multiple_of(512);
+        self.current_offset = Alignment::new(512).align_up(self.current_offset)?;
 
         Some(Ok(full_image))
     }

-- 
2.50.1


