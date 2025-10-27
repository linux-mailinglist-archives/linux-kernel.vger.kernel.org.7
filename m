Return-Path: <linux-kernel+bounces-872099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43522C0F3E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8311893788
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F61312829;
	Mon, 27 Oct 2025 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="PeKAj31u"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCEE31354F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582224; cv=none; b=lD5sWtEALo5wC5Zjq9vIKrg9ShLFn/FrBZyXxjTjkZ189RSIGD5DfBwW7uxc+tvMEiuYDgpL9F1TckqPdd33jcqt7iSvF+tKWJIeG+tYFcZKXR65L8ci90FHK0g7iHXLhdEpj5+u0L4Br1Ur4BMnWpHmxqp7zRd5cfoeOWej+Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582224; c=relaxed/simple;
	bh=f25N++NAgdwRSTuxCQQR0m+neldoOCz7dXKURFjHH9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyuiZ6Pj4ryJIFXVpGwqdkca1UP9+N4G68c6vci/MUS1J68c4RN2UM6/m3Ne9tVjxM8VyvLARLSJV9CSSYaUSQUD49kfjIqALMFNxL/rxwp84E2Le2GE78vPKhRFo0sL5fmCjfJeospjEalenI4eOsdP/xK5Pls3FKXBU9MIfnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=PeKAj31u; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 0BA9B9AFE0;
	Mon, 27 Oct 2025 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1761582220;
	bh=3Wd9jZ/xyaKFNfuiEgH09msyR8RuNPw1/jIEYWNk9Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PeKAj31uvlVwbZ4JZNdYKIZMrxmBSQwHpD5PTMWrucnMR8OgH/xH1+4UnNnm95dSL
	 /uW4LjH0fPhJ+uLcbRwguuYGrdZ+Q6Rg6pv9EaD3nrRXZQVj5z/I8LMrk96D0hs5Gh
	 owBQTp2y9quYMHcLtYo2CqlP/kUC5Nr747hbhC7A=
Date: Mon, 27 Oct 2025 16:23:36 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: shmem/tmpfs hugepage defaults config choice
Message-ID: <aP-ciK_NsCPFZLHZ@shell.ilvokhin.com>
References: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>
 <aPstDXRerYqi1O2X@tiehlicka>
 <aPtg1vUnpkaK1Ce5@shell.ilvokhin.com>
 <aPvjFuio9lBKf2In@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPvjFuio9lBKf2In@casper.infradead.org>

On Fri, Oct 24, 2025 at 09:35:34PM +0100, Matthew Wilcox wrote:
> On Fri, Oct 24, 2025 at 11:19:50AM +0000, Dmitry Ilvokhin wrote:
> > Primary motivation for adding config option is to enable policy
> > enforcement at build time. In large-scale production environments
> > (Meta's for example), the kernel configuration is often maintained
> 
> So you work for Meta?  It is poor form to send patches without
> disclosing your employer.  That way, we'd all be able to see that the
> positive reviews come from your colleagues rather than having it look
> like everyone's just "oh, i'm a random developer doing this on my own
> time".

Thanks for the feedback, Matthew. For transparency: I work for Meta, and
this patch is being submitted as part of that work. I know it's common
for many contributors to submit work-related patches using personal
emails, but I can understand your point and appreciate the guidance.

