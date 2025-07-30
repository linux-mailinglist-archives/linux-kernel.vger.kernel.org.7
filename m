Return-Path: <linux-kernel+bounces-750275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F58B15965
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D53A7A70F4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7300D227E97;
	Wed, 30 Jul 2025 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wUSH2U8E"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2072264CC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753859702; cv=none; b=F3YKPz+e5pOPhi1IcPcex4kiPgDyao9Y0mVG3SOZ3MB16Q715XjFg7bLn9S2RuD0LYFPG2ifgIiToUD/1F1KuyuiCEe87RFmRQOUellprhHaGcTBNWFCaJ3/OTDzV4Jd4schklMeu7F7rLWAmp3Nd2oxWE77OOuKZl1qcb/S+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753859702; c=relaxed/simple;
	bh=Jl96Chu7SMvNDn8DRT0lGln0Wby6eyTfgII4vTzTBJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t2eLCyBoaX6RduojrFVjSI/BroKp7nDdbuplUWPqFfI4ezkDE49RvHTvMjFdZg4dMwEvpwsuQ9f7XIsWCkZLuHWtl7i88lzBEdlbZ/knHBWKmCI8EWKxXlHTDrIum62NtMAeYixQjgGvynJsSJuS9GdjuheuVBwGEqj/h1j/rkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wUSH2U8E; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4589968e001so1376015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753859699; x=1754464499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZFPYlDdJ0rVu0VNavE3SZOZbmVPr53MAqWXB77UPjc=;
        b=wUSH2U8EPGCQ2lMwnLOrVxFsIuFACO50urbgtau4e8PO5WYDzUdiv4JPpaIS6Uqyy3
         Rz03LYPML9Re6IaQ/IjxE5njLXaL0A5Ac6ZitCoP/B8P4uPhaG6L4EpFKwkUM9Hou7lQ
         YZMVmlhDWNkiWHfRDcqs3RlcBgEqDLfRabZ3zbIUoMxPzA6wLDQLhhzepmtLeECG7cVF
         uSIDa+AH2SlyyG/2FI6NtSqlBQuIm/X6sL/pMxVQv6AbbB/jKL65IGl2wvQy0xvAy6nI
         QKPy0eN/9Q1+vyzL1BIx6eOnYeTeSaG6WKS7PeSB3n6wcRViU4APOwo+4D6TTtk04Kyq
         GkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753859699; x=1754464499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZFPYlDdJ0rVu0VNavE3SZOZbmVPr53MAqWXB77UPjc=;
        b=KTBh7Uupo9i5IeF8gtglgOW8rgiSzKRl04SOD5EUtL2Aw7yUEvqN9w5msqHST9Fwcp
         kXhmBn+MSfVCMSdXvSHTMspsvObI8qCUZKLEpE0yCsfqJICXiZGmfn8XseqFrBWLmYbF
         fKmFJ0rdLAFzhJ92J5UsFN9hXSA8ddGIjipNm4LvOVzvBhGvO6RqzTyPOwpbOVSH9Vyw
         a22A2rlES4wKO5tB4g9n180S8sn4d28ehU0Qvf7wI1iPIqAjga+6w3JtL0Xcx4AG3UY3
         ddJLPuT2ck0rY53cRYA5o0ayW8uWvaD+ZQuqtPTC6E/5JrlnzEY4BJw1Fn1HgpYUX5tQ
         ySuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXSX3Tvmjxv51IKZ9Rsj0tEJxVOvfpdWXJT1Dk3rGSkOQDwUZuWbff0+QeVNyQ6HOcf3h0h4Mb/J9+GfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXZcuzS5dI1mRWAYfifOyIwshWtxUOENuN47TaiE5e2Br9tv+S
	7gXu3WhI32cBLs6j+S0zF91O9lDD9+4MXd7Avm9ead5YOtFivPdei2RkeBCKTsL1RGa5TPg/ym7
	MgC1b
X-Gm-Gg: ASbGnctGcN72m1YHTLA/oxSXDPLrtYvZRsIhkXGxy9Dh4wK8bcM5/X++g4NeKHLfiba
	pdKHXUJnNI0QUI2JRrj7O+BdULR0JtGpT9B85tJsqGtLqUVW4jcqZ86b95q04sIY1gclWqcxcf/
	MxMt/bZD0ky6CManL0VJ8gpD7bCRvob+8CnBOUB0T7fO9cvhlAuTnMxo1SxqR8bcfxLtxcO3ZuQ
	guJ0nbLDSdoPgzuNlDkwDKwWFYOjZ2Wd59OdR/LNH9KO1eNfZdM8jvQxEWhzKFamTI6tnBRxluw
	yZI5yWr7FMz9j0sNPqe9YvgukFS0LoqxGdgTpVh3gwYMpwer9K8frDr2j251ASKhTwcrUErh7jM
	kLXbmj/9PpMLeyL4w9j4MVS+D
X-Google-Smtp-Source: AGHT+IHNb3WqBOl3BcnyoTf2mFnsCMBFsTDjTJbP6rodUQ7rplDyO6pwXBZDtxJ0tWuM+n35yFd+5Q==
X-Received: by 2002:a05:600c:3d8a:b0:458:6733:fb59 with SMTP id 5b1f17b1804b1-45892bc5895mr18567715e9.19.1753859699078;
        Wed, 30 Jul 2025 00:14:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:e75d:6dc4:a638:ae8e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eb284fsm15118926f8f.12.2025.07.30.00.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 00:14:58 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] ARM: s3c/gpio: complete the conversion to new GPIO value setters
Date: Wed, 30 Jul 2025 09:14:43 +0200
Message-ID: <20250730071443.8758-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Commit fb52f3226cab ("ARM: s3c/gpio: use new line value setter
callbacks") correctly changed the assignment of the callback but missed
the check one liner higher. Change it now too to using the recommended
callback as the legacy one is going away soon.

Fixes: fb52f3226cab ("ARM: s3c/gpio: use new line value setter callbacks")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Autobuilders pointed out only now that I missed the other line that
needs changing in my previous patch. I'd like to still queue this for
v6.17. Either through the SoC tree if it's not too late or through the
GPIO tree together with my second PR for this merge window. Please
kindly ack it.

 arch/arm/mach-s3c/gpio-samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c/gpio-samsung.c b/arch/arm/mach-s3c/gpio-samsung.c
index 206a492fbaf5..3ee4ad969cc2 100644
--- a/arch/arm/mach-s3c/gpio-samsung.c
+++ b/arch/arm/mach-s3c/gpio-samsung.c
@@ -516,7 +516,7 @@ static void __init samsung_gpiolib_add(struct samsung_gpio_chip *chip)
 		gc->direction_input = samsung_gpiolib_2bit_input;
 	if (!gc->direction_output)
 		gc->direction_output = samsung_gpiolib_2bit_output;
-	if (!gc->set)
+	if (!gc->set_rv)
 		gc->set_rv = samsung_gpiolib_set;
 	if (!gc->get)
 		gc->get = samsung_gpiolib_get;
-- 
2.48.1


