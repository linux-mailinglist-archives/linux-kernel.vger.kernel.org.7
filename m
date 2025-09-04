Return-Path: <linux-kernel+bounces-801782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639BAB449CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DA13BF8AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C272E8B87;
	Thu,  4 Sep 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZNhbHD5"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE692EB874
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025551; cv=none; b=Pd4LjEDoUA/7+k6f0Rj6fxesWpAp4MLx2Bp3l1maURrTzmUu7Kmfv8DM6SlRQ+XGq8en69DaUN4uA9zYdwmnle9YMA1pSs+1ewg3p/2SozQmng/VfSTsbGyHK9wYwKfzziqa6cx7zQryrs6Zu0aOQL91LrEBcAI7uvkf1RFTFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025551; c=relaxed/simple;
	bh=P0eL7lErTS8v56iUyRusaVLI0YisFizXJuWjCzEPVZw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qDqDt15evGH6QmvuZ5zc/dKo7hAcXWkU8GCYjlchM/BmACB5MtAbEIJJBo/wAXdKPh6SH4I1vHkMaTnxRQL+AvAi1GR2rWC9eXdRmRDTaJhYRZcqkaJX8d/EJOIbmuA0C2z03/CkHaz68PBJVPi6shVXI8DifJZjy2CrslbYHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZNhbHD5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b52047b3f1dso698639a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757025550; x=1757630350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kW9rn2v1iSXbjmMoTXUPRQjjdzpOebvUQxrfx5dfUSk=;
        b=OZNhbHD5U6Ht5AUONGMOWB9Dn3WEhFuXPM2rS77rAtFPjZjqZJm5IBN/Z0iuaG4tbL
         B+rsDCPa/8M9J/gwnFiIOsNzZzY44ZS+oeHwdQg+lEFBcHBDrIAPmaF9QLMBgrsadmtV
         6ylFUNiHC5eZE4Mhyz0WpEKR9Y33jBsfZthFdlrw78nQ42hnA6klR/AVpACN5t42v7L9
         LgMbEimr29DfawJok8uF+NL79FDxI5qvnxZioBObkHrdHbeaSv+QR2ZStKJTzvtoHulC
         MBeh9o8KAYjActyo6cfFR99TGWtwup+/ooN7vRgNNLGqxi2KXN+pAfCYmSyhk4Z+nMej
         moiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757025550; x=1757630350;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kW9rn2v1iSXbjmMoTXUPRQjjdzpOebvUQxrfx5dfUSk=;
        b=CkmIP7Hn+tfVgZawUljAp3/YEya1it/gkYX3TegNRJRYwMmwawAn+gQvUb3hcDGs2D
         s3TdScy1VC36geqG/at0xmibwL6d/S6aBj8e+WdPr0IFH3Ig+7KqxhCKSofoFxxCC0DO
         sgd/0ji05qgbnWxMWXyGVT+pT0psWn/1f5asOZJI46LpKODVVxGFdBYCvV6R3fPo6cRx
         V3sEOWsO3SQ9cjUoBFop/quepDjfkWUetyP9qxu26T3/xzeo5cf+COnvNe9sfeknDjxq
         Dybt+CHW3zUkOsnR6lf5RAkFQ3sh1mlRaLZYbk6v3v9tYUbmIttmM1+fvG3Pg8f8RY3c
         ppTg==
X-Forwarded-Encrypted: i=1; AJvYcCUJN48BBMeXDGcA7JyDs0QyNdJAj0UwvhOnvT+wTDAnb4GReOZioUux2xQRGyCvIh7vAbJkLrHgQJ5Bxm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyapRbT+dGudT0KhtmVQeh5tAwYcWJHjxyhD9sTzTUrUDnj6vlq
	7C/7yUkGoyeMD6DCj6vFHx57L+Zvpq0mjMYzHGr6ceI9OtkTu6pTxBb8a/ZWH/09ilp0uYhK6Yr
	pdypU34WmnqBqfL7lJ++z3IukYA==
X-Google-Smtp-Source: AGHT+IFFdPHEWVThnXTu0FfDT+ZcMytzRTpeJbytNNp+zdJruRZkojIgvG5+XM/y/gqjNUmQ/JwMhGivtKhPGWPRWg==
X-Received: from pjbst4.prod.google.com ([2002:a17:90b:1fc4:b0:32b:5e07:ca10])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e889:b0:24c:da3b:7379 with SMTP id d9443c01a7336-24cda3b7654mr38292825ad.16.1757025549629;
 Thu, 04 Sep 2025 15:39:09 -0700 (PDT)
Date: Thu,  4 Sep 2025 22:38:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250904223850.884188-1-dylanbhatch@google.com>
Subject: [PATCH v2 0/6] unwind, arm64: add sframe unwinder for kernel
From: Dylan Hatch <dylanbhatch@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Kosina <jikos@kernel.org>
Cc: Dylan Hatch <dylanbhatch@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Weinan Liu <wnliu@google.com>, Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, 
	linux-toolchains@vger.kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, joe.lawrence@redhat.com, 
	Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

This patchset implements a generic kernel sframe-based [1] unwinder.
The main goal is to support reliable stacktraces on arm64.

On x86 orc unwinder provides reliable stacktraces. But arm64 misses the
required support from objtool: it cannot generate orc unwind tables for
arm64.

Currently, there's already a sframe unwinder proposed for userspace: [2].
Since the sframe unwind table algorithm is similar, these two proposals
could integrate common functionality in the future.

Currently, only GCC supports sframe.

These patches are based on v6.17-rc4 and are available on github [3].

Ref:
[1]: https://sourceware.org/binutils/docs/sframe-spec.html
[2]: https://lore.kernel.org/lkml/cover.1730150953.git.jpoimboe@kernel.org/
[3]: https://github.com/dylanbhatch/linux/tree/sframe-v2

Changes since v1:
https://lore.kernel.org/live-patching/20250127213310.2496133-1-wnliu@google.com/

 - Fixed detection of sframe support in compiler (Josh, Jens)
 - Adapt latest sframe v2 header definition from userspace patch series
   (Josh)
 - Folded together unwinder/stacktrace patches (Prasanna)
 - Fix "orphan section" warnings for .init.sframe sections (Puranjay,
   Indu, Josh)
 - Build VDSO without sframe (Dylan)
 - Added support for modules (Weinan)

Dylan Hatch (2):
  unwind: build kernel with sframe info
  unwind: add sframe v2 header

Weinan Liu (4):
  arm64: entry: add unwind info for various kernel entries
  unwind: Implement generic sframe unwinder library
  arm64/module, unwind: Add sframe support for modules.
  unwind: arm64: Add reliable stacktrace with sframe unwinder.

 Makefile                                   |   8 +
 arch/Kconfig                               |   6 +
 arch/arm64/Kconfig.debug                   |  10 +
 arch/arm64/include/asm/module.h            |   6 +
 arch/arm64/include/asm/stacktrace/common.h |   6 +
 arch/arm64/kernel/entry.S                  |  10 +
 arch/arm64/kernel/module.c                 |   5 +
 arch/arm64/kernel/setup.c                  |   2 +
 arch/arm64/kernel/stacktrace.c             | 102 +++++++++
 arch/arm64/kernel/vdso/Makefile            |   2 +-
 include/asm-generic/vmlinux.lds.h          |  15 ++
 include/linux/sframe_lookup.h              |  45 ++++
 kernel/Makefile                            |   1 +
 kernel/sframe.h                            |  75 +++++++
 kernel/sframe_lookup.c                     | 232 +++++++++++++++++++++
 15 files changed, 524 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/sframe_lookup.h
 create mode 100644 kernel/sframe.h
 create mode 100644 kernel/sframe_lookup.c

-- 
2.51.0.355.g5224444f11-goog


