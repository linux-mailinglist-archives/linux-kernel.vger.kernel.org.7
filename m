Return-Path: <linux-kernel+bounces-829242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C77B96987
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1114D321DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C335314EC73;
	Tue, 23 Sep 2025 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GmVbvcXo"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1E17A5BE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641512; cv=none; b=qYzs8tVQqZU/zCXUsleyELp7j+W1SowzuoWoVV3brFBySMgs82L9SeoHFY5uv6w0levcNiXWJeHII3ZbzHvVJxV40fW2nb9SGLsu/5kAP+WwBDvbRStHVm76Q1twHVxcbwOrafGJ4OLvTqr42Es0x9tOkb7qToU03NNnxjl6ShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641512; c=relaxed/simple;
	bh=AfCy2+qXpIdgAjyEf8W/MT84uNPgynKpd69fs3+rXog=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DeJCTvnSpnRx1snxqP+4uk1CMRQUpUji/p/UQRhHBTW9jEt1oIRimNjFXDhZFX0A26p+ahBubo/cYN/9pkNmEcESeHGu+aJlj6Lz+V6fkXlRn2EgofFfPGIhfmWUFSMz1Mc6iEgs2Jhfh8jqBnft1mXZMca/d7Pl/GSZIVEdrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GmVbvcXo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-854585036e8so43390485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758641509; x=1759246309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1/pL4gMqjvoi63r5rQsSjVmd4UTaaXC/BqJF4V3qsU8=;
        b=GmVbvcXoofnhmow+9CEvGMWObGHrMhUygbeTZ8GmjwgiIm0qHQ1upB8IFySofjZYLK
         XUWOazAnyUkk3wJEUNJ2Gnbp32BCmu4s+P5hu/zqeAyMgy86T5iVwPOka/dR+g0moCqA
         XY6Df0IYj46Qa/XUJGma51rlIRs6X9MFvRccZT65xn5u9b/f7KVpoRH0GWseSl4+gr7Q
         vEV4LOP7PYQ1/V6HaWfC9X+Revv6zVJmjIseVcRWFIJE48K0eMhYXZ8obzTTJ/Iasv5z
         Jouih0CUzJ9U+Q6jdCBZ7o6PltgMaXjt40twDIjysV1Kr6I7abBL/up2MWLSQ3WQEJP2
         SvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641509; x=1759246309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/pL4gMqjvoi63r5rQsSjVmd4UTaaXC/BqJF4V3qsU8=;
        b=XtznTdf6G7WMYVFAnak/sySUZ1XSA7UcRJaqgYrD+FfBJd/yYgnU2mw1U8Vx3f9jZy
         USwBMw37asJTl9KJx9xjWwVl939I/K5HVMEzFXNEpuZWa7/fW6Y00JAl0SkYulnxhCRK
         H01feDvmvDabKfi7CLX2jI6Dj2KkG7z4jVhu/WxIoSve9qk9agCUH3NQzukO9+KJH3zb
         SKMTDa7rDU/zlyrtXQmDPxYWr/PAXrVGFBRhjLm86pYuRpzn1HBSaTEe3mcSGOMRfWDG
         DBJqpbcRsq8EXz01xjXkGcG6zaAYrbaNL24K+EZsr7mANYuBYMmSlMTxvVfgMVuHS/Ty
         3Q3Q==
X-Gm-Message-State: AOJu0YxouJR40p+ulYVcs3toqfJBL+pZazpnpnY6exUAvCKDKdiMILiF
	iwM+cOXgabXAbWHHoef5cER6Bbhmp9pq9XLGfw/nDYqIcnxfeUtyBf+X9vGIlwJZqsKdYKQVvoH
	oiluNYpc=
X-Gm-Gg: ASbGnctx1gFxJm+15gnkDLUBzW4cVKq+HXvezbqf/QvAj4wJRoI/IdbicdhcFVAGF4b
	RSZJHXCTU0sJynekRDv1erhIbhIoRxm+4tR/7sySwyNLVTgtxsG6Uj2cvmncmGiLqOsGj/1Vkmy
	GvcyVMNMbpyEZvytxmorEcQNq2Uw1AxM0LCvJy6RYylpsGt2E/LgjynTGyWeq0d7l6u/E+rOuw3
	1YImMNlJkq8ydKa3wbIISg1JvacqFbhCB69YNvRucMjBnzYPvJ5G72E6NpheyuZnT70hmRFk8uM
	YNbB2Wy/6kljHAjLf6749JyYavaLujgKlHkLGj9sTsECqmaCo392GzsWnWYW9+nFOnaalQBW5+6
	USu+xT5HXfhABjb9UwZJeud8gxbumAw==
X-Google-Smtp-Source: AGHT+IHWo44cvtqIDFFoO8L5ZbU8zL6woO7jRnQq/RrEwierAruO8aIqKy6rwzQOjkFv6UGpGavZkg==
X-Received: by 2002:a05:620a:1712:b0:82b:5653:76bc with SMTP id af79cd13be357-8516ed3134bmr337910685a.31.1758641508272;
        Tue, 23 Sep 2025 08:31:48 -0700 (PDT)
Received: from localhost ([79.173.157.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836278b77fasm1024047385a.23.2025.09.23.08.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:31:47 -0700 (PDT)
From: Fam Zheng <fam.zheng@bytedance.com>
To: linux-kernel@vger.kernel.org
Cc: Lukasz Luba <lukasz.luba@arm.com>,
	linyongting@bytedance.com,
	songmuchun@bytedance.com,
	satish.kumar@bytedance.com,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	yuanzhu@bytedance.com,
	Ingo Molnar <mingo@redhat.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	fam.zheng@bytedance.com,
	Zhang Rui <rui.zhang@intel.com>,
	fam@euphon.net,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	liangma@bytedance.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	guojinhui.liam@bytedance.com,
	linux-pm@vger.kernel.org,
	Thom Hughes <thom.hughes@bytedance.com>
Subject: [RFC 0/5] parker: PARtitioned KERnel
Date: Tue, 23 Sep 2025 15:31:41 +0000
Message-Id: <20250923153146.365015-1-fam.zheng@bytedance.com>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thom Hughes <thom.hughes@bytedance.com>

Hi all,

Parker is a proposed feature in linux for multiple linux kernels to run
simultaneously on single machine, without traditional kvm virtualisation. This
is achieved by partitioning the CPU cores, memory and devices for
partitioning-aware Linux kernel.

=== Side note begin ===

Coincidentally it has some similarities with [1] but the design and
implementations are totally separate.

While there are still many open questions and pending work in this direction, we
hope to share the idea and collect feedbacks from you!

=== Side note end ===

Each kernel instance can have the same image, but the initial kernel, or Boot
Kernel, controls the hardware allocation and partition. All other kernels are
secondary kernel, or Application Kernel, touch their own assigned CPU/Memory/IO
devices.

The primary use case in mind for parker is on the machines with high core
counts, where scalability concerns may arise. Once started, there is no
communication between kernel instances. In other words, they share nothing thus
improve scalability. Each kernel needs its own (PCIe) devices for IO, such as
NVMe or NICs.

Another possible use case is for different kernel instances to have different
performance tunings, CONFIG_ options, FDO/PGO according to the workload.

On the implementation side, parker exposes a kernfs directory interface, and
uses kexec to hot-load secondary kernel images to reserved memory regions.
Before creating partitions, the Boot Kernel will offline cpus, reserve physical
memory (using CMA), unbind PCI devices, etc. allocating those to the Application
Kernel so that it can safely use it.

In terms of fault isolation or security, all kernel instances share the same
domain, as there is no supervising mechanism. A kernel bug in any partition can
cause problems for the whole physical machine. This is a tradeoff for
low-overhead / low-complexity, but hope in the future we can take advantage of
some hardware mechanism to introduce some isolation.

Signed-off-by: Thom Hughes <thom.hughes@bytedance.com>
Signed-off-by: Fam Zheng <fam.zheng@bytedance.com>

[1] https://lore.kernel.org/lkml/20250918222607.186488-1-xiyou.wangcong@gmail.com/

Thom Hughes (5):
  x86/boot/e820: Fix memmap to parse with 1 argument
  x86/smpboot: Export wakeup_secondary_cpu_via_init
  x86/parker: Introduce parker kerfs interface
  x86/parker: Add parker initialisation code
  x86/apic: Make Parker instance use physical APIC

 arch/x86/Kbuild                     |    3 +
 arch/x86/Kconfig                    |    2 +
 arch/x86/include/asm/smp.h          |    1 +
 arch/x86/kernel/apic/apic_flat_64.c |    3 +-
 arch/x86/kernel/e820.c              |    2 +-
 arch/x86/kernel/setup.c             |    4 +
 arch/x86/kernel/smpboot.c           |    2 +-
 arch/x86/parker/Kconfig             |    4 +
 arch/x86/parker/Makefile            |    3 +
 arch/x86/parker/Makefile-full       |    3 +
 arch/x86/parker/internal.h          |   54 ++
 arch/x86/parker/kernfs.c            | 1266 +++++++++++++++++++++++++++
 arch/x86/parker/setup.c             |  423 +++++++++
 arch/x86/parker/trampoline.S        |   55 ++
 arch/x86/parker/trampoline.h        |   10 +
 drivers/thermal/intel/therm_throt.c |    3 +
 include/linux/parker-bkup.h         |   22 +
 include/linux/parker.h              |   22 +
 include/uapi/linux/magic.h          |    1 +
 19 files changed, 1880 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/parker/Kconfig
 create mode 100644 arch/x86/parker/Makefile
 create mode 100644 arch/x86/parker/Makefile-full
 create mode 100644 arch/x86/parker/internal.h
 create mode 100644 arch/x86/parker/kernfs.c
 create mode 100644 arch/x86/parker/setup.c
 create mode 100644 arch/x86/parker/trampoline.S
 create mode 100644 arch/x86/parker/trampoline.h
 create mode 100644 include/linux/parker-bkup.h
 create mode 100644 include/linux/parker.h

-- 
2.39.5


