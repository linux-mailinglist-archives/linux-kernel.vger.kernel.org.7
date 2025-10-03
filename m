Return-Path: <linux-kernel+bounces-841833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6282FBB8585
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 00:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCF14C32B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 22:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB412749CB;
	Fri,  3 Oct 2025 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KILTLBCG"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031B519007D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759531764; cv=none; b=l+ulkjFEepD7I0LS4s26AhE8QyLHDHpdjYOCOtw6fLnFc9+hfawlfIu61tYzW+gR9ScJJQFOrqm5faEFosSEMFRrXBgCaigKG6PUlSlcp/oPk/7cRxiDx3wgNHR3IjmYqazH442PzsIAV5fTAfv79/TRYo/NTHpoqoFr/dXM5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759531764; c=relaxed/simple;
	bh=wYijfx82w/i+5cLwyYwuMtQXPPURM8z5k55rzxEZFLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPkEtRUvdCpwS3cxCvlcP8kiVzrU2nQfDWMNB+g6G7nBtt/9mkf1qMmlbp1KjBbPhHeCitpdVehX6UxFXGj4Wgqpc4bGKl56e4AnAfQX4sBE5kIAZEDgY91cz5PsEFqktWS5d6hdwR9HuEzisl2knAiRrAn9QZ4wTAUhTmsA5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KILTLBCG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78af9ebe337so2004001b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 15:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759531762; x=1760136562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oeG9oeMq3V/BRy9XfGgniPTDeM9j7ii3LAYxjxadWNg=;
        b=KILTLBCGpRhBw26jlPh/lSqb6nGUq6ve+Jb/VSfqKFXI8yP0TBWs+vceqrxCEAaQke
         vRGyy7WdHqSm5u11/A3ME2TQyesHXDC+KSWXDVwllLeKWnUcWVAYTphp8IgaWUF+JF30
         mjbTMtIbVqwgtSqrXOR6HSyVluqfy8Zz7UHK4iCu5nJvcflmhBRCcRVUiceGKHvplM3o
         5L2F/fvy1IwaCGWlmJ6GG2VunrrMEVUrwemwxwwf7LNbuCzFWsN5Pb5eDwJMELLGxjBa
         8iNK8eS+RP1SsRJ2ABGrnrfuUMWbL8RvxciJebiY7LGCiqFqjkckdjsKjWQUkuzUwA92
         E8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759531762; x=1760136562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeG9oeMq3V/BRy9XfGgniPTDeM9j7ii3LAYxjxadWNg=;
        b=pSKQ43IisqR+oCBFnDC81Oa7Tt89o+5mpLyTQXUpiKchJHjwOcRVVpKwDAHehsPCHh
         4S5Hr8+94qJzFn+SLWINJErySOHrXi2XPnzT9B0HNI+QjSLACILkwPtVQ+QjaEn6o/Fq
         YdOwf1tLLwz7o2RcQXElrUbyUywLzWYeh5znKsjxxYJbCn/I/S9jcxM5bmfxm2259O39
         +QRk1DFA61g+tQjsZK4WThpLel3NZdTLNKmtqXiELnJ4xbHPtfjKw2sdQpUzinlfJcsi
         1+YvDu8G/xU03webFWbZRa6FyeZlpWviWMQN5AKxIvj6ZXiH1e+7XCWQqQeXQKvVu2O8
         jW6Q==
X-Gm-Message-State: AOJu0Yze15mEseET+So5CAUJtlbWQ9l3ifq7YHbW3d57WTjxQEmOUpFt
	oApQLXpa6KlXqvjE8+1pHWLtRmGOmn8IYIlawj/91Njx/uwEfey+zPq2/Y3jaB+R
X-Gm-Gg: ASbGncvBhP2O7JAR0jRNYyZwGZH/4Zgc8jpg762l/FfyhJz4CvhFjih4Xy8DEz+JLXG
	z9mySQb5g4VdGI5rbMPvlUvtzaxDOoCBoCr4A5RRbijEjVjw2LEo/CRk+y9PY6s2VGkytRvUGGe
	X79Ggrz/FBUddm5oB2WfjkYPOf/+iSb8YbXFa/1IPewpEv9S0SFUIPUneqDTJQifLFtC4XBAigc
	5iEMMQkDsC5UlhWb8Hcq0ey04xYSSZZwXlGnESz6xowwUbRifDd4g41F/UNP+koetNI4YxFixkl
	C/zPFNiD1CpN4MkeO/Wdwtq42Xn/yJgGXyyJZpw0zpokogeJPm5qLdunPQIwbfRkOr6DEkHM60J
	ulZ9CtpBzHcpxwRBnpft+Oftk/G+nibsGuRsbJnclQQPJOWxcglAgGB6ZhoX0qOiQN3pjBTnDi3
	dj4C+c2VhqV7A5/Vygtr8X6giQiwe31kH4mY5ZAw==
X-Google-Smtp-Source: AGHT+IEY5vwkWiLQpFdBP/OKiL2TG1owypYb10cyIeolmsHdvVP9kUkUY22iwpY5kr68lwo8OufYEw==
X-Received: by 2002:a05:6a20:7f8b:b0:2e3:a914:aacd with SMTP id adf61e73a8af0-32b61deea03mr6012279637.2.1759531762075;
        Fri, 03 Oct 2025 15:49:22 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e7c:8:5098:8942:78be:db30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0204edf0sm5959882b3a.44.2025.10.03.15.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 15:49:21 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: set default valid_thresh_ratio to 80 for zoned devices
Date: Fri,  3 Oct 2025 15:49:17 -0700
Message-ID: <20251003224917.1950708-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Zoned storage devices provide marginal over-capacity space, typically
around 10%, for filesystem level storage control.

By utilizing this extra capacity, we can safely reduce the default
'valid_thresh_ratio' to 80. This action helps to significantly prevent
excessive garbage collection (GC) and the resulting power consumption,
as the filesystem becomes less aggressive about cleaning segments
that still hold a high percentage of valid data.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/gc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 24e8b1c27acc..6c4d4567571e 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -25,7 +25,7 @@
 #define DEF_GC_THREAD_CANDIDATE_RATIO		20	/* select 20% oldest sections as candidates */
 #define DEF_GC_THREAD_MAX_CANDIDATE_COUNT	10	/* select at most 10 sections as candidates */
 #define DEF_GC_THREAD_AGE_WEIGHT		60	/* age weight */
-#define DEF_GC_THREAD_VALID_THRESH_RATIO	95	/* do not GC over 95% valid block ratio for one time GC */
+#define DEF_GC_THREAD_VALID_THRESH_RATIO	80	/* do not GC over 80% valid block ratio for one time GC */
 #define DEFAULT_ACCURACY_CLASS			10000	/* accuracy class */
 
 #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
-- 
2.51.0.618.g983fd99d29-goog


