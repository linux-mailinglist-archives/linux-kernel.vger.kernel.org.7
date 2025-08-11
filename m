Return-Path: <linux-kernel+bounces-763490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F39B21546
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC6F1A20B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF002D663D;
	Mon, 11 Aug 2025 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W11VJ7Od"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E5311C13
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940103; cv=none; b=u04cY5m5bIQ6RiAXTwKdZ94VbzPSG8gEwkP8R570h0Qwpi1Zmyj/3N3VivgnDBUajS701fH2sIbJXjYVKViZEPjIj27BVy8XwIjelhN3c2b68YhnX6rZPvDnkc2k4jtzbRCnQHXGESkB1073BwtqS0n1U2pKK5sh4u5W3hWse04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940103; c=relaxed/simple;
	bh=WfA5yKinma6wtByRTCx1cftkJPjcSnflCI6y0F3kQ2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iC3MT7XL7ZZ5hBQ+gH82K3S8DCibPCZtW8GCvk4VWCcYhZHEblb+pzX9D9Wg39Ol2qY6HWZquhbKczMmIRmIUXMJmkMHARWzVKvOS9mkdXGiU+VX59+Y7/D0EYGSE7HnOavZFm3fgqZ6rzXJvfzhh63H/Dc052g933kd9weh0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W11VJ7Od; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-af96524c5a9so620608966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754940100; x=1755544900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfA5yKinma6wtByRTCx1cftkJPjcSnflCI6y0F3kQ2o=;
        b=W11VJ7Odo98FtafJDUKqy1wJNE+Q+wTHig+Y4E9uBmV84jUB9jc31lDX0ZWmokwhBd
         TZLp48eqMEQefLkFuvJKpIcNwDjt4KWpNV0F14JwwXsU1SRH1f7ULGA8ysedO/rbwe3B
         1oEf0ZMgSpBSZ68lF/3zVRcM7YbUC+Z7FvStoPrwFYHmqcbzktW28MKqaylz6PpwMAj+
         Y4YORZoPfBAKL6BUAZw2jLuOCE3gAWuWZSDKqnFDIpIi4cPztifEpzZM0CsQokJanCIn
         OSOnch1vF9ieKiwDwrRja01mI38E+zEsA2XbbsuOLaIsGs2CRtiXmQtjNOJG92bFbLSf
         45nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754940100; x=1755544900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfA5yKinma6wtByRTCx1cftkJPjcSnflCI6y0F3kQ2o=;
        b=i2kTCiuz4wsksP1f4h2eYfcnfxHNrqVsqM0wipC4aowGNzKx+o6mRUSKmuO7AnRLfN
         mrwHFB3o7oL2Rkvr4iAikb9F7Nuf4kZ0VZSMJyYKMRfmeC+V2AiFpo1rZI7s1urO5kGU
         e9kZKd+vd3lokS9C1NYPjmPKdmfiWw89ituZv801NbTJpfJGhmxkd623H82q4WE+8cfL
         mPlki0a5k4ha/Styznc8E68U3M81jP1xvPDQgAovfjADN4MADBa2oXTebL1B3nR6zcxG
         nQ2LeSx66oahRV3DYpU6dRcn3Kl9dZPII/XYKaUDs1dOxrFUv9PYbpK6Vm8WKM/+RRXs
         ONUw==
X-Forwarded-Encrypted: i=1; AJvYcCWswsBhYZXjSop8PqjX19eaqB9dgIluVzk81DogE+e0LodN0LFj9hDR0pf/AtviolMoIvgpp3INXYji5Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqasyzEVow84mH1HojCz1t902Y9VPgJrvyn6ICCHEySIXnTOWP
	Lt63tgbmR0dI86HzbTLNHG4vJLKL64imFb5Up7F4iinMsuzESysIgKiCdWCu5hgUQh0iKBQNtxV
	lYvoWuolmZbPjDH/rcPdE8eVDacnemjs=
X-Gm-Gg: ASbGncvPtj/U5attkYkyKrqrka+dESLJTFDVldhssHNv3OZVvQnT/sOsCO86YIX74FP
	XoRdB6nn4XQaU9IX+3xJlOQqdYG7X9GaD1mzm8VRZ0+EYt8pAW3pYoAbHt9SzWZ81wWI5/N3Z8M
	JVLzyF4zN7Nm+ZTVqXrD8hdyzraXbJ1wWC8uzdy7+gQteyGKndeBTNmYuxZlgXIYHkKn0zVoddl
	iOA12YFFZk+xRGJAVnP12FJGrKCZ0U8iccZr41d+EVGNpOsng==
X-Google-Smtp-Source: AGHT+IEOro1frCTITrHsRWhfV38IS+Z8Lv5bnkyZtUOrrQBC0QzFHwPL9PwlAAjnVHvRabZT1vbWAPReE+R+BBwcbAk=
X-Received: by 2002:a17:907:72c3:b0:af9:6e2b:f30c with SMTP id
 a640c23a62f3a-af9c64d4ac0mr1238490366b.34.1754940099838; Mon, 11 Aug 2025
 12:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811182500.42670-1-wjl.linux@gmail.com> <aJo7_B6cQc1EucA1@hyeyoo>
In-Reply-To: <aJo7_B6cQc1EucA1@hyeyoo>
From: Jialin Wang <wjl.linux@gmail.com>
Date: Tue, 12 Aug 2025 03:21:12 +0800
X-Gm-Features: Ac12FXyT4htmSTdi5IcSa8EfmIvYHeg7deDi32-MVHCVVqZdKOUgkkfDOvnUAdw
Message-ID: <CAG18JnwT1P6W6AwQX0nKDiGTBtObzVXNO7RgO2B-ipnC3D4xGg@mail.gmail.com>
Subject: Re: [PATCH RESEND] mm/vmscan: remove redundant folio_test_swapbacked()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 2:53=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> This is marked as RESEND, but which patch is it a resend of?
> I can=E2=80=99t find the original one.
>
I sent the original one to the wrong mailing list and missed proper cc's, s=
orry.
https://lore.kernel.org/lkml/20250811181839.40336-1-wjl.linux@gmail.com/

> On Tue, Aug 12, 2025 at 02:25:00AM +0800, Jialin Wang wrote:
> > When !folio_is_file_lru(folio) is false, it implies that
> > !folio_test_swapbacked(folio) must be true.
>
> That is not true.
>
This is the definition of folio_is_file_lru() in
include/linux/mm_inline.h line 28:
static inline int folio_is_file_lru(struct folio *folio)
{
return !folio_test_swapbacked(folio);
}

> MADV_FREE pages are anonymous pages that are not swapbacked
> (and thus can be reclaimed without pageout if they are clean).
>
Thanks for the explanation! I'm new to memory management, so this is
really helpful for me to learn.

Best regards,
Jialin Wang

