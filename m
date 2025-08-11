Return-Path: <linux-kernel+bounces-761899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F006B1FFBF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8013B8691
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB122D9EF5;
	Mon, 11 Aug 2025 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsEuCQ5b"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA1E13AD1C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895613; cv=none; b=oTtIL/b8NXEnwLsTC7+p/jkqpLDBtZue4GJ1mxfX4MEApvg0lzx63eOVvj6Pp8eOa1qy4kZKwyb/SnVvqgidzlGEjwH/c3Ptm5mdTRyoSwBUrq8R6YCFoObDiuIYxzWJyBoUrlQ9MdB5lhNsOzvsJUOr3tuSMZaslPJWPiwVExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895613; c=relaxed/simple;
	bh=DcAe9wT6QC5QyxeiRgMQA8wNpqFV14uYDM6dcM6/kxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8U1+9CTtDhl5x0S5xg7QNgHIYtbR88q9466KP8XjwFJ9PC7ZybKelgslKnhgbHRhedWVMeamdclL9ajxfRlXuN0Em8hgsdv42E2PZwnwmHLjNuo13vGR7j7G9osYz0tXfHJ0AA21CE1wUYdQVDo0QBbKysmjGcRy0oA+BZXcps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wsEuCQ5b; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af96d097df5so733398766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895600; x=1755500400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJU4sqEwL+qXvcHvb/mnK0Ms4HACkHUUGa4uEQrj1+w=;
        b=wsEuCQ5btj+I44s1w7tK0zLMF4ecGe3SlRFC2endUZB/W8/uCeEqJyge8Do3QbZ/7r
         5Ht0+EVx4h2Ol51FiWuLKtKvxRalgQKWHqBCHiDwkE9v4TEJ3dBLzZs3mUzIP0GUWmij
         9Gy/TuYoODoXDo7FHr7fx13zpLyXexu4y//HpfH1ZN+WKv8f6Lz0F9yNBnSW6ICuBq0f
         5nQCD7+W+psvHjo1+x6Bq/TEx8AVUbuh6HBFcC4vSn8abCXuCOPNlENjz1R/xT9V1KeG
         iCPZHIFd3VdKBR2HhEbfPdV6iKLmMiptBI8cOGN8Umm1Mp3643QCJBg9p5FkywUW9yAh
         QIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895600; x=1755500400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJU4sqEwL+qXvcHvb/mnK0Ms4HACkHUUGa4uEQrj1+w=;
        b=gi05JmBHh+fi3jTVK9gUg4+oAHt+/Wk2hpVCuRXeuJxknI3LB00tOz4nNtzkjMFE2H
         GakQt2u2nBq74V9F8pX0wpq2nhwJTY8g8eEZlgK7D002Uchb5ppQzEBSKLFmoS3CFdeH
         JqTBKDb59m9987a6/15LfzyKZHomz0T1qigW5MUT1vzby/MDVsrogAaG5QXwzpgDrCZK
         cStcJtxe1tX8tShAMOR2NC6Ep7mo473pgNnw1g/Hop+25aMJpTqVYBmnEzVhn9mBDFCB
         8U7Aff0HBtkDhp6UJ87x90tFfy6N88/x/R2egw4bKYOtYXENQdGWIUBnFWONsug2mang
         Hq2g==
X-Gm-Message-State: AOJu0Ywe3xSWyuwVAxINmGryGxMuwV1KAiOTAdPR+xZ9UmjOwiMWVd+5
	1UMQIGzCan3WQHrVigETU4d6V2u9oNN777/NLfD9LTpv1FCI0toDfw16bu0991DCn34=
X-Gm-Gg: ASbGnctedRrhAouXxUIeXnStJXc6Ls0rqpIuJzMF4EXzY1J5a4w3PQNzbZ4Oz+8ev0s
	PsFmzzEDk0KasQaHKNXZhUHpV6aTBNCSiumx4eDSH7xGlsmyLAau75kKqQw0cqTjD957lFf0onG
	IzQq3Imva7WLV1PWmqsu7+tIaJuHla+1KSoHLl/W8ioMvoAhXzpg6wG5s3lW2AAsqcsnFkEax7r
	ax2CeSHe8wkupUjkHRSCaFxVwv+YATa7smoqray9dGcKyVIzzv7Uv9tYyc2lAAknS+TfeHiBojL
	pBeycUzivBMYqqWm6P7mSA9ynnuhWEuU1BJIkc+rDBF38UgQhduZX4LZr025eTyZ7Kn/IoFC9OO
	cbMkIeJSpvZq8EwKxyuq6Q/AwnESGyhk=
X-Google-Smtp-Source: AGHT+IGTU1SlnJAzBr7ngcTzox/8GCPXwlpgRLhzLsNN44/ljJtO9ZCxmOJsox/oA4D7YHsrf8RWJg==
X-Received: by 2002:a17:906:c113:b0:aeb:fc49:3f56 with SMTP id a640c23a62f3a-af9c645da46mr1126322466b.15.1754895600428;
        Mon, 11 Aug 2025 00:00:00 -0700 (PDT)
Received: from eugen-station.. ([82.79.215.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm971793266b.6.2025.08.10.23.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:59:59 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 4/6] tools/thermal/lib: Fix dependency to host libnl
Date: Mon, 11 Aug 2025 09:59:13 +0300
Message-ID: <20250811065915.3333142-5-eugen.hristev@linaro.org>
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

Fixes: 3b7c5e8adf9c ("tools/thermal: Add util library")
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 tools/thermal/lib/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
index b8fded7f22b8..51a2a2ab7de8 100644
--- a/tools/thermal/lib/Makefile
+++ b/tools/thermal/lib/Makefile
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


