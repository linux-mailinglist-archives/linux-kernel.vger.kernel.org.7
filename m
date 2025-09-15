Return-Path: <linux-kernel+bounces-816128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8DFB56FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B803A45BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C8274B22;
	Mon, 15 Sep 2025 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rjuPvkPx"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514D2749DA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757915407; cv=none; b=Y2U6W36IxYo3I2xqYrFxMk63Dsm09z9tdLWnzhzhDAOrVp4Jx84J11QifiHUCaic8+/Zv9ZJalidpMuQAftWegkuk/nCY65WAfSWb96T7pkXKN8BuknUDpgyZJAgXL09Dvmd0GKVSEUVq+KEPqMMjaN66xMYJ1zt5jUfDYY8W0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757915407; c=relaxed/simple;
	bh=fiwgx8MAD2XVYzvxjkvb3XQ/m9LZS2p8t8MWQAfOLm8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AymSdrdZIW1e5mh+JJs9T+xlPZSluixR0gZ7rpeDG2An4PmD4KpQ5MQm/fb0BDZzSHhWy4+qNSO1bOqr5acSAKjuQvyHtIyLiQKFTnaeL0jzEvP95qPZ9jpzfAtAe/VNV4opSBR4LhBuwF/ouZ3J6w9A5hILgTWMR5LfuK7oUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rjuPvkPx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f29d2357aso7139925e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 22:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757915403; x=1758520203; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/wBl0xLLFWVBpKxMI9aJF68zcNMG/DejRgIpzGZk0I=;
        b=rjuPvkPxUiqWiJaP8vf/aMiepBOJEAd0AvORKY2TuO0BPT9Lkxd73FMpD6F6QYfJu0
         AdQTW7ozH9XSBhaPmcIyo1jnnVMSzk7ZV7+Wxw3AWy1OEeo5dxElTtDAosnGpZVde6Xv
         v2uCnraqcmGtZtB/heNWDONqlxK3+HvJuzKxVxNVm8q5lRkTk2jcsnqCpZSEQnV7VKmE
         WU+gYkPkim2pSV7vqL/OSZTLuU/Wpy1zQK0KD/GGSAVbWevEz1hC89ajfeT1YxD16/2Y
         M9IONNcBVeAH6bBKQpsVTmrDkJUZPUCOFAv/sL7abOJ8Hl9uTDrH1832TYyqM6u+NvRb
         63kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757915403; x=1758520203;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/wBl0xLLFWVBpKxMI9aJF68zcNMG/DejRgIpzGZk0I=;
        b=jrheeZtjQ0S8cDqLKuNuOMajXlVma+WCmsx5Mowzb3AcpbW1Roh4FJI87/rJ6FdpCH
         HiWNvFZKnWkad+q/b2yuR6DUTslu58Gb6S9RyUusng4a3ckfsgpenxDVZ1znhLaZL2cG
         BJE3OyocmdjOTndOW1/lqwB5E46+b0PUvRXua9ojwN4fdNFCiVh/qd+Js6v47dQQhUUk
         wxFhSuoNzqXPq854fbI2JQJrpAAxDiW4Nlh5c4Dq6FwDmaGtBpx70Q/yfjnloGE50G5B
         zWd22Bg/pdsuNUqWl8mnquEBSjM+QyvS346YH6MDagzoZ9P7FxdnIWs8tujz4VauZjXS
         Gtcw==
X-Forwarded-Encrypted: i=1; AJvYcCU5vRUYgqRZaftQgxhycLaA28L7YS93KuuYna0EPiKowvoSK4wZt1fUGCmhV3rmmHSfNJmdHa4f/pI21ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSroRSg6i8ayiLcQfhzpVbjlJFbpEjUk+t5kclPbV4TQ0i1DIP
	WPr3zY9GzDNpdHbgJJkLwZRriGRZ1KOZaVKi5UtbLPRwo1bTf654DH1FmHEZlY0p6Pg=
X-Gm-Gg: ASbGnctf0HLKM5OUZ6RtauxhELs0rXUJFtD6yDLB5jLfdzhCAzsJI6LTavmlKQ6SJCj
	3r1xsL0UqOB24Br7byJU8eXKhUbI65myyEW4ozoQaauIehOFzy7TAjzCaP/+d5yiD3/KM0kkX+p
	Bb6EghXiNxoJ7IhKRU9E/6yTONRSaqsqEroBnUEezbbuedcCPSbKRxHJS2AJvbEh+KAzJkuRALL
	fQt2CCHfjo8HOUTu8lpte8m5O9dBb2h10xd49APrDMqhNGsgapxHf8cdQmHADFA01T5zOwEF16t
	mjUiIrVzLGd9dt1cWFkQBk6MgG4NodKpTQFXNqPuUE2h0Vo/BoHYuPW6XuJwGdaqtN4gRoCwKrF
	WlyQ9rHJtH21LsxjNDjNTBQVKmi29c8NWLDI6vPml+rocv/0B
X-Google-Smtp-Source: AGHT+IFRoam51kLCQlognqaLnDSeb4W/WyS/huGGcdNg8zu0xDnWYvxEcLms+5oh6bPzNGICjmp+CQ==
X-Received: by 2002:a05:600c:58c8:b0:45d:d88b:cca with SMTP id 5b1f17b1804b1-45f211cb94dmr78596335e9.1.1757915403521;
        Sun, 14 Sep 2025 22:50:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e9996f384bsm5624675f8f.56.2025.09.14.22.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 22:50:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 08:49:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Feng Chen <feng.chen@amlogic.com>
Cc: Liang Yang <liang.yang@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: amlogic: Fix some error checking in
 aml_sfc_dma_buffer_setup()
Message-ID: <aMepB7E95kwYvx0o@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There was supposed to be a "ret = " assignment here but it was
accidentally left off so the error checking doesn't work.

Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-amlogic-spifc-a4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index 4ca8e82fdc67..4338d00e56a6 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -420,7 +420,7 @@ static int aml_sfc_dma_buffer_setup(struct aml_sfc *sfc, void *databuf,
 		goto out_map_data;
 
 	cmd = CMD_DATA_ADDRH(sfc->daddr);
-	regmap_write(sfc->regmap_base, SFC_CMD, cmd);
+	ret = regmap_write(sfc->regmap_base, SFC_CMD, cmd);
 	if (ret)
 		goto out_map_data;
 
-- 
2.51.0


