Return-Path: <linux-kernel+bounces-853419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5707EBDB9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49EC94EA3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B1C30DD0A;
	Tue, 14 Oct 2025 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Lpw78URw"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04430CD90
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480351; cv=none; b=tlufU9R5KscFcvmvaqgrSLHHyO1pmE07PKR4KlNaBfWxwZ8VJz1kaq5910XOxUe2mvDNVVomcQ9AxW0JbbZFlCF/XCntUy3eJ9XBy8/0H0aI/Ugwv9eTvnaCqAXpQIJWGJcSbpwQXszuHUHLiC/hOnGimuuaF7jWn2kxfNkB5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480351; c=relaxed/simple;
	bh=d52ol5jDnCqNM35j5xvJNRzYXDEU3WfnARQ/CVHCRFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqEmi24iHI/tMZc3YLRFgueIP0rY3eoIVJskF4SZAP8P1hM+iJiB1YS7foQeovx2WVymJ8wFkHpgIbg/BRI5mty5/tkU9+Tlqae26CYWPrQAFupq3gpD49rs01adGW79kHY14kyCEz0ODMyk9jFUCPjxtsn1QsUp/t4u5fESHow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Lpw78URw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so4589523a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1760480348; x=1761085148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alzbq4xn+X7BhpgLRSUY/BiUcuSjAW2A5dveqJOGO40=;
        b=Lpw78URw8NIOO3BFwUNvi4J26gh2iGUWgUzY/fffexJ1ih9F4E/IzXTuX1e1NlKZxi
         fvl1XpxxK/qWZDiBAOsUAjRYnFZ9xHD/KvF31rtCm4nLRqQKA0slJIrs3mBcfTw9FVZc
         fsgHju32irJeKTZ4Y7aOqEKC4Sk9ODm/MpoEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760480348; x=1761085148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alzbq4xn+X7BhpgLRSUY/BiUcuSjAW2A5dveqJOGO40=;
        b=AOkkK4X5H+Cst592U4BMJUoCP6Kaek/Xf9B2ROopYnTPG5MOREiHeXdTInWOMq83GC
         xie+3ZXWiLeyvSP/APFGNzX4XfRnwz0VS5/B7MwxErzT0LyQc9CJ0opIr0snZuIVO0Ct
         o6c9rWH1p1zHCiHgwzI7SBJxh4MiU6wBPRf+tazTrFqJgT3aA4ncby7VCjo9ILwKgJYZ
         WZAiXQSgQI5ybmg/dfHbVWLo0cq1cLhOp/RuleIM9I4+v/6GKeROidw3lIuFjCbRtsmH
         2Lh0FPjj7A8KQgKn4C3XCN7iPbr/eLuruHqcHkCjAuldIEV2NnUtWQIUgmluMK8S5vnc
         /kdw==
X-Forwarded-Encrypted: i=1; AJvYcCUc38yGadCRZNEotXVTiHFu3MYMp64WA3sRXCvY6R+C9H906CzYI8JEjxKiEzY2V0rySHURSzOUvYwc2LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWpXlSTWhewAce9mEefiYnsKEIhSoayXghFRmLm90n2Ev4xCof
	Jbkrt+Oz3rNswTwRI2CGFF+BuZylcMGE6kmbOEduuRziDWcWP3ezGiuxVokAue1eWg==
X-Gm-Gg: ASbGncth3dwJtEGQPX4jiFkeAbWBTG+1KOmwIo9KAbwo1UpiTRIfSkQDcl2dTYWcJ8x
	JGBWfMA7lDRo5BScDOTxj0St97b6B11hhhH1pC8Lcdg9pB4lkUkLvGt1ZLhi0HE608c0Y82kp9w
	D6XtW5SvbyZ1bxf3OyucQI2wj8rD5z0oQHmqUEyRK7KBvXW5RO2wqHVklrvkk/Gm7LYnxf+ym3y
	nFxpEYZaVQFSkg9/2nNAwmjMWp++JMSynk117wfiV6enbqb4P8W7XUX3VScVb7B1VfRcjKp0h1W
	SEPI+71FVKJnelH3r3Cr6SinTor4O27uFC2kT5ZaBkkRqByF6JQgOWiC9p/pZHKqgtFPGMHqJ2E
	foWVYz5HI39yyPjI37ueczwssYtaLIcj77V8+GQyzuIBnKZrRgs/cEA65GT7fEMZrhJbBSVTG
X-Google-Smtp-Source: AGHT+IHdeP0YjbJf85NTvomIyM0+GVcr7Wo5mJ7Nfb5UdYxRTyJTMFJyGm2BssQ8MnxvTKoUs9ugRg==
X-Received: by 2002:a17:903:2ac3:b0:281:613:844b with SMTP id d9443c01a7336-29027418ecdmr328650695ad.52.1760480348537;
        Tue, 14 Oct 2025 15:19:08 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.127.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f93b71sm175405965ad.114.2025.10.14.15.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:19:08 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 14 Oct 2025 16:19:05 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
Message-ID: <aO7MWRnf7Pk023jU@fedora64.linuxtx.org>
References: <20251013144411.274874080@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>

On Mon, Oct 13, 2025 at 04:37:41PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.3-rc1.gz
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

