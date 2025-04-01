Return-Path: <linux-kernel+bounces-582919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CFBA773FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 07:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0B8188EBFF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 05:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0021DE4CD;
	Tue,  1 Apr 2025 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PFkXiwP6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236A614AD20
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 05:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743485846; cv=none; b=IQn8AbxgqJZPqc6C0ShgY1eUmjlEd5ZSIQgN83DQro3XK86ghmzblDw1m41NuRQDrQAhbLN9RlUBQCzh4k84FZWEDm8icTn6P9lUx6AhtOdmF6nF98izbcILpfRu+O8d0wMHd2zCGIWZ0AYdEbkNsX+/c9wHhhjn6DrydH0c7IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743485846; c=relaxed/simple;
	bh=s0VbEY+y+zt4UWZGVhiFYKXCJFm5wzoLHCoJFYBIOjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlS86yF9bAtSdksR2LNds/s9EiH2Sv+47biRUBbp+nRCI2/gOtaWw01jyEDQg1qPTNv054PvCLGoUckUkvkmflxpEG/Ab30IM/xs6S3o/e/Nhx2WNWLBgo0vaWwu6UBbYqXRu+T4EEGoRzGEhSJ6StYZgqU2CVenUCAaQBmxgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PFkXiwP6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d64e6c83eso4319655e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 22:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743485843; x=1744090643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7sGlS2iL/z9B2onN9uyeopwDJJ8I8KTQrZr2eIiejDY=;
        b=PFkXiwP6yukpkZN4wO1vxEMLABJhjfG2anYAeBCMbNbIccwhd8E8cVDxNNDkxYirbt
         JqQz8wp4hTxsr27qjt9+Nq8PCgaOzD51Ne9tJ9BzLHuBqjx1BcIQaeGXpwR0R1f3zpH3
         CJG2Ysa+znaO0CLCVik3N3mj3G/g8j3HWBhOaKMA1KuFx0/nnMzm8+kudgjCuOmbEY4S
         2bipBPv6+nHnUbiJjJLPguAzhRtOmfBnE7+XdddFidA4ZMuk/ZzlFT8HKLrVJegsZrZ+
         E5Mmw9sapmSE5Et53h7XY8/kb/zWQfqmJwnrgptnQP4TwQ7BqGhweHTiYUi42eIXYnU1
         FddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743485843; x=1744090643;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sGlS2iL/z9B2onN9uyeopwDJJ8I8KTQrZr2eIiejDY=;
        b=Rl60wLHUQ8DC1DCBGdGsHBuwJry2BJlgm7oO/Y5px33eX8QTF8PrM65rwbpklzHOAN
         PzzdkxXj1wNUUzpzwMOB11ScBGeXvjgTTjAqxz755vOsIJIlXtz0Kd4v9zfUbkc66Vkd
         LLCIBzkCCj7gTay1ty/5wqj6IkAAaxaNB9nl5z99bpTw9vHd5xngKt2QgOrZ96ZRzeDG
         yYsaOKsGI2tuszuZlt9fNePue0RpHXKwd45BJAMac9SqC8XlTo/Ji6gNZZSeFqlUd0Q3
         9aGXZbcM8Pyw+IxjiT9hg3EbYcNqqNOMRrhqe1rxfo4FGJEKtk4wp2Cs679m9LP4BGm5
         q1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWmqBNCl2EvlovkgCzza5ymRomJgBHKsllQtbRwwSCFKDy3BPTnESS0kT0/FzdginY3G9ZoeYrcX0diY5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YztGQ74EfLdgPOqkyqvj2mA2DmT62WXHL9cLSKswcABagEpsAuY
	/hprAX7nVn72UNTmwwjenO8vputdVlQWBvH+zIyXVYazGg0ZluRSnW+KwgIziIc=
X-Gm-Gg: ASbGncs37PddYUyN/iDwtSJwpPFG7ZGio6TsA41oHeq6swgT0Zx1mD5GPah6zShuft2
	e/9Ef0bDVTeLLIJXs6QUgwgay6Mja47t+pWoU2n+aYIQn8c6SjE7WPLfQClWciYrnyv/Maxvvrt
	czQvFfhjYiR9Yaz1kbSzPtYkK102zxLPFXi2zTV2dhL0shFlkZLg0kbuz54pZ6zU8PlyWP3qzsb
	gnuIiwMYrwCMrj2rKDstxFOhofR2bR97Ys/gzXcIlfWKO57aTB9Mu9bReKKcbli+P1oEAjRrPG3
	ECm/rUqU1GOUhpX9Wtb6EUwy5WKJd8VX6NMGtCXxS4GzbpJ8Mz4l8a6XkH3bVqcjNP5UVquo4Q=
	=
X-Google-Smtp-Source: AGHT+IE9VVlqaElKSlTlRNsLp5lNckamDxE50wxkxfz1YXgMaph2I/ABZPwdbX4HuFlBp2KCO3RzyA==
X-Received: by 2002:a05:600c:5488:b0:43b:c228:1ee0 with SMTP id 5b1f17b1804b1-43ea93dc66emr3022695e9.7.1743485843423;
        Mon, 31 Mar 2025 22:37:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d900008d8sm142376205e9.33.2025.03.31.22.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 22:37:22 -0700 (PDT)
Message-ID: <0f590400-d50b-4b1f-afb4-6d3ac112d426@linaro.org>
Date: Tue, 1 Apr 2025 07:37:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] usb: typec: Add Parade PS8833 Type-C Retimer
 variant
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan+linaro@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20250331215720.19692-1-alex.vinarskis@gmail.com>
 <20250331215720.19692-3-alex.vinarskis@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250331215720.19692-3-alex.vinarskis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/03/2025 23:53, Aleksandrs Vinarskis wrote:
> Appears to behave similarly to Parade PS8830. Found on some Qualcomm
> Snapdragon X1 devices, such as Asus Zenbook A14.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---
>  drivers/usb/typec/mux/ps883x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
> index ad59babf7cce..095c36530904 100644
> --- a/drivers/usb/typec/mux/ps883x.c
> +++ b/drivers/usb/typec/mux/ps883x.c
> @@ -447,6 +447,7 @@ static void ps883x_retimer_remove(struct i2c_client *client)
>  
>  static const struct of_device_id ps883x_retimer_of_table[] = {
>  	{ .compatible = "parade,ps8830" },
> +	{ .compatible = "parade,ps8833" },


Don't create unnecessary entries for compatible devices. Patch should be
dropped.

Best regards,
Krzysztof

