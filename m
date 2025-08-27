Return-Path: <linux-kernel+bounces-788875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B57DEB38BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE687189526B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9C030DEA3;
	Wed, 27 Aug 2025 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J3meIb1R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737B30DD19
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331313; cv=none; b=rSzScnmGx441Kpplici+Fhi8ZotPKNsaKg1MwUesg8DP6sQwVZx241qZnUs88kYrp+YByD8noVP97116AOPR7hs3BVf7Kz4sxJpdNrw7RdvQ+rb3JDfD6ETyXbNmEVGIX1hSGFroXbciTeO7XPLF+mGnO1XEU7tGTAVobYexGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331313; c=relaxed/simple;
	bh=wxEepMxFMucuVNOWTttN26FKUa4fU/adFqguDNxZrX4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ccaff3gY2sc3bjz08BmnUYZJjbcM8klAh665WajRhqVvnlagpfQ3AT8EhWk518GdeSB24JpJg/6tpDj83xf5dvcGAggY3QSWfecHiOjE2WSQBUoExkx8VU6ChGhwITyJ1dX4wdo823xVKLvJ7m8GYHuFR0ax5r4Ie42xwQpubQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J3meIb1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB648C4CEEB;
	Wed, 27 Aug 2025 21:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756331313;
	bh=wxEepMxFMucuVNOWTttN26FKUa4fU/adFqguDNxZrX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J3meIb1RK2YZnMMG7UCvwivy9aKF/I3vkmftYzJ7hn5Mwbk7tjwH9r5FMlizxAufA
	 Yrqdl6ZAgo5WRmHdJFE572ZlA9c/pBBJw6J9yTm5WmyGaczBcvfOefOAEhQRZ+6MNt
	 95+lqa4PTha8j3+MIyAUuzozy+ap4IzfoNt0ViLk=
Date: Wed, 27 Aug 2025 14:48:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add `const` to lots of pointer parameters
Message-Id: <20250827144832.87d2f1692fe61325628710f4@linux-foundation.org>
In-Reply-To: <20250827192233.447920-1-max.kellermann@ionos.com>
References: <20250827192233.447920-1-max.kellermann@ionos.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 21:22:33 +0200 Max Kellermann <max.kellermann@ionos.com> wrote:

> For improved const-correctness.

OK...

>
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -537,7 +537,7 @@ struct address_space {
>  /*
>   * Returns true if any of the pages in the mapping are marked with the tag.
>   */
> -static inline bool mapping_tagged(struct address_space *mapping, xa_mark_t tag)
> +static inline bool mapping_tagged(const struct address_space *mapping, xa_mark_t tag)
>  {
>  	return xa_marked(&mapping->i_pages, tag);
>  }

I'd actually be in favor of making all incoming args const (C should
have made this the default).

Because modifying an incoming arg is just obnoxious.  That value should
be viewed as part of the calling environment and should not be altered.

Try modifying a lengthy function and wanting to get at an incoming arg
only to find that something in the preceding 100 lines has gone and
messed with it.  Or forget to check fr this and get a nasty surprise when
testing.

Not that I'm suggesting that someone go in and make this change.

On the other hand, it would be neat if gcc had an option to warn when
someone does this.  I bet it would be simple to add.

