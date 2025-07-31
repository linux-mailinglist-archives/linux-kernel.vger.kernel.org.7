Return-Path: <linux-kernel+bounces-752406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF61B1752B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F1F1C25C59
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDB223D2BD;
	Thu, 31 Jul 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9bCE3Zl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D4C1F4607
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980239; cv=none; b=bVIhcoi9zxuqABlqzELPSeuA0S+5ygdzQsVc/gzD1Z8y/BuvlfwouuWFn0DVp513YFzRCOXIB2HiGI5G+GrKIJ2g5D+67VrGy+VhTTJ3aMgnTAsqhcJ+EZn0Iwku7n2Tv+Ld3m+pwTePgIhlYD5RF6Z0TQILuhmzdxNcQ3hGyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980239; c=relaxed/simple;
	bh=w4+o2mS2qRArxgB5ehhLnJpSER328Vi0bY1CxE25x+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgXCftdKu7wWrzz1yCmaR4/U9LRweH48ZwRNARD1T5z0dw/pYGJl7tvUGCOT7wqs+Rsajd51RSDDVmYSnP/Gne/gGk3euRhvDKiKGu/CKaG98Any+GgcCrSDA97FcMnneq18DRVf18YoHGAfIGwcSm5ZnFohNM/RxmNa4NdM9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9bCE3Zl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D80C4CEEF;
	Thu, 31 Jul 2025 16:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753980239;
	bh=w4+o2mS2qRArxgB5ehhLnJpSER328Vi0bY1CxE25x+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9bCE3ZlPTDEwakexIITAXv0tMPzY+7+iotOPgcNMyjKKBedUUwISrlUjsBF6fFH4
	 zoQ7ehW6kyvlTfiIyWJbgGiFRCsZeFXR066U2N0Cc4AJjDKBG6BZqRrbkIb2iAv392
	 N2RvQ5+R2lbP6sM93JS2Do+hFO/F/Of3LXkg0h3IskXSSaG5WoF0heGBDHmSzJ/oTd
	 A0xe54DghmTTzehjRQKex2moLZ+Ad/arvLfvk5Gu2EmRARn+tWFuLqajbfOlUmJkB5
	 kIauQBRoCm1Riqzem0rXWW/SJ5+zDqyr75ySzzQRX+Px1b/PbXcS4WMIU8gQbYdH/V
	 9Uo5tiw8xeWgg==
From: SeongJae Park <sj@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Takero Funaki <flintglass@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/zswap: store compression failed page as-is
Date: Thu, 31 Jul 2025 09:43:56 -0700
Message-Id: <20250731164356.15198-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAKEwX=Py+yvxtR5zt-1DtskhGWWHkRP_h8kneEHSrcQ947=m9Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 30 Jul 2025 17:22:51 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> On Wed, Jul 30, 2025 at 5:21 PM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > On Wed, Jul 30, 2025 at 4:41 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > This might not be safe.
> >
> > It's conceivable that in zswap_compress(), some compression algorithm
> > "successfully" compresses a page to the same size (comp_ret == 0). We
> > hand that to zsmalloc, which happily stores the page.
> >
> > When we "decompress" the page again, we will attempt to
> > memcpy_to_folio from a bogus address (the handle from zsmalloc).
> >
> > So, in zswap_compress, you have to treat both comp_ret == 0 and dlen
> > == PAGE_SIZE as "compression failure".
> 
> Meant to say comp_ret != 0 here... sorry for the confusion...

No worry, thank you for clarifying!


Thanks,
SJ

