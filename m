Return-Path: <linux-kernel+bounces-752567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B76EB17748
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5421C2670B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADC2256C70;
	Thu, 31 Jul 2025 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Dh5ZST7t"
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83501EF38F;
	Thu, 31 Jul 2025 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753994503; cv=none; b=FZs51mnNT130wNr7AUER3aNAvoyRGpk+RDxYyXt7pNF/LFmEzvS9zykSimrdL4JiamNaOdpTGGRuAshK1Tm53oOfTbELDaxsn70Obim2wm9K2MbHqROt7C1yTfkHqL609NFWdDIQum+5TMQ8fq31HJ7jEeSkyooq6tyknSKJz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753994503; c=relaxed/simple;
	bh=uatSVy7PBfttn4Ns2dK/pWBShxXW/7g5LQEwm1esL0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdQ2BLLpHWIB2vLwrtcV4JVAokp5tTkfItmCbjvLYfGE+U9GSDBAEvs+CKIWxFE0iVRpRnwALzsK0gIuTmGaajBfrg+YNMEUOZS1JQVjVEFwzcd+Jw9EVNRnIpOKay9+gLK3T6Y+ajJ10jxrAJUcKDWxTUXAelfyzOG6CXber9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Dh5ZST7t; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:4419:0:640:5be6:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id E3364C0036;
	Thu, 31 Jul 2025 23:41:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GfiURY3MWmI0-AFw8UxcI;
	Thu, 31 Jul 2025 23:41:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753994491;
	bh=vYGY8hvZubtxN9KqAu95Sm/mZDyDwGEV9AxSRt4Ad/M=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=Dh5ZST7tPXU+Y2k3HUCi3zb0Nr4iT+l/D8CGY5bZnZG4l8Y5QPl9qxpvWBJOoKXvN
	 YsufoaPDnYoIdk+agxAmhzI1PNk6mbounwRswI2pez5F+LSmvu8IC7D4nvpaLD97aH
	 eJIJIGUiE4sj8Jx7ICg9iRsJisxjy2AzA7P5pknc=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
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
Subject: [PATCH v3 1/1] rust: update error.rs documentation
Date: Thu, 31 Jul 2025 23:41:15 +0300
Message-ID: <20250731204115.13669-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250731204115.13669-1-work@onurozkan.dev>
References: <20250731204115.13669-1-work@onurozkan.dev>
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
index 3dee3139fcd4..7c5dac20c480 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -2,7 +2,9 @@

 //! Kernel errors.
 //!
+//! C header: [`include/linux/errno.h`](srctree/include/linux/errno.h)
 //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
+//! C header: [`include/uapi/asm-generic/errno.h`](srctree/include/uapi/asm-generic/errno.h)

 use crate::{
     alloc::{layout::LayoutError, AllocError},
--
2.50.0


