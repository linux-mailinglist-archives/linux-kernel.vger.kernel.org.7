Return-Path: <linux-kernel+bounces-881628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB863C28975
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 03:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2F53B5E5F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 02:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E2923C4FA;
	Sun,  2 Nov 2025 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="MKui6PLe"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2822541B
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762052348; cv=none; b=oT+kvKFG1vEr2iOkNhzo8S6Z6mnNaGz95xIrCHVlsGa8F6+fzehxRf1Nxf6aCI2+LxpeEUd/muTNif4EvkPqwnK/WdFjm35ZxoBhXkTFMqRXF4jNBrbC9Zf1HnMtKey/QS5X9EG106GQUIsHXiHapkAZ/UHsg2tGiqXsWCAZZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762052348; c=relaxed/simple;
	bh=obt3aM36cVJabIYjFO5PbdxBdgxz9xRXrzbYELuVAn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvBPtSUnj8jwiJXNxKCJP3CI6bOunPh4M3bjT/aslAZSgT5kqZFhWI8SS5+JzuN63UXSmJVcr3wFP9iRPlA2H8ciBSGkDTHqsn26CgyCb8vBSRWEQ5chGI1eHAWHzq8ituXJeBGQvfunq9e0UMh1vuz9972b09FO1kwoiKHN1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=MKui6PLe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2955623e6faso8013875ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1762052345; x=1762657145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLumh3cNsj4A5S7s0QtpZk3S8e1GvxVj+uYG/2PIV6M=;
        b=MKui6PLeetjOUJ0C+HiSqWhXxSHbWQFmfL1pEYWTrQKyerkIi2tw8OauoJ5yTfLjhX
         4Th/853SQuS3Ms8dH/oknqfGOpmJM43Pdz71hZAkPgfG9N0paqJSkbjJcv+P0PpZGSaF
         whk+sC0Kwu54auyVfb9F7RZw6zwvsNqe5XoI/CLA12AzARSsYCQikxLeFN+s7dXiqtEk
         1KCXBQZKYdvAOhPQW2Vu0NBIr+BYBmVekEPtAgZLIzqJdQBqdXiUY28oo7IWrG995psT
         lGQkLKtR4L8r4LiegJzlAKPUnYzVAxSmzD+iU+HKJ8f86tpnmfieutbfjzhCzPdF7HaZ
         nhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762052345; x=1762657145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLumh3cNsj4A5S7s0QtpZk3S8e1GvxVj+uYG/2PIV6M=;
        b=Zv61oBjt8nmPsQRoaYTGyqQW/mUYfVtPNH1yIyf1Eyr60+qcgQUnxpPEVvN7FDxAeI
         q4WpzGpZ73aaRAei3xCBh2GLW/TQ47wb6z57xjsaszmSbLGYFRdbj2VwrCCJV9pLM8Mg
         Gl/zLTpoPR/VxjX20f+97uJoKfOeimdxz38Qb89vxEWp06VkitK7CRVLfvUPOrw5+giz
         cbHGxZSKamxVIOOEG4v52fzCImRRAnfbu21L8kQk7QC3VmQb2s6XXZPoIzaB0MwH0DaO
         GGfNmmE8bufn4O4NT5Bf2OPx+FTZSFMC+5I3nWvfY4QCkE/7IKjmWqpaPAiHniFselfI
         H1+w==
X-Forwarded-Encrypted: i=1; AJvYcCX1wFS6acNjoFXT0RJpNYhi+uyhnDkhIHfZWtzgnbVbNIw+zbndxPIRGCEBad2iLZxynbMSW+5BNJebZM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQOyBiyyOX4IF3gkymLeI/KH1I1p7FWmHGyjgJUI6sswalL4p1
	BgVgWYb3khgzlRjgktOtulLWNoifvnIzQv2XWnmdGr4tpOk9DgLgpiTssYg+i3kD29P3qGvfmFX
	SAPyUnYeBXnuhAf4zYyT6o6uIz9XuAgg7cMSYsWNnFg==
X-Gm-Gg: ASbGncsWNhZSyVlT4XGILSxo+/FDm7/e/Bjtdo5ihufBWFW28n7XkVU5sZYOdYnGQC3
	9/MkzOMMghmOx/HkwNOn1SveBfOTLOOzFhiiNOVOatOOnBfbA6OFtATwmSCQiCb/fLwwr5R1gsZ
	jA/3uUHwKeTdy75/W7cOhXiCFvIj//7rtrR72Ot/rBiZUJ2ArMIzB4D01PtHMYxQveBUtr8whZO
	9jcW5FXyOWbP+6y4rel7Fno/djziVLxKu4ZFbeCcl6OYVKz+94uAWc6cKIen4F0DYfNaxzEVxhZ
	XDWjO+t7qRRLxRkX262VimkizAx0
X-Google-Smtp-Source: AGHT+IH7KUMAuAewCAP00Q6zBbvodvUMs+s5nG+cFcTWFTo/5afr/24R9eJSZ4skcRLpRH3OqFtHPtQDMzOEOkj5qXc=
X-Received: by 2002:a17:902:d511:b0:295:64f8:d9cd with SMTP id
 d9443c01a7336-29564f8dcf4mr34382905ad.15.1762052345170; Sat, 01 Nov 2025
 19:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031140043.564670400@linuxfoundation.org>
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 2 Nov 2025 11:58:49 +0900
X-Gm-Features: AWmQ_blFwNNxtlVAJhO9Sw2HMPpAD5tSqM9C6mgS06bG4B6-NzncKglA43uu1qk
Message-ID: <CAKL4bV5rU0eSF_MsKV1aW9A+FHquRi327fvakT5Hy6ATzN24Xg@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
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

Hi Greg

On Fri, Oct 31, 2025 at 11:14=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.7 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.17.7-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.7-rc1rv-g7914a8bbc909
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Sun Nov  2 11:13:09 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

