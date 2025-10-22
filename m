Return-Path: <linux-kernel+bounces-864572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F220BFB156
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A531A04167
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC7312836;
	Wed, 22 Oct 2025 09:10:04 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BA3126B6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124204; cv=none; b=i1HJEUgxmIP5SWPoaeWRDn17/WepyLbGVDy7hrJS5TlQHvusLTyugzw5BWl4MC+87iSm5gh2xN0oTBU2gMMKGis5VmcH3bvegFD7mNwssqJogJuPcbjNQRw7moDVJIwWJqOzY5IIDDivbe9pAWxa5CHC7neB8mhWAK3jkuCtKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124204; c=relaxed/simple;
	bh=Xwh3l3BPA4ZgKUZ7PgwsvS6awxKnTMHACbPXbU0DDZU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1vfG3zpOy4Q8tnrS9tGhC2WMSYh01+2EYdAkEuoIorq/d1yxh8KXNx7hd3dNWK9lnHqU6JffDDhyfHnN042s5vuozpmmBHxbjLflUEKJBMdFyBoQ+Eomhv3Rk3nozkXh+SDDXaicY6W3UofSR4bJmL8il3Nt/LcMYzUR6nM9Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cs3HP4d4Dz6K6HJ;
	Wed, 22 Oct 2025 17:08:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 84AB21400C8;
	Wed, 22 Oct 2025 17:09:57 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 22 Oct
 2025 10:09:56 +0100
Date: Wed, 22 Oct 2025 10:09:50 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>, <hannes@cmpxchg.org>
CC: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>, Wei Xu
	<weixugc@google.com>, David Rientjes <rientjes@google.com>, Matthew Wilcox
	<willy@infradead.org>, Bharata B Rao <bharata@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<peterz@infradead.org>, <raghavendra.kt@amd.com>, <riel@surriel.com>,
	<sj@kernel.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<dave@stgolabs.net>, <nifan.cxl@gmail.com>, <xuezhengchu@huawei.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <byungchul@sk.com>,
	<kinseyho@google.com>, <joshua.hahnjy@gmail.com>, <yuanchu@google.com>,
	<balbirs@nvidia.com>, <alok.rathore@samsung.com>, <yiannis@zptcorp.com>, Adam
 Manzanares <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <20251022100950.00002785@huawei.com>
In-Reply-To: <aPfXloRQgplusnce@gourry-fedora-PF4VCD3F>
References: <aNVohF0sPNZSuTgI@gourry-fedora-PF4VCD3F>
	<20250925182308.00001be4@huawei.com>
	<aNWRuKGurAntxhxG@gourry-fedora-PF4VCD3F>
	<aNzWwz5OYLOjwjLv@gourry-fedora-PF4VCD3F>
	<CAOi6=wTsY=EWt=yQ_7QJONsJpTM_3HKp0c42FKaJ8iJ2q8-n+w@mail.gmail.com>
	<aPJPnZ01Gzi533v4@gourry-fedora-PF4VCD3F>
	<20251017153613.00004940@huawei.com>
	<aPJZtQS4wJ1fkJq-@gourry-fedora-PF4VCD3F>
	<20251020150526.000078b6@huawei.com>
	<aPfWePBq8d3v979f@gourry-fedora-PF4VCD3F>
	<aPfXloRQgplusnce@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 21 Oct 2025 14:57:26 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Tue, Oct 21, 2025 at 02:52:40PM -0400, Gregory Price wrote:
> > I would prefer the former, since this is already what's done for
> > hostbridge interleave vs non-interleave setups, where the host may
> > expose multiple CFMW for the same devices depending on how the OS.  
> 
> bah, got distracted
> 
> "Depending on how the OS may choose to configure things at some unknown
> point in the future"

My gut feeling is the need to do dynamic NUMA nodes will not be driven
but this but more by large scale fabrics (if that ever happens)
and trade offs of host PA space vs QoS in the hardware.  Those
trade offs might put memory with very different performance
characteristics behind one window.

Maybe it'll become a thing that can be used for compression.
Otherwise compression from host hardware point of view might be
like the question of share or separate fixed memory windows for
persistent / volatile. Ideally they'd be separate but if Host PA space
is limited, someone might build a system where a single fixed memory
window is used to support both.

Possible virtualization of some of this stuff will make it more complex
again.  Any crazy mess can share a fake fixed memory window as the QoS is
all behind some page tables.

Meh. Let's suggest people burn host PA space for now.  If anyone hits
that limit they can solve it (crosses fingers it's not my lot :)

Jonathan


> 
> 
> ~Gregory


