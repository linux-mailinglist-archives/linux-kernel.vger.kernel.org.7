Return-Path: <linux-kernel+bounces-767265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE363B25218
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA46F7A4FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AAF28750F;
	Wed, 13 Aug 2025 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xb+mQcny"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AD3303CAC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106021; cv=none; b=ENdwL9+czIVbmGEMDlE4CvUhWFqWLy/N6N7ujtPXuwedbNrdiVWt1twzZicRYkr66EDg++adJTrcVrEPgIOAbKJBrKIUCWdsO3VQPO8JsfAWudIvOC21c9k8ru5OFn/aYZSEpVLf5HS9N3E3jW+Zd+IqozfKttSqQG0fdQFlNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106021; c=relaxed/simple;
	bh=7POT8uKw90iaht9ZRm5Mezj5UgObEiO6kgKegtMZwY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6+28xOT6LWEfrLZU0ONZuDdllSbB/GMTC1yOCqXznpmZPHm5wKs+/2N6+79o9PmhXT3zx35d59pcbz7iD1Li8Mck54U9H4nS3MBVkbQOi/yKhD4p64sdEJ+5Uxsyc1FSY8QtYgzbP3GyKWDsPWBuVXD0UVLfqt868DzzuzRTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xb+mQcny; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755106020; x=1786642020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7POT8uKw90iaht9ZRm5Mezj5UgObEiO6kgKegtMZwY8=;
  b=Xb+mQcnyz49tjvG/yNi3K/82hekij6lakwC1VBJELU4pHtnT1ti7lpSA
   mpW7VC8aQZZLwzaW4Ha62PZ4ywzsicrUkbukmZwxg9DaiZSpez0ktT1AG
   Q7Z7+40Yc/QhaVCqFlRw91tWaUUDbHHXXs6rlfkJYNGx4SvbJfrDeDL3J
   2MaHD7J+80vlfk2rThaSPp3XIui22W33tXP+92IbwqD1/lulAaPDGYWOi
   c4xlkR9F7xMzL5hhKWuWZkSPbd5+CzzNs4DwQNmfFCizc3qWQzricBMwe
   Yl/f/QWsnS17mZfwZ406ZGYcS+AfGZZEfUbwYudrH6fECj6a84u11GfVM
   Q==;
X-CSE-ConnectionGUID: hcU5XuD7ThycgWZ1EVU3Lg==
X-CSE-MsgGUID: 11yBE2FZRM+tx1Hlg3lTTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61255196"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="61255196"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 10:26:59 -0700
X-CSE-ConnectionGUID: M2ImGmbsTyGDxk9KZhEjWA==
X-CSE-MsgGUID: xVnOQMKwTXymxGWlL6whJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="167329697"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.193])
  by fmviesa010.fm.intel.com with ESMTP; 13 Aug 2025 10:26:58 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chao.gao@intel.com,
	abusse@amazon.de,
	chang.seok.bae@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] x86: Support for Intel Microcode Staging Feature
Date: Wed, 13 Aug 2025 10:26:43 -0700
Message-ID: <20250813172649.15474-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250409232713.4536-1-chang.seok.bae@intel.com>
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear x86 maintainers,

This is another posting of the series, now including a Tested-by tag.
There are no code changes.

The use case for this feature is late-loading with increased load times,
most likely in cloud service environments. I reached out to potential
users for reviews and feedback, and Anselm Busse has confirmed his
testing.

While additional reviews or endorsements could help ease the maintainers'
burden and build confidence, there hasn't been much recent traction. At
this point, I believe it's better to move forward and get a clear
assessment from the maintainers -- either to prompt more engagement from
prospective users or to determine its readiness for merging.

Of course, I appreciate any further feedback on this set.

As usual, the patch series is based on tip/master and is also available
in this repo:
  git://github.com/intel-staging/microcode.git staging_v4

Last posting (V3):
  https://lore.kernel.org/lkml/20250409232713.4536-1-chang.seok.bae@intel.com/

Thanks,
Chang

Chang S. Bae (6):
  x86/microcode: Introduce staging step to reduce late-loading time
  x86/microcode/intel: Establish staging control logic
  x86/microcode/intel: Define staging state struct
  x86/microcode/intel: Implement staging handler
  x86/microcode/intel: Support mailbox transfer
  x86/microcode/intel: Enable staging when available

 arch/x86/include/asm/msr-index.h         |   9 +
 arch/x86/include/asm/topology.h          |   1 +
 arch/x86/kernel/cpu/microcode/core.c     |  11 +
 arch/x86/kernel/cpu/microcode/intel.c    | 338 +++++++++++++++++++++++
 arch/x86/kernel/cpu/microcode/internal.h |   4 +-
 5 files changed, 362 insertions(+), 1 deletion(-)


base-commit: ca76508b9352e8c770b58213cc6c4700e459b7c2
-- 
2.48.1


