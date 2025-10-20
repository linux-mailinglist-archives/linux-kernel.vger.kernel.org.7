Return-Path: <linux-kernel+bounces-860475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B12BF034F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC943B9BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A3D2F549F;
	Mon, 20 Oct 2025 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEDvq1Hu"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1042F546D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952955; cv=none; b=WUB71OmiO4Xy4QX776dKCvsu8w6BVSPYrow7LM2uA8xc3QRUELly5UeiuaIG/7HTmQUUH3hPVT86IjpLqSQshoCWmOZwTK86IMC9buJccbzJ4Hy54CRfwezF3EiworWC2uKJuvFWl2Ps0JX2oYNVORJUN7nXvT8T/wwu8Q7bbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952955; c=relaxed/simple;
	bh=Rj3Cv0A0AFvlIdCz5QQRixaigsXAGVT7hj4kSACuzHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AC29iVd75u0nzdpfdeE+YQAZw9oRxAxBL1bX4DmCcd870BBdumJE0iiRRNeeHHh7mzor5m6jhlFHYkfnD9HJiZ4GyUSuhP0AJMjcvh2WleZ5MSOtdBVyxuuvxnrKfY5EmpSf99zscenr6ssCW+unVYQdTMuEFSk1GD2AmVLlqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEDvq1Hu; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-426ff59a320so5825514f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760952952; x=1761557752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQ/tfUyYnFA5M9VsXSlnSLFGwbCz4/7ogPBgd0QPqz8=;
        b=kEDvq1HulWNUpzq1QJMxsApVBhkwv0/XEYpfweEeIxZz5kxbFnE+CUgc/0VBH1FW2j
         SQKki0+uUhs2AJ+T3nVDX4s9unCLQ/LuVK/tJs4KxZmez5GXqEwwuVj4llvTs0VqYwzj
         uq1sXLugekvdeAbiAj1KxQCoj6x8J3jzjEseOxeUGLEJ4rVFdjOQ276EZk2RCICEDdrY
         LkjOJ+EnZi0rgiTar5PDPXt/LNnmBn9ZfFEDb0yrJCiKpEMQCHhlcmcflTdsD+/Nq6/t
         QufBWo0I67T7jeovjCffEw9ZIw/X/JDoawXdV0oEOBM/nOhlN1HihhBxJsnHcxhlNJTA
         CSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760952952; x=1761557752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQ/tfUyYnFA5M9VsXSlnSLFGwbCz4/7ogPBgd0QPqz8=;
        b=UpfjH2fCnVfTpSCw4prEolOg/q5NC5jF0ku+Zw8e31zBbFpIONhdgsKpV7NUi7KlyK
         JisgkzjRiFjjQcMzh9gpeNZxq1s+lVxoh9b5TXawq7M0RXsWq3OpTmuN/MiQuHJWkfwW
         DHmZoIFqDuCBqvmNalPSf3WCpbfdfgFMpULvy1aKm3Ss7aL8HBjbG0HVvfz3ghhY6zqv
         ch0a64TttqYasBQeruCTLLih3zraSWkhVKLN5gbbgI+AoY4WC+wuX0rYyyEQ2t2eqwN0
         Yoh8sMqnDZhsECdnO7BvkeyB4BOs1p1+4A/+zv4eNdLpu6kpLvjyM6uX4I4Hb5BvEmbY
         3N6A==
X-Forwarded-Encrypted: i=1; AJvYcCUxx5249MbSqJUv0mxKtKSGde8zZ1wujnzImprrPgYkDxiROukNyGU5bLGYwND2VXF6ayXfsP6Ak2h71Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9mCB97orJLiKBqsjbPbHJkIJjKc680ZTrCbHuTGIHtqr1RQm1
	I62sBSG2EJEVcaBuNd/pEwWGAJtxm3HDuAUbpDTh1fSLwbg/s2yX23uOC3CXFV1Y0QgMc0nBEY5
	tV9y/2w6RwkrPUAIedA==
X-Google-Smtp-Source: AGHT+IHkHZkomFzjib5JOKNGBWO6OTU3fGhk+HTOmg4VbQ9B2LuZx7BK0Fqf50b8EvR6TWFduVWrCYrhCF+fRGs=
X-Received: from wrmp17.prod.google.com ([2002:adf:e611:0:b0:3ee:1586:6c7a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f82:0:b0:3eb:5245:7c1f with SMTP id ffacd0b85a97d-42704d7ea04mr6947439f8f.2.1760952951574;
 Mon, 20 Oct 2025 02:35:51 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:35:34 +0000
In-Reply-To: <20251020-clk-send-sync-v2-0-44ab533ae084@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020-clk-send-sync-v2-0-44ab533ae084@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Rj3Cv0A0AFvlIdCz5QQRixaigsXAGVT7hj4kSACuzHY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo9gJ0REHnnmRjuUcXmyar5evdHcpqd7O9bOlbp
 b8p5mfvUKCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaPYCdAAKCRAEWL7uWMY5
 RjunD/9OSGEajhA31CYLMpj12QvqjwYd26hG4WCYAqisJiPP9b95yWC0X/zTIib3+aGDkZQOwDB
 Ra7rND7uAdDfnQl6n3cQ7TN0O9jGTjcqx3CPEGnx60WNUuJuG1FgjI9eaYqnu15BkkYPxgLFRGA
 icfaMnV949dRkd0qxdk1HbJ+7cC9kPx+JXqEG0dxF1vAYyvjkJO4JXmRO7IWcJg22YJ8v0xqMzm
 LeaQsNgPknR+duhFZNbDQYMx6HkpN0ESBdNZWJazjqSt1dqUBIIYPOQIvQNYRXn8ZujIlDcadGe
 OoAXiWN2htu4tyc7pIsFrcJ4T9RsRg/xW5w/pWFi7DCcg0T1ZAcNG5PEsAAiEd6BxQn6rDJ43+m
 LX9P1rg2SlsYfcHxXpek42B+U+2RH34D5oIlU1RMkcwlrZy/WPW7dj/ObKYCNrz9a9ctJ149I40
 2iqb/r9DrUW9VU8AG+gQxk9HsTksT7+9VanENR2X8p78gWPF9k2WQ5yOAJdub+ivHPCatt/Ekyk
 qKuJ823yf0Ogoe5SZZ3/FGx84Ptfedr0DIE+kCABXXID+z6MIUXpniQIG9wxxtl25F2I/Kp8eXs
 LnpAVIJfgp97lZjPeUOt7MmKvu3cXslMdq7ztj+kAv4+f4xQbHlrujuGvBdR7qfCyF8QUOFe5my jZjTBl1D/li30Nw==
X-Mailer: b4 0.14.2
Message-ID: <20251020-clk-send-sync-v2-1-44ab533ae084@google.com>
Subject: [PATCH v2 1/2] rust: clk: implement Send and Sync
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
be Send. Since the Clk type is thread-safe, implement the relevant
traits.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
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

-- 
2.51.0.915.g61a8936c21-goog


