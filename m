Return-Path: <linux-kernel+bounces-898027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF06C54216
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B5DB349733
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D7234DB62;
	Wed, 12 Nov 2025 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v28dvmxQ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4C34D90D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975465; cv=none; b=J0r33eJuRvxF3atDlhushN+rxvrFrB2SHXo5ttrOo9/44sqV4OkQPqsrJ08Wz7QGRn4GHpPnbhqMbo0ZY706D6qNy/400zjyv3GRgRYXHIYifedxK2avAs9lFwNyhC9RqaRRQT2ftZ2t4unYkSvJbXRFhAowzFY4vKEVuu+706s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975465; c=relaxed/simple;
	bh=pMtifnGguWwXh6lHrgJXuydSaUf37tbidRI42Plh0jQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BNwmcRym3qS5apkmMfRtJF+Yu4re0WjHqHgrQYbCCNYT9u4XDdlDzyGVpz1N2loPPnQYFeQOS/36A3rlZWt3ro7gwynJDSNayEcZ2eME6h8ySchAk45G4iRC0bRPvO4et4qqzXoE0bpD1XgTXDj5cwJCcYBE7ARoVf5dHAslntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v28dvmxQ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4710d174c31so512975e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975461; x=1763580261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=shBTNgU9wHH3aiYzJkihBS7EM1mqulzE2iP8vCjc0uc=;
        b=v28dvmxQ8Zqk6Vh9eI6jdOo+cRanJQb4lDpHiOF3/HPlGxuQA1nVe1ejPxMXYrYV0B
         0Ud+hGbV0fAXbNnylkdXuk34gGq5XMUrzwQCTaAgJ2eOTTRg7JWSTCvjYVzhX4geqnSO
         dwqQ4nk/MzvVreOX4/um3XWorEaghS+2AnSWXHbk+wyjZVAC2sueQk6bBT7PnVGEr9Be
         YwyWlb1V9igFhl/x9u73xPM8IgTGK3kJ+EbEQKo5LrrRgd+mmZT51BQGffU7F8PQuyFg
         3ieoY6f9dM1IaoeuvCqOWCbpbqB4ovYZH3xTLwwkBA/y8yydhrVi2iTDRHoVXUOsrBo/
         4MYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975461; x=1763580261;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shBTNgU9wHH3aiYzJkihBS7EM1mqulzE2iP8vCjc0uc=;
        b=BAv5REjYGZws2lauyhXT4QN0+5/5wASFc8P5CQNi0JPI7Zr1cUB/L5RHJ+ImwC7bYM
         LM80Y7oIXp3nGEOtX1oqN4E+Vl34e1WndHkKjSbZ9wnN13QPhTCZ2KpPau72cbWI+dNS
         ZTRFKCue5y6mju/vaDQ+UE0JS0zvYuh1/pA0rjznJBvqGwrKDwavhYdL1GOCL4C1Gh18
         LBebQVmzPmZm3yEzfU77cONCegAzXZsC0QIVJ2mYgbNldhxMgzQZkuE29CiYH/ZBvNZY
         +BTpxIDGF6ZLFIoFeZtkkizxvCeUMJ2s+UmftHd9r/e1HOuz9pgpT02oRmKcMziOUMaM
         UvWw==
X-Gm-Message-State: AOJu0YzUtAt+Ve1ubqbwEX+dTnkCTq9uz8mCIdW/uPc7YLEHtqVDGWLd
	jqECPWFFh591my9bnppel47YNXcM9cjfE6SwNWImSP8i195KdgzJdt8Eg8vWjF1zSP/gMMjBE04
	qqHy07Q==
X-Google-Smtp-Source: AGHT+IF0IMOWBsJBJ0wnh8IgGWl4VgqHbLq1DSRsMKozY2Y54uc+oyrD1ecl+ZGARKGuxvpKlqMu/I45G/s=
X-Received: from wmsp24.prod.google.com ([2002:a05:600c:1d98:b0:477:15b8:8ef1])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4fc9:b0:477:5b0a:e616
 with SMTP id 5b1f17b1804b1-47787071649mr35886245e9.5.1762975461305; Wed, 12
 Nov 2025 11:24:21 -0800 (PST)
Date: Wed, 12 Nov 2025 19:24:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112192408.3646835-1-lrizzo@google.com>
Subject: [PATCH 0/6] platform wide software interrupt moderation
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Platform wide software interrupt moderation specifically addresses a
limitation of platforms, from many vendors, whose I/O performance drops
significantly when the total rate of MSI-X interrupts is too high (e.g
1-3M intr/s depending on the platform).

Conventional interrupt moderation operates separately on each source,
hence the configuration should target the worst case. On large servers
with hundreds of interrupt sources, keeping the total rate bounded would
require delays of 100-200us; and adaptive moderation would have to reach
those delays with as little as 10K intr/s per source. These values are
unacceptable for RPC or transactional workloads.

To address this problem, this code measures efficiently the total and
per-CPU interrupt rates, so that individual moderation delays can be
adjusted based on actual global and local load. This way, the system
controls both global interrupt rates and individual CPU load, and
tunes delays so they are normally 0 or very small except during actual
local/global overload.

Configuration is easy and robust. System administrators specify the
maximum targets (moderation delay; interrupt rate; and fraction of time
spent in hardirq), and per-CPU control loops adjust actual delays to try
and keep metrics within the bounds.

There is no need for exact targets, because the system is adaptive.
Values like delay_us=100, target_irq_rate=1000000, hardirq_percent=70
are good almost everywhere.

The system does not rely on any special hardware feature except from
MSI-X Pending Bit Array (PBA), a mandatory component of MSI-X

Boot defaults are set via module parameters (/sys/module/irq_moderation
and /sys/module/${DRIVER}) or at runtime via /proc/irq/moderation, which
is also used to export statistics.  Moderation on individual irq can be
turned on/off via /proc/irq/NN/moderation .

PERFORMANCE BENEFITS:
Below are some experimental results under high load (before/after rates
are measured with conventional moderation or with this change):

- 100Gbps NIC, 32 queues: rx goes from 50-60Gbps to 92.8 Gbps (line rate).
- 200Gbps NIC, 10 VMs (total 160 queues): rx goes from 30 Gbps to 190 Gbps (line rate).
- 12 SSD, 96 queues: 4K random read goes from 6M to 20.5 MIOPS (device max).

In all cases, latency up to p95 is unaffected at low/moderate load,
even if compared with no moderation at all.

IMPLEMENTATION
- Most of the code, including module parameters and procfs hooks for
  configuration and telemetry, is in two files
  include/linux/irq_moderation.h and kernel/irq/irq_moderation.c.

- struct irq_desc is extended with a list entry and one field indicating
  whether this source should use moderation

- handle_irq_event() and sysrec_posted_msi_notification() have small
  inline hooks to track interrupts and trigger moderation as needed.

- per-CPU state is initialized via hooks in per-architecture files

- optional device driver module parameters can be added to set driver
  defaults to enable/disable moderation

Luigi Rizzo (6):
  genirq: platform wide interrupt moderation: Documentation, Kconfig,
    irq_desc
  genirq: soft_moderation: add base files, procfs hooks
  genirq: soft_moderation: activate hooks in handle_irq_event()
  genirq: soft_moderation: implement adaptive moderation
  x86/irq: soft_moderation: add support for posted_msi (intel)
  genirq: soft_moderation: implement per-driver defaults (nvme and vfio)

 Documentation/core-api/irq/index.rst          |   1 +
 Documentation/core-api/irq/irq-moderation.rst | 215 ++++++++
 arch/x86/kernel/cpu/common.c                  |   1 +
 arch/x86/kernel/irq.c                         |  12 +
 drivers/irqchip/irq-gic-v3.c                  |   2 +
 drivers/nvme/host/pci.c                       |   3 +
 drivers/vfio/pci/vfio_pci_intrs.c             |   3 +
 include/linux/interrupt.h                     |  28 +
 include/linux/irq_moderation.h                | 265 ++++++++++
 include/linux/irqdesc.h                       |   5 +
 kernel/irq/Kconfig                            |  11 +
 kernel/irq/Makefile                           |   1 +
 kernel/irq/handle.c                           |   3 +
 kernel/irq/irq_moderation.c                   | 482 ++++++++++++++++++
 kernel/irq/irqdesc.c                          |   1 +
 kernel/irq/proc.c                             |   2 +
 16 files changed, 1035 insertions(+)
 create mode 100644 Documentation/core-api/irq/irq-moderation.rst
 create mode 100644 include/linux/irq_moderation.h
 create mode 100644 kernel/irq/irq_moderation.c

-- 
2.51.2.1041.gc1ab5b90ca-goog


