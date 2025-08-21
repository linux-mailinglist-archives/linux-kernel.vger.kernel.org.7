Return-Path: <linux-kernel+bounces-780434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B78C3B301DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787511C21CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B90E2C21CF;
	Thu, 21 Aug 2025 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FSOj06Ts"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7319EED3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800394; cv=none; b=bR3UFisfiCJVLkVV9xSVTDB42BTPxsY3Rp5H3B2h06AAAZndr7Jqb+k5tZKZb5uauAMXZw5aAgJfJa1YQ4XVGKtjvNMlwq2ipSmRQdUmGRz7VUcBpEbGKafWl17CjPipeE3KQ5I0O0rkpL+Tf+RThhXzWzMMCGeJFbSE81bVfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800394; c=relaxed/simple;
	bh=RudU785isuNMZy/O7Hr4cp4IviMqo1m51VWsSpO6IUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMv5Be800zVE7YL2wrwXMT3+T0YeDNiwQ4kze4D5/0fZ9mYP2zfCE80vlC/1v2KpZDvrw9X9FGDRu0CsHrhyM1vlpuSdhHgN71EULS3iMjzQk4ZTA9nxBycDtQm2XqVAcQ2UwtOq98JpUHTf7sgbqXGYrUTjmmI4V6mtk7fgO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FSOj06Ts; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb73621fcso183931066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755800390; x=1756405190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gizn1fsNGe1xFcy+wsekYTitndUE4uCtx5bINEHMsQ=;
        b=FSOj06TshdfZ+A9NQM6yKrxm7SkRVd/vDHiYTgMu0vNTPULFALTS9aLbZfBSaQP35l
         rZV5Uvde5+ReIOwfdRP5aCmnlcGE8AkWBbEpc7thHSfOlddx2uJoX3bJ7mmCTzaZpt/9
         gV7XhumcD02BX5Nn99uKs5B01AIX1HYhYGcLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755800390; x=1756405190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Gizn1fsNGe1xFcy+wsekYTitndUE4uCtx5bINEHMsQ=;
        b=jUbHMwJrg3EzDrhc5OUxbyO9ZRMLVbpr7mkC0JU9eeq0n3vHIG4bQFHyCPlEP1rWlW
         fWJ2btm21ggSwqoEYz1dwtrBbiwmrhRvBfAM8MFmX4wADFVjduyJXV3Uj+C4f29l7WE2
         sfIW8+MxzwjfW1P5EwBLTlkCfyEI/Tm8xt6ktJEJl3iJZbTMZ35qZgXdNNKNH2g+X2c6
         P4/LVpDW1e04i01NUe3Q5xhZ0GrwH+0dfDdWOKRU6HxEFfwftDSVEIVPRmj6KYI55rqh
         wDjJFKyXydqYawQGQYou7XRM2Va5+o0+Mk1ubk+wAm9iUc+lZ3fkRBvMd9zyvMVeIufM
         YD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYvIDQJoJt8C449wmxtcn27QnjBZA9unnu69aL7zDEuqqgZ2dHqB0eB+mT+tyyc6xMBIBfgm4TIaCa8cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeZtI9Uc+uAERhNupQrDtLZ5m+O19RrOHaBGc9hLiE1p6VdEig
	9aVXJZLzjJGYk+9HSHhLU1mOa6BC9jmKG/01QoHVEwMed2Rmv9E5ZH3ublYgpZM7N1k+Z1e+H1h
	hWCtjvoY=
X-Gm-Gg: ASbGncvubY6AOkg4zOgyuCOR2h+uIErQ2/5J/PusF97h9bD7OYlXoOFsyGKx7b7pi4d
	MeItQjeRaPVyMqQnGQCFs7TKrRKtfrZy2MaHB8NNsSUPN/NT+TC8q5pZxIOqJQyGoU/6p4tH+du
	CZnGzaOTeuOPLpNQp0JsNG5/GCS/25Qulr2Nbt1RhewCbvZZwnVFGdRZ6DX8k9fJQq37csWIANz
	hv8gVn06LwtPpWNgAAfuFFaoySPlhKuOL+wpbgRL3o9QcZwTwtfJfJsGfruCJJWhb5oDNGCWYIK
	Q1M91+ZqcZBAQV933wNNRO0sXyIKZQHso760bGmYlJKYx2rjP4Zxw9s9Oj5pAwTkj3/ALnCnFSD
	yD3n+fdPcy18L35U3D6SmTYstoagRZP/noVyH4rCUM16n+f51kRdOAejk8btx/AW+FHExiSTHUp
	HPz8sqf6M=
X-Google-Smtp-Source: AGHT+IHvRM9vJKy2vtsat4R6oHE6/yFUpBMeD7wE4QtlyLvcC1SRcRFjHK2EOMUpALOZrnr9CeDKzQ==
X-Received: by 2002:a17:906:c145:b0:afd:eb4f:d5ce with SMTP id a640c23a62f3a-afe29743499mr7536566b.62.1755800390315;
        Thu, 21 Aug 2025 11:19:50 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded35547esm431122066b.50.2025.08.21.11.19.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 11:19:49 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b794743so1721212a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:19:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtS/Ccw4ye7WstYbbinq0SaUK2RQbg0p1HAndC0K6WYDPoIsPUthRDJ3xzqZ9BXr1YgRgcRcUSThVW7Yw=@vger.kernel.org
X-Received: by 2002:a05:6402:21c6:b0:61a:8966:ced6 with SMTP id
 4fb4d7f45d1cf-61c1b717eb8mr11735a12.35.1755800388973; Thu, 21 Aug 2025
 11:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250809180207.GAaJeNHymvt6gaR5nY@fat_crate.local>
In-Reply-To: <20250809180207.GAaJeNHymvt6gaR5nY@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Aug 2025 14:19:31 -0400
X-Gmail-Original-Message-ID: <CAHk-=wi+X2A6K839AxrRvaCDCakya-2B68NTkYP5YGfi-h5EuQ@mail.gmail.com>
X-Gm-Features: Ac12FXwqB2CftCI7W4sUe4VfDZb4BKB7wibLavSBa81ynIGW-1G6oEU48Nqmdj0
Message-ID: <CAHk-=wi+X2A6K839AxrRvaCDCakya-2B68NTkYP5YGfi-h5EuQ@mail.gmail.com>
Subject: Re: [GIT PULL] locking/urgent for v6.17-rc1
To: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Aug 2025 at 14:02, Borislav Petkov <bp@alien8.de> wrote:
>
> please pull a locking/urgent fix for v6.17-rc1.

Ok, so this clearly wasn't a fix.

> Thomas Gleixner (1):
>       futex: Move futex cleanup to __mmdrop()

So this causes problems, because __mmdrop is not done in thread
context, and the kvfree() calls then cause issues:

  https://lore.kernel.org/all/20250821102721.6deae493@kernel.org/
  https://lore.kernel.org/all/20250818131902.5039-1-hdanton@sina.com/

Hilf Danton sent out a patch, but honestly, that patch looks like pure
bandaid, and will make the exit path horribly much slower by moving
things into workqueues. It might not be visible in profiles exactly
*because* it's then hidden in workqueues, but it's not great.

I think it's a mistake to allow vmalloc'ing those hashes in the first
place, and I suggest the local hash be size-limited to the point where
it's just a kmalloc() and thus works in all contexts.

Or maybe the mistake was the mm-private hashing in the first place.
Maybe that hash shouldn't be allocated at mm_alloc() ->
futex_mm_init() at all. Only initialized by the futex code when
needed, and then dropped in exit_mmap().

So the problems seem deeper than just "free'd in the wrong context".

           Linus

