Return-Path: <linux-kernel+bounces-853336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB6EBDB528
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4136A542950
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046023074A6;
	Tue, 14 Oct 2025 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17wu2Dm0"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46013002BD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475134; cv=none; b=SGSamyUS+wcZDzV8W/k0sHOMnCNaMxRAZDUuRbwWn82aySIuPmhSECFJsHPtDuudJFxdSJsowH6fe6fBRoWbqFdxiVga5tWC9KHgop9QjZwOHiThKTxiynRyTj7P3HMMZwizbiX8gMBM7TvKra/UWwCnGw4rxX7+5pqVlvnyUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475134; c=relaxed/simple;
	bh=2y2VUUXBzrWUhrSxeow8dfhdVIMNT5divfgzS+sA6Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQ4lbSj9XnICW5xaSFFd9dVFmx6YNZcuclRgB2krb0DhFY+cdsbXjPFAKQKCX+1uL6WrZ1gK98y6EqpESntaTO16fKdl39gJToIbnNDu2iP3vckovEDLrX2os6AVB/SAS63kzTrzQctilBLb4oNR7ClKOpRJ+7TFQ2NZiwmSKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17wu2Dm0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-634cc96ccaeso896a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760475131; x=1761079931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkpNWjeHeUKmXwkP/k1g8V+o/ZKI683L91lvalSpWwQ=;
        b=17wu2Dm0ktDmNyvTPXMHf2NekM/8nfqXOF+Ky6xT+qFUHUcJ/rAXjeMZKEd8Tt2xcZ
         MCbi1K5W3Rh+d6fgX5j18n56vg9MuRYmoIvoJb1NHaPsL23xo1D4nl+LzLlwI5+G9Pme
         yzyW0T2TmKtrf8anqnJMEMAKwb4SUNi3IeZO6P7TlVdcbVUJ/sZRLZ6j5Rx2L4GJwjB5
         o9b3xzzyZosuCZWScD25QFCE4P5MRLq6yO2muBctFtpQ/uStD9OS/UvfWn/B/9TwSNee
         hgn7DPQ1jtPn/i3voJhMENng5oN6VNCBN02wnU25okIiO/CWuav7nlOH3m5kv3Oc0T1k
         0Rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760475131; x=1761079931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkpNWjeHeUKmXwkP/k1g8V+o/ZKI683L91lvalSpWwQ=;
        b=VO2uJaDazKCkCMJ08ty7PuOpxRR2KuwCw10bWZL40HSbsR6mHBmMZfU+sEF9l6XGFE
         DsCt6stEA0a4d0rCI1JvtAsfKsOzWt9iA8Y36Jj9BPhesOdfBQz0X9+1vlA9sDR1brtp
         kTXERQZdZdJPhrEQo2GZIfLIH8pCXyi39UthdEMUaaawvIKeGKDcdXCm1QRHJNCm2jan
         s2a7GjTkFsBGcbjbB7tkkrCGOIpfRGjMHiCqmjC34lgw1yo3XrXPfby37qxzXoTMZ0ye
         yCwskfz75/m1xU/T+l9ZzvfrcEL+RQ5tgYKCDNIbaTyJim1petTmwuDDfB9P5AStuS+U
         3B2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkCgFHkY5XEBAlSDr+PSU+7b6Mojkx1p9TevWmk8qe5Jh9F0uZZSVpeR1TK6ygyMIutNs72T9u7q7CwT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJcz9HvgdZFtJVTO69Wz3szNi4SrMR6RFnxVPtM//rs9l+uB4x
	YvvcWSF+QUAjBfoxJakxX9bmYozx2y2caKlbJxzIZErnRsiMW2NL6QTBJaw++BSp97RtLmaJ+1Y
	IQ2ok6J/IJu06CYQbHf89zb1wpBhtdT+rD9iMOSgm
X-Gm-Gg: ASbGncv+zq2Kjmfl1E/y5MUUF6vWvMCstKZqHQvgzZbYgEHXpzjVPoofA4FDF3PRqY0
	pL+iUIoEi/ghqJviRHOxpfNVUsksamOZrr99iCKE/mPC1cVoZ8HH/wqXhP6nY4W4DD8b4SmeZB8
	zE452liJ+983hUV/gNubHG+KnoJtm1O/6PBv2xLATBBfvDLARyRycbStFTyF4SWZxbokAwR1uyw
	x0170vYYZ+trcPiOexKCZxOumj3Is19MTzS+JIs13g=
X-Google-Smtp-Source: AGHT+IHvxL2Mvf5IVNrP/h/HUJMtKEtZioduXdJNcyzh+TN6t/aWcz5UKNStWO4xjS2PPNhZh9xP4lHGD+RynpjkF6Y=
X-Received: by 2002:aa7:d985:0:b0:633:2321:a07b with SMTP id
 4fb4d7f45d1cf-63bebf289ebmr14121a12.0.1760475130800; Tue, 14 Oct 2025
 13:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009223153.3344555-1-jmattson@google.com> <20251009223153.3344555-3-jmattson@google.com>
 <aO1-IV-R6XX7RIlv@google.com>
In-Reply-To: <aO1-IV-R6XX7RIlv@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 14 Oct 2025 13:51:59 -0700
X-Gm-Features: AS18NWCKNwJTtS4L7CZFU0VIevqNSQ12HleYA0I33OqRjy-_SS3O9lbh6Ug1GrI
Message-ID: <CALMp9eRQZuDy8-H3b8tbdZVQSznUK9=yhuBV9vBFAQz3UP+iRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: SVM: Don't set GIF when clearing EFER.SVME
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:33=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Oct 09, 2025, Jim Mattson wrote:
> > Clearing EFER.SVME is not architected to set GIF.
>
> But it's also not architected to leave GIF set when the guest is running,=
 which
> was the basic gist of the Fixes commit.  I suspect that forcing GIF=3D1 w=
as
> intentional, e.g. so that the guest doesn't end up with GIF=3D0 after stu=
ffing the
> vCPU into SMM mode, which might actually be invalid.
>
> I think what we actually want is to to set GIF when force-leaving nested.=
  The
> only path where it's not obvious that's "safe" is toggling SMM in
> kvm_vcpu_ioctl_x86_set_vcpu_events().  In every other path, setting GIF i=
s either
> correct/desirable, or irrelevant because the caller immediately and uncon=
ditionally
> sets/clears GIF.
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index a6443feab252..3392c7e22cae 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1367,6 +1367,8 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
>                 nested_svm_uninit_mmu_context(vcpu);
>                 vmcb_mark_all_dirty(svm->vmcb);
>
> +               svm_set_gif(svm, true);
> +
>                 if (kvm_apicv_activated(vcpu->kvm))
>                         kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
>         }
>

This seems dangerously close to KVM making up "hardware" behavior, but
I'm okay with that if you are.

