Return-Path: <linux-kernel+bounces-732529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441C3B06825
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DF25648FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA402285CAF;
	Tue, 15 Jul 2025 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="eVzGOSpM"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92A1DE2BF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612879; cv=none; b=j35C9JhFbh3cOcFJVn8wzJBPEoQ5WKCGP8QFjNe73aseVKYoFLHKAUSIcARuYxfkd/TxR6nKz6PdZpBa8nTV7S3+CwDQVil+8W3zM5ojK7kZB601zDLZuDVB7Mw4K8YPuMr7JiPIiAdFqs+GuR6OX97UqG+w6D7HZaBR4cc+7DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612879; c=relaxed/simple;
	bh=LgzU2asF5k3vCSDeX/qaDB63uYpGRuRl2pAYtPM9Er0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZklyC27J6+8VonFO+ORCgcNNDYk1kO/4XgJY4wQMiBoega8PMlt0k8wiYUhMCHbTZxU3MVOX2huSt+EMwNW/RN4iyjc+s0iSedx/XNVmDRU3QhP6JQxw50c5iNXqM0e/qHOCIows8nU4M2UUfTx8/MvaZCzT8Fsyf2xJfrUc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=eVzGOSpM; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6159fb8b2aaso121357eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1752612876; x=1753217676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dswGOwktWgcG3nWkirJ4ZrbQLweSksGqsERuN4NP0eY=;
        b=eVzGOSpMu/TYis/YgvFJNsqvRhsB/VFyOE2RZHlF5naj5L/gj+4UBpenU6YEvnWO8I
         HXLf6ynYhHheby+HkMM1RYNAyjCIwQhlCmiJ7eycv882bMgAAcg6R7PcvmLAOxodOrEl
         odvAXsKS19+vPuYpUzz3i5Z2EXhXoJ8K1Ur4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612876; x=1753217676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dswGOwktWgcG3nWkirJ4ZrbQLweSksGqsERuN4NP0eY=;
        b=YsvVKR6szXnNDaq47orGkZHJLtx3meoEGMSySaHQ1xraLK4y+ewdWsAbfySwJjGMub
         gelsjGZXiiZCeETRD1l9eMuMSjuagW2zyw4yojZwK9Hfkx92J9jGCLlI65PxhYHjz7K9
         0fAprM6t0mdYa0altaCkynM+ydFVmI3Oq1sOE+FcKnAM9bvcxP+Y7jHgXYFtDs6V1zeO
         ARlU2l/sTGMOeEH+JufL/HqrS6qpzM4OIMbHVyxM9snSsgQkcz9O/380rrWN5xklFJOX
         Gc+/wfaNxLvnILGYgomIVeDgnaXrZb/F9FqzuLVyonZ14BgY4bvP2Sdqyoarb4I9BTGV
         M4UA==
X-Forwarded-Encrypted: i=1; AJvYcCWpvaVavky+D0/Rwwrxdp6ip0m1iO06UziCDYTcpHbPe5WvqwCPAC2hTHf0/tljkDcejDZ7ottdV11tmgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6Fb2Y6JH9N4KBEYFTz3P2hcn16ZdhFUioojAnORqnKotX/Je
	WJVOs5+x9Gpj0G0QGOVIW3Tcn5zuZbaQ5Wz2TuQFWAto6e35X0KfFyWcKc6OFHtaWA==
X-Gm-Gg: ASbGncsyWkFTyJfn0HO6CHrJyuOefy/EG2tvdtTdSIbUnC6YYPJPms7rgdP377KQ5Rf
	poJSodFu8lPH1UdurA63a1oS4Wmv4ll4pT0b2OC5aIM3x+WO9J+DrZ654K/Ci/v9PB6g02XIJcb
	dbECzOD56pmfueKm5c5TgRXavvsIfNNo0EWmffWgUlVOdQ0ofqAS7lL8FaOzTbzN99saIYJr8hW
	V7vO/s5UvL16GRFbmdAXEHKtM+mFT3hqCCPe7rwd7cr3JGDveEvMZg4NWPIE8PV1uUgwY22LUtB
	6ctZejmd+YvQ3MmKTmw5hXR1U63NpmLs4IO2d4Za80zU7xYu4Rp0CoOD/agOUlre/kfQZ3b7gOI
	JBugIjq7Q4VweWEk0msWKLuTltLUpxGVWa6zvZ2g=
X-Google-Smtp-Source: AGHT+IG4xXPN2wvRnEfCL4V5sXmNlCYgQJBzs4thoSEZ169SkgQkdBQK8ezpsfkZiO6kPftgImN21w==
X-Received: by 2002:a05:6870:80d4:b0:2d4:ce45:6987 with SMTP id 586e51a60fabf-2ffb224847emr297680fac.9.1752612875994;
        Tue, 15 Jul 2025 13:54:35 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e60109587sm469093a34.64.2025.07.15.13.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:54:35 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 15 Jul 2025 14:54:33 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
Message-ID: <aHbACXMz1Ype5uW5@fedora64.linuxtx.org>
References: <20250715130814.854109770@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>

On Tue, Jul 15, 2025 at 03:11:35PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.7 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.7-rc1.gz
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

