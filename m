Return-Path: <linux-kernel+bounces-807991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B63B4ABB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91949188C535
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D231C560;
	Tue,  9 Sep 2025 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UC3TR3q9"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352B2F5E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417093; cv=none; b=NNhzE9lxOQklWHVkQ/Y3r3haGJ/8xKCEgliQepby5nXEIZ5aLoQKLyZIpvsH3MuTz3rsfgWMb6Au6+ICAuSVlyWjcesT8RreCdBnLU4aCmYTPcHGc6Y4WxdHr3au5wzIG1eSImvcPQO3goGrunSjeUSbg1kJ7YMLxVx4721xaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417093; c=relaxed/simple;
	bh=SlpGeLSPioG51P60BOa3LrpU0FbaPi3fRTERMh3jekE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkV5FkcXj8kBinGBqNMrFR+nairDcooLyK5aOlBVVI8pBV+Su9dCr1ZEGBdezBClZVoqLlTdtEvWqt0sxqNNHvnJP5Bnh2rvJSZUh+cxHFq2GCDeZps7wkZKj42JmtDvxQ1bCHLl88dboyXM+Rzn9t0AELy28VAVxpSUn/h2rWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UC3TR3q9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3df726ecff3so2914354f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757417090; x=1758021890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlpGeLSPioG51P60BOa3LrpU0FbaPi3fRTERMh3jekE=;
        b=UC3TR3q9BxQg4z7MBNOLLJ6DCdBr9DZzZc+a3GWk3/vmIWWHcwVDZnJxMZIygSHqzG
         +dX53fIzr5MzkDKEmoLBhxoujLNnbED6WuMYmf7q3X7r25h1oxJSS/Icphx45HZ1xmb5
         aZuW9nr34O/v5yGq8Ez/AYaVysZMHcPOTx3SV1vWp8+4nfFa//CaA5+kbpyYkSyNacoi
         xYGZC53GCGVIywbmTI7AKbNTrmxVspnlhOSR9QyTNZJVJV1xWMzYCssxtyxtVMoD7e46
         3pzxaSd64ySmzUUG7/kIdvsevlzTQpOLbKX4Z9kC1dYKkJ2C0gEJVh7GW7GTLuUH42Zy
         TQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757417090; x=1758021890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlpGeLSPioG51P60BOa3LrpU0FbaPi3fRTERMh3jekE=;
        b=FrIwt+HjLTPmfrBIszGO+KarREazvNL2T37utmCMw/foVy1eIF4ffQjAxbjv69aoNv
         k1ePJTKc6mEUK39jI1aGTNuN3Ol2On2DsLYZ+JEdLAFIaphpdkG0tLBSeV6Hue7w2Tmv
         z7Y1YTkj9EiZzECzRKpDv4Ws22ch8dv4z8QLv2kaHOgepdNM5c/7Djtm+yqiHIXLnPl0
         LMu2ri65V/Gyf/xquak00K6FZwjFqwtU7+RuSOalUWXKQEdtj9b7c0cM66FXqntJwXiK
         MwdD2np7M3q8APnA/sGeL/yUtbBSrR/b6c4pSiiD2Cph6vXgeoVphcCoGtuN6MTofxU6
         kihw==
X-Forwarded-Encrypted: i=1; AJvYcCVeQArdZYSFlYTvM/pgZDYjvBOubnkuH2g112C4P+0X9pbRv9ZW3ZM4MZWzOMVQgFrGalRg3r2d1tc6gmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt9fD0zS7QRcSKGzbUibEnJ34xk8ECtPnvRljpEVCsnZGBfS8l
	+9Q2/ko1Cc+k16iyeqRgc3Nzl4eHU5JkOHa0wg/wAWHROcH8duimu5SQng/xYriXfUuIvHV5hn6
	7LiCYzQ7fh/CJTgsWVrs0oCKa+ZundVi/JuEDtWOc
X-Gm-Gg: ASbGncsuHJaBCrrTVFeBEAOlWuCvBAp+L6+nn2sb8ZpowBcKD72w+WcOA5A9nCZNVrj
	j/R7aKnXNiNglPSbX2bmWrDuTHO83OjgTDf4x126edjEiWbzAknHhFKdZaUBo+k4OJJVRvgGGzf
	82ExV/CVR2KwCH0QYU0OuRneIafKbHxv9X3fvhltBY46EGm9xOOCGBSNvGuyT7e10HPNvg2YCQV
	l8ytQDgM2FLrf1b1PfJQHLnOHH7xZdZ4+83EnRBr20/CqjlHgyPqhDSaszD4/2IZJTNjTyKJeUH
	882Tug3Nacc=
X-Google-Smtp-Source: AGHT+IHml7KDQnLZb8rjsUtaI2jtqrtAkle19ABt+nKN7aScJ7nfn4E1bb8e1N2pJF4QBnZOjd4VFNVXBYUbkb7kvqc=
X-Received: by 2002:a05:6000:1a8c:b0:3e4:7f66:8ade with SMTP id
 ffacd0b85a97d-3e63736f0a6mr8635754f8f.6.1757417089737; Tue, 09 Sep 2025
 04:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905-vmbo-defer-v1-0-7ae1a382b674@google.com>
 <20250905-vmbo-defer-v1-1-7ae1a382b674@google.com> <20250905152505.005a610d@fedora>
 <CAH5fLghgqv0mNYf8r-rdeBaCGxYsdkBouqgo_ohx3DYHwpcZRQ@mail.gmail.com>
 <DCL8DQV23FIZ.KJ74UQ9YOFZV@kernel.org> <aL1pSFB9iBsfHFM_@google.com>
 <DCMJ6K06T63T.2UBTM1RL4YJ0A@kernel.org> <aL1u_YxOkuj1kIq6@google.com>
 <20250908091140.44856fde@fedora> <aL6TJYRmWIkQXujj@google.com>
 <DCNAE3CJMEJ0.JH1F0MJABXQI@kernel.org> <20250908122002.2c80dd3a@fedora>
 <DCNDGFE7RR5Q.X3PCDW0KIX89@kernel.org> <20250908141156.3dbdea0b@fedora>
 <7aa3f464-a3d0-47a0-b044-d8db93f45918@kernel.org> <a2006f74-75bb-48ac-ac9c-0a71c8f9d510@linux.intel.com>
 <8078cad2-d5d3-4e20-9848-034c2a503f3d@kernel.org> <cbd5c99d2394335ac4aeb2740994ab14508e2553.camel@linux.intel.com>
In-Reply-To: <cbd5c99d2394335ac4aeb2740994ab14508e2553.camel@linux.intel.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 9 Sep 2025 13:24:36 +0200
X-Gm-Features: AS18NWDW4ixkiSB7H4rrLvI2J3PBz80ZR4NKOECvc7-D1qMuUhNHVcSBxjljRqI
Message-ID: <CAH5fLghY8o0ouvaz48D4bsWMJ7A06L750xdKibaoe=bKjVOpzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/gpuvm: add deferred vm_bo cleanup
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Matthew Brost <matthew.brost@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Price <steven.price@arm.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 1:11=E2=80=AFPM Thomas Hellstr=C3=B6m
<thomas.hellstrom@linux.intel.com> wrote:
>
> On Tue, 2025-09-09 at 12:47 +0200, Danilo Krummrich wrote:
> > On 9/9/25 12:39 PM, Thomas Hellstr=C3=B6m wrote:
> > > On 9/8/25 14:20, Danilo Krummrich wrote:
> > > > On 9/8/25 2:11 PM, Boris Brezillon wrote:
> > > > > On Mon, 08 Sep 2025 13:11:32 +0200
> > > > > "Danilo Krummrich" <dakr@kernel.org> wrote:
> > > > > > No, drivers can't iterate the evict/extobj lists directly; or
> > > > > > at least this is
> > > > > > not intended by GPUVM's API and if drivers do so, this is
> > > > > > considered peeking
> > > > > > into GPUVM internals, so drivers are on their own anyways.
> > > > > >
> > > > > > Iterators, such as for_each_vm_bo_in_list() are not exposed
> > > > > > to drivers.
> > > > > Okay, that's a good thing. I thought Xe was doing some funky
> > > > > stuff with
> > > > > the list...
> > > > Maybe, I don't know. If they do so, the should send patches
> > > > adding the
> > > > corresponding iterators and provide a rationale why drivers need
> > > > to access those
> > > > lists directly and why we can't provide an API that handles the
> > > > overall
> > > > use-case, such as drm_gpuvm_prepare_objects(), etc.
> > >
> > > We're using the drm_gpuvm_*for_each* macros in drm_gpuvm.h,
> > > assuming from name
> > > and docs they are driver api.
> > >
> > > Also the drm_gem_for_each_gpuvm_bo(), although this usage could
> > > easily be
> > > converted to a helper.
> >
> > We were talking about the extobj/evict lists, the ones you mention
> > are fine of
> > course. :)
> >
>
> Hmm. Now on closer inspection it looks like we're checking for evict
> list empty, It looks like rebinding after validation may in theory
> evict some bos to system memory and then we'd rerun the validation step
> if the evict list was not empty.
>
> We could of course add a helper for that or if there are better
> suggestions to handle that situation, that'd be fine as well.

I don't think evict list empty means that there are no evicted GEMs.
It's possible for an extobj to be missing from the evict list in some
scenarios. That's why drm_gpuvm_prepare_objects_locked() checks
evicted on the extobj list to ensure that the evicted list is
up-to-date when you call into drm_gpuvm_validate_locked().

Alice

