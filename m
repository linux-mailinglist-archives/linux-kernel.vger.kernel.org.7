Return-Path: <linux-kernel+bounces-876137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97746C1AAAB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E753C1894854
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBC02C0F65;
	Wed, 29 Oct 2025 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VL9vNvTn"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8B2BF3CC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743644; cv=none; b=CdZL7yWdT7ueQiFBGjZNKpHbbtlOfjp9osCwFflLBXiVW2danY+Z4zg+Btu96GIlvdaPe71bMm15IIPd9vC2ZbPjenJa6DmjyWqoaoKPK+41R4Ui4/CioKE3A5z4GUp0Aa7y8rbpTl0lAjtqu+5rHt4UBVDa3f3kt1+GDwaacN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743644; c=relaxed/simple;
	bh=gmgqgw24MLfjErvr+kfghlRml+3oa3rLFqQ5uT+bh+I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qx+i8FPUQyONxCxmFbe+5ukwMKh7tenfNj0whRafCgyQWYg1+ul+vs8KZeBME/g2PwhuEwFe084JfOxCVJI90U26ww4Bg3z4UjrJPMWK0tUbVbFtkJgYXGMzTxQ+ohoDhfECZuY2nFp6kHwBhIbMxBVkKm1z8KHjFGAsSFIewpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VL9vNvTn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-474975af41dso49365465e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761743640; x=1762348440; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obvVO6ijh7zJI9QaOo5VQtAg4MY4RGT7X+Wj9ef9Fx4=;
        b=VL9vNvTnuv/Qu+l5zbH+8M+p+iIBkP1b5yYzfjsQro2Iq2PgCoX4i13iB7RLeE/mls
         ipsC3CZehO98DyClgJkdhBZ+NmRei6GqTEbj6B+dAoygOEK7lAUy30OnDLjrF/E+uagp
         yLF2+ljJzhrZVXO0rgQEaWvJ96dDSwYnvB9olnDcz69ueUDi47mXXiMQw9xvVNU8IRNN
         r1q+OZT6qXehUNpO0nDnCkHUnheKw6108NKqbRP1f+SyHryxUH8logHAuOrZC5fKTEKJ
         SA9DWMPgH31Yx5Di02M0ogS1OWCp2pCzghv0woa9qa6AnIsadSBHxHDywrnS+IFAD64U
         L3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743640; x=1762348440;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obvVO6ijh7zJI9QaOo5VQtAg4MY4RGT7X+Wj9ef9Fx4=;
        b=gIEg6VPrnJC431+ogdiH+WKpdIEwbkp4tO9p/Ezge19Ar0HperUHIztMX7SGQvETXx
         uH+F2pqlONlrcnq3iZkRkGbRNQjhOmaL1Y+g4tVuFWUSSBSKotJr0+iU7uVpFr9GSbE5
         +HKcQz6NmIkD6ORlbOSaZwrP+VEmfWlcs6NGkrqV4IuhurdvyGlbtTjvrrwyGEB+JFer
         zlO88Zbhosb/gu1Q8nSYifP/MKlM3VliP/DIaCUY1Dw44lhve/Cho5Nc/KxcF44Yw3uD
         ThDihTa/fna7VDbtI2uz4S+NZvM3HmoD3Yr3kbI/8r8W2oTIDStnBedVLOm33kveVbvm
         IhdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX23NZhc4uCI2IwjmJmRa8tyDx86ZKooGyZHY5BryJpuPh5GHE+HMSmk8/gGu0Rt78ceMdzHN+GWaJdd74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzp6xuaeq4/f4wpKVLeDHR8acUgeiuXZdOrIZrN/dODfZR6K0/
	pryEPTMA7XVsQSfHM1umihDe5KLH12RuIibLkR3tXjomG9geZDTfNU+vuSIwM1cL5Jw=
X-Gm-Gg: ASbGncsBi1jmNhM94fmuTpM5+JnWXRO1gcyZotkDGKPmbeFLligKHLikS4pFZJfSjet
	0qnWpl3evKimoo0Gl1JeeQBjQKE9VXDdRzHxvzfXFmonMbMQ1xplperyqUjn8kyLdOO7l17mTDQ
	77bw/4hVUFCOww1ddAg0PeC9mt6UHts4wg7TF2aZfecGePzZSJoC933BRU0QT2dlGh7TNG/8yhx
	wbtlIT2lCW0XfI1o/km2xcegQuu9tPnJpI/bul/eNggPES0B/JaAOthfDdd8aOLlWcwaHKHyY0I
	JBkGJZEMNMaC3HVVlpWwYlbcyHxLsQIvFk4siP7P9At7emxcwq+6KYITobrfTAK8e5IezqEA1vb
	aEDWlDZjsMaZvOYd3/UDhXDv64G6FH3+MLOKMfRgV3n+5kAjjobKe0Prmy/MLzGOtQPvoRCwwi/
	cZsF6f96nOWEiH1CQB
X-Google-Smtp-Source: AGHT+IGOlwhirvKhC2gYeFfPJKrIR9GBb37d6lWPNsa4U9lLC5IBxuYdwplG7hkMlAutxG2URF4BGg==
X-Received: by 2002:a05:600c:8b8b:b0:471:1717:40f with SMTP id 5b1f17b1804b1-4771e1ca084mr25439795e9.22.1761743640364;
        Wed, 29 Oct 2025 06:14:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952e2e06sm26433385f8f.46.2025.10.29.06.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:14:00 -0700 (PDT)
Date: Wed, 29 Oct 2025 16:13:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] misc: cb710: Fix a NULL vs IS_ERR() check in probe()
Message-ID: <aQITFDPyuzjNN4GN@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The pcim_iomap_region() function never returns NULL, it returns error
pointers.  Update the checking to match.

Fixes: b91c13534a63 ("misc: cb710: Replace deprecated PCI functions")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/misc/cb710/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cb710/core.c b/drivers/misc/cb710/core.c
index a1e6ba62c298..2dd212f04fed 100644
--- a/drivers/misc/cb710/core.c
+++ b/drivers/misc/cb710/core.c
@@ -226,8 +226,8 @@ static int cb710_probe(struct pci_dev *pdev,
 	spin_lock_init(&chip->irq_lock);
 	chip->pdev = pdev;
 	chip->iobase = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
-	if (!chip->iobase)
-		return -ENOMEM;
+	if (IS_ERR(chip->iobase))
+		return PTR_ERR(chip->iobase);
 
 	pci_set_drvdata(pdev, chip);
 
-- 
2.51.0


