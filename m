Return-Path: <linux-kernel+bounces-819713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939A5B7F781
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550585210F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A94C2DC790;
	Tue, 16 Sep 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R55DW1gL"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049D2C3244
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063105; cv=none; b=Qtg/YUMwomv3UqNA8LgFx6fwFrf4KCsmOdJfz1UiyxiZsPFTQtG53ndj2y24ok3/AFy+O2HtVJNYiJJ5VEluNUe/USI58n9Uf25wLKVWBz1tsO6wU1qdjOqLM0eLQ3CLwmAuSiCg4PbHinvdfJdiPai1OI4OlsxzIeiSJk/MSd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063105; c=relaxed/simple;
	bh=ahw98Nzw0N10giaerVDfZYUU4ISliFAGxR+jojkghBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWQ72IPEYlV4K20oB4Re277fEFyIgCVZZPtwMTzBiCXorfkag5rumj2rzSFP5AKh9BgVUhk0DP3f1BSAuXzL5+ZhYpgDvkk39bx+ShenUDyQcRxBtNBVpeR6AbtlN7riCb+cA6Kgb3cvavGesjhoJX2iCfOD+2pTOWHCisgT+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R55DW1gL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-80b7a6b2b47so572443885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758063103; x=1758667903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahw98Nzw0N10giaerVDfZYUU4ISliFAGxR+jojkghBY=;
        b=R55DW1gLadr4GipjBVnM4XiH+mQl1AEOriQbqxcyzHyn1UqmB07ho9i37K9HI0TZVf
         FlhMi9fN4bgEUJMFTeShX9qbSh2E0GBSoENlCaYEZW9y3M04NRfw6Ld9n14DlXU3vSpd
         fvpSEHSjPqcVWzFnc1VHnIfPL7OrKnbfn34ELkwTZthJst2mMat2z7kT2V1AzAzkMgD0
         WvE2FXCXgOMnZWknCgp6rjVGs+PUfrHyzf3trrerR7f/WIoQH/CKOei7SSn1GFRcAcr5
         ZwEJwF+zOHog+Uxyfd8zABXyVqMjz84KqcuzBiNE4qwfpBD1bwk/LKLrBgFMJTeM17fv
         PzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758063103; x=1758667903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahw98Nzw0N10giaerVDfZYUU4ISliFAGxR+jojkghBY=;
        b=h+e3/gvKK6gbB0dX4ZQKhaJ+M8RHPP0x6b+wANO6Z3U73h7sf2Ee7tGgoMryNvq1yq
         1nqIk+w1OdbYzoEA8iynH8cwrO9zaG6mK3bj9NV4+ozCzkQrX1+FKoe8K5XcRp3nz7V1
         LuIjn+XnYoL1WVmqlt6cdYmGStUYd2pJxk2ec03NWY5S3V9H88LKnrkwuYHImdX+Bp5o
         lycKCU4dSXvPFeyvDA1Xeo7V2WDgNcbUmhhjrkkri/iHed+np+oICPbkg4VKIxnYJxPt
         SdDuHk73rIPWQ3nP115P0QTFB7lrD2S7fRVD4YivVaZ18tWQIXVORb98pcwGfZrh1eWp
         LwBA==
X-Forwarded-Encrypted: i=1; AJvYcCXNjY8CKOhCbb+jOk1cIBa34lMaTYH6D5d7+jBamGudbszR0cJ7oxbxD5FQ/hXdOaEJoBbP4qJ7oJctG14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdsWe8Y6c0jb+ZnqiKVtJLtGfl8KWEBCeFUPMmnjeJ4cV8jCcn
	0KqahOv97/lSDmQ9rHiZQ/NR6vpqB7He+qEELXjr/x8bfHWPNH1P70i7AQr5WTqGzwDcFaIRc9U
	dqh+o9KbbgoxEzi5iM8+zUQlsV0zkgdqNN4+KGjKBnA==
X-Gm-Gg: ASbGncunf6S2MGLO6YnHCLRfll3+Ggp75atIMvCfddMXrEaZTFpg9WjAwAgevcDt+iv
	0QR2icBnauavkaEGhTBRGFesytvSuV5xYrqQm73jWAHZZI29Wmlr5mNQbfTpKzKufibWRKt2Blk
	BPh1wIhroK1PnDfLWpt050X00cXeMs08rZJfdf01esbqoxKVfXLQqSr4E7MiE51/C10az/xVZkA
	HqF4KD+LEKvRY8zEWUDrcZ5HeUrLj8Q871XnccuxQ==
X-Google-Smtp-Source: AGHT+IHDV7nD5StKN6sQ0CCv8Pll6eDmsLAx6Ma2rmFxhhZKYW073aqO6y2qoI68tKM7j1GcUSZfrJArFRuoSxelen8=
X-Received: by 2002:a05:620a:44d6:b0:802:6dc6:4f32 with SMTP id
 af79cd13be357-83111e2ba84mr3202785a.78.1758063102916; Tue, 16 Sep 2025
 15:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-15-ryncsn@gmail.com>
In-Reply-To: <20250916160100.31545-15-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 17 Sep 2025 06:51:31 +0800
X-Gm-Features: AS18NWAfmfKuo01K9eBS5msm-CTFs3neeIOqnHmUZFmjcxuaQnHLx8ZLGuoqfLE
Message-ID: <CAGsJ_4zuLQeCDw8=O-bjxg2uaiq3wowa_5ZXyTGjeS7wGnrUgw@mail.gmail.com>
Subject: Re: [PATCH v4 14/15] mm, swap: implement dynamic allocation of swap table
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

On Wed, Sep 17, 2025 at 12:02=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Now swap table is cluster based, which means free clusters can free its
> table since no one should modify it.
>
> There could be speculative readers, like swap cache look up, protect
> them by making them RCU protected. All swap table should be filled with
> null entries before free, so such readers will either see a NULL pointer
> or a null filled table being lazy freed.
>
> On allocation, allocate the table when a cluster is used by any order.
>
> This way, we can reduce the memory usage of large swap device
> significantly.
>
> This idea to dynamically release unused swap cluster data was initially
> suggested by Chris Li while proposing the cluster swap allocator and
> it suits the swap table idea very well.
>
> Co-developed-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Barry Song <baohua@kernel.org>

Thanks
Barry

