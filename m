Return-Path: <linux-kernel+bounces-761901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B16B1FFC3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49C3189BFB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8AE1F03DE;
	Mon, 11 Aug 2025 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwKMp+JE"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4202D8DC5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895614; cv=none; b=hJtT2msn6Ucpvw/mQaHEzPrgHAxwDqEDngvcRmnaIJ7x3bXmJBMuBPVKhdTttVuU7jsRcNmlUTRbliXD2+99jIDYTsRU6qeKaK5KoYKhvvSqyGKTp5OxGFFXMsxJsD0P5+gecV2xdDkcAq7FKz9YPBe1hiBcKncUY1avElCRzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895614; c=relaxed/simple;
	bh=5OKV3YFVx9AV+VrVYyDRsVXxPu+Il1+rJhjHmNszp7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEos/eOWYTGIi0CCl+HdHEUl+WMIIGux61nTL7RWM6jBFLGfy1gs/wzCq1eoVHUukgxd4cxyJXzEaV2/KPZC2Ea4M4WqKnriuJiVUbVDc0I1TPWZgorzW8YOORyUvyHr7wlWrLUOzftanx/k+070ag6xSo+WycqSxzK1DDfqfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QwKMp+JE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af98841b4abso665658666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895602; x=1755500402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6cSDcWJHXC805rmzke8t+NltGzFkInjNHEHN1KN3O4=;
        b=QwKMp+JEC/rzLrqw7jqG2U0M2vWR/9rlbJ4JPpfMO0OHcbhB0YtqpPuPJjcTDSpuIQ
         v0SD3llARKuP6NCkF4yRV+qQbkMUYgdw/9AAEPBC2DMKqdD6Pms9Eq132AVL9MvUIYCO
         XYRv1E8HtD75Q5qz3w1UKk0qCh1VPaENSHfz2KrpaGaSnAxtnpZQEk/HHsw7pStvJLat
         /WcLTWvilb1VOrGNrXUsYFzrot1e3Dx5khXoQnD6H/Nq6uRExczhVJFcnj8y9WpKiMPf
         uyIxhDC9wfLhDjlcbV5KDhmQd2Qi3vaGIgeusqf/m1GYzc+Ve+Cjy/Ao1rQAvRMohJcO
         xlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895602; x=1755500402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6cSDcWJHXC805rmzke8t+NltGzFkInjNHEHN1KN3O4=;
        b=ezetnbaLAIOhTlvOwGTF+v9w4gR7wR3t6ildkrD/hgjoOLnpoyqfTSwzgLVWxXSYZX
         ScriXJ5xLG/sA44C5q/f2WpDbVJ5zBooi7qtROAH4tfc1l5jFH0CuTpXCJlaiDKPrYoG
         Ju9b5BVr86vAzpXZ0sZCuSGpx/gXaHS2DFy01Th/5LcsnunfZnZskC+eQ+PrpHvu8q4T
         kxfjBDWHldKJe1Yen3JxHpWbOKyNyAEpciz71Yd/WHAOi3WwvIv/0A0FGJPJk2uzdHAC
         09G06HcLxCKBW3ER/0U1E7IPD6E4iucFQVCuL1iTYgctmv0r/QkwseJEoL4K0bOvqr+Y
         K+qw==
X-Gm-Message-State: AOJu0Yy1Ff4o0b69ERgRG8YQ489EheJGeKlE+J2HS+DkzeXc1dWrksJW
	AeLV+rZMAL6BnFJRY/+jpwxhtEFhS6lU2ND4RYc/sndGQIxlnt5oYqQERTh063WHwx8=
X-Gm-Gg: ASbGncuuniPKUqj0EcH8jF270wksze0dbszNVnZkHBr9o8Xh/gnhB6qPq1PLc3BJKPn
	z0M9W40yr1EmSc0W3bKvHkvNvgUIf41JNKYudmsu1/SoPwAVD1rNg0gEj1/Tbv3RiZ1Wse81im+
	JfiGniNaZva9Ra2r+gzW2E8PQVUvvOXlbuJa7RLV/AERcqv9MUi8btewiCQRrhsl0Oj0Y5rV12K
	c1/QEu8T2ZffzwynBbxkzuOB3VPF+19VbUbCLqPXrJUE/vadnz1vdUfgT48zo9Dc2HvNNZvcSYn
	sGHY2HX4/ilHYfBBeSQiJl1XfElETmohnh7tiKAMXxaUiyY0zafvy4ycUU68zLsb5K1V4E7uJ2u
	N20q+t3+A54LWlcijS2oNj09RD4GABPuBEPEx+bcalA==
X-Google-Smtp-Source: AGHT+IFRZfmnNAudk0i8fMFKOOnhnp75F3E/Nb1oPrto+I24ExyKtbRZtnEWr0MjZ5tCu9kYF/fTWw==
X-Received: by 2002:a17:907:d23:b0:ae3:635c:53c1 with SMTP id a640c23a62f3a-af9c6518c68mr1144071966b.54.1754895602457;
        Mon, 11 Aug 2025 00:00:02 -0700 (PDT)
Received: from eugen-station.. ([82.79.215.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm971793266b.6.2025.08.11.00.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:00:01 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 6/6] tools/thermal/thermal-engine: Add cross compile support
Date: Mon, 11 Aug 2025 09:59:15 +0300
Message-ID: <20250811065915.3333142-7-eugen.hristev@linaro.org>
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

Adapt the Makefile for cross compilation.
Took tmon as reference, and adapted the Makefile for thermal-engine.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 tools/thermal/thermal-engine/Makefile | 60 ++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/tools/thermal/thermal-engine/Makefile b/tools/thermal/thermal-engine/Makefile
index 6bd05ff89485..539c643804fb 100644
--- a/tools/thermal/thermal-engine/Makefile
+++ b/tools/thermal/thermal-engine/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-# Makefile for thermal tools
+# Makefile for thermal engine
+include ../../build/Build.include
+
+VERSION = 0.0.1
 
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
@@ -8,21 +11,48 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 # $(info Determined 'srctree' to be $(srctree))
 endif
 
-CFLAGS = -Wall -Wextra
-CFLAGS += -I$(srctree)/tools/thermal/lib
-CFLAGS += -I$(srctree)/tools/lib/thermal/include
+BINDIR=usr/bin
+WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
+override CFLAGS+= $(call cc-option,-O3,-O1) ${WARNFLAGS}
+# Add "-fstack-protector" only if toolchain supports it.
+override CFLAGS+= $(call cc-option,-fstack-protector-strong)
+CC?= $(CROSS_COMPILE)gcc
+PKG_CONFIG?= $(CROSS_COMPILE)pkg-config
 
-LDFLAGS = -L$(srctree)/tools/thermal/lib
-LDFLAGS += -L$(srctree)/tools/lib/thermal
-LDFLAGS += -lthermal_tools
-LDFLAGS += -lthermal
-LDFLAGS += -lconfig
-LDFLAGS += -lnl-genl-3 -lnl-3
+override CFLAGS+=-D VERSION=\"$(VERSION)\"
+TARGET=thermal-engine
 
-VERSION = 0.0.1
+override CFLAGS += -I$(srctree)/tools/thermal/lib
+override CFLAGS += -I$(srctree)/tools/lib/thermal/include
+
+override LDFLAGS += -L$(srctree)/tools/thermal/lib
+override LDFLAGS += -L$(srctree)/tools/lib/thermal
+
+INSTALL_PROGRAM=install -m 755 -p
+DEL_FILE=rm -f
+
+# Static builds might require -ltinfo, for instance
+ifneq ($(findstring -static, $(LDFLAGS)),)
+STATIC := --static
+endif
+
+THERMAL_ENGINE_LIBS=-lconfig -lnl-genl-3 -lnl-3 -lthermal -lthermal_tools
+
+OBJS = thermal-engine.o
+
+thermal-engine: $(OBJS) Makefile
+	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS)  -o $(TARGET) $(THERMAL_ENGINE_LIBS)
+
+install:
+	- $(INSTALL_PROGRAM) -D "$(TARGET)" "$(INSTALL_ROOT)/$(BINDIR)/$(TARGET)"
+
+uninstall:
+	$(DEL_FILE) "$(INSTALL_ROOT)/$(BINDIR)/$(TARGET)"
 
-all: thermal-engine
-%: %.c
-	$(CC) $(CFLAGS) -D VERSION=\"$(VERSION)\" -o $@ $^ $(LDFLAGS)
 clean:
-	$(RM) thermal-engine
+	rm -f $(TARGET) $(OBJS)
+
+dist:
+	git tag v$(VERSION)
+	git archive --format=tar --prefix="$(TARGET)-$(VERSION)/" v$(VERSION) | \
+		gzip > $(TARGET)-$(VERSION).tar.gz
-- 
2.43.0


