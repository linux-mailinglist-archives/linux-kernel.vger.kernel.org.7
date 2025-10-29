Return-Path: <linux-kernel+bounces-877156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D8EC1D53A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F1DB4E1ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6833128BA;
	Wed, 29 Oct 2025 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsQTaQUP"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CDB30E0EB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771539; cv=none; b=Qs5uMB9Qvm5n5ZN0y/+BnsPf5XMzwvDS/VlNbyIKJgYWRtv8sXhyD+8sAQADYLFxohl3t3PZyixpj83Mo0zdhFiAu4+sBCmbXyXwx7uvIm6Zq5QTwJeYbdph1ubm36KdXEChqYSp979BJcvKhGzFQWJTTjuPeVlSaeNj7vBi3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771539; c=relaxed/simple;
	bh=5HNgLPsLS6JburakamR4KuJJxf+APV5udpeuvti1r3o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DImZQ0Bcn+Jdx7l0LLvm9L4awCqry4tfv9Ymf+xf5TTR/BJR0wugMLQIxQdCcilUt9DRQEj/qgkNpEYTq7tZ/gWqngPYKVjLzUVk8tmBtu+yuGIXX7PmPC6+HmHotMqETbOlTwy+RXa6g77+6zrge9cXhu6WkNdeAKSXZelUB0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jsQTaQUP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so160029f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761771536; x=1762376336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdSLLw0p3z7nGivp6vT1oG25P9JcVKw4nemoD8BNgY4=;
        b=jsQTaQUPxSATQzv6Qy5N77POzIr1NX8AzzOkTeLSMsbQQ7UfxbtI/x+p0r9OLZMo87
         /5bEpksG/S9smzBfM29Ko48q74XA3u9mvXRHL+G4Jfyf39BQiiySJ31acCPdxvkBQwfA
         +6Z5iqG9n04DcJi0yL6nOZQ/IMWcDk5xZVMvxwT67N4wsr15ZCOe//J0BSGCZLvOOrui
         H+ThGEfobzeTTjTpZLUSjpEQY5Z1K134gLCYtSJlnXcRgjSwm85sz2bNbvHoDuvsgkFu
         VKiIrZiPyTzJ7Me3hjnnK8qX5HfoHcm+TLagJ9FXWoVO7HptouGOCxRC6wLvAFBY5SCX
         9+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771536; x=1762376336;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdSLLw0p3z7nGivp6vT1oG25P9JcVKw4nemoD8BNgY4=;
        b=Se4yCqdAjD0Yy0B8CxrWWMyksZgLULNJ5YC3HHB93Qo80ooPaaxBzLmECUtEVJk+Qc
         Y/g0J60vG4bqvzx8k/fH4OlKhyoFSIxdbKRbVxdhBpmXraBAMdmhXL+RxWJ43Zqc7Qzu
         F0ghaX3qV5xS1ZX8XZ7sEVRfONC8qdiVitxH4qiGjRHCOtf37aRdTbKD8yJiA8LTg56R
         oGObAYUCehOdIdLBO+upHeFC8iMFVSg9ZrHYRrmWV8Eunv+qTHuYyUf92O5J60p2N9mp
         9F59fAORwGZzEV5OLnA0KiZsHDoaLKMpkA9awc+hIljNYYC8hDVx31mQstPALy7E0rrF
         dFkg==
X-Forwarded-Encrypted: i=1; AJvYcCUcz3/VhkBOkKl0rJvVAeP+eQmYka+j+4CW1kyp0z6n61yCLYnz6K5pYBUcshmLxoEXpVaEC59Y/0uGXDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdqLZwVV9OHWXsFGa+XfP9h2oPW17TuYP8AeCyoGe/q9Ht9GmP
	gcfGv+dYRYD7ike1Xb8SOH1AmCVCcCanSnyl3SohHxy7g2EYDappF8c3uYjmvvybQqAKGTbRrom
	dMty+
X-Gm-Gg: ASbGncsHeknzYGJwZEREOC0PzaxnwTnKTquGmDokqU+WEQncsj18tuBXKoZHgeNddeN
	y3gPC3ZGoNaN08kWDiuvRLLIezHp+4MRGoM8DSHCFIpLhiXPEkCJCflvb4fa8/Z0AHdifxFO5S4
	F82bBvlMinqamJpg/JBaqDO83wj804/EDPKEdwC1yWDSTdamesaW15k/8mqTdUXOlCFKiJd9wRy
	cmpdv2yPAPCKpqJo1olFIpYMNG4rYJloI69pOGuPeehbTlOLu1SWl7jRSRWiL4mc0J+Wj3tPabs
	4T5HB8JLUwanfv4UMW6qZUyzbOcMXCdDaSMdVzCJcz1tP3Mys0qk5Z2AudmG5CoN4pB96Y2v+Hf
	It29rlzgAFFhqdaTKb+sQFg6tAk2Ls23ffXQMSEo3m4LYMWd+zF7sl8WileLP+Cf1PugkyYZZ+i
	KLY3W++rqhXoIdMnJUnZRM
X-Google-Smtp-Source: AGHT+IFVMHyp562BYRGWCjnik15BnXNlOH4y5IHiux9OZ9GHHrHGAoYYJnD441NGHvz13Cvns71ZAg==
X-Received: by 2002:a05:6000:2481:b0:426:d5a0:bac8 with SMTP id ffacd0b85a97d-429aefda6a6mr3692849f8f.56.1761771535660;
        Wed, 29 Oct 2025 13:58:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952ca569sm27596082f8f.12.2025.10.29.13.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 13:58:55 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Sebastian Fleer <dev@dwurp.de>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jens Reidel <adrian@postmarketos.org>
In-Reply-To: <20251029124007.232333-1-dev@dwurp.de>
References: <20251029124007.232333-1-dev@dwurp.de>
Subject: Re: [PATCH v2] drm/panel: kingdisplay-kd097d04: Disable EoTp
Message-Id: <176177153507.2036161.11759341734941100816.b4-ty@linaro.org>
Date: Wed, 29 Oct 2025 21:58:55 +0100
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

On Wed, 29 Oct 2025 13:35:28 +0100, Sebastian Fleer wrote:
> Since commit d97e71e44937 ("drm/bridge: synopsys: dw-mipi-dsi: enable EoTp by
> default") panel output on an Acer Chromebook Tab 10 (google-dru) is corrupted.
> The tablet I use is equipped with a kingdisplay-kd097d04 panel, disabling EoTp
> restores the correct functionality.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: kingdisplay-kd097d04: Disable EoTp
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d8eb00bbc628c8916ab0da2bb80059d48aa4512e

-- 
Neil


