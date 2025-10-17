Return-Path: <linux-kernel+bounces-858218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CABDABE9517
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 256AF4E6D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63142F12AD;
	Fri, 17 Oct 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUE9mmh5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67432F12A1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712437; cv=none; b=hveVsWwnyUcZsDNlIWmIcrY1UOioGnWieSkmVJDA8vFPu2xkRr2SIPkb37TyDWp4VfPKG/jsVdoygk4K/MlG4OgYOwoSgb9eKmJxPcdiR/lexqIIvwqqF8ynBikR+iiGMvQ6fLBtF8pmnjSogbmQYKkkYnhxH13aS+OFpCx3sxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712437; c=relaxed/simple;
	bh=75vKCfL3ezS+cf5WDh89YciSjSMKCTJsfcb1LDcqE2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjnouNQ55QJyulbulF91oEMKKEKZQfx7U6vIGbOYrN68V6ES3APb5hZdFS8HCl2v0YGHcULGQ8W2o7vc+k4/VlBLC+sBNm45G9PVsAu52fN6kzTrrfHuOkNmU26+jtftLF5MP0eE5d5GmRtavhDi0b0xsVZP4zHTjWVu/xSnet8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUE9mmh5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760712433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=blFtHsrz91GSUOxatWU6Sim8/yxuJYJjoWm4023zsuY=;
	b=YUE9mmh5XJiqBe6Dvdh7hOH0tW576AJiLyAKRaukEm42SryzSD5p7b6cJ4XpPEVlzUpULC
	/55KFj8qDVztyyxPkAlxMO4j4VvjPKrGkw6GT7WA1fvkpuUu7A4pxas4dPRNVBtE7MfUBU
	V/5rapJ/JcPu8THSdV5InnjLvxrhVWI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-KPUfwbanP-CWDkAiOyElsg-1; Fri,
 17 Oct 2025 10:47:12 -0400
X-MC-Unique: KPUfwbanP-CWDkAiOyElsg-1
X-Mimecast-MFC-AGG-ID: KPUfwbanP-CWDkAiOyElsg_1760712431
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D938B19560AD;
	Fri, 17 Oct 2025 14:47:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87AF81800452;
	Fri, 17 Oct 2025 14:47:07 +0000 (UTC)
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
Subject: [PATCH 0/4] rtla/timerlat: Add --bpf-action option
Date: Fri, 17 Oct 2025 16:46:46 +0200
Message-ID: <20251017144650.663238-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Tomas Glozar (4):
  rtla/timerlat: Support tail call from BPF program
  rtla/timerlat: Add --bpf-action option
  rtla/timerlat: Add example for BPF action program
  Documentation/rtla: Document --bpf-action option

 .../tools/rtla/common_timerlat_options.rst    | 18 +++++
 .../tracing/rtla/sample/timerlat_bpf_action.c | 16 +++++
 tools/tracing/rtla/src/timerlat.bpf.c         | 23 ++++++-
 tools/tracing/rtla/src/timerlat.c             | 11 +++
 tools/tracing/rtla/src/timerlat.h             |  2 +-
 tools/tracing/rtla/src/timerlat_bpf.c         | 67 +++++++++++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h         |  7 +-
 tools/tracing/rtla/src/timerlat_hist.c        |  5 ++
 tools/tracing/rtla/src/timerlat_top.c         |  5 ++
 9 files changed, 149 insertions(+), 5 deletions(-)
 create mode 100644 tools/tracing/rtla/sample/timerlat_bpf_action.c

-- 
2.51.0


