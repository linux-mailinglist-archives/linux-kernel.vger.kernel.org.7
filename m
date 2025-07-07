Return-Path: <linux-kernel+bounces-720477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF49AFBC54
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510FD420BFD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566F7217709;
	Mon,  7 Jul 2025 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHk6Epuz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4391AB52D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919198; cv=none; b=doy/fQBKSwrOeuE29HQivHs16NW5tZNk1mR8SCq1lh+KSI52zLZxOVAQZB9uHdGaUyqgb7UtxG8QsEOqQmpVofik3AEATeVan10+yQgv+BuRIGnkMsjsrEKXDJUxKSB/N9g9giNTzsDhR4L+0gKaL5WmVtqbp/kY8ZB4xR9VFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919198; c=relaxed/simple;
	bh=NSw/kuWZpidtq1hug628Y/Fm9d72GRif0agRnlwTBxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A244pag+8zL8R86qCQQ0dYcPgRW5NyRFgK0dZKu7LgkSEv5yDBAyKotsAM98Ywtl/SKq+5xa4Q2+isMfURGQrYfEGFR2c8WmP3EvBoi/DaGxL/sEwToTjQEYSqRy1MxqeWkZlYEjQjVje+WpNnKoK8j00mmQncaiqP8vXDwn0EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHk6Epuz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751919197; x=1783455197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NSw/kuWZpidtq1hug628Y/Fm9d72GRif0agRnlwTBxk=;
  b=kHk6EpuzhQ52OzBb+TV1WxHoRE7JsNaTbWBadHzNkvRCs3oXEp1LRL5E
   sMPrQ9wvHAbpcUrgsdEWaidhteevgWRqjYi52+dPQcKABa3qx4c2HsP+S
   IwsHNRcevcRM+DWurBxPYJ3Mp1FzOaQ0wSTmjKNFLyMbjm6FJAGV2KzSK
   vMl8cvp0G5xvSJRGZ4o38I8eaEjh3KZViaiAoUHbR71ZHskNdt27ZrAlF
   q5sGs2JQH/R1kPCsh4VWzkY9CxOtIRavA2JkUct5n1ff/YJ1BX/l6wyQR
   t9v7NSMSmCPkzy93A8TDymCMuJpt1TqpVixiF7XjuBC0/kiwsYEcH9o9b
   Q==;
X-CSE-ConnectionGUID: H6dWIeyyRdW0Y6DEo0Oneg==
X-CSE-MsgGUID: gAKFS/lnQXW4eGLs86a/QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71729799"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="71729799"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:13:16 -0700
X-CSE-ConnectionGUID: GCOTWsaQSViOPpnUXCRlAQ==
X-CSE-MsgGUID: oltcj9g7TAGTfRa++od8/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="159343026"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa003.fm.intel.com with ESMTP; 07 Jul 2025 13:13:16 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	senozhatsky@chromium.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v1 0/2] zswap per-CPU acomp_ctx resources track the pool's lifetime
Date: Mon,  7 Jul 2025 13:13:13 -0700
Message-Id: <20250707201315.9497-1-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-series subsets patches 0021 and 0022 from the "v10 zswap
compression batching with optimized iaa_crypto driver" patch-series [1]
to be reviewed independently, since they do not have a dependency on the
rest of the patches in [1]. This is as per Andrew's suggestion.

Further, as per Nhat's comments in [1], patch 0020 is not needed
(mm: zswap: Move the CPU hotplug procedures under "pool functions") and
hence is dropped from this subset series, and will be dropped from v11
of [1].

[1]: https://patchwork.kernel.org/project/linux-mm/list/?series=978942

Kanchana P Sridhar (2):
  mm: zswap: Per-CPU acomp_ctx resources exist from pool creation to
    deletion.
  mm: zswap: Consistently use IS_ERR_OR_NULL() to check acomp_ctx
    resources.

 mm/zswap.c | 195 ++++++++++++++++++++++++++---------------------------
 1 file changed, 94 insertions(+), 101 deletions(-)

-- 
2.27.0


