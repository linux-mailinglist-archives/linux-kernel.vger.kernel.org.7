Return-Path: <linux-kernel+bounces-869530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08C3C08134
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646EF3A62AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40702F60B6;
	Fri, 24 Oct 2025 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K5gTt9g2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42801F03C5
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338151; cv=none; b=ksycLjNhYeqir96UKVcKjwEHAv80zmcR1rTRqlZ8CwQZrSFXVN0gUOSLJLhwfhdCWi7sdALAL/xsSqgkSbwNTduuLoo/TCA6W6RglKPHzo0666TfWeTn/Whcl4e9tnuJR0m0RfeY/IMUSPsHHYvm5IqmCXVRaocGbYnN657wcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338151; c=relaxed/simple;
	bh=nNDhb0QNDoRa6ZvXfD4aEfuJ53EGj0ApN8pv2OtVXHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlaFKkLgjHPoNRrQv5oTPPmVqa5ss3msA8hQOn5rjOqxJ7TpUtiyw72bBwGK428RZFYa4DrLdW9IAt2Uav0tx68VTAmPdHMf5cQSzYuXexnG6Yc7Y4gXWzPtTszebJgv6DTux67cwY8rcZ8dxjj+2a4ccpInzi2iNWirQRKP9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K5gTt9g2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eeXo+CgeDN1hcJ5I7K0VElKLD4LcVB/Am22EAR79xXA=; b=K5gTt9g2rOXKopZUs47HB/gOK0
	3ZKOdJjFiXQwSv+L+GqvHAjvAWzXZbPe9at1Ufbeizwq4gJreYQ0IIB2NdLphzNhMyVLSZfoOnCPJ
	SHih+/nKRCjaVIoFKZr++pCgZgjVS0bT1GnG2hmsWOgSgTYamkVKosdVi96AjUMXUerIFbClVqM1c
	gjROpr8wIsOOzgAIcWwvFyvlK+PL0qHcQ6GhUOskUItRB1D1h1wHFEFaTmLkc6VG+pneTXmbFyyO3
	eGX612yp/qkmD+7uujxSopgyZZVW/0YkWdq/OnFjrSve4eIaShvesz+o72jTk2ivBGC/8ANIJCCsX
	Uv0H2zAA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCOVa-0000000A8wL-2XqZ;
	Fri, 24 Oct 2025 20:35:34 +0000
Date: Fri, 24 Oct 2025 21:35:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
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
Message-ID: <aPvjFuio9lBKf2In@casper.infradead.org>
References: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>
 <aPstDXRerYqi1O2X@tiehlicka>
 <aPtg1vUnpkaK1Ce5@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPtg1vUnpkaK1Ce5@shell.ilvokhin.com>

On Fri, Oct 24, 2025 at 11:19:50AM +0000, Dmitry Ilvokhin wrote:
> Primary motivation for adding config option is to enable policy
> enforcement at build time. In large-scale production environments
> (Meta's for example), the kernel configuration is often maintained

So you work for Meta?  It is poor form to send patches without
disclosing your employer.  That way, we'd all be able to see that the
positive reviews come from your colleagues rather than having it look
like everyone's just "oh, i'm a random developer doing this on my own
time".

