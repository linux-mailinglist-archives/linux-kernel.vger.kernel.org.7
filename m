Return-Path: <linux-kernel+bounces-872866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 878EEC12728
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D389D5073C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA73B284890;
	Tue, 28 Oct 2025 00:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y721SBMr"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16E213E89
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612805; cv=none; b=k+rcnU7ALgB7w8vtUXouOBz3YrmWssWxyc4fWeOdz7R5fTngFRJffKMHEjBPLsmU3UTdUM4Zu5oA/sskwTZ3CHjn47PW4eIUpJtbsK6XqWKHfjT7tqJT0fL3UBHGoPRmN3pC1zETVcAL/JUfnoJpi3fnlv17iTs7rLL4dAGgL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612805; c=relaxed/simple;
	bh=4cNoaCHzEIXXX6xk48r/fdOgWstgghbGcJ+Uh2Rack8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOxSrTg9PvwNuKqKMiyi21TF5cKymf69luyPPWSaOmD804F25OaHV8ERmJrDkOUpYOB2JJdsr2h/U8T05LGklP9dHiWXOf5MYIrhT2KivsjV3iKspIPYpTOn2k+diqPe9dYlRkh2La3I2ebhkPNB70O/8MnnOhSIx3FsKc8/WlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y721SBMr; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4eccff716f4so151991cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761612801; x=1762217601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJCzECofJKvnJPuZipIbzwFt9dZuYtL7L7v6udTFcYQ=;
        b=y721SBMrGPeRfrBtY6u+SOmiX8J/bxDYOc2vN4POw591ibNSAstKdBLU7K9v/oBRa5
         +cDGwJSsd7SXAaNv+3OSvJnWiuiwAnCd0QvYOV0YlEPTYc8u9TOlviM2zppVFXM3azzS
         b0zZpA+hvCC4617HHd0k1QuDMBBxP+FYZfVrUPn7C97RXuamDSxS3gLrzTnDBcttJmBt
         RfSox0mtwiysW9q1Tdx0VyjnSbZniUtCV5qiw7IS+xg1+8gSSnR7H824QXRRbPk5RC0P
         OCjmCwaRPkUzYTiNn/9a/jPj2uIx8E5EhtXIEQcBAckCPbmjyHhxKuGu8jf56VmOm3jF
         MaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761612801; x=1762217601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJCzECofJKvnJPuZipIbzwFt9dZuYtL7L7v6udTFcYQ=;
        b=lRB/kxyVikXuNTLcGHwqbqMykKo1jaqPARnGu8cNg/rT9ji1dUp6nobvWkQGQxVX0s
         zAZ+8AUOc6qWvhXnY+B1MInP9FUuYBNY5uPBZWERfgANPyBXDm9ZLsqkLjU9efuhMScP
         GaLvV8IMIXBYG9QjH1v6D3JLD296tVKhnWMXkm+bjqwY1UUAtE9KNlQBCbHvAKVSkD+Z
         dxotqeQnX0uNUp6M0HHjmDDEjsbqzzieRjj07pqAut2YjmHzEbtgC+o9yvJgU1Qhp5WV
         QhxJXKUc0gguWk90dpG4zjShO/cKGM/TZkPZkRZwC629uRqneLelaNpqZxrMAjDSrkw/
         33ag==
X-Forwarded-Encrypted: i=1; AJvYcCWm3d0sUvP0qa5D0Lf10EvqMngkrvFqwJiE0U/1gcjUX5QOiS3Q9ANwk3+dDkjRQxoWbu7MBCPkexJCrvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGZbUD5CR+U/8zqeP79mM/DoanmMrR9dr1uHdaeiHTzfXdbZp1
	EBOkMrhxGvm1MM8NosljtAYyyerXd73TKuIVuWTAqIa0fE+cG8vGu0Uk9deq/iz2yswseFVXyAk
	QwJJu54v5I5FzdDQstOVcMiGRSNk+wCZ/RA+LU0WE
X-Gm-Gg: ASbGncuPkDScAMqKct2n08/mC4xAq9FlIFPadt+Yvb/VuqcxqgFoMc2aAng9RECw1iy
	DpukCMOyHfoyMxOasFFqe91ZMRJlk7lOTfmyeXuU0w5GbRlHkSZZbXyk6T8qWCnP8k2zl19MlgZ
	LydZ8Erzc0GyBP/8BSbcAjx5kp0Mk86EYzE1P/tpBfMfXK3dpkZGiK9xV4+rfAhnR3dxlc1ZPdo
	b7UkRCHjqcr+dHzioIvUfgw0sCBGiOE++A6gFCOQUx05Qo19EA03C/SfSkr86z1zije6ki5+kpl
	BFdr/u8cD5wmSipqftXAFQU1hT0A
X-Google-Smtp-Source: AGHT+IFUa6cbmVeGtvDptFMbgioO6afUPchhlusFkMBjA1ySA48BX0gjJrkRqKv7ZzUc5bXX4Ce1xRj5gu1FMlPg1oI=
X-Received: by 2002:a05:622a:54d:b0:4b7:9617:4b51 with SMTP id
 d75a77b69052e-4ed09f6d3bdmr1722601cf.15.1761612801462; Mon, 27 Oct 2025
 17:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925172851.606193-1-sagis@google.com> <20250925172851.606193-22-sagis@google.com>
 <aPum5qJjFH49YVyy@google.com> <68fff9328b74_1ffdeb100d8@iweiny-mobl.notmuch> <aQADUmrDSRAydBhI@google.com>
In-Reply-To: <aQADUmrDSRAydBhI@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Mon, 27 Oct 2025 19:53:09 -0500
X-Gm-Features: AWmQ_blpq8uWAYgHCheNYVNyGFnS8Ty-_u58qPRtAcnmw4uJ0sM5wXqbEirKh4w
Message-ID: <CAAhR5DGAOsv-SiLkCziazy4Q9qG_iNqn5Zb9ik+KQ63KDzJsAA@mail.gmail.com>
Subject: Re: [PATCH v11 21/21] KVM: selftests: Add TDX lifecycle test
To: Sean Christopherson <seanjc@google.com>
Cc: Ira Weiny <ira.weiny@intel.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 6:42=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Oct 27, 2025, Ira Weiny wrote:
> > Sean Christopherson wrote:
> > > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/t=
esting/selftests/kvm/include/kvm_util.h
> > > index af52cd938b50..af0b53987c06 100644
> > > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > > @@ -210,6 +210,20 @@ kvm_static_assert(sizeof(struct vm_shape) =3D=3D=
 sizeof(uint64_t));
> > >     shape;                                  \
> > >  })
> > >
> > > +#define __VM_TYPE(__mode, __type)          \
> > > +({                                         \
> > > +   struct vm_shape shape =3D {               \
> > > +           .mode =3D (__mode),               \
> > > +           .type =3D (__type)                \
> > > +   };                                      \
> > > +                                           \
> > > +   shape;                                  \
> > > +})
> > > +
> > > +#define VM_TYPE(__type)                            \
> > > +   __VM_TYPE(VM_MODE_DEFAULT, __type)
> >
> > We already have VM_SHAPE()?  Why do we need this as well?
>
> VM_SHAPE() takes the "mode", and assumes a default type.  The alternative=
 would
> be something like __VM_SHAPE(__type, __mode), but that's annoying, especi=
ally on
> x86 which only has one mode.
>
> And __VM_SHAPE(__type) + ____VM_SHAPE(__type, __mode) feels even more wei=
rd.
>
> I'm definitely open to more ideas, VM_TYPE() isn't great either, just the=
 least
> awful option I came up with.
>
> > >  #if defined(__aarch64__)
> > >
> > >  extern enum vm_guest_mode vm_mode_default;
> > > diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/to=
ols/testing/selftests/kvm/include/x86/processor.h
> > > index 51cd84b9ca66..dd21e11e1908 100644
> > > --- a/tools/testing/selftests/kvm/include/x86/processor.h
> > > +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> > > @@ -362,6 +362,10 @@ static inline unsigned int x86_model(unsigned in=
t eax)
> > >     return ((eax >> 12) & 0xf0) | ((eax >> 4) & 0x0f);
> > >  }
> > >
> > > +#define VM_SHAPE_SEV               VM_TYPE(KVM_X86_SEV_VM)
> > > +#define VM_SHAPE_SEV_ES            VM_TYPE(KVM_X86_SEV_ES_VM)
> > > +#define VM_SHAPE_SNP               VM_TYPE(KVM_X86_SNP_VM)
> >
> > FWIW I think the SEV bits should be pulled apart from the TDX bits and =
the
> > TDX bits squashed back into this series with the SEV as a per-cursor pa=
tch.
>
> Ya, that's my intent, "officially" post and land this SEV+ change, then h=
ave the
> TDX series build on top.  Or did you mean something else?

I've got v12 mostly ready to be sent for review. I was thinking of
incorporating this change as part of that series. Do you prefer that I
wait until this patch lands before I post v12?

