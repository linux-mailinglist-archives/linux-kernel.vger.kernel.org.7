Return-Path: <linux-kernel+bounces-661300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F80AC292D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 19:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BC9A27209
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 17:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC53E298CA4;
	Fri, 23 May 2025 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="N8d27b24"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568729995C
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023175; cv=none; b=jiNDQrbUIriRZKeBakZ71S0MCJnhtQYBgX4FHOnHK3qzaNBAHLKtEu6G4DrMhHWxpsjg8j2AWjOWh/lN34Q/ykwZvNBYKc6TXjnoNv/PvBWDAa/deKGbtARAcSz+q4LzSJwu2+0KSuWowWfYBh0NFQpyW6ZkfKPSYFD+coqLy0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023175; c=relaxed/simple;
	bh=8wsWQ5YjMTwGPMyYB18B6uzDSiUbxxRChxzdHy4FbyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZIQB1y4WhDeQ0ecS0cKlz1GrnoHmwWE78WaW9FSXN1Anvx9Rt57ZfGxnawuD8l18V7W9I3oleI57xxkJXEcfiIIbwoxL1Y55fY3ook2D5bUs6rgVzYK0fswcp9dQgySDGaelDlVkBP4jmY0eID2NfGevZwPfpqDzThN6auY0Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=N8d27b24; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3dc64b08343so590755ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1748023172; x=1748627972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjndw5gm+i4IsAlDvyxOC/Zv2WGk4Ah4DOr+VHcYMi0=;
        b=N8d27b24VaP4yyOw9S0TwldtZLHF3XtK71oGcMie3cw8R891fcNFmkNUtHzenE1IUp
         1kQ5YE/PJ+BLTsCCMZ8N4oC6smW4dAhEVjp3oZ+D8Gq/dIM9E8Apix7kAsF7AO+9sHnz
         3Ko3go1tMUsIK9TDChCq/QLiZjI8UkAOnasEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748023172; x=1748627972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjndw5gm+i4IsAlDvyxOC/Zv2WGk4Ah4DOr+VHcYMi0=;
        b=xKNySxuZYAG+JxYMlAUjnjHGVDm/ZfLKPGpNccVZEySkFZYSgeXu5ZjKk+ufZU9Vxz
         sUeCPjkdSLVupqE8ClQ9mP7/ohwDjN7tUqkK1q/ZoaGpF5K+/EbURYwfvNnuNfj8qkFE
         sYnp9JdEuJLsPrlO27yeu6iQGDQXMfbovaEicqSM4wwQbyfvjDfg3ONtpmO1EqxXuMmK
         OtqHRbWJaLGAWIQo2mMa5C0e5QJeDdK3bwsudsRmtLlKw0KYJDqmWCDGbo+/gel+CiyB
         PtMPHU7x4sVkmJRcFkX95DDI159wZQALtTPC+HlwT1vywpt32fFNdQyxzp4YNWkeSXwn
         aX1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsRqksVREN5JPkOia2OMk8CWuBjWLM3YK8xJVRC+X55GmrrhC30OjIP9Ny/IU7mBMd0UFV8QlHTsSHFkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWBdpj6m1WOkJVSs0Wocu4bAT22yHDPR+fqJrO8vokEJlNqyB
	oQOFWrr8fWempVgG872NQ+c1RcnHsMOcF62jPGaOpxE7KjwxFL9bf3ttiPPXHBO4pA==
X-Gm-Gg: ASbGnctOE9E7CkykG96us6PM7sxqu/TiwNAH4oi8g5jclIwt8Lx5UDdb1GflUrhkPiY
	IWug2m7iXDQK8NON3cSS/KIDpDRMwSYtR7F0d/ShOzQTEEBerF+WyYssJBgjYlcLtZqdrYx3Ttb
	EkjsoSMZzJ4wVDkDDYYJjflDNXjfqOMfCV0+lp3TDjKZ/QSgDTneglRuU9aEfL9ixHRc6ueDBJy
	BwcsI7AVcEGGR9tT6d8eJaYf95qYD48cmBgNmQSFQnidVCIfSEsm0qkPWFa7izNa1z9DWriRn9s
	JoqdXc/LVq4Gdsz/iJ97AtFrNZmWvoYfGVDJExb/+6iV9pfmkR2xKbsL2nPOEdjDYqJT9eMO87K
	UGXAbweQAjA==
X-Google-Smtp-Source: AGHT+IFoy1NsNZRyu/5wF07RFlt2gE/j7+7c1FVWoN4ouL4Kx/vkSLuJVz+D0by0S2cFl4gCyaut4w==
X-Received: by 2002:a05:6e02:1488:b0:3dc:8746:962b with SMTP id e9e14a558f8ab-3dc9b6e58d3mr1101925ab.15.1748023171708;
        Fri, 23 May 2025 10:59:31 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3dc7f126188sm18218695ab.65.2025.05.23.10.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 10:59:31 -0700 (PDT)
Message-ID: <c46e9435-e56d-4563-ba84-1d8c7ef0bab6@ieee.org>
Date: Fri, 23 May 2025 12:59:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: net: qcom,ipa: Add sram property for
 describing IMEM slice
To: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alex Elder <elder@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250523-topic-ipa_imem-v1-0-b5d536291c7f@oss.qualcomm.com>
 <20250523-topic-ipa_imem-v1-2-b5d536291c7f@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250523-topic-ipa_imem-v1-2-b5d536291c7f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/25 6:08 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The IPA driver currently grabs a slice of IMEM through hardcoded
> addresses. Not only is that ugly and against the principles of DT,
> but it also creates a situation where two distinct platforms
> implementing the same version of IPA would need to be hardcoded
> together and matched at runtime.
> 
> Instead, do the sane thing and accept a handle to said region directly.
> 
> Don't make it required on purpose, as a) it's not there on ancient
> implementations (currently unsupported) and we're not yet done with
> filling the data across al DTs.

We have to support "ancient" DTBs, right?  So unfortunately
the fallback can't go away.

> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Looks good.

Reviewed-by: Alex Elder <elder@riscstar.com>


> ---
>   Documentation/devicetree/bindings/net/qcom,ipa.yaml | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> index b4a79912d4739bec33933cdd7bb5e720eb41c814..1109f4d170af7178b998c6b7d415cc60de1c58c5 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> @@ -166,6 +166,13 @@ properties:
>         initializing IPA hardware.  Optional, and only used when
>         Trust Zone performs early initialization.
>   
> +  sram:
> +    maxItems: 1
> +    description:
> +      A reference to an additional region residing in IMEM (special
> +      on-chip SRAM), which is accessed by the IPA firmware and needs
> +      to be IOMMU-mapped from the OS.
> +
>   required:
>     - compatible
>     - iommus
> 


