Return-Path: <linux-kernel+bounces-849028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4110FBCF09B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6289D40364A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B8022172E;
	Sat, 11 Oct 2025 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft0tDwcy"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43EF22332E
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760164744; cv=none; b=kxqS+yjKyKAqEjuVggArY8mLfT+JHnQNO/6SEBqE//W9RAiR3kHri/DY7sKvWJrx0O+jsd9pZo3Kdn7CxYPc+rkHrXL6LOeNg/AZpuFWUjlFTvT0kfpzA1DVY6yT8lfjANYzAofhF82UxOy/iOyiC428g4gd1OWnF9Zn9Ck9FSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760164744; c=relaxed/simple;
	bh=g+jmgjmrR4/YskSIPfMmE2GQi0643yZ1iVOqd15YojA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S023yO1hzyZHMAvG6ONNL1ovEiwFbYzouf7jkwTDXjjoJsHesDbXPgdvweRrOmhUl3Vev7LeuRygS3ShSHoK0dGEKE18QYFsjhLJkyBGa9Fch0NtdjTE536QZjTrJ0JQ4qHs1u7sljNoFIpxwQ9xYJ+q2zbNhm/s5UKJ8Bb5Nxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft0tDwcy; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b679450ecb6so952239a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760164742; x=1760769542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shA8rePJ19wVlfjQPju/k0dhMI8bALDCoGiOWjrRyo0=;
        b=Ft0tDwcyQEFH5MP3p/bwbjW6tCR2ChKkxtiqgcrCNot+RrY8fgSo6C+KCDqCZESjqO
         Ac8a52rhgZRO+6XU99CsHEZhHZcE/d4LZQJ7nY5BY1rmjGMqmsD0WCxaSVrR588eyB7i
         ildADbIdRZU+23aonjY8nVRsksH3kglvBB46bbZd3tJFBIjH6GRfM2bqiRgBaVmk9TXW
         v3jHNgnJb1QNK4FMFrt8Fa8Vh+24zZPShbxpr/uesRxm9CMPLbod1BN5gkqIYeMRosjO
         sZqyaxWAq1Fzbp8LxHeUjdqyLcIGw07ZfWQeQ+qJNMKi/44ddsjV/Vcrbg4CLY+92n+7
         qV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760164742; x=1760769542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shA8rePJ19wVlfjQPju/k0dhMI8bALDCoGiOWjrRyo0=;
        b=C4q60XGCRO4LRB8GoHF49kwJYhjHdTAuq2+zB0m4eBdZN2YOn4R/w6BeGZbD8FEuLQ
         /L4WAJLxHSISWIafesGQuWJ/Z+20tjcaB0k5La3KqlGxBqlFuaAFQqoUGxFuAUjdFjbd
         CvW/OCjoObPS+5KK/WJiUw1opxNadWrHlFUKhW3zCIyc4HWpDTxKdTbbSut/tP/zz+CV
         v5opmMJmPH9BSuFhFuLe8pzNT/ek4UHUp5v8+cLmgmABHZY90bWIKQPtFRbwUarcYjfM
         MB8MJCXOv0O3GyD/SxxwwUBBoHiWk20z09DMF95dtt7a3JEkJu9z6kzGkVib3nOGffJv
         TaCg==
X-Forwarded-Encrypted: i=1; AJvYcCXoMnmQtOzJVm6TOVLrWQfjcYOg/X8JAA9nP3EJ/TV+NrG/VXnbhFlfD2Zr3tHZ7PtY+0dC+VhLvdbdggE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLbh1/3KRVw0w2yk7YwNovpfcNzkJy53vveqI/RCePvLHX/4kb
	JtQxdbVMgx9ixo4SVfvo0eWyfxrsJpPQx1Dg4s0pijT7mkJrpIu/EB0U
X-Gm-Gg: ASbGnctNaIkbB1PpA4rKxsqK0o05Sxq0ao/Fj8LPfp5ePxQf/+zhx3bANVPrWqxWruc
	EWQNqgUFiaVMLhvrAHj0V+X2Tnjl24MkE9wGRNGeNeleU7666nDPK9lEERWcKWGphuGSxNTyK39
	U5chsr/DaOaE8eyHCPhiCTYaMasKmgJ0iD0HU+E8b3n/Tuw0T4zkM4JDgc5g5tjx0pge9vWaj5d
	k7RXtS5XNWziUKqa8gja5bWHUtOCIhqqQQUYm8wwVtS1rN2LodRakkr9ALwropgJbkWhBenBnPk
	O8vLTKT6JxhL/MUTB/27psswU/prttLiL5pgqEuWmBUzOhG9GxTltNam9lOrLtjUT7kEFYTdACi
	XZ+Il3/m0OdNcgZ5k9/MKVThDpguqt+VbgGBMDjBbAG6jM/J6ad0zQQ8AS6uIElpqR6Yw2K6lAb
	8mxvRHVA==
X-Google-Smtp-Source: AGHT+IG/jpwa1wPZmeP/lKNRuLiyl56EQ08bY9BGkYBnOH/Qya4CL3BuCNt+6P0B7CVbFnypfO2IcA==
X-Received: by 2002:a17:902:fc4f:b0:280:fe18:8479 with SMTP id d9443c01a7336-290272e0ac5mr167833545ad.51.1760164741832;
        Fri, 10 Oct 2025 23:39:01 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f362efsm75647005ad.89.2025.10.10.23.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 23:39:01 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: mario.limonciello@amd.com
Cc: perry.yuan@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jserv@ccns.ncku.edu.tw,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/2] platform/x86/amd: hfi: Remove unused cpumask from cpuinfo struct
Date: Sat, 11 Oct 2025 14:38:36 +0800
Message-Id: <20251011063837.2318535-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251011063837.2318535-1-visitorckw@gmail.com>
References: <20251011063837.2318535-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpus field within the struct amd_hfi_cpuinfo was allocated and set
in the amd_hfi_online() CPU hotplug callback, and subsequently freed in
the amd_hfi_offline() callback.

However, after being initialized, this cpumask was never read or used
for any purpose within the driver. It represents dead code that serves
no functional role.

This change has no impact on the driver's functionality as the removed
code was entirely superfluous.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Build test only.

 drivers/platform/x86/amd/hfi/hfi.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index a465ac6f607e..5d5d2cf23a75 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -12,7 +12,6 @@
 
 #include <linux/acpi.h>
 #include <linux/cpu.h>
-#include <linux/cpumask.h>
 #include <linux/debugfs.h>
 #include <linux/gfp.h>
 #include <linux/init.h>
@@ -95,7 +94,6 @@ struct amd_hfi_classes {
  * struct amd_hfi_cpuinfo - HFI workload class info per CPU
  * @cpu:		CPU index
  * @apic_id:		APIC id of the current CPU
- * @cpus:		mask of CPUs associated with amd_hfi_cpuinfo
  * @class_index:	workload class ID index
  * @nr_class:		max number of workload class supported
  * @ipcc_scores:	ipcc scores for each class
@@ -106,7 +104,6 @@ struct amd_hfi_classes {
 struct amd_hfi_cpuinfo {
 	int		cpu;
 	u32		apic_id;
-	cpumask_var_t	cpus;
 	s16		class_index;
 	u8		nr_class;
 	int		*ipcc_scores;
@@ -295,11 +292,6 @@ static int amd_hfi_online(unsigned int cpu)
 
 	guard(mutex)(&hfi_cpuinfo_lock);
 
-	if (!zalloc_cpumask_var(&hfi_info->cpus, GFP_KERNEL))
-		return -ENOMEM;
-
-	cpumask_set_cpu(cpu, hfi_info->cpus);
-
 	ret = amd_hfi_set_state(cpu, true);
 	if (ret)
 		pr_err("WCT enable failed for CPU %u\n", cpu);
@@ -329,8 +321,6 @@ static int amd_hfi_offline(unsigned int cpu)
 	if (ret)
 		pr_err("WCT disable failed for CPU %u\n", cpu);
 
-	free_cpumask_var(hfi_info->cpus);
-
 	return ret;
 }
 
-- 
2.34.1


