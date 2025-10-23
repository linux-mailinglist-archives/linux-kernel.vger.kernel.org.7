Return-Path: <linux-kernel+bounces-867285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFC7C021D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5C61A677B7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737EB33B96A;
	Thu, 23 Oct 2025 15:29:56 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4533509F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233396; cv=none; b=I7KOErT3Xp7SMpZeXyi+e0Z/3tcPFMbHywaFnIBU7/BXISGIUMT5GKSXal6tZNjBALI0El1qfNCYSRLFzlt1coIJvWTbJOVZU7brvre4twXKseDwXkzWV+33PtpC8bIkUAkWkyVo4n3eJZcTUdjcZfhkD6/pxC5vFjD4mMK4c5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233396; c=relaxed/simple;
	bh=8E3D0qa57paFIg4aScAyLAje2xeCutpKH+ZDmexdwf0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoiB+qE5N4f+TFZ9lNmZ+0N638OQBtz722nsGrA1/NbcBH388g02A/SRv+oY6MViUF6y8EWxlkZMRDRwVKEcvgKnnkSzRJkO494dncg4CWfbsbOMC6SapivI22z6cpTCs9Rnkb/2z0KkbgxcBmNyP4FcF4W0jDmm2DCETfnAPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4csqgB1897z6L50b;
	Thu, 23 Oct 2025 23:28:22 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AD071402F5;
	Thu, 23 Oct 2025 23:29:50 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 16:29:48 +0100
Date: Thu, 23 Oct 2025 16:29:44 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <hannes@cmpxchg.org>, Yiannis Nikolakopoulos
	<yiannis.nikolakop@gmail.com>, Wei Xu <weixugc@google.com>, David Rientjes
	<rientjes@google.com>, Matthew Wilcox <willy@infradead.org>, Bharata B Rao
	<bharata@amd.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<peterz@infradead.org>, <raghavendra.kt@amd.com>, <riel@surriel.com>,
	<sj@kernel.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<dave@stgolabs.net>, <nifan.cxl@gmail.com>, <xuezhengchu@huawei.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <byungchul@sk.com>,
	<kinseyho@google.com>, <joshua.hahnjy@gmail.com>, <yuanchu@google.com>,
	<balbirs@nvidia.com>, <alok.rathore@samsung.com>, <yiannis@zptcorp.com>,
	"Adam Manzanares" <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <20251023162944.000074dd@huawei.com>
In-Reply-To: <aPjyrAo5LdC5pAqv@gourry-fedora-PF4VCD3F>
References: <aNWRuKGurAntxhxG@gourry-fedora-PF4VCD3F>
	<aNzWwz5OYLOjwjLv@gourry-fedora-PF4VCD3F>
	<CAOi6=wTsY=EWt=yQ_7QJONsJpTM_3HKp0c42FKaJ8iJ2q8-n+w@mail.gmail.com>
	<aPJPnZ01Gzi533v4@gourry-fedora-PF4VCD3F>
	<20251017153613.00004940@huawei.com>
	<aPJZtQS4wJ1fkJq-@gourry-fedora-PF4VCD3F>
	<20251020150526.000078b6@huawei.com>
	<aPfWePBq8d3v979f@gourry-fedora-PF4VCD3F>
	<aPfXloRQgplusnce@gourry-fedora-PF4VCD3F>
	<20251022100950.00002785@huawei.com>
	<aPjyrAo5LdC5pAqv@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 22 Oct 2025 11:05:16 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Wed, Oct 22, 2025 at 10:09:50AM +0100, Jonathan Cameron wrote:
> > 
> > My gut feeling is the need to do dynamic NUMA nodes will not be driven
> > but this but more by large scale fabrics (if that ever happens)
> > and trade offs of host PA space vs QoS in the hardware.  Those
> > trade offs might put memory with very different performance
> > characteristics behind one window.
> >   
> 
> I can't believe we live in a world where "We have to think about the
> scenario where we actually need all 256 TB of 48-bit phys-addressing"
> is not a tongue in cheek joke o_o

You think everyone wires all the 48 bits?  Certainly not everyone does.

> 
> That's a paltry 2048 128GB DIMMs... and whatever monstrosity you have to
> build to host it all but that's at least a fun engineering problem :V
> 
> Bring on the 128-bit CPUs!
> 
> What do we name those x86 registers though? Slap the E back on for ERAX?
> 
> > Meh. Let's suggest people burn host PA space for now.  If anyone hits
> > that limit they can solve it (crosses fingers it's not my lot :)
> >   
> 
> +1
> 
> ~Gregory


