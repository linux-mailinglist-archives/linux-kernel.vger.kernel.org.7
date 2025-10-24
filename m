Return-Path: <linux-kernel+bounces-869046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BB6C06CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AC93565CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AA8253355;
	Fri, 24 Oct 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlIhkUBl"
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524721323C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317484; cv=none; b=kI6esnZdjeGYyiTiMlzZk0ljW1zVYEJ+CUxQxCJ8MbaQ9xdItYx0oV/iQJ6pOxRVzcCXU7reQ2rAwGUyZuha64EshM1xBv3J6gVs2Y2yL1ZgF7c2XtK/BUx7OD2em+ZDpGgqsIDHFM081QCRvQNDxpSzh8/T48dMrPVcz6IiR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317484; c=relaxed/simple;
	bh=AyCi8ceycLInuxeTzsbd0fUqVkD41EQlOLgYdP5AywA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nihySdZz2jZwkrWuD0XqoSV+C4VI1UyVlSv1S09M+olZcY37e42lCIi9ZKQcfekq2kH2j9Ee1smxhduw/tA87zdBCNuFQBHa/S6nym0DbJaxsdzdFMeS22vloMIkN7WHpaxu4lhEokSC/LTv48Tm1kW9caVzPF3n424uVkAbN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlIhkUBl; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63e393c49f1so2485384d50.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761317482; x=1761922282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7cVYUStCkt8XojXZTnoP+mO2e7B0TZmjY3DmPJXY74=;
        b=KlIhkUBl43Vs5inIhb2AkP1C9vSbjTgepJHvvwvnnvV9oE938J3D2gS6c98Pv/I3BK
         jTf8XOKLOzbZYEAeePoz/pmBgcOhTWFyJ9q0OMZDae7oA9sWdUZkgVijE//gWwTdwbMd
         HpRbzl522YPLAHCwEs5D41mh9KPlJIg9VAp8VgCBQLAgqrMjrLQafwZNKsoy2oRt3Xit
         PwLZsM1L+6Mn1N6VNnsQ6VXIheFqvYz+anRw0KRpdR9fatxsTyquJ3ABK5C+5SeRZNvW
         7+S0pj0p9yAlex+z2t7Dca1fGWec7lP8UVDHv5BZ8p9Hf8M1WRnLViC4Mqm6Pw7DLsdK
         mDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317482; x=1761922282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7cVYUStCkt8XojXZTnoP+mO2e7B0TZmjY3DmPJXY74=;
        b=pxTRwAwwCDBHe5u0vJNdEdT9cLOb5HKACU7aWd8RWpMtuOYDbTidHcaCPNd4l699rB
         sxvmMLxtiT8PaUIR1gjYrCb7LZoldVyma4jv+Zrf441yZVWh38dT/nftPEX8oNLasuK2
         cPbRdC+Uiyq/T7xY2wnoSt4JDZ9vPq8tz6XKsMxpvx6FRHXQFfuiwlkxO9R6jzO9ymya
         FZHwp2WXDBJtSK6BEW3U9M8OGKnsmDjhcJ5HxJsSqCM8wsZybQxWoGnHZ+36YVsVsGPx
         Q626Jvz2CfCT26aslcnhNLTyQ/19gubUViANvqkfO6lJn2AhLBbHjLodls0uq95jxhgx
         PIrA==
X-Forwarded-Encrypted: i=1; AJvYcCWGPYEZs79DE+Q84wQ8HK3Nm9rOflUn5am2j1sAh8FSfVK0dzIn+ixA8Ye3MKMutMHdPJduc+p08JJMbZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKcuMBh09IdUEl9+xMcyWZnf6IMH6HoOO8VgUYuJsDMtWeu0K8
	yMpbFDZrOA0/Ccq2xceL5V73VdKHP04mZg0yiY+D/EAQj9TfqN+ngd51
X-Gm-Gg: ASbGnctWw5/Vb1H/fA0Jg63ipn972qQr13/pawHZFVuscmo7nUG4i4xCZxxUBtnHMoC
	F8Jr2rJElEdef9nOuYeAF+rRnQdWECjtCe3xIkOFjXi2zyvabpRR277zL2J6guoSvzTRW5UUmqx
	TKc3E24vsV+4KDx1b4NmaoPZzUINJ4XU6ln05Do5TqAlLWTUgAzLqjnRokGpfdWAeanOKZhQEoJ
	DB2a+Ykr2rFUDcbl3I2up5r1OZ0DDgI83IKVjd1BibLiOS1OHcp6cTVV1KFUpSpsKmHVHF9oITJ
	nGsYguQWqAg4IXaJ/uhL2KbmJteHS5D0VgjkqaTeuOXb1O4b/I2cQs8zlj5vsCTEvJbosu8j2+e
	h+B/mXpKbmfxL65Wl5ATGW5B5qYPI8oViHF5HOifzDdzxbAhODBlp9kZYRzcCWmZ8csKT33bnAU
	PKvlf8F5u7NuPOTL2zvFlV58GBhOPITmtG7FBCHB2YmT9C6Zy3ZoN6Cg==
X-Google-Smtp-Source: AGHT+IHS99RQ+Ik6Il2kKRu5h3zUT8L58Aq7Sm1DcaM2mJ2uG0hFYk6S8DWLpXd612k7ltj6MQYkNA==
X-Received: by 2002:a05:690e:4108:b0:63e:3099:df3e with SMTP id 956f58d0204a3-63f435602c2mr1919452d50.34.1761317482101;
        Fri, 24 Oct 2025 07:51:22 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f37a37d7dsm1684312d50.21.2025.10.24.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:51:21 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	vivek.kasireddy@intel.com,
	joshua.hahnjy@gmail.com,
	jgg@nvidia.com,
	nicolinc@nvidia.com,
	nathanc@nvidia.com,
	mochs@nvidia.com
Subject: Re: [PATCH v2] mm/hugetlb: Fix incorrect error return from hugetlb_reserve_pages()
Date: Fri, 24 Oct 2025 07:51:19 -0700
Message-ID: <20251024145119.2315897-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024094240.337630-1-skolothumtho@nvidia.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Oct 2025 10:42:40 +0100 Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> The function hugetlb_reserve_pages() returns the number of pages added
> to the reservation map on success and a negative error code on failure
> (e.g. -EINVAL, -ENOMEM). However, in some error paths, it may return -1
> directly.
> 
> For example, a failure at:
> 
>     if (hugetlb_acct_memory(h, gbl_reserve) < 0)
>         goto out_put_pages;
> 
> results in returning -1 (since add = -1), which may be misinterpreted
> in userspace as -EPERM.
> 
> Fix this by explicitly capturing and propagating the return values from
> helper functions, and using -EINVAL for all other failure cases.
> 
> Fixes: 986f5f2b4be3 ("mm/hugetlb: make hugetlb_reserve_pages() return nr of entries updated")
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  Addressed commenst from v1. Thanks!
>  https://lore.kernel.org/linux-mm/20251022102956.245736-1-skolothumtho@nvidia.com/
> ---
>  mm/hugetlb.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)

Hello Shameer, LGTM, thank you for addressing the comments! Feel free to add:

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

[...snip...]

> +		/* region_chg() above can return -ENOMEM */
> +		err = (chg == -ENOMEM) ? -ENOMEM : -EINVAL;

And this looks much more elegant than the version I wrote : -)

