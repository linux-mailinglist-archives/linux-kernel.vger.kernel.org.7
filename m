Return-Path: <linux-kernel+bounces-760621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0C9B1EDDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE6A175FAA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DA91F4289;
	Fri,  8 Aug 2025 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hx5iGzGf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3DE19D065
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754674563; cv=none; b=WeZBGUQXnuC5NdHC5eOjtUcuJNBqpUq+IP9CEGrB3cDhYJntPML8DnhKdbA5ushuklm+JtodaJ1CGfXatp0QEDXuVeywBRIw8FV+dyTtXSc5lXhr48C30zOgC2haMOtdpvxBXuh2iqUe6hlLHf4/KrUZ3CsKMKKHTe9IxY2ma40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754674563; c=relaxed/simple;
	bh=4gI3Fbat6bYkv9HAnhdKRnfYXNhPJqclodKFlcXoYSE=;
	h=Subject:To:Cc:From:Date:Message-Id; b=oWfszTnz88lRsrVK+LIb39nQKXLcTyPKRGr7u+Qi+cSNp9nqRnoIsTPJViOsA/Q1L+tYy903V++sTUa+0OhbIEPOEh5CWtTPZJLNQpWLL8K2Z0WGgApAXiFQpJq9KWm/bg35zxlu5xcSbXwx6s4R6A47pEx235hlTBItP551Y1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hx5iGzGf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754674562; x=1786210562;
  h=subject:to:cc:from:date:message-id;
  bh=4gI3Fbat6bYkv9HAnhdKRnfYXNhPJqclodKFlcXoYSE=;
  b=Hx5iGzGfWwM5yfYQFZMw5HYyN1mBgE8LBbz72pEg9Q3elerZyL0TEtAz
   L9KFWfaKPaHv9qY/3SWsFxtPo9kxnTjHOFUnSCC0lhKk0sfgLUBKiZ38y
   Gf+E6y6gSPiNPy+SI6GLGJUQC+rZAJIsPfvIgHp/vBfJsb7gkaytYN9Dj
   y1ENa0+02Lvt0MR7/vbkekaCMsEwkap1TjVRFPVu9TQLy15f/YXYsnaa5
   BRwhm5375nyo3gYtH4cTOAJ3OF/Pe8svH/zLeGXI6GlDxIw+YuGhpM7si
   6+Rh7THRblu39ApTSDeKARFidTFWTMRmZDcz4D6cgjokWnkizqkOd42FP
   g==;
X-CSE-ConnectionGUID: ynWHF0lWROeBv3Z7UUxs/Q==
X-CSE-MsgGUID: Kh/MlCs8SWqZR+utZNe6oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="60874637"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="60874637"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:36:01 -0700
X-CSE-ConnectionGUID: lMvpRwTsTUySnZ2RVLXzRA==
X-CSE-MsgGUID: 8jD2peHJTg6xUlyhxepU0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="164609636"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa006.jf.intel.com with ESMTP; 08 Aug 2025 10:36:02 -0700
Subject: [PATCH] MAINTAINERS: Remove bouncing Keem Bay maintainer
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Anitha Chrisanthus <anitha.chrisanthus@intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 08 Aug 2025 10:36:01 -0700
Message-Id: <20250808173601.77F1A90A@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

This maintainer's email no longer works. Remove it from MAINTAINERS.

There is still one listed maintainer for the "INTEL KEEM BAY DRM
DRIVER".

Cc: Anitha Chrisanthus <anitha.chrisanthus@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/MAINTAINERS |    1 -
 1 file changed, 1 deletion(-)

diff -puN MAINTAINERS~MAINTAINERS-20250707-1 MAINTAINERS
--- a/MAINTAINERS~MAINTAINERS-20250707-1	2025-07-07 11:02:07.348257231 -0700
+++ b/MAINTAINERS	2025-07-07 11:02:07.364258636 -0700
@@ -12255,7 +12255,6 @@ F:	drivers/crypto/intel/ixp4xx/ixp4xx_cr
 
 INTEL KEEM BAY DRM DRIVER
 M:	Anitha Chrisanthus <anitha.chrisanthus@intel.com>
-M:	Edmund Dea <edmund.j.dea@intel.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/intel,keembay-display.yaml
 F:	drivers/gpu/drm/kmb/
_

