Return-Path: <linux-kernel+bounces-723060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91161AFE23A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE47F581949
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8916274B3B;
	Wed,  9 Jul 2025 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xEBgJEku"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5E2741CD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048767; cv=none; b=YGguJ+PBaxUj+FT/Gyaee4SaZm8TkZoUEjyriQyd9l5DwbZO4GiWQ86ykRw5K9nD4wrkllS+eoxgmuhHoKGcDvC5xSZnxn5xPUX6VnY1/P12qlrACY6va2v6uc9c71JF3fxefidr2bfGFTg23agLUYznffCSDTolO0xrcy5LHDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048767; c=relaxed/simple;
	bh=/zZwSYh2vU/5k39pFJ6jmYxsKtGH5f1vixahgGk51Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfArSrC3BLP83AGt+jT8V572XWbevcMTXnbvboimcO/FfoFQXCCIx+GQeIGfyGOGrE9mHeEmRHI38XP85UDfoc7HhilNtJ2XYQdEOnUjfNpSUHphmvpefNglPBgb4Qkn5rW7M3LBqpIwgtg9yv7ldftFDiHrtcE9BSYj37PcYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xEBgJEku; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-236470b2dceso45772915ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752048763; x=1752653563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5RyC7LXvFVaBKX4nsxZCPQg0l7p2DFOwCn7njR7ZoLI=;
        b=xEBgJEkuEF3a4t4DRNaa1vtbDBhD3XroghoTzlHEBI9yVTv4GCxJ+iylZfjv2LgWN3
         +qCyFzLO1DDUWrJaHhKVPy5TA8jF14GIhxtUmmbj10uaPlhplF2XmSxlJsBw3EOMQ+Vi
         rTl5I9f79weQ4mO5oSIUyzYaaX49LrtfNZO6mqHLi3SbicuY1lTq0+g9EAHlIH8dPtSU
         imEcD7Xe6Hn0xYnPiUDj2PWfHoEpWt0J6E/1z68jpYIZ6b3+i8Azh/2oBXVrz2Kvkf3x
         Ih+q5XJlYyDfJzo2a354RF7ouo6OiyfmN9ClPjRFFoKDfbgGgRRYwVRElpIo5f3c6qDi
         A/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048763; x=1752653563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RyC7LXvFVaBKX4nsxZCPQg0l7p2DFOwCn7njR7ZoLI=;
        b=DxClpMUqYEM6/N/OfPM2eLcuwsHzImFugMRL+8zKPK9HWAfxnNeQQHLh8bhhZLBRZ0
         kqpUcRHKMcGiAqwwOv69AxDkk/KAMhm3gyRKNltYo981jFd5Fz6kQa+ukRCIQv+KCuvU
         oHcrAFWUxvND7QrFL4CW5+LCClmXafGO+b5Q0DeLFzY2tXZooFmV1xajAM1TPhUheShi
         vtAlVaBmmJgAZ0nXsBIyr+NNRg89BV4fhF/AyPrSgWebQVdNVmp0mXoyDBEaHSjSkfl3
         NUsVoGh1dHYtFLNbqU7NnAsOj2KtyT7qplkrAtGkKe9IDpnk8e5+tQscEc+EV6hqL7V0
         1SCg==
X-Forwarded-Encrypted: i=1; AJvYcCUL3s4OF8dHLU1XhCEk4JRJXqE+gFXlROTkIRbKHJEZmO/5yee6V8byEYO6Muo7J8+JOr+2TzpVrIEpI7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7DPTrvQdoO2cX5woM9DbdY+s8CfQyl/x/dSI2Z+tgHrwQQqh0
	QRgec7KU1v0cJV2/PVTCcpqj4Rd/DSeN8OxMLhVsNOwJtRSSFom63hCtVxEKlUwiRs4=
X-Gm-Gg: ASbGncszrAmCHCoF7jgynD53kZBvod/r2KCg3M6Rq2fSLkd8KvwuI6rdb8yc5a6Som+
	sXjRn3WthLXdGu0XspekXfgN2d32qq5CTCDB4Ve7R4yond3E/1KDF4h6fK/FiR560SyyHK7o15A
	S4B59ch5U1U+dYZfvpi1kE59npBHJmg4n9fwpAfL13IT7d3clBHj0Q6Roxm58pTTByt84MCryMW
	+qULVoT+J3Pk97o4MQAELlVESd6wb2Y5SnUFJlt9NeSWV2sOeLEQH5WYPFOdCC2CFA19tX+vLLa
	HeeAtxSTgURwVhR9NAZbCrzcl+cu5P9Evkj3odfzf/1q1DBLaKV7SXwpoi+6ehKcRlZNBn6FEQ=
	=
X-Google-Smtp-Source: AGHT+IFiRMnSHmNBvUClpBlaNrV3TBD2G3A1eITscwtWGj20grwDeZwpsDQEjZBDH9aGNpfCQqSsrw==
X-Received: by 2002:a17:902:c412:b0:234:bca7:2920 with SMTP id d9443c01a7336-23ddb2e82a8mr32305155ad.24.1752048763584;
        Wed, 09 Jul 2025 01:12:43 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457e673sm139950205ad.174.2025.07.09.01.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:12:42 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:42:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Support building tegra124-cpufreq as a module
Message-ID: <20250709081240.wycbxl6fc2mmkmlz@vireshk-i7>
References: <20250707-tegra124-cpufreq-v6-0-fe69c0f9bbab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-tegra124-cpufreq-v6-0-fe69c0f9bbab@gmail.com>

On 07-07-25, 16:17, Aaron Kling via B4 Relay wrote:
> This adds remove and exit routines that were not previously needed when
> this was only available builtin.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>

Applied. Thanks.

-- 
viresh

