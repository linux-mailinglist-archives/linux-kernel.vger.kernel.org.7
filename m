Return-Path: <linux-kernel+bounces-878674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77503C2139D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B44EEB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EB7366FD9;
	Thu, 30 Oct 2025 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtXl7teC"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF1E365D37
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842110; cv=none; b=YSJ1x/6GhbKmY4Esd4WctagFTNHGjiZBrp3mqfjNmqWIF/cKoR9dDDuLq0yvNbK6esBAufocHeghkcx2mHZsRgoOPvwOcRyDyS5Lug8hbTLvmSdk8m5lOCsiMjoNovq1OKJWv0i4SQehbycp//F7G+t6gt8I185JyTDWm/8IsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842110; c=relaxed/simple;
	bh=KJhi7r1IxwKr2jceL8YpXI0OH3nQqefJ5FVtqYdua5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=od1gUIEavchsKuBQNT6fftR1whPXK24spCmlBGBTv5m4NiWeHa+L6c5ZsIfm/qgVCVoTXlWpf3le9b4PLe8bJ2LVnHTCb5dvuEjTN5qIDmOkD1E2kL++ZusbOTH9M3+BZAcVgGrABAFkpDNOgZ4T6KbVnzG6Hhcv/BXdT8ZqxKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtXl7teC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so1359357b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842108; x=1762446908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGxSll59pDGaTOq1wz4y9sLfdgQmv4t8Ak/F6aB1JEE=;
        b=RtXl7teCAhVeKP6/PyY54VoDUTJsdL4qEgzfduQcdLicZXxhKzc5IR8FyYCIzxEOxB
         bKc8yxg7YXAR54SK57pSjsNf5r7MRX7YElNQh6IVl+IF8Mmbe9KiQJyUVOEXqSsdwVOp
         NQMYHxH0tPGP0o+KtxXzih/4/S4ARFUiXPMxD5R0xPBG6s6jx0YWzuANpHM41yg1TRSm
         BOwa9B0c/QFKtjSsPS4c8YtIcYctGGalgbQqtIGjvvNH2lm+aNyWhRBigKv8rHIk5cu+
         J884vJfMfZ6fxscpY3YZ+j8HeOZUXRI1bVbvqJBATGm/IjFeP3VYS1tGmmJ8dZyrUpL4
         tgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842108; x=1762446908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGxSll59pDGaTOq1wz4y9sLfdgQmv4t8Ak/F6aB1JEE=;
        b=It1JWJj4OslXWMvC0fptt+UDx09B7XpARnuAG4Vlcr70Xphdw6Ou04ySsENWM0epV4
         OxZS8ygzoQEwxS4+2ql4naUiUlhP5Wa779DY7kDYS6EEKy5NoMvMmO0AfdU+8kMR8XqY
         1nysHbrD/WlNwoqN/wjylB1gTa5yFWRd0d9zcN3SYo9/CS+jk4jaupXRonyFtS/NgP0N
         FhmEbo5A0HNCQhClWKsh535fo4DAllzu11NnlNUEhsfa7AKwdfiPTD5NnYpQ3mDPjlun
         eKBATUFtSkt0n3VKkdLtgwDmTHl2iMp8yTj3gS48YlOaEZI2M33+RHxAywSsGwVYcFCf
         VTXg==
X-Forwarded-Encrypted: i=1; AJvYcCWF6aKOtq1lskvXt8wRz5UDGz+2d7JtP0IbohZfB/hjfMJBrYwuxHtjnqzb9wW964qo3t0W0S7DMPiJef4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyflj+CXnO7kSJhGW5UXoA7O21kNxMsYEJeQNQIaTaywokUYY6N
	iqPgDx58KToOkMjMRs2VE7mwoU5aXyYA1W/Q1mCCDuaXQBJiI9LP5ogM
X-Gm-Gg: ASbGncuFXBZSjkwSX7UBZwV/U5gb5L8KUaz5RO6jSolCFnJCXd0gdT35uUR2sjm5O+/
	xjk+61963U4eKoTMwuuObUvc4R7eLvnf87YLHKkIuqq9/1w6wqYAwLNWeR2n6HrjkyJ2cE+ITU1
	hdfj1rXbPubNacanWxvyHZuU8xjFLr0azLJbG0z1kG/zLS1mPA1/Xm6mwZlHVFeop7FI6f4YKht
	mM9d/bTVif7IuQrg7C0wa+VKZyeoLwIYlJXzkHm2pZvnuLCyxlitXsHmAb7KUlJO1TRBbXJdq6T
	ydHslnfgst1bOBSlAZA70qHqQoHkJBAzyGRTx4qBvT1gvYq26YQNxDbbINVVdfSv9f5JlAav1x8
	nWUN6+QzWm46p3RBrQ9jPoDoZRMzsvL6HrCATpJq8rktUsanyLAGPcRx3LX8xU+H4DDvUBxC+Xs
	6Xrr6cG1SMnMijdimV6NaiXbGb00BEBpNN2rKGlZaYJEIal67pQ8dXZeO7S+AN6qzQE61sphP84
	nRT0iQWkkESrwleUqQO5xjNdjDy4Ggxjvg0ZFM7SYr6QfE=
X-Google-Smtp-Source: AGHT+IEVgKwJVYk3LLzSGMiiVO2pd0zD6q0iNRm3NjG4WchOau35P7hbFf8JKXrswaA2JhS14jL/xA==
X-Received: by 2002:a17:903:2348:b0:290:7e29:f59f with SMTP id d9443c01a7336-2951a3c366cmr5308655ad.27.1761842107861;
        Thu, 30 Oct 2025 09:35:07 -0700 (PDT)
Received: from ajianan-Latitude-5591.. ([2402:e280:21d3:2:339d:c9c4:e069:47f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm190932845ad.100.2025.10.30.09.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:35:07 -0700 (PDT)
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajith Anandhan <ajithanandhan0406@gmail.com>
Subject: [RFC PATCH 3/3] MAINTAINERS: Add entry for TI ADS1120 ADC driver
Date: Thu, 30 Oct 2025 22:04:11 +0530
Message-Id: <20251030163411.236672-4-ajithanandhan0406@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new MAINTAINERS entry for the Texas Instruments ADS1120
ADC driver and its device tree binding.
Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3da2c26a7..1efe88fc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25613,6 +25613,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
 F:	drivers/iio/adc/ti-ads1119.c
 
+TI ADS1120 ADC DRIVER
+M:	Ajith Anandhan <ajithanandhan0406@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
+F:	drivers/iio/adc/ti-ads1120.c
+
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
 L:	linux-iio@vger.kernel.org
-- 
2.34.1


