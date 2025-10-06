Return-Path: <linux-kernel+bounces-843216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF41BBEA70
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C2E54F0318
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC11F2DCC1F;
	Mon,  6 Oct 2025 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="G1ndKLox"
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9340921CC68;
	Mon,  6 Oct 2025 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768298; cv=none; b=bfUo3Ar3dWtqjW6vfke7WxUfWrqGoLd5gYLqryV6EuYvauZHdD9SEZOeLWcgoXTOypacJIGtUvKZ68C4ZKD7+x4X8u42gt5rvkEUYcqyPfC+l/qAoZysq+sogz+Uc3u0rZSojoTeSF7fXzmNJ4F4U4NiXm8B0UMuf/lQvyv193w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768298; c=relaxed/simple;
	bh=2uY5NoijnwdLmleoPPRrn2yh0v/tr1KGjdpZ1mjviHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofbE2RBFHBM0grYW96ciZDuZFWpkQhnG1v5qmXQgrka3ej9ptFuFEEl64b3YDJkIvDtpVyOxQ/Z6OveTv4DO/q40+2fotIVRBOoLSmRAk0p7TRUard6WFjK4vbS3Q/SGLEg9aJbAD21ff8aguPbn0BMDDrmGNgCNFzXYGVkwaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=G1ndKLox; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4985:0:640:840f:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id D9B68C005A;
	Mon, 06 Oct 2025 19:31:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QUnb3i1LqqM0-XVWqGg8c;
	Mon, 06 Oct 2025 19:31:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759768287;
	bh=2uY5NoijnwdLmleoPPRrn2yh0v/tr1KGjdpZ1mjviHk=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=G1ndKLoxp0HthVEGilprHO0MELdxRUCDGzMNXK722hlgEHv2TlozqZcpu9fdxYum7
	 WPvKhNCZARfJO19jqPqutmnoSaasoRsiTYrThQ1WipEFAqPUUTy918nZWPYchkG4rn
	 DrExsazmvePLYvvRrY/m1vvoo791ckQBM/+nZdUQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	acourbot@nvidia.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	lyude@redhat.com,
	linux-doc@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH 3/3] remove completed task from nova-core task list
Date: Mon,  6 Oct 2025 19:30:24 +0300
Message-ID: <20251006163024.18473-4-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006163024.18473-1-work@onurozkan.dev>
References: <20251006163024.18473-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The task is completed in this series.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 Documentation/gpu/nova/core/todo.rst | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index 0972cb905f7a..de70a857fcfd 100644
--- a/Documentation/gpu/nova/core/todo.rst
+++ b/Documentation/gpu/nova/core/todo.rst
@@ -210,14 +210,6 @@ capability, MSI API abstractions.

 | Complexity: Beginner

-XArray bindings [XARR]
-----------------------
-
-We need bindings for `xa_alloc`/`xa_alloc_cyclic` in order to generate the
-auxiliary device IDs.
-
-| Complexity: Intermediate
-
 Debugfs abstractions
 --------------------

--
2.51.0


