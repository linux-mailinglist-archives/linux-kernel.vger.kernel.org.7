Return-Path: <linux-kernel+bounces-733199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D23B07171
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE8856810E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B82F1989;
	Wed, 16 Jul 2025 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXntpoEG"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8C28A1C8;
	Wed, 16 Jul 2025 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657524; cv=none; b=L0TbxX0qa+u+FHC7m3DSFrljcyQL0CRj7ytJtgcSBFRpqnSX3DJTAl7XOd8JBnyvTuoGmELc6yA7CWxQ/iTxBmS9J9Az2Dv+i4dojTfSINWZ2h5wDAbkYgczU5qR2F3Nj70ihuYQLe+dwg7BXUP2GaPqoJW7SeCsQZ5IAd7NH/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657524; c=relaxed/simple;
	bh=FmEN8qfIo9m3IHpTF4l3C4+ShBhgn9K28femGDj+sqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=okrHtemiJTLRG0KPSkzpG98cWPlsGoRq7oN/4yZ747zu9yMRrVFGt9x4+R5h3bhPz6uUnY66+YTebaQdy/r51p8GxAiScXBdOyw1uaQjmaB5T5hDVGm7xXPH5wOfZUvP6u5ndMpssn5OEUJGxtyCFT5Ztf8rpAMIE7sHqjbZJ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXntpoEG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23649faf69fso52066525ad.0;
        Wed, 16 Jul 2025 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752657519; x=1753262319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ0KHkkJP3t+pYkS2EAcCSLwi7qvEYZO1/eDZ+QTODU=;
        b=NXntpoEGDvVw8uxIxxiKyOk7POWY4WbJu519sz4UX/aXuUCtQZ1iGFiaKfjr5uIIlP
         f667N5Ll5l6xhYFdIQ8Is9109bfDyqyibr0LGCAF9ZJVjeAepIjjcq/zphyiMRz/RwgB
         SzShPSDVMTQF2P90tiLNC4tfBx0Zzf3jxe/1jyneCS3yunNT1vlOaUVq7CfI11q8xtjq
         k0r+gRK6dYUZC/+uzcOHc5a5XJtwR6DBmf4Qs/QNmi+8Uf5q3v8u6xnn0/jDhpMoLEid
         K5Y6Qh7TrnWfiDD/NAqImHu2kmlnu2FiDYFxidErY+5xQFgeclNQwB9SIBqXui1yqy3e
         QtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752657519; x=1753262319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQ0KHkkJP3t+pYkS2EAcCSLwi7qvEYZO1/eDZ+QTODU=;
        b=ePwKQQcHmWZ0UgGoMoz/bItoC+0CHIb2MU0gtwGdsCLSdpuUBjZtwZnGradO6K/R1Z
         hD3J7kD7fbPY5h6/q5lMmD/VFFI6x8+el6ym1SX7HtXZL9M6MhBv5/D1ySaaJL8C52/F
         G9OQMNlYro1V9lrikBhKnYZsOF93616sNFlcWhjBwTesXtQTWOCkE3IMtmI3Abd0488m
         6sPORfJrsrnivhtQFUmDC0ffS4E1i17TKP25nUVgo8AaMAdoC2V+QudYsoxLg1xBU2W7
         y4AS1eMa9VOFeMBRbEoUFEdvXGYfO7eOcpWZwKYytWqO7wNKgXwmsqBaMMFDIRqVjIr1
         3qwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBLPF4qJVKn5ttNbOgmHwKkfMiKdHJPdZ2fg7LjVYch5ws1J9Q9qWqSbCXBqmU1sR7E8gOebzmYM82f4Y=@vger.kernel.org, AJvYcCV4Jai+vUowrim24yTNqxMQBZJhC3CEbS3kVwt3Eg1Ugd6AdC312KKuEm/JWkykKm/nRVCzkqXo/oZqwlcfHMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3x5Nax2bUN/JGadJP+lC1dO5qWrVLXQPAi/Oblk8dvLVBWmX
	QR1c0r+bQ4sY5TWlT+NyzaZP0hN4X1MQqRuhkosgixuw95uM9WMfqIZ1tKBcYhM7
X-Gm-Gg: ASbGncvRnXm+qqa0PTurzLlLyDmHj6NAluC7h3ahCBcvzPh5wbw648hA7i6lAYCL2vq
	bTexI6Pi6xPfxeu8T9O4uDuuJmlKhEbPT8/Tz/Ho5MBYCUxkwoR1sBaCPqs6loCWT26HWwGup9v
	mg1vHQ962zv2wcyAfCQ0YzF/RkVXuCe4MsmQpueiDHZd4OsJjfIqWd+I+2seVP05qo8Z/q48kvc
	Rrag+fZdD6vJTk9YON67wZvHyZG9wXerd1rhyQ3NFQr6A8hJwOPs+525IJNDkh0Z4/X5oQLMy1O
	ZzG7exlEr942zH7uIFlujVI2lqRCGIfwWL8RMWHgWiIHPGSidm3qYKUgiG1ulhrhZisii8jwyfC
	5gzJSd743otB5hTE6G3EdiTK/D5PHdKChnPX2E9oATg==
X-Google-Smtp-Source: AGHT+IGhUtW8bAGAYLU/066dIi3oGvcDCgkjPJ/HIG78utXWmpR90D3xR9k2g5BL1NjbhLjbXyK3/g==
X-Received: by 2002:a17:903:1c6:b0:235:779:edfa with SMTP id d9443c01a7336-23e2572fe66mr30326545ad.32.1752657519361;
        Wed, 16 Jul 2025 02:18:39 -0700 (PDT)
Received: from shankari-IdeaPad.. ([2409:4080:410:5eb2:5b3d:132b:96fe:c1fc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4323cd5sm121808585ad.126.2025.07.16.02.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:18:38 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH 4/7] rust: fs: update ARef and AlwaysRefCounted imports from sync::aref
Date: Wed, 16 Jul 2025 14:48:27 +0530
Message-Id: <20250716091827.816971-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in the fs subsystem to import `ARef` and
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
 rust/kernel/fs/file.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 35fd5db35c46..18cf579d3312 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -11,7 +11,8 @@
     bindings,
     cred::Credential,
     error::{code::*, Error, Result},
-    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::{NotThreadSafe, Opaque},
 };
 use core::ptr;
 
-- 
2.34.1


