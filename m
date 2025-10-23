Return-Path: <linux-kernel+bounces-867805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED09AC0388B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD39D189C15C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D71DB375;
	Thu, 23 Oct 2025 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wYV2zcmB"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE529BDBF
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254776; cv=none; b=G5w3PVSdZcX2Cw5zZwWcCX2sMr+bTOYWpqjqUw7Blyo2+aVqaLuE0aEmKQ6QBQqL/lH+uC06GwQLAKBGQ6mhVyqrkQWRN1Vcavlr9M0St24WrzzfC0G3kFsXwTWOUi6ydmdJq1ibiV8k8D4w+XBnht9zXROtcerxph/iZFbEdP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254776; c=relaxed/simple;
	bh=NA/Uynk98eyPe7Rxvc3ztg3H9t5Rmt8BnTpDkbe7wMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+nK7c1bA+JBeyeRgmH5+4CJmVOWBcgk4Czwg3L7M3oa1uu5b3Aa2zqqN+EYQ30HBL/6022Zqe79S99IwlYZ9Lw5mAwrhmrLyrDcMm0NUSES8QiXUvuULGf44NvDBe5/G+9gfsfdlxYz/ABLUvoE0wEeI9sLRBuYYzDTCBCfxGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wYV2zcmB; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 23 Oct 2025 14:26:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761254771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVbxmFxkl5Gkpe0F49DlJZc2pZ5lmn7pCYA6JciiN2A=;
	b=wYV2zcmBHINwgvFe5hylpssfqut5+tSqdMSSDkNybl3VoXsDgkxkxs1ry9cBMJxmIycOsl
	qKxv/pCm6HltrpbLM7Pj/D0LJWRiRYTmuZeKMiqgs692fHvXuG5g7+rxYWOPRP70H5az0j
	TIVT3vVLFcGjo4sdBN6Lnw+dY2ztErE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: shmem/tmpfs hugepage defaults config choice
Message-ID: <qjqtaukb3yw36eiwktayyv4zhihgz32yy2yolpqvxn5yaeuo3i@fvznetjxhker>
References: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 23, 2025 at 06:12:02PM +0000, Dmitry Ilvokhin wrote:
> Allow to override defaults for shemem and tmpfs at config time. This is
> consistent with how transparent hugepages can be configured.
> 
> Same results can be achieved with the existing
> 'transparent_hugepage_shmem' and 'transparent_hugepage_tmpfs' settings
> in the kernel command line, but it is more convenient to define basic
> settings at config time instead of changing kernel command line later.
> 
> Defaults for shmem and tmpfs were not changed. They are remained the
> same as before: 'never' for both cases. Options 'deny' and 'force' are
> omitted intentionally since these are special values and supposed to be
> used for emergencies or testing and are not expected to be permanent
> ones.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>

This looks good. I would recommend to also update
Documentation/admin-guide/mm/transhuge.rst with this build config
information.

