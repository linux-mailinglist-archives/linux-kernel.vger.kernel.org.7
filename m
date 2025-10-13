Return-Path: <linux-kernel+bounces-851214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC84BD5CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B28818A73C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052602D8DC3;
	Mon, 13 Oct 2025 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1WO8Xxs"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7E42D8383
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381573; cv=none; b=n2/zXAmypy3tK/0NtJh3ZcgYHnkCzITRLygKtRnGCz7/8+Vkry2ezhwUFx1/pHNk5tfQmC3JsoXKiQ3Cv+SzP8PNCh0vmHqcSxHKyG9ZHsZD3E3gpfZJZy+cdpJGeETIE19JNgsEaCMqifSECJ3AMIkOwL4zUcubKVnEiciheHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381573; c=relaxed/simple;
	bh=iUk2UdMf7pERxk6w7Llo5j8YKBarUI/BPofhsYl7ZmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cn3okg/YJzhL6wRYu51pYV2lN0+pQ8tVVe95auZe8U2mc1YIK06xjb+Szgf0jQol8MuFu9G/TjxHcicbd2EJ5jZeOaHPT1UJUiVOa9TMCPaV9sTSmoYT86weSnrdZANp72Av7miXVlcPn1OZ8SVQ0b9hx5qrZjbI3beJoXIY3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1WO8Xxs; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so22536a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760381570; x=1760986370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Re5H/O2EjTXsidOVadl49AyAMlZCly7+yKfYOFvGPQ=;
        b=V1WO8XxsZJPuxZ78p+SN+1Wed5ojmiHoH5AlMg6daAd6yHFkJdM1V30IN3jMjlRIM1
         D/GHVy4A1ColStG3Wqx44to7zQELLiV9t1EZBoXxJiBOSPzNBy59rDB5PGbBOGCkIPGE
         RWCZGEubj7uYuD+o9Itjeb0fda/jk24Wt2NUofBrobVbo4Ns8UFqT+Os+lPqeflgKCVU
         0gieyu7vNvuAa2R+y4G2K2xmy0jbzI4rqJBF7OYQvaOGGTj2NwgQKtwi12kwK+MH7IFk
         ealopVV1o4A72XkwFYnYCSPL4dT9sPajjy3hKN8/5ELBA9lIKYewZUUXPeLT0TCNXzmQ
         fCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760381570; x=1760986370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Re5H/O2EjTXsidOVadl49AyAMlZCly7+yKfYOFvGPQ=;
        b=J/TGVZtZ3xy9sMcJKOX3y7GV3ArsiPheMHkOg2HDAV3LXddAejqRFTU7JJf7hb8yHB
         uUbAScXh5jHb4tXo4JD2SZRfR6JXv1U7eqayg7FHE6XEM0J4MLIiYHUf8NFMCJHPeQox
         bn8yxWlPoBtymqRZkHVSeT8b4aaUMSGiYNnPyOnsrm1FKqwO7H2mnu7bVdV5n9ftnfSl
         6pgmh43nfuIw15UgFEVW9VYWS9sPznPkK4QB8G2qRKFDgLsoq0V+XHruIp1XHrmV2vib
         S71Alc5DM8z8rR12iXvM2frBkfC8kXwvljbT8vNsu76uQSi9eMLoH2wH5wkmALKQT/OC
         DYcw==
X-Forwarded-Encrypted: i=1; AJvYcCVVOEgImEGXoAMaKSJC3EjGo9OJpZ0QXN6FtME/PRJdSXbTT968Np3N1kzDI6bWdO/pqfjWrKCdDAwtqMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA2NBnC8h/wKmWMJsmHFPEgorOjw00E21ADiijsn7ejiH/ETzG
	YovTOPc8r1rJfn/o4s6+kfgST+ohDz9Bx5p4ZWgGWUfQju+do63jjrvBb+4UVMelogtpQretG6B
	9Hy8+yKXXM3fHKmvGeBpGBYGiPV3E4j+FvOezPor5
X-Gm-Gg: ASbGncvngFoE7x9Te+fX2l3NjrusBs8V5SjP8QCWF1HPq4iJ3ffIR6s8a+MccGa+w+N
	bnL7cJu+jdj34g5YT2Ar6CD8GWWo5pr8Lvs4QrlP/yANRpcJGADPt1Ux/ARjuz82gdPqm07dPeG
	Qdu2V/zEZdEq+mkwKq3GhBMBbO3+Qoz4Hd8tJczxe9l48qdR6Xa8QN49H67YboFWRSzfmq1JiCd
	gFcAs39+oWcoEMKcWqMQj1hHoJtEBy4
X-Google-Smtp-Source: AGHT+IGjMm2akrmfnLsDJ0iB6NildCG1lCop2Q8XTbJJNu9nQzttFSJPMYZduDDnWEIei4uujvTHcEVhI6nPtTT49gw=
X-Received: by 2002:aa7:d889:0:b0:634:90ba:2361 with SMTP id
 4fb4d7f45d1cf-639d52e9f0emr630105a12.7.1760381569759; Mon, 13 Oct 2025
 11:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001145816.1414855-1-yosry.ahmed@linux.dev> <20251001145816.1414855-11-yosry.ahmed@linux.dev>
In-Reply-To: <20251001145816.1414855-11-yosry.ahmed@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 13 Oct 2025 11:52:36 -0700
X-Gm-Features: AS18NWDzaWCEhjI7Qfv6rqXIYOx0uL1PdtbeaJ4kWvwOyK8bYylvN6PL8Eg-vc4
Message-ID: <CALMp9eQ-KnS-nEGFOvTjNJNOiayumQSiScHixCpPa23pnVBq8w@mail.gmail.com>
Subject: Re: [PATCH 10/12] KVM: selftests: Move EPT-specific init outside nested_create_pte()
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:06=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> From: Yosry Ahmed <yosryahmed@google.com>
>
> Refactor the EPT specific initialization into nested_ept_create_pte(),
> in preparation for making nested_create_pte() NPT-friendly.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  tools/testing/selftests/kvm/lib/x86/vmx.c | 71 ++++++++++++++---------
>  1 file changed, 43 insertions(+), 28 deletions(-)
>
> ...
> +
> +       /*
> +        * For now mark these as accessed and dirty because the only
> +        * testcase we have needs that.  Can be reconsidered later.
> +        */
> +       epte->accessed =3D *leaf;
> +       epte->dirty =3D *leaf;

Not your change, but it seems strange to set the 'accessed' bit only
at the leaf. The CPU will set the 'accessed' bits from the PGD down as
it does the walk. So, to only have an accessed bit set on the leaf
requires the existence of some software agent to clear the higher
levels.

Reviewed-by: Jim Mattson <jmattson@google.com>

