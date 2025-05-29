Return-Path: <linux-kernel+bounces-667272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12629AC8277
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 21:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A531C026AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8935E230BE6;
	Thu, 29 May 2025 19:08:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2919C647;
	Thu, 29 May 2025 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748545698; cv=none; b=F72cEw/LH66lRpHiw1J8l3t7SltfG53NgAZw32gHyxl09YmUVh6AHf0/4Jq6WLMBPtLRyG9mAl7qev1waJ88y/yc1yK8EZXa/i46QWQMGtBfaAjfhmkysq9cC9h/7ISa75+0dz59dDCfVTC9iJfqoMse7cep99xlktqFtKr/B+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748545698; c=relaxed/simple;
	bh=qcOOepLFiW3KMiqf69+JcPAr2fkqWv4ElDERZ+uCASw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUq7m3N/Cg8XS0juYhYmg92W5NQPjJPAavCuWM5qn/jzsfQ6TFUxamypJa2jUJgN15Yje26n6mJE/RSzwMjwfRQYoRDgl24rojr7uDZBllxuPF9RumFZHfItNO19GA5d2OjgX98pyJvwsYBSOYS7rD/rq82EMD4EPs1o4NciVfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992FAC4CEE7;
	Thu, 29 May 2025 19:08:15 +0000 (UTC)
Date: Thu, 29 May 2025 15:09:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, nvdimm@lists.linux.dev
Cc: Dan Williams <dan.j.williams@intel.com>, Shiyang Ruan
 <ruansy.fnst@fujitsu.com>, "Darrick J. Wong" <djwong@kernel.org>, Ross
 Zwisler <zwisler@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fsdax: Remove unused trace event dax_pmd_insert_mapping
Message-ID: <20250529150918.7c740902@gandalf.local.home>
In-Reply-To: <20250529150722.19e04332@gandalf.local.home>
References: <20250529150722.19e04332@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 15:07:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> When the dax_fault_actor() helper was factored out, it removed the calls
> to the dax_pmd_insert_mapping event but never removed the event itself. As
> events created do take up memory (roughly 5K), this is a waste as it is
> never used.
> 
> Remove the unused dax_pmd_insert_mapping trace event.

Bah, I just noticed that the call to the dax_insert_mapping event was also
removed without removing the event. Let me remove that too and fold it into
this patch.

I'll send a v2.

-- Steve

