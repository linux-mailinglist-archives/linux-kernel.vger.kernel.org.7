Return-Path: <linux-kernel+bounces-725334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D25CAFFDA9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F945A59EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBEC291C1C;
	Thu, 10 Jul 2025 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KF7aiPDf"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077ED28CF75
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138927; cv=none; b=rRlGO1sa155/0/hBoNvAEuEzqYsoRI1opSeEWxyThrK6zE0DI1S1YrxLwxse6HvU4fwwPuNUNqDUyDLcrqBrDI+22312I/3ClqPPFm0wPJTKEgaAr+LFsiZa7trTbMoyTZPVRNwdzu72DRY+pwMuS2IG8eqGP+Tcwm7oyvQIL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138927; c=relaxed/simple;
	bh=iiLjM+aUgsYzHC/WPwWLV5opBtyLVc4FDeCI5k5C/gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SlVyma8fxiKgl8Qg1IpEg1SaUYl/sYKXRWlZeJiF/I/tNcuh2yXxbPXomcFVp7eyP+EYGSYfBdfLN2NKs28ogLxbl7GBrTYSKD2b/6E0Zf1AgFnKPFGOWH9Z5q4425KLLdE3lYbqQwMgjVV09N93fN9m7RS04HSNfWlpD0eBZRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KF7aiPDf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso4903825e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752138924; x=1752743724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6q/9SW9W8dxQjuQZq+qCAODMrqQtpqZyWtMbjNSA18=;
        b=KF7aiPDfpqpR3fe7cobvW5bhi7ALwgm5qkdHnV6P3P36cmPxo2zhBN/82RsXy+UtTB
         TmgGry5fYF00eygna8l/Hs+UrJt/zb+jcr/CTc3w4eTZgvnpM1oei+Kf2MuJGQN2Sr+D
         xpash2zB+Ddv4OfQd01+M6n0Ioah/mklYNc54VE/UXcvL3wN8EwC2UblHFzQC/AqUM9g
         nfQ19T4ORPx52x4ndx4jYzFa7mOPxh+O8dJ+GTdRVDRW+cBlGu/tnjOjJPgFRHcYyMhB
         p03VgBIy+fruZGWBZnoxeZNGsUvuc+FAQi4h5NFvQTW/yRQvJAkFPAK/jBWcx/iBiYTd
         oYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752138924; x=1752743724;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6q/9SW9W8dxQjuQZq+qCAODMrqQtpqZyWtMbjNSA18=;
        b=LWNki3OplrYIh9Sx6FMJtGPcifEoCyr35dUd98NjISTjCPPJYFncjIqZS1ON7dve5Z
         jut8syTt0k5yr46bqtzPsN4AzMKuWtGE3IiCLfoiRPqzFIhJijAbBDON8Yauz8eztH/3
         14oTPOnlcWPZXn974oX7mi71fRkT6uPSSgb+9E/LE86mkNsPNjKDuojcB+IzOHc+42Eh
         om8BBAuu1T3Hunslu3r7Zj/e9k266jdKwIK3hoSrl2kXxVvBT94L8La5fh24DU5FqHD1
         TeeqE52j15ZpN1U1yWUlpQtVhouNTXdBqErMYrWg0sjL+1zJeROE7349hJt91/bgl9G+
         GjeA==
X-Forwarded-Encrypted: i=1; AJvYcCUSh8DGG7oXd5G1+mRHMxmudM5xCq8rQwVLYZIgEKt6uit1k2Qd9Vnt7FBaI+xxe5j/7EdDmdDpI6185P8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybzy7xXhA7BAQmbcO7aHrp10Rnm9DP/E8R8hR8uojQT6XOkv51
	arLFbD/WurZbITvrtDCRCm4UE6s5f62PhN+TY652MLyPV4CIxizNFgRXlAAp8k2N6PQ=
X-Gm-Gg: ASbGnctHF/NdLdg8SkRrj2xNOGheXzexsYGjP5ZTQZoJVxUSiBsOi9wQ9mddbek1+Pi
	JZHgIOPhkLzyRocLGcDal4kjFEB04SqJVzLi8uzaaF6ltIBL4Jsb1q43gVNOpKhEFH9+5x2UaJX
	Pl9Ielb9+n5BkP/aw4n8p6ZZQ+96oWvnZfgpCwpk8LcyeuPg7IgVGqGsUrU9ZNrcwQoCuPhaou9
	s21+xhFXg+cKhE4/SISgw2D7P6mUiD3n4fG3zVFNXKhhDX54Q8qi0ScgaDiR0nFPeOloWYlaT4v
	f8HgXoyoCB6P0xRQP83AdZm9eMICC8PoCXmH2PloorfeBxvKgvXz6fy7NbApUYRqBVH3RBD3nM3
	SXwsf0W1B/lFtm8sENopN/KLQaz0=
X-Google-Smtp-Source: AGHT+IFiUkvfNJiRLRUs8fa6XAAhAZRAnt+u186odn28Di4bfezkL7HU3hExac8w06CkJd8HzwOdhA==
X-Received: by 2002:a05:600c:8717:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-454db7e87c2mr31122345e9.3.1752138924220;
        Thu, 10 Jul 2025 02:15:24 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd4b32d8sm13751625e9.17.2025.07.10.02.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 02:15:23 -0700 (PDT)
Message-ID: <c3803de2-56f3-4346-9490-67cd63abb287@linaro.org>
Date: Thu, 10 Jul 2025 10:15:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] arm64: dts: qcom: qcm2290: Add Venus video node
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 quic_vgarodia@quicinc.com, krzk+dt@kernel.org, konradybcio@kernel.org,
 mchehab@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com>
 <20250708180530.1384330-7-jorge.ramirez@oss.qualcomm.com>
 <8f30092c-0e17-6f4d-f3f1-769508d2f58e@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <8f30092c-0e17-6f4d-f3f1-769508d2f58e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/07/2025 09:57, Dikshita Agarwal wrote:
>> +			iommus = <&apps_smmu 0x860 0x0>,
>> +				 <&apps_smmu 0x880 0x0>,
>> +				 <&apps_smmu 0x861 0x04>,
>> +				 <&apps_smmu 0x863 0x0>,
>> +				 <&apps_smmu 0x804 0xe0>;
> What’s the rationale behind having five entries here?
> could you share the use-cases that justify this configuration?

Already getting in trouble with non-pixel/secure # of iommus.

Why not specify the maximum expected number hardware supports, 
specifically so we don't end up buried under incomplete schema again ?

---
bod

