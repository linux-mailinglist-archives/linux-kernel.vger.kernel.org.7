Return-Path: <linux-kernel+bounces-856966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E3BE58DD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547525482BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E07D2E54A9;
	Thu, 16 Oct 2025 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4PSQMGR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AF2E425E;
	Thu, 16 Oct 2025 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649470; cv=none; b=B9bSH8loQTP8jabtKTSZz2he9D81Ff8GE+48zABsYpbfVkJ5c/nBQbQLIuo0Rht1oiV6smuvsDWCYvIWFyb2buaTnv8JKaitJ8w+P7R4KyyxsdNcf5GX1cNIxIMInXFk2M4iC50BRbjzg2qx7e6QtXFuCH9CVfWHWt5LcgeTzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649470; c=relaxed/simple;
	bh=WGh5AR3IGPIkGeVKJtar/L8hByGyS87dy2DrVjXpwP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFMWy/rBh95C/t/1RQUQ3/CJlxkHTwPm4ledYtUntUmJE5KVRaPjVLH8Faxd58d0x7uC//SOzNifD62UD3Tn/PqX1X7FIri5BeH43NrARwhu1geFREJKDItM0FEt6vSSvIRjuOkWSnR+oM/6TVH88Ere+lUHMwo9sjgx7ccPTMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4PSQMGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943C7C4CEF1;
	Thu, 16 Oct 2025 21:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760649470;
	bh=WGh5AR3IGPIkGeVKJtar/L8hByGyS87dy2DrVjXpwP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4PSQMGRZ2DDFly/99tM1XjetYjfn42aEeKpYY5W7aqiKWmDvFzhZYaKjwFKpHh/K
	 cJ4W5F4rOink9Vqe0c8+KtK8zmnPE78wOq9wtS5HyhEf83bW9ESYAKZ+5EQdofAEZY
	 apfQpKxPs0p7n9EopLmANqUMLkQQwqZDNEoGQeQCKJNQBYFGyLI6Bdlth7fknDj82G
	 Nl3S1h8gHIxf3ih20UCDpixjdgXYu7yUHOccrmo/AMQR3qpP3C0+HraN+CBE+N3cVg
	 z3qUrmOiHiOsUn55WkycDAuiB5F0jUA9qKjPV09ysJ1kmVmeKPboGTsCkiAIvIeisN
	 yxi54tWzY9rdQ==
From: Benno Lossin <lossin@kernel.org>
To: Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Brian Harring <ferringb@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rust: pin-init: fix typo in docs
Date: Thu, 16 Oct 2025 23:17:39 +0200
Message-ID: <20251016211740.653599-2-lossin@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016211740.653599-1-lossin@kernel.org>
References: <20251016211740.653599-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Harring <ferringb@gmail.com>

Signed-off-by: Brian Harring <ferringb@gmail.com>
Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/pin-init/README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/pin-init/README.md b/rust/pin-init/README.md
index 723e275445d4..74bbb4e0a2f7 100644
--- a/rust/pin-init/README.md
+++ b/rust/pin-init/README.md
@@ -9,7 +9,7 @@
 > [!NOTE]
 > 
 > This crate was originally named [`pinned-init`], but the migration to
-> `pin-init` is not yet complete. The `legcay` branch contains the current
+> `pin-init` is not yet complete. The `legacy` branch contains the current
 > version of the `pinned-init` crate & the `main` branch already incorporates
 > the rename to `pin-init`.
 >
-- 
2.51.0


