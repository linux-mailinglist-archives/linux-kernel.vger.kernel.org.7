Return-Path: <linux-kernel+bounces-891419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4874FC429F2
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ABAFA346A79
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB174265CCD;
	Sat,  8 Nov 2025 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOuRN77A"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A1288C22
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762592794; cv=none; b=iQRHlyBSd4SpBnD2loj+0cxkUQgmJ1fsr64b91YGOsQxjXPw6CdcNGyLlkJm8gBlT8f20W+6VKcynE1dZTur/yzJAAmVB7EkSd55Lu7JdZfwTz3AgwKa3yQk4f5uKpr+zSxRaC0Rw1HgQX3KVDoGl97qDCNXl6ovomuk5HW0mWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762592794; c=relaxed/simple;
	bh=5e8JsJPkRnjnvxJLk5/07pwvaKu5ka9GvEOU3uc20xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5MlJCgMrkOHUnP0AqYBvUEX5Cx/M3kvica2dyydceXRU9pYuOxHGKZezx2vhVFn+dvRpT4H4YqhXtBp8Dg9pbb5rNyDEvTi8VV3CotooBzGmnscWbM00NUhdg5uVZ0VtJZOY8rEUiuJRGxU5QjjCSgQZvNNNc0IZV8ChHN/9zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOuRN77A; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-4336f492d75so1212775ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 01:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762592791; x=1763197591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5e8JsJPkRnjnvxJLk5/07pwvaKu5ka9GvEOU3uc20xI=;
        b=MOuRN77ALP3vkpIGiEI8BYOkA8e116P3xzbmphGYAclPMscZkAAs8bml2zETj+yQWA
         +qZs6CEStvuRQWZWFdin13ve4jUoGN4jqILmtqyZN9sH6+BcdlFAefwoQCCDoIRM20II
         EXVAYEH6lg3RWAxA0Ip4F6O2RtgJFz2OzZqnH4as7QrM7aTFYI5y29nFzECWj6W1Pzkf
         u41qXXVZe318kqhMOKZGs4DVZOUEbdmcP2wHUEwFQ643ura5F26L5jwmeEC5Mz7ZP9Ps
         BO6fMpVTCDqIEOqpDDr+ROB3TQHE7dj2A0Gd1igsjsqEgWr+U3IYJuxc4gqzd+iAxJgd
         VqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762592791; x=1763197591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e8JsJPkRnjnvxJLk5/07pwvaKu5ka9GvEOU3uc20xI=;
        b=rcklAchYkwNgcH96e6NudfUJdsHAOQO2tlt07XWkaOIhp2DK+2QX69MjH0Z/dlESNb
         ZS/XsGIawPBT5ojzO6VDqvkPqFqaoFyoU5v0QeO54ppHG7zYoQPSgLBLyk1MC+haiRSm
         DII5xb/riuSMfRJzenCmYsovwXu2MyDUUKKk2TBYhWMVt7Td0Rb/3GPg11XiKrtb8TYt
         sCIj+eSHKCnALpWWkgZZpZscILzzooMXdi4/2pNoIJfW/vRXn54Ac77V2mMoun1Tivgq
         m1l2I5fHqpSG97zLVIxCv2mwC4+0dQHQUI2u+XMMwShAjrxan3GGzfz01JGwLj3SjykB
         nV4w==
X-Forwarded-Encrypted: i=1; AJvYcCX6LchJhhvUrkJvjkWfrHi/S1MVOIKBb+819wsv0vY9IWK1Kic5f3Qt3Bo3nlnSjNsj+lYlE3/1CmsE4UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQaok0KjlzkaJLt+acKZ18f5hpcHJzeb6m1nW3E/6dGDftOhEo
	FkGpHYYMQkSqauDnMQfSvjv/u3VlYcx2rnOXclmwVlaep7UBUtAHUMfpuImmftPh95+KUP19A/6
	XtexGruLZu3w9xjAJ5c9s0NWBScT5Ug4=
X-Gm-Gg: ASbGncud0bILt7h28RsurhKILWaL+kpC76hHpC2I04E6Ox4f2wQ2FQ8pgV5zdmvl3S5
	7wL1Z/ybiIvav+IK0hSrosgMghcFjAbb0QE6SpVjSNJYN+Nn26NzNzn1VlxwWySH8vM/5dHqvzo
	pjuBYAfweILAdlHZ5kMFt05lwBVKCa+1FsYMwXYKzP0/HeHPBVe2Nnouk2g2RhIHV+FCk4iar37
	wyE+ryp6kIpatVKWruI24pfTZ7W8mqVkmfoGXQfZb4/vsgFtSUOl6tvLQfuEaE2tejtisq9TcII
	K4vuzxKoFmJj3qdAa5FdipG2cHJf
X-Google-Smtp-Source: AGHT+IGja1wjt5XLwCuQKBiJ++JM60DADavzjqt2nrtNRbHFr8AZSVSL3xnG8tTvwMdnenutWkIfTjAH31OO4EHeBxw=
X-Received: by 2002:a05:6e02:2383:b0:433:3664:b19b with SMTP id
 e9e14a558f8ab-43367e46460mr32976015ab.15.1762592790848; Sat, 08 Nov 2025
 01:06:30 -0800 (PST)
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
 <20251031220732.GA2254630@ax162> <CAMj1kXF2kKyEOc6KSBfbdUMf5m4o=DLZXk4++C3q-utA_9g4DA@mail.gmail.com>
 <CAB95QARrcOc6h9=YTzLKkNE0dEaivtiLfK0kEQ1jNp+v1w4yzA@mail.gmail.com>
 <CAMj1kXG_kPx5=3Qbn6ZTpKqOYh-mehwrH+d6Bw8QEPqvhZy1nw@mail.gmail.com> <CAB95QAS__YYYBLc3KFjBUg_QqC3AOB0y6kvhSqZFR9fx7BDKvg@mail.gmail.com>
In-Reply-To: <CAB95QAS__YYYBLc3KFjBUg_QqC3AOB0y6kvhSqZFR9fx7BDKvg@mail.gmail.com>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Sat, 8 Nov 2025 10:06:20 +0100
X-Gm-Features: AWmQ_bkRNHFJNtYSzgQ7yhp3JFrMg-7yCHs86SlmqgR8aqtR-dYbtIubCKtnEXw
Message-ID: <CAB95QAQyzYTrnGrkrcwXJ7Za37v7VsvwsmUezb1Z4VsF_RdLMQ@mail.gmail.com>
Subject: Re: Can't boot kernel 6.17.4+ via rEFInd
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I've got no response from the rEFInd author yet, but another user
reported (https://bugzilla.kernel.org/show_bug.cgi?id=220731) a very
similar problem with GRUB and ZSTD compression.

Cheers,
Eugene

