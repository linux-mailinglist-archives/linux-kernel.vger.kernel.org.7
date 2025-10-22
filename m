Return-Path: <linux-kernel+bounces-864080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B79BF9DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6CC3B3587
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317B82D1F7E;
	Wed, 22 Oct 2025 03:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBKNWn4A"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70652D193B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104563; cv=none; b=SeZsdvsJZa5GMSWhmyEwIx/BpWFXz1mbvnOqPcfyoG9L44Lk1yzmcaS6s/8IH5nEmUG6SfQoeeDqlMH0ChuTgaWOE9y7GpQYFkTFq2GF+OWG6XAuYHLGhI4a+esJ3YFV+6zViCAqwAl6t2Ad28sf7LRXduj9Cf9nhuvj2N2V/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104563; c=relaxed/simple;
	bh=5dEMTKIfOwngad8bI+KVayrLiShgINPCGXdFjEovC1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCg15tO2JTG9oFufeZ/oFsI2i8N98McnKRfz8GQKBKku0BEC0pwaNWLAt5DaWm9HMLEwYKx6k3QVxbWYBL+q72/4Y9DTPcX2uRELW54VfIGEITGoo0jEnxb9GcM66y5H3OrzeM+ryjkjTdSC+wbaEDYlTpHeywo+HE3U28hWo3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBKNWn4A; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4e89d4f0e8bso6270531cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761104560; x=1761709360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SJGuMQr365bI1J+psUMsjzP+a8qVxLMJH41vnrHjg7o=;
        b=kBKNWn4AIO8bgm3BrCuzo0hQFpkh89bFCIyaRWS4mXQEpAC7noIwiN7ATCj44HKx36
         PQpvw0G0Dgl9sZiZIzsgWlsJhwTfPX2MCNKfKV9zg/+wO6ZE2NzzBC+FIHJI96gKF/8a
         eWI4faMvjV1rRoJXucniJddQax4KrbeXd7ho2Zo5hbxSDm7DODNCVdKsvGUDqJzWSRcB
         /gTSL4mDsH2rUTKlQVB1gQWazHVxGW4lwo5OiGVaOiICVutuZSkVGqrHbxVuqIO09bK+
         WaoEjSJ71revuq3nBJnOpT0sCuE9nOQJV7GQ8vbIiE6tssO1jrq7MuUFt5bLPNuCDoS4
         hHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761104560; x=1761709360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJGuMQr365bI1J+psUMsjzP+a8qVxLMJH41vnrHjg7o=;
        b=oI2gQW9+jihRPmGcE7zyaqG9qf026vewiSKrJe4UZ8MuztVnhVN/8YRFbLWH1Sv/tY
         PVAnQCmgksnCJz2Q8oXp09ZmtyZIw22t3M814qmRKq9GB7Q2vBNIYqMupVNyrs6JeV9t
         HwWfFV/qxs51+y2IKJ0NC6RBZp1s1e/C1nXNa15cDJwIZ7genr2KKsHwGYMo23q6MrYM
         aJZOy5Ct2Um4sI488afqupYgPU6q1QZJDDkjzDT6K2XtNcwp0nK9D8ZZJDAzfIxceYvt
         YBVxgWgSlAs5OLJoo3nAqnDqkU+9EFfUvhUDeHMqJziWIcBI4aZhTtcLR3JEC27lG/L5
         o2xg==
X-Forwarded-Encrypted: i=1; AJvYcCV8YlXJrAcLCIuh5or3q6eBUCYyRlxffLgQExD3uToRyi+DqAowLcAW3PJauSTEUpkZkRGgT2TI4CQ96/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs/nLdVfTH2u3zlcr/XmhelJ1qs3kDCGLBBntv5q4TshlhU5St
	/RApl179roYxNx09msTu8SwGPtRZXprXwmle42QF82e+q94utecMeQ3C
X-Gm-Gg: ASbGncsK+d0GoSAOPH1wpMnKG6QVN4H623dd52QuUhgVZQRbO7mF7YwFMitAbppyUzy
	pAstBhzxdG1LmYnKhbm8LsBT6b/w/c6MRBukxlki0kv8GV/E3Mdk3OF0AvzzWTgrPAFFutm1CNy
	oiAa6XbmzrQQB8dFjQvXOCIIsIPnbJO4OOYZ6BysDT0qKDc1X8iuYrqj3w5H1nAZ/QMEGFf71yT
	t/iJTD0tXtOfNyJpF0uq2l5jDvA9IMR+GHv9SQl0nDyT7aq+UvH1A5EDFxL5gNSbMZhAvCx9UYM
	/OdHeSVir1lJakx/DhLRE0w6BD7Ag8NNf8RwgKG9RswjO0tndZkc9v3/d0Lb8Q1Qi1298Bolu9i
	Ra7dhBzpfukAFBzbK01M6/Xv78jCx2dd5AVTwD+t9P3PLt2DLhUMm2PsbL1hg2u+Dlj3LZh/g2u
	yonAHTxgrS3gFn509EELpBrv/cVlRSA1jVoMk2focgwQdvqpYmY8HhgAEn7VrDQds0fH4KUp8ix
	TvrdKKZt6kYQ+U=
X-Google-Smtp-Source: AGHT+IHAHDqhswmuHSxLidHCb6p5/Sb+uIpxgMc78LsU29Gzg/ywZi3Pz/uTIePpOTnuBimWngpWjA==
X-Received: by 2002:ac8:7f50:0:b0:4e8:999b:70a9 with SMTP id d75a77b69052e-4e89d4123dfmr213439791cf.72.1761104560306;
        Tue, 21 Oct 2025 20:42:40 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf521c120sm80452916d6.20.2025.10.21.20.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 20:42:39 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4BB81F40067;
	Tue, 21 Oct 2025 23:42:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 21 Oct 2025 23:42:39 -0400
X-ME-Sender: <xms:r1L4aO5QuU6kJpY067CnYlWqcqvFmE97CXfTCzClaQLZDJiPplN1xA>
    <xme:r1L4aHKBuyeyPZ6A0M2ZBJUx2UPme7CBDBva17QsqijCi72pVsMtpzWNVXUVSC58y
    iSmCFpVVTz9qIBeGSRf8RFJkdkwU2dT7HIc7bPlOYZF91kVFqYv>
X-ME-Received: <xmr:r1L4aAR-mawUh6bAFq7nD9CpjZm8SEHegqKG4rAtF71A4vzecRkMCCaB7Fqw2InofeOa1tdiXp2d1w5cNxhZPiguzeFlLfzJP-k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueehgeeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegurg
    hnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehm
    mhgruhhrvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshhfrhestggrnhgsrdgruhhughdrohhrghdrrghupdhr
    tghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinh
    hgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:r1L4aCoXFIUxhQtfFQp32XW5JUu2_liVczouQoBYXzSeDaa-A7VwjA>
    <xmx:r1L4aGbhYbCXEGXXlOYEbZgzeUlNtYD1FqG9snCkpJm-9f19J_Sh5w>
    <xmx:r1L4aFTrOSTxBO-8Uxr5_XqyD2gs6JKqwLSq5Uu3lPPWOa6pqE064A>
    <xmx:r1L4aMeRmkj3bEUnBn9jW2fzDOjL_210EsEsjGynwE1_n0UYYBbqJA>
    <xmx:r1L4aMnFrxF0cE9UEg_n0U0in5v_feXSpHtXqzDH9Q69-krVG2uNHnvx>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 23:42:38 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Matthew Maurer <mmaurer@google.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	lossin@kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] rust: debugfs: Implement Reader for Mutex<T> only when T is Unpin
Date: Tue, 21 Oct 2025 23:42:37 -0400
Message-ID: <20251022034237.70431-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aPhGo5WjbPM1Yu95@tardis-2.local>
References: <aPhGo5WjbPM1Yu95@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we are going to make `Mutex<T>` structurally pin the data (i.e.
`T`), therefore `.lock()` function only returns a `Guard` that can
dereference a mutable reference to `T` if only `T` is `Unpin`, therefore
restrict the impl `Reader` block of `Mutex<T>` to that.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/debugfs/traits.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.rs
index ab009eb254b3..ba7ec5a900b8 100644
--- a/rust/kernel/debugfs/traits.rs
+++ b/rust/kernel/debugfs/traits.rs
@@ -50,7 +50,7 @@ pub trait Reader {
     fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result;
 }
 
-impl<T: FromStr> Reader for Mutex<T> {
+impl<T: FromStr + Unpin> Reader for Mutex<T> {
     fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result {
         let mut buf = [0u8; 128];
         if reader.len() > buf.len() {
-- 
2.51.0


