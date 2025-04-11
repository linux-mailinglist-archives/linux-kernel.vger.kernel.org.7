Return-Path: <linux-kernel+bounces-600669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9146CA8630B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 18:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CFE8C0D24
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2FD2153F1;
	Fri, 11 Apr 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cAa0k9oQ"
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D41C1F4C8F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388278; cv=none; b=q+P7TBRp5BDH+mPvdX8W6o2oAkFDh1gd9qv1sBn/8etZpDg45MXiFbx6tAHF5uG9C/8D1dQm2+b+1MGAvHpMFrRlH+o5XrnDK4tg3CXrxu8VNGB+w52N7pWp1s9a2R8/o/95VaUOuHi7SbW3qCm84SUcWVm6VIGDZ+3gKNH2iiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388278; c=relaxed/simple;
	bh=KP2RaWUafBmA0oEogZi6scAsh+hqCLzFLKjiCrsxxtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sy10qSrzAuDc9eOi47i+9YZ6punWuSp5UcWZ7icuNWwSqjGENnumKrsx95cWq27Qb1eqFT85rdf6iy+sSboqYp2yAzYuIHBc1UsDpWfCr0cu0IyPRvCkPDErMr9bLYgYX8HBIRb1mDdyngRXio80t4BdzZbz3e1bY1XNz7eJgsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cAa0k9oQ; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6eae4819112so2248476d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744388275; x=1744993075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RYQ1Awm7jT8q0TCxAtt2I3/JHwOa1nftjKAz6rDAB3M=;
        b=cAa0k9oQUw8gWf+wWrJYuZxjHzfuiFgzTEzOU+V9CCZvb1nJ+OU5XCNRn3t2pg7eRN
         ie68FEoxIH9ycIdL/1y5+Y1R9i+xNerBY1uVGPLrmLWz7T/XFdQ5WJrvQSeqJXe1taPS
         o1+6oFuYkwgHf5WIfh7n8aXSQ2rQZbHSnLlSi6u36Y/I69aksCbocOBx8CDBO/0P4SRZ
         4tTPJIESzMP2UZ97GJIvuH1i7iRaO3sQG4f+rlrH0/rm/Lai9fjusIVVBEDHp6Qe70rq
         pntWc/OpYc3hCX7+9K7XNDBnowQ1mMwQs7tHovbnw0iv0S1DfDQY4eBH7B+GenG9dHCO
         KwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744388275; x=1744993075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYQ1Awm7jT8q0TCxAtt2I3/JHwOa1nftjKAz6rDAB3M=;
        b=JKcpYnxbGuhQXVCfI3rNmRdXptHRIYk3/0Nu4o/GcKW4isny3oJ4PeHqi1ioKlEzuM
         KN7vwAiInQAZKaO1+2BtyG31qH8QB1p02206lYEjbtIk8CjfQ+dogE6zCa8vLLEVj0y3
         pD3SInTrj7qXuRyHDWo7C62PfSgkEkGQJya5I0qzbPhgM/4G/3Dhr47pwDB51/TdL3kb
         n9e6LBZnGLDuymgmQdgUqqmqlKsmloIIh5ve4R6HDhRZRC/0Ae7P323LMuLtKvT8B0s+
         gFzT0skCXY9yQnw5wimvg2ePmgVbVb6+9neWcUAnYnvwb9ddGEFHqV9xOUQm/tsnHUW0
         24KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2jJw9EQxUafLlIRzn7UfpJpXuF9uycJwURDayr6KpqKQQfzzaKA/GRPUwI2X6wwj/mItKJRy8nUFSXPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuEq3p9OU6f9r9P99/l0BZrT5Rgz3VXK4n/WFDfZNkytQoh0BO
	heBMD/8MNM3fgW9qqeAL9Qnit52xHUrgEqcOkmMuQT+ok4+GavBB1XdM2Vq/T4JV4mVLsJq52lp
	p4IJoi/0QSetjkiRcvtzRyJq+fLuNXvop2xUrXTN2HvyfUowE
X-Gm-Gg: ASbGnctqc2pYLzUUpJQvbySRoYwaytcPO+/KQq7QE11RCeRwXhfYYWL2BOpldt3Ok1i
	meA5I7zFtv/qaLRHMhJIXUNgmtlA/VIvrWktte1w9RN25VwyDRqAijWPlv93X6i0k62aEuKkKmX
	YwuQxnVaA/qHtZMAhGGm6MfANAUHpBy5B1TYzh8v3QAicCX3V2+vij+njH9BtSthmzStBrZeN5q
	4WSVrZ/MBIaWd2eDmA0iGGioMWt7JsNWAJmBA4xfkYAM5Xzsqklrf9SkeZR2OPIJ50WPDU6JHWN
	S9MVsgqOEn8wuiQtTSo5c3riY56otQ==
X-Google-Smtp-Source: AGHT+IGyXtJUelEeTrI9PO9zYxEbOAMa4KjH3KhcKQWJOI2gGu9pzXcD3jwqgXdC4OFN2hVEZ2Em+TwYVBpM
X-Received: by 2002:a05:6214:409:b0:6e8:9fc6:e41 with SMTP id 6a1803df08f44-6f23f164237mr17764476d6.10.1744388275256;
        Fri, 11 Apr 2025 09:17:55 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f0de96e48asm3974236d6.25.2025.04.11.09.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 09:17:55 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 40E2B3402B1;
	Fri, 11 Apr 2025 10:17:54 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 35CDBE41DAB; Fri, 11 Apr 2025 10:17:54 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Eric Mueller <emueller@purestorage.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] mm: remove unused mmap tracepoints
Date: Fri, 11 Apr 2025 10:17:45 -0600
Message-ID: <20250411161746.1043239-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vma_mas_szero and vma_store tracepoints are unused since commit
fbcc3104b843 ("mmap: convert __vma_adjust() to use vma iterator").
Remove them so they are no longer listed as available tracepoints.

Reported-by: Eric Mueller <emueller@purestorage.com>
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/trace/events/mmap.h | 52 -------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index f8d61485de16..ee2843a5daef 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -41,62 +41,10 @@ TRACE_EVENT(vm_unmapped_area,
 		__entry->total_vm, __entry->flags, __entry->length,
 		__entry->low_limit, __entry->high_limit, __entry->align_mask,
 		__entry->align_offset)
 );
 
-TRACE_EVENT(vma_mas_szero,
-	TP_PROTO(struct maple_tree *mt, unsigned long start,
-		 unsigned long end),
-
-	TP_ARGS(mt, start, end),
-
-	TP_STRUCT__entry(
-			__field(struct maple_tree *, mt)
-			__field(unsigned long, start)
-			__field(unsigned long, end)
-	),
-
-	TP_fast_assign(
-			__entry->mt		= mt;
-			__entry->start		= start;
-			__entry->end		= end;
-	),
-
-	TP_printk("mt_mod %p, (NULL), SNULL, %lu, %lu,",
-		  __entry->mt,
-		  (unsigned long) __entry->start,
-		  (unsigned long) __entry->end
-	)
-);
-
-TRACE_EVENT(vma_store,
-	TP_PROTO(struct maple_tree *mt, struct vm_area_struct *vma),
-
-	TP_ARGS(mt, vma),
-
-	TP_STRUCT__entry(
-			__field(struct maple_tree *, mt)
-			__field(struct vm_area_struct *, vma)
-			__field(unsigned long, vm_start)
-			__field(unsigned long, vm_end)
-	),
-
-	TP_fast_assign(
-			__entry->mt		= mt;
-			__entry->vma		= vma;
-			__entry->vm_start	= vma->vm_start;
-			__entry->vm_end		= vma->vm_end - 1;
-	),
-
-	TP_printk("mt_mod %p, (%p), STORE, %lu, %lu,",
-		  __entry->mt, __entry->vma,
-		  (unsigned long) __entry->vm_start,
-		  (unsigned long) __entry->vm_end
-	)
-);
-
-
 TRACE_EVENT(exit_mmap,
 	TP_PROTO(struct mm_struct *mm),
 
 	TP_ARGS(mm),
 
-- 
2.45.2


