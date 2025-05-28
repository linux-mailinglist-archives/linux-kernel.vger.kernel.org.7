Return-Path: <linux-kernel+bounces-665893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D759AC6F64
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 19:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE1EA26C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC1328DF3B;
	Wed, 28 May 2025 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0vHEnPRv"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360197E107
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453423; cv=none; b=av+FMdOh1JQz7OIzME90m5xNJp+Syth8dv0kXUushDMvrjkrZELoM+oioXqsLGL9mfVqEGBvcBQ6UAbMnT27cMsC8upJ+QZeeC6/NuGUn7aPBA5iytXra/vLQ9AaeZgULfTbwtZmJUluCqX1p6EhFMYn547sZsDC7EQe0npZJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453423; c=relaxed/simple;
	bh=ARY8CwNgeEkx4xeewofft7OOZG05/4+sLW6rStZljR4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A5ZHhtISNk/GQx41+vK7hFQgFqr4takWWqrbG1u9d8gdJou7nDv/o1SjT3vwRiSy86GzI1H53utho89mvrfyF7xvpReuCuGr0CSbGWsFTz+PSZ5JdSpNJJPkAZEPLmzGdkUo3D01mcVQna85PsNW+L95ZbjrONFP+kbS6m4EMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0vHEnPRv; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c3e576201so1031339a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748453421; x=1749058221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5lk3aR+RzRKEkMTxOWzVHzMD+THYlxrp/Tixh3xiWc=;
        b=0vHEnPRvxl8OZy/Y7wTTc11pqfjzRERfZHMbTLrG+0UHdiRO08+rT9acCaXYZzXHvu
         AYAGz/8VNERpC1goEnKBJZZt9lYQF3QlOUm/3T555gduuaV5Yg1edrv8bDx3MFV/izJs
         GGGB+5VjPH+0MJBsLYGMLkRg56dglb55mO1XGbj7GnRj33Bg+0NuPYu5iiPZzI9lvmeF
         FF2+PC/P6x5Qk9vHwVLR8RZvyRVK4BE+hu/QkTJiTX754RsdzIHsGuLgdw44iRxHnjwT
         5VkM6uKhUZsOVjd/C6k4rKYBlhGyNUsW8aj/KbuNEezB0wQggbxvuK6lJt0LHtRVnHVs
         t22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748453421; x=1749058221;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X5lk3aR+RzRKEkMTxOWzVHzMD+THYlxrp/Tixh3xiWc=;
        b=o20Nfp48cRFRbrKXRbl7Uo+UeRskH6napGwOq8rBYMTrHmG91I505OZTI2WRZ3Wh7o
         /vv1p3toy10YwzrqXRmuRR/MnV4hjcWtn1eVVdR+qHIK662Oyw/odXTEVgIodsvpwq3c
         Ak3xE0Lg+H39UMJm2JrNu4TxxVKtYzYyeb56zYockiNbCPq80RxtSfXhRboR5sPh36m5
         /7etBzVISTQs2xRGh8/0IgAHrTL5owDVRtcYnAXA6OlzdNfxP/rQuZfglWsQNQDdimlS
         FW4AFyA+MwdbrZbg/tH3mUIWkEd17WAzMNMHFZ+rZHsaneD3p54/09Fp4XMyQZuBQK7v
         e4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCV8WpMePBlkQEcSb/qx8FzjsboAJYRFBhPxhxeZM/0x1egim5Jbgizb91278tbJu1lkFHMCYHxPJBiVsEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBYQUjCdeq8EcGC7VGcBekfsWHcotPvFy6T6txHAVyL0i8nf2
	4wWDqJy+U8BAaZCSC0QXITtuYEQKl7Sa9k3uy2FRmUKqmiHSN9hbMoHfPm09fwrb09PPxgswB3t
	J1Lx1Rw==
X-Google-Smtp-Source: AGHT+IEsnEf7VuMExZRw8wVJdfyr2XCnHx5H/B/LOCvx+d5raumWeIsp3ExyZi0ZxIt7xWBlYTiCNvkn+ag=
X-Received: from pjbpx18.prod.google.com ([2002:a17:90b:2712:b0:311:8076:14f1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3848:b0:311:be43:f09a
 with SMTP id 98e67ed59e1d1-31214e6e01dmr517950a91.9.1748453421388; Wed, 28
 May 2025 10:30:21 -0700 (PDT)
Date: Wed, 28 May 2025 10:30:20 -0700
In-Reply-To: <CADrL8HXS7zvJZjOxTxPKH0dAGoMXnFrrxCW7J7CXRtaeV6izjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109204929.1106563-1-jthoughton@google.com>
 <20250109204929.1106563-7-jthoughton@google.com> <aBqkINKO9PUAzZeS@google.com>
 <CADrL8HXDDRC6Ey5HYWvtzQzjcM2RNX7c7ngGyjUsD3WiBF3VYA@mail.gmail.com> <CADrL8HXS7zvJZjOxTxPKH0dAGoMXnFrrxCW7J7CXRtaeV6izjQ@mail.gmail.com>
Message-ID: <aDdILHOu9g-m5hSm@google.com>
Subject: Re: [PATCH v2 06/13] KVM: arm64: Add support for KVM_MEM_USERFAULT
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Yan Zhao <yan.y.zhao@intel.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Anish Moorthy <amoorthy@google.com>, 
	Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>, 
	David Matlack <dmatlack@google.com>, wei.w.wang@intel.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025, James Houghton wrote:
> On Wed, May 28, 2025 at 11:09=E2=80=AFAM James Houghton <jthoughton@googl=
e.com> wrote:
> >
> > On Tue, May 6, 2025 at 8:06=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > On Thu, Jan 09, 2025, James Houghton wrote:
> > > > @@ -2073,6 +2080,23 @@ void kvm_arch_commit_memory_region(struct kv=
m *kvm,
> > > >                                  enum kvm_mr_change change)
> > > >  {
> > > >       bool log_dirty_pages =3D new && new->flags & KVM_MEM_LOG_DIRT=
Y_PAGES;
> > > > +     u32 new_flags =3D new ? new->flags : 0;
> > > > +     u32 changed_flags =3D (new_flags) ^ (old ? old->flags : 0);
> > >
> > > This is a bit hard to read, and there's only one use of log_dirty_pag=
es.  With
> > > zapping handled in common KVM, just do:
> >
> > Thanks, Sean. Yeah what you have below looks a lot better, thanks for
> > applying it for me. I'll post a new version soon. One note below.
> >
> > >
> > > @@ -2127,14 +2131,19 @@ void kvm_arch_commit_memory_region(struct kvm=
 *kvm,
> > >                                    const struct kvm_memory_slot *new,
> > >                                    enum kvm_mr_change change)
> > >  {
> > > -       bool log_dirty_pages =3D new && new->flags & KVM_MEM_LOG_DIRT=
Y_PAGES;
> > > +       u32 old_flags =3D old ? old->flags : 0;
> > > +       u32 new_flags =3D new ? new->flags : 0;
> > > +
> > > +       /* Nothing to do if not toggling dirty logging. */
> > > +       if (!((old_flags ^ new_flags) & KVM_MEM_LOG_DIRTY_PAGES))
> > > +               return;
> >
> > This is my bug, not yours, but I think this condition must also check
> > that `change =3D=3D KVM_MR_FLAGS_ONLY` for it to be correct. This, for
> > example, will break the case where we are deleting a memslot that
> > still has KVM_MEM_LOG_DIRTY_PAGES enabled. Will fix in the next
> > version.
>=20
> Ah it wouldn't break that example, as `new` would be NULL. But I think
> it would break the case where we are moving a memslot that keeps
> `KVM_MEM_LOG_DIRTY_PAGES`.

Can you elaborate?  Maybe with the full snippet of the final code that's br=
oken.
I'm not entirely following what's path you're referring to.

