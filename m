Return-Path: <linux-kernel+bounces-735837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D3B0944C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6872616A6B9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893B4302CB8;
	Thu, 17 Jul 2025 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhQ+3OYr"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556C2F8C58
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777929; cv=none; b=aJbiNbicsf6d5abZIItX0a21FgErzAvLAtojEwfSE6H5uTpxTVFJrgxtC5A+rD72klGG1F6N4Bc+y4JYgTPNAhqCb8KiEExUm5EJUvPjBdBMWd7jSxNn0rOUpzCBVyrPKprs12iA3iRzhAi8Up/vTbB/zo9kmPXs8H9BkRMYsmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777929; c=relaxed/simple;
	bh=v0xRPM0d/W0ioWRkAdzwXdPFFFyRH3p2ZESsWsaum0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW0X1XdFNxxa0QcutcZ9H7TW8oJDJs2Bs7NbXmvbN0SpGZ3xIcxfCZUllxrWm/gfaUMt5Mdvn6r0Ew70/wAJvZG5FlsoJkG+8ZcpBlIhtpofA/dIwHWyi06jb+gzroNwUTnNKJhHUQAIDsBRFXJxSkgZLvdFWOk0vJV6k3ytduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WhQ+3OYr; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73e57751cd9so387555a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752777927; x=1753382727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yfqueyaH+mhBPzEvPoFlpFsysHFc1vTBvhNztT9Pu68=;
        b=WhQ+3OYravX2K7qeSJK9HHJkbqUvzTuSdRF3tleA6UXALYPE+XUo6pb6+6LqnpKNDP
         02dChTMsY1phH+JvD4GZBB5mbp4NFZ+obJg89tCYEEmcYssYipjDQq6GTtYY4tpsumab
         25moge5PM8kcM7xQ6rh1TFVoS/NA/NUR0LSIRtyxTGWiVJb6xfxN0K13RXz80KmFiiJV
         xCWSO+xDsmMEFm0BPZAW+afvSaGLtX/DdQVYrT+kATlDrPyTFk1ZMaMVRORGTxxOcWpT
         6vbTeh72ZgDAaPN3hcFmBMAjB1rMKeGxznnj7uAmgsgN2rCGmZtK6EqRcKt4lVELyjiG
         2s+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777927; x=1753382727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfqueyaH+mhBPzEvPoFlpFsysHFc1vTBvhNztT9Pu68=;
        b=AIi8O2VYDpKsFTbUWrAHrUZPUhs4jN4de8hwcM7TJUVB16qnK70u5i3kSKKoQBrftC
         X4qfmkrWfUfltzleVCgm6NNN8AWmRXrEEcdVd8Tmp9inM/JTkA6IHQIrhvZL8vqypkXB
         p+Es4qFO5GcrPrD3E7bxb7YA1lyAEuolUvkrcImd6+kvOIcYLsgtUILc/XiiD6gIr8f+
         7kQidtLdb30j31NvBebqdpt2gDMApIxdkRkMOEU85WfALNZQOep6+YsXOmF+PnJlrCpj
         RynYtpxkwk+a2WpvwZPo4rBJPhXULEErKgboJ4TMjPwYqReyTh+sL+388b9QRpPgqgGa
         NQVA==
X-Forwarded-Encrypted: i=1; AJvYcCWGgNkG3Me07CCaYDbJIGGVEWTKmDMmaL4SnTJiGc63Z2Q851+onauevGPWMOuN1dS2tdDG6UyPsooYlJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6lAmQg6ZlmvG/RIzAIHtbcMooKf92stlDUu/VowoK4I0zLEWg
	Cs32SThp84HkfqqLJ0TGexqGsuiFUHucpFNi1S5H7iCKkddpQMb0T5EV3hQwfd4lY959h61mJFZ
	vpH32
X-Gm-Gg: ASbGnctnzaqs49YOWZwmyABFxItcQZwuFIFkVXhRvD+4bQJgIWTk2r+bF/Z8mGLPZQe
	YzeMqXhhgsRgiEe4UQKQzbZnDTbWtiPz/1yKPCmkk0Cem2zCswPryngr6EgRHE7gqj29KoQSAja
	neiQNsgTzy1e9zYBizwooWgtXWbIaJ6ylHxWtBZtem2HvytVMkmL7WEMy7VBZ3DFKOqwhdzZbl5
	bTmRkT7+OjLyubOVzThbLuvgraxbQ7nJ6adaZzPJCpgzuK+32D7uqlRIwsH1onhXb1AQLyO/hrx
	ZTIMHZA1mHu5l94gDC0Su0PwBFdpWrLXTBmenwKE921x3KlofyXFbgtPTXL+x3LJWRb891vNRFJ
	4tH3Jh3l78MrIP0V8qfEYcN7oDDvo4Q==
X-Google-Smtp-Source: AGHT+IEPPSIFQhNfbay+212JW96etw3WPLZiv0nsf1+owv4B4k6WIOAb0+YaPANLkjQNpWntTlrA6Q==
X-Received: by 2002:a05:6808:30a0:b0:41c:4f7:1929 with SMTP id 5614622812f47-41f9886f431mr53285b6e.21.1752777927466;
        Thu, 17 Jul 2025 11:45:27 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1982:bb13:46f1:2e60])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff116872c0sm4690824fac.29.2025.07.17.11.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 11:45:25 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:45:24 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] irqchip/gic-v5: Delete a stray tab
Message-ID: <670bb1dc-7827-4916-84f3-bb46ee408b20@sabinyo.mountain>
References: <cover.1752777667.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752777667.git.dan.carpenter@linaro.org>

This line is indented one tab too far.  Delete the tab.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: no change

 drivers/irqchip/irq-gic-v5-irs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
index f845415f9143..ad1435a858a4 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -568,7 +568,7 @@ static void __init gicv5_irs_init_bases(struct gicv5_irs_chip_data *irs_data,
 			FIELD_PREP(GICV5_IRS_CR1_IST_RA, GICV5_NO_READ_ALLOC)	|
 			FIELD_PREP(GICV5_IRS_CR1_IC, GICV5_NON_CACHE)		|
 			FIELD_PREP(GICV5_IRS_CR1_OC, GICV5_NON_CACHE);
-			irs_data->flags |= IRS_FLAGS_NON_COHERENT;
+		irs_data->flags |= IRS_FLAGS_NON_COHERENT;
 	} else {
 		cr1 = FIELD_PREP(GICV5_IRS_CR1_VPED_WA, GICV5_WRITE_ALLOC)	|
 			FIELD_PREP(GICV5_IRS_CR1_VPED_RA, GICV5_READ_ALLOC)	|
-- 
2.47.2


