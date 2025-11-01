Return-Path: <linux-kernel+bounces-881190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF008C27AD1
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2405B3B9DA0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F832C0F7E;
	Sat,  1 Nov 2025 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqewDYZh"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1215DBC1
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761989336; cv=none; b=D3yQvSyNKNb+aYpCyv7D8RrZH7fQx6XDjATcMES/i6mrzpD08rb8I1u//S6UuTRallhvGCR0W95fsrDBeNbx3YRChMmUop6pgLFna1tQEFVXzhIHFKNi7Bn7wau9PlrUQSjZ+avmxLc91ygJYquxgVr2BHPVuQpXSAJniTaPkHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761989336; c=relaxed/simple;
	bh=XVW/5/gggZTWUpkWK6wUOBNnYp1qwGX654Z6WrBEvYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0JIgIIcqWyaidGOnIQD3svWWnEarzupQuB4J5kob4IdhF+WO6QtgmHCmTWoyhTBTayRVjTmpcyWASGsvfDp5FudS8jFHs0nkg8beyK5AY7GIwaerlvkb55yF849/PYeRaAcyBHmjCuk2HtAIxRKgiqh0mOl/F+fzJVV/qebgu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqewDYZh; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-43321629a25so4586325ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761989334; x=1762594134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NmGetmPUb9VA8HYMaI3fVUAPUtPbcKl+pkTJw1ZTWWI=;
        b=TqewDYZhlZLDQDEQATchlMjWEsFHZ11JRl1xnDfpTz9Qs82uOsKNaw0aPmecDGwXQf
         vmUCApxeBOqFgcKPdyv18D+NEEKvH82Pc5xDmaB1wcFh7HM/+KD6CbUZqIxphzizmk3U
         goCbo5MXp+Uz2EW3upPq4ywnBR7v+R6l59DBcQBF18jY31jH5mzLxrF/qkuewiOMLbp2
         JdVDlc4Zxg6+y4/JTxvsgwb81C23S+nbuTo61IOsQhtQi9iNr1qXUU/GwOTxE0pHmdN4
         En8ylh4JTASLG1lszucpcsPq40BmStBOd93ubuMQgvqc6hZNMWO8MKtyElML9RxyOQgU
         w58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761989334; x=1762594134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmGetmPUb9VA8HYMaI3fVUAPUtPbcKl+pkTJw1ZTWWI=;
        b=mWLv1+pXaDWwhYLYhZ5Pr6cejbGsf6VR17HxxD5NyJsoSH3r1QyFptv1s2yUCFM5Sw
         fKkHZ29NcQD48sPqRcqJCbsLCJrhKCTUS8xAUwLNsFoAFDNyNHwKQZ/2/5O/85os76LD
         A/sMST7bbKSc5CbqomdE+du003pwzmaAJCT9/6p0xbPxr0lP+b2QkEEcdX1bhQ8Ldpfd
         uMMz5TnKLF5lCsWoj4Dujtan8k6AXAPMTrJ7wDM8aSp0RhpCFenFRoGADaasxPi1JWd2
         AaUu8Vnl4b+o+ZqDC2w6O4P+y1QdzN2IIdKYYMbRvbPX0CqLunqppMzjGrI36S3+2ELX
         5YDg==
X-Gm-Message-State: AOJu0YzNtrw4lmwmUHZ7T9wzaD3MLepktKClatZWIv6cfzbfyKqYjZib
	nhJpJXTPr2Vfv2zG/HJf+YAMuvtqbkSKH5eLAQqZNCm7LN4zT/H5vGwjNy5AK+A3f1FrHWNNy7h
	imkmmlbUTWnyTdzUWOaNW5vpnnUdsgrhS8g==
X-Gm-Gg: ASbGncvXOQI4YEjr+fn7oejCoT1SfyprULc/AIssRPELELNpAhenNLJwbgLsxNvytJN
	sfWrreHPl9LMYaZ5Hpt931yQrkjAxYxgkB8SB/NEMqzMuQUYNyUPB9EecfqKeqZMWVd0xtcETMU
	o9ikzg+KBthLM9M42+Dq3hwGiZqXPbW2kqEAIhTgfI3u3fT63+UMWJ3ioDVsTbnI/zz1kTR0SfI
	SUGQvyhqEHE0iuO7iODCiNEw2MUs0UUCayEsF7/UkxHwW8pNaiVjAO6GqELn5LwIKV0MxPdQSCo
	o9iEoZJQHN7UWdtjvTjj7WILQkY8
X-Google-Smtp-Source: AGHT+IGzWoWs7bzpcoZ73HRHlX2Do8BiND8Y7jERfA95QnyRrw9tcAQNLJ2up8NwJSI9AcaaT1m5NeHxplvD/8RvJ3U=
X-Received: by 2002:a05:6e02:2485:b0:42e:7a5d:d7d6 with SMTP id
 e9e14a558f8ab-4330d122f9amr94908495ab.2.1761989333843; Sat, 01 Nov 2025
 02:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB95QARfqSUNJCCgyPcTPu0-hk10e-sOVVMrnpKd6OdV_PHrGA@mail.gmail.com>
 <20251026211334.GA1659905@ax162> <CAB95QASG1pZJT7HyqxM90_FExhSVjoHmPqYHeQWXnrAzCNErmA@mail.gmail.com>
 <CAB95QARmr9b-jVdgDLpA4Qq=3WN7CYS46YEH4Ok4gpSdZHpq5A@mail.gmail.com>
 <20251028174541.GA1548965@ax162> <CAB95QARtzDWensRzui3d-7+jhymcFBOBi78ev9LMy=ZFJMDCTA@mail.gmail.com>
 <20251031220732.GA2254630@ax162>
In-Reply-To: <20251031220732.GA2254630@ax162>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Sat, 1 Nov 2025 10:28:43 +0100
X-Gm-Features: AWmQ_bk3M0-Q4CZRFjEjAPuRZ8eL0rrEH2dcJIRWhP3CJcJlRJGn_U-BOuCK-xM
Message-ID: <CAB95QAS6q7T3C2hT1XPFm9-Smao0T=oidJWvRA20NJeSnSEfLg@mail.gmail.com>
Subject: Re: Can't boot kernel 6.17.4+ via rEFInd
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Nathan,

On Fri, 31 Oct 2025 at 23:07, Nathan Chancellor <nathan@kernel.org> wrote:
> Unfortunately, nothing appears to be out of the ordinary there... Only
> .modinfo gets removed from the vmlinux.unstripped to vmlinux stage.

I've made one more experiment: kernel 6.17.5, built on a machine which
shows no problem, using the .config file  from the machine where it
does not boot, produces binaries that boot at the machine with the
problem. These two machines are nearly identical in terms of installed
software packages and their versions.

Now, can I conclude that it is the toolchain which is faulty on two
machines? And in which way?

Cheers,
Eugene

