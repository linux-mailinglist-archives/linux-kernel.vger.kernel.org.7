Return-Path: <linux-kernel+bounces-841156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B62BB65D8
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27EAC4EB82B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBBC2BE7D1;
	Fri,  3 Oct 2025 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TcR0fpcm"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5AA2BE036
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483765; cv=none; b=cMy8fTms10WTM09u5djSuWrkqVUQtgTaF5OqcvtyiMfdLrVGyxZm5HrdtH+YPS5X5OrwDZMtVHKVSgOrDbyA1lE03z/exOzpZA4KF3S8Icc4I1aREzbL7gl8jzP2KMvB/xZb8lEYAmZRS4jnhCc8vwYR9fAHNx7/1R5SPT3UaHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483765; c=relaxed/simple;
	bh=9KK60N4wFa13mM7zEJCtUUbwe4Cyio02GXt+F+owdus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFVF2R1cwM5jfu97V6FExqVM2Fmhsx7AJbIIwqwsKfPOfkkqQ4nu7WajYwRwwbMj5mnSkeHjHwsptS5isFScWF3cRkCtkITLC6VSyrJDYmdfHO9hYGMo1If3bSUm3aom+5nWDAGlZlZOlJyn4EjW/ebToEdG4lTqlMBBd53d2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TcR0fpcm; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee12807d97so1615604f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759483762; x=1760088562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc+y3Q7Z66QblI6C9bQ4T4zR+bOLr7m+usNLDo1KAu8=;
        b=TcR0fpcmIDQkIquHSfnfb5f5auXoMBc06T16yYUAGXS/c3vnBEwZlkEVcmtpGyR6Gh
         cN6dPyBhtNHW50YaCoEqW7QuSLGHpdYGKOx3hMops4KWgrhRsM6Rqj+P/EjobK3eRapg
         JivPXvfiLA/v9bBD4gZnuoA2NradyVWNl69hr7NOmREdwtewIXnzNeAijAKtGcnQcvD3
         eLsGH3k4ZSdHLvw3HnrimZGxpsGzNi3bCSp82tntSq0x06WumsVSsO11/JZRz/2BslJD
         nRhwgiGcA3AA1VbECz9a1YX0oZowaOI0H+2tsZnwFvEghM4IZQpe9PNuIOnq/U28L/Fv
         LF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483762; x=1760088562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc+y3Q7Z66QblI6C9bQ4T4zR+bOLr7m+usNLDo1KAu8=;
        b=aKbm5i4RLgveRHeWAp8O+i0tE9VIKSvO0R6NfYOlitOTQOGBXEpgtkt2ZMdPpxVabN
         OSh1akZf9qZaebKPZIUHpcquV8eA5UaGZu4sCjuwPs36FOjkHHNrOJf+FcXuFpRBrIls
         VPA1WUExJCCZaZ+AvX0jMym4oKrWYKKN/le0Q7TaJNc2cIFGcIDXXnL0rWcm+UQtvUzd
         WSQ1L7z2TJiwuDPc7qeWA3du3cyM88cZg0Ma2f/MmAnP74Z8FjSnoKTIBobUus9bvHjn
         INWn5Y4HZCxmrH3e3CmDyYYgWslZQ8OVjud6m/hJirMG3HqdWbNLRSTfSxQJbn7LpiSG
         YjDw==
X-Forwarded-Encrypted: i=1; AJvYcCW7KfhGYNMhh2lGMJTn8XTVE01PTp7MKZiBNZZS8YgmDMwD+E+ofJAnhm8uLQ3dijM7OVmxiJDYd0mCyl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvKNqyMoN+6Jn3vt8EGhUCJxkYJ2XgF5rB8AnJHLozuwhp0jta
	TRbZwI8MbjIG63NTRXVu3xZt85EPfHZe0JtO8ebwOZjFFfBz6cxMlWExvuxzvpl/hmrarv2oKwV
	uuxmp
X-Gm-Gg: ASbGncvT0V/mgahrj8QFXZIum16EmAdJN35U/jXOS0wJwsUOO7BHjdZRhM02bXozq67
	rp/8L2Wqn9nSsB+lmW+CoWqnx4E6T+I59Mf9thmVdqaH9PKQbAiWqSO9Q3rMbA82LkjbqhLZ++c
	RaQozdUsA8p86wtPul5UueFScFHtZFDFYFjjjKVsgQIy46I1xFYtCwsv9kIkmKArfyW2bRTsTPH
	hpLhCqZAV4fmd9COPdQsujVDcmzn9OFIl2kHbo7Hy/Vn+2tO2qQ5eAjUxjsLs9IF1uzdbmW7AXu
	ITz7ibQERXKQR+bVq7FNLGxfoxsxy2V5PMMBwq/Cd4KthoGoZrCGHADgZlrfHAflaKQRYpkQYCK
	+/uNTtU7020kPYNMTtyXktYa8yMdxmtY+FHzDpnXkJaOsmQjEywY7QiRKp25V88TIPVASqJPb7D
	S3KA==
X-Google-Smtp-Source: AGHT+IEGJbdVR3GcAdsB8Chc0WaIcfmujZxeb7PDK8Xm5WerDZyBZuCeiXmBbvev21tSrd9qjR+iQw==
X-Received: by 2002:a05:6000:24c6:b0:3ec:dd19:5ab with SMTP id ffacd0b85a97d-425671c2e7cmr1395497f8f.61.1759483762253;
        Fri, 03 Oct 2025 02:29:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8efffasm7072394f8f.41.2025.10.03.02.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:29:21 -0700 (PDT)
Date: Fri, 3 Oct 2025 12:29:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Chong Qiao <qiaochong@loongson.cn>, Lee Jones <lee@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Huacai Chen <chenhuacai@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mfd: ls2kbmc: check for devm_mfd_add_devices() failure
Message-ID: <e3e7cf2cfded48c9fca8bc981c54bbcb7edb9580.1759478975.git.dan.carpenter@linaro.org>
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

Call pci_disable_device() if devm_mfd_add_devices() fails.

Fixes: 0d64f6d1ffe9 ("mfd: ls2kbmc: Introduce Loongson-2K BMC core driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mfd/ls2k-bmc-core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
index 5f38514fa89e..69387dad6661 100644
--- a/drivers/mfd/ls2k-bmc-core.c
+++ b/drivers/mfd/ls2k-bmc-core.c
@@ -495,9 +495,13 @@ static int ls2k_bmc_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		goto disable_pci;
 	}
 
-	return devm_mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
-				    ls2k_bmc_cells, ARRAY_SIZE(ls2k_bmc_cells),
-				    &dev->resource[0], 0, NULL);
+	ret = devm_mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
+				   ls2k_bmc_cells, ARRAY_SIZE(ls2k_bmc_cells),
+				   &dev->resource[0], 0, NULL);
+	if (ret)
+		goto disable_pci;
+
+	return 0;
 
 disable_pci:
 	pci_disable_device(dev);
-- 
2.51.0


