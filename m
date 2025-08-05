Return-Path: <linux-kernel+bounces-756841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2DAB1BA1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1D417E3FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9EC298CD5;
	Tue,  5 Aug 2025 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeikfEJm"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7AB2949E0;
	Tue,  5 Aug 2025 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418702; cv=none; b=mRL4600la9psweL06xuPXf8hwbMO04GbN5f7utFI0Yybh6oMPNmQpNdl7hWUwJu58HYZWJAzmMgVib7Dx4VsARL0zzA86dE3YGTyLTwMkf5tbzDfC6YHVJrP4JMSgEyMd9AsI51WF7TLKbKvPdySHtf8tJEMVxWVCKoJgB7gy5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418702; c=relaxed/simple;
	bh=bjc0knauv+Bmu5GSGfndO4T48Q0/DzlvZeIE5Nk+Dps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtXvjBVFuyxVc/Rc87aP9EF1PKxD12MfEr7c2Cr4rfaTtCzvldS+v6BTAIPOsZEc8XFf0qwZkMiQ2G+ImYmHQ+feAZ26UTUgf6Hnye3OyWuTKoe/LbeDqZdxldBJbwSH1xN3nbcgDxu22V3c45zgHR+7qNxu17+6ume6MJxwwXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeikfEJm; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-87c4bacb68eso86261039f.3;
        Tue, 05 Aug 2025 11:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754418700; x=1755023500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjc0knauv+Bmu5GSGfndO4T48Q0/DzlvZeIE5Nk+Dps=;
        b=HeikfEJmTs2gCAS/75ef636pcwetbQDNUQmL3KiQfsPo7goLUUo/auCQnHyhFKcBp7
         U4Ovu9Cn0Ti6Ya0wbPCB+RY/QEQd7qc1FDlIKQ+uq6y6mZBy7GzYbOUvaqLoN+aC4Kfi
         N7wQh4mtKvJxsn+WnzZ2zeVqH7kSBSGjEth7XOFGPH6iGV30S1OOZgv/qgY3NsAAaEsu
         5oN8444HVxn6h2Xg5NNBUxJdJsNwTV6yl53IQSzN2CMoKhh69J632/kXtaK6tjEzrkTG
         mPwCX5RR4IsVkRscyJfqUeN72GLfen2FD74l5qNx25ApaK466QfsaDjyv8LvUmIJMoFA
         gVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418700; x=1755023500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjc0knauv+Bmu5GSGfndO4T48Q0/DzlvZeIE5Nk+Dps=;
        b=vRXcDPRq6KC9/ML5+j3DDp4EF7jJCgkTTAtMPoPB1ddN9xJ0OBNklKeOvsWjVnSVwY
         62MgvOfDskdTu7d3drJP7wAkEkZNPwI5IUE9InjfH6QbPPZ5kCerxRw6EFwAQSKvT1ly
         WM6hGCmpij47Gr9KruMJlizXHVpS6uP5AkvqBAEB96Dk9mMYrg5PtW4UHbogNq4K8RIA
         V5BpQ/NyLjZ0DqPaVEdxQvMIqj1K71sasZtMMH/x3yOGtuKDagT4yBOuM2LICapxpj33
         7jWdvey4+xbC3LNDOoj3nL0k2wkNfHpGb36eJHRlzK3xGDwXo8OVpxL4WbCtuAQaE0Bw
         23Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUCvE+Ftd32ujF+/XKS/OZZ27Ur5OB9P2/usvsRhhoSNCb47U/xNS/lrgBvwXzBL8ky+JrM3G6ZAfM=@vger.kernel.org, AJvYcCUjG0USGAsUOSyUBcTV12sniV+KnIKWKUu2fJ2Q/gn922dDUdumDPZdKL8X2Q0CyHzgDffzh4Nn2AnMacTi@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPubnDbETuQZWSwRCPEIw0EaWbPNhzMmsmhlIrVdUWv7sUD3Z
	0OYm0JVF3igwEkuyD1H7S+j/WXw1fyBdtHZWP3g5kWzuM7r+Bg5Tdr4nwBAd3dVc8lVkGz6DqrQ
	QVYOU1NkXC5ko/++WtQ6kluXXHRvDNWA=
X-Gm-Gg: ASbGnctpLMnjhQLHzYDtqzZGYuc+EaK+Nd1vjePdwnQ7nBQNd9MblwzsjCWAm5ZX7Gu
	hnTtcWBuAGY6Zt7QHzNLsUnQyhECgTnbF8Wg+LWJqsVHzEjER5wWoHfL2EX8/Mo9E5yc6nWCWHR
	96jR6A6YPwADAmXkjtgJXkQfLP2M46p9HZH8RZWOmPm0fraGLRid9JlsNlTjQeyla/ODiSvYlfM
	XmJ34E=
X-Google-Smtp-Source: AGHT+IHG+mN7Qkf1e9Cg9MWqNuOrziaV/Yzsn/bv5ix/Y0IBuWtrVCZuKuskhq6RO1pfOyj05WB6XR4XfQ5Iv17m8UQ=
X-Received: by 2002:a05:6602:2cd2:b0:861:6f49:626 with SMTP id
 ca18e2360f4ac-8816834f432mr2621376839f.6.1754418698559; Tue, 05 Aug 2025
 11:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805002954.1496-1-sj@kernel.org> <CAKEwX=Pv4+nhG5j=qech3ox6CFKJL6Ox-xy_Tb+cyyXgZU1oPQ@mail.gmail.com>
In-Reply-To: <CAKEwX=Pv4+nhG5j=qech3ox6CFKJL6Ox-xy_Tb+cyyXgZU1oPQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 5 Aug 2025 11:31:26 -0700
X-Gm-Features: Ac12FXzPb23oAQJzLJEHmz2qXgO3Ui0nt3GuISZT5x069o-WuydMv99Uh1UWt0U
Message-ID: <CAKEwX=O-_J5Z33XGfUOJDBk8hOsBkgUpDhHMM6rPvP-cu7QASw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 11:25=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> 1. At store time, if comp_ret or dlen =3D=3D PAGE_SIZE, treat it as
> compression failure. This means: saving as-is when writeback enabled,
> and rejecting when writeback disabled. Basically:
>
> if (!comp_ret || dlen =3D=3D PAGE_SIZE) {

Again, comp_ret || dlen =3D=3D PAGE_SIZE here. Not sure why I kept making
the same brainfart, lol.

