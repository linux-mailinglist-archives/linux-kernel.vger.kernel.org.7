Return-Path: <linux-kernel+bounces-853030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF1BBDA7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7A019A122C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A979301003;
	Tue, 14 Oct 2025 15:50:24 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F32F90C4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457024; cv=none; b=UVYmsjmTg0xiqhonW1voOJbNgYQ89DC19KJFyZkCkSiJPxfOJNCR3anfIBfmUIRaeH79zglWBH5m8WWrl09or+qllbdU5CFdJlTRO4n/SNrOGewCHEgxPvtFeXtvVrbQogYAZtYt5Jzh6J/TnhhJ5r4rvxwTMDyiZxYl5Y6P/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457024; c=relaxed/simple;
	bh=8wW9A7Hfsu2FtyE9eu1L3cGcD1B8XIMVxYU+07MkaFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nekJzWs5avvgkzpdXZiuCysIQa8kWzva5yG9tqjdHM62T8iIIraxYiQq7dLxmeFzsLfNxizLqfIuGs/rWrLZ5g5EX5UE33pz1QrAXx+xlft/MRJDN9zqOOAIQ42/0X+NN05my4gC0chrzhPcpyA6aDXQAvu4Ym5tXqDKumazKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horky.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horky.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3ee18913c0so894079266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760457019; x=1761061819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfvNFpgoA7JDzu03KtbY8j7pJNqAnrxvwDDVwSnZugI=;
        b=Kr86HVqGSPLtYITe8fLbL6V8jbY91B7zmoiiA0qX0OYrPVHcHo0vZEViyTVYT6rSzj
         rny8Cq6S2EwCo/amxxC0skkMQYTDRjg8UsLZ0gYhosy9zl/Cm2JGxuNgknTPn6lvAi8G
         8z/hYkoobIPCRk5fMA0HTMmwyutiBrSMkx3zsvPmuZXObxcFAPEfuz/0BxqgIfTxXI4f
         z/9JcWYtkOwC2bABp4iKiacmsxH9t4wSCl+pJGapZxMNaCL8Zftzbk4qWy3f08Ii/ECH
         hjFSqaZ63UiOTQkDRt6GKd7911MTFyE0JwTYDqEQ+w/wk84Wfb/bYLZODyGzhd+FKKKx
         iNjw==
X-Gm-Message-State: AOJu0YzQYBzC4SgY6+k8kXcu8eAk3XynuWnD+ldyv+WzydZ8GrPUxQs4
	OzfiYRZCd3+Jr2XGkRWu6zvqhzob1BVudVlt3rkTPDF3daCex31GUyxH/zp2+Pk4
X-Gm-Gg: ASbGnctSdf8jDz1z2AsGtqWsbHcAJ7rRvnkV9BTPh/zemWi/7P0hcnlN4kkcW98WiXw
	D2VXviKdlDrp9k14iC7T6ryaSYqF2AgXFL6H3f1ivrFHjw2MRl3BsQZpJhFeL5xjSBDRk2/uuMK
	7OnDfbOzINXxh6Ch23nhtgyiDeXZHmkDmOVxaJi+PtKDjjiqAUfT0I/FZGl694Jd1GJor7VfYy1
	/XgY+zzaCwDCXRrWIcYp8CP7hAGy8fgoVpw6qSGSn16kjlQLlUCPZgKGoWKxyS7YJHlA/2H3WBn
	uCf5GIowfxluNtJIjy7Q0ZYfLssRwjH4AIhqrGI6epdLmHZVBDgSNJg5MVD59VW8LGSv68X+qwo
	W86k2X5lhpP0tfOrnyDjcxsYrPSG05N3mlEczZdfQf7zVXmPMaS+Kl4xqQQRPUVeSqk7eJ4n8u2
	TMvhsIJg3d
X-Google-Smtp-Source: AGHT+IFrzNcJc4LRTCmc3RmtM+wWnHntc5d+dwnNIGh9HbsQnpZNJt9jkLHH9KTbAU1PSvCVFPd1mg==
X-Received: by 2002:a17:907:1b21:b0:b5c:66ce:bfe6 with SMTP id a640c23a62f3a-b5c66cec14bmr94865166b.55.1760457018931;
        Tue, 14 Oct 2025 08:50:18 -0700 (PDT)
Received: from jamaica.cek.cz (ip-78-44-100-18.bb.vodafone.cz. [78.44.100.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd7bda3csm7165666b.84.2025.10.14.08.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:50:18 -0700 (PDT)
From: =?UTF-8?q?Jakub=20Hork=C3=BD?= <jakub.git@horky.net>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jakub=20Hork=C3=BD?= <jakub.git@horky.net>
Subject: [PATCH] kconfig/mconf: Initialize the default locale at startup
Date: Tue, 14 Oct 2025 17:49:32 +0200
Message-ID: <20251014154933.3990990-1-jakub.git@horky.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix bug where make menuconfig doesn't initialize the default locale, which
causes ncurses menu borders to be displayed incorrectly (lqqqqk) in
UTF-8 terminals that don't support VT100 ACS by default, such as PuTTY.

Signed-off-by: Jakub Horký <jakub.git@horky.net>
---
 scripts/kconfig/mconf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 84ea9215c0a7..1e3322af06d5 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -18,6 +18,7 @@
 #include <strings.h>
 #include <signal.h>
 #include <unistd.h>
+#include <locale.h>
 
 #include <list.h>
 #include <xalloc.h>
@@ -931,6 +932,8 @@ int main(int ac, char **av)
 
 	signal(SIGINT, sig_handler);
 
+	setlocale(LC_ALL, "");
+
 	if (ac > 1 && strcmp(av[1], "-s") == 0) {
 		silent = 1;
 		/* Silence conf_read() until the real callback is set up */
-- 
2.43.0


