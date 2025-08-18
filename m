Return-Path: <linux-kernel+bounces-773496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39719B2A0F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915E41881B50
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCA931B102;
	Mon, 18 Aug 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ruHDkvsM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30DF31B11D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518230; cv=none; b=HCweW7TQ42HJtVuIIv0cM3JO6g9x2rBkryJkJSjlR6HcktdJwo3dB2JJ2hNaryxFPeR56biqNRe6hRWQok+xIazHiV5wMOxeqCKqv5nOc5U2swpEQbiIJ4h31ZQIrnxb/OsPhSpsGRazSWp9tnwjOM5Q0VvME/46+Tva4egrAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518230; c=relaxed/simple;
	bh=d7klSJgcVJxKzgWS5Ztl/bfKJb1MY3zmqkRFuasnQno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVy/+Fr/Q2Kscoub6HnDE3d+gS9u0bjROulae0aHnAt746+HDC7OIkNRDQChk7V6eIAqUbsbEjPEmVWrpYjbTjvdPiAVOrU6dsMiw+DxfYyhUiWhCY42jBAJOaQO4ImUT6QEOiRMWRMCYLHTqvTN6Qvk9m9alu2W8mi5dQNMVUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ruHDkvsM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb731ca55so53513066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755518227; x=1756123027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=39WZqPqR/1R6iPJORmBOWelC6kAqE67ZSJBuraK6tpY=;
        b=ruHDkvsMx1wp9cpq5MeaKCyOWdF15RcWvdgon34j1fTaKtQ8CNDoi6ByEXem/TJ8Ae
         Irr8sDQ7UGQimJg8cxiR3zBVF2o3KktvWor41LAj9bI5pAWe9gbPBRKMrtd7mu3H/DPD
         ard/g8vrABiVXms2oLdYSs2Tm/R5B3v8/ueCSk58aGaezka6uBnmRxzFuOa6fChg05rv
         qdPqKf1tRFyP5V/2YBH8MqL0G9M1xbXxmKZz3LEucqrP4k99xlA8GRy2dr9e9pj6wf/v
         dVTz3x7Qgg7ZjDXY/yhOE2dNC2Fzg2et26mH+F0sGYGT0Fucais1BJJD/88fxcIxq6+m
         34Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755518227; x=1756123027;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39WZqPqR/1R6iPJORmBOWelC6kAqE67ZSJBuraK6tpY=;
        b=Jj0q6tKu6VCRjzYw3jlUImyguZt0SKwFXgSBKyJ6kN63TwN149H0BgqBKXYs07WTTW
         tWhrprLjzCTcgI5JIzOzeS0DcC0pc8Y6cmdVM1Qq1NoqC2p9PQKv+jSSpVU6CYgWWJ2q
         KWicC8WZ2nbRd9f9jIb/rBaaHVkmo4V049USD9Bidagf08fjSBQvfCHv8vgFF54oWYu4
         t7YJZsS+GCZpyGcVFc5Ye4ktD/MNvwlBn9E8yptFAx+W6vENp53yyip28KpQhd8k+23h
         HN1RSSiL8PFHC4Z+oJ5m9jrTqbvuYehrlotePVIw/YY8AHMltiwhgSqT3cg8Q3CiNVKL
         lMuw==
X-Forwarded-Encrypted: i=1; AJvYcCV1LJNsZoy/mN676escc8qkqwSgvNlLgGjxVxXDnOk6BUYVN9oxz6IXpWwEt6NZKiuGZgY+IFZbhVRojkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx6nlU5sGBXYiaN99+H3QchrzKNXoYg1LzOUIuT4Kyrg4mPweQ
	dKsiWnTdaRDRx0tpchmnAbJoEy9JsGZq1QHY2RbiAf0B5JDW+ELcLhPiKd7EQyBCrmw=
X-Gm-Gg: ASbGnctjx84ncLk/Ef6aIOHCHz/31wI+wB+/h32MQ+qrqdophDsJx9gaGMTYmWlUDf8
	OrOs0FXG8Wo8zyF0T0wGZGWlO89mADv4SZj/guZA3z/pmKFy2DEQ/zxNQCoziRMs8qhgWURvV9p
	idw8G/y5lKdIGqCoo0ve1CvwbUfCTsj4Dzz16olsGN1CTirKp2MKuewKTybrvLty/P3psg8/qJd
	q4JPJmtGJ/1o/xePq6O0pilS9fcNohTzYdY8U6CaJZc0d/g6ymAlQapk4XjV/QUoSAnfxLztv+n
	v62WaXo23t90+ROcPttsbaRnwzWcZ2zLyXUXAfQe9nV93PP+R72/iE+p3nqOzGVXi24XxWgP2uP
	cpPEvyf7q+kbQdC01gr+2seQHQ5ppTcuZxVGbzUfXpj4=
X-Google-Smtp-Source: AGHT+IEejkix8VzrIrmaKComZ4B/jQEUWjX/m34wQQizpIs2LiByMrfk2zkRxNKTBAfYmPx+IOePjw==
X-Received: by 2002:a17:907:94c7:b0:adb:2f16:7ba1 with SMTP id a640c23a62f3a-afcdc20e1b7mr535947666b.6.1755518227273;
        Mon, 18 Aug 2025 04:57:07 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce72cfesm776899566b.46.2025.08.18.04.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 04:57:06 -0700 (PDT)
Message-ID: <36997dea-19a8-4242-aadd-ad52e0a63cce@linaro.org>
Date: Mon, 18 Aug 2025 13:57:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ASoC: qcom: audioreach: add support for static
 calibration
To: srinivas.kandagatla@oss.qualcomm.com, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250818112810.1207033-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250818112810.1207033-4-srinivas.kandagatla@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250818112810.1207033-4-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2025 13:28, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> This change adds support for static calibration data via ASoC topology
> file. This static calibration data could include binary blob of data
> that is required by specific module and is not part of topology tokens.
> 
> Reason for adding this support is to allow loading module specific data
> that can not be part of the tplg tokens, example, Echo and Noise cancelling
> module needs a blob of calibration data to function correctly.
> 
> This support is also one of the building block for adding speaker
> protection support.
> 
> Tested this with Single Mic ECNS(Echo and Noise Cancellation).
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

