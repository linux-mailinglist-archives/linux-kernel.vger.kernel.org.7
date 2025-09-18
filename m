Return-Path: <linux-kernel+bounces-821965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A1BB82B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51ED1C21D03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954D9244675;
	Thu, 18 Sep 2025 03:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="V9Oj/Lag"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F88224166D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164880; cv=none; b=Uw/zcQjgz4AET4W/2cFdku25J2Mw8UCbqdPBCLmr41Wxi8c4JTP4j0q/CnLPJy9xey0TxranWddgrBqbeaO/Kh1ZnUOqN/mE/GhXLRuHqsvtO7axJOMOtkSQfceCLHbUlB77xuow54wBltWnZ/ryowqpN6NVVvm04pLftK32aX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164880; c=relaxed/simple;
	bh=ucCRcxsuGDClfG5heo1r5qIU5kMebbEElSVKOAPitJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhx/qqusgRBQ7YgUO1zmcKEhfA8Qdr0i90NCAPD94kn3eQIBdVVQuXTr1K124e6X4Lr+nA5WyFP6FsmFXr/C4QQdxN1G+ZXJzR37D/RNDn12Cgdl3Q7aIKgpRKsDytU3jDhENJ6BjW/Tfymxi8Mnkol+0GDiCamzXzBVzg5rdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=V9Oj/Lag; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2445824dc27so4588595ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1758164878; x=1758769678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOr262x4SNCixfw6D+h2DN6gV7zkR61R9C2FM+lF078=;
        b=V9Oj/LagAayBJWbzzAdIr+QLfFUypJLqCn0Q0otuGWv9ZLEa4CApHB8Oht7mBo2hV8
         tfsbDddh0ow3pzDtJbOyxCVCrwcxEDRALxkXUlg5cxwXtSxsy9DAD/OJQP1Fc5P7tcjt
         E65zpgnXmZ76x9ZeIykiXazJTL962d7zRByky+YCWQc7PG3WqRiqJv60gXswtiiLgwv3
         gJhzbiqQIy8dkLCgz+V9TeC3aTLPmmJVgyPJ7V8Rp0GiDeaWU7mu6CKhZpyuRHjVv+bc
         aXHlMWbVvePGIjFjlz90AICYWFTaCLm39Ah40bNvaGAtCGrx2XOhAFiqMG5rBNMdU6nb
         H1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758164878; x=1758769678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOr262x4SNCixfw6D+h2DN6gV7zkR61R9C2FM+lF078=;
        b=oID/3AYVrKGkVeRu+zzUrSkF1hkVMuzcqCj6HxabC6S19hqap7LWeCbajdfouvSng5
         wzaPNCKG5qSvBt9hGOCT/Da6jD0HP9h33p01JZDB0xcbQfbKon5N+IqkSnf5ryPANQ/7
         Q1qvIprORoLmdRh5JjyMXGlbWsMug9+JHySWP6KvPV8HPo/kCUoIIhXzYQ0yhLRRMmfV
         t8IdXM4XNzfCDIucLXSyr7BUA6fH7uEMS2bfig2SL3sVs4B2MNKQ+vmhw6pzcWpa6nhW
         j8uKQUp+otxsDWbPNM5HnU496R/UbAd4Ej1SH8GKihPuQ49EkepoKE46YWBsU6eNIFAj
         ciAw==
X-Forwarded-Encrypted: i=1; AJvYcCWUMYazVnb5Fl0Cd8nW4oCprMXN8OUbBNdiQ3a+PzQd8Sg4FamBOif7hvtKadceuHD4vwsaAHGBOT9KwDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8knlpSFNGdbNjz7kUZTHg7v1SutdnAGeo9xOnxM0eTjhooUl
	2dYGoyGwirSm4qI/6vDCCNfkBdBi1RKP3AVMzRWitig5WE3gZ/4MOI4MKVTJDp6wtJsrPGiUPho
	81lWpQEG7DwvfZM0vu8RFpcrxPDe7VQnBNtpsLMM0uQ==
X-Gm-Gg: ASbGnctVfsBrLA/9/3LalcUDwhqtOsNUgn4+wpnCjJwEYzlcCTpBNchhJg/DeqtO10k
	xdVZ0wGLx/6T4OYwQcOEqCEN1acGAQ+cBeSrUQx4NsyaLFssIV3GFA5+B6a/Vc08tqBr3dBNxVu
	tEtyCnyC3SbBLsaG4ZvdXegOtYOyQzpkQdN4WnBxC6/JhlX/UNI6oBD+il1FO1vNKEgu/7/sYxF
	ZF2RLmAaQleLMev/Myyz5eAOyo=
X-Google-Smtp-Source: AGHT+IESFnLmLGxL7zVRW9/AAJMJ3eUyMJy5//Ofo8Y4ShmsKybTu8OCYOtVcM347qhv52LF3IQYEflH+bF5I5G6ezM=
X-Received: by 2002:a17:902:d4cb:b0:24d:64bc:1495 with SMTP id
 d9443c01a7336-26813bf3d79mr48842325ad.41.1758164878562; Wed, 17 Sep 2025
 20:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917123351.839989757@linuxfoundation.org>
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 18 Sep 2025 12:07:42 +0900
X-Gm-Features: AS18NWAHWPq2LKZaxfOvpUL1LbKclh98pn2Km87I8UZDUptfVR4FgiZQQobBzMs
Message-ID: <CAKL4bV5MDKDWPKJvQke1Lah=HzeX3=hO0rfQYb3S_nXMcEYOvg@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
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

On Wed, Sep 17, 2025 at 9:36=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.8 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.16.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.8-rc1rv-gfb25a6be32b3
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Thu Sep 18 11:43:14 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

