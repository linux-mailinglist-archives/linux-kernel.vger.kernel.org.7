Return-Path: <linux-kernel+bounces-725527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2289B00049
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6475C1FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E52E174A;
	Thu, 10 Jul 2025 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bNYc+4F9"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5742E0B64
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146025; cv=none; b=cK4zSKKNRMRtFIreL1VdRh4AOSElpskk9SkZzm1Gx3VLaLiYNUJxbRzVamZ2wkTAdirz36biBwELJ8PqPLOhkNkZ2gW8yFyGys551LwDtgaSkOh2vcdG03BbfM+pcRI0o7mxsgONTZ2V8xk8pgELXTgtpnUn0KtIA/CxFNdT488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146025; c=relaxed/simple;
	bh=OeFkcmTzr6XW9fT0eRVkKb8LuPnrMZJq6KXYNQCGwRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tuw3ECRsfmyAw91jZENuIexqgpulBxU9fKGp/sTASGYLuMbfUOje0g2zBa7uAptJqnqI5F8XhoUs8eAbRfMb5eXptIe3KOXtgem88k6ujRcnHgl5nu8ERjGYz/xJvKRKt3Q5NIxSRXhpUyxpZ+N8q8pQjQaIWhzgmv8S5/5zwSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bNYc+4F9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QSYKDb138GvI+dxArsFvp9SqY4NfAKhkZ1mgvvFaOHQ=; b=bNYc+4F9oiti9nQQ0HdkVnoDdm
	zO5nQjNhq+oRe52+ZVhWMirI91miX0SMt0Gq36WOAXpTs7+F5BMVPE4EqYsSYvAPANO+5+CwV2PxS
	ZQcH8snzQEMoYokm9YcFaaMzdIAmw2P+u7OBF6GU0m6B0WFM6V48Xxf4J+6MRr/oB77NsvciN9Zt+
	suUbxn5N9JFWBU1x8gGYGxQ433NMS1AJ7Ms1+E58+E2NJTHvxW0uP8Zz0eQIPNz24ftHx4nVFvhlB
	Dr2LD8ubTYCq71PrvBgFbcQV3TMCeUuhUApHdPh4g0ER72SOQVnbNuhQB9o4641mFwfppfJuXRDRQ
	fGQlfElA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZpDa-000000090A1-3zIF;
	Thu, 10 Jul 2025 11:13:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7FB4C300125; Thu, 10 Jul 2025 13:13:34 +0200 (CEST)
Date: Thu, 10 Jul 2025 13:13:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	tanghui20@huawei.com, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com
Subject: Re: [PATCH] sched/fair: Fix overflow in vruntime_eligible() causing
 NULL return
Message-ID: <20250710111334.GD542000@noisy.programming.kicks-ass.net>
References: <20250709093829.3213647-1-quzicheng@huawei.com>
 <20250709115317.GK1613200@noisy.programming.kicks-ass.net>
 <d8588f5d-bccc-4791-9d44-bd3e383d21b9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8588f5d-bccc-4791-9d44-bd3e383d21b9@huawei.com>

On Thu, Jul 10, 2025 at 10:01:15AM +0800, Zicheng Qu wrote:
> Hi,
> 
> Based on LTS 6.6. I also looked at the code logic around vruntime_eligible()
> in the mainline. It seems that if vruntime_eligible() consistently returned
> false, this could lead to null pointer dereferences.

That is a truly ancient kernel.  Please verify the issue is reproducible
on something recent.

Specifically, commit bbce3de72be5 ("sched/eevdf: Fix se->slice being set
to U64_MAX and resulting crash") cured something very similar to this.


