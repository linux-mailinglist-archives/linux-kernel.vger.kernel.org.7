Return-Path: <linux-kernel+bounces-830741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3D7B9A6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8F03818DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC8630C357;
	Wed, 24 Sep 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGdaIUHE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C315E309F14
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725795; cv=none; b=qU5pdvQDQ20F150a6CkjUqhG+G8hCijWG/AKJIB0zbIHzuiMuTCYy5rA8kcZ69jt4kGnw9qG5o/vTr9WZmZlN0AY3xKoQRJRftbCs+D63swPV9G1+256uIIdhNgy3ajIxAnNRBljCiR9OH/LTEX4HXTp/WfafwFEpNNRkhBlxsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725795; c=relaxed/simple;
	bh=PRZk0jrFppgN7vSJOjlLygbmhzpydrL411Vx9kPArxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OO5+ZN7hliXKGzHu/naKQjiZFRBLl07b5t440K7M4CCnXVwIvwR3RGGBMK4rwF+ytT8xZsTIDRhsxbqqBf04L+OxSYSABk10PmRkBzT8TR0hUjNZlzEioYfMzRZkvPEvqaflGpntexFSzZSvJpR1Nl6CZDPPNBHq8IgTXMIPH0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGdaIUHE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so29799085ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758725793; x=1759330593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NTbOy29uVlcjxenqUAe8YQxe9aRTQQhc7UehxU14MvM=;
        b=UGdaIUHErP8azX93+SMz6kw/SwYEX3EiN/MG58aCC2P1J8HOPEZ4JqBinyWtAMPJkq
         VSyFofq3+sWzG6ERZc1HTWNWHUNy3hb7IStwk9CByeh4wYomrTwEmPolFyu3j6MbCtCL
         c4y8uF/6N5QQsuAFxBazGwnaLjbBdnSmDVwf9LvMBEMpZnNtZQWyoWF3xnzV0epZkokp
         Fvk/+P237rLUQ1SHJkqfcRMc0F4gQfj0U8v4MPAQlqpUifBa9Wol2C0iN0YW0kYzOwfN
         IwnLJIv0+RBZAtrOH4YJ6T424Vpvw0cVIzvOf48gv6m+mJrBditHZ6QrSJbcazdvrQ4x
         RlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725793; x=1759330593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTbOy29uVlcjxenqUAe8YQxe9aRTQQhc7UehxU14MvM=;
        b=LrVmZNNvwgtTK2SLhENfMJh1qloaGOBqBAQnJc2H9x2bX8phUQdaw2IInlcsH+Vhxv
         qqMD8F8Mkvu2hiJZoFBRhtc4joqBzda1LWuD/an7K8d7a7lEcI+Kspk2ndbgrDFH9lHj
         0CazffKs5eIwg1ibKX1XF9f+3g/ojwh+Hn+IdLipKZ0LUDaBECDxNEPDw3pb3nnzlCvu
         qFEEc5o7O6490oKqQYpGDSicuCESaHNSFkyHf7x/4kfpeSYzf8SvLhef4VQSTt6uarzW
         UOKOvhwOXXX67HAnztXKYMWm/dE9tF9RUW8mG0Ku+WDnxhefHT5uPY9t8k1i4gq3Cmnm
         lahw==
X-Forwarded-Encrypted: i=1; AJvYcCX5JHMqaqIDhVmYjZYNqammoG+4UxTa4EjZTd4cve9LK3lR/vXOBPKrst+GziaCUzgITmwqRK3ZthPnOrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymiAxdO49jRJbn3UySPRS30bsjRBwKIQUI7OHGubX1Fsp6uUZF
	6QrGDfG8tEjivRe6X7uUI4dJTyf6cM7F3CiGDHWFGrfpnrPajDklsm21
X-Gm-Gg: ASbGnctmE3b/g0ZTf/LdfFSTa+IU482Bt8Y1f+kFpVIC4ymy0rlBPJSSDhSsyhHtPAC
	9W/DFde52o19U4w+2T+D1SNtCpv8pMyYvzwR0+8l6xeugKoT7MgvP9yte6mEV/04PU5DT556MH8
	jVcFuiEE+SZ+5hYAugXQBAQs7aJS5XDfL4X9N/CiedWYk+e8fPnMVNX0w/FUX8ou5S4g0qDPqaD
	paoL2KoAM+O3SrREDguqj7XpHjJQ1Ikl+T2kh/gqCnV2CQn1Kv5NRVNr1HRvW8x+cdYkAHiRBb8
	n+S5/Dj08DLiTPT8QBq363SF5zDPzz/cbRzOTHr0TR+W3wZef+zrwbEaNyL99ZKd4EBFzmf83QQ
	fxWodFYyGj7wX5gjlYEM0RBpHIoRa1/jK2vJ6isARt23PTaSyi9W3uRhObEI=
X-Google-Smtp-Source: AGHT+IHUOeFU4kluRlGJm8/v8V8Ejgu0uLYlYSI6Xmc4VXSt/m1ELVH4qAcTGAn/spP/GfmPawzFYw==
X-Received: by 2002:a17:903:b43:b0:267:776b:a31a with SMTP id d9443c01a7336-27ed4a3de4emr65295ad.29.1758725792827;
        Wed, 24 Sep 2025 07:56:32 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f31:8167:35e6:be:ecb1:9216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de963sm190509975ad.77.2025.09.24.07.56.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Sep 2025 07:56:32 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	varshini.rajendran@microchip.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Sidharth Seela <sidharthseela@gmail.com>
Subject: [PATCH RESEND] clk: at91: sam9x7: Use kmalloc_array() instead of kmalloc()
Date: Wed, 24 Sep 2025 20:25:53 +0530
Message-Id: <20250924145552.55058-1-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kmalloc with kmalloc array in clk/at91/sam9x7.c. Refactor to new
API, for cases with dynamic size calculations inside kmalloc().

Resend is to correct previously sent patches mailing address.

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
---
diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index ffab32b047a0..0c0a746a183d 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -748,9 +748,9 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 	if (!sam9x7_pmc)
 		return;
 
-	clk_mux_buffer = kmalloc(sizeof(void *) *
-				 (ARRAY_SIZE(sam9x7_gck)),
-				 GFP_KERNEL);
+	clk_mux_buffer = kmalloc_array(ARRAY_SIZE(sam9x7_gck),
+					sizeof(void *),
+					GFP_KERNEL);
 	if (!clk_mux_buffer)
 		goto err_free;
 
-- 
2.39.5 (Apple Git-154)


