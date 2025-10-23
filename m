Return-Path: <linux-kernel+bounces-867803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C2AC03873
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B611A043A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B121828002B;
	Thu, 23 Oct 2025 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmBnUlXN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948E51DB375
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254762; cv=none; b=mXMc0voJ/ln0HmvmWVVZWcV5um8A5v94Z0Evmyq9COJE9H6ADm+FnGR5gmJjccJX6IS6w48bQ3Xzqxequ/qxJCul5bH5uygf7ODRhXDEccBzcAVSFYUV7eeB1GwVrTI+m5gmK7LYWc5x2PHWjgyxIpUjlZvjH0Z/uEwqUSljCR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254762; c=relaxed/simple;
	bh=oM9E3x8Q//oN29bjoNgeJ6s7bj14MX3tem/nnOEWG0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QlA7R2mkJ8oAFo1NDq7ACC9SBv7F9Y6OttFYMBbPiICMTpXlkH+TmGtZdCa34Dv0khEu0chNSzfo3flm/tevqFu62PqEV5tlxVsxGup1NvNUetFbiRGFBr2SoPzorY5KGOMfLCaZevrtsrw0oxYf8uFbaHaGCt2ctY0NJVkKulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmBnUlXN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761254759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T7EXhjseSIPKV3IEY+lfev6ijZOQWgDXogt/oOdDlqU=;
	b=hmBnUlXNp1oZVTsOqZT4f6+M6hlc4hsUW//RtvcEI+bs3L+jPUBbyPK0Z5eFeVaO2sRosT
	dYCaJugJpNCpKqc8sB+m79uYvpJgdO9ptOC1iBWxv+xz88fyVi8Poq/64OWmM9BpBoxCbn
	0UaGUqLQOnMQqmrGxQmSki1tyG4T4Vc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-_RL9-eOrMTmmmVGJks3ghw-1; Thu,
 23 Oct 2025 17:25:56 -0400
X-MC-Unique: _RL9-eOrMTmmmVGJks3ghw-1
X-Mimecast-MFC-AGG-ID: _RL9-eOrMTmmmVGJks3ghw_1761254754
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2498F1800451;
	Thu, 23 Oct 2025 21:25:54 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.64.235])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1349530002DB;
	Thu, 23 Oct 2025 21:25:50 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH v5 0/8] Rust bindings for gem shmem + iosys_map
Date: Thu, 23 Oct 2025 17:22:02 -0400
Message-ID: <20251023212540.1141999-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is the next version of the shmem backed GEM objects series
originally from Asahi, previously posted by Daniel Almeida.

One of the major changes in this patch series is a much better interface
around vmaps, which we achieve by introducing a new set of rust bindings
for iosys_map.

This patch applies to drm-rust-next with two additional commits from
drm-misc-next:

e3f4bdaf2c5b ("drm/gem/shmem: Extract drm_gem_shmem_init() from drm_gem_shmem_create()")
c08c931060c7 ("drm/gem/shmem: Extract drm_gem_shmem_release() from drm_gem_shmem_free()")

The previous version of this patch series can be found here:

  https://patchwork.freedesktop.org/series/156093/

Asahi Lina (2):
  rust: helpers: Add bindings/wrappers for dma_resv_lock
  rust: drm: gem: shmem: Add DRM shmem helper abstraction

Lyude Paul (6):
  rust/drm: Add gem::impl_aref_for_gem_obj!
  rust: drm: gem: Add raw_dma_resv() function
  rust: gem: Introduce DriverObject::Args
  rust: drm: gem: Introduce shmem::SGTable
  rust: Introduce iosys_map bindings
  rust: drm/gem: Add vmap functions to shmem bindings

 drivers/gpu/drm/nova/gem.rs     |   5 +-
 rust/bindings/bindings_helper.h |   3 +
 rust/helpers/dma-resv.c         |  13 +
 rust/helpers/drm.c              |  48 ++-
 rust/helpers/helpers.c          |   2 +
 rust/helpers/iosys_map.c        |  15 +
 rust/kernel/drm/gem/mod.rs      |  80 +++-
 rust/kernel/drm/gem/shmem.rs    | 433 ++++++++++++++++++++
 rust/kernel/iosys_map.rs        | 705 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 10 files changed, 1284 insertions(+), 21 deletions(-)
 create mode 100644 rust/helpers/dma-resv.c
 create mode 100644 rust/helpers/iosys_map.c
 create mode 100644 rust/kernel/drm/gem/shmem.rs
 create mode 100644 rust/kernel/iosys_map.rs


base-commit: 5ae65bdcb867555540169ef57876658262a67d87
prerequisite-patch-id: ed9c46db079eee47b437d10234dac813197bc33e
prerequisite-patch-id: a2c6c70700e6a333d0b4daf97978fd2e07e24156
-- 
2.51.0


