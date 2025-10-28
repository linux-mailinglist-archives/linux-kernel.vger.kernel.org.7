Return-Path: <linux-kernel+bounces-874290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486D2C15FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8ED3AE506
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52633F8A3;
	Tue, 28 Oct 2025 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mkxZ0GO3"
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C36A20C001
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670279; cv=none; b=R+jpYheGC26MBFN/37KEoWDJU6uhTFBKTAxeo2lR7qQarid5EkZRFmpI5BG4qlPFInbng23aEowJMlkOqvQBUxU2zRXjPVSmfMvkiVmhJ7k2rvuIrt/7SqHx0mvIY7NhJSVnmiKq2d+Jpy4O9QlRFMbCb1gI0+uY8ppE0MJSDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670279; c=relaxed/simple;
	bh=Ga1CqCoYwr6o//C4SLBHCH5B1129dnFraC5v6XZcwZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JpkcWetT8fBi+xtRPGCPA1o1l5b3nLTQtT91a/+DgkNxQLC7XjbTk3LcDWPbZJgehG4Vvf/w5TcASzx2YT5xmR8Z6EuuvngE+1ET4BqoYFxdSvfE+Y/PGOAWq9eDvSw+bV7USd7essmqPBi4THz9aPYc1IOH0CNBafvgtA6PeZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mkxZ0GO3; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cwxGX10BPzltP0f;
	Tue, 28 Oct 2025 16:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1761670275; x=1764262276; bh=XTmhfqqkIXLKh43gBXzcnBY8w39My0DaJdC
	IrUK/vbE=; b=mkxZ0GO32jgxxI2CeXWGxaad01saapSIifpEcXU+UWTkQ6Mtl5z
	b/dGb9TTGpSowDmzHEGoBQt/3X8Wje9Q+1NKk/8krT3FGcuy7U3xYNrj3ZeBSzpF
	kuvgKzSZbxEj1d/OIaSivNHAZJXTVTDTQbFKX1bVQbrt8kgZ2MkrUtYz3ABFDNQy
	TVHWZhafB+XBSC/pHyPPy4rJmqlk/nx9ifbLrJjExW2JU8huQuDZUIveMLK0vrnd
	mGi0z5uQQR96RdGOM1taLz8BiIF4ZrQBo6uFUUn2kettVCa+GEtMRWNammWWUa/T
	5jjfLrlgZXenmcTPCH4DMp4kIIRKRpsr5yA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id N3jDI1r2n8fg; Tue, 28 Oct 2025 16:51:15 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cwxGS2wFhzlw64T;
	Tue, 28 Oct 2025 16:51:11 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Restore and fix SCHED_WARN_ON()
Date: Tue, 28 Oct 2025 09:50:56 -0700
Message-ID: <20251028165059.682306-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

Using WARN_ON_ONCE() or any other code that calls console_lock() from the
process scheduler may trigger lock inversion. This patch series fixes thi=
s
by restoring the SCHED_WARN_ON() macro and by changing its implementation=
.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (2):
  Revert "sched/debug: Change SCHED_WARN_ON() to WARN_ON_ONCE()"
  Fix SCHED_WARN_ON()

 kernel/sched/core.c       | 22 ++++++++--------
 kernel/sched/core_sched.c |  2 +-
 kernel/sched/deadline.c   | 12 ++++-----
 kernel/sched/ext.c        |  2 +-
 kernel/sched/fair.c       | 54 +++++++++++++++++++--------------------
 kernel/sched/rt.c         |  2 +-
 kernel/sched/sched.h      | 26 +++++++++++++++----
 kernel/sched/stats.h      |  2 +-
 8 files changed, 69 insertions(+), 53 deletions(-)


