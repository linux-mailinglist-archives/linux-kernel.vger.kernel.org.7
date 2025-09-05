Return-Path: <linux-kernel+bounces-802474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE196B452AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C463A8D73
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40973128AE;
	Fri,  5 Sep 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M7CRSVSI"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF8284B4E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063314; cv=none; b=iONU+Y7yj0deQui6L/JQ6Kyt20QsNEer7MP22mazpe6KREJq5ifHavvgTl3S+5V+/g8RODYPaNe6Xq2e5Aqf0mW1GoSHzCd480For8HwzoHKPgAaDGktcP66b/NOS0gkUsd0xnO74CNmapkId7E8laJ5yoxC3Hemr26JNfa49NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063314; c=relaxed/simple;
	bh=26Tb1NtsqwZ1rv+sVNZuBfdl1j0yHZvMb0KD02KS9aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cu3I8zUkijxV3E4WSeZ53UgUg1/baNQHkYDKR7Jw29UG81sts413L574sxVmnnRxGlMfQkArxD4PXJiJYfjiZsKzsa1CnoF+ks9rwvQO2dcDVkMTSgbNIFCGFdZc55/G4erEKuKnT+7hUOvCZYs21DGbt52TH6Gmyyadytd18h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M7CRSVSI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b7c56a987so8047875e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063310; x=1757668110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsx4ro+fg1Da+fZ6k37g0k5i+Ei4r7saLuhpbXY1yMw=;
        b=M7CRSVSIPdrVjHEiX3ynHHUpvetOiCRTKsJgCPWe7bseB9Q98YLQLGSBwHbZeGkpQE
         /aPocbNzlBPzXITNXx4BztXxA7ChXEiSD/SNq86d/6JBR/P3nzh1KWfjigJLMvgkg7m8
         J6O1ZbgnxFcrdNLJXuVy7D0i/REVhCWNQ1kC1desbMJ89+sJe39gBXmtq3jiB1KbN+J8
         y+VNjEF1H9xAuMwgxgu8MX0pob/s/HsQp7qsz+3zHu4zwuJogTmTtHkwqgfWLtzq9Bqi
         w8dfZY2DWBe8+3w8vLnPEo3zUY2OxdwCktLcbWtz1mk/uZzlMipltfboP7sP1M+3UMea
         nQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063310; x=1757668110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsx4ro+fg1Da+fZ6k37g0k5i+Ei4r7saLuhpbXY1yMw=;
        b=khUKB4Dgm6Y9QJYmkAZrN8T2Ci4DWjm/iuDTR9VT0AxllIrvLv/XfwL8ndQw8X+LLE
         9RfWk3SIrJ7RZZIKdl2kv0sSKxDDKe3pP8V/FhUALXs+79LGTn5nYV23BXOKN9v1M7Bx
         80hl/+kfWWbz8pjc4e+9ekRupqR0jKmL7heJKqXgqqZv0GUmjO3BCTMO2xUvrGJNMwKx
         CzGJWnaGWW4diiL1T+GfWu5ASUT2N2tYvNi2lDW9OLW0uBTayUQ7gZDapGW42WICj0u9
         zQJd2CD++7JFHeYaTdlOREYp3W5tDeVQDgP6yOkLXvqZqUywahKP7e//kRkyv+FBmERY
         ZGVw==
X-Gm-Message-State: AOJu0YwcUDK9iLugdO4qWI1wS/vg2Wd5un2M3ouzwLvQZJuBJtrvVfDP
	7PzIAqlIR8oSV3Ym2jUCOYp9iYn9LYANUu2lhxlnDh0rhwfBzLppXRCix28I956t5tO5MBps23O
	AUCrN
X-Gm-Gg: ASbGncuUudgKLwr+/NNV5a0o4h2xpB/3nS2DVz2uV0qgnpcYrafbw63sfIFDYq+DmLF
	U5Vdsi9S7SLPOziteSPoyjIWZ/l6sDRJcA1DuO8Pj/VILYjQ0uTY8plIPCODvt01i12Gn/Oz3Gf
	rgnf+mWlKBNqw6haRbSX5n8MiImGotxXR50mnltg62fX4tgm27E789vfl4sh+ruc07q191zwYvw
	qZx402CdRGjjSNvtnMDKWTWVpb3JMaH0Ob8B6/7OP3cd3qQmLJuiv43jEWMQa75eEjhiR3VBP+k
	zrl5am3UFJn7wPNh5FLqRj0WtgYgVU0CYIL081VEM5xy2bHMBXxAZ/ThGoym0QFitPdwm6danVR
	qKR0XHTZoYxlKgVravabcEoEqwaZHY1sTEXtliaIuJWGjyJTHmgurprXatw==
X-Google-Smtp-Source: AGHT+IHUYSE4/MqB/EOjKjkztpcu59mOOTXF5Ahf/lvz7h2oStW1eg9hrquGPbwauw4p3kcS8EXfwA==
X-Received: by 2002:a05:600c:1c08:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-45dd54a5b31mr22217865e9.1.1757063310044;
        Fri, 05 Sep 2025 02:08:30 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd0350e80sm68900805e9.22.2025.09.05.02.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:08:29 -0700 (PDT)
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
	Alex Gaynor <alex.gaynor@gmail.com>
Subject: [PATCH 2/2] rust: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:08:19 +0200
Message-ID: <20250905090819.107694-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090819.107694-1-marco.crivellari@suse.com>
References: <20250905090819.107694-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 rust/kernel/workqueue.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 8ca813d68a1a..6f508c3e37e4 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -633,15 +633,15 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
     }
 }
 
-/// Returns the system work queue (`system_wq`).
+/// Returns the system work queue (`system_percpu_wq`).
 ///
 /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are
 /// users which expect relatively short queue flush time.
 ///
 /// Callers shouldn't queue work items which can run for too long.
 pub fn system() -> &'static Queue {
-    // SAFETY: `system_wq` is a C global, always available.
-    unsafe { Queue::from_raw(bindings::system_wq) }
+    // SAFETY: `system_percpu_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_percpu_wq) }
 }
 
 /// Returns the system high-priority work queue (`system_highpri_wq`).
-- 
2.51.0


