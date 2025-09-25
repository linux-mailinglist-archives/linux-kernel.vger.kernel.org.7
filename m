Return-Path: <linux-kernel+bounces-832360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 581A0B9F132
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0E94A1587
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D50C2EBB99;
	Thu, 25 Sep 2025 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Wexx5dWx"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E91114
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801757; cv=none; b=uqpfI81Icsm90JW8n34dB8pflkg+hAXU0O1xiOyW5N7XQ6oXEkWV4N0bX5npQ9B1nn/IuSDr+aMgzGCwW4Opt0cg09xCcmvoNLFD0jRK0Ygq58TKIPahlUnTIiPAsbMKNki9V1VMUuAXazp/3F0O4ruY7FDbm4MpFDyR3hqwUy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801757; c=relaxed/simple;
	bh=4zRMH/3+TUT5RpQmbQ4ZOXAf+n5jZP16OQxcRyiQ/j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezxuGFd9339xlVRkhmGs/c/9IjG06n3lXBf0xe5HjKAmem7fIGGkV7Tr4iG5Ujvcc56v5N/egP7JtC4UFLhWldugXcj73e14F+BmeuE398IUkl+DTDr/qPmSZftnb22jGh6hQ+xhMFp3iqnLGVu1HSQtTbKLtzTgwcsTonP72YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Wexx5dWx; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cXXQc1yyMz9sZc;
	Thu, 25 Sep 2025 14:02:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1758801752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YsYSsjXHoCZf1yDpNVGLxhHA3dngJtQSAS0a5Tx4PA=;
	b=Wexx5dWxo8RpKBddDVUpjHMylP0trukOxHItpqb57jd9Wb72VCle/wWI2Y1l+8veGppj3i
	uhoKkU+FQgEUN1PPZBmlFBqPI69UVT/QtCMqiKm8IZ5vybB0iziaP4VLRuKF7Q6NOMZzZd
	pObcjnoeAS/XgXJZJI5zlockMFbZex7KBtXjEKutGf/Sf2B38+pJs9s9w1MPuR58ZeD6hN
	8tyF16Oj6HAbpGbx2S7AUq8/i+x/3DL9inYcGzkPJ4MA+eZ12RdrZpgcMzZ5bpihwPgILf
	5ZIPWkgTaDfNvfILyOFgrLAPJOnplN6/fk+blBQzqaWqcrRZ04k0bwh0XI1bSQ==
Date: Thu, 25 Sep 2025 14:02:23 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linmiaohe@huawei.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nao.horiguchi@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
Message-ID: <fzfcprayhtwbyuauld5geudyzzrslcb3luaneejq4hyq2aqm3l@iwpn2n33gi3m>
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
 <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
 <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
 <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com>
 <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
 <E82638DD-9E5D-4C69-AA0F-7DDC0E3D109B@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E82638DD-9E5D-4C69-AA0F-7DDC0E3D109B@nvidia.com>

> >>
> >> We might just need (a), since there is no caller of (b) in kernel, except
> >> split_folio_to_order() is used for testing. There might be future uses
> >> when kernel wants to convert from THP to mTHP, but it seems that we are
> >> not there yet.
> >>
> >
> > Even better, then maybe selected interfaces could just fail if the min-order contradicts with the request to split to a non-larger (order-0) folio.
> 
> Yep. Let’s hear what Luis and Pankaj will say about this.
> 
> >
> >>
> >>
> >> +Luis and Pankaj for their opinions on how LBS is going to use split folio
> >> to any order.
> >>
> >> Hi Luis and Pankaj,
> >>
> >> It seems that bumping split folio order from 0 to mapping_min_folio_order()
> >> instead of simply failing the split folio call gives surprises to some
> >> callers and causes issues like the one reported by this email. I cannot think
> >> of any situation where failing a folio split does not work. If LBS code
> >> wants to split, it should supply mapping_min_folio_order(), right? Does
> >> such caller exist?
> >>

I am not aware of any place in the LBS path where we supply the
min_order. truncate_inode_partial_folio() calls try_folio_split(), which
takes care of splitting in min_order chunks. So we embedded the
min_order in the MM functions that performs the split instead of the
caller passing the min_order. Probably, that is why this problem is
being exposed now where people are surprised by seeing a large folio
even though they asked to split folios to order-0.

As you concluded, we will not be breaking anything wrt LBS as we
just refuse to split if it doesn't match the min_order. The only issue I
see is we might be exacerbating ENOMEM errors as we are not splitting as
many folios with this change. But the solution for that is simple, add
more RAM to the system ;)

Just for clarity, are we talking about changing the behaviour just the
try_to_split_thp_page() function or all the split functions in huge_mm.h?

-- 
Pankaj

