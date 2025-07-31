Return-Path: <linux-kernel+bounces-751508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DBBB16A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9333169FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1080AA94F;
	Thu, 31 Jul 2025 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="LxAp9XhU"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311B23A578
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753929045; cv=none; b=sEjVltPYD8ADQ+v733A2QSQ1CXCtdBGYVOUl0WFAl9UOnI4jU4LLcxyfoD7j4nqc55YUx1zIjeuT6sS/x3ZISNQQkFUHGqAyqFCgUtSavF4CAC6N4yXgjdDYEDUWi0UdOyQwSODDvE8Ib8SShVotsqmv4OGFWxblXSQCgp9eTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753929045; c=relaxed/simple;
	bh=BGP4l7+uPxiYh3sDyFOdJBPQva2qULDdcMFHkX14DB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3R4ZmohcK98oNV4uo9Y9jo+mMOPFtJE3P/o2dVD6oovZ4Yg1NSyq9Z3GqlZj2bnIjTLxQL0ozzv5mmw3Opf/Zm328kAzXl9lXHzw14wGmX+o+ZRNLHa4Y/1dR/rsOVh28dNr1j9G3jgVobVME6kCf7r5itgGDnePEsEG//mqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=LxAp9XhU; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e3fcf5b150so3810315ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1753929041; x=1754533841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ushCqJt1jxq6Hv7PpAxgFKijmgypw1mO/90AreCqXA=;
        b=LxAp9XhUBzulWpS4y+BOE+qWvyRrPT6R7CuNcl6fWGw0sk9z35BuNyD8Yr5RoR29Cm
         28OI4PGKmr/o0aSEHmvZDPkXeKnIld4FXrnJ9IaHKlD0Xvs5FR3xTVnvLQHC8HOZxTea
         eAJZA1kNM9soIyNWEaKtC2fjzPusVGBfNoiPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753929041; x=1754533841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ushCqJt1jxq6Hv7PpAxgFKijmgypw1mO/90AreCqXA=;
        b=u+MwoTZULwROQYiDkO07zF/lBdZQ7ubLgzSwrLT+G5xxfVOzwCXjgz9To5ht863T1g
         Uzd4yHRyJZ6Di53UGL4Lvn4kRIWjCR/KwtIXGEEej66xNqcgdgR8yLZ0XJ2zWNRLUxzd
         Cw7a/NdXjhKiXvqvHZXmY7mZj5UYjxq2jWPR94UWWcNGo1uJ5LoeLMKS8ASAk5Xn0Bjh
         TcS5g8Z5/pI3Jf/D9Ez+RTsDt9M0nU9eO7wjVw8xGYZk8a/18SqFhBe4gh6o+wXJ/mj4
         jZuIemOuf6dcMCuhfCTQmoRgKeAFgIOvOUweKYQ3cSw/U7ejOuLn49PJI6v/eUI7+Hh9
         wzMw==
X-Forwarded-Encrypted: i=1; AJvYcCX3lVi8Z9qlH684ACNw67kpohDLQJ/tR9qsr6lXk77vjHKMIBpey/V7QwTXaLBjek//jtRF+90OsooB1t0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1CpphnK4tgcptGG8LJa8vWVbRVssGMuNhdYnE5sUpFEXORxgj
	njEpOmH9FIAu8wB5zLw9Jxb1WCdJJonDzMkLdHSAcc/CnvHCBwdyOfQGf8uFDk1G4Pb39xb46hP
	lcNPZ7w==
X-Gm-Gg: ASbGncuuPyNhag4ft9IGrRqOdIjM66PzD8sxGuGfeflN85hLGPwif3QH1Mm63KHcTrX
	DijNS3+1/K8gfnT5nyigTz+S/G4ff+SF9JitMracxdalYH5EBHjAIPb+6K3F3fQ6rR1UO3K8HWM
	TFsu+BHXmsbFwYFV5IQjLqiT2LkBeCvPn8Taes92VjQ4K9Kv+tVVjbJs2eQ5F0qwRAUOBqgomya
	Na/AcAxMRbukghCUQ3pIzXZZ4snivqfBT+zkHo1Qr4J6buPJMBFOmCKiqkmrxHBjZf6fz326dUU
	PrOu4gbgNb7GPQ6nEGJrxLX+qxzLoQM+/Y9SAlQTOp1d5TzC2qtLBI6gNY4+PaTrbLe5n6SRv6U
	wxhztuksuPcdB9Xk3Da0YcMES+9o1hMi0qWkTUq8=
X-Google-Smtp-Source: AGHT+IEpDkOSfzGioCL1XlJHEiBvLDgHoxybZGActJKiPQtp5q7HYKT7qH3LFaZFNhuA+F7wTTjKVw==
X-Received: by 2002:a05:6e02:216a:b0:3e0:4f66:310a with SMTP id e9e14a558f8ab-3e3f624ff19mr92076215ab.16.1753929041210;
        Wed, 30 Jul 2025 19:30:41 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e402b018f7sm2521125ab.43.2025.07.30.19.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 19:30:40 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 30 Jul 2025 20:30:38 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 00/92] 6.15.9-rc1 review
Message-ID: <aIrVTm6WHKLbiThw@fedora64.linuxtx.org>
References: <20250730093230.629234025@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>

On Wed, Jul 30, 2025 at 11:35:08AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.9 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

