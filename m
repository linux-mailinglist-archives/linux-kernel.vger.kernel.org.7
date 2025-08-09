Return-Path: <linux-kernel+bounces-761180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B777CB1F55D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752503B8E85
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 16:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9546D2BDC2F;
	Sat,  9 Aug 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="jgLesPPp"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBBB1BC5C
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754755805; cv=none; b=mh3S5QFYNzLLabbasnnLkithkjisEgbJjrrYNP9P/dd8kew52nWeJ8YVV2xsum3+XPlncXSuOVj/u9INvTLsAd3qcEpjE6qQaqcqD0BEIj2c8J0xlePzlXiTJEy1KuDfppHnzgN3DxQ0g5GLXzyA/FDO+mV6NrgcUkul5zXZIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754755805; c=relaxed/simple;
	bh=EU3uiBgYcc4HLECZb4pgs+ZSeBNWlX64SnD/K4xqSIo=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=PvBm6lRG7Tgor9MW4VlTxsDolFB2dwBcwx+I3hcv/DjmaJ5kCN5vgrgbSg89Js2qQz5z59xQM7RAc6Clv2JlOMTR81W+++Ey2WdUb83JbtZt7nxegICed4BHCTO/r9Mk8Je7PKk8Kbgyb+hoEFxAqlcDFkyW+mn4jW2/RKEWqLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=jgLesPPp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76b6422756fso4509067b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1754755803; x=1755360603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vm111q7HEdqrlcr65H+xqM79ZO22buScjk8C2vfUtAU=;
        b=jgLesPPpJBHLimsHjWlccdY4S9rNhvT8JH2VTODuJ8gihLdAVxIdqdY9Z7WL0VKUfe
         4UEcfBI7oDUJU449z0MhsDbQnFh+HmfYDu9fq5Nx02j40ZXPujpLxWEw7WIMGuNmiu1y
         YGJFnaHTVwtxc6Cjdg+g0U4T16zkbe27EbdgTu7dT3gnc37UfeHWK68+p/yjAub9LQlQ
         2MZQUfdulCQ4oOmgJvQhWwq53oi3nVZrYOmOYCEDPyr7xsM0clSfTIsyhOX6mSq4XQOq
         IyhO0N8C7p2qnyfZI/taHRHOZfDMH5l5ptXqY99GbpYckvIttE8+f2Mu8rt+iDozxvDV
         lXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754755803; x=1755360603;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm111q7HEdqrlcr65H+xqM79ZO22buScjk8C2vfUtAU=;
        b=rhGefxgcQ8p4qM+yws6SucqeTNY3y5ilfRMn10DMFkUHUOvplF2Ez/LN3JRbE078nZ
         ALT1YsBZ2ojVl6P6hAn4ujYnKTHVyeQ2lyD/MOFvvXSrnKiAVNR9MPdBa3xClGTn5hKE
         mmNmByg3sunNoIM84uN1N6UWNf/CULen5p97AzeAnH1cfuv5uQ4/JSPlStjcVTG88OiK
         VZuunwbjBOrA7wbx+hO03a+Sm/csh7zZUQEZaK6sHdO5OgX5jFQZIt20iAl5dKiDZqID
         k9mb2jxn+m8MrmVv4HBcqBtE3UGGlLeCrnt53E1wv+jTRmFxAbdqvGanSVgTap7JBK36
         gKTg==
X-Forwarded-Encrypted: i=1; AJvYcCWqTLTuBwgny7QDi+rdtexVdvEc/Pasi3F1V5PZPHYl+wtBgL4YySXQ5U91vGHC+SDCXEkjXXu03AhyT4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YydOdet5aAQE8yjb/rb0eWF1Jw1R1oYAU/3gJcA2dAfDxEGpYNO
	d2dPgLc/nQ8sdDbR/fJfRYiM7ol5GHr1ZyHxgZ3S+e/+YjHBFrCLUPxQIsjauWr85j4buh+1uZ7
	2cNlPGAg=
X-Gm-Gg: ASbGncs1nBTt2H2pjAhny99iEWW/N0PfzKWYCVoRCn9Z//ZBBXYuEyfUvLdRA68OAAm
	lKzcgqMBQWzCRLDMFZpOXfZJiCntkPt/WBlqYWLga1DTwuXGG+5fAWEyKGLjJBJgezr9Dj7271/
	tmN8NYuxmKNBFxDv+p6PVXW2Azo3J9QbfhtlZep7v9TRSQr4hXliiNEl5glaYWKaODpCcRbi40v
	vHsJxMH39R0x1YxSV7ba/r/1mzBZ+UaJ/lFtOeeaIdOAcr8ZjJT73eXe4H4h6T5m62B8uXBgQp+
	40tJOp0TXdMpDvNe11I8DN1Cp517IASGL6s1reaX3DHllAe9x6n5Lc++XSkd3R7edtwzW8v+luJ
	a1ARX56Iv79OPOYj4axbz2ksdYZ47Zw3RQnQ=
X-Google-Smtp-Source: AGHT+IHIz6p0J1AiyXsleLuls77tX/jAJ92HSf9ZGsUP8iZXambPb+8il8tsfWkoH0Y+WW/deM2Rhw==
X-Received: by 2002:a05:6a21:329f:b0:224:c067:66f8 with SMTP id adf61e73a8af0-240551d6a9cmr10697755637.37.1754755803063;
        Sat, 09 Aug 2025 09:10:03 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31f63da6249sm27246362a91.3.2025.08.09.09.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 09:10:02 -0700 (PDT)
Date: Sat, 09 Aug 2025 09:10:02 -0700 (PDT)
X-Google-Original-Date: Sat, 09 Aug 2025 09:09:59 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 6.17 Merge Window, Part 1
In-Reply-To: <CAHk-=wjLCqUUWd8DzG+xsOn-yVL0Q=O35U9D6j6=2DUWX52ghQ@mail.gmail.com>
CC: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-655602B8-F102-4B0F-AF4A-4AB94A9F231F@Palmers-Mini.rwc.dabbelt.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 08 Aug 2025 21:58:32 PDT (-0700), Linus Torvalds wrote:
> On Fri, 8 Aug 2025 at 21:19, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> RISC-V Patches for the 6.17 Merge Window, Part 1
>
> No. This is garbage and it came in too late. I asked for early pull
> requests because I'm traveling, and if you can't follow that rule, at
> least make the pull requests *good*.
>
> This adds various garbage that isn't RISC-V specific to generic header files.
>
> And by "garbage" I really mean it. This is stuff that nobody should
> ever send me, never mind late in a merge window.
>
> Like this crazy and pointless make_u32_from_two_u16() "helper".
>
> That thing makes the world actively a worse place to live. It's
> useless garbage that makes any user incomprehensible, and actively
> *WORSE* than not using that stupid "helper".
>
> If you write the code out as "(a << 16) + b", you know what it does
> and which is the high word. Maybe you need to add a cast to make sure
> that 'b' doesn't have high bits that pollutes the end result, so maybe
> it's not going to be exactly _pretty_, but it's not going to be wrong
> and incomprehensible either.
>
> In contrast, if you write make_u32_from_two_u16(a,b) you have not a
> f%^5ing clue what the word order is. IOW, you just made things
> *WORSE*, and you added that "helper" to a generic non-RISC-V file
> where people are apparently supposed to use it to make *other* code
> worse too.
>
> So no. Things like this need to get bent. It does not go into generic
> header files, and it damn well does not happen late in the merge
> window.
>
> You're on notice: no more late pull requests, and no more garbage
> outside the RISC-V tree.
>
> Now, I would *hope* there's no garbage inside the RISC-V parts, but
> that's your choice. But things in generic headers do not get polluted
> by crazy stuff. And sending a big pull request the day before the
> merge window closes in the hope that I'm too busy to care is not a
> winning strategy.
>
> So you get to try again in 6.18. EARLY in the that merge window. And
> without the garbage.

OK, sorry.  I've been dropping the ball lately and it kind of piled up 
as taking a bunch of stuff late, but that just leads to me making 
mistakes.  So I'll stop being late, and hopefully that helps with the 
quality issues.

>                 Linus

