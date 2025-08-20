Return-Path: <linux-kernel+bounces-778226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEF4B2E2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A28A04FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35582337685;
	Wed, 20 Aug 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNEkw1vr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8724233439E;
	Wed, 20 Aug 2025 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708905; cv=none; b=fkHr5WImJDPQF74RkBIf4mZa1YWag2msynkiIKL5yu5aO8SyvnRrIyT6/KBkPcPC/zM4wFfReAch1rX+97RFuar/j00SKWhdeeTzq5DTrRO3TbW9Cx+M01Y/6WYIKxoKfmZ8LbjAIH8n289BvUPc97kQsQUJWJeUiY8RlelMGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708905; c=relaxed/simple;
	bh=mXfSjhJXgufvKTeMOyP/zIZmkN/iijvNZsO0+6zn6/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2gY8vKHeCQ0d1nE1emhJzec1oI1N7bLs+EkzjheiWpHPW/kFtjJqioyRkUC7CxZy+XFfikZwkQAkm1nO9F5ES7OR19yQjoa1clJKMKbpfnBarGCnmVEw8I7T+S7dovLXpX0Y8WDzOfdSnc2lKmnvY9yUCelfgMmfu6ZS5mrsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNEkw1vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACF7C116D0;
	Wed, 20 Aug 2025 16:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755708905;
	bh=mXfSjhJXgufvKTeMOyP/zIZmkN/iijvNZsO0+6zn6/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GNEkw1vrQm66CAq9me4jNz1SiTNHO7pPtayMy1LGw98kQu5W4KJVwKdcrZ3WhS/hK
	 ENNM5u2sNcEw72UZJAwQLsSoaW0bgDKY75CbFPhKHV3uHU/s1F/ypupfU1tVRMEB+I
	 2JljimnqE0MKwdGT0Z6byCSB8tGESxSuTw5JnuLypoWdPW2pWnhvZTIz0R14pH7Bfn
	 p9pUM3JOuBiRwWV52lpvNVzcEHmBliPTYxDAjWHO3rHQbn6CwML5buNN3pmVm4YcrN
	 wh76XUXYf0qNa2VyGSwtErc6EYx8uSylyrTdkFJEqD/bXbD/O9ndkRFUT8ClSA5xM3
	 AKuVzxj5dLi+A==
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
Subject: [PATCH v2 5/5] MAINTAINERS: rust: dma: add scatterlist files
Date: Wed, 20 Aug 2025 18:52:59 +0200
Message-ID: <20250820165431.170195-6-dakr@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820165431.170195-1-dakr@kernel.org>
References: <20250820165431.170195-1-dakr@kernel.org>
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
2.50.1


