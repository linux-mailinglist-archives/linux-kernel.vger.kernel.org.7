Return-Path: <linux-kernel+bounces-812862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C60B53DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D883AE53F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C442C21DD;
	Thu, 11 Sep 2025 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R0GDY2X+"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19027462;
	Thu, 11 Sep 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626324; cv=fail; b=QQdm4Xa2uwd7gKLale0Ih1ww78nQ5v9OY/GWJvkAp54kr5TURYp3lCRLDCFg8G5gGu/bOFOcdHjem1n/irHvAee3SLWQzMJDr9vXbOwup0GR9j537m6VX6sNoNDSWUiNRCXWGpzz+4ekvpgmFBmioH98duLkEcyU8gkH/Bg4m44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626324; c=relaxed/simple;
	bh=B99RPJecjuy/09FpHBOVqBnyzlXEBWxkMRqPh3E4VA4=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iiqnB1d10Cx6CIkDArBfCi2CNqZfRFLEI9/i7sJzUMYijCOpSM6pHDJhBlTvz8G07xwRp68dJxo1DDwNCw02H30kTBLZuOT+pHX9LmffaEp5KGXuB9RjDQfmWDvQuOx4+aVcIH5x2ORcZwOWPkgq8ezOhyuizNxWV5qSGNM6KyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R0GDY2X+; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rt8AWnLbqf8xQR5Yuf1ZAQRXLS2q0kaR/zTv2A5A094WcW2zMD29g9wQ8lyjAsTZ14ouebRNCxbbUgxx//Oz7kgCDAnHJ58uPRnyPzLHVMnDJT9Rvsu11qODlN5C7vQG4v+qOj/Ds/LXtHQXfhB+oBGJHXFwMTzxeZ2CSKu5//n2XgqLEh8P6Cr71Wo5YruvqFvMTliS5bImCedEDCyWKSPsmYPSfDmvG5TiyPrYok8di5zzvits4zb0ySm+hipARYskJ0JsR1Le94NbRgN3elgsiEzztFDfuOp/iE69YRSh59TL+v4qTBraaJSnO9Oyi+yx/nRNT41WY87glipdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoyhmDDi1SSovqVFiAvpN0/H5vZqC6XUPhMEKxF2SuU=;
 b=G1I+n3kW4GJkvJX+HDhWd/255zV/WKriXIRL84CD0o0ERE9oDriCWxKK5wZLNO4hNiDoR4gnscAMkdXyo/j6sLxkSIee5R5xHSUvQG5TlSIoKm6Wk+Wz/htZ/p3mgcoZUjzPUvVDdggzlJXuu5/cITteyOSzL8MbDIAXzGWnk8GV0zA7w3ztJQLmGTF0xaOs/iIw32b3QYor0ypPYxSGn2hE7yjPZcITiXCEv7swXcaSjg8xNCgQRYxoOy7RGPBKKpanDurjhYKrNy8Oo5KArmRTr0HQGblklyzFul+3GHno7Y405bgy55igAJJjpHfCGv5Or135vPjP9N3pOji2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoyhmDDi1SSovqVFiAvpN0/H5vZqC6XUPhMEKxF2SuU=;
 b=R0GDY2X+4CEa6emIf2t12uxRkPQhPgzQ6SehiMxkFaRAHo1ddep3yu72iPIgXvtwKBcdw28W53P17OPpC8UJnrVSwTqvhivSHg52ZFqzeJ7SodHB989CU+L8T670yHM0P2oqHBOksc3hfIZYsozanghy7cBBTg0GdPBfWlTX8OAfD3CtNR/8GtoQuBGx8K6hrYa7pmTU9/FVZHC82YXdYa1oNfVpO5PM9z/OoqauPCX84Ri7yjfKcNXFCAEg+0tMBmt0RaGCBDvhHKQ64Dmfs3SOglK4y1GP4T0Cw7jo/Msh2cJL5cBvXyVJsFTIM39UPYt0lLXwExOeWWtLLodTzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 21:31:59 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 21:31:59 +0000
Date: Thu, 11 Sep 2025 17:31:57 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Printing with overflow checks can cause modpost errors
Message-ID: <20250911213157.GA1039411@joelbox2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BN0PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:408:e4::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: f9581aea-21ef-499b-d919-08ddf17aa3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yVjvhkZro4Y3MfdpPtI8DX3/p4xzRatuYYctQzywEcvLCAHDBpzOBXYUeWnc?=
 =?us-ascii?Q?DZQVddeYPigLdTbJ7HJ9Vg6A08+gP4NFyaKz6oYkUmX/zF/MlHAyMUuxASnn?=
 =?us-ascii?Q?o9OWTGI4ObnqltZm5AeeAfADac0UNLD3EGurR9vY4yL/mki6IWn9UQLFLBKO?=
 =?us-ascii?Q?iQo6Gy9hzioTcBeqUeOvppYJQl69mcvTy66AaMCh0pDws53Xp/Dfwic1pxmI?=
 =?us-ascii?Q?QCJG5JFA2jNEEvxFRTUTovCTbNHUSDhMgJdJ+vH4FLgRGoPW0Ahk8Wcj4/Ng?=
 =?us-ascii?Q?4XWduT+9/HpKy51kUVSLIdy7z8ecXZ9Ub9Ttq8wv4wFP3cDOs+Sl46eexNC9?=
 =?us-ascii?Q?8MLCMELpG9V0FAp8GJO78Zl1NbvHyAIQjJBk+wmOq1InVRtfvITTA4WEqDVk?=
 =?us-ascii?Q?cESjpTOolJ5jUhltWbCYVlIj5jl/YD51a/8P+aqcNsXt3wmZ3sb5SNzFgUNd?=
 =?us-ascii?Q?+9+iNfZPhWKQy00GFGKNIS/y4e/YCk4gE5021NCFzJVJfiq8XHRNqFyHuiuO?=
 =?us-ascii?Q?Ym2TUpwRz4wN1lRYjnAQERlJ5fopAE7LZew9UPWJmHxs4fdnzxPk6fa0bqR2?=
 =?us-ascii?Q?daNXZTiXhV5vXlrvv4B0LlHMuPXerDFvDUcIBkd/78UuFae0ZffP1OwijJ0F?=
 =?us-ascii?Q?OzhoFtL6LUvKKMkZT1oxrczSBPXdCIOglJ6166BIG5Zi3I7H4+f1hNVIpr9K?=
 =?us-ascii?Q?EyvVA+isam+NT2wyUEvYxTn9i6PcithQ7rMHAQSgYS0mRP6uqdXQRRNf0RQc?=
 =?us-ascii?Q?3XgChH3+HEKZmmB+sHC26PLFl5lYvC2T8TWH40ELK0unJ/slQudA2Ufcp2eG?=
 =?us-ascii?Q?g7UAFDRXpG1iv4Kis81H8vsPPioVR4xthQlExFU5jaiyfa6AbeEsq9A4PiW0?=
 =?us-ascii?Q?VV20cgo/S1D55nGNbJVhukVq+fM0HNZTqq1wePO5wjWWoUi9WewPU4C2wzEh?=
 =?us-ascii?Q?KcnjjBiyJ9/iZ3WVm5UyX4kHEq3z2PNFaE5Q5M/HP6vam4TphvV9Q1l2+P5O?=
 =?us-ascii?Q?8L4AoM9ITkGDLENNi/UDV+l7DfB1JWaJFtjGrFjUoCB+2MFXN8YpPM5QhMG/?=
 =?us-ascii?Q?jKDMNk95Xqky33AzpnZl5h+MBjgSh8dwkeRbZ/sx1dCU7V4Wbxi7LwZseTqj?=
 =?us-ascii?Q?reSVyHWsCGIf5uCZEa8PnDfrdyNnPhAvXdaha/5YkdUatmCb0xXuAHSMHb12?=
 =?us-ascii?Q?VcXoRflEh6HMJ53IfDnaBdLkPCCdIBPY7QhS0KiKlv6PC5xZWPtgebgZ7w13?=
 =?us-ascii?Q?TEdcD99UFHcmjzHJLz3yMjpJ6kU706Zx+gFd3rx4C2GyZUBP7jXnkCCpX8mt?=
 =?us-ascii?Q?p/xyhrtlXtopWzZ2ufUrSiiM6trp+xQuQqcRkrbTwTib8CnDp4hUl1qam2Re?=
 =?us-ascii?Q?ZLY/DpkBSovcREuCeUW12VVuHPFOOI1KUVTTFJbOP86iP/yaf6aqa7hnowy1?=
 =?us-ascii?Q?iOrRG3IIRNw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jR8LXLHl85hdSGcd2c1w7hwhkdTxlRl1WP5740gqPMebtd2P1h7MILzYrrQM?=
 =?us-ascii?Q?ngGaIYcs4h5zyLp1pAFszEE0aanfeljeyT7cHaidlVA9faqwmLwEeeaR+SRq?=
 =?us-ascii?Q?lHmEEQNpW+l2F1/vfUxuQzRF7jf6nzJEFPQLhRWpsNJosyi2xmh3uVjIOdjH?=
 =?us-ascii?Q?nQFVHq9/8gZWb8sN4CakTtZF396Jvbw4jcl2ORGFIc1cIK3KVXlEbCA1Zt67?=
 =?us-ascii?Q?nU0+xWTCO1unGzwVEQ+jsoccfJwRIUXBpwkM+F+7gtb4feSlYbc6YXg8zxla?=
 =?us-ascii?Q?TuIMNGbOq+7g9lQgjX5/7Sly3o8nV2+CeFjLaphI6MT7YUOZqGthdYPqXeHA?=
 =?us-ascii?Q?m5fQiVlR4RlbUjru6bBFe5s9QRX4Va2fsCCt/gu7e7Fk4qqk58coi3N5xob8?=
 =?us-ascii?Q?PYCK6SWq7ow3OpMvPh+1L/BsDs0y3Q9QDbJNUECLpoQ0LBe+cOAEswtbJ7wX?=
 =?us-ascii?Q?I0I+6FmgM2g8jGtNOinOkOrAPbd+a23Y/VtKXRd7QeBn2ds8GKfThQ4TZBwG?=
 =?us-ascii?Q?Xa4bQd6ipJODUy4qlEow+S7CqiwUhb3dVEDd4RafETTfIag4ThX1JOwti529?=
 =?us-ascii?Q?Huab6GsAz2+he1ygx3GJQOxgdzZPuZHCstgGeCEs0ZWV1neGbFlz//8D4v6/?=
 =?us-ascii?Q?yNjdJ5yXz3elWMqC0sR1JeXjGEHJgDp6OxW3kOe7xCM3C60116REWOUnQQBH?=
 =?us-ascii?Q?noaKEiYhxvwapu66ta2OKb86jZ6s3NLzXCbPJGWBx98ie06jKR1J/P+/DC6u?=
 =?us-ascii?Q?x42T/qDo/hTgPdFww2htHnGMdaQcm1PvJBhmaXNZPEzGx8cwsGkwUGH3nCYp?=
 =?us-ascii?Q?5yrWF0cfN16rG9oAoEPhRisk4F6oX47LRKA4tz51HhkAIy7+iyrLIxKzXNrF?=
 =?us-ascii?Q?yZS3LEA2CVczk8XLEQMRUMeFfyxTDdCn5s/OALJRPfJi0dEyMr8KCD0L/xFe?=
 =?us-ascii?Q?1TyJb7307/jN+QQ3Cn/Hz6wm/R+1R8Q+wHm4WRSX+ShmTcWSq1veL82Gmu6x?=
 =?us-ascii?Q?ZNbFDJ3MLFJn8FHYhzUoL5Yl3ge+gE/BNAFqtyb2u9dSnTa3M2wn7ItL6qUZ?=
 =?us-ascii?Q?RvxkebwBHBvEEljCFzBqL3jDjNCnJJL1Gpl4xvywh8W3UR2RiUItYTzkrb7i?=
 =?us-ascii?Q?0AVxOxAaRAhw/+qVXyghOiJNHMTngvMNXbkvpTeaAMc06LATT+Yq+lnSBM2W?=
 =?us-ascii?Q?BftHcL5yt0kCHMSwcZe/2W58KzDbQ1dgCfuyMWZa+xT4dWCaxCSU8uggzZ/+?=
 =?us-ascii?Q?9+RvgefkG9CXb19MBUyC2hj3kTDJEqZh8zxW8rWjGbx7W7dJz2X5acPw4/Qj?=
 =?us-ascii?Q?4mSPyRQV6EfVECNPXCoyLVVw4ny3s+9+IcCb3n0J94BSuIyxZO9nL5TxVtBW?=
 =?us-ascii?Q?5zCGcq7Gpy3yb3lQAZFsO2FGQquqlm6ZwsSi5bPYIXp+UvrADIkPNTv2Oyid?=
 =?us-ascii?Q?Hgy9MoxZtyw6XRatc3ISxHobs7K8sQs6791cq7jDfUQY6ilTG19TTC4wZ8hX?=
 =?us-ascii?Q?/3uIYt24h+vlKd4Mwq8Vgjmu2Xof86h/8KhNtYap+ZvFxyyAU3bN2cOA3mda?=
 =?us-ascii?Q?Z471o0RlFc2oT+pTHKy6Fpd+AR1cVqMbQaSB9m0j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9581aea-21ef-499b-d919-08ddf17aa3a1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 21:31:59.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsI5bqOA6fOphya9gigSwB4eXq3Gh50QJSOLlANjPkvw/svtMVgihmHtDUJtWk3UIKFOE4EECspE8DCC++TZZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599

Hello,
Recently some of have been running into modpost errors more frequently. Ahead
of Kangrejos, I am trying to study them, the one I looked at today is truly
weird, below are more details.

I narrowed it down to the print statement and specifically the FFI call to
printk bindings. This was first reported by Timur Tabi on CC. 

With CONFIG_RUST_OVERFLOW_CHECKS=y and CONFIG_RUST_BUILD_ASSERT_ALLOW=y, the
following patch when applied to nova-core will fail to build with following
errors. The question is why does the overflow checking fail since the
arithmetic is valid, and why only during printing (and say not during the
call to write32).

  MODPOST Module.symvers
ERROR: modpost: "rust_build_error" [drivers/gpu/nova-core/nova_core.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
make[1]: *** [/home/joelaf/repo/linux-nova-rm-call/Makefile:1961: modpost] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Any comments or thoughts?

---8<-----------------------

From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH] Reproduce modpost error due to print

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/nova_core.rs    |  1 +
 drivers/gpu/nova-core/test_modpost.rs | 60 +++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 drivers/gpu/nova-core/test_modpost.rs

diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 4dbc7e5daae3..9ed48ddf6df9 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -15,6 +15,7 @@
 mod sbuffer;
 mod util;
 mod vbios;
+mod test_modpost;
 
 pub(crate) const MODULE_NAME: &kernel::str::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 
diff --git a/drivers/gpu/nova-core/test_modpost.rs b/drivers/gpu/nova-core/test_modpost.rs
new file mode 100644
index 000000000000..eab82b6176a8
--- /dev/null
+++ b/drivers/gpu/nova-core/test_modpost.rs
@@ -0,0 +1,60 @@
+use kernel::prelude::*;
+use kernel::io::Io;
+use core::ops::Deref;
+use crate::driver::Bar0;
+use crate::falcon::{FalconEngine};
+use crate::falcon::gsp::Gsp;
+
+macro_rules! test_reg_array {
+    ($name:ident @ $base:ty [ $offset:literal [ $size:expr ] ]) => {
+        pub(crate) struct $name(u32);
+        
+        impl $name {
+            pub(crate) const OFFSET: usize = $offset;
+            pub(crate) const SIZE: usize = $size;
+            pub(crate) const STRIDE: usize = 4;
+            
+            #[inline(always)]
+            pub(crate) fn write_with_printk<const SIZE: usize, T, B>(
+                self,
+                io: &T,
+                _base: &B,
+                idx: usize
+            ) where
+                T: Deref<Target = Io<SIZE>>,
+                B: kernel::io::register::RegisterBase<$base>,
+            {
+                // This assert has no effect on the issue and can be commented
+                // to still reproduce the error.
+                build_assert!(idx < Self::SIZE);
+
+                let offset = <B as kernel::io::register::RegisterBase<$base>>::BASE +
+                    Self::OFFSET + (idx * Self::STRIDE);
+
+                // PRINTK BLOCK -- entire block can be replaced with pr_err("{}", offset)
+                // and it would still show the same error.
+                let args = core::format_args!("{}", offset);
+                unsafe {
+                    kernel::bindings::_printk( // ---> Causes the MODPOST error
+                        kernel::print::format_strings::ERR.as_ptr(),
+                        crate::__LOG_PREFIX.as_ptr(),
+                        core::ptr::from_ref(&args).cast::<kernel::ffi::c_void>(),
+                    );
+                }
+                // END PRINTK BLOCK
+                
+                io.write32(self.0, offset);
+            }
+            
+        }
+    };
+}
+
+test_reg_array!(TestFbifTranscfg @ crate::falcon::PFalconBase [ 0x00000600 [ 8 ] ]);
+
+#[no_mangle]
+pub(crate) extern "C" fn test_single(bar: &Bar0) {
+    TestFbifTranscfg(0x00000001).write_with_printk(bar, &Gsp::ID, 0);
+}
+
+
-- 
2.34.1


