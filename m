Return-Path: <linux-kernel+bounces-604533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BDCA895A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 09:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38793B6C25
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9241AF0D0;
	Tue, 15 Apr 2025 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VVW72aPb"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24F2741D2;
	Tue, 15 Apr 2025 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703470; cv=none; b=PsoI1x7zmAefvLrnImTqtWN7JWShehpaICSeBBBuMqZkbvdLhwLYH3nUERABwvYSf7hf8UzPpjW+B1V9Q/QBDCM14XT7S6/6P0s8vnqqqGow9IW/RFq4JKK4zYR+Pk2OlSdq8oXPROdH5cWAPDIkKRlVeyrFbkQUk7V1twUZ504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703470; c=relaxed/simple;
	bh=r9ufPwUAMeRhf6lPmmzB6FeQNWgHbJaijd5wxqyPBhc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oS71kZxmYi4kbFfULMvCKEjkV9eJby0v+sLwJl5ZTpOj4cW0CBJ+tE8Le5aFAgChxPExS7kuHbcHk2z7qv4lkLBQH13BcnByk4KSXZF+zJQuiiMQkmndtVRJgbDomFMzQ3/mP8BwdPUEjcYZ4d378oU7RD2j/1Db9ey/hT0qbnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VVW72aPb; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744703465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w7xWxJYFP6M/TEqfUiLVEiOQ7IdW+X8eIqI/gwRpLkM=;
	b=VVW72aPbTA5CfCPTg6YTyuwMbCkhi0MPTaIJpFSfD/e5VFBXH8gixxFCKrqH7KikTn/Nbi
	ziz5Dbj5TKBjMJhReTN66se8zEtDRf27BtfbIfM3gjLxnw3Vllh6EBXzDIsbZYjsQYoTfA
	3eFlHnTcnES5z1l2eJPJmHy/6VB8O4A=
From: Ye Liu <ye.liu@linux.dev>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: linux-toolchains@vger.kernel.org,
	linux-mm@kvack.org,
	Ye Liu <liuye@kylinos.cn>
Subject: [PATCH] tools/drgn: Add script to display page state for a given PID and VADDR
Date: Tue, 15 Apr 2025 15:50:24 +0800
Message-Id: <20250415075024.248232-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Introduces a new drgn script, `show_page_info.py`, which allows users
to analyze the state of a page given a process ID (PID) and a virtual
address (VADDR). This can help kernel developers or debuggers easily
inspect page-related information in a live kernel or vmcore.

The script extracts information such as the page flags, mapping, and
other metadata relevant to diagnosing memory issues.

Currently, there is no specific maintainer entry for `tools/drgn/` in the
MAINTAINERS file. Therefore, this patch is sent to the general kernel and
tools mailing lists for review.

Output example:
sudo ./show_page_info.py 1 0x7f2c7de4c000
PID : 1 Comm : systemd mm : 0xffff888116b6d440
User Virtual Address : 0x7f2c7de4c000
Page Address    : 0xffffea000b3a4000
raw: 0017ffffc000416c ffffea00045d1b08 ffffea000456d408 ffff888104521970
raw: 0000000000000000 ffff8881083fdb60 0000006900000018 ffff888107a41000
Page Flags      : PG_referenced|PG_uptodate|PG_lru|PG_head|PG_active|
                  PG_private|PG_reported
Page Size       : 16384
Page PFN        : 0x2ce900
Page Physical   : 0x2ce900000
Page Virtual    : 0xffff8882ce900000
Page Refcount   : 105
Page Mapcount   : 24
Page Index      : 0x0
Page Memcg Data : 0xffff888107a41000
Memcg Name      : init.scope
Memcg Path      : /sys/fs/cgroup/memory/init.scope
Page Mapping    : 0xffff888104521970
Page Anon/File  : File
Page VMA        : 0xffff888109e135e8
VMA Start       : 0x7f2c7de4c000
VMA End         : 0x7f2c7de58000
This page is part of a compound page.
This page is the head page of a compound page.
Head Page       : 0xffffea000b3a4000
Compound Order  : 2
Number of Pages : 4

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 tools/drgn/show_page_info.py | 120 +++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 tools/drgn/show_page_info.py

diff --git a/tools/drgn/show_page_info.py b/tools/drgn/show_page_info.py
new file mode 100644
index 000000000000..70d0cd97c7f0
--- /dev/null
+++ b/tools/drgn/show_page_info.py
@@ -0,0 +1,120 @@
+#!/usr/bin/env drgn
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2025 Ye Liu <liuye@kylinos.cn>
+
+import argparse
+from drgn import Object
+from drgn.helpers.linux import find_task, follow_page, page_size
+from drgn.helpers.linux.mm import (
+    decode_page_flags, page_to_pfn, page_to_phys, page_to_virt, vma_find,
+    PageSlab, PageCompound, PageHead, PageTail, compound_head, compound_order, compound_nr
+)
+from drgn.helpers.linux.cgroup import cgroup_name, cgroup_path
+
+DESC = """
+This is a drgn script to show the page state.
+For more info on drgn, visit https://github.com/osandov/drgn.
+"""
+
+MEMCG_DATA_OBJEXTS = 1 << 0
+MEMCG_DATA_KMEM = 1 << 1
+__NR_MEMCG_DATA_FLAGS = 1 << 2
+
+def format_page_data(data):
+    """Format raw page data into a readable hex dump."""
+    chunks = [data[i:i+8] for i in range(0, len(data), 8)]
+    hex_chunks = ["".join(f"{b:02x}" for b in chunk[::-1]) for chunk in chunks]
+    lines = [" ".join(hex_chunks[i:i+4]) for i in range(0, len(hex_chunks), 4)]
+    return "\n".join(f"raw: {line}" for line in lines)
+
+def get_memcg_info(page):
+    """Retrieve memory cgroup information for a page."""
+    memcg_data = page.memcg_data.value_()
+    if memcg_data & MEMCG_DATA_OBJEXTS:
+        memcg_value = 0
+    elif memcg_data & MEMCG_DATA_KMEM:
+        objcg = Object(prog, "struct obj_cgroup *", address=memcg_data & ~__NR_MEMCG_DATA_FLAGS)
+        memcg_value = objcg.memcg.value_()
+    else:
+        memcg_value = memcg_data & ~__NR_MEMCG_DATA_FLAGS
+
+    memcg = Object(prog, "struct mem_cgroup *", address=memcg_value)
+    cgrp = memcg.css.cgroup
+    return cgroup_name(cgrp).decode(), f"/sys/fs/cgroup/memory{cgroup_path(cgrp).decode()}"
+
+def show_page_state(page, addr, mm, pid, task):
+    """Display detailed information about a page."""
+    print(f'==============================================================')
+    print(f'PID : {pid} Comm : {task.comm.string_().decode()} mm : {hex(mm)}')
+    print(f'User Virtual Address : {hex(addr)}')
+    print(f'Page Address    : {hex(page.value_())}')
+    print(f'--------------------------------------------------------------')
+
+    print(format_page_data(prog.read(page.value_(), 64)))
+    print(f'--------------------------------------------------------------')
+
+    print(f'Page Flags      : {decode_page_flags(page)}')
+    print(f'Page Size       : {page_size(page).value_()}')
+    print(f'Page PFN        : {hex(page_to_pfn(page).value_())}')
+    print(f'Page Physical   : {hex(page_to_phys(page).value_())}')
+    print(f'Page Virtual    : {hex(page_to_virt(page).value_())}')
+    print(f'Page Refcount   : {page._refcount.counter.value_()}')
+    print(f'Page Mapcount   : {page._mapcount.counter.value_()}')
+    print(f'Page Index      : {hex(page.index.value_())}')
+    print(f'Page Memcg Data : {hex(page.memcg_data.value_())}')
+
+    memcg_name, memcg_path = get_memcg_info(page)
+    print(f'Memcg Name      : {memcg_name}')
+    print(f'Memcg Path      : {memcg_path}')
+    print(f'--------------------------------------------------------------')
+
+    print(f'Page Mapping    : {hex(page.mapping.value_())}')
+    print(f'Page Anon/File  : {"Anon" if page.mapping.value_() & 0x1 else "File"}')
+
+    vma = vma_find(mm, addr)
+    print(f'Page VMA        : {hex(vma.value_())}')
+    print(f'VMA Start       : {hex(vma.vm_start.value_())}')
+    print(f'VMA End         : {hex(vma.vm_end.value_())}')
+    print(f'--------------------------------------------------------------')
+
+    if PageSlab(page):
+        print("This page belongs to the slab allocator.")
+
+    if PageCompound(page):
+        print("This page is part of a compound page.")
+        if PageHead(page):
+            print("This page is the head page of a compound page.")
+        if PageTail(page):
+            print("This page is the tail page of a compound page.")
+        print(f'Head Page       : {hex(compound_head(page).value_())}')
+        print(f'Compound Order  : {compound_order(page).value_()}')
+        print(f'Number of Pages : {compound_nr(page).value_()}')
+    else:
+        print("This page is not part of a compound page.")
+    print(f'==============================================================')
+
+def main():
+    """Main function to parse arguments and display page state."""
+    parser = argparse.ArgumentParser(description=DESC, formatter_class=argparse.RawTextHelpFormatter)
+    parser.add_argument('pid', metavar='PID', type=int, help='Target process ID (PID)')
+    parser.add_argument('vaddr', metavar='VADDR', type=str, help='Target virtual address in hexadecimal format (e.g., 0x7fff1234abcd)')
+    args = parser.parse_args()
+
+    try:
+        vaddr = int(args.vaddr, 16)
+    except ValueError:
+        print(f"Error: Invalid virtual address format: {args.vaddr}")
+        return
+
+    task = find_task(args.pid)
+    mm = task.mm
+    page = follow_page(mm, vaddr)
+
+    if page:
+        show_page_state(page, vaddr, mm, args.pid, task)
+    else:
+        print(f"Address {hex(vaddr)} is not mapped.")
+
+if __name__ == "__main__":
+    main()
+
-- 
2.25.1


