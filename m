Return-Path: <linux-kernel+bounces-825769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DACDB8CC93
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CBF1B23FC3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D55E2192F5;
	Sat, 20 Sep 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pK7T6V/h"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EDDA31;
	Sat, 20 Sep 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385219; cv=fail; b=ZTAdqzqFtmX7rLJOdQuqBySi3GwQ+9gvQ8W5XV2M6TfsbclSAY2rp4j+cxIepyMVEjnBjgf8O6lzhKlBH37vjbaPwpoIN0+6fF2Cuot4ZjG4zKXHLr0qYo2wxfjeh1ykSaZiMTMxPxsHrGWBAnC4BBid0gjQFtneJ9yo8IlUSKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385219; c=relaxed/simple;
	bh=Q1C/3XtJO+jHH4vWHZNWWZ0MIm9A2DZeRqFE1GuKMyg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=d/wQLdEG6C7Qa1re+u1324If1Y1gr/9Y5b4cLtw79pL5ncLAJP9M62sWuUWKz0bsMdRNxkh718qXZSVYWlsKXpMSYPOCz5EmfEokLTP//mj4ADx2RwqRCN4WEBbLazmxIYefuiCEQg/+pkTDFe8V7j3syvPIIIE6V7D+m1I2w3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pK7T6V/h; arc=fail smtp.client-ip=52.101.62.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTm0lJ6SrEtegy5IZKdFUjfgaDDyOr5Hjp5ELfUNTsVc1XXH5o4dHslkVLfByL7k4hexrIUvugvNmfQ3ttvn1spJaIY18U7R/9SZg3jFGgz0eHiREDWYfK6j1w9BnnQUNQSz7Wcqbj6XVWkJkFFKWxYPUvEiWZuwOuE6cVJkC12zwKK44RKEplahRIlvqpDTsApmVSDHfWqtvHHV2sigPJNNXDEpwucpjlkNv1gueiKke3bgfurF0yB9fFVc9f/LKibL6tW77cR8uUTBqXYNyyfOvIIVSaWwLMCTFBrn2b2eg1XGqQGdvJSECwh8YqVq9rQaR9zchWLS5lsvy8H3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJBg84i2GE7Lq7p5OCvBoeCiLstZRwB4JBPoNHrfSMA=;
 b=uV6QwwvZPLhVjQ1nlJx2aMSEPTY7sma1MpgSDUgURbsRYgD2HNSxaDEsTsp1uwaTFG9MXcsB3S8g06uo+T+8ffQuXlQ4pWFawH/0wbWYMtdHtRLmBXETFVVD8tH7WoJBNtMhi7HG9AG2QFBgloskx+mabtoP6FECDUWEjUM8AIT2halXDbu6khqOw+iyRqw/VZiJJshU/4Qqj1+Mf9EbJnkYjmUcqVAvVqc4Teh7YoUY263gvwpWsrWVkmlTsuOWM11cDLLpMknneRpgOeXMyL9xuD1qVrYy+W6wfzrDPLnCBeJVIis2bTqlTEBd+GKSKaYIXrCtdxGMGHdHBV7dWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJBg84i2GE7Lq7p5OCvBoeCiLstZRwB4JBPoNHrfSMA=;
 b=pK7T6V/hZE/E04xB9scE374VEGwS5n/IIlY3P3//svimHWRFrbIOoeTuWtd2LIn0Sb1AxSod2cA8bcvsBeh2gcBzB81V0MKC8KnDmqBVxPMgTVqTwI9aHXKkc0y0Cje0iM0SSmjLh2hHkzFwQ7NGCnatNWSozIOwE76PbAkLWv+niYghEC/mJG8bWOafpIXM/I5wWmBfcf+RJSlXKI1WQXPn0yBgxl2civk5aO0tW5+elvA8u+u5x6e+pmKe+RIWbr+ggcjmfUZ+wKqH1Tx4Ga/uiLlKmUra4OYLx+1N0HSJIiruKcjhTu8qLw1b+g6lA+b3NZKW7PDoLX8/i0JQWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Sat, 20 Sep
 2025 16:20:13 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.9137.018; Sat, 20 Sep 2025
 16:20:13 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com,
	Alistair Popple <apopple@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] rust: print: Fix issue with rust_build_error
Date: Sat, 20 Sep 2025 12:19:58 -0400
Message-Id: <20250920161958.2079105-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:408:e7::10) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a02e4e3-ec09-461a-8ec5-08ddf86193bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ifMzqJzpbxc5epNcB31S/ljR9kCYTdtLNyTiHTI/IPrxl90AGiGIfWd0jXUL?=
 =?us-ascii?Q?EMBdzvH21+I54US/zpy89OshKceYG7EaH9GKPKZ9e/6wfiZMD0gG0bBE7RbF?=
 =?us-ascii?Q?RLxSPjHpiP2YiB1qKebPrYGbmwZrLVwUyi4aRtUfSsg/AyGWiK3n/C0x+c7T?=
 =?us-ascii?Q?Uedww0BlfDIq8TMeDw3Sqvyic/6YG+oXFBkmC1M+njLLsH4nsZshI5SmKuFt?=
 =?us-ascii?Q?36hOvLF3f13IY6ii/8oVRIc3t1hnp/+75mmvQQ6Dlj8JaQd6/Sn1sS1f7i9a?=
 =?us-ascii?Q?TPWEqP3OuH1nuptSP49NX/QlMbRxTlV5qJR4uEBQxpTPdGpLEbZpUBtcMGLY?=
 =?us-ascii?Q?H7ybE9yduVIm01Bg6fI0m3n7wRnrX4yRldDsCC8SArhUBPagNDwyFIiAd528?=
 =?us-ascii?Q?0sP09YfAMp9eEv5V8BlAdPodZrvS72XgnaDPb4LlIGn6jIpcVHhe5vy0tF5A?=
 =?us-ascii?Q?YcEqIvwtAEkBAdRl5WlojCfYWOz8s91dY+vPiipFr4k3kxTq2/bvsiyvBLyV?=
 =?us-ascii?Q?qdVg+sVueWKay59nFUmK/RLnsg01ctuoi+7DwaXnYN26s3W55EcfN9KeJjkD?=
 =?us-ascii?Q?PAalVgWlLh6shUBHPiqvYPnwJeB3ifiu55+Y6Z+OyiWW+PAB17mLCDTSTvtz?=
 =?us-ascii?Q?lSRosU+M2dNVvnXe4oWaRgZ7Ojadw4UUTuw31Nm8wOtNibFcR8jn9WbzOhHL?=
 =?us-ascii?Q?3x05ghMl5t2yQr2U4xBzCUWea/Mvakw5srmF/+CkhIYkT06ZXmV14sj7wmcr?=
 =?us-ascii?Q?MAeQxl/EvlCg9s8z0g3wtl7pV/ARZ9wIPJ3yhv7xUst0BaH9CmGCE8MrYfj/?=
 =?us-ascii?Q?McCNXaIGV9/Pc+cQiupD87PXK1y2jT2AYDeiqsPh5XUJaZQEdaLz/ugGdAb2?=
 =?us-ascii?Q?+msDzm4KpWsGclKAlkPqwEYUyi2ngdGoKoIdH2QV1akBkwpHP8aIfjz0hTAA?=
 =?us-ascii?Q?CvubOvAziN20sIZM3ulMSVQRwnNCkwaVe6jfcHZ+SKJ59LLdpGfs0ENgzZxQ?=
 =?us-ascii?Q?xQjdePEMzpl7pX3gdYZtJ7hLNAcPLuXTcrH1ekL/6nPCFuDq8FLQ1MJWG4Kw?=
 =?us-ascii?Q?OFs7QxSAb2tK19SSizgNRBs5yoWTNUZVkS1U602fujNTWcrtOjdmpEK5o8VL?=
 =?us-ascii?Q?vmPu7zWR/gT6wz2sUI4GOUXW75IBJCUXfUC9n1DJjJYMf76emseSASwU6TT2?=
 =?us-ascii?Q?17ErkqzGWi5eAPE1szcGczGKcuy1t7bOY2Xtl5EIihId1Xe6aWsX70fHylKZ?=
 =?us-ascii?Q?qdRiC9phmyfg9WVch+X4MlTkDq72r38fVAHv4MN/0IyfbsNS2VTbJkqHBDDQ?=
 =?us-ascii?Q?OVRiYFEp2j2YpawHEtWbpzaCXs0Xc8H7vl5CEHEwt0X9zWcp+nvDjfVGu2Ld?=
 =?us-ascii?Q?CRfs1Hz/O1UKkq5GIOvNrkW7dR6bBw39rniSYPqswBRYySIv3V9ja/mHzgzB?=
 =?us-ascii?Q?VDNrlKWQ26L8i/7M69IdIOPD8wHpeV/Gkf8Qcpqcz6zjraKvxac22Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FplWEXUl22gYTkPQD8p0pc88+NlUfbVfWNNcAP9cXjHcJBsdHJuwK7GSflFr?=
 =?us-ascii?Q?P+PLAZ48NiwYCgVnCiaZ80r7YINcx8ar9ETtTVUAyXWcrVx9Tn10Is9RMg5H?=
 =?us-ascii?Q?ndjyJ+ubg+p+PFYaVrzmgh3MXfWyZBiT0sMYhO3io9UjhhNP+N2GOJ+p5ElS?=
 =?us-ascii?Q?D0GsWnotei9oNpN1b6vll0/FUZ05ji/yRjy0ySul63qgp5DaOfcKkEPZ+Yul?=
 =?us-ascii?Q?6NeCgzVppwxCoyhuEMrTS8OPmyWa+qDV3Ausldj8j1mfG0nHAOIL3yr6sh7p?=
 =?us-ascii?Q?04Y2z9cxRbGE+AGBCce+JehYNvnED0kCcT7TxOpX7ldFoxWsXNIKvKKnkXmQ?=
 =?us-ascii?Q?tlyjjQzvSeVIXxFF7mYQLVMeuaIyWtFsVn13dKLQBkdPPVT6/yFqod2M6BjK?=
 =?us-ascii?Q?92zXyqD1kN5De6VEG2L9SLzi/LRP6lnhkvsqVUVnCylubQSczIHDh9Zdgazf?=
 =?us-ascii?Q?Y2kb+rQ6nZHPn47humoZXxSEF7U2+a/PKQ7oxLX2+YWdHZqXCj+HOqOyBpcS?=
 =?us-ascii?Q?54nByFeEi+0xiNI8y35YgPT1Ve57XZdYEs0hmSsNKSl0uQ6vDhon5cOf3xnF?=
 =?us-ascii?Q?00sqSyqE5sjn2hi6xyf4h7bnQ9Xn6YNICXsawepIAaymhsLREOBpaVUCrW4V?=
 =?us-ascii?Q?8+m0yy1t6w9gonNIHCXUOhDEhTdKnywvkqFPlsnssnRPYeCWmK5dbKLME44f?=
 =?us-ascii?Q?c//5vPQGGOQvr9NH32k1hLkfG0i7ZqNVzu3lbbDHd1n8knX9pfTSw/spiyg8?=
 =?us-ascii?Q?E9jjLJaXd7aLp+oqfL2vmit2s4HNf46HUWT84ViK02Mx7sCigHNWEFrPkWu/?=
 =?us-ascii?Q?4y4DDIDRYCTVqC55Qfhk14t1jFpIhmZLNzhZeWoGd8uJFlQA/WvQAVKlpy0I?=
 =?us-ascii?Q?HL5Xve4f13qz88IJIpUAdoeQxvUr2+R462Y/lOXgzg/yPUHIwRMGonumhBy/?=
 =?us-ascii?Q?kJWMRnSosyKVX9MScgbXTnWcnjqYYebJjTNh+MUAMXgCXCkybSdgBkoup76F?=
 =?us-ascii?Q?ucTFoE4DKWrAbBk/sklCwNs5ibb0Bc6ZDy+PYYIv1alHe8/+L++mLSgcdBq8?=
 =?us-ascii?Q?bDJ+BC8Kb+uc+wff5rClMZUbUVY2RyzHBVrtwBJJQ+JDqsqynmkzEKTb+WYf?=
 =?us-ascii?Q?IO4ZYnXgvjmFjFOEBeeoycpqqeoMn5AxQ2pzMf71zKNFvkRZ/D4eRe/d4lX8?=
 =?us-ascii?Q?go3mCDNlg5615SWSyNnPjxqZCziCKOr1T7jHsm1QLgB9H31Y/JX4UGiEHol4?=
 =?us-ascii?Q?W+GLqhRTBrkhmLpWV6jLl9pDVoOZ3aWYEqBgMvxoKuKFNqw3Ghwu50V3/4cA?=
 =?us-ascii?Q?m/2knoUP18cOIiPvCMcwVErE9Bk0DSHAG65S8JM+Pq8HIGTiW7oRiZlvmE/z?=
 =?us-ascii?Q?wUsynYOJSdWLwAUrmVsMy2F/+AkwYacC9tU5CBJRetiaZtHZBJg+1LjDcZxB?=
 =?us-ascii?Q?0gm554I92/l1AhzhZgUavxIx3Vc+v10Zn041ErQCG9VY1md+3YyLQ0HkVM38?=
 =?us-ascii?Q?7wlpadJDZhk7hMkRkI8Nih6JhlcvsUYrvbAVNzuI4P2RO7XnoXVaZhNFe9pW?=
 =?us-ascii?Q?FC8LilZNB4Gc8LuBDYX+7AMu4BdNwe4JnxA1SA8i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a02e4e3-ec09-461a-8ec5-08ddf86193bc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2025 16:20:13.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzW0o1Q7M3E0nG3GMKqcRqtlYlyQNB592BN7sVW3hIXB3GHK+By9BIjRFz9lGH+t32Eye4Gq85XtaDJsYCHfEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218

When printing just before calling io.write32(), modpost fails due to
build_assert's missing rust_build_error symbol. The issue is that, the
printk arguments are passed as reference in bindings code, thus Rust
cannot trust its value and fails to optimize away the build_assert.

The issue can be reproduced with the following simple snippet:
  let offset = 0;
  pr_err!("{}", offset);
  io.write32(base, offset);

Fix it by just using a closure to call printk. Rust captures the
arguments into the closure's arguments thus breaking the dependency.
This can be fixed by simply creating a variable alias for each variable
however the closure is a simple and concise fix.

Another approach with using const-generics for the io.write32 API was
investigated, but it cannot work with code that dynamically calculates
the write offset.

Disassembly of users of pr_err!() with/without patch shows identical
code generation, thus the fix has no difference in the final binary.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 rust/kernel/print.rs | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 2d743d78d220..5847942195a7 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -143,34 +143,38 @@ pub fn call_printk_cont(args: fmt::Arguments<'_>) {
 #[expect(clippy::crate_in_macro_def)]
 macro_rules! print_macro (
     // The non-continuation cases (most of them, e.g. `INFO`).
-    ($format_string:path, false, $($arg:tt)+) => (
+    ($format_string:path, false, $($arg:tt)+) => ({
         // To remain sound, `arg`s must be expanded outside the `unsafe` block.
         // Typically one would use a `let` binding for that; however, `format_args!`
         // takes borrows on the arguments, but does not extend the scope of temporaries.
         // Therefore, a `match` expression is used to keep them around, since
         // the scrutinee is kept until the end of the `match`.
-        match $crate::prelude::fmt!($($arg)+) {
-            // SAFETY: This hidden macro should only be called by the documented
-            // printing macros which ensure the format string is one of the fixed
-            // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
-            // by the `module!` proc macro or fixed values defined in a kernel
-            // crate.
-            args => unsafe {
-                $crate::print::call_printk(
-                    &$format_string,
-                    crate::__LOG_PREFIX,
-                    args,
-                );
+        (|| {
+            match $crate::prelude::fmt!($($arg)+) {
+                // SAFETY: This hidden macro should only be called by the documented
+                // printing macros which ensure the format string is one of the fixed
+                // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
+                // by the `module!` proc macro or fixed values defined in a kernel
+                // crate.
+                args => unsafe {
+                    $crate::print::call_printk(
+                        &$format_string,
+                        crate::__LOG_PREFIX,
+                        args,
+                    );
+                }
             }
-        }
-    );
+        })();
+    });
 
     // The `CONT` case.
-    ($format_string:path, true, $($arg:tt)+) => (
-        $crate::print::call_printk_cont(
-            $crate::prelude::fmt!($($arg)+),
-        );
-    );
+    ($format_string:path, true, $($arg:tt)+) => ({
+        (|| {
+            $crate::print::call_printk_cont(
+                $crate::prelude::fmt!($($arg)+),
+            );
+        })();
+    });
 );
 
 /// Stub for doctests
-- 
2.34.1


