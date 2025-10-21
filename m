Return-Path: <linux-kernel+bounces-863486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EA6BF7F26
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD1D44E8F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6CE34D4E2;
	Tue, 21 Oct 2025 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="OsAVFdj1"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D55B34D4D6
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068654; cv=none; b=kdeP09WDPRHn/94vk/bYKsN3cYYkrCGAsLgZXYkuHmlMKa1mKtt12ZSnYWtdr8nxDN0zrO8FfpQ0WZtddVabVMOnttQ/IhqxP6HbwxJ3lG0KKmqxHujJifwmgMQ5xRPArh+MgqO0TQKMHgi/SskOLeuAGjvUDFcfcx/MpkQg4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068654; c=relaxed/simple;
	bh=K7a4l8JVBnnCMLYmHwA7OCtZe1J5ujlEJyq1JqWJvBo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZcE86TJrm155jnf8aG4trM6MPm05uYeLaOg29IXA8Nj9BtX6SSd8tFQUrbFgehZPkDdX8FjvASqb3xV2CbHV8nT/YhlLlAg9UAAustz/iEekDfzG7uZKzGBzlOWeP6lIMyvHFOXy2kT+16QSwOMsxrNXOsjTT7NQF/iw5fhuOy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=OsAVFdj1; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1761068652;
	bh=K7a4l8JVBnnCMLYmHwA7OCtZe1J5ujlEJyq1JqWJvBo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OsAVFdj1XnkmCtKV21bPHIYYTMEENYG738Q2lQCRjFy7xneyA030IigcR1yeNsUF5
	 ircnfogyilwyd4P8Jxvwzk+cH+2M19cJlo+om3JiOblX5uV51rum2FYbQzUmJg1k7m
	 PMC3DgUhg6yD9dvyeaOMTaOeNgnxXlyvnh7x8r0U=
Received: by gentwo.org (Postfix, from userid 1003)
	id A7F854028E; Tue, 21 Oct 2025 10:44:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id A71804015D;
	Tue, 21 Oct 2025 10:44:12 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:44:12 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: William Kucharski <william.kucharski@oracle.com>
cc: Vlastimil Babka <vbabka@suse.cz>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    David Rientjes <rientjes@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Harry Yoo <harry.yoo@oracle.com>, Paul Mundt <lethal@linux-sh.org>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove reference to destructor in comment in
 calculate_sizes()
In-Reply-To: <20251021110004.2209008-1-william.kucharski@oracle.com>
Message-ID: <679a717d-b434-9a2f-1d59-fb17b343bc30@gentwo.org>
References: <20251021110004.2209008-1-william.kucharski@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Tue, 21 Oct 2025, William Kucharski wrote:

> The commit that removed support for destructors from kmem_cache_alloc()
> never removed the comment regarding destructors in the explanation
> of the possible relocation of the free pointer in calculate_sizes().

Must have missed it about 2 decades ago.

Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>

