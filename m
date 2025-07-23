Return-Path: <linux-kernel+bounces-743376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E386B0FDDB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1FCAA74E4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3931A273D90;
	Thu, 24 Jul 2025 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIHb7rkw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B0E273816;
	Thu, 24 Jul 2025 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315230; cv=none; b=tROazZ8aGFFNnwqnl+t22lMEVfDFotnmf/fMyxTLtpk+QEk49MwGc14Ue6vT0VrAJhE0IDH/9qpJskmVA3vSEDa/6/QHBsGYYJsCs4uhW9QSJ4N+Av3dhgIyuUgm9cFMEZS7VrdpiwWUg8EeZ3IZGo1xgDYCs+4K+VW+x0wG21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315230; c=relaxed/simple;
	bh=+mgw+5yt63ZCOZCc9nf34vKL5GLOct9MG3MjGpd04KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vz3fBz6JmczFeDBsk0VooJblGrrUYckg7TazGVAC8u9NTuSJGMaCc45ZTVFqIn2i9KQwwKEKS0Nv3vnHsezeWLKJIGTlBOmcGgFVC47Pqz0iTX7s3y2M1XTgDf6qhcVDuI+RC1fWwTW4xGEK4P9Lk1b8iW36ud3Lj6PnE6KrW/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIHb7rkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97773C4CEE7;
	Thu, 24 Jul 2025 00:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753315230;
	bh=+mgw+5yt63ZCOZCc9nf34vKL5GLOct9MG3MjGpd04KI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tIHb7rkwyMFCIoV5QhxO9XBIJjC5DbVhQYrNCgtC548pFqa0SCUtjgXl75voVJUsj
	 TH3wc4sDDMm0seZJR+l4bcW0lKCTD+BPp1YjeT6EmUpb/gsy5wNSjrMCAfCx2ruM1a
	 EYs/sFKWJmEpGOnEvw/ZDIwmub9124oaqCqTqwUOV9YArKs/2D1gSjCBE6anaOHOXu
	 KeAOnNbkUG/zCE6kK2oSsKulE4ZAjCM8Ak9+jHx+pLXaiWE4bDgZnfdWUhNsJ9cfYA
	 9JGbSB8aNSy1ythNskhT+ouiWTQDagvyRiIzEY5Lc2uKojTF+eexLOX6bHoi+k8O3J
	 KJOQ7LEV/+HDQ==
From: Gary Guo <gary@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] MAINTAINERS: update atomic infrastructure entry to include Rust
Date: Thu, 24 Jul 2025 00:32:58 +0100
Message-ID: <20250723233312.3304339-6-gary@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250723233312.3304339-1-gary@kernel.org>
References: <20250723233312.3304339-1-gary@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

I would like to help review atomic related patches, especially Rust
related ones, hence add myself as an reviewer.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd810da5261b5..322d040cd98f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3895,12 +3895,14 @@ M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 R:	Boqun Feng <boqun.feng@gmail.com>
 R:	Mark Rutland <mark.rutland@arm.com>
+R:	Gary Guo <gary@garyguo.net>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/atomic_*.txt
 F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
 F:	include/linux/refcount.h
+F:	rust/kernel/sync/refcount.rs
 F:	scripts/atomic/
 
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
-- 
2.49.0


