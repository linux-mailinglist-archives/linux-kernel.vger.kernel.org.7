Return-Path: <linux-kernel+bounces-733189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324FBB07155
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE3A3AC6A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9315B2F3C03;
	Wed, 16 Jul 2025 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wOuJyPSM"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0BB2F3636
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656977; cv=none; b=ScBua9RLz+ZiHtOf1Mhxb4QzqsTsL9UT7hnpDReTt1Y5rejtntlI+sA5fAA45jaXS7mkjnpGVYYZSHjo17jthTtcYm59DKAbd0/OJfQFX/Y1jY2a3jbhwAvkaifr3t89kU6bItQTjmybkSEBcb5JIgnnRAboCnsg0PXImpUJZUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656977; c=relaxed/simple;
	bh=cE5VqM/Aye5M25nfqRt4xlFQsQqCriINwKa3QoUQg7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hT1xAQomIuoeEgWAgEsXimYRJi1ff+NEnYN0DW8oV/0bulHVmcOnJF5ahiGtIUTzh9hRWfigz/GowR9W1YGnxQSZA7p5iEZaqEQvGMjwg2hfnQUXKC/2Ofr63Ig+hx2WFZxc5/W1RXC2dCiyFYpvAgdsZlKGCEfaOj+UkNcHKps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wOuJyPSM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45629702e52so7387695e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752656973; x=1753261773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgcyS0cP2LKVR3dk4pVzkOQcYIRxnrw3WrAT5SUiSdA=;
        b=wOuJyPSMxGvGf6k3PqgeQINeHc2/U8nocCb9722CpNmYRZlnp7huV1H35ivbYdJuY/
         3npqwnn2K0Bks/FFVzqUCvnMvq3jsPMu/h8ucI0ouc4F5NtZH/ryNJoL/ffCf0eiizBd
         SAv1u7KqE5i3P6lAqnxt0Oyspbgz493ba5xiFLfXuAOyH4ru0mSI3d8gm5p0Jy0m4UKC
         VLAXsljctVQpAv7u3TZDgxJo1TtkY0p5o0lhasBakep6WAOoH8k9R00z2R2X8ML6YznZ
         r7h5dmoAy73MM3XaDogxw/0Kwqiz95H9C13J2ChZk0qkn6WQYlo3pFEghOqgKoZCOW6l
         LMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656973; x=1753261773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgcyS0cP2LKVR3dk4pVzkOQcYIRxnrw3WrAT5SUiSdA=;
        b=xTeqhsrNApcFaXKJ8v60spje+IsfgrVMcL2dQ+5VSkj/4NZ5829/cz5c/2uSQkuQla
         GBRiZgqKWDN7YOEjcU2VP5LMb/SH/KwKrc59ymQBeFfcxFR8MC8/gjXlJJlSfEfSkBOG
         VUnRRWdNDsi93WgcVQvIfbLHote1mWxGMA/u9ngT54KzrmNGI0H5aCKUup1vKY0QnwPD
         hkC1YfIAIrgB+XARdoG3xy7ekmxOtK4IXSPtKXfeZSuTsHrhySTc22ZQpmNZ1Jrx5PDI
         3t2Yo2LJ9iekGHRubLvwKK8Ak3Y6FccrZjljN6q6TFdBLQj2rGuYxGT8zFOnUeB3uu+V
         cucg==
X-Forwarded-Encrypted: i=1; AJvYcCUlTyD+QDEBW5mZrYVpc1i78pna+2NqxqgtYY0Xlsa1LlnDvJj1+59ciYDFHj9rkpBxQlULo6pJqYWTQz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pUCsdcIGgeKDuw+wiRqU3eexiXNH4aHgpd+VzJYfNvYzv4DY
	XzeaTi4iTudp13T4I08FGWMjc9RaRkBvD6vLiekoeSw5mpbv3Gh+QEUsjqOwYHzKB5E=
X-Gm-Gg: ASbGncstxK5oFdlNB/0bJ2sW65UgcSXdB+1KeuFG8Fc048C089laeBJ3sxlunDj4IyM
	1mGgI8mQLT1+55ZhztqnBTaKL007ot0K5wPAJLHIKUJi7l2pSifLwHtQCPbJKxEOZGLyNg36G+W
	tJJQGMFhlf0Rn1s+M5N6frS4aIfyMFqVfr6EkeQYseMx1asLVIgtE2T9zP5NhwG9ZI2gSYzQiHd
	n5NEuEFSgfDGisk1IRreFnAv/ppVYqF4mI/DMULsFLHhdJQghtEgQVR4Jc5ByyMHS1emWRplrAh
	HPvHcnX7/Ba63/H8oPBaMjMoCyCTgHHarbYP6eA44agUjttoSQd7Nmf3qYMvkwKnKz+7CUHAWmR
	hgp7aJNK7VEl6xmKW2X2QZhaYeqW+k3jmcA==
X-Google-Smtp-Source: AGHT+IH1X82qEqhjol18DDJEFGz34X4Ek+/xxtR4JMxGi/bKYriL9xzckLQgYksH5nyxoTbuZrR2CQ==
X-Received: by 2002:a05:600c:4f85:b0:456:43d:1198 with SMTP id 5b1f17b1804b1-4562e3801ddmr17207875e9.32.1752656973308;
        Wed, 16 Jul 2025 02:09:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:e8b9:11d7:19c9:41b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8027f9sm14857595e9.14.2025.07.16.02.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:09:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	kernel-team@android.com,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: devres: release GPIOs in devm_gpiod_put_array()
Date: Wed, 16 Jul 2025 11:09:31 +0200
Message-ID: <175265695302.15922.15433902408963854171.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250715-gpiolib-devres-put-array-fix-v1-1-970d82a8c887@linaro.org>
References: <20250715-gpiolib-devres-put-array-fix-v1-1-970d82a8c887@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 15 Jul 2025 17:00:20 +0100, André Draszik wrote:
> devm_gpiod_put_array() is meant to undo the effects of
> devm_gpiod_get_array() - in particular, it should release the GPIOs
> contained in the array acquired with the latter. It is meant to be the
> resource-managed version of gpiod_put_array(), and it should behave
> similar to the non-array version devm_gpiod_put().
> 
> Since commit d1d52c6622a6 ("gpiolib: devres: Finish the conversion to
> use devm_add_action()") it doesn't do that anymore, it just removes the
> devres action and frees associated memory, but it doesn't actually
> release the GPIOs.
> 
> [...]

Thanks for catching it, I queued it for v6.16-rc7.

[1/1] gpiolib: devres: release GPIOs in devm_gpiod_put_array()
      https://git.kernel.org/brgl/linux/c/ff20798820e08af0fe757c756914b4aa51993ccb

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

