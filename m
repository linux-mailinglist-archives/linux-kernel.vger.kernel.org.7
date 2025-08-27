Return-Path: <linux-kernel+bounces-788509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A0BB38582
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAB63AA266
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F9221543;
	Wed, 27 Aug 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fx0+IzNj"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF621CC56
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306500; cv=none; b=dAjSxYLk6h7UTbhAXAKysgJv6YclZIUl86lLceM0fk4Px1qLqKeo5GCi6zlEmKYaeaHIZKytVWo2KI7xsoJa1EVyQZRY2G5MjZgi1D/h7MO7eAAUgazyfgsFp7GpzYdaiw0ub0hG8vo6QVwEcmsFRo5i9PDgkPYpEfuvpAsW1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306500; c=relaxed/simple;
	bh=7/9/ab5DwSdq1kMUFY0n9EWgffcJOonazGOO+MnnqKM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f/NeYSOCg8oNFIeYL+38x13dGezIpZFKxvJ7tgnVDdLgLkNvHXM+aj5jerRD+A9DotIObddEukzvIV98Jg1Mn5geBhgYZmJeyXd1WeCdrXYCJ6XkibL+rAsZPy2vDwMYT4TVgnafFDY6HJYczdOdQlJFMqeEXWnAaydmpbOhjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fx0+IzNj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756306499; x=1787842499;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7/9/ab5DwSdq1kMUFY0n9EWgffcJOonazGOO+MnnqKM=;
  b=fx0+IzNjF8jeN53Gr05dB4Mcmjewpwj34ehiSXQzwOQhD27pt9KaKzrD
   fwoXi24vueRSFXa7ZWrXHPSX8umy0ydZLN5DPA21FkyClnlNqg2bs3O0N
   /ORUWhUN5J6eg7qWbPRCEowdIihYUGpYU+BG8VBVDSi8gxWE+9aXWeyR4
   d3Skfc+bDwoIBPRnRY+NUT9dyPy7BV/7ku/bk4jl98Ni4F2Om2uLL9Tc9
   wrIwRTIzPgmJbazTCt8a15pAiE9rFCd9Ut0DsJ1zrt925f6QTJ3/vVVFO
   CDBNlDw3hPro1qWCzhe/K72akj5ocDrB741guk5aVLfM2nGCPv844ROER
   A==;
X-CSE-ConnectionGUID: K/Go/kCXSc+X6OI3ZHXIsg==
X-CSE-MsgGUID: t5A98cIBRlCdhJ/4uxEw2w==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="45714989"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2025 07:54:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 27 Aug 2025 07:54:37 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 27 Aug 2025 07:54:35 -0700
From: <nicolas.ferre@microchip.com>
To: ARM Maintainers <arm@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Ryan Wanner <ryan.wanner@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 0/3] ARM: at91: enhance PM routines
Date: Wed, 27 Aug 2025 16:54:24 +0200
Message-ID: <20250827145427.46819-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Low priority fixes to the PM code, in relation to recent addition of sam9x75 or
sama7d65 SoCs.

Nicolas Ferre (3):
  ARM: at91: pm: fix .uhp_udp_mask specification for current SoCs
  ARM: at91: pm: fix MCKx restore routine
  ARM: at91: pm: save and restore ACR during PLL disable/enable

 arch/arm/mach-at91/pm.c         |  2 +-
 arch/arm/mach-at91/pm_suspend.S | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.43.0


