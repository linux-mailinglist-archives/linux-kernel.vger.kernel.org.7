Return-Path: <linux-kernel+bounces-833474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D506BA21AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF179188A580
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6157260A;
	Fri, 26 Sep 2025 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+6FDhzF"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B981BC58
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758847190; cv=none; b=N89TTaLvEcnRInNDR1FIcnzucQD6zVI8tMab15gaFBaGMwjYusiVJONz4wEZctzYLpzj8t0VEWwYRKSFOreDefRoAoyVMerR3JncXH6hVsSaA2uEa1FpHlsjuSMtKj1pkIfrLFUMSDneVPVQHvjIcIy3y8jefRBpanmWOnrjJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758847190; c=relaxed/simple;
	bh=nZu0dQTnI7c0vHRG4WuLt6WI+WkHJQUfIyCJZQwhANk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZ48tmNOgqIwgZXHu3WpDZqVjZ2fqgVB+hODElgAQpAaFZZC7AifdMgs57XgpkWvDPV7+ZEwAZkBmjtCTSf/3iTpyrUl1JuvbO3mwGL+wNdJKOYF8BwKNTO9s0N0etNJhYvawtk7MAnQ7NPaW8AOv14XYzPzKyU88KOr6HJdgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+6FDhzF; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b57f08e88bcso222897a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758847187; x=1759451987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKnaVIq0LZ3mDKDeIlNyOzrXDoMYEsJjeAh4xs7zfWQ=;
        b=X+6FDhzFkotNuQ0jj7zAu1wPlS1t4W/J1JL9Ird7/U7TP1PDl9+mvV8LTO1rqqSpbW
         ScxxCQpHESvjTYRRaf3/BaEcpZ17500shU+Kr917WnLaqO5VNII3h1Yk4FU6RPUylnEI
         4YihbRy02qE9Xz3sS1bcB5ZaH4DUa4IIzXQ2QbD4DyzelSAk/I1EsmplTRZUvlf8Oc1N
         xYnDQMf7Pgwe9C7b+DWKbI6K/wW/fCaHz5+ONdxdj9T3Ir9eG/ZNnNtYk64Bt6pSQpH8
         owm9yOuo8kfsCzUHzM93klnMPCjjt5rnHPcTssS19h9WkonUJYST3Z+B2WFeYMOiuf/Q
         dziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758847187; x=1759451987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKnaVIq0LZ3mDKDeIlNyOzrXDoMYEsJjeAh4xs7zfWQ=;
        b=p9e0E245SXIsioWTk8BJXMKhZeAu83aiqQbmz6B/8BmodP+NPP8SuU6Dq9RbakkEo4
         BS3XInVDxzShTsPcB/KNNfhlyRL8WmvxlyTRvYCHiRla5KwxBTDN7QygJAOVFpz6zYMn
         7erOWtvahp3pUVFJC+od3KT5YhLmJNhYveTT+V9oVyfeVOB863z1xOX8vvTsjccPRdCp
         ljqMsk64+IdeOMlqb7UEyqQw8bQdIoOUA+Yw6yOPP/NG0ej0IFhGkPP3VIwQfLz/qUcn
         jkIAjzlcEznOXtnX3R732MLjNXFyhUITtcxuDOEO3sOnMlDAbjWgkK1skflGJHZkEFDb
         UElg==
X-Forwarded-Encrypted: i=1; AJvYcCWns1DzI7x8w8HRGtOCM0P5iRDToWahoaT515lJ6nFJBI4zHasF0uRMlAA6V6qEzKbJlRV10Ggxj6iAk2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8EHNzfkkOOWDGqgABDwxf0ygcm3gC0US/ozPm9itRaPS4whgJ
	ajiXRcjgA14B/ONX3crxoTaHo/dGybqcpvpLWzmkqQeBxQjtIKsfhk5V
X-Gm-Gg: ASbGncvPdkza/+rlM6yXu2JLmBMPF6ovpSYLtrWTLI+S1gyhzQMDgjuepIPleFf8+T3
	bmVlS5Lh17VDwcS3GsnGUykEUwJmU4M568E0idbgMaUfLaKUDarumTOeOE5os9Cp3S/mvVTSPpx
	OfeVwh5coKjTQ8swaUETezZP+cgXv4qEzJ2h/7fo3LAtnGIkw0tI4woYTSn1MzaCVNvQm+D24Qw
	KCK2UxJ5UNp365/OOaRpaph34KsV6ZB7cMjYeBDcxVl4M41nm5yyxXl2GZPy5RBu+DZJ1krh/Vb
	zudDPJYkp/4nHg5mT/6+4jPI1oq3RkHSUeQDCTIfKpcDZHfC7vdSUm7NxYzfogFfefvQ3McvKwj
	CJYOljdId5lTp+4gJqLi0laaQodYTAfIizm8c65PXHg==
X-Google-Smtp-Source: AGHT+IG326amNIrt95WaEQYYFFDyTfpagBUKaviDy8uBRk8XgT2ltykYjLmd/Lb9/RrzkGixWEyeVA==
X-Received: by 2002:a17:903:845:b0:269:b2e5:ee48 with SMTP id d9443c01a7336-27ed4a5a7bcmr38027585ad.52.1758847186710;
        Thu, 25 Sep 2025 17:39:46 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882290sm35871545ad.76.2025.09.25.17.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:39:46 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: corbet@lwn.net,
	will@kernel.org,
	yangyicong@hisilicon.com,
	fj2767dz@fujitsu.com
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] docs: perf: Fujitsu: Fix htmldocs build warnings and errors
Date: Fri, 26 Sep 2025 06:09:36 +0530
Message-ID: <20250926003938.5017-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running "make htmldocs" generates the following build errors and
warnings for fujitsu_uncore_pmu.rst:

Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:20: ERROR: Unexpected indentation.
Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:23: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:28: ERROR: Unexpected indentation.
Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:29: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:81: ERROR: Unexpected indentation.
Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst:82: WARNING: Block quote ends without a blank line; unexpected unindent.

Add blank line before bullet lists and block quotes to fix build
errors and resolve warnings.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Changelog:

Changes since v1:
  - Remove formatting changes unrelated to the fix.
  
Suggested-by: Shuah Khan <skhan@linuxfoundation.org>

 Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst b/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
index 46595b788d3a..4edf26f8cfe6 100644
--- a/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
+++ b/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
@@ -15,15 +15,19 @@ The driver provides a description of its available events and configuration
 options in sysfs, see /sys/bus/event_sources/devices/mac_iod<iod>_mac<mac>_ch<ch>/
 and /sys/bus/event_sources/devices/pci_iod<iod>_pci<pci>/.
 This driver exports:
+
 - formats, used by perf user space and other tools to configure events
 - events, used by perf user space and other tools to create events
   symbolically, e.g.:
+
     perf stat -a -e mac_iod0_mac0_ch0/event=0x21/ ls
     perf stat -a -e pci_iod0_pci0/event=0x24/ ls
+
 - cpumask, used by perf user space and other tools to know on which CPUs
   to open the events
 
 This driver supports the following events for MAC:
+
 - cycles
   This event counts MAC cycles at MAC frequency.
 - read-count
@@ -77,6 +81,7 @@ Examples for use with perf::
   perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
 
 And, this driver supports the following events for PCI:
+
 - pci-port0-cycles
   This event counts PCI cycles at PCI frequency in port0.
 - pci-port0-read-count
-- 
2.43.0


