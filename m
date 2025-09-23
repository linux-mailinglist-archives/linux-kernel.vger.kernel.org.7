Return-Path: <linux-kernel+bounces-829775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5B6B97CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26702A2411
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AF530F930;
	Tue, 23 Sep 2025 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlKABTLx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC42594BD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758670171; cv=none; b=exCxjAv+DOxWU17v+9U2GDWfhntp2D8jzHLqMOYtWn7qQWdhxiX8KL5VRrDheOy5FS7h8wzRbAkiiSQMzasI/+7XXSxcJBuxvyCKmkfthqUvmLqS0lIc4iqK8cegcK7lDXCx8RRM3K8w61L7uqZvH8ecTjtRmKGxIe0PUo0hLx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758670171; c=relaxed/simple;
	bh=oESXkZoLckStr3BY/vC84oYQanMjC0d5GZszJXIXUU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyB4jTWKkYghJlV/ePkgpwBo3A5DI5jhLem4BmrTmczkxeuoXI+88019sRGnVQgZEl6R1iBW8yBbMaWVP2dfcoMoyRffYxsC6VaniDUP7DD40KUTyBaPUWPWiyzpRRP8byvmjWCPBr1OgrDqXh3HvdEyL/gO0PhwnH39G19gGm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RlKABTLx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758670168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T76o2mndCWpkn5nrn6x1OhRq/ho6UCjAkKQNWezzrwQ=;
	b=RlKABTLxVNcAXGKnw5KMiFcergkkEIqO9WvfnX0a892jxtqYYiTAoqxO2Isi7tliv4V1u+
	2ys6Co/bOgIKSSYq502q2J0l1IpNP/hVgG2WjHsK2ut8kQJ0YacGQ+t76Vw04rBEvNBVf6
	6SYxf/rMxKTG1ophqdQL4lm7xOGg95k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-J7YmGMWSMNGQwpaLHIClJA-1; Tue,
 23 Sep 2025 19:29:26 -0400
X-MC-Unique: J7YmGMWSMNGQwpaLHIClJA-1
X-Mimecast-MFC-AGG-ID: J7YmGMWSMNGQwpaLHIClJA_1758670165
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D6C5180057E;
	Tue, 23 Sep 2025 23:29:25 +0000 (UTC)
Received: from thinkpad-p1.kanata.rendec.net (unknown [10.22.66.88])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F33211800452;
	Tue, 23 Sep 2025 23:29:23 +0000 (UTC)
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: [PATCH 0/1] irqchip test driver/sandbox
Date: Tue, 23 Sep 2025 19:29:04 -0400
Message-ID: <20250923232905.1510547-1-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Radu Rendec (1):
  samples: Add irqchip test driver

 samples/Kconfig             |  10 +
 samples/Makefile            |   1 +
 samples/irqchip/Makefile    |   1 +
 samples/irqchip/irqc_test.c | 576 ++++++++++++++++++++++++++++++++++++
 4 files changed, 588 insertions(+)
 create mode 100644 samples/irqchip/Makefile
 create mode 100644 samples/irqchip/irqc_test.c

-- 
2.51.0


