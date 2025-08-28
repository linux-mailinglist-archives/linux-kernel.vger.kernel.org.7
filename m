Return-Path: <linux-kernel+bounces-789932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADE5B39CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C6F17204B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92309311977;
	Thu, 28 Aug 2025 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YbtzRi+u"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE530F7FB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383417; cv=none; b=hL4OMYy9Lm/ai98ROUXC2clazijc92NoE330rAcicqslZ3755h/cd2Jrek1lRES0bdocaM7iRMIzYxvzHCBzaSSQgWj6sY0goF3XP048xRomsaz/2pxYu3c5uYCVgIQFIyGNeHzdp16vUqKa9DXhaNBza1t4IBFaNMn5TKl6CE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383417; c=relaxed/simple;
	bh=YbjQ0YC8nHU1VGJKGrnYgqhpxxAHUCouWFB9HwnIFQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZfyBj55XMrE1gRcdxrImAW3PIZUHl/2625JNf52qDnCFF4F+L6/tuKj73m/1MOXdpcJQgXp92Exz7UM7zsNHBOwEBwJP9yVfG+50TofP6QxCJaD9j4e+5KhBQtn1/Jx85DruzWWt62LJcU0tz6CbLLwLzJ5Pca4n9XarLzlezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YbtzRi+u; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb73394b4so125030666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756383414; x=1756988214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWyFqw/gsVVjjcdygtnF3DRHaolgd2jXueCTZS28y+s=;
        b=YbtzRi+uZatbziNjENtFN+d6gIeWdC1RclkWblX03RFEZ1weI05eXvXKMQ3lUQQQtJ
         F/YS2MgiEF3sB7Gun9/uTTXhhFJYutmWUF8Gp5/iApz0tvRJslmqUfi0hDPEbCmHmFYo
         J1+oHtu2rfN8sColj+I1IJ8dcp9RnBn5lLvWDb/cfHxR5mlTueoW5u+mWrz/yk1/Su74
         7w2GggXB7Imo5XVCPIZ62wflLAFjLXsFf3LLOP/TKM5eZG9jzqlVi939e8MLnw8IXtqG
         Wft5Gvh3FajRxDtLdB4HD/873lRBYFIvISa0ErG/aT9M8nK16aQjfGZ2cqpCvBEyGdR6
         tRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383414; x=1756988214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWyFqw/gsVVjjcdygtnF3DRHaolgd2jXueCTZS28y+s=;
        b=wScqLYRIz2KkE1DUVUIocRxhzdA1KgBkYbIMA1jyuf6M1zB0Qwysac9VdOeOl822/q
         AwOKlOl5HaVSC7yC75csPPpOq0jE0lvbgBwXONsZO8jXaJ9xVR14HXnk3AA6OB72drLs
         Kc+lytgxe33tHhFpUwabQzLNxdiZYYcQC3fNGPvOUyQ4vADkNuK+CzVepM6etkWEP/NO
         gDJ84B7vXaC0yXfCpS4DkRffJ+9zSt5afYELHe5usUXL2WqCAg05tSXdaccZVcgrlngx
         uMtqMYRNkBWHP5d2dE8BfSOhisg3/81k7+Jf66/GYsQEzhib6KoHMvjcsCuwbcOJ4iMa
         PU/A==
X-Forwarded-Encrypted: i=1; AJvYcCXu7eRb5fH5rZCd+gzWzOVVfdT4Bw7PIgoqRhtXLurXOY+pFwtK+oQxgwvn01nqJdfVQgM/hQrgXhK9dJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMFbvYh4ar0/vcpSB+m/ZTs3jnZ72Yk+24e8/mWTGJrXLkvuh
	fbD8+snQcvLWalCyaCOR/ACPrhMdFVds/8KTGqZF4acxe5ZcNWN4UMmw/Kh7Ih2JlVFOQZjhv2D
	EN1VjeyBnshmAK+00dEMj0t8ZORv8TVTtto692YLR1Q==
X-Gm-Gg: ASbGncvsP00+Y8RXilyk8tvHxmZzlNxG1ooosO57sn/DTnit7WRctQvkW+6l1b3jwf4
	BWsAfN2jB4qQa80DYZqEqxSeDhk/bkoNlK/Y04clQQsbQxudaze9V2qsZrbWQvLzrFtoOxDml1L
	939VDGqirxwJCR539I5Mm7Dmd5RHZbADmc7cF/wQOFUI8TDc0ZR6XdN5+rmnk6M3FdtBLykIl6B
	IWHuWkPkUms2hJDMgXmTuehxqc7XmMO4s44WG9R2CsBVg==
X-Google-Smtp-Source: AGHT+IG92wUWtZcOcyFCdpUJMrHneJ+aWHV8w80d9QUI9w9Y5DHiVSqiFDqmiY/01zWL3y4uFsiqXcDXjqiD4EO7IU0=
X-Received: by 2002:a17:907:c1f:b0:afe:e0f2:759 with SMTP id
 a640c23a62f3a-afee0f208f8mr241486566b.38.1756383413730; Thu, 28 Aug 2025
 05:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827192233.447920-1-max.kellermann@ionos.com>
 <20250827144832.87d2f1692fe61325628710f4@linux-foundation.org> <74a33635-3348-4e70-8cdb-16307f839b79@lucifer.local>
In-Reply-To: <74a33635-3348-4e70-8cdb-16307f839b79@lucifer.local>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 28 Aug 2025 14:16:42 +0200
X-Gm-Features: Ac12FXw9QgQbdlF5-e3G7cxb-QUjEWwDSNPWlxAiuy_mjRV_rxmRxLRg7xFYSjo
Message-ID: <CAKPOu+-0zuz-t22RmENiAT7SXTMyRVeHgkCrnLK-Xt-DDxHykQ@mail.gmail.com>
Subject: Re: [PATCH] mm: add `const` to lots of pointer parameters
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 2:09=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:

> > I'd actually be in favor of making all incoming args const (C should
> > have made this the default).
> >
> > Because modifying an incoming arg is just obnoxious.  That value should
> > be viewed as part of the calling environment and should not be altered.
> >
> > Try modifying a lengthy function and wanting to get at an incoming arg
> > only to find that something in the preceding 100 lines has gone and
> > messed with it.  Or forget to check fr this and get a nasty surprise wh=
en
> > testing.
> >
> > Not that I'm suggesting that someone go in and make this change.
> >
> > On the other hand, it would be neat if gcc had an option to warn when
> > someone does this.  I bet it would be simple to add.
>
> This would break half the world, I've tried making parameters const, then
> finding basically every helper function doesn't function correctly with i=
t
> + having to give up without needing to change half the code base.

Are you guys talking about making parameter values const (i.e. pointer
addresses if the parameter is a pointer) or making pointed-to values
const?
It seemed Andrew meant the former, but my patch was about the latter.

Yes, making parameters (not pointed-to values) const by default would
be a good default, but we're 50 years late for that, and
unfortunately, C's syntax for pointers with constant address is
awkwardly confusing. But adding "const" to parameter (values, not
pointed-to) should not break anything (unless the function really
changes parameter values - there may be good or bad reasons to do
that).

Making more pointed-to values const will break a lot, yes, because
this needs const-correctness in the whole callee space. This patch
here tries to do this for a low-level part of the kernel, to enable it
in higher-level parts. Long way to go.

Max

