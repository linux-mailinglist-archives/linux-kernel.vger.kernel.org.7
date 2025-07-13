Return-Path: <linux-kernel+bounces-728993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF729B03045
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2830B3ADBA3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 08:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA979248F76;
	Sun, 13 Jul 2025 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="N+g0JCry"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9750A253944
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752396326; cv=none; b=rw3GFkIbMN3TS6rfoTpqXvCcAxfGfSVEPyAXWD1sk7zzEHYtfhlqXxhYDPDFX7eA6Wti6Y4Hi1qQLQlpR6zCnZCvWu4b/WCCvmFRtBeMwob1weIkXp91pBw5cs4HLIeNVhdEFUSFTjn/AHNQWo0U7jStN9MVf6wHWOpZI0u1l6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752396326; c=relaxed/simple;
	bh=lusFvrluC0wYhKdUfx8ugv5q6txV7qMpLVOYfgxd9LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdiLPiIzGW0In++y3gYNYhfsu5gj6HaB8vaZqsRlKYhJI8QBK5fKKWjkH2m0NHjWFfb+0OyxTa7KdDRAgEHcODBe7ndxZSK6mcLZWutpxMg/bswO9RJElKDutiwAwfQV7PkQ21XjQ5GaNOz1hd708d7833F68v7h2j57Ydj8LBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=N+g0JCry; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so1959945f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 01:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752396323; x=1753001123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOOUWMIdhHkQ+tRZU4YDol3EV+jZsKR5HFpybqxFDYA=;
        b=N+g0JCry7y8ysYbIIpQiT8BcKvcUCSIkaDc1iWf4p5xM6yT7P1SGDSP3hVgQKzUyHB
         Ig2DJvT1xZ1DbcRwfvDbJRj0xB72ihGKLxJBnRM0UqA2eRdr3X6nYL5WarK/bfmrbKOj
         rOWnQG/gcqoHQ974QrCxujo5uK8TAKhSAeozdv857HxzHxtpjWo7wRKumxCM2luoiY/0
         lHvF4ILMHvlplKPy8eVb8QZmzUBzSZGJhwJdx7u7LoklCdrGRvhxOs8y9mdDOc3V5V5G
         YxUfUhJkzpQBf7FB1t4nxl4O6Y0DT4n9oo5LgCJzivmYDLW2AhMhnum59f86PmBbRai7
         RvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752396323; x=1753001123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOOUWMIdhHkQ+tRZU4YDol3EV+jZsKR5HFpybqxFDYA=;
        b=C76nB0pGgqBjGDdp4YkRwpoC0t7zzqHHdyNfbdZjM/C3lqGsjpWjgSP18WH2NJWHWF
         IQkHvhWE/9V0Q6UW0yDF/C/1sKSjSd6b7vuljmCT185fCKv+sf+ewGOvN0c+Vj7dbGDk
         GuCTcGWhbeZ9chf3e9Sy2SkZBnY/wnhAjMh+wHSWKgPpBBNqPtDNpjWy4aQ6vNGExHaF
         EJugxlXtgyeXl4CQPUBFyG1I/6a8BZ5cbET3A+bEwxFW4OFc3UbUOVMPK1aX6XSPAw26
         NliTds6IDknVBrQ2ez7uax8Bn19BUOFiWknPoMXPNOA8BEAtYGT7zclpO9NJue2BRp3Y
         u9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb61rHZA5GpVhBnvjoHd+I1hGptZQIFi2rK2ij3HN65D8Yvtew+vdADA/yjEEJH84EEuqWv/uIxPsBMdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpXgHLHdMiZuPU6nQU3GoSvnAe8POKyZWDvFP1+kQGXmsRGam2
	o6YoACC71/lMcOBfCRcf0tsdGUBVcDC8l9JQ0KZ8m4JbQ/4o2aNWEmhd7Bij9zBtbjI=
X-Gm-Gg: ASbGnct3QQ5TIR8yJuuMHU9+fAwQSO96O2Diwlc8cozfa+MpqpJFYBzvgnMmFREPpUD
	YWtsBmSUv8oSpAVb5V+5jhxPVYFLApevWAt1mZJDckiRzViI1u5FnZiKdNIgqNM1eZjWSV7uFyJ
	3C0prTG/9szspDaC0L6XRCEZMTkJfQWrzwEwjvgBRVoKD06OaxNb7dX/PMkhlAPOB4cyQ9CAbbd
	MHsPWcpPaXOeM8rvRvCPtmmssVloNg9j22J0WBZvjbJROPa/t5ZClvdL1w1pEwRckgd0ukblMoa
	Hse43PTOBUbggtHfQA+4EHmnCTju2llxlH0DDFGC+Qnvj5OEAFfHVqKwivIrFm9uDPf4BLth7H6
	f/3pv+55Jq+A48HSoMhu9xrI=
X-Google-Smtp-Source: AGHT+IFA2prv4K400SGiTJz+5nwQs90KuarJOb9H+jJVA2bKFFKRJN7i5BSkPopM07i32Va/RQqyOA==
X-Received: by 2002:adf:e18c:0:b0:3a5:2cb5:642f with SMTP id ffacd0b85a97d-3b5f18dc494mr8398012f8f.34.1752396322894;
        Sun, 13 Jul 2025 01:45:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:f695:8645:1433:4418])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50ded8csm134569945e9.20.2025.07.13.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:45:22 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	linux-arm-kernel@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 00/12] gpio: use new GPIO line value setter callbacks
Date: Sun, 13 Jul 2025 10:45:21 +0200
Message-ID: <175239631858.6478.15774208043366926710.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250707-gpiochip-set-rv-gpio-round4-v1-0-35668aaaf6d2@linaro.org>
References: <20250707-gpiochip-set-rv-gpio-round4-v1-0-35668aaaf6d2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 07 Jul 2025 09:50:13 +0200, Bartosz Golaszewski wrote:
> Commit 98ce1eb1fd87e ("gpiolib: introduce gpio_chip setters that return
> values") added new line setter callbacks to struct gpio_chip. They allow
> to indicate failures to callers. We're in the process of converting all
> GPIO controllers to using them before removing the old ones. This series
> converts another round of GPIO drivers.
> 
> To:
> 
> [...]

Applied, thanks!

[01/12] gpio: tps65910: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/3e498b3c7b96a17037b5777c56ccff33d3bfbca5
[02/12] gpio: tps65912: check the return value of regmap_update_bits()
        https://git.kernel.org/brgl/linux/c/a0b2a6bbff8c26aafdecd320f38f52c341d5cafa
[03/12] gpio: tps65912: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/22cbcfe36e9724fda06ca873e20777d863445ab8
[04/12] gpio: tps68470: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/e41e51f07b1c8a642fed121d01da37c1c2994f89
[05/12] gpio: tqmx86: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/9ade48906b62fc7c5b999422891408a4f02c255a
[06/12] gpio: ts4900: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/ed8497dc6683cd285ef4335a315d398524c4af52
[07/12] gpio: twl4030: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/0446ce284bebe192be6e0da6e969379dc3dac587
[08/12] gpio: twl6040: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/77ba4640cc1564f29b280040b312688b79039c4c
[09/12] gpio: twl6040: set line value in .direction_out()
        https://git.kernel.org/brgl/linux/c/79880eba2c0feed895e6d2aa8f7e5489d113d653
[10/12] gpio: uniphier: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/42fbbe31634d116a7f6bee75c0ae455bf10a7737
[11/12] gpio: viperboard: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/55e2d1eec110f1278324882714b64465e4e58ced
[12/12] gpio: virtio: use new GPIO line value setter callbacks
        https://git.kernel.org/brgl/linux/c/e502df58b5e3767c00e887744b6eff43b7fde3ea

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

