Return-Path: <linux-kernel+bounces-862970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 104F8BF6ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 870D234934E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD04335068;
	Tue, 21 Oct 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b="STk6F8Kp"
Received: from MTA-10-3.privateemail.com (mta-10-3.privateemail.com [198.54.127.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38F125B2E7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052197; cv=none; b=rCMtkrnYG4E/OxiKdWBk8CR8j83+iNDnbMc11GLtj9ma64wIka4G7kFtCSFUNZ55eEgbO9LlLaaUTDtjhhKsSJ+xwZi26dKMhBJ/HsRtG4YxzL/oDICyJBLRYmE2hsszlzZHyM5+jnnBCoNG1XCgI/MXcKDOfuJeGfxuo0Ymk1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052197; c=relaxed/simple;
	bh=8cc/fv7/OOSomgfno6O4D90HKCc6nbLeOKP6JrzujBY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DKKqGKFJH9dS/WDcTFUHAseZTare5jrW8Mcq7wxazHbdKsO4j3vzlHO6o2xDEZK7CO0MnqVryv9/i6OYkUxGGVLJ9O06DjJJJrdJm2bI5I3V3mAG2LMqnoNwl4JkyBXFlKb4InZYKMxZERRff7nIds1L95txiaGkXDRNaNM3//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev; spf=pass smtp.mailfrom=lukowski.dev; dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b=STk6F8Kp; arc=none smtp.client-ip=198.54.127.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukowski.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lukowski.dev;
	s=default; t=1761052193;
	bh=8cc/fv7/OOSomgfno6O4D90HKCc6nbLeOKP6JrzujBY=;
	h=From:Subject:Date:To:Cc:From;
	b=STk6F8KpfijOKfpPhTMQRl9QE0wiwaa+PSkwzOwGM9EbzoaBpF72BX5NvcQ/r1qCm
	 15JUDmGHQTOgFn7UPB3KqMwGF0w23QjZaegh5QN6Ppdu0tErWlQh6bmB6mghQzanEO
	 xILyI7Js9BDCw8r9AzvwrmB4VXibbsAzc4HXMPttV6vwrXfA7hzmh4ALetsvKCbYKQ
	 1xfeiLV1PZmTYO5I/TBdCyUodoywhcUgMZ8Vl4a+GqMd2i1QjE92BaT6tx2eaqdkQT
	 kTbpjOLIdHoWGrOHENPkuxjTm9/VWjTElIFgPsU0F91aBbUDucW4YmNyfiFwE2CAhd
	 pS851kgCpzXfQ==
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
	by mta-10.privateemail.com (Postfix) with ESMTP id 4crXhK5bBhz3hhV0;
	Tue, 21 Oct 2025 09:09:53 -0400 (EDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [150.228.61.72])
	by mta-10.privateemail.com (Postfix) with ESMTPA;
	Tue, 21 Oct 2025 09:09:46 -0400 (EDT)
From: Olle Lukowski <olle@lukowski.dev>
Subject: [PATCH v2 0/3] staging: most: replace BUG_ON() with proper error
 handling
Date: Tue, 21 Oct 2025 16:09:27 +0300
Message-Id: <20251021-staging-most-warn-v2-0-cd51e1e717f6@lukowski.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7Rha25i48h6GRaEjTNDWdKBoC
 He3cgCX7yX//RWEEpPApVohUWbhGAroQwXd4EJPyL4w6FpbVWuFMrmeQ4/PKBMuLgW0ylOryVj
 jHJTdK9Gd33vz1hQeWKaYPvtFVj/7r5YV1mg6709nY9vWd9fHPMZFRj56ytBs2/YFEOz7xLUAA
 AA=
X-Change-ID: 20251021-staging-most-warn-51deb2e454aa
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Christian Gromm <christian.gromm@microchip.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Olle Lukowski <olle@lukowski.dev>
X-Mailer: b4 0.14.3
X-Virus-Scanned: ClamAV using ClamSMTP

This small series replaces BUG_ON() calls in three staging MOST drivers
with appropriate error handling.

The affected drivers are:

  - drivers/staging/most/i2c/i2c.c
  - drivers/staging/most/dim2/dim2.c
  - drivers/staging/most/video/video.c

All changes are mechanical and do not alter runtime behavior, except that
the kernel won't panic if a driver invariant is violated.

Tested with checkpatch.pl and compile-tested (make M=drivers/staging/most).

Signed-off-by: Olle Lukowski <olle@lukowski.dev>
---
Changes in v2:
- Drop WARN_ON_ONCE() per review (Greg KH). Many systems enable
  panic_on_warn; use plain checks + error returns instead.
- Link to v1: https://lore.kernel.org/r/20251021-staging-most-warn-v1-0-4cdd3745bbdc@lukowski.dev

---
Olle Lukowski (3):
      staging: most: i2c: replace BUG_ON() with proper checks and error returns
      staging: most: dim2: replace BUG_ON() with proper checks and error returns
      staging: most: video: replace BUG_ON() with proper check

 drivers/staging/most/dim2/dim2.c   | 27 +++++++++++++++++++--------
 drivers/staging/most/i2c/i2c.c     |  9 ++++++---
 drivers/staging/most/video/video.c |  3 ++-
 3 files changed, 27 insertions(+), 12 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251021-staging-most-warn-51deb2e454aa

Best regards,
-- 
Olle Lukowski <olle@lukowski.dev>


