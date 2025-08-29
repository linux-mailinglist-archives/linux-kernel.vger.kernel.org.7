Return-Path: <linux-kernel+bounces-791682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4512B3BA19
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481BA3ADBF5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4EC3043CA;
	Fri, 29 Aug 2025 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZq87Ykh"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D42D12E4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467886; cv=none; b=U1aAGkKgZDpYMJKl12Pxla4ZmnxzW5aqXK2WfsAozkM1hnG2Z/Kc6qIJAZ+RS5lNA+WOLUnUpbVI6y2duHe5jeDkRETWFVHNAAJ98bW+oiyxxbVPH/YeVXaeYEbeczoMeqCXnzDdvJtfh756bUMpojYJ2QGeL22CDSFTphtVYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467886; c=relaxed/simple;
	bh=eWdD+y64i88LvocVzHNcRlj3EFHUTHNycTJjSnMmtPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IlhfL0pzg5HSDy5kPG6rqjX2YDa1xGU1i2ilFgCyFCr2p57rE2Z6IwWW9P4B6mdOvmWGEaX9ztMLgl/fUSrhcCRkiq0FB2C7/G6uUezH0cFSu+zBLQg9OWgfM4MQ+El5AKF+tBHYNSUb+YQ6DXnS/3YdTNOzpgCjr9/Mub3tuso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZq87Ykh; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f4345cfd3so2090508e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756467883; x=1757072683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgtia+LpfMpm3WYDNDpUT/QXDK2dR0NCJT/wLTvQl3g=;
        b=RZq87Ykh4LrzLmDN60oHigVQXCn77ovpKUTFWOfPXxfeqcNco1GfI+H9UXNDaOA14N
         a0581FhSHb1t7kVXZzeg7jyfN31bycgN5XjWx97Z4JDd3o4fhFzPd3YsUar43S62ZOPq
         lTSp48CeuPlSUL16C9AbpLiLl64L4Ue3cU4w8J+Gxkm0B1CzFNYpY9M/Q/2ikasEt4m2
         z/bOzKdcSGv7y0v1GrUI3292Iofc5cI8cvSqTNclwVTDAWgI864wu0/NemTq+5nDT9kV
         MycREZvCABTCK6YUq0uVIsllwRYOTsyfs0dvpFpEg2hQ1VOP9T/c9sbLr5Wbs2aQy3SK
         LfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756467883; x=1757072683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgtia+LpfMpm3WYDNDpUT/QXDK2dR0NCJT/wLTvQl3g=;
        b=L7rTYXaiBMXvotcJlCM0pFao8OPdKwMx4FTVNFADjuIbOhI8RGtbwFLoKyrisrsgnw
         /GkXzp6n/q491zkcOWHZusWMeC83A/5cC+sbs9XBnn98jL3olzPk9pgebGRywsiHKmpm
         9BhETiGtUVMs+QvjCp1u6aT3arHQzK+JX6EyXK4a17WmPAdv9zpQtJFo8Fwp9eU4nJcc
         mbwl3g32HC2MfSpg3ZEPSOLYvaRP4ugpIZTNMkZlF3yiuNWG1NfgOzoURPJcTB5sDciz
         D8cAGVOLzyFNa3DNJF5uLM0DpIOt4K+c3SZOj1j+ievHJCubYDgIZ9k6PDIpNyUXNYqx
         Udfw==
X-Gm-Message-State: AOJu0Yz5xvonETCOGr68nbSvGkrhRTOkLqXJlUN8982JtaTFjGo4D5tk
	xBMvxx9uV1A4RrooB0mNJKMc9YVE24AcZydm9EjocyjUK04tzRIVvpKgiqHNsXIn7lI=
X-Gm-Gg: ASbGncssrWa1+VQt4SjUbj9Nu8raahxHiwyGE7e66XS9a9c1mI7l2/f0MwMf9kwJqSK
	8pEYkNg/2DHqWnuAajbu6ZngynGS7ddVeAHmPqWF6dBicBNoprYYcm1xG7nRC09vvi7rnRSaGyt
	CJh3EtQunJZsbzIXGYJp9pGftMhOZe5RFjN2Yb79InRfG1+I8svnCKVEjpnKKlwn8L5YgAIKuT+
	YuB1XgPqdrZCgcjAQxVw6rFWKCGcosa6JEEF8JYx2xLIl6ZgFYNgw38beg0Vn0dtPFP6jfzErxD
	Hh/qFHW1NDm5F8JouBU3zA672H7ZCMX4/3ewT3wBZvE5Vk+AfeuqTfRq6vXaet33xEULI2mCQVe
	amUI+BzmdHk3iMgHrP5FtCECkUKAqZEoj
X-Google-Smtp-Source: AGHT+IHAqQsoVsR6L7a6rcLo6fKDNuhsLtvlWrPRnW+IIIX2gb7KKe3MHpJzSG95OBA3WhmSJVm61g==
X-Received: by 2002:a05:6512:12c4:b0:55b:84d3:12b9 with SMTP id 2adb3069b0e04-55f4f4c6a38mr4346175e87.18.1756467882843;
        Fri, 29 Aug 2025 04:44:42 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f67a4c612sm581162e87.146.2025.08.29.04.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:44:42 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 29 Aug 2025 13:44:40 +0200
Subject: [PATCH 1/2] fork: check charging success before zeroing stack
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-fork-cleanups-for-dynstack-v1-1-3bbaadce1f00@linaro.org>
References: <20250829-fork-cleanups-for-dynstack-v1-0-3bbaadce1f00@linaro.org>
In-Reply-To: <20250829-fork-cleanups-for-dynstack-v1-0-3bbaadce1f00@linaro.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

From: Pasha Tatashin <pasha.tatashin@soleen.com>

No need to do zero cached stack if memcg charge fails, so move the
charging attempt before the memset operation.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Link: https://lore.kernel.org/20240311164638.2015063-6-pasha.tatashin@soleen.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 kernel/fork.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index af673856499dcaa35e135a9e8042ef28d5c5370d..2a5b7a5fa09b1f3a42473cf44a1316ec8b3b31d0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -290,6 +290,11 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		if (!vm_area)
 			continue;
 
+		if (memcg_charge_kernel_stack(vm_area)) {
+			vfree(vm_area->addr);
+			return -ENOMEM;
+		}
+
 		/* Reset stack metadata. */
 		kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
 
@@ -298,11 +303,6 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		/* Clear stale pointers from reused stack. */
 		memset(stack, 0, THREAD_SIZE);
 
-		if (memcg_charge_kernel_stack(vm_area)) {
-			vfree(vm_area->addr);
-			return -ENOMEM;
-		}
-
 		tsk->stack_vm_area = vm_area;
 		tsk->stack = stack;
 		return 0;

-- 
2.50.1


