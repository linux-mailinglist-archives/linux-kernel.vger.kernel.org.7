Return-Path: <linux-kernel+bounces-622079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3796FA9E2CE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 13:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9173B7A9ED0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 11:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632E62528E5;
	Sun, 27 Apr 2025 11:35:45 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 46D9B250C14;
	Sun, 27 Apr 2025 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745753745; cv=none; b=B17vyKzwfZEcrWA4LymNtW8HjA33uF12TU5PyeNBVE2tln7DZR8fz6XXgMhivolVyx0ylsBK+pHNjeeIHoqweypBDEC5gntLZMtFIhMdyEznrG3aAED1MOQ4YqJJxAOTLoxccY9s5n2Syfkc2uh+z3BOLa3mWtbB4xpx9FTFkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745753745; c=relaxed/simple;
	bh=4iic99CSTrCgezl0wafUvtYGM6RZbIUL1twLDdeoMSc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rOKNQVcjIXfY5M+ejkJ9QGXN3jSin42N31bpFWtcM0t1/8MsHVn1l+7wlfqgQhRON9vmfFtaETLB9Et1/C/FqXU0vMmLX1uvJ42rMWoBw2kSitgM772hdx4NgeM3I+/UmvdpYJ+5jaGspQFMLYFQP+m9TIePPguDcXCniJBPres=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 9115F6019643E;
	Sun, 27 Apr 2025 19:35:37 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	eahariha@linux.microsoft.com,
	luiz.von.dentz@intel.com,
	geert@linux-m68k.org,
	anna-maria@linutronix.de,
	ojeda@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 0/3] time: some cleanup for jiffies and alarmtimer
Date: Sun, 27 Apr 2025 19:35:27 +0800
Message-Id: <20250427113529.1473800-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some small cleanup for jiffies.c and alarmtimer.c.
Compile test only.

v2:
 - remove some guard() useages in patch 3.

v1:
 - https://lore.kernel.org/all/20250424144819.24884-1-suhui@nfschina.com/

Su Hui (3):
  time/jiffies: change register_refined_jiffies() to void __init
  alarmtimer: remove dead return value in clock2alarm()
  alarmtimer: switch some spin_{lock,unlock}_irqsave() to guard()

 include/linux/jiffies.h  |  2 +-
 kernel/time/alarmtimer.c | 62 +++++++++++++++++-----------------------
 kernel/time/jiffies.c    |  5 +---
 3 files changed, 28 insertions(+), 41 deletions(-)

-- 
2.30.2


