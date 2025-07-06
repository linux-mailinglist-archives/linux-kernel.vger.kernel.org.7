Return-Path: <linux-kernel+bounces-714947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90302AF6EC4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 11:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364381C82C32
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC42D8791;
	Thu,  3 Jul 2025 09:31:27 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1CA242D80
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535086; cv=none; b=CUxNFWBNeJ7qqB4IsLjNguecarirkTxAn48QGK9zPVLLn8a6SCDuVx1LG1RplVRU13EDvGFg8n0PFW/7/3B/i7NdzrLuzHmO6WL5CrmEB30Se0//0Hzi/wDD/BHTrPCwPxF4W7sQFMeai/ZzTqnvYvk4BHCvOMr5F0HFGelAA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535086; c=relaxed/simple;
	bh=X34FavGd/46DToNZc8uUeAvoHM4jpDKz4ojcIwPZ1f4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaW2npqXpKp9KSNQGT5k0v23Gs0jDJvNiD8Wz99JUJLuvqq7y63DlDVwJtblk2EdapZl5WgIC0TJKAPveswf+ZSjb9pb/kLw7UJRaQBGf7it/xEzP3sZfXqnlyV8pG+mJWu8K6YVSD6ly6ruGn+1jmsbJgqT9AREQPHf4FkEgig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 7a1ff63d-57f0-11f0-a9d0-005056bdfda7;
	Thu, 03 Jul 2025 12:31:21 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 3 Jul 2025 12:31:20 +0300
To: Alison Schofield <alison.schofield@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Li Ming <ming.li@zohomail.com>, akpm@linux-foundation.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, shiju.jose@huawei.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] resource: Introduce a new helper
 resource_contains_addr()
Message-ID: <aGZN6EFMLp-pL6JB@surfacebook.localdomain>
References: <20250702072008.468371-1-ming.li@zohomail.com>
 <aGTq5MKCYBO3H9Gg@smile.fi.intel.com>
 <aGWFdwla54b-98-x@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGWFdwla54b-98-x@aschofie-mobl2.lan>

Wed, Jul 02, 2025 at 12:16:07PM -0700, Alison Schofield kirjoitti:
> On Wed, Jul 02, 2025 at 11:16:36AM +0300, Andy Shevchenko wrote:
> > On Wed, Jul 02, 2025 at 03:20:06PM +0800, Li Ming wrote:
> > > In CXL subsystem, many functions need to check an address availability
> > > by checking if the resource range contains the address. Providing a new
> > > helper function resource_contains_addr() to check if the resource range
> > > contains the input address.
> > 
> > resources are about ranges and not addresses. At bare minimum naming #####
> > here. Also there is no symmetry with the intersection API. But I would argue
> > to use resource_contains() and just provide necessary parameter with both
> > start and end to be set at the same value.
> > 
> > 	struct resource r = DEFINE_RES...(addr);
> > 
> > 	if (resource_contains, res, &r)
> > 		...do stuff...

(1) ^^^

> Thanks for the review. Two alternative approaches were considered:
> 
> 1) A CXL-only helper with direct comparison:
> This duplicates range checking logic that's already common in the
> resource API. We'd end up with CXL specific when the resource API
> already provides the semantic framework for containment checks.

> 2) A CXL helper using temporary resource + resource_contains():
> While this maintains API consistency, it's unnecessarily heavyweight.

How is it? It's mostly matter of stack usage. Do I miss anything?

> Creating a temporary resource struct just to check if a single address
> falls within a range feels like overengineering.
> (This is your suggestion above.)

I don' think so. This won't create anything, it will declare the resource
data on a stack.

...

> This patch proposes, a new helper in ioport.h, provides a clean, reusable
> API that follows the existing resource_contains() pattern while being
> optimized for the single address case. I guess I can agree with the lack
> of symmetry with the existing API, but that's only if one thinks an API
> cannot be extended. The new helper actually complements resource_contains()
> nicely: one checks resource vs resource containment, the other checks
> address vs resource containment.

The point is _there is no address_ in the resources! There is a _range_.

> Revisited the name, I can see how extending an existing name, like 
> resource_contains() is a poor choice because then one might expect the
> pair to be resource_contains_resource() and resource_contains_addr()
> which it is not.
> 
> Do either of these fit better, or something else?
> - resource_includes_addr() 
> - resource_has_addr()

That's why (see above) naming sucks. Doing it local to CXL makes it clearer as
CXL knows the semantic of the range, struct resource doesn't and shouldn't.
(Yeah, I know that we have something there that relies on the range being an
address range, but those APIs provide more and TBH I would rather split them
to a separate header)

> The new helper would immediately be used 7 times in the CXL subsystem.
> What are you thinking the bar is for adding to ioport.h?

It's only a single subsystem, find 3+ more outside and we can reconsider.
Also for the symmetrical API,

-- 
With Best Regards,
Andy Shevchenko



