Return-Path: <linux-kernel+bounces-755418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D49B1A613
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027C51808EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5833242D9A;
	Mon,  4 Aug 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mDzUYLGi"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801DF21ADCC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321583; cv=none; b=KM5jGBkXWRy7qy7Qnhr/l/wP6S80xSESTMtp8t877WSqZAOYnHE1YtaZnXuV41WbSfilpFX9ABm3BniIY2JHwalSmHTvs2vDDjiQPr6rL3GG3fkmhc8A/r+FLidCYe8DKlUMSDiYWfABiyE6VVLY/wM+Uk1oOkzEwjORfswZtAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321583; c=relaxed/simple;
	bh=IEV3WI8iR3tWQrx4B8sCmIPKxn8VMU7PesW2t6hVe+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jc481eYmAPx4Q4RtCwGo1vbskcJYldDI2TilbMJjdWfNiXzhiZfS9sbUMrokicPsiwkH5Kfp4pW3/q3wFT7p1/Mf17qR40qdXZBINLPy9xbl5AJmdKQ0UHLXNXyuNqAZACt3sdQeN6qFvBTrJXNWp0kCw6W+uLZ74Fhj7r0vrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mDzUYLGi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459ddf8acf1so5413285e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321580; x=1754926380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XY+MBRKRSJ9LhmXiUjg3J9ea4YavkXYPCieLQE+Ncn8=;
        b=mDzUYLGiJ3CMCkfqNB22OuUuuuQUdHfVu6NQg50drkhbGVK9g4leRpUaJ1u/vAmA1A
         IM6mteiH5FGfGpPDQILuEHwnvBtwjJkwjLr0/Hg6pg0cTvOHDS7nc1j/cpTcHinDzA3g
         /o/2DJMaa05cPtHfAtdInvjzO9vS+7svyA5CvASzSXAZQIhc2adglx0EDHZAhC3lEfhu
         WVvvTmJA35EneCB8Nipo0d7QOPJeHvbLkNWeL7K7J13DQdkvVa+ljUK7xJ/9YAYbixiN
         adF2PtCiTso0Z8Tb9O4727lTAqjloH2/Nk6R/ycZ3sOIS6lmncHrqSW0OXQQHQYHSyqT
         3ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321580; x=1754926380;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XY+MBRKRSJ9LhmXiUjg3J9ea4YavkXYPCieLQE+Ncn8=;
        b=BCL2s9hVG7H8Pad/B852Hx74ZofDwMNYPPOUdVOmI/ASvQHfpg6RgpuRrDEM2j2BQ7
         Vhp545DZxlzYdUoDxe4NybmmKWRd/OpT+4YSQQwAYO/JLWKqb71TBp8YJtOPo+zA0nsq
         ZQc3xsen55pfmpl4nyJGuVN83LeTXggA5qG2XbJaneCkGXd5k0PZb7ILXEvjtWkS1cy4
         vfGCE+5JzsbCU9iDtfg9AxeMV7jfRTsXs73yJOlo/HBtXHDYbjmPM1m+WSQOn9uV8XNf
         awekt/PWs4Fd3W2or8ZTrYAPiMGIb6tW/mDn/Qjc3nxNG7edHK6MvuNkOj5y2UfXtDKq
         RvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVW4zdNycXhxnf/Q5MbEl+viu2Xog/7fyw1X10wb6gVYYQjN3rP56HBamPD0GYjA2r4RQz8/oem7ixAQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEaxOyhH77SalBBHX42+2TFPvbOX6hDjHdnljszUnNamnRrxkR
	iH1+mccPlEy7d5QWbZZgooI5Dyk6YgHB8D2Wo1opW/QFvwmhLYdFLNPDJ5f38+3Zl3Y=
X-Gm-Gg: ASbGncuMVgAg+WQRkEirj2I3H7sSyVnnYYB5senOo9iy9+bEG5ANaQbvrXpUApK9n5T
	flPBYI0dB3Y03O6b/UpTjBCW+ziniLm2S608KkkmP9e6naQFuXh0f9SZgl9nlJ2zdB8TaCkREOq
	GwUqKGA8dC5ydaCU4so5A9GfbgfpP4avPnhxKURlT682fqgRntdDzKZIEGVG12vE0VhDBj8MObn
	hb1jjNJginlQj93DEhpDA2EX2eBpO+nteWnA8gjtNeI7DEfwCVlkr6WPNS/DLJfrpiMcQ2vpVQW
	YMOxuRUkDxjTcbiUeX9w61yycYyRdFpCWwGEXE517mhYtBMysc6d2NLKsJD0IQGfHLW5jyU9eTC
	oE6neVMBMJU4bTlwl6M+rxRijkeUbQv4gG3mHWYOn7tQ=
X-Google-Smtp-Source: AGHT+IEQreC1eHGihD2HvGw2z4zkQ8JJctAymKDEGjS+hjYaXiioW7ASwN/QLFRl5DugavcTRyqUkg==
X-Received: by 2002:a05:600c:1548:b0:456:1ab0:d567 with SMTP id 5b1f17b1804b1-458b69c6b97mr74959325e9.1.1754321579743;
        Mon, 04 Aug 2025 08:32:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47ca5fsm15664010f8f.63.2025.08.04.08.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:32:59 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250724112358.142351-1-colin.i.king@gmail.com>
References: <20250724112358.142351-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] drm/panel: Kconfig: Fix spelling mistake
 "pannel" -> "panel"
Message-Id: <175432157897.3671011.9847593575052354034.b4-ty@linaro.org>
Date: Mon, 04 Aug 2025 17:32:58 +0200
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

On Thu, 24 Jul 2025 12:23:58 +0100, Colin Ian King wrote:
> There is a spelling mistake in the LEDS_BD2606MVV config. Fix it.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: Kconfig: Fix spelling mistake "pannel" -> "panel"
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/368ea3f33f01b618bd645aa61b673f92e9aae767

-- 
Neil


