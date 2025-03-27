Return-Path: <linux-kernel+bounces-578253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F88BA72D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 11:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F3B7A42CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E71B20E6E6;
	Thu, 27 Mar 2025 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="eonZAO0R"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828520D4F0;
	Thu, 27 Mar 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069696; cv=none; b=D9nZAC9tnAp0ogJv8PeQOdNu6cWOQvDby8jRpmORkCIKnQXlMR9KTLzwzV9CavYysU2cE9hmTfr5IvV6VatX31HekK4M+i1XRCMpY/D6kOIKK6yDw/oECbRdQ46o2FVAhD/wWBwu1TSW/rb84d5STQueVg1C7jRwmN5QuzBngf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069696; c=relaxed/simple;
	bh=yIfuRzewDws0qdrgaeJKZd/01sD49MJY1+ZpyFOCUYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLYB5X3yybdTRAxs/IXJ9lLbhPIQ9NsLhNdFpNQOdpkAcTMG3aHwiBvbRWwrM/rpST2DNdrsSYiKDGNXzRxwIN8eBZGH+UNmb8NxGA4WmBwmjZK41M8F0mg8+YGS1cXVc1+bbWoexQoP6L0jN+2IITaZxS2RgPXGw3F5N6lXt6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=eonZAO0R; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1743069686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7QQj7VDOyudzNy23vCqq1lW73TtfYCugacwtWeM0vd8=;
	b=eonZAO0RA3C+UcFIJ2UdgN3wT5wp1HXtlYR2YCMMVWnHeFIwcNMwUNP8+JU01YOIbz+v01
	w25tep7R1Se354VgGAWI2X9OUZ4bM9Wy2L1rsPDDjxNnCCLbrirRPoweVH57yL36dUjJYj
	U/3EObHkirILazSOVUHr+38DsSPqKdQ=
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@intel.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 0/1] fbdev: atyfb: Fix buffer overflow
Date: Thu, 27 Mar 2025 13:01:23 +0300
Message-ID: <20250327100126.12585-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fixes I suggested are not the only ones.
There are more options for solving this problem.

1.Find datasheet for the chip, find out the register offset, calculate
   the address using the formula (4*Dword offset), add this value to
   the array lt_lcd_regs[] at index LCD_MISC_CNTL.

2. Delete this code completely, as the chip is very obsolete and 
   not applicable.

Found by Linux Verification Center (linuxtesting.org) with SVACE.  

Denis Arefev (1):
  fbdev: atyfb: Fix buffer overflow

 drivers/video/fbdev/aty/atyfb_base.c | 4 ++++
 1 file changed, 4 insertions(+)

base-commit: 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95
-- 
2.43.0


