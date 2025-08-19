Return-Path: <linux-kernel+bounces-775648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E661DB2C2E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A501966C16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AD0335BDE;
	Tue, 19 Aug 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WluzMahH"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18061217733
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605699; cv=none; b=Zt7DpmU/5WXAw5cDJ0mMnYGZ9Eu2VCB4RhqzL+d+Jbmk91pzOBLrDUrP8bFpUIFvr5m5eem8zqfANsPjGDu+a07OG4aSzbuUbNvu2tlODbC7WeTvqxAPkAOH42tioxPYZftACeUW/JdTfG3pux4zgoFS/2rYEqiT1AFCFgL5nLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605699; c=relaxed/simple;
	bh=r3n24YkeAiFzv8X5Ud5TZiphJux1PzHKFS6EknRtIUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWNXjX3IXS1QflVf3T14KeP5lqfq3RlS7FyM8vXDi+tbdaJCj9DRRxUzGr/6Vlr+64tL/159EamuDeMGVtbosL9lzYoCY388lzaQ4JqArPeJYWf234hiEXpnLuE1uOfwPKC1T8dPOcPdXbB/sQfXNRZ1oXbqG2doggpG050vdXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WluzMahH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso4755596f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755605695; x=1756210495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv3UADiqbQ2TvjUbAoLCvVlixqzyy4Oo4r3fQdXVk88=;
        b=WluzMahHAg6v8rZhjrgVgRXGDut0Fj9sZXuQqXrVlYqFusJe0Rtg+02pdvE6U9ff2I
         crrPYwDbnRU8LX1X/LLmYYDybXZaziu7PQ45SV8RI8xcvzsfU7hUpdQUwQ+3ZjKTjWGl
         3DU0ye0EJ6VY7b40e5svQp0fZKtH1V6UW6mCYJRfi89Gw5d+6Fr+K4bL/qbQ+HRVe3oo
         rUYjYqujOmlz7rig3GosAP98A9u82WTPUAQTXYB/C+SbiOkLXdiJtFLDpLN/mEkTn1A6
         ptH+A5fx34sDciNelG0nwjTA8apZN/rCuzmbe7nM4EHez5ageAZywaVVz7JgpydAdywi
         GqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755605695; x=1756210495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv3UADiqbQ2TvjUbAoLCvVlixqzyy4Oo4r3fQdXVk88=;
        b=mOS6Y0GvwLM4YnGNx/aQqo7RcQX62pcV1mvd7JM8hy1i7SoSVlFLSRlsGbedAwZJ3P
         E2g+xh0BwZre4Jw1Ws8aoUHtBiY/p3myuWN/zw1go2fKDATvGGnhwUomA9RnOCESvxoM
         N+8alwm+QLDcnG1Bjwa05ukYWicK1SauTAW0OltXJ+pwENRhbiggMF33NyzqmdI19S/b
         psAZTOq/cBptnlQsRmNb7SiHBFrAicAp3RFhU8o4t5h3mfagLiWSE9I/ZYDAcHprN3jQ
         t4ItR8fb9wCZSCvcI6hRppxIGYEm1qidzjJ6FzhdGgbYidR7Fj45fBtkusXn8Xp2mA64
         +mGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuZEiXp64rzHqjYcJL4nrLTNxuiBzP+qvMsH015MHEbrcdctwMAAEky/UwwvRituN5pjo5RiKtDpfHxK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1q0bHISSb/zj7KfX8NMWvW5W+bXAHLNPFnc0s87JiW9mCA2qm
	/iBURGPytQJJPSs0nd6KTK6o/rnqOGGlncxD5h4OxETXSrj4yuPz/zgNH0unfGXiIyw=
X-Gm-Gg: ASbGncuoRpPpIst79I9lUGPDsOB6ZIC9OJJEtwYLyESMh0wCeNQOL2j1hgA2D7706aL
	5gQOl1V5f4PK3p6qnleumVC8of6N+P1B1B920VeE3yAm4ehli+SH90ldRzkQSMDhagJGlFL7ETD
	3GvtgIJqJl9SRfpqKop6RKub93mkt5Xe/pikAT/jyBmCSehqoSGU7fqwuMnici6J6a7dJQQkrXx
	RDYVTrXaElENWtK1CRmaeGonD73oQIxL18QPhKb46AecJCvXy0PtZa+AKEfPVeVTJ16ht2zhO68
	Urn42v+65lyhDWW9wQUtCR1x9X8lFLVtfNn7CcrkziLvlVxU19X63pjhG8kdXnpfnNdZmJGGHiD
	3rQY9Vph229oJT6f0AVsk+tfgSs8oZusTzJPDJWY=
X-Google-Smtp-Source: AGHT+IE/kD7//F1ivwBIkItT7/N13kE12xwZismDvDilF7dG6FebLdN4vgvroAj3YGiVbETZjeg3Ug==
X-Received: by 2002:a05:6000:26cc:b0:3b6:936:976c with SMTP id ffacd0b85a97d-3c0e2c89f54mr1719672f8f.17.1755605694332;
        Tue, 19 Aug 2025 05:14:54 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb0735csm107977765ad.57.2025.08.19.05.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:14:53 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Remove unused __INIT*_OR_MODULE macros
Date: Tue, 19 Aug 2025 14:13:37 +0200
Message-ID: <20250819121423.460156-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the __INIT_OR_MODULE, __INITDATA_OR_MODULE and
__INITRODATA_OR_MODULE macros. These were introduced in commit 8b5a10fc6fd0
("x86: properly annotate alternatives.c"). Only __INITRODATA_OR_MODULE was
ever used, in arch/x86/kernel/alternative.c. In 2011, commit dc326fca2b64
("x86, cpu: Clean up and unify the NOP selection infrastructure") removed
this usage.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 3319a5269d28..e9e6eeb042aa 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -151,16 +151,10 @@ extern void cleanup_module(void);
 #define __init_or_module
 #define __initdata_or_module
 #define __initconst_or_module
-#define __INIT_OR_MODULE	.text
-#define __INITDATA_OR_MODULE	.data
-#define __INITRODATA_OR_MODULE	.section ".rodata","a",%progbits
 #else
 #define __init_or_module __init
 #define __initdata_or_module __initdata
 #define __initconst_or_module __initconst
-#define __INIT_OR_MODULE __INIT
-#define __INITDATA_OR_MODULE __INITDATA
-#define __INITRODATA_OR_MODULE __INITRODATA
 #endif /*CONFIG_MODULES*/
 
 struct module_kobject *lookup_or_create_module_kobject(const char *name);

base-commit: be48bcf004f9d0c9207ff21d0edb3b42f253829e
-- 
2.50.1


