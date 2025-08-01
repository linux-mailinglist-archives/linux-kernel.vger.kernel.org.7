Return-Path: <linux-kernel+bounces-753594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD62B18509
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E514A8198F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4B9272E7E;
	Fri,  1 Aug 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmGrHBPS"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A8326F476
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062418; cv=none; b=fivEoxHaQ+2qkB3Mh1E3xr28NdOfVquJjY96DSBkQneXyJeKAEQkwHR9QB6zfefzHy11jcBbe1KAvrtc+z3TjKXvJLEwMF5GF6GkyIX35OCikTku+b6ATWDaCy3WB7cn6wfuhjhT3VtOnJmjRfZLpueCkR1DI5ULV7kFQTZ2yTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062418; c=relaxed/simple;
	bh=Hlg5IiIUSg37cw8hEXFqC6WPT7GHYQIYrncw2fqeeFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhaH5ii3ZZctbVpmWcFd3FkA00ftca9fxijiwSlmLgVw/tIUtHiaVFHNl2DpAwrJseRpYemTnmJyRKnP9IkbqTlxOfmv3JWW0PTu9JuN5Is1yPy1U/iZnIwME3p/kMSyOigOG8cxuRLjE8A3VB1FhT6yu2D1cAPG56+dn/Rg2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmGrHBPS; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso481671cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754062416; x=1754667216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hlg5IiIUSg37cw8hEXFqC6WPT7GHYQIYrncw2fqeeFs=;
        b=pmGrHBPSRxXBV1OSQ7R6Hr0nBWQrrtE3INbqCauaijfJpLKw/GOL+eHypTKyS8G+dr
         VSc/4oXlN7WwcPY0ZP+t8XGkwIYqn+OT+YJusKYEB6fsuYgU/I2la2+vSbpgCbAB9H6Y
         rHhG7agLldSS90BG1kf+ASUt1T+fYncjKBN4NN6dXb2Dp6fexe+xhupgkbTOgmFv2D27
         EfFIbZ/xwahEBaGu6bHXZsuwJjKDSBkm7jE3nj3vCVrYuT7oFYOO8JPNEcb1Qkns+XMj
         b7ugjf13JV86x1/MdFyBlptOmPQkSd+zFoIRtFvAD/0UY1FY8dd/J8bXuD7yzN9lrHZk
         zpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062416; x=1754667216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hlg5IiIUSg37cw8hEXFqC6WPT7GHYQIYrncw2fqeeFs=;
        b=Nu30kiDtJsAegFyBMabkQE2YKiIb9xLsjcRCTsEUtPsmltutnv2sjmgLTJFODjC+9/
         zHL/bWtEM1FFiQDMS3fO7Qx6x4i+mZ8RWM0WIkAaZODjIRzkeZ8e4QHMrRR5V8+70oTs
         FFjHDorDzAfoWAefE42oUuySPY2VGBQuBEnCM3p5SupdZ1FIqU/giTXVDBftM5sFF79a
         SF0VzjYyKEMzaCY9sUnRW3ALPowE7lZPn5x0gejaY4iYPM0qZPKZOK0DaKnY+G+q7S/4
         CRVASWf+aC+JWYL/yJJFRvkNDoPLkjQgpPu8XFj+xPDmc6LxN8DcQONuYNMKp4hZTjpX
         Pbsg==
X-Forwarded-Encrypted: i=1; AJvYcCWJTOoQfGfR3oCOYebtlVmi3goWgByLFEWnvwdE8ymW5wh65fCaVJAXPTjRF5/xv85x7Q1QIgz6sUK1fSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwteoS3oJSZJTeu/4N0akuN6Uy3JYZCWQRTu99vzXtqOhg+YRuk
	n84ZS/l2m6xoRSQaIYPpCJX03WB9L5u1NN8DgBaWzbzQaBtWDPPMugshOLJuaG6IPrx1itJjLU2
	bLZIAOCv6FQ6Y4iUrPCnHqiz/IiZ3VcXlASL6kkyx
X-Gm-Gg: ASbGnculBKwiws7r/6l5mRiWgoVAKrgtIF+1qL1su9yLfG+c2M3ktoJqsirNo8bStRx
	FWz58jLRx/k4i3C/t5mP7ar3c3fLdneNMdXkPufkUaHkYegfiDTmUxI+cAoONJe+FyC17LZ5V62
	meCNTCyR0l72SPU0z4qsY9rp2pA2Ius1wKT5KyNjFwePSQ2Ya/BAyKFbz14YgkFFHP7ThL18GI8
	PSsJw==
X-Google-Smtp-Source: AGHT+IEsz7cqbW/kEbKXp/wzbnkRSdJg8iPGlbcCDsMA3W/EALhw5TKX2XX+IJPal4VjoqUJ4+13OZd6BTyXLQ5Nvpk=
X-Received: by 2002:a05:622a:1652:b0:4ab:54d2:3666 with SMTP id
 d75a77b69052e-4af00896fccmr5243681cf.25.1754062415661; Fri, 01 Aug 2025
 08:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731220024.702621-1-surenb@google.com> <20250731220024.702621-3-surenb@google.com>
 <7821b672-eae7-4730-afe4-b72b80ac6ea2@suse.cz>
In-Reply-To: <7821b672-eae7-4730-afe4-b72b80ac6ea2@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Aug 2025 08:33:24 -0700
X-Gm-Features: Ac12FXwW-ZHVyxPhLTgiyxybxi8oKVAlrLZn75JD6yLNdxGMHYIyQEgr1Szxvd0
Message-ID: <CAJuCfpEhC77ZD7Zvg+9nqb=DAj2kufnLGpD72gXFbQ5Bbp-ayQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] fs/proc/task_mmu: factor out proc_maps_private fields
 used by PROCMAP_QUERY
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 3:55=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 8/1/25 00:00, Suren Baghdasaryan wrote:
> > Refactor struct proc_maps_private so that the fields used by PROCMAP_QU=
ERY
> > ioctl are moved into a separate structure. In the next patch this allow=
s
> > ioctl to reuse some of the functions used for reading /proc/pid/maps
> > without using file->private_data. This prevents concurrent modification
> > of file->private_data members by ioctl and /proc/pid/maps readers.
> >
> > The change is pure code refactoring and has no functional changes.
>
> I think you'll need to adjust task_nommu.c as well, minimally I see it al=
so
> has m_start() acceding priv->mm directly so it won't compile now?

Ugh, yes, you are right. I'll need to adjust NOMMU code as well. And
kernel test bot seems to be complaining already :)

>
> Also not sure about the naming, struct is named "proc_maps_query_data" an=
d
> priv field named "query" but the read() implementation uses it too, via
> priv->query, although it does no PROCMAP_QUERY.
>
> Seems to me it's actually something like a mm+vma locking context? Which =
can
> be either stored in proc_maps_private for read() operations, or local
> on-stack for ioctl().

Yes, I struggled with the naming of this structure. Any help with this
is highly appreciated.

