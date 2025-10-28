Return-Path: <linux-kernel+bounces-874749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C2FC17036
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4441C620D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71D5357A24;
	Tue, 28 Oct 2025 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYa3Qo5V"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77231357728
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686750; cv=none; b=d334qgpMkxkWiyRmK2FcGjF2pYei+oLkHNJISQzcxkZ4jrS2TcZAiqbwGEd8vcyWpAK8J9DnezZ/nxhWxBZlueZdCPqvKpuEYVq9/DPGyTYc2+GCHTwJP/j8JOnrvG1GvbVzsCc7EFLk63mBS1my60HYZnKsVGhhASsk8PbsYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686750; c=relaxed/simple;
	bh=LnE/ui7WPuI0tDOkrq07UPOVbHa6eIZOJkp43XDZ37A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WlmPkaWZZIczSsaS4j0mzyKHs2yMt6cwajAdC84gs02AZ4GfbvOwQXVqEMb57MupwHSq1yz6u+XAfOCT4uo5VwN+iOrSoenQJzWn5xoHC7j08h0c7I9ALtUBQreuK5KsD5/GRIj7Th/kAwbOUwITN0tlB0xAPp8WMPohpPxvVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYa3Qo5V; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-78103962c97so68239757b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686747; x=1762291547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+zRclGCeCxZWGKiQ7HQS17pkEGlf1WyYG/KnmVF2Ow=;
        b=GYa3Qo5VIWqmfphZ53KLeKKe0i2jZkaeQvJtIgEejVIHPAzdPV/Lu/oQkyUypGfvsm
         QsBHQxSCJoxNPcfbQlweizgZlBp4tA9nITfGKWxS5A+KLg0xgPwTuKGqg0qcmczsAIVx
         zaTjvFWeutTD8UZPsSlXju0kW78cZIkp5XwCB7+1E1wpPSicnEWVzD3zgjpJ7FFoVdBl
         vZZ0qKuYyZpWf6txu+SO2RIwuvvBJoPD7J6HPYlhvn42PFT9zb/nIct4MymohNfm1ny8
         3X6BzwqPvBsFdWra2nSDThCxejAIhY+mQgaXfdlTbj5jPwf9g7pMDbhFXISa7PtLBjks
         FkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686747; x=1762291547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+zRclGCeCxZWGKiQ7HQS17pkEGlf1WyYG/KnmVF2Ow=;
        b=fc2Tsn9uDh8iUH4Y7kSkWObvPK5CydC+Idc0ko5yAzrMLtWznEWspVsEZemACqoo5q
         nIFq4tnFlp+v468NsTTTY3oKplaCVO97P1NQIfWzavgP3G01Fx0GqWv5HONWzECo29No
         J7YQ/9t/aerXPq8vXSxIeaYglXQvpl/mU57bXhB6yinCuCAN1FAVtQTVoEZuhGbxCgsU
         UQHwD0IGka29ZBP52gWC1wIk+T0dC5uvkQS6pTOyRZE5HSPP7HJDErMcDBgbf72579tD
         /9+o7dnOTYTRnSOO9NwqnMfVSQDygU0rDhdF4HHxIucmpbKVyxgPVVap6tdtAA9tiVtN
         3b0w==
X-Forwarded-Encrypted: i=1; AJvYcCV/j0FsE6KYDatZ9eZSXBIoAZ/OxOrz9Y411aXcDLRnm9lul1NCngHXrlR37fGNCRe3DmRNQxvYPic+QJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPw34yStcMxmgh58agUHIZu+d4f+KotBf+3vOwWZK3pgn8WWhf
	sav+oE637+EkfEElHZ6TAPEWXAOEwHt4RGav+MVPy+t8xkW6FvmT8pwM6RF/4GD+pEg5xf6/m1t
	8fj+pNll53WZHTCjP6+5MpGBsyQ==
X-Google-Smtp-Source: AGHT+IH21b8dTnDOMODyiAwwvvmg3HPg3LdlXgV0zvr0MUW3DPJaRaW0W9viFnaByL5fljhBttHAanw04I0ZoATTMA==
X-Received: from ybbgj2.prod.google.com ([2002:a05:6902:4182:b0:eba:96f:2183])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:4c0b:b0:781:64f:2b33 with SMTP id 00721157ae682-786290149fcmr7812607b3.69.1761686747446;
 Tue, 28 Oct 2025 14:25:47 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:24:32 -0700
In-Reply-To: <20251028212528.681081-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212528.681081-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212528.681081-2-kaleshsingh@google.com>
Subject: [PATCH v4 1/5] mm: Document lenient map_count checks
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: rostedt@goodmis.org, hughd@google.com, kernel-team@android.com, 
	android-mm@google.com, Kalesh Singh <kaleshsingh@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add comments to the map_count limit checks in do_mmap() and
do_brk_flags() to clarify their intended behavior.

The use of a strict inequality ('>') in these checks is intentional but
non-obvious. It allows these functions to succeed when the VMA count is
exactly at the sysctl_max_map_count limit. This historical behavior
accounts for cases where the operation might not create a new VMA, but
instead merge with or expand an existing one, in which case the VMA
count does not increase.

These comments clarify the long-standing behavior and will help prevent
future misinterpretation as an off-by-one error.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v4:
 - Keep the existing lenient behavior, per Hugh
 - Document this is intended, per Lorenzo

Changes in v3:
 - Collect Reviewed-by and Acked-by tags.

Changes in v2:
 - Fix mmap check, per Pedro

 mm/mmap.c | 9 +++++++++
 mm/vma.c  | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 644f02071a41..78843a2fae42 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -374,6 +374,15 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		return -EOVERFLOW;
 
 	/* Too many mappings? */
+	/*
+	 * The check is intentionally lenient (>) to allow an mmap() at the limit
+	 * to succeed. This is for historical reasons, as the new mapping might
+	 * merge with an adjacent VMA and not increase the total VMA count.
+	 *
+	 * If a merge does not occur, the process is allowed to exceed the
+	 * sysctl_max_map_count limit by one. This behavior is preserved to
+	 * avoid breaking existing applications.
+	 */
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
diff --git a/mm/vma.c b/mm/vma.c
index 919d1fc63a52..d0bb3127280e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2813,6 +2813,12 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
+	/*
+	 * The check is intentionally lenient (>) to allow brk() to succeed at
+	 * the limit. This is for historical reasons, as expanding the heap
+	 * typically extends the existing brk VMA rather than creating a new one.
+	 * See also the comment in do_mmap().
+	 */
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
-- 
2.51.1.851.g4ebd6896fd-goog


