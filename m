Return-Path: <linux-kernel+bounces-759496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF5B1DE36
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048BE18A2085
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8FA239567;
	Thu,  7 Aug 2025 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lod1zMqF"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34221765E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754598012; cv=none; b=JkfuVmijsJ2oMRPYgdTNwsxcImIXWk6rTj0PY3e6e+FyLH11j/OtQFfqBKdjEIIgNaFnnwVjMaFvAaP0GfW1XHLZtffCCCTudjVWhUqxyNm8DJtnuakQGHVbblgFO0RL0jI6qTYc7ccVLtLcVOFAIGBIo6Ts/trBpkyMTikhUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754598012; c=relaxed/simple;
	bh=y4Je+uCw4PjgwpynM6o+m6QzQjMA4HULEA4ADOsYgv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlUU8AV0oEti4K8Zd9JV9g8JoXxYCdY0CiSQONxFt2FAHaMAq3gZQbauf1tyreArBMy2tvpz0IoJby1tM6no4AwGR3DN35WE57g07taXZf6hm/0fUR7y7n7t3MyYBAoEHCQzpuIb9qFs1XVRKncyrWaligb3L0/Mq02GLj+fKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lod1zMqF; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso21051cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754598009; x=1755202809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1njzRZRI0yuxaZu+3pXAmpwVjNQUojJP+cqDBoYOMo=;
        b=Lod1zMqFzSWd87CGcbdII1lg9ADrYScbc75jb/7JkBD48vhAnYfHr9F2DfNQRwmfkB
         wJOdQuNmMA3Jhiu+3LUBV6ALmSCAHA7Tgcc3HcxTmPNn+RLp8dr+nD1lwzpHfULWjvSJ
         JwlxqW9pv/tKaNrCOBrQel376iV6+9gKR2QATq/N5c1fH5nis4EHFZ+2genjhPfrF25N
         QZ1kC1W8WI/fa5FRfEis5Wd2kb8/G2b8MYiKBQZfS0Kn8ssZY3fqr/shLxgfaTcGSzNh
         DomqELjt1RsZpY74IFPKXpTVh+gT6guQH4qpKWmzyRK8b0/NiY2WEiSZadksoxin4pRM
         D2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754598009; x=1755202809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1njzRZRI0yuxaZu+3pXAmpwVjNQUojJP+cqDBoYOMo=;
        b=IQ0/0dSU3nPMYVu7cZdqzZXUh+XcCEJdHJH5uIy9eRYdvRwd7H7cmCKEcPEMEQxO/F
         YO8WM7bUki2W3WKoxU7jyDFanmlsU/3J4rlXi3/7JRpkjeID3Nb1Ec/k6OlDce5hAyph
         TVuEgnxwv/GFAGnNnVwSO+DQd8JJTYHt/PCIpzLoxtCGH5HEvaknc7+2qex/+YfhuiAS
         XsFicrI/aDEK9Jx2d+U/DMRW8+zFBZxEQrPL5eF6PyzOs8vZNQiYSv1SQkOabIeFGW3M
         6FHGD9Licp8t1qCh9aOtsR318cs2nrWVa0qAlg+aniLaUAS/GVEZISogmOBXpm+LG8oU
         xNXA==
X-Forwarded-Encrypted: i=1; AJvYcCXifrwRHM3IAT5xRvcayGSNFjVFsLYeloNc6vFNRp2K21vZ28QB20JrZT0Mk/8VFPuQQ5t2JH+bzFsy4vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQJUB8BHjl/LL08TWJkyXkgLNgi/+YuqAERy+C6ivtFB7fQQQ
	tRu2tBEuFxxXGGTh2CwTeInQ4b/LnK6kqxHzrpuSQg6yhbrrCee2RXk8RuS99x+kBcDmtPqFfLJ
	irPH/Hjr91Apn3x9pZRCXBeTdD3X09uofkZfVKjDp
X-Gm-Gg: ASbGnctmLMmR+aLkn7mKNk3xU5RuhQQPv/26n/eFoqgTWpNfLMT4dtm/uvwKLVjJDtX
	TatI0x/pRKxCOgt8X7GugwEv7ZsHPyXkkJXt6f6Q8FBeJ1CzPkDg/uSQoI99iskR4U+Wu79I43w
	8YlvJwoGgZ0s9jtwUqcrrOYkLJQs6HdOE3TgQMUZbQrLL6nS6JjW8JQ4/WHtgWrsv19594Fkr6z
	qIYLEFL5H4OkCtPHRwk0W7FcEagLhMmbpzOpqIb
X-Google-Smtp-Source: AGHT+IG5ycJ5Q52QFJSqxl/YemOAi2b5Lxu6OTbgyP5z84bzVWLUjQSVs1bZvuqtq7Om/J7u6tqoa91cHop/0QJeevI=
X-Received: by 2002:ac8:5d10:0:b0:4a9:e17a:6287 with SMTP id
 d75a77b69052e-4b0af24d8c7mr863411cf.7.1754598008591; Thu, 07 Aug 2025
 13:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com> <20250613191359.35078-6-sagis@google.com>
 <aH62f9X25LHuUx8n@iweiny-mobl> <CAAhR5DEQ9QWfdzO1yCuFzYjju+Q=pDGbcYyRWFmA_6tc8A4LNA@mail.gmail.com>
 <68922612d9712_1923952949e@iweiny-mobl.notmuch>
In-Reply-To: <68922612d9712_1923952949e@iweiny-mobl.notmuch>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 7 Aug 2025 15:19:56 -0500
X-Gm-Features: Ac12FXx0v8U4YOXtP8smuLJE-WItrOpjqXG-rvcfjA7uQFOCAuFZGv2_OLJKm3M
Message-ID: <CAAhR5DGLnEdWzQEEuQcH202BT_GiqU-aQWM9Zcnh0QF=YSjmWQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/30] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:39=E2=80=AFAM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Sagi Shahar wrote:
> > On Mon, Jul 21, 2025 at 4:51=E2=80=AFPM Ira Weiny <ira.weiny@intel.com>=
 wrote:
> > >
> > > On Fri, Jun 13, 2025 at 12:13:32PM -0700, Sagi Shahar wrote:
> > > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > > >
> > >
> > > [snip]
> > >
> > > >
> > > > diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tool=
s/testing/selftests/kvm/lib/x86/processor.c
> > > > index d082d429e127..d9f4ecd6ffbc 100644
> > > > --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> > > > +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> > > > @@ -1166,10 +1166,19 @@ void kvm_get_cpu_address_width(unsigned int=
 *pa_bits, unsigned int *va_bits)
> > > >
> > > >  void kvm_init_vm_address_properties(struct kvm_vm *vm)
> > > >  {
> > > > +     uint32_t gpa_bits =3D kvm_cpu_property(X86_PROPERTY_GUEST_MAX=
_PHY_ADDR)
> > >
> > > This fails to compile.
> >
> > Looks like it's a simple case of missing semicolon at the end of the
> > line, it builds fine if you add it.
>
> Yea.
>
> > I can update it in the next
> > version.
>
> When do you expect this to be updated?

I just sent out v8 of the patches.
>
> It would be nice to see this land soon such that we don't have to keep
> carrying these patches out of tree.
>
> Would it help if I review this series?  I thought it was relatively well
> reviewed.  But given the above simple mistake perhaps it needs more
> review?

If you can review v8 that would be great.
>
> Ira

