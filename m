Return-Path: <linux-kernel+bounces-868747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF38C060C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035F5401948
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF533164CD;
	Fri, 24 Oct 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="tOVtoHmj"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8923164B5
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304798; cv=none; b=cH37zg8py0VzE2nI4s1LZkrhcs4DGGVfRgSYMpSXvLzIKhD+96pve0Sm19DThGrHxMpe+4uin6sIsg8cNuWSjC3QDFzlylxd9CgIXMcT45BJrrJyDn3+YOauAB6m2dd+jtAP5RgBKTPnN+j8aB1d2Tq+aTfwKbloqCxPDebu4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304798; c=relaxed/simple;
	bh=/g5G+lWPRVaLGDYH2Wi4deNkocfvvZVGxU+KP7e++NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcac/9INaJKz+k1/B6jDLkmtBZwPux9f120JThqA5rXL1Ft5daKxka1mwX3uRhjVGHI+EbHuqMDlyaoZKUtxa0BtHC2eidgbUVgtYiN6J5hzTVt33nRqtiQWz0iwDKMXbK5Y9OuPoJuf5TRK1i8CP7+NXClzrtAu4HQkLBsP8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=tOVtoHmj; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id AACC39AEA4;
	Fri, 24 Oct 2025 11:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1761304794;
	bh=4HVxnkzUz6NVdQcmcA5Gy6ABoyfmOd7q1+o6lDDzoT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tOVtoHmjYUqKiQGeMmtZVdQo88liG/Y/9xwsGmFX5CXc/WTRyceTjnt0Q7ayTuVG7
	 M6nISb7ajgHNtLOaEjzN8Tdvc4vZltWvJ7/xI1+RHRBi/iH3MhY5uondOSXGSDPf4g
	 /Y8FJBtsIq5AqCO/OFnUv6M7OjGjNb79Dpq2GbEk=
Date: Fri, 24 Oct 2025 11:19:50 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <aPtg1vUnpkaK1Ce5@shell.ilvokhin.com>
References: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>
 <aPstDXRerYqi1O2X@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPstDXRerYqi1O2X@tiehlicka>

On Fri, Oct 24, 2025 at 09:38:53AM +0200, Michal Hocko wrote:
> On Thu 23-10-25 18:12:02, Dmitry Ilvokhin wrote:
> > Allow to override defaults for shemem and tmpfs at config time. This is
> > consistent with how transparent hugepages can be configured.
> > 
> > Same results can be achieved with the existing
> > 'transparent_hugepage_shmem' and 'transparent_hugepage_tmpfs' settings
> > in the kernel command line, but it is more convenient to define basic
> > settings at config time instead of changing kernel command line later.
> 
> Being consistent is usually nice but you are not telling us _who_ is
> going to benefit from this. Increasing the config space is not really
> free. So please focus on Why do we need it rather than it is consistent
> argument.

Thanks for the feedback, Michal, totally make sense to me, I should have
expand on this point in the initial commit message.

Primary motivation for adding config option is to enable policy
enforcement at build time. In large-scale production environments
(Meta's for example), the kernel configuration is often maintained
centrally close to the kernel code itself and owned by the kernel
engineers, while boot parameters are managed independently (e.g. by
provisioning systems). In such setups, the kernel build defines the
supported and expected behavior in a single place, but there is no
reliable or uniform control over the kernel command line options.

A build-time default allows kernel integrators to enforce a predictable
hugepage policy for shmem/tmpfs on a base layer, ensuring reproducible
behavior and avoiding configuration drift caused by possible boot-time
differences.

In short, primary benefit is mostly operational: it provides a way to
codify preferred policy in the kernel configuration, which is versioned,
reviewed, and tested as part of the kernel build process, rather than
depending on potentially variable boot parameters.

I hope possible operational benefits outweigh downsides from increasing
the config space. Please, let me know if this argument sounds
reasonable to you, I'll rephrase commit message for v2 to include this
reasoning.

> 
> -- 
> Michal Hocko
> SUSE Labs

