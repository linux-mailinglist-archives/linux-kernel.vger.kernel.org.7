Return-Path: <linux-kernel+bounces-874572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA5DC169B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EB91356905
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1909334EEEE;
	Tue, 28 Oct 2025 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AJrQeof2"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D137725784E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679598; cv=none; b=Fh/QN04pnT1IhOqLFRCGUKXe2jRN+ZVty3oPWgwW7NMJlX5ysS8rXeP706TyixcIkWcmzRkQdeQjWmbWvmZgUo5x2kAhqQOMWGm4bOUJwTnLED7LzIMmdJk99R8aoAGKxMxu0sz5Sx41ofVoq/bkkVwGcsbD+GZpY7DsctXe2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679598; c=relaxed/simple;
	bh=fWAjrSl5wuz9CHN+jSQpndkryTRrBFNBMsQjYdVo/hE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i30GzQScuYVn1Z9dXW/4zeaqbhr7iDjOc0zpg7y0JnqnoN9dl9TsMABaog47A1UdJfY9wYg7RYC32mJYje8gizJzZHS2a6le2BX5w7ps8d0pNi6fmOIQRjjGU5k0yUSVG8apNkbjignJXGIec69d6rKtK/6lMxzRdpHrQEwHr6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AJrQeof2; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-93e89a59d68so279733339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761679596; x=1762284396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IvIkf55LIrjeya275ZJh6F0vpAd8aXk2EAO0zzJPoo=;
        b=AJrQeof2DUOI38hFlPaZSw+eZeddZWxoSw6FB9Ge/Lk5vTp7fSoiGSvaljJjsWKYew
         390ev8wLYqVrhtCf9ZMWz0ZLfbI+nFub6ecNwxR84DXeHl9RzwYT7DSg8zMF69fHDPYl
         za3NKdy3SI5ZAbfNUbRE7J62f1VgMyI5Ze74M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679596; x=1762284396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IvIkf55LIrjeya275ZJh6F0vpAd8aXk2EAO0zzJPoo=;
        b=ED3MTu9Y4pDb9Ynuc2hrvhRqyELon0HX7hU3rIszaXaGFCgm/Pnw40ITQtcBuybnWM
         cUoVKwTUZNhrR5ysuMUAEfzLzRCWnqmSaJflOJXctB3ABiKLYnPr1yuvLBOmeQ9a/0mZ
         3k5KclxFDXqF7UGcvR4ldlC5Ut/KX3QFrE5LSOvdxn1jtu73vnsAszN1BYefH2vB8Q++
         qwQKfh6+2JMpjEzpiI+hLDrmdT2m84qfb5h6LnUQAoWXub79VhHXxkAMQwd0fLtpmFOg
         hCru+9ZUU0anr4MQsRTgra7eVjST+T0o2G8xn4O0GhMSRcEC17P1ofLZ0eL2+vjvzmED
         UcIg==
X-Forwarded-Encrypted: i=1; AJvYcCVNh2diH3VqV1CnyFLNmpz9D8rvtzz1czGqofkeFANSVKhAWEIjWEHjLgb/c6b2B6RJUUkIQ8QPIdPHvlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zbqW/70pwV/jricK1MfmWiI2IUrPqJcrjTFfGrXHXyrFEYUd
	1FZrUIiW3Fb+pY223WdbHpjfufaEtnTjkfnAsi6M8P+j6Hsx4tkJv57RbwjRoak0VjY=
X-Gm-Gg: ASbGncsrHYmxoQDP5EJv4CPxf1HAZdgsyv+CzgrSlYUwzq9d1LvJ90OCNIDDj92remv
	88MlaOi0pzU9a1fXqUpZuz7VQn9pL81EU8XyBwnLPg5ba5TQyLv8ioLoFBUp6QRFO5yWeaitQPG
	KMUPDzDWmBj0SUdTeGjkAtsfU+bnCzh5iCpPvwDaAOHAD7qZNEfj4spcGM/Uut9M9k+rkMV454X
	5uBahA2GcXrS1o1dI3LRJBdIQScrXaHL6VBgxqvd5LiWYnGVJgR9zWp0L6jMIfHmcRiUWDuSPzW
	Xl3hjRiS0o4qb3O2IRMwjr+gtq5JR1OoKo5ljAMXdeEiaNNBKVkvILV8zYwKgle3Dt7dlG2pW6q
	dEbx5hbWSG4vF11sCW6tVv9vInlHIdnIr7LT52rwK69uRx0ZxcFHxDK80EjdwPYH/SFgwcxq5Kv
	AxWxlyxXBz/KDK
X-Google-Smtp-Source: AGHT+IHOET22zbNd3s2CTpWwK2kftebS+p9x9Q9Rf3shDPSfh25G9Z4MDAp3rBcc8BbD8E0w77JeMw==
X-Received: by 2002:a05:6e02:3a0c:b0:42e:7a9d:f5ff with SMTP id e9e14a558f8ab-432f8fac74dmr6310995ab.11.1761679595937;
        Tue, 28 Oct 2025 12:26:35 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea995d2besm4673940173.48.2025.10.28.12.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:26:35 -0700 (PDT)
Message-ID: <cd84d078-53bc-414e-a879-dcf3a10bb179@linuxfoundation.org>
Date: Tue, 28 Oct 2025 13:26:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/157] 6.1.158-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251027183501.227243846@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251027183501.227243846@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 12:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.158 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.158-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

