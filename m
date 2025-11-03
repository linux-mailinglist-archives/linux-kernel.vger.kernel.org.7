Return-Path: <linux-kernel+bounces-882265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64715C2A062
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 05:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8713B226E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 04:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA832874E4;
	Mon,  3 Nov 2025 04:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV5Jrjg0"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126F2194AD7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 04:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762143748; cv=none; b=hBdHECCZ9Z93yCJ2G8g1tbNYDmpQ5V1yHyRAG4ctfr3mjS+Bw75YTustykazZe7rORYZgPYDfDNb6bdtmf37fqE682868XpmgPvwIEoMdULJ1AWeulvt94eWScvUkDfXE14SPucGCkFYiOpBcwrHiaaoAEBDoIZBLNs56udh/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762143748; c=relaxed/simple;
	bh=Wp0YqUQPEviqmmkbi/pYLnED5MDjsk7hgrDq58Rcnzw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=C0HIbAD3unATZ/MiKUzaKUM+98J5pk0HCuCn3CWRfwP5AZn2Ft1Wgj4fUNNcUjnpa27Q03LnAEjzlGVz9kQvnLBV5u8YnQmye93z7oszV2jbSaVItWtsokBhrCUXDAFagn3wrbrhP0tjyBbBUtVKcq0AgU2qxWGmb1JXtrElgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nV5Jrjg0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso3894211b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 20:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762143746; x=1762748546; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GtX4Zx8eYkEUaLjJAs2y91CkJ8ZJkcph2iUxsNSff9w=;
        b=nV5Jrjg0yQ/RMuNDxszKTFzjQ1Mrj9kw9oYrK8f9VwzNp49BG+lRkDrd8qO9TE+OlJ
         bbc788TQKa1zQGbdLMXK38bRC4AIkCcTFz1IKOX4dv+c0G2APzFZLaLBaxbrPNeerhQ/
         liNfoIOi7sXwc/1NamhklIZ7RtbBtmlj+EeIloi1KUOqa2fLWfeB/r/COWsmBPBnPRQ+
         Dk50hKSl9uAQJk79ssPYj5P2LsPIqSmvNQnucreUoLjdmmosVUXddAiEBhCjrmFXTAqV
         2vi7J7CVrgJVX64YYM5puQn6k62vjm9b1N85vID3QlT1OnoFUy4rgIF5hRh4qXnBaZw1
         rNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762143746; x=1762748546;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtX4Zx8eYkEUaLjJAs2y91CkJ8ZJkcph2iUxsNSff9w=;
        b=rRTsWNZ0qWLyTfgvdK8wv2Hv41Fa8UTFerDMw4DkuYVZQFth0IexeEKENqrKqWWdeI
         gl8tLZ8FCgASoyNeOcp8smdLamRaHHEGAbjqOxSzcNK0gVqDWDsY7scJGXGfPTD0/Pz9
         KVYBG7DEIJwivig8FL4IM62u7M42ZJbNNF5hoJtVbZd4kRIPGUFUMGiaBw+UvMARCz/l
         XvbvMsDduAqtbosYgExo9SgzP505081uRN2CI6nWvkgoDQ4dm6UPtK7/SppVJ3h9rZE6
         LuDbtEQ5dv2OmV5NAbmjYOLmEEZB7YXmgjzV9R0vvUL9zMWo77uMoZsRBd/a94Y3Jcln
         XE1Q==
X-Gm-Message-State: AOJu0YzxWE4zpLFDqucSj/AqGtEAU3YuuMdd9+KbMPXoLNYi3n4kfB0q
	GaTsCjmva0qkedX17M4JZX7xNH7souSNq0lI1HVhMALxYt7fcSRf/J+c
X-Gm-Gg: ASbGncu11FAFZWI4ekIP8ebq9++xHzedU+RDgTI3bt4VOX6CfMCyUBvl5M+tfwPUnaq
	MXxPASi3ROZZBLBZTkvt9FSpGraFMo7qDfZ9ey9acZhqIkRxXEeWWKeJyAB97446Gvn7fo19bbS
	1fVeGmDJ5QcFAyzS5TVsFylDWi4vwEY+PXun3GRNGtpXPwVUc9NdtQahq8pnhIwwlon7KqBtgVI
	GqnivfIbG3TXs06zxTI6Z2DroUu9EbR9G/eDiyDuCcBUZhG74YWRaxo2J8iOXCqjpGJhZpRtLkI
	MyH0d9SpILF6SKFbDqUNPmnxyd/U4RgljF5kef8Lu909ifMm7v4x+1zo58cWvqPZ+Am+Josct6b
	4IRTS2mDVPN7W49wJBwVoX8iGtyRy64lBQhh8xl9sJ6qJi9YVI5Ws0umT/cqYZZ9weS7TX9irSc
	lMLfpW
X-Google-Smtp-Source: AGHT+IHW+th9vAZAQ8TsYm1Rlv2J9GsVInIpUlNn9Og+2NadtO3eVDznXrvxM3q5o+d1XL7VWWCEvQ==
X-Received: by 2002:a05:6300:210c:b0:334:8f45:8e99 with SMTP id adf61e73a8af0-348cc8e36a5mr14520233637.35.1762143746195;
        Sun, 02 Nov 2025 20:22:26 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3409288c7ebsm9357224a91.6.2025.11.02.20.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 20:22:25 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/02] scripts/gdb/mm: Add support for powerpc book3s64
In-Reply-To: <6f931a16-6d62-4002-938b-bd366715f602@siemens.com>
Date: Mon, 03 Nov 2025 09:49:16 +0530
Message-ID: <871pmf694r.ritesh.list@gmail.com>
References: <cc4af3fa0fcda2a52cbbab05463e0ad0561fd017.1756521755.git.ritesh.list@gmail.com> <9da03d8e78cd895666deb1aec7ec8318833f1b6a.1756521755.git.ritesh.list@gmail.com> <6f931a16-6d62-4002-938b-bd366715f602@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 30.08.25 05:45, Ritesh Harjani (IBM) wrote:
>> This adds page ops support to powerpc book3s64. Following operations are
>> now supported:
>> 
>> lx-pfn_to_kaddr -- PFN to kernel address
>> lx-pfn_to_page -- PFN to struct page
>> lx-page_address -- struct page to linear mapping address
>> lx-page_to_pfn -- struct page to PFN
>> lx-page_to_phys -- struct page to physical address
>> lx-virt_to_page -- virtual address to struct page
>> lx-virt_to_phys -- virtual address to physical address
>> 
>> lx-vmallocinfo -- Show vmallocinfo
>> lx-slabinfo -- Show slabinfo
>> 
>> e.g. Below showing lx-mmu_info command i.e.
>> On Radix:
>> (gdb) lx-mmu_info
>> MMU: Radix
>> 
>> On Hash:
>> (gdb) lx-mmu_info
>> MMU: Hash
>> 
>> e.g. Below shows that struct page pointers coming from vmemmap area i.e.
>> (gdb) p vmemmap
>> $5 = (struct page *) 0xc00c000000000000
>> 
>> (gdb) lx-pfn_to_page 0
>> pfn_to_page(0x0) = 0xc00c000000000000
>> 
>> (gdb) lx-pfn_to_page 1
>> pfn_to_page(0x0) = 0xc00c000000000040
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  scripts/gdb/linux/constants.py.in |   4 ++
>>  scripts/gdb/linux/mm.py           | 114 +++++++++++++++++++++++++++++-
>>  2 files changed, 116 insertions(+), 2 deletions(-)
>> 
>> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
>> index 154db10fe94a..97a731db6e89 100644
>> --- a/scripts/gdb/linux/constants.py.in
>> +++ b/scripts/gdb/linux/constants.py.in
>> @@ -153,6 +153,10 @@ if IS_BUILTIN(CONFIG_ARM64):
>>      LX_VALUE(CONFIG_PAGE_SHIFT)
>>      LX_VALUE(CONFIG_ARCH_FORCE_MAX_ORDER)
>>  LX_CONFIG(CONFIG_PPC_BOOK3S_64)
>> +if IS_BUILTIN(CONFIG_PPC_BOOK3S_64):
>> +    LX_VALUE(CONFIG_PAGE_OFFSET)
>> +    LX_VALUE(CONFIG_PAGE_SHIFT)
>> +    LX_VALUE(CONFIG_KERNEL_START)
>>  LX_CONFIG(CONFIG_SPARSEMEM)
>>  LX_CONFIG(CONFIG_SPARSEMEM_EXTREME)
>>  LX_CONFIG(CONFIG_SPARSEMEM_VMEMMAP)
>> diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
>> index 7571aebbe650..9e5b1632f910 100644
>> --- a/scripts/gdb/linux/mm.py
>> +++ b/scripts/gdb/linux/mm.py
>> @@ -24,10 +24,17 @@ class page_ops():
>>      def __init__(self):
>>          if not constants.LX_CONFIG_SPARSEMEM_VMEMMAP:
>>              raise gdb.GdbError('Only support CONFIG_SPARSEMEM_VMEMMAP now')
>> -        if constants.LX_CONFIG_ARM64 and utils.is_target_arch('aarch64'):
>> +
>> +        if utils.is_target_arch('aarch64'):
>> +            if not constants.LX_CONFIG_ARM64:
>
> This reorders the check, pulling the dynamic part before the static one
> - why? Not that this is run on every command, but at least
> initialization could slow down by some cycles (or more...).
>

Sure that make sense Jan, 
Let me fix that up for both aarch64 and powerpc in v2.
Since it's been sometime that I have looked at these patches,
let me go over them once again before I re-spin a v2.

-ritesh

>> +                raise gdb.GdbError('ARM64 page ops require CONFIG_ARM64')
>>              self.ops = aarch64_page_ops()
>> +        elif utils.is_target_arch('powerpc'):
>> +            if not constants.LX_CONFIG_PPC_BOOK3S_64:
>> +                raise gdb.GdbError('Only supported for Book3s_64')
>> +            self.ops = powerpc64_page_ops()
>>          else:
>> -            raise gdb.GdbError('Only support aarch64 now')
>> +            raise gdb.GdbError('Unsupported arch for page ops')
>> 
>>  class aarch64_page_ops():
>>      def __init__(self):
>> @@ -287,6 +294,109 @@ class aarch64_page_ops():
>>      def folio_address(self, folio):
>>          return self.page_address(folio['page'].address)
>> 
>> +
>> +class powerpc64_page_ops():
>> +    """powerpc64 minimal Virtual Memory operations
>> +    """
>> +
>> +    def __init__(self):
>> +        vmemmap_sym = gdb.parse_and_eval('vmemmap')
>> +        self.vmemmap = vmemmap_sym.cast(utils.get_page_type().pointer())
>> +
>> +        self.PAGE_SHIFT = constants.LX_CONFIG_PAGE_SHIFT
>> +        self.PAGE_OFFSET = constants.LX_CONFIG_PAGE_OFFSET
>> +        self.KERNEL_START = constants.LX_CONFIG_KERNEL_START
>> +
>> +        # These variables are common for both Hash and Radix so no
>> +        # need to explicitely check for MMU mode.
>> +        self.KERNEL_VIRT_START = gdb.parse_and_eval("__kernel_virt_start")
>> +        self.VMALLOC_START = gdb.parse_and_eval("__vmalloc_start")
>> +        self.VMALLOC_END = gdb.parse_and_eval("__vmalloc_end")
>> +        self.KERNEL_IO_START = gdb.parse_and_eval("__kernel_io_start")
>> +        self.KERNEL_IO_END = gdb.parse_and_eval("__kernel_io_end")
>> +        # KERN_MAP_SIZE can be calculated from below trick to avoid
>> +        # checking Hash 4k/64k pagesize
>> +        self.KERN_MAP_SIZE = self.KERNEL_IO_END - self.KERNEL_IO_START
>> +        self.VMEMMAP_START = gdb.parse_and_eval("vmemmap")
>> +        self.VMEMMAP_SIZE = self.KERN_MAP_SIZE
>> +        self.VMEMMAP_END = self.VMEMMAP_START + self.VMEMMAP_SIZE
>> +
>> +        if constants.LX_CONFIG_NUMA and constants.LX_CONFIG_NODES_SHIFT:
>> +            self.NODE_SHIFT = constants.LX_CONFIG_NODES_SHIFT
>> +        else:
>> +            self.NODE_SHIFT = 0
>> +        self.MAX_NUMNODES = 1 << self.NODE_SHIFT
>> +
>> +    def PFN_PHYS(self, pfn):
>> +        return pfn << self.PAGE_SHIFT
>> +
>> +    def PHYS_PFN(self, pfn):
>> +        return pfn >> self.PAGE_SHIFT
>> +
>> +    def __va(self, pa):
>> +        return pa | self.PAGE_OFFSET
>> +
>> +    def __pa(self, va):
>> +        return va & 0x0fffffffffffffff;
>> +
>> +    def pfn_to_page(self, pfn):
>> +        return (self.vmemmap + int(pfn)).cast(utils.get_page_type().pointer())
>> +
>> +    def page_to_pfn(self, page):
>> +        pagep = page.cast(utils.get_page_type().pointer())
>> +        return int(pagep - self.vmemmap)
>> +
>> +    def page_address(self, page):
>> +        pfn = self.page_to_pfn(page)
>> +        va = self.PAGE_OFFSET + (pfn << self.PAGE_SHIFT)
>> +        return va
>> +
>> +    def page_to_phys(self, page):
>> +        pfn = self.page_to_pfn(page)
>> +        return self.PFN_PHYS(pfn)
>> +
>> +    def phys_to_page(self, pa):
>> +        pfn = self.PHYS_PFN(pa)
>> +        return self.pfn_to_page(pfn)
>> +
>> +    def phys_to_virt(self, pa):
>> +        return self.__va(pa)
>> +
>> +    def virt_to_phys(self, va):
>> +        return self.__pa(va)
>> +
>> +    def virt_to_pfn(self, va):
>> +        return self.__pa(va) >> self.PAGE_SHIFT
>> +
>> +    def virt_to_page(self, va):
>> +        return self.pfn_to_page(self.virt_to_pfn(va))
>> +
>> +    def pfn_to_kaddr(self, pfn):
>> +        return self.__va(pfn << self.PAGE_SHIFT)
>> +
>> +    # powerpc does not use tags for KASAN. So simply return addr
>> +    def kasan_reset_tag(self, addr):
>> +        return addr
>> +
>> +class LxMmuInfo(gdb.Command):
>> +    """MMU Type for PowerPC Book3s64"""
>> +
>> +    def __init__(self):
>> +        super(LxMmuInfo, self).__init__("lx-mmu_info", gdb.COMMAND_USER)
>> +
>> +    def invoke(self, arg, from_tty):
>> +        if not constants.LX_CONFIG_PPC_BOOK3S_64:
>> +            raise gdb.GdbError("Only supported for Book3s_64")
>> +
>> +        lpcr = gdb.parse_and_eval("(unsigned long)$lpcr")
>> +        # Host Radix bit should be 1 in LPCR for Radix MMU
>> +        if (lpcr & 0x0000000000100000):
>> +            gdb.write("MMU: Radix\n")
>> +        else:
>> +            gdb.write("MMU: Hash\n")
>> +
>> +LxMmuInfo()
>> +
>>  class LxPFN2Page(gdb.Command):
>>      """PFN to struct page"""
>> 
>> --
>> 2.50.1
>> 
>
> Rest (including patch 1) looks good to me, though not looking deep into
> the architectural bits.
>
> Jan
>
> PS: Sorry for the late feedback.
>
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center

