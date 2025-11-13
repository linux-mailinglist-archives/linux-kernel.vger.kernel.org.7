Return-Path: <linux-kernel+bounces-899810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED489C591D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 592A954310C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AC435CB94;
	Thu, 13 Nov 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAIvqS61"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65435C1BB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051241; cv=none; b=b3bo+CGyenyS/XHDTRoF7ljp9Ou4FC8Ago+75HvE5wErW8LsWRQtHjM1MjumfTuzsEnI7O/SCl4PRr+jvC180hKTBcJe2a/N9x9Gi7FCFEN6LthzAK4Q5z0fFx8kaxejZLqHRdgs3DDEDYx4AbAQfX4r/ZlF/O0LNgtlH0KydVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051241; c=relaxed/simple;
	bh=u5oWip2t3apdB0bIZvU7Uw6687OPbNuIZIStF0kBn5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zx+FoSSu1Mh5oC8hbji3F1I9hO6Kezovv1ZrB7/1/6ietAPaWWKanlqkPoCZ/MBxb+uzEorrMIEPhwQzd7AiD3kveAGldX+hafXsABLDKShO5Oq8iDfmqINnWF+bIETL0JVqKnO8r4Rzil4XifTaEsifN37/dQxVTdi1NtPDNqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAIvqS61; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051240; x=1794587240;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u5oWip2t3apdB0bIZvU7Uw6687OPbNuIZIStF0kBn5E=;
  b=ZAIvqS61elTdSQm/xtaQr66/3Pe6ymObltHgV9zlip42zHDu6PWJZftw
   xWpc+m58f1ipsLW3MSRan1LMkwujRrD4MKhZCimiajKdd0tNb4ArEx7Gj
   J0e+lN6cDA0SNIlMzQmrFDBUIJlsbqKnVn85pQQ7GkrRMs1EIFRegdrnP
   i95KlAf8vVRQ4FxzqK7RUIYe1xw4tygd573cUWuNhObPKxtW9u3/9G1XJ
   +g6DhB7Dcx2AsJHc0tpSehASyDX+XvuC5WuhQi8PJxOlNeec4XxaD81YJ
   3dGxkQpWcYnQBKFMgPI+w0ZH4yudqxnDg/5QONYLCVMMgQjosZbR/D42T
   w==;
X-CSE-ConnectionGUID: hnaOptwtTKOmDvJAFsO1gw==
X-CSE-MsgGUID: JtqL2ul1To6evhgwPm0pzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="82767221"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="82767221"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:17 -0800
X-CSE-ConnectionGUID: hv1jl9i1QPWvPaCEs3yW6w==
X-CSE-MsgGUID: bsBr622qQayFFIIqCWJg9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="190310093"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 13 Nov 2025 08:27:15 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6D08896; Thu, 13 Nov 2025 17:27:14 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Chong Qiao <qiaochong@loongson.cn>,
	Lee Jones <lee@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH v2 0/2] mfd: ls2kbmc: A fix and a refactoring
Date: Thu, 13 Nov 2025 17:22:49 +0100
Message-ID: <20251113162713.3143777-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just an ad-hoc fix and refactoring as I have noticed the problematic fix,
which is commit 4af66c2bcab0 ("mfd: ls2kbmc: check for devm_mfd_add_devices()
failure") in the Linux Next.

The best, actually to get that change simply being dropped or reverted,
as this whole series was induced by that (wrong) attempt to fix things.

Changelog v2:
- fixed spelling (Lee)
- rebased on top of for-mfd-next (Lee)
- collected tags (Binbin)

v1: <20251030113735.3741913-1-andriy.shevchenko@linux.intel.com>

Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Corey Minyard <corey@minyard.net>

Andy Shevchenko (2):
  mfd: ls2kbmc: Fully convert to use managed resources
  mfd: ls2kbmc: Use PCI API instead of direct accesses

 drivers/mfd/ls2k-bmc-core.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

-- 
2.50.1


