Return-Path: <linux-kernel+bounces-845623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB50CBC5893
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498EE19E1DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D542F5320;
	Wed,  8 Oct 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AuDUGqzO"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F62F25E6
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936576; cv=none; b=pio0PBU1lPLMybUtx9q/t4V11og2M60CWbiafkNrau3Lp9u0qBvR4FDoqh/99765Jl+UTQAUlGGqN/ARmX4I/Ca9NrKu+GxnHAP75qnxDPxtIoZY37PcPyhh5MekHNL0a7hRJgUXgXNjxbRtp5qRgcCJcqiMvON4tUGPgpHzJUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936576; c=relaxed/simple;
	bh=P3XtCirKpzXiFyLTIEO5zaf6KHOwFgqDimiakDRVvv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o99pakcGyYM1RjT0uDEfs8jc1stN5JmTqD6+qcAvOWBoCrcFeoiM4b3qUhg0Hxrh7eX6v88QYT9jh9LZgPkF7h1JdofEkeSgoFg7Ilf5haufWm/kmjRPzGI/cFav4j9T7Vdtjm+4xConPS3wcYLBBicY0wWvdPk7hQ30pj+DwFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AuDUGqzO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e504975dbso46192815e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759936572; x=1760541372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STZ9f1EAsyIXOB+9LRtr2f+ELao4rQK8RBLW3J9Lypk=;
        b=AuDUGqzO6edVCr8C8I7vSZTmBthuY88TUKCSlq+n9BsDKokp7biMrQvuuoHxbU07ad
         SiUn9rcDakSWWB/3lVFmwMvf3RRD+kxvtnN2zKrcQFcniIFY750iMBII1BXbx5NatJgF
         O3hc1xzvyJXFoX3958EA342s6Xjb7F7wo2/XXzF41DDnsknsoS5om6VUNUJvglWPwFsi
         2BK2JJTsn1FHgHw2pY+SjQUeIBFT7tmSHTj6b+VhH8w9CynQvt1Jiyt8u83wTr5uzsOj
         1IUNzQGJCzHZhmG7LXJyba9KKHG4KqCnBCpq2wIvuZ5HojTwR/inHKZz/encbmIDXMb2
         Kdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936572; x=1760541372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STZ9f1EAsyIXOB+9LRtr2f+ELao4rQK8RBLW3J9Lypk=;
        b=TdcTC8yF55oSc5Zu/Jpk9QIqYodCmwEASK3kzQL+fh2q1mKALxwQ9I25Ekd4XHWc/B
         Bw4e4jhg1do1CRZhU1eek5AX6VFPM/68gz7nnkv6htmkRiRwc3I6sH2+/ooGHssycQu9
         i9Mm+kZ4K7LqLGJfIwlddR0m9x3e3KgdH1IU1LbnH5scx3rkvGAWM6TkBp2t5hFw9z36
         4+uXW5HC3t9Crj3jz3VTmfRvBDwc1wtj3Umn8+FNxf34UIUpLPNKl4RnrLgjpib84uOj
         0Clts0L7s5Z2l5XCqHLsK5L5Xg9/J8dv4xrzonmCmBBt0eq3+KS0b/MBmmzf9HqR5tgB
         kNfQ==
X-Gm-Message-State: AOJu0YyM9VanNpmR9+J4vnoMym0gT6yRKNp8EF/nkUKjX2CfRvH2y+0w
	YC0fguy5293QqqKNlmp1FN+h/xKsJHI0JtdXJcqbNHldk1LFH9UqcPcBiDdSoU6PXdPY7nlbHR3
	bVmgc
X-Gm-Gg: ASbGncsVSSB9xjEpTTQvbQHw/t+Dlvd8J7pWbZ3b00Jv2E1rjsnX16Baemhstaenweo
	BbciuTacbtaa5AezOKeSXyN7Tr7M/y2ipH7t5YCTFL/WmX5JPeXAR0pSwq1hYjbcas4MT/AQMzn
	ANLy5h21ZR91HsdKO6TB949mD8fWVkx0oUl9l6tVuAry2LoX+bB5FvpUsCfqTfgCYCMp21/wdW0
	m5KeeKAeMCs5x8s8JLbkXv3ihx8cM4iRLn50xUvRe0q6blN0zYl3nFQDInICzBc4KJTpmDF2Rld
	N/DndAbyWf21gYREByDdDD3D9vjtjpt/5hYiJYiO38VFvJTZ8VKoXAOmqvrpPVcjtdLEVW9UETj
	jjk9/5Xv36iw+abrlSYxW8tgIhbOw0HNDk8LuoUbstUasgoPLBcO6AG/OVjUYqDY=
X-Google-Smtp-Source: AGHT+IFKgYgrLRynw6bajlFj0xIITfwp5pN//xulWCMS54+UQh1/HQxMEhuAUHQLbli25xjWxnjpFQ==
X-Received: by 2002:a05:600c:4e94:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-46fa9aef553mr33537225e9.24.1759936572083;
        Wed, 08 Oct 2025 08:16:12 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf8288sm42480555e9.2.2025.10.08.08.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:16:11 -0700 (PDT)
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
Subject: [PATCH v3 2/2] rust: add system_percpu() around the new system_percpu_wq
Date: Wed,  8 Oct 2025 17:15:54 +0200
Message-ID: <20251008151554.340806-3-marco.crivellari@suse.com>
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

This change introduce system_percpu(), that use the new system_percpu_wq.

system_wq will be replaced in a future release cycle and should
not be used.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 rust/kernel/workqueue.rs | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 300cc2bfe012..05f213444b91 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -940,11 +940,26 @@ unsafe impl<T, const ID: u64> RawDelayedWorkItem<ID> for Pin<KBox<T>>
 /// users which expect relatively short queue flush time.
 ///
 /// Callers shouldn't queue work items which can run for too long.
+///
+/// Note: `system_wq` will be removed in a future release cycle. Use [`system_percpu_wq`] instead.
 pub fn system() -> &'static Queue {
     // SAFETY: `system_wq` is a C global, always available.
     unsafe { Queue::from_raw(bindings::system_wq) }
 }
 
+/// Returns the system work queue (`system_percpu_wq`).
+///
+/// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are
+/// users which expect relatively short queue flush time.
+///
+/// Callers shouldn't queue work items which can run for too long.
+///
+/// Note: `system_percpu_wq` will replace ['system_wq`] in a future relase cycle.
+pub fn system_percpu() -> &'static Queue {
+    // SAFETY: `system_percpu_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_percpu_wq) }
+}
+
 /// Returns the system high-priority work queue (`system_highpri_wq`).
 ///
 /// It is similar to the one returned by [`system`] but for work items which require higher
-- 
2.51.0


