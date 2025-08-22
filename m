Return-Path: <linux-kernel+bounces-782532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD52DB321A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7057160204B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C32291C07;
	Fri, 22 Aug 2025 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vFZeOZTy"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D3223707
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884662; cv=none; b=pXkxzhlPGrabt59OQ6/X7lgnWwS6l4F3Stk1CU/5MEtTYG6bitkIiI4qJKmRzKOI/pEM9kVQPLroKwooirc/UtbNgGolYsdctg4EyKGgFyNQyaOJAC2W2vOZjjqdQ4wP4bz+ERcaMbhQIYvCZ55rDBpsC6ot6a9umCixjfbF9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884662; c=relaxed/simple;
	bh=tzTExOjQ48Ssla6xpsmnhOcQtYk334/k0063efP0+Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK228wNTmLCUzUK1kQbD0SGpV33tDS79IFSTDu2vDI2qJd7dwFoOfZfG6ptQRy7d2gHC3oX31C/mVLQi3I4JwPP4N9xoPk+1Pk0xsjpDqo8RAC+DgtYnpByNuIdc9V9QFFA1kg98YiJB0S/YMD2os6j6sUs7e3OhhuuqZSu7FpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vFZeOZTy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oTJjicaLJIAJUskoLvi8hPpWtcjqd5f2viAMGrcaP2k=; b=vFZeOZTyAO289lSSB71sUt6gZB
	0azEL/iAAphj41V/24KeFpAICY6Bom7PP6OnoHsBKpmPI198Ep+4SJ8R7vybYuetXCgU995YhU4AS
	SM/JfEis1gbqev05PEOPnxXjz7PYeNMQ5Moib4kIsM0eDUEHfcpPVs6r6ZssJXv5RZBBy2/kBBASO
	c3lHbFVFZWz2hACto4ESS5Z1PFvDsplNg9KrmOschrtQuzmB+Xs4XNwkNCKzTnJ6MCy9Sf23gzgk0
	DvWG+IS/5Llh57rcxgfcjiCIz/OTUzxl7exOnK2s0sEXSQdRacX0WDacdty9A1kinQMHrkyOv+FcM
	Hm/ks5Dw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upVoE-0000000AnCH-0Ctc;
	Fri, 22 Aug 2025 17:44:14 +0000
Date: Fri, 22 Aug 2025 18:44:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	android-mm <android-mm@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
Message-ID: <aKisbbkNcuZoT2RB@casper.infradead.org>
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>

On Fri, Aug 22, 2025 at 10:29:52AM -0700, Lokesh Gidra wrote:
> Currently, some callers of rmap_walk() conditionally avoid try-locking
> non-ksm anon folios. This necessitates serialization through anon_vma

... this seems awfully familiar.  Why did you send it again after
a bunch of people had already said useful things on that thread?

