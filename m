Return-Path: <linux-kernel+bounces-855164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FBABE06F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8148B501355
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A639E30DEBF;
	Wed, 15 Oct 2025 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rm3AAiFP"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0339302CD0
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556629; cv=none; b=P4syo+Q2ATZZZ/LtX+UUHJj7tmaZOMLAqu2twMsfHLsC1RcHiwlqCIKMtFUIxdksFzTedylzcRnaQgjJ/B6pU1EM9qSZm4WSkSJsSbOEm8Mqij/MLy4WJATTMSLYOEMs5KTHRvtLdSpCI3PPKJAqHjjbHioHrq+3hdfFokgWVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556629; c=relaxed/simple;
	bh=nPbCX4b0wyKA4xqnzFN93V39LMSXnGf6slFjcnpoHkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prBaEl//vQOZ3bf7m+XMPhBdzx3B2B5kv4cYffpmr6GFV7z+x2A/TN6eGKJLs9BrSC51hghX0JgW/y220EQkzK0A4q0O7iLWp1T03giLV9G0LOcsjN/HA3jtA0uGBMjom6cZRW5Ci4szc7UXrK0VMgN6sgPvtv8MYhK6W73Mt7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rm3AAiFP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57a8b00108fso1289388e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760556625; x=1761161425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn6HzcB6Q1wB3Fmq1gYyY4hfzEIJC4qbMSCV9Ej5PPg=;
        b=rm3AAiFPzKNzHGrPkiYs5NwYhdnsqXjdCQBWWNuBFoqeIsqbpexoTcLGK/luwvXmun
         wpx116Sz82PUm2GQh7VvldSRl6Ucoy6S6IFHR3OTXlIT5x/9n1RJDL2bVLuqAQa3HQjs
         dS9npXuPQ7skG+fOpmauPij9yg878q7sGUl5LJReLUJkQ/5q0K/BGVicwKqV8fmmadmJ
         0B/zLJRZ5oZFvTjYF3U5BT6Yqg7EQi1KJqMlakIRUmnHLhHGgMpjZfy3s6TYgJfPff0Y
         Qm2OCew+O+fK1ie7UR5poaypnjFT/RczzkT4862VbFs3icw2uroj8kBZbdZn0eEYeY/X
         2pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556625; x=1761161425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xn6HzcB6Q1wB3Fmq1gYyY4hfzEIJC4qbMSCV9Ej5PPg=;
        b=eB+tXQ5ath0ZZ/YBZJPshjbUAGub9v8VjHIFV+y93HHa/UPzUK4efqIdXocg87t1oe
         MD2ANvDMeTwxNSUwYtec7xL8dj2Si4fsHtso59fKzwbfwLl9IzKwlqgJjaXzot9ambsZ
         2PwpcP7jUXrwepdvzvtcsEral62OBVkNUk0GSl66HuJYST4QZAxFHoPgYKAs1bKGB8zQ
         qrDyrG92EdRr4S5wjyKsz0rGDAF0Zcf9aF/Ygr4dkiqWkqhFvHCQ5DgPTnSyLe3DrpFH
         gneOn1LBPSxWOy60WEiwD/Mo3Jhg2NlDE7C0uLwyAUPY9NNgNpWwcCwntvDjyOkWHja8
         b39A==
X-Forwarded-Encrypted: i=1; AJvYcCX81nenp8pgJup1JsEEG3TEVBp+W/gV83Up7+w8/7/jg4vU2MbjQZdSsTpJVZK2cC3lKzq2sLOAZHnSyII=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYett1SBdMyFcD2UtvOJ8oZBSzxopEPgCaNdYOLODZ68H6C//D
	0xZiTegrXhVuMd1sWtMq7033/8qK9KxyIaSrjgvE28kPwF8MEhalJABVtLMkjAwUPx9jJ1N2LDz
	hVpQm
X-Gm-Gg: ASbGncv8m0DxjHqWo8di01kPlwdvEhDgErdJuHT9jgue3caa/5uM8b11w3XV7MZ1tM2
	d+MAxgos0mr51QNQgRI+P/kk5jK0D26BpTGCKsLxNbY5O+hY4VTdQ++6LCDU6O4RSDaSBQQ4EqX
	BZSGdD+TZAM4M6ljlYbvgphUCH5L3ITlhuctlSsTSnEiH12nYaw0nKU6THlcO5R0nguJZ4+1F7X
	fGMfgyE1ssn7zaAK2ZeYLFmy0sHk+onk/h+u8OK+UJWNUJmB5bTeQzvZYLC1LJPaJAVL0AHwJqd
	mMXYZuxz19ro4olVZSm0c/b7LyEVh6/GBjUNPXKNgzkjFwoz9Za+S9TmHxUMDjHMv0xOMgGgCel
	L5Ksx6Bq/lsCfE4lMTOuE/eDVPnypssIiulzWQksgeEkDMqZaBIgLW325y/8Uk2bPzL1amIRIbc
	Z6qGJqdEc3//kNw1TyK4HvcBP8aIduym0pdA/oPTZH92GPwQEqLkuwYMAPK7YI3iQ/9i3nvA==
X-Google-Smtp-Source: AGHT+IFtiwV326wSWMTN9z/8oSxLb3NlWVYgOdgv2W41aNnsDtgsz1zRyzjEAW4kE//A9Xvesx8DNg==
X-Received: by 2002:a05:6512:118f:b0:585:805b:e3b0 with SMTP id 2adb3069b0e04-591c904cfbemr681247e87.9.1760556624721;
        Wed, 15 Oct 2025 12:30:24 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5909413ec6csm5546283e87.48.2025.10.15.12.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 12:30:24 -0700 (PDT)
Message-ID: <e2c43a8c-a9cc-46a1-9ddd-5d6dfc7e917b@linaro.org>
Date: Wed, 15 Oct 2025 22:30:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: i2c: qcom-cci: Document Kaanapali
 compatible
To: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
 tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
 yijie.yang@oss.qualcomm.com, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
 <20251014-add-support-for-camss-on-kaanapali-v2-1-f5745ba2dff9@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20251014-add-support-for-camss-on-kaanapali-v2-1-f5745ba2dff9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 05:56, Hangxiang Ma wrote:
> Add Kaanapali compatible consistent with CAMSS CCI interfaces. The list
> of clocks for Kaanapali requires its own compat string 'cam_top_ahb',
> aggregated into 'qcom,qcm2290-cci' node.
> 
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> index 9bc99d736343..0140c423f6f4 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> @@ -25,6 +25,7 @@ properties:
>   
>         - items:
>             - enum:
> +              - qcom,kaanapali-cci
>                 - qcom,qcm2290-cci
>                 - qcom,sa8775p-cci
>                 - qcom,sc7280-cci
> @@ -128,6 +129,7 @@ allOf:
>           compatible:
>             contains:
>               enum:
> +              - qcom,kaanapali-cci
>                 - qcom,qcm2290-cci
>       then:
>         properties:
> @@ -136,7 +138,9 @@ allOf:
>             maxItems: 2
>           clock-names:
>             items:
> -            - const: ahb
> +            - enum:
> +                - ahb
> +                - cam_top_ahb

Why is not to give the clock "ahb" name like on QCM2290?

On QCM2290 the macro in front of the vlaue is GCC_CAMSS_TOP_AHB_CLK,
and name "ahb" is good for both, I believe.

>               - const: cci
>   
>     - if:
> 

-- 
Best wishes,
Vladimir

