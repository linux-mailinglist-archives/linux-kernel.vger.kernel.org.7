Return-Path: <linux-kernel+bounces-875932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ADAC1A2A6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A0F3B59B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436CB33B97A;
	Wed, 29 Oct 2025 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+zSlKYM"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA1338F20
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740409; cv=none; b=rn1IUMLZxOqZCyFCl+GoiWpBp8TFIPQK5XTVkEhukGwaL8BSRF05FZH74mFdItEk1BTzBRI294fdxU8R67OuRggsh38BiUBxs0XW30GoL1fSKmqCHHJwcz6ua8qcv83l/GFFB/yIyfQc/fEaUONmnZuV6yp3XltCKuyQ7byt/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740409; c=relaxed/simple;
	bh=1Ya7qkOQEDdNbi09gHmO3z9rZVCZYmN2SBoOEI6PACc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTy5w2dffTlw25dZD6Jl0qopCi+tvKkDntnA5KE4N2bjdoplGqcaxJ5T/JhNhHUJ0iIF83vnAnNdrmK+DCK8uJBYsO1/6Q0eZQRNKHu9ss9t9s10kiukck8r2kw4WLSL4HNQk39Ka0WcTAm9kyiqW+nxlmJtdB+UM0Zy0pPC5Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+zSlKYM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-340324d333dso1557739a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761740407; x=1762345207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyHDL+kvmpNavTHblJ9DGWC2vfEbREpLIB5luOfUbqM=;
        b=W+zSlKYMT0bua6TOOQUy6HJUfeQLiWUudO1oSVysP+DvpjMQtmFsjl6LUaytNyguve
         peaHH033ZT5zATHf9PNjAXWfEafOV9npzRf1vQ43e79G2EZWC1dA8+gUot06QnV1Te1t
         giMlYCS3C8YIm/Y9mOBkUgklqyk0c/G5vEp0ycxym0UM1l7iPSMmZKqF1ZRRWqLtUadV
         PiEeHIMPGFRN6A6/6M9+qMKAbO98Ih4HExykrC14vKYXaMyDfua8fJimeZ0yCb9UpBpf
         JAEl3EAQckmt1LMV5lSlpXrF6h7mUjbU/+4OMyXWWtT8GubVcK0ssYAaMT4/DwP7zRio
         +AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740407; x=1762345207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vyHDL+kvmpNavTHblJ9DGWC2vfEbREpLIB5luOfUbqM=;
        b=C8L6wihqLs34BLmxpMVMOMuGAnbadFwXYWEMT4RiVYHYgdmltLeevRKcB6CTPMD8/y
         E34jegfEfqSrwRM/1Rojd+6p9JwPVPlzQ5k3eG8MCZ+B/wDMkGzNuOBkBml9N2O875dr
         1jwt4AGkxzVtMtFx8yBNJTgKI2nohNJLeKZRm739xdlSjUcPsL85i905u3J8HZgk/uOC
         MSbXva5QBPBTtJVWyhiNZn3WItmAmZZNWLjiH01wiFAQuQWm2OVNtw6KlZPPMajXVrbG
         gb94X7gTd1nm24y/8b/4kgLLr2iHEIHN8keod1HJixmEq68JlY7x060Ns0rFP/v9R5JO
         racg==
X-Forwarded-Encrypted: i=1; AJvYcCUErMeCNoEM/+De/M2AvgJaL6JEfWE+Q9PQTk1zZ0UDAV5Cntbevb71zqg4GI/96nHEaptvZaG27ZZcJec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJH80IAb5opX2PovyVbReShtqUpNyq8Su4XJ8jKWl5l3wNUJPv
	2tZXwwEvzcf3G0450vV3za7RJjCjkthI3FxEfSUNudicDRpSCzUdIjdO
X-Gm-Gg: ASbGncs2wxK0+AqcekJpp5wJfznz5GtIYeIt33PRoL7Pt/5kA81A5112MOdoZOSGEyU
	FJaXQHIuYP0EhsemvsBFqjCzEFP5oA1CgQmftG5cnNz7nfu50EcNY1s/JchqwcHMPdNWggEposh
	ok7lb1C4Ai/nMfDoaSt886ftYZFdw3zFoSCi+xIZNvuiOxODombKAhXTNSbxTRsnot46Es2y64R
	YqEQiyjNG2/Q5JnSUXLtqtyfGtJDIIdxRAGjI8gzWTSnUZAF+arWASCZcC5fw6M+SiWPxuBEkK+
	ZwHU8NOeZL6Lmv+pCNIotyaB5wW2hUARJHUUWjBcW7EW3aDVDLixv8G06iZzMGNR+wDJjOJHB5h
	5Ku5O9Q7WlbAEtj5Zt68pNWwd2NvEPBXj585Gr6gpJcXDXUCaf+sJIlA3d1lNkd9rOjsvY11SF+
	aK/bHEBFvIMc1u
X-Google-Smtp-Source: AGHT+IG4iUvvmVrCgSP0YCk+HtT00u5Cv73qchYGx6AbmE0/ypVfmBzPMDibB16MqRFuCBEdGpYg6g==
X-Received: by 2002:a17:903:2348:b0:25d:37fc:32df with SMTP id d9443c01a7336-294deedb5c6mr33673225ad.47.1761740406560;
        Wed, 29 Oct 2025 05:20:06 -0700 (PDT)
Received: from [172.17.49.162] ([103.218.174.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm150801635ad.48.2025.10.29.05.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 05:20:06 -0700 (PDT)
Message-ID: <9208d2ef-79da-4e80-ac1f-e01fa5feae0a@gmail.com>
Date: Wed, 29 Oct 2025 17:50:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arm64: dts: qcom: talos-evk: Add support for
 dual-channel LVDS panel
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
 konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251028061636.724667-1-tessolveupstream@gmail.com>
 <20251028061636.724667-2-tessolveupstream@gmail.com>
 <d05fe82a-640f-4a09-9d83-39bb5aff179d@oss.qualcomm.com>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <d05fe82a-640f-4a09-9d83-39bb5aff179d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/10/25 14:55, Konrad Dybcio wrote:
> On 10/28/25 7:16 AM, Sudarshan Shetty wrote:
>> This patch introduces a new device tree for the QCS615 Talos
>> EVK platform with dual-channel LVDS display support.
>>
>> The new DTS file (`talos-evk-lvds.dts`) is based on the existing
>> `talos-evk.dts` and extends it to enable a dual-channel LVDS display
>> configuration using the TI SN65DSI84 DSI-to-LVDS bridge.
>>
>> where channel-A carries odd pixel and channel-B carries even pixel
>> on the QCS615 talos evk platform.
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>> ---
> 
> [...]
> 
>> +	backlight: backlight {
>> +		compatible = "gpio-backlight";
>> +		gpios = <&tlmm 115 GPIO_ACTIVE_HIGH>;
>> +		default-on;
>> +	};
>> +
>> +	lcd0_pwm_en {
> 
> Use hyphens instead of underscores in node names

Okay, will update in next patch.
> 
>> +		compatible = "pwm-gpio";
>> +		gpios = <&tlmm 59 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-0 = <&lcd0_bklt_pwm>;
> 
> I think your intention was to use pwm-backlight and wire this node
> up to that

Soc does not support the PWM interface hence we are using gpio 
as "pwm-gpio" by setting the duty cycle to 100%(i.e. "no pwm")
> 
> Konrad


