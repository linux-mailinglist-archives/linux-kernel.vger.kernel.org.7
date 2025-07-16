Return-Path: <linux-kernel+bounces-733817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D56B07953
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51D03BED75
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EC4287245;
	Wed, 16 Jul 2025 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iIqzgAOE"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB9F275861
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678941; cv=none; b=kA4y+RDoYs3+iHJLQCeqjxoAOdp2Ht4xI4NVxJeDt5wl/+14xj1I9MjKfIB14BttRss4Zk26mPlg2XHam74PHBIwDnLtkbNM2BY4CIiF8Piz4YNxIobydOehaQJEoXwAmhJ9dlgPn+3uSPdXf27Je/Y0/003SAp3HX4OwPiO6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678941; c=relaxed/simple;
	bh=4DXHbEhpjuMfAzG9gOgKocpR2UaCTTeA1QQlxriOGF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhEDZwtUOoOWx667+BvJLKXHgUzAIjYCNtMRsfMk1Gum8AQh17P5EPTwzZZtmmWhyOtYqOMgjFT6+yiSGcVzm39EW76L1LwF9XUsv0iqzXPLfIshpcoDL4nm8MRyIowo9CZun0R5re4ADueonJo0Qqd13mox0HkvKgB6UNdB2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iIqzgAOE; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 16 Jul 2025 08:15:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752678936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3uhMti7lQ1cBdCc0rbz33z2vNMq6Y+gg2VrK0WzMZ4=;
	b=iIqzgAOE8NmoLZhs25APPyyG4LCmv5BB4S1rJzit0lJmbJuT2M/Ry9yb7+g5sLx5SWXaKy
	H3QCnB3ZDE+tpN6O9kYw1p7u00dC0p+kk/lRdgo2jxEMHo0hl786yYG1NkYG0TPDOgzSPl
	JQfB92/dajqIhr7myEMgU0mfqBN9ey4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, mhocko@kernel.org, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, yosryahmed@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2 0/4] mm: per-node proactive reclaim
Message-ID: <xessucghl6jdc37qm4d3kneqb3jhfl72izmsqu7giqifog2wvh@zwkk3ift2ccg>
References: <20250623185851.830632-1-dave@stgolabs.net>
 <20250715172410.e22bc8f791325b01b6241d6c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715172410.e22bc8f791325b01b6241d6c@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 15, 2025 at 05:24:10PM -0700, Andrew Morton wrote:
> 
> We're a bit short of reviews of David's series.  Does anyone have
> additional input?
> 

I am on this and will respond within a day or two.

