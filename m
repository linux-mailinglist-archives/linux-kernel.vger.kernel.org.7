Return-Path: <linux-kernel+bounces-841155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE1CBB65D5
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 798DC4E6DDA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33F29C351;
	Fri,  3 Oct 2025 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2b0CRHf"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A1258EE1
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483757; cv=none; b=J2hSN61MkMnz3X9EbB1fYjyuRElRrQTacYap/5j2Zt1O36nAOMsRG1IZME3HHk2jQuYXc9GGI7CoMqpdcAfvVLH7FKnh2cfwKmT9Sf4sU9StmA8aLW0aIeaZJJ/jVIVGCXm1CL6WwKq3Blo6hXQ+2BW1tizHZdhMrI0lAEADDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483757; c=relaxed/simple;
	bh=b23ht0r0Mc5jU+nKU4Dq9B+xOZLGyqKkOKJbvuKCbFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOPJeIWozpIN/vFzwGSldIj+9kjVGQ3+ddZzKJ7ac+k7RruDuwQlmj80eQRib04o5wB1pCCFdvkL1xDo6VTRkJID19Fh/PYbgUHhOctN9Fu51WI3a7P1ufZQ8zqk0W93GD8su4T6ad8F46SJBEfMoJxmE0uUvLQjAQ3oYp4U6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F2b0CRHf; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-421b93ee372so933668f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759483754; x=1760088554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVOLfuRBFnDlZv7Y9XU0gN3e9V0PE6p293X+s4H1iGA=;
        b=F2b0CRHfwFbAH+RWIuZ8x0hfRmxEkMGIx5xZvP8EZvV9u0M2EiTdeaeSROoOZn9hEi
         Wc8ka4d8wBx0qJ3zh2JgKJToSQCUu1mJjGvhWJUqrVcUBKSmRtt+uwRaBvlgvRI+L4yO
         we6Bu0bNarBGXtWz/i8s/5unOzEM87zG+mKTKsxqHQCti/JQFNo3HSVpm0FKy8inSLNC
         1PhGx9D2/bsqQR+D1bA4kWBlg+RkY28hpd+UIf7RMVdTyJn63eHuZMA77014Mp4+139t
         5z3/cgtWa6esl3Dy7+3pp7H9d+iA9VlKm0AuI74RE8SLEoFL2cY68WnnwEMqYnOUZc8e
         RJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483754; x=1760088554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVOLfuRBFnDlZv7Y9XU0gN3e9V0PE6p293X+s4H1iGA=;
        b=d/7q7wH7E0oK5UjFoXUV/xjiU3ROI4VGMrOxSLVO5gXHcrK1s2MfASoU0dU6ZvW9ye
         U+VYPwUouLRWHsMlLJkvj7J+0Zragih7f5teQ/8l9WuYYz3odne2y23DNISruTQvZUZn
         GMRGGDbJwDeP8NQdZOeJGEwm5ZT+uwduEjgKYaP5bvjlscvsrSysz5lNUPL6pAR+ToT5
         tJ4Oc2zS1wmj526ZI09VKRgEf1DaifLEw+syiJRaEQnadZSRsvskiU5B9EVQv61dy+mJ
         alQDjGFCLNQt/WTfuSTaJX0pJCy4Ym+oEG7KENdvEr8S+OK5U6bVV3vpHVHc435KXVXz
         0SMw==
X-Forwarded-Encrypted: i=1; AJvYcCUe32DEbsTUA1ShNINcr3NYnxP8Giv3dMAKNA67oDG9PAfcwOkCxIDXDygpO6xn/0+JZX8p590qjweIWho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBDGoIVKkQvvQzncpFPU6C0jxkQxdGni6T3rCayfa5vHsM6iSn
	rl8Q5huaT2HaPX1P+zDd7abWA8UBhtIVX/0IiJ10eBeG3Z0Mt28c2o9lXYWY1FO54Vg=
X-Gm-Gg: ASbGncuRafrm3HPgYm+ILUPEbtxwROVE0OH+giQWtGqir4pZmcKUccs8CaCTVWN8Y0N
	aKRDIbCkS8PbJg2/jVqVtJTMPzNC0Krk6MkDjyW+USCfUwIuKz3GpbZP5cAhzLULDJXjLF+KG+L
	DNezJd6YWPT3uqg09O2MwamwCufJFNYlEpr7vhc84gmnbT6jbDKUxvf+rLVBp2om8nwWtV7G1z3
	gO1rZ9HUTwSl7cxxLj9z+h/pYTx5dsQONiEJLFKqBgGSARA1TBHhDRDBfWj9iTFPc2ax+aHIY1K
	+6w2IB7TJbX8xoajXQ41xvj/HIoRJSaecM6nZH54X5lttPYDdwgWJJkq3sB4ukoMsptIIKJ73CO
	SAd1/VMdX1riCXNwWdtwoTfs2KLnVWXEvHdc2++IKzdn8XwOfE+LMEky9
X-Google-Smtp-Source: AGHT+IGIaObKnhJNC5cX0hzI3j+FcypBs/6mUfToPI7c44aQz/5uQ/CFsJuD9hhr+7yB53BArtceZg==
X-Received: by 2002:a5d:5f47:0:b0:415:7a6c:6a38 with SMTP id ffacd0b85a97d-425671c3bcdmr1424793f8f.59.1759483753631;
        Fri, 03 Oct 2025 02:29:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8a6c3esm7161779f8f.1.2025.10.03.02.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:29:13 -0700 (PDT)
Date: Fri, 3 Oct 2025 12:29:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Chong Qiao <qiaochong@loongson.cn>, Lee Jones <lee@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Corey Minyard <corey@minyard.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mfd: ls2kbmc: Fix an IS_ERR() vs NULL check in probe()
Message-ID: <df80c6d61229eb8f877c3694525c0f97e64a43e8.1759478975.git.dan.carpenter@linaro.org>
References: <cover.1759478975.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759478975.git.dan.carpenter@linaro.org>

The devm_kzalloc() function returns NULL on error so check for that
instead of error pointers.

Fixes: d952bba3fbb5 ("mfd: ls2kbmc: Add Loongson-2K BMC reset function support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mfd/ls2k-bmc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
index e162b3c7c9f8..5f38514fa89e 100644
--- a/drivers/mfd/ls2k-bmc-core.c
+++ b/drivers/mfd/ls2k-bmc-core.c
@@ -469,7 +469,7 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return ret;
 
 	ddata = devm_kzalloc(&dev->dev, sizeof(*ddata), GFP_KERNEL);
-	if (IS_ERR(ddata)) {
+	if (!ddata) {
 		ret = -ENOMEM;
 		goto disable_pci;
 	}
-- 
2.51.0


