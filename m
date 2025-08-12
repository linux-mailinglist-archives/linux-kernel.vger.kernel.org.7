Return-Path: <linux-kernel+bounces-765312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13B9B22E90
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200323B2F34
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2499F2FABF8;
	Tue, 12 Aug 2025 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAKa2Z6e"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC49305E08
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018287; cv=none; b=r8IdIR3maolqwNhqNYBM6Fzg2rdT7eZiCEhbM5WiPkyzf9dZOvGS2MiSUGOJtapmnQxV9WG2KVLHFE1PgB9Lqmu4avBKZOBNCwM+0fVQQtp3nq7FPvzccmwSoV6wCdcEktmlphzfubOAMcOJXcY4hmU6M3rrfVtWyjE/7tHrL/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018287; c=relaxed/simple;
	bh=5uL8+i3KiVBpgv+8Frx/szZuI2RFyAIj9i3924xw6nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCQfNpF+F/R1YO1L376DlRfh66OfJLzngmhbKB1loDHIY+MBSzpUf/q2qK3E5i8IRr+LKKQ8BgtuqEnFEAYOv3GXtsrwOWBJs1HWcPFVv+BhEF/BGA+UAzdmDW5ajRa3K/PTSktFF2h/JsEqvOLvnb+e7I7Y8Nk4EZZ2CH6wcq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAKa2Z6e; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-332590cc87fso47402321fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018284; x=1755623084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQZs2/ofaFQReX+9phc9M7duzYoeB8uO888sE2+4mEI=;
        b=hAKa2Z6e2brNW9S+WJvguDy7zA/2A+by8C/ZkcO8HwJIK9wg1/uZObV6MpHOVyxSJj
         1YoaSF4vm7Wt5aqkr+HrLPyAngwInqxrvWyaC3LxkubbaP8XXZWcD/a27RvHO/ePxdQg
         znNXi1poEZSyzs7RslFf0tJ1r0UWz/dR4CF+T4e1yMIfwC4dPp0rZR+LVbDPZVD1kyeu
         B+XVVBZbHw7gpJv0ZWvvjP64tAw7XlyKGj0Xb2/mnHC259vffw8H34+cDcgSzej+LTeW
         vFSkXTCsUKku/HDcGuPdENLBq7HNut0n7Diai6J8YzI8E3qMQW75KjKRfqiZu+GX7Ogh
         nWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018284; x=1755623084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQZs2/ofaFQReX+9phc9M7duzYoeB8uO888sE2+4mEI=;
        b=jaGxKUvpZdsmZsrYGaEfWQ6Rygcgsh8+5RVydoJzyvzWBFxFwYPIBrEsxEL4pM8tQD
         yXQNmDxD5R3WHxZ5eXlYZ57spoEfsIwPIdLASQi2WuS/NhsC3Uf9+yg5UN8zw2eiLaV1
         yd4Jic+x5VaRFyAuuoBv2Z6jAQnfJqiJ31AI+G/PKjZMYKXKuNNnEmgiZwqWK8WhD4Zj
         1G/R4ksUQAsbFVBgt9Kxuq4b0MsvzXMlxB8m8XWoYk9ZfBoGaHCf3ht4vZ9FuZXjO6xN
         vpQmG+sJLRvG1Kf7quuL9vrTC15nuEzy+LZulDvCorreOiy8rP0bVIUgX/X6sWbTZAfX
         PX2w==
X-Forwarded-Encrypted: i=1; AJvYcCVmadKTUoAoEI0hIR5U+4q1SWbXKihr6wGlocYPCmA3NODwa2hhwJZtURYrlVZQOzLB4757QndK4fDNnJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk29hx5G5A+JxRntIpEzVl7a3KZ6BUMN21OMteBw1KApHBYO5x
	jVWOvMLgV9qzL8Uuu0m7XWgS1gsiEn4+NJyF9/I5r/mHaAhH6YVSn1mBbff54o2ZuJhDjmoEi90
	bEbYUWMpfIN8qCQvO6PjnyfSBs775oms=
X-Gm-Gg: ASbGncsFGhs3HZu6+gRNv41zDdR8NKS3txNHqfb8QjO84MwKWOUwVtYFJwHZQWSMHTu
	Vks+p58+GXlPypq1zam5nxaX0L4n8pwVEagrDRNnzUsXDAOGrw+wBltaoX6OkfgYOBMOz2eS115
	7d8KBK7PEgC9dq107liITWDcHme2ePx7VzMKbm41I1NO8WAeVxXRyL+ClV+DAtSgqNjTKUuZXK3
	syXuGk=
X-Google-Smtp-Source: AGHT+IGpmmnQoGmcyvbACz7q7pYxHF6oc2yvUosK65KkSLBtIAoUIVgm598enNehZu1QWFG+mEo80S6Q3fGrwClhEOk=
X-Received: by 2002:a2e:9892:0:b0:333:7e5b:15c0 with SMTP id
 38308e7fff4ca-333e52f20b3mr1327931fa.13.1755018283694; Tue, 12 Aug 2025
 10:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-swap-scan-list-v3-0-6d73504d267b@kernel.org> <20250812-swap-scan-list-v3-2-6d73504d267b@kernel.org>
In-Reply-To: <20250812-swap-scan-list-v3-2-6d73504d267b@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 13 Aug 2025 01:04:06 +0800
X-Gm-Features: Ac12FXz1pFs0mU-lwuasB5rlKYBEA50Iom5Lt6JdWBhEBFC9PKoqyVU7xSgeTag
Message-ID: <CAMgjq7D7MBK467=xYBXPZcBbY0_6n031P3rwnE28foP5gz7N7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: swap.h: Remove deleted field from comments
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 3:26=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> The comment for struct swap_info_struct.lock incorrectly mentions fields
> that have already been deleted from the structure.
>
> Updates the comments to accurately reflect the current struct
> swap_info_struct.
>
> There is no functional change.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
>  include/linux/swap.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a060d102e0d1..c2da85cb7fe7 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -320,11 +320,8 @@ struct swap_info_struct {
>         struct completion comp;         /* seldom referenced */
>         spinlock_t lock;                /*
>                                          * protect map scan related field=
s like
> -                                        * swap_map, lowest_bit, highest_=
bit,
> -                                        * inuse_pages, cluster_next,
> -                                        * cluster_nr, lowest_alloc,
> -                                        * highest_alloc, free/discard cl=
uster
> -                                        * list. other fields are only ch=
anged
> +                                        * swap_map, inuse_pages and all =
cluster
> +                                        * lists. other fields are only c=
hanged
>                                          * at swapon/swapoff, so are prot=
ected
>                                          * by swap_lock. changing flags n=
eed
>                                          * hold this lock and swap_lock. =
If
>
> --
> 2.43.0
>

Thanks.

Reviewed-by: Kairui Song <kasong@tencent.com>

