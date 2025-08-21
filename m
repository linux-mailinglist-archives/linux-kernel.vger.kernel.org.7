Return-Path: <linux-kernel+bounces-778745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F60B2E9FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5631A5E2E98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0E01B87F2;
	Thu, 21 Aug 2025 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="WBxUddhG"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8807478C9C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738249; cv=none; b=GAYaC4DBLcMJctWd/6qFef6vwkM4NiSziWDeYM4vZTc+1RYVXTm1nL3O1PMxaZ0Erc+IEtaYt48P1raoevXGR/KQUIN8Qew90MfM5TNtvgu7/tfgyqp39hRPlWFB6mg5eVWwY6MCcli+ARq2VB1Oceeg+5meKMQU2f3tPL+RD6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738249; c=relaxed/simple;
	bh=gjM5yFflsTjE3FI6DYWRE3QB9Nt5Rd3AAh3ujDs734Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXdHU/GRNQWpA6JM6NnQaKqKIthH9NMwzfkI2L4lmNhULAmx4bcVWofdiXqm9Q9Cc9JIeFVQcD6++U89tADz1fHdMsBd/ARcPoUv+fFZRZBMo0FCNtd+AXxrNxACBnhlajIDU4KEnuhQ3VXV8YRwpmMxjk6rCoQBDnDICzUPbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=WBxUddhG; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755738243;
	bh=3BE4U4qULMJ4toWt5V1Co35e1iLPvH1DLi6EO1scyLE=;
	h=From:Subject:Date:Message-ID;
	b=WBxUddhGXe9ntBsRECp/pLnIYx6XUIkkpCCi0OmVD5UsOKccGdNbjW6jEGWOq7fZn
	 ztTi5jq36BPd6fbp76REuPHh6sXynoRcJgq2QNGLyDJIPuyn7Y3LLWCz8MLeGpFhCZ
	 zCA4RZx7Mad9neIl2T9X1+qhmPGJpro1GTyrEVBY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68A670550000338B; Thu, 21 Aug 2025 09:03:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7136754456954
X-SMAIL-UIID: 7C74DE84D15245F8AEC04F122A052724-20250821-090319-1
From: Hillf Danton <hdanton@sina.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in batch freeing
Date: Thu, 21 Aug 2025 09:03:06 +0800
Message-ID: <20250821010307.5142-1-hdanton@sina.com>
In-Reply-To: <20250820151307.1821686-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 Aug 2025 08:13:07 -0700 Joshua Hahn wrote:
> On Wed, 20 Aug 2025 09:29:00 +0800 Hillf Danton <hdanton@sina.com> wrote:
> > On Mon, 18 Aug 2025 11:58:03 -0700 Joshua Hahn wrote:
> > > 
> > > While testing workloads with high sustained memory pressure on large machines
> > > (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> > > Further investigation showed that the lock in free_pcppages_bulk was being held
> > > for a long time, even being held while 2k+ pages were being freed.
> > > 
> > > Instead of holding the lock for the entirety of the freeing, check to see if
> > > the zone lock is contended every pcp->batch pages. If there is contention,
> > > relinquish the lock so that other processors have a change to grab the lock
> > > and perform critical work.
> > > 
> > Instead of the unlock/lock game, simply return with the rest left to workqueue
> > in case of lock contension. But workqueue is still unable to kill soft lockup
> > if the number of contending CPUs is large enough.
> 
> Thank you for the idea. One concern that I have is that sometimes, we do expect
> free_pcppages_bulk to actually free all of the pages that it has promised to
> do. One example is when it is called from drain_zone_pages. Of course, we can
> have a while loop that would call free_pcppages_bulk until it returns 0, but
> I think that would be reduced to unlocking / locking over and over again.
> 
In the case of drain_zone_pages(), I think adding something like the pcpu_drain_mutex
to the path updating zone counters is a cure.

