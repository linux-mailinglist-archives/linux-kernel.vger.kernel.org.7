Return-Path: <linux-kernel+bounces-797124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22193B40C22
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D156A482146
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0F345722;
	Tue,  2 Sep 2025 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="ZTQGMEOB"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3521CC59
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834392; cv=none; b=r+hKzAcnOgKuhTFYYeNFUlupotPpJtS54HSuSVejphhN5C0XQJfWHS9jIfRFxHXcv30nMfMFJARoDOMpUdVi73tv9p2au9nalXuKNr/w4uFDvq4OX6uAPKbm/4EUpGUbbBWIbjg//7NRfV4pNxuxQFSBiEvfmGKyiquwN8BP1bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834392; c=relaxed/simple;
	bh=vSi44c+F/pB4RK/I8Cca9wMh9fClcpeVgwxtyoNWbyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSnXmmYEup42lozZf6irrqoi35+M3UKhUKUlRj6GUAEv6bylXPvEGHe0IPIbXZyX7A0i8YDlGb0MUi1RXc1W55RVeqj3bkMxFd4z6BbMcU5qKPBOEsnVP9YKk0/Q+fesQaEqD2OcXTeGdRgZVXesdRSDd4uZcxsZbnJNn1gGS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=ZTQGMEOB; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-74381e2079fso4543731a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1756834389; x=1757439189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KTz2L9raB5dHv0DWKjVffzBC8rLB5luuA/g5XJUA0o=;
        b=ZTQGMEOBeZQOUUD0BINEUuNzI4YNSAV8XoGLMTjnuodGnvWE/d3GSA9ondjbDuP9Cd
         nB8gM/xgkj8sOsmBakH9UOetSLMhxqt9gumoF6M37AWDHxw6jJVEuC/z6+rqdq8gj3PJ
         u8tC/MVwywLeQpYP6JDXybn6jVTIcX7HUFgpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756834389; x=1757439189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KTz2L9raB5dHv0DWKjVffzBC8rLB5luuA/g5XJUA0o=;
        b=ix2DEFOQDVjzRDAIYxN98viGHrxZ8Rpu8mZLZruZo+rPe7GOe1msMztnhZ0i1UbOe7
         Qq8n+yQYILjzDDqld9QcQHgDE8xduD6Sei5RwtwouGwkWzvKOHu0ETzyI15tdNG4pvNo
         j/UNQ9kleFHB+XMVOhDq/gEfY6zHrFaXIxsreZzJzasfvdnjLh1ptI/MM6EhsyUgrhva
         dO0cxUq0ud0JrQvz6prV0+479rqwiZK7YFZBbGd1hmJu/kqh4XpDzo0uhs7uqmeym0Qu
         asyDs+rRg0z2sKK13xywzIwzg2t+Tp0S0nWbe1vPWnDt4xSqDz+pkwFjRkZ2ZgZBHqwS
         EfxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk2ymscj8P02mLqCDNwNGw4qpTZYvxUJ9Pn6oZKzz8SRuLsVoagnJ3bMtgw52kHHe7GuiKRdHYqnfoB3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjKv6R2Y+WxppeM/TpmwlVKFpn4webKI6zgqboNnpf2lMD8nlY
	NhJAVG9tNxqh+A5MGiQWzecVsDpeKAX0zPLTNSDwZTue95Hal8URt7cOH7imqcu3pA==
X-Gm-Gg: ASbGncsYCRQTKD6sC+cKohqk7NBP9y0xzgpVGUKEZEK2dtxaY8k/JBZlEGylIb5Smot
	jN53t3nQCl2EVfgYeNo/7dEoRt+9OEqdeXGpVtazvK8hNjmqAo3q89v3pGMsZGHlB3CoGu68Urd
	0SGlZbinYpyp8cNA1VfVr9Yz/c2cEB9N3Hx0WA56tsDweam1m9ch/5oXDSUFMdpGcuWZdx92YsK
	rtbN7uVvCMwCDFP0CgclYp5tD7dahLgBUAQ7NjmJFAjCAYWF1dP45DkeijDsLndhyQcYCrB1w6T
	GtrVrgEQxqmNALHA/xYrw8e5b68cXBcm0xZfkc2zfBCqdfw0xRBXnvRwOjeLHWESQV6wJU2LCD/
	3/fM/+hLt6ziAMJY/I2a3NbGpcoWQZLoYe0owI5UDyUNuNgI+ysLd5VnpL6LFAw==
X-Google-Smtp-Source: AGHT+IEKZod48ntPYt/3uzppQZfzX++dethMHjVfzgn04A5ervfNM2G9qXouzn43QjM7p2KfwjeESA==
X-Received: by 2002:a05:6808:1483:b0:437:75ea:6c68 with SMTP id 5614622812f47-437f7db9457mr5956448b6e.43.1756834389567;
        Tue, 02 Sep 2025 10:33:09 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745743cd46bsm1705070a34.40.2025.09.02.10.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 10:33:09 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 2 Sep 2025 11:33:07 -0600
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
Subject: Re: [PATCH 6.16 000/142] 6.16.5-rc1 review
Message-ID: <aLcqU_rQeFwezfkm@fedora64.linuxtx.org>
References: <20250902131948.154194162@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>

On Tue, Sep 02, 2025 at 03:18:22PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.5 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.5-rc1.gz
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

