Return-Path: <linux-kernel+bounces-827124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54314B905F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E310F42042D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763EF2857FA;
	Mon, 22 Sep 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="csuvUjVc"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBDC30595C;
	Mon, 22 Sep 2025 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540651; cv=fail; b=WCYg2T1yrp3GtRuVgBxMduhxo4R25kPedsQ6effIdFSBYuvHNVM68jmjx/Ju2/fl8pqoBDXtjFW8111XrgmkMsXLHAnqTxKJNs+Sm8HsvVJsyKJyiSM9FUGyxLjegdeqQozM03K0wc+gpjrEx4HA3rHg0BV6co7R3biVQVY4ZZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540651; c=relaxed/simple;
	bh=wf/vv2kF4m7V7e77AtkJo+nF84vtmycgqIz++8oktjE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jktf23n6vEWtng2IN3fq+C5G5mwifh9t9wNyTPgZGBrgWzSGpUtLknn05D0bjHsH+DsdFTkirjdlK5q0q3wf8UyftO2jbDzEzhAnxZrKrAiUYnBAq29Ehrcc61Ple9Fb3QjaNcnaMiBuYR6CLDr4JX3sRkTL7+1HxSKIpWpZsKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=csuvUjVc; arc=fail smtp.client-ip=52.101.52.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INT19EJFMZV64AHX87FKYLt4WlS2kksi7OF0tsWBvQ7TVLrjLswliQP6pemBaRACcX5qoI726qJuMKFyF3K4E3vR1mOr/JRw9QDkGt3Xsl0+KfvUU3nONQM7prgLsV/367Ri/Gbc2s4sKfFyYL56s9RzUTPdFSks95NPJua37sItQuO1diLNZGUelaZvQwrG3rd4/Tuh731JjGj1MLwdYT9esxvC3kXVIvVQDND6Ptdq4nPDKca1TwZhjFVZ7zVOtGATiuWLVSb3N/v5lGCDmc/6FBDRn4z0r6tlYECgt4aRlNc3NX7VKIaZ5Z4EJ1LWRjuOW2ZtrjfCq0HfaIYOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUZeLpKJ0hDdeYH3x2AJo++6pI7AOBgmO6M7yv/C8HE=;
 b=klNZLwBB3SA1LUvxkIZ3xcQNFK3EFoLHP3vs5S9cOWY1VBbF8nhuQYzJ1YCVUTiqoE5zFvEUT5FxGiVv29B4QLvF1bpOlsTM0u3THAouWshi8aaUtHgOJti3VCgDdWt7mTeiC5qLc4eT3/H7TmmvgsTE9WK6Y4MKgjQmPZDlEoe89dW6gbqOOHf5ABzYPlRa0wb8WyR9U/Syh5CQEct/4rq5LzypQpuu/Oj7KcDbzGKTbKiXH6JZvV3Aki4iAfF+yog8u1/Z2UMm9kenhTdIM+zlz0DgERVepxpJ066EfE+26m/IfA1Jij2Mimb4Um1PZ09UThvK4IV1ZziCJxKizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUZeLpKJ0hDdeYH3x2AJo++6pI7AOBgmO6M7yv/C8HE=;
 b=csuvUjVcCm/o0nuwMf6fLcWrRKwmGNC/+8MZP3jUT9PK8yAAZoaATBAAsrvM7r0zWqxyZN6AkafR3oMs0tzF7eBTEztSTDeGNHjR0ga6Rax6jpKNW/dySi5zmuzrZbFViZdkwEs18/vMdYDx9eQgwX2oHteSg9dDc96n5n5tjzJeKrAd6pKa92jQPS7R4AC+RZbXNzB2J9g7ciwQ04sNiw7q1sx15b0b7WrhRB19+AGKTMBn2VLEEdtlriSwIOjapXSE00vdBJ/2qsYU9RRJxupMrL65qY18zW/GEKVlnRpISqFXX3eHMlCSRimDHLCIcDb/JswfITrgUdbfPeg/Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Mon, 22 Sep 2025 11:30:44 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 11:30:43 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	dakr@kernel.org,
	acourbot@nvidia.com
Cc: Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org
Subject: [PATCH v2 00/11] gpu: nova-core: Boot GSP to RISC-V active
Date: Mon, 22 Sep 2025 21:30:16 +1000
Message-ID: <20250922113026.3083103-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SYBPR01CA0162.ausprd01.prod.outlook.com
 (2603:10c6:10:d::30) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: d11800a0-9a72-4467-0334-08ddf9cb776c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um9ZQW9qWmtoMG9xc0ovSnZITGhZMlY5QUVpMVBQTU1FQWVCSzI4RXk0M1g2?=
 =?utf-8?B?SWlKU3B2cFhlQVV3M1FnU2hkOS9hWHFyQkM2MVIwRGNFcDJVR1JTRmJZSFVI?=
 =?utf-8?B?WEl2K3dZK2Zrd0tHZVVjWGxaTmlsRFFuRHA0Q1ZmV2pLbTg3emorak9WbG5v?=
 =?utf-8?B?U0xhWk5PTlR4dXV1bTUwOXl3MlFIbmRvSGZtR2ZVSmlzdWIwRklmM2p0MHdj?=
 =?utf-8?B?Z3FlN1ZsalNaYko2czBwM2FvVDRIdXV1WC9jczZsZzRDR0tnY0ErVy8vM2oy?=
 =?utf-8?B?SG5aelNveDduR1I0R3ZCK3doZktPYVdXYlc0M1ptTS9HdTJkRzQ3VTZVNHN6?=
 =?utf-8?B?Qy8xMEdKZDF1Y0RJVk9tNmFDUWRiRkVEVnVuUFp6K3pxZVp4Ym9mWXBqdXJ2?=
 =?utf-8?B?WGgwSzQ1V0tkTUdZaWFDRTJCd1pyUVU1aFAxeWluK1QyS0xlMnkwYnp1UzRh?=
 =?utf-8?B?YVhmNExGQzNQaUg0dTNVcnd3RUx2WDVRcFhEUHhTSWxJNDI0QjFVSncrT0F2?=
 =?utf-8?B?YlpvTFhmQkdLelpqbWwxWnVKY1ZIZkttUXBZNHdKcStqeXFISXRKcGJNekxG?=
 =?utf-8?B?NDZlWHFOTUhDUFhQVFNBMk9EVzF6NVV0eFg3dkEvS1N6QVFrR2crL253Ky9Y?=
 =?utf-8?B?bUJWNDdTL3UrWFAvdDVYRzRkaU92RDM0UklwWWlFSGt0U09WSFZSMVhkd2NI?=
 =?utf-8?B?MGNmYlJObEJYdHRxQVovQklBeGNzOUJWeGkzNlVPZlhHREV5ckh4VUg3SnF1?=
 =?utf-8?B?a05HWEE0Mmt6MFJMQzVjM3F1SHZ5Q0FQOVJFZEhOdmxyQ29ZQ3hrOXFXdHpB?=
 =?utf-8?B?YnkwR0JTekgvMEtkemdLSThiSkxCNngraEhUeitxYS9yekVFTVhKeDQxZHBJ?=
 =?utf-8?B?d2xTVHBUbFdkNjB0RTdyQmFiVkMxM1dlTGZhN2RtSXpIUFFqUGlPUSsvRFd0?=
 =?utf-8?B?K1NpaDJMVXBVaElRNlBpeDg4QjIrR21BeURXZHFTMU5xYzg5RG9GYWg3bWFk?=
 =?utf-8?B?THNJM0tHNnN1aFd6dXNPMUZ4bW5MNkR3bEZ1dHpjZ3E5TGhYYUdmMWtXZHlR?=
 =?utf-8?B?QXd0d29OeEZmYk5XMjRzWEdPcFFyK2ZQQndPOUFqMG52Tk9abVB2c3dzMWxs?=
 =?utf-8?B?dDVnQ2w2c2l6MldUdUxpVm1WZVVFWWJIalFHZ3o4Ni9OQTZiaUpOdWpGM1Ra?=
 =?utf-8?B?NEE4akJ4MkRSTEF2MVhiek1qL2xNT0Z0MVlvV1FzbTdGS2d6emlhdEgvT1Vl?=
 =?utf-8?B?MGNrYk5uTnV5cWxTYzA0UTRTQithbGV5QzV2T09aUFl0OHd6enl4TktzSHRU?=
 =?utf-8?B?c01vN0NPRUlISzJ1VDdVTWhGTGhDLytKMVRWUGduaTZ2cnJsOHM0OWkzV2Mx?=
 =?utf-8?B?aTE3UldrS1dxRUVSallpajV2SHpGU0VGOTgrRmJHdmZtWUoyTm5SbytXUWU2?=
 =?utf-8?B?U1M0VDl5Qng5QmM4K1JDMmlCcW1lRUlXeUdaMkxBN0lmSU03WlVBaktVd1Y1?=
 =?utf-8?B?RUFaOFlNNTlIYXg4WUpwdXVPUlpYQzQyejBSV1NlV20wOXVJam44RVEyb1NC?=
 =?utf-8?B?ZkpSNnFwdkpZbGYwc2dOMVo5eVI3Q0NxT0V3RzFWdUpQbzdJV3NDdGphTGdu?=
 =?utf-8?B?VjlVbG5rdEIxSnNsTXpUbWdyM1BaUUhIckdkOW1aZTFkZXgyeUYyNzV3STV6?=
 =?utf-8?B?eHlKSExuTHVKRE5tNHpoV200WTYzelh6OHBhS2JxYjhpRkh4MHdZQktzb2to?=
 =?utf-8?B?SGtrdFNENkZaTGs3WXVCY3N4KzY3UXFQdW8yTmUvTlZaQjNhelBHMXZEZ1lW?=
 =?utf-8?B?VjI1REdhWDBvUlpwYTZYSXdsTlY4dVZBMVRIQytHSmgyWktFczgvcHpDQk1L?=
 =?utf-8?B?ekYya0VDRFUzM1RJamRIWUgvOHh1bWEzMXBOTEJ3cXpITmM2NVAyWlJ2Wi9P?=
 =?utf-8?Q?ZfkOI8TtsJYRomMw3HP1upAjRnM/BN81?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmFJWkNpUmRveHpVcjQ5Q1hvTzVBN3BrTThVOFcrbVV4RTErb09GcVVSTElr?=
 =?utf-8?B?ZFk5YWxHaG1YRVdHaG8wbVRzMERYU0tyeStQL1VqZHRTYzZhendvQ2ljdEh3?=
 =?utf-8?B?aFRKZEF4VTNKQXFOTUllNW54eWwveFNLbmxXWEU4NEI3by9SZ0MvcHlSQXdO?=
 =?utf-8?B?VXF4TVdUUzBVZnhJNEpVdi81K2xkQmpKM2U5Q3JPa2pmNWk3enBIMjRJSzB0?=
 =?utf-8?B?c2k1OElzQlNTYWMxZkFZenVpZXVIZHp1RGdkd3B4aVFuSEFzQy9lZEx1MzB3?=
 =?utf-8?B?cFd2LzEvbkJLb1hFdjRjdUhidTlwMWJWSE5hQzQyWjlzdE5RM2x4WnA3T0lZ?=
 =?utf-8?B?S25pRVVBQ3huQ0xVd3h0aUhuZ29MN1YzMStIaXpROFlmbkhzOFo5R2tOR2Rk?=
 =?utf-8?B?VGY0SWxnb0xMdTE4K3JKMDh0L0tjUHVXaFJLUFhOd0xXMWNoazBUeG9hczQw?=
 =?utf-8?B?czBNS3piTXBKdytTc3JtaWpHL0hESDRmZjNuYmRJTkZzSW5wcDlNdy9xREVY?=
 =?utf-8?B?d3IvcFh3VlJvNFRlYVh1R0JKZlh5Y212SjQ1Y25EV0NoK2Z3M3gzcmd3c2cx?=
 =?utf-8?B?WlAvdDEwNEVEc2pZNitjZXJIYlNVaGRrc1RDbkFxamZvV284djhTbm1IUnlz?=
 =?utf-8?B?NzgxQ1lTMUcxY283MFNyVDdMNU44dituRkh6eXJYZTlRbDhnK21IblRZUjhk?=
 =?utf-8?B?WHVaYXRDNUtOK3UzWUhOeERucDd3c1FYdlFyVGZtY2c2R0Y1U0o3T2FwUXNQ?=
 =?utf-8?B?UHRrOTJEa21GV3VQUlJSOFFhNy9ZdFlJZEJmS1lTRjJrQmRNT01tWktoZ2Zr?=
 =?utf-8?B?M0VaK3BpL3BnUmRxVUxJN3ZPQ2w3anFXNm4xRkpBbCt2NkFacWxIYjVkMk1T?=
 =?utf-8?B?U25QMFNqRFJDRUdZeGNOS1JEbmgrYzVOclh2ZXh3d3krTi9vakhYRGVFTlVk?=
 =?utf-8?B?UEFRYTFvbmVCK1JoSnB4TCtnOVB1bGZCaCtQaGE5a05DUXpENmJBYyt3TmFp?=
 =?utf-8?B?a0sxWThsSmJCdDdxcW5vaDQ3ZXY5elBPV1owb1kzMHFIZ244eTcya3ArVGhM?=
 =?utf-8?B?RzB3c044R3BPbVdpT05zUGRxT3dRY2xzeTRYMERWU29odWlRTTBUVkQwWWVa?=
 =?utf-8?B?VElpM09aZUlLaHcxcVNLSVdHS2xUU2c1M01DYmlIRXRub1o1eEJVNytqeFh2?=
 =?utf-8?B?SDhZR1dkUEtVeUpxN0ZVWUEyVWtTTWJ5c3lydGo2V2ZoaFREcEsveThyOHVm?=
 =?utf-8?B?VkJyUkd6dk1XYzUxNTdNbTBlcmltTWJneFZ0UEFCNTBBZU5VWDJKd2dCL0Zp?=
 =?utf-8?B?SUdqNFhpRHJZZjFLUmY0M2wrcW5zQ1lMcG5tUVFRTllrTnZkOTV1UUJHTkRV?=
 =?utf-8?B?dWNhRU01N29oN3c4TmRwRVkrWEtvZFVIcUJ2REMrbnVYaVRNTmlGbk8wOWhi?=
 =?utf-8?B?QzFJYVNQSDJJZ1pCdytwS2VpTE5TVis4VTZhdlNYcVdDbkJ2WEs3M1cvVGpX?=
 =?utf-8?B?L25sb281dGxOR3E4bXNLS2pCRk43eCtmVkNBYXczU2NqaGYzM1FZbDZWRitF?=
 =?utf-8?B?OG4vRFJZN2FQa2tFa2ZmMkllZmYzUHk2QzhUU08rbkZFVkhzaG44aGpaYzgr?=
 =?utf-8?B?V3Z3c2l6eU4vd3psRkgrdUEzV0NJVWd2WXdMWEZZMkpZTmxBN1RKOEl3NG9L?=
 =?utf-8?B?M1BGQlVheURzaXRUa3VVWVFXM0k0M0V4WVJTZ3NrR3RybTQ3OE9ZTnhCbk1C?=
 =?utf-8?B?THdkWmVhM2NSeVpYTWtpR3BMSytJRHNNVnBRcTBXNHB3bTVxbU5Rem96N0xw?=
 =?utf-8?B?QWlxR0NFUnYrM3lKN0sxZGo4ZEd3cHVXc1BYYWZBKzJXN3M4bEVLZTI3MHhz?=
 =?utf-8?B?cGREQytPK0Q2TjZ1eWxMMUhWR0MrcHY4bjhhMEhrLzRKTFplNHI1bjJtUWVK?=
 =?utf-8?B?QjlsQ3pXb0FsZWl6V0NBSEJTUXZCZldVallHZEdMLysvU1JwcThPQ3VYVHpS?=
 =?utf-8?B?OVRLbS9GdStUbTJTd1ZqbDRyc3p5eDlYVXRTaWNGbHI0UFJPSkNDUGZVUkNt?=
 =?utf-8?B?VXlDYVdCZHBFTjdTTE82S25mMmJIcEJ1SUo2amE4a3ZwcThhaURjUnA0M0t2?=
 =?utf-8?Q?WlGqQzbCb2HzukTcyGZWhcLAQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11800a0-9a72-4467-0334-08ddf9cb776c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 11:30:43.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ynh2uY029FppugsqQlxOp0pJEYCzZeZxem/ETArgYjpMXipAp5oMcFZ9sAonwS448fwOmGBvElmcNOMrG/drqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679

Changes since v1:

 - Based on feed back from Alex the GSP command queue logic was reworked
   extensively. This involved creating a new data struct (DmaGspMem) to
   manage the shared memory areas between CPU and GSP.

 - This data structure helps ensure the safety constraints are meet when
   the CPU is reading/writing the shared memory queues.

 - Several other minor comments were addressed, as noted in the individual
   patches.

This series builds on top of Alex's series[1], most of which has been
merged into drm-rust-next, to continue initialising the GSP into a state
where it becomes active and it starts communicating with the host. A tree
including these patches with the prerequisite patches is available at [2].

It includes patches to initialise several important data structures
required to boot the GSP. The biggest change is the implementation of the
command/message circular queue used to establish communication between GSP
and host in patch 6. Admittedly this patch is rather large - if necessary
it could be split into send and receive patches if people prefer.

This is required to configure and boot the GSP. However this series does
not get the GSP to a fully active state. Instead it gets it to a state
where the GSP sends a message to the host with a sequence of instructions
which need running to get to the active state. A subsequent series will
implement processing of this message and allow the GSP to get to the fully
active state.

A full tree including the prerequisites for this patch series is available
at https://github.com/apopple-nvidia/linux/tree/nova-core-for-upstream.

[1] - https://lore.kernel.org/rust-for-linux/20250911-nova_firmware-v5-0-5a8a33bddca1@nvidia.com/
[2] - https://github.com/apopple-nvidia/linux/tree/nova-core-for-upstream-v2

To: rust-for-linux@vger.kernel.org
To: dri-devel@lists.freedesktop.org
To: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: Björn Roy Baron <bjorn3_gh@protonmail.com>
Cc: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Trevor Gross <tmgross@umich.edu>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Timur Tabi <ttabi@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Cc: nouveau@lists.freedesktop.org

Alistair Popple (8):
  rust: Add several miscellaneous PCI helpers
  gpu: nova-core: Set correct DMA mask
  gpu: nova-core: Create initial Gsp
  gpu: nova-core: gsp: Create wpr metadata
  gpu: nova-core: gsp: Add GSP command queue handling
  gpu: nova-core: gsp: Create rmargs
  gpu: nova-core: gsp: Create RM registry and sysinfo commands
  nova-core: gsp: Boot GSP

Joel Fernandes (3):
  gpu: nova-core: Add a slice-buffer (sbuffer) datastructure
  nova-core: falcon: Add support to check if RISC-V is active
  nova-core: falcon: Add support to write firmware version

 drivers/gpu/nova-core/driver.rs               |   8 +-
 drivers/gpu/nova-core/falcon.rs               |  16 +
 drivers/gpu/nova-core/fb.rs                   |   1 -
 drivers/gpu/nova-core/firmware/gsp.rs         |   3 +-
 drivers/gpu/nova-core/firmware/riscv.rs       |   9 +-
 drivers/gpu/nova-core/gpu.rs                  |   2 +-
 drivers/gpu/nova-core/gsp.rs                  | 119 +++-
 drivers/gpu/nova-core/gsp/boot.rs             |  69 ++-
 drivers/gpu/nova-core/gsp/cmdq.rs             | 430 +++++++++++++
 drivers/gpu/nova-core/gsp/commands.rs         | 140 +++++
 drivers/gpu/nova-core/gsp/fw.rs               | 255 +++++++-
 .../gpu/nova-core/gsp/fw/r570_144/bindings.rs | 577 ++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs            |   1 +
 drivers/gpu/nova-core/regs.rs                 |  15 +
 drivers/gpu/nova-core/sbuffer.rs              | 188 ++++++
 rust/helpers/pci.c                            |  10 +
 rust/kernel/pci.rs                            |  36 ++
 17 files changed, 1857 insertions(+), 22 deletions(-)
 create mode 100644 drivers/gpu/nova-core/gsp/cmdq.rs
 create mode 100644 drivers/gpu/nova-core/gsp/commands.rs
 create mode 100644 drivers/gpu/nova-core/sbuffer.rs

-- 
2.50.1


