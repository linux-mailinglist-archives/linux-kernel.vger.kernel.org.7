Return-Path: <linux-kernel+bounces-794101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F03B3DCE1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A175B188D5BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183332FE589;
	Mon,  1 Sep 2025 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXhpOICq"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0202FE06D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716377; cv=none; b=kMSkv4/K92sCZwXjUDPHkfeSdkOv2JyUYvhBwhY5kZgmYD/ONcxq2d4++iWLOBpKTNs8Qo+hpDPPH0jUvqBHALs0lVJEVmsXoyKmVBt155/Mv+x7bAWO0w2vPzXcKiNiVp/HIUJO+IppTKN+9lb5sek9RM2kvJSf9HcFstBsRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716377; c=relaxed/simple;
	bh=QoCdfFwHTIhOjBwrsgIE/hHcr1xYXegmqPtRl8bOr48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVlQ6DAieWq0vPcCRrwZY+FExf5jTf9wx/txV8uOqBcUzAdoy5ZbnN4xyBzYcfFM0RpH2h6+k+AtVGmPcloYZX7AoTxGtjyxBAupbl6UIDbLAPHzui48bYw0HdsW603yjgAKyUujXhLWxjQhrarn+UxH+vyll2Q+OtVJkZSEfS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FXhpOICq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61e425434bbso1462677a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756716374; x=1757321174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCuDvCcZtXrgauUzDw46OP3GVMHfHfFOYH0ITU3ZEfo=;
        b=FXhpOICqDBMtI/Tx6BqwrNKTDDbxeMlX1+r0qq3CD+xUoGahK7wURA6FxIWjEtycbM
         Bbl5CFWBxAO5o3kwM6KYp+AxkqZZfxCLxMv10ijf4T4nsKqJ17GjZjkuxkLsb00iTWZq
         eZPiVm/+gNjhpMNGLIVd81N78ttD7BurRKDblujnxO2kFOGqmCb6WGXueSPsMPCIdVzc
         zKzLf/4xZ3p6HgPthkWzcBjVFLmXXwoV+s6vRsRtLo7ClueWwrBRcDam6BEKI8U7Gmcq
         tC/XzQyvEkm8hUnzMVGtKgZeQmJhC+mgNEfxZw1uPKvqyrIY8op5qKehrZD5sBTd0iJF
         9cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756716374; x=1757321174;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCuDvCcZtXrgauUzDw46OP3GVMHfHfFOYH0ITU3ZEfo=;
        b=K9s+kRpDVEMwhqBsxBdNmz8VXE8085ZR/Q/Sl/lDkpU5Jid8zPxlfmOOFuGKWzjCkA
         ymXuGLuit3GlmZUBRhuO+rj0QNz07Wgrix8+mnEi+ofwZCxxQOYJ6wYy9f+eA02yOt7D
         WNbsr+kRyUeEPrRUdGtS22HzGN/Wo/mdA8DAeDntfB+wvxDwpG0p4xVTtHKnEukxPv45
         kIkTeUfYeL5N8i7nplrD7H5HXUpCT9PzH57IRaV9hmH6TmOYrkQy3PvXOX6TYGifjU2g
         H2/fx0JLymTJa71B1K68sgEAIEDvvWmLBSFMlD9kSxx8UWECNCrkqhflWwEw9Oifwhlw
         aqsQ==
X-Gm-Message-State: AOJu0YybuENbHvDII1lGYdmnEHm5BdTOjVzETMoOe57AHZWlz3n1or97
	L/rq2wK/zr8Ui3g0AFRT62CDrZDDBeys9XdyAh61/V2FPprLWBrYaXWo4Wb9YQuYILuZbo3qBW8
	lyVMnthY=
X-Gm-Gg: ASbGncsDvkfRDT8qdLs7CiAn1UavwKjm76qA4RmRnZb/kHiyOZJ+PoRul9lGlULobo6
	F/AmZ/WiUy2XpalkosCcjQxjvkqhOSK+Q2CYaQxiS14P427HDxwBpjimSrQTZspg0pOblFOqdcQ
	xM/p9hIGEy6R2rYIUHwqiViNapZLiPhcxP/6GhLEt+vEdQdrn/5eq1KZ24fBBvXdCAL3Ds69n3q
	oDQ1yrbe2AsBiBcVBuqcesZvhIB56rd+OiPXYwQnO3ZS8qYwCN9N8fKSlEsZdPHjHxMBpIQY9J4
	PkgCT7I+d5cXKoJUpByL/5wtOQ9YiTBfHfbnwFZJQ+Z6kSSSKenHLqcFt4m0In2f1iOPKXeVb6B
	okTi6+64ABzE4krjsHyaM10Bwl7kz5L3xeoHm+4lHrO0JFPs8Bb3Uh66GVXK6GGgKyb9LhUImHh
	83SnaQfkSO4S2u1JXmgO3swX9v+TO4DQ==
X-Google-Smtp-Source: AGHT+IEwgaLMLaFBKFr/PWcWKPlujPF7MSGDJTrP82Ursog0u8JoY9Z+hSv7cNIFvoZlLeRqHrBOgg==
X-Received: by 2002:a05:6402:2693:b0:61d:dd9:20db with SMTP id 4fb4d7f45d1cf-61d26d79f49mr5756112a12.31.1756716374144;
        Mon, 01 Sep 2025 01:46:14 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4ea764sm6686462a12.40.2025.09.01.01.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:46:13 -0700 (PDT)
Message-ID: <dda29710-4997-4c23-8620-b43ba402b7ec@linaro.org>
Date: Mon, 1 Sep 2025 09:46:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: update Dikshita Agarwal's email
 addresses
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250901-update-email-v1-0-8fd49d58c0e5@oss.qualcomm.com>
 <20250901-update-email-v1-1-8fd49d58c0e5@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250901-update-email-v1-1-8fd49d58c0e5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/09/2025 08:33, Dikshita Agarwal wrote:
> Use dikshita.agarwal@oss.qualcomm.com as the main address for kernel
> work as quic_dikshita@quicinc.com will go away in some time.
> 
> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 64ecfa45540c3e10cdef4fc10fc10e854b396c99..fe9253d6fe49c33828a79ddcf59d024495661774 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20818,7 +20818,7 @@ F:	drivers/regulator/vqmmc-ipq4019-regulator.c
>   
>   QUALCOMM IRIS VIDEO ACCELERATOR DRIVER
>   M:	Vikash Garodia <quic_vgarodia@quicinc.com>
> -M:	Dikshita Agarwal <quic_dikshita@quicinc.com>
> +M:	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
>   R:	Abhinav Kumar <abhinav.kumar@linux.dev>
>   R:	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>   L:	linux-media@vger.kernel.org
> @@ -20890,7 +20890,7 @@ F:	drivers/usb/typec/tcpm/qcom/
>   
>   QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
>   M:	Vikash Garodia <quic_vgarodia@quicinc.com>
> -M:	Dikshita Agarwal <quic_dikshita@quicinc.com>
> +M:	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
>   R:	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>   L:	linux-media@vger.kernel.org
>   L:	linux-arm-msm@vger.kernel.org
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

