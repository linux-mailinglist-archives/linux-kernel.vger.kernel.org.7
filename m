Return-Path: <linux-kernel+bounces-833531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF34BA23BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21647A3843
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53930261B9B;
	Fri, 26 Sep 2025 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjTAAf/i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C014E2E2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854645; cv=none; b=o+s3iXe66cXFfe9mQwmndHTM4yB9ODrN3VK3eaPwiOoRIgksEj2j8LrW/xxUiT4J7zaJW5E8cx8Tc+glkD7jAe0M9YdKMi/nPO+K0ECzv3qSQC/9fWpfG0l+w7FlllSkkCLi8IuDUhJdUCQb+JRstYnenv1FjAfYssfVSKjhCMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854645; c=relaxed/simple;
	bh=Nys7nGmEzAa3Rs+7Dx+hsECm3DHD9HVcRdRnYALRaWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9fG93fNIbEuGssHqiD89Uc/35BmPqVTk+nX6LsnExmFmA56fGU8T17cxalvTZIzqHYvcTdYB+MXTYCGyAeDn2PJgTwht9Y8YFBR61ZC1Xcg1MFUWEbRnIcoXbBMZU5+YDroHBoQ4RjvvcK6bxDB70bcFcx1COg/FcpksQw40e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjTAAf/i; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758854644; x=1790390644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nys7nGmEzAa3Rs+7Dx+hsECm3DHD9HVcRdRnYALRaWw=;
  b=WjTAAf/ibo/3gB6Bls8VCMJbqC1/R+zG+uUrGYe0mR7iLskO7eMXq+0E
   GypFXgSdrmhmOzUfyneQ/ofh9HribrbFR0iDTy8xiHsiXCEyYAA+Ojs5t
   0D+dIWznEoqSUbmJ7AcT5LDVwRNAXUVANu/vt9DOLQavmD+ypuFX1siMX
   nzmZMD31lnYS5xsiAhdMjqWTDt7luLVqBeiWsWfh6mYuqwgN1o7GJY+nk
   zcuidMCfdu/4CCGNyjt3tZWaejaXsACjgf0WW7pbxYkAyg+WZg9jkFFlq
   a/BWj8wFkj+EPJY2T1hIWPcSMU2a8aBEOLGVYptfT5lq6qGTzuS6eOeYp
   A==;
X-CSE-ConnectionGUID: M4EzpA3aQU6F96eFyE22+w==
X-CSE-MsgGUID: TRW95VCORHayj2Z6Xh0oeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61354313"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="61354313"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 19:44:04 -0700
X-CSE-ConnectionGUID: jkfUqTK3T7qhzSV7pxM+Zw==
X-CSE-MsgGUID: LIMtWEstSHOsvEoYHQosKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177948774"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa009.fm.intel.com with ESMTP; 25 Sep 2025 19:44:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.18-rc1
Date: Fri, 26 Sep 2025 10:41:29 +0800
Message-ID: <20250926024130.157514-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fix has been queued for the Intel iommu driver. It aims to
solve the following problem:

- Disallow dirty tracking if page walk is incoherent

This fix is not so critical for v6.17-rc. Considering the upcoming merge
window, it would be fine to include them with other patches for v6.18.
Please consider it.

Best regards,
baolu

Lu Baolu (1):
  iommu/vt-d: Disallow dirty tracking if incoherent page walk

 drivers/iommu/intel/iommu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0


