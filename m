Return-Path: <linux-kernel+bounces-895670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EECC4EA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3AA84F7DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E5732C930;
	Tue, 11 Nov 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vb4sHjwk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5869C30648C;
	Tue, 11 Nov 2025 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872656; cv=none; b=Wjbr2zmb5dJxZrd7KebOO0V1vQEJtAu3qjsZaGVMhDn3NWvyl7EH0/ospBWzKQl2r9k0ixxW1siOfCaMXn5i4ZH82bWG2YF/hQGb6xU0Vqvm0oYi1uQVZi2sOBKpYSUAi8PY16UVmePpSBcB0KEdzjWSsLVih5wQPkjNqOGfCN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872656; c=relaxed/simple;
	bh=CJT2bHiYVzimb6xUOlUijV6ufxC2fzRRaAwV5VvZxnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TidFrecelQUkiskexIN+MF6zXfxnprp13NfN0afD2GR3DVCs9+CrOITaXNFKVh0DTICOl2kb+t1R+D5gWdgkt8439+75pBEU/Jex3pMzVwk0DsHCSC6VRb3NcCd1v16muaWF+T2fLWkKWsrFG6TKqMoUGRzmKfQIUPc04DRBCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vb4sHjwk; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762872654; x=1794408654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CJT2bHiYVzimb6xUOlUijV6ufxC2fzRRaAwV5VvZxnE=;
  b=Vb4sHjwkd95egKGjDCzV89R265peULYPNl8V65CHh/54CQKxRLu6WyW+
   5ESnC60FH3EA3yb4pCrnTeAbNJMxo32/IvXfU9SMi9RO+Qi0JEcT5Et7I
   BlQY+c/eqFZrb2QRTMYl4jIaAQuqU48RfYw4s8O0HlzS3LS6vMNh47p9p
   hKnQqbEuZQqMmjt7A+VZ9Si/vaWqTpfYGdSUcJzo71xTiatQvcKkQtdwX
   lU5t2KgBFpoXNDuPWteyt9SjUiMgiNIGmGxIPhwc87GloQZB56szAmPMR
   DgUi1mwgGq9Cz9qFF4OlOTrDHzZGUWXyVxosAMaUNmAVdV7Vjf9nyF9c/
   Q==;
X-CSE-ConnectionGUID: d7AVU/byRoqhohF7Cp3POw==
X-CSE-MsgGUID: +i2RUADjTne/JdlMP5CYpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64968382"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="64968382"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 06:50:52 -0800
X-CSE-ConnectionGUID: A9CUur7HSkCWf1aCqWULhQ==
X-CSE-MsgGUID: aLLk3+7ZRB+BR/+ie7j+1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189153961"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 11 Nov 2025 06:50:50 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id AF7B597; Tue, 11 Nov 2025 15:50:48 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 1/2] devres: Remove unused devm_free_percpu()
Date: Tue, 11 Nov 2025 15:49:45 +0100
Message-ID: <20251111145046.997309-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251111145046.997309-1-andriy.shevchenko@linux.intel.com>
References: <20251111145046.997309-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused devm_free_percpu().

By the way, it was never used in the drivers/ from day 1.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/base/devres.c                         | 25 -------------------
 include/linux/device.h                        |  1 -
 3 files changed, 27 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 2b36ebde9cec..0198ac65e874 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -383,7 +383,6 @@ NET
 
 PER-CPU MEM
   devm_alloc_percpu()
-  devm_free_percpu()
 
 PCI
   devm_pci_alloc_host_bridge()  : managed PCI host bridge allocation
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index c948c88d3956..f54db6d138ab 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1222,13 +1222,6 @@ static void devm_percpu_release(struct device *dev, void *pdata)
 	free_percpu(p);
 }
 
-static int devm_percpu_match(struct device *dev, void *data, void *p)
-{
-	struct devres *devr = container_of(data, struct devres, data);
-
-	return *(void **)devr->data == p;
-}
-
 /**
  * __devm_alloc_percpu - Resource-managed alloc_percpu
  * @dev: Device to allocate per-cpu memory for
@@ -1264,21 +1257,3 @@ void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
 	return pcpu;
 }
 EXPORT_SYMBOL_GPL(__devm_alloc_percpu);
-
-/**
- * devm_free_percpu - Resource-managed free_percpu
- * @dev: Device this memory belongs to
- * @pdata: Per-cpu memory to free
- *
- * Free memory allocated with devm_alloc_percpu().
- */
-void devm_free_percpu(struct device *dev, void __percpu *pdata)
-{
-	/*
-	 * Use devres_release() to prevent memory leakage as
-	 * devm_free_pages() does.
-	 */
-	WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_match,
-			       (void *)(__force unsigned long)pdata));
-}
-EXPORT_SYMBOL_GPL(devm_free_percpu);
diff --git a/include/linux/device.h b/include/linux/device.h
index b031ff71a5bd..0c6377f6631c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -298,7 +298,6 @@ void device_remove_bin_file(struct device *dev,
 
 void __percpu *__devm_alloc_percpu(struct device *dev, size_t size,
 				   size_t align);
-void devm_free_percpu(struct device *dev, void __percpu *pdata);
 
 struct device_dma_parameters {
 	/*
-- 
2.50.1


