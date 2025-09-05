Return-Path: <linux-kernel+bounces-802448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E562AB4527B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D11BA04CF7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AB82FFDE6;
	Fri,  5 Sep 2025 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QywHnIH2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267321CFF7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063018; cv=none; b=AbcTGeSH839W/bIxCgKwKwFWKAvpPnJn6dbKSJzA+hHMoKkd7IgYTJQfHCO97maxudB5LhxibKX+e+nK4UHH3I9GGcAchY1Gdj+ADnz+r3G/X3vVxpWqBFFXveep3E+tM/34tjTZRzcRF/OL1pRukSvPLhHlnKekpFGqj/Mlvjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063018; c=relaxed/simple;
	bh=hubxZK1Re0hKriQTvqR0pgIo1HO8CGINxFx3+0HhB98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1jnmxx9YOFwp63YEFqUPtNKDj7sj0jcGc7KQxF9yBm+0nA0NeB+j7F7XyULrn+wwr9GOuVUzs/maddyLOUg3CYDGi5iUESRkI+DirCMu2Kswxw/WAjmQK20YWVvHEYPomSoXx2mE0rrFR4xclt5uv/gyUTtzgludU8OCWLed7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QywHnIH2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so4124205e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063014; x=1757667814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9Rqa4pGBGQ+nqaKUkB0WbuJqc5AZJEg5FxwGqJqHQw=;
        b=QywHnIH2wcLNQai+NtE15R3q+KhKpFS7EadWZerrN9GCDjcstd7crBs9w8QItCEVGo
         Ae/FIEKmLL62kTJEWWun2QP/+qe5jY+7W09qMRJ8ykraCi+wse6oAVVjv82rLgl3DzBO
         ZldWMVG6XhUuaqM0aQXBk4pUv8D//rN86162cUALt+H9eGprBliJdeG85XXNDLAfMBSM
         OvMaQ7SBc9MOlBGwRUw10RH8+jl1ZvOuP8eTVB9yURADvstS08hw5igXc5qfTX+0SGzS
         GdyZjB5VCtOqyrbJOYZN+1KB0E63ItaI3xcFrvRO5eApE8HvIU+OrGPJXa7o2ZzK/2VP
         /uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063014; x=1757667814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9Rqa4pGBGQ+nqaKUkB0WbuJqc5AZJEg5FxwGqJqHQw=;
        b=FLmcsVllHB9eGm/4QBBZOlLX5qAdmRlWKQnGi3uKmfm/wm62PyukiVtvhi5ZmetpWU
         7vgbTwttYvMcsiCsOFuYnzX20hl+WA4fm52iJvsVDk3Omftlpdkic+wDytsUPE4ulGuI
         5M+bxkgH0RLX0uHsfoOk1OpOclMu2J2ak3uxN765nWGa9KO9vhbM9c4Kjk6hxcubJJZh
         UbY8GH0H3elWVSeL2zwVmV2dlOKQJb4M3W0kXXH4eWEzsku8OPhxLtB9ncbonxZ7lUTM
         daOAWB/8yZXS2BO3OlUXMP8ojMsxE5JtiUhF3Ha6w8/Nfr5LkZk7XZp8qj/AIs9qxJ5T
         lAJg==
X-Gm-Message-State: AOJu0YxEV51hS4c/VspDtLPBI38wjOJSY5XilIqAADICSmBe7ZfW3feq
	Yt6+DMdgprZWIuEBu90PD1xD54OWwCWJxAH6wkergZpZl/aHYQHp0tlhCDoHE0skj4k0WRvBNpP
	eUafj
X-Gm-Gg: ASbGncuAMmwYQZnZB+65V0Jtm2zF8y9tHrWqlSs3AhUTUMZygxK9WWa9LntjsQrU9RI
	gSKqgQkR5FBmNnhJ1qaqZ2ilf6YO6nJUsXmW43scQCQV7ypLbcb8psVPVgg5PGBbYt2N4ozKYCp
	HoB7KQ4ZmVdwwS5A38OP3t3KtXQ4X2K0/2PR6/csXEKAFX33csnrH2kdo6vWfMCJBmGuuBYCrm5
	X0m7KtRZb4hbxg/A58Wwj05ID9ms18soVekHlIkLH9HuDBitWylF7rI4Xbdr1cN3d8oReRGXKsC
	MhAc3XlgtNwbWnGjoQH8FjWAa40CaVaD4kE7PRp3VlQfQHFlBhEEyfmdMzMZ9tCeDMn4ry3uT/G
	jZmIwDQCCZqTMhu2RS5oUG2+XlD82bS3wK8sQRG9FXEV/9DY=
X-Google-Smtp-Source: AGHT+IF5IWr97S5oTh0sTJHYmRd+RWZpF54xEoPhZVRBSB+xqmyXwnaCsRNO69Q1AcCVvKZ1nQuUdg==
X-Received: by 2002:a7b:cb41:0:b0:45d:d295:fddc with SMTP id 5b1f17b1804b1-45dd5b2282amr15894545e9.4.1757063014017;
        Fri, 05 Sep 2025 02:03:34 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf3458a67fsm3614543f8f.62.2025.09.05.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:03:33 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] mm: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:03:22 +0200
Message-ID: <20250905090323.103401-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090323.103401-1-marco.crivellari@suse.com>
References: <20250905090323.103401-1-marco.crivellari@suse.com>
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
CPU affinity constraint, which is very often not required by users.
Make it clear by adding a system_percpu_wq to all the mm subsystem.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 mm/backing-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e9f9fdcfe052..7e672424f928 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -966,7 +966,7 @@ static int __init cgwb_init(void)
 {
 	/*
 	 * There can be many concurrent release work items overwhelming
-	 * system_wq.  Put them in a separate wq and limit concurrency.
+	 * system_percpu_wq.  Put them in a separate wq and limit concurrency.
 	 * There's no point in executing many of these in parallel.
 	 */
 	cgwb_release_wq = alloc_workqueue("cgwb_release", 0, 1);
-- 
2.51.0


