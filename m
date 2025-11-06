Return-Path: <linux-kernel+bounces-888900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C2BC3C376
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B67D4F9020
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED79730DEC1;
	Thu,  6 Nov 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WCfUAOA+"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7AD26529A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444726; cv=none; b=lm5ADJgIMO5wUGnMOtGpRuOVXHvGhuruxWKmxOIneMJViGubGvXkN2xMukiNWhmR+jh31WvqxanBYFtua5Qz7hl/C2BTJ8f+/8iZj8YgyrWYpR5bDLCvwWw9aCXbR6d1SdDN4Kck1Aw/J7+NgVxI+/4JUD5SFBTBjqFobzLIUf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444726; c=relaxed/simple;
	bh=yJwCZuSyp0AuHoYgUuuf5DA1yb3KZTt+mYtDCkhDEvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYx+anFVw/5xQlFSdFxc7O0OlZlqhIAJ/RCrzwVYu4YV9pB506YtI/RYwgiykuj7xURFqceHS12GkAkuip4f23rEdOi4LATCrrH+8MoTn09y1g03WZEhBjaZRuWUYJ900Dl8j8bKlKfgcBEBevrCayq+pEtn5nKZWpsgZVgwsB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WCfUAOA+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso9151685e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762444722; x=1763049522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53hexOkYyaqxhpOSn/nthNa2oVXwHIV4I+WyLFdMY9Y=;
        b=WCfUAOA+3WzBgQtCTK4wBW2N16++aTOVs0ZUrtLZDcJiDllaWqZ9Lw7J46r+/NOM6m
         H5CBTxrU8DNG8iNnwZgXPYyM5/mUPDhFjInhYstDICKhNOQYCzSzeyEg4JS+Z1uHUxt7
         pB2zFM98bUa2t4zEsuKrtFxwEkQ6PQt+f1ZFfH4tUhNcp6uArdlr4O1geMCuj8PTgTfO
         +3vzM0Zz/aMwfkxFA0PxdGiS8kQrPveFxtOeICI5NpigGjrYqsb+Zw8NP9+40aUvAEmr
         GLpInDNryu7IHkQkJhoSKHTVUaxTXD7y9OG277zfXxi0qfk2fOTKx6UilcQdEgzTb7/i
         mifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444722; x=1763049522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53hexOkYyaqxhpOSn/nthNa2oVXwHIV4I+WyLFdMY9Y=;
        b=ax7eAGYbwRSBAQYFnswVbGEiwHj4CpJA6IjOBBLXOs87UyBq8DYuBK9SdKgHMSwMX1
         xI/Y8lLIF4hOaU4jf6R5FR9ZG/IkJXWu7WvbmM8lQjGmSYuxCk5r3SegpVtRVM/uJkOF
         /9LwcsA/HBdvrTs74CqGfeDbskgZgFtz8tjvco3WyWbBZoQY9tQj/ay7DiHrBqvZ4tXo
         745OqiPwdTig3F5moO0v/mh4ECOdUaeHKR3Fd6d9oqEJbcMjZEIbAUuTgjdWv5TWXgEV
         3CcxSj+SVbsnZc4GiNVOB4LRkxn1EHj2SHsGjlSolpKqeO1DoEFJT9ylBOJTMBIuUZvx
         RMcQ==
X-Gm-Message-State: AOJu0Yyz5agnmit+P0axrq1oXVBjNiqgReVJ0G22iPeCkESdFu9b0lAG
	vvbTV7JDzWk8uB2q/dmG9isnmTSQgefmSOVXIWDyM+/Z135SgYcobkGv+TE4KM2XSLlhr6tzcJ6
	vEXEm
X-Gm-Gg: ASbGnctboLDfdWUfxvx/4z+QOZhTYNeoQ1QLxr3aI0MZiI0wtQC47d81PVp06pcL6qh
	Qg/zDg1Hi5+sfOVwmfnPovEB1QFnBBYoRkWQCr68iF5VLUAVLUASFRk5vH/bBxLbsC3e8iwBdcD
	5INGjQpTpAC1RPdYpvBXzo/Gbak9D3u4Sz1iDU3KrpJ7YOsLtokLf+rTwscI1ZVQfcE7jT88Upu
	hx1zPkc9XGdN2rgUgNIVWEWhQgl9cVl2tnBEl5HK8ZEEmI45un2s0WjXXRcvk33pATbO+XReNv+
	ZoIgpKybgq8FtFPLdJAHP7C0EA1hbiLTylFbWItwzV93fIwhE5jc5qh1QEC620Htmzf+5hw6qPK
	p1NAMHfm2sr3H+TjO/4hgiCrzYG0dJjHQ7UHIkvkzrRSelN046H1WrkIuJCpIMi0JLaghIgTWPy
	B2Jv7q0qCOoZO+U9zRU6/n4y8=
X-Google-Smtp-Source: AGHT+IGsuM3JnBRPrLDis+cGJhcRI2m6z7HtbWMdfo50tweopR7jN9KNvup76xnxqkeK15q0yW/MHQ==
X-Received: by 2002:a05:600c:4e13:b0:475:dd53:6c06 with SMTP id 5b1f17b1804b1-4775ce3b380mr76738075e9.40.1762444722455;
        Thu, 06 Nov 2025 07:58:42 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403793sm5758966f8f.2.2025.11.06.07.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:58:42 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH 2/2] xen: privcmd: WQ_PERCPU added to alloc_workqueue users
Date: Thu,  6 Nov 2025 16:58:31 +0100
Message-ID: <20251106155831.306248-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106155831.306248-1-marco.crivellari@suse.com>
References: <20251106155831.306248-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/xen/privcmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index f52a457b302d..402be080ad2c 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1091,7 +1091,8 @@ static long privcmd_ioctl_irqfd(struct file *file, void __user *udata)
 
 static int privcmd_irqfd_init(void)
 {
-	irqfd_cleanup_wq = alloc_workqueue("privcmd-irqfd-cleanup", 0, 0);
+	irqfd_cleanup_wq = alloc_workqueue("privcmd-irqfd-cleanup", WQ_PERCPU,
+					   0);
 	if (!irqfd_cleanup_wq)
 		return -ENOMEM;
 
-- 
2.51.1


