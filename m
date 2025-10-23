Return-Path: <linux-kernel+bounces-866542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05309C000D2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7FFA4E7F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5104C3043BE;
	Thu, 23 Oct 2025 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aztxxpZX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B593043CB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209935; cv=none; b=Nojvzw6wP8yf/svGcO2vhfwTWkY7KB8T8NH9k6xLpNPupXW4HD0fK4Hcuk82xQNis3qDo+GhPxx0XL6Ed09ztqRaEjCk+KQqLPrB83++tw+jKhVTTrWhlTAKSqnJAaRP6HJtoYrG8ZJ85mSTCrbtkHitqcD7FXmNdS/MfOYeYVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209935; c=relaxed/simple;
	bh=7pU5zm3QYGIehz40pPqJP74VQIBSh4RuMXSNwFr0sg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9XS3CTtb/xGHBrs2lvt4Do0j8vbpXepuhmFcXWq530+8pK9ubmSquVGxZ6+5KrrqBjoUubxG0GHUlO6OkD5XOCLV0uG9vgOwbldb6mBbPlQS6un6kYHcrTwkQhyeLdl4/5NXchsQV+XtVziKBmH2WHys6Pp27DKWKDP7TFdCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=aztxxpZX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso5102125e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761209932; x=1761814732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eb+OgAnfRHsZk+Au1Zs5qDOwv/80EA0ztNh0lNnxuBU=;
        b=aztxxpZXysRCXCGNcokRhdo/awdJGUSu0k86AeG20W4VHLhfRDjVl8nN+UNejVbgmP
         OwpRh4PCxQxQoSoW3fc34afIrjrqbJD/GTLoxrPF6s/W00QniyRl2hU+zHdVI0sTZUWg
         ROAXiSG+ioc9jmSu060dlqEkSYdMWWjYvbH6iTn2cO3aW1EOz975uxUtE6tfpGGRUdIK
         5OsSod1dIiBsgKE2lPgqtFm1iqCEG/zMj5eT2KYKBTlaeegwBSsZ2vb5FP4gjuflOjQs
         Q4zA/hYNJTA+3pDE9LN3wD0grHUuY2JyBrP/H0zBsxyuB2o1FbDkU9aX03sYTS5yypfD
         quSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209932; x=1761814732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eb+OgAnfRHsZk+Au1Zs5qDOwv/80EA0ztNh0lNnxuBU=;
        b=RdJbgBXJ+PLs6Kb2LcQ+QEO0enYkIy7FWDLBvJ1iwZKpg1ySz+aQeniGTvgRt8+9J/
         SBTajEdaNjUqPHQWbiIS4+fn3tejPfIW+igi3pCpNrKyybbBpiyXq1iJ5ZrS4Vx6gZdI
         4L7DhRzuQ+SGCd8fkxqfNDtV4Cp/0mb56bPQLhPh03XybwG4yiKmKIno3p/kaDRJAOI5
         xppcFcQE5kStz+I+rIXg52JPk0h9rlzH0AO100GDdSDp22oSZ7DtmqcskrpvkXz1GwFD
         9AwxVA2mDK30ZMo1ocA9Xk2JwzI4jDa3Vc1GPFippJSQhALgxGhCsvCYw+i5eZHOYSuI
         wE9g==
X-Forwarded-Encrypted: i=1; AJvYcCVtajy/KbUHAAn7Vh+duSQEf91ictDTYkiqFfRokGbl7imTOgz4gWpmBpt85w1RsKGqhdzUGM9IrlSmdxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx73DGBm+wu2K0qXWRNuL+S4JHXlmBFup+/z1EGo/eLT8KuFFT
	M825xJ+p7fSDPmDUTtyuDuUtZu8dmuOI/QXjiUPwCthZpSvkEsWQdeAMAdvhzKnjDNM=
X-Gm-Gg: ASbGncs7PzS1MIKmq5R6TKOcq/8iAxe7BJDcJnBINAFSNqGJkIY8ZCTqyT6TnFiA+o3
	pJbEaOlvIfR+h8V7xHjlZfuBYWUkFZMiUU3qHnzK+TyK8U8QePCSSWJ865T5sDDCKZSYxecbYjn
	S2p0xz7rZeRmP16VEjczmK7tjyPdE2tpteE8vGSHO0josWYaWqmRvRt+BqKtMhPDzFcPc+JdATD
	3xbu+2ksfyrj7wOawDnUIwSSdpC78H4PcnI/pVUhwXCdYQoWcvACrerKb1BepnCzyiJbwW5r0cL
	VBUKQwZ2gybcFU9enrM0fyKBp/BAsLrmB73SYneHqpt2eEPNxgOHLxbcNoW8aC5/8fD0BwX6Oz6
	dyk9CXij8cOljDntp1hvLeh2cme4UDL02HqyXwMQEJyuqcrjTnJXb1T6R26y3Q5yf9jQPMbpA1x
	Gv
X-Google-Smtp-Source: AGHT+IE65Vu8zxlcEflx19PjtIQqmipfYIFP7ArEvVQCvSaJCChgRsffS+61E3E2uArv2eOCZZjqig==
X-Received: by 2002:a05:600c:548d:b0:46e:436c:2191 with SMTP id 5b1f17b1804b1-47117903f96mr183304895e9.25.1761209931899;
        Thu, 23 Oct 2025 01:58:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1b4:e02e:c538:6feb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf152absm29456975e9.9.2025.10.23.01.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:58:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Haotian Zhang <vulab@iscas.ac.cn>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: ljca: Fix duplicated IRQ mapping
Date: Thu, 23 Oct 2025 10:58:49 +0200
Message-ID: <176120992543.30209.6523033336777390844.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023070231.1305-1-vulab@iscas.ac.cn>
References: <20251023070231.1305-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 23 Oct 2025 15:02:30 +0800, Haotian Zhang wrote:
> The generic_handle_domain_irq() function resolves the hardware IRQ
> internally. The driver performed a duplicative mapping by calling
> irq_find_mapping() first, which could lead to an RCU stall.
> 
> Delete the redundant irq_find_mapping() call and pass the hardware IRQ
> directly to generic_handle_domain_irq().
> 
> [...]

Applied, thanks!

[1/1] gpio: ljca: Fix duplicated IRQ mapping
      https://git.kernel.org/brgl/linux/c/7d168362aedeca451ac22724f90040296dccca14

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

