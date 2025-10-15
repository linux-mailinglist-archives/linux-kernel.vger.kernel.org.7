Return-Path: <linux-kernel+bounces-855234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63545BE091E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9284D504F83
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87A0305E1D;
	Wed, 15 Oct 2025 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qjt3Df5d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5DF2561B9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558352; cv=none; b=FUs51Syr8heoT1+B1WHUoNAmCntV0p7P06aET/NcLFXUDy/h1YsgUpdu8rsyg6DEr2/mnqV+E1h/Gi1SozzXCTwOSz8Up1mioaZ/8KQ20UDxaV7ApRjFO6KCdt3Yck0OuzczzDjLu+BQuxOm9AvUU0ElUVfjEgh0JjCoeiZB/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558352; c=relaxed/simple;
	bh=qWmg0NtlX9VEzTpgvqIlBglFj3zmXkbFtSVVHicvZOg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KaMrOIvH1H1mv/f9nxFhHX/sLEjWJlB7fxMxlpGSQ+E7X475QgnUN5woghjUzWgrusqLsT+HTtQjC5KjVs9MGZnmWv8vXk+9FAwYaifXlBTEOqNQRaHkK0AinNPamt52P88VHyvhYVOafttPlQRcc+FQUkkSg4sXpagEkAMxn0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qjt3Df5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A919CC4CEF8;
	Wed, 15 Oct 2025 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760558351;
	bh=qWmg0NtlX9VEzTpgvqIlBglFj3zmXkbFtSVVHicvZOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qjt3Df5dghFnppzxr1Z54A55GDwmn1BhOWImmYBXkhS00UI0huJ55xgj1k80c9ZCu
	 /mjbrq+At/yTHDeZQp+bSHvshZA9aoGwJ7X+0tUTXv4FG+GvMM8z1DDKrH9VY42TnN
	 9iHcaDGvEo4uwo2agKjlBrNA6kO1bIAE399RxTyg=
Date: Wed, 15 Oct 2025 12:59:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Kemeng Shi
 <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, Nhat Pham
 <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song
 <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
 <weixugc@google.com>, Kiryl Shutsemau <kas@kernel.org>, Usama Arif
 <usamaarif642@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, hughd@google.com, yangge1116@126.com,
 david@redhat.com
Subject: Re: [PATCH v2] mm: skip folio_activate() for mlocked folios
Message-Id: <20251015125911.0f0ebf87b278324667c4dfc5@linux-foundation.org>
In-Reply-To: <aOaoD0HQk7YPeLkE@shell.ilvokhin.com>
References: <aOPDRmk2Zd20qxfk@shell.ilvokhin.com>
	<ltvv3v4vibvlglpch6urayotenavpzxc7klbcyowjb4wrv3e7z@pzovtvtbmnsp>
	<aOaoD0HQk7YPeLkE@shell.ilvokhin.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Oct 2025 18:06:07 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> > > +		 * They might be still in mlock_fbatch waiting to be processed
> > > +		 * and activating it here might interfere with
> > > +		 * mlock_folio_batch(). __mlock_folio() will fail
> > > +		 * folio_test_clear_lru() check and give up. It happens because
> > > +		 * __folio_batch_add_and_move() clears LRU flag, when adding
> > > +		 * folio to activate batch.
> > > +		 */
> > 
> > This makes sense as activating an mlocked folio should be a noop but I
> > am wondering why we are seeing this now. By this, I mean mlock()ed
> > memory being delayed to get to unevictable LRU. Also I remember Hugh
> > recently [1] removed the difference betwen mlock percpu cache and other
> > percpu caches of clearing LRU bit on entry. Does you repro work even
> > with Hugh's changes or without it?
> >
> 
> Thanks Shakeel for mentioning Hugh's patch, I was not aware of it.
> Indeed, I could not reproduce problem on top of Hugh's patch anymore,
> which totally make sense, because folio_test_clear_lru() is gone from
> __folio_batch_add_and_move().
> 
> Now I wonder does folio_test_mlocked() check still make sense in the
> current codebase?
> 
> > [1] https://lore.kernel.org/all/05905d7b-ed14-68b1-79d8-bdec30367eba@google.com/

So I take it that this patch ("mm: skip folio_activate() for mlocked
folios") is no longer needed?

