Return-Path: <linux-kernel+bounces-887609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF2DC38B54
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CA53B81B0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B87227BB9;
	Thu,  6 Nov 2025 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PVC5+CYS"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0806F224AF0;
	Thu,  6 Nov 2025 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392486; cv=fail; b=PKYI/vvqB/clXkXQhng+uCDOYj5wOHvgNtkSGbrT69AKJ3KP27CEpKMB7zmoXv9mwhwGNl6BsjiHP/hHnhE7MA3g6P9BCXuPFgkiPX1HXItpibkuzqC/HKy2r7i84danJUrb3h68plZLSNdRBEnHYaCjX7W6ukKkClKoSfgxwow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392486; c=relaxed/simple;
	bh=dluyCCejSkWHutBzi3NkSNQbdPMlg4wGqGZ+lcJgmmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PsN/pr6kwo5MGDbqi6YJvcVot6zziVf7NxkE0H/CTBmhLsyjXeP8PICihEgCinCW7QzlQlUwuXfvwssmdkGzd4NQWBXp8ZZpAiAWE9otO2etze7RA/Ie6MsSyI7z+UhbIDckc5eya4OmmleImsHif2IBcq2X6tPLACsH4KgCHW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PVC5+CYS; arc=fail smtp.client-ip=52.101.85.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fq0LwC1UxPqW1DwassXlCM3YPcSQX+OrtdtvpedtQQQZaKlkQh7ScPCjv0oli2/VCVeFwM4/R/ydqXcpicFnUwNv6AyJMLiRPupv1HI65lgOsmCUc+9FBDtMXg93pFRWSJLnrPg5p+n5U+LG/lqzmtCPJMNv81jgnh7xqnEIP3fwWhmr12lYxKY3OGEqw+FtHh6uPEDqDJzEU9C3RMBADQ633EHDTIa5aGLSTXyvwI5OaEEh/88w0jgkZWp23/LJQqlKYZmqxbQaFzOfqvoKIRM00OPPylEeQlLhCVGL3e03Q7wiZfahhs9IJW394Li+gqztJeU4vPVNoZ8rUoWkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIU/mOWkH8J8plevM6riSt4Z98UubFrLUzr4bXTeEDc=;
 b=ZZ5xE4k9gospMNkIN8YFaFcyS4pKIyT3UY0pkRzb/xAHcK08bUyzFVyrny0OH3qMNJFMnWTXXM87MGaRP/QkznRQb64JKpFmYKU/SYzKgZz+ZfSNbZYwmDqVSVOXxyzs0xz/wBO8JpODBSNFH5YJ+lGxRVs49QURAvzh5a3au/JE7A6AUdb8RJb9owCRF+cVATU31BsrauKQS17ilSAiNyQJlUrvL7y1F1UYlZEagYb5wI222W76Cd4qUIQHsFcfdTRGAE3Bu/EcN8YHsaDkuWQP79GXCqrqpK5IjBwzjxl0OZ8sY+pZzdZniIZfUPs4NGKTPRqr8Fvn3EEDlZox9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIU/mOWkH8J8plevM6riSt4Z98UubFrLUzr4bXTeEDc=;
 b=PVC5+CYSH1/63am0/h18XrYPb/nq4ckZamq2FZvKF0CI9wS3Qe/9jH2ff2Yn3+oQUyUn012021OLPo58WVcGhbMli0yge719QVq3LVcOqIDi5O+SMT0drTNnVt7BSOnaGU6imAZhyXG1nZUB+U47ZlWrjvptPneoOqMSYV8iqkF/V4KkGCrJt6Y8iG6fx/66JHVdMaGM99rB+/rUGcBc3W1bKgzxUcEzrKyjAPJ0T40FCCvfhr/Ennz0vByCySSUxH/q935EtAr9yr3wTTDB2ZWOF7lZ9WWAZCDy0NVs6oqxNRv2UJ5WuqU9kSb8bh41G8I4LVNkSKXYh9bpx5Hptw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 01:28:00 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 01:28:00 +0000
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
Subject: [PATCH v5 2/3] gpu: nova-core: make Architecture behave as a u8 type
Date: Wed,  5 Nov 2025 17:27:53 -0800
Message-ID: <20251106012754.139713-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106012754.139713-1-jhubbard@nvidia.com>
References: <20251106012754.139713-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: d333a665-446c-4b15-c738-08de1cd3b8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d2Bbr5cRCClLsq4sfS0RdIw3fDnA4y+7F+HuAYPtRdVcnfREZLjbapQ3XEQx?=
 =?us-ascii?Q?O3Xh8p+IiqZ9bm2tUOa0TmKqhFSavB7MS4zMVVP/9H1sW0pRT+dnSWg4c7JA?=
 =?us-ascii?Q?1BS5c1VLIMZ3jfSBUOC+1UG/BzkbVKSP9VOve7mPkChwdUqrxwrzl23g/wgr?=
 =?us-ascii?Q?gcc78CMVFvPcAk75Aw4bY44R7TYqqlYja47EZ/a0M75n7l2s8fdrx+p3WjzO?=
 =?us-ascii?Q?lgxjHa+UHpIFJYB7mjOT9HSYFnHA4hwGRHocW3XoexYrHDN9N/SvXVm30Yei?=
 =?us-ascii?Q?2iUOeNfxb+qt8aORUKDMvI+yzbOjJUVRu8jjrAIavUmEjfpuD/rRYuWSPz96?=
 =?us-ascii?Q?BEVkTSQnSuWo25RjB+sxbq+sGQI50M52hm8OXHIpa1hTMOwRAT1LxggFGJ7j?=
 =?us-ascii?Q?YavVEOvpShCMuMN+awILAMP/g1CjRTW2tb6NDbBqAGo8wdoDpunvrl9HEwM2?=
 =?us-ascii?Q?BnCS7XvMjNV+0Fr4Z0RYfJRVTtVzkky7RISWYrztFSEB3z/S1lZa11/ultYV?=
 =?us-ascii?Q?G7LPrz3XHwuyHKW/uURwAnyXyI+BGKw6gaVc9bRMUVQkuozoozaVd/L0FvKh?=
 =?us-ascii?Q?UtBU4aNRporqQ2llBcouzH/4G8WA0AlvxZfPEilpWnMjPUtMuq7fONb8+ii+?=
 =?us-ascii?Q?ON9lIKjhzYaM/yuI60Rh+PPBmb5UjqnqWPbH6kYwPhWTNAdpIUEXntDZBNZI?=
 =?us-ascii?Q?zwIcgusARper+60gwXkvg3qQDa5+i0pzsZAyHESR2Xv6hOtoT5/NCpUw19+D?=
 =?us-ascii?Q?HOHgbTJEW3RstsPzDeUD4/mioxJ7Q54JSZ5KJuPQjl5ousMRutQ195zF4cPS?=
 =?us-ascii?Q?fdIIQUX87nS8QRitCS8BpmpRBszpFr/ujkO7nbJn6vYZXBafNReIdBJ/qvb7?=
 =?us-ascii?Q?6wTRUBDi5ZSjWBetkt1+Oifhbw6WEi7P3mpnzH6Nk0HCS6WitVrd29pm6W6c?=
 =?us-ascii?Q?iva397zVOeFaBIsD13L938os5sOdy576nVGzQUt+ZIP9RVwmRnFegbflmSu6?=
 =?us-ascii?Q?PTZNi0j6n5W78gNkMHN/aCLG10zEISFEaO+4USyinkMDtBgVPiv0WgqLbRb0?=
 =?us-ascii?Q?2fk5i001tlveccxoILbBaRDZmSQJL9Xr8u+aQTIyx8v6nhM5YOwr61qq3Z27?=
 =?us-ascii?Q?Eft4hGuZvkO2Mk0k0UQIpiV5s0TJP9i/Dw7T2XuF/+BgFMZ0qEX/j/0Eq5Sf?=
 =?us-ascii?Q?59t/2M2+jOeq+x8csiiTvLqzSQzY55oVs/Xr9e/3KrT0EFGjjqvmUf4WdXgB?=
 =?us-ascii?Q?OM/NZVBySfw9XTKBoW3gU3WXHCwr1JWuuddwX2h/C69tuNyt+2sZ1375g8rS?=
 =?us-ascii?Q?G3JHBOX3hISuuH9gIrT8fy0tg35ru1s8MhdaArjjDv8d9V6Bx0XI/B67WKb7?=
 =?us-ascii?Q?3BnffdLso88IsLNy8zwvqSjfcBHul2N0bGOwsFCMYPaV2KHbooQX8laPNNGX?=
 =?us-ascii?Q?qDtb26KHSmUGUigfcwcKlgnLwOa/6sOJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?akhYmxGRXQp1+znHO/LetfR/ZN4k34rWDu8VZ0WxNn/yw6gPbx8R+oN7nt5x?=
 =?us-ascii?Q?ADNFbBv/7vpfwlLw2tcEw9JJbLaJfDbV7+MiBUsfcfR8IUyJ2vzISbwdbwEq?=
 =?us-ascii?Q?qz617HfzTSkWVr/vgImIotYHC7CGz1aC4WhJUuoFYrVeMVZ+yh+i3WToBYjY?=
 =?us-ascii?Q?gxAsBnVM5+j6a4I4NVXxX9QInHNXT5SNeXPbpoYK++VSwFxyjGZ6tAJ1n6n7?=
 =?us-ascii?Q?u7Rse6GS9N6qVHHketYwM2KDpX8M9ToV5vtCii5ekJTI0P9f0mXZVAV1JajK?=
 =?us-ascii?Q?/m8N1PlgBVfO8gvyLmHapffXEBkRYg1b87cBuDqs9/djf22UeSJjPR6lSYf+?=
 =?us-ascii?Q?YYEpdjLvwIA1Ei2fGQXN2hCS/xxkkZN6mD+5vtoA39rhZQMmDCGk82+DYzFo?=
 =?us-ascii?Q?0O8w+cnJSdfNwwpYWqMz8aRvPBXSfNEDO4xVvRe755Is4YO2PD7lV+V2gqjs?=
 =?us-ascii?Q?ZHXvZE0D3nzR17m2lD9GWoTqGCWanIgPchFf60r+qMqIsGygbVqG7d9MnUxn?=
 =?us-ascii?Q?J4krVoLHpYgSVH5MyChu6GkhgXazYY/KjVTgfh5/sRMPIJLxx/SdW7DA78VS?=
 =?us-ascii?Q?Yp48ei67LbtI+rYwMdXYxrw5xJ+H8cD0CaItDBiHx+zdTlGFxv7y1gya9G4C?=
 =?us-ascii?Q?+dnkwBn1F1Ye4NiNPQ/PRthiwO4rcRlWzlzXP7HgvR6wzNGboE7wktNtOn0a?=
 =?us-ascii?Q?Js8hINN245BXcAvbUCgAEpdgB4ixq6Y3niuXbL4Io0CyHOOK2QuJ/zQtR8cl?=
 =?us-ascii?Q?hXTu6n/zz+4lrZzzLLbNGzkCvg2TPvwXFXYqijBhL3gE24PHFZJMBlorumZa?=
 =?us-ascii?Q?Z4Xzf/6YWhnhk1H/9H+pUWwEIlzhkzOsZdqt0eDovqPZQ65FS4m/JQL/NFsg?=
 =?us-ascii?Q?mcw+BE46Rh5JcPaQjxVtSzbJmQjc3CGpsth+cH81XeVr2lX1R2JrNCqPCJPd?=
 =?us-ascii?Q?C6DjAGlbiJ66uUgNwRECXlVJRSwrocYGMeXgGOng6pax/WgPYj5WqIM445PN?=
 =?us-ascii?Q?KsMsADQ2yqvkJ9GR6+NjP2KtP6xmw6RTaaeqqi+Gig9N0vR/Sa08HZLOiRtB?=
 =?us-ascii?Q?g+kkzK2btp54+Gjr42/+85fkD9MrbBWI4qx0T7VQOLbN/aQwohHA1KHeRU1q?=
 =?us-ascii?Q?nL08kdtPOVyhYr9TZMYNBXM2z3sceOYAJUyoOwnOhi6Hojaj+ogixqfFXmIq?=
 =?us-ascii?Q?3dnXeY549hUCpY2tjpJsvsrUtTPwbRYh/w1vEfV1OfEMneZy5pUlUXs5YByr?=
 =?us-ascii?Q?HBJa5iZCixYNZQxLRhBbVkov7uzufuLJIXvGAVgZXivZy49QLA5s8l0hJh0D?=
 =?us-ascii?Q?96a2pqgCrRTfoqQztnpGYiXheeW1OrHngB7I0LJTq8E1hORWz4L0aW+HZn9l?=
 =?us-ascii?Q?adzkmyPvTa3SN00Y7JqMMAkm8G1MwNjLsEEY1abTWyJ580xMns7mFVWiZbz+?=
 =?us-ascii?Q?k4/duK5ZcPc1BK+wrLie2XGZPI2dtB1BMKElQzx8IojyzVgnsQbtbjm7d0gp?=
 =?us-ascii?Q?LPldq9xiDnJvRNMty3naYejsYVVvOuQOE5mZM1Gh1PTSWuDRatdLJOwELeKZ?=
 =?us-ascii?Q?5AR5R7KOGlqyfUIGIT7i84N6xCT0+3hTr/5BAkn+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d333a665-446c-4b15-c738-08de1cd3b8e9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 01:28:00.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80VwvnyWA2mgD9k9PhDLw2Xl6MQc8ITtDWXnS9FUsL/1Icr25I/9AFyUOOemB945jWWmK9LPf/B+xs8Z4mm3lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658

This allows Architecture to be passed into register!() and bitfield!()
macro calls. That in turn requires a default implementation for
Architecture.

This simplifies transforming BOOT0 (and later, BOOT42) register values
into GPU architectures.

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Timur Tabi <ttabi@nvidia.com>
Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8173cdcd8378..27b8926977da 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -109,8 +109,10 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 }
 
 /// Enum representation of the GPU generation.
-#[derive(fmt::Debug)]
+#[derive(fmt::Debug, Default)]
+#[repr(u8)]
 pub(crate) enum Architecture {
+    #[default]
     Turing = 0x16,
     Ampere = 0x17,
     Ada = 0x19,
@@ -129,6 +131,13 @@ fn try_from(value: u8) -> Result<Self> {
     }
 }
 
+impl From<Architecture> for u8 {
+    fn from(value: Architecture) -> Self {
+        // CAST: `Architecture` is `repr(u8)`, so this cast is always lossless.
+        value as u8
+    }
+}
+
 pub(crate) struct Revision {
     pub(crate) major: u8,
     pub(crate) minor: u8,
-- 
2.51.2


