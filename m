Return-Path: <linux-kernel+bounces-859653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9C8BEE356
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 12:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2089E1899764
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80C628B4FD;
	Sun, 19 Oct 2025 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDvt/jRM"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126171DE4F1
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760870869; cv=none; b=r6cZV+lxFXnb9ZrPHmeUQQ+b58MRoz2AFpkTwVHB7tWANHXmjNMAE6yyck9LEle1kbkfya/7HRXdkWafbkknLpq25ybn25oua75+TF/sqllY2rq/cyT8ZSYTiUAFyT7+nVjaDI94zEzvRjwcHoDFlS/BJO1FUi6ZJl3i4q5CGqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760870869; c=relaxed/simple;
	bh=REx985NMgHQnMdh/NRAVcoQw79fdFUjctACYPyS+0U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFQ32XGnlDBF9pXsbtqHqxW3/HUtOc9YDC+Xb6EF+Qwz52xVO5+fA+xcGwPD9f8p0UPjCFLrwAVcWUith+yaHfxQSyg2M0MAtIwnyZyxMYNXI1RPEIpst96nDlwuM+h1Im2ff/o7ZZsgdSt0swIJLN1llRV9H7WBSC12/ehRFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UDvt/jRM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-427087ee59cso319307f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 03:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760870865; x=1761475665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TKy0oYjKv1uVdgBHMCpSS5PvqACXTHw0VxEjCM2j/us=;
        b=UDvt/jRMp1lQhfvou5s9a6HAq1g4VK/uvSmnJZrYKZXNhSjIzJMIdroOeHrj2ZO842
         WxZYcx1AS9bBa7M8cONsLrgn0rEcrOVyOdxHM8+Ss5XeY69dowKKglw88U/Im39x02/C
         NRcM/x+33aFmkLsmKDdtYcouMGLjYT6+STtLhwUApgbqpW5mqA/okJ0Zbki/aZg7rWaF
         RL+wfIJt66NMn5/Zlc4/PxrP/QTGwDl0LpYCL6n05uXS3CyP6COd9URN2rQYHf+6MOnF
         POALSUAyT1daYBsYDKDYxbW3jHABpaP1q1hmRybOBH2HpYDuejna/YhFfdLgEX2WgMHe
         Y9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760870865; x=1761475665;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKy0oYjKv1uVdgBHMCpSS5PvqACXTHw0VxEjCM2j/us=;
        b=V4grTEk2v9IWuD/FQ2lXhNFLzbTw5+GjvkXJil+nWx9OMqvuMT260vRB2H74Sihxvf
         vOXoUVwGebHaQSxDQs4fLBTd+B0O41j7juNbchK9TtfogpMQu0W0q7MX82Mfu3GJriuK
         3CMQf6MxtpKdwFFJnmTlNUv+sMKwmbkxKy+JxoZDezVa9PP7KZEPtP4V9i5hZx8Szfl9
         fwJJZlZs6ar59OrxhLBbrAS5653SVSb5Sbu2uWrXT/U9Xe0+RRfPpBt3oCvVGbxtjRF1
         x8I/AsvswRV7oBD07yaiRFQ2JmFsryIZZqXvigAvLIIJD6R1dpF1Expb67ZNiqyoia7z
         i6+A==
X-Gm-Message-State: AOJu0YyRqqULZXYWFlw9RS7uC9hgWzIYxXIv/vsC004hxGUgS3wO935C
	QTjnqeQwfCAacp6i/3cmSDaQxj4UH5OwvZ7QIAfi5TQB8th6FYsAR2C/XJO7kBJP/KA=
X-Gm-Gg: ASbGncvMIslRFXTHEu1uowUXISAC8ARLVMUuuAlSZDp4WfDW7Pbiuw7vRO9wwEawGAw
	4gFqV72WEBB81+Rtxlfea3WhXq6rl+3q8VuE8VUt986glqGtdAhRjiT+HBvt1tBky7CF0vKthbn
	OrONg9Df0TgVvimp7PCQh0Gv1kN95BqDDZ1nEoLza5uK3AWAUkcmCpgcS4Q4vWEshuR0Lu1g6tO
	fV82hswRY681ZDN42IbxisXirpkswEUbyrTeEGG/EWVc+qNG38v29JpeGYs4Fa7trUWaC2nxSTy
	eDcF6Ryy7CrkCcWYQTjsSTkVXQctGzlEksktIHO/HKjYXnswWK7xkrQaisMUeMvsH8sgWyMbRWw
	brbUtT4DnUVcdm1G5HOUQ3/Yi/z8rXvmvni84a46DuFWYdWj7C9+BNWGAfRkqFOjnoZoRNsAWqS
	TdtyeI+ytjClpMs6vm8tZZ
X-Google-Smtp-Source: AGHT+IGPLwCtaI/RDOyMS4uCSnOLtdIg2wIv7NLSi/vkXSQC6WJrG/ORHt6FDPt2Jd/F6bIraA2Meg==
X-Received: by 2002:a05:6000:26d1:b0:426:a87f:e8fc with SMTP id ffacd0b85a97d-42704caa860mr3579348f8f.0.1760870865211;
        Sun, 19 Oct 2025 03:47:45 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce678sm9889148f8f.51.2025.10.19.03.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 03:47:44 -0700 (PDT)
Message-ID: <fd1f4d5a-9422-4d28-b552-b435e20648b5@linaro.org>
Date: Sun, 19 Oct 2025 12:47:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: defconfig: Enable Qualcomm providers for
 SAR2130P QAR platform
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Stuebner <heiko@sntech.de>,
 Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-kernel@vger.kernel.org
References: <20251019100707.2077664-1-krishna.kurapati@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20251019100707.2077664-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/10/2025 12:07, Krishna Kurapati wrote:
> The Qualcomm SAR2130P QAR platform needs the global clock controller,
> interconnect provider and TLMM pinctrl in order to boot. Enable these
> as builtin, as they are needed in order to provide e.g. UART.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
> Changes in v2:
> Update commit text.
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

