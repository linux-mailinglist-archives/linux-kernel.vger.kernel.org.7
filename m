Return-Path: <linux-kernel+bounces-758413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BB7B1CEA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F0F625338
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8E4230264;
	Wed,  6 Aug 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SyrMx7Fu"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90421D3E9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517103; cv=none; b=Qk6T1Vz5XeDPRT1yTMfAwq04HT91LugrW1VVD+sT8aZS0RH3vivcdCAxmT+YnXLehcMDxGCyhNsOn7tMRGZyqtus6iBUufYT3YHtWktdGiKA9KDoEsiGJCqO20wD4PunmkVdZz+75tek0XaUHmxg/gnTYL9FW4bwLoAVCAr6sCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517103; c=relaxed/simple;
	bh=5frXUPKwvi1kBByDKlIAmv1bwh2l2vmGgXuywfzjplQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hT/BY1/xSyI6RkHs04UrQMFml7vw5XT2p7VBjrf2ht++BSUJkSSNzKgGOaLq07HhTdiQXsqdhklxNWA99cnYKHSfS1O3ZT0MpAA+ul1gVlIqe6Yfefm25wDW6tV9F9b+c8O3gRZK/rDAo623cQeP4Wt+X5zjECeC1Ig06b3418c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SyrMx7Fu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bed3183ecso341027b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 14:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754517101; x=1755121901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RcbDY6E7AHxxcpUZnmF6WKFTQSN67azktbis/Tt+h9M=;
        b=SyrMx7Fu/Mt4H5gvLYCRDVyhav39vDEJ8mZLnnGCHW4XeBDnu1BegKiTbqQHsej65f
         vNiWYXLSw9ill3WrOqbucVDwjmd5iYCb7mkQgqR5fAOMZ2u7JuoVqXKTK6M7mO1JGUho
         jAumxaeDJgLkQLnj4RYheH9tqA18b6yJ7f3lGZeT5VxyzeO4w7ue7O8ZZ6nDZN3xbpvX
         L/GpkEgN33OgI2pgBxHwZTieJZUkoKyrh8H8iVN3QkedSf7uIT0q6BYyT+zQGh70VgSS
         84TBH0faBZ6ndxO4uPkGO3WUuZ6ip5FPs7VsRgj4IYk4jBwaejd0HTJBr0QHjEgOcEsf
         IoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517101; x=1755121901;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcbDY6E7AHxxcpUZnmF6WKFTQSN67azktbis/Tt+h9M=;
        b=O3f6eOp0OdL2eaq3W7Pd5Gl8ZT6n8BvI1aeYJnyLVAwXAJTKpjBBFfg2uZ+R5Cr//s
         HEuEBf8o0S/N5Map7iKSVhlN9xX37uPUjE7GhQpwrKjlYT09yVdVK6dAXDqmAU6o+CAw
         RF8oSlVhzCPOxhsfkx/0vVyv/CCn4DITLTtYwNrgCuqIF6LwyKll0LgSioZpotxF4c9q
         ZRawI12LP3Y14PfIs5MUnsQMGlLbPTlh+YPanQPoXKaUqL7SS+98xW7/9a+nMEaJ3UJm
         kDWyphH0moMmhr3apvuj7B6J6VveXy66qsusv5skLJx9Tgf1vKTE/DWI8yThGxGwZ3HU
         7RqA==
X-Forwarded-Encrypted: i=1; AJvYcCXzRxnHTbh9PbdGTF5b9+quHSgsPO6HswhcQexXU1pR0FDhcwGZhFQoH19xqvDuMtKUhDUR+t0RfY2fzMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyELDitv7dgp34JKGZqFM2WRICp3COc4ZLMTlWWhtuGGTb5mja9
	7Q96yjQ8i+UAAabFzHNK8+SzlTVU3zgf9ZurRtB9lrqgHPznPBSCIMZRrlPslUJjuazzpKSEBRL
	84QlGH1EbyUdOF3E6rVlnTQ==
X-Google-Smtp-Source: AGHT+IGZTcNWbHfyZ6CviAQHWKaYWfiQQ3nE28AYmXAW9ZEL2e8d/cgAu+5JNzJWgYaXY5asbvSRwmOVSMjJQ3PA
X-Received: from pfje15.prod.google.com ([2002:a05:6a00:cf:b0:76c:33e1:be00])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d4b:b0:740:9d7c:aeb9 with SMTP id d2e1a72fcca58-76c2aa63fc6mr5647871b3a.21.1754517101517;
 Wed, 06 Aug 2025 14:51:41 -0700 (PDT)
Date: Wed,  6 Aug 2025 21:51:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250806215133.43475-1-jthoughton@google.com>
Subject: [PATCH 0/2] KVM: Fault injection
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sean and Paolo,

I've prepared a patch that adds some fault injection points into KVM MMU
code to better catch bugs in the future. I put the documentation changes
in their own patch; I'm happy to squash them if you want.

The three points I've added here are:
1. Make KVM think that MMU invalidations happen more often.
2. Make KVM think that cmpxchg for TDP MMU is failing more often.
3. Make KVM think that the MMU lock is contended while iterating over
   TDP MMU SPTEs.

Unfortunately I haven't caught any bugs with this yet, but a while ago
we added something like this to consistently reproduce a bug in the
Direct MMU (the old, Google-internal implementation of TDP MMU).

I tried putting a WARN in when the TDP MMU cmpxchg fails to simulate a
bug when cmpxchg fails (this was the case for us with Direct MMU :)),
and running a few of the selftests, I get a few cmpxchg failures at the
beginning of the test, but even with several vCPUs, they only appear at
the beginning of the test. With fault injection, we can get them
constantly, exposing more code paths to cmpxchg failures.

It would be really great if this could be hooked into syzkaller for
better coverage; not sure what's needed for that.

Also if you have any ideas for what other fault injection points make
sense, I'd be happy to add them.

Please let me know what you think. Thanks!

This patch is based on the tip of Linus's tree.

James Houghton (2):
  KVM: Add fault injection for some MMU operations
  Documentation: fault-injection: Add entries for KVM fault injection
    points

 .../fault-injection/fault-injection.rst       | 12 +++++++
 arch/x86/kvm/Makefile                         |  1 +
 arch/x86/kvm/debugfs.c                        |  6 ++++
 arch/x86/kvm/mmu/fault_injection.c            | 36 +++++++++++++++++++
 arch/x86/kvm/mmu/fault_injection.h            | 31 ++++++++++++++++
 arch/x86/kvm/mmu/mmu.c                        |  1 +
 arch/x86/kvm/mmu/tdp_mmu.c                    | 10 ++++--
 include/linux/kvm_host.h                      | 19 ++++++++--
 lib/Kconfig.debug                             |  8 +++++
 virt/kvm/kvm_main.c                           | 25 +++++++++++++
 10 files changed, 143 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/kvm/mmu/fault_injection.c
 create mode 100644 arch/x86/kvm/mmu/fault_injection.h


base-commit: cca7a0aae8958c9b1cd14116cb8b2f22ace2205e
-- 
2.50.1.703.g449372360f-goog


