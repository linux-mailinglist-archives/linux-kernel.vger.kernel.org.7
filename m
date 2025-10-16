Return-Path: <linux-kernel+bounces-856949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF02BE5846
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4BD19C78A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94352DF3F2;
	Thu, 16 Oct 2025 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K7VK4UUz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C32A229B12
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648856; cv=none; b=LOc98MUsp0uJsqwkWkjF3bYTL9V0mKsdj8gXCwF2I+yxFvXf3Zk53LbsBlKIzMEbw6euKd2NTYBjXM/1uIrEka6oi3qQgHR0+ffmFmTMIoiKkMcD2TEFaq97W3tuct0uvs4izyCrgPjSB7IHcVZQUVhkKR3zFOGxawRjqUvQZRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648856; c=relaxed/simple;
	bh=qDT0KpgNjvnYSFEGuNHvVnzxlTGK5dEK3a6ypkudwFw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ayV4r5d2H2a/Cllnr6sJBM+zpCitoK2qw4zTuy92MBoNDiGpEMrIcnfNZomhq/O+T+ESRhHNiL2zPaaZuomJ3EoI/3evr1slwnn5lbURHh746As03WJfrmASmbeCTt0hrCPSTj8szWB8sEieKqUD7QWj+eldlahEEdeDt0CG/HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K7VK4UUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBC6C4CEF1;
	Thu, 16 Oct 2025 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760648855;
	bh=qDT0KpgNjvnYSFEGuNHvVnzxlTGK5dEK3a6ypkudwFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K7VK4UUzlBeno/ZXpjhVi7RxZgfZl5QaIUeY1jFwAMEbdr8lDVRJHtatM2AjUiMJ1
	 p97wvvgOwVmto4SINkte2R0PzAaomFcle8VBJ5P8L0URKA2ABvRxOTwWpGLuxY3vHX
	 w4jzmEDGoKR9DY5OGfii55hgCg07wkP1RssNBoLc=
Date: Thu, 16 Oct 2025 14:07:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 craftfever <craftfever@airmail.cc>, Chengming Zhou
 <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
Message-Id: <20251016140735.d7d4c282f0fbf22954a4b4ee@linux-foundation.org>
In-Reply-To: <20251016012236.4189-1-pedrodemargomes@gmail.com>
References: <20251016012236.4189-1-pedrodemargomes@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 22:22:36 -0300 Pedro Demarchi Gomes <pedrodemargomes@gmail.com> wrote:

> Currently, scan_get_next_rmap_item() walks every page address in a VMA
> to locate mergeable pages. This becomes highly inefficient when scanning
> large virtual memory areas that contain mostly unmapped regions.
> 
> This patch replaces the per-address lookup with a range walk using
> walk_page_range(). The range walker allows KSM to skip over entire
> unmapped holes in a VMA, avoiding unnecessary lookups.
> This problem was previously discussed in [1].
> 
> ...
>
> Reported-by: craftfever <craftfever@airmail.cc>
> Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>

Is Fixes: b1d3e9bbccb4 ("mm/ksm: convert scan_get_next_rmap_item() from
follow_page() to folio_walk") appropriate?  

The problem which is being addressed seems pretty serious.  What do
people think about proposing a -stable backport of this fix?

It would be better if this changelog were to describe the user-visible
effects of the problem.  A copy-n-paste from
https://bugzilla.kernel.org/show_bug.cgi?id=220599 would suffice.

