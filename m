Return-Path: <linux-kernel+bounces-890952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD5FC4171F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CEDAC34D258
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988B5305E32;
	Fri,  7 Nov 2025 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUc6SSPx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28A305066
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543945; cv=none; b=OtcsSSXtjg1q4SiaXG8CRkItmL4vW2yOBsIDt3P8ol52eFGX4W+n7sCKyiiFEm7bkJalKhXeLMJ5Rnm7WOCzntkt7Z9inwGp+6H/NVNak+a8N6VKMoQNS0UzVaIigWzrBub6FtB08Mx3LMzkyEZIGC6ta7n8R8ZViY8389qpaEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543945; c=relaxed/simple;
	bh=lgcFOZMnSF4vxSfKHRw9kiitpRCfT35inblbW8qaD5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUdG9xevIuyJhZTdpllzdo6SOFH2inFm9Zj0kpKw4He8Bz7YBfbBh5SJznIYuXJwDp6NJ638d3SAjlN01edFTP57Nm+AeF7b+MW+kKCX9UTiLdYGW5wPzhtpNErMsE8nX8D+mP6JvjvXX1SsA7zXRp+Qj3kv3ZSIMqiHyveSMbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUc6SSPx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762543942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+M/hTarl6Axuw1Mn1ciL73V74gFHO/xeAJFqO2OKURk=;
	b=DUc6SSPxM8NSqGNoyJRL7RtaYS9VJhFh7Tf4xr0hznC7LWkEamAXwOIQ2Y7gSmSgc/VSKS
	rtKUe+1VdQj+nVe1NNR5tVffHTMBsV95/jtXGPEskEPlBbUknaR7w0EIj2o0OJ81M8LB1X
	zLUypHMD08GHGrfEf9KyvqsDXk2IiSE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-eWXdUic0OYy9LQDsX6DXnQ-1; Fri,
 07 Nov 2025 14:32:17 -0500
X-MC-Unique: eWXdUic0OYy9LQDsX6DXnQ-1
X-Mimecast-MFC-AGG-ID: eWXdUic0OYy9LQDsX6DXnQ_1762543935
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0549F195606F;
	Fri,  7 Nov 2025 19:32:15 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.81.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DD761945110;
	Fri,  7 Nov 2025 19:32:11 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org
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
Subject: [PATCH 0/2] rust: drm: Introduce DeviceCtx
Date: Fri,  7 Nov 2025 14:23:52 -0500
Message-ID: <20251107193204.398657-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

One of the unsolved issues we still have with the rust DRM bindings is
the ability to limit certain Device operations to contexts where we can
guarantee that a Device has been fully initialized and registered with
userspace, or vice-versa (e.g. must be unregistered). This is a bit of
an issue for KMS bindings, since we need to be able to limit the
creation of static resources like CRTCs such that they only happen
before userspace registration.

While the previous solution for this that I had was simply not exposing
drm::Device at all until the device has been registered with userspace,
unfortunately this isn't enough since:

* As we found out with Tyr, drivers occasionally need to be able to
  create GEM objects before device registration
* We would still need to be able to handle KMS callbacks which could be
  invoked after KMS init but before userspace registration (not handled
  in this series specifically, but DeviceCtx will be required for
  handling this).

This patch series provides a pretty nice solution to this, by
implementing a very similar solution to kernel::device::DeviceCtx:
introducing our own DeviceCtx type state. In the future, we'll likely
add a DeviceCtx state specifically for KMS devices that aren't
guaranteed to be registered with userspace.

Lyude Paul (2):
  rust: drm: Introduce DeviceCtx
  rust/drm/gem: Use DeviceCtx with GEM objects

 drivers/gpu/drm/nova/driver.rs |  10 +-
 drivers/gpu/drm/nova/gem.rs    |  11 +-
 drivers/gpu/drm/tyr/driver.rs  |  15 ++-
 drivers/gpu/drm/tyr/gem.rs     |   3 +-
 rust/kernel/drm/device.rs      | 181 ++++++++++++++++++++++++++-------
 rust/kernel/drm/driver.rs      |  37 +++++--
 rust/kernel/drm/gem/mod.rs     |  66 ++++++++----
 rust/kernel/drm/mod.rs         |   4 +
 8 files changed, 244 insertions(+), 83 deletions(-)


base-commit: ade19c5060dfa39b84a9475a4a6b05e2a8a2b3ac
-- 
2.51.1


