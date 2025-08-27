Return-Path: <linux-kernel+bounces-788345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ACBB38334
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D697068231C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77A631E112;
	Wed, 27 Aug 2025 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yIcaYk3Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mp/9LVKT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAED33F9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299622; cv=none; b=LjlTZBUUL0rNIIGkiQXoH4h1eZCbNEN/bU+tcssc/6QN4uZ4BeBQ8ie+52YU7ILJiytgUE0qBpGU9JCAbq03M7WVpTMjhnM4lTCFZY5hVghpd63Bb0V/S2fgWhSTMejp9+snxrvXuDO5TZPzpsSbsjQ4WLswFJxi+l54YCtaUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299622; c=relaxed/simple;
	bh=9a2eWPhg67/i6p1Sf9ROqws4cGiIJonBDvT4Vp6TTcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWz7BGxciwdXXPGCWquvRU+q652T9fEpMDv3z86qiLe4CNXyoq0hF4CkVvW49p9aT+nnymasu9SmPs79RtuJ7ztpXZtvC0ehJFcHdHpKZyyTFBsdF0yR0NO8FWNfOlFGr+jcfG1lcpdcqY0WTyPIRrbU878rf9nOn7vZ6gdg26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yIcaYk3Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mp/9LVKT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756299617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aG+WKNFoBhh8hRRqE7RHmVyOQzX6PbZiCu2smWmguWg=;
	b=yIcaYk3YsrluJh6bH+EGVTOtWxCpR79uShW8AGOUOxBlBANuvBY+vBMMDIPsH10xR8hQ7N
	TW44mbUb++JD6qNLKkSeEb3MJeCAZRJu/ZVOmX6PJr/FiH9TtzirHgv5hCzdI5GeqebS2d
	WgttHDOCNBfwQ2VQ2obnNWSrurtAY55sG5c/MmdDyf2eaJbNHsTZAx+XDzGRfP4ALjehnM
	M53s5ejICXyCPP9ddrIncNTzbMPCJ0md8fYd6HraYV0+hq7FH8Jydx/p8KbIAKshK3tPNI
	Bu8xWEzM186qJLhqhOCdQwuHu5pNb6ySLCEE7Chf+w5UBpgEvo9n8hwouAVPKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756299617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aG+WKNFoBhh8hRRqE7RHmVyOQzX6PbZiCu2smWmguWg=;
	b=Mp/9LVKTuSjfICJTFQihy5D6Be2xAu2UEVdN1T0E7Cw920E+uBFtoL2s/wxU3zXVH6ZljR
	/d+beVx8HQWZgbAA==
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
Subject: [PATCH 0/5] selftests/futex: Collected fixups
Date: Wed, 27 Aug 2025 15:00:06 +0200
Message-ID: <20250827130011.677600-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I collected fixups for selftests/futex from the list. While testing I
noticed that the '-g' parameter has been removed from futex_priv_hash.c
but is still used by the run.sh script.

The first patch removes it, the remaining ones are collected fixes.

Dan Carpenter (1):
  selftests/futex: fix futex_wait() for 32bit ARM

Gopi Krishna Menon (1):
  selftests/futex: fix typos and grammar in futex_priv_hash

Nai-Chen Cheng (1):
  selftests/futex: fix format-security warnings in futex_priv_hash

Sebastian Andrzej Siewior (1):
  selftests/futex: Remove the -g parameter from futex_priv_hash

Waiman Long (1):
  selftests/futex: Fix some futex_numa_mpol subtests

 .../selftests/futex/functional/Makefile       |  2 +-
 .../futex/functional/futex_numa_mpol.c        |  6 ++----
 .../futex/functional/futex_priv_hash.c        | 19 +++++++++----------
 .../testing/selftests/futex/functional/run.sh |  1 -
 .../selftests/futex/include/futextest.h       | 11 +++++++++++
 5 files changed, 23 insertions(+), 16 deletions(-)

--=20
2.50.1


