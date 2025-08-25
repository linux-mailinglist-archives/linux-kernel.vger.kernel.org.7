Return-Path: <linux-kernel+bounces-784753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF9EB340A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61C51A8532C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18D9279917;
	Mon, 25 Aug 2025 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THoeUpgC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD0274FDE;
	Mon, 25 Aug 2025 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128370; cv=none; b=K87sszUygQmUs4c1wIRx1O17Y+M7gUT8fXziHRs4AEvA0hqnl8CP4UGhMTIFXPtCGgraK62Z5Yxm1caEf1nILQErqmt1j6ZUVZCzLPMaxFNPXC0/v/kMsDLFaZJ1ekuyH6ohB8t73sWT+t4Gqev5wdn3wgx+kHPyY1/mhuu9hoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128370; c=relaxed/simple;
	bh=E4wCK0TZxjppsY8JGUrvDL9UhfW0ST7KROT2/IHhT2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIMflJh/36F7kFlHHSWkK0YhzTI7L4ics3xRXN56SuygSj5/K9zyaZOF5Gybv19ZoDkHy9go4V4UTxEwG8Fp1XekYbS5GKYTRTkun3lG/wGbz2QaTNUm8GWEY9gtQ4ssnYRhYhLGqC3MtN/BQwS7QSasmK8agppAWwkPal/7yvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THoeUpgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255D9C116C6;
	Mon, 25 Aug 2025 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128369;
	bh=E4wCK0TZxjppsY8JGUrvDL9UhfW0ST7KROT2/IHhT2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=THoeUpgC3Ho2A4YS5B5v7efx2bFN5X2GlW/nKbGKeIQdK8C/FBG4pkdLT+76z/hIB
	 I4SX31T4vAr5GpDpsyMN9avkznyKCAKl3mQXEDVTam6YXGb1oqpqRzbOXwTJI8chQr
	 v08XVmJqNN/6w89n1Q7xWUR8C/3B5a/TsvOKkoe8cjHEIvPIJNxuR2dsnbTcJsL129
	 zcL/LN9UHyctZ+POfEQMr/QWh20rrzDMoclSLNxvZexRyGHo0Hio23DSAe0e6X54Jm
	 l6zgeLR1Y5rc+SUPn5hvNuFek5lK3zbWCP9h0VdsUdODHLlPmzOilw3jUSia16s7IZ
	 RfNahSmH8uggw==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	abdiel.janulgue@gmail.com,
	acourbot@nvidia.com,
	jgg@ziepe.ca,
	lyude@redhat.com,
	robin.murphy@arm.com,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 5/5] MAINTAINERS: rust: dma: add scatterlist files
Date: Mon, 25 Aug 2025 15:24:44 +0200
Message-ID: <20250825132539.122412-6-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250825132539.122412-1-dakr@kernel.org>
References: <20250825132539.122412-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the "DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" maintainers
entry to "DMA MAPPING & SCATTERLIST API [RUST]" and add the
corresponding scatterlist files.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..65f676b2c304 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7238,7 +7238,7 @@ F:	include/linux/dma-mapping.h
 F:	include/linux/swiotlb.h
 F:	kernel/dma/
 
-DMA MAPPING HELPERS DEVICE DRIVER API [RUST]
+DMA MAPPING & SCATTERLIST API [RUST]
 M:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
 M:	Danilo Krummrich <dakr@kernel.org>
 R:	Daniel Almeida <daniel.almeida@collabora.com>
@@ -7249,7 +7249,9 @@ S:	Supported
 W:	https://rust-for-linux.com
 T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
 F:	rust/helpers/dma.c
+F:	rust/helpers/scatterlist.c
 F:	rust/kernel/dma.rs
+F:	rust/kernel/scatterlist.rs
 F:	samples/rust/rust_dma.rs
 
 DMA-BUF HEAPS FRAMEWORK
-- 
2.51.0


