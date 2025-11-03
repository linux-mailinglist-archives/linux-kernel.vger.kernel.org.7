Return-Path: <linux-kernel+bounces-883291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED94BC2D204
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36234460EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD643314D39;
	Mon,  3 Nov 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cGFfZWQ8"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D5314B66
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185488; cv=none; b=BiAjhJQHx0Ho9F9o+APYeededxT2zfA5G1w+asYlDVm0zO1QH+Zxj42DB+vKGX1EKfCTIqGQYLEw0R6PQnFYucWc7QDbJR2ggotlT845+9tmm/4WDu+Z/7DqiQbzEHsHF8evtsY5mTr4LFsCL4ZZEVKHYSlajjn8eTrkaJyzscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185488; c=relaxed/simple;
	bh=tOALJk/sxr0gJMzpygW0hl1NK/tPdqZbnnOpmHK6Ukw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWhc3o3nTZrLnnIrpnhr8Vfr4WnN2BtbeNc5az17pX4T3Nakcr4/EA5to+tNXTp6Ojy7Ep3ckh/AMfcXYRBPOlUSRfbgGtc56N4OET8ngxSk+PdREBElQxjEMNjFArDE2fMw3VeMY4EEcwg96DXz6BejdB7P7QY+/4QyBgY5C9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cGFfZWQ8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so41162815e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762185483; x=1762790283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSjslf49+4C1KeXizurd3u1HRFo6JeAJTXRM556HvGI=;
        b=cGFfZWQ88roFwE7f1hU1FatTNHnMfhGSF+Xe+Y1danrnxVpzISUo0KFYWSDw9OR9id
         V4wGHJL3r3UtjlP7f/am+5ahJZV7asMg0k6++WgolpwKLd2swb/5JUh2hbnnhcpk+3+C
         eSpTMzp2G6lJQl7uU/jlPNlMqjPc0+GHD2AJHTPhsYBhqpk/ARitr4tX1SerrnQl9kbU
         5YoP4IxZhcfEdH6Lv2KJLe/vVJQckKbpJjoQdcXyBbJgqfyyDudBckqxQGtioNcbvfGs
         K6KDMiz774CvnYGv6IV/4TU/g0rAKPGTEP6dBOIW8PDErqJL9rKUpJZ7uIXKlTjVL24b
         jP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185483; x=1762790283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSjslf49+4C1KeXizurd3u1HRFo6JeAJTXRM556HvGI=;
        b=u9yt3JECDz3TiZxBC/YmRGWjyH36MujrmBf0Tsk9tNYMTO/LmuK7hY/Ob0lMZHseoJ
         hFIggWtkuj8uCtZuQSjjYzrfNB9dBNIyukJUXk6WelKZXd3O2F/6xobCITIs6qYSfkBl
         QY+WEGMBAx9DPr3B0Wc0jFaLlnMRtwxyQebwJ8BR1NpNoMhZsD5hmsT0hu1aBAi3TUNi
         gOGkddaSR2Gs1CpB4/bb9hMPbaVKqXbLDEeRkQ789UiQEH4J2ZEpJDX5HUKwvtDh0FOA
         d2iHgnKQJMsKA85ya+Q+bJcpZXm4dMqswgp/U30KJ9rzQ7rwhDYtzuWJdsapAgUHZihy
         erUA==
X-Gm-Message-State: AOJu0Yw4XWwvN9dIHmqpbmTmwG/Qqs6+kidLNY6Qd87nrTIW/nAsBp7g
	aQkr0zRfZqK/XBt812nmkXr1cWpw6yyLJTk3Elm9j2tUpYg2Ug4g6/PJN5IsvL7n54bHecT5hOq
	Whgh4
X-Gm-Gg: ASbGnctVWAGvrtreuaM01Gx7hNj/O/nYB+cLcKSykBu6MAqmv37GdQlN7KAfXKcFgWn
	2JX0mMhQju76PWbwJClJafaZD4SkJsuL4rMXBF0aSPsWkZgUBWXpWpSvR2SbvEJNPDPxeXqclPc
	JVUHBfx7cFVWjod4Np2gvcZSU/F17AgXSUkQL/EnJoV9mhiFon5boCGX3Qpv+4yXDj0bLI6qxds
	UR0sI/EFWPJus0YjXsPD/5r4nUyoqiaspB84rVnUsl6C7f6yDqUUGPJeXSdO8Q1v6FjrDaByJ48
	CQXMxipjuqYV4DktmK3mY+ueyFj8qVvjnY+JCc9BGnpx2GuhS+9+Oh62T59bDGpH9hhuabb1kbc
	2h3Q8TlvKxhA4JnqyxsQ4b10qxfhloAQkrQy2Ff1QEzNLosTqrNsAFAqpjcFhzD7gCem3IjA+Nu
	x5+yihmZYidPLAcHD7EMvVesFkycvSzNKZhvc=
X-Google-Smtp-Source: AGHT+IEBOwqlZ6rp5xc4yApoAq4SvaoICYZIEJ//QiOLN7wf/ONd9RM56bwB3wHPfebuEpSn8JNvnA==
X-Received: by 2002:a05:600c:b85:b0:471:9da:5252 with SMTP id 5b1f17b1804b1-477308900e0mr115180965e9.29.1762185483424;
        Mon, 03 Nov 2025 07:58:03 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47754adcd08sm48245e9.5.2025.11.03.07.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:58:03 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian Konig <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philip Yang <yangp@amd.com>
Subject: [PATCH v2 4/4] drm/radeon: add WQ_PERCPU to alloc_workqueue users
Date: Mon,  3 Nov 2025 16:57:40 +0100
Message-ID: <20251103155740.250398-5-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103155740.250398-1-marco.crivellari@suse.com>
References: <20251103155740.250398-1-marco.crivellari@suse.com>
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

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

The above change introduced in the Workqueue API has been introduced by:

commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/radeon/radeon_display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 351b9dfcdad8..3c8aa5274c51 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -687,7 +687,8 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	if (radeon_crtc == NULL)
 		return;
 
-	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc",
+						  WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!radeon_crtc->flip_queue) {
 		kfree(radeon_crtc);
 		return;
-- 
2.51.1


