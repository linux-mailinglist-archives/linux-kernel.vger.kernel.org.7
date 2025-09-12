Return-Path: <linux-kernel+bounces-813701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDB1B549CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD6DB63178
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F63E2E11B7;
	Fri, 12 Sep 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGV6b3uS"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D02E0B5A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672669; cv=none; b=YsW1lkKQynZ1+o6jcl1f7iFAb9uKFc6Yoz+gcqCEd8iV1TaUJw/fxjFMDcytg62TQg5ivjVZnKsOoCFiE3kvc7mkI1WT5VOXqz90mOdGizWDLvJYAu/cyGcPB2p3sNfBoSnZRcRQ/jsxCEso2i6+9LGplrTuG4TSA8QXT+mz6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672669; c=relaxed/simple;
	bh=Cm8AGHoNs36CjaW+QUDCUcm8hiYODo7Px0m6IAy/mIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mz8smu18EUOp5iabnXGYWxUhYpA49OIOCRtZFoEcPA944ZC6W0hL6QZ0YRFI7GXMymZhaOzKZ13uq7LK+ojTKAT/jUgle9wrJGGNFZ3Lme/eleb9eNsPZe7CLA1QUYgIj5DPyqIsMLoiLUz4wyIUIigdXEeBd5M7csHW5umP+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uGV6b3uS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45cb659e858so12588365e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757672665; x=1758277465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbUxpX3q5xMx08x814zZfnZ8avY034qyNif3tjChLWI=;
        b=uGV6b3uSYjVsnktHEu/Z+m5lnDCML4npfK9sFg2e68L7YmU56GAu9eQnKC1PKiYMQR
         tulHSZQBp225hwnkwepIiICXs2l5wgiFXLnB6hJ5exTERtYvMPWtLgnLLSjcFcWyEtgX
         7N1NC2bSP7sqgnLy42157Y6TBDiFb9f8x3tAE2tVHoEVFXyVBnxEQD0NxLrqbUg3zbfs
         jwYn3mq6TqVhoUJVijxyPWHSxlKtXKZMIjwucCa2XcIryn8hDuEq9JcDLvorWN9NtS6a
         yuCHX8ZZYMq1iK4SY01Z2OY+T7cWCeEMYM9kZRwllqSDWAHAdBcF5AYbydh1D1HcgIl5
         1pkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672665; x=1758277465;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbUxpX3q5xMx08x814zZfnZ8avY034qyNif3tjChLWI=;
        b=kYczPir9uNBDdFLK8t5d7PXB4STNJtWdJKN3LzEoq3THZzMZ9DxO0GMUuHbINDtHY/
         YXy9x1xoSEe9s7afP+iRJCMdKID/0AElaGVi/ChdIy6v2d1xtQ+QiVFOUDMrbbmYs09M
         ZRKB5pFLTAAGXb//TUbYRKr2CqSKHh1m1Fr0Uvo5KPyZFPrNLbkGOvWzhGxXkF/aOYa4
         sLgCM4n7/yi4G3wA5HYBngBZHR2fYNp7KtQdrGO2eGMNlJyo3gKQ49ZPDpK5GtZFhiQw
         iIoQqejQDjuZJSjO2XyIMN009tfjnuW/YVMzcm0TJys9WO0eJNZes5uMEORljDCGehEW
         4F7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTuT9GtRJpb6A/Norwx/Kuz/GfXGE/xx0zSr3+EYRPqih+LNBDuljNZ7eI3pjz1avgKnX094oeMPoZjWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTSLK4Lt+MCiFWZZ+0JNtVHwsVBp4imbn2oyQfccl4aVYp0JPm
	HP9NN9hwXgrkd7f4IK2lpcq3k1xSRR8XZxmdC/EmE9CrFxUYildbxdw8GBP4s2KWsxM=
X-Gm-Gg: ASbGncsJJV3eOJGSNWtJ1SeIPkXyqXZBUnMFgR/uG10yjpdBW1XizKI1DdPHMb/AThl
	L41u0jvxJ12dlW/Ca6caIc0E0BJ/wr9DQYHWti6rZAf3Ryx9dj2OSUKt8XRrwCaQoLGxe+YUiwQ
	K/DdseEiNVBN9BjvWOQj+KfLFlI3QgJ86+2gwarqc/jjDBqjaozuAivTl7eMQidtv5UOMEqx+tf
	8G9ju7pKzqduYL1Y15kkX8c1fqALcgAwWZlcMJcM7VNqvfBkJ9ykAmGsVhCJfRDe6qrAcjieAGa
	LvcQsqBlzaelCumUrakEEa+32DJmukR02foxQbLiyfWWpVsxqOSQy7ldk0F8wl0f8ud/BcI/xay
	fMxTEd5FtJzeL3Hllr4q8rCI84h7mrj2zr9aBWZ6yUi1QfVo2w/jwQkjjUsEOPFaQBaL6YoHPbw
	9uNJB26YAUFamIIpN20OkE3WozNAmD3A==
X-Google-Smtp-Source: AGHT+IEj7jfi5/gecFugEbT7EKtx3fH+ixZKBaAEuJdWl25+AesrKJ8jqjGjd6JOh+4mHUsSSjYdYg==
X-Received: by 2002:a05:600c:19c9:b0:45d:d291:5dc1 with SMTP id 5b1f17b1804b1-45f211da6aamr23950765e9.15.1757672665252;
        Fri, 12 Sep 2025 03:24:25 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e1232sm6059022f8f.56.2025.09.12.03.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 03:24:24 -0700 (PDT)
Message-ID: <980b7247-e8a5-40bd-ba20-c9c72c8a397a@linaro.org>
Date: Fri, 12 Sep 2025 11:24:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: dts: qcom: x1e80100: Add IRIS video codec
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <rPv92n3EVkoRrO1v7nlw_tPMn-nHUhpYhQP_FjmQsESL752mly20FWQqPHLs8JHGC4mklm9wfPABc5kd-x4LYg==@protonmail.internalid>
 <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/09/2025 19:38, Stephan Gerhold wrote:
> Add the necessary definitions to enable the IRIS video codec for
> accelerated video decoding on the X1E CRD and Lenovo ThinkPad T14s. The
> additions are largely copied as-is from sm8550.dtsi with some minor changes
> necessary for X1E.
> 
> The PAS interface used to boot the IRIS firmware is not functional in EL2.
> The code to start it without using PAS exists already in the Venus driver,
> but was not ported over to IRIS yet. Discussions how to model the
> video-firmware IOMMU are still ongoing, so disable IRIS in x1-el2.dtso for
> now to avoid regressions when running in EL2.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
> Stephan Gerhold (4):
>        arm64: dts: qcom: x1e80100: Add IRIS video codec
>        arm64: dts: qcom: x1-el2: Disable IRIS for now
>        arm64: dts: qcom: x1e80100-crd: Enable IRIS video codec
>        arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Enable IRIS
> 
>   arch/arm64/boot/dts/qcom/x1-el2.dtso               |  5 ++
>   .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    |  5 ++
>   arch/arm64/boot/dts/qcom/x1e80100-crd.dts          |  4 +
>   arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 87 ++++++++++++++++++++++
>   4 files changed, 101 insertions(+)
> ---
> base-commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
> change-id: 20250909-x1e-iris-dt-eb0494a130ca
> 
> Best regards,
> --
> Stephan Gerhold <stephan.gerhold@linaro.org>
> 
> 

Could you please include the Dell Thena variants in v2 ?

---
bod

