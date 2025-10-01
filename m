Return-Path: <linux-kernel+bounces-838978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF2FBB08E8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F6F179FAD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AB92FC00C;
	Wed,  1 Oct 2025 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="gATOir/C"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732052FBE0B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326422; cv=none; b=AAtZUDsfRDEuc8guJ0EgKBYNkodSKdQcdhaUvQLbcVtThzoVEze8k6XXlw4hgJH1kiC7Ji7/XCNYCFmDojdPoR833+sgJfn0Fj39v/ltJvg3nDaQSAYFMMalLTAQ7W9OhkV0x1nqbIIAA/1OkB/fmoYggeKYkXqdnJUftDvxy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326422; c=relaxed/simple;
	bh=XnzBrKkqhtzozb80b9whPjYrJYlVgO3E+tv6VeqoZHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwZwTzYNgjuO7f+yFeG5yz32a3ucDsCB2YO39pBzatyAtJtmv0N8KwY1dJ7f/Gcp6ZhhPBglAaljauzD/DdINn6cpL17If3E2uPH9RcByFKStf3Jjo590ygM7oiPjK8ZEd7QEXDGQmfS0oDaS+zpMPmQPEHFH6k3ML4l8O4ECqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=gATOir/C; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-427e5121313so26339765ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1759326418; x=1759931218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W45Thb4hNfN9gWdtcaFXe+UzJhkD5Q1/J4+NgR3g+ZA=;
        b=gATOir/CfwnlMXvJarfUaw7gikKwa5EaC3zYyW9cXuRsjdlGCKhK/ln3GepxfAOaOm
         FlhwdHq14Qd3sumTo/ez4yecJ3AFYglUIx10lWtjpj1CIOGoFDsk31rD52lu7MgtT2mn
         /5Or4EuaKDWlQeZuV4xfwxr+PrJeW9baa/oAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759326418; x=1759931218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W45Thb4hNfN9gWdtcaFXe+UzJhkD5Q1/J4+NgR3g+ZA=;
        b=Jn6ggdWFymvP5aK3Bkxhm8xTYxwX6lrKhfyfpQpsFsBktkfxcF0gMq642pkoW1J9fr
         qcq/eStKnHTkLN3rd6kfCkEajvFbuRnNAMSk9hbidKuRDsZKygJ0qwxrVjn6W3NjPglH
         nrrgrCiW+CdBYjfP/ltVSi3yM+/Yi5jJllgQzqe0gsyhPAO3xozVeTvY0dFmQ6/6dfDQ
         /fNHz5Fdd1tmy6d/nLcrPO2tWRjYA44cMgfKGYBaamR5McWSKrZPglI/7aSZtGOuBYiX
         koV+u7vYCiu/i1Z+BJ7C+3quOUK3U7kPz+n7aNzA/aBckuQyqlzarvPepRvM58fIvYvF
         BY6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmBBi44RFxxwYc35v1sMF5WTdG3WtnwFNaGDuhtx0d2TiSK6pI79+VTLVHIp2o5Ja6usSKvQFDYQ6QdS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuDWJcIqpLWQzOvikUg19Zj2X7iO43S/L4kkcPOYlE0wu6hdjM
	5nos/ZWGlpCPnZ853ehMCohfE9NckGJv3oXq3X3Oe3rPeRJIEVvZOsrT45Xl8M8icQ==
X-Gm-Gg: ASbGnctk4KgM8Kn85CdaAA6nE4o80uZi0oAWblAXP6VRqnEjE20hciitjGpWQlgJc66
	wnWKPJy2MOpNpubaccQNYSR4k4mcZ/u43Vl06cx6Cd6xiBWRGv0OnXbVZfYMQWBQVxPciDqogG4
	PMdt4BeqvzwhFZirSmYuxNxeM64V5m48DRooLrZNfSQKj5F3spA2r+sftN6SmnK0rpOU5wrEEfg
	s3cg5iKyFjvYxhVmn+dn7plZfAevSI7ApOJ/FH6C7oMdF67U+gKdZSopF5jLkLgBy6v3ccXNuAq
	FLIlUPWxFNsOcFKr3yCQySUcAfdtqMPysd3Sn1wrY5eIS+Cy+Vpv9l4+lFIiRfvoqo3AN5W8YwI
	BsqmsIQuy0cmrUv+c1me0n0hcVXrPYbfSLh4aYKkUN+Mfn1aeCSK0NKH5tc5YAziPI98=
X-Google-Smtp-Source: AGHT+IGcnVVpdzqOl2yJnXH/xAk2zhNyBvJcfPwTkWYHDx3ZGcmd+zfU56UdL8Te+QSrukeDpCOkzw==
X-Received: by 2002:a05:6e02:1a4c:b0:41b:6e7b:3e9f with SMTP id e9e14a558f8ab-42d81676819mr50599705ab.19.1759326417830;
        Wed, 01 Oct 2025 06:46:57 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.121.65])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b58db188dsm288004173.33.2025.10.01.06.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 06:46:57 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 1 Oct 2025 07:46:55 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.16 000/143] 6.16.10-rc1 review
Message-ID: <aN0wzwSnbG_K4xtU@fedora64.linuxtx.org>
References: <20250930143831.236060637@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>

On Tue, Sep 30, 2025 at 04:45:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.10-rc1.gz
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

