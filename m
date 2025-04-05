Return-Path: <linux-kernel+bounces-589481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E6DA7C6D1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 02:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C243B7D6D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 00:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA992F50;
	Sat,  5 Apr 2025 00:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbmowckC"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A11A36C
	for <linux-kernel@vger.kernel.org>; Sat,  5 Apr 2025 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743811847; cv=none; b=ori2AEDZFLiA+UqSWJp8QU7ZJpL4B1dQFA+WXGFyGVMl7CdIRghtQb2IQBYinULf2rCmxvhFtkheGG3+DURdk8gqOw7oeJTjQ6PfNy74UmQGW7n91nRNCV7PjQ6Zi1ghrQNZVemAkAHiNhFsJiMZ2UlkY9KpzbnPuLnglMHl7UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743811847; c=relaxed/simple;
	bh=9OLt6CxBIy6kqbClRlpyjmlyZ3nlZBIi/b6vLEkxDsk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SFRrs6vRyg5AqFhV33E4L6e/AcKLIXJ3HW4viBNZj6wTL+FgFf07eq6TWfx9VlnujIYK3d86RL7eWAFEmR2/vGSpteED2FEqEkI00VO8RQtIUEvBFwnOF1QkNdAjna4vh6spq1j1azw9BIaMBxR8dw0P5d7YyWl2bPvMUskWvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qbmowckC; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-8610d7ec4d3so468467239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 17:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743811844; x=1744416644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2DNvYO0bTfj7X+8PQ13cmGZGTNT4dkdJknnzMC9cIXk=;
        b=qbmowckCZVnv6vID2Wd1kKSBQ6IxjJUhQ+3TsMqsu5z9LhKAOxiphE/L3+sK3cMqKT
         EVgABvnXzUHDebplvyC4+TnY4WQPG3tGsBkP5lw04hLY2z7BKKkuPTsQGTprqK+R9I16
         lLSLrwqOF4bY0R/DnDin1y3/L/IZyZyLuqQKehM6Wr9jPG7OiHwczmB1sq+l5GipMZkt
         T5coN4Kh6Gn5tyrkhjmJbO9+FRsRpPa1Zzy86TbqmjBafeKGLIMsGqXkNcvP2oq9Tx8r
         Dvh+PAslSaw+sqQPbE70KthqqXQaZ3hNHhGjNMHcRX/azXDcwc2AawB0sIalftLGrnrt
         3coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743811844; x=1744416644;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DNvYO0bTfj7X+8PQ13cmGZGTNT4dkdJknnzMC9cIXk=;
        b=Zk++MVUAexCuyKu3fA9q8sf84AvCOzb/IIUcNUEfLheIK0nvibaE3zVAqdt3lMAvfW
         PD8SQMXPOoyUKGFnT+hN3Ehx9LiwqBVawP2rZ9rb/OHnM4DwDxX1Cr3oAh0PhkivxTF4
         fb5v56eCZTegDhqE0jYKckLY7Pwb+A8rft0OOMz1GLbpOL/LJFZFdGNl4acejuE1QlQ1
         QVVUpD7OcSdlxQZFGAagxGGmfkkxoOnt0Hxs5gfeLztQ5ABmjFeUSR7t1P2Ype//R//+
         fGEzjn+a18cCzUN+8KpHrCaGRiPf4FOS7mObAbDxfvOkK+g33Z483Vic8DCPo3T4fDPF
         vVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8gVtEPTJYwPm24qAXibiCrZ6robyMvIMIo1FroLOIqrCXHB8XyRrJfU0yEwDgvp1unVD7O7FrgnnK4Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYj6/nubmOSBtC6PrqGZH1Hc85l7v+Ahz1o2F/c8pSIjmx0lsw
	9wMyHnv299Y/151cR9cPBWpxk8YGfjmCyYG6MEqqlW5kK73MNkBq6NcwSQmaQCsUXmFrEzAO7oo
	Q6B88sA==
X-Google-Smtp-Source: AGHT+IESzYBYMsy8TcNeSXmOCuIMcY0rfkLLxruZnkYbIer8gFLQRo6rMLnXbA8I1jN134maNpjGU7IZC4nb
X-Received: from iobbk9.prod.google.com ([2002:a05:6602:4009:b0:85b:3e10:d317])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:3a12:b0:85d:a211:9883
 with SMTP id ca18e2360f4ac-8611c3bae5bmr467620239f.10.1743811844346; Fri, 04
 Apr 2025 17:10:44 -0700 (PDT)
Date: Sat,  5 Apr 2025 00:10:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250405001042.1470552-1-rananta@google.com>
Subject: [PATCH v2 0/2] KVM : selftests: arm64: Explicitly set the page attrs
 to Inner-Shareable
From: Raghavendra Rao Ananta <rananta@google.com>
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Cc: Raghavendra Rao Anata <rananta@google.com>, Mingwei Zhang <mizhang@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The series fixes a conflict in memory attributes in some
implementations,
such as Neoverse-N3, that causes a data abort in guest EL1 with FSC
0x35 (IMPLEMENTATION DEFINED fault (Unsupported Exclusive or Atomic
access)).

Patch-1 is a cleanup patch that replaces numbers (and comments) to
using proper macros for hardware configuration, such as registers and
page-table entries.

Patch-2 fixes the actual bug and sets the page attrs to Inner-Shareable
by default for the VMs created in the selftests. More details are
presented in the commit text.

v1: https://lore.kernel.org/all/20250404220659.1312465-1-rananta@google.com/

v1 -> v2: Addressed Oliver's comments (thank you)
 - Moved the TCR_* macros from tools' sysreg.h to selftests' local processor.h
   in patch-1.
 - Adjsted the citations to describe the issue more appropriately in
   patch-2.

Raghavendra Rao Ananta (2):
  KVM: selftests: arm64: Introduce and use hardware-definition macros
  KVM: selftests: arm64: Explicitly set the page attrs to
    Inner-Shareable

 .../selftests/kvm/arm64/page_fault_test.c     |  2 +-
 .../selftests/kvm/include/arm64/processor.h   | 67 +++++++++++++++++--
 .../selftests/kvm/lib/arm64/processor.c       | 60 ++++++++++-------
 3 files changed, 96 insertions(+), 33 deletions(-)


base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
-- 
2.49.0.504.g3bcea36a83-goog


