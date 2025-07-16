Return-Path: <linux-kernel+bounces-734198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C318DB07E45
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3181C42EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E4128F528;
	Wed, 16 Jul 2025 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGZqs069"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26739188A3A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695029; cv=none; b=FeeiqZS9rpI8/nfI/7PzhHcVOb9PKIAtHk9MqiCxkF5nAIOpt/olagw6H9wag15MALnsP9PbEO6OoFG7fz5Cw5LICllF77LQ7Bw+9bqiNXOMdZ9DXwWEUdAp3/c8oLMB7rlU3ryLlPBhj1jPoSHrCgxneJ1HjoEHtzPMP60BytE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695029; c=relaxed/simple;
	bh=pXfjGryhHsXaEwigYLwe/P3+EpFLiYB6sbYadjHApPY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TOMfQwKJX0oVkWmFhLSQT9KNv1ai8ztJDMko0kt2HK7gNVBZjWeAk3MiRtmdtDIOH+6EYba0NA2sm+ZYT0pN9+ZEa7zXACrNpeDITyV94CJCf5HDT3tmKhTX6iSSoWMdCXP+ELr+we7W9MRVNKYLvyvYFASOysQy4W2TYmrIMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RGZqs069; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2ea34731c5dso211986fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752695027; x=1753299827; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmJZX6J1qRoq7AzSQMCUC8rTJXTuje9Df69FamNPBRM=;
        b=RGZqs0692df34ugkghm93d1RCzV7NdjrQSOhfeM6oogPG5+7Ay9OprEHChizk16PPr
         /tjnIM6T5sHHJVcO5QTQGCshX9zUtP76xPNJR2DD1ngtvaSSoLyhO8OJxPcOtfOOT2cy
         H6/Kexs9yHN2qj35Nb9irIxsLrPGBsXrGUgOOoRyo895dJynKlJVKdQ8KzQuFBZ2z5pW
         UJ+rI1XleO0Q13QTP+wg0BHU93gOmxlhxFT7KLQHg7bzuouC0vc2Rh5KukEmKH3ixfAt
         165x5bg6G35PBwKlSXFg4hQ2RbNAxOBTJjRuFaFPyEmR/e12VG97QCA6byVfUllNIzkM
         WpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752695027; x=1753299827;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmJZX6J1qRoq7AzSQMCUC8rTJXTuje9Df69FamNPBRM=;
        b=T5UEvO3GLtmAu53CjCvSHMnKI+5vIpdbudvdIH1RRnH3FWfi6VM4rAn5W1NRMKPjrC
         QUZ2xZM9o0DeL0w3uSP1iZOLZEQi5jb7uBLH99vXLWHNrHWOeaLRLEZYwdCsfE4Zc8wF
         +WL7u/jRZGZk2pt1fcX0MQcfNjOn44uTLOdheHMrxmbLSF/2pCepjptpINyg64G5Mdz2
         l3V0ul/bIWcRC9MoixnQKSmod8J2m/2MIgf9V2Bvjyzv0l3NWvCAhF+8gPGfh8O8GvB+
         UrodElAHIIsMcx2ePX0zZkpXdw91tpsdJEsu5oULFJyjL6NUOArs7fMVefz1UxFLzS8F
         I2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUAx8WK6JF7u7z1ZopL41t/yVgtH3hTFaGpHduPQbw2eGV3RomeklCRl0DF8C7fz56h+YG41WGnACOBu2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbsJkDOK6bMQsU4JoT9z7oPsV5FQXjy1zCPtYeOlEXJ277pxCZ
	La/TcK1XsNw9lU0vyFvp97njkGov5Whiqo/YrnmHd2VJUi6pnzVv0E0TCxrKdRTRY0eagvDeoOa
	cX52k
X-Gm-Gg: ASbGncvYrvrhzc2OTUF4/80yLtZMEgWjTI+EerWfoV+0td6PctSRFbjMfHIcc9pNXLN
	qUv8iSCyccpmZbgioH/inWgavX8ok3z6oCI1munuvI5FwV+NgHQjFk8UKkIO9OZ3c2NrXSkkBrL
	QcX7t1O3abmUi8PLDSjMo5LlxNXm0Wt5zMZuSbsJaFCK0luQPT2IZlp9XO62G+If4cOEVBQSt55
	jdZodkxnOvV2HEb0rSd3ZPiBWX5HEEbOHW+OimtGgmN1U0b74h50dRvLhatM9+trZndywg8oAV1
	o41+I+AwsFU4uiIZ0fHooKYxU24CS+pVAdUrWE7g22JM522mD8vMteUFs0WTek5W2LBBThCbeMb
	s+i/ecQYEC12FFTxCZtumLaSX2Fs1zhhOx7TkEwcj
X-Google-Smtp-Source: AGHT+IF8DC41wViyGCjPZEkIppmrGRXKouyjvgC2Rel1VCsq4higRnI+57N6atyy6zVPo8lzk9b3mQ==
X-Received: by 2002:a05:6870:9f06:b0:2d5:ba2d:80dd with SMTP id 586e51a60fabf-2ffb22506aamr3182710fac.12.1752695027100;
        Wed, 16 Jul 2025 12:43:47 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3f28:4161:2162:7ea2])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff111c36b8sm3753163fac.10.2025.07.16.12.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:43:46 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:43:45 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] irqchip/ls-scfg-msi: Fix NULL dereference in error
 handling
Message-ID: <15059507-6422-4333-94ca-e8e8840bd289@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The call to irq_domain_remove(msi_data->parent); was accidentally left
behind during a code refactor.  It's not necessary to free
"msi_data->parent" because it is NULL and, in fact, trying to free it
will lead to a NULL pointer dereference.  Delete the unnecessary code.

Fixes: 94b59d5f567a ("irqchip/ls-scfg-msi: Switch to use msi_create_parent_irq_domain()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/irqchip/irq-ls-scfg-msi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 7eca751d6548..4910f364e568 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -226,7 +226,6 @@ static int ls_scfg_msi_domains_init(struct ls_scfg_msi *msi_data)
 	msi_data->parent = msi_create_parent_irq_domain(&info, &ls_scfg_msi_parent_ops);
 	if (!msi_data->parent) {
 		dev_err(&msi_data->pdev->dev, "failed to create MSI domain\n");
-		irq_domain_remove(msi_data->parent);
 		return -ENOMEM;
 	}
 
-- 
2.47.2


