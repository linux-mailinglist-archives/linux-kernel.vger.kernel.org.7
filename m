Return-Path: <linux-kernel+bounces-862478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6EDBF5652
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C11B4F3CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B4A32AAD0;
	Tue, 21 Oct 2025 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sSxrXbZ2"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890BD291C13
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037312; cv=none; b=IUYfFEWapRrC5VklkwP78TUMqGcFe7Bt7DQWaf/LR8WE8cDQoa3Q0K1eMWBflAtANoisBmOwi0f63xNX9R8tq/d0d0FWb+AwtLB1addONpnGuQe7brlWHBNE82XfLvgHUqTjzxKVxP0dMKWE9Jo9YAV1WbY+0H1wt/ukN2VXzeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037312; c=relaxed/simple;
	bh=szz9PjhinWlosFCtfgUMabH2tGBOEZwddGuYY8agzcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxaR1gt3H8cOvwuVk7wWhq2iXupECKP7EKASS9ZFAi822qkXh8oikdbQLMFqdcTDTyVNw3z6jHQ0xODTXidHtQGeV59KKIFojDqk59JzUg8NqIvdHiKARVycdBbTtdCOsKFA7qetfnlpxSxDB02zCOUSC0Ou7GZ02HJ8FXr27sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sSxrXbZ2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4711810948aso36046915e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761037309; x=1761642109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TeCc4wabnDNTUm28psVc6W31FsugP3f390k1jrgAp4=;
        b=sSxrXbZ2mb47J6V5a61JL4qnnH536vvl0WDsEo8lrUl0tuHYYCQj/Vpg6Cj+gVHUJh
         bK5eX9+7zuLv3/6CPcrwOPrcIcDF7Aw0DNAp4LQ7eciq4vDvnwZo8iTf1KpddjOi+kpi
         rvx2oEo7A8/c5sOnwhZmUrv06FeV5GjpFrVKke8vXISsDdB0ZDbuwCSA5MDEN5S5/rfr
         jgZ5x7McOryMlIUmnY5wJzMHFP/D805qAH5jm/SANGU0ALmNi6Pxq+YBsPhi00xAEIUx
         MDipLRt/5xJ0qnbqT9lWaV2J1LiHCG+bNJZYs5cTfgeEa7anBFiTRM9Q35o9ykDL/rCF
         RdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761037309; x=1761642109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TeCc4wabnDNTUm28psVc6W31FsugP3f390k1jrgAp4=;
        b=cvzeeAOASH9r9Etagcfb0zym647b/qOQ/C83Yr9UPk6wMrTsLEIQMYgReYVTX7hnU5
         zZNPP5osnhw5kSNgPUgOL4jRHaNu5spcaE+vKjHO7BRD3l1rdIZF7KPZzc0JI2fm81eo
         Mvapq4xXkKjT+ToDdF5qdASRf17yD61ZoOERbAfWmX7ZiLxl/CWT0E63L6h0oNfp5GLe
         EVMFTGqWcAw1P5i16f9Qwz4YLI+pQqLiCR8/1cpPIRKR56p/uH7MXPM/itXMWJBuXAg0
         CZSHOsjmh3TYUaRAQwTieOWM7iQ69O/q1TVZZNDdyzoLesY1iEzi9TGUXb7s0VyGOKRb
         ohGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVliFWvnA2J6RCHtWWRkZF5Jwly6GNNtLay0oOHrB3FV4O2ljxa3ZG8bF4KDjN3izC8RRVOhwOB9fVnlC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYcsjXlwO6jAetvBoibQLpzDHhOSg3t49QzcpKPU7VtSjSEA7o
	gW87ebkONqTuux0cH0IqWBKw4MP6TvfagaNGZqe3JgfCA2esaSqr0hYt48H/c2KvuD0=
X-Gm-Gg: ASbGncsa3qzNOTANWf1wiRNAcB7SE4sZyN7Tz0qWGM7oKmKpjb+NORnbPJd/GNvJeIl
	du5LXUGGK4z4Rm6Jc/IxgGLiHveoNfWl9hN41z+2S48xW62tjE7fv2aY3+ARw7DTEaKoXZe0zlb
	8onLh/+69Jt2CalFx6o/T/WzhJ3D/3lU/q2tJHgPiiOTBLwv8qXiB1bYtUzirNf17Lx5d4eGMr0
	B6VA/TickkBrny+UWGGIxIdh7ZuEiqJ8e20BbgJIKmp0Y/5k3XreQmRr1I0Juz6kQoc76NUcAWG
	UVmwNpqHDHWV8HUD9H+LwcSe+ufivtQzKZeDmD7bSsP0ukT+1TqM4e56xptpG8g4w4js25NI9QU
	xRtw8aWHe8612C+oNIrEMx7qN/1Vq10vnV16iu7GzRJu8O7kRvgqd2baOy2PXqbJ0erLFETpHXo
	L+Xq39N3Nkp+5Dk9gzTYLkPoM=
X-Google-Smtp-Source: AGHT+IHMsE5J6Bs+G5AtSF92sEFlNjDdhFMO6owKbMYPxNmFN9+p2p/mx4kaXCI9o6w10dVqttxFpw==
X-Received: by 2002:a05:600c:154b:b0:46f:b42e:edcd with SMTP id 5b1f17b1804b1-47117925d59mr91801885e9.38.1761037308222;
        Tue, 21 Oct 2025 02:01:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2979:9ff9:6677:97c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d972sm191369065e9.1.2025.10.21.02.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:01:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: latch: remove unneeded include
Date: Tue, 21 Oct 2025 11:01:43 +0200
Message-ID: <176103730244.11215.11595127566271255643.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015151605.71203-1-brgl@bgdev.pl>
References: <20251015151605.71203-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 15 Oct 2025 17:16:05 +0200, Bartosz Golaszewski wrote:
> This driver no longer uses any GPIOLIB internal symbols. We can drop the
> gpiolib.h include.
> 
> 

Applied, thanks!

[1/1] gpio: latch: remove unneeded include
      https://git.kernel.org/brgl/linux/c/d09ec3dc7fea7b2f5f5a159470d43cced39e994d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

