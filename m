Return-Path: <linux-kernel+bounces-761898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E50B1FFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB92189BA16
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F002D979F;
	Mon, 11 Aug 2025 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPuAdGfw"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A9E2D8DDD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895602; cv=none; b=hyG6M0YAlQW6uGYlNPUv51NGu3w1WWX7N1JbMLtYNSbQuULHTEbS7FJlY/dyJGynB9Ioehxz1ke9lZQL7RGCeS6fcLsTWbiZP3KNq2a8gc2aImfW5vCxaJAAkwkWRTgqen7miSzYoiO+FDhkMno/bLp7BEPDt5Awi3o+lV3vxos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895602; c=relaxed/simple;
	bh=KvFKeOUgAv5xTieNT78OQsqgL/nxGh1DVLUIu8ihqrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z32YkX76w3fVt9cpMVWULSbEwYVmWQ1kHNFWG/LIQiVkK5D4oF9bEaXYQWBkOSZuKB392wGItgtEyP8pvNuyBPUERxSP+2+OOdwtBpcFeG65EDGvpbI1U7VZyrAfdt+fAQL0qrVH6bOZnsNuIJvK4sAgxPTiGbiClRux/dL887I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hPuAdGfw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af958127df5so605416966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895599; x=1755500399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yH1Zfwk4M7pUV4TKZjHnni/k3y7gfw5Y8QnaMyZmAI=;
        b=hPuAdGfw+qYOJnHPWV8xhrt8fF0V5ZrUirrtIoFNsUm+Q1PtU5dB9gF+LjjT9RoSCJ
         d2NP+1d8iKuKPi5m4hqCXftggn/D+qChsNG3pSxiUn6B694Xw1mOCnJjJt5rrRTNjlLa
         S6nO6Doouh8VZUjVEjnDW0ZuVBtHIybzHl0mjX4hNS1qbS7+jKF3cJBOMaOGeRldlBze
         tt+bdQDoxn8qCMdT7kLcXSVkAShBCwGC92VkW9zVdLdI6nOgdX/jzEvhOavaFrFm6M1Q
         CN4ig8XlELuy1ElSXITe2Yx/t88gO7oLhkR3+DzcqiA/XyEn+FUOSucHRw3kb5uxzEhi
         xzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895599; x=1755500399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yH1Zfwk4M7pUV4TKZjHnni/k3y7gfw5Y8QnaMyZmAI=;
        b=gk+WN8NePd5OqScDwx5CddSynjUqYJPMPmXd5kSnDQbFZ+Os7iSh91zsiWCj8lNNRD
         merCqeMvuLzUgm6MLriSRkv79u14uW69K05GMCgKfTINKmF4d74XSX7Ci5K4aUJDB+0/
         eCbOZScT2vLnR8uClZqTBE20K+wtXX8+/LyJhB/tJXZKm9iMNwpyl2RSKXmlPWwrCZ9t
         x49ey7+5XuHFCDMmrkseDBHCTi7CvONLgQOookRMVknHjqaBBEIwOtEWgtGHTi1cSbyG
         LIBtKR4krtYvAGKoYx8IlcwyTKohPNjf+x+md153z1vM3eoOF9p4TrJPe4NYyeySGSRf
         tPEg==
X-Gm-Message-State: AOJu0Yw5RSVwMbi2jt7weQj9szxbGyAkv4vPQhy3/PkoFtVpgTFJ+d6s
	Imk4cbqPJT0f4IzIOTxQc6rKlk66ZxCceqhPDjGgTNjY3/O8bY0sSMrSxhqRJ7Gnf2M=
X-Gm-Gg: ASbGncsaXYx5rTGJLtNk/qx3Kp7n60/55htn4uHu3pKdH70ZRWDrQF9IBrPL5nQuQrU
	kYW2ZLgTZlVNXNIyOZDyt5im1l1jYynS3KdviEut0XWQKXN7PpI/my6dsz5EELhSQfCsCWIyEj9
	LT/37OoogjvbqQaTV1/3KQSKfiafPCXAi1FTkRFpdLmEmEFQCm56uV9Asw182SG6BdxNEiB06Dl
	G0krLQf3OU9QG+1/90fkHfVLnJzZmm2ILapbR7u3ku1I0p4jYbSMMXmevUYHC3OvJ1zxx4ir04P
	cf24Rpm/OSauAAqrqOAKX7j0H7WjHQrIdTMFcK2jh3wJCgW5YtEJaVEDVjJJBdUXIJZQwXUP8uS
	O0MagmRY1u2TnQyI9EFW0T4utii0ZMPk=
X-Google-Smtp-Source: AGHT+IGN+cgo4XlhoYRFNuK+84w1+noJNCVLJZxTCxe+T8UmaEJsfGzVSe/O7t9sBEWtkuxLD8SWPA==
X-Received: by 2002:a17:907:3d55:b0:af9:613b:3055 with SMTP id a640c23a62f3a-af9c63b0941mr994855766b.2.1754895599094;
        Sun, 10 Aug 2025 23:59:59 -0700 (PDT)
Received: from eugen-station.. ([82.79.215.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af99604e648sm971793266b.6.2025.08.10.23.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:59:58 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 3/6] tools/thermal/lib: Fix header file installation
Date: Mon, 11 Aug 2025 09:59:12 +0300
Message-ID: <20250811065915.3333142-4-eugen.hristev@linaro.org>
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

The header file created by this lib is thermal-tools.h and not thermal.h
Fix it accordingly.

Fixes: 3b7c5e8adf9c ("tools/thermal: Add util library")
Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 tools/thermal/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
index 056d212f25cf..b8fded7f22b8 100644
--- a/tools/thermal/lib/Makefile
+++ b/tools/thermal/lib/Makefile
@@ -128,7 +128,7 @@ install_lib: libs
 
 install_headers:
 	$(call QUIET_INSTALL, headers) \
-		$(call do_install,include/thermal.h,$(prefix)/include/thermal,644); \
+		$(call do_install,thermal-tools.h,$(prefix)/include/thermal,644); \
 
 install_pkgconfig: $(LIBTHERMAL_TOOLS_PC)
 	$(call QUIET_INSTALL, $(LIBTHERMAL_TOOLS_PC)) \
-- 
2.43.0


