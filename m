Return-Path: <linux-kernel+bounces-806851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA28EB49CB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B8644217A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885842E8B91;
	Mon,  8 Sep 2025 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRz9PwYK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97A02DAFBF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757369235; cv=none; b=BEm640b3fwMUCbqMxpyZPXg5d2E1m/JPv+thvv8kQIS/m11vePUrrjDmMmDoygS+yBsXHo2o7FQKSbu0RBlKDpci4+2LrXgo3XfpZJKcELk0Rc+YnSiOvuv9JK546aMkztuNuJZKp93Ll6bdyOEZLCb09T9lDiKlsqXmotofLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757369235; c=relaxed/simple;
	bh=p/Ims0Ypd3d/7zo9k2sG0p3wrCwhThGPL1JeFbGHwn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZhZ3WZsM+6bWuOc4sYd5JaJQwJVnNeRyNeQxWhYeSDS8Anm7/JLSFNXkXwe09+4WhXK1HkAXlAor68/V4FexL+UK3jLC+687AFpBmKEF335GcUFfWItIlsy/Ha57JLcYL6n35PCegPThRTVF1f6V1wOl5l/SLLHVGp5jG/0A/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRz9PwYK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757369230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JkoTyeNf/GPBdyB+JgS1FXgnD5G8Br7KbPR2/Egwx+w=;
	b=FRz9PwYKTVuYM1O1LZXEecJw90bZB+Z9g6Gla+6hXHzO/52uGbh4Yt19roWTci59J+ynF8
	t/+ARbmjupR8hiwBWp6z7Us9F2/1arbB9zeTNeky6sdiURG5QTyxg6/Fz9PDSwkIuEF0J/
	8PFvTwXQRRxCRyGr+KCJHWasJT3HrHI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-Mvf5fWX7O8KXB7tTI2FKdQ-1; Mon,
 08 Sep 2025 18:07:05 -0400
X-MC-Unique: Mvf5fWX7O8KXB7tTI2FKdQ-1
X-Mimecast-MFC-AGG-ID: Mvf5fWX7O8KXB7tTI2FKdQ_1757369223
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8702195608C;
	Mon,  8 Sep 2025 22:07:02 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.64.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80E871800452;
	Mon,  8 Sep 2025 22:06:59 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/2] rust/drm: Remove blanket AlwaysRefCounted impl for gem
Date: Mon,  8 Sep 2025 18:04:43 -0400
Message-ID: <20250908220657.165715-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This patch series simply drops an blanket implementation of
AlwaysRefCounted for gem objects, which would cause issues if any other
additional blanket implementations of AlwaysRefCounted were present
within the same rust crate. While we're at it, we also introduce a macro
in lieu of being able to use a blanket implementation.

Lyude Paul (2):
  Partially revert "rust: drm: gem: Implement AlwaysRefCounted for all
    gem objects automatically"
  rust/drm: Add gem::impl_aref_for_gem_obj!

 rust/kernel/drm/gem/mod.rs | 59 +++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 20 deletions(-)


base-commit: 6b35936f058d0cb9171c7be1424b62017b874913
-- 
2.51.0


