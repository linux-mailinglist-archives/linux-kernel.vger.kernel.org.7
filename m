Return-Path: <linux-kernel+bounces-860917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEF3BF151C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BEFE534C8EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60643112C0;
	Mon, 20 Oct 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bl745gEs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB399131E49
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964531; cv=none; b=EmC5B8fND3lp7K/juYTqoMjGlEEMogzqcZLrxYJKlry0XiahXgxGdR5GNz5cPbmeqh1ozKCjSFUuX8EGh7HTHvw2EqE6Gk5jGz2ZmdQStz2X+g1l5Ji6ybg6geUR2CR/cw4HMhZAzQXPjdOGAOozqDiKc2wghex9LTUZ3QYyzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964531; c=relaxed/simple;
	bh=sB9pCJnnJXwDgD98BDM9PkQE+7RkItJ8pEoctG0Hncg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LlDKvHY8GQTHPcDIjMCEHvOPisf/4qbyMY4kO+mvN76H7UvZLfVsqPXa/sNgMheOGwOBcHj8TycYEP5HpB2OpBKXC5l/QLpVDmQ5DZ7+xNixUcNh8clKM8k/8UO6mMrnZ0sZSxY8J7XMPms+amwk0JkY485laSCHPsNdumlD2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bl745gEs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760964528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dhSEcE7tet5FBXLX0b5z+/6XO8jmNy1PmZYd5Q2SxU4=;
	b=bl745gEs9JmpGrc22d70xTP4Fmaa1NqgGpjaE1dWfgO3swNwfuo21TNPhp2qCo+Mv4h7oY
	oilZZHnE56CwVaVh0mUPjI1cIMUZD2SO4lcwq8kEjQDHMNJW/9s85VfnE4wovnBs8rPKiW
	6tYgBxNwudee9lmu6TQsr0gBfbhVAOU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-GfR_RqHQPtWbukxcLs7fww-1; Mon,
 20 Oct 2025 08:48:45 -0400
X-MC-Unique: GfR_RqHQPtWbukxcLs7fww-1
X-Mimecast-MFC-AGG-ID: GfR_RqHQPtWbukxcLs7fww_1760964524
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 460621800637;
	Mon, 20 Oct 2025 12:48:44 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4261219560AD;
	Mon, 20 Oct 2025 12:48:41 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>
Subject: [GIT PULL] rv fixes and selftests for v6.18-rc3
Date: Mon, 20 Oct 2025 14:47:44 +0200
Message-ID: <20251020124744.111326-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Steve,

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git rv-6.18-rc3

for you to fetch changes up to d9423638c039a15f7a1720f92c6ed0fddc6fea23:

  selftests/verification: Add initial RV tests (2025-10-20 12:48:20 +0200)

----------------------------------------------------------------
Summary of changes:

* Adapt the ftracetest script to be run from a different folder, this
  uses the already existing OPT_TEST_DIR but extends it further to run
  independent tests, then add an --rv flag to allow using the script for
  testing RV (mostly) independently on ftrace.
* A bug causing kernel panic when reading enabled_monitors was reported,
  change callbacks functions to always use list_head iterators and by
  doing so, fix the wrong pointer that was leading to the panic.
* The rtapp/pagefault monitor relies on the MMU to be present
  (pagefaults exist) but that was not enforced via kconfig, leading to
  potential build errors on systems without an MMU. Add that kconfig
  dependency.
* Add basic RV selftests in selftests/verification to validate things
  like available/enabled monitors and reactors. This could have caught
  the bug introducing kernel panic solved above. Tests use ftracetest.

----------------------------------------------------------------
Gabriele Monaco (2):
      selftest/ftrace: Generalise ftracetest to use with RV
      selftests/verification: Add initial RV tests

Nam Cao (2):
      rv: Fully convert enabled_monitors to use list_head as iterator
      rv: Make rtapp/pagefault monitor depends on CONFIG_MMU

 MAINTAINERS                                        |  1 +
 kernel/trace/rv/monitors/pagefault/Kconfig         |  1 +
 kernel/trace/rv/rv.c                               | 12 ++--
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
 16 files changed, 286 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/verification/.gitignore
 create mode 100644 tools/testing/selftests/verification/Makefile
 create mode 100644 tools/testing/selftests/verification/config
 create mode 100644 tools/testing/selftests/verification/settings
 create mode 100644 tools/testing/selftests/verification/test.d/functions
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitors_available.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
 create mode 100644 tools/testing/selftests/verification/verificationtest-ktap

Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>


