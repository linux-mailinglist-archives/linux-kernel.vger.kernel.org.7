Return-Path: <linux-kernel+bounces-800325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E796B4364F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABE93B67B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD962D0638;
	Thu,  4 Sep 2025 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JSp2pW1X"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5442D0C70
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975952; cv=none; b=rJW+837mUQRVYuAqVGll2ISTvDIIqpXwNcrHdPfnjduvW/48dbVRnOX9rGMLNOF+11OMIZEJBjIyNn6XhBlNK9cvNkMQ7ppyV8U7cXW9gLxYSnPe8gmFogseQRgDr+uUJ6mTOMnNiCpJPYZugK7WTogSVOFXXwJlMZW3AWD4Mjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975952; c=relaxed/simple;
	bh=qjZa4YKZFgevyucA5IS3M7gwJDXEq9cxnfkjLJMJsNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qio3B1lJipOZVKrpRcmSiI/Zl+u4DkdeD1vSYjZu7Pyz6y/uv94uQb9m4dryk05/tLJ9HcU4+YFsVWAGDp57CJXzUGWvahg4w8fE9nRyGl0Jd6aj0x+voP2RqI90B/2+ftl2Uhx1W1HJ6nmxfho+pIy4+LgiSR20hjq1BymLupY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JSp2pW1X; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b7da4101fso2438975e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756975949; x=1757580749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7gK6n/g/HuSb43cbH0cdIC2KH3XWzF+uMZuIHFj3Zpo=;
        b=JSp2pW1XWgx5EWNvIZ9CENaCNQS8HjxNimipmNAdi5cRHXsC4qw1FTX9S5XoK36wtQ
         9wxxRe04oFWsaazBDrCg/LtQr4q04+OFmGJBWZzwvZCc1qOsLxl7CBPJkvV3xSxoQOc7
         zdWKOlan3lXDekPXeyRJ/R7ryQBPz5ORHIx4ilryzkwIXZqSGbV4f/EqFz51yZmhbPQb
         yqK9Jho5cch7HNH3MMP0DfudbbtxxlJ7IGjSZ0mNzH6fCaJhTMDvYh5eBui+C/F0yuLn
         CEbOZfHK6mv4lXTQJyDE/ljrvL1LuQtzQ8rsMJAHpKB4r8qALJaWUKUgsI/cy31lVmOE
         mzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975949; x=1757580749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gK6n/g/HuSb43cbH0cdIC2KH3XWzF+uMZuIHFj3Zpo=;
        b=WNsr2UXjgKR7cUbeoAnvqvirWcXpXHMi4BsEwtC940bM5J6f9iCVwkY/YNnv3DDv0/
         Fl2w+5n97tWTbnEH0G/J0ArFdMTlF6hdcJHk/UgEo96aJLlfGNxiL7+kBIa0gVeqbsOF
         91HdgxT3YuLdxrZT/qaBppTIl5WBNW/2QXkyLSJ07yYJO2UFBbDcr1YZFd1OnJ34ZfZC
         tVgRpf3QxWcjuu8cts/I6IC4pSC/m9bOojRFjh097Y0CJKxb01fPgSfM5nc3pSamu95L
         OqM66eQIJGji/ObOF/rKq9m0oQz9RdKznbqEo3wwIFny/MmIQ89enzYmjYpn3FBf8M9E
         yhjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmXZmXY66Db47uH40C+6NblnWF7DEoLOn9kEkorQlZgm8e3TQfDSlY5TsEViFPlUfUuinNGtdGewJ7Yno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQpPMi1ZilfO0QH2aW9mFTnxmMrjbnBoMixMKOIWrE7RLLzGU6
	myXQssTsz987Nqwjiv6knjkicR4b6KFwrcRS3LG8g/6alkSmr2C3lvQwq88jcMQqrsQ=
X-Gm-Gg: ASbGnctuHqXCia9wIgI9h070Q8dPf4PM9GGMtFrL39YIhZH5mfeoOWoDRpfaC/Cs+kN
	JeRwBCDdUvAxMrV3OQ9yY+b+ZAL/TIJLNm6jcRuo7anY6/V9Kq70LOcY56BDu8lt9GaWY5QuD0J
	v+Hie/TzjW7AWw8/r7SSKmgo3jjXh4DCn5vtOer8w73a5jnddU7jFUntBprtgR3shrX7e5ZZmVt
	hSpGC4spNP/RJzCx7yX2dVclV681V7rF4uJM/lUOmnNxwbvcUMQp5YP9ShXKum5tHk34OyFnold
	Gqqzrs5AcQ7NCryksbLdPG2v+rN7O9a/1krimi2exvS/Qs4HGE7ekh7zfq/U1IGmwjFZtd8ZTKZ
	3FFFc+p/OwelAcI/dAqUJLtsmcr1mZwXV
X-Google-Smtp-Source: AGHT+IHtO9lhAj+5b+dFwSvHFWLll5r95zkvUmodvWJ+Fdu92nqESPLKzmEOTmjK13cRmo2Ta3LMHg==
X-Received: by 2002:a05:600c:5253:b0:45d:98be:ee91 with SMTP id 5b1f17b1804b1-45d98bef030mr24615585e9.9.1756975949013;
        Thu, 04 Sep 2025 01:52:29 -0700 (PDT)
Received: from linaro.org ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d7ac825b88sm13968312f8f.7.2025.09.04.01.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:52:28 -0700 (PDT)
Date: Thu, 4 Sep 2025 11:52:26 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Johan Hovold <johan@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add missing TCSR refclk to the
 DP PHYs
Message-ID: <qlqsefvnibw4esm5wz7khmyfdnszn5veinfb3k2w67f5v73kry@rzclmu57ybdh>
References: <20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org>
 <20250903-phy-qcom-edp-add-missing-refclk-v2-3-d88c1b0cdc1b@linaro.org>
 <34d9e8eb-e0f4-47e9-a731-fe50e932fea1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34d9e8eb-e0f4-47e9-a731-fe50e932fea1@oss.qualcomm.com>

On 25-09-04 10:40:36, Konrad Dybcio wrote:
> On 9/3/25 2:37 PM, Abel Vesa wrote:
> > The DP PHYs on X1E80100 need the refclk which is provided
> > by the TCSR CC. So add it to the PHYs.
> > 
> > Cc: stable@vger.kernel.org # v6.9
> 
> You want to backport this to 6.9, but you also want to backport
> the driver patch to 6.10, "meh"
> 
> I'm not sure it makes sense to backport functionally, as this would
> only exhibit issues if:
> 
> a) the UEFI did no work to enable the refclk
> or:
> b) unused cleanup would happen
> 
> but the board would not survive booting with b) in v6.9, at least
> it wouldn't have display  - see Commit b60521eff227 ("clk: qcom:
> gcc-x1e80100: Unregister GCC_GPU_CFG_AHB_CLK/GCC_DISP_XO_CLK")
> 
> and a) is not something we'd hit on any of the upstream-supported
> targets

You are correct.

However, HW-wise, this clock is there and is needed, regardless
if UEFI leaves it enabled or not. So it makes sense to go all the way
back to 6.9 and fix it.


