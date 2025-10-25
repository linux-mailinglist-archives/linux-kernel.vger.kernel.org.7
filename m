Return-Path: <linux-kernel+bounces-869680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F84FC087F6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 03:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89F21C28062
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1921D3CC;
	Sat, 25 Oct 2025 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qlFtWOTV"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C4EBA3D;
	Sat, 25 Oct 2025 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761355456; cv=fail; b=HZtordSWq4HFxG61o3SgbLhsR/t+Nn7HmncuJRSP5BX9dPzY4yippJIwb+oqv2Ji2KZMvtSZju9/GKQSBugUmXO3YHrEZHtCzlA3epv0WYG904ZL3J30cjUJ5G5+lsQqh0JxVF02Dpj/8k5kl9ce9Sgl/p+cxA8cDHCwwJUK9cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761355456; c=relaxed/simple;
	bh=MNV8hyyrWI9AicHiG1tt22jaIuvdn8Zv3c5J186sWfI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R3MJJcYKDskQrBnMveDtAOQlWQhNHzX5UeOBpPnPHdDBlux/wy/UMrh6I9VKnLwR5NeZRWIViegLfSj/nVJotq6OQRIRl3eavd7Ehw+Zq31kV9MPg3NIcaXe/drY/fcn5EcAkLaGEcI30gzVgooqKxgnD+vCs2Q8StbUvSENzng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qlFtWOTV; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtOZiT+PBhhM5SVwTW4MKQ1aZMKUGesmrUZWwgte0wkMqi7pq2toOtT5VVIKP6Y1x3mR0zZqCsi19PuQ/n0huCK4thln81SObIWE96Sid1d/iy+WTlKPMo8Zo0YAn5uN1r07cg7T4VUFpcXnAoRjwoKmd/fQnXEhw/nWBIZP1CrnDo42hVVlbPquHr8W7uGyvw5lcN/qPO7E0aZmRFATR/eI0n99hIHHiO3ghZo6aWY87EHYDKcQN9L/lGvmA4g8Ov0Ipsl+zTyLqJU2zT6HeQbdnUMrd/YkULxcB4jqP2KxCsNn2BtRT3AvlHK6Gsn88ECWLAcSXAriHl3crGlM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2qGHY8H0MFA6UnSOb6nEpS3idAeHhtyhrBJv8/dS7U=;
 b=O4uRLRas6cfM86dZa3p7a+fX59BEJNhlMg4HCimAQV1+Yx4+/BsNy0NncdSJ50Nr5wUgmdBDUmJpdFuahj3yAtL7/aLIVQYPKYaUYPMapMYK3uvlOqSKKi+wQY4jp6mePIm8LJtPRe6+/e4Ut4PffLBEHRzVw/d6XDsOfmtjwFW+IDhwUS/rjNNWOqyAuwH87mbA0TpDv+g4KNNIru36fFHyibbxV2NhvAlfUiiA9svtOtLThTfSxxHKHK2n3YmMcNala1HUcj8c0RCBB18KxDS0Z4+H/zcNdzBO3Iz3D06OFEE8U2L3r8UFrXnmhDDK1lvEqzZIRplhfc4na1jpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2qGHY8H0MFA6UnSOb6nEpS3idAeHhtyhrBJv8/dS7U=;
 b=qlFtWOTVK9U8MZk/Wnzgez4u1XQBn4COx0HuKw80ASQFEQE80SmllZ1I0AtDOBoeE9dcY6kI1EEvwT3Q0k5e/DTzWziCeICkDLh4nKOv2jgihpyYIu+U5tVGadMHOCClLWwHLE1kt8xCf9Zf7IuAevEg8Ff56wuiWtieQPIoM5dRESPC6tsYoiGLiaExVm5A3oPWY+cEywec3lh5uvywW5AgImY51UxlrIeq+mFHD584pfk/vbkkipbhgjXu8dzDRaRFKpIXehZwsIuHA7WRFU/+S89QSEJwjGBf94tU7NEwXfjHOgV8yUchw1Eq1ULFITZRcOQJbiZPw4jHn6Ij+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BN7PPF08EEA05B5.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sat, 25 Oct
 2025 01:24:11 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 01:24:11 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Edwin Peer <epeer@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] nova-core: remove an unnecessary register read: HWCFG1
Date: Fri, 24 Oct 2025 18:24:08 -0700
Message-ID: <20251025012409.577596-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:a03:80::31) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|BN7PPF08EEA05B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0df75a-d369-47ba-78a4-08de1365336c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d81X8+RoX5Uhc8TcjWCi5m1STdp2/vqnnddnZ45qvoG+cJa+1ivTamikIP8C?=
 =?us-ascii?Q?hl8Ks4OdWopofJFfokOix3gctLA3xQW0tB4zoPkATbg/N/0OsByLQnxCti2R?=
 =?us-ascii?Q?LWHYjFBpQFpSd0a7Zqfg2im/fpGTM6iOVpiy5JvEAMBiRyNH5G/EKEe6OIqE?=
 =?us-ascii?Q?NFSWR9L4ZQum8t2anICzU3jS8hMbSqnRK5+jz0LcjDImFJdlM2H0zO/nsmMN?=
 =?us-ascii?Q?eSWaZLrQI2FZkJ6Bj50GX+qo7zKLsGXphSg2d9mKMAPhNbKPIWopExJ69tZ/?=
 =?us-ascii?Q?9s4MUgisgIaT//PIOVEb0ZXjGmMG7IVdDQe9IE9L5LCZRVRtBgWAxou42+29?=
 =?us-ascii?Q?xDSGxBJ64hSo8t6SRq/AIAKvtkP+NMLHLsFhp0e0ZtCMii5ttxAtF0kHnf3e?=
 =?us-ascii?Q?bMQP/0bWrGpF8Xg0/MF8XP3qrxRdw1NgQsrBY5G2i5BcIEo6G+/lqJLTCzYf?=
 =?us-ascii?Q?lVCl7etYzIG4XoZWZx1JV3Umwpq1cOxb4lJEj+qOtvgHk3OCEHLIVYq32mPs?=
 =?us-ascii?Q?B9PK/02d0PvaU2sazzJjkHtsvt/77U9K7saQI3mrMZiV3WVxu+fuS/hxeiS8?=
 =?us-ascii?Q?pO7YHpxKvi/QbUoriKzSb/ErsD7ug7tm+Cq+LQPluiJ4J/lRGtEhuFKmGY2S?=
 =?us-ascii?Q?kMIv88a3DfB+/xuYNt4BHZC2cDBtng4Q1BDOuqMi9/Ge7C8QhamSVCvG4v9Q?=
 =?us-ascii?Q?yaF3nyw2T9d7Mms7K7DgzvbqqaDy1zUWzULDXiR6aYFjgIKOT2rk/0KZmAuz?=
 =?us-ascii?Q?c7WpRY67cFBwx9x9vIDDkN1QLrOq+/QMF5ROc7vqFHz9oqfyP6KunSiDoLc7?=
 =?us-ascii?Q?QcdvWTp2fZ6nVjsJxkc9LY9KuEOZsD4XW/XnzfUbweB9CaxrLizpqhcKmeUO?=
 =?us-ascii?Q?cPT5biUKCrA8Fv0Y4dlfMKKnLtpHycBqgIaPDfvd+wb95FV6TQc6qDnQTJtp?=
 =?us-ascii?Q?+7AtJAyAfUXdD/MxtCxlLvV8rl7sMbbs63HOPoFQzw9bcpIL7TWGQ4LskX8u?=
 =?us-ascii?Q?+uJkzLS0tekJb6ob3UrMZR9iVRdNxWCacszfigje3Cnru6gBpbAIQ37pD040?=
 =?us-ascii?Q?1IbyoCVCwK3ZKPfQNK8SZJBhiGmpFvdYv9we51AJt3EfEPX17ITOLXJnWiG+?=
 =?us-ascii?Q?lC4UchuDa/+LepX2PdkIdQUtkY6zDMG2RoSplHzd2vsbJ1GEOEHD5UPbtql1?=
 =?us-ascii?Q?U7aeskthelZJ8cH01GO3G9RZp72iSOmLWOe8BSRv35mUTrVY3BDVHzsxSv3A?=
 =?us-ascii?Q?2VF/OvYFxOXienDDfCSLTCZTVKXwt9aJ5+1RGYn/VQP1haEwi1shNRkBhLpC?=
 =?us-ascii?Q?j+A0lh+qwOajberTx98Ej3dC9bOdV8hwvgcTmRFd01ELrV9WuEwXcuGOhB9d?=
 =?us-ascii?Q?/W6g54eKIAGR6Xvp3z9iikXPTxENABjPrrM93pZfBJ3Rw8GrbYBhn2z6aAro?=
 =?us-ascii?Q?ua1OKF6R16poY/S4E0tHuoXV2EOqeA9o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qMoCYAkcrY7HFnygNWfNZZEne/i2RIg5jG9+JCL2kw2WS/qsF1o2h61JNLF6?=
 =?us-ascii?Q?OFFYDKJeBqlC+ZHK6mPIAiIh1VG2qxRVWeOgjyGe95hRNjj1isRFSQxcJ4rZ?=
 =?us-ascii?Q?BbEYwX3Pls9U20WGKUU4VUT6PhWoGjAyS9TdTEUPWxQAnUZy/8//jZVJDjXO?=
 =?us-ascii?Q?0oTKB+cxLqNNZfBNvVAByqtEU//YvQBu0Few2+2toSA6svS8TyxrZn7Ypc/U?=
 =?us-ascii?Q?wrLOcOAkbKO7hs57Qs2loRo/cmapnevYR+NQuh29J7FIImr3WbKSBjtErc8s?=
 =?us-ascii?Q?aLaqwyhGuKijAPFO+svrLz5v0KQP69vkQ1gMEcT9NeRBb6JWC0sCLLIywJrK?=
 =?us-ascii?Q?yCJQ3gtB82XNR9HI2gRXQdHCBE1fefPouIlX3+IKl/LtEpUgtZSuIduZYsN2?=
 =?us-ascii?Q?JlbStvpEoxksH/BcT+OVU2r/OblxqgU7nwu/ELRYrfonCInKLViE9wp5dkZe?=
 =?us-ascii?Q?wn+a+BIqM9188Lx7Wqsa0RPrUoGW4f0rJ8mku6u4mJ7swfagjvriAR0DKNBA?=
 =?us-ascii?Q?CzwtDiGs3JKIygOOCFK/WYHf1n+QQyjikFgQjpZr1vMDE4FgO2tCCWXzsEwU?=
 =?us-ascii?Q?B3hkpwifuxsMJ1edn8ItqKDsc+p1TZwbiIxBG+SXUPbdXqrLisghZ73zvJZP?=
 =?us-ascii?Q?BSaUj0TzpKwC7HcqbNekpsKGOFzJH6Sy7t1e8u46J4BlhFXk9ngjqunjpPCg?=
 =?us-ascii?Q?bBbYggGbIGz2HX1kaIX3ZFdk9UghnCFFNcbA4YhjmIO9TRl6ljwnOe3DY8ik?=
 =?us-ascii?Q?XgE+Z8LJocHqPKRyp9bFni4MNkdrdUyqXlzHRrf35C1KB7l6UguvyQIghlqR?=
 =?us-ascii?Q?x81ho3aY+qZkjkxStkBYcv+M1NX5JriBCjt9WX15mbpVQDnJCNufZJBb1hEK?=
 =?us-ascii?Q?i/In5MJfFz+NjSAJk8JblQONSVTjBIL9jhyiV/N/UW9QKX99r6lZ0fvQK2Cb?=
 =?us-ascii?Q?ZKNkD/xjsvTk0ksd2qtS0TWxy49q2ZdTvTvrLVZB+pM/qAPOmDsENEl+Kvmu?=
 =?us-ascii?Q?jY33Ujk0cQXRVPFZMMLK0cjgN8KXTUYoZf0oAYI4cbSVrb9P08OihxANKKl2?=
 =?us-ascii?Q?48Q+2hHQ353IgAZA33Tdzv7AKg/dQNyarDtZMcMees4xMj6atwU/WuFJfRZM?=
 =?us-ascii?Q?Vzw9/yfUKet44b4HM450SsnFZVUcDMXXxSBsvJYEwfQgVSrAlr+c/tzX7u5T?=
 =?us-ascii?Q?2DYISlVaNFvPLfbnkQnjk/RYkEHNlaFUKLdcN8c0UzhEMtvPS2dXU6FJkOBz?=
 =?us-ascii?Q?6JKDNFa3KAh3Jlb+KY9fOt7T+D5sp8rxbKpjUbcI02ebscbXyoswRrRCMVhg?=
 =?us-ascii?Q?L5xAkqLtgi10yDeNuPJoA/wbtKQXKHLzMWDMVYNAbBNpYU0n8mBzswzy7/9j?=
 =?us-ascii?Q?TXSlfi/imIqwWM+QfkI90kNud93+TI0WEvKSN9dvzQUob5Y7SeXR2QPmWOdA?=
 =?us-ascii?Q?noXlIEcij2ZXjMRS74lww0ow3dHeKZglIrGV9Wy7g6zeQdO1Ps+e6+mGl0/e?=
 =?us-ascii?Q?cOfS3TVu2peby0HuUZtGDidDsYsIPegyhTsHO8ppyfOhwwRD+aqHI5U0ERaE?=
 =?us-ascii?Q?iCwCRolfiOA28DN77rcwfZZ/rEUtiZQLaYHIvq5W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0df75a-d369-47ba-78a4-08de1365336c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 01:24:11.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N1cb9LkdUgPpMMj56gPz+/+HaDtC+sF6EUoCJ2h+cSbppDdKu9lc6UKYdo8z+7E9m5YTL/LphpJa1KaCVaWYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF08EEA05B5

This register read is not required in order to bring up any of the GPUs,
and it is read too early on Hopper/Blackwell+ GPUs anyway. So just stop
doing this.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

This applies cleanly to today's drm-rust-next.

thanks,
John Hubbard


 drivers/gpu/nova-core/falcon.rs | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 3f505b870601..ac55cbc5ac1e 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -371,11 +371,6 @@ pub(crate) fn new(
         bar: &Bar0,
         need_riscv: bool,
     ) -> Result<Self> {
-        let hwcfg1 = regs::NV_PFALCON_FALCON_HWCFG1::read(bar, &E::ID);
-        // Check that the revision and security model contain valid values.
-        let _ = hwcfg1.core_rev()?;
-        let _ = hwcfg1.security_model()?;
-
         if need_riscv {
             let hwcfg2 = regs::NV_PFALCON_FALCON_HWCFG2::read(bar, &E::ID);
             if !hwcfg2.riscv() {

base-commit: d3917368ebc5cd89d7d08eab4673e5c4c73ff42f
-- 
2.51.1


