Return-Path: <linux-kernel+bounces-846208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C974BC7480
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E159A3A7683
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EEB22B5AC;
	Thu,  9 Oct 2025 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AyPm4yay"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE822578A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759979862; cv=none; b=Q7OLdsoS+6G5i4BqShXpqgtRYpuGjd1shRQIXiU2LdYYLeb85iFP3lfhtbzEWu9T+Vbw6KDNFHmRd7vEeY9Kh0rsQf3hwdQn5qazqdQf3oKGe65AEEIKBWQBZBxFZVOMN4DticEBw3TZ7pEaFpA5QJSQVStXsLt3cTbbh+ZfTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759979862; c=relaxed/simple;
	bh=wPJ3c+Eh/QNy+wErZtTJ6qcki/ipw0RIOm8hLXCgx9Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SoCfd2HsqMmcFKR9ymVAjCcKGhV4/oGpxrgqSwmye00yeiurzMhAkKH4Xrpizt3vqPfrhUWUiXLYynDy1Wv1hsL/SYk8lkDP2RwaD+vXCH8EYERO7ZVT6y9m7P7Y8i5YReae58bYMz0BsmBigODDwnpQQy/1UM+tnZWwPOBdej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AyPm4yay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F6BC4CEF5;
	Thu,  9 Oct 2025 03:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759979861;
	bh=wPJ3c+Eh/QNy+wErZtTJ6qcki/ipw0RIOm8hLXCgx9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AyPm4yayNVHdTNj2bvS0OKDp+PvHhdOn440JVw+h+XkAavnCmVibloeRaBO8okAdC
	 KEYcw2Nx0sDWNxQyvFV/DqDCm3xbgzlspwEDTi8aQngtRsH+1+5hHecjBtK+lcyphZ
	 qRgwUAnTrM/DleGHi8A6MrCv0kwhLLhmt3CrLvok=
Date: Wed, 8 Oct 2025 20:17:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Zi Yan
 <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
 <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>, Danilo Krummrich
 <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>, Mika
 =?ISO-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>, Matthew Brost
 <matthew.brost@intel.com>, Francois Dugast <francois.dugast@intel.com>
Subject: Re: [v7 00/16] mm: support device-private THP
Message-Id: <20251008201740.d9507f4807a73058d4da23a8@linux-foundation.org>
In-Reply-To: <20251001065707.920170-1-balbirs@nvidia.com>
References: <20251001065707.920170-1-balbirs@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Oct 2025 16:56:51 +1000 Balbir Singh <balbirs@nvidia.com> wrote:

> This patch series introduces support for Transparent Huge Page
> (THP) migration in zone device-private memory. The implementation enables
> efficient migration of large folios between system memory and
> device-private memory

Lots of chatter for the v6 series, but none for v7.  I hope that's a
good sign.

> 
> HMM support for large folios, patches are already posted and in
> mm-unstable.

Not any more.  Which series was this?

