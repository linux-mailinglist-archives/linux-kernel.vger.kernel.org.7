Return-Path: <linux-kernel+bounces-834408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE442BA4A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61374C67C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6972E261573;
	Fri, 26 Sep 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="skDDhUwp"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2C224DCE9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904196; cv=none; b=O1blKGmfGfvTy1YeTN9RXBSN6LM4qAtV0jRhdnieYLdadkymG4u164CNQUBPIVDCoYmr1jXmlausC/sJ4Diz7OFDAysS5i0I/4P27XgJc9y3IHfxnSofkCVxJDuNMxNlQySlDMEzrkjMVLsdoo+ZZ0yZ1lr6z5m/fQDy2KQj8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904196; c=relaxed/simple;
	bh=pXZMnjw+Sy9OuF5bFWxCBJB/q1PalvTkN3dKPnTWL5s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gMiu5E0Qm24UI0EYt/EhzO7760exVnox8uo1BScFGkAv8nsiFZSf0h2jDkaOTiDKPF5oWp39xaICP4kFM4cYBo3uxPHQW14Li2nFnNPfyPTE5IaoO9YYaUJ5px3EVVzvWe9B36RltEpCh/Y7f0Hovu7pxSVp1kCgO/53xJco1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=skDDhUwp; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1758904194;
	bh=pXZMnjw+Sy9OuF5bFWxCBJB/q1PalvTkN3dKPnTWL5s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=skDDhUwpJ28QhFf/DSEnPG5i/j3L4lkVN7HJLxmnX4uQxrTIFaawx6ZJ0RYaqdB8P
	 TX2qnBt3jCnEEZntTEo9pqbumFSpzucw40GmAk3mt2XUuX0BlDUT7m+kowp6/xsUBs
	 Vt5Gf6ITs6DFEN4o42ynwJyrLtOXnNVSwUntSpBs=
Received: by gentwo.org (Postfix, from userid 1003)
	id C2062402AD; Fri, 26 Sep 2025 09:29:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id C0E204028E;
	Fri, 26 Sep 2025 09:29:54 -0700 (PDT)
Date: Fri, 26 Sep 2025 09:29:54 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Yang Shi <yang@os.amperecomputing.com>
cc: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com, 
    akpm@linux-foundation.org, catalin.marinas@arm.com, will@kernel.org, 
    carl@os.amperecomputing.com, linux-mm@kvack.org, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: avoid soft lockup when mprotect with
 PROT_MTE
In-Reply-To: <20250926162034.1785899-1-yang@os.amperecomputing.com>
Message-ID: <1038c7c7-81d6-f273-6fa1-93eb7206d5ed@gentwo.org>
References: <20250926162034.1785899-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 26 Sep 2025, Yang Shi wrote:

> When calling mprotect() with PROT_MTE, kernel will initialize MTE tags
> for every single page in the affected area. Soft lockup was observed
> when doing this for large HugeTLB memory area in our customer's workload
> (~300GB memory):

AFAICT this is a bug fix. The hugetlb path should be doing a
cond_resched() like the base page code does.

It is not MTE specific. If other processing takes a long time in the loop
(setting up terabyte size mappings for hugetlb for example) then the
softlockup could also be triggered on non MTE workloads.

Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>


