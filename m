Return-Path: <linux-kernel+bounces-806294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC86B494B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BDA57B9FC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC89130F55F;
	Mon,  8 Sep 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QZ18XM7w"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41584304984
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347381; cv=none; b=spta+VYutSxH97XSMMnqAbVKURBcUG/XwaZjORdAhg7IXu06qEs3yOIVHxQh82H4IckH0ykFuVXhgi/OPdrNWBfHguQ8/80QK3I8OyGsum9AnLVLgulF+f4UtdrsuGH5DQVc9YbAnQ540DFxQEOjtk6avdfebKcXsvL0PJiAstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347381; c=relaxed/simple;
	bh=cpDYRZ5IJhjkKjhFzJ1vTz1M6dBiBoRAu8bYqSbinX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdBZgXkWsu3DQ58fSSqLUFXi7cXjZoNx1fqEVpTCeNXHvgxdWEWr2UNPWwxSfTVzSg6pn0aQUccnia+q6B1hj/8QFYu7ILam0Bh0MTm616J30QXf6Yo7WzRATBj4njYZ+Gd9CTYR9n6/fLJzTjCVegNyOv0eOwSFdOCmBfJaDKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QZ18XM7w; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45de6490e74so11037125e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757347377; x=1757952177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj7LaxgEoUuQSI89v+dCyeAFlR0ZKT1Zqyn9nsiJnT4=;
        b=QZ18XM7wxv/uLQ1iwjq+CEHfcCalB37afHEqyXe70YAZUrxUONOo/lUCtt8d72WhBY
         z+R92dZkmEFjv1olsm483JkPwHsG2Z5VE72wJ8FoQOuTVUiCPEWgtWpSrdhUQnE0hfH0
         m70EuSmzihbtJYg6FuEtWxRjNqp01zDTO9eiHvTmeOEdpuMI7ht6YE2UuOcAN6inn+2Z
         yeq6gkBpQ/yOgODTbbwy7WnnTO7oZ2y7CsSnNZaJX3lZLPy8Cb/9p/NHYv6teWeLrWD6
         pwpKIkiknhBU2E6Lz4syhqeM0x1txLADEb54bn9ToSKxuzMH2M1N97HZorFpP5LAigQ/
         Dt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757347377; x=1757952177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj7LaxgEoUuQSI89v+dCyeAFlR0ZKT1Zqyn9nsiJnT4=;
        b=IYrVbXT/vIHvTRQ96jPCd4Z+V81ElpQ9DpA6xfytXM719z9Ts2rJQFRMvXcL1me9xN
         Lmyzmx7BJTdDYKpM6drJ6IhEHA90w/cqydyO4nc50Q6QaUkykdDZHZSHWet2D0iTRTua
         md+pKiLr55qjiYo5m4Zo8O330R7O+38j9cBFboiAGypsmQnUG4wKGeqm/P8JvzrArBn8
         fEmZcedlkzqx6yPJu9TZXsN5j3t5j4I+nx60iNweafKcVYQS6bDjSzKTwmxLZD6aJ7p7
         la1wSwxEN6JQs+l20oqc5k0vHc5iFJA85TkLMvhdYkUwZWtgnIZs6kESxud/xocSWCmG
         g5Bw==
X-Gm-Message-State: AOJu0YwvD85fwD9y+s4jJRZf6NB1Or2FrCJDrUtLDH5dqSSO/o9fGQlV
	JpPtKtdUrjgyrIjhe2Id6Wi/wL3akiaxFSH/mWXYfo58MZo61b9GJ0rOi98wwM224fXbIWNHslZ
	VAWWu
X-Gm-Gg: ASbGncvaw6M3aU8s1modjt9GybgS+pdactiCmK45nFyFBc6CmyWhLH4gGenDST8JG7k
	MxWfLs12M0j/t08Muf1p8WooX3Ij9wLS0Z5J+bEctOEECGbEpnub2E2xA6g71c/hR4Y+Bt3Cz4L
	NpS78YkSBHDyU1T1WVJ8Or98wbMHdyhUwwMLpiRzqmmdpZqvwJTnlqJUTSEdZ/qb9Gd+onnGbpN
	NSYUsixOk65YzXVrRZdFR50CLNwFfoiZWmpO2/Md6XKCO/VM2lB8MuqdPWW5M3MQHjQfKXzvyIU
	i3xU07pT3yU02oa39hRhyPyiJhbfk+D21cXXgLLIgB61sfrzz7caXaZJXzW09sqeP6Dswkdo/KF
	DR6534eE7njxLu7d8cJ3u2fAh1VR7e0nsQbD+eTxa1q5b9f+4HJt8EJfm0edsTkIO/cDx
X-Google-Smtp-Source: AGHT+IEX/q1lpajvUzRGZ7zwJQGERd8WvN74KuDFW6tkBrgWMYXBbT7NDFXG3LRhu8xAfEpSq+e1mw==
X-Received: by 2002:a05:600c:474a:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-45dddea4cccmr83152635e9.12.1757347377212;
        Mon, 08 Sep 2025 09:02:57 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de5eabdb0sm55358075e9.8.2025.09.08.09.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:02:56 -0700 (PDT)
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
Subject: [PATCH v2 2/2] rust: replace use of system_wq with system_percpu_wq
Date: Mon,  8 Sep 2025 18:02:24 +0200
Message-ID: <20250908160224.376634-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908160224.376634-1-marco.crivellari@suse.com>
References: <20250908160224.376634-1-marco.crivellari@suse.com>
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

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 rust/kernel/workqueue.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 01e331a1f11b..8fb16d1015c9 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -639,11 +639,18 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
 /// users which expect relatively short queue flush time.
 ///
 /// Callers shouldn't queue work items which can run for too long.
+///
+/// Note: `system_wq` will be removed in a future release cycle. Use [`system_percpu_wq`] instead.
 pub fn system() -> &'static Queue {
     // SAFETY: `system_wq` is a C global, always available.
     unsafe { Queue::from_raw(bindings::system_wq) }
 }
 
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


