Return-Path: <linux-kernel+bounces-871918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B44C0ECD0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB41D1891EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BBD2C21DC;
	Mon, 27 Oct 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="0OA03ObG"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D172C0F91
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577251; cv=none; b=Pdpgq/Gs+lYths7/GqZ3rGgAO/ehLUnuF4ndGNJiYS5FpmgQ9bGqcRcxjROD1lDAwEIK5EWHLdnVDVgd6JIDqkBUOm3xZhlOHk+s9BnHn97IW/0h78IwQJ0BFbj1txY58yJvzYaPAWvlgoGUaBnXfJKc37l3e3Q91kvRjs6Bs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577251; c=relaxed/simple;
	bh=WYoVqdGGgU4dBUZg/kZ3a2piuxkOHNOjy/8KF8CKI/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nr+xzgHQjTJoKKp7BX5D/MT41qfN7z9VveQvgtBITV70YsAXOIh0V58QC5c+YfYpolg2CDGCZtmyeMR8vAzETc4jJjNQAK0zgWIt/DXOsnsNNQFupUTO4bQyrf5zfFdupi5KdVzWYdm1JQ20g+X/v4FnW1IvTnAimH5eSPeevO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=0OA03ObG; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 313B39AFCD;
	Mon, 27 Oct 2025 15:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1761577242;
	bh=CN7U7He+kRo4ITOtEJtKAVIRmgMIfl0h1hsDAJ7PytY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0OA03ObG2z0vmHiOHSt7uFjNLbluACjBfJof0coJZCaG0d1E/N7GCIB4ruTan95J3
	 z8XmIo1uk+5nMlNK2Mnc58vapMPFO8tqjJi847snLlw0gzXM8iCI0RoClPgjE2q31x
	 GOtbNu37pGeJMnukJRCaWHflXNmQ3+9+wUF+VvBA=
Date: Mon, 27 Oct 2025 15:00:38 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: shmem/tmpfs hugepage defaults config choice
Message-ID: <aP-JFqlCE6ee5_Ln@shell.ilvokhin.com>
References: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>
 <5dt6roxyx3h4zojls7cvr4nyjtahi33ti2sir2ijr3w4wjliyz@fl32rra6phll>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dt6roxyx3h4zojls7cvr4nyjtahi33ti2sir2ijr3w4wjliyz@fl32rra6phll>

On Fri, Oct 24, 2025 at 09:27:39PM +0100, Pedro Falcato wrote:
> On Thu, Oct 23, 2025 at 06:12:02PM +0000, Dmitry Ilvokhin wrote:
> > Allow to override defaults for shemem and tmpfs at config time. This is
> > consistent with how transparent hugepages can be configured.
> > 
> > Same results can be achieved with the existing
> > 'transparent_hugepage_shmem' and 'transparent_hugepage_tmpfs' settings
> > in the kernel command line, but it is more convenient to define basic
> > settings at config time instead of changing kernel command line later.
> 
> Why do you need these options instead of using CONFIG_CMDLINE?
> They should pull off exactly what you want, but without changing the kernel?

Thanks for the suggestion, Pedro. I think CONFIG_CMDLINE could work, but
for this purpose it doesn't seem ideal. Relying on CONFIG_CMDLINE isn't
a very scalable solution, since over time it tends to accumulate into a
long, unstructured string that isn't validated at build time. It also
mixes configuration layers: build-time policy and boot-time setup, which
makes the resulting behavior a bit harder to maintain in the long run.
So this approach is mainly about improving long-term maintainability and
operational clarity. I hope that makes sense.

> 
> -- 
> Pedro

