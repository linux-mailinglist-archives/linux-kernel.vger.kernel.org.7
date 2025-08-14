Return-Path: <linux-kernel+bounces-768740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F4BB264CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395102A14E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC82FC87E;
	Thu, 14 Aug 2025 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="roAPRZVu"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FAF2FB97B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172798; cv=none; b=FV/j/9YysWOMt/aOQ/TvLQi43MVufRBVcskM4qSTkJ4SDHlssJRhhVmwYtAfF7G+UwmS5VarvSbuSxX0qeJwCLZ3wDNzcn5Qaceg7uqY7IamZ3czEkVL8h63rk0MAbjj2NAbhWNFOaeiLnhohztA1FuF72wMln8e+fPYEQCBtY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172798; c=relaxed/simple;
	bh=HFX/Qwld+Sh0z4QKTMLIPR1Ye4VR7lyGLk0gc7fQ85w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnrHOLtD9txW4/E7DVS7+7TZDyKUc79ag13TVokuO8L56LgNyOJ3ESdsb9i46MKQQipa4uXSFDZNFZdv3BajtbBULcJ4cJ4l2DvJ1rj1Hx+wDSOT7sqnlDd76q58JuhJxPIfw+HN4Th7SPH37xS1G1szI18j9NP2AvP1uMB3pA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=roAPRZVu; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e57010bc95so8093345ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755172796; x=1755777596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkZ6MdXAK8oUuFYjzHuswEeWUTNOi4hs6qI/H9CSMKA=;
        b=roAPRZVumjhXSJMNbOOKCt7VTy16wBXw0WVHlLt6mdtIXZk83X5YibLjoUe14l+prN
         fW7d/bas93KoNHsatXcMhgWsAmvc2gQi5fOyxQEkfxfbXovmCDkk/YtBEcrkWhV0bkCM
         qY3abYbLqOZduAZGRLzhY7TDIdI2Bg+suk2QK5iQ0bHOF/DTSwTBEef4pDTXc3TsrVL1
         Cpt+bwgopxNd5MFDyjknyD7TfduO5QpRTVQlyIbTi5mHq2gIjp9BTNf9kbs7Gu0gLgom
         wv+NR7SEMY/a4IaEOILN9/Zvg/spwkdsSNDSCGdpMoCJkjfsHJP3f+JNpmYBOxM8lEgt
         S7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755172796; x=1755777596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkZ6MdXAK8oUuFYjzHuswEeWUTNOi4hs6qI/H9CSMKA=;
        b=uPR8aT16oc2nUufkhWrHC59Z5ofqPcDa84p2l+t+VMLTmX9mDs9c7wNkWD8duDUp6I
         zmkcReJGJlDSmUWd/BR9bphwqmIs+ax4jw+Da/wffmabooU0Zmq3ETkrLjkHJN7o8H7g
         5VBB+VwBdt4o9yrB3/iS5V8V6A6N+AiNDdxETgH12xxVVlM+3lhup0ahYsbbVOd/ZPp+
         FMdpziuzxuKS3024KCnPbYETUu9hF8WAFemliQ/dlTpCJfwuGAuZJQxyb/pVR21uX4Um
         twNUEJkfr1jDOGEsruWBo3dEaInWOk+7XvU7v5ypWglmBOp9JUpJvO2Gc5KvQ859Ae0P
         FkIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw4Wb0O7wmlqfKw+btQ2o4rIRuYKGH+VRhFLU6WxQaaiHJjwMlcbWYRU9Q3V7m2D5tWhIbCC7Lx0ZCHtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHuiVYFLviFkZHBFEUqo++rKeEnU9s3G/YYzjs/8D+bNGDVrnx
	qvKxGtFU1ogtRoEs4A9l9yksvfE0KZGgJJb8BzVZhEX7Oa25O44DU98lTIMtPoEgWxs=
X-Gm-Gg: ASbGncvpNGe6A9AZdRa2GKRVdPsHGLZD4bk9DiCODsGN/E6FRDgrYuKsRMaBeW8ja95
	PA4IdU1bxGbSAXcw9kjydPx9/X0MPobNWJoP3uRixzV33d61hwZn1miG929eZyMMqJJuviORgxp
	iVUULWL4Z9mW03giFSCWo//yNqAYXiqXJVSyTulYSWM9ksn1hAgeb/wXOScKqFyCczG9xCfvHhB
	3Hx4OzOXPbVX76F77MwEqA3jFykDcogxXKTweJ1qyqDTA4F5TUebUn18eFSJX9Ofcgp3FlWgo/g
	xG7R9dP741Dnui2ae9RjA5Xg9nkW64oKcKEp5rYVKnQRhivlPKeY5RZBRDh+xdXuBh6O9UK+CSE
	ZANvqYpTMTnp3WCmfxQMRTyj8MczmpvZdtmUyPbKw+wZJNw1MD+sI3cABZjNHcw==
X-Google-Smtp-Source: AGHT+IE3y11zxXdSZ7xsXLUpghewNnJCpWK8G2mFkAzcKjVS5vSn5G3dmjKvLqQoKez3LPNe1hHEcQ==
X-Received: by 2002:a05:6e02:184c:b0:3e5:6daf:ddfe with SMTP id e9e14a558f8ab-3e57084ff05mr51337105ab.10.1755172795698;
        Thu, 14 Aug 2025 04:59:55 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9cbb659sm4480210173.93.2025.08.14.04.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 04:59:55 -0700 (PDT)
Message-ID: <86174012-fd87-41d7-9568-f9c0b544c1c4@riscstar.com>
Date: Thu, 14 Aug 2025 06:59:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: phy: spacemit: add SpacemiT PCIe/combo
 PHY
To: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com,
 vkoul@kernel.org, kishon@kernel.org
Cc: dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 tglx@linutronix.de, johan+linaro@kernel.org, thippeswamy.havalige@amd.com,
 namcao@linutronix.de, mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
 inochiama@gmail.com, quic_schintav@quicinc.com, fan.ni@samsung.com,
 devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-2-elder@riscstar.com>
 <22bd5b5b-ca06-4499-b21f-22c2ff202167@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <22bd5b5b-ca06-4499-b21f-22c2ff202167@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 1:11 AM, Krzysztof Kozlowski wrote:
> On 13/08/2025 20:46, Alex Elder wrote:
>> +                      "mstr",
>> +                      "slv",
>> +                      "global";
>> +        spacemit,syscon-pmu = <&syscon_apmu>;
>> +        #phy-cells = <1>;
>> +        status = "disabled";
> 
> You cannot have disabled examples. This also means it could not be
> checked/tested.
> 
>> +    };
> 
> 
> Best regards,
> Krzysztof

OK I'll fix that in both places.  I think I just copied in the
actual DTS content, but I now understand the problem.

Thanks.

					-Alex

