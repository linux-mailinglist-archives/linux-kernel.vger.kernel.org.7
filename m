Return-Path: <linux-kernel+bounces-753157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ACAB17F4F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F149D1751ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6927A2253EC;
	Fri,  1 Aug 2025 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nhIG7ViP"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A6E22578A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040649; cv=none; b=TNnHrvYuD/MNowUCUaYh+RPA5jpLgj82GE6JYhm1NacJ9VfpXxOew+Oe+YbLNhCewaVM+6ehR0JfcNupdcuWf6+0zGln0R8WGON5OZXjNnjMnhzX5pVH1XOXyg02uId0IdovrLQaQKEG8XPyZ6PDvoPwCeC4rTpKjKGSrmvdA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040649; c=relaxed/simple;
	bh=kfic+uLDROpAOeszY5apQpKFu2TLHnt0S6dZt2k5jSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vm7jT/0343d3nrO7Lls2s+hidpdGRJxNmbtol7biI6kOU3rG6LYg7+Icu1wdm+O7/1HsFutUn5blQ7PPM47pTnpybhv3XwUDdpTCpbYAuhbDPvbBIagHkuoIZqRBMGz3MnqFy+TI//kmqM/l8mWElmZDtucy5jZ0qgIcpamysQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nhIG7ViP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso7992905e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754040646; x=1754645446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W2mFNWcV7woJMSvTpn6utw5/t2ceVV02tn5+m4prOqA=;
        b=nhIG7ViPMMHYfYONAu7LZwUW3XykX8NysiT+JluHRC55gFZn761mn8ghazV74bxtyG
         IAHbZGbzpw6O5Dj3VtplsExdWAV3+ht+lqq2jskW3W5VUD7tkshWr6/33XZ2sXM+sL3m
         FcRYDVEWCnMvNH5R+0KddDn/Ob2NV9iVWEBYhBLfuk9/yPABQJ+naHcLYHVp26MzTlw6
         1k6B4G+qwGHxdRouuVrpvFJPlI8E8MKyDmxt/wv6QW40qstEJk+xlSprnhvpCnIzE7bj
         CLf3SdCk8ZmF17QBETSlpwFYqagr46ef3Rd/u8AXqi6RDy1coPgWinNVdFApRPtcbm8k
         eU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754040646; x=1754645446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2mFNWcV7woJMSvTpn6utw5/t2ceVV02tn5+m4prOqA=;
        b=obwwexBWOF9lDjaIolU0MSgpfKLGo3iy4FBoSha+/2CBzw2+YpCQZfDNKuzfpNynlx
         sRqWw+9bMV++RYN3ANFYK/FHjY2iLbaXbaLNSSZjdxgBpPGaDd3GrCQYVUZQbBaWIto1
         +G+5CjSRYBeGJcpZvtetO62IKRb2e9zzkhZrK6bXC3IlmWmgL/6R/xD0o5i0KbKznr5K
         37xqEnNe46/+JBAmlQJVdGyGXNSkE2v3x1RYhCqf6ku1XUVfRb5qNvJEpU4Su9WzKefL
         CB9EJhFtwS4tbh6KrrYblbkaGGbnAyTPE3bNXw/1DiDI5wlny4+jkoDwsn8G8apizkxH
         fdVw==
X-Forwarded-Encrypted: i=1; AJvYcCUFrrS1ZdkS1G/3X5kdoDDvJGGYWPnAG/eDB+8NK8IzFMWNcV9lGLMopVioN2HIgQxxguJanf/EwNYZnVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6gYW6NjHCY3tLWb/ZieOjHojhGuYifw17O+Pv3FIP0ojGmaf
	yb1jkqjZnoGu/vmxUXIaucTkZvRwkb5wBlMR3xXWcfK/Qme0j4lPfs1wb/2emOqgviY=
X-Gm-Gg: ASbGnctTj12IJgbsAxUxs24I4816TtFgUgrEwOc+snSJnN0WyfquXe4NodRIIiWlo2h
	APZ/uhFC8Bk8+T/afnucCjN9WJS838f4i8I8XU+9dp9/oro/4BdIFpbyuqJIeR8nQLa/crxY39v
	YkpwQcQAolNssgKWYorxyV8AMymGkWAI0ipk318l+ZIxLfx1hBzEKICZ9QMQhUUBkTP4p6G8oD1
	rER2nXQzeeDyyJ/tKGVvnGKwpWfnkIo/yw5wk8MqJhd+rpypRAcSYsdbqG+aE7JFGNrUArI0SD4
	mtGzs5V+26wYeacJY2Sd8MaC/mVFq5tJAuCUmjesiiUfpF/swFCzSgnSbrXNolMDfPgowwUMQxG
	LnvYikWr4mfwGJy66sRjsy5jkUS5aIVT1Mu4Q2k94p6NOiFoxN3m5OMgD9dstwA==
X-Google-Smtp-Source: AGHT+IHCYZQ7LJ7cYHoVpSEsRcjkIRr0e2up/j89C6HrCxyO6Tidr6iZZH2RM3WjZrbfp3fSA5veNQ==
X-Received: by 2002:a05:600c:c177:b0:456:cdf:1ecd with SMTP id 5b1f17b1804b1-45892bde5abmr104195385e9.31.1754040646427;
        Fri, 01 Aug 2025 02:30:46 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458953f887asm98477105e9.29.2025.08.01.02.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 02:30:45 -0700 (PDT)
Message-ID: <8bd9a924-3fc3-4f4a-8096-458e771f94a4@linaro.org>
Date: Fri, 1 Aug 2025 11:30:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: thermal: tsens: Add QCS615 compatible
To: Gaurav Kohli <quic_gkohli@quicinc.com>, amitk@kernel.org,
 rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 robh@kernel.org, krzk+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_manafm@quicinc.com
References: <20250624064945.764245-1-quic_gkohli@quicinc.com>
 <20250624064945.764245-2-quic_gkohli@quicinc.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250624064945.764245-2-quic_gkohli@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/06/2025 08:49, Gaurav Kohli wrote:
> Add compatibility string for the thermal sensors on QCS615 platform.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Gaurav Kohli <quic_gkohli@quicinc.com>
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 0e653bbe9884..c8cc67b65f73 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -53,6 +53,7 @@ properties:
>                 - qcom,msm8996-tsens
>                 - qcom,msm8998-tsens
>                 - qcom,qcm2290-tsens
> +              - qcom,qcs615-tsens
>                 - qcom,sa8255p-tsens
>                 - qcom,sa8775p-tsens
>                 - qcom,sar2130p-tsens

Applied patch 1/2

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

