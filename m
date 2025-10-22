Return-Path: <linux-kernel+bounces-864088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E54BF9E08
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A1819C4A16
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C79E2D7397;
	Wed, 22 Oct 2025 03:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb9qpOFo"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F82D47E6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105214; cv=none; b=BUf9WP1u2t0GBUkzKxMunxB8qWxlX6ARbF4xZXDl6pvLYLdBB0VzimbpWv/3jz+sjgwGNBu7RqXYfffzeJNdsfPeCHYmHcrTiDg1t5VzaJHh4fQa4zV8HIQlpFqCiCOlK0xHB0sDFVQgUZRnYpuNrFAth+CHg/IL2jthKyfZveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105214; c=relaxed/simple;
	bh=NEOZ5UcQs9qWpUuFkJ3z//mwBi0OwNepB3WYde0vNFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSVZpASskdIBA4KFgyLTZhRVB9BfwDlZZ1eKJmh2ziZyMf2yoJrNQ9ixLbLjCiFjNWou3tqzALREL4TOExRB7o0dK2qltaiSR9iX02J2RFDVkZ4KAo6kVb41h3viyBpMw6cUMyj9mtWJJOGvGrwwF23aEyJrOu0dA99Op9vK2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lb9qpOFo; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-88e1a22125bso836998685a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761105211; x=1761710011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UNHVbXF1l9vxAaVojg+MHbup3Odhk55doJucb7FZw8c=;
        b=lb9qpOFoMKxxvDU4kP2Xljs56ANwI2kLj3ULkO10gL15qT8/9URJsJ3zRtQcRbEXe/
         H3lJrXXk9WOX5ouyDXoqNDeW8hUnUt05D0kNc6y2niNZqOmIUKtkswmX+pB2ZAlMY50d
         Dl7zA97nRIDTFBVlt6thvNP4259KlpqxDxOG+1xV80XYYKDRKVwGXznGpwt9W2P3lDZM
         y15dbMVNx8ABa+0q7fZhAtl8ekF2BX8aY8WMrCWBWA9/H4eUmOIG2iFb03NdQUiFGZ7u
         maLNo6g0IUTURjt6BilwkSicepq8+hbC9dAvuKF4YS0QdR3xyEPcgBwjFtqGBma89/82
         5Pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105211; x=1761710011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UNHVbXF1l9vxAaVojg+MHbup3Odhk55doJucb7FZw8c=;
        b=cAtmYgjsGyBWsxagbVGiol/EvmAkFlfqeBoiwS4a5IZAqUlrH/a0QkoH4MNk11oH0E
         M2bl/MX6ULk6jth9r/xzb4pg0yBZyfnIaGqGZ2IUk2c97tpKUQJAHGrADRZSEtoMxqIe
         9Gzaft+h829RI/aKSCmkylI/YxON6hQz+lofLPU/eOIidWNN90JFp0tQn+MQY3/lgR/f
         dVkKFYjgfiypk76KBXJw6VqJUN5wp55KVTrksqClvUlp6amwBTb7khjkpp4l5fvO+aSf
         +xXFcDmeyy91wyvYwHDXnIxdGQb+n/sGxFevkag3ThpQXHfvKshohgE/vvvLkxPJsLNW
         vfAA==
X-Forwarded-Encrypted: i=1; AJvYcCX0dS9bjKsh1iXa0v1VvR13kKmrXynFhlCdc6JKN0PjYZXlSEGR7HZT+YHUUtZMCPkn7bo4mptHI29svg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0/ed7bYeigKSSemu6t0SYBRvmouIqxn6AanZULqSDCni2PZQ
	WbyjZE+s/xiyP+pzA8A9JYvNRMzPjdyLOfARaapUYDZM2TVtAy/EN87X
X-Gm-Gg: ASbGncs+ciOVyEAxpqSaYcCs/+adqTL6QrTKB/iYT2K4ewYo7d3SC4GwCJkivrve4a0
	Hjam0YM30cygotbwEAGHKROoy7V+AM4iFyY4igvNjw0kFRzYBxlkRfAbmtF9YMLOMZsluugSjpj
	keSqqmTZTpgORI0bch95w6SEVJVQXP+PYDNPP+2Vnhux0CRcYfYhqDCabDU7sdSrcqUMPccR4fL
	3Zd9orii4LHcvcGCsR1TCgWpICUBvC3q5FcKOoU7qKPvScbH3/hvAAuX77GDt+I3Ns8IjGtWDdp
	QzG0vVQMU//6tSHmSpkSXeFAu1cmRLhVDzei2axoBelwqraTUC39ZjK5bqvpvtX1I5xflEuP/On
	M5TJGSF0Ad3m9uTK29o03smBg7o2QP010xvU9dW4Or95UtR85Z1IoZ0ixm2PaWVBjGKOG4iTXE7
	GQYy/OCSySGJbn7bcxmiXzV779PJqylgMx+1/+JUON/Q0zOzg1y/NwsGXWCiNAL2d9DPZkWC71M
	ZY05IqiUxGiLPvsU2NViufxdg==
X-Google-Smtp-Source: AGHT+IEK23rEbmImZjUjZqknwOE+XDHmtcXPf1FHlW5w+b2oVQdPahRq4eJRmv3aAqYbsDBgGjL/aQ==
X-Received: by 2002:a05:620a:2886:b0:863:696d:e37a with SMTP id af79cd13be357-8907030c838mr2419098085a.44.1761105211504;
        Tue, 21 Oct 2025 20:53:31 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba763sm890414985a.30.2025.10.21.20.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 20:53:31 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9DF95F40068;
	Tue, 21 Oct 2025 23:53:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 23:53:30 -0400
X-ME-Sender: <xms:OlX4aKfwcUe7u6R_1b5TUBBOomhh6hnwzNOg5WSiArEoPx4c9YG7qw>
    <xme:OlX4aAJA8r4LBTDjEzcW-DUkOSsoy85nL2R3EvfPfW6FnSYCt5YP6F4Tbvs-4LIJh
    RO27y6D8FLF4fI58roWx-rdGffN6WJOMjCbtvy7BqEbOB4oHaNlCA>
X-ME-Received: <xmr:OlX4aBqpYHPIR65WeXF4BytE_rsiCq-VOAJNiKzm06ryabRbUmFeZgOpuT8-EF5r_V5XD4dMKm5Q-e0g7K3MFKrd0W62R7_HG7c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueehgeeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggr
    khhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrh
    ihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:OlX4aOU0s4psfU22edkNKXf1-YxQRWwT2tMp9hXZdK3T8JBWayziQw>
    <xmx:OlX4aE32rnV6OL9MxgUIlKbnN98qCE-rmr7VRYa00MQybioKHahiOw>
    <xmx:OlX4aH2o7L5ATeV0BtMVYgiE5jBjZOUxy_X97XhxcxX_MHaFnssEow>
    <xmx:OlX4aLkq_-0jFOFrSYW-X3Xd0xACPlsVLVMAiGf2dufokMjuL0CKGw>
    <xmx:OlX4aAP-rcjdFXfu7xw2QmiALn-fvLwZt5-gBFIN2LV0A0gyMR0I7UXP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 23:53:30 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Maurer <mmaurer@google.com>
Subject: [PATCH 2/3] rust: sync: atomic: Implement Debug for Atomic<Debug>
Date: Tue, 21 Oct 2025 23:53:23 -0400
Message-ID: <20251022035324.70785-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022035324.70785-1-boqun.feng@gmail.com>
References: <20251022035324.70785-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If `Atomic<T>` is `Debug` then it's a `debugfs::Writer`, therefore make
it so since 1) debugfs needs to support `Atomic<T>` and 2) it's rather
trivial to implement `Debug` for `Atomic<Debug>`.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 0bc6e7b04d67..3afc376be42d 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -307,6 +307,15 @@ pub fn store<Ordering: ordering::ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
     }
 }
 
+impl<T: AtomicType + core::fmt::Debug> core::fmt::Debug for Atomic<T>
+where
+    T::Repr: AtomicBasicOps,
+{
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        core::fmt::Debug::fmt(&self.load(Relaxed), f)
+    }
+}
+
 impl<T: AtomicType> Atomic<T>
 where
     T::Repr: AtomicExchangeOps,
-- 
2.51.0


