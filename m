Return-Path: <linux-kernel+bounces-886296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1116AC35380
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DDF6207BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96F0309DCF;
	Wed,  5 Nov 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmElAKMg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839CE306B00;
	Wed,  5 Nov 2025 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339481; cv=none; b=JbW37Mb9adnmI9aHdEbeba8V19Rq2qZhrIGFgwEmNZTV0IX5OrWXORs85gZDTT4SyxnnazkGrOAeb4Y4i26X7RpkX8RvdifobshiJwu8CetL4nf790Xxb7QGx/DjIupE+bp9ijWNMWlM72/TKY1JrPSo+4geQaox1eoLKh7WtHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339481; c=relaxed/simple;
	bh=D2OPaV/N+ShGujg/usR9RQSQG6FixJvGWqb+QpPi9Mo=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=THAd/yVsl84+wqAQ+AMqBFw0ffhiGNKi75fihndUVZC4G5OqpHvv55JkcyY4vtwQoI5NZm25uEyn+Xbj8ohi6IlnZ8RrwcKtlV4LW62XQZP7AtPwAoZeQB6yO/DYAFlIJwumGQVjnwqTm2M7fCOJ6J8I1dOJ8zXnooLplg6C95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmElAKMg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762339478; x=1793875478;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=D2OPaV/N+ShGujg/usR9RQSQG6FixJvGWqb+QpPi9Mo=;
  b=UmElAKMgJ+Uw6+gP0wpAuEutJ9MQUkud1xDmJ0Dp5lQqcXBUXuQmmFTJ
   p/idRz0VQWjmwl2+28vQ0EZN4Jr1av2sHjU++E80hO5tC9aqwG8ciQr2o
   YsVixNJ0y6Sz90W4mjyuKeBl+rVNSilD1DvUS9JOST98SA6mWUVEJRmeG
   5lsvOZIfRSCch77laI/XWxli6HPltNNiWB46Dk3k1uTWgfr/tmcafnQKK
   APpou0OH52P6tLjJM7X6EtLQpkrOYNFW3Vda8wVB34IDXO7C2XL0W00By
   +tXHq0LKyHVI6dAf2ghbi2m9Sep0ZgNYvrRna/e6LHVJ4ydHqSYaxryyu
   w==;
X-CSE-ConnectionGUID: hMx4K+ufQkO8b7z1Qb0gfA==
X-CSE-MsgGUID: Z50TqMSoTiCfcSzY6ESZWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="67066128"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="67066128"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 02:44:37 -0800
X-CSE-ConnectionGUID: mTPu+iCOT5KTheZ9VmPT4w==
X-CSE-MsgGUID: lGLGeO5rRAC2khOwzosehQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="187111770"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 02:44:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 05 Nov 2025 12:37:05 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.18-3
Message-ID: <pdx86-pr-20251105123705-1390915696@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.18.

Fixes and New Hotkey Support

- input + dell-wmi-base: Electronic privacy screen on/off hotkey support

- int3472: Fix unregister double free

- wireless-hotkey: Fix Kconfig typo

Regards, i.


The following changes since commit 34cbd6e07fddf36e186c8bf26a456fb7f50af44e:

  platform/x86: alienware-wmi-wmax: Add AWCC support to Dell G15 5530 (2025-10-15 11:22:35 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.18-3

for you to fetch changes up to bd34bf518a5ffeb8eb7c8b9907ba97b606166f7b:

  platform: x86: Kconfig: fix minor typo in help for WIRELESS_HOTKEY (2025-10-28 20:13:21 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.18-3

Fixes and New Hotkey Support

- input + dell-wmi-base: Electronic privacy screen on/off hotkey support

- int3472: Fix unregister double free

- wireless-hotkey: Fix Kconfig typo

The following is an automated shortlog grouped by driver:

dell-wmi-base:
 -  Handle electronic privacy screen on/off events

Input:
 -  Add keycodes for electronic privacy screen on/off hotkeys

int3472:
 -  Fix double free of GPIO device during unregister

MAINTAINERS:
 -  Update int3472 maintainers

x86: Kconfig:
 -  fix minor typo in help for WIRELESS_HOTKEY

----------------------------------------------------------------
Hans de Goede (2):
      Input: Add keycodes for electronic privacy screen on/off hotkeys
      platform/x86: dell-wmi-base: Handle electronic privacy screen on/off events

Lazar Aleksic (1):
      platform: x86: Kconfig: fix minor typo in help for WIRELESS_HOTKEY

Qiu Wenbo (1):
      platform/x86: int3472: Fix double free of GPIO device during unregister

Sakari Ailus (1):
      MAINTAINERS: Update int3472 maintainers

 MAINTAINERS                                            |  3 ++-
 drivers/platform/x86/Kconfig                           |  2 +-
 drivers/platform/x86/dell/dell-wmi-base.c              | 12 ++++++++++++
 drivers/platform/x86/intel/int3472/clk_and_regulator.c |  5 +----
 include/linux/platform_data/x86/int3472.h              |  1 -
 include/uapi/linux/input-event-codes.h                 | 12 ++++++++++++
 6 files changed, 28 insertions(+), 7 deletions(-)

