Return-Path: <linux-kernel+bounces-866243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31590BFF478
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BCC3A835D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F35828DB3;
	Thu, 23 Oct 2025 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlLE8J3M"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9FE20D51C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198694; cv=none; b=KON+mQn9ITb3NSb9XDzkOZ7O/agPJ/t6P2tUisRNdJZWKfLgIGu3WtbzmuU2gOggl4p7t3mMHd5Dh7wyzdNlAPfu9OVWijBt/DgteO1eW3KQlca5UJTV9LE7mi9OTpt/OOkufZ8T7+krBU8K6or5KJAm0cwhL9XrgzN5MYoIGtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198694; c=relaxed/simple;
	bh=trsvToJEKKHu/XmsqmtPz8jWxaj1IbQyjRyBsIyHHfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClhAmaS3ap1WLtcBLjT/0clNZhENqge9EFypx7yiccZ8RMZLgft5BBdBhtnmvMtAUc4T4WwqrwBwh/NidWlsOPV6DMWzsrPDFK9JRWRxBBJwRMFGw9VIPIwBJ3o4fS+M5kjkZ0B9wX4fpMc83qFnmXaf9lze8/vio5A0OX8ZdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlLE8J3M; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e8b4e4ce70so5180191cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761198692; x=1761803492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+c+NbgHrZN7bWRSFiex5X5KJePzhxA+ZHYyLdwSqtl4=;
        b=YlLE8J3ML71LBUjAIfM2jyecWpXrRd1q8BwQbRknZRHG8NEA4UITNNxbdQy3Wy7fgG
         tnQYnH9oCXSjntPJzj1Y73aNuD8FG4rWRhgIMQ8wAsGjeHYdNKCa40v6D2um2H94SqvC
         zYyIr+0NbHSn4cdA75isKl21HFM2ZerpBDCsnPhnE8iRk3u1Q+0qJ9KC2lmMfv1LJPZw
         9poDI6l7HsuiS9JccxKC6Nyag7R7VF+WjUXKzzIzqkcdR7JOCpahdJxVuINIY0B8Te9a
         TpcvnKQNSVB7yzCZKjq9KXuBdmZfEfT3H0NQpbVu376T1QDsbRInZ0QvMrvzRwYFQmsv
         86Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761198692; x=1761803492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+c+NbgHrZN7bWRSFiex5X5KJePzhxA+ZHYyLdwSqtl4=;
        b=PSsaQ4HJlhHV/78xnpIfK032QhgPrqATSgCKWqVTwTWRCtrsVNf4/TsOTVhJtT6UaB
         1Gxq6qgU0MQiiJKXbDCPY/Eql0efPVDp8yH8x6xSpiurPbu2+Mw0jx001Tq8GbvZIt8u
         tMjJVSD6JbYBbFWZ1oUJB+eMp9Yyn8hPaFBsVT7PxJ0p1h3qEHXaDjGz8Uonfn9suPDQ
         hY33/J6rBxVd5YyAxZrGLxJF72ktQhnmGv+BCFrIHtd9HNb2I7FAFaaDg1TDlkrhAVyP
         xJQLpDW3Fti6zV3YaJiLS+j3UaK8FpwLE/qPsKHypW4YFIwUKUxnaDHZ9yGLSvprdwns
         0pQA==
X-Forwarded-Encrypted: i=1; AJvYcCUnwtgS5TUVA6M/go2jHAF2yfNQDJTZy9iwfp9Cfwe0lnTGS1zHsCV2UEskHbcj5vOlj5EgZA4Nw3sqkNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEptHbyw+kubWFM1vPapydSJ42J1/8EoyL3tQkH+QS7irKcc+Y
	wjrsXD0o4b/W8EyxkC3KVQOmWJDCHnI0YOM3EAjMqkxBzml+5Yc/zRVARCBUUWLAomvfqt9+fKj
	A1QGxKXyC5BymDNduNuNTUR3xECKviIY=
X-Gm-Gg: ASbGncsTA14LCdgbdrNGr+w22tk+fN5m/qnlBNbgnpiSK5HpMi9uTb84Wu+0+QV1MV1
	kL9yT4Aj5Uj/rVB0MT5uqQELa9lxrqi0Wv1FzEpBbLC7OZ8wEvN2E5voueACulhUKwcSh3wbGlA
	mKg29cobizwh7gRcNnrZFpAazUY4ZrlZLlccBSrRRtmn1mIj3Z3PoKuEKEb4hTvBeTjXcapSQZA
	QEGwfgGX65CHkAILNkEtya2XZ7GPGsm51yLHLnS6Q2QW7pMOLgWIJiYAAPeSTOILj0D21g3dEcp
	kfPQP8WtNwHfiy9+
X-Google-Smtp-Source: AGHT+IG2Mi7vqdQCnyt6kuAmhI1WiYtd9JowlwNahGI5Sn/aHmlC3Vnbemadnf9/Q0GK32HOEsS1UsxfrANhNicTuQg=
X-Received: by 2002:a05:622a:8d:b0:4e8:a621:7912 with SMTP id
 d75a77b69052e-4e8a6217a5fmr273669031cf.84.1761198691860; Wed, 22 Oct 2025
 22:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022105719.18321-1-ryncsn@gmail.com>
In-Reply-To: <20251022105719.18321-1-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 23 Oct 2025 18:51:20 +1300
X-Gm-Features: AS18NWB1yQIOT_rwx8pqsyu31KsQcKncmHw5kIG8Uc-XrpaBEO8kE7dzlBnI0ZI
Message-ID: <CAGsJ_4zKcxO-Tacy0jCZSs83+fGsgqQYNib9nCXoLTuL+hdLxQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/shmem: fix THP allocation and fallback loop
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Dev Jain <dev.jain@arm.com>, David Hildenbrand <david@redhat.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Mariano Pache <npache@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b50ce7dbc84a..7559773ebb30 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1895,10 +1895,11 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>                 order = highest_order(suitable_orders);
>                 while (suitable_orders) {
>                         pages = 1UL << order;
> -                       index = round_down(index, pages);
> -                       folio = shmem_alloc_folio(gfp, order, info, index);
> -                       if (folio)
> +                       folio = shmem_alloc_folio(gfp, order, info, round_down(index, pages));
> +                       if (folio) {
> +                               index = round_down(index, pages);
>                                 goto allocated;
> +                       }

Could this be a temporary variable to store round_down(index, pages)?

>
>                         if (pages == HPAGE_PMD_NR)
>                                 count_vm_event(THP_FILE_FALLBACK);
> --

Thanks
Barry

