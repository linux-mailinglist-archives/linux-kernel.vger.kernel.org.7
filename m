Return-Path: <linux-kernel+bounces-841985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3704EBB8B79
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E395919C1FF3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6FB21ADB9;
	Sat,  4 Oct 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8EWH0b+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C8288D6
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759568594; cv=none; b=N4ZEDySj6iVUY0b8jzycPi2qy1OIEnC8q9EbadxPkGcH/FmalbQv9b0LYpWYPEyULEjX8TBTEuhfTWcIBZRKyxpCfD7R8GI94GnYczjnaiUzEqj9eWjuCbLY59IfAK1/DklpQpo/5hXpUy6vE+VFeZlM987b2HjFMm2Vn9+ULb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759568594; c=relaxed/simple;
	bh=HV8LeKjunDKSdv4Vc0T3l1XGLdhhd5UaHkHDYrZJLzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWw+HeALxI+MPTPT/1m6CMDXvUG0KxO5Y9DzEtNcPHHQYvsezyMrkRtMv5SWu9OWU/FJ6XAxk0MKhNydsQj/YXQ1jIflSc28skpFxEewKXGIXq9RyvGfYtbOFLhtZG3j8lmqGUp6pMyzvEFLmGHvU8MwBcXEchLtY5NBCFp5d1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8EWH0b+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4080C4CEF1;
	Sat,  4 Oct 2025 09:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759568594;
	bh=HV8LeKjunDKSdv4Vc0T3l1XGLdhhd5UaHkHDYrZJLzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8EWH0b+klPlJBbx7UYfq7KtxLRlB50sGCp0ZifD7Uj7ndbIBOu4+wH1vbtN4FeJ/
	 QKdTBDtTqwoNQmAdeWUpUrmaO3BNhs6Y4UdXYi5Ujbs4BKjvtHCABca7bo5+dVKzCw
	 c5kJV8nD3LHiUHTE1E+S8ddMZlWnwBqGiU4L7fKzPKhNjltKcZF7rcKEId7/wvMTWv
	 o7EFWOooK1FWx16oLQInjVTpiVN8ehV/UDmT9gSbwUcod/c2dK3CVZtGisOXbKrAgj
	 jgsRKSaiVivXrXTSnWk4yZmyYDdOyKV7cehPpOEb0Mvr+dYPJLMfS9CncBuCAH4eDd
	 Zrgi/65wP/ASA==
Date: Sat, 4 Oct 2025 11:03:07 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in
 drain_pages_zone
Message-ID: <aODiywgXvAL5Ia_8@kernel.org>
References: <db51bcc5-aaf6-4cb4-ab62-fed9d40d6caa@suse.cz>
 <20251003100245.8029-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003100245.8029-1-hdanton@sina.com>

On Fri, Oct 03, 2025 at 06:02:39PM +0800, Hillf Danton wrote:
> On Fri, 3 Oct 2025 10:35:46 +0200 Vlastimil Babka wrote:
> > 
> > Also you should really stop dropping CC's on your replies, especially for
> > maintainers of given code. I've only learned in the v3 changelog from "as
> > suggested by Hillf Danton" that there was this subthread. This is not
> > acceptable. When the feedback is wrong and uncorrected by others, it can
> > mislead the patch author to do wrong changes in the next version.
> 
> The Cc list was cut mainly to avoid getting guys interrupted in accident
> with Johannes Weiner still Cced. And nothing more.

Please don't make decisions instead of the maintainers. Cutting people from
CC actually makes it worse because they need then to spend more time
looking up the emails they would have got in their inbox.

-- 
Sincerely yours,
Mike.

