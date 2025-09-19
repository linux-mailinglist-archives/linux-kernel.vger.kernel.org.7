Return-Path: <linux-kernel+bounces-824916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E938B8A771
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAB83BE702
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E049431FECF;
	Fri, 19 Sep 2025 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDhgMlHZ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F029320CC2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297520; cv=none; b=ukc+GJugUFi+rzj6kDUnj99+pOk3thX9WLVJ1HxyG8kSx8YlcblxVYjCT9f2CWksXrdUddVkre7uZ2ZwKc7EjxB0XpN8sMtayOCur/qmYNgwfTIqgaA6ciH2NW2H4QY76AKQHek4jFRKF9LIIBZyW69pnCippaYmEMzaz32kvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297520; c=relaxed/simple;
	bh=t3P2GEOcwivP3t6/urkttM5U23eccg5yH/vgb1kPN6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZMQs2udPxtSIrrLlrClVI9v/hlO9SeR45Ndythq59lWOv0gfthqJxSNky+i2t5ADtX/miqridSiTF8LaeQDzaU/wYq/GqisXj9tD5nemaNO5rFtj43wETxtwWCQoGrSU794DKWxat6vgBXVPGpg5Pb5AFd7hB5ID2eIFPgZNtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WDhgMlHZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46897c60e38so5582545e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758297517; x=1758902317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnqHCvU7rGwJGGO0ESYLZHhX3MxXPvdCUBjgSC9Fnxk=;
        b=WDhgMlHZ/7SIcNS/sdeAzbLsJdC9l9L2i1QStGYhztxbV8frEod+OeF6hbWIsLPjcn
         wNEU/rWo6fAtDwumz4JfIxza7Vk2a6cAV28/zdrh+93EXxPWnjTdKqAOW2MS0o5tDsbK
         3jEiWFZMAh0eoMhs5dL6w8CIBseTEtY3OPmSRTtQZYy8fC0aQ3Z5lJEQ+babT58AmCQ5
         /XKcd9I/iwotj+HzjmvBU+ToDTtvJ6Iii0aRoCnhCVsge33I3uCREXO1VcqXCKgIOCFU
         z+5gtlMO+PkQFWnjdSQBDZ9dXgLmW4rg/uafOmVsB700oQMA0RtCoHX6+mTdwA8mKRtK
         LVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297517; x=1758902317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnqHCvU7rGwJGGO0ESYLZHhX3MxXPvdCUBjgSC9Fnxk=;
        b=Xv0MyYY+DJgoJlWZm5+9s1Jb6s88bRCvQz/jc/Ws9PmDUYdMoFZ20SmRa3e2MF+zTu
         hUHUtua/aTgW104WrqTWspqQun8WOxb+JLa/j87mnKDom6x2ndDLWicmwIUeuvk4qxBh
         7KMTJWyONYYHap6NgFfg6P/JchzRr8YW/ToOH/Fop1R6d+oQWTrlrFzf+fikNY2Rm3JY
         Nig15fbzPYfAwuCBqvovQumZMzPcldMHStnNznG8buvncHhSRJzaHjDZDM4fnGJJQozE
         U0mHUGd851w0VETfj8UVSJKLwnZYYYBs3iKoKtwL+pUd+SC9mF+oZcSn9MZeDpwllCTt
         1YfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Z4ngOJ/Qn4odsSDfoFwEbIQkBzbLxnZVYN51KN//832ECT8Uh9gWmJBL6uqz4wqvk6QM/HhsPWcHtf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuv7UzUtgEEqa/RZAc5D1pVWglr7QgVgrrBOqnlunMVRT4xd7F
	2e2r5/7OkwG3lEh2ub6HhK6ixFCl50jUVbmaF2lUqqiFRe1AruK3Cwua5FpHoihAsRk=
X-Gm-Gg: ASbGncuJuxFKoNkPKy6QKGHng7Fs6MocFCTth8MjAPxlMxR4fQcXIVLVxwIjs7pOlCG
	BMGFQ9LdFKDxv916aI1/ue3Vwx+HnbQ9vwPUDUuiqzfKug6onV6nKuTQQsXnuTdC175kGg+WqiC
	SdszWDl9YGrjqQnuwz6D9KEIXkiOrf6g5dJGSqROVL1Ynm7tiX3GCqHiY4VgZfVwF0BEIJ0t4h8
	UC5lH+YyZJ729f+bvJ4bGxtzs6A1VsaPKDrhD4ToDEa57qXGa3aSMM3uygomshE458I8885Doox
	Xse98GlQ24XjCDJN70scM3dBjuezJWqTCb4O1KCc8EKmdiqLceAvGGfdB3yyENAzpauYabR1f83
	3DbBD3Z88zFlt40bkSTRxlwYzEDoC8T6tvcQ0hMocklqbUO5F+gdM9Uuo7mpPC4Dd7vSejLeRoG
	GRnQ==
X-Google-Smtp-Source: AGHT+IGiHVqCid6jiNXmY7e2HfatNlHZD3vTyoXsmvvtSGKovpZ2+7Stv4IcOLATQICU8wnyJ6SpuQ==
X-Received: by 2002:a05:600c:1f90:b0:45d:e110:e690 with SMTP id 5b1f17b1804b1-467eed90607mr31739365e9.14.1758297516735;
        Fri, 19 Sep 2025 08:58:36 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8ffd:205a:6719:49c1? ([2a05:6e02:1041:c10:8ffd:205a:6719:49c1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-464f527d6cdsm106682695e9.12.2025.09.19.08.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:58:36 -0700 (PDT)
Message-ID: <54b7e9b7-e2d5-404d-9410-06b62a11d073@linaro.org>
Date: Fri, 19 Sep 2025 17:58:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1 RESEND] thermal: thermal-generic-adc: add temp
 sensor function
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20250903162749.109910-1-clamor95@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250903162749.109910-1-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/09/2025 18:27, Svyatoslav Ryhel wrote:
> To avoid duplicating sensor functionality and conversion tables, this
> design allows converting an ADC IIO channel's output directly into a
> temperature IIO channel. This is particularly useful for devices where
> hwmon isn't suitable or where temperature data must be accessible through
> IIO.
> 
> One such device is, for example, the MAX17040 fuel gauge.
> 
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

