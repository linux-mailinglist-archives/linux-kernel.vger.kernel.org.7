Return-Path: <linux-kernel+bounces-860338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874EEBEFE80
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366ED189D7DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F972EB876;
	Mon, 20 Oct 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Y15tKSXK"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70D2EB85E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948690; cv=none; b=Od9uHng+sRv/zgtJMf6RH5A80e/n0h0b83gRVxJRHYDwvjvMtm7ypsT8eK66PtLnLYgYYQd/Tb9PnOrKe1j9sW4W/xPqhPLakowQx0UObW7NSfH2M67Wd+VVKPnjNdKgHZo3loZBS8PudHc/FmStkJS4A6dCQ1zeHpPJgrQWcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948690; c=relaxed/simple;
	bh=9zlHdu1C0OX3LQKq/csViY4KOIK1A0RLur/kX4QaQsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMCtTZmnyk5fvpA9Oee6FrXnSd2p8MaZuxF8GwkTdCKhELoQDVVuCd0LjGxAShB2Y3Aabk5Hd4bLgIV8WRRXW7DRvCrCV3YGkJ2PjPl0U3yK/1NEwaJyGFjT2kMPb9lk/bolmguVtXOSJFKHNUKjKHxpFbc4rz382drnu0vA5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Y15tKSXK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47114a40161so44413625e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760948687; x=1761553487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vW/AkTk8WlPjo3na4ACa1EYleQcJKdyDIWqp1NdXgKU=;
        b=Y15tKSXKDmQyX3VZJFUu8f1iVTx6lnd0y0zmsso2ucoAZu6OMaP2ixqT/IZC8e1Kpn
         tTOSdqS0l797ygAn6hUa9/VO27AXNTYZE+dH8458B5QOvykC8OYtE/FCPhKOP9qcyeLC
         ZUrhI/fkVY04tErNeJ1+bk/XomgWvE+HY2+4UBPrAVHNdbrYxSjLhEk7KAQYaWuSpoH5
         7v44T9vXbs+RRQqVMwH0qc8J+aJ3lXVSEuMOkCW1LN5Z+5PvPxNmrvAuVDLM2sQVBoIn
         UiyyP0cCYmYkciyOLx1jL6QlJuoS8+8KyyzGDkamE7aV7H2MFwcoty+2r8miH+CrRb0u
         xFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948687; x=1761553487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vW/AkTk8WlPjo3na4ACa1EYleQcJKdyDIWqp1NdXgKU=;
        b=wd4K5agDO72h9EmwA0pUkvcuUQNWV+mjKapdnToDpB7PbmnR6K3tIMqy6V4wYdLHL2
         06NdCtSC+rYZ/P0wb3QCT7HWQMN4z9POhP7Mj7LabG3ZD2bxY+9JJ7o0915t3zkTQ5UO
         NCpUnFztGETxBf/nIj4NnOu/kK74sKTeMkYB7UQFxcV5m2v0tMULXMdITP1CUOoYaULC
         C11jfgCUIzWMFOSpas9h1QlqnmBLO70MC8gz1OtdlUjBXaEOZql6dbtEJchjl2DuDcRU
         C0oIBypEFt5pgaAOC3aZzfP++AVLmFmg2upydl7A7SQUxH/0jqI9C+ivG9ebnIXSdgCe
         +VNg==
X-Forwarded-Encrypted: i=1; AJvYcCV9bu5Vpn1mcJiupaG1CunwfSBx0jdhC5rJc7btt8bfYtWd3/Q2+OYyTQMyzAJW2q5DGCCfLLAprD9C+/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzepE7Zp72zcawgb3CD8yHy7/Rl20cTXZSjZgQ1zoRXFtfvQKaw
	/VPE/i3OCgCRXzCm70NADABvqn0/wThN+4C+dHtv2v+8zB8W9PjkU+QDaEyLS6jGFdA=
X-Gm-Gg: ASbGncuQ+eW4bjUGZP33HEKT3+KvLnETZvqH+9QmLFVTH4vte+Tf8YELPl/ssDmLZpC
	xnNnmHd5Gy1kEESDw9zcv9LU2+o+KbU8mVJ8E6x3BlF518WEY+/KEFiHkB9pPFehTj7Ubq01Xr6
	fBaKc0QvsT/aUJzLJk8doT2h2xVsGioAmaPCflPZU4t7R5uV2nV5rtZ/qU2HawcPe+NpY557Hwt
	s/3111i4pHvp7bmNjQRWnowtpHvwCkC9TMaJdRGlyKK5PsZ/NmZCsdkuSFlTaAt8qSPQ0PXXIty
	vqrabcXzb7DLl9mpnvuOhHIR7b841Q7kIb6j1ai6S4OG01Q/zGFNnuPqorY3pqpV9X8mn6IjknB
	NzGirBQMQdZgf+M0RQrEvbixJQQF8LjsQFDgHc+EGIPjqsUziOJ4qq6+t6tHUIArQqMMZLRH0mW
	PR
X-Google-Smtp-Source: AGHT+IElbGLyhlp/1ybVdhj0rXNPZOg5gvo0dz1RPUfJES3/ZAsbvfhG1ocMD7SptwzEZ+DrjQdnHg==
X-Received: by 2002:a05:600c:3512:b0:46e:5b74:4858 with SMTP id 5b1f17b1804b1-47117877122mr69462225e9.13.1760948686986;
        Mon, 20 Oct 2025 01:24:46 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:5b13:a549:df98:9c00])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c29sm220299395e9.12.2025.10.20.01.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:24:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH] gpio: mvebu: Slightly optimize mvebu_gpio_irq_handler()
Date: Mon, 20 Oct 2025 10:24:45 +0200
Message-ID: <176094868222.39929.1582779339210420040.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <7190f5def0489ed3f40435449c86cd7c710e6dd4.1760862679.git.christophe.jaillet@wanadoo.fr>
References: <7190f5def0489ed3f40435449c86cd7c710e6dd4.1760862679.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sun, 19 Oct 2025 10:31:38 +0200, Christophe JAILLET wrote:
> In the main loop of mvebu_gpio_irq_handler() some calls to
> irq_find_mapping() can be saved.
> 
> There is no point to find an irq number before checking if this something
> has to be done.
> By testing first, some calls can be saved.
> 
> [...]

Applied, thanks!

[1/1] gpio: mvebu: Slightly optimize mvebu_gpio_irq_handler()
      https://git.kernel.org/brgl/linux/c/eb7f1c8415bbbb81f8674a490a5da7c22599a012

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

