Return-Path: <linux-kernel+bounces-773698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED85B2A561
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B44E3602
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EB9322774;
	Mon, 18 Aug 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiFxPtts"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B616322758;
	Mon, 18 Aug 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523701; cv=none; b=J6isQlUmnES+lo0gR3pym3u4C+MzO7XakL13GIQ0kTpX1MU+WnJRVcW1HnUV3uOqU55zPHOQBu4k6OtuOYpokDztlvRKLz8d8INqN2dEvyirtBpHYA3rcpe94hU8VX/d3D/tZoEiQjSttbyHdouljMpm2/ec9qRec7OCcUEXziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523701; c=relaxed/simple;
	bh=hu+wC9o4/iBfS8gZyDOUykSMNBQ7IB/Xd5fQW6obhX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Okx42oPUGSaCzuUYSTnshCbRc93X9YcQ0qZsO281mn9C5e6mmkO7wwJ3ncoNokkD0nAwsajQHjtS+Ag+P6PoLr3sO1nhE2WN0eL07+oUjX6xVfqlDuTmvEeX/eXbktGrU4gWwJF1C19RCYWbpX5R45Aj/SBcAvI7tGbyp/DsqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiFxPtts; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ea6ccb7so2981494b3a.2;
        Mon, 18 Aug 2025 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755523699; x=1756128499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ayzPOdwvY8tPmqgeF8sRiSj9U8GhYk7C9n4H0zOIcfM=;
        b=IiFxPttsLXbQpLjJ/G6PreijoI2G6QDHT3iNqac7jRNAkConTSQ7kqNuNge0CZ7OJy
         b+1TiXhpgdiMk+IJI89kCkLa2Kb12UDZB9xFW+Mo48fCDPHEf/cgW4OAz1CQUaGaStTW
         C5KlynT6Ob8wSjx6IyKM5ubsFZtkGE+B+W9urS7RjCJOJrqvlawY6FdnrZHR8PYHmwzq
         Yxraqf/enDj/xdi8RJ3TVdx9tqDVilrqZYuORG3ENwW90NSHhWS/Esgqy2jvgMZWUl/W
         KRPSooYmU9MtTI+kty7bf02gG4eVEKhHNJFtHfCvPuaIM7RAW6aKJkzPrdEM+pG6B9cC
         K3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755523699; x=1756128499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayzPOdwvY8tPmqgeF8sRiSj9U8GhYk7C9n4H0zOIcfM=;
        b=gBNoxERyfGbV5FWggBx/kZj8gcTKhi2jmLFSVHN87cofOtygNh+vX7L6baGNGnGXx5
         gRTRoiFuro2j2xRt/m7u+8rRipuYLXgGv0O451fM1rJadUlZ6pr7+cr2A3k7GlknQQai
         f0ikRODDudCH2ttsCSX61vAoSF2FZNskZ6tjxbEAoPcKU6JJqaroMaAAMuxUl0Y1t4vH
         XGJmq23VAyeu+ZS2I2E71JY6Lx+eYw2S7+M1G7phRJq4V81iy+3pjKBfNoW7Is7ShQ0X
         GcdqsH1sh5JAfvwUz2rWcDIX8h+pTytQl6Nz1sKha0uZMGZVl+mdmLVKN8BFXh9kPK7T
         cHtg==
X-Forwarded-Encrypted: i=1; AJvYcCV5YGFlttBvbfO3uo2W9t7RtsSBdhI3BNNCGOqhp8RSeAd0y7eL6H8uM0Ydzp4odhDwi/a8wHG/g0iXl/Q=@vger.kernel.org, AJvYcCWCv9rFMGTIMmV3VYVpD2F8DBfHYwb+DUd2gg7/9ss7hoRRfF2MlajiqWjxKQat0GeWfd6a1VpSZtLf51LO87o=@vger.kernel.org
X-Gm-Message-State: AOJu0YymaIFKj1Gi9TvYPdjcYrp5tGJRo5VHMw8g65fexT06sz/VStG4
	/JGg9KHz2pwm9l4QOiaL4H0riYPb23bpoInJtRNPy5PNBP4o6x3ZQ5fS
X-Gm-Gg: ASbGnctzjYLzGQULB8XFXwmEoIAKA6dJ5D5pnLIMFiSNv2M9FwyGa9DJOv3CsPwb5gT
	Gafu0+LC/kATuj1eAjEB4lCE+swVCr2ezGYFamRdtcat1v/0NK8PiMd60nqmAoi9tu5dW9fPLLO
	ojX7bcqCfeYqMRJfqzIboz8kU66v4/BXID1XO3Gvri617SmABWHtPK87GheKFLaITKCZQYbDVJd
	9xHUGqHanGan+CZSYVnivfXpSinhcuh30XukwSBQPFEacRM8N0jdOvaTMrbeBPB/N7JbQpaFm3O
	whyRPGDMvoWinEBPIZhRADcsbQd7asyd6n0vuGQ3hgawzaWG1ONsUl2fXOir/ketHHDSFRr+AyE
	gWToIx6B62W3hPGnT2J1oJ6JpfvBatgJmznNm
X-Google-Smtp-Source: AGHT+IE/vZuvkRKmYobqmLKQP+pmEA1JUTFPuNOy3RcQ1lOkbttPAtei9IR/eRYgLa9FxnBNvThHag==
X-Received: by 2002:a05:6a20:4305:b0:21c:faa4:9ab8 with SMTP id adf61e73a8af0-240d2da5fdcmr19154000637.10.1755523699449;
        Mon, 18 Aug 2025 06:28:19 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5d83e7sm8146870a12.19.2025.08.18.06.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:28:18 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH] rust: miscdevice: update ARef import to sync::aref
Date: Mon, 18 Aug 2025 18:58:06 +0530
Message-Id: <20250818132806.134248-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the import of `ARef` in misc_device sample to use
`sync::aref` instead of `types`.

This is part of the ongoing effort to move `ARef` and
`AlwaysRefCounted` to the `sync` module for better modularity
and type organization.

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
 samples/rust/rust_misc_device.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index e7ab77448f75..911b9320d3c0 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -105,8 +105,7 @@
     miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
     new_mutex,
     prelude::*,
-    sync::Mutex,
-    types::ARef,
+    sync::{aref::ARef, Mutex},
     uaccess::{UserSlice, UserSliceReader, UserSliceWriter},
 };

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.34.1


