Return-Path: <linux-kernel+bounces-802457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB472B4528B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663461C86168
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B590830DD27;
	Fri,  5 Sep 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PMmQcKUz"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DAA30CD81
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063147; cv=none; b=aHFiApm01SS2hANlLDjEw8PgudKduKCyeMd4koBhKru5dJoQK+MZBd6RNyAz4p6CQ1BYo+L1r9Vd8BQypymRZrrUl2uxx88O4xCXZLxI7pFZK9W7J/KU0xl8t+EuUBklEFZpaMobEWZa+Mx7982IvG3YipFSoSQVrpG4yhzqWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063147; c=relaxed/simple;
	bh=a+YHoyzddr3M1lvAms3gbc1KC3x6fhSXZ1nfCpdsqqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbQ9P8ZNO5bLCVCVSl6ETbpLmVJzvdbePzGZXYn++CjMXcze8q9Wh2MOZVgFZZV3pupSeWND0JY4uPFFTinkl3Ge1jTtQxGSXnlSrr1V15+LU3g3T3YfKDUtbhe6s25gE2enfqIvyC1/JC6fBrq1y3BqHpyK0uipRZyghAI6/4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PMmQcKUz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b87bc67a4so13591455e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063143; x=1757667943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlPw8c1buu+XznL6AI4WMMxODpf5JODmGNHWscy7PUg=;
        b=PMmQcKUzgQLwMtQ51A6AO1nwdHIE0oEh0kb0qN9+n6Pjb9xbP+o0k9jBvzZnVdeGVW
         bg72UJxYny2vBzAVaFhAWTTDxfacBd4PyzYZ5TldCrnJghg2qwXFpp+GAdltGsvNYrE5
         i5oacevqhuN4oivPpswP7PmLLRfl7G+S9twGMsLtD2Cqlwem/slStiaolXakLpoXEpcw
         yP7J6frxVdFUATq/9/9TrKq+LI2d3PsrF6+WvCUvZx6KH5i6GvowAHb/tdMO1b/PRd7k
         QT8gycR4kyNQDGSB5bOSyd3zWjuiSRC7zFkxgO0k/AKMxkA2oXzFnAdt+CIJ2vxmV6jK
         BFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063143; x=1757667943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlPw8c1buu+XznL6AI4WMMxODpf5JODmGNHWscy7PUg=;
        b=eM4VOuWh5dogi6+ibQaKAs8gE2NvYP7oECRHipaFF2LyzxvOzMbDzoYAXqk7nW4Wd5
         qi28eix6fBgrHujy/c+MO+BRf3ymE+ODe4OwKVbkKcImt244w/buTtaN6hTeVLk6y2mW
         3EostcHu+XIW3nfTVNucZCOIj95QtuKkB6uhEroiQWGbfCvTW32B3MstfHXMdRUHEBsL
         SUSbHNo/J4EB+irQrOMhj/xmsiVk0chZBm1NTr4eZCdR7VQsHyaSVGIua8Z+USaL/mbO
         YIEwwMTBLhkkTQlvAB2h3fjie8+lTAmqx3pVCzC+YfSf3sg/XPgRjPzFbnmugsVAFNvx
         yeEQ==
X-Gm-Message-State: AOJu0YyBZ/AFt82ANnfoxCmnjkCQUK1wgV/uJvU/ieGPiDFYjIx4rruY
	1M5UtBWtwAtUojw6wLpRY8EFUIBxuQwtMKzidJt+6nP5i8xlgtk/69y1ki0FllTK7Twylw7dxsQ
	+EyW5
X-Gm-Gg: ASbGnctZX3D/ohXjgT4DuwjjfjOk/1hAVkT+Tp/noyzRRMEHb/VNuXLG84KTMqF5kYQ
	lWff8fGfto4hLVR/Jp9xagRDLDWhu8Da0wrzA1NbXwpQVd89erJDoN9p8yWNTyn5ygxTQUGgBOd
	lVXmZBa6rpExTNXVQoExeHQ+EM58+d1/lzmvui0Qwx8Wzw2pMUXOcdRoyJJgjKchnkUdIz5v/6E
	MPDL5hoaMW88PS1LgL/2PuxodZlGL6PpKn3s3nBrPTfmE4LTYydUhxhMHFHrhLwOPOn4Zg7EcDX
	5Mk/vrrDX0x6gyoGvx2CI6xIyLUWsRoME5Pk7qOSF8w4XWZJ27+vY5OPG24zBfGKjH6jDHdgRyD
	mwOAVzryl5oQrLl8mVCyCSvqjeBNOB2ONdRpOroeFtZqgHr0=
X-Google-Smtp-Source: AGHT+IEqV2GwVMhOug5G3Y/HEmwqQ316oxFT9HdjaGn5/clCwNV5gMznP1aXnQzt3IWA8XOj0hQm0w==
X-Received: by 2002:a05:600c:46c3:b0:458:c059:7db1 with SMTP id 5b1f17b1804b1-45b8557f254mr213463215e9.30.1757063143134;
        Fri, 05 Sep 2025 02:05:43 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd0350e80sm68794625e9.22.2025.09.05.02.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:05:42 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH 1/2] padata: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 11:05:32 +0200
Message-ID: <20250905090533.105303-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090533.105303-1-marco.crivellari@suse.com>
References: <20250905090533.105303-1-marco.crivellari@suse.com>
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
 kernel/padata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index b3d4eacc4f5d..76b39fc8b326 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -551,9 +551,9 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
 			do {
 				nid = next_node_in(old_node, node_states[N_CPU]);
 			} while (!atomic_try_cmpxchg(&last_used_nid, &old_node, nid));
-			queue_work_node(nid, system_unbound_wq, &pw->pw_work);
+			queue_work_node(nid, system_dfl_wq, &pw->pw_work);
 		} else {
-			queue_work(system_unbound_wq, &pw->pw_work);
+			queue_work(system_dfl_wq, &pw->pw_work);
 		}
 
 	/* Use the current thread, which saves starting a workqueue worker. */
-- 
2.51.0


