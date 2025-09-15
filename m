Return-Path: <linux-kernel+bounces-817797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D2B586B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36F264E24FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058012BFC9B;
	Mon, 15 Sep 2025 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BWZfsjpr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IpZoBQ6F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF04283CB8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971598; cv=none; b=h9Ff116UjdNXrLLBgKLxyqAhxURKYYfmrObOgNZmGGosocMojPBrHzPwkD8F/jwOsV8Ep5bDowKMh1mAiCA9an3v0wViU01hrPpfBhe867xJoGRRBLxbZ/I+JzIyTy+fe/sVYBjLDyzj/EQHTpaQQ3tcFghHEFniOgGdRgiZVZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971598; c=relaxed/simple;
	bh=D6sIVYY3P1TBnnNpjinv8kVN25Q6mrQFWt+vKPNq0xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H2TtdKMC2ufwnRQqo1Dv0SyFmU/XXv2o2k6Uj5ePEVpKMcDlh8OX/q9+D5ZgOB1jPMjWGBEEufC4JGyFGPrls8Vq4iq9pgcbKYsPkZuvzzWIw06TGLDBLWoOTUUBjejx0Rts7SZvw/eBx3KR6llyowHzjsEzLiUcDyFR1iXx5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BWZfsjpr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IpZoBQ6F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757971594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ExvizeMH7MynguvkFfuqqNp6MBjV+qEDaYBR1aGXmIA=;
	b=BWZfsjpraQbYOJeoSL7WZbCTqs6YZcxcI47kkcKvIyk5Py0/eQGjIjTIC77mfGyQh/sGVT
	5Jqw9boFdV3e+yWoIBxOa+jqIOd+UPl4F5RuEN842mMWLXYNilFPNrARTH1I4zC0Jh5YUy
	0qxso+FavD+iIQv9+n7XIsX51I3hDp6SL1GakRCpUsS4FkyjOFBuAInfqBaGFhL62wlU9S
	e74jdJ5oPsqyxnWQZ7rntNd0OnXvfslQspU7L+HVRDJnuSZTe3+WQwLROQLIkvVI45CuzM
	tV/5oVQI5j2XsjujjoVyvT6csI6sPLKqiUXr+Dcg+Y8J5Gw1jMvHx6hByjJxGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757971594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ExvizeMH7MynguvkFfuqqNp6MBjV+qEDaYBR1aGXmIA=;
	b=IpZoBQ6Fxj3jqczfRVe/Uc45wJnAT3Iyu17bqg70Kkulyt3Zny4aFZaRRg/0zKWfMjmrTO
	RCkcdUNd06rhAuCA==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 0/3] selftest/futex: Collected mpol fixes
Date: Mon, 15 Sep 2025 23:26:27 +0200
Message-ID: <20250915212630.965328-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I collected Andr=C3=A9's two mpol related fixes and reworded slightly the
description of #1.
Patch #3 was also on the list for a while and now does no longer apply
so I rebased it on top.

Andr=C3=A9 Almeida (2):
  selftest/futex: Make the error check more precise for futex_numa_mpol
  selftest/futex: Reintroduce "Memory out of range" numa_mpol's subtest

Sebastian Andrzej Siewior (1):
  selftest/futex: Compile also with libnuma < 2.0.16

 .../selftests/futex/functional/Makefile       |  5 +-
 .../futex/functional/futex_numa_mpol.c        | 61 +++++++++++--------
 2 files changed, 40 insertions(+), 26 deletions(-)

--=20
2.51.0


