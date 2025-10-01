Return-Path: <linux-kernel+bounces-838514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DE0BAF5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0055A3C77A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0B226C3B6;
	Wed,  1 Oct 2025 07:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuPMtddx"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1D26B2CE
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302760; cv=none; b=M5JVt3iNhhAV+YHPgUzeiIkYz4WaBLVine3MBP61cf057qp5920HgrAPy1xOkwuK7xC200Vnjg8Kz5SEFCGo1XPxIhMUhm/ta5QS1GIROxu+0Q/HZE0DFSewHTEvE7aXbiWhw6ZMG/ZoU7wWWzHb7PGT6/MtECRicKCXAreSqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302760; c=relaxed/simple;
	bh=L2HSfqYJ1d1CTnDukXhgKX6m4nuO8rCoGcHf7t25Q3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bN7Yh883WLogBeSgp0tq8mFIoTgV76Vwu1MOcUXveCq3Ccr20AqMrH3FcD6WYGs1sj3U6lRdcNGTMyHR2qhTO26VY91e9e6f9lgiWu0N6XGtFc1Zg3sVN7mRhIGdaZYZl6D3alv2G52w1eX/ptCUKmhQUGZSwW4Q4SjXOGsyypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XuPMtddx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eeafd4882so151385ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759302758; x=1759907558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L2HSfqYJ1d1CTnDukXhgKX6m4nuO8rCoGcHf7t25Q3o=;
        b=XuPMtddxZC3+2NgTG/4QkfsacathUsfqcXFi5enQseRHHXsfWUPcTY6N3Fmn3nVS4t
         Y8NJLZI4xtIRSmBb971HnrfCJPovZl6ToFvbl5pBZH6MPtuHDzijksEfmAthZfuVYVDw
         zgbd6gewWLW53m3qUI+8rxwAZF95r+irNo8TyiBZp5/vc7ZZtgRm6iCc6opaRigQiZ6l
         0pwgmmn9MVFW0MX04XNZFkXMEmAUgvVboRmeEN+yuF+wrlTFFn6cK3OYiEJOE6nYEnou
         DU8R4VF6fUKWziw5hpxS3AOWif8gFepWanQ3AP+mfzejeJYZnZiuQeafkEwabPac3utQ
         BG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759302758; x=1759907558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2HSfqYJ1d1CTnDukXhgKX6m4nuO8rCoGcHf7t25Q3o=;
        b=u1c3wjq4rACmhBHpUWPppZvUcHjAoBkGOvvG/LxEKJN26NuPhfpt6aOjPL8ESCT/bm
         r2k8+lxOx2CAE9pCbkHz6+Dr5AQqKtVS0/VWiEZYAodUBryJnsmlT1YmpxvO/FolhK3u
         zyFQ7E9rLhcOdmqJJpRR6MAY/n6+WvbnMJ6PnjmIqgDvYgkkFrGrQ+eaCvsM6Q0qi9rD
         FczXhf4m2P8bZiEjJyD3cZtGVaMkeQc35wrmwcrj6i8TgJspgx2jZZz5eJLWcQK4jYm4
         +/SlCAQBmQs3HLp1H43lqRFCWdwRrrlvZDQhyy8vlPAnnA4IuM41y6FMdYz7DoU+E3cb
         U7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Nk4eIFTyAvcm73Y4LDAw0t/fJtzR5YElvsXmgI5MIcgk8c5NHKRBu5Feh9mREdg4QBvTJZjm6N04I0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHh9bvdR2iIkoUk7CSRfmHB/8QSGs05mgqD/FxGjrlK1XQoBem
	KBjbKisTOpE20jffwa4hm18f75n3hOUfbEcQGaq9NOvgTtS+ZuVUhqHIpSaLBSmZhiThJ/5dSsw
	r438CsLDSperzEKhwECQjmyYa2EChq11HoQ0vL5M7
X-Gm-Gg: ASbGncuN0MpVtgFmE51IC0hCODhoQ2RwnfKyoy2FFq5K22ZoKfNVYCgx2MbMU94K0l/
	9Wy7oOAcDwkIIzOC5vSJSNAaPy4Jma/JfpMZzRrXGxVnRbheafR06pubV8twPjxOoM50KvIw6bX
	D+gwTHgPyJnw7q25KQ8X/spfu9SON7HoxwJEkBzUP6XDPg4v3+hdthu02+L6BPhZ2Kd+8Qi2QGP
	/rR5AqWHlDK7x8Wdh6cVNOAmmIQki0F+SmfpsSp7Fp9dmeelNkIIYdurgKjvAEEFXAl4Azx0BxJ
	KQ==
X-Google-Smtp-Source: AGHT+IFKqalmxPPvbMf8gFFBYBwD3PuLwLfacEpGwfmVbHR7x+xhXopvFQOtlxwKsWCLYK7vchRDPFO/yKXEXrAzbhw=
X-Received: by 2002:a17:903:144e:b0:248:f683:e980 with SMTP id
 d9443c01a7336-28e7fdd3e70mr3595135ad.2.1759302757663; Wed, 01 Oct 2025
 00:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com> <aNw0sNehEQTWVI29@char.us.oracle.com>
In-Reply-To: <aNw0sNehEQTWVI29@char.us.oracle.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 1 Oct 2025 09:12:25 +0200
X-Gm-Features: AS18NWAifHOvvZfxOYNmfg733w5HRL1kfD7yDfmp_AAQDacXW-pG953lY3cbh20
Message-ID: <CA+i-1C3ry07NdPFFS3m2-WoboffgPSrOASJ4pPvoF=cN8NxbBg@mail.gmail.com>
Subject: Re: [PATCH 00/21] mm: ASI direct map management
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, peterz@infradead.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de, 
	akpm@linux-foundation.org, david@redhat.com, derkling@google.com, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	reijiw@google.com, rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, 
	x86@kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Sept 2025 at 21:51, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Wed, Sep 24, 2025 at 02:59:35PM +0000, Brendan Jackman wrote:
> > As per [0] I think ASI is ready to start merging. This is the first
> > step. The scope of this series is: everything needed to set up the
> > direct map in the restricted address spaces.
>
> There looks to be a different approach taken by other folks to
> yank the guest pages from the hypervisor:
>
> https://lore.kernel.org/kvm/20250912091708.17502-1-roypat@amazon.co.uk/
>
> That looks to have a very similar end result with less changes?

Hey Konrad,

Yeah if you only care about the security boundary around VM guests,
and you're able to rework your hypervisor stack appropriately (I don't
know too much about this but presumably it's just a subset of what's
needed to support confidential computing usecases?), that approach
seems good to me.

But that isn't true for most of Linux's users. We still need to
support systems where there is a meaningful security boundary around
native processes. Also, unless I'm mistaken Patrick's approach will
always require changes to the VMM, I don't think the kernel can just
tell all users to go and make those changes.

Basically: I support that approach, it's a good idea. It just solves a
different set of problems. (I haven't thought about it carefully but I
guess it solves some problems that ASI doesn't, since I guess it
prevents some set of software exploits too, while ASI only helps with
HW vulns).

Cheers,
Brendan

