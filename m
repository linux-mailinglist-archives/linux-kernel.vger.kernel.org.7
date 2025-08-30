Return-Path: <linux-kernel+bounces-792691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 704D1B3C7A3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 05:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8040C1C83AB5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 03:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A0D2773D8;
	Sat, 30 Aug 2025 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9gaZDc7"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084DD274FF1
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756525678; cv=none; b=mUPT5zhpcwlw2Nl0LPZBq0Pxx2kq350WJErSRjizk1nmxWSrEjd9H6kE8mtosj0UUI64JCFg1O038apWc1lIu/NUFZXMTgdl4AOH6xUfio1zd51nLXkQAbgyhbBuubVr1aIRSfGJpun5qO2lTl4xyew5TLNKVEJIgjlirnVPomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756525678; c=relaxed/simple;
	bh=bZV6OotTHCoW1aMD3LyGnZnF3D17wU0xKOonvcy8kl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c82kd0K7oz5IJJ3oYx1qYJ5pVCJpe/AENJNJ7bow9YpmIUNDYHn1VOQq9BYxzYj92toz3Hx7oOZs1rl+ozIKDjI1ENE1BA+ZBeNphhFJ/kn1vFhtHXsGtDjEbfB4r7oJXdIPoqazqqzfGAwgi6k/j7C0l9IlruuBBLq5TdZ/9VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9gaZDc7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-771f90a45easo2327757b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756525676; x=1757130476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HJzf+cbt3tnVGA5I6S0xUC2mgQggddjkpihkUdYn0w=;
        b=X9gaZDc7IFAPo+AfmXLfKBh8IQyJfhT3yg63BP4Wz3eiR4eJ3c6WTBxVZ88dHp3ndK
         4ETkBeNUJzRms/nf0O8vELiamOcapmI1aGXxwLjhRRyUHgwBk86U40hm/xyN4a8eTfeM
         7Y+C2AymJOG99+p4S1KRVgrIDKgjsxygtgqJdzYBpAycyIvlINZBEWcwiKidg0paEJak
         A68FmnES2Vt4y0+I622rX4CEP4HbqdxVzACPI45nhzea3p79rxUMB0qkOh+wRQ77p09X
         X9SA+/PHyQDXWFAKi0BIVjWGCE8wptnT++nyn34BeFz/pRVxQfsDEX+YNH/9gIO78BHI
         Dq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756525676; x=1757130476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HJzf+cbt3tnVGA5I6S0xUC2mgQggddjkpihkUdYn0w=;
        b=bHANx0AJkRwFIAzLUkywW+0L1pE5r+bABKNkyXTHflUSS7VXXSxW/oGECAxjtljJvB
         HxZLk7QRADU9ieni5GaFQA8wO5oN2CPTtvqdk6Y3wSCXeklr1If6o5BpXwSm9ErAXkTt
         9SvS715R1RssruP6xESkVFvaVdZvxmedbSU1NqbmiL2H9qrjxoDthZRyrxRJLGyBrRMM
         TBurw+g01ZuPzCx38TzJGK+3cm8rTqPlUEuJ2sgT8lEQtwq5uu1u6hEdVl0ZER6N4puo
         x/I4dT2g89Lz7CPFhAlQt494Os84ORQfFsFypViVgDmRuxZsHOQaO5kn7Y9BYDDgfo2Z
         snjQ==
X-Gm-Message-State: AOJu0Yz0er2ZbpPytZUB96j4GKPpZBt4OYjFXStRFz3U4NQlN0KWBPsG
	d11RDuxBHgVctsz+1Dbrd9a/cpZec1wbmcQHJ2oeH4sTIELvrz+MMN/apGzHIw==
X-Gm-Gg: ASbGncsdpFI2savZqKXTvLx8Kz2EldQaY6GHWzEAaDHHA8Ou/gBLOBwvkuyDO9DuTUX
	Tmyg6oSYG6oIwnJxqjkZ6oUc8zEOHt84dLpDqnUHIEh3Jnd/lGRNbNmGUofEYAwPB5G1aBxe7p9
	MNZiZUVfAgtyfIC2og37u3xmcTlsfNpHWyyKT0OiJN9vj/VTVthkFB5nSSr6xDPRtvQYAO+j7PI
	BAzRJ0lfN0gUT/T4pd9fcxr6En9UzFzi3ARdwgxcggAp6GwociNponM8bQ9kyYNncphKHevSM0b
	L0ze3a55sENPe/Yf/S/Pj5NxVRlC+AnnEOSow+uhFOOA7gquTdo1x3cfxL/v7Y2SfmDPfJnsOti
	D9B22XP8cAUlZB8tyN/Bfskz6Ow==
X-Google-Smtp-Source: AGHT+IHQqkzGpozoO/PUeN4PSh2M47+f064YNS2XPGekapyxTgNu5ZvriybhdEX/8K3++YzhEXgffg==
X-Received: by 2002:a05:6a00:928b:b0:76b:f2d9:c760 with SMTP id d2e1a72fcca58-7723e21a73cmr1040745b3a.7.1756525676100;
        Fri, 29 Aug 2025 20:47:56 -0700 (PDT)
Received: from dw-tp ([171.76.86.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4ba1d8sm3895377b3a.51.2025.08.29.20.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 20:47:55 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 02/02] scripts/gdb/mm: Add support for powerpc book3s64
Date: Sat, 30 Aug 2025 09:15:35 +0530
Message-ID: <9da03d8e78cd895666deb1aec7ec8318833f1b6a.1756521755.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cc4af3fa0fcda2a52cbbab05463e0ad0561fd017.1756521755.git.ritesh.list@gmail.com>
References: <cc4af3fa0fcda2a52cbbab05463e0ad0561fd017.1756521755.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds page ops support to powerpc book3s64. Following operations are
now supported:

lx-pfn_to_kaddr -- PFN to kernel address
lx-pfn_to_page -- PFN to struct page
lx-page_address -- struct page to linear mapping address
lx-page_to_pfn -- struct page to PFN
lx-page_to_phys -- struct page to physical address
lx-virt_to_page -- virtual address to struct page
lx-virt_to_phys -- virtual address to physical address

lx-vmallocinfo -- Show vmallocinfo
lx-slabinfo -- Show slabinfo

e.g. Below showing lx-mmu_info command i.e.
On Radix:
(gdb) lx-mmu_info
MMU: Radix

On Hash:
(gdb) lx-mmu_info
MMU: Hash

e.g. Below shows that struct page pointers coming from vmemmap area i.e.
(gdb) p vmemmap
$5 = (struct page *) 0xc00c000000000000

(gdb) lx-pfn_to_page 0
pfn_to_page(0x0) = 0xc00c000000000000

(gdb) lx-pfn_to_page 1
pfn_to_page(0x0) = 0xc00c000000000040

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 scripts/gdb/linux/constants.py.in |   4 ++
 scripts/gdb/linux/mm.py           | 114 +++++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 154db10fe94a..97a731db6e89 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -153,6 +153,10 @@ if IS_BUILTIN(CONFIG_ARM64):
     LX_VALUE(CONFIG_PAGE_SHIFT)
     LX_VALUE(CONFIG_ARCH_FORCE_MAX_ORDER)
 LX_CONFIG(CONFIG_PPC_BOOK3S_64)
+if IS_BUILTIN(CONFIG_PPC_BOOK3S_64):
+    LX_VALUE(CONFIG_PAGE_OFFSET)
+    LX_VALUE(CONFIG_PAGE_SHIFT)
+    LX_VALUE(CONFIG_KERNEL_START)
 LX_CONFIG(CONFIG_SPARSEMEM)
 LX_CONFIG(CONFIG_SPARSEMEM_EXTREME)
 LX_CONFIG(CONFIG_SPARSEMEM_VMEMMAP)
diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
index 7571aebbe650..9e5b1632f910 100644
--- a/scripts/gdb/linux/mm.py
+++ b/scripts/gdb/linux/mm.py
@@ -24,10 +24,17 @@ class page_ops():
     def __init__(self):
         if not constants.LX_CONFIG_SPARSEMEM_VMEMMAP:
             raise gdb.GdbError('Only support CONFIG_SPARSEMEM_VMEMMAP now')
-        if constants.LX_CONFIG_ARM64 and utils.is_target_arch('aarch64'):
+
+        if utils.is_target_arch('aarch64'):
+            if not constants.LX_CONFIG_ARM64:
+                raise gdb.GdbError('ARM64 page ops require CONFIG_ARM64')
             self.ops = aarch64_page_ops()
+        elif utils.is_target_arch('powerpc'):
+            if not constants.LX_CONFIG_PPC_BOOK3S_64:
+                raise gdb.GdbError('Only supported for Book3s_64')
+            self.ops = powerpc64_page_ops()
         else:
-            raise gdb.GdbError('Only support aarch64 now')
+            raise gdb.GdbError('Unsupported arch for page ops')

 class aarch64_page_ops():
     def __init__(self):
@@ -287,6 +294,109 @@ class aarch64_page_ops():
     def folio_address(self, folio):
         return self.page_address(folio['page'].address)

+
+class powerpc64_page_ops():
+    """powerpc64 minimal Virtual Memory operations
+    """
+
+    def __init__(self):
+        vmemmap_sym = gdb.parse_and_eval('vmemmap')
+        self.vmemmap = vmemmap_sym.cast(utils.get_page_type().pointer())
+
+        self.PAGE_SHIFT = constants.LX_CONFIG_PAGE_SHIFT
+        self.PAGE_OFFSET = constants.LX_CONFIG_PAGE_OFFSET
+        self.KERNEL_START = constants.LX_CONFIG_KERNEL_START
+
+        # These variables are common for both Hash and Radix so no
+        # need to explicitely check for MMU mode.
+        self.KERNEL_VIRT_START = gdb.parse_and_eval("__kernel_virt_start")
+        self.VMALLOC_START = gdb.parse_and_eval("__vmalloc_start")
+        self.VMALLOC_END = gdb.parse_and_eval("__vmalloc_end")
+        self.KERNEL_IO_START = gdb.parse_and_eval("__kernel_io_start")
+        self.KERNEL_IO_END = gdb.parse_and_eval("__kernel_io_end")
+        # KERN_MAP_SIZE can be calculated from below trick to avoid
+        # checking Hash 4k/64k pagesize
+        self.KERN_MAP_SIZE = self.KERNEL_IO_END - self.KERNEL_IO_START
+        self.VMEMMAP_START = gdb.parse_and_eval("vmemmap")
+        self.VMEMMAP_SIZE = self.KERN_MAP_SIZE
+        self.VMEMMAP_END = self.VMEMMAP_START + self.VMEMMAP_SIZE
+
+        if constants.LX_CONFIG_NUMA and constants.LX_CONFIG_NODES_SHIFT:
+            self.NODE_SHIFT = constants.LX_CONFIG_NODES_SHIFT
+        else:
+            self.NODE_SHIFT = 0
+        self.MAX_NUMNODES = 1 << self.NODE_SHIFT
+
+    def PFN_PHYS(self, pfn):
+        return pfn << self.PAGE_SHIFT
+
+    def PHYS_PFN(self, pfn):
+        return pfn >> self.PAGE_SHIFT
+
+    def __va(self, pa):
+        return pa | self.PAGE_OFFSET
+
+    def __pa(self, va):
+        return va & 0x0fffffffffffffff;
+
+    def pfn_to_page(self, pfn):
+        return (self.vmemmap + int(pfn)).cast(utils.get_page_type().pointer())
+
+    def page_to_pfn(self, page):
+        pagep = page.cast(utils.get_page_type().pointer())
+        return int(pagep - self.vmemmap)
+
+    def page_address(self, page):
+        pfn = self.page_to_pfn(page)
+        va = self.PAGE_OFFSET + (pfn << self.PAGE_SHIFT)
+        return va
+
+    def page_to_phys(self, page):
+        pfn = self.page_to_pfn(page)
+        return self.PFN_PHYS(pfn)
+
+    def phys_to_page(self, pa):
+        pfn = self.PHYS_PFN(pa)
+        return self.pfn_to_page(pfn)
+
+    def phys_to_virt(self, pa):
+        return self.__va(pa)
+
+    def virt_to_phys(self, va):
+        return self.__pa(va)
+
+    def virt_to_pfn(self, va):
+        return self.__pa(va) >> self.PAGE_SHIFT
+
+    def virt_to_page(self, va):
+        return self.pfn_to_page(self.virt_to_pfn(va))
+
+    def pfn_to_kaddr(self, pfn):
+        return self.__va(pfn << self.PAGE_SHIFT)
+
+    # powerpc does not use tags for KASAN. So simply return addr
+    def kasan_reset_tag(self, addr):
+        return addr
+
+class LxMmuInfo(gdb.Command):
+    """MMU Type for PowerPC Book3s64"""
+
+    def __init__(self):
+        super(LxMmuInfo, self).__init__("lx-mmu_info", gdb.COMMAND_USER)
+
+    def invoke(self, arg, from_tty):
+        if not constants.LX_CONFIG_PPC_BOOK3S_64:
+            raise gdb.GdbError("Only supported for Book3s_64")
+
+        lpcr = gdb.parse_and_eval("(unsigned long)$lpcr")
+        # Host Radix bit should be 1 in LPCR for Radix MMU
+        if (lpcr & 0x0000000000100000):
+            gdb.write("MMU: Radix\n")
+        else:
+            gdb.write("MMU: Hash\n")
+
+LxMmuInfo()
+
 class LxPFN2Page(gdb.Command):
     """PFN to struct page"""

--
2.50.1


