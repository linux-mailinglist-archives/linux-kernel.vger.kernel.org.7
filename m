Return-Path: <linux-kernel+bounces-772166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4D3B28F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 18:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD96AC7DF7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A4C1D5154;
	Sat, 16 Aug 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaOYU9EN"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7781418CC1D
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755361854; cv=none; b=JyFE64Ll2+Xu1Fh6uFyVv9VvZQc0m/X3w+BNQVUuyHP6ScOMchn+862KbcnhPcrNufrrfGuBXiRdKkYY0MMWoxoFi5Yf/dKCW1npka0QIvdF2pwvRUS8eujo7OwlVgs8ixaHW9nT8HMwqHop4Oj/1EQEcLSdABBR5kN5x2abb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755361854; c=relaxed/simple;
	bh=F0o0xnWPkozCFKWoWj71XGLa+u+3bjRmZCdOz8jbtZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uXXuOzyfgwQ9jVuYDvuhSws50DWjA3oHv2xfRBP67BLslauVopYvnxvSaUAMIf/lD9hd5v5WVavXWn/gksJoUPyL/VhROu6XscgCQuJIpbo6s2x22grNrwb+s81zfuAomC5GEkUmWaJgOfaC5Y3Dy2BVGiblhQEXIjyhG3kYF80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaOYU9EN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so2711371b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755361853; x=1755966653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lGscpHrKLYkJKBlkkWYFnLv4KZW6fc4RH4rOnrFs+fs=;
        b=DaOYU9ENy3qhW6W/IiKCbnYPSamUUsL5cH+hpjNQyN+6e1pcQ1fp1ee4pClnA82cRQ
         jOG2JcqZgnBM8deXx5sETuToZyem6Nwspox8Y0xeijUxtQk4j+ifgAqG9lU7BSkqD+B9
         sic/qeyy8oje0wj/QjYK3p0zE8tBJ+mxK+ADDNcPSo4PQ277OI0Vfd3DvgQYTgVuwiPK
         uf12Oz9b9blDhj1cALNnX0V9nSHSxwbplhJXgTluCaMrm84xANB0NSmjIH+JOvEBssX9
         BuF8CW2AW8lAJqf++0e4kzzuTGbWysBMPEW8QvgLQNMOi6fmxyNNBawat2zyuDypuh6p
         z3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755361853; x=1755966653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGscpHrKLYkJKBlkkWYFnLv4KZW6fc4RH4rOnrFs+fs=;
        b=aEcX0mE5XEmEwoLU3ABUR1lN9ZoD5GlTEnXmIhVxFQThF/uUAQB6n9SYC8FqWqyF4Y
         iCKlylazOIslckKnoYLmkIXiq1IO9Hx/bIx0aJlMnD9MekhnDiKFxz5PrhPpItuYrVRK
         UU840/9Dn56Aw9UxLFCPYXpVD8l5L3lJkx7ffBi94GTFHHDNS8pKpyzTZY5E+YQBE5aa
         FaJ1L5ey/CFvxVvzgHTy0F+K4r6nOhiS/kYJtTDSrGZtfqgyyPu6Az3MajgDUl4APrPh
         CA3BiWTm+B7hnF23iPqYJh0RYhcAZhmOCVOVlq8/brnfXHobN7pfqlIxWeO3fqMF8l5c
         ptnQ==
X-Gm-Message-State: AOJu0YxBlv+mPkbm34kq20lV1MZAsT/rwjksdY+Dr7emm5coKlKSVprK
	aHwn1zNt0q77JAnThw9MMNe4fr1NE04Axyr+f9wJwk+KhA7b22FYSwzWBre1I23U
X-Gm-Gg: ASbGnct+OwYF88AzUxJRM4FCfKnGjC5YEXS4w84Tds2KWu4Va2PzLiNrqQskn2r47Yx
	ZwyK2sD9tBpUvSwx0muFHPHdq9+x4WcnjJkUigAVOIrJ3Js5WMvjG5n1Zq2mNH19JWsHqeDgI3E
	b4MUwuIb7Pxn18pmykvszo8Nel4aZhkqoCdYOlbK4V6lf3dGHY8tbyXyXB8R9NbEJHYtVEApDjz
	nCUyMYGyyDeZEgIDDDtVMvnDlLU6Zo3+0evmb25954GmARCT6bgal+mH5y+vD6a3IZDAj+1kqE9
	b779RZTatJOW2tCs9VGPE7foNx6gy0gDhR7kmQC9HUYEYhv5nVi4z5kvTTdQjtc/P4B9rgU1ccx
	jXvWNs/+m+Dk+EYPtIM1moJC2J3RnNGT76l9Vd6K4
X-Google-Smtp-Source: AGHT+IGSAapA897DNdthl6u94XoLHXfcYBulHrIpjLCBAeZ1DUcYVGCBMsa0QYl0Pil1B+ITk7QjBg==
X-Received: by 2002:a05:6a00:cc7:b0:748:ffaf:9b53 with SMTP id d2e1a72fcca58-76e448182cbmr10108454b3a.16.1755361852552;
        Sat, 16 Aug 2025 09:30:52 -0700 (PDT)
Received: from clint-Latitude-7390.. ([110.226.179.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4558b021sm3426091b3a.96.2025.08.16.09.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 09:30:52 -0700 (PDT)
From: Clint George <clintbgeorge@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Clint George <clintbgeorge@gmail.com>
Subject: [PATCH] Fix spelling/grammar issues in ktap.rst file. Minor Changes
Date: Sat, 16 Aug 2025 22:00:37 +0530
Message-Id: <20250816163037.13675-1-clintbgeorge@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Clint George <clintbgeorge@gmail.com>
---
 Documentation/dev-tools/ktap.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index 414c105b1..fbfda5094 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -5,7 +5,7 @@ The Kernel Test Anything Protocol (KTAP), version 1
 ===================================================
 
 TAP, or the Test Anything Protocol is a format for specifying test results used
-by a number of projects. It's website and specification are found at this `link
+by a number of projects. Its website and specification are found at this `link
 <https://testanything.org/>`_. The Linux Kernel largely uses TAP output for test
 results. However, Kernel testing frameworks have special needs for test results
 which don't align with the original TAP specification. Thus, a "Kernel TAP"
@@ -13,7 +13,7 @@ which don't align with the original TAP specification. Thus, a "Kernel TAP"
 This specification describes the generally accepted format of KTAP as it is
 currently used in the kernel.
 
-KTAP test results describe a series of tests (which may be nested: i.e., test
+KTAP test results describe a series of tests (which may be nested: i.e., tests
 can have subtests), each of which can contain both diagnostic data -- e.g., log
 lines -- and a final result. The test structure and results are
 machine-readable, whereas the diagnostic data is unstructured and is there to
@@ -92,7 +92,7 @@ keyword preceding the diagnostic data. In the event that a parser encounters
 a directive it doesn't support, it should fall back to the "ok" / "not ok"
 result.
 
-Currently accepted directives are:
+The currently accepted directives are:
 
 - "SKIP", which indicates a test was skipped (note the result of the test case
   result line can be either "ok" or "not ok" if the SKIP directive is used)
@@ -235,7 +235,7 @@ Major differences between TAP and KTAP
 ==================================================   =========  ===============
 Feature                                              TAP        KTAP
 ==================================================   =========  ===============
-yaml and json in diagnosic message                   ok         not recommended
+yaml and json in diagnostic message                  ok         not recommended
 TODO directive                                       ok         not recognized
 allows an arbitrary number of tests to be nested     no         yes
 "Unknown lines" are in category of "Anything else"   yes        no
-- 
2.34.1


