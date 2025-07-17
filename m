Return-Path: <linux-kernel+bounces-736047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F5CB09723
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241453AA743
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA7244663;
	Thu, 17 Jul 2025 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fyef/i5f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5C24167B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794477; cv=none; b=apZuACzPMplx4TFbgw2rUK5Ibhwe4mYgK/qBkrV3srfxPnyMah8rQsVDiBKZoYg4lEw2lZtPyHz7eMdAU/DwJHJVfYbEUWRxE6KwEENK3h/l17F1RpiaC6Auza1ug3QI0WCFEwDKlkH/CimZfrPki9V1oiFjG90jmmBULkpROw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794477; c=relaxed/simple;
	bh=zKzFdRaQIlyhe88Eg/D5+roXWbvo5RWDklptJTTE3Ew=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b13DWpJCW9s/LjeiZxSyGqp8mKXFn2xYJCnyQ3spQOTvCLiOebNzXBpFpeAwH7p5JvMFtz42ZXv9Gf84FxAui74V13vpxKwRcW+nwUPTguO/SG5yGQF/tkYVDYC5O8C9A8CKeNKNIpRxaPOtK5DPCWqsGj3WrbBheyNGI/4aogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fyef/i5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177CEC4CEE3;
	Thu, 17 Jul 2025 23:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752794476;
	bh=zKzFdRaQIlyhe88Eg/D5+roXWbvo5RWDklptJTTE3Ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fyef/i5fIwR1T8neqERrObrA+aUiRderdCU6rZ4eGzFwtA96VKHPx5c4BLdQCbvSz
	 ZS13d3ydnHszD3sfTgpSg01HPukaHwBdx9sBZlrdLHQlI8oF/Y2cmVSY/YIms+UN4H
	 XzUscygiRw7ylycj9mx38wDU9O9yRuVArfXjHH9U=
Date: Thu, 17 Jul 2025 16:21:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Kairui Song <ryncsn@gmail.com>, bhe@redhat.com, hannes@cmpxchg.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: swap: correctly use maxpages in swapon syscall
 to avoid potensial deadloop
Message-Id: <20250717162115.18edbb2d71685482a98bcdb5@linux-foundation.org>
In-Reply-To: <e836546e-5146-40fe-5515-0a185b72bdb2@huaweicloud.com>
References: <20250522122554.12209-1-shikemeng@huaweicloud.com>
	<20250522122554.12209-3-shikemeng@huaweicloud.com>
	<CAMgjq7AcMtsS-EX0065jvucLR=YiAvPkjp+rmr=hfxyv9JVW5g@mail.gmail.com>
	<e836546e-5146-40fe-5515-0a185b72bdb2@huaweicloud.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 15:54:21 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> 
> 
> on 5/26/2025 1:08 AM, Kairui Song wrote:

Nearly two months!

> Sure, will add this in next version.

Do we actually need a new version?  Having rescanned the v1 review I'm
inclined to merge this series as-is?


