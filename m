Return-Path: <linux-kernel+bounces-737666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB14B0AF16
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9321891786
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B41238C23;
	Sat, 19 Jul 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq0pnbf1"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5B22DA0B
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752917263; cv=none; b=Ly4iEhwUPZah1+xFQi6khH13H9ZI7eKZhY2+Oot8bJuLp5UMgWWdMXxePqywi+8Iko/mMIVLkE9mvKkazd4XHD5beOA65cbgxVHHRGflPzCbJ2TabBnRfcLzxrGkBVlI6ORhklBT43jq7bf/e8GAB1Qf7D7CMXel+G5waD5s+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752917263; c=relaxed/simple;
	bh=nyokRy0+G2souZrsCqB5DwSPvPzy28wDE1HvAPamzR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hh4Xq/Rt8aynEjv6Hvqae8oHv5y/Wx3I4AXiipnHcoK/wu3BAHo4rC3RIIsylmte97cHgEtaSPIaEq+Eu1F/Hk1kztXIDmUitBhReV0cEbj+daIKFxwy9TLxHLTF3oLlLKa+i2Ikzy92aVrpax0SJ0pV0Ohrj0MavXehy5bTt9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eq0pnbf1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4550709f2c1so20867835e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752917260; x=1753522060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqWFgJChad3oM9bzLjXHXfury4l1/Iqz4njVutsiJGA=;
        b=eq0pnbf14Cu95u4w/dHKQccx33hJSvDVw2SER62CFPdIBsUwx/Ys3Bw0SkD3/MnOZw
         XWPy9fMx2JtAHAKPuhGyIeSAcr/zjCKOE+04KC3j0Ts9oDLc4p33Z8s6SbZtdlzdIqKA
         Q1lj/f0cwr+neCFu30/a39Z2OoTSyDWrAMUnoxrO3HHmsbNMD9/tYhk4rXtAXBG5ywvl
         xBNW+BCLzJQ62AxpfRKOhpfqsmUJkXIWzTmlCqTucoQ33gGLE4/7WGQpyMRH5UEBXkRb
         bNMMBqT6p3FLDfCI2r0WToyWD1a238LrR3eL8017BTD/+6Y0B2OOXSJCRZihX8uKM/F0
         wbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752917260; x=1753522060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqWFgJChad3oM9bzLjXHXfury4l1/Iqz4njVutsiJGA=;
        b=r3u0sn8gy8eUuaVtslFr2P9D1+CCU1dfnMaBcXvYMcDg5nkD5ee/DSbVKWVqk1KZ+D
         nJqSF5mUyGTA6kD0t2H4gi81Tk+PerhLJIOT89CcoCCWKJ91aHKeRGTlX2IiRNVLIF36
         rCPb76j6BcZUFEtThA4flwkij9zDjHyC5BnNiHGDnck7fLNZ/ROeNNHA4zqJmZaf0Prx
         WwCEyj7yjIPBiEbo/N60+I7EIE9GWZ0hK6e9ngYs9s1ibAqL9ZlS+9En2uBnR6QSwEyt
         X6Q6OqNn2i11eOKgFzAELyhxYESL+uxv8Fu9gqkv5I2j+eJgXOK4NVt4InW9SFvE0Pg7
         EMIA==
X-Forwarded-Encrypted: i=1; AJvYcCXa6aqooCkN+nH/d1NbRtgpveBQvK53PcPN2ld9dEnW3SizfHFfXWtIAWf0bKKb2Wzsg1dXMUEghYKk5qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDFYe52k2vShM6i3COxiYvR0fSpyDFOeuYrlsHr1SYwziY0taK
	1VXHLA10D99OouaulUpeCqsb2qj3ZhiQvbHWoprXK8iOf83K5lcuPt07
X-Gm-Gg: ASbGncsbeeIPScdDMm+nTvj7ilKbeYDtF4n3OD1ofqYBM6txaimbPuUJGphyvOCU/63
	3Hb5E0ut2B6xf0GnvbjuSVMDquIwI1Laq2Q7rpPZ6Eq+APHhd/ef6PSfZrnGHBjAbt0uz/tzN2F
	52Rv02YHz/kU3uXHGzV3A2q9vB3Hv4bP8k41prRFEjw9CJtpDKienv4B3wgVqgOzMJ8WK5RSP1y
	cSReY4gh56MntPKP7H4U0ifMMp4PSQd3K3Fe5iulmh3r6/apxeYaiSQfRYaoboPSLe7TeVTL6k3
	L4qa4Ctp7yxJaxVb592LfX8RLpxk0tVUmODFiPQxKqjbEvq+FsdlwMyapIKAGajQvkvZ4vPF9Cj
	2Ngsi+MEhXmdiHG/a34JwX2XZ91pGhWo9JwRYib/zQGCWWTBPlewplnHBH/3+
X-Google-Smtp-Source: AGHT+IGX36BXd2A2fUDV2jwsQJj5QjbGyvEmFdXGMYvz8lFtHEC3xlgD+mRYMrJ3Udq/9Hh5u0V7oQ==
X-Received: by 2002:a05:600c:4e8e:b0:456:1b8b:b8ab with SMTP id 5b1f17b1804b1-4563b8fca24mr60612325e9.30.1752917259983;
        Sat, 19 Jul 2025 02:27:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886286sm104052895e9.26.2025.07.19.02.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 02:27:39 -0700 (PDT)
Date: Sat, 19 Jul 2025 10:27:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: wang lian <lianux.mm@gmail.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, brauner@kernel.org, broonie@kernel.org,
 gkwang@linx-info.com, jannh@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, ludovico.zy.wu@gmail.com,
 p1ucky0923@gmail.com, ryncsn@gmail.com, shuah@kernel.org, sj@kernel.org,
 vbabka@suse.cz, zijing.zhang@proton.me, ziy@nvidia.com
Subject: Re: [PATCH] selftests/mm: reuse FORCE_READ to replace "asm
 volatile("" : "+r" (XXX));"
Message-ID: <20250719102738.06b91a8b@pumpkin>
In-Reply-To: <d27e9451-8807-4c86-b2aa-063639f7801d@redhat.com>
References: <20250716151543.998b121a58064011e9ce68cb@linux-foundation.org>
	<20250717104811.3773-1-lianux.mm@gmail.com>
	<d27e9451-8807-4c86-b2aa-063639f7801d@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 13:43:45 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 17.07.25 12:48, wang lian wrote:
> >> On Wed, 16 Jul 2025 20:31:26 +0800 wang lian <lianux.mm@gmail.com> wrote:  
> >   
> >>> Several mm selftests use the `asm volatile("" : "+r" (variable));`
> >>> construct to force a read of a variable, preventing the compiler from
> >>> optimizing away the memory access. This idiom is cryptic and duplicated
> >>> across multiple test files.
> >>>
> >>> Following a suggestion from David[1], this patch refactors this
> >>> common pattern into a FORCE_READ() macro
> >>>
> >>>   tools/testing/selftests/mm/cow.c              | 30 +++++++++----------
> >>>   tools/testing/selftests/mm/hugetlb-madvise.c  |  5 +---
> >>>   tools/testing/selftests/mm/migration.c        | 13 ++++----
> >>>   tools/testing/selftests/mm/pagemap_ioctl.c    |  4 +--
> >>>   .../selftests/mm/split_huge_page_test.c       |  4 +--
> >>>   5 files changed, 24 insertions(+), 32 deletions(-)  
> >   
> >> The patch forgot to move the FORCE_READ definition into a header?  
> > 
> > Hi Andrew,
> > You are absolutely right. My apologies for the inconvenience.
> > This patch was sent standalone based on a suggestion from David during
> > the discussion of a previous, larger patch series. In that original series,
> > I had already moved the FORCE_READ() macro definition into vm_util.h.
> > 
> > You can find the original patch series and discussion at this link:
> > https://lore.kernel.org/lkml/20250714130009.14581-1-lianux.mm@gmail.com/
> > It should also be in your mailing list archive.
> > 
> > To make this easier to review and apply, I can send a new, small patch series
> > that first introduces the FORCE_READ() macro in vm_util.h and then applies this refactoring.  
> 
> Please simply perform the move of FORCE_READ() in this very patch where 
> you also use it elswehere.

Why not use READ_ONCE() instead (or even just make all the variables 'volatile char *').
I had to look up the definition to find the hidden indirection in FORCE_READ().

It has to be said that now writes to variables that are READ_ONCE() have to be
WRITE_ONCE() why not just make the variables 'volatile'.
That will stop things bleating about missing READ/WRITE_ONCE() wrappers.
There was a rational for not using volatile, but it is getting to be moot.

	David


> 
> I missed that when skimming over this patch.
> 


