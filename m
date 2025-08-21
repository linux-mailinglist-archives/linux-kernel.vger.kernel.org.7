Return-Path: <linux-kernel+bounces-779738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B183B2F7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E0417A9433
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6D41DB34C;
	Thu, 21 Aug 2025 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8wA/ZZ9"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA1D7080E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779426; cv=none; b=U6m9UuHVNoRUgNcUFdMRZgA7KQYzTJvGl7dtrAE6Ivh5sZj/dRPwidu2H7KxMPiQPqCH4mmYeDYtjSyTmXPf9nn0f+Ys1EOum5Dq6Jfp+8vY9hlwItof/s6ERMMFzmFXnaOgplwJbPaWSGKZQs/b9a/rpeGrFXAT9riMkE6T1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779426; c=relaxed/simple;
	bh=uTIRabS6T2mGqxsTk0ErX3psVDv4gnaGVnSGbRpQFbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XC6YUYYPY87ysQoADDsO3V9oBK9BzXl5YtXCDfeLqNrsQQDVl54pDYPo6zBryRIVD+QHZ3Fo0oKsXPxmbsLMGmJEOp59XXt6DB/k2riO+uv2Z81nIN0DL+Hfaq4HcQqA8ALT9tzfxlAPkx57x6Vb8lBnKC+FsocBUL8LXJ3UMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q8wA/ZZ9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1abf5466so6287955e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755779423; x=1756384223; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFauEFqH4elwkI9ughIf+IrmIT0Pv7YSC5PWnrBVGQc=;
        b=Q8wA/ZZ9TS8dwha2JNIFMZsqyoBMbJrZMGWPJ8qpgBLCuqJ2l/W64Q5u4Q9j7sqN8M
         vkvbjhZNB1MQUg1yQhlPAsvjxpVhrmKgXKCH2qPIDxWibV5/NZe2dJnRbFACnTECL618
         Sm4/HpiVhgwjS1MT5F0ej/4mNXTJFTOnKKtnEguP4x5R4Skcdnl/0u8HcrIjxSudcOxN
         otW8pjpgU0h+DEMGLrglzZ4es4OS/4ToQeCEeV2/tlKJPFyHLqPB5JiEMli7pUAmrf3+
         CMot1we+IzVFLrmZrArzG0aJ21KB04LTyqZtt3xEi4sw4x562+2YRU0U5ZC6DyqeQFNd
         6Jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779423; x=1756384223;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFauEFqH4elwkI9ughIf+IrmIT0Pv7YSC5PWnrBVGQc=;
        b=TL/Z6CeiZKYCDg+v1OVquyxSfEErbm4FZdZSXT5dT8TRf3TMNB93FqGLGZEtFaEZuf
         MJDmNF+bzTbS/ADxkZk1frwXx2c9HDzQ/KqYKLq6+zUefaZDQiHsZJrH0N7aVeprm3mJ
         neUQYyn8wmZmPq/wEXWhuekrBLraCsLDqz5vAuyyzafrcd7a6wXeHOIDopou+V5j6MvL
         /lrGbY6J2c6h7pfh1Zl0pXML5IDPUIkboINuILHwQAeYqk3neg+St5nAeJe0IL6mL3uk
         wUeDXmJg5wSGJZD3fo7gllDXiRExmVQ/XjIiq+RnlC7shHNOfGqz6GyizjTnabh7W3b6
         eA5A==
X-Forwarded-Encrypted: i=1; AJvYcCXQrIOiT+MIOs9AAgdDun1mGaEIGzsehVEmNpty51pj8y5rPMN/NdFl0kHA0rH+C2DsBJwOc71Jg3bUnDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiSH/vLYXOMP+hmldx8Ia6LHVYyEW0SQoR6Bcpdg66SuVL6AwP
	plZySkEY53LdQh/a4WI7NqL7xn4lJ50oGkDCqyKbX7AQ3b3pYYG/R2zAAJgWPEADsEA=
X-Gm-Gg: ASbGncv6lTGtUSjXzFdHN9QVwbbsV8NuWvsmO+g4AxTukjnoPEh0PA5/BU5MPxDdS4i
	LPozPr40q36tP/jfKWPkQm+0XT6u0FK7kmMldCfwMskliakMQSvntUbYruQny9eRPpx8bg6LRoq
	xBeYodw0nccJZM/iltinV92vEgNGaiUKi8RelIIYn386u6OFqKopZUyn60mxpIp+90P9M+cXcrV
	b3s8UI1lAbH1prnFqVeasnBXNdwFbm2RmPxTCSpisdqjcZDKt6gQLBPZAFM8BF4ht40+6B/UdCi
	BGV8BUf6J7KmGb6kkTZeGCAqVcNN2YXS/TwS1JL8X39hruwIH9Z4bWfoWwTXWERriW1DR5zu+A+
	4v0meQPWxHjFq2Z29GLm8485NO+pD7EXBWOkA8A==
X-Google-Smtp-Source: AGHT+IEWBahCm/HEzs2ekfN68QoHcjk05inm/vBZ5gGcwgu+SVeuuRQ6tuDqkyo9Irqu2mxhLByrvA==
X-Received: by 2002:a05:600c:3592:b0:453:6c45:ce14 with SMTP id 5b1f17b1804b1-45b4d8deab0mr21551295e9.4.1755779423385;
        Thu, 21 Aug 2025 05:30:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4db1b7b3sm29415745e9.4.2025.08.21.05.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:30:22 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:30:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] accel/rocket: Fix some error checking in
 rocket_core_init()
Message-ID: <aKcRW6fsRP_o5C_y@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The problem is that pm_runtime_get_sync() can return 1 on success so
checking for zero doesn't work.  Use the pm_runtime_resume_and_get()
function instead.  The pm_runtime_resume_and_get() function does
additional cleanup as well so that's a bonus as well.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/accel/rocket/rocket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 72fb5e5798fa..abe7719c1db4 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -74,7 +74,7 @@ int rocket_core_init(struct rocket_core *core)
 
 	pm_runtime_enable(dev);
 
-	err = pm_runtime_get_sync(dev);
+	err = pm_runtime_resume_and_get(dev);
 	if (err) {
 		rocket_job_fini(core);
 		return err;
-- 
2.47.2


