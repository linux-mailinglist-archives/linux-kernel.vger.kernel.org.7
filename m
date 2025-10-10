Return-Path: <linux-kernel+bounces-848719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DFBBCE6C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3886619A7614
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CE13016E9;
	Fri, 10 Oct 2025 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="KQzWqHah"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4769424EA90
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760125704; cv=none; b=m1/xRff7iTp6mBqbRxMdU5Pcj55JuyQkWWHUXGhh4sYsr/Htam3qccLhAVxJHnMcw20I1/kqd/kareLpmhtyF7Woc3dXU2D5WYcSV9qiVR/rxKok9qw8e4bFBnpNxEIx/eM91Xj3cQS0jDdOfmqxdSf9tlOE4qcks+u4zu1K4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760125704; c=relaxed/simple;
	bh=83wimRLVprbnqmC14GL+S6WE4qbPtRnCGe89nxv9bhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aL05nVaErKDxZr6ECHQUcz4JACL5PRYlJlEpQvO7+EcKLDVDWyQaJn5Wm8FilS/DadZp5ENFC8RnkIV8Qs/Z+MfLu/Il2XvPNvuwfvu4EBo+f5QV7rXh/yGbbQoXoa+YkKM3dNulepCfS62rrhW59l5wlOzflBYPn/r/t7V5ztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=KQzWqHah; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7afbcf24c83so713863a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1760125701; x=1760730501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=De3XODNHpFwsaVSSqNIM0lQEtYxnx4u9mKva8FKwHIU=;
        b=KQzWqHahzgG3v1aDtn0+rBaCugRYS6r/bEzb3z7D2xvpTDjhy1xfogLhVyipGCdHvX
         okMzNF8wgpNOLSDVx8VrAzh5MrcwoMK8PG2G+jBU6DLRdpPa4nSDwNQHwVaBL/8LFOVj
         ZRuCEkgV/kLwDqmXG5qZBXuzK13vd4OgB7bk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760125701; x=1760730501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=De3XODNHpFwsaVSSqNIM0lQEtYxnx4u9mKva8FKwHIU=;
        b=hKOSUoS1CHtG2XUw9JPi3i4sAzkeTtsx7N1/sSdgQAb7/sEr2t2YNtRdjlTklL1aiU
         3l2hO4KE9gtS99hAyRabfOlY9QqnCmYAGzIzfiZuGaVsTvvWUg5OZq47bvtMUOzM42Nf
         yr8h7qCLQ+Q9Y8URCmc5PvAwEFTkYxNUyvXzCgdAkXWQaPrHvpXvTyDm1fuMQakmUR6s
         C+gpSkcThMooBVrKNC9YQdcc954BUtNiJWuzxKT/LxVh1c5whEoc/R2lhlhFlm1jV6VX
         kScr30gPWmB9YnaKDuYRFNcJMWmCusXNe9zvPFU9NTF+x2oiYOHU7O6i7S0rqoMXXtEu
         7XCg==
X-Forwarded-Encrypted: i=1; AJvYcCWgWQKT4c9i8oGAblIkr96hU5tSYp59WNB7/+IlvTmMSN5TMl4T/IbI56DHrnuRdCJe0UArp7WncX4pn90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGrST4qc+2yANuBsbP89SaqmQ3uvLbcwWdjLAEbH572j3wtMYG
	VioDrz5fORRTDmb+saFjVG7iZFdywux0Ogw+TQeF4ACh1Ot05+pR9BZ0FMQNOkCGyw==
X-Gm-Gg: ASbGncvc6bTVh28r22ujyEh2DQunEqwshHvVQVGt6eNR9cJlW2Lebv+aWlb3KQVc/4T
	zbiIvJZprl70xsMt/HDeAr8pKwUirkouL15XHDTZ3KKleQHWE6Q7IenZrJbSnlp4PA/ysE1wFEH
	1mj65sXxDAfk8ZQ5PjTgRP7Uu7uqIgtM6cjiHP+k1gcoN/juuAsOAcAHWIftbx7BkI2LrHdx7aK
	PieShuUtoylk1t1WoBUc0kbtSvoOmKufC0ejAL39coYde6o/PKJ4B5gc0EpNRMwTeF2aYw6u3KJ
	bmwuaxiPTJRUN4a746GZgwSUcBrZ/JLtBmOb9YlW+vs/Wut+EZbmVBfTKHejuOihyamI5BwX5iY
	+5XeTpJVOmxXZohli7gw02iwmiwXJr+ihSckfpYXKMK4IsRodEDUjTAKk4esAv+4=
X-Google-Smtp-Source: AGHT+IG2a/R7yGXvpWUnjwb2SugGnCDZzWLdoueR11HoiEzxPMFcCyVBrmazlF3z2WbJF/PnTfSfRA==
X-Received: by 2002:a05:6808:1905:b0:43f:9c7f:9b28 with SMTP id 5614622812f47-4417b2de937mr6142483b6e.13.1760125701122;
        Fri, 10 Oct 2025 12:48:21 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.121.221])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6501a8cc2bbsm584872eaf.7.2025.10.10.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 12:48:20 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 10 Oct 2025 13:48:18 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.16 00/41] 6.16.12-rc1 review
Message-ID: <aOljAhZFwcEiHqPJ@fedora64.linuxtx.org>
References: <20251010131333.420766773@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010131333.420766773@linuxfoundation.org>

On Fri, Oct 10, 2025 at 03:15:48PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.12-rc1.gz
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

