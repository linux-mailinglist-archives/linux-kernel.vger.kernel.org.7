Return-Path: <linux-kernel+bounces-890670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C168BC40A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C8F18907B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC39432E6A7;
	Fri,  7 Nov 2025 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ByWNCVaO"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827C32D0D4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529870; cv=none; b=J4cTUkGBYPXyaPLzgx8HBaniJ7JZpstqnsA5JDG3eRUAeaYek8x2K+RPHqC2Oc3omkpD8OjPocNP1XeYhVjUm/w9KD0S1ePz0Lf1p9iEESBpu+AGuH6iqY7XwO0jKZkXe3W4K34pXFl9nl2pNm7HvH9HMtWwzQp0t+lXQl2TMm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529870; c=relaxed/simple;
	bh=L/fRQWbw0AAQrTSYnvnb7vDJYnw5QdJKA6draAQxv5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Plo64xtbJWRO6IkEXHAcw6yCGAd93Y9Cl4MSfa+skErOrJS1JqKPXwBjEZl55mkOCFpPNKU+zwpcgnY53aYRmGDgoYvJRAuOAp/W9agAcDeCDP2dhyiERAfxKngGpdbB539r7UPHcZRtJEbWsMO8WlRFLSJSlofnEoULpWOOGhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ByWNCVaO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477632b0621so6224855e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762529866; x=1763134666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aX/1slikzqWBaDhxSFj+lmfvm64U3At/FzsDp8keSo=;
        b=ByWNCVaOomGnhDXm/he6I8bpzcDDiuf9EFQGTDb9wE6oBi9Xk2g9hh0CXvTs1bJtcA
         wqKiW9d6PaEbEbCAQ0Af/5hLDZqXLqBEdBav7nQjv2X2FpH/YzIMje7EjMU6tyL0F0Py
         mN1LYzk5JuAl/lSHEFeqcroMpz+4e8i05E/hzE4R/3wQ6fCiLnbUFEhuTGm4BbbvIDiM
         m02iDD6AGKD4IJoTiUMVnKwp6mthdNBSPY/Nn2qsUQos4depuKPgWG1GMK47/X1ahRaD
         SrVteajT85hOcdx/Ef/p+f0p7EIsy+xrQsRJ0HJK+Kcp7D8Q4OJW682hjJ6aMpjOVqji
         XbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529866; x=1763134666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6aX/1slikzqWBaDhxSFj+lmfvm64U3At/FzsDp8keSo=;
        b=fPYK2kH2zicsejfn775pQUnG6O+T1vdHV98uFXCmzw06iIhVoY/OETc4iE3lw8QRlK
         27myL562XIOZm+KQetLxayynlLEd5VEIcjIP7nBJly/h4zNoSKZgTYNHdVjg+yI/Fq/Y
         2YBcrzbWQtRY1eKtuTuN2JT5hrLuqvuD1JnVkYbYuMTTUh7Bsokj9/O0DEIIQ1rfiil0
         U63i64D9FDq1dwvb6gq87mTbKgopDxp4ZaB0JSGFqT5vNJkgEQQ/pfeDLssxSWvPpo5w
         gZLqm9Se0eRqCBZkppKzx1lUWM9oNyEjtF7krWGuvXClXbtAFw2SwtHYmwEdmI6QT7QY
         uA8w==
X-Gm-Message-State: AOJu0Yxx5d2fAGtZ2uMkxsjkYDTKIlXi42tb3k04nBMKSztr29mqa1c/
	koIa8opGgdbgiatS/fLuLx+4tfvcE4uUYLWlkGYKEpLP4Fy9jmwpYEzJjOugOFtTyHEIStvEH04
	E3ywf
X-Gm-Gg: ASbGncvToZEDIHPSU16adAqv4A0TEV/sHi7rdxpHczfcAB4OuIqKpwLjojtaUWQeDyc
	Jd6gLHCkHRyS2C5K7kq/M6zjZvcSndNLp+kns8NrReW74oSKJGHavlkFFHpoFUKo/2jeR1mZkN8
	HbSV+zuDqfQYVDpy6Z/dxW9BthOEtBeqgPEZrffJ4amA/vrGzrvZxiUiw7kIZxesIuhzBv4StSo
	SiPnMwL+xChFKxVR4z+2Gk/1WCw3/Z2f3pt+0rxF0DRNzsDBA7xSPiGNWYYl5B7fOxI+SBDYqN6
	HdUBxSYkObRH3Ja7/BKPPeDQwUziIjqLkXJSQq2kUg7FBSXWbXhD528+28Vsh3FuozXGbv+ncyq
	E6unsQLbCh9lc36IdQ6hKFMOSD1ntfz0aoGCnWQXkDwoeAo0HlxPIQTErX109wAZDmN/eflm4gW
	wk0aGYQLXcAwGwR1YiDSM+StVe
X-Google-Smtp-Source: AGHT+IElWkN5KqCboVypVNxqSVD2Mu4UQKQm9+mI4eptFL0OnAqST+uUMCEHREXinYzO1W4E658QRg==
X-Received: by 2002:a05:600c:a4b:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4776bcc3680mr28540415e9.33.1762529866117;
        Fri, 07 Nov 2025 07:37:46 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67845ccsm5763460f8f.36.2025.11.07.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:37:45 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] USB: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 16:37:30 +0100
Message-ID: <20251107153737.301413-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107153737.301413-1-marco.crivellari@suse.com>
References: <20251107153737.301413-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/usb/core/hub.c              | 2 +-
 drivers/usb/gadget/function/f_hid.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 256fe8c86828..b5cbcdb08a5d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6077,7 +6077,7 @@ int usb_hub_init(void)
 	 * device was gone before the EHCI controller had handed its port
 	 * over to the companion full-speed controller.
 	 */
-	hub_wq = alloc_workqueue("usb_hub_wq", WQ_FREEZABLE, 0);
+	hub_wq = alloc_workqueue("usb_hub_wq", WQ_FREEZABLE | WQ_PERCPU, 0);
 	if (hub_wq)
 		return 0;
 
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 307ea563af95..3ddfd4f66f0b 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1272,8 +1272,7 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 
 	INIT_WORK(&hidg->work, get_report_workqueue_handler);
 	hidg->workqueue = alloc_workqueue("report_work",
-					  WQ_FREEZABLE |
-					  WQ_MEM_RECLAIM,
+					  WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
 					  1);
 
 	if (!hidg->workqueue) {
-- 
2.51.1


