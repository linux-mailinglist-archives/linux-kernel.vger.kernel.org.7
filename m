Return-Path: <linux-kernel+bounces-870202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79144C0A2AC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 05:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9FB3A2434
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 04:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADE623C512;
	Sun, 26 Oct 2025 04:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYdLaxBI"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D520408A
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761454010; cv=none; b=nU45avAImSK7UK2l+PHRrPoAhxJqhEPl12F19S2jcesAl0VJ935vjr2MZJqWCSyKSUQhjhi/XsHTczG6M4OFT5crX87BEdjiWP9AD+593dYklE5q3ccLUur1n1WdvfvCB7IxjUJ/vE1Lm2i+LKi8KYEN62Fl5EmM4jp0/Cmavu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761454010; c=relaxed/simple;
	bh=iXWa64PM8hCJKTfCS7A1zELBoNL29b0VnqCANtQ0ENw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cf2pECxtl1IhMl1QArnNLFRNBT/tUmGeXVu/O3C2Ny47P0XwYI9iw7EzSEtgkFLmv+Mr7+loD9QJAxBZ6ijAYD9/5n7DuT2Rg+Fw5YE7Lxz2gf4CpGSdUEvbPhsPCfYJk2RjFvfO82Eh1upOBKM2ll29v0B/NcjFEC5QKKixncs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYdLaxBI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290da96b37fso149005ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761454007; x=1762058807; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk56zMULVnvV5vOe2VW536n7g9TcNK0rT/QUET2KO6I=;
        b=uYdLaxBIJoXKF2L86Br4ion3cW2yu34UP8S0ZP3a/yuGnkdvbbYzrOirVoxWbiOtU3
         ZeYyi7TYxUZfSf6sQCW+AyVHxTrIeJ9msI5I3UBs+dZsh8GcXstSBaDei0NbswiVRlOm
         JfUr4Ozqb3fkSRMgyOLTiYHsjXTUmqI1/AsJn/Tjg1z3AZJqVpRj4sSIEKo3JlWV/xGM
         gI4PMoWsQeG3bzAyiClUvECTCx9IlebbwuGSFcRTrS4q++SW1u29V03hwUvRB2RM10c6
         9H3DWDY6Vkw7w/xlgaQc1+YZ3moTwQZfoMrAe6HO/fMwVLZKw6G0VngnLJ6HpAyhxZVz
         RToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761454007; x=1762058807;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk56zMULVnvV5vOe2VW536n7g9TcNK0rT/QUET2KO6I=;
        b=c3oWoA4nvZQvANlYkPnFgHRjzuSrS3IS+sML+dNySbl0XTlzYTqYVOcMTTHmYTaMSi
         ug5a46Z3OlG3oUsqYQgB+UVvO2QYlYQd1dAKloZ/VSm3pyWTZBt0gdcjn/Rd6o/pAwog
         3gX07x6rPA9YndIWsB00IqFOrOn4+TG0QrAfjFLpmHQEjx49KjZ2tzHd7KRsLU1PYPN7
         Ka/y+MMrZ8Zh5iCwSlA5puxEJldiUD1+T3Yi8iRRlxrBrwpGyQTLTqoVWtsjNYBJbsbW
         hakoYlP4YOUD5auEWx2fnrQBGv8fRjpK6Z1ZZyobzrhK39Z6p7vH9HPhM8XmmK1lh/zJ
         iwKA==
X-Forwarded-Encrypted: i=1; AJvYcCUe0YjRJ5WSprSlOEKv56S6Imx7BSKeaWCLUUdqc7he+f+amN/XZfxVE9x1B4NYRPVullsO38r/E6fzm4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz7IX3h9+0YeMeOcMo0N2An7/4wwjXqE6RNn5ErweuiViM3Saw
	905Dm5bqM9v4naPBiJWeA9LJy2nk9qLngBKZiAno1UlpuTVFHshEJXTWA0zu+v6IBw==
X-Gm-Gg: ASbGncsCD40qEGr658QaVUZ/9ECVP2ci6nMwRBcoNf2U8WbN6kSLbkBlGy88sxNnenk
	3adCEfrSOP/aWmzqEcT3j57yDrlAe8hOi+YQ+wfWwwWEqXio5JbK9joD1C6vz2L4QNWdKb57Qat
	ptAA9Hesf11+IVQzkFs/snh/Pwmz85MoA304i0Vd+6IinDrkR1Nl+cfAC0usue3JWNHG6RPeto+
	I/HE2LtsXxOJ8Qs0GENnndsuSpPW1mla5q60fG3Qb3Xi6aJnwgrFSytVVt3NojOqokf9blwgD7V
	oJYDzJLQ85qGGgSYWeWIswUXdUwAQ7evX00/FD5fcoWuym9VlFfh8sWBqil+c7iaKs/iQWREHAD
	H4JPwryPX2pnDfp4osuER8vFtBluJ/ZkAGkvmWsieLf6f+ogD6waK0qlfzbFxksYrwZRk+RTcNp
	Cpjw6dj+mhB/wI7nPQ/d7H5b4h9R1QQRuobeqqJokt7rFOU2Ck6dDrjgMRkyerZQBVOME8xwed0
	Q52oQljxM8vxJizEmI3+mDPt9y/doM=
X-Google-Smtp-Source: AGHT+IFl64t4lXUYbfcSm4H8ba3t+zSzA5qD8iJDW5UyzavC2m1yzO8TojKTuIllnPQCuYLL/luJeg==
X-Received: by 2002:a17:902:e892:b0:290:c639:1897 with SMTP id d9443c01a7336-29497baa523mr4171425ad.2.1761454006915;
        Sat, 25 Oct 2025 21:46:46 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:2c09:d2bb:f03c:a13c] ([2a00:79e0:2eb0:8:2c09:d2bb:f03c:a13c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4aa5sm39074375ad.13.2025.10.25.21.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 21:46:45 -0700 (PDT)
Date: Sat, 25 Oct 2025 21:46:44 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Gregory Price <gourry@gourry.net>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
    akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, 
    mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
    David Hildenbrand <david@redhat.com>, Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v3] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
In-Reply-To: <20251024192849.2765667-1-gourry@gourry.net>
Message-ID: <6dad209a-5dd5-546e-a8ad-e8b720955e77@google.com>
References: <20251024192849.2765667-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 Oct 2025, Gregory Price wrote:

> We presently skip regions with hugepages entirely when trying to do
> contiguous page allocation.  Instead, if hugepage migration is enabled,
> consider regions with hugepages smaller than the target contiguous
> allocation request as valid targets for allocation.
> 
> isolate_migrate_pages_block() already expects requests with hugepages
> to originate from alloc_contig, and hugetlb code also does a migratable
> check when isolating in folio_isolate_hugetlb().
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>

