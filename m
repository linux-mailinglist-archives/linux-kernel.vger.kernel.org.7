Return-Path: <linux-kernel+bounces-805226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B81B485A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CEF1622E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D2D2E975E;
	Mon,  8 Sep 2025 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iWK/HRRB"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58D2E8B8F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317140; cv=none; b=jGXpVGp5H0paZGOSB8mcHZ4LLzRWygxlnZ4nHeVamCuzUjZO+tT+zS9t4VRSpjPaUWLVLMZVdukgXoiE6MkALa02i6Mx4cOP8kfSnElVrY2+BLWm+wuhunolCTkjXgJ+Z9hfVTvEa6JlDvx/hwQDJTsh0DZtWB+lY+5qDoJAocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317140; c=relaxed/simple;
	bh=I/8wO493tvKgW8VniJJ/pXKCPEHvRGo26tejxMuOh1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CU3HbmX57EKjMPxVsqmfOdJQ3k8sN9MkbRFSllBseI/cGY8Bnew4OE2cjFHBZf3e4Ew1QVH3ruMJ0M7duGMitPiFDzt48IuDiQPnd8p5vr4bAS174qiC4hzoGVRQixf8zh7LDfYacD9Tf8QENoIYJhErL59iEn47QMajDTLm0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iWK/HRRB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so24943955e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757317137; x=1757921937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SeC71KiTcmvc906xFt+OsD+bdUmNuwTHs5QzOIrc/g=;
        b=iWK/HRRBo41erD6gnD8N/6YXdvcglYZcubuDwTcBMcmpNQeju/baEfP+De2sbXmBlb
         jRY+4xH9gFN9OfV6x0hIm51heIk66vIZhXvHVNdkMxxQYSCBRnKZiTS22jpNFtWaGbkJ
         5OGi90JOSx5RrnTX8stEWrMMk1+f0xPZkL5LsaE0xnF3dk/omQp5tXl0fS9OJlrkVSKk
         H41gixtuq0bmuJN7HqLjAsDWuugVOB6ncKxHXa1OgOBWnHkeccXFX41/JziY076aGk14
         59VeCyl45grS9zRnqUa58voasS41YBfM+jlBZkGXQPICfMzLvE25kEG3SOmfd1sxNgVN
         +WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317137; x=1757921937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SeC71KiTcmvc906xFt+OsD+bdUmNuwTHs5QzOIrc/g=;
        b=Ol2uY2PYC36tL7D6dsjaTzUM0hXgrHWiwbAqdFmtNwHYt6DnZxGaEhsFXcjl4D4p91
         +fqnr3wbTB+t+YTOKKfKwKquPvQuq/plbxwKh67wi7E1OJ3iQPZRu6lztk2jzxXy2hY9
         0W/zYhF7YKdj39eihCXfJXGFKsBHwIM+iwFfOE/h4ySn9D2+vF5Owhfia38cOqDiT7Uq
         ihSTRwnCYeIT0IQ79P0Pghp06qpraBMG150JhSq8SpsIcXPAfTkXNLR+dz+8aljbOXp8
         LYjxBGYKTZF+v5/HI4CLR9hoUy5J7qUfyLM40VIaKxN6qm+tsXJ+5ZPdSr0tRmO9bjkc
         6Jvw==
X-Forwarded-Encrypted: i=1; AJvYcCWknniKPKh910SLAKlGHK+TTvDqvwbjth8ey2W0YD4+ECs0FOKOGGc26MsSFwHek8AJd1q9cd2VbtD5fP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiCPfhOPvHROCK98FWF7b2bT+O4ACdsnBMaRhS75xPujbzR2un
	VScYKUIP+0HtQfjEss1s/CwCau4Js9jF6HbjkXqxVbO6srBRfVcO+wZdiKsuQ50enXI1opHDA/Q
	eQcLx
X-Gm-Gg: ASbGnctZPyicIY8uB1gRVqLTSTy8h8tKtSEmjIacJHVUGW8cRVmRYOk6pZHvzcjbACb
	Vot42A2QIcwOCf/oOzwL6C5nnf++7tQhWmKoZZ3G43FZGCERde5cO3YmMCrIaq0vIsW/YZRPzxm
	cWA9r1HGC4AExxskbkh9jBobzOGU9L2/zknewRRUXTxf5YFyc1jo+M/UD1GJdrLcTsd5UgGOd1W
	YbAdtjvZSXWK7NYACTfQwcMAkAFrLQfkyexscmKFNtkAkPRSbxUVWQBODnddk1PFG/5TNslsrYQ
	mLmuQ7KC1zg90I3OBXucaRbJilkmYVHgJ1EhZ+Hjp/mmZ8BCUSV4uG8hzcCUq8lc72TU0gyHZ+c
	M2NeZC5Zp4kxh8HAlnRF9K98x
X-Google-Smtp-Source: AGHT+IHifsfv/Qynm+lweUW0TaX1cbTEu6B5/phXjByXJ7DDFPSF2vYdSkVq2b1g6PKImAH0XT0ciQ==
X-Received: by 2002:a05:600c:3596:b0:45d:d6fc:2509 with SMTP id 5b1f17b1804b1-45dddeb00bfmr69380305e9.6.1757317137171;
        Mon, 08 Sep 2025 00:38:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:5cdc:d980:b6fb:1eb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e92a42asm429977665e9.20.2025.09.08.00.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:38:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] gpio: Kconfig: Update help for GPIO_PCA953X
Date: Mon,  8 Sep 2025 09:38:51 +0200
Message-ID: <175731712487.48218.3656320884516812703.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <aLmtOWjAWPtWe/gH@bhairav-test.ee.iitb.ac.in>
References: <aLmtOWjAWPtWe/gH@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 04 Sep 2025 20:46:09 +0530, Akhilesh Patil wrote:
> Update help description with supported ICs from gpio-pca953x.c
> Include missing IC names.
> 
> 

Applied, thanks!

[1/1] gpio: Kconfig: Update help for GPIO_PCA953X
      https://git.kernel.org/brgl/linux/c/d3e7efad8fbaf0c2d6f039ae074a20c3aa89bd12

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

