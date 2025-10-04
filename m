Return-Path: <linux-kernel+bounces-841919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEFFBB887C
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 04:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A2C4C3987
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 02:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA43213237;
	Sat,  4 Oct 2025 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="aJesmHI8"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544B20C463
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759545660; cv=none; b=fCt4sbG3q4kWOjBZymHvtkvGTAUM6Jb5kRdUC5EWh2tG2Irl/EShmHiHB5uD+PgldArlesaVWhNcFOe3yIkAqYrKoqgbRbFr1PAuZwCeOZ6CYtiPCuU2WI/11KH2eM8ATcJI06VjCJMJC4DrmsWPYu2wdiZnkysktqSYFVNQxrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759545660; c=relaxed/simple;
	bh=W47sKkfwYs2RK7IYeiEtev4+DLhj5IvN+P8eDuSZFjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phKKa3QLy3v08rrUX2N3VRxGTk3LHmhOpbG6T/WGliaKCb5UXNdTCgjo9doNWsR2AP/xlp/EKGmpE3muM99g3gGxDRA4SFsu2BxWFbpVxxeYfP3imWCBYUPQHVoP2/jcvx7d0PnD8jWQHtSs9pbW1a5J5NP8l9gfxPNZV8po1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=aJesmHI8; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-938c85ccabcso123648239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 19:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1759545658; x=1760150458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNDR8b2qncZl91XQkWHfWG4VDM9E/GJQEK5T5WnHqN4=;
        b=aJesmHI8tgVxwlhooTm8Jv/QSwbIXxCn5IOfE6LyRGKpMk+kfZpMs4XfB+JdHAP3wC
         pb0CdW8pL1mEV41OvHTataM7PLBu2SVmVQ291Dn51MoJKs8PmJ9WmtG4ZNb2/wBpGCG+
         DNcBBhh+z6+JAomE40/kHyGgD0jkaq6p3h88w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759545658; x=1760150458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNDR8b2qncZl91XQkWHfWG4VDM9E/GJQEK5T5WnHqN4=;
        b=OLaomztGJ7hgxLn8js5CP/B+lzXiIyl2j3qDL+bv+OBKkl6nTDfKMTrx8hFikX4wp5
         pu656qPBPoSr8SbpB5nYCMBvY5iNCFXnbMkXwfwK69FE82+3P+iCfeGC3HW6MggFWLOO
         0OVLchkckvXtAuVPu35LUPV+7p7TcCorclXKHyn8e2MdjI0bxY3oOi300VEKxMrDetav
         x/iQO+hoMjJCFXKuC5bwEmTtGZMeZQNxugoJSo+nGPMDDAdpQPgpOzcYxi8nRGRrskHl
         DhhNn08/k/++fhZbDvE1xqAdcolJTCM99WezUrhROZ2bIxuNeUSamGMzrZhY6MRj1/yW
         dEkA==
X-Forwarded-Encrypted: i=1; AJvYcCWeeGJXjitSG3jwACdyFtBIN757dNltsffKnTaFUCRwz8N9SFI0FZo7FTvzEnz5UYmT38oQP/DDgk0MDtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5V/lLWdkfAp5O0TJ/Lt3bHPfztr91JVWPc4Cc3EwVUdBKWbB/
	v3a+wtOwhudfezCKArOn7l+9ButRHTwDC39uj7MCHBq+sjQNYGdsKZiRpKFH4ffPZw==
X-Gm-Gg: ASbGncvt8qsu0J33W3GpD02yHKFkEGjqX6K/qrdw0nyZvWRjjskhLC0KMiEqP13K1gF
	qGltLtIepJI727ra1LIwYNi1qVNCpswRAucghhdm6L/j1T5evo/jtbTLUPm4kgZy4hjik5mrL2b
	3Zi9cGYo7zlh0bHAL3dbSOGEWiHCki5iwIIyFkJ0Bf4PCByAzSTkDKNB3+kewOdauZLg/ooO0bW
	ZeSiIMsz2Ay2R2iV6+EQfk6T+JFwu3e1+MfqjRlyI+r+WBj+88AK7UrwHDAlpmG2vjFuvAZkgGs
	xaSC0nI2zDCTOc7P6PNHuFV8M8P7l0/Er3IvFtruissY+uq5tziccILAxvA6GnozC6cSAAyaf9K
	5Yuy+gUyaZnJVaiYlUW3m9gHGH3YDXCSF7HJkkHrLfHUzXa3/J0geVx9HmLe3hHGHcG2uYJAhVP
	Id8bM=
X-Google-Smtp-Source: AGHT+IFHbwBHFB4PEkKMKRHhUg29okZRl+OIlTXfFCdU/4WLStieBeO2P6W3jg9StbjK+Hp27/Vlwg==
X-Received: by 2002:a5d:81d4:0:b0:8a9:4e94:704 with SMTP id ca18e2360f4ac-93a666de022mr877468039f.3.1759545658318;
        Fri, 03 Oct 2025 19:40:58 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.126.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec07d04sm2516067173.54.2025.10.03.19.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 19:40:58 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 3 Oct 2025 20:40:55 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.17 00/15] 6.17.1-rc1 review
Message-ID: <aOCJN3i65NH_C2T-@fedora64.linuxtx.org>
References: <20251003160359.831046052@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>

On Fri, Oct 03, 2025 at 06:05:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.1 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

