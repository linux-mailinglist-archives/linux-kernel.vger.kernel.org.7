Return-Path: <linux-kernel+bounces-841324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ECABB7096
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02B864EC7E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ADD1F8722;
	Fri,  3 Oct 2025 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3RH/0e//"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7301A256E
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498742; cv=none; b=BfyoGdVewalnd9XOSKoDy4DL2OFiVGlScfMAAsA1XZHhemUmbphdNYjm8zP/LHb9fq7ONV9ndux586UvqvlSdjvX97/rfvxr999cer0v7IAaFyB85wzIb9w+jiis6xRuxxu/E5b3sLAP7ITHk1SEbklLqbR7UOgpEKQA9FMMkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498742; c=relaxed/simple;
	bh=1/upNGd3/Rvx5dFH/vSxKDt25qbMPJSALxSMj7VzRKI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qF55+6ANtgJhilJqUbzEeqRSYSIBpkmgcS57rxTJTkSPIO45QU1zZGsQkk5GCSqV1Z88d1XSoQHoetp/zciwg2s3DxUg8g2DkqogM+6tCC7S1WNQVuUqH8QZlI2PAF94mHORB03UKVmNdWYGMDgTvIT0gLZkBNBPGds1JJwhHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3RH/0e//; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3f4fbdf144dso990907f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498736; x=1760103536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0G6Ha8J9TYSfUKDQ9rZ1sUdGKiFDIA6bJFtQAksW0vk=;
        b=3RH/0e//90oqiJ3ROVAlZXC6yPtCeaczrGUFInvL2CKotHDyWIrmJoUQyVliVzMSkN
         afJQalsvWTnKUwNUCS59CzTwrWzOk1w8KRsRCpoVju1Zf4jKiWqJIuAxjUg8zf2qvH3P
         FPQfQUJ+/yYze1XHjQVfemnooXk04yycwPVU6Lc+OydrWhHHojaTmRTFeR5YQIGUClbS
         rRLeO2szjTqZ9gmYQB9jA/y28noaVxZudoIx/qM1woT01Vrp9ygYdW77KVhy1ffWibS/
         qhns2epvynLXE0CUf5mXDS98epAfeqXCimnHOjwtZB/UE/ipV+BiYbf5lT4oMU134l9B
         XjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498736; x=1760103536;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0G6Ha8J9TYSfUKDQ9rZ1sUdGKiFDIA6bJFtQAksW0vk=;
        b=WbG8/5WE+oz5G3xlJx4BhyHS193TRTzpxAPzwLfd0LC/ylsCIl1/D1xcp2GCSWz6AE
         U+S3puJS8TyyHXgnfuMdDfC8cbCYYi1ZrHymdICM1T1ylzjw2HeX4IdmVlMWjOYJbDiI
         wkJkD/xwSv7i75mA+ihbGuWBkDjrHQ4YlIGUQtBfmUuSQ3h5GZlhW++SkcbUpHI4Hql8
         TbZdEy1ywW1Sxjh1P2LQ+x9oeVyQawq74O7/9UGEI7BbjXBvpx/Eo9uZ5aJqZ+G/18jv
         Vps9luWA7J/q7U1+9r6HcBSfzgqc2gSx6LRaiHkgs2z+g6AtZtfFVJUTnWGLC7mJvYCY
         aTQw==
X-Forwarded-Encrypted: i=1; AJvYcCUZj6ip2C1yCCbNq4BzsphoULp3qNT/aZldmuZIdQiyTgTsuXiUc/uJwQKkNeWweY21zwfRpGTJzczPLxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysh0xk+pipaGjORR7KZX6LeC+Pu5P/jxdwypqTo5yk7ssKQgaw
	6eM7JhnIiPNYOBC74oljvYxzayfTJT7M6u5y3+4irnuzp1rjx4hUiOdWCQHquFboPhbG//Vh0T2
	O7Il720K7fZiZxGmhlbOeXQ==
X-Google-Smtp-Source: AGHT+IFAIVm71GpZTc1R/ZHqdkjF4gjmwFkgLyAabA2OJ8UT/2SUKouZ3IF9pX6HfZSGhtPOD9yNLv4TEggvK/0d
X-Received: from wmcq5.prod.google.com ([2002:a05:600c:c105:b0:46e:32e6:eb8f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:220b:b0:3eb:a237:a03c with SMTP id ffacd0b85a97d-42567193b3amr2055990f8f.51.1759498736448;
 Fri, 03 Oct 2025 06:38:56 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:37:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-1-vdonnefort@google.com>
Subject: [PATCH v7 00/28] Tracefs support for pKVM
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The growing set of features supported by the hypervisor in protected
mode necessitates debugging and profiling tools. Tracefs is the
ideal candidate for this task:

  * It is simple to use and to script.

  * It is supported by various tools, from the trace-cmd CLI to the
    Android web-based perfetto.

  * The ring-buffer, where are stored trace events consists of linked
    pages, making it an ideal structure for sharing between kernel and
    hypervisor.

This series first introduces a new generic way of creating remote events and
remote buffers. Then it adds support to the pKVM hypervisor.

1. ring-buffer
--------------

To setup the per-cpu ring-buffers, a new interface is created:

  ring_buffer_remote:	Describes what the kernel needs to know about the
			remote writer, that is, the set of pages forming the
			ring-buffer and a callback for the reader/head
			swapping (enables consuming read)

  ring_buffer_remote():	Creates a read-only ring-buffer from a
			ring_buffer_remote.

To keep the internals of `struct ring_buffer` in sync with the remote,
the meta-page is used. It was originally introduced to enable user-space
mapping of the ring-buffer [1]. In this case, the kernel is not the
producer anymore but the reader. The function to read that meta-page is:

  ring_buffer_poll_remote():
			Update `struct ring_buffer` based on the remote
			meta-page. Wake-up readers if necessary.

The kernel has to poll the meta-page to be notified of newly written
events.

2. Tracefs
----------

This series introduce a new trace_remote that does the link between
tracefs and the remote ring-buffer.

The interface is found in the remotes/ directory at the root of the
tracefs mount point. Each remote is like an instance and you'll find
there a subset of the regular Tracefs user-space interface:

   remotes/test
	|-- buffer_size_kb
	|-- events
	|   |-- enable
	|   |-- header_event
	|   |-- header_page
	|   `-- test
	|       `-- selftest
	|           |-- enable
	|           |-- format
	|           `-- id
	|-- per_cpu
	|   `-- cpu0
	|       |-- trace
	|       `-- trace_pipe
	|-- trace
	|-- trace_pipe
	|-- tracing_on

Behind the scenes, kernel/trace/trace_remote.c creates this tracefs
hierarchy without relying on kernel/trace/trace.c. This is due to
fundamental differences:

  * Remote tracing doesn't support trace_array's system-specific
    features (snapshots, tracers, etc.).

  * Logged event formats differ (e.g., no PID for remote events).

  * Buffer operations require specific remote interactions.

3. Simple Ring-Buffer
---------------------

As the current ring-buffer.c implementation has too many dependencies to
be used directly by the pKVM hypervisor. A new simple implementation is
created and can be found in kernel/trace/simple-ring-buffer.c.

This implementation is write-only and is used by both the pKVM
hypervisor and a trace_remote test module.

4. Events
---------

A new REMOTE_EVENT() macro is added to simplify the creation of events
on the kernel side. As remote tracing buffer are read only, only the
event structure and a way of printing must be declared. The prototype of
the macro is very similar to the well-known TRACE_EVENT()

 REMOTE_EVENT(my_event, id,
     RE_STRUCT(
         re_field(u64, foobar)
     ),
     RE_PRINTK("foobar=%lld", __entry->foobar)
     )
  )

5. pKVM
-------

The pKVM support simply creates a "hypervisor" trace_remote on the
kernel side and inherits from simple-ring-buffer.c on the hypervisor
side.

A new event macro is created HYP_EVENT() that is under the hood re-using
REMOTE_EVENT() (defined in the previous paragaph) as well as generate
hypervisor specific struct and trace_<event>() functions.

5. Limitations:
---------------

Non-consuming reading of the buffer isn't supported (i.e. cat trace ->
-EPERM) due to current the lack of support in the ring-buffer meta-page.

[1] https://tracingsummit.org/ts/2022/hypervisortracing/
[2] https://lore.kernel.org/all/20240510140435.3550353-1-vdonnefort@google.com/

Changes since v6

  - Add requires field to the selftest (Masami)
  - Use guard() for ring_buffer_poll_remote (Steven)
  - Rename ring_buffer_remote() to ring_buffer_alloc_remote() (Steven)
  - kerneldoc for trace_buffer_remote and simple_ring_buffer (Steven)
  - Validate trace_buffer_desc size in trace_remote_alloc_buffer
    (Steven)
  - Add non-consuming ring-buffer read (Steven)
  - Add spinning failsafe in simple_ring_buffer (Steven)
  - Range check for hyp_trace_desc::bpages_backing_* in hyp_trace_desc_validate()
  - unsigned int cpu in hyp_trace_desc_validate()
  - Fix event/format file
  - Add tests with an offline CPU
  - Add tests for non-consuming read
  - Add documentation
  - Rebase on 6.17

Changes since v5 (https://lore.kernel.org/all/20250516134031.661124-1-vdonnefort@google.com/)

  - Add tishift lib to the hyp (Aneesh)
  - Rebase on 6.17-rc2

Changes since v4 (https://lore.kernel.org/all/20250506164820.515876-1-vdonnefort@google.com/)

  - Extend meta-page with pages_touched and pages_lost
  - Create ring_buffer_types.h
  - Fix simple_ring_buffer build for 32-bits arch and x86
  - Try unload buffer on reset (+ test)
  - Minor renaming and comments

Changes since v3 (https://lore.kernel.org/all/20250224121353.98697-1-vdonnefort@google.com/)

  - Move tracefs support from kvm/hyp_trace.c into a generic trace_remote.c.
  - Move ring-buffer implementation from nvhe/trace.c into  a generic
    simple-ring-buffer.c
  - Rebase on 6.15-rc4.

Changes since v2 (https://lore.kernel.org/all/20250108114536.627715-1-vdonnefort@google.com/)

  - Fix ring-buffer remote reset
  - Fix fast-forward in rb_page_desc()
  - Refactor nvhe/trace.c
  - struct hyp_buffer_page more compact
  - Add a struct_len to trace_page_desc
  - Extend reset testing
  - Rebase on 6.14-rc3

Changes since v1 (https://lore.kernel.org/all/20240911093029.3279154-1-vdonnefort@google.com/)

  - Add 128-bits mult fallback in the unlikely event of an overflow. (John)
  - Fix ELF section sort.
  - __always_inline trace_* event macros.
  - Fix events/<event>/enable permissions.
  - Rename ring-buffer "writer" to "remote".
  - Rename CONFIG_PROTECTED_NVHE_TESTING to PKVM_SELFTEST to align with
    Quentin's upcoming selftest
  - Rebase on 6.13-rc3.

Changes since RFC (https://lore.kernel.org/all/20240805173234.3542917-1-vdonnefort@google.com/)

  - hypervisor trace clock:
     - mult/shift computed in hyp_trace.c. (John)
     - Update clock when it deviates from kernel boot clock. (John)
     - Add trace_clock file.
     - Separate patch for better readability.
  - Add a proper reset interface which does not need to teardown the
    tracing buffers. (Steven)
  - Return -EPERM on trace access. (Steven)
  - Add per-cpu trace file.
  - Automatically teardown and free the tracing buffer when it is empty,
    without readers and not currently tracing.
  - Show in buffer_size_kb if the buffer is loaded in the hypervisor or
    not.
  - Extend tests to cover reset and unload.
  - CC timekeeping folks on relevant patches (Marc)

Vincent Donnefort (28):
  ring-buffer: Add page statistics to the meta-page
  ring-buffer: Store bpage pointers into subbuf_ids
  ring-buffer: Introduce ring-buffer remotes
  ring-buffer: Add non-consuming read for ring-buffer remotes
  tracing: Introduce trace remotes
  tracing: Add reset to trace remotes
  tracing: Add non-consuming read to trace remotes
  tracing: Add init callback to trace remotes
  tracing: Add events to trace remotes
  tracing: Add events/ root files to trace remotes
  tracing: Add helpers to create trace remote events
  ring-buffer: Export buffer_data_page and macros
  tracing: Introduce simple_ring_buffer
  tracing: Add a trace remote module for testing
  tracing: selftests: Add trace remote tests
  Documentation: tracing: Add tracing remotes
  tracing: load/unload page callbacks for simple_ring_buffer
  tracing: Check for undefined symbols in simple_ring_buffer
  KVM: arm64: Support unaligned fixmap in the pKVM hyp
  KVM: arm64: Add clock support for the pKVM hyp
  KVM: arm64: Add tracing capability for the pKVM hyp
  KVM: arm64: Add trace remote for the pKVM hyp
  KVM: arm64: Sync boot clock with the pKVM hyp
  KVM: arm64: Add trace reset to the pKVM hyp
  KVM: arm64: Add event support to the pKVM hyp and trace remote
  KVM: arm64: Add hyp_enter/hyp_exit events to pKVM hyp
  KVM: arm64: Add selftest event support to pKVM hyp
  tracing: selftests: Add pKVM trace remote tests

 Documentation/trace/index.rst                 |   11 +
 Documentation/trace/remotes.rst               |   59 +
 arch/arm64/include/asm/kvm_asm.h              |    8 +
 arch/arm64/include/asm/kvm_define_hypevents.h |   21 +
 arch/arm64/include/asm/kvm_hyp.h              |    1 -
 arch/arm64/include/asm/kvm_hypevents.h        |   41 +
 arch/arm64/include/asm/kvm_hyptrace.h         |   26 +
 arch/arm64/kernel/image-vars.h                |    4 +
 arch/arm64/kernel/vmlinux.lds.S               |   18 +
 arch/arm64/kvm/Kconfig                        |   18 +
 arch/arm64/kvm/Makefile                       |    2 +
 arch/arm64/kvm/arm.c                          |    4 +
 arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h   |   13 +
 arch/arm64/kvm/hyp/include/nvhe/clock.h       |   16 +
 .../kvm/hyp/include/nvhe/define_events.h      |   21 +
 arch/arm64/kvm/hyp/include/nvhe/trace.h       |   60 +
 arch/arm64/kvm/hyp/nvhe/Makefile              |    3 +-
 arch/arm64/kvm/hyp/nvhe/clock.c               |   65 +
 arch/arm64/kvm/hyp/nvhe/events.c              |   36 +
 arch/arm64/kvm/hyp/nvhe/ffa.c                 |    2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |   86 ++
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |    6 +
 arch/arm64/kvm/hyp/nvhe/mm.c                  |    2 +-
 arch/arm64/kvm/hyp/nvhe/psci-relay.c          |    5 +-
 arch/arm64/kvm/hyp/nvhe/switch.c              |    5 +-
 arch/arm64/kvm/hyp/nvhe/trace.c               |  292 ++++
 arch/arm64/kvm/hyp_trace.c                    |  386 +++++
 arch/arm64/kvm/hyp_trace.h                    |   11 +
 include/linux/ring_buffer.h                   |   58 +
 include/linux/ring_buffer_types.h             |   41 +
 include/linux/simple_ring_buffer.h            |  120 ++
 include/linux/trace_remote.h                  |   92 ++
 include/linux/trace_remote_event.h            |   33 +
 include/trace/define_remote_events.h          |   73 +
 include/uapi/linux/trace_mmap.h               |    8 +-
 kernel/trace/Kconfig                          |   14 +
 kernel/trace/Makefile                         |   20 +
 kernel/trace/remote_test.c                    |  259 ++++
 kernel/trace/remote_test_events.h             |   10 +
 kernel/trace/ring_buffer.c                    |  356 ++++-
 kernel/trace/simple_ring_buffer.c             |  461 ++++++
 kernel/trace/trace.c                          |    2 +-
 kernel/trace/trace.h                          |    6 +
 kernel/trace/trace_remote.c                   | 1315 +++++++++++++++++
 .../ftrace/test.d/remotes/buffer_size.tc      |   25 +
 .../selftests/ftrace/test.d/remotes/functions |   88 ++
 .../ftrace/test.d/remotes/pkvm/buffer_size.tc |   11 +
 .../ftrace/test.d/remotes/pkvm/reset.tc       |   11 +
 .../ftrace/test.d/remotes/pkvm/trace.tc       |   11 +
 .../ftrace/test.d/remotes/pkvm/trace_pipe.tc  |   11 +
 .../ftrace/test.d/remotes/pkvm/unloading.tc   |   11 +
 .../selftests/ftrace/test.d/remotes/reset.tc  |   90 ++
 .../selftests/ftrace/test.d/remotes/trace.tc  |  127 ++
 .../ftrace/test.d/remotes/trace_pipe.tc       |  127 ++
 .../ftrace/test.d/remotes/unloading.tc        |   41 +
 55 files changed, 4581 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/trace/remotes.rst
 create mode 100644 arch/arm64/include/asm/kvm_define_hypevents.h
 create mode 100644 arch/arm64/include/asm/kvm_hypevents.h
 create mode 100644 arch/arm64/include/asm/kvm_hyptrace.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/arm-smccc.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/clock.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/define_events.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/trace.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/clock.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/events.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/trace.c
 create mode 100644 arch/arm64/kvm/hyp_trace.c
 create mode 100644 arch/arm64/kvm/hyp_trace.h
 create mode 100644 include/linux/ring_buffer_types.h
 create mode 100644 include/linux/simple_ring_buffer.h
 create mode 100644 include/linux/trace_remote.h
 create mode 100644 include/linux/trace_remote_event.h
 create mode 100644 include/trace/define_remote_events.h
 create mode 100644 kernel/trace/remote_test.c
 create mode 100644 kernel/trace/remote_test_events.h
 create mode 100644 kernel/trace/simple_ring_buffer.c
 create mode 100644 kernel/trace/trace_remote.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/buffer_size.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/functions
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/reset.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/trace.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/trace_pipe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/remotes/unloading.tc


base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
-- 
2.51.0.618.g983fd99d29-goog


