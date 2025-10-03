Return-Path: <linux-kernel+bounces-840887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2CEBB5A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AA93B47B2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28AF2C18A;
	Fri,  3 Oct 2025 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBnkyIAM"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD5E2AF1B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759450535; cv=none; b=ZKnihQgkRZXHtrI2PAPpJbmjv6B4ZtOTucwWVScJTAb5WvTeGrpBEpmSro0XvuJFKrqgDA1AsdtYY67UfHDAJS0q2/w3TByLDdHnCDy2Jt3bu/jBYsrFsyuvxjBOLS4V0Bt5SNLcBDx0qKMbJA7GnOjZS1Hcuz+9tVuis5OXx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759450535; c=relaxed/simple;
	bh=IbVTq6DVtLnDtClIa2UsIoSHwO4Q78sJ2jUNJFJCgqo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EiW4WOzblrxhqbbitwZW0Yb1oUL7qZC0Ey2tsCBoVh4ym10D7y2VL0x/+p4hP1RfqdTjzBAY2Cgp7xrCWDRXuluiuAiE2yZf6N7ll80MjXBM5kPNaqfJmJ8Dr9MeVULZ8V/TEqaCk5STWom8nEo0I2v5n8QqGjnDv9L8dpIcdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBnkyIAM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befd39so3332203a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759450529; x=1760055329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJUpzprtnJ3Qq4004mJgfAwQ4e348MX3F4zrqc0eQ2Q=;
        b=bBnkyIAMRd/6AEllKx6lzoC4aBr/LH6+BWA6knSFwHxPHqUn6PJOn1cRAFA7vDzGED
         2WPWBM59qFwW/kaEbECluxKvy3chMH+A3q4skzai6cLp4AhyZO9nBdU+huFulGgFP57r
         w2NIft2R4sMTsu+w/h0i02O9w7qm5Zfplu+pL0pf1XTVgy8sexHKvBgD9HJSe/vPT5Rj
         hsQlRdadDAq6raiNEDmuhnR3PuIphT4hjE5TiliJ2bySw8xUZjnm9AKivdRudPG453WP
         lfrYzan6dn1TPIkZC2wl6iRL+KA1iqbHZtRSQU4RU+aZXX8ZNSKQUh6tMB54NnvRqpzV
         wfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759450529; x=1760055329;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJUpzprtnJ3Qq4004mJgfAwQ4e348MX3F4zrqc0eQ2Q=;
        b=LMStbjPz5ZlSx6AZ+S50GL98TBQNb63KRU+Z3wAkbdWeHax/tHhrHIaTK86d7h4rjs
         8tcc9y5bfEuoyV3PR3sWbKEfzufIqXUC0WzMc4eZF6Jc209rihKKABcaZhnEaNjVGQux
         qC8GsgxbckeTQ1OBxN7QShxFW1p2ZDWq9JR6tntif4B0FgCr1B4vVtquu2bWHRSdpn9r
         6ggyiljjXtOdQrZB54LpNCgApOzp/Nv5qTTGXGdAvvb4o5s+M/DPii2rYyXb8QfLPS1j
         NRv5BL8OZl69u3DO7Bk4LSQ8e2eSi6Am/EUOlkcKj0OrCdkxF6WMWBGS59b0AuThYmEF
         0K4g==
X-Forwarded-Encrypted: i=1; AJvYcCWDVPVT85kWtc2dltqC7P9NwtpiXdtjLAHTp41uEcRSR0scMJE4QXgPs9v8Um03Gq3LynOeDgaIwicjjrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHpJidkAI0T1SwTrKqbq/MsFtlu2UfIPVA63yXpx3pAROA378Z
	Cf8wXZkBOwJ3Z8AKLA7J18zbbRC6Y0DdS4F15qRn4DBzA0USARUyhZXTaZQ8BuEDnlHfOEc/kSp
	kdaIgPQ==
X-Google-Smtp-Source: AGHT+IFoNlT1kyXEnjCQ5Rd9imtmnIPgNiqF4WBj65hoI/jm+258z8Wqr//zh7Y7/q1Ccc9bt47eQUCrXCQ=
X-Received: from pjbcv16.prod.google.com ([2002:a17:90a:fd10:b0:32d:df7e:66c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e09:b0:32e:70f5:6988
 with SMTP id 98e67ed59e1d1-339c27b3cb3mr1171811a91.32.1759450529204; Thu, 02
 Oct 2025 17:15:29 -0700 (PDT)
Date: Thu, 2 Oct 2025 17:15:27 -0700
In-Reply-To: <68dee81d79199_296d74294b9@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAGtprH9kwV1RCu9j6LqToa5M97_aidGN2Lc2XveQdeR799SK6A@mail.gmail.com>
 <aIdHdCzhrXtwVqAO@yzhao56-desk.sh.intel.com> <CAGtprH-xGHGfieOCV2xJen+GG66rVrpFw_s9jdWABuLQ2hos5A@mail.gmail.com>
 <aIgl7pl5ZiEJKpwk@yzhao56-desk.sh.intel.com> <6888f7e4129b9_ec573294fa@iweiny-mobl.notmuch>
 <aJFOt64k2EFjaufd@google.com> <CAGtprH9ELoYmwA+brSx-kWH5qSK==u8huW=4otEZ5evu_GTvtQ@mail.gmail.com>
 <aJJimk8FnfnYaZ2j@google.com> <CAGtprH9JifhhmTdseXLi9ax_imnY5b=K_+_bhkTXKSaW8VMFRQ@mail.gmail.com>
 <68dee81d79199_296d74294b9@iweiny-mobl.notmuch>
Message-ID: <aN8Vn9iD7OMzspp5@google.com>
Subject: Re: [RFC PATCH] KVM: TDX: Decouple TDX init mem region from kvm_gmem_populate()
From: Sean Christopherson <seanjc@google.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, kai.huang@intel.com, 
	adrian.hunter@intel.com, reinette.chatre@intel.com, xiaoyao.li@intel.com, 
	tony.lindgren@intel.com, binbin.wu@linux.intel.com, dmatlack@google.com, 
	isaku.yamahata@intel.com, david@redhat.com, ackerleytng@google.com, 
	tabba@google.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025, Ira Weiny wrote:
> Vishal Annapurve wrote:
> > On Tue, Aug 5, 2025 at 12:59=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Mon, Aug 04, 2025, Vishal Annapurve wrote:
> > > > On Mon, Aug 4, 2025 at 5:22=E2=80=AFPM Sean Christopherson <seanjc@=
google.com> wrote:
> > > > > : 4) For SNP, if src !=3D null, make the target pfn to be shared,=
 copy
> > > > > : contents and then make the target pfn back to private.
> > > > >
> > > > > Copying from userspace under spinlock (rwlock) is illegal, as acc=
essing userspace
> > > > > memory might_fault() and thus might_sleep().
> > > >
> > > > I would think that a combination of get_user_pages() and
> > > > kmap_local_pfn() will prevent this situation of might_fault().
> > >
> > > Yes, but if SNP is using get_user_pages(), then it looks an awful lot=
 like the
> > > TDX flow, at which point isn't that an argument for keeping populate(=
)?
> >=20
> > Ack, I agree we can't ditch kvm_gmem_populate() for SNP VMs. I am ok
> > with using it for TDX/CCA VMs with the fixes discussed in this RFC.
>=20
> Sean,
>=20
> Where did this thread land?  Was there a follow on series which came out
> of this?  I thought you sent a patch with the suggestions in this thread
> but I can't find it.

Are you referring to "KVM: x86/mmu: TDX post-populate cleanups"[*]?  If so,=
 my
goal is to send v3 next week.

If you're talking about something else, then no idea :-)

[*] https://lore.kernel.org/all/20250829000618.351013-1-seanjc@google.com

