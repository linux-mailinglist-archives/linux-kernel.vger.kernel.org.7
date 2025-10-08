Return-Path: <linux-kernel+bounces-845622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2573BBC5899
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6554038A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8278F2F3C1A;
	Wed,  8 Oct 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PLLrhrOT"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22D2F1FE3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936575; cv=none; b=R4Am0yZmjfmHaaQT+rS2heRljhcv3AWGdMyXDQW7ct/q1kKynpoEi1Y7Uhyrj00Oq/DA99hoVjM7xqpglqGhR2lBAa2gWfamrMt+4xJU93eqRoS5LcI/ukcRqqf6UZT/yj+N5U9NB5d/Gp3OehOzbp+45fw8BRKwL7AWL7/WqvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936575; c=relaxed/simple;
	bh=ais4VBo+OWtnTKJxBodRn7FQGVFsUHCZFYAfIWOzwCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Df2MG098pgecYDSStG9LNrmn8zuUmx3OK9SyHg2Muzy2UdP2r0C7bL1WPWZlIWLHGXN+Ii5241z6r2MdKbVyG9MRTGoPKG8/MoT6vZ7LPcBliTSQ3DGU5jja+HUyLF+IY2F/kYtTLmWMFR/KF4F9ZoCULEotUejCpxghdGEzCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PLLrhrOT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so82913235e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759936571; x=1760541371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPMYQnkDuAf+CRUJRE2Sk8y1N15ePx71ZP84+oRsHdc=;
        b=PLLrhrOTvjYcR2EbQTuW1lTnVWPsWn2+dTY/2Cp9o6HBVZ1bb7UcoDKpvShSAeS6ZD
         T0g1J5l950R5/3BNEtBV/Epo41fIml5UqXo0U7sxAXRURHhHE7jm8Pjg9kmc/I+vR0fE
         ERfI+dpZu4hQQfziu1k7uTz3QgdLFlq+cfOz9djmuLNQxwz/9KRhxuOMYtF8XbhY46zl
         1FwEC6VgT1ZdjmuabBz4Zae8edt4s+hBItO9+QLL2VvK1ei39PQ3Ckgy4OlCT7JXp0TW
         a7mrnvkVt7TTsxVpD+pitBUfIU5n9SZGS6XGDbnnXCMY+46eyd9Y67PW2xvednY9YWrU
         MJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936571; x=1760541371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPMYQnkDuAf+CRUJRE2Sk8y1N15ePx71ZP84+oRsHdc=;
        b=tzDDxj4PWpyf9nnHhtHQoX+s/BqE87fMeqRv5ge2DxNEzNqAb1YAdCaunbHgTxhknP
         Pb6UPYBCEu6ro3dEIrp/lbzniAeeEUPv/S4MCPIPUHj7hsbCl62mUqvLep+SMrqCgPmx
         fayS9GtFFzT19U69KGcYqrAmUAg1DmtBAW5bu+sRNalfBQmtcqvYREkol1kZJAykG9O9
         2CP+tMpOJKDz7FZPxTc3Orl925xNokumMI9KW9VUxXHzrFXV9Cp/QlfxG/Qv+ADRhjKG
         lsMonzmUf6pzzx3brsrXdD5aS3C+jYYIeC/I/XtnIT1kSO99Do80jAATMCQYXv4dSbB1
         Y7WA==
X-Gm-Message-State: AOJu0YxrDQWk2ASMuenoQsp8r3NYzMRDuSk4TclNiQ+Jbt2O4/IDjF9n
	5cy7q5yEq6km2a7Re8BmYCQ6LnYoqZrqhqUR9BucBGcCEiZtZoOwKBH0ZL+uFh7F0XeARZ+lyTH
	e6dgt
X-Gm-Gg: ASbGnctQv4URrCHmteWv0Q9j3W2wqkFHEwoU6mVquhNNgZBPK70G4W0ExVAxhNGT0zk
	ONC7DpAjO+CaQrvTpBKjcCF/KX7jlAcF4oJc0NrU6OMbVo08V5n6647ytoCH09AldCqoQpR8UxU
	2lbiMsh7+B2O3G9TLeiIjMWdiaDnw9hAm+jafqDLCukXtB4uMoeLa1zGUzcwAQMKpQyIDIqqJY8
	U64V1wrw1UxbObLpWoJ1M+x7JWlQ+NEemmEXjg3vzDTDAWZjGhxT7On7Orzp5EsyWA1emtD9a0Q
	bh1wR5q+2q/Pvn6WYELfcycgeItLqG6ycrKhiCafHup8BPVuGUvQAQEiCVL/ljP+9ir9C5fU9DM
	rLYEfuleyfhJXcFMNjpm1dlqYzuLH8KmOdwCykJ8bATgGARKtE+3VPZqbffUyP2ZbbaX56IdUFg
	==
X-Google-Smtp-Source: AGHT+IGTlYpcQn5B2r7Od+8utSka0uBV7TXKo0uGzLvdZkLEJ4rBleisEUkROXH+El3mxXEyM+w5Ow==
X-Received: by 2002:a05:600c:1e8c:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-46fa9a8efbcmr27903965e9.2.1759936571060;
        Wed, 08 Oct 2025 08:16:11 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf8288sm42480555e9.2.2025.10.08.08.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:16:10 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v3 1/2] rust: add system_dfl() around the new system_dfl_wq
Date: Wed,  8 Oct 2025 17:15:53 +0200
Message-ID: <20251008151554.340806-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008151554.340806-1-marco.crivellari@suse.com>
References: <20251008151554.340806-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C code defines 2 new workqueues: system_percpu_wq and system_dfl_wq,
respectively the futures replacement for system_wq and system_unbound_wq.

This change introduce system_dfl(), that use the new system_dfl_wq.

system_unbound_wq will be replaced in a future release cycle and should
not be used.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 rust/kernel/workqueue.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 706e833e9702..300cc2bfe012 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -968,11 +968,25 @@ pub fn system_long() -> &'static Queue {
 /// Workers are not bound to any specific CPU, not concurrency managed, and all queued work items
 /// are executed immediately as long as `max_active` limit is not reached and resources are
 /// available.
+///
+/// Note: `system_unbound_wq` will be removed in a future release cycle. Use [`system_dfl_wq`] instead.
 pub fn system_unbound() -> &'static Queue {
     // SAFETY: `system_unbound_wq` is a C global, always available.
     unsafe { Queue::from_raw(bindings::system_unbound_wq) }
 }
 
+/// Returns the system unbound work queue (`system_dfl_wq`).
+///
+/// Workers are not bound to any specific CPU, not concurrency managed, and all queued work items
+/// are executed immediately as long as `max_active` limit is not reached and resources are
+/// available.
+///
+/// Note: `system_dfl_wq` will replace in a future release cycle [`system_unbound_wq`].
+pub fn system_dfl() -> &'static Queue {
+    // SAFETY: `system_dfl_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_dfl_wq) }
+}
+
 /// Returns the system freezable work queue (`system_freezable_wq`).
 ///
 /// It is equivalent to the one returned by [`system`] except that it's freezable.
-- 
2.51.0


