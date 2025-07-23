Return-Path: <linux-kernel+bounces-742114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA09FB0ED78
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB983AEB90
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DDD28031D;
	Wed, 23 Jul 2025 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rnULUYYc"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AAA2E36FA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260113; cv=none; b=PleWa4Ohd3euWxBGyAHek4+KlT2WqeL1qcxAigYJySJoYQfhiFyRufq+GbgRkvfT9suXHTGCWBvDB/Ul8xqWWpE/q0Ra/U74ZCDsJwlUgI6nGjy7n7G5hpn0/GcTR99IVklL3n/lazUeRmd19NeED4k1wxq0qJPes89MHsW8M9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260113; c=relaxed/simple;
	bh=KPyVi5/nZIxHwgKBKEtm0zjwA8f1A+achXnMoLW2vT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCU4cRkI+ImZE2Qvky06zoLRMf2BCliJ+onMeD5FWAkyV+Z08SRA5VMEf8GnE82RBv4cKh3VUMvTVV6Cu3a/tKWPFwX2vs9Cxd8QpwfJUewt0e3+I+emuaB1xXW/hsFwAuWMmpQNVxBtNWTZ5BFJJal8XXfO+xkO+CklxAO0cq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rnULUYYc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-455b00339c8so45866505e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753260110; x=1753864910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IH2wjrzjfdJrOxGA250VAbjT2mkP9Bdn7D4A8cGWXR4=;
        b=rnULUYYcg8/jtFdUraWVTX7g94L77SsKP9NMZQUDuePXW2SYPcVlih29fsLMU1h+QQ
         wKRA2BzDYBfM+sEx11nJB3OB1Gnb47TzzOC8qrDTzNAe+cIYG4ChUrPVdm4k5xbIkTvm
         WuO6u4v9glGhV5A2zf1GyFuj19DRKlQqu2Rx/rTatguR6kggdYTq7heZmv4SG4+I4+6Y
         PKO1xbpO6xntn4f3knB2gxsGxg6+b1j8YQvYBpkyHrV2hLtVbqRmJgNYmoCsAmPxH7ur
         3vPwTjZegba3vbI7F08O2MMm2tTJMdaBI1PkSn5EkTNCZST9G+rLJmEayuV2wY0SV7tI
         6gIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260110; x=1753864910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IH2wjrzjfdJrOxGA250VAbjT2mkP9Bdn7D4A8cGWXR4=;
        b=dScG4helnnToTK3dObqic8h/RsX8Fk0oRnqLyyU6NWCDaBUWIe2GZCty2FyUJS5gYE
         mOK0yiT+q4gZMu/7I2+hnffWmW/Kk1xaegM7AxiZQBhX5yL3pwEhHtiPcVaU5BeMWcWL
         FFtZQDNGfEOukYkJ98un4Y3UcysGgGkwGe/FLIRN/g3Bvo96009zsJ8Rlogtn7sh90Ti
         xuPRzIftxZYbbPqIZKwpc74ZWcGTUqeSR5bOjr25BTOexCZxOMMTtIH2kvqQ5nhUeKkP
         xAYtnfHeUzo7kUfFO0TFi2dC4BsPa6pkMfWz34qHlrTezvqKnoTjBXoRRH1LNBGrm+Hc
         wtYA==
X-Forwarded-Encrypted: i=1; AJvYcCW+MZ2XJ292RW5kXUbmHQcrHlmfjGtV1bCC1CBp5Ai2Nnf1PJNYJfNyIjc0QTN8BqME/P+wUOb4ZqgFkOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygmZIr6IFYGzBVZdx6RJAO0pxzi3LBFX/kETeLn8n1tFhJ5vdl
	NgR83cXbn0/eTXRoaC6Oi79brw8x2VXJtiylpP7CL8eCEpTvI53/VMafEXU2l0GifUU=
X-Gm-Gg: ASbGncvBHIiKlLcwmtDvwT815q8tKbkgXK2UKT7GYy3DsfeycoJe3PvlKldYk553V/Y
	NNV8Q14gon3Pz7yGFkDY95xcmyUYbC05PJlv0lsgbJrPAAzidt8vVexu4ufBnztp1jrfrlWg5VC
	YMWL9N0nKj2pjQFPwqJjKVGQ3fS0sQZ3ucWN+JyPFKuXhnjGQgO08Np9umDivmECtb7MKZ1TUQp
	bsq8vs2ehf3RZa3i0l/HFXgYnoBySFuu0jEL0pzJ9MVSzLZrDYN8aqEenKSBFPU76gDp7uBsNu3
	5W4JWsvERClLxzWpNRuVPre0NvwUUB85XsmHGrM1tfPq1jpEgQtSBkDQViHbqQg9YX61NfHd0eq
	jwWwh11mHLzCmt4IbRw7taA==
X-Google-Smtp-Source: AGHT+IEnkZ9kTvvy9gav3s0JzoKsMp4FgmfJDaesNEPydYLSgAB6l6bF9ogt0Gu+vaSL9hZoEPeqlw==
X-Received: by 2002:a05:600c:a40e:b0:456:2698:d4d9 with SMTP id 5b1f17b1804b1-45868dcee82mr14396555e9.3.1753260110040;
        Wed, 23 Jul 2025 01:41:50 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:34cd:b1d:d4f9:be03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458691aaec8sm16123955e9.23.2025.07.23.01.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 01:41:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	Yang Li <yang.lee@linux.alibaba.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] gpio: cadence: Remove duplicated include in gpio-cadence.c
Date: Wed, 23 Jul 2025 10:41:48 +0200
Message-ID: <175326010614.34828.11615771707320405154.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250723064608.2178024-1-yang.lee@linux.alibaba.com>
References: <20250723064608.2178024-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 23 Jul 2025 14:46:08 +0800, Yang Li wrote:
> The header files linux/gpio/driver.h is included twice in gpio-cadence.c,
> so one inclusion of each can be removed.
> 
> 

Applied, thanks!

[1/1] gpio: cadence: Remove duplicated include in gpio-cadence.c
      https://git.kernel.org/brgl/linux/c/ff4322b22f35c010643de16c6f13e285bf314d83

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

