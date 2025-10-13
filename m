Return-Path: <linux-kernel+bounces-851075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB8BBD57A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632E2406EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49F2C0F78;
	Mon, 13 Oct 2025 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHLQscY2"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F42989A2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375385; cv=none; b=tFQcJzzNlE8odSz9Z/Baa7RtwZsdXE/MeFmLqI7M9l43zxRBT3xw54jmIyOl124ino3rnSthQLDwma+jdJTkNH+mo4xVJnMwJnfJMVEPURCmGPcXdpZ8BJs9LQOQplGM9hE5UkK49EytDbEb7dmogDKJdZ+sYBXv924SFyJRpcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375385; c=relaxed/simple;
	bh=9u0qMy/Cq9gqm/KPJ3Ei6I8Bl+VxQM9WS7DtgkWaO50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uClStXrrPejmqelixm5VxPEHVM36KQi9iHtFvpGaB8m/Y83FD9TvrYc3QuEk0TRFKuLMfmZSfyIU5l47Zs6pnjr5pjHeMhbKe0yMS3Yihm2igc5gxSWC+hJIP32Z1+3PPtKI1TEp+O6oOUrmPuS1/ZvthOjWHyd0idfLmSQVxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHLQscY2; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8572d7b2457so672256085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760375382; x=1760980182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zq9D0oiH0XGev2bvZJNS+y4TMnPelGliSASbJ0U8VMY=;
        b=lHLQscY2jSPd6VKhZSx1pFzuEv7MuQQCCj9YK8FJYsrohv5LcFXGQAVcm0YlwU7cmA
         KLzrnflWZNoAhnGC1Qa6lS8wWVQh5dVG0zrModFqiFKhsWhTc/Q3Nsu79ce9R2HRHrXg
         29BGDk7lWrcN/IT0Pn1v8BZBnTNXjeKj4EpOxEdE1iNJxkJTbXK8Nq6xvgUdl6yAJQqt
         ohBGRLG8353+97rIpQZMlmIJdHlgy0QSMkdf57NOBZAGbBj02X1sapKTJZvbmP4AH7aK
         sC0UqviytEeVyxTt+yIR+AtQbUNoLq2zZZlrzNxx63piIlo/JZNKdddwYJ3RjzQu8s72
         i4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760375382; x=1760980182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq9D0oiH0XGev2bvZJNS+y4TMnPelGliSASbJ0U8VMY=;
        b=tI58WXEaZGb8eGcAneyEOhiW8DmBj9USEd3TPWLFT7rTThvgEumEXU4pzae0tw2Yca
         xyNOroL03gMxhcCgN0SaIBFCy7Hqe0LnJzd3pD4CHS/X/XzYf1FThQrckuaNVaeco+J7
         n6SeMr04D9V6pxdc62VaCp6nGaVVshaoxC2iiqXGsKbpWVhHvThvTpsx9DxWsFfv+gx9
         BQmJ/v9wGBrDAkFcN9WFu7nw8zJJtj7RMWYzWUglhJ+E0jVf8VeQlysSDFk/QSqnbxS7
         7rzAkygPCmToOfQsl9e21BAVB7dlN8NMr5th/xMKI+VrrwtbEAhjN/8SxTREXBAVTzaZ
         RVUQ==
X-Forwarded-Encrypted: i=1; AJvYcCULYeRUxJx50ofx/zw9e4RWW+i1IvfFfJAWI1s5QEMIqFv/5V9h8B19Teomnbi3iXG/IKfZHa7SffRDO70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuRzcz4zriN11R+OoEoW/CHKTHcYiUyVTU8M5oiJ7SpoHWNuMV
	n+1YDmTaexvi4QmNAr0CsCiP6Jd3ez9v6OmyKoxH4WpWZ0S6pGW0xHwi
X-Gm-Gg: ASbGncs4jn0WoA/AzpKKwJLcRHwKpnxD0BdHwpcvXnJmlX7uxKpR4TeBshMc+/92IAv
	LvbeJJBpzBAGyTn12gOz2m8Tki5KV4+ZjzlfLdFT/GL1OT7zrGdORSGnOyor4AvpoXkXm5K2fMt
	k0PUKo2Dq/JKI6aXevo1Vdc01K5mZ2wNGlaozrMU4ISvVM++a4UXmf/5IrP1/ePvTjZNpCpVG6d
	wVcsYG4w1ajOZiwEEiq7Y42KkTN3Vi901fPQaSvDZirR2G9b0f14fKoimOdP1d13WMf2wX8CMPy
	BjtuTQ0Sr3gpsfmLmvpxuy09ynrtIp+LRionx/iP58qS1vQw36GaFC4IFiLaYi7qbKAYN5rwm6a
	So95oijeR3A8sr69dDPtqbmCYSbtf42OIyqSfHoE3zj6oSIlPS1xMEjzhiThzYf/cMJ6C
X-Google-Smtp-Source: AGHT+IH+yeZp4fthmE6bMZB75N7lU2V9amhOgMmYrKXlYcGZT8jtMuHVCUKmGe6PAoHqnGK3ukeXPA==
X-Received: by 2002:a05:620a:1927:b0:87d:9a55:7566 with SMTP id af79cd13be357-8820cbc5160mr3723625285a.28.1760375382268;
        Mon, 13 Oct 2025 10:09:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f3d862csm1029109385a.10.2025.10.13.10.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 10:09:41 -0700 (PDT)
Message-ID: <8bf9a72e-759b-4c98-ab11-6c31461db7f6@gmail.com>
Date: Mon, 13 Oct 2025 10:09:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144411.274874080@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 07:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

