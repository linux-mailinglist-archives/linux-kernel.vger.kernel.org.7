Return-Path: <linux-kernel+bounces-816720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 667F7B5778E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD064188F347
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165B12FC013;
	Mon, 15 Sep 2025 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZ4cQqEy"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D452FB991
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934159; cv=none; b=HxGzs5avZoiTkwSyEZAWropAOZUGTPF/whMv7rBezX3i2SbOr3FLvnaC5CG+vYm3oR8lBWoPV9mK7mH67Venq3ghe6VO8MBdB2Bvtwx+se2+nUIgKVhvZaum29tTmIWcYW1jZXJ1tgLWXwIevuOrisdaWssl+q1stwNBHcif6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934159; c=relaxed/simple;
	bh=iKMAgW0jQTDxBTsxxTn3NzLbmR5UC1qx3JVqLTQyo7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPUn10MA2TkOoy3Kez2dnU8Imk/c3Q1s1pnBC5xLgusKuyO5et89jdl0z5lCj83PiCTYZ3ZkpiALJag65ZakqhrSECXbTxpzNzGARf5DgXtvmAYWYeJnKHDcLvwqzbTimEmZcfqYuloQsm0HklCdzLt2xVNXSTDUFcaQj416jiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XZ4cQqEy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45f29dd8490so13317695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757934156; x=1758538956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXVKXBL0yz+l6XWANTUIZ7DjyjmDmj0eECvduqIUxgA=;
        b=XZ4cQqEyHD6x/t5/XpLJ1HnQFMrIlWoQUkHNrcm9EGLe9JlwsPergrwjPgM6caH/Qo
         gpNHmGXsOWij6FKjwIhbe5BUxeQEGWwTiveDzUyCa8zP4L3tceBz1AudclNBiGkRydE5
         kt698gaEZrbkX0mij9WX+nML1t5PVbPBatxRyazfZ7WRICd+6q7b7ca78Oiax/CvNAUy
         G67bpaj91zIccIzoh0AXdeWQ86UQpYdKyC6oSlAE79YeEj6dtXJU8aMB+0GGitIf+3Js
         nOGRfjuljdoXC4VbMseIw6CWfWNOoy+J8/x5ueAIB7/4vw1IE/Shhti+mIglDs11uCSa
         ZRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934156; x=1758538956;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXVKXBL0yz+l6XWANTUIZ7DjyjmDmj0eECvduqIUxgA=;
        b=E9p1//inSoaFq8uhGZJzL7xRC04JpX/qC9ua0501VpL2PhI0VwWYFnvXEAcG2eS4M8
         itdx/v/2Pos/pxRV54B5+TPV5a0TidTbSmBHBUoO2xNV1i2vma5DfkVkwlQQ+03l6/Rr
         Rzsbt6oioOhYh/lTxITIQ3mYyr/ilFIuc8kEb8rpcvUpx1ppowgmdMkKmxpc+MBKxRSq
         hW/U/+Mq1ux243UFXsI26wQJHalH7nG5OKbCfP8cZtzYbuaa9CZoPAFV2YXXeYql7+n2
         tUyiFU2t/rMx2q6fNZJ5dlxae92lu7Tq/uqrD6GU/7yJSJC4YYRU0MxExUnvPSAOf1YT
         /Kew==
X-Forwarded-Encrypted: i=1; AJvYcCXuD6AWIS6HZAy8iEtFLFzXMb9ASjXOOoh3o7oWFket8KjvThQQAreZs7dSUm41VyHQzw1fZtNb+7dQZYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3nYEfpSSMNj/axIuicy1HkLdu7ED8tRB32+2Ha69KX+sDIRW
	YSg1Dn+uAtF6/NsSJEZgz4k4izDO8tiSzPrOGLwaRWkiHP6es5MCaKP1PbbX1rxKrBw=
X-Gm-Gg: ASbGncvIWraRZgRDnjdVuQmlraaxOSKRoZBZPifR9knwP8czJPVRn62+Ut47iVrEmH5
	FzWYe1R5Kla8AYB/cp3kCtItjUDCF3yXLxmSvuhN8xF2Y56RmDTpTKNYxr3cjzmML4++reSkV16
	7VAbF9zxopg0Nzi/RxJI54y3YvgcN1fDCcWUswpFMcAAyi1pqjmSGv3zrlIYiJ8UqOZvYL3EJnb
	YZQcobf+HPhQsxcN99BQ2hEVj41DWz7W3VkCAf0IxcINX9XsCvdXjD201+SGEJqYhHAI/Og7AQc
	P7Ywp8lwaciYZ322Xa2Jf1Q5QqlsGnhA1XNq2ioemaiapUTe3gxVAaA5MSMun0Vz/3MwMC6w4Rj
	2/TbkCpPTMJ1lOZhya9uiGOZBDZlgCFmKkKWCk5hewbpKalW+Chyi3vZlAr8MuvbyFTbpRalmrv
	eKeVJSBkmRQRy7Wayl1zI=
X-Google-Smtp-Source: AGHT+IFJ2l0baeyUrazrw5RINbL47twbhaJDHL/xHhmxwbAzaNs77RYQey961ZxCrNsm4Oc2tjkp3A==
X-Received: by 2002:a05:600c:8b4b:b0:45f:27fb:8017 with SMTP id 5b1f17b1804b1-45f284e67cdmr67539695e9.5.1757934156029;
        Mon, 15 Sep 2025 04:02:36 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d638dsm168083065e9.22.2025.09.15.04.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:02:35 -0700 (PDT)
Message-ID: <85b6de36-4f0a-41f4-a803-77355d5da3af@linaro.org>
Date: Mon, 15 Sep 2025 12:02:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] arm64: dts: qcom: x1-el2: Disable IRIS for now
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Klimov <alexey.klimov@linaro.org>,
 Anthony Ruhier <aruhier@mailbox.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>
References: <20250915-x1e-iris-dt-v2-0-1f928de08fd4@linaro.org>
 <20250915-x1e-iris-dt-v2-3-1f928de08fd4@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250915-x1e-iris-dt-v2-3-1f928de08fd4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 11:06, Stephan Gerhold wrote:
> The reset and IOMMU management for remoteprocs like IRIS is implemented in
> the hypervisor for older targets such as X1E [1]. When booting Linux/KVM
> directly in EL2, this functionality is missing and the PAS interface
> normally used by IRIS to boot the video firmware is not working.
> 
> The Venus driver supports starting the video firmware without using the PAS
> interface. The same code also works for X1E when using KVM. However, for
> the new IRIS dt-bindings it was decided to avoid using the dummy
> "video-firmware" node in the device tree to describe the IOMMU [2].
> Discussion is still ongoing how to describe this properly [3].
> 
> To avoid regressions when running using KVM, add a TODO in x1-el2.dtso for
> now and disable IRIS even when it was enabled by the board.
> 
> [1]: https://resources.linaro.org/en/resource/sF8jXifdb9V1mUefdbfafa
> [2]: https://lore.kernel.org/r/20250823155349.22344-2-krzysztof.kozlowski@linaro.org/
> [3]: https://lore.kernel.org/r/20250819165447.4149674-12-mukesh.ojha@oss.qualcomm.com/
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/x1-el2.dtso | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1-el2.dtso b/arch/arm64/boot/dts/qcom/x1-el2.dtso
> index 380441deca65d1b443962fbe6151f4aadd918383..2d1c9151cf1b4aca79f7ad67328ffc3c721b9dc3 100644
> --- a/arch/arm64/boot/dts/qcom/x1-el2.dtso
> +++ b/arch/arm64/boot/dts/qcom/x1-el2.dtso
> @@ -12,6 +12,11 @@ &gpu_zap_shader {
>   	status = "disabled";
>   };
>   
> +&iris {
> +	/* TODO: Add video-firmware iommus to start IRIS from EL2 */
> +	status = "disabled";
> +};
> +
>   /*
>    * When running under Gunyah, this IOMMU is controlled by the firmware,
>    * however when we take ownership of it in EL2, we need to configure
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

