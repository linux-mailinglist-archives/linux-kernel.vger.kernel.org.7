Return-Path: <linux-kernel+bounces-855238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06848BE0946
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD6974E1C66
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A071E30BB8B;
	Wed, 15 Oct 2025 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="ER+FfBxf"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FD141C71
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558949; cv=none; b=WgLvevsjghqsKYf+PjND3Nn8sJJLQUBkpFZTv7VUzbpf9qWLRWeAgXokclQIygHR1RzYMZzIKvjxUO0JMqzjzKKMWrT6za9TEwdsL+qHyHkJub8ZjRdAHG5HXAFNyXaW09E+HS/31zFIH8MPMKmWurpHjISHrV/5WrfUgj77kbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558949; c=relaxed/simple;
	bh=hmNyvKf1an5yiOX+KKVIWVcA5Hai3VlOJtsPf67znUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iboVLbOq0GYt4WOqyN/vVBzHri/LaXFf7Gb+QWt4uUEHfHNAmRpc/4y422TsfJcKfcuWWTotmP1xawPUMpvBdi0PWgaaLj7DzcaXJUf7u+ECRZjaRW+v84V2TtnrmTTtzh+T7Vsce/zvgVmHX9emdl/ep+Mnk+WnbDUykuhpyVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=ER+FfBxf; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 69C46932EF;
	Wed, 15 Oct 2025 20:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1760558942;
	bh=QE9+6/UqXy7fEFgnk3w2iHUsxl9kOSZaT4yz9NSkM4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ER+FfBxfjxx+qQF+sKdm5eOSvgvyKc/qweUgWMKkQV4OH4mCoyHiQTcSxNfC7POen
	 iTn1wloJ0iGmGu3mujVFGrzAj9aI1UVzaFZ0eTwlr2l42+w4wqmN0M7M84cqeZWUPq
	 JEsfeT0drWKpkCLAcWWWd4YKCh74AUmCEs9UNj+M=
Date: Wed, 15 Oct 2025 20:09:01 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	hughd@google.com, yangge1116@126.com, david@redhat.com
Subject: Re: [PATCH v2] mm: skip folio_activate() for mlocked folios
Message-ID: <aO__XXIJShKz3-Tn@shell.ilvokhin.com>
References: <aOPDRmk2Zd20qxfk@shell.ilvokhin.com>
 <ltvv3v4vibvlglpch6urayotenavpzxc7klbcyowjb4wrv3e7z@pzovtvtbmnsp>
 <aOaoD0HQk7YPeLkE@shell.ilvokhin.com>
 <20251015125911.0f0ebf87b278324667c4dfc5@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015125911.0f0ebf87b278324667c4dfc5@linux-foundation.org>

On Wed, Oct 15, 2025 at 12:59:11PM -0700, Andrew Morton wrote:
> On Wed, 8 Oct 2025 18:06:07 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
> > > > +		 * They might be still in mlock_fbatch waiting to be processed
> > > > +		 * and activating it here might interfere with
> > > > +		 * mlock_folio_batch(). __mlock_folio() will fail
> > > > +		 * folio_test_clear_lru() check and give up. It happens because
> > > > +		 * __folio_batch_add_and_move() clears LRU flag, when adding
> > > > +		 * folio to activate batch.
> > > > +		 */
> > > 
> > > This makes sense as activating an mlocked folio should be a noop but I
> > > am wondering why we are seeing this now. By this, I mean mlock()ed
> > > memory being delayed to get to unevictable LRU. Also I remember Hugh
> > > recently [1] removed the difference betwen mlock percpu cache and other
> > > percpu caches of clearing LRU bit on entry. Does you repro work even
> > > with Hugh's changes or without it?
> > >
> > 
> > Thanks Shakeel for mentioning Hugh's patch, I was not aware of it.
> > Indeed, I could not reproduce problem on top of Hugh's patch anymore,
> > which totally make sense, because folio_test_clear_lru() is gone from
> > __folio_batch_add_and_move().
> > 
> > Now I wonder does folio_test_mlocked() check still make sense in the
> > current codebase?
> > 
> > > [1] https://lore.kernel.org/all/05905d7b-ed14-68b1-79d8-bdec30367eba@google.com/
> 
> So I take it that this patch ("mm: skip folio_activate() for mlocked
> folios") is no longer needed?

Yes, this is my understanding as well. Hugh's patch addressed initial
problem and this patch is no longer needed.

