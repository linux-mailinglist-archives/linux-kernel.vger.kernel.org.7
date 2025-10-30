Return-Path: <linux-kernel+bounces-877643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A13BC1EA66
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CD019C1C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B58233290E;
	Thu, 30 Oct 2025 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kge+qA/p"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344252F5A31
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807550; cv=none; b=M7It7ek8byou8cl+mbIXvhZPmyRVM6FQuQyWR9kL/KVQH/aUIbeOkWS9baCoOCsrRdmuzjPAE8VHiAImDYJclFBQgzxV64ldZl1BEU1YyH+hxewwbnQ+7dzT3RFI9Uwd2mLM7mhaFhJNvMlvk0ysUrIXUzxCEnU6tF/h8ovHlLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807550; c=relaxed/simple;
	bh=+BXNpvMSYXQ5gkRV1Igb+qGK/PD3CybD10G8Lpfk3ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATybQMTfJ9RdcwlY5oBpIiW5zz9iET6QDONOK10pKvz/WSsMkWibAaiu5FnwOOq+vCbYHsansC4If6tLZw58orxWCO5eeaH9MNAhe8rv1ED2azm0JgITpAX6zOd8C6DOiYtryaWg79d81ZDy/i9ukYgyyFE2DXfXoH5G+8/6Mog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kge+qA/p; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b6cea7c527bso535934a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761807548; x=1762412348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2On5/uZ00EsAWd87Xl9UGDQOXgXaq8KavS45zELduk=;
        b=Kge+qA/pOMCaxqH7lK3oJGhfvVmRIb/otUk36KQpWVzdRX/tK1sOEZozNe+9CPOs6+
         QgJNuuikkYWVUVX2weUTlA3+MXmFhnlwhi2TFiDLlm0p4jFOaYxiB8ubc4ImS/Lm2HtL
         9mEu5hM/GvdRcqNAEyaGOk/gsHe9XDGVRMlrQX0xKTh0eJ1nbzJ9ylUI2sGMxmeuoF+N
         otLrY7tu9aFT/YFc/3mjCV7oWayhgfuFHatG+kjXP4ZiHTs9Z22rF03TJteFMoNBhRPa
         FK6hXTjxjfBX5rcK5FMar7Vwh4XgIlzVZLBgh5dxFJzrvHzjYcAmPnJSD9aEWo9kCqOw
         4ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761807548; x=1762412348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2On5/uZ00EsAWd87Xl9UGDQOXgXaq8KavS45zELduk=;
        b=lZCmRgKaDowYLXLhvQ9hQF4v6tXLolMScafpgXp41Dl3TIikKoQiRTEWXFrMcK9++f
         X1ztANYNSe7NdKun1sOYUix4PYjqlSoyi/cWF+TEtNgvBNuKtJlwdKvWhtNoQPYzrx1a
         LLgGmrEKE+/abAVrn38y5zmjBKhX/bzy20Wf9OYvpRg1n3yvkXZ7G0txFn1DpmYgXfYg
         Wgm+xlXhZeEDdgZurQtoHTtCQeoiE4kPPbSjvpp/bWVMPqyNpRuXpAMz/ntjDZaAkbtD
         DKvFsaHPfiAFpBxQf3Ni9BUU3TjOPv0YQDx2KZURO/uQIeinWbOeLyMrHZ7lKIfWMhZZ
         UaUw==
X-Forwarded-Encrypted: i=1; AJvYcCWvh1vUwIwasHt8rEb8GqYYIC5qfqHrjR5SALIfxLq118EoaWslX0S6zU2msTvnaddXqnpnfYooMv5igf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMHkDtACcFoKQwQ/jRzpKmwiXtZTIDQ0DkfBi71g46j8L1DVXu
	dnI4iZVCIYT4hJzwkNitJ+kyHIayArc5GJbFhCF0pmo5aj1MTvBevvDp
X-Gm-Gg: ASbGnctmzVfAJMSPX8WdFgqXjvTf/QeTDeWoiofu5qhUO/bR5BX9nPUB3TYJsTO+WsI
	C5ROkfFCC1k5hnmd2o/faDuyUpawhESZsKlzvv/5JIy1Oh8k9Cpsje4x86IDKIcDB3EZ5DPt4KV
	Zo90LIslUGLRqA+BafZ9sb0W6C6n2UQUCgrdrddtOU3vAtoyEUHgYPA3TXAep5cgN33QPPS0pRq
	Ezz5Ybg8pt4GUZvM7hT/JKtda90dQGDHsHDSOfBrmLehXFjhzCe6ZSElx06fZ2ROSvI3UkqfxsP
	WuEWn9Q6+g/dfWCi6qwbLDonpOauaXJ/C/7a94xW/7Qn0a0CHeSfDgU9RD5ADvw1x3tWisr/Yo/
	AcSy1vuMs//hKk838D6L1i2gwQSOVGNcQ5Bj2soiMgilHix/G4T9AGO8WmzlyePtw/syuoK3I4O
	nKe4SG77D1bT+QKPd8Wa/Ze2Igg/I5D/BiFKsX0cJG8vQmRwV9uCYQQA==
X-Google-Smtp-Source: AGHT+IEZNLk5umwmBOUCw1YoD3/cw2kbTnO1hk91vhVghFo2XMH5JsrjRDL7YnUDlM53qfRU+p5zXA==
X-Received: by 2002:a17:902:d503:b0:26f:f489:bba6 with SMTP id d9443c01a7336-294ee46ac8cmr24375645ad.50.1761807548302;
        Wed, 29 Oct 2025 23:59:08 -0700 (PDT)
Received: from ?IPV6:2600:8802:702:7400:90ae:1623:a8e:9839? ([2600:8802:702:7400:90ae:1623:a8e:9839])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7128b63b05sm15663848a12.20.2025.10.29.23.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 23:59:07 -0700 (PDT)
Message-ID: <59cd28f3-f2a4-435d-9b13-3d56b1d1299c@gmail.com>
Date: Wed, 29 Oct 2025 23:59:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/WIP 0/4] arm64: dts: qcom: sm8750: Enable display
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 quic_rajeevny@quicinc.com
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Abhinav Kumar <abhinavk@quicinc.com>,
 Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250424-sm8750-display-dts-v1-0-6fb22ca95f38@linaro.org>
 <w6f3s56gx7psqgweuntqvkzrot7elhc5pdrxhvenukzwyt5eys@fndmaszfbo5k>
 <921afe20-42b1-4999-b5c4-035669dc831e@linaro.org>
 <32eb3b4f-b2c4-4895-8b48-ade319fd83de@oss.qualcomm.com>
 <2db06bcc-f04b-4a57-afd2-1d0c665d376a@kernel.org>
Content-Language: en-US
From: Jessica Zhang <jesszhan0024@gmail.com>
In-Reply-To: <2db06bcc-f04b-4a57-afd2-1d0c665d376a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/28/2025 11:27 PM, Krzysztof Kozlowski wrote:
> On 29/10/2025 07:20, Mahadevan P wrote:
>> Hi Krzysztof,
>>
>> On 4/26/2025 1:24 AM, Krzysztof Kozlowski wrote:
>>> On 25/04/2025 21:34, Dmitry Baryshkov wrote:
>>>> On Thu, Apr 24, 2025 at 03:04:24PM +0200, Krzysztof Kozlowski wrote:
>>>>> DTS is ready and I consider it ready for review, but still RFC because:
>>>>> 1. Display has unresolved issues which might result in change in
>>>>>      bindings (clock parents),
>>>>> 2. I did not test it since some time on my board...
>>>>> 3. Just want to share it fast to unblock any dependent work.
>>>>>
>>>>> DTS build dependencies - as in b4 deps, so:
>>>>> https://lore.kernel.org/r/20250421-sm8750_usb_master-v5-0-25c79ed01d02@oss.qualcomm.com/
>>>>> https://lore.kernel.org/r/20250424-sm8750-audio-part-2-v1-0-50133a0ec35f@linaro.org/
>>>>> https://lore.kernel.org/r/20250113-sm8750_gpmic_master-v1-2-ef45cf206979@quicinc.com/
>>>>>
>>>>> Bindings:
>>>>> 1. Panel:https://github.com/krzk/linux/tree/b4/sm8750-display-panel
>>>>> 2. MDSS:https://lore.kernel.org/r/20250311-b4-sm8750-display-v4-0-da6b3e959c76@linaro.org/
>>>>>
>>>>> Patchset based on next-20250424.
>>>> If the DisplayPort works on this platform, I'd kindly ask to send
>>>> separate DP+DPU only series (both driver and arm64/dts). It would make
>>>> it much easier (at least for me) to land the series, while you and
>>>> Qualcomm engineers are working on the DSI issues.
>>> DP has also issues - link training failures, although it feels as
>>> different one, because DSI issue Jessica narrowed to DSI PHY PLL VCO
>>> rate and I have a working display (just don't know how to actually solve
>>> this).
>>
>> We at Qualcomm are currently working on bringing up the DSI display on
>> MTP. For this, I’ve picked the following patches on top of |v6.18-rc2|:
> 
> Display on MTP8750 was fully brought already. I don't understand why you
> are doing the same.
> 
>>
>>   1. All the DT changes mentioned in this series
>>   2. [PATCH v2] drm/msm/dpu: Fix adjusted mode clock check for 3d merge
>>      https://lore.kernel.org/all/1154f275-f934-46ae-950a-209d31463525@kernel.org/
>>   3. [PATCH v2 0/2] drm/panel: Add Novatek NT37801 panel driver
>>      https://lore.kernel.org/all/20250508-sm8750-display-panel-v2-0-3ca072e3d1fa@linaro.org/
>>
>> However, when testing with |modetest|, the panel appears blank. I wanted
>> to check if there are any additional patches already posted that I might
>> have missed and should be included.
> 
> Many patches are missing because Qualcomm did not send them for months.
> I was pinging multiple times and I gave up - my job is not ping Qualcomm
> to send their patches.
> 
> I have no clue what you have already, what is your base, what errors you
> have and I will not be guessing this. For convenience, you can use my
> integration WIP branch from my github. I already shared that tree with
> Qualcomm more than once. Please reach internally first, instead of
> poking community.
> 
> 
>>
>> Also, I’m curious to understand more about the DSI PHY PLL VCO rate
>> issue that Jessica had narrowed down—could you please share some details?
> 
> Sorry, I am not going to repeat stuff done year ago. Please reach to the
> archives.

I don't have my notes on me, but IIRC this was the byte/pixel clk RCG 
failed to update issue that was causing the clocks to default to a bad 
rate (despite driver requesting the correct rate). It was fixed by this 
patch [1].

Thanks,

Jessica Zhang

[1] 
https://patchwork.kernel.org/project/linux-arm-msm/patch/20250520090741.45820-2-krzysztof.kozlowski@linaro.org/

> 
>>
>> Lastly, I’d appreciate it if you could share the plan for merging these
>> changes upstream.
> I don't understand what you ask me. Process of contributing to Linux
> kernel is well documented.
> 
> Best regards,
> Krzysztof


