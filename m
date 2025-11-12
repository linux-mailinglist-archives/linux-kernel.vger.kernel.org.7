Return-Path: <linux-kernel+bounces-898145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC7C5477B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 513BE4F585E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D112C11CA;
	Wed, 12 Nov 2025 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2sJPzY5"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C52D29BD94
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979253; cv=none; b=k4lYIk5XB5JPfBEBihBAQFszuunrTkU5DyZ6qkuE45CX6tPGjXvQBIRA8eC7W7letoGcjM2+Pr6vrDtMaYswISX3BtMzr83Qif5YzwF6/BREurffBu9HGVsmQkdH79KmGdQ+nZ9FSWiIW1NijyxvIX5HRKAGcV/GIOACLfU9kco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979253; c=relaxed/simple;
	bh=7q1Akm6G1W0g/IxIpcjEst+vGH/xiknusbk3UIlJLfg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KdMc/6bRnb4LAYFaKb2HaLjWQNqwN5OvhUqeJy4DlxSnnclpIXrWJd/Wu/P4fe/lUevo+xc+UUWeK0icW58PjigvBA9qaCN66G6BjmyUROqJAgguq6UlR2Hwt0pMggz+ZzlFbfoOiNIclZxpxHcAoETO8Qwk2F+tY+ATtRmQaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2sJPzY5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so32528b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762979251; x=1763584051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oLIWcbWTGCm6uL0osnPTfQ+TcowsSwsqY0w+FwgzNBQ=;
        b=A2sJPzY5OUDgKQl3ORpGIaZPcEhoj6LpAln9+Di9dF4kONkczSBQHih113qARjoOkX
         566O4GHhuaeLSS6qs9Uc0pdu8Rmvu1rGz9kFjE9AqRBOTIfJ6ax8aLZLpntWMcINi8Ff
         D5V/cBFqWQXOh26geiuCvhyFP5D1KmEFXsw43p/dMwd/A7lZ2m/3rvEbnZ3eJYoVq3KG
         TLEVQ8oisQjbgzNBshcDBM2y219AaFJOyMXm62obVgwnuBKWylMpHsh84qjz5Oef5/Rz
         1uKIAu1C5fCZegns6iFFSQJoRYcGhpiwtdPNNmXmlv8b8zoz38QKjJMhMvwdNi/cNbM4
         qT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762979251; x=1763584051;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLIWcbWTGCm6uL0osnPTfQ+TcowsSwsqY0w+FwgzNBQ=;
        b=OQABQqBtqMbbYEU1ahQVorZ3bCzWJNJQm74Z4bd2BO9tBQBxLkVv71f9yY+qoxeAgr
         wxyqyXQ99LAVbOmS5RVn8bHy+0Zq9Q0XHoL0CdKQT6ID9a3ZvC0tgkUGHndHkW1Cfjz3
         iGJOUOI6YyRil4k/8hub8UyxR2L/hNeeDn4I+7oKN8uH0lgDo8X42uHWmu2/x7zGwdHp
         XynanNfEU7eMJ7G+0WsqdMuJZDG64MF6H2aR/bBEjDmFgm1fUkcJdPLRX1Y3dKWCJPYN
         oNh1GtEOfkC23Jvl5ZbAM/o579dByQ+hVHSpqQet+z3eO1Zh589YH0c4XFBAcxMFdxoo
         VQdw==
X-Forwarded-Encrypted: i=1; AJvYcCWOVJUNXsJ2gIxcUIKPBOXdIWoie14yOliN6bMfVzY+l9hqLtgH1BuGBpa7sV/U0U/pWfWXCkre8qq1tQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EGdsyWxdlaP3kbsDlWxUYxMELdhTFTqQsRloxr4AlELpGa+y
	ifSLfjTBUZL3KHUVhuaNRzVDT+8TLBlUNYnOfISNjYj9fz9HbnW8XD5O
X-Gm-Gg: ASbGncsqghtq4CX+phMcXYG4u55XXrARBK5nA5AKmxP+q6bx8VmtJVm6Jtt2F6dF+bQ
	iY79uekqqd2egGFD402WrwcIzdVoSmKw0TX1G6ips+guOIWfFGrf3Ip9TWLhZ3znQlSIiionaG/
	dVQPL10n4EPn3Tl8nX0uGd7M73/E1SEDtm3dNmjtbNL3IT2H7fxAwS8+afQ2PhsUyyGuj5857lq
	YtO/JD/rTez5GSnh8/sl/ifzpkMzQ3zrp/IJXKwA2u5GfEtMzsCvUpIMuRD9qKx8ZBakTlhCpti
	N1b+qyECPCZENhycLeuiB/w4TGgBjMKpjsSg8mJcKVUxSUwonOxHRz08aBpiUqzFDNJ+DzNkKDH
	nusxw9mKE2xY1rtA0v7BqLBdNzJTH+7ohZmlVLCZWxDuZVoZSFAP8woqPnPb2nw3lrWX+JytoCj
	Oxr8W49yL0k5IYSR7lEcbemstngMg=
X-Google-Smtp-Source: AGHT+IEqazzqkIX3gYmP/DkKutcz0SRgO/dq+RYXdbMvGVvreBofbtZHJyjGdltxbX5JSPzLOyM0Pw==
X-Received: by 2002:a05:6a00:2e27:b0:7ac:78d6:5f00 with SMTP id d2e1a72fcca58-7b7a59979f8mr5096934b3a.31.1762979251264;
        Wed, 12 Nov 2025 12:27:31 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a688sm19823767b3a.40.2025.11.12.12.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:27:30 -0800 (PST)
Message-ID: <c3b7ce6f-aa06-432a-bbf6-abe6e1bb552b@gmail.com>
Date: Wed, 12 Nov 2025 12:27:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251111012348.571643096@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2025 5:24 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 01:22:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.58-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTb using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


