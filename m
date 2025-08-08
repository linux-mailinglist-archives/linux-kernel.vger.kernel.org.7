Return-Path: <linux-kernel+bounces-760622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2FCB1EDDF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160981AA8565
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96A21DED5B;
	Fri,  8 Aug 2025 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqnHCAKi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3A199385;
	Fri,  8 Aug 2025 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754674693; cv=none; b=HRQpSNdg2BwNu5FJ3sqzt2lWs+JneV7fjqmmPNZo2f0fp7upUUJ/Pg/JxqG0aZTNA3on9ujyRtTiWQnPbfaK8Pl+uTJTq/FZ3r6LV91JpRI/uGXSzfnXRnlf7Tai8gcjGdCzYgyGPpN8vmhc7GjTYJQr3ngrVsy1jGfyazduI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754674693; c=relaxed/simple;
	bh=KCrE/1vxbVTmZFIhx+r1KO8dpf7FoCmwnT1AoeihBWQ=;
	h=Subject:To:Cc:From:Date:Message-Id; b=L57k0yXaIllIEz9PBcilHnxCsemrMAg6v2CQ3MWcRB5Pr+2FFTmYmfWsZVp3apWlVY15HLCh+MCMEB9wNhX58FBSdXDn2XFlAvRaon5o4v+R4f4isdjuj7ctNND2XbbfrdYUwvbCHbklaleanMtEpn4BecoIMAfRPD5A/uP6JC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NqnHCAKi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754674691; x=1786210691;
  h=subject:to:cc:from:date:message-id;
  bh=KCrE/1vxbVTmZFIhx+r1KO8dpf7FoCmwnT1AoeihBWQ=;
  b=NqnHCAKiJE/2gYuvZDDdTF4JbruJZvb2/0DZq80UIVzuWiAptTOkuaRL
   rbqM16S1E/f/VJixjxJKYhBuribnrAPzHA5TNrgOaHAWoEpo2YhDAaL1t
   pk7Z5N9Ar9AJQUb88Ge+yf0Y38a8AtQTHcijp+DsQV9jjrchTTu9afrdg
   ZFbhev174E+pLdRxca4jhgFnSxRJ8YG+KTthgEFkCKb0rOGj7IH4OiZxI
   s+++UdoMyIDS/XaqR8LQJBv2XhGdYnJ/vE7rAItGU87S4yahX8sm+wPGe
   NcFOJgAw5jWIQ+9Vte4rESe68RD/gPZghiKGdzqw9XNzLhHekKDZcrV7D
   A==;
X-CSE-ConnectionGUID: 4ow6kE+vSCGwEf6+GGlj5Q==
X-CSE-MsgGUID: 3F1TGJhmRXq4ToYbdmOLog==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="67730621"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="67730621"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:38:08 -0700
X-CSE-ConnectionGUID: dcyHzB4zQ3ui1GGBd+1Ckg==
X-CSE-MsgGUID: L2v+Bpk9RwKcrXFUygimzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="196357205"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa002.jf.intel.com with ESMTP; 08 Aug 2025 10:38:06 -0700
Subject: [PATCH] MAINTAINERS: Mark coretemp driver as orphaned
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 08 Aug 2025 10:38:07 -0700
Message-Id: <20250808173807.96D134EA@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

This maintainer's email no longer works. Remove it from MAINTAINERS.
Also mark the driver as Orphaned for now.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---

 b/MAINTAINERS |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -puN MAINTAINERS~MAINTAINERS-20250707-2 MAINTAINERS
--- a/MAINTAINERS~MAINTAINERS-20250707-2	2025-08-08 10:36:09.028985285 -0700
+++ b/MAINTAINERS	2025-08-08 10:36:09.043986599 -0700
@@ -6281,9 +6281,8 @@ F:	tools/testing/selftests/cgroup/test_k
 F:	tools/testing/selftests/cgroup/test_memcontrol.c
 
 CORETEMP HARDWARE MONITORING DRIVER
-M:	Fenghua Yu <fenghua.yu@intel.com>
 L:	linux-hwmon@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/hwmon/coretemp.rst
 F:	drivers/hwmon/coretemp.c
 
_

