Return-Path: <linux-kernel+bounces-834661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C84FBA5346
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966101C0416A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12B428851E;
	Fri, 26 Sep 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2ik5e76"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21CB2882D7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922023; cv=none; b=Y9KPfiuMzCtPSQR4Rgm5msExE4qsGrcBWaqiJkJdK6bzNM14Xg6H6sPbmu3spXkdjzXlZjI06m2YQGL2rJuwzqvb4Hl4ZwhtjnzKhvhtHVsWu6DsNvBZIBj9vq54leTJc72QDCeeowIE9a1eesm4gc/i5+jp1KWAvRrLfgHJXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922023; c=relaxed/simple;
	bh=G1cYqelfWjz3TjSh+JGPX14LLVReCZN0uMRhfP+qQ/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6lEJeErsRpF+jKO3PHf5yaq88Ul5nuIK/s46bYzDeoE28VxOKdxathiS3LPuncALmT/z9v3oQYs1c+Hi/PUehwawufsLaKUiZOeYmspXYyPEqIP/fbb+OxluYKz/rVivUMccK+9zfxZNkoQ7NIkOvxvLLjeeyENS220xU4HrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2ik5e76; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-271067d66fbso28059675ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758922021; x=1759526821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgNilygMgwHdZEs1ZnH5984F+hiJNsFdGmwbqZj2EaU=;
        b=U2ik5e76HuQGCQVSTsnTuSYVWnK2YhIa2FH9Pj6N+qtEL1P7CAwXdbSOWm14fjSUrp
         A+LF3R/l7e97/SnAaPQ6D2L9FEjpb2lyFOdBDgscYQ+u2XH7jm+l4RQaaxV5aVIOwpdU
         ZGtiQMmfcizNOMwFD69Kj1z+hjd6vv/2fDpysaqvsoeGVHz+hJ+ihP2+7gFoJ6HqLX8c
         P2rq7MdWiqZZiFzMN/4hv2qj6t/iOjstct9xuBsdIRPkI/SR5zzKk67J6tCx5hHt/uWS
         HiCxETx8kijpm7nQ2lSCD11S4lbhSmENRb4fYEVb7ILtxSEUv61qkj4k4EdznubDWyKG
         OEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922021; x=1759526821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgNilygMgwHdZEs1ZnH5984F+hiJNsFdGmwbqZj2EaU=;
        b=J6HszHmW+z9YEagMJmX1dZEcZgQndTvQcvKLNJ6bUiDbEJurOhleElXchaOccl1bOO
         3FK2yQsHdEcQB/QKgGQu0BCwmbyySAmNdn0GExJJir8CmByph/7nOMSCtvFm4esWrzT9
         dI6ZWoRzpYO+8gJ4/tF5xutXRuIe1IB5T6lgBP2QpBe9VoxlrzCJSTQcFZ+1uAoVtFh3
         nCc7e5ga3UIAG2vV3iwEXz3thECO9HbWKbJjhM+Pwxvm3otkHEratiUHyxc9ByFq4KzQ
         xmVoAFSIIaPVUD+fgeUmyi3uOD+3ZgJzJxJ0oCRh6yLD7BS1WXvZsXKCHZXqyzY4KNq2
         SNpQ==
X-Gm-Message-State: AOJu0YzodidAt9GMvqN4E+VBT7hPzw1NupImwRk6WTsfHFLo0In8iyC8
	KjmMgX5Jd8aUon85INo2gJO3ZE4KtDdQcYb6v/2wSa6T/RMkTAx9Y5kK
X-Gm-Gg: ASbGnct5K1Z4tKt/+ZwWTsmgVSyiKdCr6WIeZeMLqI20Yt+3VjHua1WYozGzdMIYi1D
	9OtbCnj1QDbkeWC/gDJbSxxGZ0SPBTD8NL/TeSUd54NYPqz3z4F3TqCsf00SdmSzU7uafQcom1Y
	o1LuP1MzNCzxB9J8Es3myHdbDkvoisOnVqDwi0v+04FbHHD8P6oeHS7myiLZO7IdFpKC6xQtpmT
	NN5UMk38RqaVxW5OqiHjZLwEonDBeC1P3YOJNc8ynzjjOTme6N9GF7Y6BQrh8j1zGEr3B7pImJt
	hOSOSOMgnsRyCHPcUhiiCUhCz1Y5WVOuYgygdy1xryJPMZL9QMpYJZUNI+rnLfJvqhK05+l9pYz
	UuySDQ3GTBQAu5Abw79lso3NDgE8U
X-Google-Smtp-Source: AGHT+IGTzlIKcFo4sqkt3yWBD+x+KPNdidVuwiGXfNI0rgF3mQzrIl9N7B2rNacRAdOjJu/uukKemA==
X-Received: by 2002:a17:903:1a2b:b0:24c:ea17:e322 with SMTP id d9443c01a7336-27ed49df28dmr99920545ad.3.1758922021066;
        Fri, 26 Sep 2025 14:27:01 -0700 (PDT)
Received: from archlinux ([2406:7400:113:d078:5679:3e8d:9b65:9f1e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671d8c6sm62722275ad.56.2025.09.26.14.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 14:27:00 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH v3 1/2] selftests/acct: add cleanup for leftover process_log binary
Date: Sat, 27 Sep 2025 02:56:14 +0530
Message-ID: <20250926212614.684998-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922091042.149117-1-madhurkumar004@gmail.com>
References: <20250922091042.149117-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acct_syscall test generates a process_log binary after it runs,
but this file is not removed by 'make kselftest-clean'. Add an
EXTRA_CLEAN entry to ensure the binary gets cleaned up properly.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---

v3:
- refined changed log wording
- Removed patch version info from commit log (kept only problem/fix).

v2:
- Fix newline issue at end of Makefile (caused add/delete in git diff)
- Code otherwise unchanged
---
 tools/testing/selftests/acct/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
index 7e025099cf65..fd14128bbddb 100644
--- a/tools/testing/selftests/acct/Makefile
+++ b/tools/testing/selftests/acct/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := acct_syscall
 CFLAGS += -Wall
+EXTRA_CLEAN := process_log
 
 include ../lib.mk
\ No newline at end of file
-- 
2.51.0


