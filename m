Return-Path: <linux-kernel+bounces-880826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE80C26AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 772F94E240A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03622D8395;
	Fri, 31 Oct 2025 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3L4ZK8z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571E277013
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761937422; cv=none; b=Mir192SaWZ9lxE2VQ+kDGq3Hnsllvw/d8MHcsiyVRDkGimc7vzLY4uESf/jsSi+VacEB50EFtLyfcgEQho2f8ZypH74MiXbNlLMjY7d/co/hslgITXBZC++XHitGLzAr/vx4CsYZ2sQ837rT2MAGp0HqefafAwXgbZAUPtuUApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761937422; c=relaxed/simple;
	bh=DmGGxsaTT3V+85Rmmkku2cluIhZTAt5Tc+XuXzJoB3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QJFu7+mI2fjqHH42dK/S0YVWHJfhIzYHzVKktdbfHU5ZTSDm2HJAqNVmniSQgqDWavhM4wIVQOChBcv/eTZJkvkOtoywOEvN0Y/ErIO/qdO92cr4J5dxu4WDYynMz5FA6Lb+cR/Tar6CFb1q/+Hoy3KC32EwTUIP40gN/7dRocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3L4ZK8z; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761937421; x=1793473421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DmGGxsaTT3V+85Rmmkku2cluIhZTAt5Tc+XuXzJoB3E=;
  b=C3L4ZK8zShQT17vcgulwn8v44Qv5/n4vkHI229rUkcJFuUZWbleNifrH
   hC5cOIwP0zD/m3anX/jsVHYJYmV+/I+K1UePm0tVWd5Kyf2Z7Al7cmjvu
   Fw9/LZXcr6bWwoxTAtViJiWeNl0tgbaPUFdINtJytusdKz1IKoKupMpCj
   e497XYT8yhFa1HU1CNsbinIlOxTXsaklRgSnkjBv2v06Y/Infs2GnuSUk
   A3goNiqvM7z3r7+3ncd1za/ZZbQMjlgsTewpD9z+CE3UaXRo00wXAGPvP
   UsBE9aIE0fPcoE5Dw0bj2Jm7BU0E6U8TfbSCj4wTw+yypiL+DBJtik+n2
   w==;
X-CSE-ConnectionGUID: aUNcvz8zQb6ob51hJGBNKQ==
X-CSE-MsgGUID: zQNB4yD5TVWG79zRlUNHPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="51677277"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="51677277"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 12:03:40 -0700
X-CSE-ConnectionGUID: 3r/vcL2CSzeK7uYAKgB9mA==
X-CSE-MsgGUID: lL4KR/P6QdGkkNOcHumIag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="185580714"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa010.jf.intel.com with ESMTP; 31 Oct 2025 12:03:37 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: kees@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] mod_devicetable: Bump auxiliary_device_id name size
Date: Sat,  1 Nov 2025 00:32:34 +0530
Message-Id: <20251031190234.224813-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since auxiliary device id string is formed using the combination of parent
and child device names, it may require more than 32 bytes if both the names
are long enough. Bump the size to 40 bytes to satisfy such cases.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
Triggered by [1].

[1] https://lore.kernel.org/r/aQSwWLVKH_3TthTW@smile.fi.intel.com

 include/linux/mod_devicetable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 6077972e8b45..24eb5a88a5c5 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -867,7 +867,7 @@ struct mhi_device_id {
 	kernel_ulong_t driver_data;
 };
 
-#define AUXILIARY_NAME_SIZE 32
+#define AUXILIARY_NAME_SIZE 40
 #define AUXILIARY_MODULE_PREFIX "auxiliary:"
 
 struct auxiliary_device_id {
-- 
2.34.1


