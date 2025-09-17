Return-Path: <linux-kernel+bounces-821805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDBDB8253A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071312A88A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC32853F9;
	Wed, 17 Sep 2025 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOS9w0Uh"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED527FB03
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758153295; cv=none; b=J6bDSY2xklJRd6B/kMyOp0CiIF1Q4E352AdqFtND3Chzp4ibYpxWBo2VfkZoXZuYaUmoSVcYwhjKpzqQK8oUNMfvC1CJNqF0tFoJW00akdyBfyuNO4MSLs4AXtHosNnc1Kri5SmJVptoGMbZJm7QVmkwERmfykD1IzB60GPHNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758153295; c=relaxed/simple;
	bh=xVqmq1XyM68IuWPFvf/CwgC6VPWqheMQfHU/6sGfhXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaJmtVNkkZjHjhV+0DH222Nl7aQieUoAiPqzLgWIkSrA7cloJrjRTLDDySca0CviS1ZhmsxeOMwTRJPePmf9wpwVWbb5EThFTkERTPQKnwRHCdW/FoccIcs/bBeIvYLh9SltBiEAV1VWYac9K3845i+0qa3biIZjOryCel6ZU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOS9w0Uh; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8276e579242so37643985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758153293; x=1758758093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVqmq1XyM68IuWPFvf/CwgC6VPWqheMQfHU/6sGfhXY=;
        b=WOS9w0UhirDrRo4jqUBGHvednn4QLzsGfLSLugjvsS9GQ3H+jVEbX78dXLBKR9Z+Wd
         iaUxras/3HIxxMtIFaxzoOWpunygyn3QhbE5PGRagHyP+TVpoXD9ZYubqFQ3Su/4Lcuw
         iNFYQtEtkgB0ZD2wrUmEXGWLtXHno7aRwed/snK1au87FNCqmr0GfxPCeQkPyqlNzJ1r
         DIwbhOJan8Y6QLg1K6Znjo689olZyOTUDAtm8pyspmL2Mn4E6DoYykVZUk3A0BR6ElF/
         /uipPCEtnNW7+zoHVddw7jZFW0zA1T1ERcyNVQtu8MYCacphMx6SPe9Akk+46Epd8Fjl
         PL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758153293; x=1758758093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVqmq1XyM68IuWPFvf/CwgC6VPWqheMQfHU/6sGfhXY=;
        b=t+JWkkxYOWpg+4PJjwGD+lsHuxRr9j55UVHFXqKDu/evc2calvW0if1WKLVVym/CWP
         6y2KPH1gc1rkKQuGo7ObNTCtmN+ReHJx8SvazWiTAU6TMk/JQty6i+ZmXzI/TEUuhWfp
         5Of8r9V1iw8ANIrvhcbatH9wsvr2UrNFIUDMmhF5egKosc5BYzCyTQDTeZhWaORtXtza
         gqgGAsy1gDBDADiruNhFdMcQZ9VbLVhsBWQGl/jqN39wr/jQPkmB5rUQOQUs7ZMtQgUZ
         2+uWqhDZWjtm2aYt5poWXazklkQkkyJKVDZq2ZROR5HtDFcKM1OO8lALIMYXQgd1m2CI
         g/Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWWxbQcJrllgU8DtcMZ6PwQoWebM3hW4spuJ2nd3LSF98Na4gZX/+W5120bhmpXEsiPTaD7bTOyZ6eNEgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn3quvNmE5ZjC2MIzbSE1a9FfMZ8sclaWFCn75OH+LFBYX7H7y
	20CGB1bF5oGr0SqEIsAcI+/epFAfD1uYlnfL98CeFiZn1Rlpo+vkSxPHbieI6vhxhBHyChxnBac
	7nlh1af0IWKeWFjHGLANMrIpsMPQ596MkUtjZ9Xk=
X-Gm-Gg: ASbGnctr9F62NgTvzwhuFYSLhaKJOB9mkE9sJ19l7Qbi6V5+pSrKJgQiSmityf3YV+l
	Xc2blagivoVjxBH7gxxoE7E4k0iSwC3DXNrRDIIgQ0A3A+b7BwPRBFKhkqn6abSrk0s7oPnLH61
	81uheykP5vTssqvgbaX8McK6YNBKyUSS9F4/a2UsI10IQnKC/FosexMOHyF6GqKoD5PmN0EKWoN
	6EeUk2vJ/XDF6rzOd7L3s1fkWUM+7F6AesAdcz/dAmfdSqLMzhI57ZS8c3o
X-Google-Smtp-Source: AGHT+IGder1j1Rwbf0cQacLg5ALStnZiI32aSbbV6lf0Xs9drtdSw2rF92r3+LPRUslUoss8jtrhYKBhZNjGSi29rjo=
X-Received: by 2002:a05:620a:4116:b0:815:dab2:1ea8 with SMTP id
 af79cd13be357-831162658a2mr458884485a.79.1758153292929; Wed, 17 Sep 2025
 16:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-6-ryncsn@gmail.com>
In-Reply-To: <20250916160100.31545-6-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 18 Sep 2025 07:54:41 +0800
X-Gm-Features: AS18NWCbKRDQhueLJq3obspsewbZg-FyKMrsp6P91o-NQiGvqOCVRcKPSrRiGuk
Message-ID: <CAGsJ_4zL2nVUOpV7aBsfHn=gS_bw6pdFYTp4G3frW-3ovupBew@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] mm, swap: always lock and check the swap cache
 folio before use
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 12:01=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Swap cache lookup only increases the reference count of the returned
> folio. That's not enough to ensure a folio is stable in the swap
> cache, so the folio could be removed from the swap cache at any
> time. The caller should always lock and check the folio before using it.
>
> We have just documented this in kerneldoc, now introduce a helper for swa=
p
> cache folio verification with proper sanity checks.
>
> Also, sanitize a few current users to use this convention and the new
> helper for easier debugging. They were not having observable problems
> yet, only trivial issues like wasted CPU cycles on swapoff or
> reclaiming. They would fail in some other way, but it is still better to
> always follow this convention to make things robust and make later
> commits easier to do.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Acked-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Barry Song <baohua@kernel.org>

Thanks
Barry

