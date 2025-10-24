Return-Path: <linux-kernel+bounces-869555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA562C08272
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B25B4F32E5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30F82FF15F;
	Fri, 24 Oct 2025 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1tKvA0V1"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012932DAFA9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761340214; cv=none; b=g9F9iLXNTQUG9RSuh8hn5eAPkpMD08/lm156B1IItRG+AgwRL33CHWwmQf9Rrxs3uhjr0wxYc9uoSc+l1e+P+rmf7evoPZ3eeVrqNeK/VJf9SwDK5b5oavGcxDOCi5IoHMIh6yMsu2RJtc4338SVu4UWcfZ22aU2i1rn2otBDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761340214; c=relaxed/simple;
	bh=MkPNZSVcczdDm5QChyJYpThY9IObx1aM+jpgig1Em2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fG9NDiYchWEoKrXzUgIAobuW8cvAxAilST076Lido5zTNDU54XFU4RjhejG409wDLmi8dRKEJx0f+NqPVr6are/9679PC7s37MES8pJBCrml64+ycewwwYUsN0zT5l5g0qVDSO2w6vpqx/AsdQCJqcOFbCAGxYcbdFG60fipsfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1tKvA0V1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-290d48e9f1fso19765ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761340211; x=1761945011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5pDOCKMDd3GFfsZrIh/QVw1AdHwvEGb4atyHZgHAUg=;
        b=1tKvA0V1ZCCcPGpWr6IRXAmDUz4BtTz30yJ/0HSFQHz83MC6zDberSnZYOaR9efcBc
         PL1Z5GTjfgfGfoh3xkLbAIzxO4GOMffvf1QWt2SjvDTkXIY7u0CCaWSKG03qc/V8oeGN
         nrmKFIrLblhtP2dMYIzKR63VmgDwfN3WlnFge8FFypkVZ0BgOvuoc6cJ3YLD+W4jRLta
         F13qAxYRk+drOnRrtmiBEaB2OK0hQuykHjtInVBpY6wnkQ+l1p73RXHCIZfuSYWEFvXf
         z5wuQjWUexdPRGs9gm2Ib9xJQjNsYOhsqq2VrvT0GmR9r0eDXenAUrZw75+BBf5p+fP3
         a3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761340211; x=1761945011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5pDOCKMDd3GFfsZrIh/QVw1AdHwvEGb4atyHZgHAUg=;
        b=aMfyN20bqMoXmxi7W/wWFgE29W965u7e0Mt30Z3TEfY0zoSkiz6w/PFs/bFdka33Jz
         INMU799gPh+IOs7opY6CSjseqh449ZM7le2VN0xSEagAP5jusKF6qWvHvaOhlGlFEQNv
         +DIv9scA5tkV+ko1ekTFAMZaArEE4UsoP4lCBEjPGlOwz8V4X3MjXL84MP+ygyCj+Plh
         qsWce6kjlo7QLz2EuotJy+yQaKCdbT7pD/iAMQH31b+j1Eva+BW09EM1jQxrpdbFr0gf
         0Eej27fyxfbl5XHYP0fhWUeFE6x8rKy4O6mhpxqDxERPZdPmXtKJHL3Z726dz+gsDNOx
         OuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvqLaKRgDNQDPizbIsrYf7p/X+q+Dz32AdD3OPu2j6X9cX0KTbbEqae+OiDvc5daRpOdihO634S4nBIBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HipwfJ2lUrELImESBMQpvlP14VzZGvuTjAcYF5+LFfvQoGbx
	K7GIiHzR+Sk5HcXr9F7y0lnCYAyfmUXLwKUxKk65NQouCreLHXnQRsMjSPGlr0ZPOQQzkNGqrPU
	ZEiVv5h4kH5Xv1fWWe2yJr3vmpATy6jEFsmaPs9zR
X-Gm-Gg: ASbGnctLAIrItZip+kiDQvLZ1r9sjjBU0G2VvX+TeH0wSL8PADlFQTHZ04sKJVCwzQy
	zVjdor0NTK/Oll6g1opL+5EAPsCsxs8hwhrwhmKOenfj8NaI9FuGxM97VvIyfa/V3U+Yd/5jfE+
	IvjBWLK8BIha6QEOVOnmUCjZlZklyOnu99MdIP70eucRVCCFhAFs3hlNq+nzMHvKqIt81GG3VSt
	yf2DW7cW9Rz9QbYXZFY4R20HVM9P//CezeJMlk0MePKZMoZpDlPJGc4TP4o0AQXlNHx/yAExfcl
	eClzi1zhgXdxyU29
X-Google-Smtp-Source: AGHT+IEDjl/7fM32vSIXahj0F5uau7/hDxLy7ltSrI+XEIC5qTttx1nPzoAjguvgNspZszxbZB4PdvHaYl8ioxX9cTI=
X-Received: by 2002:a17:902:e5d1:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-2949775c38fmr1620415ad.0.1761340210605; Fri, 24 Oct 2025
 14:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
 <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
 <aPiEakpcADuQHqQ3@intel.com> <CAGtprH8q5U6h3p5iDYtwRiyVG_xF8hDwq6G34hLt-jhe+MRNaA@mail.gmail.com>
 <CAGtprH9bLpQQ_2UOOShd15hPwMqwW+gwo1TzczLbwGdNkcJHhg@mail.gmail.com>
 <aad8ae43-a7bd-42b2-9452-2bdee82bf0d8@intel.com> <aPsuD2fbYwCccgNi@intel.com>
 <ca688bca-df3f-4d82-97e7-20fc26f7d69e@intel.com> <68fbd63450c7c_10e910021@dwillia2-mobl4.notmuch>
 <aPvaw6NgPBq1paUh@google.com> <45c85e40-d049-4242-a251-d541e60d6e7d@intel.com>
In-Reply-To: <45c85e40-d049-4242-a251-d541e60d6e7d@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 24 Oct 2025 14:09:57 -0700
X-Gm-Features: AS18NWAjL7ozhAES4jGQUd19RUjxWASLIdpez7IMyB9H8APKVbQlFdZmtqC0Dt0
Message-ID: <CAGtprH_1CRxEUoJnU7KVrJK_Sgtq_jngxC0yRX3gVNguocZ9zg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, dan.j.williams@intel.com, 
	Chao Gao <chao.gao@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Kai Huang <kai.huang@intel.com>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, 
	"sagis@google.com" <sagis@google.com>, "paulmck@kernel.org" <paulmck@kernel.org>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 1:14=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 10/24/25 13:00, Sean Christopherson wrote:
> > C'mon people (especially the Google folks), this is the ***exact***
> > same problem as certificate updates for SNP[1].  Y'all suggested
> > holding a lock across a userspace exit back then, and Dan's analysis
> > confirms my reaction from back then that "Holding a lock across an
> > exit to userspace seems wildly unsafe."[2]
> >
> > In the end, it took more time to understand the problem then to
> > sketch out and test a solution[3].
> >
> > Unless this somehow puts the host (kernel) at risk, this is a
> > userspace problem.
>
> If there's an similar SEV-SNP problem and accepted solution punted to
> userspace that TDX can leverage, I'm 100% on board with that. Let's do th=
at.

So IIUC, the current stance is that the kernel can rely on userspace
to ensure forward progress of TDX module update.

I still vote for the "Avoid updates during update sensitive times"
approach to be enabled in the host kernel to ensure userspace can't
mess up the TDX module state.

