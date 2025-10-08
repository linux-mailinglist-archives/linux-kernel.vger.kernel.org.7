Return-Path: <linux-kernel+bounces-845780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE755BC6166
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267F519E3C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7152EC571;
	Wed,  8 Oct 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pfGJOKiA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EB2BEC23;
	Wed,  8 Oct 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942507; cv=none; b=I8MLYfqRcSWQzdZ+EvBKroFOGC/jj1HXJqiWQKCax4Ah3UsSgcTzbHah/wPs+u+dEQesh2wiM3MFJFVwwQyg4XcenjPkaCakDc0gxBeWqel1yNhO665NdNITP4BTahVL1cm8neStRvuF+5PD0W9aF1bQ6HL7ULNfJPMobDfPl8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942507; c=relaxed/simple;
	bh=n4wyXxtwofLlyZouQQ3C6jrZMbSj9OltW5+4ANoXjHY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Uw0jsKN5FgtxZcYmAuqwPZsqcYYeK81/MXJB8QybZbWv7Uj8OpfAqIalqH3p28r/31RYzWEScq0yj9sqBqHNupB21xRZRsGqt8NVxPamA9rTSXXYl/aZbt7HaYmnumKUgMrYPsMbqrXewfzr7spLpaRnmAU9MQVJlhkAUgYfWFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pfGJOKiA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759942496;
	bh=n4wyXxtwofLlyZouQQ3C6jrZMbSj9OltW5+4ANoXjHY=;
	h=From:Subject:Date:To:Cc:From;
	b=pfGJOKiABPkMGQNbnF8Pg5JfQggyNux0s4gj/ZDkjbFO/VIy7mc3uAjgJlXbm9MW+
	 IbJGanPzef6mSQhsPkwcUr1Ba4WBY7dOgMX8VZW8+FSwIbdnMLL42HzsxO8lUoYpkR
	 wM2pqUo9o9YC52rK9UF9/h3YbcBVowg76VwUDndgJDwOK5661jpsMax5saa27/Q7Ts
	 0zW7wXkbOJ3d1ftRUuLId/DTOMfIR2a4ggNW9cfqRv9mzH3UyTCrQp+PgHDbkTHOQf
	 E+eQvwL2kJFqfQvjrNEiiZXrBbJjpAiHylmUT7w0weW3PfGGGBuL+fD/RTiKohyv2i
	 k4jPkJn0xhb/w==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id AB10217E04DA;
	Wed,  8 Oct 2025 18:54:56 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 0/2] USB/IP VHCI driver cleanup
Date: Wed, 08 Oct 2025 19:54:25 +0300
Message-Id: <20251008-vhci-hcd-cleanup-v2-0-b6acc4dd6e44@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEGX5mgC/32NQQ7CIBBFr9LM2jFAaRtdeQ/TBR1QJqmlASWah
 ruLPYDL95L//gbJRXYJzs0G0WVOHJYK6tAAebPcHbKtDEqoTpyEwuyJ0ZNFmp1ZXiu2QhvbD1J
 2toM6W6O78XtPXsfKntMzxM/+kOXP/olliQKl1b3SA02q1RcK82ymEM2RwgPGUsoXMNwcsLQAA
 AA=
X-Change-ID: 20250902-vhci-hcd-cleanup-304ad67115d5
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.3

These patches were initially part of the USB/IP VHCI suspend fix series
[1] to address a bunch of coding style issues and make checkpatch happy
for the entire driver.

As suggested by Greg, I'm sending this as a separate patch set now.

[1] https://lore.kernel.org/r/20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
- Dropped patches 1-15 and collected the Acked-by tags from Shuah for
  the remaining two patches
- Added back the now missing pr_err() -> dev_err() conversions that were
  initially part of "[PATCH 15/17] usb: vhci-hcd: Do not split quoted
  strings"
- Rebased series onto next-20251008
- Link to v1: https://lore.kernel.org/r/20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com

---
Cristian Ciocaltea (2):
      usb: vhci-hcd: Switch to dev_err_probe() in probe path
      usb: vhci-hcd: Replace pr_*() with dev_*() logging

 drivers/usb/usbip/vhci_hcd.c | 90 ++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 44 deletions(-)
---
base-commit: 7c3ba4249a3604477ea9c077e10089ba7ddcaa03
change-id: 20250902-vhci-hcd-cleanup-304ad67115d5


