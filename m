Return-Path: <linux-kernel+bounces-753216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E59EEB18021
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118C0172C6D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5964F225762;
	Fri,  1 Aug 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+Y6eH38"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F01129CEB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754044230; cv=none; b=Ihre2Xx77DF3Bdt0I57xIJueZXkiyna4ZTjwG12E7tdQNPhKY/MI144tafN9SJ2RugKPVaPWchMmIDxxIehIyXiENepCBervWQyec2BJgC2w3qU4dEM2vA/R6WOmlfVMXTm60T8KvkEWVll1oMYxKx+Mcyr5ImFbYmda3t5Jehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754044230; c=relaxed/simple;
	bh=edSgcDogH7CSa3XprPhx5IVVENZeisLApcrIqHiO1Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Akm1YjBy1Mey5a+JJ1Ceg67u1lzH6dSGpLhOvtCq7IP/vBtukkb2Yc/UfOP/WNQgDca9fqrOVgfvw0yRwh25sVlLk+C06rApMtIPmCkcXZzfP53oLBwG7LGfhkBdW7rkcTS927VAMIBqj0OxAveSpjsTy9eMqK6vc+yBtkiPtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+Y6eH38; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b786421e36so1140751f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754044227; x=1754649027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R+MqrgO5Yl0URvHmsHiXNr06EO/8hBJAf8Kunyd3Fk=;
        b=h+Y6eH38fWreaeaV7GmH5oR8uwIl6esPXnxU8OInfrgeEAfLC/dzbTBINqqDf2mqh9
         CL5fC0O3sIvSjQsuUWWRIeY/SDlf71HAilKMJLBMp1+eIlFxl0rZyE52b9OAK0kPSLWF
         xTDoE1h5JCqFJRNevel13ErAUGdYUu9zq4tDwUXZex9r4A9esRejG3HV47A6mcdz+2QJ
         0kjeMP7pBG5+ANbpvAWRdEEZ8t+x9NQESSRF+VKaBkyXUFcW5HzOOzcJYVP2K4izxVjx
         H3xHgjYt0RYXi/hD2z9qp+72Ao0k+B/PiXPnu/rOE9zkWGBF0Ck+D8zZh5O7ORBTt/u8
         azyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754044227; x=1754649027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R+MqrgO5Yl0URvHmsHiXNr06EO/8hBJAf8Kunyd3Fk=;
        b=KTXMfc5d54bEc8cWEzaqalCX2QHfC+9cz+Anc0FSDVzjJxOUXmfYNkOE+qatCc9FFk
         i1uqgndruAvaJHETsWlVqiaI3EC1wwi2qbY7ZSuo2VlorcBNpooVMIpKiTMqaAD16QCh
         kUzz19tL7p1JDQhaGGgVPSn8DfkCXKtbm0ka/R0wK6bgVw36CUDyC+n+GXboqqULtP6V
         Tizo+ABiLadI0fTRjvnHLBpbKePr03chOfBxLfdv/yVCl4QOv6Bpr2j44dCqcK0oJLJS
         caYMxrf4iwEuI8qgSt8nzZP4ZDPwAu694AUTIvAlv1Q0ZPgdkd6OoffS0bjgWkZgGNzx
         Rv7g==
X-Forwarded-Encrypted: i=1; AJvYcCXqyzY7YzpiaQ/RyvBxnClVBZwOjXvT2EijGFwxefv1CzAW5TAK33mOWHFeDJGkzCOSCnbtNTDJgOkcLdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOkl/tgXHHuGtyMpfKMvNg+D+X/Bs99r9qUxmNn7gMEbWavxBW
	LCSXT08NUJVCmuFqs6fxKi5sRRhAK+xkuu5JVH2/Evtd0Gqv6P4A+0QvQ36z317RXU5Ko7uxc+C
	REaAVB+cmgqmHpXZG8KAqvdIrpw8Fn4g=
X-Gm-Gg: ASbGncu+9oI7Qwf4/QbyMCw6fDaBvlzOFo1+sSji5QOBD2M8sw6KvB/EJ8TpMIU1SQ/
	FmY9G8GR4D7kp9q3zuXMUFQhELtk9JU/nJRKU7yYx/EJgSjowQz98kSyWMdxrQCjWjfftb3MIDV
	yhkBqeX8ZUoM/JopFINBqjgW9V2Bgru+VwbelcGBo1TupXAlarEkRtzHZW9NAgdI5JWGgPujSgT
	+zl8h5eLw==
X-Google-Smtp-Source: AGHT+IHFfb9aylKzbGLPPo+9yypVoY7XdtvFrGtQic47H8I6uTq5dX/m0Fu7qM2GKR6tBwaCmTk4UWiTFQZcGNbSd3c=
X-Received: by 2002:a05:6000:3101:b0:3a4:cfbf:51a0 with SMTP id
 ffacd0b85a97d-3b794fed8bfmr8236846f8f.21.1754044227142; Fri, 01 Aug 2025
 03:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801092805.2602490-1-yeoreum.yun@arm.com>
In-Reply-To: <20250801092805.2602490-1-yeoreum.yun@arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 1 Aug 2025 12:30:15 +0200
X-Gm-Features: Ac12FXwpbti9uxZkALv_-SQcxyY8JUp4abK1P5ZF80uVJbXi5SM7UT7UOWr81Jc
Message-ID: <CA+fCnZdiwXXYmW9a0WVOm3dRGmNBT6J5Xjs8uvRtp7zdTBKPLA@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: disable kasan_strings() kunit test when
 CONFIG_FORTIFY_SOURCE enabled
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: thomas.weissschuh@linutronix.de, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 11:28=E2=80=AFAM Yeoreum Yun <yeoreum.yun@arm.com> w=
rote:
>
> When CONFIG_FORTIFY_SOURCE is enabled, invalid access from source
> triggers __fortify_panic() which kills running task.
>
> This makes failured of kasan_strings() kunit testcase since the
> kunit-try-cacth kthread running kasan_string() dies before checking the
> fault.
>
> To address this, add define for __NO_FORTIFY for kasan kunit test.
>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  mm/kasan/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index dd93ae8a6beb..b70d76c167ca 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -44,6 +44,10 @@ ifndef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
>  CFLAGS_KASAN_TEST +=3D -fno-builtin
>  endif
>
> +ifdef CONFIG_FORTIFY_SOURCE
> +CFLAGS_KASAN_TEST +=3D -D__NO_FORTIFY
> +endif

We should be able to use OPTIMIZER_HIDE_VAR() to deal with this
instead; see commits b2325bf860fa and 09c6304e38e4.

> +
>  CFLAGS_REMOVE_kasan_test_c.o +=3D $(call cc-option, -Wvla-larger-than=3D=
1)
>  CFLAGS_kasan_test_c.o :=3D $(CFLAGS_KASAN_TEST)
>  RUSTFLAGS_kasan_test_rust.o :=3D $(RUSTFLAGS_KASAN)
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

