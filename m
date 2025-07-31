Return-Path: <linux-kernel+bounces-751515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D04F8B16A80
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611755654F6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B2123771C;
	Thu, 31 Jul 2025 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="rPD6TO4T"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5561DA60D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753929599; cv=none; b=LRY9SN4AsKZkmdNcBg6diNnGEUjAn6K4IVXz+tDj4a6AkKXzA5jYBfijAlqoyEjHEokytmyObEZQEHn8UHZBq773HedPPirVrzGgBCF9faoVHcQUQ4WTkcEZsJrI37Fr65CEsLvoc+LCFUuB0CzxEpW4q/yafwaCI0lye+ekCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753929599; c=relaxed/simple;
	bh=/ywKHejRlAU8NaBUfYedjpYE/KbEhNXMYBNdpYwavAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dp+7N2ABGvE37ECacpHeuNqWyjaSY94bwzdSyeTExHiLuAi/RJNw69OE7EzCW/p5pDS5DDj25I3vWy5ORhxvd4lXrgrHgkOPHtuju4b0qZfKtGWe2ktaFQDWi4OogKDwEwaoHoJ7CgtExn38CxLhhXa4rNBlIY1l392P6skPfvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=rPD6TO4T; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso419999a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1753929597; x=1754534397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gik8kQn3CflT6JngBBYv+kUUKNngOz1ckMzDNY3dGCs=;
        b=rPD6TO4THGAE8vjsmrJyHFAzhgSwj7Y4CkPjq9NFL1Ic7iENHvgTq2cqRG4K+lzNJs
         NnZNP+3lGwjnp+h8zWGsL4L1o5H9JXBx6QE3trupV4cx14ZimztXpQ7vyjzY9SXDdMr1
         1DzcrPvsKiZ/93PJtMfTzS1Z1hTnXLPMS7J/AVRAVCjbnWETobNNXcm9x8TNHUnYL7/J
         smmTYWApBIQn0J4HVGBf7/10a5TerlDJ/tP/giHy4S5vfFYhBnAcs7tfn/GXo2ama5mG
         AfSNV0OQ0Z7nCytQjQNQ+N4NJiBQGQLAPxbJsqzl0yqZseDNOKQdfnF20i/MjeCTnI94
         prbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753929597; x=1754534397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gik8kQn3CflT6JngBBYv+kUUKNngOz1ckMzDNY3dGCs=;
        b=BkWETx1w3eZxGkdqVhrLnq2hz+g50gwfrX+HH9JIGLLxa+pByIyG0bV9vDeudWfEf0
         7EG+gcDIxiyN+SNVhfzhR1g6yFP8iXFqvlfaBGOBkgiu0pKA+PD08SFwXjhGLWG2/7/h
         qabt5FK9vjtpdDrX9ySw4XuA1Mez5XwXG6hqtmtTR8BTXI16lKdVKVGX4qz8h3W/QMZU
         73GgyprZsm9Tcuo6u/ck1JhW9sZkC1koC2efzsm36u+FldOL6T3DeVYrAT4wYeWsvsYy
         tcOdMdWfx9gMQnS1xRscfY8outAhByMix/h6GpEFQUyQxn/lMz0aLCDixB+SR1iPNani
         gydw==
X-Forwarded-Encrypted: i=1; AJvYcCUYFlMKk/DLmsONthcQ+Fcz9eWwzlEtlU3OaO9rvOoggvdv6P41QoAIq5+4ChQFQen9vhD747/F9IBKXx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylD+8nezOLNGs6lkn/wGvhRdm1eCUo8rtHKCPuSdJZVc9Eg9gW
	2yG0sGYc5OOMmPCXfmfKJNoFTbwLyHmXKPBEZ5P57SOtlETCTahIjWnNjyfVybjDDO4PEhWsoh5
	NzWsN65V1TdC2ozKbT7bV0FF24AQNk32YqTB5TznSrA==
X-Gm-Gg: ASbGnctpG7WSD6SgmGZqGfNEL3CG8JRezlMtllLGlAmPIIHb8nbcq7C5cZV4kQxq81T
	MG5I/wc9C12GzEv8J+GQo1jzED3E8FoPDkdGyqSqCjmDrAkXB+2Mr5NQT0TG0o85de8uCKPLuYE
	r/S2P5+rdJx3fj/lIS9LTC5x3Ej0ydxgNnwzbixOs5A6YYBT6VfA1cvEkyb7+srw8oj16fJ1GYM
	hzpWm4=
X-Google-Smtp-Source: AGHT+IG/yzJp0Zgl3QCj8JLwCRCOvmPQJgUimI3WOMMUebwa9O26lDVm5Bh2U+dtqirpR2I3YBUaWNWHtOPoD3Edbu8=
X-Received: by 2002:a17:90b:55c8:b0:311:f05b:869b with SMTP id
 98e67ed59e1d1-31f5de58622mr7607661a91.30.1753929597272; Wed, 30 Jul 2025
 19:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730093230.629234025@linuxfoundation.org>
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 31 Jul 2025 11:39:40 +0900
X-Gm-Features: Ac12FXxxs6pohzDYfR3q2pxRI0B76mYhfNwsHqFTuOdiVngA3WZUVCPz0nIqHHM
Message-ID: <CAKL4bV63xNamSc_5tDuO3uXh7VRnG35F=q5Mo++nivZYWmVH9Q@mail.gmail.com>
Subject: Re: [PATCH 6.15 00/92] 6.15.9-rc1 review
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

On Wed, Jul 30, 2025 at 6:53=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.9 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.15.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.9-rc1rv-gd9420fe2ce8c
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.45) #1 SMP PREEMPT_DYNAMIC Thu Jul 31 10:55:42 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

