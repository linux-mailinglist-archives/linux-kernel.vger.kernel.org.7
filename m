Return-Path: <linux-kernel+bounces-813568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72638B547A3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3A21CC1BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA19F28D82F;
	Fri, 12 Sep 2025 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m7dEpU53"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959B28C869
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669255; cv=none; b=Wd+2OydcNXmKJ2SmZUhr3TZ+5LOL6DvbZ/tsOCp7Dp+ljj9YLD1pJpwXJTQH7eHCNwd5+NFo1OnpkT0lSP2vTi1Wz0QLNxp2INT7mwakEkEzbCKFzL1vEe4bq+ZhPeVVvLjPQrbyaEWXvMh4FuvKFwH9b3bIj9+tPjRtLqAfkPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669255; c=relaxed/simple;
	bh=gfb3JWg2h2wLQhK4UM6/FHhhzCI5uALXsimWBNV6NQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UT7lx/7TEi+GBaXLPwYl9xTGpLrC9JDWoKa8EmHRtkmKqd45D7srAn122mMsP095RR9mXEw85F0lz3L5XBNpqS5U0qlLw9K+njM5ZL22pFzeveaJhMTj0Aaq2M7rVfuRxvnrDGW/rAM6ogKx0eYqSRImYuizLRkI9gedd02Vujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m7dEpU53; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e77e917eefso278745f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757669252; x=1758274052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kXTEITSzQJNG4FjEV+hS6a+GXTf9khmRm1tSXLrtGVY=;
        b=m7dEpU539YkuMk+HjGAlAb2g9NHmyecjpnoR1tGRljWMsSvfcURCKp6bS6eEvh16jf
         IEo0JpqDwLhKNlY1KrZO2yyu/3GbPKKrwioFjogbcnrgWa32jbswKy2llxEnaHpbLsXC
         3ctMFzst0L+btHshvkQ19p0L9aRU5F46X/MaTZ39AmRHl8Ow8p5edj/XFNCqzql5yOUY
         4OS6xCfAeg53yoil07rl5yk15vdoX/c1kO7Ri8JCmzfb0S+ZUeDcYZ5OiJlx1nggZEx0
         EhLaj4yNq3xO2YRrws2isUwKxUXw0Hu06BiejtC5OHp0uknlggiCZkywg0hNb0/CUPkF
         0AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669252; x=1758274052;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXTEITSzQJNG4FjEV+hS6a+GXTf9khmRm1tSXLrtGVY=;
        b=UbR0P7kyXsM7Rq66RES2jQ5vBDhvaZff34gI4wLlwY7dYcvPPcEUltCoctWfk08Nad
         wTYcRpExtSJkBoa0VtPj1vgkUA+jsfY+uESe2oPrj7oLT9VnCONcfovwvgpVU2gfQPdr
         KE3CaGYhLLoWkbaEZEVnStuSGZsyr2oqqvlDXuTGhWTG0YDIHg7Uj3paQEUfwTPY8d7m
         zvivG+c+QTyUrcQ0euIqX5H9TKtA0BzNLUzDNNmuUxDe6Dh2LzKLtn/JnIU4DA/gksuP
         OsLgarPGI9nWcwC72TC+cSLOFW6UySrX0kELNBOHTfYebjWes/usZ9Jim5hVgm1Ojzbe
         Pvjw==
X-Forwarded-Encrypted: i=1; AJvYcCXuWyX1VN71RjMgP9JmVTChO01yzes+hjMu7UyEuAvCF9/oEZpuD8cXvVa7luQiI8Uc/UTn7qmAg+8xv5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhVSkAZmJOKDe6Lznh++VQUZ4vBDO2dmrUMqH2ZYg4S0vwwz92
	JOr96khdmfzNj6Mwdd2Sm0CZ8tn+g8bib79iQQITYgc6yBlHksWdJE53O8ZcpOIrjEs=
X-Gm-Gg: ASbGncvkcvDdmVaLlZTwBiOOXYUqpC9MqmP6Gc+wWBVRt3GzpwLkk8LGoqMLF4QT5bM
	pBKyt78wuahTxYTGuYbM4FoRJKUjSIjQN5PIUi1PDwGpnszaDGni/MghUDnvszIUJ96rFo8p0nH
	j2H+CG3O6U2k1Jee3C9DrVGl3S7MWuq8yoBM/h43gbDJO9TWmOuhXI7W/wHZiUBTld2VzrWCpxw
	F/eBp1JM22aB4LxwmUzLtlhEBPDu8AYDoBXnKnkQFGbxFBCP1TLm6rVL5U0epc4uEQRSKa1zmiD
	ckR3U/t3ZvnWgI7b2DPPzyEMz3DVwK0IFvkSEfE4VRflGzzIYkhwSKPo/ca2nK7w6BNF7iY65fR
	PmyNP812IrrIKx9px8cCqW1fyt85e2gUyT+IRKC+8vjjHeS2dH7E/CTC3sIbU2WGgiA00RLXXeC
	Qo8i/UTREJ3OFnox0fUYwCj5qS6XgFQg==
X-Google-Smtp-Source: AGHT+IHRwP5h9u64faaN9sgkAgvq6Wk5wiLsJZGVMHzOBMSe2Z0sqeUItiFW4+Kj3CxqqJN1+tBQMQ==
X-Received: by 2002:a05:6000:1846:b0:3da:37de:a3c2 with SMTP id ffacd0b85a97d-3e765796575mr2314314f8f.24.1757669251882;
        Fri, 12 Sep 2025 02:27:31 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775868sm5886336f8f.1.2025.09.12.02.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:27:31 -0700 (PDT)
Message-ID: <2a96dfd9-a5d3-479a-a60d-698e0c235d2a@linaro.org>
Date: Fri, 12 Sep 2025 10:27:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: lemans-evk-camera: Add DT
 overlay
To: Wenmeng Liu <quic_wenmliu@qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, vladimir.zapolskiy@linaro.org,
 todor.too@gmail.com, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250911-camss_rb8-v5-0-c078e4e22d91@oss.qualcomm.com>
 <20250911-camss_rb8-v5-3-c078e4e22d91@oss.qualcomm.com>
 <ex5oojf6lqti45joyjxpyi2ev4mjcitw4lz6cszu6lustrby4j@zzigwnu4pbxo>
 <39cb76ef-3f51-438d-b740-827a4c70035a@qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <39cb76ef-3f51-438d-b740-827a4c70035a@qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/09/2025 03:23, Wenmeng Liu wrote:
> 
> Would lemans-evk-camera-csi1-imx577.dtso be a more appropriate name?
> It more precisely describes the content of the dtso.

I think that's a good idea.

For example if you added another sensor to the mezzanine board on csi4 
an ov9282 say

lemans-evk-camera-csi4-ov9282.dtso

The only problem with that is you can only enable the camera in one dtso

But that feels like a problem to be solved only when someone upstreams 
more than one sensor for this mezzanine.

---
bod


