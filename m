Return-Path: <linux-kernel+bounces-822883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01B7B84E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207EA1C83C11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F5E30C35A;
	Thu, 18 Sep 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHvcz8Vl"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE130C0F0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202976; cv=none; b=BmWJaw2o0+0jFX1AF/P4DL8Op4Z70l1GRqUPRGuaKYEOHOODj+zL3r/CrrPiLN0oTy+Y8/I8SihQ5+7zh9mcOtU3JLOzdOPGnHff2Fz8qAcq6LYRo4dQJXas01HKSTv3oedKJ9+nyKCQ226NfpCKHkwpBpeFNKCvm1LG5dhE2Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202976; c=relaxed/simple;
	bh=2MgVDXUXrMQOxS8uFJ/lr1j1/8Te8IEER8Afs8qhU1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifmWlEV7UNzrCcqdlFc9RZiQB6chzfN/H4uxR7loI+yOnXkJoPhpjdun4VptT004JKnW2ushOJc/C0P2OQ5ExyGYDMcEEF07OnWvLpkQc8VOetybAHB6V6KaM13MpfhUis7KyweoINmRmwUZsEhgPLOIUVB2YR5qdf4JOkdP1Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHvcz8Vl; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-77b2e3169dcso1312013b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758202974; x=1758807774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g28dATvvwBsU5DpAxYcRX0sUypYEWCKkK8P/4hZfSb8=;
        b=GHvcz8VlRxa8j5yi2kVA+mmmdQcG3/vGSHcyf3pg+wCPqm/s7NBou/X4hLZJLaXeEw
         ZWVtnT6nPLbYKs37DJsajI/2CbNb7J9Y9ZdbJ9jC/ZF2enbqon/SFx7UQJJsc1ddeSRa
         dwUp/ycaQElUP1rmOv00jdCqmwx5ftiCx3waZ8avuolTxmChw+KcIGMLp02V5vA4CKWr
         wnEEga5rL0V+P1NHPMJIQWSNFHWrL78qSyMX/cy+SGgAdPLZ2e5HZpX08xL3/56+Bhbg
         SaKZUvJVSEY3fR/Y+1hPfrzIJu+ws4GkyMLc8KteJ9VsPROwaqnIXMDDHYVZ5XUxIsrr
         lOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202974; x=1758807774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g28dATvvwBsU5DpAxYcRX0sUypYEWCKkK8P/4hZfSb8=;
        b=ZO42ni/KlwHhZRoeXR95SgyjvuD2o7DE+FNgBAWvUiUrdixPPRsnSJuORxx7CcYCNC
         eXlsIQWPXeEcuqi8dZ9q9LoN6IK8cpEkexOaWIrgFEfLrdH+grQuNwLQT1nY8Bzi0YnY
         PwHUDWzgj8jy1162NlHDISxbVCKgW6m6TSZ8I0bj50xOlzFB3E8HLY0uTZqZuCGF4ayG
         Fd9kxUnrDdfkfFF0MbXyqiG9NeeiQ7YPHgl2zS6WFAIgRf8O5+qmBWfUJsd3kbG3svAF
         PK2gT8cZvkUsJ1/3gTH8bZCDgEOfYnYJAa27qMRTbozDSthn33PE8llcyBQ1L9bkt2Nv
         pjww==
X-Forwarded-Encrypted: i=1; AJvYcCUzMMgwupFUpnxNtA4a+z4LCGB1iWlqTcJ00Yfc9OQ7KdFLon45y2Lw1cs8m3h6wVuo/1awB9gJa1M50S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZuIE6tJj/RmGb4hikVbilVuTwiLLxunyeRtRqCTxycNRRxdP8
	yWSIZIkMOsdVMgwv1qRi+nCiFsZzZFy8+zNfJnZOzadWc0EYtBMbfWsP
X-Gm-Gg: ASbGncuKBh81Tqe1jrpK6sj4TdzypZhl0pQgY4VwfjlKI7pgmj9CyC7Apy7DGWsNUda
	2DcAq9/+IfM2W7N6iFTASLAVzZ23fGN4Nc+Cjm73bhbYZzzv5fPELKEksk5Gjxvyy4eudAQPp/7
	DLrkprQGwVJratX80zrI03aVBS1Dx+3HdC42aroS/hXSFVTc9IHTfsSmlSGWKWevgGrzHKZvKiC
	ezlqbWyxBUhTVqp+MThWP+5QKyk0NKRrG4OgHD/u8OXw5BT8FiHOl4EdJcKdD/yX4QnmXtWjH62
	MWG9K0dd5JqVBB5eWsIS9b8rsXG/N+jPdgh8a1ZriAx7OKVTZDxQPF7tTRZ40iC0Rwy2pOW2sLx
	Q1t8p1kHzDMcQbWoo696QgVuIo5rUw+/JX5P/hNY=
X-Google-Smtp-Source: AGHT+IG+K+SBYfmyaDw9NhUaUQThAkMZ2bJ/cIM8wSPPbSySJZeVbr2Dzw1PcOt5mG7qpxrE8leYZQ==
X-Received: by 2002:a05:6a20:430d:b0:251:e4b4:7a44 with SMTP id adf61e73a8af0-27aa4f175ddmr8972812637.41.1758202974036;
        Thu, 18 Sep 2025 06:42:54 -0700 (PDT)
Received: from lgs.. ([223.99.13.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55100df86bsm842635a12.23.2025.09.18.06.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:42:53 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] kunit: test: Assert parsed_filters allocation in parse_filter_attr_test()
Date: Thu, 18 Sep 2025 21:42:30 +0800
Message-ID: <20250918134230.3569114-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kunit_kcalloc() may fail. parse_filter_attr_test() uses the returned
pointer without checking it, and then writes to parsed_filters[j],
which can lead to a NULL pointer dereference under low-memory
conditions.

Use KUNIT_ASSERT_NOT_ERR_OR_NULL() to abort the test on allocation
failure, per KUnit guidance for unsafe-to-continue cases.

Fixes: 1c9fd080dffe ("kunit: fix uninitialized variables bug in attributes filtering")
Fixes: 76066f93f1df ("kunit: add tests for filtering attributes")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 lib/kunit/executor_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index f0090c2729cd..084636ad8a72 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -127,6 +127,10 @@ static void parse_filter_attr_test(struct kunit *test)
 
 	parsed_filters = kunit_kcalloc(test, filter_count, sizeof(*parsed_filters),
 			GFP_KERNEL);
+
+	/* Abort test if allocation failed. */
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parsed_filters);
+
 	for (j = 0; j < filter_count; j++) {
 		parsed_filters[j] = kunit_next_attr_filter(&filter, &err);
 		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter from '%s'", filters);
-- 
2.43.0


