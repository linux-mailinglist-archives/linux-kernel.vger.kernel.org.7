Return-Path: <linux-kernel+bounces-853943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC402BDD229
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A99E25063AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2CB199385;
	Wed, 15 Oct 2025 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoUOpIzE"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D22153E7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512957; cv=none; b=kkqri9tJ0tQ9UsqzwcEoLlqGNJOz3VEHjk/UPyf9SZuZaPPP/I9B35vQRBj2YFjF1NhS/kL3ISJha8sylh+k5tyEoeP0JO2I774Bs/54OPeyLACaaJVgQHilWCn2WdoIp+sGrH8oL75gE+386lPcRKkRvCQJTtmbakQjojsdTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512957; c=relaxed/simple;
	bh=0VJRnfC9n6Sgwi/8S393WIjXh2WBrAMTy+hehdyv2SY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=trRKFjHuu3kPwQ7uhSDNHOfAPNqdvZk+5CUabftBJBxT6shPmaKCqLLtfwrFqcP+aF8X3u5Qx0mC4MAFEv7jflzEXYgpThHaQI915w0zhcaENrep+YOaRlxMKapauWCnB6oQvxhjtnHeCcMpOuV5f5Xl8/DMH93Wy7IQYxKNZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MoUOpIzE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so37028535e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760512953; x=1761117753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPcOIJjAqivuI68Wr991lCzvZe9U95/X4cXzOMjHBFM=;
        b=MoUOpIzElO8jQxBvwcgAf1UpDn0bu2jrLg+gInAMroNIEJjGOwF5VVajYTVM/nXk6r
         FyvxtYhGQltT1GY++mtgjcumkmIR9K2QFePZNOZLCfmOCnOIVv2fP8XY/2Czn02ci80r
         2vImecCDFgBbbN+J8UbyDxwndxJDr/iQx8vzd4Rw/jVydysKFYs1yDd51AEjQWM8tPvP
         Bq3JH4Ebhz24ILbzbbGfoU7NLBmMGnMXAOZd24/9KWzFQ4qJd5eC65vNSOV6lnr6Vv1A
         wgKL/oli99B9wmgl8a8RN67evfU071xvQhVTEisJBz6U3liXM9Ujz/LE9Ec9Vholl3N+
         d2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760512953; x=1761117753;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPcOIJjAqivuI68Wr991lCzvZe9U95/X4cXzOMjHBFM=;
        b=V4U8qlaahpvmMrRHkcz4KEe7iRorZAZE89ANIcvqhVSfH0aFzsG0Cuhin268DtZrrw
         BchsPMWb10P5wFCoxncoK2qIrBIOcaiT+8bjQnHwV0Ezv9bPY7DuMewlpowwAs9jxRGk
         hbDsMwCSQS6SpSwZ2/07iZFik76U+bsFmpKXof1k/L/yQ1wvrJH+gXD6FnGDktUIyYtE
         lMwaYUE6QpDoExk/L5bAS6iLzujJE6spqXZkxaZexNYbHGNo7edkNpG1qwssjAZLvkAB
         kjXfPdEwaaya5j1NQEyUCb3htTHOLzH8GL98z68JNGus+yJBE2CssSJkNwSFrV1Q65d1
         Xj9w==
X-Gm-Message-State: AOJu0YwMnpWNNcfN5YVXC8Vcxxf4BCq2da8S4K5KzQ9QQocLSEb3chx/
	w7mK/zU5t2E5tWyEo1HRs6wou+SLHRacu6aF474/e7zBWGrFP5qVIV5GjypZktJR9E7L9FXKjeh
	jKIHa
X-Gm-Gg: ASbGncuxOVta/mcajsXiFVHZm/6mWtWcoP4Zj40VrvDRuul39r300BLShK+PVHcLKw2
	ZOeqfUsox9qnm5FkCkJK5MohEmDA3BYSngdKWcAjF7hcQpx44BMlOS441xIpL2q4BINLhs8BwRt
	oljwQxpzWj4rpbB00D83gz9qEF2s+cb/BzHN1aX0GRZD/IOehZ72nP6Xgpead/pD8gaNdiVLo5q
	F+rt4DVSXY8plEGGwvY8E85ayPZUR/kGzuRQHoZTMpOnlfuNd9KT7xLryNlA5mqPAkt2WhuVCEW
	/Pq5XdpCfTuW+0zFPvI+jJZnmlF9LhQ3+w9m3TihqYe5alrYsqaF8Tce+L7Cha/2yfwtXHR06V+
	obPfliUlWae1+jfFF4ttUkvfWsWbcVHTI8tPR8IBSEkvVtmjl+PVK6v/JCwUSPjKKOw==
X-Google-Smtp-Source: AGHT+IH3BD5WhA7FG6Zp4c0PVdvEcLCxk34zjohYVpVCAm31anzYKVfvwlaIYZ0XuSu0KRWu7NkXdw==
X-Received: by 2002:a05:6000:2dc9:b0:425:7e38:a09e with SMTP id ffacd0b85a97d-42666ac2d01mr15689229f8f.2.1760512953270;
        Wed, 15 Oct 2025 00:22:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d4bbsm27804930f8f.2.2025.10.15.00.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 00:22:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Dmitry Baryshkov <lumag@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
In-Reply-To: <20251002-quit-qcom-v1-1-0898a63ffddd@oss.qualcomm.com>
References: <20251002-quit-qcom-v1-1-0898a63ffddd@oss.qualcomm.com>
Subject: Re: [PATCH] MAINTAINERS: Update Jessica Zhang's email address
Message-Id: <176051295262.2274368.18317625493336873860.b4-ty@linaro.org>
Date: Wed, 15 Oct 2025 09:22:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Thu, 02 Oct 2025 16:57:35 -0700, Jessica Zhang wrote:
> My current email will stop working soon. Update my email address to
> jesszhan0024@gmail.com
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] MAINTAINERS: Update Jessica Zhang's email address
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b076ed3017529ec528f2f28b8f37242a6a29a4b0

-- 
Neil


