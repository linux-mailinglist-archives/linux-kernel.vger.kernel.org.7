Return-Path: <linux-kernel+bounces-738079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F774B0B40D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26233C0DA8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 07:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEED1D9324;
	Sun, 20 Jul 2025 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvUc/qfo"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A1EAD23
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752995270; cv=none; b=K/jZ3sFtZXeZROk+SH126/65SUqzRX256ZLumiKtrx2pmVcGLXH3k2AsfKbqdlAKJcWcRtTegBIIwTbXIbzzlp6qBJ7YYDBFUn3Vtm4d2c/I2GqFNgYuaZ29SKO1Gnw7Bg3LE4rhWoU+wi65kCmGRejzr3LORiP+WgVyh22r+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752995270; c=relaxed/simple;
	bh=/F69goocamjNSBQ8xE06gouT1XFK8jNaaWfSihPXDFQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CeScBn+BuaEEZNdeqfDidk4PFihGsFktADOgZ4iuXh/aDWkgyCzaLcGxeqGvHrMFtGn/eL2O5xl09OJnEgWCKOwH8uUYnbxqLuPJIUZ7OYoX6r91373chTd38lGeM0CUyjNZckf76cDNmHC/5+LitmKbgXmeTzByM4o77JkbeUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvUc/qfo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235e389599fso161705ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 00:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752995268; x=1753600068; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n2upVjvJq5SLE+bkDu01RShUREryPEo+swiJyMoWdds=;
        b=CvUc/qfonf55cX16uUPNfn56G0sm/xD2tehTqqOoELMq74DNGRoX0DnXUb5RKGYk9B
         LjdmHNecY8kariknQbBLh8/AfMmnyyki75owW+Ddtyxv+IXQcm/nsl7irq/AYhRYIthV
         KJQdIRmWZWba6z+SMz98giJ4kymBUh1JuACGANZ5BD15+Mr5aaM6m/t5UT+O0cUxBbap
         oDxRQQPHJjClCn5l7tEDcbD4ipACd1g4nfdWHLq1QS41Ndrb4isWpZhDehxjwb+wQE4Y
         UgdqrOAmnAWkcZDBbdVQdpAM3aPRWytj/01UXx80/gOBcD4D0i6F5X18kKskjbxIuBV6
         hdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752995268; x=1753600068;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2upVjvJq5SLE+bkDu01RShUREryPEo+swiJyMoWdds=;
        b=Q7BpU40x+tKygImqRqYNaV6wliX/z6YNJq4HjCVKuK1tCHIFZbWjQole/lpoZjgCXZ
         bknb4/hHVz4X0dYtAFvjg03Q7kQZ5Wv656w8sJjJVS745LXhixtHDCHa7J7iFXi+IPMs
         Z9qI4QZbows9GKitBNZ42XtX0wrhVp4RSfVJ54luElgw8VVv9rUGi1zw9vOwke/igw8q
         NkO/ERI7unL3lex76Y3fk1bbt27ER+9guLMSFqy09FF5FnwMvsvrEr2bHKDP5J4IuQ5b
         RoZjplH+jkpLvUX05gF9PmOEPXeV373rvN8GXCiZJPbZ5QodFHlR9D6NNF6JFXw1Dq4z
         p/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXp7lJ25BSRQHZQ01//k1FK4kKEiWub0kouvcEnDntcBNHkeDr6g2mKPorq3R9LYNrAPydRMXdlVkbSrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0PPkOaOiqMBc92CePsdZaFuSY5Efo/CCntIQQ6fX1oBlgnfC
	TvSzlE68JtAsP/XeeDXPMXRIs6GGZ2qCrq0L0rKj5lcAQsJar1MkkvyQi5W03epoZg==
X-Gm-Gg: ASbGncvmNbavdT3M+xiFSirIzzPT93Y7lwA1sGufsPdkMmbVB+DUCwE/SKKN5rb8hvx
	cN7ptgL/6/8XS33H9KBr3dSM/s+BoHFctqyVrDWrSNTpAK6QyN9qVBH7/7l/Blt9EfR0vJBHYMs
	Gw4EByhdzTHhPUEbgbKrHf8PLc/1HeXl/rXDOoa+pXU/Pm7y7dV1blA5cmgXLGDV9KtDkFl0Agm
	fgJqAaoVWQ5SOvs0fI4ebNuZunmxqTzMjShfjV3Z+ZiSSzdEbumq3ESYzJ4we4+Tff1H0iW0rHn
	gwotvzjNdF5jPOf7mH/wHjlk6QsAxqNNY+5UpVDd9/NPahkb7Xl8w0lY7M54W0ZhOYQ1A/OAGX3
	TH/bg54cvVBihGf2RmIo4le72qLHDgoZcJLXTUzjHGHoloPTytGa1+VF72IRe8j0secSdZGRTey
	MetKqRGJDb1KW14mXR
X-Google-Smtp-Source: AGHT+IHy6JQIURJS/barARv2M127oAAAadSoPvkJVE+B2/1VupJFK0omvO31vATK6JkfK4O2ekGwPQ==
X-Received: by 2002:a17:902:f78c:b0:235:e1d6:5339 with SMTP id d9443c01a7336-23f71db7bbdmr2260795ad.26.1752995267815;
        Sun, 20 Jul 2025 00:07:47 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:bb44:24b7:f6ea:9972] ([2a00:79e0:2eb0:8:bb44:24b7:f6ea:9972])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2d63sm37776145ad.27.2025.07.20.00.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 00:07:47 -0700 (PDT)
Date: Sun, 20 Jul 2025 00:07:46 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Hugh Dickins <hughd@google.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
    Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, 
    Kairui Song <ryncsn@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
    Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH mm-new 2/2] mm/shmem: writeout free swap if swap_writeout()
 reactivates
In-Reply-To: <5c911f7a-af7a-5029-1dd4-2e00b66d565c@google.com>
Message-ID: <1d0cbd73-7e4a-a85b-001b-b734d0cb5984@google.com>
References: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com> <5c911f7a-af7a-5029-1dd4-2e00b66d565c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 16 Jul 2025, Hugh Dickins wrote:

> If swap_writeout() returns AOP_WRITEPAGE_ACTIVATE (for example, because
> zswap cannot compress and memcg disables writeback), there is no virtue
> in keeping that folio in swap cache and holding the swap allocation:
> shmem_writeout() switch it back to shmem page cache before returning.
> 
> Folio lock is held, and folio->memcg_data remains set throughout, so
> there is no need to get into any memcg or memsw charge complications:
> swap_free_nr() and delete_from_swap_cache() do as much as is needed (but
> beware the race with shmem_free_swap() when inode truncated or evicted).
> 
> Doing the same for an anonymous folio is harder, since it will usually
> have been unmapped, with references to the swap left in the page tables.
> Adding a function to remap the folio would be fun, but not worthwhile
> unless it has other uses, or an urgent bug with anon is demonstrated.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Tested-by: David Rientjes <rientjes@google.com>

