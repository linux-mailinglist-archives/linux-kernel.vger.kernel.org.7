Return-Path: <linux-kernel+bounces-819119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D62BB59BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC12C16CCE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F05B3191BA;
	Tue, 16 Sep 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flAGKLeT"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105023AB8F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035472; cv=none; b=G8eCCOC+Ak8djFlarCSGMz22e+i/F1zA3cZDhCatA1wHGCMSu8j/koaaznAKkxDbxBFrSyB9PFqTjVwrO1cPbvZMDvVj6vXZDuJgUKywMyVNDlEXuSMw2Un/AfkKJbqnsZf4Vdfs2H6+3o0jRfCkoPMom/wM7ASGvPhmU3ejIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035472; c=relaxed/simple;
	bh=L+u5QAY/g53mrNOSFhQziio6E/nTTNyYqNyfrjO4mGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaimCwc1s1Exd91S2Nc1vDsMzUv6ItNXI3SaQnSRsGYO/I2PvrCT5kMEWPSwaVXwmkjMKSLuK6Vyoc/6LmncvJ+TvRYBMK99sTjnmboGtlWOag27aD/+M8MquwvodZ6EGngtbSmTDMdBfUzS2+2IyiuGWAFn6JE8Jsc4Zh38Htw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=flAGKLeT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0787fdb137so837247566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758035469; x=1758640269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSIWZxM7MhxYYBISjP+LvVgOq0iQr9M2pD8SpX1vq/Y=;
        b=flAGKLeT+J9p4d2hqYyuaWIPGT4YM1qjViT7ZexoZ/Dbeal6QF53Kpj2DTLu8wdt9N
         4x1WDSeEywW72lLwprO3QlvsmFB70/yvuMxFa4/N5/nQw04FGkKULzwry0W8cDxgGab1
         ahdXCaRPxhMB2f6CeKiSDqTewJMwqnF+c0BhOuFKqTcias8rV70P5nVkUdmqLPuYKUL5
         S2+DZW5ntExtG6vDl3cT6XPqj3K4kuOYJ8RoBF8chTD0x4QaCMgg1lq86fMwis9Ar1zg
         PY3+a5q91O7euFyecT2h1S1Hi+aan7ikGcH3yt4ROowR5OX5L11fMh0T3EviLy8XCAq6
         aQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035469; x=1758640269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSIWZxM7MhxYYBISjP+LvVgOq0iQr9M2pD8SpX1vq/Y=;
        b=IyHcxx4HSoPTlJvRYudNiNogzAJ+p8Ws1GOpt/vDdT09NnqDcvbSlSepHXlEA+zzDB
         d3S+CkbjLEPdBq+FnG5qnhwz7PM0ErNHiG/46Lm3Vn5p2Swn3RROSujgCWdvQtDg+a/3
         PTG068UWrlEPDf16cp5wYyzgZahxtZug0bmzWAXh8sEe1OGLyZoIKlnUIfev68Wp76kH
         CkWsoOTksgoGNdkwAUl9FPYZCE+2TOKcKVSG9Vi6HDrjfRQLszpxh/1Y6TmLDuVU60dK
         7Fz0Z+nm7YGYYsx9JfCBl3et87gA586R3odSe8yGmRlCbzzlHztpn6iTv7WFw6DTFxEM
         h7vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg0OcKxXcV1UiPt2l9wbcsj2TiJidcKQiFPDq6iNcE+xQfy58eRvtBxrn89FtXr81MvllnEHDLIrInSxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIxW09LQOpXGvQTdEFevHhpmwK6xlxGkCIMI+3AcOD93VfY8xs
	J2KELf6mCcIWqW1uLi4BBJK/87u0Pq7cg/4J1OCtZvB4JHnUPkXcRO9Zvm38zxFd2wU=
X-Gm-Gg: ASbGncukJ+Y/0OSoHbN35aQ8dBkrltS3RdUNV0A5tRxjNp9R6sSoLRCPRdY0msQbr3W
	iWk6xMyx09NuT4NAlrBVhTXgfdx5L6bqGvAaEQ6WC3vCuHAC2UwbTE5E4GAdxzugxo0kdTOgYEx
	5/Go/Clw15HGibL53NlYjB5ZJxXUuwQK7K4KIJuQVgp0C1fkAIxPk2ZSfsGXx6h0K5Z6zp+HREw
	Pn6nSzVQTiQ4uNBbGWUnXKa8Gmm9aufH7XiLWcXzwT0VsOigPuKnAEmUH5ocSTEreUiHwgyBSev
	8PkK2ddXKi09eDJj5e3ywq6hzX1LRbUWSJia9+mM02s9AXlrTbAv35w99rlyh90ljlzaro1WKiX
	ZbpH3v+tU7TQySf+eYf5c4xSg1xAZPw==
X-Google-Smtp-Source: AGHT+IGE38GAQpAlNcaY6PmQ2ym8i+fHkW59Dfqvwtzp8Gs5cBbakiisuLH5KtCDcSUCd890i3tcSA==
X-Received: by 2002:a17:906:fe44:b0:b0d:5e0d:eaa4 with SMTP id a640c23a62f3a-b0d5e2c7bcbmr1075066466b.16.1758035468798;
        Tue, 16 Sep 2025 08:11:08 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f5da1c32esm1989288a12.38.2025.09.16.08.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 08:11:08 -0700 (PDT)
Message-ID: <9d74713c-00fc-4a17-92ed-b3e3420160e1@linaro.org>
Date: Tue, 16 Sep 2025 18:11:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans: Remove unnecessary cells from
 DSI nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250916141931.601957-1-eugen.hristev@linaro.org>
 <kday4tlzjmycgfexiaxgwnan3a3nfxt7sgslncsktcyw5bmr7d@nmjtdm3gd2sk>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <kday4tlzjmycgfexiaxgwnan3a3nfxt7sgslncsktcyw5bmr7d@nmjtdm3gd2sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/25 18:03, Dmitry Baryshkov wrote:
> On Tue, Sep 16, 2025 at 05:19:31PM +0300, Eugen Hristev wrote:
>> Fix warnings
>> Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae94000:
>> unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property
>>
>> Fixes: 73db32b01c9f ("arm64: dts: qcom: sa8775p: add Display Serial Interface device nodes")
>> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
>> ---
>> I haven't found a pending patch for this, so here it goes, sorry if someone
>> already sent.
> 
> Thanks, but no. The nodes are correct. I don't think we should be having
> the -cells boilerplate each time somebody adds a panel under the DSI
> node.
> 

I understand your point. But leaving out warnings for a possible future
node is not ok from my point of view.

>>
>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 6 ------
>>  1 file changed, 6 deletions(-)
>>
> 


