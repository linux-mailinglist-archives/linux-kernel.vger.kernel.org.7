Return-Path: <linux-kernel+bounces-873046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D580C12E78
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D26D4E7B87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93C02248B0;
	Tue, 28 Oct 2025 05:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VdcZOc0D"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD11E5018
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627907; cv=none; b=rUhHR7Dp1j7+80xQMYuikoSajSX1bhidA1fUEfs6aIaZNMTsghmD3FZFErjqVGtp4bsDIDfVyunKTIydqGPCtOpWQFtqERC22rjNQykvBLmabNBJbZlfvJh7s5jO/Yf7q3vZfHJlICPPy3QLZeNmT6NOBuJtcRWQ11si+LVBr0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627907; c=relaxed/simple;
	bh=tPEtRdgT5AFqfrjmOByK1BhhX0vqZEFiVdNegX8W91c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/XhbrrABF3KLHUVSdWIvU6z7YytUNVml2atwI3k3kOECmbQklEWxbmrswKZb3z2mgaEI30VHYpDc1hGexcDlo3jFWFRJOaCQfAfVkZTnyH4QQOLfvV0mJtayGHmMBev2IecsUVxp9IrkA5LtkF9qM9vNueMZUTScLYhOAH0KUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VdcZOc0D; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6d6c11f39aso5770566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761627903; x=1762232703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AerQ8anahxAVq796epN6eN0GZqxQd097rK/3M9J0Tyc=;
        b=VdcZOc0D2149n4kWe4LZz5x+rE2pGHpMKec5O54ERiilRcaOlC6OxIYmdmIPmTjjcT
         3dWssd3lF62vMeo0k/NYx+JmDgvlIiuopOEGUD7WMY7Wi5bRq5f2/pdcpenR8pngwwGC
         CjraMeFqR6gqtwQO/XUbqRQ9m12rYvANQGM5sDwFyL2xlhka2kMoOvvH0bSs99c1Q1y+
         nFXMpkseoCaAuo5ZyiQx5bfZ8oU1DrzD6OtJ8KsWolDw53pZUPRQUDGRCGtTik1Ij/ov
         kdaVy94UOKQvC4++jAJ0dJ2f51m+TWGpZc9x9KscChRmGegooyro2oVc5LKqXUf3BJyj
         Ctrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761627903; x=1762232703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AerQ8anahxAVq796epN6eN0GZqxQd097rK/3M9J0Tyc=;
        b=NmPEQQNzCer0cB/mrnnuB9tZOmB5K1ALTdpTXei9EAa9WxU0XLXQV+Yr4uME6A5eH+
         IA2WxDMeVQotrCXJKFciXmGBSAdxV+RP4GTFYURxOdL9ktJrh2/0LI3cRM8C3DKu577A
         jIWAcvF8Cg3w2ZHapZcenmpXaZ9mdZysAS87+uIlcLIl7T0hDeJGBRc6eNJok8Kt/noR
         twiv7Rs1066Ogu7iMbDTGGCI68MQx7CsLvxcoyIzPQwoeRGaZPK51B7dmkS3GcUenkL/
         xeMg5knOzu9T9eHOqv9TWRup/NbbBrtAJRjeuu0Erk2vqEFbX60cHTgCLUT+D6lLxKe3
         Duiw==
X-Forwarded-Encrypted: i=1; AJvYcCVOM2Ypz6D/ArMy5vtDNiLunsT/3Wp8UQdhF7srBSNFEiAZoi9aXiUL930tvmd09bQXPeEJze8EgNViK44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJeAj9sg2fk+HtJC/ldykvdF9cib50HmTadrJMlNL5+Qkt8Eq
	sT3HR+WVbE2Ie48GuK4ZVMNXUY+M/bVcd8fS9LtqBkSEKM+YA87vXao=
X-Gm-Gg: ASbGncsCOBHWWs5uVKkziJGrlUe/5p0VEfCkRxAAdPs6UALKvIpiTrZuTRc71QkLrzX
	Vm5YdN7QeCuw4jIyw18GScuCmDChKasc0Z9oQowfmZTAlFS7CoDD9MH2yltzJDSDfpp/DcGY/gC
	Gbh+ZRvD0eUFrEt3TOvpFkJBBnSqAY7EuIIT8vpsFnB+XHZtpP+lQ/6IPZs53d2ZN9O96z21CVb
	R+37rr8DT8YN2MVvl9GvJs141Z+UScfFKbnNf0xPu24D1T8kOSg8SmQQeqMZ6meJyO+H5zB4sOl
	CYR7GVlOPqIMYGveko0ZYMMnDVNiuqo1GadcWqI4vNlhAN1a+THn2hxj2s+GchCs5gsekL8Kj42
	uzPmCUMKd8Wmuvoa3cPlj641DORqmb+WRC/mrAB9GT4mdnreRtB+b0/4dH+kHLZFqmb5GKZyyEb
	Ejcmr5UzjruYOYQV2//qMdpsV9xnqj/QrMCmb02COmQrNNPTbMjdY=
X-Google-Smtp-Source: AGHT+IG98gaKXDDq10+P2yRvMTbMWPbW2KU883vT9OMUrK2f2QHIOlAdmmMdyx3BlHiKzEtfl9tNlA==
X-Received: by 2002:a17:907:1c94:b0:b6d:505e:3d99 with SMTP id a640c23a62f3a-b6dba462958mr271070766b.12.1761627902710;
        Mon, 27 Oct 2025 22:05:02 -0700 (PDT)
Received: from [192.168.1.3] (p5b057a53.dip0.t-ipconnect.de. [91.5.122.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6dad195456sm424001266b.72.2025.10.27.22.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 22:05:02 -0700 (PDT)
Message-ID: <bd62fdc3-03a1-4125-808a-4b4ce839e0e9@googlemail.com>
Date: Tue, 28 Oct 2025 06:05:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251027183514.934710872@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.10.2025 um 19:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

