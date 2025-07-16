Return-Path: <linux-kernel+bounces-733393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3AAB07423
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3B14A6301
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194C2F3C11;
	Wed, 16 Jul 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvLMByKW"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AC42F2C7B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663591; cv=none; b=WtqgZIeHiFPAFMcKf1+NITHX1zsVrNMnAKcnApWOUn9F3+cx2YT1gN76dmcwPNEvpcvx/mq2U0QrcJqm22LHuX9ZXP6eFtL2EcMgKZG2Q0dIU0EgTR7qvcJCfkqiDcZNJLikZlHCCUO/7cSX5vvoaKBJDUOCppuo5ABAcioIZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663591; c=relaxed/simple;
	bh=RdqRsNDKKQgfrmCzzuSlgn+ij1i4HNnTBhYJQ0dea1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1lWQLnyIod2KLonnSe+EIL7tTTXZJvJE6Hjo/mkrkZMCc6er4MSe4h8Dul678gqZW0IUBRbD8Uva9du0n3PB6RspfVskT8sX/vPhNsAfkm49PQoPOySvCPJlE1lESIlB8rkSSCWXiaPknIlXaAtPYAjV5rPn3dKNOabBFSbgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gvLMByKW; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-455b00339c8so36680595e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752663589; x=1753268389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ePoCatCn8uwrUkfz5cDfhTqogA3pDEPeb9x1/QWcKE=;
        b=gvLMByKWWrz/Je21u/3w94ywjHh/tG5rkSpEu7VlmghZTilm9RXPY+RVoMAMJXksla
         b9+fiylhJAmnML3q9lrgDt8Soa2jVA6kO9EW+8HMNBSfZTwsPbwKMIoGlsy2/egVH2vT
         NqCQ2qJ8JsWbNNntz/57I7zToJIPGQD2lnSY0FuXFT8ihW2nDdKoWQ+6MlCeji7EQLhc
         Ab2p4nY7SHOewCtYwJbwg6o2thxcQjzuAv7XfMea5YV1njfFKtBW/M5HVpiGcgCPlmGi
         waa/J0deZaea7W7wefY2Mf62WowpKH+70ZU3bFIVcoyEdSavBsyBMV5QF4rM54unV6GB
         G6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752663589; x=1753268389;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ePoCatCn8uwrUkfz5cDfhTqogA3pDEPeb9x1/QWcKE=;
        b=ZXC/f7BEMDHrOgOr2cfAHE3NGapyY3KvaYmDC2L5LyyHw+DOzvGCARwHDOGNTR/dMp
         kZT70PxsaRgF0NTf+eEDG4QTuu1x3roeaQziO5t8YJ/puGQzM0DSznMTr3xMZylH7RK7
         NhwaAHrtfga+4stdZpNE17yVx8QppO7jQuGCqQjJy/DSn7JkZnnjgF0qdxofpvBjSGrT
         KWzWQx0YY7+ZyiAqENIhkE0DURyjWg+1jyg3L2MsOcn4t82OXTfPH+lsDDTm1NSaIclY
         /bt41LAJwyzpXcMgDOgP9mJIZJ5PqFGs9TNoMsBZlVvzwT6iaCgza7dddY57x4qIQXj+
         NHhA==
X-Forwarded-Encrypted: i=1; AJvYcCW6Tvk5Jmg0norX36LxZ4vjS5nC8jerfFbN+LkkKNEgH5nt0uXN6x/86xtZXbwP5iDZFuKNHzbLsfi8dv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Db8kk0c41D89/EplrW9WWTvQKs9sybkQYNFiZHXW4NzmP43m
	C9/IKTb3Z8Pnd8II9mGr3kOprGY1TJEdDhikxEyoVWa9TcTyKaK0wmTdTJq9hSX1u88=
X-Gm-Gg: ASbGncuAF53rDEttIaFhDkQK7ZiD+hTXxAkW7GNg6b1EqkzNA8ba0G0gj4qMZ44GLde
	SATphzk4uhOpoxRVHfUg6WdHg7V5xThH9DV1u3LkyuZ6yWsrH0cC+6jTavMYKKgX7PII770iLOt
	ekubx/o86y077eq+ulNjBmkamCv0SvJlPn7e/YR5XxjGGh9OoxMAwZuWGKHmd0qGEhCYkFfZ9Py
	5uCOa5wbiSymuoZdUkPvPx0QQYFImhFLKJF/HaYvCGBUzGqOFeJKYvyWCaNEQc4A/hZupCZCRig
	RTrqQSdiCAHBkkUaSr5HRFRPEwuA8q6h+szBbA44tjJqChHOzpp/feIboPG0Np0iAdDu6zbVDDl
	4IpJ1hwzCMnNk2BbgmvvbyGF7W6w23mCrZ2hzomvWlggPqtN1TPFMwoEcVDTlWog=
X-Google-Smtp-Source: AGHT+IFW0OX33KBpiLU6YOL+IJgDcuTQ1zq15zYqdjMf2JYYuPC7KCK+xgulExDW9Uc9Bd9opQZwkQ==
X-Received: by 2002:a05:600c:3f09:b0:456:d25:e416 with SMTP id 5b1f17b1804b1-4562e331640mr20250845e9.6.1752663588670;
        Wed, 16 Jul 2025 03:59:48 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b600722780sm9817655f8f.23.2025.07.16.03.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:59:48 -0700 (PDT)
Message-ID: <40784fe0-3c70-4e1e-8b42-fa7230c2485d@linaro.org>
Date: Wed, 16 Jul 2025 11:59:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/15] media: qcom: camss: Add support for PHY API
 devices
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
 <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-4-0bc5da82f526@linaro.org>
 <CAFEp6-0hDqgYsjOy2mCC6ssK2LkMM0z7L_szS+M_wSMeMe3pMg@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEp6-0hDqgYsjOy2mCC6ssK2LkMM0z7L_szS+M_wSMeMe3pMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/2025 10:36, Loic Poulain wrote:
>> +       if (!phy_np) {
>> +               if (!res->legacy_phy)
>> +                       return -ENODEV;
>> +
>> +               for (i = 0; i < camss->res->csiphy_num; i++) {
>> +                       ret = msm_csiphy_subdev_init_legacy(camss, &camss->csiphy[i],
>> +                                                           &res->csiphy_res[i],
>> +                                                           res->csiphy_res[i].csiphy.id);
>> +                       if (ret < 0) {
>> +                               dev_err(camss->dev,
>> +                                       "Failed to init csiphy%d sub-device: %d\n",
>> +                                       i, ret);
>> +                               return ret;
>> +                       }
>> +                       camss->csiphy[i].phy = ERR_PTR(-ENODEV);
>>                  }
> So what happens if we have `phy_np` and `!of_device_is_available`, we
> just continue without any phy initialized?

Hmm. Good question.

Yes but, that's probably not what we want.

Thanks, I will look into this.

---
bod

