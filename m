Return-Path: <linux-kernel+bounces-871871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E043C0EACE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A973BDDD9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAE42C0F91;
	Mon, 27 Oct 2025 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrxIj0Zu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D564261581
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576524; cv=none; b=lSIEF+qjbdbsiXXd1L4DDgIyq+NjOUJSepVsqZBddIbSVOEZBXoiT+VxvqlIPSX77Xozf2NfNcNxmcJY0f246C6WV0DDJWklu3jfYAFBfhaQ/nf8dngtl35TjC/FxB7lAh+RvCKkoP1J2LLDHd0GoKfnYjKjdnhrCGqHnNek5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576524; c=relaxed/simple;
	bh=9UgMUVv8VR4+vD2TErw6dCLY3FSGTwLUH17ZY6KOigI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9UNrUcg9qDge9JLkDVAl3XCTugbSs1cd5qMalsa5K+jIo9r10jHvp4ys9K0FnwkPs1Pw46QVYw+x0m30dpwNIBpZF5W7vIDXjfJnEPawimx6f7fOOIG/MsVi5epyGf0363mnzy0XRvVfgKvTcXqWghRmEWV7YUlekQNDoxCM+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrxIj0Zu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wuiva9DBH0te7dsqF933E2n0nHV9z8ql+tWxy+A2CK0=;
	b=FrxIj0Zut6KUGwqsA/OuwmmX7ZaE9/gVbZqEf8+6TwOgfM4Rg90Y7rFcSFuNnzRxoKS61q
	AePyuLd1QoeWi4b/JKy2skg6I3ryvKma6Qgw3IROPw4x7LfX4Q262uMIRa/fCiNcXCYUXl
	FlQIqGxAO/Yby72n+XK2m9qRUBreWig=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-Qsjf0jp9MCqkjTg6bdac9Q-1; Mon,
 27 Oct 2025 10:48:40 -0400
X-MC-Unique: Qsjf0jp9MCqkjTg6bdac9Q-1
X-Mimecast-MFC-AGG-ID: Qsjf0jp9MCqkjTg6bdac9Q_1761576519
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 781EE19560AE;
	Mon, 27 Oct 2025 14:48:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F273119540EB;
	Mon, 27 Oct 2025 14:48:35 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 0/7] rtla/timerlat: Add --bpf-action option
Date: Mon, 27 Oct 2025 15:48:12 +0100
Message-ID: <20251027144819.1034041-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patchset extends rtla-timerlat's BPF support with the option of
executing a user-supplied BPF program on latency threshold overflow.

See the supplied example and documentation for how to create a program.
bpf_tail_call() is used to chain the program with the built-in BPF
sample collection program, if the threshold is hit.

The feature can be used for both in-kernel data collection and sending
signals to userspace directly from the kernel, if the kernel version
allows it.

Note: The patchset will have to be rebased on top of [1], or vice versa,
since they both touch stop_tracing() ([1] adds one call of it, and this
patchset adds an extra argument to it).

I have contemplated adding this as --on-threshold bpf,... but it does
not fit the existing actions infrastructure very well, since the action
happens in the BPF program, not in RTLA, and only one BPF action is
supported.

[1] https://lore.kernel.org/linux-trace-kernel/20251006143100.137255-1-tglozar@redhat.com/

v2 changes:
- Properly bpf__object_close() also when bpf__object_load() fails.
- Use goto for error paths in timerlat_load_bpf_action_program().
- Remove unneeded NULLing of obj and prog in timerlat_bpf_init().
- Add entry to Makefile to build example.
- Add test for BPF actions.
- Rename sample/ directory to example/, also in docs.
- Run Test::Harness in verbose mode during "make check".

Thanks to Crystal and Wander for their input.

Tomas Glozar (7):
  rtla/timerlat: Support tail call from BPF program
  rtla/timerlat: Add --bpf-action option
  rtla/timerlat: Add example for BPF action program
  rtla/tests: Test BPF action program
  rtla/tests: Run Test::Harness in verbose mode
  Documentation/rtla: Rename sample/ to example/
  Documentation/rtla: Document --bpf-action option

 .../tools/rtla/common_timerlat_options.rst    | 22 ++++++-
 tools/tracing/rtla/Makefile                   | 19 +++++-
 .../rtla/example/timerlat_bpf_action.c        | 16 +++++
 .../rtla/{sample => example}/timerlat_load.py |  0
 tools/tracing/rtla/src/timerlat.bpf.c         | 23 ++++++-
 tools/tracing/rtla/src/timerlat.c             | 11 ++++
 tools/tracing/rtla/src/timerlat.h             |  2 +-
 tools/tracing/rtla/src/timerlat_bpf.c         | 66 +++++++++++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h         |  7 +-
 tools/tracing/rtla/src/timerlat_hist.c        |  5 ++
 tools/tracing/rtla/src/timerlat_top.c         |  5 ++
 tools/tracing/rtla/tests/engine.sh            |  1 -
 tools/tracing/rtla/tests/timerlat.t           | 15 +++++
 13 files changed, 182 insertions(+), 10 deletions(-)
 create mode 100644 tools/tracing/rtla/example/timerlat_bpf_action.c
 rename tools/tracing/rtla/{sample => example}/timerlat_load.py (100%)

-- 
2.51.0


