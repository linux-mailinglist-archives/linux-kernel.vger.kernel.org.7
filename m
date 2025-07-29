Return-Path: <linux-kernel+bounces-749522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACCFB14F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C423BAC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A4A1E51FA;
	Tue, 29 Jul 2025 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="iB1+eGY1"
Received: from forward200d.mail.yandex.net (forward200d.mail.yandex.net [178.154.239.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4F21C2335;
	Tue, 29 Jul 2025 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800129; cv=none; b=Z8/WgWWSmbVFTp6YKVCA+VYrXgrmiP2CKy36udfOSiuTzq36NL5WXuTME132XutLc/EY5jNuYfhdcRL5WcK+3HWfHfPFcTPuxpyS7UMuFaN6IXCaCYjSF7YkNkYF96D5v9i+bYpg4FzL15b8ZZZYhr6UFSqFjsFeKL4Z1AcoHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800129; c=relaxed/simple;
	bh=6a8MlQQoUES2/TWgAUrFoTtkHaQpyv4ZuCNEizTErDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tc83IRWhLKwcGjSSM/U/+75hSFbsGUxH9lV+8XLq1oSLgKiuRxUtBXQs4Jd4eYvhiCW/FSpuoGGGaRruHtfFwrQQqOpHTF1CyWwR4A313hSbU3kQTCyiF3Puf6R4jPWWV8JdRLnWIwLf1VTmQsoAZFc5TSS6/HlzUxH2MFdFaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=iB1+eGY1; arc=none smtp.client-ip=178.154.239.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward200d.mail.yandex.net (Yandex) with ESMTPS id D13B582646;
	Tue, 29 Jul 2025 17:36:25 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:c54a:0:640:9224:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id D44C0C0051;
	Tue, 29 Jul 2025 17:36:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2aaRjZIM40U0-UITwGQon;
	Tue, 29 Jul 2025 17:36:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753799777;
	bh=IurhWi67dLbKCQlWJ8m2gpuiGyRDlCANiOohk3Vhk0I=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=iB1+eGY1phyrcDbEnn7SQkI71+GzyU8cgFVSmxfcyEXtqC0NgBpmsVxb/F+fdlYHz
	 WgvSK9FXLjkVNaEJEWdW7AbtaMVefkWfQn6GreGWSY9NsDp9fqksTtcQc7wSs/1lxC
	 usVSJ6IzpWfGtsQYjASE4RfxtKXGkUcvMXRgHEQY=
Authentication-Results: mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	me@kloenk.dev,
	felipe_life@live.com,
	abdiel.janulgue@gmail.com,
	dirk.behme@de.bosch.com,
	daniel@sedlak.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v1] rust: update `error.rs` documentation
Date: Tue, 29 Jul 2025 17:36:00 +0300
Message-ID: <20250729143600.5305-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replaces the outdated (e.g., `ENOIOCTLCMD` is in the
`srctree/include/linux/errno.h` file) and overly specific
description referring to a single C header with a more generic
one.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/error.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 3dee3139fcd4..a98dcf88d63e 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -2,7 +2,7 @@

 //! Kernel errors.
 //!
-//! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
+//! Provides Rust representations of kernel error codes derived from `bindgen` bindings.

 use crate::{
     alloc::{layout::LayoutError, AllocError},
--
2.50.0


