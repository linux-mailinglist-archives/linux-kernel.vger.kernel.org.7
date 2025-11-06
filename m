Return-Path: <linux-kernel+bounces-889320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D348C3D46A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB4EA4E39D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC03F3502A6;
	Thu,  6 Nov 2025 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OxEE2XHn"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F266B1D516C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762458584; cv=none; b=hVA5S7cP6Wu6eJUrcD65yP/pZ/t84KxA34i1H0ftZEa11Pw4rseaYjd+L2IJbA0CSkx//eAopvjV+pu2lWjceM+YW366O+eKHS7W6pK0VQG6jnTQsWhqExAcqQAqmsJRQw01O6UkLyLWr53tJqGtONr49qqp7idPjGw3EwPkuq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762458584; c=relaxed/simple;
	bh=KNglB+is572fPQik1I8VuhdCkPupPcFd+dhc6oteTRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N20kbUkByo2RdkmCuxGEvpZ9zhHiI0VQl33xpweV236Ej6nknl+3ebgBigAvU9snRYUFmo1TfCanISKAcPL3VMt+FPxBDvWh3dRm1UaiDnZmtc9E0J+8nNBDnWJsKMTbOF+5AhiVutkdl2eS3MGP6qsYJBgX74U74yud8BLAkY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OxEE2XHn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b472842981fso622466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762458580; x=1763063380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nBrsl6/CQ1RQ5Pw+U65hqGvC9Glz2m//zyu11cb91Go=;
        b=OxEE2XHnid83VI3lutzOsUpSbGPK2mGwMQdKqGfm8It+YgIKbG1INgVuQOJssjOr23
         XWQ0c44fv2hAfAMeXmjmVVLSRWksfWiF4ATGUSl82IYSxr6LqnNo6UVOxXW+T5X5V0fi
         lCk8FAro3in854AGzoy0W9y+lPnehFf0kojw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762458580; x=1763063380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBrsl6/CQ1RQ5Pw+U65hqGvC9Glz2m//zyu11cb91Go=;
        b=bHZLpqWllYYBREv/ZLDQgWzlzEQY7+ZpOCsoRTQnsujPCjMKVhe1ldG38JqWM0x6I6
         Sglhf45JbG9WBMkWsTngTOF+v+bUWOb86UAcdidvBUJh694bS9BoDkeR6onMVsKVJgOy
         9uWlTF7KQdT/eJNTm38tgRNBeSA/2CHIbMyppCet4NorVLJqk0N9nkZnKJ8Mgs3OuTzo
         yci/Iak2uF7ikgyzrBwp9DqG5D7xOcgzfaCauAK7/G+n+OvL4w35TAsoJ9Ei/VF9tjog
         sN6PTYI06axhY8K6mu5pnqSDXEm6oPcTpRrf1N2ga82wWziI+GyRc538O7J9Vqp+vN5Z
         SUQw==
X-Forwarded-Encrypted: i=1; AJvYcCXeRP7OOlLlCMUibpAiTBsJgXXAtk6qLnUqZK17QeXfJ0iUUvGvElvnS9/jTyB0MxuOiGxVHm/XSIJzzUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZ6jhOwd9E2tv7bGsJ0NmLjxF1oe4D2mzdZfnw9t5rfJo0+4I
	OWTtzbJYQOgV4fcoZDG+lKlcoQOzRoEPRbhxG1UW5/7NugCvzKyiwaeRK7dFGz5CUOzK4BUtF8h
	yC/5NU4Q=
X-Gm-Gg: ASbGncvMbH2G7qFOfrs+Q7GjQXF+BRNPTxkhlhp5G4q+XPeDFwxLGPiJ1N2q/U9ITSd
	3JBJwc5AQpSFUDO89M4w6mbHch8hNR655tP1oG9+wtT608dRMaCWvZuToIpmOJn0EykJheteT88
	dPP5Jinb82OKmJHCf8RSuVCDVNlI8DSuEAdmUWJE6SzFcYrL5R92Yb0KAw/KLo2KLLAyxBX/XQq
	4m0gf7GPLtaMOsYVkBedl29h5YeBsvUr2dgLAC3GobuJT+hqohB24+FQJ6J27skHrGGA5x1o42i
	KuHkjqxplHW+zO7bshDUNU7JzCiXB2UF63C58qwC3GRrqVr7VrXpww/s/2qVPBiKebHTuoRPVGg
	kSZrYMoKbkRp1ddurPzxVQHdmRw+JG51b5CH7dbF/sRYU8fzv1QNj+75JPdVHl5YAj32sJBeUVS
	ew6gw+RuxtEWjBGJ8ewIrsvdSF4Na+IZlNgviLmJHVL0t6dhSArw==
X-Google-Smtp-Source: AGHT+IHp0KBQanTUQaYtv12xQ3ubJSfYmu52jWA5EAJ1/vX4oiXujyRPyZ2zs1ZKo6JZzDzBpKXaeA==
X-Received: by 2002:a17:907:96aa:b0:b71:df18:9fc2 with SMTP id a640c23a62f3a-b72c0cfe769mr59500566b.45.1762458580085;
        Thu, 06 Nov 2025 11:49:40 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf312271sm35440666b.19.2025.11.06.11.49.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 11:49:39 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so5804a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:49:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHU5plJGkSDuF/ZyMANH8FAe0L3XUxWO9UxyIusFVmVcDHUigaDUfjx3ATpLmAEpgeE3hQUVeyMpRcSx8=@vger.kernel.org
X-Received: by 2002:a17:907:6ea5:b0:b6d:4fe5:ead8 with SMTP id
 a640c23a62f3a-b72c096d4fbmr51233066b.25.1762458578590; Thu, 06 Nov 2025
 11:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local> <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
 <CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com>
 <20251106111429.GCaQyDFWjbN8PjqxUW@fat_crate.local> <CAGudoHGWL6gLjmo3m6uCt9ueHL9rGCdw_jz9FLvgu_3=3A-BrA@mail.gmail.com>
 <20251106131030.GDaQyeRiAVoIh_23mg@fat_crate.local> <CAGudoHG1P61Nd7gMriCSF=g=gHxESPBPNmhHjtOQvG8HhpW0rg@mail.gmail.com>
 <20251106192645.4108a505@pumpkin>
In-Reply-To: <20251106192645.4108a505@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Nov 2025 11:49:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9yyNH7Xj3r_zO2vOtwfB8+vBt03Z7XRpJE9qCo-K6vg@mail.gmail.com>
X-Gm-Features: AWmQ_blSRvPDLC84LiEOMXHpSSJxscSXsXuq9j4k7UimqA5YjK9SBdhiuq1mY0Y
Message-ID: <CAHk-=wj9yyNH7Xj3r_zO2vOtwfB8+vBt03Z7XRpJE9qCo-K6vg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: David Laight <david.laight.linux@gmail.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	"the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 11:26, David Laight <david.laight.linux@gmail.com> wrote:
>
> IIRC it was a definite performance improvement for a specific workload
> (compiling kernels) on a system where the relatively small d-cache
> caused significant overhead reading the value from memory.

Some background:

  https://lore.kernel.org/lkml/20240610204821.230388-1-torvalds@linux-foundation.org/
  https://lore.kernel.org/lkml/CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com/

where that "load address from memory" was particularly noticeable on
my 128-core Altra box in profiles.

That machine really has fairly weak cores and caches (it's what I call
a "flock of chickens" design: individual cores are not particularly
interesting, and the only point of that machine is "reasonable
performance on multithreaded loads thanks to many cores").

I did have numbers, but never posted them, because as mentioned in one
of the emails:

  For example, making d_hash() avoid indirection just means that now
  pretty much _all_ the cost of __d_lookup_rcu() is in the cache misses
  on the hash table itself. Which was always the bulk of it. And on my
  arm64 machine, it turns out that the best optimization for the load I
  tested would be to make that hash table smaller to actually be a bit
  denser in the cache, But that's such a load-dependent optimization
  that I'm not doing this.

IOW, the actual biggest impact on that machine was when I hacked the
dcache hash tables to be smaller, so that it fit better in the L2.

But that's one of those "tune for the benchmark and the particular
machine" things that I despise, so I never did that except locally for
testing.

The patches that actually got committed are "these improve performance
a bit by just making the code do the same thing, just being less
stupid".  Much less noticeable than the "tune for the machine".

               Linus

