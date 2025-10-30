Return-Path: <linux-kernel+bounces-878547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BE7C20F58
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 596DB4EB9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400073644AC;
	Thu, 30 Oct 2025 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y4Gl+/ND"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593E13777E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838484; cv=none; b=a+lQzM+UyWou/GldNj2o46whPhcTmwVs1oSAWoFCR94cJsou/U41t0Y5Wkfp9ogjzC8A2JRL9bmXT6OgoWHrnX3nCS9RhnhjmEbF59zQV9YwgEfH5/NbM5vHdMA37PgpTfQNPyjosPCglhm+JRJU7h4kNbOKRgVU9lE9ZZMZqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838484; c=relaxed/simple;
	bh=XDYYiEMJ6jX2Dj12ooGDEDPoCriz//Z+UWgQPJPyjGU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mhQ9pp7BnmGqjz6WB38nDJIPlxqjhpADK0dAwDCy3J5zmnLNfUqVIIQ+rLb74eG/E5jBQsgMz3tMJMFWBsUa0EzlBPJSeyup5ccqCtqmtn2UqEQxTfQ0HPJuSIcJGGNj0sbLwBfhzuwAzTrk+9mkY87h0M7Dw0gZW+hC1zOsLm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y4Gl+/ND; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-9435969137aso108416639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761838481; x=1762443281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lOQ1a3T7gC/w5kd3v0pW6TZTXp4rOowVPq9YOCsOHpA=;
        b=y4Gl+/ND4YsdHp9LHuddTOvkbRc3l3/5q+XM0l/0j9aCqIS9N4m1BNsOvR2k+KJ+Pi
         OTOzJxa8IWykvY+KVfS0KhPUJ27e0a2W4DD+U6VeFgngRbHTClInWNQbmXqu5PDAar8g
         S9AYZyfKp1oeM0VQNuf4rLrkqadoiR6l5h34Di2TJl8RGkYyZfRNtbGKYJRmFYhOolE/
         ZTbqSScrbc9NRFza1bqzA+4QSei1J01mNXqqRrK3GGGP2vFvlw3DAhOJjNGFbeUZkFzu
         fS4q5/sAFSm3vbUVoE9jETAg7Lw2ByQNAe3PAAzQ6+8eLAqXLC85kfJN+ss0KM9Vdgh7
         Oyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761838481; x=1762443281;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lOQ1a3T7gC/w5kd3v0pW6TZTXp4rOowVPq9YOCsOHpA=;
        b=o9T8i6Vgl+Ywv+Ay07iazrkfv/jlqrM/votuKyvIl/Fa2OXQE+FZdlHBkbop6wqeRQ
         3DcPAVzwOn2n9K/YCqykbNotfMxOnHt+rlvDtlj4iB2/lz0bjrbMaoAkDqmuS/An8nk0
         fc9rEcQBP6t9R1Oz1XE0nHefo2BASv+21shKjFv6FffDz++cMh1otVbBo3QNrfPPKyPt
         6OJyntR5SGPlSCRSqhmOinaYxwnh2PA1o1659s5vaWoz2DTkOCia2lwi6Kh0Ih50sbd9
         eiS4xwDqHHAf4ONmUbAeHfqC9JKRp2MY3dbQz+qvvMuNTFNE6pe0hZc1qN0AzZ2v6gJY
         pocA==
X-Forwarded-Encrypted: i=1; AJvYcCXLOy3NnAWBmBvtpyMBsRqTaytPgCCaE9WaAp6jcxRNHGhkhk+1k0GDE8xchSEp0FI8YtRZFN/kpOJ0VVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3xrKFT/n+l+8UBy1pLnfsNPAXdT9NqtOcw0kkY8CGZLFuAteR
	IkCpS21S1/M8OLhvP59DVWIDDq68M963gjF1jzwvlnPZoIO+kwNOPr4ropA32e/5MhyiS7rAKiy
	KhzU2yL2uegFumDea/x3tlAIaxIZj9D9e+laXXNDm
X-Gm-Gg: ASbGncsjVDx1173r9bX/6R5hRtTtXtY1g305hcauO+hbGKev1aAUgqtnxGqHGhxfrtu
	hQIENXMf1t4wQ4SRZAbfUeWo3D2+5v1fSz9RQJEaM5/BOmDdzBwYk8KTlCQMi6kp5rps9JyXBnX
	4ssrDj0wVboldFmzTT2KIIFtjwtXqKNZg+XspxXXVU4RN8vg09pNufJF+MMpCtlOrQ4FGHnJOaG
	G416dGrnSmfQB+i+UtEErWCrIV5eXiyxJ0486IXnRLjb9Dazv74L3cVPGOUn78/+I85miPdf4N5
	RAAtYKyONK6JHAYJ99o6AmdiFA==
X-Google-Smtp-Source: AGHT+IGFPRlDpealNzZLuy9JmQPH387+1gus/PsWzpptKjSHaGqJdBee+pNUHwsOg0QXZuj4dhYmuxNsskl/crdcTUg=
X-Received: by 2002:a05:6602:3402:b0:945:a9b0:8ea3 with SMTP id
 ca18e2360f4ac-948229aaff9mr35732839f.17.1761838480883; Thu, 30 Oct 2025
 08:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Big Sleep <big-sleep-vuln-reports@google.com>
Date: Thu, 30 Oct 2025 16:34:29 +0100
X-Gm-Features: AWmQ_blYmEEbMahW_s_9GinZYFD6xkjkmJzqf0dqZCN4XhCkUxtDPBt3m7zO2co
Message-ID: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
Subject: Oops in secretmem_fault()
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Hello Mike and Andrew,

we found a bug in secretmem_fault() - please see below for details!

--Google Big Sleep

## Bug Details

Unprivileged code can provoke a kernel Oops by exploiting a race
condition in the page fault handler for the `memfd_secret(2)`
feature. Through the race condition, there is a short time window in
which a newly allocated page can be missing from the direct map after
it is acquired, and when the allocating code attempts to access the
page in the direct map, it results in an unhandleable page fault Oops.

**We believe that the bug has no security impact.**

## Analysis

When a page fault occurs in a secret memory file created with
`memfd_secret(2)`, the kernel will allocate a new folio for it, mark
the underlying page as not-present in the direct map, and add it to
the file mapping.

If two tasks cause a fault in the same page concurrently, both could
end up allocating a folio and removing the page from the direct map,
but only one would succeed in adding the folio to the file
mapping. The task that failed undoes the effects of its attempt by (a)
freeing the folio again and (b) putting the page back into the direct
map. However, by doing these two operations in this order, the page
becomes available to the allocator again before it is placed back in
the direct mapping.

If another task attempts to allocate the page between (a) and (b), and
the kernel tries to access it via the direct map, it would result in a
supervisor not-present page fault.

The relevant code is in `secretmem_fault()` in `mm/secretmem.c`:

```
static vm_fault_t secretmem_fault(struct vm_fault *vmf)
{
    struct address_space *mapping = vmf->vma->vm_file->f_mapping;
    struct inode *inode = file_inode(vmf->vma->vm_file);
    pgoff_t offset = vmf->pgoff;
    gfp_t gfp = vmf->gfp_mask;
    unsigned long addr;
    struct folio *folio;
    vm_fault_t ret;
    int err;

    if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
        return vmf_error(-EINVAL);

    filemap_invalidate_lock_shared(mapping);

retry:
    folio = filemap_lock_folio(mapping, offset); // (0)
    if (IS_ERR(folio)) {
        folio = folio_alloc(gfp | __GFP_ZERO, 0);
        if (!folio) {
            ret = VM_FAULT_OOM;
            goto out;
        }

        err = set_direct_map_invalid_noflush(folio_page(folio, 0)); // (1)
        if (err) {
            folio_put(folio);
            ret = vmf_error(err);
            goto out;
        }

        __folio_mark_uptodate(folio);
        err = filemap_add_folio(mapping, folio, offset, gfp); // (2)
        if (unlikely(err)) {
            folio_put(folio); // (3)
            /*
             * If a split of large page was required, it
             * already happened when we marked the page invalid
             * which guarantees that this call won't fail
             */
            set_direct_map_default_noflush(folio_page(folio, 0)); // (4)
            if (err == -EEXIST)
                goto retry;

            ret = vmf_error(err);
            goto out;
        }

        addr = (unsigned long)folio_address(folio);
        flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
    }

    vmf->page = folio_file_page(folio, vmf->pgoff);
    ret = VM_FAULT_LOCKED;

out:
    filemap_invalidate_unlock_shared(mapping);
    return ret;
}
```

When two tasks cause a page fault concurrently in the same page for
the first time, the call to `filemap_lock_folio()` (0) will return an
error, so both tasks will enter the conditional. Both tasks will call
`folio_alloc()` and `set_direct_map_invalid_noflush(folio_page(folio,
0));` to remove the page from the direct map (1).

Only one task will succeed in the call to `filemap_add_folio(mapping,
folio, offset, gfp);` (2), while the other will get `-EEXIST`.

The failing task then calls `folio_put(folio)` to free the folio (3),
making the underlying page available for allocation. Immediately
after, the code calls `set_direct_map_default_noflush()` to mark the
page as present in the direct map (4), but at this point the page
could have been allocated elsewhere. The code should not use the folio
after the call to `folio_put(folio)` in (3).

## Affected Versions

The issue has been successfully reproduced in the following Linux
versions:

* v5.15.195 (longterm)
* v6.17.6 (stable)

When spot-checking the versions in between, we were also able to
reproduce the problem.

## Reproduction

Our reproducer is written for x86_64.

### Reproducer Code

We can reproduce the bug with the following self-contained C++
program:

```
#include <err.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#include <atomic>
#include <barrier>
#include <thread>
#include <vector>

#ifndef SYS_memfd_secret
#define SYS_memfd_secret 447
#endif

static int memfd_secret_syscall(unsigned int flags) {
  return syscall(SYS_memfd_secret, flags);
}

constexpr size_t kPageSz = 4096;
constexpr size_t kMemFdSz = kPageSz * 1;
constexpr size_t kNumIters = 10000000;
constexpr size_t kNumThreads = 2;
constexpr size_t kMmapSz = kPageSz * 512 * 512 * 5;
constexpr size_t kAccessStep = kPageSz * 512;
constexpr size_t kNumMappers = 1;

int main(void) {
  std::atomic<bool> should_stop = false;

  std::vector<std::thread> mappers;
  std::atomic<size_t> bw = kNumThreads;

  for (size_t i = 0; i < kNumMappers; i++) {
    mappers.emplace_back([&should_stop]() {
      while (!should_stop.load()) {
        void* addr = mmap(nullptr, kMmapSz, PROT_READ | PROT_WRITE,
                          MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        if (addr == MAP_FAILED) {
          err(EXIT_FAILURE, "mmap");
        }

        uintptr_t mapping = reinterpret_cast<uintptr_t>(addr);
        for (size_t target = mapping; target < mapping + kMmapSz;
             target += kAccessStep) {
          __asm__ volatile("movl $1, (%0)" ::"r"(target));
        }

        munmap(addr, kMmapSz);
      }
    });
  };

  size_t last = 1;
  for (size_t i = 0; i < kNumIters; ++i) {
    if (i >= last * 2) {
      last = i;
      fprintf(stderr, "Iteration %zu\n", i);
    }

    int fd = memfd_secret_syscall(0);
    if (fd == -1) {
      err(EXIT_FAILURE, "memfd_secret");
    }

    if (ftruncate(fd, kMemFdSz) == -1) {
      err(EXIT_FAILURE, "ftruncate");
    }
    void* addr =
        mmap(nullptr, kMemFdSz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (addr == MAP_FAILED) {
      err(EXIT_FAILURE, "mmap");
    }

    std::vector<std::thread> threads;
    uintptr_t target = reinterpret_cast<uintptr_t>(addr);

    for (size_t i = 0; i < kNumThreads; i++) {
      threads.emplace_back([&bw, target]() {
        bw--;
        while (bw.load() != 0) {
          __asm__ volatile("nop");
        }
        __asm__ volatile("movl $1, (%0)" ::"r"(target));
      });
    }

    for (auto& thread : threads) {
      thread.join();
    }
    bw = kNumThreads;

    munmap(addr, kMemFdSz);
    close(fd);
  }

  should_stop = true;
  for (auto& mapper : mappers) {
    mapper.join();
  }

  return 0;
}
```

### Build Instructions

#### Reproducer

The reproducer program can be built using C++20:

```
$ CXX=clang++ CXXFLAGS=--std=c++20 make repro
```

#### *Kernel*

To make the race condition easier to reproduce, we add two
`mdelay(100)` calls in `secretmem_fault()`:

* One `mdelay()` before the call to `filemap_add_folio()` to simplify
  the race condition between the two faulting tasks.
* The other `mdelay()` before `set_direct_map_default_noflush()` to
  simplify the race condition between the task in the error case and
  another task that allocates memory.

We build Linux with a default KVM guest configuration, with
`CONFIG_PREEMPT`:

```
make defconfig kvm_guest.config
echo CONFIG_PREEMPT=y >> .config
make olddefconfig
make bzImage
```

### Command

#### Kernel

We ran the test kernels in QEMU with the following invocation:

```
qemu-system-x86_64 -nographic -m 8G -smp 4 -net nic,model=e1000
-enable-kvm -append "root=/dev/sda1 kernel.sysrq=0 console=ttyS0
selinux=0 secretmem.enable=y" -action
"reboot=shutdown,shutdown=poweroff" -kernel "${BZIMAGE}" -snapshot
-hda ${HOME}/rootdisk.qcow2 -net "user,hostfwd=tcp::10022-:22"
```

The root disk is a simple Syzkaller-like image.

#### Userspace

From within the booted kernel, run the reproducer as an unprivileged
user:

```
$ ./repro
```

### Crash Report

Note: The crash happens when another task attempts to allocate and
access the page. It is hard to control which exact task that will be,
so the crashes can look different.

```
[   18.126690] BUG: unable to handle page fault for address: ffff9a3d060de000
[   18.128071] #PF: supervisor write access in kernel mode
[   18.129101] #PF: error_code(0x0002) - not-present page
[   18.130117] PGD 1b7c01067 P4D 1b7c01067 PUD 23ffff067 PMD 1061a8063
PTE 800ffffef9f21020
[   18.131714] Oops: Oops: 0002 [#1] SMP NOPTI
[   18.132550] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted
6.17.6-00001-g40e6d463b4d0 #2 PREEMPT(full)
[   18.134417] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   18.136358] RIP: 0010:ioread32_rep+0x44/0x60
[   18.137234] Code: 96 04 8b 10 89 16 48 83 c6 04 48 39 ce 75 f3 c3
cc cc cc cc c3 cc cc cc cc 48 81 ff 00 00 01 00 76 0f 48 89 d1 48 89
f7 89 c2 <f3> 6d c3 cc cc f
[   18.140937] RSP: 0018:ffffa61780140e10 EFLAGS: 00010002
[   18.141965] RAX: 0000000000010170 RBX: 0000000000000008 RCX: 0000000000000002
[   18.143363] RDX: 0000000000010170 RSI: ffff9a3d060de000 RDI: ffff9a3d060de000
[   18.144765] RBP: ffff9a3d060de000 R08: 0000000000000008 R09: ffff9a3d01298130
[   18.146179] R10: ffff9a3d002fbb00 R11: ffffa61780140ff8 R12: 0000000000010170
[   18.147607] R13: 0000000000000000 R14: 0000000000000008 R15: ffff9a3d01298130
[   18.148794] FS:  0000000000000000(0000) GS:ffff9a3e81469000(0000)
knlGS:0000000000000000
[   18.150053] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.150957] CR2: ffff9a3d060de000 CR3: 0000000101aa7000 CR4: 00000000000006f0
[   18.152095] Call Trace:
[   18.152515]  <IRQ>
[   18.152842]  ata_sff_data_xfer32+0x88/0x170
[   18.153518]  ata_sff_hsm_move+0x466/0x9b0
[   18.154146]  __ata_sff_port_intr+0x94/0x150
[   18.154817]  ata_bmdma_port_intr+0x33/0x190
[   18.155490]  ata_bmdma_interrupt+0xcc/0x1e0
[   18.156144]  __handle_irq_event_percpu+0x45/0x1a0
[   18.156909]  handle_irq_event+0x33/0x80
[   18.157536]  handle_edge_irq+0xc2/0x1b0
[   18.158139]  __common_interrupt+0x40/0xd0
[   18.158785]  common_interrupt+0x7a/0x90
[   18.159436]  </IRQ>
[   18.159788]  <TASK>
[   18.160140]  asm_common_interrupt+0x26/0x40
[   18.160836] RIP: 0010:pv_native_safe_halt+0xf/0x20
[   18.161612] Code: 11 86 00 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d e5 62 1e
00 fb f4 <c3> cc cc cc cc 0
[   18.164562] RSP: 0018:ffffa617800b3ee0 EFLAGS: 00000206
[   18.165396] RAX: ffff9a3e81469000 RBX: ffff9a3d002fbb00 RCX: 0000000433dd2480
[   18.166541] RDX: 4000000000000000 RSI: 0000000000000002 RDI: 000000000000a7c4
[   18.167684] RBP: 0000000000000003 R08: 000000000000a7c4 R09: 0000000433dd2480
[   18.168804] R10: 0000000433dd2480 R11: ffff9a3d001f5900 R12: 0000000000000000
[   18.169930] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   18.171051]  default_idle+0x9/0x10
[   18.171617]  default_idle_call+0x2b/0x100
[   18.172268]  do_idle+0x1ca/0x230
[   18.172792]  cpu_startup_entry+0x24/0x30
[   18.173432]  start_secondary+0xf3/0x100
[   18.174049]  common_startup_64+0x13e/0x148
[   18.174717]  </TASK>
[   18.175081] Modules linked in:
[   18.175597] CR2: ffff9a3d060de000
[   18.176132] ---[ end trace 0000000000000000 ]---
[   18.176888] RIP: 0010:ioread32_rep+0x44/0x60
[   18.177589] Code: 96 04 8b 10 89 16 48 83 c6 04 48 39 ce 75 f3 c3
cc cc cc cc c3 cc cc cc cc 48 81 ff 00 00 01 00 76 0f 48 89 d1 48 89
f7 89 c2 <f3> 6d c3 cc cc f
[   18.180884] RSP: 0018:ffffa61780140e10 EFLAGS: 00010002
[   18.181911] RAX: 0000000000010170 RBX: 0000000000000008 RCX: 0000000000000002
[   18.183446] RDX: 0000000000010170 RSI: ffff9a3d060de000 RDI: ffff9a3d060de000
[   18.184862] RBP: ffff9a3d060de000 R08: 0000000000000008 R09: ffff9a3d01298130
[   18.186309] R10: ffff9a3d002fbb00 R11: ffffa61780140ff8 R12: 0000000000010170
[   18.187741] R13: 0000000000000000 R14: 0000000000000008 R15: ffff9a3d01298130
[   18.189172] FS:  0000000000000000(0000) GS:ffff9a3e81469000(0000)
knlGS:0000000000000000
[   18.190804] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.191791] CR2: ffff9a3d060de000 CR3: 0000000101aa7000 CR4: 00000000000006f0
[   18.193164] Kernel panic - not syncing: Fatal exception in interrupt
[   18.194272] Kernel Offset: 0x33200000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   18.195998] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---
```

## Reporter Credit

Google Big Sleep

## Disclosure Policy

Our assessment concluded that this finding has NO security
impact. Therefore, we are NOT applying a disclosure deadline to this
report.

For more information, visit
[https://goo.gle/bigsleep](https://goo.gle/bigsleep)

