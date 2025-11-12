Return-Path: <linux-kernel+bounces-897499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A320EC535F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191314A6462
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0030923BD02;
	Wed, 12 Nov 2025 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="Z0vYmB/k"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737933DEF7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959625; cv=none; b=mmDa15EYb41IxbDKNmADiKP9LrOMFKMPCahu8NXbwLmqTxcOxmDfp0tyVYrpTBfsn9qXzKuMlHIGORufzEGtr08vk+XCd7vPUwMnPBTLg/e1GoFt1pto/Dn1EbID9lmtPe9YwNYY1bYu3n/fEhdFw10YInG8qUk//AjtZIgkfhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959625; c=relaxed/simple;
	bh=PJk3WBrYdf7Tyo77E02znNUc50rN6CzDR9RBvtG6MM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfHTNE8ivPqRDRpBuOgjzPN4L5IyMf5LdpN8xdjDw5evdY5rRbGrYszh8RKkQjeYZfXLhMsmSioVsxlGJyd0OAS26WI8kD1DOc0EmBan2t9AfZfKeaYdwy0F2nDK7TQiMNWG/+Ejb+w5zixXZVco/jZ6XFZBPPqMhSnq4APaYMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=Z0vYmB/k; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b1bfd4b3deso77995085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1762959622; x=1763564422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zXj8Vw0xd/qX3+ihzUkZ+DSqDm45u5a8I3Mp92b6iE=;
        b=Z0vYmB/k01SIZ38kS+Z3DNMoPHpMK2OjQqopLQ4yS8/IEgccYIrpq0OtDFu3MZxizm
         wkYEkOnybjay74OcwMK5q6Yky2pUmeN9ngB2KmcFsLumVzyLuKjeP8vYKJzxYbt7AKok
         gdizIBstYOweU2cDa5m4xNZGps4RmO4avfxi9ydqwKsbptvCy3Q6/9URWAbfNptk0NIH
         WYkLrcb/ybs1iDalnlD/IkSkZeeTFzg70gZRJDAmnJsNgNZNsauyNF7gz07OeQnH1Orn
         gjrgW8UG1ohYYtSS+MYRDu4N8nh8EL1VMNUV7rc4AJjbRDi8EGkxVJZJ8Pxa2+jbR1bu
         siRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959622; x=1763564422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zXj8Vw0xd/qX3+ihzUkZ+DSqDm45u5a8I3Mp92b6iE=;
        b=BSVDxqBYw3aKu7q4mVYr0ZWdV5f5jc5qRXMl/M//GWTtX5Pjdc/86cwe8ZrXr/AXQA
         SPwWyOj8YuJ9u779DVdkfZsEfT/jmp222GX1mjvqkLbYyHsWnhrzboxiEgLyfkw97wgp
         +LroQbUawp0+fktU+XsNZaTOg1aZaxCwJTylH0gNKsbyo6PXH6pEPUQLpolTH3X9ripY
         Z7AE0cBr/+r1YvtxqDgU8YDzBZedZdmB+SDq8OclHGhvOx9ST1Po1UHhoMfRKzfPX795
         PZbTs/CtP9+uSR+mirZO4B0TE7QVdQOO9CfJX3cXo7bwvkG8KutIbVwz/f1Bi43wexvR
         /Dng==
X-Forwarded-Encrypted: i=1; AJvYcCVGeqC0KSKLwJUF0T3hTQ5J6UDHV5QA1qhv3TY3r7lUez0orDRT7Fyedtz8PhZRW4z7mD77GsmZ0RV3p/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwshY5DZKLI8ump+Dbo7XvHj51PZ9L/2nu15PcnDBEdvSBKh/lC
	bFBTDMshRG2RuziuzkLmBH4wXehUbnv44h3N9md9FM+QGL3TuvLPvPU4hF8EE9J6SIpjDGa8a/k
	yAlc+c1uenNV6d+1UK0CvEKZ7Ypj/KgVtaxlyClfmBA==
X-Gm-Gg: ASbGncvWWvIq54vtXKVx8sqg2Z3INefpCyXGybA0HOTyU6Z4Wka4uSAc3A0kNTvhz36
	yxP+lTp1HUYyln9sElnEF3pMz1s9CQActwurib6KkaZfh6o6oczxKYjNIu6LZHIqep/tZy1Job0
	yqkNadOLRsdTjvkHFkxysgTDzlLBMzlADk3NByWy3BqCjwydsRu8l6gXDmujoPJG7K789C7KGQc
	BWxEIKpNbUrsPgDatwZLKgiIh4gDnwRPnGL4FXktFyJpaJO9sNdcCDyn6KCFPJvSKjrDuOE
X-Google-Smtp-Source: AGHT+IGGxwpT70xdgCvNPIbAid5Yr2yjLeHLPdRKOlMlldVAPeBVEplLhReQ6HO49sUo8UA+RLI8nmybAhzhOWfAiQg=
X-Received: by 2002:a05:620a:4452:b0:8b2:295a:bcec with SMTP id
 af79cd13be357-8b29b96dacemr411166485a.88.1762959622363; Wed, 12 Nov 2025
 07:00:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111012348.571643096@linuxfoundation.org>
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 12 Nov 2025 10:00:11 -0500
X-Gm-Features: AWmQ_bm34fQ2h4Ko5Ao74lfhzAP12s6Mwur0ANO5wwfSG1IMc_s2OBnSCBibTtU
Message-ID: <CAOBMUvgGc=a9BQzoEjZVR76=RjYVBA5QSFh7bGHCGZi4VEddVA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
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

On Mon, Nov 10, 2025 at 8:41=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 01:22:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.58-rc2.gz
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

