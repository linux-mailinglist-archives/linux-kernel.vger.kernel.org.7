Return-Path: <linux-kernel+bounces-881402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0905C28239
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60EE24EEF55
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDA52FBDEC;
	Sat,  1 Nov 2025 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="GEOGDbAv"
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9925D209;
	Sat,  1 Nov 2025 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013480; cv=none; b=t6gIOZyi0rNpa0/c6LF/tq7oVpy/xac2j9auQwz7egnI4+5HGvF+H+kJMBPgbi4K0QQiLZPSDrXVibdQgM7/orxmfL+e3UeLoOIuXp3zqlZ7+Z2ewnycLng389MwwY30KZgoWlpd6FQ3ZSg/k6r4PYMglfZFSeaA7oejWF2qW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013480; c=relaxed/simple;
	bh=8qpHjS58yRnMjonBxk24D7YNjaxNwLJ18ZG97fwDO+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+fGH5NLTVsukluC4hdOntWTLp49KXSHc0v7um5aeROuT4SYEupXhwYnZ6RjvfWxp4Fx8TiQ/OwN0fv/+KlZX2le9QPTtFufhUlOBiFbRD2p7SLrNDAAkTIgNVYPnCJRv+vNbzFuNF5ap8nyYUKypEWOYC/0uuJ5VmkLg+GBRDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=GEOGDbAv; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:d7c6:0:640:5e67:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 50F10C000D;
	Sat, 01 Nov 2025 19:11:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wAkixRhLDOs0-1ieWV4zK;
	Sat, 01 Nov 2025 19:11:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1762013474;
	bh=yFK6lRt2ssfqukpmgrenlQa2EpfYl8xx6d3OUJKDPLc=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=GEOGDbAvp4ONdbyrlH93ZEKVQJOjifOaWYp0B3bX64Pvzdi3m5P8oV0jt9CbsE7Au
	 T4GR2bzQae21vNdGW0+J8urP2zF/30Tl0C2ZVIcxukvPu5PYodTSJr8DuSACIAijGL
	 2Pktv5kQebYG0Q/3PLvvGpm3Z/e69ZoP2pAuJmtQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: lossin@kernel.org,
	lyude@redhat.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	felipe_life@live.com,
	daniel@sedlak.dev,
	bjorn3_gh@protonmail.com,
	daniel.almeida@collabora.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v7 3/6] rust: error: add EDEADLK
Date: Sat,  1 Nov 2025 19:10:53 +0300
Message-ID: <20251101161056.22408-4-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251101161056.22408-1-work@onurozkan.dev>
References: <20251101161056.22408-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is needed for the ww_mutex implementation so
we can handle EDEADLK on lock attempts.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/error.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 1c0e0e241daa..9bf1072cfe19 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -66,6 +66,7 @@ macro_rules! declare_err {
     declare_err!(EPIPE, "Broken pipe.");
     declare_err!(EDOM, "Math argument out of domain of func.");
     declare_err!(ERANGE, "Math result not representable.");
+    declare_err!(EDEADLK, "Resource deadlock avoided.");
     declare_err!(EOVERFLOW, "Value too large for defined data type.");
     declare_err!(ETIMEDOUT, "Connection timed out.");
     declare_err!(ERESTARTSYS, "Restart the system call.");
-- 
2.51.2


