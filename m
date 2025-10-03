Return-Path: <linux-kernel+bounces-841756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CE6BB825F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C6774EEFF7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44B52561AE;
	Fri,  3 Oct 2025 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="k2M/ReJg"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE410254B18
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524691; cv=none; b=n7E3/aibtuc1suc8DYXJazBKlldKLP27uMUuik/WX/vfPlZ9SbHYhadTa58f8fnI/nMvWLr2DiE5BaNirBhPPkXQ4pcTB0Jsd1GyPAZ2ePxbJCO53VSQzU2Hnlen68B43YDxpdpjuzU1vGme4ISuZouRbuPNGv2n5kuUPmYH3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524691; c=relaxed/simple;
	bh=bGf/fVMq7D81Q5YNB5Z+ahF/or+jbs9kwSx5EKrooY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ta9t58kUe4Mj/8m2wV5B3SiVLjbiVJQPylZ6hl99SuSg/I7JVit2lOOd6gpJpdHN7jkmYvpDJtRjNlPSXImM0GU75ImuGklZ1HhWWZYs5ESVnV/Fw4RZ8NyVlu4S8OX3WKCoZqY4sHSEOqOZ3wYwEHIFxYjHbOf72sNYMl+yrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=k2M/ReJg; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4da37f6e64cso27479501cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1759524687; x=1760129487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z9OJHsg9AnDgBWFYYVznso9JgY1ikRBT350Nr1kqdA=;
        b=k2M/ReJgV/PIPf4/m4x1RqbifFPwBk5bqmg8At//lqk6DpVBhDAm6KT4/g2mVY1DEA
         2X0Ac4C23kFdj2Mos7g7JXG9+pZHCBLeYaaw+h/iGbMT+0fHaviuoapGj038Ccl8Zat2
         eRzWm1Q3dwSHgL0go0/W5FG09tfDkyG4uULYxOF+puBvARO9pvQTt32yEAMg92oXnql9
         IUErb7yQeBzFm6BnuB6SeVU4K3fiM+g50n9rCflqYg7cQhXK70ta5OxRHeXHv+rAb6Ox
         b/dlWauTsRnEdQV09tGwWa6Q1NspN4PMi0eCIyQakckYXOZZcoK8vtk84LT9Yh9l2Cm2
         tFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759524687; x=1760129487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Z9OJHsg9AnDgBWFYYVznso9JgY1ikRBT350Nr1kqdA=;
        b=spRbYVuvCfxvreXTnNdrtk2XyeUqUliqph5PozciTARGm13tWu1yoBK0sunkc5gNQ3
         lCwTxo8tZzhvx7J8R4P+KlJzLNI/9BfvHkOvg6YJWhwONWJP4cg6QhU/ktDD4cABAd6y
         QmJkO/ilr7cg30sjohIchWv2YZ7JbhA+Zxy35hxiur5VnCyX+SyiHxC0JTcOSYQPRVeo
         GH9E8GX9/B1k2IwhgpJjkelGafgF/NfQdFmoAelIkrjAxY+mWc1qSySD67SBZGnfMRAq
         fNvJtOI/+/mpY9X8PQXrk2OmBkA/Z2XdjGhWwxlL5wRXY2qxfC1+Xt7k2V4x+tCZfB1k
         L2ng==
X-Forwarded-Encrypted: i=1; AJvYcCVC9hCaUnC0Qm3E2f7SDhhoS8MoM2A/4s6T0K79UYOUWc1N/Utq9kaBQnrnnoolHztd2iZynepohxDZSpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjDrO429wJPE15Gwn8TodWZPpVm6ZCZxAzg9UOFzUAnQDGo/wC
	naYdEtXyqnHqkOBfpV4RNEE6bewZ6W9UpNCpmd4jjw1RHD4d/q7metKi+A5U6tFW1CodzZxbrXq
	Px5koYVnU4qPi/jpEfzsohUIsUOrza1skXxQW6oy4Cp75kry1BfBot0FQ/Q==
X-Gm-Gg: ASbGnct5ZSd6PMciLUvxcj3+mKVNrC3tj8vYer6tEY5Yc9WVQ5yNkhr5OotT0sT5zRf
	L3aNaVVYiP8wkzf7IAIgyxowq+QNq3UzZBoYzzTqyusA3244wdjoceeht4tY07L8vCQFXdPA3/z
	JhONcfFajuzmrWUN9Beox+/DEqsFcyuNdRk4jWhraVv1iwZeJy5PYmn+wt3+ijvKBbVRYyWRk+C
	wZk9VubmGcLLCvoIaPUTDHyqHTwZotEDvbZOatPgr0=
X-Google-Smtp-Source: AGHT+IGOFuK5QKXUa0EoyQNwTfrrar3OCp+dKAGP3fEaEJ9VnSeYg1Yk+ezWQ9N6bxp2R87Mtx6d9Bh25m/9JjggpuQ=
X-Received: by 2002:a05:622a:303:b0:4b7:9add:76cd with SMTP id
 d75a77b69052e-4e576ae6ba4mr64596521cf.42.1759524687516; Fri, 03 Oct 2025
 13:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160338.463688162@linuxfoundation.org>
In-Reply-To: <20251003160338.463688162@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 3 Oct 2025 16:51:16 -0400
X-Gm-Features: AS18NWCwKeFKfMLlMvvr2cSuujlh1BUpd9drr1fldSku7mQZdxTUWOKjj9ta5Is
Message-ID: <CAOBMUvjBZLErkgx=VK06QHFBJZ3rLiJ+NdXitrT7PUnd452Jmg@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/10] 6.12.51-rc1 review
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

On Fri, Oct 3, 2025 at 12:08=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.51-rc1.gz
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

