Return-Path: <linux-kernel+bounces-732615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF23EB06987
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6C21C2121E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385872C324F;
	Tue, 15 Jul 2025 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZl6S30+"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F4A288C09
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620322; cv=none; b=nBkB22YkcaBqbrvHOtAJER3AVC1Z5b9PfyMCrw826LyxUNNSM/12y8xfFoG/s3N8NQn/HCfku1AoDcySQVKzzwb0rd7dKyK2AU4vqOAiipqYPmg8nSfuvKWBvm0jc+9WcbyFPRXPg8CEfGyltaX5i+6Xy9I3Sru4+Ur+IGNCY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620322; c=relaxed/simple;
	bh=YfJndeDNNKb+DJXXBEqntPkbEm1wX2h/q+7NcWAA8fY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XZHJ0c9ofvQl+cIoZo5qJBLNMSTOdbM/lHp6jcbw8j+8NwPoQl6sQK8KgCSxzibZnf1ihLEqICYJYgQfWxcdlhtxY3YmoxWxClZUbsvdd6Y+NjOc2mbwPlHqA2kY59clIwHpWuiEVceNAZn3Wytr4w8LupSyKaA5JSCLIr23rFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HZl6S30+; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c14138668so2277589a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620316; x=1753225116; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xd3z62QSYDNQGGQDCwZHy5uaazsJb4z6l10vr2/CFsY=;
        b=HZl6S30+ktLwy15UZ9EzV2Zvc0ixJsGWZLmBbQQYDn96YEuFBmJ4wbNQhWmSdyEjuT
         42ueNpfQ1LPvRmq8d6A/vd4XRr2vqEv7hNLC+0sJECUZ8R4GqG8GGsOkW0uD0TXtG74p
         dH1RGc52zY3iy7awz8Y4IrFBM69f4dzc+5r+xfxcT1kLllY8FVUnlq4FxZTm5RCbZljX
         My+UEo9FcwgBI/Cbp2Yxg9dwAvg/Nb9vI040lcwUKj8SDp4BpcpS+Bwa3jU/QVVALhCF
         mbZiiYgh4iQW2a8WM8sZzvdem/vxYhlPTRh+NkrFjSdtfYpy9Ua+Cmefo9fTg/dA9TDQ
         /tPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620316; x=1753225116;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xd3z62QSYDNQGGQDCwZHy5uaazsJb4z6l10vr2/CFsY=;
        b=n1TICIdK4/SuNVeKCUmOn1xfOMw0qgFh1OdaCmGsQFlAffhbRHtoTnW+2t/eQKarj3
         BQcomy2ki2WGk7y4JqdimvKKAVLiFMIgAk0ImL9b9u4UHMSrhtwinRa1cb3MLp6FOaU1
         1IvCq/nXP5zOQ9eOZW0vqxGlf1SAXjF+L8hW/FgrWahSQoq/O8UaG5jDQod1JoliUETS
         iUCPqEQtEM2gkKF7lrVHbfOVF75oBkSyI0udT9hDX+JiP3uE7PzdUOV1bbcAkZEOSd+6
         GRWQ4zllFS9kmVj3RTfQw4A8VswXNY/z6EjXuShcoSvt3u9CZEgdKd78JFYowXeM/q0P
         RZaw==
X-Forwarded-Encrypted: i=1; AJvYcCWiNe/huGYTMuF3xY9Tx+vnYiy73H19hdeOAPb5ueWZD3yumW1tx1jh0lAgLHUt//n7LTw3ic5Fo1Ft6LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIs/E89xGfMgiz0ztGmzIWt8Pzf6ynq1uVhTVXQAMtyslyCW5A
	/b4nYNrzUhEOL8y3zhIHdk193AzqxYhw0W9YfQL8W5DyERBGLoahcVCy3GmXswHhH5E=
X-Gm-Gg: ASbGncs3+R0Qd1bdyRmKxqPK6OwsivlxPHMalCF8uvMyJLLbEXB331o5GrCAonrQaX1
	pRAhn+SojN7m7FvbzKDrFfHkNQXSqL/6mWI5ToZEx8gkRdlLewoQo0M0r9A6cVJffGGcJNg67pD
	KAfzYDuKW+DVdzQwbtVpZ2ep1c9GmG555XAFOxyQFQ0zHzf+7GbZ6JXrf6+rxH3rJpzRabBHFGZ
	Hbr3k/b/Q+PmiGoVZpawhIYM3Dt9evPfRHJYktm7nO8ibXaQLbFdbB4AUrdbHobI4wpp4p7hgSy
	11DidHQGxXtMfO5/14HxogG+aiKN7/P9/vZILLC0maRbciTYiavX+p0vh/1RHbNM8sx6Zhx6ImT
	MlBRpaDyezW9d/7CsyY7xg4Ddn+6lPzTZR2N+1TE=
X-Google-Smtp-Source: AGHT+IEcnMLBH8gdjj/v/BIDdQjlwnkJ7S/ATCiix0YyiZQNd6IC6FrB4fBrsEE6GWebz8GXYY4Ntg==
X-Received: by 2002:a05:6830:6c88:b0:739:fcb4:db1e with SMTP id 46e09a7af769-73e64acf237mr791454a34.20.1752620316602;
        Tue, 15 Jul 2025 15:58:36 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73e63b94769sm368296a34.21.2025.07.15.15.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 15:58:36 -0700 (PDT)
Date: Tue, 15 Jul 2025 17:58:34 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] gpio: viperboard: Unlock on error in
 vprbrd_gpiob_direction_output()
Message-ID: <9e72018c-e46e-4e55-83e4-503da4d022fc@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Unlock before returning if vprbrd_gpiob_setdir() fails.

Fixes: 55e2d1eec110 ("gpio: viperboard: use new GPIO line value setter callbacks")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpio/gpio-viperboard.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-viperboard.c b/drivers/gpio/gpio-viperboard.c
index 3eba77f981d3..e8e906b54d51 100644
--- a/drivers/gpio/gpio-viperboard.c
+++ b/drivers/gpio/gpio-viperboard.c
@@ -378,15 +378,13 @@ static int vprbrd_gpiob_direction_output(struct gpio_chip *chip,
 	gpio->gpiob_out |= (1 << offset);
 
 	mutex_lock(&vb->lock);
-
 	ret = vprbrd_gpiob_setdir(vb, offset, 1);
+	mutex_unlock(&vb->lock);
 	if (ret) {
 		dev_err(chip->parent, "usb error setting pin to output\n");
 		return ret;
 	}
 
-	mutex_unlock(&vb->lock);
-
 	return vprbrd_gpiob_set(chip, offset, value);
 }
 
-- 
2.47.2


