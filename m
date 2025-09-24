Return-Path: <linux-kernel+bounces-830437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B6DB99A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE15A3A53DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B582FF672;
	Wed, 24 Sep 2025 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m4C0wd8K"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFDF2FF153
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714698; cv=none; b=tjz04vmONtdVSH2l28wfqO5/29wCbeGTs+wG5AAZOprMfbBUZ94HMzamsEo5LBWx3yeWHrxMhTdjDs6rkYqREg5CeL76j5q0mXQ6sMNX6CxoV0P0RJiYRmLraw2P4H7FB9xulfsfPpAikZTZ2lthtq/hUySS88U1gHjIrRkzwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714698; c=relaxed/simple;
	bh=m9udRDyHRd7Rsj/9wBYHP6INEkJoGlz+LmtBxxlGfAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENZ8H00e2MV72TWwjNWq/tbCECHX7qa2y2zK022vB31lOTQdCNWfTB0JTOO9Yc/h/buqOU0X4qS8/iMHd0ML42Ud9o08gg4N4Nx37A5dHi2+tkgvGQZUOmrRSUm1ndzr9+Em3pqYkedmg4Xr+Pzk1zBSmOZjkGHBoVkr9cBOYDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m4C0wd8K; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so6203275f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758714694; x=1759319494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MouZgkYvZZ6gSHXSJjdKF/cB6pNj5ClHepYp0r7Pvfk=;
        b=m4C0wd8KjFJK+M3u468X9LiY1yPSM334O4lBdhJpP+C1jN5dfia+c77Lhm8WzfIagQ
         yFZHzHyPRRzi6sJ3y71E0c5nHLeeHzGFjHBbpDhmx8z75Y8mBRjXa7r4DHr7tWol85gN
         JKGX0IOOTyYdbRqnbP5h3yCTUQrzqjsp1Tt7msH1PCpDQIzougychfdYgd1vIQUX5J+U
         5qGwCaDqhHyfnN4+I4aE1ouz4bNBrvCfz4vLvefuNZoWJGzLn3y4XzveojTwLI8wsuiJ
         GLOOkyM2WvegA8Cdm40EImR5qdc9ciLyZ5C6b2RqyQwNAbRZvvtsgp9VdY2yyrcrx0eT
         KMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714694; x=1759319494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MouZgkYvZZ6gSHXSJjdKF/cB6pNj5ClHepYp0r7Pvfk=;
        b=kDMK1SjaK+t2OgD8cb2OP//ryDHr/ipNYDz7miEegS845/EuCwIopja+EJmcIeMU9n
         MnGlTzQ9KohAITx7Qh0i8/raxI5/XULUqziTWdeEpcL1wM3AQteeMrYYoSbDKBpeQkPA
         cZgoeeO5T4u6dDtTUKakmkattV/SigUtn/6abjs3/qSmQ0fWsVJXnYvrQuNJLcI/KlQf
         9sQiXXrsmgL3yo+HexMmfMYqO+j+eLBJOcl3RDbT3EtNqDfhksuGZQh0JfCIGmHwRnZ3
         91U4fO+3RfNx0682mg/HaO0B/IMeJTo0tm6RJ/bHI62/zlZno8NhGBBHGHHvEovB4O3V
         Qa6w==
X-Forwarded-Encrypted: i=1; AJvYcCVpAraYd6AL+c3Q/GTe1mhkKzzi1jEU3mi+MuUBTPXABT+XmjU5XOFWDUGpLeHqlT8jB0P8jA7t2Ie8Hcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycVlp8J0lPV7AgpGYR9lEowvTX7LfX80HJm49qM2iCE7cfYykq
	+ypM89xSstn78G2/MXKVgjAr9kSjAiZswKljxNcFBEYLBqy8n7nhQf5Ec5ZNXOBpXaY=
X-Gm-Gg: ASbGncsus2SxZtfL7fSJV4Pe9WtfBytl3tceSkHkgYa8+Rz5q9pJEAljnYoTdCwsGVx
	xt9bmpyX2gYxAcdnwqFnsWAMDJ4dCzd90vvYMbhEiMVuRBIr5EW5fKMDD3luBokl6hz/8AWngFu
	2LqtvBQ2e2o1+epRBsg5E81xgcISyufRBZlL/eSv0N+ZXnQzOJgrQdJdl4PpOnV1IyGy//J2JJf
	KPnSL4UUGX92rkEcYqWnEdLnbtxKrlyy/mOBnyx7MCmNxNGKPRvjaLINL/d7IA4h4gi9ByGngoJ
	LajGj7OeahI13ElnrtuCg3+DW4dRY0rVBykUYnXVZEkJ/iWzjV0AD5KDTjGAJXL8esydOqiewpZ
	kK0Oq4pmi1UwxJYKS2FiuI6Vv
X-Google-Smtp-Source: AGHT+IFfNfkyehlN0G3gahSkVgCCL0++WuyaWaeTwKNXMYm5/4Z59W78vrGvVpgP2hu8ixgBlu3VmQ==
X-Received: by 2002:a5d:5f82:0:b0:3f5:453:77ea with SMTP id ffacd0b85a97d-405cc9ed248mr5013363f8f.58.1758714693860;
        Wed, 24 Sep 2025 04:51:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1729:c9b6:7a46:b4a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31ea3sm28329915e9.12.2025.09.24.04.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:51:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] gpio: generic: rename BGPIOF_ flags and move them to the generic.h header
Date: Wed, 24 Sep 2025 13:51:32 +0200
Message-ID: <175871466164.30561.3331024743245978268.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250917-gpio-generic-flags-v1-0-69f51fee8c89@linaro.org>
References: <20250917-gpio-generic-flags-v1-0-69f51fee8c89@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 17 Sep 2025 10:54:04 +0200, Bartosz Golaszewski wrote:
> This is a follow-up to the conversion of gpio-mmio users to the
> modernized API: we globally rename the flags called previously BGPIOF_
> to use the new prefix matching the gpio_generic naming convention and
> move them to linux/gpio/generic.h.
> 
> Linus: if you don't mind: please Ack the pinctrl changes as they
> obviously all need to go in together through the GPIO tree.
> 
> [...]

I'm queueing this for v6.18 in order to send the entire complete rework
for the upcoming merge window.

[1/2] gpio: generic: rename BGPIOF_ flags to GPIO_GENERIC_
      https://git.kernel.org/brgl/linux/c/63a93d25bcce12580af6dbbaa4d9f3ccd0c9c4d8
[2/2] gpio: generic: move GPIO_GENERIC_ flags to the correct header
      https://git.kernel.org/brgl/linux/c/3fda0cd8fa3b19aa1bb75d55983e02321b0aaf0c

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

