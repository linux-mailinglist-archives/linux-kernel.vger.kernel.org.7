Return-Path: <linux-kernel+bounces-855110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C94BE0419
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B653AB2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0303B3016EB;
	Wed, 15 Oct 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zQGngk2D"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4A42FF667
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554246; cv=none; b=ftse0XjA09gZSF1n4MTJx8TQNoHL4hHNX6S/nIWnV4JGH/Ky9KWRBvsgU4dGoncfiReF/h95V5lDIuoK328LBc7iZ+NbaeeTF0/VDCBH/e4cOsMJD1QpY5I9YGQwWGhjLgMyvR19PlmsGOUS+k5lOtO7KcN8urgEiPA1R6tEsY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554246; c=relaxed/simple;
	bh=swdv/wTY0LTvBv/YcthMcjAr/gt2RxtK+9y/lOz8BJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAEDh9cCAs5yX9wa/7hSbqHUc5U3Hj7GCazriQL0dKJlICw3CaVduMsuz0+sntzkqX6B+Fj2/AmrjWne222a/0kLLaQbnNyAwhAEGTODc1ehsUvo2K/3CvSvFbGRQ9jJktWCmbAVueVwugRKovXJxRvjXSCDuP438sOt2HwyJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zQGngk2D; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-591b99cb0c4so475730e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760554243; x=1761159043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hukg1h3ozHOZYYKzu8a9q8XV+g6fS+oS92fdsP1ACq0=;
        b=zQGngk2DmzXh1R9zj8rYdKMA9zBpfYEb4NiHomF4okkjw2x3VAZwzsoyIKHCaIZMwQ
         UiqLBK/j5yeu28iAbi6dZMZ4FkaaFxNtMSj/+NmEM5+Alt3o75U91N/KaA6IYIJVFeI4
         1ihD1sRVH5x4oUcGyVPGHh4OuxFnNk6v7Tn+aw/uBuHCOSqDmtZoQse3wYAIEwlzWbDe
         2RgrvExnBd3CeejXUbzGWlAxKhiTJxMP75h9nLekzpMKKZZ7pgL/DVZMSNe/men5Mncv
         qoS0P4mcHe6sVvLcmdG5QRTqtUMclmF4Ire4AcSHf0NieCUdS3AM4bALOKbzG7Uiw1bQ
         tRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760554243; x=1761159043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hukg1h3ozHOZYYKzu8a9q8XV+g6fS+oS92fdsP1ACq0=;
        b=El+VD4uU8fmaP7VcbhTWXUxM8DU9nD1nysnYBQ+74vwazfLgPU4t6zx9CeV7ruhrOM
         HpaZSx2WoHbociOjd/yGzfFdkfBsajX79vN97DD1Zy7TS0RXN6j8i4jo/8EtQhQF3sIc
         nvsLu6zcUFcvtI07Scj6//svRYyQ7pEYeSU60L1DXofLaSyvorKFfc4+Or/T9z3NzEmO
         8RQGjEXqpmJ4khCOJUguThVzf1YeBn5Y9FWb+V7+OdjdslneQn91frXF0Kj2MbUj5nfT
         JA7z4MYGevyCRRf5NvgASvpclCrJmLArSrMrqEcD1YiXmjsF8XxtnVqGalX+X8nNxovx
         GCrA==
X-Forwarded-Encrypted: i=1; AJvYcCWVovYzDhnMS1LLQb55Bvn97GmJaRvKMmCc98WnzbpfmoHA+utiK29hze2D5Cn4smuzP/jgDgghlj0Tzh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeAKbeh60KZYM+coNM64Gk59YYlJ1tNsNsr8dOBnENsaOuCFIP
	mO3bPogGgjGTbgu08El90DjjtVLCZvY4EjtqVP9hBELa0G6d24+K9RGVNY/kFO9jox8=
X-Gm-Gg: ASbGncvhAjPWGCvHX3Fn38rrc2CS6+Y6AI05v2qFPTsuRnCvkHMRWX0bI0ya4+ZiiZ8
	0XfB47dP9IPjlvTNrnz4FW91LmoZLQy5vQF2FpswV8D4PdY1oYv10YyzrcyBVj080ANHIsCBicM
	oywp/vAczU2CQgmfnlWDxO3mzrjcbhaFcprYxVQanQsmca/OvZcZP6ACfB4RcIkuPiDoH+Zw7VC
	Vd/+rxBTiy8km0dLQnz7teD32vVFiKpr06EjawVxvOD/A4NWskw4tD3Bhp5ay5Qml94m72bVu5q
	DrBwYpe/I0kQ154OnmdiZ955nAT/5BfEBq/h0Dzt32Lm9w+b2X3w4wvHRLHO5djoHu/6vqlhhzJ
	elky0Yu5cGTS/p6LcXWq60bUfN3rFDTbwlFGGZ/Gr8tc/IfNUi65M0rF+Dmr5gh+iIRB1uh3LZD
	Rr1lUgQ5wVitFPwYcdkat73xdM9mEsmU1/rZs=
X-Google-Smtp-Source: AGHT+IG+0JkONJK7diPS9LC4IMA7PvSE07P+bqP1KzE0xk93DSkWmTXn5VqwKTon3a4GXj+CVo91gA==
X-Received: by 2002:a05:6512:3b14:b0:581:9295:1b10 with SMTP id 2adb3069b0e04-591c9017360mr816502e87.5.1760554242641;
        Wed, 15 Oct 2025 11:50:42 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4e09sm6425776e87.23.2025.10.15.11.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 11:50:42 -0700 (PDT)
Message-ID: <365d2e55-8ed8-432a-964c-b57601fd2385@linaro.org>
Date: Wed, 15 Oct 2025 21:50:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: i2c: qcom-cci: Document qcs8300
 compatible
To: Vikram Sharma <quic_vikramsa@quicinc.com>, bryan.odonoghue@linaro.org,
 mchehab@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
 hverkuil-cisco@xs4all.nl, cros-qcom-dts-watchers@chromium.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, quic_svankada@quicinc.com,
 quic_nihalkum@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251015131303.2797800-1-quic_vikramsa@quicinc.com>
 <20251015131303.2797800-2-quic_vikramsa@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20251015131303.2797800-2-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 16:13, Vikram Sharma wrote:
> From: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> 
> The three instances of CCI found on the QCS8300 are functionally the same
> as on a number of existing Qualcomm SoCs.
> 
> Introduce a new SoC-specific compatible string "qcom,qcs8300-cci" with a
> common fallback.
> 
> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir

