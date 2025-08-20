Return-Path: <linux-kernel+bounces-777566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CEAB2DAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8735E7BAF28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0472E427B;
	Wed, 20 Aug 2025 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSnAjuA+"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4B2DFA2B;
	Wed, 20 Aug 2025 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689341; cv=none; b=SkFFpiwvrckTjVQFAt3sU5g9GVDVtv48vLPP4A307hkYrauy7MNXbUef4ueor0MDZX5C5Mw/A2W58Fd5n5sWx3/2w2RWIE2/vE1iImf1S7bV+2Lf/OoZiBjdxmWwyr7Fu1rV7c/DJpAylcBWspPlfZeIJknwrpP7v6RG/pPCxmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689341; c=relaxed/simple;
	bh=KMwQZgWhhj9gd29/Q7w168KxOrHurfNtkfHhLeePnCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CTk0OqDHRR4muYMd+Sq2bS0NH5BAZJu1+Xwi2H7BxwRNJjtOUSrUfq7eFdhesIGmW6gqHBI5EBQ+dnwwd8WKNm0XdWQPi0oZJU26JHSSHJc8yRsvo42LpZSIUNHNZslGnAe+3jpKqDLbm1Vno5xv0xQ7hqD1cqtCwXLT/m/sVPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSnAjuA+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326e8005bso6381365a91.3;
        Wed, 20 Aug 2025 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755689339; x=1756294139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOnk2+rOYpz7eECwYsk6p5gDf1G+hGGjc9uxMwX3oe4=;
        b=gSnAjuA+Z70UryvhN3vtdJT5DJlJCEJp+oKB9joOPwpWJ3H5hosY2Zx/W+Lj9/xa6p
         8I8u9vUc0Q6Pl6lGZxn8RXRl92NrvddLunGClURlvn75JwIgzq9dwJmDtMAiIe+UkgeU
         KSW/orjMVZmEO+ZNFYxm3PDoK+vUxARgzStTA3/3bOfttgs0Hq/GE1p0JmrWNaMOF1K2
         W7RQc3TIbAW1th+Gijiici+ZNeKosEy+2CIwDEdfsyWjmqPoet//38zcMCtsQ05gM8VU
         u/nHDJvQBxNFhIWStuY8+vTANudoHbbAfDa3dHwgmTLG4+3O6tYTotZJXSndjfg1zLnQ
         ze+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689339; x=1756294139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOnk2+rOYpz7eECwYsk6p5gDf1G+hGGjc9uxMwX3oe4=;
        b=vkZyO1JHwelPUTiwcqim2xpcxpVmVBMTjKbOgk5YGrI1caluHe7uUnayqkTorF/6GA
         NB6DoLRhom+/GmIa62gqG47cmg2DMGrvRUsv8lBUeyPaJqdPYaN/qV0SAxaq8+QQB+oq
         w0gH0VBAFO7qCvpNoA9XGKrK3JGllws1Pjje2U9OFBVbsfXvIojMRrE9iVn3BnQgDr0F
         xOc6zHlXjw/INbo2fMRji0LPl+OaLOUH3H3EPp8peFE16FQXClYefgHSm2cIkahu+HLm
         Utp8J5xY9yxtTXWZpgiC2Sa3rWNEhewGDoYO5xSWl24/MTh8p7eXHfT+zC4aJm9RGZKQ
         6ZAA==
X-Forwarded-Encrypted: i=1; AJvYcCUESjzuJUWYuS38DkfcnM/YBe74Ovdlom78NXTvThBGHEZQMSDmiQqnWM4Z/Ky4tnmtn8S6kW7xDd9scp5HYSE=@vger.kernel.org, AJvYcCW/q/r7JRVcRaOhTyMRgFchbwEpuuyru0a5AFFtcQhKgCxK4QHF6GjTwp+QOi2uRhcpgHOIc2V8S7EZljA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGUcjCXH40+SRgm17gI5TWS2oVJNxG1BegQlVz9GcslswLxlY
	hy77bIVrdVKxDFbxln9n1Wt3scSpdCic46Y7Oxmh297tAXleXeEJYl4c
X-Gm-Gg: ASbGncsnp0giotcnL7MOTgc7mFYEBmjWZJ8X00w8jcDXEN6p7qNBVVLs6BpLOwH7lny
	A9jgvPCuEcYUxtweUQl8OcBxPJ/xSen4vQ3dLm/6UdfnFTxA9O0SlDXF5AAty9ka/Yzvy1xTMFv
	lp9debO+jbTIfhlacmjBY13ue1vKjKhORvMWryXBo2EfTg8jbow0y/lCPhLlOG7oh/6+DUTZdd/
	Wab64M3uNdq5HUSOn+CsfMWUixLTmTGgJ/d+QNkWydqvjjihQPASw7igPrRvBZReO8KaYwit64V
	OIG7d1XZQofE9dA0VDbsLuLJv8pwChOE6JdqmoAKpbqJW2rIaNGd10OP+ay6x8WhydtJRevQXeQ
	H6KihwXwm5yVMgiT6lwT8b1Ewo0NvTyTRiIacdqNOsNXOyqY=
X-Google-Smtp-Source: AGHT+IHC1KRrmEby70STQpwjwfXQJpf3nJ6cbTi+qa72osCtJ7TF9Egj/X+S+o+F/xIiixul1wuoNw==
X-Received: by 2002:a17:90b:514c:b0:311:da03:3437 with SMTP id 98e67ed59e1d1-324e1463fb6mr3542427a91.27.1755689339366;
        Wed, 20 Aug 2025 04:28:59 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640d509bsm2114621a12.55.2025.08.20.04.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:28:58 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH] rust: nova-core: Update ARef imports from sync::aref
Date: Wed, 20 Aug 2025 16:58:46 +0530
Message-Id: <20250820112846.9665-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in nova-core to import `ARef`
from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
It part of a subsystem-wise split series, as suggested in:
https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
This split series is intended to ease review and subsystem-level maintenance.

The original moving patch is here: (commit 07dad44aa9a93)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440

Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 drivers/gpu/nova-core/falcon.rs | 2 +-
 drivers/gpu/nova-core/fb.rs     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index d235a6f9efca..645e65175cb6 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -7,8 +7,8 @@
 use kernel::bindings;
 use kernel::device;
 use kernel::prelude::*;
+use kernel::sync::aref::ARef;
 use kernel::time::Delta;
-use kernel::types::ARef;
 
 use crate::dma::DmaObject;
 use crate::driver::Bar0;
diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 4a702525fff4..68559902ae78 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -4,7 +4,7 @@
 
 use kernel::prelude::*;
 use kernel::sizes::*;
-use kernel::types::ARef;
+use kernel::sync::aref::ARef;
 use kernel::{dev_warn, device};
 
 use crate::dma::DmaObject;

base-commit: 3ac864c2d9bb8608ee236e89bf561811613abfce
-- 
2.34.1


