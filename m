Return-Path: <linux-kernel+bounces-839041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67C6BB0B06
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D093C5074
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849A026158B;
	Wed,  1 Oct 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdW/Z6nF"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFAA48CFC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328589; cv=none; b=ECe11bst5NL3ow+CrS55wNtvl/RA/qLMU0aQA1Fyfd01TNHMrjk52etUvVmiFoL074EkrYqh9n+j2Xtnt8gNGOZ2/kjniBFzXkMO7Pbb6LCuWp18HOJLEzuXG/s9hqKDcgRayTrQoDiGu3sQpNKATGUYDrNoCdZ9fQ7iOdsVLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328589; c=relaxed/simple;
	bh=FmtIBDf5zkip6g4eD/UswZPBKwOpkuCPfzBvxBmzoQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAaFzWfmW/XVZiSFnKOxdO3yd7JyJ7CJxhJMmddRlFMSpyP1RCklcSpCt+OwMByZEGnJKJENS27HdKcBmOoxk2ffow9Tj0mQj/Bstx+//lET15i5/KKL/47Mkr3p9NGdHcBnYVILXan8vlQJpGK/ppyDhEWiJcVW+458urjGxMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdW/Z6nF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2731ff54949so155025ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759328587; x=1759933387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRDU21uoioJAyRtmdoNLfN5ywa86kEkXqLJeusadAtI=;
        b=gdW/Z6nFLRNc4cAm1wrmorxHwQiAEeA6CEMmmZFMoFH7iQaiE7CdVb3SCEmKbrACX3
         yh7X3cB3QpmsAAYdItjp8HHjJ5DsQhko1qDwxRQ2qh9RLghBlUo6Wnktvvt+VThSM+2S
         aM5aCj6W0tEGW/ue/cMXv3BHj0IjQ+HQMtWN6sEgjNHiLA0ar5a0xTd15IpA7st66D5p
         SKYoTEE4yxFyIVz6n4QHrPPyifOsgD9sFWbaHK4S/JkvuxlSdhI2LYuBkZqKfHejVDpc
         FAJzU1j9kdV7KWbsHxuFLXsMkk0md6jH93AlLp+1aEBhu/xCHKQXNh6YGWo+BO1SyZMR
         p3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759328587; x=1759933387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRDU21uoioJAyRtmdoNLfN5ywa86kEkXqLJeusadAtI=;
        b=MCYHg6GDy4X4D55vGlCHfP73k4KqoYPCJKcXFSRAiX4SKJNlab7nlGJQTG+gNl4Oqv
         NYQ+CT/PLxID9xmKows0NhKrvDRyPWYdTxxmzsylsjO6s+nqtDNrxPHhCyzcdO7dEhen
         5mm9YvryzlgPAeHJ81y1EX8Y2UixBB0MmoqP2ExBS1qKWxxFYgrpqUPrnkaxQaIS/Drq
         wiliPJ1uZyA15VZX3ystu8kDiByZAPNKIymJbC6kSeYNslNZ9ZxVJdLc5P7UXhUr1RDu
         bt4VWgS84Rc+CoVhSdzzHiUk4HjcV70rL5GBf9tLTDZFNvgvs3btE7oEGZCWp3Y/9Va6
         2T3g==
X-Forwarded-Encrypted: i=1; AJvYcCVPDt2ZyUhqoEYo1GLXdb7MJnI8GVnffffPSAIsP6xqkb/JA6u1I7Zhvsb2/Y+UDRV1qgmi6q/w18IopV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTZaBINaLev2RA6AgFTVxeQ9m1uAO5F6yGiO4KW3HjaAIm2j4
	enHNKeKnkKElsBx/uHqIF1JyeOXI5njh9SsijPN3M2F2eRfKlsZG3D+JZtsyTqWmkGRFiKljYDq
	9UPjJnYhIbjqWWY5+T+o5ccuWDX27VYqw7mRdMTV6
X-Gm-Gg: ASbGncubeDCw3H2SaVUZvqy1NkKWGvLx5LPIh1rA8JoRyYAHbi1lb7l59TZDbvXkViy
	rWGyEu93Bq8rZyaAvsN9r8WPVzJVIL0g7gynR+1E8NPPSnrQkgk7w3KRX4D8H3HE+v73MOsOQCH
	m5f2P1EeIEBUpHBsYT9kLkIgwYqoCfjHzCphcWvUIBhlAJ+JkG24wCtqKCoNDTLd7cS5AHmXzIZ
	d9LvGKHiCMyz9/mbGIh6EriQfgew9/D2LfuyBW1FSnRUZ/xZuvYQoWl+onYd22Spx3StX5FyQjW
	hZrHTw==
X-Google-Smtp-Source: AGHT+IFjNi8Io1yPUrwHGeOkJcDsUObFSv7z+2KeefYqjzChvcYJ2tFoLRup7oLYrJhe7J5OIZo+sAxoga+39UD3Lok=
X-Received: by 2002:a17:903:1aac:b0:27e:e96a:4c6 with SMTP id
 d9443c01a7336-28e7fdd7471mr5306875ad.2.1759328587100; Wed, 01 Oct 2025
 07:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926163114.2626257-1-seanjc@google.com> <20250926163114.2626257-2-seanjc@google.com>
 <CA+EHjTzdX8+MbsYOHAJn6Gkayfei-jE6Q_5HfZhnfwnMijmucw@mail.gmail.com>
 <diqz7bxh386h.fsf@google.com> <a4976f04-959d-48ae-9815-d192365bdcc6@linux.dev>
 <d2fa49af-112b-4de9-8c03-5f38618b1e57@redhat.com> <diqz4isl351g.fsf@google.com>
 <aNq6Hz8U0BtjlgQn@google.com> <aNshILzpjAS-bUL5@google.com>
In-Reply-To: <aNshILzpjAS-bUL5@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 1 Oct 2025 07:22:54 -0700
X-Gm-Features: AS18NWDxYGbjgzSZArzj-LO4RB9noYp5lSx-_UA5Ump9xA5S6PZGo7guXq4xoNo
Message-ID: <CAGtprH_JgWfr2wPGpJg_mY5Sxf6E0dp5r-_4aVLi96To2pugXA@mail.gmail.com>
Subject: Re: [PATCH 1/6] KVM: guest_memfd: Add DEFAULT_SHARED flag, reject
 user page faults if not set
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, David Hildenbrand <david@redhat.com>, 
	Patrick Roy <patrick.roy@linux.dev>, Fuad Tabba <tabba@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nikita Kalyazin <kalyazin@amazon.co.uk>, shivankg@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 5:15=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Oh!  This got me looking at kvm_arch_supports_gmem_mmap() and thus
> KVM_CAP_GUEST_MEMFD_MMAP.  Two things:
>
>  1. We should change KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_MEMFD_FL=
AGS so
>     that we don't need to add a capability every time a new flag comes al=
ong,
>     and so that userspace can gather all flags in a single ioctl.  If gme=
m ever
>     supports more than 32 flags, we'll need KVM_CAP_GUEST_MEMFD_FLAGS2, b=
ut
>     that's a non-issue relatively speaking.
>

Guest_memfd capabilities don't necessarily translate into flags, so ideally=
:
1) There should be two caps, KVM_CAP_GUEST_MEMFD_FLAGS and
KVM_CAP_GUEST_MEMFD_CAPS.
2) IMO they should both support namespace of 64 values at least from the ge=
t go.
3) The reservation scheme for upstream should ideally be LSB's first
for the new caps/flags.

guest_memfd will achieve multiple features in future, both upstream
and in out-of-tree versions to deploy features before they make their
way upstream. Generally the scheme followed by out-of-tree versions is
to define a custom UAPI that won't conflict with upstream UAPIs in
near future. Having a namespace of 32 values gives little space to
avoid the conflict, e.g. features like hugetlb support will have to
eat up at least 5 bits from the flags [1].

[1] https://elixir.bootlin.com/linux/v6.17/source/include/uapi/asm-generic/=
hugetlb_encode.h#L20

