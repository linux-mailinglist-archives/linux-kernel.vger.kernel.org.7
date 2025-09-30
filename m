Return-Path: <linux-kernel+bounces-837960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72592BAE212
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71413B2594
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A98830AD1F;
	Tue, 30 Sep 2025 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAFfFga9"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FEB309F1D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251972; cv=none; b=LIiGLfbQxXsgaraOJ+ji1nIj71N40pwyJWINqjJ/48m6MJEe1xTN6uJ4e7o/HN6FLYXEdh8kUS+0wimX6H9/RrRkzobthVz9je77xO+5P2YAFcsAMAE8leo1aLVWxtS4/9f5nlAYahW5YFVgLloB8mSx8upxCKrDiNAGOWZLbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251972; c=relaxed/simple;
	bh=z0OeE8KKG8p4YUEXLYKNB265pXE5/l7+L7QRs6INbAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yvcs5aC2TIAMdLvE6Iv26Q5zPa0AOm6ABhsPuBUDZ/4M2ReC2H/oBDFpWwmChgBFrcW10hLEecNWKnE+lvrRpDJAI5ngq8Ic6CQg2g0qNDC55Wb8bgIL/btCnFzPVBC6DUw1ZfCyfO06/HLHymqVmhBDnoPQacwWqnQNjucnbxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAFfFga9; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8209dfef9c7so1069996d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759251969; x=1759856769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYca6WxwMn8N7DVnp/rlZBC4kI148ITA0or7jK+Xv0Q=;
        b=nAFfFga9+QFeev9Asg6weKzvt7V6n+StM2zKnIDFPKsI5fjLNGEzTnTN/Tkgqr8iRy
         z+Z6F1a9L2MRLH69j4v8YeMSG6T4jiYRf+Xk1w7pSKOFIk18+hag+THqBa4O35Mo925H
         U2KK4oasGNw5QZkYBYJ2aegkrcd48lgdPCCvT7o78g/lfmd6bMANR8U5v4e3tCuLlwdh
         ETk9/IqSrO4BpTh4wtbujcCqZbHZ3pM4FHcAIO0HtFRL62INiUUZK+6ilg46NN/LFn/g
         Bh/9lchFzYgoL/7GlcVa+MwgfiiaXVh08NabltizqyuglmrXQjrAB2ROCmQ+wtgoxTzr
         fPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759251969; x=1759856769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYca6WxwMn8N7DVnp/rlZBC4kI148ITA0or7jK+Xv0Q=;
        b=kK+cVVn0CAtckFWtwUcXeJ2flsC+Udu+zx7nKE4gz1nlO59uRo4rU9U1/hJ7n50oOx
         5SOLQwjbJVCCAMdXwVwt6BdvaD3gQA8W00TuX0LCVcJSuekkmfARqKa85s24qT0NHFmd
         7UFPC1feQrXOuVMPp4hZBQ0AWotIBIy0iiZT0qyWVDCgl1H85mI0rhYPVh1WEsISxEad
         jtrwZ+0sdMLbL0hlGcH7QZ9ZJSVEv+RaqEhALWZaSha8c4DHVeMO/4KedXI/q6/IEgwv
         P1FCFMAYSuf74g13Ve8p4nxkhOd6u41cNjQM2kJzdYrdPJ12BtAE0DcyJcRh6tu0anA/
         J7ng==
X-Forwarded-Encrypted: i=1; AJvYcCUsmG1EmAiR41giQhhZ2Wz83nUeQ86XcI4i19qniMVB6coqcp8cIXTqP9WQP2mckCUVlrrZ14UjzlE+MzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMhWYpkwf7McHrpquo5JUyXqKwrsEYDkKyj5tLINeii1kfnFc
	41MJHnojTRxOq/uFYm5Y4lJY2DVE8g7z7HWNSI4cfyn/I/JPGAantzyr
X-Gm-Gg: ASbGncs0kfnQtj7QJEI5ub3RCXuHVBPael4fjyrcQup05BlUIt0xaXLGIExCWh8v72q
	gHsha3pYPzkxAXMznTnQTFmhcJn1DVZXUgjoYm6daGzarqcifKqRsPH3t8V4zImcoODAhweu2Dn
	eKWhDNiAfNCJYOioS0Ewn9Azasn+shgtsr7ozxYOXQ1GnG5RIu4g+ru9Q745/7EaiRYAm3aKLMZ
	nXImcJeBm2S8aWEBB8Nk4wQmg5dZt1Yi9696qA5dkx+qAs8K2mFLEVk+c5EB9qukMAajSgxq22j
	O6NM2K7rC5dUnjLK9oWKnMQ3Gnz0Y6hMqkR3/XhFJJVP4IpZ4LtXgByDUff19V4T8xSGUH8jZfG
	9PQisck+YeLtc/FTH4lGcaAk4tCBBBW/gdTL0uK7onnbQ6UyPNf80Mdrf+80yAaPp2c9MEh45q6
	nUwV3YNmt+
X-Google-Smtp-Source: AGHT+IF4D6Nsl38GnCXyOtksgIhWMh1L+lM9odVVJFrjIv/5VTtQCbZa7dmUDr1LBiNm7pc7h/TPoQ==
X-Received: by 2002:a05:6214:cac:b0:70d:ba79:251e with SMTP id 6a1803df08f44-86997d2ada7mr64406166d6.13.1759251968994;
        Tue, 30 Sep 2025 10:06:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135b54636sm98871316d6.6.2025.09.30.10.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 10:06:07 -0700 (PDT)
Message-ID: <b1e7efb7-ff4c-486e-9f27-1e5b26d4b044@gmail.com>
Date: Tue, 30 Sep 2025 10:06:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/81] 5.4.300-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143819.654157320@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250930143819.654157320@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 07:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.300 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.300-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

