Return-Path: <linux-kernel+bounces-809473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEFCB50E11
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BA24814F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6782DF701;
	Wed, 10 Sep 2025 06:37:09 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349A246788
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486228; cv=none; b=lrIhOmZ+fABsHzEBfkUZpw/f2eZWATxG5uTeGy1w74PfvOpkZPxt2QEm4hN8ebGHb8kXqKOmCHbUmZ5bkjtQ2jndVJ1GWHIAb7RM2vwBOgGDNrI4Vphdvad8HPcf3K2m5D4Y25ze3ZwMUftHB6eVYCF5BSET52F4tyICzEmT5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486228; c=relaxed/simple;
	bh=3mzbvo3iJbNmlk1psxPOkNnZ5sCKL6t+y9DKIavLy/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKYfvGhWix/KPLiPotxSkyoBe5pudTxrSgW1lkx4OMCFZeRaSbq8+/i7DbNYBNOz2AzjHgdpXQfjcO7gmwQ99pBlmVLKWknR24HdnRmmhxsmHANYwV3N1SeWkn8MXHY0BWvAOoHKRxqUqM4iFd/ALnQ4W9zc6gDW+O8dj4sng5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201614.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202509101436476236;
        Wed, 10 Sep 2025 14:36:47 +0800
Received: from PC00024056.home.langchao.com (10.94.9.241) by
 Jtjnmail201614.home.langchao.com (10.100.2.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Wed, 10 Sep 2025 14:36:48 +0800
From: cuishiwei <cuishw@inspur.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: cuishiwei <cuishw@inspur.com>, Michal Hocko <mhocko@suse.com>,
	<akpm@linux-foundation.org>, <axelrasmussen@google.com>,
	<yuanchu@google.com>, <weixugc@google.com>, <david@redhat.com>,
	<zhengqi.arch@bytedance.com>, <shakeel.butt@linux.dev>,
	<lorenzo.stoakes@oracle.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] disable demotion during memory reclamation
Date: Wed, 10 Sep 2025 14:36:40 +0800
Message-ID: <20250910063643.2323-1-cuishw@inspur.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909144531.GA1474@cmpxchg.org>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 Jtjnmail201614.home.langchao.com (10.100.2.14)
tUid: 20259101436489048ee04c079dbb8e6ea2fbdc70eae8d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

On Tue, 9 Sep 2025 15:45:31 +0100 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Tue, Sep 09, 2025 at 09:40:51AM +0200, Michal Hocko wrote:
> > On Tue 09-09-25 09:21:41, cuishiwei wrote:
> > > When a memory cgroup exceeds its memory limit, the system reclaims
> > > its cold memory.However, if /sys/kernel/mm/numa/demotion_enabled is
> > > set to 1, memory on fast memory nodes will also be demoted to slow 
> > > memory nodes.
> > > 
> > > This demotion contradicts the goal of reclaiming cold memory within
> > > the memcg.At this point, demoting cold memory from fast to slow nodes
> > > is pointless;it doesn't reduce the memcg's memory usage. Therefore, 
> > > we should set no_demotion when reclaiming memory in a memcg.
> > 
> > We have discussed this in the past and it is my recollection that we
> > have concluded that demotion is a part of proper aging and therefore it
> > should be done during the limit reclaim.
> 
> Yes, thanks. This is intentional. Please see 3f1509c57b1b ("Revert
> "mm/vmscan: never demote for memcg reclaim"") for more details.
Thank you for the guidance. It seems the original processing logic was sound.

Sent using hkml (https://github.com/sjp38/hackermail)

