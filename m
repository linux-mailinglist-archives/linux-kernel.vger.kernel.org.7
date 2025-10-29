Return-Path: <linux-kernel+bounces-875154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87764C18517
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAA7B50292D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995DD30B528;
	Wed, 29 Oct 2025 05:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cx3NmWig"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9772F619F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716087; cv=none; b=dbZ4jHFm8BvawggMr3+uHXmq6lga/EAu0F4LgcGwv9CwpHYf29o/yOl6JttSHJp1GWHXRaHZEjkn5w88i5uK2IzriKw8z8h2SRwp5Hor/kCmYkHi9DeuhLVEhJHNSq5yYlVzp7Woy3Ze3Y+DfPloL5qMkymtbschsJ//M3e1JjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716087; c=relaxed/simple;
	bh=cXBb0FpLHE2+FneP8Fo+45jo0Wy454pCH8ScJIJcmqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iezpiFlHz/fMylmZC8CDJfcsWAtnzPXVgf8cJy1TPia1BZO30cHXYOMCk58TagKWWTvXkvrDjXRJpmPJkINJuaaEMef8asbsZgM6y5aK5L3OCgxLbvy9ZNTioWUEM/ow51ECbgPbinAKla2xmkhhFYEPNxybhfQQiXu3yeBbs+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cx3NmWig; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-339b704e2e3so6216171a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716085; x=1762320885; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gC3uJBytFjGETcDOSgD3LOM/9/gCLbGFWg1YShV84iU=;
        b=cx3NmWigG++FEG+yZxZLKwDkLaP9dRHHR+Uif9tw5qQq1g8R2ON2Jryv3wDAi+hrpo
         zQwE6o/7E9HMCyKy4w32R4VuX/daoUOqIZMhBD+Fft2zd+Fqd7KZtVHcpf+vl+lXtYR0
         jvoCVXJkdLMmp988WFnz/P4idsG+0E09LrZA0oMYUDEWLbY9UXFGqqQw8HLCpRUUGFVc
         +tQieKwFUAh9kk2touFuVeivz6yBFb/xntiV8mEew0wmlAiUG+Brd0WI6KB7JGUAMtUs
         Spg9zOa8Uxwjv120gqFXfMw72nAMnKroCGx32gAtwnAillCR+ohfW/wJWNdTvNHcVxJ+
         4rMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716085; x=1762320885;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gC3uJBytFjGETcDOSgD3LOM/9/gCLbGFWg1YShV84iU=;
        b=pO/qJMv2G1+xt4Oa2jlrhhmLUghd9rrcTPdfS11Zt3S628J3uXFlgdo5WPAGfMjb7Z
         Lu5INmnX9RhQB0SAutWbZOr006QlrobwoHmzPLRe6IzE+kwRDIRUBzTT0MWN0knTiPK8
         D9TGWuGbhfSYSgXry5vvD41IBn4ZPe1NUctQWkLcD/CTu13oehE7GpjmLpuPYdXpC1tf
         8kVoLkIsA+G9S9aWp2SBZw+u4GPYh6PiU4xfKJoTKb0x2upHBYqK1eeCIWgdYnWvNcZ1
         Zp8uD//puUZWUaLp4f19pFDue9lzs2GOhdnu/EKm+B7z2uCUWUlJZGgmdfkp+gZynFtz
         ieRg==
X-Forwarded-Encrypted: i=1; AJvYcCUQy3Elz9nmx+s+zcfqt4MCLBH6NSD6zUI4HyXcwFYg+Zg40jYu/FmLxsdov2R3FIsL1JUWdZ5dE5eZluA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLUmoKR1M79PFd5BFZ/Z5bu4XKAGXDz+rukGTTSqHRp3zOyYO9
	j1xQKNh/BDaKVwPGC6qel990MY6qqsr1qy3sRVtrifV9+i9EFyzd54yXCdfWMjFOb4IV4hEBHwM
	dcmPM20H1Xg==
X-Google-Smtp-Source: AGHT+IHyABFgO5ifFMRWloVxbgKF6DgOKTCx7hX5z8zDswf1AZ0hIWHCguMLeQj+zWYBmU7ntB23e4WGxRng
X-Received: from pjob9.prod.google.com ([2002:a17:90a:8c89:b0:33b:8aa1:75ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e4b:b0:33b:bf8d:6172
 with SMTP id 98e67ed59e1d1-3403a305995mr1671076a91.34.1761716085290; Tue, 28
 Oct 2025 22:34:45 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:13 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-16-irogers@google.com>
Subject: [RFC PATCH v1 15/15] perf mem-phys-addr.py: Port to standalone
 application from perf script
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Give an example of using the perf python session API to load a
perf.data file and perform the behavior of
tools/perf/scripts/python/mem-phys-addr.py.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/mem-phys-addr.py | 117 +++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 tools/perf/python/mem-phys-addr.py

diff --git a/tools/perf/python/mem-phys-addr.py b/tools/perf/python/mem-phys-addr.py
new file mode 100644
index 000000000000..32bb63598239
--- /dev/null
+++ b/tools/perf/python/mem-phys-addr.py
@@ -0,0 +1,117 @@
+# mem-phys-addr.py: Resolve physical address samples
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2018, Intel Corporation.
+
+import bisect
+import collections
+import os
+import perf
+import re
+import sys
+from dataclasses import dataclass
+from typing import (Dict, Optional)
+
+@dataclass(frozen=True)
+class IomemEntry:
+    """Read from a line in /proc/iomem"""
+    begin: int
+    end: int
+    indent: int
+    label: str
+
+# Physical memory layout from /proc/iomem. Key is the indent and then
+# a list of ranges.
+iomem: Dict[int, list[IomemEntry]] = collections.defaultdict(list)
+# Child nodes from the iomem parent.
+children: Dict[IomemEntry, set[IomemEntry]] = collections.defaultdict(set)
+# Maximum indent seen before an entry in the iomem file.
+max_indent: int = 0
+# Count for each range of memory.
+load_mem_type_cnt: Dict[IomemEntry, int] = collections.Counter()
+# Perf event name set from the first sample in the data.
+event_name: Optional[str] = None
+
+def parse_iomem():
+    """Populate iomem from /proc/iomem file"""
+    global iomem
+    global max_indent
+    global children
+    with open('/proc/iomem', 'r', encoding='ascii') as f:
+        for line in f:
+            indent = 0
+            while line[indent] == ' ':
+                indent += 1
+            if indent > max_indent:
+                max_indent = indent
+            m = re.split('-|:', line, maxsplit=2)
+            begin = int(m[0], 16)
+            end = int(m[1], 16)
+            label = m[2].strip()
+            entry = IomemEntry(begin, end, indent, label)
+            # Before adding entry, search for a parent node using its begin.
+            if indent > 0:
+                parent = find_memory_type(begin)
+                assert parent, f"Given indent expected a parent for {label}"
+                children[parent].add(entry)
+            iomem[indent].append(entry)
+
+def find_memory_type(phys_addr) -> Optional[IomemEntry]:
+    """Search iomem for the range containing phys_addr with the maximum indent"""
+    for i in range(max_indent, -1, -1):
+        if i not in iomem:
+            continue
+        position = bisect.bisect_right(iomem[i], phys_addr,
+                                       key=lambda entry: entry.begin)
+        if position is None:
+            continue
+        iomem_entry = iomem[i][position-1]
+        if  iomem_entry.begin <= phys_addr <= iomem_entry.end:
+            return iomem_entry
+    print(f"Didn't find {phys_addr}")
+    return None
+
+def print_memory_type():
+    print(f"Event: {event_name}")
+    print(f"{'Memory type':<40}  {'count':>10}  {'percentage':>10}")
+    print(f"{'-' * 40:<40}  {'-' * 10:>10}  {'-' * 10:>10}")
+    total = sum(load_mem_type_cnt.values())
+    # Add count from children into the parent.
+    for i in range(max_indent, -1, -1):
+        if i not in iomem:
+            continue
+        for entry in iomem[i]:
+            global children
+            for child in children[entry]:
+                if load_mem_type_cnt[child] > 0:
+                    load_mem_type_cnt[entry] += load_mem_type_cnt[child]
+
+    def print_entries(entries):
+        """Print counts from parents down to their children"""
+        global children
+        for entry in sorted(entries,
+                            key = lambda entry: load_mem_type_cnt[entry],
+                            reverse = True):
+            count = load_mem_type_cnt[entry]
+            if count > 0:
+                mem_type = ' ' * entry.indent + f"{entry.begin:x}-{entry.end:x} : {entry.label}"
+                percent = 100 * count / total
+                print(f"{mem_type:<40}  {count:>10}  {percent:>10.1f}")
+                print_entries(children[entry])
+
+    print_entries(iomem[0])
+
+if __name__ == "__main__":
+    def process_event(sample):
+        phys_addr  = sample.sample_phys_addr
+        entry = find_memory_type(phys_addr)
+        if entry:
+            load_mem_type_cnt[entry] += 1
+
+            global event_name
+            if event_name is None:
+                event_name  = str(sample.evsel)
+
+    parse_iomem()
+    perf.session(perf.data("perf.data"), sample=process_event).process_events()
+    print_memory_type()
-- 
2.51.1.851.g4ebd6896fd-goog


