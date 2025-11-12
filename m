Return-Path: <linux-kernel+bounces-898258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCBFC54B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D0514E0527
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907952EBDE0;
	Wed, 12 Nov 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/1DwiIo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B082E6CA0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985993; cv=none; b=tFCHLHkBZKPm0qE5koPvf+HlasIqrTnr7kmOQVlhFqazGPGnskv6CH1CzAD6iC7IAF7n34O0xqVppIAQU+aFIraJ1WqwVCAUqe0f1qd+wSIwdiW0XBGsq8im1NBkT7oi4b5Dme2PEkxhp9ToWd4+DujU1Yyr2gePvki8d41e4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985993; c=relaxed/simple;
	bh=VJWjXYGJBNwYFBaFjS8qpnnVAKIcI+JOJyyZM7I8U0Y=;
	h=Message-ID:Date:From:To:Cc:Subject; b=NuxI/s26YsK2tZQw+JfGMGUQDKXL4fPZAqerNWK88H7b2kowjhw7MJ5ywN7fwoVq7Fz8jxrdahA3hgEEOXUTbYrmDTmZ2TVGOpIlSFb9tL1zRLMzReAxydn2e/JDu2tPQAz+DyMYc2cNVRLLaaDtSrh18+TAeZgapxut35Lttbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/1DwiIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A44C4CEF1;
	Wed, 12 Nov 2025 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762985993;
	bh=VJWjXYGJBNwYFBaFjS8qpnnVAKIcI+JOJyyZM7I8U0Y=;
	h=Date:From:To:Cc:Subject:From;
	b=n/1DwiIoW1s1L1bNVvGsHOKk33ZyQg7Sw/tUY7nSBPGIFGe41rIbQREirJKC8ULYd
	 jFOIQO+87cTyFbgHObxEiNFLp+F6+M0LLreVgKe0Ho1gpgMmUF0uWvg3/gZzqoxRPy
	 Je2hI4s/HhygJNhQszXxtm1MShHJejj3A3dbRqCBkBvphyVigrVUdhQZZVEvIxeHwA
	 xXhcOAHoDsxkdZopzCWSP1ED+Xv+odylotIygRH00kCK7X0iNhuSm+ear9PXKs6F52
	 ixh9w3vDPPGmVqUjO9TfRmDdp4cFQOZiiscBdyg8Zn+xWmlrRwOsBmgFrOLquDKE4c
	 go6tGvTOQlaBw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJJCA-00000001EVL-2QR0;
	Wed, 12 Nov 2025 17:20:06 -0500
Message-ID: <20251112221946.389142361@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 12 Nov 2025 17:19:46 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [for-next][PATCH 0/5] rv: Updates for v6.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
latency/for-next

Head SHA1: 69d8895cb9a9f6450374577af8584c2e21cb5a9f


Gabriele Monaco (2):
      selftest/ftrace: Generalise ftracetest to use with RV
      selftests/verification: Add initial RV tests

Thomas Weißschuh (3):
      rv: Pass va_list to reactors
      rv: Make rv_reacting_on() static
      rv: Add explicit lockdep context for reactors

----
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

