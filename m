Return-Path: <linux-kernel+bounces-874947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C507DC17AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AD764F9EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66302D7DC8;
	Wed, 29 Oct 2025 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UrYDOyka"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96AE2D8388
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699389; cv=none; b=XXBhvFLXIZZ9WwFez18O5vuUksOgMX2h+Pp5jrL7xXLBPBH7cTuKWZDI5yqBtAdXaOeMKq5YhaDZX+h+ytqlG9l5pA6lD5TTYAwg0SLkb6EKmQeKHfMFR8TF7KhJENNAJXBP+KbFVUvks/omKOTLEV8Xhs4TmSBv9dk3N6FiYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699389; c=relaxed/simple;
	bh=h/EPR5R47qLSS906RL+S0spd7IC9iAe0ya9Jgl77/eI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FZTX2u8m8oxz2nHk/j2H262lif9H8HhfN3bT/S1wCwxEYfWjvCtyTUuIBi0MTBZeuKJgWNOrKHyLGap9+rSEmCmAd0LJjX+enRv/k7R9aPDqXPemQ/ha8UBC1uWgMaZlvw3RQ0Ks1v4jtDkbpH8+rJW3oQIW9ITVVlRC7SSY/z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UrYDOyka; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bcb7796d4so6319164a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761699387; x=1762304187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upoMfybmbc/1ds2YKNLV5b3LJhcfmEcs/moGK/drz3I=;
        b=UrYDOykaW8na5cogsHnKsdYb1Ja9H6S3aP0ELPKKjkjOTWtRT0Iv5gAgCxgHvshHGi
         f5Qh5ROUaleL0B5TOAhqz/Br8JYvzHkeX+XQknxmOpMssqDkdB9BANDQl5zQU24/IQ/9
         9AeXHpMXzitvTDx7NHUrEdPT9B8uYdrH42z1EoR2vl6p5zmK+Ug9urUclQ6Wj78LCJIU
         YagZn+egLimkdF5/q59L6yquVUHWEdvNYGcVLX77xKfkODIp6ZoKPNTPhLVXnk0o6S9D
         yCVr475nDAm3JzlA8Vf2cm1pkfjcPgi0p0wc9R/QKirdqMFv0YpSxZ3qi/laYyovDBS9
         eIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761699387; x=1762304187;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=upoMfybmbc/1ds2YKNLV5b3LJhcfmEcs/moGK/drz3I=;
        b=lBAzGxulEKAXff3XPPokYXUtByu5h3Hxh5zRKjZXRLSQveb0PNUPC9EEeohs7PbrGZ
         9LY26Ju0FnjNlHhj5QdcmcPi+WuNuTZ2mq4ceMlAkmTvUUUsdXSaKxYlklXEIKPqe31i
         JjBQ0UJB+JT3jXCXYfQtYmZuUiwpJcsZgu+HYfJqzfgAaUIhOYmrKhYoQT580Upfp914
         /a+0DHbXZRSRk8/nRF7gngLp9GBAuqwBV79CBUSa7ii8Wj1T1NEtf5k7sv0M8DX5/g4H
         1LKWNuh3lkofQF6zUT3abHLpVdciKhamTY3JUDHrLAVI3qfvoewc3M8hSP33APXPnn9R
         wxkg==
X-Forwarded-Encrypted: i=1; AJvYcCXXK3eYbZB00MzmhMOwM4x7fvkgK96yX3zidxQS/6cHKE/HJykN1Xf3yf2JkA6bJEZaftobFY/mav94ecU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR45dCd1nqrutOptRTZW7hCqN7VxmZzucQFqht2xKU3vsOAjbA
	O+GENcqOMLfBYUgswnNFCEIVFg59VUv6+bBXilqAVpZcXHYU9rXZk13In0vrAYyYP5IWt7XHNAz
	Komm+nQ==
X-Google-Smtp-Source: AGHT+IF+uxnoaodwmY/BiGEU5Z7mQidEmCh9G0+H4xmKLgoqPmRen8KmIjN2RVaOC05lHdTEPvjF5gcEGj4=
X-Received: from pjha4.prod.google.com ([2002:a17:90a:4804:b0:33b:cf89:6fe6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57c4:b0:33b:c995:5d92
 with SMTP id 98e67ed59e1d1-3403a2aab6dmr1121219a91.32.1761699387051; Tue, 28
 Oct 2025 17:56:27 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:56:25 -0700
In-Reply-To: <CAAYXXYyVC0Sm+1PBw=xoYNDV7aa54c_6KTGjMdwVaBAJOd8Hpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <10786082-94e0-454e-a581-7778b3a22e26@intel.com>
 <CAGtprH8AbW4P2t-wHVcTdfLwf3SJK5mxP1CbsMHTgMYEpLiWjQ@mail.gmail.com>
 <68fc2af6305be_10e210029@dwillia2-mobl4.notmuch> <CAGtprH8-UGFkh4NmuY1ETPYmg7Uk+bm24Er2PPxf8tUOSR_byQ@mail.gmail.com>
 <68fe92d8eef5f_10e210057@dwillia2-mobl4.notmuch> <CAGtprH8g5212M26HPneyaHPq8VKS=x4TU4Q4vbDZqt_gYLO=TA@mail.gmail.com>
 <68ffbfb53f8b5_10e210078@dwillia2-mobl4.notmuch> <CAGtprH-rv9T1ano+ti=3eU4FO2APCOcR06buPALggAwUnka3Dg@mail.gmail.com>
 <690026ac52509_10e2100cd@dwillia2-mobl4.notmuch> <CAAYXXYyVC0Sm+1PBw=xoYNDV7aa54c_6KTGjMdwVaBAJOd8Hpw@mail.gmail.com>
Message-ID: <aQFmOZCdw64z14cJ@google.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
From: Sean Christopherson <seanjc@google.com>
To: Erdem Aktas <erdemaktas@google.com>
Cc: dan.j.williams@intel.com, Vishal Annapurve <vannapurve@google.com>, 
	Dave Hansen <dave.hansen@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Kai Huang <kai.huang@intel.com>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, 
	"sagis@google.com" <sagis@google.com>, "paulmck@kernel.org" <paulmck@kernel.org>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025, Erdem Aktas wrote:
> On Mon, Oct 27, 2025 at 7:14=E2=80=AFPM <dan.j.williams@intel.com> wrote:
> >
> > Vishal Annapurve wrote:
> > [..]
> > > Problem 2 should be solved in the TDX module as it is the state owner
> > > and should be given a chance to ensure that nothing else can affect
> > > it's state. Kernel is just opting-in to toggle the already provided
> > > TDX module ABI. I don't think this is adding complexity to the kernel=
.
> >
> > It makes the interface hard to reason about, that is complexity.
>=20
> Could you clarify what you mean here? What interface do you need to
> reason about? TDX module has a feature as described in its spec, this
> is nothing to do with the kernel. Kernel executes the TDH.SYS.SHUTDOWN
> and if it fails, it will return the error code back to the user space.
> There is nothing here to reason about and it is not clear how it is
> adding the complexity to the kernel.

Userspace needs to reason about error codes and potential sources of those =
error
codes.  That said, I agree that having the kernel set AVOID_COMPAT_SENSITIV=
E by
default (I vote for setting it unconditionally), doesn't add meaningful
complexity; the kernel would just need to document that the update mechanis=
m can
return -EBUSY (or whatever), and why/when.

For me, that seems far less daunting/complex than attempting to document wh=
at all
can go wrong if the kernel _doesn't_ set AVOID_COMPAT_SENSITIVE.  Because I=
MO,
regardless of whether or not the kernel sets AVOID_COMPAT_SENSITIVE, the ke=
rnel
is making a decision and defining behavior, and that behavior needs to be
documented.  If AVOID_COMPAT_SENSITIVE didn't exist, then I would agree thi=
s is
purely a userspace vs. TDX-Module problem, but it does exist, and not setti=
ng the
flag defines ABI just as much as setting the flag does.

The failure mode also matters, a lot.  "Sorry dear customer, we corrupted y=
our VM"
is very, very different than "A handful of machines in our fleet haven't co=
mpleted
an (optional?) update".

> > Consider an urgent case where update is more important than the
> > consistency of ongoing builds. The kernel's job is its own self
> > consistency and security model, when that remains in tact root is
> > allowed to make informed decisions.
> >
> The whole update is initiated by the userspace, imo, it is not the
> kernel's job to decide what to do.=20

I think you and Dan are in violent agreement.  I _think_ what Dan is saying=
 that
the kernel needs to protect itself, e.g. by rejecting an update if the kern=
el knows
the system is in a bad state.  But other than that, userspace can do whatev=
er.

AFAICT, the only disagreement is whether or not to set AVOID_COMPAT_SENSITI=
VE.

> It should try to update the TDX module and return error code back to the
> userspace if it fails.

+1.  Unless there's a wrinkle I'm missing, failing with -EBUSY seems like t=
he
obvious choice.
=20
> > You might say, well add a --force option for that, and that is also
> > userspace prerogative to perform otherwise destructive operations with
> > the degrees of freedom the kernel allows.
>=20
> IMO, It is something userspace should decide, kernel's job is to
> provide the necessary interface about it.

I disagree, I don't think userspace should even get the option.  IMO, not s=
etting
AVOID_COMPAT_SENSITIVE is all kinds of crazy.

