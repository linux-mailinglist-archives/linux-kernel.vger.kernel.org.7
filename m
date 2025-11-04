Return-Path: <linux-kernel+bounces-885051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A99FC31D96
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 870E64ED406
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094152580D1;
	Tue,  4 Nov 2025 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="komXz4R+"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949B258CD9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270172; cv=none; b=KpjUEAVbYEVXlhlQJZ4w8VI8n75HsusP5QbJ86KMLpY3kl+rXXuI1Z4hBV/tyaHszXMInpS2wPa43JqieDydLZrapCkjUS6hn3hBtPSTncsLmhD2nTBmwVWjvMHLcYMk4C4/tsBTGMPN5Ul6WmTP2y+xyd8YmPJ8PYbdZfJDSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270172; c=relaxed/simple;
	bh=8GNMbexAGe1nKqMzzLVClEkNd7j6DVDRkgcdOMp8ajQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqo3CllkY/b9Q8yWn1hIGrvfd8by2SAxn5EdMUNIqlOmjlhdd7vFefHVW8Ls32abXPZvroQw8ZFQvyvPjza4XX93r05s/4mBMJQRd8qbjFKWgn8cp50qhqmTfhM0vEgwHgWAvVAkawe1HExtdl8Hyg/lBJxpCEyBTpo/xbV29S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=komXz4R+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2959197b68eso195915ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762270170; x=1762874970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GNMbexAGe1nKqMzzLVClEkNd7j6DVDRkgcdOMp8ajQ=;
        b=komXz4R+41dzT/XSiGVn89xk28v1lVjn5ZUX4+R3Vry1fRFm0on3hzx47TViArkgsV
         64igP4q74IHlHGz/e6WNOhIzO4NoXFVpzWZY5PT6xsU5aMt5urG5Tmgum3HpayNNAR7W
         qMgE5xpOgsKWwcZiD/HiON3MyShaU7sEGd9iKE/mhwXRZZth+xK/SZMi8eNiy6M2u/JN
         mu5mOt3DcNFAVsM5g7HUMIvWJa2e7uJ6jJGTK7/tdfqn1iuKZ03YmvQ6604ISnoZsI6F
         EwQrKMGUNWm7ChO2CPB+o/p4InWbwf4bs/Ew38x9e09dHaSp+1R2iw0gthCKjcs7qe3Y
         ZcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762270170; x=1762874970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GNMbexAGe1nKqMzzLVClEkNd7j6DVDRkgcdOMp8ajQ=;
        b=xTIQuabZ5rK1UTdBOwFnvpBVLzv2RR8/mLHqIX5nEG/3iVaD8brbp+pm7J5WuPQzZL
         GSHlXI5Eb3k2GNZPA7lJgygdTOybFKGrCDPsoZdxgJLSvISz+mtRuVu7F2vbO+l62I1I
         g40LFvLA4tQzDXstV8odoim2HIqwpSpEsqB1YlSfOAke8SVk4m9nwH4kIUdxN21RwSgX
         mLHkt+DK5u8GQ4yTkBgTrvuqYaWNxT6DL0/HFt06v4Yr2QvHXYwY3p4cDU/mqgcJNlRa
         JjFNJXiZ3d1OQps5RIl5sBhLpj4GGCR8gfSfh2W2dULdi0Xqam9+J/PpzLoZ+HE4nQFK
         Pckg==
X-Forwarded-Encrypted: i=1; AJvYcCUX7XpmJ1hNvKPT6S2MIHb05uJmKypk/PTjZpeI9C59ihJD7mvRpuuGhxx6i/IVXfPgpZLBYPG+WxUd0ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jG5eoA0owzdJPfIT9cPGWwYSNHjp+U11n2D7dsxHJfKsZG60
	jRuYFo+myQIfgiBqvLOHfNrK1/3yj8mmMjAvuxN9oyuasg251dkbHSlIJPxiumtbag2HQaBK2gS
	NtKcOvqq/CfCMrc0stZUaFfMbMh/bcs30Y7fuHUJp
X-Gm-Gg: ASbGncu69pmR/XyOOQfhP9lo4GiiiPhgmfCrIt9wvnj8nyyB9VleMIXfrPXO1PL3cpN
	ekDlD64xVce3xB5siL4a3SCn5eKzZvxRq/2KJIHmi/67hf5wAOntK/QttgMUkVkTY8OhMPeganL
	5ILzr25gephmBGRSkTzyfwEsswKZIlvFPwvzngIp3ae1zuzE2EmKW9FB82rakomjDEQfD4xw/bW
	ZH6pB4ULp2Hu25TtdvRqN8UBlzkwrhMEEaZlF6wDAeJDPPVPdKdq4TFnIvS9mObYrHHI78fY19G
	xCpvaG4sD5dnD3Scyg==
X-Google-Smtp-Source: AGHT+IH4UAJnle8ScuJWqynVoBOWdaJhxSn6rAs6bqvidoqyAcb3/mjW+zeWXvxPSrbgnMnIJK48J8HHgBswCtIjjHM=
X-Received: by 2002:a17:902:c412:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-295fd276d54mr4970305ad.2.1762270169379; Tue, 04 Nov 2025
 07:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <5a4dfc265a46959953e6c24730d22584972b1179.1760731772.git.ackerleytng@google.com>
 <aQnGJ5agTohMijj8@yzhao56-desk.sh.intel.com>
In-Reply-To: <aQnGJ5agTohMijj8@yzhao56-desk.sh.intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 4 Nov 2025 07:29:14 -0800
X-Gm-Features: AWmQ_bl_ayCFfhnMsugNyyrAbP6HSGsNUxGOugUtPG7U3zm3zMrinB0nHoIiMMY
Message-ID: <CAGtprH9cajbGWrU9PAZWNKMeKJ9DyhoV=nEYk_DnYnR8Fyapww@mail.gmail.com>
Subject: Re: [RFC PATCH v1 11/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maobibo@loongson.cn, 
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org, 
	mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	peterx@redhat.com, pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, 
	qperret@google.com, richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, rostedt@goodmis.org, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shakeel.butt@linux.dev, shuah@kernel.org, 
	steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, wyihan@google.com, xiaoyao.li@intel.com, 
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 1:27=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wrot=
e:
>
> On Fri, Oct 17, 2025 at 01:11:52PM -0700, Ackerley Tng wrote:
> > For shared to private conversions, if refcounts on any of the folios
> > within the range are elevated, fail the conversion with -EAGAIN.
> >
> > At the point of shared to private conversion, all folios in range are
> > also unmapped. The filemap_invalidate_lock() is held, so no faulting
> > can occur. Hence, from that point on, only transient refcounts can be
> > taken on the folios associated with that guest_memfd.
> >
> > Hence, it is safe to do the conversion from shared to private.
> >
> > After conversion is complete, refcounts may become elevated, but that
> > is fine since users of transient refcounts don't actually access
> > memory.
> >
> > For private to shared conversions, there are no refcount checks. any
> > transient refcounts are expected to drop their refcounts soon. The
> > conversion process will spin waiting for these transient refcounts to
> > go away.
> Where's the code to spin?

When dealing with 4k pages, I think we don't need to spin waiting for
transient refcounts to drop, that logic will be needed when dealing
with huge folios in order to restructure them while handling
conversion. So the specific part can be safely dropped from the commit
message.

