Return-Path: <linux-kernel+bounces-819629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0820FB5A3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997D51BC82E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE92287515;
	Tue, 16 Sep 2025 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOwq0Avk"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B049E27280A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057787; cv=none; b=k8K4ngqVTyC0Iy7BhQIVa5QYhw1JsG5Eptb9eQbsOcR++q33EuW6+GRtcbCmHCf3+wrtrmrlsXYsUmylZ92nRQVDNpLQECqKLIdP/L/ZhqOwy+/Pz6jmRu1zbYcxBX8X6Ksek9E06VCmAOLcgiMasNTT2+gBR7krP935zKBJC8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057787; c=relaxed/simple;
	bh=7d7fyEYUl0ACJpbrJxaRgpnFSnvwlBZGD5NItbZRgx0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KzdnrqwF9KkLYsFt2rnTKD5wv2zi2+MNEWB7dkW5FrSnRFNOLLoKgfaud+jx+n3FbSLE8/a9cDiao8gh7idQMqYzQccbOOtXTjU4ZodQhUCNrjsXDZXHncYnBqdA3s8HeHmiupair+wJ+yEy6RhIbt9TNedvRTn0zdGwidldLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOwq0Avk; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e931c858dbbso3847262276.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758057784; x=1758662584; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/ZO0MqZiDI6fHTwbXd86RNAJbgLdrJ10yQLcCe1K2k=;
        b=MOwq0AvkD07vR8CfMxTsrMVlGyyrL7s06z93o6ydMUY2mKEywuFERdXB2EtmLDqzcT
         Oa+KiKcmo6gAxVtI4GXFjQHMIYtDn+Ou4D6HQuEmU3OEKbb1FU5oJ4nfSoHaohWnfOJc
         uiRyIjcqQLphoHZPeeT1mswv1Yg0lRfP8RH32yMrfEfzTAAs4z5kDSCsa5/Kmofg0CXE
         Hl5/O8fITOlKG2WLYYroUl6Yz6p3OtiBM0huSpRMJtft6DwbYw0OMeZ7QsE2MVe6zjaw
         B5HUAlZ3bndKLBCNN2g7xX8tz9NxoaMMEhutKhhm7oU2UUGQ5G7j+CdC+PHY1ZvXcCo4
         kM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758057784; x=1758662584;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/ZO0MqZiDI6fHTwbXd86RNAJbgLdrJ10yQLcCe1K2k=;
        b=Oa+fjvkdwzKE8TsTu223IpMFK4tTl9us/9S8ry/mdDqsNwtaWeUbV1HLoOYEbQMagG
         p1HkyTlFhfPDxRTy2ebLGNTPqS5FRO/V8t1v2YXYoyt7dyU/rsS0WQopfrg4CeEJhtlV
         d7YVtmY41du78kCpA1DUW+x6pCGN8Hq4QEsQe2GYTeUI1f40yUm9C+fe/sJCb6NihilV
         Ydlx62K3EvJLg6D9VqWVxmRwe53QpkdaPF7mA+TM9PwCUtvmlYui0R3zVHAbEYPrqq8N
         AAADWf3Zn7EPDuSgl4qNfHfY6eokXe6bSpCMWtc2esjEKELVcnJFVO9ruAFSWeP7704i
         c92A==
X-Forwarded-Encrypted: i=1; AJvYcCVoLjOowMhNXpoWJNTLPPrwDFgzwsZbcErTR3Ccc8sIZMTRjlq7oLxg5xuACBvovkeFtibld4zq9P4mq+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhWKMkp5V1MDDcEqkfRZICvpLNoo0bd9XAXhCddTQPzGMH1wJE
	MjOiRM5uxPMc+RNFe8eURVJJJuUTbNZWtruwuHtIuwtBD5RH2FaNkd+YqRa3L8Urvw==
X-Gm-Gg: ASbGncsJonQRgNJIAzgkVsflyqwMdahhV1b2zzJPnMPdwTraFkjR0KW8p18wQWUrgtT
	K0vYKUdliGeLIFu6ch1LGz/HxAMIaSC4w746yHSkFKsLxrcjq0OTyVYIA7+W9vfnTDhKq5WSfHW
	cCGEBLeKnMlt47frIcOUI6xxqDvNV2W4fR41OZlDWojHu9E7R83dr0k2TiSBzOu+xyQA5GFwRMp
	mFseter3f5fYlkEtzsBLHdSpNwHa6ly1H6v9sBL0hM8kR8VyxgnJWERaFwARO196zlgzskxtaTs
	+hjdlWfzd5gTKkgD+MFcSlscpoiMbNKPAn6a1cTvGPSJHSs+Xq/0lMkvuuMZOEYTV9BisTRU0zO
	CorO3WIWm83DnOUedcwmOuG5zpBdeSBONVSgPkh3q2hUrRMikxAWtveNWfsSZ6X6BnScFsaPVuB
	schkV3BBCL4MvbjQ==
X-Google-Smtp-Source: AGHT+IF9km1aJwEt+1aGPxCzX4qDZv8bfQl194903OwDWSZ+8/On9Gh9pLdqJIZx54NMGgPjHY2hVg==
X-Received: by 2002:a05:6902:4203:b0:e90:6ed1:ec51 with SMTP id 3f1490d57ef6-ea3d9a34108mr13441041276.14.1758057784374;
        Tue, 16 Sep 2025 14:23:04 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3f0fe5fcesm3633731276.29.2025.09.16.14.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:23:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:22:51 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kairui Song <ryncsn@gmail.com>
cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
    Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, 
    Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>, 
    Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Ying Huang <ying.huang@linux.alibaba.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, 
    Yosry Ahmed <yosryahmed@google.com>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
    linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v4 00/15] mm, swap: introduce swap table as swap cache
 (phase I)
In-Reply-To: <20250916160100.31545-1-ryncsn@gmail.com>
Message-ID: <99f57a96-611a-b6be-fe00-3ac785154d1c@google.com>
References: <20250916160100.31545-1-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 17 Sep 2025, Kairui Song wrote:
> V4 changes:
> - Patch 14: fix potential cluster leak when attemp a sleep allocation of
>   swap table: Just remove the logic that check and return the percpu
>   cluster, it was trying to avoid fragmentation, which wasn't very
>   successfully and may not work at all if there are multiple devices.
>   The fragmentation is not a serious issue and given the chance of
>   hitting that race is extremely low, let's just ignore that [ Chris Meson ].

And in Patch 11 I can see that you've made an important fix to the
!folio_ref_freeze() block in __folio_migrate_mapping(): there had been a
swap_cluster_unlock(ci) which you've fixed to swap_cluster_unlock_irq(ci):
I was going to report that, with the WARNING and "BUG: sleeping function"s
it caused, but you're ahead of me.

Thanks also for fixing the shmem_replace_folio() locking and stats
update, which I'd noticed too (but never hit): looks good now.

Hugh

> - Patch 8 & 9: move some changes from Patch 9 to Patch 8 to avoid build
>   error, no code change. [ Baolin Wang ]
> - Patch 9: Fix locking section issue, should protect the shmem statistic
>   update with spin lock irq. Also fix an warn on condition.
> Link to V3:
> - https://lore.kernel.org/linux-mm/20250910160833.3464-1-ryncsn@gmail.com/

