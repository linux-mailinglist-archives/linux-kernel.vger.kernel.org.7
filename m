Return-Path: <linux-kernel+bounces-801836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CC7B44A8D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49F75469F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D22D29A9;
	Thu,  4 Sep 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PZ5Q9uHb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956EE1A76BB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757029631; cv=none; b=SaEgwGuZN9AaJ79Z4c/em1CWQvcfl9SOHgC4Rw9XtstQTDgcIw4yJ2GNqtah0J2Gvnsi0knd4P9Ku8kRvafP8NWn/6uaavee+1hQxwURrC9p9YpqEqU4PCfC3eFi3sNnAXnOrCOBtP3T36emRazJHv+Etj+Gb6dtRm+WEXr/hR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757029631; c=relaxed/simple;
	bh=wBY61Eq9TrYmzEriZktQvbsr92drztU25kt7n6mRRO0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IdlY9H/P0o8+TfIlEucyt5JK3j2Y2O2TIf1u6u3rUyiIKFOYzg19xG9we047izOkDWCtVOTWEHZoMZ9rRXUoOPIMS9P6yB4EqEn25BJOu5uQqIlogp0YgRYjsRZST2x8++VN7ZeQeIugSUgoQ3jBqb3UZfc0e1udFdVJ4lcTI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PZ5Q9uHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8FAC4CEF0;
	Thu,  4 Sep 2025 23:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757029631;
	bh=wBY61Eq9TrYmzEriZktQvbsr92drztU25kt7n6mRRO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PZ5Q9uHbUhKuZcOxdhN8wKAybQx/ha0k6QUz9jeOmyL9u5PkrnGxfRfnpj/7h2CWx
	 j0NUem97OttUtPfXr+ohp2wBfl499zuHANfI3yD8bhB8zFf4rJ6kfQevz2nTKgbTqP
	 7fNJXc79mEDQBbuFHCI7vWMe5aVFj4j7V2zMfVlo=
Date: Thu, 4 Sep 2025 16:47:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: hannes@cmpxchg.org, linux-kernel@vger.kernel.org, Vlastimil Babka
 <vbabka@suse.cz>, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm: remove zpool
Message-Id: <20250904164710.210731847fe25d9419203886@linux-foundation.org>
In-Reply-To: <20250904093325.2768507-1-vitaly.wool@konsulko.se>
References: <20250829162212.208258-1-hannes@cmpxchg.org>
	<20250904093325.2768507-1-vitaly.wool@konsulko.se>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu,  4 Sep 2025 11:33:24 +0200 Vitaly Wool <vitaly.wool@konsulko.se> wrote:

> > With zswap using zsmalloc directly, there are no more in-tree users of
> > this code. Remove it.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Per the previous discussions, this gets a *NACK* from my side. There is
> hardly anything _technical_ preventing new in-tree users of zpool API.
> zpool API is neutral and well-defined, I don’t see *any* good reason for
> it to be phased out.

Well, we have the zpool code and we know it works.  If a later need for
the zpool layer is demonstrated then we can unremove the code at that
time.


