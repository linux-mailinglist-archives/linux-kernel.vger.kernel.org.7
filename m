Return-Path: <linux-kernel+bounces-790079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F44DB39F12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCCC171AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DA93148D5;
	Thu, 28 Aug 2025 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tufBIF0c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7D1D5150;
	Thu, 28 Aug 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388036; cv=none; b=uXTLBpqNyxsxOKcD1qa4uLAU+g7q3dqnZS0Scun3WQk3iUyBAZKmGY6dNfI9Pmq+WIaO32Bdv6XLF6U2mJ9gbd3nOYpRzK7ey3HWk0sZQmdhdaU0pwCT6Cbu609TDDYNCUojHkLMmMmr1OcKMCcx+DpxpmIz2OU4tDxZ9ZQ5nXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388036; c=relaxed/simple;
	bh=yR4vSi5k8JEVq7aDA45SJHV0W+6kRG5djMrcwSLEFzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGiFGJdviZx8rzW4n1eJ2sM/Fl1eSvoX43BqeZfy4uhjmt4Cd1hH3M5tr61Oyi8it3Gu09ljxCIj/0Fb1IRal2gr34nmdtQ+WYIIMkzGRgxAIUNJaWpF+7pCvc4Qzagz1DhGV7VhhpJLU3aB9oHIezOyZFJ5XI5OIe3eXJTU9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tufBIF0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDAEC4CEED;
	Thu, 28 Aug 2025 13:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756388035;
	bh=yR4vSi5k8JEVq7aDA45SJHV0W+6kRG5djMrcwSLEFzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tufBIF0cGNzlNoU2ZMC4o1c8khlWEr2mM7SKrAoh4FpFzQ2qigODozUjtVO6Q7HtA
	 242xRCMpuAioK6trHHP2pkZaPdQWHzQ9xJGSP55p+YAliVd8IhSS2D+n6TN43OIXb7
	 OOHB7RA2qOvr26E5v7S7/AyPftwc8LcuPzyYojItKfiYCrPKMmCQT9HSVYddPuHLFG
	 lDNK7bOTOD1JHIRQJNDbVfBnLFQuihBdqtSu8B9itP6UFvIgGWARg2JT/3YegIyoRu
	 VPQgb+Wf7dKzsLtaIsD33oFpIMQcRMyRaEqlyQhQ+TLDOgvz00Lzp6S3IPTZtgaAOg
	 1HWTtQ1nJF35w==
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
Subject: [PATCH v4 5/5] MAINTAINERS: rust: dma: add scatterlist files
Date: Thu, 28 Aug 2025 15:32:18 +0200
Message-ID: <20250828133323.53311-6-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828133323.53311-1-dakr@kernel.org>
References: <20250828133323.53311-1-dakr@kernel.org>
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

Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
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


