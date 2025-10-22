Return-Path: <linux-kernel+bounces-864230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B754BFA39D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC4C33491EB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0277C199E9D;
	Wed, 22 Oct 2025 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8VB2w7y"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1CD26560D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114601; cv=none; b=nbcN6wObAT3x+d4VmKYk41sX83F+/k6eJZWqxPxrsT/DB0MgBKposbnS3ucDM3kLQp0LscPVvLghZH8/jgGipI8UBQKK3UsOD/DURI8coGtlocfT4mKNsuJqGCzkSYJ9hZYRSMSE6JjkOggDttHxWkeId4lFWkEziqNe5kEnwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114601; c=relaxed/simple;
	bh=pxi12w+zJvC4kZodhK0Ij6Jx0cFF+FxyL/tgy3imtgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9E8yRp9JnBmdDbWhbI/99LuDZotD7upZsBP2TnJHV7MttHSjewttufyjCLrfiMd/2By6v1rmbp8IqX4aa7wZpQJuEH9wRsJX6F28OaL1eGHQptVZYODNt1Ub31dYGUo7JMEYZjfQm6aB6vBTdKxItgV4Y75WXlGtstgVB5pF9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8VB2w7y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a26b04bfc8so154799b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761114599; x=1761719399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRyE8t6dhAXyClNR4lT1jQASjbYPHXa83JC4TjDmfbk=;
        b=I8VB2w7yGMF2YQnTnrTzrWkTWo4CX/RcKmOXqOU7pIEnRXK9CUIf/gX2wVxT1zjGoU
         RH9tntSabA0PgGpumchozKxYZGdre00hD3fRfDlP4J6TlEPZTvetyqsME3prVvMFc5y8
         on0CtY6qAQ1GPTfS6tuivN4+mwe1KTPrWzvWsYOMqMVA+163RRTkJJ7TNkDsOXvmClcm
         V+k9HqcFcrrar6zk3BsA/9qdACu5hwJUy4POgdU3Chj8bYl4XI48bD8Up7x6l35uUJth
         Zkj7W5ZtzjApyRPcYWBbTkv5nQg41OelmyhCcqwsy8TwwpV/XFpi0wdPTufDVvgta3o1
         OH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761114599; x=1761719399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRyE8t6dhAXyClNR4lT1jQASjbYPHXa83JC4TjDmfbk=;
        b=XdcbTX2TZbQhH3msR/zuvrYt/VTknlAv81kcpm+JIHzFTzqTxZtc+yjsbGGK+Tg6wX
         kFREAjKJReCgH44dpJ8PfIvbvEQgW/Cr44gHqhYVpz43p0CiLOh7kYFoVVJZjmMaxr3t
         ue/uPN6HJ7yo0uohhOi1cDfF0SSX/jnyMW5B4r+m1Mz5CKKPY3r/de6H0jBgVoOb4UB7
         BwkB+WbeeQhv62y1xTsusf0qMpiW+FFrVmVvgKy5JDLjNK+oQrAc4wUab6lwk31BNaRJ
         3hrgycPJIc7mgJEQPi4xE6iHQeQ73eKpErV0dVidD+y1Kxxo+UXzx4Z6G3T5qJcSKvnM
         1PEA==
X-Forwarded-Encrypted: i=1; AJvYcCVtJwl0QvgnG4VyYHrHdvNtIB5kgK/VTV0hTsXl/Ci72GFSGLL/xYIQqTR1Tw0bDuyIGQyf51sWH779Ux4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrysitUK5OV+4rZVsurUP8glzsU0h89PvNqnavsfTmq8XzlRoh
	beZX1yoG8xg4f64x05ViKGtsMBYzZKuZ2tHNi6457haPY1csaB3toPuK
X-Gm-Gg: ASbGncspkJsd41kb/DqwlOoy8kABH0gChzXiDbSGRc40BGe+GNRdvgk6XeUIJVEFfRP
	GJfXe+Do5cN1wsZ/2O2S1DradVbvyLrg0Ag/heGBra/761L0llup/3Uo91VZpwQBfH/Z8y8shS1
	7oCAvzimlDimZMzfS9g1vn0Xj3+KTStELARC2qgCUx6oSZcvXJwEfQvgJ+7LiMEPkcsZgLimHx0
	Ccfvmdi6iWvDOb9vQFc3Kzbkz8uDk99QIO4CSJZ8QTlYGdM1gO1Ukp4NZPNCdsEhCgzHBiZzuzW
	HF1kji8XyJFYCILkirWs+vwBZWiw/ovmGQiaL/d7eiZSiu+q28anokisRs6wBz9p5/SJJ3oFFcY
	BnlVrrt7I9c0Rpm/Jc9te+LGnXphsIUaWYXcYedLvu1569IDkt+CQSVJToEqjivtFfoptuVBbUz
	GSO9q9fyNHwaaI4RtXsY9SOrXj0+HmEVA=
X-Google-Smtp-Source: AGHT+IHCdWM1S/FVwbPmHY3O4OmTAtweU3JQt3Ila1Kmd/ZSXIEyZnlKVzKCFjwGH+txrzbmUlsmmA==
X-Received: by 2002:a05:6a00:84a:b0:78c:985b:8d3b with SMTP id d2e1a72fcca58-7a220b29d75mr20156837b3a.23.1761114599073;
        Tue, 21 Oct 2025 23:29:59 -0700 (PDT)
Received: from server.. ([103.251.57.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23011ec97sm13408435b3a.67.2025.10.21.23.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:29:58 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: naresh.kamboju@linaro.org,
	broonie@kernel.org
Cc: anders.roxell@linaro.org,
	arnd@arndb.de,
	benjamin.copeland@linaro.org,
	bp@alien8.de,
	dan.carpenter@linaro.org,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lkft-triage@lists.linaro.org,
	mingo@redhat.com,
	reddybalavignesh9979@gmail.com,
	regressions@lists.linux.dev,
	richard.weiyang@gmail.com,
	shuah@kernel.org,
	surenb@google.com,
	tglx@linutronix.de,
	x86@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH] selftests/x86: Add selftests include path for kselftest.h after centralization
Date: Wed, 22 Oct 2025 11:59:48 +0530
Message-ID: <20251022062948.162852-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com>
References: <CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous change centralizing kselftest.h include path in lib.mk
caused x86 selftests to fail, as x86 Makefile overwrites CFLAGS using
":=", dropping the include path added in lib.mk. Therefore, helpers.h
could not find kselftest.h during compilation.

Fix this by adding the tools/testing/sefltest to CFLAGS in x86 Makefile.

Fixes: 4d89827dfb27 ("selftests: complete kselftest include centralization")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/lkml/CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com/T/#m83fd330231287fc9d6c921155bee16c591db7360

Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
---
 tools/testing/selftests/x86/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 83148875a12c..434065215d12 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -36,6 +36,7 @@ BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
 CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
+CFLAGS += -I $(top_srcdir)/tools/testing/selftests/
 
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
-- 
2.43.0


