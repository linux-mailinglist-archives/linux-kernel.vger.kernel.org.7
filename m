Return-Path: <linux-kernel+bounces-768510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DADB261CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB73F5A2ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872282FA0F8;
	Thu, 14 Aug 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2Za1iEb"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD42E8885;
	Thu, 14 Aug 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165687; cv=none; b=ZbJ1yKg/BHVUK4hDvdGVeS6vnOJ5S4lsvfx4UcgFMC7IHUU68uOhINaC4tVw4JV4x+o4Sd+V4aDJfmPk/YMTyt+DdRezZQ/oK74QpobWdf+smtnTIki+Sp8QfSBZNSQDvIHp/NkpCGkdA5UZpiqtYW59mWkefgz6BwMEaSAy0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165687; c=relaxed/simple;
	bh=BrDWoluxtku+nAW6JwX2qFZu1TEVQX5iuHLya+uBpYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r7Tl+2BEn9yTKoeMvZnu5cIbEakL881pkqe2n1bJwrsX2maDv0bzJonV0uPsAh65lienk3NS8NGUHXcPN6G8YsPO0glrUzc7OoMorVAn8Ny1yWMNNWEU6ESCwAuFDD6nDOUTd+Dy3rDX+NfsZA8MN9MaJYoUltCU2/a6qs+/clg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2Za1iEb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2e5c0d4fso656399b3a.0;
        Thu, 14 Aug 2025 03:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755165686; x=1755770486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eXsOjMYTb4N096B2RBgHg0TlPam36w84ousz1r3Kh/Q=;
        b=S2Za1iEbBrHLj8afqLIavbFzmBNv1Nwn8VbdFKQPlubN6eCfEtmUitXj1IB0OHZfRn
         brG7zZ3FPh1rKTdob39M1ezW9cEsqYV2MsK6cXFZVSXFYvQ4Ts/ina/896ktnMGwGdSz
         b+i7olZsOT0wMf8TLdm0JXKQRPiahVinb5v5CqjBSU7wj9guCEkanq2lOXAhZpmO7x3k
         M1tBCUumCKiZgN9S0trLuzYPF/8CFeESoMDwxyw90X73Rk/azbYF4xbGHZHXhZ2eda8d
         fDQ4K/Y+Xy267Lc2WYN6lBJHn3vGG9sijWVK1ZjDiS3m22MvNARaTBJyL/ywdXjkVJdQ
         wRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165686; x=1755770486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXsOjMYTb4N096B2RBgHg0TlPam36w84ousz1r3Kh/Q=;
        b=J8Gl4YsHBSlh431wpn1FBtmEHUHvwqawOWj8vw9TCwXc2eXeCAIO+HtRk8aO1USmSc
         u2FjJBL3MWRnXh+ZvBh4Ty6TlH3grT8FERcrzvl06cUQ//cC7kOw70rAMnhiUaC0024O
         MVELqA/iCAizfHeV6vYmSXPYBbyQkdOBDBrKTknH99qikIgbPphA3qaQ620xY38tvtxs
         vroAJqyM6ngHcGO94VNyzbmcYhP4q3vAmKgHhqhp9TbPDQjuiRx2bb41eSipMDpz/OLi
         xC+oQoIl/MEGo6DyPQBhZBOrtUtken/LBNorCFJc685FYpGLWHfvCb6A5Z7Y/4JMS4Gj
         zobg==
X-Forwarded-Encrypted: i=1; AJvYcCVy2J7QGdKEcG/eMSO+xu4BdV5gz0c+7Qa3hAC9XnbnBdRBpfR6bZQ19ggDJEr05AChXLiF4Z8O/x2HCb4=@vger.kernel.org, AJvYcCXofr7AmzBX5tYFb+CTa3P9TQlN7AtL/njyn8b0CWzwIphWXtWBQNMQWcAnPKi4srECnHDNuNxGISDoP4ZdQQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOANIPBj/63mI5XlCcyD+/klEVjskUvGeIeG9OMrx9bAmEtEga
	amox5RqtXNC4o1wL+VJ1Qqcw6gvnS7LPISu0CSqu6V8jU+SND8Gnp4Hf
X-Gm-Gg: ASbGnct5MptKk31yTmV4u/q4ujxVBaa8B2LTl7g2+eq+E1SJ8SE3CRDjOEVnYucwpUe
	8qPjqJWUk4507Kg4N7ZczNhMVY9gWWEVCcQQyA+POcNGcoa2pMg/Gnkib/xvaUuom1WoI7NdFZv
	1QHGuTmp/r1tclw+Ak9d6TrAWsqUtudCJPKi0C8D0r5FQEfgW+zDNPVzefZJflRBXRsZDa4tjXg
	tG2OHY6hPBr6ZzckR1+BbvruLeJ7acsK3ZzbxvDOaXTBgiOQREwfUfdK6KwZvDMaHZr4pElj2SP
	ARsXNmzgDGoT7kErFXv3v60f6ICMDjsdTqk1NOPTgx7e4i5I9pxzsGEpt8hRsPHgrYmH1WPO8fC
	SrxBLL8SEHgHfg4srF6HzzMzWz0QaJ6QSv+DAAFnqNVb5E40=
X-Google-Smtp-Source: AGHT+IHtQtzs4xAhMglWTlMm98Tg62vXGnMsGvFl8G6W60TYRQsjv42WL6mcwaBkuN3cuuOHuM8EeQ==
X-Received: by 2002:a05:6a00:179a:b0:76b:cae6:ee8a with SMTP id d2e1a72fcca58-76e2fd434f7mr3459776b3a.12.1755165685117;
        Thu, 14 Aug 2025 03:01:25 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce84sm34377876b3a.71.2025.08.14.03.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:01:24 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH RESEND] rust: fs: update ARef and AlwaysRefCounted imports from sync::aref
Date: Thu, 14 Aug 2025 15:31:01 +0530
Message-Id: <20250814100101.304408-1-shankari.ak0208@gmail.com>
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
Acked-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
It part of a subsystem-wise split series, as suggested in:
https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
This split series is intended to ease review and subsystem-level maintenance.

The original moving patch is here: (commit 07dad44aa9a93)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440

Gradually the re-export from types.rs will be eliminated in the
future cycle.

(Carry-forwarded acked-by tag and added Christian and Alexander as recipient)
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


