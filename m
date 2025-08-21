Return-Path: <linux-kernel+bounces-779397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DB0B2F3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEE96881B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F622EE615;
	Thu, 21 Aug 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="fSRHEBjT"
Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757472ED872;
	Thu, 21 Aug 2025 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767738; cv=none; b=s/p/Cucy1eJbRZbJU36jQf9mNVX6KNH4T/+EFKuXkXUoOdsxDuFmq55zI45YJyT1mKdBOJncRU8xIo3sc8xK255DXtoDyVMlbl5Gyk6GzOangfkUglC9GKZbLDqiOgJKWPuSLWfENVVhVqK+chByeKPMattTPKaxR7buEJpkpO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767738; c=relaxed/simple;
	bh=efoQrj7bXWgexhd3BHD2Qhn1VZWqg4JM11GT3VNhmWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HgGbSQRMmvViVylr3xGVD2rOqSlVb+UJa3besk9pYv4Xx5NuMwHD/vhZGtblUunc6AOhkBpVBFj3y5AAwgkrLiBUevcq9NuzaYShSkCjU7Hm6+9pqG7Jdl2GNJRAo9TjqnnZZlNRADC8szE7bPSamBV4UoRBgveeKqL6plIOIEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=fSRHEBjT; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward202d.mail.yandex.net (Yandex) with ESMTPS id C12AE841F1;
	Thu, 21 Aug 2025 12:07:52 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3928:0:640:8b00:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id A854BC0097;
	Thu, 21 Aug 2025 12:07:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id M7PNAONL5Sw0-zNXIiSp1;
	Thu, 21 Aug 2025 12:07:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1755767264;
	bh=D2NoTGbvCME0hV3MUX25OOiQBe7Hg6+IxESPay1AqjU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=fSRHEBjT9+aPADLJ6r3ovdVXRiCoZa6wDsW+yJ/GSKVqWfAUNk0LQKvQcYHiEdvC1
	 mxeiHHh5xyY+/IPijQl19dEDwfJnCGWdCUk/WkwcbteR4AH9xyxqXSJX4HRdsALZ+r
	 p8IEh3tKoDr65AIAIcVP1kfG1bBTWVGNt3sBu8mA=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH] rust: regulator: use `to_result` for error handling
Date: Thu, 21 Aug 2025 12:07:20 +0300
Message-ID: <20250821090720.23939-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Simplifies error handling by replacing the manual check
of the return value with the `to_result` helper.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/regulator.rs | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index 65f3a125348f..73ad4ad4747d 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -267,11 +267,8 @@ pub fn set_voltage(&self, min_voltage: Voltage, max_voltage: Voltage) -> Result
     pub fn get_voltage(&self) -> Result<Voltage> {
         // SAFETY: Safe as per the type invariants of `Regulator`.
         let voltage = unsafe { bindings::regulator_get_voltage(self.inner.as_ptr()) };
-        if voltage < 0 {
-            Err(kernel::error::Error::from_errno(voltage))
-        } else {
-            Ok(Voltage::from_microvolts(voltage))
-        }
+
+        to_result(voltage).map(|()| Voltage::from_microvolts(voltage))
     }

     fn get_internal(dev: &Device, name: &CStr) -> Result<Regulator<T>> {
--
2.50.0


