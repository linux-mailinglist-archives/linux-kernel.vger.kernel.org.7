Return-Path: <linux-kernel+bounces-880987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EC5C27220
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4407F428712
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250142F0C68;
	Fri, 31 Oct 2025 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f4pFgS7v"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D622DBF76
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761950165; cv=none; b=GszM4H/uK6qbqlsBd56JjAgK858wgabx3JqLONswlw8e1g1facxLpRVAajf7WRB/gjdAq1QfLoDZ04bV1VDXCRjnNmZKme1Y4KnPPEm5H3XyyeiAtf2etfEkflhq7jo2mDhvu8tngFrpGisrnDhpiIN5oE5ZQv/cJEQc6+6Yycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761950165; c=relaxed/simple;
	bh=0tVzFNaHEgPaz0CZFVVHB80gUFRmJ483D/NF8VfZ8Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mylBjcfVvilLMimkEUZ/px9URbNrQW8bLHFPnOSuJkdj0J1JFmcXIN5L2VT1XqWs0yZPBQLpuxg+8f6Vv2/nq77fgyeVqZYZ1zEVwHPdP3L7GhJpn2QQD0jdwqnXzxnPnMFXpIdSRwoUux1FxjK6Zr2Ce8EQO/p6WRZICFw4obU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f4pFgS7v; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-945a4bfd8c6so237936039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761950163; x=1762554963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJjxAMRCSSyp0uaLlfSkXfbuT3Ybs5HEdO2ce/3JrAo=;
        b=f4pFgS7vZLqXTCX8l0GPvNh74SZx64byTH3tT0J799EoKBkekpMDGVyivYmcJ9GRNx
         zkxGO9Yja9835fejW9+80ZFRZNOGDW8r3SKnodySHiyhL9Bs3znnbFauXT6B/vB2HsXU
         DgwJmYr2PdXCPgZpD+IZg05946qR8xp19NuBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761950163; x=1762554963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJjxAMRCSSyp0uaLlfSkXfbuT3Ybs5HEdO2ce/3JrAo=;
        b=viE3pHg7RyFjpRQJqmXCJLTij1cyyYS4KQ3dJ+h2hyAMnBxhUuGGb8bV80MVBRP3vq
         afGD6to3p0YFdQo9vqt2Fco9uPqYZxVG2x/vqg1aaq3SwgNzgM63dosrxhFtC/huoebN
         rr0UaBNmjt2/9w21ve3jce5paLULBwGL+rtLmCvrQ21gRXsVqfAAb4qzRi2GSr9WEHIA
         J6a9CC0dwWeJcUql8dPwqP5k4vyDp0rGbFTiYCjB7WSfiadlgxdNgVEv0R+KSL880upm
         Jir1gpEPo/dtZ66QRcEmCdEW0df68AtQlEcrqqgSOEO9WAF5F2+0r4S9iHJY+lQnQjIQ
         E9Pg==
X-Forwarded-Encrypted: i=1; AJvYcCW8ELgtvfPnUiFoioYTHr/liIbqUAB8HB4Od539mivIlUDmM5pNPFjj24UcMutJrZShcmRQSQ3sjI5SbcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhto91e4wJw4Fff3G26oKn9XJtxyMcyImKUcRNkSRwQM1ziP6
	gXVj22a/7Umii5XvBUPKNJnh6RVCCg5AlKIFF0I+0Er85zDxKlLsG3Khx1cms1IkVxs=
X-Gm-Gg: ASbGncvmQ/IHpNy8WGM8YJYjVMWfuZmjctnO+lVYn9tvfoQTUl6bP8QOAh2ZaUXyBYS
	SkIz5jInwwvvUSsjrR4aF/fOIUqJFjouYz9tNAN3Qf43Y4vjJ1AV0WOycz/W2OUMvc9UNIyQcxK
	k6lkqfSDaQbkIMaPip/m/Pn88MNsQcdHgUhz7Tdjo8OrQ9RFw9U4X1GKeL7nDF4/Qt85/ORp8oQ
	T5x75evPcrS8lChsqvxv0C92OnFmqmLpI1saZAA9UNqYB8bOFfAu8pcG1ouvxvyMvqDGdH3Oz7c
	RD3aV2LOY+CvtinUKoazbecMH88lfgKgHKCeP6GYqZya9werSoU0Jby6Y6XHW+21/GQNPxCC1WK
	kiK22/sxk2tF+fkNkSegVOP6rzEK5zDZVtU+FFy/Koo+CQ3cc5h/0vZzsehU3+OVlUnbHcpDDFN
	MHDCol4o4KVkv5
X-Google-Smtp-Source: AGHT+IHpp2jrTbLgg0/IEW8inYD+D6jhXRJdiw9OAuvNttZoQnFgqxt14vowND5GNwRc9wQwEHi3bA==
X-Received: by 2002:a05:6602:2b83:b0:943:5c52:f802 with SMTP id ca18e2360f4ac-948227e6a14mr838664839f.0.1761950162944;
        Fri, 31 Oct 2025 15:36:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94827baf909sm96079639f.8.2025.10.31.15.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 15:36:02 -0700 (PDT)
Message-ID: <7e1582d1-4d1c-45cb-86a2-70de0161d735@linuxfoundation.org>
Date: Fri, 31 Oct 2025 16:35:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251031140043.939381518@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 08:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.57-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

