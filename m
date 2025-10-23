Return-Path: <linux-kernel+bounces-866070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8507ABFED39
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D77A4EFD6A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A202919CC28;
	Thu, 23 Oct 2025 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="YLkqZIlO"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743634502A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182435; cv=none; b=GJc5IteLTZE03P7SjyzR1zrd8tC+8Uxnm5aFIcjDo9XBQBnz8I92AVvIsMueClKEbRogcT6flOHZKP2hl3Bs4P3RyDn145R/AmqY8M+Hf5smAqrS2umvzbkXTWyvB0dX1xRWhHuWNVwiTFlcF2y7a40rFgbP0rVun3taXu2d+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182435; c=relaxed/simple;
	bh=HWeVzs4HkP0W/Y6HvJDuWMbx8SneTc7qsQZMtj9yvMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N//4y1pCpT4vgD0NNgiHHzLhOd//BtgtBoifZUeXJ0sCT+y/iLXdcaKKN0RkuO+lsuurYwrNJIvHo+78tdGbHaY0xFDU2DHpX881eZdtzn9XSTQ+TdQgKLzJZzMUdHwRGIetuJrooGRNXuDEFeR1qyrBa+6/bJpR5LztJf5A3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=YLkqZIlO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290c2b6a6c2so2517225ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1761182429; x=1761787229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ijG+3nszibgNynLBA4c1V0LvvFa9+rH6/8ywIqIspo=;
        b=YLkqZIlOPSWH7uqLb98KRUHOr/4QzLA9u7R8GqPdeeqnRo5u+LuHPZwmz8mSFHkJ/y
         c1SHk+zrIFBGyohbmg04vRx3/d2+TKY3Gm1wzkzfLVThqHF97X7EjTNM6q/DApEWG0di
         ll0mA8YQPMJV4xoKXNDZynABNIxMPTYIgk5OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761182429; x=1761787229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ijG+3nszibgNynLBA4c1V0LvvFa9+rH6/8ywIqIspo=;
        b=Poz4RiLHHiR9L9HAdNz7sEI062XhREkRiMU5e0R4W2RaMR3zcCeWJu0x20hqRu8xB8
         wCcrWE8NsXNfU1cfQhLYGt1MT8Qn9cOdSG0bd/lv1IgbXgrhUyT4f3q3jkRTiEFvd5BS
         SrdaEHtnEZp/ORTSY4hBDAk1xM7F+9oM4rC8tytSFgWNZM+3fLoqRPLc+jl2j5CauX8P
         10bqctbJ6bkGpaA9/J6SXiLLu3mdfL1yNGuavrp2yj7Wpy23JHHtqXXaosH8PwEgQbs+
         swh5Qj1nYZs0Uvb5t3b7k9Z73ZVNj7UqsnFveq8KStYsBILkLSo5ncjFjmpVAvAVfEXM
         HEcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwHPPQpDkDcYFaGijtF7KIGcb8TQwM17rjGD0bddL3EodJUFkeO01nMa74WFpSfwi/79ZiaWbrNzYIIP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW8bZtvwlkqPd8tWMRrPjkHBBzhGKj1LgjRbD5oPJ2QxXPp1AB
	gP+GBeetj7iT3tsJPruTkn73DbiPl8VCswaI3pwWhrmdwYqsVO1s8KZ9XsVFy6LIBA==
X-Gm-Gg: ASbGncu55AqihcaT/28U60l7FL1mUfz4NakkJQqcOnmtO0/kQG3e3Ea231/pAEV8l72
	r+6wXBY1M3rpUixK+PbQjsGZ6xd8vVp6NAq2F7sWYCvucolNPogAOP1Abi8ONXxiVUalsHFoUYY
	bLCmREIhP9k1hWLDwgqCkUbQ1oiDA+nlOeF95UhC58kCOZ0y3a+eA+ICnAysyvM2XUds2o88SqY
	MkWY+ioDpMCueADk0qW+CvkBmzbJeWgoKO3/LodTKG4MwI0lhTJJsQnLRvhqh5LHSLPJWToVIle
	e005DxL7kbBbQuOOkY/OLPzDPbFr3expNBDrvvvmW8Fx/koAYWB541dD/Dm+tCMHgD9Lhr0LoMa
	nlpwWzD4gQpJqJyuQRDNMY/94hKW/bZFZR/Yd/XI2Zn3+mf5jTAidomoSZAd+i3cZgG5v0H2jgt
	46qsD3nC8WimocR7TKA95lMqtxSOnhXHg=
X-Google-Smtp-Source: AGHT+IGqlsv2gN808APRt6SB8St16ScWc42axG4K0bEhdfrp2ymJT8G4ZPKTSW9b6iTHmmaAgcxKNA==
X-Received: by 2002:a17:902:d2c6:b0:290:c0d7:237e with SMTP id d9443c01a7336-290caf831cdmr329156695ad.39.1761182429389;
        Wed, 22 Oct 2025 18:20:29 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.124.76])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e4303dsm378640a12.37.2025.10.22.18.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:20:28 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 22 Oct 2025 19:20:25 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
Message-ID: <aPmC2fnwdvffkc_B@fedora64.linuxtx.org>
References: <20251022053328.623411246@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>

On Wed, Oct 22, 2025 at 07:34:14AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Oct 2025 05:33:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

