Return-Path: <linux-kernel+bounces-874814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44616C17279
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FAFC402C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78D33563C6;
	Tue, 28 Oct 2025 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="fs5EU/At"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95A0355814
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689487; cv=none; b=n1pv4LBrnQZkx4pWPGB9XPm+zUYryHkrLTIKjsyUaGUe7RYRcv7pU97RiaxkT2htRu89hsVk6tXjR/7eu3v60pfC7Nf7B+mlWFI04BoDA4qnTJky56MIhbcwEXsyqkfOYPd2IttjG4oUeP+fXARMFIXrJ00DbO4uz81cZdWWwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689487; c=relaxed/simple;
	bh=SajjjPU7ooHm9j1bcOZQP2p2t6mzMP8oH0w3pXmySUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jK7wx71avv/LC1/jpselcvZi2pWcA++K0QIvjlMENzo2x3x8Opf6vo/8pS932CryShw1E2e21G3cJu68Hr2H5itVvIERX0W0qO6oCA9URwUl5XXqti6dAfS8pMBFC8GQWvR1D6Szl/cGykgywDTYKv4Dr1/R9uavG8T+lSUu6+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=fs5EU/At; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4eb9fa69fb8so52795101cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1761689481; x=1762294281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtLU3JE9Y5OXHhXpJkKXkmYHPl8HTetY/QdDWBoDdO4=;
        b=fs5EU/Atf7os3gWp6MkTot8wLwUu+DoY+bmGhgvsI6muD31N0VIwfYaQwokNsi6a2j
         EW3weJkUahcXk06um4RNHsk8gxGDx8qxHNU+LPoc8EixeeKLG66oOyYeZXzGX4cY5uMn
         trtqFxLoQTWfwHwxfxEgWk6RyjN57JXxwKkLxCOHSfNXSRygPy32CtcwEMRwyKEzZpMH
         xSjMh4pOE6z7yJhESiEN3wB/fbOsjlKca1V4Zx7/iNUDQCP7riiY/QMDkVRoYxWWFI8O
         ewI4pinYvBxltiG1+eYayc+b3/na+kSw+cJkAubtRpRIwH+fvmmvSCodhucSaLkj+fw8
         cNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761689481; x=1762294281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtLU3JE9Y5OXHhXpJkKXkmYHPl8HTetY/QdDWBoDdO4=;
        b=rFq+xgOdN/0EjltmjKc4DL2oioY+MQi3+qXFwCjwBR3jf5zeYy04IBEk3uCuVky3h7
         b9pPqyP6LQvUHqtywUaEVsTWSpqoUmKa9V7NJb5cH+eW5Lr2xUGcfHlKWf19+aCvQ1ff
         WVuHi62XQJqc5ksUc+AB3RfaVMeLvtVirdPmYnMrPdkbNoO5wSTrBJbIhavkJ0Qq1bei
         C121aMsPRhqiy/8nAD1CIPtsGWmMe5iuqBkGSFSEuvYXp/LIENu5FbL/F55INOxY58/n
         bIUaQESG2jUUA+aJqmekfuUAEe9FEUJVJBDvauZYAgG5k1+9XFXpJtcyO1ibM9PTY1AM
         ymkg==
X-Forwarded-Encrypted: i=1; AJvYcCWVtbgfg0KifIrA05BBXcXMFncQ9edyP4r4YMbnzxVtpKDCkmzvRp6+ybn8tWDa2MpUWlvBAJ68JDCFo9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YycE0dSYXiHP7xmn3RNJeMQR0KHvADvMzKcDpQY8vUgHk/hxAtv
	3tLZghBJ34siCkiX99/lO5wkokk/WAgNpapQNDovXrNxXdq3gEoFPlEyJR7TsKBbzBXByzB6BYq
	+RZgi2Bg=
X-Gm-Gg: ASbGncvFO76z8IMQG3kL4Y7GlPoFm85R6Rui/FQ503miKpKSJjN3+PiW2kh31kaTPKv
	PB6Llym9rEASyPZywD7oYhxUxzt/iS4aqbdjlDWiacme6chpjt0EuoxVk+DzfWMemd8Kkn54ynG
	Rj1P3xLYshUpzNf8OcFAZRYVt2fk2V+I4Is6Oe6D89qdpVkNAnM1pa8oOtuIR40IQ22yX0pFa2n
	j2AkJ8sxJ8MAEBJ00HQV6cUgQuiKAp90kcEoNl/N/UufjDzqaklr5NatA+nC2X8ZX6+Qn+znG9R
	xgFw1XPzt+lKv3Wz/iKU4QKXzKZZ7YLyUOdgIgU4G/C5729poab9NWdbui92sgx0er8U/GOPJL7
	lXoGi19SL3VZAVY4U4bZtCM1xfk5abG/Eq+PAPA7LEKIql6E4TR00xAc/onw9mksbEANjMtBfD4
	KoxpPWzHdYn78+7U/bWpolEhs0
X-Google-Smtp-Source: AGHT+IH8IqWGuZZlKiFkTKML7svZTrrSeVNnrFoedT23cSoLdRm4s4MqFN2yRRflIL9ChyeaLS53ow==
X-Received: by 2002:a05:622a:1f85:b0:4ed:c7f:c744 with SMTP id d75a77b69052e-4ed15bcbfd6mr13483461cf.42.1761689480630;
        Tue, 28 Oct 2025 15:11:20 -0700 (PDT)
Received: from [10.10.13.73] ([76.76.25.10])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25a8c492sm914103085a.41.2025.10.28.15.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:11:19 -0700 (PDT)
Message-ID: <da504bf7-c9a5-4a29-9404-6aff5a7cda75@sladewatkins.com>
Date: Tue, 28 Oct 2025 18:11:18 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/84] 6.6.115-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251027183438.817309828@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251027183438.817309828@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 2:35 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.115 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.


6.6.115-rc1 built and run on x86_64 test system with no errors or
regressions:
Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

