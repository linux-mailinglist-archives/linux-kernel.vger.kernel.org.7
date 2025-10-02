Return-Path: <linux-kernel+bounces-839933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA45BB2C35
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4B619C17F3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B07228C5A3;
	Thu,  2 Oct 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Y0xQFQ8R"
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D12E2F2E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392193; cv=none; b=r3LDdVC955ixFU1hQpON58Q49z0zT5lxUlrDPp07LPwswqNh3xx5WcKbYSsA4PEBTV7sHT7ApqD1W2A8G0Go32k8x6GS/XzDfxBOCqMf1JZpDcn+IYz9nTosANZpRsffYzZGghGRsughqa3e5cNtS7uNUr+JUXTTniCrhaYzKcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392193; c=relaxed/simple;
	bh=lRukIy30LVv7TeGtMbkzrjg9Vy9ZJ2n4W+vI14PJbVE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiuD5DYEgQ9vrTRS1erFm8FelKLLl2KCiH6LxvcbrTTchi87+xULtPC+YzypW0zr1G+LScZyG2kltCko7O5nXjW9Xu+oVPshNh1+t9Ag82R5AccfGuMPN47RUJAWbqZq5spwbEEgU1OZhebmAo5sTZSBdXf0/S3NpMVV1m9G4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Y0xQFQ8R; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759392192; x=1790928192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x6O6oMw804oQZ/Ro+shkMBMYGI7avV6WEQj7MYFI3fw=;
  b=Y0xQFQ8RHwyn0dm35FSbRP299GONxExJBNErnxbzzRLRSfj55p+UBwa6
   XpQ4q8kZBudbJPnwYjgb7ZV6k6BXqDQfWhkUKttW/DEHTYhYXXfQ/WUnR
   wO6Ys1QDt+fDzpyPeeypXc7Kv3a2mUXfFw6LAE3MBk7onmxq5u1jtWLZu
   HENL53aL6cTeIL43Zemx5cH0fSAbi6HU5G6QeGx0K2aIDFaJdYwLnszqi
   QbGw63w72u1+5sZfIbsZbhcfpkxGfu/FWAOiHnak0NxMqDMQShlmp/smO
   Iv/pslFru1L4zrKJFlxMVaX8MPSpbUmwBRlEQTU0pp8gA5ivcXr2Bdgh9
   w==;
X-CSE-ConnectionGUID: Ysj+1pBqSMCNFcJVNcJ0XQ==
X-CSE-MsgGUID: mqx+7wp8RzKMOARc/pMxug==
X-IronPort-AV: E=Sophos;i="6.18,309,1751241600"; 
   d="scan'208";a="4126945"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 08:03:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:14480]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.125:2525] with esmtp (Farcaster)
 id e92ed99c-d82a-4e10-a994-20eb525beca5; Thu, 2 Oct 2025 08:03:09 +0000 (UTC)
X-Farcaster-Flow-ID: e92ed99c-d82a-4e10-a994-20eb525beca5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 2 Oct 2025 08:03:08 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Thu, 2 Oct 2025
 08:03:07 +0000
Date: Thu, 2 Oct 2025 08:03:04 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: David Hildenbrand <david@redhat.com>
CC: <linux-mm@kvack.org>, <akpm@linux-foundation.org>, <xu.xin16@zte.com.cn>,
	<chengming.zhou@linux.dev>, <peterx@redhat.com>, <axelrasmussen@google.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mm: redefine VM_* flag constants with BIT()
Message-ID: <20251002080304.GA26368@dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com>
References: <20251001090353.57523-1-acsjakub@amazon.de>
 <20251001090353.57523-3-acsjakub@amazon.de>
 <98cad9a6-875f-49c2-99b2-389bf4fd9b55@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <98cad9a6-875f-49c2-99b2-389bf4fd9b55@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, Oct 01, 2025 at 04:04:51PM +0200, David Hildenbrand wrote:
> >-#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
> >+#define VM_GROWSDOWN	BIT(8)		/* general info on the segment */
> >  #ifdef CONFIG_MMU
> >-#define VM_UFFD_MISSING	0x00000200	/* missing pages tracking */
> >+#define VM_UFFD_MISSING	BIT(9)		/* missing pages tracking */
> >  #else /* CONFIG_MMU */
> >-#define VM_MAYOVERLAY	0x00000200	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
> >+#define VM_MAYOVERLAY	BIT(10)		/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
> 
> Careful: VM_UFFD_MISSING and VM_MAYOVERLAY share the same bit,
> depending on CONFIG_MMU (9).
> 
> >  #define VM_UFFD_MISSING	0
> >  #endif /* CONFIG_MMU */
> >-#define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
> >-#define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
> >+#define VM_PFNMAP	BIT(11)		/* Page-ranges managed without "struct page", just pure PFN */
> 
> -> 10

Ugh, thanks for catching these!

> 
> 11 is actually unused IIUC.
> 
> >+#define VM_UFFD_WP	BIT(12)		/* wrprotect pages tracking */
> 
> This seems to be correct again.
> 
> 
> IIRC, Andrew prefers not mixing fixes and cleanups in the same
> series if possible. So you might just want to send out patch #1
> separately and, send out patch #2 separately with a note under the
> --- that it depends on patch #1.
> 

I saw that patch #1 was applied so will leave that alone now, but took a
note for future.

For completeness adding the link to v4:
https://lore.kernel.org/all/20251002075202.11306-1-acsjakub@amazon.de/

Many Thanks,
Jakub



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


