Return-Path: <linux-kernel+bounces-820240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864D4B7CCEB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347D0580943
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AD52F25E0;
	Wed, 17 Sep 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f75OQNSn"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC69C2DCC04
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097952; cv=none; b=Mzh0h2XR99X3SovmNgZ5OOidN/gbtYPQz2kozBAFiVy6ykxfWNk7esygoItbYS/fLbGqVIjH+IBAJVb5Ek7Ba/hrbtVI1oYuH15v5gwrTHu+x7lLHVVUKzbhih5LopjftXCBagIZmQ1SWj0C7HhnuHRkjqduybTEY6Z+BZ5MGtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097952; c=relaxed/simple;
	bh=e1HqXtZJd/mh2DQlYKpY8+rgwoNAGd8qppLD4tEH3oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQHKugDSRwo8DZakRFA/WMswTRt5kSvKDvB7D17wnaS7dgmC035v7c83ZLOFfM67asjy2YMHUUTJjIduVanuk4UFBtq5Ov+nQsMwefAoIUb/tfnTbz50HVApmIoKjbS7UtB5/lAhx75VT2oicwCV62VSgwVTVZRvgqy+U18L+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f75OQNSn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2b062b86so22978035e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758097949; x=1758702749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iIl77ODDceGEz0pehinF+GLY6J4fc68QbX8V3FX9t7U=;
        b=f75OQNSn+/YU2eSAvwOltb8qiau0B/h1zK8q4Y4c2Kk+XXjDIQsl9JHJZchhFdggPj
         yOdkGbr2jyLbftZUuXfVAJ+J6EeoO3BlQ4EsVL7vZu0onAXjnhwrOQe8o1OiUpS6FSq1
         s66sqpMUkqyYZ6QTzpIaC8VYi9qfHSXSCEX6Cm5AOgJQWHmwE7G7pq+ZOy6myDv8TK34
         Xl5HfjqriijJ+P+kxBzZjdVBv94cYfRSokP98tpt+39TmligchTSlb6BR04pfoMRuDr+
         hLt1Md4UO8f3V6psUZSWvgBHFf4AKoQ+ckTbsfoQQxFYYhkpgH4OBPubxMAyv55YDsji
         sslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758097949; x=1758702749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIl77ODDceGEz0pehinF+GLY6J4fc68QbX8V3FX9t7U=;
        b=wS8VBuwlYmXddo5I9ts8vJLpa5hSOVvvHy1BLJlpG4qCkLUjn+BbIiJV3ihHGEzZd5
         uenevGSFFSunYiquL0ZexOE9g5FBtj+1gjgPrFAWQFX1q8xPJr+N/Vj96dhGB4Sl24Ku
         hTGpZHIxvbXZ8/FZ45CkakfUdTwRa/NdY7/K7CbLfysv6Rk9qnh2MwB+9JiECQmoCcZu
         9ZTlkDcETkRcAqpgRWXZ6NBBzPX8LFhB1qo5MOOnOuIkSxDPUKTH+iHjmnOA7Kpb2WKm
         92ktFnyktv+JzFkOtkFwdDiIlZD0CcVby/xRtf/WSuXBTo6gPxh10VHbW5K/dh1ftipd
         Dt0g==
X-Forwarded-Encrypted: i=1; AJvYcCU0xBYkVfFO8KNNmwkkK8hmurqJZZgsOywbtU8Wqvu/IqWQAmPINOlrNXMN+5Nmh3uVdXFcNsfHPaGcUxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzz3vdI39SVViee9n74l05X5wtkA+ADMyhVZH/gDTgo5s7KWYT
	MX1O9XvtLIvCLNGEwDIgAHYPZeQ/LJjxQYPUH6i84ACT8iF0i7l+xkfUZjJjx68NI4I=
X-Gm-Gg: ASbGncvA7ez+CzbH29m3fgTv220tW1B+YQLf6rbuevr7dDTkW4BsLL1lZEzYk2Q4c4n
	aNZvUxwSaqauwTZ3dvdYbSbAqB58BF/RHTfqp+IOzCTo9brxeh/ajU37osuZ5q9EV/VvZXxweYV
	vmWzNSpMVHDxAFZN+VF4MZnrNZIgVUxAA3zpS2FPQjTlClJk6N8PjonPxgtJ3uvP/Fpv4llzWCG
	cGjJRDustpu7GqJmXtzNOxK1aQ54THXWdlUYHvatyss40HJpkSm/sztooPItmQQx6sUXLnMuluZ
	mYR3D8n6/VDqpUcZrTJx6Tm/m4sWlZe8AgOBCtFOzNZQJ6kRvRr8pwQkaxk9nYIfIphIS6BOJSD
	drbtHiS8PagXG6LItrwGbKfylycYeZ3qi2b442geY63owZhMm0UGbC0gAanlxrBQWx+0lNFov5Q
	IDTg==
X-Google-Smtp-Source: AGHT+IHbchbH0zTDIhtvWBHzePerwa0GqNo06mWsjRIIJhssqnaVVC6k8oSRdp5XnAjDncSPkNhAWg==
X-Received: by 2002:a05:600c:5492:b0:456:18cf:66b5 with SMTP id 5b1f17b1804b1-46206842695mr11181345e9.22.1758097948975;
        Wed, 17 Sep 2025 01:32:28 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46139ba88d0sm26629015e9.10.2025.09.17.01.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 01:32:28 -0700 (PDT)
Message-ID: <e30113f3-5562-44fa-8986-8a8889738517@linaro.org>
Date: Wed, 17 Sep 2025 10:32:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: ingenic-sysost: convert from round_rate() to
 determine_rate()
To: Brian Masney <bmasney@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250810-clocksource-round-rate-v1-1-486ef53e45eb@redhat.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250810-clocksource-round-rate-v1-1-486ef53e45eb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/08/2025 00:37, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> appended to the "under-the-cut" portion of the patch.
> 
> While changes are being made to 'struct clk_ops', let's also go ahead
> and fix the formatting of set_rate so that everything lines up as
> expected.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

