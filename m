Return-Path: <linux-kernel+bounces-844491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B15ABC20E9
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD163E2A02
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E151FDE09;
	Tue,  7 Oct 2025 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4j1ajkS"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E32DCF78
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853542; cv=none; b=HQVetm+svJrfos1yu7/uGTTPpWXOrzfifdyH+k4qstLPTHe0S4TZOTbgQ/G4S31kxM+ZRx6i9AhKkihyPKMKTq2Zzolfw61udSv94tlhGL/dfzaNxfJecwk/OhjxU+wS84kMoyQI8PhK6gZV7BE4gaC55nKf1JrNI1YxkN0WnvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853542; c=relaxed/simple;
	bh=5E7iWUmZ2vIjSTqtzT1C1NtPApyBCh7aJPO7S699wwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnuyfOV699XWa2x1KAZNRjLZvOa5lIyHfFyBldrpLQoGE1tOFpV75cIIADHzZFTXovYHH3dwRxTJXvivwI8b7hBB4X6zAIwuSF74Wbmdo6WeWn33tGxjxf0cjoAwyyGSDJQh34TIrJBVDuTXWuRKSYAunQ/P831koSn0IJbaNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4j1ajkS; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b552e730f4aso87651a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759853540; x=1760458340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5E7iWUmZ2vIjSTqtzT1C1NtPApyBCh7aJPO7S699wwM=;
        b=i4j1ajkSaru1Tajh0Lkssq02qK/t5OvL34epDzJ4uw17i2bkr8Dxw2hyqqCi4oOEja
         drtjTchNNWxn9R15xc94/32bir5I7Lr3M3gHp0OZkBmVPkSXxFT/l4OMv1NIsRzcG7yE
         zofizUV34i6A0tygfL2SfZJg8M/bJRcIZ3ZwFZupw/wXQCjH1jQDF2yIlEHBG6D0wrR2
         cde33VTCxOAjxwtI36wfqJRCZJWDQYv9BsnB/gWTdAZ+YnGhrgB0TUb6Szch/1/DYhSx
         4A6sO7g+W1UqmUAJwSpbCBXq2CFH1WdppFvlEz7lHnZDyn2ZJRBOsRolP9d23OVHuBr/
         2Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853540; x=1760458340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5E7iWUmZ2vIjSTqtzT1C1NtPApyBCh7aJPO7S699wwM=;
        b=KynFQ/KJA43zywruP1CFhgVJ/ESxWRzSSet/quOyBBAp4ag01P5QI0YwdcOcZRe0wc
         +R8HBh4Or/Bf9SwWf7MbhW785i9VYxeaCzF30llCApyJTIx/n7z9UVYW244gffgGtWR8
         X0CYAF6rQO4Qh2WqkG04n4atTbqkQTXReTGi8ec8wiJdkLw29aOYAvccTRPf0NO/8/8d
         uIv7y3+Y3q2YJCpq4kOEU57+VoeO1CEj1TR1mNDfT5rEUbLFKidtNqth0PawKOe6vC3W
         2t4U1YyyffBWeRDQ2+U4nuv9Z47TOXlzuwh0MImx6QWyYhKZ2PY0jgU3pCxfUUh6Jr8E
         lpPA==
X-Forwarded-Encrypted: i=1; AJvYcCXkLHTJT2XVnN9jEE40Jqst70v0pkCduuMA1WjsCTEhygKZ262YFe1+pVYLhbi9pV/RoTnI3P7hYphO66U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxlWQxzqSIyI0RaAfGKIux6+p/YiWOmzJA4FJ8B9rLT2Idhten
	hLFnPjTY6j+9hobZ61EBGskbMpLttJN2VE86gIuA+n3X1oBL6voC9b5H1PFW8UbF8vFdSlr1i/h
	CJGhNbDFRVRZjTE/qNHKjjtCRUC7rbxI=
X-Gm-Gg: ASbGnctgyKcZLaZwUVWjhiUo5H4Jg26fWUmnTHGjY4vWfYbKAGbEYQkzpRZ7B2QMvbO
	hNLJBg1OJEmSsZPAv2U3tjeQAZWLK91LFDETUWQK0/HNp79fy7U5LJ8QzAjEhJ3KtdxVZ3IGPay
	CdG8y4g/NSvFSN7zsw1wdy88vlF9gaMNKD6hDL0KsfTT8cn2W0bBYmAblhUsi/5qDCXgLaAFk/j
	9YGyo3iLufjLuIFmsf3EnOOYSYLbl/OjfnvmANM6VPhSZGqqkUwS/yBF0zBHvdCyd/FQksUgLRJ
	gPNRXh6KbYC/H0LdiII+JrqNjEoQw/Bx6dAxGHOPlBYkNwov1w==
X-Google-Smtp-Source: AGHT+IFCzHpcrXLGR1ie60smXpk8UuckeKOb000I2PbnwCKR7UoPdsv6hdVQqjL0vFW9FH9QZdEfImMvB9toz+HjmvQ=
X-Received: by 2002:a17:903:1a68:b0:274:944f:9d84 with SMTP id
 d9443c01a7336-2902733fb0dmr2059795ad.11.1759853540296; Tue, 07 Oct 2025
 09:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003154748.1687160-1-joelagnelf@nvidia.com>
 <aORCwckUwZspBMfv@yury> <DDC0VAHL5OCP.DROT6CPKE5H5@nvidia.com>
 <CANiq72m1eiGVJHNyym+JwM=tQ9bGnmoW0+OuKQ3Vxo_AQOy5dg@mail.gmail.com> <DDC4DA0BPHRC.3P5M2CXSJYYTI@nvidia.com>
In-Reply-To: <DDC4DA0BPHRC.3P5M2CXSJYYTI@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 7 Oct 2025 18:12:07 +0200
X-Gm-Features: AS18NWAPdykPHVe-VPSk9QmwsEQUF86AhW888gSoYNbxgNmy_9MCu-o1i7ygLqA
Message-ID: <CANiq72kykzwdv2fOmRMeJ_FPztkkU2a=PFDH1fo9+XbGAeKsaQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Introduce bitfield and move register macro to rust/kernel/
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dakr@kernel.org, 
	Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Andrea Righi <arighi@nvidia.com>, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 3:21=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> Ack - how do you expect things to work in terms of code flow? Do we need
> to have a dedicated tree and send you pull requests? If so, should we
> host it under the Rust-for-Linux Github org?

In general, if there is a better tree (i.e. an existing C subsystem),
then what we always do is ask those maintainers first.

But, otherwise, if there is no good choice because it is something too
generic/core, then yes, what you propose would be ideal (and it should
be easy since you are already maintainers of other trees etc.).

If the amount of patches ends up being very low, we can skip the tree
and I can take the patches, but PRs are simpler and scale better for
me.

Thanks!

Cheers,
Miguel

