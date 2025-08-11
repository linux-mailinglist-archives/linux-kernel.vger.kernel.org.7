Return-Path: <linux-kernel+bounces-762160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6503BB202D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7186E1680BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373F82E0408;
	Mon, 11 Aug 2025 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mN0lDivT"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C92DCF5A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903427; cv=none; b=mwHLwpmq4MLnkIxhFkoUXeNzwLfeKXQBrl6n1X/R8PU6uZkKIgBA4xydcM0IJi16gszr1H/tbbsFYP0dpw4Z1qi2WIVSLXCRLXL0Fojto7ZsmzjlYcAAK8rhJVgbbKQcXJc6MUvZMIG+jJjuzXTOZHT1XoT1dPADNDw3eYe/zpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903427; c=relaxed/simple;
	bh=GTK6PH2GLJ8zdSVDaRtEO8SDfY/2lLgVp3FVW1DDiu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmv8ll99NhPFequXp1gmfdrQ7VIglwu5QQOTQ3/Yzw4GUS9QEgadeugDV/5rQLQqZ35YEk90eu+vGpt5vwhhQ79x4RrY/qwf4lFFYdYT6WdLHGNuHlbqjsodGzNAJU2jS4H+CL+8NHYUdO3u5ZPAVDZXAKdAFeQSykze1szl+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mN0lDivT; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b792b0b829so3991959f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754903422; x=1755508222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Qn1l1+ZBQDpWHIpCv84QlPIvcnD4wklf3q7JJCJ7Zg=;
        b=mN0lDivTJqUAj7KjwFxGLT7b5TbbuJwp6wlEUE6xNJkgcPjPaQnwwB3fQlRUvRUEkz
         uP1c8frszNctt0GmMa4zDthhRYNY/4zrg6kgbBtIEyYNWMPR4/jfIhIOA+WG0/wLelPM
         t1pGuAjO0ERj+layORSrxMKo3fV8GUWvb0occv5ApT6/mYszUEcrly91OKIQ3QGDE80N
         XplSB3uYKu4S83Lj+AKk1rNIkm9E8V54hvT0WBb2BZksVrl8vL9yabLjP+2aWT8U1U39
         acPEyKkaqrwjUhu3J+Sj75P/rmK8INS8VKsrPWt0yEr2W5oxADEsIsC+McL81aoG74fV
         KNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754903422; x=1755508222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Qn1l1+ZBQDpWHIpCv84QlPIvcnD4wklf3q7JJCJ7Zg=;
        b=lJ1/N/IseDvqqvQx2WyBGEk8SoQta24k9rK4D/crnE825yrDx5tOV/lTodLNdRn3bj
         9TqAhJHSLhafCyfnlXTgP7l/iXZEcK/vN3kxvvzKPGgDC/DBl4nKgDWytzWEWl9oCyzX
         9ucNxNLpMkHsyRMM/TvbY0SIFWedCRp3mWjHLhsQUqKMgeJzJT808duheY/gZi4Tt3xL
         fOZjQ/CTnR4BMcitxgmK4FFkWtMUt6LOpMmLGlgehKkQ9Xwc270yqPvO1jX8S1epnF3+
         zMDHCYcIf5MTJ5HcLITZJkS0XQYnJgONkMC5dLU1/2eSGnfFOdjzis711z+sntNOdr3l
         K9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVs0x+4pWbL3jnDKqI60dskiTUbAek4WpKj9GEPR10A6yntR+BNu3nDIQvDBArt4YujHJeNrfcJUHtW8vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVtr+hQoIV6/18bffvXbr7IW7KiiAgJSdIBxO/m177EF1WY7WR
	VCV7pNgd32y/7ZicrFBpDdOGCqIXwXk1T/qxhQFkNartd4qAQsBbF77topXbDry/DF0=
X-Gm-Gg: ASbGnctPz6+BwWY3ui0Ro2cHOpVaBf9zURDKlyHrJJo76wXeCDq7SPIt2o18qE8YKiG
	ZmixHMMk+98mVeL54WxNpx/CMBG3nc+D0anBVUff9+uzcSQJH9aaX8f/XXBempFP79dafSiPMPt
	jT6jjY3r5oBO/T0y+Bj7fQC9XASaU+VFBh5loROH8gOSPAr1xI2t0e+RsrQ5Y3YBM2KNxU1BEgU
	GQ+naDYtoaKdeTDrJY41TSI4CdC2W5JYaMgR29WoYRKytG2WMRJglW2XbjJL/zpMaUAGazI7hpp
	M8y2BQiKMtKjivP4A4mldtre+za2FQvgcGTGKwYUGT88G8sS93QepQd3mjbOeCdLPGq6yXtUUZ/
	mURWXZhSGoOgQUJhhJ8GyBlfY
X-Google-Smtp-Source: AGHT+IFdVlgR2Uf1ca3NIwmvbqqLhuhd81ZtRnQK2kc8IJiQBuEcYZM46ftlzImE+aVrkBs1IL9pwg==
X-Received: by 2002:a05:6000:2010:b0:3b7:9d83:5104 with SMTP id ffacd0b85a97d-3b900b83ce4mr9953008f8f.51.1754903422254;
        Mon, 11 Aug 2025 02:10:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453ab0sm40220239f8f.44.2025.08.11.02.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:10:21 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] gpio: stmpe: Allow to compile as a module
Date: Mon, 11 Aug 2025 11:10:16 +0200
Message-ID: <175490341188.22509.14430833125542251906.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250728060544.18169-1-alexander.stein@ew.tq-group.com>
References: <20250728060544.18169-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 28 Jul 2025 08:05:43 +0200, Alexander Stein wrote:
> Add the necessary boilerplate to also make this driver modular.
> Keep the subsys_initcall to not change registration order for built-in.
> Also add OF match table for module autoloading.
> 
> 

Applied, thanks!

[1/1] gpio: stmpe: Allow to compile as a module
      https://git.kernel.org/brgl/linux/c/03db20aaa3ba3998b5a025e243b04e33b5bdefa5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

