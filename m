Return-Path: <linux-kernel+bounces-770197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FE8B2785B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACCEAA570F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10312594BE;
	Fri, 15 Aug 2025 05:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+nKScj5"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA282236F7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235253; cv=none; b=RtT+tTwbjxcJdryVQ+PRcbzQgp7hO06d6Q+zhtbCayt0vOywkZ6AgL4EPqyf5j82DV2Z2QZEkMHYYht/x4QDo0/GDVN412PX83bqHseSHIP0qjxs80pzyDlYEhkAzLE9Q2yRgmeh594NIQhn3xFX6TAcUfglIuNQymweyxfuWdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235253; c=relaxed/simple;
	bh=503SEWrEiwk4AHvc6H88byJ1joeM0iL9UAQxQ+98CZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jum6w6OEkJ4fX8c5sQHrPG4GlabxEPUtqorUS/PZSoYoadx4e736CLqA1OPIfffvVqfABV5OXTT1CcG7dwzgT3uk7z6ntXAz/0ur9f6YkRjU6naF5RlozgsZ3e+l6u8t5AfkK+3K/AkbupKPMvF6NN+m+QlRjo/cdpWrpbCayrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+nKScj5; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b0bf04716aso131361cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755235250; x=1755840050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN6cY1WnXIWqH8qfrJcmPCahJeWVJ2HfC4QiO+3/8v4=;
        b=s+nKScj5LJZNrEVsvXbbuHos36kQy2ps7WusTDOaXxn92quN7YN6BxcS2nh0Y9Xqiw
         OH8tWGVIDomjG/N+3a3fQPLqYVsY8QRxhtm7sGU2kCa5yus0Fq/v3O4+T9ooCjnlGoTu
         /xivnXirwdsrh86wweNJld2EkkPQ8eYTKg3xtXxz5aJgpewD1fL3JJIJ9seXGEQy6BD4
         M70ndyzTvL35FfDo5BuQaQhO66orfqi3hjSwHbzkHBFRNthxSGOC0KHKRrI2PepT0N6s
         Xj8VSjEe5HUA+CK360xBhE6lZbl2mAABDBqqYrOacFs1121bFiRUq7yqD1b7TbnGVt+1
         s9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235250; x=1755840050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nN6cY1WnXIWqH8qfrJcmPCahJeWVJ2HfC4QiO+3/8v4=;
        b=EXEjjNIRqvrIBi3i9TzD8aBkZIZFV/0UZ5JI05/7iOzWii0EWwr7KsuUtpp+5HPWpq
         pe69lVhDejo7CXPHP0aoz3mv6wvmbL4LGcz4+/h/DhApkLKWrWRU8HPOlk1XrEsqfFdP
         PZrTHRT6rwYO+Yp9wbuL2nGlBJIyVEGY/A3chzDJGYEBx/ECdDji72jsU/6c9fGxZWeg
         jQb0Qjv9kqOfblAomNmZMAAQV7T4x31yNOaqpQtvpXhfcBeUNHcVIsPFR73Y7ksWSnGv
         GId2DD2KCHpRWlSekGxPQz/rtU5B/NpKlY7ohNUFXMUttMTScnlkqhlWUmoOZL2MNJba
         Ij+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkxNZTt55M9DYXgJu6gar5scY8I9Us2f6EDxMJ4d3aUPWm6o0gUNWJb/hewlQ2ug8Xt6drGOCA2q7+ETw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOBWQ3r5xitKmzAQgXeRjK0JZwsRwfclx1kKoi+gw/Rf3p16ud
	YLXxBiVGszaVMjPvURconz1dsWVcEFtf/NWj8mLd73dpGeKZQGp/rOcsAJRK6Gxf38wJwAZm2qp
	O1B+d7k+f4atEZelc4QpJzS+g0eA/RwxHrU3SmcjJ
X-Gm-Gg: ASbGncvvbCWIdESCwavPd8GTWGmRZ8lBQBXYz/0QUTwdSguon/sP2IyKh+2eQApWd7e
	UWWzYOg4pTl6WXSwheyd/udUeGUcn4ZiyGZU+o/qReWriBuOORJ3ofZRU9jvB96lglQlYDV+iRi
	xHy9BvEZRiCAuVKpXozsvAq7aqk4DIXXryPXss8ifau2iOdnULxJx4SrqivpuoB7Cmkm192794b
	gw+KDz59qYNcvNGjU1SM1HhKSJluziytwadl9LrD89PVo4a9cixk41p
X-Google-Smtp-Source: AGHT+IE69f8D6srRBPVl9pKN5vZpO5F0/UnsSKswJGEAghVTRDosELHxgLTcfYcE/QjWOYfDfEWsjCzTxskkAyr2rBo=
X-Received: by 2002:a05:622a:353:b0:4af:103d:f71 with SMTP id
 d75a77b69052e-4b119db955bmr3455771cf.2.1755235250003; Thu, 14 Aug 2025
 22:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-7-sagis@google.com>
 <aJpO_zN3buvaQoAW@google.com> <0c8d6d1c-d9e1-4ffd-bb26-a03fb87cde1f@linux.intel.com>
In-Reply-To: <0c8d6d1c-d9e1-4ffd-bb26-a03fb87cde1f@linux.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Fri, 15 Aug 2025 00:20:39 -0500
X-Gm-Features: Ac12FXzFZpZpXFtVKoFfvJsHTFWvzrLQdnlQzpXmS7z6xkcHqsTDLUOB3CL7Lc8
Message-ID: <CAAhR5DG+EMVbrdGaPoUiX3MtnVktFtdiY+dDjRhA9tugAoRTJQ@mail.gmail.com>
Subject: Re: [PATCH v8 06/30] KVM: selftests: Add helper functions to create
 TDX VMs
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 11:22=E2=80=AFPM Binbin Wu <binbin.wu@linux.intel.c=
om> wrote:
>
>
>
> On 8/12/2025 4:13 AM, Sean Christopherson wrote:
> > On Thu, Aug 07, 2025, Sagi Shahar wrote:
> [...]
> >> +
> >> +/*
> >> + * Boot parameters for the TD.
> >> + *
> >> + * Unlike a regular VM, KVM cannot set registers such as esp, eip, et=
c
> >> + * before boot, so to run selftests, these registers' values have to =
be
> >> + * initialized by the TD.
> >> + *
> >> + * This struct is loaded in TD private memory at TD_BOOT_PARAMETERS_G=
PA.
> >> + *
> >> + * The TD boot code will read off parameters from this struct and set=
 up the
> >> + * vCPU for executing selftests.
> >> + */
> >> +struct __packed td_boot_parameters {
> > None of these comments explain why these structures are __packed, and I=
 suspect
> > _that_ is the most interesting/relevant information for unfamiliar read=
ers.
> I guess because the fields defined in this structure are accessed by hard=
-coded
> offsets in boot code.
> But as you suggested below, replicating the functionality of the kernel's
> OFFSET() could get rid of "__packed".
>

I agree, I think the reason for using __packed is because of the hard
coded offsets. I tried using OFFSET() as Sean suggested but couldn't
make it work.

I can't get the Kbuild scripts to work inside the kvm selftests
Makefile. I tried adding the following rules based on a reference I
found:

+include/x86/tdx/td_boot_offsets.h: lib/x86/tdx/td_boot_offsets.s
+       $(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
+
+lib/x86/tdx/td_boot_offsets.s: lib/x86/tdx/td_boot_offsets.c
+       $(call if_changed_dep,cc_s_c)

But I'm getting the following error when trying to generate the header:

/bin/sh: -c: line 1: syntax error near unexpected token `;'
/bin/sh: -c: line 1: `set -e;  ;  printf '# cannot find fixdep (%s)\n'
 > lib/x86/tdx/.td_boot_offsets.s.cmd; printf '# using basic dep
data\n\n' >> lib/x86/tdx/.td_boot_offsets.s.cmd; cat
lib/x86/tdx/.td_boot_offsets.s.d >>
lib/x86/tdx/.td_boot_offsets.s.cmd; printf '\n%s\n'
'cmd_lib/x86/tdx/td_boot_offsets.s :=3D ' >>
lib/x86/tdx/.td_boot_offsets.s.cmd'
make: *** [Makefile.kvm:44: lib/x86/tdx/td_boot_offsets.s] Error 2

For now I can add a comment on the __packed and add a TODO to replace
it with OFFSET. I think that making OFFSET work inside the kvm
selftests will require more expertise in the Kbuild system which I
don't have.

> A side topic is when developers should provide comments for the uses of
> "__packed". Is it always preferred a comment for it or a developer can sa=
ve
> the comment for obvious cases, e.g, the structure is defined according to
> some hardware layout?
>
> >
> >> +    uint32_t cr0;
> >> +    uint32_t cr3;
> >> +    uint32_t cr4;
> >> +    struct td_boot_parameters_dtr gdtr;
> >> +    struct td_boot_parameters_dtr idtr;
> >> +    struct td_per_vcpu_parameters per_vcpu[];
> >> +};
> >> +
> ...
>
> >> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S b/tools=
/testing/selftests/kvm/lib/x86/tdx/td_boot.S
> >> new file mode 100644
> >> index 000000000000..c8cbe214bba9
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
> >> @@ -0,0 +1,100 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +
> >> +#include "tdx/td_boot_asm.h"
> >> +
> >> +/* Offsets for reading struct td_boot_parameters. */
> >> +#define TD_BOOT_PARAMETERS_CR0         0
> >> +#define TD_BOOT_PARAMETERS_CR3         4
> >> +#define TD_BOOT_PARAMETERS_CR4         8
> >> +#define TD_BOOT_PARAMETERS_GDT         12
> >> +#define TD_BOOT_PARAMETERS_IDT         18
> >> +#define TD_BOOT_PARAMETERS_PER_VCPU    24
> >> +
> >> +/* Offsets for reading struct td_per_vcpu_parameters. */
> >> +#define TD_PER_VCPU_PARAMETERS_ESP_GVA     0
> >> +#define TD_PER_VCPU_PARAMETERS_LJMP_TARGET 4
> >> +
> >> +#define SIZEOF_TD_PER_VCPU_PARAMETERS      10
> > Please figure out how to replicate the functionality of the kernel's OF=
FSET()
> > macro from  include/linux/kbuild.h, I have zero desire to maintain open=
 coded
> > offset values.
> >

