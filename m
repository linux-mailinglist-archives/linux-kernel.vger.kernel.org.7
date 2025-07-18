Return-Path: <linux-kernel+bounces-736299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC5CB09B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6C37B3E48
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89EB1E521B;
	Fri, 18 Jul 2025 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOGhYs8z"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7535D1552FD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752819417; cv=none; b=VfDblCylpgeuvC6gtbVYJU1SWGrr7N+buT7CwhHtCghOmVF43Ie3rjzaU0g2IcozL+koSl8dqZy3JtLEIlXm8DZXuwW4GjMs6G07megMDSh9kumO6XX0CY/2NUFgAFbRgqaMDuAvg1D8sYQzkQNYFEH8qOxS9XkJeE9sq/67oGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752819417; c=relaxed/simple;
	bh=I8UNMCDFBAAb+YBj8JFoJcvOE7xS5z4swcVBq99wvHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHvudjOK3Xi/tHVkO7P6wR+wzwR9CstOHWMA/tSjnIijCpgSC8BcwkD4eVdecEe7ahXkCzdn85QjK2cfCF6vryAwohwKbJOrmIxzGFYdwTUUmWLcmIl8oz3ZwDhpFrqTKuMqvtKGwvBpBqiZskbSMs+70mqg6ZxRET3VsCGgE+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FOGhYs8z; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-612a45284e1so217249a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752819414; x=1753424214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z1JxVJ0cGy/4vRl8q2hnJqL2Htk4WJ35GqE3f6gUHZE=;
        b=FOGhYs8zqqnQFV2xhcyXfdbwKe8YM0Az1gJs7235ZwYECWiDSdsvbKBjjZ7rDqOSm3
         8X+mC6eAkbso/TcZ3GQPAPmD0WQLoY0jDfCEEJbhhOaQsTBfbsBVXaqCjEqCJaIIdqCe
         9ijA2P7u/tWEH7Z1JZ5NsweZhNIfi6VarD3Ms7JxssnH/Keuk1cOMm38+yDxXTxB2hl2
         GARU34bZ1ophaVAv4fSEwpPmWuNfYCh/MU27/abeFQg1EeljLC/IrHaxpIbVCGOBhdRu
         BA05hrL3kXO6JDMkmKmwtxuKgZc6eRzCJBrDhRxXQM/kMYOeRvXf3q0kN6b75V19XzEO
         SeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752819414; x=1753424214;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1JxVJ0cGy/4vRl8q2hnJqL2Htk4WJ35GqE3f6gUHZE=;
        b=ucb0FjSgFCvCDrH51vqHzv/G66wMqJUIskkD2l+lbG/nxPWZ0CMMGcbWMvbaYS0kPw
         pQA0K8htczdfB6FK049H1p24NqkREFFWdl5LabTHdRuibsuP/gJ6XIGzwC7WHF6axpSH
         dXG8jVkVr5UcY+Ys/De6S6V5ONB7ZLhHDIpbDmhlfQ+jlrbtUp6rd+11E/VdpSWCO4sj
         qEY3V8USPae+yZew8Cku10FwMNxZP8dru3kSImXuWuuE4ieqdMr+lsv2tC8h7rzDG03o
         W7lOPLXdpYEkSW7Pzw6M7Wg1pUB61gBvQNUpw7JyuIV8NXtow/UFyUK8QotWP9281Gqa
         S25Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkPl+n3AzBYDAEUn1csmdL0XR/H00ibaXHLzaBVU63wtSslvvwVzYg9RpYscHsRK0roSaBGnia8derM+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw10EM7QVDeDDNpx/ze5IBUAGZEPhJiVxGONfx5hDy/OFc/zHW
	INSKcJzK1oXndmB0ZC601yZlHNfJmwGLyUdIAkq7xVfw4shJsukoIJmTXfZV0DY0r/E=
X-Gm-Gg: ASbGncutW0EechOgoUzBLh8AjsCj147eai+tKA6tkAwCY8Y9u142mhhsD+QL5eL0vMS
	QuICXes9PgqnC6jbmX9JBzxxTN6pkSrkKxkp9d1rXZcC/MyVet1KgYnkVvMJ7IYph/JUODMKHDS
	khh61D/Vity+OZcDKG0zRYZtpYbGFMc6pBkiWbLSt0/RguwicGaiIwPGjEYeOKvzXMbcxcUDLKW
	ZsfRHL6OdJivDAZ4zpjagFG3Mp5E/n10MpxGm24ZPWw0PHUGxaueh899MgdrSpSNKOgSfn3V2z6
	SEzMMqYTFmSaDoBCLuu2QnG9KqWI4SW48cTDD5p/5joJp7q4iKC9iKmpjM5zYEjDEMjvVZzP6vS
	NyJyD1b+oNzqQG2nEG22o4Wjw0EnOp/KjahPA7lB06Q==
X-Google-Smtp-Source: AGHT+IEw3Mcsz89XFSoarNt5H3TImNWXTbq78NJurRa8he4GJCSKW9GRBJizI3fHv5QihPCFF6p8UA==
X-Received: by 2002:a05:6402:13cb:b0:612:ce8b:8e2b with SMTP id 4fb4d7f45d1cf-612ce8b9481mr223054a12.7.1752819413593;
        Thu, 17 Jul 2025 23:16:53 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f335e9sm489075a12.17.2025.07.17.23.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 23:16:52 -0700 (PDT)
Message-ID: <b8d6edef-6809-4166-b936-fd000513df90@linaro.org>
Date: Fri, 18 Jul 2025 08:16:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: Fixup x1e80100 to add DP MST support
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Danila Tikhonov
 <danila@jiaxyga.com>, cros-qcom-dts-watchers@chromium.org
Cc: Abhinav Kumar <abhinav.kumar@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Yongxing Mou <quic_yongmou@quicinc.com>
References: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
 <20250717-dp_mst_bindings-v3-1-72ce08285703@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250717-dp_mst_bindings-v3-1-72ce08285703@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2025 01:28, Jessica Zhang wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Add x1e80100 to the dp-controller bindings, fix the
> displayport-controller reg bindings, and drop
> assigned-clock-parents/assigned-clocks
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>


That's not a correct tag really - drop the quotes. If this was added by
b4, I think you might be using an older version.


Best regards,
Krzysztof

