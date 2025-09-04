Return-Path: <linux-kernel+bounces-800817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69438B43C75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB3D18902C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9642FFDDD;
	Thu,  4 Sep 2025 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eCmLNBYR"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8DE2FF67F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991059; cv=none; b=K1KRNtQ7JUCwOQULIxr8ohgzqoV4+wRhl59dpb4O5Hu7afKJ6jJKzbEKLkewp/yo3YYjUi1R5RNM4krWomek5joiKbBN2lfUB0EQB+ONb6Hhiz6E3pFRcbnt5eKi1vfek4/+Y0Mfdmk8i0vJ4XBlmit6Nh+frDw6mqoa0xfe23s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991059; c=relaxed/simple;
	bh=LtdaAszdeXM6G8srz/BQF1PhrWxwy2ClWglLzRn1I7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JY21ydn6leAxGeMmcOxjvXG+j8YNDvBcuR/PuYUHXpNUYZYC4pD5arK62/Gc9ACcxgsitsvOdWiMVOJqjmmSRp1F5b0VY8cnldm+oZ+H8i0xikXLzysyim+anwppmjq/7OBaHO+e9SsyBG5HDc91F/DFzgTIGgQBpczV+2a1wCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eCmLNBYR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b8b8d45b3so9357765e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756991056; x=1757595856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJ2yny2AZyLw5kGAtNbOv6rkTL+h8EX2jliOx5kuaqM=;
        b=eCmLNBYRh61qT5a0eRCIwGzkvGk6zhqTpQLdqZqjJpgUIOQ6OL5aeg2HgNpKgAKLp+
         A3Fm825v/8cf6JRrQLW/7FCwjZTmdJOdsXYcK4H+RzW6YxG4MS3T0P60dsrzZPu2fjEM
         q1YINTy9QSZZupLVw4ccdNdxJAULOpeDQ4V8ZbeHoKQHG1CVyS8GmWsdoD7T9Tq7Col9
         aYmBBTBHl26RufyIOkV7k3UxOIL6nIALbLoMZpODJDjVYA3NFDh5DPkUkCt4lXEMWU6J
         AbeGGQEF2t1btuHUeISMLl4OJuVwhvdkTYZCwhgbnZ9YMRbHg22io2FrV/60Agi8MBmN
         QBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756991056; x=1757595856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJ2yny2AZyLw5kGAtNbOv6rkTL+h8EX2jliOx5kuaqM=;
        b=vvgZLur/Rc86fsRNtTrug2kzkutSZ2dvPZWGsssCgXSenLrlCkHTZUNGleB1shCY5+
         bb5IyLPQrbPzBi4WisRhRLZm/ImBha2qNKMaxoU3VOQ5uJiyUrv7Gs/Tu3cMY/VaYUYh
         SNkj1GbQH6y7i8kycufG5LyTmxJ2UxF1xmK/NM+cvqiezpjjnJ4tgDCGkeaUI9X3CoJS
         eJJTnyKp0h0V4QEIq3LIl/3T4bFig9kgLm4ILVf9sYwum+wAcx0VT1BA+pGL3hxWvh9J
         rFrvMOe6TcfBGGJtFwhwp64cmDgfFcxo2Ykrz8ptWmtKS/hiqNjHg3+7wo3X6igwtsd2
         DHbA==
X-Forwarded-Encrypted: i=1; AJvYcCVNDuFz+WyUfXYsRN+YOaW+B/7qpHIs3gpnGtscXLDh/VnKFOPSlG89U05PUp6aO0/33p9FIOQd/9g9ccU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWwq52HjE0ijXrLeA2Ju53nUE8CL/+SXkJbxRs3UDQNqcEUEN
	UrO6hNuw4GGDoRTO1e0ruYPN3Mc2kiW9yrUkFv/Y6pEZ4Mc9GFvtCsmx8DsK325G6ss=
X-Gm-Gg: ASbGnct2+dTA95EPjNn8nok384RhzlyxaGkpNCd64EEE+iIcLx10yqftY6cG3RhmvIS
	FY79lupiCtfIvzRLY1O4ts6wT9sU8o17dqGb6BVIdwOYwk6EWikvRkplrc8LMCi0+XetA5kf2QC
	hUs4026rNeKr/hjP3Mlc4U40bhaDNVCY5xB5jbVEgo4TadBejEyJRw37kn0QRH3lvbtxCTIfjw0
	cHT5bLc5WnYLEz5Wvvf24oecEW0SZVuvLlSrVRnqc0yeByFo44wvZF2yXb2zt7+tHQGhkyy3SJT
	X5blh5y2KDE9dbrLBusJw6DJX39io9atTMCQyZOCl7QCP9uJLYcd3jFFe/M/dDrxdfg/2ZwxHdR
	Mxk6fzU4W5gmrgPEHcc1KrQeBTt1fTu7hyA==
X-Google-Smtp-Source: AGHT+IGxBimr8IyZ1DY86cVwVfp94kA87fe9hUXm7C1nUfS6RvrRyv+/zG+v/lPCzgh/LN8QWSMvOA==
X-Received: by 2002:a05:600c:8b23:b0:456:1dd2:4e3a with SMTP id 5b1f17b1804b1-45b855506e2mr155178225e9.3.1756991055686;
        Thu, 04 Sep 2025 06:04:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6e82:a4aa:49e0:a7d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d701622b92sm16393258f8f.58.2025.09.04.06.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:04:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] mfd: stmpe: Allow building as module
Date: Thu,  4 Sep 2025 15:04:12 +0200
Message-ID: <175699105010.72115.9734506229516403389.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250819070458.1027883-1-alexander.stein@ew.tq-group.com>
References: <20250819070458.1027883-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 19 Aug 2025 09:04:57 +0200, Alexander Stein wrote:
> Export the core probe and remove function to be used by i2c and spi
> drivers. Also add necessary module information so the drivers can be built
> as modules. This reduces footprint of the driver is enabled but unused.
> 
> 

Applied, thanks!

[1/1] mfd: stmpe: Allow building as module
      https://git.kernel.org/brgl/linux/c/df6a44003953fb23ad67f82d299e439e7ff7150a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

