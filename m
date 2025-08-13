Return-Path: <linux-kernel+bounces-767450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D929B25472
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CB59A1476
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F962E1C63;
	Wed, 13 Aug 2025 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Ai90iJ9f"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACBA1494CC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755116116; cv=none; b=bKfbEs5AVyWQsvx/zOsUtwT30kYYyu22YVfk6RNYNR4isG0EM0GYNrnLTBSG35UNzhzuGa0iOW3Ct2o2Bp0bZgYCq7KItwv8+7JOgxl0mPTbEabl8kAAVDsQpEClJgOX09VB2dqs5thuKJ8yt2uvrqKtjKPTnidNpq+KLuy7TKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755116116; c=relaxed/simple;
	bh=/DpqAeslv8bRmsN2sfqbbHvqAKqaJvH3JKfHsdO27s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av5b+n9799jqPX8sR2UM8Pn77n5dHo/u1RTvktYC/5iJdvyii8aIcqiLe4zfiJV0Sd6JZnPDPTVfGXXlp0ya5S8G/N6EoUIxSqYdtBWoKx008vgxzbZBsA69bVcfPU4W+XKnYSqn6pTnvbrdFGdeT3hREvv+XJxDbh8BqU4qbFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Ai90iJ9f; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88428b19ea9so41704539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1755116113; x=1755720913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcgwJo67fSdIwhf/Y1kaVkQkpR61CWnlebZ6dKIeM1Y=;
        b=Ai90iJ9fJ1yHbEda6tGc0tAtrZrca/fRRhz5yGL3SypnGDFVkmY6wsehiNEioyeK++
         AKSdnreJai/Xs7SOwIIwgKfbe8QAXJ09fyWKg7gautqyvdQl9SAuZAFn+L8NAHor6LT4
         lT1WO+/MV59UgaVZUdYIFWSOgXT8BLb2mTTzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755116113; x=1755720913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcgwJo67fSdIwhf/Y1kaVkQkpR61CWnlebZ6dKIeM1Y=;
        b=wCDIcWx3/ne7dl0oO4IbBrc1U5RbJtMoN9gr5zBml5dfXC02lAPa7BznaIL/Bif6LP
         YgDddAovdehsO2lSWJclwlDoHO13vMC+NGbgXkLnGBh3sh0L5iFHhChUO+Af6FyuhvEW
         k2LUIf5TKVSOvMlibbRasvhIwfmpG4EXUzg7Ukm1X7FGd+/Pw9lK4Eu+hmmV6agrU1TN
         R70Yvqy8MYIkvpfKueXksYkvmo8zDeSb2A/l8QHiwJS6HUKgownWHsvDM41+fLmglD+Y
         hXk6uTZymkbKBNnxRK/FqZE8foX/D8AFeDO86GvSP658gGl4GPChltqqUaberg0tWnmR
         hvkg==
X-Forwarded-Encrypted: i=1; AJvYcCX+hTBb0kpjamhBmIT/eFc2qWpPa+6o7HBEPhRVjQoPSdZ+EzVsHz/CG2w/QhEVDcNi0KUUBuPIBr3FQZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsRlhgO9Ymb6otA9I5NAlCHo4Tx1yGAVxc5/9/e9F/1pKf1gJP
	1DfkAUEh0dqVdh9iWdxPy8T2t2o2vgqMObfyNyBs1NN9ylVdn92Avgpzy8l32OF7bQ==
X-Gm-Gg: ASbGncvbJ2AOHadrQUfb38D2GNs28IlI/EauKwLObbJGYKwEE3+jK2UmHOfVNbwRnti
	5eY1mRc5S9EYTsuobwUmeKvZpwNaD8WiaQLX9g6XMs3wXimstDK3XuX+dZSZbR+0L1Imgyq5Hn6
	/ZfFdb5O5rHtUekVOYgTUqcoJdfgKWymMty9qPLwQG6S0x1f7cJKN73zRRLtfIOT1x5JhyHg1jD
	QmdF/H2f1NM/3lr0aiaVrhQQREwogv3dGbWvwZyEo4mRy+OQWTXE8nskSo+Zu9AllmcPbfsWH5Q
	QCXMfnMR0MukJ7xVhkn6wlaVQgdalUlk/KDnGFMBRPy984LahqZleP8I8oRlqg0lWHkIjCYsGv9
	Us2Plt9qn8BPnA4kSpK/9rJPWywLncwoKoIoZcv0=
X-Google-Smtp-Source: AGHT+IFIT83RK1BgW71T/A/tIXZmBd0yTKosCWQhpckCX2xdMMMQJzk4nn/G4EkvLEe5LUihAUVh8w==
X-Received: by 2002:a05:6602:7184:b0:881:8957:d55e with SMTP id ca18e2360f4ac-8843446d220mr16540339f.3.1755116112915;
        Wed, 13 Aug 2025 13:15:12 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae99cd268sm3906199173.22.2025.08.13.13.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 13:15:12 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 13 Aug 2025 14:15:10 -0600
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
Subject: Re: [PATCH 6.15 000/480] 6.15.10-rc1 review
Message-ID: <aJzyTmxsakkQ0SCB@fedora64.linuxtx.org>
References: <20250812174357.281828096@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>

On Tue, Aug 12, 2025 at 07:43:28PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.10 release.
> There are 480 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.10-rc1.gz
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

