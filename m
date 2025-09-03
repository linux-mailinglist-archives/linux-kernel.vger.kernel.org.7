Return-Path: <linux-kernel+bounces-797897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FDAB416E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F683B8FD1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF6F2DC336;
	Wed,  3 Sep 2025 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RKyW3rPN"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE92DCBEC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885139; cv=none; b=gfVstS58aqZMvm5VZtyONGyWb9KIEd3ER2hXgQo2kXSexVfnYrNtta1Yi7M+2fi+0f+H+0fRXK4MSWZLKr3WpUzhIR4IlPlVCEOoULebhZ97oNDtbL+ZlmsnaL9Jmjm+VvVNDH0YWP7OsogZNhzWc8iZr80A97kabQ7Zox99N8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885139; c=relaxed/simple;
	bh=5R1W8LWzThf0lefJvjX7dgtNUQ87EdiwGUIQXxLzwL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjPsZlKZ107UPvYrX75vb6KRWrRolTeNtvBR66sY2GAFPcHbCOJPSgsdjkoqwh6R+CrClObCva/u1ExDAfEjA1du6RXSK8IfW1J30rhCaoPUHZT+tkt3VsCvFcyu/B+ZYSliKuwIPk/I/3OJBi5bmsUkwYp7mGo3dPymtOLwhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RKyW3rPN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3d1bf79d758so3251560f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756885135; x=1757489935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mp5T71lPvUAjJD5COGIsnq0220IphycqvLkiYGEuO38=;
        b=RKyW3rPNGi/Nz4B9jAeglCHRkp9TFvVoix3yKzjp/SGPL00lJe+XwBFLumtC2YpB89
         j634Iuyub94+CuOUABGVKQG3rjIzP4jiQ1JfdbS3yU2K3uQWuUjoXduL3/qDh1lLwGFN
         QNTnbH5OseM2XVNwNp6cLsw6qNmdjB8dcnWev0hyB92RNotodYpCQYSgSRqYlK2nRQOn
         A+RslbeQZMi3wYooTKd6hjQYT4y6uOs05BMfXjLtUbhfAqqH8KEeW/NLTeMWavz0igKv
         I3MYykytH8vkUAveyUO7pfSYCOf28vm1sA2JstNITLVGU2mcCngM46Y8hpRMnjHtm/0P
         Oxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756885135; x=1757489935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mp5T71lPvUAjJD5COGIsnq0220IphycqvLkiYGEuO38=;
        b=GWKD7MZzEeWNLh2No1xr7B4ti/dxv0v2PMnIqvEWE2uH+JieFOubVUgRVhGMTHs3zH
         pbNzQK7FWkLxWmkBcgsvBccITRlBiDqIHxGzWvFqEBPJ/CWdfs9Ocr4BcWiUt3PJsDDk
         kiXBmrodNAhlNr45QqkrxPDePV+Owgjs43gEdE8jOfQB2PWFGcnYW0+NKzxuPhUXnxoF
         UM/L6ZWyOV0CKM1ZQ5l5aXAZWXVSBjsYEtaG7w8jG0d9JKDgJBNdrA46B1fOY65noeHP
         BtXL4dRFpTHpcczPPA8vmr8hDA05sG+uwWNBvpVBQVjUn5eeYBbmAWY6UBvvPsYSligZ
         M4kA==
X-Forwarded-Encrypted: i=1; AJvYcCVfJMJETU34g9ls3SKDytq0xs7aWLEbrKpid8aPKQyQB4RgCNcE+e12w8BPIuWfNEWUr0HfTmwBtzwOEvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwcLkvS+8Ir/qJQFjy/mfDGJoYM4y557vqf+oH0uvhApYxIuU
	/YMcMHTPEJbwFHhmXRhvuEiTf9PY2Naj8mpl7rc3ryHWKkQ+W7XkQTCjHaOc2GkMVcJh+e6MYLz
	4uF/s
X-Gm-Gg: ASbGncu0pVQnaNGWDOBoYwvPGERSDlliXoQYAIySI4yhKLKV8eHJ3grLvFQ+ldLUO/E
	W3fhXtrimQM6QrQaxqmBXX7+9eYloH+wvJPyH+SFeSwGXC39kg6WBoPSf7SELQRazuO/YdOUXKO
	TkdfIRV04TMV9u+CM4yzrs5+1eG/CGmDPb2B9g34JY9ttLcqcCnpRsjlr85FQF0rULYMdl5xmGE
	TeNWaXgYt8aUCMnMFxVLuypWShjuFJxxdMzNSAAThDtei8B3Zp0jdbTfvmcGeovljo7EIpfrhdl
	ntggsvCfu/hAxZCKi3DkxyYMr4joXWD0myifE2XMamc91W9zviyFzGDRrod4wDKeBUXhJbpuH+M
	eDImBL8CaKiLbWVtVB0oM2f0=
X-Google-Smtp-Source: AGHT+IFkZYEPWWCkKse2PQo7g1HVYHPWt9iUadycuLD1iYe9gFsnwRwmTjB2wHvwzo04UWlct/Y1jQ==
X-Received: by 2002:a05:6000:64f:b0:3d3:1ad0:e8b7 with SMTP id ffacd0b85a97d-3d31b2c7c54mr11268847f8f.12.1756885135098;
        Wed, 03 Sep 2025 00:38:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2f8b:4799:6bd6:35df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d53fda847dsm13417216f8f.0.2025.09.03.00.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:38:54 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Yang Shen <shenyang39@huawei.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/12] gpio: replace legacy bgpio_init() with its modernized alternative - part 2
Date: Wed,  3 Sep 2025 09:38:51 +0200
Message-ID: <175688512868.10115.1073812305846607850.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250826-gpio-mmio-gpio-conv-part2-v1-0-f67603e4b27e@linaro.org>
References: <20250826-gpio-mmio-gpio-conv-part2-v1-0-f67603e4b27e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 26 Aug 2025 11:35:01 +0200, Bartosz Golaszewski wrote:
> Here's another round of patches converting GPIO drivers to the
> modernized generic GPIO chip API.
> 
> 

Applied, thanks!

[01/12] gpio: xgene-sb: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/38d98a822c143a4a7337d08f50968cbd7b701ca2
[02/12] gpio: mxs: order includes alphabetically
        https://git.kernel.org/brgl/linux/c/d3332dd1f6e2cf82744dbab37d05857e2d028fa0
[03/12] gpio: mxs: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/c7357c8b6703d4bc0db6198782fcbf0cf3033844
[04/12] gpio: mlxbf2: use dev_err_probe() where applicable
        https://git.kernel.org/brgl/linux/c/7cb9086790a0de526ee40508a4deaebfd82a5bca
[05/12] gpio: mlxbf2: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/72fdbf35ec7273bb1c885696680e611c47b261b4
[06/12] gpio: xgs-iproc: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/6821e5d5877ca80b6989dfba2648a7ecbe3d9a64
[07/12] gpio: ftgpio010: order includes alphabetically
        https://git.kernel.org/brgl/linux/c/cf0257d3ce05259a74265fe0a0bd7de063cc6793
[08/12] gpio: ftgpio010: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/3ff7ab070b4804aad5b1d3e3d82a793710ef1f27
[09/12] gpio: realtek-otto: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/b9dac8251e7e6aa433f54a7da45cb05c66627695
[10/12] gpio: hisi: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/c0378e59a6af2efa470a384b69fd24d3f3f3dd97
[11/12] gpio: vf610: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/656dc0c6f725a29c9e48657ae3db78f9016f518c
[12/12] gpio: visconti: use new generic GPIO chip API
        https://git.kernel.org/brgl/linux/c/a6f03347debb7c2c6d04cd4be67ed766e19633ba

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

