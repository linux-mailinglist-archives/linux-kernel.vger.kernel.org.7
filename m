Return-Path: <linux-kernel+bounces-742908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AFBB0F819
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 054747B301D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68191F4631;
	Wed, 23 Jul 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="JNotYbGf"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC97136658
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288056; cv=none; b=uc7s+ew5Lx+U7/dm2CdEIy23JF4Xoq143F0cOqBFJaXb6g8mrF+RSlpzOgeuJObcG7ZbYg+ynzJIR/uDqkPKlQ9cYZJ/aERcnRIUIyD2fFvTyV3aan2criGCUKT5gti8TSDQ6bBRfL6cSdypNAylHWOmgmR+cWjGdtAyR+Ct+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288056; c=relaxed/simple;
	bh=QHsEWJ65EKEeUAnjRO62w45lv6VLZRWBmcs6bu8I5Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL69KH5qLx5qrGd3ezYGsP2NFq0ug68JaiYELqJqsvmDHCW9XnOiYwnvsV3ktP0bpoFN4G9fh6qqya0DvmmE23jHscIWUfhgg6LKi44xPCzduoazvPeyRVknnxBp90JkeBhN1n/Z1dyYiIT20ZS66B+JSWbJMi3LMcxKVUmOf2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=JNotYbGf; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2fef7f6d776so47781fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1753288052; x=1753892852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6A0ra1sbjas+5Ydcn1mY51RGT/qA9lEFtptxsAU7TM=;
        b=JNotYbGfGtl/cbSjAfGgXMXVv4bj2rrkBdmRXliMjOiVS6sK/MSt7KOXKcjNfpwgiL
         uvF+2SUYcUGzo0elp106/u/sBOwJMl9Es12qnEZtMCFxgj8GsSuEfzxSf/Ml4KcFe3QN
         MXTxU49cfEKWJPRsyDWPibNRxECoEMeegWsZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288052; x=1753892852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6A0ra1sbjas+5Ydcn1mY51RGT/qA9lEFtptxsAU7TM=;
        b=TKp8lL29+IpSv6OtlwTBqG83rGLx/1k+yKhfoaZCXphbC3SE50ZsJ+TM87fSD+sRnU
         NZU8yXaWgvK/2V7i5j0Wb39oyxrBNOOt2KhwPXIpDY0301bKC4OhhkKOJjdNkSu0IiiN
         SH2P3xmpsuIOM92aM4AXVpvDVx2Vx5v68oC+PDJg8bXd6DlSnT/mUMnhno+kebysyZe1
         sYB/MfRHakawRaMUgAI4Ai5/H44SFIQIUGrY0pfxHdrwNCnxEQ/Zl66F7HJJjLCfTCuG
         mz5lF2MWCzg1Ijro/S0e4Wr/TV6EdEUVJ6egYcF4N0GGQNOILmU2aNwwAicnRp36DqYN
         hyPg==
X-Forwarded-Encrypted: i=1; AJvYcCUhFOBKEW3oSAioGO+LesB9W/SIAl/L3NTGRJjQqHdT+HCl91SLCb1NaQPgNF94eA2uTrOLwTpqwF8lz9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZWgsfY/eqMRplzjqqR3/pTtUYWji1rM2ltqCxauUihhiZ6/y
	CkLg3jh01iowBr2Vqsnb+MmVOwQIXK03Vz6QL+ZsP8HRAX3cFBkXOGOr+JOX2h+NCQ==
X-Gm-Gg: ASbGnctQukafjgrlatT/UxNvTxlxmU0iJD8D+lJAKa7O5gITnF8hVXAMn4ovKk/8m9i
	1Xo2Dia1SMtKlzZmQdewGyG/kOwphQYT2lK2jQkVbI81oKSL2rlB+xqxOiSTj2ZCnZj7bFABlz9
	nVNR2VS9tJxOT/xehk7c/Z+9J36tAseaKkWRA0XMR1D0hJ63qMT7iRtElNkgo9/8JH9xksongbq
	r64KzViohuJyvEuBozC+e5+26oVo9NNhwh0NfMjmsAF8twxkJc/C4IwoBpFhYW581pYS2jOCuz+
	BVS6P1rDdWaQoVlmEbYLlIAfQJspZzKzNgP14X4xP0BkM692kLBYEbQf2Lv1aRh5LKo6NA26vkQ
	jhY1uz2dj32gaYr0e5abTjySZPiI/7DnjddgVEVA=
X-Google-Smtp-Source: AGHT+IEO8bpmfpwvvlzRcmZt1Ivg71kovZ+W+IOSknlxinA5MmpXthLTgUWvuZ4sxkkWAFZMhb/IIQ==
X-Received: by 2002:a05:6871:10e:b0:2ff:9663:ca48 with SMTP id 586e51a60fabf-306c7350031mr2041806fac.39.1753288052151;
        Wed, 23 Jul 2025 09:27:32 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30103d1b601sm5150726fac.24.2025.07.23.09.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 09:27:31 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 23 Jul 2025 10:27:29 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 000/187] 6.15.8-rc1 review
Message-ID: <aIENcUTPkxpM8nlO@fedora64.linuxtx.org>
References: <20250722134345.761035548@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>

On Tue, Jul 22, 2025 at 03:42:50PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.8 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.8-rc1.gz
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

