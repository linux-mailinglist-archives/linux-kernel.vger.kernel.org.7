Return-Path: <linux-kernel+bounces-797898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E733B416E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032323BBB7C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106022DE70B;
	Wed,  3 Sep 2025 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X5nmqeCa"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE052DE6F5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885140; cv=none; b=Vk/+7FZglZiTVuk4zfvbl1OKJrHoL07ntwtZcoGxTCzjWBIBiUzNslGGB3ihMFmRCLYh4NeOQpAWWpeq/WSnkXVH7jXTgP1cfodk9ve33yazcGMr09ttAPRhfyfU5USwIK+dr9vdpTScPkQnHJOameq2mP6AEU+WkzWunRAC1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885140; c=relaxed/simple;
	bh=ZMq+/DLAY/G0cbCuJHDGH9PS4rmeWgA649rs001QIRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chPUBadXBa6E/SUCfkGYgKU9MTKVLabSCFLigGMuQHYubRr3BUR2gVTBmXlYJ68bFmAabgB2STgFZEtAEOFvUnG0Osd7jygV5Q1xWNT/uWHXibjDd1S8vtEygdWq4PI7Kfyy3Ej/q1BEavLuLF3WnOSzO9bTvxxp8aosh73qhTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X5nmqeCa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b9853e630so14604015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756885137; x=1757489937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzDrLtK3tVYXpgajpgV5xkfeNF5cniPAFxRcbhLkKq4=;
        b=X5nmqeCa6G3jNoRzJVGcTJgsq+jjaefzCJhNRwlv4WQgt+oxk+4e74BtDTrFe8Mwl0
         n0NwXGwV56+TtFkYXsuRndj1GNG9uZ39LzO3l3kjbS/ZPBPUyWzIgdLAt0mI9FuFnmIH
         T4ZkZIV8wyEsJyzKAG6CSEwYxSD05Mr2GNOyoXRYWPYATxbTHvEGZPgzRqWFItPFQLn/
         jyJ0ImPhA3hmqBp8K0SDJiApbfPZhqqly7nItjxGeUFUWqkpxofVD3HHQxt642SUpLL8
         cOI79bpx4JZRnoAs9uZNSIZL6aT+A0HLZAdRUGI8/zOmUfP4V/VCyxhT5I+9ZnQAJGeC
         RFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756885137; x=1757489937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzDrLtK3tVYXpgajpgV5xkfeNF5cniPAFxRcbhLkKq4=;
        b=V9an4i8CwPau/naQtoj91YqO9lEAOMfMdfEnZWbCLODSXfGIvh7NcXhmF3P636GcHu
         Uhkuj0lxrptDHCFSRw6an7JvhD1m12eLS/nZCb3nNpE+YwujMeeN96IoHBe82WONvjBP
         3Ocl9JytXfTWLVGMWxQZec7BLeD2KTvJQCZy/Re3Lbyp9++Ym/EM+4hOyPEK6OeMTuQ3
         M5xMDGTMhLBJIvBMUPjifaYr9jf3RrCxYCuCfw6+n3h9cZnImKpebTLemPrEdlB4yqVk
         hTYvy/i+dk/KTpj036Y1MsMmomn2cJC8i9VyrOosq8laJpBAYByYTXZXPbgsEcRiPcGR
         /gDw==
X-Forwarded-Encrypted: i=1; AJvYcCVU4liTtziQaIywREsFriYsF4p0/UZGjMRfEmKa9Ypia1y8ttDuM9vAuGY2NSgEYVX1uucXG6n/X+GAE54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdEnYsgu6TLAQ3vD2es5RKcAbErkiEXRWzLqNbW/EsuKyNFsIG
	cu3qn8dLUnlHDA0wkUPRMeq+Coa0YSvb/gptzMQ67Tn0FxVyxlb+YVjlg1ZvoLHPUOc=
X-Gm-Gg: ASbGncuoEQCGDMSi3gDCayJtU4bFLSWgndvf2me/w5Kwi4BHhmGla2Uo9i/+JoEq+rB
	wtsr5mGA14aTrzHt1XsBbRAp3AUpZ6AeYkhh4ubMCut/8c4M4Ed5fyD69aCxVNYzr11eS0wGPvA
	hzdop1a4txXCrGVc6J/ppMcd4QkpE0m2Qq7W8H7RLYcS/KmECQ8cPwOQW9fBX4HkRj3t7Bhwtww
	STE0w0nYdhg+jiIRDjwPn92QaroyVG9jhwONC7pau/FUH9ACtZeHj4uItkGEI9RYjQB2xBwW4pi
	x5ggQTWr/Cco8rSiYhywdpZBAwqHYLpFFb9pUnkLKbypi6etpCqMi6WiWpKKzvtd7ufHHb54Ein
	iCfIEzBcNdRoEoOLPXeJH9bkzEggbipZMzw==
X-Google-Smtp-Source: AGHT+IGzMNTEASi0Qi6RgPFb9XAbV8YDnYAnOHuJi0TADIjDiS29XexXLdCQiRjZjgcY+IsF0TsvRA==
X-Received: by 2002:a05:600c:3b29:b0:45b:6269:d257 with SMTP id 5b1f17b1804b1-45b855c428fmr121644965e9.35.1756885137007;
        Wed, 03 Sep 2025 00:38:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2f8b:4799:6bd6:35df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d53fda847dsm13417216f8f.0.2025.09.03.00.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:38:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/6] gpio: remove references to gpio_chip::base from debugfs callbacks
Date: Wed,  3 Sep 2025 09:38:52 +0200
Message-ID: <175688512869.10115.2172054090244481140.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
References: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 26 Aug 2025 11:54:34 +0200, Bartosz Golaszewski wrote:
> We've stopped displaying the global GPIO numbers from core GPIOLIB
> debugfs callbacks. Start dropping it from drivers too.
> 
> 

Applied, thanks!

[1/6] gpio: stmpe: don't print out global GPIO numbers in debugfs callbacks
      https://git.kernel.org/brgl/linux/c/246b889c704e3209050eb0aa5a3733564aee1b38
[2/6] gpio: nomadik: don't print out global GPIO numbers in debugfs callbacks
      https://git.kernel.org/brgl/linux/c/ddeb66d2cb10f03a43d97a0ff2c3869d1951c87d
[3/6] gpio: wm831x: don't print out global GPIO numbers in debugfs callbacks
      https://git.kernel.org/brgl/linux/c/3767426b234f0d7b82ccfa05e53c47c83e0a12c2
[4/6] gpio: wm8994: don't print out global GPIO numbers in debugfs callbacks
      https://git.kernel.org/brgl/linux/c/aaa1279b8b5b46cc42b6175c2bcd83d8ac5fd2b3
[5/6] gpio: mvebu: don't print out global GPIO numbers in debugfs callbacks
      https://git.kernel.org/brgl/linux/c/2d71156cfea8391625ea146eff32b3d2ef059345
[6/6] gpio: xra1403: don't print out global GPIO numbers in debugfs callbacks
      https://git.kernel.org/brgl/linux/c/3be2d43534aab7291b59c4e66526f911854aa3a7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

