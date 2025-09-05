Return-Path: <linux-kernel+bounces-802473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E74B452A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0556C188A7A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6B30DD02;
	Fri,  5 Sep 2025 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ah0tmg8e"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0337B30AD06
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063312; cv=none; b=BQOfh/LMXQIF0e4GnWy3T4irdZS+MkoDU3K0hSuqZNDAFKm00YY+RHefowx2YXVsE0ufbtXlS627lhqG57oNoHJ4MBJxmehwg3KW9bOe/fxVPG1xyH+IzmYK4B/AwmurbD7qZkZTKC3f8pq4s1HJ5jaB9oxVhZs7zXa4HWvabLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063312; c=relaxed/simple;
	bh=k+ixhQPGGF72LjHNNF5qNcmLsCiq464i8JXv41ZYhso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKUNt5NysIWspc2eJGsQ8ez28GrSbQW9pICJnuFg21W3hfSkuby1BX1z/PCBfra9TR18OXwG06+JkpxLA29kH9T32o33qRYUwBFLm0QzJKGOllQVBQAg92LobMTHRlKqDbZHbHZTmGmuhfkfJHDps3IpYlvGx6OVxvyeenHQYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ah0tmg8e; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b9853e630so17658865e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063309; x=1757668109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMpbE6VafRyeOOP29fdsM3EDpozD5yF3rEIxtn+59NM=;
        b=Ah0tmg8e1B9z2LnN3sOiJ2+WgecqgThPr+eTgN7oPxnYlp0W8NtQ6Z/U+AgGQUBJfL
         vwon7GE2oAhbZL8Hs2JtI9wy6xwpFkMWiGqDnGPTNLeBfyWZt0BIfIOW3F4BJ/NX/Kpx
         gzLSHlBgwnwAUwENMGRkqrxPmkeHseWJuIs+FPZ6R963TZzyos+oAwKa1EzS4drOOJsa
         DLrN2ecNC+HJRUDe4FjOudgQW5DKHecTYIUn+ZJwGNMtbCj2rA98tT0laH8UkkRoUOoL
         qx3PFSFdUMeUz8rC2l/RLPP/ayT5HrCm1tH/UVwvDHeLb3S1Cw7XlB6yqmRrQlgzk8s9
         yabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063309; x=1757668109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMpbE6VafRyeOOP29fdsM3EDpozD5yF3rEIxtn+59NM=;
        b=s3F5vBt9ZCqfjKcp8BkntUCDj/gCA6gR7DWmfAvda52YczteCbsI/piUQNQZhPOTAK
         p858gtMnLrMql9u1jNrPHjctqdlSNVTgEqLU4UvLkTwkehzuAiE4n1d2qQYlf3a2nIL2
         sTlyPwHkhAUMRYSRzaVZuJhN2cAtdmcLxjP1Th70FuSP3rCfF+L5vY4YSwxRZRUmQXIp
         pU2F6BOVsh5nVHFj43ibZbrzqxoRh627mYDJuaqrMhWQWrijbSsl0/g17rokXn8Ri8g4
         S+kXAMkyGf8KCuVDj8aP+rwUbQBOV7w5AHE8uxydFOMRpZOvPEf0eAUjTjaN9X8RpK9X
         8bAg==
X-Gm-Message-State: AOJu0Yz1XtH2ycd42msvRrkNzlsFU2PiU6cS7rUc3h4uy9P3B7oyHzkU
	NKv3+A9zu3///vwa/tfkN+Zefomh1FB4A+hahMOc9lcdMM2wRUq2DWB1fkn+u7sIAFCdOU56fBq
	d/gYh
X-Gm-Gg: ASbGncubCwgQ4rjQT+i/TUZhhfqpz7cRCF+rOMHXtRQ3Ba61kfXKK6z2UtTNAm2O1Qs
	mh4R4tx7EBcqKcevc8T/LEDXGyJwCEhNzcHggUZsEZkwZYE5J1RlANMoBHK9Az+gqV3U1XLQgPX
	HKHK8ZeCDh5V+YR+hQgJZS6F+IfwpdQU6THpUxkBZxm3wWXB+32sCQPL97t8GzjCarZVLiVnMyP
	wYdJp4KgFOtvr1EJUUsiNmI9oiPdBaut2ONzyvIornqtrKai2s0pVcq7Dsfi50DzNPXiLBA1QY8
	zWxjN2HBYw28KL1i2kzrkqbtyCK/wyiz3/7oNT62YBCdWKlH8a4JVi585aGCFbd5PWBIt1KGPPm
	pDRDI7fvB8Yi2E5m5q0nmQI+MWDW9eT2V77lXUkr41/IAl+FMIfAesynHSw==
X-Google-Smtp-Source: AGHT+IEQ7iICtAFI26qq7I6gkL+FcH2hfR1NxHLVFsStd3ArLDcFGJmIecq7OFAY9rQ+tTYgegYx2w==
X-Received: by 2002:a05:600c:3556:b0:45b:8822:d6c4 with SMTP id 5b1f17b1804b1-45b88321ca0mr179252895e9.33.1757063309076;
        Fri, 05 Sep 2025 02:08:29 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd0350e80sm68900805e9.22.2025.09.05.02.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:08:28 -0700 (PDT)
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
Subject: [PATCH 1/2] rust: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 11:08:18 +0200
Message-ID: <20250905090819.107694-2-marco.crivellari@suse.com>
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

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 rust/kernel/workqueue.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index f98bd02b838f..8ca813d68a1a 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -662,14 +662,14 @@ pub fn system_long() -> &'static Queue {
     unsafe { Queue::from_raw(bindings::system_long_wq) }
 }
 
-/// Returns the system unbound work queue (`system_unbound_wq`).
+/// Returns the system unbound work queue (`system_dfl_wq`).
 ///
 /// Workers are not bound to any specific CPU, not concurrency managed, and all queued work items
 /// are executed immediately as long as `max_active` limit is not reached and resources are
 /// available.
 pub fn system_unbound() -> &'static Queue {
-    // SAFETY: `system_unbound_wq` is a C global, always available.
-    unsafe { Queue::from_raw(bindings::system_unbound_wq) }
+    // SAFETY: `system_dfl_wq` is a C global, always available.
+    unsafe { Queue::from_raw(bindings::system_dfl_wq) }
 }
 
 /// Returns the system freezable work queue (`system_freezable_wq`).
-- 
2.51.0


