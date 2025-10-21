Return-Path: <linux-kernel+bounces-862018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FEFBF4409
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FD718C1E48
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BED231C9F;
	Tue, 21 Oct 2025 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCnRqdAS"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358F1F8908
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761010161; cv=none; b=nOksALiPg2Mb3BRSAfm0i/O1qj2uXjOtixz9pb4iZ8AYeqaj5w2r+MW+ufLCNyHk91GrJ8E2OWnC6ghmFRK5plEy76xcWbMnxHqgSYgKB69RIkSFqun0y2r9IxdDgmmVmf4aQ+ekhz714YrXTgke6NP6XxGzI51pwONOt/a7mvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761010161; c=relaxed/simple;
	bh=O1Q7PD47uysNpTkg+jsK4vRtT4mHWmpwYWVkO2bPAh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UowJKv5kXJDT+RGwSaYTv5+wnb36DkZYfrNVzqqKfK1KGBX490Rki0r+wrtVbqDHxxb5epifZMgaIM382Mn1v4d39Z7nlKoFyLxOLEJ+NqrNbzawzptp78s+YtPrnH8qg3RmBq9rXRiCpEAyqw6epyZhNgxoHoAwr1ZLZcO3TYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCnRqdAS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b5c18993b73so816400066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761010158; x=1761614958; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbAeAhvigMJAS3c2tXoCnvk4KAjUZ+kOzf4CO+MJDfc=;
        b=KCnRqdASX0I5MeaSTjRS5vyoE2BV8hOaou6O+rcJMu43vQM/HSsiZz9DzWnLVuQiHZ
         NTzVQHgqndjnC4Jv1bUekcHsYGdvxrZUjJgcRD2ZmsrwaPCDdWQO5cTs/x9iuLDA6KhK
         voCCTIEVYgxNrE2hV2rYkF2ABOqsdlQfd8GUTXmhZYe+GJSRruWp2CEsouRHbAnsOe0P
         l3E8jx/5hbl7777b9tzXS0Ieud0kGy2HBB4lqkDpZJ4wMBMrjAVRuRkcoJtMKG4KEjSE
         nEUiWC/oVczX4i/C7rw3Z2JhfwaQ/R7GlVmlig1/CoOhmk5NnCtgyQyRUo2pBS7rH9A6
         co6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761010158; x=1761614958;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XbAeAhvigMJAS3c2tXoCnvk4KAjUZ+kOzf4CO+MJDfc=;
        b=sPeu1Yh1RNgRWrN0oZ8pcwrtEwzP7ZP5w6IipU5cbnWXDItp+qIMzA9z70nStuxCsl
         YuyctEjiJYjKLybQHA+gjOTFL7yY/vzxc+v2z46ljGSPYlZEcHqe8cQ2DQ5KRSlYTR0W
         SvaA78RzmpR3fesNY5fTq8XTKczBuwIEj58+6UQNDCpPHF5fgv5E3pWAYPEYNBsFf6Nl
         J+CK3PVfFo8JrmVdhHspxLQJyg2XkyM679whfKqsVUtrGQoj8en3xPe2OP87QZX8D9uP
         5CrWbiq99i/Jk83tf06lu9D1alPHguVga6Kh0T86R2Y509zxCTGLzBj/ZgOpyNw59SfD
         vY7A==
X-Forwarded-Encrypted: i=1; AJvYcCXzwWcZH3nSGIJ3TkZYrGa5R62QSllS8k8QHhQ33WIeHusBfcYnCpk7SwWyz3mJybGf3RLb8zyAHqgibZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx75ltgNgebI8h+rdG6v9HEdtuBusdaZpAMUApXcZofa+63CToV
	lbildfKNHFDtMm3VPic2zl1O+UwbCM74K9++FQunfrDiweY69N7kseiZ
X-Gm-Gg: ASbGncvg4FiVHrCN8REVo4sKrvtDSjzsLRZb/9Sa8eSZ3yN/ooynMfZq9VVpdGLvJ2g
	/1fn+zKbLjgALqNdXitNGBAbcdpSZXcrwglFHn26etcd42YcaQfWBVImNIB8PUE3ViPiy+5715H
	bS+NXm269cFJJM54lOs/2fRVzJlk5wKtfc36f07RFjV9Q4k29Mn5O6rgPqXJ/v8kOMLNez5gU0C
	jPDbcRsun5HBEzFClHPMZKAhT1qJ10wz/1dg4SgyFEast2d9pa3wr8ocFXszCS91crE3VCXj5NC
	jc52wC3W2Nyc+g/UmNJYRPDnbwubaI09JWPP7GTBXapZ4c3Ds9LKG/kDBoW58D0hWTjebvBJ78e
	6BwlcGTsNRyUbDQY9XL4bzY3N1OJFiH3BaIN3bkkQ3lScDLkKpuLc6/UnAC4+9eK67kBGp8yV8/
	w=
X-Google-Smtp-Source: AGHT+IEaH2H2LgvLbz87krnRsRO92Pl4X1QpotTP6cukUX3DXB/2xHYU+4teR4vU4XoGFAF40rZTFw==
X-Received: by 2002:a17:907:7203:b0:b1d:285d:185d with SMTP id a640c23a62f3a-b646ff7d658mr1804922266b.0.1761010158071;
        Mon, 20 Oct 2025 18:29:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab45b8sm7990881a12.9.2025.10.20.18.29.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Oct 2025 18:29:17 -0700 (PDT)
Date: Tue, 21 Oct 2025 01:29:16 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH v2] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
Message-ID: <20251021012916.gkxh6cenjivwj455@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251020210816.1089910-1-gourry@gourry.net>
 <20251021012533.56rdl6v76plkw4nl@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021012533.56rdl6v76plkw4nl@master>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Oct 21, 2025 at 01:25:33AM +0000, Wei Yang wrote:
>On Mon, Oct 20, 2025 at 05:08:16PM -0400, Gregory Price wrote:
>>We presently skip regions with hugepages entirely when trying to do
>>contiguous page allocation.  Instead, if hugepage migration is enabled,
>>consider regions with hugepages smaller than the requested allocation.
>>
>>Compaction `isolate_migrate_pages_block()` already expects requests
>
>isolate_migratepages_block() ?
>
>>with hugepages to originate from alloc_contig, and hugetlb code also
>>does a migratable check when isolating in `folio_isolate_hugetlb()`.
>>
>>Suggested-by: David Hildenbrand <david@redhat.com>
>>Signed-off-by: Gregory Price <gourry@gourry.net>
>>---
>> mm/page_alloc.c | 15 +++++++++++++--
>> 1 file changed, 13 insertions(+), 2 deletions(-)
>>
>>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>index 600d9e981c23..da2e65bf63e3 100644
>>--- a/mm/page_alloc.c
>>+++ b/mm/page_alloc.c
>>@@ -7048,8 +7048,19 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
>> 		if (PageReserved(page))
>> 			return false;
>> 
>>-		if (PageHuge(page))
>>-			return false;
>>+		if (PageHuge(page)) {
>>+			unsigned int order;
>>+
>>+			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
>>+				return false;
>>+
>>+			/* Don't consider moving same size/larger pages */
>>+			page = compound_head(page);
>>+			order = compound_order(page);
>
>How about using folio_large_order(page_folio(page)) ?
>

Hmm... I see the discussion. Forget about it.

>>+			if ((order >= MAX_PAGE_ORDER) ||
>>+			    (nr_pages < (1 << order)))
>>+				return false;
>>+		}
>> 	}
>> 	return true;
>> }
>>-- 
>>2.51.0
>>
>
>Generally LGTM
>
>Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me

