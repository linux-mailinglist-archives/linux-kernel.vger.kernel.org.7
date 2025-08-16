Return-Path: <linux-kernel+bounces-771998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31470B28DA1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E6E7BD581
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F285F2D3725;
	Sat, 16 Aug 2025 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWo+G+ez"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA3610E0;
	Sat, 16 Aug 2025 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755347038; cv=none; b=dlHoexjdbcEORnpZcavkOLvcQfjTaN7KCG+ffq7Q0Gy7gRiLNaxGZN2qZMwUBLAdkuKs03rjnW0pVgxYxFkwY9eX7nOiEq3QPPEiET2QhWAPJ3R9Gi1iJxsibrNdgpyt2XtRvadiMlVtN8zBlrx11FT/OxVGI6C1kRKYI0451Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755347038; c=relaxed/simple;
	bh=Kw3ckJdMKLwKyYPtDkqtkG5zp0Qi2AV7UZqhMV/thao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DM2iCKdTOEVDvXY2HFRQMOgNuiwqn71cmZ1gTtxPzzW1OqgTa1cD65YIy8WnZXatdr015XDWrxi90w5ngm5Z1UbhflR2QLIqSKJluqlfm1627p6xdDBNZ2KVk+9NhIXmoCiVlyVGXL3xk0Hrk6qJZCPp1tPSV491hOi4AOHtitw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWo+G+ez; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b47405591ceso25064a12.3;
        Sat, 16 Aug 2025 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755347036; x=1755951836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PqD22COtEsqkj19UV5+ZhECL+s35NUSUGBG/o4BDvJI=;
        b=FWo+G+ezZus0EkUQM28VQActWpSEiOt2paPAPICd9oeAWfkoUW+/wJCojfqnW+tKLw
         2lzvp68dZqKUfUnIScKHgjyk4GAoKTu/BXX7AaNslQCwdslH4xkQFLLdOffmVBfISmBZ
         lHnQOTxDJXW9PmDeiaZf/LQjxEfeAfVcg7kZEvoU4RoR0Sy6/lEAIZQfMYT8g2Ett7wM
         BACLyO39DTRMdGiztsOt9yXlu3MqkBiQ78i2D23UDqnCMq0bqIW9Meof2YZz+F3KsL8g
         Jnf3iuJdJBlhjmVJroBBaWosyh5qa35zcHg9/jCXAnibsp66wVr20ctB1hwfb0IHzhU8
         m30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755347036; x=1755951836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqD22COtEsqkj19UV5+ZhECL+s35NUSUGBG/o4BDvJI=;
        b=gdi+Jk9JDGrar8BogbmjLDkseGiCqH2Mqho0dKfyX8GsFLOlUlArto2hTIv+foTr5L
         7r0zZ83WCqgp2/eUEetUhBMqsoQjXbPvI9+5QJS4ihG55xd1H6lEMZ+yar0fisH+MgP4
         TNXvSRGUsT3Eje7V1LKnBSVnLAB6CSfGculpbhyVgSAiIoDQxT0KOSi3xmedcmV+F1to
         lfWV4t7Opn+WWRGfzu8MV4Alm5S0PONzjiRg7We/xBngzsOW6Sr4G3SuwZp+Q7ElOgqn
         5pg/X83oxKYhEch6pb7k5nxC/jKRgSS+UU8IuK1Iat7VL8IvRcg3/0abj8zHLqSYFY3t
         rEiw==
X-Forwarded-Encrypted: i=1; AJvYcCVD0ScXylwJ7zn6NzV0ZuK4Dki5vqeIbMJtK3K87eaPYkflB6s384n0amyR5oiUxCQJHQ83wtHMTvmwGd3/WWY=@vger.kernel.org, AJvYcCXuKPQ8GtC+gTMSMKFekvwZ+0RjqgD7CYjy9OvU+B+0szkuIR03z0ZFCBpUBOtj+IzJYF3cJWDhP7BlhC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztFPbFA4ai58Y0rT9adNV30gQtexIJTmtccIoxt9k7mJubKnaQ
	jSChiFLUEFE8VEhQBxTPO2KUzS5UctT6fvapHXljQmd6Fe6azLQz5N3S
X-Gm-Gg: ASbGncsSWJ762lfFenqhasXGC20kGgeootcUSVgoPpTaSw8U7LdrIChzPkI6GbsV36u
	LFCuPCarpaXs4q/uaykkesSFXwkmcEnQUsEbVCYgkeCvtFVvVsW3NGxULxGPjQkfI1Xl2zs9KsG
	lt3STSo7swJ+5BgiP+SKF080tgHAO/WKlQdhbvmV/Pono8WRmDKkobDowNQs4+ybQaQ010d1UtJ
	zwXnOowKUWtZgt9m9gkE0SLZYDNAfzjI9gj+xWXfvvC92ymmzTM95C0mjElPnq8lsDR7VrHbo7r
	vgDfz4LcQh4ojOXsOqkqDarVLHUC2XBovevI6DbAn6ZIMr25aMX1rf9uP/EUJ9OPVdE78QbIIGS
	Mz1irJMF6av49e3fsazsa9mBJ4TYRxp56tgc/
X-Google-Smtp-Source: AGHT+IED9q1MO2NjY7JkP8xKxr3ghVGuo4ahIddsDm9SCORk/W6agnSoVKinlJ4N61fgtyi4T9QgSg==
X-Received: by 2002:a17:903:198b:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-2446d8ee421mr85971415ad.46.1755347036197;
        Sat, 16 Aug 2025 05:23:56 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53ee6bsm34819935ad.119.2025.08.16.05.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 05:23:55 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
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
Subject: [PATCH] rust: pid_namespace: update AlwaysRefCounted imports from sync::aref
Date: Sat, 16 Aug 2025 17:53:23 +0530
Message-Id: <20250816122323.11657-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in `pid_namespace.rs` to import
`AlwaysRefCounted` from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to `sync`.

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
 rust/kernel/pid_namespace.rs | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
index 0e93808e4639..979a9718f153 100644
--- a/rust/kernel/pid_namespace.rs
+++ b/rust/kernel/pid_namespace.rs
@@ -7,10 +7,7 @@
 //! C header: [`include/linux/pid_namespace.h`](srctree/include/linux/pid_namespace.h) and
 //! [`include/linux/pid.h`](srctree/include/linux/pid.h)
 
-use crate::{
-    bindings,
-    types::{AlwaysRefCounted, Opaque},
-};
+use crate::{bindings, sync::aref::AlwaysRefCounted, types::Opaque};
 use core::ptr;
 
 /// Wraps the kernel's `struct pid_namespace`. Thread safe.

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
--
2.34.1


