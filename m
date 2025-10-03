Return-Path: <linux-kernel+bounces-841225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE015BB68E1
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 13:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D94E189FA4B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9567B23183F;
	Fri,  3 Oct 2025 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abSHRRWI"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F9192B66
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759491980; cv=none; b=VSvaJbIeDb/lKalWHZWFomUNPHWzKZiEo2WazBtCTAMmGuHHht5VRL2Rhg47nt70o3H06wJHcVbSIHN+WFyilxNpi81a3zqk8YF42cqAtBgWYFeDSGs5oJINk9DidBuB4NthFKCYMNqHbwTRNBVtJClpiLc+/AAjO/ti1BSRDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759491980; c=relaxed/simple;
	bh=pyZ3TAOi0U4n2XzT9dIn2NH1hBOe2oL0LlEkuEzKqmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GL2cMj3sWDICf8LahyzzL2rWw3I836sE0l6ZgwxXgkNnhl5p1S8vdZ3X3kwWO/s+9+ygzi+JwRimbkRs6KK6zF0bJZHS8NgqDS1YSZMv5UCEWwabi8hhq9LVAjla2ZwqfOlXhcGMEaTVYcyO1zEZzm3DFpOSHw1jMDAJ7KuBiRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=abSHRRWI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so22461485e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 04:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759491976; x=1760096776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MXPI8JPSlSxfXU3oIGiKhsz+rY4EG6yV9MAy6evg5c0=;
        b=abSHRRWIjw99uqxDq9VAZ49WsCDXQAVamhm+MAc+8d514KSru2cX9L3ZSucNk5qRnM
         gXu72uNawMrP2cKIr9bENS5d/Gdb5Pj5kWA9h2462N2d3XvFPDTZBMy+8ut0YWIQXzQl
         i8Fy5awrBKH0g1sqi5TyJt7TFrZfGBD8ALOJg9yX3hV0ai1QVS1G4riRW2GeNu5oDETx
         cWB/q3lRcHOC+4RbTaWrhK8/zk2MJiza8EkF7M+ZQVs7OodNOYqHbGfF5EjDxg/1/XUg
         BqiLjoWbSfM2b5LgFtLEj+U7F7cZVStTQWjoGEEOwYezcIrSNGQNTIhbWNAV8uNsaCxv
         e9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759491976; x=1760096776;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXPI8JPSlSxfXU3oIGiKhsz+rY4EG6yV9MAy6evg5c0=;
        b=Ee/guBBPMCZ3pM/tT8+Y8x1GoJ8NRCcGV+sIg7QdBWH5eNFpijcnQjADhzwpqNFAE0
         83J2XEmfTJ4moy5LZB9ibmASy8sxeLKc3Fb6D+qZY73eGdKgdxqjkGF1vtyxbd3EdUP3
         PGwWAxB/x4Car4tj3SspgMw+cI93mwtUYR5LjkBaeRDUMwy2WQV/6AdM8H0Cskt2FEIC
         Seu6ekxKfuzPX/K8VkPzoIeedvOQSwTZ6y+HQUCPP+L9sJzBh5dWLqdRuz4OVynjko1B
         u1O+d7B2lMtjvVlF9yIgEEbHEYyHj1r3NHShhXFinR3DzQK557isrWfoiYx3G0bsyQdt
         shpA==
X-Forwarded-Encrypted: i=1; AJvYcCVa/uK+a9CW9WDF+xMqHvvFhM3P9ZPuG+pc745cWKA38JDFfG9Ujj76Hh9D8DwozQ56FbsejQYF2s7hnVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PpmsUODfk9BreRHSt8b91eeOXSYzGs+vcSzuBl0S5uwbmH3e
	L2Z0/cYy+EuDDwWoFpAhzufHYpoX4z9WKZscsDdKYSKwcjTGI9/Z1kmSVcGHFa+9itY=
X-Gm-Gg: ASbGncs6PYNaeOQm/dbSvrT6ZmbSL+Lf/f/V0kIwPMfjog1tkNEnYqLCeKPuE4wQ2sq
	1F5jImtWKZXSKSkNCfQv6rn4R8mu2BfqMNSHFrP8JtZYDn3CglHISYdnLyAi3K4rshLDFy4cQkf
	/6nl1OFYGo+3OhoomHatGzUJfNavWw3Sj1wfAOhCaWpNduCr8secmhw7C6DHJpmGSfp1KmJWikl
	mWedisoWmhsqrzm7QmxtA6G4dBWcmW4Auftxv45JXV+6ZuGmcB08tJFq7xN1M7vRWcHY66g9Htb
	NhPBiyfvv0bI3cG9CpdLTWuoXjNnImBeKZ8qUzO9nEzOaiqAJEq4IKbF1HRc3J2VD0O1DSOsHlV
	ZxXKR7QeGaTRFL8UFiBJ+9LuA8LyZTSF3HAQ65tuY04/4xCxa8mflblNhjg==
X-Google-Smtp-Source: AGHT+IFbWMEm1USYX7Rq9NUIjPZY/j0rB2JHjRl6Tdj4Ye/pg2AbJ5imxLC5UbzbWi6GsAHZYHcJ9A==
X-Received: by 2002:a05:600c:1f96:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46e7115cba1mr21953415e9.36.1759491976464;
        Fri, 03 Oct 2025 04:46:16 -0700 (PDT)
Received: from [192.168.0.25] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723593d8sm31826055e9.11.2025.10.03.04.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 04:46:15 -0700 (PDT)
Message-ID: <385818b4-72bd-465d-89f8-774a76102506@linaro.org>
Date: Fri, 3 Oct 2025 14:46:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: soc: qcom: add qcom,kaanapali-imem
 compatible
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
 tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
 yijie.yang@oss.qualcomm.com
References: <20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com>
 <20250924-knp-soc-binding-v1-1-93a072e174f9@oss.qualcomm.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924-knp-soc-binding-v1-1-93a072e174f9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 02:31, Jingyi Wang wrote:
> Document qcom,kaanapali-imem compatible. It has child node for debug
> purpose.

Nitpick : subject should start with a capital letter,
also, I do not think the sentence about the child node makes sense, as
the binding already explains what it does.

Otherwise,

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> index 6a627c57ae2f..1e29a8ff287f 100644
> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> @@ -19,6 +19,7 @@ properties:
>        - enum:
>            - qcom,apq8064-imem
>            - qcom,ipq5424-imem
> +          - qcom,kaanapali-imem
>            - qcom,msm8226-imem
>            - qcom,msm8974-imem
>            - qcom,msm8976-imem
> 


