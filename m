Return-Path: <linux-kernel+bounces-742885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEAEB0F7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C91D584635
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC6D1E7C1C;
	Wed, 23 Jul 2025 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+nldWap"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD1C1DEFE6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287184; cv=none; b=uweIO973gnEZfrYo/PYlOJ2YDiQHFEDVsJMNUn9uKpv4LOTQh3xe/TRxI5TsZnWpD7/dNe8MDorQtSSaZVTjKhNqWrMUjsa6qNKwy0dGZU48pCAoWixrt/D69hR2uCpXT/2H4+AWQbmyLgKveJxY5oWI/0d5WMRBmqOvm4Wp/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287184; c=relaxed/simple;
	bh=EHRzdPb0LLStR3iLrVZ+owxfK6UVWdl5XsXSYoyqR+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/x4d946MtcH78NQk51aFmGCYEmclshLMCxi8GomlXhFmNy9fiuX61W8GLFaHH/J+ZfxcTNrUPOJDDqPOrTn6d1orsJbMMplY+GolTS1CPxQKa8xDXgOoqja+4cZ5UIjejxUK9z/OPJ349npr1PK/w9RvrZSc2fqGMuu4BRDetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+nldWap; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753287181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kPaV9EoGwYB8+Esi3xWvmAXaHLihX39vnwiCRAeH64s=;
	b=h+nldWapBN8rH2cDPCBUnR2TH3GvrOpTGRlf1n9tyldWqWYLH1igrbyk6YbMjWHn9/SpCl
	+9dLlsZJmmwaMHXph6O1wg5ddt6TEL8JVgGMHf293eGFrLuzL2rW+JHJeEupNLHI3fprFU
	xMoWTbmp52QwQyOETvjTuRkWvhncPZk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-0XsRb-NnMmyni74NKtsjVA-1; Wed,
 23 Jul 2025 12:12:57 -0400
X-MC-Unique: 0XsRb-NnMmyni74NKtsjVA-1
X-Mimecast-MFC-AGG-ID: 0XsRb-NnMmyni74NKtsjVA_1753287176
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1417E180048E;
	Wed, 23 Jul 2025 16:12:56 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.162])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B50618016F9;
	Wed, 23 Jul 2025 16:12:51 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/5] tools/verification: Improvements to rv and rvgen
Date: Wed, 23 Jul 2025 18:12:35 +0200
Message-ID: <20250723161240.194860-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This series introduces various improvements to the rv/rvgen tools as
first posted in [1]. It also adapts generated kernel files accordingly.

Specifically:

Patch 1 fixes the behaviour of the rv tool with -s and idle tasks.

Patch 2 allows the rv tool to gracefully terminate with SIGTERM

Patch 3 adjusts dot2c not to create lines over 100 columns

Patch 4 properly orders nested monitors in the RV Kconfig file

Patch 5 returns the registration error in all DA monitor instead of 0

This series is based on the linux-next tree.

Changes since [1]:
* Cleanup python code to improve PEP8 compliance
* Fix condition for long line in dot2c

[1] - https://lore.kernel.org/lkml/20250721082325.71554-1-gmonaco@redhat.com

To: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>

Gabriele Monaco (5):
  tools/rv: Do not skip idle in trace
  tools/rv: Stop gracefully also on SIGTERM
  tools/dot2c: Fix generated files going over 100 column limit
  verification/rvgen: Organise Kconfig entries for nested monitors
  rv: Return init error when registering monitors

 kernel/trace/rv/Kconfig                       |  5 +++++
 kernel/trace/rv/monitors/sched/sched.c        |  3 +--
 kernel/trace/rv/monitors/sco/sco.c            |  3 +--
 kernel/trace/rv/monitors/scpd/scpd.c          |  3 +--
 kernel/trace/rv/monitors/sncid/sncid.c        |  3 +--
 kernel/trace/rv/monitors/snep/snep.c          |  3 +--
 kernel/trace/rv/monitors/snep/snep.h          | 14 +++++++++++--
 kernel/trace/rv/monitors/snroc/snroc.c        |  3 +--
 kernel/trace/rv/monitors/tss/tss.c            |  3 +--
 kernel/trace/rv/monitors/wip/wip.c            |  3 +--
 kernel/trace/rv/monitors/wwnr/wwnr.c          |  3 +--
 tools/verification/rv/src/in_kernel.c         |  4 ++--
 tools/verification/rv/src/rv.c                |  1 +
 tools/verification/rvgen/rvgen/container.py   | 10 ++++++++++
 tools/verification/rvgen/rvgen/dot2c.py       | 20 ++++++++++---------
 tools/verification/rvgen/rvgen/generator.py   | 16 ++++++++++-----
 .../rvgen/rvgen/templates/container/main.c    |  3 +--
 .../rvgen/rvgen/templates/dot2k/main.c        |  3 +--
 18 files changed, 63 insertions(+), 40 deletions(-)


base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
-- 
2.50.1


