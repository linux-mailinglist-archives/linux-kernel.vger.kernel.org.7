Return-Path: <linux-kernel+bounces-806293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF260B494B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71357B288C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CE230E0EC;
	Mon,  8 Sep 2025 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GVbdwwkg"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F91DF26E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347380; cv=none; b=ZstAwIXcGgR4xQx+zqi6Et90u9eLYMXunGwmXm50bTsSq+RoT97q3+6OmD+vJr9pjWt9Sl9mqmU+4f3yy5xEsO0oxUb4p2ife5lcEzMvHOeaNO9BJ35j6cq7R1W2k7H8c9mAqH/dKwZTvUhw1ZxV3yO2A6N60tld2I8LLXfId78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347380; c=relaxed/simple;
	bh=muHMziR6xLMl/Nc8dXnmMmFgMfjZIGHcsmFG/iG/AVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojWl8ekAhXFwXXU8nuGelkBZ2PmK71btexF25AvJStHiEbgq2iXVb0XwZMq5ooaWmCP5uvgFH+uixZAqsWdxI31tYytT7I/hzPaJBUC/EBibO5REhrWHsvjE0hv/OzzvYLUM++R+zypvoLUElKcdqBjsAWXYO7LtVBe3kovePzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GVbdwwkg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dde353b47so9079495e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757347376; x=1757952176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKLYuj1zBe0tw28xEet32waA8kdE40/dkPVFZ16WtA4=;
        b=GVbdwwkg6ZB/MQ028GQpD9wfeQ1pMxs53SKGv1LkLGlT6VL4eL6Kf1/yUHtjhsJcK7
         6Axpcnin+Rke50/kiXp1tAJiniCrQ2A/qllPz9ARo1Rv/7M5OZgslx3AgB9kNdExHQ4X
         YR9XpXa699KW0ajTysyT2LTmFSfQnAZ0BbFWIMqE118eogrYOzA9kJmVLf6/X73yUZFP
         T61Au4g5bgPU5nrZDVYB01yfR1SMSdzJQH9KmU+frkS0vViWmdir27kcJPlhfs018SD8
         UAVNCdumW+pj0B3lh1lnge2mBOjUdzKzFky0IAR7njT9HeQDzWtavjkg4HrHYJ37++0f
         78yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757347376; x=1757952176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKLYuj1zBe0tw28xEet32waA8kdE40/dkPVFZ16WtA4=;
        b=ud43Y4b0Y0jPHpXZgBzgdljg6mlFH3yZAuufVsNYPTExNp59XcNZYx8tETk3DYvEhE
         G1dTXzKK3NM63IH41G1Q9sPcuDeuCCGkrY6iZQKtczBcihpB2g2MXwyZsPD8+6qZkJWE
         +c2bUf9MVCiWm4F+bznv3DWn5neyHqKRVL8qj9epCbFxdw/7usziNJ4oeGYOvfqlzdpl
         HMBoWHXy9QsJG5E4rL4iuSW20VM3a0nzZCe6+DglF0Ur/MLzsziGosntfmt53nZ3+o+y
         scnje0bBNUkjNkfnQfItHGBmQ1OHFQBg2fDTCgparKhUpm5dGJFFAELTUFSW+3VLkf9o
         eO0Q==
X-Gm-Message-State: AOJu0Yx4ZY4f5gCymqArZfRClrbtF8WmjqgeOOA6SoAaYRzBI2E6Tj4W
	aFtSd7mk6lUw/9QgksfBJ/R+9hYCNXfAjwb06dk3sSE7xGVu7jnRYCYpR54YWe+ho4Yvncn+LYm
	qyG9N
X-Gm-Gg: ASbGncvIjWYilZRMMERbvhs8BkN3YNQAEs6fF7tJYW+uLJYPir+s5d/L7iSWknXzPjP
	zA+qezwRW21oMB3/clX4Jogep9wQD3pyog4kQ6QmP0G0G5fZfPPLhTzKGI8VSnJvWgKIDc+EVkg
	YK/7plZVBey8YBtxwNkQIG8LunS40wFenvQBYAWvnU9rrxPoguOr3az2pJKZc3Xw8DRSw5z75d1
	dVYLXowQXkOJG5+1sKowf8DmsDJtYPWwh3WuuNzB9Z+cCpSOGznpULUsZDQd6lVoP89FIYpXhAc
	h7pSFp2mXCCeWnceOe6H+MakwEKYMo+klNh10dlY4jo9XLnyKgJ4CkO06G9oH2IeV0RPfwwU7O+
	plfgLlh/JStZavFrkw9tMwQ2aLoJzy0lis/XsHDFUF5b4I0r/jKdWlQWXsxXUUigroWgP
X-Google-Smtp-Source: AGHT+IFJVlzkmZHaBFQ14oRcj4jOEGD8Cc/KwQLz2s3/80/2vatwZ7I8ZaHS4qGcVAYrVKzg+U3RXw==
X-Received: by 2002:a05:600c:4688:b0:45d:d2d2:f095 with SMTP id 5b1f17b1804b1-45deb702e1dmr14497635e9.19.1757347376105;
        Mon, 08 Sep 2025 09:02:56 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de5eabdb0sm55358075e9.8.2025.09.08.09.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:02:55 -0700 (PDT)
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
Subject: [PATCH v2 1/2] rust: replace use of system_unbound_wq with system_dfl_wq
Date: Mon,  8 Sep 2025 18:02:23 +0200
Message-ID: <20250908160224.376634-2-marco.crivellari@suse.com>
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

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 rust/kernel/workqueue.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index f98bd02b838f..01e331a1f11b 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -667,11 +667,18 @@ pub fn system_long() -> &'static Queue {
 /// Workers are not bound to any specific CPU, not concurrency managed, and all queued work items
 /// are executed immediately as long as `max_active` limit is not reached and resources are
 /// available.
+///
+/// Note: `system_unbound_wq` will be removed in a future release cycle. Use [`system_dfl_wq`] instead.
 pub fn system_unbound() -> &'static Queue {
     // SAFETY: `system_unbound_wq` is a C global, always available.
     unsafe { Queue::from_raw(bindings::system_unbound_wq) }
 }
 
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


