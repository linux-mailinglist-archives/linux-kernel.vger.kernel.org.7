Return-Path: <linux-kernel+bounces-802414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A35B4522E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF786188DD18
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1898F304971;
	Fri,  5 Sep 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M/0j53tF"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6BE28000F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062523; cv=none; b=T8iz7wJqZeKh36LBeSPozcG1IEhDLICLx57Tq/qMhgHJCqEHhYTOnE6TArdc8bfnWmQGTtpQ8fpJB0MuQbIr0EUuXbIBZB250CY62c3s6sQRt4scv2OsmaW4Ws5VU4ESrc6Er1BM9rJ51l6PLYi7yFKncR8o2ScKf+WkMv/DlP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062523; c=relaxed/simple;
	bh=rPqk/i8FHiso17+h8HR95Fljzg9ubNSYBKvqESikwFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6S3Qm3ereVWf1RsbWdcZtIXQylp1rbr95GvTW0JtyQUzMoSYUfGkg5ANKFz00roArdKYsMGddwTAIlHYnjimJr8EAcAuxg4JrRGUc8/y/vswe5MOLNyrQnEqMXgXjei63xKPkOCc9Ox9sYJBcXJtdvAhTmmMxjmS+faUtoqzTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M/0j53tF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dda7d87faso1799495e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062518; x=1757667318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAGsQ/32s/KKYkZau8Rby6xoFYH4N+/s1hCU9vRuvK8=;
        b=M/0j53tF/wAPQ7/tLbaOR8uKHqPRRnpGXcmgg8wiOT3BrO++pDCR0ZW5Yujlt3JFMb
         E0StLcNHgxYol00GNOAQIjBKEyFah2rMs4usckGCya87qHhR4DnKYID0KpPo1sTN6lkB
         bSRF1CjjW+qBeelfXySXMGjybezase9/H+w4j+JtIElR93L7nqZVoXLKpURsu9vlxu8j
         wXKZ8FjN8/6kNjTDzB9isn6P0SEfXnrtQMDtO1kw8nhVxKQKEW9x9JsIxNKfOAOSdo3r
         VFlEccQ5zqWkwk0HlPyuQpS7qNGIT3II4oHU3nJ4PTQ2Ofs5WN2KBjlvRjmcq2KFltD7
         0JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062518; x=1757667318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAGsQ/32s/KKYkZau8Rby6xoFYH4N+/s1hCU9vRuvK8=;
        b=PxnDyeVkUUS8DQFK1yEMkRb98Cjwh4VGRuMLHkz7ff0SpiP+tT/2JacLVedCWCyctF
         5+QVikpR36+Zd32ogNyD5ZSozMZy8JL57pIAxmOuF9wJRbbUSqdhSZmLl0+Y5avzHCrK
         fUaa8Vjo+VHREURKgVHeLhMvCeRzFiXl1Si8TWTzw149GS/rgBYcUA+/U1o/ptNYMaoe
         jGSMWfDnejlt1RlJ44crY6Av4lkjD/Vw2mOlp7Ead5k0JTHKPIwCtd1QUYsNTOKadFBN
         Ancbpe/lGgecOVaUNyTfSB4hdboI+iCzIqE8bb5S9v+zWpVpe+LPEfDw1dq0Ni3mGwJ1
         D6NA==
X-Gm-Message-State: AOJu0Yz8NhsBHaFjZFPpcgRqVYCogTlRwFNRsowM5s7to8F6/SvCmpld
	qTaPJqvPpza/I3KKrRjU3v8DuE6sLZWMkNuKKP1nFX0gouD2WZpjVGpRs0B4gqL+P3dAoww/aoS
	Rb2Vz
X-Gm-Gg: ASbGncv37yYg8ZRF2wxhX19ZQ5QzcNwHGN6E1r/J/vQTYBASGagedrC2Gx4FrymKR2x
	Eem8JtjjcwSCMRJEEbvNflA/sCocL9ualOS4GoLKtH/hzN8AXY8vqGJHFApsmGOVZsqv8T9Ltyj
	gNf2iOaGLqyphJxQ+ukggALgPHteMvffvRBCKsQuSDJWzJHQGSCGoXPSTR58fwRbdTSP7g1eh/k
	ybtvzzrlkEunyDrFCU2ax/ZKE60llKPZeAZ2ifA5s0XClmyR9Uh4J/QjEgKBIvFPw7b5oQ49got
	ZzZGEhkKqroy464ym57G+TM7O4zKXR2hGG9g48EC9VlxwTYtnuwLuZXYvdkYzA5dWkcu6Y39hVj
	w8FhIbAQuCSZEAyJks/6IsKEfOSjM3tSV9PGo8AIZQB+V1N3eKiqwubtIOg==
X-Google-Smtp-Source: AGHT+IEIeeWlv5Y1zYgVrT7F52IJeE+DGSxWfwj/+Ab75L8oWqb439G29fc+gz412+/+BrWVo8S3uQ==
X-Received: by 2002:a05:6000:3111:b0:3dd:6101:4efb with SMTP id ffacd0b85a97d-3dd61015026mr8283880f8f.11.1757062518456;
        Fri, 05 Sep 2025 01:55:18 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d21a32dbc5sm28178346f8f.11.2025.09.05.01.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:55:18 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>
Subject: [PATCH 1/2] cgroup: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 10:54:35 +0200
Message-ID: <20250905085436.95863-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085436.95863-1-marco.crivellari@suse.com>
References: <20250905085436.95863-1-marco.crivellari@suse.com>
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
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3caf2cd86e65..1e39355194fd 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -121,7 +121,7 @@ DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
 /*
  * cgroup destruction makes heavy use of work items and there can be a lot
  * of concurrent destructions.  Use a separate workqueue so that cgroup
- * destruction work items don't end up filling up max_active of system_wq
+ * destruction work items don't end up filling up max_active of system_percpu_wq
  * which may lead to deadlock.
  */
 static struct workqueue_struct *cgroup_destroy_wq;
-- 
2.51.0


