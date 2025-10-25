Return-Path: <linux-kernel+bounces-869639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF780C08628
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E32D4EEC63
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A4572605;
	Sat, 25 Oct 2025 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iLTHC3E4"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BEC49659;
	Sat, 25 Oct 2025 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761351310; cv=fail; b=pRHdvtcIODYYDxqEl/fNlfrcWNM0Vsim2kSSomLf6fnJ+Q1MUBmWhkGeR9mFkSQB3yzuHAwzuNiDuGu/6uQq1VkMn8Gh4GeMQKesrbJB6NldXn2NCnt24SveZZsjongoO2Jl8/mnC1Yq6RASiX6pTdTXiS4gkKzH1n/0k8Rre+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761351310; c=relaxed/simple;
	bh=RkS6q5FlIaz9d+/R9GSxnlZDe5Dwo/qp4kTt0RiEW3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=avm62CAUP2jwBMDbkE4uly/gKwRio5e1Pq1Fzs/j656YY8KQzZ65BJ/VxTuqYzqxcydq084Gy8hHflI7kkEz+gN5QgGy7loD/dJq+Xs1raUPeqnXFEDZjGSIZvWm9wZHVhnCXrZtBn9elXhuHpOWv68HoDpXzTgY4Dd/IYanr7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iLTHC3E4; arc=fail smtp.client-ip=52.101.85.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1GDDxeoPQ2qUx4Bjii+MIPrfzK6U6y3RWga4r7awzNh8MrJiKOxvVR+8recg6VoF7Kr2efqUaHPhFCPUZd//Qf2Bgc5CWyp5bEXMizaY7uvTkcPSH8FvcukZGEYe70JoqpDL+Gli+diES6qfd9zRn6JZo63fq8tmh1rKJZsg6l7Y0KwT3L956XaZtPC3M9OvpEnlACS9kaf+9kQJ3g42uZTpQNzz1RbqkLYfyCcT7ie4lN3FZwK/jAkMmIc+DSGhf2AwogM3vcq6e44Z+OjR8UzHgAhxYydpb8UYzlutTQAENMH8uOaLM+qS9p/N55Crl5f9ZNtZeAS9zCjUFp8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW+5xz8Wm13sWHBesYvMair+HopsBP+WZjnf0VXHrxk=;
 b=h0dN87wgngC2YSBZ7oyl0tj3sH9D33uviaeoXeUmB8m9oGJJEfnaZa/rIV+OvA2StsJy0mNHEvfEag+JN0lam2TOerQ3LqweTZvY7WRKqjNzIaAQrEoPd7Mqv1yBTNVy2lkfVem4s/Smqt0uJFTssRBEL4bpymeQ/A96GKBKsa+7Ls35jAbTYfmF56n1iAgn28poJR/Xi4DEh6/KG6zCl9V1MrHc9nrlYdZKXU0zum87qgnxNs4kGICKzOymOxUGrUI9zMkW8/36Ryhsk1iHM94oqS+/fsvBwzNUlLzdpI3XxqZfWRwe5CDQCHKWnAuHbwKrslA4R8KsZVSe8n1OSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW+5xz8Wm13sWHBesYvMair+HopsBP+WZjnf0VXHrxk=;
 b=iLTHC3E4sitAMKCjvwAD+Z1/ifFRqJbCO+KZAwB22qvv+AB+4Uk73GtMSW6EUwi49NagWzqqeYBRnKoMSEaUSdeC18s0BCjKCpdtZnTvrnPBJXfNOkee6WS3xu9AT5+X3SkwiFbbc1yxPNg6uTULWSIQGDSCRBR2n427WhwEDczyVbNFCCl4zpgt031ni9fxldZKOLAd2a57dK+z4d1ZxAvxSiD0VkIypKf9V5v5fcOlBseMuAMqnnLREg0Ow3TkHv+wnbgQydlq52I0ov05mTGuc1MS2ifdnYCiSSL6VZq8x0C4p0gAazZxbVjNNgBgVxCT9OMWLgI2QXi7CaDfAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sat, 25 Oct
 2025 00:15:03 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 00:15:03 +0000
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
Subject: [PATCH 1/2] gpu: nova: remove Spec and Revision types
Date: Fri, 24 Oct 2025 17:14:58 -0700
Message-ID: <20251025001459.491983-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251025001459.491983-1-jhubbard@nvidia.com>
References: <20251025001459.491983-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::20) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: bafa1a5c-7f32-4549-8ed5-08de135b8b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ba1KB5kxskTzYESEV3pBiRphEKi1udpCHJ4Z82R/j47jg6dIZ3ehtdl8JqD?=
 =?us-ascii?Q?JHmKLSu/NlqTXPQyG2SEnnsd1CRBIelclOTxTzFmuOkNhrg9YNvZRJFVLMTj?=
 =?us-ascii?Q?U0HnIxF/AXVkHFnFMu+Rfn7W1l7xiPK3ybFmOCpWwHJUE1ZbRx2mocI6Mt+E?=
 =?us-ascii?Q?fo0iqwV6u4mlC1UCgL6E0c4FDR/IJoNZ7G5tKD5dZTEXfOI1UaskTUav6LHn?=
 =?us-ascii?Q?6sZ/JMApCNREFd1X8aGnXHT98MIPp0qhDlLzeoNrMwp5cEN3not1utVxQlkI?=
 =?us-ascii?Q?AsZFhYX4bt32zYZXJd2qrIB7b69TSCJ1HKIN3d5zDHwgELbd1nAwOE+qT6QB?=
 =?us-ascii?Q?pEuc28kZQDgvNapEauC2f8dIxyRLNK81GDKPaCYSNmQK87WoL8fnwUJwTFX4?=
 =?us-ascii?Q?sdB0BSWSuNOeEzx/yevPi2/4YhXwJlHsheTxQV5dWXMc2OfVTkH8aI+3z3SB?=
 =?us-ascii?Q?3rA1wpdB4S4kamjPhkLVLnVMbz7A47cGICJuXKoZj8CMw+3b3LqZdc90kTuG?=
 =?us-ascii?Q?egwBfGdS6iwv+KKTJCgioKErrASSF+osAqVVSF2/2DJGTaclmrztNF1R6wkY?=
 =?us-ascii?Q?Dc0n5l/RNv/u62NhYuqhtSCjlFypbyYCQsZOeNZgpvviNGBHUv5nWes7wb/c?=
 =?us-ascii?Q?EJtTWLVfFa5MkrWNe5dvProgCd6mHECY2iOvtdSXiORUWzw+8RtyMk/Q4NdB?=
 =?us-ascii?Q?4Z3WQbGgmbhx8twskZuIRsCT3/WPmnxIiB+IDWE7OU7jMo93kq1/5EtsLJIK?=
 =?us-ascii?Q?P3XlBlcboawa5IgwCBEusEBoceit/aMs1FJIZg6H9K3eC/wIi1sRzu3czT0P?=
 =?us-ascii?Q?HC/OvONLe7eF5waDIppxohFmxzLnXTwxxDeoU7bLpBLjg7AJSj1y+/VjtYFv?=
 =?us-ascii?Q?lEUPi5nOFYng28nB7agQINxz+iE8iHVnM7mFSuDd3OI5n4eDUI5zSjQHmkZp?=
 =?us-ascii?Q?Wrpo/7eNoZzazQU8Vt30bOOY+WKrr2ZoLtI9pncaofXhJ+G8uPDBVXSRltFr?=
 =?us-ascii?Q?vwfynf7ivkZBa1nix5mEOiOwEUdN+Hj33qVYC2tRcwlNst+nJlWoj5DIFwgF?=
 =?us-ascii?Q?vLYy/tX3N8dFPPbdGZ2aFCXSPNbrPk/qPetEppV5NMATIJ/Ii8PLn4/QM0xm?=
 =?us-ascii?Q?yKMmLjxqhyBqXfxHaAxrFq9EDqrnudR+tmkt4VGzLGBdVOaG0Ry8RDlf2Vi7?=
 =?us-ascii?Q?bN5vBN1vwiZz+HuhSMwXnHXhtXJimnmcZY38ZEUTCc5z8KBXLHCBVH+0kV86?=
 =?us-ascii?Q?KtT1uqZIa8kgwdmQ6YUg1AoocVf9kcN1DcfvVWJahD8wZSMtp8YjwQAym1A2?=
 =?us-ascii?Q?RF3cbj/DxskaZEbUX3z66RHcf0FYRDlYmf6Ga9TcM65lXmAnOik3Zfirnvxz?=
 =?us-ascii?Q?XTrgmVg6uhsPvnwl750CL59J5s+pKIjoDlmtJSG5gSUYmxN1Ym1w34A6RrhS?=
 =?us-ascii?Q?/sfQYY4x5SBJ7tUJ+J9w3UWQqUaxpKUM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ftfQc/OqpZhwREJ8xhJsIuDKEaYtpKT8IWMR4Sp2Xv/mgJc9P85snFBIZUhP?=
 =?us-ascii?Q?S4xMemp9eXfJVGnh4ALd6D+6KnLNIjEjLGtXmQxCLWa77DCKAsnESQuotdjl?=
 =?us-ascii?Q?zkz4Sr7hH07eldxyMDxvnqfOAAzjilrRCGTFdZorxKotHsn4GEonidw4tHtS?=
 =?us-ascii?Q?e8g0jSHAfKc1jNJlOFPkcSj2rqJBWCRk62po6XRPwyUYIyeyHA4lVoyYvtXv?=
 =?us-ascii?Q?O04Ik3B4zQ2Fhpseo1SoI3S4SDFzaX9YzZYpLzKjxLQIo2EvS2rHDzlN78JY?=
 =?us-ascii?Q?yHsKfy18eOl4YgQApVVcR3CYDLqG5z648KCuhYYXvyq9gU4oj3t/OBSOg6J9?=
 =?us-ascii?Q?GKgOIK11FP9zcym64W0Zt6+LgNii6FKYP3yOxKrBUiQJ609QXB6QeRMO3qen?=
 =?us-ascii?Q?UgoCSRoTFCtv7avjrFCdJF8QMsBCrU0XnB/BiWDQLcm80V+auJ/l0jmeXxA4?=
 =?us-ascii?Q?EopHDhtsNkfuBwJOrtF4ZeFU9n2oK0nGmlx9zQSwFLjSXil/bNK4VVXPll7o?=
 =?us-ascii?Q?x9LpXkaAPBMt9znIq5RingEVNBbKDIb4rbWHjbNhi3BSdzbkdImdMMO5rh+0?=
 =?us-ascii?Q?CJLi094mVuR28WLkxGHP2rECiy3T0v+Z1Ug8XA6/MNlR9qD1FnEtRm6WE89i?=
 =?us-ascii?Q?O02JeiWi1rfclJOU2pFpIG+Mxn6OZmBXIkQDj4URw9XWY9sngOZVN0gLwCcv?=
 =?us-ascii?Q?futmGAQboH9J7FptzERtUqznsgIWqTSeVMbFib2WiQdguiSk3v3rjqCaYhvD?=
 =?us-ascii?Q?TbW1I0TZDrOQz46VZQAx4Q6Fa6Wef4se35gwQYNTxx67k/gwFDXHmpsOvDxC?=
 =?us-ascii?Q?xQnfLl+DiphUwl6KrF/VoeTs5ABFtSFYz5d5BEKBoxPQUzSNfercUPd6pzvv?=
 =?us-ascii?Q?km7Tlsh3egg0CnU0x0lWIz/p9in0dnW7ZH79D0wWfjTJRu+Qj6fIThi+nDEq?=
 =?us-ascii?Q?wSuNAkJSkgr/Uh0PqsM+ig5JAjw4jjnLjLrV1eOktbglKeo6IbBw9BL7mai9?=
 =?us-ascii?Q?UIpwfPu5zljDt0YfwuXrUfrEIDbCbY6tSqv5eKNSrmXbTq/9S28i9P9O2XzL?=
 =?us-ascii?Q?lGB2YUCVce+0/AUNDitcOQ6wlgv+JSY4/ufJsAkUkO2FW4p7P33MmDB54qWy?=
 =?us-ascii?Q?u2wcDq5GodO0TstS1o8xZckS35KfxKiQNmBOR/teZ0WOCKDdoTSu3peSO0Oa?=
 =?us-ascii?Q?ZWZM0KYzGQ809gS192S7kqe3u/zm928xVmDQkA9coQerjL7i9qQVB+8hFat8?=
 =?us-ascii?Q?LDS4XgRKAa380BjvGGzojR6mwjvEKW/qqWmB32nCgy3u+vCkX9y1hFnrT/2L?=
 =?us-ascii?Q?OtUF11wtb0eINqc2PC+X1S4U1M91jjQ9aQ9lK7ub1ytyQr0SAUxo9TQ1KbL0?=
 =?us-ascii?Q?k2XBhjzA60RWHKyBo5mhqOLidJPB5yJQbVtmf6osqPHyNrkXBeXBIyI74gX7?=
 =?us-ascii?Q?9119zBjFmF2FckZOaX9axRP9SfNVnRFW53S5QzssBej37S6Fr41HpoRqbDEW?=
 =?us-ascii?Q?jI8gWQcHkEtmfBXXtOzXu4qv+4QEYIx0jVULpikgPdj7O6B7ULDNuojYczVz?=
 =?us-ascii?Q?idtIf08AWkB6VsIUWHKgfqOnsYMh2+viL4xMMxwL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafa1a5c-7f32-4549-8ed5-08de135b8b33
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 00:15:03.2629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivHa9Ht/qcgr3fb6PPgF7LZ8KlpWhRSS96c3p0swwpdrLKkwqHj/jpWhNFHLaY6a2PvYFcCxeR7L/ZhcmrqCRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313

In the fullness of time, it has become clear that these two types are
not actually needed for anything, after all. Remove them both, and use
boot0.chipset directly, instead.

This deletes a net total of 33 lines of code and simplifies the code as
well.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 67 +++++++++---------------------------
 1 file changed, 17 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index af20e2daea24..a8a993424771 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -129,48 +129,10 @@ fn try_from(value: u8) -> Result<Self> {
     }
 }
 
-pub(crate) struct Revision {
-    major: u8,
-    minor: u8,
-}
-
-impl Revision {
-    fn from_boot0(boot0: regs::NV_PMC_BOOT_0) -> Self {
-        Self {
-            major: boot0.major_revision(),
-            minor: boot0.minor_revision(),
-        }
-    }
-}
-
-impl fmt::Display for Revision {
-    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        write!(f, "{:x}.{:x}", self.major, self.minor)
-    }
-}
-
-/// Structure holding the metadata of the GPU.
-pub(crate) struct Spec {
-    chipset: Chipset,
-    /// The revision of the chipset.
-    revision: Revision,
-}
-
-impl Spec {
-    fn new(bar: &Bar0) -> Result<Spec> {
-        let boot0 = regs::NV_PMC_BOOT_0::read(bar);
-
-        Ok(Self {
-            chipset: boot0.chipset()?,
-            revision: Revision::from_boot0(boot0),
-        })
-    }
-}
-
 /// Structure holding the resources required to operate the GPU.
 #[pin_data]
 pub(crate) struct Gpu {
-    spec: Spec,
+    chipset: Chipset,
     /// MMIO mapping of PCI BAR 0
     bar: Arc<Devres<Bar0>>,
     /// System memory page required for flushing all pending GPU-side memory writes done through
@@ -191,16 +153,21 @@ pub(crate) fn new<'a>(
         devres_bar: Arc<Devres<Bar0>>,
         bar: &'a Bar0,
     ) -> impl PinInit<Self, Error> + 'a {
+        let boot0 = regs::NV_PMC_BOOT_0::read(bar);
+
         try_pin_init!(Self {
-            spec: Spec::new(bar).inspect(|spec| {
+            chipset: {
+                let chipset = boot0.chipset()?;
                 dev_info!(
                     pdev.as_ref(),
-                    "NVIDIA (Chipset: {}, Architecture: {:?}, Revision: {})\n",
-                    spec.chipset,
-                    spec.chipset.arch(),
-                    spec.revision
+                    "NVIDIA (Chipset: {}, Architecture: {:?}, Revision: {:x}.{:x})\n",
+                    chipset,
+                    chipset.arch(),
+                    boot0.major_revision(),
+                    boot0.minor_revision()
                 );
-            })?,
+                chipset
+            },
 
             // We must wait for GFW_BOOT completion before doing any significant setup on the GPU.
             _: {
@@ -208,21 +175,21 @@ pub(crate) fn new<'a>(
                     .inspect_err(|_| dev_err!(pdev.as_ref(), "GFW boot did not complete"))?;
             },
 
-            sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
+            sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, boot0.chipset()?)?,
 
             gsp_falcon: Falcon::new(
                 pdev.as_ref(),
-                spec.chipset,
+                boot0.chipset()?,
                 bar,
-                spec.chipset > Chipset::GA100,
+                boot0.chipset()? > Chipset::GA100,
             )
             .inspect(|falcon| falcon.clear_swgen0_intr(bar))?,
 
-            sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset, bar, true)?,
+            sec2_falcon: Falcon::new(pdev.as_ref(), boot0.chipset()?, bar, true)?,
 
             gsp <- Gsp::new(),
 
-            _: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
+            _: { gsp.boot(pdev, bar, boot0.chipset()?, gsp_falcon, sec2_falcon)? },
 
             bar: devres_bar,
         })
-- 
2.51.1


