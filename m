Return-Path: <linux-kernel+bounces-843743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51FCBC01F2
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 05:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF843B2A6E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 03:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00E4217723;
	Tue,  7 Oct 2025 03:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhaqxzSq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E820322
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 03:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759809359; cv=none; b=LD18GR0rwX8YFqz/Vv4Hl4buuwhs6BSsUX5TJGK26s8BRuhwMxctV/BEfvCL3Gtqlkecn7OKK0w/onhEHk705Lz/qEBwz3KAOewfL53d/E1PZaBhBX3hkHcAlWPfh3BO9iNAxvpQ9YTxq17i2Oh0YnKofWMb5ttiQNLO1UvNDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759809359; c=relaxed/simple;
	bh=jOihmF4P0swyWsQa85Mr9eVtGiGJmtPMuRcm6r/f3OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaxSARHKYWcqNOkosVp7G9P2Y9A63kbBqbEjPBNNBGY0I30CS1t6SRjP2c8kUUjq6NkGn1GYxXhXYUNNw3AqUMXJuLYoubJtfHNHIpdgmxTo+xtEuKh96hx1ytW05Ag/+vQXWKuJnwadHLrhJZaqus0D9JTFZ8gt0QTI7htalKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhaqxzSq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759809354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BAqsmdKl53hITGHtj1mkVYMvSyvoN7BzckwVidIU+U4=;
	b=KhaqxzSqNFnIhshZc8NYTmJWy/nKt2Eitw/Pqmz7PaMNZ1RzK89oDt1Pa2cj3ftLn5jRDH
	SvFwoNNFTe3M9dZhcbB+YkBbuBrCxvKwjP+OMft0UkigZKfdM3MnNGECD78Mxdkc9SaM0b
	No7etJmFlmLInKSlUIC/dUUR7bLqopw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-DLMVmdrePgS62B1-gx2b4A-1; Mon,
 06 Oct 2025 23:55:52 -0400
X-MC-Unique: DLMVmdrePgS62B1-gx2b4A-1
X-Mimecast-MFC-AGG-ID: DLMVmdrePgS62B1-gx2b4A_1759809351
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25D3C1800452;
	Tue,  7 Oct 2025 03:55:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.55])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1BF41956056;
	Tue,  7 Oct 2025 03:55:42 +0000 (UTC)
Date: Tue, 7 Oct 2025 11:55:36 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <dhildenb@redhat.com>,
	Breno Leitao <leitao@debian.org>
Cc: kas@kernel.org, Jiri Bohac <jbohac@suse.cz>, riel@surriel.com,
	vbabka@suse.cz, nphamcs@gmail.com, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
 <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
 <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/06/25 at 06:45pm, David Hildenbrand wrote:
> On 06.10.25 18:25, Breno Leitao wrote:
> > On Mon, Oct 06, 2025 at 10:16:26AM +0200, David Hildenbrand wrote:
> > > On 03.10.25 17:51, Breno Leitao wrote:
> > > > Hello Jiri,
> > > > 
> > > > On Thu, Jun 12, 2025 at 12:11:19PM +0200, Jiri Bohac wrote:
> > > > 
> > > > > Currently this is only the case for memory ballooning and zswap. Such movable
> > > > > memory will be missing from the vmcore. User data is typically not dumped by
> > > > > makedumpfile.
> > > > 
> > > > For zswap and zsmalloc pages, I'm wondering whether these pages will be missing
> > > > from the vmcore, or if there's a possibility they might be present but
> > > > corrupted—especially since they could reside in the CMA region, which may be
> > > > overwritten by the kdump environment.
> > > 
> > > That's not different to ordinary user pages residing on these areas, right?
> > 
> > Will zsmalloc on CMA pages be marked as "userpages"?
> 
> No, but they should have the zsmalloc page type set.
> 
> > 
> > makedump file iterates over the pfns and check for a few flags before
> > "copying" them to disk.
> > 
> > In makedumpfile, userpages are basically discarded if they are anonymous
> > pages:
> > 	#define isAnon(mapping, flags, _mapcount) \
> > 		(((unsigned long)mapping & PAGE_MAPPING_ANON) != 0 && !isSlab(flags,
> > 		_mapcount))
> > 
> > 	https://github.com/makedumpfile/makedumpfile/blob/master/makedumpfile.h#L164
> > 
> > 	called from:
> > 	https://github.com/makedumpfile/makedumpfile/blob/master/makedumpfile.c#L6671
> > 
> > For zsmalloc pages in the CMA, The page struct (pfn)) is marked with old
> > page struct (from the first kernel), but, the content has changed
> > (replaced by kdump environment - 2nd kernel).
> > 
> > So, whatever decision makedumpfile does based on the PFN, it will dump
> > incorrect data, given that the page content does not match the data
> > anymore.
> 
> Right.
> 
> > 
> > If my understanding is valid, we don't want to dump any page that points
> > to the PFN, because they will probably have garbage.
> 
> My theory is that barely anybody will go ahead and check compressed page
> content, but I agree. We should filter them out.
> 
> > 
> > That said, I see two options:
> > 
> >   1) Ignore the CMA area completely in makedump.
> >      - I don't think there is any way to find that area today. The kernel
> >        might need to print the CMA region somewhere (/proc/iomem?)
> 
> /proc/iomem in the newkernel should indicate the memory region as System RAM
> (for the new kernel). That can just be filtered out in any case: dumping
> memory of the new kernel does not make sense in any case.

Agree.

And I saw Jiri has excluded the crashk_cma_ranges[] from the dumped
content via elf_header_exclude_ranges(). Have you encountered a real
problem about the dumping, or you are just worried about it?

> 
> > 
> >   2) Given that most of the memory in CMA will be anonymous memory, and
> >      already discard by other rules, just add an additional entry for
> >      zsmalloc pages.
> > 
> >      Talking to Kirill offline, it seems we can piggy back on MovableOps
> >      page flag.
> 
> We should likely check the page type instead if we go down that path.

Talking about the pages in CMA except of crashk_cma_ranges[],
zsmalloc/zswap is true as anon mem and can be discarded. I am wondering
if there's any driver or kernel pages residing in CMA and being worth to
dump out.


