Return-Path: <linux-kernel+bounces-724026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78F1AFEDB4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2514E2A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D935E2E92CA;
	Wed,  9 Jul 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSRslTd3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23D12E8DEB
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074814; cv=none; b=MPyy3sVWQO5u2O4A+5rA4ksqnax1VKA4FTG2CUsjlzf/aU/ByunGqtWtJBHTAi02AiUeBNOwRM6hiz8EAvtT/u8YzkIr19+NfdNpiIljwSuuuEAMVM0EeMvvd/jiu6kRind5JrkOUXCvkFFHJ3LUAWb4A9lpDZPYAHmMrhIfCIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074814; c=relaxed/simple;
	bh=c3EE6wrQNXh5lkN5NgK6InlkspugXxkkAh0cxdXykUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpYE8IwlxicwAHGUIUIs+M1fsdizKbQUNQJvwRbyxoey0EWPGS/Y021JMhL+WNah69G381W7kBPhWqphgRKoQZLd2KQebfvSB/xo50jAePk2frqtDwLfxt7hbDbZvknKp5fzBrUcwoXW6iEbOAjM+b/NkJcJxfJhYv9Ijylkhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSRslTd3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752074813; x=1783610813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c3EE6wrQNXh5lkN5NgK6InlkspugXxkkAh0cxdXykUE=;
  b=VSRslTd3jvq57QEBvKW8a7J4PgjdjrAKJpi20Yrv86zHNS/bRh3gDcnz
   /7/7sb0fxT7a/yxrns8+4zqHXzPnxFFFk7vLC9xsLMNhmvuodfrbSxW3j
   cIWlqpJlDMACprqkx1xMSebpcdHvNV60oZ/x7ZquiB3FIgxjtULvO7N3B
   JPLkMgFkmeZRViXMADbHTIjM1aYItDD+sFwm37IbWE+gkcFFHQda/V6A/
   u5gaGwJ/GPqi7oFRd1sd+N4F4tRjZ0fbcHtPcN24+UgK3QALYiHW69tfo
   cTbFpBFF+rhWVIP6aQ7FKVBS/1fvaCUANzR6HjQbcUV4F1pPpD+XpEouv
   g==;
X-CSE-ConnectionGUID: mOP40g6SSoawKoIPoFsQNA==
X-CSE-MsgGUID: Mn+th4tyQ+KS0r0Zfinsqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54487381"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54487381"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:26:52 -0700
X-CSE-ConnectionGUID: A3C4383ORdmnj/IAkcNVpQ==
X-CSE-MsgGUID: gK4EmQi6TaKogSUXN5PnDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155557805"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 08:26:50 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next v3 1/5] mei: set parent for char device
Date: Wed,  9 Jul 2025 18:13:40 +0300
Message-ID: <20250709151344.104942-2-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709151344.104942-1-alexander.usyskin@intel.com>
References: <20250709151344.104942-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connect char device to parent device to avoid
parent device unload while char device is
still held open by user-space.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 1f5aaf16e300..95d4c1d8e4e6 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1225,6 +1225,7 @@ int mei_register(struct mei_device *dev, struct device *parent)
 	devno = MKDEV(MAJOR(mei_devt), dev->minor);
 	cdev_init(&dev->cdev, &mei_fops);
 	dev->cdev.owner = parent->driver->owner;
+	cdev_set_parent(&dev->cdev, &parent->kobj);
 
 	/* Add the device */
 	ret = cdev_add(&dev->cdev, devno, 1);
-- 
2.43.0


