Return-Path: <linux-kernel+bounces-858596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5379FBEB3EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A18189A375
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C116732C952;
	Fri, 17 Oct 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixMNJIQI"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994152877C2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726232; cv=none; b=sHonXoZ3OBahxyHOqAY0xV0hmg00XmGtSZprQP6xLmoM+5lqQ96G3ydSvAwyFQhsbglzMyQ2edE2aU7S45/CKjnjU17ICek9tLK0qBXhS2qF2iDg3uyrHjo9iIzRhcLTsLIku2bRojm/hfHPUAZObgoO7koRLlY69jpMNHSsZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726232; c=relaxed/simple;
	bh=0HYzdDZcUi93MY7xV3bFA4oYlGIU1yq5GRoqS26jaIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHSarNJyVrT8XkhHfX3fXZi+I5XGL+k0GRipBa8S0veEg7MrzBME6PF2K6aCC0i4GcPJN7c5R0z4ev3ZW8Zf7PWEv/kHBOWtGA1nRNHe5tDoPRMQpOpNIw+7qU/HjJwHUqVYsCbuY4IDoVl250LckZr3yioITqbHrb6Ky8721iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixMNJIQI; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c1413dbeeso3091192a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760726227; x=1761331027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1rE57XXMWa+VwNPDtVGrV/wXcErqp5ekEXu+eNAT0BQ=;
        b=ixMNJIQIe9id/ScC49z/ts4yLewQrUrkCGKk5tTUNpWBDZ5NzikPtRlW3hf7bhv/vn
         8wYyMQeH+ExqWSUjoRSbUu1NNnEy37lWysRigTXaLFSeBPb9fSGd4Ev+1beVjwsrYlo6
         qy+K2j3YwwecI1gOzjnABn+68ylRp7zP1Orr4legJsmtRRyuRY6vJXLhbrd/QFRs8f8e
         m1fdXkgP0Oq+XytJLwnvaGXluuENzhyPuMye33mcD1LKw/mVirMHlrXLHp966nsMjujb
         TCBZrQU2VkJtX9sovsJeN5VYirjwWt68ZGDKTzduZnC7vFZjCF+jSn4eKK6uMpi8WisX
         GUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760726227; x=1761331027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rE57XXMWa+VwNPDtVGrV/wXcErqp5ekEXu+eNAT0BQ=;
        b=UAPbbwJTM3Hg9mPe49ezpnwB2VGYE9Rd7eP4atzZ9ipclAj5niVtn51FFPF2Gqlu+X
         LclW1fwLM3GTLXRbbs+FVQwAf3wjp0GpCXATrlEt5W48z+b9gdndPzu7JZecnmPplj6R
         7GcRYl71fWQUZnwKqYA6CaGIS6T3XCpG7sshcpDT6dLsiq/Bpc+mbYVczumZsQxh3Jmx
         u4wAG78hura1VJaoZViiPSeYKEFUo7P4a42G/7JK8S6PZW3NC9+3vhbaKmjQIDbqzpJ/
         Pc4C7kuCm2Zi1P3w1Soj65mF0Bf7V0Inh+z12m4I56faC2od5vD09mWuurYpaafTHkPY
         1ARQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaGXD+nCfCRvVsMdFNDWPhO6RPSMIWRz0xyr8eq1Lxgak015oXyMtI4xvOvyPePE3uY7CVo5cNbzHgc8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB3T8ldqxZ2hEagVI4mWHHouknjEhy7U2j4wbcNCK+HHk5tZSC
	YhCETneX+uAdgpKniDJZWIXEBGCek56s74bT4IwzjZSSEGQgMvoWRGMc
X-Gm-Gg: ASbGncux12Ug8ZBnwXKuEiGb9QvypnIZtxbUwERIBYbCTR3uG6ysHnvU5FKePMOQTOR
	5BPPh+ywQOtjwCebH6q12ZoTtrQvGHfCwaSpFnqG4Ov01SYIUFqmNns/LiAtqqzg+q53H27JH78
	1b3H1QM6v+yU3kKubCyaZ2ny5DFVKs1qxyQVdG6f8z5DYcJKYz2AJu0rL8TGWjTd4LSGXsxE4Qj
	hwrmtVZjH6RYwvc3RUXfGCXKTke/pNgBvy/wXeM5uy2El/JGpFsYZNGYnLIiV3DoUoOC2+Y5Vim
	8qEpLUTfLhPBLygvua8xx55sUQ8/kyCo7Lgej4xYgb6iKC+vnGZvSyAZnGj1Jvdb1IBU59NhCUw
	Zj2ngZs/nUvCuNGtoX/Mqses+M5yOsKhQDOCdSH8tAkSXlvN7SSd5IbiYpcs63xXKKuxj2CWQ2h
	R7gyGh095IZkOuYAtmvzdD6Tr6RkODQdahWSmT16FQySuknbuonBPy
X-Google-Smtp-Source: AGHT+IEqDf1CFx+tImN/qmpjBMn9gDXH5AAbouHdZCqZsw8BSWD0GaBU+JjrB00u6MgijpPDdz3IKQ==
X-Received: by 2002:a05:6402:4316:b0:63b:fbb7:88bc with SMTP id 4fb4d7f45d1cf-63c1f628bcamr3968505a12.5.1760726226709;
        Fri, 17 Oct 2025 11:37:06 -0700 (PDT)
Received: from localhost.localdomain (93-87-220-163.dynamic.isp.telekom.rs. [93.87.220.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c494999dasm321247a12.37.2025.10.17.11.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:37:05 -0700 (PDT)
From: Lazar Aleksic <kripticni.dev@gmail.com>
To: hansg@kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kripticni <kripticni.dev@gmail.com>
Subject: [PATCH] platform: x86: Kconfig: fix minor typo in help for WIRELESS_HOTKEY
Date: Fri, 17 Oct 2025 20:35:21 +0200
Message-ID: <20251017183521.16268-1-kripticni.dev@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: kripticni <kripticni.dev@gmail.com>

Fixed a misspelling of Xiaomi

Signed-off-by: kripticni <kripticni.dev@gmail.com>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 46e62feeda3c..c122016d82f1 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -432,7 +432,7 @@ config WIRELESS_HOTKEY
 	depends on INPUT
 	help
 	 This driver provides supports for the wireless buttons found on some AMD,
-	 HP, & Xioami laptops.
+	 HP, & Xiaomi laptops.
 	 On such systems the driver should load automatically (via ACPI alias).
 
 	 To compile this driver as a module, choose M here: the module will
-- 
2.49.1


