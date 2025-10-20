Return-Path: <linux-kernel+bounces-861454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 931DBBF2C65
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AF73ADB67
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041DA3321BB;
	Mon, 20 Oct 2025 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="b93sbZAW"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7462561AE
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982077; cv=none; b=ERYq1KrnZUvcjao1pmTMjVn/Tn795dFtSQm1a1wjWVeeaVWQQlp0FY9JK3i63tQRdEvH+w7JIHbeId11JgYUTFmzkdkD+K9QyJxG4Upes+NK1+HKKtpO/N11bnWIwUi0MBX2E0sw0dI7P3BfDgl5FQxR6QXZAyVivwdMlYUgIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982077; c=relaxed/simple;
	bh=bFmswqbf3DaVhCnuroAuwIQco+WWUhFgeC50wytLZ3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8V/0iWqyOZMvYo8yAovSrMZGznxEEgChosYCOLwXg52TwY8EYuolWNskgf7OuEhd5g5c3cx71Tv7leLcyuIKq4pIU3eXedz3R80fg88g40lnCN2pvsUVMYIovMqnVuQvi8t33ojZzU5+91SQFpjCctQMJc1pMhwWRliqRKUJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=b93sbZAW; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7f7835f4478so50990916d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760982074; x=1761586874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fjTtWJ04FOXbi3894+HZSuerKrZxUoz40xS5pGSg+Yk=;
        b=b93sbZAWN70y9KgDvbypz8KRIrb+pocvyTCR/Ps9JzhFcETAwGfsyRihZIYEgSVn5C
         xDzlCUp+S24nkzfdzqUSUPljI9FGdg0j1yUgIAJjveQattrBDVaIZf8eN4LEdOVQ/MC/
         RWpax/Y+u86W+WEhIcPbCYflujy29GM09mM3+ero2soZhY7oQ3gZrn+OnmBT/CbEYeRG
         mUlCE+aRPlDsk+YU9JaqAYb+F3IRRhh+zdZHDb5iHHljUtBRV2eRAjQl5dbu9aLnXkUz
         T2ssOmnS6VfoJE9bWHRUohlNawbg9Uq3deqgxFwVtUF+J/3HzyMn5B1NrQWj2iEgGu3X
         zszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760982074; x=1761586874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjTtWJ04FOXbi3894+HZSuerKrZxUoz40xS5pGSg+Yk=;
        b=Xe1MROPiIJSqIHIGYF1Wjz0HbXrKApi6cWp0qczzvnJSF4WfzF+nLcy/1TgvHC3lKl
         ZgXmg9W5xxul9D+P7Cu3YgZO4RbQwUgNaSxFk+DX5iBzxs/UIn9Vct8SmR3iJ54n3eJJ
         sDr25PIsMTKPVMzliKSJJJq69NoezDmntnxpGXBex26htIESzqd2Jrot8uj8X4GwRM+X
         tjBreJkz2LzpTK3XmQLJ4Zg1KQHKLRI6EgYOwa+WZPM7jFS5CWfSi+tgRuqh2bWPaqmI
         WYzV9onA6dQ19al4x30J0TV00L9czKdSlzdogC5BgC9e8lUxkq97wEky1RBMvGhJ6qcu
         Kcdg==
X-Forwarded-Encrypted: i=1; AJvYcCWZz/QU/LMQlLkjLtPGEXOzLAaEL7nnns57OB7073LzsBBq6tKJ6qQ62mXeWht9okzN3T6MaNCD2wlgJc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/XyuXzDNsZshnBvt+8bT8AiR8BXLMoTIKeE132Ckb7q5rGWF
	/OJ690xqmrMMX2aJSvDBEl6zrjCCoegnqjnxDL9ro4DoeKIWuLMZmabg2CSv6du+P90=
X-Gm-Gg: ASbGncv+fmc88CGGsWSYhgVmeTmK0LRc4GNyCApOPo0yxomcmah7F32mB8MeQ/r15Aq
	yVbMAMZv6Qh4eWxHjpuVgvG2jVlr/0IidUYOK3pTCRxH7rs58nZulC9CVZOdWahQueeuN/ikKqR
	u8OdyP4ol+azHtfSxCYiTb1AxddAZcw6GXHaUgSrBo/wmfqpjmuRP9InWBzyc5Iitz7ut49ffC4
	TKhaPqIBml3kL/LhH0BVXdofuZodJWqEwXTTIBiN2T0iXRkCQ0GrG4m+8JMXX5zf8GaMknDqEri
	b+SDQGCTzkjfkhX0iXJd9cwv3sA2ia4sViOYe+N2VjZEY/JONQ0OSHRDBvhD5Lex6W/q3ZHM0Q3
	lAoM9L8/kNT8AKLRfKvtFABn8knxbjumayOtXweMwx2e2Vtsyw4PpSTdQVF72eupzT1NLj6g8TJ
	tqaYpZhwrawsmdKyimFkep5Naouthf8mZaD7WSfBfeBtcHstnkVJG5GQwY0HQ=
X-Google-Smtp-Source: AGHT+IF27fdheVev+QfR8cbUM42iDCUTKvZpHAkwKN/mALsFLATrPYKyM8gqCwn8kv46sHcSKP7PrA==
X-Received: by 2002:a05:6214:2484:b0:87c:1d41:575d with SMTP id 6a1803df08f44-87c2054aefcmr170598696d6.3.1760982074158;
        Mon, 20 Oct 2025 10:41:14 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf51fcd39sm54735456d6.6.2025.10.20.10.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:41:13 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:41:12 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com
Subject: Re: [RFC PATCH] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
Message-ID: <aPZ0OKx_VnQ4H_w1@gourry-fedora-PF4VCD3F>
References: <20251020170615.1000819-1-gourry@gourry.net>
 <487730c6-423a-4a03-a668-9b9ff92a5cfb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487730c6-423a-4a03-a668-9b9ff92a5cfb@redhat.com>

On Mon, Oct 20, 2025 at 07:24:04PM +0200, David Hildenbrand wrote:
> On 20.10.25 19:06, Gregory Price wrote:
> 
> Do we really need the folio_hugetlb_migratable() check?
> This code is completely racy.

My thought was it's better to check if any *one* folio in the bunch is
non-migratable, it's better to never even call compaction in the first
place.  But you're right, this is racy.

In one race, the compaction code will just fail if this bit gets set
between now and the isolate call in folio_isolate_hugetlb() - resulting
in searching the next block anyway.  So that seemed ok?

In the other race, the bit becomes un-set and we skip a block that might
otherwise be valid.

I can drop this check, it's just an optimistic optimization anyway.

I should also probably check CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION here
regardless, since we should skip compaction if migration isn't possible.

>> folio_nr_pages() should be fine AFAIKT (no
> VM_WARN_ON() etc), not sure about folio_test_hugetlb_migratable().

will change, and will check/change based on above thoughts.

~Gregory

