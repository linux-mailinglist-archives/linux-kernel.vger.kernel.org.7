Return-Path: <linux-kernel+bounces-888715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D95C3BBB2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9401AA8617
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F8A34D90B;
	Thu,  6 Nov 2025 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C8/g835m"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B423446AF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438814; cv=none; b=rFdnfpHBaYWmgF9bTP707sgg4txtHFmjZWiJlaK8sc91s4Hvia4E8E74y0bnZaLvva57Iz4wlNYy0baS0C+bf5XKhhM73E7mZvYzgjq2HiK91KMwQWMkqBpuf+MbfbzvZePAlk2xB+5Odz+WR6osHsvbalGu3OGVhUO7MZrxHg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438814; c=relaxed/simple;
	bh=8NtqKplCTfthbw1sz5U+vy8cTC2ogSC3rGwhwWFmRQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnvmuqkgZO8FhYDapBamGWSA0gX/pTfZpabU0CzLJNcyjwT5DOV80I4VMYxHN/xx2EWNPENVsBDPfLKZMqTpf0AEwbHJyQ5SyUxpGLfEdni/xooWehP6SArmkVTlrFmsM/cDANVMp2l1eOy6JL49jtN/5JokILuhTlwCNJe8hIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C8/g835m; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4710683a644so7429345e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762438811; x=1763043611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TBiyXlV6SP766DuHM6j5JQotvSVYeIR5ytAqVLqwpw=;
        b=C8/g835mP4RC0PgZ+b6KETu9P7Mh0hIfJ9QrF8oXJZ4t5uKJ4sZK3mtSreEblixSLu
         EIuaGa+QLQ7KK7AMs2hbb/o1koNQRvoIDxgMUEIcVZ8s4Z1w4UbBy3K0oV6MpNW06KcQ
         I7WV9MGJV6f7RlMihn41RtWReHgaOXQkkS3btHG6j8BnS/rpSNgIQYASLFZA3THOjznN
         9qqIa3C5jbShbGB2tuy1NKeDTMHYKQ9zCQIz7paeHMWF+lsy9QV/ZyswXLxA18zAYlER
         CDsO+f60mp41NPg3oYP14nENf3hrCpcc5d1YReTf4cBeKyHLYwz3J81AjxxE9BZcittR
         iCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438811; x=1763043611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2TBiyXlV6SP766DuHM6j5JQotvSVYeIR5ytAqVLqwpw=;
        b=PYMfZnuHSFIaywob2UihT7X7xTDxhECvw2UovDNMrR14lBxD7+GETzq+s65t3PUI4g
         FikuNnqfRfiou4t/prDbb2atW1bowmp8Dai72uaOPY8wQX0Vo0wMQRmJpXF3YLtZXcNG
         oeoVTYEuesWRcVWk4Qfxl3KSk6EFL/7U+OOF01qytUKCnd86zAijOJk4BRME2fBQjn66
         NIzp4r+fugz83JQNvi3VRXbOOPnE1SfEVBTBu9f3d/Kzgfpb625R61TWsXMRN1ekDKxs
         7q0Dk4yH6df3SCG055YU4ELMT/aLlKoXF5RjNrtevMVRaCVvyOz/mWc2p6YxasvGNvsg
         lpSw==
X-Gm-Message-State: AOJu0YyZkibyKTeB1fOxj7eebRX3FzrytmLFbzHk2eTqGejhPMX5dFFe
	X2V6+WCUhOGVvo60vfJpBoTYKsQBhmTdV8RGxD8aX229AZKy/Du/+1vCSAU7IRBhguDysZGftjs
	mZLaM
X-Gm-Gg: ASbGncuxHyuOhmh6nMBVKLOchmL8PPH2lcUFOrJ8aidROXbmFptjg9qbkSeRdIXYsp5
	TI5rSccCcHYONRkr/iD3n3C3uDyNrjEemiaVEXqVaILNti4QyZ6da8aQKymw7Uj6qukRtYwfTKL
	DUYrq/b1ZEvt4lu2DimMK/dMfgjZTCBZQbezxT0C8H8clwi2WWKIZxMoSXQiKisefHYXdVbrZS7
	/8QO/nHWuy1kICK9zOCDrAoQoZfwsUwpJ78CRrY3IlBAC3T85+R9mxrT2lUQXRkOPt+GLak6+Nt
	ht51MGzYrk6VUh0/UjzRcovHg++rAIfVsx02FeRRIhATuw0ndzJRGIt9QQD5lxl7uddLY4GN3wS
	Fc4NlHhQ9KLSzuYTwrbneRMnYoEZg8IewGFFFe0YfrozldhCYP3zmTGIvYlQgF60dA7gyHI4Fc5
	SFVGkYhv2+AdQbA4q6QdK0yhM=
X-Google-Smtp-Source: AGHT+IEkUdUSnfE11zagsJf8KjzZv5gAOKwiUUPQtcQqvGlegNskiK6BvaOrq9+/jCOzm/1zxdPqiQ==
X-Received: by 2002:a05:600c:4e86:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-47762049f4emr29994945e9.10.1762438810682;
        Thu, 06 Nov 2025 06:20:10 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49be96sm5255531f8f.35.2025.11.06.06.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:20:10 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 4/4] Input: psmouse-smbus - add WQ_UNBOUND to alloc_workqueue user
Date: Thu,  6 Nov 2025 15:19:55 +0100
Message-ID: <20251106141955.218911-5-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106141955.218911-1-marco.crivellari@suse.com>
References: <20251106141955.218911-1-marco.crivellari@suse.com>
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

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This specific workload do not benefit from a per-cpu workqueue, so use
WQ_UNBOUND on the custom workqueue instead.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/input/mouse/psmouse-smbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
index 93420f07b7d0..15bd49ccad22 100644
--- a/drivers/input/mouse/psmouse-smbus.c
+++ b/drivers/input/mouse/psmouse-smbus.c
@@ -299,7 +299,7 @@ int __init psmouse_smbus_module_init(void)
 {
 	int error;
 
-	psmouse_smbus_wq = alloc_workqueue("psmouse-smbus", 0, 0);
+	psmouse_smbus_wq = alloc_workqueue("psmouse-smbus", WQ_UNBOUND, 0);
 	if (!psmouse_smbus_wq)
 		return -ENOMEM;
 
-- 
2.51.1


