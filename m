Return-Path: <linux-kernel+bounces-796641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367BDB404F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8DD3A220A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ECD30649C;
	Tue,  2 Sep 2025 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="K3mhGzre"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038423101D5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820466; cv=none; b=LPZWa1ID8fILddAFTGc5urCZWgnrM+SLndRJSl4jX2gGVm7UeuOr3ByMBADYUghALF2IM9DQekvC8unAQe4trEQUi5IqoIJd/cbvPr0cu/kIon3xMtQTyc/DXOOoOzYZsIsYtBGc6cYydXt/qCXIfNXRlay6S2/RF3rB156T6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820466; c=relaxed/simple;
	bh=+yXn8SmnzMbiBKXcR89kb31iTU8IclLF/1cbqyO8+IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/Yl3ynUEJVL/sGXhB9ikY6stEEuL1nTlkET+wGolUnTTDyRsZfKMJ4qNOSB0jPLi8ZoBZ7Ps+toDOGDWeBjeFT7V1TIIwTLOHtDQtShbj6xSDB6RQNbF1TifMdNsvLoaQDPlL4iPM3149z5gc5w3XgZEijdKL6NZhWMoGUCt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=K3mhGzre; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cGRhr0yqXz9tgd;
	Tue,  2 Sep 2025 15:41:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1756820460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywssiw/YaYwXrQoqZBjHzV6kBM/9ffLqYweAJQR0/Tc=;
	b=K3mhGzreM+Xd/rnTCuWWyyeeSQURhtz9MzSVz380rrhsQLXWop33JBz326eCtL2131w2UG
	nZvkOhGuSxD0qT+X4QQVW3iEwUsfRPbj/MRB8Uwv6gO1t44dXfCrN2nOBSwGbmBOuQz/uC
	n0AePi5MebOJaXOb8Aj69FVewcca8yT0bWwNu5lm6zbFBYthSI2JbYX6e8/LhvJ3owdpMj
	67qy/o5CuUV9hC4kVnoYQux+baZ3eFeoReIxP/KKGDDe1rvlrmEqOXf33QaS6rJr9KQ1Mh
	hB2muN1xq55leopbH/Z7qXtphKdkuT6n7IXwrbd9mehYx/vEBcsgzeDCzmzdGQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Tue, 2 Sep 2025 15:40:39 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: David Hildenbrand <david@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, mcgrof@kernel.org, gost.dev@samsung.com, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
Message-ID: <ic5kobuxfm4zi6agfvosjxs325mdgrfpjz52mi3zn27epbuvef@z5dmowge6uyb>
References: <20250902084036.208921-1-kernel@pankajraghav.com>
 <qh7s3j26aac3hyzgnr2ee6byjenstxhjnlwn4qxbvz2l32ohqc@qbhdxvpnuhtp>
 <90cd5be7-cbe6-42c5-b0eb-bf9613047097@pankajraghav.com>
 <6l6f5idkqebpai6qn6n3phbnydz55typdwmvp3eexwnhk4qr54@otcgssegyqke>
 <519df8fd-b02d-4b4b-bf47-79070e3d2c9e@pankajraghav.com>
 <h7pqst5vvkahposrvf2iy5qz53t4crrujold2ky4ssrpawaefv@yaqaj3so2hxi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h7pqst5vvkahposrvf2iy5qz53t4crrujold2ky4ssrpawaefv@yaqaj3so2hxi>
X-Rspamd-Queue-Id: 4cGRhr0yqXz9tgd

> > 
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 48c4f91c5b13..4ddf9e87db91 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -588,21 +588,29 @@ static inline int
> >  split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> >                 unsigned int new_order)
> >  {
> > +       struct folio *folio = page_folio(page);
> > +
> > +       VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
> 
> No. Make it unconditional. The point is we don't expect to see any
> splitable folios, so no reason to get here at all.
> 

Got it.

Just one question though, in a future world where we remove the
dependency between large folios and THP, then we can revert back
this change to do a conditional WARN_ON?

--
Pankaj

