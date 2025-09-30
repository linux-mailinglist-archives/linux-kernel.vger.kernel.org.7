Return-Path: <linux-kernel+bounces-837566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE90BACA12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4849173B19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E4E1F37C5;
	Tue, 30 Sep 2025 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B21vioHz"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D911CAF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230266; cv=none; b=BU4uLkexIdB4V8zf+8kqe7D3j1YchXivOgHuXn8OvNKDZDc6E1ZluP1gCPexor1mWKiMW9J2xpWA7Ai5jYn+RkoI83xdVk9YvB/qNe70n7Qy6pZoA6+w2ZpkNhb4VAF43YWSiVp9iFJvzAp0bGfGjBDlF/1HgsJWsd3m/n+6OuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230266; c=relaxed/simple;
	bh=YNuBjMcAcNII5wmOqu/ZT99nidyTcJ+BFMPR9FYlMbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2xBorLSJ8gwic51WrNmGo926D8ajHF1DQntFoBmrMgSszcJp0Z2aqh3+H44BAKXEiCmfnI50rbRNM3SxycuvcmJ9JcgxL7m7hXuFpJkaeAEw5WxBomNir1S9H2Wn205ZoidAWyKizWfC3RsxY5tc6TXvg8dnqFDSYr5i/O/xSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B21vioHz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3fa528f127fso4545010f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759230263; x=1759835063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLG2shrEUT3PEsVD2MKX4WEwp+11f9/xRUTGis7fAKM=;
        b=B21vioHz0k0Cgi1tEnfrOXn/Fwc+lha22Pd7wYknTPjm2zJOJe0Q5G1ymrFDu5q0RU
         jH/c8e9HFF+JfRIwB/meFM9DizCGsKsfVAMpM6C+hu9gtATfzF0v2ySTQrmTBkUrSjod
         fWQpa1hIZGktyWp8ThdFtR/oUIAhsqjupCwSr4TCvXkpG8Qw84lJRC8TMUEd10Tx9QOY
         QoeG/fGf336OGQldAS/Jhyd5VhT78q0mi/UBKfilO+zmo31Y5Ok/ftID3Joo8FUkTJxH
         hi/yUb+iTMGx1UbY32jW33b1B/CG8CG7TKVfLgpi1ebGBRFLY6S1mktnhi/rs3NKaX0X
         73Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759230263; x=1759835063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLG2shrEUT3PEsVD2MKX4WEwp+11f9/xRUTGis7fAKM=;
        b=P6scd90wLaidkMq1aMxmTseyB6pKNxqwzzJp2WWDMbHBZblvcwpMtP3ZvNntM74Bq/
         0B2i96MYD7BJtiY4BnMASl2vD8AaGtvLDeQ0aSDvl9vKiPvjqzcFUKlqWm6cQ2ciY91T
         CYBOkn8kjl+Hr28v6tn21CdLh43Tp/RnYdQu9JwkYVsjF+yFbkt+pzOHMTCGWtsNAWuH
         nOBs9/sN1j5+4jy1MSfuKTA78WnJwH3uIYlY+I+FAoILz+1NuSZmON9g18UYtATpfmAu
         8e9NxNLdcHQylKQhG9x+6rACx9JYLSrRpuGdZC+Q0MZZRzRn6E1uvat3lWuTADKHMdWp
         tMXg==
X-Forwarded-Encrypted: i=1; AJvYcCU6hsjrpXjmdry5VfhqPBYHYIfm6rcAbplHQ57ORC/J+doVY6eH9wZSpFIjIPcrg5usgdLNDQmt3VNKIHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo58pInhwsiBLR8z2WIITO/Rfen8EXZNDnsabr4AGC5rtOkvjR
	H3h5qtiiaanNaq0bUKHXVtGaLwLQdhxD2enIypGppebjw2QCPLdwVBTXYFYTfD0VGQG8ZBBYzjY
	B6ijZ6cf/yYlW3GD2+FiJtcqF1OX5wHY=
X-Gm-Gg: ASbGnctCzaCzpqfWY7jn1juDuSVyNh1w+K16N3WVBjo5kpAs1VJIHpehsALJ9S4diEw
	nFPxmxBqP2dPMz2T7rcHrhINzmfoWsV3nuuUJhMeRnbPBs7fdmT4e7Y80/pSvydaxPf8m6UBelx
	i17DEeaYlOhVx9gnQHpheZoANX1P+w+zGOVpabKH0I9v5QKa03bmj0jsK7qoUau7rw+eymdBBmh
	ylJToTuUBnrl0tW6KjZKrEocH5CluuI
X-Google-Smtp-Source: AGHT+IE1Is0PTQDKNr+NSF+nZuh/e1voDJCc644MliK0X/icVb+Svhcvwsj2c4aXKUHdH9O9YMauBVY1JShn7PqSgKk=
X-Received: by 2002:a5d:64e4:0:b0:3eb:ad27:9802 with SMTP id
 ffacd0b85a97d-4240f26156amr3686758f8f.2.1759230262708; Tue, 30 Sep 2025
 04:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930063831.782815-1-ranxiaokai627@163.com> <aNuX9wZHjOZgJdTm@hyeyoo>
In-Reply-To: <aNuX9wZHjOZgJdTm@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Sep 2025 13:04:11 +0200
X-Gm-Features: AS18NWDWMUL9dtXKS3ofmjeGZtpVuVjezBxx8spaAodkJfgXXqDAB7u70llrrXM
Message-ID: <CAADnVQKkFFxSMBi5EnsQ9-ZwcNqMrUvFM14fV8ehExSEbgY69A@mail.gmail.com>
Subject: Re: [PATCH] slab: Add allow_spin check to eliminate kmemleak warnings
To: Harry Yoo <harry.yoo@oracle.com>
Cc: ranxiaokai627@163.com, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, cl@gentwo.org, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, ran.xiaokai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 10:43=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> w=
rote:
>
> On Tue, Sep 30, 2025 at 06:38:31AM +0000, ranxiaokai627@163.com wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >
> > In slab_post_alloc_hook(), kmemleak check is skipped when
> > gfpflags_allow_spinning() returns false since commit 13d872ade8be
> > ("slab: Introduce kmalloc_nolock() and kfree_nolock().").
> > Therefore, unconditionally calling kmemleak_not_leak() in
> > alloc_slab_obj_exts() would trigger the following warning:
>
> Good catch.
>
> > kmemleak: Trying to color unknown object at 0xffff8881057f5000 as Grey
> > Call Trace:
> >  alloc_slab_obj_exts+0x1b5/0x370
> >  __alloc_tagging_slab_alloc_hook+0x9f/0x2d0
> >  __kmalloc_cache_noprof+0x1c4/0x5c0
> >  __set_page_owner+0x10d/0x1c0
> >  post_alloc_hook+0x84/0xf0
> >  get_page_from_freelist+0x73b/0x1380
> >  __alloc_frozen_pages_noprof+0x110/0x2c0
> >  alloc_pages_mpol+0x44/0x140
> >  alloc_slab_page+0xac/0x150
> >  allocate_slab+0x78/0x3a0
> >  ___slab_alloc+0x76b/0xed0
> >  __slab_alloc.constprop.0+0x5a/0xb0
> >
> > Add the allow_spin check in alloc_slab_obj_exts() to
> > eliminate the above warning.
> >
> > Fixes: 13d872ade8be ("slab: Introduce kmalloc_nolock() and kfree_nolock=
().")
>
> The commit hash in the tag and commit message will be adjusted after -rc1
> when picking up this patch.
>
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > ---
>
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Makes sense to me as well:
Acked-by: Alexei Starovoitov <ast@kernel.org>

