Return-Path: <linux-kernel+bounces-877848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 578CFC1F30A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96B524E92E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE2534027E;
	Thu, 30 Oct 2025 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b="Ov0OdZ0M"
Received: from sg-1-38.ptr.blmpb.com (sg-1-38.ptr.blmpb.com [118.26.132.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DADF340275
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815282; cv=none; b=GvFxzoBaJ5vAGxIxbZjPoj6i6ZOWDAu0l8ZK4JkQkl2Ya7OCLG5/Y7f7oTWXL0kWPG36NHpbYe+xmr6H1QBcm52pNdX+xHOyXVjKn1XUAYTMPsz0gdx4OqiRbg3leheOMEvAI5p4zjKe7hl90pGhAU0vrb2LbWX+4Xb0p7WFPI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815282; c=relaxed/simple;
	bh=N2nhDDoVSkyl5VIjjrCqInu8j5G4Jln8Mq8+CrZWkW4=;
	h=Mime-Version:To:Subject:Content-Type:From:Date:Cc:Message-Id; b=RHxmGUmEF+b4DJToNFwZqPOul3pStkEfP9kNhmiC6o6ApZL9CYFt/PtuQ4FztHpjnmFrPImvQ7kyXvZowb29SaZ9CQ9GaRrFoZwGK68rle0t0WjqN7R0gRKY0G1O87+Sw42M+B9ELx+yicOhL7kAbeKJkdUwHQ0X1ZdyI/IJ6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club; spf=pass smtp.mailfrom=openatom.club; dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b=Ov0OdZ0M; arc=none smtp.client-ip=118.26.132.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openatom.club
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761815268;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=yFLfJAIRB5GB4c3FauNgnw4VQrFIdM3sS4dAA1umawc=;
 b=Ov0OdZ0Mfeq6J2VNsJhzXMV36tJojCvos6+Bqc/r1GwSFEFwJzzbHrcUnIsRBLz+3Jw8RU
 Z3o0HDU3fTDHSuIXOmU1qunYYjq/rbOcLaTEKW7BRyMVxR687Nv9sQmkLSYDW42LjfVVce
 lU76X3719Sjwa81An82kcvuR6/xdvqmHVNw3p+kHefQzVlB290lZeP3tgOHHnCbrZMIBE3
 kUVpHKqJVUvj+z/9jhRCPk7NI+DDZGv5BmWrIKyShIT5cXgBrECGHJxQDXF9qCgSPDkceP
 fLmL76vwTT2SO/1Mfy3IYNqQh0QIo2lZ1h9tK9MqRkY6KS9rmPfOQcFJkKHLeA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+269032ae2+31a8be+vger.kernel.org+chenmiao@openatom.club>
To: <lossin@kernel.org>, <nathan@kernel.org>
Subject: [PATCH] Makefile: Remove the product of pin_init cleanly in mrporper
Received: from nyaos.localdomain ([114.249.194.57]) by smtp.feishu.cn with ESMTPS; Thu, 30 Oct 2025 17:07:45 +0800
X-Mailer: git-send-email 2.43.0
X-Original-From: chenmiao <chenmiao@openatom.club>
Content-Type: text/plain; charset=UTF-8
From: "chenmiao" <chenmiao@openatom.club>
Date: Thu, 30 Oct 2025 09:07:36 +0000
Content-Transfer-Encoding: 7bit
Cc: <hust-os-kernel-patches@googlegroups.com>, 
	"Dongliang Mu" <dzm91@hust.edu.cn>, 
	"Nicolas Schier" <nicolas.schier@linux.dev>, 
	"Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, 
	"Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	"Andreas Hindborg" <a.hindborg@kernel.org>, 
	"Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, 
	"Danilo Krummrich" <dakr@kernel.org>, 
	"Masahiro Yamada" <masahiroy@kernel.org>, 
	=?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	"Tamir Duberstein" <tamird@gmail.com>, 
	"open list" <linux-kernel@vger.kernel.org>, 
	"open list:RUST:Keyword:b(?i:rust)b" <rust-for-linux@vger.kernel.org>
Message-Id: <9500284ff72ad4e4dc4799fa5392a7bbfdd34f3b.1761814593.git.chenmiao@openatom.club>

When I enabled Rust compilation, I wanted to clean up its output, so I
used make clean and make mrproper. However, I was still able to find that
libpin_init_internal.so in the rust directory was not deleted, while
all other corresponding outputs were cleared.

If this is an intentional design, I will drop this commit.

Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: chenmiao <chenmiao@openatom.club>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b34a1f4c03967..f43a70413a6aa 100644
--- a/Makefile
+++ b/Makefile
@@ -1590,7 +1590,7 @@ MRPROPER_FILES += include/config include/generated          \
 		  certs/x509.genkey \
 		  vmlinux-gdb.py \
 		  rpmbuild \
-		  rust/libmacros.so rust/libmacros.dylib
+		  rust/libmacros.so rust/libmacros.dylib rust/libpin_init_internal.so
 
 # clean - Delete most, but leave enough to build external modules
 #
-- 
2.43.0

