Return-Path: <linux-kernel+bounces-836195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610FBA8F90
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2B83C2E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFE12FF66A;
	Mon, 29 Sep 2025 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="BFr9qwPG"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C82FF677
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144141; cv=none; b=uJw1pMSpalqFQGwVdo1tpsasQ345HmXKrg4GuhG95Ojx/nuNSqCGUML0foCn91OpXXYEvFBZqR710tsztTtYoRwoSq61TUARG4XqrbYNLyYwBkx+vV9VzzUQjjCS/jn19PFY4B9VFwHSkz/pJBHZ7OxA1OJPj7CGTRY1XeDCFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144141; c=relaxed/simple;
	bh=z9rAk77Or04lznOmurKlQG94eT5OBpd/NEjeL8xIOsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0AmzZ6COkSIYSeR6uL1oAby2mYXL/f73VVnxicysWbrksHpLNnCzIjgn4Qkq3Y+Tv7dArAgW4LxMkMTXG++O4uOVbEHcbbMaA0H4Svb1sBj7DbRQa0LzEzddHgDiP0eZkP68eqY/tDG4t9mgORwzC3lw0DdvQe6HZjxD9P7xhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=BFr9qwPG; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cZz2t71STz9v83;
	Mon, 29 Sep 2025 13:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1759144135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIkbgwB61F3CFgvTxKLtgC2iQ5qBPi72OUA4jDc13Rs=;
	b=BFr9qwPGCVOcL5z8nMNsXDm3b1xc5f1vVoE+XByhUj9zv+ygRPS6k4UYgDoAB9RRo/Xv2T
	PUXOs6ILjNZQjoOajat8A+E6ycbrJaLlImyN7HFpbS4Ui8YgettdYjxtk2GsAQuMEnz+wF
	9Ib6tB41iGYeoMDRnJMmyHyn5oL+jpZ6JxCAc3IhMw+U+Vk+GBnJtAkWIwm+ayy9BNiNDq
	0Jl4qA/7DndQ2g78RRRdWy1YS1hdfBtXlLYwfTxn78gfSf20oZFlY3hQ9pPBSEtsepgSSF
	RbiWrd8SVNx5bERD1Va1zIzi/pkRNd31hHSjsv+JMYlb3kR2WcmCTTfpm9oF9w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Mon, 29 Sep 2025 13:08:47 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linmiaohe@huawei.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nao.horiguchi@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
Message-ID: <w2kwxcd6br6h4tdn6xigtuf73qklt6jhxvhtcwp7idugycgxlv@vqjx26vrnwu5>
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
 <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
 <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
 <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com>
 <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
 <E82638DD-9E5D-4C69-AA0F-7DDC0E3D109B@nvidia.com>
 <fzfcprayhtwbyuauld5geudyzzrslcb3luaneejq4hyq2aqm3l@iwpn2n33gi3m>
 <80D4F8CE-FCFF-44F9-8846-6098FAC76082@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80D4F8CE-FCFF-44F9-8846-6098FAC76082@nvidia.com>
X-Rspamd-Queue-Id: 4cZz2t71STz9v83

> 
> I want to change all the split functions in huge_mm.h and provide
> mapping_min_folio_order() to try_folio_split() in truncate_inode_partial_folio().
> 
> Something like below:
> 
> 1. no split function will change the given order;
> 2. __folio_split() will no longer give VM_WARN_ONCE when provided new_order
> is smaller than mapping_min_folio_order().
> 
> In this way, for an LBS folio that cannot be split to order 0, split
> functions will return -EINVAL to tell caller that the folio cannot
> be split. The caller is supposed to handle the split failure.

IIUC, we will remove warn on once but just return -EINVAL in __folio_split()
function if new_order < min_order like this:
...
		min_order = mapping_min_folio_order(folio->mapping);
		if (new_order < min_order) {
-			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
-				     min_order);
			ret = -EINVAL;
			goto out;
		}
...
> 
> WDYT?
> 
I think it should be fine as along as we return an error if someone is
trying to split < min_order for file-backed folios.

> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f327d62fc985..e15c3ca07e33 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -387,34 +387,16 @@ int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
>   * Return: 0: split is successful, otherwise split failed.
>   */
>  static inline int try_folio_split(struct folio *folio, struct page *page,
> -		struct list_head *list)
> +		struct list_head *list, unsigned int order)
>  {
-- 
Pankaj

