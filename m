Return-Path: <linux-kernel+bounces-806878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A05B49CFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2CD1BC03A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E6A2ECEB4;
	Mon,  8 Sep 2025 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AyAC6sBO"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFC2ECD30
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371017; cv=none; b=lIp50etp2I/yb2wOG3FSueB6Rd4TPQ5jdpfjjQXJsM5UWFEYFLky8hQqcHdKZaIWE5EtYmbUhtfEzvKtuHDrcsbeJVeRka9zOYRN94Lx9J/TBoxTkjxBXoQT0rn+3vEx9JjzeVv4Jc2khA0vIg2WGWXl6QTnwbuNCIlmMBGusRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371017; c=relaxed/simple;
	bh=T9P/K6SEcXRuUJUXzSA5TYU5bmqcQ8N7GHQaxFjMhXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LySW7nEjQ0FkBVRyOO06HOU2TXWMcEessyusboGjfTHiqm05JGFQSk5aHK0yipWgoc0sitB56pHQ+fOu6ULsvYscIQvcm39MQWDFbbTBtKKhzBLq0U4BquMk0e2gXAFKr/nquy7ffyv4gHaOHGnwMorQwTVhMxTeHaX7lkNayPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AyAC6sBO; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-40ab48f3924so9615375ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757371014; x=1757975814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhYf+Oj/7EuAlJsyRI1kl4nGXkiLJ1sdDKDHJYLWFpc=;
        b=AyAC6sBOJckJGouZhLdbl/lu1ccFHoV/qtmPj0uIr39IJsJ31jHc7vRC+PeIZeiR5L
         FZSgeTwOsX4PT77HElqFA3ZmJu4grxfR8uegrN/69eFZgmN5NEApyfwaE9TwlmDOHMi0
         09X4srGgu5oqDRVX28CGzCCM/S5GXJNvVIZMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371014; x=1757975814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhYf+Oj/7EuAlJsyRI1kl4nGXkiLJ1sdDKDHJYLWFpc=;
        b=s90dNjh0z9CtohgROxeKmg+8Ku5TyXxNCgHFTO31KzRG6aptZseO05cpHuogguXBiZ
         ZMv+ElgIW9qQZFIplZhCoHkXp5uFbVqc2jPMAc3ydseb2o3ypFgVdObr6nVA6lkkXp73
         e91rSX5exQaO3DIWg22Er6gftDNA2ZcQjVFYciJ1MFfa5tcGFX1acZhrmVlMl5LJPQEO
         u1YCK9bvSJba/uo0+pCth8lfTWpYX8FwVko+JR9fIpe2E/Rvz1XEsp5lBr358EpknTHZ
         bJw4wy0WnbdWBCe68AHPw86o5bEDTovFkCC579QRjUqSsrjCJYFAd4YhkhCU/iC6neFD
         VOJA==
X-Forwarded-Encrypted: i=1; AJvYcCV4nCeoPu6b2d7o2wQKPxKyLkRKpub7Ogptad2RxP7YvvCTq/W7wRqigmXEKwhXbO40sJk+93UxB2OvHNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjOQwlzAph44NshKrLnZb0TpiXYMGCvnQOPW57EZpR9C2qB1/f
	NEcoLsGrEck7iy7H6JwnVCmiAR62nS8M0lSMkKEQmHhT9I3IKrlUOZMzfdayhD0s5EI=
X-Gm-Gg: ASbGncvwvVScObu8W9TJsUtq+yHwqAaezfKpwYqBPotD9OqXKk769mYWWJ76qSuicGF
	yqTmUX7QurhBpLu10kJorEb6BXJnHAqxquiGPbFIe8+zK6G1uP4Wexo9bVRJegkUa4p+mOtfGYJ
	nIBGZQtiszneBWiuXVM0Qi+M7K3KatXsDpy6ndieYcqWV5lfohfvk1EjH1ERioX5TC49kfoRIVY
	D+nC4l410Gs0ho90HrGpZEff6N1UYF0WDTi9/i9a9QjhrPCRvz7zi5w8WRva4r4ejpnSn+SoVFW
	nAx4o9mo8P9IcpNKDYtbuPUP0hBmW4gbAWKanCaxMjTOhULqI/QGOtDmC9At/MSrYwL6SmfHOvh
	HE/QrAUyqamQ29yC5E/AD5lg+6E5q5mcs56o=
X-Google-Smtp-Source: AGHT+IGWCoQv8jgv0YHriek8VPPsKGGZClBOcgF0YLzARTTz5XIpyx2mZHmSef9NietX+UdPwGY8Wg==
X-Received: by 2002:a05:6e02:932:b0:404:5e3a:292f with SMTP id e9e14a558f8ab-4045e3a2c31mr66923635ab.13.1757371014127;
        Mon, 08 Sep 2025 15:36:54 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31c926sm9214471173.53.2025.09.08.15.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 15:36:53 -0700 (PDT)
Message-ID: <b4878e9f-7f22-4d73-9a98-ac26b2aa6cb2@linuxfoundation.org>
Date: Mon, 8 Sep 2025 16:36:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/175] 6.12.46-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250907195614.892725141@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 13:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.46 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.46-rc1.gz
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

