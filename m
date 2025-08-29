Return-Path: <linux-kernel+bounces-792240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D028FB3C1CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073A5189CD47
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141634320A;
	Fri, 29 Aug 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ink2n9sk"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A57342C83;
	Fri, 29 Aug 2025 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756488805; cv=fail; b=oPA96fjhPO1FMo23B6U41VqZxpzE6cPKu3KNgz9VsjebcDjOCdWx7oCyJuLG2ljyo0ATWgqq/yJHTuzFLqAklGj8TnymA2cvgC7VNEfejMpdUBW0/MCtuKTH5aN800MLs/wgLRr9Wxxh1D99bxcGWNUiEImbSsURpU7vIsLn1Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756488805; c=relaxed/simple;
	bh=O03uyaWNN6bwvSRmUiV9d5N/sZeSFnvWj1LEpZ7Hit4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V/mcQPZu/bnb0hgh8wAoVmUUKs+hzDKRxeVf5sebHwNig1gIHqT8JchoSSx/oaPiCr5JZBOYv3xxT94HkocpQECd9u2m81YQtBd6uiHi3c1dxvExmK4qJCSyc6/R269BgPlUK3zNQWfoPaK56209qg+QDq8pHbyiTckhQHalRww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ink2n9sk; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1ZK+PqpMSFBlEjXKKEG5manjcZWcOD1NEtXAlvFUN8LWa+zpf23F2E4UUpMuOkwFfyLgqiDMAV52QDnsmhfcX+O6CL1Woj4iXxVBlXmePlD7vqT4+z7HU0OkZXcFHLSOkZLtSgFIuE1B45SwBnQNfNu/6j8d0edjalLIjHFbkA0FJv7D1tGOe4QuX+sz0xlibnWuYmLd4fJAVS0JHQmX9oRD0cjeXwgJ0PbtYgOoFW83wwLcs2y8g5kwnj3JcM+0dfixx1QDDjtN+H2BqCTNF5OlBrP6TgQ9IHyctSmjie/7gD4MWwIH1uoNPtl31pmdKSKrjewn91CgN9bouU/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8Fbc4Tze5Mg0aEcu3bovuKOJEUp1XYoM1x5p3ZUe00=;
 b=tj0/TFmFGh1Po4QZErO3Ov4XEB80F2ObBx/lctgdfo7tOW9AE5ZXFf6WoVt82K589KSH/FGOZhmoI3vwlBhWhIls/zmUWOJd2pCZ0eqkaGm5RAD9//htJdDX26Hbpplp6XyACx0Ro9M5NnxVr5dElWW6rBQdzOrwwSogHZDQ7qDjMRK2HZ60Twzxlr9ufxgYP/s2Fp6pXsR/UzrFaSlTwSdJpxBe+v31tl9Zo/yIxwxLoQwJXx5ya9smROl5biP+Ukw1yXAKMknZw9+VPwpcFKOMBS0S3oJfLL7qEBQHJjZF5IHuhIiWGZzZ8DAVMlwE5jax8O+46uaOXuekGy2NVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8Fbc4Tze5Mg0aEcu3bovuKOJEUp1XYoM1x5p3ZUe00=;
 b=Ink2n9skaOWBRU6d9bg1PN0+rbk+UILDOot4TiEkZZbjQaZNotb5ZtWyGgto+0T5KaqsL1R4kvs34DuWVN0Qz7lwu+yuCrsllwPJHdDAoD6AYS14zRbUduzgguXoaw9PAvZ20qPfAYH5HLMTQ9c4qWgPT76vPw8zbdBrFt9pud4WXgfgKzVbvDV4pO7bkSUFo7Ic9jM7PEFEIk/KEYL9BV4HwBWMDib+AslIL/Ep+RITZTqqBl/D3L6a/ZSoP15z+updkylGyzXtJwRQu4cHHAPOTImiMUv7/IamDIhFXsB3Zgn1akH+tjhNZ9/InTHQlofujQZOCmX2qbSta4yXrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Fri, 29 Aug
 2025 17:33:10 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.9052.017; Fri, 29 Aug 2025
 17:33:10 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	dakr@kernel.org,
	acourbot@nvidia.com
Cc: Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com,
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
	joel@joelfernandes.org,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 01/17] nova-core: falcon: Move waiting until halted to a helper
Date: Fri, 29 Aug 2025 13:32:38 -0400
Message-Id: <20250829173254.2068763-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829173254.2068763-1-joelagnelf@nvidia.com>
References: <20250829173254.2068763-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:208:15e::26) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 93fd070e-0e31-4d8d-7adc-08dde7221f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bs64wQGuDlHlOvCQkhBI/uzE+LsMGBZYQKsaYmV4BcdhXeU6KVhc39Zl6wU/?=
 =?us-ascii?Q?DLstfMwfehQzk4aflye7ttQ9x7KyerqkMOaUvMhOKjklgBAeK+Flek+nwRaS?=
 =?us-ascii?Q?0sC4oxCdFnsskD0HO50r9b2PTc1/FQbmaNh7H200i+Iq7+vyGqVp1FML00AS?=
 =?us-ascii?Q?tcqTs1/7ioYNjJw8FsQNJCdlYE+Q4m2PtoIYBbcb1fRdgFkqruP5eOBFVJ0y?=
 =?us-ascii?Q?tNKHQOk7A3BNoRcc08Z2GPFQztaDMGprFzxxJPA9BOmnFJvCcuqO18t+1F+n?=
 =?us-ascii?Q?MI4iN75lgtn1xUU/QKGmkfK/sCbx4SpTHmCzsJ0PLzUAuC88C0rEdr9PBq2w?=
 =?us-ascii?Q?YP2i67MZDp+QjydIG8G9vIuwlQv6HajPzzAAHZL4ObEOdO57Amndxggxf4Xd?=
 =?us-ascii?Q?EzDRqDy+2wMWLZAh36a6PifreoJxB06llZT1L6Vrul9WczV5YRArg73oqm1f?=
 =?us-ascii?Q?O/RL6qf+rnG21l5MNTAHMJlnOUPZhq9kjMyCalVZEzcsqrKXyZOsQFZ6Snda?=
 =?us-ascii?Q?ZgF+viY69Q+2VaAbUEhJaJKYX+XkdEMxyHyIB6sIxc6uE3JzxxsOOdDsMJ9y?=
 =?us-ascii?Q?guuQXyAmRVl6rbjp9hwuBbPLmJAM7fmKeGhFMw3UwV6dfmJ8JaVCpKGehY7V?=
 =?us-ascii?Q?IThGbXTzdKLySltI09qgUyipc3mfODKjtywvy02LuJpfQsh7YnAJZSX21Lhu?=
 =?us-ascii?Q?UKY63CzlzSBvoyD9xGt6GUkc9JfzEaD+CnAnTrJnTCIQwMFO6pzIc92ayDpF?=
 =?us-ascii?Q?QNWX/dHJwItmQBMDDGv5m1AonaOhTeCcM0R7zpd3ahsSJTFRg+oim7ll7hEM?=
 =?us-ascii?Q?ZAossIbbUUTbsWlqUdKJ0Ucf/9Bc94zZ6AE3qdsUDHzbuX0MoJVPGAUxhZzx?=
 =?us-ascii?Q?ymtW67C8FfT9dYvqQIyZfdsI5ZGn1XS3BC+IkUARG6WU6i8qbqEAwcLxbreh?=
 =?us-ascii?Q?+vP6JwRjT0HKBZmqX2rYFS48OS3F5+Q4rasnmtgU0yhvG6J8hn4eLOTA8u+I?=
 =?us-ascii?Q?M+8NCK5JpuZAQx6jIXenKGXgbGwrfUvzunY8p+PPcHy+xzDOjliJ8qwxpfC8?=
 =?us-ascii?Q?UMp83PZaEl8Ne0MjoRP0eMTfZHT4rnwOGVhI1Gmwvv4Pms3F1lNoPa313cCr?=
 =?us-ascii?Q?kusql56yliLjo4R5C1ACQ8+J36mVHTixG3JqxO2ctqFXifpt6S16495v3pgv?=
 =?us-ascii?Q?x3MZBGcLvRvi/FSZ8mN07TCP3xYd7eHlEWmOL85Xb0YeL9sgTQOH+c+1Fs0e?=
 =?us-ascii?Q?pPE0RyE76oVqLsYoR5v24RWvYOsXZuX5hsVSRGkp2wka2srnYYpBUxg5yjwY?=
 =?us-ascii?Q?kMP7YrOBuBvcTC6qbDYWRpNY0OT1nEJkhpazzUVzCH+LTKReVwS+hKKzrSSX?=
 =?us-ascii?Q?o3nfi2cPlNR85AUjHSpCE1JW/JpSRgEMJWmbtKrhFKPhJHmzLyL1jyTvSBES?=
 =?us-ascii?Q?H042JlaE4i0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1lsO2edoy0GEoSmxi596PVijeHupASHw27oNer4qk5u/Y9hN9coV/4kEnX04?=
 =?us-ascii?Q?fzX8rNfNWTCvPxVmMLYcsN3oTa+VTFS0XyuE4jND1r8aTjN5l1HaFos9FcsN?=
 =?us-ascii?Q?fzqu2hEuMaYy3jTeIOiVLzL6lG9oY2m+5EzoNO5gs6P1ZjuANUMF/jv0KxTK?=
 =?us-ascii?Q?RTBe605VvVrQGEwkoeP6TR7NKhdQCkVpQWhObmrNpDXISjcrbxlp75BZEoZu?=
 =?us-ascii?Q?jAu+72PVsqjVoSkTLBD6wSrbcDVqnexzPIn+/3zLiOxc+Lc7Okx2b5ZHPX5v?=
 =?us-ascii?Q?yXiY1owk/t2L5u1qFSodJfx7GGsFwevWBvKjCMUY1qKIOgjd2JxZrCgtlNJ8?=
 =?us-ascii?Q?EHYr9P5jaZpQfC5p6qQ2UgB2NJPFyNFLrkHjQKxNjxRsO/5XGWXzXvZ6h/0z?=
 =?us-ascii?Q?YIEFeHNoPkGI+gJHfvnBSWrqYgAObsTAW9HMEr6Ve2bjSL1AeDOg/RZc3fYM?=
 =?us-ascii?Q?xfG8uotMPbOekU3+l36N8FvJtB3/0HYvp5QNLVlZETmVpSZcuDZyKvAoAQO0?=
 =?us-ascii?Q?n+6kdnTiYLNoOhdKyKfrF8G6uzZ4sspXPbQltyyiqrXkVTfFwTBJNtOd5P69?=
 =?us-ascii?Q?dlKBsJzOPC5MoTKAsl9/zx9SjvMp2ESzyuhci/VfC5bRhQONY0lJ13RFoz0T?=
 =?us-ascii?Q?Q1gfBMhMZWVxk3205DpPALd9w/sGvxJF5FCukJzh21g12k3PQuddZ5hkUVuh?=
 =?us-ascii?Q?YEyaswbJR4Up4cj/ylBWRNYajj1yp1VH10oUl7MjVrv6xALXPhDtxue+JLga?=
 =?us-ascii?Q?koQEHxJT9oGikoPnMWCSQk1d2B5PYGniV22oyoNZ8k9DKwmWg5RH6z+P8tw7?=
 =?us-ascii?Q?jPcw/xRoHCE9cXsF38HF1OHXKgu+4Lrsr7rTWGMnkiIuLqM9UY1lIpzZjdeo?=
 =?us-ascii?Q?rrHbeakXY12+cMNmwd3Rto9IA3yFe5gNJfLymQVL/Jsm8On4+PBlhkJunI/g?=
 =?us-ascii?Q?Mf4lGtbB21FdIEZp2TAOcrrysAKmwtmo1Pw4pfn+3+MCk/oeTnuvqrEKQlXR?=
 =?us-ascii?Q?kukw9jy3Od7lkFyKQL6TpeQSlQkI2QuBr4yfziv1+Zj2Sc9XyrPtEauKXvd4?=
 =?us-ascii?Q?FHDV651D1Pf3CIPIE3vaU0OjPM807BlxZuaCMukU7LM4CUIK17fAKD4iS/N4?=
 =?us-ascii?Q?hZP3e1xv5R+GJRkOmuBoHQ3I10s6IaE4fC/M9udlxV+GFO3sBbzufbxsrNap?=
 =?us-ascii?Q?yHY/seEoYA2WvrviJz8GEI0zXaD8M6QRXVZUZQu0a+e13CctCi6Icuc45Pj2?=
 =?us-ascii?Q?A4+lNJhW8I3pj9Ntuve8QoIDIKI3uZgZ2kDyQtXxb9eI+xNWr+Z/3FBI203G?=
 =?us-ascii?Q?9IswdOotILllQCmOYE/Q+0i2KBf2ZEgdMXD4ZV4fSMCzIb9z0kJzhYLnKym8?=
 =?us-ascii?Q?VwajAEpgLVmSmprXRiCbEhZLW/qcfHZ7nz0YLk6xN8dVAoHeRT4fRNJPFEFl?=
 =?us-ascii?Q?FYQkANTzpaaq+Vn7Lj8mjGWMn+6YOOKqqUwfoiId7GuCLV+YdUVsQezWBZ91?=
 =?us-ascii?Q?2UexgvjeTma/PrS8/Bbii+ytRtxWzLPdGE6LSLs5143ltT41fYSRG6RkhkCE?=
 =?us-ascii?Q?fqRwwWF9J6ODX0VAcBviFxjt4Tu7+l9mbDAUxpqK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fd070e-0e31-4d8d-7adc-08dde7221f61
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 17:33:09.9201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxop3ZZ28Hz7IJfU/6uHKAYYHonmh6frGe0kz8YlrIWnxsTOoZnBlSMnmHyqNpWjgtqJWvASAa4ziPbe6HEtxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

Move the "waiting until halted" functionality into a helper so that we
can use it in the sequencer, which is a separate sequencer operation.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 0c8ee7761f70..83e40a7abde0 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -547,6 +547,21 @@ pub(crate) fn dma_load<F: FalconFirmware<Target = E>>(&self, bar: &Bar0, fw: &F)
         Ok(())
     }
 
+    /// Wait until the falcon CPU is halted.
+    pub(crate) fn wait_till_halted(&self, bar: &Bar0) -> Result<()> {
+        // TIMEOUT: arbitrarily large value, firmwares should complete in less than 2 seconds.
+        util::wait_on(Delta::from_secs(2), || {
+            let r = regs::NV_PFALCON_FALCON_CPUCTL::read(bar, &E::ID);
+            if r.halted() {
+                Some(())
+            } else {
+                None
+            }
+        })?;
+
+        Ok(())
+    }
+
     /// Runs the loaded firmware and waits for its completion.
     ///
     /// `mbox0` and `mbox1` are optional parameters to write into the `MBOX0` and `MBOX1` registers
@@ -581,15 +596,7 @@ pub(crate) fn boot(
                 .write(bar, &E::ID),
         }
 
-        // TIMEOUT: arbitrarily large value, firmwares should complete in less than 2 seconds.
-        util::wait_on(Delta::from_secs(2), || {
-            let r = regs::NV_PFALCON_FALCON_CPUCTL::read(bar, &E::ID);
-            if r.halted() {
-                Some(())
-            } else {
-                None
-            }
-        })?;
+        self.wait_till_halted(bar)?;
 
         let (mbox0, mbox1) = (
             regs::NV_PFALCON_FALCON_MAILBOX0::read(bar, &E::ID).value(),
-- 
2.34.1


