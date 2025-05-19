Return-Path: <linux-kernel+bounces-653963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31F6ABC15A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 16:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CDC97ABC20
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAEC280015;
	Mon, 19 May 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7xNcCbi"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819C274FE1
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666341; cv=none; b=X5TXdkgXLHy8zS6eJdET0n+zkF8/9oN2TKo8KV2qGWVW1Q4IbXqTkBRkXIljxbiErU5UWiyd9/ZzRI4oFBhyanni2s+ihVnUVk1Uk6hqDVB3lja+kyHPlg4YD5ptOX6AxRq+nR72B1jBaZtWZJDQ4ICjIvVsTJee/9fsiOjJNws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666341; c=relaxed/simple;
	bh=0Z0YteBla6iUqWntSwajrUF0lrCT5yft7KEasXmYpLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8fW/Eir1V05RbwQZnrgLhupmjfhgXvJv5zQVqt7OQdSU/lvqbauqDgl1Y8o+BIHkJ1SjRqdGsZx2YHdhQi4p0UgtUztNbqxSh+W0XPREnm15ErEEoS5BNWSOJOGkppnAIE8eWGofLb5zk8xxW+BO9lmNfIOcx/wpUmpSrQF7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S7xNcCbi; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad551923eadso16978366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747666338; x=1748271138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U2o8j34NI0bciQQu5STnjspj3R64g/tb5wC3dEqkg1s=;
        b=S7xNcCbiQoh8Vhd+jARle6HUurFtodfogQV6k/J/JJQ0by3adxTXKAJBAWzwsej62l
         i6KOOMXtmmoekyXIyYx4ftMmNgWPSMeJiAwZQFM6t6t1Q1n7uBVrRig/xSwAybi8Mart
         3aFDgjOIsoEPSDwqSGl632kMyHoJGVBZ5JNN8kUDNXeQ8eddeJJGhwaoRc1fGFvSLdER
         QL+UMFvcLz+BR5EB70oQd36DMlxBXFErTRV65192NdadSPMtE87fjNWCaATmhhkN0gPq
         yGDoQt/GJ6V2Jx+qK2/OzEGHAhCVJqRXgMkofjfnD84fJTZLhmNe+/5DDsPlPrDeU3Dl
         pHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747666338; x=1748271138;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2o8j34NI0bciQQu5STnjspj3R64g/tb5wC3dEqkg1s=;
        b=XiPdeo+z4PATe9r2q/z0BlYos7l+bezpQov5AqZKicea5JsGYz2Vh0/0Lqj7EF5qhq
         VeAbbKS7gZq9a2PohVYa1z1pV1jeg2oSIBZ69svGPnEstkT2+ydXkNIUp8PHG/aQxif1
         LbiIUboGy2nl1UWC9/MHTGNzpXwnolxv/eOohTvefTj84F2PEu+8sj2jyN2jTJKyxBzf
         UkdQligzcGTJm3I0tyMW4XOAdP7gsLGWNhb3EO9v/SRaaciAh1rifW8ZQJEXy4HEpcY4
         jYB9i+tx9NfV1/+8CXOuTOHMi0gr2iwnV9d0pHsu1rVrkCs6It//0jqbD3z8UuJbYgaH
         k8tg==
X-Forwarded-Encrypted: i=1; AJvYcCVpwXi9E6em9+AxcAGQ7KzW4L0yIi6T12lLV8MnTKjB/XYngmwqI93BJnJVrdOP+tiayULW0B9MltMMkdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB3YWwQ1faWqArrFkW4gG+eZB3rUQ03HmuYYo3THV4dSiFdOMW
	bDUchR+yZ/1SJ+Fnkjek7XB7FlZ6ELsvElJ4G7NqOaAzIpPFDELS1Z2sRaNULeCcccY=
X-Gm-Gg: ASbGncvh7/glUWyc/pERMBaYrJAe3FtKis7AQpo+D5ulN1mgDWiDLT4kW/NAAA7LYd/
	x0NvnrHqV0t7LnQVsPQaGPc+t5OyFyOJp4LJqywoM1i+rAAT58D5PGZAnjY6xPdE2y62GEznaHR
	i4cLgcYYXAx8zPg1w9G/ky5PXNqkzLeI4G7bi9tThlD9co7Y9LLrUCWIJzaksikPfC9k646aqhO
	ZnFccb5XKkMUfPJfFmUhHRrDNPqLmfcZ/G/znPm/5fpGoGHzy7RXsDdY+ywpMCQSzK0QsLZA5W9
	ecd2fp6gaMFORT0G2a/lBlv4hMhZUzhYtw1zgZw7tik6g1hHz3coHlPIU0xuS20GwGVakwQ=
X-Google-Smtp-Source: AGHT+IH9zgdaGWKJVCnRy31O8Lk1rIV72hWBjTwmWf6vCm9kAw5B7k9GjdC0BT3/VJRY7bOIdp8X5A==
X-Received: by 2002:a17:907:ab5:b0:abf:6c88:df53 with SMTP id a640c23a62f3a-ad52d5256f3mr363732966b.4.1747666337974;
        Mon, 19 May 2025 07:52:17 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d04e816sm593323766b.23.2025.05.19.07.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 07:52:17 -0700 (PDT)
Message-ID: <24e49307-7d75-4736-9b5c-2e6286fe57a3@linaro.org>
Date: Mon, 19 May 2025 16:52:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/24] drm/msm: Add support for SM8750
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
 linux-clk@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250430-b4-sm8750-display-v5-0-8cab30c3e4df@linaro.org>
 <75f503ea-e8cf-48f3-b39e-388ac456821f@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <75f503ea-e8cf-48f3-b39e-388ac456821f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/05/2025 02:08, Jessica Zhang wrote:
> 
> 
> On 4/30/2025 6:00 AM, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> Dependency / Rabased on top of
>> ==============================
>> https://lore.kernel.org/all/20241214-dpu-drop-features-v1-0-988f0662cb7e@linaro.org/
> 
> Hey Krzysztof,
> 
> JFYI, I think there was some discussion on IRC (specifically #linux-msm) 
> about having the feature bit dependency back in February.
> 
> I believe both Abhinav and Dmitry agreed that you can keep the changes 
> to do version checks and drop this dependency.
> 
> There are still some ongoing discussions regarding the feature bit 
> series, so this way your series isn't blocked by that.

I was asked by Dmitry to rebase this on his rework. That was quite an
effort. Now I hear the dependency - Dmitry's rework - won't come in and
I need to rebase back, which will be more effort. Can you all ack this
so I won't be needing third rebase?

Best regards,
Krzysztof

