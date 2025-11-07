Return-Path: <linux-kernel+bounces-890242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FBEC3F96B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A5DA4ECC31
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6111330AABE;
	Fri,  7 Nov 2025 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L6QhbM8T"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BDC3081B5;
	Fri,  7 Nov 2025 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512837; cv=none; b=jSECuPH3x+q+kVpg5XUKQDAQz5ty1c4kiSv3NSsbCNoWeoLfe3mocpxoiCLS2KnR2nGCy7yeBqH9TkjwzrdXLxbRGzRkF7gefjXqSukU7WfTObN2/FenPSaoq1pVIgFs+M52+lbg3T62oKrMVg4fPKjVK2lqYZFnzVdyMJjvaPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512837; c=relaxed/simple;
	bh=7FhOzSROIBAD8OQe3osqtX6VKCcGjmTXe7rBBYWCaCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DozZxFehzdi5j1o9Wg4FvMLwmRiAb2j6EeUB1RhwvzX9JXR/6IRu6C35ZBF8tW49qfmclcrb5D1/6cqDsMjso+w27+MTibaGevogBiw7FwDpFKMU5Cm9DKKDX4iAJChQDbQIJ3vAs3itKEiIaICQRUJ0on/otAnp/XeD4T50K+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L6QhbM8T; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7FhOzSROIBAD8OQe3osqtX6VKCcGjmTXe7rBBYWCaCw=; b=L6QhbM8T0TCEKraCG4DMEQRUGv
	IELBE2StJcqvAPrKd0DWrDHtocILUZbCkpIEsak5LTSQxJ6ubf45T7PMZWataaxQZ0F207tSgGB2e
	py21YwgjiRaJxjI8Tl7CdsLrEoO6nrhmqnn7LVcKIfRoPkGxGPKFozSOtFpe5owesCnVBcPVhpkiZ
	FPgd+/fLAdR+kwRGqOj73aWZ5WfdVb/u+Ezl6EaPH0ZXMNY5sUn8VXGzRvkJqZYZMGpnL+/T5peqc
	ht8+1tX1OkUIAVVG7SH+IdjgmnVOuqraRSCkBbhCUjB/6mWpsxnj3LkfSGqL73FE+KNfeR6vHkak9
	T2l2+SHA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHJEb-00000006Ec2-1PaE;
	Fri, 07 Nov 2025 09:58:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4D0203001D4; Fri, 07 Nov 2025 11:53:49 +0100 (CET)
Date: Fri, 7 Nov 2025 11:53:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Philip Li <philip.li@intel.com>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>,
	kernel test robot <oliver.sang@intel.com>,
	Fernand Sieber <sieberf@amazon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	aubrey.li@linux.intel.com
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20251107105349.GD1618871@noisy.programming.kicks-ass.net>
References: <20251021110449.GO3245006@noisy.programming.kicks-ass.net>
 <20251027125453.GY4067720@noisy.programming.kicks-ass.net>
 <3b30e40b-f1fb-4145-b4d9-a9279b9602d8@intel.com>
 <20251027135516.GA3419281@noisy.programming.kicks-ass.net>
 <20251027140718.GT1386988@noisy.programming.kicks-ass.net>
 <20251027140959.GU1386988@noisy.programming.kicks-ass.net>
 <e9f705f3-3a8f-4952-b5d5-e36f4fa1515d@intel.com>
 <20251105110026.GI988547@noisy.programming.kicks-ass.net>
 <aQs9yFQloF9aFCbA@rli9-mobl>
 <aQ3G44fqJG378pM1@rli9-mobl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ3G44fqJG378pM1@rli9-mobl>

On Fri, Nov 07, 2025 at 06:16:03PM +0800, Philip Li wrote:

> Sorry for wrong reproduce steps, we should be more careful to make it consistent.

No worries, shit happens. Thanks for getting it fixed!

