Return-Path: <linux-kernel+bounces-874452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 885B9C165F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E02584EE816
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AF634A3A7;
	Tue, 28 Oct 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DCWAmEM5"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40423D7F5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674385; cv=none; b=PRx3Sv+bezZ7FKULWb3xyx7NSoCXZBt0RyHXG9OOcS1NfgcT/LwixiwAi4bC6OpXk+kLxOfY3oCRtyvzU5yeuawGF+dy/ZN8xwROrv/h3TCMfeQkEweB75XB96ASDL4W3fDHvr1NZ7qQOIUn65vISx0XGiN4j4WY0FrOwOq23Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674385; c=relaxed/simple;
	bh=R8AybmrZDIkqVDjMETd+NmrYSFl4Ytvx6KFwtBxhfsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJNvDN08fjhmUw/q2Aku+YDmEUMdpA6ersjdtZql4+t+LqbJL03xXjHxXFAUXGK/Zfetrp3ljs5gHe4y3SQwnL2+k4/q2lK49hPh7l7g0tZom0q14I9Au+1UEp1ITNJyiWBHt/pe2oqDLgOdqJmzjDB/xIrtlLLaHNfCdqsofac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DCWAmEM5; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Oct 2025 10:59:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761674374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7g17JYwPJ5XpNlfo7q1lNoeZclw3CEprpKdF+EeuB18=;
	b=DCWAmEM5kMQAoqJKRxfn8sRG5ESoCq0u6n3lclOlIDLfIhkiOVzzyuhgSBwh0MQuOM1q35
	sK6i4zEDeQJPRni1K8QfvayPpdAjp7vKdbrgaVF4IjOUsl3FlO6YkurXoLbIH2eDdwQ6cN
	LajKYnDwHySHdt1HnkA9Xv3ZwOwSy6o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vma: small VMA lock cleanups
Message-ID: <nt2rifeuokz73xtzqycguhrvki3vpi2pb24tuv36h6m2oz5fsv@7g33zih37yqx>
References: <20251024090902.1118174-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024090902.1118174-1-lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 24, 2025 at 10:09:02AM +0100, Lorenzo Stoakes wrote:
> We declare vma_start_read() as a static function in mm/mmap_lock.c, so
> there is no need to provide a stub for !CONFIG_PER_VMA_LOCK.
> 
> __is_vma_write_locked() is declared in a header and should therefore be static
> inline.
> 
> Put parens around (refcnt & VMA_LOCK_OFFSET) in is_vma_writer_only() to make
> precedence clear.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

