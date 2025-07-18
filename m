Return-Path: <linux-kernel+bounces-737301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A6BB0AA7C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E9C3BA30A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA852E7F31;
	Fri, 18 Jul 2025 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhLtfNvx"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0D92E6D31
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865193; cv=none; b=AC1+LiYB0rjxVv/V51C2SHp36MbNaPDMeLectQFlbrRresOe9ZfuBNngNA7sMI2l8C+3kAhElv1e9CJLXxKvaNzpPJfHx/U2GX/r18jnItUoLIFSh5/lvr1S4ZHFzHkCOX4QQ3ogPPt95q/Q6rXXe4dZVqnoO8sp3IU/1zYcVCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865193; c=relaxed/simple;
	bh=taE+/ctRGOPew3+5bSYl2Hv+oOd5K+FCRxlMfgVgMuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/KlWS3PhoUOPoj2VO52GLcR2m1ZH2B++5UxfhAV4royQSx2MOUFYZFi2YtqPfzRksL0BhdB9vZh514sJ4pzRCMJK2SWe+336K2l+v4xITkyKXyJjX6JbAOgZlGBb2hZd799WzsnS5+WS68/9AZI9l+ZRyfN5iaJbIfpSuJVg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AhLtfNvx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235e389599fso32955ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752865191; x=1753469991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrROO4+eR6/+Z0KaNlJ044e8PDoospst2QAllWf9w8w=;
        b=AhLtfNvxtK7cG3XM6ELKoBABQrTllPNpcu94ubGXIu0to9ZZffmzQX8BARS6F0Pu2L
         5kzg7/oqbbIl4TdCO4vaU2K2DzQrGU3VC6FxP9YkgT54z8Ptto+d4XbTmBYp5tjVnwvP
         HPkNHnzajZ8+M9f0cbWjEfoTQrVFQGKJb136fqRVg7f982sHAgTUF+p/t0M7nbRQMKcD
         el25i2iHwSd1VRWCNMOmDmZD7M91ryx4IgCHVO3dlSXm9SrUorqp8jnDzacawm5GZVR6
         v3615r6CJGuoO/kS+3EQFGtmoauPcwI0Csmss+GVG4EwYLQLviLWsafeLpLwgHzzbKbS
         6zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752865191; x=1753469991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrROO4+eR6/+Z0KaNlJ044e8PDoospst2QAllWf9w8w=;
        b=GykmjXi+gk7CqAifg5S/sUrsmJ/eAjRCueUk8+ujCERwWWPhE42zhH0EapAcsQ/86N
         JgmkXfNj+m6bVzV1MKpzVT4k/7bNHTU9LkqCOG+W0lFumXauIaHXZhYZMhh8Qw2KZp7I
         I4EmAq8a8xUCWJYoeE8zSIQYBUdsWDV8SVbn9Pn9RUGUnC8CeVbX6cJjafeYuammZsN5
         cRUzuGPxgOpmNU5gxppQDiSUh3GMtA32eQjtl1HFfcCEPUKjV0nEzTG6xSwqKzekxEae
         K0DcQ0tiFUpxVtJJOWJgn+OvBQ039hPWjz54EbZKvFxlCVfuW1a1TQdsFumLQvlNd+ze
         4mjg==
X-Forwarded-Encrypted: i=1; AJvYcCXbryUU4QucL2tUikim6xopZkn6hMnJB+AREuiOhBJWOCIO/bDF8nop08beAvkUruxz7qTYmUgsWxk0aVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWBAZdGOMta+4bdeZzxBKfDH7+HpRUwu+5YhDWDYbXngqxuWAM
	MjQWMFRXOmEC/c2b0WbTyl6bnPzygQVgPF05cBHHJE0F38hD1sZDA60PGHv8fObDJQM+v+oFQSU
	860Oy2nbRbKvQxNDubateF94Yc85sFNGmcue5PIY0
X-Gm-Gg: ASbGncupFRhl6Bgu1m4LSw/dlMggoHXsVwKW5cqAR+BAriyCJoOynV3ODihlHMDuMO5
	dV+yDGJwUi8BJaLHBiw8Wg6YqBSRaxWeCzIcG264GtmFj3HyPqwLqxH2f2XI1W2BHEqadi/847y
	JLtAEDZ3XF2vZnnkX+ppRRJsCW8C9OJP33vcFsUy3+Ps+nMW+4nxt/u/9YTqaTDOWffE1DHPgTk
	SE/7jGrF3CDlLk2W/ST6NuF//9tptivypH5CORg
X-Google-Smtp-Source: AGHT+IFpf5quYC1vdY93qwtkt519zsw+ML1HvqAXK+aPQMdz4ELJvbogdmOIVNoHWEPpznqkON8Fny73GNCipKvP1Ig=
X-Received: by 2002:a17:902:f78c:b0:235:e1d6:5339 with SMTP id
 d9443c01a7336-23f71db7bbdmr323975ad.26.1752865191118; Fri, 18 Jul 2025
 11:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709232103.zwmufocd3l7sqk7y@amd.com> <aG_pLUlHdYIZ2luh@google.com>
 <aHCUyKJ4I4BQnfFP@yzhao56-desk> <20250711151719.goee7eqti4xyhsqr@amd.com>
 <aHEwT4X0RcfZzHlt@google.com> <aHSgdEJpY/JF+a1f@yzhao56-desk>
 <aHUmcxuh0a6WfiVr@google.com> <aHWqkodwIDZZOtX8@yzhao56-desk>
 <aHoQa4dBSi877f1a@yzhao56-desk.sh.intel.com> <CAGtprH9kwV1RCu9j6LqToa5M97_aidGN2Lc2XveQdeR799SK6A@mail.gmail.com>
 <687a959ad915e_3c99a32942b@iweiny-mobl.notmuch>
In-Reply-To: <687a959ad915e_3c99a32942b@iweiny-mobl.notmuch>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 18 Jul 2025 11:59:39 -0700
X-Gm-Features: Ac12FXxYJMxLN5HPBgnNv0VYOyT__JVaniVIs9JK603HrHK22vQiSEL3DYC88P4
Message-ID: <CAGtprH-DprCYLCYK3T7fQ23xAkTb9HdMbbp3TJ=-QgenNz8=mg@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: TDX: Decouple TDX init mem region from kvm_gmem_populate()
To: Ira Weiny <ira.weiny@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, kai.huang@intel.com, 
	adrian.hunter@intel.com, reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@intel.com, binbin.wu@linux.intel.com, dmatlack@google.com, 
	isaku.yamahata@intel.com, david@redhat.com, ackerleytng@google.com, 
	tabba@google.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 11:41=E2=80=AFAM Ira Weiny <ira.weiny@intel.com> wr=
ote:
>
> Vishal Annapurve wrote:
> > On Fri, Jul 18, 2025 at 2:15=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com>=
 wrote:
> > >
> > > On Tue, Jul 15, 2025 at 09:10:42AM +0800, Yan Zhao wrote:
> > > > On Mon, Jul 14, 2025 at 08:46:59AM -0700, Sean Christopherson wrote=
:
> > > > > > >         folio =3D __kvm_gmem_get_pfn(file, slot, index, &pfn,=
 &is_prepared, &max_order);
> > > > > > If max_order > 0 is returned, the next invocation of __kvm_gmem=
_populate() for
> > > > > > GFN+1 will return is_prepared =3D=3D true.
> > > > >
> > > > > I don't see any reason to try and make the current code truly wor=
k with hugepages.
> > > > > Unless I've misundertood where we stand, the correctness of hugep=
age support is
> > > > Hmm. I thought your stand was to address the AB-BA lock issue which=
 will be
> > > > introduced by huge pages, so you moved the get_user_pages() from ve=
ndor code to
> > > > the common code in guest_memfd :)
> > > >
> > > > > going to depend heavily on the implementation for preparedness.  =
I.e. trying to
> > > > > make this all work with per-folio granulartiy just isn't possible=
, no?
> > > > Ah. I understand now. You mean the right implementation of __kvm_gm=
em_get_pfn()
> > > > should return is_prepared at 4KB granularity rather than per-folio =
granularity.
> > > >
> > > > So, huge pages still has dependency on the implementation for prepa=
redness.
> > > Looks with [3], is_prepared will not be checked in kvm_gmem_populate(=
).
> > >
> > > > Will you post code [1][2] to fix non-hugepages first? Or can I pull=
 them to use
> > > > as prerequisites for TDX huge page v2?
> > > So, maybe I can use [1][2][3] as the base.
> > >
> > > > [1] https://lore.kernel.org/all/aG_pLUlHdYIZ2luh@google.com/
> > > > [2] https://lore.kernel.org/all/aHEwT4X0RcfZzHlt@google.com/
> >
> > IMO, unless there is any objection to [1], it's un-necessary to
> > maintain kvm_gmem_populate for any arch (even for SNP). All the
> > initial memory population logic needs is the stable pfn for a given
> > gfn, which ideally should be available using the standard mechanisms
> > such as EPT/NPT page table walk within a read KVM mmu lock (This patch
> > already demonstrates it to be working).
> >
> > It will be hard to clean-up this logic once we have all the
> > architectures using this path.
>
> Did you mean to say 'not hard'?

Let me rephrase my sentence:
It will be harder to remove kvm_gmem_populate if we punt it to the future.

