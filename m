Return-Path: <linux-kernel+bounces-818977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E282B59929
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9AE16C15B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A4C28315A;
	Tue, 16 Sep 2025 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mOCGnvwg"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164B211460
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031944; cv=none; b=TYge9y8Ks+OHygDypxtxYPNspcc/1BFawRVimWu13Ui7KWV/pjtkYJkBx7NVxvZt+wBVyg9IkcuoVqcy0vmai2euBK8BXh1Ltk/WZYSAoj4ZqL3v00F4T8GNx706H/ceZHc0WfGzzbqvWYYcrUA+C3AhfEbBrCX+RPdrz1FGKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031944; c=relaxed/simple;
	bh=fVduY9ChM+XTiJ/WxOZb5vLjE0k0RtwqZkyUiEW8pZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QoB6YuhvL/xprn+TGQlqY80B61moraAgO6dALWe3+yWyXsEfaIpRmj4opz9T+z8+iARgjXfl0GTFd3QTEdUftIV94qGQEnNbjsgPS3I0xYERjY1HfmUiJiShM4zFll8usniiFdPz4VgIFspWHZm8JCE9r6NvtxglWWdHox1xU8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mOCGnvwg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so52889935e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758031941; x=1758636741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ihTrH7t7gLzKRumooOOczb4IBjokkGyHJ2+QxNRMxY=;
        b=mOCGnvwgcrU5KMtGEYRdZSbfkuz1xSxEYBDr0cn6QPZPfHN3Ekbdo2d4sqORAIe5Md
         BWG3CUqFvXoePD6D2vMNjzRJMlxt/DDkXlXbSKT3p5XRGysYXw98oGzaUSF5L6m8FEMr
         OzIjEKCneuEMM6RXtPw1JcA8qF/6eUN6Rax4+x3DVn4TB+Lpx5JbC0Tz1QpCl9QGDrlJ
         jreFR6TE2YU7/XEPu0u7ag1n+bpDl5msFmnjdxhllhSaZT2vxM2Xl6QklzlghUipVSZC
         HGZ2Ad3FDOmHkSwgdSdNuh0hpoJSHa5xvXNmLqPaVA+zLmlYR1hEyGuK9VPacYtdSF2M
         K09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031941; x=1758636741;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ihTrH7t7gLzKRumooOOczb4IBjokkGyHJ2+QxNRMxY=;
        b=KG9nnKKbtmJH4p2Gk6f0+UvsbebKraot3mrCFr8m2Et7vdduJtaE5BBpY4jnxqtpye
         NVquQmcLR2xMJiDndpjvypCH7ZoySCUA+VGS77RgFyWIkdBxMaPjGhKzWbrnOnEAEB9s
         VuCGTJqLtzgBxk5JyxDOJYEhk/OUriXu6+mcimtW29s+LvX32rwHqi2cRnlTTMlQlBKW
         1lcEAHSmlTrCVgMxoiUchM9vRBSjaefyW4j4CLqUhaqW+/Kd5oxlKtaRxe+wBm1oV3TD
         9tCdeMH+hI7nfEO75eMlatqy1O51Px7JBzQWX5wLVnW9fUPG1SmtABIVvoONYIpIgIEj
         NT6A==
X-Forwarded-Encrypted: i=1; AJvYcCUkmOTkUZMWFicuwRBDJaswPv0nZZUeUELETH/5FksVuMdxLelUplO42ibMbHaw3NzT6OLa9uQGHPimFwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuQkaMggbcRSaES340lCm0mqkz80sGMniabZAO3FR4G8W0jyLA
	2TrWmu8dgkqQZg8ANDbowpssgskiAQzOVK9BDDidOC+XXUMojqFVxEb0UvQk5g7/eEs=
X-Gm-Gg: ASbGncveKq+L8iRCdmEM5Dpazme71FgL9K7Pox0JSuDI4/Vm4W5MeIfaxhnhMuspKUx
	UearpjjbbEfO3xmW/LpN1ODqdQbjsJfR7YHqIyl+fu9fKELtGUwTg4jSsIVgjndMdM/yAvMaJC1
	EGWwDlr+HX8zfr7Vypv/id1Xes2Tyjq+SSsSHUulToAB7XuWmjMt2DshoCo+hSpdhF1kaIrq6Aq
	F8qH9+QuPpz07bA2w1clHKAsbZd/LvmEqs+s2LA0rR2UU9IDHqfUxyj0y+ZnIVDW6uitUujtbup
	7MARyHsq2d73FJe9d7zS+qKwtmbpn4GZDuHjGbhCbLpGQ0Ff1kTfaMUJSX4XvEAKIicRT3TzqSC
	mGxiwDn7bo/Cs+UQYsJ4T+2l6R8F8ygPRYj76+03JkgpcsAUK5WZvpXU9NvEw3aClWTTdzNWKDW
	j1w8+YDDY7T5zc04XIafk=
X-Google-Smtp-Source: AGHT+IGmb1kHFNHQ4frPlib14MxI7w4SRTDLbyi2XJON83MQa2TxlNaD5uBHUokreLL+hCdD46cN6Q==
X-Received: by 2002:a05:600c:1546:b0:458:bc3f:6a77 with SMTP id 5b1f17b1804b1-45f211c4c03mr137113085e9.2.1758031941271;
        Tue, 16 Sep 2025 07:12:21 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8c7375fb7sm14091558f8f.14.2025.09.16.07.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 07:12:20 -0700 (PDT)
Message-ID: <ca511d42-0381-41d1-bea0-0d766e04f9f4@linaro.org>
Date: Tue, 16 Sep 2025 15:12:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tty: serial: qcom_geni_serial: Fix error handling for
 RS485 mode
To: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, johan+linaro@kernel.org,
 dianders@chromium.org, quic_ptalari@quicinc.com, quic_zongjian@quicinc.com,
 quic_jseerapu@quicinc.com, quic_vdadhani@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 stable@vger.kernel.org
References: <20250916093957.4058328-1-anup.kulkarni@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250916093957.4058328-1-anup.kulkarni@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2025 10:39, Anup Kulkarni wrote:
> If uart_get_rs485() fails, the driver returns without detaching
> the PM domain list.
> 
> Fix the error handling path in uart_get_rs485_mode() to ensure the
> PM domain list is detached before exiting.
> 
> Fixes: 86fa39dd6fb7 ("serial: qcom-geni: Enable Serial on SA8255p Qualcomm platforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
> ---
>   drivers/tty/serial/qcom_geni_serial.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 9c7b1cea7cfe..0fc0f215b85c 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1928,7 +1928,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>   
>   	ret = uart_get_rs485_mode(uport);
>   	if (ret)
> -		return ret;
> +		goto error;
>   
>   	devm_pm_runtime_enable(port->se.dev);
>   
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

