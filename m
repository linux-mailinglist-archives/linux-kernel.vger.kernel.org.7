Return-Path: <linux-kernel+bounces-890723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 297EDC40C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87BE8350582
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6789427B4E1;
	Fri,  7 Nov 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ObsTWnMh"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683A2EBDF0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531608; cv=none; b=tNH9/XvmnCHCGPu0UO3Sbfbnz8efWT0bg6QMj+JQ+1n8To82FModR5+ax1MxGO2bv+/ThYXUp/m2cc8pi3HmPjvn1N3PC9ijYLuGS3UPGdCVTBN1f4v4/7FqnW/K8Nb8QtoXo38ZDd/WjNvl/UNuKh+y1DQzjBx6yaFX+5qqG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531608; c=relaxed/simple;
	bh=x+DtsaG2ezqoDl/ORtbXySV+scQOmtyaY6mAN0fIaKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0OOscMLI/FZesd0N41paEGQNUR+hm163T14OmkG1WmQwApClVZ9ov1gqOqRibZQ73iGbq/293gC/lW4M72sRfbgXy0A02IttXGV/V0c1lDaqCimR9HCRH6n+5joCtbwuBIhE6xNjQvcm5qMMJFOOC+6wE2BIHTdR32zr7bo18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ObsTWnMh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563bcaacso6868995e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762531605; x=1763136405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTxtPdqIOjBiNh+kEG3rzU/aqVNTJwEsRfpt2o7gfCw=;
        b=ObsTWnMhbFljlSK/LSsUD/LGLOx9bXTQkIIwsOXBEVxt8bFVXxgImWR8Fbg/+wWQ8x
         wL/egwSndDHqC4apcMypcKCBiKGg7i1bjkZA1jGjw1TdqWIosPWyHyrJn4lHBLWIaeeY
         qiJuXihN8p9KBQW+s4XdSQe0XODLqIIeIcLOW0TEJTzC/1ZWEVnaAcpP/Pfa41yH19PG
         15a4c9iFBnshqW3XajIbXU+EXmuDAQ/+j/TxzNSZmditasf9mCjW7LqBqgHFMCPkTmth
         WzGBkojHNlmbBQAw3jc35rwDgqFEYDMr34BepRxNNRPyCps4tFxm6v/V729WCR6c8T1z
         RwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531605; x=1763136405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTxtPdqIOjBiNh+kEG3rzU/aqVNTJwEsRfpt2o7gfCw=;
        b=mFYRxheOEK4aUkTN6YOr9pI1lLzn5HoKKKBDgndXXvfX7Wrfj3Lp+eO8Av/3mNI8Jt
         HX7ShtdNGM8wKYn0fo88cZMOCKI0/m7aQWPHIT8HoIrspBwnaVLWUwY1dAEsHTbE68z3
         JCOM7Pzhw0TEDDpzBM0gOqGxo6TwdesrDs5VFz2aTZfQ689YRCUiihBs1tdoFdzv5/2Q
         t3sM0h11hJ2RJxpv61fsvTa9gyfGHF+BiQfTIZU2VlRzNwfW4BhqObFE7RTBTdc4Ie1P
         QHQlTWCXPTKDbaL5QvgFMp0ZMY9D4SJKvjnNq75iPP/Z+RTWmaQjT7i5eMqaf8/YGW89
         BX4g==
X-Gm-Message-State: AOJu0Yywl6zwlvuEP+yVnpToj68H2l9lGfVzZTQAb7i7YDCq5yjAT5CL
	EVIbila0klkWKZ+0nwzV+lSrBYOWUHpN/wggyyfOwB4E+w3KwLMFkWuFGJiQuLUQbyc5MfjgehN
	tZFDx
X-Gm-Gg: ASbGnct9YLsNq3a92cT5HrnA8jmiOLeedCVUqBl5vCaDvY04APoifS6I8flNtZbYBhL
	mYpEGCzlPnJYhn5sITDLFMuzJDnHjIKnHOgCSww3WxbjUC9+/7OQPk/JC8nTcw/3CwAtfYMGZS8
	14nIrhZOAMpx2hJ/Sc4UHDMjk54z0Ifb0uUZxPuPnRlH6CLvntI6d4C7XgvmlajLV2OhqzQyPxu
	Fc9d9iafuZqQQD0qoaSt2ldsI1p1G8cwSNAyiHwsQ+ahgMi9UArcnLYqcoorQa80It/xVY+iULu
	jL7+90MHkPDRA4s9w3Ab3CgTHpEbUQI/zONbfPBICQdZqS3ZCtOtIRmbg+LlIkTk9w6cIiUibRP
	LJNBimTYPjUrVmVN+fCCLj3qU5K9XWnjC1sXMxekJH64/oVpFGBjMds7aC2EwWxGlpY/mtTiiNR
	2Y3aQcuzkIItOPmlAlhzKtXKcf
X-Google-Smtp-Source: AGHT+IFfXUvhPLWq4Eyb06gTcQTq+I9z6kEY/JaKmybYS7EC8EOMXMErbaOfsvG/lbNJzy0KavXZ9w==
X-Received: by 2002:a05:600c:190b:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-4776bcba096mr29153135e9.22.1762531604800;
        Fri, 07 Nov 2025 08:06:44 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce329afsm168311405e9.16.2025.11.07.08.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:06:44 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2] umh: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  7 Nov 2025 17:06:38 +0100
Message-ID: <20251107160638.328955-1-marco.crivellari@suse.com>
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

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Switch to using system_dfl_wq because system_unbound_wq is going away as
part of a workqueue restructuring.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
Changes in v2:
- improved commit log
- rebased on v6.18-rc4
---
 kernel/umh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index b4da45a3a7cf..cda899327952 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -430,7 +430,7 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	sub_info->complete = (wait == UMH_NO_WAIT) ? NULL : &done;
 	sub_info->wait = wait;
 
-	queue_work(system_unbound_wq, &sub_info->work);
+	queue_work(system_dfl_wq, &sub_info->work);
 	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
 		goto unlock;
 
-- 
2.51.1


