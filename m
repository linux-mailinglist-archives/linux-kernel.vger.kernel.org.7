Return-Path: <linux-kernel+bounces-877165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B2C1D590
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59BE84E29C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5F53168F2;
	Wed, 29 Oct 2025 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AG+r7ot+"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14218313E1D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771940; cv=none; b=XNb/1NX6CO4JxRM2dFdJbebrKzKE60Si70g79o+fRicvwAX3pEALmx5R5K/XRVgiQ44DtIRugh30YkMDbIyoBoOHrbgUcKL1QhdhwZvtvkZOdAYK6YOOP6TL4BjccrlJdAIZg2rygaBqEbps3RUMnt6j6459mdwb0Z8AfmOiqX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771940; c=relaxed/simple;
	bh=m4SxS+TGkq5xA1wA6WqqbX3O7Z66wrUg5NUzgroK0KI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cA6+vXLc6hN9T9KuLIArcXhQPUtOfnkRmmSRPKIjjzMOqsftFv0WxmgZ1Dv0Vpb8ksjLVVpBksHdu2/hKxxx0k/uaW+3r/09sPsyIpBL+HSslQFzXMiXbw9+xetk4CzPryDb/5DEqeRZpOiTQaLHzcwrwA7vmbBm1fcj2fjc4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AG+r7ot+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4711b95226dso3961025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761771937; x=1762376737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaZEH0yhNHb6AZuGMp444IQPM11zRvvtSXK46Sjp70E=;
        b=AG+r7ot+VUYWJHJxBReSOLko8BrfChiNzyRYVIZ9DUiUBH4LB6I3OCt5bw8snXa0cC
         uPF++hXM3VHfb5qEPza7g5toDmL3zbWD11QSPzsoZGzNarT4EGOtOmBXgkyv9sLuwea2
         XdAcvdyM6eqQ90q750DnvZnPHulN3EV1A0sMARlCHthKC6MbRkBUgteauz8DmHk4goHz
         Yv/MvBEqy3JkFmHe8fbZQkyZYQTS3vvl71aGFVaF8xogtACAeMB25PwaOSP62u/jcZH2
         KOmer5rwLrY+nj0M95xn7d4/plxJxQ4HlB2+so/ZdDjcij3ixWVnhKxS6bhAC9C26HI3
         z2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771937; x=1762376737;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaZEH0yhNHb6AZuGMp444IQPM11zRvvtSXK46Sjp70E=;
        b=uWYx8NXI5hmbefwEHoFeW4SD5B09Cf/njZkZSar1rrtEBYb+zyiix7KE+dP8wh82jD
         kUB5hqpPth1b3frztxhRAwt7bSneuDGyQWki11ZA2Bz7a+i8sFFK19ZVtCu0naF4Bj+i
         GIi2BPZYEZzlPI9IFDZELMplIxnM9sFKHcEgW2y1gUgxgkJS84lm/x6H0pMX34Exdznm
         dDt6hdVl/a1mjoshz4b0bBA2RzYWsLmeoXp/lmB3548mzf8cBg4ZxQG2r+SZ4pwATdph
         veSOThFCjusu7b1GKaSdzhgqPYm3T7bH13X8QJ2jID+Dc7DbfE8W5rO6fQUy4zZ8wrNu
         RfSA==
X-Forwarded-Encrypted: i=1; AJvYcCWwQUKzTKq1p9nKL5C7g8dd6GNduX0s+ue9ygE9rOJgMtUhLg2L0f3lm6sFv+PjkudIl1JlLaHJpY3hgs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbfwQGTH0ON644aisWo/35Kg1aooqQrsAI+GpjauHoDJqDvY64
	AiclTIdQJ8tIr5u9+eWtKMTD/3NPnPcTCf8MoYCMo3DAFSNAwG4UeVq16m84kXaO8Gg=
X-Gm-Gg: ASbGncswtHUQRnPASG3kTKJ8Ue0FQdvkBnpTIL/memUk3NuPvfGz8J4r0FS7bwJ9v5a
	hsRr/ktZvDXHlP2lDekM2c4HpthjZgc4ELE/oYRiLqnhzMLQgIj67d3ANGs/Wbs4HR/T6ufZdl2
	PIsmEfyfhHYCZ9lFjSFIZMTaMvUWsDgLvkQ0wIcnOWu5x6E3w93bf4Y+QbGxnwAOrc4lvwImB1F
	iHAJCCHlTTGcKtLgI5jfV/5NmPHSZwAAGNou5mcogm1wH4J+7fDjPklpf+IWXOn09OLrvhDGOxn
	FICvyfNOmA9MWu8eSnGRshDnrAgVfWNdwX+/5VYrTgQeo7emdxxX6uKQujpatBH7nXTK/xBqJff
	JLld3TgisbsuOeUGQl4MZ01X8YSoQFTD/lGGmGqaNiN/DwLcCS7+/pi3pYM4xBZdwul1682zvKz
	pSzmyOChZB1y3xUbG1bKwd
X-Google-Smtp-Source: AGHT+IHhwfeUBtBxW50VBHrS7NUwmZJ+MJHKstiaDt5zo7z8vEMuNxb43BjkmGAxCqpZCv4tJ3jB8A==
X-Received: by 2002:a05:6000:2282:b0:428:4354:aa27 with SMTP id ffacd0b85a97d-429aefc9a12mr3241114f8f.46.1761771937287;
        Wed, 29 Oct 2025 14:05:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de971sm27815109f8f.39.2025.10.29.14.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:05:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Priit Laes <plaes@plaes.org>
Cc: John Watts <contact@jookia.org>, Ryan Walklin <ryan@testtoast.com>, 
 Christophe Branchereau <cbranchereau@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250619132211.556027-1-plaes@plaes.org>
References: <20250619132211.556027-1-plaes@plaes.org>
Subject: Re: [PATCH] drm/panel: nv3052c: Reduce duplication of init
 sequences
Message-Id: <176177193662.2073083.2838618250714859498.b4-ty@linaro.org>
Date: Wed, 29 Oct 2025 22:05:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

Hi,

On Thu, 19 Jun 2025 16:22:09 +0300, Priit Laes wrote:
> Although there are various small changes between the init
> sequences, the second half is common for all 3 currently
> supported displays.
> 
> Note that this is only compile-tested.
> 
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: nv3052c: Reduce duplication of init sequences
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b21c47d71bc321785d61e6649bf1992ff157514d

-- 
Neil


