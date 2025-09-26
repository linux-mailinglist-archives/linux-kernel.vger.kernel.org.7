Return-Path: <linux-kernel+bounces-834457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B331FBA4BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A89740145
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281B30B508;
	Fri, 26 Sep 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8pZ6dXs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46A2FD7A3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905954; cv=none; b=SOZ2bxLnoa7CGiVh/5B1gfVuR10HF0yhg4C/4PC3on60/gPu8Rf+UfW3ipVlJu+2ANVsxftPLs3Hi0X4tBEplZ2sq/lqDX6qVEnX8X5uAVh7AhXmVEMR1cLxOF8ivI+JuWHSwmf3mW8IjSyI4gJqD6XONsWvUg062PUg8GmkvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905954; c=relaxed/simple;
	bh=gvfiDOh1LjbTrlOH1JqIh3fRoY4w018PfqgGr00DGu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2AYbHSu3SUNx5Wx6EUnD0lBAe4WpKcBoVqGf/LnNqL1UqadwVS0jA8+fTMEugCVYQZ/YM3yx/Iht8KsTAT3pXod8Khjnf/nSfZCiji/nICHEBq41Ry34B6Ni/0oVaEIxU1z84dciMTSMhjiZyJ+X1Bx6L+cIjOdBvCoC+MMy9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8pZ6dXs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758905950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tUALypN6U3UhG+VP6DaGg1EdZQDaePHtd2jNPQDM/d8=;
	b=T8pZ6dXsnrI1UlAi1Jl37w5rIckSxL2RfpZBmWKsHjGBJyA6BxTyzqJowe/gc9ac0DiM3t
	rQAMX+XLGKsSKLh6OYUYfcH8RoCzT9KL3ZBhoX5unLGggBFpDvPUVK416ic4G9wsnp17cF
	ZOQQbNcuJzbIsqpbREjvB6xM+HBBP0w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-R5YRkSNJM0ewuFy2bOZIxA-1; Fri,
 26 Sep 2025 12:59:09 -0400
X-MC-Unique: R5YRkSNJM0ewuFy2bOZIxA-1
X-Mimecast-MFC-AGG-ID: R5YRkSNJM0ewuFy2bOZIxA_1758905948
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4964A19560B2;
	Fri, 26 Sep 2025 16:59:08 +0000 (UTC)
Received: from thinkpad-p1.localdomain.com (unknown [10.22.64.55])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0223F1800446;
	Fri, 26 Sep 2025 16:59:06 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: [PATCH v2 0/1] irqchip test driver/sandbox
Date: Fri, 26 Sep 2025 12:58:09 -0400
Message-ID: <20250926165810.2423996-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is a dummy irqchip driver that implements three different types of
IRQ chips, requests interrupts like a real device driver would do, and
provides the ability to manually trigger any of these interrupts. The
main reason why I wrote it was to be able to hack on the kernel IRQ core
without depending on any hardware (even virtual, inside a VM). But it
can also be used as an example for implementing irqchip drivers.

The irqchip setup/layout is described in detail in a comment block at
the top of the driver's source file, so I'm not repeating it here. Two
"leaf" IRQ domains are implemented: hierarchical and multiplexing. These
are attached to an additional "root" domain, which is similar to APIC
(x86_64) or GIC (arm64). Interrupts are simulated by calling the generic
interrupt handling function on the "root" domain, in a workqueue context
and with local interrupts disabled.

A few notes on the implementation:
- The driver cannot be compiled as a loadable module, and the only
  reason is because it uses irq_move_irq(), which is not exported. I
  could not find a better way to make IRQ affinity control for the
  "root" domain work on x86. This is also documented in the source code.
- The driver uses a write-only module parameter with a custom handler as
  the interface to trigger simulated interrupts. While this slightly
  abuses the module parameter API, it's very simple to implement and
  also keeps the sysfs file confined in the module's own "namespace" at
  /sys/module/irqc_test. Of course, setting the parameter on the kernel
  command line makes no sense but doesn't have any side effect either.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
Changes in v2:
- Fix sysfs file mode on module parameter
- Add "depends" to Kconfig to prevent build failures on unsupported
  architectures (no IRQ domain hierarchy support e.g. x86_32)
- Link to v1: https://lore.kernel.org/all/20250923232905.1510547-1-rrendec@redhat.com/

---
Radu Rendec (1):
  samples: Add irqchip test driver

 samples/Kconfig             |  11 +
 samples/Makefile            |   1 +
 samples/irqchip/Makefile    |   1 +
 samples/irqchip/irqc_test.c | 576 ++++++++++++++++++++++++++++++++++++
 4 files changed, 589 insertions(+)
 create mode 100644 samples/irqchip/Makefile
 create mode 100644 samples/irqchip/irqc_test.c

-- 
2.51.0


