Return-Path: <linux-kernel+bounces-841310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6509FBB7015
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176EF3BDF12
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8561DED77;
	Fri,  3 Oct 2025 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUgfzswG"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7C522F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497684; cv=none; b=Gng/M2x6bmPXGG8H6TA+Eceyvr8MmGcd70qEKXeS6QFbumX5vTYOfxyTKkVNaE2BvoUcCylWhP2yLC/ZSnwybMQFLsJW2cYXQT/0KKMgDAbx9ZIeB5PEEswF3fRKfX5El1SiFM+B0axC3IaxWLTiFqWpcsjAp5DFl98NA+D/Row=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497684; c=relaxed/simple;
	bh=0xuYuVRnvoi3h2VJMy+VwCbPVEUcLMz6AZlmenXKJYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCv8Z7WHisms+SCDly3GBe6EiTV83Gtxy2gCxQPMzk3PWkH3uYGw2Y30AvBqgv9/1uGAc1ZCW93Ig7lyzzhHc+HppC/VIT6uPeDiCeEJewHuPgQbcwZ+m4KbZHOVrG74v9lE49Qi2nR8skvQJmQ20z9/i24FeUFITvgbdqW2yOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUgfzswG; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3d80891c6cso530524366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759497680; x=1760102480; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEydH1jo5Se5kyBydip8SdPrTJcyroKtL59YbuJLJJ8=;
        b=iUgfzswGkdI5QvECn/7lZHMb/F9CYbqhgttf8G0vddRSGg7YX21cIw0XpQJZpcfchq
         O7+HSeFOxjkyQWCk23MUEGk9vEpPrujrHxP32EFniS25ex29eGb8md51kSbD0b2gEbVJ
         4BaiXwpCBkB+2Y8jEfsrbS69corMRYw8drnWK+o8Gq6wvF9ixSj2xHmg2VzBP1O+nJgf
         pNfGeiATv7QCROwexqjoax5TxnJMMa3hhZUTyn5uRJ5atI7f9J+zXtXN5kcK9yXnTvvx
         1HpCBV/eefaq96o264NsyOmQ/2LODUZHFsJ3qSvv+yvO9Ui5QRwVpIvrII0lZPB4+P+w
         DleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759497680; x=1760102480;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pEydH1jo5Se5kyBydip8SdPrTJcyroKtL59YbuJLJJ8=;
        b=bNgizfKQz9Wvvf4YZz5TNf6NxuN4tkQX3ZuvZ3gERVY3jQ+Uz5S82RvcZQQjB9LXt0
         awKdMgKzLquKg30K0F/4FTR3bIcHM4XHEAbf1ETjWAgvw21zWvGasUOnjrMsTUxRqQ4A
         5uWiIIIJ1HGUS9/8iD96bDXbNj7+4nabG6rCnNte7gRFPYRz6+h4rKT6v9ozM5BvHT3F
         fAhBTss8tcfzwWhGv5+mpuLQDhzAYFiNOfkE7s2hvu3u22QMRVqGECyem9WtxmbUT7Cb
         MBqP1P+V8ByRBFpPtWKA867LUA2WItBiLx7WeDUvrBSlw6gQnM/ilkkeexN4kgm6E9jK
         qHpg==
X-Forwarded-Encrypted: i=1; AJvYcCVBDRqYZKCtdBnWsJnegu34A5RvNOAAZ25OqOb0IOqGAM553JfhwsbQKSNhBrvE5dBIU2/1xpGCvk4p7dA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ysLamLkM2GCAiVIfPSuHhLshLk9VXYV5fl2x8uDiOgNxEuTG
	AvyUnbKHbEUjJBYnXlmMAlfqRhAFyrBlbYv1uWmJ+UtL+e/4RaUtQ+ui
X-Gm-Gg: ASbGncsephBXlfGCg3DIXW8LyIG0xdXY2/neNVlpAy0rvSmtQRfbu7o90KP/FPqDbcO
	9lVxwTtNcoOl7hDdq2mmuluRntpVCWGDpoa3c/+qPclIPMjZJMMnjDTSvn0VA36xWO3FNspL+cp
	eHaoldatTgdt7JFU/Th7YYPMHNbZPULBvBE6XsYhM01Jl8kGOrei65wJLadcicbBIkPtJnHZYu4
	MjYCVNZaJg54UqO05Kl8dlvvLVYSk4jiYUF6Hyg2wVjRuh/Qm/w1dxxWWboI8Gkeb3yR2vusEp0
	oyWvX4r0+/dgaimgHOf4hjRfN9uNl5GFNrxW28mqcAZSSjYrFmqP8oNcq0Ii3ox9I1gWWoPiYz1
	8pNJrt6gfiXqKRTpMsyineQHn8g23RttIuxfdgABhYmp5BS6UCVOMCn9bONJZtiK4ANCfD8E=
X-Google-Smtp-Source: AGHT+IGa64G0qwV9Bk1JMsFpkYvw0NEXZMFhhOg5F9dy+OS5qHXCxq08mh6HOFbiqmNQxCE//fb+4Q==
X-Received: by 2002:a17:907:1c85:b0:b40:c49b:709 with SMTP id a640c23a62f3a-b4859c7a718mr816247166b.8.1759497679749;
        Fri, 03 Oct 2025 06:21:19 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4d9f5sm447012366b.66.2025.10.03.06.21.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Oct 2025 06:21:19 -0700 (PDT)
Date: Fri, 3 Oct 2025 13:21:18 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
	richard.weiyang@gmail.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH mm-new 1/2] mm/khugepaged: optimize PTE scanning with
 if-else-if-else-if chain
Message-ID: <20251003132118.qe2wipbrzwkbaatq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-2-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002073255.14867-2-lance.yang@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Oct 02, 2025 at 03:32:54PM +0800, Lance Yang wrote:
>From: Lance Yang <lance.yang@linux.dev>
>
>As pointed out by Dev, the PTE checks for disjoint conditions in the
>scanning loops can be optimized. is_swap_pte, (pte_none && is_zero_pfn),
>and pte_uffd_wp are mutually exclusive.
>
>This patch refactors the loops in both __collapse_huge_page_isolate() and
>hpage_collapse_scan_pmd() to use a continuous if-else-if-else-if chain
>instead of separate if blocks.
>
>Also, this is a preparatory step to make it easier to merge the
>almost-duplicated scanning logic in these two functions, as suggested
>by David.
>
>Suggested-by: Dev Jain <dev.jain@arm.com>
>Suggested-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Lance Yang <lance.yang@linux.dev>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

