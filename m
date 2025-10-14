Return-Path: <linux-kernel+bounces-853307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD64BDB314
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035D218A3718
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CDA29BDB9;
	Tue, 14 Oct 2025 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LLU4i0A6"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E782134CB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472930; cv=none; b=Z3VTE0Mfo8j2RA9qgtW1n9onj6fPe9STWDUAyNnPIojCxBTt31jwBJ5G445Ji8Gj8A+TX82tPdRB3v3HAB96gs88u8BSu8m2KL3DI+LBeiwGesPJsI/Lt477nL1uS7o9PJRJ1yoctSqSxn2UgW4AZWZMNWERKcs3VPOa3if7Zwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472930; c=relaxed/simple;
	bh=N83eN6ldsLHCjrHTckQYmZSkVVLuOVskDx40Qi6uNQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFx3jtVvAa34Hm0IALvOJdLEmFSL7JYeXm/zG320SImJ64kJ/SYg4B7PVWrWspWNmATTqH3EKXGpPizAl3xICQLqfWonw80zcY846RsJEOe/39WFA2c/wdWo7hQkz8UCglp1s4KuCaaDimYnTV+rQ7xI2RN5Ih15u1yAGjmUpfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LLU4i0A6; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Oct 2025 13:14:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760472913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30m/R6kGfPQmiGGpbfSfPfjCzYkpYWzL1bJUfwurkgI=;
	b=LLU4i0A6ZpHdPmXMxuV2bZN0fctkP3wxDDwLYaHrtOgCs0TWyKR1pug9wqOq1/2ryEsb/j
	QGUt2ynUwveYKjE988Gk7NtQDHnkdUGuc3oHlCVHDlRYy+x4kMD+1odLFDA7a2Nkszgwd+
	JNlBh2+SNLZrxG1xC/DGmw0nBbo8ueU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Hao Ge <hao.ge@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH v3] slab: Add check for memcg_data != OBJEXTS_ALLOC_FAIL
 in folio_memcg_kmem
Message-ID: <vdngz65wojqalim4xb6vxb6k7upbzmkfoogmbuswc4lowju3ke@32hgwjlzxibr>
References: <20251014152751.499376-1-hao.ge@linux.dev>
 <CAJuCfpGBxUmvWoe2xv2-bsF+TY4fK-m1-Z_E3OcyTiSYz5KeAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGBxUmvWoe2xv2-bsF+TY4fK-m1-Z_E3OcyTiSYz5KeAA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 14, 2025 at 09:12:43AM -0700, Suren Baghdasaryan wrote:
> On Tue, Oct 14, 2025 at 8:28 AM Hao Ge <hao.ge@linux.dev> wrote:
> >
> > From: Hao Ge <gehao@kylinos.cn>
> >
> > Since OBJEXTS_ALLOC_FAIL and MEMCG_DATA_OBJEXTS currently share
> > the same bit position, we cannot determine whether memcg_data still
> > points to the slabobj_ext vector simply by checking
> > folio->memcg_data & MEMCG_DATA_OBJEXTS.
> >
> > If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
> > and during the release of the associated folio, the BUG check is triggered
> > because it was mistakenly assumed that a valid folio->memcg_data
> > was not cleared before freeing the folio.
> >
> > So let's check for memcg_data != OBJEXTS_ALLOC_FAIL in folio_memcg_kmem.
> >
> > Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
> > Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> 
> nit: I think it would be helpful if the changelog explained why we
> need the additional check. We can have the same bit set in two
> different situations:
> 1. object extension vector allocation failure;
> 2. memcg_data pointing to a valid mem_cgroup.
> To distinguish between them, we need to check not only the bit itself
> but also the rest of this field. If the rest is NULL, we have case 1,
> otherwise case 2.

With Suren's suggestion, you can add:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

