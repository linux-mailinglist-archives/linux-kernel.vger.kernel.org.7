Return-Path: <linux-kernel+bounces-883983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0021CC2F024
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 03:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5203B2673
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 02:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C911B24291B;
	Tue,  4 Nov 2025 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KouVxNdP"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645ED7260A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762224125; cv=none; b=nAIo0N4GyPug+BP+b9385QZPSbe00D0PdqsMVaKYgYWjZ7AfsSibzEFrXPxFKH9zNvmh7ShbsCi7NpockpJ30+a5hBzy8t13YZXVqlW1YbzoKx0ysAzg9flab6pGzXwl1zwSvlKT/qjr41L5LXtbrecXJYp7Gu9qqPx4BgYxF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762224125; c=relaxed/simple;
	bh=oEsUpbPQWxAtUUN22k6w9rpksyliISYsLWRxapFFMYc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Yy5A4QT1KclilcZncdqLmHz6wLzvmGOK/4kb+wEbzzmgUekPm/paEjXr88Olkwor1iU9XtWl6YWHee1N+h1fzaTSiuG0bI1T4mlKMTl/KvPpKhxXvRl67ud1qudahsGHjZbqxtYqm6uCi8ZyO9de8SH3GbH/wr1qGX6WCrKMQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KouVxNdP; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762224121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrRYu9HPjwo6Pe33SVmq+ZaNoNPIIc4e6Jwj2agDzxE=;
	b=KouVxNdPurpBVOxWme6zPBHls/q68AeQA5Y8ySWoarm4fl2KTt2rbydNlOk2fMPwySzsmB
	T0hdEeyr2+oEF51OJhMCfpQj+ZbUnqwxtZ2bWte6VKcMTgZ9mDHVVkVKkChb3Ok7JydrKR
	2NZ0Kzytx7WBvwUQZvKSPDmW4G7RG9o=
Date: Tue, 04 Nov 2025 02:41:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: hui.zhu@linux.dev
Message-ID: <1ecbb7b6b6c1cc85e9a52d32d968a2ad987a1922@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 1/2] mm/hugetlb: extract sysfs into hugetlb_sysfs.c
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Muchun Song" <muchun.song@linux.dev>,
 "Oscar Salvador" <osalvador@suse.de>, "David Hildenbrand"
 <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: "Geliang Tang" <geliang@kernel.org>, "Hui Zhu" <zhuhui@kylinos.cn>
In-Reply-To: <cbee126b-5a3b-4f03-a049-2d8b86b4e5f9@kernel.org>
References: <cover.1762156954.git.zhuhui@kylinos.cn>
 <fa0fee2b8c2e54cb2437db44579475492c19e94d.1762156954.git.zhuhui@kylinos.cn>
 <cbee126b-5a3b-4f03-a049-2d8b86b4e5f9@kernel.org>
X-Migadu-Flow: FLOW_OUT

2025=E5=B9=B411=E6=9C=884=E6=97=A5 00:28, "David Hildenbrand (Red Hat)" <=
david@kernel.org mailto:david@kernel.org?to=3D%22David%20Hildenbrand%20(R=
ed%20Hat)%22%20%3Cdavid%40kernel.org%3E > =E5=86=99=E5=88=B0:


>=20
>=20On 03.11.25 09:22, Hui Zhu wrote:
>=20
>=20>=20
>=20> From: Geliang Tang <geliang@kernel.org>
> >  Currently, hugetlb.c contains both core management logic and sysfs
> >  interface implementations, making it difficult to maintain. This pat=
ch
> >  extracts the sysfs-related code into a dedicated file to improve cod=
e
> >  organization.
> >  The following components are moved to mm/hugetlb_sysfs.c:
> >  - hugetlb page demote functions (demote_free_hugetlb_folios,
> >  demote_pool_huge_page)
> >  - sysfs attribute definitions and handlers
> >  - sysfs kobject management functions
> >  - NUMA per-node hstate attribute registration
> >  Several inline helper functions and macros are moved to
> >  mm/hugetlb_internal.h:
> >  - hstate_is_gigantic_no_runtime()
> >  - next_node_allowed()
> >  - get_valid_node_allowed()
> >  - hstate_next_node_to_alloc()
> >  - hstate_next_node_to_free()
> >  - for_each_node_mask_to_alloc/to_free macros
> >  To support code sharing, these functions are changed from static to
> >  exported symbols:
> >  - remove_hugetlb_folio()
> >  - add_hugetlb_folio()
> >  - init_new_hugetlb_folio()
> >  - prep_and_add_allocated_folios()
> >  - __nr_hugepages_store_common()
> >  The Makefile is updated to compile hugetlb_sysfs.o when
> >  CONFIG_HUGETLBFS is enabled. This maintains all existing functionali=
ty
> >  while improving maintainability by separating concerns.
> >  Signed-off-by: Geliang Tang <geliang@kernel.org>
> >  Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> >  ---
> >=20
>=20[...]
>=20
>=20>=20
>=20> index 000000000000..63ab13cfb072
> >  --- /dev/null
> >  +++ b/mm/hugetlb_internal.h
> >  @@ -0,0 +1,110 @@
> >  +// SPDX-License-Identifier: GPL-2.0-only
> >  +/*
> >  + * Internal HugeTLB definitions.
> >  + *
> >  + * Copyright (C) 2025 KylinSoft Corporation.
> >  + * Author: Geliang Tang <geliang@kernel.org>
> >  + */
> >=20
>=20So, you move some code and suddenly have copyright and authored that =
code.
>=20
>=20Especially given the cove letter says "The code is moved
> as-is, with only minor formatting adjustments for code style
> consistency."
>=20
>=20?

Thanks for your remind.
Remove the wrong copyright according to your comments.

Best,
Hui

>=20
>=20-- Cheers
>=20
>=20David
>

