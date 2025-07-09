Return-Path: <linux-kernel+bounces-724620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF9CAFF4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD11A3AFAA2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AF5235BE1;
	Wed,  9 Jul 2025 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTxoiFkF"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356C5944F;
	Wed,  9 Jul 2025 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101385; cv=none; b=tXmhKuP5ENX+LZ+946Seq6o3loB4Z47JCsUM8U9JTuK+4CNDdsDvXHXbooNSUp55BJtVCRlEpXBp/LBygggMVxRXStnnEfkFJfYGVgKJZ5BmXgD/8E/R+cets5xgJyIu0vnVegcVnNjj71CmDaGJIpehhFASz1MCfmii/vzllBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101385; c=relaxed/simple;
	bh=BwRCvm3BgZ80hq9tbXA3a3WNynye8CYtFvwrmxpCQcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbRzdcJSxHA22lZ9QV54Kn4uuAYF9MrMyNH7Cg18468wWuBWl7nzuyHK3ULKR0bC30jkFmOiGF5CLhmwdiVDhcQ8oQW4zgTCVs3i83JdZHBFPo3EaJbODyR2Kdd9o6Qf4Qdoo7h8HswPX+Bg1IBIh7NwuQrmpOrKGXj44CEod4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTxoiFkF; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6facc3b9559so5710986d6.0;
        Wed, 09 Jul 2025 15:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752101383; x=1752706183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8/TzuqQbF0zeJ7arRjJ5OhvWeIWrAayC5nQjxauL6Y=;
        b=CTxoiFkF57Om2sGwhjkuNqm38II0Aty4bKhlxvjFzQnx5N2UIf1ycoXbqPHbEJcUBC
         7OIPjfcx44qpTMQsmRofcb5x4XFaUc2/bqxtJkru4kD+4LUjUNPnVjdaFsiCb0hr5cRq
         I0ClMMdHPzoZQESFiDs4F8pFy7qLBTbfKH4YnUtQuZrkvBW0tMQDzv7G4XbaTT5i38p1
         RhUX+Asv+Ux31jO3aMwmLc8KYNtxPs6SxNbYqddMoshV2forOBhxQ/CNvBfzw+MMapNj
         dDaiCuqVC3cSaFMoa/MjW07nsyX7eCarQg/I7PaXODnDgisSCAz10ThVN6jqchvSiO5K
         TL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752101383; x=1752706183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8/TzuqQbF0zeJ7arRjJ5OhvWeIWrAayC5nQjxauL6Y=;
        b=YGgAASBdHVLyeGM6Pm6VZDYvAmKwf05Nh/ikwacopgGC3Cphra2C2/MOPNx74xxA5P
         6Z146irTCvLMCggTCIx+DOuwVy2P4LJRS/PTYj0on4V8tM5HdRZc/zHIKBwdFvSzi/wu
         d0qBmPfL1XSx6wXlEnhpBvnxgRpXxAIdKU0MwVvAmyL9shFV4JPNVXugcyTObVPqrR9Z
         4buw6AmnurBrmsjRqtntLcQx8SbAMaHEuCGeNNuPDur3qVM/S7EDqD7FrFnbG/4ydfdV
         xAWyMHOUEBBU4JzpYNhcx7uD2lq5xdaSbOgTX4po3JPtw/rZzdrCyp00uTYaiArbYXAM
         dU3A==
X-Forwarded-Encrypted: i=1; AJvYcCXdyWFKnmlovjix5zgM/+WIvokhbpX8CjuuqaXSEdM6CPLpSYbBFOjalZ30eFbKtM2zTKzqgdfprk95k+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMWSnqYzVhzgsWVcygzZlQWAGNwaPQlSx9AgWzPdKcSv/g2Uef
	dOJ7+wR/1wTwvsqWDm1MMrHPa+F8bXeSCcmpFS9+4HnAdCZsG6bp7eDl
X-Gm-Gg: ASbGncslkEVHNkHBLAouZsnfIg4YcLTb1X52lEtRebBRvC0J0jUi66RrVh+YK6CG2x1
	ES9eFE0e4yJf5VXF5x7OrsDc8wQRQX1BqT+pdcE394/+3fOOc5CDHIXCEumiQpiuo3vw+CPx2OS
	VoTsap47Kj5DkGM6N1cZQYmf2UiCJlOdnLIie4BI5QTi08W5SRNw6MHhBr5RRXAcnNP1Ak74O57
	lifEHPBV2PoAggB4YX7bWV4eW3HfDUcsSFFv/ll2hn9tvbOATcA0JnJyZVgNu2MxuzDBtQOg9Om
	NXJrgdIQsI6OMMX43K56zPlt6cchSWH7K/EWZze/0Qylq2uviVOXxPzV47u/M9ae+dbMxNTAgdS
	wK1k=
X-Google-Smtp-Source: AGHT+IH8OHVbbUMlAkzWHWT4AfeFFO1DMg6+0YJXc2uaqJbAGWNPNR9yaeXXNKwaFn4eqwZJlWXARg==
X-Received: by 2002:a05:6214:1bcf:b0:6fb:4e82:6e8 with SMTP id 6a1803df08f44-7049801ce5amr4756626d6.14.1752101382896;
        Wed, 09 Jul 2025 15:49:42 -0700 (PDT)
Received: from [192.168.1.156] ([2600:4041:5c29:e400:5085:1d69:8814:72d4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70498090248sm1025986d6.90.2025.07.09.15.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:49:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 18:49:34 -0400
Subject: [PATCH v2 1/2] rust: init: compile examples
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-init-remove-old-workaround-v2-1-a3b1be8fd490@gmail.com>
References: <20250709-init-remove-old-workaround-v2-0-a3b1be8fd490@gmail.com>
In-Reply-To: <20250709-init-remove-old-workaround-v2-0-a3b1be8fd490@gmail.com>
To: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752101380; l=1442;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=BwRCvm3BgZ80hq9tbXA3a3WNynye8CYtFvwrmxpCQcE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAEAKByke0NS+RQGlNtlLgCllmhP020mu9LT7C5FFDwzTczq7mKzCC5TtkRR2ZqfYh64TmY+gon
 jk2Ok4T+tGQE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

It's not exactly clear to me why these were `ignore`d. There are many
others like this in pin-init, but I'm only touching the kernel-specific
ones here.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/init.rs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 8d228c237954..f8402c818d30 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -29,15 +29,16 @@
 //!
 //! ## General Examples
 //!
-//! ```rust,ignore
+//! ```rust
 //! # #![allow(clippy::disallowed_names)]
+//! # #![allow(clippy::undocumented_unsafe_blocks)]
 //! use kernel::types::Opaque;
 //! use pin_init::pin_init_from_closure;
 //!
 //! // assume we have some `raw_foo` type in C:
 //! #[repr(C)]
 //! struct RawFoo([u8; 16]);
-//! extern {
+//! extern "C" {
 //!     fn init_foo(_: *mut RawFoo);
 //! }
 //!
@@ -66,12 +67,13 @@
 //! });
 //! ```
 //!
-//! ```rust,ignore
+//! ```rust
 //! # #![allow(unreachable_pub, clippy::disallowed_names)]
 //! use kernel::{prelude::*, types::Opaque};
 //! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
 //! # mod bindings {
 //! #     #![allow(non_camel_case_types)]
+//! #     #![allow(clippy::missing_safety_doc)]
 //! #     pub struct foo;
 //! #     pub unsafe fn init_foo(_ptr: *mut foo) {}
 //! #     pub unsafe fn destroy_foo(_ptr: *mut foo) {}

-- 
2.50.0


