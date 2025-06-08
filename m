Return-Path: <linux-kernel+bounces-677043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA20AD1501
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 00:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86EA3AA6C8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jun 2025 22:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22EF1EF382;
	Sun,  8 Jun 2025 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtT9iUFm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8685313AC1
	for <linux-kernel@vger.kernel.org>; Sun,  8 Jun 2025 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749420221; cv=none; b=DWCWDGVwOx+v+oQ97cVAmJYAMNMtUC8TyKQt/ozTXHsMv5Mv+lMaeZ/9F5/VDbJrpj/deiZONxG2vOc5nP9ShOr35OIMdN/r57Cwka23i6qJAtTGZn12HcSdJqZvH6+on9og4ojN2fr/QXzRvHHGwCCDjVPl16FI9Umbb03mCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749420221; c=relaxed/simple;
	bh=sOgIZl9JDRuhvnkUVkrZS9RJ17+4m5FbMvGt4avTgIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHGo/UikPz2g9VON0xtXHgA8cBomnKjx6CMHgnIw/7Xl2xovRA20Vlml8x3mbGxHaEPWybatW/jao92jqbi8sCEF2HBK614rssNBMrcx0bDJ/Us55MP6kzykEuLCZd7wnJ5FaDgDEf6Bch5ovzHYrHUXWvZ84TX3XTWYQPUxLEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtT9iUFm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749420220; x=1780956220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sOgIZl9JDRuhvnkUVkrZS9RJ17+4m5FbMvGt4avTgIg=;
  b=OtT9iUFmicCQn43dRvI3wAhZdJRmiGPHAXBFr+Gv3DukVlg9TCK9v4BE
   Zimtzm4+gbJiIifp06uoL6hijGYUeMm5nsepdGTjK3qhdN2upVbLiIRyH
   RzClqvMLgDg3XBYTFtwYqA19Aa5qrFp6N8cEgcpc6U+uh4n43kAdnZa6P
   hKn/nvUZDpcuLKZWahCWY/D0Lm/kQfwEGab+LuT53p/NQTeWsciLo1FGs
   05QbUJUTkUE4gwhuYgOj6JwGuP0tPZXQvjNm36V1QdbGKm/JpJQsLD271
   Ged/sIToDk/p4vYpQ3kPwVGKbGFj4VVJ2YtTrrfExqcZLIl1Js75VvIb3
   w==;
X-CSE-ConnectionGUID: RlbJH7QuTXexGR1LHzAH0Q==
X-CSE-MsgGUID: NHsPEwAOSM+Sc7/IU6CMsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51581825"
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="51581825"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 15:03:39 -0700
X-CSE-ConnectionGUID: A+nUbwODQueO5fDXMv1yeQ==
X-CSE-MsgGUID: S3XpvY7bSv2blbZbLOuPFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="147314447"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 15:03:39 -0700
Date: Sun, 8 Jun 2025 15:03:36 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Chen Yu <yu.c.chen@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v5 22/29] x86,fs/resctrl: Handle domain creation/deletion
 for RDT_RESOURCE_PERF_PKG
Message-ID: <aEYIuGOgnHkt-nZr@agluck-desk3>
References: <20250521225049.132551-1-tony.luck@intel.com>
 <20250521225049.132551-23-tony.luck@intel.com>
 <9ca45c27-7d1c-4bcf-bcc9-baa24fb7c95d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ca45c27-7d1c-4bcf-bcc9-baa24fb7c95d@nvidia.com>

On Fri, Jun 06, 2025 at 05:54:29PM -0700, Fenghua Yu wrote:
> > @@ -666,6 +701,12 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
> >   	default:
> >   		pr_warn_once("Unknown resource rid=%d\n", r->rid);
> >   		break;
> > +	case RDT_RESOURCE_PERF_PKG:
> > +		resctrl_offline_mon_domain(r, hdr);
> > +		list_del_rcu(&hdr->list);
> > +		synchronize_rcu();
> > +		kfree(container_of(hdr, struct rdt_perf_pkg_mon_domain, hdr));
> > +		break;
> >   	}
> 
> Why default is not the last one?

Fixed.

Thanks

-Tony

