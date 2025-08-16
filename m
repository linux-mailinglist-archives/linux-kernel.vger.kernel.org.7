Return-Path: <linux-kernel+bounces-771928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B93B28CF9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1611C23016
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CC4298242;
	Sat, 16 Aug 2025 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fm1nCaGu"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AEF21C16E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755340814; cv=none; b=REC1/FEvw+z03M1qx5HEpe8LX39aHXqtfKcm7MyPI0IMM1Tsm3v7VUVTe33cKde+oyzM4Ia5qKuA8r4GFOJ9L5Xx27Jl6RLQsD2IlyS6Z7befhXXHs8NTZqekSr8RD64d/R36SF5nzzQQ27YGRLCPzpBY60QTeVJNwK1EYPnhg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755340814; c=relaxed/simple;
	bh=xDCesgs8bOhRL6/nEJLkgt+FdBHD+t772CYVE3HpMUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drQjuU5hP1VTF1IJt5BpN3OlRJowLusiMIekeQuelc7tFJPJyHcHFh6L+3IrAWXgWKeNDJB9UNzZwme65Q/weyeAn5b1+fY5K/rHn2nABTX2YL019h3EEDpIJwZDtzialVnGp9AgAiM/s0nrqqRmkYXz4F1MUQRG+dSQsHv85nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fm1nCaGu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3bb30c72433so533651f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755340811; x=1755945611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNCJA6QUUK+uVCAqEH7BdfhhLl78MFNK1pDau4L8ozU=;
        b=fm1nCaGuljRPEG4A/ROUxdOCeYefn3O3kYdgZicfzRY3e5jgmMPZmEWHjFp6utUO/2
         ecGrRvMfOm6kJ48GRv2dlV6MdiD1X9JZriUEyqpt2nY9UiAnnWxWDc3OdynDs3CKV0yE
         9C8DZ6Ur65P1YNBFdQfLdrM652X7kkttt+3x5MCML7dkBao6t+o5hFi7TnNhtAQdhNV6
         RHjNTc50V1GNO+PLORvxjy/6waGTz+d12jRGyfUXUdg+uhaBOfhWDphCc+3TMLfqIBD2
         zfAfujPf3AgykBX7T8hYDp6aJOSfU2RU5Fmr9ybJX9mNKo+blQQ7MJtG2dIF3qWJxs5Q
         xYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755340811; x=1755945611;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNCJA6QUUK+uVCAqEH7BdfhhLl78MFNK1pDau4L8ozU=;
        b=e2bvGISqeBipmcW6EGYS3Kxm3y2R5O1egyBY8Qrz4MFP3iWw6XVIA6zgYyFNsPFVFK
         +xcRoLZtRVOPZ3zaB2ZC7Vyl/X3xFpyeHgCXFXNO6hCVPEiib34FuowMBYXMQr8lTXgk
         66wgFVscX1gNrY1RshuYJ1PR1moGIuUitnra8BQ8OOJ+o7BRqO+s0XWfw/1JZV0H1Bd8
         or07CPAte7BOCPS95yO+kuHjjxHcSW419a9pXt7cE47O1ZlK9wc9c/og+OB90RGYrGZG
         rzJmbuuuISMENGHOz3sSSsmt3MSVU/c0AtEP9BXUPOhqmjKgC51HESxcwgVt1EGp0/IU
         S/KA==
X-Forwarded-Encrypted: i=1; AJvYcCXTeULr2CgCpTzKJkbZLxUNCxJCwBX/lKLXpYYwDnD7EODsV63B4hPWHGOx8JnBdqteIY0u5xeaDX5LymU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL2aJ3eF3QAcM48PgM5IZH6JvNENhMXrqecrLHXEP25ysTq21b
	Nv7CcFHs2Ij2RAZ7RhbHgDk2fgXfdshZROOvYRuqb11veU9ASX5bup/ROfIvbmhv7rk=
X-Gm-Gg: ASbGnctGgnzvz2IUJlU76Ku3LXq/3ElIsieIzmMJyFuEJtsZLnHPHP6sf1rUxLLTl4y
	K7yuFyTLUMR95OxbNsBb69HTaGlDJz6b/mD38a8xxZDRnPzWwzfusLQkKNZvmC3ZB7VFZNbqo63
	ZhNwygdEdj5qcpKP24Kgb/7x1G+to37cvpvlVSxU/qSbbDRA17qf9kO+7fnzBt6CD0wO9oCANBf
	3Mdxns4QUdvSq8UPMzrzNWRdrYyPrSvENUbnyKaqVQZsuomTWLRDinPT81r2q1hYX3kIFKfLnd/
	Os4PtXcoJVpR06GghikV47ZVzPomwc9SCZtuj4FgA386+zmowvLI/LsWP00PEYsasEV/1L3tEyc
	NKZpTzPd7A9RrHzdwl6uX4WOpxim519B7/3eJtuTpttnaAqmT0oBRyi7RyaUtV49z
X-Google-Smtp-Source: AGHT+IH9y5g9eDW3ZyR31wyNx8tU7SHMvCmkDzRQOX9w5fpIXbwluXssS0cmo4xuR8VXa39wuXAquA==
X-Received: by 2002:a05:6000:2005:b0:3b9:1056:dfad with SMTP id ffacd0b85a97d-3bb66567b2bmr3798630f8f.3.1755340811496;
        Sat, 16 Aug 2025 03:40:11 -0700 (PDT)
Received: from [192.168.0.13] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c748a9esm90820815e9.19.2025.08.16.03.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 03:40:10 -0700 (PDT)
Message-ID: <40673a17-a19c-4722-ae5b-272082af917b@linaro.org>
Date: Sat, 16 Aug 2025 11:40:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/24] media: iris: Fix port streaming handling
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Stefan Schmidt <stefan.schmidt@linaro.org>,
 Vedang Nagar <quic_vnagar@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Renjiang Han <quic_renjiang@quicinc.com>,
 Wangao Wang <quic_wangaow@quicinc.com>
References: <20250813-iris-video-encoder-v2-0-c725ff673078@quicinc.com>
 <20250813-iris-video-encoder-v2-4-c725ff673078@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250813-iris-video-encoder-v2-4-c725ff673078@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 10:37, Dikshita Agarwal wrote:
> +	if (!ret)

I think you should have a consistent error pattern

if (ret)
	goto error;

Once amended

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

---
bod

