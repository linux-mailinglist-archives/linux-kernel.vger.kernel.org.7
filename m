Return-Path: <linux-kernel+bounces-738127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 446D6B0B4C6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79948175266
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC31F12F4;
	Sun, 20 Jul 2025 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="c8a8UGXM"
Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFBE1DE3C0;
	Sun, 20 Jul 2025 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753005356; cv=none; b=NnFkZAZOC87gp8sERERODcYtw8RBK+vCP206AOjNzbUUG66pcN7wO+pHqG8COgzCTcv7MrfAHnzlplexzLczisaFc1SGroyDQgwKlsgRTmXt7UM8BPdlZV9AJZh9B2FTdLEC1Q+UVN3xHaVR29Nazkj/G2LzwKC91ZOOtanqllQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753005356; c=relaxed/simple;
	bh=GFa0YFh7rnF36crYZ8kQlad566/j64nA1pXdu2g/StA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLA9kBjqtmxEN9Zcpc73kQKe60DmjK8fzIekcSaxe+P3P2PJZa5dt23Lp1LbUYRMcRV/DUga3eau2+1DyhLH0xglK0bcba2GrBHPkZAISIa0AqHI0IGb92FpzuAgOTnUKTW1y/5wS4Ysc/T++argF3OKZav09ZeDVWYR1iRp/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=c8a8UGXM; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward205d.mail.yandex.net (Yandex) with ESMTPS id 10393890AA;
	Sun, 20 Jul 2025 12:49:07 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:e0cb:0:640:3e34:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 8C357C0093;
	Sun, 20 Jul 2025 12:48:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id emMPSZxMxuQ0-BcJnzjcu;
	Sun, 20 Jul 2025 12:48:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753004938;
	bh=xZmvch/RB2Pm8dA1QtMTs0vcuWppyiPWJBKMFB4UoSQ=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=c8a8UGXMIKhfXy5TBIbNo8NIsy7/e+w0j6q4yaOX5iyKCSR0QsEGzq3yWzMZxwuE8
	 5hNAMPbv4HbA497L+QrOZyKUoYYIlgbCKihHXQaUkHKYH6s4FHTkUGcCeyi5nJa1KI
	 376hH/jswNrU7XFy/oK/y38ZDWeDmQVeJjmjAW50=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: dakr@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v1 3/3] rust: make `kvec::Vec` functions `const fn`
Date: Sun, 20 Jul 2025 12:48:38 +0300
Message-ID: <20250720094838.29530-4-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250720094838.29530-1-work@onurozkan.dev>
References: <20250720094838.29530-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Makes various `kvec::Vec` functions `const fn`
to allow compile-time evaluation.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/alloc/kvec.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 1a0dd852a468..af6e2564a194 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -174,7 +174,7 @@ const fn is_zst() -> bool {

     /// Returns the number of elements that can be stored within the vector without allocating
     /// additional memory.
-    pub fn capacity(&self) -> usize {
+    pub const fn capacity(&self) -> usize {
         if const { Self::is_zst() } {
             usize::MAX
         } else {
@@ -184,7 +184,7 @@ pub fn capacity(&self) -> usize {

     /// Returns the number of elements stored within the vector.
     #[inline]
-    pub fn len(&self) -> usize {
+    pub const fn len(&self) -> usize {
         self.len
     }

@@ -195,7 +195,7 @@ pub fn len(&self) -> usize {
     /// - `additional` must be less than or equal to `self.capacity - self.len`.
     /// - All elements within the interval [`self.len`,`self.len + additional`) must be initialized.
     #[inline]
-    pub unsafe fn inc_len(&mut self, additional: usize) {
+    pub const unsafe fn inc_len(&mut self, additional: usize) {
         // Guaranteed by the type invariant to never underflow.
         debug_assert!(additional <= self.capacity() - self.len());
         // INVARIANT: By the safety requirements of this method this represents the exact number of
@@ -244,7 +244,7 @@ pub fn as_mut_ptr(&mut self) -> *mut T {
     /// Returns a raw pointer to the vector's backing buffer, or, if `T` is a ZST, a dangling raw
     /// pointer.
     #[inline]
-    pub fn as_ptr(&self) -> *const T {
+    pub const fn as_ptr(&self) -> *const T {
         self.ptr.as_ptr()
     }

@@ -260,7 +260,7 @@ pub fn as_ptr(&self) -> *const T {
     /// assert!(!v.is_empty());
     /// ```
     #[inline]
-    pub fn is_empty(&self) -> bool {
+    pub const fn is_empty(&self) -> bool {
         self.len() == 0
     }

--
2.50.0


