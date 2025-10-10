Return-Path: <linux-kernel+bounces-848749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C5ABCE7E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A45994FA71E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A61C21FF38;
	Fri, 10 Oct 2025 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="mdBmyPed"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B91DDC33
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760128226; cv=none; b=p0RCc/EByDjqn7olJ40NeepxVl/+cV8v0e2NRzrO3S5RR6KJenRp0F47M8/TagFtj33qem+JEG7yZNO+dt9nXKBQge36PjMndfTsRsJVYglWoW3D/HuMQ0CRkbPh8h0hwCYWib6BvdBXvIcRhQr11PTAV4LfK4elF+5c3zuz7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760128226; c=relaxed/simple;
	bh=9A/LumBEIKcjOP6VHI6kMCIyzUnl5vaceti643YJJpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVOAax6BpIi8f/z6m5EqQOzzFR1t5iJ1Rqj49bT9pwAZ6glyZqMD4ucn1MDA/ZQyWNXb2MpjYjuCJ2Gkw+bEIDOTpQH8f+7HMjJfzEGAjUG0pagtCDxCWcxrqSe7bsJJKb16oebln0mP8OwjiMmf3emWXA7TTsJQvMjPTvPiWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=mdBmyPed; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-795773ac2a2so23454666d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1760128223; x=1760733023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+senocMrwmKsaXZeJzB2jZ0qaAjcExrF8jnru4WCps=;
        b=mdBmyPedgefRjh/89eajco+kkGjEdLI+eoqKhXnMeAxHwRTdNsuX7WQpBI2lx3WlSs
         yto9h/UNBa101tvOgOtbDzohsaOt3zk4bTtZgpYWn6tiF/ucPmVXCp+MIu2h5Tq55ZpM
         cHVmbhg82BfAvnsIjBYPbETkx0haA5OzAUFrdOAIEmAY97k2o2VdfvMjVso4qDWnXpfT
         +XCyGJagGVHnNy4IOLG0jyRgN7NbxNGRT1vSmRm2QAKIF4n0u0M7oqaSk4jE/FamGgjy
         2S/6n3T3b3s7Fg9Bq726EuysCaiyBl+3vKgo27Z1C7yTFsAn/2fFx+JyFNaNlDY6yeqX
         4wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760128223; x=1760733023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+senocMrwmKsaXZeJzB2jZ0qaAjcExrF8jnru4WCps=;
        b=Dxh5zPTSU6HCSmGiZL7O67REU2jzW+xwoRFISHmA9cwydwbM6ugrbuEuc+LjdsQbOd
         a7MJkGQ2HeWAcLAm0Wb4MhfpOmB7ZUqhYCog/GYeoZLBsUYjFaR0LmNgUbdLB5xiuTVw
         61rZYEFps2gBpVoyySaOc9D/+EXjkeq75HGeW8TDwT4uJ+1UhjpeZoKsykt35pfWPmUx
         oMRKSQ97ATgvyQ5hNVBCH/SNZS6Iv4xiIHgm3fEEsZiuBu7VKl81cy4r+Q8Bf6OZwtEI
         CL7CXzJKFmvNawGI7G0BHcDFGx29eyL6UMv5KdK0VQ6A3230MTn7W7+AklfWbcxhIUyy
         /imA==
X-Forwarded-Encrypted: i=1; AJvYcCVndH1QWZh5lO95+0M/PTOqoAENhox/JbxtILG1jrbIVMsktx1GML3F655BkUHvMmrVH3rMTNODD43tz3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7tSuT01q7oYod/AOK2yvbisawuGXJj68SjjVIZkhM6GAgJZMV
	27z0/Mg4Rwe2ws5XSTft3UyHrCNouswhNoiKH0CbcSdi/AlWzBg2yiIKUP1EygaOydhrp8jxbOK
	5PPkhY7CkJdjTx7vAYQG9yA53uCZnOPbZ7FcVC3HnkQ==
X-Gm-Gg: ASbGncsDV8DUs+dGYOC/J+oLe+A0JrR6xvL2s077Yb4EkYvqFSijVxE3MBH2TDrfXop
	zsaB7drltyrDAzXj/olOBBn/zeIKQYaVaJWaPAamqrV+zDs3G3x9/U8SNmHzmAK11rg1qvRGffa
	HtWuLZJjDTpOukqI33bh9h+oqHiKcxL8qHRuaDnA2/Tell7ZUS2nHvtr1ym4psGQfRdSOxnxNXX
	XqNoD4yJE1tIqRMtows1O0Ct4iMNgpAO+MnvrWe7WY7yAGX
X-Google-Smtp-Source: AGHT+IGaDT2KJRVgn3V2uHg5JrdMPPQc76Kr/F3VIFR8OseRONCHJrHCaP7mg/1pCqM9GqIYlzx1MsO81oon8uA+GHA=
X-Received: by 2002:ac8:5d05:0:b0:4d0:bc99:16d7 with SMTP id
 d75a77b69052e-4e6eacccf83mr179102061cf.18.1760128223369; Fri, 10 Oct 2025
 13:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010131331.785281312@linuxfoundation.org>
In-Reply-To: <20251010131331.785281312@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 10 Oct 2025 16:30:12 -0400
X-Gm-Features: AS18NWBLUvy4NjkY7UZ1PNbxMzBt3vi-RAZIn1RsDpjfgXc3METhIL69fv1WqAE
Message-ID: <CAOBMUvjKaFZ9Y1+WYc4EkaQeMU+vP5bvV_Fx73JJ=P2fANztqg@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/35] 6.12.52-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 9:24=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.52 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.52-rc1.gz
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

