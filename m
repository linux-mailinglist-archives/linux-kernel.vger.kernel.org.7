Return-Path: <linux-kernel+bounces-741630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40387B0E6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B401C83495
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C140C28B4FE;
	Tue, 22 Jul 2025 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjNV6HMZ"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB03288C92
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 23:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225659; cv=none; b=cFydFbKZT+vJmtvElpLHhhZq40X2F8W8iVNXRnBCSD6Ziz8ORtw5av5pKg9YNGMQHQEllOiEjxI0L6c5Ox3XrQOeyWjbygjY9wAmkBcjL7hQ8sb2iZE6HMMA1UEw+pHi6tc68pSJ7QC6KDX4w3Yr1XhzLgCeikMBcD/IO2IKIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225659; c=relaxed/simple;
	bh=i9Topy5p8+oRB1ybTn3eGTjAdmW4So/zy81PHcCSQws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cZKJ/do9MSAm8FAIOAXrTNyta3bAko38UXW0/59gHyu83Xu2blmr9Gj3nVL9ZDdiqu6F8qXE5lt6GpIcrFF36rj3RFqEitEtevY9637mg55Tx42gpW0RQVURzI+OID9IC8Iww5U61faFRsJLEbAzQh3t5HvBcmBIDaHkxjvtzYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YjNV6HMZ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3f321dc6abso3277678a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753225657; x=1753830457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+m6qI30JHvrm3ONaGCpQMi0L8lxI7PYDb1Mu/Pb3F4=;
        b=YjNV6HMZQgvFeWmgIyEazOWyPuyrczJAmAScQ3juRgI2Oyk5Auifj3T82fblvcIVsJ
         t/JxxxUxv6ig9D+zvPa55YTZ0XCkLdcbkxBk51XOfFLOKmZ0hLot0LnccnU6o+pfL1Pq
         koCpg/CeoYYuLXF54IyFwlZJMEdTEoHprTPgCc4UzxJs4FwlN1XQuk2gVdoWgMTWq9ze
         lvEz3PHjmkl0muXdwXPMot4w/Eg86z8mI95p5jmMMli90BRA64lYvhlmwZspEDE9djF4
         JZz6j1y1w+rOIn3Boz66P3ii3IMREpGGEhH8BnRGvTEjFtwQzU6PqzTzC4pY80yE1nJm
         u7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753225657; x=1753830457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+m6qI30JHvrm3ONaGCpQMi0L8lxI7PYDb1Mu/Pb3F4=;
        b=wTlLj9xgM0CvURAl1ib6nEL8tUBOEdsvGVpUR5YbjfSLfH7mG0WmQcrPA8nb1dY1hd
         QId+qX27rv+6qT8R5za04Rw9jNFgibxjZIYByaO5mALY9U4EEKAln+ch2jHkqDVEY84G
         5xiggAkPEasGriDMdNHAG+Io+jdjoXO/or5Ho+qcYFuk9c3aE0WrANUYipFbqWFOqXqt
         FgyBsMX+276nQ6ZxluYVAivsUH7l8DOrgn0ZS3KLsEjOyBAbMiX3P5oc6bYru+3cm5Qm
         o90mUVYwor0e6yD5BstTQygjNgcznZx7YLG7sHQ8jkPSbabsYvqcS0M698Zi2Bc/B9bL
         Nuug==
X-Forwarded-Encrypted: i=1; AJvYcCWoIO95zHMTfyR5zWi2JesFzFjFa+P1yhV5tv/7Nt19kO7/pwAZunjeltnqZG59rSgHPTH1zIG+P22Hgds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2m17x+hv/NxUb8IO/1gJBB+yAFfdff8Z6sZ/WqSggcO38Osa9
	2uuyttdt6HyKl1f3vJpWcJRHC/+IjmPUiK+DrfMTeIUdvgq3Rt5BCS+zguNjWm1FhlkRlQJksju
	z14EAYw==
X-Google-Smtp-Source: AGHT+IFOb8KYXXobVAAvvjW+Fe1YbH8mwfp6V2E801ROWDybd0+20juthdBHS5x4qZEtLjQQN6CpBVqzr4M=
X-Received: from pjuj4.prod.google.com ([2002:a17:90a:d004:b0:313:242b:1773])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5647:b0:311:fc8b:31b5
 with SMTP id 98e67ed59e1d1-31e507abbc6mr1697551a91.14.1753225656408; Tue, 22
 Jul 2025 16:07:36 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:07:34 -0700
In-Reply-To: <80a047e2-e0fb-40cd-bb88-cce05ca017ac@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250713174339.13981-2-shivankg@amd.com> <bdce1a12-ab73-4de1-892b-f8e849a8ab51@redhat.com>
 <aH-j8bOXMfOKdpHp@google.com> <80a047e2-e0fb-40cd-bb88-cce05ca017ac@redhat.com>
Message-ID: <aIAZtgtdy5Fw1OOi@google.com>
Subject: Re: [PATCH V9 0/7] Add NUMA mempolicy support for KVM guest-memfd
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Shivank Garg <shivankg@amd.com>, vbabka@suse.cz, willy@infradead.org, 
	akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, ackerleytng@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, 
	bfoster@redhat.com, tabba@google.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, rppt@kernel.org, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	rientjes@google.com, roypat@amazon.co.uk, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, kent.overstreet@linux.dev, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, chao.p.peng@intel.com, 
	amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com, 
	ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
	suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 22, 2025, David Hildenbrand wrote:
> On 22.07.25 16:45, Sean Christopherson wrote:
> > On Tue, Jul 22, 2025, David Hildenbrand wrote:
> > > Just to clarify: this is based on Fuad's stage 1 and should probably still be
> > > tagged "RFC" until stage-1 is finally upstream.
> > > 
> > > (I was hoping stage-1 would go upstream in 6.17, but I am not sure yet if that is
> > > still feasible looking at the never-ending review)
> > 
> > 6.17 is very doable.
> 
> I like your optimism :)

I'm not optimistic, just incompetent.  I forgot what kernel we're on.  **6.18**
is very doable, 6.17 not so much.

