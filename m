Return-Path: <linux-kernel+bounces-749934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D273B1551D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208AA3BF2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D09627F18F;
	Tue, 29 Jul 2025 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RKlaGbEn"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F501946BC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753827133; cv=none; b=YLe2z/mH2vBEXZYcfeCc0bNVtgJ8Z8KuLwyGR4kjQaERaSDiPGMOfnTcSEbIRrsVkXDPuNcsLW9jjdJ6ng2MET5uWFQuXHJwpIcVhliKHkPR6U9KecdG4gAIuRRyM1i+w6hbAsP+2quwtyKdkTyvjUTs3KJV+fHrRa7S/BzeYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753827133; c=relaxed/simple;
	bh=J9ktPbjZAOu/cMphSMDUmsfrqK/0nCFLRAvADNCv01o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBLQToXzwwkGkqhJepo4jHufuIn8hGZZONaCoDpgpaLs4SDKxCkPaCVmomEvR8c0Xgpi2zBMpXh8L+/PXoLelzd8WA4wk5L31Yf/iO74Hc72DriKFkNYsV/4pPayq1SivInBQjXl/6oMtgArWvGrh1DyVjkBvl36DRgeX+yZrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RKlaGbEn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61564c06e0dso2325766a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753827130; x=1754431930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uekxUxr5uM4S/EqgXfAvtm4gx/VKlAWDqfatYpjgNqo=;
        b=RKlaGbEnOcGpr0VDqdMqIJHKBpK/15fXCP/zKZzIMaGNlFNdrqdeUHsjM+lIyYMx2i
         vc6eXL+muSY6u8va2gUKPTARvkWTGOiZKuyyrNobdQpC25x0mh4GbHazP/jv87gn6B83
         wJQRRvEu3LVCR80YHG+OkacZ1cqru4lj7oCYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753827130; x=1754431930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uekxUxr5uM4S/EqgXfAvtm4gx/VKlAWDqfatYpjgNqo=;
        b=ig08k3+wK60h4Hm9ChhIiBvtgOlKs5vQ6o7hQ7/qdmexDvfF1BlSR76TNjlhn2x5fO
         j0JsWwBgEZ4A13SVthesShglmfJ/bMGpgV0Xn/ad7GP1l9EWqiuhRE4bcheD/KOgln6H
         s7nIr97hUaFOW4gRjhopIE/k9gdmMdeGMFwaE5w8PykE6JtIVI4kmAby29LoV8znd2fB
         7F5pPZDqeBgiYmjKyJWUg/Y6ayTXkP0vfSvn9pVoD9Hw+4Btki3hoV0H2bIcHRvy6l4d
         2fyxEGIuPeFJ9rJdmoNuNCHAFrmVYm5XBYEE41sGaLc7U8XqFOT1nhxm7zL04r2mn4su
         gYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcua4TNRSeEYJ4MxzLrYc6ixKycNzx3Rh99Wrr4C/6R+ovmGpOVWAZp4L61YzeVoXpaKeAAnOYMrUDokM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4PE+dsRn6BhyRoHZ0VTE0qDhyYe0mag6PSst7PVXAN+ZMJU3+
	aRF9ZdN0z7CoHcfHx6FTKdv46yJmrw4CARs3TJ304iKEKVnLxQIZc95E0F/Qu7bWOa/bOeTv5u2
	sKLpCNcU=
X-Gm-Gg: ASbGncv3VywCtANrrSFlF8bBj7c/NX273jvSJriTjvYXxbPrBazKMqwKeVYqWQuyUMe
	yEHzZIu8ImmkV86D5J7CGeNkhmyI0pttTHo7Q6f0n13W8ElKHwQ4qC0sJzno8ZEyiIJp7wBkXgL
	e+CbGe61c/SGZYaIi31iiMeyZCZcBAAzZbeaZr+n0ixf3/09f0+9CB8fb9/1gxZVDKe6oLcQ8iU
	g0uKPRwgH2008aa3RKFAyeeHZL7jZvB8zlxOvyJVvMTI5ivxuwwu2Ku86yOejTH4o4ziskgun2a
	EO2I/jEHZgAisKz/qSaD7tByaFGEYHIXGGaitOuEz89h2qtvXglXbaygJ1GKgzozDZZIqxCIeuj
	WmeM95L5Zs/05d1L+j/EDJPmi1cC5mkeD6TR4UpdgHIi6ahFpd/5NbPff9eMgBupvdD6C5ho=
X-Google-Smtp-Source: AGHT+IFAj2e3q3zvYxWS8j3FajNvLX5O+R1YjfgwE2T8xRWQAA+/kuOPQ2a02fvIwiZ+QgSF3opSYw==
X-Received: by 2002:a17:907:3ea3:b0:ae3:7058:7b48 with SMTP id a640c23a62f3a-af8fd792675mr140597666b.25.1753827129898;
        Tue, 29 Jul 2025 15:12:09 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635aa4e7dsm646231966b.108.2025.07.29.15.12.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 15:12:08 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so9765772a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:12:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWo0V41hYftv88+VrZ/X7BjzgzOoqJd3O1WxkPwS9gJbSjC1l+Qc3EhSD9tME0MiG9NGKaVWH9XWA3BZuA=@vger.kernel.org
X-Received: by 2002:a05:6402:26d3:b0:615:4c9f:f7bd with SMTP id
 4fb4d7f45d1cf-61586ee28bemr1051214a12.1.1753827128218; Tue, 29 Jul 2025
 15:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6888d004.a00a0220.26d0e1.0004.GAE@google.com> <87cy9ikcwh.ffs@tglx>
 <874iuuk87e.ffs@tglx> <CAHk-=wirbb_FxAMsb+LFimsMF+nLg4UYsrHvjF1F9tF1xOm2UA@mail.gmail.com>
 <20250729215228.GEaIlCnHzcYmGpiBrQ@fat_crate.local>
In-Reply-To: <20250729215228.GEaIlCnHzcYmGpiBrQ@fat_crate.local>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 29 Jul 2025 15:11:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfrTfVMDjgM2fzPjUJpP7y27OsBssZSSCSR7V-=cd1eA@mail.gmail.com>
X-Gm-Features: Ac12FXzCpUoikjp2wtds78jmhs-CcFHpy_bSBC_-cTxioqBeIl7ax_MCiceLs44
Message-ID: <CAHk-=whfrTfVMDjgM2fzPjUJpP7y27OsBssZSSCSR7V-=cd1eA@mail.gmail.com>
Subject: Re: [syzbot] upstream build error (23)
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	syzbot <syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com>, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, syzkaller-bugs@googlegroups.com, x86@kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 14:52, Borislav Petkov <bp@alien8.de> wrote:
>
> I triggered the same thing today with:
>
> $ gcc-13 --version
> gcc-13 (Debian 13.2.0-25) 13.2.0

Bah. I should have connected the dots and looked at my own compiler
version, because I saw a variation of this same thing yesterday that
caused

  section mismatch in reference: volume_set_software_mute+0x6f
(section: .text.unlikely) -> tpacpi_is_lenovo (section: .init.text)

due to gcc not inlining a single-instruction function.

And yes, KCOV was part of it.

And I have gcc version 15.1.1, so clearly "upgrade gcc" isn't the answer.

> I'm thinking if this has worked before, then it must be something coming in
> during the merge window...

The thing that triggered it is apparently commit 381a38ea53d2
("init.h: Disable sanitizer coverage for __init and __head")

Which is supposed to _lessen_ the sanitizer coverage by adding the
__attribute__((no_sanitize("coverage"))), but it's clearly causing
more problems and making gcc just do crazy things.

                 Linus

