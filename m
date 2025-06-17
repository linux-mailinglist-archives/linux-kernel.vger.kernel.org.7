Return-Path: <linux-kernel+bounces-689427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD38EADC1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 07:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5559189617E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 05:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676FB28AAFE;
	Tue, 17 Jun 2025 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AVO+PWn2"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B0528399
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750138497; cv=none; b=mWr//AAjlOdyM2IPneeFO2nIaKjlPDnIJYFEnirO552hFby8l3edLsiBjhEZTL1Fng6S94IiTmEbFtRIg6ntg7tWcyaGReT7O5lJZVmoZNYzYnXLMUV4MoEMVn+eG7MUh3LhQ9B2oWmJb99H7fVjgxV37+6BFuJBBSUXynTUvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750138497; c=relaxed/simple;
	bh=y5Zj7llXD6onLMY3UGnfkAAtYDcPM2tenix2NZa86qI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aA2A8CVh3ztaCf0cPF9T3rUkx8acSoFioUUCCJy2C7+8BgNhRmVXTdVf9x3PNheeouXBBLZV+rD5YgYBGnMniYxkBJ/AqvO3/LLUi6aS+1gWR23jD3hZ7ez7/6GL6SQxq5i2sHGFAbFSeD5dx0yu7HQZNcnDuQsbwU/QX+deAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AVO+PWn2; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750138483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F+F/i0GG3dVaWoc6Zw5lkvRKM42zxYRYhgbTG6NPSyI=;
	b=AVO+PWn2MjSqlrTfqCn6GB6PWkM5olCb6tdA4kIqhcFmDEVN9HOP9316WkrHYjcqg4fAsW
	0csoLYXWDguChd6XilAEeX1vfFDjzyGcfaUPGdTvAv7DR0X3s2D4FcIUAekvs6HvnpzbH3
	vDisOewdHOnG2R2rw2OC/Oqo5ZNrdA0=
From: Hao Ge <hao.ge@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v4 0/1] mm: Restrict _shared_alloc_tag static definition to CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
Date: Tue, 17 Jun 2025 13:33:56 +0800
Message-Id: <cover.1750138121.git.gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Recently discovered this entry while checking kallsyms on ARM64:
ffff800083e509c0 D _shared_alloc_tag

If ARCH_NEEDS_WEAK_PER_CPU is not defined(it is only defined for
s390 and alpha architectures), there's no need to statically define
the percpu variable _shared_alloc_tag.

Therefore, we need to implement isolation for this purpose.

However, currently ARCH_NEEDS_WEAK_PER_CPU is a #define and
is enclosed within the #if defined(MODULE) conditional block.

When building the core kernel code for s390 or alpha architectures,
ARCH_NEEDS_WEAK_PER_CPU remains undefined (as it is gated
by #if defined(MODULE)). However, when building modules for these
architectures, the macro is explicitly defined.

Therefore, we remove all instances of ARCH_NEEDS_WEAK_PER_CPU from
the code and introduced CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU to
replace the relevant logic. We can now conditionally define the perpcu
variable _shared_alloc_tag based on CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU.
This allows architectures (such as s390/alpha) that require weak
definitions for percpu variables in modules to include the definition,
while others can omit it via compile-time exclusion.

The following version can be regarded as the most original version:
https://lore.kernel.org/all/20250529073537.563107-1-hao.ge@linux.dev/
But unfortunately, it caused build errors on s390.
Based on Suren's guidance and suggestions,
I've refined it into this patch series.
Many thanks to Suren for his patient instruction.

Verify:
     1. On Arm64:
        nm vmlinux | grep "_shared_alloc_tag",no output is returned.
     2. On S390:
        Compile tested.
        nm vmlinux | grep "_shared_alloc_tag"
        00000000015605b4 r __crc__shared_alloc_tag
        0000000001585fef r __kstrtab__shared_alloc_tag
        0000000001586897 r __kstrtabns__shared_alloc_tag
        00000000014f6548 r __ksymtab__shared_alloc_tag
        0000000001a8fa28 D _shared_alloc_tag
        nm net/ceph/libceph.ko | grep "_shared"
        U _shared_alloc_tag
     3. On alpha
        Compile tested.
        nm vmlinux | grep "_shared_alloc_tag"
        fffffc0000b080fa r __kstrtab__shared_alloc_tag
        fffffc0000b07ee7 r __kstrtabns__shared_alloc_tag
        fffffc0000adee98 r __ksymtab__shared_alloc_tag
        fffffc0000b83d38 D _shared_alloc_tag
        nm crypto/cryptomgr.ko | grep "_share"
        U _shared_alloc_tag

v4:
   Merge previous patches into a single patch.
   Remove all instances of ARCH_MODULE_NEEDS_WEAK_PER_CPU from v3
   and use CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU to
   replace the relevant logic.
   Replace CONFIG_ARCH_NEEDS_WEAK_PER_CPU with CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
   in v3, as weak percpu support is only required for modules ,making the name more
   semantically accurate.
   David, Mike, Matthew, Kent, Heiko and Suren have all provided valuable input.
   Thanks for this.

v3:
    Suren pointed out that patches 1-2 can be merged into a single patch
    in version 2. And the commit message for patch 3 can be made more
    concise.Make corresponding modifications based on the pointed-out
    issues and update the corresponding commit message.

v2:
    Heiko pointed out that when defining MODULE_NEEDS_WEAK_PER_CPU,
    the CONFIG_ARCH_NEEDS_WEAK_PER_CPU condition in the v1 version
    should be removed,as it is always true for s390 and alpha
    architectures.And He also pointed out that patches 2-4 need to
    be merged into one patch. Modify the code according to the suggestions
    and update the corresponding commit message

Hao Ge (1):
  mm/percpu: Conditionally define _shared_alloc_tag via
    CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU

 arch/alpha/Kconfig              | 1 +
 arch/alpha/include/asm/percpu.h | 5 ++---
 arch/s390/Kconfig               | 1 +
 arch/s390/include/asm/percpu.h  | 5 ++---
 include/linux/alloc_tag.h       | 6 +++---
 include/linux/percpu-defs.h     | 7 ++++---
 lib/alloc_tag.c                 | 2 ++
 mm/Kconfig                      | 7 +++++++
 8 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.25.1


