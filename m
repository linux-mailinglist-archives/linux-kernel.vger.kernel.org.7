Return-Path: <linux-kernel+bounces-733191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF75B07158
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5925820DB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B162F49ED;
	Wed, 16 Jul 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6Q+DBjy"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24D2F49E3;
	Wed, 16 Jul 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657004; cv=none; b=EdNYxzs1zuiFHneiEViOdVzeuABDElf5pq/wgKY8dQw0t/rabSAdGDxOTAuV2Gug3ZfPHxod2RkflRhG1bL21RvE3K2p/CI+QWPPFUwZ5jCDprpDFCwV3skHwy97r5tmJUeTYXEzLXirrZ+K5zFLopJf7JRruAZkz3bPEqbV5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657004; c=relaxed/simple;
	bh=zL8ahHipP6d7L0VyozPMcr3d+eAgsfQfsEFdgBE4zIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hGkVX8NyKppCysPs9C2b2tLxCqR/oG6RKElZbiqPkAHxlbRQ5GBJ7n8lq/x9+/eYb3nd4NdYGBAkLEIVOzktN84piCwfAXnO2eFMvn5/vw+R4dNrAy75CyVVSmtroXyuZLqc0puptwuS4Q7FHmZUvujLLS/jRQU4TUjcjjJaLBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6Q+DBjy; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-749248d06faso5375849b3a.2;
        Wed, 16 Jul 2025 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752657002; x=1753261802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bdGXm9SCphY8DlE94vXROEGjLyLoWcUww3peagjrA28=;
        b=I6Q+DBjy/ZSf6+ppAM56eH0lstC284s5GY3argbClKvMO+UUF3Ib2S+No6tQkZjNOS
         5CAdAI37uEbeeLiDZO0aArWnetwGzwI6QWwIyIm9Dwbiw5g3EGr55kGLwspbwcIwRb7B
         HAPwnyvCPg1W8WOPlrjayuWpodaStYRv/jwagD94Q57a6+kh8R+sfrlvLzftK1Wh/7ky
         lYboeesxKNvEEXYmsdsgXekKdc56ClxNEeRpqvqqeuHKvdF4BA3+VnpimQ30xNHyHNX4
         SKayoXeCDqxDELiKRJYAkA0xBdeHUChtlg8WLHLh9X25Ipsd4vDoW/0FVgemU9DbS6nP
         rWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752657002; x=1753261802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdGXm9SCphY8DlE94vXROEGjLyLoWcUww3peagjrA28=;
        b=bxHkfyvx9LIHs4930WWM4B9ElWh99tQrzFM8Hb3VCHds6j6YC2cN/qzkRjbABDplMv
         yBGROc+VuyB1qFYRHczR24z03GVbp0+ZnD+9ecVjtkdhpOMTZ5/wECqCuEq1KUADCTKM
         gjCzcHEeYqpORe2BdO+vazFGiwvMgJqeM75IqN/PLEvAoDxwjQTc+SDMT/+0R8ddOT3G
         7kxua7EgN8SdHQLNADRCM4RQhD0MwYiTLn1k5DFXqANlbA2oNsDdG8KaaOlck7BhvECR
         3GjnQZl15iS/09kKZ/insg8+VRiLgMJvaJs3Cf5Z5TR/dMAaxYsE5yYGb8G7UMCtwybZ
         ZTkg==
X-Forwarded-Encrypted: i=1; AJvYcCWG+2aUPxaDSbzMEcb/pxkzEfZr277cQrqMZ2cKJagZWdiFJbpOullbo4z6Tog0lnrIEv32iUlGEOLCevs=@vger.kernel.org, AJvYcCXNZKKVIcjVw9HW01dbZYybhlpal2oGr9aLCtAPKooFO7PBX6jYTPiABvVLp54hb+1vnCyXLDCnhcf9t7hFoYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMH2GeRgifwIVuoOXFbNmBTr8dfzwybhWueby2yV3YaDGqiqW0
	u2I5nwC3F7uQLxuyeDuVFo9noqLEFW/KRF8TOlnX6G8TIii2z3AV4+xe
X-Gm-Gg: ASbGnctxFM4JOqJcw1T9DXGdk5l413vJSG0b+IwAwmehRp6Rmy9PMznBU9be8Z3dpDc
	SlHfh2UOYJ+mTYrGWct/yc7nuxZqWsh2xPm5bZVTzjERwLwNQI0b5VsbFTbsz2Wr78ZEiFJaIZh
	gXyYtBnXVY63Nbd0Gh8yVuuj6jm67Mx/9Tfmm1e4DBqVxbdbB3pIiWF7LbepUYJa1UXUNhvGC0T
	3bzP+Q/Ihf3IHoUs1L/23bn8OIJA3ocAgaCHgXbzAkzYxRMzKh0snBbuBDktWTby+rqrslZNY43
	GFXUAaLn6HHGKjBYbTWqBaKQdqkQ1D9KEImJohRJu5ja0DPNPj2fppdwhqXCXCWa5eRi8z152oQ
	38wvInrl/kIy5MKwiLjyKoRjNogCFJbCbSABN6BvS5A==
X-Google-Smtp-Source: AGHT+IF8VHdQWd4VhFZ+U0x2R2wD3rpjE2LfC8/XJ0q5AiF6fsay8YUMtb+u8HbdtzrH5Ek3tMvkDg==
X-Received: by 2002:a05:6a21:4593:b0:235:df1c:7b11 with SMTP id adf61e73a8af0-237d56ff576mr3602575637.12.1752657002093;
        Wed, 16 Jul 2025 02:10:02 -0700 (PDT)
Received: from shankari-IdeaPad.. ([2409:4080:410:5eb2:5b3d:132b:96fe:c1fc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe72912asm13362473a12.71.2025.07.16.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:10:01 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH 2/7] rust: gpu: update ARef and AlwaysRefCounted imports from sync::aref
Date: Wed, 16 Jul 2025 14:39:41 +0530
Message-Id: <20250716090941.811418-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites under gpu to import `ARef` and
`AlwaysRefCounted` from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
It part of a subsystem-wise split series, as suggested in:
https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
This split series is intended to ease review and subsystem-level maintenance.

The original moving patch is here:
https://lore.kernel.org/rust-for-linux/20250625111133.698481-1-shankari.ak0208@gmail.com/

Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 drivers/gpu/drm/nova/driver.rs | 4 +++-
 drivers/gpu/drm/nova/gem.rs    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index b28b2e05cc15..91b7380f83ab 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{auxiliary, c_str, device::Core, drm, drm::gem, drm::ioctl, prelude::*, types::ARef};
+use kernel::{
+    auxiliary, c_str, device::Core, drm, drm::gem, drm::ioctl, prelude::*, sync::aref::ARef,
+};
 
 use crate::file::File;
 use crate::gem::NovaObject;
diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova/gem.rs
index 33b62d21400c..cd82773dab92 100644
--- a/drivers/gpu/drm/nova/gem.rs
+++ b/drivers/gpu/drm/nova/gem.rs
@@ -4,7 +4,7 @@
     drm,
     drm::{gem, gem::BaseObject},
     prelude::*,
-    types::ARef,
+    sync::aref::ARef,
 };
 
 use crate::{
-- 
2.34.1


