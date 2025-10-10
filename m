Return-Path: <linux-kernel+bounces-848398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A893BCDA63
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111223BAF03
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A52B2F7471;
	Fri, 10 Oct 2025 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bFoqyy02"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BCE3D6F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108320; cv=none; b=Xb1UaXCrLCnyuus6s9oES6KKgaCOP1B2BrzktFaxlVTAMWKXDoKValAJQvYlTXUcBEahmlXpzuyiQqudZdun2ZCiTyLgr6CMKNGKgV9vkdjwWOROhgzjfbggRJ0Wra6OQmWRauY57dH/wyuKrcdA/wb5PixwbDpzWklRVjRSGNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108320; c=relaxed/simple;
	bh=O/f5MiBij3IECEF2d6NbqhVZBoXbyknaX3YNy+v2jBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BElVDR8dtjr09qulPrkfPm8ZymlGDZhEZIVdG/3qoE8eawh79b9NlBREUEx0q43T4440DD6AeEZLLf4I8VqlIKsa2KRxRdVndEsueCLsUsltMVLS2l504kroqo79shnHtFybLFXeupi41NCpbhWO+CR4PAGbkdnLufDpBRozMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bFoqyy02; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4da3019b6b6so19869661cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760108318; x=1760713118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/f5MiBij3IECEF2d6NbqhVZBoXbyknaX3YNy+v2jBg=;
        b=bFoqyy02oYGr/LuWsFyi0W5Ej8pKXhjqyohD00Z5dbmSNvYpgSVewN3J+q15yRc6ii
         69LaSyM2tnR+luiCcl5eZPTkuEaxMlBkiqscmQBocaCErkJ/8uoJ8JQzcs/JRWsBs492
         ZgPrk5u9q1Nk7hg3EotW9qKnKWO2J2gL22sOWZM97MJcIR6WyTyUXzhBNsJN5wICsyuR
         jr0+y7OHElysr7a1Coplm6vDUbPt5vsBjlh30Ozonuo3yKa9UDglFAxvSAn3SFNb9k0+
         iE+F9gR9VJLEooADnWPNwfzCIFrP6cM7wD85seJ/G3+4aKMou9VK6t3t4TxBQuuxR0l7
         xq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108318; x=1760713118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/f5MiBij3IECEF2d6NbqhVZBoXbyknaX3YNy+v2jBg=;
        b=TR9I+rbHGoi4XWGW9QhS5yUTsg0sZs8Of8vI9IjMsed3HlJSoFzxb5igOj4S+c/LwB
         iqxdE30kPvFVw/keF+1sCyx5rtiTIIUoF3GUHji2QvGJPLobSiRVJNRXexc9WqMbRItQ
         Lr519dIRaHzwty+bu2vaoxVAMbIIUkUGTchY+B+etVRcxPksOMwdgM8mYpQVjugNYfWc
         JE1w/phzW3DHlORmlLxuFyrs+Imky6lrW+wg8N0A17mvDfwDhn7GKy2v2pn+fXkpXKjW
         JVKOxcU5A2F19+A/BVNjkRCjQUFIqptu5I/aHq+zk06FCvebkLYiap+D7acBkyqb+ejQ
         /WLw==
X-Forwarded-Encrypted: i=1; AJvYcCWI/cWNQ7j/VL4TzicMbUR8VlrlRgtVt794jN1yQWxMchyFO7W+wMsBhXT2ekOhM0UO590fm4w2JsrrbvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP9kLIds3xGwGAGf7ukJyUJ+M7BFtdzIk3NYoYWFbUOzgbhesR
	1TEih/eVMIivpAD0UnASnWut4OQmj+MhTxwGO7F9GxpKDAmPppwdeCwxK+UOiUaAQJ3vr8pWBcP
	bPogA85+DyGRiQUBQ0x5FeQVmwdhRxbYplktNoLFlBA==
X-Gm-Gg: ASbGncuiKcpe7KQpv1uJXEKuGZAXp3/ClrNZSjbdrpfiCqvxssmmdaAgT8vglPuIt/H
	s0cjpour3UWsxbyuyskMus4IVyM636gFP/iAT9g/5QtIsNkbMuDkYztUhYOgldHDbmm+Q0ULyv4
	xupM87akqBgQXmzdweQ5JBkXrgxBWyzpPna8BeHNvyo66jZRXg8jlTDXBBJ0F78/dBR5got5Qw7
	fGkXXGcQWPQdIWCB3QkA9c=
X-Google-Smtp-Source: AGHT+IE0WXDhjauHLcC2POBv0t7LgQCplfzbTEHy7h2aL8mobxzYVpt1EHLlI6ZDdZuKo41ZojriIaW0+E5fBHESUrw=
X-Received: by 2002:a05:622a:90f:b0:4b9:b915:a26f with SMTP id
 d75a77b69052e-4e6ead514a2mr181154551cf.52.1760108317513; Fri, 10 Oct 2025
 07:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
 <CAAywjhT_9vV-V+BBs1_=QqhCGQqHo89qWy7r5zW1ej51yHPGJA@mail.gmail.com>
 <CA+CK2bAe3yk4NocURmihcuTNPUcb2-K0JCaQQ5GJ4B58YLEwEw@mail.gmail.com> <20251010144248.GB3901471@nvidia.com>
In-Reply-To: <20251010144248.GB3901471@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 10 Oct 2025 10:58:00 -0400
X-Gm-Features: AS18NWBORXQFPGvPP__b4olxbKs0hTzftz4XLJRMqdjSudzyOrwIdA4I2ICtXVo
Message-ID: <CA+CK2bBxMpb=jXy3-i19PdBHqxLoLrMMg1sOnditOYwNe1Fr+w@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, pratyush@kernel.org, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:42=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Thu, Oct 09, 2025 at 06:42:09PM -0400, Pasha Tatashin wrote:
> >
> > It looks like the combination of an enforced ordering:
> > Preservation: A->B->C->D
> > Un-preservation: D->C->B->A
> > Retrieval: A->B->C->D
> >
> > and the FLB Global State (where data is automatically created and
> > destroyed when a particular file type participates in a live update)
> > solves the need for this query mechanism. For example, the IOMMU
> > driver/core can add its data only when an iommufd is preserved and add
> > more data as more iommufds are added. The preserved data is also
> > automatically removed once the live update is finished or canceled.
>
> IDK I think we should try to be flexible on the restoration order.

It is easier to be inflexible at first and then relax the requirement
than the other way around. I think it is alright to enforce the order
for now, as it is driven only by userspace.

> Eg, if we project ahead to when we might need to preserve kvm and
> iommufd FDs as well, the order would likely be:
>
> Preservation: memfd -> kvm -> iommufd -> vfio
> Retrieval: iommud_domain (early boot) kvm -> iommufd -> vfio -> memfd

At some point, we will implement orphaned VMs, where a VM can run
without a VMM during the live-update period. This would allow us to
reduce the blackout time and later enable vCPUs to keep running even
during kexec.

With that, I would assume KVM itself would drive the live update and
would make LUO calls to preserve the resources in an orderly fashion
and then restore them in the same order during boot.

Pasha

