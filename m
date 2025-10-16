Return-Path: <linux-kernel+bounces-856276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415DDBE3B89
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC26542BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA53339B36;
	Thu, 16 Oct 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lznjt33l"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD618A6C4
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621519; cv=none; b=r3kUluygOv17CvFmjSgvGLIeqW9N5te7ISRipept+OCqV9rdIkCuFqCiJ+vydBPxtyrZFPdaR7qtYD3RbJ6FaJjU+rKshQmEEhWMHwLWgXOHc20KS45S/+CFv5l3VtSx4KWbt+9l8xb2kgwM/aEsUXowmKh4jCK1F0FuEcQEuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621519; c=relaxed/simple;
	bh=RFh/gqvFYe3mrthIbrCFXM9FsiCYqUCmiQDRUcSGYj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KAOpRJkl5+xCAuVrO3FvoMFFnwq7MKzyMMrSRUcPuP3Cs2jP+oqIMlLr4jLGgV/vVrpyZrxuCi+1ettXpcFna2BI+71Pyw9+sFqEkBWVoiV87OLFXUkrhVAu+ACCEKsne9f0EZFd80GiYBJuo0UUKUqu2eSYJp3qSW6Fic2jZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lznjt33l; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-58d8c50080cso86147e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760621516; x=1761226316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVVxXst564TPeNRQIV0Zrdb17qt+RXom9Ra+osC/9Kg=;
        b=Lznjt33lDzi8vg9xW3aQmvZ5FOGRz0ZA0fkxtRfF6xXDtriiqL6widdjmiFIH85+lz
         +2VSOO2vt50e2hhDmYGvaJmqElcspSdumVCf9uN/kUgK3tqXDxTnR4Hf1CUyXq9ucngB
         RXhu4oDSaZE2CQ0Ynxk5KdcNX32LI5CWRCr/iXD07xi55j9/ntVZuy0OSYTJwnSq8FV7
         KwsEOTcWmyMVv216hXzxKhamoR8210lKSnECqmDCNGNB0mWhvVG3n7ICrxOyGu1h0ryC
         Y8tP1ckgthMv0ZIzSiz7XCgDTj+rsVMjg0HnNdbgJ0dPROIpFKXA1r7uitDJt2hIXDmc
         Wlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760621516; x=1761226316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVVxXst564TPeNRQIV0Zrdb17qt+RXom9Ra+osC/9Kg=;
        b=vZbCxBMfJjjZLdMWX2hXA0yNrLTK2ZH4CcyAsZKraKzO/zD889Db45uGM4VbfNIk5h
         JSaEorE3Q7jWXoDPOUC/QCL62mSXPhRY5qllnnhj4fZPlzIFwqC2sMGbJhb/PEIZaHRE
         E+EuJj6J5eMGvXhPPkcg6FIZ4xhCnufKCo8V+d7IxcSx4YO6eqfAnuI13LBb/U6+vO5a
         oPtKxfYZ8VeWRT/UCkiCCz2aQmpG4REUD+HmIB8R4vvxJhb+sffO6NCnmbbdoNwjufPp
         DSc7ZSKlEVLOE+ycn5G9H612a94ujsldyqw2cgtE7wi+4QXedLNOFB4gYdXrEca8jwLU
         l/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvU4UOubZTtkV/dk0Zce1Bgd7FSwKfRnG2UaM764q3OEIJsGQaDZypLHIYtSU54b7H1+B5aQD4HXAJjOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKD7e0L5Bv0h4cZyV6UbwHbANjenOdJHhPnoeVrbm0Dg38MaD2
	smFUzuKRPT0CMx0ZIogHAN/mvPmo5vc/aXHwHkmge3UVQ7RyzuR8RShLFblMAHqJ5NBEu2RQF5D
	S7lJ5
X-Gm-Gg: ASbGncsCAsL3fSCeWBl7vQJ0kzpialR3PuFECWfjrkTBbHmbgzSF64i3fCd0VKn3lud
	cAtEyXYfvg3T+x9ZFtPxma7VsBeSPI60VeABmHJI7wiXSgUNMlpp+1QDHarlnuf9IbOnmMrDbTc
	2E/V20C+v6zU8T17F+LHCv8yfL6TUkBbRT2a5F7pDR1hnw89VHQQiNAaD+GM3sHlEd/7TskZVng
	OLPzx4X4NDS+o4OBiXtl0+iiCSVzj+d7aLZN4c//p+NbEm+u0osJFsKz/dq6F6tNxPGdXeylL1h
	k8h4PsneKVi2duVzV2aAAO6cSDjCjQ6HJFfiIs1M91F2pwoJ5oAv5up/A4nEV4HbwgwszQkrA6s
	G5JWfkhs8t1u2M3GOwoWzAZogyxpdLJtqTJ8AsNw1xyeTAQXfFbnI2U+CMPV8TXxFJhpwfngPnO
	ivcxN4NkcPefCAsc/HLIXIeCCnudTPrIr/Xi4M55Tf/LsME6jCb4LrBh5SSaach92kAc+xbg==
X-Google-Smtp-Source: AGHT+IE1afceVs8PBuaZj9exPtYlK0QfXyVjdYDJJxq6s9C8bQx673U2F0e4V3yJkwmn8me+a4KtbA==
X-Received: by 2002:a05:6512:2393:b0:55f:5965:e4e5 with SMTP id 2adb3069b0e04-591d85703bemr10189e87.6.1760621515969;
        Thu, 16 Oct 2025 06:31:55 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f91c0sm7100030e87.41.2025.10.16.06.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 06:31:55 -0700 (PDT)
Message-ID: <fb491c3a-6786-4daa-b3ee-53756b3d9b44@linaro.org>
Date: Thu, 16 Oct 2025 16:31:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] media: dt-bindings: Add qcom,sm6150-camss
Content-Language: ru-RU
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251016-sm6150-camss-v1-0-e7f64ac32370@oss.qualcomm.com>
 <20251016-sm6150-camss-v1-1-e7f64ac32370@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20251016-sm6150-camss-v1-1-e7f64ac32370@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/25 13:22, Wenmeng Liu wrote:
> Add bindings for qcom,sm6150-camss in order to support the camera
> subsystem found in Qualcomm Talos EVK board.
> 
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>

Looks good, please add my RB to the next version.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir

