Return-Path: <linux-kernel+bounces-732597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 887E2B06951
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4731C2084D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24E2C15AC;
	Tue, 15 Jul 2025 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GoCbTlGR"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548EB2D1F7B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752618711; cv=none; b=chVzE1ceKZPDchkEX8TGgKz8eTn3P+ppcZL3lILs7FgFNIMdRz1Y8VnDDdtcmSJVZQ7VcQqUuKPC55Q/khajUCuMVIC7S6ykWvqlKJ0rlP+yQhSfoZKQpCIav7TTUseSGNW01PW0RrpDEAr2AAPzK9Yz6ajHWy/jQpIbfh8OhwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752618711; c=relaxed/simple;
	bh=EGo71pGB25aRe+dzBTxG5hUAh1TU9qUWx5DqyUNZDD0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UikGk9EbH3yHrAHIGVa0aETuN2SlrlBSiZSkvv0Rwp5CruGmOhKYUYO/E/Z/6NBwVrwtWzz2BvH/7tDPCjdB4q5bDG27lbsfKHNw6mb4RZe35bafjHZQ/pSP2GdywgRznLWpzJ1Hx0zFJbKPD7zVnysfigIwIjbVk/uIolKBa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GoCbTlGR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so5765413a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752618710; x=1753223510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGo71pGB25aRe+dzBTxG5hUAh1TU9qUWx5DqyUNZDD0=;
        b=GoCbTlGRhMnyFft9cjqn8cZJEmwTtHZ3RUte1tyR8MwBojoBhYBqdMKzeceSQOMERR
         uK54YmSpA5Nb5OvCdlRpL1tThb/F7qOLz3T/6ziaqRcXbcSqVF0cH9D5yxrVNlKkDpaS
         oeawh/DBTrVRMbZcHipIx3ZS87EurMp+E1/KuVLhV+FdAXouhwRhHepaJmD794P8g0H4
         gVzU2Q3aL7gUR/5rCLlPfJbKW8ZRWW+hhkV8TA9O7R8MvDCwbRYdrAdmQVMevDwE+B5X
         242A4QijoU3/Yq24HsZ/okwd7NRKvbibPtOdt1AhqeDhVJftC937W7laDHEfUZyVbwD7
         SEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752618710; x=1753223510;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EGo71pGB25aRe+dzBTxG5hUAh1TU9qUWx5DqyUNZDD0=;
        b=TNiJ6g4gVzK/24eh6stU5zRoUaugcU9ATOq/2KDSRjIJOX6smgGOd68FwT1F8cQXUI
         6CGFFO/MWOP2jdcJA0bBwNOaDcMGGqSF+v3qp5HaT7df3HPoZBAuPJQq0enDOcjNyeMA
         83gwE96UXb2pv1dJuj3F1FeF4DJCRNRJozoqPZ4OXxAM73X1WxTqd9oRPJl2krAudutr
         Xu9GF18KBtEVL+IS01HTd5lEcnTM6n6hHUxRlGO8qhePMsCOOZUd8a2e4FXojcmwJTMY
         00PR66ADElUq/PMaAa1DmvW5WSxbX2qBU7pB0q8HS7em9tMPLYc42jyXD8vr9PdIlcR6
         BwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/a84+UTQMelwfqzHggCUPodoQqu0RBWGZxTKJqclkH4LtPj9jXVhiZJMPJmOKDgxOhdGi1KU8cuA+xH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLyY2sAAdVupW/uyFz+KHdXK2vxsqB8soo1007QtLmUCxTwQf3
	YwIisPlpwtE9IKkVZ3uhoCagOtUu8YxY0397dBWeeMompz+Mrv0PwY8DhIGlbIYyT3Ksc0qb4ng
	F/CEnWnDMYGe3UxM4Spi4uUN2BQ==
X-Google-Smtp-Source: AGHT+IEJmk08WJfnlzLLoLwdM9qLMEEvMBr3WhmfjtruDn3UecOESho2SIVbYJkbM8TfrUrOHaIdkcaEyzEJ1IOF4g==
X-Received: from pjtu13.prod.google.com ([2002:a17:90a:c88d:b0:312:e266:f849])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:57ed:b0:311:a314:c2dc with SMTP id 98e67ed59e1d1-31c9e6f11camr1291163a91.14.1752618709635;
 Tue, 15 Jul 2025 15:31:49 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:31:48 -0700
In-Reply-To: <345e890e65907e03674e8f1850f5c73f707d5a36.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <diqzms9pjaki.fsf@ackerleytng-ctop.c.googlers.com>
 <fe6de7e7d72d0eed6c7a8df4ebff5f79259bd008.camel@intel.com>
 <aGNrlWw1K6nkWdmg@yzhao56-desk.sh.intel.com> <cd806e9a190c6915cde16a6d411c32df133a265b.camel@intel.com>
 <diqzy0t74m61.fsf@ackerleytng-ctop.c.googlers.com> <04d3e455d07042a0ab8e244e6462d9011c914581.camel@intel.com>
 <diqz7c0q48g7.fsf@ackerleytng-ctop.c.googlers.com> <a9affa03c7cdc8109d0ed6b5ca30ec69269e2f34.camel@intel.com>
 <diqz1pqq5qio.fsf@ackerleytng-ctop.c.googlers.com> <53ea5239f8ef9d8df9af593647243c10435fd219.camel@intel.com>
 <aHCdRF10S0fU/EY2@yzhao56-desk> <4c70424ab8bc076142e5f6e8423f207539602ff1.camel@intel.com>
 <diqzikju4ko7.fsf@ackerleytng-ctop.c.googlers.com> <345e890e65907e03674e8f1850f5c73f707d5a36.camel@intel.com>
Message-ID: <diqzcya13x2j.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 08/21] KVM: TDX: Increase/decrease folio ref for huge pages
From: Ackerley Tng <ackerleytng@google.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
Cc: "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"kirill.shutemov@intel.com" <kirill.shutemov@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"david@redhat.com" <david@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "Li, Zhiquan1" <zhiquan1.li@intel.com>, "Du, Fan" <fan.du@intel.com>, 
	"tabba@google.com" <tabba@google.com>, "seanjc@google.com" <seanjc@google.com>, "Weiny, Ira" <ira.weiny@intel.com>, 
	"Peng, Chao P" <chao.p.peng@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Annapurve, Vishal" <vannapurve@google.com>, 
	"jroedel@suse.de" <jroedel@suse.de>, "Miao, Jun" <jun.miao@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pgonda@google.com" <pgonda@google.com>, 
	"x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Mon, 2025-07-14 at 12:49 -0700, Ackerley Tng wrote:
>> I'm onboard here. So "do nothing" means if there is a TDX unmap failure,
>>=20
>> + KVM_BUG_ON() and hence the TD in question stops running,
>> =C2=A0=C2=A0=C2=A0 + No more conversions will be possible for this TD si=
nce the TD
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stops running.
>> =C2=A0=C2=A0=C2=A0 + Other TDs can continue running?
>> + No refcounts will be taken for the folio/page where the memory failure
>> =C2=A0 happened.
>> + No other indication (including HWpoison) anywhere in folio/page to
>> =C2=A0 indicate this happened.
>
> Yea.
>
>> + To round this topic up, do we do anything else as part of "do nothing"
>> =C2=A0 that I missed? Is there any record in the TDX module (TDX module
>> =C2=A0 itself, not within the kernel)?
>
> We should keep this as an option for how to change the TDX module to make=
 this
> solution safer. For future arch things, we should maybe pursue something =
that
> works for TDX connect too, which could be more complicated.
>
>>=20
>> I'll probably be okay with an answer like "won't know what will happen",
>
> I have not exhaustively looked at that there won't be cascading failures.=
 I
> think it's reasonable given this is a bug case which we already have a wa=
y to
> catch with a warning.
>
>> but just checking - what might happen if this page that had an unmap
>> failure gets reused?=C2=A0
>>=20
>
> The TDX module has this thing called the PAMT which records how each phys=
ical
> page is in use. If KVM tries to re-add the page, the SEAMCALL will check =
PAMT,
> see it is not in the NDA (Not directly assigned) state, and give an error
> (TDX_OPERAND_PAGE_METADATA_INCORRECT). This is part of the security enfor=
cement.
>
>> Suppose the KVM_BUG_ON() is noted but somehow we
>> couldn't get to the machine in time and the machine continues to serve,
>> and the memory is used by=20
>>=20
>> 1. Some other non-VM user, something else entirely, say a database?
>
> We are in a "there is a bug" state at this point, which means stability s=
hould
> not be expected to be as good. But it should be optimistically ok to re-u=
se the
> page as long as the TD is not re-entered, or otherwise actuated via SEAMC=
ALL.
>
>> 2. Some new non-TDX VM?
>
> Same as (1)
>
>> 3. Some new TD?
>
> As above, the TDX module should prevent this.

Thanks for clarifying! SGTM!

Btw, after some more work on handling memory failures for guest_memfd,
it now seems like it's better for guest_memfd to not use the HWpoison
flag internally either.

So it turns out well that for TDX unmap failures we're aligned on not
using HWpoison :)

