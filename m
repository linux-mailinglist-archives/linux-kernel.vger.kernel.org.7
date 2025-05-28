Return-Path: <linux-kernel+bounces-665627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 836BFAC6BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 16:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92C0189EC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F0E28935F;
	Wed, 28 May 2025 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pd0Ki3/F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01868289345
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442766; cv=none; b=d5ZSvs1w5eDImzYf6CSv/QiBOnAweXGrtqwjcWMAdW65pSW/ELGJp2JVjYSLgQkOKtJUgOzDm/Izw6/98T3H6JXz0bfrf7sr/dvzUJlxRCRNtsq2Q0qqZt24KVsxjWay9qJZch4NYtMCRP9ZmDcu4OSXLlx4VU7iQN4+ctb1Bnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442766; c=relaxed/simple;
	bh=JBYwdCdTyvYoQAXWxDyaQxN2QX3e1Xl53i4v/JIvq8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLvbUOKgX6S6YEjLeJzfgdcl0H8Ltx2gN3D2lYFPlUz+c01S7mJwBoBr+N/+eCx5z+uZ7dUz07fGVHkpawK0nTGiHFq2StNDpyq81PY2bQ45C79YGI/fo+Wwj9qupMDPmxIg0DznGnI1OaoQmk8+Yg8PNUFHcz6apx9fZ+AffS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pd0Ki3/F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748442763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eBwB1N+lCFgkoewCyl34COuFv/09dqI6TaRz6nP+SHg=;
	b=Pd0Ki3/FUZK7Ti95N3fpyNAWALh4VmLS7S6lfmLXGgT5wdBN2YbkEL7vN/K0pTefr912Q/
	fiTp2o2gL0+85LLf3PV8BZfXRO49l1UH0AdcHQuCZfAi0+XqcinaWdaJk9UA7IpkOq98In
	cV1N+tkGwIgykM59YHnNkiCL34LwL48=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-H7OXcgnFOLqjTVayGDFiGA-1; Wed,
 28 May 2025 10:32:42 -0400
X-MC-Unique: H7OXcgnFOLqjTVayGDFiGA-1
X-Mimecast-MFC-AGG-ID: H7OXcgnFOLqjTVayGDFiGA_1748442761
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 275351955DAD;
	Wed, 28 May 2025 14:32:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.94])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C93EC19560AA;
	Wed, 28 May 2025 14:32:33 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH 0/2] rtla/timerlat: Implement flexible actions on latency threshold overflow
Date: Wed, 28 May 2025 16:28:56 +0200
Message-ID: <20250528142858.185017-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

rtla-timerlat defines the -i and -T options to set a threshold for
latency, stopping tracing if a sample above the threshold is
encountered. After tracing is stopped, one of two optional actions can
be enabled: saving trace output and auto-analysis. Auto-analysis is
enabled by default, unless --aa-only is supplied, while trace output has
to be explicitly set with -t/--trace-output.

This is an RFC of a feature extending this to a potentionally arbitrary
action. It adds a new option, -A/--action-on-overflow, that takes
the action to be performed and optionally, arguments to that action. For
example:

$ rtla timerlat hist -T 10 -A command,exec=date

will print the date after stopping tracing. The argument also supports
trace output, via -A trace (equivalent to -t), and can be specified
multiple times. See the patch log for more information on the actions
implemented in the RFC.

The feature was inspired by a case where collecting perf data on rtla
latency overflow was required, which can be done by sending a signal
to the perf process. In general, the feature is aiming to allow
integration with external tooling.

The RFC contains two patches. The first one clearly distinguishes
between rtla-timerlat tracing modes with regards to collecting data:
BPF-only mode, tracefs-only mode, and mixed mode. It is not a hard
prerequisite of the other patch, but is expected to be useful in
the implementation of the next version of the patchset. The second one
contains the actions feature itself.

Missing functionality in this RFC expected to be in the final version:
- Allowing the tracing to continue after the action. This is expected
to be implemented via either explicitly stopping tracing with "-A stop"
if needed (and not stopping if any other action is specified), or vice
versa by explicitly continuing with "-A continue". The latter might be
better for more meaningful backwards compatibility.

An unresolved question is whether to stop tracing or not during
the execution of the actions, if the measurement is to continue.
- Specifying a trace output file, like -t does, e.g. "-A trace,file=a.txt".
- Converting auto-analysis into an action of this kind.
- Multiple actions of same kind in one run, e.g.:
"-A signal,pid=2,num=2 -A signal,pid=3,num=2"
- Properly handling errors when adding actions.
- Providing the latency to the exec action command via an environmental
variable.
- Plus there are a few minor checkpatch issues.

Suggestions (e.g. with respect to your own use cases) are most welcome.

Tomas Glozar (2):
  rtla/timerlat: Introduce enum timerlat_tracing_mode
  rtla/timerlat: Add action on threshold

 tools/tracing/rtla/src/Build           |   1 +
 tools/tracing/rtla/src/actions.c       | 155 +++++++++++++++++++++++++
 tools/tracing/rtla/src/actions.h       |  33 ++++++
 tools/tracing/rtla/src/timerlat.c      |  66 +++++++++--
 tools/tracing/rtla/src/timerlat.h      |  22 +++-
 tools/tracing/rtla/src/timerlat_hist.c |  83 ++++++++-----
 tools/tracing/rtla/src/timerlat_top.c  |  89 ++++++++------
 7 files changed, 375 insertions(+), 74 deletions(-)
 create mode 100644 tools/tracing/rtla/src/actions.c
 create mode 100644 tools/tracing/rtla/src/actions.h

-- 
2.49.0


