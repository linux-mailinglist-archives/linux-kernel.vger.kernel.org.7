Return-Path: <linux-kernel+bounces-776622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF36CB2CFA0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CBC7B798A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DD125C711;
	Tue, 19 Aug 2025 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGWWpkZo"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C70258EDE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645163; cv=none; b=kScZuCl4Y7Uv6Dd54dsNoHP+MFBAkZd6c45GQQKZxMTCPebzf+Ffu1ySTtkHxX6E4bWmK9dFAEPuu68UC/7ibiBiLhw2AejisHNysY45R1dFy+TAVLSqylTzbV/5XaPxfvya8b0HU265A+ArcxqjMnhdQitfh9cPAHKrVPJSr/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645163; c=relaxed/simple;
	bh=tN2d0iBRLdibpnliXtRBHAo/6Jubq5ZEAkUJDcXTn1g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F0rgPOPhDTv221sk3PgKY0Qy5IF5367PAamtz8oi8Km+/NkiEE/i4iB2JFfAkfLLYHxbJIPxv1bGRyS0TWuW10FArOHSy5d2cJvaBL8agjAyp0chDrojITq/59hwEFI/y1xOzBcOdxFYjFsbZREChkPRbRIbKF07hh9sAfAZnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGWWpkZo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326bed374so4969864a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645160; x=1756249960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cdkg5EdcS5JFoEk22pjb/uAdY4rj813xklyn1rTCstU=;
        b=cGWWpkZoUFWvLPcIQXiNVMpV6IBHvfUCXobmTmA/fc7ngUnk20qlDUdoH44LgSz5p4
         8MMaIdU3o+uSglXNvBukW9pVR4yCDTdy4B6goAn4i1jMVAsx48mz2M9teGAUgOsPMYzZ
         dd9mUP398uvUYo77bHIV2J848BZ3YTbv3SIWHsz091GzPTGnHpjdFl2uqF0BoOSG96Sd
         8q8FCZSm7wDh0eED8SpOcMChD5jlYhiTMIRgOnQ+QLQBWuI1WTMthFjNZk/D3tnjMRh+
         dyIcdUP2uVqk3r+npMbOfb1cVLgwzSwRH8qT0IiUh3Zl/xcas6NTqkPMAyYZX7+xqPUb
         s0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645160; x=1756249960;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cdkg5EdcS5JFoEk22pjb/uAdY4rj813xklyn1rTCstU=;
        b=YCWSBFYuTSx9d8pJBRv/CnXnv5ykXAU0bZHUUJs9x6cYhYUwRlHdCiNYYKBcf1oWzh
         L0ErdLZpFMoqgSnypczaWRwZgKSMdHuCzRHzBnp1ZKbvpbe89NMIMSI/VeAwddDtFPXF
         a3JjdGecnzxFCJfkk7JvErnHOsj4ahPWyeMLwcg0n/+8UOg1NaaYTM7imjULYlITpvgV
         LFC6ujP5H/qOdp2W+cdQPJTpfwWBU5/cKN6bAejZIZAKJ9ZFykDQJZ1ViVHVNB78XnLx
         3o45MK/ZHRpPnZ9JTg1TeuHTbPlPmmTtgTGcbsyB7AIB8ZvJCsfrPc89lMJk11PBGcLS
         H6vA==
X-Gm-Message-State: AOJu0YzGTctylh9WlOtQZXc6Q/hjUKgyvmm7kotJ0m3o+zJzBCpci4rU
	to7+DHBk+JTNgKpxYxJvf5UylpJUrab2qH4M75gW98XZbgBvHtH+NPXW693Spa99jOcVNm5nwo2
	2sBuiKSoZww==
X-Google-Smtp-Source: AGHT+IHq2ZGydkxOCKDgPFbqm1zIYpEaeiSpOMHsq6YpiMIlZCQ0TjgGxP0laqAl+qv35spgDxGaYvXNFlyW
X-Received: from pjbsj14.prod.google.com ([2002:a17:90b:2d8e:b0:31c:160d:e3be])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc4e:b0:312:f0d0:bb0
 with SMTP id 98e67ed59e1d1-324e13b08f2mr1319229a91.12.1755645159794; Tue, 19
 Aug 2025 16:12:39 -0700 (PDT)
Date: Tue, 19 Aug 2025 23:12:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOAEpWgC/03OvW7DMAwE4FcxOJeGqfhHFYKia7duHYoMsiw7B
 CKrEW2jQJB3r+pm6Hgk7sPdQHxiL2CKGyS/sXCcc6CnAtzZzpNHHnIGVamm0qTx6mJAiY7nMaJ
 rdF11VpN1LeTKV/Ijf+/cJ3y8vcPp75j8dc308vgEL2J32hTHh0yKDrqhsm3aukZCd04sC9tZ7
 LxEuXCwil6nYPlS5gkv8H+hKXalVhoH36/TKJhWWfDghsY9d77vBjIbVb+l3orHLAReTLG1JXW YnILT/f4DE+vhXw0BAAA=
X-Change-Id: 20250818-qcom-socinfo-c58407a81ac6
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755645158; l=3040;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=tN2d0iBRLdibpnliXtRBHAo/6Jubq5ZEAkUJDcXTn1g=; b=kHjUnWWjgWPHx9fl7xVzA9lXW44Bd5Jj9Mgqu0vko7qyFF1TuUS6i2e4U80e3b7iJYi2/KkcC
 pUlO1kN1ER0DfH9LEvxT5eT6DMjP+THQLAGaXeGShkrHo2CWdTGar79
X-Mailer: b4 0.14.2
Message-ID: <20250819-qcom-socinfo-v1-0-e8d32cc81270@google.com>
Subject: [PATCH WIP 0/5] qcom-socinfo Rust Implementation
From: Matthew Maurer <mmaurer@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>, 
	Dirk Beheme <dirk.behme@de.bosch.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

THIS IS NOT A PROPOSAL TO LAND THIS SERIES

This is a demonstration of implementing a real driver that uses DebugFS,
primarily uploaded to serve as an example for API discussions on the
DebugFS series [1].

There are a number of rough edges (transmute, intra-module bindings) and
un-landed abstractions (SoC registration, randomness), but the main
purpose of this series is to look at sample usage of DebugFS in

* driver/soc/qcom/socinfo_rust/socinfo_rust_scoped.rs
* driver/soc/qcom/socinfo_rust/socinfo_rust_file.rs

to show how this would look in the two different APIs.

The example outputs byte-identical (as checked by recursive diff on
debugfs mounts) DebugFS files to the existing C driver. A real rewrite
would likely be simpler as it would be willing to not precisely mimic
newline quirks, etc.

[1] https://lore.kernel.org/all/20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com/

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
Matthew Maurer (5):
      rust: Add soc_device support
      rust: transmute: Cleanup + Fixes
      rust: Add support for feeding entropy to randomness pool
      soc: qcom: socinfo: `File`-based example
      soc: qcom: socinfo: `Scoped`-based example

 MAINTAINERS                                        |   1 +
 drivers/soc/qcom/Kconfig                           |  12 +
 drivers/soc/qcom/Makefile                          |   2 +
 drivers/soc/qcom/smem.c                            |   9 +
 drivers/soc/qcom/socinfo_rust/bindings.rs          | 126 +++++
 drivers/soc/qcom/socinfo_rust/data.rs              | 387 +++++++++++++++
 drivers/soc/qcom/socinfo_rust/socinfo_rust_file.rs | 538 +++++++++++++++++++++
 .../soc/qcom/socinfo_rust/socinfo_rust_scoped.rs   | 367 ++++++++++++++
 rust/bindings/bindings_helper.h                    |   8 +
 rust/kernel/lib.rs                                 |   4 +
 rust/kernel/rand.rs                                |  14 +
 rust/kernel/soc.rs                                 | 137 ++++++
 rust/kernel/transmute.rs                           | 126 +++--
 13 files changed, 1681 insertions(+), 50 deletions(-)
---
base-commit: f3c5631f70e434e318c44001e2417d4770f06cd0
change-id: 20250818-qcom-socinfo-c58407a81ac6
prerequisite-message-id: <20250811213851.65644-1-christiansantoslima21@gmail.com>
prerequisite-patch-id: 9448855f52cb137ad246ae5fde9eab12eac5da94
prerequisite-change-id: 20250428-debugfs-rust-3cd5c97eb7d1:v10
prerequisite-patch-id: 78c729bc8c164ce7a7c3ff841e720518a7f28c54
prerequisite-patch-id: ca7c06b342af0d1f5b03f8907206f8b69a189c9b
prerequisite-patch-id: f3e7541c4e907d874c8f303c2da14dd3aafe05f6
prerequisite-patch-id: e892f83de14710bea11f042ed874c05ccb3bc972
prerequisite-patch-id: ce8a5988c32a6491bc36e87fb33b2e9adf254db8
prerequisite-patch-id: 0762df7763820dd608da15dfbd8b5309d7692aa9
prerequisite-patch-id: 23da818045894ee8c6f2a7d8ade002ccfc96cc3a
prerequisite-patch-id: 2bfdaa7c29838c44d80003c623067051617f2b5e

Best regards,
-- 
Matthew Maurer <mmaurer@google.com>


