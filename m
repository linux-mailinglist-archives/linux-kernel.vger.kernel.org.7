Return-Path: <linux-kernel+bounces-732553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6356EB0688A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3464E0A43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F02C08DD;
	Tue, 15 Jul 2025 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="cBO8R3Uw"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8316C2C08CE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614849; cv=none; b=JJDkev+KoKNimpGb11UDPkhd48Mpczn02XxuebkvS2iaSRmd3HMiteDLp+Ix31RDjYsM6goXyn9Z+2lwt1LukUjeeYnHYfxct/9pgHM90VVon/g8l7x8wjf1zTpWeD3ONCI5y0v32fEzM4v/VVphcVSdwSuK2FvHLkf8bwHKEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614849; c=relaxed/simple;
	bh=D9HEnKpqxTaHq5dlDfw7mwWkvcUfEgMavo2bCfMr8us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRoatp6Ff0eFPyG43TRp4dFKffN9Ib0afwUeMC8jzOM1Vrxr1YvtAg2WRxMIR2KeWT9PfS9DsRDCdz0ABFJlaStScE2dXrcFYSqRgOOs7H1XvdIpAiyoMu9s4zkBnN1B0DSUfYgvWv0bHDLEeTU2oOsyU5XoqyN5Clcff2qWc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=cBO8R3Uw; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-315b0050bb5so4172800a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1752614847; x=1753219647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOELzqJhc/ryZF/a1QLEL+CHjG5U4uGeHFM65aS5DO4=;
        b=cBO8R3Uw5COKIqDiWuGdutCVaP+AazI9h5iMBKlMYQnEokN4IFYhVNZ+nVHWoqN6q0
         x+JK8FRF+YtJNV41RGo+GOl9xHQmb7vRScJTfEhM/sA9gkAihDqBQVR9FINz0cPiIDu5
         bT0o9+u5vJo6jD4If3STi61q7HkfYTcLN3aVHZ/GVDifkD0b7hcI7FYOpAPKpVs5Rb1K
         SuQqK6bkrYce7NsF4ltc5BvbPy8LuAh8yWZLNswJbbcWX9U87fhAACZSUWvQgyqrBmQh
         viUovU/9l9TngI2XdUGakudUJNSHeNO9yskbM+0QkdRYWzgxC0CfOEllecmGIgMqUE+u
         hGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752614847; x=1753219647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOELzqJhc/ryZF/a1QLEL+CHjG5U4uGeHFM65aS5DO4=;
        b=J6ArRMe93ui5E4IOw6OggbzYw5WQeM2qAi26Eat49zIwphts40eaPape7L1nYKLm0w
         Hzc2aYwUPCsVXCL1Qbg99KNjUsC0YJ+sfqYTb+E0S59jHkAYyxQu2q9xk05FENwmryxQ
         GvbJZYscjJbobxPlMoazupWoAlSYj8ITf+etPQjXKMjzkqDbbfEiOpb+KZblIaFBNljT
         n/DSndniYZsuHJHOQTdW+RO3C8j4Wm2cq/ZOmBBFXOMYvX9kjOftBwGiYqHeTi4Lb6PQ
         52jv0r3TXBOiREGasL8hBYpldZZJlXi3WutpMfObZDiFgg+7xBSqzzpsNbn14oibI5O7
         W6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcpTXCCZowaIQCtucF3awC1hBsuwg/OlNQfW8scn6OEaBnjdVp8Jml58r6HSIt151Kxh+v6JJR84On6e0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hJz0BxJOodMj1QdLYBmPXB7TnXII386AnxTTzHz8cJSEZ4U6
	z/LVr1fmFZjsJy88I9fE1W/f7n7yu2JhD3sxBoNlF9AZebz29t5Xtt0gOnX/GEacLwR/uXB6WLr
	dMkmB8KyRG6SN8jLWeLP1jv9JduVWO53Rnp+iIMiJ+Q==
X-Gm-Gg: ASbGncs1Lu1XtXOrR6pY1UkQjFj43A15YlvR+jHyR4SVf1j/ng604hK5nl9TzgLD/eN
	yethtV/RqPUftxZ8GV8jN93ZoNdNWHcr+0+jLTtErgR5BNixMwVVSScZ1ETC6ttJwcWdYTG0pYU
	0og1e6be91sAR2HPIrFuEVIso0ImcHkiMv1DofVlBUIiTxEcm8IlxM5dE/DorpAa/0ZwmvTQxAn
	rBYtxhEFEweAVaxvg==
X-Google-Smtp-Source: AGHT+IHIMG5AOIEO7NWtr7b7qQXOwUwyu++a7MBGcUjFW29Fo09J23bRD+O0k/Yj4fz9s6Q9Ys+GEoOzZBuXDt2FQCs=
X-Received: by 2002:a17:90b:4fcc:b0:312:e1ec:de44 with SMTP id
 98e67ed59e1d1-31c9e77050fmr1014801a91.27.1752614846758; Tue, 15 Jul 2025
 14:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715130814.854109770@linuxfoundation.org>
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 16 Jul 2025 06:27:08 +0900
X-Gm-Features: Ac12FXw_zO_5hI65OrUKo80Jj8hMmAumQxAUZ4aSIH3foYyd6ktRTVpXkyDcl4k
Message-ID: <CAKL4bV5npxPDCt6dsmJLSjVxTTnDn7GyJ05AgPF3Qh2M3NDY_A@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Jul 15, 2025 at 10:50=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.7 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.15.7-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.7-rc1rv-ge6001d5f7944
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Wed Jul 16 05:56:57 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

