Return-Path: <linux-kernel+bounces-863988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FE8BF9A89
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0D3A4F3387
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FB020CCFE;
	Wed, 22 Oct 2025 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sw5f1Pg3"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEACD1FE47C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098151; cv=none; b=jX5kEFvwJYRXOMbExTuieNR0BWCzBEccFJT+W9uesKbKbnJKF0lVCL2hSNRJiOzW5bbGKkvpJk7btkDXZgUVGSrcKemDJblxPpUxTB94Rx4Kqkxu9fEZYkY6kKGsWGsBqN75O2DDTfyBqMK+GlctJgHm7IA3nCYr7a6Hi/N27MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098151; c=relaxed/simple;
	bh=Y5j/Bnfa9vnAcAs2FiaNWlxj6FttS8dn3fKo1856mw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EKfGNfkPkH3Js5Jv6AwQY9p1v9+rgDQ1yyBEj/bu4N3IifvWwG5zU6gwXVtgwkqQLVYiM96Hs63Q2zUbGgyLJPaLSJZJisw0/2cZ37wBwk4OAiI3dL4OHlzMsTZ1h+zM0LrgbJ+rLzpz656CTzyX06YGySmIZyyMN26uTHyFgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sw5f1Pg3; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33255011eafso5907565a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761098149; x=1761702949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdRGmRFj0+9fhloGjpnhbXyISHONx/9VHecgIuMRmLs=;
        b=Sw5f1Pg3v9t1VCJMXnm9feA8QOMyp/QKrrr+xxOCvaqkqbXkPvRAtEFT6hqrbpeW/V
         eMSka3hsE4n90+7chgeJ54zv/z1Y6eGsviMJOdoQ8TcSEOqcVKn/NLmX+xrE6CkggUVz
         HGwk0Wk7Tg5G8XuSnKFL/HG1Dz/0NkHSnMs93oI/otcY+clTHIkDXj+arS+BfEU79llN
         2M+lrna7HHA2f2mdvw3OZ9KEtXGrt2aCjXKZmsh2jmGXpF1kB+oc46UzKHCyVjqjzYRj
         U2GZCB4Plzf2tGLbSQc25/RvBYLjd1Dhd/7tYNCv2Rk/wmgNZYHt8ZjFG32FE1j/WdSM
         /hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761098149; x=1761702949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdRGmRFj0+9fhloGjpnhbXyISHONx/9VHecgIuMRmLs=;
        b=phGzfvpefxdFAKJZvUfOHdsXeW9BVb+TTJQvvajNJFTqTCMeP0l+KcYYwOYqw+97Rh
         KJGKL/iSMiDgUUh/peUflFIvitlZ9BLvE2Gj9UBWXg9Tvd0YkuBcy6cQI0HpYgcxnWS5
         HyRTsuzZE2un4edHkf4eUYhZ8MXzE1dAUhrQyEwp6/7NXz9BA+rh1ZFdBcuP02uTT08D
         k2gt/+ybNuf1dJ3e9l9/1E7JNrP1th3jm7lxznDBstq2td10iDS4Ch4nULpzLSZZvrhS
         T9AhQxKUtCf6keHvMKXkBy7/EMTLSwPVP/hGzfKO7weIvh/cUQWj2T9UwjEBzW73gJh9
         Rpfg==
X-Forwarded-Encrypted: i=1; AJvYcCVWkLnS2iee+dTZm3rigd4EnNmw+ATxGw7we/rgpQdkLGrw6nT+FBZPrpXeYVIUGCE9oEepZ3RVO00z1QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygwT00IJR5Ecuiw89rXa6YFhCmvQBRNd6ZvgP4pfudwe4xzW+E
	WemvRfYpg/HZDfIbSpPDwW01d1w87YC+IfNoOrtCiPIht510/ae9rvrQ
X-Gm-Gg: ASbGncu4ESFN6ETwqr4tpiC5Aayp3biQmGv3JUwz18VzvFddBOVk9vBldjyq5A2S2yy
	vm6luVLuIsXWEEy9TprvbL4oW0uvz8s1CYqw/SF8RzRhmOnfH3VhFibqdEaPnBBnUezHM5wUHnQ
	CFvQX/lEjffWDv6ozwFEc/4pEEv//ez0ssAG3Du97MDPJOGc9VbW6lVPGjU6mxQy7C6mv59DHMo
	lKxhhBSPgy4MYxOGUo/nTohJbMr3mvn3rnRQbtnWAETFS+EnyPhpVzqZ5CQXIfikwjdEDg8VwGn
	9jNMiVSnQiJDPw+jRgkJD5w/Z1wWTSf/guNZ6olKNT/A0e0DXhrgeuC00Bl8IQTIRWjTRqv467E
	ZgvNy95z9hh/rDVvAFQlyJDN5qRLyb9S3+kD26iQFLJOL012MPqL1z/57MOhdEOJTYjj1LA9Zvc
	dSZBxJbvnhRQSw2XCq
X-Google-Smtp-Source: AGHT+IH4VFJdE+kDCVl6k0I6gA+Y4FWyXYx4XWrJNt2MQHubXgoRL2/ifVMDcCHlbJ/5611GH+xrRg==
X-Received: by 2002:a17:90b:3d87:b0:339:d227:82fb with SMTP id 98e67ed59e1d1-33bcf8fa579mr26874479a91.26.1761098149249;
        Tue, 21 Oct 2025 18:55:49 -0700 (PDT)
Received: from hilb.. ([170.254.111.1])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a22ff14a2esm13163188b3a.9.2025.10.21.18.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 18:55:48 -0700 (PDT)
From: =?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>
To: 
Cc: =?UTF-8?q?Bruno=20Sobreira=20Fran=C3=A7a?= <brunofrancadevsec@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Gabriel Somlo <gsomlo@gmail.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] soc/tegra: Resolve a spelling error in the tegra194-cbb.c
Date: Wed, 22 Oct 2025 01:54:54 +0000
Message-ID: <20251022015511.7257-1-brunofrancadevsec@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I aim to join the Linux Kernel Mentorship Program, so I'm currently a
ddressinng minor issues in the kernel.

Signed-off-by: Bruno Sobreira França <brunofrancadevsec@gmail.com>
---
 drivers/soc/tegra/cbb/tegra194-cbb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/cbb/tegra194-cbb.c b/drivers/soc/tegra/cbb/tegra194-cbb.c
index 846b17ffc2f9..9a52cd3aea65 100644
--- a/drivers/soc/tegra/cbb/tegra194-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra194-cbb.c
@@ -1836,7 +1836,7 @@ print_errlog1_2(struct seq_file *file, struct tegra194_cbb *cbb,
 }
 
 /*
- * Print transcation type, error code and description from ErrLog0 for all
+ * Print transacation type, error code and description from ErrLog0 for all
  * errors. For NOC slave errors, all relevant error info is printed using
  * ErrLog0 only. But additional information is printed for errors from
  * APB slaves because for them:
-- 
2.43.0


