Return-Path: <linux-kernel+bounces-826116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EB8B8D930
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 12:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774CF17A878
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219D2512F1;
	Sun, 21 Sep 2025 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="T9HuMCuZ"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B119D8AC
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758449046; cv=none; b=U+EL1NXfV68Iw86zTR+G0H+gOGRZxfTZtndCttCjELlBAIDctmeAmL5L+piMXrVdbxFouHEPnQ6edXw75tZqgeOKpP/XslafQGnNrFGdtGumvOrCRmL5wSp+asoxe4Bwj8ESX5KJjqeXNHlLbbTwGzMiCK/3zkxNg54bTN/NosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758449046; c=relaxed/simple;
	bh=xZZa2Jz2WA7YryhDhvodNYvhGdEYAfnBL3pN4bsZvxo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P3FCvUfwBrvXCYoyLRp6dI7ShHO2fxJpmvPSAC2SgTyQBZd8jGzaYfZ/4Ngw0Ikfuvy7IOcTZ97kRBtp23BW/3laBlmpjxQ2yI1uEFP+EUMAjt2Z2I6VFtFsLAY4o9gYZsS78TEOsJXxROInYRfzU6z4zOaZhig5OINdFaz5RBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=T9HuMCuZ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cV1zh5wLGz9snn;
	Sun, 21 Sep 2025 12:04:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1758449040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yjptQbraHLFs6zmoKSZrQfLCVHInBho8ridTsBdHUR8=;
	b=T9HuMCuZXKemULNrQpDRl/7wimwvak3ft3PVpHecVKBZEfb9ivQ5r3tkCLTU73+yAvSDL5
	amZaQ09TnJobe9BI6wfqyb2TyD3PS9WyWp+ASVDdDU5CLkI4abSlHXGe5TTSs2qcrEAgVU
	4ZVgrjULL2k4NRcdmiot4VBi3juBSgFc+ZjebLuTiiaIR2aju3gWNsKi10RQ1u4MWXEj6V
	FfFuCAEi80jZyjDv1gNfCL9Rf9BPS1UZ3UhNSPknwLKVLT7HTDX5mvHNlgEExU5QDzqoMM
	44sMbR9o9BwdDDhYfKQFHx3Iwavoi/8u/lnyWlyfO0v3OuFy9c3fP3WRWj8QXA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 0/2] minor fixes to faddr2line
Date: Sun, 21 Sep 2025 12:03:56 +0200
Message-ID: <20250921100358.19986-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cV1zh5wLGz9snn

From: Pankaj Raghav <p.raghav@samsung.com>

The first commit fixes the issue I am facing in NixOS.

The second commit uses a tempfile instead of shell variable while trying
to read the elf file.

Pankaj Raghav (2):
  scripts/faddr2line:use /usr/bin/env bash for portability
  scripts/faddr2line:fix "Argument list too long" error

 scripts/faddr2line | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)


base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
-- 
2.50.1


