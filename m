Return-Path: <linux-kernel+bounces-800199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFE7B43478
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5E91C809A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEE82BEFF9;
	Thu,  4 Sep 2025 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CKMsiHMO"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D491F4168
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971944; cv=none; b=ebtStZkxoMaVkO58us/FyqBk7ORfa2ZrhI+mXej2hZyq/hhW+b4p1OPqqfVtDFs7NUCxB8DuXU9AbR+cGp1vT/2JH6qQoDVdBsnGNIq+grR7Oogo+uTwml629PMMRyP1+Bo/zRIaVHA6q3GlF/HergAl7eBrFfLa+4oEwbxke4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971944; c=relaxed/simple;
	bh=mwVo5BvCGfBrvtywIF3km/HSbNwqZiXe2Hw6huMBRVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LetEmo9bGoco56ppDu8oFSLY2gblPbvNgUiw1UcgYC5eML6EE39mTKpDC+JL5vvJLJNE3CWzEnhVMG2feunYCo4UKlVSDguId9RItPpJ+xAjfANwc915QcHFAY1QbJzqYMewCzw6RFbKZK+uJ4dQUpnc7aW/ubQPA/tW7FQHUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CKMsiHMO; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso420946a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756971942; x=1757576742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwSifmMVhfrKYyAfWULyU3wfJ1S9Le3WIslBvHhnZRY=;
        b=CKMsiHMOjz7+Yfo7ec4H7W8wdZPosztZNIv3XB2yCNgi7/2ytik+qt3rJfwCZS36/x
         SsiQylzvfeW7d45f5uPoDrQPHH1SC80j+Zi0xhQWrIb5hrIpjqHO3YP5DjwLTLnNSDuq
         thPSUAjtl1LewbYVvA6YB/OSSH9jJr2/lvgKyxaHIoPdtdpo/7AAxBCIS1r982BUs9sJ
         iPDHnbnaC0Lm7T99uSyI/UEixMUI+gi2idEG9Ir+D3NVucAW6mair76aowSjVw4QNlvJ
         ElvgouD2qYNEEE2B94XqQCDZxQbI6cLtzaLPnxY05mIbmnEU2AL9hTKwOKKa13jTGLzw
         tQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756971942; x=1757576742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwSifmMVhfrKYyAfWULyU3wfJ1S9Le3WIslBvHhnZRY=;
        b=VOcZu9jGodffiy/xB59v5DjB0Z0amQt/5gCpFG3jtUFlF6rPtqEwLGibRwjkou1E7r
         Icpbbo7HMem6N7o7uoZTwafqoOqG1W2f2tWRPFGgQwg+KRJX/rc/g2y9BsQVa8fMacqt
         bGIGb8uqDRttVHkdWUhvqyXj8YU02j2d5DPe2vyzfihEnXyuEEOgsAytGjyXRIPwYAmB
         7lUOs0lIjIF/gpdsRhbXPdtZZC0pYRmruwSd3kspT0b6iTE9Rjrup9BmmnD3ADOSHUOu
         ei7lwkDJtxP8EtXa13ghk9P8oeLhfA6Xha6Zqu0u0O8wkxSdBVSUsDMhTX1oiw9N6vKq
         wnvg==
X-Gm-Message-State: AOJu0YyzvSq4JOnUsP1GC5ATsLIuB0MgtyTmJ0pppXLMBNORhqjzUJO5
	50pybgsxEVxA1M7aljx3Mr+LgQwTQJgwKobeHLnGJqC6bRKyOxKt1RJ8DB7T6gIHCW8=
X-Gm-Gg: ASbGncv6ar7Lh4CXD3yPfJol8R288hPPdZnKK8Qy4C0a7vs/D6kIO18Keq5aPlKo4eg
	uInUHHjMxQSNZlujdPPPKvYnzfnT5YMw+LI+qJtslwDAkHLrMtP24JhSITUj6Vjg5QRZkPd5YnP
	fg3XJ75C5OxGLC2Dkjj/b8Q3rH9WBBwZfxpycajdYFqRZXgLgRRrzWVayr/F2w7GmIA+67SHKCW
	9ed3f0eO4iPd2vin4wcx8r6jl407XRpm24BaJ1MnvTxQ9mQVDUVPiQMfEq+NEO7v1PWlLy/UwoC
	p2HPSX9u3d0bf9Y1w4tlEDiI+oRsrwtAw6TDGKCAWadoSyyqdaIb8J6Wx58qNg8QWnS5IqQ0ocv
	8KokmKEL+vjjdV+k+8VHRjWkzYm0rxrrXWQrjIPX6QpZmdkc=
X-Google-Smtp-Source: AGHT+IFX4EjymSq0f8f1JxLjejSSfBxljLJBopRSZmFliuv880srE/4QP2txO60+lbu/wT5uhlsYEA==
X-Received: by 2002:a17:902:f549:b0:24b:e55:34b with SMTP id d9443c01a7336-24b0e550987mr145495995ad.31.1756971942481;
        Thu, 04 Sep 2025 00:45:42 -0700 (PDT)
Received: from n37-019-243.byted.org ([115.190.40.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f7492d8sm63504395ad.129.2025.09.04.00.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:45:42 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	longman@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH 3/3] cgroup: Remove unused cgroup_subsys::post_attach
Date: Thu,  4 Sep 2025 15:45:05 +0800
Message-Id: <20250904074505.1722678-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
References: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cgroup_subsys::post_attach callback was introduced in commit 5cf1cacb49ae
("cgroup, cpuset: replace cpuset_post_attach_flush() with
cgroup_subsys->post_attach callback") and only cpuset would use this
callback to wait for the mm migration to complete at the end of
__cgroup_procs_write(). Since the previous patch defer the flush operation
until returning to userspace, no one use this callback now. Remove this
callback from cgroup_subsys.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/linux/cgroup-defs.h | 1 -
 kernel/cgroup/cgroup.c      | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 6b93a64115fe9..432abdfdb2593 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -746,7 +746,6 @@ struct cgroup_subsys {
 	int (*can_attach)(struct cgroup_taskset *tset);
 	void (*cancel_attach)(struct cgroup_taskset *tset);
 	void (*attach)(struct cgroup_taskset *tset);
-	void (*post_attach)(void);
 	int (*can_fork)(struct task_struct *task,
 			struct css_set *cset);
 	void (*cancel_fork)(struct task_struct *task, struct css_set *cset);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb7..75819bb2f1148 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3033,10 +3033,6 @@ void cgroup_procs_write_finish(struct task_struct *task, bool threadgroup_locked
 	put_task_struct(task);
 
 	cgroup_attach_unlock(threadgroup_locked);
-
-	for_each_subsys(ss, ssid)
-		if (ss->post_attach)
-			ss->post_attach();
 }
 
 static void cgroup_print_ss_mask(struct seq_file *seq, u16 ss_mask)
-- 
2.20.1


