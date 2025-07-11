Return-Path: <linux-kernel+bounces-728263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0238EB02595
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 22:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BBF5A15B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494541EFF96;
	Fri, 11 Jul 2025 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EZX5VuK/"
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7B1DE2CC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264456; cv=none; b=f71e/ohlSoRdLdI0PgRhrPcoJyZH8AkX/HH98H7WD+0QjzNTyO8AFkZP3cciJFCID7ONtjGux3yaBzJ2qAbxP/YSdL0gYYaCg9scpDYynbqNizywl9eycpTE25Q5fG3KkH4TavLIYqz031OyREskxIEuC8FqIzPE0Et4d5cM2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264456; c=relaxed/simple;
	bh=8OmiKAixvVd1qUodpWB5lP5+cBj7n2qE/sWCnAHwWYc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VTXKh+bl2e7zKaoU3ZptIqfdE8v9eFKvrTMKDEWW3CaUBucnXZ+owBTXeLbcgo0PS7+sntBx72IrfKot/9m+8oCftQ4SZSm3dCZqEEYXus+OJY9usHdjz5lMQJaBIek3gu4O3HOFgc5e2BNKFioFJkVJE9X6lUsDIVvEetTD78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EZX5VuK/; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6fb520a74c8so43369406d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752264453; x=1752869253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PyWhAnCYCt4u7XeibLhzzMMy2HX/pV/921yEKYQT3nc=;
        b=EZX5VuK/u7S5M+aWGimT7F/hqXXdlXnl81r/teW4bP0JmqLJpQ85Qq7jbb80N//C8X
         KE9W+ji1Sy96Xfjg+Jm4cH+KXGVaAMxXvagu0dYR9JFgQCLEMEnPjc+5kZ9y93XxD5RO
         joUEKkhRAhRLqtsP8Op4GglVHV6AVMXajL9G7ftYPBEcstYGCsPlqBw0PmMtM/s03odB
         gi/fw5vkeXwyYB3FJw6Nim8eKUbj7SJDaMzxkvTQOEbqJVTA+3ktfGKiMaUVklwm2mTE
         diodX5RVp7Wc1eQ5UNfhULR2nvLBm1Nit8xGGjwCXTxTCyy1wbwIoWIdgAA3kApMQH5d
         JRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752264453; x=1752869253;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PyWhAnCYCt4u7XeibLhzzMMy2HX/pV/921yEKYQT3nc=;
        b=ctkes/XJjNXE9fwBLslII+cbHUrKGxRlgluqLVhHbaWy6jDxV0zGU14XbJ6Usnkexe
         J/Bh9EMzZqP01CxYikhuo3OtgOMLoHi9WWYTMCNnFCsp3mcHOjpIXqR2nrXRNeFjYGs0
         /T1ZORXQqhFZ9W17Y+WbBJ0ZvBPot9m3XDJDbsE4TLs0zWG6STocyHuef2pSxsp1Y9Ww
         wiKqKqbxjD0G8tg0pUgUUxJqDiM20ABqynKNeqefgE5dWHvd6A2i8rZcUdl2non2cEPH
         sYxn27+KYCdyvXfF2Q8CicCZP6fnO85hYaP0fHcLTeO9j0GuzwcBj2zXSeV2JkckguPB
         A3UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNhRXtixaSYmYD3xm/3y5bA01inRogxHs0HwSY5EGIcnks1mDUIJkFgJh/TDjBSWyKJVfdfQ56q/pT4m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJLtov+dk1r8wz+xGlFTmVqb6wI1JUslOaR94kJZkDV20X2vBh
	X+Ho4msXpcn42hx5Nh+2FYwrtIZIK2n6VRHhreIyOok4Z+3PjDjf0s7BkcQ17HCaQHPZGYy4X4M
	clx+aty2cAexjqHq3qujCggFxIo8RdQ==
X-Google-Smtp-Source: AGHT+IG3Murba99pf2Nruu8809aM7LvUkJqNwkECR/wtGoS6MccCGJJni4eGnXrjYnl4jQo30klzBClcQ70IO8if9b4=
X-Received: from qvvv14.prod.google.com ([2002:a05:6214:808e:b0:6fa:e85f:14f9])
 (user=mattgilbride job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2304:b0:704:8f24:f044 with SMTP id 6a1803df08f44-704a39c6951mr90664806d6.34.1752264452777;
 Fri, 11 Jul 2025 13:07:32 -0700 (PDT)
Date: Fri, 11 Jul 2025 20:07:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711200705.1545447-1-mattgilbride@google.com>
Subject: [PATCH 1/1] uprobes: relax valid_vma check for VM_MAYSHARE
From: Matt Gilbride <mattgilbride@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="UTF-8"

`valid_vma` returns false when registering a uprobe if the provided VMA
is writable (`VM_WRITE`) or sharable (`VM_MAYSHARE`). This causes
`perf_event_open` [1] sys calls to fail silently. A successful return
code is delivered to the caller even though the uprobe wasn't actually
attached [2][3].

Remove the latter restriction (`VM_MAYSHARE`) from this check to allow
registering uprobes on code that has been "dual mapped" into a
process' memory space. This is helpful when instrumenting just-in-time
compiled code such as that of Android Runtime (ART) [4]. ART maps a
memfd twice, once as RW and once as RX, to uphold W^X for security
(defense in depth), and also to provide better performance (no need to
call `mprotect` before and after writing) [5].

uprobes already work for code that is ahead-of-time (AOT) compiled by
the Android Runtime (ART), as it resides in a static ELF file [6]. In
order to attach to just-in-time (JIT) compiled code, the Android OS itself
can coordinate with ART to isolate to-be-instrumented code in a separate
memfd, which will be left untouched for the duration of a uprobe being
attached. Thus, while the VMAs inside the memfd will *technically* have
the `VM_MAYSHARE` flag, the system will ensure that they will not be
written to again until after any uprobe as been detached.

Link: https://man7.org/linux/man-pages/man2/perf_event_open.2.html [1]
Link: https://github.com/torvalds/linux/blob/088d13246a4672bc03aec664675138e3f5bff68c/kernel/events/uprobes.c#L1197-L1199 [2]
Link: https://github.com/torvalds/linux/blob/088d13246a4672bc03aec664675138e3f5bff68c/kernel/events/uprobes.c#L1256-L1268 [3]
Link: https://source.android.com/docs/core/runtime/jit-compiler [4]
Link: http://cs.android.com/android/platform/superproject/main/+/main:art/runtime/jit/jit_memory_region.cc;l=111-137?q=jit_memory_region.cc [5]
Link: https://source.android.com/docs/core/runtime#AOT_compilation [6]
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
We've created a working proof-of-concept in Android that demonstrates
what is described in the last paragraph of the commit message. Thus, we
introduce this patch to understand the reasoning behind the original
`VM_SHARED` (later converted to `VM_MAYSHARE`) restriction, and the risks
that may be associated with relaxing it. It's not clear to me why the
restriction is there, and we'd like to get feedback on why it is or is
not still relevant.

 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a8caaea07ac37..1ecb3fdb853b9 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -123,7 +123,7 @@ struct xol_area {
  */
 static bool valid_vma(struct vm_area_struct *vma, bool is_register)
 {
-	vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
+	vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC;
 
 	if (is_register)
 		flags |= VM_WRITE;
-- 
2.50.0.727.gbf7dc18ff4-goog


