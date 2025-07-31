Return-Path: <linux-kernel+bounces-752328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571BEB17420
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270B81C23E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6681DFE12;
	Thu, 31 Jul 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+4g5dFa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6259317A2E6;
	Thu, 31 Jul 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976972; cv=none; b=lS2hTbFad3pPaiDh33Vl0z9/6BuY2keJBoFDsmhYi2qHcUZ2rKbJ5UHJfo27up5nM8rOflWRF58270bWU6Ka+VYlLKQgwyUw8gHiaXQYp4wgtfL79s5TfLZoXN6cGR8hZRcgsnvgGsG7gszwIe8kUKLk8Vu29yjhwqkbDmH4YaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976972; c=relaxed/simple;
	bh=EPnS+85CCZB3YSSlWabEu+epgy+Y4fGVAt01JDMlEv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5f4hVMcz7VQGvTgMVfS7RV8BvP/daYbyKnpbukPyRDbLTVhdnTq+Njyvo/m30KQ3AKliWgjpKUc3D6nkHHbtP+L7F5pb7QZxL5OfWzc5+z9BDd7jpbmBoilByEHIK5gGHxo7iBQmOo4alwe9CVdIYX5leADmR/WysyC4lP8pIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+4g5dFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD85C4CEEF;
	Thu, 31 Jul 2025 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753976971;
	bh=EPnS+85CCZB3YSSlWabEu+epgy+Y4fGVAt01JDMlEv0=;
	h=From:To:Cc:Subject:Date:From;
	b=c+4g5dFaReZzRCC9XACkiV5iNmmll02yrMuGGFUYQuPCcV0sS7pZUXpJiXDN6S+CW
	 cuIxLT/kFWJqKbW1QiL3cTnyqGP76pU4quzXb1UzPiPhfIHo56Au61R3fa58/wKloz
	 h2FsqjHjQ7oRc/7DUezSMCA9vi37xGkB9d8HglbRAhsi1ygk33gqjeqffUHexMU221
	 uZIetj/SQCfl5epNmmcGwE+BgU7mwPMYFf/LfmkmImPD3gmhCxFwQUA0KJ6HIMspNi
	 azHCDjCG5dTOuwLnxFD7m00N4uvmg2iu46SGH3yFBSKIbAGLTeljQqRoX/SfyZHc4B
	 c0xERPu52GP7A==
From: Danilo Krummrich <dakr@kernel.org>
To: lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	urezki@gmail.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/4] Alloc and drm::Device fixes
Date: Thu, 31 Jul 2025 17:48:05 +0200
Message-ID: <20250731154919.4132-1-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series replaces aligned_size() with Kmalloc::aligned_layout(), which
is subsequently used to obtain a kmalloc() compatible Layout for
__drm_dev_alloc() in drm::Device::new().

It also contains two additional drm::Device fixes; the commits are based on
next-20250731.

Danilo Krummrich (4):
  rust: alloc: replace aligned_size() with Kmalloc::aligned_layout()
  rust: drm: ensure kmalloc() compatible Layout
  rust: drm: remove pin annotations from drm::Device
  rust: drm: don't pass the address of drm::Device to drm_dev_put()

 rust/kernel/alloc/allocator.rs | 30 ++++++++++++++++++------------
 rust/kernel/drm/device.rs      | 32 +++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 19 deletions(-)


base-commit: 84b92a499e7eca54ba1df6f6c6e01766025943f1
-- 
2.50.0


