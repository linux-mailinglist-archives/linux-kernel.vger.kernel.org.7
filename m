Return-Path: <linux-kernel+bounces-830828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1EFB9AA88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9EFC1886832
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC5230DED9;
	Wed, 24 Sep 2025 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irQgTQzj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A7D30DEC4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727690; cv=none; b=hGsqluHNUGLCuh0XyoQ4qoRZszAz5NeH0DixIeQVMSrD++7tg5cBHL816Se03awPeb7REsQXyMqtIZYOOc2iEJY7Oqt3Wk+XygokPwrOnXY0v99RO3WeAXJgFersjafTT8eKp0Uyv3RqmJySlWCpTfnOJx+5+7baQZMk/9GVWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727690; c=relaxed/simple;
	bh=O/bKTpvQARqt8FVg/y21EPm0JoWae7amDRNYbxV7ONc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V83umjfmNwca+xV5qlHG++DbSS9xQQFtCCas1oVUadvpaTxDdjXShjdEWTCdRrP3jkTdXwqWppGMyNT+Y7of/ZPmwxrXZuN/9+IdTbBoYkQ6EfLf2TJF9RtE/ClrCX0jj4CHmmPm6gkYITs1ggnxuvR7M4BQQ/PXVBd8PAoVo4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irQgTQzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F31FC4CEE7;
	Wed, 24 Sep 2025 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758727690;
	bh=O/bKTpvQARqt8FVg/y21EPm0JoWae7amDRNYbxV7ONc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=irQgTQzjfSAjWwFVUQYTRj/oZ1GIQOmw6hdssvbkPidionp5q5qRBCVgMhNc71jUA
	 RpsG9bOvIDFcynHxs5toNX9PmUeYLEkApMwKR07l/VKoaqMkKEi4uDMFbIKmpvCMF4
	 FdTi3dHPyvwoX3cnCcLsFQKRZXASwWuDUzS3vQoQFz2Vn2adC+XM1YHWXIcklNt1p/
	 wYGFAX22klRZ7NuqxsHnDpJjIRZeFh9CCAqb0si0AEFWD9ZP5V67PvFMS8xdbyMuBT
	 V+OlOwvaf35CchUJqb0cx5b/InhHOicYhWFNucyh5gLSkC2/UiOMh2riv7Cjk+T1j/
	 j0+7OvHvZ2RUg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,  Mike Rapoport <rppt@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,
  Changyuan Lyu <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc allocations
In-Reply-To: <20250922143407.93e171f8b7c09eb21159a33e@linux-foundation.org>
	(Andrew Morton's message of "Mon, 22 Sep 2025 14:34:07 -0700")
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
	<20250922131948.GX1391379@nvidia.com>
	<20250922143407.93e171f8b7c09eb21159a33e@linux-foundation.org>
Date: Wed, 24 Sep 2025 17:28:07 +0200
Message-ID: <mafs0ikh7dg54.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 22 2025, Andrew Morton wrote:

> On Mon, 22 Sep 2025 10:19:48 -0300 Jason Gunthorpe <jgg@nvidia.com> wrote:
>
>> > +static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
>> > +{
>> > +	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(kho_vmalloc->first);
>> > +
>> > +	while (chunk) {
>> > +		struct kho_vmalloc_chunk *tmp = chunk;
>> > +
>> > +		kho_vmalloc_unpreserve_chunk(chunk);
>> > +
>> > +		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
>> > +		kfree(tmp);
>> 
>> Shouldn't this be free_page()?
>
> Or vfree()?

It should be free_page(). The chunk isn't in the vmalloc-ed area, it is
the metadata to track it. It gets allocated in new_vmalloc_chunk() using
get_zeroed_page().

>
> Not sure why this code works - I'll suspend the series from linux-next
> for now.

It only gets called in the error path and that didn't get hit during
testing I suppose. Until v3 the chunk was being allocated using
kzalloc() so I guess this got missed in the move to get_zeroed_page().

I think Mike is out of office this week. Do you think this series is
stable enough to land in the upcoming merge window? If so, I can send a
v6 with the fix today.

-- 
Regards,
Pratyush Yadav

