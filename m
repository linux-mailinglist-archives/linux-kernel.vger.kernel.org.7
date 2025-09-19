Return-Path: <linux-kernel+bounces-824782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A215FB8A24B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8929B61B99
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D666631A069;
	Fri, 19 Sep 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUoV5E98"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F233164DF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293890; cv=none; b=ByXvnJrAF7un4S00dD9uZe6QhH30Z4X5ZLSb6l9ETxDpNxdWQONTd9Ytb1fT2Qdb42bjyhpReYYUW3snDC9ofJ8A6RkdTCRLZ9dYg+fw7Iu/X0kqWkCmnnRLUzW3rxd7HG+SwC2nMYsugfK4UUIrJCaKxveijEJf2D2L9pI1wSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293890; c=relaxed/simple;
	bh=3vn7Sq0i7hG+a6szTOMm8s8ZW2GBG7tNPmnyf2hSsp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNZAFrYy7VnD4Iw5eBlpHN32/+ogTebYqg4vms5+pJHLakoCmyqdBY78Kmjah8J0toZwd5aViI3TVKVEHEAGYNuggPmqtGjrjnqEYVlfL6TeQokhHlrruzy+bvPuarozU6d07sBsllKcp6mMGi4qVkZqbugvcEWGm2UcolNcJsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUoV5E98; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso1222361f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758293887; x=1758898687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqsEMj50XfHOshwHI2kqebsGSz4e9jnLx3tuTedHdO8=;
        b=bUoV5E98nKkxs+7HB72ZK8Pl0dMf43RjXIUj336jgINJXRzhuM+jqJirfr7fSwwfzo
         CgmLm6JIYkKzUgZdHoHB5XAjBHpxnDdf7m26kKzF/mLrEddIm7BfushQ0aZyvc/oYlRj
         UFxg2EHiGk2OlaZwnSPSg9WK+e4RUEGYNaZu7QDzgusSNebroUUQ01Qr8mqEuH9yKWwy
         BOEFoNKJJs/nTDLlk3Y6y1OjjHZJLCRCl37wvAmfqohRRc6xihVBu4arPf3thwtxzDY8
         eQFCOCZsEvFG+4gzooWMoC0sMyij+cflzvOnMyx8CL+cJXaPBI9RMSxraq4GHHjFqZqX
         c9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293887; x=1758898687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqsEMj50XfHOshwHI2kqebsGSz4e9jnLx3tuTedHdO8=;
        b=Dom8najGVRguRBL7Yid8CLsUTtjpM8D+DrkObbO9/EAaDr++Ed/rr/14mBy9fOsdHL
         10/coYzEfNClEWWXi5Vh4ZXo7BezJCl+/f4IYSHsvcSrl7rGxbPOpjvB44DPXSlKBrCl
         S/1GMN3M9wO3w5XNSGxrAcU2AfUJlTy6/tN4QsxYF+PYLx364TjAEIoec1japwDybBGz
         +1LOssMKPV3kX8HodwS1HHcqdruSjz4aoAZRpUhNyOaMEtrXyBvuuhczTWHKVQ16h/ki
         f2ctcLIXSwAymR6R+fz95ytidPCTp4O2xucb+QxDRfNfRJHDR2+Fg4c7qZ8f0p64BBMU
         Z3Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXJn4VLhdyIbpfJapKvwuVNvmHbmVMx6rYnOHL/hjWUqWeZoBrduudGl3jrtaUJJj476UrtucVMZ7i/XGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJHW1FW/vxSn6Ae921c4cFlKaQLy0O926XpfCOTncfgEZr2vZf
	es7Se16n4iX9GGs9DqT9+HwvAGcR9QE6akWDXXMhc0TP8oht1Tgl09xi
X-Gm-Gg: ASbGncvgpKEUgeQOtzdBzRP4b3TzwCMqGsWD1xtNFROMIVGzG35Ybg0mvktl9xg28H8
	k6yHdIOlgEXjx9kBQctIeW2pk38wg4cWYALaiCfUPXvhdBZ+bsHtvCRPA7fxK/9jE2ixSVYY293
	ztTD3nP/2h2HPG/0VRZHPjOf6FXCi6bAmApN+wqWDmPKMpZIhKiPElrrxcAR7YTN+lkJ55gba82
	kIanXIFvoz/3lp3Y2k0s676K+m7FLNzXZOX6rTNHzjPFYWOvEhZqxmiZ6RfReAQdU+d8rRz4TOp
	aruFgAHhIOtlptJu/QPorca4nFH2/PgZODbjQ6BHoi58G48VsLlRedEh2DunDS6i+Krg378z7r5
	zu2xtMcfw2dE0wqYwdh7deqq/lNP4DSTukAWpdpDBQlKfnT/MlkNc6VWh5eAJzcJ7MkNU5yRoqo
	wJkMD7Vtjqf1u5Ooo=
X-Google-Smtp-Source: AGHT+IEQGQ5Ibv5m+pzFfVuYC0xkpO2eoDLOdQC6WRoyuHEWEKPg7eRdhB1UiP1O9gJT0nbSt3KJMg==
X-Received: by 2002:a5d:584f:0:b0:3d1:61f0:d26c with SMTP id ffacd0b85a97d-3ee862edc77mr2891484f8f.54.1758293886534;
        Fri, 19 Sep 2025 07:58:06 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (124.62.78.34.bc.googleusercontent.com. [34.78.62.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm8551386f8f.37.2025.09.19.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:58:06 -0700 (PDT)
From: Ethan Graham <ethan.w.s.graham@gmail.com>
To: ethangraham@google.com,
	glider@google.com
Cc: andreyknvl@gmail.com,
	andy@kernel.org,
	brauner@kernel.org,
	brendan.higgins@linux.dev,
	davem@davemloft.net,
	davidgow@google.com,
	dhowells@redhat.com,
	dvyukov@google.com,
	elver@google.com,
	herbert@gondor.apana.org.au,
	ignat@cloudflare.com,
	jack@suse.cz,
	jannh@google.com,
	johannes@sipsolutions.net,
	kasan-dev@googlegroups.com,
	kees@kernel.org,
	kunit-dev@googlegroups.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lukas@wunner.de,
	rmoar@google.com,
	shuah@kernel.org,
	sj@kernel.org,
	tarasmadan@google.com
Subject: [PATCH v2 10/10] MAINTAINERS: add maintainer information for KFuzzTest
Date: Fri, 19 Sep 2025 14:57:50 +0000
Message-ID: <20250919145750.3448393-11-ethan.w.s.graham@gmail.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
In-Reply-To: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com>
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ethan Graham <ethangraham@google.com>

Add myself as maintainer and Alexander Potapenko as reviewer for
KFuzzTest.

Signed-off-by: Ethan Graham <ethangraham@google.com>
Acked-by: Alexander Potapenko <glider@google.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef..14972e3e9d6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13641,6 +13641,14 @@ F:	include/linux/kfifo.h
 F:	lib/kfifo.c
 F:	samples/kfifo/
 
+KFUZZTEST
+M:  Ethan Graham <ethan.w.s.graham@gmail.com>
+R:  Alexander Potapenko <glider@google.com>
+F:  include/linux/kfuzztest.h
+F:  lib/kfuzztest/
+F:  Documentation/dev-tools/kfuzztest.rst
+F:  tools/kfuzztest-bridge/
+
 KGDB / KDB /debug_core
 M:	Jason Wessel <jason.wessel@windriver.com>
 M:	Daniel Thompson <danielt@kernel.org>
-- 
2.51.0.470.ga7dc726c21-goog


