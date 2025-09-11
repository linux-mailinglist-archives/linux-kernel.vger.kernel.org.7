Return-Path: <linux-kernel+bounces-811582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558C4B52B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149E316290D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE012D3A83;
	Thu, 11 Sep 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMXQkPmT"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2272D29BF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577849; cv=none; b=FZ3YuZ98LNOf8Hxvyfmb4p4VpekGnlqPwtepenD0OsABEh7hF8k+FkBFrTRBmJxtNt77qN1i68Hlwl7MZb3XlfG+xjOKvM2EZSPkeFkX6czxxHVPLKEWqywzdNbF2+B0dIF1m3FlJgB9E7G+svtVluVdDiU+ss8cZPPihzW/7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577849; c=relaxed/simple;
	bh=D1dXUKDliy4JjAhsX2oUcRHMuirhDjdc0xD6es9VOAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6og1d8JAGCH2o9WE5GPJ2vD3fWtzKV0GxiUZ/pupKQDvCB455s7Pi5b20dHfEz2aGwSF4722txLPB8OaZdDhNiTqYPOWgLbDnPtW9P941YmyHvmNunDBqBDaPY+pWlk/r8JaTgDtV27wqutDCV7MhhasTfiXpW6w8vO9ipGA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMXQkPmT; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b046f6fb230so80133566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757577846; x=1758182646; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCXGwUwpyKq6QC0HqHvB+PlNFDZF/zHlcXjRKnHG9yI=;
        b=EMXQkPmTd214kPmQ9WLxqtr7AFsG/wHHpp4cFaE6zgTz7nzvIaxaRrzHkfRneZHcyb
         8gP4rZ7malheRzSr99sCnDsWUOfhW6TOOYoaKzjC/d23Wo68ARuPuCB/3YEioxGp6x6r
         5jzpInbthqzW4YXpumRRz3KNl5SfEV0sDJceXec4GyW4rkBcLcmAmVJPPKk2pWvvibQ0
         0RuxvqaBfvUwFQQ+wxFzf58E7HxFojqNHx32G4FXYNlBKgXpvVTzi9JV7ugppTNDckN8
         GrH9FVvwxvb3+WRo1E9BLe1OoyYi9CdOUCBo/jBVA9vian6jM+w7fKlrrj30fKGVYrxa
         dG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577846; x=1758182646;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCXGwUwpyKq6QC0HqHvB+PlNFDZF/zHlcXjRKnHG9yI=;
        b=BgKfzrRZuTCLa0FH4A4iaqJO/+F8q/0N8g8JdOK+ZZGXcL6W0gOU2kTDX4Oc7+3lNN
         i+NvvUTmIoyTp5wuPo1QJi57OAifRkGaHVLkT8gomXhEIzIuJg0Yzi4FeRAd3MxSLI8T
         Ds+IOtK7A2frc7gcj5ErCDTk+TZnUHAm55Wre96d7YRyzQSU3NdIy1LKmNNckBkW5uVD
         rKIKdECQjw/slh82M962vH0becxy5ABle4IQ/bP6p/B6k/9EcQCjGAdgEYqTnrr7tK+4
         /ADeu1bniS7xqFGUEUxS3YtbJw9AXMcf3XdlS1LqL99FCD1JazH6551qgmfAyYeAvBNF
         XCYA==
X-Gm-Message-State: AOJu0YzPbDN2p6Mdf6+xw/zPwgIeCvYSasD2apGNJWMah7EYtqIoksPG
	YEGx3igJwuTe54TfUNQrpv6UrEXS+mpYcAP3lbbRQvXJNDCwB4zttqZ6
X-Gm-Gg: ASbGncsNeEn7tzuSC4LYcnaS0lYmvh6CgVGr1CzCak0bfqn7q+LqIy5ZGnsEIJlBqwq
	5w16bDwQuPBGKxDYHSzyIe4KUzPnPQ8y53tAxjIXHY4H4GDBEgIH+17zROo9NCRpg70dlvlJ74W
	bR2TnW/wXtOXX8059uFnTb30WDtAJPwMFeZX0PFqu4UPbzQ1ha7O4TdTetPHSe5Bh6Npz0h2p1m
	6MdeCz7Rm1QS55pfaW457a8HhoH3L0Q9ADJM46SGCxIwHuGSmiNn7P0H4MGwKt6tgVvmfnpZ/rB
	D1OiYupDcZFB6zRg+3mJuItiZxCRySTG16HYsT2McRG4ipqKQJSCYye8N/58QcizPN7h45heDcL
	y/9cl7H/aTzAeXq3W5NFvbtx3xw==
X-Google-Smtp-Source: AGHT+IEcMSgKo4+sU99486bq3+Fvkta2bK3Nuc0JJPNS1zet5974H/X47nBk+8+kC1RGRur6L5MELw==
X-Received: by 2002:a17:907:8691:b0:afd:eb4f:d5d2 with SMTP id a640c23a62f3a-b07a640873dmr285777066b.31.1757577845911;
        Thu, 11 Sep 2025 01:04:05 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f2122sm75915966b.85.2025.09.11.01.04.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Sep 2025 01:04:05 -0700 (PDT)
Date: Thu, 11 Sep 2025 08:04:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, damon@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: Re: [v4 06/15] mm/migrate_device: implement THP migration of zone
 device pages
Message-ID: <20250911080404.r6vqlhyi7qyjutij@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250903011900.3657435-1-balbirs@nvidia.com>
 <20250903011900.3657435-7-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903011900.3657435-7-balbirs@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Sep 03, 2025 at 11:18:51AM +1000, Balbir Singh wrote:
[...]
>@@ -836,15 +1107,47 @@ static void __migrate_device_pages(unsigned long *src_pfns,
> 					migrate->pgmap_owner);
> 				mmu_notifier_invalidate_range_start(&range);
> 			}
>-			migrate_vma_insert_page(migrate, addr, newpage,
>+
>+			if ((src_pfns[i] & MIGRATE_PFN_COMPOUND) &&
>+				(!(dst_pfns[i] & MIGRATE_PFN_COMPOUND))) {
>+				nr = HPAGE_PMD_NR;

This one trigger BUILD_BUG() if !PGTABLE_HAS_HUGE_LEAVES.

>+				src_pfns[i] &= ~MIGRATE_PFN_COMPOUND;
>+				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>+				goto next;
>+			}
>+
>+			migrate_vma_insert_page(migrate, addr, &dst_pfns[i],
> 						&src_pfns[i]);
>-			continue;
>+			goto next;

-- 
Wei Yang
Help you, Help me

