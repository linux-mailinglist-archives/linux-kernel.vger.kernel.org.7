Return-Path: <linux-kernel+bounces-873935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BA1C151C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D819644055
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A0335BAA;
	Tue, 28 Oct 2025 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="Z8snaPvt"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B930FC10
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660563; cv=none; b=G41MvlUry5DwDo6amRWg7dIXESH5bHHIMbeSh6jAAGjdOoSibLCoOFObX23EDLz7EH2jW76y9ajqYG3DB8v3FLjb3sRVcu8+PyhQKPMgeR/0HiMTn6SFNXjdGQS0EB4OpyQegdD9yvraky4/foc6jDdWqzImP6RSVsV8i8TQY6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660563; c=relaxed/simple;
	bh=AdnRw7U11fEVAUyQ3c4ltusVoJvhyax3gV4Hxys3+Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NekHFp8CfusDNhUZ1IwXf1y/82EQqvexMI7nO500urly1lAVEWJM1+a8MNSd1odosppWYc4dRSVKmDkXbKKaNVOcsnsecJue+aGciYvLqcvsf6Y+rCnzCWDuMqKp/VYtNJ/9eV+qJDcmTzdDcSBtJuQQD+9KEmPUd6MGpCUdpp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=Z8snaPvt; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8909f01bd00so645179985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1761660560; x=1762265360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zcU8dbk3YPaQpFZh0LEGbD8GL5cYg7PwFTIPigTrJM=;
        b=Z8snaPvtntUhFF81tpuJKrbRAija26SAyLnj8u9SKvi2gLZJIZKvbbcYtax9wCq8JT
         mle5zzxEoqiwfoPYDqMrSVerTR7OrkR4L/1IMJdjHjQ2MMGusC0iHIX2IySM/c8fyucg
         oCDYniXxQnUYt4uIaLsHnADB1OOKo9x6bGi/qXyOrF/83NCvmYVa0yvnad3vH8unsTby
         y8gC3VxEOFAxKISHWt2XO8fm5vTBPqYbgmT9b8w/j/VjnPLqJkiXgQ6LHI3epttxwasX
         xTCqE5vTXZ7HsuK27+4ojGmqIU/NFtupn3fbGvlltasgTeuGSvdo3CUyKej88psQI7nK
         IUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660560; x=1762265360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zcU8dbk3YPaQpFZh0LEGbD8GL5cYg7PwFTIPigTrJM=;
        b=IGmTYtSb9BVurT8vHGk9RAeQeuMOiFuuuTXj//yUtu+2GrGrE4nLLWAoxV1dd/ksa1
         eaSHFGZNMwvMhEexY4aANn9uPaflaWVJff7zR3l+f0lwDtbQlN1bRI9H7RnSsrWw6tFL
         3VFq0cyIZnW2Aa4WmfFPuC3lJKKqLJ0iLFqtwEb17JPB/xs5wg82ciOSVKvri/hIiO/g
         eabQmCxffQR0xjc8Peg5HngQwRYR/sy14IGfDh7emhjSJOvt0AR8Ri7AiQiksAXA4OuX
         k5lh3e8fN/mHdMsX/W7q+PlSLKglA43kR3uwo8pjCUQyKEZlZHpEcDIkFkurqLpCkeq4
         /WCw==
X-Forwarded-Encrypted: i=1; AJvYcCUyN01+b2NRSttjKKDBPMB+jO8GOFaNg3gLrA0AK/vEFLOHa6E505Nuvy5FaO5eHwWUnVxVWeUAFrao5/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0h3gLSyVx3NXKdYvGsxcrH1QLHk3p9oVL3mvIlBlUvf+NqrB
	1n0hvN6lDv/t0u1sbGfDJbcxXXzAyRQ97CZe/m6jg/Whg/Argw03Ca9JHUa7cMdN/+LIdmd9CT2
	HH9wOFa6GLRb3nDWgRqneaVgyEQYKGAR5pKNN8ru/8w==
X-Gm-Gg: ASbGnctdAnOuLhejrNHI5sTklbV++35n3NY906KHBIXeDLgtekukESz4DV+hMB7YdzH
	wHGOktJJe55lDN6jUC8hOeqv/eT2NT7aDu/6B4m2FARwdS7Iul+XlG7ZtgKTVNdo80ICu2qzGC4
	eAfdzDshPCED7//8GQgCbK7JvqO+RS/0OfMGJfenrhg+aEAWLyloJczZNGYs7LX7OOGSxLM/VyO
	MysHjPtWB4FYwsjzjeH1dXSnX79hjWqkWcNHgzYTmF/cAjZF0fBKXjYC/iGkg==
X-Google-Smtp-Source: AGHT+IGeD0rlHtRDBvGxpdgqlidUafHqhsh8Ky9XoEDN3FLfwPUswXwdlMrdSNVbbnKnTlU7nlSS8qkTv9BYaTfYk5o=
X-Received: by 2002:a05:620a:4711:b0:856:60d8:3688 with SMTP id
 af79cd13be357-8a6f78fc5eemr447314685a.47.1761660560137; Tue, 28 Oct 2025
 07:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183453.919157109@linuxfoundation.org>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Tue, 28 Oct 2025 10:09:08 -0400
X-Gm-Features: AWmQ_bmdkmfhBJpXFY9QIg-9Nu9KvuWXlnvP1dY6QfRsnqg3ap99m04OvaHDYGk
Message-ID: <CAOBMUvjZR4OL0Ffq_yZq_-4nGNAQnicFP8mXqgc1tCtP0VvVsQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 3:31=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.56-rc1.gz
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

