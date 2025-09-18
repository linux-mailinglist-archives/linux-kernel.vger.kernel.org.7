Return-Path: <linux-kernel+bounces-808161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8374CB4FB53
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321CF4E6AA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96620321F39;
	Tue,  9 Sep 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEYDF1W0"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2139F23D7FB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421274; cv=none; b=pEDbM3DtIME8sV6DHdpDH8urcnUq3zr40taSb2ifm2UHtwog5vpZX0xGws8Ir/+3mYmgo0BGadOwlfJJ/F0YuYoailPnJ4jI5Qt9QekLlqfAPbVtQZiDgH5JX1q9z3ibgMDabA5SkftMNRvWhKG+oguYgztof0KvPhc3KbM5YtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421274; c=relaxed/simple;
	bh=7mjj7rz2/91ejYPmnOag2TLqmJpXVzRAQQZ9jyS/Yuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuRln51dfrvbcyDC62pt0gfjxmDTYfHVNCcJYshl/d87kXlAGORxOCl4RWvUQHwPeDuXT6F8rxA8fCnnZf53ycuEpmN5m8cmSXd4kMDB+YgeMzdscgTJF+EiTvl7RtsiR2JjHS1b38Qmdx3mt9FPpoRJjYAXfp4Be1jIVduPqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JEYDF1W0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b04962442fcso84836566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757421271; x=1758026071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A8FY6t1e4Uc9Ae59s5Q0dm07RQgXfKaJ6ZJfiPWFz8w=;
        b=JEYDF1W0lPqbwNrqtb/LQmskl2uvQcTNfHwZvCq90rtVnZbqZvgbjvH4/rrbIOgTFF
         uHkVBSRZAALE8k5+/PadOsiT6ZZ7imJvjirDGQa10zCKpMVNnZEu1V6x/2iZ3RpUKZGW
         8IPUSYtD/l1UAPg04HadnhRl71ZxvESyf6sKPljuaTeif8gqYoXh99R92QFH//u/FNsU
         6PbRdnxu7Pmfujx4hKo9HsH1MJPEBzHZrBoCZHH//nIgqBON0/I3lAgCA3DQzKIE3fCo
         pLFIH6BlbkJ48iJyqgrBXtk2IYnkO5LTjr5PmRLziT+wPHHeJioadZ3NWSnuOdvcxO6r
         ISwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421271; x=1758026071;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8FY6t1e4Uc9Ae59s5Q0dm07RQgXfKaJ6ZJfiPWFz8w=;
        b=JOhFKqMfGd+MPDhlP/pg3Pvw79WCZgq0dH6W3q264f/iVQNNdp0Afw3ly+ijvCtI6o
         Ckf2xLpu5sd94qmrZVIz6dIWhSXPzJIs1NGAB3sA3IaXO9RPUWgrsWPmPmRgs/tDH7BU
         avrWTB33fMkepJ/oc4XvOgHMUPnaOb0F0FZwFXXatGKDqtWXhbOvzEzK4p5IYqQz56Ku
         ryxumFhDrOtSrYSmMzZFgJX32MYsaEcy7B+rkEFLIwR35OcjS3WmE2XvWmgMBUY6E7Id
         m10JB3Hl8/jHHdqld1ZjzygmhCPwUJpXzNKekxUp6StD1h3JS5yRNMs4V6f4sib3IjIl
         Uz0g==
X-Forwarded-Encrypted: i=1; AJvYcCV+mT1WcYb+luJDx9sdBne6pyMjuOP5Z2LM5m8jV8ZGGbIX0EYJEAcUcTdjlmk+n5eYWIekPdYhns+Mzug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpi8/wN6S7+j7N51xjHCWfyBseBMJFMPc31dwxmAh6350Gt5xa
	kre88lb/C14sqeKjpDpsnKoTDrL5BmDnJRYYUa6dhlEciSVv8kzLt22dFuU/Iv0ZY88=
X-Gm-Gg: ASbGnctrZkTVjLuwAeGe5spSCo5EWZI3t0OsHbypzX60A3L4GNcGEETu6xaDkBxw3BM
	W4Ijv6T8FX/OD/yoqp88JKRvJKtq7gO5QHxnlfpl7NypWiraiKZqLH6+OWOeRzHlRzhe8bjxj+E
	ppZE4g2FawQFmr3SsX0qCWhVYtnRvngKJf6NcdGxvKuMdPap0slfdz2he+8W860MmcRMGAR8PBr
	94quqAXWKIh7g/cTRsGUJ1+PQw5y/1sg3j6yQeo8P2xZnMbYvKLKJh7krRLV+HazgzNTULgaFZ4
	4q8jKQfWn6oMB4TdpEod/fZlVSbF8ZlXD1wWRA7dGPYygborIF7V682HxqgkU3DQ7nunokiuhl6
	YdT5P1xsrCxpPOe2qMIFZ65zgDAdfWAD/N1vsOdOar/c=
X-Google-Smtp-Source: AGHT+IE8rEi135RP6VtGcWAWerUo0T15mMkFHkykkUAIx12TkWOyPRkfn7DvpKit5FzG6ZAN4/JF8g==
X-Received: by 2002:a17:906:d54b:b0:b04:71b1:765d with SMTP id a640c23a62f3a-b04b13d6ad8mr574604266b.1.1757421271333;
        Tue, 09 Sep 2025 05:34:31 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046d420e02sm1466778166b.39.2025.09.09.05.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 05:34:30 -0700 (PDT)
Message-ID: <d7caec9b-3137-4e55-87e0-831732453b13@linaro.org>
Date: Tue, 9 Sep 2025 14:34:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: dispcc-glymur: Constify 'struct qcom_cc_desc'
To: Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Taniya Das <taniya.das@oss.qualcomm.com>
References: <20250909-constify-dispcc-glymur-desc-fix-v1-1-6cb59730863f@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250909-constify-dispcc-glymur-desc-fix-v1-1-6cb59730863f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/2025 11:47, Imran Shaik wrote:
> 'struct qcom_cc_desc' is passed to qcom_cc_map() and
> qcom_cc_really_probe() only as pointer to const, so make the memory
> const for safety.
> 
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
> This commit is similar to [1].
> 
> [1] https://lore.kernel.org/r/20250820124821.149141-2-krzysztof.kozlowski@linaro.org
> ---
>  drivers/clk/qcom/dispcc-glymur.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Uh, people need to stop copying downstream drivers.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

