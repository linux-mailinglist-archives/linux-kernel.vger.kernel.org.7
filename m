Return-Path: <linux-kernel+bounces-844941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3308FBC31C0
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 03:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66C13AB7EE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 01:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145CD28E59E;
	Wed,  8 Oct 2025 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R//HYTdh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C08413774D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759886416; cv=none; b=UAuAZnBy1Y0t+lscTK+FOJ+kXdZlBmYfrc3V6XX0EWzZosYb4wzHS4A8oTyjt9qyQtDNv8BQWHDOQO0KnmScJEktDT5MRVasrP3k19I3ZeFpFbYys9yawbh9wdfwAWHKDossKZKZaOAVY3tsgk1tXK54YjaQXrLGBpIw3wPY2jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759886416; c=relaxed/simple;
	bh=RggMqVpCe390gnGrGEqJRdIG6qG4CtpvuczcXMf7cvQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mPZjWxqFZjp1vZnUbxAyoI7e6MZaWRsGMSXThKfC4jSIQ+xxdHeXMYUjx3uUyI+KrjZbPH1mDzKmhXTz9pUhqLKCNtOo3IfSR4hKnj3fTATDEXsT2MB0Feo4gyZwFZT0zuaVAuN64lECaokDQCwH1FhV8j/QNwivSwk93WmC9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R//HYTdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64DBC4CEF1;
	Wed,  8 Oct 2025 01:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759886416;
	bh=RggMqVpCe390gnGrGEqJRdIG6qG4CtpvuczcXMf7cvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R//HYTdhSQqxbhONMMs56VKD4M4Aayke0Qw3/3uFTYr5htKhgRksOzM6PnWOAmm9O
	 ePJQ3W1JyouZ0TN0HQ7ger9uOGa7CuVNayKVJSCCTRwj5wnaXcrbXw9DrWZ1Zhxr7K
	 Fb+ghAFpd2RBXtMscNIkR70l1Ns41uOMUCZ1Ctc4=
Date: Tue, 7 Oct 2025 18:20:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, Kemeng Shi
 <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li
 <chrisl@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, David
 Hildenbrand <david@redhat.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm/migrate, swap: drop usage of folio_index
Message-Id: <20251007182015.cae4a063398cdaac71e47f41@linux-foundation.org>
In-Reply-To: <CAKEwX=OfcTDH08VrTMFL-uQyBay11H=NccYWVo73XNHVVf7bEw@mail.gmail.com>
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
	<20251007-swap-clean-after-swap-table-p1-v1-4-74860ef8ba74@tencent.com>
	<CAKEwX=OfcTDH08VrTMFL-uQyBay11H=NccYWVo73XNHVVf7bEw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Oct 2025 16:48:40 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> > This helper was used when swap cache was mixed with swap cache. Now they
> 
> mixed with page cache? ;)

I locally made that edit, thanks.

