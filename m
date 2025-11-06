Return-Path: <linux-kernel+bounces-888792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDCEC3BEC0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A522F1B274AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B644346A18;
	Thu,  6 Nov 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="efnvtBPj"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842C3446A6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440879; cv=none; b=rDGqo1v2opfltk6wqd2Vnr1kY48AebWDtzkhn7WFeezWlrJU4TJQJwsGlkCg3Scd7L18SZj0eyDdnCGQK2YM7Z+ySVePDu+kfjRX6yk+OCZI8iwSiVy6LIZc2fZBhjcWPc92sJW8bzjt3WBkBiDc1H/KzJqhbIT7yG5TFn7EE5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440879; c=relaxed/simple;
	bh=yqPyRRy9rOzhon+Sl71PVmdBT+h+QTdgvgit+6Cq+38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6mQoofoBb0H8fRAbIP78sp6StOeYmrgG+PN+/pvuiWgR84DurZ9zeMKzMydKI7B24DY0afTr7h1pVnRNco08ZMH9RnN6CWp74ngcds2aqtnyqf0RNqtNwZBRKvY2jHRl4vlDl9nbhLLmSyNAxGwbHoGw1PBnwQluvTl619FvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=efnvtBPj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563e28a3so8632595e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762440875; x=1763045675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/iJ8+grc2Rl2/IHfufh9TPIQreS9jjFa0ImljQu6yc=;
        b=efnvtBPjexY0aa7PbbJtZrYSZGrZ6vuz4I78aNp85IWNohP2iDl3zBx4g+ALamECcU
         GOAlcsL4Y8YElR/AnseZqSMS0wFmxPWmBdNKU8bXkZXQnciGv2LGJb5h8QrpDCx90SLZ
         gkQvTu6rmDZBxQaI2BTc7fYvtem8bAEnc0n7qIL8MZMkx9gbYYLBcbX3XRd32sF7kblF
         3ckR3eLdlhz+k+XO6NVHzap3wEN/70nHbpztWZleDpdOcQfcLG2MmyVKu+4rWSHTJ7mK
         ZCGnoiGx5WutBgbxTQc6EdX5aX30yWnztFQ6OGtvHHClyUq+Wcum5qx3r410nZuxF12Q
         gs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440875; x=1763045675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/iJ8+grc2Rl2/IHfufh9TPIQreS9jjFa0ImljQu6yc=;
        b=qg9ZtG1DkMvhOnpn9UQGlvzNJ+KaoMJX0BajVsRKGuAv7m1hqOniLAoC8pyoxoXJg7
         WhWH0jGR491yfK3TNduEJaBTFRlZZJ7yV++4tsqI2qKNi/yjG0Iw5iWJBC9i1wJnbeTl
         OKmSSvUSjo3AEMIzdgdLzePG/Pm7Q/dw0uf1+JqinJ6CsP6RemKFCTlVCcenb/aQV+Vs
         sbt+JOSTj8PemKjoiZKek1FuoQnzHMB14HTbra69JFwfDoI0KsrGmNXD9bF7gwcY8qiZ
         EH8yKA8bZtjma38WptFFpGXKsgahjF+s1+Wr64TvJsqjQehVRLfyIvfnVqV56MpdtRSG
         QcJw==
X-Gm-Message-State: AOJu0YyeDM/Oe56Ll/2To9CPe4fpncZNYoHglPJg19Mj8hwCwV5RvmpC
	Ms7343sScxnhPv5lbDIs6QEmI9nlOcR/Xywsktmq6Zc8WkkLsS07RncuUJ+mcOAAnRawEh51GFj
	XpF+E
X-Gm-Gg: ASbGncuzLf1BMg/1o/CiZgB5LhNUQ5meZnqv0uRYkQqy6cO/XbXFSTDGySP6JsKS4ly
	IzzW/CmUAxCKYXjzwRAa5wxdhhRP54r3hI2yqXWZ34AcESCxFCtQGbx4oTRu+3UDgsho/99rd0Y
	cNs3ok+zcRPs3xLeY/oLjwTofRv2NenNYoUUNdFeygskK30bLdn+XcXamFvPA/yxYonc1QL8uHY
	nr1me2kcsIjvkHWm+9Qs+HGe+7xsG7p3AKDK8sONQuR12iM6A1b8sejxjG3Ook7TLJ22qO+y+kU
	QhjRxcdP7ExKbnblgaZ7ap8XyZR6sp/vjjzk96xPJk7MSWWpR1w6aksB7G3UfXHd2i+6jxYAHrA
	KfRnXbnrmgcz4cXDUTDY44Gos8P3pmeQ6yPS9/Pezgc2DukhB7WlJeeAzm8vfyVzUwo9/fhBNh7
	9SXO0Rffn5GYRXcWYhTtxZMMrHhKAvdRjyng==
X-Google-Smtp-Source: AGHT+IE3rCRx8PbAKMPkM4/+bTHmQJ+mzXIyyeZ009J6re9yllhWkKvYevjnVHoRfNl7KwpcN4nWTg==
X-Received: by 2002:a05:600c:a39a:b0:475:d9de:952e with SMTP id 5b1f17b1804b1-4776728d457mr16306635e9.1.1762440875526;
        Thu, 06 Nov 2025 06:54:35 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce20ff3sm108037155e9.10.2025.11.06.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:54:35 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: xhci: replace use of system_wq with system_percpu_wq
Date: Thu,  6 Nov 2025 15:54:28 +0100
Message-ID: <20251106145428.250251-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Switch to using system_percpu_wq because system_wq is going away as part of
a workqueue restructuring.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/usb/host/xhci-dbgcap.c | 8 ++++----
 drivers/usb/host/xhci-ring.c   | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index ecda964e018a..9da4f3b452cb 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -374,7 +374,7 @@ int dbc_ep_queue(struct dbc_request *req)
 		ret = dbc_ep_do_queue(req);
 	spin_unlock_irqrestore(&dbc->lock, flags);
 
-	mod_delayed_work(system_wq, &dbc->event_work, 0);
+	mod_delayed_work(system_percpu_wq, &dbc->event_work, 0);
 
 	trace_xhci_dbc_queue_request(req);
 
@@ -677,7 +677,7 @@ static int xhci_dbc_start(struct xhci_dbc *dbc)
 		return ret;
 	}
 
-	return mod_delayed_work(system_wq, &dbc->event_work,
+	return mod_delayed_work(system_percpu_wq, &dbc->event_work,
 				msecs_to_jiffies(dbc->poll_interval));
 }
 
@@ -1023,7 +1023,7 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 		return;
 	}
 
-	mod_delayed_work(system_wq, &dbc->event_work,
+	mod_delayed_work(system_percpu_wq, &dbc->event_work,
 			 msecs_to_jiffies(poll_interval));
 }
 
@@ -1274,7 +1274,7 @@ static ssize_t dbc_poll_interval_ms_store(struct device *dev,
 
 	dbc->poll_interval = value;
 
-	mod_delayed_work(system_wq, &dbc->event_work, 0);
+	mod_delayed_work(system_percpu_wq, &dbc->event_work, 0);
 
 	return size;
 }
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 8e209aa33ea7..3d05734c8377 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -434,7 +434,7 @@ void xhci_ring_cmd_db(struct xhci_hcd *xhci)
 
 static bool xhci_mod_cmd_timer(struct xhci_hcd *xhci)
 {
-	return mod_delayed_work(system_wq, &xhci->cmd_timer,
+	return mod_delayed_work(system_percpu_wq, &xhci->cmd_timer,
 			msecs_to_jiffies(xhci->current_cmd->timeout_ms));
 }
 
-- 
2.51.1


