Return-Path: <linux-kernel+bounces-787107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7AFB3717F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91828367288
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D052D3A7B;
	Tue, 26 Aug 2025 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="CO52tFkz"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED2E273810
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230183; cv=none; b=dh1XuMLtlTsSpilW6yg8ujxy25R4oQ6NAQ1xtGE9pf3IE9amorG8ui+6tMQvmKYtP9MF/T4vyg/y/Zg9IKgcwr4gFXO9IJNnA2id6P17iXlAy3E5NCIVwLCqGiH/NP+lZhwXRLw4UxfClWif+H0C/X5SqBbD/2lMf+yz0jwyHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230183; c=relaxed/simple;
	bh=H2SMMWzVR4ZSZ9dW6KgvJlYxCMpDZKFqGFifKD4HpUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LutE3yrPn58QP76IzkuWjlqUWSLH6vH5wlqYA00ZJGIp0kzZIRC6F83wBj85cAAzd0PEQpFiECANFO76XnJE8p2NGhm8FvVSh95CamkbCZyJK12lNHwo4WPhV7r/+dhp3DfxDjmuudQfQ7T/wFoyXXQO3I/pEUTDHQV1ddHmfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=CO52tFkz; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e9812c8315so46704375ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1756230180; x=1756834980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLat70Fn2scFAgQOgRNY0XwY85hhzAqNB6rfyJS0Gig=;
        b=CO52tFkzKva62/A1Gcv1CwnSnilCRmGuKsKncaWJXZ518mXxRwLzJXF468MbMI56H0
         wKUQw6e5bU62+f8z8+WPKjexK5jna7nl+kGYRAv14yMqVIdwczExrpeAEVI00rsVAkaa
         dlNoUFD3a8nc+MGYpW8pcGeMPEMlMXWd1XYrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756230180; x=1756834980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLat70Fn2scFAgQOgRNY0XwY85hhzAqNB6rfyJS0Gig=;
        b=Sn9bv8TwUvkM/U29sTcifLFMn8iALgiBkhCOv+E1eobbXhZU/OLw/HcBtu1/vOj/kR
         R81TUigCrN6F8KnKnadLJf/U5GOkATpcJiJ38q7nEhQFXQGEVLj/pxcbQGZRotDvnNdO
         9fe2Mg+M8ZUz2FlJRIws2ljrNevIS2fHBX/ftGNLRvBK9N+Hmrv4SAqiFcl03nIpNmQp
         r8hr5rHSXzErqmKA0K9z8zqACsQ0sPTTN+9iBhluDrUxagIXdYtac7Qao2641nLbsIfH
         8IToOXKw2OpY38YfA6A4YNj8ixP0xG/OqbzN7KJ0unlAYxC1zC0Vl89MjL79FEeQwqwj
         0vhA==
X-Forwarded-Encrypted: i=1; AJvYcCUyZQNPJr4PlTEODb150E2q+DAmbeVA6DoklujHH3cNokC4ZNwLXSS1j5XF6gUe46hUhj04SGXFmn2vbNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypdP3QzCoZlo+ajOqpWlDy4Ir6nqAjopD5oJV0AndiSeqHK6cN
	uEqH61KYCfdUZkXYZEA09jGskl1sqkaUQj7X5vZRyvygxz8SITxlMSg02Z3tXI4WEw==
X-Gm-Gg: ASbGncu7EvwCwWOYQG45qhJ9KodFIDUeGn6qH5fY3SGrqo5JRVHSjcmyOtRLSWsvHF1
	R7rSFXb0SyltDDk6MGeRea4cgFyw8xnvwJzY6lfpLAYkM5/UOJzTBqbHsxfGLzQVDen1YuXDrmf
	hlLSjuEBVWzLXAnHGSFmP0r3sHGcwaVCQSSkyDtwTnJzJOn3MpuAT0DT+YR2e4wRjewLDZy+8l3
	fngJpNfVQ6cGlWwMtJPCnNFS+AYdwm1ST26KYaYD3e239jGMp27MoUE4EV9Cx21OHiIhq7tLgeo
	i5fv6ORnkc3pzxYRVlBJEX7gj1mwcjmZtxQJRFTuFub2H+8Aqa+4/DP1SY1KUqOkmOzrFoAtv5u
	cC+QW51rAylC3STyxl6t5n7sjrndSrF/k/3rwluvxbmA2WDPVjbQ=
X-Google-Smtp-Source: AGHT+IGEEt7ahjFtIRMy5uVKD3Gn8h5UtYr5/nf1Yq+VfL0Dk6Esf1pzUs2E0NY4xIrFkvNZj1AETA==
X-Received: by 2002:a05:6e02:3309:b0:3eb:1211:8738 with SMTP id e9e14a558f8ab-3eb121187c5mr137483505ab.21.1756230180022;
        Tue, 26 Aug 2025 10:43:00 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886c8ef4c42sm701382539f.4.2025.08.26.10.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 10:42:59 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 26 Aug 2025 11:42:57 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
Message-ID: <aK3yITcoPubsEhPR@fedora64.linuxtx.org>
References: <20250826110937.289866482@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>

On Tue, Aug 26, 2025 at 01:04:44PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.4 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 28 Aug 2025 11:08:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

