Return-Path: <linux-kernel+bounces-806534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E6EB49829
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8617AE1E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3C530F94C;
	Mon,  8 Sep 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="g/0VIyvK"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7765221F24
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355658; cv=none; b=OgtfnyCMKOIDQUYdZ/S3cBdSmn4Sjx9C7WWtXgH8NIJkIifgMrLkVqsYCAHB6H/xC8Jh+EQabfeDBmtxcBO9lG90TcPm7PY/UhlpCHjG0UJZflu1kEWbUwfWm+OrrPJwmi+RltgQ8rkXXgaFLkTc6Ekv0EGOaC0epffGmL5GicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355658; c=relaxed/simple;
	bh=Nh5FCkUds8fUdhe4ZcLrZzck+rIGv90oXfld6eJMTBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4O8VG/bVvY5LiyVzbLUXXJEIbce889cZczICtifDoEilBz/44MKkiSOjpdEanLKs3cskcw/n/spGReBQs9w7p//cQ5tcwn7yftX3LbaJ30tCJWp05NmD4xmmfPftPz3roCitiPhMQaE0FWNF/2bbI8N7rto5rb8ZIn/gOORYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=g/0VIyvK; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-40c8ed6a07aso5568665ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 11:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1757355655; x=1757960455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBV+iImOReBPqWH0+/ePZkAazHev8dST5Y3pJ+QrJxA=;
        b=g/0VIyvK3h74HSBnSvv8Ng/zFHZUw+Dt7dGIFQk3+Th1KJII+X8+/M848gHUjZEBBy
         YPH9cdpP1Z2npmGLTg982fLyZu21+Gwo/6xg8HvkzRIKfW9QGd5MtFsq3CFD3tioqIwD
         K5gfy/CAOphldPWg1yGYdVEr82XhDo3p/4cLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757355655; x=1757960455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBV+iImOReBPqWH0+/ePZkAazHev8dST5Y3pJ+QrJxA=;
        b=thm8C3PimAEyw7tc/4OsSz95/9RVj2ZxMSbuEhCDFTR1gJVyKjFNQrdPWcg0TyFcso
         s1x4NVKQOv599RPEd6D8h6/lA9pBKBasKZiQ8Ht24UiHeTuR5UIAqS1bHAKZdW6+d1li
         sPkWLJsYKWQjF8AwGkHvLB48fgh5eOZHhPzsZJjFHiwlv/CvyLH+OxHr+PvnfMQ10hAy
         vyZno2qGCQ8j/LblUtLf4rDmHuf/ZnTImo0qPNNICCst3PZ2U8s6leA3pjXDRpPuTH5b
         nE6x2ByEboGmrGXIQzY+yktGlkOW/+2NHJ2zmzQE2LP/gbHx9vgEZJZiEONRZyUpRrKk
         nc/w==
X-Forwarded-Encrypted: i=1; AJvYcCXSaPlB+FB3c1FD7dhAAqdkNNdLHV/b3E01L74QY5TP3/LYFe7TyUqdgDFy069aqMcIrsCh0e0nmGhiLbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ3OZVWo+ZRQsDML44YwVfmMf0/pPgVSK+4uNyg1gKjxg38q7L
	vbMMMzm9//sVOCnjdZbt0Vi7p8wx55iRDnpMvyc5dQIjPS6SPP/C2HMq+xCmAQlSdA==
X-Gm-Gg: ASbGnct1EcLgr61C26FNihz/Dsmz6xNiphnQ6Fba3nKDz7hJiDxqS1cvy5BdPI67qKb
	zicnXrqBz8QaMaXuiom4fFKo9hFnEUY7gYZiKfsl0ZvMu301nFYXKI1wTpXZERL5+/qrqwxGXHR
	JspZQAGoxfZAWZGUm/m8DxnlmnFDxOQ4LrAcKz2yahE2lUI3xCn8fuZqu3DMVHLmW/GSh5XTntM
	hQCDIKphzDnoumq0w8ezfKlFKlFVAXLDf2RCdr/QAMYl5yNJGFWdccCFQip+8heXtNiygoQ23mS
	9D5WurDzE3wP1ka6jRHN9n/wig/wzrYd0IWxkHndLvxOzv2q/uCuzk9rdsMARhxgfBn+/3RZiIb
	gzruyrStDF+d5n/HDEGrIQxw8RbcNBrsekoMoALUwDWabxABiotA=
X-Google-Smtp-Source: AGHT+IE/BUasf1MdEX0bTcfzQ1t5u2MGL0J2BuN4ERdg8XHl+2w+6N/iuG7UlaLA0C1871kNgg5oOg==
X-Received: by 2002:a05:6e02:1aaa:b0:40f:be7d:bb23 with SMTP id e9e14a558f8ab-40fbe7dbdb4mr1707655ab.17.1757355654594;
        Mon, 08 Sep 2025 11:20:54 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31d0b6sm8858916173.42.2025.09.08.11.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:20:54 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 8 Sep 2025 12:20:52 -0600
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
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
Message-ID: <aL8ehNxQ_725HF9S@fedora64.linuxtx.org>
References: <20250907195615.802693401@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>

On Sun, Sep 07, 2025 at 09:57:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.6-rc1.gz
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

