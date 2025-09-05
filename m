Return-Path: <linux-kernel+bounces-803882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ECFB466C0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C2964E0754
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DCC2882BE;
	Fri,  5 Sep 2025 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGDalKx6"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF2524F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757112029; cv=none; b=CJDFAHhOk5XFHgefx3wBZSkHHhBmLz9Qt6nlLN0SAvSCQwsbZfHIoQrWgR2WhdkJdpsTaW4X4MQ8TxqqdotiQKYi0kdW2Nkw5lPUyCA5VG77HOelANL2tjwER8YvPkfqvuSoMLl1QcshQHMqy0KI31jWC6+np3AWTTXZyrRf2Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757112029; c=relaxed/simple;
	bh=qCejKM4XYsS3Mc8jT+/6eMCCnzQlKMfy/kZQZZSu9UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bW9w0JL/DWiIg1G7tWl9LC5iVBjlNQz9fURnguFFbUwKDi0A9fahRv2pvA/87nIMUzLPJI+w+07gFXPspqciuXOrCUe/yS59UeBciQFMluZIqrROWi2U/juCs8YIGRxkILSfGTK3vktkVxgYFTDdltUgd71A1ZVk1qYdxcsBBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGDalKx6; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-887745ee814so28845639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757112027; x=1757716827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCejKM4XYsS3Mc8jT+/6eMCCnzQlKMfy/kZQZZSu9UA=;
        b=PGDalKx6C5P6lxYmdD7+2CEZ1uoA/9qZkClpdTKsNk8ODQcJeoztrORrioUzupytAf
         zQxZyOwr66eKDW40INATS2Ldb0te7oeUqMo+a0vqR3Spxq7QUvQ1QD6eLhjWp7Qc9/pe
         OjNN4MsrvW1e9vYq8C5U3F27ihNyYGQDl6+o973Stx4gg4zkyX9kY7bJBagsgFOmNRm8
         Os7M7rpTqsYS4hlQP8LWd9UZy1VBM0ZLHH8ciMD6weDpXyi6ah91Jl2doloOOZizYfwo
         YfYosBa/MrkfuUuCuUxLRiwlUZnIcquxDLoc5owlqNC5yGk0XmZvv1OuxrfoOP6ERkV3
         zwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757112027; x=1757716827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCejKM4XYsS3Mc8jT+/6eMCCnzQlKMfy/kZQZZSu9UA=;
        b=sqMOtvKHtxv9uZAS0viSauSP04sY8T6ihCEHuvdry/7x8lOoG2tY43Akq86I9AqKKb
         WWjJ4fr0XntGDCpBVYWFwyNW8LF9HieQpZLDznJDTUV4tJebpqRc0STDWoy9sK2e4RWY
         ya1JQKMXe+e23pz6R1xf+7LKaN5qeHVPVx4/ZUL4+hNXJ6di5x7ZFrZwIyDcLlTcUimp
         qOK/7PClBFELkQ9SgcXfbo92xAf0i7Wl7Aup7v2eNkHpx6A/xdhjhvUamlu5VFIsMjRL
         LVltHYKqkaegPsFQewBuAAPQFsESR/tHC1LLX28WeBU6MRo4S5JJuveMkJHN54Ck58x2
         HNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp58nPGSTv6sFW82ZSxlBJ/C9JHQb7YDWUDsa519EBFe2LZvUzyiO+w1CTgaJ2MGzGMGvylpv9dPKvUCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJbUVOp1Er+sySepDsv9+tf9wRS4BhdCFSSXpfEFxMbxn+/r7
	UI59R/GOi5NksKo7gr5syFf+2C/PA33RG6FvncfGPt17iScLUfjTClLwhlzOc3Xmp/VSnfzyL23
	sRtiAveX1SDIBwP8ShHb/1vbhRiG2ZYQ=
X-Gm-Gg: ASbGncuciKu4fRKiawTY5tOdLXjuRz73//3hzLrtxhurA3NEr3HfSeXBbQoXfutq1bs
	thO/6UR6dAs0QfsXAgaigh5+e6bfIdmEgowcBVkzFLnn0pzB/Ai+22bOdrj2aOPU5VGn/VBOo31
	Y+YpUgVuU5ToHGOjsNZlrW39vEmkZazdRUH1oTju/Bxmyi1N/Inb8lBvITwV36bpSl1btsRSisE
	eV7q0qT
X-Google-Smtp-Source: AGHT+IG55bRnjpEXdc2WowZ5rrMS7XLGIAtuFag6uplP7dR8JDmhZUxRNCDeLpq1gfeQR+Z4TeVn2mE+C2ogz8I/qSk=
X-Received: by 2002:a05:6602:3420:b0:887:6d06:3604 with SMTP id
 ca18e2360f4ac-8877768ad3amr76211239f.14.1757112027235; Fri, 05 Sep 2025
 15:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-4-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-4-ryncsn@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 5 Sep 2025 15:40:16 -0700
X-Gm-Features: Ac12FXwf1n-35Lk16KT3TkdmL6NzGPHTW0aRJyCAC7z75wlx6fkzmLWV7yOp5YA
Message-ID: <CAKEwX=Ndtbsy7UoGhwcd+by6bz2gt82o6EPOkiXbqNv=uPb8wg@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] mm, swap: fix swap cahe index error when
 retrying reclaim
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:14=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> The allocator will reclaim cached slots while scanning. Currently, it
> will try again if the reclaim found a folio that is already removed from
> the swap cache due to a race. But the following lookup will be using the
> wrong index. It won't cause any OOB issue since the swap cache index is
> truncated upon lookup, but it may lead to reclaiming of an irrelevant

I mean if there is a race, folio->swap could literally be anything
right? Can the following happen: between the filemap_get_folio()
lookup and the locking, the folio can have its swap slot freed up,
then obtain a new swap slot, potentially from an entirely different
swapfile (i.e different swp_type(folio->swap)).

It is very unlikely, and in many setups you only have one swapfile. Still..=
.

> folio.
>
> This should not cause a measurable issue, but we should fix it.
>
> Fixes: fae8595505313 ("mm, swap: avoid reclaiming irrelevant swap cache")
> Signed-off-by: Kairui Song <kasong@tencent.com>

Yeah that's pretty nuanced lol. It is unlikely to cause any issue
indeed - we're just occasionally swap-cache-reclaim some rando folio
haha.

Anyway, FWIW:

Acked-by: Nhat Pham <nphamcs@gmail.com>

