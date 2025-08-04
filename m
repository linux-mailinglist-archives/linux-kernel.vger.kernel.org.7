Return-Path: <linux-kernel+bounces-755607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA57AB1A91E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947B81883F19
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D517A224AE6;
	Mon,  4 Aug 2025 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHj+wstd"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE5D217F33
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754331616; cv=none; b=jSBF+2BfCtwysDtp+PKqffv9JolvnHC0FAfiy4xMWuT/rc5uARulfITvmUoGSyi+rA5UR5oKQZc7k4gViRj4eMYZb7W97Qu1rc/iLVCrbIZusRqckSjcH+lcwTlK7nxwjbj6QjDESy9trlFcFEP8yTalbv+aln3bO1G5kMb+Tp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754331616; c=relaxed/simple;
	bh=2ZVlhV6ndThCFd4+zGJNIWInZ4a60Ev1vYWmuIdzmJ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pg95FyyF1oCbYOzfzKvOAiPnWgSrVdrgvXDgr5XFX+wHRiokiAxrA5R7207DFqqXn0Qzqz4LRjK7g4a0YNlUTXjVnXS3OpLF+b6eDUzyGUQPKATLr6rIx2RrnqqaVa5yElppmXijkR8RIzZUywCIxl15yI3krckeL3qGbh+JE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mHj+wstd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-240718d5920so27875ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754331614; x=1754936414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2ZVlhV6ndThCFd4+zGJNIWInZ4a60Ev1vYWmuIdzmJ4=;
        b=mHj+wstdfNoSEaUBL03Z1TEj5BuQ16vVioMHTmDgflfwVVCHaFSNDKjePYsN7easB/
         ziskdoahawBNHxXARcAAZZLAj31liKAt0IT5SlEqffdnfQKskiSl7uK6OgPMjo2dWObm
         N0/rwHHiHWorLwwF1+oLD7pGR2GzmDeU0cY0GueDc3n75T7XA0oMTUTF4H3t9KZxzQYw
         ZFOJgGni/NnFNt7EGh+dREpDYsCIEiLaeU1wlrr+nRxxWAWAQXgyBSRhBTjI4FbOqBxd
         KoKdYPTBqwqwU4xhhfqjVcYdJBj3PIpOnPHEw6rAKwHYfZCXZbmT+GYVgyKYLX20orsG
         CWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754331614; x=1754936414;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZVlhV6ndThCFd4+zGJNIWInZ4a60Ev1vYWmuIdzmJ4=;
        b=DBJn7UbHdThCgKmYXgMV7qZO3Cx61f/RiEMjtljJMnYCOm4GkblxGV15yaTew+AGpA
         cSDgApxwbtaQYUVb4W6F3b5Zq+R08rfahZxFqiujRAAGuW3CNU9DrnsrCZZ5QYj7qJp0
         8sA72Rn1u2LnQdOWMGXamUQsmtFIxKhikEwAVlgV1qilotGPJbhJ1y60Z8+iQsDTT2f2
         LLJhAemqRGrd2zlviSnOe2swpZqqebSih1Fi5aynC82sOoXYcrWNDy7qsXipatr73HJ0
         iHIWjrUzmmOcJKtp6dI2jhwSk85eD/f64k4VtQGhCSIjo2TGWQtFaeOAK/K07H/2Zmmy
         xIxg==
X-Forwarded-Encrypted: i=1; AJvYcCWpGecaynWqvDW9aK8JIlFUa8rauLJsHzDIEFPlVD5mw/RZzx0j1zUkB6R/qOucolaPwkLYc2UOrmJmgz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiMGbZML8s1VoDRb/ZWkXHnSpweyN76ieFzbGy11xvdI6iG73N
	MRfaycbbvFYjLR3GKkxNsd5yms1NRYtWllqG3Fm4aEYleK7BYGMlYaLUlyZXsfm/FBpe3Ove3cd
	EOqJ+YmDg+glDTljM8w+4qxs88qSE6Xfae5VmXM37
X-Gm-Gg: ASbGnctlrOZbx6U7PMfZC314aEwtk59X8EZaKsrLjVVUyFB4+WIvAJhqjcuOTnP3ZS2
	MarrHC6WsdaNFK0WjwFH88rq589avm2wOeZaI3VqfK8rOBDQxqFgy6auX31vHFVfs6U5y91d0nw
	r0UnTSB9cBUOIsRyO7JixQjbowZT0MRG/vf9/lxxbma4kEcqBOKihvItwRyA9RfGtcYqsS+f8GU
	gslTynTkHgwf/UOSDo4jEOaBnkj8cbOX+XfJ5+JrtIqyJQFY6o=
X-Google-Smtp-Source: AGHT+IHJ3G+xP08obdX5jcc6GtOvxbQiCdbE6cUflcwsxBlSF4DjeWJy9y+0NJsLPYUHbsN86ka8wS8EBaMWAaxaFo4=
X-Received: by 2002:a17:902:f606:b0:231:ddc9:7b82 with SMTP id
 d9443c01a7336-24289f4137fmr145425ad.13.1754331613677; Mon, 04 Aug 2025
 11:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juan Yescas <jyescas@google.com>
Date: Mon, 4 Aug 2025 11:20:00 -0700
X-Gm-Features: Ac12FXzbGKN5jlyd2IPApq6ZL8_tui4fcRP6MtCL-WgGFvEuHfb0FzO73d8vRXE
Message-ID: <CAJDx_rgzkZognxWzOXJ-ZxdTtUaM3FT6bmpkwxMz03XiX3fKAQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
To: David Hildenbrand <david@redhat.com>
Cc: akash.tyagi@mediatek.com, Andrew Morton <akpm@linux-foundation.org>, 
	angelogioacchino.delregno@collabora.com, hannes@cmpxchg.org, 
	Brendan Jackman <jackmanb@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Linux Memory Management List <linux-mm@kvack.org>, matthias.bgg@gmail.com, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, wsd_upstream@mediatek.com, 
	Zi Yan <ziy@nvidia.com>, Kalesh Singh <kaleshsingh@google.com>, 
	"T.J. Mercier" <tjmercier@google.com>, Isaac Manjarres <isaacmanjarres@google.com>, 
	Juan Yescas <jyescas@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi David/Zi,

Is there any reason why the MIGRATE_CMA pages are not in the PCP lists?

There are many devices that need fast allocation of MIGRATE_CMA pages,
and they have to get them from the buddy allocator, which is a bit
slower in comparison to the PCP lists.

We also have cases where the MIGRATE_CMA memory requirements are big.
For example, GPUs need MIGRATE_CMA memory in the ranges of 30MiB to 500MiBs.
These cases would benefit if we have THPs for CMAs.

Could we add the support for MIGRATE_CMA pages on the PCP and THP lists?

Thanks

