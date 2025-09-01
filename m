Return-Path: <linux-kernel+bounces-794160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C55B3DDAC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DC117C16F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18723043BA;
	Mon,  1 Sep 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRO8+o3o"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7272272E42
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717824; cv=none; b=ZfYmIHsZvMvzrlxTKHO4k+9Rc8vKP1M6iZdhP6W5vTeHxkJ3/05vqibuJQ6qvXFm1Pc2tU2UqZDE6HsgebYWqMC44yHnnE2C4Qb+9qf917/VAlbDTYCZHU04ymDoHg85UUmp+L6WXRie5X0JTEaZFb7/N2cdB137Nb+1+YcXcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717824; c=relaxed/simple;
	bh=wHuP9vzcf0uxMcxpVzhAD7blzq8KbpGGUt0A4O2FaOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxFyn2PM9ELg6OtVcd7qVlAdfFG3sz5BSLmO0kfxKXxPNYR+OyJFvEjWW/bNy7HgDxccsIJJGSLMvNUVgoTMWye1cNh0aLmbYFCBvqqSlq4tbVjK2nUSv/5ZhBH6LVYbnpkWJJtM4q7DJ95X4jvVWvwPaJijyQtPemNKlbVbsLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRO8+o3o; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3d1bf79d6afso1286432f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756717821; x=1757322621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=meHf9Dzi9Udu3DdPaq0IFaV1tFMGI7amWp2ppks2KVU=;
        b=SRO8+o3oq/Dqw+Ci1/BcDKx92BuyYldu3U1V5pzVWYIVKDx9k9a7Iq8y51mMnyPrk+
         m4+TPHniS6D+ZkZP18GeXW9i6MfyHIzPSTnAVbjTMesPpCTwGDUNWMWOJvRTeu7lWUnE
         ZCI0TtT8yoyjlCPaa12lnaNRWb7tTb5wsUgz9au30qLyFGqYgOTchOR1RbVzoJBqENge
         seOV6Ge7iP5ekg3L1mVio+llOypLGJUDQPRjalOoWJ65LM4zajLqUYK+Q1LDgo+JvHwe
         mBeQj7pQTnB1qGdFLLCIWb30EgI370k1C1FnwtI+W1FGn3HM4kT+D8U1nbdHI1fJZ4Fz
         9wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756717821; x=1757322621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meHf9Dzi9Udu3DdPaq0IFaV1tFMGI7amWp2ppks2KVU=;
        b=ibvYbETHwrGzp30Ni5CPZ3ECdcYjGQUe01U+UVE+QbgHh1S/+bPulX+S5DV6K/WCgw
         NszI3hkrJAeutZtU6nITNZ19h0CYMBdmalN13iM9BFRd7jscWlh9cYiq/teTNxzbY4kj
         AeIAl3lwGb0uxYrFgEdOEset65WnVuApKd6ZuMf+EctFYJMZmzaT6F1rinvbhp/DiP6J
         L13L2aSt3/iuHpYmHILk6ezmNcA6E73PdVEg2oDrkaDG15gb5kf1c+928yWMY/XrmNHb
         2cSSmx9ksCHYPGtRZZI16wjP8L7jcYOfq3tDHyVQAG8e/Yelsb4/RC9+pGt8xwTBcphs
         fhgg==
X-Forwarded-Encrypted: i=1; AJvYcCVHbO4FAMCA8vHKdkq4aHbFmDwFg3CXoMia960ONNTlfsLguyi1ULUmkrJ5pG+t5C2/BpGp/bJk3xFdHmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXGGDPcHw650S+fCTZKax6YRbg2aYTBH4J7uUpUrlzdGPOsx/
	bzXGcYAeKlnZXhbK9eTDBHS54Dqkjwkp7qyAR3wrZJBQ2n7ptZYaozdMblZQoPYAudk=
X-Gm-Gg: ASbGncsbecfUm5erRfJ2lvcQzEmmtKf/Iyz+aeLzk+3sc0v9qjcPn7CrIuWnBPLp+0S
	EuH7pKb7Tm3rcDqGJoSKfHBf4kGHILpGiJunkYoIs+hSDk1aGHcUIKzdCaK5qmbDa07mhXae2b/
	22opB0LdegcYsZHKnZFvRvaZfZ1D0CgCluyfV9kZMMVa1ypixkmkzO3AYA2ajxtHQP/BV1GyBrR
	fcX0txFEciW3IP1Iu4YbtmQsunDCtgaOBX9pxw1buM0XGbi/ZLKw28vFxu2782mYplHiGxOkPKV
	0FxvTZtn1eTgpLE2C9plbuLywSLQ1Im3WUMaD4Aqts4Pi+T16CXPeQ5XwtQ05uRm7ue1h50l81i
	5tkyATLbqUfgnhKIC9CGjVMUpCP2Czvzwumpxgw==
X-Google-Smtp-Source: AGHT+IHwD9wQkYnnHFPyCoE+oRse9cNjidrfIe1Wag1mwkgXlb86FEc301H4rWNpqC3pM6+30woB+Q==
X-Received: by 2002:a05:6000:2011:b0:3cd:1cc2:f411 with SMTP id ffacd0b85a97d-3d1e0a986c8mr5227063f8f.61.1756717820994;
        Mon, 01 Sep 2025 02:10:20 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d85f80d8casm1010533f8f.54.2025.09.01.02.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:10:20 -0700 (PDT)
Message-ID: <7a40573a-1868-4697-bca5-fb22aac0402e@linaro.org>
Date: Mon, 1 Sep 2025 10:10:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] spi: fsl-dspi: Avoid using -EINPROGRESS error code
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>,
 Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
 <20250829-james-nxp-spi-dma-v5-1-3246957a6ea9@linaro.org>
 <20250829125440.fuxwiekll53myiui@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250829125440.fuxwiekll53myiui@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/08/2025 1:54 pm, Vladimir Oltean wrote:
> On Fri, Aug 29, 2025 at 12:46:43PM +0100, James Clark wrote:
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> The way I'm understanding these tags is: you wrote the patch, I submitted it
> (which is not what is happening).
> 
> I think the conventional way of describing it is:
> 
> Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Yes I agree, I took your patch a bit too literally and didn't modify it.


