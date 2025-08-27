Return-Path: <linux-kernel+bounces-788614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B622B38746
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A423A7AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC31139579;
	Wed, 27 Aug 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="N9fCFlpN"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3E2AE7F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310664; cv=none; b=YMMvdGy4Onw+Np1fF3jThQQOH5wjjSlbno5sZD6NVP/cDZt+G6dgeT/iTXB/AKo1gGZbs0mvM+QoePqOgKUVWH4BvxpEpa4XhusltpOanaGJn0QLmWBEqG7Bz0D/XqHAQ7flRIo5+Jz1dS6A+1Lxdb3qXT+lCqr0JfdVmgm8Cro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310664; c=relaxed/simple;
	bh=Q/95dte0FRIox+Mc0zMjJdCZnOlDTQ2BO+SbNB3I05A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URMUqqo4na8k+17vj9ynj0PwbNY7VMsM1C7L1Hu6yVOPPTzTm4YoFTbG1qr7Xm9WEOWUZCvejLxvNqx2JovV0Ocn/QLNzQNEQZOiZhTP3bUM+M7dsGr5ZMsTNLoa8Uq6MbR4fZqa8EMePkM9o5MaU06vD3bm78LzNXB62v3SCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=N9fCFlpN; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7f903bb47c7so11171285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1756310661; x=1756915461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O01BKWKJMhnsa1JrRHWzprMGs/4GQnb9M6HdYZRlFI=;
        b=N9fCFlpNVwQKMFSj95jKfLiIaV3Yfgus54hSQ92h63LWPBudN7gfFNT24LyE0rIrw4
         MUWleWXd/aOaNZmtDy+GA0sTi4YQ550WzS8YwEyqNjANQTw8PN5KqeldQbwouqXyUSu8
         028y8pMIZdodDKm2caFX2O4nZ6AZUVn31YN4Ud0BPexlIB0bmWqsKHMSBjlAVex8DbLW
         QxjTI6rPG72KcVzsx5K+2Otbbrqx6uoLKdE7zpm3STSb/YsGrc7TkQ1kmKjin43JtmTk
         dp4HiSraBqzIR+bxkpZpi5/6PUewOsWFWkI+Hqq09mpPrHgkKb6OfidkBbRltmDOUwd9
         O/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310661; x=1756915461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0O01BKWKJMhnsa1JrRHWzprMGs/4GQnb9M6HdYZRlFI=;
        b=cGH8pFlHfEg62ZNJ37zLTYmVSWp6QGXN6+ZRoHWfZCzmXxKSAuDf+INZK+PH4NWFQ5
         THWSTEGMLkyqVimxema8lBpRfWY26G9EU4OMvh9Sl4I2hAnwYkpAaQ/2f6DaQNKKByij
         2BG56Rem8y8TpYqwu1Hk7LTSD6GppvlIOc2NrVTnO2HmtqCUT6ndipCLAeLqeXXP+HId
         FfM7HeIMVbhwlF8h+HkdfXdQe5noBjhJlIyd/oK8SPtKCpeRI700QijCatg0QEt2mSFm
         k8HRgikzyhPqiTWf0XOcTK4/ozuLpivPt7BV/JmE1Ci3T9MZlE06LLGbJPvQClwyM/Y2
         0Uow==
X-Forwarded-Encrypted: i=1; AJvYcCVATYk8rTvMF2EL0DYuXC4UTJNlZumTykbN4goR3m/cVUMBM+wTSlUSjsiKdmhroxIyWYQSK5560BYxQ1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhSVsK6McbVW7ZaYz/tbB8z8xT7qrdLNt2qqFKWNTw3+YPmvGH
	9T6p9DEefc6thJk62O+D5ZeF16hqQiFkqqXT9lfAYqKszT8MugkHjkrSVKDKrvst4G0elK7vrhJ
	3k8U1wLPv+ZL1AbefLpluUjQnClfDJ40m3q+hiZ/Mow==
X-Gm-Gg: ASbGncslg5uuZ1AcnsR8tqofEIu+RvZQoWmAtGIYgpH3CgOiay3e/eKeAohlEim/WsJ
	xcK3ZeRUBJqkANkAkGq27dKC5DduOEQe3uUpEI5wPyFlYxyB6jVjNZcNQnXILRFTphaz+2xFKWk
	qPOZfEURcOfPxzcr/CTanitCk9C0wr6IXE31EQgFMDIBsGR3puIRBQTRD4O4yrvVFfX6Gskui35
	M28PJ+Y
X-Google-Smtp-Source: AGHT+IFs/mwXa9xjC6cm8maRYL98DbbuhF4eeMipGDRxTRqWXTH3hzFo9Xw+umP930+5MgqlefdPLnRTlR8sFlKKbSw=
X-Received: by 2002:a05:620a:171f:b0:7e3:3065:a6b9 with SMTP id
 af79cd13be357-7ea10fc7a86mr1947926085a.7.1756310661271; Wed, 27 Aug 2025
 09:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110915.169062587@linuxfoundation.org>
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 27 Aug 2025 12:04:09 -0400
X-Gm-Features: Ac12FXzyI1vWTwS2g7VCl4GpPis8V1-XUBHCDNtNCGs_MU3ZX-OEWDTPVk7Brps
Message-ID: <CAOBMUvjsdK4G-eDqQksd2Nguuf-RmdiY7vmkYRLDrtPpwk5rOQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/322] 6.12.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:13=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.44 release.
> There are 322 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.44-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

