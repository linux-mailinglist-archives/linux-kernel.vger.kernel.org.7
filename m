Return-Path: <linux-kernel+bounces-764089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAF2B21DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6993AE504
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FD12E2835;
	Tue, 12 Aug 2025 06:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q5IUO/Md";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ytUXTvqq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ECD27602D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978656; cv=none; b=MAgHmAfisJuOSPcqCl/8z7h1Fqr8XPNgFeq5DfAP1yJNhxPgFTpMkCq48CcHhJLDyrLky3MovlxZIeOygye5Dozlzqhq1Ks9wLTNytPUpL2sE5a0XnfTLZd7XMfRQ2E+BD2SKzQaLkoVyDW5nqnUnhskRoUN3wX3DnrnAHbgRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978656; c=relaxed/simple;
	bh=lBwChGViG9IQ/xOQwgTpHQt2WBljXDP0mkqC1oXpmhA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rDM7iDKDww/xPLBld5kGapF9KVKVnt6dqixFRJcP/F+Uc+ffOPcpe1n9TPNqGr/6BULRPAxhozeph2NLX6qihi+T8O6OkoPYtDtq/Qw1OQoN+mjTg+rvu3zHUu/nWAxx1yoUpc9s33uQ1yp7kI2IJSqVByKFv7ypa9Si0sQ4AOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q5IUO/Md; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ytUXTvqq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754978653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4QDQETyc20JdZDZ2r1xwd/4uC2WlIt36s5xFf0a8pfY=;
	b=q5IUO/MdaGWjhBqb5ckhDG7czo6RN1lisDUtYtrsUDR1T/NweioqQXwW/WsnV/gjLHU695
	/AqZxPxSfm4hWeDI0VCwUt/vcmSV5lKFE19AT4u299BI9CZLS8/e4FQFAPeFhVOm3OTV0F
	25YcDoxSDUBKbdgrmZomIvRq+KsIFL0Ee681JdFt85Ym6DWVypQ75xDEVn/6K8BpKrzoKN
	cGCARX7NVTV3Z+vnvAKZjXMB/QAbA1gwCokfHiv4Sfop2c3Os/TIOPmi0JHAur9nq6MpIe
	veJ3mtcEovioJgFKdtgqES6ZG7HrFfRlo7+Bx30sE7nPhBPY84uIHrpGVfuNhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754978653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4QDQETyc20JdZDZ2r1xwd/4uC2WlIt36s5xFf0a8pfY=;
	b=ytUXTvqq3YrD5lmJoam8hvcFm2YakZiE3iCOfoVQFZATdUqucrXoKJE7iN8FjznnqVrALV
	34kcv/Wtt8eUG4BQ==
Subject: [PATCH 0/3] vdso/datastore: Allow prefaulting by mlockall()
Date: Tue, 12 Aug 2025 08:04:02 +0200
Message-Id: <20250812-vdso-mlockall-v1-0-2f49ba7cf819@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFLZmmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyND3bKU4nzd3Jz85OzEnBxdEzPDpCRjYyMD0yRDJaCegqLUtMwKsHn
 RsbW1AH7Cs15fAAAA
X-Change-ID: 20250721-vdso-mlockall-461bb33205b1
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754978653; l=846;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lBwChGViG9IQ/xOQwgTpHQt2WBljXDP0mkqC1oXpmhA=;
 b=FYM+98ZtLiHxVkPDixHVMurTvpa6w6VPNZkV9sbEQyodZGvSmhLzvirxg1nLnmNts6BicPPhn
 7mR/WigulJaCNjFFAy0WDqUzJIaO4q3dMcbvggdLL54IOy9gJzMsXzK
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Latency-sensitive applications expect not to experience any pagefaults
after calling mlockall(). However mlockall() ignores VM_PFNMAP and VM_IO
mappings, both of which are used by the generic vDSO datastore.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (3):
      vdso/datastore: Explicitly prevent remote access to timens vvar page
      vdso/datastore: Allow prefaulting by mlockall()
      vdso/datastore: Map zero page for unavailable data

 kernel/time/namespace.c |  7 ++-----
 lib/vdso/datastore.c    | 38 ++++++++++++++++++++++----------------
 2 files changed, 24 insertions(+), 21 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250721-vdso-mlockall-461bb33205b1

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


