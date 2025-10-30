Return-Path: <linux-kernel+bounces-878011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A72C1F8F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FBB1A212DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0D43557F9;
	Thu, 30 Oct 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIdOhvzy"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEABD350D52
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820139; cv=none; b=O48Mj5AC6LMCDuAI8p3ahQNZ66tg74Ya+IEQv+MTgZfs0q97UJDIc2rlkV9uo3uBBcSmwNrC3XzPRep4WlAIHa3uxjHVAklBE8143o0muJD4mLL51HoGr221sybqHMThpov/HAZIa0I5y/xDnJs0tRqldnQFO6EGQiJOUMP4ZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820139; c=relaxed/simple;
	bh=kzl9mAH6hTFguh9+K+POMEtXKft/c/zYEBMgKAxiGv4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy9wH4WmHfxUq8BaIXlKRG8APpYuDoOshT/MZ0q0/mLYOiQZZLUlkSlt/dLk6yJ1gwjqmcvjeQqXaLsz7WDcUOffA1ktMXTxAEwX6gJ7x/8+Bt3d3gmqOVYDQlTlvXgz+k80C71c9Bi182vfd5LcxSC95bQwKuHmfWqbwmG7P/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIdOhvzy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429babfccd9so226386f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761820136; x=1762424936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc85XyLkyjY/htulnzTmfDFLZeGYW80xA63mZmVSpP4=;
        b=ZIdOhvzy4lEw1lg7+j1FE1TIUNqc1hJe8i5Qw3bNHt4BC79AQopwHEkk10xWbRP6r+
         dIgmBXojmjuJ9HGMdavQt/atIgPMlz3BbKB2S7PgG88uK8piBO2sX6/9LnfCjG5N0Y1q
         Zz2poSYRNqekJyoO7A+2K5KcmJy0o4K4C7uyTfz94GCpXxu6DShyKEbfbSMkX+7PVJPq
         d321msZEi4tP9uX6bE0zot25pqNuu/lEGqEiLXu6aFmjQnzE1ERBy78DMHBBDU3CXq3Y
         HYiG6d+aCKmP4KbPKhUYpnrWO7uyi/d9vqvfXaLCqVLquCDaEHL3iXzYzpj1xmR0VkUw
         ltGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761820136; x=1762424936;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tc85XyLkyjY/htulnzTmfDFLZeGYW80xA63mZmVSpP4=;
        b=qUGvJjpRgKSvdseDkls7wBlozdUHc4Nkuzfxo3tdxTZA4iZesL9FwmvRujSYILJNYf
         YT4ExHyYU4PMk4Sp4gEupJi470TgQYNFaiIILhtR0Eho0dpLWnC+T99Hj67ChzhSl9C+
         dfFEZMK0q7Mv6qqeZ+RadkeNgQuUiMNC5TvyvhfMqVbTmHeVg9dusxjc1GMWtaJkZePa
         F4DQyBVCNzSWyOuczTkAlN5DcpPrO32TPm3LG7DtPikikgtppJVGpp+MQ//3yTwOpOBU
         ZFRiziLmnEFQBRBfHbk4rmcQn4wPRudI6DefDdOT8xkVyklLHozzZrNaEzT+Ye/s+WxN
         27gw==
X-Forwarded-Encrypted: i=1; AJvYcCWJo4+xzw+St4Pnd59YO3txGlCE4ayR6gC8VuizSxJX/3jS2N4EYrpwb+5V5MPg4KxHhoKajafC1nPanEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT4mPiUGeC7laTuzTG03+l5ePBdZ8ETj9IcWcb9QJl5Zu6QYkr
	e734ug2ZbKBAJ7aVB0oqPfhT4WrIPLCIezk/p2tU7kkJQALpZk88hTnh
X-Gm-Gg: ASbGnctx44MrSP8CutAkqzZzWPTyiIbYMfjMA4sQ3DXLpLUZe03gj1F30/gJTkXcpLB
	7riuN/JnDZmHHn50xQj+gXvlvdWVtWjGONDvBZr5uY5lr7OPjOEGOo2jQrdDJYxD9U0/kGqrLkX
	6Sx7XqXJpePC2dOeGCTPtMHXvEjoA9a2TmyfDUsbOg+S3urdQJi84S3ovXHF3yyVDw72RYiyXV0
	wXbcmXhewHGvF27ayPmK+t61sB7m9nIrw2rsqnpDlvFhZbYGvVu1sT+tevO9y1iVghLZUuMX5rg
	BTbabunJwoxYcB5SRhRUkwuViK5R7+DotfEAlvDZiqRHpTQwSAZK2ARWzUTkJLUrXbOPwiW2uzz
	t3EgqWKyPjIB5SpcmB5r7/vRveyNjSrfkJfcoezbW7VeCNDP9vUKy8HrTHlv7UUvPPJ6UrZPVMH
	P4JmdBT+Ulab+Y5vuxMKgUc3xjBEge4Ya9Wfs4osw=
X-Google-Smtp-Source: AGHT+IF3Pmj4qbCJZe4BCr+sht1pza1y+0oRqN31cQl/tVeOBCZYjO0OsuO5WkG0CsnxbyhqDkQ6NA==
X-Received: by 2002:a05:6000:2881:b0:429:8b8a:c32d with SMTP id ffacd0b85a97d-429b4c97e26mr2412283f8f.31.1761820135994;
        Thu, 30 Oct 2025 03:28:55 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899fdf0sm32153555e9.3.2025.10.30.03.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:28:55 -0700 (PDT)
Message-ID: <69033de7.050a0220.34ea6.780b@mx.google.com>
X-Google-Original-Message-ID: <aQM95VjGr9NOrwix@Ansuel-XPS.>
Date: Thu, 30 Oct 2025 11:28:53 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <20251029133323.24565-3-ansuelsmth@gmail.com>
 <9343108b-7796-4783-afb1-afe758f78414@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9343108b-7796-4783-afb1-afe758f78414@oss.qualcomm.com>

On Thu, Oct 30, 2025 at 09:56:24AM +0100, Konrad Dybcio wrote:
> On 10/29/25 2:33 PM, Christian Marangi wrote:
> > On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> > case for some Google devices (the OnHub family) that can't make use of
> > SMEM to detect the SoC ID.
> 
> Oh this is (the unpleasant kind of ) interesting.. Is there any sort
> of uboot/kernel tree for these machines available?
>

There is some sort of source but quite confusing. From the info they use
coreboot and chromeos.

Looking at the source they comment everything related to SMEM
(confirming the fact that they actually don't init it)

[1] https://chromium.googlesource.com/chromiumos/platform/depthcharge/+/refs/heads/firmware-storm-6315.B/src/board/storm
[2] https://chromium.googlesource.com/chromiumos/third_party/coreboot/+/firmware-storm-6315.B

-- 
	Ansuel

