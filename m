Return-Path: <linux-kernel+bounces-752329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330C3B17422
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D773AF1B5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6481EEA47;
	Thu, 31 Jul 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EQ9RhTUE"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFBD141987
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976973; cv=none; b=gGoz4t/bCTbvWBlSBFo4llzhdasoISvGrFZheaHQSnqHiPYKhjIQGqPcHtqNkqBP0xqRiWkZUlV5gje0t+Q+5WG4E5Mx8Ck7JMCl3NLQQijd+/S2bGG+f7WPrQL/GCn+bw5s74Ysxd9L4zPvmM1m3aXfSkXfYq1gF5lERw/4HnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976973; c=relaxed/simple;
	bh=ty2HCoqYjlov1COEQq5EkrPwmHuATgl+GyX7EzEJfW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYi/SsfphqAYqfkhY19zt9SNe7EwEaQpc5i9srT+LPyOQ0EETGVZKArmU09GA33K6arYX9FZY6H2UeU7h293jy3cxJmDd+S0430bMxUk7cQCeF5Pi09PpcAXyXi/aiANyTptekliOm9CTcAxeW0KaTPwFFHy0CdlzTDT6iQfr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EQ9RhTUE; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 31 Jul 2025 11:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753976959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ty2HCoqYjlov1COEQq5EkrPwmHuATgl+GyX7EzEJfW4=;
	b=EQ9RhTUExy+IvZf/bcHVwlpZcpugDpXvIrR2tAc0Gr4vh2GjG3eVQKAteyJ66eJFrrn4Zb
	jLJl3ZaYT6JYc5CsOZvktxCTXqVh2MlnrXRbWg6I6pmnkway7yarjvl6rp+s1hinM2b/E4
	5oklP1Qi4TZcqyEzmdGVl/EDNKREcwM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
Cc: colyli@kernel.org, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcache: enhancing the security of dirty data writeback
Message-ID: <etlu4r6gxbe2jc3eemj3n4slg6xraxtxxydvxvmhv77xv42uss@7aw3yxbdgrdl>
References: <20250731062140.25734-1-zhoujifeng@kylinos.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731062140.25734-1-zhoujifeng@kylinos.com.cn>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 31, 2025 at 02:21:40PM +0800, Zhou Jifeng wrote:
> There is a potential data consistency risk in bcache's writeback mode:when
> the application calls fsync, bcache returns success after completing the
> log write, persisting the cache disk data, and persisting the HDD internal
> cache. However, at this point, the actual application data may still be in
> a dirty state and remain stuck in the cache disk. when these data are
> subsequently written back to the HDD asynchronously through REQ_OP_WRITE,
> there is no forced refresh mechanism to ensure physical placement on the
> disk, and there may be no power-off protection measures, which poses a risk
> of data loss. This mechanism may cause the application to misjudge that the
> data has been persisted, which is different from the actual storage state,
> and also violates the semantic agreement that fsync should ensure data
> persistence.

So, the way you start out describing the patch, it sounds like you're
addressing some sort of bug in REQ_OP_FLUSH handling, but it looks like
what you're actually doing is adding a mode where flushes also flush
bcache?

This doesn't sound like a bugfix, this sounds like a completely new
mode - we'd need an explanation of the use case you're aiming for.

The model for bcache has always been that since the cache is persistent,
when you're in writeback mode there are no fsync/REQ_OP_FLUSH
considerations for dirty data; once we've properly persisted (and
flushed) that data we're good.

If you want a mode where you can run in writeback mode, but obey flushes
so that it's still safe to lose or yank the cache device - is that what
you're after?

