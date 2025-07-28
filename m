Return-Path: <linux-kernel+bounces-748562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79774B142B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA2C54230A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E805C277029;
	Mon, 28 Jul 2025 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETlIpl5T"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A4273D95
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753733523; cv=none; b=mqpD3UDhrH4IViM1iI303aldVnnhBWLR/HOi+VtAh3bQGkV3zC2+BfRVCgVhuDbtIvEOPojN21nE9OzLg93kp9mIFzdQuvC6GfPP9tW6YoRyyZkrymyOI8wsecOZras2d2ii7IHHfcl5N8UrdmL+b4x5HbxX51rGXqJKLaa0J3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753733523; c=relaxed/simple;
	bh=Lw44dNghmCiq28TogKJdMlT60+fsL5APY9+7UOE+tB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LtLJ++3hHBqgfDUsaXRjZfkTVxzxgqx1NoaT49XG7LdU6K7qCqIugcd6ZKyrEH9Cv8B6SLW0PsSFS3tQ7Xb5noNR/R6QeWBTB6HGBy6qu3IyFbi5WbzfRsEQOOSjtUpfQqnjinHmlWPBTQ8vl32bZsCzg55IF36LC8zkfsrFFc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ETlIpl5T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-455b63bfa52so12315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753733520; x=1754338320; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s0cHzSvxGHBD6anMEro7maJOsM/+ZwrFtNd3kS/G7GU=;
        b=ETlIpl5TZAzx6n4DJhvzYNUJikYxLU9RnsdFK8IAJBKDsURea6tYVWso0aNgXlT4yh
         +WG0Rkz2WHnSO0Y654eCuBcwCN9wvdnxsBckGx/NN3wBRb/O8tXFw3D8ldTq6ovIVF8S
         MxSsAxDWQZ8+Zv/8hqYxPaZOblfDyW/ZSqAWTEVBp+U7+02MkujOgM2/4RiZAHN7bkQI
         sK4nzjAwQl+64ak4xZ+woRKdjm8OyGwpg1TlURYn2Zakgz5/9+AyMLmXCYrZ4nNEOzOi
         094+1fj70mRwaycO54k86WOY0QlwApzbLzEixIFbObCMH3nRa7UxCuUyT1H4qZSEEa5P
         E2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753733520; x=1754338320;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0cHzSvxGHBD6anMEro7maJOsM/+ZwrFtNd3kS/G7GU=;
        b=NWDpF0AW9cKrcg0/R6DY6dTUSIuvF+WKnoRLAgAceXZ7Rh5rbp9V7vLUMzg5c64IO2
         x9ILD0pheu4pr4j8J4P4q50YAYkQesh6CqrXkZktXhe3NFxJJDOAurF76S3/sUYb8WxD
         DCw9Sof1N3CPtxradXldfTmsTSoa1Z6U1gqMoZm8B8POWkKbDXEf6HH2xkxGVsXlcQ/h
         Ldiy1EGK4JKExc1v474nxV7MN8l2i3/BCfcEJdRZtfsssvFNCJ85EwWWY8etS0Uwq1SF
         oEWq3iIow2gsg2iqk9a1g1Joal7YzwnoRzNZSAiwdneNw4XU0W/1abTqanrDhnll1oM/
         8VLg==
X-Forwarded-Encrypted: i=1; AJvYcCXMWiJqHWhk+EYwUin17tAahrtL6/K+PBSNqD4CP6FBcYne13MRleya0NYjdUkNS5tL9ZPJqkfhMAsBGwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIkAeDycxFd0JKEJVDFtURELvvkBpH0UJY++bvo71C8L64M+p
	3egWDcPhLeMga/NqosuXiW/bSviTQNWEv4BXCqZJVDO4IsD0Be3L/qjrcUU0p7X25Q==
X-Gm-Gg: ASbGnctaUSK/OZ6s9UmxiPhr/7A7TsiKbNGYvYJKrjd0smJJfler8sJdAPgpIP5P4K1
	dzFzn9UIBYTWSf5dzMWZKPSZf9XVKkx/n0N4dEOknSxrUTaBTciFI4eePp/T7uCwRmPFqlTYzts
	woCEzfym94IrvyLIkgkrkSG5tobyJL7pG+tJmNgFzAfUSoJxC7WEPMLQI2qA4EVDAEalyh/Tv2N
	XWXOGRE8uWxXu5QWFmlBjUBKI2oyqXuSZCAFRUWoxGfo1JDKSTHdLM2xNTljdGleD7LxSsmyiLc
	AjrUZLqW//JfRjo+nQSR4KoCg8CWbYuGCuUUcXhWKAxljElg6OURPSPwaST3eMXAnxM/hZJKUqP
	y0/gdMv5qsA==
X-Google-Smtp-Source: AGHT+IHayh209RgU2OQ2Ql6nCDUMXhu0axdv21GxFZW8eJ+BL/8tzZhBPIchhicCa1tjRfY4ljX+Ww==
X-Received: by 2002:a05:600c:1c8f:b0:456:e94:466c with SMTP id 5b1f17b1804b1-4588d6faea0mr193425e9.3.1753733519713;
        Mon, 28 Jul 2025 13:11:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:ec3e:2435:f96c:43d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458705c4fcfsm167139575e9.29.2025.07.28.13.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:11:59 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 28 Jul 2025 22:11:54 +0200
Subject: [PATCH] kasan/test: fix protection against compiler elision
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-kasan-kunit-fix-volatile-v1-1-e7157c9af82d@google.com>
X-B4-Tracking: v=1; b=H4sIAInZh2gC/x2MSQqAMAwAvyI5G6gF16+Ih9SmGpQqrYog/t3ic
 RhmHogchCN02QOBL4my+QRFnsE4k58YxSYGrXSpat3gQpE8LqeXA53ceG0rHbIyWm1aVxlDdqw
 h5Xvg5P91P7zvBw59gk5qAAAA
X-Change-ID: 20250728-kasan-kunit-fix-volatile-d2b9f6bbadc7
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Nihar Chaithanya <niharchaithanya@gmail.com>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753733515; l=1506;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Lw44dNghmCiq28TogKJdMlT60+fsL5APY9+7UOE+tB8=;
 b=C6lZbcU2X+AJW0vETjhTQhf3UGiePUoutVdYlhO5KePE7UNaPnUOl8JEhfpjN20q0CI8rf9es
 golCyt2pFHDBgyH8gSS+VI4ja5yi+aO2ecmGVWz3fDq3wNJKKFrjOeH
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The kunit test is using assignments to
"static volatile void *kasan_ptr_result" to prevent elision of memory
loads, but that's not working:
In this variable definition, the "volatile" applies to the "void", not to
the pointer.
To make "volatile" apply to the pointer as intended, it must follow
after the "*".

This makes the kasan_memchr test pass again on my system.
The kasan_strings test is still failing because all the definitions of
load_unaligned_zeropad() are lacking explicit instrumentation hooks and
ASAN does not instrument asm() memory operands.

Fixes: 5f1c8108e7ad ("mm:kasan: fix sparse warnings: Should it be static?")
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/kasan/kasan_test_c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 5f922dd38ffa..c9cdafdde132 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -47,7 +47,7 @@ static struct {
  * Some tests use these global variables to store return values from function
  * calls that could otherwise be eliminated by the compiler as dead code.
  */
-static volatile void *kasan_ptr_result;
+static void *volatile kasan_ptr_result;
 static volatile int kasan_int_result;
 
 /* Probe for console output: obtains test_status lines of interest. */

---
base-commit: 01a412d06bc5786eb4e44a6c8f0f4659bd4c9864
change-id: 20250728-kasan-kunit-fix-volatile-d2b9f6bbadc7

-- 
Jann Horn <jannh@google.com>


