Return-Path: <linux-kernel+bounces-747076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE253B12F68
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCC718996E7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B4620C00C;
	Sun, 27 Jul 2025 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZbGyrPhy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lx6tdLwj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E57DA9C
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753617499; cv=none; b=jRAg1n/DwXD4HwRkbCC2K6MV6Q1ZhdHA+YzakSrQO4fuu4I4TXWEDYMtbCIc+nPHzhm5G8Oi7a2kK2FX2OouCkoUdAh0cUAOW8EpbUWjO4M7aje1vNQoyH3DEBdnvnyBTHDQpm948SLNLm+OSzXz8lfZnElo8I1/Qx/FtAZhEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753617499; c=relaxed/simple;
	bh=vQiS9WsDhvmmjcrxNFhCLW21Prq4GXFSk3wYrkHthQE=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=HyL3PxpBxHUFGJF0hpctNa0+6ajm5KJtp1E7Y7BT6eG0q9Ket+oKlzB4zdMCYhJrTNLH/W0FvTKqwRXiHOTfn5TTjcPu7CCnwxulF8C+hVekpK7L8PlVxN58QLYrXwNiNam8ezSurb7U8IIowMDZbYAGmDtRi0y6pCJhBd+1EJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZbGyrPhy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lx6tdLwj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753617496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I+zuwacxWYZl6TUKC6lPLqxDk0VR8ir+oCHy5XPhScQ=;
	b=ZbGyrPhygBKXjyzRbVDRVe9pYZ7kkRgrN1s7EugYslH8bxRcu7FKrHDtPXIkp4BBG/5ozU
	cWZ4Bi/l956iK6VhyUlpevQWA1/WQETYwd5VQiHN9N6fN0O5qqSDG+bpyQltlnIsb4FB3N
	GVVSS+fUhp9/4TB+y1YLUup3qS2i3yvgZ3T8xhejEeSdTyIiSqaLKVrAtEYW7BalORPwEV
	5uc2tC070vKDJ2OMKKEIDgS8Wycos3DU/pVg5m4ILmQnMgY6l4MOANeNhPE9xXvXExcFIJ
	OAO6GC3rypv1Tb794YDBJzpGI7v46T14SqC090ucUYc1GyVjWSqpoID/PykUVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753617496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I+zuwacxWYZl6TUKC6lPLqxDk0VR8ir+oCHy5XPhScQ=;
	b=Lx6tdLwjL8XsVhS1Bjf7NsGpnMcrl1C51CtuK4CNm7JUWoKfUupFIQYGciYnWByjcIN512
	fyFykP/eu4GGXrAQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v6.16
Message-ID: <175361748735.557480.6049747546698820190.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 27 Jul 2025 13:58:14 +0200 (CEST)

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-20=
25-07-27

up to:  67c632b4a7fb: timekeeping: Zero initialize system_counterval when que=
rying time from phc drivers


A single fix for the PTP systemcounter mechanism:

  The rework of this mechanism added a 'use_nsec' member to struct
  system_counterval. get_device_system_crosststamp() instantiates that
  struct on the stack and hands a pointer to the driver callback.

  Only the drivers which set use_nsec to true, initialize that field, but
  all others ignore it. As get_device_system_crosststamp() does not
  initialize the struct, the use_nsec field contains random stack content
  in those cases. That causes a miscalulation usually resulting in a
  failing range check in the best case.

  Initialize the structure before handing it to the drivers to cure that.

Thanks,

	tglx

------------------>
Markus Bl=C3=B6chl (1):
      timekeeping: Zero initialize system_counterval when querying time from =
phc drivers


 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index a009c91f7b05..83c65f3afcca 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1256,7 +1256,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 				  struct system_time_snapshot *history_begin,
 				  struct system_device_crosststamp *xtstamp)
 {
-	struct system_counterval_t system_counterval;
+	struct system_counterval_t system_counterval =3D {};
 	struct timekeeper *tk =3D &tk_core.timekeeper;
 	u64 cycles, now, interval_start;
 	unsigned int clock_was_set_seq =3D 0;


