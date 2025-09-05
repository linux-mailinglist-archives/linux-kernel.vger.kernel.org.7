Return-Path: <linux-kernel+bounces-802629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E5EB454D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98807BE598
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169742DF701;
	Fri,  5 Sep 2025 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDtm8cNd"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6972DE71A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068488; cv=none; b=FI2r6Ap22RFhZA+TWZ541XtgTH2Us6sYTuHlV8zN1fEAd68vI+3u69AB4wUSrxKqQYhAfNHGOz4eP0ZhW434T3M7MYK040igZCpHagdvHiX9RcDYWYt0Yo2DGqgMqboxvzg6mkO0kUPpENIqOpuhC59aGxN2YPNRvxR5F+ybblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068488; c=relaxed/simple;
	bh=u6RhB0tf0PDdBxV2rbvlgcsSK3l7osAwo6tTvY3V7jU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lIoe273HPAJa9YOoX2UyjhqPVzW3WW1mTdT9KswkQshzCt/2zfHG+B1jclp1DCWACqQb28YD5o2aCia/ji+yh5LJvcotspywsVGNMqSZQpFXYWqkAYyA/KSoYGHiWgwnQrtP+ghV+LRZZdVKv6/rmKtdqriA4fowjA3gdKaaAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DDtm8cNd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b9853e630so18433735e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757068485; x=1757673285; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPtTBmTlI3N0NEb+IPUhn2li4g4XRE/ENCP82oW3Ymc=;
        b=DDtm8cNdvV2i0UbcZdJkKhttMeS8Ge1GZO6/2sOLoaBmV0Cy8YGY4P1pqt0cRU3ffB
         uZOxLjyl99lUMFuT2YPgdHBvXJ7UPamY1JRM9Jb4F5VTCCbWW1kPiZ4iPu0Qo7cax7Ty
         81Bs+zgXlE1A8f/wSNCP0t2WuKgoVKP4Cvw9dxJv6RMuz6C/8EtW8mkXuZG7oS4KHhKB
         SlQp6BiPWfZPhTXpm/VHVal7q2SHwIbu3zC517XH7LH83IgSzhaRak9TgHDZ7xYFiK8u
         f42EWOVh2KLenHMpUV/AvVqP7MV8A8ZFcsI1kX2B9BKczikqemGfreSq27b2cvUFw248
         rZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757068485; x=1757673285;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPtTBmTlI3N0NEb+IPUhn2li4g4XRE/ENCP82oW3Ymc=;
        b=OabAuvl8fnOeTMalECSwZBUkfdzhoCBpsHt5YCMsVcFMifjZvK2mir/K4nnllt4KWI
         0dyQaJsXz70IJQ5nUbMNkWN4IYw16upuTAorWvfhT03cYkdr/8Jv5mpGes/q5eBfKmEL
         zFdSCRx4Liz1Luc/v352LBh+lBMwmrUGgPMGRwwhqCIYj+R9DcAHyvlXfG5Qxo8eeqOO
         d573jSoEM2DfDgw9a6uylwIEvFZ4ITGCJRXEWVQA0qcbywIWJwPBleuTQWXLXbs1L0A8
         FUrY4PRhgSud/tSGSfO5jhME7anliDGe5UimuHgLLcE8VhCGozRI0NJegScvwh9oIkSi
         XlYA==
X-Forwarded-Encrypted: i=1; AJvYcCV25F0Tpw3Rp5UTV8gI9BJ0bGPW5Tca7ohLrC3/q7XhrPDwiMhjFWDZ/GzZYFqSyXxLCY/5pAw76GWMjjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxFbGFHY+ET6tgsUjGwyDJoLgM6nRYSzHpU7XG7hm+egFWz3u
	wl9yusml8oQ/LwZfQZ72aChmO7naL48ZB26WrhOv5U5fNRFMAMKxjv3LqLgJopfyImM=
X-Gm-Gg: ASbGnctFQpMdOeLWLQrVAqvaezsOjSZdrLNOICzKlxvooSyNPbky8lA4KhlYjzg8y2F
	bHWFKTCUtdS5wL/2FWbUpXRKBRbXi4s1KinFHt0X7fgmLfuLbEeiJZKdTB9ePtcxUQjWfCjTvkN
	AlSotIAMt1EIVXZ51fTcDkGIlkgcuxVQ1GKEhP2bRm69sP3AM90WF4j37XuTAPFh4zW3ieR28Mn
	+sBXlFrAY62y7ULMCy+9jmroAtf3QGJ4JvSDLSRD/QMGnSADSKljnhi9SCf9uVrbMVtLhg8G+IG
	NvbswxCluuYlSagENss8+pclODAkg67MgPDdBk99T259lntB2dcsv+9GM8ILOr1MVaFQWB+QISa
	PlX8oOgXfyuvm/Np+PNdV0ORblkk=
X-Google-Smtp-Source: AGHT+IHMNZ5aQjypfVjJ8/LG9UBIbm3yubJahrqfypappgfPyW+RM4kefqenC/by5O/ylYVnmWRXlQ==
X-Received: by 2002:a05:600c:4454:b0:459:dfde:3324 with SMTP id 5b1f17b1804b1-45b855b34f8mr173869605e9.29.1757068485001;
        Fri, 05 Sep 2025 03:34:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b9c5c89f2sm137991255e9.14.2025.09.05.03.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:34:44 -0700 (PDT)
Date: Fri, 5 Sep 2025 13:34:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] kunit: print a message before triggering a NULL dereference
Message-ID: <aLq8wXJraE3SBPnP@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Print a message so that people reading dmesg know that these NULL
dereferences are not a bug, but instead a deliberate part of
the testing.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 lib/kunit/kunit-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 8c01eabd4eaf..a8b6e16f4465 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -119,6 +119,8 @@ static void kunit_test_null_dereference(void *data)
 	struct kunit *test = data;
 	int *null = NULL;
 
+	pr_info("Triggering deliberate NULL derefence.\n");
+
 	*null = 0;
 
 	KUNIT_FAIL(test, "This line should never be reached\n");
-- 
2.47.2


