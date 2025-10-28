Return-Path: <linux-kernel+bounces-874145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F96BC159D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C3E1C2219F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCC6345727;
	Tue, 28 Oct 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHThKcag"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6D34320A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666438; cv=none; b=iOxgSzp1dX2qKiuOQKsSe16dHf6gCUp+Np2y/dzWpDWEt/g7yzk55Ua6DvhC6kQDjVu0LkPzwIzC07TuOsJPbcEqVRmfoQ9QAN3f23fcM04+ztQ/ZAO6MGr2DCcWLm07nz4iqexARYnOVRZd5x2mXWuH9q0uZ7WkQR1+FXzWDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666438; c=relaxed/simple;
	bh=9Y6cuup2ygOkn1D+mhXdhwDZmH2FNUNmnj6uiwVUQJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxAoCXkYFaZB490G5G5YswvL4jamLODpdgv6bJBnBf0Lm3BzvY9w/Duq+rVaoFqixtjA8HW9JvFV9D4eNIKePAYhmBWdedX5l5hMw0c8p9quK8owlz+SumrDzn8TCxEGxfo2Lfb5xJF9IEMg/8NYWD0AmINgimQTG1CQxm5sR3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tHThKcag; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4710c507f47so1927995e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761666434; x=1762271234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly7igO6UUojvT0L2mrFQ2G8pxDYiFWGNFbACO3M5+Qg=;
        b=tHThKcagI7Z0p3EP2uB3JS0FBrV7N7EWFzN63OFRRCX6WKJaUukWynvT+ySRj6FZ8Y
         pPLPCp81oUko4KJy/GDd7uwhtcIb2k6dWyb/62DYcythxCcVI73UFyOqIL3cQahUcSqP
         V+m0R0CZS5f0Ae51X9AGGgzvgd+Mf01TPadcS5djDXjj9TW96mC9Lon9Ls7p2UiLFTIH
         DKWfl1+oOq1J5BsdpqFjqhCQN3wmxQ3+NMHFWSlsTFXQ5d76/ZizniaHaO72Fj81ZJN3
         N6zdXqBogJ0DIkaelcMVSHJ8YBKE9RGyUqS3w2PZkUWLyWAct9Xnah1X4b6E7846sd/a
         spsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666434; x=1762271234;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ly7igO6UUojvT0L2mrFQ2G8pxDYiFWGNFbACO3M5+Qg=;
        b=lp7QEXMPJvWplKkzWFtm7RyUeypSLT7t5zv94yi7OtOHFBmVWD7VNomGGTFEyxve0c
         EFmToyILR3XRx0ADWKsxH0j2Vn9mnAawQW1LisLQIdiYVy+YbVIrRMa2C8giYHqMSUQR
         ZYOMZ6VjseqHoadrCUcB1NsY33JZG5BP/CoyQK1r+Qse9yo3SZRef875WBc/2Xcnn5uT
         PLmrkJHnA6uOj5JZsJAxjlF8HY43QCSdXG+v48b6SEm6wV0lvyUTNlbucIbzFvaJ9Kl4
         rjyuTlM9HloHPMDSsQRhrDpwvPmnl9t5zgjDLpffoBF5qEx1QwA+jpEaFMKfD5H5wpuI
         tpDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqawgYtOq3bV+8w5Rc84krf6S+kvuCUX4IIRXcD0jdTRWPYJBgw89WjsGpN9/zEu5S9+TUFaS+vALP5nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLMLCCBJ1cOiuNYO6s+jbjwU7TPEJbnUqcl0B8CPr1Le22dt8
	MjSrWPqw+SYXnRjzKeNrBjdADVxzBiQ0v+SusRrt6AxTyDIpDTaTneR/hBuXdBJ+//g=
X-Gm-Gg: ASbGnct4m55BkcV3iZ6vo9sb0eHt8SOMfUmM/BbvWRXfT9L7uQnZtsW/2gOXi8M0s+3
	k786AKTAl55oTi3UcniT/9l6iVOyElVv2EwO+cZj356x925lJghWonfWGd9swb1dulL24G68NdB
	uto0X2QUbUKSBxsw2jAhTPmhRicY1h0U5fhjLPp8uhEdT8DuJ5hgTbTc5UCl7ztnivuizqcl2av
	givWqonTeLdFA9GLR4T8ruDidplGDV1gclxaLcP+uYFhte/ddomvmY38dYiQMWOb5v6xGwjvoCC
	8pGEkAv2I3h6fgzbVYoYVhd+4ocRWTJd+FvN+MQ/rn7zp6nOvvfuo2BGlzceXDKC82VqKl8xUVh
	tq82YjYVCqualCWMsJ/ZwSgJH7nkRo0sWgXIK87wU6VaTF5NiFo+Z5soPiLGlWJ0XHzoo9nS8It
	6PeWk5ukRrPOeu1YcKu6PS
X-Google-Smtp-Source: AGHT+IGKgXwlOvIehOvpFN7gEcO/B/7FmJXLc3na7usvqcT8HRKr9yeuOhth8NNWw1FimUvqgwzEIw==
X-Received: by 2002:a05:600c:3513:b0:475:dca0:d457 with SMTP id 5b1f17b1804b1-47717e7f4b9mr18168985e9.8.1761666434496;
        Tue, 28 Oct 2025 08:47:14 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475de57b156sm192684785e9.13.2025.10.28.08.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 08:47:13 -0700 (PDT)
Message-ID: <bd5bb1f2-a8ba-4828-9d04-2e1d433ecadb@linaro.org>
Date: Tue, 28 Oct 2025 16:47:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] Bluetooth: MAINTAINERS: Orphan Qualcomm hci_qca
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Rocky Liao <quic_rjliao@quicinc.com>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org>
 <20251028-dt-bindings-qcom-bluetooth-v1-1-524a978e3cda@linaro.org>
 <CAMRc=MdqAATOcDPhd=u0vOb8nLxSRd7N8rLGLO8F5Ywq3+=JCw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <CAMRc=MdqAATOcDPhd=u0vOb8nLxSRd7N8rLGLO8F5Ywq3+=JCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/10/2025 16:43, Bartosz Golaszewski wrote:
> On Tue, Oct 28, 2025 at 4:33 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> There are no maintainers of Qualcomm hci_qca Bluetooth driver, so make
>> it explicit that driver was orphaned and no one cares to keep it
>> maintained.  That's also indication for future removal from the Linux
>> kernel.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8abdc0e50699..be637b9dc7c0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21146,7 +21146,7 @@ F:      drivers/net/wwan/qcom_bam_dmux.c
>>
>>  QUALCOMM BLUETOOTH DRIVER
>>  L:     linux-arm-msm@vger.kernel.org
>> -S:     Maintained
>> +S:     Orphan
>>  F:     drivers/bluetooth/btqca.[ch]
>>  F:     drivers/bluetooth/btqcomsmd.c
>>  F:     drivers/bluetooth/hci_qca.c
>>
>> --
>> 2.48.1
>>
>>
> 
> Actually, I added that entry so that the arm-msm list can get Cc'ed on

Ahaha, nice :)

> patches. The fact it didn't use to, caused some regressions. I have

It also points out that drivers do not have a maintainer.

> done some work on it, so I can take it over as maintainer.
Sure, I'll send separate patch for that replacing this one. Shall I add
you to the bindings as well? All or only some?

Best regards,
Krzysztof

