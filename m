Return-Path: <linux-kernel+bounces-731633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6378FB0577B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB861C22146
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C3F274B41;
	Tue, 15 Jul 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fmSNQqW9"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE62E226D10
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574046; cv=none; b=ifr9ez+bLgQrlSi1MQT8lufBAH98/JgncWq+VaNCMIRwNwgqc/qdnCYtIArOZdX8IkPqzs15BObMPSz66S0ohG40qYgOPrAQrRxbk+sPZb5ZfeVVCZGeUNH0j9bXOmS7z76uR1aIt10e8uLwjj0d5fIweqRkRFyQQONkWmxpkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574046; c=relaxed/simple;
	bh=pmPuCTA9fVFmN/p93tytYkq21QsJABQLVSLv5iDrJTw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VSRq9AGXT6KZAphLeeJ9pn+NZw/t43eynTuOrWzELv6P8wK/bFtf+bQ6BtulcfSBQK+VEIAlgjdMOosvmpntCqhQpN0X7XSy18JHJ9lo/AB5z9+ehoKEcCoWF1tavc8mwHWdKxr7u6QHwwxIw7HGn7N83wHKjSVcLsTT4u42ijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fmSNQqW9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-456077f0e6eso1402315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752574043; x=1753178843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JCtkP+NXfcKNSawUwyCjFILTjiTFxq5oHCDPWfXdrKE=;
        b=fmSNQqW9MlQM7HLprsjmORvnVrnLtalD62L1wMDi8wsoxq4Xo7QbOrqMM+NfrYonOe
         aNykvdO/tGI/1RwyKpAu8oQHeMiBmLBcMEzn5RXdXhOAGjI/mhX7Ra1FOhFxiQpHN8s9
         le3OLxeZfbhH6nFtXayV3RWADarY0SfcjL522Kan4t98PFscRaPFYRA2dw1UEYKF69xz
         Vpw1fzjrufuAK81GNUr6XKUomA/enCp3h+ZZi3unPfXkS6F+6OPbcP0OqIUVjt36GEyD
         pTIhq200pybtM6RIeiW2IagTI2DPjBnD7JAec7/GmWqt4sDtvWc7m7aOZepf7EOHgSKJ
         ea4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752574043; x=1753178843;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCtkP+NXfcKNSawUwyCjFILTjiTFxq5oHCDPWfXdrKE=;
        b=Ot20GRUTChko1RV3koPqMQUjbPQi02xcCX6vf1CG30jyZXh2E09CKCuU5l/soAT9tA
         a5UjhPamN2FV3aN2r+6uzqaD9Eod/kVtvxQdh2fRuSOVo+xQ+0g6C90Hlh8fZysF/OF8
         HorsTptNpEV2ZETufrxf/kt5Q/0Jm1TpvS/iNwqvCCD9X5tARVIrOgUe2+WzhIjd/eZr
         IZenXAtcCoda9ECMJlIRGO4aUjpv1Cw/C0eZdaJ74mFsxl+9rWG6dEYRzYoFA/G3ekWj
         pNLsWJ4XG4w0BiXoZ32gPtvB5InYEyqscRrFylSxkQGhwpNOHVpDuxx4r7jR1xYrIVni
         QOhw==
X-Forwarded-Encrypted: i=1; AJvYcCU6BCtBDQNO28+9W0A0Jm2vl1m5Eaut4sDxxSL9BMowEINP+nM4M6YcZkOP16BQRGonwMmDwZfoCM5Lr74=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUDCXuA68n+t9yhYiLFVnET/tF7gqgS3TBEaAHf9JnNy01t//E
	3uOi+w7mCzu4ITnJp3loG3fl4I8n6lnEIII4iaWq/D4and20wJic7GoDuC+mE9dvnTY=
X-Gm-Gg: ASbGncv6KHJRmpPTbV1uOvu+tvdKLJk5TcT8cSSok81hJYjNFn61/SXZvEXeiIsagEQ
	9WWIctGoEnnE8lmmTp0cvwXxC/Zt+bVf6uUghj3VNQ/AVwGg4ordEddNBCLNiu5OGwe3zk3/zt4
	cSTrMbBXh3HQV+eEEqIAugqABElhFBEB3GtF507MbqnDWadyMo6w0vruLqv65bnMpWqgdGPXRas
	EDpeNbNGQH7uutEro3XAEuKpmOK21bXg39Mm9Nab6ebTRvnsxhZr9Ims+PDkCZiNGN/EvBvEoBF
	NH4KE+Rms33KImhvjKWVTrbw5pU7HiacF9wCR9d0nRBlK/JnqHx4Lh8cHVv7AIWPDp5IgtXb53e
	0no+uSQHtR61sex5GtOrd+6SH2ADMA+rWr6ehNR+0Qw==
X-Google-Smtp-Source: AGHT+IEBK7rL82+z+EqTMAv+P8qH3uhUe5ILnSQYCt183pJkP24KWEVUloTLtKnkZtVFrRhcu3Rp5A==
X-Received: by 2002:a05:600c:3512:b0:453:c39:d0b1 with SMTP id 5b1f17b1804b1-45629123a98mr4641245e9.2.1752574043065;
        Tue, 15 Jul 2025 03:07:23 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456172f3ec6sm68071085e9.22.2025.07.15.03.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 03:07:22 -0700 (PDT)
Message-ID: <15b8b9e0-a211-4102-9b68-994c8ab50a7a@linaro.org>
Date: Tue, 15 Jul 2025 12:07:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250714-b4-sm8750-iris-dts-v1-0-93629b246d2e@linaro.org>
 <20250714-b4-sm8750-iris-dts-v1-1-93629b246d2e@linaro.org>
 <5dd36649-821c-450e-bdcc-871735d10059@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <5dd36649-821c-450e-bdcc-871735d10059@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2025 11:32, Krzysztof Kozlowski wrote:
> On 14/07/2025 15:55, Krzysztof Kozlowski wrote:
>> +
>> +		videocc: clock-controller@aaf0000 {
>> +			compatible = "qcom,sm8750-videocc";
>> +			reg = <0x0 0x0aaf0000 0x0 0x10000>;
>> +			clocks = <&bi_tcxo_div2>,
>> +				 <&gcc GCC_VIDEO_AHB_CLK>;
>> +			power-domains = <&rpmhpd RPMHPD_MMCX>;
> 
> This is incomplete, need second power domain and I did not check against
> qcom,sm8750-videocc schema before sending. I will send a v2 a bit later
> (maybe some reviews pop up).

Heh, no. The DTS here is correct. The videocc bindings are not correct
(and that's not my patch).

Best regards,
Krzysztof

