Return-Path: <linux-kernel+bounces-895669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4879C4EAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511E84233B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E0B2FFDD6;
	Tue, 11 Nov 2025 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yuj7DVSv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC492F8BFC;
	Tue, 11 Nov 2025 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872654; cv=none; b=JsUgsr4Lc5NWB9DHoBX6uqm+TYry1CIOz5nFOCF7jNkABtAzuw5HF8j3aMoKVcRqm63pfXKuudfzIVmUHkl2ndva2Qf5T55vXbn+8QtQkqRyIg6i+QCKKa5EVd3PbZTWdW1y3F6r1Nhp70TxuxQ25KhciXNytKy5tdL/z3hvRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872654; c=relaxed/simple;
	bh=jJKdCsnhn4vYWt4a+uu98ZVVRN9KcID14W1vQYF6Zt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gb4lF0nDNm2hzRIBiXx4woETriV69oaSFcNN6vFHfdVcRFetmGfG103WV15V0NZAHH1Q+Szx5uFJ6qrYGaArpCPRV5PMtLt2AAakT7NooNepf0e4PHoBjQ20KAJ8g1N6DpJQeZ0KkKe/Poc2fShNFR6MKm/Z0CJ4mqIxFkY862s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yuj7DVSv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762872653; x=1794408653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jJKdCsnhn4vYWt4a+uu98ZVVRN9KcID14W1vQYF6Zt4=;
  b=Yuj7DVSvHmKChLhf4PYIqicym8KeztktV5dCGLrXmN5lP5OP+o4nfS6a
   hkBN5bxSrNySTL52xzTHVpWjUGmOOimaAJ7aFV8/naMukAOEk75PmJwlK
   P6GASmUK9Rh0gteCSukh8IgvBhaJob3wjSb5zLNpFlPmukZ65jfLmyh6v
   d4iEXahvlsgVHfqmOXuLiEOLO94TXtJTzzm+jLRMtmXHqzrBUlWch3/rX
   35eqVaSoeub4cj42HrCpmF0Uq8rJ4799tRvaWljsFHiCFepG1gZw9rt0j
   W3YvbBi9EXszvav+QEZOtanNmcBCXP2d3f4iEADjEvhxmJQMonibRYmc7
   A==;
X-CSE-ConnectionGUID: s7mZwyfpThqLFU+Jmn6JSA==
X-CSE-MsgGUID: vLjs6UXbSGii7IooY7Su3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64968377"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="64968377"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 06:50:52 -0800
X-CSE-ConnectionGUID: E6+3wh9ARge+LXPoEtqZWw==
X-CSE-MsgGUID: liifPDHyQnmmgEhcD0ag9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189153960"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 11 Nov 2025 06:50:50 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id ABAF096; Tue, 11 Nov 2025 15:50:48 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 0/2] devres: clean up and move percpu allocator
Date: Tue, 11 Nov 2025 15:49:44 +0100
Message-ID: <20251111145046.997309-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up and move managed percpu allocator to devres.h.

Changelog v2:
- fixed build error by adding a missed inclusion

v1: <20251111144104.910241-1-andriy.shevchenko@linux.intel.com>

Andy Shevchenko (2):
  devres: Remove unused devm_free_percpu()
  devres: Move devm_alloc_percpu() and related to devres.h

 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/base/devres.c                         | 25 -------------------
 include/linux/device.h                        | 19 --------------
 include/linux/device/devres.h                 | 17 +++++++++++++
 4 files changed, 17 insertions(+), 45 deletions(-)

-- 
2.50.1


