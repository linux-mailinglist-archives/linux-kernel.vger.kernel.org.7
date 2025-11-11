Return-Path: <linux-kernel+bounces-895402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAB5C4DAA3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469293A7E54
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500A63587B8;
	Tue, 11 Nov 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqiUsMG3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0E2737E7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863931; cv=none; b=NwsaKkYcV1wcIXyshAc+uMbSy3I/lq+5LMa1gGiqFMaQxjmd2lIqxKStsG7vg7HS36Qzp7W0TyIXNtwWqI9RKOMoypCdpCDDrol+De6lKAQjhYuwmec69BRJe2Deh7dTowZWFLX079gcim3Vd6RSmRwVFZa/MoyYyjaCkfpHAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863931; c=relaxed/simple;
	bh=gkDWYrw2YX0gRfoRkwjVqDKrZLhUWgie2iN8zpeK96c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N1Y8kK8jjaPj0JrHHI09kXeEiDVqZNeSox2WYovcgnGfl1beV/MPSLD71Fr0mpdGq6a7CB1tHjntG+qgxKUDmaLu4bCCeRB1d8wcfQm0SPbjuNCJOwJn8AUEkztw3RedQQSIPD2sG9Kj6Bd9fruqpX9y4vSl0oKZJM1csY/sP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqiUsMG3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762863928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uLImWdrhaH1dfsShMsOohGC3W+XoG6uigfF1FZMQCps=;
	b=FqiUsMG3ttLddupWjFVUBMv0LRVTKdx/Nd8wou9Wotl+2y/RAwMDkT7Rw18itOdzJ2nmuo
	Xt+MWB0ynfONoMFF/g33AJnS/mGBr5nwvHRK6zt4gom5v4qadhP3QaVbuDZ8Ip300IRF5M
	j9aIdhlxfI9MV0GS0LacIZom+stHpWY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-M1zKPoZwMQOw1vxaU_UFhg-1; Tue,
 11 Nov 2025 07:25:25 -0500
X-MC-Unique: M1zKPoZwMQOw1vxaU_UFhg-1
X-Mimecast-MFC-AGG-ID: M1zKPoZwMQOw1vxaU_UFhg_1762863924
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A93618002CD;
	Tue, 11 Nov 2025 12:25:24 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.225.167])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EAE3019560A2;
	Tue, 11 Nov 2025 12:25:19 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Nam Cao <namcao@linutronix.de>
Subject: [GIT PULL] rv changes for v6.19 (for-next)
Date: Tue, 11 Nov 2025 13:24:15 +0100
Message-ID: <20251111122416.96930-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Steve,

The following changes since commit e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c:

  Linux 6.18-rc5 (2025-11-09 15:10:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv-6.19-next

for you to fetch changes up to 69d8895cb9a9f6450374577af8584c2e21cb5a9f:

  rv: Add explicit lockdep context for reactors (2025-11-11 13:18:56 +0100)

----------------------------------------------------------------
Summary of changes:

* Adapt the ftracetest script to be run from a different folder, this
  uses the already existing OPT_TEST_DIR but extends it further to run
  independent tests, then add an --rv flag to allow using the script for
  testing RV (mostly) independently on ftrace.
* Add basic RV selftests in selftests/verification to validate things
  like available/enabled monitors and reactors. This could have caught
  the bug introducing kernel panic solved above. Tests use ftracetest.
* Convert react() function in reactor to use va_list directly and use a
  central helper to handle the variadic arguments. Clean up macros and
  mark functions as static.
* Add lockdep annotations to reactors to have lockdep complain if they
  are called from improper context. Useful to develop new reactors. This
  highlights a warning in the panic reactor that is related to the
  printk subsystem and not to RV.

----------------------------------------------------------------
Gabriele Monaco (2):
      selftest/ftrace: Generalise ftracetest to use with RV
      selftests/verification: Add initial RV tests

Thomas Weißschuh (3):
      rv: Pass va_list to reactors
      rv: Make rv_reacting_on() static
      rv: Add explicit lockdep context for reactors

 MAINTAINERS                                        |  1 +
 include/linux/rv.h                                 | 11 ++--
 include/rv/da_monitor.h                            | 35 +++-------
 include/rv/ltl_monitor.h                           | 18 ++----
 kernel/trace/rv/reactor_panic.c                    |  6 +-
 kernel/trace/rv/reactor_printk.c                   |  6 +-
 kernel/trace/rv/rv_reactors.c                      | 22 ++++++-
 tools/testing/selftests/ftrace/ftracetest          | 34 +++++++---
 .../ftrace/test.d/00basic/mount_options.tc         |  2 +-
 tools/testing/selftests/ftrace/test.d/functions    |  6 +-
 tools/testing/selftests/verification/.gitignore    |  2 +
 tools/testing/selftests/verification/Makefile      |  8 +++
 tools/testing/selftests/verification/config        |  1 +
 tools/testing/selftests/verification/settings      |  1 +
 .../selftests/verification/test.d/functions        | 39 +++++++++++
 .../test.d/rv_monitor_enable_disable.tc            | 75 ++++++++++++++++++++++
 .../verification/test.d/rv_monitor_reactor.tc      | 68 ++++++++++++++++++++
 .../verification/test.d/rv_monitors_available.tc   | 18 ++++++
 .../verification/test.d/rv_wwnr_printk.tc          | 30 +++++++++
 .../selftests/verification/verificationtest-ktap   |  8 +++
 20 files changed, 322 insertions(+), 69 deletions(-)
 create mode 100644 tools/testing/selftests/verification/.gitignore
 create mode 100644 tools/testing/selftests/verification/Makefile
 create mode 100644 tools/testing/selftests/verification/config
 create mode 100644 tools/testing/selftests/verification/settings
 create mode 100644 tools/testing/selftests/verification/test.d/functions
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitors_available.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
 create mode 100755 tools/testing/selftests/verification/verificationtest-ktap

Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Cc: Nam Cao <namcao@linutronix.de>


