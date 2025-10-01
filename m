Return-Path: <linux-kernel+bounces-838350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806F4BAF01D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367D61C8A65
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D28274FDF;
	Wed,  1 Oct 2025 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZKOG0JG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500C270ED2
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759285400; cv=none; b=auQAXaBHixT6qNKBLPxwh8Sy6BYVYZcWZjW9Nhj6Y5Q2j6bwDNDMlC+xWNrM1rG8z40W8FgwPdzgIsHNA9ypfbaliT9pF7ulbNPm0grbcZxF+ltWP5YSb8jbMxnu0JDJYS98SR0BrQNzFodOcbr/1vJIkmvRqp/tGBrc6LOvXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759285400; c=relaxed/simple;
	bh=CT6DMJFXJYlXvWJBJlUrFXKGFsLGereGiBqD+owiYn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1aBnIMXt3E0AM+xvxjRfWGo6DVAXw+6jk9/IzRODtrMKRpz+dzLcNK9R4E1LfIyOuTszv5415/rFaOZMkHvVTRJfHLWJaPtSdb1mtXusX6dqhYWbpjn8yL+57p7iYzAzWK/fktSfbR1d4xfFw2+YYhOan0w/nbZ+/KJ/QtPKjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CZKOG0JG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759285398; x=1790821398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CT6DMJFXJYlXvWJBJlUrFXKGFsLGereGiBqD+owiYn0=;
  b=CZKOG0JGg7tYjA3rw4jNJoxzKIOzY7r9EhdjGDhR+UX9/3Zw+hiZBvH7
   /ngNADXJnGJvPejYPBtWbtQNU5kmd2ylILYLhhYztXPZlRgZtQAN7uv0l
   yd0rNxTWt3WeM+0VbqzC7l1KVzGgSM5/LJxXDaKKMdHMruha51Q8V3Mdl
   OwzVVTBO9cXy1G+7b68J9XpMvrF3DM4XceOVA1EYiwc8spvl+tl5+wguP
   I/uqwXLCgCdcZ4dha0T6HucxEhsT41Dw0fGEi+w6qzUJvsVGK7zbOZTsF
   k1IMtiUH5VR5HACrGp3ynkZ6ia8txn3sOkymE1bW7zpY1g9tE2Ode9GAx
   w==;
X-CSE-ConnectionGUID: KndiwSovRc6fX5aDvCNc7A==
X-CSE-MsgGUID: 82gRHwsFQfefOlH2RnWaKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61444969"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61444969"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:23:17 -0700
X-CSE-ConnectionGUID: ZMKxdDU1Q7WOMBkUSRQoUA==
X-CSE-MsgGUID: Wb94tfoYT1mgIQhGwMEilg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="183079902"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:23:17 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Chao Gao <chao.gao@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kai Huang <kai.huang@intel.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 0/2]  Expose TDX Module version
Date: Tue, 30 Sep 2025 19:22:43 -0700
Message-ID: <20251001022309.277238-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there is no user interface to get the TDX Module version.
However, in bug reporting or analysis scenarios, the first question
normally asked is which TDX Module version is on your system, to determine
if this is a known issue or a new regression.

To address this issue, this series exposes the TDX Module version as
sysfs attributes of the tdx_host device [*].

This series is built on the VMX always-on series, which enables VMXON
during CPU bringup, and the "tdx_host" device, which creates a virtual
device to serve as the user interface for all TDX host features, e.g.,
TDX Connect.

The base-commit is:
https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/commit/?h=tdx&id=9332e088937f

[*]: https://lore.kernel.org/linux-coco/20250919142237.418648-2-dan.j.williams@intel.com/

Chao Gao (2):
  x86/virt/tdx: Retrieve TDX module version
  coco/tdx-host: Expose TDX module version

 .../ABI/testing/sysfs-devices-faux-tdx-host   |  6 +++++
 MAINTAINERS                                   |  1 +
 arch/x86/include/asm/tdx_global_metadata.h    |  7 ++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   | 16 ++++++++++++
 drivers/virt/coco/tdx-host/tdx-host.c         | 25 ++++++++++++++++++-
 5 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-faux-tdx-host

-- 
2.47.3


