Return-Path: <linux-kernel+bounces-822179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C44B833AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6254A2B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F6B2DFF1D;
	Thu, 18 Sep 2025 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMBaM5eC"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68225275AFE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178674; cv=none; b=U3eEAbBVqQYBXVCzGTnGD24WVhCtAslGiL9S1bXVPmNFvcMvuGTYwwxq2vzaBZuXj0dXJ85EdzxovoypJ71XktBiqlZYqqLq8JGxuzHnklxi0vMWNZD9A9rY5bif8WVTxezs/go8cDRGWqiFkYAJ7tXmXs9QOhjf1XWLkBPhD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178674; c=relaxed/simple;
	bh=Pj7C6lSwNgTZXom9kMKSotto7rqPi805M8krrGWhdZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SIu/2kGN912F8uzwjvTERVZKzrtmSpGx9ohjP+xPzSQa+Q06ZFqbZBI2elh2ZkpYZQPg51ghSn+NY4uR+s7LX/ucWNHc60SIl6dZgTC+gkucNj2raJykQMSHXzsafbYm37YXk8USBZnIW1vBO0x9qhfecFxMuUgz+VZspvsOYfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IMBaM5eC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45ed646b656so5160935e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758178671; x=1758783471; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9/nMa0PtV43rgQWcYDMB+PP5kWaFcHHQhI+qUmHdeuI=;
        b=IMBaM5eCXXkkaM5X/iTM2RP4xSLJSNls5MHlyrEHIEBlRPTxmT1XNvFy5W4Fb1ZeSO
         n9LLFzZb5EJ3uZSxQReC1uf/hf59lpY49SWHfr1dYy7HPP/0FEgvL0BF1tfg7YxHiyHD
         encfkTYbZlU/EMfUcVqI/4fRheExYqHp4HTQmTrTiB+432BWCSc7AC+Kmn5nsQKYv+uL
         DHS7iEMr20ik25cyaw1qZhMxBQRKMtUwYgW33uQOR+VvJi+wM6c6Vo8yo0v+IVEjcmTQ
         13ofajq84GUhImII2ZgrMGaEGz9Y61JsLeIxulXE6xnvP8Jrrb6QzZ3CNHzJD+rLiFL8
         ayzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178671; x=1758783471;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/nMa0PtV43rgQWcYDMB+PP5kWaFcHHQhI+qUmHdeuI=;
        b=uqLbHsL7Vv5rKTxff30+kFzxc9/p7vUPwto/cpK6RMMvpWiFcY3nDwV12WBtZ9MP5z
         ObYA1jbWSiSGb9kn9QIE54Ojp+QFTNbrdP//aEIBDDTtZpioFu7mKEytS8lej3S5diuw
         URFySExf0TLCRXVbe4AoUELn/FEVIghXd4Y8OccgsWyERNANFYMlM/pmq/mQ77nc8tom
         PCg1jT0mBu/yo0ybD24O82LUL7sduCHcus+nVuTG2B95TTi/W0YkQeKU3zYUfO3uB1hf
         RQHSOK0WHx0c9/4iXmRdtwOhm/GscIO8hkXtIqimBju9CT9UK2oxmy55p0HF8qAC4pwZ
         h8JA==
X-Forwarded-Encrypted: i=1; AJvYcCWIl8vqpqPsteRAUR2Bscj87QWxHUDDR+ks4A+lk74LV19hnbH+qZOMUJnUL0eLKrpvodqn/oHl0Q5uvuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa34WiW9WzgHGTkHxR39QKQ1mLEqCaLf2cWDSWgqdZWauZSwsN
	78WQ/eZnkj3mA8otw4mLsUPYanq4aW7y9gEuXiKlrSsDrk4w/JDwEpyXfhZ4VImJXXQ=
X-Gm-Gg: ASbGncuP9SglI6ie9sGmj2Lv7RyHt9Fjngj4hlrsbqVyX/BLcQ43vDtR4dfi4lZbFIg
	pYueo1kpAaRRXlrlxK6TE1hpeUNY28pcvTo/GnE2wtvcJD14NY+mqufIkghhnIa83zC7jiHY5yv
	9qa1NC1GZDK4pLkJ9mi3jiWQNbQncSjwvURg1YL/yJUVINYaty+xhLTadUM/Ea2zCYb99fAtte5
	5PTp1eIBj+wf89Jc8gPrVOvlF9y0XiKSYYbh03BUDFe8XNQi+ybJbaiMD7XybNRPVVZ/FkGf83t
	RzsLaRtf8s6395wxBcAuXhHa47xRzRZnPUj8ja30beb2q+mxKgjjLSmdPX7mXufTqaqyynOIQu9
	EteawGVzt4O6hC1pLSBub70W1s44bKOgaJgiY80u5ZCCP6g==
X-Google-Smtp-Source: AGHT+IGwR8k7r0TQYAu3JvMmJhIKVXCkY8cUsMc5qCPfSU/SkaC0D9hFbJ3u/9HM/gyc79LjqswdEw==
X-Received: by 2002:a05:600c:190e:b0:45b:47e1:ef68 with SMTP id 5b1f17b1804b1-462076af168mr36954925e9.35.1758178670715;
        Wed, 17 Sep 2025 23:57:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45f325c3c29sm56657115e9.3.2025.09.17.23.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 23:57:50 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:57:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] EDAC/versalnet: Fix error code in probe()
Message-ID: <aMuta8vbLUaP_C-R@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code returns success if devm_kzalloc() fails.  Return -ENOMEM
instead.

Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/edac/versalnet_edac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 66714fffa591..7c5db8bf0595 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -888,8 +888,10 @@ static int mc_probe(struct platform_device *pdev)
 	}
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	if (!priv) {
+		rc = -ENOMEM;
 		goto err_alloc;
+	}
 
 	amd_rpmsg_id_table[0].driver_data = (kernel_ulong_t)priv;
 
-- 
2.51.0


