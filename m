Return-Path: <linux-kernel+bounces-766582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E85FB2489A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87CF14E2EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8212F746E;
	Wed, 13 Aug 2025 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="ROCCXBTG"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AA2F3C04
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085229; cv=none; b=qXfjEV7/hUoZTb8UakS4hQPJzSR2rewSxKG4hm/HaUIz9EdKua6M1q8xgb76qqFHSVPC6q+41HkIwTtWxO4sedhWlrOri5xO0hXNH1nYbv30G66vQun4iQSuRcmakdtygqDeZpC/Le0KDX85xJfRVO53yikzZoMLFhgAkxuzngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085229; c=relaxed/simple;
	bh=BykKkHkEYLWLb7CWwOkQJr56BnQRn1jAcQYHyZXJ7SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N621VeKEc95GSMYIdHhMxWglzBaeDNt/gkh4OqPVd0PbaGwQLYdnG2cuYm31dNgMMZza92d76Qy4zPWAWSoU3tDOkWXnmgnVsjQcQlDgfTr08mrCpvUqMboOJpzejP+n+PKZmGBpZSWa1PdiidyJmKmBgbhbbEaQVM7JEmhQwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=ROCCXBTG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2430926b53eso8749305ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 04:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1755085227; x=1755690027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3BIRKaVVBaY39rbF9hkLu5eZuKZvFD7FdH3yM7Pxzo=;
        b=ROCCXBTGpPfnDZKZCGplVVjGL2ASiIxYn972CW8thXAsvVNqriDutNNwGcKxyLxglZ
         eyz8hVFfhHsosuJuVUK2q+K2qE6a+AjWc0auWXq+VZgwDJYJiB2SmSDxnWAnrxr0pSn1
         Y4HWvVkaU14zz30v3/i2EhG0CMi93L/C1Nx/x8AlNoLRPU+t7yJHEn1b9BgazdoDSz/K
         ByL7f2L+Njd2iCbgVE487s+4pwu+h+szoNALtuUqKHNPL+TD5KQpeXRF2Xvv32jArQ6K
         +2v+enVqao0LRImMQBkByg9AGDomuw3qNjMDbmKYK1r4h86Rs5HeMosbrGgaJjfVmgd7
         DgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755085227; x=1755690027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3BIRKaVVBaY39rbF9hkLu5eZuKZvFD7FdH3yM7Pxzo=;
        b=d/p8HRAlzL83aKEViMOPNKLVP4FZ8LvI2P5lorHeCajlJgaSU6OlrKH9HKf+Yi2D6M
         5h06Q+qX317w9JeP42u5m6kNeVdvLFWa1nB9lugRuU0FqCC1R4+0wP2ZMh7GVlULHGmk
         JdTyJmSWSCY6upoBsAh7jLNcBYgWwprhdCftkDZFcmkTNGJBUDYKE50clxCQJZDa/jmk
         2grkbU0jdXcRVRK6UcnQLRkMxlJLa7rOfv0e0MThUiVQV96GzFfYT5Fa/msyFXhGxskJ
         J9AtK8QjbnNKgot+Yi898rlAIBgvV5dHpaLVSiG6WogpkwdaXwjl3nbLBj5xoueEBqcZ
         XelA==
X-Forwarded-Encrypted: i=1; AJvYcCWqt3hsV5FML1Ag1k9teiTi8MGJjMna1P0kziryDyHjlpjsJ4yRA/qLsIZjG2XMs96JvC1PzlOloAJElq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywEMMiHRlBV0Xx14L6oOoFIecEQPtOG4C+WMKt4Yvcvd+hdXjD
	cQaP7Z30rLfFAbQyaWu9HDZPqgFYT2Pa3lpJb4YDTes/2Jdki+KM9dIc1i8N/hVe0zuiXkfpXR/
	HNed4kLWFrCprsDHj/ErJ5DdBD/Zwuxyf5tDfUlacig==
X-Gm-Gg: ASbGncsWpqHZYSQ0fk46pO+FaSy++yKNwofr5Mx/Xgj1WvrEkemEOWJuVE2sriifFE+
	iC/L8nAkTHhw2bQ39ztfezSskMapxxHE7fnGlFvwBXr3RUSSZIoNBonmTmF//Z5Iwyt9N0jW50h
	JRTv/sMsquvC6iqT/3AFhZLhTn5Qpnl7HJxGzdJ+vLSuslM1bftzwLIqhNHZsEaCBzwDEVhUixk
	edNkaRvYFWj+rI0MA==
X-Google-Smtp-Source: AGHT+IG+nTtyJUv253oPnJUoEUCvokuRcXD3lVo6sfsPY5VdK1rqYeYLJlaXzeSlTxh4lbSWQWL4kc2qrpNDy+NJ/s0=
X-Received: by 2002:a17:902:d4cb:b0:242:a1ee:6c3f with SMTP id
 d9443c01a7336-2430d10dd90mr37501495ad.4.1755085226707; Wed, 13 Aug 2025
 04:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812173419.303046420@linuxfoundation.org>
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 13 Aug 2025 20:40:09 +0900
X-Gm-Features: Ac12FXxMDc5GahUfXc8UnHZ4PbyMkPDHmDcjMghecDq50fr3-LAFQeLVWMO6SJo
Message-ID: <CAKL4bV5HBA=WvUDwxxXAbAUvXz1ctf509GWJPHuDJWHUHk8vMw@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
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

Hi Greg

On Wed, Aug 13, 2025 at 3:32=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.1 release.
> There are 627 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:32:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.16.1-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.1-rc1rv-gcd8771110407
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250729, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Wed Aug 13 12:10:19 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

