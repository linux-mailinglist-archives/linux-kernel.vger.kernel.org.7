Return-Path: <linux-kernel+bounces-776519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CFBB2CE66
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218475C09B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070E4343204;
	Tue, 19 Aug 2025 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="hWEP/lpw"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B5731079C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755637848; cv=none; b=hE+QwU6IUOjF9S/lHD0T8OXAhV/9LBGYGlxo/CETJFMNhbKIwnCSqKd8HIbe+9d782g+JWOOeTh8ncQ3irBpw1g/n90paW9EIuQEGdiVQK7Fvs+yvgP3oxdU31sGy/dCB97+UFaVl8vQp+Y5dFA4aDZ/wlpjw5YG6XcBusLc0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755637848; c=relaxed/simple;
	bh=txX5jr8BxDd33Eld5ynHoiTnCcdsuh04s9+CPfvKpNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRjQ5vR0IZa8zdCVSKUwDTjqIsJkuo6Z+gprEEJYa+Jy9hs7OoN5GJSrqZAsBX5t9AGoLVH5i5Zbnl5JqTm+D8LtJa9dyfx60oClkthuqqDjCbkfEJkr5eGBEDKCKRiSy2ZZoIEy66vIySeFnhwlmWWUVFwef/khUdapyZC+b+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=hWEP/lpw; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e669190697so16661125ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1755637845; x=1756242645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDkKsSqVswK768y6OwV/pwm/Qgw8vqSdXXmpv1U2m9k=;
        b=hWEP/lpwCh1QIhqisD/FTFS/JEjNWSsDSEdfmP2djzR2nxyaozkjTp7PXtnJQWBFdz
         YscgFauhns9fWgeMzNmhITLLB1GFGT99P6lJntHGO6VBZReZwZlPUZkWLFkNnrNYawAn
         u65mAfpPp4H2oCqZHTz8BDOIlSyaNttlosiiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755637845; x=1756242645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDkKsSqVswK768y6OwV/pwm/Qgw8vqSdXXmpv1U2m9k=;
        b=CZP/j0XE2pq69VQLvprkbVpUr5vlJb8a9GmMl08ncCQ5Rarjw1UjvX3HiCFMT4F+7Q
         K51ANj1s8b1muPeDGobm7TUwUs93OxWa/yT39xn8j+6gK9xxQntMcvj8PzScpH3zZ0eP
         dU1gB3CSfUqBiS0GzZEpFJey7dVwM7pYCDbZyno//0L9m0TWFuC1v9oAQNNHLy9aLBoW
         2id2tx+5UHwvho9Mn8b3/a1lzXbvFJJlAhROY+0K8XrwMAIMlPj2MqyqdiG6zF5YcSsr
         xFHIhDZNR0EYofNC7rfr9tvftlFzZR9UWm2BtroooACKIPfOR59ScSYLPNtSHNB/dJ7q
         ZtcA==
X-Forwarded-Encrypted: i=1; AJvYcCXGOwRbwgPeyz9agd1dNgMg0Nbogg1edvvo5eluZP52SHaFJWlVPYuKZcRNummh0XcrGwcmm3JgmFgRK/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9QiBsznbpjwMh9nj1E3Weil9W1+OyYxMXgTrNaxqW1PBvCdXr
	8EY8oE39z0yJmgm00YtRM5EgQYqUDCS5KDhNsA94Nf8oSBhHNotG/ZCLDb/gAGcA3w==
X-Gm-Gg: ASbGncuf1av0ftEaEhwZKxRfbCnaFoNmNBnuiO+ixg0+tnEK8/FbSQzeVSHpSWYPoAB
	t+foVIclffUUjEjsrLsz26kkQITvMN/y2DNg4xZFmQUHYrzC8ZvOPRFBzVpEAAYMXMtn7SDDnNw
	NLzGF+iZHLJY6z1UIiNCOi1VXguaeV41UBY1tRdq6793TJphgSMABU+zIV4G9wvQqjZzh6KHv5F
	Mr1hPsuQw8O7SbheouKm/Te1qpKL0B52yQJpIdMZ+dFglVqQOPZ1wlgts9H99ErnfDMqSkkL27G
	NyDupBNcYLAg/kOd5ZML0lNaT7J4dxIvUXdfONY2KhiQ0xPObDNAWkQqa/HT9agDBUJ3UUtblN8
	BzR1IyyDUmAIC/MkXXFYvcmzb2f+k4QstvL+l3ARu
X-Google-Smtp-Source: AGHT+IFkgVqKIKxgw+wzoUg+k46rcgWwLSYjImXVctH+FBD3hju9b7c9XVOKir802ruFQAxf9LZvrw==
X-Received: by 2002:a05:6e02:3e04:b0:3e5:29a3:b552 with SMTP id e9e14a558f8ab-3e67c9f4910mr12050375ab.3.1755637845295;
        Tue, 19 Aug 2025 14:10:45 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c9477ef32sm3638741173.19.2025.08.19.14.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 14:10:44 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 19 Aug 2025 15:10:42 -0600
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
Subject: Re: [PATCH 6.15 000/509] 6.15.11-rc2 review
Message-ID: <aKToUqhLaqzvaSUF@fedora64.linuxtx.org>
References: <20250819122834.836683687@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819122834.836683687@linuxfoundation.org>

On Tue, Aug 19, 2025 at 02:31:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.11 release.
> There are 509 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 21 Aug 2025 12:27:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.11-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

