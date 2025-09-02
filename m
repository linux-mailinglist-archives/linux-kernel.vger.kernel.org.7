Return-Path: <linux-kernel+bounces-796228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA8B3FD8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED1A16F9DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B414AEEC0;
	Tue,  2 Sep 2025 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXfTE3Aj"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895B280A2F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811718; cv=none; b=HuJvYKVtyPwzEr5SLX0nxspGdPOs6tSeyLlYh/Jf+RxegI4WhDlkpLlWSiVnPI5PzLENcnAYusUQpU8NQU4IRkAQQOBrhsWlMD4AVNpsXKARDgXWLEAtMoEbwbFqbn/5SogzX64HdSxEKF4mnwpN/qOq38IRseM8F1TrjnVdTT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811718; c=relaxed/simple;
	bh=Muuy3gEexhv4NL/zAMIombmXpD1vHKRCvPTAbu3qpWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssgWtd5tW8n9b1SpbGhOuamOMStXH+Bn2coBLrvcttIFntBnZxCTKdYwH8t8GWVsGISg/cUM5HskNreYrkozjGJT3IvhmV/wEVO+lzRTJoLrcBLJDfGP3bAApYSwjT9dPTfJZFf+gADyeDbKBUXf2AUHqNRbnWOTt8SceIUFIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXfTE3Aj; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-805a55c09aeso103655485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756811714; x=1757416514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Muuy3gEexhv4NL/zAMIombmXpD1vHKRCvPTAbu3qpWM=;
        b=LXfTE3AjYZU31FasiS7HCwK0lrouBJZJM4NrM86eCG4ZsBK2ydX9abngiQyE/gAM4x
         6PWJDe8ATknyEzr2TgFxYk1Hyg0lbIt6oUp5RAnwgTNM3ta4WsN1d+sx17Jc8Bj6k1j7
         in+2NHv9RjDQpMB1qek0Z9WvYNYMkunG/ewH7RdqVOhTg4yoxoQLfqYu/7Bllf8zpAbs
         Or1bc4HwJTieBBxnLRzdvrgHAc+ztdP+bFoAr0QuVE0KleTAk2cl45ZAejQpbJvYK/Rj
         ptlEe7B5B0IiqWy519q+BonXKf6ik8e7ZrECbeTnw0h+GeJKfs1dzCrYalNZ4TpZIEh3
         g/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756811714; x=1757416514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Muuy3gEexhv4NL/zAMIombmXpD1vHKRCvPTAbu3qpWM=;
        b=KmeOF9EFI3tYOSVKqx42uNU4XOHpOowh1deDr7y6U7mtj8PHgYon8kppWMGaJf0ncE
         /i4hR6HoVsbc6FiFQPq6YXhrG6wrWUcQuVv+SeP9EDtE+KS2rdXVxaxYGVl/AaOdV8jM
         GPcp/rrAomiqjskv7lZT9He8wH+Aqc1R85O8c7MaYh4DV9/grPEmxkkJrpIY/fZZ5BO8
         7UoK1duVjeUiuiAV316YGYh04vfld/Rmf4v4w55+IVbDgNDaBDkwR1AR9ARJKuYh+CNI
         VCNTFdqA9K5OQEt2O2xnIgRlCe/EriBl5ClXvWntZXx8v9q5HuZWay5r1I9A9J7Mz5Ng
         AADg==
X-Forwarded-Encrypted: i=1; AJvYcCVXAvGxC+F87A+d/9WT+Ve1HlnPNbG4Tr1BeGC0HthsvBh+o2YSarF4LIiLKpiqrZcMu6LYOKj2TxBagws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/810evh1LwuIKUkusWxGAxkamJYw8VycJ5Z1Em9IIEurIUeb
	bzgXyGW3po1ZOL2tbdUKiS3x+B11cQKsHLvZ5RadOcnS/JibSdpv1XcOzvVDo/nN4QIIIUGH5g6
	UV5wAZk87m5wJmK2otsyJHGr4pOT7k78=
X-Gm-Gg: ASbGncuKerHPiqGpA55f5FWdgdZc0USLC1/4l7fKHBnoIo1FPtZ2VvbdrJ2TFVE4E0t
	4E8aypiwcMz3so2rRNomJMVm4lR7x5l7IY4VW7YMnQalJIEL6HlyIR6SITz6DTRXqQfmlfMvh4D
	R0Fk7lvObBFZrHO5e4/+CX431VbFpk/u3rjjmkgPsRQEPwSFxUUvR4KvsIY/uMdRGIhd7K7n68Y
	SPewP4=
X-Google-Smtp-Source: AGHT+IHihVMu7J0wGiafdqLPHYOzKjh1lKiFbzfZm/I7Nqpsl5xFXzGFk/zni3xJLjNUvadYSQXM7c2LuSeGdRQDC08=
X-Received: by 2002:a05:620a:19a7:b0:7e6:8f41:2047 with SMTP id
 af79cd13be357-7ff26eab696mr1231276785a.6.1756811714293; Tue, 02 Sep 2025
 04:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-9-ryncsn@gmail.com>
In-Reply-To: <20250822192023.13477-9-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Sep 2025 19:15:01 +0800
X-Gm-Features: Ac12FXw2zVbOlTxPFwozdYEN2QUi5dTUOC897UqRY3jmRoZMs6j8v_WyCXaaD5I
Message-ID: <CAGsJ_4xON7fYg1VvcjLOsgBb_Wp4ruC+vdA4Q496GH1jXunU1A@mail.gmail.com>
Subject: Re: [PATCH 8/9] mm, swap: implement dynamic allocation of swap table
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 3:21=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Now swap table is cluster based, which means free clusters can free its
> table since no one should modify it.
>
> There could be speculative readers, like swap cache look up, protect
> them by making them RCU safe. All swap table should be filled with null
> entries before free, so such readers will either see a NULL pointer or
> a null filled table being lazy freed.
>
> On allocation, allocate the table when a cluster is used by any order.
>

Might be a silly question.

Just curious=E2=80=94what happens if the allocation fails? Does the swap-ou=
t
operation also fail? We sometimes encounter strange issues when memory is
very limited, especially if the reclamation path itself needs to allocate
memory.

Assume a case where we want to swap out a folio using clusterN. We then
attempt to swap out the following folios with the same clusterN. But if
the allocation of the swap_table keeps failing, what will happen?

> This way, we can reduce the memory usage of large swap device
> significantly.
>
> This idea to dynamically release unused swap cluster data was initially
> suggested by Chris Li while proposing the cluster swap allocator and
> I found it suits the swap table idea very well.
>

Thanks
Barry

