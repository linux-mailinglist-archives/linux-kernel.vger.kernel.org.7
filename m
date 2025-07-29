Return-Path: <linux-kernel+bounces-749723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6227EB1521C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4690016CBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D7299AA1;
	Tue, 29 Jul 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VpwDJOAq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222229993B;
	Tue, 29 Jul 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810338; cv=none; b=Em3CpT5NdilkWx4YIofbKsB8TCrqyrf5BzgF1OoWgN7L4uysPTlwbELueVHL6nDIdS4EMnbfOxheRFuQb+BfTjYtdIMmEBljtNL3hStjjyY92CwPaDPHeaDIFRux146KdGGuqBrPyGJYSAEZj/kM3YuNN71CpunI3FWAWTcMWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810338; c=relaxed/simple;
	bh=Ks5rnGdq/WZDwyCCzJeCpscV0ClRUzaNDean8OPtm2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L2My/yxIBICF94jvk2ypTIoGk1KkGFRzGE+iY0FCjIfpSOnwPfkljxddW5s7aeOdTT9pozVoao3BwjQYdZdF0URV8Tor3nseoF8ZMVTbRQpnI+TgJh0VOoQDXklk2u+WNwIvOP9M3V03bsIyjsjeDZ/0PT7hnFBkeb2QyNoX3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VpwDJOAq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753810335;
	bh=Ks5rnGdq/WZDwyCCzJeCpscV0ClRUzaNDean8OPtm2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VpwDJOAqkiX3lD4854zEundkEt31YVJkW6keXUt+m6QiuQj24ig6JTrZ+4aRnEB1O
	 MCrNhy7Lb3gnF6Icre+H/qrPvud9+d1NQgI2IuHlASDE17Ldam3bXc4pFAeasKZ7Dc
	 VpGcRJr2kOAG5cBYxtCjXqr1ZSlZrxU+hF33zGnEjz0ht2GfBWWZrBpmGpJtStraNI
	 Jrt8yDjBgQBe6NYGZUNczz1pR8eXFkgvLMtPccSzbbTS/jjD8jPL9HO4XFAjQ5l6Vy
	 ZqZvcrJ7a9PVJFqjAIbwgWsKbvSkw/WaeTrZQL2u1HrFdrPKgV8KAOMHsqIu4ZsV0n
	 N+BQZApQGEN1g==
Received: from [192.168.0.7] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DFEB217E14DD;
	Tue, 29 Jul 2025 19:32:12 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 29 Jul 2025 14:31:41 -0300
Subject: [PATCH 2/2] rust: regulator: implement Send and Sync for
 Regulator<T>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-regulator-send-sync-v1-2-8bcbd546b940@collabora.com>
References: <20250729-regulator-send-sync-v1-0-8bcbd546b940@collabora.com>
In-Reply-To: <20250729-regulator-send-sync-v1-0-8bcbd546b940@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

Sending a &Regulator<T> to another thread is safe, as the regulator core
will properly handle the locking for us. Additionally, there are no
restrictions that prevents sending a Regulator<T> to another thread.

Given these two facts, implement Send and Sync.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/regulator.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index d56aa229e838c45258a27cea742a693dd71e8e40..704147e18bfc9c993a00f7a187105360ad1d4956 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -398,6 +398,14 @@ fn drop(&mut self) {
     }
 }
 
+// SAFETY: It is safe to send a `Regulator<T>` across threads. In particular, a
+// Regulator<T> can be dropped from any thread.
+unsafe impl<T: RegulatorState> Send for Regulator<T> {}
+
+// SAFETY: It is safe to send a &Regulator<T> across threads because the C side
+// handles its own locking.
+unsafe impl<T: RegulatorState> Sync for Regulator<T> {}
+
 /// A voltage.
 ///
 /// This type represents a voltage value in microvolts.

-- 
2.50.0


