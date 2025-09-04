Return-Path: <linux-kernel+bounces-800344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B0B43689
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FD31BC3562
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A767A2DD60E;
	Thu,  4 Sep 2025 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tekYqWB+"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CB32D5C95
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976610; cv=none; b=Tw3Ln6gA2jQjZyUGlPB8f1IcGmszGRxUuT/lcVxBr86hzMcERp61GWkJy21inqjkcBj30dsJBHfKmsdqzuu3LejQFjopC/Y7vlxIF8dmh7qqtMboN66ird7I3WzkQ7CcFA2VjDgbEC5sZuna83lr53Vj5On8GKhYwliJpVrqLF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976610; c=relaxed/simple;
	bh=vd6AugBRQQ7LSCss9P7jkclD2lwejCl9P5EdEOF1JQA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H781HFFJz2HUNchRqcV4HCK4YylohcZz10sdT0iskrIEHv2NHspdwCW5HdqZWDwgSlC6gBpubVOR1GeyRkybtdrBsSA9/+MRTjh3BmvmiqJAIdPMxxNch/DmLZOQb13Bpn2UxfoBuhPhzANwKBJpddVfaOmdlWYl+CxMaVvS9Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tekYqWB+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45cb612d362so4289685e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756976607; x=1757581407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jJtnDDrtdvxSxz2byyhf6ovg3vXgEml10lpi8GliOwg=;
        b=tekYqWB+kGgUXTKTfXzZb1/3XFaAyHW0G5mD/UyznnWDka6LP+pVidT9CMWn43F1Az
         wtnd/gwvukSeiyVkykYgbSFu1EKLpxZp61Uss//gaNzI4mLhfju03ggEzzXbDZzbVE2k
         FUmzfcyKVEepoX8S6KlckEW3XFomIXGwUUwucd7J/g0ld9Cn95YHHHWJBvEzt1Aan1LD
         E9GX3cjBGTOfp6wnKCgAr3dTiXItuKLjlUMxZgdbgI0BsN055zMRIXmYo5UURC2fDUKb
         41YuuyfZJ9E8eTkJBUkX5poyzSI8qgRLDDcvnzdKCgj7cKA6n6D6GpBxAcCutEB+JxF0
         VA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976607; x=1757581407;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJtnDDrtdvxSxz2byyhf6ovg3vXgEml10lpi8GliOwg=;
        b=mb9itc5QLBZBSPxKlVcelmp9Y8Tcs011IK1aUT4E205Dabb33ZsPmzpODBeGHppcHU
         IJv348C+KaezupIENdUaVfaYie12LNeF/hcueF1jgCHdLkPQNQgMhFe0ifgyyn9BG2EB
         72rVQIc/hO/S5VP5535Pj72RfW06pV5c1ywfJ59XKdiSHMLnYog1x3JzrOoIUNxZ+hOf
         yBxvKRX79PtaPqyWsimDoZ+604AuDOi7NpdjH+E6b0pz63F5+0ja9WdkBo3Pb89wgQNq
         3ngYW9xto4djPSp7KA1Jmbv7pfm/EzJJLu1B/Hoy129QygQA/Mp6dWKNGgGB1egflCg5
         U3gg==
X-Forwarded-Encrypted: i=1; AJvYcCVoHWHwhFidcPHMTXPongNYyJDxwevTH4Lj+XMIqf8hrLvVqP/fyM6sG8tjam8SFPi/+KD6Lj0Tqf2pgpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MotJd6ETEoeLhbaPMoNVz0wkOtDWVcWA71IwLX4knwYmOjVS
	9JMzNQQV/gI3hsGPo/ga4YSyBAtME4Hf1Ugjvtgd2GWiWj/kCs2H0Z9Z9p9o+e8HFYq+zyZaIlr
	1r2DdQfVBiGN6Vnxm9Q==
X-Google-Smtp-Source: AGHT+IFON1WOJMPLi3KX20ldY+fg9A+absAs4vpg5c2bhfbXxem38DAApNJjd/cwu2TKdJ2KoCKCY+4GfZPUlUU=
X-Received: from wmbep20.prod.google.com ([2002:a05:600c:8414:b0:45b:9cac:6fea])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:354f:b0:459:d6a6:77c with SMTP id 5b1f17b1804b1-45b855add8bmr140973945e9.33.1756976606738;
 Thu, 04 Sep 2025 02:03:26 -0700 (PDT)
Date: Thu, 04 Sep 2025 09:03:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANZVuWgC/x3MMQqAMAxA0atIZgO1VkSvIg4lphqUKg2IIt7d4
 viG/x9QTsIKffFA4lNU9phRlQXQ4uPMKFM2WGMb0xmHtK2oHCfUOxLWFHwbHFfEFnJzJA5y/b9 hfN8PQpUfpV8AAAA=
X-Change-Id: 20250904-clk-send-sync-3cfa7f4e1ce2
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=vd6AugBRQQ7LSCss9P7jkclD2lwejCl9P5EdEOF1JQA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBouVXZEgW4jnxvJ/iEOXp3OqgNSuN/YN/xWrsUl
 SHDqcVjfEWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaLlV2QAKCRAEWL7uWMY5
 RmRBD/9CYkpfGQt4q39WuBsUiTUblJypwp1kURHjawSb19cMOK6iRyNxPWJ5XFUnnmSrI20oTxq
 xb/XKSu1fg6DVdee5o2IfO4oYwZg88f4sFNwi1wZS8ghUcbgkGS37DcOexsFbojXb55i/rh5TyJ
 ZZByQj+JrSx9XTyh/weW/Y/2TTtYn+d3tbVHFV69heZUNYTFmi/z677wHaGH9kcja5p9+9rZ6XL
 vPTw7USab1mnLP6p09WCBPmx37b19BkbddxuFWsSq2p3ZHp657uUpgOTmiaQqz9srkJZhRMa2Wy
 N9h+v3YR5H3zD6xIc19nB+LuSseRU6lD05Q5vtgs3yEkS2e9NtHrj2O0JDrW4bQ9VzqdMvYLkz5
 98Qvst/ohMU/YWeDQwa9psTIfGaL5mMFncAQajootFjynWZ2ed1Q6JOYDHRNm/7SNdCESVFFlMi
 GBAtvAkWzWU01Fa24TFche5ToEyzcWDjE+lSXax/5MUljrsLN6sQD2cA1hwXjlLFRwtkY4UH4Zn
 78qRXHUn0uKPuSVJnjXBDYxj5uJWK0breTxPRQixK7IUhRWKa2K9PPcb58MgiXU0pETKAABBogp
 rJt3B79qzP9ZTvBP6P673FpDuH0bBV94XF2/OXenumEIsf2fEaOAK6DImEmg1cbNSpcuDoMo6FP 9bsx2qmPLaHdL2Q==
X-Mailer: b4 0.14.2
Message-ID: <20250904-clk-send-sync-v1-1-48d023320eb8@google.com>
Subject: [PATCH] rust: clk: implement Send and Sync
From: Alice Ryhl <aliceryhl@google.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

These traits are required for drivers to embed the Clk type in their own
data structures because driver data structures are usually required to
be Send. See e.g. [1] for the kind of workaround that drivers currently
need due to lacking this annotation.

Link: https://lore.kernel.org/rust-for-linux/20250812-tyr-v2-1-9e0f3dc9da95@collabora.com/ [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
I'm not sure if there was already sent a patch for this. I recall
being told that one had been sent, but I could not find it. Maybe I
mixed it up with the regulator change, so now I'm sending a change for
clk.
---
 rust/kernel/clk.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 1e6c8c42fb3a321951e275101848b35e1ae5c2a8..0a290202da69669d670ddad2b6762a1d5f1d912e 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -129,6 +129,13 @@ mod common_clk {
     #[repr(transparent)]
     pub struct Clk(*mut bindings::clk);
 
+    // SAFETY: It is safe to call `clk_put` on another thread than where `clk_get` was called.
+    unsafe impl Send for Clk {}
+
+    // SAFETY: It is safe to call any combination of the `&self` methods in parallel, as the
+    // methods are synchronized internally.
+    unsafe impl Sync for Clk {}
+
     impl Clk {
         /// Gets [`Clk`] corresponding to a [`Device`] and a connection id.
         ///

---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250904-clk-send-sync-3cfa7f4e1ce2

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


