Return-Path: <linux-kernel+bounces-886929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA921C36BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75561891390
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40593328FF;
	Wed,  5 Nov 2025 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJwG80bY"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933A336EE1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360225; cv=none; b=f9cBzDDuEdqf+vzpSTF8RDLgrFW11ig3cHSKenvFtyP9z/MlgW0hDBX4/vCJiuOggo6LFRUCDizX5EuPJpSPYkCIiyO9c+w8odoVUFvm0B7xVPXbBTLrohzbnESSTOW6b8o+nRs4B54mmaMdhYZF5b+AiXveKEReD/YRKMDczj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360225; c=relaxed/simple;
	bh=aLMWc2wz0lR+J9epmU7ClTbyI4cwZQ7jLjWyLp9sQaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUIJEH5nmeMqNMc3pJP8joIWPEMvOLZ7oP+p7oY5FH4JLlImhp7JPahmlNEhQ7BBBk279LLp7SkmRwYRswejvm1eHlnTDHk3kZSvmlVSI/JDAQX46mRJr/ko9IwJTQr5m/8pycmbqNGO6BRgdRv9rMD70wCIdi717VPrLEhBVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XJwG80bY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b5a8184144dso949588666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762360222; x=1762965022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0ElpEfU23zmMJp6XAE1iet2IvdsDeFlwy28hHUB1VQ=;
        b=XJwG80bYnUdB1x5t2V1mvvxGzmfX2iReVIBu4sTdXpahTpnRhGqH2OcNhugni2L7nz
         l14ElFYtblMAXTJxOZlHQ3tQ0rv8Wq9NIYcM9oPK6nUAJFy4E3LiSSgDzf2tfEAXs1fU
         37/r4BCerfxdnP4OFHN2qRjJHDcLW2Fbr9M8sUfIMI2zmffNtGRAD3Gfg3xH4q9M21rx
         lYZ6s+fZOBX8R3UvsgIqUJl2Np2cRj2+rNqsmkG/wgu/pTGiwLBQStvztTxfMM8uyQyh
         369bk+xt8WJtIXuV20ts9iJe25fn9oe19pplIHKFSG8e35h6Hf1kfmp6fMnaXGVzBNKw
         uyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360222; x=1762965022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0ElpEfU23zmMJp6XAE1iet2IvdsDeFlwy28hHUB1VQ=;
        b=rngRcjOBEJjmh5G1wcuB9vZuJUe2+wG1f/Li8/FNyNssk6CFr9Zhz8on2vyfjG4/pI
         RjzpDmgJ+i1lQykCkmJ1UlRlnAxDgGnoHTY+mkxLvqKXCmUMNNMtCzFOgcWd2fnY1i7j
         Iec/1rb4/jlYwDCA7awYXJWKKMDOqE4rQOCAduLwYpLSWvGXjlXSOIpjoHEB7tk3KHB+
         Ty6uEeH4uLbZ7N/PZFSj2/qatJOdcWvBmzXhKcrt9kFPavIqn8tUp6KpWjQgTKUCBY6E
         ScmztfJuQTP/V+VD/YW7KLd3+vYUguNVS2X5+AiWxBg2zrcgtbs3RIOi45oAOCls2rcJ
         j00A==
X-Forwarded-Encrypted: i=1; AJvYcCXa35Q68gfQ59OgK6fGNF8fEdbWi7krwyvphJEj2s2IKKxOmovy3aUfHkmi1z+/GTusEHSF1Wzz54cYIb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7xqsatmr+cxKtHdnlmM4M8OVFNI3Z+nOYoko5mOf3Mm9ao7vA
	TNcsfIrl4Ho58Ev49rKu86tYfzbbgPowHzJW7sAm+sb4dPVXsY9gp/PesgmX8scNF4c=
X-Gm-Gg: ASbGncsykT+U8yPMgPcBon5qhzFts4VJLJFo03pHXxAQUiIeo1aBul/ZFel+BGuAqLr
	SYMA0ya3FMx8ujcVv43tkp3Nxxbg7NHmZN/a/UQy0LavU9a+L9zm70jlA0k2dtLj1PrNJ3HTvkN
	peEiYvWt/S0kPZ1ls5PcOE6SS1RJPB99sXnDzWFtVLmXW93Nj9RwdpoUtERZBnBfMs7cNkqgmdI
	x/o+00oZ9s2GtFu0X0NzIIEJWj4DasZSbp5aWH4WoqGoUqiO2HV10dWpIHB3MivSqFjRG9EHTCI
	dj0f/8005mWyYXxxN1ldMM8jxoCSGe8RTjGU+LxK4r4sOxdtGWVvYqSMPRn3hlHJkI+3jtUhM9z
	iC0sgS65m/UMRgJ18+EnWVo1qQVaWAIBgxRB3DO+Rusmv6BnzKeQFZYkFlQKusUIu3dGuIhhJj2
	NHOWwD5uWqMS2YvZNLsuNb2Gl/JX56iqmV6Q==
X-Google-Smtp-Source: AGHT+IEsYpuKCxcTkA8jk0GtWL4UNm/KQc74RM599U6pQuabiThT7lxCazj2PKzyq5T1ntntU8gerQ==
X-Received: by 2002:a17:907:3f24:b0:b42:9840:eac1 with SMTP id a640c23a62f3a-b726553b597mr370430566b.49.1762360221599;
        Wed, 05 Nov 2025 08:30:21 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289335c6bsm313966b.7.2025.11.05.08.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:30:20 -0800 (PST)
Message-ID: <d77310d9-f865-45cf-90ae-ff542cd1140f@linaro.org>
Date: Wed, 5 Nov 2025 17:30:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/28] mtd: spinand: Convert vendor drivers to
 SPINAND_OP()
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-11-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-11-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 6:26 PM, Miquel Raynal wrote:
> This macro allows to silently switch bus interfaces, use it outside of
> the core in all places that can be trivially converted.
> 
> At this stage there is no functional change expected, until octal DTR
> support gets added.
> 

Shouldn't this be squashed to the previous patch?

