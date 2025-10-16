Return-Path: <linux-kernel+bounces-856749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E22BE4F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36DD1A684FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0722A23185D;
	Thu, 16 Oct 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HT1UX00a"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE137222575
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637519; cv=none; b=qkEA+tmxZpTccmWEk59Tvc73zV8qupQvN18ueltRrAy5ZfhGIMtF7L6K3T6NT6lSX3Pg3Y1zM2a6+oesloKrVt3I+vaj7dFVrdQmKcl72ETqNxuk8MVSVGWMGnY1Tq1SnMEX+wd5L2EXsO9RkEj96k1ypZs1jTx6LR65+a4G+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637519; c=relaxed/simple;
	bh=R3RwGP6QHDreMcxjaLIw71PUQygCZwdeGhPBMRoSyzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqB6z1IFOFNFYjyBXn2MRaFj6hOsUPTPQ1Pz8r6RgO7Jq83uUd1nCnYDx838Juyf5Bqe49zHqo4t2jFho1kWjfpMgJ1WgmsDDWDcny5zwL7UsvU1H0mcWMVfib9qhmMwPWVheAUKpFVn4thMM+dVIX1ziFHvWnBhskFl48uYjag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HT1UX00a; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3c2db014easo230214266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760637515; x=1761242315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fZNdo6IOExcFVFfhr7rwkSFSNClAo0oWYAwloq7HC0g=;
        b=HT1UX00aRfcMEXc0Co8J+L4FNA7f+AQFJERoYX6Ye8Ecc3y5RyWAbFIBCdGtRQFVhE
         1iwvIUtgmuHJJsbTiudjRSNIVbWd4LR953x9VP71CePdtqLyfg/ByRpd9HSRdwv7w9zM
         k8lpxRS09zmrDgM6ILJbL6AsSDutfwPWySlF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637515; x=1761242315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZNdo6IOExcFVFfhr7rwkSFSNClAo0oWYAwloq7HC0g=;
        b=UMzDOKDvzJYkxM/J6T5WyLxkIOC5gKycygjDm7v1G1znv8Iz5gRukgTGaSyGfnRN/f
         dO797PQV6bfgdg5a6QpkNqw8KF08vCzv24V03X3WBB+hftwasvyI8J7eKsY5qqr6t2uf
         riRz5EP7IP9EH0rNyKDtenRj7ak7OmyT5X93Az2I7nLJfWykNhqCbAkHpT+iHbJkq1AC
         PylgcMdWWSeer3JbRFTpigCacn61a1CQF9breFWHBK4Eq/AyNaRN4AzH1REa8ngsD1sm
         QxtMzSeE7TNzvk6iYUFER2ksnQ43mSH6uinS7VsY+D9fiEzW1WDvrRLwaKCzX2Jgd+Cd
         ec4w==
X-Forwarded-Encrypted: i=1; AJvYcCV4CPod+7NajDtRqZ9uFNeBGSj7DXx7lGxSt4+NV+bk2Z3rVTrB9HZj6A9bT1Sqcv2uNbBoNpwoCFfWp+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw78vx0WYyd5yBSRDmGuiL2zAmLe6utSxQYcjPsyCsN4Q5pX3zr
	AYPOIt8cwxg8T9ZzrNOmo75wszDQV5ot8qiHuA46f55YMJNk+v08HhzzAnNk6JdRjjEwz2C6JHh
	RxZWgsuw=
X-Gm-Gg: ASbGncsCQc0n8IHxtLjNN2ptT06ZoCXYALrweR1IEjEVMf/v8a26V2+tJJb3FvWYJD6
	ixMO7im0niGoCNQzncJy0vAkpsNnzzlY4i1P5/VUBOSub9K+cQD8X9jNzUQXQK7wN8K0sEl7ABr
	F+R7Zfw1bHc7JMFgiRIdlxsD3WkFWbrsQ4Kww6X49EPriA7q3uT32nxTqFhpraVdl8VBpWXOj7C
	/9s0FMuMtifsCGvaecWdyIjPP753Yo0Em+2jbsu5khszf3+ptf0nYDPD6pDdP8NiUE5AQacHorq
	LH8bZC8GzOLSh9nmfQI/EAOO78HZxCKfKqfndrfOfznqLJcBy0zva/ir0cHmO3pjV4Kw2XUK9+/
	rw/ef5YMcJf44ZRi6uF0mp+3bF3bHzEz/UfwpEI+NJreWjVSeWiTdqGKSBb09PxJOj9k/yDf86k
	BG/92vWkwBlrzaxkxpLfgEGlRMBVSaqov3vhbLXJ9SRbBoReBHGw==
X-Google-Smtp-Source: AGHT+IEwrSaz/69FIx0ighy/r+69ioHUHVdMflPYhvIqytKSSSBLl+3Os8z5Odkq747sqkewa6J4gg==
X-Received: by 2002:a17:907:26c1:b0:b5c:753a:e022 with SMTP id a640c23a62f3a-b6473630cadmr89212766b.29.1760637515005;
        Thu, 16 Oct 2025 10:58:35 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd4beb62sm562434266b.72.2025.10.16.10.58.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 10:58:34 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso1947362a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:58:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKwv+3NOU16Eu12wQbPaa30sczdyxINGwNb8SNH7fFDFKdgWZcqegCpJ2p//OxMVI+vKOwYjL9l8Dr3qc=@vger.kernel.org
X-Received: by 2002:a05:6402:280a:b0:63b:f4b4:a005 with SMTP id
 4fb4d7f45d1cf-63c1f6419c0mr820839a12.10.1760637513765; Thu, 16 Oct 2025
 10:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760633129.git.dsterba@suse.com>
In-Reply-To: <cover.1760633129.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Oct 2025 10:58:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiysgAErOobR02zECiniaM69AacAHjTOSKsv3yDF2R+A@mail.gmail.com>
X-Gm-Features: AS18NWCW69bbQCilJuwzNh2MGEz8nRlr1ju2SK0ZTD_7Tzbzhzpwc98VIVLFRSk
Message-ID: <CAHk-=wiiysgAErOobR02zECiniaM69AacAHjTOSKsv3yDF2R+A@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.18-rc2
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Oct 2025 at 10:00, David Sterba <dsterba@suse.com> wrote:
>
> - reorder send context structure to avoid -Wflex-array-member-not-at-end
>   warning

Ok, I took a look because this sounded like a bad bug, but that flex
array member really isn't a flex array at all.

It's clearly intended to be a fixed-size inline array, just using a
flex array for syntacting reasons.

And that not only resulted in that warning, it also means that the
compilers can't actually check the *real* size of the array and won't
realize if there's some actual overflow problem that they might
otherwise have been able to see.

I do see why it's done that way, but it's not wonderful.

I'm trying to think of a way to do this cleanly - we have some similar
things elsewhere (like the DNAME_INLINE_LEN for the dentry, which has
a similar kind of use-case).

But in the dentry - exactly to avoid using a flex array when it really
isn't - we have that ugly "calculate things by hand" (and the whole
union shortname_store, so that you can also treat it as an array or
words, but that's a separate independent optimization).

Sadly, I can't think of a way to have the compiler just calculate the
right size at structure definition time without just having to repeat
the whole structure definition twice.

So that flex array may be the best approach even if it has these downsides.

Does anybody know of some C language trick to get the remaining
padding size without repeating the struct definition?

"offsetof()" sadly does not work until the structure has been fully
defined, so you can't use the "obvious" trick

    char buffer[256 - offsetof(struct .., buffer)];

and anonymous structure members not only don't name the container, the
strcture type also cannot be named, so you can't do

  struct outer {
      struct inner {
       ..
      };
      char buffer[256 - sizeof(struct inner)];
  };

to create that buffer.

Oh well.

                 Linus

