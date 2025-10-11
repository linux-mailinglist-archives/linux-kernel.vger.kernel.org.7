Return-Path: <linux-kernel+bounces-849207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF63BCF81E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77531189B668
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DE027F177;
	Sat, 11 Oct 2025 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Qh9eIihT"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6A238C36
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760198788; cv=none; b=B8oKmJpZ5nwFNNdl5e1NoFtdjcT4jitunWbINHQHHoS0iIH2FZfQBbq+zF51O6T7GxNXR14C1opDhKgjnhPAuTVZHd+sKj2vkXvsuhuFX5kyk3OVBz6XPCXPEg7lTIFKRR4WSXvV0FTbyjBdII/FoNuTLoYzs444zzNyeb8IsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760198788; c=relaxed/simple;
	bh=JjIh2lczLKwDIwSKF4BwhHpOJKcgjiv/kBCLDU2dBes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JBexplaRbvJnuLMlsqY4yrFgPxT5USrN5iMlSQFwR2eX8GYObi0iMJxaGJSX5F817ZOFaKRe+kjnO19iJdAr6VEbc7vGyzIrtT09/JaFjPvUFaq9+KeCJq92vLMxHuAK4JBg/NtOSfdERy5+CNd3hLZnZNWqG1Nn+3QfMMrgXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Qh9eIihT; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 6CE85240028
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 17:59:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760198379; bh=q4xApVDsw0fLR62UrJyoTIkPSGQkWROQJLk1KxBMKUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=Qh9eIihTTB4hK4USWQlVgkJEg67jC3diHwwUHZUxKi4M3UJnumb5BHRopAUfeOesV
	 ySBJ9voDp6C0Pf2aU1hCp83aXqw/AXrnbcSBR3UeEGeVyh3Cg8v66E/zobHJuctvYC
	 eYOYPQYNWDWYb4EmrtKKTp8MOle1vmLyx9NEwsgGY/mkObV9iYzC4Z7GEXcF6pIZ5W
	 7IDWBynp8H9f4iZC9u01+faVuGTzRqgVQ8tLZmeyUfqQDVN4kZdYapH85jlkzx6dwc
	 h0dOfq1y8NB76Ma6+eJKDcIvEUr4va0ArIN3ojMRbH+BWPIy7E8Onu19d8kMYXmlpq
	 soJbJ3wEcKQ2Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ckSwp69sxz6v1c;
	Sat, 11 Oct 2025 17:59:38 +0200 (CEST)
From: =?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
Subject: [PATCH 1/3] mailmap: update name and email addresses
Date: Sat, 11 Oct 2025 15:59:39 +0000
Message-ID: <20251011155903.7442-1-martink@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Apply my new surname, remove unused and update to currently used email
addresses.

Signed-off-by: Martin Kepplinger-Novaković <martink@posteo.de>
---
 .mailmap | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index d2edd256b19d..8a19cb96f448 100644
--- a/.mailmap
+++ b/.mailmap
@@ -494,9 +494,7 @@ Mark Brown <broonie@sirena.org.uk>
 Mark Starovoytov <mstarovo@pm.me> <mstarovoitov@marvell.com>
 Markus Schneider-Pargmann <msp@baylibre.com> <mpa@pengutronix.de>
 Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
-Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
-Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
-Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
+Martin Kepplinger-Novakovic <martink@posteo.de> <martin.kepplinger-novakovic@ginzinger.com>
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> <martyna.szapar-mudlaw@intel.com>
 Mathieu Othacehe <othacehe@gnu.org> <m.othacehe@gmail.com>
 Mat Martineau <martineau@kernel.org> <mathew.j.martineau@linux.intel.com>
-- 
2.47.3


