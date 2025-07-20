Return-Path: <linux-kernel+bounces-738078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B05B0B40C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44CA3C0504
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 07:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7AE1D5ACE;
	Sun, 20 Jul 2025 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xt8loYIv"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBEFAD23
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752995251; cv=none; b=GRi/rkosL5zKcUR8DaSYUcUZF6G8HwYJkGKtWjU86WvWlOr98zFiUdp6bdq3l1qpQ4YjmGOKVXofNkV1nmE6i4hk2kL5Z9jz+S6ZWwAgtq0jVSfU48iO98mw4wheMSUq4GdqGjEfmgNnX37Xu9xm65qZn/ZIRzRe5PagyxZfFng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752995251; c=relaxed/simple;
	bh=YYg2X7L5mdaZSmhhF3j+6VxAQBmhmZwhPWgxsc/c248=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QR6CJN9976uQaBZz9DnPJ+4ZoFAYxvz0jRGO7spQEXqby2kNyWGzbsj0E6iV3hdJqzcatdkAyR3mCa7iV+NvzwnYUxN8pGb9sUzeciYgfy4OjmZonXlZHP3iG6C5WnezdS4QQAtDRzldfjK8emMSSOrn8zDof+yAraCsXaIYErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xt8loYIv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235e389599fso161605ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752995250; x=1753600050; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Omj6cKltDINOcd+LjxZrx4pcU4/bzBfskgiaVRZ4nI=;
        b=xt8loYIvqxBNQvpx/UlAy9Bv/qGvr6N8ml/h2bE1SSAwunFOmdtqkTdfVANn16o7x2
         sp3BDS63JQUo8kpWiCdpqW4ziO1bV1Vz5kRSy06pMKX/ajHB0m9ftvLuK+CY5XJSzScV
         YKXq+V8zpVSG4sO1hRNg6d4UiuL2LW8rTrjqk1j8sAcp5Avsi0xpBXNyk5UEHawGOR0j
         7ZhAAGJBVq92VQ37BnX+M2NnCirCDgyswRY5foAcSSsw1tczd3360ggODmv9xQ2OfXQN
         HWDbodF+kxR9bMecSdA0pYk+hFjIUcY9BcN2ScMSIdH8FCRp1oBpMZI6+0e+oa110/8I
         g87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752995250; x=1753600050;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Omj6cKltDINOcd+LjxZrx4pcU4/bzBfskgiaVRZ4nI=;
        b=scQ2b1pUr5e7+4IcpAuV00mJ59ZJFiBhTiNOKci0VVNrYzZgcWFMWFZSMFkpvFsi3S
         QNSHhQB4Ju9fiTkyZDWOaFmzEUSSjFafbUGq8uQpJjMSKjFOf3cyicpcFnred6kTXTJR
         F5jAWjBk6pZ9OhbKepripBgCuzj2LT1RJlul3wFxCBgXePWCsBRVFJodACSrRO3BfkDw
         9Ga6j2+G6ucVBZ9XD7tGkt99ORsPxbfSfSBOGY3r5vTDkC58QZH+jGWN4KNHXVhgpnGD
         Nvk3e3G+MERGviS0x4Smdj1aAv9rAZV85/ghxY+TwUSeKmQgt44xtVOQzHgfg8w7xiC5
         mz3A==
X-Forwarded-Encrypted: i=1; AJvYcCVcRpi0Us7jJ+a2xtzr5Q4V82VAJ8hFlLaaaw01WpHI4u1Mt9qdmf7QHsYbOBmRNkTVB4ViQqEZaYIEi+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKcOrwGS9m27F7/NfiafrycH/vmtb86KBMIhCi4TdTakZtfec
	ctYND5dWK16F71N1GiU35E+qDCxM5PfRmzBg2mV3zM/OaczeN9WqSSC1cJaHgOmICA==
X-Gm-Gg: ASbGnctW3iJtDVrzKNger8n8XBA8BmcVlU2JWVpcwIM3qmYx1Mzob2IlbG4qVQURD1x
	kzdjx3q1w38mVj8eSNyzp/5egX9MzyfpLoR2F4oyS5BwvfTJzsI5p1jlJUo59z6tR4aTahE/OZ4
	k1gFb6hYkQ2ECmKTcpb9s0a24d9oziy49aFfOZE5yeAZgUPlGxX+PbW6XX0CGlnuMiTkXJmInBy
	y+v8Pq94GsXLHYMmry9iFTVfm5eRnIWqKah53DEC0kPXZUEVioNP0fCAg0vc+hKbHNbT3Zha1dz
	g+BeQ9VxGdjsNpQFO0RT/5nbI5Jmk1m1+xgCCNAi942LHnRd665ELvVxkvgyFQpZdPaYVZRULPJ
	pJP+OZMKf3xgKNTI0U+fRP4nb4/d8CCIZ9AjzbAUPI1BVn612YxPILWhahI0oko9X8K//XUDbNa
	IKaDjTy0s2xxkOlxkz
X-Google-Smtp-Source: AGHT+IE96A4Tu2HRyclAkumC6G+QjI3lPLSjFvgKqKO6zW5rPBBd44SGMBsNN/cIaCIyyoJ3VoF8Pw==
X-Received: by 2002:a17:903:3bad:b0:23c:7be2:5a05 with SMTP id d9443c01a7336-23f72bebdf1mr1509585ad.21.1752995249330;
        Sun, 20 Jul 2025 00:07:29 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:bb44:24b7:f6ea:9972] ([2a00:79e0:2eb0:8:bb44:24b7:f6ea:9972])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef21bsm37786955ad.197.2025.07.20.00.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 00:07:28 -0700 (PDT)
Date: Sun, 20 Jul 2025 00:07:27 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Hugh Dickins <hughd@google.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
    Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, 
    Kairui Song <ryncsn@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
    Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH mm-new 1/2] mm/shmem: hold shmem_swaplist spinlock (not
 mutex) much less
In-Reply-To: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com>
Message-ID: <6c9a1261-1256-0239-72bd-a713c959ce85@google.com>
References: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 16 Jul 2025, Hugh Dickins wrote:

> A flamegraph (from an MGLRU load) showed shmem_writeout()'s use of the
> global shmem_swaplist_mutex worryingly hot: improvement is long overdue.
> 
> 3.1 commit 6922c0c7abd3 ("tmpfs: convert shmem_writepage and enable swap")
> apologized for extending shmem_swaplist_mutex across add_to_swap_cache(),
> and hoped to find another way: yes, there may be lots of work to allocate
> radix tree nodes in there.  Then 6.15 commit b487a2da3575 ("mm, swap:
> simplify folio swap allocation") will have made it worse, by moving
> shmem_writeout()'s swap allocation under that mutex too (but the worrying
> flamegraph was observed even before that change).
> 
> There's a useful comment about pagelock no longer protecting from eviction
> once moved to swap cache: but it's good till shmem_delete_from_page_cache()
> replaces page pointer by swap entry, so move the swaplist add between them.
> 
> We would much prefer to take the global lock once per inode than once per
> page: given the possible races with shmem_unuse() pruning when !swapped
> (and other tasks racing to swap other pages out or in), try the swaplist
> add whenever swapped was incremented from 0 (but inode may already be on
> the list - only unuse and evict bother to remove it).
> 
> This technique is more subtle than it looks (we're avoiding the very lock
> which would make it easy), but works: whereas an unlocked list_empty()
> check runs a risk of the inode being unqueued and left off the swaplist
> forever, swapoff only completing when the page is faulted in or removed.
> 
> The need for a sleepable mutex went away in 5.1 commit b56a2d8af914
> ("mm: rid swapoff of quadratic complexity"): a spinlock works better now.
> 
> This commit is certain to take shmem_swaplist_mutex out of contention,
> and has been seen to make a practical improvement (but there is likely
> to have been an underlying issue which made its contention so visible).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Tested-by: David Rientjes <rientjes@google.com>

