Return-Path: <linux-kernel+bounces-771260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FAEB284C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CDA608154
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE5F30FF1C;
	Fri, 15 Aug 2025 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVc/Zvm8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DB930FF12;
	Fri, 15 Aug 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277887; cv=none; b=TkLCTqWkHtSBsUOjwn9Juo8aI1EfCtuDswa+4ZG70IcJJDv2LPKHNxuYq/kU9uJ+Y2tfnqTZc5vx+a4I025e7U3ZEL2e5Ox7aYdn3NKYSB4um3R6KoD7FA12VS24dFQeJZST4gSV1G4HpBH9JdHHai6/hftKGYvwHKwjznZylWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277887; c=relaxed/simple;
	bh=mXfSjhJXgufvKTeMOyP/zIZmkN/iijvNZsO0+6zn6/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFzmc00Rh2EHFi8QBWxXQUm3IrEgpk6KB7P+JDjiwp4LSDANNRz4n+mU0eSmxeRMa2SdM0CPW9256XY4QiQ78ZUqzGU4Rl1vEy2/F2UcoH6AjuEVUjz3kRArvg1hvdo7XAOkCcrS4WD89KsOUviZkLLtXz8OkeYj4zkdzYogseg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVc/Zvm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA2EC4CEEB;
	Fri, 15 Aug 2025 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755277886;
	bh=mXfSjhJXgufvKTeMOyP/zIZmkN/iijvNZsO0+6zn6/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVc/Zvm8wdZ6kWX6jDljRHNB+Js4F4YytvGDx/y7OWJYKRcnEWCuvZT6HXwUPCTC1
	 8cV+zZhEJMjHJo9PNlzG0WxgEvgl4+KJNMugsb6IgTAvlH3MKePtj013iu3ySXZDAO
	 5Ggq49zIWPpmyQzX9f9D2257K3e9+PGd7GWdbe1O7YNZxKtwDWZuv945Ne4Pe2UikN
	 5ttC3nDoliv0jDSGESLw/vPBIn7kT3catr6wBP8yAh1lg8ZADc5nZBp0sgn1S5C2A8
	 VSJmAa05a4lbs5BpEAY5IQHBiLoqCX80c+88+0i4HoHrZvYDsqf+b4+zfeFJGWtVB3
	 zwVOCMy/VOu4Q==
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
Subject: [PATCH 4/4] MAINTAINERS: rust: dma: add scatterlist files
Date: Fri, 15 Aug 2025 19:10:05 +0200
Message-ID: <20250815171058.299270-5-dakr@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815171058.299270-1-dakr@kernel.org>
References: <20250815171058.299270-1-dakr@kernel.org>
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


