Return-Path: <linux-kernel+bounces-750697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FBBB16000
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F31C3A969B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDA7293C6C;
	Wed, 30 Jul 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="c3p9Mwqh"
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCCE292B5E;
	Wed, 30 Jul 2025 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753877533; cv=none; b=GG6uW7ZH4uvHPej048GQWUlEXVhyY0QLHjecR8Tx1Cx4FfqNmqT18lc0nhXRtiQBDvhckGhLb1Zju65Q91iw5VCb2bYqj4yZ5NN3WRQ/fXAE3T1iOPaDMi0fCGDFlK94NuApiWZ71bSItHEZ0sw5q/QPc3sSQc4t/z5sy7LeHuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753877533; c=relaxed/simple;
	bh=hnwFMGVddiaj4FGSNZe0IX1pB7gFBavSOPqdW3Q/Gms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sm2RijxnXXAWemyqmm7j/Haip56m4+A+iNjjwa5w7HgkQT/0NzWZLwvkO/yrtldg2tc0n22zuXKJgLAtLZg2lvQ/GJtB1qZH9C1yY2xm2q3nSlnGqtX2A7tlJkMnCPB+LvjqO2vc0GhWTw/qnm84rZz7wgD1jwbZxv3Y1Z2YjcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=c3p9Mwqh; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward205b.mail.yandex.net (Yandex) with ESMTPS id EDCF78308C;
	Wed, 30 Jul 2025 15:05:24 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1ca9:0:640:4823:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id A31B5C0181;
	Wed, 30 Jul 2025 15:05:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 15ZEvq3MbmI0-eAmi243C;
	Wed, 30 Jul 2025 15:05:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753877116;
	bh=hnwFMGVddiaj4FGSNZe0IX1pB7gFBavSOPqdW3Q/Gms=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=c3p9MwqhYA8lkHiikloNnoOfl2J8ouJPdaYIpWbRcfIn31Ao/OOvtYPr5tP07AC+H
	 vrcM6WI5xfy45zl06+zQugybBRulxse+jfX1hBBCObP8PtIKSS5TgUHRtn2mr5FGTw
	 u/38SN/CYON4c5cvlIiTAMtP8sEugIkpyK4XWoOM=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
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
Subject: [PATCH v2] rust: update error.rs documentation
Date: Wed, 30 Jul 2025 15:04:59 +0300
Message-ID: <20250730120459.15607-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds missing header links.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/error.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 3dee3139fcd4..dd3e4224218d 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -2,6 +2,8 @@

 //! Kernel errors.
 //!
+//! C header: [`arch/mips/include/uapi/asm/errno.h`](srctree/arch/mips/include/uapi/asm/errno.h)
+//! C header: [`include/linux/errno.h`](srctree/include/linux/errno.h)
 //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)

 use crate::{
--
2.50.0


