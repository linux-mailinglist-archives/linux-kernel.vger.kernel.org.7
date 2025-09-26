Return-Path: <linux-kernel+bounces-833871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBC0BA342E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2644A3A7D34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BED2BD58A;
	Fri, 26 Sep 2025 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sZirVNKC"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EFD29D294
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880655; cv=none; b=Xp01ti+omyVh/6kcSdZXjXEkcoU8pFSAljeBWprd73uZMPLIDctduZFQk51mGPQBEGOe37Pwc/+3zWIDpLG3CUO8mGihesjOCdooI+2zR5uUjJWHosdgLQBUorni3nGrQK3tfBwnl3tYR7LVFnXBLyw9JI2Pvup0uuqZFm9SrF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880655; c=relaxed/simple;
	bh=pSTGxTVn/zpOADQlpLLlrFQ3O7dddV8wjcyu0d9N78k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAPjBnolweEjK77pQVzHYIwzFeWyvDQroumHT6O4FRyk9fLA51Xt0y2RuoxBJVH41CzMAghMX4dGJIYb0vU5VUkNE3K9JKFjKNY0944JuH2wY0YSwRuYHg0G+qv3VbI9qfggt5btT8LZ7O/E8/GjqEdCdAJenn4Y8eEaVkwFlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sZirVNKC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso10860125e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758880652; x=1759485452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Kxy+zDkcHliCNrZ/JPAcR9GylbEx4LYmoR1pgjRV4E=;
        b=sZirVNKCvvIkXRb7JR1uzWw81ekdTMnS1wafQr+1S8ltTN5JC7jNwREgC1FYxnVDVK
         rEA/E4mGdz78j1uNmbyO5cX/eoLOonSeZrhHR6mYSWb+PXw2dk7oF7LoYZrNV4NlhlqQ
         dhwj00imPKAfxLJUcY4YGXnc8x9GwyxZc4CR598D5xLkLxkh6A9fnheSATvZRbDmEyt+
         4txLMwj9fBxjEaDA9+lvM8EIFDv14pxVZW5u05u8wphqJUtbTdV6rgL3BLpVbwiYru1j
         mb7ucW0iDKUeVlta8G0KYvepkjJ7emqtpYGTOiro0zlNFQIw7/khu8GaXsnTH3iiNnZM
         TFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758880652; x=1759485452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Kxy+zDkcHliCNrZ/JPAcR9GylbEx4LYmoR1pgjRV4E=;
        b=dcjBpCy1BSCCOVyBGJf8lTJuVPG6nON+ZB7+UBcJ3AFGQsYOlxld2OpAJ0yTgL68GW
         5S+nD2wiPH3VexnX7IEk/hr8e7+YfG1VSRmpBN23WqiSqSfgkStLubyDHzzITCa43ruv
         BeBPwmnA0EWGMz/y3FVNfKQGQYgfdm7L54CRlUIsXHsxsv0gkdavbItjnANThcMGmK+7
         I+gqXNjfLAVs3Wgs4ZV3Hf5TVfWL1274U0Hjc3O4yf8O5Zh6thMpU/OCM8IuEAJhGh0M
         0Mj8Cb9osYuJQVSdR4Mp8SHD3z2gNCIJWrB8I1oFT855CNL2NwaBJq+VXgEamxMF8rHF
         DkBg==
X-Forwarded-Encrypted: i=1; AJvYcCUGzIJLLF+p69K7Hkb1tBGNDBsd3PfXUwP8BgxGplaz9IYoxtl5mPc3v1ZHU9L7qDQVu8IgQ+JERxGaey0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF5n58JSEDsM0dUW3DUn59TyZBK4x61R2qEhExXuVf9/10jOsr
	/d8HnQjuWyoeXE3rM9uGihfq3v4HGN6Ut3F5wG4SbXxVp20Ik5OiaCqJDPkWjij0E/o=
X-Gm-Gg: ASbGncuDqHulh/SmEQKHqZ6dDSFFFDuuQIiCpUpRFe8qNduiPN6a+8ybvYLRp7YJ72U
	ov4GtSOQx5l8u+SPkMzPce9nvlZUbbAgUHhDU00UdZbDjurIWtjRb+VUoRggid5rEg/+6XUfsal
	eyfGYqUaInH9tV5YlQfdNCKzwN8ZJbotcf1lTd6YXhnwYqpRJ0t9JmfMG323diqu2oDYlyg6DLE
	tSi+UjIkB/Xhwly4rsl3C0M57qgPHzWvmx6mKQfJzm/Oi8OsvONRFjXEk/fZWGNYRriIlBuLcA2
	4jEAjLHw4qmrnxQnHAp24Yt1WVmPlyXIP91a0iNWe6q1XPEc5CsobW2HnNTSPgbAnrdBC/+QF68
	T3ZaxMAz7RtNq9Rnrwzm9WSE=
X-Google-Smtp-Source: AGHT+IE/q7gcEasaydfPlSh1kSSOSBJAZe/1ZBQmjjrYMZ94FaitrgjVEefEJEXUDsJu0At0EET9aA==
X-Received: by 2002:a05:600c:1c92:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46e3dad3310mr19221425e9.17.1758880651763;
        Fri, 26 Sep 2025 02:57:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ab15:a65:aecd:6def])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e34074983sm66168915e9.10.2025.09.26.02.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 02:57:31 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril.Jean@microchip.com,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gpio: mpfs: fix setting gpio direction to output
Date: Fri, 26 Sep 2025 11:57:30 +0200
Message-ID: <175888059620.38209.6546087887696517521.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250925-boogieman-carrot-82989ff75d10@spud>
References: <20250925-boogieman-carrot-82989ff75d10@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 25 Sep 2025 16:39:18 +0100, Conor Dooley wrote:
> mpfs_gpio_direction_output() actually sets the line to input mode.
> Use the correct register settings for output mode so that this function
> actually works as intended.
> 
> This was a copy-paste mistake made when converting to regmap during the
> driver submission process. It went unnoticed because my test for output
> mode is toggling LEDs on an Icicle kit which functions with the
> incorrect code. The internal reporter has yet to test the patch, but on
> their system the incorrect setting may be the reason for failures to
> drive the GPIO lines on the BeagleV-fire board.
> 
> [...]

I'm about to send my last PR with fixes for v6.17 and this hasn't been
in next even for a day so let me queue this for v6.18 and it will get
backported once it's upstream next week.

[1/1] gpio: mpfs: fix setting gpio direction to output
      https://git.kernel.org/brgl/linux/c/bc061143637532c08d9fc657eec93fdc2588068e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

