Return-Path: <linux-kernel+bounces-830599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94C4B9A14C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB674C5A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E7C2DFA3B;
	Wed, 24 Sep 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmKt0Jgj"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DFC2E5B32
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721409; cv=none; b=MJf29M43y/seXKALVSN8dOHfv++5FrLkR2IU2SyZ2ocau5GDFe+cjBg+WF+qf5ssMswRPxbXSn2bb4rM4jDCcscuPkkLOnz2ZjVBG/vsV2W9zpSlYXk1OmlMugyuC67nshweO27KTEWnhGeOisXhJGZXlzVCAIF45zqvtra9Kec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721409; c=relaxed/simple;
	bh=362mok49h0ojJfmh7EylXoAruuBtJNGAh3gG39mc09M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbMUDVtG7VWeHZxCHljZ23O0abXQNtZ/ERZHsqcM9KeQeadFzLHpSyfU/CC2rPBU1rO+LQEWWRLH384bK6KIewQg2RlSzZT0wKEfRlyCnn84892SARcpxFcaTb+0t6LFMln6UibT5WUGrbcxxP0aQJot35L9yIt8LLLu+bRmNrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BmKt0Jgj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso766573f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758721405; x=1759326205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YNtYnYusjvosApIQjeQMJVd6fwCQkpG8X3XVdnB9O6Y=;
        b=BmKt0JgjYRQ6Q1TwxQoiZNMhSOt/dQmk9TbqqedqstNJ3jYiOU1KnPLNampvP3bbq1
         2T4wFrHWpOhi9yB33HdV++Oz6euazOGf0+X3eKAz3/F3vGpZoJAsjaVbuiwEaYySu2jT
         jYvglYOncPO1GHcEH2jtGO3PSSGn954UoxMLkvmHhmwCvsqrSm1d0NvFz0pcEy+iiVS0
         2JfF67aUkFPk7yS6CyZF2TMMSflsIfnPhTiJQKbs8pTuKmFqKfYfmR2iJ9JCllmJaHSD
         1bBNts2vYBAVue8w6tpErp3orj+PMJpLfszumD/CXxJr4oWbRr1tIgscG3AUAOQumDGW
         EB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758721405; x=1759326205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNtYnYusjvosApIQjeQMJVd6fwCQkpG8X3XVdnB9O6Y=;
        b=MTzndETc/Sl9cYvxI4VqoyC8WEMmOczdi0bdpLiThWhnHWzLM5U0TKiGk/7Ckztaid
         l7PdFSCK6fSfG8BQid+h1fDgp0dheQf8KBHvts9XyWUVK1qe8RqBk6JhtHiFhVOTuPfC
         wfU3YxIkfL7Gv6BmnHg5bVqHuRNfAgD4vmLl1v9dnQkg1KU/Rp7SIEtKm5AbXKZdU2yV
         7mqcuidvQy1Jn8twftC9du0lPKT9EuXvpxZjLCDqZ/7uy1zCcfGzgHXAR5Kt+e8jKfrt
         eyblr//lyjh6TKx/5ZQ24GIeRAieZJXZl24yzUCk89YkKa+mmea0DVFoYYHL/18n0BIT
         jNQw==
X-Forwarded-Encrypted: i=1; AJvYcCVj10c11rZY/ViODEgy7JqUJIBSuW9g7yhOmhTYphhCTYqabDImdf03BofY7fKJMpbvzixrPOMG+z+mGHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFJ+P6+THmWdukLlkkbOhonvYsyH8SrvJQhaNLEXL5N7Bop2Y
	pU8TppckbzCWDOtvgZVmDfts1VaYPPBsE4m/+RgKsDR5Zuc2zla/vwSdVdpS8sKNWAA=
X-Gm-Gg: ASbGncuWoeRM17bcK0Rgln7JOwrLDORPRO47bmmnRICwkOTAm1hG/5CrC30+cFOxQz5
	rkyrya2klEpFWdPZhwwZVZ35pLbS0YlS6zfT7m/zWYYU6OAkaumsy4GyT6HjzcqoGKgTgnwRBS9
	tzQuJNuwc5il/wjFX2O+mUglflAvinygvqDOl46qPkgAkeFoWf/RsrL5u1p85iUu16aprECroWy
	DmxxMIz0gTJB7Gi80sv1u+V4xhIlgYRa1m+r8J79HPo08b5MVeNBzahRZ3eIv7WvhrcZYaCbN/V
	4SW+qkG0rixeyC+bkYPhrcrn9ZwNt1wl/6wfXfTatbS/r/nEjfb7wXfQ1MjDLl6sA0g1w/r5ePk
	ILch4S2kpq+uCuf5JoRqpQtouO+rP/v82mtJltzXWYUnQ3KppoCjbca+e5a1tDdmo1ETZXQiYqJ
	aBSQ==
X-Google-Smtp-Source: AGHT+IGNAydMr50yC2b0MrETOTGyItfTHurjxG7B/vwv3DCmYmEvjQ5clr88rehB9F8Xk9KRZUcVWQ==
X-Received: by 2002:a05:6000:1865:b0:404:2fe4:3a80 with SMTP id ffacd0b85a97d-40ad1605104mr1803335f8f.25.1758721405328;
        Wed, 24 Sep 2025 06:43:25 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bc4b:2611:54b0:29a4? ([2a05:6e02:1041:c10:bc4b:2611:54b0:29a4])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e2a7c8531sm33284845e9.0.2025.09.24.06.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 06:43:24 -0700 (PDT)
Message-ID: <69f09f55-fd2f-47a9-887a-e9c2cf7c21df@linaro.org>
Date: Wed, 24 Sep 2025 15:43:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] clocksource/drivers/sh_cmt: Do not power down
 channels used for events
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20250910142657.1148696-1-niklas.soderlund+renesas@ragnatech.se>
 <20250910142657.1148696-3-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdVKZn-YfBxvwA1wgjksvzZK=NPzaoTCPRur_Z=AneLA6w@mail.gmail.com>
 <8672a8c1-26b2-4b65-a30e-a4c3e0f1f32e@linaro.org>
 <20250924093132.GA1062104@ragnatech.se>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250924093132.GA1062104@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/09/2025 11:31, Niklas Söderlund wrote:

[ ... ]

> If it's not too late I think we should drop it. The issue this work
> tries to solve is a lockdep blurb which highlights a design issue in the
> driver. But the driver have function properly in the past. So I think
> it's better I work on solving the blurb without any regressions.

Ok, dropping 2/2 but keeping 1/2 is fine, right ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

