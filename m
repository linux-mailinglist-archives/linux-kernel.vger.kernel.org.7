Return-Path: <linux-kernel+bounces-792563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A787B3C59F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACFC1C8079A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9392270542;
	Fri, 29 Aug 2025 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9T7EpeQ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05263225417
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510586; cv=none; b=Urq9ZoE3exSp7VExCd0mv59ambRe/B/U0SYuWhUhosEiBvrA/MpVX2x8yombaqZfETl01dTcuCmrxjDgfeirF9vC4os5bxW9wIBKTPEnKTVdIOLI/KQEOkfXduO5WbBWo+mplrPUrkZXf2IgbVnIuK6M/ArgjkUI8ekxbX4gz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510586; c=relaxed/simple;
	bh=AsJ3SL8JMyQGm36SXu+lFPmybifDvlILkDnLi6fBeAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw+6LvKzocFgx2kzfsWEqBS0yhdfFUzT5h2f5I6CcR/PnnoNFffnq/T7AthFFx63ho4Nr3dBr/4g9xXnO5kQJlSFh1gdYBaltJ38XWmTKzUmTXK/APf+HEQ8TdqWdbnHGaiWUBTfpUATd0HRVCHuoeea2TSylZSN382OhiCkkuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9T7EpeQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-248c7f955a2so24462865ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510584; x=1757115384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2pyvu2xGKVlWNaiEYBrfW6GEFqLeb6YKaM9SHto6H6I=;
        b=G9T7EpeQyM96SDl5qUugbYznUDC2LWIQCdm2eIVBQTjzW+KFJ5LUdXzlXwMNlwY3pY
         rFNOSzZcMonkvEYoouVEyXhVBin+rX3mvAyUgGeMELrshGzIPlT6zrPurDwLNoyAC0HV
         3mseOAaiSsZQWxx09PX1lpIwQ3NCOYXOc4UTOQFLcd4i4AiunopiAp8yhhgNrgMeyA3J
         I+0ylemBLslB4oDFruIStR/1tnkzMLky9SHhPv79B9/P0ojcZV81seleVtOWT5ZTZ3t/
         2iQubjZfK4V2V5Np4x8lKqW/PE/qsFHTK2gldEWbWl8QK6KERHVWVsubZF/TgEsYz99x
         bvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510584; x=1757115384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pyvu2xGKVlWNaiEYBrfW6GEFqLeb6YKaM9SHto6H6I=;
        b=HcRm4iAmYyNtFq0FpNUeG0hDkqKWMbKWnGoxbWw2JS1Nr8Ii1D3/tjXqC75oCpn0Xg
         BaMS7+DZxs5J5FIMFCvtDQV+fSXzftN4belIeNo9Uv5YlkVK2zRIbxYMGyWI173hWmpq
         c5kzL+encAGZgrjMbC6azqjU8xO2ne7pRwKk63xzxxDALhpZ8zBIv+s+oQbU7LEfPEWt
         NDZTz37w+/rrAdt9fnhXhDdolzUF3/gNAoueMCvrislk6/VKqyOEDeDL85L5xAoy8r1T
         iimpvyHQker6Rjenb4t/g69r1V/ln9UgOdoR11AUle/3Ot6vXmBrkFmhKkBTl7GC1g3l
         kkvg==
X-Forwarded-Encrypted: i=1; AJvYcCVuJfP3eQ2pIKCkCY4eUT+jw6emrDWREtcCYmmzq7/WU1tBeSuO10qj5+SQdXLJzZjOE0modfbw0cYhqHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOj3k/tql+izuuWtQtff8hl11hp9SXHzWRZaA4T3ma1CxzGsE
	4/F3kywUr6xL9rcUhJGj/vYjggNVaDRqNQBJNjMhRsJoZ5CNBYXCA0WX
X-Gm-Gg: ASbGncvRlIL7Id0MUZFuncA+WqFhvVlNCS1nFRrXuS6PYVDlxKQZtixjuhUpfSMhORS
	HGPhnQZ5J5mweh5bDdsluh5km1bABX+ElV60awBhJgRA6K/Ilg5Tl/BZWSezlRSUh4GYmVA0pj8
	6VcJppWTAUQ7xGS67L6WS7Poglg8K7xMvtHPdP/GUH/7oDm4OZqYVq6BOqJiK3oAC8V12QDutQ+
	8vn9s6xqoajkPt2VKUyWzkpYBPeDFOR1qB5cftE1E07VWraCommw4HJDYknaHIWVvQqdrLNUfv6
	hAI9ak9HaJt5lAjmuG0urfyN/pQFhKK3/LoWm9Vz57RBAaHKVfcbWIfQWe65BSnK8IkZOlzMOug
	RPyqh3WaJZx4zv3rlwUKyydx45q7iJw6BzINIsZ9Ll/lQEyvbEEHBFA==
X-Google-Smtp-Source: AGHT+IHoj7XG0pCPW2nnB7qndBOFkXszkOLOhhVnZ6fRs9lOoYLbsN3EfLhNuZ7C+p0VkOQeRoAeng==
X-Received: by 2002:a17:902:fc4e:b0:249:2caa:d5cc with SMTP id d9443c01a7336-24944b0d1famr4223155ad.28.1756510584188;
        Fri, 29 Aug 2025 16:36:24 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065ad59fsm35658045ad.123.2025.08.29.16.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:36:23 -0700 (PDT)
Date: Fri, 29 Aug 2025 16:36:20 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
	yuanchu@google.com, willy@infradead.org, hughd@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com
Subject: Re: [PATCH 08/12] arch, mm/util: add const to
 arch_pick_mmap_layout() parameter
Message-ID: <aLI5dKVl_7bPqB57@fedora>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
 <20250829183159.2223948-9-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829183159.2223948-9-max.kellermann@ionos.com>

On Fri, Aug 29, 2025 at 08:31:55PM +0200, Max Kellermann wrote:
> For improved const-correctness.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  arch/s390/mm/mmap.c              | 4 ++--
>  arch/sparc/kernel/sys_sparc_64.c | 2 +-
>  arch/x86/mm/mmap.c               | 6 +++---
>  include/linux/sched/mm.h         | 4 ++--
>  mm/util.c                        | 6 +++---
>  5 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> index 547104ccc22a..767c5c26f9a3 100644
> --- a/arch/s390/mm/mmap.c
> +++ b/arch/s390/mm/mmap.c
> @@ -27,7 +27,7 @@ static unsigned long stack_maxrandom_size(void)
>  	return STACK_RND_MASK << PAGE_SHIFT;
>  }
>  
> -static inline int mmap_is_legacy(struct rlimit *rlim_stack)
> +static inline int mmap_is_legacy(const struct rlimit *rlim_stack)

Thanks for splitting the patch into all these smaller snippets, it makes
review a lot easier. But this function should be part of the 6th patch
since we'd want function signatures to change together :).

Once moved, feel free to add to both patches:
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

