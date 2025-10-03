Return-Path: <linux-kernel+bounces-841618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A9BB7D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5DA319E3307
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8D02DC774;
	Fri,  3 Oct 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g7cgyxyU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F22D46A1;
	Fri,  3 Oct 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514611; cv=none; b=QyjtN6Xi2wuQtmOSxoZB3sZ+M5WFr+2/oOFm5Y435KMOpd4PRn/EBsjapjav10pA/EWMBScdVWGC08z5wSz5N0MtqyUisaAdjQUpxKizoA4YYS2Aaim+KOi+a9OHJJOOqB/ipjVchNMOG3MMAai277QymxXTOTqOqlnIJ3BTI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514611; c=relaxed/simple;
	bh=pnR0deZzWsEX4dCLYIe3EJzFB+OZ4qgPE9dBJko8/QM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FXQGPCaK+3zR8pCnIZsDLuj6EIT2YgS5qWThyDd6KUfbWm4VNnKgtVHQzZmBXTI2OXfz0kKwBieyKPFUT0F1doAOfv2PXvmm1zntFdPIMavP9byPO6i34fV8tKRQBFD++RNSImqGk0VWQQUWKSsTquoUEXRk9W54Z921vxsKrwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g7cgyxyU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759514607;
	bh=pnR0deZzWsEX4dCLYIe3EJzFB+OZ4qgPE9dBJko8/QM=;
	h=From:Subject:Date:To:Cc:From;
	b=g7cgyxyUegNCY+jcBis5fcLEo3cAxGP+UPrg6YNrhKdGf/yV7oRAzxKuuVNHeBqWL
	 N2e9rckxpOkdG34q0yc6u5zp7x3IfW6mDhAjs97uYpO6eoHtFhWGVn/2vkGkbM0Fwe
	 qQFcLle2MdU5RxGFtiMOplwZ5LMRgPPvzDvVIyi/wP1zAwxmwoDPKvZI/CTg+zYQjO
	 yuPbAJL6iHsWAIwqhElpM2SgJVhADrkwEXP7ZOQrS1EF6q0IV6R7zcrvVAB335sDMi
	 RmOlEgxj+fq+E3c3BtwBaZ+xmw3Cu+mwuWH1EqPdg05T+d6Vy9+X+qeo6xduLQuIxF
	 IVXyWOIt2yvUg==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 7E67C17E12F3;
	Fri,  3 Oct 2025 20:03:27 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/5] ASoC: nau8821: Fix IRQ handling and improve jack
 detection on Steam Deck
Date: Fri, 03 Oct 2025 21:03:22 +0300
Message-Id: <20251003-nau8821-jdet-fixes-v1-0-f7b0e2543f09@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOoP4GgC/x3LTQqAIBBA4avIrBtQ+7OuEi0kx5oWFloRRHdPW
 n483gOJIlOCXjwQ6eLEW8hQhYBpsWEmZJcNWupaSVlisKcxWuHq6EDPNyX0rS0bX01WdgbyuEf
 6Q/6G8X0/zf3UjWQAAAA=
X-Change-ID: 20251003-nau8821-jdet-fixes-f7a36f4ca098
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Seven Lee <wtli@nuvoton.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

This patch series addresses a set of issues in the Nuvoton NAU88L21
audio codec driver related to interrupt handling and jack hotplug
detection reliability.

The changes focus on:

* Eliminating race conditions between jack insertion and ejection events
* Ensuring interrupts are consistently and correctly cleared before
  unmasking
* Introducing a DMI-based quirk to bypass the jack debounce circuit on
  Valve Steam Deck, improving detection accuracy under stress
* Improving robustness of the IRQ handler by avoiding unnecessary
  blocking operations

The series has been tested on affected hardware to verify correct
behavior during repeated and rapid jack hotplug cycles.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (5):
      ASoC: nau8821: Cancel jdet_work before handling jack ejection
      ASoC: nau8821: Generalize helper to clear IRQ status
      ASoC: nau8821: Consistently clear interrupts before unmasking
      ASoC: nau8821: Add DMI quirk to bypass jack debounce circuit
      ASoC: nau8821: Avoid unnecessary blocking in IRQ handler

 sound/soc/codecs/nau8821.c | 129 ++++++++++++++++++++++++++++-----------------
 sound/soc/codecs/nau8821.h |   2 +-
 2 files changed, 81 insertions(+), 50 deletions(-)
---
base-commit: 47a8d4b89844f5974f634b4189a39d5ccbacd81c
change-id: 20251003-nau8821-jdet-fixes-f7a36f4ca098


