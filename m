Return-Path: <linux-kernel+bounces-895654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6461CC4E940
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9D474FAF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69AC345CCB;
	Tue, 11 Nov 2025 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPqkypRX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719EB344046;
	Tue, 11 Nov 2025 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872075; cv=none; b=AyYh8zdkMQjEPGXRsLMkvBD+Sr3754nj1HYCDxO6yLWFazsADhVlOaVKJXYyEddmRuEZgAwUpNrf0IUB4Ih71UM0Vq/eV2Z7Ayw6vCvkYyddZCq8Vo/F6lJ7tjXMauy9f7hmpdLVJbZalg+nuertobCCvjOgHuI8SSz64ncsReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872075; c=relaxed/simple;
	bh=HPsL/tAB194Nvdaf+/kuYpiY3P9Er3Kago6S6vw3LYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZWiXerus3Un1HXpmnsll92Ya5arCD7UtqQ4uo0X0XPkzlx+85N8KiYGcbOGhabuyLFLRaCRU+stOlq77yDlkIp+odP+CNkKxcKlIzsCLpz6Jomo4Z+xlch9dA4SBKM/7t2tQ0xvPHIC9qVUiyQYJHEsn/GoshEEdnkeEURl9De0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPqkypRX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762872073; x=1794408073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HPsL/tAB194Nvdaf+/kuYpiY3P9Er3Kago6S6vw3LYs=;
  b=JPqkypRX+4vjS2vXWAdmOwbb5BwesLcql0TgRul2cee8mH7EBbB7Um2Z
   ww+jWOBSVwn449/MBe/2eT5j6tbbmrfrw6PSDE5nLlQhVGo5Rzr/D/H9D
   3ehs75Ko60jOGZ3i2X12qwisJHkP18MUi54hNKepEB593uXgIQ5s+Kguq
   p8CHqg5aGMhQjcQhGRUPGj1I062qc/Am7+7LQa9mj4ySqyvhdVqNHMxh0
   a76e0cBgv93Wcl9BpdLSiL7TqFEwtps9V+khfwqL4BaHr2yph63Cnp3Sr
   68JWUKgghf8q2y8Gjl5u2DUI4vf1/OFRc/oNhC/vMmbM2tfKEXuXEChWH
   A==;
X-CSE-ConnectionGUID: 94pkRG+XTbKWjKF+3pwEzA==
X-CSE-MsgGUID: fPD9o6bBROy4LIC3Cfsx8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="68793497"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="68793497"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 06:41:13 -0800
X-CSE-ConnectionGUID: RN7Ot5xkSRWcK3m6xtcOew==
X-CSE-MsgGUID: ncabnXqTSAOET6rWzWjSEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189713187"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 11 Nov 2025 06:41:06 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 1E43296; Tue, 11 Nov 2025 15:41:05 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v1 0/2] devres: clean up and move percpu allocator
Date: Tue, 11 Nov 2025 15:39:56 +0100
Message-ID: <20251111144104.910241-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up and move managed percpu allocator to devres.h.

Andy Shevchenko (2):
  devres: Remove unused devm_free_percpu()
  devres: Move devm_alloc_percpu() and related to devres.h

 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/base/devres.c                         | 25 -------------------
 include/linux/device.h                        | 19 --------------
 include/linux/device/devres.h                 | 16 ++++++++++++
 4 files changed, 16 insertions(+), 45 deletions(-)

-- 
2.50.1


