Return-Path: <linux-kernel+bounces-800316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94231B4362E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB75175F9D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62002C327C;
	Thu,  4 Sep 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="raH91HrR"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C18F28B3E2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975523; cv=none; b=nIErrUQi/Nt7RhLDdvKXIrwa1F2wCa4bZMOgatTjtDX6A4f04i2fwvwq2Y793xkuRwNBj/37CFcXGsirbrXWerPDb52PuAo44lhN0tSs25J5IXGCR3kpplVDZNgEnlLY9tMf//4sITJej++dvTh6mB6L8E34uOXAMg2DliZK9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975523; c=relaxed/simple;
	bh=bF8A9kjIXOyp4KJQCwHrBsND+iKStCkVgpl25MXZkzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aOypghzzpcP4z1JnDTfmK8aIyvBck20nkwovjB9FLT+PfhlwYJmOMfWFKb43rf4kvJ3x1BXuC3tEMqJGC8l8X4S4jO4SgsVkDoCJyESR+yA/uu6kJFOaPPiReglaAxXiJSFRRwkDDor3ylCbQLXoMLttvxZJfWRTGY8Vhnlw+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=raH91HrR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77265551c77so1336457b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756975521; x=1757580321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P71OTbqs7HkHLt+0YQ5aCeNmESM5V1X30oeNZynlP4Y=;
        b=raH91HrRbRogsl8dWmTlnqyl5lxpIK4vHdCEhQm0sQQ4ADvj7kT4J2yZNqzWC3sDUA
         zpSY+cybxMtEWChCfAwvAWXo+nvn3jR1Zw/JPdrAFP7WoSeqCJhIgLxzoUK5RkuQ+4Yx
         QcSGwnhyoNay6MI7oAWm1TG5vKgZXdf4A1YxJexjuDp4cRuyYwAXlOVYjomRwoRbi955
         k9ooOJezddfhik10cxE3crtGL0PVnVAyBDQB4MNrZevqXX+i8uR2F7U4Elb+Gp89ebEL
         3aNDeXA57QKM3P1G/hpKAwJFEUY/ZAb3ZDEJu8gt89/0r2joBLBM6mT2UCP51YFnwuzD
         bOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975521; x=1757580321;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P71OTbqs7HkHLt+0YQ5aCeNmESM5V1X30oeNZynlP4Y=;
        b=NOsmzyhmcJKhqEcUIa/D4CVEsbCscQKsBC8H/yOHu6f/V0lIybUU0KPSAspRdtdpqj
         px8mtkAliZk5elrRL2P4fktaPW1z0UvgUY6lP5xHPKku19gDeTySR9JLR8+sPYk9GUZn
         vXBZiZNYr76ICXDpIpjnKZqRG9mJKgp5hZIBP2wKfcHBHcR52WzYWgt9qcuQZ97m9mCT
         rhaMeNiGYaptKzE7d0YQG+eBwYuC/acBywTaJMqAtUL9taGAEpyAsF+RYm+BiNiDNQNO
         7V3AL1NXQtgeWbWTPDwFszAMwQnPPRB/XbcQaWI2hic3S2sHXQomdFeLQ/LYBn9KZuqn
         WJeA==
X-Forwarded-Encrypted: i=1; AJvYcCWiZXQF7Rg6yktiDvEgSCrLhbm2gkQBySI5hqKRHUMvPI+7d1fHPDiHA3rnwqFR9WQlnhEdGwct6OL3pyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyvRjE40gV0KasaUfDd0GLJstQtZsSiXvtAuVYMVFwiwNmju1t
	Qh/xOPxF/djRUIgXdW0ovxUYUBdgQT3J7i7uB3SOlAHlDaPSx02tti/1vifmWw5h4pHPAfJNEaE
	aNmV22Q==
X-Google-Smtp-Source: AGHT+IFifnWO8BsbpNnWCA7xwWar2zICrVkC3ktYtvdG1V4ckGV0ffM8aKP/TkCPQ7eLFK9nQT5Kj0Gq72U=
X-Received: from pga17.prod.google.com ([2002:a05:6a02:4f91:b0:b49:dac2:f892])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a7:b0:243:15b9:7791
 with SMTP id adf61e73a8af0-243d6f7d02fmr23663536637.53.1756975520887; Thu, 04
 Sep 2025 01:45:20 -0700 (PDT)
Date: Thu, 4 Sep 2025 01:45:09 -0700
In-Reply-To: <97a422c0ba7a5d68b35b5327d3bf0cd11429c300.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com> <20250829000618.351013-6-seanjc@google.com>
 <49c337d247940e8bd3920e5723c2fa710cd0dd83.camel@intel.com>
 <aLT2FwlMySKVYP1i@yzhao56-desk.sh.intel.com> <aLcqVtqxrKtzziK-@google.com> <97a422c0ba7a5d68b35b5327d3bf0cd11429c300.camel@intel.com>
Message-ID: <aLlRlbaq84IRvNPv@google.com>
Subject: Re: [RFC PATCH v2 05/18] KVM: TDX: Drop superfluous page pinning in
 S-EPT management
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yan Y Zhao <yan.y.zhao@intel.com>, Kai Huang <kai.huang@intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "michael.roth@amd.com" <michael.roth@amd.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2025, Rick P Edgecombe wrote:
> On Tue, 2025-09-02 at 10:33 -0700, Sean Christopherson wrote:
> > > Besides, a cache flush after 2 can essentially cause a memory write t=
o the
> > > page.
> > > Though we could invoke tdh_phymem_page_wbinvd_hkid() after the KVM_BU=
G_ON(),
> > > the SEAMCALL itself can fail.
> >=20
> > I think this falls into the category of "don't screw up" flows.=C2=A0 F=
ailure to
> > remove a private SPTE is a near-catastrophic error.=C2=A0 Going out of =
our way to
> > reduce the impact of such errors increases complexity without providing=
 much
> > in the way of value.
> >=20
> > E.g. if VMCLEAR fails, KVM WARNs but continues on and hopes for the bes=
t, even
> > though there's a decent chance failure to purge the VMCS cache entry co=
uld be
> > lead to UAF-like problems.=C2=A0 To me, this is largely the same.
> >=20
> > If anything, we should try to prevent #2, e.g. by marking the entire
> > guest_memfd as broken or something, and then deliberately leaking _all_=
 pages.
>=20
> There was a marathon thread on this subject.

Holy moly, you weren't kidding.

> We did discuss this option (link to
> most relevant part I could find):
> https://lore.kernel.org/kvm/a9affa03c7cdc8109d0ed6b5ca30ec69269e2f34.came=
l@intel.com/
>=20
> The high level summary is that pinning the pages wrinkles guestmemfd's pl=
ans to
> use refcount for other tracking purposes. Dropping refcounts interferes w=
ith the
> error handling safety.

It also bakes even more assumptions into TDX about guest_memfd being backed=
 with
"struct page", which I would like to avoid doing whenever possible.

> I strongly agree that we should not optimize for the error path at all. I=
f we
> could bug the guestmemfd (kind of what we were discussing in that link) I=
 think
> it would be appropriate to use in these cases. I guess the question is ar=
e we ok
> dropping the safety before we have a solution like that.

Definitely a "yes" from me.  For this to actually cause real world problems=
, we'd
need a critical KVM, hardware, or TDX-Module bug, and several unlikely even=
ts to
all line up.

If someone encounters any of these KVM_BUG_ON()s _and_ has observed that th=
e
probability of data corruption is meaningful, then we can always convert on=
e or
more of these to full BUG_ON() conditions, but I don't see any reason to do=
 that
without strong evidence that it's necessary.

> In that thread I was advocating for yes, partly to close it because the
> conversation was getting stuck. But there is probably a long tail of
> potential issues or ways of looking at it that could put it in the grey a=
rea.

