Return-Path: <linux-kernel+bounces-848721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A924BCE6DA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4097F4042D8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A9B30170F;
	Fri, 10 Oct 2025 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="AOV4GLcw"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655125CC62
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760125883; cv=none; b=XZzCbIZKYdv8O6iIOzjAJjmf6GaPrQi47SvzulVCdWLf/oe+X95N4+OKRf4t8BC7PasL74H84mrmTztYlSOkAUWuZHMN4WdNqkB6V0+UinmxT0OLTZwiwYhMlikXMOM2GVAISZGZA9K9IE6WQTvXxJoOb2/H+DiPTkpd9VrUMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760125883; c=relaxed/simple;
	bh=3GdRCdkK8i0HMt2ysyFwTb8cfB/yNxqn/yGQquteeC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbIhbQRXXPPku9H4eCTOohjWxVtVP1ZWEg5rsM6NktNBTs+gfO9C4nz1YFPdxIV6MTO9vx+0KNvhRkvzCndg7hMj+ZKF+aG6l5iEnFQiMiEeOeTjgOMu4bam1vBCtbL69k/xoJ7xs8cDwExogwiHd3nktcasF+jUZsnqIn4XGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=AOV4GLcw; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-64fdca63b41so1205995eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1760125881; x=1760730681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1mBRXfD6aVOZGe7ISkRTaKXlOb2UVmCyJNswlIaWLo=;
        b=AOV4GLcwRuut5H7EKUNgZJ9KSAEeh75K5SuCG3DlNYjDsvM0X8pepffq+vFPBbpAL9
         u6Tu/Tgj+X+gJWUzDGd6mT9/wPvp/1rp5ZCcPDqMh+8Fz7ntEb2mibnNdvyBEDNOHyiC
         HznZGz0gug1Otc5P/NU5VOLA7cdpFtm08QMeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760125881; x=1760730681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1mBRXfD6aVOZGe7ISkRTaKXlOb2UVmCyJNswlIaWLo=;
        b=diSsTYidXAOexCE1bECwu2DI6lKR0Y445gyQ4LcE/wAKklZkE7nKQfZERLPb0CHAX7
         PfcfkLwH6meJf1wYiyR9ScohUJMj31SSAHJ4bqI+uD94CbuV6/PTAmk7xAVwa/nF2XEM
         T5hop9Pmr9YDhFdiVb1RIy+FW14ag/anKVRVZieKKolGIYlVt37YPSfB3L4/w4/roQV7
         6iKbvsy3zepJSW8sao5tckKgL+eY/RmjGpcCEhInwQ3v63bzP+CaHU80ukK5MU8ea6xR
         3/orQHZVY189hyiE2OxJ2rHi95KUIl4M2Wro6uMi0QbNGGZEUS217gIRbS5EVGPVgS4E
         l6ug==
X-Forwarded-Encrypted: i=1; AJvYcCVoB9L9V+v4Pc6TeURaJpH78neE1AlkJPWwVKIQG6jUYY45zDBb1qC6j3D+IENPELfuE3WlYyBzrzqqY5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS3omq5dZclBmuj8aGTM84OhuTR+QFj08mTivIGxXB3RyPgoM0
	U3i33GC5lix2bmnSgRY3HoPb8Y11wCRFcf9/fnFXOvA1A1ehRZcg72T2vRLEuTTcLA==
X-Gm-Gg: ASbGnct3XCO41dyr2eirv3UYYlMw72du9KW59WLbEKPVtpNYMSuDu1bCMjQfIhxL63F
	ZuauFjlRClj1QSi4A9G+MNkkM4dnufzca94SE4WnhmK2KoazgvQRC2CeQlK/IXCQnKhCRZG0fdd
	21ly715pZP8cn4XR9O1E+IHhyK1RhsGdpR/2upWfJGTock9lIw51pERLX5AEMpamfoGnf5pQPot
	5EvtPlTtGr/uTo/yV2R+jqUgOYwjeL12hFS+S9Bm5inLrVg1GsZ0RFOECIFoHFs5NiqnGBKzbDi
	GyVHTZxjHK1yh/rIcTdem+NYizOvh6JZEmNgUrh9V+qKl2J6hA4mXA6bVgBtyenwN3Sk9vwyN2o
	/r3y8/v53RGjGasw9f5z/qfdnJ6qigofv+e6Lgm7QceviWMLoldW1gJXmf5donSc=
X-Google-Smtp-Source: AGHT+IFwv3HVSecz/sDwYByfksZk6QFqC3jm2lmV0c+tXg//H+sD+6ELezVqd8mcsaWf1Db3uhiT0Q==
X-Received: by 2002:a05:6870:a189:b0:363:d16b:3af6 with SMTP id 586e51a60fabf-3c0fa962b9amr6908046fac.47.1760125880727;
        Fri, 10 Oct 2025 12:51:20 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.121.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8f653d8sm1153620fac.28.2025.10.10.12.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 12:51:20 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 10 Oct 2025 13:51:17 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.17 00/26] 6.17.2-rc1 review
Message-ID: <aOljtRKkIwc0V6FS@fedora64.linuxtx.org>
References: <20251010131331.204964167@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010131331.204964167@linuxfoundation.org>

On Fri, Oct 10, 2025 at 03:15:55PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.2 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.2-rc1.gz
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

