Return-Path: <linux-kernel+bounces-764952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED3B22948
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CB66811BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF872820C6;
	Tue, 12 Aug 2025 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sxvwzJEx"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5227A918
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006127; cv=none; b=UCMeKdHpBloBfSczPMGjjsLGKLRFirP8+xCuO4cO6CwlW6Wd8KNlS1pRVOn649qPGl6rKlNSnaru+zG4o1K0t2JfW0kb3poashawVR/sje0rsAzlmLkS87EG0J7bEtRFBSQJkGxm8bxqhe5HoMgz9fKBvjZrabuqF7SagzuXXD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006127; c=relaxed/simple;
	bh=oa7rJuYPUogPuSxaDRvZAN1fyLFuPuWwWOOFmAdB4fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGEOdip4GmKuXYMAyebZXcjZMzIVZA8fEZd7rJu+pK6Svr2+d6fQmf0hUhqlmqvLxCF74kOtUB43JeSRakyCkznZqLyNQt5hADpHAhbn7TCfts5VzCabsA4JEQJWja7+JZbnwaao+pz2N1RzEm+hCRHBLrlmEo1OtX6CV4Uqj4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sxvwzJEx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso36511375e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755006122; x=1755610922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSZ1PCEGP3pi/OH/Xi1V3U6pclhEz8nu1z3XblBVYXE=;
        b=sxvwzJEx8CzTLmv6f64zNL/RHMjEDdFxbddOXOXx4AExV4hMW7nv9aN7lrq0Gf9hWg
         r6TEcE2xTs/7hsggR/qYNbDVYZl1etkuW/8/72GTb0zeOn41I282ND5Qf3ySa3gYW6+1
         /RZBbC0whORl21c8FmvSlc3VFsZA4fp/6W4glTzsouO0VxAD5ViAi/SAxwp7lIsBOXay
         S4iYRT1ATbeSS1ZCzucR67pIHOJhzufrwAp64LbQ/IEyERTgOS/yNhVhUbii8EA/LUoZ
         mPHCToremv/+eGb8AFDZAftdB4B4wApjZMbEtR/8jXLor8HXjzUMskIMk/baYxz7tzDE
         whFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006122; x=1755610922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSZ1PCEGP3pi/OH/Xi1V3U6pclhEz8nu1z3XblBVYXE=;
        b=rSecInq9P/p9QRDWFBJaFj3K/UoBQJtA4mvx6/Ypqzi4znsi1ym8W5CHkX3dpgzn+g
         zsek1yi43iBZWfM7Q/+aAH54LYQLgDfHb+yiiqP/bfkpEmo/1WLryxy2UkxiHdmcNiPw
         c4zUlJb7PAOmcEet2LGTh/dzN63Nz2r5y1uL/Imr9hL5dsbA0+oE7ltlJdBsmOeEEF3x
         UKFX7fP0LZpMj4GB/3ditNI+B3qkkzzJidrZVmS/9SoHBZr6V4PRkfwmeRkRO5NUzrSd
         uWEVTeUkbUT+beH5FNyERMXcsbF/YhZ+9Ri5kQQjVAuhKZG7iks665uBzZKIez3b8ZUf
         VZKw==
X-Forwarded-Encrypted: i=1; AJvYcCV6DytSm9aT9pGw/nS9vPA+XMiog2FELdILjMAgswxDcCNjcYqluK3kRhu88vgpoetoeD8Ty7hMBa2VROU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXlHtEqOj+hKOGhhyN8eefUVxFPc2jdl13OhhC6xXpnTDyvkJ
	ZF+32/SRnuSO3xGMkaF0F0ZoEHWGMdySQbvSDBC+ycMbe1Q5lIEnazItd9jW0cNfFFg=
X-Gm-Gg: ASbGncuXTfaAQjFBDGF8bhW6oGVXqx9rudxe8pws/9TBFXzGH/XjzlOAKhNiUH9YFqX
	JcVHWSAPkkhhS5rL6PbkHmKFkQGkmzaZZiDN64KFqBNo7ZnwQJlYbcOuS9p/0qL07gO/GJ4mPwo
	qZcxvuBUsr4fRbysiXPh+03c29Jwf9S+CInAJDvRJk9wxnoL83zLGE76D95WS7OW1NK+qk+W1Ba
	Cn+mO111lC2F86wAfNGWenrUh3U2IT0704TwfOTlShFjx0ocjxH5+VxlcXb8BtgK804SI4vu/Pl
	FrIlWLHjGQ+dJiAIpp8z/DzWnM5kwfpyu7BYckPIl8FW3cJyMlMy+7o6qzXK6fTVcrV2/c5HmFd
	L/tsgZ8hcllB9orhoHi+ooA==
X-Google-Smtp-Source: AGHT+IEzn9A/H9lqrdqywd6oI5H1wCRV0u4fShJthX9iNne30DDuIMBEWGX7dCZuB0wcfBMPlkvGFw==
X-Received: by 2002:a05:600c:1f0e:b0:458:c045:ee99 with SMTP id 5b1f17b1804b1-45a10c0f75cmr28749465e9.28.1755006122265;
        Tue, 12 Aug 2025 06:42:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e585586esm318545615e9.13.2025.08.12.06.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:42:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andriy.shevchenko@linux.intel.com,
	mika.westerberg@linux.intel.com,
	David Thompson <davthompson@nvidia.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] gpio: mlxbf3: revert device name logic
Date: Tue, 12 Aug 2025 15:42:00 +0200
Message-ID: <175500610764.300642.9569950085828730672.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754928650.git.davthompson@nvidia.com>
References: <cover.1754928650.git.davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 11 Aug 2025 13:50:43 -0400, David Thompson wrote:
> This series reverts the use of device name processing
> in the BlueField-3 GPIO driver "probe()".  Instead, the
> kernel API "platform_get_irq_optional()" should be used
> to prevent errors being logged.
> 
> David Thompson (2):
>   Revert "gpio: mlxbf3: only get IRQ for device instance 0"
>   gpio: mlxbf3: use platform_get_irq_optional()
> 
> [...]

Applied, thanks!

[1/2] Revert "gpio: mlxbf3: only get IRQ for device instance 0"
      https://git.kernel.org/brgl/linux/c/56bdf7270ff4f870e2d4bfacdc00161e766dba2d
[2/2] gpio: mlxbf3: use platform_get_irq_optional()
      https://git.kernel.org/brgl/linux/c/810bd9066fb1871b8a9528f31f2fdbf2a8b73bf2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

