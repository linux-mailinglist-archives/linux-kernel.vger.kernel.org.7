Return-Path: <linux-kernel+bounces-752488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE6DB1762F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB54E1AA7300
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43422586C2;
	Thu, 31 Jul 2025 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTE571R3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425792580CA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987539; cv=none; b=S+V21s3AffurF+qJJYxaEBxgRdIspeyBqY4TZRqGRf72txEV9P/3iYAB5mMRP05dQX80ii2uehqqLAT6MJyJhp1SEcPqSNKFG7ylQs46vcu8r/MyDl3iOlu/sR4kb0A7W9uIPz2p59QtMv+O8XPeEgiY1gxXVqezV779eJnjK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987539; c=relaxed/simple;
	bh=EDF5fbjVVtLHDax6DWwi8zVjLgTT3NYO+yAT3GKnzGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ndpU+W31ddwp2+6aqodTnb+yGUzA6gbQfi8Hd2e8rBkdPM2Kb1C3F17u5h7Y8/3xt8bItfpabptmoClXyIeo0iOWTLXTZcodB75Mv00v6CEJomAC833XOAk5bttkGOz8KfieRtWoATQocHeK0lZQBTwiU8J7HGSICH5DezdJLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTE571R3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82069C4CEF7;
	Thu, 31 Jul 2025 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753987536;
	bh=EDF5fbjVVtLHDax6DWwi8zVjLgTT3NYO+yAT3GKnzGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bTE571R3uL8yVkEByfBkisQXXirJ/lh/NmmQvnlNQupf9TEy5rzWuRr9qcal1irWf
	 S6rbnKD0SyB7borVmo/qPY8kbJHP//vl9LB8TlqJuUhy4zu9E6W0unIxp22DFwMb7B
	 eR1GS1Lg5YMXRptg8zNAvNHTDR31y3p4Hstl69o4LhjmqJ2scrcIZV9qy6gxtIC7N6
	 HNIi0yWiA2jcnNjuL13K4aH4GGhyjb2v4hiNU6P3OmNq+/5AQLfjtwrJSoHppCasFY
	 IbfcSllb7OomUMmxK78WopGDkfVb0q8SQ59wHJpbiS+UyVv42NsSj4gO4lXLsT4Nuy
	 87Y5QC54gdWJg==
From: SeongJae Park <sj@kernel.org>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: SeongJae Park <sj@kernel.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] mempolicy: Clarify what RECLAIM_ZONE means
Date: Thu, 31 Jul 2025 11:45:33 -0700
Message-Id: <20250731184533.16419-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <87tt2t9lkp.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 31 Jul 2025 09:48:54 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
[...]
> > On that note, one thing that I felt was slightly undercaptured in
> > Documentation/admin-guide is what "zone reclaim" actually means. What it does
> > is of course well captured by its name, but it misses the nuance of preferring
> > reclaim over fallback allocation.
> >
> > Actually the whole motivation behind all of this conversation is because I saw
> > zone reclaim preventing allocation into a second node in a 2-NUMA node system
> > and was a bit confused until I understood what the implication of having
> > zone reclaim was.
> 
> Yes.  It's good to improve the document.  If it makes you confusing, it
> may make others confusing too.

+1


Thanks,
SJ

[...]

