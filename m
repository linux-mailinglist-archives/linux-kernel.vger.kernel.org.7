Return-Path: <linux-kernel+bounces-761897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC0CB1FFBB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE8F17AC3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA182D94A3;
	Mon, 11 Aug 2025 07:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8ZpoHVe"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065452D8DC8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895601; cv=none; b=NBuUZXws6tTi8RIdMe/kKx0NRKwlf5nFTcHEmE7/pHpq+/5bH0zUjv6gDzQAfJfYcfvemWeGUIAfk+srq/llo5L2Sg5MyeJxmownfSSDH8nNtQj46oRQuCqPQ9ADbZXs3ko5CqdnPTv56AeekzmFV4OO6okJrbyfmRSIkObtfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895601; c=relaxed/simple;
	bh=3yZG1w4E8aqqoqQW5zLOvh3uvnyaBxVEiamqN5NZMSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9OI+a54JOCtq+RelY7NRSaVa1X5Z1XHOtyxKLZGb7wNsNtYDASnTVtO1M2KrOwCvoddGjiLsT/jQ8lT+hjvloGYhWmn9GkUoBMyvJ0nU0fyj7ccj+gWshjytcX82DRcuRJ/PNw3f8cnYDhuGU5dhXop4gHd1n6tOuA//FsUDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c8ZpoHVe; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6157ed5dc51so6169609a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895598; x=1755500398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSWS63dgKn7kFeQEdpGLXWVaoXQGy0K+bkkJl1msO+c=;
        b=c8ZpoHVe6+yDJLWGzQcJ0DcVril5cFSaGzxOOqRtxVyzGgBlKi1b8H3sJMCJbKCs7A
         yVtGrc9ZuSns0CB6tjemLv0PUoy74g5RAR5gLgEKvK5yZjv5QpbL1X5MzHjnfDV482ez
         0K3L+RlZRsTb4gZxbSInOf5CsCND3vSZg1flTdlOp6j2djw42ZBfLkHi7O0ufIQnT085
         XIj+1aADYKySmCMI7rN0vc7CZOYdVVy3e2McTSCPvpIB98V4zC8wNoGeaCtvJsJAnVWq
         seC5nHaMkvrcbEXjoOgndTSOOUN2gS6mEAVRu6tdDGWhFmzxwV12K+b6G+xeHAR18W8l
         SgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895598; x=1755500398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSWS63dgKn7kFeQEdpGLXWVaoXQGy0K+bkkJl1msO+c=;
        b=gnAYnyfdWWVnHK1+LiZGk3RcUl1X+YA+XKW6IMfwkaYK0otszQGO3NI2lSoM8TsoP6
         1q9qj+SS+9dufcOeesyxboxdxtJzXoBb9pz2kfqwAUAiJMBFXoREM9kQ9gwWEu7B8rdM
         gsu9ZFym47bNcXEd6beBOBn1GLhFTIf0hTwIACErelVlLEQz/YLyLuNDAGOzA9eRJ0fz
         EZyy7kgtIDUu4WnL2yA/WQHac9NdqYlS3Mnf98qv9BUD3QArsMxHW28JwpuO4pZkPHIX
         sO828ACNUw5YX1UTlMK7XRFJeno3t6GX5oQCRDmBu10stDAg5cRsWrV8q3r1IDdpcRMI
         YzQQ==
X-Gm-Message-State: AOJu0YzYxtqfk6V4yuaIiaBIEEvOcBz5nx3gbgqhCQwtGlKCAxE6x1V/
	pUPZjYHuvDyTqa7CBrRVh3VnW36doYRkZWqM7Kyn9UO9cCv2ywVcL0H+rG+bSf55LJ4=
X-Gm-Gg: ASbGnctE2kdm8ARz6Fcf004xE5i+AfVAxjVcCfAbH3Y0RWKylwzeoBXS90ePb/P2MHx
	pQRDJGsLxBfpuSASJ/EOMtO0Xp3BfCbMoJSx6bYOfj0EcaTpFITpsPzg6w9d/lJFl4g8Zy8pRKm
	5j4+ypIrA6JyhA16vSadvVXjqgqbAzObEwlTWr0JmVbGE1IetyGvFYhHYRWnV4rs6+wFK/8FsCk
	sFUskWmmQnYrUTXDWXFjXIcRfAuZhIEukuLXge5vjV61EqIerb1lYjhnOspWvtUAQJarOdWKYkJ
	WDmD9P0d/NIymFlG40qUpYLBIwMEdtPxxnRn66lmg1H+x+Mn9ts0pZlPo2Ka+/X5YNWWE8GtNs2
	pbaLqzhnx9rZxdWw/pmpP1rjrmzfYfjk=
X-Google-Smtp-Source: AGHT+IFA5uwA/OJXYyO9fAVmjzSH1NeaCu1TKHlEdpmXOJBGeW8JH3l9EsOujXZG+RsuHLVxaosWXA==
X-Received: by 2002:a17:906:eecd:b0:ae6:f564:18b5 with SMTP id a640c23a62f3a-af9c64525famr1132639966b.19.1754895598260;
        Sun, 10 Aug 2025 23:59:58 -0700 (PDT)
Received: from eugen-station.. ([82.79.215.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm971793266b.6.2025.08.10.23.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:59:57 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 2/6] tools/lib/thermal: Fix dependency to host libnl
Date: Mon, 11 Aug 2025 09:59:11 +0300
Message-ID: <20250811065915.3333142-3-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811065915.3333142-1-eugen.hristev@linaro.org>
References: <20250811065915.3333142-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The include path should be created according to host pkg-config
especially when building with a different sysroot or cross compiling.
Thus, call the pkg-config to obtain the correct path instead of
accessing directly from root host file system, which is incorrect.

Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 tools/lib/thermal/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
index a1f5e388644d..ea56b55c9fcb 100644
--- a/tools/lib/thermal/Makefile
+++ b/tools/lib/thermal/Makefile
@@ -47,7 +47,6 @@ else
 endif
 
 INCLUDES = \
--I/usr/include/libnl3 \
 -I$(srctree)/tools/lib/thermal/include \
 -I$(srctree)/tools/lib/ \
 -I$(srctree)/tools/include \
@@ -55,6 +54,12 @@ INCLUDES = \
 -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi \
 -I$(srctree)/tools/include/uapi
 
+VAR_INCLUDES = $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0 2>/dev/null)
+ifeq ($(VAR_INCLUDES),)
+VAR_INCLUDES = -I/usr/include/libnl3
+endif
+override CFLAGS += $(VAR_INCLUDES)
+
 # Append required CFLAGS
 override CFLAGS += $(EXTRA_WARNINGS)
 override CFLAGS += -Werror -Wall
-- 
2.43.0


