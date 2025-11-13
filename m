Return-Path: <linux-kernel+bounces-899085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B071C56BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 377A54E50EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B137D2E0902;
	Thu, 13 Nov 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYyUS1LU"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F32773F4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028080; cv=none; b=INmtCafOuSgs+3vKXD44iayV4qYIG8l5J5HDReIQO8Dr8Wx3s6miv07hUbytaKVw1/uWu94lyX+6TupkD13p66/K+DfbeJ6MoCR9RLus8VqNysfKuvvvY4aIEMuCOhf/lzl4c/cI5A3WjDU7PSMuQJ8yMwQgKcgfD5HrTDCqGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028080; c=relaxed/simple;
	bh=3b5PjEHSTEB/TZsW8zBrzKUYYUs0lBRnTQMC5bWmguk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E+lKiGTYPVOmb9MfvZXLd84z7AB0bguj676MJDfYYw4z36meaSAjjFpCA0EtISKh+z4SZJ1TqiCv6g4oZu7yyVcDUbWPP2DYpW4/tu99qg0nxKAzDKy9RPVF3WMlTUZ9AJtQ6yH8RMXuvhEVtGUtDuQErGJPWshDNG4FP2m0K6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYyUS1LU; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429cceeeb96so289112f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763028077; x=1763632877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c4w5KZd531WGutkzYGc2Uxqak6CJ8VRcLZ5/cBifR7g=;
        b=bYyUS1LUKiKW7r8W6KdO3QjDacNaRuzO5+4mcbrRU/fxQy8QMKBft1tYAXUlEFTGAB
         wNa0eXqYBETSOpuQdYl6pbsJkIeuCIWSPK/xbR0yyIesW3FPv/Ta3o3ZDgvwePY3A8Nz
         IdhdUezB7Cv5b0ldD0mWhLN3v3r93huHi05wkH4bUu+DIkR6cc5dhQJo1DVl14rFg9ZE
         1DpA4SnA5HiGyUB5PrbImE68O57W/x/Kt0PfTZEArlC8FLbj2Eq+uDWJvqByW0O972gz
         3NY23GY0E5Qx/YaaSQhNCHG2Ib9PrilF88N1hhA/yzP1bg3b41ellzUXjWyKlhghMzD0
         jtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763028077; x=1763632877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4w5KZd531WGutkzYGc2Uxqak6CJ8VRcLZ5/cBifR7g=;
        b=oLSksCY9no6GBvt3EvwKZ1/dM0WbfscUK4JIZbygK397TtmwWJmUcNEffRbpIIuyMk
         2s7Cr3EkzTNpzVh229nhNlY9TAe356jLxz8VhuzIGYXFdje49BGP4LPtg10waoYouQyT
         xsBLBe8Yoml/HTVMJuPHtLowsWm8pXS/MXQthjdfM3tosN5z0kFVXP7PuYUDIJKaVxRs
         Rl2dMUDs1OO+L9NtQfs8SIG4H5Voh7pnOO3BP8v3Aqa3j2KqK4FHiyDl6r4kUeyYHDRz
         Cmth8NLy6/O1xFuZqbUxQ/yeMw10pP5BGUpERCCx11JkCaLCyjCyr5mlGMa6GKFxV8tE
         fvJw==
X-Forwarded-Encrypted: i=1; AJvYcCU3pCXaeeWuRY4BRa7nbivDdmLB2b6v3udUbRbS1dmPHnIa2DmNYAcRmtbsQOgPFI++tXv4pVepP6gXwg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJikQT/repWFo8FheltTNw2XX0vqjzJ3WO3nGq1lZdq7nNzlhr
	zgNxickMsyYvgDU9Sn1sbU4qcEWylWhXlKVbwqTQvKsE4cf82qbW5kopjJz3szYrj85pBZxD8lH
	fUS1OALBtfvqkrkBuMg==
X-Google-Smtp-Source: AGHT+IGdZqOMmMqgKSHUA92H7sJR56vXz9P0MQh1D0De8AaXu9pFZzsxozn1O0FNiA6BaxeYIJPD/EQ5Oay2cX4=
X-Received: from wrrx13.prod.google.com ([2002:a5d:444d:0:b0:429:c500:687c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c05:b0:42b:41dc:1b5d with SMTP id ffacd0b85a97d-42b4bba63admr5756966f8f.25.1763028076852;
 Thu, 13 Nov 2025 02:01:16 -0800 (PST)
Date: Thu, 13 Nov 2025 10:01:06 +0000
In-Reply-To: <20251113-create-workqueue-v2-0-8b45277119bc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113-create-workqueue-v2-0-8b45277119bc@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=3b5PjEHSTEB/TZsW8zBrzKUYYUs0lBRnTQMC5bWmguk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFaxqG8vJZevlknr3Ce0GpQQooK/S72BJ4f6BI
 bwkM+IvOqWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRWsagAKCRAEWL7uWMY5
 RgFBD/9UrFY0v6oFOvVnB8O04B0MZgFn6IsaEFwkZHC8QBd0L0B1l/M6LtCc1NcyekGRImeD1TN
 DVRyN5ywdd/Is1PEAdnKyns+8LYY7FJuHHTo4AFYvw+3pJYnlfNT4UrB4948RNifBTh4RVc3mAQ
 MDs6SNmogT5wBAvtpNz/oIPATQ0+WFwcmmn3ugJrmn+hDnHdqBdHveZKMo/+ClteCfTcwWvwE60
 QdiLYm15PpT3mPPc3Kuw7qtYLIHULNNzi8Zfxb1vpAJr12tImtWY0JFUKJkwTQVdFtd3x6aa6pD
 qNzxTHINYkZ9ql8DJsilsCADUICtnl9c61DR0tsP2jbhDFOiSf5TFLtcekMnWT6yzAWG8G2//I/
 5sDC+eWoEzMbHL5or/g6MieBfY30hd7waGwNbzU7TvtZboVOLy+aK9e2NiX81pJLpvuWTb9Uj8J
 2XZ4N2ZNMTNNNaB/IrB54eDNuByKXqUMsofsg7pwotmH4n9Dh+chI7BGQbYotOsVMnfr2mkVDNS
 /JkupcGUF/C3doKtmEtF0DnMmEgi4YMF3G0sq6d/MjwQI32lIKqZyNwDub6jfJ+kk+vwa/yvPqk
 nbrpedApt/C6B7xaCHPG7bjPqnUNzg1RWeLny5ToaxZ7ZdMUAFESHoPveYDFBpEjyfrNyu9U+O9 RVbZW9P2L+THeVw==
X-Mailer: b4 0.14.2
Message-ID: <20251113-create-workqueue-v2-1-8b45277119bc@google.com>
Subject: [PATCH v2 1/2] rust: workqueue: restrict delayed work to global wqs
From: Alice Ryhl <aliceryhl@google.com>
To: Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, John Hubbard <jhubbard@nvidia.com>, 
	Philipp Stanner <phasta@kernel.org>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

When a workqueue is shut down, delayed work that is pending but not
scheduled does not get properly cleaned up, so it's not safe to use
`enqueue_delayed` on a workqueue that might be destroyed. To fix this,
restricted `enqueue_delayed` to static queues.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/workqueue.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 706e833e9702ba4ba9aa7756b0e1fa80079a63fc..901102a8bca54c9fb58655d80fc9624b4dfe1dc1 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -297,7 +297,7 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
     /// This may fail if the work item is already enqueued in a workqueue.
     ///
     /// The work item will be submitted using `WORK_CPU_UNBOUND`.
-    pub fn enqueue_delayed<W, const ID: u64>(&self, w: W, delay: Jiffies) -> W::EnqueueOutput
+    pub fn enqueue_delayed<W, const ID: u64>(&'static self, w: W, delay: Jiffies) -> W::EnqueueOutput
     where
         W: RawDelayedWorkItem<ID> + Send + 'static,
     {

-- 
2.51.2.1041.gc1ab5b90ca-goog


